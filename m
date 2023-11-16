Return-Path: <netdev+bounces-48344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55FC7EE201
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF2F28109A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB630CF4;
	Thu, 16 Nov 2023 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kmc5CgSA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41623A9
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:55:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaVyPrRdQcFEgJP5/F+w6bbfvnz/ewWEwcprdHfsFVFYHk0t2RFO/8jz/RcuBOoY2dhsK7qhgypWRrcTHIGPpiJsGZCUaGK9969tNjNbyJ6HpBO0MhLFaBkdU2LWCQRXv4nmoL8/HtvmtXh3kl3gr+bWTWZQ3/Oi5DRjE6wSdA7Mhw5ejsqYl0T7l+GLwa4gkXa7GUKuH6lc2ppktCJpbBvfgs+cG7FBdwmmMep9AOcLBUZFclResxol83KCcU10RgbCcw+7vThgYXSWUy6FCrT4MEZonwN3srazyoFbizunTRWuri3IBfFispqwA+Zqm2GFNvl2EWEnnNcuFPXPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQ8mb5ca+vRt3S/qckE9enOqxOf1BTDR78NMejyB/7k=;
 b=YZqKoo1LgNck2B3J8e4tKE9iUXY1J3tVQa6rUbt6qN/OaokvTjio0eYjW6RnYoeu8xcOgfma6NgtVZsOdp/qMQVUNrElkPJH/uXfco5J3ELndO9n7EJubcsuQ5yrxJCs1ltaJl/b0A7r9/mxxEOakpt0djX7b3WbZB5IP4+a1tBElLMnK5XVFu3aQ0RLYaZIVQeVeGszGFoJ7JkcdURDhd89gDMHHXyNn/y1o0n1q5zVx89JbC5sXRILkHIZlfuh85ySwW/z44WQpowd972XJfLT+nZ9xwk1A9X1Tlonb+n0RXpVKkwmHtNHTzuz6WBjV6SiWkto5opdztHBBHT2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQ8mb5ca+vRt3S/qckE9enOqxOf1BTDR78NMejyB/7k=;
 b=Kmc5CgSAz1gzr7U5JC+SJ7GwROgl4bsPK98SVB/zTJdQqoI5fUS5WW+4UVf+e4Qk2IjjclepVsJliOKAeM+9YDDauaA43PHWX7xpcu703QFlwVASmnxrvoSJznQlt4piiVnPmcixHv7pRi3oXHiJNHcykloevgOu/2uAFohdzic=
Received: from MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::30)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 13:55:40 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::98) by MW4P221CA0025.outlook.office365.com
 (2603:10b6:303:8b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 13:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 13:55:40 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 07:55:36 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: [PATCH v2 net-next 3/4] amd-xgbe: add support for new pci device id 0x1641
Date: Thu, 16 Nov 2023 19:24:15 +0530
Message-ID: <20231116135416.3371367-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116135416.3371367-1-Raju.Rangoju@amd.com>
References: <20231116135416.3371367-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbeef52-17f1-4a82-ee9a-08dbe6abb822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uABTtcJ74rzF3v1AqNJzWgFGuTI3zqA7Lmb2hUP8YntOx9McyoXW11OSgcqcZ2cHkINpoM5goadHtYfAOCqekJ4VWNWVJKy8pB+aNNyDplt1QXy6/eC9LvVKPN5VEi6CGKbKCYEd5b8Vqzj2qguvaVAMn1nHryFwd7KadbpEONZojjFyhTBWklpC3S2eb/4xpmbQZul/xf7w0qikGT2T5LmbYD4h9qOXe76Yb87AK8RigZ5DOZaUNIC9VqcgdCm1FAe3x+GFggYpeEtcuE7zqMqhdVjptRMSSZ7JgLvYCjhUpHmNJFnuPj1ObG1MNm0yEggPTl+P1w6jETQycuAcyhKxE57XIOgYdS5pZ/oUplM3oE1MqCL2diK6UYAhQL93KkAdzw7FR0XGCN98d5lNQJZTO+ymR6aMlS5Xldp+MOn11imF7gSjIsOvWy7LsOkZtNdYoJFAJgS3CMGfJJfcFriYobHOZRDwregi3J+Co9o8eVn0n+ItgoK0LTzYOyN+L7rTjGGVRXywgpFPdwdcFnv+xc7hZiWzhu6/1hOtzG0m4QOTVk942iwZKL3m18bgJrbCW//m8T0eYWXb42kuAkQBwQlTS/4UOgkEC2aIyi9Q+NosZBHKj4IMykZTUwKppTSJtYQ+XHv3p4y4xodVsaZiPhzBSrFwTpzBGClvil5W9ZNao8lsjdCXOWcjrXsoA0mHFjK27nfmjuJavsnn+0gt6VhuTn9ft+9ArEKxoiQXor7oVPrx7IpLI/HYaICVDxw3M44kTd+/cP2u1cOvfA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(46966006)(36840700001)(40470700004)(47076005)(316002)(70206006)(70586007)(2906002)(54906003)(6916009)(40480700001)(36756003)(36860700001)(16526019)(2616005)(356005)(41300700001)(336012)(26005)(426003)(81166007)(40460700003)(478600001)(82740400003)(5660300002)(86362001)(1076003)(7696005)(4744005)(8676002)(8936002)(6666004)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:55:40.3181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbeef52-17f1-4a82-ee9a-08dbe6abb822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193

Add support for new pci device id 0x1641 to register Crater device with
PCIe.

Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 22b771057cb8..5496980e1cc7 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -545,6 +545,8 @@ static const struct pci_device_id xgbe_pci_table[] = {
 	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
 	{ PCI_VDEVICE(AMD, 0x1459),
 	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
+	{ PCI_VDEVICE(AMD, 0x1641),
+	  .driver_data = (kernel_ulong_t)&xgbe_v3 },
 	/* Last entry must be zero */
 	{ 0, }
 };
-- 
2.34.1


