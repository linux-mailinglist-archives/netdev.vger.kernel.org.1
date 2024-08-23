Return-Path: <netdev+bounces-121346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C755995CD83
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD9A1C21662
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A250018660A;
	Fri, 23 Aug 2024 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nq/jN1j5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A4C185B7F
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418902; cv=fail; b=RqPQa9kGijpCJyLqRybJ6XyFWkWuHsU9Pu3rcmC9x0YQ5E/K7IjLGxNtI+PMUcTgtIObtHkTkelwkxZSp9b6azjkdbDe0FkazrqvTUzJrYbUhZ55VTGtS+pR/tX8wQVIiIwccp3IXS/kczPBCJtZJ7fDYhFbZl5yf2wX2+LSFfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418902; c=relaxed/simple;
	bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hi/T1O8iz1HZcpqhHI3FtQa7D1atKUcgP9CWY80frD7WRVBvSWetJ74IATnwScdKK0IZjjXGK2W3DKauLyQALQHed6v8fDIOh0m2Zqapw9Ke0A3vMjp32aruqvHL777hv1hVZe+QfoJlOBSrcy7bzvBTlKQNZ8JW/SvlgR3UZ+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nq/jN1j5; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHT9Gy/lIntv1O5MFszywTQtTntvDX6J04BahGN1bKse898CSCeq6kqdju4Mmcb4k1wUDDQeDUiOlgVmdxJYWoigZxCqH5E1JChDix6UKLu9k/VD6lH+8+DV48FmJUfd3oqxxi3IiMeyeQnmVV1gWgN2BdDc5FgU/HFBMv4MNZpfqdoXYxkA2++krlPAD8qoXauq9d5VIZ8xC069Vv9hmDxDaagy7by00aWMqTxaprgHUtUzY1P96F65Cw29eplJwKvxOS1v3BvpAHh7/BL/2ZjaRbdO7VSFfcPKOPBwgNWTr+TdxXqN2eC/D3vla3KFxp6+VuK9QyGeVdEJ49jZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=gVvKiEiQQ+8LJrsYWpom+qBLpX892rViDjMuML/yL9YEVxXInYVDedXxwn75SrxfCMC9JAOICWzKgqfQkf+1cf7BrnhmSAlxUynA/Gk6rbfjQh7jr//XaNX7xOuyYUL8cgujEDowK1Lak1uLjBzm0ebCWioMcVebY/lajTaBUwV7XyaFX/3sGrrJNW7zcdTmv17WbjjRIvYrRwUiRof3BNZy4F/F5xEu3ypzLgB+Xo5EI8zgaqNvZt8uLklzgeMo9bx4rVv7h9HhPu41f4zL6Zmpe4UDpl7ogZOe90+DwERSMBRWSNWYnRY2xDeOWX7L+3m4IMUAXKc13W8hNdhmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=Nq/jN1j5bJV9uzsb63/0UpF+L9v1bRxep31H9fCBfZpCWKEb/V17WF5y/dt2M+FYBC1AFCZkbH+2XI9jpqHNuab3by0LXn8zq4Ua7i0wTRCAM6HlfbtAWIvrqc1qPi2NWJsHgE2jDM6Ns5SSaFZFYQX4KeFRXEekta5FdDZQp+6IN4JVlaZfCGq/PjHmVuVMt4MOPNwE9gEDbmGy39D/Y/8iqnFLxzZ+MYsomJpTHXcuJU/RfaD3+nv1Z82xjlvekGk32ToDqKon3539YyphS3cuSzWnfB1zcnPiIwWK/M2hWwljKFJG8iW5d066qqZ9BMNMWvTLqcVIk2q9YD0KtQ==
Received: from PH7PR17CA0045.namprd17.prod.outlook.com (2603:10b6:510:323::10)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 13:14:56 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:323:cafe::d9) by PH7PR17CA0045.outlook.office365.com
 (2603:10b6:510:323::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 13:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:14:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:14:37 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:14:30 -0700
References: <20240822043252.3488749-1-lizetao1@huawei.com>
 <20240822043252.3488749-5-lizetao1@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Li Zetao <lizetao1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <j.granados@samsung.com>, <linux@weissschuh.net>,
	<judyhsiao@chromium.org>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 04/10] rtnetlink: delete redundant judgment
 statements
Date: Fri, 23 Aug 2024 15:14:23 +0200
In-Reply-To: <20240822043252.3488749-5-lizetao1@huawei.com>
Message-ID: <87seuvjs98.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d381025-549e-4abb-0672-08dcc3759589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8uALbwITyiZYFgJBBNOcXvUK+WfVZ7KDCE6mWYk6dVBSaeXQ2lJjgAXUzcPZ?=
 =?us-ascii?Q?8z20FuPuhyRc01mDoxU49VBZYXd+xSDYzn0dsrXadAnA+wzdLWyAVw/fGIT4?=
 =?us-ascii?Q?kOxqzxXmoCyGXk4H0u85PnyCX7TaWVHbo8qQfbtfjuw0d402R21sN/r+1y9i?=
 =?us-ascii?Q?Pg9FfWDMUx6N52EoAiEdHozdJkYKT8oIU/KJuyIhBmE6xw5EEasZJK86OcjQ?=
 =?us-ascii?Q?ZyGCTZyNN6YfR9U7sjbAefqRg1Xp5K9/Ko8ReNCYkwpStEsFRAYvzhhGFqV5?=
 =?us-ascii?Q?xo2qVZnDHww2HAqM66xZnW5+2FF9wqAy+AwBZd51O0ugWMEVvd8HBG9n3y3a?=
 =?us-ascii?Q?URNphK7l1IKmTLXT+bq2dHHmJIF6fIaDtS8DAt9RH8nfsECmS2g+aGFDEQQG?=
 =?us-ascii?Q?sDuthT0daJuaSa05qDyxE6ALKfLvUHsU9jlBrFYM5AarLGMUo5vV1U9YyfMj?=
 =?us-ascii?Q?vmWh4QqCkxHsmPPQViuRweQNq0GQQOlKuaCn/HhKBEMU9uxpU4RHmstRfTlN?=
 =?us-ascii?Q?+QHvNlnQqBijRT8TpAowPhp70xzZmPHhw3kMDt6VkLM/Hkh6imBzq3jeQvN5?=
 =?us-ascii?Q?krbXmAPIE7yfyOSRuCIg5uxrAkaG2/reptiesfWYfKtDB9atOMAPH3EzKXSe?=
 =?us-ascii?Q?6NUXm0gnHwmPp176MOXHuJtXwgHEXdNf41p2aoKyJxwqIpwsUgpQIuYcu054?=
 =?us-ascii?Q?gdY+T6gnF8rElPZO9qbcCTpcKsOSioZ9dkQBDiZ70qL4N4NN1Zau3DlCDYP6?=
 =?us-ascii?Q?sNtTGEis8M23j64UrOvsY3ohM7S2Dv/yIm4O9T8fGw7fWhzgevDSEMgB4uZd?=
 =?us-ascii?Q?TeLnekXraaXVs7oOcEmRLv0D2xEvnFuFy6xz1Y+3zvrD+alxNKLzX63zaZ3C?=
 =?us-ascii?Q?Ldu4GBIKBmTRc3MxpsPIMnqgooub/3WQ2r+aQEq4duLle1F8ioETksgZ4Mtw?=
 =?us-ascii?Q?lMpfl7MlAbfsqqPuK8XbgO0QIT02q+pwDbpAT07/81B2jPNeD8J0Jrlqbr0c?=
 =?us-ascii?Q?5lj5m4AyBK8tsbcbc7+6l/vV9LteAjO4ZQB1XV5hfUTsmRqzYlpb1WT5Pbsq?=
 =?us-ascii?Q?kGUy426dbmZOW1Wv+xLwJFJr0RCNIM6ehbDcR+zQcARl3EopBRJqq7tSN0PU?=
 =?us-ascii?Q?EMEu7b9/HaYQbgg2do7dLJIU2xMcXHPFkgiWuzqrRFO7npzsJ8G9ZzEK0kJH?=
 =?us-ascii?Q?aiQV4jhI95wZsmRKLdomQdkWyf7bTLoC6j52rbhf6WqX3SQ8V8p9Zjk2RC5D?=
 =?us-ascii?Q?V3+t9mUHjn/ryxuvv1UOt13t4TWoMb6dfOmEwTJKVWvjLf1V7raHA4/A1Pxt?=
 =?us-ascii?Q?HW++wPSqMK4EUJrE1CBQ8XUHxugBeTHS2s7XqbBZB2LMTx+t+DkGJ7p1HbRW?=
 =?us-ascii?Q?Zry/HHImPWzBPAag5xLbG4lzIoiygNf6+/QiY/TlD6z/EBHMA+2oGC0T/NpO?=
 =?us-ascii?Q?uWKyB1wCP94wIxfbmVhKxrv85IEeF5iV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:14:56.5892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d381025-549e-4abb-0672-08dcc3759589
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688


Li Zetao <lizetao1@huawei.com> writes:

> The initial value of err is -ENOBUFS, and err is guaranteed to be
> less than 0 before all goto errout. Therefore, on the error path
> of errout, there is no need to repeatedly judge that err is less than 0,
> and delete redundant judgments to make the code more concise.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

