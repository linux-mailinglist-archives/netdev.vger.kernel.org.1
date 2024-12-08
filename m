Return-Path: <netdev+bounces-150011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E144B9E8834
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 23:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5432802AA
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 22:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D91187862;
	Sun,  8 Dec 2024 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdEsRZs+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99B22C6F7
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733696306; cv=none; b=C9XsH7LoRp6NPNwogM94cj6o7FmHDHb8ur19NLUVKgakb/jETAMIjlfUMDWVTtp3ptR3T2heTyBg67UJFA5zPtupVeahIHhlzguARWgpIi+eSo4oAnEdsfDbIM8iO72hfbeiC2rag4PHU7yyVdiAA2xi59wgWtdkQaUx0DZjYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733696306; c=relaxed/simple;
	bh=OtnibXiAEK+ALgExowwHnYRGud6+QSBAow3rOBEFCKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msfnrg4rgkTBnsxs5c/cr8njSxX/XtAYHHKm4O3y93K7usxOiyZWljWJh7DfKacGk5ma0Wi2Fw+uY1vWuir53h7KtgePDktdVnDyigav9eA4eyq+3ObwfRz3HsvsHq6ft3O4MpH2igdD8FDDAvAcRCLM5e72uk+FWoXF26i3jRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdEsRZs+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733696302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pz1ILyWtLlctRNXA8uJeeSN13RnZuZ4rsM2geX3JWFk=;
	b=PdEsRZs+8vhGddNRO9Y9svb1ynafYe48SoUyg5fHYYk1dqHizBQKpNGyxPRrjd8FKO4tsS
	cKf4ShHAI+AE/Ahvu4WCF8zjhQnRl5SO4ni6kZ1vN05z6SQNUlz6QBP5DQhDXlVbrDLxGn
	d21dlY9sEVRz6MMvTMh5nxDWXHhHqmk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-3QAsa4mGOU-SqNe5ninlGA-1; Sun,
 08 Dec 2024 17:18:18 -0500
X-MC-Unique: 3QAsa4mGOU-SqNe5ninlGA-1
X-Mimecast-MFC-AGG-ID: 3QAsa4mGOU-SqNe5ninlGA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49DE91956086;
	Sun,  8 Dec 2024 22:18:16 +0000 (UTC)
Received: from thinkpad-p1.localdomain.com (unknown [10.22.88.31])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65E5C300018D;
	Sun,  8 Dec 2024 22:18:14 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net-next] net/bridge: Add skb drop reasons to the most common drop points
Date: Sun,  8 Dec 2024 17:18:05 -0500
Message-ID: <20241208221805.1543107-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The bridge input code may drop frames for various reasons and at various
points in the ingress handling logic. Currently kfree_skb() is used
everywhere, and therefore no drop reason is specified. Add drop reasons
to the most common drop points.

The purpose of this patch is to address the most common drop points on
the bridge ingress path. It does not exhaustively add drop reasons to
the entire bridge code. The intention here is to incrementally add drop
reasons to the rest of the bridge code in follow up patches.

Most of the skb drop points that are addressed in this patch can be
easily tested by sending crafted packets. The diagram below shows a
simple test configuration, and some examples using `packit`(*) are
also included. The bridge is set up with STP disabled.
(*) https://github.com/resurrecting-open-source-projects/packit

The following changes were *not* tested:
* SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT in br_multicast_flood(). I could
  not find an easy way to make a crafted packet get there.
* SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD in br_handle_frame_finish()
  when the port state is BR_STATE_DISABLED, because in that case the
  frame is already dropped in the switch/case block at the end of
  br_handle_frame().

    +---+---+
    |  br0  |
    +---+---+
        |
    +---+---+  veth pair  +-------+
    | veth0 +-------------+ xeth0 |
    +-------+             +-------+

SKB_DROP_REASON_MAC_INVALID_SOURCE - br_handle_frame()
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 01:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL - br_handle_frame()
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E 01:80:c2:00:00:01 -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame()
bridge link set dev veth0 state 0 # disabled
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame_finish()
bridge link set dev veth0 state 2 # learning
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT - br_flood()
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 include/net/dropreason-core.h | 18 ++++++++++++++++++
 net/bridge/br_forward.c       |  4 ++--
 net/bridge/br_input.c         | 24 +++++++++++++++---------
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index c29282fabae6..1f2ae5b387c1 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -108,6 +108,9 @@
 	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
 	FN(ARP_PVLAN_DISABLE)		\
+	FN(MAC_IEEE_MAC_CONTROL)	\
+	FN(BRIDGE_INGRESS_PORT_NFWD)	\
+	FN(BRIDGE_NO_EGRESS_PORT)	\
 	FNe(MAX)
 
 /**
@@ -502,6 +505,21 @@ enum skb_drop_reason {
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
+	SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD,
+	/**
+	 * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT: no eligible egress port was
+	 * found while attempting to flood the frame.
+	 */
+	SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index e19b583ff2c6..e33e2f4fc3d9 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -249,7 +249,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 
 out:
 	if (!local_rcv)
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
 }
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
@@ -349,6 +349,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 
 out:
 	if (!local_rcv)
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);
 }
 #endif
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index ceaa5a89b947..fc00e172e1e1 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -96,8 +96,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (br_mst_is_enabled(br)) {
 		state = BR_STATE_FORWARDING;
 	} else {
-		if (p->state == BR_STATE_DISABLED)
-			goto drop;
+		if (p->state == BR_STATE_DISABLED) {
+			kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
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
+		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
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
+		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
 	}
 	return RX_HANDLER_CONSUMED;
 }
-- 
2.47.1


