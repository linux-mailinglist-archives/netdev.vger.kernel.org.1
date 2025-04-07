Return-Path: <netdev+bounces-179778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC81A7E813
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF2D3ABB19
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DBD2165ED;
	Mon,  7 Apr 2025 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdtPDahY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD35217677
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046541; cv=none; b=mZY2SWtzvqQzNpQaX+C/tH9Hn7AZMqR9CgWQ5WWVdMicy0P+w+FKdS/Qvs3Y7OoIYyvOeED/+J5tZ0hKbrq7KUb5NveuyZC6OfZQJ5zyEkRRomlo6LiguF/Fu0BgGVC3x9IQeRP6TAK+v1GFLK4Fo1fg7VAmkkQ+jNCK72Sbhys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046541; c=relaxed/simple;
	bh=e6xBCx6KCyZQ+WAmG8p/9CXT2fwMx05TH0LteZH4924=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsPorAnX6abWp/M228gfEYepHFxM1rFqiG+K6nUdjtJtcBvIMLpVB8g3vlUsrPQ163c1uDdj/kDbsqEFVi/aFzZ9ahKhn2Pzx/UK4njVwdF5AkxjxY12SqzKD7QBfgBSENvvneC04BGqPBbcouxsWfs5TQGToxs0TL/g928qo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdtPDahY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f2f391864so2582592f8f.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046537; x=1744651337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJXfebpW96isL83shSVBOH8JQgo3FAHUrKjLExiexoY=;
        b=WdtPDahYGFfTZeeHWVky1HMy+TwidjBv4SDfYRS69gOgRWvBbOLjtkrGtrl1iwSYtP
         anVOmv3GoRHXd5+FEKBiSuBfddTfyZhxl3brMz+JFo2O+78Q9wNC/aiwRLpT6Oac5xOg
         iL9H5wl371L2kDG1Dv/4LJtzyoV9miMMGi2t18nZf9MXTM/sEG3r9kZ+iTbKT/HtFquK
         7bAA3yr5H/qamEMT5CzF4CsNQIc5hYyWdcE8m54V9ysgKCzjuw2X2lUVhe+xAYDcgXMi
         Hn9frokQVvD4sKrh0lAboSwR8btoK9y938Uo6WZGovR3Eb5bu+MFScg7lX+eLK1nhEiZ
         pPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046537; x=1744651337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJXfebpW96isL83shSVBOH8JQgo3FAHUrKjLExiexoY=;
        b=a9d34J8wioN6vL5b9X/ND/bNQHwszd2j237DcPc7r/7QXxr673O0ReughnIoShXy9Z
         d3J32cmLLR3+VgVgB1RTR35Ote0ArU+/S/s6RmJRTs6pBi0XDaZT5eHNZLHlPfXvGsjE
         hD4HCpuPnCF63nnk4J6eApS3bS2aKjywj7o+Vt0PlfAAFhIwCMBbtSuMYJXOkjKPLjY+
         kSvveQQw1XXZSMTnSaqcPSO73kRa2IdkFuv1sisAYe5UZHUTYtYLHTX7ce20fzsWxCEU
         U6aVqU3wTVPdYCbn0dcZL5FZDwzKFNMesPlrm650x2HUZu7mbcUpqB0HMYInjCZLiG/7
         mzpA==
X-Gm-Message-State: AOJu0YwKC2n3ZS6zWc/mYSqOqE/0PusLCgo8+OGcakr+i6Usp40jbLNq
	PgEuyzbzYQXWonpbNOGuSwFnrtqHS9YjAOpnNhZJ1MgYs4nbqKLBL0ivvaLO
X-Gm-Gg: ASbGncuUc+SpoEXdx7g8+7r8vENt3xPVhNosBueD9+buNHd38D3VfGio+evQYrOXdVn
	pjxKnwQvjqfIg2bN490wWiTFGdNIQ5a3Dur5MSjAqsYYX89iaEBuFaFwtCoTjB5uXXiSlW5BaBW
	AGv495MAkreH1WYvlzglOImZ3o8tU4vPznY5h6yOdqP6DYE0AuVaLhLijG0gbNbEXSgk9rQXMB6
	myTBwUZUteJOiT+FELLSY0lfP/0kX7GrIAxC1pTSOLXJJ5p4zHMhRESmrVJRb/o+vWjyETVmZHI
	SwmZVC3OgsonHyKYagrnEqgz033t+7En/ZTqEfitmies33CLgNYY
X-Google-Smtp-Source: AGHT+IF/ISIzO4QcinNjGjHgk4Mw8uWkbHQyBVecjKkKsLcUhIcf2gvhxNsk5YIg7yrEbZa2ItkfVg==
X-Received: by 2002:a05:6000:1849:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-39d0de3e88dmr11702843f8f.35.1744046536869;
        Mon, 07 Apr 2025 10:22:16 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d66csm13114993f8f.63.2025.04.07.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 10:22:16 -0700 (PDT)
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
Subject: [PATCH net-next 4/5] eth: fbnic: add support for TMI stats
Date: Mon,  7 Apr 2025 10:21:50 -0700
Message-ID: <20250407172151.3802893-5-mohsin.bashr@gmail.com>
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

This patch add coverage for TMI stats including PTP stats and drop
stats.

PTP stats include illegal requests, bad timestamp and good timestamps.
The bad timestamp and illegal request counters are reported under as
`error` via `ethtool -T` Both these counters are individually being
reported via `ethtool -S`

The good timestamp stats are being reported as `pkts` via `ethtool -T`

ethtool -S eth0 | grep "ptp"
     ptp_illegal_req: 0
     ptp_good_ts: 0
     ptp_bad_ts: 0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  7 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  5 +++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  5 +++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 34 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  6 ++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  3 ++
 6 files changed, 60 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 8ba94ae95db9..02339818cb8d 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -31,6 +31,13 @@ separate entry.
 Statistics
 ----------
 
+TX MAC Interface
+~~~~~~~~~~~~~~~~
+
+ - ``ptp_illegal_req``: packets sent to the NIC with PTP request bit set but routed to BMC/FW
+ - ``ptp_good_ts``: packets successfully routed to MAC with PTP request bit set
+ - ``ptp_bad_ts``: packets destined for MAC with PTP request bit set but aborted because of some error (e.g., DMA read error)
+
 RXB (RX Buffer) Enqueue
 ~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index a554e0b2cfff..9426f7f2e611 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -432,6 +432,11 @@ enum {
 #define FBNIC_TMI_SOP_PROT_CTRL		0x04400		/* 0x11000 */
 #define FBNIC_TMI_DROP_CTRL		0x04401		/* 0x11004 */
 #define FBNIC_TMI_DROP_CTRL_EN			CSR_BIT(0)
+#define FBNIC_TMI_DROP_PKTS		0x04402		/* 0x11008 */
+#define FBNIC_TMI_DROP_BYTE_L		0x04403		/* 0x1100c */
+#define FBNIC_TMI_ILLEGAL_PTP_REQS	0x04409		/* 0x11024 */
+#define FBNIC_TMI_GOOD_PTP_TS		0x0440a		/* 0x11028 */
+#define FBNIC_TMI_BAD_PTP_TS		0x0440b		/* 0x1102c */
 #define FBNIC_CSR_END_TMI		0x0443f	/* CSR section delimiter */
 
 /* Precision Time Protocol Registers */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 518c180173ce..de43a1b4a0be 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -27,6 +27,11 @@ struct fbnic_stat {
 	FBNIC_STAT_FIELDS(fbnic_hw_stats, name, stat)
 
 static const struct fbnic_stat fbnic_gstrings_hw_stats[] = {
+	/* TMI */
+	FBNIC_HW_STAT("ptp_illegal_req", tmi.ptp_illegal_req),
+	FBNIC_HW_STAT("ptp_good_ts", tmi.ptp_good_ts),
+	FBNIC_HW_STAT("ptp_bad_ts", tmi.ptp_bad_ts),
+
 	/* RPC */
 	FBNIC_HW_STAT("rpc_unkn_etype", rpc.unkn_etype),
 	FBNIC_HW_STAT("rpc_unkn_ext_hdr", rpc.unkn_ext_hdr),
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 1c5ccaf39727..80157f389975 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -70,6 +70,37 @@ static void fbnic_hw_stat_rd64(struct fbnic_dev *fbd, u32 reg, s32 offset,
 	stat->u.old_reg_value_64 = new_reg_value;
 }
 
+static void fbnic_reset_tmi_stats(struct fbnic_dev *fbd,
+				  struct fbnic_tmi_stats *tmi)
+{
+	fbnic_hw_stat_rst32(fbd, FBNIC_TMI_DROP_PKTS, &tmi->drop.frames);
+	fbnic_hw_stat_rst64(fbd, FBNIC_TMI_DROP_BYTE_L, 1, &tmi->drop.bytes);
+
+	fbnic_hw_stat_rst32(fbd,
+			    FBNIC_TMI_ILLEGAL_PTP_REQS,
+			    &tmi->ptp_illegal_req);
+	fbnic_hw_stat_rst32(fbd, FBNIC_TMI_GOOD_PTP_TS, &tmi->ptp_good_ts);
+	fbnic_hw_stat_rst32(fbd, FBNIC_TMI_BAD_PTP_TS, &tmi->ptp_bad_ts);
+}
+
+static void fbnic_get_tmi_stats32(struct fbnic_dev *fbd,
+				  struct fbnic_tmi_stats *tmi)
+{
+	fbnic_hw_stat_rd32(fbd, FBNIC_TMI_DROP_PKTS, &tmi->drop.frames);
+
+	fbnic_hw_stat_rd32(fbd,
+			   FBNIC_TMI_ILLEGAL_PTP_REQS,
+			   &tmi->ptp_illegal_req);
+	fbnic_hw_stat_rd32(fbd, FBNIC_TMI_GOOD_PTP_TS, &tmi->ptp_good_ts);
+	fbnic_hw_stat_rd32(fbd, FBNIC_TMI_BAD_PTP_TS, &tmi->ptp_bad_ts);
+}
+
+static void fbnic_get_tmi_stats(struct fbnic_dev *fbd,
+				struct fbnic_tmi_stats *tmi)
+{
+	fbnic_hw_stat_rd64(fbd, FBNIC_TMI_DROP_BYTE_L, 1, &tmi->drop.bytes);
+}
+
 static void fbnic_reset_rpc_stats(struct fbnic_dev *fbd,
 				  struct fbnic_rpc_stats *rpc)
 {
@@ -419,6 +450,7 @@ static void fbnic_get_pcie_stats_asic64(struct fbnic_dev *fbd,
 void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 {
 	spin_lock(&fbd->hw_stats_lock);
+	fbnic_reset_tmi_stats(fbd, &fbd->hw_stats.tmi);
 	fbnic_reset_rpc_stats(fbd, &fbd->hw_stats.rpc);
 	fbnic_reset_rxb_stats(fbd, &fbd->hw_stats.rxb);
 	fbnic_reset_hw_rxq_stats(fbd, fbd->hw_stats.hw_q);
@@ -428,6 +460,7 @@ void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 
 static void __fbnic_get_hw_stats32(struct fbnic_dev *fbd)
 {
+	fbnic_get_tmi_stats32(fbd, &fbd->hw_stats.tmi);
 	fbnic_get_rpc_stats32(fbd, &fbd->hw_stats.rpc);
 	fbnic_get_rxb_stats32(fbd, &fbd->hw_stats.rxb);
 	fbnic_get_hw_rxq_stats32(fbd, fbd->hw_stats.hw_q);
@@ -445,6 +478,7 @@ void fbnic_get_hw_stats(struct fbnic_dev *fbd)
 	spin_lock(&fbd->hw_stats_lock);
 	__fbnic_get_hw_stats32(fbd);
 
+	fbnic_get_tmi_stats(fbd, &fbd->hw_stats.tmi);
 	fbnic_get_rxb_stats(fbd, &fbd->hw_stats.rxb);
 	fbnic_get_pcie_stats_asic64(fbd, &fbd->hw_stats.pcie);
 	spin_unlock(&fbd->hw_stats_lock);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index ec03e6253ba5..abb0957a5ac0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -42,6 +42,11 @@ struct fbnic_mac_stats {
 	struct fbnic_eth_mac_stats eth_mac;
 };
 
+struct fbnic_tmi_stats {
+	struct fbnic_hw_stat drop;
+	struct fbnic_stat_counter ptp_illegal_req, ptp_good_ts, ptp_bad_ts;
+};
+
 struct fbnic_rpc_stats {
 	struct fbnic_stat_counter unkn_etype, unkn_ext_hdr;
 	struct fbnic_stat_counter ipv4_frag, ipv6_frag, ipv4_esp, ipv6_esp;
@@ -88,6 +93,7 @@ struct fbnic_pcie_stats {
 
 struct fbnic_hw_stats {
 	struct fbnic_mac_stats mac;
+	struct fbnic_tmi_stats tmi;
 	struct fbnic_rpc_stats rpc;
 	struct fbnic_rxb_stats rxb;
 	struct fbnic_hw_q_stats hw_q[FBNIC_MAX_QUEUES];
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 05d7f4c06040..6802799b0f63 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -423,6 +423,9 @@ static void fbnic_get_stats64(struct net_device *dev,
 	stats64->tx_packets = tx_packets;
 	stats64->tx_dropped = tx_dropped;
 
+	/* Record drops from Tx HW Datapath */
+	tx_dropped += fbd->hw_stats.tmi.drop.frames.value;
+
 	for (i = 0; i < fbn->num_tx_queues; i++) {
 		struct fbnic_ring *txr = fbn->tx[i];
 
-- 
2.47.1


