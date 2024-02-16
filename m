Return-Path: <netdev+bounces-72578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D1A858935
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2731C2145C
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5A01482F0;
	Fri, 16 Feb 2024 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PV/OID6E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A71419A2
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124002; cv=fail; b=PIjenLH0lQEIpRmRsAmcdo3Me8cy7pNDaBRMWaxBdUgN3aNvdPH7df/MVJvgAJIPFBzr/+L6E1Ap6eGkfv+4zgKaLiZsSsfYxVWh5m3cuDEsUlKWzq7bIh7rLE8XetS7G+vDNHoC0xXkYLmf4EqztB0/d0pvjINZhzflM4J5aX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124002; c=relaxed/simple;
	bh=hHLEgGIECUkGQMpOW2vzX7zy7Ea7mtswroGX7t9Qhj4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NKEjIaWlQeWN8y/RzCHyi4d5ASYryBmJxEClJjVfPoRG7fSSbnbonQ04DLscaYujJijOVW78r5RZyBXeKGORcSeYz8WFcY/EV7aesTW4DKCNqH6m5UKvEEYVbddlNB190vnd476/C3rwQgudz/ckZn5qd5BcUqJn9z5qA7bXVGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PV/OID6E; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPZy7piuAMjSLCCRiOxcnfkSE315a/vcWujyQ3dDB52Xd/zeKjkg9xZigV3jLcQtyVbEw5fKW49d1ZMOgOcM5sgJmIj2YzelaaT30Yj5aIVuGNc/gIkRdEKJzEGQg/dr2I3f+IUR7W/EJfShVWYrmB1oGNTZFBePglCWdjhqkVPRoAoevyVbvR28ulJrmltW4CVbugHHVTlgEbTP3eIxawhhiGKnA6ZvjO5Ensa6nsHWzmHDzUX66ZWTFOQ9X/J4duna91q1OPchvPcwHJJx3jc5ZJ7lxu6vOcR+lpuy3uRH7Z89NMeRU+auA9BtSqGwp6kq/12839jVchgXHSVTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMwDLgGGCMUOPvp1DsoHjRJxfAMHphawG3GKcF5vyIk=;
 b=g+dHpPHfHA+n/p8KMidSAsiHZhCPXY2oh7ytuahJa0wD5B3ClCJPYhIhmHzaE+6SWUOg9mjhQYbXu0yL6VZ7kM6YdXmFVozbqX6IUjMRDNzx8aZsW/A0BVV+r3ots9uJz7FOtetYmuAbRDwOK/j8E+JhHE0IshiRzIGJ6DhUbV82O8PlMVqHgQDhdsa75cgLyDyjAfx/3XpD+T5R13vDOAqCQ9g46ED+EyNVOSV7VxnYxw6ye4dEtEkjN3Baf0nzS02S0Tw5EoAAWNvX7yr9KcdRiVrbDIy/O3ZnBtJId2KE7AsZHiWGTkVasq01tzcZ355He/3ly+zk1dtMF3VLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMwDLgGGCMUOPvp1DsoHjRJxfAMHphawG3GKcF5vyIk=;
 b=PV/OID6ENiuMrZkPvod639QLt28VBn1ZrTMEqg4+487Tj0Q/h+x6rNBgdGgggubISt64oOoLoff/sVaULJlKnyg3PqbuKxcZRQyjGvcWlV/zThqfJE5g1fBLoqKK2N6ydmxJMphmKaPU4WmJVOUrYCa861ioP1SgQE9MXfGGPYU=
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 22:53:18 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::93) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 22:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 22:53:17 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 16:53:15 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net] ionic: use pci_is_enabled not open code
Date: Fri, 16 Feb 2024 14:52:59 -0800
Message-ID: <20240216225259.72875-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c7b111-5d03-4428-528f-08dc2f42110f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q4Hg+BulOVHHRFdkkx7kRXCAJGT4aM/t/T5HEq90EcHZotrziZ8MrhPbm5472+ugPrZkNYrT7fp5NXYp4yXkjRFu7dZOjcjYHuff9Eh4aFNsCKP/OVXhAbkpwp0NwZwFKX30GEGCBtwym2TVTBNPbzFlSP4q1epEJWVmuWUuRW1nI3hTlOiUFo//tNx13LoZoCpkzV+45tU5Z8arQxcSIMNGeiRfStpsPhJI3FpMRzoENmw/TytHp206v6JkZorAfOus0EtEJBFROLcL2eu6UaiLZlzfgynX+RhC4aydMwHQMfwY19t6bgpgBAALc/ocF+h9y4rFnBgdJdaMuUfU+4o+wDSNPIyVKZLF80zKaMAHhhyzh8LzvOdZ6Ya1iOAo7dJN9ffDtLPheR5IkKza/rG4AsZZGWTzXXOTLebYk6SlVezJXxEiloG/TDv3SyrVCKAS8OuYnjl5oWV9+DvPf5KsXQ3uRP2qJx+hcGA40V4MJ0wI4prvIEugjd0tjJZju7DOAIL8EqiEIqLp6FT8YufQljNnL42Una4KYS+XSuGDobmiyOteDGp7MWd4N9SN6uu+J49UCOWXcfUREANwyaifvf/tKCYgQtedEacoVd4/JKZvuo3eja5wnl86ayb4DcA9AevkEBVf3hfT2E2T9r32XFZ61DzxsVj/BAT4lCY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(64100799003)(36860700004)(451199024)(186009)(82310400011)(40470700004)(46966006)(86362001)(356005)(81166007)(70206006)(70586007)(4326008)(8676002)(8936002)(82740400003)(2906002)(54906003)(44832011)(4744005)(5660300002)(110136005)(6666004)(36756003)(83380400001)(478600001)(316002)(41300700001)(16526019)(1076003)(2616005)(336012)(426003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:53:17.8300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c7b111-5d03-4428-528f-08dc2f42110f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116

Since there is a utility available for this, use
the API rather than open code.

Fixes: 13943d6c8273 ("ionic: prevent pci disable of already disabled device")
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index c49aa358e424..10a9d80db32c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -223,7 +223,7 @@ static void ionic_clear_pci(struct ionic *ionic)
 	ionic_unmap_bars(ionic);
 	pci_release_regions(ionic->pdev);
 
-	if (atomic_read(&ionic->pdev->enable_cnt) > 0)
+	if (pci_is_enabled(ionic->pdev))
 		pci_disable_device(ionic->pdev);
 }
 
-- 
2.17.1


