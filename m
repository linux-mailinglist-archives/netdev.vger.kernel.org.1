Return-Path: <netdev+bounces-99550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810CB8D5405
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 22:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352D3284C58
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C44984D2A;
	Thu, 30 May 2024 20:48:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44D18756A
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102091; cv=none; b=h3SyP1lHEfvEJLomhHVuIcNo5VM9iljFORA9494HEnvzsA7pGKcoFeDomGM3nyAa164tsKNz+8ypXgbN3N+ef2NFaOeG85JuTQG99e0aNn8i4D5/7krYexuP4FanMjKD/O22j0fpgTZxN8FJGXEq24OmOiznRNv+9ldqSvYdj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102091; c=relaxed/simple;
	bh=zLihNuizMFuHGGW38wruXu5d27shrXQ7GNLJzE1X3cg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a28gHcQka8kwQSx285pi+GQc03ZRT0KEShaEtR4+qL7CENH73JudvE56N9t90pSHcDew8vSeZmQUhL1DzkgeQdmWyucADXI1g/l1S8GYF72SGFIVAGA13+jdiUxVb6CiQw/MKhG9SqD+DAM6qSXN2Wp7vv5Izp80SGfZbwj5vqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UJjKHS013327;
	Thu, 30 May 2024 13:48:01 -0700
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dmeta.com;_h=3Dc?=
 =?UTF-8?Q?c:content-transfer-encoding:content-type:date:from:message-id:m?=
 =?UTF-8?Q?ime-version:subject:to;_s=3Ds2048-2021-q4;_bh=3Dr1nExtLSApXqemP?=
 =?UTF-8?Q?mZoendJMXmczUZJiBFv1G9YHLNfE=3D;_b=3DO2Kze15OzOuVPrPiQlBZDnuuCV?=
 =?UTF-8?Q?Xt0y0pQO0Z2Ga78IIiU72wbX7uRpHARgZJh0fN84rG_n8ayl8n4GG5mRNFer3UI?=
 =?UTF-8?Q?mahJAOwEuGroYwlf5CbZJ+E/z0a/5ZC4diAOBj6sPMExlyl6_M2uDOysUwUG+HS?=
 =?UTF-8?Q?JVDgrUKIIdyLYyRz+058Z/u83Mo4aeEwVSVjclXTVYwOUCWwAVg5S/_ZnR+Itmv?=
 =?UTF-8?Q?p2mfAjltovVbd+jZ8UlQfasirnDBDtquJ95SOhgte5/9K8p8+ZaDjas5qufQ_Z/?=
 =?UTF-8?Q?IiHdxRVU7xFc9QxwRso/5f/n5OVmBOyqF/qOoDdslLQUxgypvUDLdHksfhtIM17?=
 =?UTF-8?Q?kGa_Hg=3D=3D_?=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yemeqw00p-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 May 2024 13:48:01 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 30 May 2024 20:47:58 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Michael Chan <michael.chan@broadcom.com>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        "Jakub
 Kicinski" <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
        Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH net-next v2] bnxt_en: add timestamping statistics support
Date: Thu, 30 May 2024 13:47:51 -0700
Message-ID: <20240530204751.99636-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: G6GrhbOQTUKgXM-aepy7pl_EwxarNulJ
X-Proofpoint-ORIG-GUID: G6GrhbOQTUKgXM-aepy7pl_EwxarNulJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_17,2024-05-30_01,2024-05-17_01

The ethtool_ts_stats structure was introduced earlier this year. Now
it's time to support this group of counters in more drivers.
This patch adds support to bnxt driver.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v1 -> v2:
 - embed stats structure into ptp_cfg structure
 - keep ethtool stats untouched if ptp is not enabled
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c      | 18 +++++++++++++-----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c  | 14 ++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c  |  8 ++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h  |  8 ++++++++
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c437ca1c0fd3..6d9faa78e391 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -512,8 +512,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 
-		if (ptp && ptp->tx_tstamp_en && !skb_is_gso(skb) &&
-		    atomic_dec_if_positive(&ptp->tx_avail) >= 0) {
+		if (ptp && ptp->tx_tstamp_en && !skb_is_gso(skb)) {
+			if (!atomic_dec_if_positive(&ptp->tx_avail)) {
+				atomic64_inc(&ptp->stats.ts_err);
+				goto tx_no_ts;
+			}
 			if (!bnxt_ptp_parse(skb, &ptp->tx_seqid,
 					    &ptp->tx_hdr_off)) {
 				if (vlan_tag_flags)
@@ -526,6 +529,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
+tx_no_ts:
 	if (unlikely(skb->no_fcs))
 		lflags |= cpu_to_le32(TX_BD_FLAGS_NO_CRC);
 
@@ -732,8 +736,10 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 
 tx_dma_error:
-	if (BNXT_TX_PTP_IS_SET(lflags))
+	if (BNXT_TX_PTP_IS_SET(lflags)) {
+		atomic64_inc(&bp->ptp_cfg->stats.ts_err);
 		atomic_inc(&bp->ptp_cfg->tx_avail);
+	}
 
 	last_frag = i;
 
@@ -812,10 +818,12 @@ static void __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)) {
 			if (BNXT_CHIP_P5(bp)) {
 				/* PTP worker takes ownership of the skb */
-				if (!bnxt_get_tx_ts_p5(bp, skb))
+				if (!bnxt_get_tx_ts_p5(bp, skb)) {
 					skb = NULL;
-				else
+				} else {
+					atomic64_inc(&bp->ptp_cfg->stats.ts_err);
 					atomic_inc(&bp->ptp_cfg->tx_avail);
+				}
 			}
 		}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 8763f8a01457..bf157f6cc042 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5233,6 +5233,19 @@ static void bnxt_get_rmon_stats(struct net_device *dev,
 	*ranges = bnxt_rmon_ranges;
 }
 
+static void bnxt_get_ptp_stats(struct net_device *dev,
+			       struct ethtool_ts_stats *ts_stats)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+
+	if (ptp) {
+		ts_stats->pkts = ptp->stats.ts_pkts;
+		ts_stats->lost = ptp->stats.ts_lost;
+		ts_stats->err = atomic64_read(&ptp->stats.ts_err);
+	}
+}
+
 static void bnxt_get_link_ext_stats(struct net_device *dev,
 				    struct ethtool_link_ext_stats *stats)
 {
@@ -5316,4 +5329,5 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.get_eth_mac_stats	= bnxt_get_eth_mac_stats,
 	.get_eth_ctrl_stats	= bnxt_get_eth_ctrl_stats,
 	.get_rmon_stats		= bnxt_get_rmon_stats,
+	.get_ts_stats		= bnxt_get_ptp_stats,
 };
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index e661ab154d6b..a14d46b9bfdf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -696,11 +696,13 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 		spin_unlock_bh(&ptp->ptp_lock);
 		timestamp.hwtstamp = ns_to_ktime(ns);
 		skb_tstamp_tx(ptp->tx_skb, &timestamp);
+		ptp->stats.ts_pkts++;
 	} else {
 		if (!time_after_eq(jiffies, ptp->abs_txts_tmo)) {
 			ptp->txts_pending = true;
 			return;
 		}
+		ptp->stats.ts_lost++;
 		netdev_warn_once(bp->dev,
 				 "TS query for TX timer failed rc = %x\n", rc);
 	}
@@ -979,6 +981,11 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 		rc = err;
 		goto out;
 	}
+
+	ptp->stats.ts_pkts = 0;
+	ptp->stats.ts_lost = 0;
+	atomic64_set(&ptp->stats.ts_err, 0);
+
 	if (BNXT_CHIP_P5(bp)) {
 		spin_lock_bh(&ptp->ptp_lock);
 		bnxt_refclk_read(bp, NULL, &ptp->current_time);
@@ -1013,5 +1020,6 @@ void bnxt_ptp_clear(struct bnxt *bp)
 		dev_kfree_skb_any(ptp->tx_skb);
 		ptp->tx_skb = NULL;
 	}
+
 	bnxt_unmap_ptp_regs(bp);
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index 2c3415c8fc03..8c30b428a428 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -79,6 +79,12 @@ struct bnxt_pps {
 	struct pps_pin pins[BNXT_MAX_TSIO_PINS];
 };
 
+struct bnxt_ptp_stats {
+	u64		ts_pkts;
+	u64		ts_lost;
+	atomic64_t	ts_err;
+};
+
 struct bnxt_ptp_cfg {
 	struct ptp_clock_info	ptp_info;
 	struct ptp_clock	*ptp_clock;
@@ -125,6 +131,8 @@ struct bnxt_ptp_cfg {
 	u32			refclk_mapped_regs[2];
 	u32			txts_tmo;
 	unsigned long		abs_txts_tmo;
+
+	struct bnxt_ptp_stats	stats;
 };
 
 #if BITS_PER_LONG == 32
-- 
2.43.0


