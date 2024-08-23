Return-Path: <netdev+bounces-121331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C01895CC27
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE3C1F214CF
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD1B16DEA7;
	Fri, 23 Aug 2024 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E21CgUwi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7561FFC
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415134; cv=fail; b=CtS8/0XDS1aW2uY9aqw7yJvmpB06dWgCsuKpvmQSXdF+YKxIczvZl7LDVYwIfiA/d1m3QkB7kkDicNvNAX0uFREfxhexvdVrVc6arJfWBkoy0uqZiC/3cOiofwHr2PAYkt5tj2bwX7k59XsEMO2IKWT9A+gm/YtJA2OUuCpfiqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415134; c=relaxed/simple;
	bh=shOXX59lM8YizFva0MjWE0eLze3mxrIH4PoCd3yrYF0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dT+GSWWkorTFihCrU49UU0KX4nUby9PO4M5gdDL6LTW+kOtCO6DuJEPl5VwPTAhB8rOocue3apH1f2EshIdkfclbZYfhaGGsmP/CJz1+wwWaOja2TN2xdec65d/O6/+JGcrZcammPvCV1qrQVLKEZy77o2oCo7pJA5txJkY6muU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E21CgUwi; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eltNycIz2Ad8xybHKZvcOfEVtGQskdj8ieE7Wav49Gu/3PQVZ0ckxoUTcpVQeu8N13xLlRS7olGNL0SDMiYfp5py7LkGfK4rlASBCzdrk5pXqrzkT/c2waatXzMLolp6RaVDZ7JlERR+rFlsxZ7QqRqkcZHfms19797DD6hHkCqcPDSLxzCdOV9qN7XlgxSfiL/te4PEH7p8/XP1yAf7ngIoNh4Deue/6jaHo5D3sNxz1ulfsEvCb11NQv2Sax88jlD79GuMp2v7wEIhlwUpTcGrsFHrBrIxdWkpybs+JSVVog/YnnFtCM329bDhoVQIiKcbyfDCSYUwY6z1vFS4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWiK1koBhGz6RVm56/fsR6ptb6Ys1dqAxJxrhnpTzX0=;
 b=UTCg0e7hJt8koYXEw0yciFryOb5iFPaJsQPXBWWrEkt8Uz6ZJP0iyLqRtNw8P7IGmI4bWzldIM7a6CpSODQJJ9eqs2840IyvU9UdSXbPtueJJ9atXA/GBkcnqJ9TUZ1E6DXGS9VQZa/CEullnF5y2jwivAcU9fM2DOu5/V8//bFOkwozOqKnPtYyYm/2d2Vh2toCyrh+Wem5qMW9J18JhkfRttAd9BkQi/o0QTvFr23jkhm/JjGV+Wb+C9pWkLFV3V2jePBZa3aO+nMIFmj50A8P4FGV1efXLTlgw4UOQeMUugPwGPwAPUitnMfc1odT5VPv5ZMV2y7c2CUg16phag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWiK1koBhGz6RVm56/fsR6ptb6Ys1dqAxJxrhnpTzX0=;
 b=E21CgUwiE/iaRJgirs4+x4wD0VmJ752qy2UUv9RZEfiioR97i4MA91YKzXnDj6iX53tNGSyUX0iSrHZats3HXrPPX4rL6ZfTwHRY7M7W0GnkaJsUpdQ4sg0K6+lad9JbJg64AeaxJINY0gg8QpbPjaN82QkSSiQYB1i/LrUQxGfLN9sJrwiQFVkwR0oi0Pl9orHP5n31T1ddcsEZiHN2UgGDbZRFWS16AWCUzxX9ZXs5o5NRDlTS6pM/kdndZjY2OaxCVm/lVZ+9i+NGSn7hsVsmLNU66aDM+0Trm9XVBjVTSj+m8knDVaJ+foL1qvY4IcXK0Cs/xzMqbTG3/uCdCA==
Received: from BYAPR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:c0::47)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 12:12:08 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::ed) by BYAPR05CA0034.outlook.office365.com
 (2603:10b6:a03:c0::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Fri, 23 Aug 2024 12:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 12:12:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 05:11:56 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 05:11:54 -0700
References: <20240822083718.140e9e65@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] forwarding/router_bridge_lag.sh started to flake on Monday
Date: Fri, 23 Aug 2024 13:28:11 +0200
In-Reply-To: <20240822083718.140e9e65@kernel.org>
Message-ID: <87a5h3l9q1.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca2897b-08c9-4c3f-1a34-08dcc36ccf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xlD6Gbh+u9g3NUr73nNg/exYAiFXhRV486txbBzKZz163IT5OHBOayIA4VGR?=
 =?us-ascii?Q?PEMcYFaNvglrOfYQzQ1uhpFcPsMBTdeghhtYWBLDTjNlAm6ZagbBUp4Yycvt?=
 =?us-ascii?Q?rS5BzeCRKOM8LxRbB/bwltCERUa04YQPiK/VY1ihqOX84yNEejkIvcmdDtkY?=
 =?us-ascii?Q?yiM0zrCJaSWEAT6nTQDGgA43CpC09AO89JtiAENJqKzVxxZb/BAgZvVDFC6j?=
 =?us-ascii?Q?YLT+mpltOUNiapku/PhN6NfhXHkjxYtXsF8mHNLMiZK8OGuUXnGXqKAQMO4D?=
 =?us-ascii?Q?AQugJCnUiw0jH8TIlpysGvz0BTW5sg/JZqxFuwiEY5zndYxDLM8TdjNj83N2?=
 =?us-ascii?Q?joc68GPGnE4GiBX8GMHeJr+WHvUWWxbamuwwIdRS34JoAReFHFZjkRJe9zr+?=
 =?us-ascii?Q?NItpMn552rnXl/CH5pTnyRt6lJEontGLRkpvQktoFKm2RpcjnIBFSUfAU8Fw?=
 =?us-ascii?Q?q+vi8caxr0rgAkd9SPCn0WO/4614ntTxKH4rJDzU73/JMU5RAc3TKy+I53B7?=
 =?us-ascii?Q?5UvQu/tDPrf8zL/LrLDwaNwa8zbO5rFwyDZu8AaZRE0KQrg+UH6+Ph5ytA6k?=
 =?us-ascii?Q?2sSRNUjZj5w890/IwHRWpSAqRy3nWf3ls5kkmGdvRtseNksQFodPVu+GhpG9?=
 =?us-ascii?Q?RWPHfhJpYX9HZKGpc5pZ6MuHAOazuydUbxSpnFksdtR/ZSBcAU53jnklHXNZ?=
 =?us-ascii?Q?6k1UgAyA+qsmx6L6KPx7DDnDoRpZ6Vo7aefTBg//eBcdHOaJ+7EIe17NzSCR?=
 =?us-ascii?Q?d+07pf6If+zxHexrkPUuOpyJe7yHVxMIMx2nWQjSfNuMWR/O+bw4xSU+Nnc2?=
 =?us-ascii?Q?KmyJKI7FpLGQEJkTRx+dqYHMnBDe7L8U/OmWJHFu7UuZDhL+3hqBofhoVfjQ?=
 =?us-ascii?Q?biQ2A2CUrRcHda02RD5Qe/EcNKlLeKihQZZdNLK2HH35xQwW3I9x2Arog/Nc?=
 =?us-ascii?Q?iJraLRVox1Jil60Re7QKl1FrSWJFT6eo60jvPXiISuNuTA+dyGGCBwxeFyfE?=
 =?us-ascii?Q?vwtDImXLGyrx6GSvgHYTNAKYChTAu2tGnRfOLVi2fJKnFobuY3GboBnftm6a?=
 =?us-ascii?Q?DvCNZMlgwj6nY9RqdHoWFYxeXnTkkNeK0zWWN8oCc5gR/sGrWegM17nP8wpS?=
 =?us-ascii?Q?LoN9HavSzZOdi1SIOYu1426YOYMx2EVUGa46tshtnupb7Av1GwFQcONmFmbD?=
 =?us-ascii?Q?KISB5gcPEhkFXvEdKSwvFxDZ31UQV+nmy/BWaPSom5oOqi4bh60BXe75ElVn?=
 =?us-ascii?Q?JYc+4VsK7tfFKdOozWY/LXzTcSH9tKU3KxEd9/7qUJR7xvSHn2mogG6SacRI?=
 =?us-ascii?Q?WelOlS2QcHcG9vT7boHuQQv5RQq948Cp3FfxhousbEeIlz8Fv31NrmXnqxWo?=
 =?us-ascii?Q?J9aDyxcTmAIy2F2jYOd88J55z64m9PtfAxfeZRk7m4IbVGAWz3WRitEftjZq?=
 =?us-ascii?Q?h1XxSxzbib6WoOmCqN38F5bM1thkjYF9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:12:08.3566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca2897b-08c9-4c3f-1a34-08dcc36ccf83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611


Jakub Kicinski <kuba@kernel.org> writes:

> Looks like forwarding/router_bridge_lag.sh has gotten a lot more flaky
> this week. It flaked very occasionally (and in a different way) before:
>
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-forwarding&test=router-bridge-lag-sh&ld_cnt=250
>
> There doesn't seem to be any obvious commit that could have caused this.

Hmm:
    # 3.37 [+0.11] Error: Device is up. Set it down before adding it as a team port.

How are the tests isolated, are they each run in their own vng, or are
instances shared? Could it be that the test that runs befor this one
neglects to take a port down?

In one failure case (I don't see further back or my browser would
apparently catch fire) the predecessor was no_forwarding.sh, and indeed
it looks like it raises the ports, but I don't see where it sets them
back down.

Then router-bridge-lag's cleanup downs the ports, and on rerun it
succeeds. The issue would be probabilistic, because no_forwarding does
not always run before this test, and some tests do not care that the
ports are up. If that's the root cause, this should fix it:

From 0baf91dc24b95ae0cadfdf5db05b74888e6a228a Mon Sep 17 00:00:00 2001
Message-ID: <0baf91dc24b95ae0cadfdf5db05b74888e6a228a.1724413545.git.petrm@nvidia.com>
From: Petr Machata <petrm@nvidia.com>
Date: Fri, 23 Aug 2024 14:42:48 +0300
Subject: [PATCH net-next mlxsw] selftests: forwarding: no_forwarding: Down
 ports on cleanup
To: <nbu-linux-internal@nvidia.com>

This test neglects to put ports down on cleanup. Fix it.

Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/no_forwarding.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
index af3b398d13f0..9e677aa64a06 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -233,6 +233,9 @@ cleanup()
 {
 	pre_cleanup
 
+	ip link set dev $swp2 down
+	ip link set dev $swp1 down
+
 	h2_destroy
 	h1_destroy
 
-- 
2.45.0

