Return-Path: <netdev+bounces-173798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D755A5BB56
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61A23B118F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749C422A4EC;
	Tue, 11 Mar 2025 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bfZ34ZdG"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497B22A1CD;
	Tue, 11 Mar 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683415; cv=fail; b=GrhHY0y2ly+lRzUUF1dFMp9MJgSMtoSOzixJj/aI4POTvOVN5F1IGBmUjiLyuKN/crsIMcQv/QZkVVyXrLrtvdwfsylX8/rYmoA+VzSi/sFTXMyEUrCE5mqujyMZdYMpXSQXQtpicMd8zI6I7xX9LPDOWaLp3q2cT3d71waxyUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683415; c=relaxed/simple;
	bh=geB5dBtbs9Ps4DRQTyoxoskZXtO+HC7X6rJRd2GHZxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k8TDNoSXhSKr88TW+D5wOw89Le9Axk/kxmkXeojKMuA1JM87gXF89iqnc0HeznDsQuuc4AHyozUq1KdF3Hilm4YrMP+4XJ4Y05o8/WKxmK9AzyXIazCgrqIT6XM68nXYDIUGns6G1pGyddmL/ouhwJlUmXhOTQnEl+XPYwY54ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bfZ34ZdG; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NW3EHu4sV/xUhJUplzY9bfqbYh2fjxgu6FFBd/OcFF+4iTKY7HyaGaSurCfmAquILyulnjr/ndP+oJrMxjAcNiCrODwnV7XqUVPoJIgiEkQRaUOD2L9kA+qilo3hw6FC9p/O4YflTa8j2LojFitduhVXaQueUOjI5UVw3QKZyqhSUUcu1iy3Fc+e8wzmQDDLAtYrdNB+IAE0wLum8PtX1VYAkUSCI+mqq4MeRYRgHYVE2ilP3tcVS+KRVeZIo37hMOFSzzyDDbBJ0DuyDG1QzYnAbfWY6DQ8x920uKnljcFH92Az8aEVpx9EvBmhyL+Ytwxki7iCvD5xyNruEh/HqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geB5dBtbs9Ps4DRQTyoxoskZXtO+HC7X6rJRd2GHZxQ=;
 b=nC0Btsr2OCeg5PnKLrbLz0bmVqtsHfI1q8yhA4u2gBq4B6saWHJ0fBSCSJ7KWzOaEIysihpbhlJt/hRmvGjRVQAqU8owRVADwQIZPa5x77w5B5Te4yDXhAIILlf4RAr/J0/kaMff8K246tAbD+9FODF1fl7necA0c+Fws1Zw6pPMQV2hYMJGJvjJxmHoaj+UeHMiVddJrYo3+3BBhjMt/7vl+TQuchoVG3jHyKrSMOPVjtVsQGuvZsmQ1zpfQvoCMAKkhBJQzhFqbc+fWTkyXntBytbX1gPCmuOAfwgn984IghVr+sRvUC5CdXVbm1VW3vdNMTgkumu3fqFK3uoPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geB5dBtbs9Ps4DRQTyoxoskZXtO+HC7X6rJRd2GHZxQ=;
 b=bfZ34ZdGl/Kf9/J1FaxawZI8q4DKz4fMUf8q9KA6piIYs8Mo0W209miMytUahXb1F5CSiiHC3jOusXdHTEaA+DYCMatvZBr75/mlW/p3ycOx0qv3ri6kCbIFyggFH+LPC9EscrXQkCpXMjzY2w6v+bah94qfHJP4flOrM/hKaT+RabjjdSlGKyYpZaPc8xl1ImFHTGPiKtSEUCpJ0GQEs5Ig+bMzvxwrOeK8o8t/jGRIX7CknF2k1yuGO1MmAjLzjhrhCTW/ewWDzyUL5A0AMnRQSLPJcxlI0MzyLD0GjMMGUJX1Js1om80MZ3jhae+Xq5l0DjK//cWkwUIBX1dIYg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM7PR10MB3793.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:176::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 08:56:50 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 08:56:49 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "jpanis@baylibre.com" <jpanis@baylibre.com>,
	"srk@ti.com" <srk@ti.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "rogerq@kernel.org"
	<rogerq@kernel.org>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: Fix NAPI registration
 sequence
Thread-Topic: [PATCH net] net: ethernet: ti: am65-cpsw: Fix NAPI registration
 sequence
Thread-Index: AQHbkkyd/vgmW1tIRk2UfG0M1eu7tLNthJWAgAAcSYCAAAGUAA==
Date: Tue, 11 Mar 2025 08:56:49 +0000
Message-ID: <dbeb0d830c41eefe127d13af55fbaf6243164b0a.camel@siemens.com>
References: <20250311061214.4111634-1-s-vadapalli@ti.com>
	 <421a4c67865215927897e16866814bd6eb68a89d.camel@siemens.com>
	 <20250311085109.q3g32v3ycoskhsko@uda0492258>
In-Reply-To: <20250311085109.q3g32v3ycoskhsko@uda0492258>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM7PR10MB3793:EE_
x-ms-office365-filtering-correlation-id: 3687c929-2b41-4b1b-86b8-08dd607aa918
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnF1Mld4RXh6VDdXYlgwRURXaFZPRUg1TUgyTjdncGdDYndVelIwdDNLazhh?=
 =?utf-8?B?YWNQSjN5OUpIYTdKOVR3V0czWVZJbzJOMitwSC9IbW1ScjRTclRRdGoycW9C?=
 =?utf-8?B?R0JMRHpJSW0wNjloY1ZCNkU0N0ZGUExjVGlaR3lZVUpNQ2NmWXdyKzhvUnQ5?=
 =?utf-8?B?NTZmOEVJdUlQR2k1L1F0em11SlZFOGlTSU96UE9GUExuTHpZUDkzYVJCZ1RH?=
 =?utf-8?B?UEQycERYYlRZTXVHbGk3cHdJRW43QzVhVUR4SzNyOEJ6eU5WeHAvWDNUbFA4?=
 =?utf-8?B?YlRqdE9LMFFoalN0WmJWZEVWZTNMU3FJMkZ1U3ZidXY4REZ3alNSQ3BjNXk3?=
 =?utf-8?B?S2QxTSs5RXhhYlN5NXpPUmM5T0NFVmtGREpPN3J3OU9kb2FiYmIyVmUyQ3N1?=
 =?utf-8?B?dlNmbGFkODVCYTE0VTVBelpHcnRLZlliUllrN3hJVU91eDZ6VzVLdFFDM280?=
 =?utf-8?B?QlpDamNYUlFXMHQ5MkhjOWV5VGRrSS96anlxOXRjRUh2SG1ROEZlS2hEVnk5?=
 =?utf-8?B?TFlsMjkyT0lCNk51bjYybWtwaW5kMTgvZ3dwUSsrcE5IcDNzWnhHZlpwRFFJ?=
 =?utf-8?B?NXVuZVk3YkpENU1HRlhjTVVKSVk3YTRMZTZiMzJxbzlBK2FOc09BWWdZL09L?=
 =?utf-8?B?WEMzQ1Vka1VheWYyYlBtc2FyQ2E4VVZIeTg0WEJjaEhGSHkybVlPK2JnclV3?=
 =?utf-8?B?eEhYcmlVV3JYQkI2cG0zQ1QvTFhBak9WRnJ6VWR3MjdhVDFqbmNLZWd5SGRE?=
 =?utf-8?B?Nkp3b2hlYm9JbmlOVm9ZYjFKUVJWNVhVRS9ISW5nRHRWNE1xOExsOXZLRVhO?=
 =?utf-8?B?TS9MdHB0Q29KZG1ZclZxT0d5UFNvZmE4OWVGV2dWUU4vdzkxbjNxNCt4cGJt?=
 =?utf-8?B?ZlZGWFNDRmkzbmRzeEdEdUI1L1MzSWJWUVlCaGtNUE5nVWl0NnJSaU9qelZD?=
 =?utf-8?B?Y1pBTDZxbC9leWlzQ2JyZ05DSGJ5TDZTNE9uQlVsZFprbXN6NklXTlMwZ3ZV?=
 =?utf-8?B?czlGK3hId2FiNmxMN2YwcGVndTNRUVYwalhJVHBRcmd6c042Q2hSclJDM25u?=
 =?utf-8?B?ZVVoY1lOQnBrc09tVHFZdTVJeDRUMHN2RGl2VHJMTUNqTWVkVEhSRlY5M3hL?=
 =?utf-8?B?SFgvRVg3WVpJWWw3YXZXY3Zqd3ExQTFFOHRucm1pbk5KRVJtV1NhZjVJTC8v?=
 =?utf-8?B?VVoyQWZDZ2NNWkFWNTZJSTdvUzNJeUs5ZS8zaVhSY2Myc3hiT3pId3VheUgv?=
 =?utf-8?B?eWFCbmdyT21ScHdQMTRTenN1NThiSVRUODdzN1NZaWNPc3hENjJYaG8yeVd0?=
 =?utf-8?B?WS9HSzhIajZiRUp5MGVLTXlHM1dZcUVDTWUzWUVVL1dxdlkrK2w4MFRZNStQ?=
 =?utf-8?B?c2lsY0ZObzlVL0kwUFJLZzZuYUsrWUswSUUvTWdNYVJiQjdJQWNPeldDUHJL?=
 =?utf-8?B?dFZKVnRHc3NnYVVyUTJUSFlGKzB0dEg0MlkrdCttNXlNd0tHRWhkdlBHK25x?=
 =?utf-8?B?QThvMFpMYWVydGI1Y25mWStYdlMrS1FxMEdxa1R1QkRlb3VtWUZxeWhUMXAw?=
 =?utf-8?B?bExtc0JXN3RFVS95M3YyYkcxb1ArQ1cxY2NkTGN6TDU0S2JqekVWMDRBVTY0?=
 =?utf-8?B?c3d3b1NkeUtXamJIZWZSNDFNb3gwVW1sR2tFWjJWWUJiWnZ0UG5nSjZtRWlG?=
 =?utf-8?B?Z2tDcUpUdFU3ME54MmVxYmNMTXg0V01CUTRSOG1CQllSN2F5UGpXZk1qWTNx?=
 =?utf-8?B?eExjck5kNTdjTUNBZG82SGRjU2VlYkoyMENKVWVjQURJVlhnT2pDaUg3WVpK?=
 =?utf-8?B?Ykp5NVJwbUJqZGtMK3ovM0JYVGFRSHMyY2NIczNKWDJsOEg1YU1pQWhVbTA2?=
 =?utf-8?Q?yJPKmgI+hHh8j?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUhzVzh2N2JGT3FPTjlPRUsvaFBxc1A0MG1zeVVUczRRSXBQQ20wNVNPU0VD?=
 =?utf-8?B?ejV2NXRFQlpOcUlCc1ZNbDAwaFhqQ3dGNUw4T3YzblZDVk40bW5TZVd1UUVK?=
 =?utf-8?B?ZlQzdHQyQWI3VUE3TkZIN2NGTWxHcFo1MGYrZThPa2N6Z0FtNTlQMmxMeStl?=
 =?utf-8?B?UFdtS2FBUjIwSzVYdWw5ajVMcHJPbVNpdUl4MUwzb1o3Y0krbkdERG5Hb244?=
 =?utf-8?B?Wm1oZEQvbTlHMjlmVXVGK1kvM3JwOFRtdC9tTVRoSThjSlBDTEpCNHFkWFlF?=
 =?utf-8?B?ZDd0WGtXbEJ2djFsaHZnVWtSM3dId3ozYkxLcmhDQkY4cU5WMDIyVTNDMFBM?=
 =?utf-8?B?M2FSdXUrUnkvNG1sWHY3NmQ0MzdDNHlFd3QzcEs5d1d1RWp0aEJXREgrbUlF?=
 =?utf-8?B?VkJ4NDFsbWRVWTZVMWJPbnVBSmxjYU9jOXBmQ1NVMEVrY1haUklRWWoxY1Vs?=
 =?utf-8?B?RDZlNlFkN21sWEJwYmlwdzUxZWlrWnVEalU0MlczTWVRQjdHNjlKQ3Axc3Zi?=
 =?utf-8?B?d0dBMnpGZGNVSVVOaWQyY1R6aHdEcWttWHRtenFwb3VZYmJmVkFRUzkySkxl?=
 =?utf-8?B?U1RYdXRpL2Vvc3BwVlowdERSUUJSMm1oREVRaVZGR2ovZ0F4UUdidlZGQzhM?=
 =?utf-8?B?TkxDeWVKMXRBMTg4VnUxTml0ZFNIZld0Qm56TEc3SnNaMEFINFhKWldqNXdt?=
 =?utf-8?B?djVGZGlWaGdNd1hHMTNXYmZPYlBzRmp0dEVMdEovbDlEbFVQZlRYK1JBMjhI?=
 =?utf-8?B?dnVFZC94VnZ3QWRqK0loNFlDNEJtc3FEaVFmT0cxVUd5ZTVwaEI2akIzVVNr?=
 =?utf-8?B?cFArd2xRUTNaTUh1Q2l5RVZPbXNWempjWjNETXRKZGhnR2FqcWIvZlc5dzFO?=
 =?utf-8?B?cXJSZUNkMGVnNkRxa3EvWW5UZDhTbmFkWEtKQmlpVU1iM1FqbWFYM1dlRzgw?=
 =?utf-8?B?QXY0UUY5V0lGcVJma3VnQTlvTDF4eENpQ1BuNmlzZ2ZudDhuRDZ4eXdaMFU3?=
 =?utf-8?B?MlZXY29CVUNVNjJNNGU0OXlDK3ZZUS9qN3pYalZkWDduNzBqZUxVNnFUZWxX?=
 =?utf-8?B?ckxPbUY2RXV4K0JreUIxbjB5MDJmWGo5VXhsMDZsanZXZG9ZVFhVNDUxY2ND?=
 =?utf-8?B?Zlh3M3M4dUs0MForWmUyKzJjeVp5dmhWMFNqNG45OTFlZFNVOFpqa2ZHRm9x?=
 =?utf-8?B?ditaNi9ESVhqZlUvNmE4emZQS0hvL2VMZHFWaWhocDBVcUdNVjVmU0tHTCtz?=
 =?utf-8?B?YWhMd05CUTBqNXIxTUVyT1NWNWZxWmdLc2thSWcvM2FZTUR0d2RpVEU0Y3JU?=
 =?utf-8?B?N0ZQTmpPbEQ0ZC96NWVvZS84emlzbGdqVC9taThGWDZSQWNMd0R4NFZHeWJT?=
 =?utf-8?B?RkYwQ1ZXa0wydWtiN3oyZTVEdHFrdWxnakdzUjFvQzJvUkQ4Tk9NMzc0dWM5?=
 =?utf-8?B?ZFR3RWtJZkhSa2ZYVHZzWFBjVDNuZTlBenRuUCtZS0JNNG9vNzJ3cU01Yngz?=
 =?utf-8?B?aGdvL0pUL0h5WXRlcUl4bnl4MHRieWNqaVRUakpnL1BxMXRnaU03OHpYSEEv?=
 =?utf-8?B?OUUxSUlHb3Z3ZTRFcGIzeTl2TUd6aW9BRDRLYTBqZ0UySjBHQTBTbzBoNWIr?=
 =?utf-8?B?eEpPQUhDS3M2aVV4bmRWWEo0MU9HYWx1cUxXVU8yVGZ3em80N1g0RnhpZjht?=
 =?utf-8?B?cXovTEM1OXpld1NHbFoxemYvZUN3SkQxVy81YmwxRlkrVjFPVVBNYnNzV0JK?=
 =?utf-8?B?YnJrOE1oeUNKMHl5RHlmdU1ZdGRQZVBnUzJSdzFZWGxPSWZtbERlQUhaQk5i?=
 =?utf-8?B?ZEF3aFZjcW1IQUtYcnFJTmFKQ3RPTVlScGlCZVdYcElvdlBOaDFyWmpFaW1a?=
 =?utf-8?B?VEZ2WmpYWS94NnY4d01WT2VNL0tlVlIxYjNhQ2UrY1p3bVBrbUNQQnBCSWdk?=
 =?utf-8?B?MXdRRnNHc09zLzc0aDlrTHRVaWNVTmpOZXBWYjM2c0pUZ3lBb0Q3QTZGWG5T?=
 =?utf-8?B?UU1ZRnhGcWJuZVdIM0pqRDI1ckNjK3hEWUFsZDBPZnN0VjJZb3dtL2djZFhW?=
 =?utf-8?B?Qm9LU1B3bnZMZFkzMnp2N2I1NWJxMDB6MHJKZXlGWjNidXBUQWlyQXRveWlo?=
 =?utf-8?B?TEhhQ2tJN0YzU0M0aEdodnNDWThWY1Z3bXROVjJYb1NzdGhBTG1XOFVXbDJ5?=
 =?utf-8?Q?fehWgU5OrJ64zNHABjPQ3kE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C90A120332434F4CAA1A2D1DFD8FB737@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3687c929-2b41-4b1b-86b8-08dd607aa918
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 08:56:49.5404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRlrFz0AoY8HqradvAgPvdWQJkqVwivlv8P5WFJFkZSCoeYN/e+Rcd5YF+z5fs/ovpDWG+HR9wu/H2G4D3DMorU1h74heqLVGxAx2o5WMn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3793

SGkgU2lkZGhhcnRoIQ0KDQpPbiBUdWUsIDIwMjUtMDMtMTEgYXQgMTQ6MjEgKzA1MzAsIHMtdmFk
YXBhbGxpQHRpLmNvbSB3cm90ZToNCj4gPiA+IFJlZ2lzdGVyaW5nIHRoZSBpbnRlcnJ1cHRzIGZv
ciBUWCBvciBSWCBETUEgQ2hhbm5lbHMgcHJpb3IgdG8gcmVnaXN0ZXJpbmcNCj4gPiA+IHRoZWly
IHJlc3BlY3RpdmUgTkFQSSBjYWxsYmFja3MgY2FuIHJlc3VsdCBpbiBhIE5VTEwgcG9pbnRlciBk
ZXJlZmVyZW5jZS4NCj4gPiA+IFRoaXMgaXMgc2VlbiBpbiBwcmFjdGljZSBhcyBhIHJhbmRvbSBv
Y2N1cnJlbmNlIHNpbmNlIGl0IGRlcGVuZHMgb24gdGhlDQo+ID4gPiByYW5kb21uZXNzIGFzc29j
aWF0ZWQgd2l0aCB0aGUgZ2VuZXJhdGlvbiBvZiB0cmFmZmljIGJ5IExpbnV4IGFuZCB0aGUNCj4g
PiA+IHJlY2VwdGlvbiBvZiB0cmFmZmljIGZyb20gdGhlIHdpcmUuDQo+ID4gPiANCj4gPiA+IEZp
eGVzOiA2ODFlYjJiZWIzZWYgKCJuZXQ6IGV0aGVybmV0OiB0aTogYW02NS1jcHN3OiBlbnN1cmUg
cHJvcGVyIGNoYW5uZWwgY2xlYW51cCBpbiBlcnJvciBwYXRoIikNCj4gPiANCj4gPiBUaGUgcGF0
Y2ggVmlnbmVzaCBtZW50aW9ucyBoZXJlLi4uDQo+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBW
aWduZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+DQo+ID4gPiBDby1kZXZlbG9wZWQt
Ynk6IFNpZGRoYXJ0aCBWYWRhcGFsbGkgPHMtdmFkYXBhbGxpQHRpLmNvbT4NCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFNpZGRoYXJ0aCBWYWRhcGFsbGkgPHMtdmFkYXBhbGxpQHRpLmNvbT4NCg0KLi4u
DQoNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMN
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMNCj4g
PiA+IEBAIC0yMzE0LDYgKzIzMTQsOSBAQCBzdGF0aWMgaW50IGFtNjVfY3Bzd19udXNzX25kZXZf
YWRkX3R4X25hcGkoc3RydWN0IGFtNjVfY3Bzd19jb21tb24gKmNvbW1vbikNCj4gPiA+IMKgCQlo
cnRpbWVyX2luaXQoJnR4X2Nobi0+dHhfaHJ0aW1lciwgQ0xPQ0tfTU9OT1RPTklDLCBIUlRJTUVS
X01PREVfUkVMX1BJTk5FRCk7DQo+ID4gPiDCoAkJdHhfY2huLT50eF9ocnRpbWVyLmZ1bmN0aW9u
ID0gJmFtNjVfY3Bzd19udXNzX3R4X3RpbWVyX2NhbGxiYWNrOw0KPiA+ID4gwqANCj4gPiA+ICsJ
CW5ldGlmX25hcGlfYWRkX3R4KGNvbW1vbi0+ZG1hX25kZXYsICZ0eF9jaG4tPm5hcGlfdHgsDQo+
ID4gPiArCQkJCcKgIGFtNjVfY3Bzd19udXNzX3R4X3BvbGwpOw0KPiA+ID4gKw0KPiA+ID4gwqAJ
CXJldCA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCB0eF9jaG4tPmlycSwNCj4gPiA+IMKgCQkJCcKg
wqDCoMKgwqDCoCBhbTY1X2Nwc3dfbnVzc190eF9pcnEsDQo+ID4gPiDCoAkJCQnCoMKgwqDCoMKg
wqAgSVJRRl9UUklHR0VSX0hJR0gsDQo+ID4gPiBAQCAtMjMyMyw5ICsyMzI2LDYgQEAgc3RhdGlj
IGludCBhbTY1X2Nwc3dfbnVzc19uZGV2X2FkZF90eF9uYXBpKHN0cnVjdCBhbTY1X2Nwc3dfY29t
bW9uICpjb21tb24pDQo+ID4gPiDCoAkJCQl0eF9jaG4tPmlkLCB0eF9jaG4tPmlycSwgcmV0KTsN
Cj4gPiA+IMKgCQkJZ290byBlcnI7DQo+ID4gPiDCoAkJfQ0KPiA+ID4gLQ0KPiA+ID4gLQkJbmV0
aWZfbmFwaV9hZGRfdHgoY29tbW9uLT5kbWFfbmRldiwgJnR4X2Nobi0+bmFwaV90eCwNCj4gPiA+
IC0JCQkJwqAgYW02NV9jcHN3X251c3NfdHhfcG9sbCk7DQo+ID4gDQo+ID4gLi4uIGhhcyBhY2Nv
dW50ZWQgZm9yIHRoZSBmYWN0IC4uLl9uYXBpX2FkZF8uLi4gaGFwcGVucyBhZnRlciBbcG9zc2li
bHkgdW5zdWNjZXNzZnVsXSByZXF1ZXN0X2lycSwNCj4gPiBwbGVhc2UgZ3JlcCBmb3IgImZvciAo
LS1pIDsiLiBJcyBpdCBuZWNlc3NhcnkgdG8gYWRqdXN0IGJvdGggbG9vcHMsIGluIHRoZSBiZWxv
dyBjYXNlIHRvbz8NCj4gDQo+IFllcyEgVGhlIG9yZGVyIHdpdGhpbiB0aGUgY2xlYW51cCBwYXRo
IGhhcyB0byBiZSByZXZlcnNlZCB0b28gaS5lLg0KDQpOb3Qgb25seSByZXZlcnRpbmcgdGhlIG9y
ZGVyLi4uDQpXaGF0IEknbSByZWZlcnJpbmcgaXM6IHdoZW4gcmVxdWVzdGluZyBpLXRoIElSUSBm
YWlscyB0aGVyZSBoYXMgYmVlbiANCmktdGggTkFQSSBhbHJlYWR5IGFkZGVkLCBidXQgdGhlIGNs
ZWFudXAgbG9vcHMgc3RhcnQgZnJvbSBbaS0xXS10aCBpbnN0YW5jZS4NCkl0IGxvb2tzIGxpa2Ug
YSBwb3RlbnRpYWwgbGVhayB0byBtZS4uLg0KDQo+IHJlbGVhc2UgSVJRIGZpcnN0IGZvbGxvd2Vk
IGJ5IGRlbGV0aW5nIHRoZSBOQVBJIGNhbGxiYWNrLiBJIGFzc3VtZSB0aGF0DQo+IHlvdSBhcmUg
cmVmZXJyaW5nIHRvIHRoZSBzYW1lLiBQbGVhc2UgbGV0IG1lIGtub3cgb3RoZXJ3aXNlLiBUaGUg
ZGlmZg0KPiBjb3JyZXNwb25kaW5nIHRvIGl0IGlzOg0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L3RpL2FtNjUtY3Bzdy1udXNzLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ct
bnVzcy5jDQo+IGluZGV4IGQ1MjkxMjgxYzc4MS4uMzJjODQ0ODE2NTAxIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5jDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMNCj4gQEAgLTIzMzQsOCArMjMzNCw4
IEBAIHN0YXRpYyBpbnQgYW02NV9jcHN3X251c3NfbmRldl9hZGRfdHhfbmFwaShzdHJ1Y3QgYW02
NV9jcHN3X2NvbW1vbiAqY29tbW9uKQ0KPiDCoMKgwqDCoMKgwqDCoCBmb3IgKC0taSA7IGkgPj0g
MCA7IGktLSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtNjVf
Y3Bzd190eF9jaG4gKnR4X2NobiA9ICZjb21tb24tPnR4X2NobnNbaV07DQo+IA0KPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXRpZl9uYXBpX2RlbCgmdHhfY2huLT5uYXBpX3R4KTsN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldm1fZnJlZV9pcnEoZGV2LCB0eF9j
aG4tPmlycSwgdHhfY2huKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV0aWZf
bmFwaV9kZWwoJnR4X2Nobi0+bmFwaV90eCk7DQo+IMKgwqDCoMKgwqDCoMKgIH0NCj4gDQo+IMKg
wqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+IEBAIC0yNTkyLDggKzI1OTIsOCBAQCBzdGF0aWMg
aW50IGFtNjVfY3Bzd19udXNzX2luaXRfcnhfY2hucyhzdHJ1Y3QgYW02NV9jcHN3X2NvbW1vbiAq
Y29tbW9uKQ0KPiDCoGVycl9mbG93Og0KPiDCoMKgwqDCoMKgwqDCoCBmb3IgKC0taTsgaSA+PSAw
IDsgaS0tKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbG93ID0gJnJ4X2No
bi0+Zmxvd3NbaV07DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ldGlmX25hcGlf
ZGVsKCZmbG93LT5uYXBpX3J4KTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
dm1fZnJlZV9pcnEoZGV2LCBmbG93LT5pcnEsIGZsb3cpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBuZXRpZl9uYXBpX2RlbCgmZmxvdy0+bmFwaV9yeCk7DQo+IMKgwqDCoMKgwqDC
oMKgIH0NCj4gDQo+IMKgZXJyOg0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gQmFzZWQgb24geW91ciBjb25maXJtYXRpb24sIEkgd2lsbCBpbXBsZW1lbnQg
dGhlIGFib3ZlIGFuZCBwb3N0IHRoZSB2Mg0KPiBwYXRjaC4gVGhhbmsgeW91IGZvciByZXZpZXdp
bmcgdGhpcyBwYXRjaCBhbmQgcHJvdmlkaW5nIGZlZWRiYWNrLg0KDQotLSANCkFsZXhhbmRlciBT
dmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

