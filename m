Return-Path: <netdev+bounces-110391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B6092C289
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E8C1C2125E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DD6180022;
	Tue,  9 Jul 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf5ufnLo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6AA17DE1A
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546157; cv=none; b=N/ujwXb+U2WXuFwtH5nv2q4DZNZxDIgko6xAO2+HnEK7JQ/tmw9n+s4aYihqoc57xuc2JZQdhFyAc1IT6c7BUcr2A79lkU2XH8YEf9SqbftW7C1nynO+Ws7f1RjFsJZ++mwUbY9rUeJVrsA6BT2tzRuBzHeG1Fk9ccFGnpKVEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546157; c=relaxed/simple;
	bh=5wxTsAE4ojUvwd8scXs6n8T/O1T38vjhw7XiIlRJaGY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuheygYSjtrQn0pWyE/wwKnjAroV4Lu/zAM4g8tNO0NiBj0MkRJS003ofdTbm4Kc/P1j9Bb7vkUuVXZiSI11HwIv9PebeUa3a6o0GC9ebVqEqZ6ELwRhg3gbEF1gNJIXo6VdUnL7j0yDSpQV8IF/A0OxdKULkxBmlMJJ/Xb1/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf5ufnLo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb3cf78ff3so36171835ad.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 10:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720546154; x=1721150954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e/mE2XQeCvDDaF4evgAOzx5POYCntfEK+J5E0B5GSQI=;
        b=Pf5ufnLoPpYdxozzIBCWkZFQfR2phIHNome77a7TftBCnuWKciz6qkUtW1usYqHAIw
         UuOHV6LJl5OUjR1mKVaX3kc0+mjzafvyh7p+ovfLvFc6RgsoEA1Wz8j4PP9LaGN9W5R2
         1A0WPokzvZAoyUhpY/XJTbLuqGhuNuzfqsEqNNQT8Yr3482LgBjplJ5a1V9trvIp7+7r
         Ks47WNKWE1uztNfwsns9OHoGmg6RRlYMJh1J+/mykyLzJX9ekjBTTwB9IjohrvYtvnfm
         TJAROjm24SvKjiPMsXOLpoM4WEo8Y/oPi8ixvh3EEhHyhJqAjmuyjs+1R/i+r3+SdWdD
         euOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546154; x=1721150954;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/mE2XQeCvDDaF4evgAOzx5POYCntfEK+J5E0B5GSQI=;
        b=RFqFPEawRW76VjssbFKB9MqScMTZi1w+X24vTzOhJ5JwvSFAGNOvwP5tMCt7xxN+Ym
         zH0+TwGlTkzkBCG0jEsUaj08LQs1vjbNNGQcL+5DpcaMJ7IHL+Fxd4Nx2zJnbuwbx6wp
         ViIkl7B6phN6hpIo5xHAqN8qGlRO+o3lwucT+RzqCw1odtdHOjVUtJh5+orEuOj+V4kP
         eNncxwo1bH65vK13WdmGJRHPEU0R8vUV5IULtO72aTC8vWH3YzCAkdfDprQ+CeeRcUA1
         DGhQBxoaLe/jAPFcnadyEdM/NgqZ4zTF9+rK7CLqBE695KmXjUlYjlN0SVnxH8zJfVyg
         6fiA==
X-Gm-Message-State: AOJu0Yzhe77q7Ybm/skKHVLY1RN9VSltsKpLpB5496dDBGS9Xw3q/wVS
	TLKbZJNvThyljcidqir/37AF4GyUBhvzgAqS8F1AvBlafXRNjMPJ
X-Google-Smtp-Source: AGHT+IHD5SrsKFuosH6LfbNsI3XVRuXzuaC0hW/DuZe78yqP8TT3xALFvTVRxrWgn+8FJ2BWYviINw==
X-Received: by 2002:a17:902:d643:b0:1fb:2bed:6418 with SMTP id d9443c01a7336-1fbb6eb22d6mr17530625ad.57.1720546154273;
        Tue, 09 Jul 2024 10:29:14 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2a4d2sm18769435ad.92.2024.07.09.10.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:29:13 -0700 (PDT)
Subject: [net-next PATCH v4 11/15] eth: fbnic: Add link detection
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 kernel-team@meta.com
Date: Tue, 09 Jul 2024 10:29:12 -0700
Message-ID: 
 <172054615268.1305884.1538979796878523852.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
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

Add basic support for detecting the link and reporting it at the netdev
layer. For now we will just use the values reporeted by the firmware as the
link configuration and assume that is the current configuration of the MAC
and PCS.

With this we start the stubbing out of the phylink interface that will be
used to provide the configuration interface for ethtool in a future patch
set.

The phylink interface isn't an exact fit. As such we are currently working
around several issues in this patch set that we plan to address in the
future such as:
1. Support for FEC
2. Support for multiple lanes to handle 50GbaseR2 vs 50GbaseR1
3. Support for BMC

CC: Russell King <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/Kconfig               |    1 
 drivers/net/ethernet/meta/fbnic/Makefile        |    1 
 drivers/net/ethernet/meta/fbnic/fbnic.h         |   10 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h     |   39 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h      |   13 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |   67 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |  241 +++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |   61 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |   22 ++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |   11 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c     |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |  161 +++++++++++++++
 12 files changed, 629 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index fbbc38e7e507..d8f5e9f9bb33 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -21,6 +21,7 @@ config FBNIC
 	tristate "Meta Platforms Host Network Interface"
 	depends on X86_64 || COMPILE_TEST
 	depends on PCI_MSI
+	select PHYLINK
 	help
 	  This driver supports Meta Platforms Host Network Interface.
 
diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index f2ea90e0c14f..a487ac5c4ec5 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -13,5 +13,6 @@ fbnic-y := fbnic_devlink.o \
 	   fbnic_mac.o \
 	   fbnic_netdev.o \
 	   fbnic_pci.o \
+	   fbnic_phylink.o \
 	   fbnic_tlv.o \
 	   fbnic_txrx.o
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 44fe6bbf88a1..3539e090df69 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -21,6 +21,7 @@ struct fbnic_dev {
 	u32 __iomem *uc_addr4;
 	const struct fbnic_mac *mac;
 	unsigned int fw_msix_vector;
+	unsigned int pcs_msix_vector;
 	unsigned short num_irqs;
 
 	struct delayed_work service_task;
@@ -49,6 +50,7 @@ struct fbnic_dev {
  */
 enum {
 	FBNIC_FW_MSIX_ENTRY,
+	FBNIC_PCS_MSIX_ENTRY,
 	FBNIC_NON_NAPI_VECTORS
 };
 
@@ -95,6 +97,11 @@ void fbnic_fw_wr32(struct fbnic_dev *fbd, u32 reg, u32 val);
 #define fw_wr32(_f, _r, _v)	fbnic_fw_wr32(_f, _r, _v)
 #define fw_wrfl(_f)		fbnic_fw_rd32(_f, FBNIC_FW_ZERO_REG)
 
+static inline bool fbnic_bmc_present(struct fbnic_dev *fbd)
+{
+	return fbd->fw_cap.bmc_present;
+}
+
 static inline bool fbnic_init_failure(struct fbnic_dev *fbd)
 {
 	return !fbd->netdev;
@@ -110,6 +117,9 @@ void fbnic_devlink_unregister(struct fbnic_dev *fbd);
 int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
 void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);
 
+int fbnic_pcs_irq_enable(struct fbnic_dev *fbd);
+void fbnic_pcs_irq_disable(struct fbnic_dev *fbd);
+
 int fbnic_request_irq(struct fbnic_dev *dev, int nr, irq_handler_t handler,
 		      unsigned long flags, const char *name, void *data);
 void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index fb64ad919d31..031ddd9ac4d4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -85,6 +85,9 @@
 #define FBNIC_INTR_MSIX_CTRL(n)		(0x00040 + (n)) /* 0x00100 + 4*n */
 #define FBNIC_INTR_MSIX_CTRL_VECTOR_MASK	CSR_GENMASK(7, 0)
 #define FBNIC_INTR_MSIX_CTRL_ENABLE		CSR_BIT(31)
+enum {
+	FBNIC_INTR_MSIX_CTRL_PCS_IDX	= 34,
+};
 
 #define FBNIC_CSR_END_INTR		0x0005f	/* CSR section delimiter */
 
@@ -419,6 +422,42 @@ enum {
 #define FBNIC_MASTER_SPARE_0		0x0C41B		/* 0x3106c */
 #define FBNIC_CSR_END_MASTER		0x0C452	/* CSR section delimiter */
 
+/* MAC MAC registers (ASIC only) */
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
+#define FBNIC_MAC_CL01_PAUSE_QUANTA	0x11015		/* 0x44054 */
+#define FBNIC_MAC_CL01_QUANTA_THRESH	0x11019		/* 0x44064 */
+#define FBNIC_CSR_END_MAC_MAC		0x11028 /* CSR section delimiter */
+
+/* Signals from MAC, AN, PCS, and LED CSR registers (ASIC only) */
+#define FBNIC_CSR_START_SIG		0x11800 /* CSR section delimiter */
+#define FBNIC_SIG_MAC_IN0		0x11800		/* 0x46000 */
+#define FBNIC_SIG_MAC_IN0_RESET_FF_TX_CLK	CSR_BIT(14)
+#define FBNIC_SIG_MAC_IN0_RESET_FF_RX_CLK	CSR_BIT(13)
+#define FBNIC_SIG_MAC_IN0_RESET_TX_CLK		CSR_BIT(12)
+#define FBNIC_SIG_MAC_IN0_RESET_RX_CLK		CSR_BIT(11)
+#define FBNIC_SIG_MAC_IN0_TX_CRC		CSR_BIT(8)
+#define FBNIC_SIG_MAC_IN0_CFG_MODE128		CSR_BIT(10)
+#define FBNIC_SIG_PCS_OUT0		0x11808		/* 0x46020 */
+#define FBNIC_SIG_PCS_OUT0_LINK			CSR_BIT(27)
+#define FBNIC_SIG_PCS_OUT0_BLOCK_LOCK		CSR_GENMASK(24, 5)
+#define FBNIC_SIG_PCS_OUT0_AMPS_LOCK		CSR_GENMASK(4, 1)
+#define FBNIC_SIG_PCS_OUT1		0x11809		/* 0x46024 */
+#define FBNIC_SIG_PCS_OUT1_FCFEC_LOCK		CSR_GENMASK(11, 8)
+#define FBNIC_SIG_PCS_INTR_STS		0x11814		/* 0x46050 */
+#define FBNIC_SIG_PCS_INTR_LINK_DOWN		CSR_BIT(1)
+#define FBNIC_SIG_PCS_INTR_LINK_UP		CSR_BIT(0)
+#define FBNIC_SIG_PCS_INTR_MASK		0x11816		/* 0x46058 */
+#define FBNIC_CSR_END_SIG		0x1184e /* CSR section delimiter */
+
 /* PUL User Registers */
 #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 40d314f963ea..c65bca613665 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -104,6 +104,19 @@ enum {
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
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 10377a4a9719..46ad12a15aa0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 
 #include "fbnic.h"
+#include "fbnic_netdev.h"
 #include "fbnic_txrx.h"
 
 static irqreturn_t fbnic_fw_msix_intr(int __always_unused irq, void *data)
@@ -83,6 +84,70 @@ void fbnic_fw_disable_mbx(struct fbnic_dev *fbd)
 	fbnic_mbx_clean(fbd);
 }
 
+static irqreturn_t fbnic_pcs_msix_intr(int __always_unused irq, void *data)
+{
+	struct fbnic_dev *fbd = data;
+	struct fbnic_net *fbn;
+
+	if (fbd->mac->pcs_get_link_event(fbd) == FBNIC_LINK_EVENT_NONE) {
+		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
+			   1u << FBNIC_PCS_MSIX_ENTRY);
+		return IRQ_HANDLED;
+	}
+
+	fbn = netdev_priv(fbd->netdev);
+
+	phylink_pcs_change(&fbn->phylink_pcs, false);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * fbnic_pcs_irq_enable - Configure the MAC to enable it to advertise link
+ * @fbd: Pointer to device to initialize
+ *
+ * This function provides basic bringup for the MAC/PCS IRQ. For now the IRQ
+ * will remain disabled until we start the MAC/PCS/PHY logic via phylink.
+ *
+ * Return: non-zero on failure.
+ **/
+int fbnic_pcs_irq_enable(struct fbnic_dev *fbd)
+{
+	u32 vector = fbd->pcs_msix_vector;
+	int err;
+
+	/* Request the IRQ for MAC link vector.
+	 * Map MAC cause to it, and unmask it
+	 */
+	err = request_irq(vector, &fbnic_pcs_msix_intr, 0,
+			  fbd->netdev->name, fbd);
+	if (err)
+		return err;
+
+	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
+		   FBNIC_PCS_MSIX_ENTRY | FBNIC_INTR_MSIX_CTRL_ENABLE);
+
+	return 0;
+}
+
+/**
+ * fbnic_pcs_irq_disable - Teardown the MAC IRQ to prepare for stopping
+ * @fbd: Pointer to device that is stopping
+ *
+ * This function undoes the work done in fbnic_pcs_irq_enable and prepares
+ * the device to no longer receive traffic on the host interface.
+ **/
+void fbnic_pcs_irq_disable(struct fbnic_dev *fbd)
+{
+	/* Disable interrupt */
+	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
+		   FBNIC_PCS_MSIX_ENTRY);
+	fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(0), 1u << FBNIC_PCS_MSIX_ENTRY);
+
+	/* Free the vector */
+	free_irq(fbd->pcs_msix_vector, fbd);
+}
+
 int fbnic_request_irq(struct fbnic_dev *fbd, int nr, irq_handler_t handler,
 		      unsigned long flags, const char *name, void *data)
 {
@@ -110,6 +175,7 @@ void fbnic_free_irqs(struct fbnic_dev *fbd)
 {
 	struct pci_dev *pdev = to_pci_dev(fbd->dev);
 
+	fbd->pcs_msix_vector = 0;
 	fbd->fw_msix_vector = 0;
 
 	fbd->num_irqs = 0;
@@ -137,6 +203,7 @@ int fbnic_alloc_irqs(struct fbnic_dev *fbd)
 
 	fbd->num_irqs = num_irqs;
 
+	fbd->pcs_msix_vector = pci_irq_vector(pdev, FBNIC_PCS_MSIX_ENTRY);
 	fbd->fw_msix_vector = pci_irq_vector(pdev, FBNIC_FW_MSIX_ENTRY);
 
 	return 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index a6ef898d7eed..770feff7d9cb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -6,6 +6,7 @@
 
 #include "fbnic.h"
 #include "fbnic_mac.h"
+#include "fbnic_netdev.h"
 
 static void fbnic_init_readrq(struct fbnic_dev *fbd, unsigned int offset,
 			      unsigned int cls, unsigned int readrq)
@@ -402,8 +403,248 @@ static void fbnic_mac_init_regs(struct fbnic_dev *fbd)
 	fbnic_mac_init_txb(fbd);
 }
 
+static void fbnic_mac_tx_pause_config(struct fbnic_dev *fbd, bool tx_pause)
+{
+	u32 rxb_pause_ctrl;
+
+	/* Enable generation of pause frames if enabled */
+	rxb_pause_ctrl = rd32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL);
+	rxb_pause_ctrl &= ~FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE;
+	if (tx_pause)
+		rxb_pause_ctrl |=
+			FIELD_PREP(FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE,
+				   FBNIC_PAUSE_EN_MASK);
+	wr32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL, rxb_pause_ctrl);
+}
+
+static int fbnic_pcs_get_link_event_asic(struct fbnic_dev *fbd)
+{
+	u32 pcs_intr_mask = rd32(fbd, FBNIC_SIG_PCS_INTR_STS);
+
+	if (pcs_intr_mask & FBNIC_SIG_PCS_INTR_LINK_DOWN)
+		return FBNIC_LINK_EVENT_DOWN;
+
+	return (pcs_intr_mask & FBNIC_SIG_PCS_INTR_LINK_UP) ?
+	       FBNIC_LINK_EVENT_UP : FBNIC_LINK_EVENT_NONE;
+}
+
+static u32 __fbnic_mac_cmd_config_asic(struct fbnic_dev *fbd,
+				       bool tx_pause, bool rx_pause)
+{
+	/* Enable MAC Promiscuous mode and Tx padding */
+	u32 command_config = FBNIC_MAC_COMMAND_CONFIG_TX_PAD_EN |
+			     FBNIC_MAC_COMMAND_CONFIG_PROMISC_EN;
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+
+	/* Disable pause frames if not enabled */
+	if (!tx_pause)
+		command_config |= FBNIC_MAC_COMMAND_CONFIG_TX_PAUSE_DIS;
+	if (!rx_pause)
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
+	pcs_status = rd32(fbd, FBNIC_SIG_PCS_OUT0);
+	if (!(pcs_status & FBNIC_SIG_PCS_OUT0_LINK))
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
+		lane_mask ^= FIELD_GET(FBNIC_SIG_PCS_OUT0_BLOCK_LOCK,
+				       pcs_status);
+		break;
+	case FBNIC_FEC_RS:
+		lane_mask ^= FIELD_GET(FBNIC_SIG_PCS_OUT0_AMPS_LOCK,
+				       pcs_status);
+		break;
+	case FBNIC_FEC_BASER:
+		lane_mask ^= FIELD_GET(FBNIC_SIG_PCS_OUT1_FCFEC_LOCK,
+				       rd32(fbd, FBNIC_SIG_PCS_OUT1));
+		break;
+	}
+
+	/* If all lanes cancelled then we have a lock on all lanes */
+	return !lane_mask;
+}
+
+static bool fbnic_pcs_get_link_asic(struct fbnic_dev *fbd)
+{
+	bool link;
+
+	/* Flush status bits to clear possible stale data,
+	 * bits should reset themselves back to 1 if link is truly up
+	 */
+	wr32(fbd, FBNIC_SIG_PCS_OUT0, FBNIC_SIG_PCS_OUT0_LINK |
+				      FBNIC_SIG_PCS_OUT0_BLOCK_LOCK |
+				      FBNIC_SIG_PCS_OUT0_AMPS_LOCK);
+	wr32(fbd, FBNIC_SIG_PCS_OUT1, FBNIC_SIG_PCS_OUT1_FCFEC_LOCK);
+	wrfl(fbd);
+
+	/* Clear interrupt state due to recent changes. */
+	wr32(fbd, FBNIC_SIG_PCS_INTR_STS,
+	     FBNIC_SIG_PCS_INTR_LINK_DOWN | FBNIC_SIG_PCS_INTR_LINK_UP);
+
+	link = fbnic_mac_get_pcs_link_status(fbd);
+
+	/* Enable interrupt to only capture changes in link state */
+	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK,
+	     ~FBNIC_SIG_PCS_INTR_LINK_DOWN & ~FBNIC_SIG_PCS_INTR_LINK_UP);
+	fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0), 1u << FBNIC_PCS_MSIX_ENTRY);
+
+	return link;
+}
+
+static void fbnic_pcs_get_fw_settings(struct fbnic_dev *fbd)
+{
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+	u8 link_mode = fbn->link_mode;
+	u8 fec = fbn->fec;
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
+
+		fbn->fec = fec;
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
+	}
+}
+
+static int fbnic_pcs_enable_asic(struct fbnic_dev *fbd)
+{
+	/* Mask and clear the PCS interrupt, will be enabled by link handler */
+	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK, ~0);
+	wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
+
+	/* Pull in settings from FW */
+	fbnic_pcs_get_fw_settings(fbd);
+
+	return 0;
+}
+
+static void fbnic_pcs_disable_asic(struct fbnic_dev *fbd)
+{
+	/* Mask and clear the PCS interrupt */
+	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK, ~0);
+	wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
+}
+
+static void fbnic_mac_link_down_asic(struct fbnic_dev *fbd)
+{
+	u32 cmd_cfg, mac_ctrl;
+
+	cmd_cfg = __fbnic_mac_cmd_config_asic(fbd, false, false);
+	mac_ctrl = rd32(fbd, FBNIC_SIG_MAC_IN0);
+
+	mac_ctrl |= FBNIC_SIG_MAC_IN0_RESET_FF_TX_CLK |
+		    FBNIC_SIG_MAC_IN0_RESET_TX_CLK |
+		    FBNIC_SIG_MAC_IN0_RESET_FF_RX_CLK |
+		    FBNIC_SIG_MAC_IN0_RESET_RX_CLK;
+
+	wr32(fbd, FBNIC_SIG_MAC_IN0, mac_ctrl);
+	wr32(fbd, FBNIC_MAC_COMMAND_CONFIG, cmd_cfg);
+}
+
+static void fbnic_mac_link_up_asic(struct fbnic_dev *fbd,
+				   bool tx_pause, bool rx_pause)
+{
+	u32 cmd_cfg, mac_ctrl;
+
+	fbnic_mac_tx_pause_config(fbd, tx_pause);
+
+	cmd_cfg = __fbnic_mac_cmd_config_asic(fbd, tx_pause, rx_pause);
+	mac_ctrl = rd32(fbd, FBNIC_SIG_MAC_IN0);
+
+	mac_ctrl &= ~(FBNIC_SIG_MAC_IN0_RESET_FF_TX_CLK |
+		      FBNIC_SIG_MAC_IN0_RESET_TX_CLK |
+		      FBNIC_SIG_MAC_IN0_RESET_FF_RX_CLK |
+		      FBNIC_SIG_MAC_IN0_RESET_RX_CLK);
+	cmd_cfg |= FBNIC_MAC_COMMAND_CONFIG_RX_ENA |
+		   FBNIC_MAC_COMMAND_CONFIG_TX_ENA;
+
+	wr32(fbd, FBNIC_SIG_MAC_IN0, mac_ctrl);
+	wr32(fbd, FBNIC_MAC_COMMAND_CONFIG, cmd_cfg);
+}
+
 static const struct fbnic_mac fbnic_mac_asic = {
 	.init_regs = fbnic_mac_init_regs,
+	.pcs_enable = fbnic_pcs_enable_asic,
+	.pcs_disable = fbnic_pcs_disable_asic,
+	.pcs_get_link = fbnic_pcs_get_link_asic,
+	.pcs_get_link_event = fbnic_pcs_get_link_event_asic,
+	.link_down = fbnic_mac_link_down_asic,
+	.link_up = fbnic_mac_link_up_asic,
 };
 
 /**
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index e78a92338a62..f53be6e6aef9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -10,15 +10,76 @@ struct fbnic_dev;
 
 #define FBNIC_MAX_JUMBO_FRAME_SIZE	9742
 
+enum {
+	FBNIC_LINK_EVENT_NONE	= 0,
+	FBNIC_LINK_EVENT_UP	= 1,
+	FBNIC_LINK_EVENT_DOWN	= 2,
+};
+
+/* Treat the FEC bits as a bitmask laid out as follows:
+ * Bit 0: RS Enabled
+ * Bit 1: BASER(Firecode) Enabled
+ * Bit 2: Retrieve FEC from FW
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
+/* Treat the link modes as a set of modulation/lanes bitmask:
+ * Bit 0: Lane Count, 0 = R1, 1 = R2
+ * Bit 1: Modulation, 0 = NRZ, 1 = PAM4
+ * Bit 2: Retrieve link mode from FW
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
  * void (*init_regs)(struct fbnic_dev *fbd);
  *	Initialize MAC registers to enable Tx/Rx paths and FIFOs.
+ *
+ * void (*pcs_enable)(struct fbnic_dev *fbd);
+ *	Configure and enable PCS to enable link if not already enabled
+ * void (*pcs_disable)(struct fbnic_dev *fbd);
+ *	Shutdown the link if we are the only consumer of it.
+ * bool (*pcs_get_link)(struct fbnic_dev *fbd);
+ *	Check PCS link status
+ * int (*pcs_get_link_event)(struct fbnic_dev *fbd)
+ *	Get the current link event status, reports true if link has
+ *	changed to either FBNIC_LINK_EVENT_DOWN or FBNIC_LINK_EVENT_UP
+ *
+ * void (*link_down)(struct fbnic_dev *fbd);
+ *	Configure MAC for link down event
+ * void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_pause);
+ *	Configure MAC for link up event;
+ *
  */
 struct fbnic_mac {
 	void (*init_regs)(struct fbnic_dev *fbd);
+
+	int (*pcs_enable)(struct fbnic_dev *fbd);
+	void (*pcs_disable)(struct fbnic_dev *fbd);
+	bool (*pcs_get_link)(struct fbnic_dev *fbd);
+	int (*pcs_get_link_event)(struct fbnic_dev *fbd);
+
+	void (*link_down)(struct fbnic_dev *fbd);
+	void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_pause);
 };
 
 int fbnic_mac_init(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 0dd955c7c7ff..18953a2d1eef 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -45,6 +45,10 @@ int __fbnic_open(struct fbnic_net *fbn)
 	if (err)
 		goto release_ownership;
 
+	err = fbnic_pcs_irq_enable(fbd);
+	if (err)
+		goto release_ownership;
+
 	return 0;
 release_ownership:
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
@@ -72,6 +76,7 @@ static int fbnic_stop(struct net_device *netdev)
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
 	fbnic_down(fbn);
+	fbnic_pcs_irq_disable(fbn->fbd);
 
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
 
@@ -114,6 +119,11 @@ void fbnic_reset_queues(struct fbnic_net *fbn,
  **/
 void fbnic_netdev_free(struct fbnic_dev *fbd)
 {
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+
+	if (fbn->phylink)
+		phylink_destroy(fbn->phylink);
+
 	free_netdev(fbd->netdev);
 	fbd->netdev = NULL;
 }
@@ -162,10 +172,22 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
 
+	/* TBD: This is workaround for BMC as phylink doesn't have support
+	 * for leavling the link enabled if a BMC is present.
+	 */
+	netdev->ethtool->wol_enabled = true;
+
+	fbn->fec = FBNIC_FEC_AUTO | FBNIC_FEC_RS;
+	fbn->link_mode = FBNIC_LINK_AUTO | FBNIC_LINK_50R2;
 	netif_carrier_off(netdev);
 
 	netif_tx_stop_all_queues(netdev);
 
+	if (fbnic_phylink_init(netdev)) {
+		fbnic_netdev_free(fbd);
+		return NULL;
+	}
+
 	return netdev;
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 18f93e9431cc..faf75e6359ba 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -5,6 +5,7 @@
 #define _FBNIC_NETDEV_H_
 
 #include <linux/types.h>
+#include <linux/phylink.h>
 
 #include "fbnic_txrx.h"
 
@@ -22,9 +23,18 @@ struct fbnic_net {
 
 	u16 num_napi;
 
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
+	struct phylink_pcs phylink_pcs;
+
+	/* TBD: Remove these when phylink supports FEC and lane config */
+	u8 fec;
+	u8 link_mode;
+
 	u16 num_tx_queues;
 	u16 num_rx_queues;
 
+	u64 link_down_events;
 	struct list_head napis;
 };
 
@@ -39,4 +49,5 @@ void fbnic_netdev_unregister(struct net_device *netdev);
 void fbnic_reset_queues(struct fbnic_net *fbn,
 			unsigned int tx, unsigned int rx);
 
+int fbnic_phylink_init(struct net_device *netdev);
 #endif /* _FBNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 9eda65e04609..040aaa127500 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -116,12 +116,14 @@ static void fbnic_service_task_start(struct fbnic_net *fbn)
 	struct fbnic_dev *fbd = fbn->fbd;
 
 	schedule_delayed_work(&fbd->service_task, HZ);
+	phylink_resume(fbn->phylink);
 }
 
 static void fbnic_service_task_stop(struct fbnic_net *fbn)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
 
+	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbd));
 	cancel_delayed_work(&fbd->service_task);
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
new file mode 100644
index 000000000000..1a5e1e719b30
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/phy.h>
+#include <linux/phylink.h>
+
+#include "fbnic.h"
+#include "fbnic_mac.h"
+#include "fbnic_netdev.h"
+
+static struct fbnic_net *
+fbnic_pcs_to_net(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct fbnic_net, phylink_pcs);
+}
+
+static void
+fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs,
+			    struct phylink_link_state *state)
+{
+	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	/* For now we use hard-coded defaults and FW config to determine
+	 * the current values. In future patches we will add support for
+	 * reconfiguring these values and changing link settings.
+	 */
+	switch (fbd->fw_cap.link_speed) {
+	case FBNIC_FW_LINK_SPEED_25R1:
+		state->speed = SPEED_25000;
+		break;
+	case FBNIC_FW_LINK_SPEED_50R2:
+		state->speed = SPEED_50000;
+		break;
+	case FBNIC_FW_LINK_SPEED_100R2:
+		state->speed = SPEED_100000;
+		break;
+	default:
+		state->speed = SPEED_UNKNOWN;
+		break;
+	}
+
+	state->duplex = DUPLEX_FULL;
+
+	state->link = fbd->mac->pcs_get_link(fbd);
+}
+
+static int
+fbnic_phylink_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	return fbd->mac->pcs_enable(fbd);
+}
+
+static void
+fbnic_phylink_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	return fbd->mac->pcs_disable(fbd);
+}
+
+static int
+fbnic_phylink_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			 phy_interface_t interface,
+			 const unsigned long *advertising,
+			 bool permit_pause_to_mac)
+{
+	return 0;
+}
+
+static const struct phylink_pcs_ops fbnic_phylink_pcs_ops = {
+	.pcs_config = fbnic_phylink_pcs_config,
+	.pcs_enable = fbnic_phylink_pcs_enable,
+	.pcs_disable = fbnic_phylink_pcs_disable,
+	.pcs_get_state = fbnic_phylink_pcs_get_state,
+};
+
+static struct phylink_pcs *
+fbnic_phylink_mac_select_pcs(struct phylink_config *config,
+			     phy_interface_t interface)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	return &fbn->phylink_pcs;
+}
+
+static void
+fbnic_phylink_mac_config(struct phylink_config *config, unsigned int mode,
+			 const struct phylink_link_state *state)
+{
+}
+
+static void
+fbnic_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
+			    phy_interface_t interface)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	fbd->mac->link_down(fbd);
+
+	fbn->link_down_events++;
+}
+
+static void
+fbnic_phylink_mac_link_up(struct phylink_config *config,
+			  struct phy_device *phy, unsigned int mode,
+			  phy_interface_t interface, int speed, int duplex,
+			  bool tx_pause, bool rx_pause)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	fbd->mac->link_up(fbd, tx_pause, rx_pause);
+}
+
+static const struct phylink_mac_ops fbnic_phylink_mac_ops = {
+	.mac_select_pcs = fbnic_phylink_mac_select_pcs,
+	.mac_config = fbnic_phylink_mac_config,
+	.mac_link_down = fbnic_phylink_mac_link_down,
+	.mac_link_up = fbnic_phylink_mac_link_up,
+};
+
+int fbnic_phylink_init(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct phylink *phylink;
+
+	fbn->phylink_pcs.neg_mode = true;
+	fbn->phylink_pcs.ops = &fbnic_phylink_pcs_ops;
+
+	fbn->phylink_config.dev = &netdev->dev;
+	fbn->phylink_config.type = PHYLINK_NETDEV;
+	fbn->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
+					       MAC_10000FD | MAC_25000FD |
+					       MAC_40000FD | MAC_50000FD |
+					       MAC_100000FD;
+	fbn->phylink_config.default_an_inband = true;
+
+	__set_bit(PHY_INTERFACE_MODE_XGMII,
+		  fbn->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_XLGMII,
+		  fbn->phylink_config.supported_interfaces);
+
+	phylink = phylink_create(&fbn->phylink_config, NULL,
+				 PHY_INTERFACE_MODE_XLGMII,
+				 &fbnic_phylink_mac_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	fbn->phylink = phylink;
+
+	return 0;
+}



