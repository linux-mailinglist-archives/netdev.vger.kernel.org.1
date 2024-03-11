Return-Path: <netdev+bounces-79127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC21F877E8D
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 12:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82021280E52
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 11:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F5364BE;
	Mon, 11 Mar 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="epHN/QtJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01338DC0
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154943; cv=fail; b=mzBrKe+XIbl83IQ/H/oNbkAaJuWYRDXHvEoGQ4aoXAzPqKUxE/uhxQgGL/00vBsyViOwbq8IYf8IxtvK/3R10e8JL8ErgubCa58QOYQqpkbMnzbw5tBhNHmKVetGmN7yJXLQwOpPw0yCPzw3ibbl/zWgaqBtU4SNequnmnxkflY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154943; c=relaxed/simple;
	bh=fHzRhdVUz9pDWzxdMp5xMhG1hq9wOsn9TxgQJmlNuVI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gzpMJrRidlOLhyfOARd7w3xM6PRVd6CBH2cMwY7agFzvD2AoKfNFzqLHYktooaXSQKCie76wycPRYi29yomR911MoqhjX5UbiHPEZ/KF2xCbY8x14PfGSrH9eujl2bL52E0b1DlNpZeCVfsz9qg0WB7ny3RW4ax7iLD9ZDYXs78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=epHN/QtJ; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIDnTkLrBM+fEK43jWOjqWsuKQ57OZI3xAxThrWZ2FfifIfdOXcSNyKbY9LDKLgnFEt0sPJ1I0r2CNyeEijHP7MTGD12lREZyahM67anZSANitAzPTJz9KqisOXCJ5xLyDijW73ccJS7f8+03FooThu7eRUBdRz8kuYtz+hZzUwUHhpkNKCayg3LmYqS1QbKprWQMtsQkumEJomRFe4aD6l8hyE0ZE74PndxQDBQDz11IVGieABsN3FDucvOU+TmcJ5ul2q/Y5oZM5s8BIb2xotO6iHq3+z1U+UWHs49tEnbnIIlLPezuAV5A9Dg2TJ4x5Zz6ElKZ8KP7mgawFKjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u0clj5WtIyypLnQ9krW18K10rE3CSurB1TEIEFD4cc=;
 b=R1Z9GkzDKpfi8VAO+lBriaSL6oaXridEYVhOhgZfEnYYTdI4gHMn4p7BSfiX/sKMK3QIcZSKhDgHfkJPYDP4XkbV5+XYcrbku9uQdyceRy733a4Bc6TJZKxjZK+dgVPzW2NKSAuQTimgMN85GLj6RjI/U8LbP4qs2dD1LWqyFiVX9ANeQozWIbrcGlEUT+swxVFa1pf0lshp10d/IGD+s74STeqy2afsIqONxMFgjKcNV8wELUBBVjsO8Dx35LRqONOaVscp8v/8F2gVmLJHrGpBo+4TDVuP8oDFe1/yfHZN8MF69PrU07GOi4JI+0KG81wxOTTlNo0/9RlaQkvrjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u0clj5WtIyypLnQ9krW18K10rE3CSurB1TEIEFD4cc=;
 b=epHN/QtJupKVrGyadB8/zgvB5GyV4aYO9RDLjSlwvUqtyJmehZcdILVcVXJ2wWzDWGQeoA03ksNBdY6zWwqu3Lce74fz+IBYNHrNFLmxvj1PLigxYW84bJs183qYFUYkS+FbOfhWe9799+Tv52Awj6E9qKDoB7F0IoLHFztCMZBa/2333Z7VJ2Rg6oXeydqmbq2K/rvf7ZbIItYZGIUtfTKuipJPDk649ku7R9KIQ8cfrS4vzUxAPi41JPvN8dDqKKkb8ssVsEmiJIWZAnlnTMWyufgwg4F4F/8BEdOrVrwyryiqEXpFT/rQDt0ERWWsmFw4yPo0EpTD3i0OciLw8A==
Received: from DS7PR03CA0165.namprd03.prod.outlook.com (2603:10b6:5:3b2::20)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 11:02:19 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::a7) by DS7PR03CA0165.outlook.office365.com
 (2603:10b6:5:3b2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 11:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 11:02:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 04:02:06 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 11 Mar
 2024 04:02:01 -0700
References: <cover.1709901020.git.petrm@nvidia.com>
 <2a424c54062a5f1efd13b9ec5b2b0e29c6af2574.1709901020.git.petrm@nvidia.com>
 <20240308090333.4d59fc49@kernel.org> <87sf10l5fy.fsf@nvidia.com>
 <20240308194853.7619538a@kernel.org> <87frwxkp9v.fsf@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 11/11] selftests: forwarding: Add a test for NH
 group stats
Date: Mon, 11 Mar 2024 12:00:59 +0100
In-Reply-To: <87frwxkp9v.fsf@nvidia.com>
Message-ID: <87bk7lkp5n.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: f601f079-3507-42db-3bf6-08dc41bab84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	okSxHibGvgK7np6ZrVGTPHE9UK5oqdivuk1qPljJt3shM3+qWwBw3CbPIoEreDgQQbuiGEC/Asr9Kp2HtDjJtUhRSTTcVeLXmnkOXJdgiTvzsfrVYWgxQx1u2zIqnzRsCT/1cueh1xRE5EmUYPlq/JUXE2RF9BdBdAWLTVSVI7MB7w1Pzu3mB7kN0UH2rVK9RzlNYkSdia4qQ9EZGbjuoLKmWLIX843ZuGDut/U7mXVa9qXKzEKoNSqjRTcB2jNTFFgNT4Sbr1N2xdRd2L65zMcsomwvyTVC+zydNtnbcuODp+uVRXza7R7/wt1Wl7qV74AN2VGiZeKZ+K0zyfx75i7YCrhNLtUTu4ttKgojPRAbVCyrgC/xHOh0mPueCcrh+D4HO6wfEw0aQ4oKExgrXXFcS+eGLA0G0gNaqIfxaOuwUXExy4O5PCBRTD2knzxLKelg/yL1m+b3m6ODIeYu6PdHXDNsin0za8Z1KifmHUavbUouxlkpRL7cr47xxy06lKkXTb2wdZJHMQNFLQL+9hH5R5LTrVtYilw5OOG1KtUGjFL8c7Q/6rUQ7FqZR8AAp7EgD+kib1PeiG5izEIUfqSbrO6dOHCSK2MbsvFvQ8WlYzH0jP2iNRa32CuQSR3ilRfBNoNsfbN/QssRgb72UA153QjvtxHK2Pq3THPVrWG0aQarMLGLnompK2uLiqszNhhce8mImfHQqoH7QrU+Ygcxb0Pf99aLWrz93ZfP0ZHScecugPc621d0guaGuL6D
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:02:18.9906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f601f079-3507-42db-3bf6-08dc41bab84e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222


Petr Machata <petrm@nvidia.com> writes:

> Jakub Kicinski <kuba@kernel.org> writes:
>
>> On Fri, 8 Mar 2024 23:31:57 +0100 Petr Machata wrote:
>>> > Are the iproute2 patches still on their way?
>>> > I can't find them and the test is getting skipped.  
>>> 
>>> I only just sent it. The code is here FWIW:
>>> 
>>>     https://github.com/pmachata/iproute2/commits/nh_stats
>>
>> I tried but I'll need to also sync the kernel headers.
>> Maybe I'll wait until David applies :S
>> Will the test still skip, tho, when running on veth?
>
> It should run the SW parts and skip the HW ones.

In fact why don't I paste the run I still have in the terminal from last
week:

[root@virtme-ng forwarding]# TESTS=" nh_stats_test_v4 nh_stats_test_v6 " ./router_mpath_nh_res.sh
TEST: NH stats test IPv4                                            [ OK ]
TEST: HW stats not offloaded on veth topology                       [SKIP]
TEST: NH stats test IPv6                                            [ OK ]
TEST: HW stats not offloaded on veth topology                       [SKIP]

