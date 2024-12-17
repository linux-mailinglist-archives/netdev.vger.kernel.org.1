Return-Path: <netdev+bounces-152742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B149F5A26
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AA8189325A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 23:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264571E3DF7;
	Tue, 17 Dec 2024 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dE6sK5EB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D61F8ACD
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476887; cv=none; b=bcNNotBxgabRWHphVTop5CzAusSBJvfDTqXyYoZVaae7arB+xbA5Uea8AdLfQGsyRcS2TOXWOl3EY+DR/xXlb3Wk17cjlQiZw4lTnfvyrhQBPaWqCIBCXxmLe4Y9fBWEvx1TZeCdcl86sZ/6fNvDNxxfKgZ13B5fJqFy0mnw08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476887; c=relaxed/simple;
	bh=9xOKQ0MIcKagfuMEV96al33FnDItvCRepMfijnB7I64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPUs0TcOCD82xHTabDBgppPhGNE5FQfjJQbTWqiZmh8gtIc8KxqT1BDV8SLngYVXiFdPLRzlvH+r8VeI5VW3w/RmEab9Rqc0999/la3XRhbQy/bFyp+dStW3yOA+IbtSseM6kY4tsG/QoH89Pz4TC2WFQ69+/1LSvpkR8C6UVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dE6sK5EB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734476883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EV2rpHIogclq1YlArgsEVcIhxvrlIiemvBU7IzhZvTA=;
	b=dE6sK5EB5X1J9OrgmtFbhiC/20R2JzUi3X//5NpxpDy3yM7Td0Y9ZrWRRZ0Hk1vVpxJyvj
	I0tHHuqo4ELrU+qfb1dc2qjZ+cOyPVw9xej3XmOWg60fpp0vgZO6smTpafsPsjJMK8mUJ1
	Wax12FVkIqGVUYOQEFFgnPCz+42Asd8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-DnC8P7e9NUGu0iHgvdXk6A-1; Tue,
 17 Dec 2024 18:08:00 -0500
X-MC-Unique: DnC8P7e9NUGu0iHgvdXk6A-1
X-Mimecast-MFC-AGG-ID: DnC8P7e9NUGu0iHgvdXk6A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 281421956089;
	Tue, 17 Dec 2024 23:07:58 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.88.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1933A195394B;
	Tue, 17 Dec 2024 23:07:55 +0000 (UTC)
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
Subject: [PATCH net-next v2 2/2] net: bridge: add skb drop reasons to the most common drop points
Date: Tue, 17 Dec 2024 18:07:11 -0500
Message-ID: <20241217230711.192781-3-rrendec@redhat.com>
In-Reply-To: <20241217230711.192781-1-rrendec@redhat.com>
References: <20241217230711.192781-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
 net/bridge/br_input.c         | 24 +++++++++++++++---------
 3 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index be58c97c64a1b..eeb7c67586431 100644
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
+	 * @SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD: the STP state of the
+	 * ingress bridge port does not allow frames to be forwarded.
+	 */
+	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index e19b583ff2c6d..3e9b462809b0e 100644
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
+			WARN_ON_ONCE(PTR_ERR(prev) != -ENOMEM);
+			reason = SKB_DROP_REASON_NOMEM;
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
+			WARN_ON_ONCE(PTR_ERR(prev) != -ENOMEM);
+			reason = SKB_DROP_REASON_NOMEM;
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
index ceaa5a89b947f..0adad3986c77d 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -96,8 +96,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (br_mst_is_enabled(br)) {
 		state = BR_STATE_FORWARDING;
 	} else {
-		if (p->state == BR_STATE_DISABLED)
-			goto drop;
+		if (p->state == BR_STATE_DISABLED) {
+			kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE);
+			return 0;
+		}
 
 		state = p->state;
 	}
@@ -155,8 +157,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		}
 	}
 
-	if (state == BR_STATE_LEARNING)
-		goto drop;
+	if (state == BR_STATE_LEARNING) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE);
+		return 0;
+	}
 
 	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
 	BR_INPUT_SKB_CB(skb)->src_port_isolated = !!(p->flags & BR_ISOLATED);
@@ -331,8 +335,10 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
 		return RX_HANDLER_PASS;
 
-	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
-		goto drop;
+	if (!is_valid_ether_addr(eth_hdr(skb)->h_source)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_MAC_INVALID_SOURCE);
+		return RX_HANDLER_CONSUMED;
+	}
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
@@ -374,7 +380,8 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 			return RX_HANDLER_PASS;
 
 		case 0x01:	/* IEEE MAC (Pause) */
-			goto drop;
+			kfree_skb_reason(skb, SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL);
+			return RX_HANDLER_CONSUMED;
 
 		case 0x0E:	/* 802.1AB LLDP */
 			fwd_mask |= p->br->group_fwd_mask;
@@ -423,8 +430,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 
 		return nf_hook_bridge_pre(skb, pskb);
 	default:
-drop:
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE);
 	}
 	return RX_HANDLER_CONSUMED;
 }
-- 
2.47.1


