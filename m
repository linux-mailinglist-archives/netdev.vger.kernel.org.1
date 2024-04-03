Return-Path: <netdev+bounces-84607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5EE89799D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8F81F270B6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569CB15574B;
	Wed,  3 Apr 2024 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es9+sJvh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F484155736
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174957; cv=none; b=aFAz3VojDPk+C9tJi7mXUSULPRNCPFDtqRNCJPhugOAgbBFqLzxSLYc8214w+/W3MKwc/EHLPXrDgmTkXlYXBp55nA3TU6WXy4IGH72iMxByeVgtFV9kFXSPz1unWGpEz8diTs1Gc9Ca64J8yRhMECH7gNYfu+ThKrzPN857RxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174957; c=relaxed/simple;
	bh=2yEbbdRjAfyLv6AbyoYgtGGTERBEMWLq6ZGKcDDajD0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpyRV/uFPZX7u9aAMoog93VyVj6OVd1wI3lIcdaacN9sNKrnF+yXFRWbKRFuOe0fFGfyg+8h1CmEAdZtXPUm/khloNr5VUyebAG1t9mer2IyzaQ3xECBBsk4rfTOT5Cpt7mCZJn/b0F0xxyWap4QbBv2f6cptCYgLVVBEM73GI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es9+sJvh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so193696b3a.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174954; x=1712779754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=elSOqNAygeLugyGUtm84X7lmma0y5sNgZID7faN/js0=;
        b=Es9+sJvhjuypnu+3z7QCfoqP0+RH4s/d04aHracrch2o7GTwFUczmOYGQvUQ1OD8NN
         Ez/HRp5A/xtqNdFGcNl0V4SAmiDCanpHbqLJ2ifM2rfgY1X6mCXYVNVPlTFyewFxl4Pk
         xR2UZtDmdQryxICjbI2EC2WgmTRIbi1bR1sqkh0x5OVBXcXeJjD3euWmyhi3YoTxd5N6
         54rr+XZGT0dBLr/dmKaTRBZCZiEY6A6spi5wIxZC5bPDWiueowtGRbLtVT7NmUJUtIL5
         bIRBTVLzOAnQbQJddxKWZzS882Nu184b8mNCl/1WeRZ+hoe//Ljrc7lC2Diy2zmpYawJ
         viUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174954; x=1712779754;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elSOqNAygeLugyGUtm84X7lmma0y5sNgZID7faN/js0=;
        b=OL86+rovQxJxTaJ31OfMX5mi35zokNpiR9KLGWHTNh51xCKXgeJE6K31JOKSdj6d+O
         rIVY9n4NIFz+1gJ/zZXGT6NtJ10w96RgniVxnXJAVQvmKlw4cOwTY4wnIC84JVnYfTLt
         mMSQEfnQ1yydilRw1AaguBDZYBxUQERrIPZ95ZbvJzxDf9iQH73TF3qJ6nmGjK1jp+L6
         OiWCYCaPUigGSIfRXY0PKcrHr54S9h881oZMzhl11+2EgQJWrrX4RhRMoQMrOCRqZHwu
         GA6nT6YmBtpuUBU5qxu1Sn+9kpt2Cpl+8+USeNkiTbrDFBXTJ4U6oR72eVx+GZioQxNa
         jnjA==
X-Gm-Message-State: AOJu0YyPaXOBsOfcxLMkyWiG3niAT/d0r5F/6jUcr5UrMNnXPcooEL1W
	Rv8FEAMVM8BOVNJyRDjb/WmFt02QTWncivTMytnxnLGz8Hl7/Ssi
X-Google-Smtp-Source: AGHT+IHHT7jtoIo7mjvRfMdSfmXaj0upPN39lyrpOm5zpz8/jlMbcffkeKCt886N3+dI6wcDdwDy6A==
X-Received: by 2002:a05:6a21:2b14:b0:1a3:e0b5:418 with SMTP id ss20-20020a056a212b1400b001a3e0b50418mr616381pzb.36.1712174953369;
        Wed, 03 Apr 2024 13:09:13 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id y44-20020a056a0003ac00b006eadc87233dsm11864302pfs.165.2024.04.03.13.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:09:12 -0700 (PDT)
Subject: [net-next PATCH 11/15] eth: fbnic: Enable Ethernet link setup
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Wed, 03 Apr 2024 13:09:11 -0700
Message-ID: 
 <171217495098.1598374.12824051034972793514.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Add the logic needed to enable the Ethernet link to be configured and the
link to be detected. We have to partially rely on the FW for this as there
are parts of the MAC configuration that are shared between multiple ports
so we ask the firmware to complete those pieces on our behalf.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h        |   18 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h    |  143 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c     |   60 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h     |   22 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c    |  118 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c    |  587 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h    |   58 ++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |   12 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h |    7 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |   73 +++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   |   21 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h   |    1 
 12 files changed, 1119 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 4f18d703dae8..202f005e1cfd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -20,6 +20,7 @@ struct fbnic_dev {
 	const struct fbnic_mac *mac;
 	struct msix_entry *msix_entries;
 	unsigned int fw_msix_vector;
+	unsigned int mac_msix_vector;
 	unsigned short num_irqs;
 
 	struct delayed_work service_task;
@@ -37,6 +38,13 @@ struct fbnic_dev {
 	u32 mps;
 	u32 readrq;
 
+	/* Tri-state value indicating state of link.
+	 *  0 - Up
+	 *  1 - Down
+	 *  2 - Event - Requires checking as link state may have changed
+	 */
+	s8 link_state;
+
 	/* Number of TCQs/RCQs available on hardware */
 	u16 max_num_queues;
 };
@@ -48,6 +56,7 @@ struct fbnic_dev {
  */
 enum {
 	FBNIC_FW_MSIX_ENTRY,
+	FBNIC_MAC_MSIX_ENTRY,
 	FBNIC_NON_NAPI_VECTORS
 };
 
@@ -89,6 +98,11 @@ void fbnic_fw_wr32(struct fbnic_dev *fbd, u32 reg, u32 val);
 #define fw_wr32(reg, val)	fbnic_fw_wr32(fbd, reg, val)
 #define fw_wrfl()		fbnic_fw_rd32(fbd, FBNIC_FW_ZERO_REG)
 
+static inline bool fbnic_bmc_present(struct fbnic_dev *fbd)
+{
+	return fbd->fw_cap.bmc_present;
+}
+
 static inline bool fbnic_init_failure(struct fbnic_dev *fbd)
 {
 	return !fbd->netdev;
@@ -104,6 +118,10 @@ void fbnic_devlink_unregister(struct fbnic_dev *fbd);
 int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
 void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);
 
+int fbnic_mac_get_link(struct fbnic_dev *fbd, bool *link);
+int fbnic_mac_enable(struct fbnic_dev *fbd);
+void fbnic_mac_disable(struct fbnic_dev *fbd);
+
 void fbnic_free_irqs(struct fbnic_dev *fbd);
 int fbnic_alloc_irqs(struct fbnic_dev *fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 8b035c4e068e..39c98d2dce12 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -58,6 +58,10 @@
 #define FBNIC_INTR_MSIX_CTRL(n)		(0x00040 + (n)) /* 0x00100 + 4*n */
 #define FBNIC_INTR_MSIX_CTRL_VECTOR_MASK	CSR_GENMASK(7, 0)
 #define FBNIC_INTR_MSIX_CTRL_ENABLE		CSR_BIT(31)
+enum {
+	FBNIC_INTR_MSIX_CTRL_MAC_IDX	= 6,
+	FBNIC_INTR_MSIX_CTRL_PCS_IDX	= 34,
+};
 
 #define FBNIC_CSR_END_INTR		0x0005f	/* CSR section delimiter */
 
@@ -392,6 +396,145 @@ enum {
 #define FBNIC_MASTER_SPARE_0		0x0C41B		/* 0x3106c */
 #define FBNIC_CSR_END_MASTER		0x0C41E	/* CSR section delimiter */
 
+/* MAC PCS registers */
+#define FBNIC_CSR_START_PCS		0x10000 /* CSR section delimiter */
+#define FBNIC_PCS_CONTROL1_0		0x10000		/* 0x40000 */
+#define FBNIC_PCS_CONTROL1_RESET		CSR_BIT(15)
+#define FBNIC_PCS_CONTROL1_LOOPBACK		CSR_BIT(14)
+#define FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS	CSR_BIT(13)
+#define FBNIC_PCS_CONTROL1_SPEED_ALWAYS		CSR_BIT(6)
+#define FBNIC_PCS_VENDOR_VL_INTVL_0	0x10202		/* 0x40808 */
+#define FBNIC_PCS_VL0_0_CHAN_0		0x10208		/* 0x40820 */
+#define FBNIC_PCS_VL0_1_CHAN_0		0x10209		/* 0x40824 */
+#define FBNIC_PCS_VL1_0_CHAN_0		0x1020a		/* 0x40828 */
+#define FBNIC_PCS_VL1_1_CHAN_0		0x1020b		/* 0x4082c */
+#define FBNIC_PCS_VL2_0_CHAN_0		0x1020c		/* 0x40830 */
+#define FBNIC_PCS_VL2_1_CHAN_0		0x1020d		/* 0x40834 */
+#define FBNIC_PCS_VL3_0_CHAN_0		0x1020e		/* 0x40838 */
+#define FBNIC_PCS_VL3_1_CHAN_0		0x1020f		/* 0x4083c */
+#define FBNIC_PCS_MODE_VL_CHAN_0	0x10210		/* 0x40840 */
+#define FBNIC_PCS_MODE_HI_BER25			CSR_BIT(2)
+#define FBNIC_PCS_MODE_DISABLE_MLD		CSR_BIT(1)
+#define FBNIC_PCS_MODE_ENA_CLAUSE49		CSR_BIT(0)
+#define FBNIC_PCS_CONTROL1_1		0x10400		/* 0x41000 */
+#define FBNIC_PCS_VENDOR_VL_INTVL_1	0x10602		/* 0x41808 */
+#define FBNIC_PCS_VL0_0_CHAN_1		0x10608		/* 0x41820 */
+#define FBNIC_PCS_VL0_1_CHAN_1		0x10609		/* 0x41824 */
+#define FBNIC_PCS_VL1_0_CHAN_1		0x1060a		/* 0x41828 */
+#define FBNIC_PCS_VL1_1_CHAN_1		0x1060b		/* 0x4182c */
+#define FBNIC_PCS_VL2_0_CHAN_1		0x1060c		/* 0x41830 */
+#define FBNIC_PCS_VL2_1_CHAN_1		0x1060d		/* 0x41834 */
+#define FBNIC_PCS_VL3_0_CHAN_1		0x1060e		/* 0x41838 */
+#define FBNIC_PCS_VL3_1_CHAN_1		0x1060f		/* 0x4183c */
+#define FBNIC_PCS_MODE_VL_CHAN_1	0x10610		/* 0x41840 */
+#define FBNIC_CSR_END_PCS		0x10668 /* CSR section delimiter */
+
+#define FBNIC_CSR_START_RSFEC		0x10800 /* CSR section delimiter */
+#define FBNIC_RSFEC_CONTROL(n)\
+				(0x10800 + 8 * (n))	/* 0x42000 + 32*n */
+#define FBNIC_RSFEC_CONTROL_AM16_COPY_DIS	CSR_BIT(3)
+#define FBNIC_RSFEC_CONTROL_KP_ENABLE		CSR_BIT(8)
+#define FBNIC_RSFEC_CONTROL_TC_PAD_ALTER	CSR_BIT(10)
+#define FBNIC_RSFEC_MAX_LANES			4
+#define FBNIC_RSFEC_CCW_LO(n) \
+				(0x10802 + 8 * (n))	/* 0x42008 + 32*n */
+#define FBNIC_RSFEC_CCW_HI(n) \
+				(0x10803 + 8 * (n))	/* 0x4200c + 32*n */
+#define FBNIC_RSFEC_NCCW_LO(n) \
+				(0x10804 + 8 * (n))	/* 0x42010 + 32*n */
+#define FBNIC_RSFEC_NCCW_HI(n) \
+				(0x10805 + 8 * (n))	/* 0x42014 + 32*n */
+#define FBNIC_RSFEC_SYMBLERR_LO(n) \
+				(0x10880 + 8 * (n))	/* 0x42200 + 32*n */
+#define FBNIC_RSFEC_SYMBLERR_HI(n) \
+				(0x10881 + 8 * (n))	/* 0x42204 + 32*n */
+#define FBNIC_CSR_END_RSFEC		0x108c8 /* CSR section delimiter */
+
+/* MAC MAC registers */
+#define FBNIC_CSR_START_MAC_MAC		0x11000 /* CSR section delimiter */
+#define FBNIC_MAC_COMMAND_CONFIG	0x11002		/* 0x44008 */
+#define FBNIC_MAC_COMMAND_CONFIG_RX_PAUSE_DIS	CSR_BIT(29)
+#define FBNIC_MAC_COMMAND_CONFIG_TX_PAUSE_DIS	CSR_BIT(28)
+#define FBNIC_MAC_COMMAND_CONFIG_FLT_HDL_DIS	CSR_BIT(27)
+#define FBNIC_MAC_COMMAND_CONFIG_TX_PAD_EN	CSR_BIT(11)
+#define FBNIC_MAC_COMMAND_CONFIG_LOOPBACK_EN	CSR_BIT(10)
+#define FBNIC_MAC_COMMAND_CONFIG_PROMISC_EN	CSR_BIT(4)
+#define FBNIC_MAC_COMMAND_CONFIG_RX_ENA		CSR_BIT(1)
+#define FBNIC_MAC_COMMAND_CONFIG_TX_ENA		CSR_BIT(0)
+#define FBNIC_MAC_FRM_LENGTH		0x11005		/* 0x44014 */
+#define FBNIC_MAC_TX_IPG_LENGTH		0x11011		/* 0x44044 */
+#define FBNIC_MAC_TX_IPG_LENGTH_COMP		CSR_GENMASK(31, 16)
+#define FBNIC_MAC_TX_IPG_LENGTH_TXIPG		CSR_GENMASK(5, 3)
+#define FBNIC_MAC_CL01_PAUSE_QUANTA	0x11015		/* 0x44054 */
+#define FBNIC_MAC_CL01_QUANTA_THRESH	0x11019		/* 0x44064 */
+#define FBNIC_MAC_XIF_MODE		0x11020		/* 0x44080 */
+#define FBNIC_MAC_XIF_MODE_TX_MAC_RS_ERR	CSR_BIT(8)
+#define FBNIC_MAC_XIF_MODE_XGMII		CSR_BIT(0)
+#define FBNIC_CSR_END_MAC_MAC		0x11028 /* CSR section delimiter */
+
+/* MAC CSR registers */
+#define FBNIC_CSR_START_MAC_CSR		0x11800 /* CSR section delimiter */
+#define FBNIC_MAC_CTRL			0x11800		/* 0x46000 */
+#define FBNIC_MAC_CTRL_RESET_FF_TX_CLK		CSR_BIT(14)
+#define FBNIC_MAC_CTRL_RESET_FF_RX_CLK		CSR_BIT(13)
+#define FBNIC_MAC_CTRL_RESET_TX_CLK		CSR_BIT(12)
+#define FBNIC_MAC_CTRL_RESET_RX_CLK		CSR_BIT(11)
+#define FBNIC_MAC_CTRL_TX_CRC			CSR_BIT(8)
+#define FBNIC_MAC_CTRL_CFG_MODE128		CSR_BIT(10)
+#define FBNIC_MAC_SERDES_CTRL		0x11807		/* 0x4601c */
+#define FBNIC_MAC_SERDES_CTRL_RESET_PCS_REF_CLK	CSR_BIT(26)
+#define FBNIC_MAC_SERDES_CTRL_RESET_F91_REF_CLK	CSR_BIT(25)
+#define FBNIC_MAC_SERDES_CTRL_RESET_SD_TX_CLK	CSR_GENMASK(24, 23)
+#define FBNIC_MAC_SERDES_CTRL_RESET_SD_RX_CLK	CSR_GENMASK(22, 21)
+#define FBNIC_MAC_SERDES_CTRL_SD_8X             CSR_GENMASK(18, 17)
+#define FBNIC_MAC_SERDES_CTRL_F91_1LANE_IN0	CSR_BIT(9)
+#define FBNIC_MAC_SERDES_CTRL_RXLAUI_ENA_IN0	CSR_BIT(7)
+#define FBNIC_MAC_SERDES_CTRL_PCS100_ENA_IN0    CSR_BIT(6)
+#define FBNIC_MAC_SERDES_CTRL_PACER_10G_MASK	CSR_GENMASK(1, 0)
+#define FBNIC_MAC_PCS_STS0		0x11808		/* 0x46020 */
+#define FBNIC_MAC_PCS_STS0_LINK			CSR_BIT(27)
+#define FBNIC_MAC_PCS_STS0_BLOCK_LOCK		CSR_GENMASK(24, 5)
+#define FBNIC_MAC_PCS_STS0_AMPS_LOCK		CSR_GENMASK(4, 1)
+#define FBNIC_MAC_PCS_STS1		0x11809		/* 0x46024 */
+#define FBNIC_MAC_PCS_STS1_FCFEC_LOCK		CSR_GENMASK(11, 8)
+#define FBNIC_MAC_PCS_INTR_STS		0x11814		/* 0x46050 */
+#define FBNIC_MAC_PCS_INTR_LINK_DOWN		CSR_BIT(1)
+#define FBNIC_MAC_PCS_INTR_LINK_UP		CSR_BIT(0)
+#define FBNIC_MAC_PCS_INTR_MASK		0x11816		/* 0x46058 */
+#define FBNIC_MAC_ENET_LED		0x11820		/* 0x46080 */
+#define FBNIC_MAC_ENET_LED_OVERRIDE_EN		CSR_GENMASK(2, 0)
+#define FBNIC_MAC_ENET_LED_OVERRIDE_VAL		CSR_GENMASK(6, 4)
+enum {
+	FBNIC_MAC_ENET_LED_OVERRIDE_ACTIVITY	= 0x1,
+	FBNIC_MAC_ENET_LED_OVERRIDE_AMBER	= 0x2,
+	FBNIC_MAC_ENET_LED_OVERRIDE_BLUE	= 0x4,
+};
+
+#define FBNIC_MAC_ENET_LED_BLINK_RATE_MASK	CSR_GENMASK(11, 8)
+enum {
+	FBNIC_MAC_ENET_LED_BLINK_RATE_5HZ	= 0xf,
+};
+
+#define FBNIC_MAC_ENET_LED_BLUE_MASK		CSR_GENMASK(18, 16)
+enum {
+	FBNIC_MAC_ENET_LED_BLUE_50G		= 0x2,
+	FBNIC_MAC_ENET_LED_BLUE_100G		= 0x4,
+};
+
+#define FBNIC_MAC_ENET_LED_AMBER_MASK		CSR_GENMASK(21, 20)
+enum {
+	FBNIC_MAC_ENET_LED_AMBER_25G		= 0x1,
+	FBNIC_MAC_ENET_LED_AMBER_50G		= 0x2,
+};
+
+#define FBNIC_MAC_ENET_SIG_DETECT	0x11824		/* 0x46090 */
+#define FBNIC_MAC_ENET_SIG_DETECT_PCS_MASK	CSR_GENMASK(1, 0)
+#define FBNIC_MAC_ENET_FEC_CTRL		0x11825		/* 0x46094 */
+#define FBNIC_MAC_ENET_FEC_CTRL_FEC_ENA		CSR_GENMASK(27, 24)
+#define FBNIC_MAC_ENET_FEC_CTRL_KP_MODE_ENA	CSR_GENMASK(11, 8)
+#define FBNIC_MAC_ENET_FEC_CTRL_F91_ENA		CSR_GENMASK(3, 0)
+#define FBNIC_CSR_END_MAC_CSR		0x1184e /* CSR section delimiter */
+
 /* PUL User Registers */
 #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 4c3098364fed..af38d5934bbf 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -643,6 +643,63 @@ void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd)
 		dev_warn(fbd->dev, "Failed to send heartbeat message\n");
 }
 
+/**
+ * fbnic_fw_xmit_comphy_set_msg - Create and transmit a comphy set request
+ *
+ * @fbd: FBNIC device structure
+ * @speed: Indicates link speed, composed of modulation and number of lanes
+ *
+ * Returns 0 on success, negative value on failure
+ *
+ * Asks the firmware to reconfigure the comphy for this slice to the target
+ * speed.
+ */
+int fbnic_fw_xmit_comphy_set_msg(struct fbnic_dev *fbd, u32 speed)
+{
+	struct fbnic_tlv_msg *msg;
+	int err = 0;
+
+	if (!fbnic_fw_present(fbd))
+		return -ENODEV;
+
+	msg = fbnic_tlv_msg_alloc(FBNIC_TLV_MSG_ID_COMPHY_SET_REQ);
+	if (!msg)
+		return -ENOMEM;
+
+	err = fbnic_tlv_attr_put_int(msg, FBNIC_COMPHY_SET_PAM4,
+				     !!(speed & FBNIC_LINK_MODE_PAM4));
+	if (err)
+		goto free_message;
+
+	err = fbnic_mbx_map_tlv_msg(fbd, msg);
+	if (err)
+		goto free_message;
+
+	return 0;
+
+free_message:
+	free_page((unsigned long)msg);
+	return err;
+}
+
+static const struct fbnic_tlv_index fbnic_comphy_set_resp_index[] = {
+	FBNIC_TLV_ATTR_S32(FBNIC_COMPHY_SET_ERROR),
+	FBNIC_TLV_ATTR_LAST
+};
+
+static int fbnic_fw_parse_comphy_set_resp(void *opaque,
+					  struct fbnic_tlv_msg **results)
+{
+	struct fbnic_dev *fbd = (struct fbnic_dev *)opaque;
+	int err_resp = 0;
+
+	get_signed_result(FBNIC_COMPHY_SET_ERROR, err_resp);
+	if (err_resp)
+		dev_err(fbd->dev, "COMPHY_SET returned %d\n", err_resp);
+
+	return 0;
+}
+
 static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 	FBNIC_TLV_PARSER(FW_CAP_RESP, fbnic_fw_cap_resp_index,
 			 fbnic_fw_parse_cap_resp),
@@ -650,6 +707,9 @@ static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
 			 fbnic_fw_parse_ownership_resp),
 	FBNIC_TLV_PARSER(HEARTBEAT_RESP, fbnic_heartbeat_resp_index,
 			 fbnic_fw_parse_heartbeat_resp),
+	FBNIC_TLV_PARSER(COMPHY_SET_RESP,
+			 fbnic_comphy_set_resp_index,
+			 fbnic_fw_parse_comphy_set_resp),
 	FBNIC_TLV_MSG_ERROR
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 40d314f963ea..ea4802537d31 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -52,6 +52,7 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
 int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
 int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
 void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
+int fbnic_fw_xmit_comphy_set_msg(struct fbnic_dev *fbd, u32 speed);
 
 #define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str)	\
 do {									\
@@ -76,6 +77,8 @@ enum {
 	FBNIC_TLV_MSG_ID_OWNERSHIP_RESP			= 0x13,
 	FBNIC_TLV_MSG_ID_HEARTBEAT_REQ			= 0x14,
 	FBNIC_TLV_MSG_ID_HEARTBEAT_RESP			= 0x15,
+	FBNIC_TLV_MSG_ID_COMPHY_SET_REQ			= 0x3E,
+	FBNIC_TLV_MSG_ID_COMPHY_SET_RESP		= 0x3F,
 };
 
 #define FBNIC_FW_CAP_RESP_VERSION_MAJOR		CSR_GENMASK(31, 24)
@@ -104,8 +107,27 @@ enum {
 	FBNIC_FW_CAP_RESP_MSG_MAX
 };
 
+enum {
+	FBNIC_FW_LINK_SPEED_25R1		= 1,
+	FBNIC_FW_LINK_SPEED_50R2		= 2,
+	FBNIC_FW_LINK_SPEED_50R1		= 3,
+	FBNIC_FW_LINK_SPEED_100R2		= 4,
+};
+
+enum {
+	FBNIC_FW_LINK_FEC_NONE			= 1,
+	FBNIC_FW_LINK_FEC_RS			= 2,
+	FBNIC_FW_LINK_FEC_BASER			= 3,
+};
+
 enum {
 	FBNIC_FW_OWNERSHIP_FLAG			= 0x0,
 	FBNIC_FW_OWNERSHIP_MSG_MAX
 };
+
+enum {
+	FBNIC_COMPHY_SET_PAM4			= 0x0,
+	FBNIC_COMPHY_SET_ERROR			= 0x1,
+	FBNIC_COMPHY_SET_MSG_MAX
+};
 #endif /* _FBNIC_FW_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index a20070683f48..33b5f15e2c40 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -84,11 +84,127 @@ void fbnic_fw_disable_mbx(struct fbnic_dev *fbd)
 	fbnic_mbx_clean(fbd);
 }
 
+static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
+{
+	struct fbnic_dev *fbd = data;
+
+	if (fbd->mac->get_link_event(fbd))
+		fbd->link_state = FBNIC_LINK_EVENT;
+	else
+		wr32(FBNIC_INTR_MASK_CLEAR(0), 1u << FBNIC_MAC_MSIX_ENTRY);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * fbnic_mac_get_link - Retrieve the current link state of the MAC
+ * @fbd: Device to retrieve the link state of
+ * @link: pointer to boolean value that will store link state
+ *
+ * This function will query the hardware to determine the state of the
+ * hardware to determine the link status of the device. If it is unable to
+ * communicate with the device it will return ENODEV and return false
+ * indicating the link is down.
+ **/
+int fbnic_mac_get_link(struct fbnic_dev *fbd, bool *link)
+{
+	const struct fbnic_mac *mac = fbd->mac;
+
+	*link = true;
+
+	/* In an interrupt driven setup we can just skip the check if
+	 * the link is up as the interrupt should toggle it to the EVENT
+	 * state if the link has changed state at any time since the last
+	 * check.
+	 */
+	if (fbd->link_state == FBNIC_LINK_UP)
+		goto skip_check;
+
+	*link = mac->get_link(fbd);
+
+	wr32(FBNIC_INTR_MASK_CLEAR(0), 1u << FBNIC_MAC_MSIX_ENTRY);
+skip_check:
+	if (!fbnic_present(fbd)) {
+		*link = false;
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/**
+ * fbnic_mac_enable - Configure the MAC to enable it to advertise link
+ * @fbd: Pointer to device to initialize
+ *
+ * This function provides basic bringup for the CMAC and sets the link
+ * state to FBNIC_LINK_EVENT which tells the link state check that the
+ * current state is unknown and that interrupts must be enabled after the
+ * check is completed.
+ **/
+int fbnic_mac_enable(struct fbnic_dev *fbd)
+{
+	const struct fbnic_mac *mac = fbd->mac;
+	u32 vector = fbd->mac_msix_vector;
+	int err;
+
+	/* Request the IRQ for MAC link vector.
+	 * Map MAC cause to it, and unmask it
+	 */
+	err = request_irq(vector, &fbnic_mac_msix_intr, 0,
+			  fbd->netdev->name, fbd);
+	if (err)
+		return err;
+
+	wr32(FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
+	     FBNIC_MAC_MSIX_ENTRY | FBNIC_INTR_MSIX_CTRL_ENABLE);
+
+	err = mac->enable(fbd);
+	if (err) {
+		/* Disable interrupt */
+		wr32(FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
+		     FBNIC_MAC_MSIX_ENTRY);
+		wr32(FBNIC_INTR_MASK_SET(0), 1u << FBNIC_MAC_MSIX_ENTRY);
+
+		/* Free the vector */
+		free_irq(fbd->mac_msix_vector, fbd);
+	}
+
+	return err;
+}
+
+/**
+ * fbnic_mac_disable - Teardown the MAC to prepare for stopping
+ * @fbd: Pointer to device that is stopping
+ *
+ * This function undoes the work done in fbnic_mac_enable and prepares the
+ * device to no longer receive traffic on the host interface.
+ **/
+void fbnic_mac_disable(struct fbnic_dev *fbd)
+{
+	const struct fbnic_mac *mac = fbd->mac;
+
+	/* Nothing to do if link is already disabled */
+	if (fbd->link_state == FBNIC_LINK_DISABLED)
+		return;
+
+	mac->disable(fbd);
+
+	/* Disable interrupt */
+	wr32(FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
+	     FBNIC_MAC_MSIX_ENTRY);
+	wr32(FBNIC_INTR_MASK_SET(0), 1u << FBNIC_MAC_MSIX_ENTRY);
+
+	/* Free the vector */
+	free_irq(fbd->mac_msix_vector, fbd);
+}
+
 void fbnic_free_irqs(struct fbnic_dev *fbd)
 {
 	struct pci_dev *pdev = to_pci_dev(fbd->dev);
 
+	fbd->mac_msix_vector = 0;
 	fbd->fw_msix_vector = 0;
+
 	fbd->num_irqs = 0;
 
 	pci_disable_msix(pdev);
@@ -128,6 +244,8 @@ int fbnic_alloc_irqs(struct fbnic_dev *fbd)
 	fbd->msix_entries = msix_entries;
 	fbd->num_irqs = num_irqs;
 
+	fbd->mac_msix_vector = msix_entries[FBNIC_MAC_MSIX_ENTRY].vector;
 	fbd->fw_msix_vector = msix_entries[FBNIC_FW_MSIX_ENTRY].vector;
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index dbbfdc649f37..64c4dde30b9d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -2,10 +2,12 @@
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bitfield.h>
+#include <linux/iopoll.h>
 #include <net/tcp.h>
 
 #include "fbnic.h"
 #include "fbnic_mac.h"
+#include "fbnic_netdev.h"
 
 static void fbnic_init_readrq(struct fbnic_dev *fbd, unsigned int offset,
 			      unsigned int cls, unsigned int readrq)
@@ -415,8 +417,593 @@ static void fbnic_mac_init_regs(struct fbnic_dev *fbd)
 	fbnic_mac_init_txb(fbd);
 }
 
+static int fbnic_mac_get_link_event_asic(struct fbnic_dev *fbd)
+{
+	u32 pcs_intr_mask = rd32(FBNIC_MAC_PCS_INTR_STS);
+
+	if (pcs_intr_mask & FBNIC_MAC_PCS_INTR_LINK_DOWN)
+		return -1;
+
+	return (pcs_intr_mask & FBNIC_MAC_PCS_INTR_LINK_UP) ? 1 : 0;
+}
+
+static u32 __fbnic_mac_config_asic(struct fbnic_dev *fbd)
+{
+	/* Enable MAC Promiscuous mode and Tx padding */
+	u32 command_config = FBNIC_MAC_COMMAND_CONFIG_TX_PAD_EN |
+			     FBNIC_MAC_COMMAND_CONFIG_PROMISC_EN;
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+	u32 rxb_pause_ctrl;
+
+	/* Set class 0 Quanta and refresh */
+	wr32(FBNIC_MAC_CL01_PAUSE_QUANTA, 0xffff);
+	wr32(FBNIC_MAC_CL01_QUANTA_THRESH, 0x7fff);
+
+	/* Enable generation of pause frames if enabled */
+	rxb_pause_ctrl = rd32(FBNIC_RXB_PAUSE_DROP_CTRL);
+	rxb_pause_ctrl &= ~FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE;
+	if (!fbn->tx_pause)
+		command_config |= FBNIC_MAC_COMMAND_CONFIG_TX_PAUSE_DIS;
+	else
+		rxb_pause_ctrl |=
+			FIELD_PREP(FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE,
+				   FBNIC_PAUSE_EN_MASK);
+	wr32(FBNIC_RXB_PAUSE_DROP_CTRL, rxb_pause_ctrl);
+
+	if (!fbn->rx_pause)
+		command_config |= FBNIC_MAC_COMMAND_CONFIG_RX_PAUSE_DIS;
+
+	/* Disable fault handling if no FEC is requested */
+	if ((fbn->fec & FBNIC_FEC_MODE_MASK) == FBNIC_FEC_OFF)
+		command_config |= FBNIC_MAC_COMMAND_CONFIG_FLT_HDL_DIS;
+
+	return command_config;
+}
+
+static bool fbnic_mac_get_pcs_link_status(struct fbnic_dev *fbd)
+{
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+	u32 pcs_status, lane_mask = ~0;
+
+	pcs_status = rd32(FBNIC_MAC_PCS_STS0);
+	if (!(pcs_status & FBNIC_MAC_PCS_STS0_LINK))
+		return false;
+
+	/* Define the expected lane mask for the status bits we need to check */
+	switch (fbn->link_mode & FBNIC_LINK_MODE_MASK) {
+	case FBNIC_LINK_100R2:
+		lane_mask = 0xf;
+		break;
+	case FBNIC_LINK_50R1:
+		lane_mask = 3;
+		break;
+	case FBNIC_LINK_50R2:
+		switch (fbn->fec & FBNIC_FEC_MODE_MASK) {
+		case FBNIC_FEC_OFF:
+			lane_mask = 0x63;
+			break;
+		case FBNIC_FEC_RS:
+			lane_mask = 5;
+			break;
+		case FBNIC_FEC_BASER:
+			lane_mask = 0xf;
+			break;
+		}
+		break;
+	case FBNIC_LINK_25R1:
+		lane_mask = 1;
+		break;
+	}
+
+	/* Use an XOR to remove the bits we expect to see set */
+	switch (fbn->fec & FBNIC_FEC_MODE_MASK) {
+	case FBNIC_FEC_OFF:
+		lane_mask ^= FIELD_GET(FBNIC_MAC_PCS_STS0_BLOCK_LOCK,
+				       pcs_status);
+		break;
+	case FBNIC_FEC_RS:
+		lane_mask ^= FIELD_GET(FBNIC_MAC_PCS_STS0_AMPS_LOCK,
+				       pcs_status);
+		break;
+	case FBNIC_FEC_BASER:
+		lane_mask ^= FIELD_GET(FBNIC_MAC_PCS_STS1_FCFEC_LOCK,
+				       rd32(FBNIC_MAC_PCS_STS1));
+		break;
+	}
+
+	/* If all lanes cancelled then we have a lock on all lanes */
+	return !lane_mask;
+}
+
+#define FBNIC_MAC_ENET_LED_DEFAULT				\
+	(FIELD_PREP(FBNIC_MAC_ENET_LED_AMBER_MASK,		\
+		    FBNIC_MAC_ENET_LED_AMBER_50G |		\
+		    FBNIC_MAC_ENET_LED_AMBER_25G) |		\
+	 FIELD_PREP(FBNIC_MAC_ENET_LED_BLUE_MASK,		\
+		    FBNIC_MAC_ENET_LED_BLUE_100G |		\
+		    FBNIC_MAC_ENET_LED_BLUE_50G))
+#define FBNIC_MAC_ENET_LED_ACTIVITY_DEFAULT			\
+	FIELD_PREP(FBNIC_MAC_ENET_LED_BLINK_RATE_MASK,		\
+		   FBNIC_MAC_ENET_LED_BLINK_RATE_5HZ)
+#define FBNIC_MAC_ENET_LED_ACTIVITY_ON				\
+	FIELD_PREP(FBNIC_MAC_ENET_LED_OVERRIDE_EN,		\
+		   FBNIC_MAC_ENET_LED_OVERRIDE_ACTIVITY)
+#define FBNIC_MAC_ENET_LED_AMBER				\
+	(FIELD_PREP(FBNIC_MAC_ENET_LED_OVERRIDE_EN,		\
+		    FBNIC_MAC_ENET_LED_OVERRIDE_BLUE |		\
+		    FBNIC_MAC_ENET_LED_OVERRIDE_AMBER) |	\
+	 FIELD_PREP(FBNIC_MAC_ENET_LED_OVERRIDE_VAL,		\
+		    FBNIC_MAC_ENET_LED_OVERRIDE_AMBER))
+#define FBNIC_MAC_ENET_LED_BLUE					\
+	(FIELD_PREP(FBNIC_MAC_ENET_LED_OVERRIDE_EN,		\
+		    FBNIC_MAC_ENET_LED_OVERRIDE_BLUE |		\
+		    FBNIC_MAC_ENET_LED_OVERRIDE_AMBER) |	\
+	 FIELD_PREP(FBNIC_MAC_ENET_LED_OVERRIDE_VAL,		\
+		    FBNIC_MAC_ENET_LED_OVERRIDE_BLUE))
+
+static void fbnic_set_led_state_asic(struct fbnic_dev *fbd, int state)
+{
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+	u32 led_csr = FBNIC_MAC_ENET_LED_DEFAULT;
+
+	switch (state) {
+	case FBNIC_LED_OFF:
+		led_csr |= FBNIC_MAC_ENET_LED_AMBER |
+			   FBNIC_MAC_ENET_LED_ACTIVITY_ON;
+		break;
+	case FBNIC_LED_ON:
+		led_csr |= FBNIC_MAC_ENET_LED_BLUE |
+			   FBNIC_MAC_ENET_LED_ACTIVITY_ON;
+		break;
+	case FBNIC_LED_RESTORE:
+		led_csr |= FBNIC_MAC_ENET_LED_ACTIVITY_DEFAULT;
+
+		/* Don't set LEDs on if link isn't up */
+		if (fbd->link_state != FBNIC_LINK_UP)
+			break;
+		/* Don't set LEDs for supported autoneg modes */
+		if ((fbn->link_mode & FBNIC_LINK_AUTO) &&
+		    (fbn->link_mode & FBNIC_LINK_MODE_MASK) != FBNIC_LINK_50R2)
+			break;
+
+		/* Set LEDs based on link speed
+		 * 100G	Blue,
+		 * 50G	Blue & Amber
+		 * 25G	Amber
+		 */
+		switch (fbn->link_mode & FBNIC_LINK_MODE_MASK) {
+		case FBNIC_LINK_100R2:
+			led_csr |= FBNIC_MAC_ENET_LED_BLUE;
+			break;
+		case FBNIC_LINK_50R1:
+		case FBNIC_LINK_50R2:
+			led_csr |= FBNIC_MAC_ENET_LED_BLUE;
+			fallthrough;
+		case FBNIC_LINK_25R1:
+			led_csr |= FBNIC_MAC_ENET_LED_AMBER;
+			break;
+		}
+		break;
+	default:
+		return;
+	}
+
+	wr32(FBNIC_MAC_ENET_LED, led_csr);
+}
+
+static bool fbnic_mac_get_link_asic(struct fbnic_dev *fbd)
+{
+	u32 cmd_cfg, mac_ctrl;
+	int link_direction;
+	bool link;
+
+	/* If disabled do not update link_state nor change settings */
+	if (fbd->link_state == FBNIC_LINK_DISABLED)
+		return false;
+
+	link_direction = fbnic_mac_get_link_event_asic(fbd);
+
+	/* Clear interrupt state due to recent changes. */
+	wr32(FBNIC_MAC_PCS_INTR_STS,
+	     FBNIC_MAC_PCS_INTR_LINK_DOWN | FBNIC_MAC_PCS_INTR_LINK_UP);
+
+	/* If link bounced down clear the PCS_STS bit related to link */
+	if (link_direction < 0) {
+		wr32(FBNIC_MAC_PCS_STS0, FBNIC_MAC_PCS_STS0_LINK |
+					 FBNIC_MAC_PCS_STS0_BLOCK_LOCK |
+					 FBNIC_MAC_PCS_STS0_AMPS_LOCK);
+		wr32(FBNIC_MAC_PCS_STS1, FBNIC_MAC_PCS_STS1_FCFEC_LOCK);
+	}
+
+	link = fbnic_mac_get_pcs_link_status(fbd);
+	cmd_cfg = __fbnic_mac_config_asic(fbd);
+	mac_ctrl = rd32(FBNIC_MAC_CTRL);
+
+	/* Depending on the event we will unmask the cause that will force a
+	 * transition, and update the Tx to reflect our status to the remote
+	 * link partner.
+	 */
+	if (link) {
+		mac_ctrl &= ~(FBNIC_MAC_CTRL_RESET_FF_TX_CLK |
+			      FBNIC_MAC_CTRL_RESET_TX_CLK |
+			      FBNIC_MAC_CTRL_RESET_FF_RX_CLK |
+			      FBNIC_MAC_CTRL_RESET_RX_CLK);
+		cmd_cfg |= FBNIC_MAC_COMMAND_CONFIG_RX_ENA |
+			   FBNIC_MAC_COMMAND_CONFIG_TX_ENA;
+		fbd->link_state = FBNIC_LINK_UP;
+	} else {
+		mac_ctrl |= FBNIC_MAC_CTRL_RESET_FF_TX_CLK |
+			    FBNIC_MAC_CTRL_RESET_TX_CLK |
+			    FBNIC_MAC_CTRL_RESET_FF_RX_CLK |
+			    FBNIC_MAC_CTRL_RESET_RX_CLK;
+		fbd->link_state = FBNIC_LINK_DOWN;
+	}
+
+	wr32(FBNIC_MAC_CTRL, mac_ctrl);
+	wr32(FBNIC_MAC_COMMAND_CONFIG, cmd_cfg);
+
+	/* Toggle LED settings to enable LEDs manually if necessary */
+	fbnic_set_led_state_asic(fbd, FBNIC_LED_RESTORE);
+
+	if (link_direction)
+		wr32(FBNIC_MAC_PCS_INTR_MASK,
+		     link ?  ~FBNIC_MAC_PCS_INTR_LINK_DOWN :
+			     ~FBNIC_MAC_PCS_INTR_LINK_UP);
+
+	return link;
+}
+
+static void fbnic_mac_pre_config(struct fbnic_dev *fbd)
+{
+	u32 serdes_ctrl, mac_ctrl, xif_mode, enet_fec_ctrl = 0;
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+
+	/* set reset bits and enable appending of Tx CRC */
+	mac_ctrl = FBNIC_MAC_CTRL_RESET_FF_TX_CLK |
+		   FBNIC_MAC_CTRL_RESET_FF_RX_CLK |
+		   FBNIC_MAC_CTRL_RESET_TX_CLK |
+		   FBNIC_MAC_CTRL_RESET_RX_CLK |
+		   FBNIC_MAC_CTRL_TX_CRC;
+	serdes_ctrl = FBNIC_MAC_SERDES_CTRL_RESET_PCS_REF_CLK |
+		      FBNIC_MAC_SERDES_CTRL_RESET_F91_REF_CLK |
+		      FBNIC_MAC_SERDES_CTRL_RESET_SD_TX_CLK |
+		      FBNIC_MAC_SERDES_CTRL_RESET_SD_RX_CLK;
+	xif_mode = FBNIC_MAC_XIF_MODE_TX_MAC_RS_ERR;
+
+	switch (fbn->link_mode & FBNIC_LINK_MODE_MASK) {
+	case FBNIC_LINK_25R1:
+		/* Enable XGMII to run w/ 10G pacer */
+		xif_mode |= FBNIC_MAC_XIF_MODE_XGMII;
+		serdes_ctrl |= FBNIC_MAC_SERDES_CTRL_PACER_10G_MASK;
+		if (fbn->fec & FBNIC_FEC_RS)
+			serdes_ctrl |= FBNIC_MAC_SERDES_CTRL_F91_1LANE_IN0;
+		break;
+	case FBNIC_LINK_50R2:
+		if (!(fbn->fec & FBNIC_FEC_RS))
+			serdes_ctrl |= FBNIC_MAC_SERDES_CTRL_RXLAUI_ENA_IN0;
+		break;
+	case FBNIC_LINK_100R2:
+		mac_ctrl |= FBNIC_MAC_CTRL_CFG_MODE128;
+		serdes_ctrl |= FBNIC_MAC_SERDES_CTRL_PCS100_ENA_IN0;
+		enet_fec_ctrl |= FBNIC_MAC_ENET_FEC_CTRL_KP_MODE_ENA;
+		fallthrough;
+	case FBNIC_LINK_50R1:
+		serdes_ctrl |= FBNIC_MAC_SERDES_CTRL_SD_8X;
+		if (fbn->fec & FBNIC_FEC_AUTO)
+			fbn->fec = FBNIC_FEC_AUTO | FBNIC_FEC_RS;
+		break;
+	}
+
+	switch (fbn->fec & FBNIC_FEC_MODE_MASK) {
+	case FBNIC_FEC_RS:
+		enet_fec_ctrl |= FBNIC_MAC_ENET_FEC_CTRL_F91_ENA;
+		break;
+	case FBNIC_FEC_BASER:
+		enet_fec_ctrl |= FBNIC_MAC_ENET_FEC_CTRL_FEC_ENA;
+		break;
+	case FBNIC_FEC_OFF:
+		break;
+	default:
+		dev_err(fbd->dev, "Unsupported FEC mode detected");
+	}
+
+	/* Store updated config to MAC */
+	wr32(FBNIC_MAC_CTRL, mac_ctrl);
+	wr32(FBNIC_MAC_SERDES_CTRL, serdes_ctrl);
+	wr32(FBNIC_MAC_XIF_MODE, xif_mode);
+	wr32(FBNIC_MAC_ENET_FEC_CTRL, enet_fec_ctrl);
+
+	/* flush writes to allow time for MAC to go into resets */
+	wrfl();
+
+	/* Set signal detect for all lanes */
+	wr32(FBNIC_MAC_ENET_SIG_DETECT, FBNIC_MAC_ENET_SIG_DETECT_PCS_MASK);
+}
+
+static void fbnic_mac_pcs_config(struct fbnic_dev *fbd)
+{
+	u32 pcs_mode = 0, rsfec_ctrl = 0, vl_intvl = 0;
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+	int i;
+
+	/* Set link mode specific lane and FEC values */
+	switch (fbn->link_mode & FBNIC_LINK_MODE_MASK) {
+	case FBNIC_LINK_25R1:
+		if (fbn->fec & FBNIC_FEC_RS)
+			vl_intvl = 20479;
+		else
+			pcs_mode |= FBNIC_PCS_MODE_DISABLE_MLD;
+		pcs_mode |= FBNIC_PCS_MODE_HI_BER25 |
+			    FBNIC_PCS_MODE_ENA_CLAUSE49;
+		break;
+	case FBNIC_LINK_50R1:
+		rsfec_ctrl |= FBNIC_RSFEC_CONTROL_KP_ENABLE;
+		fallthrough;
+	case FBNIC_LINK_50R2:
+		rsfec_ctrl |= FBNIC_RSFEC_CONTROL_TC_PAD_ALTER;
+		vl_intvl = 20479;
+		break;
+	case FBNIC_LINK_100R2:
+		rsfec_ctrl |= FBNIC_RSFEC_CONTROL_AM16_COPY_DIS |
+			      FBNIC_RSFEC_CONTROL_KP_ENABLE;
+		pcs_mode |= FBNIC_PCS_MODE_DISABLE_MLD;
+		vl_intvl = 16383;
+		break;
+	}
+
+	for (i = 0; i < 4; i++)
+		wr32(FBNIC_RSFEC_CONTROL(i), rsfec_ctrl);
+
+	wr32(FBNIC_PCS_MODE_VL_CHAN_0, pcs_mode);
+	wr32(FBNIC_PCS_MODE_VL_CHAN_1, pcs_mode);
+
+	wr32(FBNIC_PCS_VENDOR_VL_INTVL_0, vl_intvl);
+	wr32(FBNIC_PCS_VENDOR_VL_INTVL_1, vl_intvl);
+
+	/* Update IPG to account for vl_intvl */
+	wr32(FBNIC_MAC_TX_IPG_LENGTH,
+	     FIELD_PREP(FBNIC_MAC_TX_IPG_LENGTH_COMP, vl_intvl) | 0xc);
+
+	/* Program lane markers indicating which lanes are in use
+	 * and what speeds we are transmitting at.
+	 */
+	switch (fbn->link_mode & FBNIC_LINK_MODE_MASK) {
+	case FBNIC_LINK_100R2:
+		wr32(FBNIC_PCS_VL0_0_CHAN_0, 0x68c1);
+		wr32(FBNIC_PCS_VL0_1_CHAN_0, 0x21);
+		wr32(FBNIC_PCS_VL1_0_CHAN_0, 0x719d);
+		wr32(FBNIC_PCS_VL1_1_CHAN_0, 0x8e);
+		wr32(FBNIC_PCS_VL2_0_CHAN_0, 0x4b59);
+		wr32(FBNIC_PCS_VL2_1_CHAN_0, 0xe8);
+		wr32(FBNIC_PCS_VL3_0_CHAN_0, 0x954d);
+		wr32(FBNIC_PCS_VL3_1_CHAN_0, 0x7b);
+		wr32(FBNIC_PCS_VL0_0_CHAN_1, 0x68c1);
+		wr32(FBNIC_PCS_VL0_1_CHAN_1, 0x21);
+		wr32(FBNIC_PCS_VL1_0_CHAN_1, 0x719d);
+		wr32(FBNIC_PCS_VL1_1_CHAN_1, 0x8e);
+		wr32(FBNIC_PCS_VL2_0_CHAN_1, 0x4b59);
+		wr32(FBNIC_PCS_VL2_1_CHAN_1, 0xe8);
+		wr32(FBNIC_PCS_VL3_0_CHAN_1, 0x954d);
+		wr32(FBNIC_PCS_VL3_1_CHAN_1, 0x7b);
+		break;
+	case FBNIC_LINK_50R2:
+		wr32(FBNIC_PCS_VL0_0_CHAN_1, 0x7690);
+		wr32(FBNIC_PCS_VL0_1_CHAN_1, 0x47);
+		wr32(FBNIC_PCS_VL1_0_CHAN_1, 0xc4f0);
+		wr32(FBNIC_PCS_VL1_1_CHAN_1, 0xe6);
+		wr32(FBNIC_PCS_VL2_0_CHAN_1, 0x65c5);
+		wr32(FBNIC_PCS_VL2_1_CHAN_1, 0x9b);
+		wr32(FBNIC_PCS_VL3_0_CHAN_1, 0x79a2);
+		wr32(FBNIC_PCS_VL3_1_CHAN_1, 0x3d);
+		fallthrough;
+	case FBNIC_LINK_50R1:
+		wr32(FBNIC_PCS_VL0_0_CHAN_0, 0x7690);
+		wr32(FBNIC_PCS_VL0_1_CHAN_0, 0x47);
+		wr32(FBNIC_PCS_VL1_0_CHAN_0, 0xc4f0);
+		wr32(FBNIC_PCS_VL1_1_CHAN_0, 0xe6);
+		wr32(FBNIC_PCS_VL2_0_CHAN_0, 0x65c5);
+		wr32(FBNIC_PCS_VL2_1_CHAN_0, 0x9b);
+		wr32(FBNIC_PCS_VL3_0_CHAN_0, 0x79a2);
+		wr32(FBNIC_PCS_VL3_1_CHAN_0, 0x3d);
+		break;
+	case FBNIC_LINK_25R1:
+		wr32(FBNIC_PCS_VL0_0_CHAN_0, 0x68c1);
+		wr32(FBNIC_PCS_VL0_1_CHAN_0, 0x21);
+		wr32(FBNIC_PCS_VL1_0_CHAN_0, 0xc4f0);
+		wr32(FBNIC_PCS_VL1_1_CHAN_0, 0xe6);
+		wr32(FBNIC_PCS_VL2_0_CHAN_0, 0x65c5);
+		wr32(FBNIC_PCS_VL2_1_CHAN_0, 0x9b);
+		wr32(FBNIC_PCS_VL3_0_CHAN_0, 0x79a2);
+		wr32(FBNIC_PCS_VL3_1_CHAN_0, 0x3d);
+		break;
+	}
+}
+
+static bool fbnic_mac_pcs_reset_complete(struct fbnic_dev *fbd)
+{
+	return !(rd32(FBNIC_PCS_CONTROL1_0) & FBNIC_PCS_CONTROL1_RESET) &&
+	       !(rd32(FBNIC_PCS_CONTROL1_1) & FBNIC_PCS_CONTROL1_RESET);
+}
+
+static int fbnic_mac_post_config(struct fbnic_dev *fbd)
+{
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+	u32 serdes_ctrl, reset_complete, lane_mask;
+	int err;
+
+	/* Clear resets for XPCS and F91 reference clocks */
+	serdes_ctrl = rd32(FBNIC_MAC_SERDES_CTRL);
+	serdes_ctrl &= ~FBNIC_MAC_SERDES_CTRL_RESET_PCS_REF_CLK;
+	if (fbn->fec & FBNIC_FEC_RS)
+		serdes_ctrl &= ~FBNIC_MAC_SERDES_CTRL_RESET_F91_REF_CLK;
+	wr32(FBNIC_MAC_SERDES_CTRL, serdes_ctrl);
+
+	/* Reset PCS and flush reset value */
+	wr32(FBNIC_PCS_CONTROL1_0,
+	     FBNIC_PCS_CONTROL1_RESET |
+	     FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS |
+	     FBNIC_PCS_CONTROL1_SPEED_ALWAYS);
+	wr32(FBNIC_PCS_CONTROL1_1,
+	     FBNIC_PCS_CONTROL1_RESET |
+	     FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS |
+	     FBNIC_PCS_CONTROL1_SPEED_ALWAYS);
+
+	/* poll for completion of reset */
+	err = readx_poll_timeout(fbnic_mac_pcs_reset_complete, fbd,
+				 reset_complete, reset_complete,
+				 1000, 150000);
+	if (err)
+		return err;
+
+	/* Flush any stale link status info */
+	wr32(FBNIC_MAC_PCS_STS0, FBNIC_MAC_PCS_STS0_LINK |
+				 FBNIC_MAC_PCS_STS0_BLOCK_LOCK |
+				 FBNIC_MAC_PCS_STS0_AMPS_LOCK);
+
+	/* Report starting state as "Link Event" to force detection of link */
+	fbd->link_state = FBNIC_LINK_EVENT;
+
+	/* Force link down to allow for link detection */
+	netif_carrier_off(fbn->netdev);
+
+	/* create simple bitmask for 2 or 1 lane setups */
+	lane_mask = (fbn->link_mode & FBNIC_LINK_MODE_R2) ? 3 : 1;
+
+	/* release the brakes and allow Tx/Rx to come out of reset */
+	serdes_ctrl &=
+	     ~(FIELD_PREP(FBNIC_MAC_SERDES_CTRL_RESET_SD_TX_CLK, lane_mask) |
+	       FIELD_PREP(FBNIC_MAC_SERDES_CTRL_RESET_SD_RX_CLK, lane_mask));
+	wr32(FBNIC_MAC_SERDES_CTRL, serdes_ctrl);
+
+	fbn->link_mode &= ~FBNIC_LINK_AUTO;
+
+	/* Ask firmware to configure the PHY for the correct encoding mode */
+	return fbnic_fw_xmit_comphy_set_msg(fbd,
+					    fbn->link_mode &
+					    FBNIC_LINK_MODE_MASK);
+}
+
+static void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd)
+{
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+	u8 fec = fbn->fec;
+	u8 link_mode;
+
+	/* Update FEC first to reflect FW current mode */
+	if (fbn->fec & FBNIC_FEC_AUTO) {
+		switch (fbd->fw_cap.link_fec) {
+		case FBNIC_FW_LINK_FEC_NONE:
+			fec = FBNIC_FEC_OFF;
+			break;
+		case FBNIC_FW_LINK_FEC_RS:
+			fec = FBNIC_FEC_RS;
+			break;
+		case FBNIC_FW_LINK_FEC_BASER:
+			fec = FBNIC_FEC_BASER;
+			break;
+		default:
+			return;
+		}
+	}
+
+	/* Do nothing if AUTO mode is not engaged */
+	if (fbn->link_mode & FBNIC_LINK_AUTO) {
+		switch (fbd->fw_cap.link_speed) {
+		case FBNIC_FW_LINK_SPEED_25R1:
+			link_mode = FBNIC_LINK_25R1;
+			break;
+		case FBNIC_FW_LINK_SPEED_50R2:
+			link_mode = FBNIC_LINK_50R2;
+			break;
+		case FBNIC_FW_LINK_SPEED_50R1:
+			link_mode = FBNIC_LINK_50R1;
+			fec = FBNIC_FEC_RS;
+			break;
+		case FBNIC_FW_LINK_SPEED_100R2:
+			link_mode = FBNIC_LINK_100R2;
+			fec = FBNIC_FEC_RS;
+			break;
+		default:
+			return;
+		}
+
+		fbn->link_mode = link_mode;
+		fbn->fec = fec;
+	}
+}
+
+static int fbnic_mac_enable_asic(struct fbnic_dev *fbd)
+{
+	/* Mask and clear the PCS interrupt, will be enabled by link handler */
+	wr32(FBNIC_MAC_PCS_INTR_MASK, ~0);
+	wr32(FBNIC_MAC_PCS_INTR_STS, ~0);
+
+	/* Pull in settings from FW */
+	fbnic_mac_get_fw_settings(fbd);
+
+	/* Configure MAC registers */
+	fbnic_mac_pre_config(fbd);
+
+	/* Configure PCS block */
+	fbnic_mac_pcs_config(fbd);
+
+	/* Configure flow control and error correction */
+	wr32(FBNIC_MAC_COMMAND_CONFIG, __fbnic_mac_config_asic(fbd));
+
+	/* Configure maximum frame size */
+	wr32(FBNIC_MAC_FRM_LENGTH, FBNIC_MAX_JUMBO_FRAME_SIZE);
+
+	/* Configure LED defaults */
+	fbnic_set_led_state_asic(fbd, FBNIC_LED_RESTORE);
+
+	return fbnic_mac_post_config(fbd);
+}
+
+static void fbnic_mac_disable_asic(struct fbnic_dev *fbd)
+{
+	u32 mask = FBNIC_MAC_COMMAND_CONFIG_LOOPBACK_EN;
+	u32 cmd_cfg = rd32(FBNIC_MAC_COMMAND_CONFIG);
+	u32 mac_ctrl = rd32(FBNIC_MAC_CTRL);
+
+	/* Clear link state to disable any further transitions */
+	fbd->link_state = FBNIC_LINK_DISABLED;
+
+	/* Clear Tx and Rx enable bits to disable MAC, ignore other values */
+	if (!fbnic_bmc_present(fbd)) {
+		mask |= FBNIC_MAC_COMMAND_CONFIG_RX_ENA |
+			FBNIC_MAC_COMMAND_CONFIG_TX_ENA;
+		mac_ctrl |= FBNIC_MAC_CTRL_RESET_FF_TX_CLK |
+			    FBNIC_MAC_CTRL_RESET_TX_CLK |
+			    FBNIC_MAC_CTRL_RESET_FF_RX_CLK |
+			    FBNIC_MAC_CTRL_RESET_RX_CLK;
+
+		/* Restore LED defaults */
+		fbnic_set_led_state_asic(fbd, FBNIC_LED_RESTORE);
+	}
+
+	/* Check mask for enabled bits, if any set clear and write back */
+	if (mask & cmd_cfg) {
+		wr32(FBNIC_MAC_COMMAND_CONFIG, cmd_cfg & ~mask);
+		wr32(FBNIC_MAC_CTRL, mac_ctrl);
+	}
+
+	/* Disable loopback, and flush write */
+	wr32(FBNIC_PCS_CONTROL1_0,
+	     FBNIC_PCS_CONTROL1_RESET |
+	     FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS |
+	     FBNIC_PCS_CONTROL1_SPEED_ALWAYS);
+	wr32(FBNIC_PCS_CONTROL1_1,
+	     FBNIC_PCS_CONTROL1_RESET |
+	     FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS |
+	     FBNIC_PCS_CONTROL1_SPEED_ALWAYS);
+}
+
 static const struct fbnic_mac fbnic_mac_asic = {
+	.enable = fbnic_mac_enable_asic,
+	.disable = fbnic_mac_disable_asic,
 	.init_regs = fbnic_mac_init_regs,
+	.get_link = fbnic_mac_get_link_asic,
+	.get_link_event = fbnic_mac_get_link_event_asic,
 };
 
 /**
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index e78a92338a62..5aa089093206 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -10,14 +10,72 @@ struct fbnic_dev;
 
 #define FBNIC_MAX_JUMBO_FRAME_SIZE	9742
 
+enum {
+	FBNIC_LINK_DISABLED	= 0,
+	FBNIC_LINK_DOWN		= 1,
+	FBNIC_LINK_UP		= 2,
+	FBNIC_LINK_EVENT	= 3,
+};
+
+enum {
+	FBNIC_LED_STROBE_INIT,
+	FBNIC_LED_ON,
+	FBNIC_LED_OFF,
+	FBNIC_LED_RESTORE,
+};
+
+/* Treat the FEC bits as a bitmask laid out as follows:
+ * Bit 0: RS Enabled
+ * Bit 1: BASER(Firecode) Enabled
+ * Bit 2: Autoneg FEC
+ */
+enum {
+	FBNIC_FEC_OFF		= 0,
+	FBNIC_FEC_RS		= 1,
+	FBNIC_FEC_BASER		= 2,
+	FBNIC_FEC_AUTO		= 4,
+};
+
+#define FBNIC_FEC_MODE_MASK	(FBNIC_FEC_AUTO - 1)
+
+/* Treat the link modes as a set of moldulation/lanes bitmask:
+ * Bit 0: Lane Count, 0 = R1, 1 = R2
+ * Bit 1: Modulation, 0 = NRZ, 1 = PAM4
+ * Bit 2: Autoneg Modulation/Lane Configuration
+ */
+enum {
+	FBNIC_LINK_25R1		= 0,
+	FBNIC_LINK_50R2		= 1,
+	FBNIC_LINK_50R1		= 2,
+	FBNIC_LINK_100R2	= 3,
+	FBNIC_LINK_AUTO		= 4,
+};
+
+#define FBNIC_LINK_MODE_R2	(FBNIC_LINK_50R2)
+#define FBNIC_LINK_MODE_PAM4	(FBNIC_LINK_50R1)
+#define FBNIC_LINK_MODE_MASK	(FBNIC_LINK_AUTO - 1)
+
 /* This structure defines the interface hooks for the MAC. The MAC hooks
  * will be configured as a const struct provided with a set of function
  * pointers.
  *
+ * bool (*get_link)(struct fbnic_dev *fbd);
+ *	Get the current link state for the MAC.
+ * int (*get_link_event)(struct fbnic_dev *fbd)
+ *	Get the current link event status, reports true if link has
+ *	changed to either up (1) or down (-1).
+ * void (*enable)(struct fbnic_dev *fbd);
+ *	Configure and enable MAC to enable link if not already enabled
+ * void (*disable)(struct fbnic_dev *fbd);
+ *	Shutdown the link if we are the only consumer of it.
  * void (*init_regs)(struct fbnic_dev *fbd);
  *	Initialize MAC registers to enable Tx/Rx paths and FIFOs.
  */
 struct fbnic_mac {
+	bool (*get_link)(struct fbnic_dev *fbd);
+	int (*get_link_event)(struct fbnic_dev *fbd);
+	int (*enable)(struct fbnic_dev *fbd);
+	void (*disable)(struct fbnic_dev *fbd);
 	void (*init_regs)(struct fbnic_dev *fbd);
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index bbc2f21060dc..c49ace7f2156 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -45,6 +45,10 @@ int __fbnic_open(struct fbnic_net *fbn)
 	if (err)
 		goto release_ownership;
 
+	err = fbnic_mac_enable(fbd);
+	if (err)
+		goto release_ownership;
+
 	return 0;
 release_ownership:
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
@@ -72,6 +76,7 @@ static int fbnic_stop(struct net_device *netdev)
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
 	fbnic_down(fbn);
+	fbnic_mac_disable(fbn->fbd);
 
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
 
@@ -146,6 +151,13 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
 
+	/* Default to accept pause frames w/ attempt to autoneg the value */
+	fbn->autoneg_pause = true;
+	fbn->rx_pause = true;
+	fbn->tx_pause = false;
+
+	fbn->fec = FBNIC_FEC_AUTO | FBNIC_FEC_RS;
+	fbn->link_mode = FBNIC_LINK_AUTO | FBNIC_LINK_50R2;
 	netif_carrier_off(netdev);
 
 	netif_tx_stop_all_queues(netdev);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 18f93e9431cc..3976fb1a0eac 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -22,9 +22,16 @@ struct fbnic_net {
 
 	u16 num_napi;
 
+	u8 autoneg_pause;
+	u8 tx_pause;
+	u8 rx_pause;
+	u8 fec;
+	u8 link_mode;
+
 	u16 num_tx_queues;
 	u16 num_rx_queues;
 
+	u64 link_down_events;
 	struct list_head napis;
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 8408f0d5f54a..f243950c68bb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -160,6 +160,78 @@ void fbnic_down(struct fbnic_net *fbn)
 	fbnic_flush(fbn);
 }
 
+static char *fbnic_report_fec(struct fbnic_dev *fbd)
+{
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+
+	if (fbn->link_mode & FBNIC_LINK_MODE_PAM4)
+		return "Clause 91 RS(544,514)";
+
+	switch (fbn->fec & FBNIC_FEC_MODE_MASK) {
+	case FBNIC_FEC_OFF:
+		return "Off";
+	case FBNIC_FEC_BASER:
+		return "Clause 74 BaseR";
+	case FBNIC_FEC_RS:
+		return "Clause 91 RS(528,514)";
+	}
+
+	return "Unknown";
+}
+
+static void fbnic_link_check(struct fbnic_dev *fbd)
+{
+	struct net_device *netdev = fbd->netdev;
+	bool link_found = false;
+	int err;
+
+	err = fbnic_mac_get_link(fbd, &link_found);
+	if (err) {
+		/* TBD: For now we do nothing. In the future we should have
+		 * the link_check function request a reset.
+		 *
+		 * We would do this here as the reset will likely involve
+		 * us having to tear down the interface which will require
+		 * us taking the RTNL lock in order to coordinate the
+		 * teardown and bringup before and after the reset.
+		 */
+		return;
+	}
+
+	if (!link_found) {
+		if (netif_carrier_ok(netdev)) {
+			struct fbnic_net *fbn = netdev_priv(netdev);
+
+			netdev_err(netdev, "NIC Link is Down\n");
+			fbn->link_down_events++;
+		}
+		netif_carrier_off(netdev);
+		return;
+	}
+
+	if (!netif_carrier_ok(netdev)) {
+		struct fbnic_net *fbn = netdev_priv(netdev);
+
+		netdev_info(netdev,
+			    "NIC Link is Up, %d Mbps (%s), Flow control: %s\n",
+			    ((fbn->link_mode & FBNIC_LINK_MODE_PAM4) ?
+			     50000 : 25000) *
+			    ((fbn->link_mode & FBNIC_LINK_MODE_R2) ?
+			     2 : 1),
+			    (fbn->link_mode & FBNIC_LINK_MODE_PAM4) ?
+			    "PAM4" : "NRZ",
+			    (fbn->rx_pause ?
+			     (fbn->tx_pause ? "ON - Tx/Rx" : "ON - Rx") :
+			     (fbn->tx_pause ? "ON - Tx" : "OFF")));
+		netdev_info(netdev, "FEC autoselect %s encoding: %s\n",
+			    (fbn->fec & FBNIC_FEC_AUTO) ?
+			    "enabled" : "disabled",
+			    fbnic_report_fec(fbd));
+		fbnic_config_drop_mode(fbn);
+	}
+	netif_carrier_on(netdev);
+}
+
 static void fbnic_health_check(struct fbnic_dev *fbd)
 {
 	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
@@ -192,6 +264,7 @@ static void fbnic_service_task(struct work_struct *work)
 	rtnl_lock();
 
 	fbnic_fw_check_heartbeat(fbd);
+	fbnic_link_check(fbd);
 
 	fbnic_health_check(fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 484cab7342da..2967ff53305a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1031,9 +1031,14 @@ static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
 static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 				       struct fbnic_ring *rcq)
 {
+	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
 	u32 drop_mode, rcq_ctl;
 
-	drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
+	/* Drop mode is only supported on when flow control is disabled */
+	if (!fbn->tx_pause)
+		drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
+	else
+		drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_NEVER;
 
 	/* Specify packet layout */
 	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
@@ -1043,6 +1048,20 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
 }
 
+void fbnic_config_drop_mode(struct fbnic_net *fbn)
+{
+	struct fbnic_napi_vector *nv;
+	int i;
+
+	list_for_each_entry(nv, &fbn->napis, napis) {
+		for (i = 0; i < nv->rxt_count; i++) {
+			struct fbnic_q_triad *qt = &nv->qt[nv->txt_count + i];
+
+			fbnic_config_drop_mode_rcq(nv, &qt->cmpl);
+		}
+	}
+}
+
 static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 			     struct fbnic_ring *rcq)
 {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 200f3b893d02..812e4bb245db 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -99,6 +99,7 @@ void fbnic_napi_enable(struct fbnic_net *fbn);
 void fbnic_napi_disable(struct fbnic_net *fbn);
 void fbnic_enable(struct fbnic_net *fbn);
 void fbnic_disable(struct fbnic_net *fbn);
+void fbnic_config_drop_mode(struct fbnic_net *fbn);
 void fbnic_flush(struct fbnic_net *fbn);
 void fbnic_fill(struct fbnic_net *fbn);
 



