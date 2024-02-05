Return-Path: <netdev+bounces-69246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8874A84A81D
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49F91C2800C
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 21:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61058137C2F;
	Mon,  5 Feb 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BdNpL/ED"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1FE137C26
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166166; cv=fail; b=uNFAlsihiwgmo22X85yivwfbXGj5mhduyX2dTwjrGX5SOaB8dDVnK4VGozcqO3ITLtlXkHi0GRh9Ypp7MfVHWZaRmht+Qyur90fVoqLhW4tyjPVQfgXscV6woRu9jMC4gBQ2nZ6sdgZ6QBEvHBtg5GUDzf4GwwC4v5wvHPnXxKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166166; c=relaxed/simple;
	bh=4BfPpg14X9zmpWFCNHwAx6oITMvvk4lAjrfh7UUrwCs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UAr2Er9jvJE38p6b0QUGKEHc4koxzN7k2aksGIZucaAbInAIdYJ2wHGqmQYirRcLLcN7xdIm3zPhlvKJolQrMSDEyA58vz10e4PNOHcS2wCfu8j7xg/H0WBcmIanj5u7YoyGSUvxmXmu7XlHP0g+g6Z3WgWEuSErzXFyI8cORs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BdNpL/ED; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSKBCiibByNvyCO06MZZw36F30/HX6DyURmT/MbsHnNMx4qkHgrHVME6FK6hde1X2k+fuMYQp+JI0jLoAkzV6Nk60khk2ebxZg7JX/kVZoXiyOBE7jSir0ax59J4XmZtnsGjKraZni0PgVfbdZwo6kO5eVOjWnfSEJhhXCktRyAQZsBNO+BHy0i/1IWrH8YFM2Dgn4/T6qrp8vNMuBnu5Jt2fJM7l6+86V30tAnWcXtLcLy6cNMsVaQ0Sh/R0Iryq2rizYI/8bLrAtA4X+letzTfcQzU5l3/4yTqGsu6qZBbIALc3wdU1FofOvhYx8GohjWw09EQ5akt5MQVGIDnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5VS4oxSsccFnoLE5+e4ikme4NrVqpepAGdM5ID7ZC4=;
 b=ghIp5EqHMmMtyKQdeOdgMm/GaWT89V630MZ13b4GXtin9FNcOHYhJ/RDy/2AWnXWWIY5lvG4Sv1XnWxuI/BKq8/oPTtPW08uP42nyD0EQIVmd7o6OXrKVPVH0iNTW8ZS6sNMCCmhnlORZZzAj/VgBDmiq6Qbc+GsxJuwuiKGAg1i3UbuEswfW4Ds5T3ouqTBnzlDNsi5iCq7pw5b26f/ga05Gyo6bUXiY0wcxeelG/ucBpgdqaRTffcdM0REpCdzx6bR1Pwe6BECM7UOAvwiIv9gfPO3IRHj2RC0bcd1vLyW+IdnRJq51imsi1XK3NWm3gwmQJV2Rpt4o5+/38A1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5VS4oxSsccFnoLE5+e4ikme4NrVqpepAGdM5ID7ZC4=;
 b=BdNpL/ED63hUxTvt4Bjm1g032W/bAb9iKsM0Jeb0ExN3+fvrtbCfJzaW9GgYdpaybYlp8XzkgA/OLuNd3GRHz4qhW3MSJdKPj25ED1XY3Oe09dU65PqyHr0CC2t/6+JDk9J4xspWexkd13FJ2vns/YqYPp03YW8myVJtc4Tsk1I=
Received: from DM6PR12CA0008.namprd12.prod.outlook.com (2603:10b6:5:1c0::21)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 5 Feb
 2024 20:49:21 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::c6) by DM6PR12CA0008.outlook.office365.com
 (2603:10b6:5:1c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 20:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 20:49:21 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 14:49:19 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v4 net-next 0/2] amd-xgbe: add support for AMD Crater
Date: Tue, 6 Feb 2024 02:18:58 +0530
Message-ID: <20240205204900.2442500-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af09453-8e3a-43e3-3827-08dc268bee15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Wfa0V5ayRfVknCKbpy0N9axyPo+Daay9HLUbuBDjOVpPbnAhdEvalw3mn78hhCW3d6c+wnXK5JLkDNl4JoN7zZd1i5/haFR4i2AeusvwwNPqPB0ed8f8IGKuM74Nj/8B5Ogw80/QlLQS6IldLg8qdGEAAS2VAcbLXjuTz1UXcWZ9+RJPqQxb6cidtUPYDK9yVjinBJdjikGotz/HJ8rIlyJyHU4tIRO/mgsQjNpa8TBpqU3s0zyCkVDN7+m48eypcKvRuIkyAMZaaR289VLI6cBLg44fG/VvDsq0nCv+LQzCyD8BTbhhYS2qqRGQe6MG5yTdpzfT2tHvsV8pHfCnMYfoH/0eqFqDVL7lyhefoFYJed/G+IGckrm26cdUL8tvM7B+0ESOOMu9VSeTa8zB0l5zgZboMrHA8NH4WPiK+FmZXRdu0vSqeiDrN5l9Qw0z0hMzMFT7SZ9Ikv3eYMuTrn8QHqWfOm2I3SxG9iKUm4FJXJ+YIqAn9SMg7I3um1mc3vLYOFzlVWkZv7XLpC2VHHxhL1Vl251jgmsKNaC9TabC57QmQRiYfsvWj8kC/G/HQ85iIQspna2JnhhCmZcjWjqo10l+dehHewOrrAmApUSRGmMZKvrXDLI5SdKpjcTQ6mVmBbAlg/h4FQ/pcv7CR6e0bERceamem4BJaM+SY5KhgzrqTszVFMunYgA2Apu4IVwsRtXNtPj/pFVWAnrr3uYd2NrBqS5Y3VC6FPSivqiCspSCcwKgoDEx0SxHBgV7iQAl1IiPjnLmLsg9i5mew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(36840700001)(46966006)(40470700004)(41300700001)(40480700001)(40460700003)(478600001)(36756003)(86362001)(426003)(2616005)(316002)(81166007)(356005)(82740400003)(336012)(1076003)(47076005)(54906003)(16526019)(26005)(83380400001)(6916009)(70206006)(8676002)(5660300002)(7696005)(6666004)(36860700001)(8936002)(70586007)(4326008)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 20:49:21.5664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af09453-8e3a-43e3-3827-08dc268bee15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367

Add support for a new AMD Ethernet device called "Crater". It has a new
PCI ID, add this to the current list of supported devices in the
amd-xgbe devices. Also, the BAR1 addresses cannot be used to access the
PCS registers on Crater platform, use the indirect addressing via SMN
instead.

Changes since v3:
- Club patches 2 and 3 to avoid bisect issues.
- Modified license in xgbe-smn.h to match the license in all the other files.
- Modified the function get_pcs_index_and_offset() to reflect the name.

Raju Rangoju (2):
  amd-xgbe: reorganize the code of XPCS access
  amd-xgbe: add support for Crater ethernet device

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |   5 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 119 ++++++++++++-----
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  68 +++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-smn.h    | 139 ++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  11 ++
 5 files changed, 291 insertions(+), 51 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h

-- 
2.34.1


