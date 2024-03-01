Return-Path: <netdev+bounces-76653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A862786E714
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345AF1F214BA
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07113525B;
	Fri,  1 Mar 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vvloh7I3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5AA5CAC
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313788; cv=fail; b=ZxkvSzglcV61qG0m2Tu3PzUHeG7mWujnmwEp9D4nFON0bCv8WxeV9+lFiNOj3PmdCqBMmFH/CAx1zikSrDCQ9UeGASDgO5F2NBKsXEKdBq45u5zuUsSq5aBQhgDhju7FPSqIzbfq5IBWwRdocPF/qNC3C0WXmmmKpV5ZMbXkDEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313788; c=relaxed/simple;
	bh=FXH2+R/Ml5mBI6egwrM4TecDdBNaMVBzzv+vGi3Sbo8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lZAohUm83pK34WS6lYzYmkZpx7oOSNHz9tXW0pIf5TvT6N/vNSVJ18jH1+iZ+ltz4wqSciUyIo1gst8Od/z2fGVI4WjaHl78u6jcagoMD5C/zQ5CakfR6mcj6rwyR0Qmzqxs/VVwmQq/aYODxsYMo7ZekualU4KoZJA/8+nzzx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vvloh7I3; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBHW2JUHMILQZuAB477+oeHzHi22BjQ2sl+b2XyI3rg9FQhhEKEfE1aOSJ0HpPYqCOL0xed+xz5/PU6GNQ7Sv/CMZIWGgOM8NC57GBEMDXLEHvltSdBTzct6VVSVii07sxcFcOsKUZWX6x2Dlq0/NhCs0v3hkhnTcEIr7kqXj3L8koqA/v4vSQLkYmpxWUF8C4jyqznxqcFiUpRr6caaf+hpGDhzQ4GtRHx7mcZRLV5tL4yWiJOQ/dm1rJHrNX7mFTwfOufyh8yd8UqEQB0J8VdIW6ix5goTcM5s9IX34/vEPwS9FAdRXbogZtD2z0zg/Cx1cRO+GJ7m4NaA/6MhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygRYC+vpbizWSqBeHNftcRaZDeJTwO/c5XtcR1pjfbg=;
 b=nxc4MYjuKgnjPWeJCLoteQPLrgfPsT39jge0Qd/lcm0FjlW6hJHs6ztZkXzWEC25G1voQPMowI9QerXcVLe0VJT4RBEx/fMyzecbj2iHYXMwciNEMEW/fk3jxNcgwgs1AwwKgp4vNS1BghZpp2tNWUu3mxVfHpTuY+rWeM8LsU6KxukHsKwwErecIrDDmtY6YL0aTYbnFGcEXMiVoW0s/Ekvqj8/NLD3/irZoDJfsKn7g5lgxDmp331EarYAfueFOtaCGp4Ixz2YUGlLPPYEJ1UCNaCclETuob4IeQkCKqZFWMD2DZJ4/lzXdtW0iZAKo+N/g4ucVz77MeT4Vc+aEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygRYC+vpbizWSqBeHNftcRaZDeJTwO/c5XtcR1pjfbg=;
 b=Vvloh7I3WJatWX+hDXJrIRjGE0kS9+dHIHYH0EPEU2hZwa0yez9MjwGgQWkE+VcgHnIyqLpIu8Jh+qQKgT49RlOiR99YtAItDdkXK7+JbhddL9UPui76i6crDbVhQI6kCeIuJq23w8qp/4VTIOfnTp6gzNIqJaZ0O6Xq3SXN2RZ9SPkSoNTTdtYyjNwC0nQ8wf2WrokYsW8v8u5NUY5NmkXUJhkNwmTW9qslaEoU2FIKlNnhB4gDVdvLqg9OI3ZazPyazMs1xKQn9IOYhYIxtslU1m8BS+O2lCBm8Euz4tIXPf+QG7heyYjuP59yP1dDHRj5EBka7cF9CcNkGvDtgw==
Received: from CY8PR12CA0030.namprd12.prod.outlook.com (2603:10b6:930:49::8)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 17:23:04 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::9c) by CY8PR12CA0030.outlook.office365.com
 (2603:10b6:930:49::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.33 via Frontend
 Transport; Fri, 1 Mar 2024 17:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 1 Mar 2024 17:23:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Mar 2024
 09:22:48 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 1 Mar
 2024 09:22:44 -0800
References: <cover.1709217658.git.petrm@nvidia.com>
 <5766037d73a81ddc72106cde93943bbca9289ae2.1709217658.git.petrm@nvidia.com>
 <e22ebccf-c65b-49d8-814f-a17e9186eb90@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Simon Horman <horms@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 6/7] net: nexthop: Add ability to enable /
 disable hardware statistics
Date: Fri, 1 Mar 2024 18:18:56 +0100
In-Reply-To: <e22ebccf-c65b-49d8-814f-a17e9186eb90@kernel.org>
Message-ID: <87r0gtn9yb.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 400103cf-e875-4fe0-af35-08dc3a1440ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yBngjAeBS0ml45whTjXWAv6b+1xpg42XrxRO6MZqNaAsGM1f9oGpQXnVnpiC7ardF750PTOKtOH/Y6hbd9sfF2G7jDSZBbPeVownqZp7FzGYU/dqg7B83tN6L/VUnhYwfg04GMt6G0orOhq7nmb6C2eEymiwt2wlXJJQGYNngKyP0+v8C+/nB6bK/rjEN/pf2HDcYU3T9f9q7YsnobCqMN0ovtHg2UMFfz53eXOs32oZBRUmV2Qq4H68fKeKcJFiFSJTPK/cgOxmfT2bW8wWRs9lpzKxu7IGFZI/WSvYSJEWM0vNe0ARXhdUxNoqCGoK5DKHbsUr5OZwPek+rG0qaysGpkyacYDuhQfN9SEChgMs3NUQYBR57YQGUVD/Wdyn97Q77xa2mdTcPOOA3qz3N1U6AE/ldu9+o7oy2CEO2+ic+0n1Vhh2CJ+HSkrLHY2KO5zWyTsEGmRCqMNa1i32jW6FXXABFCyCHdjWevWKC8jSXXzAANipxOUNNvLN7XoKDIjEu/JjTpZbcHtDyBYFGXIvzhs8iMHarv2EHpwcKee6hpdrHRSGBtwd9f4S35EvSp5ZbogD9b0GrV3wodLhokM3ToPruZlisTXBQfwLbf7ZflYq3USsS8ySyNGHWH9vbdZLJvin8CUzFsurAsH6lEsQPdHBA5tOZR5p2gCC+CwInRB0X7LXEXta60xH09bcMSwzIO7myxqMoa7WPVDiIeRouyKzH3wzjlbmTdC1rLnutFuQi6uxqvHp7WzNEokl
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 17:23:03.9874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 400103cf-e875-4fe0-af35-08dc3a1440ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824


David Ahern <dsahern@kernel.org> writes:

> On 2/29/24 11:16 AM, Petr Machata wrote:
>> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
>> index 02629ba7a75d..15f108c440ae 100644
>> --- a/net/ipv4/nexthop.c
>> +++ b/net/ipv4/nexthop.c
>> @@ -37,6 +37,7 @@ static const struct nla_policy rtm_nh_policy_new[] = {
>>  	[NHA_ENCAP]		= { .type = NLA_NESTED },
>>  	[NHA_FDB]		= { .type = NLA_FLAG },
>>  	[NHA_RES_GROUP]		= { .type = NLA_NESTED },
>> +	[NHA_HW_STATS_ENABLE]	= NLA_POLICY_MAX(NLA_U32, 1),
>
> numbers typically need a name or comment.

How about this?

	[NHA_HW_STATS_ENABLE]	= NLA_POLICY_MAX(NLA_U32, true),

Too weird maybe?

