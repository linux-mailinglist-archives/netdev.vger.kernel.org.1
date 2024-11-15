Return-Path: <netdev+bounces-145125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A36BE9CD52E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074F8B22665
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29EE152E02;
	Fri, 15 Nov 2024 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIBf85No"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08AF14D43D
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635637; cv=none; b=Em/JamUr20jWqhM0UyKtQEzoAN0AaVZa+jg+HnaU21mJSiPiRSGHECIlCN7KGQ5hWR6G6LO2HDwxhAswjLgieXanpoRVIM3wBPy/1eHW4XPFXXU08Y1+G+Uk7bku3IVqp48paB80f839/DiYlAJTbrLqHYpGB468do4NEcnksUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635637; c=relaxed/simple;
	bh=FI9GlcUIu33RNZTh5AZ29+7+iWMQfT82AHf8QzMOfe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fh+qjcI0+lISc8YZwTPj7ZySvs8+mgAS7LSdi0u6Ve0OUU9iCuyIDu4s8EimzmHermFO0rwNRPFuhWi63OSvp9XQRDScmMjRbpR5TuR3DVwh2y08DabND5KjyGwzfQ7Tnd4uDJ8cR9uG6WnBwcoCL4m8BmBlG3XJOdEHHdLyJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIBf85No; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7D5C4CEDA;
	Fri, 15 Nov 2024 01:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731635637;
	bh=FI9GlcUIu33RNZTh5AZ29+7+iWMQfT82AHf8QzMOfe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIBf85No/BPCrPNK1YH5dJ+Xcaxb1hRiLrnT2UCNp8Cxp4/+WLWlP8oCj844dhhFB
	 N+TSdTH6EZCp0lcCUvWHdeHl3Gnw2g9Z3VKbIGZV77CFUvOdmgQZHeUIR8w23H/JNS
	 ByFpaItaotSyfW/PQS3cRS/8LSAfu9ednYgQJ1ctg1fIjKspwhwASAHZZQLX1/dagX
	 7Xksh1tzB+ch5Mzjvrzi1y8MP8bI72HJHrASA6+bNoxerOIsV8F1yWvcNYiX7E2IXx
	 4oXowr+MhCKEbt1jkpoebNxJe/PXcs65IKwuw4Ub88aML95u9UKS7OLu0Z4v5B0Se1
	 lY1+N+MXAdMfA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/5] eth: fbnic: add PCIe hardware statistics
Date: Thu, 14 Nov 2024 17:53:43 -0800
Message-ID: <20241115015344.757567-5-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115015344.757567-1-kuba@kernel.org>
References: <20241115015344.757567-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanman Pradhan <sanman.p211993@gmail.com>

Add PCIe hardware statistics support to the fbnic driver. These stats
provide insight into PCIe transaction performance and error conditions.

Which includes, read/write and completion TLP counts and DWORD counts and
debug counters for tag, completion credit and NP credit exhaustion

The stats are exposed via debugfs and can be used to monitor PCIe
performance and debug PCIe issues.

Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  30 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  37 ++++++
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  34 ++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  12 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   4 +
 6 files changed, 231 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 32ff114f5c26..14f2834d86d1 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -27,3 +27,33 @@ driver takes over.
 devlink dev info provides version information for all three components. In
 addition to the version the hg commit hash of the build is included as a
 separate entry.
+
+Statistics
+----------
+
+PCIe
+~~~~
+
+The fbnic driver exposes PCIe hardware performance statistics through debugfs
+(``pcie_stats``). These statistics provide insights into PCIe transaction
+behavior and potential performance bottlenecks.
+
+1. PCIe Transaction Counters:
+
+   These counters track PCIe transaction activity:
+        - ``pcie_ob_rd_tlp``: Outbound read Transaction Layer Packets count
+        - ``pcie_ob_rd_dword``: DWORDs transferred in outbound read transactions
+        - ``pcie_ob_wr_tlp``: Outbound write Transaction Layer Packets count
+        - ``pcie_ob_wr_dword``: DWORDs transferred in outbound write
+	  transactions
+        - ``pcie_ob_cpl_tlp``: Outbound completion TLP count
+        - ``pcie_ob_cpl_dword``: DWORDs transferred in outbound completion TLPs
+
+2. PCIe Resource Monitoring:
+
+   These counters indicate PCIe resource exhaustion events:
+        - ``pcie_ob_rd_no_tag``: Read requests dropped due to tag unavailability
+        - ``pcie_ob_rd_no_cpl_cred``: Read requests dropped due to completion
+	  credit exhaustion
+        - ``pcie_ob_rd_no_np_cred``: Read requests dropped due to non-posted
+	  credit exhaustion
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index f9a531ce9e17..dac9a4879e52 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -918,6 +918,43 @@ enum {
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
index 183c7c4914dc..59951b5abdb7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -3,17 +3,51 @@
 
 #include <linux/debugfs.h>
 #include <linux/pci.h>
+#include <linux/rtnetlink.h>
+#include <linux/seq_file.h>
 
 #include "fbnic.h"
 
 static struct dentry *fbnic_dbg_root;
 
+static int fbnic_dbg_pcie_stats_show(struct seq_file *s, void *v)
+{
+	struct fbnic_dev *fbd = s->private;
+
+	rtnl_lock();
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
+	rtnl_unlock();
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_pcie_stats);
+
 void fbnic_dbg_fbd_init(struct fbnic_dev *fbd)
 {
 	struct pci_dev *pdev = to_pci_dev(fbd->dev);
 	const char *name = pci_name(pdev);
 
 	fbd->dbg_fbd = debugfs_create_dir(name, fbnic_dbg_root);
+	debugfs_create_file("pcie_stats", 0400, fbd->dbg_fbd, fbd,
+			    &fbnic_dbg_pcie_stats_fops);
 }
 
 void fbnic_dbg_fbd_exit(struct fbnic_dev *fbd)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index b3f8dc299b29..c391f2155054 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -28,3 +28,117 @@ u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset)
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
index 199ad2228ee9..b152c6b1b4ab 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -37,12 +37,24 @@ struct fbnic_mac_stats {
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
 
 #endif /* _FBNIC_HW_STATS_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 877c45e6dcae..0aa95160f006 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -9,6 +9,7 @@
 
 #include "fbnic.h"
 #include "fbnic_drvinfo.h"
+#include "fbnic_hw_stats.h"
 #include "fbnic_netdev.h"
 
 char fbnic_driver_name[] = DRV_NAME;
@@ -290,6 +291,9 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fbnic_devlink_register(fbd);
 	fbnic_dbg_fbd_init(fbd);
 
+	/* Capture snapshot of hardware stats so netdev can calculate delta */
+	fbnic_reset_hw_stats(fbd);
+
 	fbnic_hwmon_register(fbd);
 
 	if (!fbd->dsn) {
-- 
2.47.0


