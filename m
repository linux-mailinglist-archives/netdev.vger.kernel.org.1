Return-Path: <netdev+bounces-70051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA20284D758
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E325C1C23848
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3FD3D6B;
	Thu,  8 Feb 2024 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ie4BFMS6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665611E52C
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353872; cv=fail; b=jdQvUUwHD8wF7ljIl0yjX5yacBE3EHQF2f5zXpp1Wr5tXmTPkJzsfKo7Pgwah3TGA97Hpv18c/LV2nW98ruy2d8gv3n7i1jj1TqraU9hlpIXiKJvs26kB39VD7wjsgThVDwSOd+mFVrblznRmiaBts/ogdV4w7mY//FltYXnAzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353872; c=relaxed/simple;
	bh=ZPG+r43xGwh9GYx2k+DVv7b+tnl/OBlC1zTVAeFaxpA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QypU0YP3vXBm34KmLnD7tA4ADpHtYWUtz4SKUVPLmh975uJjNVwhlz/otKRvAEFInFSOMMqSaAdmk6Zkx+VTCkT8T6vYeK52V8xzki/CQGsj0PSPXqPpiM2oBq1AW7Ok+oGSBIxYLTnjHIVZwtdt/+Qi08w1zZIvbL3SoCTM9RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ie4BFMS6; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVd8VI+370iwWn/nsUQuLJV1aq2GCk+HOzB46epc6knf0gOdrmobFZ0iW6TI7fOfyktcvEWgcbYnO2/+5nFzPEW8jXshJD2VJlWTKavoDBuT8HkTzpqrRBb/DEcUd2spHgbYbMs0YmzP6a6H4kAh/RMx6B7FnjZhUPUMi8bvQqhKYUgnvMV9yt+nMJfJIv9d4/BTjoFknttr9aPUOq2nw5xthftmNn9rguY22/FSoxls2djDGxAR26v2iJhYNlwRSV79yp5F58BS7FpcM0BfhOwTE85EfxDEp528M7nzgq4ha8aV9XHyoPlOPPEzFlr9k2Q6xKvVNwcNfVMdQguogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojbSN/v7NjxBnD/cDkZaDmRuthdScIsRyHdtZ/7WF8A=;
 b=JVZRez2cVrfjU1PJwy7EhfSUy2FHvy3HRXhmLdWJogzeeQ/vzAy4znfHRH3FO2i/ty8hPqyPcfnNTombfay56wx147mttrxDHo1lLYpZ2ZX69fd3bK/L3/FOJxvSx1h32GX1qIsZSnjWbRD3RDijmbkZUogYzqxmqA75PSjQPe9KyEWbHuV3j1dADj50nWNreTaP46W+K8Jq/pN8Jqx0cCGhv8UA9xwPmR0Fxzx7gDdgQwU8P2ygzRumuNooDpmp8DREHn3lRTMUPmzCVSyWCtAxWqSF36LG7ViaS56L5H6H5HZcyf8lw/wO9hW45+VpDkV4uPyOw9BIJRxXEbRSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojbSN/v7NjxBnD/cDkZaDmRuthdScIsRyHdtZ/7WF8A=;
 b=ie4BFMS6+ph20P0SsuC2Tu9rxfqPG+lbIcsOODb+Jk/fOvzSFqknMhYSPHI6Qj9ctL1O3RlabSX0gvVqqIN7V1V4wWXRHz5bXkY8DbwfGQIRIYnYyZtC7jrH6yB/36CWddX8XIUfjeS6MAxZu5Z0HFqnFNESF5bwBj1cLldT0ig=
Received: from CH0P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::26)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 00:57:46 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::dd) by CH0P223CA0011.outlook.office365.com
 (2603:10b6:610:116::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Thu, 8 Feb 2024 00:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 00:57:46 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 18:57:45 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 00/10] ionic: add XDP support
Date: Wed, 7 Feb 2024 16:57:15 -0800
Message-ID: <20240208005725.65134-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: a113cf16-b2d3-410a-d131-08dc2840f6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Af2Jv1bLds1E79BxeDglroHWn2C/N2e04rGrFFZrbP2A+1YNQbSLlc3E+3YtxiHBroW7lIcK4E0QlyApLzuud9Et0PR4w0zZgjRQsfjWQvW4bNPaEhBSNsEMPNRxtfTYicGPUtIi/kkYSvrZ+SUxrb/+nT9u7kXtlbQTZxxH09bFb3GWJ4BFAV2X6Zjgz6kFMxQTZZ+WSQac6v+h6GHqyvHMXhI9iidXr7b5dqTYTUyqZhZ9mvoSEV3gvuEe8Gv5VNe6JFS45Z8kkzrnsANkQSnb9T5hHb9H6H8uvwGVfkOenP7/RPoJtHu6pY4wifZd6GHtlPSE8x4WeIkcLToLDuKoJg9BBUn6DGOBpzCKBpaH+Fr6k7Re+5AqiXzedmqaA4vdBnnhGiesnM6LDYMvIwS1+Fn3Q6DfUKz3uMWdsXeXrUsoCyo8Ojsy+qifc0OXa2UIrdPUjj2Gyi3PsR3dU26LZoucmv9z1p2KpXNE+CHAiy6ZhOa6IOq1cmmmCUAqAVft6vzG8WQh0RpY0CoMJ/LbJLMgn3prHtCSglPD0N+UKWHSf+quqz1nth0jdNmsu8qF9oXck8e9N3N49eNCPw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(82740400003)(110136005)(54906003)(83380400001)(316002)(356005)(4326008)(81166007)(6666004)(336012)(70206006)(86362001)(1076003)(5660300002)(2616005)(16526019)(2906002)(26005)(478600001)(426003)(8936002)(70586007)(8676002)(44832011)(36756003)(966005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:57:46.3933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a113cf16-b2d3-410a-d131-08dc2840f6e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097

This patchset is new support in ionic for XDP processing,
including basic XDP on Rx packets, TX and REDIRECT, and frags
for jumbo frames.  This is the same set that we posted earlier
as an RFC, but now refreshed on the current net-next.

Since ionic has not yet been converted to use the page_pool APIs,
this uses the simple MEM_TYPE_PAGE_ORDER0 buffering.  There are plans
to convert the driver in the near future.

v2:
 - added calls to txq_trans_cond_update() (Jakub)
 - added a new patch to catch NAPI budget==0 (Jakub)

v1:
https://lore.kernel.org/netdev/20240130013042.11586-1-shannon.nelson@amd.com/

RFC:
https://lore.kernel.org/netdev/20240118192500.58665-1-shannon.nelson@amd.com/

Shannon Nelson (10):
  ionic: minimal work with 0 budget
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
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 190 ++++++-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  13 +
 .../net/ethernet/pensando/ionic/ionic_stats.c |  18 +
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 465 ++++++++++++++++--
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |   1 +
 7 files changed, 665 insertions(+), 38 deletions(-)

-- 
2.17.1


