Return-Path: <netdev+bounces-231298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3C5BF7272
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DECF4EBEBA
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F60340D98;
	Tue, 21 Oct 2025 14:46:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B6340A5F;
	Tue, 21 Oct 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058000; cv=none; b=Smg+41JHkjxQa+8RBJZbBIoLcBqzM5+SJ4S26PBiL7ysi27yzJPMf21d+b1uWlksSVNGxCkElgdqTOWhGfuEpsLhJOIObliDHYHZsIE3Ron4VOohZ/W6qzginaQtbu/g4BKu9Pw0aCNDCsjUanXxXH17Vd6rV/g0dM8AhdVz6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058000; c=relaxed/simple;
	bh=ARRg4+o+/YEUb+aaHWYf/yQrw7Xn7ZN+cazC/OZzMYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPiQoiv+k9eZ9USAUlAwey32UiShOQJX6vD3f/e3Olj6VAf1xdEsa0LANo0+g3D0vYQZTI7CV5GdQxFzTpsNSXIlGZbXKL8YJb6AnMDy6YTbvzDzDepCqa5/uY/ciQOLVrzvsJHaSgYEZjDBUdDTFz32bZIGCxMGs7cU2eQSGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4crZlj0YKBz6D97N;
	Tue, 21 Oct 2025 22:42:57 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id AAED21402F5;
	Tue, 21 Oct 2025 22:46:35 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 17:46:35 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 6/8] ipvlan: Support GSO for port -> ipvlan
Date: Tue, 21 Oct 2025 17:44:08 +0300
Message-ID: <20251021144410.257905-7-skorodumov.dmitry@huawei.com>
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

If main port interface supports GSO, we need manually segment
the skb before forwarding it to ipvlan interface.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 50 ++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 28ce36669d39..f1b1f91f94c0 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -4,6 +4,7 @@
 
 #include <linux/ethtool.h>
 #include <net/netdev_lock.h>
+#include <net/gso.h>
 
 #include "ipvlan.h"
 
@@ -76,6 +77,41 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 	return err;
 }
 
+static int ipvlan_receive(struct ipvl_dev *ipvlan, struct sk_buff *skb)
+{
+	struct sk_buff *segs;
+	struct sk_buff *nskb;
+	ssize_t mac_hdr_size;
+	int ret, len;
+
+	skb->pkt_type = PACKET_HOST;
+	skb->protocol = eth_type_trans(skb, skb->dev);
+	ipvlan_skb_crossing_ns(skb, ipvlan->dev);
+	ipvlan_mark_skb(skb, ipvlan->phy_dev);
+	if (skb_shinfo(skb)->gso_size == 0) {
+		len = skb->len + ETH_HLEN;
+		ret = netif_rx(skb);
+		ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, false);
+		return ret;
+	}
+
+	mac_hdr_size = skb->network_header - skb->mac_header;
+	__skb_push(skb, mac_hdr_size);
+	segs = skb_gso_segment(skb, 0);
+	dev_kfree_skb(skb);
+	if (IS_ERR(segs))
+		return 0;
+
+	skb_list_walk_safe(segs, segs, nskb) {
+		skb_mark_not_on_list(segs);
+		__skb_pull(segs, mac_hdr_size);
+		len = segs->len + ETH_HLEN;
+		ret = netif_rx(segs);
+		ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, false);
+	}
+	return ret;
+}
+
 static int ipvlan_port_receive(struct sk_buff *skb, struct net_device *wdev,
 			       struct packet_type *pt, struct net_device *orig_wdev)
 {
@@ -115,18 +151,8 @@ static int ipvlan_port_receive(struct sk_buff *skb, struct net_device *wdev,
 		goto out;
 
 	addr = ipvlan_addr_lookup(port, lyr3h, addr_type, true);
-	if (addr) {
-		int ret, len;
-
-		ipvlan_skb_crossing_ns(skb, addr->master->dev);
-		skb->protocol = eth_type_trans(skb, skb->dev);
-		skb->pkt_type = PACKET_HOST;
-		ipvlan_mark_skb(skb, port->dev);
-		len = skb->len + ETH_HLEN;
-		ret = netif_rx(skb);
-		ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, false);
-		return 0;
-	}
+	if (addr)
+		return ipvlan_receive(addr->master, skb);
 
 out:
 	dev_kfree_skb(skb);
-- 
2.25.1


