Return-Path: <netdev+bounces-56049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB27880DA11
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85850281C3D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6752752F8D;
	Mon, 11 Dec 2023 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="azjJ6y0B"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B6CF
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:58:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVVIz63KrcTRsMNejux3wxn598L8VeZgO2fjQ7rXRos6GzYeT9RZKTYOdGWgkyGH+9rO0qcvOCgbCblfyjLoufvBvjx32IgsFJ9zQfNkmlnvFLJGH8K140ADd834hpYph3v3eT4Ea2QjmSjHpZ6t+kd59vUZCvUsgoXPAeCHDxRyvOgmIA95ue9KBZqm6NMkHKnXN0BRPzHY5LmIXM11AvQk+0h8f5qXX66cEIuewSUeHan/+jCglbPUSoqfpwLgvq+AwYRTs+XgvtFj+eQITpiY/LmIAwSxVUBW1OpdIhEXUca8IEEDA6bygPh9o33boy/JH+92fKu80luk0PSjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpLboh9i0uLYXVWYnR43BI0Dx8RP854F+/7D7eVXXi4=;
 b=Ar55TZWT2pfs8JMT+cdRyDzBHpXy1yUEZeFRahNc2MvabnpUlUuaI73d5MWmxi+tFEa/d2pKVpE+LxENNKnhdeolIDciP9WgCquyWhPLuuRPNIz4yPPbLyYmjGzHHfhsHg6eHKVk1z85yAJQe1JhHGsAaJwIO4r7TEraXInwINpBUb8sVHDTE82dFKWqCp+D7y5E7BJF8yNMG1zuDyHeh6LuEY3yAPI9Wcmic9O6PnmARk1jyaJ4aB1HJeNlH+VF4kPwgn42f3wFKpPZORICPUwPAHnWAIv8oEmh/7IeIosHG9EUfs27v0tTSSznhekytV13eftbekIHmO4piGFjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpLboh9i0uLYXVWYnR43BI0Dx8RP854F+/7D7eVXXi4=;
 b=azjJ6y0BPk9le3y2wOkC3Bk3XOHJGEx0Hsxmpt5oep5G/OZB742cLQ5u3PfnzKNQFtnsKkwK9aPHCjKAOa8J6C/irOqlIU+04u5w29kC1rGAL0V8efP1kTTfwXqVaByX1zfVLCAkTPOXZ7xs4NaO0eYijlL4I1USCJv0P1cfz4o=
Received: from CH5P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::6)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 18:58:28 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:1ee:cafe::70) by CH5P222CA0014.outlook.office365.com
 (2603:10b6:610:1ee::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 18:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 18:58:27 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 12:58:24 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 6/8] ionic: use timer_shutdown_sync
Date: Mon, 11 Dec 2023 10:58:02 -0800
Message-ID: <20231211185804.18668-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231211185804.18668-1-shannon.nelson@amd.com>
References: <20231211185804.18668-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c63b68f-ae6f-4460-fa8c-08dbfa7b28ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FelV/ZiPrLPv1DjdDOSmikLUKR3S8wJFMrdcXMF85Otq8ouf716kuRvUzI149YZuE3L5wCFX+Ga+WtXzIRfdc8l9FwHF16xEJQU0mCBU0e39QJ6GiQY31ER/lTaJ8GxPPqVt3ZexVecxu7xHis7hemu8h85k06CFs09se+2upwRS3o7NUPMRqd5wfM11iLB72fspnbHk653ztnOdrX1JsHgpoX1Wyc4KHPlcwtIIXq1yfQX2wktY/yBf3F10BIF1UBUjjFwwbNZFFHOaxqQ6G39qGDzarTABkskLppxvHp6gbgqVrOyDws2uy9yjbDIUazEiW1LB08DDBzv6mTzZjvoBQOMNl25p2+QNrTr5+HYYBZAVplQ1qMHLJypFIpynsQYb0Sv1ytDlXcFP9D50FWFyIa7c4VGqEruWZvo2cUp+UoQYxhCWreXY3+ofSm/LpRl9hKW+/MvHehmrysj7tul3lbjqoq3ZTiUYiBk2i2mVcBE9cL2FXhpKlBTIdJb/Yzxwp47Rue20uoiCqj2qRZczsL2B1trOHWycOqLVdB7bpnBww+hKNuvz7T2lFg6Jv0jzRuvPMPD+YtmRZF2tV5WcsUdepqfBPyI+uB4bwUW0pc0TAUVxd7oPeSIRARCKwuQxqSasn2GtMloeZvWHmF2D5JdvZaFzaRKdMQYOOrGebWE3IMLoHSMelYw5DEg/AV/+ZYzOoQkMJdrrm4EZ5r6Rxati4yOPgF8Lu44fAI6m5RCGtWBYUG+raaClYq4AJAlDPaxupg4epIzJX/CH6Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(2616005)(1076003)(36756003)(36860700001)(6666004)(478600001)(40460700003)(110136005)(316002)(86362001)(54906003)(70586007)(70206006)(8676002)(4326008)(44832011)(81166007)(82740400003)(356005)(47076005)(426003)(8936002)(26005)(336012)(83380400001)(40480700001)(16526019)(4744005)(5660300002)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:58:27.6791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c63b68f-ae6f-4460-fa8c-08dbfa7b28ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110

When stopping the watchdog timer at remove time we should
be using the new timer_shutdown_sync to assure the timer
doesn't ever get rearmed.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 311d9f4ef0e2..fd2135c23862 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -396,7 +396,7 @@ static void ionic_remove(struct pci_dev *pdev)
 {
 	struct ionic *ionic = pci_get_drvdata(pdev);
 
-	del_timer_sync(&ionic->watchdog_timer);
+	timer_shutdown_sync(&ionic->watchdog_timer);
 
 	if (ionic->lif) {
 		/* prevent adminq cmds if already known as down */
-- 
2.17.1


