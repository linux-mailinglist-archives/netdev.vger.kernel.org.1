Return-Path: <netdev+bounces-264834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDmBNCXtqmmOYAEAu9opvQ
	(envelope-from <netdev+bounces-264834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:05:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 511DB22367F
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FEEC300AC0F
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB91343D75;
	Fri,  6 Mar 2026 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oEYsG2Zl"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572EB30EF87
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809279; cv=fail; b=behfdvnxYto9O0/O+DWUd2WZKaonFLszymB2jvj4wMRFm6YVHdHzBqnDA19p6yQYHYtZTkvhqnC//7VUptc4AafB/AMJKcsHhWS50I+jZHS80jsYPxkAXnRJ76ivoPcXfRdj84boeRpQGJdD2hA0NCR6/kEEga2jhV78euz0+IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809279; c=relaxed/simple;
	bh=sEwc8QL9GRWCygjYKgic6c45omqpnBcG0xfsv8o6/eo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HiZ+exMrnyVMeXdHjnKUlar+Jp54RFScEGvefUSAPiskVe/ZBuvquUbh1FUS2LYYs5B3OPBXROcvbK7YmmTU1CSoXBoIO+i8os4eADh4koQ34pcPxKT5TbY/c0H27zbEmmXrsT8DscZDg8MZdgmsvASBIgvFa9e8RAgvPppcE7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oEYsG2Zl; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccfH+GmEcgIahLm/kZp/h4KnxGm572XxmV8H6vEesqGPYVjkyUHzr1ahktq7afZvgr0D2kCQdSgcg72cj6Hgv3c///E66Piwc3UdpqmX8w2Bcb7PxBcCZGR7vcMw7q87gyZmApv2GDktRu0XUVv7sPMyQONqf7XcG/oWAs3mpkYMiMzSfyniw9Pg0ZVr53FfnGRAJ7ootOJfTDp3dcjflDuJxEIOYxmmb6DInJHibG2iI/IAgSlw824FqJ9kBKyEwq3DAusrHMIhlzwbA7HVAw8N97MVo6GKmAL45t+Z7SbZBhe5ULlAC07XRR41suYfa+Q3geaD0hT0/qpgwa+O/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEwc8QL9GRWCygjYKgic6c45omqpnBcG0xfsv8o6/eo=;
 b=P3KZDF2aBGmIESWcN8OoFLPZjQpU0KYB4CSkI5oClPpWiB/CRscTG2aeZzUOUNBQ981uqDzpy4SrME2BQ8E64u6Lsd4OlhzwXsFqBex2XiCh+3Sax0EvtpVCnPSAOkGU6J9FjQPBS2EKYbXlsj5N0NOPHDTnRWWJWi8BSllHH62FcRmo2YAsJW1rW+ETrp629aSH3A+pUuO9ch8NJ6GCb7PoSRUdnubPJLY/nO+aAD9g097vCOXkNJ3xpfOrmJR/3Fe5PLJ8Uf/ziaZw6b2NDRjsIuu/TgQ1DCrrDDHf0efCwx444F3rKeqbWOevp5afb3uYqv1zvjlU3jzu9qErtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEwc8QL9GRWCygjYKgic6c45omqpnBcG0xfsv8o6/eo=;
 b=oEYsG2ZlicmGc7GThakVG7UV9DaePJk715AgpV/Sn2yd9Venxoi0l9Tz1crY0IU+NQ31JIK1579xMeqHSyqV5BnjEhKbD7IlJO6nKukSFxRImZDCRINsF2WiqEBdXtRgs2H2Fj89dJneQA1qwIIi4VfmTRd9A1gvWj/WZdHjMN1jApr6bX0ICrncwNtj3sXsDLONggtdfVEcxMmXOEnUHegk8d0mGPR9j6F4bLBAxLrEPxffS7xQuj9g60qrmYTUg+vQDCYsWJnqvcn8WX6pBDy1aCSWpjKmDEs2Msp8/uwx8RtLDqdIUuqpmZRksKl4XjZpVDQ9kdhpS6BvFnLabg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by IA1PR12MB7685.namprd12.prod.outlook.com
 (2603:10b6:208:423::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:01:09 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb%4]) with mapi id 15.20.9678.016; Fri, 6 Mar 2026
 15:01:02 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 2/3] selftests: Add macsec offload VLAN tests
Thread-Topic: [PATCH net-next v2 2/3] selftests: Add macsec offload VLAN tests
Thread-Index: AQHcp8fmkGmulGq6SUq/0ayj1Ot4xLWWo4WAgAsBAoA=
Date: Fri, 6 Mar 2026 15:01:02 +0000
Message-ID: <305e5617d31872ed9734463a1e13bb714a5e2a22.camel@nvidia.com>
References: <20260227090227.1552512-1-cratiu@nvidia.com>
	 <20260227090227.1552512-3-cratiu@nvidia.com>
	 <20260227065833.36edcc6c@kernel.org>
In-Reply-To: <20260227065833.36edcc6c@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|IA1PR12MB7685:EE_
x-ms-office365-filtering-correlation-id: aa80b39f-4a15-4f93-a1c8-08de7b912f05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 emGN1M2YQ57Zf4tS4YYFabaaR58T5QzH5Nz0S8zNSupr6YL5sFLHAphGbL6r5+x7R5Vae2fdTdDYWYwWZtUTITNx4E0hnUtERDD7ZzHexY3B3o1gnbehG11p8l5Z533D4kqRrdYNaSQW7LOH0fZbTm12Mv0csBJ277pqol1rccLOUJzbyCIA5puzQZ5Wzcuszp72M5u/4+k8BCNjUOsnM9aYzxfm0eY43oOH6E29jJDmNuH5zZniYfZ46Ryzhn+CxRBaEL5696/pw07luZXIIc6qxRzoRhiF9wncffcc/ftkmH/M2l+E30fxbyGZHWJ9b6bzxoFSvpY7l0mq3kU3SboFrLNmuh9tpe5OOVoZ5jD58FIpcpfnvJM73VrLg8YAe/IQa18hRiziYB4uw6Cr+tf5lnp81vEsfDPqPBkpVS4yVEAGorCvjAGPpG/JT7KNx2L8BmnWiT/bpepTv8aTzk8BS6x6rd8GOmI7+wdnz8bLG+0bRsvjlz/xyuLAEP5zmQX0OEK1GBjRQ3tcmTJ1ZiAbyeEAfP73kNWjMBC//A4/dA91Ebl60GQctA5wRRy6DdYlB8jl5/mh59alj8SvBs8N1Mdj7wuH4iazgwquV6SzFFH58mb+jB4Dk/kWVXNbzpMtt4gHDNZMQIcEvMDCH8HWkt0uvzGha8ZTLnzbvzxxQU6SKk3ORjTdHmFJe9gWyRcsbBKPxRPeyZBVGTyKUXtqGieXkFXYJxNIEINN1yllB37DfvD1Yohnf64+ugaP+f4HXq/8BHrzhB5gtF0M8Ja7mUCJr54FEmgm5QmxP9E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VThUODMwcXVacmswMkVzM25UZlQ2YTB1M28zT21jeEI3MStORlhZUDFLRHRI?=
 =?utf-8?B?WkVnTDBHZzd6ZEZhczdNYlVjNnJCNnpHRmZxWHJJZFNxcUptRlcrTUVlWHdR?=
 =?utf-8?B?cGFHR2IzM2ZGTHBkWU1LM1RHcmJmbjBXbndGek52eFRRaHBLT1k0SkxDVjh3?=
 =?utf-8?B?Q0hOVDBoeXArRUhheGI4U3RON24wVlpiWEFtZVJobTVYdDlpbU85SUw4ek9O?=
 =?utf-8?B?T1ZoclZlQW5QUk5jNVZzOVJ3QUJJa3VuM1UxbW9yd3RabElvc2VOb1lINmpB?=
 =?utf-8?B?TTdqRUtCSTI2RzFaOENSWEdURmZHelRWVGI1U1ZzcVB0YXprbmdDQ21tM2Rp?=
 =?utf-8?B?ZUFvcE1Yc3FlUEI1SFFheXZWbnFkdHcwT2lUNDBvcGpQL1NHUTRHZ2x0dExL?=
 =?utf-8?B?ekZSM2RTOHpjQTRuK29NU0Jjb0FrR3B0eE1yL2R1cW9uS3VnVndHZEVCY2pR?=
 =?utf-8?B?eE45WkpLcWlkUGM4SjRtOVp2ZFFlQWhCYmlQOEdiVjJ3QytZdjNFdnFpa2hZ?=
 =?utf-8?B?M2Rzb0VQZHJsRllIOUhWREFOaFd1VjBjbVZNTG1NeHp0WlV2bWgza3VFNmNm?=
 =?utf-8?B?cmVxQWpmL21WRiszUEppVkh5QmVrRkVzOCtNRVU3UUV2U21hK05pZVBFVXhE?=
 =?utf-8?B?Y2FoOWlhNzhsWk5IaFBwb1U3M3dhMXRGRjhNZ05zY1FTUW9acUZrSWNaR1Ir?=
 =?utf-8?B?TnI3cG1lY0t4SFpXeEpweEFZZ1JxMXM5UmRFMndvTlV6SHlHZ3pyOHhmKzc2?=
 =?utf-8?B?MW1CSkw5Q2NXUzRkUzREVm1YUitFT2NWVjhTSXNmVi8rVXA0a3kzdjdPaUhR?=
 =?utf-8?B?dTZBcU5hVWVxOG0xL0xFbEw4VmVxaUw1d0pxMTBsVnY5eW56UUZscEJJTHRI?=
 =?utf-8?B?ZFNrSXJtMVF3c2N0LzJNM0I3aXZ0SHpSZWc5TlF6ZUh2ZFRoOVJXOEN5OURP?=
 =?utf-8?B?N2E0TkcyNittRGQ2TmFmVUprSFJINC9PMG5ob25zWEFNd1FpMGRFYWp5NnNu?=
 =?utf-8?B?c0JZdldXaXBkU28vcVJ4SWZoWHRpT1FGTXBpL2dhMklmRFpLaUVaQjA2NGRX?=
 =?utf-8?B?WmlXT1Zka1BKTWFJL29aZS80VzNaK29hNFlmdkR6L2hVS3Q5T2lGT05DK2FZ?=
 =?utf-8?B?OXZPNEF3bWNqQjZ5K0xYdFV4V3RwY0V0SkRaQUNKNi9jait5QW4rZDlGeE90?=
 =?utf-8?B?bFQzQktBSm0rakloV0M5dHd5cEwraytTRHNPTStiV1Rsekw5a3JaWkxqeCty?=
 =?utf-8?B?aVJZbHE5Zk5BSkZQNk1QQ0dMbmdsTGt5c1Vja3p6dFArTnBiWjl4eTVkeVpI?=
 =?utf-8?B?OStGY0h1NllrejArdVI0Mkp6SzAybmZabXFmd1ZuTkxHSGt0dWpoTEN0ZXpD?=
 =?utf-8?B?RnVyQjcvY01lMjBCQ3ZDeHA4Z2VvTGhDZTZ3b1N1ZzZybHJYVmt5ZzdQL0l3?=
 =?utf-8?B?NzJoYUt5QzNiSVo1cm1FRm9jY3Ayd3MzRGRBd01wTGxUblk0NnZXTDlyWHBV?=
 =?utf-8?B?cDBjaHV4NnJveUp6a1ZkcGc1NXh1WFlmWDhqV3B2bTdqd21MeEFoM1VtMzRD?=
 =?utf-8?B?TzB3N3ZOeUdEMzQ4UWU4cFVRbGUvbVNlWDY0WUVQaEFUZzgvZmY3dnY2U2RK?=
 =?utf-8?B?cStkVDJFcEpTb1JBR2dLRVV5Qk9NeHNrZkJxM3hFampGT0JmOXVpUnMrUUJG?=
 =?utf-8?B?REpKNkNYUVl2T3JGUDV5ZG5sK1JMYmtmcFV2Z3NuN2FZalNiZDZKeEo1VCtj?=
 =?utf-8?B?Q2MzVWViTkUyNlh0WSs4MnRHd1Bjd0hndVJ4UmE1b3RwbytZNk9zcE83VXd2?=
 =?utf-8?B?N0VPNWk3M2t5bjNYWlN1L054VW10QkJvYkMyN2k1NmNNUlpoMXd6U0ttZGNM?=
 =?utf-8?B?SVlyaHNaQ1c1ekYzNWdsVjlNclZYdG5NU3luTlRid0VVcVplWmhnRUVqRlZj?=
 =?utf-8?B?RVloYUc5eVMzbEtDV2ExY3d0SVhMSDdPbUVWVmo0WUFnMXlYRFlkVVI3RDdr?=
 =?utf-8?B?ekVhbzJoazBOSUk5US9ZUUNvZ2tWZ2ZFMDRNc0tZMkpzQlVxWUNtTjgrLzcy?=
 =?utf-8?B?elV3Q1FLU1dFMlRGWXErMWd0a1RLVTlOYWRvYko4c0lPZUx0Q1VoRnU1QTJX?=
 =?utf-8?B?YnZuOFRzeW43NXMrdUdJajYvNEYrdDZGQVBVaU55OTNDbnpqLzZZbU9TWXM3?=
 =?utf-8?B?dDR5QU1qQmZYYnNzZWFVenJLWjdTWkpueHNXeGNkRzhYSHhXaGdlSTgwT0Vx?=
 =?utf-8?B?K0poNHl5ZUI1TnZaS0V3VTlkdHMyV0FuWjhQbWJ2eTgxTHFYRFVTTU96T3Rt?=
 =?utf-8?B?RXpEUkNubnNnSVEreC96R2dheVFqNTAwbitENTRFeGE1VE13MUtGdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <300006927DBC37488D04A034D5328F41@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa80b39f-4a15-4f93-a1c8-08de7b912f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 15:01:02.1936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FuXG6OCDojBdYEksHvbTsvqib7BLXSXeRHPZz4gEcfY0K9f2fHKavDfr3M0Glid0aHx34s3gLxtg6GRBGVK3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
X-Rspamd-Queue-Id: 511DB22367F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264834-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:replyto,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAyLTI3IGF0IDA2OjU4IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gRnJpLCAyNyBGZWIgMjAyNiAxMTowMjoyNiArMDIwMCBDb3NtaW4gUmF0aXUgd3JvdGU6
DQo+ID4gQWRkIG1hY3NlYyBvZmZsb2FkIFZMQU4gdGVzdHMgdXNpbmcgdGhlIG5ldHNpbSBWTEFO
IHN1cHBvcnQganVzdA0KPiA+IGFkZGVkLg0KPiA+IEluIGNhc2UgdGhhdCBWTEFOIHN1cHBvcnQg
aXMgbWlzc2luZyAoZS5nLiB3aGVuIHJ1bm5pbmcgdGhlc2UgdGVzdHMNCj4gPiBvbg0KPiA+IG9s
ZGVyIGtlcm5lbHMpLCB0aGUgVkxBTiB0ZXN0cyBhcmUgc2ltcGx5IHNraXBwZWQuDQo+IA0KPiBZ
b3UgaGF2ZSB0byBlbmFibGUgbWFjc2VjIGluIHRoZSBjb25maWcgZmlsZSBmb3IgbmV0ZGV2c2lt
IHNlbGZ0ZXN0cw0KDQptYWNzZWMgaXMgYWxyZWFkeSBlbmFibGVkLCBJIGFzc3VtZWQgeW91IG1l
YW50IFZMQU4uIFdpbGwgZG8uDQoNCkNvc21pbi4NCg==

