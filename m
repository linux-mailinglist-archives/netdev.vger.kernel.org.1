Return-Path: <netdev+bounces-102045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4369A9013E0
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 00:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 355DDB21326
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 22:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C65383A5;
	Sat,  8 Jun 2024 22:20:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20D1804E
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717885243; cv=none; b=e79psPAc1549VLWblNlIWSdhdwH7V8FV6K71zXneAPMd61TNZmThrA2QZLi1kIKKwHisK0soXNMNPEfONmfda/nwB6uTIGxy5UwQKvepNrwfwEabC+rA6JDhw5PNSfW2JSFBtKYGLFM52R8ChFLX+eQMpndEHVN6gcOtcN0nJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717885243; c=relaxed/simple;
	bh=3er4TrHoYCLWeSryp3q49X1GNhiit4Y72NHd+Uz70yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgrcViJVP7EuBX5L5oFOu5CbCej/ZljBirhsu8t9fs/DG4v8M9xFz718G64HsKtUEUrCYB7NtL3w9g5t+6TYR9lFhKuT2RWOAb8NV+jPYHxojA9y4f9dbWMtmwpActYr9luJ75rtokiItM/eFJpdCpCBWew7wtaHfb2Evm3py8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sG4QQ-0003iZ-AE; Sun, 09 Jun 2024 00:20:38 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	willemb@google.com,
	pablo@netfilter.org,
	Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH net-next v2 1/2] net: add and use skb_get_hash_net
Date: Sun,  9 Jun 2024 00:10:39 +0200
Message-ID: <20240608221057.16070-2-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240608221057.16070-1-fw@strlen.de>
References: <20240608221057.16070-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Years ago flow dissector gained ability to delegate flow dissection
to a bpf program, scoped per netns.

Unfortunately, skb_get_hash() only gets an sk_buff argument instead
of both net+skb.  This means the flow dissector needs to obtain the
netns pointer from somewhere else.

The netns is derived from skb->dev, and if that is not available, from
skb->sk.  If neither is set, we hit a (benign) WARN_ON_ONCE().

Trying both dev and sk covers most cases, but not all, as recently
reported by Christoph Paasch.

In case of nf-generated tcp reset, both sk and dev are NULL:

WARNING: .. net/core/flow_dissector.c:1104
 skb_flow_dissect_flow_keys include/linux/skbuff.h:1536 [inline]
 skb_get_hash include/linux/skbuff.h:1578 [inline]
 nft_trace_init+0x7d/0x120 net/netfilter/nf_tables_trace.c:320
 nft_do_chain+0xb26/0xb90 net/netfilter/nf_tables_core.c:268
 nft_do_chain_ipv4+0x7a/0xa0 net/netfilter/nft_chain_filter.c:23
 nf_hook_slow+0x57/0x160 net/netfilter/core.c:626
 __ip_local_out+0x21d/0x260 net/ipv4/ip_output.c:118
 ip_local_out+0x26/0x1e0 net/ipv4/ip_output.c:127
 nf_send_reset+0x58c/0x700 net/ipv4/netfilter/nf_reject_ipv4.c:308
 nft_reject_ipv4_eval+0x53/0x90 net/ipv4/netfilter/nft_reject_ipv4.c:30
 [..]

syzkaller did something like this:
table inet filter {
  chain input {
    type filter hook input priority filter; policy accept;
    meta nftrace set 1
    tcp dport 42 reject with tcp reset
   }
   chain output {
    type filter hook output priority filter; policy accept;
    # empty chain is enough
   }
}

... then sends a tcp packet to port 42.

Initial attempt to simply set skb->dev from nf_reject_ipv4 doesn't cover
all cases: skbs generated via ipv4 igmp_send_report trigger similar splat.

Moreover, Pablo Neira found that nft_hash.c uses __skb_get_hash_symmetric()
which would trigger same warn splat for such skbs.

Lets allow callers to pass the current netns explicitly.
The nf_trace infrastructure is adjusted to use the new helper.

__skb_get_hash_symmetric is handled in the next patch.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/494
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Changes since v1: add @net to kdoc comment (kbuild robot warning), no
 other changes.

 include/linux/skbuff.h          | 12 ++++++++++--
 net/core/flow_dissector.c       | 15 +++++++++++----
 net/netfilter/nf_tables_trace.c |  2 +-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fe7d8dbef77e..6e78019f899a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1498,7 +1498,7 @@ __skb_set_sw_hash(struct sk_buff *skb, __u32 hash, bool is_l4)
 	__skb_set_hash(skb, hash, true, is_l4);
 }
 
-void __skb_get_hash(struct sk_buff *skb);
+void __skb_get_hash_net(const struct net *net, struct sk_buff *skb);
 u32 __skb_get_hash_symmetric(const struct sk_buff *skb);
 u32 skb_get_poff(const struct sk_buff *skb);
 u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
@@ -1578,10 +1578,18 @@ void skb_flow_dissect_hash(const struct sk_buff *skb,
 			   struct flow_dissector *flow_dissector,
 			   void *target_container);
 
+static inline __u32 skb_get_hash_net(const struct net *net, struct sk_buff *skb)
+{
+	if (!skb->l4_hash && !skb->sw_hash)
+		__skb_get_hash_net(net, skb);
+
+	return skb->hash;
+}
+
 static inline __u32 skb_get_hash(struct sk_buff *skb)
 {
 	if (!skb->l4_hash && !skb->sw_hash)
-		__skb_get_hash(skb);
+		__skb_get_hash_net(NULL, skb);
 
 	return skb->hash;
 }
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 59fe46077b3c..702b4f0a70b6 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1860,7 +1860,8 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric);
 
 /**
- * __skb_get_hash: calculate a flow hash
+ * __skb_get_hash_net: calculate a flow hash
+ * @net: associated network namespace, derived from @skb if NULL
  * @skb: sk_buff to calculate flow hash from
  *
  * This function calculates a flow hash based on src/dst addresses
@@ -1868,18 +1869,24 @@ EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric);
  * on success, zero indicates no valid hash.  Also, sets l4_hash in skb
  * if hash is a canonical 4-tuple hash over transport ports.
  */
-void __skb_get_hash(struct sk_buff *skb)
+void __skb_get_hash_net(const struct net *net, struct sk_buff *skb)
 {
 	struct flow_keys keys;
 	u32 hash;
 
+	memset(&keys, 0, sizeof(keys));
+
+	__skb_flow_dissect(net, skb, &flow_keys_dissector,
+			   &keys, NULL, 0, 0, 0,
+			   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+
 	__flow_hash_secret_init();
 
-	hash = ___skb_get_hash(skb, &keys, &hashrnd);
+	hash = __flow_hash_from_keys(&keys, &hashrnd);
 
 	__skb_set_sw_hash(skb, hash, flow_keys_have_l4(&keys));
 }
-EXPORT_SYMBOL(__skb_get_hash);
+EXPORT_SYMBOL(__skb_get_hash_net);
 
 __u32 skb_get_hash_perturb(const struct sk_buff *skb,
 			   const siphash_key_t *perturb)
diff --git a/net/netfilter/nf_tables_trace.c b/net/netfilter/nf_tables_trace.c
index a83637e3f455..580c55268f65 100644
--- a/net/netfilter/nf_tables_trace.c
+++ b/net/netfilter/nf_tables_trace.c
@@ -317,7 +317,7 @@ void nft_trace_init(struct nft_traceinfo *info, const struct nft_pktinfo *pkt,
 	net_get_random_once(&trace_key, sizeof(trace_key));
 
 	info->skbid = (u32)siphash_3u32(hash32_ptr(skb),
-					skb_get_hash(skb),
+					skb_get_hash_net(nft_net(pkt), skb),
 					skb->skb_iif,
 					&trace_key);
 }
-- 
2.44.2


