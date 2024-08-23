Return-Path: <netdev+bounces-121349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E538495CD8F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D26D2846BC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594CE186E29;
	Fri, 23 Aug 2024 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HaO8quVC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE45118660F
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418956; cv=fail; b=SWiomjTRQnfwVMpUQ0iuSrTzCTke2PKX4ccGn+NW4Cdtp+CZ3rn2+ngMGUmKwqGYh4zXORc863ncwRj9nnny8X/UWDXz7LdyxqzmNPKjFZEKXUdfpFJ5tyr4xE9+N4Fr9BwGMP8i+Ptm8k4jTIAWwm6Dx6BIaZzdfOBKMunPUsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418956; c=relaxed/simple;
	bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AAALzGNs28yTf8HFQE3j8ihasvJ9i5MinfgAHGYtg9HcBxMIAsNxkPVPC1VcpkqIXU51BYXw11ppQME1IL4mSHYpeIuO7vA5Zso6CIy9jc3YK9HKM3faP/QZsm9+UryNh08/41TblL8mZ35LKHfAHaAdwueH2Cd6UD15SDXJQ5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HaO8quVC; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msea1ImvDZJnGudXa5+68NnmNB11kAwYH/7Ub/rZsQ6xA/gzbfOVq09TDQJqMqlhV7as3ugdVjJ746xTBEjc7oJAU0m0z60q35InmcnK9w015jZ65dpNcK2BEAf22UzUC6hUd+2Bo/47ZaBPwY830mF6bkpN+7wL+omYoUUPK9glgO8bJQgi1BkuPalCS9nP0cSNumUt8yE0UPU09ZXGEWYPFWguQ76vDMqNThG/odqYHTthBO/L79am+lKXastoXx1j/Kd7w6qd6aTRtI7gHtHGKoEQAke4bJZjtWjZPSAOax+5Rh2pf+BVDA0uNI0/5qfCJLyvc3qTm9FjihZORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=NKN9IujNnYs8JYOUKysO6wncffFuUD9XHPFb9MBNy2DSDQf4ohCPe8uR3YAhPL+ixNQU6Ztb1+SsW4TEL9g+Y2QpT9wGI+yVjZyRhjXSZ5av6Uga06GlSVvWJ6Le+MhJxzE+p5xC/QjqYQiJ+k6+in0ZpusBSPKZ1csqWSoAfUYyDzqGmFGkKkNHPShTehTO63YUCbjP+ZQVMLaJJgT8nOJXI9+pv3Z4X0615qKP1hF5ej3qGVwKeVHYyeoGkOHXcnvSwpe/da614e67uwnKZlZR5Td2AcznW6SCGpaTEhuaZrB4dNPripCe+dBQGZOr9t71XCfjkU2SPSTJA0lYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=HaO8quVCKuvb0U1A12++AlcQ0SNSKbaPIw+jzcSqvTCtKyxbV5DB3eda9UThWX7o1kYNoHJocQNoNFBHo4txsKfdn8u+/MYo441ZPUFdqee0/UgHZrPqZOdXIfZ5JpoNyWQjqNhoUlRjMGTplm50lkCI0JJkLbQZgLMQOFO/+g/46A1IJVKSEAImxPPhngy0vp7ixVR/Chiuhc++ABviM7zPGK4qJFfi8l9eYf+hVrUwDQSJ7Dq/anbMR5nlU5WnP9TrgFH/F7hpC7fcWPtUvxAT9C8y/1Qb+NaH/Z4F4vwgf6lHZoTXR3H15JZEhjvBNg3qkI4gFkijUH/+W86pag==
Received: from SJ0PR03CA0176.namprd03.prod.outlook.com (2603:10b6:a03:338::31)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.22; Fri, 23 Aug 2024 13:15:46 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::b5) by SJ0PR03CA0176.outlook.office365.com
 (2603:10b6:a03:338::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Fri, 23 Aug 2024 13:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:15:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:15:31 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:15:23 -0700
References: <20240822043252.3488749-1-lizetao1@huawei.com>
 <20240822043252.3488749-8-lizetao1@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Li Zetao <lizetao1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <j.granados@samsung.com>, <linux@weissschuh.net>,
	<judyhsiao@chromium.org>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 07/10] net: nexthop: delete redundant judgment
 statements
Date: Fri, 23 Aug 2024 15:15:17 +0200
In-Reply-To: <20240822043252.3488749-8-lizetao1@huawei.com>
Message-ID: <87frqvjs7r.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d9fd87-9589-432c-55ab-08dcc375b2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mq+vdAF6vsip+d6oXo9MPwydWjC/xlsMP8CohxPNXCXduOLZeNtRgYJlbKe2?=
 =?us-ascii?Q?c6zdv8g7WZ6lRkehXd6BTkY8Lrkx02DuwBrPLpeRBV6VsfNiyFNDASKROVr7?=
 =?us-ascii?Q?oXUOFqW8L2/Srv/uISYm0/LAxPCnjdIv57NPHUu+BTSDQ5HOcuFkeP/t/qeK?=
 =?us-ascii?Q?MmQnEhLIDwUsvWRUhI/CR65CKJmKFeBnyvCa7XwPua8MkGtnD2AWhsEbEs8N?=
 =?us-ascii?Q?lj7kWygEknO/o9trhG7Whbb3N8q/iuv9QLcVJMiC/kEBJni89V8t1XA78hNR?=
 =?us-ascii?Q?O3WHGo6RrKkoQSvNHfc/pyhTXkxId52+FgVBvAWcV6uClgkMkDTQqCV8R4zU?=
 =?us-ascii?Q?aF9BR42+xmwkQot0kD78/j/q00dkoXcY8ykv2mnFrNZjR2F1KYLYGxTuXByt?=
 =?us-ascii?Q?NqVYQy/zTP3fSMP41UuScHqvdwP9eqeG3niURal2l2ZZ1lJiAjjYWwDcNKvN?=
 =?us-ascii?Q?hbZBQSKXOmx9oSBi5HHS7axpPoXOS5ph9viqBr/WooVLL1r2/uOTW7bF9eCW?=
 =?us-ascii?Q?9C+CRRf2Zuff8LX6W1lgnJS7cdMXJqomUBp5N3l0TbbKuntc1EBbU+myJHk4?=
 =?us-ascii?Q?5CiD13e7Uq7H99mC4Gx5bM642P7kfiu3Y/Up6/3Gqa+mrh7ZiIveTVZvlerC?=
 =?us-ascii?Q?vG/BYycbkG8t9AcxM2giUtYPnTrr+CDEVYzl0u3JdaR8CoApxGDcBqUtCfPw?=
 =?us-ascii?Q?eTbQyxUhmf3OYrcfPsxRSgDgjrxL8s2jG6Qu9RudVAkqddOz6vG8E7vZHufT?=
 =?us-ascii?Q?zLLrjB4BBESL6SdJzEutgxUy3qLyiX7foecWZwx1fJHnHmlYZagXuCQpfTck?=
 =?us-ascii?Q?gd9TwzzkvQgq/PKFpKQD2PWwB/e2kmFPqFsZWSi86PDXSd0q4Uw4aj1pj+4q?=
 =?us-ascii?Q?w+2wtBWzCSGvAd6OnBcXocbEbhZcy7FTDEilSoZ5GqgKxrYilnFxR4akkdi6?=
 =?us-ascii?Q?I76vkQ4O+4OQaTOTNpCH1kcVVorgfCqgTF7Xoc+yZO8CNENi8AlqKUG4c4HO?=
 =?us-ascii?Q?zbOEO2UisfOoyIxS3H+KrW1D2dX95VaQ9rqMnV7hXN8GgVln9c8R3dgePtSJ?=
 =?us-ascii?Q?TdLtD+CNgaY3apuq+VQTyRkZr3GS5xFFXJvgESp85SvV8zfH5t9tsv1AlUm9?=
 =?us-ascii?Q?u9MFoM+aoI+3kPZ2gv3iQrEcIOZpx38o9+Mz0W/jPZ0EzyMUuInmzpd4OL6w?=
 =?us-ascii?Q?YE813CZe0gr5zBI8iU5SQ4i4+cKhOk6LozUS94Mfn/6S3eXxBNl+ExPATEpN?=
 =?us-ascii?Q?LkvXW4sx8SBV6PiU2zhUvbQR/qpPwEvPEVDhjTk62EYlGaze8DtzZ1YiRMiI?=
 =?us-ascii?Q?UnpwB6olwY/hVRGTT9NpX+98QC88rZvaYkfFWp0qxIgN+xhKOsfZrcXRj4ds?=
 =?us-ascii?Q?dDrkOiuWXovIxULBdPQqZkstuPbUb6CEbITvaUpMH9CPB5K+Ws+g/RegCjRm?=
 =?us-ascii?Q?cffpiJvfhNoCTLyB65VZibQ2HCzSoDLk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:15:45.7786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d9fd87-9589-432c-55ab-08dcc375b2d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414


Li Zetao <lizetao1@huawei.com> writes:

> The initial value of err is -ENOBUFS, and err is guaranteed to be
> less than 0 before all goto errout. Therefore, on the error path
> of errout, there is no need to repeatedly judge that err is less than 0,
> and delete redundant judgments to make the code more concise.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

