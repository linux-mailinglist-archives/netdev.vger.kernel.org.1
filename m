Return-Path: <netdev+bounces-159181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED569A14AA7
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE7C3A48A4
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622181F8699;
	Fri, 17 Jan 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Nr13cnWi"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EFA1F8692
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100973; cv=none; b=l9CH7qBYrjKAdQkxRGRwXqV0ruBuRwbFWYzVCDBqK9GRFs1P/VAIZOACYJJbgs8r6aLGETPzTa3LAYvcxYZyONQOJ0gphlxMn/QVMGrpzsdeuTBpwp0/2bMZqCpEBHcWtLO9McntIXPncIZx9UmeHQcVDeSPkwc6j0mXPq7vFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100973; c=relaxed/simple;
	bh=iMWsdHVznWqj+KClXxjcChTWvzzcv08gHonmv08w2zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwC5IvRhvac8Vx/c665ZthJlDpvLjXvXDOLgO7RCCiPeAuGabiWDU0snb6CMqQ7MW8mOUGMIffeV3ZZRwDlqg21hMg/kbyCH4tvw2844AMSNeyFsqJ7nXmLMaKChBVlgGHEFNU3gNTUhisd3kiu6mpr1pW5lfLYISad7wGCeoJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Nr13cnWi; arc=none smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=16411; q=dns/txt;
  s=iport; t=1737100971; x=1738310571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QCQHu2GGp4NryTQrJT79oIqwDqlQrdb7Tlsq1MFYl8M=;
  b=Nr13cnWiER953Zmcs3IzQRgH7Rtb+dk9U8d/raZcEkNbhik3T8r8eZ13
   vtxWvIhqD0zHunUNFE/XUBBfAVk+vuKVsoqDagvrr1AS016oqodZObnwY
   4XFkOD2nTTUV3k2iD9u9Cc8kP/u8TmNUWfIbeKE6me9P/jTIDTii86tEi
   E=;
X-CSE-ConnectionGUID: 3MsHst1qQxewd5yVJY9Pyg==
X-CSE-MsgGUID: yNtNTvEmSCmCHuWznaoinQ==
X-IPAS-Result: =?us-ascii?q?A0AtAADmDIpn/5T/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkqBT0NIjHJfiHOeGxSBEQNWDwEBAQ9EBAEBhQcCinMCJjQJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGWwIBAycLAUYQU?=
 =?us-ascii?q?SsrBxKDAYJlA7MfgXkzgQHeM4FtgUgBhWqHX3CEdycbgUlEgRWBO4E+b4QGh?=
 =?us-ascii?q?l8iBIdlnzJIgSEDWSwBVRMNCgsHBYE5OAMiCwsMCxQcFQIVHQ8GEARtRDeCR?=
 =?us-ascii?q?mlJNwINAjWCHiRYgiuEXIRFhFGCR1SCR4IUeoEahG9AAwsYDUgRLDcGDhsGP?=
 =?us-ascii?q?m4Hm1M8g2wHgQ4BG4FqDpN9kh+hA4QlgWOfYxozqlOYfCKkJYRmgWc8gVkzG?=
 =?us-ascii?q?ggbFYMiUhkPjioDFsFCJTI8AgcLAQEDCY9jLYFOAQE?=
IronPort-Data: A9a23:RSqtqKhpR+3pp1ntcezrFVkeX161QhEKZh0ujC45NGQN5FlHY01je
 htvWmGCOv6MYWKmKYsiPYWxp0sFu5LXnIRiGQBoryA8FC9jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSEULOZ82QsaD9Msvvc8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqVD3/1XGn0X7
 MUIJS8BMwG9pdPn+KO0H7wEasQLdKEHPasFsX1miDWcBvE8TNWaGuPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgd/5JEWxI9EglH9dD1epFuRqII84nPYy0p6172F3N/9IYTVGpoIzhbAz
 o7A13XfHjcmKvGa8hGA2VKxuf3JlCT6XrtHQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVUBq/r3qJ+BUbXrJ4EPAw4SmOx7DS7gLfAXILJhZIbtA8udB1QzE22
 lKXt9f0Azopu739YWqU/LqSrBuoNCQVJHNEbigBJSMD7sXvrZ8bkB3CVJBgHbSzg9mzHiv/q
 w1mtwAkjLkVyMpO3KKh8BWe2nSnp4PCSUg+4QC/sn+Z0z6VrbWNP+SAgWU3J94ZRGpFZjFtZ
 EQ5pvU=
IronPort-HdrOrdr: A9a23:eULQgq+6lQhyyO6hW1duk+DfI+orL9Y04lQ7vn2ZhyY7TiX+rb
 HIoB11737JYVoqNU3I3OrwWpVoIkmskaKdn7NwAV7KZmCP0wGVxcNZnO7fKlbbdREWmNQw6U
 4ZSdkcNDU1ZmIK9PoTJ2KDYrAd/OU=
X-Talos-CUID: 9a23:BIB0eW9DELYmfyZbhM6VvxUxAeA+biTE9WfdPEPlGFhLeeytWFDFrQ==
X-Talos-MUID: 9a23:dAq9cAqu+FjVLgGXN1MezyBEKOFU/YmrM2sIurUbhNuCPCtxPQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,211,1732579200"; 
   d="scan'208";a="307775880"
Received: from rcdn-l-core-11.cisco.com ([173.37.255.148])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Jan 2025 08:01:41 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-11.cisco.com (Postfix) with ESMTP id D15F118000254;
	Fri, 17 Jan 2025 08:01:41 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id AAEED20F2004; Fri, 17 Jan 2025 00:01:41 -0800 (PST)
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
Subject: [PATCH net-next v6 1/3] enic: Move RX functions to their own file
Date: Fri, 17 Jan 2025 00:01:37 -0800
Message-Id: <20250117080139.28018-2-johndale@cisco.com>
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
X-Outbound-Node: rcdn-l-core-11.cisco.com

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
index 9913952ccb42..23176e2563d3 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -58,6 +58,7 @@
 #include "enic_dev.h"
 #include "enic_pp.h"
 #include "enic_clsf.h"
+#include "enic_rq.h"
 
 #define ENIC_NOTIFY_TIMER_PERIOD	(2 * HZ)
 #define WQ_ENET_MAX_DESC_LEN		(1 << WQ_ENET_LEN_BITS)
@@ -1282,243 +1283,6 @@ static int enic_get_vf_port(struct net_device *netdev, int vf,
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
2.35.2


