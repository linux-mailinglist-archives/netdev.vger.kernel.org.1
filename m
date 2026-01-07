Return-Path: <netdev+bounces-247587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32971CFC188
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 06:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E78E3302C4D4
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 05:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47047265CC2;
	Wed,  7 Jan 2026 05:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p4246PBc"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012061.outbound.protection.outlook.com [52.103.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7715C235358;
	Wed,  7 Jan 2026 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767764136; cv=fail; b=R8f7qCXlAD6FznUH+xt3E/R/dcukRrpBvZPx3D5OG/Wp/ZQJwt5PAWQA9qSPZp3OaCGXVaWXzSqkZTLGo5SaNqPtjSLI3wK1IY7ObS9jKX7kV/qgtnxH5kvxVDTdX5c6dq/jT+IcEkM0Bb9AEJSnAzQ+hSmGJeYe6BoafsbTea8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767764136; c=relaxed/simple;
	bh=8Tt+osK5c4cHon1UldHWQgjPwnGZTZ8ZCxqy+wtaBAE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KLmD0zh9/q6UUbff3T4o3x6E4/Fpy1N+hwrMeH3DJFojgZhOP8aqikaRN4emyvPbxmxL1oePK8/5kmOr/MOdiFgkq6DYtf+ZNUsmGZ0261Bl1Ja/t46Z8gFeDtAxyzo1HlhCTnph1xMmKXc/CigMMVquCfjqBv5h6yCWV+a5jW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p4246PBc; arc=fail smtp.client-ip=52.103.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/4If5P5V7jnMsa6zHyAYAfVGX4Xy/WIhkHUiZw2cl7KtvX4Q8jWyWtxbSckKuuZPP+OWYc1ty3YJ761Eqs+YxdRzAmIjAvXm9ZG65mUEzJKR3ZPDD0jCEVwetW1fcAr/uvZsxY5jQeB1a10LHk8IAgCbVgwuERdJUeJp6Ohwl4I29FbpYcXsC4SxrDbT9gRnY6UIJ1hzX8bavEZSjVe4qScyfrx8bHimbgxLeMTqu8+WfJRh/tE6VNWK+rpLAqvIO3yLjTi3Q0zHkuuPIAPcujrTJf6g3Jk1i+VtaguEn1iJmHUvG2DzDYHuQ/LsdL4XwLH5CiUdpKX+yZpmQfeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Tt+osK5c4cHon1UldHWQgjPwnGZTZ8ZCxqy+wtaBAE=;
 b=hVVmqEySyyR58lQnsc6BVjI0SfZ4TqlFRG3MuhDcJZCps5dXsAj4I2A8sT61puFiFUeIv6GyPUmHJP3/0GHvB7SrpiewPQgCEEl+cfcbYJb0cejXO9savLAuqG5iFZf/cCL/fNqjolWpqPRfNS52rmBVcdN2VRufD9uTsAZM2+V0PcPOZR7Hwh8/L1vF0Rr0i8TkRIdxM/Wp7aPj6Ew5SS02Fkjr/U+H9EgUfBRoRnOWL33ygkMs/q0zRydrpgd2f33sAAED9x0Tl5gAyf9rDMiEWrzF6CVYMi1UuotrdyySTIS4ZZ6xGpsXZJbrST8+9aWWb6rbRposeQ6dtPgz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Tt+osK5c4cHon1UldHWQgjPwnGZTZ8ZCxqy+wtaBAE=;
 b=p4246PBcTJrmPIoSUpN7nyXcTA+BMEueOH/gKGP8ebC+ATsoXe3s2geuniOkBdrMTSeUG/aelyye8mA/oTZMwf/xZ1Re3LZlJcAiJDY7PkqVweTYmOkZA+WzXcqQnRGhSToBsFgHdVoTbpzAG0QyQ0mNS3QV+Sl4lZwIqwdFKEK6U/PzgES8UKo1J4pKRp9yPcCfMgzvtJAXO8eNL6qyskPPmjkTLrpu/t9KJVLiej8yRcsPFigxR86UcX2EJDR8b40pnz0vuTFOHirihKBU6RNJvWOwdE6uTVkw38YcdLsiA7KJsnnrFJJ8n0YXcS6ikILXjdDA7GgpK/o59IolOg==
Received: from KL1PR03MB8800.apcprd03.prod.outlook.com (2603:1096:820:142::5)
 by TY1PPF6FE718230.apcprd03.prod.outlook.com (2603:1096:408::a5c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 05:35:29 +0000
Received: from KL1PR03MB8800.apcprd03.prod.outlook.com
 ([fe80::95dd:dd8:3bbf:2c16]) by KL1PR03MB8800.apcprd03.prod.outlook.com
 ([fe80::95dd:dd8:3bbf:2c16%6]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 05:35:29 +0000
From: "WangzXD0325@outlook.com" <WangzXD0325@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Subject: [BUG] qrtr: refcount saturation in qrtr_bind() leads to
 panic_on_warn
Thread-Topic: Subject: [BUG] qrtr: refcount saturation in qrtr_bind() leads to
 panic_on_warn
Thread-Index: AQHcf5dGRtJAnwS/FkmWHXzuMb+zMw==
Date: Wed, 7 Jan 2026 05:35:29 +0000
Message-ID:
 <KL1PR03MB88003FA66C7BFA4BD7F392D7A184A@KL1PR03MB8800.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB8800:EE_|TY1PPF6FE718230:EE_
x-ms-office365-filtering-correlation-id: 577ecc60-b714-4c22-f3ae-08de4dae919f
x-ms-exchange-slblob-mailprops:
 xgbIMsDSu2YQP4YTVSfAdmvv3RzbJgGlfZmV6n35G/YHarE1AzHI75IMCKhItFdcyOxcNw6zd1snwwP6FuB/lSfn0i/5jq+xGMFQeMkgu6gIO0051psVBAaK7BJ5LvNrg1FKDuD9QRbiHOmH5Q6OYnQfSRn+dUXbZk2jMwxP2CloVb/2GTDXtfr1G8cd7YA3LOtn/BsQYZu/G92fBk7Hpm2M90EwSaMK81Ig+OzG8qYixmcxjFwDYOlNS4D2n47gAS2ulpo4OQnZHlKvtn99JYl+98aoQEOBJ1eTTyM6+8fh45S9G3d7M/kx61FuzM6MKbjQP+6S4UC2mv6ZQzaJHJ9hhyyfDLPn35TgwrjE39tpaIAlD/45BFOdO0ZvXgJVCBkpRMyNOEtn69266xzHead0U7vWa20UQWCPfKy1Po0AgO13T0S7rCJ5fdjZCoEjccdv72s/gep/WL634zEwuGsLWBzLlFC4xECHRB4eb74XBGnL2ywph4wyYAcAdshga7UybdYESrteDjGr4lALCUwPnJWSg3HZhn/SFRasKOHl1k8WUo7ulIVR7Hk29+K7OFrJwVPOo+jZ7/QkkWXbZQoh6KJ1ak+OJYvC0BTHokeC27zPFhE5Yhd3RwREdoRc6gTPHqNo4SgxVfrFMslqpIV//zmhRzWH1B8wbiqaphdGSwoh0LOE9YKtFEBc10Uan5ZepXwWLJSwdAsBRw0pjwebvo2gf37Rx4MJALuMKkGu+BlxaJRwM/WCJt9TqHzwP9AxNPcopwigEI7TMY8ACmAR9i9dz3oW
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|19110799012|15080799012|39105399006|8062599012|8060799015|15030799006|461199028|440099028|40105399003|3412199025|102099032|3430499032|26104999006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?HIvScMu7JXv//A135bGiUWnRsfZjXKlnIUTnP0A78Ippa7eENbhUxBc5LA?=
 =?iso-8859-1?Q?bKly8k35hfYeYTfDxKNU6mPL4bIh96gJ7CE7bbE+/JHzITJ6JyZI/dVjRp?=
 =?iso-8859-1?Q?etn2BsBZ/pLVuOBMT6qmgGJpypagJrWnjwxQUXm58pv3KRyeMhqar758Y2?=
 =?iso-8859-1?Q?QA2xVHHmTWRv/sqnWk9nZYv9+9OcoQsRGq8P0DTcXEjejca1OJNB1Eyu+1?=
 =?iso-8859-1?Q?l7N3PtmjVuhWQxV+EgIKVlVfYb0cgs0Kf1o3JngAgX7gpklVTDs1uqiH/v?=
 =?iso-8859-1?Q?nNnQ5o6aHW+C5dJV44ZbKaV9AFfQ/vHIPi6kBPAGqItQn2SkeDFlJzh/Qb?=
 =?iso-8859-1?Q?PxDYtylyTTS2qBKjvlEBzEOh2Q1pekdqNsGz3BH1F3bO+T0AN79oP/EdsR?=
 =?iso-8859-1?Q?IHJgijSFQORvYmvJzNSAWU4NvH+rEqRNtclSoViC3GQ/Q2owGsbxmwxBbK?=
 =?iso-8859-1?Q?Nhasb1gceLQOgi7Mq6e9aE9E66fvvj6Tm3qH3jgHw04XV8cYjUA768dBC1?=
 =?iso-8859-1?Q?X4Qg23VITtHdUaHXhVZh4O5WTS4RfftIGqKRBsf4CVjAtL/Y/9gQi12UR4?=
 =?iso-8859-1?Q?RB1ffY5o00YxSO4MEHGVfkuCZeduCMbIENxNE+gRm1ejc8zLMtfgiRJqpm?=
 =?iso-8859-1?Q?XkOXTQTmTVC5lO1cm678kbi+Vftx0qzVqwktFC7k2KMx4kORc7ZTgAX6il?=
 =?iso-8859-1?Q?48vqP2uXslVgYk5+EI0Xy1oFcPiBaVskzLxn0w72raGpYxgnXoc4WwaHiC?=
 =?iso-8859-1?Q?fd8DD2BONi2yPCW+W/50mfe9zZoCwZ3XQkcesviuVfO6Y+vA886P8U1Iy9?=
 =?iso-8859-1?Q?A79i5dKoOMUejkfZGhSYKCMH6cM8+141yQ2mpLZpNV94fx079rpSs/lMDv?=
 =?iso-8859-1?Q?Hz7cw5RLFod+h0Dj5CBAfJtflJrEEu2F90XuwGHfRfSfeRecgfhs7BYnXl?=
 =?iso-8859-1?Q?/XkV3EmDO+Q2bg8Cd1M+zUPSQ1bsvgVmv8VUCFTeQS2v+9UTDhi+P5LngC?=
 =?iso-8859-1?Q?2eFx8jbTWolAUbbbN+jtib4ThGKz/Go8Q0thQYyXJTG9CGvAXze+n6Qs48?=
 =?iso-8859-1?Q?xxRlSteSmt/o1Y+n4wnVsqjSa/TjsVolEToH+IAf6GhVnJMVlXtrNah66C?=
 =?iso-8859-1?Q?xdSl6R2ZGKVvDaTsvs/mSvdRcoCBKZqhn9wT+l8gsSJQDipk8cO8N327Cj?=
 =?iso-8859-1?Q?/5CXmcYD+O3ECYi4QPjn0/EITr3Twf56bqjEC1ITTuf2i1JyveqKpKWreH?=
 =?iso-8859-1?Q?5bOTGHpT87u9ggM6UgMQCuPG9/OYhoUZog/SvIQ8s=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Gzct0ZsRz+LK2xHz2LkKa4YiYRBGKI7E79yPxC6X16sVhllp9dgd+tyeMw?=
 =?iso-8859-1?Q?nN5KtmCaP1PhtFl7I+sc/V2hFYSJoUDnGuayz3hjNv9lmZ97ZyyYGb3G64?=
 =?iso-8859-1?Q?zkeciYVLT9WNhKPiCUD0Rrdbwkh5Bdbqzb9SNE5+GCNVrbJ1ZTXAp14w5d?=
 =?iso-8859-1?Q?1HUVkLvtqdB7j0GkFPR1gujmLuOOqDWGSy9HdaNA0Gtyzrga8Ik14f4oil?=
 =?iso-8859-1?Q?X7ZxpB4oFHTgl0UpJ6XhwrIChG6b7aH2QjL5nOaFgVm6Q4rm36uubFtVV8?=
 =?iso-8859-1?Q?CqzKvCgMdqLCQnVv9aF8IRvP8wgEEeuP7jBJpsFQYpLGVPe3IKFkJbtE7l?=
 =?iso-8859-1?Q?wAJ+7tA9s9bs79kh0Pl3JV6MWXnddsDNTCd8XyUl9D7mZ9sF1lvDzyT8qi?=
 =?iso-8859-1?Q?l4nQ+SawjmCzkiTkqCVoIE8tcrSWchc1UH+HwAHWKgrsBP9Gyd6ZWM6BPe?=
 =?iso-8859-1?Q?mEeaC+nmI0cuYRTa9qrG3VGV/l2Jh35AR17dh3EVv+rQBkZEHZUZOgxAV6?=
 =?iso-8859-1?Q?8AhDCoRWyG3iOo5aSxSi22IXjgDhVFWV3VtTZS5u/RRmHP778nCSGq2HuX?=
 =?iso-8859-1?Q?CH4MDdnGGLiE+EZ1SGhhq49pQTWvdun3NMY8/LrUQERczNvGB5SnEw6fho?=
 =?iso-8859-1?Q?+FPgWIf+jfsGZHKcz1ivFpNCsm9ztvdh7BhV+ftd0B5gloBTyuF+R18RUZ?=
 =?iso-8859-1?Q?J03Eb5tqix+HsURcZbLCD2ZjBDjfHfBuJugpcrKexDJ4kbY2/hrijr0gq1?=
 =?iso-8859-1?Q?T4KiQJGwtomEjaDb152TnhVja10n227Rleotjite1SWVEEs3KWLSsFlZJp?=
 =?iso-8859-1?Q?jv2TFrUE1/lGXpcgXCpJ3OVhKY+VDpvNkqmWGs51Im2VZLY9tNGKzACCWu?=
 =?iso-8859-1?Q?atxE561b7TL0OJ+YF1VuPNtMGoH90iyC6gMfNEXefUUR0QEVYf/JkKQ5qA?=
 =?iso-8859-1?Q?LecvyBzx7pHxYykKPeGg39cb6u3jGHa6pwo/zp4mCF7hcmPoihWn82wnyh?=
 =?iso-8859-1?Q?xXTkOktCGugI8waJ9mzEdoPNE0W3J6f1O3dR+hbuEls0tXNgHE++HTFQpk?=
 =?iso-8859-1?Q?uRssxAts/lgwBlPY8Uo54++Sxp7xKvOFcWMKFJtnac5Exc9LAbh7uyNQah?=
 =?iso-8859-1?Q?w9HtIoGCAR6lDw06KH4Sfr3229rNnL2KN2m4sX5YNzhRRt42If6ZXUTB5L?=
 =?iso-8859-1?Q?ZTUoahu0cPfmnGlWleQZxSu3tV19j8uKW1JPGYCcLdHO/tChJzRpQVHx75?=
 =?iso-8859-1?Q?IxYh12XFQUw5d+V5f6xMglyOeRNXae8CV4AX5IR29iqkvd4r8dOhKDxZOa?=
 =?iso-8859-1?Q?Iekie6aia1RcweH7btXj/YihfIvnN+Txf9QAiZx9xX6uFn5bPGcDdUzrtG?=
 =?iso-8859-1?Q?SYBziCbSvagdu9XRJU+aDCx0Muvpad3uyuZWAVNEb+WbNz6fOb5nHk/KQ4?=
 =?iso-8859-1?Q?Kq1zC9C6wHB4BiMr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB8800.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 577ecc60-b714-4c22-f3ae-08de4dae919f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 05:35:29.5754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF6FE718230

Hello,=0A=
=0A=
I am reporting a refcount-related WARN_ON() triggered in the QRTR=0A=
(AF_QIPCRTR) subsystem, which leads to a kernel panic when=0A=
panic_on_warn is enabled. The issue was observed during syzkaller-style=0A=
fuzz testing.=0A=
=0A=
=3D=3D=3D Summary =3D=3D=3D=0A=
The kernel triggers a refcount saturation warning:=0A=
=0A=
=A0 refcount_t: saturated; leaking memory.=0A=
=0A=
at:=0A=
=A0 lib/refcount.c:22=0A=
=A0 refcount_warn_saturate()=0A=
=0A=
The warning is triggered during initialization of the QRTR protocol=0A=
family. With panic_on_warn enabled, this results in a kernel panic.=0A=
=0A=
=3D=3D=3D Environment =3D=3D=3D=0A=
Kernel: 6.18.0 (locally built)=0A=
Config: PREEMPT(none), panic_on_warn=3D1=0A=
Arch: x86_64=0A=
Hardware: QEMU Standard PC (i440FX + PIIX)=0A=
Workload: syzkaller (syz-executor)=0A=
Modules: qrtr (loaded via modprobe)=0A=
=0A=
=3D=3D=3D Triggering context =3D=3D=3D=0A=
The warning is triggered during module initialization of the QRTR=0A=
protocol, in process context while loading the qrtr module:=0A=
=0A=
=A0 modprobe=0A=
=A0 do_init_module=0A=
=A0 load_module=0A=
=A0 do_one_initcall=0A=
=A0 qrtr_proto_init=0A=
=A0 qrtr_ns_init=0A=
=A0 kernel_bind=0A=
=A0 qrtr_bind=0A=
=A0 __qrtr_bind=0A=
=0A=
=3D=3D=3D Warning details =3D=3D=3D=0A=
The kernel reports:=0A=
=0A=
=A0 WARNING: refcount_t: saturated; leaking memory.=0A=
=A0 WARNING: CPU: 0 PID: 556 at lib/refcount.c:22=0A=
=A0 =A0 =A0 =A0 =A0 =A0refcount_warn_saturate+0x94/0x170=0A=
=0A=
RIP points directly at refcount_warn_saturate():=0A=
=0A=
=A0 RIP: refcount_warn_saturate+0x94/0x170=0A=
=0A=
The warning is followed by a kernel panic due to panic_on_warn=3D1.=0A=
=0A=
=3D=3D=3D Call trace =3D=3D=3D=0A=
=A0 refcount_warn_saturate=0A=
=A0 __refcount_add=0A=
=A0 __refcount_inc=0A=
=A0 refcount_inc=0A=
=A0 sock_hold=0A=
=A0 qrtr_port_assign=0A=
=A0 __qrtr_bind=0A=
=A0 qrtr_bind=0A=
=A0 kernel_bind=0A=
=A0 qrtr_ns_init=0A=
=A0 qrtr_proto_init=0A=
=A0 do_one_initcall=0A=
=A0 do_init_module=0A=
=A0 load_module=0A=
=A0 __x64_sys_finit_module=0A=
=0A=
=3D=3D=3D Observations =3D=3D=3D=0A=
The refcount saturation occurs in sock_hold() while assigning a QRTR=0A=
port during bind, suggesting that the socket refcount may already be=0A=
in an invalid or saturated state.=0A=
=0A=
This indicates a possible refcount imbalance in the QRTR socket=0A=
lifecycle, such as:=0A=
- refcount_inc() being called on an already-saturated refcount,=0A=
- missing refcount_dec() on an error or teardown path, or=0A=
- repeated binding or namespace initialization without proper cleanup.=0A=
=0A=
The issue is reliably detected by syzkaller, although no minimized=0A=
standalone reproducer is currently available.=0A=
=0A=
=3D=3D=3D Reproducer =3D=3D=3D=0A=
No standalone reproducer is available.=0A=
The issue was observed during syzkaller-style fuzzing.=0A=
=0A=
=3D=3D=3D Expected behavior =3D=3D=3D=0A=
Initializing or binding QRTR sockets should not trigger refcount=0A=
saturation warnings, even under malformed or adversarial userspace=0A=
inputs.=0A=
=0A=
=3D=3D=3D Actual behavior =3D=3D=3D=0A=
A refcount saturation WARN_ON() is triggered in refcount_warn_saturate(),=
=0A=
and the kernel panics when panic_on_warn is enabled.=0A=
=0A=
=3D=3D=3D Notes =3D=3D=3D=0A=
Additional logs, full kernel configuration, or syzkaller artifacts=0A=
can be provided if needed.=0A=
=0A=
Reported-by:=0A=
Zhi Wang=

