Return-Path: <netdev+bounces-102650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD8D904133
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F406289296
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7E81AC8;
	Tue, 11 Jun 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KSqLXNk9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A343AB4;
	Tue, 11 Jun 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122991; cv=none; b=cumUbHGVvLK1xOao9A9ifQi6i09wHJTDr0uEzvWUU9Ev+ZLnaE7g1sKb1Cvd6iG4D7TmVpWm2K8UhdpyIQHLBDlh5uOBPXZMT4MjhXedHIepQQ4DwZzWAWDwUgqVdEoYNbjkCyfvkkJCDYjs/v3fINUrqgI9E/8ktaXLN3Fw7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122991; c=relaxed/simple;
	bh=m5UE1MiwSmATBLpmwbRdWhRqhM/mEKs4X2RVg6dEgsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUmzVByT57XQ1AuIu10waufEGkDB77by2DextCm4Si6qdhny2Yl1OWAE3JyCzbvPColYXNtz7xDevfZ0QpRStO6fiL3ICB5do2vZfTHNK4PkgAMB7Gde/6gWnuZmpNbW+hHPz6YclNisFwS5qM6QoJOWgXf3VHpEpy0Y4m+KA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KSqLXNk9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BGJRiu021185;
	Tue, 11 Jun 2024 09:22:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=y0whBG5VzxLNn5/8tDUFHBocf
	GMBvnXU/5WiaR7V9GI=; b=KSqLXNk9hbSqap1dt2wrO0rhC4zadRkJuUx//t1pS
	s54laxjMxsDkHOSvF/87fFJUXjdLcBaKyJPoezNlPQBeMfKqA8qrlEmZbes6LNzQ
	wttpe80DYl1vAOlVQfNlwrJEQCaNHKvncAS0Wu0g+XqmWS7Uwz0LkpozemVQ+vpz
	QD53u/4YQeqno+uFPe2t48I0hSyn+94+MoHV4Bx0MF3TlUCTksfV8SJPt4d/tfny
	oYU+5gHHSQ4hZipObWfsD3wxxdQmcgMt9JJAgP8dLWq3ULvJZ2euRWz19yfMspUZ
	BewUKYa6xoq1IjL4Hzbx8QfSrj6/chQXX1w2N0dmiSeIw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ypmq0hcu4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 09:22:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 11 Jun 2024 09:22:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 11 Jun 2024 09:22:52 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id B51603F7059;
	Tue, 11 Jun 2024 09:22:49 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v5 10/10] octeontx2-pf: Add devlink port support
Date: Tue, 11 Jun 2024 21:52:13 +0530
Message-ID: <20240611162213.22213-11-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240611162213.22213-1-gakula@marvell.com>
References: <20240611162213.22213-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: OifaibnbaQWKG9k9aLkCjNtOBACoXjZT
X-Proofpoint-ORIG-GUID: OifaibnbaQWKG9k9aLkCjNtOBACoXjZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01

Register devlink port for the rvu representors.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 74 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  2 +
 2 files changed, 76 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index d984b7d9dc64..2a0ec4c25c22 100644
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
@@ -338,6 +405,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
 	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
 		rep = priv->reps[rep_id];
 		unregister_netdev(rep->netdev);
+		rvu_rep_devlink_port_unregister(rep);
 		free_netdev(rep->netdev);
 	}
 	kfree(priv->reps);
@@ -380,6 +448,11 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
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
@@ -400,6 +473,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
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


