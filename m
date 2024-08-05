Return-Path: <netdev+bounces-115686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFED8947889
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B7A1C20C14
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D1D14A609;
	Mon,  5 Aug 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OtmZdgb0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C7149C45
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850712; cv=fail; b=DqJ9/2QdzwJN5ilBgnE1eAk/vYom9bfKwiplBPAkfw1CilpvCKPrGGRR8dWxndvaU/KHYqjlxPYmlI090lFC3EeThje+I5T5D4Yyi9W4cXURF9mGBkvWFmiX1xM39+cmoFbXq+WDNyNXgzxk6w8aEuXHoYf+0W7vus1ddZgx0lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850712; c=relaxed/simple;
	bh=+xfAdJ1y0evl8k9Vc5ALuWqIoLMLl+IbKomPPAZrrm8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EublyxOCBWEUhI9tMlWFCvh/CvlIduDIdEqXR2WQR9Nz0ttc6xmY7zcu4cXqD5HuqVxeEhykNboQMLNGpuhQsGllePqI7hako5cdquuDPzunNQ46wk2lj6ovnUG3gPwXu4+lNjUAf7iJe5fzjj6kPg4z7W5vlRldqHPnpO59sqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OtmZdgb0; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnPfKYmmPWlHN9wn75E8ivlLcMUxuyy7e0678lvF0KXt/UOBohqNJJ4yiTbYw8McVhSQdunQxAdckrMedBL8+rQ8J80sXGhYDegk+CtpUbkgvTTBI8D9xuD8ra/4Qn34PYgnw+oVjArChCJGNqdLuHtVYKrdYg/u8jTcZ/ehhXsJHkL8XnHAMzlCI6x2aSaTaU/SZFgdqbcbqLXTWFCks8hu8qDQUJbhYUrIhJMmw2L8NoYiRRcHffdNopeEKoUUXM8oheNiHEFDgMc7C+uqdkKYRUqgVOLp1WAWH3EwGwQznfghK+0JiZGCHnUd1JY+TbylfK0kWlu1aP/3KedyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBWyoDyA07uxJN7KW70rsS6BDYv0io4qM0PjbyIqo7U=;
 b=AaXOOmW38sPOKsze62Njgw/vmS3qmBnPru7q+zG/43vIA9UNfc7v5mOOOdo5OmSG3eXlQm53QrcF1c1CSxzVOUe5bRDFKv93t+BaT8kurIy592kTp9TxJvfjpUMyvA/1+5bh9yvhs4gAJQTImHL71+oBOV29beT3goSxUf+HJkCzYuQHB4qjDYAkMGuBdGHZ49623ODiOYaMQ2XK1ccRNQ3cKXKfBmyAgDbR45RD0XBULXXxDsxGNddS71eLitQW6YeBlwV9z1TnDnJYh4hhyxIAjjFLGLENAbB57gzDoeb6FQ5oZ6JIvQxo4g8IDsyj69nt8yc96qIQaSSzxJvE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBWyoDyA07uxJN7KW70rsS6BDYv0io4qM0PjbyIqo7U=;
 b=OtmZdgb04YXS4oE7Fa8qjFsqR+jOfPlN+YZivesxONDNz83Tz7QvGHrn76FRzxn8aK/kWkq3vI5Q090bsK5qgUSS9587QuUYrHLJ6EEJvVWbs9HOS2hcesv7/ZbmbLucgx5cJVqGUCSjRE/QOLLCFz3iuzEqkC7VUzJdOr9W/2T/8tKs3oVdRpkVfDZ6cMqmA4BF/a+2bVpr837bwFYW5yIjna72gsgo65lyClw262ZeYevdR3sp1E4oeEtBJYrRmzKQdQRgEJnUSxUXTUm71RO8wXArN/OUc4fSzOgHL9tk9yeWLnyCbjvsnbKSrx7KxTcuMKTRzLr8gdiYRydsyg==
Received: from PH7PR02CA0007.namprd02.prod.outlook.com (2603:10b6:510:33d::13)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 09:38:23 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::cf) by PH7PR02CA0007.outlook.office365.com
 (2603:10b6:510:33d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 09:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 5 Aug 2024 09:38:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 02:38:11 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 02:38:07 -0700
References: <20240801232317.545577-1-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <sdf@fomichev.me>, <shuah@kernel.org>,
	<petrm@nvidia.com>
Subject: Re: [PATCH net-next v3] selftests: net: ksft: print more of the
 stack for checks
Date: Mon, 5 Aug 2024 11:37:41 +0200
In-Reply-To: <20240801232317.545577-1-kuba@kernel.org>
Message-ID: <877ccv5myt.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfadd53-6890-41a5-b171-08dcb532593c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HJ+Cip5a3d6V/98v++BOf6xOz6YIIbwbW1+XoCQ8WFjh6Lm61TcKM2V5HmOs?=
 =?us-ascii?Q?tD9JlFETVjfKJm6u6JCFex31Rkfu1jqR2BONbLsKDTLI6wV+OZt1Uvp5CJoD?=
 =?us-ascii?Q?Ia+XDqSyrXRegXExJMnObhP80960Qa9jfP6XgYOP+mA+olA7LP1bOks2ggdN?=
 =?us-ascii?Q?wZYCN+3oS48+jbPekVtYKOQ5pILf9y2A55BCB2iMp0QlHaarOPtj8OfPZJ+7?=
 =?us-ascii?Q?qgV6ST9l0uH3LvJkYO3azv79XcREdG33XGiUfQY6X1Dce/lEVV2d+5x6pOhd?=
 =?us-ascii?Q?Y/HtgLMFJszSGjE4HIFwnVRO+QAG0e3S7fHL8Qy7l5y5SlNpVFlRS1DLeuxe?=
 =?us-ascii?Q?IAW+IctVOULxnwNe3s3FL0JLHKLv1g+Q2uzWjcI1wQi2csSrVrwfHQNTV7v1?=
 =?us-ascii?Q?o507Q0DDUEgdZs1hN8I419UhvEWQ/Hd8iMnl+5D9jls0WbxK7ZMjFA/bELRS?=
 =?us-ascii?Q?Q1Dv1DXSs8NuAL+0dguZPsSxQyqV7OvnMWjHaABQ+s6c6YZHfypjTFs/I6bd?=
 =?us-ascii?Q?DuXQfyHEzKBGfzra0r8+f7lAPs+xlR3jDIFlZaX96trNWKeV4HGOmfuuE6yg?=
 =?us-ascii?Q?58Uh83/94sqEEoLLIfgY7grcxDMDiIrLbs1pysJpZ+oJdRdBCzyEWYmo6yON?=
 =?us-ascii?Q?ujlKkkQmP/eLCrP2rMEuQo9PAx7JEk+yoeD47BaYyPwLbsU+eucB9JNU9i3m?=
 =?us-ascii?Q?nwGF+k6ha4+KourXK9nmmKwB+SZk/Nwi22t64xWbZwAI0UJuASjQGLVTE4oX?=
 =?us-ascii?Q?LuQq7pAsNuoLGZODhQIDVEmo+LAibZWDA9dHGrWZe7SYMw36HZk1BbjU3N7i?=
 =?us-ascii?Q?0p+jDdBFxCBu3Y8QVCqGViSd28vkdYP1JoaO+3pl1p3IgEa7zfgJHIFfo+gp?=
 =?us-ascii?Q?I9r6y0tHA7C6JLhUrZeLNk/cDbxOsWxVBsbvyE6Waohojyt9ksmit9mDsMpK?=
 =?us-ascii?Q?TGCaGhs8HlyKy40us0kiW2WHjW49rxZqjtpX0+dCUlJsT8A12waGo4+Ptu/4?=
 =?us-ascii?Q?V/q5x+Qo5/EKk9XjP+ijSq163nyzqOXuFPLnCtV/Tjki4hgPn5iWJ7ltCDDb?=
 =?us-ascii?Q?/Ex0GZkIzB2Y+6WSwXjC7SC+Tu+N9pNwUYSdeM5gRc/it9fsL8E2NgySz6if?=
 =?us-ascii?Q?XHOVSKdowqDPmL5W8WVOR1ne9oYoeEkuwxF4bknF7Sji0wJYvjsj9Xzmq7d5?=
 =?us-ascii?Q?eISb85Oxgw8uje/poKrAb2/FUvyCGZzS0fFzQsSMnARsc6TFWpvuyskwt7cb?=
 =?us-ascii?Q?QYjiHLmyaQ/MIqKVLZ8fzXcoC/p4Fga2qrkpbIP88S8gIyC7lEwJm+bSfntD?=
 =?us-ascii?Q?nYhUWvv5/UHmDeZWxvr9MreWcDs3ycvDeTgOY9IiygcyzQrPrCFHCvSenPYi?=
 =?us-ascii?Q?I3Zdip/ZjszcfREXEV+GNEfN9VaGzX14dls0ibVmZ31xhJSvSC+9EpqOLjuL?=
 =?us-ascii?Q?4wl2KQJZXn8/aoyANZrSxNs+4tWbR03T?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 09:38:22.8816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfadd53-6890-41a5-b171-08dcb532593c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568


Jakub Kicinski <kuba@kernel.org> writes:

> Print more stack frames and the failing line when check fails.
> This helps when tests use helpers to do the checks.
>
> Before:
>
>   # At ./ksft/drivers/net/hw/rss_ctx.py line 92:
>   # Check failed 1037698 >= 396893.0 traffic on other queues:[344612, 462380, 233020, 449174, 342298]
>   not ok 8 rss_ctx.test_rss_context_queue_reconfigure
>
> After:
>
>   # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 387, in test_rss_context_queue_reconfigure:
>   # Check|     test_rss_queue_reconfigure(cfg, main_ctx=False)
>   # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 230, in test_rss_queue_reconfigure:
>   # Check|     _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
>   # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 92, in _send_traffic_check:
>   # Check|     ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
>   # Check failed 1045235 >= 405823.5 traffic on other queues (context 1)':[460068, 351995, 565970, 351579, 127270]
>   not ok 8 rss_ctx.test_rss_context_queue_reconfigure
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

