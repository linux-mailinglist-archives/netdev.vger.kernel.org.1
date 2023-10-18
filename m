Return-Path: <netdev+bounces-42160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFAF7CD700
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E15281CE4
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D37156E9;
	Wed, 18 Oct 2023 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF41641E
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:51:41 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA75C9D;
	Wed, 18 Oct 2023 01:51:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qt2H9-0006Kf-6I; Wed, 18 Oct 2023 10:51:35 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 3/7] netfilter: conntrack: convert nf_conntrack_update to netfilter verdicts
Date: Wed, 18 Oct 2023 10:51:07 +0200
Message-ID: <20231018085118.10829-4-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018085118.10829-1-fw@strlen.de>
References: <20231018085118.10829-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This function calls helpers that can return nf-verdicts, but then
those get converted to -1/0 as thats what the caller expects.

Theoretically NF_DROP could have an errno number set in the upper 24
bits of the return value. Or any of those helpers could return
NF_STOLEN, which would result in use-after-free.

This is fine as-is, the called functions don't do this yet.

But its better to avoid possible future problems if the upcoming
patchset to add NF_DROP_REASON() support gains further users, so remove
the 0/-1 translation from the picture and pass the verdicts down to
the caller.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_core.c | 58 ++++++++++++++++++-------------
 net/netfilter/nfnetlink_queue.c   | 15 ++++----
 2 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 124136b5a79a..2e5f3864d353 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2169,11 +2169,11 @@ static int __nf_conntrack_update(struct net *net, struct sk_buff *skb,
 
 	dataoff = get_l4proto(skb, skb_network_offset(skb), l3num, &l4num);
 	if (dataoff <= 0)
-		return -1;
+		return NF_DROP;
 
 	if (!nf_ct_get_tuple(skb, skb_network_offset(skb), dataoff, l3num,
 			     l4num, net, &tuple))
-		return -1;
+		return NF_DROP;
 
 	if (ct->status & IPS_SRC_NAT) {
 		memcpy(tuple.src.u3.all,
@@ -2193,7 +2193,7 @@ static int __nf_conntrack_update(struct net *net, struct sk_buff *skb,
 
 	h = nf_conntrack_find_get(net, nf_ct_zone(ct), &tuple);
 	if (!h)
-		return 0;
+		return NF_ACCEPT;
 
 	/* Store status bits of the conntrack that is clashing to re-do NAT
 	 * mangling according to what it has been done already to this packet.
@@ -2206,19 +2206,25 @@ static int __nf_conntrack_update(struct net *net, struct sk_buff *skb,
 
 	nat_hook = rcu_dereference(nf_nat_hook);
 	if (!nat_hook)
-		return 0;
+		return NF_ACCEPT;
 
-	if (status & IPS_SRC_NAT &&
-	    nat_hook->manip_pkt(skb, ct, NF_NAT_MANIP_SRC,
-				IP_CT_DIR_ORIGINAL) == NF_DROP)
-		return -1;
+	if (status & IPS_SRC_NAT) {
+		unsigned int verdict = nat_hook->manip_pkt(skb, ct,
+							   NF_NAT_MANIP_SRC,
+							   IP_CT_DIR_ORIGINAL);
+		if (verdict != NF_ACCEPT)
+			return verdict;
+	}
 
-	if (status & IPS_DST_NAT &&
-	    nat_hook->manip_pkt(skb, ct, NF_NAT_MANIP_DST,
-				IP_CT_DIR_ORIGINAL) == NF_DROP)
-		return -1;
+	if (status & IPS_DST_NAT) {
+		unsigned int verdict = nat_hook->manip_pkt(skb, ct,
+							   NF_NAT_MANIP_DST,
+							   IP_CT_DIR_ORIGINAL);
+		if (verdict != NF_ACCEPT)
+			return verdict;
+	}
 
-	return 0;
+	return NF_ACCEPT;
 }
 
 /* This packet is coming from userspace via nf_queue, complete the packet
@@ -2233,14 +2239,14 @@ static int nf_confirm_cthelper(struct sk_buff *skb, struct nf_conn *ct,
 
 	help = nfct_help(ct);
 	if (!help)
-		return 0;
+		return NF_ACCEPT;
 
 	helper = rcu_dereference(help->helper);
 	if (!helper)
-		return 0;
+		return NF_ACCEPT;
 
 	if (!(helper->flags & NF_CT_HELPER_F_USERSPACE))
-		return 0;
+		return NF_ACCEPT;
 
 	switch (nf_ct_l3num(ct)) {
 	case NFPROTO_IPV4:
@@ -2255,42 +2261,44 @@ static int nf_confirm_cthelper(struct sk_buff *skb, struct nf_conn *ct,
 		protoff = ipv6_skip_exthdr(skb, sizeof(struct ipv6hdr), &pnum,
 					   &frag_off);
 		if (protoff < 0 || (frag_off & htons(~0x7)) != 0)
-			return 0;
+			return NF_ACCEPT;
 		break;
 	}
 #endif
 	default:
-		return 0;
+		return NF_ACCEPT;
 	}
 
 	if (test_bit(IPS_SEQ_ADJUST_BIT, &ct->status) &&
 	    !nf_is_loopback_packet(skb)) {
 		if (!nf_ct_seq_adjust(skb, ct, ctinfo, protoff)) {
 			NF_CT_STAT_INC_ATOMIC(nf_ct_net(ct), drop);
-			return -1;
+			return NF_DROP;
 		}
 	}
 
 	/* We've seen it coming out the other side: confirm it */
-	return nf_conntrack_confirm(skb) == NF_DROP ? - 1 : 0;
+	return nf_conntrack_confirm(skb);
 }
 
 static int nf_conntrack_update(struct net *net, struct sk_buff *skb)
 {
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct;
-	int err;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if (!ct)
-		return 0;
+		return NF_ACCEPT;
 
 	if (!nf_ct_is_confirmed(ct)) {
-		err = __nf_conntrack_update(net, skb, ct, ctinfo);
-		if (err < 0)
-			return err;
+		int ret = __nf_conntrack_update(net, skb, ct, ctinfo);
+
+		if (ret != NF_ACCEPT)
+			return ret;
 
 		ct = nf_ct_get(skb, &ctinfo);
+		if (!ct)
+			return NF_ACCEPT;
 	}
 
 	return nf_confirm_cthelper(skb, ct, ctinfo);
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 556bc902af00..171d1f52d3dd 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -228,19 +228,22 @@ find_dequeue_entry(struct nfqnl_instance *queue, unsigned int id)
 static void nfqnl_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 {
 	const struct nf_ct_hook *ct_hook;
-	int err;
 
 	if (verdict == NF_ACCEPT ||
 	    verdict == NF_REPEAT ||
 	    verdict == NF_STOP) {
 		rcu_read_lock();
 		ct_hook = rcu_dereference(nf_ct_hook);
-		if (ct_hook) {
-			err = ct_hook->update(entry->state.net, entry->skb);
-			if (err < 0)
-				verdict = NF_DROP;
-		}
+		if (ct_hook)
+			verdict = ct_hook->update(entry->state.net, entry->skb);
 		rcu_read_unlock();
+
+		switch (verdict & NF_VERDICT_MASK) {
+		case NF_STOLEN:
+			nf_queue_entry_free(entry);
+			return;
+		}
+
 	}
 	nf_reinject(entry, verdict);
 }
-- 
2.41.0


