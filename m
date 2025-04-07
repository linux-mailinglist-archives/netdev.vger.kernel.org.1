Return-Path: <netdev+bounces-179777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6837AA7E812
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2821766BB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617B2163B6;
	Mon,  7 Apr 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaE7ALiW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451E215F6A
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046537; cv=none; b=uOTy+IkU3wSu8tc6lYW+27+AU8WkYZHYAXARUYxg0YWqzVMeFyQKjws4Qp3tuh6Blu4jj9cvdanBRhzPYpBOg4aPpYRMOI2KSAIcxAtLhvjhYl4ExAqNzAk218Z0XBY8iFZOa6SSJT/VfeeqeorSS3gQSnck7rzvp38kroV1Ejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046537; c=relaxed/simple;
	bh=xFnHtvY+9qXLTFEreWXH3ozM52qtv7L3nAyRTc0GMEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWfdYkHwgBgNBkISzovRuVxz+j5M4aeDJU5q/ERBk5n1ek2LGXB+sPpqkJpGs3LFUZNrDT5r1ZlnpfuTUxcMiSk4TgVZH90PbYDQ/nMyFvhofZ0biPVhSsJAtqUJl39u+vcq6QRBcT6Wspxbv0oCpAXEm4S/OX9rA1ywzEJcphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaE7ALiW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so2660706f8f.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046534; x=1744651334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrS9tg5WxhzD7JtN8Y++VTzKA94fdUFDba5FPXwUMmw=;
        b=aaE7ALiWF8NRPSJiqahIeenMyB0E8ER0SWG8RFbFOC3k4gG0MTsJXjQ8eVWp5Zz8+8
         gVrkdQ9E5GQZRTqMP1TYpCdwIcLU2qtQZIw8jqz8anlcdmFY9MTD/eqjVMPiw9wzgJPI
         Zh5YcHsUkJnbUuFaDfDfRlHDXhKVQ+QlibLBPFFCjbFr0OE3OQVuXuJYhdikezDnSei9
         v7Ntw+3dms6o0MSv6G++x/pGS6p8WcxKPQ0bCCfjq6VURDTGE712t8UMju7DXcM3YlMC
         5DPgoR9B36bkdBPXnlqMAzAc9VUv/BmbZm741c+fa0IQzRNex85y2qqdEFWvTJCrjF0N
         7pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046534; x=1744651334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrS9tg5WxhzD7JtN8Y++VTzKA94fdUFDba5FPXwUMmw=;
        b=JsR/g0FgP/ZhKjcvtrTi6thXTzI+PGtGpS0X/y+bQeTtT6cK5/8S/qRusWa8MDyLYc
         7JwmY+2Tt36eLgzPxg0xjyFJkS8mNkBa/66DSvsbl5SYD/4Xke8Kvc7WZUupvLcfvXrk
         /nduaWmDMlqG1Igyvb1TKCyQVc22OIVGTzUKS7NfPS2y+KLLHn95bNjQgCnH9u10cAFj
         4vKEQDp3M4pdw91EeMHCOzEH4Ytpo0UlUUwRvZg9N2nvSzpTf8TvsFHMz6ClEKW7J4PN
         kBG/nqFUXtjc4xxBbRottnWvVqGcm441wh1ZBt+8Vh065xD336h/F5j2pZGoSUP2mHtP
         N7CQ==
X-Gm-Message-State: AOJu0YzNXuHkyqMV0kJm5S3gti4JXkb4LifYYVSr2K3ELp9/70LJchsn
	0ilF8RnU/3R0aswNkcXWAjiarbkjLlyR2vWzDT3mS3y8JvSdmkz38cq2/Mlf
X-Gm-Gg: ASbGncvr1LFZwYq5JpxLHjRGQg9aqsT1nyrPEB9Hx5v+MkgZk68OqaWzThffsl72GL6
	nWleoB2+8lwvz8in8CVhstsuOjm80L3oMOkNGO9Cd/M1KjwcsQpOEXQugW3AVKAx0+ftPG3+ZBQ
	u2D3d22PSoN29B+354sCSi8r5bDjRMmo4ZpmeSGVrhVrd08oMYM6sk7g/KnsuOfdpv4lFpsywqG
	1V21HFXtcVVWphmfOXKxPomYJrwiCI7Nq0EiHrrcJkIHZHABSpa7XNfIi8dQxIgLy3fkZPbvYsL
	9k6X6eoMrldZQRS9XHF6PiichmqAut7qjY09onX0FhI=
X-Google-Smtp-Source: AGHT+IG/ZDzb5p2++Ix+EkNO0Ik3NzMm+OSxyvLLfZSc7/4ihcGbaGPkTCtnsuefX3kq8nY/c7bX7w==
X-Received: by 2002:a5d:648e:0:b0:39c:30f9:339c with SMTP id ffacd0b85a97d-39d6fc4ecb0mr7521232f8f.28.1744046533547;
        Mon, 07 Apr 2025 10:22:13 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:47::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d64dsm12888176f8f.70.2025.04.07.10.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 10:22:13 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	suhui@nfschina.com,
	sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next 3/5] eth: fbnic: add coverage for RXB stats
Date: Mon,  7 Apr 2025 10:21:49 -0700
Message-ID: <20250407172151.3802893-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
References: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch provides coverage to the RXB (RX Buffer) stats. RXB stats
are divided into 3 sections: RXB enqueue, RXB FIFO, and RXB dequeue
stats.

The RXB enqueue/dequeue stats are indexed from 0-3 and cater for the
input/output counters whereas, the RXB fifo stats are indexed from 0-7.

The RXB also supports pause frame stats counters which we are leaving
for a later patch.

ethtool -S eth0 | grep rxb
     rxb_integrity_err0: 0
     rxb_mac_err0: 0
     rxb_parser_err0: 0
     rxb_frm_err0: 0
     rxb_drbo0_frames: 1433543
     rxb_drbo0_bytes: 775949081
     ---
     ---
     rxb_intf3_frames: 1195711
     rxb_intf3_bytes: 739650210
     rxb_pbuf3_frames: 1195711
     rxb_pbuf3_bytes: 765948092

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  26 +++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   8 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 110 +++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 171 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  28 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  14 +-
 6 files changed, 356 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index bc7f2fef2875..8ba94ae95db9 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -31,6 +31,32 @@ separate entry.
 Statistics
 ----------
 
+RXB (RX Buffer) Enqueue
+~~~~~~~~~~~~~~~~~~~~~~~
+
+ - ``rxb_integrity_err[i]``: frames enqueued with integrity errors (e.g., multi-bit ECC errors) on RXB input i
+ - ``rxb_mac_err[i]``: frames enqueued with MAC end-of-frame errors (e.g., bad FCS) on RXB input i
+ - ``rxb_parser_err[i]``: frames experienced RPC parser errors
+ - ``rxb_frm_err[i]``: frames experienced signaling errors (e.g., missing end-of-packet/start-of-packet) on RXB input i
+ - ``rxb_drbo[i]_frames``: frames received at RXB input i
+ - ``rxb_drbo[i]_bytes``: bytes received at RXB input i
+
+RXB (RX Buffer) FIFO
+~~~~~~~~~~~~~~~~~~~~
+
+ - ``rxb_fifo[i]_drop``: transitions into the drop state on RXB pool i
+ - ``rxb_fifo[i]_dropped_frames``: frames dropped on RXB pool i
+ - ``rxb_fifo[i]_ecn``: transitions into the ECN mark state on RXB pool i
+ - ``rxb_fifo[i]_level``: current occupancy of RXB pool i
+
+RXB (RX Buffer) Dequeue
+~~~~~~~~~~~~~~~~~~~~~~~
+
+   - ``rxb_intf[i]_frames``: frames sent to the output i
+   - ``rxb_intf[i]_bytes``: bytes sent to the output i
+   - ``rxb_pbuf[i]_frames``: frames sent to output i from the perspective of internal packet buffer
+   - ``rxb_pbuf[i]_bytes``: bytes sent to output i from the perspective of internal packet buffer
+
 RPC (Rx parser)
 ~~~~~~~~~~~~~~~
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index ff5f68c7e73d..a554e0b2cfff 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -485,6 +485,14 @@ enum {
 	FBNIC_RXB_FIFO_INDICES		= 8
 };
 
+enum {
+	FBNIC_RXB_INTF_NET = 0,
+	FBNIC_RXB_INTF_RBT = 1,
+	/* Unused */
+	/* Unused */
+	FBNIC_RXB_INTF_INDICES	= 4
+};
+
 #define FBNIC_RXB_CT_SIZE(n)		(0x08000 + (n))	/* 0x20000 + 4*n */
 #define FBNIC_RXB_CT_SIZE_CNT			8
 #define FBNIC_RXB_CT_SIZE_HEADER		CSR_GENMASK(5, 0)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 1688f6d0abc8..518c180173ce 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -40,6 +40,47 @@ static const struct fbnic_stat fbnic_gstrings_hw_stats[] = {
 
 #define FBNIC_HW_FIXED_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_stats)
 
+#define FBNIC_RXB_ENQUEUE_STAT(name, stat) \
+	FBNIC_STAT_FIELDS(fbnic_rxb_enqueue_stats, name, stat)
+
+static const struct fbnic_stat fbnic_gstrings_rxb_enqueue_stats[] = {
+	FBNIC_RXB_ENQUEUE_STAT("rxb_integrity_err%u", integrity_err),
+	FBNIC_RXB_ENQUEUE_STAT("rxb_mac_err%u", mac_err),
+	FBNIC_RXB_ENQUEUE_STAT("rxb_parser_err%u", parser_err),
+	FBNIC_RXB_ENQUEUE_STAT("rxb_frm_err%u", frm_err),
+
+	FBNIC_RXB_ENQUEUE_STAT("rxb_drbo%u_frames", drbo.frames),
+	FBNIC_RXB_ENQUEUE_STAT("rxb_drbo%u_bytes", drbo.bytes),
+};
+
+#define FBNIC_HW_RXB_ENQUEUE_STATS_LEN \
+	ARRAY_SIZE(fbnic_gstrings_rxb_enqueue_stats)
+
+#define FBNIC_RXB_FIFO_STAT(name, stat) \
+	FBNIC_STAT_FIELDS(fbnic_rxb_fifo_stats, name, stat)
+
+static const struct fbnic_stat fbnic_gstrings_rxb_fifo_stats[] = {
+	FBNIC_RXB_FIFO_STAT("rxb_fifo%u_drop", trans_drop),
+	FBNIC_RXB_FIFO_STAT("rxb_fifo%u_dropped_frames", drop.frames),
+	FBNIC_RXB_FIFO_STAT("rxb_fifo%u_ecn", trans_ecn),
+	FBNIC_RXB_FIFO_STAT("rxb_fifo%u_level", level),
+};
+
+#define FBNIC_HW_RXB_FIFO_STATS_LEN ARRAY_SIZE(fbnic_gstrings_rxb_fifo_stats)
+
+#define FBNIC_RXB_DEQUEUE_STAT(name, stat) \
+	FBNIC_STAT_FIELDS(fbnic_rxb_dequeue_stats, name, stat)
+
+static const struct fbnic_stat fbnic_gstrings_rxb_dequeue_stats[] = {
+	FBNIC_RXB_DEQUEUE_STAT("rxb_intf%u_frames", intf.frames),
+	FBNIC_RXB_DEQUEUE_STAT("rxb_intf%u_bytes", intf.bytes),
+	FBNIC_RXB_DEQUEUE_STAT("rxb_pbuf%u_frames", pbuf.frames),
+	FBNIC_RXB_DEQUEUE_STAT("rxb_pbuf%u_bytes", pbuf.bytes),
+};
+
+#define FBNIC_HW_RXB_DEQUEUE_STATS_LEN \
+	ARRAY_SIZE(fbnic_gstrings_rxb_dequeue_stats)
+
 #define FBNIC_HW_Q_STAT(name, stat) \
 	FBNIC_STAT_FIELDS(fbnic_hw_q_stats, name, stat.value)
 
@@ -52,6 +93,9 @@ static const struct fbnic_stat fbnic_gstrings_hw_q_stats[] = {
 #define FBNIC_HW_Q_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_q_stats)
 #define FBNIC_HW_STATS_LEN \
 	(FBNIC_HW_FIXED_STATS_LEN + \
+	 FBNIC_HW_RXB_ENQUEUE_STATS_LEN * FBNIC_RXB_ENQUEUE_INDICES + \
+	 FBNIC_HW_RXB_FIFO_STATS_LEN * FBNIC_RXB_FIFO_INDICES + \
+	 FBNIC_HW_RXB_DEQUEUE_STATS_LEN * FBNIC_RXB_DEQUEUE_INDICES + \
 	 FBNIC_HW_Q_STATS_LEN * FBNIC_MAX_QUEUES)
 
 static void
@@ -311,6 +355,36 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	return err;
 }
 
+static void fbnic_get_rxb_enqueue_strings(u8 **data, unsigned int idx)
+{
+	const struct fbnic_stat *stat;
+	int i;
+
+	stat = fbnic_gstrings_rxb_enqueue_stats;
+	for (i = 0; i < FBNIC_HW_RXB_ENQUEUE_STATS_LEN; i++, stat++)
+		ethtool_sprintf(data, stat->string, idx);
+}
+
+static void fbnic_get_rxb_fifo_strings(u8 **data, unsigned int idx)
+{
+	const struct fbnic_stat *stat;
+	int i;
+
+	stat = fbnic_gstrings_rxb_fifo_stats;
+	for (i = 0; i < FBNIC_HW_RXB_FIFO_STATS_LEN; i++, stat++)
+		ethtool_sprintf(data, stat->string, idx);
+}
+
+static void fbnic_get_rxb_dequeue_strings(u8 **data, unsigned int idx)
+{
+	const struct fbnic_stat *stat;
+	int i;
+
+	stat = fbnic_gstrings_rxb_dequeue_stats;
+	for (i = 0; i < FBNIC_HW_RXB_DEQUEUE_STATS_LEN; i++, stat++)
+		ethtool_sprintf(data, stat->string, idx);
+}
+
 static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
 {
 	const struct fbnic_stat *stat;
@@ -321,6 +395,15 @@ static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
 		for (i = 0; i < FBNIC_HW_FIXED_STATS_LEN; i++)
 			ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
 
+		for (i = 0; i < FBNIC_RXB_ENQUEUE_INDICES; i++)
+			fbnic_get_rxb_enqueue_strings(&data, i);
+
+		for (i = 0; i < FBNIC_RXB_FIFO_INDICES; i++)
+			fbnic_get_rxb_fifo_strings(&data, i);
+
+		for (i = 0; i < FBNIC_RXB_DEQUEUE_INDICES; i++)
+			fbnic_get_rxb_dequeue_strings(&data, i);
+
 		for (idx = 0; idx < FBNIC_MAX_QUEUES; idx++) {
 			stat = fbnic_gstrings_hw_q_stats;
 
@@ -355,6 +438,33 @@ static void fbnic_get_ethtool_stats(struct net_device *dev,
 	fbnic_report_hw_stats(fbnic_gstrings_hw_stats, &fbd->hw_stats,
 			      FBNIC_HW_FIXED_STATS_LEN, &data);
 
+	for (i = 0; i < FBNIC_RXB_ENQUEUE_INDICES; i++) {
+		const struct fbnic_rxb_enqueue_stats *enq;
+
+		enq = &fbd->hw_stats.rxb.enq[i];
+		fbnic_report_hw_stats(fbnic_gstrings_rxb_enqueue_stats,
+				      enq, FBNIC_HW_RXB_ENQUEUE_STATS_LEN,
+				      &data);
+	}
+
+	for (i = 0; i < FBNIC_RXB_FIFO_INDICES; i++) {
+		const struct fbnic_rxb_fifo_stats *fifo;
+
+		fifo = &fbd->hw_stats.rxb.fifo[i];
+		fbnic_report_hw_stats(fbnic_gstrings_rxb_fifo_stats,
+				      fifo, FBNIC_HW_RXB_FIFO_STATS_LEN,
+				      &data);
+	}
+
+	for (i = 0; i < FBNIC_RXB_DEQUEUE_INDICES; i++) {
+		const struct fbnic_rxb_dequeue_stats *deq;
+
+		deq = &fbd->hw_stats.rxb.deq[i];
+		fbnic_report_hw_stats(fbnic_gstrings_rxb_dequeue_stats,
+				      deq, FBNIC_HW_RXB_DEQUEUE_STATS_LEN,
+				      &data);
+	}
+
 	for (i  = 0; i < FBNIC_MAX_QUEUES; i++) {
 		const struct fbnic_hw_q_stats *hw_q = &fbd->hw_stats.hw_q[i];
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index c8faedc2ec44..1c5ccaf39727 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -117,6 +117,173 @@ static void fbnic_get_rpc_stats32(struct fbnic_dev *fbd,
 			   &rpc->ovr_size_err);
 }
 
+static void fbnic_reset_rxb_fifo_stats(struct fbnic_dev *fbd, int i,
+				       struct fbnic_rxb_fifo_stats *fifo)
+{
+	fbnic_hw_stat_rst32(fbd, FBNIC_RXB_DROP_FRMS_STS(i),
+			    &fifo->drop.frames);
+	fbnic_hw_stat_rst64(fbd, FBNIC_RXB_DROP_BYTES_STS_L(i), 1,
+			    &fifo->drop.bytes);
+
+	fbnic_hw_stat_rst32(fbd, FBNIC_RXB_TRUN_FRMS_STS(i),
+			    &fifo->trunc.frames);
+	fbnic_hw_stat_rst64(fbd, FBNIC_RXB_TRUN_BYTES_STS_L(i), 1,
+			    &fifo->trunc.bytes);
+
+	fbnic_hw_stat_rst32(fbd, FBNIC_RXB_TRANS_DROP_STS(i),
+			    &fifo->trans_drop);
+	fbnic_hw_stat_rst32(fbd, FBNIC_RXB_TRANS_ECN_STS(i),
+			    &fifo->trans_ecn);
+
+	fifo->level.u.old_reg_value_32 = 0;
+}
+
+static void fbnic_reset_rxb_enq_stats(struct fbnic_dev *fbd, int i,
+				      struct fbnic_rxb_enqueue_stats *enq)
+{
+	fbnic_hw_stat_rst32(fbd, FBNIC_RXB_DRBO_FRM_CNT_SRC(i),
+			    &enq->drbo.frames);
+	fbnic_hw_stat_rst64(fbd, FBNIC_RXB_DRBO_BYTE_CNT_SRC_L(i), 4,
+			    &enq->drbo.bytes);
+
+	fbnic_hw_stat_rst32(fbd, FBNIC_RXB_INTEGRITY_ERR(i),
+			    &enq->integrity_err);
+	fbnic_hw_stat_rst32(fbd, FBNIC_RXB_MAC_ERR(i),
+			    &enq->mac_err);
+	fbnic_hw_stat_rst32(fbd, FBNIC_RXB_PARSER_ERR(i),
+			    &enq->parser_err);
+	fbnic_hw_stat_rst32(fbd, FBNIC_RXB_FRM_ERR(i),
+			    &enq->frm_err);
+}
+
+static void fbnic_reset_rxb_deq_stats(struct fbnic_dev *fbd, int i,
+				      struct fbnic_rxb_dequeue_stats *deq)
+{
+	fbnic_hw_stat_rst32(fbd, FBNIC_RXB_INTF_FRM_CNT_DST(i),
+			    &deq->intf.frames);
+	fbnic_hw_stat_rst64(fbd, FBNIC_RXB_INTF_BYTE_CNT_DST_L(i), 4,
+			    &deq->intf.bytes);
+
+	fbnic_hw_stat_rst32(fbd, FBNIC_RXB_PBUF_FRM_CNT_DST(i),
+			    &deq->pbuf.frames);
+	fbnic_hw_stat_rst64(fbd, FBNIC_RXB_PBUF_BYTE_CNT_DST_L(i), 4,
+			    &deq->pbuf.bytes);
+}
+
+static void fbnic_reset_rxb_stats(struct fbnic_dev *fbd,
+				  struct fbnic_rxb_stats *rxb)
+{
+	int i;
+
+	for (i = 0; i < FBNIC_RXB_FIFO_INDICES; i++)
+		fbnic_reset_rxb_fifo_stats(fbd, i, &rxb->fifo[i]);
+
+	for (i = 0; i < FBNIC_RXB_INTF_INDICES; i++) {
+		fbnic_reset_rxb_enq_stats(fbd, i, &rxb->enq[i]);
+		fbnic_reset_rxb_deq_stats(fbd, i, &rxb->deq[i]);
+	}
+}
+
+static void fbnic_get_rxb_fifo_stats32(struct fbnic_dev *fbd, int i,
+				       struct fbnic_rxb_fifo_stats *fifo)
+{
+	fbnic_hw_stat_rd32(fbd, FBNIC_RXB_DROP_FRMS_STS(i),
+			   &fifo->drop.frames);
+	fbnic_hw_stat_rd32(fbd, FBNIC_RXB_TRUN_FRMS_STS(i),
+			   &fifo->trunc.frames);
+
+	fbnic_hw_stat_rd32(fbd, FBNIC_RXB_TRANS_DROP_STS(i),
+			   &fifo->trans_drop);
+	fbnic_hw_stat_rd32(fbd, FBNIC_RXB_TRANS_ECN_STS(i),
+			   &fifo->trans_ecn);
+
+	fifo->level.value = rd32(fbd, FBNIC_RXB_PBUF_FIFO_LEVEL(i));
+}
+
+static void fbnic_get_rxb_fifo_stats(struct fbnic_dev *fbd, int i,
+				     struct fbnic_rxb_fifo_stats *fifo)
+{
+	fbnic_hw_stat_rd64(fbd, FBNIC_RXB_DROP_BYTES_STS_L(i), 1,
+			   &fifo->drop.bytes);
+	fbnic_hw_stat_rd64(fbd, FBNIC_RXB_TRUN_BYTES_STS_L(i), 1,
+			   &fifo->trunc.bytes);
+
+	fbnic_get_rxb_fifo_stats32(fbd, i, fifo);
+}
+
+static void fbnic_get_rxb_enq_stats32(struct fbnic_dev *fbd, int i,
+				      struct fbnic_rxb_enqueue_stats *enq)
+{
+	fbnic_hw_stat_rd32(fbd, FBNIC_RXB_DRBO_FRM_CNT_SRC(i),
+			   &enq->drbo.frames);
+
+	fbnic_hw_stat_rd32(fbd, FBNIC_RXB_INTEGRITY_ERR(i),
+			   &enq->integrity_err);
+	fbnic_hw_stat_rd32(fbd, FBNIC_RXB_MAC_ERR(i),
+			   &enq->mac_err);
+	fbnic_hw_stat_rd32(fbd, FBNIC_RXB_PARSER_ERR(i),
+			   &enq->parser_err);
+	fbnic_hw_stat_rd32(fbd, FBNIC_RXB_FRM_ERR(i),
+			   &enq->frm_err);
+}
+
+static void fbnic_get_rxb_enq_stats(struct fbnic_dev *fbd, int i,
+				    struct fbnic_rxb_enqueue_stats *enq)
+{
+	fbnic_hw_stat_rd64(fbd, FBNIC_RXB_DRBO_BYTE_CNT_SRC_L(i), 4,
+			   &enq->drbo.bytes);
+
+	fbnic_get_rxb_enq_stats32(fbd, i, enq);
+}
+
+static void fbnic_get_rxb_deq_stats32(struct fbnic_dev *fbd, int i,
+				      struct fbnic_rxb_dequeue_stats *deq)
+{
+	fbnic_hw_stat_rd32(fbd, FBNIC_RXB_INTF_FRM_CNT_DST(i),
+			   &deq->intf.frames);
+	fbnic_hw_stat_rd32(fbd, FBNIC_RXB_PBUF_FRM_CNT_DST(i),
+			   &deq->pbuf.frames);
+}
+
+static void fbnic_get_rxb_deq_stats(struct fbnic_dev *fbd, int i,
+				    struct fbnic_rxb_dequeue_stats *deq)
+{
+	fbnic_hw_stat_rd64(fbd, FBNIC_RXB_INTF_BYTE_CNT_DST_L(i), 4,
+			   &deq->intf.bytes);
+	fbnic_hw_stat_rd64(fbd, FBNIC_RXB_PBUF_BYTE_CNT_DST_L(i), 4,
+			   &deq->pbuf.bytes);
+
+	fbnic_get_rxb_deq_stats32(fbd, i, deq);
+}
+
+static void fbnic_get_rxb_stats32(struct fbnic_dev *fbd,
+				  struct fbnic_rxb_stats *rxb)
+{
+	int i;
+
+	for (i = 0; i < FBNIC_RXB_FIFO_INDICES; i++)
+		fbnic_get_rxb_fifo_stats32(fbd, i, &rxb->fifo[i]);
+
+	for (i = 0; i < FBNIC_RXB_INTF_INDICES; i++) {
+		fbnic_get_rxb_enq_stats32(fbd, i, &rxb->enq[i]);
+		fbnic_get_rxb_deq_stats32(fbd, i, &rxb->deq[i]);
+	}
+}
+
+static void fbnic_get_rxb_stats(struct fbnic_dev *fbd,
+				struct fbnic_rxb_stats *rxb)
+{
+	int i;
+
+	for (i = 0; i < FBNIC_RXB_FIFO_INDICES; i++)
+		fbnic_get_rxb_fifo_stats(fbd, i, &rxb->fifo[i]);
+
+	for (i = 0; i < FBNIC_RXB_INTF_INDICES; i++) {
+		fbnic_get_rxb_enq_stats(fbd, i, &rxb->enq[i]);
+		fbnic_get_rxb_deq_stats(fbd, i, &rxb->deq[i]);
+	}
+}
+
 static void fbnic_reset_hw_rxq_stats(struct fbnic_dev *fbd,
 				     struct fbnic_hw_q_stats *hw_q)
 {
@@ -253,6 +420,7 @@ void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 {
 	spin_lock(&fbd->hw_stats_lock);
 	fbnic_reset_rpc_stats(fbd, &fbd->hw_stats.rpc);
+	fbnic_reset_rxb_stats(fbd, &fbd->hw_stats.rxb);
 	fbnic_reset_hw_rxq_stats(fbd, fbd->hw_stats.hw_q);
 	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
 	spin_unlock(&fbd->hw_stats_lock);
@@ -261,6 +429,7 @@ void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 static void __fbnic_get_hw_stats32(struct fbnic_dev *fbd)
 {
 	fbnic_get_rpc_stats32(fbd, &fbd->hw_stats.rpc);
+	fbnic_get_rxb_stats32(fbd, &fbd->hw_stats.rxb);
 	fbnic_get_hw_rxq_stats32(fbd, fbd->hw_stats.hw_q);
 }
 
@@ -275,6 +444,8 @@ void fbnic_get_hw_stats(struct fbnic_dev *fbd)
 {
 	spin_lock(&fbd->hw_stats_lock);
 	__fbnic_get_hw_stats32(fbd);
+
+	fbnic_get_rxb_stats(fbd, &fbd->hw_stats.rxb);
 	fbnic_get_pcie_stats_asic64(fbd, &fbd->hw_stats.pcie);
 	spin_unlock(&fbd->hw_stats_lock);
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index 81efa8dc8381..ec03e6253ba5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -17,6 +17,11 @@ struct fbnic_stat_counter {
 	bool reported;
 };
 
+struct fbnic_hw_stat {
+	struct fbnic_stat_counter frames;
+	struct fbnic_stat_counter bytes;
+};
+
 struct fbnic_eth_mac_stats {
 	struct fbnic_stat_counter FramesTransmittedOK;
 	struct fbnic_stat_counter FramesReceivedOK;
@@ -43,6 +48,28 @@ struct fbnic_rpc_stats {
 	struct fbnic_stat_counter tcp_opt_err, out_of_hdr_err, ovr_size_err;
 };
 
+struct fbnic_rxb_enqueue_stats {
+	struct fbnic_hw_stat drbo;
+	struct fbnic_stat_counter integrity_err, mac_err;
+	struct fbnic_stat_counter parser_err, frm_err;
+};
+
+struct fbnic_rxb_fifo_stats {
+	struct fbnic_hw_stat drop, trunc;
+	struct fbnic_stat_counter trans_drop, trans_ecn;
+	struct fbnic_stat_counter level;
+};
+
+struct fbnic_rxb_dequeue_stats {
+	struct fbnic_hw_stat intf, pbuf;
+};
+
+struct fbnic_rxb_stats {
+	struct fbnic_rxb_enqueue_stats enq[FBNIC_RXB_ENQUEUE_INDICES];
+	struct fbnic_rxb_fifo_stats fifo[FBNIC_RXB_FIFO_INDICES];
+	struct fbnic_rxb_dequeue_stats deq[FBNIC_RXB_DEQUEUE_INDICES];
+};
+
 struct fbnic_hw_q_stats {
 	struct fbnic_stat_counter rde_pkt_err;
 	struct fbnic_stat_counter rde_pkt_cq_drop;
@@ -62,6 +89,7 @@ struct fbnic_pcie_stats {
 struct fbnic_hw_stats {
 	struct fbnic_mac_stats mac;
 	struct fbnic_rpc_stats rpc;
+	struct fbnic_rxb_stats rxb;
 	struct fbnic_hw_q_stats hw_q[FBNIC_MAX_QUEUES];
 	struct fbnic_pcie_stats pcie;
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index e21a315ba694..05d7f4c06040 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -408,8 +408,8 @@ static void fbnic_get_stats64(struct net_device *dev,
 	struct fbnic_net *fbn = netdev_priv(dev);
 	struct fbnic_dev *fbd = fbn->fbd;
 	struct fbnic_queue_stats *stats;
+	u64 rx_over = 0, rx_missed = 0;
 	unsigned int start, i;
-	u64 rx_over = 0;
 
 	fbnic_get_hw_stats(fbd);
 
@@ -448,6 +448,17 @@ static void fbnic_get_stats64(struct net_device *dev,
 	rx_packets = stats->packets;
 	rx_dropped = stats->dropped;
 
+	/* Record drops for the host FIFOs.
+	 * 4: network to Host,	6: BMC to Host
+	 * Exclude the BMC and MC FIFOs as those stats may contain drops
+	 * due to unrelated items such as TCAM misses. They are still
+	 * accessible through the ethtool stats.
+	 */
+	i = FBNIC_RXB_FIFO_HOST;
+	rx_missed += fbd->hw_stats.rxb.fifo[i].drop.frames.value;
+	i = FBNIC_RXB_FIFO_BMC_TO_HOST;
+	rx_missed += fbd->hw_stats.rxb.fifo[i].drop.frames.value;
+
 	for (i = 0; i < fbd->max_num_queues; i++) {
 		/* Report packets dropped due to CQ/BDQ being full/empty */
 		rx_over += fbd->hw_stats.hw_q[i].rde_pkt_cq_drop.value;
@@ -462,6 +473,7 @@ static void fbnic_get_stats64(struct net_device *dev,
 	stats64->rx_dropped = rx_dropped;
 	stats64->rx_over_errors = rx_over;
 	stats64->rx_errors = rx_errors;
+	stats64->rx_missed_errors = rx_missed;
 
 	for (i = 0; i < fbn->num_rx_queues; i++) {
 		struct fbnic_ring *rxr = fbn->rx[i];
-- 
2.47.1


