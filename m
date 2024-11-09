Return-Path: <netdev+bounces-143486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AAA9C299B
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 03:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A748283F4E
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC5B13A86A;
	Sat,  9 Nov 2024 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6XJlF8H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7A3FB8B;
	Sat,  9 Nov 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731121149; cv=none; b=c1Ju059Lm3Q7pD3FwZmtUUR+Ren/ddVB0fXf8y+T4OyDkzuGRxAY1undEuk0RfvNBT126RosSnZYNIB8tTO6BzCYRp81gjv838QNiJacWRqe7FvR/HISkotfSxDrjxiVf6LoYuIly80dvjxtC2jTvXVhTgIXqB0lr06Zce8leI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731121149; c=relaxed/simple;
	bh=kDQDpWAlwqhenDk+2KnXtbzpfIV1sZA1Qv7cylFp7d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5xfl85OwHLDM0Ytdg4CqTwU2A+AIdvsevIpWuBBGdIWJQJ/r1Ub2HInK0Bcd4Hq606Jk4ZvYRK5PU4HmkYP3haDh4AmcYqpOSwbvIS+s2v9bC/krU1hZH79VmOrkZeC2ZMOvWI5ecSn4c5Pge5es3+5dXLaX8HIzpiNh9Lk+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6XJlF8H; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso2517808b3a.3;
        Fri, 08 Nov 2024 18:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731121147; x=1731725947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgzjvu2KFAIoDqaousuCkzou9PgVU9Gj9P4/pqvAl70=;
        b=S6XJlF8H47OQ+NeOCvZQtOFKgQHyxRCUHigFD1sh5bpUQzrX9E9l7TYZvOs6B4lzqp
         cQUmHlUevgRz2nsjIzlqOso2pE8I/UW/vrhKR/lNe9ivo4iWcg3kJ7mX86d7VJgGeAZO
         WljPyFhiTQmgBy1Fkfo6U/UDGVg4N9ybHzNbKdVb21j1dZkBx4KcwD9iyo4bU8VYyO13
         rAwh98rvc1pJXG15H5ufYYAFgxGxtZdncBi1Bk7Uqm6c2B+Ug682FokTrrKXib04zDDq
         jYCzEHXYzc8iXdYw/g8LklUTfzwWgNGFGYkDWOJpgnO34DyUJmO5b0FOSx7mAbmr+IH5
         Xxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731121147; x=1731725947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jgzjvu2KFAIoDqaousuCkzou9PgVU9Gj9P4/pqvAl70=;
        b=eaRlsqN/Bh7kCWst6rrzHdM4xbv8qa2vN+2XGNHOsm4sCC5i2o6ysEkTSZWzVMHBEP
         X61h1r1KSmp4Ndz2W++LCPV0pMK8FbzFb03wvZPqF8ybu5yOWG1/Yf0caqNfyfM136NT
         yZjv8OnqeiiG/1XMZsX5q4RmmVWYkqgRZ/gbosymsw5Lk5dVfLMyI8xSInObl7wymqiw
         AyZRb6hHpRqs2c/NkTi0Mn/yUlp72DHL9ovFufl2JvBjz4Bh6rLOm0OuClvwIjQbsUcL
         vqSL93Z6t1ohaepAcS/MMlsXZLK9ZxMwd6fjByVM/7IU2rjNM7RpRKNE4CS6NHc8dCME
         GmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/gx8U9wyPOHyLav0E9K8dR9Cz7z5wd5XFzRgEoHMj2ftsWhcDTvTd5Qy88Ys5ofi7qb5J+7Z0LSQ=@vger.kernel.org, AJvYcCXsMn0jdmHJgo/Ajr3IunlRGkq0sa0ZfFErFOB2RBEczgKXk5Z1X0UEynA7F0cYNOOB/sAM3cXJLQNYxq1Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9I7i7WONdcY79FQhQpYi9RGTes0S5qd+dMkDO0/BTzhOi1r4
	tilvbP3nDBCn4WIZ7U2VOaY06/jPjn2YYTzZueOUcxyQR63+U5dCkO4F5h94
X-Google-Smtp-Source: AGHT+IHvK3BLv1YH2YOmDBjcDpFxUSxglJM5l0441IzKnxx83Kl8a+R2UFAnIhoY3Q0BcRI0jH7RDw==
X-Received: by 2002:a05:6a00:218d:b0:71e:5033:c5 with SMTP id d2e1a72fcca58-724132c211amr7009580b3a.14.1731121146727;
        Fri, 08 Nov 2024 18:59:06 -0800 (PST)
Received: from localhost (fwdproxy-prn-031.fbsv.net. [2a03:2880:ff:1f::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a134f0sm4572878b3a.131.2024.11.08.18.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 18:59:06 -0800 (PST)
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
Subject: [PATCH net-next v4] eth: fbnic: Add PCIe hardware statistics
Date: Fri,  8 Nov 2024 18:59:05 -0800
Message-ID: <20241109025905.1531196-1-sanman.p211993@gmail.com>
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
v4:
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
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  37 ++++++
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  54 +++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  12 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
 6 files changed, 246 insertions(+)
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
index 000000000000..1c865d5b7320
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -0,0 +1,54 @@
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
+void fbnic_dbg_init(void)
+{
+	fbnic_dbg_root = debugfs_create_dir(fbnic_driver_name, NULL);
+	debugfs_create_file("pcie_stats", 0400, fbnic_dbg_root, NULL,
+			    &fbnic_dbg_pcie_stats_fops);
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

