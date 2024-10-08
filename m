Return-Path: <netdev+bounces-133248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C62995642
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 225EEB22DAA
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF9212D1A;
	Tue,  8 Oct 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Bc65cCGx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92071212D13
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411309; cv=none; b=S/Na7Gg2Qycoca7HAyGSrOI31mznqlyJV6DEJUgsTUsRwtZV0W7clvmYZhf1ASS3r5jMjq9VJgwWGKcawrDC3gUVOxRIDTMVvladX56pEkLtmPrv1dQeANnja6rSxjBEl/Pp47kz9vt22J32HIpLuVhDfM2iAAL5VRxbjkHcV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411309; c=relaxed/simple;
	bh=I6mfGxJtqlkzMaXjuY7zpAdRc3hztKT1u+eujAyHMFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxIFmDev9u8XgGMZbHp3arbu34lNI9VjJ8mYAboreSmmyyoWPbMfTsqcCza8j5TLSmKJ3wMNV3ZvYRm/b2gsa77Q+O0K7S9ULQBDhSd7yu9d4YIeWH9y0mjWjMqrjHoheF0OI+PNL8Jiqhsq6i33LW6LlT62UBhvvBCE2j9ZbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Bc65cCGx; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498GcIvb023369;
	Tue, 8 Oct 2024 11:15:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=vf2oq6bPUFBPbfr9GzykesF1/WoXMH1eSU+8YVQiPdE=; b=Bc65cCGxvZC9
	1RPeTE09sD+APo2dVuZek9S+NY80IUEfms6JIDYAq7Ly2joFQ/ABh6vgUKoFFr8R
	8isrogyKgWG+DsPqknf9D7JY9Zqya67g/e5367bwI3KqwuuKvblO11aEG9a/Smle
	MjZ+9wQt0dRiZDVwxRFFzelC/7k9i8m1Ji5tubu/bqaJ80EdJbQEy8igzZOIUhq5
	euzqDewwn1ir393QqaKvQEqfhxymCZKhjfH+UHMRKqeIo9ZAhX1TP+uyw7b7gkcU
	+tzNgfLlpLWMmHHAXEDbNtwxJ/slvsXAq3Pp5pDyBV51p2jNdYzKZh1E4m1qPGe3
	NYM3ibgt7A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42339s279v-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 08 Oct 2024 11:14:59 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 8 Oct 2024 18:14:51 +0000
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
Subject: [PATCH net-next v4 4/5] eth: fbnic: add TX packets timestamping support
Date: Tue, 8 Oct 2024 11:14:35 -0700
Message-ID: <20241008181436.4120604-5-vadfed@meta.com>
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
X-Proofpoint-GUID: l50ZzmEliCsteeVrdUZKCv_7yrl1o261
X-Proofpoint-ORIG-GUID: l50ZzmEliCsteeVrdUZKCv_7yrl1o261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

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
index cbf7a6c6331a..2e3d06946e74 100644
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
 
@@ -150,11 +155,32 @@ static void fbnic_unmap_page_twd(struct device *dev, __le64 *twd)
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
 
@@ -374,6 +400,12 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
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
@@ -427,6 +459,53 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
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
@@ -460,10 +539,12 @@ static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
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
@@ -471,9 +552,9 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 		int napi_budget)
 {
 	struct fbnic_ring *cmpl = &qt->cmpl;
+	s32 head0 = -1, ts_head = -1;
 	__le64 *raw_tcd, done;
 	u32 head = cmpl->head;
-	s32 head0 = -1;
 
 	done = (head & (cmpl->size_mask + 1)) ? 0 : cpu_to_le64(FBNIC_TCD_DONE);
 	raw_tcd = &cmpl->desc[head & cmpl->size_mask];
@@ -496,6 +577,12 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
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
@@ -515,7 +602,7 @@ fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
 	}
 
 	/* Unmap and free processed buffers */
-	fbnic_clean_twq(nv, napi_budget, qt, head0);
+	fbnic_clean_twq(nv, napi_budget, qt, ts_head, head0);
 }
 
 static void fbnic_clean_bdq(struct fbnic_napi_vector *nv, int napi_budget,
-- 
2.43.5


