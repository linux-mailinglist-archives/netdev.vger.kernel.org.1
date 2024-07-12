Return-Path: <netdev+bounces-111138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8425693001A
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C23B20C53
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148BD17B515;
	Fri, 12 Jul 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CL5mmEX6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BBA17B4FC;
	Fri, 12 Jul 2024 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806972; cv=none; b=Lsr8sCH5XmOgQWOq6i83+GUh3240esKYZF1fuHrs+US3NMrLmEdsepMNmr/xFCMPEy0ktoGRUoO7F5TIGI5gB5ZNVG7uVwSzQsL1OCe6CdlfLAv6+t8KYcIQ8ldi8/dsIIksiqHgHIqEKSOxC/iw0Wl5Xlx/gXR9hzFyVlMqc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806972; c=relaxed/simple;
	bh=pyeOyZb4wdVKngAuWvkY1s62ITPe9pKZIYvqLBwFkq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpBPw6UVBsVVhTCUaM6DQk0zGc+6jwx+ag02fH6Nwi6e4H+CCYhxxzkNdUG5jIA9UPPtiIM63gybzAuPALYp/Z9RQq5FLd2+RJMe+I5KFL75jpQnlxgpntV1CvZJsuqdjXLREeSqJId56gMB2KUZPmfmiwZr88+m9lI4e3IUfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CL5mmEX6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDh1NS012285;
	Fri, 12 Jul 2024 10:56:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=zmDQRbex59fLltI/bnTVP3snw
	1zkiULM8MbjWF5s9xE=; b=CL5mmEX6369xVokd7NMnaQk61V5bMMsb8ZcnDxu+l
	EfSG+B8QoNrSQXgc/zDDArh+bCu38WcwG8YEn6/Z6KbSDIePJsf8iKTt3D0USgJs
	z1STbOCv0K5giO5+MQLHcHitDmEq6edxRc8gc/SiuBrBSr1mpjxMh1pTc+lt1OJl
	a1p1trLp1sJc9vPTfUxpGnVTFNLHRisDkm+CalaW24ly1JRCSdRzzJoZxf3dhRbe
	cNgzk9Cf/AXc+Fyz3nYsZageycU9kOx9SNSW31rafGJXXX08Fx604ysKkJ0gE0P6
	RO80plqWjM5aPDElrd2d73BWnXfdqGejJqMDAe8DCfjlQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40b5m68wqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 10:56:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Jul 2024 10:56:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Jul 2024 10:56:02 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id D21A63F70A1;
	Fri, 12 Jul 2024 10:55:59 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v9 11/11] octeontx2-pf: Implement offload stats ndo for representors
Date: Fri, 12 Jul 2024 23:25:20 +0530
Message-ID: <20240712175520.7013-12-gakula@marvell.com>
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
X-Proofpoint-GUID: BGslHD47Dt0EzLd_ClhPEibnhoWgyCYV
X-Proofpoint-ORIG-GUID: BGslHD47Dt0EzLd_ClhPEibnhoWgyCYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_13,2024-07-11_01,2024-05-17_01

Implement the offload stat ndo by fetching the HW stats
of rx/tx queues attached to the representor.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


