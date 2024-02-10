Return-Path: <netdev+bounces-70704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485BB85014C
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131ED28D08F
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495B1149E0F;
	Sat, 10 Feb 2024 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HFIvdGHw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DF63C
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526127; cv=fail; b=LjXIkvo2yWmDaoHhursBkU1q/ntxGlUi8JpMLoj1IIwLPozE0btbezCrUR6YYRrnu/8avPUJ4UqCfiBPlb5gGNSzi8lVTe2pJZNpBuumrXMD05nQ1w53BH+we4MJqWXqyds+bpKyqwLHAxvpxtkIvq+01aufAR83etLAg5YRHJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526127; c=relaxed/simple;
	bh=xKXJ3t3sSgR44cp+6TMsvC5kNKYyFHoQ0ehocszNhx4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L+h8Lld4cyJRaXz3CgjKw7do8LHdYSM10e7e4GJJgpTgERfYO1FYA18/qD6/79JcEOXDrqdZpuP+lkySU/eqdh/HhNmIqg9EFYI94QOTQwD3Wc/zbxPuDsd6gBtKeuPxkrqWii7cCEJCWjxBp0vRfv9NAUl24wO4FEFDhGEVUv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HFIvdGHw; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZoQFTnNhru8TZEZysXroieZr4A133ZMJ1+1j+mKGdlZmtgEgcPo6a4tPiH3ZnRukP99wuL5VjQ9nLDODO/l7czEC68ypYLP9+EsG7fbJFhWMZbzFvDVhrdL6X6554/L7ad4pIiX0k+XV96bz0YrZx52GcD1Det8/m0onmeM+eY6pxjMU3b57tQS1+bh019bbgiCX/P8hMkjbV7ML6mRo+UPjJEi6uBHa4nysXebXrs1vG2iuaDqyMbswH+A0BmWAd0K0ZgHQEYVk14or06NDhq60UcZuXC5pz2Onvz0HlqM6+xG33eBhSu2eQ3eEMAno6I0ttmlqLeq/w8Uo6QnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/7lAy6jvAuD6KFZHDOW9LjXQCKDELAr5glLai7+J/Y=;
 b=B3+FrzMr9Htwr9lwCndhkVJPMljLfKhaVCiLa1lZ3OY7oX1hRfIA7NWhKyNwzGP80UM4i0YrRlwZ/LgEK1Py81hZcki6J/UoGKQZhrXL7Os5z5AnyFuvYkwOHJT1w6Wd/otN5VpVEjpnOSeTiEnZHrm2GbckYrMAFVuN7xFRHYHOBYr5ED4wLpS72lnlkMFKOrCQuCtBG8KiQ2e974AynnsSUnI/lxRyyHmXaAHq774XBJ/KMYa+r9zkfkPhKgZ0Y0wJtSl/VE9e8TOkEgcST2fwHt9Jl6VtU++lEKq7ypG4Q77rRS+Dme6PYzki7VI/EiKChJtFEeofzSBb1y7omA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/7lAy6jvAuD6KFZHDOW9LjXQCKDELAr5glLai7+J/Y=;
 b=HFIvdGHwLTYpA+Oi7wjohc0PZMH+VXrBc99I2AK1HUpMl8JrWIqbPW7ofUcpBEX7UKEQ7bdLJo5rSctbfi5nKbx7HnTw1ymhnQ232XLYZOtAdMHS8c0X1Z0urVuSqHHwJatfrRcxafzFrSIrrtmZLMmVeOYd5mEF4XwFIe71PR4=
Received: from DS7PR03CA0314.namprd03.prod.outlook.com (2603:10b6:8:2b::26) by
 CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.16; Sat, 10 Feb 2024 00:48:43 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::8a) by DS7PR03CA0314.outlook.office365.com
 (2603:10b6:8:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.32 via Frontend
 Transport; Sat, 10 Feb 2024 00:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sat, 10 Feb 2024 00:48:42 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 18:48:41 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3 net-next 0/9] ionic: add XDP support
Date: Fri, 9 Feb 2024 16:48:18 -0800
Message-ID: <20240210004827.53814-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: cad4d8a9-a8e4-427f-e56b-08dc29d207ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p3yTeVwmckTtARj9mxEPlfUr0naFqYqWug8aSSNytZNtmaRfApmuFXzsVeo1yLbcXYuLUVgurb0nz1ujyKyFMCyDqiM8Rr8ttKJ30Hz8vYJyv0IpdEWvVlUpCogGRCOcZA0IQvpvjTlFqvHJFlFgLw9gqpRz+gOWlaBWCYiPnoK8UCpX/QAfqShnBH+Tal4cV4oZbGYDqH0zgy92fTDzloiHvH3RIXt/1C7P3oFVDXT66PdNvfBc3SQfLMV5W6JIzd24oU2cx9HyjMwbq3zkc33BOtmSegdIhpSIda6qPsKsJ9ck5O6lsneuND3kfizbBikXJAW/kkE+K0Pevz+OtDjSCHmrwzZHr3uDQFujAkG9AC1osmBq5vt90dCOr9StH1x0EDvJqPBHfG1NbbBLTxzSdeWeHkEee521IMTrxJ79H1FFE0QNwtjOyeniVq4/K28Nxz6rG3Yakq/rXU5sKBeu7U1PTLjyyV0WmvU+MuSTcSvhECLMo8w3f9OyO+vXHMiliGZkKAIK85ayCm3lVns8HovHa5/3W7ZxcTlmyFBaU1DM7rv+/yrsGvivw9bekR3aBrnodoGqk/aL9gVgkWSF3bznORo+EKz3dokpqKjbW81edgM+ypaVAVSMHS5l
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(36756003)(966005)(336012)(16526019)(6666004)(54906003)(81166007)(5660300002)(356005)(2616005)(70586007)(44832011)(83380400001)(478600001)(26005)(426003)(41300700001)(70206006)(316002)(8936002)(2906002)(110136005)(8676002)(1076003)(4326008)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:48:42.9544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad4d8a9-a8e4-427f-e56b-08dc29d207ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529

This patchset is new support in ionic for XDP processing,
including basic XDP on Rx packets, TX and REDIRECT, and frags
for jumbo frames.  This is the same set that we posted earlier
as an RFC, but now refreshed on the current net-next.

Since ionic has not yet been converted to use the page_pool APIs,
this uses the simple MEM_TYPE_PAGE_ORDER0 buffering.  There are plans
to convert the driver in the near future.

v3:
 - removed budget==0 patch, sent it separately to net

v2:
https://lore.kernel.org/netdev/20240208005725.65134-1-shannon.nelson@amd.com/
 - added calls to txq_trans_cond_update() (Jakub)
 - added a new patch to catch NAPI budget==0 (Jakub)

v1:
https://lore.kernel.org/netdev/20240130013042.11586-1-shannon.nelson@amd.com/

RFC:
https://lore.kernel.org/netdev/20240118192500.58665-1-shannon.nelson@amd.com/

Shannon Nelson (9):
  ionic: set adminq irq affinity
  ionic: add helpers for accessing buffer info
  ionic: use dma range APIs
  ionic: add initial framework for XDP support
  ionic: Add XDP packet headroom
  ionic: Add XDP_TX support
  ionic: Add XDP_REDIRECT support
  ionic: add ndo_xdp_xmit
  ionic: implement xdp frags support

 .../net/ethernet/pensando/ionic/ionic_dev.h   |  11 +
 .../ethernet/pensando/ionic/ionic_ethtool.c   |   5 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 190 +++++++-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  13 +
 .../net/ethernet/pensando/ionic/ionic_stats.c |  18 +
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 456 ++++++++++++++++--
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |   1 +
 7 files changed, 656 insertions(+), 38 deletions(-)

-- 
2.17.1


