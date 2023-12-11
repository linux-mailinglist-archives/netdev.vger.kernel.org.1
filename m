Return-Path: <netdev+bounces-56010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA8D80D396
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C849C281AF7
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5D24EB45;
	Mon, 11 Dec 2023 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g4v80DOp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B75DB
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:19:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMFq0/RbIat/iO0+v+ocfTztSD8/ENOJ4VFekGDp4Tg77sK0KccjvcKxSZTqDH84CwBpCKnuGdRkXAKpyHSjb1mozG65jMRXRLa49GAxDExwUJNXEvdrclRf2oudTN2q69cHhXKcKxeKUWUcKlmFwVZBe0ORFBNQ9VFzKtEfYVPN6hy9hsmQn/axvV+1ETdAY22CIJsPfloZLzIRqoXrtNv9MNUOV5HCPq0RyDJWIGTT664ZzAckp1KftE7YxzbbKx5vGZv741uY4iT0DAB6shE3EmK2kTwWwaS0ynCHj4FzbYHLMrZqZQIk1VZe7VpdFnQsEPziEeHJfDPcchYE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiiE/G0fjq8l8nKeRjZq8S+Jym/ah+ztytXTEswnBNU=;
 b=Wf+AD7HEzJ9BkOKGYzFb0XBUf49xSA+4KMHVAtzpt82QbjW2BmTzuE4G98tXCIkHFTGx/lS5Ml4nNUioBUCq/lEXlRW5AsrTmOtVJYCyIky5NcfqHMIO+9KG7fB3TRsiRdsLTuF/k3Fxl3J2lfc2KAg67XvrwyAH+i6JznxGyPvpNLER0b4t+V/6RfPkIzMnyj0I1/AXpLnTKiLD4Nx/+ywhORa8CHUHqOlQbxaGPvuU4WSu+46qyjhUpiu6R+ir5yfNL8VJ2eEKUDU/oJKG+sBu/5hEAWbsij0k8v7Js0GoWFFQzwHOv0YLWYRqgDVladXSrxXTSz7GrTdY/uhjvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiiE/G0fjq8l8nKeRjZq8S+Jym/ah+ztytXTEswnBNU=;
 b=g4v80DOpDZhf9Rla+wdre4MMH5Azi8mbBvnnAk9UcRexCo/TE+ujwXc8sNZbEESPINfrpxoGOMNSLwqdVY/vE8oxuS7kG9KlIOHtQpzvfcdi+/l46tHI045zfXglO0e4HR8LQIp4v53+urkfYe26cPGewdt6EfSTG8OwuKMfkUc=
Received: from BLAPR03CA0081.namprd03.prod.outlook.com (2603:10b6:208:329::26)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:19:49 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::8c) by BLAPR03CA0081.outlook.office365.com
 (2603:10b6:208:329::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 17:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 17:19:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 11:19:47 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 11 Dec 2023 11:19:46 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: [PATCH net-next 7/7] sfc: add debugfs node for filter table contents
Date: Mon, 11 Dec 2023 17:18:32 +0000
Message-ID: <0cf27cb7a42cc81c8d360b5812690e636a100244.1702314695.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7fbc85-c4ec-4152-77f3-08dbfa6d6168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	csISDJYgiH37f3c0yY5M7jmDD1/JXwh6HS/4qy6ecEQnKpFNGCNODRrQ2ZlCPL3YAq+M301gFVIzvRdBFnB+z/trZTWGdPJFJqvNus23Orb9M1qZIFWGNKEdRwt5AHjmTQq5HergiWfMQhk6TUBCLk9/8ojrzi6oGS8neKWszRqJytk9BVw1qCX150pjWMyVR3jDNIqYu57gqTTUO/KRirWjPukCdeVtSsQm3dTCiGl52di9I/BXmZE+eAD71ouDWdGOKz/d0R6/I3SFupPPxfpsB0z0V0YWrI5nBCd5yajERyEyj9oDch9tj/RkSNm06TvnuxlQ1rGwYxcr4ArPpjiRaV1yS00lzMPv8z3kMuk9pGwsCJCMBC6b1adNbYJw7xG7JQ+0LN72HwvjA9fqVqHHiDCOLQ+U/eblfGUMic2fKu8vn0tsKCMk5kuvRb6j0dqrS/+smvuA0O66QyuwW97TKOD4FXoxyPxDSnViD7LP1xYroVo2o9V+wSzQSmanaOZwIa1iixvEU67nwzOD9W3VpCje9WiiXvreYebVVEQSuqjumQHpRsigv8HE21j4D8FAWpTTdUE8CDfYfFkcbHZK2e6FkEbJrRBZfPIRq4j6I7Xgp9GUz6EU8Lx19Q9RQs1ER/MhWoA0m7Bhi/FDA4gsykzCzdSzR9HbbfJVMADPVFERfe9mw+pqu0GB/ZdfRSoWosSrT0vK/lEH4tphWKMotw+d5gpmZIao3eV9/EdqtsjkBnKKgB6fcg3gZfnXMmgoBChGjt8QbttTHljooQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(26005)(426003)(336012)(40460700003)(82740400003)(36756003)(81166007)(55446002)(86362001)(356005)(47076005)(5660300002)(83380400001)(6666004)(9686003)(36860700001)(316002)(70586007)(70206006)(110136005)(8936002)(8676002)(54906003)(4326008)(2876002)(2906002)(41300700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:19:49.5204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7fbc85-c4ec-4152-77f3-08dbfa6d6168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978

From: Edward Cree <ecree.xilinx@gmail.com>

Expose the filter table entries.

Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/debugfs.c      | 117 +++++++++++++++++++++++-
 drivers/net/ethernet/sfc/debugfs.h      |  45 +++++++++
 drivers/net/ethernet/sfc/mcdi_filters.c |  39 ++++++++
 3 files changed, 197 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/debugfs.c b/drivers/net/ethernet/sfc/debugfs.c
index 549ff1ee273e..e67b0fc927fe 100644
--- a/drivers/net/ethernet/sfc/debugfs.c
+++ b/drivers/net/ethernet/sfc/debugfs.c
@@ -9,10 +9,6 @@
  */
 
 #include "debugfs.h"
-#include <linux/module.h>
-#include <linux/debugfs.h>
-#include <linux/dcache.h>
-#include <linux/seq_file.h>
 
 /* Maximum length for a name component or symlink target */
 #define EFX_DEBUGFS_NAME_LEN 32
@@ -428,3 +424,116 @@ void efx_fini_debugfs(void)
 	efx_debug_cards = NULL;
 	efx_debug_root = NULL;
 }
+
+/**
+ * efx_debugfs_print_filter - format a filter spec for display
+ * @s: buffer to write result into
+ * @l: length of buffer @s
+ * @spec: filter specification
+ */
+void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec)
+{
+	u32 ip[4];
+	int p = snprintf(s, l, "match=%#x,pri=%d,flags=%#x,q=%d",
+			 spec->match_flags, spec->priority, spec->flags,
+			 spec->dmaq_id);
+
+	if (spec->vport_id)
+		p += snprintf(s + p, l - p, ",vport=%#x", spec->vport_id);
+
+	if (spec->flags & EFX_FILTER_FLAG_RX_RSS)
+		p += snprintf(s + p, l - p, ",rss=%#x", spec->rss_context);
+
+	if (spec->match_flags & EFX_FILTER_MATCH_OUTER_VID)
+		p += snprintf(s + p, l - p,
+			      ",ovid=%d", ntohs(spec->outer_vid));
+	if (spec->match_flags & EFX_FILTER_MATCH_INNER_VID)
+		p += snprintf(s + p, l - p,
+			      ",ivid=%d", ntohs(spec->inner_vid));
+	if (spec->match_flags & EFX_FILTER_MATCH_ENCAP_TYPE)
+		p += snprintf(s + p, l - p,
+			      ",encap=%d", spec->encap_type);
+	if (spec->match_flags & EFX_FILTER_MATCH_LOC_MAC)
+		p += snprintf(s + p, l - p,
+			      ",lmac=%02x:%02x:%02x:%02x:%02x:%02x",
+			      spec->loc_mac[0], spec->loc_mac[1],
+			      spec->loc_mac[2], spec->loc_mac[3],
+			      spec->loc_mac[4], spec->loc_mac[5]);
+	if (spec->match_flags & EFX_FILTER_MATCH_REM_MAC)
+		p += snprintf(s + p, l - p,
+			      ",rmac=%02x:%02x:%02x:%02x:%02x:%02x",
+			      spec->rem_mac[0], spec->rem_mac[1],
+			      spec->rem_mac[2], spec->rem_mac[3],
+			      spec->rem_mac[4], spec->rem_mac[5]);
+	if (spec->match_flags & EFX_FILTER_MATCH_ETHER_TYPE)
+		p += snprintf(s + p, l - p,
+			      ",ether=%#x", ntohs(spec->ether_type));
+	if (spec->match_flags & EFX_FILTER_MATCH_IP_PROTO)
+		p += snprintf(s + p, l - p,
+			      ",ippr=%#x", spec->ip_proto);
+	if (spec->match_flags & EFX_FILTER_MATCH_LOC_HOST) {
+		if (ntohs(spec->ether_type) == ETH_P_IP) {
+			ip[0] = (__force u32) spec->loc_host[0];
+			p += snprintf(s + p, l - p,
+				      ",lip=%d.%d.%d.%d",
+				      ip[0] & 0xff,
+				      (ip[0] >> 8) & 0xff,
+				      (ip[0] >> 16) & 0xff,
+				      (ip[0] >> 24) & 0xff);
+		} else if (ntohs(spec->ether_type) == ETH_P_IPV6) {
+			ip[0] = (__force u32) spec->loc_host[0];
+			ip[1] = (__force u32) spec->loc_host[1];
+			ip[2] = (__force u32) spec->loc_host[2];
+			ip[3] = (__force u32) spec->loc_host[3];
+			p += snprintf(s + p, l - p,
+				      ",lip=%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
+				      ip[0] & 0xffff,
+				      (ip[0] >> 16) & 0xffff,
+				      ip[1] & 0xffff,
+				      (ip[1] >> 16) & 0xffff,
+				      ip[2] & 0xffff,
+				      (ip[2] >> 16) & 0xffff,
+				      ip[3] & 0xffff,
+				      (ip[3] >> 16) & 0xffff);
+		} else {
+			p += snprintf(s + p, l - p, ",lip=?");
+		}
+	}
+	if (spec->match_flags & EFX_FILTER_MATCH_REM_HOST) {
+		if (ntohs(spec->ether_type) == ETH_P_IP) {
+			ip[0] = (__force u32) spec->rem_host[0];
+			p += snprintf(s + p, l - p,
+				      ",rip=%d.%d.%d.%d",
+				      ip[0] & 0xff,
+				      (ip[0] >> 8) & 0xff,
+				      (ip[0] >> 16) & 0xff,
+				      (ip[0] >> 24) & 0xff);
+		} else if (ntohs(spec->ether_type) == ETH_P_IPV6) {
+			ip[0] = (__force u32) spec->rem_host[0];
+			ip[1] = (__force u32) spec->rem_host[1];
+			ip[2] = (__force u32) spec->rem_host[2];
+			ip[3] = (__force u32) spec->rem_host[3];
+			p += snprintf(s + p, l - p,
+				      ",rip=%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
+				      ip[0] & 0xffff,
+				      (ip[0] >> 16) & 0xffff,
+				      ip[1] & 0xffff,
+				      (ip[1] >> 16) & 0xffff,
+				      ip[2] & 0xffff,
+				      (ip[2] >> 16) & 0xffff,
+				      ip[3] & 0xffff,
+				      (ip[3] >> 16) & 0xffff);
+		} else {
+			p += snprintf(s + p, l - p, ",rip=?");
+		}
+	}
+	if (spec->match_flags & EFX_FILTER_MATCH_LOC_PORT)
+		p += snprintf(s + p, l - p,
+			      ",lport=%d", ntohs(spec->loc_port));
+	if (spec->match_flags & EFX_FILTER_MATCH_REM_PORT)
+		p += snprintf(s + p, l - p,
+			      ",rport=%d", ntohs(spec->rem_port));
+	if (spec->match_flags & EFX_FILTER_MATCH_LOC_MAC_IG)
+		p += snprintf(s + p, l - p, ",%s",
+			      spec->loc_mac[0] ? "mc" : "uc");
+}
diff --git a/drivers/net/ethernet/sfc/debugfs.h b/drivers/net/ethernet/sfc/debugfs.h
index 7a96f3798cbd..f50b4bf33a6b 100644
--- a/drivers/net/ethernet/sfc/debugfs.h
+++ b/drivers/net/ethernet/sfc/debugfs.h
@@ -10,6 +10,10 @@
 
 #ifndef EFX_DEBUGFS_H
 #define EFX_DEBUGFS_H
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <linux/dcache.h>
+#include <linux/seq_file.h>
 #include "net_driver.h"
 
 #ifdef CONFIG_DEBUG_FS
@@ -63,6 +67,45 @@ void efx_fini_debugfs_nic(struct efx_nic *efx);
 int efx_init_debugfs(void);
 void efx_fini_debugfs(void);
 
+void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec);
+
+/* Generate operations for a debugfs node with a custom reader function.
+ * The reader should have signature int (*)(struct seq_file *s, void *data)
+ * where data is the pointer passed to EFX_DEBUGFS_CREATE_RAW.
+ */
+#define EFX_DEBUGFS_RAW_PARAMETER(_reader)				       \
+									       \
+static int efx_debugfs_##_reader##_read(struct seq_file *s, void *d)	       \
+{									       \
+	return _reader(s, s->private);					       \
+}									       \
+									       \
+static int efx_debugfs_##_reader##_open(struct inode *inode, struct file *f)   \
+{									       \
+	return single_open(f, efx_debugfs_##_reader##_read, inode->i_private); \
+}									       \
+									       \
+static const struct file_operations efx_debugfs_##_reader##_ops = {	       \
+	.owner = THIS_MODULE,						       \
+	.open = efx_debugfs_##_reader##_open,				       \
+	.release = single_release,					       \
+	.read = seq_read,						       \
+	.llseek = seq_lseek,						       \
+};									       \
+									       \
+static void efx_debugfs_create_##_reader(const char *name, umode_t mode,       \
+					 struct dentry *parent, void *data)    \
+{									       \
+	debugfs_create_file(name, mode, parent, data,			       \
+			    &efx_debugfs_##_reader##_ops);		       \
+}
+
+/* Instantiate a debugfs node with a custom reader function.  The operations
+ * must have been generated with EFX_DEBUGFS_RAW_PARAMETER(_reader).
+ */
+#define EFX_DEBUGFS_CREATE_RAW(_name, _mode, _parent, _data, _reader)	       \
+		efx_debugfs_create_##_reader(_name, _mode, _parent, _data)
+
 #else /* CONFIG_DEBUG_FS */
 
 static inline void efx_fini_debugfs_netdev(struct net_device *net_dev) {}
@@ -99,6 +142,8 @@ static inline int efx_init_debugfs(void)
 }
 static inline void efx_fini_debugfs(void) {}
 
+void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec) {}
+
 #endif /* CONFIG_DEBUG_FS */
 
 #endif /* EFX_DEBUGFS_H */
diff --git a/drivers/net/ethernet/sfc/mcdi_filters.c b/drivers/net/ethernet/sfc/mcdi_filters.c
index a4ab45082c8f..465226c3e8c7 100644
--- a/drivers/net/ethernet/sfc/mcdi_filters.c
+++ b/drivers/net/ethernet/sfc/mcdi_filters.c
@@ -13,6 +13,7 @@
 #include "mcdi.h"
 #include "nic.h"
 #include "rx_common.h"
+#include "debugfs.h"
 
 /* The maximum size of a shared RSS context */
 /* TODO: this should really be from the mcdi protocol export */
@@ -1173,6 +1174,42 @@ s32 efx_mcdi_filter_get_rx_ids(struct efx_nic *efx,
 	return count;
 }
 
+static int efx_debugfs_read_filter_list(struct seq_file *file, void *data)
+{
+	struct efx_mcdi_filter_table *table;
+	struct efx_nic *efx = data;
+	int i;
+
+	down_read(&efx->filter_sem);
+	table = efx->filter_state;
+	if (!table || !table->entry) {
+		up_read(&efx->filter_sem);
+		return -ENETDOWN;
+	}
+
+	/* deliberately don't lock the table->lock, so that we can
+	 * still dump the table even if we hang mid-operation.
+	 */
+	for (i = 0; i < EFX_MCDI_FILTER_TBL_ROWS; ++i) {
+		struct efx_filter_spec *spec =
+			efx_mcdi_filter_entry_spec(table, i);
+		char filter[256];
+
+		if (spec) {
+			efx_debugfs_print_filter(filter, sizeof(filter), spec);
+
+			seq_printf(file, "%d[%#04llx],%#x = %s\n",
+				   i, table->entry[i].handle & 0xffff,
+				   efx_mcdi_filter_entry_flags(table, i),
+				   filter);
+		}
+	}
+
+	up_read(&efx->filter_sem);
+	return 0;
+}
+EFX_DEBUGFS_RAW_PARAMETER(efx_debugfs_read_filter_list);
+
 static int efx_mcdi_filter_match_flags_from_mcdi(bool encap, u32 mcdi_flags)
 {
 	int match_flags = 0;
@@ -1360,6 +1397,8 @@ int efx_mcdi_filter_table_probe(struct efx_nic *efx, bool multicast_chaining)
 			    &table->mc_overflow);
 	debugfs_create_bool("mc_chaining", 0444, table->debug_dir,
 			    &table->mc_chaining);
+	EFX_DEBUGFS_CREATE_RAW("entries", 0444, table->debug_dir, efx,
+			       efx_debugfs_read_filter_list);
 #endif
 
 	efx->filter_state = table;

