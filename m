Return-Path: <netdev+bounces-181088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAB2A83A72
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C6E8C52F9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A90204C14;
	Thu, 10 Apr 2025 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPow/a5P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6643204C3C
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268983; cv=none; b=jAl1W9Ut0Olk73olF9yVugssOrOhcwf5iD78BzhyHWeWvWpprwaerUzpXcy7fjRP2FbEir+7mQNhvUoxiWWyxIgamNIQNa6jeaMPthr9IdkGUHdiBYW+fsRQtlyQvrS/YWRW76Xe5XNno+IfJUwpf8JJPcAJLrG8uVhzKdF36/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268983; c=relaxed/simple;
	bh=8vzmveTwXWZn4nZaYw5YL6CNieBIdBrZO1rG66Nexe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlGS+c3a1qEaLS7kHV4GK3TazAPvLBpYnuLbII8dfe0cyHrfOGerELZqO0UR/0wQ4QMA1KQDtLIc5184fd9Oz/XAcx8JEd2zxKIZwdXrFkwdv3CwYn8sKw4Q9l8qONvat3f9iQgU90lQo5MgF0xPAw7uLdSGvvuT2f8rqx6/QPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPow/a5P; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so5356525e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 00:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268979; x=1744873779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+FdyvwWte9fQ+zlYmpZxgQpsgup+t9GWDZcE3v6yyA=;
        b=CPow/a5PJzAr4yoA6PaRy0V59Sj9M/ABJ/4AXgIURSXvC46CSTCCUVozOLYuskmtpj
         XBmyeMwLcbWb8+0M0mzCbupOl7SlvG9i9AAVchZNsYFmORMm1PUA5aKmMT7YcVvbeFIs
         t0X/eL/Sem0L9EIkzPGYxNVd9UxnrUSI4wIXlHIjW4JAx/zNCKPpyQHVL9QFN5PUdRx5
         e4okiqFBvCerhNzGWwH209RjWzK2Bj/IE+0/gK5PHbG87cn/Xm7dQBPRSp+YISXCo5zK
         mX+ZeKCOAcG5WzORamub6X4Q5WMj1qxDV8GQOMN0+TrxgVWuixAAtyqFWpOqq42dCeb7
         kEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268979; x=1744873779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+FdyvwWte9fQ+zlYmpZxgQpsgup+t9GWDZcE3v6yyA=;
        b=XbyrMnEIt/xnt4KIFuaCLmBHcIzU/LHVXmJDxW2MCUmfZit6fTlzJ2S5Or7XybubsJ
         yT33SnGhybyPg1E4KXG5l5RdVTDU0LNW037C54So1L7cdISrdNLTYGlyvnWY7V5Adobk
         D++tTV/+VMn0buurC55hrg1a2cB05Fx2mOgiQfSlWETBdBiG81obKG7osr4kWemoTUMm
         AuTIbsl5ulC1X6lu1r83I+OPZKyS1f1zjQXsSebGnTB8YhhrosHdWH6yj87f5UcZgA4O
         XltFy/PtoQy+Grgrd9ZTrVnvraEqj3YH1FS1kbCc+75y3Q1wMIhvzGq6kGpeMWzE4D66
         toIw==
X-Gm-Message-State: AOJu0YyOCqqPuwQkMhDYXx/ZmGV3EO1neQTPzTOyK8SN2huI5uymdQFF
	mCMODvd/HTtaQxDdlEvjS9npRpZkIVgUmxcMT8vnlgnzh0nMVbJBu5AlHXRo
X-Gm-Gg: ASbGncuTgSo8VEjRWOekUsMJoUjaXjmRHTlr7dOglL3Vdxxh6CCXafuhbHlA+te8ven
	a3Qj4O6bjiKC8CBtKrV3fqdc/dsXOkZp7pBUpwQVyhfHtqHKqYGxVDFJbqd/umn8axnTKkkvDy5
	Wn2Tj4jCM2gsp6N3UGU1CSndVctIH82sUetMkCCZkuitYSudEna/WeZg8a9b3ZVnZxCF2/0ipZx
	MvKFXmS9u2Ocm4pwbDOvOztQmtk8KMkl9BGY1m0OBUR5Pr3LnvzXW/tppXj5k1uPQjDEp7ZDrll
	8Q0VFOIDREzP/zt3uU0C8W2hfVY/bd56ITQ=
X-Google-Smtp-Source: AGHT+IHIcbe00HafuxTiVPPwEiqqMpejOZYmCvn5ftTXFvSQzYxJh7cq6AFUwTa5+M2dd4+RxX1Tsw==
X-Received: by 2002:a05:600c:a08d:b0:43c:f513:9585 with SMTP id 5b1f17b1804b1-43f2fedc717mr11162305e9.13.1744268978590;
        Thu, 10 Apr 2025 00:09:38 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5ec3sm41314255e9.39.2025.04.10.00.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:09:37 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jdamato@fastly.com,
	kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	sanman.p211993@gmail.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next 4/5 V2] eth: fbnic: add support for TMI stats
Date: Thu, 10 Apr 2025 00:08:58 -0700
Message-ID: <20250410070859.4160768-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250410070859.4160768-1-mohsin.bashr@gmail.com>
References: <20250410070859.4160768-1-mohsin.bashr@gmail.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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
index 816af96a5d5f..7d421791033e 100644
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
index dff485511301..a0f93bd27113 100644
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


