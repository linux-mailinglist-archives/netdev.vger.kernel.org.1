Return-Path: <netdev+bounces-47140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BEB7E8370
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B7228102B
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DCC3B785;
	Fri, 10 Nov 2023 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GRSe9R/W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C18208C1
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 20:08:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3139C7
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 12:08:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5ObZBQWNOkysZDxwMak1uWmBP/ArmLz08r1HIe/uZoVm/i8PfpXdVi65+CImKjVdkUt1BW0nWRfpgQ+uLgf9Y1IaCLiZvYSKt9pcxqRXrrRQpZicafMVybAAVWILeAxRlwVEKjq/gCmFtsmU2xSu8C2a0rT/yykdiT6ZJcdblSAuDPRx4SDAQbXNhf7HbOCJ41SMnY0iLILmCDeeaez//llMxYhKsk3QSWEM+uOXzB1LiUDEMd57Yyfh/WjRLJbYFhjW6DEuirkLvO00M5trxWKuf/+QMaLxE90/J33uDelhlNm/+iXSShyzD64uyPhtZvADcuhfJBEtfeTFdaaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBryB4mAoAxsdwrhUHU2fI3g4UC9HljnytlCy+lSsF0=;
 b=fv/jp2sl8uo7QR9wexfY0DybP+LyvuiEytdSFSrAltxH2wtTg1Te/ExmuNNOwxjXrh/7JBU6BRAB/haSq3Ncw+cTzQmg8RLQ23Jy4UZiHax5AejUhFbSHO5npmR+Zo1oD4nMWNJTu0YysnRcKUIHs7VWsA71Ti1mIPEliDMy2ckwe8TSFmmruSx8bPyGVOqFmcwe1KNjSRHiwx3VvqLVl4lMAgbamNFjEIEyISwxkqsJwrlWFUKi29n+WTOBHCf9fawx/gJ33vkm2VrA5Fm0MEyzfhy2EfzbU2HU1rGy9YTw/sMwZkGxi7hWoqJKXxls7QCvVYPlFNlbufV7lE/6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBryB4mAoAxsdwrhUHU2fI3g4UC9HljnytlCy+lSsF0=;
 b=GRSe9R/WYpStLNMxcRyg7qb88sQfmZkQDbg2m0N8F490LfYspQ3w4nhm/CLnDpVf5sNgt45EyCUc7AdkSzRLikLA/Ru3EBdCN0BcA8pzpy5xcXnC4HTG2bZFQZRGho0aymnDuFnYHx1YtdoFCCei5wnMMyLSxOX/aFgA1inAcVw=
Received: from PA7P264CA0133.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::15)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 20:08:32 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10a6:102:36e:cafe::ac) by PA7P264CA0133.outlook.office365.com
 (2603:10a6:102:36e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 20:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 20:08:31 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 14:08:30 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <drivers@pensando.io>, <joao.m.martins@oracle.com>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 0/2] pds_core: fix irq index bug and compiler warnings
Date: Fri, 10 Nov 2023 12:07:57 -0800
Message-ID: <20231110200759.56770-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcb002e-228a-4e70-ba9b-08dbe228cfbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rOywFEGs4soSyO1P5aagcacZANWfQxMLR455wIN4z2WVRGJz31V4nAlQXpVlBqBrosvgXFtYJzfEZjnnEDm3KKvg4Nru/V/iMDdE933nqZ2i9mfBioe1K1FGOd0TjMyT16W37zapEwEcj+eUPEa81EeHdudgOjl2nBJ95KyigoZa9M7Y3w4JVoS5ou5Pbda37T12Xy5VypZgGSt7bpItS3nTVR7/Lw2ifoA8nWv0n3YbQQxyjzpW1/GIUlXOR8VXlPDLtLkulDQpPw2VcNtCCnX3BZnIL79rfBFkSI3AQx3fIffApIrNRpRcd5rPyLBqiHQFrrAi6SB+wbK1EdPH5OpLkBnAD0FLQJCGk7sQdc2aj9tC2MdPoPPhvQ3ORT6frpDIqR2B8cS8n3eT5+RgFe12ncWlzAu8HWbMQqsSKt/KiEZ6z880nF8r0lqgG87BhCb/z8A5dGy66yLWZ1ExbYcjYfcD8AU/Fj5acsGWj6dAFzGO+Cby4KqmT2+HWGyOIwFxK5wMDI4wA38KRJlYP8p+nkXnc5eeUwBTjNzPVJcIyDIJdU4/c05hx5hUq63m91q3rga46elwDq/OmFwXXauMaaqlqA84RZ3J/VhHX39hMnwSQJpm6bDUVqF+3TeO0Pxn6GpHQd+DXXxEdqmdYbDv5spG1IlprhtzgZO7d/nU3Mt2AJtqwpfE4o75c84YqFjNukQ0gnN2XPK+8s6EUaKtWimVMfwcItM5MlTYW/ugPpdn7w6LpLO5WqCd1l4zBUdUU2mgdden2H1iqxRg3Rf+US4lmT5VqN2gCz6fjMc+pmdEZUpHuStb8Apghl/w
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(82740400003)(6666004)(2616005)(1076003)(70586007)(110136005)(16526019)(83380400001)(70206006)(26005)(426003)(336012)(40460700003)(478600001)(40480700001)(8936002)(8676002)(4326008)(41300700001)(86362001)(36860700001)(5660300002)(47076005)(4744005)(2906002)(44832011)(81166007)(316002)(54906003)(36756003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 20:08:31.4006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcb002e-228a-4e70-ba9b-08dbe228cfbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055

The first patch fixes a bug in our interrupt masking where we used the
wrong index.  The second patch addresses a couple of kernel test robot
string truncation warnings.

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


