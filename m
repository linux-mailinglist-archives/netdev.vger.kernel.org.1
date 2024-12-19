Return-Path: <netdev+bounces-153445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90719F8002
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D991889C10
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCA522652C;
	Thu, 19 Dec 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rwvhl9Tr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B622288CB
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626199; cv=none; b=JhIuETG45aU4LykRpf2dWtLyg3jC6dfLcNC9KcrCaeWqDzx3nayxxKfql+fI9wemNibyq3AcaCVAi0VWNd1XAdd0VxfnbzFc1OU1SuE7dCZsQYNurwzF8El7oSQb/eKcoz6GVOCeBkKqcybPAUEpoaWTQ6u5wMt4LRtMnCoJ5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626199; c=relaxed/simple;
	bh=BHMiRLnr0eBj2HA84QWRvKBp2FfmBeV0kplqwMt34U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INsx4n8MPoXL4PY5tyMUoJEQ7xhhIRJzdaNlZLKRBOF4+HNbXXOdBN2QiJFFYIt3CVBFdgH7rvLVUJAwdgXVigEqrNwT51mnQy/JMZEZrCrX0IMQLP4vzwixMSgUIu5+Ih7tDPfFrWGm4PzMq49C7CzhThweOmLK8sBN39OD7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rwvhl9Tr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734626196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zO4bunjUqueplCUpTWfQRk6/1LAiOsYuAdF+rE7PHYo=;
	b=Rwvhl9TrU/KKXBoGlcQfuBDj9SPvMnsJ0UhFFQHlhxONqB/Y3/EAs/TqAJgOzcLCzxbNfl
	mEnt1Tidf8WfDdShlk2HyaZbf4n3Dhv6vZBeVjpwDPQ+SmO+ldovoCTUZzEvruGpNqn/9m
	50UoVmVLC7ngQ+f1vXNZKe1QhNOCo34=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-BEagXdH9M0GUkHqnJE1Ijw-1; Thu,
 19 Dec 2024 11:36:33 -0500
X-MC-Unique: BEagXdH9M0GUkHqnJE1Ijw-1
X-Mimecast-MFC-AGG-ID: BEagXdH9M0GUkHqnJE1Ijw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B27241956048;
	Thu, 19 Dec 2024 16:36:31 +0000 (UTC)
Received: from thinkpad-p1.localdomain.com (unknown [10.22.81.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 558A519560AD;
	Thu, 19 Dec 2024 16:36:29 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Roopa Prabhu <roopa@nvidia.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net-next v3 2/2] net: bridge: add skb drop reasons to the most common drop points
Date: Thu, 19 Dec 2024 11:36:06 -0500
Message-ID: <20241219163606.717758-3-rrendec@redhat.com>
In-Reply-To: <20241219163606.717758-1-rrendec@redhat.com>
References: <20241219163606.717758-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The bridge input code may drop frames for various reasons and at various
points in the ingress handling logic. Currently kfree_skb() is used
everywhere, and therefore no drop reason is specified. Add drop reasons
to the most common drop points.

Drop reasons are not added exhaustively to the entire bridge code. The
intention is to incrementally add drop reasons to the rest of the bridge
code in follow up patches.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 include/net/dropreason-core.h | 12 ++++++++++++
 net/bridge/br_forward.c       | 16 ++++++++++++----
 net/bridge/br_input.c         | 20 +++++++++++++++-----
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 6e32106d72294..3a6602f379783 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -111,6 +111,8 @@
 	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
 	FN(ARP_PVLAN_DISABLE)		\
+	FN(MAC_IEEE_MAC_CONTROL)	\
+	FN(BRIDGE_INGRESS_STP_STATE)	\
 	FNe(MAX)
 
 /**
@@ -520,6 +522,16 @@ enum skb_drop_reason {
 	 * enabled.
 	 */
 	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
+	/**
+	 * @SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL: the destination MAC address
+	 * is an IEEE MAC Control address.
+	 */
+	SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL,
+	/**
+	 * @SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE: the STP state of the
+	 * ingress bridge port does not allow frames to be forwarded.
+	 */
+	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index e19b583ff2c6d..29097e984b4f7 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -201,6 +201,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
 	      u16 vid)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port *p;
 
@@ -234,8 +235,11 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 			continue;
 
 		prev = maybe_deliver(prev, p, skb, local_orig);
-		if (IS_ERR(prev))
+		if (IS_ERR(prev)) {
+			reason = PTR_ERR(prev) == -ENOMEM ? SKB_DROP_REASON_NOMEM :
+				 SKB_DROP_REASON_NOT_SPECIFIED;
 			goto out;
+		}
 	}
 
 	if (!prev)
@@ -249,7 +253,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 
 out:
 	if (!local_rcv)
-		kfree_skb(skb);
+		kfree_skb_reason(skb, reason);
 }
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
@@ -289,6 +293,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 			struct net_bridge_mcast *brmctx,
 			bool local_rcv, bool local_orig)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port_group *p;
 	bool allow_mode_include = true;
@@ -329,8 +334,11 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 		}
 
 		prev = maybe_deliver(prev, port, skb, local_orig);
-		if (IS_ERR(prev))
+		if (IS_ERR(prev)) {
+			reason = PTR_ERR(prev) == -ENOMEM ? SKB_DROP_REASON_NOMEM :
+				 SKB_DROP_REASON_NOT_SPECIFIED;
 			goto out;
+		}
 delivered:
 		if ((unsigned long)lport >= (unsigned long)port)
 			p = rcu_dereference(p->next);
@@ -349,6 +357,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 
 out:
 	if (!local_rcv)
-		kfree_skb(skb);
+		kfree_skb_reason(skb, reason);
 }
 #endif
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index ceaa5a89b947f..232133a0fd21c 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -75,6 +75,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
 /* note: already called with rcu_read_lock */
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
 	enum br_pkt_type pkt_type = BR_PKT_UNICAST;
 	struct net_bridge_fdb_entry *dst = NULL;
@@ -96,8 +97,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (br_mst_is_enabled(br)) {
 		state = BR_STATE_FORWARDING;
 	} else {
-		if (p->state == BR_STATE_DISABLED)
+		if (p->state == BR_STATE_DISABLED) {
+			reason = SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE;
 			goto drop;
+		}
 
 		state = p->state;
 	}
@@ -155,8 +158,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		}
 	}
 
-	if (state == BR_STATE_LEARNING)
+	if (state == BR_STATE_LEARNING) {
+		reason = SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE;
 		goto drop;
+	}
 
 	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
 	BR_INPUT_SKB_CB(skb)->src_port_isolated = !!(p->flags & BR_ISOLATED);
@@ -223,7 +228,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 out:
 	return 0;
 drop:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	goto out;
 }
 EXPORT_SYMBOL_GPL(br_handle_frame_finish);
@@ -324,6 +329,7 @@ static int br_process_frame_type(struct net_bridge_port *p,
  */
 static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct net_bridge_port *p;
 	struct sk_buff *skb = *pskb;
 	const unsigned char *dest = eth_hdr(skb)->h_dest;
@@ -331,8 +337,10 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
 		return RX_HANDLER_PASS;
 
-	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
+	if (!is_valid_ether_addr(eth_hdr(skb)->h_source)) {
+		reason = SKB_DROP_REASON_MAC_INVALID_SOURCE;
 		goto drop;
+	}
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
@@ -374,6 +382,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 			return RX_HANDLER_PASS;
 
 		case 0x01:	/* IEEE MAC (Pause) */
+			reason = SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL;
 			goto drop;
 
 		case 0x0E:	/* 802.1AB LLDP */
@@ -423,8 +432,9 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 
 		return nf_hook_bridge_pre(skb, pskb);
 	default:
+		reason = SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE;
 drop:
-		kfree_skb(skb);
+		kfree_skb_reason(skb, reason);
 	}
 	return RX_HANDLER_CONSUMED;
 }
-- 
2.47.1


