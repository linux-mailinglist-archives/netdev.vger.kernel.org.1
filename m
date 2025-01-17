Return-Path: <netdev+bounces-159182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96229A14AA9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9D4160EA1
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655651F8AC1;
	Fri, 17 Jan 2025 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="lfMfWrrQ"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E03D1F75AB
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100974; cv=none; b=Qy4Fa9gyA4XJmK0hx7XaKDghPxqw4OqjyQ5oIZ9ol+oFF6rwzf9vcj3QzApoo7rS52zLxmfLmKjaXgP7QaB0NexiZGyi8jlt87MB/xcRgw8Vm+ODFrfYsjMVffwCmjKoCfPJHXe3c4LAdPX8POgoRUqJa2tpp49U1mmH/35k2t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100974; c=relaxed/simple;
	bh=+DEoahxWMOWSYKVxlWG39CYqx1tPPMsJjaSkyweNIII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jH7C2/1RdFRUgwAQOGyF1ow+4j3IxTTJL2rAi1tYV45UeSM+WZlR1eBuQfLNW+8qt97Ejh+r5pRl01T5IqvCJLqDQr1poIELYbInCkyLQU6wLPulChZDOSZgC4IPtDZU5LSbigwLrgByrHAOIIBqyAuiuO0RkNnUGroxYqcC/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=lfMfWrrQ; arc=none smtp.client-ip=173.37.86.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6472; q=dns/txt; s=iport;
  t=1737100972; x=1738310572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8tHihxnd3158brmVAAO86jPo9ElmTPjRv0wqnW/d3ck=;
  b=lfMfWrrQQWmiKAjgA+2rP5VDOJXsDrnemxwm4DxdBW0BjDoyoR4ipQgD
   ZrZCJsQhd8zp05j4xhOq25Z9PKGEM9lCkB7UtjapRPaacEmSFlkATsGYk
   F7O+M5/jPnLL5QnQAQcj8Z7MTV+K71kduftVm63o4VlTf49rnoFlZrvOx
   0=;
X-CSE-ConnectionGUID: I/NRu+6MQQy/yYI71ejjkQ==
X-CSE-MsgGUID: fpAWK48FQtaJnWXUO97Zyg==
X-IPAS-Result: =?us-ascii?q?A0AtAABfDYpn/5X/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkqBT0NIjHJfpw6BJQNWDwEBAQ9EBAEBhQcCinMCJjQJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGWwIBAycLAUYQUSsrB?=
 =?us-ascii?q?xKDAYJlA7MfgXkzgQHeM4FtgUgBhWqHX3CEdycbgUlEhH2LBwSCMoUznzJIg?=
 =?us-ascii?q?SEDWSwBVRMNCgsHBYE5OAMiCwsMCxQcFQIVHQ8GEARtRDeCRmlJNwINAjWCH?=
 =?us-ascii?q?iRYgiuEXIRFhFGCR1SCR4IUeoEahG9AAwsYDUgRLDcGDhsGPm4Hm1M8g2wHg?=
 =?us-ascii?q?Q6CBqYqi3KVEYQlgWOfYxozqlOYfCKkJYRmgWc8gVkzGggbFYMiUhkPji0Ww?=
 =?us-ascii?q?UIlMjwCBwsBAQMJj2MtgU4BAQ?=
IronPort-Data: A9a23:HjAhsqMPNrzSbm/vrR2HlsFynXyQoLVcMsEvi/4bfWQNrUoi0TQCy
 2YZD2CCPv3ZZzOgedFyb9ngp05TvseEyNJlQXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WljlV
 e/a+ZWFZQf8gmEsawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj69QpKnsrftM9w99mRnB/1
 KNBJTIPbSnW0opawJrjIgVtrt4oIM+uOMYUvWttiGiDS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzPXwsYDUXUrsTIJA5nOGkj33yWzZZs1mS46Ew5gA/ySQqiOeybIeMJIbiqcN9kF6xm
 UGar0rAHhg4MuOv9B3UrUC9ibqa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pSJ
 1ER8zgjsYA980ukStS7VBq9yFaHoxQVc9ldCes37EeK0KW8yw+fCnIJUX1HZcAqudEeQSEs0
 BmCn7vBHTVlvbuUYWiQ+redsXW5Pi19BWkPeSMJUyMb7NT55oI+lBTCSpBkCqHdszHuMSv7z
 zbPqG01gK8eyJdRka665lvAxTmro/AlUzII2+keZUr9hisRWWJvT9XABYTzhRqYELukcw==
IronPort-HdrOrdr: A9a23:U7Gn4qzrpRI6NHzrWdjNKrPwK71zdoMgy1knxilNoNJuHfBw8P
 re+8jzuiWUtN98YhwdcJW7Scu9qBDnhPpICPcqXYtKNTOO0ADDEGgh1/qG/9SKIUPDH4BmuZ
 uIC5IOa+EZyTNB/L/HCM7SKadH/OW6
X-Talos-CUID: 9a23:BJGgeW5zrl1uwMTWg9ss1QkyIN1mLFjk9WaXMn6ZVj9kSr+WcArF
X-Talos-MUID: =?us-ascii?q?9a23=3Am6gtKw06Ttf2v3vUFxBc0VWnTjUj7byHN2NRwbs?=
 =?us-ascii?q?/p8CmMxNABhDM0wamTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,211,1732579200"; 
   d="scan'208";a="307745162"
Received: from rcdn-l-core-12.cisco.com ([173.37.255.149])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Jan 2025 08:01:41 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-12.cisco.com (Postfix) with ESMTP id D6E21180001D7;
	Fri, 17 Jan 2025 08:01:41 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id B201720F2005; Fri, 17 Jan 2025 00:01:41 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v6 2/3] enic: Simplify RX handler function
Date: Fri, 17 Jan 2025 00:01:38 -0800
Message-Id: <20250117080139.28018-3-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250117080139.28018-1-johndale@cisco.com>
References: <20250117080139.28018-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-12.cisco.com

Split up RX handler functions in preparation for moving
to a page pool based implementation.

No functional changes.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_rq.c | 162 +++++++++++++---------
 1 file changed, 93 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
index e5b2f581c055..48aa385aa831 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -50,6 +50,94 @@ int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
 	return 0;
 }
 
+static void enic_rq_set_skb_flags(struct vnic_rq *vrq, u8 type, u32 rss_hash,
+				  u8 rss_type, u8 fcoe, u8 fcoe_fc_crc_ok,
+				  u8 vlan_stripped, u8 csum_not_calc,
+				  u8 tcp_udp_csum_ok, u8 ipv6, u8 ipv4_csum_ok,
+				  u16 vlan_tci, struct sk_buff *skb)
+{
+	struct enic *enic = vnic_dev_priv(vrq->vdev);
+	struct net_device *netdev = enic->netdev;
+	struct enic_rq_stats *rqstats =  &enic->rq[vrq->index].stats;
+	bool outer_csum_ok = true, encap = false;
+
+	if ((netdev->features & NETIF_F_RXHASH) && rss_hash && type == 3) {
+		switch (rss_type) {
+		case CQ_ENET_RQ_DESC_RSS_TYPE_TCP_IPv4:
+		case CQ_ENET_RQ_DESC_RSS_TYPE_TCP_IPv6:
+		case CQ_ENET_RQ_DESC_RSS_TYPE_TCP_IPv6_EX:
+			skb_set_hash(skb, rss_hash, PKT_HASH_TYPE_L4);
+			rqstats->l4_rss_hash++;
+			break;
+		case CQ_ENET_RQ_DESC_RSS_TYPE_IPv4:
+		case CQ_ENET_RQ_DESC_RSS_TYPE_IPv6:
+		case CQ_ENET_RQ_DESC_RSS_TYPE_IPv6_EX:
+			skb_set_hash(skb, rss_hash, PKT_HASH_TYPE_L3);
+			rqstats->l3_rss_hash++;
+			break;
+		}
+	}
+	if (enic->vxlan.vxlan_udp_port_number) {
+		switch (enic->vxlan.patch_level) {
+		case 0:
+			if (fcoe) {
+				encap = true;
+				outer_csum_ok = fcoe_fc_crc_ok;
+			}
+			break;
+		case 2:
+			if (type == 7 && (rss_hash & BIT(0))) {
+				encap = true;
+				outer_csum_ok = (rss_hash & BIT(1)) &&
+						(rss_hash & BIT(2));
+			}
+			break;
+		}
+	}
+
+	/* Hardware does not provide whole packet checksum. It only
+	 * provides pseudo checksum. Since hw validates the packet
+	 * checksum but not provide us the checksum value. use
+	 * CHECSUM_UNNECESSARY.
+	 *
+	 * In case of encap pkt tcp_udp_csum_ok/tcp_udp_csum_ok is
+	 * inner csum_ok. outer_csum_ok is set by hw when outer udp
+	 * csum is correct or is zero.
+	 */
+	if ((netdev->features & NETIF_F_RXCSUM) && !csum_not_calc &&
+	    tcp_udp_csum_ok && outer_csum_ok && (ipv4_csum_ok || ipv6)) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level = encap;
+		if (encap)
+			rqstats->csum_unnecessary_encap++;
+		else
+			rqstats->csum_unnecessary++;
+	}
+
+	if (vlan_stripped) {
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
+		rqstats->vlan_stripped++;
+	}
+}
+
+static bool enic_rq_pkt_error(struct vnic_rq *vrq, u8 packet_error, u8 fcs_ok,
+			      u16 bytes_written)
+{
+	struct enic *enic = vnic_dev_priv(vrq->vdev);
+	struct enic_rq_stats *rqstats = &enic->rq[vrq->index].stats;
+
+	if (packet_error) {
+		if (!fcs_ok) {
+			if (bytes_written > 0)
+				rqstats->bad_fcs++;
+			else if (bytes_written == 0)
+				rqstats->pkt_truncated++;
+		}
+		return true;
+	}
+	return false;
+}
+
 int enic_rq_alloc_buf(struct vnic_rq *rq)
 {
 	struct enic *enic = vnic_dev_priv(rq->vdev);
@@ -113,7 +201,6 @@ void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
 	u8 packet_error;
 	u16 q_number, completed_index, bytes_written, vlan_tci, checksum;
 	u32 rss_hash;
-	bool outer_csum_ok = true, encap = false;
 
 	rqstats->packets++;
 	if (skipped) {
@@ -132,14 +219,7 @@ void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
 			    &tcp, &ipv4_csum_ok, &ipv6, &ipv4, &ipv4_fragment,
 			    &fcs_ok);
 
-	if (packet_error) {
-		if (!fcs_ok) {
-			if (bytes_written > 0)
-				rqstats->bad_fcs++;
-			else if (bytes_written == 0)
-				rqstats->pkt_truncated++;
-		}
-
+	if (enic_rq_pkt_error(rq, packet_error, fcs_ok, bytes_written)) {
 		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
 				 DMA_FROM_DEVICE);
 		dev_kfree_skb_any(skb);
@@ -162,66 +242,10 @@ void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
 		skb_put(skb, bytes_written);
 		skb->protocol = eth_type_trans(skb, netdev);
 		skb_record_rx_queue(skb, q_number);
-		if ((netdev->features & NETIF_F_RXHASH) && rss_hash &&
-		    type == 3) {
-			switch (rss_type) {
-			case CQ_ENET_RQ_DESC_RSS_TYPE_TCP_IPv4:
-			case CQ_ENET_RQ_DESC_RSS_TYPE_TCP_IPv6:
-			case CQ_ENET_RQ_DESC_RSS_TYPE_TCP_IPv6_EX:
-				skb_set_hash(skb, rss_hash, PKT_HASH_TYPE_L4);
-				rqstats->l4_rss_hash++;
-				break;
-			case CQ_ENET_RQ_DESC_RSS_TYPE_IPv4:
-			case CQ_ENET_RQ_DESC_RSS_TYPE_IPv6:
-			case CQ_ENET_RQ_DESC_RSS_TYPE_IPv6_EX:
-				skb_set_hash(skb, rss_hash, PKT_HASH_TYPE_L3);
-				rqstats->l3_rss_hash++;
-				break;
-			}
-		}
-		if (enic->vxlan.vxlan_udp_port_number) {
-			switch (enic->vxlan.patch_level) {
-			case 0:
-				if (fcoe) {
-					encap = true;
-					outer_csum_ok = fcoe_fc_crc_ok;
-				}
-				break;
-			case 2:
-				if (type == 7 &&
-				    (rss_hash & BIT(0))) {
-					encap = true;
-					outer_csum_ok = (rss_hash & BIT(1)) &&
-							(rss_hash & BIT(2));
-				}
-				break;
-			}
-		}
-
-		/* Hardware does not provide whole packet checksum. It only
-		 * provides pseudo checksum. Since hw validates the packet
-		 * checksum but not provide us the checksum value. use
-		 * CHECSUM_UNNECESSARY.
-		 *
-		 * In case of encap pkt tcp_udp_csum_ok/tcp_udp_csum_ok is
-		 * inner csum_ok. outer_csum_ok is set by hw when outer udp
-		 * csum is correct or is zero.
-		 */
-		if ((netdev->features & NETIF_F_RXCSUM) && !csum_not_calc &&
-		    tcp_udp_csum_ok && outer_csum_ok &&
-		    (ipv4_csum_ok || ipv6)) {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb->csum_level = encap;
-			if (encap)
-				rqstats->csum_unnecessary_encap++;
-			else
-				rqstats->csum_unnecessary++;
-		}
-
-		if (vlan_stripped) {
-			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
-			rqstats->vlan_stripped++;
-		}
+		enic_rq_set_skb_flags(rq, type, rss_hash, rss_type, fcoe,
+				      fcoe_fc_crc_ok, vlan_stripped,
+				      csum_not_calc, tcp_udp_csum_ok, ipv6,
+				      ipv4_csum_ok, vlan_tci, skb);
 		skb_mark_napi_id(skb, &enic->napi[rq->index]);
 		if (!(netdev->features & NETIF_F_GRO))
 			netif_receive_skb(skb);
-- 
2.35.2


