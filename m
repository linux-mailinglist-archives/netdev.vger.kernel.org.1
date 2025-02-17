Return-Path: <netdev+bounces-166959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA289A3822D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6A23B5416
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAA21A437;
	Mon, 17 Feb 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XJklR1Pd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9B199E8B
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792620; cv=fail; b=lfPalWuU063nrd5dlz0BRRB3tZRjeZ2EXTcetkDAZEVH6j+xO02pcTUjScBUhEh5mqhZqfcYzSUYoPgpPga+4KdXgdn5+XLZszo0Kpo/TD/uaVUD4ZNDDPG5DNhMLohp3bXOS+cRoI1brpmZVre5r2K76pB1KPTez7ubeYD07G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792620; c=relaxed/simple;
	bh=WYh7zYRsNKbohtYKXxOUe3TtO0JR+0lBveAC5iNRx6Q=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Vt/SVrKBolf9Mcj/qtgkdmlW/CxfyLyll7jm6J7SCgxgNkyYm1iNSr8/EJ21Sx5wdVQ+XH/qOfTHC9E/4wiS1IWrvLidtDTHZl/rOv7+62e2SGUGm+hD1Qrh/cb7QaB5YEV0pDfXZ/yYq7cTXuRzg0V2vCdGIod2Osv55gs2m6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XJklR1Pd; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHq0VhO5VV2LEG4zB6imdAEO9QfjuzKiLMuCQH3hogGi/JdcOkSOk3hY16agbt2w53jF+97P0peDDGrVtxLKbIxPb8bMvKFp0fjvvGaYA9ZSH5xbzVXhEq5rzeT9tvYRiBk+40OcLd3kR78n3B0U0LVe3ucV3W4+x23ya2T07qam9JpDprQDeiX7UKed2fbkkCl5H/5/UHBwowd7Egbvcs37P13gEy1UeTDyLu97qUUtjgNq80fX8RTU1QEFyI3j0wO6rbc/2HCCQKnJiiPP8uEiqxntf6cLaktuq0lvwbXyaPuSKtZsRX8KLWbJM8GlaMS1urQodOYnn9H7b6Aqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYh7zYRsNKbohtYKXxOUe3TtO0JR+0lBveAC5iNRx6Q=;
 b=rnk/v4SENle0iuqPbjkhMZgYeOanQ4lFh/RMVViAXITWogdqOGAhUnb1JbFzjxbyunMJVtzH1wrKqk58TtXdhYDhSx6hlKy8sFmAXS82BCrwBBfs+E8DfER7/FqYLsy/0YAwEwgSRGcCLa18wa1OLB3FpBh6Q73lTHHNJa68/5ZZC8wnERgQ60WSHP9fwgIHmJTi6CRRgCq15pRwsCjwrulZ0zMZdaOiIA2u5AOE8m0EKEq7K1gy3ddCkyfleBOFLJXUYxCMyqI2aUi2fE8bFdStGSkeFLNIfO4HcVWgixpqRZt3/08hTCWgjYAHVDl6R0Jz3I/ZeNX85RK1XOVRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYh7zYRsNKbohtYKXxOUe3TtO0JR+0lBveAC5iNRx6Q=;
 b=XJklR1Pd9gjl8KHlPUDrQE3DY4IOFMjfi32tcx8D8g2ATVaaG8D8G3zrXc8uWJs781HKKHw9o4L9UaStlGKq1KnTLm2TWaO8HpyDo484igQowM1qK6zQtXiBya7S9TX4hofr7FXDjkqgtMbqyMalgfN7oO3HrWeL+N0U+U8z3F0/zk50zzxlFnvd58HDjw1TeOq40poKzZ91/WZBZvXkx1CMomZZDTwILg2ndSSUaoDt1d6uVtrQSRp2h0MuKeRnUQ1TGkX60BYEnJvRmsaL6+CJ/BY2fjyCHkoq/icK/XC9TT9wi+pww10aReAA4urwcgBfTZ8wMwlM+2IvseY3PQ==
Received: from CY5PR15CA0162.namprd15.prod.outlook.com (2603:10b6:930:67::24)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Mon, 17 Feb
 2025 11:43:33 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::76) by CY5PR15CA0162.outlook.office365.com
 (2603:10b6:930:67::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Mon,
 17 Feb 2025 11:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 11:43:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 03:43:20 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 03:43:15 -0800
References: <20250214234631.2308900-1-kuba@kernel.org>
 <20250214234631.2308900-2-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <petrm@nvidia.com>, <stfomichev@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] selftests: drv-net: resolve remote
 interface name
Date: Mon, 17 Feb 2025 12:42:35 +0100
In-Reply-To: <20250214234631.2308900-2-kuba@kernel.org>
Message-ID: <8734gchk4x.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: e98cdaa9-0f0b-4c08-da6f-08dd4f484eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fcLjOtjWLpd7rQmvb6wmiOitvgftIzBtd+GR5W0/f7Rm3havqM6y0rxlKXTb?=
 =?us-ascii?Q?CTsDm5XBYXBB6lbgNEzVSdIdMZv0CpYpY/aS1kQzphnmZiOKVaXmk8IZVfWm?=
 =?us-ascii?Q?kV/dT+8Fvg6WREVVTkkj10XdcNzFAhPaRr1q6+ZgE/chtUCs856a62JHS9ae?=
 =?us-ascii?Q?5G4dXTx9nH/RPPQ75jIlFG6DYv7S8R7kDHNQFRSAa4i0NKCgcslnunhD6ELN?=
 =?us-ascii?Q?ocIQ6o+qOqI7jiKEDQqa++8ZsIwe/rJBuZkfxmdBon0wZ5S7yBm/issz7KeN?=
 =?us-ascii?Q?Ft9zj28ZGjW+i3+6nToH+eLa1gnAD/pz+Yy+W1pw/2WPakTG4IyVMCWJI+Sp?=
 =?us-ascii?Q?p6CruwPOo5X/S7jQ/Gb69ZPcOvVwJsVk4pupSbPCyzRN4bKlb9t3tZG77VHT?=
 =?us-ascii?Q?kEDU3TqYUTw9gFIKTxjZsi4uvwQRemTM9ljEo7mTlparDONpHkHgSLiZoRzb?=
 =?us-ascii?Q?8NhyWo0eN1FT2Lj6lqsSn2v6K8To4/4w183qJfZlNSu7P5J8eTTbIcON1TV9?=
 =?us-ascii?Q?8beNOjxNVenHzodE58uK9SjrfBP+ldK12kd7W28T7g5gSokF+tVHXu+n+KL/?=
 =?us-ascii?Q?rzOdf6u1x5aDKdT51ZLAX+pu3APWtkCOi0qI5QO+SAUh9qB12RsGaqtIjGPa?=
 =?us-ascii?Q?o4pGStcwfKoLCxwHw7Jpy9Qz9KMPWXMRS4n8hRWnvm+L8A32aHneMCR9E/EA?=
 =?us-ascii?Q?8Fcwlf8KUPcJGZJrIq3rBS5geqayR5z4v1ql5bn7QGV52waPxuKwm+pqW3+h?=
 =?us-ascii?Q?17vzhw1dpOOgv4gEPNESiX9yepuL9ovUE6Ey8WJtqJ4QjhI0UzO8LX5Fm2RI?=
 =?us-ascii?Q?3kaXiQxBMW2ltMMKM8DZrNU1OeG+c8C7FeuilS1IxhIxMt+hpezrPNJU47sI?=
 =?us-ascii?Q?Z4Oc5rRfGJLqLX214E685tH5kDIYyLF+zwfNIIsSKgAMQUiDM32+zpn3QNV3?=
 =?us-ascii?Q?yY/+wYaHDEazYUVXTcCuZbD/qzS0BRccpOgUFR/tdsqGhVbfQoI8kpqu9tdT?=
 =?us-ascii?Q?jNNRpEtiRZOnPcdNYLzPXhFsi6ahS22FK1r4Qkahkhou0ZmJniGOIhnLL24D?=
 =?us-ascii?Q?Hl622Q5C5IP1mBHLVt2FhDGjRze9g7Kk0Cm2CS7m8GUS9Cl9GAom9sgkbr4D?=
 =?us-ascii?Q?j5DBEWGhEQG0SktuP/n62gKL+a9zOxsefWSnuMLN22V46zKD/x993WghIZuu?=
 =?us-ascii?Q?539lI2njebbiS7yc8ZXxhsI0JLyKH4+qkmaiQyctX7EJO3W2FCWPTbCZ1MJ4?=
 =?us-ascii?Q?1jciMiOcv5I9m364crdhXa0K7NcLQzPDSmz/HBfkbwXoWztSljpfEFa/mcvX?=
 =?us-ascii?Q?B6iUlUjRYPzDYP4STqA5COd0PmZkz8py6K55A7pktyaE1e5kR8MuFjqTLYlM?=
 =?us-ascii?Q?0OgKuP4kOcDwp7TGcAU/h06jkDBpUgPXNugJGXlsL0+RGiSCnXTLB4rmo7Sb?=
 =?us-ascii?Q?r1loXb0/w86LBIhxEyIY6W3xfFScVhODaPb5pV2nvcTzcXbrb347lHzAB1nV?=
 =?us-ascii?Q?Q0c2uolZKCWHjds=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:43:33.1575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e98cdaa9-0f0b-4c08-da6f-08dd4f484eac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551


Jakub Kicinski <kuba@kernel.org> writes:

> Find out and record in env the name of the interface which remote host
> will use for the IP address provided via config.
>
> Interface name is useful for mausezahn and for setting up tunnels.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

