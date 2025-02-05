Return-Path: <netdev+bounces-163295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1349A29DB5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC37167B47
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031D21CFFF;
	Wed,  5 Feb 2025 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="VSJ2Yn3P"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09EA18A6BA
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738799742; cv=none; b=uxeitM669q/iPUdgSCaHpAjr3ZrPQ/OXRjCoiyANIhyk5NrK68wvKyfcCvbuYt9wGJ90NVr6lpc/GKlGuq4LwKixVq15OfPq+hF+NVnkiP7MhsMdYDM3/JOQmwHBDw3NOfJWex0EPlY6t4DMwixDMjAUEPBE6GXWqco+mUs+w+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738799742; c=relaxed/simple;
	bh=HsTXcHdd+JzSFDO3/nTnV0QDnzywLCFeaEVhLfnrv8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAGrwY6+VgKp9aEh+eNV/12fKx5lEv2FmBk6mqHKIqKy7mjNlkEhZ7T3hD+zqtvhimdEZq3fSbEeLP1LKj0D7vZI+s9khlZLeZdXoURRO1Gmlz5L3JzOz/qPDbjEWy87cbqbfte4gZSe+7A0xo7YNmR8bgTKStqpnaDvPOUsdCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=VSJ2Yn3P; arc=none smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=16411; q=dns/txt;
  s=iport; t=1738799739; x=1740009339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=viRRbD1wULdju1mf5Lt+Y8xA9ZpXA9DZsS8+beAfqww=;
  b=VSJ2Yn3Phby/Y+m+hs11G5EYD+QGGjtyerPjV0Wz2JjUddfqpvdDDzMW
   hZEv3Ig2OMhWcVAx2w3Ctwq0aIoUQEqgcoA9t3J0KEXq8eHX2gkx/7BrA
   hgH7TUiBQU81f5uxDtT4Te0Pw9pGGiQBt+/+L7sXfzjx8auK+cZy49T4h
   4=;
X-CSE-ConnectionGUID: xbSGBhZaT6qA7pvwuXS3Iw==
X-CSE-MsgGUID: 9X+KT799RICZr0dj3Qk5Fg==
X-IPAS-Result: =?us-ascii?q?A0AEAADv+KNn/5P/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgX8FAQEBAQsBgkqBT0NIjHJfiHSeFxSBEQNWDwEBAQ9EBAEBh?=
 =?us-ascii?q?QcCiwACJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Th?=
 =?us-ascii?q?giGWwIBAycLAUYQUSsrBxKDAoJlA7BKgXkzgQHeNIFugUgBhWuHX3CEdycbg?=
 =?us-ascii?q?UlEgRWBO4E+b4QGhl8iBIdeonRIgSEDWSwBVRMNCgsHBYE5OAMgCgsMCxQcF?=
 =?us-ascii?q?QIUHQ8GEARqRDeCR2lJOgINAjWCHiRYgiuEWoRDhE2CQ1SCRIISdIEaiDxAA?=
 =?us-ascii?q?wsYDUgRLDcGDhsGPm4HnU08hBAHgQ4BG4FqDpN+kiGhBIQlgWOfYxozqlOYf?=
 =?us-ascii?q?CKkJoRmgWc8gVkzGggbFYMiUhkPjioDFswmJTI8AgcLAQEDCZABLYFOAQE?=
IronPort-Data: A9a23:miR9NaOC8wHcsk/vrR2HlsFynXyQoLVcMsEvi/4bfWQNrUol1zEPz
 jROXGjXbK7eNGr2edskO4m3oEpT6JfSnYBhG3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WljlV
 e/a+ZWFZQf/g2MsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6+VkN24cPb8RxrhuKD5W6
 +MFGAtWTw/W0opawJrjIgVtrt4oIM+uOMYUvWttiGiBS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzM3wsYDUXUrsTIJA5nOGkj33yWzZZs1mS46Ew5gA/ySQqieWwa4aMJoziqcN9z3bbh
 V6ZrjXDIzooLoSTy2G88S+Cibqa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pSJ
 1ER8zgjsYA980ukStS7VBq9yFaHoxQVc9ldCes37EeK0KW8yw+fCnIJUX1HZcAqudEeQSEs0
 BmCn7vBHTVlvbuUYWiQ+redsXW5Pi19BWkPeSMJUyMb7NT55oI+lBTCSpBkCqHdszHuMSv7z
 zbPqG01gK8eyJdTka665lvAxTmro/AlUzII2+keZUr9hisRWWJvT9XABYTzhRqYELukcw==
IronPort-HdrOrdr: A9a23:XjNS7KNaemenOMBcTsajsMiBIKoaSvp037Dk7S9MoHtuA6ulfq
 +V/cjzuSWYtN9VYgBDpTniAtjlfZqjz/5ICOAqVN/INjUO+lHYSb2KhrGN/9SPIUHDH5ZmpM
 Rdm2wUMqyIMbC85vyKhjWFLw==
X-Talos-CUID: =?us-ascii?q?9a23=3AHASmBGutKlm5jDqtN7rdIQy36Is1eEby5nfiKnP?=
 =?us-ascii?q?mEE82UKOKVG+ro4J7xp8=3D?=
X-Talos-MUID: 9a23:DUuD+gXEJFxN3gbq/G7cxxJea5Y52YWFOlpVnZddgsrZGyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,262,1732579200"; 
   d="scan'208";a="315534148"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Feb 2025 23:54:30 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTP id 54E8E18000274;
	Wed,  5 Feb 2025 23:54:30 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 2A07F20F2003; Wed,  5 Feb 2025 15:54:30 -0800 (PST)
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
Subject: [PATCH net-next v8 1/4] enic: Move RX functions to their own file
Date: Wed,  5 Feb 2025 15:54:13 -0800
Message-Id: <20250205235416.25410-2-johndale@cisco.com>
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
X-Outbound-Node: rcdn-l-core-10.cisco.com

Move RX handler code into its own file in preparation for further
changes. Some formatting changes were necessary in order to satisfy
checkpatch but there were no functional changes.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Makefile    |   2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c | 238 +------------------
 drivers/net/ethernet/cisco/enic/enic_rq.c   | 242 ++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h   |  10 +
 4 files changed, 254 insertions(+), 238 deletions(-)
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.h

diff --git a/drivers/net/ethernet/cisco/enic/Makefile b/drivers/net/ethernet/cisco/enic/Makefile
index c3b6febfdbe4..b3b5196b2dfc 100644
--- a/drivers/net/ethernet/cisco/enic/Makefile
+++ b/drivers/net/ethernet/cisco/enic/Makefile
@@ -3,5 +3,5 @@ obj-$(CONFIG_ENIC) := enic.o
 
 enic-y := enic_main.o vnic_cq.o vnic_intr.o vnic_wq.o \
 	enic_res.o enic_dev.o enic_pp.o vnic_dev.o vnic_rq.o vnic_vic.o \
-	enic_ethtool.o enic_api.o enic_clsf.o
+	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 49f6cab01ed5..1d9f109346b8 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -58,6 +58,7 @@
 #include "enic_dev.h"
 #include "enic_pp.h"
 #include "enic_clsf.h"
+#include "enic_rq.h"
 
 #define ENIC_NOTIFY_TIMER_PERIOD	(2 * HZ)
 #define WQ_ENET_MAX_DESC_LEN		(1 << WQ_ENET_LEN_BITS)
@@ -1313,243 +1314,6 @@ static int enic_get_vf_port(struct net_device *netdev, int vf,
 	return -EMSGSIZE;
 }
 
-static void enic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf)
-{
-	struct enic *enic = vnic_dev_priv(rq->vdev);
-
-	if (!buf->os_buf)
-		return;
-
-	dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
-			 DMA_FROM_DEVICE);
-	dev_kfree_skb_any(buf->os_buf);
-	buf->os_buf = NULL;
-}
-
-static int enic_rq_alloc_buf(struct vnic_rq *rq)
-{
-	struct enic *enic = vnic_dev_priv(rq->vdev);
-	struct net_device *netdev = enic->netdev;
-	struct sk_buff *skb;
-	unsigned int len = netdev->mtu + VLAN_ETH_HLEN;
-	unsigned int os_buf_index = 0;
-	dma_addr_t dma_addr;
-	struct vnic_rq_buf *buf = rq->to_use;
-
-	if (buf->os_buf) {
-		enic_queue_rq_desc(rq, buf->os_buf, os_buf_index, buf->dma_addr,
-				   buf->len);
-
-		return 0;
-	}
-	skb = netdev_alloc_skb_ip_align(netdev, len);
-	if (!skb) {
-		enic->rq[rq->index].stats.no_skb++;
-		return -ENOMEM;
-	}
-
-	dma_addr = dma_map_single(&enic->pdev->dev, skb->data, len,
-				  DMA_FROM_DEVICE);
-	if (unlikely(enic_dma_map_check(enic, dma_addr))) {
-		dev_kfree_skb(skb);
-		return -ENOMEM;
-	}
-
-	enic_queue_rq_desc(rq, skb, os_buf_index,
-		dma_addr, len);
-
-	return 0;
-}
-
-static void enic_intr_update_pkt_size(struct vnic_rx_bytes_counter *pkt_size,
-				      u32 pkt_len)
-{
-	if (ENIC_LARGE_PKT_THRESHOLD <= pkt_len)
-		pkt_size->large_pkt_bytes_cnt += pkt_len;
-	else
-		pkt_size->small_pkt_bytes_cnt += pkt_len;
-}
-
-static bool enic_rxcopybreak(struct net_device *netdev, struct sk_buff **skb,
-			     struct vnic_rq_buf *buf, u16 len)
-{
-	struct enic *enic = netdev_priv(netdev);
-	struct sk_buff *new_skb;
-
-	if (len > enic->rx_copybreak)
-		return false;
-	new_skb = netdev_alloc_skb_ip_align(netdev, len);
-	if (!new_skb)
-		return false;
-	dma_sync_single_for_cpu(&enic->pdev->dev, buf->dma_addr, len,
-				DMA_FROM_DEVICE);
-	memcpy(new_skb->data, (*skb)->data, len);
-	*skb = new_skb;
-
-	return true;
-}
-
-static void enic_rq_indicate_buf(struct vnic_rq *rq,
-	struct cq_desc *cq_desc, struct vnic_rq_buf *buf,
-	int skipped, void *opaque)
-{
-	struct enic *enic = vnic_dev_priv(rq->vdev);
-	struct net_device *netdev = enic->netdev;
-	struct sk_buff *skb;
-	struct vnic_cq *cq = &enic->cq[enic_cq_rq(enic, rq->index)];
-	struct enic_rq_stats *rqstats = &enic->rq[rq->index].stats;
-
-	u8 type, color, eop, sop, ingress_port, vlan_stripped;
-	u8 fcoe, fcoe_sof, fcoe_fc_crc_ok, fcoe_enc_error, fcoe_eof;
-	u8 tcp_udp_csum_ok, udp, tcp, ipv4_csum_ok;
-	u8 ipv6, ipv4, ipv4_fragment, fcs_ok, rss_type, csum_not_calc;
-	u8 packet_error;
-	u16 q_number, completed_index, bytes_written, vlan_tci, checksum;
-	u32 rss_hash;
-	bool outer_csum_ok = true, encap = false;
-
-	rqstats->packets++;
-	if (skipped) {
-		rqstats->desc_skip++;
-		return;
-	}
-
-	skb = buf->os_buf;
-
-	cq_enet_rq_desc_dec((struct cq_enet_rq_desc *)cq_desc,
-		&type, &color, &q_number, &completed_index,
-		&ingress_port, &fcoe, &eop, &sop, &rss_type,
-		&csum_not_calc, &rss_hash, &bytes_written,
-		&packet_error, &vlan_stripped, &vlan_tci, &checksum,
-		&fcoe_sof, &fcoe_fc_crc_ok, &fcoe_enc_error,
-		&fcoe_eof, &tcp_udp_csum_ok, &udp, &tcp,
-		&ipv4_csum_ok, &ipv6, &ipv4, &ipv4_fragment,
-		&fcs_ok);
-
-	if (packet_error) {
-
-		if (!fcs_ok) {
-			if (bytes_written > 0)
-				rqstats->bad_fcs++;
-			else if (bytes_written == 0)
-				rqstats->pkt_truncated++;
-		}
-
-		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
-				 DMA_FROM_DEVICE);
-		dev_kfree_skb_any(skb);
-		buf->os_buf = NULL;
-
-		return;
-	}
-
-	if (eop && bytes_written > 0) {
-
-		/* Good receive
-		 */
-		rqstats->bytes += bytes_written;
-		if (!enic_rxcopybreak(netdev, &skb, buf, bytes_written)) {
-			buf->os_buf = NULL;
-			dma_unmap_single(&enic->pdev->dev, buf->dma_addr,
-					 buf->len, DMA_FROM_DEVICE);
-		}
-		prefetch(skb->data - NET_IP_ALIGN);
-
-		skb_put(skb, bytes_written);
-		skb->protocol = eth_type_trans(skb, netdev);
-		skb_record_rx_queue(skb, q_number);
-		if ((netdev->features & NETIF_F_RXHASH) && rss_hash &&
-		    (type == 3)) {
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
-				if ((type == 7) &&
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
-		skb_mark_napi_id(skb, &enic->napi[rq->index]);
-		if (!(netdev->features & NETIF_F_GRO))
-			netif_receive_skb(skb);
-		else
-			napi_gro_receive(&enic->napi[q_number], skb);
-		if (enic->rx_coalesce_setting.use_adaptive_rx_coalesce)
-			enic_intr_update_pkt_size(&cq->pkt_size_counter,
-						  bytes_written);
-	} else {
-
-		/* Buffer overflow
-		 */
-		rqstats->pkt_truncated++;
-		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
-				 DMA_FROM_DEVICE);
-		dev_kfree_skb_any(skb);
-		buf->os_buf = NULL;
-	}
-}
-
-static int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
-	u8 type, u16 q_number, u16 completed_index, void *opaque)
-{
-	struct enic *enic = vnic_dev_priv(vdev);
-
-	vnic_rq_service(&enic->rq[q_number].vrq, cq_desc,
-		completed_index, VNIC_RQ_RETURN_DESC,
-		enic_rq_indicate_buf, opaque);
-
-	return 0;
-}
-
 static void enic_set_int_moderation(struct enic *enic, struct vnic_rq *rq)
 {
 	unsigned int intr = enic_msix_rq_intr(enic, rq->index);
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
new file mode 100644
index 000000000000..e5b2f581c055
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2024 Cisco Systems, Inc.  All rights reserved.
+
+#include <linux/skbuff.h>
+#include <linux/if_vlan.h>
+#include <net/busy_poll.h>
+#include "enic.h"
+#include "enic_res.h"
+#include "enic_rq.h"
+#include "vnic_rq.h"
+#include "cq_enet_desc.h"
+
+#define ENIC_LARGE_PKT_THRESHOLD                1000
+
+static void enic_intr_update_pkt_size(struct vnic_rx_bytes_counter *pkt_size,
+				      u32 pkt_len)
+{
+	if (pkt_len > ENIC_LARGE_PKT_THRESHOLD)
+		pkt_size->large_pkt_bytes_cnt += pkt_len;
+	else
+		pkt_size->small_pkt_bytes_cnt += pkt_len;
+}
+
+static bool enic_rxcopybreak(struct net_device *netdev, struct sk_buff **skb,
+			     struct vnic_rq_buf *buf, u16 len)
+{
+	struct enic *enic = netdev_priv(netdev);
+	struct sk_buff *new_skb;
+
+	if (len > enic->rx_copybreak)
+		return false;
+	new_skb = netdev_alloc_skb_ip_align(netdev, len);
+	if (!new_skb)
+		return false;
+	dma_sync_single_for_cpu(&enic->pdev->dev, buf->dma_addr, len,
+				DMA_FROM_DEVICE);
+	memcpy(new_skb->data, (*skb)->data, len);
+	*skb = new_skb;
+
+	return true;
+}
+
+int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
+		    u16 q_number, u16 completed_index, void *opaque)
+{
+	struct enic *enic = vnic_dev_priv(vdev);
+
+	vnic_rq_service(&enic->rq[q_number].vrq, cq_desc, completed_index,
+			VNIC_RQ_RETURN_DESC, enic_rq_indicate_buf, opaque);
+	return 0;
+}
+
+int enic_rq_alloc_buf(struct vnic_rq *rq)
+{
+	struct enic *enic = vnic_dev_priv(rq->vdev);
+	struct net_device *netdev = enic->netdev;
+	struct sk_buff *skb;
+	unsigned int len = netdev->mtu + VLAN_ETH_HLEN;
+	unsigned int os_buf_index = 0;
+	dma_addr_t dma_addr;
+	struct vnic_rq_buf *buf = rq->to_use;
+
+	if (buf->os_buf) {
+		enic_queue_rq_desc(rq, buf->os_buf, os_buf_index, buf->dma_addr,
+				   buf->len);
+
+		return 0;
+	}
+	skb = netdev_alloc_skb_ip_align(netdev, len);
+	if (!skb) {
+		enic->rq[rq->index].stats.no_skb++;
+		return -ENOMEM;
+	}
+
+	dma_addr = dma_map_single(&enic->pdev->dev, skb->data, len,
+				  DMA_FROM_DEVICE);
+	if (unlikely(enic_dma_map_check(enic, dma_addr))) {
+		dev_kfree_skb(skb);
+		return -ENOMEM;
+	}
+
+	enic_queue_rq_desc(rq, skb, os_buf_index, dma_addr, len);
+
+	return 0;
+}
+
+void enic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf)
+{
+	struct enic *enic = vnic_dev_priv(rq->vdev);
+
+	if (!buf->os_buf)
+		return;
+
+	dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
+			 DMA_FROM_DEVICE);
+	dev_kfree_skb_any(buf->os_buf);
+	buf->os_buf = NULL;
+}
+
+void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
+			  struct vnic_rq_buf *buf, int skipped, void *opaque)
+{
+	struct enic *enic = vnic_dev_priv(rq->vdev);
+	struct net_device *netdev = enic->netdev;
+	struct sk_buff *skb;
+	struct vnic_cq *cq = &enic->cq[enic_cq_rq(enic, rq->index)];
+	struct enic_rq_stats *rqstats = &enic->rq[rq->index].stats;
+
+	u8 type, color, eop, sop, ingress_port, vlan_stripped;
+	u8 fcoe, fcoe_sof, fcoe_fc_crc_ok, fcoe_enc_error, fcoe_eof;
+	u8 tcp_udp_csum_ok, udp, tcp, ipv4_csum_ok;
+	u8 ipv6, ipv4, ipv4_fragment, fcs_ok, rss_type, csum_not_calc;
+	u8 packet_error;
+	u16 q_number, completed_index, bytes_written, vlan_tci, checksum;
+	u32 rss_hash;
+	bool outer_csum_ok = true, encap = false;
+
+	rqstats->packets++;
+	if (skipped) {
+		rqstats->desc_skip++;
+		return;
+	}
+
+	skb = buf->os_buf;
+
+	cq_enet_rq_desc_dec((struct cq_enet_rq_desc *)cq_desc, &type, &color,
+			    &q_number, &completed_index, &ingress_port, &fcoe,
+			    &eop, &sop, &rss_type, &csum_not_calc, &rss_hash,
+			    &bytes_written, &packet_error, &vlan_stripped,
+			    &vlan_tci, &checksum, &fcoe_sof, &fcoe_fc_crc_ok,
+			    &fcoe_enc_error, &fcoe_eof, &tcp_udp_csum_ok, &udp,
+			    &tcp, &ipv4_csum_ok, &ipv6, &ipv4, &ipv4_fragment,
+			    &fcs_ok);
+
+	if (packet_error) {
+		if (!fcs_ok) {
+			if (bytes_written > 0)
+				rqstats->bad_fcs++;
+			else if (bytes_written == 0)
+				rqstats->pkt_truncated++;
+		}
+
+		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
+				 DMA_FROM_DEVICE);
+		dev_kfree_skb_any(skb);
+		buf->os_buf = NULL;
+
+		return;
+	}
+
+	if (eop && bytes_written > 0) {
+		/* Good receive
+		 */
+		rqstats->bytes += bytes_written;
+		if (!enic_rxcopybreak(netdev, &skb, buf, bytes_written)) {
+			buf->os_buf = NULL;
+			dma_unmap_single(&enic->pdev->dev, buf->dma_addr,
+					 buf->len, DMA_FROM_DEVICE);
+		}
+		prefetch(skb->data - NET_IP_ALIGN);
+
+		skb_put(skb, bytes_written);
+		skb->protocol = eth_type_trans(skb, netdev);
+		skb_record_rx_queue(skb, q_number);
+		if ((netdev->features & NETIF_F_RXHASH) && rss_hash &&
+		    type == 3) {
+			switch (rss_type) {
+			case CQ_ENET_RQ_DESC_RSS_TYPE_TCP_IPv4:
+			case CQ_ENET_RQ_DESC_RSS_TYPE_TCP_IPv6:
+			case CQ_ENET_RQ_DESC_RSS_TYPE_TCP_IPv6_EX:
+				skb_set_hash(skb, rss_hash, PKT_HASH_TYPE_L4);
+				rqstats->l4_rss_hash++;
+				break;
+			case CQ_ENET_RQ_DESC_RSS_TYPE_IPv4:
+			case CQ_ENET_RQ_DESC_RSS_TYPE_IPv6:
+			case CQ_ENET_RQ_DESC_RSS_TYPE_IPv6_EX:
+				skb_set_hash(skb, rss_hash, PKT_HASH_TYPE_L3);
+				rqstats->l3_rss_hash++;
+				break;
+			}
+		}
+		if (enic->vxlan.vxlan_udp_port_number) {
+			switch (enic->vxlan.patch_level) {
+			case 0:
+				if (fcoe) {
+					encap = true;
+					outer_csum_ok = fcoe_fc_crc_ok;
+				}
+				break;
+			case 2:
+				if (type == 7 &&
+				    (rss_hash & BIT(0))) {
+					encap = true;
+					outer_csum_ok = (rss_hash & BIT(1)) &&
+							(rss_hash & BIT(2));
+				}
+				break;
+			}
+		}
+
+		/* Hardware does not provide whole packet checksum. It only
+		 * provides pseudo checksum. Since hw validates the packet
+		 * checksum but not provide us the checksum value. use
+		 * CHECSUM_UNNECESSARY.
+		 *
+		 * In case of encap pkt tcp_udp_csum_ok/tcp_udp_csum_ok is
+		 * inner csum_ok. outer_csum_ok is set by hw when outer udp
+		 * csum is correct or is zero.
+		 */
+		if ((netdev->features & NETIF_F_RXCSUM) && !csum_not_calc &&
+		    tcp_udp_csum_ok && outer_csum_ok &&
+		    (ipv4_csum_ok || ipv6)) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+			skb->csum_level = encap;
+			if (encap)
+				rqstats->csum_unnecessary_encap++;
+			else
+				rqstats->csum_unnecessary++;
+		}
+
+		if (vlan_stripped) {
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
+			rqstats->vlan_stripped++;
+		}
+		skb_mark_napi_id(skb, &enic->napi[rq->index]);
+		if (!(netdev->features & NETIF_F_GRO))
+			netif_receive_skb(skb);
+		else
+			napi_gro_receive(&enic->napi[q_number], skb);
+		if (enic->rx_coalesce_setting.use_adaptive_rx_coalesce)
+			enic_intr_update_pkt_size(&cq->pkt_size_counter,
+						  bytes_written);
+	} else {
+		/* Buffer overflow
+		 */
+		rqstats->pkt_truncated++;
+		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
+				 DMA_FROM_DEVICE);
+		dev_kfree_skb_any(skb);
+		buf->os_buf = NULL;
+	}
+}
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.h b/drivers/net/ethernet/cisco/enic/enic_rq.h
new file mode 100644
index 000000000000..a75d07562686
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright 2024 Cisco Systems, Inc.  All rights reserved.
+ */
+
+int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
+		    u16 q_number, u16 completed_index, void *opaque);
+void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
+			  struct vnic_rq_buf *buf, int skipped, void *opaque);
+int enic_rq_alloc_buf(struct vnic_rq *rq);
+void enic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf);
-- 
2.44.0


