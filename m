Return-Path: <netdev+bounces-148192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CED9E0B0C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6242D280DE1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B61DDC02;
	Mon,  2 Dec 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="M2q7+jlY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8F70805;
	Mon,  2 Dec 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164371; cv=none; b=CtFGzvF1ENPhxgXvZXpGufmMWD/EmffgaA2ssz1PAwbcUW4ntfIGjnP4NeMPRMQeP2oyXCGs1d8SPNP8f0fAyG+CAHnYXm9n0UKGRtIU8I1MkCLor+gRRII2XPTIzSbVCM7XwzYfQP/x05YBjkulJifSxjLmbz96OczNEobnHiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164371; c=relaxed/simple;
	bh=5zdc5yDcA29a0xhFW2zhxgI2AoKgeyu3kJazza0fKyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XAxlTPxIbqSHrlAqHk/5vU18rVgURqLxiv/RfMVJA/bh/KofrLY0+dLjjRqRBVxklq/FejykC2u9aeGro9GjrD/2cB6EeavpTiFoSESkhvZPMC+4tRIJcpegJq+4ZzVJLal0ON1uF887QlRdLUDZTaqOi9I9tAOYplabdbvNxYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=M2q7+jlY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2AT7LK014470;
	Mon, 2 Dec 2024 10:32:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=e3RFZtalqMokySmIITPzp0C
	A15CGLdsWKD7j0mPpw54=; b=M2q7+jlYJEwosuGU8Hn+Vmg210+iplzz5DzDUOM
	KM7afWkDHkqZGer2EVFledvVSXuoNwZVtPFHYJWGjACjuh+SMcVhLwm59RfCjlzg
	bYQ2wGRl6U5rzzPiLjLQevUkCBDSx9dmWZxDNeaNpEdaD7rirClkPIx96A3b5HgN
	dpf+TuxazGj9lEoFq1mJJLjxlt1e8tTjr80HPqmjLUnmlDs2x/lJwV2c5hGcJeUG
	05fyFWNoI+VKq41vC7sBf+elX4ssElgPG2HQ/LquDtn5kJzCzpqD1yBg+HY7ZRyV
	v8bjnleLLAyuEhgYn1D6KuEuyMxg3k+DroB9fOtMiBo0lRw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 439agjh0yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 10:32:22 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 2 Dec 2024 10:32:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 2 Dec 2024 10:32:21 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 1CF833F7052;
	Mon,  2 Dec 2024 10:32:21 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <einstein.xue@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net-next v3 RESEND] octeon_ep: add ndo ops for VFs in PF driver
Date: Mon, 2 Dec 2024 10:32:18 -0800
Message-ID: <20241202183219.2312114-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3BBGa2pk2etLCPcSKW2RU-PQeJr_EQo0
X-Proofpoint-ORIG-GUID: 3BBGa2pk2etLCPcSKW2RU-PQeJr_EQo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

These APIs are needed to support applications that use netlink to get VF
information from a PF driver.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Corrected line-wrap and space checkpatch errors
  - Set spoof check as true and vf trusted as false to be default vf
    configs

V2: https://lore.kernel.org/all/PH0PR18MB47344F6BCCD1B629AC012065C7252@PH0PR18MB4734.namprd18.prod.outlook.com/
  - Corrected typos, and removed not supported ndo_set_vf* hooks

V1: https://lore.kernel.org/all/20241107121637.1117089-1-srasheed@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_main.c   | 46 ++++++++++++++++++-
 .../ethernet/marvell/octeon_ep/octep_main.h   |  2 +
 .../marvell/octeon_ep/octep_pfvf_mbox.c       | 24 +++++++++-
 .../marvell/octeon_ep/octep_pfvf_mbox.h       |  6 ++-
 4 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..226a44823401 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1137,6 +1137,45 @@ static int octep_set_features(struct net_device *dev, netdev_features_t features
 	return err;
 }
 
+static int octep_get_vf_config(struct net_device *dev, int vf,
+			       struct ifla_vf_info *ivi)
+{
+	struct octep_device *oct = netdev_priv(dev);
+
+	ivi->vf = vf;
+	ether_addr_copy(ivi->mac, oct->vf_info[vf].mac_addr);
+	ivi->spoofchk = true;
+	ivi->linkstate = IFLA_VF_LINK_STATE_ENABLE;
+	ivi->trusted = oct->vf_info[vf].trusted;
+	ivi->max_tx_rate = 10000;
+	ivi->min_tx_rate = 0;
+
+	return 0;
+}
+
+static int octep_set_vf_mac(struct net_device *dev, int vf, u8 *mac)
+{
+	struct octep_device *oct = netdev_priv(dev);
+	int err;
+
+	if (!is_valid_ether_addr(mac)) {
+		dev_err(&oct->pdev->dev, "Invalid  MAC Address %pM\n", mac);
+		return -EADDRNOTAVAIL;
+	}
+
+	dev_dbg(&oct->pdev->dev, "set vf-%d mac to %pM\n", vf, mac);
+	ether_addr_copy(oct->vf_info[vf].mac_addr, mac);
+	oct->vf_info[vf].flags |= OCTEON_PFVF_FLAG_MAC_SET_BY_PF;
+
+	err = octep_ctrl_net_set_mac_addr(oct, vf, mac, true);
+	if (err)
+		dev_err(&oct->pdev->dev,
+			"Set VF%d MAC address failed via host control Mbox\n",
+			vf);
+
+	return err;
+}
+
 static const struct net_device_ops octep_netdev_ops = {
 	.ndo_open                = octep_open,
 	.ndo_stop                = octep_stop,
@@ -1146,6 +1185,8 @@ static const struct net_device_ops octep_netdev_ops = {
 	.ndo_set_mac_address     = octep_set_mac,
 	.ndo_change_mtu          = octep_change_mtu,
 	.ndo_set_features        = octep_set_features,
+	.ndo_get_vf_config       = octep_get_vf_config,
+	.ndo_set_vf_mac          = octep_set_vf_mac
 };
 
 /**
@@ -1560,9 +1601,12 @@ static void octep_remove(struct pci_dev *pdev)
 static int octep_sriov_enable(struct octep_device *oct, int num_vfs)
 {
 	struct pci_dev *pdev = oct->pdev;
-	int err;
+	int i, err;
 
 	CFG_GET_ACTIVE_VFS(oct->conf) = num_vfs;
+	for (i = 0; i < num_vfs; i++)
+		oct->vf_info[i].trusted = false;
+
 	err = pci_enable_sriov(pdev, num_vfs);
 	if (err) {
 		dev_warn(&pdev->dev, "Failed to enable SRIOV err=%d\n", err);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index fee59e0e0138..1c39833ffcc0 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -220,7 +220,9 @@ struct octep_iface_link_info {
 /* The Octeon VF device specific info data structure.*/
 struct octep_pfvf_info {
 	u8 mac_addr[ETH_ALEN];
+	u32 flags;
 	u32 mbox_version;
+	bool trusted;
 };
 
 /* The Octeon device specific private data structure.
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index e6eb98d70f3c..3024f6428838 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -156,12 +156,24 @@ static void octep_pfvf_set_mac_addr(struct octep_device *oct,  u32 vf_id,
 {
 	int err;
 
+	if ((oct->vf_info[vf_id].flags & OCTEON_PFVF_FLAG_MAC_SET_BY_PF) &&
+	    !oct->vf_info[vf_id].trusted) {
+		dev_err(&oct->pdev->dev,
+			"VF%d attempted to override administrative set MAC address\n",
+			vf_id);
+		rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		return;
+	}
+
 	err = octep_ctrl_net_set_mac_addr(oct, vf_id, cmd.s_set_mac.mac_addr, true);
 	if (err) {
 		rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
-		dev_err(&oct->pdev->dev, "Set VF MAC address failed via host control Mbox\n");
+		dev_err(&oct->pdev->dev, "Set VF%d MAC address failed via host control Mbox\n",
+			vf_id);
 		return;
 	}
+
+	ether_addr_copy(oct->vf_info[vf_id].mac_addr, cmd.s_set_mac.mac_addr);
 	rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
 }
 
@@ -171,10 +183,18 @@ static void octep_pfvf_get_mac_addr(struct octep_device *oct,  u32 vf_id,
 {
 	int err;
 
+	if (oct->vf_info[vf_id].flags & OCTEON_PFVF_FLAG_MAC_SET_BY_PF) {
+		dev_dbg(&oct->pdev->dev, "VF%d MAC address set by PF\n", vf_id);
+		ether_addr_copy(rsp->s_set_mac.mac_addr,
+				oct->vf_info[vf_id].mac_addr);
+		rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+		return;
+	}
 	err = octep_ctrl_net_get_mac_addr(oct, vf_id, rsp->s_set_mac.mac_addr);
 	if (err) {
 		rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
-		dev_err(&oct->pdev->dev, "Get VF MAC address failed via host control Mbox\n");
+		dev_err(&oct->pdev->dev, "Get VF%d MAC address failed via host control Mbox\n",
+			vf_id);
 		return;
 	}
 	rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
index 0dc6eead292a..386a095a99bc 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
@@ -8,8 +8,6 @@
 #ifndef _OCTEP_PFVF_MBOX_H_
 #define _OCTEP_PFVF_MBOX_H_
 
-/* VF flags */
-#define OCTEON_PFVF_FLAG_MAC_SET_BY_PF  BIT_ULL(0) /* PF has set VF MAC address */
 #define OCTEON_SDP_16K_HW_FRS  16380UL
 #define OCTEON_SDP_64K_HW_FRS  65531UL
 
@@ -23,6 +21,10 @@ enum octep_pfvf_mbox_version {
 
 #define OCTEP_PFVF_MBOX_VERSION_CURRENT	OCTEP_PFVF_MBOX_VERSION_V2
 
+/* VF flags */
+/* PF has set VF MAC address */
+#define OCTEON_PFVF_FLAG_MAC_SET_BY_PF  BIT(0)
+
 enum octep_pfvf_mbox_opcode {
 	OCTEP_PFVF_MBOX_CMD_VERSION,
 	OCTEP_PFVF_MBOX_CMD_SET_MTU,
-- 
2.25.1


