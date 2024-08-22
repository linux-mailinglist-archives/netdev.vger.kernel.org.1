Return-Path: <netdev+bounces-121019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E977C95B66E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663A41F22010
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A61CCEEF;
	Thu, 22 Aug 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LEFMq97A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D988136354;
	Thu, 22 Aug 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332888; cv=none; b=Lw5QS73L3xSH6fltVIS/DHTtm+Dr1n5usp/nTkM4pCPjtdqUpvZzOlOd9MZv1tdrr8vaweTsvGi0kGdAGXCY/OGRsxUUwiBcI9cXctsk9zMYilwI3vQwPOXqa/wPfygSgg5KbQKu5Aii/ZWFaCPJ6s+gQHJQ0z/KfZYHtwtmmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332888; c=relaxed/simple;
	bh=bExkVKVk88L8qRM9/A1GTD213UAEp48mAtYDlazYQLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oay4QnLfPswmKK7pe6dggE4HcgA3e7Y+F2zzpPf4tPZTMfVEa+xGHc/iU3ryVseHilmzMqnn107Dq5jG7VtCTCc6vHapN/kl8Yj7cuY5STkRiobT9ZhoiAxNfGTfGEQL3c+WX4/y7FpBYpCS7k5MH6Dowye2b6TUh7ED5CN0lgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LEFMq97A; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MC45CN006004;
	Thu, 22 Aug 2024 06:21:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=gT4F9O9rXadxrLxPEb6/Vxxh1
	7sHE+jVCA+vlFViR8E=; b=LEFMq97ABvi7qWtk2KzhrfUHkxaEDB+ccyQWhgIYs
	m2KdCLmntF98Resa1BR1bM7QSb3WIQND9RqZrD3n+hRTpbamJBe9Gfxl9+o8RrJf
	B/P8vtMyvuHwvCr7l1eYX+9Ykhf/aDIfmw6UiuW13yFdv4mXy3UCQWD7kRpZYNGd
	XcGZFqTP13kKKaDuq0M67QBYULqeQFp3gVh2r69V85V8vC79SmgOJoFkfzBElXk3
	+YOp+6/wPOMXrf87tJ3UDYuQ5KGp+6mw83gpD4Jh1H65LunacMq6k28Q1DlFO/LI
	ZX1J9BgpF0szPrDpZl0wvqm7L/cOX4h4tV/CN7wTf8DjA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41650urbar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 06:21:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 Aug 2024 06:21:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 22 Aug 2024 06:21:16 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 0C6113F70CE;
	Thu, 22 Aug 2024 06:21:12 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v11 10/11] octeontx2-pf: Add devlink port support
Date: Thu, 22 Aug 2024 18:50:30 +0530
Message-ID: <20240822132031.29494-11-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240822132031.29494-1-gakula@marvell.com>
References: <20240822132031.29494-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: GvKDiuCN-hUi9McyDt_elnVRWbzNt2D6
X-Proofpoint-ORIG-GUID: GvKDiuCN-hUi9McyDt_elnVRWbzNt2D6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_06,2024-08-22_01,2024-05-17_01

Register devlink port for the rvu representors.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../ethernet/marvell/octeontx2.rst            | 39 ++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 91 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  2 +
 3 files changed, 132 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
index 1132ae2d007c..33258cc18f45 100644
--- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
@@ -393,3 +393,42 @@ To remove the representors devices from the system. Change the device to legacy
  - Change device to legacy mode::
 
 	# devlink dev eswitch set pci/0002:1c:00.0 mode legacy
+
+
+RVU representors can be managed using devlink ports
+(see :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>`) interface.
+
+ - Show devlink ports of representors::
+
+	# devlink port
+
+Sample output::
+
+	# devlink port
+	pci/0002:1c:00.0/0: type eth netdev pf1vf0rep flavour physical port 1 splittable false
+	pci/0002:1c:00.0/1: type eth netdev pf1vf1rep flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false
+	pci/0002:1c:00.0/2: type eth netdev pf1vf2rep flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
+	pci/0002:1c:00.0/3: type eth netdev pf1vf3rep flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false
+
+Function attributes
+===================
+
+The RVU representor support function attributes for representors.
+Port function configuration of the representors are supported through devlink eswitch port.
+
+MAC address setup
+-----------------
+
+RVU representor driver support devlink port function attr mechanism to setup MAC
+address. (refer to Documentation/networking/devlink/devlink-port.rst)
+
+ - To setup MAC address for port 2::
+
+	# devlink port function set pci/0002:1c:00.0/2 hw_addr 5c:a1:1b:5e:43:11
+
+Sample output::
+
+	# devlink port show pci/0002:1c:00.0/2
+	pci/0002:1c:00.0/2: type eth netdev pf1vf2rep flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
+	function:
+		hw_addr 5c:a1:1b:5e:43:11
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 5f767b6e79c3..aab1784b5134 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,90 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static int rvu_rep_dl_port_fn_hw_addr_get(struct devlink_port *port,
+					  u8 *hw_addr, int *hw_addr_len,
+					  struct netlink_ext_ack *extack)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(port->devlink);
+	int rep_id = port->index;
+	struct otx2_nic *priv;
+	struct rep_dev *rep;
+
+	priv = otx2_dl->pfvf;
+	rep = priv->reps[rep_id];
+	ether_addr_copy(hw_addr, rep->mac);
+	*hw_addr_len = ETH_ALEN;
+	return 0;
+}
+
+static int rvu_rep_dl_port_fn_hw_addr_set(struct devlink_port *port,
+					  const u8 *hw_addr, int hw_addr_len,
+					  struct netlink_ext_ack *extack)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(port->devlink);
+	int rep_id = port->index;
+	struct otx2_nic *priv;
+	struct rep_dev *rep;
+
+	priv = otx2_dl->pfvf;
+	rep = priv->reps[rep_id];
+	eth_hw_addr_set(rep->netdev, hw_addr);
+	ether_addr_copy(rep->mac, hw_addr);
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
@@ -339,6 +423,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
 	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
 		rep = priv->reps[rep_id];
 		unregister_netdev(rep->netdev);
+		rvu_rep_devlink_port_unregister(rep);
 		free_netdev(rep->netdev);
 	}
 	kfree(priv->reps);
@@ -381,6 +466,11 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 		snprintf(ndev->name, sizeof(ndev->name), "p%dv%drep",
 			 rvu_get_pf(pcifunc), (pcifunc & RVU_PFVF_FUNC_MASK));
 
+		err = rvu_rep_devlink_port_register(rep);
+		if (err)
+			goto exit;
+
+		SET_NETDEV_DEVLINK_PORT(ndev, &rep->dl_port);
 		eth_hw_addr_random(ndev);
 		err = register_netdev(ndev);
 		if (err) {
@@ -402,6 +492,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 	while (--rep_id >= 0) {
 		rep = priv->reps[rep_id];
 		unregister_netdev(rep->netdev);
+		rvu_rep_devlink_port_unregister(rep);
 		free_netdev(rep->netdev);
 	}
 	kfree(priv->reps);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index 0cefa482f83c..d81af376bf50 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -34,10 +34,12 @@ struct rep_dev {
 	struct net_device *netdev;
 	struct rep_stats stats;
 	struct delayed_work stats_wrk;
+	struct devlink_port dl_port;
 	u16 rep_id;
 	u16 pcifunc;
 #define RVU_REP_VF_INITIALIZED		BIT_ULL(0)
 	u8 flags;
+	u8	mac[ETH_ALEN];
 };
 
 static inline bool otx2_rep_dev(struct pci_dev *pdev)
-- 
2.25.1


