Return-Path: <netdev+bounces-141944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD69BCC0B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916AB1C24798
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE541D45EA;
	Tue,  5 Nov 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="frt5R3vX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE01D4615
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730806851; cv=fail; b=KP1WzkJiwVjzVdMqAsSccL0xZ/kHvkVXjQj061NAaTokYAB+2jjcgzH442fn6o2z2+9imBWqd21nuiz+AfC5jwlAcrkXhQe9DPSEF+AdwwvF7fk3bKV6fZKvEZPfUVmL2HMGZl6fMvOWKywtO+s0jiGVMb4xaT2MOJhRRem05zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730806851; c=relaxed/simple;
	bh=71khF3U/G/EE1X5DT+3TMchhZuMFRkpHwvkSYv6Dlz0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bk98kiVnLCp/xWz9fWTjPZPSyUuJrlpV3wobO/Gvgs00Q+Edy9spLANbZmGPIN6seTJh/u7rTRVnNRivB1eyPQpIIGlAmBOVV5s64ml7TIbtdGzPmla1XnEaZ5Fzk5EEOtCFPKt/jpjuaNBZJVuswfyk7Qac7qZ7B48Y2iDkTxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=frt5R3vX; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBGCB5BVLWlncJbo+ffBNhzv+UwUa5UD/cQwJgkhKL01yisXMupXqr5BsnAUCCx3UmsiIZEYJ9BxjxeZP9abIae+pDN/GV1LhFxPaOeRisc9qH1/AkYauIucHaR36juYmDpdCwnwkaxoELGpNo8dtl4KrXkrPEBYIn/Tm8mSoXns+PZDcu3SKpwqZnDM3JRgXfwa7DqUofrmG3+IXyfvtpjob9WmeX/p1H9Yu8/FPb0wHmkr/rTtypOhIQyFpFXbVfzV5KZjVcp9bbowqLhl8AqrpyABL328OYOcnF7ykxuSDJNoIEKylJ5658phF1Hey4hwkg1sZ8YtSn3GSUjm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IUbr4HpJjiLqd7yu+GqgTxTkC0klEq0o7lGeILHknk=;
 b=jPpvjsErq7SqykfCRS1FYxXAPxnrGRdybRMVA+gst9RPA0QkoJVy4d133shDpAxEJnVXaheUIRZmBzfAIDfnJOZtyRceWKmHfVUGY/VSXYkcbGZzlrmFLaK/9pvIy714lviHJJ+IUFa645ehiOdSMtS9MBtOBddorHaBNBmp0DMbjac2aycsIt498S1RZy7KrJmBglchGuDkxafk38ykowSDYN7fzwqdddQFzZ+2pZS6T09T7wMI2PlGsTjdBH4u22trnWcc32MpS365WR/Znf8m9DwBodK5FPJ0hJKxvZ/dbK7g3BzAt1j/Xla86K2dJXG0H6sZj0FglnzeWdeieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IUbr4HpJjiLqd7yu+GqgTxTkC0klEq0o7lGeILHknk=;
 b=frt5R3vXYK84x/aYeDLtwIuwNg66ixAEavPT0El5+og89OdQW7NNZXRTkNkJSGVoLrUx4gASmG/fIRzNFCSWBjtUNoF2s626nCATFBqGTfmq3//lbMyEY+KI58m2zeygz2UXVmGQw4UM1yeM1VqizcxABK4AU6pJNYkE0N7ojkVlScDbJeUBdewEZw9nB1dWsiFO/KiKu9vFcde1XI6KVAjOptuQ9/N2BDp5e1Za4b62FsCfQr7CzgFta2IcoK8/mKk5MTa91JwTa/THcugQgYEuX0LKhLxpBmQ/KvWlpXhqbO+53emRXnJr37rwuwEQMaCqiKT2wiRvKAfv0fhVeQ==
Received: from SN7PR04CA0158.namprd04.prod.outlook.com (2603:10b6:806:125::13)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 11:40:44 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::4c) by SN7PR04CA0158.outlook.office365.com
 (2603:10b6:806:125::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 11:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 5 Nov 2024 11:40:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 03:40:29 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 03:40:24 -0800
References: <cover.1729786087.git.petrm@nvidia.com>
 <20241029121807.1a00ae7d@kernel.org> <87ldxzky77.fsf@nvidia.com>
 <7426480f-6443-497f-8d37-b11f8f22069e@redhat.com>
 <874j4mknkv.fsf@nvidia.com>
 <959af10c-8d51-4bc5-9a85-ec00ad74994d@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Petr Machata <petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 0/8] net: Shift responsibility for FDB
 notifications to drivers
Date: Tue, 5 Nov 2024 12:38:54 +0100
In-Reply-To: <959af10c-8d51-4bc5-9a85-ec00ad74994d@redhat.com>
Message-ID: <87zfmdkixn.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: dbee83d6-7dfe-4901-9a8c-08dcfd8eaec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I0sA7/N6qDUIRMNV8rIExrGLuJDKqiMoXkJBZPhsfbXMe5P7dsaRaPJ4i+mI?=
 =?us-ascii?Q?gIz6+0hzXRQYRhBH/vSktVhaU1Mb5C0R/WlT8cDu2lFxjVmvy5KI2+4dqVNq?=
 =?us-ascii?Q?qNfUHztVSrMLemh70kC7cYTIOqqpnhJvPQ4swS6OGMzTGdtobkwQqZUuk4VF?=
 =?us-ascii?Q?gXguI5qe28VUJoNEI7WEy1F4Fy/EOhaJDBv77U4qX3SVu86d6Medxp4Ky/uY?=
 =?us-ascii?Q?C9CzQT0aHn5H8YlggsAon7Yxg9ZasitvEgYyZIC6tfM2Fn2kWYOe7mBM7p2S?=
 =?us-ascii?Q?/RZtd08QOSy3gQuySmKVfV5QOUCKVnl4FlxwFbKh39us3lR/Y8GvZ6eQm7jL?=
 =?us-ascii?Q?ZXwbhuuzo6eSABnRZrbwAhjA3f8KoQJuDqo/PZphZSj502PQ2PQbztfSb6Po?=
 =?us-ascii?Q?5rKvMYNAuyhKkcfcO4mXUZFAntLtDH+CpYCHOkQ5k9C/uDvTV5ekHUV55HD8?=
 =?us-ascii?Q?1kios8x1YFZlClxIt+IvRusg80TtwkieZOySIGU41D/iJM1bJTRMjknIdl03?=
 =?us-ascii?Q?kcInK58lXvJHpBQ6m8AMOK83ACi1kba8Ac4K0WxEyJCgyteJz3Z1t3hYS+vm?=
 =?us-ascii?Q?2C1kJnt9L6GhLcZoVvE92wixyaX12KK+Q2PWn1zMjTjdtDA26UB7+G3PqYTx?=
 =?us-ascii?Q?8cIBB5JRdkqUNN7GGw0fKjyLz9xAU7TpViPp/IQ2fHGvy6TS1yVgeILNlmaz?=
 =?us-ascii?Q?b5U//EX9SjOcWOzl1NPOc8CygdAv0PSuGf0Ib3p72sPePvAVMbpFi0MrdaB2?=
 =?us-ascii?Q?/WJz+K5c1L0GdpQeGYwE5TsbemhkV0sP2cGGS/2Rkj1aSX+kvCVVK9XN316D?=
 =?us-ascii?Q?+QaMxPEz4/XmfTtl6pGS1Z492Td4Iot2QWC10KM+9A2pa1q3Qy3WM1kcUHMK?=
 =?us-ascii?Q?3LVKSwhBnQ43a0jJwqFP8708THQn9D/ezDcwOEyc/Ih3atS9rF7fspTmfIm3?=
 =?us-ascii?Q?DyGCrMXEmobR3w2YLsrPKbu//vfsviVjw+R+W7coL2RUeLYcIxcVxhyr5PWw?=
 =?us-ascii?Q?4Qoh3U1cTRAIHCCUBd1qMJAo2z3eBaVbI5R/sE8ZxYYJbckycXNnylTa5M7m?=
 =?us-ascii?Q?3FCviXbcNa+NSmjs8P6JwEkoKmIUmQG/GOv2+Y+0W3S+6JPym4UY0orC5i4D?=
 =?us-ascii?Q?j5SPpll9OK+whTSJ1NXsOCmQPApWcLiVa5IeGvfx1D5gNH+P03dbhkjyxNOt?=
 =?us-ascii?Q?IFd3YQz4Itr03QGGPXdsU5umosYMUEMnCBR+oOXAQhqoX8bTlkrOV2uk4KDu?=
 =?us-ascii?Q?OQFekY9sBcEepV4T39pzJAXbI9SS3rAlHE6lsIdB27OY2Slok4JSkevi1shO?=
 =?us-ascii?Q?mux4JUnFhvb3JhQs4Kc8D16EnsYhRWPm8/OvJYZQmt3yPWe9JkAV3rMb6Yek?=
 =?us-ascii?Q?qdqINJ3LXV7JbyDJp3renxcy/bW9PeYoZTe9ZW92TOU97Qd68A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 11:40:43.8043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbee83d6-7dfe-4901-9a8c-08dcfd8eaec5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468


Paolo Abeni <pabeni@redhat.com> writes:

> On 11/5/24 10:45, Petr Machata wrote:
>> Paolo Abeni <pabeni@redhat.com> writes:
>>> On 11/4/24 12:43, Petr Machata wrote:
>>>> Jakub Kicinski <kuba@kernel.org> writes:
>>>>> On Thu, 24 Oct 2024 18:57:35 +0200 Petr Machata wrote:
>>>>>> Besides this approach, we considered just passing a boolean back from the
>>>>>> driver, which would indicate whether the notification was done. But the
>>>>>> approach presented here seems cleaner.
>>>>>
>>>>> Oops, I missed the v2, same question:
>>>>>
>>>>>   What about adding a bit to the ops struct to indicate that 
>>>>>   the driver will generate the notification? Seems smaller in 
>>>>>   terms of LoC and shifts the responsibility of doing extra
>>>>>   work towards more complex users.
>>
>> How about passing an explicit bool* argument for the callee to set? I'm
>> suspicious of these one-off errno protocols. Most of the time the return
>> value is an errno, these aberrations feel easy to miss.
>
> I would be ok with that - a large arguments list should not be something
> concerning for the control path. Just to be clear: the caller init the
> bool to false, only the callees doing the notification set it, right?

Yes.

OK, I'll do it like that.

