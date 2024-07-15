Return-Path: <netdev+bounces-111514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084119316A2
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04611F223BE
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D71B18EA63;
	Mon, 15 Jul 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZnAbHUBD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309418EA62
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053532; cv=fail; b=VCaJarrjM8coO9W4cV7Z4pwWE7GbBYkgEuMOkUd5ODPYeN5LMV4lsEj89ZNDz146Zb43jKD4URnHyrCLDtHBiaYNSJG+tvmOoJXq5EhLaB3c7fzel3RBIMNEYNDcWrrVqnQ8aVyPQG65DkwlsOsb8bAgSJ3AprfN8ENIzjJrhJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053532; c=relaxed/simple;
	bh=cZ/5RK7tvZHr7bvkjwcnmnwCX2rq5cowDDGZLzZ3oew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C8CHQ/WvyIvn5Qrsn0QwT0ZPV365JJYxZmzG3Snj2uprqtDy1+pypftQpaQYzUYrGPxsTubJR9ZJyUYZMb1VWdtgcn8mXDq+AobL2eFa8GEG/dZVBi5qsdYMg4Nhxg+WLhxd87okIUHm1d4T4u+bBeSogQvqt8WIU3sf2SC9FS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZnAbHUBD; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kj8A/2F0UKISW7P08DnSePNNxZ/yTD9OIev4GHH8BD3YHL0vrYEOBFnMrlG92fCINpFzapaPdDIOgI8Rpf+nbpYVaC8OBswKjlzkt8sBy+ZJfZLxSqoAXiUmOfz9N+T40RDUonLQ6pH/Zs1CqnqLQ56xYhrrDEp9hro1L8rdIotV6w8dRktEAhT9lRlbIL9kiLTB53JsiAts3apVf9XXJ2sVwt+rM5xaapP5qVWcsQE1qBgrErsnxnyxMCQQ3wy78TEvHsFI/NTYHXdGEsh75gFdtV4RD9+9rG1VjZfxMpIcyPGiRe34ub9fWJf3EbpxePdGCHpaWjLfM/FR+UvzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlZ6FjUIIV+a33hi3nRmF/F9zC67iYEvQcQfDlKWCQo=;
 b=P4rxsVWN2A2rZ7TaAE1b5jXQ+4feW7LfIdSih9lUMpzcQg9gA61cQwGGniFMYO0T9Ugsa02Fy4eelre045wfoleUOwgVkcMXA3MlI0rFYgp/l0Crv6wmLew3gvr+XftcNsW3p/IXrud6YpQGAqrV2os5C8/+pqxQtYxmhLNvGHyiHupi2khF/jumlMAtTMtp7RKxzrV+8VmbFl4n82Sr9W2g4RideHkWS+ZEKDHUtF8m3Mq3tLo84mtUuREunm6dL+v9vAIhToqZU3pUuzftfvNwt8CKRM98BrCjSDAem0eLkkb3DnsTQf9ApLQrwIrGBRWEWJQ+vfitMT3KHJ+iJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlZ6FjUIIV+a33hi3nRmF/F9zC67iYEvQcQfDlKWCQo=;
 b=ZnAbHUBD85opmBS1THNzxCDuos5OX54z348tdoZcattTxKemabmQAP/0GUIbLwHQKabyWJpOPQhESu2JtD+NA/pxSzRh+MpY0ZOv3OZDt/pbSDGkjbfqul5zllFmmWApigP8aypX72Lsb8lAMdl9z73A9NAlEoZsBylKxpLLYD3V4T7zskZf40RHNdpu8HXcgynmsLIfywcWR3ClJ92WA4+wyBsQs8xsaSi9wn6OQyO3N9ou1RXM2GOWGtBbLYnAJk1a30JlBKA+eL1UfDrFFyZorTdsg7Mr19T7+S4lDt98VdNhBOWeY8Gh8pIhjkbz7Zg9KBrVjopelVjYPD11Og==
Received: from PH7P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::9)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:25:27 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::ac) by PH7P221CA0037.outlook.office365.com
 (2603:10b6:510:33c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 14:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 14:25:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 15 Jul
 2024 07:25:11 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 15 Jul 2024 07:25:07 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<roopa@cumulusnetworks.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/2] ipv4: Fix incorrect TOS in route get reply
Date: Mon, 15 Jul 2024 17:23:52 +0300
Message-ID: <20240715142354.3697987-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.45.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: c6858477-679a-43b4-f78d-08dca4d9f92d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yiG9R641gm+OHUp+dF9lP1FGotnh4c4MdY2ILLgwROC5lWlUVo2WzDTCjBNR?=
 =?us-ascii?Q?BMZul25QWMvCAwNT62b6+qVGogbyjAqrclKDUj/93dMP+bfpeaP7EkJIUqaa?=
 =?us-ascii?Q?bvZIwpv7Nya/gI2Je+49Q/bQbRTOe5l1kak7YOSgi5SgamP9+f52Ch1GQTEp?=
 =?us-ascii?Q?Gx/mcyFnwwYOA9Ir6eMSbd8mo/4x3x4QxHePrzw0OuAIKEs2zJntXjKGFIwG?=
 =?us-ascii?Q?RDnXZFBfKCeEYskRtGmsPPcFt16gP3mBEw8itZiaccgd8cEBSXeVpOT6X5v3?=
 =?us-ascii?Q?L0nDnVL/5qqX/iPRFlUYhYNjX6N9hnVRamJzK10AJ1r/fzdorbFnrfhY7X8G?=
 =?us-ascii?Q?K3y12Hw63lVqji9d+7YiHWdMU6JLrce4yox3xCscS7CwJJG2wQDODeYvqEvT?=
 =?us-ascii?Q?IjGQblz/NFO0qzqchuIrjwRfai4znsYuDaO2yc0KL3rZ2TUlzBzlCeoWT/wx?=
 =?us-ascii?Q?nZYd63PmASNzCBB8suTPeqwasL9i2tvigs7BorwhcN5v78oBM7i288y24PiI?=
 =?us-ascii?Q?QhCHGTyENy42ucpz7gg3fMgBRwWB/EVSeIptnn2bUZizRG8fR8Xduoj0s2dy?=
 =?us-ascii?Q?9/3UGNVOhO6mD5Wvn2JVfVykx+hVx1aPp+l6gMaZsMewAdirv41X0laABSWF?=
 =?us-ascii?Q?7hvQnMOHwZq4uNJxT0fv02DTGYxOpp0rX9oWvRp4icU6VvMQ0k3h/mnfyU4t?=
 =?us-ascii?Q?CpyYGvGK2nAc2OM4uj7ntvK1sBrNaweqiLhN0kesSLt2iss8O3AL70+W4hNv?=
 =?us-ascii?Q?ajDpD5SepXjIlAzEayq2yMnpUxh9uKgAwk3yUGqQSrDyJ0UCloDa0J2XY9xd?=
 =?us-ascii?Q?qXRGZxsZr0vSCxCdJEmHZI8beyCfWJ30OAk9IodytoLvgWDCJURWZsjvoPpc?=
 =?us-ascii?Q?Szuphodf4ImFyBXjzoEGOa4JW1u7PVtnvLGXpw16SjgwYDMRuqvAVg3JtIYQ?=
 =?us-ascii?Q?P8qClnbx4FUK4r2/3fsWOS/McsAhvKFwmcLNOFBBenZQX5t1Kw00H0T1BeJR?=
 =?us-ascii?Q?fR6Yp5x6gLtjES5jJPd6ls3lKG6RpLCyoi+VSD/mMDfunHyvqydhzjeMyuIo?=
 =?us-ascii?Q?q8t7f0n61SCVeJFwIxvJxxcNj0SHGG2eMWohcB99UNiZaOfkPd3g7e1/GJ5D?=
 =?us-ascii?Q?jlqs03GRYn3APHCiOlkj0FBRubatqqYehuKYkGaWFiR+1QDGAi9C2EZJTLRd?=
 =?us-ascii?Q?xkXypfJvHJC5qTt5PKBuZOmmKmeHg7eE74bn8q+nobZxs2gVN5qy2d3hzQ/M?=
 =?us-ascii?Q?rPUtqPJxThKxIiIl5l6ZC+O81VfOCr9cTVBvKzYwTFu0p65lmkRV89Q6KzBI?=
 =?us-ascii?Q?0ATwBBEUJvGC059GnBQDvPzWFxNuvxyY0lVUqpKsd/mP/XjQM6obZm9JX505?=
 =?us-ascii?Q?eg7MFENgRkWXemnTtbo01lz7GYJpvmd/D4SsM9W594XC8CVM3g0Gn9tUip2v?=
 =?us-ascii?Q?q4BoDb9DrVoiP3j7PyRG7xbsZknGdkgd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:25:27.3759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6858477-679a-43b4-f78d-08dca4d9f92d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881

Two small fixes for incorrect TOS in route get reply. See more details
in the commit messages.

No regressions in FIB tests:

 # ./fib_tests.sh
 [...]
 Tests passed: 218
 Tests failed:   0

Ido Schimmel (2):
  ipv4: Fix incorrect TOS in route get reply
  ipv4: Fix incorrect TOS in fibmatch route get reply

 include/net/ip_fib.h                     |  1 +
 net/ipv4/fib_trie.c                      |  1 +
 net/ipv4/route.c                         | 16 ++++++++--------
 tools/testing/selftests/net/fib_tests.sh | 24 ++++++++++++------------
 4 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.45.1


