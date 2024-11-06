Return-Path: <netdev+bounces-142141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB779BDA42
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B2E1F2434F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F19ACA5B;
	Wed,  6 Nov 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2LQ8D+6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546880B;
	Wed,  6 Nov 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852789; cv=none; b=QtMrmQkRKIPMu8MIPkiJ7lyvagJgsXEzEtsXJr7/Re54tcjQWG4EoL2JJhPQ7WKKqgjIFw3obI3WNnPbf3B6+nLUWuWiXK0GK3ojQMk7Oxk28clG2p2PxjSAFPOOXmjPARx+/dA63/qe0ZY6nObMkgOMfX5sywjaSqjtHKk0vDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852789; c=relaxed/simple;
	bh=5syg6IcFL+X6xshG3yM0xl986OEFBxGzoLVfk6Vq1g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXsGyphV5L3tInPLtSRxdEcIGnxditK3EkNIkLh1J8T95/EXZeBMxgBpdX0MX5S/1HlBzmeM8EhVgrnmn+B7VC76bQ2MAOv057AW8nQn6bu82JFY2QBCH31tcm8b77VSwizSWKR58b0uE/5WyQOuvUst4SLd0bpidYa+Z9J/A3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2LQ8D+6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so4592059a12.1;
        Tue, 05 Nov 2024 16:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730852787; x=1731457587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64tOp7EWdaLLShJ9e30DKuX+hso6z7A9q54lerqgD6E=;
        b=D2LQ8D+6Yw/27GOzn4QBehp2w4VwQcC5TWo940JgwigyqgzsRq7R+TonPxq9VrI3Pz
         YVia+uFOMoSfFBWh0k9hZhNlDFnVdotPmmp7XBvKWKVhA1N2phiZFYyWsTzGkkP7oEPP
         zv+LrKKeGvbtDSw9KwhLlMx+owPK/wNq+GonhP7YKZbvA02LgrKHwPfsJJTvGgB5ccDD
         RShdVPTKPVFVTBUD7YFE1NImAL0mfrc6GeKTjiJiEKG1zRn2DCk0lH8qK4vGugBTMxcB
         j1T58pbkNc/xL2TaQYNyGIOZdsLRGECuXLt4KQapvjFz2bi+DbuvD51YcFEOh3IADnnE
         jZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730852787; x=1731457587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64tOp7EWdaLLShJ9e30DKuX+hso6z7A9q54lerqgD6E=;
        b=pLSdna9wdr96+rk67uqUJaAgOmZkIbtcdY11hZyo0V62XpJM52C5tav9fHvTes/0t4
         ScDRq3AM+h9M/X4WPeeoaZGWOFsPcOo9Rhv9RJz9rERcC8ISbWGFoVlbgRaA2cY9fDKr
         rhxdf0CYNI3+EKe790Avbfhn4DS6NxxuiwCbqXc57YkopOrUNCf6zRoE/k5xUVu4i6Xo
         HPWJulMuOLx9un4XQ1A4n9IQ3mgz+8LSCmiCuNFNajiveTZDsVeeywKji8KsT3saQjDr
         Qro8pM+jZy5XBTJsmMMDyJDcE83xld0yidDqeB1KCTs7sLdxCGyCdwat7yxY4MZ6qGdI
         NjOw==
X-Forwarded-Encrypted: i=1; AJvYcCVRx+r7wZpsBsuU09W6FACCPeRM9DULoZB85Dqk7IwIgacdKbqb5mXhzQGGUsTgZL0ZXTQlaVvKs6DaEd1X@vger.kernel.org, AJvYcCX40EmTIQbo/QWal8EoCinefX5/otN3z7fp65cYG99RzTaMmLqn+C1wjK+04V/kpeI12krOfSOT2AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwqEJ8Mbndwgat7o3t3GTvn715hJc7Lbedxviq/BOeW/T6h49C
	H+7Bt31fNdETGxTpeoOSLHO5jxKiSdwdcse8uZMXEWOsOKx4Dxim71HgT5tl
X-Google-Smtp-Source: AGHT+IEXR0UM1pNdHmUOdURIDsawjuhpl7KrERDdIynTPMV6kSIeQupyh2BWQ341jNVGYvBlz72H/g==
X-Received: by 2002:a05:6a20:d807:b0:1d9:87e3:11f5 with SMTP id adf61e73a8af0-1db91e5358amr30912254637.37.1730852786573;
        Tue, 05 Nov 2024 16:26:26 -0800 (PST)
Received: from localhost (fwdproxy-prn-032.fbsv.net. [2a03:2880:ff:20::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d44cesm85233315ad.255.2024.11.05.16.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 16:26:26 -0800 (PST)
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
Subject: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Date: Tue,  5 Nov 2024 16:26:25 -0800
Message-ID: <20241106002625.1857904-1-sanman.p211993@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PCIe hardware statistics support to the fbnic driver. These stats
provide insight into PCIe transaction performance and error conditions,
including, read/write and completion TLP counts and DWORD counts and
debug counters for tag, completion credit and NP credit exhaustion

The stats are exposed via ethtool and can be used to monitor PCIe
performance and debug PCIe issues.

Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  27 +++++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  39 ++++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  77 +++++++++++-
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  17 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   2 +
 8 files changed, 278 insertions(+), 2 deletions(-)

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
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index fec567c8fe4a..a8fedff48103 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -6,6 +6,7 @@

 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/netdevice.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
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
index 30348904b510..0be403ac211b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -11,6 +11,21 @@ struct fbnic_stat_counter {
 	bool reported;
 };

+struct fbnic_hw_stat {
+	struct fbnic_stat_counter frames;
+	struct fbnic_stat_counter bytes;
+};
+
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
@@ -33,8 +48,10 @@ struct fbnic_mac_stats {

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

