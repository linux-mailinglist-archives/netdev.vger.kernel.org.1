Return-Path: <netdev+bounces-56007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F24180D392
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D935F281C62
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7A4E62A;
	Mon, 11 Dec 2023 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I0DMjaFN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B389B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:19:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYNDbF9wCi+Bu6HoKSAwCefGLoDwJ0IHFia9/s04f2AVCcDJyaF0ojKxhUJ9+rAthRflVfwSrlh1zd1WbZTCJYDA+DnOarWM9rn7NLi6tvCNVDrSLefM7foRZNhMfSvV+8C/gc/IRluFNI5bHqh/Q4L6HO7z0X2ElX3hl1zyeO4AussvFvBvfjeqxZb4nXuiOME9WQa2ih+M4GMcejwZvS8DkM0s0rkt9aTUq7M6pNqjzx1Fq5ELw+9yiRtBGKCqiEc4QgNWK+k8K6BMQsyzz/CMtlFJHqSJxFqnRbNRiMYqork8LscnQ5WcUUYLsgU3B71jlqTxNpBgvzul0abEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSf7IM+yJK+2bOGxs8/iljwayHYTF/LX7QhnW9vZDGo=;
 b=WOkqbC6iOY5ae+01276vpRLHV+jRb7WIwxVXxYnBb+Q4z1ViJzyRRwSJwHVlqh/+zZxpojdqBOxZv+SNqtTYPN+rLdsNG5b8ZFZpzfAMox9dnRORkZ/ExffkEm5aNgwIso5OLJGkK5bcEM86PXMhm94t3/DZ2f8fKqYOgO0vFQ/rXUFEHkJp4hEU+uShcHuPjyhIS/f6gAXWZdgKDHWB/uhmPmDV8hos1JRGGEo0YmeFg+njo3onplFzdY4Qg63erNOLCumZoVZpmUdETlMkBkLO9dKK1+/qko8NaWSV/IjECMCJgvMrQmIfm2O4k0teVofnJ2Rq+n/ZeBAVOGdvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSf7IM+yJK+2bOGxs8/iljwayHYTF/LX7QhnW9vZDGo=;
 b=I0DMjaFN/ADP+ppaNpVfQtUhzSL7vbw0ZBGqBIxxor0ciJLwZNdsQLxVGEeiX4JiZUaUIpyAhJk+0bBYKJHPTPK92ba8sYNKdGc0NTzTYkXL3SRTPfyYYQVCMEBdp24o20pv2cP0CtfCFv+nDjPWnGEeXJPDoXBuYJu1/WKmgNI=
Received: from DM6PR13CA0002.namprd13.prod.outlook.com (2603:10b6:5:bc::15) by
 MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.33; Mon, 11 Dec 2023 17:19:42 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::56) by DM6PR13CA0002.outlook.office365.com
 (2603:10b6:5:bc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.21 via Frontend
 Transport; Mon, 11 Dec 2023 17:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.19 via Frontend Transport; Mon, 11 Dec 2023 17:19:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 11:19:40 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 11 Dec 2023 11:19:39 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: [PATCH net-next 2/7] sfc: debugfs for channels
Date: Mon, 11 Dec 2023 17:18:27 +0000
Message-ID: <df43d737fda6b6aa0cda3f2cb300916ca4b2e8f8.1702314695.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: a2093385-4d05-4255-7587-08dbfa6d5cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LoeBl8Is6yPLYrjNhtR2+01Z3k1CVV3eiTDwGd8G0sG49FogJjRHxhsB/ALl87pYGV2xdrf0gZKSGL5gzthoIKHQprDaJNtFXmvkOwmPhuswxxhUUd/OzLnIcGMHs/Hb0KgRFTdl3fQMdcfp7hudAe/0HQm+10brim3LKDXpj8AAxI6fCgaUqtRQo3t4rRCswSv+ZtxBx2Tx6PHzGz85ginbZxfZz9+jpQCNtthshCKtZGxIK82x6r/iZuajrQfSGIgag9c+WnSM+pEDEBKeQiZtwjNTyOgdAy9aBquOAKkmtJNQ2Y/8hRFgXpire36qbUqkq5BSFgeNen3X7a3364gTZXLByzk++uF3zZXOvwDjf+xshKpp8foKS1jNaqOMu35BEHTqMWRjnvtyFoTObmw09JK6mRuKvQN6kIGVah52kE6uUx/LtuUNiPcW+gTGTr5FpfqDw83wAq6i3qzAba8+LzwhLg8UHiqfyH5S3EGte7eZQjE7ifJfPx48NYTS1bNHy2C/YmWSzbFpavjvUtZ3yr4qR3Ie0v3z5R8aww4iym8U/FX37DNWr0otST2Avw0KnwrjNuwlcXlvxW5/tqKrY75MwXXFjxHHZsp2UGf16n8wocPDN/wFVsmqa91ttQpPDqEnL2tYJngS5naemje7JC4pSsMYjzAvdJKJpwoGQylsj8ia3zmPhZH5stmQh+IwYkDOG0g9MDuLuCpDsqrOOJjmjohKGhDDqe0dHPtGdLX/9Od9KN8mrdBCbUKIr0wazMyUzMPvCpaEJft/qg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(9686003)(40460700003)(36860700001)(5660300002)(47076005)(336012)(26005)(36756003)(426003)(54906003)(70586007)(70206006)(40480700001)(2876002)(2906002)(83380400001)(81166007)(82740400003)(41300700001)(356005)(478600001)(86362001)(8676002)(8936002)(4326008)(55446002)(110136005)(316002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:19:41.8254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2093385-4d05-4255-7587-08dbfa6d5cd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

From: Edward Cree <ecree.xilinx@gmail.com>

Expose each channel's IRQ number and EVQ read pointer.

Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/debugfs.c      | 51 +++++++++++++++++++++++++
 drivers/net/ethernet/sfc/debugfs.h      | 15 ++++++++
 drivers/net/ethernet/sfc/efx_channels.c |  8 ++++
 drivers/net/ethernet/sfc/net_driver.h   |  6 +++
 4 files changed, 80 insertions(+)

diff --git a/drivers/net/ethernet/sfc/debugfs.c b/drivers/net/ethernet/sfc/debugfs.c
index cf800addb4ff..b46339249794 100644
--- a/drivers/net/ethernet/sfc/debugfs.c
+++ b/drivers/net/ethernet/sfc/debugfs.c
@@ -78,6 +78,54 @@ void efx_update_debugfs_netdev(struct efx_nic *efx)
 	mutex_unlock(&efx->debugfs_symlink_mutex);
 }
 
+#define EFX_DEBUGFS_CHANNEL(_type, _name)	\
+	debugfs_create_##_type(#_name, 0444, channel->debug_dir, &channel->_name)
+
+/* Create basic debugfs parameter files for an Efx channel */
+static void efx_init_debugfs_channel_files(struct efx_channel *channel)
+{
+	EFX_DEBUGFS_CHANNEL(bool, enabled);
+	EFX_DEBUGFS_CHANNEL(u32, irq); /* actually an int */
+	EFX_DEBUGFS_CHANNEL(u32, eventq_read_ptr);
+}
+
+/**
+ * efx_init_debugfs_channel - create debugfs directory for channel
+ * @channel:		Efx channel
+ *
+ * Create a debugfs directory containing parameter-files for @channel.
+ * The directory must be cleaned up using efx_fini_debugfs_channel().
+ *
+ * Return: a negative error code or 0 on success.
+ */
+int efx_init_debugfs_channel(struct efx_channel *channel)
+{
+	char name[EFX_DEBUGFS_NAME_LEN];
+
+	if (!channel->efx->debug_channels_dir)
+		return -ENODEV;
+	if (snprintf(name, sizeof(name), "%d", channel->channel)
+	    >= sizeof(name))
+		return -ENAMETOOLONG;
+	channel->debug_dir = debugfs_create_dir(name, channel->efx->debug_channels_dir);
+	if (!channel->debug_dir)
+		return -ENOMEM;
+	efx_init_debugfs_channel_files(channel);
+	return 0;
+}
+
+/**
+ * efx_fini_debugfs_channel - remove debugfs directory for channel
+ * @channel:		Efx channel
+ *
+ * Remove directory created for @channel by efx_init_debugfs_channel().
+ */
+void efx_fini_debugfs_channel(struct efx_channel *channel)
+{
+	debugfs_remove_recursive(channel->debug_dir);
+	channel->debug_dir = NULL;
+}
+
 static int efx_debugfs_enum_read(struct seq_file *s, void *d)
 {
 	struct efx_debugfs_enum_data *data = s->private;
@@ -160,6 +208,9 @@ int efx_init_debugfs_nic(struct efx_nic *efx)
 	if (!efx->debug_dir)
 		return -ENOMEM;
 	efx_init_debugfs_nic_files(efx);
+	/* Create channels subdirectory */
+	efx->debug_channels_dir = debugfs_create_dir("channels",
+						     efx->debug_dir);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/sfc/debugfs.h b/drivers/net/ethernet/sfc/debugfs.h
index 1fe40fbffa5e..4af4a03d1b97 100644
--- a/drivers/net/ethernet/sfc/debugfs.h
+++ b/drivers/net/ethernet/sfc/debugfs.h
@@ -22,11 +22,20 @@
  * bound and created a &struct efx_nic, there is a directory &efx_nic.debug_dir
  * in "cards" whose name is the PCI address of the device; it is to this
  * directory that the netdev symlink points.
+ *
+ * Under this directory, besides top-level parameter files, are:
+ *
+ * * "channels/" (&efx_nic.debug_channels_dir).  For each channel, this will
+ *   contain a directory (&efx_channel.debug_dir), whose name is the channel
+ *   index (in decimal).
  */
 
 void efx_fini_debugfs_netdev(struct net_device *net_dev);
 void efx_update_debugfs_netdev(struct efx_nic *efx);
 
+int efx_init_debugfs_channel(struct efx_channel *channel);
+void efx_fini_debugfs_channel(struct efx_channel *channel);
+
 int efx_init_debugfs_nic(struct efx_nic *efx);
 void efx_fini_debugfs_nic(struct efx_nic *efx);
 
@@ -39,6 +48,12 @@ static inline void efx_fini_debugfs_netdev(struct net_device *net_dev) {}
 
 static inline void efx_update_debugfs_netdev(struct efx_nic *efx) {}
 
+int efx_init_debugfs_channel(struct efx_channel *channel)
+{
+	return 0;
+}
+void efx_fini_debugfs_channel(struct efx_channel *channel) {}
+
 static inline int efx_init_debugfs_nic(struct efx_nic *efx)
 {
 	return 0;
diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index c9e17a8208a9..804a25ceea7f 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -19,6 +19,7 @@
 #include "nic.h"
 #include "sriov.h"
 #include "workarounds.h"
+#include "debugfs.h"
 
 /* This is the first interrupt mode to try out of:
  * 0 => MSI-X
@@ -667,6 +668,12 @@ static int efx_probe_channel(struct efx_channel *channel)
 
 	channel->rx_list = NULL;
 
+	rc = efx_init_debugfs_channel(channel);
+	if (rc) /* not fatal */
+		netif_err(channel->efx, drv, channel->efx->net_dev,
+			  "Failed to create debugfs for channel %d, rc=%d\n",
+			  channel->channel, rc);
+
 	return 0;
 
 fail:
@@ -743,6 +750,7 @@ void efx_remove_channel(struct efx_channel *channel)
 
 	netif_dbg(channel->efx, drv, channel->efx->net_dev,
 		  "destroy chan %d\n", channel->channel);
+	efx_fini_debugfs_channel(channel);
 
 	efx_for_each_channel_rx_queue(rx_queue, channel)
 		efx_remove_rx_queue(rx_queue);
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 961e2db31c6e..2b92c5461fe3 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -528,6 +528,10 @@ struct efx_channel {
 #define RPS_FLOW_ID_INVALID 0xFFFFFFFF
 	u32 *rps_flow_id;
 #endif
+#ifdef CONFIG_DEBUG_FS
+	/** @debug_dir: Channel debugfs directory (under @efx->debug_channels_dir) */
+	struct dentry *debug_dir;
+#endif
 
 	unsigned int n_rx_tobe_disc;
 	unsigned int n_rx_ip_hdr_chksum_err;
@@ -1144,6 +1148,8 @@ struct efx_nic {
 #ifdef CONFIG_DEBUG_FS
 	/** @debug_dir: NIC debugfs directory */
 	struct dentry *debug_dir;
+	/** @debug_channels_dir: contains channel debugfs dirs.  Under @debug_dir */
+	struct dentry *debug_channels_dir;
 	/** @debug_symlink: NIC debugfs symlink (``nic_eth%d``) */
 	struct dentry *debug_symlink;
 	/** @debug_interrupt_mode: debugfs details for printing @interrupt_mode */

