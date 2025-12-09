Return-Path: <netdev+bounces-244142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DC3CB0675
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 16:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73AF7306BD43
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E942D1913;
	Tue,  9 Dec 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FPv1fSXU"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD42F6929
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294248; cv=fail; b=oe6zFFWHmbm8aO37h254Xy0FygArL2KCIOEK+MOLOeYE+5Vs1px/rrgrAMoEm95MTihyTojYGsXHFYEwzSXfMsTIjYZKCXngaJX+Rt7BzASOGzzzEVYW3FUroAkuf3mW52z90jGMDI/OH1A/oFAE7hAtXRbbl9BCZcGUgT6d1i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294248; c=relaxed/simple;
	bh=44n87J8S/wfxTyhWQFrjKcbCj18M+ExDtSGVBGwOkDQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uIAYd0C3LTT0JFvIHony4l72SkOTaWuLqfkA0dEUL7+p8v+MX1nud6kVRO+Tbq313fkWpmVoAW6ePd/vwiE5DvnpqWWidxaX7NUcR7nhP5C7a7eI7+oSaToshaKqtGZbofPgpnb6C2keirvJBG07LTBnDC4QyO3zkAaEcF99qZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FPv1fSXU; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITcHslA4ob5+mp76molOBmzW1tA0zhAto4k0cZNMZ2N4+Mqx9ajQkI4kmBy/jeU4dMYXu3JBwBgGyi4L9oXcJGcpQ3bT4RJj3y8MJEQMPZG38iwNkRZGlueV6dr9iPgreEOgD8GDUWRkidrSu3otLOenegVpQilxE6aYnxS5zc22s4opl6H/X5qkU5A031I7e/Pg0baDohM6MnYdysl1ReU5AXv0j+2lEFb1UC7d9GVeLey1sd/0IAZ0wF114Z+u1bkoxmDgl3ltH2meusvEPAlylEI0MM1QpScUlvObdrm56FqXPmkaJbpWsGNwk96ui8M1uHarMjFqTD3SvtWOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu328FBIyUJowrsaFj3/oGsySeCLtcpZSj1JBoEtzIU=;
 b=vj5+n3VQEKzvRF1KPwaFZgsMzgjGRSaTlbPgKGHcehZfD5pmJxImOBH2GiyUfCVVEx2eW2Gej9+Hoo7gVWMaYYrVI0u+ibu6uTkodQaUEEZ4A7nmwgZ1uOdQ0GE8ED8haq4CgmBrxv3AQ1T4/FWKq0EQvAEqNIAGl/2SOXKFHsTokcZPsWU16XbgOyLOOzbH5ZK3xVWXzk0qaRxhmJ/VnZVYu0HXUDSz4rYq4BH+Rz/2086DCz18nk6k1kYAIsXs6Kt2mT6FJiIO363zQx6wowmHlYD679TND4Gt3x3KZSgUQMNWWtnjMtvAWC1Y8CUL2HSpqF/g/EnjNU8n+fkxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu328FBIyUJowrsaFj3/oGsySeCLtcpZSj1JBoEtzIU=;
 b=FPv1fSXU/Iov/mxvbY1n2HDFK5EESt6iwRV+NEIOAisRFrBhkXEVBf2/djPdVA0IzZkrC6jJzJ9fZTsTUdmnO8BNZa2ipI3Ocnd538XuNvW/1X66yWKxUO8dUeqoq8pBrELnSmxBwlXsek020XUQI/0216sPA7pN1MJta6f2THTHrsffotbJTkCj51CLnuTuDJ2r0tzBhIBH2aoWBmdgWgRCvAm9EzVj2j3WxBo4KcNV5sfGRP8zmCjXfgBQqts18aGtQRFDxpRR7XjE86eL5LB7lADb1NWvJPcH4WCp8Y7GT62R/ZdgWdqRhbBbah9k8SOO84sp54y+VSFvXqJjZg==
Received: from BN0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:408:e7::17)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 15:30:43 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:e7:cafe::7a) by BN0PR03CA0042.outlook.office365.com
 (2603:10b6:408:e7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 15:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Tue, 9 Dec 2025 15:30:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 07:30:14 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 07:30:08 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 0/3] selftests: forwarding: vxlan_bridge_1q_mc_ul: Fix flakiness
Date: Tue, 9 Dec 2025 16:29:00 +0100
Message-ID: <cover.1765289566.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 792cad7e-e217-4a77-cf33-08de3737ea3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qyNHTi5WDAO606RCQ3/QGj6C1bWPy8cl9DQRe9rzzEV+Rvmyqxi83GcAtQt9?=
 =?us-ascii?Q?/lEgonXQOTfG3fSsSJWOYj6FMWURNvyHpPukC0wxcVxScBlgeCeo3ZM3nJe9?=
 =?us-ascii?Q?1u+2I3+uT0h8pE8sHljVKkfUsNh42wQhJozdIFNDKmAWYdPknxoRZjtC9NlN?=
 =?us-ascii?Q?M5wY+67MU62/ipIJ26XZyQCk7FYYLEkp9nTMIvcu5G6jVEFZWzB09hUJ8dBY?=
 =?us-ascii?Q?lPTM1O1+tk2vH/mRr8+EeT8UHWXD+yXXQranVaLe1lmREXLQGtTeE5/ERmTs?=
 =?us-ascii?Q?loxeDXufONNOlS5oVgBWSvfBrbTrdoM/ioI0hl/4IP8DtmICro6nJT6h+Ehz?=
 =?us-ascii?Q?aNHttAw3u9bhjcR3e7KBikXzgTYRT++ZC5IVBkPQx7fmo9zvv8ScEypnmu29?=
 =?us-ascii?Q?UkdwtLj9AsCGbxVIfyCW0LjNsVwYtTNAWBAeQp8rzFgmRTg8/EfezTXQnJEQ?=
 =?us-ascii?Q?chsk24OiK/tvUblDMAuuAxBtqEmbt5oODnZh6KB/AK7lSVO+5wK96TqbTm0u?=
 =?us-ascii?Q?uP2DtzcJKDY6y+0dYeO+07wvUq4eydJqTcWKM6rmSljoN+yDWVipYFVHVnzF?=
 =?us-ascii?Q?Go4KIO7DmciePKO6gJdU79f5mbw3L2t0OxP9t+JGMClOfA7vRxnGJ/XxaKHZ?=
 =?us-ascii?Q?lrb/APA3wxu6ZrQ2LuiT3rVIFQLmRx64vnfnTozAYeUmF4IZXng8/axIRNI8?=
 =?us-ascii?Q?PfWwWxQ4O96Tung+0XiP6DDnT91mNB3ZrWLpZ+h4y9FQPYHGUy/79rq98ks9?=
 =?us-ascii?Q?mMWKA1+Vdk/0HTf2d6MtLOKFSV4Aqa3hmx/0djI/2jYZU6pNigj/e8SIwB/Q?=
 =?us-ascii?Q?ZY05/+mj76WS8FIYJzf5AsladDQs9vBuZDEnS+vc2wkLI42sk0NH0VRjpOOV?=
 =?us-ascii?Q?tynhWJBzxbV174Zn8wU03ScpVhCHuql06jMxnzNbN7C/UWdTVzwJeIwg0kjv?=
 =?us-ascii?Q?P/GxFdLMZrs7tGei8HAU85KCHX7WPbs9d593gX5AWOUXPpJ1hvqjYtFgEtJ3?=
 =?us-ascii?Q?+/dQZGig7nAFlsZZKQdkXW53lmf9/WJjiiHptWqSgsONoMJ7f0zKqnlrv/tk?=
 =?us-ascii?Q?Hlkg1T42hKRBAoFCX+nhy2KgVyeHALGzG99jJm70hK94tndVL0DFxZ3NsMsx?=
 =?us-ascii?Q?NQ4WcRu1y+KzSoSTpgpfMntjgBMqUoKnuZIf5Pnv2TY4AwF7sBo9Ad3fV1VX?=
 =?us-ascii?Q?qg50WDJTHhFVQ6iFT9eu9oyw883GEL+nU150xOk/8xpG7FUNHccQvcjC098U?=
 =?us-ascii?Q?3hXztS2nWWC9yd1sG4x4e19rQl3XDVjcNty2GY0pnCr8+ooB3Q1t6kaJY1dg?=
 =?us-ascii?Q?Az+at/fwSXlup5JBXi4Oer1r0kIbMbSDwLTVI31JYxihUeyJzTWm2SJT5hXi?=
 =?us-ascii?Q?sQ5BHgzgHwPZ/7mqLgQkgJaWYRkihCzlZPX5arJ+CmgjXqhb6gyjT1Gq/aon?=
 =?us-ascii?Q?eQcgOXlKB4xAoP8XS6uaudpMUJ0p3PDYvaWM+qqRBWGdNkW3vnCnHkYFAAUw?=
 =?us-ascii?Q?X9fYD4QYX8B92pc3uJR4cvpyBFO66Lrs2RAYVLmSPJIccHxFHYiYjAM06LA9?=
 =?us-ascii?Q?HNh3Z+TfpURRe/7NFVY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:30:42.3686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792cad7e-e217-4a77-cf33-08de3737ea3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

The net/forwarding/vxlan_bridge_1q_mc_ul selftest runs an overlay traffic,
forwarded over a multicast-routed VXLAN underlay. In order to determine
whether packets reach their intended destination, it uses a TC match. For
convenience, it uses a flower match, which however does not allow matching
on the encapsulated packet. So various service traffic ends up being
indistinguishable from the test packets, and ends up confusing the test. To
alleviate the problem, the test uses sleep to allow the necessary service
traffic to run and clear the channel, before running the test traffic. This
worked for a while, but lately we have nevertheless seen flakiness of the
test in the CI.

In this patchset, first generalize tc_rule_stats_get() to support u32 in
patch #1, then in patch #2 convert the test to use u32 to allow parsing
deeper into the packet, and in #3 drop the now-unnecessary sleep.

Petr Machata (3):
  selftests: net: lib: tc_rule_stats_get(): Don't hard-code array index
  selftests: forwarding: vxlan_bridge_1q_mc_ul: Fix flakiness
  selftests: forwarding: vxlan_bridge_1q_mc_ul: Drop useless sleeping

 tools/testing/selftests/net/forwarding/config |  1 +
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   | 76 ++++++++-----------
 tools/testing/selftests/net/lib.sh            |  3 +-
 3 files changed, 34 insertions(+), 46 deletions(-)

-- 
2.51.1


