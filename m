Return-Path: <netdev+bounces-56003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB35A80D38E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A841C21446
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5494E1B8;
	Mon, 11 Dec 2023 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tFM9Pzek"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62D59B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:19:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1hy8SXHQ0vXqi8e3poUNSLck4SCDB8jV6HSOuLgdZkpiju9Mv1976tkJye0n6fKCr5FUfEnzsaT/lTdJi4XTT+HlIApP8OjZlHL+LqUOcbFjS6delf1alat7s8xxmeyawFuB4NaZUY/0LslSUi+FTqO2+5OuvBnpkm0xygirxC+UlMx0GEq5n2lN25lkRbqgehDxgh7zBxWRj3cmWnnX/BykejqCka2NLkzTRcspDWVAHMoHDRTEsUcL6H1CMOi0kjGYW++3kERDuCVPBFPeLpRUv1TtmEawF+8V17KHJJp5k0u1VkHkF6PBJiHsttIUkaOBsM06Wqs7g5HMtCs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgG2W4fi4iWtYDLLvgxoINe7lNhnUD1m0KIIdwUx6fg=;
 b=bxKXpc2t6c0wLdMOhiAgF5EW137mahm6YwwhN8gEMr/nGyrrgcBsjxRzKYjmOB/rimdqspWYYUn+mrorG08GydnvdiZMOJUDvGagW6n/UdW5RRv95Cm8T44qGhNgcwSdw1BGhD3ayUHI5ErgLi3g8zTfqCP3qESyq6NUPRbKJ/tzdNSbREjOI+xDkE3Dpx8s9l/vdqGFhzZT0YX1OPg4uvKR+ZGf3LiTPGrU7s+FTsKr5ZnIwjWR7F8OWK1uOgwHEmLaNrAx3sdyn5kg+z8at3DHfb659384I41DqpvlmUDXADyXThYjT/SDzzF+7BlC3pXBqeBLM8EMpfTgexTbUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgG2W4fi4iWtYDLLvgxoINe7lNhnUD1m0KIIdwUx6fg=;
 b=tFM9PzekHU2vZuk5M7QOM/1+C0XGvC6f+X7MdWuymj37D+S3cr0b+p0XSK4G/qbMRn2vFzIfGqIDEDnisnWS3DlZDIWLygA+pyvhuLDQNzk7Hii9T1EYR2HVq2QbnqL1znbojPo9hiHiE0yHwX2B5AbotFgr9CZFb7jFSd463EQ=
Received: from BL1PR13CA0321.namprd13.prod.outlook.com (2603:10b6:208:2c1::26)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:19:40 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::d3) by BL1PR13CA0321.outlook.office365.com
 (2603:10b6:208:2c1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.21 via Frontend
 Transport; Mon, 11 Dec 2023 17:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 17:19:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 11:19:38 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 11 Dec 2023 11:19:37 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: [PATCH net-next 1/7] sfc: initial debugfs implementation
Date: Mon, 11 Dec 2023 17:18:26 +0000
Message-ID: <9454bbffe8de24c0afcc6b307057e927ffaec6ca.1702314695.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1702314694.git.ecree.xilinx@gmail.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3d7ba1-1521-4def-04e7-08dbfa6d5b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zP+DCBFy0WndCvQmv0L51LJLvzP4Aln3dAR3pzOIeYGst7j4vgq9cBWAxm1ATjq900dLPH5/yhdbFpSxHGKDAplTNOIGXUcCA74fuqyPqW2iOwldr75BmDDpYDrN1RfLaET/9Bht0nMNHvyd7VUZUxuvOFLzjIVbR8zvomXX2TydDrVE29ucQUuKO1d/qusV0sBnhN6+1uKqasxSc/M6apw1KTz/gmFRts2t3OZ5GLIeytupFQpO1CgjO7LzinC8U1CWGorpV8wunit1BmpF9xFt6BSY+THNXMDrpLTdq2ce5BkQCQXVJJUopZpVHvHb50YJgyjTgvUBIh9lE81H5BpZ36TFUP6IlYBaXK5OFrQLQ0myzdVpim+PsVwtwVFZEVTURm+61GR7I/Bi1AOVHKgDbK5OFMTKymhuaBFBa92n7ObwW+SUzxGRLRGa17NHDmj3k9uUMLWJVblC3K1Be7+bTavRRytSRdjBCSZuQvjHKf+U70B98TYsPN6ZVtXDoPd86JrVD7/co/DzQhs0t+n+I/tj46HXDc4hKuT49lRzuaHbsmOnzn+1pLb8Q3yc2vF34+W1Mw5p0KGVNtjpXqctnNvchh03RE1SB07lO/wSW0WIWOgnGPolaglEOA/2PiObNnJC9ZeAnr+qKECyaqdzQQoPqZeMKSHIElrTpe6b1yWNiewHB5oh5QRwU9GTr8RyUxuBfeX6RoVzuZ4zgfg+RaRWH3gxmt/AClnbQXBoXR/v0VR1+CoOu1s03mtBH4DvgHEG3xOp6ERB//PVEL2KaihO+SWzkKESD9hXQVM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(30864003)(6666004)(2906002)(2876002)(54906003)(70206006)(9686003)(356005)(81166007)(86362001)(55446002)(36756003)(4326008)(8676002)(8936002)(316002)(5660300002)(110136005)(40480700001)(70586007)(478600001)(40460700003)(41300700001)(36860700001)(82740400003)(47076005)(26005)(336012)(426003)(83380400001)(2004002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:19:39.6411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3d7ba1-1521-4def-04e7-08dbfa6d5b85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

From: Edward Cree <ecree.xilinx@gmail.com>

Just a handful of nodes, including one enum with a string table for
 pretty printing the values.

Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/Makefile       |   1 +
 drivers/net/ethernet/sfc/debugfs.c      | 234 ++++++++++++++++++++++++
 drivers/net/ethernet/sfc/debugfs.h      |  56 ++++++
 drivers/net/ethernet/sfc/ef10.c         |  10 +
 drivers/net/ethernet/sfc/ef100_netdev.c |   7 +
 drivers/net/ethernet/sfc/ef100_nic.c    |   8 +
 drivers/net/ethernet/sfc/efx.c          |  15 +-
 drivers/net/ethernet/sfc/efx_common.c   |   7 +
 drivers/net/ethernet/sfc/net_driver.h   |  29 +++
 9 files changed, 366 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/debugfs.c
 create mode 100644 drivers/net/ethernet/sfc/debugfs.h

diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index 8f446b9bd5ee..1fbdd04dc2c5 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -12,6 +12,7 @@ sfc-$(CONFIG_SFC_MTD)	+= mtd.o
 sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
                            tc_encap_actions.o tc_conntrack.o
+sfc-$(CONFIG_DEBUG_FS)	+= debugfs.o
 
 obj-$(CONFIG_SFC)	+= sfc.o
 
diff --git a/drivers/net/ethernet/sfc/debugfs.c b/drivers/net/ethernet/sfc/debugfs.c
new file mode 100644
index 000000000000..cf800addb4ff
--- /dev/null
+++ b/drivers/net/ethernet/sfc/debugfs.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ * Driver for Solarflare network controllers and boards
+ * Copyright 2023, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#include "debugfs.h"
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <linux/dcache.h>
+#include <linux/seq_file.h>
+
+/* Maximum length for a name component or symlink target */
+#define EFX_DEBUGFS_NAME_LEN 32
+
+/* Top-level debug directory ([/sys/kernel]/debug/sfc) */
+static struct dentry *efx_debug_root;
+
+/* "cards" directory ([/sys/kernel]/debug/sfc/cards) */
+static struct dentry *efx_debug_cards;
+
+/**
+ * efx_init_debugfs_netdev - create debugfs sym-link for net device
+ * @net_dev:		Net device
+ *
+ * Create sym-link named after @net_dev to the debugfs directories for the
+ * corresponding NIC.  The sym-link must be cleaned up using
+ * efx_fini_debugfs_netdev().
+ *
+ * Return: a negative error code or 0 on success.
+ */
+static int efx_init_debugfs_netdev(struct net_device *net_dev)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+	char target[EFX_DEBUGFS_NAME_LEN];
+	char name[EFX_DEBUGFS_NAME_LEN];
+
+	if (snprintf(name, sizeof(name), "nic_%s", net_dev->name) >=
+			sizeof(name))
+		return -ENAMETOOLONG;
+	if (snprintf(target, sizeof(target), "cards/%s", pci_name(efx->pci_dev))
+	    >= sizeof(target))
+		return -ENAMETOOLONG;
+	efx->debug_symlink = debugfs_create_symlink(name,
+						    efx_debug_root, target);
+	if (IS_ERR_OR_NULL(efx->debug_symlink))
+		return efx->debug_symlink ? PTR_ERR(efx->debug_symlink) :
+					    -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * efx_fini_debugfs_netdev - remove debugfs sym-link for net device
+ * @net_dev:		Net device
+ *
+ * Remove sym-link created for @net_dev by efx_init_debugfs_netdev().
+ */
+void efx_fini_debugfs_netdev(struct net_device *net_dev)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+
+	debugfs_remove(efx->debug_symlink);
+	efx->debug_symlink = NULL;
+}
+
+/* replace debugfs sym-links on net device rename */
+void efx_update_debugfs_netdev(struct efx_nic *efx)
+{
+	mutex_lock(&efx->debugfs_symlink_mutex);
+	if (efx->debug_symlink)
+		efx_fini_debugfs_netdev(efx->net_dev);
+	efx_init_debugfs_netdev(efx->net_dev);
+	mutex_unlock(&efx->debugfs_symlink_mutex);
+}
+
+static int efx_debugfs_enum_read(struct seq_file *s, void *d)
+{
+	struct efx_debugfs_enum_data *data = s->private;
+	u64 value = 0;
+	size_t len;
+
+	len = min(data->vlen, sizeof(value));
+#ifdef BIG_ENDIAN
+	/* If data->value is narrower than u64, we need to copy into the
+	 * far end of value, as that's where the low bits live.
+	 */
+	memcpy(((void *)&value) + sizeof(value) - len, data->value, len);
+#else
+	memcpy(&value, data->value, len);
+#endif
+	seq_printf(s, "%#llx => %s\n", value,
+		   value < data->max ? data->names[value] : "(invalid)");
+	return 0;
+}
+
+static int efx_debugfs_enum_open(struct inode *inode, struct file *f)
+{
+	struct efx_debugfs_enum_data *data = inode->i_private;
+
+	return single_open(f, efx_debugfs_enum_read, data);
+}
+
+static const struct file_operations efx_debugfs_enum_ops = {
+	.owner = THIS_MODULE,
+	.open = efx_debugfs_enum_open,
+	.release = single_release,
+	.read = seq_read,
+	.llseek = seq_lseek,
+};
+
+static void efx_debugfs_create_enum(const char *name, umode_t mode,
+				    struct dentry *parent,
+				    struct efx_debugfs_enum_data *data)
+{
+	debugfs_create_file(name, mode, parent, data, &efx_debugfs_enum_ops);
+}
+
+static const char *const efx_interrupt_mode_names[] = {
+	[EFX_INT_MODE_MSIX]   = "MSI-X",
+	[EFX_INT_MODE_MSI]    = "MSI",
+	[EFX_INT_MODE_LEGACY] = "legacy",
+};
+
+#define EFX_DEBUGFS_EFX(_type, _name)	\
+	debugfs_create_##_type(#_name, 0444, efx->debug_dir, &efx->_name)
+
+/* Create basic debugfs parameter files for an Efx NIC */
+static void efx_init_debugfs_nic_files(struct efx_nic *efx)
+{
+	EFX_DEBUGFS_EFX(x32, rx_dma_len);
+	EFX_DEBUGFS_EFX(x32, rx_buffer_order);
+	EFX_DEBUGFS_EFX(x32, rx_buffer_truesize);
+	efx->debug_interrupt_mode.max = ARRAY_SIZE(efx_interrupt_mode_names);
+	efx->debug_interrupt_mode.names = efx_interrupt_mode_names;
+	efx->debug_interrupt_mode.vlen = sizeof(efx->interrupt_mode);
+	efx->debug_interrupt_mode.value = &efx->interrupt_mode;
+	efx_debugfs_create_enum("interrupt_mode", 0444, efx->debug_dir,
+				&efx->debug_interrupt_mode);
+}
+
+/**
+ * efx_init_debugfs_nic - create debugfs directory for NIC
+ * @efx:		Efx NIC
+ *
+ * Create debugfs directory containing parameter-files for @efx.
+ * The directory must be cleaned up using efx_fini_debugfs_nic().
+ *
+ * Return: a negative error code or 0 on success.
+ */
+int efx_init_debugfs_nic(struct efx_nic *efx)
+{
+	/* Create directory */
+	efx->debug_dir = debugfs_create_dir(pci_name(efx->pci_dev),
+					    efx_debug_cards);
+	if (!efx->debug_dir)
+		return -ENOMEM;
+	efx_init_debugfs_nic_files(efx);
+	return 0;
+}
+
+/**
+ * efx_fini_debugfs_nic - remove debugfs directory for NIC
+ * @efx:		Efx NIC
+ *
+ * Remove debugfs directory created for @efx by efx_init_debugfs_nic().
+ */
+void efx_fini_debugfs_nic(struct efx_nic *efx)
+{
+	debugfs_remove_recursive(efx->debug_dir);
+	efx->debug_dir = NULL;
+}
+
+/**
+ * efx_init_debugfs - create debugfs directories for sfc driver
+ *
+ * Create debugfs directories "sfc" and "sfc/cards".  This must be
+ * called before any of the other functions that create debugfs
+ * directories.  The directories must be cleaned up using
+ * efx_fini_debugfs().
+ *
+ * Return: a negative error code or 0 on success.
+ */
+int efx_init_debugfs(void)
+{
+	int rc;
+
+	/* Create top-level directory */
+	efx_debug_root = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	if (!efx_debug_root) {
+		pr_err("debugfs_create_dir %s failed.\n", KBUILD_MODNAME);
+		rc = -ENOMEM;
+		goto err;
+	} else if (IS_ERR(efx_debug_root)) {
+		rc = PTR_ERR(efx_debug_root);
+		pr_err("debugfs_create_dir %s failed, rc=%d.\n",
+		       KBUILD_MODNAME, rc);
+		goto err;
+	}
+
+	/* Create "cards" directory */
+	efx_debug_cards = debugfs_create_dir("cards", efx_debug_root);
+	if (!efx_debug_cards) {
+		pr_err("debugfs_create_dir cards failed.\n");
+		rc = -ENOMEM;
+		goto err;
+	} else if (IS_ERR(efx_debug_cards)) {
+		rc = PTR_ERR(efx_debug_cards);
+		pr_err("debugfs_create_dir cards failed, rc=%d.\n", rc);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	efx_fini_debugfs();
+	return rc;
+}
+
+/**
+ * efx_fini_debugfs - remove debugfs directories for sfc driver
+ *
+ * Remove directories created by efx_init_debugfs().
+ */
+void efx_fini_debugfs(void)
+{
+	debugfs_remove_recursive(efx_debug_root);
+	efx_debug_cards = NULL;
+	efx_debug_root = NULL;
+}
diff --git a/drivers/net/ethernet/sfc/debugfs.h b/drivers/net/ethernet/sfc/debugfs.h
new file mode 100644
index 000000000000..1fe40fbffa5e
--- /dev/null
+++ b/drivers/net/ethernet/sfc/debugfs.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for Solarflare network controllers and boards
+ * Copyright 2023, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef EFX_DEBUGFS_H
+#define EFX_DEBUGFS_H
+#include "net_driver.h"
+
+#ifdef CONFIG_DEBUG_FS
+
+/**
+ * DOC: Directory layout for sfc debugfs
+ *
+ * At top level ([/sys/kernel]/debug/sfc) are per-netdev symlinks "nic_$name"
+ * and the "cards" directory.  For each PCI device to which the driver has
+ * bound and created a &struct efx_nic, there is a directory &efx_nic.debug_dir
+ * in "cards" whose name is the PCI address of the device; it is to this
+ * directory that the netdev symlink points.
+ */
+
+void efx_fini_debugfs_netdev(struct net_device *net_dev);
+void efx_update_debugfs_netdev(struct efx_nic *efx);
+
+int efx_init_debugfs_nic(struct efx_nic *efx);
+void efx_fini_debugfs_nic(struct efx_nic *efx);
+
+int efx_init_debugfs(void);
+void efx_fini_debugfs(void);
+
+#else /* CONFIG_DEBUG_FS */
+
+static inline void efx_fini_debugfs_netdev(struct net_device *net_dev) {}
+
+static inline void efx_update_debugfs_netdev(struct efx_nic *efx) {}
+
+static inline int efx_init_debugfs_nic(struct efx_nic *efx)
+{
+	return 0;
+}
+static inline void efx_fini_debugfs_nic(struct efx_nic *efx) {}
+
+static inline int efx_init_debugfs(void)
+{
+	return 0;
+}
+static inline void efx_fini_debugfs(void) {}
+
+#endif /* CONFIG_DEBUG_FS */
+
+#endif /* EFX_DEBUGFS_H */
diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 6dfa062feebc..58e18fc92093 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -19,6 +19,7 @@
 #include "workarounds.h"
 #include "selftest.h"
 #include "ef10_sriov.h"
+#include "debugfs.h"
 #include <linux/in.h>
 #include <linux/jhash.h>
 #include <linux/wait.h>
@@ -580,6 +581,13 @@ static int efx_ef10_probe(struct efx_nic *efx)
 	if (rc)
 		goto fail3;
 
+	/* Populate debugfs */
+#ifdef CONFIG_DEBUG_FS
+	rc = efx_init_debugfs_nic(efx);
+	if (rc)
+		pci_err(efx->pci_dev, "failed to init device debugfs\n");
+#endif
+
 	rc = device_create_file(&efx->pci_dev->dev,
 				&dev_attr_link_control_flag);
 	if (rc)
@@ -693,6 +701,7 @@ static int efx_ef10_probe(struct efx_nic *efx)
 fail4:
 	device_remove_file(&efx->pci_dev->dev, &dev_attr_link_control_flag);
 fail3:
+	efx_fini_debugfs_nic(efx);
 	efx_mcdi_detach(efx);
 
 	mutex_lock(&nic_data->udp_tunnels_lock);
@@ -962,6 +971,7 @@ static void efx_ef10_remove(struct efx_nic *efx)
 	device_remove_file(&efx->pci_dev->dev, &dev_attr_link_control_flag);
 
 	efx_mcdi_detach(efx);
+	efx_fini_debugfs_nic(efx);
 
 	memset(nic_data->udp_tunnels, 0, sizeof(nic_data->udp_tunnels));
 	mutex_lock(&nic_data->udp_tunnels_lock);
diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
index 7f7d560cb2b4..e844d57754b7 100644
--- a/drivers/net/ethernet/sfc/ef100_netdev.c
+++ b/drivers/net/ethernet/sfc/ef100_netdev.c
@@ -26,10 +26,12 @@
 #include "tc_bindings.h"
 #include "tc_encap_actions.h"
 #include "efx_devlink.h"
+#include "debugfs.h"
 
 static void ef100_update_name(struct efx_nic *efx)
 {
 	strcpy(efx->name, efx->net_dev->name);
+	efx_update_debugfs_netdev(efx);
 }
 
 static int ef100_alloc_vis(struct efx_nic *efx, unsigned int *allocated_vis)
@@ -405,6 +407,11 @@ void ef100_remove_netdev(struct efx_probe_data *probe_data)
 	ef100_pf_unset_devlink_port(efx);
 	efx_fini_tc(efx);
 #endif
+#ifdef CONFIG_DEBUG_FS
+	mutex_lock(&efx->debugfs_symlink_mutex);
+	efx_fini_debugfs_netdev(efx->net_dev);
+	mutex_unlock(&efx->debugfs_symlink_mutex);
+#endif
 
 	down_write(&efx->filter_sem);
 	efx_mcdi_filter_table_remove(efx);
diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 6da06931187d..ad378aa05dc3 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -27,6 +27,7 @@
 #include "tc.h"
 #include "mae.h"
 #include "rx_common.h"
+#include "debugfs.h"
 
 #define EF100_MAX_VIS 4096
 #define EF100_NUM_MCDI_BUFFERS	1
@@ -1077,6 +1078,12 @@ static int ef100_probe_main(struct efx_nic *efx)
 
 	/* Post-IO section. */
 
+	/* Populate debugfs */
+#ifdef CONFIG_DEBUG_FS
+	rc = efx_init_debugfs_nic(efx);
+	if (rc)
+		pci_err(efx->pci_dev, "failed to init device debugfs\n");
+#endif
 	rc = efx_mcdi_init(efx);
 	if (rc)
 		goto fail;
@@ -1213,6 +1220,7 @@ void ef100_remove(struct efx_nic *efx)
 
 	efx_mcdi_detach(efx);
 	efx_mcdi_fini(efx);
+	efx_fini_debugfs_nic(efx);
 	if (nic_data)
 		efx_nic_free_buffer(efx, &nic_data->mcdi_buf);
 	kfree(nic_data);
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 19f4b4d0b851..9266c7b5b4fd 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -33,6 +33,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "debugfs.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -401,6 +402,11 @@ static void efx_remove_all(struct efx_nic *efx)
 #endif
 	efx_remove_port(efx);
 	efx_remove_nic(efx);
+#ifdef CONFIG_DEBUG_FS
+	mutex_lock(&efx->debugfs_symlink_mutex);
+	efx_fini_debugfs_netdev(efx->net_dev);
+	mutex_unlock(&efx->debugfs_symlink_mutex);
+#endif
 }
 
 /**************************************************************************
@@ -667,6 +673,7 @@ static void efx_update_name(struct efx_nic *efx)
 	strcpy(efx->name, efx->net_dev->name);
 	efx_mtd_rename(efx);
 	efx_set_channel_names(efx);
+	efx_update_debugfs_netdev(efx);
 }
 
 static int efx_netdev_event(struct notifier_block *this,
@@ -1319,6 +1326,10 @@ static int __init efx_init_module(void)
 
 	printk(KERN_INFO "Solarflare NET driver\n");
 
+	rc = efx_init_debugfs();
+	if (rc)
+		goto err_debugfs;
+
 	rc = register_netdevice_notifier(&efx_netdev_notifier);
 	if (rc)
 		goto err_notifier;
@@ -1344,6 +1355,8 @@ static int __init efx_init_module(void)
  err_reset:
 	unregister_netdevice_notifier(&efx_netdev_notifier);
  err_notifier:
+	efx_fini_debugfs();
+ err_debugfs:
 	return rc;
 }
 
@@ -1355,7 +1368,7 @@ static void __exit efx_exit_module(void)
 	pci_unregister_driver(&efx_pci_driver);
 	efx_destroy_reset_workqueue();
 	unregister_netdevice_notifier(&efx_netdev_notifier);
-
+	efx_fini_debugfs();
 }
 
 module_init(efx_init_module);
diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index 175bd9cdfdac..7a9d6b6b66e5 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -1022,6 +1022,9 @@ int efx_init_struct(struct efx_nic *efx, struct pci_dev *pci_dev)
 	INIT_WORK(&efx->mac_work, efx_mac_work);
 	init_waitqueue_head(&efx->flush_wq);
 
+#ifdef CONFIG_DEBUG_FS
+	mutex_init(&efx->debugfs_symlink_mutex);
+#endif
 	efx->tx_queues_per_channel = 1;
 	efx->rxq_entries = EFX_DEFAULT_DMAQ_SIZE;
 	efx->txq_entries = EFX_DEFAULT_DMAQ_SIZE;
@@ -1056,6 +1059,10 @@ void efx_fini_struct(struct efx_nic *efx)
 
 	efx_fini_channels(efx);
 
+#ifdef CONFIG_DEBUG_FS
+	mutex_destroy(&efx->debugfs_symlink_mutex);
+#endif
+
 	kfree(efx->vpd_sn);
 
 	if (efx->workqueue) {
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 27d86e90a3bb..961e2db31c6e 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -107,6 +107,24 @@ struct hwtstamp_config;
 
 struct efx_self_tests;
 
+/**
+ * struct efx_debugfs_enum_data - information for pretty-printing enums
+ * @value: pointer to the actual enum
+ * @vlen: sizeof the enum
+ * @names: array of names of enumerated values.  May contain some %NULL entries.
+ * @max: number of entries in @names, typically from ARRAY_SIZE()
+ *
+ * Where a driver struct contains an enum member which we wish to expose in
+ * debugfs, we also embed an instance of this struct, which
+ * efx_debugfs_enum_read() uses to pretty-print the value.
+ */
+struct efx_debugfs_enum_data {
+	void *value;
+	size_t vlen;
+	const char *const *names;
+	unsigned int max;
+};
+
 /**
  * struct efx_buffer - A general-purpose DMA buffer
  * @addr: host base address of the buffer
@@ -1123,6 +1141,17 @@ struct efx_nic {
 	u32 rps_next_id;
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+	/** @debug_dir: NIC debugfs directory */
+	struct dentry *debug_dir;
+	/** @debug_symlink: NIC debugfs symlink (``nic_eth%d``) */
+	struct dentry *debug_symlink;
+	/** @debug_interrupt_mode: debugfs details for printing @interrupt_mode */
+	struct efx_debugfs_enum_data debug_interrupt_mode;
+	/** @debugfs_symlink_mutex: protects debugfs @debug_symlink */
+	struct mutex debugfs_symlink_mutex;
+#endif
+
 	atomic_t active_queues;
 	atomic_t rxq_flush_pending;
 	atomic_t rxq_flush_outstanding;

