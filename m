Return-Path: <netdev+bounces-144245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392C9C6440
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 23:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E4C1F23567
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947BA21A4A7;
	Tue, 12 Nov 2024 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3T1Cbum"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84200219C9E
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450439; cv=none; b=UOK1yqZEulHXEFkvZVG6a5gdGUdfHlpmX3ynqsGTm8HWZ6abqTmrNGgmuMjnlmX25fKNcOzx2wGoD5bKFOn2e7c3o65FYXqhMnmbiLr1c0mocElE8YmJYbwNrioSLLXmSwLhGfMQ3gXkums8RXXTN+X8UdCCQ54gqYhxhA5A8qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450439; c=relaxed/simple;
	bh=sg2GGwe+GEJNAY9kG3fTYYnMJbskhFLnik0aon5qHtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAjz8CJrWDkayd4+okwX7Ji1JtthEijY5UvwFcBnyqcmJTqXHCXR+cw+ty5VhRWBMwvBSYpU7yaxS1Ko05+RURSC9jhrluTvhb/cFGkbXaxKl+aPN6Ef68gdqtdlIO7qyAMO4KjDe7gLeh4RvbvWW0iGPRiF21xB5G6wRipQj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3T1Cbum; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so54047495e9.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 14:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731450435; x=1732055235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEaTTPqYYsxTrW2GB0+bNm08wUNSaYsHd4gF9Vdgdqc=;
        b=j3T1Cbum24DH+WYBBNpQmmKNJe4T0o6DR5isp8KHT50ZZ9CrH0IUSBl36rrjAuW7sS
         LHaWqEWThWwex2OD9WFtn9LlswZn3QiBZjtJEtroLQ0+o06LvvADr8PoDXjwcZGruAyg
         gnPBnKvbRtVqRmyJwUJThMeF/bQYdQFfQ5XprAm3RI32zAI3LVvOzaZAIEPmgc598mRH
         ccX/DesK5dZMCA7DEVaNRcxYovDvKzPhX2VxLTJGPNXhD14bIttoB26MgpqzN8EyHwyG
         gKH6V0XSGb+GjqzOAJGAUH21psggno75Byhjalyte/sehxxNCF58zZHAgiU60LDk3fWe
         9wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731450435; x=1732055235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEaTTPqYYsxTrW2GB0+bNm08wUNSaYsHd4gF9Vdgdqc=;
        b=Rm9F964OVsOkONGfydN4Nzd279MKixLvfQnAfR6NGkr1ehsg2Hhj3y780Gpcxpart8
         CH5rJZca3G6MVBUZq6tZmC5Uw2dKL+4jgt0oJsG0+u/9TUa8Elyfa4hDsxafseCBPe1A
         y1h4ExRTgkA/mtUMeJCH7y3kAY1NSaheU9+3hhjz9gstNjFbDD48x91v31Dde06xRrU3
         6iTp0h0P2Vo6OEJ1Fsa0QRRmbkoL6apEZ23vVp7vBEBRg+KLEZJ/18u6co3fkW9YwtJG
         zRt/ufogYPjvKjRqsWkYVLkYlyRkHEuJVCkbOrrjY3bySWxhRjkTv4aRJTw4/DOU1PUO
         1jBA==
X-Gm-Message-State: AOJu0YzMhhTpIset0C3OB32m/h11GSz1EIvy2NBreZtchE4TAmjIKPY2
	EiiQaGJb8m4OtZthQsgvWW/Cw5lrdJ8g+ILSyXCZ/KwRZROAbpEnO4qnig==
X-Google-Smtp-Source: AGHT+IEqXVWeiXutjaIvnPRav5gbwTz/W+/ky9JoWw/QzxuBBOgjshf7+XHg7O/LsNctwRQgvGcKlg==
X-Received: by 2002:a5d:5849:0:b0:37d:4318:d8e1 with SMTP id ffacd0b85a97d-381f186db1amr13204803f8f.23.1731450435054;
        Tue, 12 Nov 2024 14:27:15 -0800 (PST)
Received: from localhost (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97ce0fsm16396275f8f.33.2024.11.12.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 14:27:14 -0800 (PST)
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
Subject: [PATCH net-next v2] eth: fbnic: Add support to dump registers
Date: Tue, 12 Nov 2024 14:26:05 -0800
Message-ID: <20241112222605.3303211-1-mohsin.bashr@gmail.com>
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
V2: Add missing SPDX license identifier
V1: https://lore.kernel.org/netdev/20241108013253.3934778-1-mohsin.bashr@gmail.com
---
 drivers/net/ethernet/meta/fbnic/Makefile      |   3 +-
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c   | 148 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  16 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  17 ++
 5 files changed, 186 insertions(+), 1 deletion(-)
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
index 000000000000..2118901b25e9
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
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


