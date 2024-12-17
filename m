Return-Path: <netdev+bounces-152741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2DB9F5A21
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD45518944F2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 23:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34861FA145;
	Tue, 17 Dec 2024 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eghK9aAh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366F1F8AE6
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476869; cv=none; b=IQYVVbAgZpZ1ZiB784ExwNkOfnP6IdADu6AoaC9YR+MA+HoS4XA0aaRBdHD7O+c2c4a6cSaoZvwHMaW7e6YJW5JFHUJhSpJAbyuY3CAJ4UtEffo6NAaOd+dQIjfUiEWO14Notj30sr3oWwvsPFTy/XKdC+PAYpB20Amvpb9HG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476869; c=relaxed/simple;
	bh=PkrHh7Z4nTwZiRN3v+cLZGL9NEK4Z2A1GlBLOoGqafM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxTsO/P0r08VzqDB2dX3xOfouI56UHIDlr0DYrlPtYs+fJH8zuPhKRZHIw8jJr7mx6d/kSr5dgCaxcwdOMo22MMphkhnB0sCH7oiFuuCHVOeXl31oi6yVC+BLOWNI743LIZoTSuRCUPTv9QXC4+X8iPR+A7XbspUoCYhaSkjg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eghK9aAh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734476867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VU6lNo5XLHAIp4OF6qULlJdvE1fCiJVwYTJas6gYzLY=;
	b=eghK9aAhTqPxHpF4paG8I3toAC3QrQZlN0Qk2VmhH9ZQJaiw5hbzV7SarVH4JpnJgpdsDF
	wr3um3ZKhVby7hKSwmng0Y29ewYwKDdkGodWAqYgNL6CzRDMBgxE0A4HMmyAMtYbCFZZke
	zz1RDrboGi2cWcH9uuYcKnHoSpEk0ag=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-qJf--3jtPkChUWBbCRWyaw-1; Tue,
 17 Dec 2024 18:07:43 -0500
X-MC-Unique: qJf--3jtPkChUWBbCRWyaw-1
X-Mimecast-MFC-AGG-ID: qJf--3jtPkChUWBbCRWyaw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2535019560AB;
	Tue, 17 Dec 2024 23:07:42 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.88.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB13C195E480;
	Tue, 17 Dec 2024 23:07:39 +0000 (UTC)
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
Subject: [PATCH net-next v2 1/2] net: vxlan: rename SKB_DROP_REASON_VXLAN_NO_REMOTE
Date: Tue, 17 Dec 2024 18:07:10 -0500
Message-ID: <20241217230711.192781-2-rrendec@redhat.com>
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

The SKB_DROP_REASON_VXLAN_NO_REMOTE skb drop reason was introduced in
the specific context of vxlan. As it turns out, there are similar cases
when a packet needs to be dropped in other parts of the network stack,
such as the bridge module.

Rename SKB_DROP_REASON_VXLAN_NO_REMOTE and give it a more generic name,
so that it can be used in other parts of the network stack. This is not
a functional change, and the numeric value of the drop reason even
remains unchanged.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++--
 drivers/net/vxlan/vxlan_mdb.c  | 2 +-
 include/net/dropreason-core.h  | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0c356e0a61ef0..05c10acb2a57e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2798,7 +2798,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			dev_dstats_tx_dropped(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
-			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
+			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 			return NETDEV_TX_OK;
 		}
 	}
@@ -2821,7 +2821,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (fdst)
 			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
 		else
-			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
+			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 	}
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 8735891ee1286..816ab1aa05262 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1712,7 +1712,7 @@ netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
 		vxlan_xmit_one(skb, vxlan->dev, src_vni,
 			       rcu_dereference(fremote->rd), false);
 	else
-		kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
+		kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 
 	return NETDEV_TX_OK;
 }
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index ead4170a1d0a9..be58c97c64a1b 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -106,7 +106,7 @@
 	FN(VXLAN_VNI_NOT_FOUND)		\
 	FN(MAC_INVALID_SOURCE)		\
 	FN(VXLAN_ENTRY_EXISTS)		\
-	FN(VXLAN_NO_REMOTE)		\
+	FN(NO_TX_TARGET)		\
 	FN(IP_TUNNEL_ECN)		\
 	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
@@ -497,8 +497,8 @@ enum skb_drop_reason {
 	 * entry or an entry pointing to a nexthop.
 	 */
 	SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
-	/** @SKB_DROP_REASON_VXLAN_NO_REMOTE: no remote found for xmit */
-	SKB_DROP_REASON_VXLAN_NO_REMOTE,
+	/** @SKB_DROP_REASON_NO_TX_TARGET: no remote found for xmit */
+	SKB_DROP_REASON_NO_TX_TARGET,
 	/**
 	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
-- 
2.47.1


