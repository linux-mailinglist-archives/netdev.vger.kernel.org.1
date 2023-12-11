Return-Path: <netdev+bounces-56004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4641C80D38F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C454C281D01
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056F4E1CD;
	Mon, 11 Dec 2023 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fh3I99uR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C3C7
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:19:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKLhVw9WJIgBMLXJ+SDofFr+ITVbYqKFG73Yh9g+MphIsHPyBK7XkT0+wTiwxjGkZzoazdzbB3RvQiMsiLsgmi/6okE7HhWIl8/4Cufknecg0Yd5+W84tpg5MgSaV2jDJr6rXsgc1oKP3Jpq4lA77fNOr9VH940aTL815wJuPFmh+Zjyhz4dP5sOxG8HtG43MCCbNY8uZYSyuDh7eF4Q2NI8OR0nCvLviXVdcXHai3ocV7Ti2qht8X4SPXha+zlFAyEe0PGdC88BEabEUMzSjiak7+Ska4fBSvuQJmjQgkCWocR9Bu3pWBbXo8OxtvnFp5beI1f/pQ2KAg5XPBYCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbu3jWDf6McsLaLyo98cnxOOfoXvMuUZYavxn2YJI18=;
 b=nHPSxWE6dZr9eI8mspqh2DZS/Or1ZnlkGN9WnpWAU3b7SaShr+7FUyne0hD/T8QSGXNnMxURtSP2KiEaouKfp4IoLyhSYtbc8p1alo17+L1T7YMilfk48EIeBpB3Y642nrs+sJ9oh/F/PwWkMd+Dvn32VL+Rr5oC5o2vEkhcZMuaaLEaoNmnaahWx22qAGwYnDsF/EcpPGAI9kFgOZuQGjk20dCKapi1dtwhpHXiSp920AHpp/XygExZ7de4oyS2eUKVHUBEEm9UQcp2X+0oex/qosONirXsgEwjftk/TYtmR/IR0NFTka9ARcL4+b2/42s6PJltQ+RndKGA6Sihiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbu3jWDf6McsLaLyo98cnxOOfoXvMuUZYavxn2YJI18=;
 b=fh3I99uRARTpDssD0d420H+fkFul5GrettSLOIBPVnEVOTmv7eLL7q1pYzAY1rXURBB1mkEUaC76XVI0X1b9mzsKoK3ZpW095oUEbEENF+Wtc+zzEbUnIvH5jvk6owc1fDqR+6Sqkncp3paIg3iCdVkl1k7CxaFdv9OBhgdi6TI=
Received: from BL1PR13CA0304.namprd13.prod.outlook.com (2603:10b6:208:2c1::9)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 17:19:43 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::35) by BL1PR13CA0304.outlook.office365.com
 (2603:10b6:208:2c1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.21 via Frontend
 Transport; Mon, 11 Dec 2023 17:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 17:19:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 11:19:42 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 11 Dec 2023 11:19:41 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: [PATCH net-next 3/7] sfc: debugfs for (nic) RX queues
Date: Mon, 11 Dec 2023 17:18:28 +0000
Message-ID: <a5c5491d3d0b58b8f8dff65cb53f892d7b13c32a.1702314695.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a92d96-b49d-4540-5274-08dbfa6d5d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9EF/gWeeUN00zNDLqJKFTsLTRxtn45zoEFCxh3xDAPbrxXYEgf3DZC6ixpa/xTVmDL/kc9iikxBjV3E9u3doo9OSvIKpwdmzCcLVt1jNzPUEouxOV5qYf3K8VoYENwDhl28vNLA89ZxNE6tHyZkVcgJZeANaULPKk+d8Tl8J1OX7mVHyFXkNrlvUzEY80CUjBLmEzrbzKWvVUgGLOc6NJJqhtOOu14UqGTvRWolAp9BHS3iybIuV/c8ERmm9d1RqN0HlFLPl5dnEZOMs8ga5KhX0fJmtfWG4PXm+T0rh7204WUIMppHhImHdriVpRHTsTBaCxwk+cPPOaIXptz1mGrlYUHsYt/Pwv01GyxX9X4HSSP5NVzeorU5TixFvBtaT6F3ZCmaxcV9g3iaewIjcKKdRlnk/Ta7gZvu13ykUORKLvu1CfWWYQx5pvpsX696z6g6Fy2BCv9Br/ChpbHlqGFw1E1PKw6yXpCg0JJ7o+LyJF+Aoc1jXl0dGcq5oQSBrtiHdKvDuc4ar2c1UgtsO1T2Soknj/m6l1M0ddMZ4JUJF6MebMUNH+axh25f9asDvRLYRCjxHa6QMdBmLq27IMzzIb2QM7mi9nJ7sbD7meEVFHO3XR2fYUFp6zDe2f8YUrKvd4sm32tejF0Qh/gIIL22FMMo3yi/MdeiXhniT70+XZp1FrExQUvgtumrMQoaDwk0Z4q7ABAU0ooGPaF9ZCsG2ru6zmUROnhog0dQgrEjvsJy+oSAeNoQy7qSYKT4tPKrXL9MZD6V0CJPWbrzsag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(426003)(336012)(26005)(40460700003)(82740400003)(81166007)(36756003)(356005)(55446002)(86362001)(83380400001)(5660300002)(9686003)(6666004)(36860700001)(8936002)(70586007)(8676002)(110136005)(70206006)(54906003)(316002)(47076005)(2906002)(4326008)(2876002)(41300700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:19:43.1100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a92d96-b49d-4540-5274-08dbfa6d5d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110

From: Edward Cree <ecree.xilinx@gmail.com>

Expose each RX queue's core RXQ association, and the read/write/etc
 pointers for the descriptor ring.
Each RXQ dir also symlinks to its owning channel.

Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/debugfs.c    | 69 ++++++++++++++++++++++++++-
 drivers/net/ethernet/sfc/debugfs.h    | 15 ++++++
 drivers/net/ethernet/sfc/net_driver.h |  6 +++
 drivers/net/ethernet/sfc/rx_common.c  |  9 ++++
 4 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/debugfs.c b/drivers/net/ethernet/sfc/debugfs.c
index b46339249794..43b1d06a985e 100644
--- a/drivers/net/ethernet/sfc/debugfs.c
+++ b/drivers/net/ethernet/sfc/debugfs.c
@@ -78,6 +78,72 @@ void efx_update_debugfs_netdev(struct efx_nic *efx)
 	mutex_unlock(&efx->debugfs_symlink_mutex);
 }
 
+#define EFX_DEBUGFS_RXQ(_type, _name)	\
+	debugfs_create_##_type(#_name, 0444, rx_queue->debug_dir, &rx_queue->_name)
+
+/* Create basic debugfs parameter files for an Efx RXQ */
+static void efx_init_debugfs_rx_queue_files(struct efx_rx_queue *rx_queue)
+{
+	EFX_DEBUGFS_RXQ(u32, core_index); /* actually an int */
+	/* descriptor ring indices */
+	EFX_DEBUGFS_RXQ(u32, added_count);
+	EFX_DEBUGFS_RXQ(u32, notified_count);
+	EFX_DEBUGFS_RXQ(u32, granted_count);
+	EFX_DEBUGFS_RXQ(u32, removed_count);
+}
+
+/**
+ * efx_init_debugfs_rx_queue - create debugfs directory for RX queue
+ * @rx_queue:		Efx RX queue
+ *
+ * Create a debugfs directory containing parameter-files for @rx_queue.
+ * The directory must be cleaned up using efx_fini_debugfs_rx_queue(),
+ * even if this function returns an error.
+ *
+ * Return: a negative error code or 0 on success.
+ */
+int efx_init_debugfs_rx_queue(struct efx_rx_queue *rx_queue)
+{
+	struct efx_channel *channel = efx_rx_queue_channel(rx_queue);
+	char target[EFX_DEBUGFS_NAME_LEN];
+	char name[EFX_DEBUGFS_NAME_LEN];
+
+	if (!rx_queue->efx->debug_queues_dir)
+		return -ENODEV;
+	/* Create directory */
+	if (snprintf(name, sizeof(name), "rx-%d", efx_rx_queue_index(rx_queue))
+	    >= sizeof(name))
+		return -ENAMETOOLONG;
+	rx_queue->debug_dir = debugfs_create_dir(name,
+						 rx_queue->efx->debug_queues_dir);
+	if (!rx_queue->debug_dir)
+		return -ENOMEM;
+
+	/* Create files */
+	efx_init_debugfs_rx_queue_files(rx_queue);
+
+	/* Create symlink to channel */
+	if (snprintf(target, sizeof(target), "../../channels/%d",
+		     channel->channel) >= sizeof(target))
+		return -ENAMETOOLONG;
+	if (!debugfs_create_symlink("channel", rx_queue->debug_dir, target))
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * efx_fini_debugfs_rx_queue - remove debugfs directory for RX queue
+ * @rx_queue:		Efx RX queue
+ *
+ * Remove directory created for @rx_queue by efx_init_debugfs_rx_queue().
+ */
+void efx_fini_debugfs_rx_queue(struct efx_rx_queue *rx_queue)
+{
+	debugfs_remove_recursive(rx_queue->debug_dir);
+	rx_queue->debug_dir = NULL;
+}
+
 #define EFX_DEBUGFS_CHANNEL(_type, _name)	\
 	debugfs_create_##_type(#_name, 0444, channel->debug_dir, &channel->_name)
 
@@ -208,9 +274,10 @@ int efx_init_debugfs_nic(struct efx_nic *efx)
 	if (!efx->debug_dir)
 		return -ENOMEM;
 	efx_init_debugfs_nic_files(efx);
-	/* Create channels subdirectory */
+	/* Create subdirectories */
 	efx->debug_channels_dir = debugfs_create_dir("channels",
 						     efx->debug_dir);
+	efx->debug_queues_dir = debugfs_create_dir("queues", efx->debug_dir);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/sfc/debugfs.h b/drivers/net/ethernet/sfc/debugfs.h
index 4af4a03d1b97..53c98a2fb4c9 100644
--- a/drivers/net/ethernet/sfc/debugfs.h
+++ b/drivers/net/ethernet/sfc/debugfs.h
@@ -28,11 +28,20 @@
  * * "channels/" (&efx_nic.debug_channels_dir).  For each channel, this will
  *   contain a directory (&efx_channel.debug_dir), whose name is the channel
  *   index (in decimal).
+ * * "queues/" (&efx_nic.debug_queues_dir).
+ *
+ *   * For each NIC RX queue, this will contain a directory
+ *     (&efx_rx_queue.debug_dir), whose name is "rx-N" where N is the RX queue
+ *     index.  (This may not be the same as the kernel core RX queue index.)
+ *     The directory will contain a symlink to the owning channel.
  */
 
 void efx_fini_debugfs_netdev(struct net_device *net_dev);
 void efx_update_debugfs_netdev(struct efx_nic *efx);
 
+int efx_init_debugfs_rx_queue(struct efx_rx_queue *rx_queue);
+void efx_fini_debugfs_rx_queue(struct efx_rx_queue *rx_queue);
+
 int efx_init_debugfs_channel(struct efx_channel *channel);
 void efx_fini_debugfs_channel(struct efx_channel *channel);
 
@@ -48,6 +57,12 @@ static inline void efx_fini_debugfs_netdev(struct net_device *net_dev) {}
 
 static inline void efx_update_debugfs_netdev(struct efx_nic *efx) {}
 
+int efx_init_debugfs_rx_queue(struct efx_rx_queue *rx_queue)
+{
+	return 0;
+}
+void efx_fini_debugfs_rx_queue(struct efx_rx_queue *rx_queue) {}
+
 int efx_init_debugfs_channel(struct efx_channel *channel)
 {
 	return 0;
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 2b92c5461fe3..63eb32670826 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -424,6 +424,10 @@ struct efx_rx_queue {
 	struct work_struct grant_work;
 	/* Statistics to supplement MAC stats */
 	unsigned long rx_packets;
+#ifdef CONFIG_DEBUG_FS
+	/** @debug_dir: Queue debugfs directory (under @efx->debug_queues_dir) */
+	struct dentry *debug_dir;
+#endif
 	struct xdp_rxq_info xdp_rxq_info;
 	bool xdp_rxq_info_valid;
 };
@@ -1150,6 +1154,8 @@ struct efx_nic {
 	struct dentry *debug_dir;
 	/** @debug_channels_dir: contains channel debugfs dirs.  Under @debug_dir */
 	struct dentry *debug_channels_dir;
+	/** @debug_queues_dir: contains RX/TX queue debugfs dirs.  Under @debug_dir */
+	struct dentry *debug_queues_dir;
 	/** @debug_symlink: NIC debugfs symlink (``nic_eth%d``) */
 	struct dentry *debug_symlink;
 	/** @debug_interrupt_mode: debugfs details for printing @interrupt_mode */
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index d2f35ee15eff..7f63f70f082d 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -14,6 +14,7 @@
 #include "efx.h"
 #include "nic.h"
 #include "rx_common.h"
+#include "debugfs.h"
 
 /* This is the percentage fill level below which new RX descriptors
  * will be added to the RX descriptor ring.
@@ -208,6 +209,12 @@ int efx_probe_rx_queue(struct efx_rx_queue *rx_queue)
 	if (!rx_queue->buffer)
 		return -ENOMEM;
 
+	rc = efx_init_debugfs_rx_queue(rx_queue);
+	if (rc) /* not fatal */
+		netif_err(efx, drv, efx->net_dev,
+			  "Failed to create debugfs for RXQ %d, rc=%d\n",
+			  efx_rx_queue_index(rx_queue), rc);
+
 	rc = efx_nic_probe_rx(rx_queue);
 	if (rc) {
 		kfree(rx_queue->buffer);
@@ -311,6 +318,8 @@ void efx_remove_rx_queue(struct efx_rx_queue *rx_queue)
 
 	efx_nic_remove_rx(rx_queue);
 
+	efx_fini_debugfs_rx_queue(rx_queue);
+
 	kfree(rx_queue->buffer);
 	rx_queue->buffer = NULL;
 }

