Return-Path: <netdev+bounces-94194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05FA8BE97C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1321F23281
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B28F16D4F3;
	Tue,  7 May 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cUai6QeN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18B616D4D1;
	Tue,  7 May 2024 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099988; cv=none; b=IileZt7eAeemriu51ecFJtUi0iqxm1V8WIiaMmfs2qjAPvL4xygkhalrU6qK+k/XJDYDJptTsbSn3NLuNvcECtSfhLc2ZtkygX0kXKxg5xMTWpE4SVq0WnnQMVlgnRalWl3ORkHmTGk9FOPFAemOqkoFqtLFZeqS+npw7xeRx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099988; c=relaxed/simple;
	bh=k6traiZlgDOCRLrI+cXfbMh1K/vxHzTnCNN65tRFpIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/ujtGtxQa7EDhbS+YqOHEKMZ68ykg5PJMyVbfuaFiXewDZfODBNy7AP7XYMm/t7A38UYcqzUsPdTLw6d52cK2VpOU41u3XigaXFMZgKYFf3NEVy9HUzV76LRyTv2kVvkONLmQZFrZXUNYVguLebdUaBuiZUHhm6xBqI4Uq/Uuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cUai6QeN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447FkAgE002968;
	Tue, 7 May 2024 09:39:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=1n75WfqGj4IxSHySuPhzy
	4Q50vTKaiZKRuy8sCi2bRk=; b=cUai6QeNUKSvflxeQ3F0uJAZizkLvZS8/R/QN
	KejTkkUmfCZq7Uvtbp/pFjpvR7w8k/S0PoKgZOKv3mbNmFbN3q2srrmNBH9qvkU/
	9w35M7TIdvaP/XArJ6o5mD+Rc17m4e4pKJCUU8aZM/hZ0s+qvbdhx0l/Tdjt0sbA
	Igc3jxQQldQ2VGI73ThJ06903RZxCehgkwKI7lACasu7s+6m2rexeoLmVxRoz5Ji
	O0hmS55w0W9SxI4ijpCcJBwBTffrykcY/LY+xf7qG7y4k9HsVU4HC0c6/lm5hYKP
	d0L+RdddgA5d2P3HQ+egzI35K1Y6wP8A1eMUiv7zCHFpxyDBg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xwmhgjexb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 09:39:40 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 09:39:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 May 2024 09:39:40 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id C08FB3F7041;
	Tue,  7 May 2024 09:39:36 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v4 04/10] octeontx2-pf: Add basic net_device_ops
Date: Tue, 7 May 2024 22:09:15 +0530
Message-ID: <20240507163921.29683-5-gakula@marvell.com>
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
X-Proofpoint-ORIG-GUID: 5jbGvX0O0W5tpfAy7E1HNtF3Cg2FaJbT
X-Proofpoint-GUID: 5jbGvX0O0W5tpfAy7E1HNtF3Cg2FaJbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02

Implements basic set of net_device_ops.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index ff4318f414f8..c212b4d7ed20 100644
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
+		/* Check again, incase SQBs got freed up */
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
 static int rvu_rep_napi_init(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 {
 	struct otx2_cq_poll *cq_poll = NULL;
@@ -152,6 +197,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 
 		ndev->min_mtu = OTX2_MIN_MTU;
 		ndev->max_mtu = priv->hw.max_mtu;
+		ndev->netdev_ops = &rvu_rep_netdev_ops;
 		pcifunc = priv->rep_pf_map[rep_id];
 		rep->pcifunc = pcifunc;
 
-- 
2.25.1


