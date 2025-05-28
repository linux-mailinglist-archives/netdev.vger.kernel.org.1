Return-Path: <netdev+bounces-194081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F08AC7428
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 00:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36A917691F
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 22:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CC4221DA5;
	Wed, 28 May 2025 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="jl6/nzEP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF816EB7C;
	Wed, 28 May 2025 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748472175; cv=fail; b=JeyV7TS2TzGxQDfbrDwMqqFVuWDIOFNX2VfaWwd1NqKQSrSCiPygR5/FKoLagdyxJqi0D8tN7Iv9EadReSMpyDdX8LSpPT5zwDmH5yBQl/uE9A8MoJL7CsjXvjOBLztG6R8uT+EHijDUbSrniPqdwwuAZWVgyBBdXq37AAe3Vhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748472175; c=relaxed/simple;
	bh=EFIXM++h3BvVCm60fXlhka347BbezJwHXt2xHT5JrHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TGznXhCZK07YTHVtZa7+WEFxxGo0RgwbfLp/Bvf0qGJaeDRStoNWf7VtRruXINr9f8b1/sCDB7KmF6/F1xcoTTcyvrECzQPMsBIya2lS/svQfBZgB8cFNGX4jzSkRrsggIimmqWLHEUS/HXHTpOGyC8QDeaXWE1onSwA4eGXATY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jl6/nzEP; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0XktaEqH0nhKmVyc2pJf0jnikCQZzPFafrN4WNazOfpGt8jU5CtZ7MSo7nO88/s0qTet20bA7xqpq1phMLi3v56jauuFdep5GLtKT7pHZBw8QY/GEYC0OVJsYP/rHUDXdVMrR31BDwlKBPTFcWSs46v51Ia4uHEV/SnRynOVoJaR7X9+gseHJ4fPL5nKcElIO/HMk3t+7wOHBl5crlRkIYYHCzONUUJmCyiKIStEtRdxM/eejdZx5zLXXJw6CQ98AU09IGqOS5Wkf65MR3ORCVNW/FnHTL2WgLpNeNXmFJfAirNh8Cf2UEnv5IYIYX/F1wYQ0yVIsnEXcinoKgYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnP7eYlpoMCA8Sx2VNwH6vEL86dSl6KRyMlhLKOwEqQ=;
 b=Abn+3NylohkMtrqpXxIg6lH8OS/8gP/UC2avOYm6W6fEKhV+P39QeZgONvgoCdc3qPl89ADCPQ0jtk/yo5PXbScYhFeOvmY+UsovXsFzyu2McdQiNxLHUGzS2PJX5nHS+VuYno6IuBjQ/bg3qTj79kR/QnNnVwxQbiFkMvix4UwKEcnt8vKaTuR2SxB0aotrmjd9vUiY5+0s9HZ+lfhgB1+ZPKbcL0Aa1MZxWq+wzftsM5k1pOMwDX5t3aA02z8d+WIJZKJf8IbryUsZaG8VH49tp77Ymy7aKvXc6K0W0jXnL5f1LDEiLABvIHhjnAI0tCr3ccvxoqMncL+pWJzQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnP7eYlpoMCA8Sx2VNwH6vEL86dSl6KRyMlhLKOwEqQ=;
 b=jl6/nzEP1Y9QD+hYKD6Hp/yE9PXHBSWUSd0eqhRy3lEuG8OjZe0o7bq5Pxf+ccWSccOBO5cAGat5HlB+10Jy8TEPPN83SW4RChdGaD/aFwXAH/zPIh57nPjBtZam2Vr/mzTwGFXEOm9wvLIT5YU2Aa9eYGW70Q1it4rnvn5rnm2q4lwlNCGILaYQAdq6FyEG9RH+cv+M/wukD6lsKjQNq8fhSvWoyHtKiVgExSyCLuqBU+eg+bcQ0Nqhxkr3bqp0nGGZkgKzmIaljJK31nw/mzCsQF5UTXNQcevXiZuIVa5aA2fufM0BbYVKkeIW5zybe7cs/6WzABF/mEYPhOqmOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB3465.namprd03.prod.outlook.com (2603:10b6:5:ae::19) by
 DS0PR03MB7582.namprd03.prod.outlook.com (2603:10b6:8:1f5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.26; Wed, 28 May 2025 22:42:51 +0000
Received: from DM6PR03MB3465.namprd03.prod.outlook.com
 ([fe80::1ddf:36b:d443:f30]) by DM6PR03MB3465.namprd03.prod.outlook.com
 ([fe80::1ddf:36b:d443:f30%7]) with mapi id 15.20.8769.019; Wed, 28 May 2025
 22:42:51 +0000
Message-ID: <3a256280-8367-4ae7-b02b-11701955626e@altera.com>
Date: Wed, 28 May 2025 15:42:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mun Yew Tham <mun.yew.tham@altera.com>
References: <20250528144650.48343-1-matthew.gerlach@altera.com>
 <20250528170650.2357ea07@fedora.home>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250528170650.2357ea07@fedora.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:180::19) To DM6PR03MB3465.namprd03.prod.outlook.com
 (2603:10b6:5:ae::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB3465:EE_|DS0PR03MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 012b8696-2ba3-43f8-254e-08dd9e38fa71
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emZEbW82WDhjWHl4V3BkMWloOTJIQ2libTk1bkp2bHAwTE1Kd1hMN0w5T29k?=
 =?utf-8?B?WGFwOXowUjlpUkR0VDBsYWl1L1JjWGtiV1BoS0h0WEU2LzNtR3ZqaUV4MEZS?=
 =?utf-8?B?TXc5b2lsSVd6bkZBT2FzOURLcDB4bGtQamh5THNua291Wjcxc1FKd2hMdG1W?=
 =?utf-8?B?dmpiblV0eDhVOS9VWW5ES1NzZlVpbDJUNDRvdDNUa1RXeW56aHEvdWZpU3dm?=
 =?utf-8?B?dHpzK2pwQ3pRRWZKTlVndUdwb2VUb1QxYWx3K21BM2dUaWtiZHFORmVlYXQy?=
 =?utf-8?B?bFF0TkREaEg4WGVPVW9Nc2Q1ZFJ5R0hOV0VVTTdxV1BUMmdyVUxDWklDblhz?=
 =?utf-8?B?ZEJKMXU0SnBVRDRYSUl3Wlg5Y2hwLzZPTktxRzNrT3FSZHpjeEJISW5TM1VJ?=
 =?utf-8?B?UXRFby9kdXozKzFoVU85M05lNjR5UWlVMitOTW4vbFhBQ0RmdVAxWXU4RmFt?=
 =?utf-8?B?Y1R1dEs4aFlFZDNQV013c2ZyOHFuemNOZC8valhNRW9aZWZSSWc2M2xXT0Zv?=
 =?utf-8?B?cDlQbmZPVnF3VmEvNWlYQlp1SmI1TFBCMHY0UU5lYVl2emE0bHZac1hDbVBl?=
 =?utf-8?B?NTFUa2pRUTBSRWZ4VmVYRThOUFQ5VmNYS1dWaFprc0VMZCs1NldTQ1A2bGZ6?=
 =?utf-8?B?SVNPM1BRYUNjL2t4UHR0YWlVK0dWK3lNZnUxcGN5NFRzNGFlTmxySFZRcGNy?=
 =?utf-8?B?MU9HRktBeHVhVkt4cWZWblMyRDBPcm1aQmg4WHF0RTU4MHlKWlBqR3hlalR2?=
 =?utf-8?B?alNyak9DQnkwK1N3bmNNdEs0VjRXNDQ3ekttRVc0bEV1TW53L29TbWlmSnBZ?=
 =?utf-8?B?ZkVIRXhjbWo2OHVDWEdtNnlCTGw1cWtOVWVDMDRzQ2NXR08vY2NqSVRHNHI5?=
 =?utf-8?B?bzR5MGpnRFZ5ZThUbXFjV0hzZCtxTStnRU01aEIzZnRzQzJrQVM5b0p2UDZr?=
 =?utf-8?B?alR4Wkt0NnVEOEYvalJUWGtmSU5YZWVkTHFDSHFhYldUVVhNMDJSa3lMSnZJ?=
 =?utf-8?B?WVh4RWRjdzlSNjR0QmVlV0RuNWlSbE1HejhYNHQraFR1RElNRjBMWmUyS2xJ?=
 =?utf-8?B?SzJkcEltN1JhcnNzYThvcElEdDRSWWxZU1pSOHh5c1hiOEpBM0tKSE1Lam9k?=
 =?utf-8?B?VWdvc1lCRW42ZW52NTBEY3VyRG92MjlvMVdzQWdhbUJWVnAxUjhoeWhMQ2cx?=
 =?utf-8?B?cnVaQzFzeVlnV2o4dy9ia1MzOERQa0VabHJGa2NwOU1QT0VwWGJsTThNcVJs?=
 =?utf-8?B?MWhwVU1idit5Wjdjc1BySFBFaXBOczVJNVRvRXpFVE1jSjlpbGJUOWJsTUwy?=
 =?utf-8?B?RVpPQmZmUkZoVmdhcjF2ZnBpbHBUWmdMZ2RVc2Y1M0RjYkJMTXNyVElSRzBo?=
 =?utf-8?B?UHBpNzA2NXk2aVZ6VVF1empZL3REamxMdGhOcHpORVZXaUY5MTRsMCtDQXpW?=
 =?utf-8?B?SjdUOTdyMDZYSE56clVyV0JpUzFHK2U1eHoyUVJNbUhybDZjMG9NMWpOMU5z?=
 =?utf-8?B?R1oraXNxZGdRTWk5T1JFV3ROUnZzWE5sOENMc1BXMyt0UVliNzdyMmV0S2Fa?=
 =?utf-8?B?VXVZR09ZMmhlM1hFTjdTMnlNZ1M4Zm5JTlF4R0cxcE5YMVVGbEd5aVdhbkF6?=
 =?utf-8?B?YVdMa2d6QUlYRFk0dXR2dmpXay9jK1pvcHNMVnpXM3dnK0gyNDZreXV6NDRT?=
 =?utf-8?B?VUJSY0tKZzkxS1RsQy8wZytHS2NvZkhlUGJSU283dm02anMwd1dKZnFmd3RF?=
 =?utf-8?B?Sm9rRHJCZVd2c3RQWXZiQzVUOGNoam0yS0dnT053eHF1Zmt6MzM4ZlJEN2F6?=
 =?utf-8?Q?qAAuYgZ9dLu2VqzXka/eHMoQV0S6xV2Il4vYo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB3465.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkZPdkdublE5aTRiWlo1M1lodCtkS1V1KzFqT1VRRmVLUXh6bzU4T2xsTkpj?=
 =?utf-8?B?d1A2UCtIdzRHMkRUVkpDMHhzWFR2aEZ5YXVkbzFJemlTcndMVWFwM2tweXVG?=
 =?utf-8?B?d3pPS0JhZ3U0bTVoZW5JZHk4MFJKemdWd0ROSVk1K2pGV2doMVZIVzY2M2hP?=
 =?utf-8?B?RmhocUY5bC9NQmt1bE84UVNFS0kyUFRaQ0t0WUxOS3czaTREL09nYkMrVzdO?=
 =?utf-8?B?TEp3b1EvVmd1SSs4MFhXVE9YVmN6OUJPNTg0TTZzM01LTS9aKzg2MDl2RTBz?=
 =?utf-8?B?UXcvR0hVRFUrSzlqS2hyVU1VVG94Sk1iS2c5S25ENXdaVjY0VG9hNTNWcjJV?=
 =?utf-8?B?dmhIdXc4d0szWlRTakUrb1Q2UnFWSHVlT3M3WW5ZZkVlL2lCWFd0UkFxYlhR?=
 =?utf-8?B?aEd6TjdsSzJMMlhsNWFodjJaZXdXNHcrbklTZmdRQ2gzb3hVMzRnWElyei9s?=
 =?utf-8?B?MFJXOVV5OWVhVEZ1Qi8rZkRBdTEzY1Brem9TUE1nQWN2KzdBb29vdTA1Y3JY?=
 =?utf-8?B?clhVWnFzU3VOUlJOMm9CbXRvTVRDdis0MTNUKzlpVW9LcW1DU3QxMmk0WHBP?=
 =?utf-8?B?M3dGTU11Q2VkWW9HUTdSN0lTQ0NpQWVBU2tRanRFSGZMZjAyM3d3L2FIdWZq?=
 =?utf-8?B?YVNleTNxMm1zOG5BY1VMS1Z2c1NBRGhGUndzYUZWZFhMZzUyU1Z4N2dzeHVj?=
 =?utf-8?B?K2hDMzhSQThSNk04dzdXazIwbm00R1VxY3RUeGJCN2lIbVZSc29JQ0V5ODkx?=
 =?utf-8?B?UE5tdXVsaThiTmdLcERjM2xSZU80QXBXMmlnYWRCUFptQ0NzcFBDSVZ0aHc2?=
 =?utf-8?B?SS83V2Jlak4xQ0hvNDI0M0dpUkV3UjllWkZEWVFQNmtmaGZ3SkNscVorakxq?=
 =?utf-8?B?VHJiT0gzaWxMUVd5aDAzZ3dxenZ1MHE3bEpkMms3SEExa3k2ZERCbGJvRWpm?=
 =?utf-8?B?SXViMVlsbEJrRVl3WGJOeDVDT0NMQjc4R1FWNDdPTk9KWVY3VlJCTDhFYXRD?=
 =?utf-8?B?VDBlNUpaUFBWdGpuc1U3RWUwVWFNVVIrN2hnUlRLN015anI5VDkzeGI5T0tN?=
 =?utf-8?B?THpYU3JNNmZpS2RVcmFIeEZXV1orcDZrRHBBcjFhRGZMa29lL0pjSVpDbUti?=
 =?utf-8?B?Smp3Zmx0SElMd3RpZDREd3kyeFFqVG8rYWJ5QmJCZTZpQlBlMEhMZzNmZHg3?=
 =?utf-8?B?cG4zOTIvanJQb0RaQ3RjZ2ljMnpBNFFQTTdPeENhckdpYkJHaUlUY29Talpw?=
 =?utf-8?B?TjdqTTVIV284dmhtcEtZaGxmYzB3OVl6WFAyc0QzMG1pQllIa0owenlOb3BG?=
 =?utf-8?B?aDYwN2UvZTViWWcvaXFqRi84UWxIK25oMGtOaTRCcm9zTW5kZUpYM3k2c2FM?=
 =?utf-8?B?dXE3RzhOZEhoZ0QwWHNCNlB3aVcxNElKZFJhWG4zZ2pPT3ZEN3hmMDRQczVt?=
 =?utf-8?B?VlpQbXE1VkxvK1pkckRySFl6TWNyZnMzZmhhbVYzdnZVRWJVRmhhQ2pnejZT?=
 =?utf-8?B?UEZzd1N3WVpIcWZXWVNTcENkSjViSERFTitTZHZEd0ZaL0VMbVBDZUtsVGYr?=
 =?utf-8?B?NGhEM1V6azNSV1p3anNxWE9DNy9PK0w1YzdOVDFERE0wOENSVGJ6TU1iYktv?=
 =?utf-8?B?MmlyOXF1c3ZaRFRJOVRrejBoZmUzS0kzNG9wcXIyYUs0OWlRb08wVWRiV210?=
 =?utf-8?B?YXVXUnJKTS9SQUkvSEtqdkEwekIzaThORGlZNG1URFN4eW51NjJZckM3MFpJ?=
 =?utf-8?B?VnNpZyswT0l6TTluWFlqYjBaN3NGSGhNY3lCY1ZjdXp5MkZnUThZbWh6L3lH?=
 =?utf-8?B?cThFanpPM3hlb25LMmh2L3JrNmwvZTVzUmpKWE1Ud3VxS2VUaGhwOFVXYWdY?=
 =?utf-8?B?b1puT1FjaTBmcHRTaHJRZFAwY2U3aTJ2dnRtQm9WUWFsK1ZNaHJSS2RKaW15?=
 =?utf-8?B?SHFFY25KUStPZzdsaFRaVzJlQlgvMUJXQjZ2NjRnYmZBRTROcm94SlN1U0ow?=
 =?utf-8?B?RlBUVUxWZDRYcGp6ZjNHaldvQmN2WGlaUGk4d2NFUGZzYmt2blhhTEw3czhw?=
 =?utf-8?B?VURQc0xSY2lRdTRLZ000RHBmZnVudUVwZVRRUnlHODJEdnVabTJiT3RQY3JD?=
 =?utf-8?B?MU9lYlkxck1TenBVbUhxMzd5cGY0KzNmOXdzQVNjdXdJQWhXMHRXZnFjSVRK?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012b8696-2ba3-43f8-254e-08dd9e38fa71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB3465.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 22:42:51.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzSjIZ51q4t/6jKbR29Umb+QhX2IGazQyJoY6YgGRu0SNAHSS74Tn99ITTOJz+k6hIgwL/Jou1K/zzWDzC7zD7vw8wqn4WOAYfGCGyBBbHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7582


On 5/28/25 8:06 AM, Maxime Chevallier wrote:
> Hello Matthew,
>
> On Wed, 28 May 2025 07:46:50 -0700
> Matthew Gerlach <matthew.gerlach@altera.com> wrote:
>
> > From: Mun Yew Tham <mun.yew.tham@altera.com>
> > 
> > Convert the bindings for socfpga-dwmac to yaml.
>
> Oh nice ! Thanks for doing that ! I had some very distant plans to do
> that at some point, but it was way down my priority list :( I'll try to
> help the best I can !
All help is greatly appreciated. I've been trying my best to fix as many 
socfpga schema check errors as possible.
>
> > Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> > v2:
> >  - Add compatible to required.
> >  - Add descriptions for clocks.
> >  - Add clock-names.
> >  - Clean up items: in altr,sysmgr-syscon.
> >  - Change "additionalProperties: true" to "unevaluatedProperties: false".
> >  - Add properties needed for "unevaluatedProperties: false".
> >  - Fix indentation in examples.
> >  - Drop gmac0: label in examples.
> >  - Exclude support for Arria10 that is not validating.
> > ---
> >  .../bindings/net/socfpga,dwmac.yaml           | 148 ++++++++++++++++++
> >  .../devicetree/bindings/net/socfpga-dwmac.txt |  57 -------
> >  2 files changed, 148 insertions(+), 57 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> > new file mode 100644
> > index 000000000000..a02175838fba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> > @@ -0,0 +1,148 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/socfpga,dwmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Altera SOCFPGA SoC DWMAC controller
> > +
> > +maintainers:
> > +  - Matthew Gerlach <matthew.gerlach@altera.com>
> > +
> > +description:
> > +  This binding describes the Altera SOCFPGA SoC implementation of the
> > +  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
> > +  of chips.
> > +  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
> > +  # does not validate against net/snps,dwmac.yaml.
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      oneOf:
> > +        - items:
> > +            - const: altr,socfpga-stmmac
> > +            - const: snps,dwmac-3.70a
> > +            - const: snps,dwmac
> > +        - items:
> > +            - const: altr,socfpga-stmmac-a10-s10
> > +            - const: snps,dwmac-3.74a
> > +            - const: snps,dwmac
> > +
> > +  required:
> > +    - compatible
> > +    - altr,sysmgr-syscon
> > +
> > +properties:
> > +  clocks:
> > +    minItems: 1
> > +    items:
> > +      - description: GMAC main clock
> > +      - description:
> > +          PTP reference clock. This clock is used for programming the
> > +          Timestamp Addend Register. If not passed then the system
> > +          clock will be used and this is fine on some platforms.
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    contains:
> > +      enum:
> > +        - stmmaceth
> > +        - ptp_ref
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +  phy-mode:
> > +    enum:
> > +      - rgmii
>
> You're missing rgmii-id, rgmii-rxid and rgmii-txid
Thanks for pointing out more supported phy modes.
>
> > +      - sgmii
>
> SGMII is only supported when we have the optional
> altr,gmii-to-sgmii-converter phandle, but I am pretty bad at writing
> binding, I don't really know how to express this kind of constraint :/
>
> 1000base-x is also supported if the gmii-to-sgmii adapter supports it
> as well, by having a TSE PCS (Lynx) included.
Thanks for highlighting the constraint. I'm having difficulties figuring 
out how to express a couple of constraints (see TODO above).
>
> > +      - gmii
>
> rmii and mii are also supported, it would make sense to add it
> here.
I will add rmii and mii as well.
>
> Maxime


Thanks for the review,

Matthew Gerlach


