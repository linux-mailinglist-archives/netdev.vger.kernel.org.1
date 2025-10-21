Return-Path: <netdev+bounces-231294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66473BF7259
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E27004FC6A5
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EC033FE1C;
	Tue, 21 Oct 2025 14:46:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49146336EFA;
	Tue, 21 Oct 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057992; cv=none; b=MMXGjpF2OXSMEC030xSskY/C96bu3qhZIfJnHstzt1nTVPfUgxLzvM9l3GJFcJGQa4nFJ5HfKDEqmMJokbouSx1Oq3NtrCL7Jj/eQXqntkP8A5GzHUUOwAVp5vIC71EdMkbqkAionE4l9gyYkOTJxmHAGl1rHCqOjNhwkACQ5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057992; c=relaxed/simple;
	bh=BQJ0TUB8BmfWucJRbDFbsnHOn8lKjd2g39aFSDQHK9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoYRaEpV+iGCUdJCqc62Kv9bSv+Egz8noqarE90Mg/yJuybySoqrtRV34hBLloGzg1LCZxeaa5Y2QfRJfZBLv4UcpgiMw2OelZtqdGoAiUpPdzsXywjw9k5lEp6e+bq4BwLDb/5wZLj5A5CnDgCEu0MwXxdbGLDukETl56+Cm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4crZpC0PHtz6K6Nf;
	Tue, 21 Oct 2025 22:45:07 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 77D5B1402F5;
	Tue, 21 Oct 2025 22:46:28 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 17:46:28 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/8] ipvlan: Send mcasts out directly in ipvlan_xmit_mode_l2()
Date: Tue, 21 Oct 2025 17:44:04 +0300
Message-ID: <20251021144410.257905-3-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021144410.257905-1-skorodumov.dmitry@huawei.com>
References: <20251021144410.257905-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
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
index ffe8efd2f1aa..9af0dcc307da 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -285,9 +285,10 @@ void ipvlan_process_multicast(struct work_struct *work)
 
 		if (tx_pkt) {
 			if (ipvlan_is_learnable(port)) {
-				/* Inject packet to main dev */
+				/* Inject as rx-packet to main dev */
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
+			/* Packet was already tx out in ipvlan_xmit_mode_l2(). */
 		}
+		if (consumed)
+			consume_skb(skb);
+		else
+			kfree_skb(skb);
+
 		dev_put(dev);
 		cond_resched();
 	}
@@ -729,10 +726,15 @@ static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
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


