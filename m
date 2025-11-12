Return-Path: <netdev+bounces-237877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10119C510A3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C5B189CDA3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081322749C7;
	Wed, 12 Nov 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QzGHo+OD"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013003.outbound.protection.outlook.com [52.101.83.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2830C1E492A
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934575; cv=fail; b=SGDs+5VzPqfXak145EZUsenMuxs6a5V53kU3sNSEsYaUFeJK5XapsbddJUGZUZIBDzUzff6c9kOfZZCu/OnjA/6SrSZxlqlMEx8OxMjVmmagzhHfGMbbBooLELH/roKOPwIF+Hp5oInyn7v9+O0lzP3IZoz/DJNujJAtqFSmL4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934575; c=relaxed/simple;
	bh=KRZEwrqyV2RvTtNzWqqb1KrJ/Z5a/zR3+vO7pZB/lR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HaXpMCM1YK/JKn00lkroVet1pxPO59mboEQ2yXHEainxnJ+ueFpzc4/aPJ7SNK8kpa6fRb7Acikek3Wju4KYkfrWpaqzIsoykJsFq1/G9HF/oQymfDqJtRe2vH7VlZuydeBk5XVwwGnaVsN9f712tps0TlprSlxkYyb9emi2zQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QzGHo+OD; arc=fail smtp.client-ip=52.101.83.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCrD2cAC/4B9jeE7IBgrqfA1CvyhGywYn0D1IPmvfwOz7rxQ38AsEFUlhzs6SiuOur6iTrbzavRgPFdid9PISIOhnu0/E313/JI3oqPWWP5X32Ib/LFQgTRepbpXew0FmLpofGmOweBsr1gwEp4T31HLnMaou/G/ScGZT8RS6ptsdRxe++oU4uPk7WeiXqKjr3vnw57Cspv8sfW86HjGUZ8xTyzoIudr1Cdpt99qLjj2sreIwRhj5rNpJrW7Asd9yvm9Mrt6WWGBRNUQs8xiwz4remjN+FFTD3QCcy98Cb2oWQKmstX7FmaJP/nhGIEEj2Y4T29cen0qwtjk/a8ghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRZEwrqyV2RvTtNzWqqb1KrJ/Z5a/zR3+vO7pZB/lR4=;
 b=WDivhY7IpaHD8jP0UGG9Ztoa9e/RJjjRSoPZsxdL8Fd6CdWLHYKQNSJDelexSet5lftniysKiapQ+B2iYYEqpU5P9plfbDDKbKqFEBLj/uk4woyesC+iwAVBpcHus+LSdhJSYXxuLXBTOw3Q851tvNEB7Vr1kWQpsEoocba6Pl4AxqFRF8eqoJjfPGiw6WiIfkdzdh9QYil0lQ0vnDDsF7sRMGRz24dwulmZFxqejKtCsCl1ztUVJer9ASmBJVpBhaxamWXmVDtSyGSQLklASO8mO79WWJm34LTnDVZbXtWmo3O6rDwD6fhxStw+ktXlBDjbY6A2HAM4UAam9DUE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRZEwrqyV2RvTtNzWqqb1KrJ/Z5a/zR3+vO7pZB/lR4=;
 b=QzGHo+ODvA0xnREzQblWP3vX9aQjuCqVlqqHxYRlkYXxXhH6HIf4cWvdR1ZWrhsrgsRs9tjXZLDd1aqrVbMbF+LNs104dosjLgoU4gTQaMlpnP03rv/ELoO7IUf2H9D7kenhLgUKgbMtF9K7AtbUhofJzsK10hN0xSS9j80LYHPfqlTabdEQo6Aj3rtGhcnrF5e9S6mWSwze2+e0S4HEAXQ8yDx/stf2AcHEGdaLEXRLtukD81F13d7/JuyBJEPbpbU0z9U1Oku8e/Y5CrAKurtMmrjTVjQerWtI0SUwOZ7e5rkvmr06YPTCpSr6lGHdVo3wJkUJFhHX/RzzGNeg5w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV2PR10MB6408.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 08:02:14 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 08:02:14 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "kuniyu@google.com" <kuniyu@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuni1840@gmail.com" <kuni1840@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: Re: [PATCH v3 net-next 07/15] ipv6: mcast: Don't hold RTNL for
 IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
Thread-Topic: [PATCH v3 net-next 07/15] ipv6: mcast: Don't hold RTNL for
 IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
Thread-Index: AQHcUwjvNtUtpW9H/EGDOjs11xos4LTuW5OAgABTqYA=
Date: Wed, 12 Nov 2025 08:02:14 +0000
Message-ID: <daa3c21fe3580fc1905734143e47ac3323ee90a4.camel@siemens.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
	 <20250702230210.3115355-8-kuni1840@gmail.com>
	 <94edb069a793c63a455ef129658f2832460f104f.camel@siemens.com>
	 <CAAVpQUDxNL7uQWmJLyy3FLJoTa53N3zam2CqxZc-5CGkVhxVbg@mail.gmail.com>
In-Reply-To:
 <CAAVpQUDxNL7uQWmJLyy3FLJoTa53N3zam2CqxZc-5CGkVhxVbg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV2PR10MB6408:EE_
x-ms-office365-filtering-correlation-id: b4a12da2-26de-40dd-d1f6-08de21c1cac3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTNvZkVHdUVZY3FnSFRJenMyaTJvZXV4a0NiQWkvNkpuQkdJL0RKZGV4WE9n?=
 =?utf-8?B?ckMyMS9hT2xINWlVekU3Tk82YURzOHM5OWpIQmU4WmNMSFFuMjZxcnJYTzkx?=
 =?utf-8?B?VStuNUV0Zi9tZHVBTlJVOUxKQkZ2SEhKM3FxcjZ5VlVaTXhaUENSWHVSMEtx?=
 =?utf-8?B?S1creWtxWElXTW96RTRieHlQMS8wbE1jTXF6dGhQQTZST0d0a3Y5Z3ovWEpT?=
 =?utf-8?B?N0EzSDdLOGNWL040RlNpN2xDenBTbkhHZTYwMGw5dXlyNUtMM1pGM0NCS1g4?=
 =?utf-8?B?WHVXNGpIdHlHSCtUb2ZNd0gzWWQvby9FemFYaGYyZVNNbmtJWHZqYjdNRFMy?=
 =?utf-8?B?UnR0NXI0L09GZmtDaExoSlJ5dFBib293dytDZVB2ZEY1SUxnSHJ0ckVDZjRy?=
 =?utf-8?B?cDR5UHZwV2Fnbit4TVdqaEk2aFBtcjlaeFBObkc4Y1Q5dElqODR3dC9ZNnRT?=
 =?utf-8?B?UTRYWmRVTFYxZmNURUpDbWZHTDNJaWtVWHEwNjk5MGRReDV4b3liT2dYWWl6?=
 =?utf-8?B?OEpqSWZ2a0J2UG1RVkVhVk5DV2RrU1Y4dE15OXFsNXcrbDc3UXg0NWVGLzdM?=
 =?utf-8?B?d1dqRzhiOEJNbkIyNVFsclI3bzhVWkFrUEVtdDhDRVAvU3BUbU41dDkrL2pJ?=
 =?utf-8?B?V3dJaGU5U0h3Uk5uaFBzcEp4MWI4b0hRbTVRY2Y0dDlPaHBRc1VhU1BNdEEr?=
 =?utf-8?B?c2V2bWllK2N3U0R5R1BRd2tEMDlsd0RnekVXSkhkajV0VzVCRzlzVG5EMGJF?=
 =?utf-8?B?RVFaNGR3VDJYemUyMElGSTlvNHI5QXhkS0ZPZ1RrRjhmTCtMd1hoTW9xS1Fj?=
 =?utf-8?B?Uitza2F4WWxDODNZT29VR1JJeER4VytwcGNONWQ2LzhNeEtYNjBLMWZLNW1a?=
 =?utf-8?B?NGphK1VtMXQ2SUo3QTBOaGFrU0ZReEw4N3VWMUZxbE1GTzBnM1dDMlk3SmNJ?=
 =?utf-8?B?ZG5QR20vL1ZpWGViWCtLN0FJM1JaVTYxOTI5bW1wNE1SMlhGOURtQ3FUeWlG?=
 =?utf-8?B?a1Y1T0VUMmZweVUwOHQ3TEcwUTRXRHhxZ1FJbitrT0VqL2ErZk93N0NpTFpZ?=
 =?utf-8?B?eGtVMVZTdk1jaG91RjNBdEFwRVJESFhtZ3lBNS9JalpZcGQzWlh6UHVkdUN3?=
 =?utf-8?B?R2JsamRNU3hmTVpjeWJacWMwb0t0eEYwcTBhU1dkZ0ZCamhCWUtUQzZwRklZ?=
 =?utf-8?B?YldFODJIR0d3dHJna1JLQmdDTmRnaGJTS1lVMUhJSEtqQloxTFdSWnp1ekFn?=
 =?utf-8?B?V3IrT3p3Z3UxVEs2MHkxdGZxSHFHamFGb3IvNzRtMHZIV3NhKzBNeTR3Vlky?=
 =?utf-8?B?ZmlZMlFoY1k1dWw2NWljU1FETzVLZTAxV1dhNjBPUVd2MnRmMnJmbXp6VjV5?=
 =?utf-8?B?c2dtVGtHZXlRRUR1RWZmamVPSlVhclVFY09KVUJ3Q0dJbDFLbWJkMkRMMmJR?=
 =?utf-8?B?bTZzSnZ3UU5JeVFDb3hPcXFtcUhqY3pEaWk4T3dKYTlMc0ttY0syRGYrMXc3?=
 =?utf-8?B?aGFMRjhYL3hrNjQ0czJRZGJ6MUtIcnF3ZEEycTMxY2krOVRTNUlMeXRKM1k3?=
 =?utf-8?B?UHUwNmVEYWMxbEZadHVaSUlYVjd2VTU4VS9Md2I4UEg4eitHVUcrRlNXY0VT?=
 =?utf-8?B?T2dZMnA0ZzMwQ0cvTHVJNk9qN1JSOHdSQm9BbmlidEo3bzUrTWRrbW4rS0k3?=
 =?utf-8?B?a2Rrci80UjFITGlrME5Sak0zTXZLMGU0cFV3dHIwWUhsQlVnR3hsN3o0T3Vn?=
 =?utf-8?B?U3dSY3h0VE1EYzhnSTAyR2RRd2ovNDZQUzZFa2tOb3l1ejJEOFZlMi9DVTdz?=
 =?utf-8?B?TzBueUdjMFNVMThsKzg3eWxldE1GYklOenppaHZNV2s2MTdMTnpvdWpiUTMr?=
 =?utf-8?B?YVp3YitCdW1wbm84d1JlbENUZzVCaTExVUVqTk5QaXpncW11c3VjYW5XVUdI?=
 =?utf-8?B?a3BPc1FyWVJFaE0vNUV0S1NBVGZjbmpwek83MDduTk91amd6NTc3NVB6a2Zk?=
 =?utf-8?B?S2xpMVhZbmRjZnJuRXdQNjlJNlhiY25Ydm5XdUM3Qk1Da3R1M2lvTU50MGcv?=
 =?utf-8?Q?brX4iP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUhlaDFQYnBaWmNPSDl5ZjZLRzgvR2VDWnNNd2F0WUp4SkxuMEVVZ0NYVGFp?=
 =?utf-8?B?N0pZWDJVMHJTMTNTay9hN3JvdFFrS3hNYVRjZ3phaUl6NDlLN0NlcSsxZnN2?=
 =?utf-8?B?NGJJdEU3RWE5aDBOQVAxSnV4dWZzQ1BxbXZIdmJCRWhOZzZaaTNZL1BVSWhp?=
 =?utf-8?B?dEdpcHdiLzZpT0RCUVVmMmh3d0UxalM2am5xWENHemJRTys2bytIWUJFOTBX?=
 =?utf-8?B?NXYwQ2xKYlA0K3c5S1VSbjBURlBjVTRyNDR0VEZBUXVJbkQ0Q29JMW9ZK3dG?=
 =?utf-8?B?L0I4REszUkJReGRDS3UyTUlyVDJORXRUWlV1dW42MFJVeXBlbnBjY3RkNzNC?=
 =?utf-8?B?RGppWHZCMzNZVFJxRXJOdVByaXJnU2crdkJDbDdZVTFxOUU1dWFLeDFJbHhG?=
 =?utf-8?B?bjNnci9zZzAwcXdUUEEyNkxsbjdtSHkrcGZGYW9MbmpiaWlNQ090SlU0MUVC?=
 =?utf-8?B?Q2VCTUQ4bi85VG5PMk1FSnZVSDd2T21VNmhuYVg5SkIyeGhJalFuRTRYSHF4?=
 =?utf-8?B?Yms4S1dqc05IRkI4TWR5bHc2aStETTZTb0FUaFdVQnN4VjlWMmVPRjJreHdl?=
 =?utf-8?B?bDYwZitUL1VkL3JFT3dLRkxqRnhiSWFTV0NzcC8xTzR6WnczZVVoRUFabmwx?=
 =?utf-8?B?VzdzbUl4T3grd0JPNHRXUHg1WEdlMWNORjdsTXZqY0VPeGVmOUIvQ2hZK2pk?=
 =?utf-8?B?bmwxWXNYWWduNDRXMHlVRWZEdDB6TDFNUTN5ekVvMmlaUFMwcERqaEo1eEpK?=
 =?utf-8?B?cjNqMGtCRnR1N1Eza21GL3M1S1V5TE9VM1hoOE1pY2lPYWltREFLSDFKUjdW?=
 =?utf-8?B?cG9PcEkzL21nb1RjeWxHRjNvamdNaDArYlVsT2Y3WDk4dU8wdCt5WjRjUGEz?=
 =?utf-8?B?TTAxUmNKak1UdVRJRlhiS0lOOTNaREx0WVNEdVBwbDdFYnhmVmNFQmpHVTRC?=
 =?utf-8?B?dGJUWTd3eklYRndkQktLUG9sVUgwcjN1YWJldmhYSEs0YjRQN2tpRnI0MU53?=
 =?utf-8?B?bmR0dkttUkM3Q0JoR1BMS0Z4NjcyeEFyRWQwdVBveXNUS01QMXBHQ2I3a0JQ?=
 =?utf-8?B?WlVuamQrRXpBaHFKMTVSSlBnSzA2VitsU00ybmRsTHNXRXowMVBVUmxTY1V1?=
 =?utf-8?B?NWd3UEF2RTFSVFRxODBsMGp6dWlINGozaW5ubWpqMTFNbVIrbmo1dTB4eE0z?=
 =?utf-8?B?WUhxYVo4cHdFRXJoN1NVbGNGSjl0elh2citycHMxVnprTGFrSzloZzY3YlYx?=
 =?utf-8?B?WDVPR3ByVWtRQTBJcnFPRHlaRGhVd2d2Y2llczFIZ0Q3Mi9tSWgzSmlNeHFl?=
 =?utf-8?B?cjMrWU9NNWdqK0tTdFAxUmhLK21tZjZtMDNlY2JodFBTa2dJeUkwZk96bUFx?=
 =?utf-8?B?bVF6SHBtZitsMWw1YXc3OGlvUHJ0cWo2THlDSWVaekN2ZjFBUnloV2NlbDdY?=
 =?utf-8?B?MFA0L0hRRnljWTNnMUYyek4rQTV2T2xQYytQN1RzaXVTY3doTjBIWEZyenBW?=
 =?utf-8?B?REFXeXlTaFFxMXJWRVNOV1lkNXVSenJSUGNEVVlNWHA3ZTMrUW5WQ1U4T1oy?=
 =?utf-8?B?MEVvOGZnd1FQSmVFN0lPWmRVcGhtdXRGS1ZPUzRKSzNZZUMzc0NsSEJJS0Nw?=
 =?utf-8?B?T0NwNWZnd29kbnNnMFVDZElnWXZOM3UxWUlCMXM5bHdxVXJncGpuSkxuNmd4?=
 =?utf-8?B?bVFNK05KNENNZHRnWU1XZFVBZE1zNFJxNTAyalErV25IWnJaVTd1S2hoU0FG?=
 =?utf-8?B?dXEwbTFCd2RLZDNFUURNY0J4VE1yTnhidG5SU3FBeEJTMmVvNXp0alFaUVVp?=
 =?utf-8?B?S0JNZHZCZGFPd0xSdWtWWFozcFh3V0dhTCt6Z1MrbkNJUUsrRnEyeHp6WlU4?=
 =?utf-8?B?cFNyV3ZGTlRwT1BCa0tSZ0w1TnBVbS9GNUlJSThTZnNOczZxUk9VY3U1L2dT?=
 =?utf-8?B?Y0RPY0V6SnN5R0c2K25nNkRaNUJQQ2ZwelljdTVwSDU1U2pHYjIxNjgwbTl2?=
 =?utf-8?B?Q1VvT0FqMktnOGRBZTJqT2QrcWRzSnNmaURtL0o5MW9QaDBwT2RFWmpkckhW?=
 =?utf-8?B?ZnR1K2ZOendmY0tuNGhOSHhUbWFYTll4ZFJUR1dvSm9PMWdyZ1BrdDgwL1N2?=
 =?utf-8?B?blMwczVpR2hocmc0NkdOdXpWdytYZkpTeGc2aG0xdk9xeGhuK2swMU41WFBR?=
 =?utf-8?Q?jvrwLCvUNqnHmb4PtynntG4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5EC4B83EDAC214AA6067FDCFEDF1646@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a12da2-26de-40dd-d1f6-08de21c1cac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 08:02:14.7128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RqIAQpwDQl6W6nCrYIHGNDMNvcgOJ37WF13m8P21BxzGWX//amkcgHc/xFD/GzAMoFqGqVhXO71p4NaT0iOK5a+GnUTEz4AYQXgjEd7IUx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6408

SGkgS3VuaXl1a2ksCgpPbiBUdWUsIDIwMjUtMTEtMTEgYXQgMTk6MDIgLTA4MDAsIEt1bml5dWtp
IEl3YXNoaW1hIHdyb3RlOgo+ID4gPiBGcm9tOiBLdW5peXVraSBJd2FzaGltYSA8a3VuaXl1QGdv
b2dsZS5jb20+Cj4gPiA+IAo+ID4gPiBJbiBfX2lwdjZfc29ja19tY19kcm9wKCksIHBlci1zb2Nr
ZXQgbWxkIGRhdGEgaXMgcHJvdGVjdGVkIGJ5IGxvY2tfc29jaygpLAo+ID4gPiBhbmQgb25seSBf
X2Rldl9nZXRfYnlfaW5kZXgoKSBhbmQgX19pbjZfZGV2X2dldCgpIHJlcXVpcmUgUlROTC4KPiA+
ID4gCj4gPiA+IExldCdzIHVzZSBkZXZfZ2V0X2J5X2luZGV4KCkgYW5kIGluNl9kZXZfZ2V0KCkg
YW5kIGRyb3AgUlROTCBmb3IKPiA+ID4gSVBWNl9BRERfTUVNQkVSU0hJUCBhbmQgTUNBU1RfSk9J
Tl9HUk9VUC4KPiA+ID4gCj4gPiA+IE5vdGUgdGhhdCBfX2lwdjZfc29ja19tY19kcm9wKCkgaXMg
ZmFjdG9yaXNlZCB0byByZXVzZSBpbiB0aGUgbmV4dCBwYXRjaC4KPiA+ID4gCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEt1bml5dWtpIEl3YXNoaW1hIDxrdW5peXVAZ29vZ2xlLmNvbT4KPiA+ID4gUmV2
aWV3ZWQtYnk6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4KPiA+ID4gLS0tCj4g
PiA+IMKgIG5ldC9pcHY2L2lwdjZfc29ja2dsdWUuYyB8wqAgMiAtLQo+ID4gPiDCoCBuZXQvaXB2
Ni9tY2FzdC5jwqDCoMKgwqDCoMKgwqDCoCB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0KPiA+ID4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCsp
LCAyMiBkZWxldGlvbnMoLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9uZXQvaXB2Ni9pcHY2
X3NvY2tnbHVlLmMgYi9uZXQvaXB2Ni9pcHY2X3NvY2tnbHVlLmMKPiA+ID4gaW5kZXggY2IwZGM4
ODVjYmU0Li5jODg5MmQ1NDgyMWYgMTAwNjQ0Cj4gPiA+IC0tLSBhL25ldC9pcHY2L2lwdjZfc29j
a2dsdWUuYwo+ID4gPiArKysgYi9uZXQvaXB2Ni9pcHY2X3NvY2tnbHVlLmMKPiA+ID4gQEAgLTEy
MSwxMCArMTIxLDggQEAgc3RhdGljIGJvb2wgc2V0c29ja29wdF9uZWVkc19ydG5sKGludCBvcHRu
YW1lKQo+ID4gPiDCoCB7Cj4gPiA+IMKgwqDCoMKgwqDCoCBzd2l0Y2ggKG9wdG5hbWUpIHsKPiA+
ID4gwqDCoMKgwqDCoMKgIGNhc2UgSVBWNl9BRERSRk9STToKPiA+ID4gLcKgwqDCoMKgIGNhc2Ug
SVBWNl9EUk9QX01FTUJFUlNISVA6Cj4gPiA+IMKgwqDCoMKgwqDCoCBjYXNlIElQVjZfSk9JTl9B
TllDQVNUOgo+ID4gPiDCoMKgwqDCoMKgwqAgY2FzZSBJUFY2X0xFQVZFX0FOWUNBU1Q6Cj4gPiA+
IC3CoMKgwqDCoCBjYXNlIE1DQVNUX0xFQVZFX0dST1VQOgo+ID4gPiDCoMKgwqDCoMKgwqAgY2Fz
ZSBNQ0FTVF9KT0lOX1NPVVJDRV9HUk9VUDoKPiA+ID4gwqDCoMKgwqDCoMKgIGNhc2UgTUNBU1Rf
TEVBVkVfU09VUkNFX0dST1VQOgo+ID4gPiDCoMKgwqDCoMKgwqAgY2FzZSBNQ0FTVF9CTE9DS19T
T1VSQ0U6Cj4gPiA+IGRpZmYgLS1naXQgYS9uZXQvaXB2Ni9tY2FzdC5jIGIvbmV0L2lwdjYvbWNh
c3QuYwo+ID4gPiBpbmRleCBkNTVjMWNiNDE4OWEuLmVkNDBmNWIxMzJhZSAxMDA2NDQKPiA+ID4g
LS0tIGEvbmV0L2lwdjYvbWNhc3QuYwo+ID4gPiArKysgYi9uZXQvaXB2Ni9tY2FzdC5jCj4gPiA+
IEBAIC0yNTMsMTQgKzI1MywzNiBAQCBpbnQgaXB2Nl9zb2NrX21jX2pvaW5fc3NtKHN0cnVjdCBz
b2NrICpzaywgaW50IGlmaW5kZXgsCj4gPiA+IMKgIC8qCj4gPiA+IMKgwqAgKsKgwqAgc29ja2V0
IGxlYXZlIG9uIG11bHRpY2FzdCBncm91cAo+ID4gPiDCoMKgICovCj4gPiA+ICtzdGF0aWMgdm9p
ZCBfX2lwdjZfc29ja19tY19kcm9wKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IGlwdjZfbWNfc29j
a2xpc3QgKm1jX2xzdCkKPiA+ID4gK3sKPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBuZXQgKm5ldCA9
IHNvY2tfbmV0KHNrKTsKPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBuZXRfZGV2aWNlICpkZXY7Cj4g
PiA+ICsKPiA+ID4gK8KgwqDCoMKgIGRldiA9IGRldl9nZXRfYnlfaW5kZXgobmV0LCBtY19sc3Qt
PmlmaW5kZXgpOwo+ID4gPiArwqDCoMKgwqAgaWYgKGRldikgewo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBpbmV0Nl9kZXYgKmlkZXYgPSBpbjZfZGV2X2dldChkZXYpOwo+
ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXA2X21jX2xlYXZlX3NyYyhz
aywgbWNfbHN0LCBpZGV2KTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIChpZGV2KSB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIF9faXB2Nl9kZXZfbWNfZGVjKGlkZXYsICZtY19sc3QtPmFkZHIpOwo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbjZfZGV2X3B1dChpZGV2KTsKPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkZXZfcHV0KGRldik7Cj4gPiA+ICvCoMKgwqDCoCB9IGVsc2Ugewo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlwNl9tY19sZWF2ZV9zcmMoc2ssIG1jX2xzdCwg
TlVMTCk7Cj4gPiA+ICvCoMKgwqDCoCB9Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgIGF0b21pY19z
dWIoc2l6ZW9mKCptY19sc3QpLCAmc2stPnNrX29tZW1fYWxsb2MpOwo+ID4gPiArwqDCoMKgwqAg
a2ZyZWVfcmN1KG1jX2xzdCwgcmN1KTsKPiA+ID4gK30KPiA+ID4gKwo+ID4gPiDCoCBpbnQgaXB2
Nl9zb2NrX21jX2Ryb3Aoc3RydWN0IHNvY2sgKnNrLCBpbnQgaWZpbmRleCwgY29uc3Qgc3RydWN0
IGluNl9hZGRyICphZGRyKQo+ID4gPiDCoCB7Cj4gPiA+IMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaXB2
Nl9waW5mbyAqbnAgPSBpbmV0Nl9zayhzayk7Cj4gPiA+IC3CoMKgwqDCoCBzdHJ1Y3QgaXB2Nl9t
Y19zb2NrbGlzdCAqbWNfbHN0Owo+ID4gPiDCoMKgwqDCoMKgwqAgc3RydWN0IGlwdjZfbWNfc29j
a2xpc3QgX19yY3UgKipsbms7Cj4gPiA+IC3CoMKgwqDCoCBzdHJ1Y3QgbmV0ICpuZXQgPSBzb2Nr
X25ldChzayk7Cj4gPiA+IC0KPiA+ID4gLcKgwqDCoMKgIEFTU0VSVF9SVE5MKCk7Cj4gPiA+ICvC
oMKgwqDCoCBzdHJ1Y3QgaXB2Nl9tY19zb2NrbGlzdCAqbWNfbHN0Owo+ID4gPiAKPiA+ID4gwqDC
oMKgwqDCoMKgIGlmICghaXB2Nl9hZGRyX2lzX211bHRpY2FzdChhZGRyKSkKPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPiA+ID4gQEAgLTI3MCwyMyAr
MjkyLDggQEAgaW50IGlwdjZfc29ja19tY19kcm9wKHN0cnVjdCBzb2NrICpzaywgaW50IGlmaW5k
ZXgsIGNvbnN0IHN0cnVjdCBpbjZfYWRkciAqYWRkcikKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGxuayA9ICZtY19sc3QtPm5leHQpIHsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoKGlmaW5kZXggPT0gMCB8fCBtY19sc3QtPmlmaW5kZXggPT0gaWZpbmRleCkg
JiYKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlwdjZfYWRkcl9l
cXVhbCgmbWNfbHN0LT5hZGRyLCBhZGRyKSkgewo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2Owo+ID4gPiAtCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpsbmsgPSBtY19s
c3QtPm5leHQ7Cj4gPiA+IC0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZGV2ID0gX19kZXZfZ2V0X2J5X2luZGV4KG5ldCwgbWNfbHN0LT5pZmluZGV4KTsK
PiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRldikg
ewo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3RydWN0IGluZXQ2X2RldiAqaWRldiA9IF9faW42X2Rldl9nZXQoZGV2KTsKPiA+
ID4gLQo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaXA2X21jX2xlYXZlX3NyYyhzaywgbWNfbHN0LCBpZGV2KTsKPiA+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChpZGV2KQo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9faXB2Nl9kZXZfbWNfZGVjKGlkZXYsICZt
Y19sc3QtPmFkZHIpOwo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9IGVsc2Ugewo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaXA2X21jX2xlYXZlX3NyYyhzaywgbWNfbHN0LCBOVUxMKTsK
PiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiAt
Cj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0b21pY19z
dWIoc2l6ZW9mKCptY19sc3QpLCAmc2stPnNrX29tZW1fYWxsb2MpOwo+ID4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrZnJlZV9yY3UobWNfbHN0LCByY3UpOwo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2lwdjZfc29j
a19tY19kcm9wKHNrLCBtY19sc3QpOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9Cj4gPiA+IMKgwqDCoMKgwqDCoCB9Cj4gPiAKPiA+IEknbSBnZXR0aW5nIHRoZSBiZWxv
dyBzdGFjaywgdGhvdWdoIHVucmVsaWFibHksIGR1cmluZwo+ID4ga2VybmVsLXNlbGZ0ZXN0L2Ry
aXZlcnMvbmV0L2RzYS9sb2NhbF90ZXJtaW5hdGlvbi5zaCBydW5zIHdpdGggZGlmZmVyZW50IG5l
dy1uZXh0Cj4gPiByZXZpc2lvbnMgYmFzZWQgb24gdjYuMTgtcmNYOgo+ID4gCj4gPiBSVE5MOiBh
c3NlcnRpb24gZmFpbGVkIGF0IGdpdC9uZXQvY29yZS9kZXYuYyAoOTQ3NykKPiA+IFdBUk5JTkc6
IENQVTogMSBQSUQ6IDUyNyBhdCBnaXQvbmV0L2NvcmUvZGV2LmM6OTQ3NyBfX2Rldl9zZXRfcHJv
bWlzY3VpdHkrMHgxZDAvMHgxZTAKPiA+IHBjIDogX19kZXZfc2V0X3Byb21pc2N1aXR5KzB4MWQw
LzB4MWUwCj4gPiBDYWxsIHRyYWNlOgo+ID4gwqAgX19kZXZfc2V0X3Byb21pc2N1aXR5KzB4MWQw
LzB4MWUwIChQKQo+ID4gwqAgX19kZXZfc2V0X3J4X21vZGUrMHhmOC8weDExOAo+ID4gwqAgaWdt
cDZfZ3JvdXBfZHJvcHBlZCsweDFlOC8weDYxOAo+ID4gwqAgX19pcHY2X2Rldl9tY19kZWMrMHgx
NjQvMHgxZDAKPiA+IMKgIGlwdjZfc29ja19tY19kcm9wKzB4MWFjLzB4MWUwCj4gPiDCoCBkb19p
cHY2X3NldHNvY2tvcHQrMHgxOTkwLzB4MWU1OAo+ID4gwqAgaXB2Nl9zZXRzb2Nrb3B0KzB4NzQv
MHgxMDAKPiA+IMKgIHVkcHY2X3NldHNvY2tvcHQrMHgyOC8weDU4Cj4gPiDCoCBzb2NrX2NvbW1v
bl9zZXRzb2Nrb3B0KzB4N2MvMHhhMAo+ID4gwqAgZG9fc29ja19zZXRzb2Nrb3B0KzB4ZjgvMHgy
NTAKPiA+IMKgIF9fc3lzX3NldHNvY2tvcHQrMHhhOC8weDEzMAo+ID4gwqAgX19hcm02NF9zeXNf
c2V0c29ja29wdCsweDcwLzB4OTgKPiA+IMKgIGludm9rZV9zeXNjYWxsKzB4NjgvMHgxOTAKPiA+
IMKgIGVsMF9zdmNfY29tbW9uLmNvbnN0cHJvcC4wKzB4MTFjLzB4MTUwCj4gPiDCoCBkb19lbDBf
c3ZjKzB4MzgvMHg1MAo+ID4gwqAgZWwwX3N2YysweDRjLzB4MWU4Cj4gPiDCoCBlbDB0XzY0X3N5
bmNfaGFuZGxlcisweGEwLzB4ZTgKPiA+IMKgIGVsMHRfNjRfc3luYysweDE5OC8weDFhMAo+ID4g
aXJxIGV2ZW50IHN0YW1wOiAxMzg2NDEKPiA+IGhhcmRpcnFzIGxhc3TCoCBlbmFibGVkIGF0ICgx
Mzg2NDApOiBbPGZmZmY4MDAwODAxM2RhMTQ+XSBfX3VwX2NvbnNvbGVfc2VtKzB4NzQvMHg5MAo+
ID4gaGFyZGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoMTM4NjQxKTogWzxmZmZmODAwMDgxODIzZWU4
Pl0gZWwxX2JyazY0KzB4MjAvMHg1OAo+ID4gc29mdGlycXMgbGFzdMKgIGVuYWJsZWQgYXQgKDEz
ODYxMCk6IFs8ZmZmZjgwMDA4MTE0NDgxND5dIGxvY2tfc29ja19uZXN0ZWQrMHg4Yy8weGI4Cj4g
PiAKPiAKPiBUaGFua3MgZm9yIHRoZSByZXBvcnQhCj4gCj4gPiBEbyB5b3UgaGF2ZSBhbiBpZGVh
IHdoYXQgY291bGQgYmUgZm9yZ290dGVuIGluIHRoZSBTdWJqZWN0IHBhdGNoPwo+ID4gCj4gPiBE
byB3ZSBuZWVkIHRvIGRyb3AgQVNTRVJUX1JUTkwoKSBmcm9tIF9fZGV2X3NldF9wcm9taXNjdWl0
eSgpIG5vdywgb3IgYW0gSQo+ID4gdG9vIG5haXZlPwo+IAo+IGhtbS4uIEFTU0VSVF9SVE5MKCkg
aXMgc3RpbGwgbmVlZGVkIHRoZXJlIGdpdmVuIG5vdCBhbGwgY2FsbGVycwo+IGhvbGQgbmV0ZGV2
X2xvY2soKSBhbmQgbmRvX2NoYW5nZV9yeF9mbGFncygpIGNvdWxkIG5lc3QgdGhlIGNhbGwuCj4g
Cj4gQnV0IGxldCBtZSB0aGluayBpZiB3ZSBjYW4gZG8gc29tZXRoaW5nIGJldHRlciB0aGFuIHJl
dmVydGluZyBpdC4KCkknbGwgYmUgaGFwcHkgdG8gdGVzdCBhIHBhdGNoLCB5b3UgZGVmaW5pdGVs
eSBoYXZlIG1vcmUgaW5zaWdodHMgaW50byB0aGUgZGlmZmVyZW50IGxvY2tzCmluIHRoaXMgYXJl
YS4uLiBJIHdhcyBsb29raW5nIGludG8gaXQgeWVzdGVyZGF5LCBidXQgdGhlIG5ldGRldl9sb2Nr
X29wcygpIGluCmRldl9zZXRfcHJvbWlzY3VpdHkoKSBqdXN0IGRvZXNuJ3QgbG9vayByaWdodCBh
cyBhIHJlcGxhY2VtZW50IGZvciBfX2Rldl9zZXRfcHJvbWlzY3VpdHkoKQpiZWNhdXNlIGl0J3Mg
b3B0aW9uYWwgKGZvciBzb21lIHJlYXNvbikgYW5kIGl0IHNlZW1zIHdlIG5lZWQgc29tZSBkdW1i
IHBlci1uZXRfZGV2aWNlIGxvY2sKaGVyZT8KCi0tIApBbGV4YW5kZXIgU3ZlcmRsaW4KU2llbWVu
cyBBRwp3d3cuc2llbWVucy5jb20K

