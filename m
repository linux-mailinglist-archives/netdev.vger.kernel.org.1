Return-Path: <netdev+bounces-106834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FFC917D6E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68A2B24462
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67046176AC6;
	Wed, 26 Jun 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jIWZ9l2o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0E175AA
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396745; cv=fail; b=gWnmLZoFQyk+EaUCpUD3+GhaCKHLE+CoWLfCN7SNTFB5HMHP9AKonRZzfJVQUBXr+Ah7IO0WUq7s9gZv5MeC2RxPMwktdJ9dCL3rzyHdiducG++/gVuji7IhfBLk/hPCU5UXEOntbJEQmRJqcayT3Ynml4DwRDjLW/MGA11tGdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396745; c=relaxed/simple;
	bh=v4d5lsmeOlIFQTJvXvwG+Y28Tv4VYk9mjl+NniXSQMU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YRnVzjoaZfjjuTGxYqWBG1JshVW7/NNlIivqqWJfJFUk176CLkuEBV0jW9yLYP0UPVE4c4pn2wfMc9Fbbjoye57EKD6J/7CSQs6cWuorIlEdurjIfR4LxjfBVT8Z51iZnEK+Yfp0sqtUaCPdxj9xsegFs5DQCluu0Y8g+Xpy220=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jIWZ9l2o; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf/gWHxWYx0eI8JeKsWmEdFJaTOl9u7Y1OBYgxO/iRZoshfNCrrs8itAYyb/pYn7qSZgMsatE4Ngwh+01kKnqc0z6Em+aGgBsPDtiWucRYkdCCzp8VtyMQG4vK8q+64bhvHyupmE5Yl4pnY8VTTukBZZN/XVnBJ2bGoNeFxGkvYq3iAqidk2xTj42WPMrt5o29oaC7q4lxnhcqvSukZ4dR+FyXMRoeHPsQNRqTj3FQBawNMm+NzczIi04+7Lyu5eh6pHA4xyEGkMtu/Q9ma6L6nBTL2fxC7htwYT6ko2RmLih4DMO4Ie70ryh78/4trqHNnTQBxOR+dbAxJjUWUEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cQ1IMOM0/YyrzZzjWhK4MJlC61a83V5gK1GVCCEeU4=;
 b=ANmpp9Vpr7wfXhHR7UrXbkKd6BWxcCjDpkqr6qE/SH/kuPPrwgfX6p/CTc9Q37+K82ggDpriHpjPyKoEC55jlqb5m/wsmDg7lmxEdLjVztCCJ+a5IjcW9tIW7ldE8bzTzFUcUSk+/SyD42Apbp6GXOhBrGZfA0+GQZ38etIVP937zjNYzaRKJBuqXfWa0tJAqUxyaYGm3Q0NiAR50KgTK7igZbJN1evlnk9JNmYyGcsNDlwZtZUFJJvLzWHjh/YrxQkU0aKZSWiWtZMs42UdG095uMORQRbKAHA3ZxAsgKythBRa1/Tw+CmICUDK2spJJ3/s8yVtlBCC49Tafu43qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cQ1IMOM0/YyrzZzjWhK4MJlC61a83V5gK1GVCCEeU4=;
 b=jIWZ9l2oHa6LPjnW0Oqb0m1YCodEOespPHoTJOVxZyVphNUYX/Zdq29K44yiAM5tiPtTRfU+u66ewGdpnvMx13rpTmH8Mvdmf3ZBNliZ3XtkKUeeug/Yz3Iz+ieIBqYzHYCehyIqxF2iH/hl1vlzYa/lSSKWOS2xaPjHDircoLLjCaqUjpbsxTlW0bf+/u73Z3r2Q/i18NdX0kwEm9rF22AfAbIj2MNpHYqpVwTALp83KmTmzSvmrsOEYjgdHDTBulLTqUt3pB+8efupx4xUsNaAVx3d714oQQHEruQ7ev+txFHdpY9FZRvJ99ol4il7ECWQzzYqmQGh7gzaoRFu9w==
Received: from PH8PR02CA0024.namprd02.prod.outlook.com (2603:10b6:510:2d0::16)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 10:12:18 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::8e) by PH8PR02CA0024.outlook.office365.com
 (2603:10b6:510:2d0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:12:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:12:02 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:11:57 -0700
References: <20240626012456.2326192-1-kuba@kernel.org>
 <20240626012456.2326192-5-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
	<ecree.xilinx@gmail.com>, <dw@davidwei.uk>, <przemyslaw.kitszel@intel.com>,
	<michael.chan@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<leitao@debian.org>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next v3 4/4] selftests: drv-net: rss_ctx: add tests
 for RSS configuration and contexts
Date: Wed, 26 Jun 2024 12:11:45 +0200
In-Reply-To: <20240626012456.2326192-5-kuba@kernel.org>
Message-ID: <87cyo49fo6.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc42b30-4ea3-4fb5-c3c3-08dc95c8758d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|82310400024|7416012|376012|36860700011|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gjf6u00Ejz0nd72voSCDlw/8FAxbEVRHpnFvMd2PJq36v3C+a9d3KuCmyRGz?=
 =?us-ascii?Q?7dVI81WpdixrW4m+XSh9/S60I/DoSuJ7JI02bC+niSEGXzkv30K7+tTcjgSS?=
 =?us-ascii?Q?tYJLlv6HMG9dd/wPEGv54A5bo0lEUwK6y1SGHe0Qp+S2MwTylycuJX1dKWW8?=
 =?us-ascii?Q?s8JkvQbrQg9l2uYuhXMpGGt9WSaJ/acaT2/LAWw7MESd8ejDQN7+yOuoZ8sw?=
 =?us-ascii?Q?dNJpukQFwjv5cTefmWE6J1yMJc+1neJnZzCumUgqKwKhyZIZZS+/JVDRItjP?=
 =?us-ascii?Q?xko3RE7O2m+LLA04dlZHcW5rJ+gDC07PuAF1qrRl5xysYohDyNjLMWUqSOHn?=
 =?us-ascii?Q?ZQVrkhXGL3m99mnrsTL7Qm9TovDeUYbo7qcn38IdbgUawGGaA7W4bgz4yvy9?=
 =?us-ascii?Q?O74acAU680u04GYq6UOI57aFgKlJVcRh/+xDnBdiqFM8YCsK3IMPZqkWNf8M?=
 =?us-ascii?Q?hRdEYYYTE7pXbpe7Uu+RsITpqjpv/NwafGNKNxcv1fxaPj73rGLmGGlMaBaJ?=
 =?us-ascii?Q?eVwwTihilKRgcDQVu7pJCZpGHj7P/GTWbO3XiYmYqAvI4+9GWHLZj88dMN7X?=
 =?us-ascii?Q?bOHHaiB7WfMvQurzEbvceKGl6eR388+F7FnLrQ9fYDmGIkDmoO/b0G9bdyxk?=
 =?us-ascii?Q?hFI37EmDHXWOuLw2uPqNjD5JejsLHU83N+QwXg7PdVHo/QpLHpPQDoAsgi4T?=
 =?us-ascii?Q?j+su0S7QSorl5w93YO4Tt1sFLBq43Etvu8se7zs4KfFQm+pB2v/zwX4fZgSQ?=
 =?us-ascii?Q?/cFUUSYLxkKEo7WhmGFA6Ta8beSBzC3kSqIEDBk6LjbcEtCy/+a93dQ0kpZv?=
 =?us-ascii?Q?07qhSaG+iNyNuzbNXhjdMf9LmHdNS+J5FFfThFgoF7Iv5Ql3OWWQ9K4io0xP?=
 =?us-ascii?Q?tbWrzIJnYv3mM6r+NPb76CuoxXTtDNFWdppPTUa6ONBauiy6j8QGSdSSC5mN?=
 =?us-ascii?Q?3LHSxKJO03QR0sNqEkQ5QPnC0zQavpAYCjU4JN+hRfiA4/8r1a0v4QYWi+Gd?=
 =?us-ascii?Q?W8Op1/nBGkGP5VKBtpojE6UADKv0c+YpVDBydK1HzQbddpcbxBnwzPHS0KvK?=
 =?us-ascii?Q?nF39aDGzrFcRVoH9F5ky9ruXu0j4EsFQCbbtdNX+5xNVjPX4EUBQurPds+SF?=
 =?us-ascii?Q?69dBrUJo7nJAPbWx5970118dEntjcWABND91C1Lv64eeV2LcMoMncLRde/mM?=
 =?us-ascii?Q?PX9ZWb2N0OiR/T6zc7uYmn3huqNMk1ykhhO5zGONRuk2ZNjOhZXf8/q2r0iV?=
 =?us-ascii?Q?RpYrd6QxQJNVd0WcP14VHgZp5X8rBr0F6ye59NI0xe9zYuKyUfssbl09NYkq?=
 =?us-ascii?Q?RKbnTWy5DFN4XeYBRe1gTVE4rnW9/5tUQf/s7BJzd9LT7h7WsbuW9JGc6n9E?=
 =?us-ascii?Q?6S0tMni5I42X/J5QUMusH+K4cLOuEXv1AUg2LAcoKNfx9rA4jQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(82310400024)(7416012)(376012)(36860700011)(1800799022);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:12:17.6584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc42b30-4ea3-4fb5-c3c3-08dc95c8758d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920


Jakub Kicinski <kuba@kernel.org> writes:

> Add tests focusing on indirection table configuration and
> creating extra RSS contexts in drivers which support it.
>
>   $ export NETIF=eth0 REMOTE_...
>   $ ./drivers/net/hw/rss_ctx.py
>   KTAP version 1
>   1..8
>   ok 1 rss_ctx.test_rss_key_indir
>   ok 2 rss_ctx.test_rss_context
>   ok 3 rss_ctx.test_rss_context4
>   # Increasing queue count 44 -> 66
>   # Failed to create context 32, trying to test what we got
>   ok 4 rss_ctx.test_rss_context32 # SKIP Tested only 31 contexts, wanted 32
>   ok 5 rss_ctx.test_rss_context_overlap
>   ok 6 rss_ctx.test_rss_context_overlap2
>   # .. sprays traffic like a headless chicken ..
>   not ok 7 rss_ctx.test_rss_context_out_of_order
>   ok 8 rss_ctx.test_rss_context4_create_with_cfg
>   # Totals: pass:6 fail:1 xfail:0 xpass:0 skip:1 error:0
>
> Note that rss_ctx.test_rss_context_out_of_order fails with the device
> I tested with, but it seems to be a device / driver bug.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

