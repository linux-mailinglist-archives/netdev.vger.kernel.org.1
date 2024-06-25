Return-Path: <netdev+bounces-106511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 472E1916A37
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95831F2214D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216FC16D311;
	Tue, 25 Jun 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HP4Ogz10"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1316C85F;
	Tue, 25 Jun 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325543; cv=none; b=pbj4qJS3qeProG3fCRAzo+p+aZ1ZMNc1rYYY701YxIUvZudiPljN8m9LVo7XlvpTXHw/vzActwTPRFJ/4YH7ESYegAmJTo/auIRmuh7Q2jT+2fhgtHisfoB6Tcicotbq60vjQyvGH7pq7hV+agTZoIt34d32OjGUY1oTWQCj8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325543; c=relaxed/simple;
	bh=TsQp4LM7Td12vmyrU8UBLwhpmKKgGksDIz2Id/Onwhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoHPQJ7DDTtmZ2AFmOpt7V4wy89IO915GrpmK/4dXZjysnUSS+I+k7C8+sXA5ROvpc4ROPmXrzh+bBFTfTWxVDyrvIKSil+jY9irw58KqCCU4MOgcg+l8eJxBXBXOYA0hlpx6IIDnuhZjveJF0UvUprf5eYV5qT0m6wR4KobQvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HP4Ogz10; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P8sUXJ006267;
	Tue, 25 Jun 2024 07:25:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=dvR+JHNGmIUeB3DF/1xHEE2E5
	Fp89OPzZhqql+nqi/A=; b=HP4Ogz10vNQWV9+rJHz2NDH374Xr9QfqYT7Hdt6Pq
	gAatvfjbg2sWYBL5qfeE0SUGa99FFkxOKdxllZcwL3xyTxu/EJUSKrsb523f6yhy
	vpc91f762JEaMLzf0z4SQ0YTDZDNGZSvvfnicFsu+NTOTP3RYzFWJzWIQfJA/8y/
	+NgZnXeNl7cyO7vBSVSLcIGW3U1h1h//g35eAqAXHmL7u9WERDS2oV7E7y1caBjN
	MS6gn1ml+YK2Gc1RefbGNXMznCPqNwFCU1y3CHci+agR2yepo2NvPvxZwaUzdCsx
	2p9T6v4/tJLi/Z1wF8NkGaE1tIp9Sh/c5N8qY8OXKCfmQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yytt097tr-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 07:25:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 07:25:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 07:25:18 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 063193F7045;
	Tue, 25 Jun 2024 07:25:14 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v6 03/10] octeontx2-pf: Create representor netdev
Date: Tue, 25 Jun 2024 19:54:56 +0530
Message-ID: <20240625142503.3293-4-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240625142503.3293-1-gakula@marvell.com>
References: <20240625142503.3293-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zRumrv4WDWegAZQMV2c7mfVPf32fQYQe
X-Proofpoint-GUID: zRumrv4WDWegAZQMV2c7mfVPf32fQYQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_09,2024-06-25_01,2024-05-17_01

Adds initial devlink support to set/get the switchdev mode.
Representor netdevs are created for each rvu devices when
the switch mode is set to 'switchdev'. These netdevs are
be used to control and configure VFs.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 165 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |   3 +
 3 files changed, 217 insertions(+)

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
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index b0a0080e50d7..6ea5b4904a7c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,164 @@ MODULE_DESCRIPTION(DRV_STRING);
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
+		snprintf(ndev->name, sizeof(ndev->name), "r%dp%d", rep_id,
+			 rvu_get_pf(pcifunc));
+
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
+	return err;
+}
+
 static void rvu_rep_rsrc_free(struct otx2_nic *priv)
 {
 	struct otx2_qset *qset = &priv->qset;
@@ -167,6 +325,10 @@ static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_detach_rsrc;
 
+	err = otx2_register_dl(priv);
+	if (err)
+		goto err_detach_rsrc;
+
 	return 0;
 
 err_detach_rsrc:
@@ -188,6 +350,9 @@ static void rvu_rep_remove(struct pci_dev *pdev)
 {
 	struct otx2_nic *priv = pci_get_drvdata(pdev);
 
+	otx2_unregister_dl(priv);
+	if (!(priv->flags & OTX2_FLAG_INTF_DOWN))
+		rvu_rep_destroy(priv);
 	rvu_rep_rsrc_free(priv);
 	otx2_detach_resources(&priv->mbox);
 	if (priv->hw.lmt_info)
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


