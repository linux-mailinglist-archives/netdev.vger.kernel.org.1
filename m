Return-Path: <netdev+bounces-143134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 058589C13A9
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B737B20F68
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E56BA4A;
	Fri,  8 Nov 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrIsGPms"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E5629
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029581; cv=none; b=lgo5E3yKJYlOPwlpUdj2AffnZsPA7WnI72KLDifMCP+6++vVQjVBBYV+a9zBa3UxTW5Pf3mRCiwV/V3KkMXDBYY7WY1gZl4Ms/oWyrsAVCgXlVFFj77k6T5fZEDZE+R5/kkW5gGRAebP7tA0hpvW8HBPOFOguXdO3j7qpiFeRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029581; c=relaxed/simple;
	bh=Liz5Q36OmOOx/SUM4FDPeUJw78UuC5rInOug6F6t1wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZRQKLj1ENO86WcV4NSEcbMa4ds6pTrqvNFIytWTv0Ft9QR/W+P6wArfirK9bpSfQNMK55oLz956CoEvE9l+g81k8/5OOXrssRFlj55uGiiKIRO3/qVAL+tBRALK8zfCweIDXwYSUVByPtVZ4XMEQet4gig5Loop4YNb0U8TmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrIsGPms; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so18782655e9.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 17:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731029578; x=1731634378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bSfGPx6mkp7W3gVCh6kvL+NlBBJhEkBoZHKtN0bdNkc=;
        b=nrIsGPmsjsFjE7hpzk4nBmOvpl3gCzmmHiLw2TCRkm+4SW6zq7aQ6uNX7VJTQ4GvZq
         Pwyfe9vONLy+RcmOSGJopwKrmUy0ziXA2Jj3J9M3cds/s63ooCl18GBKSavUJBLePqeQ
         bcmqHbs+ZNmLn/W1qJkcqH9aLmjjTSb/AHS1bHzJ/WVgIQlv3W8HqxOmAbLCfd33zv2l
         rWWaVV8B3oBtbtZbT39vxqbrae7z7h8vkdsmgfYbxS8R9yjN6+M05k/Zh86/+i8aEw+b
         HMuOzujy62xWIMu2HXysoVyK/c+uJo5MB3PUVXLIqVysUDIzo/jj7SrkPdQ7IlnudZfD
         SGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731029578; x=1731634378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSfGPx6mkp7W3gVCh6kvL+NlBBJhEkBoZHKtN0bdNkc=;
        b=CubFmGq0QE77AY2+UUCiRoBTfK3NMp4o56TjSQwy67kHsGCbsqWE3+j8hDrpsW3q3V
         9EXv8pTt4aaOZmNevRS3wiyoPcK/yESjWw2mQ72cMHVgtEEZEZedv8AWbC2Fhk0r5nTm
         uwFIx4wzwmmhDfeMTd/wnRQW4mx8QQoyQkmVUmgViKJFlOu+x3GbdAZbonaDTBOd56oV
         e5k2uqLtG9OEO57SS6XFQqt+wqk/hqIIY0lZ6WRJxyaRIgAVuOUK/l99QNKn6zRjqMQ3
         Ct8ioI0r8195EHk9uXg22RsrHJtN0Xtp3NqHuBhkcYMdOkBSt1weHguJxVXjNeo2zTvj
         7SGg==
X-Gm-Message-State: AOJu0Yy0Df9JCvct8kSZghliDHzNVUSdYQQSY7KJTirxI7iCxXvvdUO4
	dMUmTdsYd6k56E8wASCSxmYt9GZvTQ3a4KZZXRee9SZjSclu6tmeSPjxoVrP
X-Google-Smtp-Source: AGHT+IF/Pvzncvx9gqyB3Tge6ZBe1fhN0ACvdQIXH7d4HzcWe1aRfItPMGRzAck2xtz7z3QJPYE3Dg==
X-Received: by 2002:a05:6000:1f87:b0:37c:c51b:8d9c with SMTP id ffacd0b85a97d-381f1884871mr998522f8f.38.1731029577359;
        Thu, 07 Nov 2024 17:32:57 -0800 (PST)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5fc9sm79838765e9.3.2024.11.07.17.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 17:32:55 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kernel-team@meta.com,
	sanmanpradhan@meta.com,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next] eth: fbnic: Add support to dump registers
Date: Thu,  7 Nov 2024 17:32:53 -0800
Message-ID: <20241108013253.3934778-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the 'ethtool -d <dev>' command to retrieve and print
a register dump for fbnic. The dump defaults to version 1 and consists
of two parts: all the register sections that can be dumped linearly, and
an RPC RAM section that is structured in an interleaved fashion and
requires special handling. For each register section, the dump also
contains the start and end boundary information which can simplify parsing.

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile      |   3 +-
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c   | 145 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  16 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  17 ++
 5 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_csr.c

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index cadd4dac6620..425e8b801265 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -7,7 +7,8 @@
 
 obj-$(CONFIG_FBNIC) += fbnic.o
 
-fbnic-y := fbnic_devlink.o \
+fbnic-y := fbnic_csr.o \
+	   fbnic_devlink.o \
 	   fbnic_ethtool.o \
 	   fbnic_fw.o \
 	   fbnic_hw_stats.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 9f9cb9b3e74e..98870cb2b689 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -156,6 +156,9 @@ int fbnic_alloc_irqs(struct fbnic_dev *fbd);
 void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
 				 const size_t str_sz);
 
+void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version);
+int fbnic_csr_regs_len(struct fbnic_dev *fbd);
+
 enum fbnic_boards {
 	fbnic_board_asic
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
new file mode 100644
index 000000000000..e6018e54bc68
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
@@ -0,0 +1,145 @@
+#include "fbnic.h"
+
+#define FBNIC_BOUNDS(section) { \
+	.start = FBNIC_CSR_START_##section, \
+	.end = FBNIC_CSR_END_##section + 1, \
+}
+
+struct fbnic_csr_bounds {
+	u32	start;
+	u32	end;
+};
+
+static const struct fbnic_csr_bounds fbnic_csr_sects[] = {
+	FBNIC_BOUNDS(INTR),
+	FBNIC_BOUNDS(INTR_CQ),
+	FBNIC_BOUNDS(QM_TX),
+	FBNIC_BOUNDS(QM_RX),
+	FBNIC_BOUNDS(TCE),
+	FBNIC_BOUNDS(TCE_RAM),
+	FBNIC_BOUNDS(TMI),
+	FBNIC_BOUNDS(PTP),
+	FBNIC_BOUNDS(RXB),
+	FBNIC_BOUNDS(RPC),
+	FBNIC_BOUNDS(FAB),
+	FBNIC_BOUNDS(MASTER),
+	FBNIC_BOUNDS(PCS),
+	FBNIC_BOUNDS(RSFEC),
+	FBNIC_BOUNDS(MAC_MAC),
+	FBNIC_BOUNDS(SIG),
+	FBNIC_BOUNDS(PUL_USER),
+	FBNIC_BOUNDS(QUEUE),
+	FBNIC_BOUNDS(RPC_RAM),
+};
+
+#define FBNIC_RPC_TCAM_ACT_DW_PER_ENTRY			14
+#define FBNIC_RPC_TCAM_ACT_NUM_ENTRIES			64
+
+#define FBNIC_RPC_TCAM_MACDA_DW_PER_ENTRY		4
+#define FBNIC_RPC_TCAM_MACDA_NUM_ENTRIES		32
+
+#define FBNIC_RPC_TCAM_OUTER_IPSRC_DW_PER_ENTRY		9
+#define FBNIC_RPC_TCAM_OUTER_IPSRC_NUM_ENTRIES		8
+
+#define FBNIC_RPC_TCAM_OUTER_IPDST_DW_PER_ENTRY		9
+#define FBNIC_RPC_TCAM_OUTER_IPDST_NUM_ENTRIES		8
+
+#define FBNIC_RPC_TCAM_IPSRC_DW_PER_ENTRY		9
+#define FBNIC_RPC_TCAM_IPSRC_NUM_ENTRIES		8
+
+#define FBNIC_RPC_TCAM_IPDST_DW_PER_ENTRY		9
+#define FBNIC_RPC_TCAM_IPDST_NUM_ENTRIES		8
+
+#define FBNIC_RPC_RSS_TBL_DW_PER_ENTRY			2
+#define FBNIC_RPC_RSS_TBL_NUM_ENTRIES			256
+
+static void fbnic_csr_get_regs_rpc_ram(struct fbnic_dev *fbd, u32 **data_p)
+{
+	u32 start = FBNIC_CSR_START_RPC_RAM;
+	u32 end = FBNIC_CSR_END_RPC_RAM;
+	u32 *data = *data_p;
+	u32 i, j;
+
+	*(data++) = start;
+	*(data++) = end - 1;
+
+	/* FBNIC_RPC_TCAM_ACT */
+	for (i = 0; i < FBNIC_RPC_TCAM_ACT_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_ACT_DW_PER_ENTRY; j++)
+			*(data++) = rd32(fbd, FBNIC_RPC_TCAM_ACT(i, j));
+	}
+
+	/* FBNIC_RPC_TCAM_MACDA */
+	for (i = 0; i < FBNIC_RPC_TCAM_MACDA_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_MACDA_DW_PER_ENTRY; j++)
+			*(data++) = rd32(fbd, FBNIC_RPC_TCAM_MACDA(i, j));
+	}
+
+	/* FBNIC_RPC_TCAM_OUTER_IPSRC */
+	for (i = 0; i < FBNIC_RPC_TCAM_OUTER_IPSRC_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_OUTER_IPSRC_DW_PER_ENTRY; j++)
+			*(data++) = rd32(fbd, FBNIC_RPC_TCAM_OUTER_IPSRC(i, j));
+	}
+
+	/* FBNIC_RPC_TCAM_OUTER_IPDST */
+	for (i = 0; i < FBNIC_RPC_TCAM_OUTER_IPDST_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_OUTER_IPDST_DW_PER_ENTRY; j++)
+			*(data++) = rd32(fbd, FBNIC_RPC_TCAM_OUTER_IPDST(i, j));
+	}
+
+	/* FBNIC_RPC_TCAM_IPSRC */
+	for (i = 0; i < FBNIC_RPC_TCAM_IPSRC_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_IPSRC_DW_PER_ENTRY; j++)
+			*(data++) = rd32(fbd, FBNIC_RPC_TCAM_IPSRC(i, j));
+	}
+
+	/* FBNIC_RPC_TCAM_IPDST */
+	for (i = 0; i < FBNIC_RPC_TCAM_IPDST_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_TCAM_IPDST_DW_PER_ENTRY; j++)
+			*(data++) = rd32(fbd, FBNIC_RPC_TCAM_IPDST(i, j));
+	}
+
+	/* FBNIC_RPC_RSS_TBL */
+	for (i = 0; i < FBNIC_RPC_RSS_TBL_NUM_ENTRIES; i++) {
+		for (j = 0; j < FBNIC_RPC_RSS_TBL_DW_PER_ENTRY; j++)
+			*(data++) = rd32(fbd, FBNIC_RPC_RSS_TBL(i, j));
+	}
+
+	*data_p = data;
+}
+
+void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version)
+{
+	const struct fbnic_csr_bounds *bound;
+	u32 *start = data;
+	int i, j;
+
+	*regs_version = 1u;
+
+	/* Skip RPC_RAM section which cannot be dumped linearly */
+	for (i = 0, bound = fbnic_csr_sects;
+	     i < ARRAY_SIZE(fbnic_csr_sects) - 1; i++, ++bound) {
+		*(data++) = bound->start;
+		*(data++) = bound->end - 1;
+		for (j = bound->start; j < bound->end; j++)
+			*(data++) = rd32(fbd, j);
+	}
+
+	/* Dump the RPC_RAM as special case registers */
+	fbnic_csr_get_regs_rpc_ram(fbd, &data);
+
+	WARN_ON(data - start != fbnic_csr_regs_len(fbd));
+}
+
+int fbnic_csr_regs_len(struct fbnic_dev *fbd)
+{
+	int i, len = 0;
+
+	/* Dump includes start and end information of each section
+	 * which results in an offset of 2
+	 */
+	for (i = 0; i < ARRAY_SIZE(fbnic_csr_sects); i++)
+		len += fbnic_csr_sects[i].end - fbnic_csr_sects[i].start + 2;
+
+	return len;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index dd407089ca47..f9a531ce9e17 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -665,6 +665,15 @@ enum {
 #define FBNIC_RPC_TCAM_MACDA_VALUE		CSR_GENMASK(15, 0)
 #define FBNIC_RPC_TCAM_MACDA_MASK		CSR_GENMASK(31, 16)
 
+#define FBNIC_RPC_TCAM_OUTER_IPSRC(m, n)\
+	(0x08c00 + 0x08 * (n) + (m))		/* 0x023000 + 32*n + 4*m */
+#define FBNIC_RPC_TCAM_OUTER_IPDST(m, n)\
+	(0x08c48 + 0x08 * (n) + (m))		/* 0x023120 + 32*n + 4*m */
+#define FBNIC_RPC_TCAM_IPSRC(m, n)\
+	(0x08c90 + 0x08 * (n) + (m))		/* 0x023240 + 32*n + 4*m */
+#define FBNIC_RPC_TCAM_IPDST(m, n)\
+	(0x08cd8 + 0x08 * (n) + (m))		/* 0x023360 + 32*n + 4*m */
+
 #define FBNIC_RPC_RSS_TBL(n, m) \
 	(0x08d20 + 0x100 * (n) + (m))		/* 0x023480 + 1024*n + 4*m */
 #define FBNIC_RPC_RSS_TBL_COUNT			2
@@ -683,6 +692,13 @@ enum {
 #define FBNIC_MASTER_SPARE_0		0x0C41B		/* 0x3106c */
 #define FBNIC_CSR_END_MASTER		0x0C452	/* CSR section delimiter */
 
+/* MAC PCS registers */
+#define FBNIC_CSR_START_PCS		0x10000 /* CSR section delimiter */
+#define FBNIC_CSR_END_PCS		0x10668 /* CSR section delimiter */
+
+#define FBNIC_CSR_START_RSFEC		0x10800 /* CSR section delimiter */
+#define FBNIC_CSR_END_RSFEC		0x108c8 /* CSR section delimiter */
+
 /* MAC MAC registers (ASIC only) */
 #define FBNIC_CSR_START_MAC_MAC		0x11000 /* CSR section delimiter */
 #define FBNIC_MAC_COMMAND_CONFIG	0x11002		/* 0x44008 */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 1117d5a32867..354b5397815f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -116,8 +116,25 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
 	}
 }
 
+static void fbnic_get_regs(struct net_device *netdev,
+			   struct ethtool_regs *regs, void *data)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	fbnic_csr_get_regs(fbn->fbd, data, &regs->version);
+}
+
+static int fbnic_get_regs_len(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	return fbnic_csr_regs_len(fbn->fbd) * sizeof(u32);
+}
+
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_drvinfo		= fbnic_get_drvinfo,
+	.get_regs_len		= fbnic_get_regs_len,
+	.get_regs		= fbnic_get_regs,
 	.get_ts_info		= fbnic_get_ts_info,
 	.get_ts_stats		= fbnic_get_ts_stats,
 	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
-- 
2.43.5


