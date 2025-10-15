Return-Path: <netdev+bounces-229655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEC7BDF798
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFE419C3945
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C2B30505F;
	Wed, 15 Oct 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="F7gO05Ah"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010068.outbound.protection.outlook.com [52.101.228.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E27830C363
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543336; cv=fail; b=MXps+HF25//CqQ1Zk5+tyjx/NYzCrIJIuYw0tUFU0V2opzbFBH8d35qiMHEq1vvJMsfF1eYKAwUFESmSDapDMzyRvBF96noEoI8WPws0Y2sExhQcwggrre25KKvOXWYS3AOTX46v61oIX3+iGTy6kKbRPqZc4vjrW7bHJaJSKfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543336; c=relaxed/simple;
	bh=WdStRmlm3eeA/wz2sfwA0dfmYCgU9G4FoIBBHwQ4TNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NOzSWtnX5n9HJJMvf+fvHsEx3zilwGiDKRLlnGGfeqiB/9KvtF0sTs9ltaptT7jXeTy9geqQeMEOUN4bcE9+6JbgT0QAg1dJuRhYPI+8umzyXOEYR0hYvWeCY3Fzp3XdyjrklSYvWVL14crO0UvuISJSiHCKY4/gVFpiZ8qle/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=F7gO05Ah; arc=fail smtp.client-ip=52.101.228.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQsyp8OY1teuZNFx4jwsshkQOtSUTeaFqoMrpevM1e1mcpNAzgjNXqmuNRx3SQdJ58c5JIYUg+RXZQ9AJh7suzbeNMlpjiaCrA1AlzlR0lm4JUSYZ1YFMUDJT4thEUkffgZvuT2CcuMY0u75no0i3UjuLSAChV5jA/Fm5P02kW6Qi1So2w5Hgp/l/CEYoYvNkRxQjkSo6f58wpqVI6SToiFD1YJZBaqyik4jWgUmLI/YWBKCEDd7TT2SBPjVkvRwS2dDhausOX9ClDMRFduJQHa8/lIZsupxPw/Bxm8WLlNJ02YOQHEJyB6Em7mix8BQjilLqwmZjZNKBq9OMaMpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdStRmlm3eeA/wz2sfwA0dfmYCgU9G4FoIBBHwQ4TNY=;
 b=nGhEUv40Ty2Sj2WOcS54oVpKVIji5+cC0WcgrQH9lseMJFV88BRNm/yg2KujPKFMAONLce3zI7VrWh8P3Oiz0GADhBplhRtJojnv3gabEk48A1Y14LWiN1h1R3c/lGABi4//d07aDRWRT1gVnmR0QjQ46//OEiWyENCOdMi+0UAseY7r2nwN7H2d2avsW6/Bt0V6n4iL8FcuFfkxN8scIZ8hf2YtJt4v2DAjXCo6tUO95uFqHkn57KvVvjLFX9/6c5wx8qARMmM+mDHcqXwnNyhGkrnAmy1qgOn2Mkg8ODqNpvtMiVJV+8B24AaZFXIC3xvNp7RKVmRzkuubTUD0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdStRmlm3eeA/wz2sfwA0dfmYCgU9G4FoIBBHwQ4TNY=;
 b=F7gO05Ah2B3+Ktcue5PgAmZCMqNY8ppOvlYwTDwpmy/zwVyfdWmnAIbVEmCPOnhGSPA5oD7BP8msryXj/bM7qgMpT+ZGZfOOYxvW3Dty2OdsE9iEvss9oubQARKZezPdT8wwRpqe3nASEiwMXMwa0LFegbCdHK+nL36phXbMyUg=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TYYPR01MB7950.jpnprd01.prod.outlook.com (2603:1096:400:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 15:48:46 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 15:48:46 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: Query about the impact of using CONFIG_PREEMPT_RT on locking
 mechanisms within networking drivers
Thread-Topic: Query about the impact of using CONFIG_PREEMPT_RT on locking
 mechanisms within networking drivers
Thread-Index: Adw9xY/b5NfpgJ5gTyajqPRxZdkzngAH/RmAAAAZ2qA=
Date: Wed, 15 Oct 2025 15:48:46 +0000
Message-ID:
 <TYCPR01MB120933E9C8A96EE9CF617CF1BC2E8A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References:
 <TYCPR01MB12093B8476E1B9EC33CBA4953C2E8A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <20251015110809.324e980e@gandalf.local.home>
In-Reply-To: <20251015110809.324e980e@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TYYPR01MB7950:EE_
x-ms-office365-filtering-correlation-id: 229467ba-bfcb-4e40-c182-08de0c0253c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ESGSMA5AA/kNJnxDsJumxP3NtiiKBSS8vfkCY6zKjoqAEeSO2DBHEHRynE+8?=
 =?us-ascii?Q?ujHzVyEASFnu4EYkTjzecY7rbPfnNWIn4FhJRB8MAa/A0/gEOI0E2bop8bJm?=
 =?us-ascii?Q?E1aWmR4POPrZqNTDiqtCfl45SCzRWpMcbYcfTpOTiyGACskKb+eZZuqJXEZt?=
 =?us-ascii?Q?6gLUwT7DiHPY3EuohsQ1QT/3Vo7JqBSoqIv/Ipa0BXFCYdRUnKcxl96hq+Pl?=
 =?us-ascii?Q?67OIXVmBRxYhaaftvzy2NumbsCgyIhvwnG8TBuZLa2tuMJRs/j2H/SoXHff4?=
 =?us-ascii?Q?BLx4W+CNOvQVPFn9QmIfN84Hj14ougvK0WMirLYxSkjBoyz/Cl3s07vRSiui?=
 =?us-ascii?Q?NTdu+SzhCq11j2cfaepyIiX/7MCeXIkb7bj6lGbwMzkHJayXRhPUAdLhwoBi?=
 =?us-ascii?Q?I2x3aRX8f2fUnSGGvQCGBEE0mb4YOW68noMTB2f7++QIDwF/AnNI7hCDSv44?=
 =?us-ascii?Q?d/ySzSFiTUiXHCfdVBjChthvMtlq5bft2l3UVUwauYVZy39lKNaXpf9DU30S?=
 =?us-ascii?Q?Q0lHqwMQRBen5/iBKszefZTF2+ugLzBL19DnskvdkAd1VJIukl11DvN+uftq?=
 =?us-ascii?Q?z8QM4bx346LrKqltXGuC5a0g1RbETzI7CEGIKeiyTykCd3w3oC4vnpOxihp9?=
 =?us-ascii?Q?t0NZw46RFuX8E68Gjd7AvtaaJKnNgjxlQp0MvOJWE9akqdP8E0ueOR1R3pha?=
 =?us-ascii?Q?Rz0YWabPsb6A7vu6umdmgBzn9kfpepPeAyhKcnGWIg5ixQBGkvlvmKID297V?=
 =?us-ascii?Q?eu6XThT5CgRFAgp3biEOCbPIye1t0i/puRt+7pNQEj4F24AAAXxNUjSgPulZ?=
 =?us-ascii?Q?SLnmsqzWBaDh3YdHInYJ8JPXecrRjmaabLr0+2FcYrkVErDcKzRXGmJ8kiw1?=
 =?us-ascii?Q?DLT+COMwboWaVzYsfG/otIVRumE1ZySejvlbU2w1+4RaFCjQblUqFZ2zzzBq?=
 =?us-ascii?Q?IYlz9G1CifnWeTejTjqpjjEa4K18NEm4KXwut9EA/C7WlkrkKkx4fNPZ/WBZ?=
 =?us-ascii?Q?09yjX3Wg93pwbTQDQ/LTP2uP24fHpi6/9YGFM6lhx0rEN1528+2jgb5xL2IM?=
 =?us-ascii?Q?xAZKTSX1xUyOalWPsfHA/erXofjFyU29u+cteJlnzqpmNFbGLZJyZGpzGyqA?=
 =?us-ascii?Q?EVqGGEU1SPrteWsWVG+wnwGPsC7RXgFUnJ/JNyEaYelDuMF5SfbwC8DurafY?=
 =?us-ascii?Q?i+7jyKdAwHkTM0kF8ryJM6fHVv8/zZU15EdHxQaCATl7o/dpDp2/0C82ZcGh?=
 =?us-ascii?Q?UU2LY53sEoXvvGyENWDrhZkF7mlGCzk0CeEg5pCp5wc+6/eD1XoVDceto49i?=
 =?us-ascii?Q?OYDXafRjw8PuVeGESUjTzm6BJ3n5xbDJm+O5wwQitrebee51acErISkahsxR?=
 =?us-ascii?Q?WwTNuiEgHTrIzA5+PHxBDUz0jOVQIlVFWWr2WdvkP5wGF17eHfXZa27Whbwu?=
 =?us-ascii?Q?PnJJAxup1O8gmedK4pAKHKuphzg2S5SqzRDGKgGC/haNg2QziAlVMg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?e+y1j7OMTvJE6rF9MRlaSL4ggGHefirR0zxIZxVr0wRBvJRFPHRYyeuZ9zvQ?=
 =?us-ascii?Q?+kQMlGiRG5rKBOkbMrE0baU2GsmA5v3TfvChkAPg/x+YLDfWEiCnsHchy9tt?=
 =?us-ascii?Q?xWiVaYrlBFXlaNyKqm41HK3l1YNhZRWb6YGqsnezJIPNYKqKGPP0N8JUBIMz?=
 =?us-ascii?Q?syLj80TLJF+mG5RTUA7K4e8jPFr39id5RDm6fXo+Bz86Pm7lX/cM17JIYJPj?=
 =?us-ascii?Q?Hfd+EB+HGg/dJc1w69j5K9sHx6Dl2vZ7lhlNfzdWL01vVTw3vWO6qlmmulgd?=
 =?us-ascii?Q?bpQ4NSZYjW9z/b69m8q7d7Iz+JeVB0AHe6QJ6ECk8SrlfGYb9vzStpVn0zHj?=
 =?us-ascii?Q?wnCkVbR7cctKojf/XaeAVYOntn3kEoKtAi+9dMYjDf6nhlWgEWZYPuInylXx?=
 =?us-ascii?Q?eUvX01V1vs/w6XliKeoN9SLVeOlYapeuTSVjjM7ny9PmmOAO74SVnwwEy+kB?=
 =?us-ascii?Q?ftyLUiVO9tiPvlm+l2PuQmzOoRfoMpHMg4iKm8Rm+7ZjKC6kxRBOusWtUGNd?=
 =?us-ascii?Q?ELzxRlcRyu0ys389vkuM0GBySfYH+W45Fq6faYmRCISLjqSapVcHfnhN/grS?=
 =?us-ascii?Q?vBfvxKeoyOOCtJa2+MgQe1+Gs0k782KXtEoOaAGTkB5Vmzbddewc6JytpFbe?=
 =?us-ascii?Q?bz/tkYRFcEdawqif4e+vMB/QYUUoWHdNxRQbv1RoVxPzLWDoq8IO80sF6car?=
 =?us-ascii?Q?QDqFqE3QVlBP2s1sslfhhzvaTCkgxnGbYx/s4t00zV7kkJao0ht7azj3yYrt?=
 =?us-ascii?Q?EoGVNdXDNjuAH0hP9ZMIkZqk9IIhXbNtdDBEH67p+A1CLDqcCaFIWBSWz+B3?=
 =?us-ascii?Q?o9f51gwSD/aMLI8YpTaFRTzQ1xHldcRicErDX+m7yWoUtjfRu1p96h5R7ggu?=
 =?us-ascii?Q?5Y/uvCDwCyZq2e8d0OUacgkYzNmj/dOlcYaO0D0mkHWCkBJZKQEdoaJpdSvw?=
 =?us-ascii?Q?yGjAEA5AK3caUNuKpkH7B1fDP0KNwV9fq2YpPw6yxFyFHsFMgp6vma0jt4pR?=
 =?us-ascii?Q?ui5wB6ZUsHwmX8Xf/YN/yWJehGiT88e2ejvdVRfwU7nVDU+sD8bxWP2XH2lV?=
 =?us-ascii?Q?g1/9Qyrd8sKQKoMqTloew4bJQuQc7yIOlH85ukCCKS8ubxVUOZHh9zAnAyns?=
 =?us-ascii?Q?jNLQXoPzLzzQjcRR1SxMRTj0QEvoBnqBEUKgEujZ9KWlqCh3gqEUn2wWRWn3?=
 =?us-ascii?Q?GTnR/kipMaDDspAcMtSU2XdQipHAJdbYuQ5Nw2p5PDUDO5ItIH7AOXCQLWx3?=
 =?us-ascii?Q?wwRdxmXEz4YOi68rcpzYzVaF1iBmeFxnL7tU/Qo+9cXJzeI/VNUGyK1qykNx?=
 =?us-ascii?Q?aBqJS+Lw2vFBkudZPctZYn0k3+ie4hCu0Lu5vbqMUu/VPwnKJ1zqsYxH7P9p?=
 =?us-ascii?Q?bR7QqCslB2kxeMwHooO3kHOhm5/KtKZiaIR2i1Eoo/l2zVeN21Lu75/M1d5x?=
 =?us-ascii?Q?aQDfVoEDjD12dqfW81H0NcjFdcdWxLIvgUtB3XbXtDq2PBfBVImiOCfiq/Wc?=
 =?us-ascii?Q?P6oXDTSD966C+iY95lXaMp8K6bd6XAiLwsRyc7WNYPjBdTWp+KkjVlhWBWDK?=
 =?us-ascii?Q?j6dwa3layGkLXJIgFF7CW6okK2RQ4yfcXOAyy0FbAwr/RMvJQKfJHy/kcQta?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229467ba-bfcb-4e40-c182-08de0c0253c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 15:48:46.7476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvAgmrp9W1Jk2MuTGjDyhLPLDQXddxCBklHFIOyphI6Br7WogdMJmhKPmwKRi4gOJp70bu7HKqy/dGnPASPQOVIJdXgDJncaMf9CLoXOxDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7950

Hi Steve,

Thanks for your reply! Very much appreciated.

> From: Steven Rostedt <rostedt@goodmis.org>
> Sent: 15 October 2025 16:08
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@red=
hat.com; andrew@lunn.ch;
> bigeasy@linutronix.de; clrkwllms@kernel.org; netdev@vger.kernel.org; linu=
x-rt-devel@lists.linux.dev
> Subject: Re: Query about the impact of using CONFIG_PREEMPT_RT on locking=
 mechanisms within networking
> drivers
>=20
> On Wed, 15 Oct 2025 11:24:35 +0000
> Fabrizio Castro <fabrizio.castro.jz@renesas.com> wrote:
>=20
> > Dear All,
> >
> > We have recently started debugging some issues that only show up
> > with the kernel built with CONFIG_PREEMPT_RT=3Dy, and we have noticed
> > some differences w.r.t. the non-RT version.
> >
> > One of the major differences that we have noticed is that spin locks
> > basically become rtmutexes with the RT kernel, whereas they are mapped
> > to raw spin locks in non-RT kernels.
> >
> > When is using raw spin locks directly in networking drivers considered
> > acceptable (if ever)?
> >
> > Thank you for taking the time for reading this email, comments welcome.
>=20
> The reason for the spin locks conversion to mutexes is simply to allow fo=
r
> more preemption. A raw spin lock can not be preempted. If a lock is held
> for more than a microsecond, you can consider it too long. There's a few

That actually gives us a good way of gauging when holding a lock is not
appropriate. Thanks for this.

> places that may hold locks longer (like the scheduler) but there's no
> choice.
>=20
> To allow spin locks to become mutexes, interrupts are also converted into
> threads (including softirqs). There are also "local locks" that are used
> for places that need to protect per-cpu data that is usually protected by
> preempt_disable().
>=20
> What issues are you having? It's likely that it can be tweaked so that yo=
u
> do not have issues with PREEMPT_RT.

The first issue (which is the one that sparked this discussion) has been
addressed by a patch that was sent out today.
While the issue addressed by that patch is not related in any way to lockin=
g,
it sparked a series of discussions within my team about locking because whe=
n
PREEMPT_RT is used there are cases where the driver gets preempted at
inconvenient times (while holding a spin lock, that gets translated to an
rtmutex with PREEMPT_RT), and the issue itself is fully masked when using
raw spin locks (and that's because the code doesn't get preempted, making
the issue a lot less likely to show up).

The above picked our curiosity, and therefore we had a look at what's
under `drivers/net` and there doesn't seem to be much code using raw spin
locks directly, hence the question. =20

Here is a link to the patch I was mentioning (although not relevant to
locking):
https://lore.kernel.org/netdev/20251015150026.117587-4-prabhakar.mahadev-la=
d.rj@bp.renesas.com/T/#u

Another issue we have seen is around CPU stalling on a couple of drivers
when PREEMPT_RT is enabled:
https://lore.kernel.org/all/CA+V-a8tWytDVmsk-PK23e4gChXH0pMDR9cKc_xEO4WXpNt=
r3eA@mail.gmail.com/

The above is more luckily related to locking issues, even though we didn't
have the time to dive into it just yet, so we are not 100% sure about what'=
s
happening just yet.

Again, thanks a lot for your answer.

Kind regards,
Fab

>=20
> -- Steve


