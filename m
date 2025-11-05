Return-Path: <netdev+bounces-235858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA70C36A7F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451971A4294F
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5E233B96A;
	Wed,  5 Nov 2025 16:08:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83104334C33;
	Wed,  5 Nov 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358886; cv=none; b=RBLkJjKGO/bDlRhSiM8mQddvZ3jpIuwj7EvxfhmNkCPuW0HwPtE4rSPvUUypzEhePyQFHI7eLA45Ts0pJRFPeBK7h39N/rEMybN7pUyCSnxWM5efScBGlMtoqiNPW6iW6oOHHheXo2qh100nZ1HON65BIVYjefC7bjc9zgLqsoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358886; c=relaxed/simple;
	bh=ZiWQ5REple6VKc4oiJyq/bf1THoa1NpEXakgPmYk1qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtmB2n+qDAh+FqnMbYYlkTZKYoEzvM6+iEVYAwl17GAdm9TmkdpyN7AEp55xmn2IcUw55xwvyYgSkGOQLMFvLoOOwkscxNJFtxOVmsUGzGobmOFQz+CFkVuDi42zJJjJAisTJprtr84OX3gF3iaA2IB/91LKriAYaVIUK9XC5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d1qrR6wqCz6L515;
	Thu,  6 Nov 2025 00:04:07 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E8A91400D9;
	Thu,  6 Nov 2025 00:08:00 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:08:00 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 06/14] ipvlan: Support GSO for port -> ipvlan
Date: Wed, 5 Nov 2025 19:07:10 +0300
Message-ID: <20251105160713.1727206-7-skorodumov.dmitry@huawei.com>
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

If main port interface supports GSO, we need manually segment
the skb before forwarding it to ipvlan interface.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 51 ++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 18a69b4fb58c..ec53cc0ada3b 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -4,6 +4,7 @@
 
 #include <linux/ethtool.h>
 #include <net/netdev_lock.h>
+#include <net/gso.h>
 
 #include "ipvlan.h"
 
@@ -71,6 +72,41 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
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
+		return NET_RX_DROP;
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
 static int ipvlan_port_rcv(struct sk_buff *skb, struct net_device *wdev,
 			   struct packet_type *pt, struct net_device *orig_wdev)
 {
@@ -111,19 +147,8 @@ static int ipvlan_port_rcv(struct sk_buff *skb, struct net_device *wdev,
 		goto out;
 
 	addr = ipvlan_addr_lookup(port, lyr3h, addr_type, true);
-	if (addr) {
-		struct ipvl_dev *ipvlan = addr->master;
-		int ret, len;
-
-		ipvlan_skb_crossing_ns(skb, ipvlan->dev);
-		skb->protocol = eth_type_trans(skb, skb->dev);
-		skb->pkt_type = PACKET_HOST;
-		ipvlan_mark_skb(skb, port->dev);
-		len = skb->len + ETH_HLEN;
-		ret = netif_rx(skb);
-		ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, false);
-		return NET_RX_SUCCESS;
-	}
+	if (addr)
+		return ipvlan_receive(addr->master, skb);
 
 out:
 	dev_kfree_skb(skb);
-- 
2.25.1


