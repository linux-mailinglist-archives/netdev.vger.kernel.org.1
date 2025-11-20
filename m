Return-Path: <netdev+bounces-240512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68334C75CC8
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C06EA4E1C29
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86D92FD1B6;
	Thu, 20 Nov 2025 17:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD4E86353;
	Thu, 20 Nov 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661013; cv=none; b=j85uF8WX/ZNakiWb/UuOxBtNwgOTada5FiuarOJxQg1nMIzeh2MC9DPGaBOsUUpKD4Qwvs2been3xBMm4X7tQPwveW1ftSddhumQM75/PQtTiB8UMWU79cBhY5gpMwikn76TbFnRzBORbQQLCCpLIRCzlY1k++2YfkR6NdOGsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661013; c=relaxed/simple;
	bh=RKZ1RnmG4MTsNuHEc2YMJCAUqssAaYXpX/a+VpG2TKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnDeJunc+EhxKU05UngkUVKERP+g/RpTiTS5404IZnVoQNgPZjetdqjfzjJz85CZ/gW/tdKSuxdTR3bqlMT93WSFfWRB3PkBnI6+vBSjpfuX97+1D/5hdXOQVKHMITGwg6Dsm02Svwj+B8TXzdsSDi/hStV1MjqaYBj7SzHI8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5TB682gzHnGcx;
	Fri, 21 Nov 2025 01:49:34 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 0673A1402EC;
	Fri, 21 Nov 2025 01:50:10 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 20:50:09 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Jakub Kicinski <kuba@kernel.org>, Guillaume
 Nault <gnault@redhat.com>, Eric Dumazet <edumazet@google.com>, Julian Vetter
	<julian@outer-limits.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 02/12] ipvlan: macnat: Handle rx mcast-ip and unicast eth
Date: Thu, 20 Nov 2025 20:49:39 +0300
Message-ID: <20251120174949.3827500-3-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
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

Some WiFi enfironments sometimes send mcast packets
with unicast eth_dst. Forcibly replace eth_dst to be bcast in this case
if bridge is in L2E mode.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 62 ++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 5127f4832a8c..1d9478f570fe 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -985,18 +985,69 @@ static rx_handler_result_t ipvlan_handle_mode_l3(struct sk_buff **pskb,
 	return ret;
 }
 
+static bool ipvlan_is_mcast(struct ipvl_port *port, void *lyr3h, int addr_type)
+{
+	switch (addr_type) {
+#if IS_ENABLED(CONFIG_IPV6)
+	/* No need to handle ICMPv6. This type is used for DAD only. */
+	case IPVL_IPV6:
+		return !is_ipv6_usable(&((struct ipv6hdr *)lyr3h)->daddr);
+#endif
+	case IPVL_IPV4: {
+		/* Treat mcast, bcast and zero as multicast. */
+		__be32 i4addr = ((struct iphdr *)lyr3h)->daddr;
+
+		return !is_ipv4_usable(i4addr);
+	}
+	case IPVL_ARP: {
+		struct arphdr *arph;
+		unsigned char *arp_ptr;
+		__be32 i4addr;
+
+		arph = (struct arphdr *)lyr3h;
+		arp_ptr = (unsigned char *)(arph + 1);
+		arp_ptr += (2 * port->dev->addr_len) + 4;
+		i4addr = *(__be32 *)arp_ptr;
+		return !is_ipv4_usable(i4addr);
+	}
+	}
+	return false;
+}
+
+static bool ipvlan_is_l2_mcast(struct ipvl_port *port, struct sk_buff *skb,
+			       bool *need_eth_fix)
+{
+	int addr_type;
+	void *lyr3h;
+
+	/* In some wifi environments unicast dest address means nothing.
+	 * IP still can be a mcast and frame should be treated as mcast.
+	 */
+	*need_eth_fix = false;
+	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
+		return true;
+
+	if (!ipvlan_is_macnat(port))
+		return false;
+
+	lyr3h = ipvlan_get_L3_hdr(port, skb, &addr_type);
+	*need_eth_fix = lyr3h && ipvlan_is_mcast(port, lyr3h, addr_type);
+
+	return *need_eth_fix;
+}
+
 static rx_handler_result_t ipvlan_handle_mode_l2(struct sk_buff **pskb,
 						 struct ipvl_port *port)
 {
-	struct sk_buff *skb = *pskb;
-	struct ethhdr *eth = eth_hdr(skb);
 	rx_handler_result_t ret = RX_HANDLER_PASS;
+	struct sk_buff *skb = *pskb;
+	bool need_eth_fix;
 
 	/* Ignore already seen packets. */
 	if (ipvlan_is_skb_marked(skb, port->dev))
 		return RX_HANDLER_PASS;
 
-	if (is_multicast_ether_addr(eth->h_dest)) {
+	if (ipvlan_is_l2_mcast(port, skb, &need_eth_fix)) {
 		if (ipvlan_external_frame(skb, port) ||
 		    ipvlan_is_macnat(port)) {
 			/* External frames are queued for device local
@@ -1008,6 +1059,11 @@ static rx_handler_result_t ipvlan_handle_mode_l2(struct sk_buff **pskb,
 			struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
 
 			if (nskb) {
+				if (need_eth_fix) {
+					struct ethhdr *eth = eth_hdr(nskb);
+
+					eth_broadcast_addr(eth->h_dest);
+				}
 				ipvlan_mark_skb(skb, port->dev);
 				ipvlan_skb_crossing_ns(nskb, NULL);
 				ipvlan_multicast_enqueue(port, nskb, false);
-- 
2.25.1


