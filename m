Return-Path: <netdev+bounces-141890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316329BC9D7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CCC2847EE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700491D1738;
	Tue,  5 Nov 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UFvkuVJF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B990F1D0F60
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800839; cv=fail; b=i7PovkAWVP18JEJqG4ubGBtmxwmThqLYI+PTZAjBasy+m19gO+4lqZQqsX38e93G2rs5qjzIb9StBGTahruaHC6qUtjCvcf5n4y4hZWrXsXD25DByz5yqGnmRjso57aRoIlxFrC1AEtMkMgb1EXD00PZs/vEiG4u/h+P9OSOLMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800839; c=relaxed/simple;
	bh=DknoO9kwT/CxcLQO2oSM5F7D326/q6hXBf2xcRAissc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pXGZWLbT4poQ67XwewvByjqIFZ7I26t0924M2MYw2WAz4nUYkjSbnKtp8DEDvwAfCMDfJl0ntfNuvYLMvaRVc8scpUijJMLRaMRko8GCIJpnin6wl3XCAk3ubfhNMVqjRf2aS6nQ8WlG3bdeJBpYO4bBjM2wV6DFbm7XboxW2Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UFvkuVJF; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjfxMmOmUH92JgpNyEZ1hO7+4gJCtOYCr2wayiwjiKqtMAM+6XiCgM6RSC8YXHxtTfT+IBi5jOTlrzSyoq8o153342I6CsLi6gspRsWb6SFDwwk1luJJzuqMuqDNCwSEDorxffaDeRqZF5BFxsaKb8mAjOiSfkyh3XdB53mbAmFr/ZRlPatvWZ2RtzicQIPeR7gTfDkKv7EvMtYI+YgN6oNC0a+WlgpHNMvkwF104KWhIdhQ0E3L4PMYso0Wo641Djgu0kHSpXrQWrt8FgKzorr2FRXlelXVqOleVx06i5RUI3VyMnnN82tm8yNvKpiawG5g3fvR2UPosD8yJpeBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2wzk7KaQ+UJVuRGs2A1fFmXB3/Dl5DEeZ2hUjqo8W0=;
 b=d75ofBCQU1suhbfmmPFIM9wPgKNbs+BjHaj8DnbNAtqqV9wKdovH0d74SavZTHnkFLcIJJwE9214U4D3A/+PfKH1oiOsi2OIx92NszClRYnUpKH17VMN0qfLuYNk7cnRxfNQ6Vr+bNCjWNsKQCPCwTfH7UUX/mcliFr/ubCD5Cg58XP+FyQsvvDD15DU+9qjxagcPbbVEkwhYNqT1Mk7wHmmn46Ut94u3UlqlyqNPPF3XSZRWkzFwEf88ycru/kb5h5NClyp6S7j5ZtxID7xJ26qFb/dRYtPogqJRVrvaVekvXG4f3ua4RT7EQ7Wf3FKRTU+pH/MlkcZwrtVw1SEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2wzk7KaQ+UJVuRGs2A1fFmXB3/Dl5DEeZ2hUjqo8W0=;
 b=UFvkuVJFv26AT2FlCf+opaHmeLPe7PWUK3ud6ffuCvkByRZeusurgDcfisOgf17A85kICf2OheZ7AwcMFtwt6qYdPSB/6XGeZUS6AAh83zb2KH6uzZtIwUj8KN+zpnJEGW0TJMta/DF25FQGxJUboQ/PpUAT3cOmU51d/VJWMQAajf3/mgxpMTv1lfIUZjBTrlXMFXdcRwkyarQXNTkKnD/O1UFJIb+nP0WTmMqtE1NGt1ilH52gUSeHDC063TDR/GXea+i+n6HgMnuKucJrSuzeyHMzLVPsfSo3Eo1IGoRK19NZOzJR2qXgQbqNsMBShGM4QxUfj7gBJsD9FAOZRg==
Received: from MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::8) by
 SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 10:00:34 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:80:cafe::a9) by MW4P223CA0003.outlook.office365.com
 (2603:10b6:303:80::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 10:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 10:00:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 02:00:11 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 02:00:05 -0800
References: <cover.1729786087.git.petrm@nvidia.com>
 <20241029121807.1a00ae7d@kernel.org> <87ldxzky77.fsf@nvidia.com>
 <7426480f-6443-497f-8d37-b11f8f22069e@redhat.com>
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
Date: Tue, 5 Nov 2024 10:45:04 +0100
In-Reply-To: <7426480f-6443-497f-8d37-b11f8f22069e@redhat.com>
Message-ID: <874j4mknkv.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 778ca58f-9ed2-4b43-950c-08dcfd80b084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wMzP2g74XX5RIIdHOyAJDU4VK83SKxgmIer96fXOyN+t4RTF5/jxpJTaxhn/?=
 =?us-ascii?Q?F7+46xOU17OHsQJ4EpW7/OMH1DQFMAF1OMaViD6imnEAdIUdhkAY3VCMci8r?=
 =?us-ascii?Q?BYEJD5rTVNZiOq/BkdEa4WgX31CLka0rg9GEWGeDVNdGRnthZrqfnueoENl4?=
 =?us-ascii?Q?9eNY2pjNgk1wrxkAH3rXGEwX/52Vgdn+4TSCtiaNgigJ2zS1mCsbPpqflZZC?=
 =?us-ascii?Q?5xkpby4SN9PTCRiui2FYhw6igTrVljYx/OXu5VuNsfjJ/e+pgvspUs5CfSnq?=
 =?us-ascii?Q?HrwYqV7JjuPcFLLUTPVd6QXwtFHVGQyHizcMNr7XkUcy3JCIIaBe4nOlE+AZ?=
 =?us-ascii?Q?eNDPA/5MqAqPAn7YXggibQ7Uc0ZGwk6G+OH/OkpdmQzY7QLUHXdGEXhhWzM8?=
 =?us-ascii?Q?0jbaWU622btsPNl9tWQcLgZfqFtp5nyMDuooXupmsti/rn0p+PqCaCK+ijPA?=
 =?us-ascii?Q?FHsIHtRT+MCHKcwrSh91RpCsGpvRa2Pmdfmr8FCc5mEcsHgQ68JonsiOeLr0?=
 =?us-ascii?Q?TIKWxVT3KjaumDtlwT2iei7GxCOhry7MrbGkt1LU36IBaSQSW83nHbB6qJqf?=
 =?us-ascii?Q?ze8eg5vFbgHHj2l4a4iB6FFMdmSfjrErZQFQhDy+lPL0OFzyHqeST1GUzGq5?=
 =?us-ascii?Q?eE//ebXY/gyjcKR8FPTV+ua2Wf7MspXAjfyTc46nhdfR29wuqzdZCjkL5jg0?=
 =?us-ascii?Q?jcmtibuyKKRP8nN5l2FNNguNa5+Wc2Kckze2A03K8tS2LuLKM28/HtBnuuvy?=
 =?us-ascii?Q?fSJ7mDuTdhkQ1ndR++cLMo90DtXehssXulSXYumEFtFilDmRoQ3v7esoTGcb?=
 =?us-ascii?Q?v8uaw+Vt8F9KOTt8marlRI92xrNAHxXuX07AL8sA3IR3U7zokvCo6QRKAggp?=
 =?us-ascii?Q?A1tCXxKHtzYcMWVSCOBSnA6yseuKxdDiRIwmy/1eow4FvhBFRA6n+Slw2Eyw?=
 =?us-ascii?Q?cT8YwjcX2aSsqqcRWOK4629rkpPJrR8Fgq9u+GJZnbREuze+IqRMif0jO2ot?=
 =?us-ascii?Q?sIwjVPpTkY/62FE89q25ZGQJ/R5DMHf6rcMnpnHxJQlcv6T11nM8aTe/bycV?=
 =?us-ascii?Q?3AQvD4zXUpVAxf37Uotj3JDaP97YxuDl3VZT1qPLmzs5JMPECZzJxj+ZVePQ?=
 =?us-ascii?Q?wPxAGX7dTb9wERL7V+uUjA4oaqXb5ZL4l4VjBgcviRd6uZqEY03D1BM/CUS5?=
 =?us-ascii?Q?YQh5jwCDVA1GDqAWXJfKrJZudHTwfBkISS6cRUGcS3j/PL3HzUBg39lMIhEp?=
 =?us-ascii?Q?Ds9sWJpRcJx3H69bVbD3GsgFSsFepn53PLZZrx8oDl5qqTCcVGRvFF+BRJqu?=
 =?us-ascii?Q?fmPfZNOpXtsxZ8R9DnZHfVGQSEw8TyFtowj826f68ZUsiS3WRv7JYPOw0ceU?=
 =?us-ascii?Q?T1N6Rff0aYRrJEti9Bjuw9Pku6cBCQdVGJfgOMoWfe0AQRNI1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 10:00:33.7950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778ca58f-9ed2-4b43-950c-08dcfd80b084
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143


Paolo Abeni <pabeni@redhat.com> writes:

> On 11/4/24 12:43, Petr Machata wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>>> On Thu, 24 Oct 2024 18:57:35 +0200 Petr Machata wrote:
>>>> Besides this approach, we considered just passing a boolean back from the
>>>> driver, which would indicate whether the notification was done. But the
>>>> approach presented here seems cleaner.
>>>
>>> Oops, I missed the v2, same question:
>>>
>>>   What about adding a bit to the ops struct to indicate that 
>>>   the driver will generate the notification? Seems smaller in 
>>>   terms of LoC and shifts the responsibility of doing extra
>>>   work towards more complex users.
>>>
>>> https://lore.kernel.org/all/20241029121619.1a710601@kernel.org/
>> 
>> Sorry for only responding now, I was out of office last week.
>> 
>> The reason I went with outright responsibility shift is that the
>> alternatives are more complex.
>> 
>> For the flag in particular, first there's no place to set the flag
>> currently, we'd need a field in struct net_device_ops. But mainly, then
>> you have a code that needs to corrently handle both states of the flag,
>> and new-style drivers need to remember to set the flag, which is done in
>> a different place from the fdb_add/del themselves. It might be fewer
>> LOCs, but it's a harder to understand system.
>> 
>> Responsibility shift is easy. "Thou shalt notify." Done, easy to
>> understand, easy to document. When cut'n'pasting, you won't miss it.
>> 
>> Let me know what you think.
>
> I think that keeping as much action/responsibilities as possible in the
> core code is in general a better option - at very least to avoid
> duplicate code.
>
> I don't think that the C&P is a very good argument, as I would argue
> against C&P without understanding of the underlying code. Still I agree
> that keeping all the relevant info together is better, and a separate
> flag would be not so straight-forward.
>
> What about using the return value of fbd_add/fdb_del to tell the core
> that the driver did the notification? a positive value means 'already
> notified', a negative one error, zero 'please notify.

That would work.

How about passing an explicit bool* argument for the callee to set? I'm
suspicious of these one-off errno protocols. Most of the time the return
value is an errno, these aberrations feel easy to miss.

We decided against a dedicated argument originally, because it's not
very pretty, but if the callback itself should somehow carry the
please-notify interface (and I think it should), an argument is a more
explicit and obvious way to do it.

