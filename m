Return-Path: <netdev+bounces-94193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F208BE9CA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3328B214D2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029DE16D30D;
	Tue,  7 May 2024 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BrVmiIs+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB216C87C;
	Tue,  7 May 2024 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099984; cv=none; b=L+vdm6TBdD1mf2rbGkjsUGmqBIfgkQKsbSYecTrsswPsBqZWurPoLvd0c2gN2/oB46GTVfsq1gSYS0QZttMFcjng+yJrHtpH9/C5NQx7dyYMKWUAEMV9XjFaXvl1SuHhFtPLY8WMsBr1NvXleKUt1CJ8LTddmda03qSs6HMrzdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099984; c=relaxed/simple;
	bh=NLOAkYGwNJu11eHgNp9gwDi+ovtBvDlxSyv5xNJz/d0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TW+BC8954Nn5NstXEOfshlukI2Oe1cmVdab/DjTh4tBWG3t7kXwr1oq9gQqblUDtkm5qBwWZMaQ5NhgVCcxO3cvyyU54tWjj2XlGogxHCYeLDDKKw1psH7IOjBbmILujkr0zSYnllTAb2fA1KBLeuyNgdCYY2pgELsw7/bM4ZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BrVmiIs+; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447F4MvH005008;
	Tue, 7 May 2024 09:39:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=lhHCuWIJrnTesQi07BUW6
	vSQmo+ntijasWApfN0SbQw=; b=BrVmiIs+TENT6HyVDFuj/5y79aFr0+DPRr9db
	PNHfnPq9sQxlX/Fn5UPCmdPeGk4yklTkq645aozXbMtR77lj3870tQ4zf6CUzmwj
	9l/4zX83mjmTjeUqPQ4r0xs0VxmmPoQk6zUguYubFMO+HhORVTVajlpIPuh3OGk1
	4Fjj0jvqlziPB1ADLNxMKxp8JyKGSr6+r26qAlzg4WW17r7lk+vz1NW4cXiAsWzX
	mbTNEvfUT/eyuaalk17sk3pNu6+HGDXHCu5QIDqbJ2pssUfR1iq5VLAp31owaDX9
	VT6OqJwQu6gT3xe84nIYMlPXF4UsrTksDcN/nH3ZFM6LVAW9w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xygt2tq1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 09:39:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 09:39:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 May 2024 09:39:36 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 386803F7041;
	Tue,  7 May 2024 09:39:32 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v4 03/10] octeontx2-pf: Create representor netdev
Date: Tue, 7 May 2024 22:09:14 +0530
Message-ID: <20240507163921.29683-4-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507163921.29683-1-gakula@marvell.com>
References: <20240507163921.29683-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Q64TKqSmIemCa5uJ6_64eZ8iIkTWpDxz
X-Proofpoint-GUID: Q64TKqSmIemCa5uJ6_64eZ8iIkTWpDxz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02

Adds initial devlink support to set/get the switchdev mode.
Representor netdevs are created for each rvu devices when
the switch mode is set to 'switchdev'. These netdevs are
be used to control and configure VFs.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 157 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |   2 +
 3 files changed, 208 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 99ddf31269d9..5d577b671686 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -77,7 +77,56 @@ static const struct devlink_param otx2_dl_params[] = {
 			     otx2_dl_mcam_count_validate),
 };
 
+#ifdef CONFIG_RVU_ESWITCH
+static int otx2_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+
+	if (!otx2_rep_dev(pfvf->pdev))
+		return -EOPNOTSUPP;
+
+	*mode = pfvf->esw_mode;
+
+	return 0;
+}
+
+static int otx2_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
+					 struct netlink_ext_ack *extack)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+	int ret = 0;
+
+	if (!otx2_rep_dev(pfvf->pdev))
+		return -EOPNOTSUPP;
+
+	if (pfvf->esw_mode == mode)
+		return 0;
+
+	switch (mode) {
+	case DEVLINK_ESWITCH_MODE_LEGACY:
+		rvu_rep_destroy(pfvf);
+		break;
+	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
+		ret = rvu_rep_create(pfvf, extack);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!ret)
+		pfvf->esw_mode = mode;
+
+	return ret;
+}
+#endif
+
 static const struct devlink_ops otx2_devlink_ops = {
+#ifdef CONFIG_RVU_ESWITCH
+	.eswitch_mode_get = otx2_devlink_eswitch_mode_get,
+	.eswitch_mode_set = otx2_devlink_eswitch_mode_set,
+#endif
 };
 
 int otx2_register_dl(struct otx2_nic *pfvf)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 33ebbcb223e1..ff4318f414f8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,157 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static int rvu_rep_napi_init(struct otx2_nic *priv, struct netlink_ext_ack *extack)
+{
+	struct otx2_cq_poll *cq_poll = NULL;
+	struct otx2_qset *qset = &priv->qset;
+	struct otx2_hw *hw = &priv->hw;
+	int err = 0, qidx, vec;
+	char *irq_name;
+
+	qset->napi = kcalloc(hw->cint_cnt, sizeof(*cq_poll), GFP_KERNEL);
+	if (!qset->napi)
+		return -ENOMEM;
+
+	/* Register NAPI handler */
+	for (qidx = 0; qidx < hw->cint_cnt; qidx++) {
+		cq_poll = &qset->napi[qidx];
+		cq_poll->cint_idx = qidx;
+		cq_poll->cq_ids[CQ_RX] =
+			(qidx <  hw->rx_queues) ? qidx : CINT_INVALID_CQ;
+		cq_poll->cq_ids[CQ_TX] = (qidx < hw->tx_queues) ?
+					  qidx + hw->rx_queues : CINT_INVALID_CQ;
+		cq_poll->cq_ids[CQ_XDP] = CINT_INVALID_CQ;
+		cq_poll->cq_ids[CQ_QOS] = CINT_INVALID_CQ;
+
+		cq_poll->dev = (void *)priv;
+		netif_napi_add(priv->reps[qidx]->netdev, &cq_poll->napi,
+			       otx2_napi_handler);
+		napi_enable(&cq_poll->napi);
+	}
+	/* Register CQ IRQ handlers */
+	vec = hw->nix_msixoff + NIX_LF_CINT_VEC_START;
+	for (qidx = 0; qidx < hw->cint_cnt; qidx++) {
+		irq_name = &hw->irq_name[vec * NAME_SIZE];
+
+		snprintf(irq_name, NAME_SIZE, "rep%d-rxtx-%d", qidx, qidx);
+
+		err = request_irq(pci_irq_vector(priv->pdev, vec),
+				  otx2_cq_intr_handler, 0, irq_name,
+				  &qset->napi[qidx]);
+		if (err) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "RVU REP IRQ registration failed for CQ%d",
+						qidx);
+			goto err_free_cints;
+		}
+		vec++;
+
+		/* Enable CQ IRQ */
+		otx2_write64(priv, NIX_LF_CINTX_INT(qidx), BIT_ULL(0));
+		otx2_write64(priv, NIX_LF_CINTX_ENA_W1S(qidx), BIT_ULL(0));
+	}
+	priv->flags &= ~OTX2_FLAG_INTF_DOWN;
+	return 0;
+
+err_free_cints:
+	otx2_free_cints(priv, qidx);
+	otx2_disable_napi(priv);
+	return err;
+}
+
+static void rvu_rep_free_cq_rsrc(struct otx2_nic *priv)
+{
+	struct otx2_cq_poll *cq_poll = NULL;
+	struct otx2_qset *qset = &priv->qset;
+	int qidx, vec;
+
+	/* Cleanup CQ NAPI and IRQ */
+	vec = priv->hw.nix_msixoff + NIX_LF_CINT_VEC_START;
+	for (qidx = 0; qidx < priv->hw.cint_cnt; qidx++) {
+		/* Disable interrupt */
+		otx2_write64(priv, NIX_LF_CINTX_ENA_W1C(qidx), BIT_ULL(0));
+
+		synchronize_irq(pci_irq_vector(priv->pdev, vec));
+
+		cq_poll = &qset->napi[qidx];
+		napi_synchronize(&cq_poll->napi);
+		vec++;
+	}
+	otx2_free_cints(priv, priv->hw.cint_cnt);
+	otx2_disable_napi(priv);
+}
+
+void rvu_rep_destroy(struct otx2_nic *priv)
+{
+	struct rep_dev *rep;
+	int rep_id;
+
+	rvu_rep_free_cq_rsrc(priv);
+	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
+		rep = priv->reps[rep_id];
+		unregister_netdev(rep->netdev);
+		free_netdev(rep->netdev);
+	}
+}
+
+int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
+{
+	int rep_cnt = priv->rep_cnt;
+	struct net_device *ndev;
+	struct rep_dev *rep;
+	int rep_id, err;
+	u16 pcifunc;
+
+	priv->reps = devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev *),
+				  GFP_KERNEL);
+	if (!priv->reps)
+		return -ENOMEM;
+
+	for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
+		ndev = alloc_etherdev(sizeof(*rep));
+		if (!ndev) {
+			NL_SET_ERR_MSG_FMT_MOD(extack, "PFVF representor:%d
+					       creation failed", rep_id);
+			err = -ENOMEM;
+			goto exit;
+		}
+
+		rep = netdev_priv(ndev);
+		priv->reps[rep_id] = rep;
+		rep->mdev = priv;
+		rep->netdev = ndev;
+		rep->rep_id = rep_id;
+
+		ndev->min_mtu = OTX2_MIN_MTU;
+		ndev->max_mtu = priv->hw.max_mtu;
+		pcifunc = priv->rep_pf_map[rep_id];
+		rep->pcifunc = pcifunc;
+
+		snprintf(ndev->name, sizeof(ndev->name), "r%dp%d", rep_id,
+			 rvu_get_pf(pcifunc));
+
+		eth_hw_addr_random(ndev);
+		err = register_netdev(ndev);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack, "PFVF reprentator registration failed");
+			goto exit;
+		}
+	}
+	err = rvu_rep_napi_init(priv, extack);
+	if (err)
+		goto exit;
+
+	return 0;
+exit:
+	while (--rep_id >= 0) {
+		rep = priv->reps[rep_id];
+		unregister_netdev(rep->netdev);
+		free_netdev(rep->netdev);
+	}
+	return err;
+}
+
 static int rvu_rep_rsrc_free(struct otx2_nic *priv)
 {
 	struct otx2_qset *qset = &priv->qset;
@@ -165,6 +316,10 @@ static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_detach_rsrc;
 
+	err = otx2_register_dl(priv);
+	if (err)
+		goto err_detach_rsrc;
+
 	return 0;
 
 err_detach_rsrc:
@@ -186,6 +341,8 @@ static void rvu_rep_remove(struct pci_dev *pdev)
 {
 	struct otx2_nic *priv = pci_get_drvdata(pdev);
 
+	otx2_unregister_dl(priv);
+	rvu_rep_destroy(priv);
 	rvu_rep_rsrc_free(priv);
 	otx2_detach_resources(&priv->mbox);
 	if (priv->hw.lmt_info)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index 9b3734146dd1..c04874c4d4c6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -29,4 +29,6 @@ static inline bool otx2_rep_dev(struct pci_dev *pdev)
 	return pdev->device == PCI_DEVID_RVU_REP;
 }
 
+int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack);
+void rvu_rep_destroy(struct otx2_nic *priv);
 #endif /* REP_H */
-- 
2.25.1


