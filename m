Return-Path: <netdev+bounces-74620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0255861FC2
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 23:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52C51C23804
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8414DFDF;
	Fri, 23 Feb 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w/WmY0wu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C5614DFE5
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727281; cv=fail; b=RBOFjOToU9FAcHoMmM5Xb7VUlPbsA8yFVI5E72qi2VF9/3GeLr/oiM1Nv5vgtYVNGE9XwMRcbQFE81hhOA3VUoOeSmwQQiCcQmqb0Pd3nDDs9xx97nQcADQoSEmj3UC8tpliuINVPsLKOG4z60BBuK+KkjCH35bz+gdvfketGME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727281; c=relaxed/simple;
	bh=9TyuwoidErGLvgR/JSdJsSFKOigdsCDQQDmc75z2Ftk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=owciIALM/+dErXlvrCe6SsY36c4iBYSZwSk8Gbck2cpIWmJsYXs5uH7HQfL2+WheInaeUqT98eU93GHhqJ/MTY6n3Aa5/TKTVQvw53Yqs2eiwQ9pvGrV58N+7pbsxI0+mVfPNmevDo2bqj/tj83pCP1td/+F1MjGgqPwe8iWz1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w/WmY0wu; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4q5nhqLBphJH9Z8CfVjdUQ020Nu+km2rgG/EF8yvO/ZGQ3tGl85JyT3zE3kzX5H684h7T6F1Jyo2yVVVfz/Mkxjn4dhm67kyMUR+a1rwTXOQHcJSZp5ElDt/YuI7yn43x/jJFc09PEhOrR7dyYM6PvCA5HsShPKH7PJa2IfoJ+6Id0i8uFMTsiHNHAs416WneXNmkABODqJq2H0jXn2R5xGikjw8WWSUby3GiAoeYzQaeryy3D6LgJXwYrzX28/0/WE2BFEZpyfUkA/Pz5UqWKFzrheb2ktr+6BT0EcrdgZ1duI5RP3nRtAiYyrnva7kU/EJ06Vo1qrA/vkNXiKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLzGF54wOYymuWMKQwg32XWTJbC+8YNayMBvYQ9MmIA=;
 b=CHJcqdQDGS25sPLwv5WEuXFSedlJSCNltZ6NYaCwyiFBhrFYLZfDLU9fuii8ki4lHaVnczA2R1HmaPuGRfzeqK033axzwW56PkPaKr/RG10nQnCvNIMYmoGfPKo1eltagpryJJbB76Z8Jm1STSoO4zrGTxE0bRMAeb6d0EBqQP8BDQ1Z64ZuCfYLaZjpcB/hMyUBIQyO/mlozsgfYOE93KrWHbsPY2FRTU8bNFWbpte0isiXCBvmD/ls8+Y9jZsbHVqhmxWbSiZnzQHZdBe9/2alfoxMqEywNsJSulEHo7m6LQU5RTyLHbC2BxNSyEEzDs1nDyZouc1oqMZpWSbGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLzGF54wOYymuWMKQwg32XWTJbC+8YNayMBvYQ9MmIA=;
 b=w/WmY0wusQTWtvmpuijgC3APGCPZ1tmzh+tbJyUeGZ1/mua0xD86w2Fi3kjIp2ug5aeSPUDpyWcXFWFBRwZO9BHwT+KB1GLJM/aUqhITx22hisuI+2sfTtwFD4HhnTq/hUEdWmwemvnHJW26F6mflJJF5JYchCzG0IbsrfYuYyE=
Received: from SA9PR03CA0026.namprd03.prod.outlook.com (2603:10b6:806:20::31)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 22:27:57 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::9e) by SA9PR03CA0026.outlook.office365.com
 (2603:10b6:806:20::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Fri, 23 Feb 2024 22:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 22:27:57 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 16:27:56 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 0/3] ionic: PCI error handling fixes
Date: Fri, 23 Feb 2024 14:27:39 -0800
Message-ID: <20240223222742.13923-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: f07505d4-bdd4-428b-b5a1-08dc34beafdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lUpWW/rEeh7thG8pDihR0upebGjvTB5e53lWaed4WISW5Zzx88vFd19UNKt0esTMAi+MQEMTTi6L6uRsTOUNnpHMNMqK+AcAKgyAOMkaocvX73f10U0eiHiBY7rxrBh9t3mh3rW8GeZqTp/R4U78GPS29+0wIO0joQe7c04HaUDygzwEYQg9jo6oOoq04Fn/YYZalbB0o0t9gop44jnVOv+QeyC5kHximNuvcsQeQiEn4B8qSBUcS+lkdmuGeh+4dJgwowbQynfOs9n97Ryk3pvwX8ANBYpSfqA0T01kdIi2w+ptA8sjAizOCEti7NO27urdNZIMKWK4r5ybOQhfgIi2Iqgi/tsiGYS2AD01V6yn7kRsZ0BZp5Q450ZzHuIMNBjYrBSrSxs8V6hJgmPDmCkn1wV8PlQFnlkuEQRiHG2MORZzJGr1W1u/SC3uHzf2wffIX+MsokOVHU4rksgBci66y7ZYib4vDk8+dNajYH7aGWc0aXc+0f5YAiyVyv/OkbkVAvd6+DaiXC4zEX2o++1MHbgG8Np/GPOWOM1UlviCauQJry3MAjJf8QGPCzEr0qRNLeMImlZKjipUyBh4oThJZkybXfU8iptOu4hGWW1bbhhVFtUxo1x/h14E+GK+egDomFuB28rhDMsvgUIZLoED0H0QmafWuneHbpKZRFM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:27:57.8091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f07505d4-bdd4-428b-b5a1-08dc34beafdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175

These are a few things to make our PCI reset handling better.

Shannon Nelson (3):
  ionic: check before releasing pci regions
  ionic: check cmd_regs before copying in or out
  ionic: restore netdev feature bits after reset

 .../net/ethernet/pensando/ionic/ionic_bus_pci.c | 17 ++++++++++-------
 drivers/net/ethernet/pensando/ionic/ionic_dev.c | 10 ++++++++++
 .../net/ethernet/pensando/ionic/ionic_ethtool.c |  7 ++++++-
 drivers/net/ethernet/pensando/ionic/ionic_fw.c  |  5 +++++
 drivers/net/ethernet/pensando/ionic/ionic_lif.c |  5 ++++-
 .../net/ethernet/pensando/ionic/ionic_main.c    |  3 +++
 6 files changed, 38 insertions(+), 9 deletions(-)

-- 
2.17.1


