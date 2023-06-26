Return-Path: <netdev+bounces-13869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6995473D7F9
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 08:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2711F280DC1
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 06:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C0E4C7F;
	Mon, 26 Jun 2023 06:48:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF15D4C7C
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 06:48:00 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 822CF180;
	Sun, 25 Jun 2023 23:47:59 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net-next 6/8] netfilter: snat: evict closing tcp entries on reply tuple collision
Date: Mon, 26 Jun 2023 08:47:47 +0200
Message-Id: <20230626064749.75525-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230626064749.75525-1-pablo@netfilter.org>
References: <20230626064749.75525-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Florian Westphal <fw@strlen.de>

When all tried source tuples are in use, the connection request (skb)
and the new conntrack will be dropped in nf_confirm() due to the
non-recoverable clash.

Make it so that the last 32 attempts are allowed to evict a colliding
entry if this connection is already closing and the new sequence number
has advanced past the old one.

Such "all tuples taken" secenario can happen with tcp-rpc workloads where
same dst:dport gets queried repeatedly.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_nat_core.c | 92 +++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index ce829d434f13..fadbd4ed3dc0 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -27,6 +27,9 @@
 
 #include "nf_internals.h"
 
+#define NF_NAT_MAX_ATTEMPTS	128
+#define NF_NAT_HARDER_THRESH	(NF_NAT_MAX_ATTEMPTS / 4)
+
 static spinlock_t nf_nat_locks[CONNTRACK_LOCKS];
 
 static DEFINE_MUTEX(nf_nat_proto_mutex);
@@ -197,6 +200,88 @@ nf_nat_used_tuple(const struct nf_conntrack_tuple *tuple,
 	return nf_conntrack_tuple_taken(&reply, ignored_conntrack);
 }
 
+static bool nf_nat_may_kill(struct nf_conn *ct, unsigned long flags)
+{
+	static const unsigned long flags_refuse = IPS_FIXED_TIMEOUT |
+						  IPS_DYING;
+	static const unsigned long flags_needed = IPS_SRC_NAT;
+	enum tcp_conntrack old_state;
+
+	old_state = READ_ONCE(ct->proto.tcp.state);
+	if (old_state < TCP_CONNTRACK_TIME_WAIT)
+		return false;
+
+	if (flags & flags_refuse)
+		return false;
+
+	return (flags & flags_needed) == flags_needed;
+}
+
+/* reverse direction will send packets to new source, so
+ * make sure such packets are invalid.
+ */
+static bool nf_seq_has_advanced(const struct nf_conn *old, const struct nf_conn *new)
+{
+	return (__s32)(new->proto.tcp.seen[0].td_end -
+		       old->proto.tcp.seen[0].td_end) > 0;
+}
+
+static int
+nf_nat_used_tuple_harder(const struct nf_conntrack_tuple *tuple,
+			 const struct nf_conn *ignored_conntrack,
+			 unsigned int attempts_left)
+{
+	static const unsigned long flags_offload = IPS_OFFLOAD | IPS_HW_OFFLOAD;
+	struct nf_conntrack_tuple_hash *thash;
+	const struct nf_conntrack_zone *zone;
+	struct nf_conntrack_tuple reply;
+	unsigned long flags;
+	struct nf_conn *ct;
+	bool taken = true;
+	struct net *net;
+
+	nf_ct_invert_tuple(&reply, tuple);
+
+	if (attempts_left > NF_NAT_HARDER_THRESH ||
+	    tuple->dst.protonum != IPPROTO_TCP ||
+	    ignored_conntrack->proto.tcp.state != TCP_CONNTRACK_SYN_SENT)
+		return nf_conntrack_tuple_taken(&reply, ignored_conntrack);
+
+	/* :ast few attempts to find a free tcp port. Destructive
+	 * action: evict colliding if its in timewait state and the
+	 * tcp sequence number has advanced past the one used by the
+	 * old entry.
+	 */
+	net = nf_ct_net(ignored_conntrack);
+	zone = nf_ct_zone(ignored_conntrack);
+
+	thash = nf_conntrack_find_get(net, zone, &reply);
+	if (!thash)
+		return false;
+
+	ct = nf_ct_tuplehash_to_ctrack(thash);
+
+	if (thash->tuple.dst.dir == IP_CT_DIR_ORIGINAL)
+		goto out;
+
+	if (WARN_ON_ONCE(ct == ignored_conntrack))
+		goto out;
+
+	flags = READ_ONCE(ct->status);
+	if (!nf_nat_may_kill(ct, flags))
+		goto out;
+
+	if (!nf_seq_has_advanced(ct, ignored_conntrack))
+		goto out;
+
+	/* Even if we can evict do not reuse if entry is offloaded. */
+	if (nf_ct_kill(ct))
+		taken = flags & flags_offload;
+out:
+	nf_ct_put(ct);
+	return taken;
+}
+
 static bool nf_nat_inet_in_range(const struct nf_conntrack_tuple *t,
 				 const struct nf_nat_range2 *range)
 {
@@ -385,7 +470,6 @@ static void nf_nat_l4proto_unique_tuple(struct nf_conntrack_tuple *tuple,
 	unsigned int range_size, min, max, i, attempts;
 	__be16 *keyptr;
 	u16 off;
-	static const unsigned int max_attempts = 128;
 
 	switch (tuple->dst.protonum) {
 	case IPPROTO_ICMP:
@@ -471,8 +555,8 @@ static void nf_nat_l4proto_unique_tuple(struct nf_conntrack_tuple *tuple,
 		off = get_random_u16();
 
 	attempts = range_size;
-	if (attempts > max_attempts)
-		attempts = max_attempts;
+	if (attempts > NF_NAT_MAX_ATTEMPTS)
+		attempts = NF_NAT_MAX_ATTEMPTS;
 
 	/* We are in softirq; doing a search of the entire range risks
 	 * soft lockup when all tuples are already used.
@@ -483,7 +567,7 @@ static void nf_nat_l4proto_unique_tuple(struct nf_conntrack_tuple *tuple,
 another_round:
 	for (i = 0; i < attempts; i++, off++) {
 		*keyptr = htons(min + off % range_size);
-		if (!nf_nat_used_tuple(tuple, ct))
+		if (!nf_nat_used_tuple_harder(tuple, ct, attempts - i))
 			return;
 	}
 
-- 
2.30.2


