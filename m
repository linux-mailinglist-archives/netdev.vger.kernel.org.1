Return-Path: <netdev+bounces-131592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B198EF62
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D51E280DD6
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A911865F0;
	Thu,  3 Oct 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hief5dLy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D31186E43
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959205; cv=none; b=M+/qsA3vevY4UsXXqXQ1VOQPQUJODfmRp+ABo5MdjQspMQ+nQMo5xDFCGfm7Z5Kf6ZiXz0fzmkbuYqvFsEcTK9E/YArYpT6OCT2YLJsx98I6eBuT67kC+MZ/remdiTola7gTxMYgvs+g4m2XKNnaQAfo70Stlapts811NQj1C5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959205; c=relaxed/simple;
	bh=RPfVXY7VQY172YEzddSu4YUOBUuNpU9cnr6ll98N82c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7pmNIBY7KsrE2eIe5QDn2CyAyH1Gf+TDCAld7PCIzI9beEKMCgc1rjYvEhInWD7BAYfYNxWR6FdrfNQHpZPkBBaOuZ8nQG9D3hL8hxyoj5EJ3IR1ZbxUMaqXmD0oECqXURugmo5Z69rfuRdD8IAZtkgwwcSc51MpLkb8EbCd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hief5dLy; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4935dLZO001492;
	Thu, 3 Oct 2024 05:39:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=nQv9m+1+55+AJzEDyMQnNeLAxw/QL4wH/eZzYlCVn48=; b=
	hief5dLyMF7V1jU4ApLdO8DPf8rVN+N96Ai30gTEwq17bSPf6ts1OPIUAWIFqr3O
	HX1lbhaYfyeFLFsIGLq8DSP9mk/Cl14in1ZBix9dkS7abIJSLZPlCyJR2MI97aaJ
	JDHxyleJzPvbNsB6x5lNCVqezUX3lSJdrAXrzDLbezRQwmm3o4zBTUzOew7E9XPi
	u9guvawGbjHHUN9SILTfxtkgXJrBNxmstGKaoL64+obQ3qFs/JF+HyNXrCOF970T
	9VYA8PCeWzG0BMUeI1J7SIUfXg7lt0PcWsoQVDx9AorT2kuumU7Y9KBjE1geoN5g
	ivxbl3nchuMU2atUY4o3gA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42163x71an-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 03 Oct 2024 05:39:50 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 3 Oct 2024 12:39:47 +0000
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
Subject: [PATCH net-next v3 4/5] eth: fbnic: add TX packets timestamping support
Date: Thu, 3 Oct 2024 05:39:32 -0700
Message-ID: <20241003123933.2589036-5-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241003123933.2589036-1-vadfed@meta.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: H_AXmdPS1ml7VUdAPG66H2t0EcqkeTFs
X-Proofpoint-ORIG-GUID: H_AXmdPS1ml7VUdAPG66H2t0EcqkeTFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01

Add TX configuration to ethtool interface. Add processing of TX
timestamp completions as well as configuration to request HW to create
TX timestamp completion.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  5 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 93 ++++++++++++++++++-
 2 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 3afb7227574a..24e059443264 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -16,9 +16,14 @@ fbnic_get_ts_info(struct net_device *netdev,
 
 	tsinfo->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_TX_HARDWARE |
 		SOF_TIMESTAMPING_RX_HARDWARE |
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 
+	tsinfo->tx_types =
+		BIT(HWTSTAMP_TX_OFF) |
+		BIT(HWTSTAMP_TX_ON);
+
 	tsinfo->rx_filters =
 		BIT(HWTSTAMP_FILTER_NONE) |
 		BIT(HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index b64c1d4f925e..d6f0f3faa82f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -12,9 +12,14 @@
 #include "fbnic_netdev.h"
 #include "fbnic_txrx.h"
 
+enum {
+	FBNIC_XMIT_CB_TS	= 0x01,
+};
+
 struct fbnic_xmit_cb {
 	u32 bytecount;
 	u8 desc_count;
+	u8 flags;
 	int hw_head;
 };
 
@@ -148,11 +153,32 @@ static void fbnic_unmap_page_twd(struct device *dev, __le64 *twd)
 #define FBNIC_TWD_TYPE(_type) \
 	cpu_to_le64(FIELD_PREP(FBNIC_TWD_TYPE_MASK, FBNIC_TWD_TYPE_##_type))
 
+static bool fbnic_tx_tstamp(struct sk_buff *skb)
+{
+	struct fbnic_net *fbn;
+
+	if (!unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
+		return false;
+
+	fbn = netdev_priv(skb->dev);
+	if (fbn->hwtstamp_config.tx_type == HWTSTAMP_TX_OFF)
+		return false;
+
+	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	FBNIC_XMIT_CB(skb)->flags |= FBNIC_XMIT_CB_TS;
+	FBNIC_XMIT_CB(skb)->hw_head = -1;
+
+	return true;
+}
+
 static bool
 fbnic_tx_offloads(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 {
 	unsigned int l2len, i3len;
 
+	if (fbnic_tx_tstamp(skb))
+		*meta |= cpu_to_le64(FBNIC_TWD_FLAG_REQ_TS);
+
 	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
 		return false;
 
@@ -372,6 +398,12 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 		if (desc_cnt > clean_desc)
 			break;
 
+		if (unlikely(FBNIC_XMIT_CB(skb)->flags & FBNIC_XMIT_CB_TS)) {
+			FBNIC_XMIT_CB(skb)->hw_head = hw_head;
+			if (likely(!discard))
+				break;
+		}
+
 		ring->tx_buf[head] = NULL;
 
 		clean_desc -= desc_cnt;
@@ -425,6 +457,53 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 				 FBNIC_TX_DESC_WAKEUP);
 }
 
+static void fbnic_clean_tsq(struct fbnic_napi_vector *nv,
+			    struct fbnic_ring *ring,
+			    u64 tcd, int *ts_head, int *head0)
+{
+	struct skb_shared_hwtstamps hwtstamp;
+	struct fbnic_net *fbn;
+	struct sk_buff *skb;
+	int head;
+	u64 ns;
+
+	head = (*ts_head < 0) ? ring->head : *ts_head;
+
+	do {
+		unsigned int desc_cnt;
+
+		if (head == ring->tail) {
+			if (unlikely(net_ratelimit()))
+				netdev_err(nv->napi.dev,
+					   "Tx timestamp without matching packet\n");
+			return;
+		}
+
+		skb = ring->tx_buf[head];
+		desc_cnt = FBNIC_XMIT_CB(skb)->desc_count;
+
+		head += desc_cnt;
+		head &= ring->size_mask;
+	} while (!(FBNIC_XMIT_CB(skb)->flags & FBNIC_XMIT_CB_TS));
+
+	fbn = netdev_priv(nv->napi.dev);
+	ns = fbnic_ts40_to_ns(fbn, FIELD_GET(FBNIC_TCD_TYPE1_TS_MASK, tcd));
+
+	memset(&hwtstamp, 0, sizeof(hwtstamp));
+	hwtstamp.hwtstamp = ns_to_ktime(ns);
+
+	*ts_head = head;
+
+	FBNIC_XMIT_CB(skb)->flags &= ~FBNIC_XMIT_CB_TS;
+	if (*head0 < 0) {
+		head = FBNIC_XMIT_CB(skb)->hw_head;
+		if (head >= 0)
+			*head0 = head;
+	}
+
+	skb_tstamp_tx(skb, &hwtstamp);
+}
+
 static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
 				 struct page *page)
 {
@@ -458,10 +537,12 @@ static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
 }
 
 static void fbnic_clean_twq(struct fbnic_napi_vector *nv, int napi_budget,
-			    struct fbnic_q_triad *qt, s32 head0)
+			    struct fbnic_q_triad *qt, s32 ts_head, s32 head0)
 {
 	if (head0 >= 0)
 		fbnic_clean_twq0(nv, napi_budget, &qt->sub0, false, head0);
+	else if (ts_head >= 0)
+		fbnic_clean_twq0(nv, napi_budget, &qt->sub0, false, ts_head);
 }
 
 static void
@@ -469,9 +550,9 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 		int napi_budget)
 {
 	struct fbnic_ring *cmpl = &qt->cmpl;
+	s32 head0 = -1, ts_head = -1;
 	__le64 *raw_tcd, done;
 	u32 head = cmpl->head;
-	s32 head0 = -1;
 
 	done = (head & (cmpl->size_mask + 1)) ? 0 : cpu_to_le64(FBNIC_TCD_DONE);
 	raw_tcd = &cmpl->desc[head & cmpl->size_mask];
@@ -494,6 +575,12 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 			 * they are skipped for now.
 			 */
 			break;
+		case FBNIC_TCD_TYPE_1:
+			if (WARN_ON_ONCE(tcd & FBNIC_TCD_TWQ1))
+				break;
+
+			fbnic_clean_tsq(nv, &qt->sub0, tcd, &ts_head, &head0);
+			break;
 		default:
 			break;
 		}
@@ -513,7 +600,7 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 	}
 
 	/* Unmap and free processed buffers */
-	fbnic_clean_twq(nv, napi_budget, qt, head0);
+	fbnic_clean_twq(nv, napi_budget, qt, ts_head, head0);
 }
 
 static void fbnic_clean_bdq(struct fbnic_napi_vector *nv, int napi_budget,
-- 
2.43.5


