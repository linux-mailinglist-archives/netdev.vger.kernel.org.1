Return-Path: <netdev+bounces-115254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF1A9459E3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2CB1C22E47
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1B81C2311;
	Fri,  2 Aug 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O3b206Gn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CA1CAB3
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587281; cv=fail; b=byMTW3YdjTDBf6TyBp9jEcvcxR+q2s3wQLwmOw7AFAdeYca05JmN1xuRcJBhgebMtEwjpGB5MAc+KfFVA/GJXo6do9cDl2MgS95fGymcvkXKkuTAUnOEqycJrIwVgH65kgI3YqQvuOf/OoCJt4o8f55WSb0n+iI0vRo3bjBnhdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587281; c=relaxed/simple;
	bh=IJo74oJrSDFRfD6iL7untB8iMwMt+9qw5HCwiwcKxUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kPGj3TOl+wr3TjKJWSlRBMIBs+0tOG5tU9NCf4UyUTs8lILc14UY7/YeYwwmPoZf3hiaTj8p9KtziDTw2FogXzGNrkcKhWoaMzFud0HQIQCwmfcht6mm7enag0MenXv+OJW1qCav7S0wy3FGo4qA4Ku7O3SbIMkQgrnC3m2DO6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O3b206Gn; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAFxqarog9icrCTMsmd21gmeT/tgxQXECOujv/CIqgNoS3dMpplcmAZ/P/HbA51cIP7KlHq0jYGYpGNFckeafz6jAYcr8dEioNlwVZIQnpbLOAAZWObfOtL6rafx8WdF0MI1YyASmZdcgcWeuy3dc4uaIofsW95+S3LTxY572WJ+e0O/SLR80wpjGbZS6MGygWB0fJTSEq7RJEpiUm7wZ0SF9rwXrG1njS5YiC36rPFQCo87G0Nl9S+85b/dJkjEvA/HXO10Ml27YAXOx+mbAtFqpn9zIt4R2UcFVE9wQoUHsJ0368YCJUWA8jrCxriTEiJT2USsxl/y+6vRF8SVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJo74oJrSDFRfD6iL7untB8iMwMt+9qw5HCwiwcKxUk=;
 b=san0ZxOg2YqFV6EX+L1FGGN71bDoUzcrs+KJ8h0BVnxclIAeiOimVBzJlG41jJPYkSZM6A4y9zXK0BZLOli1iIaR+UOygDARcxJou2gomcep9VlOtpuW5NE4cXiugiPHst2NgE/9eRi6jc/hCC7Glm8hVqPEJj5iepCQmQ+LsniXkDiFehd/IcRuW4XNu+ZsYFiPf0dCqMJ2tANCNnRN7dsTkdxYvRlB+4mnKbSQow1LX7s43rrDaoWw8ATGA6sRSvE6210EY9M0D/IYV+b5XTTmIA+i9iGyu5RD07Hmo+syRISfMuPi0wRDEWADTnoqvdb2V4bB3kQxlLBcOlRHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJo74oJrSDFRfD6iL7untB8iMwMt+9qw5HCwiwcKxUk=;
 b=O3b206Gn6M2ZxJrK0WztjJ8rm29k/IrKyo7ZhV9Fd/ET57/wgwGM+dbXSmcoLb9H965NFCqMa1YibcvMBaJUxY+oGRWDoDeYKSz4gfvTvTKvmawpZvTX7bFbJsEHOB26w12pDlxrho7sZeNmfqUV18OuxDyKpHj0KCn9uHok1IhI5LNa84NETapHEcu73S66AmjeUPcsoEdGEpAXOpZUwASZvQ5d3hU4wrcdoQ9DsdPfh/01yZciJsTFlhdbLpUd0SawGj1Q7fkhN9vV87siK9l+hPLF7DMOtp0A8y7dlh3WhSjIojveay8JdMidU6O6GBr06r92UkIKp3sTAXA5kA==
Received: from IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 08:27:56 +0000
Received: from IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d]) by IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d%4]) with mapi id 15.20.7828.016; Fri, 2 Aug 2024
 08:27:56 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"andy@greyhouse.net" <andy@greyhouse.net>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Leon Romanovsky <leonro@nvidia.com>, Gal Pressman <gal@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>
Subject: Re: [PATCH net V2 3/3] bonding: change ipsec_lock from spin lock to
 mutex
Thread-Topic: [PATCH net V2 3/3] bonding: change ipsec_lock from spin lock to
 mutex
Thread-Index: AQHa4/hXkPuNgbMCskKA39ozsMFZabISMl6AgAFxcIA=
Date: Fri, 2 Aug 2024 08:27:56 +0000
Message-ID: <3a26acab9bf5b010679debe366c9da36b42a567a.camel@nvidia.com>
References: <20240801094914.1928768-1-tariqt@nvidia.com>
	 <20240801094914.1928768-4-tariqt@nvidia.com>
	 <f150dec8-7187-417a-a700-4ea7ce44f721@redhat.com>
In-Reply-To: <f150dec8-7187-417a-a700-4ea7ce44f721@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8554:EE_|LV3PR12MB9185:EE_
x-ms-office365-filtering-correlation-id: 1b5ee0b4-58fd-41ac-57be-08dcb2cd02e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?akFvOEpFWTlFNGs4SERCcldYckZFWjAzYXU1NVFmZ2V4cDh2VGVJNlU2MnFE?=
 =?utf-8?B?YTAxK1pZdmlNRkNGZTU2bWJLcmltZ25OVVB0MERXRkxNcnBGckJyWGNpL25m?=
 =?utf-8?B?OHZnUng3eFJFNEVveVRjSmZWRmJoemFQSzlYZzlWVTAwcWt4SmE2bXh3OUta?=
 =?utf-8?B?ZnNQRzNkbDE4M3JVbEtzYzBtVHJwNGM5MUtlL21lVmJ4QmNTZHFtQW9BdTEv?=
 =?utf-8?B?ZGdyNWU4OEgzZEhNV3M3NlNXRUtOcHE5ZzVjcENSVUVVOXJTZ1FoNXVqRHFm?=
 =?utf-8?B?cFJibmw0S2NCMmw3R2tsTDRpaEg0WVJYcVAxMndEMmlEVEJnWFJsYTZvTWRH?=
 =?utf-8?B?cFFpNDJrK2Z1R1JhYlNVeDMxSUlKcVF3eHRCc1MrYUVSTmhlMFFLMndTVHZu?=
 =?utf-8?B?Y21velZvNjB1K0t6SnRqNjZNTXhVT3htbVBEZEdPVzFESm91UUN3YzhUNXE1?=
 =?utf-8?B?Tkd0WUN3cGZrdXV5V0Q3TjVNeWp6bGNBa2JxM2pjZlBiR3NTVGxtazJoVG5K?=
 =?utf-8?B?NmNGTGg4VmpNTkJyRnpjTCttRzc2a0x1N25uTVppRFUzdjlsNWk3UnFnVFhu?=
 =?utf-8?B?dE1zVHNNYktTZjZPNUY1ckVOWDlnUkJQNEZRL0FCeWw5d3ZQc0piVHRqNkdS?=
 =?utf-8?B?L1N4Q3FlR1NJZUFwb01GN3VKaDRDeGUyb3hPY2NZZHFkcUEwcDZwcVd6OXpW?=
 =?utf-8?B?bWpMeXVJQXlVNXhsdVM3UFVzVmg2QWMwZ1Q2YmdyUTY1bVRUNnN2Ni9TZFd1?=
 =?utf-8?B?MW1GdGViZWVXU0ZmS1A3Rlc0NXlwcTB5SE42OUNRbFdBY2hncVBJR2k4UkJ3?=
 =?utf-8?B?Qzg5RnZyOGlNNElhQ0lZRlJ0UEVZdFZVQUN5dEk3TVU2NlBQd01NazlkRkxr?=
 =?utf-8?B?WWI3TlByMHdyMTlUWHRLUHJlV042UlFvQU9HSkJMQU9odWZWcFJVV1BFOThC?=
 =?utf-8?B?Z0R5Z00wdGZKa0lTUkxPYmR0L3JjQmRsb2dVMVV5NFA3c3lTNkRkZStCSkpK?=
 =?utf-8?B?aVBPUnhyczU1dlFRckNnWUluVFUxTXBLSGx3cVd1TEdmRC8yaEkxUDQwK3Rj?=
 =?utf-8?B?cU1NbGUwOEtURTRSU2IvTllvRE5rdmxGSTEvSXFYQW1YM1p3UHVYUHZ0Y2Qr?=
 =?utf-8?B?SVNyUG14LzZwcnlMd2U0ZUVoZy9UZmswcEY1ZThEQnVhVXNydmp3VkJVcSs2?=
 =?utf-8?B?ZFRoZk5ndk9qWFpoVUVyc0ZaMmhmUWdLRzFkUEkyNU5MSGxGOXdXd0VSTnZH?=
 =?utf-8?B?SHJaTjRsb2dDb2lZSVYveDlJbCtFakVXUXphT2dxSjY2NE0yVVIvMmlMSE9l?=
 =?utf-8?B?Zk43UmQvUXFDUTlLN0U3L3gvbE1PdCtmMzNnVFdKM3IyTjd0RXNqNkNDNFlw?=
 =?utf-8?B?bGE3Rm1YZXBpODNVWUdmSm1JNDEwRTBvSytpZGpJeFhRakU3Qmh1RlB6cjl1?=
 =?utf-8?B?d3FKM1RWa3NuZW00ODB1VUlISXA3ZEhxWTdHQnR1K3FLVjV5ZUpITmpDQVFm?=
 =?utf-8?B?UWRHSGpsM0FlbjE4blpFTlFiMGJ1a2tlWUI1WG1lYXl5S25sZWo3dG15VGdk?=
 =?utf-8?B?YUJoRnBmcnVOU2dNZGhmZzcyWEIwTXpnY3Q1cTZWaUtFNnZVbmdRc2hveVRP?=
 =?utf-8?B?ZERZYk9qYnNHM1ZVbjFKV3VnbFhhOUxybXlubjk0M0JqUVphWldKaFkvZExM?=
 =?utf-8?B?dnU4UDNBWmV6TjlEbDF2MUJTU0tSajRRdjgrNitkS3pqV1J2R0Roam41eE05?=
 =?utf-8?B?ODR5eFFmYk5heDlpQUZvT1dvMllsanFnbEhaUGRjSHFSbVNocFNGNXN6SlRH?=
 =?utf-8?B?R0F0STNFeTZwd2lNUGM3RnRMa2FvUlAyR2tDWlBmM1hhZTFJck92RU1qSHAw?=
 =?utf-8?B?WVNURXlHYUtSQkI0bWdBOEs5clJtQWhvcmxTcVJXcms2Y2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8554.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmRSZ245dzZCMjYyL0phN0dib08vR2IvdnRMOVIwb0RWNE04N1UvcmlqV2NO?=
 =?utf-8?B?Si9DOUVjTWdaeFJ0T2g4ditxQkswWjBkYUZxalE4NGJtdTYzU2RRd0lVT1du?=
 =?utf-8?B?ZGN3dHFHYzU2ZHRPUDJUWnJQQzVVWjBFcE5TeTFydjc4TGt2aFE0UWxsMUF2?=
 =?utf-8?B?NkFDc0QwVTgwY2dOYUpLdTg0Zm1mZUNEd0Z6YzVNalorVko2RGMvRHR2dGJS?=
 =?utf-8?B?OWczTk5wcFUxVkVlZk1MSmRONXJFY2pvZnB6U1YrbGY1d29kR2E4Vy9QeXZZ?=
 =?utf-8?B?bTBkdG5DTnZyN1VvbEZ6QkVPcUhJQ2QxV01iRUhoQXRvWnlHOTdtaTUwQklU?=
 =?utf-8?B?b1FwTjY1anZHeEppS1VhQUZ3blhKa1RtbVhxLzFHeEc5ek5NRHJiQitzdlVq?=
 =?utf-8?B?TllmeWFqN3dLOStudGVUbzBxcE91Znk3TUpCNUR5cTZFVHI0d3RhZUVzMHQ5?=
 =?utf-8?B?cmpJVjZCVjN1MEM4TUxsVjdMM0VUMWJMaEhMVk9iV0lQM21pSTZSbXBtejJr?=
 =?utf-8?B?ZTlpMmdMbmoyOHJDZ0VvM05tdGZUc2JLSk1oL3lHSjJIcDlSNHlHOFlkZE80?=
 =?utf-8?B?Qld2ZG4yN2dPenFCNXlqQ0JGU3VsN21RaTJoa1djaTArRTFtalA1a2NZRThN?=
 =?utf-8?B?MlExbHZIdzgrdTBiM1UyYmJZOEdxeFpzckd0MnhmMndONjZYMEdqRURrcTB5?=
 =?utf-8?B?clBpNHVxK2h2b1c0RWNYa3FTZWNBNUowL3FYb0JTR1J4U3gvNkMvVG1BVlh6?=
 =?utf-8?B?OHZNVzdiZ09YMFNRNFM1Vys5UzQzZEZwbXkwTkhLbDdyOUdNRFF6Ym5sK01P?=
 =?utf-8?B?RTQyKzZDVTdyWk55czU4L2FWVmJxMGRDbFRxbzJqMFFCVDZTZk85a3Q3NzVV?=
 =?utf-8?B?V3pyMGJMbTFxTVR2VTRabFFiQXhGVE50a2ZSdzllUnNKNG0rMFJTSHdheGF4?=
 =?utf-8?B?MEdWYURXMkNOWnJCalhSelowWmNpaFYxQUxtcEMyQlhPdHA2SDRYalQ5MkJw?=
 =?utf-8?B?U1lYb2FJNVpiWXNOdkR6RVQxVk9jSGlNZDlsVW8yMnFFdVBKaUUwL3FhN0s0?=
 =?utf-8?B?SEZ4bWl1Q2NRU2hkNXN1ZjhIS2xwT0c3SGRndFVLaERaYytkOFRFK0U2MW9C?=
 =?utf-8?B?NmFGbERuYnVqcmhBeUhvZmxxN2plSnowcXdaZUxRRjNzQXpuTzJwcENrcTRD?=
 =?utf-8?B?aFd3NCs3dVhKSDg0R1QrNVJoVjIyZ0Q3eTVoWFcvOXYzcGZiN2VlOEkzeS85?=
 =?utf-8?B?aXZyU1VpTWFiUjZ2eTh4MDEvdnFXK0UxQm04dTBWdEZKVXMzLy9DNGErQXht?=
 =?utf-8?B?S2hLL3p3QUs3eFA1STh3aGVKcEhDaVF0aGt3bnI1Z1ZScE83Q2ZkS3l1T2RD?=
 =?utf-8?B?QjB1S202Sk9NSm0ydWFENzArclAwdFNkUHN0cUIrWmtKaTJPWm5pTWFOVUxp?=
 =?utf-8?B?Y2wvczJ6QVVEWG1NSk4zRjE2b3F3ZUtwUWEwT2ZBMnlLaFYxR1NFbFZ3R1pO?=
 =?utf-8?B?cjRrSWhLWSszcTR6YllIVkluMEgyWDgyZTF5Z0xqbjBvaUdWbVNBOXczNGsz?=
 =?utf-8?B?RlFDeEI2RFdUbCt3LzFRYUd4MGp2OGlZeFk0RVdQazdCNUUxRnFENHg2K2gr?=
 =?utf-8?B?am54Kzc2Vm9QS0VFc0YzL1Y4S0I1djNYZGZnWlY5SXNNN2RHL3Z5QUpMMkQ4?=
 =?utf-8?B?Y0lzMWZheVlLRFMrc0Y5OExsbUJTK0RzTVFnNWk5dlhvWWF1MkpFOWFDcXl0?=
 =?utf-8?B?ejlwUHJBMWJtU0VDT09MbXZRNjFaTHBDTk5aSzRHVmkxd0VqUnZhalI4NjFG?=
 =?utf-8?B?c3laY1FoUzFlQlV5cnp6U0NZR0hqVVZjeVdwU3dWdXJ4OGN0UlpCQ2laWGJ5?=
 =?utf-8?B?dWF2SjRRemt2TUNVUHd0ZzR1azdtcDZGOFlxNXV3dXBuQzBjalhIQmZKM3Rs?=
 =?utf-8?B?Z25QUHlOMHpGUU5nZ25HdmRPNkRCWnJxMm40N3pqTEEzSXcxNVdQenFnZXg4?=
 =?utf-8?B?d01LbE1QZXlwYXkxZHdIMEtJaTlFVGtsN2ZJVU1mYmNzRmZGVVAzczQzRXZB?=
 =?utf-8?B?aytxVTRoL2Q1N0VzcDU5aHpDVnBIMnRtdFlLRStGeERpUVVCdTk1M05ZL3hp?=
 =?utf-8?B?SUlGTEYvbGxia1IrL2ZoVDhWNDcrbkd6eTJ5bk8yWVBiSWRydGJNYTJtdm81?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DAA14A1FF254A428DFBB355C1857014@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5ee0b4-58fd-41ac-57be-08dcb2cd02e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 08:27:56.6419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2TkQIwXGiCI4iCrLKuUttyuJXqoKEDeYr6npotPN4PSA+4JEtZPJTbIo7IVQ9fNelD/issj5pf2co0QAI9XGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185

T24gVGh1LCAyMDI0LTA4LTAxIGF0IDEyOjI1ICswMjAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCj4g
T24gOC8xLzI0IDExOjQ5LCBUYXJpcSBUb3VrYW4gd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2JvbmRpbmcv
Ym9uZF9tYWluLmMNCj4gPiBpbmRleCBlNjUxNGVmN2FkODkuLjBmOGQxYjI5ZGM3ZiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvYm9uZGluZy9ib25kX21haW4uYw0KPiA+IEBAIC00MzYsNDEgKzQzNiwzNCBAQCBz
dGF0aWMgaW50IGJvbmRfaXBzZWNfYWRkX3NhKHN0cnVjdA0KPiA+IHhmcm1fc3RhdGUgKnhzLA0K
PiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIWJvbmRfZGV2KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7DQo+ID4gwqAgDQo+ID4gLcKgwqDCoMKgwqDC
oMKgcmN1X3JlYWRfbG9jaygpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBib25kID0gbmV0ZGV2X3By
aXYoYm9uZF9kZXYpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBzbGF2ZSA9IHJjdV9kZXJlZmVyZW5j
ZShib25kLT5jdXJyX2FjdGl2ZV9zbGF2ZSk7DQo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKCFzbGF2
ZSkgew0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByY3VfcmVhZF91bmxvY2so
KTsNCj4gDQo+IEknbSBzb3JyeSwgSSBwcm9iYWJseSB3YXMgbm90IGNsZWFyIHdpdGggbXkgcXVl
c3Rpb24gb24gdGhlIHByZXZpb3VzIA0KPiByZXZpc2lvbi4NCj4gDQo+IEkgYXNrZWQgaWYgdGhp
cyBjb2RlIGlzIHVuZGVyIFJUTkwgbG9jayBhbHJlYWR5LCBpZiBzbyB3ZSBjb3VsZA0KPiByZXBs
YWNlIA0KPiByY3VfZGVyZWZlcmVuY2Ugd2l0aCBydG5sX2RlcmVmZXJlbmNlKCkgYW5kIGRyb3Ag
dGhlIHJjdSBsb2NrLg0KPiANCj4gWW91IHN0YXRlZCB0aGlzIGJsb2NrIGlzIG5vdCB1bmRlciB0
aGUgUlROTCBsb2NrLCBzbyB3ZSBzdGlsbCBuZWVkDQo+IHRoZSANCj4gcmN1IGxvY2sgYXJvdW5k
IHJjdV9kZXJlZmVyZW5jZSgpLg0KPiANCj4gU2FtZSB0aGluZyBpbiBib25kX2lwc2VjX2RlbF9z
YSgpLg0KDQpTdXJlLCBJIHdpbGwgYWRkIGJhY2suIFRoYW5rcyENCg0KPiANCj4gUGxlYXNlIGhh
dmUgYSBydW4gd2l0aCBDT05GSUdfUFJPVkVfUkNVLCBpdCBzaG91bGQgc3BsYXQgb24gc3VjaCAN
Cj4gZGVyZWZlcmVuY2UuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBQYW9sbw0KPiANCg0K

