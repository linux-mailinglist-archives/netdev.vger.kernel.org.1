Return-Path: <netdev+bounces-27718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFDD77CFC3
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877161C20D85
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA09156E5;
	Tue, 15 Aug 2023 15:58:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E90156E4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:58:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42531BD4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvatVkl5f3tGgqjJO5xEmXtdt+Xx09s/OhkGzQlj0tdX2wsnYoWTVMzOjFEJz1k+M1/WAXS0tTi4R5b7UlqONFi4QPPO/qe6mXUwLUQBDt3lfRW0uUYvrY5swiFz0QXMMShLYG/Ox8zX2rqZxrIDFHjZozywViVos0uFChyL/NgJsXD63zTNBbYpwXb5Nn6HsOxynfd1XWbJ79K2pHjDwjQB4xiQVQ/HLrAleOnjA8n5JpJgh6DVZrd1dhJux6bNsbco+KZ/gPU3pWFz+pv7DHVVhOfNHi0WKwa7aGiG/4w/ASSTGAiWQ4r0Yr2CIS/HQYHCPKEz5Q9iZkcgoLr1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79BFSJlokQtPOfsbenkcjeU9SGdBeUendqkpKkSAxy4=;
 b=UkVBYI+yPnB13+9Vmvp+NZ66FxwvHg0xHs3rD8pIZjCok9QnjitR0Riyw9RaZcEozU8gxEvTBg81CXrv/QdzA7PwtiLaCdVhb3BskWJ2O+Y4gKLar4FUkZH61xyyP3etojFhTCtHAi6bl5FTlFijjfyLUmZITM5LYlx4gSfgppWw8hKWGLZJTQRHnVKKltuAYuBS0l62qJDzo/10XnTFx3vP7XATZBRW8L5Z/K+al34eQEapM8ZcES4PEvrv/nfZyuIoGZCJbC+0dPfguyZNERDRXPmzKk/i7T1TgjS9N/ylLwrhXzY7BfQMrAJjxlwaIKxMLDQY/DRWnYKpvLwp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79BFSJlokQtPOfsbenkcjeU9SGdBeUendqkpKkSAxy4=;
 b=ihdQBeHefwEpJKdVhp30Y1aq/MWk6Bjr9Ynu9jMrUFGn6FKPZe07BBgzd46pDe/i4v444GfKUz226+lRTXF33MYijWTJGXGkvfTn9YtiqDW4UElJcX/Bas7gQ4vZS1xWvUlWBj5hdGr5gn1gAMKZ0pUvdHBFuABivjrhcAC86ZA=
Received: from CYXPR03CA0090.namprd03.prod.outlook.com (2603:10b6:930:d3::26)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:57:59 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::74) by CYXPR03CA0090.outlook.office365.com
 (2603:10b6:930:d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 15:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 15:57:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 10:57:58 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 15 Aug 2023 10:57:57 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>
Subject: [PATCH net 2/2] sfc: don't fail probe if MAE/TC setup fails
Date: Tue, 15 Aug 2023 16:57:28 +0100
Message-ID: <aa7f589dd6028bd1ad49f0a85f37ab33c09b2b45.1692114888.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1692114888.git.ecree.xilinx@gmail.com>
References: <cover.1692114888.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea36413-26e9-48c4-0db2-08db9da86630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sCx21tmKtQvehZJhhYoLshaFQbP4n3MRMFV751ZpdKNGjxJcJ7zxl2ZCkttB1AMuLb2x54nRNh7b30d4AlZoo7I/Kwv5s3EFli6LCkYzmeLym7kkIR4NIISyMhUGKmAi2By9PAx6C+Q1j7ul7cS7P4QDspmMralUYxogUwCMU9Aa4ojC4eEzJL7eLXN8Fl7FaFtSeKNdBLl+c2t5XV3YSzcafg/XBRp1Fzbd6CFaAKEOL/op/VW3WmAZJP0+mJu7VmbjOzU3Eir4zUy1vJyy5PyYt2qqnFZO7EeyxZkCOCPmcwsvYOZHpGn3Lfq67L6KVcrdmC2vKsDtTOYN40SkE8Fwb9hEJd0JCyxJCqe4M4mv3cYzc/v8pCrB3Q4Oaw8vn4RqyTrb1Ozz2Her/wJfoe2Q0dRjHv3PyijN6RIGCr/4Kta3JdALGh0EhBc7d+Oj1VBb/58TXLEKflJlEzpZq5LE2KynOOP6kJsx3vqJLUeJMW0qpDoaw5fmkjstCK8IlJEFuMkQDsLtZbmDokH86/tDIfQvfPv8dQjd+i7PqBdcvTz3BleuYGP/anG9TDKZ5bmlbYYOsAOa6NoqMkU9Z+OsybWRJr3fqJsm9bpdJejXBjWz2LHpw67w/w8kVUcHAq3BO751YRV2VT4jWsxF3K9QoLNxKhgCF1/B9UokSwMVT7NOdWd/K12ZdGm7vUK2GE9amP6VGwT/fOGk8GlxIXH51dI3wf1fBcSLPoWHntNcJAgS4kBg4xNivXJPfBT5lrdj6Tuic/p8g/pr8AR3tQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(9686003)(4326008)(86362001)(4744005)(36756003)(2876002)(2906002)(316002)(336012)(8676002)(82740400003)(81166007)(47076005)(36860700001)(26005)(426003)(83380400001)(478600001)(40460700003)(356005)(40480700001)(6666004)(5660300002)(110136005)(55446002)(54906003)(8936002)(41300700001)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:57:59.6298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea36413-26e9-48c4-0db2-08db9da86630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Existing comment in the source explains why we don't want efx_init_tc()
 failure to be fatal.  Cited commit erroneously consolidated failure
 paths causing the probe to be failed in this case.

Fixes: 7e056e2360d9 ("sfc: obtain device mac address based on firmware handle for ef100")
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef100_nic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 7adde9639c8a..35d8e9811998 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -1194,7 +1194,7 @@ int ef100_probe_netdev_pf(struct efx_nic *efx)
 		net_dev->features |= NETIF_F_HW_TC;
 		efx->fixed_features |= NETIF_F_HW_TC;
 	}
-	return rc;
+	return 0;
 }
 
 int ef100_probe_vf(struct efx_nic *efx)

