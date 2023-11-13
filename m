Return-Path: <netdev+bounces-47433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 382C17EA2E0
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 19:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53FD1F2239A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC521A10;
	Mon, 13 Nov 2023 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UapvoUFg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F722F12
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 18:33:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C26D68
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 10:33:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm6Vg9oOgTD7KCZnBBhkq/xXyhqFsUBgwMsnxO27zE2QDMY4FlgFEcff6SnQHCVp7qd3Y91wG5s7XRTSMiAT34KX3PypoD/MRR3/EGahnLZz+2FiviPkwjxFD9DYmisIXbQWQWpTrBLFFAlogHCGxf46fquE0A1dNMLqbhSoJCtC2wK5OlJUIHIz6RN25Pmh+FsRrcgiroDYOKRA4jOjsq+a4QDunRaYRSJu8n8r/LdsyaO6xxloT/NQ9d3WCMvcTjt0hDxwwlTYSakbq2R51u/hRvfDjIrhyQ/heVWTgNlIEL9Mcn2lUCbLMF8hvu9Xzy7F7lPBJW8v6JfeVVp4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0g4V1nheBuF8EXQqiaKcHQ8CS4O/dV02T6pMPddsZY=;
 b=OIybSPSYOX4kB/f3cte4Xy5xhbHo5VgmuMaEZhX6kMGNVlYIGXMSrVoS/pIJsge22yta0/YOdAwf9v5PDwwImoQbEm6hSuuPw5W514MEnMzGDColavzl+JaPAEQgPNqG+xAiKDrFI192oQAjbgpTch7Qhy3VZpCBUlSmsnK6M48JqJKpHrKBx0LgCORpilpSyIxsT1Xiwm1hgH7rEUtrQUwIctFgPZ68Ui0q1zxsV078neGhluncrWWWMC0bETr6/zSVhuwbXNe6YjydSY+ZCp/9an08CVod47WM92wYN4yFoj8wWAI7hZb8OOhgVZYDLhMxnKi/eFVOlPnPa+ZG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0g4V1nheBuF8EXQqiaKcHQ8CS4O/dV02T6pMPddsZY=;
 b=UapvoUFg2AGsrmhiICPUP2ZeFgDDEurO6ofMbh8M/t6eNI6vsq/mIfTBZwSKy2Jb+Lco+qorOHcB6WLt+H1+/Vqb/5hus+jfHMWtYjJu/Sn/KQNNDFGuuc4veW9wmvqSIYlshZ0EP4AbbQNK4S79shk26vqS2xoGpGheAWtU8/Q=
Received: from CH0PR03CA0370.namprd03.prod.outlook.com (2603:10b6:610:119::11)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 18:33:25 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:610:119:cafe::1d) by CH0PR03CA0370.outlook.office365.com
 (2603:10b6:610:119::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Mon, 13 Nov 2023 18:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Mon, 13 Nov 2023 18:33:24 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 12:33:22 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <drivers@pensando.io>, <joao.m.martins@oracle.com>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net v2 2/2] pds_core: fix up some format-truncation complaints
Date: Mon, 13 Nov 2023 10:32:57 -0800
Message-ID: <20231113183257.71110-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231113183257.71110-1-shannon.nelson@amd.com>
References: <20231113183257.71110-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b926f3-44f7-4842-4868-08dbe4770588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5YFG3frrRXErZMzm/XtBGCQZ7+IEq/i9+tF2hVeSvxn/JDM4a1W/y74zlpO99gJLk5/PJIDlEzz6lyAJ6lmvhhfJV/wb8medj9dF38qNMedHx9LdkCpSVCwIiLZGbqtdMyGzTDoQBTlkTIMHWgmvddp1z14HSEU1g+ompuRdVuV/7LEHs4o2iHGfTWRczmYDZEkov9xwtTECpqSn6UEViJVUSI3440MvFKbgqXxa+CJGLedgKbW9bH4s4tuGYskUGeadWs3vOxPPPCv7Qc22qlaVrg+yINDA1BWZV5ItY5zutOvpvVyzjN0BfggK0cSL/Mv/y1Yh6G90P4K1LqstjNefcmzxzS5Hhie5C6QI4u3d/Kp4EeTvHUiBx43XUBMi+g2jlj62Sh+oY1ef53XmnbFmR8FaAAr1YmW1nGoO0jFX78IM4/s+KCsM+bt6pDq21xcxFHLsAk4HnRSEThC7wcQgSouKOzMfXJTj2XPHL3EyvRf2blr979hMYSwXRXtXJ3pms28jX0PGk9XdNNlSFipfsZu4H+yyQWT8uZmPK9v9g1Y7emXc+f/VCup6MiXs2iZEqtr+8mXrSkY9QTnbXDMtjCfPiEgkoWIsJQNEaeR9i/1zSTUE+jf2kKzVPADx+If8XCm0GiZIg5CmdNhbE/yxDbXJFxliWGHQrJtJ0fM6rYDhcixCK5ayWZ6adqGJ/Hv8v3yM+8pze6fz0k2NEleNkEjIUGMdySBF2lrCa1moEGRTEVEqomL0H97uvGvylm21uNg2ty9HishG2KCXJA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(46966006)(40470700004)(36840700001)(44832011)(40460700003)(4326008)(8676002)(8936002)(1076003)(26005)(2906002)(36860700001)(16526019)(5660300002)(2616005)(86362001)(82740400003)(356005)(426003)(336012)(47076005)(966005)(81166007)(6666004)(36756003)(478600001)(41300700001)(83380400001)(40480700001)(316002)(70586007)(70206006)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 18:33:24.5615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b926f3-44f7-4842-4868-08dbe4770588
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851

Our friendly kernel test robot pointed out a couple of potential
string truncation issues.  None of which were we worried about,
but can be relatively easily fixed to quiet the complaints.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310211736.66syyDpp-lkp@intel.com/
Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.h    | 2 +-
 drivers/net/ethernet/amd/pds_core/dev.c     | 8 ++++++--
 drivers/net/ethernet/amd/pds_core/devlink.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index f3a7deda9972..e35d3e7006bf 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -15,7 +15,7 @@
 #define PDSC_DRV_DESCRIPTION	"AMD/Pensando Core Driver"
 
 #define PDSC_WATCHDOG_SECS	5
-#define PDSC_QUEUE_NAME_MAX_SZ  32
+#define PDSC_QUEUE_NAME_MAX_SZ  16
 #define PDSC_ADMINQ_MIN_LENGTH	16	/* must be a power of two */
 #define PDSC_NOTIFYQ_LENGTH	64	/* must be a power of two */
 #define PDSC_TEARDOWN_RECOVERY	false
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 7c1b965d61a9..31940b857e0e 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -261,10 +261,14 @@ static int pdsc_identify(struct pdsc *pdsc)
 	struct pds_core_drv_identity drv = {};
 	size_t sz;
 	int err;
+	int n;
 
 	drv.drv_type = cpu_to_le32(PDS_DRIVER_LINUX);
-	snprintf(drv.driver_ver_str, sizeof(drv.driver_ver_str),
-		 "%s %s", PDS_CORE_DRV_NAME, utsname()->release);
+	/* Catching the return quiets a Wformat-truncation complaint */
+	n = snprintf(drv.driver_ver_str, sizeof(drv.driver_ver_str),
+		     "%s %s", PDS_CORE_DRV_NAME, utsname()->release);
+	if (n > sizeof(drv.driver_ver_str))
+		dev_dbg(pdsc->dev, "release name truncated, don't care\n");
 
 	/* Next let's get some info about the device
 	 * We use the devcmd_lock at this level in order to
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 57f88c8b37de..e9948ea5bbcd 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -104,7 +104,7 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 	struct pds_core_fw_list_info fw_list;
 	struct pdsc *pdsc = devlink_priv(dl);
 	union pds_core_dev_comp comp;
-	char buf[16];
+	char buf[32];
 	int listlen;
 	int err;
 	int i;
-- 
2.17.1


