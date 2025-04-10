Return-Path: <netdev+bounces-181089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2AFA83A74
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191D38C5968
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6011A204C19;
	Thu, 10 Apr 2025 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juR//tfu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B61DFDE
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268986; cv=none; b=iZJj0G1tdenp+dEioRoGPj1IVWrSHP3si3e8PiW1LDucxH//b0LV25y9BhiRQtCJL7xlx8QnnxwkA+v/sEcvpap0YGA0oOqal7TOb7liZpKuNBoBkRf+jGe0MbKh+JyHLxbLCnfh1cXfV2In7cHZLmvVtZ3OLt/Z46CubKKqQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268986; c=relaxed/simple;
	bh=zumvnT4RkTGQuq5rPHV8umYXVTGpW/B+zSu8kqD+hl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpoxVVSWN0tJg4TGlioTkrM9IZOvALmm0OEL7pI017Pi7LZquvhnM33ETlPIs/rA9B2PRZFCYUXbbXnsLQ8nBfLaNvcbCnF5R3bjpK+5TPpCHH+f6rTCnoysjaQL7d/PHdxdpzaeluMMVn+4j4raxlMD0rS6Jv2FwvVr5Z7zuQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juR//tfu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39d83782ef6so978237f8f.0
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268981; x=1744873781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koDuUtZSzdwmAZeQ+8NiUzPArIkaBe59rnqzlp7f0Qo=;
        b=juR//tfuJbZ6zUKkGE2ISRVqvok5ZYb8RnVeXprS4z6OtHWiUdToHfVByJXooTaCEd
         ORGvQohagvcrZE99Jk62CSffQGai1N/RZDTTfqVVB2qpARsGiE4IWh/rUUDmbJn3QpN9
         cFWYE6HBCFLl5Fk2kwrr4l7XOZPACDxkeJlkRDnK8I0zOXd8a4ENEFuGWEt+FtoyI38l
         +Z2JWBnosMU0a2TvkEghtFGHi3XX3W0LKwkHB+7OYrUc1HT/C1IKav1ULfuVhczEz2aI
         agj/PQTwBsWsjJNDTej2YQFJLnzN4V5DlMc7zUyoa/245iXMYJcDQJvwaajIvy6acsOi
         DYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268981; x=1744873781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koDuUtZSzdwmAZeQ+8NiUzPArIkaBe59rnqzlp7f0Qo=;
        b=MjySGLfscBnYMClpZVVtuKCoEu+4xjsLhreK2alloaQEDM7KpVAqpV1dylyUz0yAJ7
         eGq/GDnaFDiBcj25+0R4VSXpOvf0AozsaF53GYFJLA87wm79Dl6gx3Kk0SrpSl5OityA
         BlIWhaj9YbP0bjsnQE3BJbM55rgHSZ0TVv28tAN+2FpXoEAREHMptFU09P2IYXBU3x/t
         jpkHTbHgjUin1cZEQbeGjso3mxa7rVeC9WyG8wnr8Wd0Pw3lGxTxOUup8IC5AKoiG3hb
         Iqe1PeWWYs0eXOJcLcTzYMdPzfsQUIiCogawQxLRrUtfZQ6sdEDunu+DiXIh+SZmdmCZ
         gUiw==
X-Gm-Message-State: AOJu0YyU8MRTJSbDC1gvi6XC5GtQhOcUinFQbjMjfSU6Hkc8F+o9APFI
	5tP0JG0uEjvanhRz0b8l//lt86WmOVetKlULZjOIzhiPNr5LK6SOkvD5hbMn
X-Gm-Gg: ASbGncvwmSejwv6GHpqnbD5K2yYNKqye6stwYRpFcguwbH5u7vLYcnzOJCE/PDRw9WK
	vWC1aZLLAYsiID4IQ3k/1eEoL2TXZARrDQSwapzOrOKpdLiqe8MoCwvdf7PTHV8YNpo3ncvoDeV
	eXB0gLG8LqhBTBXxMeTUutfUYHI6boGABdwHG+wP9letp6gCUlfZh3dcqKgngdJuj/s7VQ8XcNz
	gVezyu8/3nUne8AYvcZ15khPYUZDISF/KJvhH0b77Yo8q71VkAp5Kqa0oUDUUawlYkx9N3V1sI6
	ek0KzES5rzBt2TTOjRqDp6lsUSkjxgUqpSu4CJM=
X-Google-Smtp-Source: AGHT+IFWoYcqrL+wudr/QKCdgY1favnxe2+wsJVT6ImPOw1UIZ942lCVFnASeC8GrxzmsHTAWzzwEA==
X-Received: by 2002:a05:6000:188f:b0:391:3207:2e68 with SMTP id ffacd0b85a97d-39d8f27628cmr1067209f8f.9.1744268980918;
        Thu, 10 Apr 2025 00:09:40 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893fc88dsm3814042f8f.81.2025.04.10.00.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:09:40 -0700 (PDT)
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
Subject: [PATCH net-next 5/5 V2] eth: fbnic: add support for TTI HW stats
Date: Thu, 10 Apr 2025 00:08:59 -0700
Message-ID: <20250410070859.4160768-6-mohsin.bashr@gmail.com>
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

Add coverage for the TX Extension (TEI) Interface (TTI) stats. We are
tracking packets and control message drops because of credit exhaustion
on the TX interface.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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
index 7d421791033e..5c7556c8c4c5 100644
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
index a0f93bd27113..d699f58dda21 100644
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


