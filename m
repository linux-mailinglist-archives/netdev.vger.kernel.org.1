Return-Path: <netdev+bounces-175341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0E3A654D7
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2963A4DBD
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB123FC55;
	Mon, 17 Mar 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lge6XPld"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62623F39E
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223695; cv=fail; b=f6B0iWfif+3p6LZf3OGyOHGko6i9IYGZaArqwsHv+s6nOumP8JYxBrN2hvN9kJTs91vBx2l5eyhr/3vqNP/4t1BPpADznC5Yve8MKfqZXOrvYogKE251hPjSQ/fo1WFICASBX278UE6SsOjlNzrcmV/8CfL0yj0gc91YLZvX5jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223695; c=relaxed/simple;
	bh=5hsoCuAGxaitTsqolE3HDzmzfSsH6afdZFhH0AOL2PY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oLjyr+msqT2hVNLkPvlQliHwkrU/iwYvnf7qZjKfFCkn+YEjtqc4TlfDlf/TrOaKz7i9QEnKhxUYDN6rXp9RaaqTeSlVyy5A5Y0P7rRCYsSRE6WSgY5VgnYSwzGOlagrnnuri1qCurlCa/69vuCU7EHMhgYSxcnqCtUHto4f5CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lge6XPld; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMxsnM7mrZTsLLedzdPslJouFmYk0IiCuNJ9mmYi15KcC4AhS1q0HJAqS3XrfPaOB7W+OgaYdI8dlAidlgZ8DtvRlt8W6GuS5S7yIqk8VSfq+FwubI6GG4SonXIppGpX94IlJeNjqer3tTopIs4+mds2z3ymKkIVuLppvCfGi3Dcmk4MPfYZ2je85R+eZ7wheT/h8J1J4RIlgr88wL3ncAq+80fcO7BpmBLspcOaGCtnyWPMuJ9HDaPSSG9AsFkLf3yrfMoCslB65hT6a+LpIi0+ul4uFAOtmIvFV0sSgaiOaC72TmWaiglSwLOlmpZ1BTq3KRc/xHVTOJtq7i3xBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWprAUhkp5rxJlEQoUiSLgHXX7J/5iio899YWZzZO6E=;
 b=QGoBQIRhOu723ovWPaGNnSpYzN85+z/EnvvC9KEH4mFh6EFoGidP19SCw7X08ZEIW7HYP1b2QvUgbahoO4iqs94eQekZBGKdICWXrYzhOy3YKwOlWzk6kg1D0sw9ZXXdNMfrdd6qsSrjACzGn2+lM3ylcCSTeuxijjGqaTNRxyq5wkXrumKYnciVSeFPGFM6NNvl3zgaHf73h7Ar+V6r9Q9LrTh4Tg4J4pc7LlQC3nl74j2GHVh/UKhDyKunDSkn39TM5Ftg8RS5sojS4OdjT2bl9+CqFKzP81oITD9xDuWd8wlQhiq6DkkS4TXSV1hlsww9ncHaTXjm0+LGC2kAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWprAUhkp5rxJlEQoUiSLgHXX7J/5iio899YWZzZO6E=;
 b=Lge6XPld/k6ypqaNSHrtC2BBhjP+cu63H3zicruB5+iiOXT3agu3fMQJsABI4J4f5sWMK5ejOh1p2fUv1V7YMreHQMVqG0/xOjjvPTeh3a7KNa4bOHOI/SHi/hLEwnrCH/9yNu22AbIcqm1O/QWGBWp0HzLrPDTc118cUXYiPMk=
Received: from BN9PR03CA0168.namprd03.prod.outlook.com (2603:10b6:408:f4::23)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 15:01:28 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::d2) by BN9PR03CA0168.outlook.office365.com
 (2603:10b6:408:f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Mon,
 17 Mar 2025 15:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 15:01:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 10:01:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 10:01:26 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Mar 2025 10:01:25 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 0/3] sfc: devlink flash for X4
Date: Mon, 17 Mar 2025 15:00:04 +0000
Message-ID: <cover.1742223233.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 55892592-0e16-468c-5aa0-08dd6564982c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?waKRC5bD29+5X8PtoudSxTMQZT/f81YTj7HZW29zvdj7Vu3OYvm6LneMguFe?=
 =?us-ascii?Q?mRIBH8ETXYDiqhOyy363Ml5LiVTQGDPQ0zvgPVk++DHfWoZawvjv8HXG1SfA?=
 =?us-ascii?Q?UnArE/uAaCx+mTalfOXWKM4+yme5S7P1FNKfICmsOYHr5WWjHaiz8W3porWS?=
 =?us-ascii?Q?hmxhYJ31HIQ3MZmQxtT1uQEux93Yocap3D74S+UD71FpafYPDCuQSB7uj+uQ?=
 =?us-ascii?Q?0y751ADBQOmPfbjTWPfmEuefiVuBUSqd+eCZ51sSv5fjRFMqVRdAISKP4aoZ?=
 =?us-ascii?Q?v7qqVn5HoyJLDSmPXNciIwjRs9FWhoaAgZwNAWWHUrBaN6dzMYiyN4oUwJOf?=
 =?us-ascii?Q?zlfqxZkyJ5awqAMr6PDjNgoq20kmjwIrwyUG7ck2BG0eVgu4zeOHAPscHMMB?=
 =?us-ascii?Q?2sYQ/m7gZkNwUZh0ru1eaEAqYFY8QHxDikIRHD75+wg9VJ1S9/TG1BG+pGI/?=
 =?us-ascii?Q?RjrbAjm0HR1hmC8Q1z3DJZJif3gp4fj364JrL3h9aaSQHWR9rVSK+rAywWa9?=
 =?us-ascii?Q?+TrQMtK5AR7HdC5mmVGY16HJIOnsh5QA2K9F6GMjdDBqurWwtM82a1P7fvCk?=
 =?us-ascii?Q?ghoqUOXkf/4Bhb4zUZ7KMlBUHvQBPibNKvfNAkbBL2CCNsPzQ1Wm6+lZCgfk?=
 =?us-ascii?Q?UcitqJoZ+c5ZVpIjfoz5gs5VZIem5AN8Rg3Dm2WSiICYUzrLJ5ZZ7/WhxY4B?=
 =?us-ascii?Q?LlgdIsHIhI9mzlAjmGhngwv/wqdYd168wZyHgiOp9M3ZFGCRo2ecVaMtJcU8?=
 =?us-ascii?Q?qtL1TMsRAj1daXdBeRMvvcBifNp7eJJKBdIj39cQanxA7DxusxqhKr50tHoz?=
 =?us-ascii?Q?K81anzS7hc+UEyFmQvEI+ESjNIZBh5NqSBP7IY4kDO0KTHdgPAftkEWyHHIU?=
 =?us-ascii?Q?4jZ+UK5b6vevlldchiJQPXHv+NP6dp4EPPz5Zq5TTXNbdvM/Jdnh6TFFCm8Y?=
 =?us-ascii?Q?U9ELM59aCOq+4muI11+bNa//hu0EH/0H9+1EmxD2GdGh6ly6ts2cA73a/dkd?=
 =?us-ascii?Q?UpuQY3Vx7bhzGzhoaKTkQ+s8UdB0XsgJdwxfgeDL2SfWUoSuzvlae6uDo+N5?=
 =?us-ascii?Q?TTvibgyqbJM99fAJt924dVYE8NYWCJSnw7zAwnS3yttXSnoEKGkgpB6CC3bU?=
 =?us-ascii?Q?wo49BWCOZwwRK3LU1bIlmU0bntZD/rpQgs5jm4J23QgZHMaZSjG9HVaM3rP4?=
 =?us-ascii?Q?nUqMXZ4KlzqRMZN0e0SXJfWDfEG1cWEYpjX+HgFBXozN87GI0xwRz1zR+40o?=
 =?us-ascii?Q?VNGje3YMFL0tVO1ATGfmbJJciAaIH6MGiOA82/tRjnNkceZaIBKJIzBJfkbE?=
 =?us-ascii?Q?Ae9qDj/NUgm/5zrLLzYx+nEB3GiOQyoeAxMpcjPQ8ueCYBWXzwa6xf0HVwFe?=
 =?us-ascii?Q?a4ZO3jnjr1BG44p038xF9exlqzOx0e4VGgf6EyGys5IB0d0POtZQoYDV9cOw?=
 =?us-ascii?Q?B2bI9kLav/aa5Dckrg0US0wsr+verzpXXR/dpL2mK89Fun7u0421WlxUfRXc?=
 =?us-ascii?Q?tmqnw7Yx8Wqb6UM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:01:28.0032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55892592-0e16-468c-5aa0-08dd6564982c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

From: Edward Cree <ecree.xilinx@gmail.com>

Updates to support devlink flash on X4 NICs.
Patch #2 is needed for NVRAM_PARTITION_TYPE_AUTO, and patch #1 is
 needed because the latest MCDI headers from firmware no longer
 include MDIO read/write commands.

Edward Cree (3):
  sfc: rip out MDIO support
  sfc: update MCDI protocol headers
  sfc: support X4 devlink flash

 drivers/net/ethernet/sfc/ef10.c             |     1 +
 drivers/net/ethernet/sfc/ef100_netdev.c     |     1 -
 drivers/net/ethernet/sfc/efx.c              |    24 -
 drivers/net/ethernet/sfc/efx_reflash.c      |    51 +-
 drivers/net/ethernet/sfc/mcdi_pcol.h        | 20158 +++++++-----------
 drivers/net/ethernet/sfc/mcdi_port.c        |    59 +-
 drivers/net/ethernet/sfc/mcdi_port_common.c |    11 -
 drivers/net/ethernet/sfc/net_driver.h       |     9 +-
 8 files changed, 8222 insertions(+), 12092 deletions(-)


