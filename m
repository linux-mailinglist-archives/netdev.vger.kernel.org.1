Return-Path: <netdev+bounces-112747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB2C93AF99
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 12:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D471F2167A
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC79149C6A;
	Wed, 24 Jul 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TOFyDjT/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C422EF2
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815745; cv=fail; b=BQWCQTkauez+MuxWN1f12xCe9UlsniGZEbmHMhyfriHi2BpJmzFxeCnKxtdRai/EYgKmwabiLIzDshErckjuLSzafu9QPqUOjXAFEvfCRx/ZKX7PadUP6Bo8OZ4rOufudVmrOOBNNn76iJV7YYbLAZZsivSeqzOhiua8hUuyuDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815745; c=relaxed/simple;
	bh=gerOxQKqDq99CZs09kaiIhdp32y1ENBo7vGInIcQWnU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=k82ghndv+uZa/SW1rvSN9c9/9k+aiQoS6Ioc4HBpA6qU5Nqowd7pmmeZn3LcK96bdRvufR+Ka8VDgwI/B3pUwmudVpPdiB6tmd3kKI30a9EODvch4u1r6u8OqWi1mW97+/3J9jJaOv2fkqTlkCjxB0jrtsWExm7ZQSDdN1DoCoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TOFyDjT/; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUaMWDZMcKwPH1QTgT9cFSE0JeCWK8KI8mkHfy89bN20L/6NeGeyTgU6CW0qfRXwMA2eqTfTzlMQhzuVkMnKyxodTYreIefa8mZoL8Op3haDWed5VWap0TPusdkqpv2xolXFqvNzLBbt4o1rYFmuLy+na+xLZYEL1C8AB/IBLbqXc4H7dgt+ddLTOdrGO4MzNPzvrXx7B69ulRJX7IWb4nZfINfg8wOrLVRv4pFlmn1glSgy+sK0ZKmuGjK4J/TCmZYfFWoWEY0ERoEMnt7n/ROOuy57T/Ou0JPjlekq0h0xcb9I8XLriaPFv6LABv3xNM9AMxww4AyedL4+4b8z0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HiuUSSYnJUhC0NaUY0xjjSLnQRQysO9OTUc7ryuGJs=;
 b=yeVYGKD9FzHplY1G5iVw143GEzUxziCyw8xFUm4k6p9dR7RFB5LaqYB3Qa293bhTVa1pkBMglcNUiAhxe2fS7Z1N8HFJKiU/LtnhnWpmyq1Ed00IALLwud6DPPD6C1pU3lTaQasNkTGi0VIkgJu0m8SEORGlHWM3UCuxhdPm+ikWANWzdO8AIeP/QJn7Jxg0Lx1Ub9R8bBYLyNwGKUnDm3y9FddQorsdIy8nF8n82K97gXtyyBAk8RejZObezgkU81daFhH1Kx4i2np0OoEWXstnyzmPLgB5PQand+EAFjJpHEImQwHHOyFxh0vALBnKVkVjDmZF6TgjBXeLmfrKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HiuUSSYnJUhC0NaUY0xjjSLnQRQysO9OTUc7ryuGJs=;
 b=TOFyDjT/+1BHoxAILTyARtMy0MrJ9No6JCtIr+T3969ASoJiwnvzPNZO3qYnne76Mlgfkngok/JbJWyuOb+/69hNo9fBpbsmyGG6dlJRUdKKpzQtf11eJsSMpNdo9Xb0VqeaZPq8QZgtG75+BTkHhXf4eftX0TV0MykTIolIzMHzEMEpORtdB7LvNq1oKr3IbZECUuekK/4ibdYSM+zny8G39sIirLSCyXs3ZGUGKMrw91b8A9Bm3jcT9TrrIN7Blw2zZ8//2IkQy2k4tGR6ao9/ZzS93HU7hGwoC5JzI58Sc+iq5jCSnbRJc2yriCZnj7R9Kd3V3F0u2hKyy0BEoA==
Received: from SN1PR12CA0086.namprd12.prod.outlook.com (2603:10b6:802:21::21)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 24 Jul
 2024 10:08:59 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:802:21:cafe::33) by SN1PR12CA0086.outlook.office365.com
 (2603:10b6:802:21::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 24 Jul 2024 10:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 10:08:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Jul
 2024 03:08:45 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Jul
 2024 03:08:40 -0700
References: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
 <CANn89iJQB4Po=J32rg10CNE+hrGqGZWfdWqKPdY6FK0UgQpxXg@mail.gmail.com>
 <CANn89iLvqJXmCktm=8WoSuSWOAVHe35fy+WHet-U+psMW2gAoQ@mail.gmail.com>
 <CANn89iJ6vG3n0bUbGuHosRDwW97z7CT4m4+_D91onPK5rd8xVw@mail.gmail.com>
 <CANn89iLcHERTvExi7zEVwArxBzaa2C-y_W_UPQa2ZWzYdT_d+Q@mail.gmail.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net] net: nexthop: Initialize all fields in dumped nexthops
Date: Wed, 24 Jul 2024 11:12:22 +0200
In-Reply-To: <CANn89iLcHERTvExi7zEVwArxBzaa2C-y_W_UPQa2ZWzYdT_d+Q@mail.gmail.com>
Message-ID: <87o76n85ml.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 291d3e18-7f3d-4c1f-5e67-08dcabc8a2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHQ1VnJwZmtUUU02QlB5bmxRZmtSTCs5UDVmSHVIcDZXWGVvYUgrVEZOMXVw?=
 =?utf-8?B?cFJTM0g1RW9oOENuZVNVTTE0bXNWQlhKN2I2Uy9MWW5UMSsxQ2t5KzRkV0Nt?=
 =?utf-8?B?QTk3RWhYbkhNUDk3ZkJoN2hSKzFuUzVlY0VMYllkZzVMS2kyemtVdDltVTdQ?=
 =?utf-8?B?ZTI3NHZiUWZUM0VaTXlsaERMaU50RmMwbEJGdy9IZmFqaGI1eU5OUW9BM01x?=
 =?utf-8?B?OUw2ckZYYW05WFgvSm5jc2lpMENBdGp5QWQ5clZiSlpCWjQxQnVJNlp0OEdS?=
 =?utf-8?B?UEdidS83UVdOdCtCK0FoZzlPa3ZTQ21STEVXYTM3U1FwdnRRajFPRHJpaTRD?=
 =?utf-8?B?aXZFQzRQb1NwZHlFV1kzS1ZRY0liNTFrQVBpd1R6QVlWYmw1V0lIUTZWUDh1?=
 =?utf-8?B?L2NOMld6Wk1GN015TG1tWE1zUXFOSDhUVHpCUmxOakRUbGs5eGxQYkwxc0tV?=
 =?utf-8?B?UGlPdUlpRTRMTFErN0x1QUg4ZDlpL1BCT2RQWTJnRlptUDVkNHBwMlBZSGRQ?=
 =?utf-8?B?cGp5QUxYVTVXMkFTRGZVQzdTc2xwY004MDZ2OHM3ZVpzWHNBYXRHeWNIbWJX?=
 =?utf-8?B?bDd2YlFpT3VtUzFzWTBHbi9ucmVJUWROV1RLNXhoQk9rV2hnKzYrZTk5MDEx?=
 =?utf-8?B?dk5Iak5tK09KNnhnUFlIVW5saThrckRoZDJTNktTbFpobExQbGc4QjRka3Y2?=
 =?utf-8?B?SDBJdkpsL2JEOUwxdEsrNCtRK056N2pQQ0hPZElRN0o3czlZb3loOCtGaDkx?=
 =?utf-8?B?TVp3U0dNejdqekRSek9oSHRIdEdQOFhEYmtiT3NYUkF0TU5LWEFVYjVWQ1dY?=
 =?utf-8?B?L3lmZVFHbkpGczlPMlNLRmVueVBsbG85aHJZSm9hYS9KekFkeFFKQkJtZFYv?=
 =?utf-8?B?YjdBQnNQNFFndzVhT1JtbGVYUHROdDZ5eDhhQnNROGJiaWJWMjdUTEk0elBZ?=
 =?utf-8?B?bWltbGFvVEZDSHFJaVIwTS9ZNWFmOVNTTzU5NndyeVlFVVVOc3dERVpFaWxV?=
 =?utf-8?B?QmEvbnhsSjRZRDMyMzlRK09IQVpmOGFCZFU4NW9KbmJ6dVNDMjFpeWZ2UzBk?=
 =?utf-8?B?Y082VkhIWEtwaytHZmgzclpoWUFDQU1GR0Fmb3hXeFVFbXE3S3o3eVRCRU1y?=
 =?utf-8?B?Y3F6dVlJdjNsTUtZcWlSeDBMNzBZcWJiZnBMdTdPNFVCKzlLUGwvTnlnTjV6?=
 =?utf-8?B?M0lwdkhjV2Jwa1E3ZmN4ekdnS09xZHcrcVhUR21FODJkN2dORU1zNDhRL1lK?=
 =?utf-8?B?WVcrR214UE11WTlvNmlZck5JVG8yVzFlRVpRcS9Fays4SEdlNUczWTc0TUMw?=
 =?utf-8?B?MHBvYXEwK25lWTcxb29XdDlsNTZCS2pHYlVyRlZNcStSNlFMNE4wWUUxdEw2?=
 =?utf-8?B?amdHZFJIdnMxck9PMVNnNXR6NHI4dU5QT2JLRDFUUThZeEZXSjAvMmF6N2pt?=
 =?utf-8?B?WmR5TlVERHoxOTZ4Sks4aXd6Z1plVVBDY0RRMCtFd3paTTVrRzFKa0NuM0dt?=
 =?utf-8?B?blowK3lYc3VWNmNUTERmUkZwNlFoemR6VVhsOUlXU2JRWXJRMG1WTDRhZ0RV?=
 =?utf-8?B?WWxWeVROZTAvQSt5TmVPRkFkVnNMeWluL2NuNjQ1R0gydlk3S2wrTXNQUUMw?=
 =?utf-8?B?YXV2OE5WZEpIVjg4TGNKajl5TmRxRTd1Y3VidW9NTmkrbW4ySmYyRkJOZEx5?=
 =?utf-8?B?L055QXJhQjVQZm45WFl6aHVLU01wWG5LQjBvRXJiZ0lVQUxXNFFuQVJ3ZGow?=
 =?utf-8?B?SloyMFBEZk5jYm5TU25lWE1KaFU2QlNXRngyanZZRFZ2Uk5mdy9qd0RDa1Z2?=
 =?utf-8?B?dGJ0NkxpODh2Ujg2Q3llNVdUaHp0ZGVLWmxNb0dsRWttT0paTURManBVVE1J?=
 =?utf-8?B?ZVRLVEpocE9XaVBZTE9DaC9xbng1TGc3TnBIL21HMzNXNURMd05JOHpZNmJl?=
 =?utf-8?Q?B5LYvZF6mjmpJ7pJJkEhe5GXxxduP7tz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 10:08:59.0555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291d3e18-7f3d-4c1f-5e67-08dcabc8a2be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037


Eric Dumazet <edumazet@google.com> writes:

> On Tue, Jul 23, 2024 at 7:41=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
>>
>> On Tue, Jul 23, 2024 at 7:26=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
>> >
>> > On Tue, Jul 23, 2024 at 6:50=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
>> > >
>> > > On Tue, Jul 23, 2024 at 6:05=E2=80=AFPM Petr Machata <petrm@nvidia.c=
om> wrote:
>> > > >
>> > > > struct nexthop_grp contains two reserved fields that are not initi=
alized by
>> > > > nla_put_nh_group(), and carry garbage. This can be observed e.g. w=
ith
>> > > > strace (edited for clarity):
>> > > >
>> > > >     # ip nexthop add id 1 dev lo
>> > > >     # ip nexthop add id 101 group 1
>> > > >     # strace -e recvmsg ip nexthop get id 101
>> > > >     ...
>> > > >     recvmsg(... [{nla_len=3D12, nla_type=3DNHA_GROUP},
>> > > >                  [{id=3D1, weight=3D0, resvd1=3D0x69, resvd2=3D0x6=
7}]] ...) =3D 52
>> > > >
>> > > > The fields are reserved and therefore not currently used. But as t=
hey are, they
>> > > > leak kernel memory, and the fact they are not just zero complicate=
s repurposing
>> > > > of the fields for new ends. Initialize the full structure.
>> > > >
>> > > > Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
>> > > > Signed-off-by: Petr Machata <petrm@nvidia.com>
>> > > > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>> > >
>> > > Interesting... not sure why syzbot did not catch this one.

Could it? I'm not sure of the exact syzcaller capabilities, but there
are no warnings, no splats etc. It just returns values.

>> > > Reviewed-by: Eric Dumazet <edumazet@google.com>
>> >
>> > Hmmm... Do we have the guarantee that the compiler initializes padding=
 ?
>> >
>> > AFAIK, padding at the end of the structure is not initialized.
>>
>> I am asking this because syzbot found a similar issue in net/sched/act_c=
t.c
>>
>> My current WIP is :
>>
>> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
>> index 113b907da0f757af7be920cc9b3a1b1c769f5804..3ba8e7e739b58a96e66ca64d=
38bff758500df3e1
>> 100644
>> --- a/net/sched/act_ct.c
>> +++ b/net/sched/act_ct.c
>> @@ -44,6 +44,8 @@ static DEFINE_MUTEX(zones_mutex);
>>  struct zones_ht_key {
>>         struct net *net;
>>         u16 zone;
>> +       /* Note : pad[] must be the last field. */
>> +       u8  pad[];
>>  };
>>
>>  struct tcf_ct_flow_table {
>> @@ -60,7 +62,7 @@ struct tcf_ct_flow_table {
>>  static const struct rhashtable_params zones_params =3D {
>>         .head_offset =3D offsetof(struct tcf_ct_flow_table, node),
>>         .key_offset =3D offsetof(struct tcf_ct_flow_table, key),
>> -       .key_len =3D sizeof_field(struct tcf_ct_flow_table, key),
>> +       .key_len =3D offsetof(struct zones_ht_key, pad),
>>         .automatic_shrinking =3D true,
>>  };
>
> I guess your patch is fine, because the holes in struct nexthop_grp are n=
amed.

Yep, that's it. It's not padding, it's just fields.

Otherwise AFAIK padding is unspecified in general. For these partial
structure initializations (i.e. where some fields are omitted), at least
GCC as of recently has initialized padding to zeroes, but it's not
guaranteed.

