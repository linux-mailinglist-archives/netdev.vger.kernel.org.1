Return-Path: <netdev+bounces-106532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EFD916A9D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CA21F28175
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BD516C696;
	Tue, 25 Jun 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtV339xZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327A16EBF3
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326182; cv=none; b=bTrOgS0TaNScb0i5qJgYHljLpXQAsNQvL31QaohTDujJDdj/YQyk1LuJQDDwAHbc+dE3fExiHVZa/P9NYUbY7D2cv2GLD1c5eqYLnqeQszmPtUpu6zdbY+aMV5v4G9XRjN7ThQOr0v8Hcsbijhi4aP0XlasFwsP7nap0if4O1RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326182; c=relaxed/simple;
	bh=Qu4ulbnz1GKsfzgbwr1AENk4nJoCQ7e9V2okn0cY8v0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOnbckOAuzWwP8ODregORUra9RE6BsLmgzBcoQD1PNw0FanRk9h1kzhUYlRDIOe9lTbuhGv0z4mxgZzrUp6cEN43d/YhSWPojvjB7cEFQ/SmOI+JL/Gpm9Ym3M/CyTuLc5kDFsnfHO8LxOO6NR7xY3ASyqkVjG1C5k9W7M7WlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtV339xZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fa244db0b2so21294945ad.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326180; x=1719930980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WC1aNR13PMiTSRcf2SphOEFUYms90cj0S/JNRlQuCe4=;
        b=jtV339xZmWK6ZKFAYZ6bW9cd1zO053wQpHN/MA4o6+UOz27jbOeACcw1+YT8m6Rc2W
         v7+2SX8rX1cr2RLa9ryriZEFuYgzaMIMgQIHfI7fyp9LM7GK5vV4UJHG+IspqgE3NqX6
         upoVz+VPBNP4N7GK0SMEobql9Pk9lFDiJFNZlB12j85keOC6QbIY+eAR2FANpgBwuZLS
         g0AbjDE5JEWXbH1qUVHA6Egm54n3LB/334t6RbEG7qV3BYms3Dds0GXyhQkbXHqYqVQH
         II9rtEc98lJ36/ug15rMKAZ6utx83girFlYW9SxMxU1i66xynbNDBnU2obUHs2oBnkkK
         B6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326180; x=1719930980;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WC1aNR13PMiTSRcf2SphOEFUYms90cj0S/JNRlQuCe4=;
        b=YyjsZJG/TRV13DDt+2ah8gwkm5Exuvo/sgT61xkcabdbPzgS1PFkkRoeOmAmbpSRlM
         GUEPj65dGk2YEYfqKNBmINvVzBKcGmdt6fgZz0myXjCR3ql576dG7RRYrYXD2HNRYSuZ
         1XKRPcsHIt1BhbqEfUZdgnseiCS+0Mj2NTLvcwJ8qDI2PBkHVLFVpvzZg1C4kJpvOaAe
         q8YsQv3ShdYRN7DqzNu32Ss2INtMq5rl6iUyiqEBShDny4FO5wJGm/eVUua/q1Eq6IES
         hvCvkPvy3QX6rtyHDtPjrLELKeePzceg6EEFm73wRXFvbTrz6XimdfEEiQMQw2b6TBDt
         UHRA==
X-Gm-Message-State: AOJu0YzITljc7204p2noRQxaJ84eRA2XtRW5+Fq5eVq0x6JFbRmdjSkz
	Ltkn6f6dXEkup8CooWEAYPxYPqpR7uUe+4Db5dCFWysattJtrR3i
X-Google-Smtp-Source: AGHT+IENZxY1ev6AvghJQBj+7GQr3icd6ceqvR9HTpq5MOESbw8C4nuLR4nIc2IFkPEppgCy67qoGA==
X-Received: by 2002:a17:902:e742:b0:1f9:fca9:742a with SMTP id d9443c01a7336-1fa15943472mr111599195ad.57.1719326179763;
        Tue, 25 Jun 2024 07:36:19 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f028asm82452705ad.3.2024.06.25.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:36:19 -0700 (PDT)
Subject: [net-next PATCH v2 11/15] eth: fbnic: Add link detection
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexander Duyck <alexanderduyck@fb.com>,
 kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:36:18 -0700
Message-ID: 
 <171932617837.3072535.9872136934270317593.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
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

CC: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/Kconfig               |    1 
 drivers/net/ethernet/meta/fbnic/Makefile        |    1 
 drivers/net/ethernet/meta/fbnic/fbnic.h         |   12 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h     |   39 +++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h      |   13 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |   83 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |  269 +++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |   61 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |   22 ++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |   13 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |  159 ++++++++++++++
 11 files changed, 673 insertions(+)
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
index 44fe6bbf88a1..2be7e5f8e6e2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -21,6 +21,7 @@ struct fbnic_dev {
 	u32 __iomem *uc_addr4;
 	const struct fbnic_mac *mac;
 	unsigned int fw_msix_vector;
+	unsigned int mac_msix_vector;
 	unsigned short num_irqs;
 
 	struct delayed_work service_task;
@@ -38,6 +39,13 @@ struct fbnic_dev {
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
@@ -49,6 +57,7 @@ struct fbnic_dev {
  */
 enum {
 	FBNIC_FW_MSIX_ENTRY,
+	FBNIC_MAC_MSIX_ENTRY,
 	FBNIC_NON_NAPI_VECTORS
 };
 
@@ -110,6 +119,9 @@ void fbnic_devlink_unregister(struct fbnic_dev *fbd);
 int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
 void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);
 
+int fbnic_mac_enable(struct fbnic_dev *fbd);
+void fbnic_mac_disable(struct fbnic_dev *fbd);
+
 int fbnic_request_irq(struct fbnic_dev *dev, int nr, irq_handler_t handler,
 		      unsigned long flags, const char *name, void *data);
 void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index d7b895619ba7..a48ab12db2c0 100644
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
index 10377a4a9719..73d535640262 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 
 #include "fbnic.h"
+#include "fbnic_netdev.h"
 #include "fbnic_txrx.h"
 
 static irqreturn_t fbnic_fw_msix_intr(int __always_unused irq, void *data)
@@ -83,6 +84,86 @@ void fbnic_fw_disable_mbx(struct fbnic_dev *fbd)
 	fbnic_mbx_clean(fbd);
 }
 
+static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
+{
+	struct fbnic_dev *fbd = data;
+	struct fbnic_net *fbn;
+
+	if (!fbd->mac->get_link_event(fbd)) {
+		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
+			   1u << FBNIC_MAC_MSIX_ENTRY);
+		return IRQ_HANDLED;
+	}
+
+	fbd->link_state = FBNIC_LINK_EVENT;
+	fbn = netdev_priv(fbd->netdev);
+
+	phylink_mac_change(fbn->phylink, fbd->link_state == FBNIC_LINK_UP);
+
+	return IRQ_HANDLED;
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
+ *
+ * Return: non-zero on failure.
+ **/
+int fbnic_mac_enable(struct fbnic_dev *fbd)
+{
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
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
+	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
+		   FBNIC_MAC_MSIX_ENTRY | FBNIC_INTR_MSIX_CTRL_ENABLE);
+
+	phylink_start(fbn->phylink);
+
+	fbnic_wr32(fbd, FBNIC_INTR_SET(0), 1u << FBNIC_MAC_MSIX_ENTRY);
+
+	return 0;
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
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+
+	/* Nothing to do if link is already disabled */
+	if (fbd->link_state == FBNIC_LINK_DISABLED)
+		return;
+
+	phylink_stop(fbn->phylink);
+
+	/* Disable interrupt */
+	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
+		   FBNIC_MAC_MSIX_ENTRY);
+	fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(0), 1u << FBNIC_MAC_MSIX_ENTRY);
+
+	/* Free the vector */
+	free_irq(fbd->mac_msix_vector, fbd);
+}
+
 int fbnic_request_irq(struct fbnic_dev *fbd, int nr, irq_handler_t handler,
 		      unsigned long flags, const char *name, void *data)
 {
@@ -110,6 +191,7 @@ void fbnic_free_irqs(struct fbnic_dev *fbd)
 {
 	struct pci_dev *pdev = to_pci_dev(fbd->dev);
 
+	fbd->mac_msix_vector = 0;
 	fbd->fw_msix_vector = 0;
 
 	fbd->num_irqs = 0;
@@ -137,6 +219,7 @@ int fbnic_alloc_irqs(struct fbnic_dev *fbd)
 
 	fbd->num_irqs = num_irqs;
 
+	fbd->mac_msix_vector = pci_irq_vector(pdev, FBNIC_MAC_MSIX_ENTRY);
 	fbd->fw_msix_vector = pci_irq_vector(pdev, FBNIC_FW_MSIX_ENTRY);
 
 	return 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index a6ef898d7eed..bbbc618b15c0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -6,6 +6,7 @@
 
 #include "fbnic.h"
 #include "fbnic_mac.h"
+#include "fbnic_netdev.h"
 
 static void fbnic_init_readrq(struct fbnic_dev *fbd, unsigned int offset,
 			      unsigned int cls, unsigned int readrq)
@@ -402,8 +403,276 @@ static void fbnic_mac_init_regs(struct fbnic_dev *fbd)
 	fbnic_mac_init_txb(fbd);
 }
 
+static int fbnic_mac_get_link_event_asic(struct fbnic_dev *fbd)
+{
+	u32 pcs_intr_mask = rd32(fbd, FBNIC_SIG_PCS_INTR_STS);
+
+	if (pcs_intr_mask & FBNIC_SIG_PCS_INTR_LINK_DOWN)
+		return -1;
+
+	return (pcs_intr_mask & FBNIC_SIG_PCS_INTR_LINK_UP) ? 1 : 0;
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
+	wr32(fbd, FBNIC_MAC_CL01_PAUSE_QUANTA, 0xffff);
+	wr32(fbd, FBNIC_MAC_CL01_QUANTA_THRESH, 0x7fff);
+
+	/* Enable generation of pause frames if enabled */
+	rxb_pause_ctrl = rd32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL);
+	rxb_pause_ctrl &= ~FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE;
+	if (!fbn->tx_pause)
+		command_config |= FBNIC_MAC_COMMAND_CONFIG_TX_PAUSE_DIS;
+	else
+		rxb_pause_ctrl |=
+			FIELD_PREP(FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE,
+				   FBNIC_PAUSE_EN_MASK);
+	wr32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL, rxb_pause_ctrl);
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
+	int link_direction;
+	bool link;
+
+	/* If disabled do not update link_state nor change settings */
+	if (fbd->link_state == FBNIC_LINK_DISABLED)
+		return false;
+
+	/* In an interrupt driven setup we can just skip the check if
+	 * the link is up as the interrupt should toggle it to the EVENT
+	 * state if the link has changed state at any time since the last
+	 * check.
+	 */
+	if (fbd->link_state == FBNIC_LINK_UP)
+		return true;
+
+	link_direction = fbnic_mac_get_link_event_asic(fbd);
+
+	/* Clear interrupt state due to recent changes. */
+	wr32(fbd, FBNIC_SIG_PCS_INTR_STS,
+	     FBNIC_SIG_PCS_INTR_LINK_DOWN | FBNIC_SIG_PCS_INTR_LINK_UP);
+
+	/* If link bounced down clear the PCS_STS bit related to link */
+	if (link_direction < 0) {
+		wr32(fbd, FBNIC_SIG_PCS_OUT0, FBNIC_SIG_PCS_OUT0_LINK |
+					 FBNIC_SIG_PCS_OUT0_BLOCK_LOCK |
+					 FBNIC_SIG_PCS_OUT0_AMPS_LOCK);
+		wr32(fbd, FBNIC_SIG_PCS_OUT1, FBNIC_SIG_PCS_OUT1_FCFEC_LOCK);
+	}
+
+	link = fbnic_mac_get_pcs_link_status(fbd);
+
+	if (link_direction)
+		wr32(fbd, FBNIC_SIG_PCS_INTR_MASK,
+		     link ?  ~FBNIC_SIG_PCS_INTR_LINK_DOWN :
+			     ~FBNIC_SIG_PCS_INTR_LINK_UP);
+
+	fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0), 1u << FBNIC_MAC_MSIX_ENTRY);
+
+	return link;
+}
+
+static void fbnic_pcs_get_fw_settings(struct fbnic_dev *fbd)
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
+static int fbnic_pcs_enable_asic(struct fbnic_dev *fbd)
+{
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+
+	/* Mask and clear the PCS interrupt, will be enabled by link handler */
+	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK, ~0);
+	wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
+
+	/* Pull in settings from FW */
+	fbnic_pcs_get_fw_settings(fbd);
+
+	/* Flush any stale link status info */
+	wr32(fbd, FBNIC_SIG_PCS_OUT0, FBNIC_SIG_PCS_OUT0_LINK |
+				 FBNIC_SIG_PCS_OUT0_BLOCK_LOCK |
+				 FBNIC_SIG_PCS_OUT0_AMPS_LOCK);
+
+	/* Report starting state as "Link Event" to force detection of link */
+	fbd->link_state = FBNIC_LINK_EVENT;
+
+	fbn->link_mode &= ~FBNIC_LINK_AUTO;
+
+	return 0;
+}
+
+static void fbnic_pcs_disable_asic(struct fbnic_dev *fbd)
+{
+	/* Clear link state to disable any further transitions */
+	fbd->link_state = FBNIC_LINK_DISABLED;
+}
+
+static void fbnic_mac_link_down_asic(struct fbnic_dev *fbd)
+{
+	u32 cmd_cfg, mac_ctrl;
+
+	if (fbd->link_state == FBNIC_LINK_DOWN)
+		return;
+
+	cmd_cfg = __fbnic_mac_config_asic(fbd);
+	mac_ctrl = rd32(fbd, FBNIC_SIG_MAC_IN0);
+
+	mac_ctrl |= FBNIC_SIG_MAC_IN0_RESET_FF_TX_CLK |
+		    FBNIC_SIG_MAC_IN0_RESET_TX_CLK |
+		    FBNIC_SIG_MAC_IN0_RESET_FF_RX_CLK |
+		    FBNIC_SIG_MAC_IN0_RESET_RX_CLK;
+	fbd->link_state = FBNIC_LINK_DOWN;
+
+	wr32(fbd, FBNIC_SIG_MAC_IN0, mac_ctrl);
+	wr32(fbd, FBNIC_MAC_COMMAND_CONFIG, cmd_cfg);
+}
+
+static void fbnic_mac_link_up_asic(struct fbnic_dev *fbd)
+{
+	u32 cmd_cfg, mac_ctrl;
+
+	if (fbd->link_state == FBNIC_LINK_UP)
+		return;
+
+	cmd_cfg = __fbnic_mac_config_asic(fbd);
+	mac_ctrl = rd32(fbd, FBNIC_SIG_MAC_IN0);
+
+	mac_ctrl &= ~(FBNIC_SIG_MAC_IN0_RESET_FF_TX_CLK |
+		      FBNIC_SIG_MAC_IN0_RESET_TX_CLK |
+		      FBNIC_SIG_MAC_IN0_RESET_FF_RX_CLK |
+		      FBNIC_SIG_MAC_IN0_RESET_RX_CLK);
+	cmd_cfg |= FBNIC_MAC_COMMAND_CONFIG_RX_ENA |
+		   FBNIC_MAC_COMMAND_CONFIG_TX_ENA;
+	fbd->link_state = FBNIC_LINK_UP;
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
+	.link_down = fbnic_mac_link_down_asic,
+	.link_up = fbnic_mac_link_up_asic,
+	.get_link_event = fbnic_mac_get_link_event_asic,
 };
 
 /**
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index e78a92338a62..48bb74bd6f72 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -10,15 +10,76 @@ struct fbnic_dev;
 
 #define FBNIC_MAX_JUMBO_FRAME_SIZE	9742
 
+enum {
+	FBNIC_LINK_DISABLED	= 0,
+	FBNIC_LINK_DOWN		= 1,
+	FBNIC_LINK_UP		= 2,
+	FBNIC_LINK_EVENT	= 3,
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
+ * int (*get_link_event)(struct fbnic_dev *fbd)
+ *	Get the current link event status, reports true if link has
+ *	changed to either up (1) or down (-1).
  * void (*init_regs)(struct fbnic_dev *fbd);
  *	Initialize MAC registers to enable Tx/Rx paths and FIFOs.
+ *
+ * void (*pcs_enable)(struct fbnic_dev *fbd);
+ *	Configure and enable PCS to enable link if not already enabled
+ * void (*pcs_disable)(struct fbnic_dev *fbd);
+ *	Shutdown the link if we are the only consumer of it.
+ * bool (*pcs_get_link)(struct fbnic_dev *fbd);
+ *	Check PCS link status
+ * void (*link_down)(struct fbnic_dev *fbd);
+ *	Configure MAC for link down event
+ * void (*link_up)(struct fbnic_dev *fbd);
+ *	Configure MAC for link up event;
+ *
  */
 struct fbnic_mac {
+	int (*get_link_event)(struct fbnic_dev *fbd);
 	void (*init_regs)(struct fbnic_dev *fbd);
+
+	int (*pcs_enable)(struct fbnic_dev *fbd);
+	void (*pcs_disable)(struct fbnic_dev *fbd);
+	bool (*pcs_get_link)(struct fbnic_dev *fbd);
+
+	void (*link_down)(struct fbnic_dev *fbd);
+	void (*link_up)(struct fbnic_dev *fbd);
 };
 
 int fbnic_mac_init(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 4a4691a3115b..2963cdca1327 100644
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
@@ -160,10 +170,22 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
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
 
+	if (fbnic_phylink_init(netdev)) {
+		fbnic_netdev_free(fbd);
+		return NULL;
+	}
+
 	return netdev;
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 18f93e9431cc..5731197d1636 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -5,6 +5,7 @@
 #define _FBNIC_NETDEV_H_
 
 #include <linux/types.h>
+#include <linux/phylink.h>
 
 #include "fbnic_txrx.h"
 
@@ -22,9 +23,20 @@ struct fbnic_net {
 
 	u16 num_napi;
 
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
+	struct phylink_pcs phylink_pcs;
+
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
 
@@ -39,4 +51,5 @@ void fbnic_netdev_unregister(struct net_device *netdev);
 void fbnic_reset_queues(struct fbnic_net *fbn,
 			unsigned int tx, unsigned int rx);
 
+int fbnic_phylink_init(struct net_device *netdev);
 #endif /* _FBNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
new file mode 100644
index 000000000000..1fe4a5371f05
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -0,0 +1,159 @@
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
+	switch (fbn->link_mode & FBNIC_LINK_MODE_MASK) {
+	case FBNIC_LINK_25R1:
+		state->speed = SPEED_25000;
+		break;
+	case FBNIC_LINK_50R2:
+	case FBNIC_LINK_50R1:
+		state->speed = SPEED_50000;
+		break;
+	case FBNIC_LINK_100R2:
+		state->speed = SPEED_100000;
+		break;
+	}
+
+	if (fbn->tx_pause)
+		state->pause |= MLO_PAUSE_TX;
+	if (fbn->rx_pause)
+		state->pause |= MLO_PAUSE_RX;
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
+	fbd->mac->link_up(fbd);
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



