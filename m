Return-Path: <netdev+bounces-120786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333D95AACD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 04:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBE21F23804
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4A9125DE;
	Thu, 22 Aug 2024 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dCOw6kqm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ECB111AA
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724292470; cv=fail; b=P6aT/IaUwr5h1U/gU44d+UaH7KWHZqsXyErDBcTwDyBCICG+uOyOImpry5w9OPEvy2SeJeEqe34qVbYACPtURZD4BenR4qot1t0Ezzpq8s4LBLQeifqA9yJpQam7C3EpXNQsmjN0nPL7QOG7zjNR2oOp8Q1YfdaWZFSSvk1LMfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724292470; c=relaxed/simple;
	bh=IXaXSmik3lG9w3fsOAC4Y/dfSxWMmmVLAfNnsiF+GEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7WeuPDRpSwX+fcTOvGpm7LULFobyIj5H4Qyi2lS/pqzk1cCIrPJUhLpwrm8GgkCdHFQbx20ry5JxZQfPLnWWinFF8UrIWhwYVzWmiaDdpYsfOz0OU6SUU1oFusJu/7n+z4Nzu6nie/ap4DXKO2BUzKBvadZQGEz0lyRVYdIDiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dCOw6kqm; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvTrbXW69LNceKfz4xeT7Xo0ARKtNKOUvF0jdxvSn7sL5nYr0vvetNLLxdQIrlUAgb1n17vBwELWgipqItcqHu1/1Eyk0JlGdTWlzzsWXbydEblJxvgDWR+RUOIPYhifNpW/EO8pPkTDjhoBTuO31uk4/ZpMoGwqxh+Wqv6be5az9CB9UYz2BmXGu2jcGSFgf6/0hfV4VYfHflxI2OCQnWOFKUn5FFfrnT0fWCzbAT9t/yZHAV2tTmKbmLvXOQTpzTihN/uF1ZQdN8BRivxl+4YgZOGdvui2KF163SbvMrq2NTQ1mHD9m0cjvxANsO87FXOpy/QABUuopYUVdKrd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXaXSmik3lG9w3fsOAC4Y/dfSxWMmmVLAfNnsiF+GEQ=;
 b=s1/onHST8s9HsBVklHQL4jNGXgvQvAWvI3zGg31SyhYbqLFaftbqGJ3zq6G9TIfCYYxYTIIyCm7ymfrHYh9ShjetzbYYq0IVrBk+bF7Kwf2vg3MB6D5gazThOW4OusQx89+pChoPs46ugsLMhAnqJskdG1uEFpG6HQEZCFQcAf21yzfeKGReFUtb0Wq497hCfpuKxVXzpRB6DynIfOMqK6d/vAcnX7tBDVyYN7g4c1B1Zkf1rsUkaMz3zlEl7C3u+v2JIdWDdrJUMZwFrIw0CfYiQFIgpJk2XmxFgaj8W73fHGzNyObk+90eCMSjstjshcz2UNlWY+gFJ/Y+GSFxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXaXSmik3lG9w3fsOAC4Y/dfSxWMmmVLAfNnsiF+GEQ=;
 b=dCOw6kqmwAqOD2IpxKRghNnzPzcepMjmKXld7U6hdYS3nEOR7jNxu6qUHyK6LzmleRFXK1CfrgE6I8NT8QDi1vMbNNf/lnVrbCwG99N1iCiHgAZ+RCGX4O6QPsE37cry6VNQKe/mGHxYsK827WeoGjjry8Qd4EC/lXy+uKip4n93vxUpiz9ceJ7IPIjQtJRwcFsLkD4jjDJlUsBRG+YMPDOO2xDLez3tbasd2yosmimg03VgIEW8Kw6Yo/wbuMpYnVG7om8TgV2WxhYxCke2qAVe4qDf9FR56Eu0/pJKe36/hWVYv78csSs2kbbuQLpLvcS05PQikfK69AE5BRzN5A==
Received: from IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 02:07:46 +0000
Received: from IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d]) by IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 02:07:46 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "jv@jvosburgh.net" <jv@jvosburgh.net>, "kuba@kernel.org" <kuba@kernel.org>
CC: "liuhangbin@gmail.com" <liuhangbin@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, "andy@greyhouse.net" <andy@greyhouse.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net V5 3/3] bonding: change ipsec_lock from spin lock to
 mutex
Thread-Topic: [PATCH net V5 3/3] bonding: change ipsec_lock from spin lock to
 mutex
Thread-Index: AQHa86lRvqzE9qTrNE+i0gwEMFd6W7Ix3ysAgACJEgCAACCWAA==
Date: Thu, 22 Aug 2024 02:07:45 +0000
Message-ID: <086f08d257d5d50f5dca5e85b474831358d37c22.camel@nvidia.com>
References: <20240821090458.10813-1-jianbol@nvidia.com>
	 <20240821090458.10813-4-jianbol@nvidia.com> <120654.1724256030@famine>
	 <20240821171106.69e8e887@kernel.org>
In-Reply-To: <20240821171106.69e8e887@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8554:EE_|DM6PR12MB4340:EE_
x-ms-office365-filtering-correlation-id: b67dda11-17da-49e2-b9fa-08dcc24f36ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzRWRlArWVNFbkNnZFdUbmdOQ08xby93VklUY0lzWUM4cVpBSXEvUHpqaTYv?=
 =?utf-8?B?N1JnSk1USjVBb2pHR3g5ZXRFaEl4Ny8vRU44OHNYRTM0NTFjYUJlYnRuMGFp?=
 =?utf-8?B?WVBWdWZaN1dsaExIeUlldS9hbmtrYThYNzg1Tlk2cUoxY2M4WGN5UEowTzZJ?=
 =?utf-8?B?T2Ivd2tlUkFYck9BdGtCdm5NRTllcjNCdDJ6WFlMemxKQUlPU0s1RTl0eXBN?=
 =?utf-8?B?UzlIOC9iVldweC80anZkQ3NnVDI2V3o2SEEvTVh0VUhOTkVPaTV1Y1J3NGd6?=
 =?utf-8?B?b29EQlFtSmhmL1B1UzBYNkV5dG5EVVhTUm1peFZYbVJDSVU1Zlk4TkcrbVVL?=
 =?utf-8?B?RlM2Ly9oL3FBK0lmNHM2bWxZNjZvODkwTzF3ZSt4QStBMjN0cVpvOEdvNnda?=
 =?utf-8?B?VlFnbGRaNU1QZFZlbE1wNDNUZjJma3dxTEV6OVM5aXM5QlJVV2ZGUVVNQnp2?=
 =?utf-8?B?Qjg1NXZJT0QwcWJ1WHVZYUxGTVp5RHY2ckExMUxRVzZYZkRZb28yVEZIc3Bx?=
 =?utf-8?B?N2JnY3hZbllFVE84c2E0NCtvQkVXK0o5OC8reHBlL2xOU3N1R0EwUTdncERt?=
 =?utf-8?B?M3IzL1orN1hXWTFKVksvcllzYkpqMjBia3JDU1hIajYxLzNqYVU3OUhUMjZ4?=
 =?utf-8?B?WS9yNWdqcmZyMi84YVBselkzaFBCbGFGVU84Q0JSNnN3SEx4blRIalFpWG9Y?=
 =?utf-8?B?ditpVnpjRlB5WnVNOGhqajcrMFR6Z3pXdkd4S3JGV3F2VG5heFFYQmhQRHVQ?=
 =?utf-8?B?UlJLamVYMndlR3NsQ0FoblZYQlpnWHpBNWlSU2dmTGJ4NCtBa0RIZjZvL3RD?=
 =?utf-8?B?SktqWUM0dFVaTFBJZThFZEw1bXZQT0c3NFpJMkQySklNa0pFN0EyUkFsZnor?=
 =?utf-8?B?Y05YZVFKRHhVVkhTSUl4d0JOLzNUZEZoTXgwOXp6cWZ2M0F0c3d5SDVIR1dv?=
 =?utf-8?B?aXRmWStzTUJKdkpWZ2w5YW5hS3o5bUpGdmhjQjdEZGtQNjY0dkFqbTZkUEZs?=
 =?utf-8?B?M1ZYVFBZdFdQenVSMHRUVkJFV0JTQ2puSWVqb2t6VFpxRHdXRjVLMHlZVmov?=
 =?utf-8?B?dEpaZzFMaThwOGpQZmk2aTNNT0xWckFXUXRFT3JIcjMrWlcwTkJlYWRVMHpo?=
 =?utf-8?B?UENmaEwwNlhkS0ZISFFzd1VGeDFjUEthaDdZTUptOUJNZTRuWkxpc0FPdEZp?=
 =?utf-8?B?M0d1Mmt0bW5SZXpZQUVRQndqRVZCbzhQLzQzbWJKOHFjWGRHSnI5aERIdnE4?=
 =?utf-8?B?UExoYjBrNEttNmJSM1dnRHZwak42Z3hibXNoeTR2Zm92Qit4NUlHVWtlc0w5?=
 =?utf-8?B?dHpWMmorNE53Y1ZvWHc4VDQ0bnNZRm9IRlI1RXNSYkp1cGF6TVRnY05ta200?=
 =?utf-8?B?VTZKNXRpSEVqY3Qvb1g1Q09zZDZGVVlSbXpoZ1c3czBXZkNkWDVocnFMdGo0?=
 =?utf-8?B?L2d1YnBjYnlLM1djMmxYdGhkTTVlSytoMjJ4ZFRXOXBUVGtDOS9Sd0Q1bzNm?=
 =?utf-8?B?MkpoM3E3WGd5RVI4OWxzWmFYYllyQk9CelVRN2hSeGtLWlV1MWd2aG5RSW4y?=
 =?utf-8?B?bWxvVnNlZmQrRmhneUt2d3hTUG0rdk9QVXNzL2hWaE8yVzRCL3VRQ3oyME1k?=
 =?utf-8?B?cGNHRGZLQ0ozNjIyZUt4UGIrSWpBdWVCT0VIZzFEeCttWS9KeVRkL0pjU1o1?=
 =?utf-8?B?a0djUzFxM3pSWXhQRWpxTVFvTHVqNnBNQUg2MmpGUWc5ZmM0Um00UlhoNy9t?=
 =?utf-8?B?TDhuc2c5REFpbndXb0tkR1FLUjBQbC9ONEw4T2ZkckZWL3lqY1FBT0ltMGF2?=
 =?utf-8?B?QkZSQVQvWVIzQW00d2hLallKb2VqdFE2Y00zM0dOYlhDT2JXZE1lTWw5TUkv?=
 =?utf-8?B?Vjg1WWoxcjVjYVo3b3ZoRUJjbVBOUnc5L2pkbm00dzVyZHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8554.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YStuQnNiMW1oaERiSGFQN0FzWHRJWWVLT1Q1TUxTb3VqK1NxeExBWVFMSVZS?=
 =?utf-8?B?V0lJUUZWRDVReVVLaDZoaStiVkREelpyWGdiRE13UUMxWWhHUzFHRTAxZFpp?=
 =?utf-8?B?ZjFPTC9iejZhSEZ3L1lhN2xGS2VxUW85UGxMamhYaDNIck13dkVOSjZEQTN2?=
 =?utf-8?B?eHdQQm4vR1IvRGo5V3VJdTkrcnNvVHc2cis4V01vYkdQRDNXSi9xaTl0d3VT?=
 =?utf-8?B?OFRQR1JxUDB6bTZGTStlN002R1I3cnVTVWEvWWsxQ3p6TWptbTZLOXpMMmMy?=
 =?utf-8?B?YldCRkg3ekNyaUtScjRVL1VvMTQ0RXA3YVBkR0dQSVIyR1hRbzZyeEVJSThQ?=
 =?utf-8?B?dWQ4SHJkL24rU3FwQWRBOXQ0YWJTaHBTNS9udjhqK01aT2ZWQjJsNGJhTHFE?=
 =?utf-8?B?TXdORzBKMklMZm9PL1lyYUJOU1JsTXhpZFZsQzFacFpBWUtJTzFIZDJQcTZx?=
 =?utf-8?B?dlhCS0NRLzBFcm9ta1FIK0xQbldjb1dvQ0ZERnNhNTk4c0hPMU03ZlFJbmor?=
 =?utf-8?B?YUNQUnk1eTRrZlg3WkR6cWdQclRacDBDb3l0bkgzamJCM0NJNGpTS0YvZ3l0?=
 =?utf-8?B?Q2pOZWluQnNuekR3VGF1N1lqZXA5L2Judm9LcmtXbXdpS1JMdU5yVzBlS1pE?=
 =?utf-8?B?dURLdER1b3c4RGhIZDQxMkpMV3BqTWdkUnlFU1llOVoxY3EzcFJ6V3krUkpu?=
 =?utf-8?B?SDNJT0lQQ3FBOW5SQ0FDZC9DODBMYjRsL292Q2xGa01takI2NGEwbWpoUDBU?=
 =?utf-8?B?RERhU1p3WkM1eUwyYXVPYkVVQWZjRmFiWHBsR1J1SE12ZmlDclB5Mk1SdGZu?=
 =?utf-8?B?RnNDVWZLRDIzNW4wYytBRWJ3T29Ec1ovbnJ6TDE3aTFheHBLS2JDZzJRalJ6?=
 =?utf-8?B?T3EzWExSQVpMYU5MYWk5RCtkalIzQXVDL1g3cjQ0a0lzU1FqYko5TUlqdWtF?=
 =?utf-8?B?SlNrTFljUjdnSnNVSDY5eUxXMml3WW9TYzhHdS8yT2xDbUlBdGdDR20rRzZL?=
 =?utf-8?B?V0JrYkM0RUJCWXRKOFFLOGF5Uld2ZVE3YUxPYmlZTndFeHBKMFd0blROOUtZ?=
 =?utf-8?B?d0xKK3MrLzltWlg2WXdYYUFxV1pSQS9HVlB0OEJVdVRIajlid0xJQTJTb3Jx?=
 =?utf-8?B?OVR0TUlxY2JCQ0dJemtqZGVlTS85S2YrTWY2b1hHd1Q2NEs0RC9mWis2UUY1?=
 =?utf-8?B?anU1c1RDV00yYWkzY0NlUXhGRWxkcWdNQlJGN2tYRWpYbER6eWdSdnVWeklW?=
 =?utf-8?B?SUtHL1EyZkhrZko2dUthdDdpUmR5UVhqbU50M2JETFloTnFFWk1ESTJ2R2Jw?=
 =?utf-8?B?eVNodTdrRkFQMWRtd3VnYmhsTVh5QlBvUXZxTzUvcnBXSEdpSVJMckNMNjgw?=
 =?utf-8?B?eUlFM1U4c29aSS8zeWtNZmpIaDNORVMydFh1cG12dGVHblhjVkRhb3YxV3E1?=
 =?utf-8?B?SFp5aHVLdEZPNUxNYjR0aWhJUnArNllQQXluUk8wQ1RUTzNleG5BcHcyU0sz?=
 =?utf-8?B?TGJpMTBvN1dONm5kRTVuYUY1bjlwTVQza3M2dnpZTk05K3NuMldEQmp2dGpF?=
 =?utf-8?B?TzZ1aXVVS0NIaStzdkdKaGZBNlZiWS9JRis3bVVGNGxMaVR0NUVUM0xMajNW?=
 =?utf-8?B?RXBjU0JSdzdLeDVoVFRGQUZxcEUrdGk5UFY2bXVnMVphY2tIeHJsQ2Z5Qkdx?=
 =?utf-8?B?WjVHdGJzbE9pTHR6UHJCRFhqZTZQa2FrcTd1SWxzTkM2ZVVwbHlvVEV4Snhr?=
 =?utf-8?B?ZEtCK1lnWVR6Ym1sZ29uU2J3dXBzR2JBcXJzRWN0dTc2VXViM2VTeHJhbjFl?=
 =?utf-8?B?QTdFZjgwcW8xdXpMVlJCcjRucjI4VUVvVzBPVTNyY3B5dXhnck95Y0N2b0xk?=
 =?utf-8?B?Yi9sRjl5M1dwYXdMdzVOZ0ZnL2w1UFd3VW5QWGU0VlhiUVhER0FLYUZQTFZi?=
 =?utf-8?B?aVIva1JhRGtLTUN5STNYL0RCTGNKdjV4WlpaVEIvMHBtMzFPdHBOKzNOVXpi?=
 =?utf-8?B?RWxpanZrTWF0aEpla0tuUVlNOHVreDVmZHlFeWhPMndxQ2VqYlVPbG95U0Q3?=
 =?utf-8?B?NkhvQ1pXNnZBRVh2d2xiWVNWeUtFd01kOWVka09xYjFpbVdpVWx1TTVnd212?=
 =?utf-8?B?OVgweWE0V1JveUxlR1phOG9mRFo0a3hTanlFRGFmVGNXbE1PTGdSa0pjcVo4?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88C8EF215D20BB49BC1C8E2D318470AF@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b67dda11-17da-49e2-b9fa-08dcc24f36ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 02:07:46.0080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6WL5idBbQDM97t4O+AvoDZ7Zf8IGXmiwpg63nc5+hQBNUU+oW9/U8n2ogaaEatBk3Wdek0/bdLn4mi54VFQzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDE3OjExIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAyMSBBdWcgMjAyNCAwOTowMDozMCAtMDcwMCBKYXkgVm9zYnVyZ2ggd3JvdGU6
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoElzIGl0IHJlYWxseSBzYWZlIHRvIGFjY2VzcyByZWFsX2Rl
diBvbmNlIHdlJ3ZlIGxlZnQgdGhlDQo+ID4gcmN1DQo+ID4gY3JpdGljYWwgc2VjdGlvbj/CoCBX
aGF0IHByZXZlbnRzIHRoZSBkZXZpY2UgcmVmZXJlbmNlZCBieSByZWFsX2Rldg0KPiA+IGZyb20N
Cj4gPiBiZWluZyBkZWxldGVkIGFzIHNvb24gYXMgcmN1X3JlYWRfdW5sb2NrKCkgY29tcGxldGVz
Pw0KPiANCj4gSGFoLCBJIGFza2VkIHRoZW0gdGhpcyBxdWVzdGlvbiBhdCBsZWFzdCAyIHRpbWVz
Lg0KPiBMZXQncyBzZWUgaWYgeW91ciBzdXBlcmlvciBjb21tdW5pY2F0aW9uIHNraWxscyBoZWxw
IDopDQoNCg0KU29ycnksIEkgbWF5YmUgbWlzdW5kZXJzdG9vZC4gSSByZWFsbHkgbmVlZCB5b3Vy
IHN1Z2dlc3Rpb24gYWJvdXQgaG93DQp0byBjaGFuZ2UgaXQuIEFsd2F5cyB3YWl0aW5nIGZvciB5
b3UsIGhhbmdiaW4gb3IgYW55b3RoZXIncyBjb25maXJtDQpiZWZvcmUgZG8gYW55IHVwZGF0ZS4g
VjUgaXMgdGhlIHJlYmFzZS4gSWYgeW91IGFuZCBKYXkgd2FudCB0byBtb3ZlDQpyY3VfcmVhZF91
bmxvY2sgYWZ0ZXIgeGZybSBjYWxsYmFja3MsIEkgd2lsbCBzZW5kIG5ldyB2ZXJzaW9uIHNvb24u
IA0KDQpUaGFua3MhDQpKaWFuYm8gDQoNCg==

