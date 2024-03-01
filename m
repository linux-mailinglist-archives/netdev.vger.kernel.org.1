Return-Path: <netdev+bounces-76656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F886E725
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDFD1F239DE
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE825CAC;
	Fri,  1 Mar 2024 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eOaG+sft"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE47468
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313922; cv=fail; b=V+vl/1D9qNalWPKaukUA0etjK09+YOnRFK4TlUfQAdeHz+UZhh3oq5k/wuifMASoC7yMZyaz6j3tJqYrmYXMW61Z1uEMErRhGgxagktEzcZkrZsE1PiCky8dh9co47aUXROTcEGGUvPN2s71eMp8/m+SWSgOF/aM5is6s5ipYS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313922; c=relaxed/simple;
	bh=jZRCDwg9VlSlzmuJV5XMRpNwMF0f708b428480gcwHw=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ZWSJVV//T2K7d87znj3MpoKxUYBoosbP7OZuKbiv6JJUZc41JnucNyheh5mhJ4sZc/bfQVJ4F4DcS3h/oXwlWCpwZPDZwylg4qzP7r1tFgi/q2cZsz2i/wbsMMrNWpAs8qrdE8LmTUismgduPamtMimchwmiTpVvWmzXeA8wLRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eOaG+sft; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T66u94olVmSrNA0FKXh0hBUzBVp6I7DcJ0OUXLetwnaIOVLsOFnnwSRJvNqGYBU/ujYCTU0LgRxj7C95ym8aHOkFPNXDrOmCuRwnDxJy4oYBeBAnnYarrum+5/K92ToF1Y0eZHX/l16owRH3i23K6RM9cRTUCty3T4RSHYkBleOn83q2yrclP/d3YbLXdfeWcUvHDHgvMpVf7u36/VIoLETfTakZXe7cc5A4IKh8UxcDy6VBtDomY5hqz33O8Vg8Xe3ccBdIDqv49BULKSLhRWouSSCys8Su6fpFbCMgspheVRh0pWpY7uENRCz77xQlLAo+wG6VuQm0Tn/qyxTlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHBYxf51bInbI7DKKiyD5PIDsdhj9OoW2mYHAgBNmDw=;
 b=HKBc8HIQO3A3w8s1PgXVYswf6bqdjm1ZXX83K+FV0zKvjQx0hHZAWDCpDNgNpko4AWY4nKVB/4oXAB/Iy0g8lZfFfv1iBPSgXvI5jxRQE6n9JGtSgKzuMWAfIZu2xEuH3EkHKREdtKfCIAx8614sZxxo5TI3js8rUikU8Xwl1/kuNQ8fbDU83jV/OSIjPe6JDhLkjjPqY1gpF0QszxzYXSn5/ZOk0qJyMAVFBGyJp331osuXFL6bFMEQ7rY0S8Gu9Hesqx7nCP8fQ/Sxb8Di6IL/nI/bdIvalS4WpYH2nnPEhjBHZveyU8o6kh3dHGxhxwkPL/qQC92dzRHEzPR/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHBYxf51bInbI7DKKiyD5PIDsdhj9OoW2mYHAgBNmDw=;
 b=eOaG+sftdYDzs1E6u0/osJ4jkQyFQFJl4lWt1RPr8+Jefhnqa54wVSfMisPcAsNM9IO6m4BJ+4XgaocsxIQ2tqwucyC8uS79V8ZctwzbpEGxjkVRiq0lV+UQ8EEFwOx6SO2fHil6nTdfghjkQJeNODGazeEqB9A2hduo9piZIXwm0yHqLnJ4Ft6JzUIbvfpcB3VjYU96tZRYFKXw5mvxeqWqA6aV+7DUWBQ095MzHYK4erqhZsJYKXXJx7s4vUoWvLQkv3YiDCCpr6WShHZ4/sTRRMvC/a0bMjwYXKY6PFidAh1J7FzxLknI5Jp8XxBQH1Y05W2eCpSz2OrtNl+tZA==
Received: from BL0PR01CA0028.prod.exchangelabs.com (2603:10b6:208:71::41) by
 DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.34; Fri, 1 Mar 2024 17:25:13 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:71:cafe::95) by BL0PR01CA0028.outlook.office365.com
 (2603:10b6:208:71::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Fri, 1 Mar 2024 17:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 1 Mar 2024 17:25:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Mar 2024
 09:24:55 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 1 Mar
 2024 09:24:50 -0800
References: <cover.1709217658.git.petrm@nvidia.com>
 <f35433867d7bab05bbe0a1b4a09c3454cdefeb7b.1709217658.git.petrm@nvidia.com>
 <386b5f4d-2228-4e57-a4b3-fb17facf9029@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Simon Horman <horms@kernel.org>, <mlxsw@nvidia.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH net-next v2 7/7] net: nexthop: Expose nexthop group HW
 stats to user space
Date: Fri, 1 Mar 2024 18:22:55 +0100
In-Reply-To: <386b5f4d-2228-4e57-a4b3-fb17facf9029@kernel.org>
Message-ID: <87msrhn9ut.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f78d363-6a81-46b7-1a1b-08dc3a148dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8czH4fSm5+73qPr+9Mhy3H+JBMW2vE1ylG6OD1qFfEj6cY/ma0WqUmh6q/bIsIArrqZQ/fFplbcRWLxMWhBqUj0TdZP84O7VQ4OIXYV+cH+atjp9p0SeM5jskczP6Soir36spwa6jECljpex8ywmn7fdlZT+/RSTbjacbOfoYbZ+Iz+V7FBwovTQFDPZCo31mziDLbARsOEeqi+M6OCeIY4ht88/Vb7MYZ0enKyT3EF48W1hWQ4qBQUOHILEixUIsmaRrajAZsW5UbLt1jc3y/JSZ8Wc5fj8xClXh695bE2WRuHzCNBRcAEsdqFVxqJCzwgTpatEqsbPShDGxsX0x/FfO3KmOCvj4I7MPLM1zS0Pa852EdVIJRi8RgBfiYzgNcSUC7TQ+5AriLn+Q478/hCYo3uEdOoy8CBsd2fnlWm1nJn866KhdjHCPSZeRh7RmYPeF206lU+62y5F+HDiVBBbUrf69D+3zCNl7iXio7x/QaFGB5V/RgbLHeoALCCCk335H8Q5b1dDpmXODhJTMBCFkgsg+MdiZD21wYmR1KrBUQfuK7sCWSk6EeCtXKHPRAwPoldieHlOajLMZ2nmlBKu5SrXIXQzKXLbnE0QXimwkqbZ64KZYnSfqOTccl9UGACrwN3bwesy2xPM2zwamdifoA8Zlx0B4AdHP/Mk1U4Da7RKmT3lJjpw/QIbalp3x4hsXjhs6txugdAD4Jc68e/EDC2m2ZnM38ZcZjXlsBTpKBLDayPIj23HZMJxa4sk
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 17:25:13.3627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f78d363-6a81-46b7-1a1b-08dc3a148dfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744


David Ahern <dsahern@kernel.org> writes:

> On 2/29/24 11:16 AM, Petr Machata wrote:
>> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
>> index 15f108c440ae..169a003cc855 100644
>> --- a/net/ipv4/nexthop.c
>> +++ b/net/ipv4/nexthop.c
>> @@ -43,7 +43,8 @@ static const struct nla_policy rtm_nh_policy_new[] = {
>>  static const struct nla_policy rtm_nh_policy_get[] = {
>>  	[NHA_ID]		= { .type = NLA_U32 },
>>  	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
>> -						  NHA_OP_FLAG_DUMP_STATS),
>> +						  NHA_OP_FLAG_DUMP_STATS |
>> +						  NHA_OP_FLAG_DUMP_HW_STATS),
>>  };
>>  
>>  static const struct nla_policy rtm_nh_policy_del[] = {
>> @@ -56,7 +57,8 @@ static const struct nla_policy rtm_nh_policy_dump[] = {
>>  	[NHA_MASTER]		= { .type = NLA_U32 },
>>  	[NHA_FDB]		= { .type = NLA_FLAG },
>>  	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
>> -						  NHA_OP_FLAG_DUMP_STATS),
>> +						  NHA_OP_FLAG_DUMP_STATS |
>> +						  NHA_OP_FLAG_DUMP_HW_STATS),
>
> 2 instances of the same mask; worth giving it a name.

OK. I'll stick this somewhere above the policies:

#define NHA_OP_FLAGS_DUMP_STATS_ALL (NHA_OP_FLAG_DUMP_STATS | \
				     NHA_OP_FLAG_DUMP_HW_STATS)

