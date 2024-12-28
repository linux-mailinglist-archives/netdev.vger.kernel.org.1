Return-Path: <netdev+bounces-154402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7069FD85F
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 01:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1671885740
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 00:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE38C1E;
	Sat, 28 Dec 2024 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="AF6R0ur3"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB0A94D
	for <netdev@vger.kernel.org>; Sat, 28 Dec 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735344666; cv=none; b=YTEDtOPhQbbFvNqOdgDdc3SO8zFFng9i/NWDw4BoSxF9qIzmVIX8nAqvxt4VMd9G3BhAZDQ7TewvGymQiaUaWeQnt6e2smPqHrhwO4E8PNkopdIVQbHzXMZwVrhcJTOu+VRO34wFJ1uHUpzPEPl9GjVitgub7eKwGWVtC3phDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735344666; c=relaxed/simple;
	bh=G18Lp5NB/377r4ZItaiEwYiT0g8v5rQu0qz7CTBWzdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NTPbqw7K0t01F1UMYQH5Plg/cwUQJRa5VKNPzxr3B9VLbG5xy6P+lic4XPrmY/N8B5dyX7zvWR7rMWWMoE5h4peAtjlhlHdf4S+Rwcex9byfwHIUANvK3ke1wmEs8HQ6VGxLit0Bk3BfH6Gmni4aLGeR2egMVMyAoq5J1qfxtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=AF6R0ur3; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11381; q=dns/txt;
  s=iport; t=1735344664; x=1736554264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6UMZSEFMCqsQvKnMVoSaYcfhydkuEqOPZPpeuzYbpks=;
  b=AF6R0ur3aSYVciTriAvTO9PFEXSFw3UTuBUgBp+8z91rmqXSWtynqNH7
   9RupbBlORsSaDZfROY2Hd3/Uf50d6YwewOG3L6M9iujnV68MgeJ18+mn7
   WWIGQz+0xU51np9MZVFUMeYpbrv3Z+xn+VCBbuT3eSrnbta9Am0ei21do
   U=;
X-CSE-ConnectionGUID: qhXzy62DQA298Jq/gp4khw==
X-CSE-MsgGUID: w6MGrjiVRhyYTHYtU/PKrw==
X-IPAS-Result: =?us-ascii?q?A0ATAADJQG9nj4v/Ja1aHQEBAQEJARIBBQUBgX8IAQsBh?=
 =?us-ascii?q?BlDSIxyX4hynhsUgREDVg8BAQEPRAQBAYUHAopuAiY0CQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEHBRQBAQEBAQE5BQ47hgiGWwIBAycLAUYQU?=
 =?us-ascii?q?SsrBxKDAYJlA7E5gXkzgQHeM4FtgUgBhWqHX3CEdycbgUlEgRWBO4E+b4QGh?=
 =?us-ascii?q?wEEiRWeckiBIQNZLAFVEw0KCwcFgTk6AyIMCwwLFBwVAoEegQEBFAYVBIELR?=
 =?us-ascii?q?T2CSmlJNwINAjaCICRYgk2FF4RehFaCSVWCe4IXfIEagiVAAwsYDUgRLDcGD?=
 =?us-ascii?q?hsGPm4HnF9Gg2wHgQ4BggUOVZMokh+hA4QkgWOfYxozqlKYfCKkJIRmgWc6g?=
 =?us-ascii?q?VszGggbFYMiUhkPiFyFUQ0JtSAlMjwCBwsBAQMJjzgtgU4BAQ?=
IronPort-Data: A9a23:0m70oKkmf01G0heCn9rcEOfo5gxlJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJJDGDTPqmPNGryKdh1Yd6yox4BuJXdn4UyHlBvqX00FltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pe31GONgWYubjtOsf3b9HuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FZQYyvRmXztiz
 NVCeWAvd1eMn761wK3uH4GAhux7RCXqFJkUtnclyXTSCuwrBMiZBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQUaz/7C7pm9Ausrnv4cztUoVaYjaE2+GPUigd21dABNfKJIoLTGZ8LzhzwS
 mTu4DrcLQsYNeKlySu0zlKdmtKIpQDhR9dHfFG/3qU32ALInDN75ActfVeyv/S8okK3Rd9aL
 0sa5mwooLRa3EGnU9z0TRCkiHGDuREYVpxbFOhSwAKQwKP84AuDAGUACDlbZ7QOvck6XzE1l
 VmEg9/kGxRrrbuTD3mdnp+MpDm/Pyk9N2IOZSYYCwAC5rHLpowvgh/RZshsHbTzjdDvHzz0h
 TeQo0ADa647l8UH0eC/uFvAmT/p/sKPRQ8u7QKRVWWghu9kWGK7T5Wo2UrKs6xsFa/DHwmjp
 T8Lg5Sd7P9bWPlhixexaOkKGbio4dOMPzvdnUNjEvEdG9KFpSXLkWd4vm0WGat5DvvobwMFd
 6M6hO+w2HOxFCbwBUOUS9vtYyjP8UQGPYi/PhwzRoESCqWdjCfdoElTibe4hggBanQEn6AlI
 ou8es2xF3scAqkP5GPpHLpHiuB7l3tvmDu7qXXHI/KPj+P2iJm9FOdtDbdyRrpihE95iFyPq
 o8EZpHiJ+t3DbKiPXW/HXEvwaAidiVjWsus9KS7h8aIIxFtHyk6GuTNzLY6M41jlOI9qws71
 i/VZ6Os83Km3SevAVzTMhhLMeqzNb4h9ihTFXJ3Yj6VN40LPd3HAFE3K8BvJeFPGS0K5aIcc
 sTpjO3ZUq4RF22Zom1CBXQ/xaQ7HCmWacu1F3LNSFACk1RIG2QlJveMktPTyRQz
IronPort-HdrOrdr: A9a23:A9ga8KCIJ2E0yaXlHemr55DYdb4zR+YMi2TDGXofdfUzSL3+qy
 nAppUmPHPP5Qr5HUtQ++xoW5PwJU80i6QU3WB5B97LN2PbUSmTXeRfBODZrQEIdReTygck79
 YCT0C7Y+eAdGSTSq3BkW+FL+o=
X-Talos-CUID: =?us-ascii?q?9a23=3A4iGZH2r2tC85Enx3LTlOF9fmUdklQm/Mki38Gmb?=
 =?us-ascii?q?iWDZLUfqaUQOT+Lwxxg=3D=3D?=
X-Talos-MUID: 9a23:6gw+8Aq+291Yx+5vlI0ezy48Eehy4aWQMkAcoKkmitW5chRTISjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,269,1728950400"; 
   d="scan'208";a="406142682"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Dec 2024 00:10:57 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTP id 9BD2018000237;
	Sat, 28 Dec 2024 00:10:57 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 757DD20F2004; Fri, 27 Dec 2024 16:10:57 -0800 (PST)
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
Subject: [PATCH net-next v3 1/6] enic: Refactor RX path common code into helper functions
Date: Fri, 27 Dec 2024 16:10:50 -0800
Message-Id: <20241228001055.12707-2-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241228001055.12707-1-johndale@cisco.com>
References: <20241228001055.12707-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-02.cisco.com

In order to more easily support future packet receive processing schemes
and to simplify the receive path, put common code into helper functions
in a separate file.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Makefile    |   2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c | 100 ++--------------
 drivers/net/ethernet/cisco/enic/enic_rq.c   | 120 ++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h   |  22 ++++
 4 files changed, 150 insertions(+), 94 deletions(-)
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
index 9913952ccb42..33890e26b8e5 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -55,6 +55,7 @@
 #include "vnic_vic.h"
 #include "enic_res.h"
 #include "enic.h"
+#include "enic_rq.h"
 #include "enic_dev.h"
 #include "enic_pp.h"
 #include "enic_clsf.h"
@@ -83,7 +84,6 @@ MODULE_AUTHOR("Scott Feldman <scofeldm@cisco.com>");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, enic_id_table);
 
-#define ENIC_LARGE_PKT_THRESHOLD		1000
 #define ENIC_MAX_COALESCE_TIMERS		10
 /*  Interrupt moderation table, which will be used to decide the
  *  coalescing timer values
@@ -1330,15 +1330,6 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
 	return 0;
 }
 
-static void enic_intr_update_pkt_size(struct vnic_rx_bytes_counter *pkt_size,
-				      u32 pkt_len)
-{
-	if (ENIC_LARGE_PKT_THRESHOLD <= pkt_len)
-		pkt_size->large_pkt_bytes_cnt += pkt_len;
-	else
-		pkt_size->small_pkt_bytes_cnt += pkt_len;
-}
-
 static bool enic_rxcopybreak(struct net_device *netdev, struct sk_buff **skb,
 			     struct vnic_rq_buf *buf, u16 len)
 {
@@ -1358,9 +1349,8 @@ static bool enic_rxcopybreak(struct net_device *netdev, struct sk_buff **skb,
 	return true;
 }
 
-static void enic_rq_indicate_buf(struct vnic_rq *rq,
-	struct cq_desc *cq_desc, struct vnic_rq_buf *buf,
-	int skipped, void *opaque)
+void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
+			  struct vnic_rq_buf *buf, int skipped, void *opaque)
 {
 	struct enic *enic = vnic_dev_priv(rq->vdev);
 	struct net_device *netdev = enic->netdev;
@@ -1375,7 +1365,6 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 	u8 packet_error;
 	u16 q_number, completed_index, bytes_written, vlan_tci, checksum;
 	u32 rss_hash;
-	bool outer_csum_ok = true, encap = false;
 
 	rqstats->packets++;
 	if (skipped) {
@@ -1395,15 +1384,7 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 		&ipv4_csum_ok, &ipv6, &ipv4, &ipv4_fragment,
 		&fcs_ok);
 
-	if (packet_error) {
-
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
@@ -1427,66 +1408,11 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 		skb_put(skb, bytes_written);
 		skb->protocol = eth_type_trans(skb, netdev);
 		skb_record_rx_queue(skb, q_number);
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
+		enic_rq_set_skb_flags(rq, type, rss_hash, rss_type, fcoe, fcoe_fc_crc_ok,
+				      vlan_stripped, csum_not_calc, tcp_udp_csum_ok, ipv6,
+				      ipv4_csum_ok, vlan_tci, skb);
 
-		if (vlan_stripped) {
-			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
-			rqstats->vlan_stripped++;
-		}
 		skb_mark_napi_id(skb, &enic->napi[rq->index]);
 		if (!(netdev->features & NETIF_F_GRO))
 			netif_receive_skb(skb);
@@ -1507,18 +1433,6 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 	}
 }
 
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
index 000000000000..571af8f31470
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2024 Cisco Systems, Inc.  All rights reserved.
+
+#include <linux/skbuff.h>
+#include <linux/if_vlan.h>
+#include "enic.h"
+#include "enic_rq.h"
+#include "vnic_rq.h"
+#include "cq_enet_desc.h"
+
+#define ENIC_LARGE_PKT_THRESHOLD		1000
+
+void enic_intr_update_pkt_size(struct vnic_rx_bytes_counter *pkt_size,
+			       u32 pkt_len)
+{
+	if (pkt_len >= ENIC_LARGE_PKT_THRESHOLD)
+		pkt_size->large_pkt_bytes_cnt += pkt_len;
+	else
+		pkt_size->small_pkt_bytes_cnt += pkt_len;
+}
+
+void enic_rq_set_skb_flags(struct vnic_rq *vrq, u8 type, u32 rss_hash, u8 rss_type, u8 fcoe,
+			   u8 fcoe_fc_crc_ok, u8 vlan_stripped, u8 csum_not_calc,
+			   u8 tcp_udp_csum_ok, u8 ipv6, u8 ipv4_csum_ok, u16 vlan_tci,
+			   struct sk_buff *skb)
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
+int enic_rq_pkt_error(struct vnic_rq *vrq, u8 packet_error, u8 fcs_ok, u16 bytes_written)
+{
+	struct enic *enic = vnic_dev_priv(vrq->vdev);
+	struct enic_rq_stats *rqstats = &enic->rq[vrq->index].stats;
+	int ret = 0;
+
+	if (packet_error) {
+		if (!fcs_ok) {
+			if (bytes_written > 0) {
+				rqstats->bad_fcs++;
+				ret = 1;
+			} else if (bytes_written == 0) {
+				rqstats->pkt_truncated++;
+				ret = 2;
+			}
+		}
+	}
+	return ret;
+}
+
+int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
+		    u8 type, u16 q_number, u16 completed_index, void *opaque)
+{
+	struct enic *enic = vnic_dev_priv(vdev);
+
+	vnic_rq_service(&enic->rq[q_number].vrq, cq_desc, completed_index,
+			VNIC_RQ_RETURN_DESC, enic_rq_indicate_buf, opaque);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.h b/drivers/net/ethernet/cisco/enic/enic_rq.h
new file mode 100644
index 000000000000..46ab75fd74a0
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2008-2010 Cisco Systems, Inc.  All rights reserved.
+ * Copyright 2007 Nuova Systems, Inc.  All rights reserved.
+ */
+
+#ifndef _ENIC_RQ_H_
+#define _ENIC_RQ_H_
+
+void enic_intr_update_pkt_size(struct vnic_rx_bytes_counter *pkt_size,
+			       u32 pkt_len);
+void enic_rq_set_skb_flags(struct vnic_rq *rq, u8 type, u32 rss_hash, u8 rss_type,
+			   u8 fcoe, u8 fcoe_fc_crc_ok, u8 vlan_stripped,
+			   u8 csum_not_calc, u8 tcp_udp_csum_ok, u8 ipv6,
+			   u8 ipv4_csum_ok, u16 vlan_tci, struct sk_buff *skb);
+int enic_rq_pkt_error(struct vnic_rq *rq, u8 packet_error, u8 fcs_ok,
+		      u16 bytes_written);
+int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
+		    u8 type, u16 q_number, u16 completed_index, void *opaque);
+void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
+			  struct vnic_rq_buf *buf, int skipped, void *opaque);
+#endif /* _ENIC_RQ_H_ */
-- 
2.35.2


