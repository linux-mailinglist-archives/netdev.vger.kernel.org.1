Return-Path: <netdev+bounces-56009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5900480D395
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CBC281C62
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27E4EB33;
	Mon, 11 Dec 2023 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GH5davCd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05167D9
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:19:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acY56NQ6JjSbeHDcK9WrVLqnPc30Q//YC7RJ0e5PcIDphEdUlSAHvllBSeluiyL7+f7QMYER4elW0/NvoTTsizUQJ7Lcp5Mts5YnZ97fDx01Go9oM6AQpxpLpVaxDnxADwTPf18IIU+AKQK/o9VeFHxQGRRrug9zoFES9va00vMayJwq9F/ii1KSh9mmRKOEYltnV5EHkGI/E0eHC82H+fRgJlN2rb1V7H4aUbOOzrTVKfN8ZaJ8eqHfIR135UtXFKWoxOZTHQCjvTbj8dgsANCL76+vvQ6GeK/r0lb9+hO5ZpgiHCoiIY9Gj2Omjc/dO9reRNozi1Q3xywluML6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyORSVF8tbgPaEjDtp5KFWSGtEv1YMdooBwAQ43NxCc=;
 b=fXrHlyvteL1I6HVf1XIYuNWvcRHX74coSoztZF2yAUX8rRnmGWDRYFnxAEQ4r7hW90CtWf92LBzYHM7j+i7F4l6DsuOw8+VwiQv1HydxMh4BaHMhWCI7uPXROp3aozAamUfQsdxtzB6UzhaHY5vqa/R73+2oGUc5a5j5IpTU7E92FxOFiUyhVneLNYnBuSqVzxucnc3TlIwFtadWiCWQycPALuMiikWmNEAHf4YMD6agPRq8mIX+MyU9Teku5UlfTx4tV7eC5Dd7uvFcSCQh77bevZjvoTO+OAklpWq3uDzUyIw9zkaVoqtv5Ai9Nttz9P3YUPR6GtRGhZ6FNXBsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyORSVF8tbgPaEjDtp5KFWSGtEv1YMdooBwAQ43NxCc=;
 b=GH5davCdKTQfqoQtpnhD0Pn7iMM6fm0SLtUG9BCgDlKdp55KCKWRQ2XRvKXOmeesl/bXxJm98WtZnbNZT09EG3UK++i2Mgu0gTQDXzd/UkY3zqyH/CvsZkjJjFfamjXwfDC60UPUiGRy1IsVgHN+J2xuUbDejutdelQii6AEZN8=
Received: from BLAPR03CA0071.namprd03.prod.outlook.com (2603:10b6:208:329::16)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:19:48 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::4a) by BLAPR03CA0071.outlook.office365.com
 (2603:10b6:208:329::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 17:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 17:19:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 11:19:46 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 11 Dec 2023 11:19:45 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: [PATCH net-next 6/7] sfc: add debugfs entries for filter table status
Date: Mon, 11 Dec 2023 17:18:31 +0000
Message-ID: <fc28d967fbffd53f61a1d42332ee7bc64435df7c.1702314695.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1e5893-dd8e-4b11-d81e-08dbfa6d6002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XzGBrZxyU9gvHXWdGTvYEmZzQlaxxGoN/7cF7sulD+kh+Hy0djWwJVJ53MN9VyhXtSYSCUa6nKrkQWI6yWmnl9gwepdkXGcEul+a3ldZr5JRge5ryw95yHK50q+0y+YHCmbEE2hiEMTI65RWx54OlB4ujMJcojdITwxg13iJ8AZVyitumHOyRSmENH8ayQiCD8686NSIHlr9uDrFWpLf7RZCOYgcDqf6e8QtBF0orAavQ7KWZ2xu3tnt7sukQ1l75Ss9euAIf22lJ4dt5XgN7BTljPSyS4RojqP+HyoCKypV5NlvySmG9Gz2dVz/+hggQFnm/6SbTsMqI99tCXcTZ5M2vdwKLxglHLyieu+DxwK9Iv7D/KUq5iaLJBd93+Rlld5KrlsOq77FSWvxCmTGqqoHDKqbkkOAJxigFGo18Q7h8op61ZHrcwYEfl2Pf5awoHfFYgCbAa4Q1hJDhbHAsniwX/3Y6bljgHouQ8Sao+3Y9JWFgYV7OeovtxPby9uwOTdNFW8Ks6qAuXx30iAYkgEmKIoczTKTju3acJLN+EqwdrI+N+73+sF5SbzPWSDmso1ZP0dAIEAG6DlShDeEeV40UxsfVldql83lMXqeToxGE4nPoZiptw5YGrm5gNdpRGDyKY1EpkisenpAiRRGLXypGWUZjvBiycHNjlecdtJZ0F/sVt5UyNNaDeIoRqhJfCzmUJCnHto1xQXGfgedM/EywrE039Bnw37TSjBps5qUTRqUAlpOkcSfn9ifZlG6vALVtvrkQCfXtninqnDuQQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(40480700001)(336012)(26005)(426003)(40460700003)(82740400003)(81166007)(316002)(356005)(55446002)(86362001)(36756003)(47076005)(5660300002)(83380400001)(6666004)(9686003)(36860700001)(70206006)(70586007)(110136005)(8936002)(8676002)(54906003)(4326008)(2876002)(2906002)(41300700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:19:47.1766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1e5893-dd8e-4b11-d81e-08dbfa6d6002
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824

From: Edward Cree <ecree.xilinx@gmail.com>

Filter table management is complicated by the possibility of overflow
 kicking us into a promiscuous fallback for either unicast or multicast.
 Expose the internal flags that drive this.
Since the table state (efx->filter_state) has a separate, shorter
 lifetime than struct efx_nic, put its debugfs nodes in a subdirectory
 (efx->filter_state->debug_dir) so that they can be cleaned up easily
 before the filter_state is freed.

Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/debugfs.h      |  4 ++++
 drivers/net/ethernet/sfc/mcdi_filters.c | 18 ++++++++++++++++++
 drivers/net/ethernet/sfc/mcdi_filters.h |  4 ++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/sfc/debugfs.h b/drivers/net/ethernet/sfc/debugfs.h
index 3e8d2e2b5bad..7a96f3798cbd 100644
--- a/drivers/net/ethernet/sfc/debugfs.h
+++ b/drivers/net/ethernet/sfc/debugfs.h
@@ -39,6 +39,10 @@
  *     index.  (This may differ from both the kernel core TX queue index and
  *     the hardware queue label of the TXQ.)
  *     The directory will contain a symlink to the owning channel.
+ *
+ * * "filters/" (&efx_mcdi_filter_table.debug_dir).
+ *   This contains parameter files for the NIC receive filter table
+ *   (@efx->filter_state).
  */
 
 void efx_fini_debugfs_netdev(struct net_device *net_dev);
diff --git a/drivers/net/ethernet/sfc/mcdi_filters.c b/drivers/net/ethernet/sfc/mcdi_filters.c
index 4ff6586116ee..a4ab45082c8f 100644
--- a/drivers/net/ethernet/sfc/mcdi_filters.c
+++ b/drivers/net/ethernet/sfc/mcdi_filters.c
@@ -1348,6 +1348,20 @@ int efx_mcdi_filter_table_probe(struct efx_nic *efx, bool multicast_chaining)
 	INIT_LIST_HEAD(&table->vlan_list);
 	init_rwsem(&table->lock);
 
+#ifdef CONFIG_DEBUG_FS
+	table->debug_dir = debugfs_create_dir("filters", efx->debug_dir);
+	debugfs_create_bool("uc_promisc", 0444, table->debug_dir,
+			    &table->uc_promisc);
+	debugfs_create_bool("mc_promisc", 0444, table->debug_dir,
+			    &table->mc_promisc);
+	debugfs_create_bool("mc_promisc_last", 0444, table->debug_dir,
+			    &table->mc_promisc_last);
+	debugfs_create_bool("mc_overflow", 0444, table->debug_dir,
+			    &table->mc_overflow);
+	debugfs_create_bool("mc_chaining", 0444, table->debug_dir,
+			    &table->mc_chaining);
+#endif
+
 	efx->filter_state = table;
 
 	return 0;
@@ -1518,6 +1532,10 @@ void efx_mcdi_filter_table_remove(struct efx_nic *efx)
 		return;
 
 	vfree(table->entry);
+#ifdef CONFIG_DEBUG_FS
+	/* Remove debugfs entries pointing into @table */
+	debugfs_remove_recursive(table->debug_dir);
+#endif
 	kfree(table);
 }
 
diff --git a/drivers/net/ethernet/sfc/mcdi_filters.h b/drivers/net/ethernet/sfc/mcdi_filters.h
index c0d6558b9fd2..897843ade3ec 100644
--- a/drivers/net/ethernet/sfc/mcdi_filters.h
+++ b/drivers/net/ethernet/sfc/mcdi_filters.h
@@ -91,6 +91,10 @@ struct efx_mcdi_filter_table {
 	bool vlan_filter;
 	/* Entries on the vlan_list are added/removed under filter_sem */
 	struct list_head vlan_list;
+#ifdef CONFIG_DEBUG_FS
+	/* filter table debugfs directory */
+	struct dentry *debug_dir;
+#endif
 };
 
 int efx_mcdi_filter_table_probe(struct efx_nic *efx, bool multicast_chaining);

