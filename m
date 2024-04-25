Return-Path: <netdev+bounces-91139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC08B184C
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 661DEB21EDF
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 01:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC767489;
	Thu, 25 Apr 2024 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrt83ter"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547C6AC0
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007128; cv=none; b=Bxl3ruu6FCHivwRkgwjAhcHL1xbl/fXrve3XURPGH7ZkNxmHl/y46NQaWS/3i3eDnh740eYWSuQgw+7T4obzCN4J6aEcaU6BvgGTXME8RanFzUn2buXYsDwsBL+4fBwVmr8i1X7P/pxRQcNuiohkzTGPP4LLVDSEzOABjSNVPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007128; c=relaxed/simple;
	bh=G/fzz1BPRVSXAdKqTUuTb/nysIglAJebyFjHLk8rYeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCelpw5nEFARPToYY7ATWVXpbGXVwAfpLVokvTI6l8jJGfBVW7B/RQoyAJIeVK1yBPrFRW/B1ivHX72USXigycGmSLDnRzF2hzFWaYN+izcwOztgVao7ozBi+BhP6weEOi/P6ujXMc8bzxkDnTGjOzrmYWfiODuL7mUkEU/iupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hrt83ter; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ac074ba920so105536a91.1
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714007126; x=1714611926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sMwOzSS8AXIut/UYF5L1XcJ9VhguG9KaY7zRMb1V7Y=;
        b=Hrt83ter41QOKouUUVqwCE85PpKfHQ/6oyJZp2L5V/0R+Y9pvD/gkjRKjZ6YNkt6HN
         340IPrDnVFEcahHTdBSwyo/mqvmYw+Py+efKeZt2t3sVTgjLlHpYELAauj2U6sA6EhQo
         KlTchJTsFn+TuQ4C+Ini5OOh9WT4p6Q1EG5sm1eRSw8sTmooHwszAdpKe16mTjP7XjTF
         Cosdzws3XMlya/iG0B7Cc2KQbtRC2CHdmpXCZeoFuggg/mcV5QHwXPNUB5vqKTuKSdgv
         PZbP41Cpbv8wgFl+nuB2wzLTRAQhQUY3BauF3KBgl9+qrz6J050NlRaY21sbLKaU5k9X
         9FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714007126; x=1714611926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sMwOzSS8AXIut/UYF5L1XcJ9VhguG9KaY7zRMb1V7Y=;
        b=ouMuq2N3ntmG+IxC5pipmu0euThbjk36741sL7NT1rUnian387d5W+x0K/bcTUf1Sz
         CVjHWg7zjZ0MtEpY7EU6nyPWVwwZt0E/MWIrABI04E3C2FRfe6snNaqcvUTSFzgVSAoP
         shDT5xnWlo+A6kOesOIAdJQE52kqRVPWY7OETETHUT06UVwHXdVhnmmoA9sJhd8Wym63
         RN+lrecv/TM4DK8mJt+BLiiS5Ct0nYQbgptySQEFOEyLAMeCx5rUKLGy49oP/0nnRd3/
         /8tn+NkG/HiTm00pU35FbdrhKgrt6IjwQnujkRMIksDU5pQhUWYgUaAZudxk5EC6z5D0
         KS2g==
X-Gm-Message-State: AOJu0Yy1qOsufxCt1WD1FZXPZojCNs6ZjNw3Jh0jhnRfYWzpzwJa7K50
	P1t2y5J/AABoBZi3Y1SsERGnVZ5IC0aUaOCMrTAEUcQe5jcA13OqIscHeQ==
X-Google-Smtp-Source: AGHT+IHZbt/apRpibz8xpKePON256zparKlpPuRUQRR+3vtuyX42icB0TJrOz9LYz/mxhULg7QIrCg==
X-Received: by 2002:a62:be11:0:b0:6ea:6f18:887a with SMTP id l17-20020a62be11000000b006ea6f18887amr4653409pff.1.1714007125868;
        Wed, 24 Apr 2024 18:05:25 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id s27-20020a63525b000000b006008ee7e805sm5644940pgl.30.2024.04.24.18.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:05:25 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org
Subject: [PATCH net-next v2 2/6] net: tn40xx: add register defines
Date: Thu, 25 Apr 2024 10:03:50 +0900
Message-Id: <20240425010354.32605-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425010354.32605-1-fujita.tomonori@gmail.com>
References: <20240425010354.32605-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40_regs.h | 266 ++++++++++++++++++++++++
 2 files changed, 268 insertions(+)
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h

diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 83db71ba3b02..b4978f92574a 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -7,6 +7,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include "tn40_regs.h"
+
 #define TN40_DRV_NAME "tn40xx"
 #define TN40_DRV_VERSION "0.3.6.17.2"
 
diff --git a/drivers/net/ethernet/tehuti/tn40_regs.h b/drivers/net/ethernet/tehuti/tn40_regs.h
new file mode 100644
index 000000000000..013f25272927
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40_regs.h
@@ -0,0 +1,266 @@
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
+#define GET_MDIO_BUSY(x) FIELD_GET(GENMASK(0, 0), (x))
+#define GET_MDIO_RD_ERR(x) FIELD_GET(GENMASK(1, 1), (x))
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
+#endif
-- 
2.34.1


