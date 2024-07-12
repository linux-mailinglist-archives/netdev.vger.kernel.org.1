Return-Path: <netdev+bounces-111129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E3930007
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BD11F23A2D
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A483178371;
	Fri, 12 Jul 2024 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MmLbci1e"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86514176FC5;
	Fri, 12 Jul 2024 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806946; cv=none; b=ETxhpYL+soDlWvzlbdr/Jd3Sbfeb6UAP5J1lj7H9nw/BqTg/IJwilMiswAwzbqu+DOqRElOai1SBeU9Y9jwJ3Yi+/dj8s0Tf9OpCZ1W2PDJ1cRR0SRAd6cvFwgQ5fbfB27Trddm9WoJzBqF5CsOkabWuL00bDxKFmPOwMDR5xiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806946; c=relaxed/simple;
	bh=teilrp+twnas5Xjp6g4BakB56Ij3NoZ3yaTI9qsdUmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqn4o+XuMrRS0g5nRMwW8Dzd5Ut01tHH6bnQaxrPiJRmeEzRYQBSoYT3PkCwp/aGH7ZZL+1GCuj0+gzwYADslTd/ZQQDbUbLlaSlpgBiNmsDV/GaUAOH7pn/NxUoRxz737wxc4LDrIjS4bv5jAJq4yI0q82zgKn2zLTAHhV4Nsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MmLbci1e; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C9JHcO026970;
	Fri, 12 Jul 2024 10:55:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=wc7ZA68weQMg57+X9daBzarfL
	BLGdJER25P9521/Zs8=; b=MmLbci1eoA30BLIrKUVZ5VpWm0+xFVsFd8LfbPvcQ
	0XtRo+5dRKnFKnmaZMEknHp4haQIb4cev/clAEagv4wt5psAlVwDViRdRcMxDsbB
	JtYyVoJv3XpzQjUpV02ANFSXW18SZ9nnpVQDGqmdOq34o3s0YAIY3XXOkiJsIkPL
	ChMyVGCm4/uiDBIZX9J38//7ICB6NZk/PCPuckVfI093ApRF9l4t87s7lkenmKVF
	WhUEE1Dl9cqehKTjWDLwAwmAohpQICu/to1iWdXF8mwLDmcjhaZM9yeSJFUVjY1b
	h8+dxvNVjCBReJQBagYtVcuvdGi+CAnRFsc73wwrZIDqA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40b1rgsm3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 10:55:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Jul 2024 10:55:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Jul 2024 10:55:38 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 489A33F70A1;
	Fri, 12 Jul 2024 10:55:35 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v9 04/11] octeontx2-pf: Add basic net_device_ops
Date: Fri, 12 Jul 2024 23:25:13 +0530
Message-ID: <20240712175520.7013-5-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240712175520.7013-1-gakula@marvell.com>
References: <20240712175520.7013-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0jdpmuYllLEk49-BX1G-QLj3gGx_T0No
X-Proofpoint-GUID: 0jdpmuYllLEk49-BX1G-QLj3gGx_T0No
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_13,2024-07-11_01,2024-05-17_01

Implements basic set of net_device_ops.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 6ea5b4904a7c..a021350fe83a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,51 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static netdev_tx_t rvu_rep_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct rep_dev *rep = netdev_priv(dev);
+	struct otx2_nic *pf = rep->mdev;
+	struct otx2_snd_queue *sq;
+	struct netdev_queue *txq;
+
+	sq = &pf->qset.sq[rep->rep_id];
+	txq = netdev_get_tx_queue(dev, 0);
+
+	if (!otx2_sq_append_skb(pf, txq, sq, skb, rep->rep_id)) {
+		netif_tx_stop_queue(txq);
+
+		/* Check again, in case SQBs got freed up */
+		smp_mb();
+		if (((sq->num_sqbs - *sq->aura_fc_addr) * sq->sqe_per_sqb)
+							> sq->sqe_thresh)
+			netif_tx_wake_queue(txq);
+
+		return NETDEV_TX_BUSY;
+	}
+	return NETDEV_TX_OK;
+}
+
+static int rvu_rep_open(struct net_device *dev)
+{
+	netif_carrier_on(dev);
+	netif_tx_start_all_queues(dev);
+	return 0;
+}
+
+static int rvu_rep_stop(struct net_device *dev)
+{
+	netif_carrier_off(dev);
+	netif_tx_disable(dev);
+
+	return 0;
+}
+
+static const struct net_device_ops rvu_rep_netdev_ops = {
+	.ndo_open		= rvu_rep_open,
+	.ndo_stop		= rvu_rep_stop,
+	.ndo_start_xmit		= rvu_rep_xmit,
+};
+
 static int rvu_rep_napi_init(struct otx2_nic *priv,
 			     struct netlink_ext_ack *extack)
 {
@@ -156,6 +201,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 
 		ndev->min_mtu = OTX2_MIN_MTU;
 		ndev->max_mtu = priv->hw.max_mtu;
+		ndev->netdev_ops = &rvu_rep_netdev_ops;
 		pcifunc = priv->rep_pf_map[rep_id];
 		rep->pcifunc = pcifunc;
 
-- 
2.25.1


