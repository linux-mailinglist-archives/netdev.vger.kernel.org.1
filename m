Return-Path: <netdev+bounces-143433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43A79C26CD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09865B20FC4
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82271D0F6C;
	Fri,  8 Nov 2024 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StmRAeTm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC13A1D0B81;
	Fri,  8 Nov 2024 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098803; cv=none; b=QShTbnR5s6uNm+TW8XX8TdyjvVvmT6VsQR4vR0uZE93U1mYH0xOI6JE2+FnHz44D6furyTKKo1mGvTBvLoZzaB3zhZK8U2/vR4n6xI3mgsdJh/pl4XzGw5Ea9Iqp/hE2JX8SdtMcKlcgjxiCMFTGWdEilJAVXnazOd7lHd0gW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098803; c=relaxed/simple;
	bh=Ru4cQ6EsPweb8JntuE4SXLhVClFuwF6/Z+o+VpAiSi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeDLi35O336C3F1LUERrYjOxb3g/pqKFgXeUhA7tekCzcRe0QgzML7aznET26TBKSfQDLX3cecUieXX2DCFRsIc+auVa1+1jq9OTReAtVZRucEu/kz9eG10anIV/Ww4MiSOIFsghMXghz8DJhXrzpxKIk2moqVgDVTGSasmBev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StmRAeTm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720c2db824eso2810085b3a.0;
        Fri, 08 Nov 2024 12:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098801; x=1731703601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGFTnb3SLUA1C/PUv6Qnxn9YYJABuVhsI0lxDk1SqD4=;
        b=StmRAeTmm80mJUE2Cvj/aPKxx2OgpVMLflwm4gUR6lsFETafEHqK1RNGNmF1+x3qoe
         fiOVqgm8fIa83amT+8VCqqxBQK9jR0W43zJadCqPt91hSIjCLHBBo6SKb1quZnzTRgk2
         8ul9+6tDSVh5eZSqXpMQNsdRS+H2aSNEtY039IqEtYv4gYOwMsok2l8x1kleNNMIrHb2
         ywpuxLXe+Za5YfJ6v93dQU4GDNispw4fU/F8GfdCnm3h9rtiaRJN4/gl8gBDM8eNKzFG
         FVzGXZ/I1wqYCXIud2XV6gio2K4MjDi+PX2jvvmf8feMCYhsDKDS5mzmtaXpEdiS5r0S
         4d4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098801; x=1731703601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGFTnb3SLUA1C/PUv6Qnxn9YYJABuVhsI0lxDk1SqD4=;
        b=QysLNZhHNWxWdZGT860KGFIQcAM8dKnEL7mkWCIO9L8jWcHNvCbysuqspQ/K+VG/nc
         YS3IGHhTxIa6maMc9Twqt043MVTKwF8zd4cx1VCEKqdLU0d5HfCsLvCUW9CT4SGkEwnW
         qbdG0H/T2GPBOZ2zvGf43wTEEwK5vNied9usgkK204NH1Hp7gVCuj4eIgySw4rPaW2u5
         xcyzxsuLOpiBwMJo9OBp3R9j6fS9YLxFvHHx0SL4EocfiIbzf0DtKW6i+WMzA+XyvxBe
         HjOjSeFVzYbhbY4WhTRxlugtk05xT7CzT8DRgpSTCrjW+t29ZBKtq9YjUgyNFxxpkWh4
         3IIg==
X-Forwarded-Encrypted: i=1; AJvYcCUwNLHQ1cZs2B3FM1I+WsYbYSRrsmoWRT4KWDGRic1ItpQoDF8ESoVue1hvwLbXizrQRT/lu6MkMyc=@vger.kernel.org, AJvYcCWsOSf7v/JmI8VJbCIBnn8sYuQ+i6UcwEfcj/eOEg6f1w2LdXW+Dk2UKZLRewFwA6e4gnMPuPl9oyVcn4bS@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnwLTgxc4+YtPtuKavqWqfhHm9oA3dYZvMkV7DE33Mvg3kdT7
	WHE7kOfgWwvsBoRVdXLdcl1/EXYk/iqowmrwQxpkErmlcmCoyA7tEkJwXAJR
X-Google-Smtp-Source: AGHT+IHYGcXna26MQC11xRPCw/QgjQgA2ATFsyE8BpwCc/+V11bsrECyuKQ3kpCwGvQVNDeQKsnj2Q==
X-Received: by 2002:a05:6a20:6a0c:b0:1d9:c862:2c58 with SMTP id adf61e73a8af0-1dc2292c520mr6067259637.12.1731098801029;
        Fri, 08 Nov 2024 12:46:41 -0800 (PST)
Received: from localhost (fwdproxy-prn-026.fbsv.net. [2a03:2880:ff:1a::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799bae1sm4203371b3a.94.2024.11.08.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:46:40 -0800 (PST)
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
Subject: [PATCH net-next v3] eth: fbnic: Add PCIe hardware statistics
Date: Fri,  8 Nov 2024 12:46:40 -0800
Message-ID: <20241108204640.3165724-1-sanman.p211993@gmail.com>
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

The stats are exposed via debugfs and can be used to monitor PCIe
performance and debug PCIe issues.

Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  26 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  37 ++++++
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  46 +++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  12 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
 6 files changed, 238 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 32ff114f5c26..13ebcdbb5f22 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -27,3 +27,29 @@ driver takes over.
 devlink dev info provides version information for all three components. In
 addition to the version the hg commit hash of the build is included as a
 separate entry.
+
+PCIe Statistics
+---------------
+
+The fbnic driver exposes PCIe hardware performance statistics through debugfs
+(``pcie_stats``). These statistics provide insights into PCIe transaction
+behavior and potential performance bottlenecks.
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
index e78745332d82..463fd5d54d35 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -917,6 +917,43 @@ enum {
 #define FBNIC_MAX_QUEUES		128
 #define FBNIC_CSR_END_QUEUE	(0x40000 + 0x400 * FBNIC_MAX_QUEUES - 1)

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
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
new file mode 100644
index 000000000000..38736c4b42d0
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/debugfs.h>
+#include <linux/pci.h>
+#include <linux/rtnetlink.h>
+#include <linux/seq_file.h>
+#include "fbnic.h"
+
+static struct dentry *fbnic_dbg_root;
+
+static int fbnic_dbg_pcie_stats_show(struct seq_file *s, void *v)
+{
+	struct fbnic_dev *fbd = s->private;
+
+	rtnl_lock();
+
+	fbnic_get_hw_stats(fbd);
+
+	seq_printf(s, "ob_rd_tlp: %llu\n", fbd->hw_stats.pcie.ob_rd_tlp.value);
+	seq_printf(s, "ob_rd_dword: %llu\n", fbd->hw_stats.pcie.ob_rd_dword.value);
+	seq_printf(s, "ob_wr_tlp: %llu\n", fbd->hw_stats.pcie.ob_wr_tlp.value);
+	seq_printf(s, "ob_wr_dword: %llu\n", fbd->hw_stats.pcie.ob_wr_dword.value);
+	seq_printf(s, "ob_cpl_tlp: %llu\n", fbd->hw_stats.pcie.ob_cpl_tlp.value);
+	seq_printf(s, "ob_cpl_dword: %llu\n", fbd->hw_stats.pcie.ob_cpl_dword.value);
+	seq_printf(s, "ob_rd_no_tag: %llu\n", fbd->hw_stats.pcie.ob_rd_no_tag.value);
+	seq_printf(s, "ob_rd_no_cpl_cred: %llu\n", fbd->hw_stats.pcie.ob_rd_no_cpl_cred.value);
+	seq_printf(s, "ob_rd_no_np_cred: %llu\n", fbd->hw_stats.pcie.ob_rd_no_np_cred.value);
+
+	rtnl_unlock();
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_pcie_stats);
+
+void fbnic_dbg_init(void)
+{
+	fbnic_dbg_root = debugfs_create_dir(fbnic_driver_name, NULL);
+	debugfs_create_file("pcie_stats", 0400, fbnic_dbg_root, NULL, &fbnic_dbg_pcie_stats_fops);
+}
+
+void fbnic_dbg_exit(void)
+{
+	debugfs_remove_recursive(fbnic_dbg_root);
+	fbnic_dbg_root = NULL;
+}
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
index 30348904b510..036cc065a857 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -31,10 +31,22 @@ struct fbnic_mac_stats {
 	struct fbnic_eth_mac_stats eth_mac;
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
 struct fbnic_hw_stats {
 	struct fbnic_mac_stats mac;
+	struct fbnic_pcie_stats pcie;
 };

 u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset);

+void fbnic_reset_hw_stats(struct fbnic_dev *fbd);
 void fbnic_get_hw_stats(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index fc7d80db5fa6..04077649161b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -628,6 +628,9 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)

 	fbnic_reset_queues(fbn, default_queues, default_queues);

+	/* Capture snapshot of hardware stats so netdev can calculate delta */
+	fbnic_reset_hw_stats(fbd);
+
 	fbnic_reset_indir_tbl(fbn);
 	fbnic_rss_key_fill(fbn->rss_key);
 	fbnic_rss_init_en_mask(fbn);
--
2.43.5

