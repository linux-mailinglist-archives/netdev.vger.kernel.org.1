Return-Path: <netdev+bounces-64269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F53831FAF
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632EE2889AA
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BE42E40E;
	Thu, 18 Jan 2024 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q5CH6HxG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7F34CD5
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605927; cv=fail; b=qDLwltKuuD/TyfMIRvAZVFzoHsWQoeo5+4bn5OoXhP3vYsAX/RFDPC/bqCTiWKm2IbZrFGF2objs3t0Gci5r1b8J3mo8lgQCIDUieORrWuyMs9W77uyyJRgQNxqkro9wQX0cEUgXk8rvoUM358+e2bCVzeUBS9mMow67AI5evPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605927; c=relaxed/simple;
	bh=sNszYVzy97tZvq6Lf4y5DUNzPnBJqXe4AyLe/nUH2S0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWLQz04S7v7xK0S64VGi6ryGLS4rRyrZ+nIEqU01f6/rzG9xuP8PXJINcw4mgIYcQLoqejQUSIHU8zt9iOcdRwW3TL326jZJrWE4aSEpgae2s+xteXtDPF7XGPDllUps9pgEJCIgOQ13U8AcVMgKyoqLs0593U5DrvTp5UMigR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q5CH6HxG; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5P2iY0HpLqmuoAy9M22AE0xXP6qWwHD4iLl1UlWyfvXqMgYYl/Rjhm3ss3rLXw3DtHFOdluFAiGWsD+iipQf5I18IftxVrtb/u4I9OZRZ1iUMDfg2Hsk7ot+H5IPt7JGPvMvhcaanbezYRzVB+YeJFqieaeUEyJvllEAC8Hqv3oTosDkTDQAj5ZBn+PLrXM94uqVh1jcW18hqUy+dIvdrxsYrvcFU855SHdwp1hIx4DSHiSsb99fjkf/zwJJw6bxMslPHoxPMfa6oPjEbjpzsjRNu5fpagzlfYNirvD/o7ltyQxsniLdAPCINL6xvm25Qor681Lsm+jecjxpW3Dhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iuqd0UJRY/8Pef92ox+L6iZYimdz3aw3Vpdb8kHYg9I=;
 b=OB74IVxuNEOopEOWcSY7z362ZN/7dZk9gvUYaJm9LhErArNx/Aa0kFo7VNK92w0gAwNW2vPaCjy+h4KUwWCsfqUmo5YSZx1jLTFVRY98E7v9f0rARXmqpCvtWcJBkUWyBnh9wAjtWKQAFq/7F5vmGwKNCbsfyKMpoYlgv5CtcBAXOZA0gmuS0HhKMLjF29WVD01uEQFb9o1+l9rWVO0e4JpUyaMIIeqR5WcxefzPWgOFo6KpdvKExpb+pKY7tXUupxaSAtIu3Q2k7P3OO6vGqiNEU2PUUp9SNLpIH11018RueC7dhaCbsCSmW3zHOWgGJuG7gCIDjayIO6+oZSNHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iuqd0UJRY/8Pef92ox+L6iZYimdz3aw3Vpdb8kHYg9I=;
 b=Q5CH6HxGGBwZntjRW05ZqQwfPCTyLU4zNHFxpk//pC3suRMLP/AeTqEzDT1jLyzIOywv6seRrQ0Gelb9bWBjLdtQTuD4cAw40TNseJAVSw0hnvz82sBmas+boVEmDbAbymciHDgYDuVbTwMvk4ybO3l/zvbJ6u2kZ9WFJHAfMBU=
Received: from DS7PR05CA0094.namprd05.prod.outlook.com (2603:10b6:8:56::11) by
 BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 19:25:22 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::10) by DS7PR05CA0094.outlook.office365.com
 (2603:10b6:8:56::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 19:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:25:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:25:17 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH RFC net-next 1/9] ionic: set adminq irq affinity
Date: Thu, 18 Jan 2024 11:24:52 -0800
Message-ID: <20240118192500.58665-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240118192500.58665-1-shannon.nelson@amd.com>
References: <20240118192500.58665-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac2e847-1160-4e2b-7161-08dc185b36fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+s+Ltrwj4Hq8uVOHTTrpwL6d3X7GE/V9UdU4DmZyG3zU4dKqeC8tbAoCyMoF8V/xyZEfAxzAjEwhiJTPHVd+eetT7FsZvBBPiefM3c8rko+2U98E0I2LnR3NWSNQKiTDGUWImMBB6FpPmooKZtGsg1HYicw+A0Em9WoduCwm6MLwj0XTcGaaEhjoYsuNSCv52qsMqOYu1fCY0U2gZV1BQjlzR1oA4k8j9LK6k/NhwBnQjT/sDgwKA65ZZge6CH0OIJLhoHzN0rFkkQU3b43CFP6B/IZAnIoyZGHah4xSYBYswlGGi/ChIjXRmBBVq7jiEbXPpGH5qvFlQTm9Dj5H9iIVNlkO34sZBmlOeXdkFLz1245TJQSTJuNSvz4zFFtEL+uQQwX1sghnBXoisKXL1ZVEQvUdG3FAXCmxdBFW8t9zqPk6hJ2nxD7vsYtpRupNsXXefCyEWoUBF4Hq06yO3ZjeT1dykDT7Q1ehPTsCJ2gTrcpNYcxN+Gl2N29YtEM05YsCFqGgPW4nU0DXDpxzKrs9ovwicr2QR0N/25S2tdMaboGDWtJZ25YcW6/lJg5RuUhipQ7C1ZZdLIX/8V8AC2iLT6OoLYlpSbVrN850+Gfg53rxQfwaeyCsRkMJzPhcV8oDURx9tYDUIFHGwei5RLOCD56Ity2BucOpIyturbRyYwwAF0P+o7AAVBf5rpDind268cDMF/3uONevFHLrP54Stu3nZ6TPVrtWyva+DFuv1Uqva8x1P3PBF3WyxFfxcohyGFNeKqnMId2co1vvww==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(16526019)(6666004)(8936002)(4326008)(83380400001)(336012)(26005)(8676002)(5660300002)(47076005)(316002)(70586007)(426003)(110136005)(54906003)(70206006)(478600001)(2616005)(44832011)(1076003)(81166007)(356005)(4744005)(82740400003)(41300700001)(2906002)(36756003)(86362001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:25:22.2656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac2e847-1160-4e2b-7161-08dc185b36fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

We claim to have the AdminQ on our irq0 and thus cpu id 0,
but we need to be sure we set the affinity hint to try to
keep it there.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index cf2d5ad7b68c..d92f8734d153 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3391,9 +3391,12 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
 	napi_enable(&qcq->napi);
 
-	if (qcq->flags & IONIC_QCQ_F_INTR)
+	if (qcq->flags & IONIC_QCQ_F_INTR) {
+		irq_set_affinity_hint(qcq->intr.vector,
+				      &qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_CLEAR);
+	}
 
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
-- 
2.17.1


