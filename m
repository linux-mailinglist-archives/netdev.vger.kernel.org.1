Return-Path: <netdev+bounces-159654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C67A163C9
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 21:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9361885560
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 20:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734571DFD8E;
	Sun, 19 Jan 2025 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="WlfL45AF"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E761DF99B
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737316895; cv=none; b=VA22hDpg0Fz6OlhLnMCW8Oe3l5cMXDQxgGWjS8JlWMp32Cd9noXnKab+ygIvDKdCraiBD3tyaonnxmnjsxcSj1jht1ReQmD/6RKhEn2JSPbmvtKY+6UA1Jdk2cU85fiTaVMy73TEGbMsF/Kw5wAJUXz5Ip9iriyDP/w/g+13Dio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737316895; c=relaxed/simple;
	bh=Fd+FspXPbbqXlhJ6ZsUiWgJxOFRAOSSxdsE5KMn7qOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXnhVHidb40ArW2w78FNGZ5IuBjdahD2f6ksdRQSkkUVa0x+bSinesJTO43l9k6wquKd7ULlVcsSXZ7QlCxioFf1RqkGBluKFTOHKq/bnVEEoYlEtLSzNanidiAGCXVQsrnIb+WH8dL7MbpzuFNc3sVobYyIfl+tY3fj//kG25c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=WlfL45AF; arc=none smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=16329; q=dns/txt;
  s=iport; t=1737316893; x=1738526493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0gsX97fJ7vgvrpr1OLCNUsS+cYVQr0nJZypHSvyjYE=;
  b=WlfL45AF+pkkIdxDhGeDGz6KH3zqXZgMF1mDT2tdV9vfAfAhvhksR6Ux
   mb1ytvkqS9hHcCrV0BbZgRK5G3+SwMhIJzIFc/HMM040KreOKsZDYdj+6
   S2kpTPlMQbUPgc5iUxso883PA0vbWhCn2GXHKYh9aYN9CihPd75cV7CGv
   U=;
X-CSE-ConnectionGUID: 3igE5TEvRgKXpKus1d6Fgw==
X-CSE-MsgGUID: daJgnqMIQcSRocbV2dPbQw==
X-IPAS-Result: =?us-ascii?q?A0ANAAAUWY1n/4//Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBgkqBT0NIjHJfiHOeGxSBEQNWDwEBAQ9EBAEBhQcCinMCJ?=
 =?us-ascii?q?jQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGWwIBA?=
 =?us-ascii?q?ycLAUYQUSsrBxKDAYJlA7R+gXkzgQHeM4FtgUgBhWqHX3CEdycbgUlEgRWBO?=
 =?us-ascii?q?4E+b4QGhl8iBIIyhTOfUkiBIQNZLAFVEw0KCwcFgTk4AyILCwwLFBwVAhUdD?=
 =?us-ascii?q?wYQBG1EN4JGaUk3Ag0CNYIeJFiCK4RahEWEU4JDVIJFghR6gRyFEEADCxgNS?=
 =?us-ascii?q?BEsNwYOGwY+bgebZTyDbweBDgEbgWoOk32SH4tylRGEJYFjn2MaM6pTmHwip?=
 =?us-ascii?q?CWEZoFnPIFZMxoIGxWDIlIZD44qAxbCVyUyPAIHCwEBAwmPai2BTgEB?=
IronPort-Data: A9a23:rKEVFqy9b687Ztup7Yt6t+cVxyrEfRIJ4+MujC+fZmUNrF6WrkUFm
 zMXCjiCOvuKZWHxKN51Ydi18hwPvcLQx9NhSwtk+VhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/lH1b+CJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 IiaT/H3Ygf/hmYtazNMscpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJBo3MqBFxstpO25tx
 eQ7NStUYk6tiP3jldpXSsE07igiBNPgMIVavjRryivUSK54B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2cOHWjOX9PYH46tOWvhn/zejlVgFmUvqEwpWPUyWSd1ZC2aIqMJ4zWGJQ9ckCwq
 mvk8GLgJzAjP+elzjGPzCigvuX2gnauMG4VPPjinhJwu3Wfz3IeDTUaXEW2pP2+hFL4Xd9DQ
 2QZ9jcrpLo/6GSkSd7yWxD+q3mB1jYfRtBZO+438geAzuzT+QnxLmECQiRMd58gudM6SCIC0
 kKPmZXiBVRHqLSfRHSc3q2ZoTO7JW4eKmpqTSkJUQcI/fH9r4wpyBHCVNBuFOiylNKdJN3r6
 yqBoC57g/AYitQGkv3lu1vGmDmr4JPOS2bZ+znqY45s1SshDKbNWmBiwQGzASpoRGpBcmS8g
 Q==
IronPort-HdrOrdr: A9a23:Jh98BKon5hh6VRmHgj+n6EwaV5oseYIsimQD101hICG9vPb2qy
 nIpoV96faaslcssR0b9OxofZPwI080lqQFhbX5Q43DYOCOggLBR+tfBMnZsljd8kbFmNK1u5
 0NT0EHMqySMbC/5vyKmTVR1L0bsb+6zJw=
X-Talos-CUID: 9a23:TmVfdG/f8MYs7R+BuAiVvxUVFe14TlDD9njzE1ebFH0wROO7RkDFrQ==
X-Talos-MUID: 9a23:A3hKfASsGxCPXYkURXTgjRNtMt5Nwp2lM3oKmp844cW8PxVvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,218,1732579200"; 
   d="scan'208";a="308158459"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jan 2025 20:00:31 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTP id E9AE918000251;
	Sun, 19 Jan 2025 20:00:30 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id C41A920F2003; Sun, 19 Jan 2025 12:00:30 -0800 (PST)
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
Subject: [PATCH net-next v7 1/3] enic: Move RX functions to their own file
Date: Sun, 19 Jan 2025 12:00:16 -0800
Message-Id: <20250119200018.5522-2-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250119200018.5522-1-johndale@cisco.com>
References: <20250119200018.5522-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-06.cisco.com

Move RX handler code into it's own file in preparation for
further changes.

No functional changes.

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
2.39.3


