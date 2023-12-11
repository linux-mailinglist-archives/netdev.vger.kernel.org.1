Return-Path: <netdev+bounces-56006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB3F80D391
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5F41C214B1
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF04E605;
	Mon, 11 Dec 2023 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J19yIvQt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29660CF
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:19:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGYheD7zjP/nLYMOuvtWg+cFLZ6bWkx180W9Vu9yHcWTr9BcbhwQCjgD1PVRrFelsoOq4tV7cqtSox77TCm9H0ckttfjsBOC2YaLPPIT5RvSq+eMwWICW7wczcmGpxdJ15OhLr1vlGBc6HT/uvialqyCL1F4Lbc95Lu65dMZByNWZjOzyMKwCiwiY2zyGjRdQ9R0rAa5AOXydpA6wshnttrIJpg0y3O67O/jVGWAl7vj6etWB/GVG+wwBdkFG5B+WFUqJoHq7/lkMKekdTHl/qrLfl97N7MqwG1yxFKD80aohGiDoHnbNMZ6IbHiXDrH//pEKKv05RGibFwMsaNdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbTvZ8qbUZ8Fx17miXc33ApZU0mLxRuM6IqI8xBdFaA=;
 b=cyT5Oo4S5e8cY04B7nBJXfZYB8iSA2SvuNZNIMaY/EzzUr5bcOAFaBXT9Qx0TJMqZodFGMbIjtoShXvwHEQnhvSSK5+jrfF+OdW+ha66Wy7Uw3L2rz7OQMdiS8xxE+jMPuyfXlR+ZwY9vgPRydxpw0cjnDiIC8dpcjZBz07JvkmhVoVKNtViV+lTHYy2hFgDBVxcMxQPutCc8KdameBYj0zGyWdYPWXUROEA1OKWH4w35bZLqHAJtRAkzs2vnd0bUefVKABCqreAzxAZ701nV0ssele8S9rJv4UmYjNS3Jt7TGfSTEBPX5OYONrkV5Xy062YqVN9MbmEQlC0fZOTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbTvZ8qbUZ8Fx17miXc33ApZU0mLxRuM6IqI8xBdFaA=;
 b=J19yIvQtsCHV0KXRK886Y3M4hf+4bP3Jl90wZGy+KJGl8I+X1Pd54KsKuz88aciIMctwENvkUDBnZDw9ZGZcjTcwU44xx5CTTGalmXBQyN08SLQd86eBgeVs32X68Ag5yB+FM2l1eAmXgGYyq4x8VjxhV1EsLe2QEM6jIUhluvc=
Received: from BL1PR13CA0304.namprd13.prod.outlook.com (2603:10b6:208:2c1::9)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:19:44 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::35) by BL1PR13CA0304.outlook.office365.com
 (2603:10b6:208:2c1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.21 via Frontend
 Transport; Mon, 11 Dec 2023 17:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 17:19:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 11:19:43 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 11 Dec 2023 11:19:42 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: [PATCH net-next 4/7] sfc: debugfs for (nic) TX queues
Date: Mon, 11 Dec 2023 17:18:29 +0000
Message-ID: <91beef38162b8e243c2275b41a6f37c01f19850f.1702314695.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 206c48de-01d9-408c-994b-08dbfa6d5e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y3hSWVFPsKU25mh/sPZmaHini1oK4xpP0WElQq83I7WkfOawar/zTmmocjnhdJgyQ5JYc6AAaveZsVm0saFAzZYviyr0fea3Ifway/rMbqQqdzWLsPG8vGsP4dD6kTz0b9ATnHldNs5dPbMQMPv/EmTIddNYdILkCDlXr/lCBfAp9vaPRE7nVkFuMSp9VmCvXdE1QW7pMWHb4E8VruJTXKDg38rdUp/P2ELjHTgEwAS8oNTBOUO6TQ11/w3B71L6n4Ipcrce4gYVdBiGAcL8St5VsjI2PRFxoUhJ4o9H8f3Tg66X6BSgqPpc/cAXPwXo2trvK+nkAuPTkPn4nrZzXNHgi7FuS0pMYxYxGGqp6LQlTmFBHT7/plyIQFkvIOxZyRs+7ClYmsQBPuxUKEv99ljAMO0InGVH9DpcnOfy4q4nmIjpIS1HHqTrlRGl3Bf91t2x2ocX3PEYnp4cCsYa3aKQ7tC8Z3YDwHeTqum5j1axAedaB+YxNoExxa2RbXGN/xjzhIfE1P81bgS/M7iCmHB9JBHFsvYC9QSOb6Dv6dL47RjxNbjSbDEZP54D6CO+hbDilo5VEZCj42BsLuBRsiPgj8yKFNQe9QlvzIFfIJ2I+Z3HoekKswiSQp6qAH2/9Ke2ia5oRHi05SSc5b/oby4K0X4MqtTdMc+QCbnkNshv5iKZ+RLGrPyG+4O1Uc1zYEJKtorpWjR1N1TP3RXFUva0tEkw/KskVvdQigVTI01slP3M05bVnHzW53N1Fpz7Je/Vq8fJdk1uVeac3JrCRw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(2876002)(40460700003)(2906002)(41300700001)(36756003)(110136005)(36860700001)(86362001)(55446002)(82740400003)(356005)(9686003)(336012)(426003)(26005)(478600001)(6666004)(83380400001)(47076005)(81166007)(4326008)(5660300002)(316002)(70586007)(70206006)(54906003)(8936002)(8676002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:19:44.4225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 206c48de-01d9-408c-994b-08dbfa6d5e5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853

From: Edward Cree <ecree.xilinx@gmail.com>

Expose each TX queue's label, type (csum offloads), TSO and timestamping
 capabilities, and the read/write/etc pointers for the descriptor ring.
Each TXQ dir also symlinks to its owning channel.

Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/debugfs.c    | 71 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/debugfs.h    | 14 ++++++
 drivers/net/ethernet/sfc/net_driver.h |  4 ++
 drivers/net/ethernet/sfc/tx_common.c  |  8 +++
 4 files changed, 97 insertions(+)

diff --git a/drivers/net/ethernet/sfc/debugfs.c b/drivers/net/ethernet/sfc/debugfs.c
index 43b1d06a985e..8ee6e401ea44 100644
--- a/drivers/net/ethernet/sfc/debugfs.c
+++ b/drivers/net/ethernet/sfc/debugfs.c
@@ -78,6 +78,77 @@ void efx_update_debugfs_netdev(struct efx_nic *efx)
 	mutex_unlock(&efx->debugfs_symlink_mutex);
 }
 
+#define EFX_DEBUGFS_TXQ(_type, _name)	\
+	debugfs_create_##_type(#_name, 0444, tx_queue->debug_dir, &tx_queue->_name)
+
+/* Create basic debugfs parameter files for an Efx TXQ */
+static void efx_init_debugfs_tx_queue_files(struct efx_tx_queue *tx_queue)
+{
+	EFX_DEBUGFS_TXQ(u32, label);
+	EFX_DEBUGFS_TXQ(bool, xdp_tx);
+	/* offload features */
+	EFX_DEBUGFS_TXQ(u32, type);
+	EFX_DEBUGFS_TXQ(u32, tso_version);
+	EFX_DEBUGFS_TXQ(bool, tso_encap);
+	EFX_DEBUGFS_TXQ(bool, timestamping);
+	/* descriptor ring indices */
+	EFX_DEBUGFS_TXQ(u32, read_count);
+	EFX_DEBUGFS_TXQ(u32, insert_count);
+	EFX_DEBUGFS_TXQ(u32, write_count);
+	EFX_DEBUGFS_TXQ(u32, notify_count);
+}
+
+/**
+ * efx_init_debugfs_tx_queue - create debugfs directory for TX queue
+ * @tx_queue:		Efx TX queue
+ *
+ * Create a debugfs directory containing parameter-files for @tx_queue.
+ * The directory must be cleaned up using efx_fini_debugfs_tx_queue(),
+ * even if this function returns an error.
+ *
+ * Return: a negative error code or 0 on success.
+ */
+int efx_init_debugfs_tx_queue(struct efx_tx_queue *tx_queue)
+{
+	char target[EFX_DEBUGFS_NAME_LEN];
+	char name[EFX_DEBUGFS_NAME_LEN];
+
+	if (!tx_queue->efx->debug_queues_dir)
+		return -ENODEV;
+	/* Create directory */
+	if (snprintf(name, sizeof(name), "tx-%d", tx_queue->queue)
+	    >= sizeof(name))
+		return -ENAMETOOLONG;
+	tx_queue->debug_dir = debugfs_create_dir(name,
+						 tx_queue->efx->debug_queues_dir);
+	if (!tx_queue->debug_dir)
+		return -ENOMEM;
+
+	/* Create files */
+	efx_init_debugfs_tx_queue_files(tx_queue);
+
+	/* Create symlink to channel */
+	if (snprintf(target, sizeof(target), "../../channels/%d",
+		     tx_queue->channel->channel) >= sizeof(target))
+		return -ENAMETOOLONG;
+	if (!debugfs_create_symlink("channel", tx_queue->debug_dir, target))
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * efx_fini_debugfs_tx_queue - remove debugfs directory for TX queue
+ * @tx_queue:		Efx TX queue
+ *
+ * Remove directory created for @tx_queue by efx_init_debugfs_tx_queue().
+ */
+void efx_fini_debugfs_tx_queue(struct efx_tx_queue *tx_queue)
+{
+	debugfs_remove_recursive(tx_queue->debug_dir);
+	tx_queue->debug_dir = NULL;
+}
+
 #define EFX_DEBUGFS_RXQ(_type, _name)	\
 	debugfs_create_##_type(#_name, 0444, rx_queue->debug_dir, &rx_queue->_name)
 
diff --git a/drivers/net/ethernet/sfc/debugfs.h b/drivers/net/ethernet/sfc/debugfs.h
index 53c98a2fb4c9..3e8d2e2b5bad 100644
--- a/drivers/net/ethernet/sfc/debugfs.h
+++ b/drivers/net/ethernet/sfc/debugfs.h
@@ -34,11 +34,19 @@
  *     (&efx_rx_queue.debug_dir), whose name is "rx-N" where N is the RX queue
  *     index.  (This may not be the same as the kernel core RX queue index.)
  *     The directory will contain a symlink to the owning channel.
+ *   * For each NIC TX queue, this will contain a directory
+ *     (&efx_tx_queue.debug_dir), whose name is "tx-N" where N is the TX queue
+ *     index.  (This may differ from both the kernel core TX queue index and
+ *     the hardware queue label of the TXQ.)
+ *     The directory will contain a symlink to the owning channel.
  */
 
 void efx_fini_debugfs_netdev(struct net_device *net_dev);
 void efx_update_debugfs_netdev(struct efx_nic *efx);
 
+int efx_init_debugfs_tx_queue(struct efx_tx_queue *tx_queue);
+void efx_fini_debugfs_tx_queue(struct efx_tx_queue *tx_queue);
+
 int efx_init_debugfs_rx_queue(struct efx_rx_queue *rx_queue);
 void efx_fini_debugfs_rx_queue(struct efx_rx_queue *rx_queue);
 
@@ -57,6 +65,12 @@ static inline void efx_fini_debugfs_netdev(struct net_device *net_dev) {}
 
 static inline void efx_update_debugfs_netdev(struct efx_nic *efx) {}
 
+int efx_init_debugfs_tx_queue(struct efx_tx_queue *tx_queue)
+{
+	return 0;
+}
+void efx_fini_debugfs_tx_queue(struct efx_tx_queue *tx_queue) {}
+
 int efx_init_debugfs_rx_queue(struct efx_rx_queue *rx_queue)
 {
 	return 0;
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 63eb32670826..feb87979059c 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -273,6 +273,10 @@ struct efx_tx_queue {
 	bool initialised;
 	bool timestamping;
 	bool xdp_tx;
+#ifdef CONFIG_DEBUG_FS
+	/** @debug_dir: Queue debugfs directory (under @efx->debug_queues_dir) */
+	struct dentry *debug_dir;
+#endif
 
 	/* Members used mainly on the completion path */
 	unsigned int read_count ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
index 9f2393d34371..3780da849e98 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -12,6 +12,7 @@
 #include "efx.h"
 #include "nic_common.h"
 #include "tx_common.h"
+#include "debugfs.h"
 #include <net/gso.h>
 
 static unsigned int efx_tx_cb_page_count(struct efx_tx_queue *tx_queue)
@@ -47,6 +48,11 @@ int efx_probe_tx_queue(struct efx_tx_queue *tx_queue)
 		rc = -ENOMEM;
 		goto fail1;
 	}
+	rc = efx_init_debugfs_tx_queue(tx_queue);
+	if (rc) /* not fatal */
+		netif_err(efx, drv, efx->net_dev,
+			  "Failed to create debugfs for TXQ %d, rc=%d\n",
+			  tx_queue->queue, rc);
 
 	/* Allocate hardware ring, determine TXQ type */
 	rc = efx_nic_probe_tx(tx_queue);
@@ -133,6 +139,8 @@ void efx_remove_tx_queue(struct efx_tx_queue *tx_queue)
 		  "destroying TX queue %d\n", tx_queue->queue);
 	efx_nic_remove_tx(tx_queue);
 
+	efx_fini_debugfs_tx_queue(tx_queue);
+
 	if (tx_queue->cb_page) {
 		for (i = 0; i < efx_tx_cb_page_count(tx_queue); i++)
 			efx_nic_free_buffer(tx_queue->efx,

