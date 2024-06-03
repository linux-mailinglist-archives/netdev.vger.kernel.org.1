Return-Path: <netdev+bounces-100156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F32948D7F76
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4174AB245D4
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC9F3FBA7;
	Mon,  3 Jun 2024 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W3tlswbm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5472282C6B;
	Mon,  3 Jun 2024 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408319; cv=fail; b=DU2ElvlA7d20uuwn8w3oxHNB3tHW1+uM73eh4pBTbk1d8hZPhDn3vvH7GNXJZVm5ogJx2Pjru/fq6uTnXCbRMCvGQGMnC4Bg8pyiK2YZ/zx5wRtJoUY06Z3yzDXHcKuGhMO97W5PkgPwxgkTy3Mu0nBqyFUDrthiVGpbyknNAWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408319; c=relaxed/simple;
	bh=ZS24zFDqNxXF7yMkBDG4Vp25RL5tkoks6o6x9NYGTyM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cFDyUnWAL7EaSXqMr5ja0TohM4s04lxCCp2r2HVKyNL3EjAtTAD8IUWVUhtuR3ThUXTm8fdaJqxhs9e5G2t6EZZmojpp1HnksqazUuD+mjmMNgCS2pVI44jyvYWW8JFqP2yZUPwDVxWZiTGvMJ/2hsGS2AEhS2vlyYp9T9VhEFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W3tlswbm; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeGJZMkeILmu3xDxn9IwTtN32OX5CFj5iWxf+jNtl9YdqlPpdv1YjuabeA66tIrWbuB1c0KKds/MmCrnsL0DbEdWArNENeEeNcQ4p/q5cEwN7ynlmt5+pI57KzjWquMASiZVcsbxc//+KpNbXkDU029X/Kgx+l91N0r/BxCapKVaSpSGXOSTWP3s4pYkuMAnCw8KLbrMW32nh1vW9xTht7sCR9uvyH/mvO0qiqQxr4OUaqVOrdicVTPwSj6+fTYw4aqmo6Xk9f60HPSCC6yO691EnMqG1YFQ23lVP6S2mqyc6ZAuJmpuw2WnkbFK1gnI0FVfVNrA3dH+D9LzdQ1hcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEOtnCfSkmOcUi1ppa7J8y4ALl/Y8XkdVGPnQCbTe2Y=;
 b=kshWeRJskXGeYv5QYbwKQ1rhqe76HfVYLuJAt9aj0yVRSeytY2IkE3czfdkj6LaG11CaF1aQckCNyUW8+HXf4uQlLw4YXEDyXiagrwqZntLp3EfDkYvuTGacVZpALdohORAQO/3zpYYSesHmLLMEGDR67k1SDaIcpe4Bp73Ngh5JS78f0REBVxvtnLkGrUePcSRQZbOPsN6cJl01X8IZiNXixoEuZA1xa2u1UAiK/4SELwWlFFLZp3GgiABNQniPQOE2MgAEVto3GUSbGZyQcYb3npXzy4cnhfTO56rprWp/oQTuxO8vt5w1wHeuAsHoI64H5/1T6UQwDuDX+RRBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEOtnCfSkmOcUi1ppa7J8y4ALl/Y8XkdVGPnQCbTe2Y=;
 b=W3tlswbmjJwqpNxsMtnQiFzyUXK+lvZTH3ojyTxpz26oaPgX4vue88GQNoAh+dw3aCIX2NWs3dReeNWGJX76BICHZQfcPbnbTjizMvgeXHa+rnIiaXq/IqQkiihqL1XVuoC4LIh8zCup+eZONgYrLPlNG6p6AEcPJ6uif1K1OmQbJ3fCo90cyFKP1accreKfvAD42ekHcvSaAzOYpwdOp4X4euAGnVECHpD/bMNEEjCpfQg0utp7yj51m33FIA1whMDYa8wtvmu9DZFQHguGXEvMOldrx535a0H1uUtIRwiLTKPltY2KnIz0yQ7qt5nFWRtJkV8brO2atxe0Kf5hfA==
Received: from MN2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:208:1b4::37)
 by PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 09:51:54 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::71) by MN2PR15CA0024.outlook.office365.com
 (2603:10b6:208:1b4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Mon, 3 Jun 2024 09:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 09:51:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 02:51:42 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 02:51:37 -0700
References: <20240529111844.13330-1-petrm@nvidia.com>
 <20240529111844.13330-3-petrm@nvidia.com>
 <CANn89iL8P68pHvCKy242Z6ggWsceK4_TWMr7OakS3guRok=_gw@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath
 hash seed
Date: Mon, 3 Jun 2024 11:50:50 +0200
In-Reply-To: <CANn89iL8P68pHvCKy242Z6ggWsceK4_TWMr7OakS3guRok=_gw@mail.gmail.com>
Message-ID: <87wmn68icf.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: da52f9c7-4f8a-4444-a518-08dc83b2ccac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1ZZTVFoT1gyUC9lWUFtYVkyTFcxTWcrbG9iVkhOcWhqOHFpL3Mrc3JHcEFR?=
 =?utf-8?B?M2lIQnZqN3JOaW82UFdva05MdGh3OXRWd0xzL0V6ZGp6aWp4bWU5ZzNXK0NV?=
 =?utf-8?B?QzBpN1FWTis0RW5qcS9DRmc4bFBWM1ZmdlJqOVpjQmRXaFFONmhHYXlHMDVr?=
 =?utf-8?B?enZObXNsSmNuckw3SmtrOVdqOC9xVVpZU1dubmMwVUpOMGRlZ0oybWVxTVA3?=
 =?utf-8?B?ZXdRNGprVGlpNlV5K2svR1BlczRlOWxQb1Jxb1VSRk8rNkhRdGI2YVd4eGlw?=
 =?utf-8?B?K0Jua25jTXp2QUxlczdTdTFLNmNKcU1ZQzZjYWp2eVI2YytYZnUwUWwrZmhq?=
 =?utf-8?B?UVYzbjR6aUkxK3NsTjY2ejZiYkJCTHJ0LzVYVElMek9sTGdQZFhUa0U1cElz?=
 =?utf-8?B?RDdKR1JQa3lOZTNsK0ZHYk1aNiszNmRoT1Q5UFhaMmN2UG14dmpCSjlxNThy?=
 =?utf-8?B?SWp0Rkh5SXRuUmw1alkrbldQbzJWbWtnZW5nbEY4ZjkrS1JjcVBkZzBEdVFM?=
 =?utf-8?B?eEJHemh6a0ZIVngxZlgxMWpNVmV6dGlleDBIMkJyV1ZlZ3Ywd1A3bXJMRU4v?=
 =?utf-8?B?THdYd255cDd3ZllMMDc4SkhDb0pBNDA1UzVzVXN5VTVNblQ2YUR3WkpGNGlH?=
 =?utf-8?B?VHlCRVc4T2NMa1lJMFRiVVJHSHRFMzBkOWRaQllyTHNCbjY5NTZ6MitsUHlr?=
 =?utf-8?B?cUh6ZUh4b0VTNEtSOWVDa2ljWEsrd1lrUEpIeDNaQUxacENqUjMrL3hvS2tx?=
 =?utf-8?B?ZDhkaWp3WnZtaHp1R0dKeEMwMXBtOWJxTVdRUVNGaHN6QXpmdnExMCtWTEtH?=
 =?utf-8?B?elFYY3dDWFZiMlZrK3VveFV4VTVLQTNKVEMwMEJML2x1TXFDaUVlZzl2UzlV?=
 =?utf-8?B?L0VKUUxLL1hTS1JjeUYxcjdGb2s5cFRvWFFFbXExejVsYU1sOGIwUytZb0lD?=
 =?utf-8?B?MXN1NjYyMGJkTVU1S0QraUxtWlNWZHdSR1NmRlJqZ1RSb1Q2OFhmY29qTHQ2?=
 =?utf-8?B?aHpIaThwWU55aEo2T1RhUXVSU1FDMy9DZUpHU2RGTTNXZFFoYUZpKzNMeFZV?=
 =?utf-8?B?ZkkwOENzQnNJZFJodU83MTFhSS92QllHRnFBMER5SWQrMEE1amkrYUF0TU5S?=
 =?utf-8?B?dno4YWJTcHMvZGJDay8ySFluQnNrS1ZhaWE3WmNuZENCdXA3WnhKTDdPdTJG?=
 =?utf-8?B?cXpKcWhKSjVGWGVYdzBQblcwZG5sSDBQVzBlSjBsaHZiNCtUM3o5QnpJUEFs?=
 =?utf-8?B?VmJJdk16NXRvMVVrWFdGeWhKTGQ4c1R3NTVjSXpyOXFrZVIrZTdsSkZpY3Yw?=
 =?utf-8?B?U1ptbW02MzFmTC9WaFRlNzNsMWdDSkRTVUVSQU55b2VSV3MrcFk1dDQ5R1dS?=
 =?utf-8?B?SUtaQW1lYkVFdVY4RmZ5ZTc0M0pwckxucmdSek1iSFVkUDZ4NkpiQXBqMmRu?=
 =?utf-8?B?NG9ZdlhKQmpBZ2dHVUZBSkhvYlNib3F6Q3ZYKzJJYjJkalVQbzJ6bEQvTG9y?=
 =?utf-8?B?V3VtR0UzaWh0MXFwd3lmOThGTlU5bVI4eWZHVFNtcE42YTJMaHl4UzdHUmIy?=
 =?utf-8?B?YXhqd2NEd1RhUXJLelc5RXRaUm1CMTlLdHRDQnlEQ1BTRjJ5bThZVzU3UHZt?=
 =?utf-8?B?VHZRYnZYbW50OFVLdDdwU2hHcjdmMi9JWmNtaEVKbCtON1pIZkJyaGZPWndw?=
 =?utf-8?B?VDdBZ1VXc1VFWjBJVS9nVVNYQWlKeERETlo5d0VJZHRnRkpYdzRuT2FONStU?=
 =?utf-8?B?MnBMclR3NWhZeU9YTEtrL2FMVXd1ZHZCNmVpeGMreTlEbks0ekJHaFRTOVVv?=
 =?utf-8?Q?vahnScXktbtcFtL73RHOL8c0PEPKocbNpXl0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 09:51:53.9020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da52f9c7-4f8a-4444-a518-08dc83b2ccac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302


Eric Dumazet <edumazet@google.com> writes:

> On Wed, May 29, 2024 at 1:21=E2=80=AFPM Petr Machata <petrm@nvidia.com> w=
rote:
>>
>> When calculating hashes for the purpose of multipath forwarding, both IP=
v4
>> and IPv6 code currently fall back on flow_hash_from_keys(). That uses a
>> randomly-generated seed. That's a fine choice by default, but unfortunat=
ely
>> some deployments may need a tighter control over the seed used.
>>
>> In this patch, make the seed configurable by adding a new sysctl key,
>> net.ipv4.fib_multipath_hash_seed to control the seed. This seed is used
>> specifically for multipath forwarding and not for the other concerns that
>> flow_hash_from_keys() is used for, such as queue selection. Expose the k=
nob
>> as sysctl because other such settings, such as headers to hash, are also
>> handled that way. Like those, the multipath hash seed is a per-netns
>> variable.
>>
>> Despite being placed in the net.ipv4 namespace, the multipath seed sysctl
>> is used for both IPv4 and IPv6, similarly to e.g. a number of TCP
>> variables.
>>
> ...
>
>> +       rtnl_lock();
>> +       old =3D rcu_replace_pointer_rtnl(net->ipv4.sysctl_fib_multipath_=
hash_seed,
>> +                                      mphs);
>> +       rtnl_unlock();
>> +
>
> In case you keep RCU for the next version, please do not use rtnl_lock() =
here.

Thanks. It looks like it's going to be inline and key constructed at the
point of use, so no RCU.

