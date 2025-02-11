Return-Path: <netdev+bounces-165254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D762A31483
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEF23A460C
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A4F262168;
	Tue, 11 Feb 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CohAFyGy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFED24C69D;
	Tue, 11 Feb 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300378; cv=fail; b=D7EY29uVCmbz2aN3Ev2jpUIwCwU1Rg9x/DlPPP/Agmvhx5K/rGLp4z6o2CaxHbRup8JaQhaeVH9pzflvS2NvQW9eoirNFahwD1QERDDZTC1eQLKHLiA/8J+NWKdv2W45jnpH3d211+RH+L9VBzJrNKSAGvXy6PxarZIWRVLZQbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300378; c=relaxed/simple;
	bh=ukksR94T/H10DCHUvh2u+cdR82nkPVRaTcVpJdqBhAY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HPLpgMOonbwN7zaboxwZjRK59vLmPHSQl/XX7VtAlGkS+u3K5IrOvHu0Xn58pjslWQhF4nWki2p0p321CM4DpNa9ues8MIUXgAio8ZZ8Gof8kXCXrhzUE/icTzAMcncRVhJj13t+ka00ubayfcRAegKuRo8MTCH2JNzCtgvOmio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CohAFyGy; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3J9T/29A54gF54i8gbwMHGbC19Sj1fBxv1ty14g6FzLQTkaPw7q4macTwG5Ao7GuFtB4rdn28Vrm82DOxP6H4q/5rrI2qFeEw/BcJsyKFQ0FjQlcP79C6N2A7dC5NXHRovMLYR04pMIz3BZ5tvHxOT+HYn0/XkXap4kKVLRiTknCEBR8iqsCl3nzddux0+929eJtH6oI6gbRLiz/OdNCc4D2PjbQoEERUnEXhhqXm8erejYZyqCcFgsaUIXCRVT9YSoVdNvDD/okIh7EuCV5nOP1zkqXOoCVbDzoWyQ6ZFBs61QcPFpSp4XKwt46jy9jLLK/knsscjeOBu6k3YGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEOa3rV/Dyc4UPiyDTSxmZFXSdImfLUTnTZxaIixNFU=;
 b=IHI+2qyNItjtIf7aO9MPq0PciA/VuZDJyXqiG96LCZTyPCXbJ/Lw/DHoCgsy4OtjWnijJNfITWWtfdEdeWIdqiNDVDrGgv0Un78JcGVLHHjwgAU4Dvj5SrR8LH3Owm7xWYtTJUGl+P5Bkidd6VXsNZoNrsvsoxfD1GrWRYIHB6ScpTzQH/RYRzOMwoVllQ8eWUvJw1z50iZPi5pBraZrFt9jSzIumjXvhYRqftUVBiI+NOjVG6uYx7UCy3WBl6D1fenGEJEykeh/VZuBvJeXEMCPB0lG+/AQvzwpH8dpEDOpvPKYHoNY/U4PEYzlGfr80Q4RSk9Rk8yWg8iBUFVUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEOa3rV/Dyc4UPiyDTSxmZFXSdImfLUTnTZxaIixNFU=;
 b=CohAFyGy2L9GIFK2PanMjXHVgX4Jyh2kZHkHHpMg8MXWEYkFePRaTfTROYmBOCpze2UNsEZln5ZUJW0Hi4K7zNdhlhBnmocEAj6F1eW3M/U/OiijcbsCgWJEjwFRkbECDzx9YqRFoA2pVapOL+/Kk3wVYW9myHQ44mV3guW199cndK1wzqPWft6DGDGNB3FCPJvb2aAJIWTysGYqzxPYYAZPNpE7jYjK/gYC1jevFTybuYIX8afJ4Ajvg8dWd82RTNGh86wB3ispoSZ0O3wv8INJmXUHD/D+Rp3zvodS3ceY9FVWybMkF5aXHo/yvnjaUQS5eyXoxoXjxP3CeqAzng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 18:59:33 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8422.011; Tue, 11 Feb 2025
 18:59:33 +0000
Message-ID: <ee761ca9-5aa0-4f48-96b9-295ed2c444c4@nvidia.com>
Date: Tue, 11 Feb 2025 20:59:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Add options as a flexible array to struct
 ip_tunnel_info
To: Kees Cook <kees@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>, Louis Peens <louis.peens@corigine.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Pravin B Shelar <pshelar@ovn.org>, Yotam Gigi <yotam.gi@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, dev@openvswitch.org,
 linux-hardening@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
References: <20250209101853.15828-1-gal@nvidia.com>
 <202502110942.8DE626C@keescook>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <202502110942.8DE626C@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00006637.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d4) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: e9527e17-f029-4510-4982-08dd4ace3877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2lXRnJNdENuMGgzUmRaYTkyZU9tUDYxQzFiV3ZPSkR0YktTWXlVRXRkMEpj?=
 =?utf-8?B?c2RwV28veUp0VmtuanphOXV1MHBxTUxaOGRMbFJ3WE1tOU54MjVUR0V4WW5Z?=
 =?utf-8?B?VlI4OWRaSWVxK0JxRXNYeEt0RkJvZkJNenhRcGVFV01WR3BYdDJHV2FVMG1p?=
 =?utf-8?B?V1pLNXdmWDZ6Z0ZzSFNsd2NtWFM2NDFEUWt3NjlzK0FZa2xTdURnUlcvTUll?=
 =?utf-8?B?Z3NuK2VVNzhWdk9lSXhZdlRxTHJ2a1BVOENLYmplcTBpRVVxTkFHaEk5dW9z?=
 =?utf-8?B?UjVERDRkdUtCeWYvUzVLYkdzTU9zcC9zaXdSVFUzQkRoKy9RVElkcGx0c1Rl?=
 =?utf-8?B?b0dRYi9Xa1JyWEVqRzl6ODRhTnhMVk5tQ2JTNklGdnZjeDZlVXZWQWoxcnBm?=
 =?utf-8?B?TGV0azJIb3k5cFJqTVlpaytVak53YzFYa1BwVmJ3MnVOZW5wTFJjRzdRclAr?=
 =?utf-8?B?TURqcW5LTGhaQXJVMEk0cUR3cUxvSEF4cTJPUHI1YS85VVhTRWkyZzBRMXJR?=
 =?utf-8?B?cDk0d3pOL0F2VUxHajdyYXV3Um9wVGxMOFErREVYU2xkM0owTDMzcmlwT2R5?=
 =?utf-8?B?VVQ4a2VWaW1EVThiVGpVVGYwQ3JEekxId0p2Zll0TFFOdkFGQkZYYi9KT09J?=
 =?utf-8?B?TzMwMW12SGNwbTdlQjZkTXcvRDNSb2hkME1MTzJsQkVoQkJDZWRHOU41SnZY?=
 =?utf-8?B?S2ZxbTV3MVlCVmJweXlGY2JKanRKZFdTU1RhbkJMZWVFY0N2VStEVE1ERGlC?=
 =?utf-8?B?eEhVTGFXNm5TQTNGVWVIbGwrSDBqL1dYb2pQdFJDUStISGltWWZraDNJZ2pz?=
 =?utf-8?B?blJBNTdRT0NQTzVRajM5ZUZlYlgvMlgrMW9zRzgxMGdiWEF1WE5SNERLRGtN?=
 =?utf-8?B?bUV6YmJCVWx3V1c4WlJKdEZOb0FOM0VxM1l0by9kdjZjTkIwZExUa2puVjRY?=
 =?utf-8?B?T0Q3cTZPeXgyQk45N1hVaE0rOEVHTDg4VW1FTmd5NFI0WEtZZzV0L0VKdzNZ?=
 =?utf-8?B?Z0wxY0gxc0QyMW1qL1lESkVaczR3d0xWTGxrUlBmWFJCdnVlS0FZYnBuWnhJ?=
 =?utf-8?B?Zys5dk1jek4vSkpEYXdCbEd4M1ZYZ1pWSGZCTWRCcklDbHF4S3RqL0ZMcklt?=
 =?utf-8?B?N1oveHJwSTBHa2JtU1g5QnVjeDVEOG1nK2RwU29HaE9md3VuKzlJZlFpWEJ1?=
 =?utf-8?B?V1N1ZThPbGw4YXpGQUF1UkpleW5TVXU2ZUJDS0pUQ05TUkYrbnZBd2R5Qk5v?=
 =?utf-8?B?UDJjdURiSTZ1SEhaNVlvQmZORWYxczQ5cmJ6anRSaWFSYTRGNlY0ZEI5YkNp?=
 =?utf-8?B?UVdPaEhaWEUvR1MxanNYaldHa3p4QjFNTXl0YkE2bjlENWUzTnNXNHgvM3ZR?=
 =?utf-8?B?OUZOUTYySWdZTGtUaHhwbXM5d2ZDRzh1N0d2Ky8vZlFCUFFia0tVSGRNR20x?=
 =?utf-8?B?RjErOW1TVExiWENvN3ZNN2M1Y25ocDRyMEtJdFRQZUFHZEVnaEY1NVVUMkFh?=
 =?utf-8?B?WFgxZVRyZWxZQnVQUkdqYTBzTjI2eWFoRnRnZzBCQ2J6ZXlXbExldHRMVnBs?=
 =?utf-8?B?dDdlNmF5Q0pYVkFjRFRITUgrM1pob1J6M0lUcjZtSFRWeHdzSCt4U0wzaE40?=
 =?utf-8?B?bllWTGg2TkliYzF6NmoreXhQWHlHcjhDSGNURHlNWlJyNjNkT1BKSHRiQkMz?=
 =?utf-8?B?Y2lwb290NmJxUklQeklDTTl1TmlMRjFZcjJ5S0NEaVNoV2ovRkFoYk83OWgy?=
 =?utf-8?B?OG1uZEtSbUlVUkNGKzMvT2NTZGpVNTg4K3JEbU5kSTRzRlVHY2xvUmdYUUp3?=
 =?utf-8?B?T3hxTEhIdVQ2TDlyWXA4UE9xbGpmQjcveUxQdUsyWHFHSlhBSHpvTkRxNUtY?=
 =?utf-8?Q?or1p2h2HQpk9p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVphMytvK2VZUDJGcEN5aWlJSmlkeWRBa05URWhUYmh4bnNkcXhxcWxiamtj?=
 =?utf-8?B?dUphVUV1QzAwb2tFdUgwSTUwWGFwMFZjMlg4RXdWdlJUZXByUVlFZk1Kak1E?=
 =?utf-8?B?ZTZaSGlub0ZoN0pRQ1hWemtSaCtwTmJMTC93dUwrK3NJWDdqOFFnS01XaXc4?=
 =?utf-8?B?Y2JnalJDQmIxUkhsUVI0MU0vcFFWUy9XL0M3ZzJqSGY4UURpZFhGbjN5bG1h?=
 =?utf-8?B?MTUwWm8rR3hIekR5UDFCU3BPZGVaNnE5MHZsU3cyNk1zUjBocGVuUjJhazFz?=
 =?utf-8?B?TWNJSk44MS8yUDd2TjBteHFhaGk0Ui8ybHQxN2ZKWGVIcUpNT0N4ZzRVRmc5?=
 =?utf-8?B?R2NscUJKZzN0QkpidGpiTWJYMzZBQklCelRUdnoxWGRJaFNLNlVBbDQxOFY3?=
 =?utf-8?B?WENicVlwekl2dnVUdWRMaG1CR2VwNG0rMkJxVVo0aE5lSlpLQ2d5R1kxNEZN?=
 =?utf-8?B?QzlNcUVsV2VOanFMaUphb04xaUpyR01RMDJETk9xWnJST2dIUmdtSmUxSTZy?=
 =?utf-8?B?OG4xSTEvWG5QRTArNWJJN3YzTVhvUlZ4ZmEzMXVvZVhwbWVSeGYvL0V5NE43?=
 =?utf-8?B?d2hqaXM0MVZ6WjBUVEFKdGpWZllyM2tLcnltUjZ1S0tpMUJjUGhsMHM4Mm5L?=
 =?utf-8?B?cGpRdlQyUURkdDZQNDZTaTRpZ2x4SkZ0K0NDQkp4bWJYUXJySEc5TUxKQlRl?=
 =?utf-8?B?THQ5NG5nWjU4U1hvSHZWakROQUlnSjFHV1lCb2JBSXc3eU1vUm41ay9IOTJL?=
 =?utf-8?B?cXJsQ0E5WkpmblI5Z0pvbkMyU2lxOFNtcXRXeVB1blFROW5OZDR0ek10Q1pr?=
 =?utf-8?B?Q0d0NW5WZHVwK3BkemJtek1JR1Yyczl6ZlpGSnRBcjk5WHkyY3RicEtTOGhJ?=
 =?utf-8?B?V000alo3WmRHN1BkZ2Yxa2dsYTE1eUpHR0FnQXVJOERETVBYb1dwMnBiemp2?=
 =?utf-8?B?dzljbHRKNjcyWlhTdCtYVTJ3VHhMVUR2ZkljYU5NeFk0S2R6dmw1ZWdNU2tS?=
 =?utf-8?B?MXQraEJlMkpwTTFuWkp5V1l6cktwM0VQRTA0SXBISDF4bjBIeEQ4ZzB2QUt5?=
 =?utf-8?B?OEJBeUdXeVg0K25EYjNlY3RwUmFrcWoySWFWVE5KSXlSNGRpUlpibnNXKzdI?=
 =?utf-8?B?eHhua1orRWREK1NvT2o0ZElNMCtWQmJia1BXRzNpaEpLa1lMMTh1Uk1Od0lZ?=
 =?utf-8?B?U0N1cEZ4RFhKRTdpbjlSU3ZpN2JZdmRnQmUrSVVQZ2NnYklCWVRhOTFlSUVB?=
 =?utf-8?B?ZmJmUEpySm1JQ1JPSTVjYkY4MHQ2TktvNUxlS0ZTMnRWT2ZyeWZVb01zODdF?=
 =?utf-8?B?MDFxUjlNTXdaUTZ6ODJKVVpmazhRTHR6bzZUMWRmRjdOa1k1b2pGUDBwYmJB?=
 =?utf-8?B?R3l4T3kweGhCL0dsOEpYUThFejhIYWdZV0VTd0ptTDU5blJTQ2d2LzRMazBF?=
 =?utf-8?B?YklDNzF1R0t4S25oTGx6ZnBTQjRqL2o0dDVHbmxDWFdCYTd1dTl1WXZEK3Bs?=
 =?utf-8?B?ZU9WU214eWtaWVhzZ0liek53Nk52T3VDV1VjZWFxWmpCK3pJWjIxdG15NVVi?=
 =?utf-8?B?MXhlZzJYWmZSc0Rtb1lFb01BOXJZcjlPTzhaTTdYTk5xQTFhTEc3NS9VZ1pw?=
 =?utf-8?B?L3Q3RnZqZDBYbFpJYUNOUEhvT2Z1aEc4d3oxTE1mWm56ZzFHN0FrYUVRMlZF?=
 =?utf-8?B?WGtsQ3NvYTJ4L1lnUTFicjNpY3lUbTBpQ1A1S01GYWQ1VE5haG5CZGhhWVBM?=
 =?utf-8?B?YnhXMnJoWHBrcFFsZjQ0YXRHUWVHSjNWc2ZJN0c5VlNGTHFPWTdMdnJRUU9K?=
 =?utf-8?B?OE5aMkFWd3l5c2JodmNmNnhTZ2F5cHJvbVJSM2MranFMODB4ajF1Z2M5Y1lu?=
 =?utf-8?B?YVpITkpQVWFzRVV3cmNmVko0eHFjRndBK2FhbkpqVGs4eU5HdTZFMW8weXY0?=
 =?utf-8?B?YVNnUEdaalRVTzFRN2phRXV3TEdnd1A1YkQvRTMzKzFYREJseDZqRlVZRkhP?=
 =?utf-8?B?RFI4ZkZ6bWIvTlBoTld1N3dvK2lmNERNUHd2WXFOVEhGTE9WSDVNa0NWVUpZ?=
 =?utf-8?B?UU9BdXcwaHhEeGFscnJjT0I5MzF5M3c4YU1FRXhZU2p1ZEtFRzFoSEFJWDV0?=
 =?utf-8?Q?5zgXDeY6XaN3ppZ6blUmXKB1V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9527e17-f029-4510-4982-08dd4ace3877
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 18:59:33.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhShrQTWbpGAgFI+H3b4WuLJlYtMxwgaHiocv+0j7yfJ0ZAeRWRRfH94fO7CR6HO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172

On 11/02/2025 19:49, Kees Cook wrote:
>> @@ -659,7 +654,7 @@ static inline void ip_tunnel_info_opts_set(struct ip_tunnel_info *info,
>>  {
>>  	info->options_len = len;
>>  	if (len > 0) {
>> -		memcpy(ip_tunnel_info_opts(info), from, len);
>> +		memcpy(info->options, from, len);
>>  		ip_tunnel_flags_or(info->key.tun_flags, info->key.tun_flags,
>>  				   flags);
>>  	}
> 
> And I see info->options_len being set here before the copy into
> info_>options. What validates that "info" was allocated with enough
> space to hold "len" here? I would have expected this as allocation time
> instead of here.

Agree.

> 
>> diff --git a/net/core/dst.c b/net/core/dst.c
>> index 9552a90d4772..d981c295a48e 100644
>> --- a/net/core/dst.c
>> +++ b/net/core/dst.c
>> @@ -286,7 +286,8 @@ struct metadata_dst *metadata_dst_alloc(u8 optslen, enum metadata_type type,
>>  {
>>  	struct metadata_dst *md_dst;
>>  
>> -	md_dst = kmalloc(sizeof(*md_dst) + optslen, flags);
>> +	md_dst = kmalloc(struct_size(md_dst, u.tun_info.options, optslen),
>> +			 flags);
>>  	if (!md_dst)
>>  		return NULL;
>>  
> 
> I don't see options_len being set here? I assume since it's sub-type
> specific. I'd expect the type to be validated (i.e. optslen must == 0
> unless this is a struct ip_tunnel_info, and if so, set options_len here
> instead of in ip_tunnel_info_opts_set().

I think all callers of ip_tunnel_info_opts_set() do it right after
calling metadata_dst_alloc() (except for bpf_skb_set_tunnel_opt()?), so
in theory it's probably fine moving the assignment to the allocation.
But TBH, I'm not feeling comfortable changing this, many flows are
affected. And anyway, this should be done as a separate patch, unrelated
to this.

> 
> Everything else looks very good, though, yes, I would agree with the
> alignment comments made down-thread. This was "accidentally correct"
> before in the sense that the end of the struct would be padded for
> alignment, but isn't guaranteed to be true with an explicit u8 array.
> The output of "pahole -C struct ip_tunnel_info" before/after should
> answer any questions, though.

Thanks, I will attach pahole's output in the commit message.

