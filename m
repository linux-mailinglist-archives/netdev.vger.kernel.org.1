Return-Path: <netdev+bounces-157312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B871FA09EB6
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23155167CC4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B66222575;
	Fri, 10 Jan 2025 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="S9iYpEbL"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD40218AAB
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736551981; cv=none; b=F7f9DmnQWyYFk/LC9oDYdWNFQaS9s0QyOPSw7E89ygmaHFBIzxAXYzetneKn2s/clUDAiFFHk0a7DKNN5tCik99nIoaGmPp3KSxSvIYi1fkI2KgJvCK/+DBpxKPdqVFlS2NN1ZnILrSDnJElnFxA6OZpCv4/B3wvKoSdaBA5pGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736551981; c=relaxed/simple;
	bh=gOZ/9xPscm7DHYecaMZItzg+5wHDWiVCyyiGQyAERAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCLp1h2nxOSPEsfdbLD6EYX2CltW8NG/R3P5AnaJupn2xRfp/0WhSkr+C6lFeTXSch/5m6iR2TFL6t2gorE01IQCBBzvyneGFFwIn0rK9mttvT5O2jTTBAncJ1VY7q9uV33JzDojGEUCxYGKhMggoJzcm2rjxebfa+yVhV/ukG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=S9iYpEbL; arc=none smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11406; q=dns/txt;
  s=iport; t=1736551979; x=1737761579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+DrN/uoXLwjyelak05gv0W0iTMTTzvP3vTAQgSR6SgA=;
  b=S9iYpEbLCt12+RQc4Rw8ZMiPzPMaVgp8o0RyJede70xRFNrrPq/Ns54N
   4OLcpVZLIgp+YUvLl2RIsxWIftuckmz9nmqrj3Ko+MDckd7ArB0/XexYy
   oghFuUo7DvDRxbo9RxdDWGOegol1D+Ix6E8W0gOlV1HsBDebAUE054LGI
   0=;
X-CSE-ConnectionGUID: 1vy9msTsRrC9kOuN1ZfpuQ==
X-CSE-MsgGUID: d9+2nIlYT3Gxl7Iwp/T/7w==
X-IPAS-Result: =?us-ascii?q?A0AEAAD8rIFnj4v/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBhBlDSIxyX4hynhsUgREDVg8BAQEPRAQBAYUHAop0AiY0C?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBRQBAQEBAQE5BQ47h?=
 =?us-ascii?q?giGWwIBAycLAUYQUSsrBxKDAYJlA7RNgXkzgQHeM4FtgUgBhWqHX3CEdycbg?=
 =?us-ascii?q?UlEgRWBO4E+b4QGhwEEgjKFNZ5SSIEhA1ksAVUTDQoLBwWBODoDIgsLDAsUH?=
 =?us-ascii?q?BUCFR4BEQYQBG1EN4JGaUs6Ag0CNYIeJFiCK4RchEeEVIJLVYJHghR6gRmEA?=
 =?us-ascii?q?UADCxgNSBEsNwYOGwY+bgebJzyDaAYBgQ4BggUOVZMokh+LcpURhCWBY59jG?=
 =?us-ascii?q?jOqU5h8IqQlhGaBZzqBWzMaCBsVgyJSGQ+IXIVRDQm8XCUyPAIHCwEBAwmPI?=
 =?us-ascii?q?y2BTgEB?=
IronPort-Data: A9a23:PlDq66D1+Yp3hRVW/8zjw5YqxClBgxIJ4kV8jS/XYbTApGx2gT1Rx
 jMXDzyBb/qNYTf1L9pzao3loEwC7JWBx9VmOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZsCCeB/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWWthh
 fuo+5eCYAb8g2YvWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEmut/XUQtAZYi4M0mAkZT0
 6UqJigQV0XW7w626OrTpuhEnM8vKozveYgYoHwllWufBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGE+BPjDS0Un1lM/CpU+muuhgnTXeDxDo1XTrq0yi4TW5FApgeK8YYCJIrRmQ+1ZzwXCo
 EPCzliiLQEea/2A0X25tS2z07qncSTTA99KS+biqZaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcCQBcJ7sfLvo4+lFTMQ8xlHarzicf6cQwc2
 BiQpyQ4wrFWhskR2uDjpxbMgimnod7CSQtdChjrsnyNtx1oNYu+W5eS83OK7tFdCt+rQEGch
 S1R8ySB19wmAZaInS2LZewCGrC1+vqIWAEwZ3YxRPHNEBzzoBaekZBs3d1oGKt+3i85ld7Vj
 K375Fg5CHx7ZSfCgUpLj2SZUJtCIU/ITouNaxwsRoASCqWdjSfelM2UWWae3nr2jG8nmrwlN
 JGQfK6EVClBV/g7k2fqG7tDgdfHIxzSI0uOGvgXKDz6gNKjiIK9E+1t3KamN7pgtf3Y8G05D
 f4AZ5PQkH2zr9ESkgGMrNZMdgpVRZTKLZv3sMdQPvWSORZrHXppCvnah9scl39NwcxoehPz1
 ijlACdwkQOn7VWecFniQi44MtvHA80gxU/XyARwZj5ELVB/Ot73tM/ytvIfIdEayQCU5acoH
 qVcK5/dWJyiiF3volwgUHU0l6Q6HDzDuO5EF3DNjOQXF3K4ezH0xw==
IronPort-HdrOrdr: A9a23:dsCecq/Xw8DJ9DBwLjRuk+DfI+orL9Y04lQ7vn2ZhyY7TiX+rb
 HIoB11737JYVoqNU3I3OrwWpVoIkmskaKdn7NwAV7KZmCP0wGVxcNZnO7fKlbbdREWmNQw6U
 4ZSdkcNDU1ZmIK9PoTJ2KDYrAd/OU=
X-Talos-CUID: 9a23:+mKqCGB3HhqI6gj6E3B55R8RAfw+SGf2nXT3PmnhO2hxVYTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AaFS95A2ScMlOZB6Fkrkkb44IDjUj7/XtUkYslaQ?=
 =?us-ascii?q?64OaUMXNRJC/asHPoXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,305,1728950400"; 
   d="scan'208";a="409299240"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 10 Jan 2025 23:32:53 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTP id 0F25D18000233;
	Fri, 10 Jan 2025 23:32:53 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id DC98E20F2004; Fri, 10 Jan 2025 15:32:52 -0800 (PST)
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
Subject: [PATCH net-next v5 1/4] enic: Refactor RX path common code into helper functions
Date: Fri, 10 Jan 2025 15:32:46 -0800
Message-Id: <20250110233249.23258-2-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250110233249.23258-1-johndale@cisco.com>
References: <20250110233249.23258-1-johndale@cisco.com>
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

No functional change.

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
index 49f6cab01ed5..2a1448e98466 100644
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
@@ -1361,15 +1361,6 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
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
@@ -1389,9 +1380,8 @@ static bool enic_rxcopybreak(struct net_device *netdev, struct sk_buff **skb,
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
@@ -1406,7 +1396,6 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 	u8 packet_error;
 	u16 q_number, completed_index, bytes_written, vlan_tci, checksum;
 	u32 rss_hash;
-	bool outer_csum_ok = true, encap = false;
 
 	rqstats->packets++;
 	if (skipped) {
@@ -1426,15 +1415,7 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
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
@@ -1458,66 +1439,11 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
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
@@ -1538,18 +1464,6 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
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
2.44.0


