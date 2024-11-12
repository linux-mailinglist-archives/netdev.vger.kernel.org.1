Return-Path: <netdev+bounces-144205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7139C6405
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 23:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62199B2CA0F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B76217919;
	Tue, 12 Nov 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YnH8J/XK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B77216429;
	Tue, 12 Nov 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437691; cv=none; b=mc09H2LaHrzNSt4HjslFREJrQjZi04Fyobu3qaKPGyBEH30AwVd8p/M9bNqN43PeQjJ2Mn74jNijGLKxAPbnJ2kpc9hMKjmj1aEVjlohacHeWlWUKVP91lmajkghY1pnVJpRvfG1MSLpKl/aCPyIIQnRCCS939npCoVAd8ssO9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437691; c=relaxed/simple;
	bh=kY3t6JZYW8KjOp6xl2EbMyFHILQshQabM3ejZVCF4ek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FFJvrM9kiQJMqGFM5rS7GonNlAh2ZGOCXRi+WbkwPpzXpkA7RSIxoih54MBCOxsAZskHeFOVfjAwC9RPDchNta4i63Y++hbYunIq2+4jZqQoDy9K8MItEN0RD5aR7AGZiGGIUKeY5SlayYmlVMaNFN6ZWUJgPAxi4K/06CWEeh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YnH8J/XK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACI6uXo032328;
	Tue, 12 Nov 2024 10:54:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ktecIOd1FEuTMdchCwLyg7e
	cyCeCZVxK5+8+l1znnu0=; b=YnH8J/XK9iQ+ga7LESzrjg+2x2amXoQsH+/YxTL
	qIj0+DbN+djKIsItJJwej3h3pbcfjnYgW2fXKNsDPZms5tJtLhJN+rNyTJrx+hOd
	I2UJGxHF0dC1qajlOqgVeYdP9PeD0OQjhubDCCkcwK9RUpz40241ty5uP1ieGDxh
	csB9XguJPlpcu0tIOdGpIDcDJbC43qomouJqj+8nB5LdEXFdzjJBS9Srn9NCESym
	58MV30qkkxIsK+sESL4Rrrn7fh2NyB1aifJqMQ3RQ5n6n4xd80hYA4suHQHz0bD/
	SB6Aj3pGYTjdnaKBKuZL7/LHjYaLmts7VsO70oEli4AOXhA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42vc0pr3g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 10:54:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 12 Nov 2024 10:54:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 10:54:35 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id C1F2E3F7045;
	Tue, 12 Nov 2024 10:54:34 -0800 (PST)
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
Subject: [PATCH net-next v2] octeon_ep: add ndo ops for VFs in PF driver
Date: Tue, 12 Nov 2024 10:54:31 -0800
Message-ID: <20241112185432.1152541-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _T9_zC8nsh79nyDhPQhygxIA5dhIae3c
X-Proofpoint-GUID: _T9_zC8nsh79nyDhPQhygxIA5dhIae3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

These APIs are needed to support applications that use netlink to get VF
information from a PF driver.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Corrected typos, and removed not supported ndo_set_vf* hooks

V1: https://lore.kernel.org/all/20241107121637.1117089-1-srasheed@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_main.c   | 41 +++++++++++++++++++
 .../ethernet/marvell/octeon_ep/octep_main.h   |  1 +
 .../marvell/octeon_ep/octep_pfvf_mbox.c       | 22 +++++++++-
 .../marvell/octeon_ep/octep_pfvf_mbox.h       |  3 ++
 4 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..6c1689a98f20 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1137,6 +1137,44 @@ static int octep_set_features(struct net_device *dev, netdev_features_t features
 	return err;
 }
 
+static int octep_get_vf_config(struct net_device *dev, int vf, struct ifla_vf_info *ivi)
+{
+	struct octep_device *oct = netdev_priv(dev);
+
+	ivi->vf = vf;
+	ether_addr_copy(ivi->mac, oct->vf_info[vf].mac_addr);
+	ivi->vlan = 0;
+	ivi->qos = 0;
+	ivi->spoofchk = 0;
+	ivi->linkstate = IFLA_VF_LINK_STATE_ENABLE;
+	ivi->trusted = true;
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
+	oct->vf_info[vf].flags |=  OCTEON_PFVF_FLAG_MAC_SET_BY_PF;
+
+	err = octep_ctrl_net_set_mac_addr(oct, vf, mac, true);
+	if (err)
+		dev_err(&oct->pdev->dev, "Set VF%d MAC address failed via host control Mbox\n", vf);
+
+	return err;
+}
+
 static const struct net_device_ops octep_netdev_ops = {
 	.ndo_open                = octep_open,
 	.ndo_stop                = octep_stop,
@@ -1146,6 +1184,9 @@ static const struct net_device_ops octep_netdev_ops = {
 	.ndo_set_mac_address     = octep_set_mac,
 	.ndo_change_mtu          = octep_change_mtu,
 	.ndo_set_features        = octep_set_features,
+	/* for VFs */
+	.ndo_get_vf_config       = octep_get_vf_config,
+	.ndo_set_vf_mac          = octep_set_vf_mac
 };
 
 /**
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index fee59e0e0138..3b56916af468 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -220,6 +220,7 @@ struct octep_iface_link_info {
 /* The Octeon VF device specific info data structure.*/
 struct octep_pfvf_info {
 	u8 mac_addr[ETH_ALEN];
+	u32 flags;
 	u32 mbox_version;
 };
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index e6eb98d70f3c..26db2d34d1c0 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -156,12 +156,23 @@ static void octep_pfvf_set_mac_addr(struct octep_device *oct,  u32 vf_id,
 {
 	int err;
 
+	if (oct->vf_info[vf_id].flags & OCTEON_PFVF_FLAG_MAC_SET_BY_PF) {
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
 
@@ -171,10 +182,17 @@ static void octep_pfvf_get_mac_addr(struct octep_device *oct,  u32 vf_id,
 {
 	int err;
 
+	if (oct->vf_info[vf_id].flags & OCTEON_PFVF_FLAG_MAC_SET_BY_PF) {
+		dev_dbg(&oct->pdev->dev, "VF%d MAC address set by PF\n", vf_id);
+		ether_addr_copy(rsp->s_set_mac.mac_addr, oct->vf_info[vf_id].mac_addr);
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
index 0dc6eead292a..339977c7131a 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
@@ -23,6 +23,9 @@ enum octep_pfvf_mbox_version {
 
 #define OCTEP_PFVF_MBOX_VERSION_CURRENT	OCTEP_PFVF_MBOX_VERSION_V2
 
+/* VF flags */
+#define OCTEON_PFVF_FLAG_MAC_SET_BY_PF  BIT_ULL(0) /* PF has set VF MAC address */
+
 enum octep_pfvf_mbox_opcode {
 	OCTEP_PFVF_MBOX_CMD_VERSION,
 	OCTEP_PFVF_MBOX_CMD_SET_MTU,
-- 
2.25.1


