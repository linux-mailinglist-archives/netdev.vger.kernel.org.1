Return-Path: <netdev+bounces-143834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4549C4637
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 20:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41DB1F22579
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632C11AC423;
	Mon, 11 Nov 2024 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHNwONFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5EA1A2C04;
	Mon, 11 Nov 2024 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355039; cv=none; b=tQuDqE9YlgcM4yhMRpQD4XmC4BuLiiWG1U7ZA2Ey5FxJ+hX0CcBDnKxUTfXx6p/NEOSRxono7vwt+Ruon/7O6zvfUJTKjo2K9YfBUNDphSo2Vz9hMExx6mCdDikpimCWWw8E9pwhg/TDzz+0F2MVnygYZnhUuolIdH7QRuF9htQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355039; c=relaxed/simple;
	bh=ixQfwqIBV23CnIVmQgrR5STGTXQmFG2tnheOZ29q8xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjC89u23fpHfBnpZ7nWmzSjRy9+1PKV9vpWgo8ShTq62bOpwz4mwdMNi9CmD9/U2JyNnM0Lgfu3Q1fgGZNQwbjVE9HYJodqEtYPdF9A5vd+joVHRa5GUMC1q8TznzwsVi/AxdTqdA4mQZZ2OloLoCOGyAIxb/5XHv2Unuf1JsBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHNwONFP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cb7139d9dso44906365ad.1;
        Mon, 11 Nov 2024 11:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731355036; x=1731959836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=On/yC3RUvFS85378pjUf+gJ5SwNriK0XjwcZ/D8nm/Y=;
        b=SHNwONFPDvj3vSh4NzJJfdDebFElzUqkIsA7OEuPf4+RcptFnTXt/48w0mGIdvnwig
         rZn3/rXxNtesncrknVvDUqhHxq+sGgBbIcapeByYHcN+05QlcfKBs2f3I9npsWR0zL/Y
         iKT+5Adr6AfDvdvTILiYRMPovL4F3yt6jtvahE9z0CBzRCOKghY1KJAsDrQX6kTFT48Y
         x060vaUDxBwGARvo/PAPfD6VQsFxoIKrcl3GHRuMl+gQ5HAyZ/D1uPA78qhXLl9sFOIE
         DtoLFAvBFbtOfz656ZKN30L4MzZveC8k9Ovpa3gMdLtzUyFGVVEN9/NuYZ8As70FwbBs
         JRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731355036; x=1731959836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=On/yC3RUvFS85378pjUf+gJ5SwNriK0XjwcZ/D8nm/Y=;
        b=SvyOtOPEjGBH0Uv0jpan7qo0i2zS0WerSMWLji2GtCaXYETq+vftxtanqGhTg+GgJy
         l/14hJ3YMM8jyevaPGph4fnnq8mMawSOPehtYlImtaAu/FWsT7k05RmY7cHUZ3v6b2v3
         HLHc+mA9gDdl1G71J2Hg45r5N1cadSjQhFb6gPkLvFenLyOJ5pwflcu/L1L/vMD8sPp2
         hpS3HUCjrRMwbu1FL1uWkzAQ1L0TJzyzVVIO21SGbZxamkZileaX3CcEKAGmPE8JS8vG
         9VvZnt5RolzzpzKqv8w4BxUlURXd6xF35mv3zkTUilrCmP5rJXqVVP66UROQZdk86Uo0
         EM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfpVNkYg9tWPDUjBhjKhsqKnbpMwp1AHwOGIWi8nIan2g+NUU6bU9qCUFUss7VlMVg+gsgrQBG5V0=@vger.kernel.org, AJvYcCV/Cyox0vGBjq3TJGJzaEKd5aY+JIAJhuAPjirrFG/pMijAXNWZmHk8k1NxKocsQfCQ6uCmQgltbJVyqlcR@vger.kernel.org
X-Gm-Message-State: AOJu0YxtfilCnnt70ixIKuwBtA5iANTsUBXOLz2d4zU1Ot6nqym9Fj2y
	hkP8jzCEDz6+IZBFM+AQlHNT+Se1uMuJVPpxRzUHnLAAoimBDCLJAwtLlbsn
X-Google-Smtp-Source: AGHT+IGGyPvLh3RuqqeajCfbQCH7BeDaGoGOhy62xRTTQ+UVI4EE4CtYQ5wYfDox+aRpl7XvXYF5kw==
X-Received: by 2002:a17:902:e803:b0:20b:fa34:7325 with SMTP id d9443c01a7336-21183e0dc58mr179820445ad.43.1731355036308;
        Mon, 11 Nov 2024 11:57:16 -0800 (PST)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e41884sm79697705ad.119.2024.11.11.11.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 11:57:15 -0800 (PST)
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
Subject: [PATCH net-next v5] eth: fbnic: Add PCIe hardware statistics
Date: Mon, 11 Nov 2024 11:57:15 -0800
Message-ID: <20241111195715.1619855-1-sanman.p211993@gmail.com>
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
v5:
	- Add missing fbnic_dbg_init, fbnic_dbg_exit, fbnic_dbg_fbd_init and fbnic_dbg_fbd_exit functions
	- Add missing entry in fbnic.h
	- Tested on 1-NIC 2-Host system
		- Test Logs:
				Without ping <remote_host>
					# cat /sys/kernel/debug/fbnic/0000\:01\:00.0/pcie_stats
					ob_rd_tlp: 88724
					ob_rd_dword: 1363273
					ob_wr_tlp: 980410
					ob_wr_dword: 105006453
					ob_cpl_tlp: 98665
					ob_cpl_dword: 1363273
					ob_rd_no_tag: 0
					ob_rd_no_cpl_cred: 0
					ob_rd_no_np_cred: 0
				With ping <remote_host>
					# cat /sys/kernel/debug/fbnic/0000\:01\:00.0/pcie_stats
					ob_rd_tlp: 114081
					ob_rd_dword: 1902295
					ob_wr_tlp: 1098457
					ob_wr_dword: 112936622
					ob_cpl_tlp: 128409
					ob_cpl_dword: 1902295
					ob_rd_no_tag: 0
					ob_rd_no_cpl_cred: 0
					ob_rd_no_np_cred: 0
v4:
	- https://patchwork.kernel.org/project/netdevbpf/patch/20241109025905.1531196-1-sanman.p211993@gmail.com/
	- Fix indentations
	- Adding missing updates for previous versions
v3:
	- https://patchwork.kernel.org/project/netdevbpf/patch/20241108204640.3165724-1-sanman.p211993@gmail.com/
	- Moved PCIe stats to debugfs
v2:
	- https://patchwork.kernel.org/project/netdevbpf/patch/20241107020555.321245-1-sanman.p211993@gmail.com/
	- Removed unnecessary code blocks
	- Rephrased the commit message
v1:
	- https://patchwork.kernel.org/project/netdevbpf/patch/20241106002625.1857904-1-sanman.p211993@gmail.com/
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  26 ++++
 drivers/net/ethernet/meta/fbnic/Makefile      |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   6 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  37 ++++++
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  68 +++++++++++
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   |   4 +
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  12 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   8 +-
 10 files changed, 278 insertions(+), 1 deletion(-)
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
diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index 425e8b801265..7109d6390b0d 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_FBNIC) += fbnic.o

 fbnic-y := fbnic_csr.o \
 	   fbnic_devlink.o \
+	   fbnic_debugfs.o \
 	   fbnic_ethtool.o \
 	   fbnic_fw.o \
 	   fbnic_hw_stats.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 7d5efbf32408..f2c641174f63 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -19,6 +19,7 @@
 struct fbnic_dev {
 	struct device *dev;
 	struct net_device *netdev;
+	struct dentry *dbg_fbd;
 	struct device *hwmon;

 	u32 __iomem *uc_addr0;
@@ -158,6 +159,11 @@ void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
 void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version);
 int fbnic_csr_regs_len(struct fbnic_dev *fbd);

+void fbnic_dbg_fbd_init(struct fbnic_dev *fbd);
+void fbnic_dbg_fbd_exit(struct fbnic_dev *fbd);
+void fbnic_dbg_init(void);
+void fbnic_dbg_exit(void);
+
 enum fbnic_boards {
 	fbnic_board_asic
 };
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
index 000000000000..a2f424124a86
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -0,0 +1,68 @@
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
+	seq_printf(s, "ob_rd_dword: %llu\n",
+		   fbd->hw_stats.pcie.ob_rd_dword.value);
+	seq_printf(s, "ob_wr_tlp: %llu\n", fbd->hw_stats.pcie.ob_wr_tlp.value);
+	seq_printf(s, "ob_wr_dword: %llu\n",
+		   fbd->hw_stats.pcie.ob_wr_dword.value);
+	seq_printf(s, "ob_cpl_tlp: %llu\n",
+		   fbd->hw_stats.pcie.ob_cpl_tlp.value);
+	seq_printf(s, "ob_cpl_dword: %llu\n",
+		   fbd->hw_stats.pcie.ob_cpl_dword.value);
+	seq_printf(s, "ob_rd_no_tag: %llu\n",
+		   fbd->hw_stats.pcie.ob_rd_no_tag.value);
+	seq_printf(s, "ob_rd_no_cpl_cred: %llu\n",
+		   fbd->hw_stats.pcie.ob_rd_no_cpl_cred.value);
+	seq_printf(s, "ob_rd_no_np_cred: %llu\n",
+		   fbd->hw_stats.pcie.ob_rd_no_np_cred.value);
+
+	rtnl_unlock();
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_pcie_stats);
+
+void fbnic_dbg_fbd_init(struct fbnic_dev *fbd)
+{
+	struct pci_dev *pdev = to_pci_dev(fbd->dev);
+	const char *name = pci_name(pdev);
+
+	fbd->dbg_fbd = debugfs_create_dir(name, fbnic_dbg_root);
+	debugfs_create_file("pcie_stats", 0400, fbd->dbg_fbd, fbd,
+			    &fbnic_dbg_pcie_stats_fops);
+}
+
+void fbnic_dbg_fbd_exit(struct fbnic_dev *fbd)
+{
+	debugfs_remove_recursive(fbd->dbg_fbd);
+	fbd->dbg_fbd = NULL;
+}
+
+void fbnic_dbg_init(void)
+{
+	fbnic_dbg_root = debugfs_create_dir(fbnic_driver_name, NULL);
+}
+
+void fbnic_dbg_exit(void)
+{
+	debugfs_remove_recursive(fbnic_dbg_root);
+	fbnic_dbg_root = NULL;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index 0072d612215e..10b27fd07069 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -117,6 +117,8 @@ void fbnic_devlink_free(struct fbnic_dev *fbd)
 {
 	struct devlink *devlink = priv_to_devlink(fbd);

+	fbnic_dbg_fbd_exit(fbd);
+
 	devlink_free(devlink);
 }

@@ -145,6 +147,8 @@ struct fbnic_dev *fbnic_devlink_alloc(struct pci_dev *pdev)

 	fbd->mac_addr_boundary = FBNIC_RPC_TCAM_MACDA_DEFAULT_BOUNDARY;

+	fbnic_dbg_fbd_init(fbd);
+
 	return fbd;
 }

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
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 2de5a6fde7e8..5c485e9f3469 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -552,9 +552,13 @@ static int __init fbnic_init_module(void)
 {
 	int err;

+	fbnic_dbg_init();
+
 	err = pci_register_driver(&fbnic_driver);
-	if (err)
+	if (err) {
+		fbnic_dbg_exit();
 		goto out;
+	}

 	pr_info(DRV_SUMMARY " (%s)", fbnic_driver.name);
 out:
@@ -570,5 +574,7 @@ module_init(fbnic_init_module);
 static void __exit fbnic_exit_module(void)
 {
 	pci_unregister_driver(&fbnic_driver);
+
+	fbnic_dbg_exit();
 }
 module_exit(fbnic_exit_module);
--
2.43.5

