Return-Path: <netdev+bounces-52738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31BF7FFFE0
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0EF1F20F75
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFD717CE;
	Fri,  1 Dec 2023 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lS1dUFIk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA610E2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:05:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftvSq0AzGmLbz55kCXa0+EyOgtEKpTQL7xzUefjPx4DmGgnEfpC60qDL4n+XB2Ocjkqu4Xnw1b98f35c0x3ZcnO9T2PaDPg+P+Y+ii4HrQU3iWfoFEfHNaVpTnckGmepbdNOYYQk1wz+6RMrc6oS2EOmzjaPFgaBkZHGvyTkLMumdMUGAykJVc8F05d0I87QHsiCyxhtox1TrVVNYZV8e0dip67k/mNHbPTEGvZH/d2Jeo8YNenowMt/jCnNzgZLqlMQF+viArQet2WlDgHC06lAHiBldsxBcRKD1d/knSnLTR7ZdQ+0vfDURdHnQztD+OtOvIrH68gAZjbEDIgzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkcKsxCc0JTPWqNGg0LnFu79R1SJy4BhB5sjASXe8vw=;
 b=N5UaTlLdVJYoc51HLE7XlzbuyzMJoxU288FbLSRaRGEgAwVO15vEdGUiTlw8J9bJjn6hucDXpnYvvAUheKn5yLRvfSRi50qBSsdwsxik51vHlhEky77h3H2/qhVugm0aCOtFUg6DAue0l9mCfqv9jQDgtEHM9qLD3XFSYrHmR+rknG8eJTQeXI8bC0s5q/B94bFlUG+Zjo9OJgA+GBcjNPY2KoKNyleLz1LCfRLKDngw4Pyh+1Q3m1u+uOvVQZEfzznPpeS6G+WcuWCzqBouaa45SCb/OgcJINGbmMvN9lXXWqat372NianSSVy0ARhGA+74hlmhzYMstj9GZmNfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkcKsxCc0JTPWqNGg0LnFu79R1SJy4BhB5sjASXe8vw=;
 b=lS1dUFIkXZVc7rGE3iR2Wb14yWncoR3rETk0Y+QrBg1gjx28yf03ZQLR0OUgk+J6KZUsX6cqf2FhlMaVl6Z4++NE4rUkIfZzSyS7/yKPIwrZdqTwCC2u2DnwtLiHgtwvgl0cI1cwRdeYiW7ZWFXO38bo1GILWUw908XFhKADtnQ=
Received: from CY5P221CA0094.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::19) by
 MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26; Fri, 1 Dec
 2023 00:05:46 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::4) by CY5P221CA0094.outlook.office365.com
 (2603:10b6:930:9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:05:45 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:05:44 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 7/7] ionic: Re-arrange ionic_intr_info struct for cache perf
Date: Thu, 30 Nov 2023 16:05:19 -0800
Message-ID: <20231201000519.13363-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231201000519.13363-1-shannon.nelson@amd.com>
References: <20231201000519.13363-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: e46adb45-75ce-4123-300a-08dbf2014476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kqWsHKMP4469wQ3nnryrjcZ2ReqGcne3JxI7l/POf38KfFN3/kU4DAybGqiFApQ7oEDNcKGflrXpLk2tQ/n2cYR9omelVXrs6BhbPoz/78zGI7W37Z+mlSJTEh4rtNYHGOP2iEaVASMXR23g3GDDQO3nBxGMD3uCKsGszzUb35l9aXsjLQiQmna2Sr8DIfJmxox5Fb2g0dnjtqpXf4/IO5e7VMkoRoktTRHX21oV4izIFV/ejYLXtq1rTvKj+LdNhjO/gj8XEwtTv7Rl0gJtstZm1sCUoKmsYWoU7Zvi+htDHE9tJ6Mt0aGIvT6PGPDiFjwMKsU8S+bxxo6sm7Pw/Uuy1jQAXzkV36RdggO1WUaWAodVM2G/3UOBUi/k3FyIUZIP3u4Zvm/x7/ERKwtzAONo2jaugQ7Qxu/gelmHYa2mjMrEPtKhsgrOmWDPd/tWS3qM9eRt6w99fYGj3FvIXkDAkajT+j/kqaYXj3cnE6DOu+mDKsiOy+FEw3HSt/tbnocy6n3oU2HegAD4VpZqkQU6+sTF/POhKVr0y6Dpe+DhoPCuNn4UnFX7/QDDPxwdPbnODUw4eSRNGzVLIG/nONFDiIUUSzmZpmIQUo9Na2CpuHKRIYobxKQ+bA1nxuFcrUL2bSoALLyMhdPhrsFl9qHaRA1oBnACSmnO+oz2gVXEhXVIokZPqEcmKCfH6SVr3ggXTfh0a77VvIpsbGLCBcsIN1LCj9YG0QHl6FxN6/9xl5vwZKsmOracNbUeroTMcm014QslRbN0Wj02pntg2Y5KDa1xjYgLZBqlAXYfZHQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(26005)(336012)(83380400001)(6666004)(36860700001)(2616005)(47076005)(426003)(16526019)(4326008)(44832011)(8676002)(8936002)(41300700001)(2906002)(5660300002)(110136005)(478600001)(316002)(70206006)(70586007)(86362001)(54906003)(36756003)(81166007)(82740400003)(356005)(1076003)(40480700001)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:05:45.9448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e46adb45-75ce-4123-300a-08dbf2014476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

From: Brett Creeley <brett.creeley@amd.com>

dim_coal_hw is accessed in the hotpath along with other values
from the first cacheline of ionic_intr_info. So, re-arrange
the structure so the hot path variables are on the first
cacheline.

Before:

struct ionic_intr_info {
	char                       name[32];             /*     0    32 */
	unsigned int               index;                /*    32     4 */
	unsigned int               vector;               /*    36     4 */
	u64                        rearm_count;          /*    40     8 */
	unsigned int               cpu;                  /*    48     4 */

	/* XXX 4 bytes hole, try to pack */

	cpumask_t                  affinity_mask;        /*    56  1024 */
	/* --- cacheline 16 boundary (1024 bytes) was 56 bytes ago --- */
	u32                        dim_coal_hw;          /*  1080     4 */

	/* size: 1088, cachelines: 17, members: 7 */
	/* sum members: 1080, holes: 1, sum holes: 4 */
	/* padding: 4 */
};

After:

struct ionic_intr_info {
	char                       name[32];             /*     0    32 */
	u64                        rearm_count;          /*    32     8 */
	unsigned int               index;                /*    40     4 */
	unsigned int               vector;               /*    44     4 */
	unsigned int               cpu;                  /*    48     4 */
	u32                        dim_coal_hw;          /*    52     4 */
	cpumask_t                  affinity_mask;        /*    56  1024 */

	/* size: 1080, cachelines: 17, members: 7 */
	/* last cacheline: 56 bytes */
};


Fixes: 04a834592bf5 ("ionic: dynamic interrupt moderation")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 745a3292be92..c47c059465ae 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -269,12 +269,12 @@ struct ionic_queue {
 
 struct ionic_intr_info {
 	char name[IONIC_INTR_NAME_MAX_SZ];
+	u64 rearm_count;
 	unsigned int index;
 	unsigned int vector;
-	u64 rearm_count;
 	unsigned int cpu;
-	cpumask_t affinity_mask;
 	u32 dim_coal_hw;
+	cpumask_t affinity_mask;
 };
 
 struct ionic_cq {
-- 
2.17.1


