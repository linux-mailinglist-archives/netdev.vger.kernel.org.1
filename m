Return-Path: <netdev+bounces-235857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F0C36A0D
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86916628EC
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872E4338599;
	Wed,  5 Nov 2025 16:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F2334C2B;
	Wed,  5 Nov 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358886; cv=none; b=g8bBZaCtJsV7a1pMwNpXuzG+SsDqu5xoMh59AIsbwybTzpLxmpN0Cm5LT+vhu+DV5rRe6MUX7g1fslbjNFgaFsEPhz/Ze8QjLZrTvy5bYXlfgYMY7GXVHid55IT0oOlGqbwQ9skiWnkSZJHVZ5koZZbgFTY5v+8JZ9qx00zCjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358886; c=relaxed/simple;
	bh=tvxdehWydYA+luFkBIek6+x0FQA6BTszrEUJ2KwGblU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9cXCgF7LxOZ6WRLewDP0cfPs5ujTZfPyMc+3b3We2GX/OreYj6QJOVhX3nkEz43sol0TiutfB45YOxf/E37AtC4ERVKQ+s02lNzv+1u5Y0QunciUkvbiPrpqQ8o0MkojGMzHwN5x4rM5x/E9SwKGLmYoj1h6KzSW4PpLCJ42Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d1qrP0Sjmz6L50w;
	Thu,  6 Nov 2025 00:04:05 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id AFF791400D9;
	Thu,  6 Nov 2025 00:07:57 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:07:57 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 02/14] ipvlan: Send mcasts out directly in ipvlan_xmit_mode_l2()
Date: Wed, 5 Nov 2025 19:07:06 +0300
Message-ID: <20251105160713.1727206-3-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105160713.1727206-1-skorodumov.dmitry@huawei.com>
References: <20251105160713.1727206-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Mcasts are sent to external net directly in
ipvlan_xmit_mode_l2(). The ipvlan_process_multicast()
for tx-packets just distributes them to local ifaces.

This makes life a bit easier for further patches. When
out-mcasts should be patched with proper MAC-address.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 06c1c4fdc4f6..2ff681de8105 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -285,9 +285,10 @@ void ipvlan_process_multicast(struct work_struct *work)
 
 		if (tx_pkt) {
 			if (ipvlan_is_macnat(port)) {
-				/* Inject packet to main dev */
+				/* Inject as rx-packet to main dev. */
 				nskb = skb_clone(skb, GFP_ATOMIC);
 				if (nskb) {
+					consumed = true;
 					local_bh_disable();
 					nskb->pkt_type = pkt_type;
 					nskb->dev = port->dev;
@@ -295,17 +296,13 @@ void ipvlan_process_multicast(struct work_struct *work)
 					local_bh_enable();
 				}
 			}
-
-			/* If the packet originated here, send it out. */
-			skb->dev = port->dev;
-			skb->pkt_type = pkt_type;
-			dev_queue_xmit(skb);
-		} else {
-			if (consumed)
-				consume_skb(skb);
-			else
-				kfree_skb(skb);
+			/* Tx was done in ipvlan_xmit_mode_l2(). */
 		}
+		if (consumed)
+			consume_skb(skb);
+		else
+			kfree_skb(skb);
+
 		dev_put(dev);
 		cond_resched();
 	}
@@ -764,10 +761,15 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	if (is_multicast_ether_addr(eth->h_dest)) {
-		skb_reset_mac_header(skb);
-		ipvlan_skb_crossing_ns(skb, NULL);
-		ipvlan_multicast_enqueue(ipvlan->port, skb, true);
-		return NET_XMIT_SUCCESS;
+		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+
+		if (nskb) {
+			skb_reset_mac_header(nskb);
+			ipvlan_skb_crossing_ns(nskb, NULL);
+			ipvlan_multicast_enqueue(ipvlan->port, nskb, true);
+		}
+
+		goto tx_phy_dev;
 	}
 
 	if (ipvlan_is_vepa(ipvlan->port))
-- 
2.25.1


