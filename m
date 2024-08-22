Return-Path: <netdev+bounces-121011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029E795B65E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B3528449A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD81CBE8F;
	Thu, 22 Aug 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IQVxxjmv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B701CBE85;
	Thu, 22 Aug 2024 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332866; cv=none; b=k/38pcPV35ofKAds5jkq8+NsrDU/f5M3v+vM6ZaRwwdjShsdoJnz/T4Uz4FhhHxPA+r28nah5NpAsbxwz+jQcTnx3KpgtMnKtc2L595OPzga0MzPjog5J8lMEsQGoVtYS3lFAKFZmiYNj3hKcfhHyyUDKGEIRYXjoaEvo/UffUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332866; c=relaxed/simple;
	bh=bZ6dc8n0qBIlN9zSK0l8bsODANYOQrqot6Qd1Idptl8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ea4JvQJI2J6Kk5/Jd+qItFtevDtGuYV3+UOdPGKd76/Kjs/E4GhfyWLW+ClVTBKeO9c9/v2dC52w+wmD4jH+COQkclMg4XXULqYE7LuZFvgTqGZJXEEgF0LA6mN30EgCxb13/7esY4nDlp9vITVpV+KY6CFzBnL9RWtm4R2Dea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IQVxxjmv; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47M9WSq8017317;
	Thu, 22 Aug 2024 06:20:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=TOpNNtMLJ3ArfET+HKcrVy9m+
	eT4ow6l/uXl9MauLyg=; b=IQVxxjmv9qBLAta6NHrOKr2UhJVFO1BBLdswMFWTU
	mF/dSUGEiEL/29WR4O0TlzA3FVM2FVtVZMu7Kg1INChRouZr80Ds6ZW4qmtgTdJq
	7sRlPpI1su+AIPsBHV+gRuDNLY6qf6oXbdKqF0mlCRSSk6Gg3iyVm2gDyWVaZLb1
	pDmSxjkQxXdx0P7AEZScFTDm1M+YD3IuGjkyjaBDPEnTm4PDAeoagpsk0Z/1/p9t
	vH93f1R2ATNaWH8afXfBYBHC6Y61hO0Q/RtZFQHxv8wKJofZL43cmZz+jdA7nLm3
	Vzd/jlD7z919nCSJ1JAzndxnR3eUoiBHcRtTToT/6Z4zw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4162sp0xam-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 06:20:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 Aug 2024 06:20:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 22 Aug 2024 06:20:53 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 0E8AC3F70CE;
	Thu, 22 Aug 2024 06:20:48 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v11 04/11] octeontx2-pf: Add basic net_device_ops
Date: Thu, 22 Aug 2024 18:50:24 +0530
Message-ID: <20240822132031.29494-5-gakula@marvell.com>
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
X-Proofpoint-GUID: vjERmB2Gf6k2B65tWw3Rddm1ssVwR63D
X-Proofpoint-ORIG-GUID: vjERmB2Gf6k2B65tWw3Rddm1ssVwR63D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_06,2024-08-22_01,2024-05-17_01

Implements basic set of net_device_ops.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 5635861a83f7..e085fef4e2dc 100644
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


