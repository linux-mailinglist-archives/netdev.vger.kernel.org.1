Return-Path: <netdev+bounces-92165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1FE8B5A86
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456DC288FDD
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49AA7442E;
	Mon, 29 Apr 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="Ns7bY3xH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2134.outbound.protection.outlook.com [40.107.15.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1F74424
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398657; cv=fail; b=q3n9mjvoYvuWHlYdKqBaEcXT1S+vCxzTQdDsVwLvBrV5Z30eelpn3bZWYeT1xtU/AkZgmdgVYuxiwVUuuYFestMJd636zhUHpLGwmfRWwAecgknQTekz/LKeOOATtn70U2LJu9/bF0iJiTwqgY6bPOvtZZnkJ0SCNS4IB8j9Db8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398657; c=relaxed/simple;
	bh=6adM2zLE9lDMf5PcrBfZi8qLpBwhcKDSN2uKVubDrkA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=os1emLAs71Gh50rkUYNStUEkomV4wEF9NOP6JWRCCgI2BBW99TLCj2Rr4qTmhdp+XjSOnB9GBttjNC4X52BbJEY4lMQ2OWS71/POdOyfnvNHqoKcYAkoivOhSeAHcLPW1zRussM1DdG4OFx32vqaHj7wmhndb91igUn9fEzAvjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com; spf=pass smtp.mailfrom=raritan.com; dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b=Ns7bY3xH; arc=fail smtp.client-ip=40.107.15.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raritan.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gko5F3EjhdBzMuaOOFFmvgZbJm67I92rs46Jglg3RpZ51EtWk+4M9TAhtFlcQag43zO6cFgvf1Qh+ggh6z+f5j8BW1+ZO57eFgZqdw38wvo0enMhZS45RXypuGn4NgBQEtCh6AR4hYoTyGLgLFyRICORKPwjN1sanI4aadqKbE2I2Ju7KNVp6WSwEe+aY/wEOLwVKvq8eV/SurT6OZ3rbKKA1gUFmy1vucfbIpxzINctJKX5brjU8ZqUQJ8PpS4JJtciwZJZ0Zgt9IMxARKb7YqDHztt/gOrZ8ekonl+szLPasl4EXaNBWkHMKPIkdrCKnQmlahaEEbYagdfgCpZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6adM2zLE9lDMf5PcrBfZi8qLpBwhcKDSN2uKVubDrkA=;
 b=T4I4ctW34/FjIjEMtYCsy0B2M3gQFgq+CqJM09r3/I5eG6Uj3or2/AJtEgq8nKccb2Iamy+7mqXYrdBSb4kWkwGK4HK4lrbsj1hPB3rNwfa1OsDngxSxtG45l9gJWpaUCyQ5CMLUGVM+ju0l9vDR02Uwa1/kh+YbuwPFn0R6mW0Y2o/7XziBgqitYfUbaOq60QJvkXsk3JsPnaomhq814J+e/YT3MJuRfvPGoZapKu+xo/9UMCwusTe1ci6Xq3yTdV5PpDIJ5g2KhOTOScW2vyBa4d1D7FL/9cEN7758BkdlHC1/zcjfAKx+6u/NeTwtCKbLaYfqFH1xdTdkvQTnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6adM2zLE9lDMf5PcrBfZi8qLpBwhcKDSN2uKVubDrkA=;
 b=Ns7bY3xHU92fZKL2zZJqeg7PmdGUn1xitk+aQ2DnXc27G3NzVeVnmSr2+PPAM9euON3XmuB541N/f7QFWwWaD5aJRXzgstqumSWpHkFpn0ilznKHcL/F5RVcbEzlH4ae7frtUQWFWKrBzwvW1U6OvsNuWi1uf7CMJMie6b9QLA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from AM8PR06MB7012.eurprd06.prod.outlook.com (2603:10a6:20b:1c6::15)
 by DBAPR06MB6773.eurprd06.prod.outlook.com (2603:10a6:10:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 13:50:52 +0000
Received: from AM8PR06MB7012.eurprd06.prod.outlook.com
 ([fe80::9832:b8f4:ea0c:2d36]) by AM8PR06MB7012.eurprd06.prod.outlook.com
 ([fe80::9832:b8f4:ea0c:2d36%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 13:50:51 +0000
Message-ID: <001769c4-02de-4114-ab64-46530f36838e@raritan.com>
Date: Mon, 29 Apr 2024 15:50:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: ks8851: Handle softirqs at the end of IRQ thread
 to fix hang
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20240331142353.93792-1-marex@denx.de>
 <20240331142353.93792-2-marex@denx.de>
 <fa332bfc-68fb-4eea-a70a-8ac9c0d3c990@raritan.com>
 <16f52bb6-59a1-4f6f-8d1a-c30198b0f743@denx.de>
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <16f52bb6-59a1-4f6f-8d1a-c30198b0f743@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To AM8PR06MB7012.eurprd06.prod.outlook.com
 (2603:10a6:20b:1c6::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR06MB7012:EE_|DBAPR06MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: ba115eda-09ba-4449-7f04-08dc68536229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE1walQ0MUFMVEhvOTlOSzRBSExsdm5uazE0NWZsMVIvL1RhNGhpVXpILzgr?=
 =?utf-8?B?bE5LeGxzL0ZCNVhkUzZEa1h6Q1FFZGxpVXg2UUMzQ0l2bit0dld2R1BnVVJa?=
 =?utf-8?B?bGlMTk9ENWh2UHJwSFRveGJ6ajRtNTUwemRUQnI5TGhTS2NPd0xKVk9HZSt1?=
 =?utf-8?B?SDRlei82V0REUTB4c2ZVSkxLWkpHMjljdm5IajhDOVVZTFh1NjV0RVVHWWRx?=
 =?utf-8?B?MjExSXNpSXhLU1g2VGxpNXoxK1ZDM1JIL1lNU2lKSjhIQmR0bWRXYkdaZmVH?=
 =?utf-8?B?dlNlank5QnRESFZCL2tZYVArMjZoWHRtODRyU2ozeU5vdkpNSmFwUVNoM01y?=
 =?utf-8?B?SU5GWVA1Tmh2c2xScjJWclNITENXOW8wZGlpbDFML1RHSzEySGpwOEhReHdT?=
 =?utf-8?B?andHVHBKQStJSTRlLy9mVnRsQ29aNVJBREpaVFdnVGpKM0ZYV0E2eVZ3eVU2?=
 =?utf-8?B?MkRXelpGeFdQUURjR0RZanJvYVN6bnJxNUdFckhNWVJHd29MU2NrZDlISXBq?=
 =?utf-8?B?eGIxOFFYakR0YXYzVnFOaVBIS1RWZ1Vkd3pLc1M0c2FWajY0Tms3TUdtVGtT?=
 =?utf-8?B?NkdCVVdWR2tUWXhKNGtZRmNqTnAwYUtCWThPaUVINVBsbFE5RUVVclZVemdU?=
 =?utf-8?B?ZEx0MWJib1dWN1Y0Z2xBeW1XRkt0bjNqNHZiYVk5SzZlQXNUZlhzMTJTYzUy?=
 =?utf-8?B?OCsxMlRnWmZTditDd2FVSVRJVWFRSGhxaWhyWHYwSG96VkhMSXJZTEk4c0JT?=
 =?utf-8?B?R3I2SVFtVUV3bUQ0N3RFQ0c2RnRBOGFVTjhCRlY5cjYzeVRNQ0NCUk0wd2Ns?=
 =?utf-8?B?WkxnQ1FIcndnNVF1V05ES2pWUVpzNjI0eDlaSWU2Q0RoZWNjOHZzWGtlRHFH?=
 =?utf-8?B?WXYraStmNDcxcVlPc1JQdGVvUXRXRFVLVHI3d2ZSSGFyMXIvV1NzUjNLaXVO?=
 =?utf-8?B?Z3NvODh6VTFXMjZad2F1WUlkTlNYeS9rQ21EYVhDVkk1bVNCM09iUkFPQWFZ?=
 =?utf-8?B?N1FZdEFVR3QyR2VaSVlCc0FDTGlsQ2pPcENYTnlIWDVaNE5JeWlzR0V3V2ZU?=
 =?utf-8?B?WllsdTFGaHRZUXFlOUxaTTEyL0o1N2ZvZG0vbkVLS1hlYUNtUmp1dHdSaHJj?=
 =?utf-8?B?NUVSWmpxdklzKzN3c2ZWcis5VHFYRXRJTGNXb1hRd2hySDgxWUdSRTQ0eG01?=
 =?utf-8?B?bmVQYVZDMVVKWU90YWVmSmhFWGg0dUlJT1hIc1dRZStDNDl2Q2hQR2ZlaVFD?=
 =?utf-8?B?MDUreWZRYUVhWVdkNG5PWlQyMlhIVkJVVXpZSnhmTFM2SFBvaFpOWWNjMmNU?=
 =?utf-8?B?WElkYUozSmZFbFVmSU00akpDb3FnT0YyTlpVd3FHbU1sVXhWK3J4Nk5qako5?=
 =?utf-8?B?VEJFMGNkQXZHdUZiaVZ2azNyaWcrbWRiTDBmMXNUc3c1d0p3c25DZ0JVMy9B?=
 =?utf-8?B?cXA3NzBzbmpQZlpYWE5oNTJQbnVLR1pUZ2FEZGhiRmNjTFlOOXV6OEN4ekF4?=
 =?utf-8?B?cVBrcTQxQmZpb0dFVVJFQ29TdkFabVNZMnRSTGw3ZHJwWEF1dWtHWnBKVzk0?=
 =?utf-8?B?UnJLeVNiUjhRUCtqcWZBamwzWXhhVXJwbmJpNm9HZHJQbVZJTFlCYnNaTWJI?=
 =?utf-8?B?eXNBcU1mdDdBeVZmU09WeHpMc2hxUTVHSm4rbEloc0FONG1BOVMySHZzNzFI?=
 =?utf-8?B?OE9tc09rOXdwRTdwWTZMMi94TGd4S2JtTUorekdrTjRCL3B5dUdaYjlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7012.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXAzUC9JbUlxalVEVkZzaWhWcmI2RVBjOHFkL1BOR2hMbEZTcHhNMUZ0b1FH?=
 =?utf-8?B?VmdrcE05aFQ5K0d0ZkVlQ3Q0SHl2WTIvRVJuTHFrMkcwSDRjNVRFcVQybWlK?=
 =?utf-8?B?UmhhQVNhbGE2c00vRHJXSytTSEtVclpzQnJJTEhSUzJ5a3JEdnBHeGk1bGVG?=
 =?utf-8?B?eTVjbzA1U2VaWVpSVFBOamF4bGwxeFdLdnMyaXhtYndSNFQ4NU40YjZUMmkw?=
 =?utf-8?B?dU0zV1NMZmFsUU1RMjlZY2p1dG9RMHAxVlJmdE5MME9Ud2RRZkRmdWFrSWVr?=
 =?utf-8?B?Ry93Z2tuSThLQWhCVFRsWjRBY2wrWHd4MzVDZWlldmM4T2pUcWh3U0c0c3Y0?=
 =?utf-8?B?NXlCN0d0ZXNNaHNZV0c2WW1SZXM0elNHbjA4RWgrOFl1NWpjZkQ4NTFCSitH?=
 =?utf-8?B?RFZLbUp6RDFISFg3ZGhrMGJWelNzRSsxNVo1clZTc21QZGNXUkZHUU0wRUVX?=
 =?utf-8?B?dXExQnp3bzE0WHVZbFd4MklGaFd3bk8zWXZXWWNZdUttNzBzdjRya2lGMHVX?=
 =?utf-8?B?NHJSaEJLZVFsU1ZsQk1UaFoyWEtpZEhKbVpSQUNOYzM1VTllNmNtei9ZaTZN?=
 =?utf-8?B?WE9Pak9YRE4xZFRYaUNGa1VGTHh2RE9PV2sreUZ6K0FYRUQ4SzlwSEtNSW9v?=
 =?utf-8?B?M29INW12TE5sWW84cDVlcWZtNFJwSXlvdjRtR0doMWMwMkxjRjhrTWtpb0FF?=
 =?utf-8?B?aEFUdU16QWkzZ1RYOTdJQXhLVWFtMm5XVGE0cDhucmNNNnBQL2dXc2hoRE5t?=
 =?utf-8?B?OGtrSWRWQllJQisvYjEyUmRQQUkrY3Bhd1VoNGdZcGxMTDlFcC9RY0ZxVVZC?=
 =?utf-8?B?Q3dqUTJZYWlpVEV3c1RORHp4cDR1clRSVk9wR0l3SkhycXplOHVYcmF6d2V4?=
 =?utf-8?B?bGw5Njc0RVk2WFFHTkNKS1RNUnRBTFJxN3dvcklta0R5SmE2V1AzcmY1RUlE?=
 =?utf-8?B?bS9HL0Nzc1o5MzExR1VYTTVIeHl4bFVhWFBneHFwb1lMUmc3disydFZPNDMr?=
 =?utf-8?B?M1NRM3FPS3RLWnc1c3pRdzRsVHk0eGErcjBwRFA1bitCUFdTTS9LVEk0eTNi?=
 =?utf-8?B?VDRldzlwZXJyUTlTRDNLckY3c1Q4L25ZcWgwSzN5amVieUZZOGRyT0ZIQmFn?=
 =?utf-8?B?MkVOSTEyY1N4cHR0STJKeUtiekYvTmJkY21UTkNSV1BESWs2UmlkdGdiRVVu?=
 =?utf-8?B?eTQ0bTVYRFRDcFdXdUQ5NkxzL1NQcEVjTTc4bEJPUEFCcDBTNEVtUGxIcUVY?=
 =?utf-8?B?MzFwMTRzdlc3NDZqVFBuVFpaSmcwdC83dGQ1RHlvMmJybkZBQ3IwMXJRQnNu?=
 =?utf-8?B?cnM1ZFFRZjNxU3ZLaG9KSWNjb1g3OWNJc25OQ3FZY01HYnQzeW1nUVgxMkpj?=
 =?utf-8?B?eENOM1FHZ2E4cFRGeHRZaFpvbWpGUXU4RkQ4Y1ZrQ2UxUFZNNWt5TUhmRHdj?=
 =?utf-8?B?MmZhZnhmZWUwUTQzQ2s3eXk0dnQxUEpCMWtSeFhBV1MxTHJ2Vnk4dGN6UlN0?=
 =?utf-8?B?TmJPMm9qV05BWEl6dVpEd2lNSStHQm8zMTFrWG1zZkpOKyttY3NPU1B0MGZn?=
 =?utf-8?B?eG5tWjM2VC95WVhKRml1NFYxbGFsbXB2bnNBUWxSTU5oeExBTkVrVlVkOThW?=
 =?utf-8?B?dDVnUG5SWURkUjNMZ3k0V2lBcG1iK0pWdi9ZNUM2YzhmR05DanhaK2xEc2I0?=
 =?utf-8?B?NlRFazFZZGcrNlVFRGJiNGt5SGtoSnV3QVlwOHZ6VGkvYnRrMzc3OEx2bWwx?=
 =?utf-8?B?aFhDcHM5YS9MUW5Ob3U2YjdHRmxPaElZb2VIanQzQmhYeHFzQ09qcWdadjJr?=
 =?utf-8?B?Wk4vblB0R2NtLzdUbkhMTWtvYXBuN1AzOVRsT2kya2VSdHZCYWNwUGlPZytu?=
 =?utf-8?B?aTU2K2JOaDRCK29MTDFZQmtRY3BTT3M1NU55Mk1ubjZZbjl5ajVWZytNVFRC?=
 =?utf-8?B?QWJRQlE5Nk42Y1pheCtVZ1FjTFQ1MGJocUV0RlVHOWM4MW90alJrb2NHM0FP?=
 =?utf-8?B?VTVsQTBFVGgwNzlOSkNVSUdPQWNMVVFVd0xnbnA5RDVwek9uZVh2UUhvVTFE?=
 =?utf-8?B?Ynl6aFRHTlNTTTRrWTlxUjZSMzNlOFlMUDVHMUZiV1M1K3VPcy9wQVhZNFFK?=
 =?utf-8?B?dXVKT1A0VHRUaEhLNkVvU3Ayc3BkU1VUMmRIbWpXR2RyVmtlY0pTWFpNd2ZD?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba115eda-09ba-4449-7f04-08dc68536229
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7012.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:50:51.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3FFe5BRmNfMQO4au7J9T2Tz6kbTl++2VJoIKXtH/m/NSNu4DTCG885hhfks5f33YhdZD80DvjBgFAXVHUwabA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6773

On 29.04.24 15:23, Marek Vasut wrote:
> On 4/29/24 1:46 PM, Ronald Wahl wrote:
>> Hi,
>
> Hi,
>
>> for the spi version of the chip this change now leads to
>>
>> [=C2=A0=C2=A0 23.793000] BUG: sleeping function called from invalid cont=
ext at
>> kernel/locking/mutex.c:283
>> [=C2=A0=C2=A0 23.801915] in_atomic(): 1, irqs_disabled(): 0, non_block: =
0, pid:
>> 857, name: irq/52-eth-link
>> [=C2=A0=C2=A0 23.810895] preempt_count: 200, expected: 0
>> [=C2=A0=C2=A0 23.815288] CPU: 0 PID: 857 Comm: irq/52-eth-link Not taint=
ed
>> 6.6.28-sama5 #1
>> [=C2=A0=C2=A0 23.822790] Hardware name: Atmel SAMA5
>> [=C2=A0=C2=A0 23.826717]=C2=A0 unwind_backtrace from show_stack+0xb/0xc
>> [=C2=A0=C2=A0 23.831992]=C2=A0 show_stack from dump_stack_lvl+0x19/0x1e
>> [=C2=A0=C2=A0 23.837433]=C2=A0 dump_stack_lvl from __might_resched+0xb7/=
0xec
>> [=C2=A0=C2=A0 23.843122]=C2=A0 __might_resched from mutex_lock+0xf/0x2c
>> [=C2=A0=C2=A0 23.848540]=C2=A0 mutex_lock from ks8851_irq+0x1f/0x164
>> [=C2=A0=C2=A0 23.853525]=C2=A0 ks8851_irq from irq_thread_fn+0xf/0x28
>> [=C2=A0=C2=A0 23.858776]=C2=A0 irq_thread_fn from irq_thread+0x93/0x130
>> [=C2=A0=C2=A0 23.864037]=C2=A0 irq_thread from kthread+0x7f/0x90
>> [=C2=A0=C2=A0 23.868699]=C2=A0 kthread from ret_from_fork+0x11/0x1c
>>
>> Actually the spi driver variant does not suffer from the issue as it has
>> different locking so we probably should do the
>> local_bh_disable/local_bh_enable only for the "par" version. What do
>> you think?
>
> Ah sigh, sorry for the breakage. Indeed, the locking is not great here.
>
> I am not entirely sure about the local_bh_disable/enable being par only.
>
> I will try to prepare some sort of a patch, would you be willing to test
> it on the SPI variant ?

Yes, I can help here, thanks. Meanwhile I also have some good understanding
at least on the TX path because we had some issues here in the past.

I will come up myself with another fix in the interrupt handler later. We
currently reset the ISR status flags too late risking a TX queue stall with
the SPI chip variant. They must be reset immediately after reading them.
Need
to wait a bit for field feedback as I was not able to reproduce this
mysqelf.

- ron


________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.

