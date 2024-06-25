Return-Path: <netdev+bounces-106525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F612916A96
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E3C1F27EB8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA0C16C44C;
	Tue, 25 Jun 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfcAsIyK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124443A8CB
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326156; cv=none; b=bznrMsvfeA4JNfRhZ2Q+YsjY97GmVd/+QE1STzVmzXcG0JGSk/BEaiunYWP4x9TF+AVtwc75KhztbBD6B5tpPIOKJH84gUwrt81jq2tXeU9US8NT13h9nlWAjFy/na1Z26JnOeMbSZfAiBw3ejKPMinRzqyn0V3CHQ7L8F0z7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326156; c=relaxed/simple;
	bh=td8hGbgMoYStIpUeRRmcgb7XGLVxlKgLwrGsR5ElwMA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQWJos16O5Hgx/zid/Po2Yz0k2gXZQG7DeBBjKt4MldL6yRAv4jeRzUDLwumT8QTjSYnXRXt3jXcm8Um/t8Wj/3afitTyW8EDsaYE28cP61ZWi2E47aP22HwHIyYydbQYibacHTkKhfJP1LpmwgETZUd275bBkcrZ+TZlIMNaag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfcAsIyK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fa07e4f44eso27930055ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326153; x=1719930953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HZYSQaHHljRfc1k9gUwWRRAPSymrGA3KtbExBQrvQA4=;
        b=nfcAsIyK/JFnssghbIe432Tm9FwPMbB0EFXU8jzXd+fmhdGeH8zpsOyx32A4YAjdQP
         65yhO7AOMq0TV00meNe+WT6V3G2g5wulbeSeoIG+UbCCe0UnusXVIfqrxbGge+HrQfCz
         KAD05dva1sDHStOk9/3TljEiNT5A8eXcfJIn3AG8ipx8cQGgHqGkfK+CvCpw9JM4u4F4
         5loCHo5ZQu68WOg1flt3PfmxtUicyBbV8TxyMoayFSDZX/faI5WN0CcEXGIzYbP1TciD
         t+qwHiLNu54n3tQtkSRiRRdfYJzYAxRIzz/uJ3hexbaNgz+fQTZCfhY69R2x5psx8TzK
         wG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326153; x=1719930953;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZYSQaHHljRfc1k9gUwWRRAPSymrGA3KtbExBQrvQA4=;
        b=I+Y6Fy5iVWPis64ywvNXLMKHtuc9ksP+srDD5h1vfTdAwdEdpDL3PG2RD65k6V9lu0
         nnXDwzMcDJZBLEf/zkFoqR/hXjA0wqL9BAOZAIDUClqlhe1YaqwwVSfbfLDV5HFEeslI
         xwtFBfN1CvyYFK3lfpz9mxAbqdHyNGOl2lbUYG0/obDYKJhpTyS/f7b0fyJ8E/R/6oZG
         u4y0lt2up4QEVbeVo7ewMUX+ZrXEalmIR+FC0lHifBsKPQ0HaihZ8uH0xGq584tkGZmQ
         44Ya2lTn3OW0RLlfOdiev60Ydzw0QDDWwarsl5eSABcfhJMD+wAMezlxp6FvvNzBFWWL
         kBqA==
X-Gm-Message-State: AOJu0YyC271TgXbkm4oXxB+nbDN+RzVQE9vzbPdGlDxZgbn60htv3f4o
	N6BTyjG8LeX3SnrAL46zgM43IQdHoZOPCSWERvX+LPk8YD/4ggyNZsUigA==
X-Google-Smtp-Source: AGHT+IENuVi503Sw/n0JfrEFQoBwlcYZWmtns3lvgG1gYIIah5Fre01y+3WgPTLNgjB9HJvpuPa5cw==
X-Received: by 2002:a17:903:18e:b0:1f9:f538:4b09 with SMTP id d9443c01a7336-1fa23f00faemr83257725ad.57.1719326152895;
        Tue, 25 Jun 2024 07:35:52 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb320843sm81997445ad.71.2024.06.25.07.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:35:52 -0700 (PDT)
Subject: [net-next PATCH v2 04/15] eth: fbnic: Add register init to set
 PCIe/Ethernet device config
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:35:51 -0700
Message-ID: 
 <171932615131.3072535.4897630886081399067.stgit@ahduyck-xeon-server.home.arpa>
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

As a part of enabling the device the first step is to configure the AXI and
Ethernet interfaces to allow for basic traffic. This consists of
configuring several registers related to the PCIe and Ethernet FIFOs as well
as configuring the handlers for moving traffic between entities.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile    |    1 
 drivers/net/ethernet/meta/fbnic/fbnic.h     |   41 +++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h |  312 ++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c |  425 +++++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h |   25 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c |   39 ++
 6 files changed, 843 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mac.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mac.h

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index c06041e70bc5..b8f4511440dc 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_FBNIC) += fbnic.o
 
 fbnic-y := fbnic_devlink.o \
 	   fbnic_irq.o \
+	   fbnic_mac.o \
 	   fbnic_pci.o
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index db85b04e9b80..af863dfabd82 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -4,16 +4,22 @@
 #ifndef _FBNIC_H_
 #define _FBNIC_H_
 
+#include <linux/io.h>
+
 #include "fbnic_csr.h"
+#include "fbnic_mac.h"
 
 struct fbnic_dev {
 	struct device *dev;
 
 	u32 __iomem *uc_addr0;
 	u32 __iomem *uc_addr4;
+	const struct fbnic_mac *mac;
 	unsigned short num_irqs;
 
 	u64 dsn;
+	u32 mps;
+	u32 readrq;
 };
 
 /* Reserve entry 0 in the MSI-X "others" array until we have filled all
@@ -25,6 +31,41 @@ enum {
 	FBNIC_NON_NAPI_VECTORS
 };
 
+static inline bool fbnic_present(struct fbnic_dev *fbd)
+{
+	return !!READ_ONCE(fbd->uc_addr0);
+}
+
+static inline void fbnic_wr32(struct fbnic_dev *fbd, u32 reg, u32 val)
+{
+	u32 __iomem *csr = READ_ONCE(fbd->uc_addr0);
+
+	if (csr)
+		writel(val, csr + reg);
+}
+
+u32 fbnic_rd32(struct fbnic_dev *fbd, u32 reg);
+
+static inline void fbnic_wrfl(struct fbnic_dev *fbd)
+{
+	fbnic_rd32(fbd, FBNIC_MASTER_SPARE_0);
+}
+
+static inline void
+fbnic_rmw32(struct fbnic_dev *fbd, u32 reg, u32 mask, u32 val)
+{
+	u32 v;
+
+	v = fbnic_rd32(fbd, reg);
+	v &= ~mask;
+	v |= val;
+	fbnic_wr32(fbd, reg, v);
+}
+
+#define wr32(_f, _r, _v)	fbnic_wr32(_f, _r, _v)
+#define rd32(_f, _r)		fbnic_rd32(_f, _r)
+#define wrfl(_f)		fbnic_wrfl(_f)
+
 extern char fbnic_driver_name[];
 
 void fbnic_devlink_free(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 72e89c07bf54..56a8bbd8b720 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -4,6 +4,318 @@
 #ifndef _FBNIC_CSR_H_
 #define _FBNIC_CSR_H_
 
+#include <linux/bitops.h>
+
+#define CSR_BIT(nr)		(1u << (nr))
+#define CSR_GENMASK(h, l)	GENMASK(h, l)
+
 #define PCI_DEVICE_ID_META_FBNIC_ASIC		0x0013
 
+#define FBNIC_CLOCK_FREQ	(600 * (1000 * 1000))
+
+/* Global QM Tx registers */
+#define FBNIC_CSR_START_QM_TX		0x00800	/* CSR section delimiter */
+#define FBNIC_QM_TWQ_DEFAULT_META_L	0x00818		/* 0x02060 */
+#define FBNIC_QM_TWQ_DEFAULT_META_H	0x00819		/* 0x02064 */
+
+#define FBNIC_QM_TQS_CTL0		0x0081b		/* 0x0206c */
+#define FBNIC_QM_TQS_CTL0_LSO_TS_MASK	CSR_BIT(0)
+enum {
+	FBNIC_QM_TQS_CTL0_LSO_TS_FIRST	= 0,
+	FBNIC_QM_TQS_CTL0_LSO_TS_LAST	= 1,
+};
+
+#define FBNIC_QM_TQS_CTL0_PREFETCH_THRESH	CSR_GENMASK(7, 1)
+enum {
+	FBNIC_QM_TQS_CTL0_PREFETCH_THRESH_MIN	= 16,
+};
+
+#define FBNIC_QM_TQS_CTL1		0x0081c		/* 0x02070 */
+#define FBNIC_QM_TQS_CTL1_MC_MAX_CREDITS	CSR_GENMASK(7, 0)
+#define FBNIC_QM_TQS_CTL1_BULK_MAX_CREDITS	CSR_GENMASK(15, 8)
+#define FBNIC_QM_TQS_MTU_CTL0		0x0081d		/* 0x02074 */
+#define FBNIC_QM_TQS_MTU_CTL1		0x0081e		/* 0x02078 */
+#define FBNIC_QM_TQS_MTU_CTL1_BULK		CSR_GENMASK(13, 0)
+#define FBNIC_QM_TCQ_CTL0		0x0082d		/* 0x020b4 */
+#define FBNIC_QM_TCQ_CTL0_COAL_WAIT		CSR_GENMASK(15, 0)
+#define FBNIC_QM_TCQ_CTL0_TICK_CYCLES		CSR_GENMASK(26, 16)
+#define FBNIC_QM_TQS_EDT_TS_RANGE	0x00849		/* 0x2124 */
+#define FBNIC_QM_TNI_TDF_CTL		0x0086c		/* 0x021b0 */
+#define FBNIC_QM_TNI_TDF_CTL_MRRS		CSR_GENMASK(1, 0)
+#define FBNIC_QM_TNI_TDF_CTL_CLS		CSR_GENMASK(3, 2)
+#define FBNIC_QM_TNI_TDF_CTL_MAX_OT		CSR_GENMASK(11, 4)
+#define FBNIC_QM_TNI_TDF_CTL_MAX_OB		CSR_GENMASK(23, 12)
+#define FBNIC_QM_TNI_TDE_CTL		0x0086d		/* 0x021b4 */
+#define FBNIC_QM_TNI_TDE_CTL_MRRS		CSR_GENMASK(1, 0)
+#define FBNIC_QM_TNI_TDE_CTL_CLS		CSR_GENMASK(3, 2)
+#define FBNIC_QM_TNI_TDE_CTL_MAX_OT		CSR_GENMASK(11, 4)
+#define FBNIC_QM_TNI_TDE_CTL_MAX_OB		CSR_GENMASK(24, 12)
+#define FBNIC_QM_TNI_TDE_CTL_MRRS_1K		CSR_BIT(25)
+#define FBNIC_QM_TNI_TCM_CTL		0x0086e		/* 0x021b8 */
+#define FBNIC_QM_TNI_TCM_CTL_MPS		CSR_GENMASK(1, 0)
+#define FBNIC_QM_TNI_TCM_CTL_CLS		CSR_GENMASK(3, 2)
+#define FBNIC_QM_TNI_TCM_CTL_MAX_OT		CSR_GENMASK(11, 4)
+#define FBNIC_QM_TNI_TCM_CTL_MAX_OB		CSR_GENMASK(23, 12)
+#define FBNIC_CSR_END_QM_TX		0x00873	/* CSR section delimiter */
+
+/* Global QM Rx registers */
+#define FBNIC_CSR_START_QM_RX		0x00c00	/* CSR section delimiter */
+#define FBNIC_QM_RCQ_CTL0		0x00c0c		/* 0x03030 */
+#define FBNIC_QM_RCQ_CTL0_COAL_WAIT		CSR_GENMASK(15, 0)
+#define FBNIC_QM_RCQ_CTL0_TICK_CYCLES		CSR_GENMASK(26, 16)
+#define FBNIC_QM_RNI_RBP_CTL		0x00c2d		/* 0x030b4 */
+#define FBNIC_QM_RNI_RBP_CTL_MRRS		CSR_GENMASK(1, 0)
+#define FBNIC_QM_RNI_RBP_CTL_CLS		CSR_GENMASK(3, 2)
+#define FBNIC_QM_RNI_RBP_CTL_MAX_OT		CSR_GENMASK(11, 4)
+#define FBNIC_QM_RNI_RBP_CTL_MAX_OB		CSR_GENMASK(23, 12)
+#define FBNIC_QM_RNI_RDE_CTL		0x00c2e		/* 0x030b8 */
+#define FBNIC_QM_RNI_RDE_CTL_MPS		CSR_GENMASK(1, 0)
+#define FBNIC_QM_RNI_RDE_CTL_CLS		CSR_GENMASK(3, 2)
+#define FBNIC_QM_RNI_RDE_CTL_MAX_OT		CSR_GENMASK(11, 4)
+#define FBNIC_QM_RNI_RDE_CTL_MAX_OB		CSR_GENMASK(23, 12)
+#define FBNIC_QM_RNI_RCM_CTL		0x00c2f		/* 0x030bc */
+#define FBNIC_QM_RNI_RCM_CTL_MPS		CSR_GENMASK(1, 0)
+#define FBNIC_QM_RNI_RCM_CTL_CLS		CSR_GENMASK(3, 2)
+#define FBNIC_QM_RNI_RCM_CTL_MAX_OT		CSR_GENMASK(11, 4)
+#define FBNIC_QM_RNI_RCM_CTL_MAX_OB		CSR_GENMASK(23, 12)
+#define FBNIC_CSR_END_QM_RX		0x00c34	/* CSR section delimiter */
+
+/* TCE registers */
+#define FBNIC_CSR_START_TCE		0x04000	/* CSR section delimiter */
+#define FBNIC_TCE_REG_BASE		0x04000		/* 0x10000 */
+
+#define FBNIC_TCE_LSO_CTRL		0x04000		/* 0x10000 */
+#define FBNIC_TCE_LSO_CTRL_TCPF_CLR_1ST		CSR_GENMASK(8, 0)
+#define FBNIC_TCE_LSO_CTRL_TCPF_CLR_MID		CSR_GENMASK(17, 9)
+#define FBNIC_TCE_LSO_CTRL_TCPF_CLR_END		CSR_GENMASK(26, 18)
+#define FBNIC_TCE_LSO_CTRL_IPID_MODE_INC	CSR_BIT(27)
+
+#define FBNIC_TCE_CSO_CTRL		0x04001		/* 0x10004 */
+#define FBNIC_TCE_CSO_CTRL_TCP_ZERO_CSUM	CSR_BIT(0)
+
+#define FBNIC_TCE_TXB_CTRL		0x04002		/* 0x10008 */
+#define FBNIC_TCE_TXB_CTRL_LOAD			CSR_BIT(0)
+#define FBNIC_TCE_TXB_CTRL_TCAM_ENABLE		CSR_BIT(1)
+#define FBNIC_TCE_TXB_CTRL_DISABLE		CSR_BIT(2)
+
+#define FBNIC_TCE_TXB_ENQ_WRR_CTRL	0x04003		/* 0x1000c */
+#define FBNIC_TCE_TXB_ENQ_WRR_CTRL_WEIGHT0	CSR_GENMASK(7, 0)
+#define FBNIC_TCE_TXB_ENQ_WRR_CTRL_WEIGHT1	CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_ENQ_WRR_CTRL_WEIGHT2	CSR_GENMASK(23, 16)
+
+#define FBNIC_TCE_TXB_TEI_Q0_CTRL	0x04004		/* 0x10010 */
+#define FBNIC_TCE_TXB_TEI_Q1_CTRL	0x04005		/* 0x10014 */
+#define FBNIC_TCE_TXB_MC_Q_CTRL		0x04006		/* 0x10018 */
+#define FBNIC_TCE_TXB_RX_TEI_Q_CTRL	0x04007		/* 0x1001c */
+#define FBNIC_TCE_TXB_RX_BMC_Q_CTRL	0x04008		/* 0x10020 */
+#define FBNIC_TCE_TXB_Q_CTRL_START		CSR_GENMASK(10, 0)
+#define FBNIC_TCE_TXB_Q_CTRL_SIZE		CSR_GENMASK(22, 11)
+
+#define FBNIC_TCE_TXB_TEI_DWRR_CTRL	0x04009		/* 0x10024 */
+#define FBNIC_TCE_TXB_TEI_DWRR_CTRL_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_TCE_TXB_TEI_DWRR_CTRL_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_NTWRK_DWRR_CTRL	0x0400a		/* 0x10028 */
+#define FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM2	CSR_GENMASK(23, 16)
+
+#define FBNIC_TCE_TXB_CLDR_CFG		0x0400b		/* 0x1002c */
+#define FBNIC_TCE_TXB_CLDR_CFG_NUM_SLOT		CSR_GENMASK(5, 0)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG(n)	(0x0400c + (n))	/* 0x10030 + 4*n */
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_CNT		16
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_0_0	CSR_GENMASK(1, 0)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_0_1	CSR_GENMASK(3, 2)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_0_2	CSR_GENMASK(5, 4)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_0_3	CSR_GENMASK(7, 6)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_1_0	CSR_GENMASK(9, 8)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_1_1	CSR_GENMASK(11, 10)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_1_2	CSR_GENMASK(13, 12)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_1_3	CSR_GENMASK(15, 14)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_2_0	CSR_GENMASK(17, 16)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_2_1	CSR_GENMASK(19, 18)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_2_2	CSR_GENMASK(21, 20)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_2_3	CSR_GENMASK(23, 22)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_3_0	CSR_GENMASK(25, 24)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_3_1	CSR_GENMASK(27, 26)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_3_2	CSR_GENMASK(29, 28)
+#define FBNIC_TCE_TXB_CLDR_SLOT_CFG_DEST_ID_3_3	CSR_GENMASK(31, 30)
+
+#define FBNIC_TCE_BMC_MAX_PKTSZ		0x0403a		/* 0x100e8 */
+#define FBNIC_TCE_BMC_MAX_PKTSZ_TX		CSR_GENMASK(13, 0)
+#define FBNIC_TCE_BMC_MAX_PKTSZ_RX		CSR_GENMASK(27, 14)
+#define FBNIC_TCE_MC_MAX_PKTSZ		0x0403b		/* 0x100ec */
+#define FBNIC_TCE_MC_MAX_PKTSZ_TMI		CSR_GENMASK(13, 0)
+
+#define FBNIC_TCE_SOP_PROT_CTRL		0x0403c		/* 0x100f0 */
+#define FBNIC_TCE_SOP_PROT_CTRL_TBI		CSR_GENMASK(7, 0)
+#define FBNIC_TCE_SOP_PROT_CTRL_TTI_FRM		CSR_GENMASK(14, 8)
+#define FBNIC_TCE_SOP_PROT_CTRL_TTI_CM		CSR_GENMASK(18, 15)
+
+#define FBNIC_TCE_DROP_CTRL		0x0403d		/* 0x100f4 */
+#define FBNIC_TCE_DROP_CTRL_TTI_CM_DROP_EN	CSR_BIT(0)
+#define FBNIC_TCE_DROP_CTRL_TTI_FRM_DROP_EN	CSR_BIT(1)
+#define FBNIC_TCE_DROP_CTRL_TTI_TBI_DROP_EN	CSR_BIT(2)
+
+#define FBNIC_TCE_TXB_TX_BMC_Q_CTRL	0x0404B		/* 0x1012c */
+#define FBNIC_TCE_TXB_BMC_DWRR_CTRL	0x0404C		/* 0x10130 */
+#define FBNIC_TCE_TXB_BMC_DWRR_CTRL_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_TCE_TXB_BMC_DWRR_CTRL_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_TCE_TXB_TEI_DWRR_CTRL_EXT	0x0404D		/* 0x10134 */
+#define FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_EXT \
+					0x0404E		/* 0x10138 */
+#define FBNIC_TCE_TXB_BMC_DWRR_CTRL_EXT	0x0404F		/* 0x1013c */
+#define FBNIC_CSR_END_TCE		0x04050	/* CSR section delimiter */
+
+/* TMI registers */
+#define FBNIC_CSR_START_TMI		0x04400	/* CSR section delimiter */
+#define FBNIC_TMI_SOP_PROT_CTRL		0x04400		/* 0x11000 */
+#define FBNIC_CSR_END_TMI		0x0443f	/* CSR section delimiter */
+/* Rx Buffer Registers */
+#define FBNIC_CSR_START_RXB		0x08000	/* CSR section delimiter */
+enum {
+	FBNIC_RXB_FIFO_MC		= 0,
+	/* Unused */
+	/* Unused */
+	FBNIC_RXB_FIFO_NET_TO_BMC	= 3,
+	FBNIC_RXB_FIFO_HOST		= 4,
+	/* Unused */
+	FBNIC_RXB_FIFO_BMC_TO_HOST	= 6,
+	/* Unused */
+	FBNIC_RXB_FIFO_INDICES		= 8
+};
+
+#define FBNIC_RXB_CT_SIZE(n)		(0x08000 + (n))	/* 0x20000 + 4*n */
+#define FBNIC_RXB_CT_SIZE_CNT			8
+#define FBNIC_RXB_CT_SIZE_HEADER		CSR_GENMASK(5, 0)
+#define FBNIC_RXB_CT_SIZE_PAYLOAD		CSR_GENMASK(11, 6)
+#define FBNIC_RXB_CT_SIZE_ENABLE		CSR_BIT(12)
+#define FBNIC_RXB_PAUSE_DROP_CTRL	0x08008		/* 0x20020 */
+#define FBNIC_RXB_PAUSE_DROP_CTRL_DROP_ENABLE	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE	CSR_GENMASK(15, 8)
+#define FBNIC_RXB_PAUSE_DROP_CTRL_ECN_ENABLE	CSR_GENMASK(23, 16)
+#define FBNIC_RXB_PAUSE_DROP_CTRL_PS_ENABLE	CSR_GENMASK(27, 24)
+#define FBNIC_RXB_PAUSE_THLD(n)		(0x08009 + (n)) /* 0x20024 + 4*n */
+#define FBNIC_RXB_PAUSE_THLD_CNT		8
+#define FBNIC_RXB_PAUSE_THLD_ON			CSR_GENMASK(12, 0)
+#define FBNIC_RXB_PAUSE_THLD_OFF		CSR_GENMASK(25, 13)
+#define FBNIC_RXB_DROP_THLD(n)		(0x08011 + (n)) /* 0x20044 + 4*n */
+#define FBNIC_RXB_DROP_THLD_CNT			8
+#define FBNIC_RXB_DROP_THLD_ON			CSR_GENMASK(12, 0)
+#define FBNIC_RXB_DROP_THLD_OFF			CSR_GENMASK(25, 13)
+#define FBNIC_RXB_ECN_THLD(n)		(0x0801e + (n)) /* 0x20078 + 4*n */
+#define FBNIC_RXB_ECN_THLD_CNT			8
+#define FBNIC_RXB_ECN_THLD_ON			CSR_GENMASK(12, 0)
+#define FBNIC_RXB_ECN_THLD_OFF			CSR_GENMASK(25, 13)
+#define FBNIC_RXB_PBUF_CFG(n)		(0x08027 + (n))	/* 0x2009c + 4*n */
+#define FBNIC_RXB_PBUF_CFG_CNT			8
+#define FBNIC_RXB_PBUF_BASE_ADDR		CSR_GENMASK(12, 0)
+#define FBNIC_RXB_PBUF_SIZE			CSR_GENMASK(21, 13)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0	0x0802f		/* 0x200bc */
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM0	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM1	CSR_GENMASK(15, 8)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM2	CSR_GENMASK(23, 16)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM3	CSR_GENMASK(31, 24)
+#define FBNIC_RXB_DWRR_RDE_WEIGHT1	0x08030		/* 0x200c0 */
+#define FBNIC_RXB_DWRR_RDE_WEIGHT1_QUANTUM4	CSR_GENMASK(7, 0)
+#define FBNIC_RXB_DWRR_BMC_WEIGHT	0x08031		/* 0x200c4 */
+#define FBNIC_RXB_CLDR_PRIO_CFG(n)	(0x8034 + (n))	/* 0x200d0 + 4*n */
+#define FBNIC_RXB_CLDR_PRIO_CFG_CNT		16
+#define FBNIC_RXB_ENDIAN_FCS		0x08044		/* 0x20110 */
+enum {
+	/* Unused */
+	/* Unused */
+	FBNIC_RXB_DEQUEUE_BMC		= 2,
+	FBNIC_RXB_DEQUEUE_HOST		= 3,
+	FBNIC_RXB_DEQUEUE_INDICES	= 4
+};
+
+#define FBNIC_RXB_PBUF_CREDIT(n)	(0x08047 + (n))	/* 0x2011C + 4*n */
+#define FBNIC_RXB_PBUF_CREDIT_CNT		8
+#define FBNIC_RXB_PBUF_CREDIT_MASK		CSR_GENMASK(13, 0)
+#define FBNIC_RXB_INTF_CREDIT		0x0804f		/* 0x2013C */
+#define FBNIC_RXB_INTF_CREDIT_MASK0		CSR_GENMASK(3, 0)
+#define FBNIC_RXB_INTF_CREDIT_MASK1		CSR_GENMASK(7, 4)
+#define FBNIC_RXB_INTF_CREDIT_MASK2		CSR_GENMASK(11, 8)
+#define FBNIC_RXB_INTF_CREDIT_MASK3		CSR_GENMASK(15, 12)
+
+#define FBNIC_RXB_PAUSE_EVENT_CNT(n)	(0x08053 + (n))	/* 0x2014c + 4*n */
+#define FBNIC_RXB_DROP_FRMS_STS(n)	(0x08057 + (n))	/* 0x2015c + 4*n */
+#define FBNIC_RXB_DROP_BYTES_STS_L(n) \
+				(0x08080 + 2 * (n))	/* 0x20200 + 8*n */
+#define FBNIC_RXB_DROP_BYTES_STS_H(n) \
+				(0x08081 + 2 * (n))	/* 0x20204 + 8*n */
+#define FBNIC_RXB_TRUN_FRMS_STS(n)	(0x08091 + (n))	/* 0x20244 + 4*n */
+#define FBNIC_RXB_TRUN_BYTES_STS_L(n) \
+				(0x080c0 + 2 * (n))	/* 0x20300 + 8*n */
+#define FBNIC_RXB_TRUN_BYTES_STS_H(n) \
+				(0x080c1 + 2 * (n))	/* 0x20304 + 8*n */
+#define FBNIC_RXB_TRANS_PAUSE_STS(n)	(0x080d1 + (n))	/* 0x20344 + 4*n */
+#define FBNIC_RXB_TRANS_DROP_STS(n)	(0x080d9 + (n))	/* 0x20364 + 4*n */
+#define FBNIC_RXB_TRANS_ECN_STS(n)	(0x080e1 + (n))	/* 0x20384 + 4*n */
+enum {
+	FBNIC_RXB_ENQUEUE_NET		= 0,
+	FBNIC_RXB_ENQUEUE_BMC		= 1,
+	/* Unused */
+	/* Unused */
+	FBNIC_RXB_ENQUEUE_INDICES	= 4
+};
+
+#define FBNIC_RXB_DRBO_FRM_CNT_SRC(n)	(0x080f9 + (n))	/* 0x203e4 + 4*n */
+#define FBNIC_RXB_DRBO_BYTE_CNT_SRC_L(n) \
+					(0x080fd + (n))	/* 0x203f4 + 4*n */
+#define FBNIC_RXB_DRBO_BYTE_CNT_SRC_H(n) \
+					(0x08101 + (n))	/* 0x20404 + 4*n */
+#define FBNIC_RXB_INTF_FRM_CNT_DST(n)	(0x08105 + (n))	/* 0x20414 + 4*n */
+#define FBNIC_RXB_INTF_BYTE_CNT_DST_L(n) \
+					(0x08109 + (n))	/* 0x20424 + 4*n */
+#define FBNIC_RXB_INTF_BYTE_CNT_DST_H(n) \
+					(0x0810d + (n))	/* 0x20434 + 4*n */
+#define FBNIC_RXB_PBUF_FRM_CNT_DST(n)	(0x08111 + (n))	/* 0x20444 + 4*n */
+#define FBNIC_RXB_PBUF_BYTE_CNT_DST_L(n) \
+					(0x08115 + (n))	/* 0x20454 + 4*n */
+#define FBNIC_RXB_PBUF_BYTE_CNT_DST_H(n) \
+					(0x08119 + (n))	/* 0x20464 + 4*n */
+
+#define FBNIC_RXB_PBUF_FIFO_LEVEL(n)	(0x0811d + (n)) /* 0x20474 + 4*n */
+
+#define FBNIC_RXB_INTEGRITY_ERR(n)	(0x0812f + (n))	/* 0x204bc + 4*n */
+#define FBNIC_RXB_MAC_ERR(n)		(0x08133 + (n))	/* 0x204cc + 4*n */
+#define FBNIC_RXB_PARSER_ERR(n)		(0x08137 + (n))	/* 0x204dc + 4*n */
+#define FBNIC_RXB_FRM_ERR(n)		(0x0813b + (n))	/* 0x204ec + 4*n */
+
+#define FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT	0x08143		/* 0x2050c */
+#define FBNIC_RXB_DWRR_RDE_WEIGHT1_EXT	0x08144		/* 0x20510 */
+#define FBNIC_CSR_END_RXB		0x081b1	/* CSR section delimiter */
+
+/* Rx Parser and Classifier Registers */
+#define FBNIC_CSR_START_RPC		0x08400	/* CSR section delimiter */
+#define FBNIC_RPC_RMI_CONFIG		0x08400		/* 0x21000 */
+#define FBNIC_RPC_RMI_CONFIG_OH_BYTES		CSR_GENMASK(4, 0)
+#define FBNIC_RPC_RMI_CONFIG_FCS_PRESENT	CSR_BIT(8)
+#define FBNIC_RPC_RMI_CONFIG_ENABLE		CSR_BIT(12)
+#define FBNIC_RPC_RMI_CONFIG_MTU		CSR_GENMASK(31, 16)
+#define FBNIC_CSR_END_RPC		0x0856b	/* CSR section delimiter */
+
+/* Fab Registers */
+#define FBNIC_CSR_START_FAB		0x0C000 /* CSR section delimiter */
+#define FBNIC_FAB_AXI4_AR_SPACER_2_CFG		0x0C005		/* 0x30014 */
+#define FBNIC_FAB_AXI4_AR_SPACER_MASK		CSR_BIT(16)
+#define FBNIC_FAB_AXI4_AR_SPACER_THREADSHOLD	CSR_GENMASK(15, 0)
+#define FBNIC_CSR_END_FAB		0x0C020	    /* CSR section delimiter */
+
+/* Master Registers */
+#define FBNIC_CSR_START_MASTER		0x0C400	/* CSR section delimiter */
+#define FBNIC_MASTER_SPARE_0		0x0C41B		/* 0x3106c */
+#define FBNIC_CSR_END_MASTER		0x0C452	/* CSR section delimiter */
+
+/* PUL User Registers */
+#define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
+#define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
+#define FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME		CSR_BIT(18)
+#define FBNIC_PUL_OB_TLP_HDR_AR_CFG	0x3103e		/* 0xc40f8 */
+#define FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME		CSR_BIT(18)
+#define FBNIC_CSR_END_PUL_USER	0x31080	/* CSR section delimiter */
+
+#define FBNIC_MAX_QUEUES		128
+
 #endif /* _FBNIC_CSR_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
new file mode 100644
index 000000000000..a6ef898d7eed
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bitfield.h>
+#include <net/tcp.h>
+
+#include "fbnic.h"
+#include "fbnic_mac.h"
+
+static void fbnic_init_readrq(struct fbnic_dev *fbd, unsigned int offset,
+			      unsigned int cls, unsigned int readrq)
+{
+	u32 val = rd32(fbd, offset);
+
+	/* The TDF_CTL masks are a superset of the RNI_RBP ones. So we can
+	 * use them when setting either the TDE_CTF or RNI_RBP registers.
+	 */
+	val &= FBNIC_QM_TNI_TDF_CTL_MAX_OT | FBNIC_QM_TNI_TDF_CTL_MAX_OB;
+
+	val |= FIELD_PREP(FBNIC_QM_TNI_TDF_CTL_MRRS, readrq) |
+	       FIELD_PREP(FBNIC_QM_TNI_TDF_CTL_CLS, cls);
+
+	wr32(fbd, offset, val);
+}
+
+static void fbnic_init_mps(struct fbnic_dev *fbd, unsigned int offset,
+			   unsigned int cls, unsigned int mps)
+{
+	u32 val = rd32(fbd, offset);
+
+	/* Currently all MPS masks are identical so just use the first one */
+	val &= ~(FBNIC_QM_TNI_TCM_CTL_MPS | FBNIC_QM_TNI_TCM_CTL_CLS);
+
+	val |= FIELD_PREP(FBNIC_QM_TNI_TCM_CTL_MPS, mps) |
+	       FIELD_PREP(FBNIC_QM_TNI_TCM_CTL_CLS, cls);
+
+	wr32(fbd, offset, val);
+}
+
+static void fbnic_mac_init_axi(struct fbnic_dev *fbd)
+{
+	bool override_1k = false;
+	int readrq, mps, cls;
+
+	/* All of the values are based on being a power of 2 starting
+	 * with 64 == 0. Therefore we can either divide by 64 in the
+	 * case of constants, or just subtract 6 from the log2 of the value
+	 * in order to get the value we will be programming into the
+	 * registers.
+	 */
+	readrq = ilog2(fbd->readrq) - 6;
+	if (readrq > 3)
+		override_1k = true;
+	readrq = clamp(readrq, 0, 3);
+
+	mps = ilog2(fbd->mps) - 6;
+	mps = clamp(mps, 0, 3);
+
+	cls = ilog2(L1_CACHE_BYTES) - 6;
+	cls = clamp(cls, 0, 3);
+
+	/* Configure Tx/Rx AXI Paths w/ Read Request and Max Payload sizes */
+	fbnic_init_readrq(fbd, FBNIC_QM_TNI_TDF_CTL, cls, readrq);
+	fbnic_init_mps(fbd, FBNIC_QM_TNI_TCM_CTL, cls, mps);
+
+	/* Configure QM TNI TDE:
+	 * - Max outstanding AXI beats to 704(768 - 64) - guaranetees 8% of
+	 *   buffer capacity to descriptors.
+	 * - Max outstanding transactions to 128
+	 */
+	wr32(fbd, FBNIC_QM_TNI_TDE_CTL,
+	     FIELD_PREP(FBNIC_QM_TNI_TDE_CTL_MRRS_1K, override_1k ? 1 : 0) |
+	     FIELD_PREP(FBNIC_QM_TNI_TDE_CTL_MAX_OB, 704) |
+	     FIELD_PREP(FBNIC_QM_TNI_TDE_CTL_MAX_OT, 128) |
+	     FIELD_PREP(FBNIC_QM_TNI_TDE_CTL_MRRS, readrq) |
+	     FIELD_PREP(FBNIC_QM_TNI_TDE_CTL_CLS, cls));
+
+	fbnic_init_readrq(fbd, FBNIC_QM_RNI_RBP_CTL, cls, readrq);
+	fbnic_init_mps(fbd, FBNIC_QM_RNI_RDE_CTL, cls, mps);
+	fbnic_init_mps(fbd, FBNIC_QM_RNI_RCM_CTL, cls, mps);
+
+	/* Enable XALI AR/AW outbound */
+	wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
+	     FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME);
+	wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
+	     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
+}
+
+static void fbnic_mac_init_qm(struct fbnic_dev *fbd)
+{
+	u32 clock_freq;
+
+	/* Configure TSO behavior */
+	wr32(fbd, FBNIC_QM_TQS_CTL0,
+	     FIELD_PREP(FBNIC_QM_TQS_CTL0_LSO_TS_MASK,
+			FBNIC_QM_TQS_CTL0_LSO_TS_LAST) |
+	     FIELD_PREP(FBNIC_QM_TQS_CTL0_PREFETCH_THRESH,
+			FBNIC_QM_TQS_CTL0_PREFETCH_THRESH_MIN));
+
+	/* Limit EDT to INT_MAX as this is the limit of the EDT Qdisc */
+	wr32(fbd, FBNIC_QM_TQS_EDT_TS_RANGE, INT_MAX);
+
+	/* Configure MTU
+	 * Due to known HW issue we cannot set the MTU to within 16 octets
+	 * of a 64 octet aligned boundary. So we will set the TQS_MTU(s) to
+	 * MTU + 1.
+	 */
+	wr32(fbd, FBNIC_QM_TQS_MTU_CTL0, FBNIC_MAX_JUMBO_FRAME_SIZE + 1);
+	wr32(fbd, FBNIC_QM_TQS_MTU_CTL1,
+	     FIELD_PREP(FBNIC_QM_TQS_MTU_CTL1_BULK,
+			FBNIC_MAX_JUMBO_FRAME_SIZE + 1));
+
+	clock_freq = FBNIC_CLOCK_FREQ;
+
+	/* Be aggressive on the timings. We will have the interrupt
+	 * threshold timer tick once every 1 usec and coalesce writes for
+	 * up to 80 usecs.
+	 */
+	wr32(fbd, FBNIC_QM_TCQ_CTL0,
+	     FIELD_PREP(FBNIC_QM_TCQ_CTL0_TICK_CYCLES,
+			clock_freq / 1000000) |
+	     FIELD_PREP(FBNIC_QM_TCQ_CTL0_COAL_WAIT,
+			clock_freq / 12500));
+
+	/* We will have the interrupt threshold timer tick once every
+	 * 1 usec and coalesce writes for up to 2 usecs.
+	 */
+	wr32(fbd, FBNIC_QM_RCQ_CTL0,
+	     FIELD_PREP(FBNIC_QM_RCQ_CTL0_TICK_CYCLES,
+			clock_freq / 1000000) |
+	     FIELD_PREP(FBNIC_QM_RCQ_CTL0_COAL_WAIT,
+			clock_freq / 500000));
+
+	/* Configure spacer control to 64 beats. */
+	wr32(fbd, FBNIC_FAB_AXI4_AR_SPACER_2_CFG,
+	     FBNIC_FAB_AXI4_AR_SPACER_MASK |
+	     FIELD_PREP(FBNIC_FAB_AXI4_AR_SPACER_THREADSHOLD, 2));
+}
+
+#define FBNIC_DROP_EN_MASK	0x7d
+#define FBNIC_PAUSE_EN_MASK	0x14
+#define FBNIC_ECN_EN_MASK	0x10
+
+struct fbnic_fifo_config {
+	unsigned int addr;
+	unsigned int size;
+};
+
+/* Rx FIFO Configuration
+ * The table consists of 8 entries, of which only 4 are currently used
+ * The starting addr is in units of 64B and the size is in 2KB units
+ * Below is the human readable version of the table defined below:
+ * Function		Addr	Size
+ * ----------------------------------
+ * Network to Host/BMC	384K	64K
+ * Unused
+ * Unused
+ * Network to BMC	448K	32K
+ * Network to Host	0	384K
+ * Unused
+ * BMC to Host		480K	32K
+ * Unused
+ */
+static const struct fbnic_fifo_config fifo_config[] = {
+	{ .addr = 0x1800, .size = 0x20 },	/* Network to Host/BMC */
+	{ },					/* Unused */
+	{ },					/* Unused */
+	{ .addr = 0x1c00, .size = 0x10 },	/* Network to BMC */
+	{ .addr = 0x0000, .size = 0xc0 },	/* Network to Host */
+	{ },					/* Unused */
+	{ .addr = 0x1e00, .size = 0x10 },	/* BMC to Host */
+	{ }					/* Unused */
+};
+
+static void fbnic_mac_init_rxb(struct fbnic_dev *fbd)
+{
+	bool rx_enable;
+	int i;
+
+	rx_enable = !!(rd32(fbd, FBNIC_RPC_RMI_CONFIG) &
+		       FBNIC_RPC_RMI_CONFIG_ENABLE);
+
+	for (i = 0; i < 8; i++) {
+		unsigned int size = fifo_config[i].size;
+
+		/* If we are coming up on a system that already has the
+		 * Rx data path enabled we don't need to reconfigure the
+		 * FIFOs. Instead we can check to verify the values are
+		 * large enough to meet our needs, and use the values to
+		 * populate the flow control, ECN, and drop thresholds.
+		 */
+		if (rx_enable) {
+			size = FIELD_GET(FBNIC_RXB_PBUF_SIZE,
+					 rd32(fbd, FBNIC_RXB_PBUF_CFG(i)));
+			if (size < fifo_config[i].size)
+				dev_warn(fbd->dev,
+					 "fifo%d size of %d smaller than expected value of %d\n",
+					 i, size << 11,
+					 fifo_config[i].size << 11);
+		} else {
+			/* Program RXB Cuthrough */
+			wr32(fbd, FBNIC_RXB_CT_SIZE(i),
+			     FIELD_PREP(FBNIC_RXB_CT_SIZE_HEADER, 4) |
+			     FIELD_PREP(FBNIC_RXB_CT_SIZE_PAYLOAD, 2));
+
+			/* The granularity for the packet buffer size is 2KB
+			 * granularity while the packet buffer base address is
+			 * only 64B granularity
+			 */
+			wr32(fbd, FBNIC_RXB_PBUF_CFG(i),
+			     FIELD_PREP(FBNIC_RXB_PBUF_BASE_ADDR,
+					fifo_config[i].addr) |
+			     FIELD_PREP(FBNIC_RXB_PBUF_SIZE, size));
+
+			/* The granularity for the credits is 64B. This is
+			 * based on RXB_PBUF_SIZE * 32 + 4.
+			 */
+			wr32(fbd, FBNIC_RXB_PBUF_CREDIT(i),
+			     FIELD_PREP(FBNIC_RXB_PBUF_CREDIT_MASK,
+					size ? size * 32 + 4 : 0));
+		}
+
+		if (!size)
+			continue;
+
+		/* Pause is size of FIFO with 56KB skid to start/stop */
+		wr32(fbd, FBNIC_RXB_PAUSE_THLD(i),
+		     !(FBNIC_PAUSE_EN_MASK & (1u << i)) ? 0x1fff :
+		     FIELD_PREP(FBNIC_RXB_PAUSE_THLD_ON,
+				size * 32 - 0x380) |
+		     FIELD_PREP(FBNIC_RXB_PAUSE_THLD_OFF, 0x380));
+
+		/* Enable Drop when only one packet is left in the FIFO */
+		wr32(fbd, FBNIC_RXB_DROP_THLD(i),
+		     !(FBNIC_DROP_EN_MASK & (1u << i)) ? 0x1fff :
+		     FIELD_PREP(FBNIC_RXB_DROP_THLD_ON,
+				size * 32 -
+				FBNIC_MAX_JUMBO_FRAME_SIZE / 64) |
+		     FIELD_PREP(FBNIC_RXB_DROP_THLD_OFF,
+				size * 32 -
+				FBNIC_MAX_JUMBO_FRAME_SIZE / 64));
+
+		/* Enable ECN bit when 1/4 of RXB is filled with at least
+		 * 1 room for one full jumbo frame before setting ECN
+		 */
+		wr32(fbd, FBNIC_RXB_ECN_THLD(i),
+		     !(FBNIC_ECN_EN_MASK & (1u << i)) ? 0x1fff :
+		     FIELD_PREP(FBNIC_RXB_ECN_THLD_ON,
+				max_t(unsigned int,
+				      size * 32 / 4,
+				      FBNIC_MAX_JUMBO_FRAME_SIZE / 64)) |
+		     FIELD_PREP(FBNIC_RXB_ECN_THLD_OFF,
+				max_t(unsigned int,
+				      size * 32 / 4,
+				      FBNIC_MAX_JUMBO_FRAME_SIZE / 64)));
+	}
+
+	/* For now only enable drop and ECN. We need to add driver/kernel
+	 * interfaces for configuring pause.
+	 */
+	wr32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL,
+	     FIELD_PREP(FBNIC_RXB_PAUSE_DROP_CTRL_DROP_ENABLE,
+			FBNIC_DROP_EN_MASK) |
+	     FIELD_PREP(FBNIC_RXB_PAUSE_DROP_CTRL_ECN_ENABLE,
+			FBNIC_ECN_EN_MASK));
+
+	/* Program INTF credits */
+	wr32(fbd, FBNIC_RXB_INTF_CREDIT,
+	     FBNIC_RXB_INTF_CREDIT_MASK0 |
+	     FBNIC_RXB_INTF_CREDIT_MASK1 |
+	     FBNIC_RXB_INTF_CREDIT_MASK2 |
+	     FIELD_PREP(FBNIC_RXB_INTF_CREDIT_MASK3, 8));
+
+	/* Configure calendar slots.
+	 * Rx: 0 - 62	RDE 1st, BMC 2nd
+	 *     63	BMC 1st, RDE 2nd
+	 */
+	for (i = 0; i < 16; i++) {
+		u32 calendar_val = (i == 15) ? 0x1e1b1b1b : 0x1b1b1b1b;
+
+		wr32(fbd, FBNIC_RXB_CLDR_PRIO_CFG(i), calendar_val);
+	}
+
+	/* Split the credits for the DRR up as follows:
+	 * Quantum0: 8000	Network to Host
+	 * Quantum1: 0		Not used
+	 * Quantum2: 80		BMC to Host
+	 * Quantum3: 0		Not used
+	 * Quantum4: 8000	Multicast to Host and BMC
+	 */
+	wr32(fbd, FBNIC_RXB_DWRR_RDE_WEIGHT0,
+	     FIELD_PREP(FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM0, 0x40) |
+	     FIELD_PREP(FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM2, 0x50));
+	wr32(fbd, FBNIC_RXB_DWRR_RDE_WEIGHT0_EXT,
+	     FIELD_PREP(FBNIC_RXB_DWRR_RDE_WEIGHT0_QUANTUM0, 0x1f));
+	wr32(fbd, FBNIC_RXB_DWRR_RDE_WEIGHT1,
+	     FIELD_PREP(FBNIC_RXB_DWRR_RDE_WEIGHT1_QUANTUM4, 0x40));
+	wr32(fbd, FBNIC_RXB_DWRR_RDE_WEIGHT1_EXT,
+	     FIELD_PREP(FBNIC_RXB_DWRR_RDE_WEIGHT1_QUANTUM4, 0x1f));
+
+	/* Program RXB FCS Endian register */
+	wr32(fbd, FBNIC_RXB_ENDIAN_FCS, 0x0aaaaaa0);
+}
+
+static void fbnic_mac_init_txb(struct fbnic_dev *fbd)
+{
+	int i;
+
+	wr32(fbd, FBNIC_TCE_TXB_CTRL, 0);
+
+	/* Configure Tx QM Credits */
+	wr32(fbd, FBNIC_QM_TQS_CTL1,
+	     FIELD_PREP(FBNIC_QM_TQS_CTL1_MC_MAX_CREDITS, 0x40) |
+	     FIELD_PREP(FBNIC_QM_TQS_CTL1_BULK_MAX_CREDITS, 0x20));
+
+	/* Initialize internal Tx queues */
+	wr32(fbd, FBNIC_TCE_TXB_TEI_Q0_CTRL, 0);
+	wr32(fbd, FBNIC_TCE_TXB_TEI_Q1_CTRL, 0);
+	wr32(fbd, FBNIC_TCE_TXB_MC_Q_CTRL,
+	     FIELD_PREP(FBNIC_TCE_TXB_Q_CTRL_SIZE, 0x400) |
+	     FIELD_PREP(FBNIC_TCE_TXB_Q_CTRL_START, 0x000));
+	wr32(fbd, FBNIC_TCE_TXB_RX_TEI_Q_CTRL, 0);
+	wr32(fbd, FBNIC_TCE_TXB_TX_BMC_Q_CTRL,
+	     FIELD_PREP(FBNIC_TCE_TXB_Q_CTRL_SIZE, 0x200) |
+	     FIELD_PREP(FBNIC_TCE_TXB_Q_CTRL_START, 0x400));
+	wr32(fbd, FBNIC_TCE_TXB_RX_BMC_Q_CTRL,
+	     FIELD_PREP(FBNIC_TCE_TXB_Q_CTRL_SIZE, 0x200) |
+	     FIELD_PREP(FBNIC_TCE_TXB_Q_CTRL_START, 0x600));
+
+	wr32(fbd, FBNIC_TCE_LSO_CTRL,
+	     FBNIC_TCE_LSO_CTRL_IPID_MODE_INC |
+	     FIELD_PREP(FBNIC_TCE_LSO_CTRL_TCPF_CLR_1ST, TCPHDR_PSH |
+							 TCPHDR_FIN) |
+	     FIELD_PREP(FBNIC_TCE_LSO_CTRL_TCPF_CLR_MID, TCPHDR_PSH |
+							 TCPHDR_CWR |
+							 TCPHDR_FIN) |
+	     FIELD_PREP(FBNIC_TCE_LSO_CTRL_TCPF_CLR_END, TCPHDR_CWR));
+	wr32(fbd, FBNIC_TCE_CSO_CTRL, 0);
+
+	wr32(fbd, FBNIC_TCE_BMC_MAX_PKTSZ,
+	     FIELD_PREP(FBNIC_TCE_BMC_MAX_PKTSZ_TX,
+			FBNIC_MAX_JUMBO_FRAME_SIZE) |
+	     FIELD_PREP(FBNIC_TCE_BMC_MAX_PKTSZ_RX,
+			FBNIC_MAX_JUMBO_FRAME_SIZE));
+	wr32(fbd, FBNIC_TCE_MC_MAX_PKTSZ,
+	     FIELD_PREP(FBNIC_TCE_MC_MAX_PKTSZ_TMI,
+			FBNIC_MAX_JUMBO_FRAME_SIZE));
+
+	/* Configure calendar slots.
+	 * Tx: 0 - 62	TMI 1st, BMC 2nd
+	 *     63	BMC 1st, TMI 2nd
+	 */
+	for (i = 0; i < 16; i++) {
+		u32 calendar_val = (i == 15) ? 0x1e1b1b1b : 0x1b1b1b1b;
+
+		wr32(fbd, FBNIC_TCE_TXB_CLDR_SLOT_CFG(i), calendar_val);
+	}
+
+	/* Configure DWRR */
+	wr32(fbd, FBNIC_TCE_TXB_ENQ_WRR_CTRL,
+	     FIELD_PREP(FBNIC_TCE_TXB_ENQ_WRR_CTRL_WEIGHT0, 0x64) |
+	     FIELD_PREP(FBNIC_TCE_TXB_ENQ_WRR_CTRL_WEIGHT2, 0x04));
+	wr32(fbd, FBNIC_TCE_TXB_TEI_DWRR_CTRL, 0);
+	wr32(fbd, FBNIC_TCE_TXB_TEI_DWRR_CTRL_EXT, 0);
+	wr32(fbd, FBNIC_TCE_TXB_BMC_DWRR_CTRL,
+	     FIELD_PREP(FBNIC_TCE_TXB_BMC_DWRR_CTRL_QUANTUM0, 0x50) |
+	     FIELD_PREP(FBNIC_TCE_TXB_BMC_DWRR_CTRL_QUANTUM1, 0x82));
+	wr32(fbd, FBNIC_TCE_TXB_BMC_DWRR_CTRL_EXT, 0);
+	wr32(fbd, FBNIC_TCE_TXB_NTWRK_DWRR_CTRL,
+	     FIELD_PREP(FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM1, 0x50) |
+	     FIELD_PREP(FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM2, 0x20));
+	wr32(fbd, FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_EXT,
+	     FIELD_PREP(FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_QUANTUM2, 0x03));
+
+	/* Configure SOP protocol protection */
+	wr32(fbd, FBNIC_TCE_SOP_PROT_CTRL,
+	     FIELD_PREP(FBNIC_TCE_SOP_PROT_CTRL_TBI, 0x78) |
+	     FIELD_PREP(FBNIC_TCE_SOP_PROT_CTRL_TTI_FRM, 0x40) |
+	     FIELD_PREP(FBNIC_TCE_SOP_PROT_CTRL_TTI_CM, 0x0c));
+
+	/* Conservative configuration on MAC interface Start of Packet
+	 * protection FIFO. This sets the minimum depth of the FIFO before
+	 * we start sending packets to the MAC measured in 64B units and
+	 * up to 160 entries deep.
+	 *
+	 * For the ASIC the clock is fast enough that we will likely fill
+	 * the SOP FIFO before the MAC can drain it. So just use a minimum
+	 * value of 8.
+	 */
+	wr32(fbd, FBNIC_TMI_SOP_PROT_CTRL, 8);
+
+	wrfl(fbd);
+	wr32(fbd, FBNIC_TCE_TXB_CTRL, FBNIC_TCE_TXB_CTRL_TCAM_ENABLE |
+				      FBNIC_TCE_TXB_CTRL_LOAD);
+}
+
+static void fbnic_mac_init_regs(struct fbnic_dev *fbd)
+{
+	fbnic_mac_init_axi(fbd);
+	fbnic_mac_init_qm(fbd);
+	fbnic_mac_init_rxb(fbd);
+	fbnic_mac_init_txb(fbd);
+}
+
+static const struct fbnic_mac fbnic_mac_asic = {
+	.init_regs = fbnic_mac_init_regs,
+};
+
+/**
+ * fbnic_mac_init - Assign a MAC type and initialize the fbnic device
+ * @fbd: Device pointer to device to initialize
+ *
+ * Return: zero on success, negative on failure
+ *
+ * Initialize the MAC function pointers and initializes the MAC of
+ * the device.
+ **/
+int fbnic_mac_init(struct fbnic_dev *fbd)
+{
+	fbd->mac = &fbnic_mac_asic;
+
+	fbd->mac->init_regs(fbd);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
new file mode 100644
index 000000000000..e78a92338a62
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _FBNIC_MAC_H_
+#define _FBNIC_MAC_H_
+
+#include <linux/types.h>
+
+struct fbnic_dev;
+
+#define FBNIC_MAX_JUMBO_FRAME_SIZE	9742
+
+/* This structure defines the interface hooks for the MAC. The MAC hooks
+ * will be configured as a const struct provided with a set of function
+ * pointers.
+ *
+ * void (*init_regs)(struct fbnic_dev *fbd);
+ *	Initialize MAC registers to enable Tx/Rx paths and FIFOs.
+ */
+struct fbnic_mac {
+	void (*init_regs)(struct fbnic_dev *fbd);
+};
+
+int fbnic_mac_init(struct fbnic_dev *fbd);
+#endif /* _FBNIC_MAC_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 185a4d2e6c52..dfe043200d2d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -29,6 +29,35 @@ static const struct pci_device_id fbnic_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, fbnic_pci_tbl);
 
+u32 fbnic_rd32(struct fbnic_dev *fbd, u32 reg)
+{
+	u32 __iomem *csr = READ_ONCE(fbd->uc_addr0);
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
+	if (reg != FBNIC_MASTER_SPARE_0 && ~readl(csr + FBNIC_MASTER_SPARE_0))
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
  *  fbnic_probe - Device Initialization Routine
  *  @pdev: PCI device information struct
@@ -88,6 +117,12 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto free_fbd;
 
+	err = fbnic_mac_init(fbd);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to initialize MAC: %d\n", err);
+		goto free_irqs;
+	}
+
 	if (!fbd->dsn) {
 		dev_warn(&pdev->dev, "Reading serial number failed\n");
 		goto init_failure_mode;
@@ -101,6 +136,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	  * firmware updates for fixes.
 	  */
 	return 0;
+free_irqs:
+	fbnic_free_irqs(fbd);
 free_fbd:
 	pci_disable_device(pdev);
 
@@ -158,6 +195,8 @@ static int __fbnic_pm_resume(struct device *dev)
 	if (err)
 		goto err_invalidate_uc_addr;
 
+	fbd->mac->init_regs(fbd);
+
 	return 0;
 err_invalidate_uc_addr:
 	WRITE_ONCE(fbd->uc_addr0, NULL);



