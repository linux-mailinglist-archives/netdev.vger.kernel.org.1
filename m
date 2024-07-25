Return-Path: <netdev+bounces-112995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577AA93C25E
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DF228222D
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD719AA42;
	Thu, 25 Jul 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bq0mJpeX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE019AA71
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911765; cv=fail; b=VVEeE1zJO+VkeG8kNKJhrZCmjXvOA0/IE23IbUa6SyHaNOb0ONXnKTngcWo0NDfTnRSDX1fST0358zXW6/OclD/AipG1UfbGbiPXar7f4pLJoEHehF2aj4kdqNh8UtrODcy6YxYDNld44cblV3yEi73+KvKEtUCI3DV9N7CuIro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911765; c=relaxed/simple;
	bh=ZZUnnp3N5EpuVirF2TvOoEyGhTgsb1TtFW18FyhGAeU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kp2mgU2yhJlymidUK9wS1jtGqqVS8uXurSBMsEFbLLJyMPVlIKttPjD7tU0S6FQikTe0q3j8bpc/oyXu9VUOD/9C2VCb0+B9JGDMH6LwjJN7pWU3TbT1mecH4RPe/edXlnEDox1IoT4z6pJBpD+NnsJs0VVWmKW+7kt5dWMduJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bq0mJpeX; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksOWLFddSV6pAaKFRkZJ+6mf/R+BeiPYLdv8iRUwUlNbisHgUUmfePVFLYROLxHLmaA2QegIpwD+ueLH6H76nH8ZwEmLE+t5AF06hA5/EvZvXkjlIfEmS10YT5lxMiUD0DCqfyRPpM8lghRbzMib6pjDXUvPZXr12Fdvv+zDusXxOngv8I54YybF3rtEUh0AYUmsrBjjxg8ubvGUSY/aO1VHuR/MPpa1D0M1xHaBEyvGkYJfwS+zKDiMpHgPNoDZXem4kn2rZaKgh+B9BjBm66QTxPgKJBgRaHXL0mUtqyIXe0Vj8TK3f5pbiyqYzEU7F52N33cUCH0htzzZ0RbhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6srxyUYq+ANabKSGc/USc3HjWYdam63/BGhC5/3IL5U=;
 b=JvjyNgEo6OiJ5BSKluplQeW0EEz4+4gxEaYp2L05F2TY/auD/6iJ00LjblnHfH6wportnylfnsrzWrrd6le2vKn7JxFaHvE7f9627shZbnY6AY/tfJq/yJwUoAm6IaLZVLQgYv3b44aywMXbDWekmdOMAB8NusvXoMFiyKjasISt5mQZTMQ0oMPiYGaCQF4yT/L8GD4G09TLq1xI36M1duaguSWPlGs4bc1l0uzGzIFbOEMH7THhyGh3NJNGQwybG3JJJrEg+zwR7vqfq6iX62Nhuhl5iGNqmJzIPaf7ebA8qsbTXmFXX/qIGsaa6YqMyDhMYj/moOrb+Jn/pCb8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6srxyUYq+ANabKSGc/USc3HjWYdam63/BGhC5/3IL5U=;
 b=bq0mJpeXenOLJ6rXsFmUO60tIfQv8vwrdRi760E7eDcui25IJMlLsgHva1zx3Lldz+pQm+Xq6Tb/eVRXACZ0FfJ/V+eLZiaBNph0JdqvGHiP9/sLvC40CuCAKxHtYe1d5vFdJ7GfG5BLChtjgapvAiU367cWvHqVT6p7AIP2kPeV7B8MkRfJODOTOaD+Y03MgjrcLzc8j5o0X1bbE5kPfBeK25kGsw/0j3bg7XPkFoc3Ka6fWMQFBT2EmUxnFfgrqC9w6zutlRhXaXUozy9QS8dcS7MTlW4L+pqpttknOLvC3XafITrqfQlwlAKjJg24y4/DgXXJTgowwhzOIWR7zA==
Received: from PH7PR02CA0021.namprd02.prod.outlook.com (2603:10b6:510:33d::26)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 12:49:19 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::1c) by PH7PR02CA0021.outlook.office365.com
 (2603:10b6:510:33d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 12:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 12:49:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 25 Jul
 2024 05:49:04 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 25 Jul
 2024 05:48:58 -0700
References: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
 <CANn89iJQB4Po=J32rg10CNE+hrGqGZWfdWqKPdY6FK0UgQpxXg@mail.gmail.com>
 <CANn89iLvqJXmCktm=8WoSuSWOAVHe35fy+WHet-U+psMW2gAoQ@mail.gmail.com>
 <CANn89iJ6vG3n0bUbGuHosRDwW97z7CT4m4+_D91onPK5rd8xVw@mail.gmail.com>
 <CANn89iLcHERTvExi7zEVwArxBzaa2C-y_W_UPQa2ZWzYdT_d+Q@mail.gmail.com>
 <87o76n85ml.fsf@nvidia.com>
 <CANn89iLGh6sG8AhD_dgb15Es6MsATZ+QHkNzHwm5iufTCXZ+SA@mail.gmail.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net] net: nexthop: Initialize all fields in dumped nexthops
Date: Thu, 25 Jul 2024 14:42:23 +0200
In-Reply-To: <CANn89iLGh6sG8AhD_dgb15Es6MsATZ+QHkNzHwm5iufTCXZ+SA@mail.gmail.com>
Message-ID: <877cd98woh.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 3786083f-c1e0-4c49-38d8-08dcaca832eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWx3TWVMU1hmM3BpWUMrUU1SclJCWEN2UFhIc1ZtS1p2V25TRCtKSXF4dTNG?=
 =?utf-8?B?c1FncEhlS3lHcnN3TEttSTNnSFhUUUcvVndlUGRpdGVSbEczbm90ckVpK28z?=
 =?utf-8?B?MVpZem12dk9KS0RVNFJ1MDFVcWRMS3pZdEZ2aTFENFNTdFZuUDBzY2JWM2NP?=
 =?utf-8?B?alRQYUk1eEo4c1kzYSs0SmMzWjFKWFhKVWhITlVFNWxSc28zMytsamx0YklL?=
 =?utf-8?B?M0szQXJ1M1o4S2JHK1l1ZlBEOW9naVpDSmVKekFEeG54WUlGY1lETlZsd09T?=
 =?utf-8?B?d3FrVjhadVQxejF3b0F1eEs3ZmlrTTNjTmxjMTNlaDkrRjh2d2VMcllpMDF6?=
 =?utf-8?B?MHQ4YzlkMFpTR3p1d2FnK0g4ZVhkdHRmWW5XUFBQWEpiU0lZWWl5VDc4Uk9P?=
 =?utf-8?B?K0NDU25Va1ZXN1VLdWxVWEFmdWJtQnRsbjVzZi9MOEcwWWpIUEJKRWVwWVl0?=
 =?utf-8?B?Q0xVZGx1d2lYdHAwNEVyTkQ3R2tHOS82QWNIYkc4cGFuTzN5dklIRnBGRXdm?=
 =?utf-8?B?TTVLVHFJU2ZkeFQvNzFGek5xVGN5UFJpSUlyVTdjdUZyWGJDSWNmK28yV2x3?=
 =?utf-8?B?akRCb2J4Mlg1VGg1MHdWZFdoc3JVWjE0WkxFemhCZ2l1VVJGck9qYWxRcDgz?=
 =?utf-8?B?R3FRZ0hsWG5CN0t0N2F5REZ5ZXEyM2lMWGdSRTczQ2RWb2IzTk5pSDl1VG8r?=
 =?utf-8?B?dis1cVlqZzVkWlpseC9VUXI2S0ZHeEhwaTJkWEw4ZGZDaytwRXpNdDZmNURI?=
 =?utf-8?B?Mmk2VWkrZVljOWR3WC9iU1hEOHQ5ZjdGYmRCclpyVFBMdmJPc0w2bnovcEJT?=
 =?utf-8?B?cVJtQkFHUS9zTUd2T0ZPV0FjSnFmTXhUUWdKQmJ4anBXWmN5TEZlVktTY2Rm?=
 =?utf-8?B?MXZ1NEc5Z0FrNUV4d0MzUEdlOEtNNkcvUU9mVjVLMFZ4eE56N0xzVG0vSFFX?=
 =?utf-8?B?SmFINWdoOWRuY2ZWa0RsS3lqWEgxRGZtc3VKbWRIV0tpTHF5Z2R1UW02bWNM?=
 =?utf-8?B?ajdBaDgrNFFjZlIvaW5lZWRrSW9PZjdVbkZnTldXN3FHL05OeXhnMk5ueXlk?=
 =?utf-8?B?dXA3cnhTODAwcnFCWFBQTmc5ZDZVb2ZEeklLVGtFb0VVTER2UEpYSktNRHhQ?=
 =?utf-8?B?eENsQk1SKzJHWlcvZ1hxV05WaklkWFM1UDZOcStiMk5hTWFQZ2gwWmRYTnlL?=
 =?utf-8?B?RGVobVdMQ0UrSWFQaHBPVFVBUEphTC9EZytrOXRCb1BmV1d4SHhPaHRsMCtv?=
 =?utf-8?B?UFZYSkF1ZjdqZXJ0eVc3SFRkQ1k2WVVFdi8wY0grSlc4R3Ztc3AySVBCRk52?=
 =?utf-8?B?TGFndURqTElmY0NhQjl3MUhMMitWd3dzTTA3SjVCQTk1WlVMR3N2dlFIa2Ir?=
 =?utf-8?B?Z1ViWi83cnVKL1hrWjQxMFFsNjE0N05NVWJHaTE2ZExHUEtIN0lMYUpjVDRw?=
 =?utf-8?B?NElyYXp5dDRLaGRMeHNsTnlkSXd0WFlJQnJBMFZZbnpvcVJTeHFLLzZqN0dq?=
 =?utf-8?B?d1VITDlMQVF3MnN3R2dQRndWelY3VUFqUXZtUHM2bmh4RVpYVWFWdmQrNStx?=
 =?utf-8?B?YlBMOE9BNUZ2ck9JZlF5NXBOUFVieW1xUU5tZ3pIbUthNlFhdG9RbDFDT0tY?=
 =?utf-8?B?U2F6RWMrUzVDZVRZMFVBaDl2QjFkOFNOQUM3bElVWnF1a0ZqZ1VONFh4TTNB?=
 =?utf-8?B?WHBaSmFTKzNySUlWYTdIUStEU1lIVHQ4ZWpGbnlOdXl2TDhYb085SUNCdnlk?=
 =?utf-8?B?L3NzVmVMOCs0TjRuK0lMK3FYQnBGZ2dxZHpmUUZwdFdLcGF4TjVCREJUeHBO?=
 =?utf-8?B?bTV5VmQ1NW5ZZW5HNjB5L3pxaUhSaHJsMFI1VGxxVXgrQ2w3Vld3WXRoV2dT?=
 =?utf-8?B?M1FzenZpeWFyTnVmL092VnNrUzI0SWxYbFllY1RORlRzdmN5RUljd0w4N3l6?=
 =?utf-8?Q?d84LbYDCCz9gpNqkgIcIcHUZ48+Eneeu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 12:49:18.7746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3786083f-c1e0-4c49-38d8-08dcaca832eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261


Eric Dumazet <edumazet@google.com> writes:

> On Wed, Jul 24, 2024 at 12:09=E2=80=AFPM Petr Machata <petrm@nvidia.com> =
wrote:
>>
>>
>> Eric Dumazet <edumazet@google.com> writes:
>>
>> > On Tue, Jul 23, 2024 at 7:41=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
>> >>
>> >> On Tue, Jul 23, 2024 at 7:26=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
>> >> >
>> >> > On Tue, Jul 23, 2024 at 6:50=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
>> >> > >
>> >> > > On Tue, Jul 23, 2024 at 6:05=E2=80=AFPM Petr Machata <petrm@nvidi=
a.com> wrote:
>> >> > > >
>> >> > > > struct nexthop_grp contains two reserved fields that are not in=
itialized by
>> >> > > > nla_put_nh_group(), and carry garbage. This can be observed e.g=
. with
>> >> > > > strace (edited for clarity):
>> >> > > >
>> >> > > >     # ip nexthop add id 1 dev lo
>> >> > > >     # ip nexthop add id 101 group 1
>> >> > > >     # strace -e recvmsg ip nexthop get id 101
>> >> > > >     ...
>> >> > > >     recvmsg(... [{nla_len=3D12, nla_type=3DNHA_GROUP},
>> >> > > >                  [{id=3D1, weight=3D0, resvd1=3D0x69, resvd2=3D=
0x67}]] ...) =3D 52
>> >> > > >
>> >> > > > The fields are reserved and therefore not currently used. But a=
s they are, they
>> >> > > > leak kernel memory, and the fact they are not just zero complic=
ates repurposing
>> >> > > > of the fields for new ends. Initialize the full structure.
>> >> > > >
>> >> > > > Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
>> >> > > > Signed-off-by: Petr Machata <petrm@nvidia.com>
>> >> > > > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>> >> > >
>> >> > > Interesting... not sure why syzbot did not catch this one.
>>
>> Could it? I'm not sure of the exact syzcaller capabilities, but there
>> are no warnings, no splats etc. It just returns values.
>
> Yes, KMSAN can detect such things (uninit-value)

But that would involve a splat. There's no splat with this issue, even
though I'm testing on a CONFIG_HAVE_ARCH_KMSAN kernel.

