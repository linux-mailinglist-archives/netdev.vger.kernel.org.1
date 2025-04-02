Return-Path: <netdev+bounces-178768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF88A78D5B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D197A5435
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 11:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF2237A3B;
	Wed,  2 Apr 2025 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qouLRvB4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D33235BFB
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594200; cv=fail; b=BPFq6+bdlIaIun5HWHUWPMWC0YcoX6YfxRvHKGrTVEjcYeVgzF/z8ZJdvXysW0QGND+BNifuDK1ZF0N60Vi51+lJ9VyufdteJB06JOZE0MLDs0jinYeJ4Vgpeg5tuBEnmSw9mjfYNfH2tA/pE02577zNfQYS+GgsHUGGMbKFASU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594200; c=relaxed/simple;
	bh=onISp+J0Z6hvDG0uDPspU0LLTsXMkFeLZgVlxY5R6f0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+VsjuH5cHb3jtEscoeq4ohDQYzmoR88j26Fpn0RR9EgfKXFWgY+XNlVZnICSqFpM+g753r/eK3j31QGcoFJ3qTH0VrDix4ttfgpZbNlBZUtm/j7IZcKWrfK6hpc0OZe1kWhdDcPwEn5iteJNAUrBPKMlOpbadg2yRu33OwJiM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qouLRvB4; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTKLwbYOpw6KwDUhsIWFbV+R/lHZrE0xqG4E4UTvH0fGN81PaBuSrHk6oPdFmO9nqaIMmDaI4c3f6Rfe+bGNMus/x3Z9zkcpxtK4U3/8BnL+FtDNdPF1lBS84GWYbw6/y5m2zv+8RC2Tnv6J5oNvppnp2Ejx13X6rivxjPSSdHo0N45gSFY9LzYRwPZzKm6zcXgtuTPcLNUv6c3NE4euasSOXDUhg4X3R42wVXzQ5XDVmMtzcuZIKVAUA3mtnlD19QMnwxuBrVnFptYI1qwWJZYTye2oc9qrKE+y8itImJeOwhiYgY//FR6RdEgj4SnhMHZjbaedVXXiD5tnhrXnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW4bUrULxL4m8sx6gFzrL1x34bgMXki/JE09xo/GLP0=;
 b=y56Bixe/VXwSCiGkwnOQGAMjG29NrXt/CqoFzuMd2L03Ybr0vhKaKre8FMw0qO23CLkRj+vKjwLx+xharBPb0YxQS/Ycj7YJ3u9BnLO3aFKkpYAgNCb3nxR9wIbMCguBzUQpGvyHhYI6bBgHFOocdxUPQc4kvPV1QJ1K4XGvThdzaG+cB5nu2crTB/HzPn3GJWg4SNvqrNCghKLcqgQ2EXaVfuytNFvFgnDLwXwwposdHNJkNsrLI+1ciWdVKv2cwwpLFwZ9KRuDvBmPeuNTop6zFa2TQDZE6vtDST+zmiK5mIJmAsMX6wtpt+wBRXZgLqEQbYfX3Jk3xHtFHc9cqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW4bUrULxL4m8sx6gFzrL1x34bgMXki/JE09xo/GLP0=;
 b=qouLRvB4dr2iDHvEF1XxxjckVGPhRvobwFMSIOZqdh0Oh0UAA20+oUjHKFSPevnVDsQzxc+rr2wHNlrbdjPtpWKn/pqBY3CqddbN2mYqmau2FzBS+Kw71yWpjT+MkjJFUwsv/scZsUYqblBWbkeZXfoucRgn7okbAY1aJQwC2Tm+P7CLHv71SPFyYu7ljLWsxPoH2Z5cLdmIjgSxQRDG97oA0JKhHS1q4NDswqTXav0K3doQd+8BHrQBQ2b0fBU+CAd0DoQjQ0qM2V6kXXP4nnbKcLNhQe/S8wtloqPtmqswmGLpQlVBcynYCNsVv6LO8K1X9uCvs2AeTepu6F8GdA==
Received: from SA1P222CA0044.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::9)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 11:43:15 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::6) by SA1P222CA0044.outlook.office365.com
 (2603:10b6:806:2d0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Wed,
 2 Apr 2025 11:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 11:43:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Apr 2025
 04:43:00 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 2 Apr
 2025 04:42:54 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dsahern@kernel.org>, <horms@kernel.org>, <gnault@redhat.com>,
	<stfomichev@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/2] ipv6: Multipath routing fixes
Date: Wed, 2 Apr 2025 14:42:22 +0300
Message-ID: <20250402114224.293392-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 47cfdfba-95e7-49d7-819b-08dd71db8e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ms9mEP9maaR+xNmVL871n0CSQwkz4Nlujru03meZ1ubEOIPPqDum1CPgDE49?=
 =?us-ascii?Q?Lr7xJpFUUgI6z96LAueqxxZeQl/DYaw+NEsvg6DiDDV2RyXrEiA36P6E0lls?=
 =?us-ascii?Q?CifOg990eCG2mUCEDPBoB9i0tMpdy/+/KHInGSHXBqZ8RV6zh9221mlDsplZ?=
 =?us-ascii?Q?5IEix1I5iNKTlEf9hmvAv0ha3p0+MOgjXRVriiRcgwqk5TwWVRjoOTCK1PtS?=
 =?us-ascii?Q?CX7rB4c4udzfvqSqFlTD+28EGv+FssF4vSexkJGF+GH5uD/W8ZQ/hpP2Sy3f?=
 =?us-ascii?Q?nE4gcmdJOb7vSaBThH95VEkPv8lmgpMiCkNYBTpe2lTKkM3OO+hceWm8M6gV?=
 =?us-ascii?Q?rnp0PQNK8UZL5nr6HtqO7SPjYmI2QrNSMFZeudzw73WCvOwe9gdYWWQpxREG?=
 =?us-ascii?Q?pWDADgk9sfgbGgTYfKlPBA1H2Mi+ZnmpN0w+RhgYpmSY+4GVyk7NXD+3UclY?=
 =?us-ascii?Q?rBiFO1lMW7cq+bsf+Q4S+ghMFIffRI4QQ5xGo6Z8nRmPy7ML+3dI2/gOf3e9?=
 =?us-ascii?Q?T/nc/TVicF4Riv3WzRgt9WCvdQZIqUhuyMvtdGSwJ3owRLFdbNUKPG6vIqOF?=
 =?us-ascii?Q?J68/RXZh8yRDXxGuRq0yKv72CqeEE935mjcTMT+u5+Amr/i6XrKYlewuYZ3v?=
 =?us-ascii?Q?+NOp+gb52bS9LdNYCXdZ3KQzlE9M6OPm9zzpSKa+vYhzPdVF8wxZfq9bXUGm?=
 =?us-ascii?Q?Zv1QCzns/9f0+lDu3A++kj4YJeY+d6T+Bl/d0nGe3MpbfNCFD9VBC1onSaAW?=
 =?us-ascii?Q?LmkiPfUXq3FINhQxjE8lmh73yhPVEw5jOvNyKeX8spXTSCokzfe0+HjcO8fU?=
 =?us-ascii?Q?jsqfWO9ZQKQ6Stptiir4eZelIar00hpmACnbqGpgxlFjQ2UzVyJD7dU6a/SF?=
 =?us-ascii?Q?l38UBtWwplK9GngQ+DxPSlP6N1ge5uU0ezU/KqQbLNpCiVu//4YekCCGTQDE?=
 =?us-ascii?Q?btZjfNcVRgoGv4erxj9pE5q5ImTApwYzFUWT6QyFPt+/lsVDbIVUXPVKFr0z?=
 =?us-ascii?Q?0hdGHaj3O2ZzzlUy7QPE4XYfmsUAjzcq1cLKZ/xPN4bVLWse92G8qaB93TMA?=
 =?us-ascii?Q?HT+qN2ZitcC9e/1JoXghLWLRl1UY+FBjCoZoMkBOx7u9SqQ4xEx//8GBQjgo?=
 =?us-ascii?Q?IhJHheFOUZ8gp99pWdAU9FBCx+HlDsDQJvmPRprj5r+4XmKTF6TidLDxIeXS?=
 =?us-ascii?Q?1nE5lR3ZgRX60dk8kGlQ9TySEhKxdQLgB1/okESfMNrAQ3/GyhbbRfXOmDg2?=
 =?us-ascii?Q?oVga+/h2w7/Yfpc7P7GkChtuu/DMv62G0TiEvX1J10UiJj6gGVeT+g+ecSZM?=
 =?us-ascii?Q?2+gh+8nI8L7kwtCaWJYR+Mg8pZ667iwAgtzCLvo2Q8V1seumNQpU+S4HJ0vf?=
 =?us-ascii?Q?/XwfrbehFS4H0ZlcE7DblM6bZk7Xx74Y46uHrD9INRslujEFabcIxfuLpA8Z?=
 =?us-ascii?Q?V9Jwn9+j5bQUCnt2ehSl+GSajyCP/h0XDcu7qT1zl9aWggpdfQn9PUN4puHA?=
 =?us-ascii?Q?m6BCEkzeelV8ll4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 11:43:14.9574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cfdfba-95e7-49d7-819b-08dd71db8e05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

This patchset contains two fixes for IPv6 multipath routing. See the
commit messages for more details.

Ido Schimmel (2):
  ipv6: Start path selection from the first nexthop
  ipv6: Do not consider link down nexthops in path selection

 net/ipv6/route.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

-- 
2.49.0


