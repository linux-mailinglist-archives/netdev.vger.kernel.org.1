Return-Path: <netdev+bounces-72563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9552B85887E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D02728C5F0
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918822061;
	Fri, 16 Feb 2024 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IsSEn8nz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3924577F2D
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122619; cv=fail; b=LvD25227KWRgnuMaP827tbhh4g7HSiGuhJqARoARftP7w9xBxpMh9hg0qpH2X15sLnsP0PNTMgchdtAdSLLK11lYIb290xEkvJ13IVeSafZj84RKRldkZz0tBckpQw+0WW0gEZr/8jNdW9Baaz76vf6ZDFLKyQp74278dTs+ueQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122619; c=relaxed/simple;
	bh=Q0P1hytwMzgKr36osfdqfboOowXqSk+fmj5XbO/0pVQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=neyPXsav1iKSpEw9tDEJgiAIIZFj3J5KKgkChwPdUoCptS0KfrvfwrjelRvy0uO6s7xHGSplquNUVKaYgfEijn8GCziNvLEWukMHhXrN7PLq1uvaleZ71uX+ClOOsi2GmV6pPpz+jR0L9l1iYehPF9I7jWfQpSKVCrruOwmBeRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IsSEn8nz; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdWLosRZrfW7/CBdwReJZPgyCbCqDMEBTthrlX8sFCmE20srhCbU2+dsY1ZfFfA2tq6g/xx8zg50PwwQSIWvPaLgk9liS+1yAD84ukQ2yT0aCeS6DC97t6HtXw481SdrJotRrYG9QMra1iwCfuE+kexX6jzDQtnxgLEKaYh7uoJY41Aw2qqqnnYydohT1ejOLx4Rn1ue1hW65WFqG5XtCEudm7Jp+S4ugGhfAC49yNH5AY4S529piWaceJdlvVXIWzFWiFhnCIQVTt1evH/oTtJgJA406J5w8G9LioSZqukBagmegHyhDuIioVen+AXMiQvToTFqsx16Z98E6qdf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8c1gNXGuamD9NEMHGIB84BxF1AIVqx4nxbIt1MDjxQ=;
 b=HrQdCGsMcVDakfn9d7uPMskSA0rqnayGCCBEPHnZ1nbSSBYX+CMxdY0BPJn3/FowZYFXDH68FavVRnL+htinEceqhZkS6AF2fToJPuumnbQgWiomgkbCLBb663ZoBecGRVE/rbM1pMfvtPbBfEMOHoD0Mq4huPAbdPkJxqr/7KMTTCAr3VxqWrhbA03C/F2p0yl8Oil5sjX1UWlmMHPIi9OnkxTc91fLAYpjjBHIMoeMBhDGQehLn0D0qx3sdJuoIdmxjQfRKD4wAOdvWacV1BIq2j2R18k04FEw3Kdv0hqkklNWzLV+pQywvj0tqqsjQcE0nU0Ju9VPfce7JAQIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8c1gNXGuamD9NEMHGIB84BxF1AIVqx4nxbIt1MDjxQ=;
 b=IsSEn8nz2AGEvbsGUawORU5n0we9nBf1EOnXKSOl6IHf/8dSo+mdUgFfGxFMoabWEGYiW4Q0fRK15Otba9WTEn1IyHh6FHtm8zLJkeIrUXzAd6HGdwPaAm3vBdZ3B6WHmb9FQEYOcyueaX9tWv5rWi460rK7teQNpIdEXJi9PTg=
Received: from DM6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:333::19)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 22:30:14 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::72) by DM6PR03CA0086.outlook.office365.com
 (2603:10b6:5:333::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Fri, 16 Feb 2024 22:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 22:30:14 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 16:30:12 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 0/3] pds_core: AER handling
Date: Fri, 16 Feb 2024 14:29:49 -0800
Message-ID: <20240216222952.72400-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db999f5-25e2-4469-13ff-08dc2f3ed887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B32rb0ZfqbkttXtUdSx7hAZRgWBhRoZdsWUnwknfWBHdkqayCQdEV7P5jOx8qWH4WuTVfeQLjRh6FVecBjIgcko/0zf3MoWVDpQN0yV5U/f7P71HZWGltTj9eBQeuP+7BylWqp+LHo1/DFFekIEq1m0/O/2reuJPeOCzZWjLmCkDJtf+omf3SSDqXqUtARvFbBuoOSbegAmQJoeOF+kmyrRqtpdfROIUyaATOwPXsl2SqC1oDiV2sZyTkZtLZJm5jtQRvA+wmtCOelchIt6NWiRT9ZxZNZd4e/ZHQQLyiumsLS/FdYpkgs58H9FbDjE42VdfamdD993Nd1wyZVYyrQhdyR00OF5c1lSR0+FWJZNpppLoY+KMsyQKmltypM/8XNpHJLVC7vBd9H2/MCKQwgTN9xV3rO8tAp61/R8wjEst4yH+VPjhQzgdsMy6sh2mJCQeNmj3LqR6noFAFYigEw2GCGQklczoXXUTNOOSpM2gOtWohgkxMHzEFlRJNWia6FKlaJsBh+5VMiPygNNp2f5lVyMIxEMhQeLZAn2iymTwvBORBjhbSAGmEOcckTmLx4NfNzebs8JvHsDxplO1Z+qw+KqHQTrHuRkNryOOoLkjpRE8UQLwRR6mkMg9NkeiUjvXPv95ONAc33+IOs/pyQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(36860700004)(64100799003)(186009)(82310400011)(40470700004)(46966006)(2616005)(36756003)(426003)(336012)(16526019)(83380400001)(26005)(1076003)(41300700001)(70206006)(8676002)(4326008)(8936002)(70586007)(478600001)(6666004)(110136005)(316002)(54906003)(86362001)(356005)(81166007)(82740400003)(5660300002)(4744005)(44832011)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:30:14.5414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db999f5-25e2-4469-13ff-08dc2f3ed887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471

Add simple handlers for the PCI AER callbacks, and improve
the reset handling.

Shannon Nelson (3):
  pds_core: add simple AER handler
  pds_core: delete VF dev on reset
  pds_core: use pci_reset_function for health reset

 drivers/net/ethernet/amd/pds_core/auxbus.c | 18 ++++++++-
 drivers/net/ethernet/amd/pds_core/core.c   |  3 +-
 drivers/net/ethernet/amd/pds_core/core.h   |  3 --
 drivers/net/ethernet/amd/pds_core/main.c   | 47 ++++++++++++++++++++--
 4 files changed, 62 insertions(+), 9 deletions(-)

-- 
2.17.1


