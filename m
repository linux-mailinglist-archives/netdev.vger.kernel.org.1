Return-Path: <netdev+bounces-92028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E978D8B5047
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 06:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E284282207
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 04:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6956D520;
	Mon, 29 Apr 2024 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JahebK0u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C5D28D
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365582; cv=none; b=txk9vFHjxNMhKRHttaEsBnSJZagxrkAINVR3B7ZVLCR1TKeDx6ahDKtZh4JqCHVdrLqldQhXr8dlj94C4Z6mYbR6aD6jNC/gFW1djdDdOMiqpDQEz0V2LV6MNnNoMOSws6sDt85f+qyXT37j88TWI+XcAYMkIQTFimKz0XigaJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365582; c=relaxed/simple;
	bh=Xpb8wVJ+Mx8YW5Y+1oatS0xzUY1jy+gB4r6m/2x7KqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bq8NO3pl9Hn7GF/xScnOMi9CtEYSfWJdTO1gKJy66AM9n1WYRLDgTT6D9XuC7HfM3YiHQjP5hmCn5al2IDusAjkzJHdHHnEXZ77p1Ib4whBfLGKS5J3+ZdJ+o1IOk5ro9BfWFdELWo2a2ZMZnrJBFjDXoclznrxw6D83w5jJWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JahebK0u; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2af37c18c10so992341a91.2
        for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 21:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714365580; x=1714970380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/FF6D/8184qCCHXQ9vmAZdFqA730t5wmIdRfG4vJEs=;
        b=JahebK0upp2kZYyPRyi+oGYvSxuKjyfpwMmJTESqh8TyOCxbwXGmn3M/3yC9gXt225
         7pqvP2OM2HH2ffxztcF+pjYds0/GFjAsWe48tftsaEirYirDXBxj3wP7vKLdKR/Cu3Zk
         D00rgx0uEPivE6nMcw87ARuAfeou31x553DZh9Y5p+fZycuHGQCOD/bQCFyQZpy0Yvw5
         3IL1V9GGsYajcO5k1Tsi02Mes01ntfuL6SNcNEEu4FRRhhrfqHE0iSKeij9W2D4bOTdi
         f3FLa5XIRb3T/4K1B4267Iof+teQShrY6OmNPrM6KY9WCjxjDjVBXUgSNzZaX+eAORnv
         FNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714365580; x=1714970380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/FF6D/8184qCCHXQ9vmAZdFqA730t5wmIdRfG4vJEs=;
        b=N7kYg/WenpKNTuHobExTYhXwZUBHeMnmZj6ErAgb7pxQ3NiEGABiPZ88GiJWStLXkx
         tFS7hurLQzS5R+rpc8W4a4ZW0o1DEQXEjzNsm3dOJI1T8k7fAgT5k71I/ibkV1tbJ6Ay
         4jKAXzvVK+iEFWv6V0/in59pCDIlHJLx/hupIg+UspH61CdH7O/xxiD8d0HtuT4XQUO9
         b56ZxYEh/oUykEuav/5xAf4bJ7w3oZLTuYQMxFXrxEcBtqi5zmj4DW4YdjBWE7Efl2yo
         Ox3bhkbOHNfUhtN3orCNWq30YZrw+2yoz8HlNhBi48HVeH/s7kfftOPtefOHYcfv0AR5
         Z+ow==
X-Gm-Message-State: AOJu0Yw57oU68WyO8qGP5slzpcxMDKw119mnquFyyUB3DrRW/qi3mhl1
	zj5RrKrH8h+NN/en5BkmxzXWxngg3yL3Giz5eANqoQXTJYstiTydoQv5bw==
X-Google-Smtp-Source: AGHT+IHydIrD9pDnKRAVFyK5iE7tM2dcAq9B+3gc16KHqC7iEeKZ44Ucn/m+yGmlFfJvy22MjPr+mw==
X-Received: by 2002:a17:902:d504:b0:1eb:2e59:d6a with SMTP id b4-20020a170902d50400b001eb2e590d6amr9106517plg.3.1714365580192;
        Sun, 28 Apr 2024 21:39:40 -0700 (PDT)
Received: from rpi.. (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001ebd799bd1csm796129pls.13.2024.04.28.21.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 21:39:39 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	jiri@resnulli.us,
	horms@kernel.org
Subject: [PATCH net-next v3 2/6] net: tn40xx: add register defines
Date: Mon, 29 Apr 2024 13:38:23 +0900
Message-Id: <20240429043827.44407-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429043827.44407-1-fujita.tomonori@gmail.com>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
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
index 098267dfbc07..a8d97f54290d 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -7,6 +7,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
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


