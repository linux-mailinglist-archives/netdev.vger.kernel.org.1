Return-Path: <netdev+bounces-142610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE099BFC4F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D051C2283C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4C11CD2B;
	Thu,  7 Nov 2024 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+Woo7jt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986312B63;
	Thu,  7 Nov 2024 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945159; cv=none; b=WeBT2Gt+vYSZnEVdsnlMgXTfrgm82u/2wugCtv+aj/H6uxUXmm7Psm5QZkW9FYfPGlOOPNt+flUWfVh9D+u48OkDe0ZEnFtkWwJWrqusdiHRu4ORsamy8SpfFRS8a6ZLCjUidtk8O+W/vrP8xX+Wa1bU//XMgNcTXZPuZseZx5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945159; c=relaxed/simple;
	bh=DDDjae2/2sJOrdAym8U2UMDV5vGP6TgBpRl8o46nmio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HfDmT+UPaBHZjrwgVI4KYLkc5kGR+98G0j5G9RF4rJ6hz0vCsq3ZljbUmT3UAyKZJJqOZ2PEJuLzfusKb+7i1hSGjj62iYrl1K1icfTa9+vdevLZnyouP/JJmH5P/oJUBb/cfT2J/4LiY7bK/db1cuh+DdElv2xQFPBwPYZ7M6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+Woo7jt; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a6bfc1dc8eso2077405ab.1;
        Wed, 06 Nov 2024 18:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945156; x=1731549956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgEcCxJ+vSGeMhm3xx61MSV2wsR7XP5lXQM+qvnm9uY=;
        b=d+Woo7jtzB3zn3mBXsSLiHAJap5y7bHZf8RYS54/bEPZQ5VhoTplZ5aY75c1VH3wzu
         c9iTHqmpcfL72mWsHAkO+z3BtXOB/gHdLjoCUnaeepWnmNPPbzlRQXL4bFCbWyYDBmmI
         DqiwvBVlW9EndiwKvsdfA/9xYUKEtdoNX/Q/a2s2kmQhqYIoXjuCj5g6XXdeadD1LBE5
         CXdSqoXrb7wEEDEdnghRZC11Nsr4FE/hrKKwHwFdAeVwJwr3Z4OAsUiEiKuOnemWRxdW
         qDuzsrLMC65M1fPb1p4YkFvQfPX0JNYMCOB6A2D+5t54gJzHA9jv1szOeHkQ1ENTUaPS
         kV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945156; x=1731549956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgEcCxJ+vSGeMhm3xx61MSV2wsR7XP5lXQM+qvnm9uY=;
        b=Lo6IXshcwzlBiyNGTA74QWnohYl8E7AiaML+QSi69jZAnqz+WNPLx6DTKqo+7j2Bdq
         SmN4Lle0T6KxEXsA3D/RSlk2IhpMcGyIQKGulYgsqz69mF8Rvrsr3KZD3Ihm24kjdsIA
         g8X5grSAugFPxZAKUUM9kti0KcSrnJ9lm/yaSjjI2XtleBQ/lnON5MoO7xNPZbHtTrBb
         wpCV4mstHlmJdKZSXXNaqztDX3Ft484608XH9aifwwuTUQv4qSKbc9te8ZRZ8mJPJ7sm
         tMBDK4Cwc0LplLOuxYpfxzyjfC7RG8cFw97/gWKEgFWabiXMPTqkvjYrZM+nG0tPWHQ4
         LQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCV6xLBwPJAdeKxHZfugyssaZ7GpqANPUjZlvcrKe8uGAqcOD7a1vogOTO4wSF/MAg2L4Vn+LSDgmTo=@vger.kernel.org, AJvYcCX+ha8gjyW/t+8+NK7Z0qaoxgHD0HWTBMwclJsFMlrmnbW8VOhNTtjpaazeKygbwjAwZu4qDlT6e7Kei1Gz@vger.kernel.org
X-Gm-Message-State: AOJu0YxvoZPmCY854Fz23kvb+9QCnfGnzd5VdLMQgOl4DThQVIKqdtPA
	w/YLtvzTtyyPbTQYCzMlkvxGY5xixqk/0pGSWHbei/ZjLAGG4RqI+NRUxaaM
X-Google-Smtp-Source: AGHT+IGV/viUi+Z/f8UPB3vsHgORPSReBIDTUJnpLbmGttm8PJBxlSWePUTdS6VaLZKXH09czGPNAw==
X-Received: by 2002:a05:6e02:1d9e:b0:3a2:7592:2c5 with SMTP id e9e14a558f8ab-3a6b031a2e7mr229105845ab.17.1730945156304;
        Wed, 06 Nov 2024 18:05:56 -0800 (PST)
Received: from localhost (fwdproxy-prn-036.fbsv.net. [2a03:2880:ff:24::face:b00c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f64386asm201379a12.57.2024.11.06.18.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:05:55 -0800 (PST)
From: Sanman Pradhan <sanman.p211993@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	kernel-team@meta.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch,
	vadim.fedorenko@linux.dev,
	jdamato@fastly.com,
	sdf@fomichev.me,
	sanman.p211993@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] eth: fbnic: Add PCIe hardware statistics
Date: Wed,  6 Nov 2024 18:05:55 -0800
Message-ID: <20241107020555.321245-1-sanman.p211993@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PCIe hardware statistics support to the fbnic driver. These stats
provide insight into PCIe transaction performance and error conditions.

Which includes, read/write and completion TLP counts and DWORD counts and
debug counters for tag, completion credit and NP credit exhaustion

The stats are exposed via ethtool and can be used to monitor PCIe
performance and debug PCIe issues.

Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
---
v1:
	- https://patchwork.kernel.org/project/netdevbpf/patch/20241106002625.1857904-1-sanman.p211993@gmail.com/
	- Removed unnecessary code blocks
	- Rephrased the commit message
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  27 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  39 ++++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  77 +++++++++++-
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  12 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   2 +
 7 files changed, 272 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 32ff114f5c26..31c6371c45f8 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -27,3 +27,30 @@ driver takes over.
 devlink dev info provides version information for all three components. In
 addition to the version the hg commit hash of the build is included as a
 separate entry.
+
+
+PCIe Statistics
+---------------
+
+The fbnic driver exposes PCIe hardware performance statistics through ethtool.
+These statistics provide insights into PCIe transaction behavior and potential
+performance bottlenecks.
+
+Statistics Categories
+
+1. PCIe Transaction Counters:
+
+   These counters track PCIe transaction activity:
+        - pcie_ob_rd_tlp: Outbound read Transaction Layer Packets count
+        - pcie_ob_rd_dword: DWORDs transferred in outbound read transactions
+        - pcie_ob_wr_tlp: Outbound write Transaction Layer Packets count
+        - pcie_ob_wr_dword: DWORDs transferred in outbound write transactions
+        - pcie_ob_cpl_tlp: Outbound completion TLP count
+        - pcie_ob_cpl_dword: DWORDs transferred in outbound completion TLPs
+
+2. PCIe Resource Monitoring:
+
+   These counters indicate PCIe resource exhaustion events:
+        - pcie_ob_rd_no_tag: Read requests dropped due to tag unavailability
+        - pcie_ob_rd_no_cpl_cred: Read requests dropped due to completion credit exhaustion
+        - pcie_ob_rd_no_np_cred: Read requests dropped due to non-posted credit exhaustion
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 79cdd231d327..9ee562acbdfc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -882,6 +882,45 @@ enum {
 #define FBNIC_MAX_QUEUES		128
 #define FBNIC_CSR_END_QUEUE	(0x40000 + 0x400 * FBNIC_MAX_QUEUES - 1)

+#define FBNIC_TCE_DROP_CTRL		0x0403d		/* 0x100f0*/
+
+/* PUL User Registers*/
+#define FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0 \
+					0x3106e		/* 0xc41b8 */
+#define FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0 \
+					0x31070		/* 0xc41c0 */
+#define FBNIC_PUL_USER_OB_RD_DWORD_CNT_63_32 \
+					0x31071		/* 0xc41c4 */
+#define FBNIC_PUL_USER_OB_WR_TLP_CNT_31_0 \
+					0x31072		/* 0xc41c8 */
+#define FBNIC_PUL_USER_OB_WR_TLP_CNT_63_32 \
+					0x31073		/* 0xc41cc */
+#define FBNIC_PUL_USER_OB_WR_DWORD_CNT_31_0 \
+					0x31074		/* 0xc41d0 */
+#define FBNIC_PUL_USER_OB_WR_DWORD_CNT_63_32 \
+					0x31075		/* 0xc41d4 */
+#define FBNIC_PUL_USER_OB_CPL_TLP_CNT_31_0 \
+					0x31076		/* 0xc41d8 */
+#define FBNIC_PUL_USER_OB_CPL_TLP_CNT_63_32 \
+					0x31077		/* 0xc41dc */
+#define FBNIC_PUL_USER_OB_CPL_DWORD_CNT_31_0 \
+					0x31078		/* 0xc41e0 */
+#define FBNIC_PUL_USER_OB_CPL_DWORD_CNT_63_32 \
+					0x31079		/* 0xc41e4 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_31_0 \
+					0x3107a		/* 0xc41e8 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_63_32 \
+					0x3107b		/* 0xc41ec */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_31_0 \
+					0x3107c		/* 0xc41f0 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_63_32 \
+					0x3107d		/* 0xc41f4 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_31_0 \
+					0x3107e		/* 0xc41f8 */
+#define FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_63_32 \
+					0x3107f		/* 0xc41fc */
+#define FBNIC_CSR_END_PUL_USER	0x31080	/* CSR section delimiter */
+
 /* BAR 4 CSRs */

 /* The IPC mailbox consists of 32 mailboxes, with each mailbox consisting
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 1117d5a32867..9f590a42a9df 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -6,6 +6,39 @@
 #include "fbnic_netdev.h"
 #include "fbnic_tlv.h"

+struct fbnic_stat {
+	u8 string[ETH_GSTRING_LEN];
+	unsigned int size;
+	unsigned int offset;
+};
+
+#define FBNIC_STAT_FIELDS(type, name, stat) { \
+	.string = name, \
+	.size = sizeof_field(struct type, stat), \
+	.offset = offsetof(struct type, stat), \
+}
+
+/* Hardware statistics not captured in rtnl_link_stats */
+#define FBNIC_HW_STAT(name, stat) \
+	FBNIC_STAT_FIELDS(fbnic_hw_stats, name, stat)
+
+static const struct fbnic_stat fbnic_gstrings_hw_stats[] = {
+	/* PCIE */
+	FBNIC_HW_STAT("pcie_ob_rd_tlp", pcie.ob_rd_tlp),
+	FBNIC_HW_STAT("pcie_ob_rd_dword", pcie.ob_rd_dword),
+	FBNIC_HW_STAT("pcie_ob_wr_tlp", pcie.ob_wr_tlp),
+	FBNIC_HW_STAT("pcie_ob_wr_dword", pcie.ob_wr_dword),
+	FBNIC_HW_STAT("pcie_ob_cpl_tlp", pcie.ob_cpl_tlp),
+	FBNIC_HW_STAT("pcie_ob_cpl_dword", pcie.ob_cpl_dword),
+	FBNIC_HW_STAT("pcie_ob_rd_no_tag", pcie.ob_rd_no_tag),
+	FBNIC_HW_STAT("pcie_ob_rd_no_cpl_cred", pcie.ob_rd_no_cpl_cred),
+	FBNIC_HW_STAT("pcie_ob_rd_no_np_cred", pcie.ob_rd_no_np_cred),
+};
+
+#define FBNIC_HW_FIXED_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_stats)
+#define FBNIC_HW_STATS_LEN \
+	(FBNIC_HW_FIXED_STATS_LEN)
+
 static int
 fbnic_get_ts_info(struct net_device *netdev,
 		  struct kernel_ethtool_ts_info *tsinfo)
@@ -51,6 +84,43 @@ static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
 		*stat = counter->value;
 }

+static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
+{
+	int i;
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < FBNIC_HW_STATS_LEN; i++)
+			ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
+		break;
+	}
+}
+
+static int fbnic_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return FBNIC_HW_STATS_LEN;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void fbnic_get_ethtool_stats(struct net_device *dev,
+				    struct ethtool_stats *stats, u64 *data)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+	const struct fbnic_stat *stat;
+	int i;
+
+	fbnic_get_hw_stats(fbn->fbd);
+
+	for (i = 0; i < FBNIC_HW_STATS_LEN; i++) {
+		stat = &fbnic_gstrings_hw_stats[i];
+		data[i] = *(u64 *)((u8 *)&fbn->fbd->hw_stats + stat->offset);
+	}
+}
+
 static void
 fbnic_get_eth_mac_stats(struct net_device *netdev,
 			struct ethtool_eth_mac_stats *eth_mac_stats)
@@ -117,10 +187,13 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
 }

 static const struct ethtool_ops fbnic_ethtool_ops = {
-	.get_drvinfo		= fbnic_get_drvinfo,
 	.get_ts_info		= fbnic_get_ts_info,
-	.get_ts_stats		= fbnic_get_ts_stats,
+	.get_drvinfo		= fbnic_get_drvinfo,
+	.get_strings		= fbnic_get_strings,
+	.get_sset_count		= fbnic_get_sset_count,
+	.get_ethtool_stats	= fbnic_get_ethtool_stats,
 	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
+	.get_ts_stats		= fbnic_get_ts_stats,
 };

 void fbnic_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index a0acc7606aa1..eb19b49fe306 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -25,3 +25,117 @@ u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset)
 	 */
 	return ((u64)upper << 32);
 }
+
+static void fbnic_hw_stat_rst64(struct fbnic_dev *fbd, u32 reg, s32 offset,
+				struct fbnic_stat_counter *stat)
+{
+	/* Record initial counter values and compute deltas from there to ensure
+	 * stats start at 0 after reboot/reset. This avoids exposing absolute
+	 * hardware counter values to userspace.
+	 */
+	stat->u.old_reg_value_64 = fbnic_stat_rd64(fbd, reg, offset);
+}
+
+static void fbnic_hw_stat_rd64(struct fbnic_dev *fbd, u32 reg, s32 offset,
+			       struct fbnic_stat_counter *stat)
+{
+	u64 new_reg_value;
+
+	new_reg_value = fbnic_stat_rd64(fbd, reg, offset);
+	stat->value += new_reg_value - stat->u.old_reg_value_64;
+	stat->u.old_reg_value_64 = new_reg_value;
+}
+
+static void fbnic_reset_pcie_stats_asic(struct fbnic_dev *fbd,
+					struct fbnic_pcie_stats *pcie)
+{
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0,
+			    1,
+			    &pcie->ob_rd_tlp);
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0,
+			    1,
+			    &pcie->ob_rd_dword);
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_PUL_USER_OB_CPL_TLP_CNT_31_0,
+			    1,
+			    &pcie->ob_cpl_tlp);
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_PUL_USER_OB_CPL_DWORD_CNT_31_0,
+			    1,
+			    &pcie->ob_cpl_dword);
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_PUL_USER_OB_WR_TLP_CNT_31_0,
+			    1,
+			    &pcie->ob_wr_tlp);
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_PUL_USER_OB_WR_DWORD_CNT_31_0,
+			    1,
+			    &pcie->ob_wr_dword);
+
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_31_0,
+			    1,
+			    &pcie->ob_rd_no_tag);
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_31_0,
+			    1,
+			    &pcie->ob_rd_no_cpl_cred);
+	fbnic_hw_stat_rst64(fbd,
+			    FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_31_0,
+			    1,
+			    &pcie->ob_rd_no_np_cred);
+}
+
+static void fbnic_get_pcie_stats_asic64(struct fbnic_dev *fbd,
+					struct fbnic_pcie_stats *pcie)
+{
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0,
+			   1,
+			   &pcie->ob_rd_tlp);
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0,
+			   1,
+			   &pcie->ob_rd_dword);
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_PUL_USER_OB_WR_TLP_CNT_31_0,
+			   1,
+			   &pcie->ob_wr_tlp);
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_PUL_USER_OB_WR_DWORD_CNT_31_0,
+			   1,
+			   &pcie->ob_wr_dword);
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_PUL_USER_OB_CPL_TLP_CNT_31_0,
+			   1,
+			   &pcie->ob_cpl_tlp);
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_PUL_USER_OB_CPL_DWORD_CNT_31_0,
+			   1,
+			   &pcie->ob_cpl_dword);
+
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_31_0,
+			   1,
+			   &pcie->ob_rd_no_tag);
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_31_0,
+			   1,
+			   &pcie->ob_rd_no_cpl_cred);
+	fbnic_hw_stat_rd64(fbd,
+			   FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_31_0,
+			   1,
+			   &pcie->ob_rd_no_np_cred);
+}
+
+void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
+{
+	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
+}
+
+void fbnic_get_hw_stats(struct fbnic_dev *fbd)
+{
+	fbnic_get_pcie_stats_asic64(fbd, &fbd->hw_stats.pcie);
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index 30348904b510..39d8b3f62d8f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -11,6 +11,16 @@ struct fbnic_stat_counter {
 	bool reported;
 };

+struct fbnic_pcie_stats {
+	struct fbnic_stat_counter ob_rd_tlp, ob_rd_dword;
+	struct fbnic_stat_counter ob_wr_tlp, ob_wr_dword;
+	struct fbnic_stat_counter ob_cpl_tlp, ob_cpl_dword;
+
+	struct fbnic_stat_counter ob_rd_no_tag;
+	struct fbnic_stat_counter ob_rd_no_cpl_cred;
+	struct fbnic_stat_counter ob_rd_no_np_cred;
+};
+
 struct fbnic_eth_mac_stats {
 	struct fbnic_stat_counter FramesTransmittedOK;
 	struct fbnic_stat_counter FramesReceivedOK;
@@ -33,8 +43,10 @@ struct fbnic_mac_stats {

 struct fbnic_hw_stats {
 	struct fbnic_mac_stats mac;
+	struct fbnic_pcie_stats pcie;
 };

 u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset);

+void fbnic_reset_hw_stats(struct fbnic_dev *fbd);
 void fbnic_get_hw_stats(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index c08798fad203..9cb850b78795 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -627,6 +627,9 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)

 	fbnic_reset_queues(fbn, default_queues, default_queues);

+	/* Capture snapshot of hardware stats so netdev can calculate delta */
+	fbnic_reset_hw_stats(fbd);
+
 	fbnic_reset_indir_tbl(fbn);
 	fbnic_rss_key_fill(fbn->rss_key);
 	fbnic_rss_init_en_mask(fbn);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 2de5a6fde7e8..cd1fe1114819 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -455,6 +455,8 @@ static void __fbnic_pm_attach(struct device *dev)
 	struct net_device *netdev = fbd->netdev;
 	struct fbnic_net *fbn;

+	fbnic_reset_hw_stats(fbd);
+
 	if (fbnic_init_failure(fbd))
 		return;

--
2.43.5

