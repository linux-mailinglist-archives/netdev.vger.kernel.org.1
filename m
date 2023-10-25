Return-Path: <netdev+bounces-44277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EB77D76C3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3283281DC5
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBBD374D8;
	Wed, 25 Oct 2023 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA8347DC
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:26:10 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99446193;
	Wed, 25 Oct 2023 14:26:06 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 06/19] br_netfilter: use single forward hook for ip and arp
Date: Wed, 25 Oct 2023 23:25:42 +0200
Message-Id: <20231025212555.132775-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025212555.132775-1-pablo@netfilter.org>
References: <20231025212555.132775-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

br_netfilter registers two forward hooks, one for ip and one for arp.

Just use a common function for both and then call the arp/ip helper
as needed.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/bridge/br_netfilter_hooks.c | 72 ++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 4c0c9f838f5c..6adcb45bca75 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -570,18 +570,12 @@ static int br_nf_forward_finish(struct net *net, struct sock *sk, struct sk_buff
 }
 
 
-/* This is the 'purely bridged' case.  For IP, we pass the packet to
- * netfilter with indev and outdev set to the bridge device,
- * but we are still able to filter on the 'real' indev/outdev
- * because of the physdev module. For ARP, indev and outdev are the
- * bridge ports. */
-static unsigned int br_nf_forward_ip(void *priv,
-				     struct sk_buff *skb,
-				     const struct nf_hook_state *state)
+static unsigned int br_nf_forward_ip(struct sk_buff *skb,
+				     const struct nf_hook_state *state,
+				     u8 pf)
 {
 	struct nf_bridge_info *nf_bridge;
 	struct net_device *parent;
-	u_int8_t pf;
 
 	nf_bridge = nf_bridge_info_get(skb);
 	if (!nf_bridge)
@@ -600,15 +594,6 @@ static unsigned int br_nf_forward_ip(void *priv,
 	if (!parent)
 		return NF_DROP_REASON(skb, SKB_DROP_REASON_DEV_READY, 0);
 
-	if (IS_IP(skb) || is_vlan_ip(skb, state->net) ||
-	    is_pppoe_ip(skb, state->net))
-		pf = NFPROTO_IPV4;
-	else if (IS_IPV6(skb) || is_vlan_ipv6(skb, state->net) ||
-		 is_pppoe_ipv6(skb, state->net))
-		pf = NFPROTO_IPV6;
-	else
-		return NF_ACCEPT;
-
 	nf_bridge_pull_encap_header(skb);
 
 	if (skb->pkt_type == PACKET_OTHERHOST) {
@@ -620,19 +605,18 @@ static unsigned int br_nf_forward_ip(void *priv,
 		if (br_validate_ipv4(state->net, skb))
 			return NF_DROP_REASON(skb, SKB_DROP_REASON_IP_INHDR, 0);
 		IPCB(skb)->frag_max_size = nf_bridge->frag_max_size;
-	}
-
-	if (pf == NFPROTO_IPV6) {
+		skb->protocol = htons(ETH_P_IP);
+	} else if (pf == NFPROTO_IPV6) {
 		if (br_validate_ipv6(state->net, skb))
 			return NF_DROP_REASON(skb, SKB_DROP_REASON_IP_INHDR, 0);
 		IP6CB(skb)->frag_max_size = nf_bridge->frag_max_size;
+		skb->protocol = htons(ETH_P_IPV6);
+	} else {
+		WARN_ON_ONCE(1);
+		return NF_DROP;
 	}
 
 	nf_bridge->physoutdev = skb->dev;
-	if (pf == NFPROTO_IPV4)
-		skb->protocol = htons(ETH_P_IP);
-	else
-		skb->protocol = htons(ETH_P_IPV6);
 
 	NF_HOOK(pf, NF_INET_FORWARD, state->net, NULL, skb,
 		brnf_get_logical_dev(skb, state->in, state->net),
@@ -641,8 +625,7 @@ static unsigned int br_nf_forward_ip(void *priv,
 	return NF_STOLEN;
 }
 
-static unsigned int br_nf_forward_arp(void *priv,
-				      struct sk_buff *skb,
+static unsigned int br_nf_forward_arp(struct sk_buff *skb,
 				      const struct nf_hook_state *state)
 {
 	struct net_bridge_port *p;
@@ -659,11 +642,8 @@ static unsigned int br_nf_forward_arp(void *priv,
 	if (!brnet->call_arptables && !br_opt_get(br, BROPT_NF_CALL_ARPTABLES))
 		return NF_ACCEPT;
 
-	if (!IS_ARP(skb)) {
-		if (!is_vlan_arp(skb, state->net))
-			return NF_ACCEPT;
+	if (is_vlan_arp(skb, state->net))
 		nf_bridge_pull_encap_header(skb);
-	}
 
 	if (unlikely(!pskb_may_pull(skb, sizeof(struct arphdr))))
 		return NF_DROP_REASON(skb, SKB_DROP_REASON_PKT_TOO_SMALL, 0);
@@ -680,6 +660,28 @@ static unsigned int br_nf_forward_arp(void *priv,
 	return NF_STOLEN;
 }
 
+/* This is the 'purely bridged' case.  For IP, we pass the packet to
+ * netfilter with indev and outdev set to the bridge device,
+ * but we are still able to filter on the 'real' indev/outdev
+ * because of the physdev module. For ARP, indev and outdev are the
+ * bridge ports.
+ */
+static unsigned int br_nf_forward(void *priv,
+				  struct sk_buff *skb,
+				  const struct nf_hook_state *state)
+{
+	if (IS_IP(skb) || is_vlan_ip(skb, state->net) ||
+	    is_pppoe_ip(skb, state->net))
+		return br_nf_forward_ip(skb, state, NFPROTO_IPV4);
+	if (IS_IPV6(skb) || is_vlan_ipv6(skb, state->net) ||
+	    is_pppoe_ipv6(skb, state->net))
+		return br_nf_forward_ip(skb, state, NFPROTO_IPV6);
+	if (IS_ARP(skb) || is_vlan_arp(skb, state->net))
+		return br_nf_forward_arp(skb, state);
+
+	return NF_ACCEPT;
+}
+
 static int br_nf_push_frag_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct brnf_frag_data *data;
@@ -937,13 +939,7 @@ static const struct nf_hook_ops br_nf_ops[] = {
 		.priority = NF_BR_PRI_BRNF,
 	},
 	{
-		.hook = br_nf_forward_ip,
-		.pf = NFPROTO_BRIDGE,
-		.hooknum = NF_BR_FORWARD,
-		.priority = NF_BR_PRI_BRNF - 1,
-	},
-	{
-		.hook = br_nf_forward_arp,
+		.hook = br_nf_forward,
 		.pf = NFPROTO_BRIDGE,
 		.hooknum = NF_BR_FORWARD,
 		.priority = NF_BR_PRI_BRNF,
-- 
2.30.2


