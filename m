Return-Path: <netdev+bounces-47432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D77EA2DF
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 19:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB03E1F22348
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED5521374;
	Mon, 13 Nov 2023 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pu2Yodes"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC972374B
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 18:33:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503C7D7A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 10:33:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSFsGGHRuFat4wT+fQEimO1Ek2gCvVXzx7ImRt+0iTZcHkeNz97koaVUk+p52g3Ya3hYZixhyjC+7WnqISIFivrmZbj9PK3hKaeTG5BkNRIFxtflw6nCPfi4CiL3aeT/qMgN3QaKDnKg4Aos0jejC/YTEKDWlHFvVd8VdIWOc5iHKKxOVKXJJ1FykwhQGScEb8EvSQFGnxcvbQzmaH+mHRlR8w3VVj4y3BJHH15XIIdPOHKWxKMi++5PNKQkKdN4ZGp/3yra3lQ8DGlEZ7YMaRVCSH+mQVttDVnPcLnkUkx6asIYVjO+e79fyEczgh8a+SBaoBuBfOHJjLJzK2liqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssQ9ZNLufQjJXyw32svVuh3pnZ2jec30S753Ke7HeOM=;
 b=N5vjhSGwbrstUKOs6E4CWZhL2w/0Z1Db0hyC54yia4u6IqPTFPUayMde4Vpy4NG2IvxItvONPDE8i4kYpg6fispD+clkd9zEMKO0/ZacRgLcFu3VTl+SYBRwmVwv0DQ1MO98j5c1GTFfn40+8upP72mi9tiJDqhmWJ7TMg1uPEajoZu1msfmmz+YMuDDQkDbcRBUFa0/AFJ9LAjkUvjr2jAROYyTWaHtsSDh1qrhlbrEkif0FKl/RNsHjpLKrA23o8kfmbyhxFNOPmGVtlPS6vOS9CZ+yBBkllRPBlK3Za/N8jGBIXnLKS/y1SktCNdLZdJDQRrr6m+6WWGWYZNNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssQ9ZNLufQjJXyw32svVuh3pnZ2jec30S753Ke7HeOM=;
 b=pu2Yodes90DKHZJAO6YwY3tJ9H2ghbZGTil78QNzDf7mwHQtaRvc3GFWCD561UKFRukDRKeNVSr4su08L6S3bw8xCU5/91/nqHPWPFUe0+n9pv4TEdyz/Pk+5MUToyu5FqqRbkn0FXik7Ux4lJN3++tOVAJgkpprf+XrAme9ed8=
Received: from CH0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:610:119::26)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 18:33:23 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:610:119:cafe::e5) by CH0PR03CA0384.outlook.office365.com
 (2603:10b6:610:119::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Mon, 13 Nov 2023 18:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Mon, 13 Nov 2023 18:33:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 12:33:20 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <drivers@pensando.io>, <joao.m.martins@oracle.com>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net v2 0/2] pds_core: fix irq index bug and compiler warnings
Date: Mon, 13 Nov 2023 10:32:55 -0800
Message-ID: <20231113183257.71110-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: f19cf586-5c3f-4270-e57d-08dbe477043c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JLCAPIGjTaup1mjImTBoINkQnlL9uGMv+ioDNO77iA0406OGbC9y2X8/JGwADdU3b6QRrYjKNllbsiC9FMOQvFr7zIQu1XPBfSXANfyF2iHnDxm5AasbH2/Jl8zeK1thVnCrkKd9BLj7LFof0c/WfcfwFUKyXGHSyphbSIAiLw6S/SM2Mjmlj9yUEbIHR0t+1TguSzNn+id0D3+y7R4UPkoa8Zrd7Sl/Bm6we00WuD8JlVAWMs0Q2IRF+QdQ4YATVt9FVpeNYf2957FJoegUq4RBa+Bfjic4EW9+eZGVKrpLIxO5nCyeWx4q00MTOYfPKJSK1EWpFLIAUXyaG9972U+EpTbLHpB+AJFBmhHtQM/wAaN+D8Br/d9B6Ap4dBdn101Hb1MkGfYrhf3/Del2yH3Cubzqts4LWS64AC2MdbTd896DyLPeqwopOCtSfKaY1HWkxwcq29ZZNCGS1mjMi5c0B/9LM065pGbPfjl+VNTXVMM24fXSYJmjmv0gxmHbf7ngwqLRyoIHm+uVod7IPEDuWw3LtUIl2f9EJkK9VM3QqixDTPeromFz0XJA7nddy6manaPXnluuA0minRUEzHJzrq1ctmRdJ0houXWeQ4el1AmmBDPKkzabM13TFqhNnuV2m2RlAgmLOBUdywkm7biRb6qo4mGLDIikXvhaPRk/oYDOuNCbULxoHs3b4aoIDSvtD+O2huOmvMyBOJ3bYN/0ByoMWSQpvBG8WXu4F2ZHrH9PWKG4cvRp/biZYG3n1Dpw3SmJirG9aF5QUBupST7iu1LSb+ysOba6e/SoNaGRbDzMS0ttR3bP4r2eLY69
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(54906003)(70586007)(70206006)(110136005)(316002)(81166007)(82740400003)(356005)(36756003)(86362001)(83380400001)(26005)(426003)(336012)(1076003)(6666004)(2616005)(36860700001)(4744005)(2906002)(478600001)(16526019)(44832011)(5660300002)(47076005)(41300700001)(8676002)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 18:33:22.4053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f19cf586-5c3f-4270-e57d-08dbe477043c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444

The first patch fixes a bug in our interrupt masking where we used the
wrong index.  The second patch addresses a couple of kernel test robot
string truncation warnings.

v2: added Fixes tags to commit messages and more detail to first commit msg

Shannon Nelson (2):
  pds_core: use correct index to mask irq
  pds_core: fix up some format-truncation complaints

 drivers/net/ethernet/amd/pds_core/adminq.c  | 2 +-
 drivers/net/ethernet/amd/pds_core/core.h    | 2 +-
 drivers/net/ethernet/amd/pds_core/dev.c     | 8 ++++++--
 drivers/net/ethernet/amd/pds_core/devlink.c | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.17.1


