Return-Path: <netdev+bounces-133247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF64995641
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BAC1F2691E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE7E21264E;
	Tue,  8 Oct 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="b91OEC4q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047F1E0E1D
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411308; cv=none; b=XEDp66j4r1VzTciQKsvfU8Xs7Fb+7Z62sdJJ5Az2/ru3ylRErgxlkGWKi0qPMfoMBSoTDpU1yb+O8zgmv+EMmFuKEIivcPlYTmNDUR9IJmFni+uXtAhyBImb9NPgjY1kkX4uPhXxEY94HTjg2e5YBKzBQ+XmJQ08TNO2h76UJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411308; c=relaxed/simple;
	bh=K9s9RGRV3G1z3rXxbqNe+b1HrpaWa5c3A7EJtt2Og6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I39EfR+CjTBlCgQF6wPUuuoutf2UJnd0YfAWt8x9olhocn3NlBfuukbo9AFWPyjJQ8p7f2BSWc8rV7AwrQkzai6f7lcl4azFo3733yN6hiQXJWxBSNKcVFR8g13azT1pVhyFxSEtWoMaQ/k090pc4pKx+F6WQUTo5uYoXe805Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=b91OEC4q; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498GcIvT023369;
	Tue, 8 Oct 2024 11:14:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=HS85CrIJZ/2d8TtRsZYfxzrcM/O+0zMdojGSfLeyQws=; b=b91OEC4qtudJ
	yXcymLZlVKrbMzNzjm+Gu+4fM3Rn+IDljdKIFfqaiAl8BWD9AJB3rnzBlwsM1URw
	JtTKyGmH/daPvOJnCw7ZRM4on8sZt1aa0wc66DxlPjW4Uz4mUyEWHlByV5TUGUm/
	ayTx4FrJgl4l8kjA37U6cgn6ym4gTtIcPEFR52udzAw9BW0sIWwZkuWbx8vxGVhI
	T+TATg1dCX/AIT9YVcP1foHg7sgd37kMqdIYhGrRKAht2jwpiTnc17d6liu8Ehwf
	fbzKJNGOS2yHpyLRNK8fBLzirSU5S5dGzoQIWLSMGjlU7BaRe2zutHkTAVXI6mTu
	rtsXSKLw0Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42339s279v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 08 Oct 2024 11:14:52 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 8 Oct 2024 18:14:49 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Duyck
	<alexanderduyck@fb.com>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>,
        "Richard
 Cochran" <richardcochran@gmail.com>
Subject: [PATCH net-next v4 3/5] eth: fbnic: add RX packets timestamping support
Date: Tue, 8 Oct 2024 11:14:34 -0700
Message-ID: <20241008181436.4120604-4-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008181436.4120604-1-vadfed@meta.com>
References: <20241008181436.4120604-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _Sz6O18KkOriG9zSWdNizaR16pKNcV-T
X-Proofpoint-ORIG-GUID: _Sz6O18KkOriG9zSWdNizaR16pKNcV-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Add callbacks to support timestamping configuration via ethtool.
Add processing of RX timestamps.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  1 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 16 +++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 80 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  3 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   | 31 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 63 +++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
 7 files changed, 194 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 290b924b7749..79cdd231d327 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -586,6 +586,7 @@ enum {
 };
 
 #define FBNIC_RPC_ACT_TBL0_DMA_HINT		CSR_GENMASK(24, 16)
+#define FBNIC_RPC_ACT_TBL0_TS_ENA		CSR_BIT(28)
 #define FBNIC_RPC_ACT_TBL0_RSS_CTXT_ID		CSR_BIT(30)
 
 #define FBNIC_RPC_ACT_TBL1_DEFAULT	0x0840b		/* 0x2102c */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index ffc773014e0f..3afb7227574a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -10,8 +10,22 @@ static int
 fbnic_get_ts_info(struct net_device *netdev,
 		  struct kernel_ethtool_ts_info *tsinfo)
 {
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	tsinfo->phc_index = ptp_clock_index(fbn->fbd->ptp);
+
 	tsinfo->so_timestamping =
-		SOF_TIMESTAMPING_TX_SOFTWARE;
+		SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_RX_HARDWARE |
+		SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	tsinfo->rx_filters =
+		BIT(HWTSTAMP_FILTER_NONE) |
+		BIT(HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
+		BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
+		BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
+		BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
+		BIT(HWTSTAMP_FILTER_ALL);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 6e6d8988db54..c08798fad203 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -324,6 +324,84 @@ void fbnic_clear_rx_mode(struct net_device *netdev)
 	__dev_mc_unsync(netdev, NULL);
 }
 
+static int fbnic_hwtstamp_get(struct net_device *netdev,
+			      struct kernel_hwtstamp_config *config)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	*config = fbn->hwtstamp_config;
+
+	return 0;
+}
+
+static int fbnic_hwtstamp_set(struct net_device *netdev,
+			      struct kernel_hwtstamp_config *config,
+			      struct netlink_ext_ack *extack)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	int old_rx_filter;
+
+	if (config->source != HWTSTAMP_SOURCE_NETDEV)
+		return -EOPNOTSUPP;
+
+	if (!kernel_hwtstamp_config_changed(config, &fbn->hwtstamp_config))
+		return 0;
+
+	/* Upscale the filters */
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+	case HWTSTAMP_FILTER_ALL:
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+		break;
+	case HWTSTAMP_FILTER_NTP_ALL:
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+		config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	/* Configure */
+	old_rx_filter = fbn->hwtstamp_config.rx_filter;
+	memcpy(&fbn->hwtstamp_config, config, sizeof(*config));
+
+	if (old_rx_filter != config->rx_filter && netif_running(fbn->netdev)) {
+		fbnic_rss_reinit(fbn->fbd, fbn);
+		fbnic_write_rules(fbn->fbd);
+	}
+
+	/* Save / report back filter configuration
+	 * Note that our filter configuration is inexact. Instead of
+	 * filtering for a specific UDP port or L2 Ethertype we are
+	 * filtering in all UDP or all non-IP packets for timestamping. So
+	 * if anything other than FILTER_ALL is requested we report
+	 * FILTER_SOME indicating that we will be timestamping a few
+	 * additional packets.
+	 */
+	if (config->rx_filter > HWTSTAMP_FILTER_ALL)
+		config->rx_filter = HWTSTAMP_FILTER_SOME;
+
+	return 0;
+}
+
 static void fbnic_get_stats64(struct net_device *dev,
 			      struct rtnl_link_stats64 *stats64)
 {
@@ -401,6 +479,8 @@ static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_set_mac_address	= fbnic_set_mac,
 	.ndo_set_rx_mode	= fbnic_set_rx_mode,
 	.ndo_get_stats64	= fbnic_get_stats64,
+	.ndo_hwtstamp_get	= fbnic_hwtstamp_get,
+	.ndo_hwtstamp_set	= fbnic_hwtstamp_set,
 };
 
 static void fbnic_get_queue_stats_rx(struct net_device *dev, int idx,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index f530e3235634..b8417b300778 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -54,6 +54,9 @@ struct fbnic_net {
 	struct fbnic_queue_stats rx_stats;
 	u64 link_down_events;
 
+	/* Time stampinn filter config */
+	struct kernel_hwtstamp_config hwtstamp_config;
+
 	struct list_head napis;
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index c8aa29fc052b..337b8b3aef2f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -244,6 +244,12 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 	 ((_ip) ? FBNIC_RPC_TCAM_ACT1_IP_VALID : 0) |	\
 	 ((_v6) ? FBNIC_RPC_TCAM_ACT1_IP_IS_V6 : 0))
 
+#define FBNIC_TSTAMP_MASK(_all, _udp, _ether)			\
+	(((_all) ? ((1u << FBNIC_NUM_HASH_OPT) - 1) : 0) |	\
+	 ((_udp) ? (1u << FBNIC_UDP6_HASH_OPT) |		\
+		   (1u << FBNIC_UDP4_HASH_OPT) : 0) |		\
+	 ((_ether) ? (1u << FBNIC_ETHER_HASH_OPT) : 0))
+
 void fbnic_rss_reinit(struct fbnic_dev *fbd, struct fbnic_net *fbn)
 {
 	static const u32 act1_value[FBNIC_NUM_HASH_OPT] = {
@@ -255,6 +261,7 @@ void fbnic_rss_reinit(struct fbnic_dev *fbd, struct fbnic_net *fbn)
 		FBNIC_ACT1_INIT(0, 0, 1, 0),	/* IP4 */
 		0				/* Ether */
 	};
+	u32 tstamp_mask = 0;
 	unsigned int i;
 
 	/* To support scenarios where a BMC is present we must write the
@@ -264,6 +271,28 @@ void fbnic_rss_reinit(struct fbnic_dev *fbd, struct fbnic_net *fbn)
 	BUILD_BUG_ON(FBNIC_RSS_EN_NUM_UNICAST * 2 != FBNIC_RSS_EN_NUM_ENTRIES);
 	BUILD_BUG_ON(ARRAY_SIZE(act1_value) != FBNIC_NUM_HASH_OPT);
 
+	/* Set timestamp mask with 1b per flow type */
+	if (fbn->hwtstamp_config.rx_filter != HWTSTAMP_FILTER_NONE) {
+		switch (fbn->hwtstamp_config.rx_filter) {
+		case HWTSTAMP_FILTER_ALL:
+			tstamp_mask = FBNIC_TSTAMP_MASK(1, 1, 1);
+			break;
+		case HWTSTAMP_FILTER_PTP_V2_EVENT:
+			tstamp_mask = FBNIC_TSTAMP_MASK(0, 1, 1);
+			break;
+		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+			tstamp_mask = FBNIC_TSTAMP_MASK(0, 1, 0);
+			break;
+		case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+			tstamp_mask = FBNIC_TSTAMP_MASK(0, 0, 1);
+			break;
+		default:
+			netdev_warn(fbn->netdev, "Unsupported hwtstamp_rx_filter\n");
+			break;
+		}
+	}
+
 	/* Program RSS hash enable mask for host in action TCAM/table. */
 	for (i = fbnic_bmc_present(fbd) ? 0 : FBNIC_RSS_EN_NUM_UNICAST;
 	     i < FBNIC_RSS_EN_NUM_ENTRIES; i++) {
@@ -287,6 +316,8 @@ void fbnic_rss_reinit(struct fbnic_dev *fbd, struct fbnic_net *fbn)
 
 		if (!dest)
 			dest = FBNIC_RPC_ACT_TBL0_DROP;
+		else if (tstamp_mask & (1u << flow_type))
+			dest |= FBNIC_RPC_ACT_TBL0_TS_ENA;
 
 		if (act1_value[flow_type] & FBNIC_RPC_TCAM_ACT1_L4_VALID)
 			dest |= FIELD_PREP(FBNIC_RPC_ACT_TBL0_DMA_HINT,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 8337d49bad0b..cbf7a6c6331a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -43,6 +43,46 @@ static void fbnic_ring_wr32(struct fbnic_ring *ring, unsigned int csr, u32 val)
 	writel(val, csr_base + csr);
 }
 
+/**
+ * fbnic_ts40_to_ns() - convert descriptor timestamp to PHC time
+ * @fbn: netdev priv of the FB NIC
+ * @ts40: timestamp read from a descriptor
+ *
+ * Return: u64 value of PHC time in nanoseconds
+ *
+ * Convert truncated 40 bit device timestamp as read from a descriptor
+ * to the full PHC time in nanoseconds.
+ */
+static __maybe_unused u64 fbnic_ts40_to_ns(struct fbnic_net *fbn, u64 ts40)
+{
+	unsigned int s;
+	u64 time_ns;
+	s64 offset;
+	u8 ts_top;
+	u32 high;
+
+	do {
+		s = u64_stats_fetch_begin(&fbn->time_seq);
+		offset = READ_ONCE(fbn->time_offset);
+	} while (u64_stats_fetch_retry(&fbn->time_seq, s));
+
+	high = READ_ONCE(fbn->time_high);
+
+	/* Bits 63..40 from periodic clock reads, 39..0 from ts40 */
+	time_ns = (u64)(high >> 8) << 40 | ts40;
+
+	/* Compare bits 32-39 between periodic reads and ts40,
+	 * see if HW clock may have wrapped since last read. We are sure
+	 * that periodic reads are always at least ~1 minute behind, so
+	 * this logic works perfectly fine.
+	 */
+	ts_top = ts40 >> 32;
+	if (ts_top < (u8)high && (u8)high - ts_top > U8_MAX / 2)
+		time_ns += 1ULL << 40;
+
+	return time_ns + offset;
+}
+
 static unsigned int fbnic_desc_unused(struct fbnic_ring *ring)
 {
 	return (ring->head - ring->tail - 1) & ring->size_mask;
@@ -710,6 +750,10 @@ static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
 	/* Set MAC header specific fields */
 	skb->protocol = eth_type_trans(skb, nv->napi.dev);
 
+	/* Add timestamp if present */
+	if (pkt->hwtstamp)
+		skb_hwtstamps(skb)->hwtstamp = pkt->hwtstamp;
+
 	return skb;
 }
 
@@ -720,6 +764,23 @@ static enum pkt_hash_types fbnic_skb_hash_type(u64 rcd)
 						     PKT_HASH_TYPE_L2;
 }
 
+static void fbnic_rx_tstamp(struct fbnic_napi_vector *nv, u64 rcd,
+			    struct fbnic_pkt_buff *pkt)
+{
+	struct fbnic_net *fbn;
+	u64 ns, ts;
+
+	if (!FIELD_GET(FBNIC_RCD_OPT_META_TS, rcd))
+		return;
+
+	fbn = netdev_priv(nv->napi.dev);
+	ts = FIELD_GET(FBNIC_RCD_OPT_META_TS_MASK, rcd);
+	ns = fbnic_ts40_to_ns(fbn, ts);
+
+	/* Add timestamp to shared info */
+	pkt->hwtstamp = ns_to_ktime(ns);
+}
+
 static void fbnic_populate_skb_fields(struct fbnic_napi_vector *nv,
 				      u64 rcd, struct sk_buff *skb,
 				      struct fbnic_q_triad *qt)
@@ -784,6 +845,8 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			if (FIELD_GET(FBNIC_RCD_OPT_META_TYPE_MASK, rcd))
 				break;
 
+			fbnic_rx_tstamp(nv, rcd, pkt);
+
 			/* We currently ignore the action table index */
 			break;
 		case FBNIC_RCD_TYPE_META:
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 2f91f68d11d5..682d875f08c0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -47,6 +47,7 @@ struct fbnic_net;
 
 struct fbnic_pkt_buff {
 	struct xdp_buff buff;
+	ktime_t hwtstamp;
 	u32 data_truesize;
 	u16 data_len;
 	u16 nr_frags;
-- 
2.43.5


