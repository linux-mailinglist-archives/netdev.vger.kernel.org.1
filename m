Return-Path: <netdev+bounces-142909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E1A9C0AF3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87ACC281E48
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED04217F25;
	Thu,  7 Nov 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HBg/cKXP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A347821766E;
	Thu,  7 Nov 2024 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995770; cv=none; b=M8kV0c5Y+uaCaePedPtpc7elazfjSofuLRiDuQj9navBLu4XoqcRaU4pNnnlT9oJAfV6YVDbsMviQSk8YGSQnCyKBUss7NeOuxwna7099/1pHATU5U9NcaDOQWIppbdR47ItvH+ymGikKubv/h4ZevDByU7/WDQHzTXY1MZxZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995770; c=relaxed/simple;
	bh=4/cFH9e/JCbsBBZrOWxmo/FlsggDvtxCOgPFWgqytsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBFOLGKrBM2WK1P3bKMDi3iK9GuHY8zRsEFZqRXkiPanymMNEd7NlkuUFhg1FlUREXKGl56DYg5Y75kHisgHn9qyXIV6BL/s9fLRubvq5u4Gg5pZo2iCy6jgIGGHrIMg9cZ+ywYWiHP9H/AhVNFAgJcf0+9N8h55vdiTQN4p+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HBg/cKXP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7B6kWu011000;
	Thu, 7 Nov 2024 08:09:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=tpDkcJclJcOIsyDDqm0r83WxU
	UJGX4LaWggbQmpw3T0=; b=HBg/cKXPkvw5a3jYTRYEybUCVLxHhdNzjgXNwYFiN
	Lk49LKQX3IPxZF8SnhTP3pMBqDzFKdv3zlCt3sIJHq3d9AdVZL4Y6hZagYCYKQ/J
	qcAClDCFgqm9OOMxmw5fm9O0vtOyoYCSGXs77lyOYV/luEHsHj/TQa+L46Z0UZBD
	Ry2JDY9MeP9+Xnour80g3M5KL0MEvSuP0//beBP6FHplGnvJOMIerbOYF/S4XEAs
	n8cp1phkpCT0MHd+hc1M31KN7QEWGf1PpftUqRcJ/3Z/J1mzS+yQ/F+oVXJc2+6Z
	lyddr1+vCLJpfxcSAyD8O4fph6b2OJWI9/EfyYjeAI+ZQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42rvcw0pf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:09:21 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 08:09:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 08:09:20 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id A74273F7050;
	Thu,  7 Nov 2024 08:09:16 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v12 09/12] octeontx2-pf: Add devlink port support
Date: Thu, 7 Nov 2024 21:38:36 +0530
Message-ID: <20241107160839.23707-10-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241107160839.23707-1-gakula@marvell.com>
References: <20241107160839.23707-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Pqoummvo8pC8CU0_FB_bYsO_qksl3Df0
X-Proofpoint-GUID: Pqoummvo8pC8CU0_FB_bYsO_qksl3Df0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Register devlink port for the rvu representors.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v11-v2:
 - Used container_of to get rep_dev pointer.
 - Added code to forward the updated mac address to VF.
 
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 +
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   |  4 +
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 90 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  2 +
 4 files changed, 98 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index b583c964d30c..62c07407eb94 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1583,6 +1583,7 @@ struct rep_evt_data {
 	u16 rx_mode;
 	u16 rx_flags;
 	u16 mtu;
+	u8 mac[ETH_ALEN];
 	u64 rsvd[5];
 };
 
@@ -1593,6 +1594,7 @@ struct rep_event {
 #define RVU_EVENT_PFVF_STATE		BIT_ULL(1)
 #define RVU_EVENT_MTU_CHANGE		BIT_ULL(2)
 #define RVU_EVENT_RX_MODE_CHANGE	BIT_ULL(3)
+#define RVU_EVENT_MAC_ADDR_CHANGE	BIT_ULL(4)
 	u16 event;
 	struct rep_evt_data evt_data;
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 80947fa28138..97b682291e3f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -35,11 +35,15 @@ MBOX_UP_REP_MESSAGES
 
 static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
 {
+	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, event->pcifunc);
 	struct rep_event *msg;
 	int pf;
 
 	pf = rvu_get_pf(event->pcifunc);
 
+	if (event->event & RVU_EVENT_MAC_ADDR_CHANGE)
+		ether_addr_copy(pfvf->mac_addr, event->evt_data.mac);
+
 	mutex_lock(&rvu->mbox_lock);
 	msg = otx2_mbox_alloc_msg_rep_event_up_notify(rvu, pf);
 	if (!msg) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index d4e78015ef71..15e775027c38 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,89 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static int rvu_rep_notify_pfvf(struct otx2_nic *priv, u16 event,
+			       struct rep_event *data);
+
+static int rvu_rep_dl_port_fn_hw_addr_get(struct devlink_port *port,
+					  u8 *hw_addr, int *hw_addr_len,
+					  struct netlink_ext_ack *extack)
+{
+	struct rep_dev *rep = container_of(port, struct rep_dev, dl_port);
+
+	ether_addr_copy(hw_addr, rep->mac);
+	*hw_addr_len = ETH_ALEN;
+	return 0;
+}
+
+static int rvu_rep_dl_port_fn_hw_addr_set(struct devlink_port *port,
+					  const u8 *hw_addr, int hw_addr_len,
+					  struct netlink_ext_ack *extack)
+{
+	struct rep_dev *rep = container_of(port, struct rep_dev, dl_port);
+	struct otx2_nic *priv = rep->mdev;
+	struct rep_event evt = {0};
+
+	eth_hw_addr_set(rep->netdev, hw_addr);
+	ether_addr_copy(rep->mac, hw_addr);
+
+	ether_addr_copy(evt.evt_data.mac, hw_addr);
+	evt.pcifunc = rep->pcifunc;
+	rvu_rep_notify_pfvf(priv, RVU_EVENT_MAC_ADDR_CHANGE, &evt);
+	return 0;
+}
+
+static const struct devlink_port_ops rvu_rep_dl_port_ops = {
+	.port_fn_hw_addr_get = rvu_rep_dl_port_fn_hw_addr_get,
+	.port_fn_hw_addr_set = rvu_rep_dl_port_fn_hw_addr_set,
+};
+
+static void
+rvu_rep_devlink_set_switch_id(struct otx2_nic *priv,
+			      struct netdev_phys_item_id *ppid)
+{
+	struct pci_dev *pdev = priv->pdev;
+	u64 id;
+
+	id = pci_get_dsn(pdev);
+
+	ppid->id_len = sizeof(id);
+	put_unaligned_be64(id, &ppid->id);
+}
+
+static void rvu_rep_devlink_port_unregister(struct rep_dev *rep)
+{
+	devlink_port_unregister(&rep->dl_port);
+}
+
+static int rvu_rep_devlink_port_register(struct rep_dev *rep)
+{
+	struct devlink_port_attrs attrs = {};
+	struct otx2_nic *priv = rep->mdev;
+	struct devlink *dl = priv->dl->dl;
+	int err;
+
+	if (!(rep->pcifunc & RVU_PFVF_FUNC_MASK)) {
+		attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+		attrs.phys.port_number = rvu_get_pf(rep->pcifunc);
+	} else {
+		attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
+		attrs.pci_vf.pf = rvu_get_pf(rep->pcifunc);
+		attrs.pci_vf.vf = rep->pcifunc & RVU_PFVF_FUNC_MASK;
+	}
+
+	rvu_rep_devlink_set_switch_id(priv, &attrs.switch_id);
+	devlink_port_attrs_set(&rep->dl_port, &attrs);
+
+	err = devl_port_register_with_ops(dl, &rep->dl_port, rep->rep_id,
+					  &rvu_rep_dl_port_ops);
+	if (err) {
+		dev_err(rep->mdev->dev, "devlink_port_register failed: %d\n",
+			err);
+		return err;
+	}
+	return 0;
+}
+
 static int rvu_rep_get_repid(struct otx2_nic *priv, u16 pcifunc)
 {
 	int rep_id;
@@ -386,6 +469,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
 	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
 		rep = priv->reps[rep_id];
 		unregister_netdev(rep->netdev);
+		rvu_rep_devlink_port_unregister(rep);
 		free_netdev(rep->netdev);
 	}
 	kfree(priv->reps);
@@ -439,6 +523,11 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 
 		ndev->features |= ndev->hw_features;
 		eth_hw_addr_random(ndev);
+		err = rvu_rep_devlink_port_register(rep);
+		if (err)
+			goto exit;
+
+		SET_NETDEV_DEVLINK_PORT(ndev, &rep->dl_port);
 		err = register_netdev(ndev);
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack,
@@ -459,6 +548,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 	while (--rep_id >= 0) {
 		rep = priv->reps[rep_id];
 		unregister_netdev(rep->netdev);
+		rvu_rep_devlink_port_unregister(rep);
 		free_netdev(rep->netdev);
 	}
 	kfree(priv->reps);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index 7230061e9671..163913c3b30f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -34,10 +34,12 @@ struct rep_dev {
 	struct net_device *netdev;
 	struct rep_stats stats;
 	struct delayed_work stats_wrk;
+	struct devlink_port dl_port;
 #define RVU_REP_VF_INITIALIZED		BIT_ULL(0)
 	u64 flags;
 	u16 rep_id;
 	u16 pcifunc;
+	u8 mac[ETH_ALEN];
 };
 
 static inline bool otx2_rep_dev(struct pci_dev *pdev)
-- 
2.25.1


