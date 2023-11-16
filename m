Return-Path: <netdev+bounces-48341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E31877EE1FB
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D973280E85
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F472D05A;
	Thu, 16 Nov 2023 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sohl7ovY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33478F
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:55:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a96a8SWu/h/c8FGH7PhG9DeToYthPp2A8s0cNrKT1Ml1y/DiFb/nYqfyDAxkLIvT8lDKCgwDpUudUQnDG1y54dJ5HjwU5fqdXaEldX9poyGPPdkSDnkbkxE4ycE55M2iqGedMnIfdeTA5aix6eiIvsysNPhqJoS8HDW1E7iBrItQJyy7tAKDWDWAmRF3z8zHczxs1psml/PB6Dl3Qjj0/Tr+jYEPvaH7QijMoItIO44t3OqXOD7Z0aMNVH0spreO2F/zIrIS/x1tnVFDUR4SpPKyjD8TRI/p8EDZnshSyTXFhQ97hBiW0UtlsZ3a/y8Y5+pOOe6davgx23sZ6NvwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSC1BEukrzRmZ/Xum03EFfvvjTfaU74x8DitNuosHJo=;
 b=E1bDuIeQv7k1WnxNf9fnO0OLpVThwAC85QNGJ5f0jZik3R/OOkFH1/sdN6r/9JyaP9Th351erGpdzvXiDEsdHrJCXLEYs4+bQjSee76YffXzKDc8GVqOBnnar3DCaKltoVp4HDJiHtShWFQghvYvwDjdZGwAEylZGgRtO7WPFXeF/tK5MAVyKKfF9uvLTQ/vv9ORzZHEtME47Opd5KUU7YaDLpKDqEBIdbjcQfzhuhEZAaT8dBnyjx5rJmmKwni4ezZBWR7t9grAxLe8tV5nU5w6vK7Qq3/jKUf/l36bWTe3fmHQ9GAQAxpi4Egh/pFl6nak5/hyF+yN9H8e133Dow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSC1BEukrzRmZ/Xum03EFfvvjTfaU74x8DitNuosHJo=;
 b=sohl7ovY7r5qOnUfEuPsWVkClnCLscaVLvaaWLbuWDc8KBzeYMWXYwrl97LnGAs6VMZsSIrxnLO/IZ6E9CRwyMUgVfUKOG3vR1IFQrFCpmrjhmewb5RIL78LezSaS5cVjq6zt+zee5ngy4Svqq2yfhqE86DjrATrHIuGgTwrW1g=
Received: from SJ0PR13CA0170.namprd13.prod.outlook.com (2603:10b6:a03:2c7::25)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 13:55:26 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::71) by SJ0PR13CA0170.outlook.office365.com
 (2603:10b6:a03:2c7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8 via Frontend
 Transport; Thu, 16 Nov 2023 13:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 13:55:25 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 07:55:19 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v2 net-next 0/4] amd-xgbe: add support for AMD Crater
Date: Thu, 16 Nov 2023 19:24:12 +0530
Message-ID: <20231116135416.3371367-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b679db8-26d4-4dd3-5992-08dbe6abaf50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y9Mvx3tuJGz3TIoECvP6K1GQG+6ijaFHCTzyjqMSGAC6fYwTPQlh6+zyjq/kVG6sNRykA1KrDPFA8RZnasEEqKSoNHdDpmJekLLBUMvf+uAw9FwmrXQzho3lSweuJ3INwA7yRR5SKqPnyZ1twb1urAgkG0phYDMt0YSNhjMV+niPTnVYG4vchbsH43iI3GAOGG38O2kv3rxPaGwxTEOonwOpFDwJcbsVgRp0sbBKVVQBWAux0x7HKfywkNI2dkxYdZJlPLPdNHLGLXWWVUnj+VSGxOGOcEV9rnE+lvQ82rGJI8UiwYLwGaWDBWhbv74F1Ruva1bvKSYb7aAGsF3ippa0NXjKyX4YkL3WY+QS03OKSpWkVIccBM3A5qMu9sGfR4lS1fBHtvmnPwnlv4spB6mVVoj4iHFHb8yfd6hmt9sq4Gkz/X6gZvLCRhFhm6NKuOX0BaSD4FakrETbtTLJ/hdB3oMpRQuZ5p6NLInMEPgsv4ASnicqplhFxBnQnUPKEMDAK7mdg+zrVUxpyS+vMVB/Wqn7nUSVWKbv/AuAFVn6nK2JWdgD/xh5Jvqiptc7uPr7mdUEXhzOXUayQwuNJ7fPCog/Ir14Ab5A/5SaL5NOYktXxULJ40C4esSBmfJpkssTLwCMfRWLhuEBNrmBOtNKFHJW09XWTZdxwfYwTc78s7xCD95e3AhWfow4qRVRFkxxRNtjBFJphhitzHWpgU0Yz6qKfzols6oXEKeasYmgn8J5JyeLE2hBRMWyfH5atPpniLmLmGJaoceroYbDWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(2906002)(2616005)(4326008)(36756003)(16526019)(8676002)(8936002)(36860700001)(426003)(336012)(26005)(1076003)(40480700001)(6916009)(478600001)(86362001)(5660300002)(54906003)(316002)(70586007)(70206006)(82740400003)(40460700003)(356005)(83380400001)(6666004)(7696005)(81166007)(47076005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:55:25.6413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b679db8-26d4-4dd3-5992-08dbe6abaf50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069

Add support for a new AMD Ethernet device called "Crater". It has a new
PCI ID, add this to the current list of supported devices in the
amd-xgbe devices. Also, the BAR1 addresses cannot be used to access the
PCS registers on Crater platform, use the indirect addressing via SMN
instead.

Changes since v1:
 - A new cleanup patch is introduced to reorganize the code using helper
   functions.
 - New XGBE_XPCS_ACCESS_V3 type has been introduced handle the Crater
   device XPCS handling.
 - Used FIELD_GET() and FIELD_PREP() helpers

Raju Rangoju (4):
  amd-xgbe: reorganize the code of XPCS access
  amd-xgbe: add support for Crater ethernet device
  amd-xgbe: add support for new pci device id 0x1641
  amd-xgbe: use smn functions to avoid race

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |   5 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 122 ++++++++++++++++----
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  52 ++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        |   6 +
 4 files changed, 157 insertions(+), 28 deletions(-)

-- 
2.34.1


