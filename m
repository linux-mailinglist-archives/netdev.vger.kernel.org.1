Return-Path: <netdev+bounces-142902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA29C0ADE
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24932284ADA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6982170BE;
	Thu,  7 Nov 2024 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="f2VlnpGG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642EC216A31;
	Thu,  7 Nov 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995745; cv=none; b=KQ/iDGbJALnW/7tglyWLcyMZiGIYZ7fV5M71ov0Rr0+yBZ/DtSgLCNK2TTfQcftLVFVIdnHk7Q7V3LrenztqrSD7hOYXqrONJfGxl1lHin9wardTq3E5JQJOwojFopg92y/O5HFnOKf/2IVHHF/V4E+5j1Sg0enyiptEue9n5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995745; c=relaxed/simple;
	bh=IGS+P0tORyXpDCwSdS7FZlvcNEIIKhSphdYH+VQIVMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHbcDT4xOX2i7gxIkp4soI7iLitm3Gc2mN03XZ4tYAKtWZ6kxqfFpguQZVH0ScP/4WPpKb+NnF0ms9lGiB4X+yNU7NsDCmkqHPQvLTTBLd9xAm/+gmvzsdXJKxFK4wPDegrc36Pps5Oo77tPgyV1YwRb5Xy+oUfGX5qA5Uef7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=f2VlnpGG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Ca6QA018136;
	Thu, 7 Nov 2024 08:08:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=MVq88qWJgF5mzury7PoORK2kA
	wxFy/+OHEbqg6iTXuE=; b=f2VlnpGG2kp6OGgn0L2mEA2GrEYs+3JH/vdjFPAOq
	wQuOaKRFFZxRZa+4BHhsyFPXNWLOI3zf8bYtUP8MTs9GyNZK9woXpeDk1lyi0tau
	126g8QbnZlnbZkVzSIvclvtdmeWJoZ69KbRJGsejBEn/v7GsEk2c+feYvoQGEz1G
	2TGRV1RH1MHoABr1JQxrDxlaQn9un0OvGqNkiilwx2PDHaYA3gEKyuF2glRb6xh0
	jGBTTq7j5UYh5ecwLX3sOsxrDPeEBQzWq4yfR6JuORYo4T9R0+80TtrrFuW1bvSC
	Vs4cPuacqytO4IucEvI58Jx9zkXGA/YhP3MhBdCWgiVHg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42rwpngh3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:08:53 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 08:08:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 08:08:52 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 00CAC3F7050;
	Thu,  7 Nov 2024 08:08:48 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v12 02/12] octeontx2-pf: Create representor netdev
Date: Thu, 7 Nov 2024 21:38:29 +0530
Message-ID: <20241107160839.23707-3-gakula@marvell.com>
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
X-Proofpoint-GUID: b9tS6RVIjd1oQILEU_ZAQ_0oj-1swGd0
X-Proofpoint-ORIG-GUID: b9tS6RVIjd1oQILEU_ZAQ_0oj-1swGd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Adds initial devlink support to set/get the switchdev mode.
Representor netdevs are created for each rvu devices when
the switch mode is set to 'switchdev'. These netdevs are
be used to control and configure VFs.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       |   2 +
 .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   7 +
 .../marvell/octeontx2/nic/otx2_txrx.c         |   1 +
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 223 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |   3 +
 6 files changed, 285 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 6e0183f0d5a1..8b6e60dde684 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -246,6 +246,7 @@ int otx2_hw_set_mtu(struct otx2_nic *pfvf, int mtu)
 	mutex_unlock(&pfvf->mbox.lock);
 	return err;
 }
+EXPORT_SYMBOL(otx2_hw_set_mtu);
 
 int otx2_config_pause_frm(struct otx2_nic *pfvf)
 {
@@ -1782,6 +1783,7 @@ void otx2_free_cints(struct otx2_nic *pfvf, int n)
 		free_irq(vector, &qset->napi[qidx]);
 	}
 }
+EXPORT_SYMBOL(otx2_free_cints);
 
 void otx2_set_cints_affinity(struct otx2_nic *pfvf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 53f14aa944bd..33ec9a7f7c03 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -141,7 +141,56 @@ static const struct devlink_param otx2_dl_params[] = {
 			     otx2_dl_ucast_flt_cnt_validate),
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 8905cc6413ac..c35327a10bc9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1400,6 +1400,7 @@ irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL(otx2_cq_intr_handler);
 
 void otx2_disable_napi(struct otx2_nic *pf)
 {
@@ -1417,6 +1418,7 @@ void otx2_disable_napi(struct otx2_nic *pf)
 		netif_napi_del(&cq_poll->napi);
 	}
 }
+EXPORT_SYMBOL(otx2_disable_napi);
 
 static void otx2_free_cq_res(struct otx2_nic *pf)
 {
@@ -1607,6 +1609,7 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
 	mutex_unlock(&mbox->lock);
 	return err;
 }
+EXPORT_SYMBOL(otx2_init_hw_resources);
 
 void otx2_free_hw_resources(struct otx2_nic *pf)
 {
@@ -1696,6 +1699,7 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
 	}
 	mutex_unlock(&mbox->lock);
 }
+EXPORT_SYMBOL(otx2_free_hw_resources);
 
 static bool otx2_promisc_use_mce_list(struct otx2_nic *pfvf)
 {
@@ -1789,6 +1793,7 @@ void otx2_free_queue_mem(struct otx2_qset *qset)
 	kfree(qset->napi);
 	qset->napi = NULL;
 }
+EXPORT_SYMBOL(otx2_free_queue_mem);
 
 int otx2_alloc_queue_mem(struct otx2_nic *pf)
 {
@@ -1835,6 +1840,7 @@ int otx2_alloc_queue_mem(struct otx2_nic *pf)
 	otx2_free_queue_mem(qset);
 	return -ENOMEM;
 }
+EXPORT_SYMBOL(otx2_alloc_queue_mem);
 
 int otx2_open(struct net_device *netdev)
 {
@@ -2866,6 +2872,7 @@ int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 
 	return otx2_register_mbox_intr(pf, false);
 }
+EXPORT_SYMBOL(otx2_realloc_msix_vectors);
 
 static int otx2_sriov_vfcfg_init(struct otx2_nic *pf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 7aaf32e9aa95..9b4e4c5b1468 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -594,6 +594,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 	}
 	return workdone;
 }
+EXPORT_SYMBOL(otx2_napi_handler);
 
 void otx2_sqe_flush(void *dev, struct otx2_snd_queue *sq,
 		    int size, int qidx)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 284bceef448a..fda01a485b61 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,222 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static int rvu_rep_napi_init(struct otx2_nic *priv,
+			     struct netlink_ext_ack *extack)
+{
+	struct otx2_qset *qset = &priv->qset;
+	struct otx2_cq_poll *cq_poll = NULL;
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
+					  qidx + hw->rx_queues :
+					  CINT_INVALID_CQ;
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
+					       qidx);
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
+	struct otx2_qset *qset = &priv->qset;
+	struct otx2_cq_poll *cq_poll = NULL;
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
+static void rvu_rep_rsrc_free(struct otx2_nic *priv)
+{
+	struct otx2_qset *qset = &priv->qset;
+	struct delayed_work *work;
+	int wrk;
+
+	for (wrk = 0; wrk < priv->qset.cq_cnt; wrk++) {
+		work = &priv->refill_wrk[wrk].pool_refill_work;
+		cancel_delayed_work_sync(work);
+	}
+	devm_kfree(priv->dev, priv->refill_wrk);
+
+	otx2_free_hw_resources(priv);
+	otx2_free_queue_mem(qset);
+}
+
+static int rvu_rep_rsrc_init(struct otx2_nic *priv)
+{
+	struct otx2_qset *qset = &priv->qset;
+	int err;
+
+	err = otx2_alloc_queue_mem(priv);
+	if (err)
+		return err;
+
+	priv->hw.max_mtu = otx2_get_max_mtu(priv);
+	priv->tx_max_pktlen = priv->hw.max_mtu + OTX2_ETH_HLEN;
+	priv->rbsize = ALIGN(priv->hw.rbuf_len, OTX2_ALIGN) + OTX2_HEAD_ROOM;
+
+	err = otx2_init_hw_resources(priv);
+	if (err)
+		goto err_free_rsrc;
+
+	/* Set maximum frame size allowed in HW */
+	err = otx2_hw_set_mtu(priv, priv->hw.max_mtu);
+	if (err) {
+		dev_err(priv->dev, "Failed to set HW MTU\n");
+		goto err_free_rsrc;
+	}
+	return 0;
+
+err_free_rsrc:
+	otx2_free_hw_resources(priv);
+	otx2_free_queue_mem(qset);
+	return err;
+}
+
+void rvu_rep_destroy(struct otx2_nic *priv)
+{
+	struct rep_dev *rep;
+	int rep_id;
+
+	priv->flags |= OTX2_FLAG_INTF_DOWN;
+	rvu_rep_free_cq_rsrc(priv);
+	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
+		rep = priv->reps[rep_id];
+		unregister_netdev(rep->netdev);
+		free_netdev(rep->netdev);
+	}
+	kfree(priv->reps);
+	rvu_rep_rsrc_free(priv);
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
+	err = rvu_rep_rsrc_init(priv);
+	if (err)
+		return -ENOMEM;
+
+	priv->reps = kcalloc(rep_cnt, sizeof(struct rep_dev *), GFP_KERNEL);
+	if (!priv->reps)
+		return -ENOMEM;
+
+	for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
+		ndev = alloc_etherdev(sizeof(*rep));
+		if (!ndev) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "PFVF representor:%d creation failed",
+					       rep_id);
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
+		snprintf(ndev->name, sizeof(ndev->name), "Rpf%dvf%d",
+			 rvu_get_pf(pcifunc), (pcifunc & RVU_PFVF_FUNC_MASK));
+
+		ndev->hw_features = (NETIF_F_RXCSUM | NETIF_F_IP_CSUM |
+			       NETIF_F_IPV6_CSUM | NETIF_F_RXHASH |
+			       NETIF_F_SG | NETIF_F_TSO | NETIF_F_TSO6);
+
+		ndev->features |= ndev->hw_features;
+		eth_hw_addr_random(ndev);
+		err = register_netdev(ndev);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "PFVF reprentator registration failed");
+			free_netdev(ndev);
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
+	kfree(priv->reps);
+	rvu_rep_rsrc_free(priv);
+	return err;
+}
+
 static int rvu_get_rep_cnt(struct otx2_nic *priv)
 {
 	struct get_rep_cnt_rsp *rsp;
@@ -118,6 +334,10 @@ static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_detach_rsrc;
 
+	err = otx2_register_dl(priv);
+	if (err)
+		goto err_detach_rsrc;
+
 	return 0;
 
 err_detach_rsrc:
@@ -139,6 +359,9 @@ static void rvu_rep_remove(struct pci_dev *pdev)
 {
 	struct otx2_nic *priv = pci_get_drvdata(pdev);
 
+	otx2_unregister_dl(priv);
+	if (!(priv->flags & OTX2_FLAG_INTF_DOWN))
+		rvu_rep_destroy(priv);
 	otx2_detach_resources(&priv->mbox);
 	if (priv->hw.lmt_info)
 		free_percpu(priv->hw.lmt_info);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index 565e75628df2..c04874c4d4c6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -28,4 +28,7 @@ static inline bool otx2_rep_dev(struct pci_dev *pdev)
 {
 	return pdev->device == PCI_DEVID_RVU_REP;
 }
+
+int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack);
+void rvu_rep_destroy(struct otx2_nic *priv);
 #endif /* REP_H */
-- 
2.25.1


