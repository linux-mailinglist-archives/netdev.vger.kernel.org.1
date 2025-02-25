Return-Path: <netdev+bounces-169452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F0A43FE6
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB813BA240
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C34268C73;
	Tue, 25 Feb 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XJ2+evhN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A259268C70
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488397; cv=fail; b=KxH8aEIRJHoD3I+cPDTq5G02M0FrQ/IKzIw5tNFsPnnIVp9BkUs5KOjSDdZhI3S21gN4+gzq1Gmb6gCOZxhO3wHW65ou0z9GZheCGUyquZ3bEhwrFYiZOOT+//FKJ7Wf2kHEMkVu9qL1PEEJmGrZXEGSKGUqBLS70GvxaeMSejw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488397; c=relaxed/simple;
	bh=2N9t0QDAl1h81F8/I87twZFzEvxLxCBGliWY8wT4xEw=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dVpKsXnjeXSI2TOFMhtpQXMUdyTPl3A2yILQ9Yb23B231uAfrozP9M6WvURRA1ZAun+tka9BkZQTR9D4x39/nhjy191KMMCTHY84knOYpewpErf6Z87YDvAY3gNJW5KKidA1avo4WNka5PrO2ujHYFs7vrFMyK8r/ME+IRCdOco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XJ2+evhN; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQSJpg065WePbrEPIckWAgqs3OqdG3Gf1GalAJuesSrFIXOflxM/4nUkFer2uyssoKTguXgqm0dWIqtj+IkWtxOMWeR+1ub5RhQALrumbRnR25NlEAZ6Rgr2ceK8leCenYnW0YS/kTHz/TBVCur76/frgWejNB0uHV48elqZ4UNEbUdQpwIPq2+x+crBcXFM5wdv6GhxVeD8MdLz2xOowl/j6AVW8HQTQdx54mhTrL2lsb7QoJF1IXAWvBRAg0a79OoZHdYmxx+JYDjmU5uDpvNnbk7fZTeoUJsf03OxGT4eN9JTPEuNpT/6NpoMMQc9Y2q9mGIHL0q7mnra8+XNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2N9t0QDAl1h81F8/I87twZFzEvxLxCBGliWY8wT4xEw=;
 b=TSLDaIIqgQebbL6qYjrGOT0TnSV3qhXEHgiOgyn9FCb9pLb05YvnfAr5GJrC5PHhdD90mJqFl+Y4UyDhDkF2ygc15M5qaJRMSavPnMe1HmE+jfAItH8og9Sd+FR0ApzGJf2UInqXAYGXckFSv8pgE9RhxxUtDI1Jq/g+caJ1mnq0uU58Q0Qyrx9T+CV5z+/TQim8AKTzWSMwNsM4ip1UZ5/O5FVESUYFo9naaltXBTA3F86xZuEqV1tGxqSez1ePS8HkGzLACVK5JXQL8a82eOY1dc9mc8q3BfwdWX0FBmtfTNv2u9XFyZVfkna4pyDIu0gSphI3rJAY4uK2OPgP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2N9t0QDAl1h81F8/I87twZFzEvxLxCBGliWY8wT4xEw=;
 b=XJ2+evhNIjr+7jTrWJ0lkOeWesf0HVI5SS4UdDqR1oG0Zthy/VWcKVIWJ2rvaK0KfH8AUaYkKFSN5ki0VWTW7MtuL799cRVqFQM7M200Tfsdog6OWT4MeXWB2zXCO0+0x9PimwnPbzyVIZdQV+IbNY0XXbQDsQqbTG8JOD/7LBImYtOsfHiHqfewpkBzuhc7gw3x0cZogzxYG1HBlMGS7PkqvAtS6iuh03U3khz9MUKl5uklkYhGN6D4cXhZGhZTc+O+1khY6lEXc+I3tilCV5NFM9glVclrgMrhK1cInC2Juvijk3Rjc1X+IdQvz5wH6r1lHmB8i/hPEN6KfHmoTA==
Received: from BYAPR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:c0::45)
 by BN7PPFCE25C719B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 12:59:52 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::6b) by BYAPR05CA0032.outlook.office365.com
 (2603:10b6:a03:c0::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 12:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 12:59:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 04:59:33 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 04:59:30 -0800
References: <23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Pablo Martin Medrano <pablmart@redhat.com>
CC: <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>
Subject: Re: [PATCH net v2] selftests/net: big_tcp: return xfail on slow
 machines
Date: Tue, 25 Feb 2025 13:56:35 +0100
In-Reply-To: <23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com>
Message-ID: <874j0ii3ip.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ba7dc7-a7a8-47cb-b742-08dd559c4ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Waz9OrTg16FsCCqSSFxs6dUoOQsG4lIYqevZCe6cAb+ZyzOA7rTFST0Qf2bB?=
 =?us-ascii?Q?jphX828OcvgC6EJxidj9LEs2bEk8JUP/FJJHRAEQjFjBQzJFbHiLPHB1hKuT?=
 =?us-ascii?Q?XrVW5X90+M1cRQFwf3/O6wDa9ONI3BNc7yghRjFdVsvA9VvwGL8u0WFqyEdL?=
 =?us-ascii?Q?WxQ2OUUqj5YPb0To2Q+HePURmdFhHti0XPWVQEUU4+UlcoQ9e7BtYBRVy4tQ?=
 =?us-ascii?Q?dRPcEH6nfvjHdUTD2bhCKG1UiAaV50S5E3jjMMWKalSbwuNTr4i3MzkFfaU5?=
 =?us-ascii?Q?kLE8qKHP3Cw319zdE/5dvIlTTMNoHaR6LS7FzLIWFE5SyDjsqnGun7HhOJc6?=
 =?us-ascii?Q?0B1fGWxDXCujH3M+k5hBfyDMqXX3OcLLbw7uF1M1YSoHHfj5jWd/iDt2XvQC?=
 =?us-ascii?Q?ky5ohWiY7UzY7IkbYK+el0pItERV8hO5Ny0qsMdkn/7JqxCJPm5eVetx010w?=
 =?us-ascii?Q?b/noHmoxjbHNQIUSHzVFDvCtVqVzXj+59KuQcAvtObIs+/gH82VI7M4K27iI?=
 =?us-ascii?Q?ZMYZWclTKAbOzBDnAhIFSVUw4SNTwDgCIVc2w2BiVZuAMdcTQEcecHbO9orb?=
 =?us-ascii?Q?V0wCi2mRz+JolmagpHeA5pvB+LlHcxfGi1GMPDIYRxaLMLiNG3uXoB4YG0QS?=
 =?us-ascii?Q?6tmnSgXPDPvIwBaj/WxoqdK0KndT/bfWu11wxDyDHWtrHwOuLfQ4RbjcESkI?=
 =?us-ascii?Q?LP0ngupTC4YQoa0/kg4epWtVyiwi8OIMzkVzn/S87XVRE51olUcOhUvqDW8e?=
 =?us-ascii?Q?NT0rFevferqXXKNSfUYk6GsZ/e0KtaJOerJ/4atWc+qTutZ77d+KMPHwXSvR?=
 =?us-ascii?Q?4F8ycbBefvJtLc4nosIJHzebar10MGEpImMD5Z8whHBLeXv9tae9SWIq0v/W?=
 =?us-ascii?Q?Mrl1LnzZaw/CFoBlhknB7gTUcF0KabGu8nI3SdonNLB2gBnI5Wgpj1S6HvSn?=
 =?us-ascii?Q?PxPUzjKzhL+mE2/IE0ZMoyGVrQGXdoF6G9AKwdBjCfBtC2egj2P1GCMMmuXf?=
 =?us-ascii?Q?Xkd1XOkJt8jwbAPd41Uv12B54BUUVfhFq0NgfoEnZPbF5eOAv/2uWd07wUWq?=
 =?us-ascii?Q?7SiH/Xp8W9nfy+TEKRH9BMCjANIMV9JEaoyXWtFfmIuImvD0kDWkAYAKfiOW?=
 =?us-ascii?Q?5GH878pjukVT1ck0zKTa2rA+0O8I1NiPSIk8SfBJyNgQYqdD+ocQPrA3J2r7?=
 =?us-ascii?Q?AeGtrYv6kk+4lA3SDxktgw3MKqNpCL957Fgc3AmklIE4vZSCyoumPDAM89oh?=
 =?us-ascii?Q?D3SdPvjaxWX/GKaMARfekewn/btRLRVWCqYSVT65m2VtFkENM2c5layncOyb?=
 =?us-ascii?Q?e0nZGAHBuJVdYmfxNq7Ptx3Uev3QfBsqlu9iFME8hV0B9ik+oIdjvlshqgRr?=
 =?us-ascii?Q?sAG1D7WdIw4cBg3kB08mgQBuThAjMiy9oMNWzMbJolDGSUOqUSQR//G6wzrb?=
 =?us-ascii?Q?0lok/yiOFzJ0llJxCXDJfBo3AgZjb9daB5bJhL/oAEvoDLSqNMIqk7eMC3AD?=
 =?us-ascii?Q?9sfCcYVLUWJ70pY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 12:59:51.5318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ba7dc7-a7a8-47cb-b742-08dd559c4ae9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B

It is customary to Cc people who have expressed interest in past
versions of your patches. I had opinions on v1, so please Cc me
on v2+ as well.

One more of them stones :)

