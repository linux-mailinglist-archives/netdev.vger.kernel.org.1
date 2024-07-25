Return-Path: <netdev+bounces-112997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BC93C295
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 15:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051AA2824A4
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 13:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76919AD6E;
	Thu, 25 Jul 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="My7d1R1y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665019AD56
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912391; cv=fail; b=MikQlluzVvMFwmF/GVnFg+mWQPXPDr7bzmVeAB2NfGgJjvUUBSeyBeUU1p8/++KlFDfIgqpam2NKxQsPjQOJZ3QmvWHBI6heuokK1e2tl+ccxQDmXTSdE968aif76rEo8Ngc7UQM1yNvjLFiQcLWeJ8F3gCUxbyU/NbFI3uvLgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912391; c=relaxed/simple;
	bh=Zyr6f+dtZp6FBn6Eh0PKzq3rajaVYhyZWeBhBlsHIn4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cE+j0FFHA9KdTb7eWr7S/aI53o9LTN+Is/DA1srluSDCNvzG561cOLtXoswnwdWGPE0nfbu3ROjELHkHLaBAHEPoeNezM7p9b6lnErq2dXEl8KTZfRwmCd3oahZkzDGg6Qq+lm2bQMAIoYkaEhtMnmbynaHVenFeb8YSZ5V2PZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=My7d1R1y; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlxGA/2useOTLYIV2rFsVgv/s5w3vC6Gm5eLs+CCL6boeaZTbwGVhAxL1ieLBLDNo5Nt73Vr33uh3g2LZeZyr+Ec3dW1zPMznwrHkn7HnHMM+TTCEuTGPoRW/eS2sIFNUOVyrSzQ0zGYF6MOz6cVqZh4jsTT2DS6iuPZTHy8KHujPwVK+SyVj6PnVZ9DpBOMAP2GWFJmttFiRoB3mAk15zNy738FYHs3BE9JatCBYUiPWrZtHeSxaKdZXfD4Z5p9rM6gYcuGjOrr9/rMwPV0hqnxbYx1P99nrMLNjvCNSdY5xvuV+xyb2twlLdrw9PI8ezlT8/EWWK3ptd0rWSf0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyIW6bDttWvKPQti8JMqOlCcVvXkOyBe5pN5/wX5d8A=;
 b=AjqErewLLU9dVHnL94aUjFWK6IwZoQ/6DNV4vPmX2Sqpg35bLPsRYo7+N0rUMw+SbIfrA6hFEblX8vVlwts/AvEYq75sNuJtwVSUaYbE2hNjP6QI5N+rgvtS7150+V3PSOVCrGbBx3dVMGCE/p3M2ayrxVMeqBYJL6VGf8ZKdcQ483yaOgpjAI8z8bll/jduh+w95hP9y5C6VNFEHeveqA0QBRml7pcOG6irivUuZTzCzgP25fnIrKd5LSS08PEXfjVXlEiz88Mv7h/36cMVqL7O7x/qIlv1UdFCIekdgiOt2HrZqNv4OW6nbPEzegiXtm7OUcZnFSCpAyeXcRdq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyIW6bDttWvKPQti8JMqOlCcVvXkOyBe5pN5/wX5d8A=;
 b=My7d1R1yrMp5VuHinFAuqBDHF8vUEqxXfonszps7KuR+gJGEE4cJ1QHT7V4ogNGoUZ6umR4blJxxCNuPaXsO4Djk/fKSeLxgE6SmR9HQWrz0GR5ivw/2VH8bB5ltnwSuWiMbfz2RAUBScK4HCmnQjiGBieSxMb/YagZocTcLMKOowjU311B3rhs8HT4O7L91unRrdADRj+xzG3z2Nmr4CcoD6HiFwYO2IS1e+EVGoWimbmioKvuyBPrUqHlU8+qSMr72gWh58STdbAi4CmcJi1ISPpq7heouo58zps735Z6OC59G7gh3PJ116HHjICdGfPsaW7uPwtp3XoQl4it1MA==
Received: from DS0PR17CA0021.namprd17.prod.outlook.com (2603:10b6:8:191::16)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 25 Jul
 2024 12:59:45 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::9b) by DS0PR17CA0021.outlook.office365.com
 (2603:10b6:8:191::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 25 Jul 2024 12:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 12:59:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 25 Jul
 2024 05:59:34 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 25 Jul
 2024 05:59:29 -0700
References: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
 <CANn89iJQB4Po=J32rg10CNE+hrGqGZWfdWqKPdY6FK0UgQpxXg@mail.gmail.com>
 <CANn89iLvqJXmCktm=8WoSuSWOAVHe35fy+WHet-U+psMW2gAoQ@mail.gmail.com>
 <CANn89iJ6vG3n0bUbGuHosRDwW97z7CT4m4+_D91onPK5rd8xVw@mail.gmail.com>
 <CANn89iLcHERTvExi7zEVwArxBzaa2C-y_W_UPQa2ZWzYdT_d+Q@mail.gmail.com>
 <87o76n85ml.fsf@nvidia.com>
 <CANn89iLGh6sG8AhD_dgb15Es6MsATZ+QHkNzHwm5iufTCXZ+SA@mail.gmail.com>
 <877cd98woh.fsf@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, David Ahern
	<dsahern@kernel.org>, <mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net] net: nexthop: Initialize all fields in dumped nexthops
Date: Thu, 25 Jul 2024 14:56:47 +0200
In-Reply-To: <877cd98woh.fsf@nvidia.com>
Message-ID: <8734nx8w6s.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: c361fc36-6c4e-4ea0-256f-08dcaca9a83f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGlHczVHMVJ5MExNSEFvb2IyL2IwNXRmZnBJYks5d0dyV3FUd0hsME5IK2RK?=
 =?utf-8?B?RndrT0djb3hNRWlWdG4zWUZrMnZTZ2ZRMDBWRFBqRHJ4U3R3Q09JcmpocFp4?=
 =?utf-8?B?TFNVelJHa09JYU1laENUTUllaWY5KzZsNW5XeEUrU3NyOHVyanZQQUV4MzNH?=
 =?utf-8?B?Z0NQbnRYalU4cFdFeW5HbkhLalhVd0lNRmU0TGF1UmxOVWRxa2NjV0E4Y1Nh?=
 =?utf-8?B?b09iRjVsNE5lcElScGF2c3BYODJTR3V0QXRYQWxHZEorSnROY0VtQWxMUzJU?=
 =?utf-8?B?T0tpekR1bUk0NEhKY3lQdkJjV2lUVWJaZG9hNmV4K2xVRzFUTkdLWGQybWpi?=
 =?utf-8?B?ZDM4czd1THFJS1pEN2ZycTFoU0hWWkdMUUdXUitjOURRS0lHQnAyNHdlMnZL?=
 =?utf-8?B?WUtCNnp3MW5nRjJ3czhaNjdpWThpVkx4bklsOXNidkdvWmdqOWpCNGRjU01h?=
 =?utf-8?B?bHdPMHFrTXdVcDRNaC9ETEtYYzI3NWxSSFk3RnFzakVWWWVYeXMrRDFBNktm?=
 =?utf-8?B?Qkp1a21TalYvdjRnVE45Y00xajIxcmVPcmY2Zlp6N0FBaE1PY0N6OFREWXJ3?=
 =?utf-8?B?TDV2azlzYi81NVc1aVpzYWpMSm51dUFDTEJYai9MME83WUVJRHordFRsNG9a?=
 =?utf-8?B?RDVnekJiVUg3VVdacnJGQ1NGdjRFc0RXNE15MHU1MzM1Wk1ZU2JiT2RWT0lU?=
 =?utf-8?B?M0svQXdxNkp5TDU4Z0FrTmRYeG1TQ2pjMk1NeExVUG92OHRaVEZFMEFjOXhh?=
 =?utf-8?B?amIwcXBYRzV6R1RHWDR0dTZuWjFjTXZwNE85alpWb2hoMjYyNi9LUEVuWGVm?=
 =?utf-8?B?aTkzSkVqUnZ1U3lORU5FN3FPTDVaT2ZNa2U3TENMamtDekVmRkFqWWNWYzVU?=
 =?utf-8?B?VUVWTDZOZnpoMVBreDF3N1E1cVlhOWVLL3A4ZlZnNkk0bTlHdkphZlgwUTVG?=
 =?utf-8?B?QW54VytYWktvMjc0NzhQOElvWG1xQitYanI0RVZxOG9Ucms0UlZRKzlOeGNK?=
 =?utf-8?B?S093SGY0VkdpMGxWTkt6OXppOUVlMEhqalhiWkl4R2NXeG42cFIvdm9sdnNa?=
 =?utf-8?B?a3o5TVl4NDlWM1djZEd3dm0xUFplT3YwMjhFZDlabTU3V3IxUVJiZGNGZkhD?=
 =?utf-8?B?aWprVUlwYUdjKzh0M3B4VzZnOGJPaS96NkxJWDZKWWpEdmdjZVY1Z2tOcUhB?=
 =?utf-8?B?aFQwdDRqaURNRFNDdmNBbjdXSzd0bi9LWU45YUdoNGxleCtiR05hRDlCMjN1?=
 =?utf-8?B?SHp6RTFPZVR2R2dBR2RMalh4b1RLZUJZd3hTaCthUEhZa1pZZ3lPUDkvejJC?=
 =?utf-8?B?WGFUc1VsVFFta3lnTGhVZ3g5dE9UMHY5TzJMdkVhNW9HY1p0REhoUnNYYkJC?=
 =?utf-8?B?TjVHa3lhZVF0T2xMYjMyZzRMSXFyVE8rbytxcnhNU3I2VnJhempINUVmOWMv?=
 =?utf-8?B?ZUpNMHZwNTQ2amhrOG5MdDZYWFRkOFNoLzRZR0REdW5mUTRYV0Z0ZFBwVzZh?=
 =?utf-8?B?T1J4b0wvRkpiRDFpdHp6VGc0WW9JWmMweTJaQU9oZEZWZENqU3ZKaFZMelBS?=
 =?utf-8?B?VUxERzN0ZHkwMUVvOEVmRGlCU1NENWJRR1VSQkNzNGxtOUNYeHZOZ2h1cm0y?=
 =?utf-8?B?eXR5MmxUME9VOWZoZ3dHVnpSTDkzdE1kSVp2TFZkSEllamp1ZHlCcTBZQWJH?=
 =?utf-8?B?RmFQUnlRZXU1ODdkcHZUMUpTaXBiTC80VEZZZ0U0ekUrWXhhMHB4YW5BNlBP?=
 =?utf-8?B?cjlmaXpMUDZLZmMvNXM2VU4wVGorNVNPU3pLTDBZZXR6Y21LWnBwbG85VnB1?=
 =?utf-8?B?TDRockgycS85SlFuc1d6alRiL0VDYkdQUnlkWDVVU2dFNEZRUDBNdmsyUFdS?=
 =?utf-8?B?QWRBbDlXd1dCSTBJYjFoK1JQQmpWdG5sRUdOWi9ENDQ4MzRvZTk1TXUyZk1V?=
 =?utf-8?Q?TV0z+VzjVx0W/ZLvxXy2BE+P2cvHxicp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 12:59:45.0835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c361fc36-6c4e-4ea0-256f-08dcaca9a83f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238


Petr Machata <petrm@nvidia.com> writes:

> Eric Dumazet <edumazet@google.com> writes:
>
>> On Wed, Jul 24, 2024 at 12:09=E2=80=AFPM Petr Machata <petrm@nvidia.com>=
 wrote:
>>>
>>>
>>> Eric Dumazet <edumazet@google.com> writes:
>>>
>>> > On Tue, Jul 23, 2024 at 7:41=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
>>> >>
>>> >> On Tue, Jul 23, 2024 at 7:26=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
>>> >> >
>>> >> > On Tue, Jul 23, 2024 at 6:50=E2=80=AFPM Eric Dumazet <edumazet@goo=
gle.com> wrote:
>>> >> > >
>>> >> > > On Tue, Jul 23, 2024 at 6:05=E2=80=AFPM Petr Machata <petrm@nvid=
ia.com> wrote:
>>> >> > > >
>>> >> > > > struct nexthop_grp contains two reserved fields that are not i=
nitialized by
>>> >> > > > nla_put_nh_group(), and carry garbage. This can be observed e.=
g. with
>>> >> > > > strace (edited for clarity):
>>> >> > > >
>>> >> > > >     # ip nexthop add id 1 dev lo
>>> >> > > >     # ip nexthop add id 101 group 1
>>> >> > > >     # strace -e recvmsg ip nexthop get id 101
>>> >> > > >     ...
>>> >> > > >     recvmsg(... [{nla_len=3D12, nla_type=3DNHA_GROUP},
>>> >> > > >                  [{id=3D1, weight=3D0, resvd1=3D0x69, resvd2=
=3D0x67}]] ...) =3D 52
>>> >> > > >
>>> >> > > > The fields are reserved and therefore not currently used. But =
as they are, they
>>> >> > > > leak kernel memory, and the fact they are not just zero compli=
cates repurposing
>>> >> > > > of the fields for new ends. Initialize the full structure.
>>> >> > > >
>>> >> > > > Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
>>> >> > > > Signed-off-by: Petr Machata <petrm@nvidia.com>
>>> >> > > > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>>> >> > >
>>> >> > > Interesting... not sure why syzbot did not catch this one.
>>>
>>> Could it? I'm not sure of the exact syzcaller capabilities, but there
>>> are no warnings, no splats etc. It just returns values.
>>
>> Yes, KMSAN can detect such things (uninit-value)
>
> But that would involve a splat. There's no splat with this issue, even
> though I'm testing on a CONFIG_HAVE_ARCH_KMSAN kernel.

OK, Ido tells me this is just the "it's available on this arch" option
and the actual option apparently needs clang. So disregard what I said.

