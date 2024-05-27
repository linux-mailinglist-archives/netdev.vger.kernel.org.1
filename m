Return-Path: <netdev+bounces-98330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7724D8D0EB1
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 22:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72BFB21BBD
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 20:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1A1161306;
	Mon, 27 May 2024 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6Dr1PZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A35338D
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842399; cv=none; b=M5iNdRqIxD+emtjJP5wQAFD/WpMwgBFIFdLPlx51FzHJxkADRLoj33Mu3/MR6yhpQuuGfM97dzn19dazgidDiN2P6ImU+Roo9C+DYDPjNngkEnKsmkyWuolzoMZGANdSxK6XTjkiHohGh5ggOiyPgtxytcTdKZ0HzYssFiwRkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842399; c=relaxed/simple;
	bh=ICT3siwG4tz49HUoV7Y/5O043QtRmj53WFotR+XLGoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t97A+/s4A390AXfhCWSJxQD3mEfeOpVB+PNpz19UUl+JNTtOASjDBTHHUDgyp09Z1u40mhU1EeGvF3n3Nef9HRjXdM3UMtwn7gw4uAv4mW08W1Eka6rcqJ9efeg9XQpTAku+4hXwpcFIgKWuK9napeYcLV9Jeaz2Zn8HoMLp3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6Dr1PZZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4948a6a8cso146305ad.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716842397; x=1717447197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOJaY2yg1bwX8hMccEYNu4Sf4C7RBgAssrRmzJD9xKI=;
        b=R6Dr1PZZYGYBEfKHmQFdiyFjvPAayKLhbS6PIEw89zEhgUW85M7aopaFkCj9Vpnv/v
         2edTrP/FJVOVhct/MHOXq2sZHzYgO6uQgJaqb420sIQgIfdLrBM1lZ3pPZchz9SkE4Q3
         dnaJQY56kUKSznRx5juE3j5AfKv9M9Tj/ZfgZl+wktDJahqG10pDv6Zk5ptUMlXwjhGR
         mTA5uTaOyk8FcuSWkIrk2HdworEJsgfudrDnV/h+nlGX3HB77+Ixwu2QHJtBSmRz1P+w
         OQuNEdDbQ/faJVgNzz2XDLFWhPRxqhA4P22PVABWNuu6MUwuaPt42lLTvmXylOEMcFWe
         FGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716842397; x=1717447197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOJaY2yg1bwX8hMccEYNu4Sf4C7RBgAssrRmzJD9xKI=;
        b=ORWSlYmjtAGNdY0ZJ0q5llBsft120VfttTAkhGCab4bC+CAP6XehPXQm0o7PZnkxWy
         hut82VNlQF4212oU2VIjQlLoV+N7ogeFR9ZXcy9CO55VWFipwq/6gJdSTnW9e9XHpntM
         UFZU1sGIffToyJAlepHB9JKhP5Ay5AI/aCho0fd/VxWjuZCEXNM3PVErqdgWEur87ykF
         B1UGMSWgaoMQEls+VQvGOK10I3rC9QH+NwmFospdKUfzgOp65uabxdYRyeQTwRRmAFf8
         B4hxLA0uJqHWyRRZ9K9Lt69qDIYEZ+CJ69zzX4FJP4hHk9zM7s65DAGjnsVSLfcNnIpa
         mP/w==
X-Gm-Message-State: AOJu0YytNJ8xr+M6Jym7dsIlXebjYlGblgDYd1x3rLiHtLlxeWrbGJgy
	NiVIDG7q1BupyK8cTPNydBXjaSMflobXbGX1E/4uKlz1XD36VdoFDs6+940w
X-Google-Smtp-Source: AGHT+IF/5B80949BT3ZLvfrU6ZhQ+2hFN6eHC7LHxZNEddcLbACblNfug5xsbHUsr8JTi+/wLCJIYA==
X-Received: by 2002:a17:902:6545:b0:1f3:4d8f:e5f6 with SMTP id d9443c01a7336-1f44993169bmr121588955ad.6.1716842396701;
        Mon, 27 May 2024 13:39:56 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4960ca3f6sm26502925ad.164.2024.05.27.13.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:39:56 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net,
	naveenm@marvell.com,
	jdamato@fastly.com
Subject: [PATCH net-next v7 2/6] net: tn40xx: add register defines
Date: Tue, 28 May 2024 05:39:24 +0900
Message-Id: <20240527203928.38206-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527203928.38206-1-fujita.tomonori@gmail.com>
References: <20240527203928.38206-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds several defines to handle registers in Tehuti Networks
TN40xx chips for later patches.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/tn40.h      |   2 +
 drivers/net/ethernet/tehuti/tn40_regs.h | 245 ++++++++++++++++++++++++
 2 files changed, 247 insertions(+)
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h

diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index a5c5b558f56c..c0ac64a19c31 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -4,6 +4,8 @@
 #ifndef _TN40_H_
 #define _TN40_H_
 
+#include "tn40_regs.h"
+
 #define TN40_DRV_NAME "tn40xx"
 
 #define PCI_VENDOR_ID_EDIMAX 0x1432
diff --git a/drivers/net/ethernet/tehuti/tn40_regs.h b/drivers/net/ethernet/tehuti/tn40_regs.h
new file mode 100644
index 000000000000..95171aa57a9e
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_regs.h
@@ -0,0 +1,245 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#ifndef _TN40_REGS_H_
+#define _TN40_REGS_H_
+
+/* Register region size */
+#define TN40_REGS_SIZE 0x10000
+
+/* Registers from 0x0000-0x00fc were remapped to 0x4000-0x40fc */
+#define TN40_REG_TXD_CFG1_0 0x4000
+#define TN40_REG_TXD_CFG1_1 0x4004
+#define TN40_REG_TXD_CFG1_2 0x4008
+#define TN40_REG_TXD_CFG1_3 0x400C
+
+#define TN40_REG_RXF_CFG1_0 0x4010
+#define TN40_REG_RXF_CFG1_1 0x4014
+#define TN40_REG_RXF_CFG1_2 0x4018
+#define TN40_REG_RXF_CFG1_3 0x401C
+
+#define TN40_REG_RXD_CFG1_0 0x4020
+#define TN40_REG_RXD_CFG1_1 0x4024
+#define TN40_REG_RXD_CFG1_2 0x4028
+#define TN40_REG_RXD_CFG1_3 0x402C
+
+#define TN40_REG_TXF_CFG1_0 0x4030
+#define TN40_REG_TXF_CFG1_1 0x4034
+#define TN40_REG_TXF_CFG1_2 0x4038
+#define TN40_REG_TXF_CFG1_3 0x403C
+
+#define TN40_REG_TXD_CFG0_0 0x4040
+#define TN40_REG_TXD_CFG0_1 0x4044
+#define TN40_REG_TXD_CFG0_2 0x4048
+#define TN40_REG_TXD_CFG0_3 0x404C
+
+#define TN40_REG_RXF_CFG0_0 0x4050
+#define TN40_REG_RXF_CFG0_1 0x4054
+#define TN40_REG_RXF_CFG0_2 0x4058
+#define TN40_REG_RXF_CFG0_3 0x405C
+
+#define TN40_REG_RXD_CFG0_0 0x4060
+#define TN40_REG_RXD_CFG0_1 0x4064
+#define TN40_REG_RXD_CFG0_2 0x4068
+#define TN40_REG_RXD_CFG0_3 0x406C
+
+#define TN40_REG_TXF_CFG0_0 0x4070
+#define TN40_REG_TXF_CFG0_1 0x4074
+#define TN40_REG_TXF_CFG0_2 0x4078
+#define TN40_REG_TXF_CFG0_3 0x407C
+
+#define TN40_REG_TXD_WPTR_0 0x4080
+#define TN40_REG_TXD_WPTR_1 0x4084
+#define TN40_REG_TXD_WPTR_2 0x4088
+#define TN40_REG_TXD_WPTR_3 0x408C
+
+#define TN40_REG_RXF_WPTR_0 0x4090
+#define TN40_REG_RXF_WPTR_1 0x4094
+#define TN40_REG_RXF_WPTR_2 0x4098
+#define TN40_REG_RXF_WPTR_3 0x409C
+
+#define TN40_REG_RXD_WPTR_0 0x40A0
+#define TN40_REG_RXD_WPTR_1 0x40A4
+#define TN40_REG_RXD_WPTR_2 0x40A8
+#define TN40_REG_RXD_WPTR_3 0x40AC
+
+#define TN40_REG_TXF_WPTR_0 0x40B0
+#define TN40_REG_TXF_WPTR_1 0x40B4
+#define TN40_REG_TXF_WPTR_2 0x40B8
+#define TN40_REG_TXF_WPTR_3 0x40BC
+
+#define TN40_REG_TXD_RPTR_0 0x40C0
+#define TN40_REG_TXD_RPTR_1 0x40C4
+#define TN40_REG_TXD_RPTR_2 0x40C8
+#define TN40_REG_TXD_RPTR_3 0x40CC
+
+#define TN40_REG_RXF_RPTR_0 0x40D0
+#define TN40_REG_RXF_RPTR_1 0x40D4
+#define TN40_REG_RXF_RPTR_2 0x40D8
+#define TN40_REG_RXF_RPTR_3 0x40DC
+
+#define TN40_REG_RXD_RPTR_0 0x40E0
+#define TN40_REG_RXD_RPTR_1 0x40E4
+#define TN40_REG_RXD_RPTR_2 0x40E8
+#define TN40_REG_RXD_RPTR_3 0x40EC
+
+#define TN40_REG_TXF_RPTR_0 0x40F0
+#define TN40_REG_TXF_RPTR_1 0x40F4
+#define TN40_REG_TXF_RPTR_2 0x40F8
+#define TN40_REG_TXF_RPTR_3 0x40FC
+
+/* Hardware versioning */
+#define TN40_FPGA_VER 0x5030
+
+/* Registers from 0x0100-0x0150 were remapped to 0x5100-0x5150 */
+#define TN40_REG_ISR TN40_REG_ISR0
+#define TN40_REG_ISR0 0x5100
+
+#define TN40_REG_IMR TN40_REG_IMR0
+#define TN40_REG_IMR0 0x5110
+
+#define TN40_REG_RDINTCM0 0x5120
+#define TN40_REG_RDINTCM2 0x5128
+
+#define TN40_REG_TDINTCM0 0x5130
+
+#define TN40_REG_ISR_MSK0 0x5140
+
+#define TN40_REG_INIT_SEMAPHORE 0x5170
+#define TN40_REG_INIT_STATUS 0x5180
+
+#define TN40_REG_MAC_LNK_STAT 0x0200
+#define TN40_MAC_LINK_STAT 0x0004 /* Link state */
+
+#define TN40_REG_BLNK_LED 0x0210
+
+#define TN40_REG_GMAC_RXF_A 0x1240
+
+#define TN40_REG_UNC_MAC0_A 0x1250
+#define TN40_REG_UNC_MAC1_A 0x1260
+#define TN40_REG_UNC_MAC2_A 0x1270
+
+#define TN40_REG_VLAN_0 0x1800
+
+#define TN40_REG_MAX_FRAME_A 0x12C0
+
+#define TN40_REG_RX_MAC_MCST0 0x1A80
+#define TN40_REG_RX_MAC_MCST1 0x1A84
+#define TN40_MAC_MCST_NUM 15
+#define TN40_REG_RX_MCST_HASH0 0x1A00
+#define TN40_MAC_MCST_HASH_NUM 8
+
+#define TN40_REG_VPC 0x2300
+#define TN40_REG_VIC 0x2320
+#define TN40_REG_VGLB 0x2340
+
+#define TN40_REG_CLKPLL 0x5000
+
+/* MDIO interface */
+
+#define TN40_REG_MDIO_CMD_STAT 0x6030
+#define TN40_REG_MDIO_CMD 0x6034
+#define TN40_REG_MDIO_DATA 0x6038
+#define TN40_REG_MDIO_ADDR 0x603C
+#define TN40_GET_MDIO_BUSY(x) FIELD_GET(GENMASK(0, 0), (x))
+#define TN40_GET_MDIO_RD_ERR(x) FIELD_GET(GENMASK(1, 1), (x))
+
+#define TN40_REG_REVISION 0x6000
+#define TN40_REG_SCRATCH 0x6004
+#define TN40_REG_CTRLST 0x6008
+#define TN40_REG_MAC_ADDR_0 0x600C
+#define TN40_REG_MAC_ADDR_1 0x6010
+#define TN40_REG_FRM_LENGTH 0x6014
+#define TN40_REG_PAUSE_QUANT 0x6054
+#define TN40_REG_RX_FIFO_SECTION 0x601C
+#define TN40_REG_TX_FIFO_SECTION 0x6020
+#define TN40_REG_RX_FULLNESS 0x6024
+#define TN40_REG_TX_FULLNESS 0x6028
+#define TN40_REG_HASHTABLE 0x602C
+
+#define TN40_REG_RST_PORT 0x7000
+#define TN40_REG_DIS_PORT 0x7010
+#define TN40_REG_RST_QU 0x7020
+#define TN40_REG_DIS_QU 0x7030
+
+#define TN40_REG_CTRLST_TX_ENA 0x0001
+#define TN40_REG_CTRLST_RX_ENA 0x0002
+#define TN40_REG_CTRLST_PRM_ENA 0x0010
+#define TN40_REG_CTRLST_PAD_ENA 0x0020
+
+#define TN40_REG_CTRLST_BASE (TN40_REG_CTRLST_PAD_ENA | REG_CTRLST_PRM_ENA)
+
+/* TXD TXF RXF RXD  CONFIG 0x0000 --- 0x007c */
+#define TN40_TX_RX_CFG1_BASE 0xffffffff /*0-31 */
+#define TN40_TX_RX_CFG0_BASE 0xfffff000 /*31:12 */
+#define TN40_TX_RX_CFG0_RSVD 0x00000ffc /*11:2 */
+#define TN40_TX_RX_CFG0_SIZE 0x00000003 /*1:0 */
+
+/* TXD TXF RXF RXD  WRITE 0x0080 --- 0x00BC */
+#define TN40_TXF_WPTR_WR_PTR 0x00007ff8 /*14:3 */
+
+/* TXD TXF RXF RXD  READ  0x00CO --- 0x00FC */
+#define TN40_TXF_RPTR_RD_PTR 0x00007ff8 /*14:3 */
+
+/* The last 4 bits are dropped size is rounded to 16 */
+#define TN40_TXF_WPTR_MASK 0x7ff0
+
+/* regISR 0x0100 */
+/* regIMR 0x0110 */
+#define TN40_IMR_INPROG 0x80000000 /*31 */
+#define TN40_IR_LNKCHG1 0x10000000 /*28 */
+#define TN40_IR_LNKCHG0 0x08000000 /*27 */
+#define TN40_IR_GPIO 0x04000000 /*26 */
+#define TN40_IR_RFRSH 0x02000000 /*25 */
+#define TN40_IR_RSVD 0x01000000 /*24 */
+#define TN40_IR_SWI 0x00800000 /*23 */
+#define TN40_IR_RX_FREE_3 0x00400000 /*22 */
+#define TN40_IR_RX_FREE_2 0x00200000 /*21 */
+#define TN40_IR_RX_FREE_1 0x00100000 /*20 */
+#define TN40_IR_RX_FREE_0 0x00080000 /*19 */
+#define TN40_IR_TX_FREE_3 0x00040000 /*18 */
+#define TN40_IR_TX_FREE_2 0x00020000 /*17 */
+#define TN40_IR_TX_FREE_1 0x00010000 /*16 */
+#define TN40_IR_TX_FREE_0 0x00008000 /*15 */
+#define TN40_IR_RX_DESC_3 0x00004000 /*14 */
+#define TN40_IR_RX_DESC_2 0x00002000 /*13 */
+#define TN40_IR_RX_DESC_1 0x00001000 /*12 */
+#define TN40_IR_RX_DESC_0 0x00000800 /*11 */
+#define TN40_IR_PSE 0x00000400 /*10 */
+#define TN40_IR_TMR3 0x00000200 /* 9 */
+#define TN40_IR_TMR2 0x00000100 /* 8 */
+#define TN40_IR_TMR1 0x00000080 /* 7 */
+#define TN40_IR_TMR0 0x00000040 /* 6 */
+#define TN40_IR_VNT 0x00000020 /* 5 */
+#define TN40_IR_RxFL 0x00000010 /* 4 */
+#define TN40_IR_SDPERR 0x00000008 /* 3 */
+#define TN40_IR_TR 0x00000004 /* 2 */
+#define TN40_IR_PCIE_LINK 0x00000002 /* 1 */
+#define TN40_IR_PCIE_TOUT 0x00000001 /* 0 */
+
+#define TN40_IR_EXTRA						\
+	(TN40_IR_RX_FREE_0 | TN40_IR_LNKCHG0 | TN40_IR_LNKCHG1 |\
+	TN40_IR_PSE | TN40_IR_TMR0 | TN40_IR_PCIE_LINK |	\
+	TN40_IR_PCIE_TOUT)
+
+#define TN40_GMAC_RX_FILTER_OSEN 0x1000 /* shared OS enable */
+#define TN40_GMAC_RX_FILTER_TXFC 0x0400 /* Tx flow control */
+#define TN40_GMAC_RX_FILTER_RSV0 0x0200 /* reserved */
+#define TN40_GMAC_RX_FILTER_FDA 0x0100 /* filter out direct address */
+#define TN40_GMAC_RX_FILTER_AOF 0x0080 /* accept over run */
+#define TN40_GMAC_RX_FILTER_ACF 0x0040 /* accept control frames */
+#define TN40_GMAC_RX_FILTER_ARUNT 0x0020 /* accept under run */
+#define TN40_GMAC_RX_FILTER_ACRC 0x0010 /* accept crc error */
+#define TN40_GMAC_RX_FILTER_AM 0x0008 /* accept multicast */
+#define TN40_GMAC_RX_FILTER_AB 0x0004 /* accept broadcast */
+#define TN40_GMAC_RX_FILTER_PRM 0x0001 /* [0:1] promiscuous mode */
+
+#define TN40_MAX_FRAME_AB_VAL 0x3fff /* 13:0 */
+
+#define TN40_CLKPLL_PLLLKD 0x0200 /* 9 */
+#define TN40_CLKPLL_RSTEND 0x0100 /* 8 */
+#define TN40_CLKPLL_SFTRST 0x0001 /* 0 */
+
+#define TN40_CLKPLL_LKD (TN40_CLKPLL_PLLLKD | TN40_CLKPLL_RSTEND)
+
+#endif
-- 
2.34.1


