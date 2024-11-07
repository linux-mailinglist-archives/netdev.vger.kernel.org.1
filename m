Return-Path: <netdev+bounces-142783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D69C057B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9571C208F4
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A3820F5DD;
	Thu,  7 Nov 2024 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="F/s6hjXr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786820F5BB;
	Thu,  7 Nov 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981826; cv=none; b=VyeGdQvw/KWUCw6bW3h+hWkfddQQF7SNuDx+20PULOkij9ypwziJjZEta0kvQPgbFecZ0qryOrkpCx+4+8CFkxGKBddFn9l0Nh7w9pGkEastYqWVF+77CIvFFISoh7YuEetP05pSOAJHpiae0Y9B3aNe++qIlZknPRuxSAngeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981826; c=relaxed/simple;
	bh=sZV0qxLvua5r1mJgF5G3A+imFVLb9qzB7bIzJ7vDtWI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=twRg0VTpwQ3JVJTYvoZlhr7rQ+QjoTQAhNC3Fp8VVGgv9lQdnemzJCczlOnalYOrRiktXN5wTnFQPM4HxTpkrPMJwNNuK9miOzbYjxETulIDliPXJC3J+u0SOxN3GG6eCxnv4Hl5gsnBlIH51qchKY86Ad3WyFyDsBfGMPODsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=F/s6hjXr; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A76ukrb008408;
	Thu, 7 Nov 2024 04:16:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=exzzD5vdwISfgk/7qU0wg54
	0Ri7ikeozSsfwwvDRcXQ=; b=F/s6hjXrjcazqhZGJq3PIvY2PqkEyM9H5e1EP0z
	7biXOb5UoCAt2x7CqTeos6gjUtVjVzw+yD5NiFFH1hYqi/pxnchN3P63knJCvuIV
	vUA/yu36EWCNQVLPib2uc2eDidIPn+dW2E/b8sdQJ8HGRu+XqK3AxLjAs0tpf0bc
	02MYLdhdOj8Vh0QqCshQ8LJ8laC5Cv1OQqUT9BCPklZFVWoFcM3GDXpNG4xsAOHC
	+JiV2vBWC0yBLX01V6vuwp72yMP1ikkFJlqMwSQyYUp3OiAD1GSTgPDdwqlQ2Iio
	IjF6wMKZdghX0+e3bOZv+H8ime1zn/Q32OLON27KTyl47nA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42rrqa8j2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 04:16:44 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 04:16:43 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 04:16:43 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id ED9433F7050;
	Thu,  7 Nov 2024 04:16:42 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <frank.feng@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net-next] octeon_ep: add ndo ops for VFs in PF driver
Date: Thu, 7 Nov 2024 04:16:37 -0800
Message-ID: <20241107121637.1117089-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dDrU9BrqxZD2ywOcd8DlwqmkHbG2ap4Q
X-Proofpoint-GUID: dDrU9BrqxZD2ywOcd8DlwqmkHbG2ap4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

These APIs are needed to support applicaitons that use netlink to get VF
information from a PF driver.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../ethernet/marvell/octeon_ep/octep_main.c   | 98 +++++++++++++++++++
 .../ethernet/marvell/octeon_ep/octep_main.h   |  1 +
 .../marvell/octeon_ep/octep_pfvf_mbox.c       | 22 ++++-
 .../marvell/octeon_ep/octep_pfvf_mbox.h       |  3 +
 4 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..129c68f5a4ba 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1137,6 +1137,95 @@ static int octep_set_features(struct net_device *dev, netdev_features_t features
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
+	int i, err;
+
+	if (!is_valid_ether_addr(mac)) {
+		dev_err(&oct->pdev->dev, "Invalid  MAC Address %pM\n", mac);
+		return -EADDRNOTAVAIL;
+	}
+
+	dev_dbg(&oct->pdev->dev, "set vf-%d mac to %pM\n", vf, mac);
+	for (i = 0; i < ETH_ALEN; i++)
+		oct->vf_info[vf].mac_addr[i] = mac[i];
+	oct->vf_info[vf].flags |=  OCTEON_PFVF_FLAG_MAC_SET_BY_PF;
+
+	err = octep_ctrl_net_set_mac_addr(oct, vf, mac, true);
+	if (err) {
+		dev_err(&oct->pdev->dev, "Set VF%d MAC address failed via host control Mbox\n", vf);
+		return err;
+	}
+
+	return 0;
+}
+
+static int octep_set_vf_vlan(struct net_device *dev, int vf, u16 vlan, u8 qos, __be16 vlan_proto)
+{
+	struct octep_device *oct = netdev_priv(dev);
+
+	dev_err(&oct->pdev->dev, "Setting VF VLAN not supported\n");
+	return 0;
+}
+
+static int octep_set_vf_spoofchk(struct net_device *dev, int vf, bool setting)
+{
+	struct octep_device *oct = netdev_priv(dev);
+
+	dev_err(&oct->pdev->dev, "Setting VF spoof check not supported\n");
+	return 0;
+}
+
+static int octep_set_vf_trust(struct net_device *dev, int vf, bool setting)
+{
+	struct octep_device *oct = netdev_priv(dev);
+
+	dev_err(&oct->pdev->dev, "Setting VF trust not supported\n");
+	return 0;
+}
+
+static int octep_set_vf_rate(struct net_device *dev, int vf, int min_tx_rate, int max_tx_rate)
+{
+	struct octep_device *oct = netdev_priv(dev);
+
+	dev_err(&oct->pdev->dev, "Setting VF rate not supported\n");
+	return 0;
+}
+
+static int octep_set_vf_link_state(struct net_device *dev, int vf, int link_state)
+{
+	struct octep_device *oct = netdev_priv(dev);
+
+	dev_err(&oct->pdev->dev, "Setting VF link state not supported\n");
+	return 0;
+}
+
+static int octep_get_vf_stats(struct net_device *dev, int vf, struct ifla_vf_stats *vf_stats)
+{
+	struct octep_device *oct = netdev_priv(dev);
+
+	dev_err(&oct->pdev->dev, "Getting VF stats not supported\n");
+	return 0;
+}
+
 static const struct net_device_ops octep_netdev_ops = {
 	.ndo_open                = octep_open,
 	.ndo_stop                = octep_stop,
@@ -1146,6 +1235,15 @@ static const struct net_device_ops octep_netdev_ops = {
 	.ndo_set_mac_address     = octep_set_mac,
 	.ndo_change_mtu          = octep_change_mtu,
 	.ndo_set_features        = octep_set_features,
+	/* for VFs */
+	.ndo_get_vf_config       = octep_get_vf_config,
+	.ndo_set_vf_mac          = octep_set_vf_mac,
+	.ndo_set_vf_vlan         = octep_set_vf_vlan,
+	.ndo_set_vf_spoofchk     = octep_set_vf_spoofchk,
+	.ndo_set_vf_trust        = octep_set_vf_trust,
+	.ndo_set_vf_rate         = octep_set_vf_rate,
+	.ndo_set_vf_link_state   = octep_set_vf_link_state,
+	.ndo_get_vf_stats        = octep_get_vf_stats,
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
index e6eb98d70f3c..be21ad5ec75e 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -156,12 +156,23 @@ static void octep_pfvf_set_mac_addr(struct octep_device *oct,  u32 vf_id,
 {
 	int err;
 
+	if (oct->vf_info[vf_id].flags & OCTEON_PFVF_FLAG_MAC_SET_BY_PF) {
+		dev_err(&oct->pdev->dev,
+			"VF%d attampted to override administrative set MAC address\n",
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


