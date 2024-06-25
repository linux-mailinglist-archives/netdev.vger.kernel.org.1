Return-Path: <netdev+bounces-106516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D0C916A42
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7BC1C20F21
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE8816F8EC;
	Tue, 25 Jun 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KRQMaDft"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE716D32C;
	Tue, 25 Jun 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325545; cv=none; b=V+JI6MmfOJrIxt0ZeIwIgI938sRK2+RjHwLBWJ+RQYshWCDvuPHjk6k9BPg5n1f9KtVY9JrdRzDk2q4njhv2gJeW3yl5RzuApacujTEL2nQiq77B5ee+GDbtNynPxOfg9BBg4IgznD4CFvyCHRAeL3nBNl1SsH9c1FkcGTXkPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325545; c=relaxed/simple;
	bh=bIrTVxlnvAQ9Ybr5T2Z0Zvl96cnH7GS4L4loSDc+rtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBcUODFob3iBKhzD8PFLmoZLl59PQwvmPafOoUNyOykBo7D5ywGpaaPf1oL2TQZVi+HMhu3v0EbuR0rO8L22NQUHgPLAWFLyb79Eu5nr1OYCBOVDkAJ1wD81FkW66UqgKMeqY/6xhapWnSk3p+W1AhCTiJj0MSIip5SZY8Uf8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KRQMaDft; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P8sSXU006235;
	Tue, 25 Jun 2024 07:25:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=THix5D/P93y19dl3BZf33xbtn
	Wvf5THW5H2Z7v6CNRY=; b=KRQMaDft696ejJXVwQtQf0ZjcPfScYEDphRW2/Afw
	RSXwHcl1ZWcuvRiOW3ujLKvLvov7mwST2Tdf70MYVpqyxvpjuBWWYsXXI/Uz/I9p
	uO4+oPzuYGOr76hvyE/SkhLsG3y9CQTh7vUxCdNa3RCVQkgzuLIHtNnnnKLMqDSr
	q3IM1sdrsENXKONdOZifz7vOBHvdqUHf0wQ+WGrP8Iu3vJSr11yaE4ijAo+DXMyK
	AMlYGA5X1p3EtoLGh/SEFh9QPB7y2t7fzG8833jCa+vvWU0yZRln3yZTnCXHo32y
	vbShtmYubuIjR7qZoJ1zavIFBTFK5d8KexZ7ir2UHaDSw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yytt097u3-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 07:25:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 07:25:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 07:25:28 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 78EB43F7045;
	Tue, 25 Jun 2024 07:25:25 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v6 06/10] octeontx2-pf: Get VF stats via representor
Date: Tue, 25 Jun 2024 19:54:59 +0530
Message-ID: <20240625142503.3293-7-gakula@marvell.com>
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
X-Proofpoint-ORIG-GUID: jFM1RaO04n4cwVpR9jTU81pREPMJC3wy
X-Proofpoint-GUID: jFM1RaO04n4cwVpR9jTU81pREPMJC3wy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_09,2024-06-25_01,2024-05-17_01

Adds support to export VF port statistics via representor
netdev. Defines new mbox "NIX_LF_STATS" to fetch VF hw stats.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 32 +++++++++
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 43 ++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 65 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  | 14 ++++
 4 files changed, 154 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index a7c32f1cc924..d293a3c35b6b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -321,6 +321,7 @@ M(NIX_MCAST_GRP_DESTROY, 0x802c, nix_mcast_grp_destroy, nix_mcast_grp_destroy_re
 M(NIX_MCAST_GRP_UPDATE, 0x802d, nix_mcast_grp_update,				\
 				nix_mcast_grp_update_req,			\
 				nix_mcast_grp_update_rsp)			\
+M(NIX_LF_STATS, 0x802e, nix_lf_stats, nix_stats_req, nix_stats_rsp)	\
 /* MCS mbox IDs (range 0xA000 - 0xBFFF) */					\
 M(MCS_ALLOC_RESOURCES,	0xa000, mcs_alloc_resources, mcs_alloc_rsrc_req,	\
 				mcs_alloc_rsrc_rsp)				\
@@ -1366,6 +1367,37 @@ struct nix_bandprof_get_hwinfo_rsp {
 	u32 policer_timeunit;
 };
 
+struct nix_stats_req {
+	struct mbox_msghdr hdr;
+	u8 reset;
+	u16 pcifunc;
+	u64 rsvd;
+};
+
+struct nix_stats_rsp {
+	struct mbox_msghdr hdr;
+	u16 pcifunc;
+	struct {
+		u64 octs;
+		u64 ucast;
+		u64 bcast;
+		u64 mcast;
+		u64 drop;
+		u64 drop_octs;
+		u64 drop_mcast;
+		u64 drop_bcast;
+		u64 err;
+		u64 rsvd[5];
+	} rx;
+	struct {
+		u64 ucast;
+		u64 bcast;
+		u64 mcast;
+		u64 drop;
+		u64 octs;
+	} tx;
+};
+
 /* NPC mbox message structs */
 
 #define NPC_MCAM_ENTRY_INVALID	0xFFFF
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 5f2e2cbd165a..6bc867dea42e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -13,6 +13,49 @@
 #include "rvu.h"
 #include "rvu_reg.h"
 
+#define RVU_LF_RX_STATS(reg) \
+		rvu_read64(rvu, blkaddr, NIX_AF_LFX_RX_STATX(nixlf, reg))
+
+#define RVU_LF_TX_STATS(reg) \
+		rvu_read64(rvu, blkaddr, NIX_AF_LFX_TX_STATX(nixlf, reg))
+
+int rvu_mbox_handler_nix_lf_stats(struct rvu *rvu,
+				  struct nix_stats_req *req,
+				  struct nix_stats_rsp *rsp)
+{
+	u16 pcifunc = req->pcifunc;
+	int nixlf, blkaddr, err;
+	struct msg_req rst_req;
+	struct msg_rsp rst_rsp;
+
+	err = nix_get_nixlf(rvu, pcifunc, &nixlf, &blkaddr);
+	if (err)
+		return 0;
+
+	if (req->reset) {
+		rst_req.hdr.pcifunc = pcifunc;
+		return rvu_mbox_handler_nix_stats_rst(rvu, &rst_req, &rst_rsp);
+	}
+	rsp->rx.octs = RVU_LF_RX_STATS(RX_OCTS);
+	rsp->rx.ucast = RVU_LF_RX_STATS(RX_UCAST);
+	rsp->rx.bcast = RVU_LF_RX_STATS(RX_BCAST);
+	rsp->rx.mcast = RVU_LF_RX_STATS(RX_MCAST);
+	rsp->rx.drop = RVU_LF_RX_STATS(RX_DROP);
+	rsp->rx.err = RVU_LF_RX_STATS(RX_ERR);
+	rsp->rx.drop_octs = RVU_LF_RX_STATS(RX_DROP_OCTS);
+	rsp->rx.drop_mcast = RVU_LF_RX_STATS(RX_DRP_MCAST);
+	rsp->rx.drop_bcast = RVU_LF_RX_STATS(RX_DRP_BCAST);
+
+	rsp->tx.octs = RVU_LF_TX_STATS(TX_OCTS);
+	rsp->tx.ucast = RVU_LF_TX_STATS(TX_UCAST);
+	rsp->tx.bcast = RVU_LF_TX_STATS(TX_BCAST);
+	rsp->tx.mcast = RVU_LF_TX_STATS(TX_MCAST);
+	rsp->tx.drop = RVU_LF_TX_STATS(TX_DROP);
+
+	rsp->pcifunc = req->pcifunc;
+	return 0;
+}
+
 static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
 {
 	int id;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index b993b03622dd..d4e90b13db71 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,68 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static void rvu_rep_get_stats(struct work_struct *work)
+{
+	struct delayed_work *del_work = to_delayed_work(work);
+	struct nix_stats_req *req;
+	struct nix_stats_rsp *rsp;
+	struct rep_stats *stats;
+	struct otx2_nic *priv;
+	struct rep_dev *rep;
+	int err;
+
+	rep = container_of(del_work, struct rep_dev, stats_wrk);
+	priv = rep->mdev;
+
+	mutex_lock(&priv->mbox.lock);
+	req = otx2_mbox_alloc_msg_nix_lf_stats(&priv->mbox);
+	if (!req) {
+		mutex_unlock(&priv->mbox.lock);
+		return;
+	}
+	req->pcifunc = rep->pcifunc;
+	err = otx2_sync_mbox_msg_busy_poll(&priv->mbox);
+	if (err)
+		goto exit;
+
+	rsp = (struct nix_stats_rsp *)
+	      otx2_mbox_get_rsp(&priv->mbox.mbox, 0, &req->hdr);
+
+	if (IS_ERR(rsp)) {
+		err = PTR_ERR(rsp);
+		goto exit;
+	}
+
+	stats = &rep->stats;
+	stats->rx_bytes = rsp->rx.octs;
+	stats->rx_frames = rsp->rx.ucast + rsp->rx.bcast +
+			    rsp->rx.mcast;
+	stats->rx_drops = rsp->rx.drop;
+	stats->rx_mcast_frames = rsp->rx.mcast;
+	stats->tx_bytes = rsp->tx.octs;
+	stats->tx_frames = rsp->tx.ucast + rsp->tx.bcast + rsp->tx.mcast;
+	stats->tx_drops = rsp->tx.drop;
+exit:
+	mutex_unlock(&priv->mbox.lock);
+}
+
+static void rvu_rep_get_stats64(struct net_device *dev,
+				struct rtnl_link_stats64 *stats)
+{
+	struct rep_dev *rep = netdev_priv(dev);
+
+	stats->rx_packets = rep->stats.rx_frames;
+	stats->rx_bytes = rep->stats.rx_bytes;
+	stats->rx_dropped = rep->stats.rx_drops;
+	stats->multicast = rep->stats.rx_mcast_frames;
+
+	stats->tx_packets = rep->stats.tx_frames;
+	stats->tx_bytes = rep->stats.tx_bytes;
+	stats->tx_dropped = rep->stats.tx_drops;
+
+	schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));
+}
+
 static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 {
 	struct esw_cfg_req *req;
@@ -87,6 +149,7 @@ static const struct net_device_ops rvu_rep_netdev_ops = {
 	.ndo_open		= rvu_rep_open,
 	.ndo_stop		= rvu_rep_stop,
 	.ndo_start_xmit		= rvu_rep_xmit,
+	.ndo_get_stats64	= rvu_rep_get_stats64,
 };
 
 static int rvu_rep_napi_init(struct otx2_nic *priv,
@@ -233,6 +296,8 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 			free_netdev(ndev);
 			goto exit;
 		}
+
+		INIT_DELAYED_WORK(&rep->stats_wrk, rvu_rep_get_stats);
 	}
 	err = rvu_rep_napi_init(priv, extack);
 	if (err)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index c04874c4d4c6..5d39bf636655 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -17,9 +17,23 @@
 #define PCI_DEVID_RVU_REP	0xA0E0
 
 #define RVU_MAX_REP	OTX2_MAX_CQ_CNT
+
+struct rep_stats {
+	u64 rx_bytes;
+	u64 rx_frames;
+	u64 rx_drops;
+	u64 rx_mcast_frames;
+
+	u64 tx_bytes;
+	u64 tx_frames;
+	u64 tx_drops;
+};
+
 struct rep_dev {
 	struct otx2_nic *mdev;
 	struct net_device *netdev;
+	struct rep_stats stats;
+	struct delayed_work stats_wrk;
 	u16 rep_id;
 	u16 pcifunc;
 };
-- 
2.25.1


