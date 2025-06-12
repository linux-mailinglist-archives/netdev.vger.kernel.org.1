Return-Path: <netdev+bounces-196939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B29AD703E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5168F17B655
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6A122FE18;
	Thu, 12 Jun 2025 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="foMeSW4/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391AE222571
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731072; cv=fail; b=Yxwv0aoKqFHATOCHL6Z5N3fLhuCXuEidzDpXuZ/JUwOnOgBGr7m/q56TAgwcMUWkq0tiSvtBEmGQBD/jKeHP9eBX7rnZoRtRdJO/QowKYgTd/24AIxG5qlFJcTlvc6mqxMcJus8Fj6997vUiMCDeuMmTcvAXdbeMBvgwySVs3PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731072; c=relaxed/simple;
	bh=GbgoKAIgcQjDJna5mcPoixngaW2Bh1MMYTxtR5DLeuo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B6QUXSikkucgWIgnDLUSo3cL64tAslFdwCoNYmz1Wo+j1MbMyHAUw3ZrjyMyMvqF6SCMhMTDCU315HQYKowPM/6tILRly4+HX+8btQ/jweP+A1inQgaOX24y/6Y2sh/gqrA5XDUslrKY+iV6FejjW4TZbC2fIbuPOP27va0fhgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=foMeSW4/; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/HG2UIvR/opFFp3bmyMIiJzITRytcaxMXThBURM/wkuogvBf3D2cHh/VjLNz8DcYfwmKmYA1y7Ndo4MWrkFZS7ufEAL+7tQLpgmgTqhFjcEwSabs6FzHvD5brA9nRCQYrj7pMc/4SURsUI6N88v8qOmY0zLDKvqlzunffXEo3jsodCFlq+EtK8tZmP+61o15mDkIzf+0GCyMTgDWQ+kNTPtzMuoGq6tJDDheRUpmG3uikIj63NITthUeKLFSnVRIFS4DlKgXeBwe14N8lFwDfsBA8L0E61MjXn091jNPHlLo1353cimMDzSP4YVO/gNcl3+O/v0fAMsqnC3MbvMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2wtZTAbiP4+EGUiR4kJftcPDmkxBLL6sJwCjT0eVoc=;
 b=fgKR48DOtrge4y0tX1Wc650Bn6nPGwABgQ8+dTYWc2pHpU+vzjlEeSddA7G/7tki8SBu0tXLIBZEBzRuv9slDNxsymX9ShxSFeYibBS+8wQC7YUOmsKx+4mQSeJFnoFp0ldCyTEHCxx1NzZR1nZ7ybQQ8ZDHjeAZJ67NqdGabmRg5wxfI68c/MWBERFhnPJmDI9Gi/X/AZPWapJtK3rj6NOkoYqz+2sPaH43q1YlSTlyH5yU5BunoFgsvlGWJoMCzzHcox4MdRuiusy1rJF8ZPbjt3OdcBuUjH9cePbnIl/pEyt20ZDb870xw7P9lOTt+3vpj9v8I6G4wGpx94MfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2wtZTAbiP4+EGUiR4kJftcPDmkxBLL6sJwCjT0eVoc=;
 b=foMeSW4/fyKIbpCxVxeHNzulBKwGJUwxZgCV+FTsnRwSIASrogbfbowbHByJH9ScaURtMkoJXBjYvwZSsubp4zjxuay8f2d2h3Zt3JhAHu4TuF5ttijOJKEfmznpPbfEm/rBuO61MbbsmFQIzCP+IZr0tuObtCizv9GmBieCoprHYrffjSv3BwpPsfynOB9M+pIdD1fxul72Xnb4hpJHNOP3UK32J/sx/PWQjVOhok3S3OPObc/QA9T9jdgao/XeXSeC0uBp+PJR4RWVfTzRiYJfInqlK/XwOthcz/Ev+nNfwV0RKpvkb/4wwRVGu9ztxRQ4u3eN3T7J0L905ZVkrw==
Received: from MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::9) by
 DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.23; Thu, 12 Jun 2025 12:24:28 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::ad) by MW4P221CA0004.outlook.office365.com
 (2603:10b6:303:8b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Thu,
 12 Jun 2025 12:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 12:24:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 05:24:14 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 05:24:11 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrea.mayer@uniroma2.it>, <dsahern@kernel.org>,
	<horms@kernel.org>, <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/4] seg6: Allow End.X behavior to accept an oif
Date: Thu, 12 Jun 2025 15:23:19 +0300
Message-ID: <20250612122323.584113-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: cf806678-e9ad-44c0-9614-08dda9ac1357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tni0wKeKscXIHORp+iAZefjcaYNZIZI+wsQcspL1/z3BELUQZpjOpiePRzk5?=
 =?us-ascii?Q?utzGothzItdINGOyUcoc9dkkAHs8gzjFuX7SAEpNy6RG9yYgphFcGb/gPa1y?=
 =?us-ascii?Q?8fJEPOUtyCH7L527Z41ZjBahfGm2/YQY4/LISuMiKhi4CFlzaqmcyT8fXDKB?=
 =?us-ascii?Q?8PeKfi6g/3KjsjXdy318AT+5aFtDXCNABVHD4D/1aoSDUujYfaYIkuLTq3XK?=
 =?us-ascii?Q?E1g+E4g3rG8qjwT9NYStYqZj0GS2SuYTTdhzgjra2IKPumjduwRUgo/Vn/EA?=
 =?us-ascii?Q?kuoIdcHWekjhC8pJhFIxRBTWaQQh+XeTB1Xkv+LYz2CM8zCE3yNq2d0JgkZU?=
 =?us-ascii?Q?uUHhvlQd2wkx1B/5G0/lk3PEgpMWlgc62hUxqoSVE5C7wEgaoMRq2vgqKPs/?=
 =?us-ascii?Q?wRvoU5wgvZmlxLuc6mdTerKrvRNAcU0H2GZmeDMaAMa3A/R4Shs1L6pMG7zG?=
 =?us-ascii?Q?F0fVuFprCT+VMtw/Jqj93ZQg65TlUZvZ7LHVIOXtMnDYtO0U9R18YNX7TCe8?=
 =?us-ascii?Q?T4pTDBJpSCanafFHKpXES9hYY+JHtiG5K+Viw/YkUUxeNLqp+5RPcipfW+n3?=
 =?us-ascii?Q?19JTk7qApd3D7J4Jl9uwNV2roGWMovC2N/iJacV0XP5/eWpv0UbZYP2Pb/kf?=
 =?us-ascii?Q?rDO29KXBc13S3VMusWdlDMXoUDBi4jDsvk7VP6orS4If9sEUAB43wcsBr+uD?=
 =?us-ascii?Q?PEor7zT+IjUsLNkwBkeHCahoa8GpLGC8XqJ+hw7GIT2l9gm20iSB1TreN/oZ?=
 =?us-ascii?Q?ttK6sky4tYOZYbuX/O+ZZdlOISH3nit1Nc4JXfawpx1RtAEPe2RsYNHsyFNK?=
 =?us-ascii?Q?RXdga1n9Q8gGkzMy942kWkoeaQPxLg+02Mf4ReMIfgUr2znr+6FQKk446pWR?=
 =?us-ascii?Q?gK8BGqKPGMhgjhPGjReKVb7pLkd/iJw8aqwlAi7MsnOidb+y28TY9GbcHtwz?=
 =?us-ascii?Q?Nn1LcetRRUCI7YUvDCdzx9CC5xWV4fVI2npGwhusxvZNGEps3KLyCMoUXk1s?=
 =?us-ascii?Q?cGnQyyoc1SsBxXTja2D1PQzWGKrxrovAFmm1KSws4cpWPWipca62fvDSecc8?=
 =?us-ascii?Q?SKK+YTzmldc0nHE529BqGEO8RrNkvwM9WMjGI72SJ8VBhZzfNRrM7jRTQdFW?=
 =?us-ascii?Q?QyeoCsXsFHS4H3VcxqQwgi5vVsA8OlMz5B8DTXhFXXFWKVEpALDxuA7dkSS+?=
 =?us-ascii?Q?mGM4ByOC0gBTHHyw3zdnk1sMJ0iZfPtRfYDEgN99mFDcKrWf5audu1OVOU4o?=
 =?us-ascii?Q?QqL4NOnSwdSDhQnrEZ3qQ7COgeA1lJT94xKShaHUvR3r5+w+t5WuSOQonCtM?=
 =?us-ascii?Q?IZQgDF966OwKALfN90huVT32h14Pwop2m9dbufEZ9tITlHkZuUb2FEvhn1e+?=
 =?us-ascii?Q?nR8b0QRPwV/Yx/UgUWCqu3kjgKirnlzxOxsh1Cqti8Pe4L98nDh41zg6PSwP?=
 =?us-ascii?Q?F/SgaomVovBOMRa0dQFqfss8CJCQzWCcrqCDmm0iy2BEfS4VNwNmA5EbMiRa?=
 =?us-ascii?Q?0oJ0bkEQsen//f7giHQsIizYURbhvgmvBBE2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 12:24:27.9143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf806678-e9ad-44c0-9614-08dda9ac1357
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770

Patches #1-#3 gradually extend the End.X behavior to accept an output
interface as an optional argument. This is needed for cases where user
space wishes to specify an IPv6 link-local address as the nexthop
address.

Patch #4 adds test cases to the existing End.X selftest to cover the new
functionality.

Ido Schimmel (4):
  seg6: Extend seg6_lookup_any_nexthop() with an oif argument
  seg6: Call seg6_lookup_any_nexthop() from End.X behavior
  seg6: Allow End.X behavior to accept an oif
  selftests: seg6: Add test cases for End.X with link-local nexthop

 net/ipv6/seg6_local.c                         | 22 +++++----
 .../net/srv6_end_x_next_csid_l3vpn_test.sh    | 48 +++++++++++++++++++
 2 files changed, 61 insertions(+), 9 deletions(-)

-- 
2.49.0


