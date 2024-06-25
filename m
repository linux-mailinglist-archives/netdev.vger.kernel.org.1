Return-Path: <netdev+bounces-106514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B84E916A3F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7C51F22156
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE5B16F82A;
	Tue, 25 Jun 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WRDD+Yuu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CCA16EBF3;
	Tue, 25 Jun 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325545; cv=none; b=XTRQvXWgn4BxkmmBkl2DYnjCLx+A9zbjsDGaVdYkpWQLe08EeNrTkeHTVodaDwxrh4lWV2pEQ0/WdRhZIrdDuNyWojDVqc0duisJ6FxoX5iuR9OEnj0k/Ezs41PEuAqTZwIrjwRDsJsVvmJjSVJLI1WFw19k4vVWlw/W6fMa2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325545; c=relaxed/simple;
	bh=MahMOmX8HNP65jj6E2OAEjkH7EUdqwUC4Dkre658DyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6do1R0edt7pmMVWGctP9rKTlWva3OBbHKbhIWZE3jnYy39OAKeRG9zdWcrloDtUu0/og06F1AQNdD6dT7utiJLNAeKRxYkaI+qASJM0rUe2W5n/l75oNbjE4aAG8zo4Ue361tChBAGef4hjEzbkCfhTvcdrGNJz2aEoElq9W6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WRDD+Yuu; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P8sSXS006235;
	Tue, 25 Jun 2024 07:25:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=dc/mnP7nN44RCxG4zWwLeF+xD
	Itw2bObWXT4Mq5plgI=; b=WRDD+YuuxAgqYSRfoT+MxAhT9L0gsMj9D8Alac7S7
	nVXINA/hW5l640xIHZQ8uz3m/R48FejqWQmb3Os0+EOnsrpqIBalcC0UtF3Rv754
	tG9Am4ns7LIj7B9MPME4sGxvdvHo6G6F/MmdFWcAgEFH+uCTOpqYHXwYD7DIeok2
	Hyin6FMJJnrAj82BERWKCkIpTuOLuTHahHeoD4bXtmi6tZbocDeT7ykenc7nTKi/
	ceafIPoG5pt8GvY+z+bqt8PONjrzzlQsyNTUWwA9MsFvjL47z0mRHd+mcMY+qsed
	UUGkVDWrgvTJrmDF3gA3LFDl1tRT5fLpXaiaRJQQxu8KQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yytt097u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 07:25:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 07:25:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 07:25:21 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 7DCBB3F7045;
	Tue, 25 Jun 2024 07:25:18 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v6 04/10] octeontx2-pf: Add basic net_device_ops
Date: Tue, 25 Jun 2024 19:54:57 +0530
Message-ID: <20240625142503.3293-5-gakula@marvell.com>
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
X-Proofpoint-ORIG-GUID: bNH6oC25Fcul1AsCrx0--02EXmnpeS5S
X-Proofpoint-GUID: bNH6oC25Fcul1AsCrx0--02EXmnpeS5S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_09,2024-06-25_01,2024-05-17_01

Implements basic set of net_device_ops.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
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


