Return-Path: <netdev+bounces-100157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F88D7F78
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEBD1C23C36
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BA480056;
	Mon,  3 Jun 2024 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fOyYKaFP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146E6F2F2;
	Mon,  3 Jun 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408394; cv=fail; b=sgwY4IhRZy456pch1uk3wQX/5AoGjuLp+b9qxijnWkSmmg8fz8j2+mv0KQlBhaMzp3z1JCeTAU6e82dyMPhHBj7dG9SaZZZLLeN3UZPPEkyy1x2eFbs1GwxeEPFYevg77XPq7/cL/jO0GkExmpUHMCJi7Kb1kx2LJ983twxqRXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408394; c=relaxed/simple;
	bh=emaJVCjMP/DqeAmdpK2wQrNBIeL+ytLh9rhwPCJzsuU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aq7zLxlS+mRaWUmjM5HYWdFWAE2lKhuswXoJe926klPwN9YwDEaUWqk9uMR1iAsrX2MTxpj2pANq5+kRHCiTs7URKMEjuzcSCNWyWww8vfcZ4L4S790zofYoRuDkBmiXTIXaxYZt2wGLe4RS9J3GRD08FVcBtgblMFS0d8nmk5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fOyYKaFP; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu6D6pfetms+NB1obB8X9c7l7Et6m6C5sxdC6T9YzZdJfcVbJ1+JxfMQ0lqJYeMjLRJ+0gVu+/hAYkPpFg1GY67zzdkCxEgoGOMZ7yf7JE6LN23J43kOWhZrKxkflS9aFCkulxDmvJBeQh9nXj84iVmK5amtdcanO/+3NRczS1mwA+cnnFw9CsJPsKgBU0+JXFOgAlCWGzUgsdv1WjoaGD9WgHA8QIkJeH8k70dJvtD3cVE2Sg9CL4r//3t7DpnSOWcRpWQY3N0KhvrrkKZ4kAol906UvrmotgY5TWqIqrappqrlJ8G6RdBkoSQ7bGMGlF2HhVsUn56I6PwMSboVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUEfx9TuXRdsvT4WZcRMCpRHpzMHwv5B66va9YHRM1Q=;
 b=cQApVVsMBwdDhz9be5xNDYiDV3Q2pALdFmPH1poHdpq4nhrfvWkeay0AoNtrFF0i0DsJ0f2GQ18qYOONlsEy3wNL+Tpx8twzChk5Hrg5tl0eGyOiCqnEx/tTpaULbKY+/A+mNK3nAMUqWgq045TtuqOipzF0XWRr+JL0d1srLdLcQHFKj6n8juJRHn8RqnebWaytrg46p80VFJtcK40jv6CBy5fFvAckc3wMQ6Zlz3sc4Il4Y5jeEStLQVLwN0EQ4Nx3hV+LbWD5ccaAcbiUpYv/65cmYCu44lkXjs7GDqzgLrDqaErEixo4sZN6B0yk3iMEh5x2henssPXWwSCPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUEfx9TuXRdsvT4WZcRMCpRHpzMHwv5B66va9YHRM1Q=;
 b=fOyYKaFPJh94Srcg2wrxNvmGLzX1+twA0mBu8gdmDbrKnyDo4AeHjbs636qI2FzTTZ8eI1kInA8EJ1irQUZBPdN0t3MVeokV1y/uOcFF/Hqadm+Ck1p/ysl5f4Oh5pyweJtFo6ALBKqFBmRwnD7YoBgNMC7MtrI3vZ/xKxL28IytAMOGvM/xtnDIEnJY1IXAhhR89u3dZ9Zbv2Ku0yswfbunYs4/DmgjIiQfwqbSE4N4fwBsMHJglIyyKShHZDReOPAcQpYB2rYAlrM13B7eyh9aGNevJqrEc5d1BrkoUm2tmcjtjmDf4oG7I+odccEZUBYluAzgtf36JbvKOrWgTA==
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 09:53:09 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::23) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Mon, 3 Jun 2024 09:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.0 via Frontend Transport; Mon, 3 Jun 2024 09:53:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 02:52:55 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 02:52:50 -0700
References: <20240529111844.13330-1-petrm@nvidia.com>
 <20240529111844.13330-3-petrm@nvidia.com>
 <20240530180034.307318fd@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath
 hash seed
Date: Mon, 3 Jun 2024 11:51:47 +0200
In-Reply-To: <20240530180034.307318fd@kernel.org>
Message-ID: <87sexu8iaa.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8556c0-90ec-46f4-5b6d-08dc83b2f939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qz8TLFGnJjFQBKhEtepbZ/UuNXNd5/QPfAu/eIWhTtNjQcMeLxo5WIn8r64h?=
 =?us-ascii?Q?BQJV/x2ZAQmJ9A1kCmT0+GPdYEQI8vKCBxXpzomMeaTveYmlXvCZB7He46BT?=
 =?us-ascii?Q?tozb99v4fwHr0v3rP8zA2uFKegpGlgFU8+AQC/DkAuHXScfHY72SEdi14BQt?=
 =?us-ascii?Q?3XxOXi1n7ShBxMHx0nTHt3TeARdNfgBGBcYPA2yAqpxLaL1fd0EsDeD15JOx?=
 =?us-ascii?Q?8rojqM+btX65WJS/xR7lg6rv9SYNamnux9rEn5vgLZYNdCPnGtFj3XgRbaHN?=
 =?us-ascii?Q?I9xnYWRheoFQ4Xg7h/W/BfSyblTz3AS7gBmi0KUdZ2hTKLX5/xXDrWgmwejX?=
 =?us-ascii?Q?yYel6EDmVbrpUcsbgSvt6Xa1CE0Bb03wL9Een7kQh1UmQcjWUNcE0FWuuRyU?=
 =?us-ascii?Q?cdS9WRwASACbL9tL/QO78g4IBS5WdZCe7iX+uD49DC5l/TwJUKNTHStNpmvG?=
 =?us-ascii?Q?t1/6m1GMS3QUYREYpEp1xXu+r0yp10i2ZftVbRNXAmuTUR6QhqV9CMlvlaLq?=
 =?us-ascii?Q?xe/Hh4oRacvVTwamGo0K9HsawZBtEaqC4O/CjNOMeP26i1BAhv16Z7S3KUVS?=
 =?us-ascii?Q?EDhMMr/9dkN67dAjha89/hcaRmImpOe1+jzCd2UsiBieZjKywqL3gXXavrnO?=
 =?us-ascii?Q?/SFz34028M29uDhcc8ZkwhfyGLsT3/7e+7b9kLZ50fo/t410hxckAvqsLXXP?=
 =?us-ascii?Q?wzR6Qxa+dNKl2m+vo/f78FmcZV7waaGvBk25PBtoLMj5XL4xq2ljC4cTFz81?=
 =?us-ascii?Q?q1adyIU+1I81iF/968IbC60WZkG9sWa8dqXZCW/NYREmVcrnZ2j9/Uy1lhIT?=
 =?us-ascii?Q?427zzTv7sWBvpmKQxYfF3zFRACgMyCkazJXu6VwwXdyK6qwb4gEtDmhzm7sB?=
 =?us-ascii?Q?uXRSeZdI6/q8mihpxMHi3hswzh6QtmU9x0sk8kA7jU2NT+gEWl/hTBnxa2Nz?=
 =?us-ascii?Q?c+K9Gw7SuLne6Q6Vd6q+QcwB3Jpf1WAwQpnRwbUZm6O0wpd+KSv4IQkrbCyR?=
 =?us-ascii?Q?DSIPKSePMj0QdwQ8Td7F2tWv1m999AfxY6LLa5i26uJOIu9OUF2DjIEA6AS2?=
 =?us-ascii?Q?quQ6kIc0l6JsE/aABzINIWu+uyINdKBW5n40kDUjpS1MewOyEYEcONHSSBOl?=
 =?us-ascii?Q?r1YsxIh83Ss7EErzeXDhVoV3qzlD6JwiC5Zq9uHmbic0witSw8CLNK1xE+Hc?=
 =?us-ascii?Q?OofgBvJj9YKoJe9PfOWw09OGqPyETs5VRtCNOhUPl7rQz2yO1rSkmSw00TgX?=
 =?us-ascii?Q?jiKDQpQVl5+0qyIn4Xvjw1iVGLUSbBERL66FCOuoSygzlhoihClMDmD2Tv+B?=
 =?us-ascii?Q?8YFNo9DdJ8CO9sSKiHWaLD5ZPyzU+akT9VUOBtRjVtyzHJ5bZqJEnEHliC+f?=
 =?us-ascii?Q?RC8eAvc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 09:53:08.6439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8556c0-90ec-46f4-5b6d-08dc83b2f939
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 29 May 2024 13:18:42 +0200 Petr Machata wrote:
>> +fib_multipath_hash_seed - UNSIGNED INTEGER
>> +	The seed value used when calculating hash for multipath routes. Applies
>
> nits..
>
> For RSS we call it key rather than seed, is calling it seed well
> established for ECMP?
>
> Can we also call out that hashing implementation is not well defined?

As others note, this seems to be industry nomenclature, so I'll keep it.

>> +	to both IPv4 and IPv6 datapath. Only valid for kernels built with
>
> s/valid/present/ ?

Ack.

>> +	CONFIG_IP_ROUTE_MULTIPATH enabled.
>> +
>> +	When set to 0, the seed value used for multipath routing defaults to an
>> +	internal random-generated one.


