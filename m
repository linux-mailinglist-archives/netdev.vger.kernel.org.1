Return-Path: <netdev+bounces-167100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D21A38D49
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A9417148D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C53C238D35;
	Mon, 17 Feb 2025 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W/l6cije"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DF225798;
	Mon, 17 Feb 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823930; cv=fail; b=N4fdQPI6QYfzQBOFT6SaPc/Im/gvtIM27s0F8FbR04kXeVR5Q5NW5kKjZsxIVB4Elc2RwjdSkwjp7VyrLP2bU9lvkCPYFvYlbhwXC16x1YNVRB0b8NsQTXmhWYvx+MV/yX6uUfQkrI7qk+N8C8Dmp1KH1e2xO7EB4fYAfEd1sEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823930; c=relaxed/simple;
	bh=nr7EsV+q4C7UkAVa0dVWqMZPrFhgIdjrAqrWk9p2Ntg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DOCCVwwEy7w9noAoxHguLrNrq7oUOvHgsWWdWHmod9kW+nd1Cng1ZqhhmCBXC0K1VrgS1Lu/0K/0RNjKZ4dsQ4hdRD9/RZu7uVKMutqbPsNFQqTwTqrAP6iYYPNJxu/Bk8NREUDE8sM1AsrEHPkq7AkYsDl6sc4iAkX9X7EVTiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W/l6cije; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc4P6BqceJS3THumO740/gLnteMoJ+uB19hNfLI20TObJwdNUlqr087SJAKrdnKQxcpaASH8pW58vsjfkvYD8dUH/A+WzhipxmQ5pLuC7a3c4tPyIJdl8Sp1SlhlxwsqKpS7FS2QNCmwA7BQ5V4cJGRhHTyQOYyr+MPCdvHTCH5aMzl/xnLz63IJ53iFI4vSExMFG9ky6LLbS8UNSSk27lrVMbuuPgcFfSJa/Xzlo9vat6TpsTaSA6E8ul6vftQDVM+4OYt6DiFyUoG9qpq1w/RjeNsFnPkkdRFfioaJYoVGxkXK85eC+T07oaCJPpXnMiwPNJTrQ2ez+Tuc3n+Ojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78B7cm568T1iQIlQxyaQokoVNt96nBOkSkk5vQsBDJA=;
 b=bqy6NtTH5Sr0n8PrkvLgamf0nfaieZrBwkLuPgXzkBrlvFDeYfE7CchePrltor9A/fRi9o8/eLooT+6XTeubz2PLQSms85CkzJUlGcA1wVIrIMB63+c6el/vllwOcXyV0HIelsYYmS1TdpzyRdkSFzLKYcpyL6Gp785JO2ukAEObbYNIN4aLBh0AWpr6V4dWACeVP8iEBdtpPcxdaP2th2BIJbhZmdACcjD4+3oc/gb19sUg4nneUV8J9YZPzArnU/EH2acweQBbg06QR5/YVnM5yBLN4aW2VGIP2zg/d/nzG4vgXKILHJPOXgHpw+UVocEABMlOUDTfLqOGpi/9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78B7cm568T1iQIlQxyaQokoVNt96nBOkSkk5vQsBDJA=;
 b=W/l6cije8bCQwmPmwdlcdeD3TrwErhPul4sNmjgpkOcsmZEISH9G2mTOmX8r62gGMFL9MuGmvydo/3hcu2g0Ifmlb0L/ezFNZRAkXBLoS9fJM4Ec8xgGV92+5hh00vD1AUAiysCuBFBaNaIk5CCcenZa0E1PQg8Y4w3qWbBmzkSlCnq+wG79oiJnIl5loH7UQ9RqClLd/09aeQ8xmcAH83ba5I6yGdRB9xNl6cU/gOeb4Azup4xL2ck72lzv8HVDvc7mB6Vc1+/xkkvZVTgwDxkS0DrTQ8W0s3ECv1qScWz9peb+ULdCDaSMWtaXTlTng4jELSygUbl87081nyGkhw==
Received: from BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::10)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 20:25:25 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::dc) by BY1P220CA0015.outlook.office365.com
 (2603:10b6:a03:5c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Mon,
 17 Feb 2025 20:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 20:25:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 12:25:09 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 12:25:09 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 17 Feb 2025 12:25:04 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, Louis Peens <louis.peens@corigine.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, "Pravin B
 Shelar" <pshelar@ovn.org>, Yotam Gigi <yotam.gi@gmail.com>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <dev@openvswitch.org>,
	<linux-hardening@vger.kernel.org>, Ilya Maximets <i.maximets@ovn.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next v3 0/2] Flexible array for ip tunnel options
Date: Mon, 17 Feb 2025 22:25:01 +0200
Message-ID: <20250217202503.265318-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0bec11-b14f-4c4b-c48d-08dd4f91363c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vEtZbEXgTblLx5vke+aoguwe2xAQS4kwfUvc+Mm4BPH/gsoUZ3IvI7jNBXiL?=
 =?us-ascii?Q?c/0FR9YcmdPCFqM2wawsYh+2lgD3qkZCt6fkTJoOj/LrrWZKBClUF3I7rZEJ?=
 =?us-ascii?Q?/WOCUDQM9ywgGEHNASpXVkfSBAei421costaYqRWEMCjni9QIFIe3P1Rgg+2?=
 =?us-ascii?Q?riQrAY/v7gUyOG868ASfdgsUIipXmH0rh0CC+s2kUmD/JYlHQmudU3npwMvX?=
 =?us-ascii?Q?mfayQumuY5tiRH+IXjJzFxcSqhX7Zya5WZMeBh+jNX2BET+jcCxhJaC6biZV?=
 =?us-ascii?Q?S19c7O7adfBhRenG1M1mU4p4Xqm+CtPqB+aaYy8x+41OfnmPZngLz1BklVSP?=
 =?us-ascii?Q?C0qpRlSVY8AQUNaaMQNGp2oCYto6ztfQj5s0Oma8EoMzToVO8x2ciVijYq9F?=
 =?us-ascii?Q?j2IlExSrrIpqqpD+urhx92wUFd43BsDFCEyDc2PkCsdjkz+k515Wfn0cLQtw?=
 =?us-ascii?Q?T3euAq54B83T2VR4FdP9zFY231Itlq1c2df6ywiafLHxo+rraBXTfeEmaTqA?=
 =?us-ascii?Q?VSBdeJdwV7B9tWTlBXUNF2ECRQpp0NOEWC5yuAEtFhwQk4HR13PKL8eG95na?=
 =?us-ascii?Q?WAFMOZGFKdCDWFYEeZY35fToyTTCCEdUaOzB3yvUDmJdE089UezGxyG66EXD?=
 =?us-ascii?Q?rtPeVoaR2MKRVOZYdTqyn+8E57ftISNoDTovSumyGVF7BdZdBXV3Y36dRbey?=
 =?us-ascii?Q?prVAK9ruRmEG9zC7YhXoAWg2gn0Lq1L93lArQI1Ub/ESWqTUj8J9OjWkZXx1?=
 =?us-ascii?Q?q8zTXTfpKp4mPvDx8Bfwvad02gYUWmqku8w4nWLJV2Wr0REXAeW9eHzbKDgo?=
 =?us-ascii?Q?6v8uwOP5lQ7dlV7HqG7Yk4PrSptxDO2HV6LzRY8rjk+ALZtqTXubPM1+WNjy?=
 =?us-ascii?Q?lngUntOFtrk/MzJ5dKRBMzId+JNRA36hC8sWSswBEHa7ET48cA3I3VjuKE6B?=
 =?us-ascii?Q?eCssEVI6RzmCeNrfRs8EzXFQSgPmTk2vxr/zF+a4ZcGEeIVqkejApMAUuscG?=
 =?us-ascii?Q?EnMK0tTnCykiPiAN6Mq9MyPnZOLq5bL4vRtEWeBF/0BgIai2bYpIVcOYVNmb?=
 =?us-ascii?Q?3JdXjR5rG5PZNrmPgaeiMF2/+ONc3f7uD2chFZ84fOPf+jXhjAcW5bBgkv63?=
 =?us-ascii?Q?1JEn53HZBi8k2nqodmuqqKDz1qWw4i8h4LAQSW52JeXKkKjlvVONZpsMIJMP?=
 =?us-ascii?Q?40De0YgoAc1Z5UezNmyRirFdL1I4qKtSrReR6jtJid/atK+ZFfoNXB2hq4SM?=
 =?us-ascii?Q?CwVbf2dQMQYpZG0Xvst9ka4KxrCJxEiJ4XIk41uAOOcdNUCIAcXzgENzlG64?=
 =?us-ascii?Q?AYVRKeKvJVhpYyCPRAd7Q8LYpvSaz1jXIbZY8/DHC+H+maafWItYeyUUubhf?=
 =?us-ascii?Q?eKMYlZW7Lsn8SPYpvS0PwzRtnfeTu6ITCMD9ea+0gwdYrqGfpKoSdHKBCGMU?=
 =?us-ascii?Q?IXxS3kPBU4Ukn4/cPJmKP8+bYB9kTownbZQKO4rdIPVHYCLZ+mRorGx5ZO18?=
 =?us-ascii?Q?zCrAbDLsS9XkQVM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 20:25:25.4814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0bec11-b14f-4c4b-c48d-08dd4f91363c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833

Remove the hidden assumption that options are allocated at the end of
the struct, and teach the compiler about them using a flexible array.

First patch is converting hard-coded 'info + 1' to use ip_tunnel_info()
helper.
Second patch adds the 'options' flexible array and changes the helper to
use it.

Changelog -
v2->v3: https://lore.kernel.org/netdev/20250212140953.107533-1-gal@nvidia.com/
* Add a precursory patch to convert hard-coded user of options.
* Keep ip_tunnel_info() macro (Alexander).
* Use __aligned_largest (Alexander).

v1->v2: https://lore.kernel.org/netdev/20250209101853.15828-1-gal@nvidia.com/
* Remove change in struct layout, align 'options' field explicitly (Ilya, Kees, Jakub).
* Change allocation I missed in v1 in metadata_dst_alloc_percpu().

Thanks,
Gal

Gal Pressman (2):
  ip_tunnel: Use ip_tunnel_info() helper instead of 'info + 1'
  net: Add options as a flexible array to struct ip_tunnel_info

 include/net/dst_metadata.h | 7 ++-----
 include/net/ip_tunnels.h   | 7 ++++---
 net/core/dst.c             | 6 ++++--
 net/sched/act_tunnel_key.c | 8 +++++---
 4 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.40.1


