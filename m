Return-Path: <netdev+bounces-163296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33BEA29DB6
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B231888B42
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0E621D58F;
	Wed,  5 Feb 2025 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="H1VbXpI4"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428321B19F
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738799743; cv=none; b=p5Wz9AIIxfyAqcwN6ANAlV4UKybNfe2kl0N3CbSr0x33jao9FHghoTsGPMkhury9REP/bSNI2r08Hy9xi0zkUuh5AI9MdkWAK/9uG2so2N5zRDOLjkRUgOgQFizJydArs8tGbPMPwcn+/tUX6rtBcJ1Ms9L2r9P/sDDczznhaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738799743; c=relaxed/simple;
	bh=VON6Vu2sZh/beyWH4Rr8nlwTxi5IaBiyyZ8BbOKShsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uC6ABMB5m+QYdnxZn32VoLpt49gz2M4X5l2PHF0AUUOD/BRzcsY+HaH5q0NrxF+dXI5giWPysJqHP1kTp5osA7XgJUtiMas5ScvibTcJiJjQlmHmEg8VYLti2m/rCH4gmLhbmUKT18zNE7yaYAlY4ysPhoiMWBE8oEBgVwkQl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=H1VbXpI4; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6472; q=dns/txt; s=iport;
  t=1738799741; x=1740009341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EBucgvS5Z2mCmKGni79kFmes1t/olgeTWVria/r6Qzc=;
  b=H1VbXpI4hJ0PijgFri8KDsZOTN0YCpVsAi5A56OGgrhXE8kh/j1eXbFm
   bTKMjQnkJ8IYWMEyAJw+05elgpc3dAUq9FvjetYSLDBJBARH3LGZiyd/G
   vpUSWiZ2IRFMLGYdjv2hB+ZiTbuXJXu18AMXpArXDkcm18wkJyKg/K7Nq
   M=;
X-CSE-ConnectionGUID: lZ9JV1AOQ5K4irQR+15Hlw==
X-CSE-MsgGUID: QroRvNQJTTyLiSvehpESJg==
X-IPAS-Result: =?us-ascii?q?A0AUAABv+aNn/5H/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYIABQEBAQsBgkqBT0NIjVGnC4ElA1YPAQEBD0QEAQGFBwKLAAImNQgOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZbAgEDJwsBR?=
 =?us-ascii?q?hBRKysHEoMCgmUDsFGBeTOBAd40gW6BSAGFa4dfcIR3JxuBSUSEfYsHBIIvh?=
 =?us-ascii?q?S+idEiBIQNZLAFVEw0KCwcFgTk4AyAKCwwLFBwVAhQdDwYQBGpEN4JHaUk6A?=
 =?us-ascii?q?g0CNYIeJFiCK4RahEOETYJDVIJEghJ0gRqIPEADCxgNSBEsNwYOGwY+bgedT?=
 =?us-ascii?q?TyEEAeBDoIGpi2Lc5URhCWBY59jGjOqU5h8IqQmhGaBaAE6gVkzGggbFYMiU?=
 =?us-ascii?q?hkPji0WzCYlMjwCBwsBAQMJkAEtgU4BAQ?=
IronPort-Data: A9a23:RyUjTaAw3jsiIhVW/wviw5YqxClBgxIJ4kV8jS/XYbTApDh2gmYDm
 GEWCmCCO/fYZGbwfYokbtiz/RsB78SExtFmOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZsCCeB/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWGthh
 fuo+5eCYAX9hmYuWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEx8c/Ln9vFKohp8UrAHt3z
 79BdRAJcUXW7w626OrTpuhEnM8vKozveYgYoHwllWGfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGYyBPjDS0Un1lM/CpU+muuhgnTXeDxDo1XTrq0yi4TW5FcpiOm2aYSNI7RmQ+1shEGiu
 ET/3VjFEzUbD8KSySKoyVCj07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc99TN
 kkd6Ccyhac180OvQ5/2WBjQiH2ZtBc0WNdKFeA+rgaXxcL86gCVHGUbDThMdNArqucyWDosk
 FSJ9/vxDDZitry9U3+R9r6I6zi1PEA9K2IeaSIaZRUK7sOlo4wpiB/LCNF5H8aIYsbdAzr8x
 XWO6SM5nbhW1Z5N3KSg9leBiDWpznTUcjMICszsdjrNxmtEiESNPuRENXCzAS58Ebuk
IronPort-HdrOrdr: A9a23:k7Gpua9hNhCfFdpHmERuk+DfI+orL9Y04lQ7vn2ZhyY7TiX+rb
 HIoB11737JYVoqNU3I3OrwWpVoIkmskaKdn7NwAV7KZmCP0wGVxcNZnO7fKlbbdREWmNQw6U
 4ZSdkcNDU1ZmIK9PoTJ2KDYrAd/OU=
X-Talos-CUID: 9a23:pwcG/26etFMJd8/BXdss8HxFOP58W1rkkVSMIlWBMyUwFZ2RVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AMrLv7g5L6SrqUO2Xx87oTHduxoxR+aOUFmY0s6k?=
 =?us-ascii?q?6qu2FDjJ9Oy+wtxa4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,262,1732579200"; 
   d="scan'208";a="300931601"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Feb 2025 23:54:31 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTP id 46FED180001E8;
	Wed,  5 Feb 2025 23:54:31 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 1BFF220F2003; Wed,  5 Feb 2025 15:54:31 -0800 (PST)
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
Subject: [PATCH net-next v8 2/4] enic: Simplify RX handler function
Date: Wed,  5 Feb 2025 15:54:14 -0800
Message-Id: <20250205235416.25410-3-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250205235416.25410-1-johndale@cisco.com>
References: <20250205235416.25410-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-08.cisco.com

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
2.44.0


