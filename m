Return-Path: <netdev+bounces-109419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3570B92869E
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A331C245E6
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B8014B064;
	Fri,  5 Jul 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ORMM36rN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4214A632;
	Fri,  5 Jul 2024 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174648; cv=none; b=tTRwhmGzzkolu5O5cjDuGlf7XXo2AAP9P0ZobjVeLCAWZcIEKWEMsvcPfI84eh/3u5WsxVqNVVlQIDH1IJEVrjnhbQ+TnYziLDwSayxX1uwEOHYZ3z2tQ72eH2z/gTlmfcql1Eigdxzwnqfbao8mwqh6G7MtVV4HnB1U3BKugWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174648; c=relaxed/simple;
	bh=CERjG3vfMc3zpYIx6pqPfIR//sLXgGReNEsdcIrwJvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbeoSJQEgBZBclGOQzMrOJy/6+UCnFHRALgol/64YHYaHwJFHgupQ771+eEaiiGCZhL5NX0xDp17f2DwYZFXAHbvnvPe+7s69/23mRsv6fmef9f5e5s0FQggjH9mIQtI9zQ+KdWV/JrD9SYoManuSbT+EcYRH6SVQYE4WvoS87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ORMM36rN; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4659PKeA029609;
	Fri, 5 Jul 2024 03:17:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=22uP3ntITndWxJFGeHsZEBEQR
	hAx6GuaawHqjARjRLg=; b=ORMM36rNiAQsNChByGvs5Q0w73yK1QvWKmF/+mPCd
	Ui7xd6xlCHFWK2eZsn6SpydBKBTTFqg5tlDgM+ONb8bm0k+FLWxNwmx2Dw8BYW16
	gBop14Kt3XBxAorgLSXmhqOXD40+aP7d4RNz6Sod1BbgpKx9M5zSm84ix/RcMSK2
	Q0hU2YgVlPCjmRAdKboB5NM8TwvEU+473yjEjCHebvH+H+Mrnzv4MR96nRzEybQd
	+r9EixlX8xZfiJkLHnugTU5UtaSNM2Ipn1O4cYh3W/WA+tSF1Fc0lfcI57HPP46e
	WtVV/20JDQUEiiPi6k418kC6gPLU5GbuYNy3v8SRPyLHQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 406e6c04v9-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 03:17:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Jul 2024 03:17:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 5 Jul 2024 03:17:01 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 6E7C33F7040;
	Fri,  5 Jul 2024 03:16:58 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v8 11/11] octeontx2-pf: Implement offload stats ndo for representors
Date: Fri, 5 Jul 2024 15:46:18 +0530
Message-ID: <20240705101618.18415-12-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240705101618.18415-1-gakula@marvell.com>
References: <20240705101618.18415-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: RIfaC6STybUv_1tvuVgzMBzL_s8yW-Zv
X-Proofpoint-ORIG-GUID: RIfaC6STybUv_1tvuVgzMBzL_s8yW-Zv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_06,2024-07-03_01,2024-05-17_01

Implement the offload stat ndo by fetching the HW stats
of rx/tx queues attached to the representor.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       |  2 +
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 41 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 4c11c420399b..b1251f80a569 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -83,6 +83,7 @@ int otx2_update_rq_stats(struct otx2_nic *pfvf, int qidx)
 	otx2_nix_rq_op_stats(&rq->stats, pfvf, qidx);
 	return 1;
 }
+EXPORT_SYMBOL(otx2_update_rq_stats);
 
 int otx2_update_sq_stats(struct otx2_nic *pfvf, int qidx)
 {
@@ -99,6 +100,7 @@ int otx2_update_sq_stats(struct otx2_nic *pfvf, int qidx)
 	otx2_nix_sq_op_stats(&sq->stats, pfvf, qidx);
 	return 1;
 }
+EXPORT_SYMBOL(otx2_update_sq_stats);
 
 void otx2_get_dev_stats(struct otx2_nic *pfvf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 6939f213f9f8..d62aabf98833 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,45 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static int
+rvu_rep_sp_stats64(const struct net_device *dev,
+		   struct rtnl_link_stats64 *stats)
+{
+	struct rep_dev *rep = netdev_priv(dev);
+	struct otx2_nic *priv = rep->mdev;
+	struct otx2_rcv_queue *rq;
+	struct otx2_snd_queue *sq;
+	u16 qidx = rep->rep_id;
+
+	otx2_update_rq_stats(priv, qidx);
+	rq = &priv->qset.rq[qidx];
+
+	otx2_update_sq_stats(priv, qidx);
+	sq = &priv->qset.sq[qidx];
+
+	stats->tx_bytes = sq->stats.bytes;
+	stats->tx_packets = sq->stats.pkts;
+	stats->rx_bytes = rq->stats.bytes;
+	stats->rx_packets = rq->stats.pkts;
+	return 0;
+}
+
+static bool
+rvu_rep_has_offload_stats(const struct net_device *dev, int attr_id)
+{
+	return attr_id == IFLA_OFFLOAD_XSTATS_CPU_HIT;
+}
+
+static int
+rvu_rep_get_offload_stats(int attr_id, const struct net_device *dev,
+			  void *sp)
+{
+	if (attr_id == IFLA_OFFLOAD_XSTATS_CPU_HIT)
+		return rvu_rep_sp_stats64(dev, (struct rtnl_link_stats64 *)sp);
+
+	return -EINVAL;
+}
+
 static int rvu_rep_dl_port_fn_hw_addr_get(struct devlink_port *port,
 					  u8 *hw_addr, int *hw_addr_len,
 					  struct netlink_ext_ack *extack)
@@ -310,6 +349,8 @@ static const struct net_device_ops rvu_rep_netdev_ops = {
 	.ndo_start_xmit		= rvu_rep_xmit,
 	.ndo_get_stats64	= rvu_rep_get_stats64,
 	.ndo_change_mtu		= rvu_rep_change_mtu,
+	.ndo_has_offload_stats	= rvu_rep_has_offload_stats,
+	.ndo_get_offload_stats	= rvu_rep_get_offload_stats,
 };
 
 static int rvu_rep_napi_init(struct otx2_nic *priv,
-- 
2.25.1


