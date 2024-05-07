Return-Path: <netdev+bounces-94200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A258BEA06
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BC7B2C7D7
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D6116F90B;
	Tue,  7 May 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bvIOLwt2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2D16D9CA;
	Tue,  7 May 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100010; cv=none; b=jk2g0S6WPAtdf90L2J5UCm7ciz2xE7vwkGK4eik1f5ji+a0vZPUDcA4w+EQrWLtj7iHFKiWdq/RZzk489I4VpIaMkZdObrabRX7mgX5+JufEHcbTJtu/IStSK6i86qOGfSJJ8JVoBIuqpj8OxWunjLUOU6ATPPlh+37L+jP6Cro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100010; c=relaxed/simple;
	bh=m62YhKSRXUfHt5lDMhBJaNPsHqf9geqluqgaDzwrtWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hl6DnT68kSqkt1iEZC3DuTHOHkWDiI1CYIwNrylWyXggY5nzzvvYx26U72JjV3m4QdEqMTxWMDdi9Pm08gSW8eEIm5qdvhEXN3S069RmTumG/IOTQOEYlin5Sa9G1E/P3lgS9bwWVy3wiXQJziR80XfDuxUZBbCeZKNBok7Ups4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bvIOLwt2; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447Fk97J002936;
	Tue, 7 May 2024 09:40:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=WlX/GO0J468UzhMmOyV05
	4LQCuP9iFTyBsPrxoQ6BL0=; b=bvIOLwt2/4aN9DFl773TXiz2aP1Mtc+DDp++x
	Twfj4lWjd2EnrXGYbeu7bp2cPaDzYJdn75ZATD3FMun7PikQwQtpb2xjNJRpckB+
	UgZpVYDXNDiEKZBSzvJGiQBGDYA+GdfbLOZoWoTI8EbUyWnAqfufHdB/jdxzMylO
	FACoCU9YGL9z0lSvaS28kxr0vvL1TNtsWT5lVqP1lsoZ6UhdSj/mN/oOnP15EFcl
	lCJ8ymOCUKOiYREpU79nzdN2wRgu58T39mG18KeqYHo4JFiGKgjWJybL1vQhO+88
	hkJHmMbUpxD5MjT5hy6Bq3O0dAOJwEQ0XJzCrqKy68da+Mkgw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xwmhgjeya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 09:40:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 09:40:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 May 2024 09:40:01 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 222963F7041;
	Tue,  7 May 2024 09:39:57 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v4 10/10] octeontx2-pf: Add devlink port support
Date: Tue, 7 May 2024 22:09:21 +0530
Message-ID: <20240507163921.29683-11-gakula@marvell.com>
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
X-Proofpoint-ORIG-GUID: IUZGk9KiLb2oEichsGmfa4_0knW6hDDe
X-Proofpoint-GUID: IUZGk9KiLb2oEichsGmfa4_0knW6hDDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02

Register devlink port for the rvu representors.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 74 ++++++++++++++++++-
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  2 +
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index f7e150099b2b..f8a4702c1d48 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,69 @@ MODULE_DESCRIPTION(DRV_STRING);
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
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
+	attrs.pci_vf.pf = rvu_get_pf(rep->pcifunc);
+	attrs.pci_vf.vf = rep->pcifunc & RVU_PFVF_FUNC_MASK;
+
+	devlink_port_attrs_set(&rep->dl_port, &attrs);
+
+	err = devl_port_register_with_ops(dl, &rep->dl_port, rep->rep_id, &rvu_rep_dl_port_ops);
+	if (err) {
+		dev_err(rep->mdev->dev, "devlink_port_register failed: %d\n", err);
+		return err;
+	}
+	return 0;
+}
+
 static int rvu_rep_get_repid(struct otx2_nic *priv, u16 pcifunc)
 {
 	int rep_id;
@@ -335,6 +398,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
 	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
 		rep = priv->reps[rep_id];
 		unregister_netdev(rep->netdev);
+		rvu_rep_devlink_port_unregister(rep);
 		free_netdev(rep->netdev);
 	}
 }
@@ -355,8 +419,8 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 	for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
 		ndev = alloc_etherdev(sizeof(*rep));
 		if (!ndev) {
-			NL_SET_ERR_MSG_FMT_MOD(extack, "PFVF representor:%d
-					       creation failed", rep_id);
+			NL_SET_ERR_MSG_FMT_MOD(extack, "PFVF representor:%d creation failed",
+					       rep_id);
 			err = -ENOMEM;
 			goto exit;
 		}
@@ -376,6 +440,11 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
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
@@ -395,6 +464,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 	while (--rep_id >= 0) {
 		rep = priv->reps[rep_id];
 		unregister_netdev(rep->netdev);
+		rvu_rep_devlink_port_unregister(rep);
 		free_netdev(rep->netdev);
 	}
 	return err;
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


