Return-Path: <netdev+bounces-153817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3347C9F9C76
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FA3189011C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171481A3BC8;
	Fri, 20 Dec 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="H+uJgNff"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D038C2248BF
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734731552; cv=none; b=VGZaSDnE/9B8W82EqKS+GadKkbZA3Zd00AWi6SvouB9/XQNZIAAYWR2gIb+OLR9sL12omCxrzdUUzLrJcodsKM5FZjkSsqUBGkm9ELfcRTASH3+oV4Iar+x+Q9wuPKTG0j/LwqE7dXOCy91q05P9aTxtkqKEDwTD8XLy99gvw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734731552; c=relaxed/simple;
	bh=G18Lp5NB/377r4ZItaiEwYiT0g8v5rQu0qz7CTBWzdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HlJuxOJBVKl8wUq7IoiOUq2Eua37bSdgiij+UM/EDqgddNytxjyHl4nH7i5pUAP9IZSecABDrs/DvH8KTUfNeQcDj96Qn+WbqUFl87LXObr9wZbTDuGUhiT1mEOC0wSpSYMx7oIRHRIFgO7jpwkKIwTNWYd+AnO4eL2RDv0D/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=H+uJgNff; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11381; q=dns/txt;
  s=iport; t=1734731549; x=1735941149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6UMZSEFMCqsQvKnMVoSaYcfhydkuEqOPZPpeuzYbpks=;
  b=H+uJgNffgWW1mKMKc/9smSUKirBApkrsqDmDTRrtFsoaD7WKxArFSBip
   7jl5/dO38w2om7sk068c22TYyBmemVwm4jYLkqzTE8WhrwKIcbMrU8t3q
   kiFiGWd3HWS0S8GeTGsRpRySyY0/nGeHGiOmaiHQAgLI4GIlG190R8g10
   8=;
X-CSE-ConnectionGUID: 7o+Xb4V6TQ6cmGuchuiZew==
X-CSE-MsgGUID: E92sCZZPRr2bAVimncGMKg==
X-IPAS-Result: =?us-ascii?q?A0ANAAB75mVnj4//Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBhBlDSIxyX4hynhsUgREDVg8BAQEPRAQBAYUHAopsAiY0CQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBRQBAQEBAQE5BUmGCIZbAgEDJ?=
 =?us-ascii?q?wsBRhBRKysHEoMBgmUDsCyBeTOBAd4zgW2BSAGFaodfcIR3JxuBSUSBFYE7g?=
 =?us-ascii?q?T5vhAaHAQSJF55OSIEhA1ksAVUTDQoLBwWBOToDIgwLDAsUHBUCgR6BAQEUB?=
 =?us-ascii?q?hUEgQtFPYJKaUk3Ag0CNoIgJFiCTYUYhGGEV4JJVYJ8ghd8gR2BcUADCxgNS?=
 =?us-ascii?q?BEsNwYOGwY+bgecUEaDaQeBDgGCBQ5VkyiSHaEDhCSBY59jGjOqUph7IqQjh?=
 =?us-ascii?q?GaBZzqBWzMaCBsVgyJSGQ+IXIVRDQm6eSUyPAIHCwEBAwmPMC2BTgEB?=
IronPort-Data: A9a23:BSknGqBoXQlOtRVW/83jw5YqxClBgxIJ4kV8jS/XYbTApDIlgTxUy
 TFOX23XOfuMYzOhL9sjPY+1904BsZ6GnII2OVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZsCCeB/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWWthh
 fuo+5eDYQX/g2YuWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEnPItPEtqA9Mkw7h8BE5T/
 vwFKQIAcUXW7w626OrTpuhEnM8vKozveYgYoHwllW+fBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGY0BPjDS0Un1lM/CpU+muuhgnTXeDxDo1XTrq0yi4TW5FApi+ixYYePIrRmQ+14zxyDj
 VD0x17jWBszCt2azzGq11Gj07qncSTTA99KS+biqZaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcCQBcJ7sfLvo4+lFTMQ8xlHarzicf6cQwc2
 BiQpyQ4wrFWhskR2uDjoxbMgimnod7CSQtdChjrsnyNsQQ6VIT5WdKU0AbQ6NldJ4aET2uMo
 y1R8ySB19wmAZaInS2LZewCGrC1+vqIWAEwZ3YxRfHNEBzzohaekZBs3d1oGKt+3i85ld7Vj
 K375Fo5CHx7ZSfCgUpLj2SZUJlCIU/IToiNaxwsRoASCqWdjSfelM2UWWae3nr2jG8nmrwlN
 JGQfK6EVClBVfo8l2DrGb1BidfHIxzSI0uOGvgXKDz6gdKjiIK9E+1t3KamN7pht/nc+G05D
 f4CaZbWm32zr9ESkgGMrNZMdgpVRZTKLZv3sMdQPvWSORZrHXppCvnah9scl39NwcxoehPz1
 ijlACdwkQOn7VWecFXiQi44MtvHA80gxU/XyARwZj5ELVB/Ot73tM/ytvIfIdEayQCU5aQtE
 qlcJ5TZWKgnp/au0211UKQRZbdKLHyD7T9i9QL8CNTjV/aMnzD0x+I=
IronPort-HdrOrdr: A9a23:8DlWqaP8OXeCisBcTsajsMiBIKoaSvp037Dk7S9MoHtuA6ulfq
 +V/cjzuSWYtN9VYgBDpTniAtjlfZqjz/5ICOAqVN/INjUO+lHYSb2KhrGN/9SPIUHDH5ZmpM
 Rdm2wUMqyIMbC85vyKhjWFLw==
X-Talos-CUID: 9a23:lNMM0WOqIPL7IO5DBy4kxERIJJ4ZSyPWyVjNKE+lCFRkV+jA
X-Talos-MUID: 9a23:uXj4WAosAaMR6KrNbvAezxwzbtxD0ZaWMlpXm7w4usyCPgNVGDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,251,1728950400"; 
   d="scan'208";a="403849520"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 20 Dec 2024 21:51:21 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTP id 102E918000252;
	Fri, 20 Dec 2024 21:51:21 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id E11D920F2003; Fri, 20 Dec 2024 13:51:20 -0800 (PST)
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
Subject: [PATCH net-next 1/5] enic: Refactor RX path common code into helper functions
Date: Fri, 20 Dec 2024 13:50:54 -0800
Message-Id: <20241220215058.11118-2-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241220215058.11118-1-johndale@cisco.com>
References: <20241220215058.11118-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-06.cisco.com

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


