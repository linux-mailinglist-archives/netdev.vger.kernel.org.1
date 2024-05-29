Return-Path: <netdev+bounces-99148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9799F8D3D47
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E82A282240
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBA2181BA7;
	Wed, 29 May 2024 17:20:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF6839E2
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003209; cv=none; b=BqraFXw5V1rQsnj4edfnYNoiABE13fwmJYfphA3rIu6luV9g7r05HUCKPqZvKwEa3pzEnnlAkB2lty891ivTCuVvPkmLifh4pTVjPLIhAE5dii7u+fbkbJ4gyDBv6G9lVxu7zP8RffAlDSiaYUqmk/jLHIgmYlNs8iCwU11ndUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003209; c=relaxed/simple;
	bh=jYnfurIQdytmcl47D3eAttdm770xlabKN2+/V75dwLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvpmKRxRfLK63zM/FVw1xx8ib0NebT1DQLBgvQUFRihylv4Xt8JEtR15wF8q193gcZ8xSMuTmY9jQqmHyTnMZvEl4Qj/BTZ4CZPh92jeKiQmSIb4VbqwC7oP5AqDYAVj7psDNiwMnZPRP3mu367cH4VOBEM3JeOAazIvvMbMoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44TH8o1V006591;
	Wed, 29 May 2024 10:19:56 -0700
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dmeta.com;_h=3Dc?=
 =?UTF-8?Q?c:content-transfer-encoding:content-type:date:from:message-id:m?=
 =?UTF-8?Q?ime-version:subject:to;_s=3Ds2048-2021-q4;_bh=3DZoS9DoAcF8SzocN?=
 =?UTF-8?Q?9vQceCQQUZUTcyEZwFSp7zF3bdlo=3D;_b=3DVJqer7fkc8d9MHOR5blMaDadI9?=
 =?UTF-8?Q?fSg8tNWLA8MwKHyrAk+FzoOL90z1oXNnPtKzD9U3RV_PDH0KJIf680P5zlkQCVY?=
 =?UTF-8?Q?IdVdRoF+qLOfgvVh4/LxpsPDndy69Mbs0AKhbV4JMTulz4A3_eR2XG1FciXp5DL?=
 =?UTF-8?Q?A+Y8cNUKDeE48sWV0uaQ+62FNciCLhqj4JdkxMpZ2V1YlMv4E899LG_OeuNd+0L?=
 =?UTF-8?Q?1GTtm/E2jMc2Rb38EGVKeiT5vTHO+K0PvOYZz8HXAqca99wZX253hI0Arc9/_WO?=
 =?UTF-8?Q?3ouZ7ly8ww7xVm3+3cHrm6MTQVrL9RU08Qw2gvVBXr9iOOii5sj6XhRnWSYTHc+?=
 =?UTF-8?Q?nA3_dA=3D=3D_?=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ye1y8u01a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 29 May 2024 10:19:56 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 29 May 2024 17:19:53 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Michael Chan <michael.chan@broadcom.com>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        "Jakub
 Kicinski" <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
        Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH net-next] bnxt_en: add timestamping statistics support
Date: Wed, 29 May 2024 10:19:46 -0700
Message-ID: <20240529171946.2866274-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wKY8J4KElHyfpz4iYYNVoHSgAXxoyImW
X-Proofpoint-GUID: wKY8J4KElHyfpz4iYYNVoHSgAXxoyImW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_13,2024-05-28_01,2024-05-17_01

The ethtool_ts_stats structure was introduced earlier this year. Now
it's time to support this group of counters in more drivers.
This patch adds support to bnxt driver.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c      | 18 +++++++++++++-----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c  | 18 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c  | 18 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h  |  8 ++++++++
 4 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c437ca1c0fd3..f3db8b0fbbe6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -512,8 +512,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 
-		if (ptp && ptp->tx_tstamp_en && !skb_is_gso(skb) &&
-		    atomic_dec_if_positive(&ptp->tx_avail) >= 0) {
+		if (ptp && ptp->tx_tstamp_en && !skb_is_gso(skb)) {
+			if (!atomic_dec_if_positive(&ptp->tx_avail)) {
+				atomic64_inc(&ptp->stats->ts_err);
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
+		atomic64_inc(&bp->ptp_cfg->stats->ts_err);
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
+					atomic64_inc(&bp->ptp_cfg->stats->ts_err);
 					atomic_inc(&bp->ptp_cfg->tx_avail);
+				}
 			}
 		}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 8763f8a01457..594e9967c591 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5233,6 +5233,23 @@ static void bnxt_get_rmon_stats(struct net_device *dev,
 	*ranges = bnxt_rmon_ranges;
 }
 
+static void bnxt_get_ptp_stats(struct net_device *dev,
+			       struct ethtool_ts_stats *ts_stats)
+{
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
+
+	if (ptp) {
+		ts_stats->pkts = ptp->stats->ts_pkts;
+		ts_stats->lost = ptp->stats->ts_lost;
+		ts_stats->err = atomic64_read(&ptp->stats->ts_err);
+	} else {
+		ts_stats->pkts = 0;
+		ts_stats->err = 0;
+		ts_stats->lost = 0;
+	}
+}
+
 static void bnxt_get_link_ext_stats(struct net_device *dev,
 				    struct ethtool_link_ext_stats *stats)
 {
@@ -5316,4 +5333,5 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.get_eth_mac_stats	= bnxt_get_eth_mac_stats,
 	.get_eth_ctrl_stats	= bnxt_get_eth_ctrl_stats,
 	.get_rmon_stats		= bnxt_get_rmon_stats,
+	.get_ts_stats		= bnxt_get_ptp_stats,
 };
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index e661ab154d6b..f75bcb8d43c0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -696,11 +696,13 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 		spin_unlock_bh(&ptp->ptp_lock);
 		timestamp.hwtstamp = ns_to_ktime(ns);
 		skb_tstamp_tx(ptp->tx_skb, &timestamp);
+		ptp->stats->ts_pkts++;
 	} else {
 		if (!time_after_eq(jiffies, ptp->abs_txts_tmo)) {
 			ptp->txts_pending = true;
 			return;
 		}
+		ptp->stats->ts_lost++;
 		netdev_warn_once(bp->dev,
 				 "TS query for TX timer failed rc = %x\n", rc);
 	}
@@ -979,6 +981,18 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 		rc = err;
 		goto out;
 	}
+	if (!ptp->stats) {
+		ptp->stats = kzalloc(sizeof(*ptp->stats), GFP_KERNEL);
+		if (!ptp->stats) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		atomic64_set(&ptp->stats->ts_err, 0);
+	} else {
+		ptp->stats->ts_pkts = 0;
+		ptp->stats->ts_lost = 0;
+		atomic64_set(&ptp->stats->ts_err, 0);
+	}
 	if (BNXT_CHIP_P5(bp)) {
 		spin_lock_bh(&ptp->ptp_lock);
 		bnxt_refclk_read(bp, NULL, &ptp->current_time);
@@ -1013,5 +1027,9 @@ void bnxt_ptp_clear(struct bnxt *bp)
 		dev_kfree_skb_any(ptp->tx_skb);
 		ptp->tx_skb = NULL;
 	}
+
+	kfree(ptp->stats);
+	ptp->stats = NULL;
+
 	bnxt_unmap_ptp_regs(bp);
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index 2c3415c8fc03..589e093b1608 100644
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
+	struct bnxt_ptp_stats	*stats;
 };
 
 #if BITS_PER_LONG == 32
-- 
2.43.0


