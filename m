Return-Path: <netdev+bounces-115767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D977E947C0E
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165561C20E91
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B8C3A29C;
	Mon,  5 Aug 2024 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EkmUXVx/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B738FA1;
	Mon,  5 Aug 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865373; cv=none; b=ZJ4exGLqz6PMKKz9tGLAjyBVkGOcLo2QBaPjXU0uJkIFSCV+dkpzcCirU9LhxbY2de7XybmnbFfjdB/nF2mwLzC03GbN1aCJHwp1ZgHCVSDy2lSbCbTx3eKBwKr0tgXvpptqxSbpWC4GD0rAIFwDBNGLdVcKvSu0CU/m0WQIBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865373; c=relaxed/simple;
	bh=pyeOyZb4wdVKngAuWvkY1s62ITPe9pKZIYvqLBwFkq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwaq/QzgiCAl/S4h/8yVcJGopA5Kbv1RxnDz5VtDik7NUjALWTsnyjmvxTQ3F8HPv1LMy3b2KUUZjO0mVc2D8yAigfBvtcgteM+8QWgXtnDK/2l0a+unQQ/FntEIpUee7Il5jgfTVGEC15ezo79fRvOe1C2jzxVTsAUSPM7MzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EkmUXVx/; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475BVBg8021538;
	Mon, 5 Aug 2024 06:42:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=zmDQRbex59fLltI/bnTVP3snw
	1zkiULM8MbjWF5s9xE=; b=EkmUXVx/bBktC2ShH7EN7n8fhx8OrKpHebmVHRIeH
	hIR7VM3gbatdlV3gcn/xnlTlSuun1mwfHuLL+lSQh8wZqcF6BYyuX9EIR532clhq
	V/kTmR1uoR/vwVfl9eKwy/Mg65cR3vpkbI69VmJHH4nNs97bNkoDEKI45pINgkGX
	ZZCWnc0xp+atSb6NM1bRFe6x9WdMK2VTIpW5ldDNXeeQy6nRnGRqhqwUShbIaqa2
	QvBAJF9zA59wQjrjIHHYWCl3B50E9NIL9Kv5MmjdCgEPXxwzRWoIvK0tdrlSoRr3
	pZDucwSW9sSK1YHrglQXanVrM/VnfKuqejmPkMyK+0yLw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40twxd0cmk-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 06:42:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 5 Aug 2024 06:42:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 5 Aug 2024 06:42:38 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id F2D125B6EC2;
	Mon,  5 Aug 2024 06:18:57 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v10 11/11] octeontx2-pf: Implement offload stats ndo for representors
Date: Mon, 5 Aug 2024 18:48:15 +0530
Message-ID: <20240805131815.7588-12-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240805131815.7588-1-gakula@marvell.com>
References: <20240805131815.7588-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: IkIGLp4T3RQlAvDt6Sl6A0ANNIgJjbzO
X-Proofpoint-ORIG-GUID: IkIGLp4T3RQlAvDt6Sl6A0ANNIgJjbzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_02,2024-08-02_01,2024-05-17_01

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


