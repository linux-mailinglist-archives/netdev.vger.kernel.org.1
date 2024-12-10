Return-Path: <netdev+bounces-150780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3FD9EB89E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A721888D33
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715A31AAA1C;
	Tue, 10 Dec 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jOBqjq3G"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073486333
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852931; cv=fail; b=ldowcuLxUYg9+T1vTEvkKOn+b8mNiVcd73+QFjDhUPS80YU7w8FQBLuv2G2YFVhLpWm88fnAeJ+DxBJYYSr0pCyenJdYn8ElQKJP0G8mEwe98qRsZmRFlqw1EoDecCC6u0NZZ7lFTY4a3926fTa/N2EJ5vQZfV0Wf0gPjZolQ9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852931; c=relaxed/simple;
	bh=TCFGao7ZODNfh3s2pV1t0utECX+KPJiVMl/lv0oH8pA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LOhPb0AiF9sB8kW/r4G8t9Fne4wm10Ebye6zP8KhlUuEB6J3Yxlsbz5M4xgW97VU8IUK9PvflnE5hE3KVFHtLGXcte2DswliyEes+LKix4mYlPk46ZiaW2oCuDvEoGvTzuljA7M0pAmoPcf1SHtS318CZCkZZySmoKBd3qQ0aaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jOBqjq3G; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNbyuS4hTNirVRRUPbV7U79GqXomT3R2nWKYi+rY+Y1Z1yy/6ZahguwITMinGg9RVXnyLUaNnyaRj4bv7IkWwEQajikpZptybAD+Cmpp4Y8gzaJjavnl7MvD7ybOS7vkf91bqSE2TzlSomBr8pQBsoNqv86fxJCRl1iRa50tksv8Dldl/LZ668vrV5hu3autvB2GU72phphoSJ8PzJn/2OujdGRHAbAYp9cX/ofRTnyGTf027C7y6ZseXJ+sknY18JkYuutuLUeNG1sgMGuU1mjAny6i5GDy4FkqVrWm8rfuS25/6etPNvNKepSU/SdRkOlc4DYLsf19gWu06kklGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf3j4kOm28DjxTYVglyomcR9DQ/YdOPWM6NEN6oQNPg=;
 b=S29ZAW77vy2796HxHhR/Sipn2eQYQ+epqHrmrs7mJ3SlP8kMIZsJR3tCSAtp+rNhcJmiJjnxf7tSp5i8kxcazMD+tlJ+iEtSfugfdp8Cvl48xIBWg5AEzqE3QLliOQJaiEBKIAmdaNeezQy7+pvIY97s5tXMrU+OAur+18kSRY38gMZ9Ang7YfXpSb/DS0s70cQDGIfypQVw2WPng8cfdNdOM39SKwyS9SibuBqOmVEDtUz3Uti7V3tjY0mlhF4bJXm0/Rb6jDfqm4S2c35lvCKx1j7OHa7OWvrauQITstG6g9jbUWAjqUtyUTRlB29De9FenOgZzeMST+iGaupE2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf3j4kOm28DjxTYVglyomcR9DQ/YdOPWM6NEN6oQNPg=;
 b=jOBqjq3Gr7J2a0wiYDH7UdmIQc0ZGaYINlyeuJaz0WreWZzedNB/GOXYk4vA9Dro3ZbtKtsjfn74c9CGUm/UK102/aqu7hZILZyAZS6IWBZSqNdsVBGfKyLm3Cy/IVIxQ6GToIg/sBnsB7Lt279HihGhnS1ggp8cpX8kGlFB7MQ=
Received: from MN2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:208:1a0::20)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.27; Tue, 10 Dec
 2024 17:48:45 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::c) by MN2PR07CA0010.outlook.office365.com
 (2603:10b6:208:1a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Tue,
 10 Dec 2024 17:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 17:48:45 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 11:48:43 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 0/3] ionic: minor code fixes
Date: Tue, 10 Dec 2024 09:48:25 -0800
Message-ID: <20241210174828.69525-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 5626d893-2d82-4471-371e-08dd1942e4a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dOVc11mN/syfmHH3vGl2CTn/BF1kTeempG6Bkqwiz2l8hSGirUWHU21Yui5S?=
 =?us-ascii?Q?YzznGAQUkMb27lpaDPuIcpAToShJSZdTzF2FolAqfsfp3vunbwo/3uI6jJYk?=
 =?us-ascii?Q?zfcQkSGAptuaVl1UBOV0upOJ8DX8QK2yTah7B0J7YSoTh4+5T1ByVh/r3J2M?=
 =?us-ascii?Q?G0EgCgtgkcP/nVa8vdANnS6jszr5rLY4PWIZxG3X+AOiopVvclSQr0rZtJmx?=
 =?us-ascii?Q?9ARKvTpiZyqJ3gPOEnueBNyJcaTj73ZqPNds7xo4EGZacMIL73CX0jkveoid?=
 =?us-ascii?Q?GLb2Ee9Lk8zcny0o/O2qv3bwAdUYfwNp5ePVwMzudiSZ7BGcxWf1AHg3keLu?=
 =?us-ascii?Q?i4+8BD9x5h6yNWbEqj5ETh+63ILKBuyerG57XsuiKKQ6d0nAuxlyAFpJjtRn?=
 =?us-ascii?Q?r4HyDlD+IHDPkVtghxaryJtXNUx4b0SZbSBJbHL/IrkFRwLQwarGK2CVfVtx?=
 =?us-ascii?Q?x4K0wrXtpPXDWPR+KYaTEtW0VFPa+Zs3/iDySq2e47DxdHYB7J/Exv8u9RV4?=
 =?us-ascii?Q?nkiDCHcp+XcWrwo/dUNPoqhJZxxav1fEhEmuoTq3q5BO1CAQMD2odz6PDBFd?=
 =?us-ascii?Q?AnzsV3Y+rpzhxkEVg6+yTtAT5MUlVZWB5W9B5qcnt6T0mqmDKMY0Nev753Xp?=
 =?us-ascii?Q?DjzcEDMMDeVVEbLBe6Py2SGuiJ5DqX749RezhIUCk7RTS+k92aUz9yih0RJW?=
 =?us-ascii?Q?51ByAWSc6LUst/3PlSlkAooRsgbUd1aOsAYcNVsvGyS85PSKvky27Tmi9Wku?=
 =?us-ascii?Q?pr7FQXiTlnUOOgmtgC4eY7JkyhDsZSGs2SGnjCXigbEo3vQEmraqjcEgXsEK?=
 =?us-ascii?Q?NsHy0NhwtZ9LhD83nOY5cwqyVgdNkSHaQhLfGhsr8Db6KGhXInuFAUDcVwuF?=
 =?us-ascii?Q?egKJFsIbOIFByoPUtl40Ct2Upp/1sk094ZC4ogKXjrfEif05oxdFyeqDh/4X?=
 =?us-ascii?Q?jQCX/ncjqeDyI47zdzSr5Fy0pWDyRqeVi9JmHt5T3Y8b0xLIFfuyE8/Lthun?=
 =?us-ascii?Q?PfxxOq++SqPDio2ki0CwYKtWGi7gkmKv6E1oYCifC182+F3NpZyuedT8L0wp?=
 =?us-ascii?Q?JIjf0bsCnxSMjZ2KsDP0EaPfqfu8smVoiyfHzwN2iTA9+kLB0LtobbTxmFlM?=
 =?us-ascii?Q?HArEPTHp/i97ia2ZbcOcElBxu3YqqZPthMHsWDTaCtKpPivP29Q8CTCL8s6b?=
 =?us-ascii?Q?+SudcEk+/lPXJd3n0JmjikYWg9NDdXzqf/ecsgrNbL28m60qrSq3LKnB3x4m?=
 =?us-ascii?Q?pqoUsaZp2iyV76KsvxcEyNMYgfR7NHNUGXH9eDFv4os39bGMAWR3BdRIW0ma?=
 =?us-ascii?Q?XglwYecb0vonSCyaQxX76OBISetor7DA5Bh6S/SBCC+1ya9D0Y2Q+JDDXW7F?=
 =?us-ascii?Q?pj2RDmu/h1tvbfaEqbLOS6bTwh6+xGVuPTMfFBiQ6LI/Rubt5rAYNn2vcfYq?=
 =?us-ascii?Q?+abboCM8IEkEJQziyiNLgA+8GOtAZytK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 17:48:45.0225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5626d893-2d82-4471-371e-08dd1942e4a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770

These are a couple of code fixes for the ionic driver.

Brett Creeley (1):
  ionic: Fix netdev notifier unregister on failure

Shannon Nelson (2):
  ionic: no double destroy workqueue
  ionic: use ee->offset when returning sprom data

 drivers/net/ethernet/pensando/ionic/ionic.h         |  1 -
 drivers/net/ethernet/pensando/ionic/ionic_dev.c     |  5 ++++-
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c |  4 ++--
 drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 11 ++---------
 4 files changed, 8 insertions(+), 13 deletions(-)

-- 
2.17.1


