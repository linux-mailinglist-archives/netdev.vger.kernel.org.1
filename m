Return-Path: <netdev+bounces-179779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5D8A7E815
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717A9188D9C8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40715217677;
	Mon,  7 Apr 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcaG0gdg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B5217642
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046544; cv=none; b=ondw5Uui/DkRPGy+gnNaIfmys6FcqXdkEmGvbCSZFSo3KQCvJ4K5Idlf0251ISWJCBuLxHfQMbRgF5TQ572pRVuk1BMubUpcUhcSL/YJJQM/mu6inhLtoQCIpwYWduxqvH+PRugaW8sCRvJLGY7qVo/dMkcNpilR/fSucBho+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046544; c=relaxed/simple;
	bh=SYb5LFbJ6uDKlSZCjT/7qUCWvRzj1HDVy849l6JI4ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kk1ELO+5BMdL2/nx+q2p4lwj8nh9ejwKwErA10hgC9LATzwr9q8e1tGEEeEgBAdqNvA7lgMYGSKwvCQgmU+SFCBdCKBoJyYM9S0iK7IBobX1jPswmFOesUSlHBJ75u1sAdfEWb/TJA7jRf7Kilihl7xodMh6m6z0xgue68uqanA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcaG0gdg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso29646795e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046540; x=1744651340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5C7cIzqNnRTj3LvuO37iAmu2AHSFGaDtAXyLA9ukEA=;
        b=KcaG0gdgULl4KjuHDg5yThe2YlabWo7QgwXIfbb2W1eQxagOq0p9Px/BPB68gXRdJ2
         niYs6mlFatmPIMrXdMTGufLYRZRojpN5bZ4rCur+seIIoyxvdf5w6n0d3+0CP+NqUYgz
         J1R3O5ACVt6XOoWNgfYO1SPSWD2JZajP5kJTZ43spOTvVlwxJh6scZSbY4sUrqxU7ig4
         qWTg4F+U4u+K+iofUizY0cRCcnmv1BCp2oFAsXqyMDFJaxT0H8fahjF11IE1hvNBEAX9
         MYRR445rIAs3moS/gxKKoZtgShNv6gQi5ARuzBv85hAQm0EpJtYuXfSM82VEUA/AVFdE
         nzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046540; x=1744651340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5C7cIzqNnRTj3LvuO37iAmu2AHSFGaDtAXyLA9ukEA=;
        b=iIxR835MnMRVe2+uJElilB7d+xqGElLbeljUiawPzJAEmUCaOvMsN5FHk5ezUKg4y0
         vP6s/gwHpp3GJh6h95lQrQ959SVCVVcNMKxCj3BzCnEFZbfLNCOhX5N3npI3hTgdeNyx
         0qryP3GK7mlp0FCcYZwt4/G0rx8sv23ZDoA57UHOIQXLkRNJaHkd7wRtFAbhxW8n/LTL
         5AO79J+y6Y84uypI6tjQd9o6BYma9cPVe2V0EPcPSABfbDBAlA9NzFlPz5UanBcbzORv
         NWXxXhph5COwEMQ6mPms1iy255TAOvA+aZnneoRwNOb1+RJAaSphsJVr3PzULSrnRn0T
         +rmg==
X-Gm-Message-State: AOJu0YypMK3Ebmr4+UFFIxgS1CTcgSXZuxbXs5nWrSfXmne4OKYj/yee
	CeLXUbe48cnFLdL+WQR5sVkLMDshLbJIRA/DgwtAiG/2uMSW8Qbr1gWwOEt2
X-Gm-Gg: ASbGncvRoiyPthx5mr65O4fZEVqmgG1nbjckBKCykpY2o8Pp/m1rrdvtb5/uy9QoOZn
	eE5aoYVomc0XACH7abIRRtIpjBpxaHH3+hnRmJJ3v2m0VQ+ZigeUK85nrVaJmKflgXH6G+OXiCe
	+c2/fgjuNZBeVksrWjJdIM61tqvAyxOReDUQkNbmHhFCCAvprnBrP3d+33tlttexRfw4FCM3CCt
	OsOziDrl1k1EpaktdFUne33ighRKyddW1bWDDW3+WNAjvHRxT4DMHAVf9QI6p922yDhyqpyF0ti
	DxeIjIy4OSH0+4QVyCxfLxheT6keP5xfHPtQG0fPzw==
X-Google-Smtp-Source: AGHT+IFXiSDL0X1tl4X6dgQ/VZNnlqCydPL5w5JaFCUvaLWlVvwSQbDa+bGrBhCgJcVcCjFM+Gvl8w==
X-Received: by 2002:a05:600c:5105:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-43f0e55e881mr2329235e9.4.1744046539686;
        Mon, 07 Apr 2025 10:22:19 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1794efesm140240185e9.28.2025.04.07.10.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 10:22:19 -0700 (PDT)
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
Subject: [PATCH net-next 5/5] eth: fbnic: add support for TTI HW stats
Date: Mon,  7 Apr 2025 10:21:51 -0700
Message-ID: <20250407172151.3802893-6-mohsin.bashr@gmail.com>
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

Add coverage for the TX Extension (TEI) Interface (TTI) stats. We are
tracking packets and control message drops because of credit exhaustion
on the TX interface.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  7 ++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  9 +++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  8 +++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 66 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  5 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  5 +-
 6 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 02339818cb8d..3483e498c08e 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -38,6 +38,13 @@ TX MAC Interface
  - ``ptp_good_ts``: packets successfully routed to MAC with PTP request bit set
  - ``ptp_bad_ts``: packets destined for MAC with PTP request bit set but aborted because of some error (e.g., DMA read error)
 
+TX Extension (TEI) Interface (TTI)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+ - ``tti_cm_drop``: control messages dropped at the TX Extension (TEI) Interface because of credit starvation
+ - ``tti_frame_drop``: packets dropped at the TX Extension (TEI) Interface because of credit starvation
+ - ``tti_tbi_drop``: packets dropped at the TX BMC Interface (TBI) because of credit starvation
+
 RXB (RX Buffer) Enqueue
 ~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 9426f7f2e611..0c217c195c6a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -397,6 +397,15 @@ enum {
 #define FBNIC_TCE_DROP_CTRL_TTI_FRM_DROP_EN	CSR_BIT(1)
 #define FBNIC_TCE_DROP_CTRL_TTI_TBI_DROP_EN	CSR_BIT(2)
 
+#define FBNIC_TCE_TTI_CM_DROP_PKTS	0x0403e		/* 0x100f8 */
+#define FBNIC_TCE_TTI_CM_DROP_BYTE_L	0x0403f		/* 0x100fc */
+#define FBNIC_TCE_TTI_CM_DROP_BYTE_H	0x04040		/* 0x10100 */
+#define FBNIC_TCE_TTI_FRAME_DROP_PKTS	0x04041		/* 0x10104 */
+#define FBNIC_TCE_TTI_FRAME_DROP_BYTE_L	0x04042		/* 0x10108 */
+#define FBNIC_TCE_TTI_FRAME_DROP_BYTE_H	0x04043		/* 0x1010c */
+#define FBNIC_TCE_TBI_DROP_PKTS		0x04044		/* 0x10110 */
+#define FBNIC_TCE_TBI_DROP_BYTE_L	0x04045		/* 0x10114 */
+
 #define FBNIC_TCE_TCAM_IDX2DEST_MAP	0x0404A		/* 0x10128 */
 #define FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_0	CSR_GENMASK(3, 0)
 enum {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index de43a1b4a0be..9082136065f4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -27,6 +27,14 @@ struct fbnic_stat {
 	FBNIC_STAT_FIELDS(fbnic_hw_stats, name, stat)
 
 static const struct fbnic_stat fbnic_gstrings_hw_stats[] = {
+	/* TTI */
+	FBNIC_HW_STAT("tti_cm_drop_frames", tti.cm_drop.frames),
+	FBNIC_HW_STAT("tti_cm_drop_bytes", tti.cm_drop.bytes),
+	FBNIC_HW_STAT("tti_frame_drop_frames", tti.frame_drop.frames),
+	FBNIC_HW_STAT("tti_frame_drop_bytes", tti.frame_drop.bytes),
+	FBNIC_HW_STAT("tti_tbi_drop_frames", tti.tbi_drop.frames),
+	FBNIC_HW_STAT("tti_tbi_drop_bytes", tti.tbi_drop.bytes),
+
 	/* TMI */
 	FBNIC_HW_STAT("ptp_illegal_req", tmi.ptp_illegal_req),
 	FBNIC_HW_STAT("ptp_good_ts", tmi.ptp_good_ts),
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 80157f389975..4223d8100e64 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -101,6 +101,69 @@ static void fbnic_get_tmi_stats(struct fbnic_dev *fbd,
 	fbnic_hw_stat_rd64(fbd, FBNIC_TMI_DROP_BYTE_L, 1, &tmi->drop.bytes);
 }
 
+static void fbnic_reset_tti_stats(struct fbnic_dev *fbd,
+				  struct fbnic_tti_stats *tti)
+{
+	fbnic_hw_stat_rst32(fbd,
+			    FBNIC_TCE_TTI_CM_DROP_PKTS,
+			    &tti->cm_drop.frames);
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_TCE_TTI_CM_DROP_BYTE_L,
+			    1,
+			    &tti->cm_drop.bytes);
+
+	fbnic_hw_stat_rst32(fbd,
+			    FBNIC_TCE_TTI_FRAME_DROP_PKTS,
+			    &tti->frame_drop.frames);
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_TCE_TTI_FRAME_DROP_BYTE_L,
+			    1,
+			    &tti->frame_drop.bytes);
+
+	fbnic_hw_stat_rst32(fbd,
+			    FBNIC_TCE_TBI_DROP_PKTS,
+			    &tti->tbi_drop.frames);
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_TCE_TBI_DROP_BYTE_L,
+			    1,
+			    &tti->tbi_drop.bytes);
+}
+
+static void fbnic_get_tti_stats32(struct fbnic_dev *fbd,
+				  struct fbnic_tti_stats *tti)
+{
+	fbnic_hw_stat_rd32(fbd,
+			   FBNIC_TCE_TTI_CM_DROP_PKTS,
+			   &tti->cm_drop.frames);
+
+	fbnic_hw_stat_rd32(fbd,
+			   FBNIC_TCE_TTI_FRAME_DROP_PKTS,
+			   &tti->frame_drop.frames);
+
+	fbnic_hw_stat_rd32(fbd,
+			   FBNIC_TCE_TBI_DROP_PKTS,
+			   &tti->tbi_drop.frames);
+}
+
+static void fbnic_get_tti_stats(struct fbnic_dev *fbd,
+				struct fbnic_tti_stats *tti)
+{
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_TCE_TTI_CM_DROP_BYTE_L,
+			   1,
+			   &tti->cm_drop.bytes);
+
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_TCE_TTI_FRAME_DROP_BYTE_L,
+			   1,
+			   &tti->frame_drop.bytes);
+
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_TCE_TBI_DROP_BYTE_L,
+			   1,
+			   &tti->tbi_drop.bytes);
+}
+
 static void fbnic_reset_rpc_stats(struct fbnic_dev *fbd,
 				  struct fbnic_rpc_stats *rpc)
 {
@@ -451,6 +514,7 @@ void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 {
 	spin_lock(&fbd->hw_stats_lock);
 	fbnic_reset_tmi_stats(fbd, &fbd->hw_stats.tmi);
+	fbnic_reset_tti_stats(fbd, &fbd->hw_stats.tti);
 	fbnic_reset_rpc_stats(fbd, &fbd->hw_stats.rpc);
 	fbnic_reset_rxb_stats(fbd, &fbd->hw_stats.rxb);
 	fbnic_reset_hw_rxq_stats(fbd, fbd->hw_stats.hw_q);
@@ -461,6 +525,7 @@ void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 static void __fbnic_get_hw_stats32(struct fbnic_dev *fbd)
 {
 	fbnic_get_tmi_stats32(fbd, &fbd->hw_stats.tmi);
+	fbnic_get_tti_stats32(fbd, &fbd->hw_stats.tti);
 	fbnic_get_rpc_stats32(fbd, &fbd->hw_stats.rpc);
 	fbnic_get_rxb_stats32(fbd, &fbd->hw_stats.rxb);
 	fbnic_get_hw_rxq_stats32(fbd, fbd->hw_stats.hw_q);
@@ -479,6 +544,7 @@ void fbnic_get_hw_stats(struct fbnic_dev *fbd)
 	__fbnic_get_hw_stats32(fbd);
 
 	fbnic_get_tmi_stats(fbd, &fbd->hw_stats.tmi);
+	fbnic_get_tti_stats(fbd, &fbd->hw_stats.tti);
 	fbnic_get_rxb_stats(fbd, &fbd->hw_stats.rxb);
 	fbnic_get_pcie_stats_asic64(fbd, &fbd->hw_stats.pcie);
 	spin_unlock(&fbd->hw_stats_lock);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index abb0957a5ac0..07e54bb75bf3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -47,6 +47,10 @@ struct fbnic_tmi_stats {
 	struct fbnic_stat_counter ptp_illegal_req, ptp_good_ts, ptp_bad_ts;
 };
 
+struct fbnic_tti_stats {
+	struct fbnic_hw_stat cm_drop, frame_drop, tbi_drop;
+};
+
 struct fbnic_rpc_stats {
 	struct fbnic_stat_counter unkn_etype, unkn_ext_hdr;
 	struct fbnic_stat_counter ipv4_frag, ipv6_frag, ipv4_esp, ipv6_esp;
@@ -94,6 +98,7 @@ struct fbnic_pcie_stats {
 struct fbnic_hw_stats {
 	struct fbnic_mac_stats mac;
 	struct fbnic_tmi_stats tmi;
+	struct fbnic_tti_stats tti;
 	struct fbnic_rpc_stats rpc;
 	struct fbnic_rxb_stats rxb;
 	struct fbnic_hw_q_stats hw_q[FBNIC_MAX_QUEUES];
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 6802799b0f63..cebdfbead438 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -424,7 +424,10 @@ static void fbnic_get_stats64(struct net_device *dev,
 	stats64->tx_dropped = tx_dropped;
 
 	/* Record drops from Tx HW Datapath */
-	tx_dropped += fbd->hw_stats.tmi.drop.frames.value;
+	tx_dropped += fbd->hw_stats.tmi.drop.frames.value +
+		      fbd->hw_stats.tti.frame_drop.frames.value +
+		      fbd->hw_stats.tti.tbi_drop.frames.value +
+		      fbd->hw_stats.tmi.drop.frames.value;
 
 	for (i = 0; i < fbn->num_tx_queues; i++) {
 		struct fbnic_ring *txr = fbn->tx[i];
-- 
2.47.1


