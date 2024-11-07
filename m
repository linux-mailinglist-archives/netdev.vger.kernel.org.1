Return-Path: <netdev+bounces-142910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B89C0AF8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723F81C2031E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568FB217F4B;
	Thu,  7 Nov 2024 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Qf1A9uoC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367D217F2E;
	Thu,  7 Nov 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995772; cv=none; b=tDAFiVx2po/h8EdOujR0WzXYcAfHMKLRfy35F5O7hEtlpnNGAL12MVtY9vDPgT2rcAD1VhZZCqHYoB3MhCC9+mEkjX/dOvQho9Rdg9BpYcF7ReiVtdD0cEn8PyhetXzN7SKZ7PazDOr61M26AYEdhzcpOEpSw03/rlplOWeqZ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995772; c=relaxed/simple;
	bh=LLB3Xfe4xmgk9DaTU7W3u0B4ozOX7h92mwuE1s88Fpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrp12w6Y0d9ah+L8JOyzYRKZS/qS5YSqowAIHL8vkS+ojgtlKovrscwrkSEzjqRss3tdvO/3fFpndQiz39ksX7/eKuGxp34r1AJakc97n+nQow15gLjCXReEpOjvOMEzfnEU9L2fziN7S/EncmVIRI+gBgLCgs1xg0zxGCswUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Qf1A9uoC; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7CZb62016979;
	Thu, 7 Nov 2024 08:09:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=yxmndC84zG6mtMGWD6sabkrTx
	pyQlvv3+9quhLVNHCg=; b=Qf1A9uoCQ7kt3gfBvZNk+qfiSF/PzHsAyjIfKRvV6
	Ixo4NKPjcvVcFvGmy/ClD7lC5In6QFYzFMBgOGstc9VGmTLy6eQahtUnSYwR/kQ+
	YJcaobNfRL8gbjY4SINKt0EUjnKthkATxyUj8LuhhVf00T8YGysvVvd45Kd+r+20
	cKKpzkwkES3GVkZZ2Ol9xcwHmaB4NPcabyA+/NIgulHz1yxvKiBu5eegQsYu2WGG
	5uYuzdZxDaDZIAWjah5i2j6TYFgX9puNXm8tDpxjH4FhfsrrDoiGPcG1fhM8c60u
	/JjPBVYqOsPxq3+bf88qL7tqeRkwkfRVxhw059VftH2qg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42rwpngh5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:09:24 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 08:09:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 08:09:24 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 9252A3F708D;
	Thu,  7 Nov 2024 08:09:20 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v12 10/12] octeontx2-pf: Implement offload stats ndo for representors
Date: Thu, 7 Nov 2024 21:38:37 +0530
Message-ID: <20241107160839.23707-11-gakula@marvell.com>
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
X-Proofpoint-GUID: EFZbk6VUF7SumtXcNuVXEpGzh5KqtE0q
X-Proofpoint-ORIG-GUID: EFZbk6VUF7SumtXcNuVXEpGzh5KqtE0q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Implement the offload stat ndo by fetching the HW stats
of rx/tx queues attached to the representor.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../marvell/octeontx2/nic/otx2_common.c       |  2 +
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 41 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 46a448030e64..523ecb798a7a 100644
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
index 15e775027c38..1806d050c143 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -31,6 +31,45 @@ MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 static int rvu_rep_notify_pfvf(struct otx2_nic *priv, u16 event,
 			       struct rep_event *data);
 
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
@@ -326,6 +365,8 @@ static const struct net_device_ops rvu_rep_netdev_ops = {
 	.ndo_start_xmit		= rvu_rep_xmit,
 	.ndo_get_stats64	= rvu_rep_get_stats64,
 	.ndo_change_mtu		= rvu_rep_change_mtu,
+	.ndo_has_offload_stats	= rvu_rep_has_offload_stats,
+	.ndo_get_offload_stats	= rvu_rep_get_offload_stats,
 };
 
 static int rvu_rep_napi_init(struct otx2_nic *priv,
-- 
2.25.1


