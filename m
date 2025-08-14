Return-Path: <netdev+bounces-213701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3244B266A4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3C45E46A1
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B1303CB9;
	Thu, 14 Aug 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BaBIrtsh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747A303CA3
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176908; cv=fail; b=GNtX0/X/NYMrGcNUloZuZVC3tXeddd3UzvRNyPuZs3QjcA0iQHfNbCMJzNgBGsS1P2zHbXBT/E0WMm/VyKOkiuNjnXvi3UEMUUoxktLoMc/Rnpn9/aaaMouq1G3OMwZnBJd13Zz/ggZEHVE4O6wefcF/VQquJh/06VYfYfT6LRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176908; c=relaxed/simple;
	bh=6HebEbvs+vo6uqahVZlkTtdAnitwGUDxSUACuPkUGV0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MSFmgWSZJBpQQsNPQcPTI20instWjS2ZDnqk550T8SHEwgKRj3UIdkWcupXKn8WWv5SP5c/tWZXQNClcspWMnfKGILwHjjsBRKAZD9o5vlwQkSKZbshBml5c4gz2dulbQV0Ck05q+8IkUBrxz2Zs72HehUgqWsZ8hBHlqmYSrD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BaBIrtsh; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8KhDWgQ2BpM3kSYNeML4yZVkrEViZdlEAdss0WgNA1N3FSspIOMSLiDF65Kluh7uDrYPKy0D8IZHlkfNHVDub1useqst0CTM4ZCEFcuKLlJVWv+H26n2npM2l00qEHmydGJ4MiZ36g8NP1qe/dsbTRDFcKh4nUmWByzoZ8BxBVGH8OvkY4H1puD0PpCXGUNyePt8+B/E+okPCgB3nkZCtwVAxvyiTN576l88eVIav7KWRwaClB6lmsmq1TYjTWClsPBSkgsSshUZywCwmUkhmWrYKiSXkQMN+cF0EaG5BNwf1poW+7l+0MUiC2+zvfN/fszoRELd8c8XgxikCli4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgchif4HbabUXjGfnFBSk7z6VA8o1ubVNg+Lk2rXY44=;
 b=Fnjx6sIviVwO4h0j7hX7HAeVr4GXnBCdPtDJclR/BYdlq9dDB5aCw6Jd9+zS6uqkyjDtQ8AlJ7JhAk1LKTne7rHtKerh979O0zDcwCCl9/bdC/QcF9lw5U7+LH8u97uremGm95CX9uXb/x8XFljJGcjYY+viZRoymNsx8ijtlvACPvWBc3tzaYANBo4E7SJzCdmFR3p8MDCNS93vktZv9cqhVfYw6lr2RLFz5GtgyX1t85IS57NYi/PFKtIvK0Z6YUO9RXWAZDaMeGTMZGrGDJvoyFlPnYKbCaVWaP86f57lcl7DrJjrTnXTd8WF03keYKOdWfrRyqD05a45V5UYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgchif4HbabUXjGfnFBSk7z6VA8o1ubVNg+Lk2rXY44=;
 b=BaBIrtshwqFdrRlkaAOefHl8eKIVXQnpmNWTFwz8ev8z+YJnKYzl5yZdnQc9feABysaBXNP3N7LpdyFn2FhDEQt3Jan4CyQslNtj5TOwuC8/0T3vtSso8/70jhtNAFLUBvpQf7tSrvAUpsgB27rqoHtUnyq7xcPPV2YroCpNEdLtR6/7ymLsSKPX2ygNOkrgdCAjDXV8LTUxnt5cKNJEYCbsmb3UaTq2VYm5VuFJu6dlcNqQ/0LrXFetYWLwGx3atjCA1ZnWCUFNWODunMslUnCXAQhzDmCwIAOAbISwlrIUP51epABEOyBVtF8JZtk9kguJZeEhw1bngsMxMHbTXQ==
Received: from MN2PR20CA0040.namprd20.prod.outlook.com (2603:10b6:208:235::9)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 13:08:23 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::1d) by MN2PR20CA0040.outlook.office365.com
 (2603:10b6:208:235::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 13:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 13:08:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:08:05 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:07:59 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	<mlxsw@nvidia.com>
Subject: [PATCH net v2 0/2] mlxsw: spectrum: Forward packets with an IPv4 link-local source IP
Date: Thu, 14 Aug 2025 15:06:39 +0200
Message-ID: <cover.1755174341.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2ee5dd-f7e8-4130-bd80-08dddb33a53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dw+6tt7zwiyXeC8ShxfGKEreucxAFOMkno4VkzXYqmLT8oFpnnOPG3FbKSfa?=
 =?us-ascii?Q?54ObKCmgGxEjfaD3/qoyoGJU78bVudwBRjTkZJ+BLTYolHHOglgutFTsXSEk?=
 =?us-ascii?Q?Q5eYCitx73nUvfxlEIBZu2s76t9DE9L2SDt/SVdqGEG5U/TYnwRaHA9i3cDo?=
 =?us-ascii?Q?XyuOXcpeRzxhTEAhvVqMjBPYb10YTgr/biFnB9IUyYcThCQ2fOBxFtNX/wlu?=
 =?us-ascii?Q?Vl78mp+xdLDfl6lT25Zq1u6rfFPOZxTrfjks4kT4Y5jFrcKogfjA/nQUdk+w?=
 =?us-ascii?Q?re8YaHu97pLDyN/8UCPkx5rVy9KRN0veip00bMv2/uAvhNYqzhMGA3bM0rBy?=
 =?us-ascii?Q?tC0AuyiSONjE3dQ+Hi41mnwPQ3m9ckp02x97p6LOdSew6MyNwlj2CJeQ1VZv?=
 =?us-ascii?Q?LiIkmD8HCPxZO6BmjiEWXFIHHjbK1JNOYW/VQSwSjF4xBZK9tfZxIzF4Kraz?=
 =?us-ascii?Q?ZoApz7a5OSEA0pkPXaBg7s7prLGJB5KM/QGogEklV/CVq7I87MeQni5kw4Rr?=
 =?us-ascii?Q?VsF6/CgxBS7WmiApVt41gShZpNSMZtNJgQstL0kBffAsoEevj6frVdIIeGPL?=
 =?us-ascii?Q?raVjxvx6v72b5MuEW4gvRBP2Qbmz0BJUDkNOWKcMl587feZ8o+78M7fzCAiV?=
 =?us-ascii?Q?61bZ5CqNFcKm4rstTXXYyxTxxvedeP/kRz5AUFAFAhNPlxdTuOM/YrhaGfWc?=
 =?us-ascii?Q?JDhF/rUrOpRnxZb9b/MScaoy1G60PvgvtZtipLnquMaBh/lSNpKGm4ieq05N?=
 =?us-ascii?Q?fa9XtB4YocIDV+ozzBftyWrY106a1k8VDooyDUMbAOgDikBQb2AbKiAVtg85?=
 =?us-ascii?Q?jokkCFalLeq1IpTvBi7Espn09FfXInLpyalJn2Or1yRSRfWLBayKHf2c5zH0?=
 =?us-ascii?Q?+FL5d7BmCrfmWLRrySnJJBK+xFBoElJp/S5i+kmV3vH1nni6j/0TeGes5yiD?=
 =?us-ascii?Q?uC5ZjL9eRugUuWwgWhbKQjmKDILO9cbKy8vXvFE2g5zHI9k5PZfUQKREa/Ma?=
 =?us-ascii?Q?2c5GsZXAF5aNbGC5B3NEmdkNEuLK3HLT4pHNXESqH/WtUu0WlTFdTIT/Y1q2?=
 =?us-ascii?Q?g+7iYhJ+R9Xn9JbPdMdjnvnhkfTP0gaYg12sO+Yb+ghHqphA+XGJ00jUiGyQ?=
 =?us-ascii?Q?HC0Uv1TzBJ2kTuU80CHRMLCepKaIuEVwsmUYAZ/3slS4flOT405rsgncEMxm?=
 =?us-ascii?Q?WCoMyaIVSFEavmtGPkhDFu212kKNQe1Ppr6ivy/8IvEZ0axRBUcalFbk3cQO?=
 =?us-ascii?Q?4Oifb/6ODbM07lqhifQHrzYDB6j6LOXbk+VyHDKYrpqENBBX039oOpVpaFsW?=
 =?us-ascii?Q?fzbPQSB6Mf3INTUaH31dcn0TU52LI9ET7P/Tdup9bXeTl8a5a1vylA5YeeoU?=
 =?us-ascii?Q?SMHD1OoaQQThxo6xj/4W+0WpsulQvDAHiEevoBbSMitAn+usRdgrD+xUfnu5?=
 =?us-ascii?Q?ig+SMDTQONZgz3OEWBNDKTbeT0ftUAItO2itHktYokv+rhNnGgfzAkffVWAv?=
 =?us-ascii?Q?IaZW9OBSPCp4CHJQUk/Gu0Mt8guDeJSE2kuI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:08:21.6695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2ee5dd-f7e8-4130-bd80-08dddb33a53c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969

By default, Spectrum devices do not forward IPv4 packets with a link-local
source IP (i.e., 169.254.0.0/16). This behavior does not align with the
kernel which does forward them. Fix the issue and add a selftest.

v2:
- Patch #2: disable rp_filter to prevent packets from getting dropped
  on ingress.

Ido Schimmel (2):
  mlxsw: spectrum: Forward packets with an IPv4 link-local source IP
  selftest: forwarding: router: Add a test case for IPv4 link-local
    source IP

 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  2 ++
 drivers/net/ethernet/mellanox/mlxsw/trap.h    |  1 +
 .../selftests/net/forwarding/router.sh        | 29 +++++++++++++++++++
 3 files changed, 32 insertions(+)

-- 
2.49.0


