Return-Path: <netdev+bounces-87857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C54B8A4CCC
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C403282B85
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480EC5D91E;
	Mon, 15 Apr 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtUnX+zq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BB5D732
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177852; cv=none; b=V3Whv5lR4CWjDBRzWUAi0tDNu58YcwH4PutnxnsmTzlHysSPj4pUr2HzwFBR4Vkoze9kDVRKCZwftypyGYfKSz3qbHHQM8YEN2OrO7YQLY5CwFeGALicqKg41Z5c7pglcZlUa/Se4lX+EnS30O6Uk4ieJW47VRJY35eD+i4m8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177852; c=relaxed/simple;
	bh=Rz3paBI1UBirE4nq7OAASZ6kqlSsLWm7qSdcFRD6zcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sqy5buYZHT4lOmqrhEVF4bil/35MvIPDaUKzr0q2KPLnq1gIniKJpii0HljIXdQazzwa0rpHO/3TnE9YFvjAn3HrrCxYFs4LiZ1bhfDltPt9WXIHv7V1GZYh7VGjXZSrXZMnb6J5dBu4eQDvEzoWx6DPHOSbZR0wEvTSZ4jRpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtUnX+zq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e2be2361efso5004935ad.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713177850; x=1713782650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9RbN9pywMBg5izQFvB2cnqrH7gASngwl7RGQ72c/c8=;
        b=NtUnX+zqJc1ZWnOuH/Mr8aglKAA5Yl1lqyQ2K/Gz996pwYyZOG1MjHWy+vDkNVYz2N
         P+BbCV2MwX/mOxUMSBB1fMXhUG43KkbYWCh3/kIJSJ6mVIWB4+LGo2ZVkxei8XcpSzEN
         a2GHI860J54JmOKZPARieuXyu/2EeEC3o4IEwwoCKAbbLlCW2X5V6eFq4Ktuq8wWxTcM
         T2zNEoqwtAnoXsD7VmtWEZHilX3DsMWxbDGC/yrz4R7lErLLn2vjYHTqy4di4lWXleHq
         TBeGx4kQVo+a2N1lh4l1IgqtKzjEw2a4LelmNMVgZBhiqzOe3/D7V72RcUdNWuFHt/Ml
         uIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177850; x=1713782650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9RbN9pywMBg5izQFvB2cnqrH7gASngwl7RGQ72c/c8=;
        b=Pe0gHyMOC+bszsmbLIsV33h/GQwGf7D8U1x7dDbBgEjT6fXMxVVwyggPUSjob4IakF
         cY730LW2N9bpoZjE/KxLDZolXRJrWaSLLQQoWfETI32LyAT+QCamHWdtbSjICfbhKNvm
         JV+5vxPrNB1/YmaN+s2Thaf9q9Q6wgI+d4D0zh+gZa59fiIitIfg6Kog2AwiVjNE/Uvb
         SDLt+8RthUqv2M75kvW2utVlKPOQhFFCmMswjWBffjns9yIlZR/51WEvoejqRRHcqtP/
         8hxaDSHQuuj1+yookgfNvsRo5NFwcy1P1SFT1WiiRQsclGa62MKle3U7kI8hIqLL76lj
         fJSQ==
X-Gm-Message-State: AOJu0Yxqjiq8PhGCHZhC+LCBB6e2pWSRP7/SVGNaTVsRcMBY0tg9r+KG
	W3t0J+Mtm+x074KUIrKrp6enA96v4r98Q93YuZRW5zVsIhrfwLUCHiZUWg==
X-Google-Smtp-Source: AGHT+IHX9zHD5acYOOESu9ZxQVw+6d9nuYRniNInr2QVMQfukL2k5W4Sg9LlZ9jPXzHtxfKenBayyg==
X-Received: by 2002:a17:903:1c1:b0:1e2:6d57:1012 with SMTP id e1-20020a17090301c100b001e26d571012mr11390710plh.5.1713177849550;
        Mon, 15 Apr 2024 03:44:09 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090274c400b001e256cb48f7sm7581991plt.197.2024.04.15.03.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:44:09 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch
Subject: [PATCH net-next v1 2/5] net: tn40xx: add register defines
Date: Mon, 15 Apr 2024 19:43:49 +0900
Message-Id: <20240415104352.4685-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415104352.4685-1-fujita.tomonori@gmail.com>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40_regs.h | 279 ++++++++++++++++++++++++
 2 files changed, 281 insertions(+)
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h

diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 8507c8f7bc6a..ed43ba027dc5 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -9,6 +9,8 @@
 #include <linux/pci.h>
 #include <linux/version.h>
 
+#include "tn40_regs.h"
+
 #define BDX_DRV_NAME "tn40xx"
 #define BDX_DRV_VERSION "0.3.6.17.2"
 
diff --git a/drivers/net/ethernet/tehuti/tn40_regs.h b/drivers/net/ethernet/tehuti/tn40_regs.h
new file mode 100644
index 000000000000..5e5cb0c49fdf
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_regs.h
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#ifndef _TN40_REGS_H_
+#define _TN40_REGS_H_
+
+/* Register region size */
+#define BDX_REGS_SIZE 0x10000
+
+/* Registers from 0x0000-0x00fc were remapped to 0x4000-0x40fc */
+#define REG_TXD_CFG1_0 0x4000
+#define REG_TXD_CFG1_1 0x4004
+#define REG_TXD_CFG1_2 0x4008
+#define REG_TXD_CFG1_3 0x400C
+
+#define REG_RXF_CFG1_0 0x4010
+#define REG_RXF_CFG1_1 0x4014
+#define REG_RXF_CFG1_2 0x4018
+#define REG_RXF_CFG1_3 0x401C
+
+#define REG_RXD_CFG1_0 0x4020
+#define REG_RXD_CFG1_1 0x4024
+#define REG_RXD_CFG1_2 0x4028
+#define REG_RXD_CFG1_3 0x402C
+
+#define REG_TXF_CFG1_0 0x4030
+#define REG_TXF_CFG1_1 0x4034
+#define REG_TXF_CFG1_2 0x4038
+#define REG_TXF_CFG1_3 0x403C
+
+#define REG_TXD_CFG0_0 0x4040
+#define REG_TXD_CFG0_1 0x4044
+#define REG_TXD_CFG0_2 0x4048
+#define REG_TXD_CFG0_3 0x404C
+
+#define REG_RXF_CFG0_0 0x4050
+#define REG_RXF_CFG0_1 0x4054
+#define REG_RXF_CFG0_2 0x4058
+#define REG_RXF_CFG0_3 0x405C
+
+#define REG_RXD_CFG0_0 0x4060
+#define REG_RXD_CFG0_1 0x4064
+#define REG_RXD_CFG0_2 0x4068
+#define REG_RXD_CFG0_3 0x406C
+
+#define REG_TXF_CFG0_0 0x4070
+#define REG_TXF_CFG0_1 0x4074
+#define REG_TXF_CFG0_2 0x4078
+#define REG_TXF_CFG0_3 0x407C
+
+#define REG_TXD_WPTR_0 0x4080
+#define REG_TXD_WPTR_1 0x4084
+#define REG_TXD_WPTR_2 0x4088
+#define REG_TXD_WPTR_3 0x408C
+
+#define REG_RXF_WPTR_0 0x4090
+#define REG_RXF_WPTR_1 0x4094
+#define REG_RXF_WPTR_2 0x4098
+#define REG_RXF_WPTR_3 0x409C
+
+#define REG_RXD_WPTR_0 0x40A0
+#define REG_RXD_WPTR_1 0x40A4
+#define REG_RXD_WPTR_2 0x40A8
+#define REG_RXD_WPTR_3 0x40AC
+
+#define REG_TXF_WPTR_0 0x40B0
+#define REG_TXF_WPTR_1 0x40B4
+#define REG_TXF_WPTR_2 0x40B8
+#define REG_TXF_WPTR_3 0x40BC
+
+#define REG_TXD_RPTR_0 0x40C0
+#define REG_TXD_RPTR_1 0x40C4
+#define REG_TXD_RPTR_2 0x40C8
+#define REG_TXD_RPTR_3 0x40CC
+
+#define REG_RXF_RPTR_0 0x40D0
+#define REG_RXF_RPTR_1 0x40D4
+#define REG_RXF_RPTR_2 0x40D8
+#define REG_RXF_RPTR_3 0x40DC
+
+#define REG_RXD_RPTR_0 0x40E0
+#define REG_RXD_RPTR_1 0x40E4
+#define REG_RXD_RPTR_2 0x40E8
+#define REG_RXD_RPTR_3 0x40EC
+
+#define REG_TXF_RPTR_0 0x40F0
+#define REG_TXF_RPTR_1 0x40F4
+#define REG_TXF_RPTR_2 0x40F8
+#define REG_TXF_RPTR_3 0x40FC
+
+/* Hardware versioning */
+#define FW_VER 0x5010
+#define SROM_VER 0x5020
+#define FPGA_VER 0x5030
+#define FPGA_SEED 0x5040
+
+/* Registers from 0x0100-0x0150 were remapped to 0x5100-0x5150 */
+#define REG_ISR REG_ISR0
+#define REG_ISR0 0x5100
+
+#define REG_IMR REG_IMR0
+#define REG_IMR0 0x5110
+
+#define REG_RDINTCM0 0x5120
+#define REG_RDINTCM2 0x5128
+
+#define REG_TDINTCM0 0x5130
+
+#define REG_ISR_MSK0 0x5140
+
+#define REG_INIT_SEMAPHORE 0x5170
+#define REG_INIT_STATUS 0x5180
+
+#define REG_MAC_LNK_STAT 0x0200
+#define MAC_LINK_STAT 0x0004 /* Link state */
+
+#define REG_BLNK_LED 0x0210
+
+#define REG_GMAC_RXF_A 0x1240
+
+#define REG_UNC_MAC0_A 0x1250
+#define REG_UNC_MAC1_A 0x1260
+#define REG_UNC_MAC2_A 0x1270
+
+#define REG_VLAN_0 0x1800
+
+#define REG_MAX_FRAME_A 0x12C0
+
+#define REG_RX_MAC_MCST0 0x1A80
+#define REG_RX_MAC_MCST1 0x1A84
+#define MAC_MCST_NUM 15
+#define REG_RX_MCST_HASH0 0x1A00
+#define MAC_MCST_HASH_NUM 8
+
+#define REG_VPC 0x2300
+#define REG_VIC 0x2320
+#define REG_VGLB 0x2340
+
+#define REG_CLKPLL 0x5000
+
+/* MDIO interface */
+
+#define REG_MDIO_CMD_STAT 0x6030
+#define REG_MDIO_CMD 0x6034
+#define REG_MDIO_DATA 0x6038
+#define REG_MDIO_ADDR 0x603C
+#define GET_MDIO_BUSY(x) GET_BITS_SHIFT(x, 1, 0)
+#define GET_MDIO_RD_ERR(x) GET_BITS_SHIFT(x, 1, 1)
+
+/* for 10G only*/
+#define REG_RSS_CNG 0x000000b0
+
+#define RSS_ENABLED 0x00000001
+#define RSS_HFT_TOEPLITZ 0x00000002
+#define RSS_HASH_IPV4 0x00000100
+#define RSS_HASH_TCP_IPV4 0x00000200
+#define RSS_HASH_IPV6 0x00000400
+#define RSS_HASH_IPV6_EX 0x00000800
+#define RSS_HASH_TCP_IPV6 0x00001000
+#define RSS_HASH_TCP_IPV6_EX 0x00002000
+
+#define REG_RSS_HASH_BASE 0x0400
+#define RSS_HASH_LEN 40
+#define REG_RSS_INDT_BASE 0x0600
+#define RSS_INDT_LEN 256
+
+#define REG_REVISION 0x6000
+#define REG_SCRATCH 0x6004
+#define REG_CTRLST 0x6008
+#define REG_MAC_ADDR_0 0x600C
+#define REG_MAC_ADDR_1 0x6010
+#define REG_FRM_LENGTH 0x6014
+#define REG_PAUSE_QUANT 0x6054
+#define REG_RX_FIFO_SECTION 0x601C
+#define REG_TX_FIFO_SECTION 0x6020
+#define REG_RX_FULLNESS 0x6024
+#define REG_TX_FULLNESS 0x6028
+#define REG_HASHTABLE 0x602C
+
+#define REG_RST_PORT 0x7000
+#define REG_DIS_PORT 0x7010
+#define REG_RST_QU 0x7020
+#define REG_DIS_QU 0x7030
+
+#define REG_CTRLST_TX_ENA 0x0001
+#define REG_CTRLST_RX_ENA 0x0002
+#define REG_CTRLST_PRM_ENA 0x0010
+#define REG_CTRLST_PAD_ENA 0x0020
+
+#define REG_CTRLST_BASE (REG_CTRLST_PAD_ENA | REG_CTRLST_PRM_ENA)
+
+#define REG_RX_FLT 0x1400
+
+/* TXD TXF RXF RXD  CONFIG 0x0000 --- 0x007c */
+#define TX_RX_CFG1_BASE 0xffffffff /*0-31 */
+#define TX_RX_CFG0_BASE 0xfffff000 /*31:12 */
+#define TX_RX_CFG0_RSVD 0x00000ffc /*11:2 */
+#define TX_RX_CFG0_SIZE 0x00000003 /*1:0 */
+
+/* TXD TXF RXF RXD  WRITE 0x0080 --- 0x00BC */
+#define TXF_WPTR_WR_PTR 0x00007ff8 /*14:3 */
+
+/* TXD TXF RXF RXD  READ  0x00CO --- 0x00FC */
+#define TXF_RPTR_RD_PTR 0x00007ff8 /*14:3 */
+
+/* The last 4 bits are dropped size is rounded to 16 */
+#define TXF_WPTR_MASK 0x7ff0
+
+/* regISR 0x0100 */
+/* regIMR 0x0110 */
+#define IMR_INPROG 0x80000000 /*31 */
+#define IR_LNKCHG1 0x10000000 /*28 */
+#define IR_LNKCHG0 0x08000000 /*27 */
+#define IR_GPIO 0x04000000 /*26 */
+#define IR_RFRSH 0x02000000 /*25 */
+#define IR_RSVD 0x01000000 /*24 */
+#define IR_SWI 0x00800000 /*23 */
+#define IR_RX_FREE_3 0x00400000 /*22 */
+#define IR_RX_FREE_2 0x00200000 /*21 */
+#define IR_RX_FREE_1 0x00100000 /*20 */
+#define IR_RX_FREE_0 0x00080000 /*19 */
+#define IR_TX_FREE_3 0x00040000 /*18 */
+#define IR_TX_FREE_2 0x00020000 /*17 */
+#define IR_TX_FREE_1 0x00010000 /*16 */
+#define IR_TX_FREE_0 0x00008000 /*15 */
+#define IR_RX_DESC_3 0x00004000 /*14 */
+#define IR_RX_DESC_2 0x00002000 /*13 */
+#define IR_RX_DESC_1 0x00001000 /*12 */
+#define IR_RX_DESC_0 0x00000800 /*11 */
+#define IR_PSE 0x00000400 /*10 */
+#define IR_TMR3 0x00000200 /* 9 */
+#define IR_TMR2 0x00000100 /* 8 */
+#define IR_TMR1 0x00000080 /* 7 */
+#define IR_TMR0 0x00000040 /* 6 */
+#define IR_VNT 0x00000020 /* 5 */
+#define IR_RxFL 0x00000010 /* 4 */
+#define IR_SDPERR 0x00000008 /* 3 */
+#define IR_TR 0x00000004 /* 2 */
+#define IR_PCIE_LINK 0x00000002 /* 1 */
+#define IR_PCIE_TOUT 0x00000001 /* 0 */
+
+#define IR_EXTRA                                                     \
+	(IR_RX_FREE_0 | IR_LNKCHG0 | IR_LNKCHG1 | IR_PSE | IR_TMR0 | \
+	 IR_PCIE_LINK | IR_PCIE_TOUT)
+
+#define GMAC_RX_FILTER_OSEN 0x1000 /* shared OS enable */
+#define GMAC_RX_FILTER_TXFC 0x0400 /* Tx flow control */
+#define GMAC_RX_FILTER_RSV0 0x0200 /* reserved */
+#define GMAC_RX_FILTER_FDA 0x0100 /* filter out direct address */
+#define GMAC_RX_FILTER_AOF 0x0080 /* accept over run */
+#define GMAC_RX_FILTER_ACF 0x0040 /* accept control frames */
+#define GMAC_RX_FILTER_ARUNT 0x0020 /* accept under run */
+#define GMAC_RX_FILTER_ACRC 0x0010 /* accept crc error */
+#define GMAC_RX_FILTER_AM 0x0008 /* accept multicast */
+#define GMAC_RX_FILTER_AB 0x0004 /* accept broadcast */
+#define GMAC_RX_FILTER_PRM 0x0001 /* [0:1] promiscuous mode */
+
+#define MAX_FRAME_AB_VAL 0x3fff /* 13:0 */
+
+#define CLKPLL_PLLLKD 0x0200 /* 9 */
+#define CLKPLL_RSTEND 0x0100 /* 8 */
+#define CLKPLL_SFTRST 0x0001 /* 0 */
+
+#define CLKPLL_LKD (CLKPLL_PLLLKD | CLKPLL_RSTEND)
+
+/* PCI-E Device Control Register (Offset 0x88) Source: Luxor Data
+ * Sheet, 7.1.3.3.3
+ */
+#define PCI_DEV_CTRL_REG 0x88
+#define GET_DEV_CTRL_MAXPL(x) GET_BITS_SHIFT(x, 3, 5)
+#define GET_DEV_CTRL_MRRS(x) GET_BITS_SHIFT(x, 3, 12)
+
+/* PCI-E Link Status Register (Offset 0x92) Source: Luxor Data
+ * Sheet, 7.1.3.3.7
+ */
+#define PCI_LINK_STATUS_REG 0x92
+#define GET_LINK_STATUS_LANES(x) GET_BITS_SHIFT(x, 6, 4)
+
+#endif
-- 
2.34.1


