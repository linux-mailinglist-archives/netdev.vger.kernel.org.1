Return-Path: <netdev+bounces-56005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C6D80D390
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2A41F21835
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6E54D59C;
	Mon, 11 Dec 2023 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SR4WmBfG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9650BD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:19:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkhExCiIDNiiByCQDQ7qG3ggtUP9it6LtwqhaOZSK3JIndz/eJgRQtSyzN/4ayRpDyfr77y6qKFFCouOlMuedCGMWsiMvRpYwx4dBBZ481pd3aBVH8QmIv1jaCDb1FjUCmn04ArJvxnKklxSLD3KvSib0t//rH88E3xGv84IPH6d8irn8FmSlVfpd4NoM/t1a2KwrtmCzjEsqI0IQhkrHwpXdCwU3s29Dt+pBudjTdkYLWe8EJdMJ/9NF4OxnfjOdGsdRSR/Z0HRjJp859yQFHyRfKYqE4WvJcTZK6RqXIsk7DT0yUmsCrk2ZYtv6ynpYfiIe7yAroMcLPxJ0AjcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3QUNy3zqCecER5PbAHdTyN7lwhF5kxzOdi/OQMklwM=;
 b=ftWOWq2yXOY1ZmqPtzPGiw3TdXSRZk8xHtP1KtMOAGc+K7n+yYAdSoBZXo0MlG+bPByhTL+1JS5ZQreHjMaL6ZP+kYiJhXjMAVJcxG2RPRSlhom6cx5i7zLM0fqdQAD/3VbOVY8J1Lxs134DnGgEnFwLsjIzuzSEt6SSCUIkj4C5fRwavi2Hb8AxqtmTI9hiAOi3dVwIw2wNql+b/Vpw4bsehm9L6ERi+ImoGLfLmFupOupNyZsYVUkJuPFnVu6jWXwFg95lC24UPuMzJ5cqPPo1/fQQPaQfQcM6kzbMT6oo4pfNLajzBxrbnmEuTC6BQLxmDiKje7oo0ujxiqbJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3QUNy3zqCecER5PbAHdTyN7lwhF5kxzOdi/OQMklwM=;
 b=SR4WmBfGoJg2oZ5Dm7DhW0dVayjleuhXYRlYsz8vLoW656OlRkOA7t+ROiaOwJstZTbS3bhbbSa38GYyESV+FEi5iC6PQ2UEySXRJqk4llaDs/5IJHLLluHfSFXvjPPIcYXsSQCfl3gPZuxZ0wYdev4T2ry67oK5Ok8K4Ran+Is=
Received: from BLAPR03CA0125.namprd03.prod.outlook.com (2603:10b6:208:32e::10)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:19:46 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::12) by BLAPR03CA0125.outlook.office365.com
 (2603:10b6:208:32e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 17:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 17:19:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 11:19:45 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 11 Dec 2023 11:19:44 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: [PATCH net-next 5/7] sfc: add debugfs nodes for loopback mode
Date: Mon, 11 Dec 2023 17:18:30 +0000
Message-ID: <97029c69a149de5bd6ba6e70c6de1e04bcdc6692.1702314695.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c9310e-0f5b-43bf-f0c6-08dbfa6d5f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LDnEyIrP1x8w1ZtIdiQHVYQNz8SJMtfTKA8H+wQ1BRpP+9WihjXp5ACxM2+6ccFGJxlWaW4gq23uVZ5CV90VLMXdlziFEl+1xVfZaFymzIVzn+uJU5gdDxm0jvIHW4n+PEtdPr931BhxesUKzfQeof6bzrMUmTsOXephmg2pRsw0RHDSpF0bYxCqolB311KcMYZ89UIwjhxaWt62tEnEzh/hcjoKAfKDSavW+XWgr+rYNtbDdBXZQuH2w6X6oSrenAeXv7hzIzYYS9XB8QGBCimwK26HITtZUJShH4wbJ2/UM7NQpjneeeiRUVZq+9TRkk0hhvdJCrszQXDD0XEB34CkGfwVyX/vQGkiNLKgNc5itpXi9w/hLGsAPLMUr6ADuWK1OSIeyx4KUXqbHmWx8FEbQE1XdZ3mA7qVujVWOW20CiAgLJzy2G9jDK8EqBI6GpXftdTVsOpBPuLCPc//evIFphsNVy3tLtKxmvY7vxwZQfe998QsVa+R2cKuFuSo5x72V6MHE1bfAhRuzqki4f4ZkLQQNsTBmfqUUTBzJCQkJQtGY3o/WfxcA3/KhLSg8IhJQXCw2E+EHX575It90mWMR7JzJSXOlXEckXEvOWcqULO6VApK0a/KC6gr1oG6IBD/CfqCWI3lzBG8ONnr7Rq/usR4bFd2TBE0hiwxA4aNpkLxAaBDRCBuVZk0LVbUOGe8Dzubr39ObmmxS9kilhJo0bFGwLUZmRvN9A0nuBHPQ7PsxLpeMvs+yzwr+zdnyAzzTQYFqZDAgoGYEYi4aw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(47076005)(26005)(478600001)(6666004)(9686003)(81166007)(82740400003)(36756003)(55446002)(86362001)(356005)(2906002)(41300700001)(70586007)(70206006)(5660300002)(426003)(336012)(36860700001)(2876002)(110136005)(316002)(8676002)(8936002)(54906003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:19:45.7682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c9310e-0f5b-43bf-f0c6-08dbfa6d5f2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295

From: Edward Cree <ecree.xilinx@gmail.com>

'loopback_mode' shows the currently selected mode, while 'loopback_modes'
 is a bitmask of modes supported by the NIC+FW.

Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/debugfs.c    | 7 +++++++
 drivers/net/ethernet/sfc/net_driver.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/debugfs.c b/drivers/net/ethernet/sfc/debugfs.c
index 8ee6e401ea44..549ff1ee273e 100644
--- a/drivers/net/ethernet/sfc/debugfs.c
+++ b/drivers/net/ethernet/sfc/debugfs.c
@@ -326,6 +326,13 @@ static void efx_init_debugfs_nic_files(struct efx_nic *efx)
 	efx->debug_interrupt_mode.value = &efx->interrupt_mode;
 	efx_debugfs_create_enum("interrupt_mode", 0444, efx->debug_dir,
 				&efx->debug_interrupt_mode);
+	EFX_DEBUGFS_EFX(x64, loopback_modes);
+	efx->debug_loopback_mode.max = efx_loopback_mode_max;
+	efx->debug_loopback_mode.names = efx_loopback_mode_names;
+	efx->debug_loopback_mode.vlen = sizeof(efx->loopback_mode);
+	efx->debug_loopback_mode.value = &efx->loopback_mode;
+	efx_debugfs_create_enum("loopback_mode", 0444, efx->debug_dir,
+				&efx->debug_loopback_mode);
 }
 
 /**
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index feb87979059c..e3605c361117 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1164,6 +1164,8 @@ struct efx_nic {
 	struct dentry *debug_symlink;
 	/** @debug_interrupt_mode: debugfs details for printing @interrupt_mode */
 	struct efx_debugfs_enum_data debug_interrupt_mode;
+	/** @debug_loopback_mode: debugfs details for printing @loopback_mode */
+	struct efx_debugfs_enum_data debug_loopback_mode;
 	/** @debugfs_symlink_mutex: protects debugfs @debug_symlink */
 	struct mutex debugfs_symlink_mutex;
 #endif

