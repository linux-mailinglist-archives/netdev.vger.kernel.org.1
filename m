Return-Path: <netdev+bounces-102444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B7D902FB1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 06:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFECF285071
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73617082D;
	Tue, 11 Jun 2024 04:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGRKGmxW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB33170853
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718081638; cv=none; b=GLoH+KTgq09SvKm6WOX63V1EPbG/AsQp8r4HYJk7GWI2iPlkr8MCqxnMZgjKif7EC/QU3JWOl4HsbU0O2xbvVjygcOVO1AP4MTl+5fmnOTkQcwwtJ0VPYLa+t09Vm8TPtjgD0R1hUyerxMSlcclj8tM5cPEFzzR5xcbLyC3TBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718081638; c=relaxed/simple;
	bh=QG2diaFw/zHyKV5669a4mDjKzfHtUFnyXDL79u9IKZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RERrzg4XZTgI5ZW2T4EN8YKfXfzpoqWUjoznuwUhlFzk38ZQ+bQw9mzktoPTcBBccKpWataX8di2YhnH1XeNEUjnj6Kyi235oNbca4Xp8GwHBxmAyNK16DCIXbjzkXejTtsS/6gJX01xjeDPcH2bunH5/qU/ByLZgDdCdkftrEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGRKGmxW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6f799fc5af3so5916a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 21:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718081636; x=1718686436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vsU2SMQNQG1U95FWxf+0bavDKSxSnCG+/d8ReK+WWE=;
        b=WGRKGmxWoqu3yfrJ3qebY+tusd4m52g4kVAB9mq2twwgDj3UDoJkOHQ6Wv9e2RFUUi
         +91PByzndHhetleNxeVeIWpHXRy/0P68ZI7k+uGpaxY3dydRjePBsBV8+/UqsrqhktBF
         3NcoNAHJG3yVjZuu2tyCVwfmxzBUpZoaRcnPauN+bazGPRNGFC3lchThhQkGSc9HZvVg
         Wjm/PSUpOPCmktW+5wqXVB1CS/whdmVRD0OIioY6pb22ruKVK4TgDyOTlTNUDcQUnHDD
         75vhdHUfUCYXEdSzIXH/ulZWE6YF6lO1jpJTMmMvcoV7vR9hxTgRiXih4El8dPosdHOZ
         7aNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718081636; x=1718686436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vsU2SMQNQG1U95FWxf+0bavDKSxSnCG+/d8ReK+WWE=;
        b=GpSPiaH9gbGBdMTHDtf/Co9VSMEDwhh71s5OPLDJfu6Z2SDgbiiSVWmGYewr5HCA0m
         cPEAmsxVEhsVXfRvOlCnzcRDwBlcUPGGFF5gbFBAfR09Q3C4O2/mSrgH2L0bz3CGY1P2
         eAwXmOSsjJuQYmou7vsr9uaewRQaPlcoedXuC8D5xTdG91S8V6yrWFuQlyBl/F0dsWBz
         qxl3jZzhf7kcdXkCDS8lwjDQ/n2a5Hlsu1A8ZRzzEpJC+E3KzJXSWu/tVmzwlA1dHz4v
         viyyy44IBEaeeZIuFZOeiEx4t2DJUWDe7S36Vch8k3a4BQlcot6o0DbsqjVJ3NdmwblL
         7sGA==
X-Gm-Message-State: AOJu0Yyi6YfNwQkpyGcUmQtfAFAh/FmbxkUAHUleoAuQSPc+JY4iELNO
	1A0SbUQPA8BW6slytXeZvlWzNZASnEPnRH1QqIOqvXfSfbWsLEgdajghTxCI
X-Google-Smtp-Source: AGHT+IF5GfiwYykxBXkHM+gO3a5SnZIT+vYxrtKwmk3q2xzz5cAlt9Vr/JSUIlK9kAYtEZk/kJVHgw==
X-Received: by 2002:a05:6a20:100d:b0:1af:aeb7:7a10 with SMTP id adf61e73a8af0-1b2f96b3371mr10053490637.1.1718081636299;
        Mon, 10 Jun 2024 21:53:56 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c31bb3c141sm1967277a91.10.2024.06.10.21.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 21:53:55 -0700 (PDT)
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
Subject: [PATCH net-next v10 3/7] net: tn40xx: add register defines
Date: Tue, 11 Jun 2024 13:52:13 +0900
Message-Id: <20240611045217.78529-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611045217.78529-1-fujita.tomonori@gmail.com>
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
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
Reviewed-by: Hans-Frieder Vogt <hfdevel@gmx.net>
---
 drivers/net/ethernet/tehuti/tn40.h      |   2 +
 drivers/net/ethernet/tehuti/tn40_regs.h | 245 ++++++++++++++++++++++++
 2 files changed, 247 insertions(+)
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h

diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index b45a2eef2850..aec23208e9b1 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -4,6 +4,8 @@
 #ifndef _TN40_H_
 #define _TN40_H_
 
+#include "tn40_regs.h"
+
 #define TN40_DRV_NAME "tn40xx"
 
 #endif /* _TN40XX_H */
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


