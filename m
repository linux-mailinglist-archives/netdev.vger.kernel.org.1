Return-Path: <netdev+bounces-232346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55280C045B4
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E576C18C279C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 05:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98C71ACED5;
	Fri, 24 Oct 2025 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Rb4IEWbR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39CAC8FE;
	Fri, 24 Oct 2025 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761282021; cv=none; b=BmOFi31zL0OAt7OpofwaVBCXDpCv540piTEqatRMH5QdsoNTZKD/x+SyWz9E9MDSBfK6WW7DM5lCgls0S9nmAI7PzhmM061DeKyQ0l8kWfWtpc3NkZ5mqtqBnlxagL2qZwgakrJvep84B3fYfBPGSNgE80ltjQwFuABV4YF/CFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761282021; c=relaxed/simple;
	bh=J2AVCqJTAGqKJVL2P67f2NzX7cPdI9hNGd+bFU6Ilnc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dDniYlMYfqO11KEYCIfDFH2/CKnSoLbHMrj/A+1mDyO4yRxcWvmCyKbk6irMtx1Dr7h6gDAXRTooBbV1eGWBX/Nc7AxcTLjT/i4yOnCF2kIzSqTbuklbW5CPCcGbIbKb5Nr8T+s/GtIIY9XmCVTmKQZQ+DXHjcguaiGvfgtR5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Rb4IEWbR; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3D1tU023013;
	Thu, 23 Oct 2025 21:49:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Vm+8XCT0Gg/06ESrA5UFQL6
	vNcgQ1Buv1tUTm/7yCkA=; b=Rb4IEWbRnk1zUl/NSHMHUmEU3U0tFiFsjcNRhRJ
	ItEVbF6EmVddxgVnjNtVBcaLjAs0Az1jXTrPOm83pPrWZF2Pz1oXrtWcGIvHObxq
	ze9UeJPnJgijhoUbj04HwQq+SJec2EVPrk5BJVHjIO4JuqFrT+xjrxNKeHZbc3i1
	LcRYP2ji3XggZ98UsnbE+HqEBz/BIHSBxNjGyj4N5JjHdyCL+6W4Nl7DyrJLWKG/
	xw7zWfqvsxVrAso9XNcyUrBhLo47UkNM3YXJgw4YQBxZzfUkP0AqZ88yYqZL0Wsn
	onik/oZHodZKif20jSjqzLko7V0Ji4V3XMblbCznLSkVtBw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49yx2j0fq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 21:49:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 21:49:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 21:49:36 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id C1BF53F7068;
	Thu, 23 Oct 2025 21:49:20 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        Kory Maincent
	<kory.maincent@bootlin.com>,
        "Gal Pressman" <gal@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Breno Leitao
	<leitao@debian.org>
Subject: [RFC net-next] net: loopback: Extend netdev features with new loopback modes
Date: Fri, 24 Oct 2025 10:18:48 +0530
Message-ID: <20251024044849.1098222-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDIxNCBTYWx0ZWRfX6OTRG3Z2hmq/
 UXHgTV5mhQ8hbrangT0m8VWHGzwSJLK1qCT4hS4LdfrfMdS5yy4voqUpDP8RgJzJXLbOb32N4JC
 vbvJ79s9cjm4sC0KsmVpEUMAZ6Ff7f7FGcEFy30BJOLmkgAUU99n7TtuWZJiXaI6DGFZIlnb3uG
 XRx7AHstZLb+VKSgNM6hr9YGoPSV6WAHTsNv5XiYYcO5FeF/74MR8Enp7pgHWUcKE7XDezfH9fX
 arFToolmBo2MW4YpEu0jnOlTGv8Ou3fsX99+aHAZd0IFeqnxCj8/njpJPPU8Xgg3xK2BMZzQABy
 Ln124W+u+YtEog2OHDOr3Dr5zqq+wxIQHhPVHoQWUZFReAfqtoTfoIgZyJh4+myXJv+1zyRJFz1
 2oNZiuOzrBFPnU3pFzcl1EAZJtBtzg==
X-Proofpoint-GUID: F01pi-IkULeLM6k17YFshUrWhpX2rKx-
X-Proofpoint-ORIG-GUID: F01pi-IkULeLM6k17YFshUrWhpX2rKx-
X-Authority-Analysis: v=2.4 cv=Rs7I7SmK c=1 sm=1 tr=0 ts=68fb0556 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=rHH5SKvytUcD9PMnC3QA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01

This patch enhances loopback support by exposing new loopback modes
(e.g., MAC, SERDES) to userspace. These new modes are added extension
to the existing netdev features.

This allows users to select the loopback at specific layer.

Below are new modes added:

MAC near end loopback

MAC far end loopback

SERDES loopback

Depending on the feedback will submit ethtool changes.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 Documentation/networking/netdev-features.rst  | 15 +++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 93 ++++++++++++++++++-
 include/linux/netdev_features.h               |  9 +-
 net/ethtool/common.c                          |  3 +
 4 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index 02bd7536fc0c..dcad5e875f32 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -193,3 +193,18 @@ frames in hardware.
 
 This should be set for devices which support netmem TX. See
 Documentation/networking/netmem.rst
+
+* mac-nearend-loopback
+
+This requests that the NIC enables MAC nearend loopback i.e egress traffic is
+routed back to ingress traffic.
+
+* mac-farend-loopback
+
+This requests that the NIC enables MAC farend loopback i.e ingress traffic is
+routed back to egress traffic.
+
+
+* serdes-loopback
+
+This request that the NIC enables SERDES near end digital loopback.
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index e808995703cf..14be6a9206c8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1316,6 +1316,84 @@ static int otx2_cgx_config_loopback(struct otx2_nic *pf, bool enable)
 	return err;
 }
 
+static int otx2_cgx_mac_nearend_loopback(struct otx2_nic *pf, bool enable)
+{
+	struct msg_req *msg;
+	int err;
+
+	if (enable && !bitmap_empty(pf->flow_cfg->dmacflt_bmap,
+				    pf->flow_cfg->dmacflt_max_flows))
+		netdev_warn(pf->netdev,
+			    "CGX/RPM nearend loopback might not work as DMAC filters are active\n");
+
+	mutex_lock(&pf->mbox.lock);
+	if (enable)
+		msg = otx2_mbox_alloc_msg_cgx_intlbk_enable(&pf->mbox);
+	else
+		msg = otx2_mbox_alloc_msg_cgx_intlbk_disable(&pf->mbox);
+
+	if (!msg) {
+		mutex_unlock(&pf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	err = otx2_sync_mbox_msg(&pf->mbox);
+	mutex_unlock(&pf->mbox.lock);
+	return err;
+}
+
+static int otx2_cgx_mac_farend_loopback(struct otx2_nic *pf, bool enable)
+{
+	struct msg_req *msg;
+	int err;
+
+	if (enable && !bitmap_empty(pf->flow_cfg->dmacflt_bmap,
+				    pf->flow_cfg->dmacflt_max_flows))
+		netdev_warn(pf->netdev,
+			    "CGX/RPM farend loopback might not work as DMAC filters are active\n");
+
+	mutex_lock(&pf->mbox.lock);
+	if (enable)
+		msg = otx2_mbox_alloc_msg_cgx_intlbk_enable(&pf->mbox);
+	else
+		msg = otx2_mbox_alloc_msg_cgx_intlbk_disable(&pf->mbox);
+
+	if (!msg) {
+		mutex_unlock(&pf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	err = otx2_sync_mbox_msg(&pf->mbox);
+	mutex_unlock(&pf->mbox.lock);
+	return err;
+}
+
+static int otx2_cgx_serdes_loopback(struct otx2_nic *pf, bool enable)
+{
+	struct msg_req *msg;
+	int err;
+
+	if (enable && !bitmap_empty(pf->flow_cfg->dmacflt_bmap,
+				    pf->flow_cfg->dmacflt_max_flows))
+		netdev_warn(pf->netdev,
+			    "CGX/RPM serdes loopback might not work as DMAC filters are active\n");
+
+	mutex_lock(&pf->mbox.lock);
+	if (enable)
+		msg = otx2_mbox_alloc_msg_cgx_intlbk_enable(&pf->mbox);
+	else
+		msg = otx2_mbox_alloc_msg_cgx_intlbk_disable(&pf->mbox);
+
+	if (!msg) {
+		mutex_unlock(&pf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	err = otx2_sync_mbox_msg(&pf->mbox);
+	mutex_unlock(&pf->mbox.lock);
+	return err;
+}
+
 int otx2_set_real_num_queues(struct net_device *netdev,
 			     int tx_queues, int rx_queues)
 {
@@ -2363,6 +2441,18 @@ static int otx2_set_features(struct net_device *netdev,
 		return cn10k_ipsec_ethtool_init(netdev,
 						features & NETIF_F_HW_ESP);
 
+	if ((changed & NETIF_F_MAC_LBK_NE) && netif_running(netdev))
+		return otx2_cgx_mac_nearend_loopback(pf,
+						     features & NETIF_F_MAC_LBK_NE);
+
+	if ((changed & NETIF_F_MAC_LBK_FE) && netif_running(netdev))
+		return otx2_cgx_mac_farend_loopback(pf,
+						    features & NETIF_F_MAC_LBK_FE);
+
+	if ((changed & NETIF_F_SERDES_LBK) && netif_running(netdev))
+		return otx2_cgx_serdes_loopback(pf,
+						features & NETIF_F_SERDES_LBK);
+
 	return otx2_handle_ntuple_tc_features(netdev, features);
 }
 
@@ -3249,7 +3339,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (pf->flags & OTX2_FLAG_TC_FLOWER_SUPPORT)
 		netdev->hw_features |= NETIF_F_HW_TC;
 
-	netdev->hw_features |= NETIF_F_LOOPBACK | NETIF_F_RXALL;
+	netdev->hw_features |= NETIF_F_LOOPBACK | NETIF_F_RXALL |
+			       NETIF_F_MAC_LBK_NE | NETIF_F_MAC_LBK_FE | NETIF_F_SERDES_LBK;
 
 	netif_set_tso_max_segs(netdev, OTX2_MAX_GSO_SEGS);
 	netdev->watchdog_timeo = OTX2_TX_TIMEOUT;
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 93e4da7046a1..124f83223361 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -14,7 +14,7 @@ typedef u64 netdev_features_t;
 enum {
 	NETIF_F_SG_BIT,			/* Scatter/gather IO. */
 	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
-	__UNUSED_NETIF_F_1,
+	NETIF_F_MAC_LBK_NE_BIT,		/* MAC near end loopback */
 	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
 	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
 	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */
@@ -24,8 +24,8 @@ enum {
 	NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAGs */
 	NETIF_F_VLAN_CHALLENGED_BIT,	/* Device cannot handle VLAN packets */
 	NETIF_F_GSO_BIT,		/* Enable software GSO. */
-	__UNUSED_NETIF_F_12,
-	__UNUSED_NETIF_F_13,
+	NETIF_F_MAC_LBK_FE_BIT,		/* MAC far end loopback */
+	NETIF_F_SERDES_LBK_BIT,		/* SERDES loopback */
 	NETIF_F_GRO_BIT,		/* Generic receive offload */
 	NETIF_F_LRO_BIT,		/* large receive offload */
 
@@ -165,6 +165,9 @@ enum {
 #define NETIF_F_HW_HSR_TAG_RM	__NETIF_F(HW_HSR_TAG_RM)
 #define NETIF_F_HW_HSR_FWD	__NETIF_F(HW_HSR_FWD)
 #define NETIF_F_HW_HSR_DUP	__NETIF_F(HW_HSR_DUP)
+#define NETIF_F_MAC_LBK_NE	__NETIF_F(MAC_LBK_NE)
+#define NETIF_F_MAC_LBK_FE	__NETIF_F(MAC_LBK_FE)
+#define NETIF_F_SERDES_LBK	__NETIF_F(SERDES_LBK)
 
 /* Finds the next feature with the highest number of the range of start-1 till 0.
  */
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 55223ebc2a7e..4a6a400a7c69 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -77,6 +77,9 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_HW_HSR_TAG_RM_BIT] =	 "hsr-tag-rm-offload",
 	[NETIF_F_HW_HSR_FWD_BIT] =	 "hsr-fwd-offload",
 	[NETIF_F_HW_HSR_DUP_BIT] =	 "hsr-dup-offload",
+	[NETIF_F_MAC_LBK_NE_BIT] =	 "mac-nearend-loopback",
+	[NETIF_F_MAC_LBK_FE_BIT] =	 "mac-farend-loopback",
+	[NETIF_F_SERDES_LBK_BIT] =	 "serdes-loopback",
 };
 
 const char
-- 
2.34.1


