Return-Path: <netdev+bounces-288691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JGWIIR9jCWqHXwQAu9opvQ
	(envelope-from <netdev+bounces-288691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:41:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A555F8C4
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15272300B9CF
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 06:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706422E8B9B;
	Sun, 17 May 2026 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AXVfzFp8"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07681A724C
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779000092; cv=fail; b=DkbhdNTUb2moKvQCFXQWMIBNm8IgZRIREuw4vcW4Jx8BpOFFXQVTBn6Ntmu4wjc3WrWkmp5nCpLtSc2ZmjHtbB2VduX9ndlQOR9DdqBeEh21tsIVTPG2FUwzA+0VeW71vWtt8wnIfl8rW8mMimranegmm13ETyqfV9Vr6v1c2aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779000092; c=relaxed/simple;
	bh=HIw8Od6sYoUHpCtymUsb8vrw3WwpflJzPt9EXe7JXS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dhK+Zm5v7khbASxTgpuCzuq2SkTxMiwPMULipBbQyKYCCFZ+4SoYZBsAHpWPivbfZigpgshU5NV5O39nD1DqXVIvtiPedAzpJKuYMekKmxNzTF0DGVxUgFZJJZNaDAY2B8r67aLAnyRC2TbKFw6lvBhEWKkH6mHR2Yo8KTpZLMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AXVfzFp8; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kN3jFGYaF0Q9FCosZ24Ha30HCQpmxbSyrYbju2iCege3lmePdd0vUzDtlFoJC2tZOXqRxoNXYGrl0naJZGRTLhd64E4oAArH5d8JDUsiX0d1DjJ6GHMmDosudWOUdJq0mQxYoj1XKLc4uRWwLQgk1Jkcd80vfontG5CO+357IjJqZMnw24LFNvpH68dbm8x7WiHIolbriqqM26dli9FFW55cGAuZGQBojSAoj4mmr7DdLQiEpFZzwxay9jEm+7a+P1eixPOtOb39E/pvgxIDeJFzh75EpEeYJHeL4AGseMsxJoPahaBnGKvt6pBAITtqJNbgAhek7Px2kbCaOuvupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OikvRQjD7HJPAyQVTs+0ncGIz/wdZjL7iH48qrL+7yc=;
 b=YL66ae1Hv71NOND0lpLufXx2dxKIhpiK9Bd8Ao+LDoakfgSgoEVKNGod0KmNaNpFi3JWfIj3PtklUn0RB2puaWyfETrYh9zjFrpp3m9gxhAEhM3HhWFkW7nIFVutMul4XHZ9ky6fthoD8M9E1UdwNoVe/SBG3tH0f0zWNhW5FIcUnM71LFLmPEFOsdURUwCT2swlaPoOuErt/TPQWOwpzmg3YPKqv8PcWTK2p76Vp48+QkAHSOfB9uuvxQvgm0drca3fHzaMP8RM7kIXiVpZWmIDJj2ZMGnUgdZrEvN4ps6Mv+/8y4TmZijlOleHaZCKy1lBVo5nE/W0OU0UH95UQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OikvRQjD7HJPAyQVTs+0ncGIz/wdZjL7iH48qrL+7yc=;
 b=AXVfzFp8SsUzd1SVfY4D3Bd7H1vvGiDabBAB+K1uXfgRX4ceijzgZxI4PnTvM+D04fk9kYORDUmIvtRfcf5zHx+SdLRrPeRUgvgPS6db0dn5Vvfce+VOZObDbPdiuPM/99GpARUAnaTizinUPvF5m7ZDNrlDsbU64ihA3VuwdvGWlCHQp8r3Kq5iVMRvv/e6zahiK7KuiPQ4qglFpBpHI2bCquavNj1MhvSQOGS7AmMIVR4AVI320kFf5/B2Le9NydvsgULsz0bnOZOsTfTqm4d/r03wGFY4gwNIunp8lUH/u1nlGMcE06CXDkBJ04TOGsgFbhUwA0cgC+5DbuBqqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sun, 17 May
 2026 06:41:25 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.21.0025.022; Sun, 17 May 2026
 06:41:25 +0000
Message-ID: <58b42cf7-d18e-482c-b4e5-695dd490b40f@nvidia.com>
Date: Sun, 17 May 2026 09:41:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: Fix UDP length on last GSO_PARTIAL segment
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 Willem de Bruijn <willemb@google.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20260513074349.2152146-1-gal@nvidia.com>
 <f75c1cf5-b5ad-47db-952f-faad9f0a33ed@app.fastmail.com>
 <f356add6-e173-4020-a8af-8cc70aec955d@nvidia.com>
 <ea0d0e1c-bfc2-4271-94d7-3bec2f2e85a3@app.fastmail.com>
 <c129979f-7494-433c-92c4-6d4290add4d9@nvidia.com>
 <23e6e0f4-29ee-4f86-b02d-8c8d881c51f7@app.fastmail.com>
 <c4279000-dd9a-4e59-ae0d-6dcc5c7b03a2@nvidia.com>
 <6702f4e4-cc0d-42ed-b11e-ba272018750a@app.fastmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <6702f4e4-cc0d-42ed-b11e-ba272018750a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5edf1d-852e-4d84-b787-08deb3df510f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	9i3RrcjL+p1clLD3KxpsI12ZZHgrYvRs13Ub3rMaxpqAFEqqM3XXT75aD8W5ym04k8Ry1Ag5a7cZNHiTlxJvYEBqgI4EWwEGZnmIAMzCQhFgjc9GzNKv1jnDCTXgF2H2PeOrL2Vzr4aprnjadG/4RmdWIz+doXNYrtXJXuLUzuNGnDnP7NMpIATNDhzc/nA/zA8cgq8JPH0VoLkFBZokyHqMCEFDwEQwQa/pwWqpZ204b1Adf1jI1p0x+CgsgdIkdeix5dUL9lkMm+Ir82sCf/6G5HRZcgoUxgCDbNI4pjrqzAt2XnOGaMtV/ugbQAS7q3SigaHz29itlUiJ+OOMTGLjnswbLVWUJWAnyUyncFW1W29stB+fJ3rPsxq3E/FRDjcSB81UhS/7FyCzPh5VQ6t7L2GqvLyQYTi3g3euHII0FFTf09v4s/xpEsqkiLab8XDyLDM2AZXtqQ0GipOntgc3SO3u0u0vWJX56K1aRqzi5bx6+cn7p36qqVcc78BWBgFlCT9uA5dxF8GFXwN1ICRbjYiNAqyeNJQ1ENjNj6V7LEMfOpVkgzuIgzX3aiZWtqBts/STulIPAQjKLmB77ns2qyoXRKj10TyGjVTFOlt5jLidiz3E6Nm+MWAxkQFPFLvpsYcsq92b5ZsN+P5m5+mYTOTXBagD8zx+TlRJiSjemHtTDvdEFpMbUTyznKJ3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXo0TEF2VmhPcEFkaXJqSXJLRGU3M2J5MllNOEIrMTRxZ2NFakdyZ3doTmFL?=
 =?utf-8?B?UXloUDlLd05nc2JRa05SdHlub0FFY2J0eFZwYStWLzN3czEyd0VPclRRaVNh?=
 =?utf-8?B?U2oyOE1wNHBBMzI2T3pMRmRJeDRRcTFWZ3hGOS8wMnp1bjBJOUpUemJBbmNS?=
 =?utf-8?B?MHhna2I4by9laXh6NEtHSWxuQ0Nob3lPWkpPVGo5VWl4RGxDRnIzc0RxYW12?=
 =?utf-8?B?MVhNMWNHSG5kenFYa1FyWXRCam02WHg2eFNUZ3ZyNldURHg5RmZtdkJySFBX?=
 =?utf-8?B?S1ZURm04ZEd0RUV0d0hZZ3g1b3R1bVkvODlDK3hlZWd5S2tlZzJ2Znc4ZDlp?=
 =?utf-8?B?aUd5ZXQwV29XOTduOFhQZ2grUWl6SXN6dWpkUTlUNXc0YlJBR3BTc2J0VC91?=
 =?utf-8?B?ZnV5ZmR1Z0tpOWJNVnNsaU1vMUpIOGcwbHdnU2FCK09NZDYzNFhmVXRwZ1pp?=
 =?utf-8?B?OHpJVUZMOU5mSk9HdnY5ZDJLQkpDK0VPbkZBMStTQksxTmVibzBselE5VlVu?=
 =?utf-8?B?ekF0djUwWmcxQTZBTnd3NC9WaHpXbEluRkxzeHJTOXhWbXJXaVhDRXFLaERQ?=
 =?utf-8?B?aDR3WWtDQ3lEb2s4SHgyRGFzOXYrdXBmYmJqNzYxOWExSy9WZythNm5zeFRj?=
 =?utf-8?B?N3lGb2hNemdydGRWa2xJTVNrZU1LVkVpejhxTjJwYnl4YlJOQXpubWRpZnpB?=
 =?utf-8?B?TDBraGZGME9YSCtTcXNJdXh1bXhlT3NSWXJCOGRtMlhod2MvMjRMOXVJc1pB?=
 =?utf-8?B?ZjFYSlJ3K1U2TVhOaElYbFZaME52Q1VnblA3Y1MxRzJLQ2ZzM0dTeWFJaTNL?=
 =?utf-8?B?ekcrMEN1bHV0TVVveUFVcDhOeFNYd3dIUnJIVndOTWhTck9wWHArVXZiZlBy?=
 =?utf-8?B?ejVjWFROcWZKT2NJM0plZUx0Wkx4WFM4MWgrYTZCd2N3T0doUnV0TldPVHJH?=
 =?utf-8?B?cUQ3cEI0aVZOSU5la0pHcUUzY3U2UEFmSmI5Vmhqb1l3TlJXa2lFL1UxdG5z?=
 =?utf-8?B?VmlLdGtacWFiRHZIQUN3LzlnSWNEUHVrakhHSGZLQm5wNnNRUFFrQU1Semx4?=
 =?utf-8?B?YStiU0ZwdHBQNnZxUWZ6cVVuZUZzM2FDMkFhN3FWU2RyTFZLNkRGVTlUUS9o?=
 =?utf-8?B?cnpZYVVOdnRiSHJuWlBCRDQ5alFISUhPQVI2S2Q4Ny9sK2NQVFZXZHJ1TXJN?=
 =?utf-8?B?RXRaQ08rRC9NV0RTWUpSOVBwRVB1NGlDaFpWM2QxbXJ0TUZLcU8ydkJnNzdU?=
 =?utf-8?B?dGhrYjZWb1VYaFAxa09MUXpYcVBxbkJyQ1Fiak4rbzhZVi9lQ2RsdjUwVDIv?=
 =?utf-8?B?ZUFGVFc0cGlBazV3SVN0QXdKcWlaallFTWFjUWtRcHI4UVVNZEtrSWh5Vjc0?=
 =?utf-8?B?a2lnUVJSaWNXaVNWbFpFYURCaTlWZ0xnUVd1NC9sL2drYmNaOEtKOUh0dXdB?=
 =?utf-8?B?WnFvc0UzeW1ZWkFnL0lhckErK1BIdlhTNWpZaytrNkQvQU1reW1qL0JFejBr?=
 =?utf-8?B?dkNOem5UdmN6aDR1WmV0SkxjWGZkSDVjNWRnYzJhUXduOHR5eml4YXlBcjZF?=
 =?utf-8?B?SmpjcnU3ZVFhZTA3UjkwdVNkS2dlVHlwRVZxOSsvRUh4aVAwNVR5eUZ2NU1V?=
 =?utf-8?B?ODNncERJK3IzSHowSzRtU3pKNUIxejF1Mk9nZ1FoL1lweFNiVDFhWEt1Y3l5?=
 =?utf-8?B?aDJxZ29sOWlFMTVpYkFxYTk5czh3RTNxSHl3UGhXd3BGUW9Kc1JoQVltRWxp?=
 =?utf-8?B?OElnb0VnaWhzNXhnMGRBRGJ0ZzBqdm1MbnIyb3ByOHc0eVNLWmZ6K1RuemtY?=
 =?utf-8?B?MUN6Vk5BUVgxWFEzSW10RHdOZElaL0l2WXB6TDFXN1oxckc5Z1lYWk9PVnpj?=
 =?utf-8?B?bGNnMkM5U2liUDhmY0hVNXVEVzZPK2trcUREaXgwcGNDK0wxRHRFWWIrQnNZ?=
 =?utf-8?B?d1lPU3JZQ3V3RWcwQ2Z5REtEOUJIWUhMRzlUMGlYSksycHlVTm1xc29mdXNL?=
 =?utf-8?B?VTE4eVdnd01Pcm5iYjlTMzd6RkZsMnNIU05CSXJ4Nm9USVhNYTRZWXVwOEh5?=
 =?utf-8?B?bkxOU29TT2JuV3pZWW5BNFlvM0p2OUo5VGNTMTRPc2xqK1hPQnJzNkdKVkRN?=
 =?utf-8?B?ZksxdEc5L1ZBZE15MHZGbzkrSFpCRWdBUjNhcFRjbUt4T2gxR2JNU2xJSG1v?=
 =?utf-8?B?bTgvWG84MjZ1d1JiRE04OTBiM1grZG1DdUI1WnVyeHBnOVN3R1p6U0dzWCtQ?=
 =?utf-8?B?YmF4VnFueitFMExpakZydW5PNnBLdStQUWd2emZpMHNzSHE2VWlqMkYxOFp6?=
 =?utf-8?Q?DTRtzxX3a1TBOUvyRF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5edf1d-852e-4d84-b787-08deb3df510f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 06:41:25.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNR22yi8wv4czu/V+BxSVOL6kCNv/HarhtaX6QN1Y0jH7KF5C0bDfED+qYSAZpkc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
X-Rspamd-Queue-Id: D53A555F8C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288691-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.im,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Action: no action

On 14/05/2026 17:45, Alice Mikityanska wrote:
> I can put it like this:
> 
> udp: gso: Fix handling checksum in __udp_gso_segment
> 
> The cited commit started using msslen for uh->len, but still uses newlen
> to adjust uh->check. Although the checksum is ignored in most cases due
> to the hardware offload, __udp_gso_segment attempts to maintain the
> correct one. Fix uh->check and adjust it by the right value.
> 
> Additionally, after the fix, newlen becomes assigned and unused before
> the loop. The code can be simplified a bit if mss adjustment is dropped,
> so that newlen becomes equal to msslen before the loop, and msslen can
> be also dropped, saving a few lines of code.
> 
> This brings us back to one variable, drops an unneeded arithmetic for
> mss, and fixes the UDP checksum.
> 
> Fixes: b10b446ce7ad ("udp: gso: Use single MSS length in UDP header for GSO_PARTIAL")
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks Alice!

I will take this and submit both fixes.

