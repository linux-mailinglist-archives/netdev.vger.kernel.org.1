Return-Path: <netdev+bounces-135267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C4299D3D5
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1547A1C25C8E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763C273176;
	Mon, 14 Oct 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZeLXxg6y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E25231CA4;
	Mon, 14 Oct 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920875; cv=fail; b=n48YuRCTYGOOK2SjG9AwV2z17AQPFxZuC/m/J3FfkXrqtXBKztXcunRVmhrE7AKAuXGQOOk1wCdQMEjrRxROF9UiBE1gl6VZkaBdVwQRhZEoSZ+9stO7X5w9f5m0uHdexu78yJTQadj3a0xicXqg2hSTFjRfr3pCTG3zvUXHICU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920875; c=relaxed/simple;
	bh=Gk8+h4selA+rrDnS7uukGR+X0vMjTIffO0f1qrtP484=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=prxx4lJVQGnrTtBQujhGeig4OHHQpkTgOIKQU/yrxlm4NdAKzk9T0C/e+HUUifEfLYo8USko6NOm2A7SN94B7yyWvLw+8HXhymrZvM7gviPjbK6xNn2QYFiDoEp1Wsi8qVBaydvbu2FqMV1PvrANuIpecsZWdOSWjFqJGJ1dZWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZeLXxg6y; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQ2YYAxV1v/XaP/9nZf+Ko12NUb97eARWiItQnahAqXnFQQox5kquIEaiqUKOmFaFxo+xn/X37hQXkLYsK0MOGPNfpMc4Na7HYSxSHc++Put0/fmUeqvFCKKNXgCTP86F98ZD/75XIGMEVSM3tl1ud+kDHfhTgMP8UAU9x6fluMyYLV1vSvzKYEzEueaD69te7xG8eKvMtKPVTbL8VHggTPOBdAQNXo+Gb6B5FTfJDx3rK+rzt+Sg4UDF6ZLhW27dwOdAuziHlr/SXZX3SdZjPBGy30IA8RKtKT9Lyg3w4uGA3RbDWkjFrzDog12sSs9CEYJ2zJDUx5/HnXC15MJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY5Z1RtooD/H3ULgi8v0qSRFV7SZI878MyN+LSLUhls=;
 b=ZFw/GmWTYcIFxqmlQYDsUt42DENJIhAQIyO28coidb78Tojd6vXcYSzh+dNu95ITaCZBxD5iMkRlwt4S0KVu0Ag8bjzFgMjjyDZXoa/qJ0/L1Sc6Rcf+b3MHkLigtJMhAOh6RrwQUqrMxUyFM7Wofhv6Em8oIx05fAJK3fvyEWfLRZNMoOmb1qIBwt8ZYvU/m+o+VvYj+9b+a/BkFk2axOyhLPCKMpn4cpThV8a/qzQacLBfS/PIB0SYTfQ3789erHll8PGOKBjKF7Oe97Kd/qsHPs6Tqew3ufZjHTOQ1Z1n9s2oduwzKVHnZ6LtjBzoSPipixZhgDd7D+dNYH4MWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY5Z1RtooD/H3ULgi8v0qSRFV7SZI878MyN+LSLUhls=;
 b=ZeLXxg6ylIRe/mwCm7kUSia2spFWSgc975FNjvJ5OBGH+7vgxbej26qBDwoPLjGCDZvAG2NWHxh5LcPWFjwYjZAsSJQwlb4j3P5xP7jaKxHA6l2n332K0iW0uhrPfCIapODEbOJXaxlyWxAWlnnheC4621eNLTs06BTEmnz3Yg8ikD574iux2xUIUAjgKP9hsl2g4B+eAg8EvZpPXPzOtkL4MIEoHtFSCuu3EqV+z9O1Pv0XuyLJ8MjP32I/bo/H+r5IKNeqCIn/Sk4wfEDm5IKxnx6gCmliJECaCs6k46t034mo80fIiDkmmI3p/VeKa7GBJf4VR/Ts7cJ80uJMDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 15:47:49 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:47:48 +0000
Date: Mon, 14 Oct 2024 18:47:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 08/12] net: vxlan: use kfree_skb_reason() in
 vxlan_xmit()
Message-ID: <Zw09Gs26YDUniCI4@shredder.mtl.com>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-9-dongml2@chinatelecom.cn>
 <ZwvAVvGFju94UmxN@shredder.mtl.com>
 <CADxym3Yjv6uDicfsog_sP9iWmr_Ay+ZsyZTrMoVdufTA2BnGOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADxym3Yjv6uDicfsog_sP9iWmr_Ay+ZsyZTrMoVdufTA2BnGOg@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::14) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 177ac69d-059c-418e-60ef-08dcec678d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkUxRDBlZ1VLUHllT2tJcjNLek1DK29ld2Z1VnlWb3pxOVRWZFJtaHpHK01u?=
 =?utf-8?B?RnFsOGFVWXZDMG8zV0tBZHAzTmZyaUc5OW00VEFtdmNrM3lIMkZXWFR2Ymk2?=
 =?utf-8?B?UDY3dUZmc3h1T2NMa0lUSzRHVUVDK3IwS1FXdW11SGxXWWkrSHdiY2l3QkVi?=
 =?utf-8?B?VUx3blJSc2JaT3FXUHBxaGNWZnU5Mk9GTmtMRVIxS0pCaHQydnhhVkFhS1px?=
 =?utf-8?B?R09SVzdkbmFNcXd5MGRUZ2hBTEpJcVJ2R09XazhsZDJvK3kzc3g4V3JKVEVG?=
 =?utf-8?B?aXNEVUhiVm44dEcvTVFyTjhKcWZmd2FIQmRYOHdQb0xnanBIUk41L0hrR0xW?=
 =?utf-8?B?MllWSVVxM1VucFFRWFFJdVB2SDkyZllkSzBScU9nTjAyNi9FWTF2NVJGWER1?=
 =?utf-8?B?UFZGVFp4VlEzYmdoK0U3RzJhK0JpcUlnWlZ4KzBnZUtrK3ljQk9XYlhvS21Q?=
 =?utf-8?B?dVFtRHdJUkFqYVBIZy9ZdWZFbVg5VkpYL1MzQ2JnaGNOV3gyY2ZOMTErbUNa?=
 =?utf-8?B?UnRaVUp1K3VJLyt0YUJTZlRVc2FaNGg3YU9RaW1qRDh3V2xKVEZmZlNmaFE5?=
 =?utf-8?B?UUFzalAyVnh3Y3F0RWVnZ3lsS2h2UTBhbHMxMi9sRTZHRUV5bjJHQmZZQmYx?=
 =?utf-8?B?MkZjOEtOTVYzb2ZleWtiS2c3aEtOTFZWNHJ4OFFXTFlHY0xJNmxTLzJCTkkw?=
 =?utf-8?B?Q3dEM2g1dCswTkFRMUk5dElqUWplem04bzlCTS8xQ2I1aERNeWJ6T3BvbVha?=
 =?utf-8?B?VXpoWlQzK0ZtLzRxdG56MFdPSWRmbVpDTElqbm14NC96d0dub2xubzhNUUcz?=
 =?utf-8?B?bnZEY2pMWFkzQVc5SXJDMWM1dXcvN1pHTFhkd1p1ZFYyZTQwdDZyY0FkN1Zw?=
 =?utf-8?B?Z1BnVG93SndlUy9aN21QZDZvWnhNYVpFeEROVVNLZG9IVEQ1L3JsR1VzcXZ6?=
 =?utf-8?B?OE5mSzIzN2luRE1OcDNvTmdYSmdIMVVvU3kwQmdJZTZQNkp0a2hJQkhiNUNF?=
 =?utf-8?B?Nk4wN21qK0lTZDFqNzExYWtJYXFnTzdTV1J1UDZaWFNtaG5pY1RrOUhtZld6?=
 =?utf-8?B?OUlQZ0tDdGdabjRwRlAyRzVBME5mVzhkb0poYzJpaGo1SXMvU3cwdk5VaHZn?=
 =?utf-8?B?UjFxQndYWUZ3UHVaaEZ0NURVcXZEOWxHWlBzRFkyb1YxMzBNMzYwbFozWEJ4?=
 =?utf-8?B?Y3BIRFJnbGtpU0c1RFNLeHEvMStNUjk1clhZSytyWS9NZlJHcXlKWEpuY3Zl?=
 =?utf-8?B?a09xQ0FQaDU0T2FidzhmQ0d6QU84Y2FpemlWK2UxZGxxNlRXVHZVZzZBZ203?=
 =?utf-8?B?ZW5veWpzYTNPcVloUk4rS0FtcWNHeXM2V3Y1bDNrZTB2TVpjemx2OU5mVDhu?=
 =?utf-8?B?N0RrNkdvU0JSOTNaSUhXeWxyNDY3OTE1bVhJc0g3SVlwNHE4ZVlHQ3NOdWdk?=
 =?utf-8?B?SGRCeWNUbVRwdnNxU2FBTGtxYUZHS2hIVUJJcVMwTUE5TzdvRDZWdmR5SWFW?=
 =?utf-8?B?MWYxR0d5WFB3cTNGNWVOUzdHczNtY1hpWXB5TGVKVnpXek9pRkpNWEJLU3Bv?=
 =?utf-8?B?VU9rbFBWVDlBdkNjbGlwVUR0UnUveFl3cHpGOEFIdk1MVU1IWktMTTRrdU1C?=
 =?utf-8?B?d0xrT2NuM0t5SGdPc010TGR1ZTN2UHZsdDZ4QXIxRlg4UU12TjlETnM1ZVlY?=
 =?utf-8?B?cnJYOEhtSXdkdno0NDhjbUhSUnd4QytVdTduclFmZ3V6dnk5RDdxWkNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2NGYkZ6SkxxY3Y2aDNLZHpqOWV4dDhRdG5BWVhhZ2RNVE4vQkhEQVdEWDF4?=
 =?utf-8?B?eGpNTlFMSUhEL0ZJQ3BqS2JHMThaMGVTeVRBSHZIMzdVNUZYSlRjSVdnb0JF?=
 =?utf-8?B?Z09LOEZHa292MTlsQ2lXcnhIek9CN1ZJcmJ4c2VZeXFoZU96VENlRjcyc2ZU?=
 =?utf-8?B?RmE4R1U4WFlKWjhiNDYzR2JZRmdKYi9LZmFBTVRiRnVmdms5SVB0aldsQlFu?=
 =?utf-8?B?cDZXOXdJLzVQZmpPUC9LY3pYbThYVDcwaFp6L3pqVVlndFNtY1VjTXgrc0ZU?=
 =?utf-8?B?a09Fcy8wWHJRZS92OWxkL05SZlBaZkh0NVVMN3V0ZHNZQjJYZ3lrUFFPbzY5?=
 =?utf-8?B?RVhQNFFoNFN0KzRhVEVMeXg3KzNxT2dtRWxZRkRHWDhhYXZjQk81ZUUrdG5W?=
 =?utf-8?B?SXFYSThQUERvS0NvWFJPS0FLcEZPNWlwMDljRGJFUlBzYWZqT1pYYkt2SEk4?=
 =?utf-8?B?UUhZODh0R3JheUNlZE9kQVd2cnRiaWtRTXlsaS9TUTE2UHA4amZNUnZIdDlo?=
 =?utf-8?B?dGhObS9YMmNUMktUck1UMWNFdm1uK0tWbTZkKzFNZEZIQ3N0My9Na083QTdl?=
 =?utf-8?B?VmNWMjZRVDJHazA2d1dPVk03TG5Gbi9xenN3cG1HTHJFMFZJOElTdnNIOXB5?=
 =?utf-8?B?QUp3V2MvaUxnYjNYcEVmNjE5dTdHeU12SjFvazAxdEhIc2ViQ05GU3N4MTlj?=
 =?utf-8?B?a2NaWnhUNTVMUGRRWW5mRFl0M29wRSt2SHRQSWdYTHFKeWhDQmpMY0RkbU1Y?=
 =?utf-8?B?dW5ZRGtZckMxRll6VGZPYVExOEpTeW85Mm5TL1Q0dFNybk8wb2s3QUZjOTl1?=
 =?utf-8?B?K3VFVmVnOU82dmVBc0RRNDE0dWd4VjVlUHlXWEQrMWlZcnNkM2hwcGZEY0ZW?=
 =?utf-8?B?T0N2OVdnbkJnTFJTbkxWMnYvUUlOT2ZKR3FmNGpyeXlpd0RuVjJ1TkFzRXNL?=
 =?utf-8?B?THliU2dnYVFhejBCRFc5NnY5dDYzUERtdGI0RnFIN3JMNVBqb1B3WEFDQmMz?=
 =?utf-8?B?S0NFaVhaRHdCblRKT0ltQU9uZHpQS2RUeWtPMjI2azI4S1R3M3VTeStLbkpK?=
 =?utf-8?B?eENsdE84QjcrT1NnNmlUbURnYjU0Y1gwb0pWTXpTak56T0FwazVyelRGaksy?=
 =?utf-8?B?SHZvK1pMTmd5dllZZ2pDb0Fhc0JUYlc1MS9FdHFmcnZ5T0E0emZ5Y2kwZVhn?=
 =?utf-8?B?SG1oaGJhQ3IvbkdtQXpISWlzNGdJSlVaY2M0U1NWRE1HdlYzVkJOYzVHUzhC?=
 =?utf-8?B?UUIyZWloMDVteHZRNWQrbkFmWVJLKzI0VkR1WHJ6emIxY2ltT1VxR25QVVA3?=
 =?utf-8?B?RmNiOEVYdlBySlh1WS95cUtoUFZTbmVmdnR6MkFHdDh1aXE4SVFxaC9ZakRZ?=
 =?utf-8?B?KzdaYkUyeUQ2WHV1WkFHR2xUU2F5dW9hbmZsU3EyU3hPcTNoLzlBUGs4R3pt?=
 =?utf-8?B?S3Nub1o2N05lSVcxZitLc3lpOVhJMjkwUW9vRjdiL0NpZ0FUdjFhRGg5TWo5?=
 =?utf-8?B?QVhxTDlySnJJWmVRTWFCbWhZNHBWWnZpTFpCOEk4RGJWUGZHVHgvTTdVQzJq?=
 =?utf-8?B?Y2l0SlVlUjUvM2VRWXU3OFZrdjRXT2xrZXpjRkxhK3o3NlFSS1p6andMUWVB?=
 =?utf-8?B?b0ZBWVBtZUFmVzNJdGdGbGV2UG8wSzd5OWVmdllXNGJZZHgvejNFelo5YVpO?=
 =?utf-8?B?cllSSHIxdDNRN29vQXBFUlVQQVZ0K0ZIYW5PUWxLcjg2VXp3VVZRRnJJZlF4?=
 =?utf-8?B?dEYra3k3QzVLdUtkOU4raXJsdnBzQlorcHpyakloVU9yakEzRzJWaU5za1Jh?=
 =?utf-8?B?L1c5a1BpOVRZR0tYNGpVQS9DSW5FZHI2c0RhdUtPWTRhZkIyeHVkdTFFdHpn?=
 =?utf-8?B?bFpXbWl4MWZxUTZ2elJTeW9raXFmRytTNHdZSzR3dVpGNXczZDEvZHJSRno0?=
 =?utf-8?B?OU5TQ28zRjBLM0picmE5MUhpK3VwcFQreWZwbGhRVzA5NHA1dXdlUzNWY2lp?=
 =?utf-8?B?eTdKTUJRNysrQjVhR0NjS3JBRGxCNm8zTXdSRkZQMFB4VWRDTGVwZ0N3S2FN?=
 =?utf-8?B?cSswb0RnSEdCWDU3OGhkUng5Rnd5UGVFWmZKcUMzUW9QR0l6Wk9sRDgySmhB?=
 =?utf-8?Q?VOI8LY5buG/fGqn7YgskRHwU3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177ac69d-059c-418e-60ef-08dcec678d69
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:47:48.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7f+8+JsjSMKu+8SXZWu5nWWojhVBjhAtuji+hmv10W9vRoU9BYYGYNs/iJZqgfe0mbWiUSDNFbPs14FtzmfRwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947

On Mon, Oct 14, 2024 at 08:35:57PM +0800, Menglong Dong wrote:
> On Sun, Oct 13, 2024 at 8:43 PM Ido Schimmel <idosch@nvidia.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 10:28:26AM +0800, Menglong Dong wrote:
> > > Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Following
> > > new skb drop reasons are introduced for vxlan:
> > >
> > > /* no remote found for xmit */
> > > SKB_DROP_REASON_VXLAN_NO_REMOTE
> > > /* packet without necessary metadata reached a device which is
> > >  * in "external" mode
> > >  */
> > > SKB_DROP_REASON_TUNNEL_TXINFO
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> >
> > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> >
> > The first reason might be useful for the bridge driver as well when
> > there are no ports to forward the packet to (because of egress filtering
> > for example), but we can make it more generic if / when the bridge
> > driver is annotated.
> 
> You are right. As we already need a new version, so we can
> do something for this patch too. As you said, maybe we can rename the
> reason VXLAN_NO_REMOTE to NO_REMOTE for more generic
> usage?

"NO_REMOTE" is not really applicable to the bridge driver as there are
no remotes, but bridge ports. I'm fine with keeping it as is for now and
changing it later if / when needed.

