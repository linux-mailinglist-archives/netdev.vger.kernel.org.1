Return-Path: <netdev+bounces-107699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9991BFB1
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D851F23853
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98821C8FB2;
	Fri, 28 Jun 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fBMsZ5za"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319C1BE861;
	Fri, 28 Jun 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581765; cv=none; b=R+RWM6cdupE2Vt8ElIHH6YZ6JaZ6JKpMcc4etY65cMzg+3MTDxISCAesuHg+yGooP1mmG/QFjx0jBFxiwIzF5sQQhorCEvdoLm+sT2t7U3y2dn719AgkJYoByPPQQ1E080FjMMwdCRv05n7TA59zGoaPn2Xs0GvYEsMKJQswLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581765; c=relaxed/simple;
	bh=/jBv6+zQYz5Xnt2OI0F8VV6D+ZhfeD+JXXmuO5B4ttM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EC91utZ8klM+9p1xGnsbF1maIQboAoTtgMvENy8OzMeehuV+GyuFNkbCn4wXJCdC8CmPPdKavwfycv+ltrAkji+oRv769yQ9FmlXn9qnxdwLFBj4i7VC+j+DwELHeYpt6gvzgBgx0xULHGHegBDJTdVQuTzmDwk0OKqE435KhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fBMsZ5za; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SA194G027537;
	Fri, 28 Jun 2024 06:35:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=o8ymvUvGRClq0Xhmh3raIbx7z
	oL5etdJR0qeTeWCwUE=; b=fBMsZ5za0auENOLR4jRibNnjpdkF4aee35jPIsuBI
	c0n12D3mygGH6P6SEfEqwe8cWNHGRKh2SH9sYCBa4qZWDjO/jtl2dSFABfp231qh
	E1PTkygdkif0Bf2N+0ofD+mzLyx0cAlMxZIAqIcEeYck0Xw2rddN8zPZO83f/nk+
	7K8GSbGgtKFqpWhCBJ6ldrNtAqHP9IHG026S4lrZ2ugTA+xCadXd3eMA1HH4aQbd
	YIHok1g3IjPyJLJ0H2wWMvT6fgfjfpkL+uInsYw+M1JLpO+iDqBXko1yT4RQs9VT
	ChdjO1Mf1lm7cWaxEHslyH/NGge9cqkwO1XUkZAOv2NgA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 401c8hubpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:35:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 28 Jun 2024 06:35:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 28 Jun 2024 06:35:56 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 8C77A3F704E;
	Fri, 28 Jun 2024 06:35:53 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v7 10/10] octeontx2-pf: Add devlink port support
Date: Fri, 28 Jun 2024 19:05:17 +0530
Message-ID: <20240628133517.8591-11-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240628133517.8591-1-gakula@marvell.com>
References: <20240628133517.8591-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: CURmyp4frGo6_hE6wCkyDN2Y6GZAnhFk
X-Proofpoint-ORIG-GUID: CURmyp4frGo6_hE6wCkyDN2Y6GZAnhFk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_09,2024-06-28_01,2024-05-17_01

Register devlink port for the rvu representors.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 74 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  2 +
 2 files changed, 76 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index c37cbf440235..6939f213f9f8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,73 @@ MODULE_DESCRIPTION(DRV_STRING);
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
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_PF;
+	attrs.pci_vf.pf = rvu_get_pf(rep->pcifunc);
+	attrs.pci_vf.vf = rep->pcifunc & RVU_PFVF_FUNC_MASK;
+	if (attrs.pci_vf.vf)
+		attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
+
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
@@ -339,6 +406,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
 	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
 		rep = priv->reps[rep_id];
 		unregister_netdev(rep->netdev);
+		rvu_rep_devlink_port_unregister(rep);
 		free_netdev(rep->netdev);
 	}
 	kfree(priv->reps);
@@ -381,6 +449,11 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 		snprintf(ndev->name, sizeof(ndev->name), "r%dp%d", rep_id,
 			 rvu_get_pf(pcifunc));
 
+		err = rvu_rep_devlink_port_register(rep);
+		if (err)
+			goto exit;
+
+		SET_NETDEV_DEVLINK_PORT(ndev, &rep->dl_port);
 		eth_hw_addr_random(ndev);
 		err = register_netdev(ndev);
 		if (err) {
@@ -402,6 +475,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
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


