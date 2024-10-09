Return-Path: <netdev+bounces-133455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E35995FAB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25207B252C6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 06:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8000D16C850;
	Wed,  9 Oct 2024 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mKygC+2h"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B41DA5F
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454902; cv=fail; b=akMNvQA3s9J8nZlWueAb1prJArBKNuEKMagSOQRA/E9xH0hf7gb4/gQ6SXKA5+CMC7yCgenCRhXQ+1GsIjIaL/YOwpf8Ue1C79110Qx30dmZCEwpMkrJhsWH2T2LtPgWNZXq4wmA8etPwGbiFWkg9WUJXd61OraIEWcvUjdJGLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454902; c=relaxed/simple;
	bh=Cg5XVSmivnUazZteuCb2j9yn6DT3z0hnyLrTlRdZT5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cp7tAJSv/vC66a5X+j0Apmh+j1jduKs1RpOCh1IZEhNr3r/b66yRQD6CwnIVc0NOA/M04Bo05K5nYOslbkUuGeIIedBz9CZX3xMpUFlIFQ992oA+VruagDTVm52DBOid4K9ONT+Zy/55hvL0ypkE7Sg715NnfpBrL3fC90216qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mKygC+2h; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXFvS5pmZSvtyjKEXO61J/sPrc1tHzLreIN32wszbjSRrFcG6dAo9mj1CjGmxEGelGa2+ERpl/JP3EIyupujIoud2fXUxT1rhbthEkCdbcueVgCxh9hpSh6jINK5vHRWnZECGbX+9mcknA/YvIKMY4UH8Glb52oKz9odKrPrENDh1Kp6xbNtJJj2LU0yvCKf0iYTo2J9zwBFY5VY+2F1F4WfrjkgRBRj9DuyVOv0wHbNEE+P1hTTnBiO0NeeuBJ10Do0B2oDqxU5ZcHPoQy+7PTb4JcRRUdeT+HMn2FBnyPHYexuhBq0BDVaNo6A+XnJs5qjRX5I3r0+030JRosmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+mBi5j+K/N85phXksGkVTvFnTuIe6cn+BuRcupSxg8=;
 b=TWsJrjOCoexmXvu+E/pVEni/K86vMogl99CE8nCQKl1ORzPXhxeRtaSTK7Lg93oDFypX+PzFaSwa0+rkJv1xSFjU0OSgZNpKdmKKdV3pM0dmkuEOJrgIT7D4tn5s3NoG32iHSbLnUf3F2gRtxIyEjeVzj+UrcQdhuW73ncnBdu+NcOV3latchrK9hQXe4CS2vfo7jACjGrBD771pQdYoYp/y424SnC6K1kpbChzyUTRHiIqytj1ZKxYYvXN4BYOnOii8K+9up14mRtcnU1mVvrHU9ETAjS9VyPjs/9hD8SOlyEwNHmZ6OakoljPJx1Mx+e8PIozq96s4EK0oAQlbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+mBi5j+K/N85phXksGkVTvFnTuIe6cn+BuRcupSxg8=;
 b=mKygC+2h/7RZ5IHyuvu0K0d4DdhqsPAhKmCe7/bYhqhZ/R8dmux+XG13a4lrkste2nTPk6KcXNb6A7zXMEcoBbmuEy8tJmVE8UjbaH4rJKsDBfp/uU3DXCV9fndmKH9Dv6bIoiEzxLp37q4qxA7OjLjoAf2sg9o0XyAOkkgj/5EfQDGNJvT5LSc1l0/pFkzPwRgkVpbo2ARLFxvR6PytoYZ9L1KpmgqLRDlj/rN8qDMVT5cogKnqKMJTHCZHnzluXcbN3OXKeFoOMmoqpY2sZEdHVjD2/XMcu03HLxfQvI1/aKPrkowV7q72sCrBIavov0SdPG9FjjELic7WgHzfKw==
Received: from BN7PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:20::20)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 06:21:34 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:20:cafe::8a) by BN7PR02CA0007.outlook.office365.com
 (2603:10b6:408:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Wed, 9 Oct 2024 06:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 06:21:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 23:21:16 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 23:21:12 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 0/2] iprule: Add DSCP support
Date: Wed, 9 Oct 2024 09:20:52 +0300
Message-ID: <20241009062054.526485-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.2
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8a7e9e-b207-4532-c151-08dce82a9fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llzhr8VZO12XUqoDmnXXcBvSTgc3JtZQiGOjFaaDlZKR+CiUWfHdNoGoNwQM?=
 =?us-ascii?Q?rZUoQ1y/9QfsawNoK4NwSfOF6y1uCIC8k2pzAb4ca034Zt9jp/n8E36UYbFH?=
 =?us-ascii?Q?FPtigyW6I+OvSb1Q0Ol1eDFP7LNjIaxqP84Y5Tt0yBlJBCgPGUpePoc117s/?=
 =?us-ascii?Q?787o+XNaPmzrxc/kH7LhKalrvSVt94irn0NpEeE7eVXLFPcGnXRJkvCdfv7y?=
 =?us-ascii?Q?YIqoEyOXVZ8GPW+KSspYxkj2mH9dmhuzNkHFHvo46zhntHlLRUns4wNlRxi0?=
 =?us-ascii?Q?mbz4mb1shoqAZKVtD3E7oaSTRecAGis8dLo1PhACoye6vy4O+sUpabagB52K?=
 =?us-ascii?Q?PLQtw9AV6v5EMPa1EgJW+TPwUmQtYNjCXCE7qRG3RoHQOgOdzU69avtU3Na0?=
 =?us-ascii?Q?h5dePMAVx9/WrIsq5wrwtQ0Cp1tZtmjSNs1ve2I60L1miDg2OKrEjwWX4Rz/?=
 =?us-ascii?Q?ZJRlZah5q8a+peQh6CUvrBmfNtq9sX2/7XGHeQwlH4lDx7S/l9sGkqjRn4C8?=
 =?us-ascii?Q?wA962V8yN+1qweYyMPsgVT6BUkje4zG4eXuUHMfm88cERoKt7e5OnLL1GxI+?=
 =?us-ascii?Q?5Qj2B71g9C7uYA/mOqBAUH39NmNaXDcrBYNfyAdViH5Q+RYGkmPwcRLQyY6y?=
 =?us-ascii?Q?xjv7yhqKCX69MVN8qcZpWrLWNcJ9aa7q1W1u2lRr1EME79VrH/0Ylj2JC6NT?=
 =?us-ascii?Q?rpENDzI9FokS+U4oRuT37hKKEZlVmv8MoWShJ3Uz/O/m47FFAhyZArgtCpm+?=
 =?us-ascii?Q?0JwOfwBETBNAiOUTBxICbNhhG4dtS5fMrDlp27nDKURoRG/CcWm2HV95tB7M?=
 =?us-ascii?Q?GwbdUi+2ecwxpOk/jN39Hz9yOo7J557ngVNppeDox5b8cGZxKpvUsxtJr6dE?=
 =?us-ascii?Q?opVzzZKK+t7Gd4xMIvjm4LUugVFoOdzF6DcPWxk9DY+LtsY7dgZMtET1No8H?=
 =?us-ascii?Q?8Gwh1/rQ0aCH2Qg66JM6Nm39kp2LgrUBGJqyxjDEXiIO8Z2eIZW2QDZx/gB2?=
 =?us-ascii?Q?LyxT9T+3cezTXX95WuvKHKqsWzI1cotkMkgk7ZexSb+NyZR6EA3JbpfxDHsX?=
 =?us-ascii?Q?DKRqVZk3u6IJzBnzGtYhz8bTAN0WIJbG5SLepkH4gFXnGIMjKVoYp9NYauac?=
 =?us-ascii?Q?WauDvKxZg4hX4CAzxF4CibpAnHZYg1YehqTehV2mOf2tgoTNskRchMAFenaQ?=
 =?us-ascii?Q?bygt2fXTtH46tzFtaCKRbIArBFN0Oe7VkSHF1SDvsfc00Z6lBN7DPJrES68Y?=
 =?us-ascii?Q?OEAyjXltNB/k0EfA8eutfIQfJEEKD+tBokOti9g4CMl+tg30Du7h+QIcRI7H?=
 =?us-ascii?Q?txOOKU7RLDbr8/3PGqnCephwBHegMbxxyuFb/i6OWcs3Z9U22bSpqeZpVL+r?=
 =?us-ascii?Q?xrVz/gMJ27pSrAeEBgLYHCD9U7HC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:21:34.2159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8a7e9e-b207-4532-c151-08dce82a9fa3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237

Add DSCP selector support to ip-rule following kernel support that was
added in kernel commit 7bb50f30c123 ("Merge branch
'net-fib_rules-add-dscp-selector-support'").

Patch #1 adds ip-rule(8) as generation target so that we could use
variable substitutions there in a similar fashion to other man pages.

Patch #2 adds actual support. See the commit message for example usage
and output.

Ido Schimmel (2):
  man: Add ip-rule(8) as generation target
  iprule: Add DSCP support

 include/rt_names.h                   |  2 ++
 ip/iprule.c                          | 36 ++++++++++++++++++++++++++++
 lib/rt_names.c                       | 23 ++++++++++++++++++
 man/man8/.gitignore                  |  1 +
 man/man8/Makefile                    |  2 +-
 man/man8/{ip-rule.8 => ip-rule.8.in} | 17 +++++++++++++
 6 files changed, 80 insertions(+), 1 deletion(-)
 rename man/man8/{ip-rule.8 => ip-rule.8.in} (93%)

-- 
2.46.2


