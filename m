Return-Path: <netdev+bounces-33983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414F67A1108
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 00:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E55F1C20DDE
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 22:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0ED2E3;
	Thu, 14 Sep 2023 22:32:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0638F
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 22:32:36 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9B3270B
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/jolYwg9E5u+5wjUKHPaFVLRg38hlkVmThGwXlaJTfQG6eqkCmYgqhrsJ2J7DJFRb8UqBkcdF3XOdhtGzES/8C4zUfaa1H6kzy+BU7Y7nnE534JiHo5n6J7wogG95NN7wLpSb3WEtC3sTcdkmGr23yzLslFa83zqV8Mmc6y2p9ieFfVQik7oSezyhdmrlemI57q96LxxGYRe901ib6/QUowVNcKvRBUJr8eRyhB2AWdBDS75KwsmkRhH8A2/hU0HoQz44EPJjnHWpY8eB7ePrJMT5mKS6Svc19+tLnpiO/txYZ8M8WKvxRsRhQcmC+9E51Q1n92XpeMeJiJw+qqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cdmgFZCj+Dxb9/L0+nmsxQyyULWUJ93Uh26oMPjITU=;
 b=ifUdHL1e3214T1l6AlE3cdnWz9BJ4H+dNwNlcvYSkp5PYovSFxME5xMf6RsNdH05eYT9cxAXpMIGKF02qRZMGxSvNmNpu84ckMNR7N6cRP2k40m+csUNiFg2QhL3EaD38b2obxB80Esl4fZYfQVq4d2CQ2d4wpMxLmjO5pmw0CuXSm70Pe20/W8W2mz7Wz5f6o+T3etDEsUUmDPAlje0LX2AU/eQWihtEBp5lsETPVTFcjt6YjpFVh6LQmwP9FprrWPu/7rIdemxdz/fB7070cPyqIDaMstt+YVuM4fH/fotiI5HyxE9wTFeK87YUhd928HARwyVt7EeT07wuB0ziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cdmgFZCj+Dxb9/L0+nmsxQyyULWUJ93Uh26oMPjITU=;
 b=ej9I53KBhCgjLdHvuJ4ibSmE8x0Ug7WEtSUrR2kQB1A8VF/ee1bAk2j2OuwjzJcu1bsbG+KFZ6UZglKxVvgVKtP+/UDMMzojN/hO7t7NHvgCF8IFmvA04DbgWHcJ+NFbtN6htSN7bUF4O4yVdRJ5FmUPJpzl+QZoHtqQfEVWmuE=
Received: from CH2PR15CA0022.namprd15.prod.outlook.com (2603:10b6:610:51::32)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Thu, 14 Sep
 2023 22:32:32 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::50) by CH2PR15CA0022.outlook.office365.com
 (2603:10b6:610:51::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Thu, 14 Sep 2023 22:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 22:32:31 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 17:32:30 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 0/4] pds_core: add PCI reset handling
Date: Thu, 14 Sep 2023 15:31:56 -0700
Message-ID: <20230914223200.65533-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3d82a2-e4ef-4283-27a9-08dbb5727c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7tpbuo/vucEAumVB/NUaOHMpRD0etzxrVLyoQTc6DhVJKmP3Qukll7WmC02JSGsGR8JyUtb/d/+nD9MCkkbbRZTcqYZKRn90MOJKRsdXmHKo64goqqk5pnLAtR6QfJ2FhrPkCnFl1FoZmetWja0OUK+LkpGX8LzkMpe2qA0LQzAnieGn0K9gCZI0r8c0Uk6WmoOj79/WgcHApyTiyNFSdEyeMU3lqc1dKxsQx3mjQd4AqVQ6ZzvQyY1RtWtVS19UQrVyEH7kkljtqh4onATL1Da6/3qyZzzanOewxXmPJxwQnDPt+BdpiFYj4GTc5jrd+P/SE6gawywCHgWpjHbfTNFAwmKtCZtlw6XraqozGFLOcTIhKBtikUZsmUND47uHmmJeRlXxM7554qixkKN4OUX1jD52ZXPmfoPlFdQmUdthmctTfoAQNIsEAzqJSGrZTmusC1pOPXt264hbdT7OIjuQ6w+cEzW+vRpgjdVdFCD6059LtX6QefjLJoJC5ytMCldxCffEzU9STZ7eIKf+H1GgcZjc7m1GSUAtr7gg10r3W1EjckmWmHiwGiHHSLxq8wWlBrs55DSINJsWGFVajAj4JHK0g20yd60ogmPGEfVeaDYtcp3LRq4bdvqIv99hQqMGTGKY9hvqKnswKTSGfcDpco0e3MbviHFMoqxsmQAzrzKvwh9eTlh7Z86M1wdg81WhN5U0Xzn4p3Dx4rNq4ndvSkKXpuLx+vfT8EcOTymEjQkZ/MbKZ6ftmGJr9D78hcAa97Uj78ERbVqZeCa0iA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(82740400003)(36756003)(81166007)(40480700001)(356005)(86362001)(40460700003)(4744005)(2906002)(6666004)(8936002)(8676002)(4326008)(44832011)(70206006)(70586007)(5660300002)(83380400001)(1076003)(16526019)(26005)(478600001)(110136005)(336012)(47076005)(316002)(41300700001)(36860700001)(426003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 22:32:31.8344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3d82a2-e4ef-4283-27a9-08dbb5727c49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

Make sure pds_core can handle and recover from PCI function resets and
similar PCI bus issues: add detection and handlers for PCI problems.

Shannon Nelson (4):
  pds_core: check health in devcmd wait
  pds_core: keep viftypes table across reset
  pds_core: implement pci reset handlers
  pds_core: add attempts to fix broken PCI

 drivers/net/ethernet/amd/pds_core/core.c | 43 +++++++++++++++-----
 drivers/net/ethernet/amd/pds_core/core.h |  7 ++++
 drivers/net/ethernet/amd/pds_core/dev.c  | 11 +++++-
 drivers/net/ethernet/amd/pds_core/main.c | 50 ++++++++++++++++++++++++
 include/linux/pds/pds_core_if.h          |  1 +
 5 files changed, 101 insertions(+), 11 deletions(-)

-- 
2.17.1


