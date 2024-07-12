Return-Path: <netdev+bounces-111106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAF292FDDF
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83ABA1C23593
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFCD172BD9;
	Fri, 12 Jul 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHUBky7q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838557407B
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799384; cv=none; b=NhjaoAfccRxFsWDLWpn2wpZqA5EM2Rx0/knp7ujgEIFJAWHthB6tA811hMkhh8ZZV7YCNxvJpWP9ehe0vJB6QRegceOwsUxBY3f+WcoCYVzmFoCrCcZLjDZ+7zy+ieTAIPnotp3dCsp+Eg/FSSWzMD+ZnaFEKENlOCgYgqRjQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799384; c=relaxed/simple;
	bh=udRYF075v0FIO8FQ29XY1XZZASK40tOoNqYkC0UsAYY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnXf6jc6jCB3IN2+fPOjYDM3vn5+D/rSf+vGgvY/AO2FuwrMczyW3KqlVnYcRW9L9CkVmS7NxbVNXG9IvPahhvxIml/ZUChMh1S40n/43Eo/sxmZY2hN4lwITqvV0AY8i/t6keacZBxqJ3/yA05YSH3QFXN+udxyciKxW6Wyxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHUBky7q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb4fa1bb34so14434265ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720799381; x=1721404181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Qxtbt4n+TmH8cr4c+3KARZVCh/3AM6E3P0PRxkwjd4=;
        b=dHUBky7q2OIxTzd4GpY67zmgEMdoYa6Ienc3OGOWzlocrmbVHSh1/pQwCgRbidH+mW
         mObN9eP+VixFBQVabHaNq+JvpSNHYU0UNhuel3Sb4Xl06oPBcuDqUjGRD3+DvfELVCUc
         iJSKMo9HJrC1PRYAE8IO1V79xLQNGQthg5sQ8lavCRT/wi+AXNgSfr+nvHR6L7F5HX81
         DGLOpcSgOLrox09dUpR2Q9T2HO8dVYN1arhoDaIwxkeSoidg9om699tenPLeE4xxqgLV
         U8e0CH6iO1p3oafb7jKEzawqCp6xDB9SlOpO2a3YTqQHMAHJdiHgwd+cSbrF1vK9XzHx
         Xvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720799381; x=1721404181;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Qxtbt4n+TmH8cr4c+3KARZVCh/3AM6E3P0PRxkwjd4=;
        b=EZTaxBJWaSj59TYK5Eg++wkwcRE1nKpcRAapNmjJrQrU4oirnDLVkrXKRguILzbNb0
         8HwjpwdiAtWfjlva43kjHyVGd+DBj7zffCtA641y1kgCPKLYWcO7J4OQpYF485bwl63w
         gTu1uF/KoNu8AK/CEvwwzz/T1MtHNOgCSMbqHV797bIRqVSVcaEMHuz9aJBKr2qX7PSk
         223jpNkv94jjcCqyV7HEnUhmmz2Y68s3TYQzfxeRwit5b3M8hpvFBhppkxkYJ+wPGdds
         cmpGXHxf/YG/hBkgPdXQa4sLmFbFpMmqk9OkRzRU5nL1RQ2tS4ru211kP4HhlwR7/cxB
         AoUg==
X-Gm-Message-State: AOJu0Yz2ClOv1DW8ELQsXuqdq6peVa9kKtwVGNi0cbIGNbA3aL+tK51j
	dZNGaGf8RzISch9hozLS9l8wMgZNe1D82WzwKqWpVgG8iMUghCVvwQ/ELA==
X-Google-Smtp-Source: AGHT+IGvce4fjsPNDn1GyV5Xq12JrpC7doqHXqT0XvzI+K3Nlg4wDvNfKGPO0bLtg04tun80sftT9w==
X-Received: by 2002:a17:902:dacb:b0:1fb:80b9:fb8d with SMTP id d9443c01a7336-1fbb6d66824mr101645325ad.56.1720799372594;
        Fri, 12 Jul 2024 08:49:32 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac9733sm68700705ad.249.2024.07.12.08.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 08:49:32 -0700 (PDT)
Subject: [net-next PATCH v5 06/15] eth: fbnic: Add FW communication mechanism
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 kernel-team@meta.com
Date: Fri, 12 Jul 2024 08:49:31 -0700
Message-ID: 
 <172079937113.1778861.10669864213768701947.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
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

Add a mechanism for sending messages to and receiving messages
from the FW. The FW has fairly limited functionality, so the
mechanism doesn't have to support high message rate.

Use device mailbox registers to form two rings, one "to" and
one "from" the device. The rings are just a convention between
driver and FW, not a HW construct. We don't expect messages
larger than 4k so use page-sized buffers.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile    |    1 
 drivers/net/ethernet/meta/fbnic/fbnic.h     |   18 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h |   79 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |  380 +++++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |   26 ++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c |   78 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c |   59 ++++
 7 files changed, 641 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw.h

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index 0434ee0b3069..7b63cd5b09d4 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -8,6 +8,7 @@
 obj-$(CONFIG_FBNIC) += fbnic.o
 
 fbnic-y := fbnic_devlink.o \
+	   fbnic_fw.o \
 	   fbnic_irq.o \
 	   fbnic_mac.o \
 	   fbnic_pci.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index af863dfabd82..42e2744cfe10 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -7,6 +7,7 @@
 #include <linux/io.h>
 
 #include "fbnic_csr.h"
+#include "fbnic_fw.h"
 #include "fbnic_mac.h"
 
 struct fbnic_dev {
@@ -15,8 +16,13 @@ struct fbnic_dev {
 	u32 __iomem *uc_addr0;
 	u32 __iomem *uc_addr4;
 	const struct fbnic_mac *mac;
+	unsigned int fw_msix_vector;
 	unsigned short num_irqs;
 
+	struct fbnic_fw_mbx mbx[FBNIC_IPC_MBX_INDICES];
+	/* Lock protecting Tx Mailbox queue to prevent possible races */
+	spinlock_t fw_tx_lock;
+
 	u64 dsn;
 	u32 mps;
 	u32 readrq;
@@ -28,6 +34,7 @@ struct fbnic_dev {
  * causes later.
  */
 enum {
+	FBNIC_FW_MSIX_ENTRY,
 	FBNIC_NON_NAPI_VECTORS
 };
 
@@ -66,6 +73,14 @@ fbnic_rmw32(struct fbnic_dev *fbd, u32 reg, u32 mask, u32 val)
 #define rd32(_f, _r)		fbnic_rd32(_f, _r)
 #define wrfl(_f)		fbnic_wrfl(_f)
 
+bool fbnic_fw_present(struct fbnic_dev *fbd);
+u32 fbnic_fw_rd32(struct fbnic_dev *fbd, u32 reg);
+void fbnic_fw_wr32(struct fbnic_dev *fbd, u32 reg, u32 val);
+
+#define fw_rd32(_f, _r)		fbnic_fw_rd32(_f, _r)
+#define fw_wr32(_f, _r, _v)	fbnic_fw_wr32(_f, _r, _v)
+#define fw_wrfl(_f)		fbnic_fw_rd32(_f, FBNIC_FW_ZERO_REG)
+
 extern char fbnic_driver_name[];
 
 void fbnic_devlink_free(struct fbnic_dev *fbd);
@@ -73,6 +88,9 @@ struct fbnic_dev *fbnic_devlink_alloc(struct pci_dev *pdev);
 void fbnic_devlink_register(struct fbnic_dev *fbd);
 void fbnic_devlink_unregister(struct fbnic_dev *fbd);
 
+int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
+void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);
+
 void fbnic_free_irqs(struct fbnic_dev *fbd);
 int fbnic_alloc_irqs(struct fbnic_dev *fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 56a8bbd8b720..47a5321b68a7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -9,10 +9,60 @@
 #define CSR_BIT(nr)		(1u << (nr))
 #define CSR_GENMASK(h, l)	GENMASK(h, l)
 
+#define DESC_BIT(nr)		BIT_ULL(nr)
+#define DESC_GENMASK(h, l)	GENMASK_ULL(h, l)
+
 #define PCI_DEVICE_ID_META_FBNIC_ASIC		0x0013
 
 #define FBNIC_CLOCK_FREQ	(600 * (1000 * 1000))
 
+/* Register Definitions
+ *
+ * The registers are laid as indexes into an le32 array. As such the actual
+ * address is 4 times the index value. Below each register is defined as 3
+ * fields, name, index, and Address.
+ *
+ *      Name				Index		Address
+ *************************************************************************/
+/* Interrupt Registers */
+#define FBNIC_CSR_START_INTR		0x00000	/* CSR section delimiter */
+#define FBNIC_INTR_STATUS(n)		(0x00000 + (n))	/* 0x00000 + 4*n */
+#define FBNIC_INTR_STATUS_CNT			8
+#define FBNIC_INTR_MASK(n)		(0x00008 + (n)) /* 0x00020 + 4*n */
+#define FBNIC_INTR_MASK_CNT			8
+#define FBNIC_INTR_SET(n)		(0x00010 + (n))	/* 0x00040 + 4*n */
+#define FBNIC_INTR_SET_CNT			8
+#define FBNIC_INTR_CLEAR(n)		(0x00018 + (n))	/* 0x00060 + 4*n */
+#define FBNIC_INTR_CLEAR_CNT			8
+#define FBNIC_INTR_SW_STATUS(n)		(0x00020 + (n)) /* 0x00080 + 4*n */
+#define FBNIC_INTR_SW_STATUS_CNT		8
+#define FBNIC_INTR_SW_AC_MODE(n)	(0x00028 + (n)) /* 0x000a0 + 4*n */
+#define FBNIC_INTR_SW_AC_MODE_CNT		8
+#define FBNIC_INTR_MASK_SET(n)		(0x00030 + (n)) /* 0x000c0 + 4*n */
+#define FBNIC_INTR_MASK_SET_CNT			8
+#define FBNIC_INTR_MASK_CLEAR(n)	(0x00038 + (n)) /* 0x000e0 + 4*n */
+#define FBNIC_INTR_MASK_CLEAR_CNT		8
+#define FBNIC_MAX_MSIX_VECS		256U
+#define FBNIC_INTR_MSIX_CTRL(n)		(0x00040 + (n)) /* 0x00100 + 4*n */
+#define FBNIC_INTR_MSIX_CTRL_VECTOR_MASK	CSR_GENMASK(7, 0)
+#define FBNIC_INTR_MSIX_CTRL_ENABLE		CSR_BIT(31)
+
+#define FBNIC_CSR_END_INTR		0x0005f	/* CSR section delimiter */
+
+/* Interrupt MSIX Registers */
+#define FBNIC_CSR_START_INTR_CQ		0x00400	/* CSR section delimiter */
+#define FBNIC_INTR_CQ_REARM(n) \
+				(0x00400 + 4 * (n))	/* 0x01000 + 16*n */
+#define FBNIC_INTR_CQ_REARM_CNT			256
+#define FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT		CSR_GENMASK(13, 0)
+#define FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT_UPD_EN	CSR_BIT(14)
+#define FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT		CSR_GENMASK(28, 15)
+#define FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT_UPD_EN	CSR_BIT(29)
+#define FBNIC_INTR_CQ_REARM_INTR_RELOAD		CSR_BIT(30)
+#define FBNIC_INTR_CQ_REARM_INTR_UNMASK		CSR_BIT(31)
+
+#define FBNIC_CSR_END_INTR_CQ		0x007fe	/* CSR section delimiter */
+
 /* Global QM Tx registers */
 #define FBNIC_CSR_START_QM_TX		0x00800	/* CSR section delimiter */
 #define FBNIC_QM_TWQ_DEFAULT_META_L	0x00818		/* 0x02060 */
@@ -318,4 +368,33 @@ enum {
 
 #define FBNIC_MAX_QUEUES		128
 
+/* BAR 4 CSRs */
+
+/* The IPC mailbox consists of 32 mailboxes, with each mailbox consisting
+ * of 32 4 byte registers. We will use 2 registers per descriptor so the
+ * length of the mailbox is reduced to 16.
+ *
+ * Currently we use an offset of 0x6000 on BAR4 for the mailbox so we just
+ * have to do the math and determine the offset based on the mailbox
+ * direction and index inside that mailbox.
+ */
+#define FBNIC_IPC_MBX_DESC_LEN	16
+#define FBNIC_IPC_MBX(mbx_idx, desc_idx)	\
+	((((mbx_idx) * FBNIC_IPC_MBX_DESC_LEN + (desc_idx)) * 2) + 0x6000)
+
+/* Use first register in mailbox to flush writes */
+#define FBNIC_FW_ZERO_REG	FBNIC_IPC_MBX(0, 0)
+
+enum {
+	FBNIC_IPC_MBX_RX_IDX,
+	FBNIC_IPC_MBX_TX_IDX,
+	FBNIC_IPC_MBX_INDICES,
+};
+
+#define FBNIC_IPC_MBX_DESC_LEN_MASK	DESC_GENMASK(63, 48)
+#define FBNIC_IPC_MBX_DESC_EOM		DESC_BIT(46)
+#define FBNIC_IPC_MBX_DESC_ADDR_MASK	DESC_GENMASK(45, 3)
+#define FBNIC_IPC_MBX_DESC_FW_CMPL	DESC_BIT(1)
+#define FBNIC_IPC_MBX_DESC_HOST_CMPL	DESC_BIT(0)
+
 #endif /* _FBNIC_CSR_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
new file mode 100644
index 000000000000..feca833ee924
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/dma-mapping.h>
+#include <linux/gfp.h>
+#include <linux/types.h>
+
+#include "fbnic.h"
+#include "fbnic_tlv.h"
+
+static void __fbnic_mbx_wr_desc(struct fbnic_dev *fbd, int mbx_idx,
+				int desc_idx, u64 desc)
+{
+	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
+
+	fw_wr32(fbd, desc_offset + 1, upper_32_bits(desc));
+	fw_wrfl(fbd);
+	fw_wr32(fbd, desc_offset, lower_32_bits(desc));
+}
+
+static u64 __fbnic_mbx_rd_desc(struct fbnic_dev *fbd, int mbx_idx, int desc_idx)
+{
+	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
+	u64 desc;
+
+	desc = fw_rd32(fbd, desc_offset);
+	desc |= (u64)fw_rd32(fbd, desc_offset + 1) << 32;
+
+	return desc;
+}
+
+static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
+{
+	int desc_idx;
+
+	/* Initialize first descriptor to all 0s. Doing this gives us a
+	 * solid stop for the firmware to hit when it is done looping
+	 * through the ring.
+	 */
+	__fbnic_mbx_wr_desc(fbd, mbx_idx, 0, 0);
+
+	fw_wrfl(fbd);
+
+	/* We then fill the rest of the ring starting at the end and moving
+	 * back toward descriptor 0 with skip descriptors that have no
+	 * length nor address, and tell the firmware that they can skip
+	 * them and just move past them to the one we initialized to 0.
+	 */
+	for (desc_idx = FBNIC_IPC_MBX_DESC_LEN; --desc_idx;) {
+		__fbnic_mbx_wr_desc(fbd, mbx_idx, desc_idx,
+				    FBNIC_IPC_MBX_DESC_FW_CMPL |
+				    FBNIC_IPC_MBX_DESC_HOST_CMPL);
+		fw_wrfl(fbd);
+	}
+}
+
+void fbnic_mbx_init(struct fbnic_dev *fbd)
+{
+	int i;
+
+	/* Initialize lock to protect Tx ring */
+	spin_lock_init(&fbd->fw_tx_lock);
+
+	/* Reinitialize mailbox memory */
+	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
+		memset(&fbd->mbx[i], 0, sizeof(struct fbnic_fw_mbx));
+
+	/* Do not auto-clear the FW mailbox interrupt, let SW clear it */
+	wr32(fbd, FBNIC_INTR_SW_AC_MODE(0), ~(1u << FBNIC_FW_MSIX_ENTRY));
+
+	/* Clear any stale causes in vector 0 as that is used for doorbell */
+	wr32(fbd, FBNIC_INTR_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
+
+	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
+		fbnic_mbx_init_desc_ring(fbd, i);
+}
+
+static int fbnic_mbx_map_msg(struct fbnic_dev *fbd, int mbx_idx,
+			     struct fbnic_tlv_msg *msg, u16 length, u8 eom)
+{
+	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
+	u8 tail = mbx->tail;
+	dma_addr_t addr;
+	int direction;
+
+	if (!mbx->ready || !fbnic_fw_present(fbd))
+		return -ENODEV;
+
+	direction = (mbx_idx == FBNIC_IPC_MBX_RX_IDX) ? DMA_FROM_DEVICE :
+							DMA_TO_DEVICE;
+
+	if (mbx->head == ((tail + 1) % FBNIC_IPC_MBX_DESC_LEN))
+		return -EBUSY;
+
+	addr = dma_map_single(fbd->dev, msg, PAGE_SIZE, direction);
+	if (dma_mapping_error(fbd->dev, addr)) {
+		free_page((unsigned long)msg);
+
+		return -ENOSPC;
+	}
+
+	mbx->buf_info[tail].msg = msg;
+	mbx->buf_info[tail].addr = addr;
+
+	mbx->tail = (tail + 1) % FBNIC_IPC_MBX_DESC_LEN;
+
+	fw_wr32(fbd, FBNIC_IPC_MBX(mbx_idx, mbx->tail), 0);
+
+	__fbnic_mbx_wr_desc(fbd, mbx_idx, tail,
+			    FIELD_PREP(FBNIC_IPC_MBX_DESC_LEN_MASK, length) |
+			    (addr & FBNIC_IPC_MBX_DESC_ADDR_MASK) |
+			    (eom ? FBNIC_IPC_MBX_DESC_EOM : 0) |
+			    FBNIC_IPC_MBX_DESC_HOST_CMPL);
+
+	return 0;
+}
+
+static void fbnic_mbx_unmap_and_free_msg(struct fbnic_dev *fbd, int mbx_idx,
+					 int desc_idx)
+{
+	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
+	int direction;
+
+	if (!mbx->buf_info[desc_idx].msg)
+		return;
+
+	direction = (mbx_idx == FBNIC_IPC_MBX_RX_IDX) ? DMA_FROM_DEVICE :
+							DMA_TO_DEVICE;
+	dma_unmap_single(fbd->dev, mbx->buf_info[desc_idx].addr,
+			 PAGE_SIZE, direction);
+
+	free_page((unsigned long)mbx->buf_info[desc_idx].msg);
+	mbx->buf_info[desc_idx].msg = NULL;
+}
+
+static void fbnic_mbx_clean_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
+{
+	int i;
+
+	fbnic_mbx_init_desc_ring(fbd, mbx_idx);
+
+	for (i = FBNIC_IPC_MBX_DESC_LEN; i--;)
+		fbnic_mbx_unmap_and_free_msg(fbd, mbx_idx, i);
+}
+
+void fbnic_mbx_clean(struct fbnic_dev *fbd)
+{
+	int i;
+
+	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
+		fbnic_mbx_clean_desc_ring(fbd, i);
+}
+
+#define FBNIC_MBX_MAX_PAGE_SIZE	FIELD_MAX(FBNIC_IPC_MBX_DESC_LEN_MASK)
+#define FBNIC_RX_PAGE_SIZE	min_t(int, PAGE_SIZE, FBNIC_MBX_MAX_PAGE_SIZE)
+
+static int fbnic_mbx_alloc_rx_msgs(struct fbnic_dev *fbd)
+{
+	struct fbnic_fw_mbx *rx_mbx = &fbd->mbx[FBNIC_IPC_MBX_RX_IDX];
+	u8 tail = rx_mbx->tail, head = rx_mbx->head, count;
+	int err = 0;
+
+	/* Do nothing if mailbox is not ready, or we already have pages on
+	 * the ring that can be used by the firmware
+	 */
+	if (!rx_mbx->ready)
+		return -ENODEV;
+
+	/* Fill all but 1 unused descriptors in the Rx queue. */
+	count = (head - tail - 1) % FBNIC_IPC_MBX_DESC_LEN;
+	while (!err && count--) {
+		struct fbnic_tlv_msg *msg;
+
+		msg = (struct fbnic_tlv_msg *)__get_free_page(GFP_ATOMIC |
+							      __GFP_NOWARN);
+		if (!msg) {
+			err = -ENOMEM;
+			break;
+		}
+
+		err = fbnic_mbx_map_msg(fbd, FBNIC_IPC_MBX_RX_IDX, msg,
+					FBNIC_RX_PAGE_SIZE, 0);
+		if (err)
+			free_page((unsigned long)msg);
+	}
+
+	return err;
+}
+
+static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
+{
+	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
+	u8 head = tx_mbx->head;
+	u64 desc;
+
+	while (head != tx_mbx->tail) {
+		desc = __fbnic_mbx_rd_desc(fbd, FBNIC_IPC_MBX_TX_IDX, head);
+		if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
+			break;
+
+		fbnic_mbx_unmap_and_free_msg(fbd, FBNIC_IPC_MBX_TX_IDX, head);
+
+		head++;
+		head %= FBNIC_IPC_MBX_DESC_LEN;
+	}
+
+	/* Record head for next interrupt */
+	tx_mbx->head = head;
+}
+
+static void fbnic_mbx_postinit_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
+{
+	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
+
+	/* This is a one time init, so just exit if it is completed */
+	if (mbx->ready)
+		return;
+
+	mbx->ready = true;
+
+	switch (mbx_idx) {
+	case FBNIC_IPC_MBX_RX_IDX:
+		/* Make sure we have a page for the FW to write to */
+		fbnic_mbx_alloc_rx_msgs(fbd);
+		break;
+	}
+}
+
+static void fbnic_mbx_postinit(struct fbnic_dev *fbd)
+{
+	int i;
+
+	/* We only need to do this on the first interrupt following init.
+	 * this primes the mailbox so that we will have cleared all the
+	 * skip descriptors.
+	 */
+	if (!(rd32(fbd, FBNIC_INTR_STATUS(0)) & (1u << FBNIC_FW_MSIX_ENTRY)))
+		return;
+
+	wr32(fbd, FBNIC_INTR_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
+
+	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
+		fbnic_mbx_postinit_desc_ring(fbd, i);
+}
+
+static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
+	FBNIC_TLV_MSG_ERROR
+};
+
+static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
+{
+	struct fbnic_fw_mbx *rx_mbx = &fbd->mbx[FBNIC_IPC_MBX_RX_IDX];
+	u8 head = rx_mbx->head;
+	u64 desc, length;
+
+	while (head != rx_mbx->tail) {
+		struct fbnic_tlv_msg *msg;
+		int err;
+
+		desc = __fbnic_mbx_rd_desc(fbd, FBNIC_IPC_MBX_RX_IDX, head);
+		if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
+			break;
+
+		dma_unmap_single(fbd->dev, rx_mbx->buf_info[head].addr,
+				 PAGE_SIZE, DMA_FROM_DEVICE);
+
+		msg = rx_mbx->buf_info[head].msg;
+
+		length = FIELD_GET(FBNIC_IPC_MBX_DESC_LEN_MASK, desc);
+
+		/* Ignore NULL mailbox descriptors */
+		if (!length)
+			goto next_page;
+
+		/* Report descriptors with length greater than page size */
+		if (length > PAGE_SIZE) {
+			dev_warn(fbd->dev,
+				 "Invalid mailbox descriptor length: %lld\n",
+				 length);
+			goto next_page;
+		}
+
+		if (le16_to_cpu(msg->hdr.len) * sizeof(u32) > length)
+			dev_warn(fbd->dev, "Mailbox message length mismatch\n");
+
+		/* If parsing fails dump contents of message to dmesg */
+		err = fbnic_tlv_msg_parse(fbd, msg, fbnic_fw_tlv_parser);
+		if (err) {
+			dev_warn(fbd->dev, "Unable to process message: %d\n",
+				 err);
+			print_hex_dump(KERN_WARNING, "fbnic:",
+				       DUMP_PREFIX_OFFSET, 16, 2,
+				       msg, length, true);
+		}
+
+		dev_dbg(fbd->dev, "Parsed msg type %d\n", msg->hdr.type);
+next_page:
+
+		free_page((unsigned long)rx_mbx->buf_info[head].msg);
+		rx_mbx->buf_info[head].msg = NULL;
+
+		head++;
+		head %= FBNIC_IPC_MBX_DESC_LEN;
+	}
+
+	/* Record head for next interrupt */
+	rx_mbx->head = head;
+
+	/* Make sure we have at least one page for the FW to write to */
+	fbnic_mbx_alloc_rx_msgs(fbd);
+}
+
+void fbnic_mbx_poll(struct fbnic_dev *fbd)
+{
+	fbnic_mbx_postinit(fbd);
+
+	fbnic_mbx_process_tx_msgs(fbd);
+	fbnic_mbx_process_rx_msgs(fbd);
+}
+
+int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
+{
+	struct fbnic_fw_mbx *tx_mbx;
+	int attempts = 50;
+
+	/* Immediate fail if BAR4 isn't there */
+	if (!fbnic_fw_present(fbd))
+		return -ENODEV;
+
+	tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
+	while (!tx_mbx->ready && --attempts) {
+		/* Force the firmware to trigger an interrupt response to
+		 * avoid the mailbox getting stuck closed if the interrupt
+		 * is reset.
+		 */
+		fbnic_mbx_init_desc_ring(fbd, FBNIC_IPC_MBX_TX_IDX);
+
+		msleep(200);
+
+		fbnic_mbx_poll(fbd);
+	}
+
+	return attempts ? 0 : -ETIMEDOUT;
+}
+
+void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
+{
+	struct fbnic_fw_mbx *tx_mbx;
+	int attempts = 50;
+	u8 count = 0;
+
+	/* Nothing to do if there is no mailbox */
+	if (!fbnic_fw_present(fbd))
+		return;
+
+	/* Record current Rx stats */
+	tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
+
+	/* Nothing to do if mailbox never got to ready */
+	if (!tx_mbx->ready)
+		return;
+
+	/* Give firmware time to process packet,
+	 * we will wait up to 10 seconds which is 50 waits of 200ms.
+	 */
+	do {
+		u8 head = tx_mbx->head;
+
+		if (head == tx_mbx->tail)
+			break;
+
+		msleep(200);
+		fbnic_mbx_process_tx_msgs(fbd);
+
+		count += (tx_mbx->head - head) % FBNIC_IPC_MBX_DESC_LEN;
+	} while (count < FBNIC_IPC_MBX_DESC_LEN && --attempts);
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
new file mode 100644
index 000000000000..c143079f881c
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _FBNIC_FW_H_
+#define _FBNIC_FW_H_
+
+#include <linux/types.h>
+
+struct fbnic_dev;
+struct fbnic_tlv_msg;
+
+struct fbnic_fw_mbx {
+	u8 ready, head, tail;
+	struct {
+		struct fbnic_tlv_msg	*msg;
+		dma_addr_t		addr;
+	} buf_info[FBNIC_IPC_MBX_DESC_LEN];
+};
+
+void fbnic_mbx_init(struct fbnic_dev *fbd);
+void fbnic_mbx_clean(struct fbnic_dev *fbd);
+void fbnic_mbx_poll(struct fbnic_dev *fbd);
+int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd);
+void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
+
+#endif /* _FBNIC_FW_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 7d1475750b64..66a2034514e5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -6,10 +6,86 @@
 
 #include "fbnic.h"
 
+static irqreturn_t fbnic_fw_msix_intr(int __always_unused irq, void *data)
+{
+	struct fbnic_dev *fbd = (struct fbnic_dev *)data;
+
+	fbnic_mbx_poll(fbd);
+
+	fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * fbnic_fw_enable_mbx - Configure and initialize Firmware Mailbox
+ * @fbd: Pointer to device to initialize
+ *
+ * This function will initialize the firmware mailbox rings, enable the IRQ
+ * and initialize the communication between the Firmware and the host. The
+ * firmware is expected to respond to the initialization by sending an
+ * interrupt essentially notifying the host that it has seen the
+ * initialization and is now synced up.
+ *
+ * Return: non-zero on failure.
+ **/
+int fbnic_fw_enable_mbx(struct fbnic_dev *fbd)
+{
+	u32 vector = fbd->fw_msix_vector;
+	int err;
+
+	/* Request the IRQ for FW Mailbox vector. */
+	err = request_threaded_irq(vector, NULL, &fbnic_fw_msix_intr,
+				   IRQF_ONESHOT, dev_name(fbd->dev), fbd);
+	if (err)
+		return err;
+
+	/* Initialize mailbox and attempt to poll it into ready state */
+	fbnic_mbx_init(fbd);
+	err = fbnic_mbx_poll_tx_ready(fbd);
+	if (err) {
+		dev_warn(fbd->dev, "FW mailbox did not enter ready state\n");
+		free_irq(vector, fbd);
+		return err;
+	}
+
+	/* Enable interrupts */
+	fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
+
+	return 0;
+}
+
+/**
+ * fbnic_fw_disable_mbx - Disable mailbox and place it in standby state
+ * @fbd: Pointer to device to disable
+ *
+ * This function will disable the mailbox interrupt, free any messages still
+ * in the mailbox and place it into a standby state. The firmware is
+ * expected to see the update and assume that the host is in the reset state.
+ **/
+void fbnic_fw_disable_mbx(struct fbnic_dev *fbd)
+{
+	/* Disable interrupt and free vector */
+	fbnic_wr32(fbd, FBNIC_INTR_MASK_SET(0), 1u << FBNIC_FW_MSIX_ENTRY);
+
+	/* Free the vector */
+	free_irq(fbd->fw_msix_vector, fbd);
+
+	/* Make sure disabling logs message is sent, must be done here to
+	 * avoid risk of completing without a running interrupt.
+	 */
+	fbnic_mbx_flush_tx(fbd);
+
+	/* Reset the mailboxes to the initialized state */
+	fbnic_mbx_clean(fbd);
+}
+
 void fbnic_free_irqs(struct fbnic_dev *fbd)
 {
 	struct pci_dev *pdev = to_pci_dev(fbd->dev);
 
+	fbd->fw_msix_vector = 0;
+
 	fbd->num_irqs = 0;
 
 	pci_free_irq_vectors(pdev);
@@ -35,5 +111,7 @@ int fbnic_alloc_irqs(struct fbnic_dev *fbd)
 
 	fbd->num_irqs = num_irqs;
 
+	fbd->fw_msix_vector = pci_irq_vector(pdev, FBNIC_FW_MSIX_ENTRY);
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index c03d3945d6d2..0c37f4f32612 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -58,6 +58,48 @@ u32 fbnic_rd32(struct fbnic_dev *fbd, u32 reg)
 	return ~0U;
 }
 
+bool fbnic_fw_present(struct fbnic_dev *fbd)
+{
+	return !!READ_ONCE(fbd->uc_addr4);
+}
+
+void fbnic_fw_wr32(struct fbnic_dev *fbd, u32 reg, u32 val)
+{
+	u32 __iomem *csr = READ_ONCE(fbd->uc_addr4);
+
+	if (csr)
+		writel(val, csr + reg);
+}
+
+u32 fbnic_fw_rd32(struct fbnic_dev *fbd, u32 reg)
+{
+	u32 __iomem *csr = READ_ONCE(fbd->uc_addr4);
+	u32 value;
+
+	if (!csr)
+		return ~0U;
+
+	value = readl(csr + reg);
+
+	/* If any bits are 0 value should be valid */
+	if (~value)
+		return value;
+
+	/* All 1's may be valid if ZEROs register still works */
+	if (reg != FBNIC_FW_ZERO_REG && ~readl(csr + FBNIC_FW_ZERO_REG))
+		return value;
+
+	/* Hardware is giving us all 1's reads, assume it is gone */
+	WRITE_ONCE(fbd->uc_addr0, NULL);
+	WRITE_ONCE(fbd->uc_addr4, NULL);
+
+	dev_err(fbd->dev,
+		"Failed read (idx 0x%x AKA addr 0x%x), disabled CSR access, awaiting reset\n",
+		reg, reg << 2);
+
+	return ~0U;
+}
+
 /**
  * fbnic_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -121,6 +163,13 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto free_irqs;
 	}
 
+	err = fbnic_fw_enable_mbx(fbd);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Firmware mailbox initialization failure\n");
+		goto free_irqs;
+	}
+
 	fbnic_devlink_register(fbd);
 
 	if (!fbd->dsn) {
@@ -158,6 +207,7 @@ static void fbnic_remove(struct pci_dev *pdev)
 	struct fbnic_dev *fbd = pci_get_drvdata(pdev);
 
 	fbnic_devlink_unregister(fbd);
+	fbnic_fw_disable_mbx(fbd);
 	fbnic_free_irqs(fbd);
 
 	pci_disable_device(pdev);
@@ -168,6 +218,8 @@ static int fbnic_pm_suspend(struct device *dev)
 {
 	struct fbnic_dev *fbd = dev_get_drvdata(dev);
 
+	fbnic_fw_disable_mbx(fbd);
+
 	/* Free the IRQs so they aren't trying to occupy sleeping CPUs */
 	fbnic_free_irqs(fbd);
 
@@ -196,7 +248,14 @@ static int __fbnic_pm_resume(struct device *dev)
 
 	fbd->mac->init_regs(fbd);
 
+	/* Re-enable mailbox */
+	err = fbnic_fw_enable_mbx(fbd);
+	if (err)
+		goto err_free_irqs;
+
 	return 0;
+err_free_irqs:
+	fbnic_free_irqs(fbd);
 err_invalidate_uc_addr:
 	WRITE_ONCE(fbd->uc_addr0, NULL);
 	WRITE_ONCE(fbd->uc_addr4, NULL);



