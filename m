Return-Path: <netdev+bounces-212749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EFEB21BD8
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B22C626461
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255A2153E7;
	Tue, 12 Aug 2025 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/A6jKD1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC35C2C9
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970801; cv=fail; b=cIbgPCSPBp8vDertOM3PqFnHvk+Mg4qJZIJVyrzagbz7BwodfwUZ68Du874IDqE1TMPpAcm0sfx0Wi9c6vRwKLZStFwXP6GvCt0DItuOdza1hWixpkoyFtn1fR1VsOwrdw6Gknpm/c1deqSkJDm0PHFqwGYC4K7ZLnQVCOsOq9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970801; c=relaxed/simple;
	bh=F9wE66hGKq+k6nNVJF7ffioKUR1Nwi8W1Jp6XGxXY9c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W2H33q1mHFkTC77Qvoxney5zq0LpVq1YFQjlttd71npwaAezWN5zvrU20nmp97S93c7W29+GR40zs5XL0aPbCTssntuMizCk8Khknp7YFjZf8sBklYRMp6IY7P/n6gOMHH2m0XaQOXBoRR/Y0VZ3xyQSmaxjUO8x/ey4W0VcUhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s/A6jKD1; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gexTiAXC8wTTzhZsWge05VTv6l+wy6J4+DCPiJLmwP2FYIofX49UttDEbxdSWX8P2/VXi9OXDO/3xI+KnbRcP6Qn11hB8k0hD3Lflo63WAhu79pfOd3cUbzRemlkDjKhBMn5w/lQ1OJp6L/RmdFg+XWSx7q0Mq5vJ5o523mrGC8BthvSj7qed9JzMJhWrrYZnu6mTdoL20pg8JLBeO2ZKxd/mrYijBvpJ+0rQ2wAhNA41WRm+nzuact6blzdXGczmGoW/T9963qr3+3ykWJf7yujlh3IbaMNQG/J0ZrcDAxgYS6APXaDitMru5YyG0FDfhdGcWo+ggKZUuggavz/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erEwB9mGd/iN57XuDIHgEuhuOW6G8zJPYMa8FRPKDW0=;
 b=g3l3kWA4BUtXsRRzJxEcwQFQTNdo9ZHSoDe3pp+0ruMeQXQxFpbaZxTiq6RoXeqZ/rodgf62oJNSYfTMO1CyGQmyRqvn5WPV+eceMqvs4JBdzG28QJ+lQhhwmCw2WdpHuwX8Az/BAGGwWP5PPruupCczOXDrtvZjlIiBjkOBnSd6KLUFt/boTLJC9dzjolqexkU2sOHy2Qcy7mcqbYPDCU2ju6HskBJIkFXqtWG+UlW5b1sixRrVPTzSUgK2qu3wibWZpMKDr86K+irXpQmDHnWtLqVKSCSukSLMAjQgJjJPuookaARcJfz3k38YqOSlHDFpWKNkuYn0vnmg7HWbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erEwB9mGd/iN57XuDIHgEuhuOW6G8zJPYMa8FRPKDW0=;
 b=s/A6jKD1Ojw+C1wBtdgtsGi7lKkSW2a72hl1YSt1iNS+DBvciEThOsny/060Ke9IAH977Oi99ElKWuOHJ4jaX9cdW4/aNxFBQL+HNcwYTHho+q0YHzBYSDO4khEDLI4lZCDxXy28efpwhQi1Rq26U6hJwNAhH8iDXO5iuyU1gPBronHuGSU6TrQysujI3xMT0AkC0JOCN4kD3gPGBba/xjNwHxg+F6uwZurZSizJJxW8QAa/sLaw+msgdFtzf2Fv/P/F+h3U70xLqDlVrraRR2gko/4g00lTMJ1GTNBSIWstfuJcQwWOUoao0OQ1RqQUF0uH+tCRyH3vfeIqbmoQBQ==
Received: from MW4PR04CA0179.namprd04.prod.outlook.com (2603:10b6:303:85::34)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Tue, 12 Aug
 2025 03:53:16 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::3) by MW4PR04CA0179.outlook.office365.com
 (2603:10b6:303:85::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 03:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 03:53:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 20:52:24 -0700
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 11 Aug 2025 20:52:22 -0700
From: Parav Pandit <parav@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH net-next 0/2] devlink port attr cleanup
Date: Tue, 12 Aug 2025 06:51:04 +0300
Message-ID: <20250812035106.134529-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 2463f44d-2dff-4867-2c76-08ddd953c471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Ti1dDCegdQwNXmYqOAk7l3h3zFDzSnTWBnSesI/Fzze7mjitmCx9xBy6i0e?=
 =?us-ascii?Q?UJWpsqkyDe23RjEqUpL00BkA10MfD9IEN35ws4qsZHQEKyLyyn5gtl2Q2gJH?=
 =?us-ascii?Q?ovvH9J5kasWdf04uGdxfCd6qe+OWS8/Hc2Guil87dl9Wl6nZyaqNdJ8CxIr2?=
 =?us-ascii?Q?otZnuz0bAGt7K7IXBl4/315q4fjN4mW/6tBMC92IIMW+/tWzEc/nlIhL12aL?=
 =?us-ascii?Q?a34UYDsg7vHmvGix4PqE1t5UkA6mVxzw01NZkZz49RXqCruOV+onC8gLvwMt?=
 =?us-ascii?Q?Wq13jgoOAPnyymYUQJuZYn/DrYIT0oDUdhOHUyPSnliu3rhDWwqiZ/hMm3m8?=
 =?us-ascii?Q?rbdEetLfrH3LscCGxfYnfHVe/zezShkIhkCpVQWs56+XeV6Ho/086dVJROPN?=
 =?us-ascii?Q?WI3jAWP7I4J6/azJKpfgiCUyFLKDsGB7b3gQ7FEUcl0qo65zwPpTKoLHKBnV?=
 =?us-ascii?Q?qU4C1sZsN0tZzrZkmhPKmssRNdyOXzgivxmSFT6ODuySlniAcxtUawwmsjiX?=
 =?us-ascii?Q?z5jjs/+uYe/R7GcarngQBlEoVqZkxq5zqlig/V8RX+6KUiwN1K5c2lM2OVNr?=
 =?us-ascii?Q?cauXNFBac/v7a2QHrSuhcP86K//hnQaXlGF8an4smL5D18UL3+LJFg/v1+9x?=
 =?us-ascii?Q?T4464MnswQHC+CEQOYmpL9BbijGXBcmHm382Dv60naitFDXoqljYArvuHIF6?=
 =?us-ascii?Q?Mcin6mulCwQBHBWsfF1DybnrQUezASvrRxZgOnI6Mfy9xLj4zmQpky9HVUqZ?=
 =?us-ascii?Q?rDh+4n1QXne4q+nvta7JmWq458MLrN9EkLHRxLMZ4DmA1BsP6sLy7m/PMkJB?=
 =?us-ascii?Q?LEpBqF/pFvivKHJ6It7RwbXLDNE+pC54PoP6E40lI1V2LB2BMz4mogWM0Ivh?=
 =?us-ascii?Q?1KmapNGfklg3SxYYdZPCfl1jjeh7knLSUy5+gdVpV5HtAQmEYekFfpjMSua9?=
 =?us-ascii?Q?wdEOk7Nralcpz+6PKHdAOdl+/VY6EpLGcokJe0dyrwnsZ5cICqSAwluuZ0Dc?=
 =?us-ascii?Q?nYkBJN0EQTwM1ZIQ4G7AqKKH+ECPvyQL+ZNT/+X2enCvRB0kpQymJvnAOxtD?=
 =?us-ascii?Q?UAFJTpx97Eb3/SF2rxhujV5sgD28AIFpTZzoAKfmZaiAYociDHHvI81s37id?=
 =?us-ascii?Q?znEbmRZysIhDPO0XvX6K9r3IoJgAyOksI3osuNKlKo1xRA5j0P7nqisSsOvY?=
 =?us-ascii?Q?/EMn4MYO8730NEUTSURETQiQL6q00oIeu1Z8LMrTnhu9oOpPeqwUab+8hQmj?=
 =?us-ascii?Q?QW7ZP6bh+HC3PldWo+BTehadxXda5K/VE+SeM3Nbfw5VeoweUscXkVol4TYX?=
 =?us-ascii?Q?N9M6lYJZpKweaL3PlVhmOjM9d3dDP5WjWfN2FaH1vTic6usJAIs3p+NR1VZC?=
 =?us-ascii?Q?/ov6+Eeb4UzLxJv0FyAOx0ZXR1U3gGJqL7g+alsDxuWVsGeGXfFUb2fGK2dg?=
 =?us-ascii?Q?getsycq6WqnzFBCi6Ku5Q2+O9cPHfSBWZzvt7tZjBhl8S5U0j2gRP0Q4gqZ5?=
 =?us-ascii?Q?Rw1FG9i9WrjfauhqncZ23OtS206IYUQ5qMBO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 03:53:15.6801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2463f44d-2dff-4867-2c76-08ddd953c471
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334

Hi,

This two small patches simplifies the devlink port attributes set
functions.

Summary:
patch-1 constifies the attributes and moves the checks early
patch-2 removes the return 0 check at several places and simplfies
caller

Please review.

Parav Pandit (2):
  devlink/port: Check attributes early and constify
  devlink/port: Simplify return checks

 include/net/devlink.h |  2 +-
 net/devlink/port.c    | 33 ++++++++-------------------------
 2 files changed, 9 insertions(+), 26 deletions(-)

-- 
2.26.2


