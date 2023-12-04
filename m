Return-Path: <netdev+bounces-53669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBC38040C8
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2CE2812EC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48CC381C9;
	Mon,  4 Dec 2023 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ueppCu+k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB40B9
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 13:10:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFKX2Z9KJGFgHSGub7DoUVvajPyhmbs8uqbu4S6TH1gqw3fo8TUqnqayO8T5byKEV1RZy7V5gKWUOPN3pX8E1U1J+pg/d7KpQ17zKKV4pdB1XVhdpQD5sHXEjbFwRua5JU/RF84sx2b9XmeXT5tYYO5UheLD2emRloSoG/qifq5ddI3I6fm5sPktjuPrbqIpWXnE3WTRwpMGaio5fe/V0tJ4hdQEaTlw6J6aZ6Qe4wU1nSWREtLtpCf8FfJqhwb042xooUqfjgjfPRQ131IYP6LGwCRIa8UAWx8XfYQYfPVajhglk2EF6CBWfX38AZOEK4sJLUbf4OlSRlvUxyPrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u8m/0BB0jCYzPpFvhhJsS0D3vXyQvcwpz+q8fPzR4Y=;
 b=HkUFuX1utn+5EjGzODhGjlcHSCHcp+X5cS+bflL4UKt+3vLB9cQJGdVKgQvPNfJUTEzOtIj7to0jwk22yCOcfUOqY9/saCZ1GgpuPpErFO/nN7hHvleI9pNdlW3kCsWHVuzbzWyi/vTmq7xSxXP1QIIg7pGgir1+gzOrxiG4095st/KT6TZCT28B2msbaLVvKk51CpnWYoK9tgc+3TxAi4yCcRDqFWMVp93oZbwWqEmdYYuTOb28k2+mFWLhBrNthKoVPMks850OHkSAZy7d+B7Z9t5G85ikgL5gsqEMd4dFkSOj1BRRajHGnS0aw3kHPRAMObGu8IwvLMD1mmMiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u8m/0BB0jCYzPpFvhhJsS0D3vXyQvcwpz+q8fPzR4Y=;
 b=ueppCu+k7fEDFf4QLCas86y8vJqRDJGHLCcibqX7Jkb6tpOLPY2u7qkGMz743T8IFmcL1hWyX0RNu4dum1Wb3Lmg5K6ZKnlTWg5p7C/jMgd6GrJrOr/9tuR978vgqcVih9KOMbPXnfAaU/D/oW50zmMAfLPZp7FXjWDEMHUEKJ8=
Received: from SJ0PR03CA0383.namprd03.prod.outlook.com (2603:10b6:a03:3a1::28)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:10:06 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::bd) by SJ0PR03CA0383.outlook.office365.com
 (2603:10b6:a03:3a1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 21:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 21:10:06 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 15:10:03 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <f.fainelli@gmail.com>, <brett.creeley@amd.com>, <drivers@pensando.io>,
	Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 5/5] ionic: Re-arrange ionic_intr_info struct for cache perf
Date: Mon, 4 Dec 2023 13:09:36 -0800
Message-ID: <20231204210936.16587-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204210936.16587-1-shannon.nelson@amd.com>
References: <20231204210936.16587-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MW3PR12MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b7ae6a-a1ba-46f1-ddc5-08dbf50d63fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JJHFlc3nYH1uxPC7oU4qo1ISjmWERXUmxhrZNRDAvsIh2mFZy6mrq6UMmpwDhq1sBVg29fBCkemdk4jdrTdHLy4JGgwYJb7A2XilhrgYP/E9UyBfcbnUWIy1nGX9PxnMfHWHsCwC98Dj68oMkVdXopGdFDrjspFwuHvp2OMI57y8yspw151FSNnkN0ITJ+pX4apb2GNSE2W/+d/ZMQ24iYojyHwJTCpUX0Qt+s7CxhYXL5JzLuxliLBIkH/JgxmJKxVlEh64f3HlXOzX1dehAUKZRucXlbnhqAsvrhM8JyP2tPGjIiZPadDmQ6L0yn0DnnuIDUkFo0PyVn9atJWpB77nfJfnXXyILHOEs/jtyEb3J5PvLN0pVs93uVHJJdAvgQve4li76Q+bDzFnhzzXur4HgyvwDUYVTsyCm7c6N4FbLI5tOZVrMpvBlGAPRvrbIuKGHnkqm/OclY6ZJaOK5zjXGn8if2lNBXXZc1rDwbzs3tOWBKlSUlDSxWlKQcTDWpc9a/dk3stuS/BTuNA+WcDLtlZSeBrnhKY1XjiVTnzVmijiwqQwkygziVHrOqK1FIRkWoGXadiYCP3P+9BLB0nBZZ+0vyta2wOvo7rmsu4zwpFjtbaxxfkj4qvx4Igj3WXkqOMCakNVVgOFoNars6A7FSaQiHgmSsJ3zfmoFBAUhthNk7ysDPCZEC9gQhqsYlmZWJLAQ7+J4d0wD+VsKiaKxbD0rLAShFjdbks51+/rcte2uVG4LJ5ZgGW0tinhI6FmNMp8FS9CkJGPifxQGAzqFPtdu+B8a4VZx4X5xMs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(54906003)(316002)(4326008)(86362001)(8936002)(8676002)(44832011)(70586007)(478600001)(110136005)(70206006)(41300700001)(36756003)(2906002)(5660300002)(36860700001)(81166007)(47076005)(356005)(1076003)(16526019)(2616005)(26005)(6666004)(83380400001)(82740400003)(426003)(336012)(40480700001)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:10:06.1922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b7ae6a-a1ba-46f1-ddc5-08dbf50d63fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441

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


Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 19edcb42d9fd..cee4e5c3d09a 100644
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


