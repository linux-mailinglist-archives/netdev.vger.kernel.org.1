Return-Path: <netdev+bounces-163307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43018A29E47
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BD1188856D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 01:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A5748F;
	Thu,  6 Feb 2025 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="K5+6F663"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE9802
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738804555; cv=fail; b=a0RoFYCOCaWGu4UfcAczpRxwRH7PYfw9NIT2JgNBana5zZ0KrZuhAwmp09RaoDBGC9ZJInTVxXFiivM0I1pAE/DK8PELNiiv5pVWneQ0t0oKACkm//9uB6eVkopSICv8PyTW/vZrYNxK3FBMWOuEXCPx3q0vo6+4oB8njsAFkLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738804555; c=relaxed/simple;
	bh=cU5j4zujB5SWqxhzKw/SKLMH1TPVfyeITrrmJhznJrY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ibIoFuuSUAf5Zn9vVt10oG+jUG+0bomEhJGYe3bQJHXO3fRhtY5ZYbKqo/Ctddagx1u0LDrRTDvWK3Sw3U5G+409nRc4S+LNa9ooBHWVljRmY+7L1uCf5UO1S/Cw8tVDlwgNs/Kx0/CnSrqlraQts+rDlMhZ77llrBJn7OzJ+8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=K5+6F663; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1738804553; x=1770340553;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=cU5j4zujB5SWqxhzKw/SKLMH1TPVfyeITrrmJhznJrY=;
  b=K5+6F663XmEWx6/s7h0QMfURiS1O0rs5A9hXlJFD54rLknD5/hHfLdNL
   6pESYcLxRQ3KzaCRKjwNrDCx6J4qV2Fz22LMUh2NFejhYSBg8sUrr8ylC
   H4wHjM+XynATTHXwLgPJB1Kgla58IbSlXDrXElUf0TLWMGRYf7MgxBFOA
   8=;
X-CSE-ConnectionGUID: w/ZbmduLSm65IuE+uOJZ1g==
X-CSE-MsgGUID: TozNk5GfTuqZhl56NIaxEQ==
X-Talos-CUID: 9a23:loW+i2M7QgobLe5DR25V/ksYB+QedyOA7Wr9YFKfK1QwR+jA
X-Talos-MUID: 9a23:3h9DlwjbCg/G+MuQVHmqJcMpCMB6xafzJ04xjIw0u83ZawpRMiewtWHi
Received: from mail-canadacentralazlp17011052.outbound.protection.outlook.com (HELO YT5PR01CU002.outbound.protection.outlook.com) ([40.93.18.52])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 20:15:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ftj/wtzSGKm6KWPcNFYTwL47v8W2KxArehaHra+2Ze7L85BBC4vpSPssFRb+8OUkZ/uvQvmv1Qt9mF+qI7qRXuocjg7Hy4cGFnA62jm0pUml68i7fWOxRG0I5aGFhFbZT1YxlT44Zrq11bMsyUbHRbHWQbNzoG0ha7G2dtAix+mAmtdRUJAnStLwNM3LTdCgprAQBIPdt0ib3yEC43J+sleXRnNVSNHytLolurYQExpZwfcotPflvzKI04tbSs4M+/uqjzTztqXgnUEib5HtREvHxHv9l8pIjQj6oZjiaB2JwfHZbChjRwiOsxdM+i4ty16r55XgWVM9Qfbc3yGghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6w3lKgS3/c2RDOExBttUC8GZyVbCS5JJiFO+WOFUjQ=;
 b=yVR4xysq9o+mlgsztywuckPoecLazaabzknR0kPvL08w5Si+WCdTibC56kLSz8V9MR2vSy1K9i+JWPnvP6OVsR8lKqYkVX+OpOKO9W1uT7MYo4TSFqcZ9jSzIUY1Rl7MagUrYBcM0uHZNz282/7a2jsCKtWji4UcQA5zpOVrk+ec3XaPkMzGD6I8l0G2RsxI27HBUgbi8kUIytVMGrkPMqhKv340ltAsOtXM839T3kpJPNLyZEyO2D6A9Yt+4W5jnwH2WYl6RO/kWn9svzYyeRj7C0cTtGeyQl3l+wbd5KfTJFFy5+xamiMBNJK+f7O2qcFCN7Fd/ilG7YE8ZQhwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YQXPR01MB6528.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 01:15:48 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8422.011; Thu, 6 Feb 2025
 01:15:48 +0000
Message-ID: <b2c7d2dc-595f-4cae-ab00-61b89243fc9e@uwaterloo.ca>
Date: Wed, 5 Feb 2025 20:15:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
 <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com>
 <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YQXPR01MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 766a84b4-09f0-4422-1e0c-08dd464bc972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWNsSzVkNnRiZEtxMm95Um0rK1QzYjBXUHQ5cHJYekFSU0pKMmxSUUhBeTB3?=
 =?utf-8?B?S1NaMGdEeG5JcHVLOTFTQ2p4N3ZkazZUa2VrSnJnOGlUQlpwZzB5SktHdjda?=
 =?utf-8?B?TFVaU3VqNzZmbE1BU1g2SW5UV0R2T0luenhxQitzaWtNN25ST2dLVFRST2VN?=
 =?utf-8?B?UWdVVHlHdkozR3RSTVEyWFdoNTNNdWxLMEkrWERQamdHeEZmYUhOSllQczVQ?=
 =?utf-8?B?R2hsNFRtYk9yalBBYm1DS2RlSUY5TDJveW9CSXJxaDVhelN0eisxUEpSR2JE?=
 =?utf-8?B?UmYrYmhFV1kxUmJta0FyRU13S1g4cVhySUJMcUhPTmZocElyeUNacVVMdVdr?=
 =?utf-8?B?ckhFVWtCemNpZFRnWlI2Y1UzcGNlYkRpOXN3ZEN0YmhHVGp0OTFEQVNkRExI?=
 =?utf-8?B?dVdHYmhoVkJNZWpvUFBoY2g0YU5mWkI5OG9VQXU3K3dpR1R0T0Npck4xM05h?=
 =?utf-8?B?QVgzL1FyQWdMVkZ1NFN0TjhBNDBEZnVhM0lGNGthbnhpZDNPRjVVcWFJcEVs?=
 =?utf-8?B?dkFhNFNKTkhWQU1VRGNMR3EydU0rL0F4M3RITUhINkp4bXU5ajF3SXFDNXZ2?=
 =?utf-8?B?QXE0aTd3eDJ4T2h6Wi9CcWk2VlhialY4ZFNmM1J6UE96SkFDVmlxakxnc2pt?=
 =?utf-8?B?UzNXSTVTNXJPYzhUVEpFWi9TSVI4LzB3dVhWZUs0OFZZa2srK0NtelNIU05t?=
 =?utf-8?B?aFNEM0NHdGFNNzI4RXl0bjZOUlB1Q0NFSFhVVGFmVnBSK2I0a3B2VUtvR0dY?=
 =?utf-8?B?ekxiWkVLRHI0LzdXQXNVVHhMdGJ2dUQ0bmlTSG1JNzJlM2NsU2FUaWdYMzlz?=
 =?utf-8?B?bW5MWDBtK2h0RHBXMkJDVGRqbit3YnpySW5TcHhmbUhWTGp2K0pOd1BoeUll?=
 =?utf-8?B?OGZLOFFYWk5wdDg2TzJQeUdSd2d6dEttSGhkUitjTnFGNi8xSExtSVQ1NGdC?=
 =?utf-8?B?MjBlRnJKdkFVV2IxeE9FSlpxZWVEOFhoYmJENjZoNmp2VXdHTjJOVXlySWhR?=
 =?utf-8?B?U3F4K1FibUV4aU92TXpYOWx6OHZNVTFDN05IVkxmWFlSNkVaa2c0VVNQVkIy?=
 =?utf-8?B?eTBNRXNjVzFGTzgyajBRRG11VER2aGFSdytrZkd4VGUrN3daQ0wrbFcydVFE?=
 =?utf-8?B?QjBrWmIwaEllaW0wZjB3elk3M0VsRTVibEV4NFZLV3FtSWhwSGFldVg5a1FR?=
 =?utf-8?B?ZWpTUXdHUjlXN2NRdTkyYlZVNnBMYzdRQy9nOUdGRUowOUM4NjhUUVV5UjN5?=
 =?utf-8?B?ZDI5T0ovc1RTcE0rWDlsQW5BSWNGeFIrckhOMkxpRnQ2T2ZOTVBEYUZkaXM4?=
 =?utf-8?B?dUc2eGZ1K2ppNGcyQnRhaHZreHZRdGtBS0dXS01veHpRS1NiUWVIa09uR1Rl?=
 =?utf-8?B?V0R3UkJ0RG1LWVBVOTlJRGJzeFlqR1czZEtyLzhPWTB1T1Y1amxsc1pTZEVv?=
 =?utf-8?B?UXlUaFgrQ1ZXa080U3N0bCtnMWZCU0tJWEc3TWJpTWdzTk1zaEplcUkvT3BW?=
 =?utf-8?B?dlhwcjlNTGNFVTZZSEMrSVF5blQrOXRRaEZXSHF0Mk82Uko4S0NUa2VWS0Rj?=
 =?utf-8?B?ajkybXRqTkZrMXY4KytBclRpLzd2akpSZlpmL1FQM3l2N2ZKT0UzcElaZGY0?=
 =?utf-8?B?c09mbDhka0hpeXdwK0lWK0FkdSt1UVhacUhYTzNsNmRWaG5Ea1JSWWJtS1ky?=
 =?utf-8?B?TkQxY0xZazJuQWxoOEkwQlpFSmNGR2ZlYkhlMTFjSFUxWENhSXk0TUNYWnhD?=
 =?utf-8?B?SFVrNEFKbEJSUEhqekVqaHg2VU9KRm5PRC9XbTc4LzdVNHprYTBPa1FZT1ps?=
 =?utf-8?B?NmVtcjRPaThCcEpQWFhzV2d2VWJ4d0JKajkxVjIwUkNTUTkzeFdiRU1TbUlz?=
 =?utf-8?Q?WU3qj3SWVnlFB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0E4dTB3N2I1WSswQm1ySmdqZUMxREQzTjZrZGI5RlZ4MjZiWFNSZy9heUtk?=
 =?utf-8?B?QmpJSnh4K2Q4ZFdvaDV4elBPUUNORFRKV3FvMVd6MHpEb3hrK0FiVUVnRGpO?=
 =?utf-8?B?bGhKNGZ4UXQ5MzBLSVQxS1dSRTRLY1hPcnd1SnZpQlkwdW1McnFOYk9XVjVE?=
 =?utf-8?B?bmdDdHI4NTYvWXJEQVdTOGxDbEZkM1k5TWhyd1FwdU5aMFFXUk42dnFLZmVI?=
 =?utf-8?B?a2h3QUgzYXhub1VYTmxWSUV2ZzY4bVBTREgrYmUycC9aWFdrcVkwQnl2S2Zp?=
 =?utf-8?B?cFRRWS9yd1V5MmxXVmFMaDFtbmdlQS9IM04venA4WTFiZDZURkNyd2o3RldZ?=
 =?utf-8?B?UHAvZEdqRG1HQ1lJcWdjc0xVaHRkTVkwMU9tZUtOWFZVdWcySGZVWmN5Z2xM?=
 =?utf-8?B?YXN5eTNneE5kR0dnNFE5SjFBOVVJeDlINzBwb1BtQ1J5ZDNaZjExck04R3I1?=
 =?utf-8?B?NVZwQU1pbUlKWVhSOVNoRGtWUlR2K2hmL2dUZVdWMUxJcWwyUThyM3laekk4?=
 =?utf-8?B?YVg3eEFnUjQwWTFwTlVWZDJZeWJ6SnpPNGhHdGVQK0JJeW1kcWNkSThUdnhN?=
 =?utf-8?B?YWRTUGVqdkNTM0Rad1pRWjVLNjhDZ1JUbURvUUhRcmpROWpNZWxjeGZlNjh4?=
 =?utf-8?B?c2g0U2VsU0U0TDUrQ255T1pZZmx6OWxhUFRBVnFpMk16M0VkMHZYZGV5dG1i?=
 =?utf-8?B?a0ZNTWYrYWZuMWRyRmZlenU5c0tMMHo4Q3pLVFg0eDlwQ3JOV2lVSWh4ejZE?=
 =?utf-8?B?dFhVelNTa0pjYVdDc2M1UGxsZGpoNmV1YThSNFBmK1BWeDVSNFhqdWpIUytv?=
 =?utf-8?B?bmhIV3VSckhNcDgxRVE3SE9paFR2THhWQkpXMmdJYW1wTE0vY3UwODBQbVFY?=
 =?utf-8?B?QzBRTkwxV1I4djRrM0xXd1ltQ0VkcDBnenZNUXN2b0tGWnhOZys0L0hqYTd5?=
 =?utf-8?B?WkRZQ2k5OWIwbG12b2QyWENzQ2N2OER3TXRteGFxUFhPdjJUYkRlTklFRDJC?=
 =?utf-8?B?ZVJuV2VBc2s5SzdyRkVRUjJRQm9iTzgwMFZ0Z2Y2Z2orQmdHSWJrK2NNNi8w?=
 =?utf-8?B?MFlXREt6Qm5qRWRJRmJ5aTM5TGFTZkt6Q2pKVG5Cc1JRamVEd2d0Vnlvekcz?=
 =?utf-8?B?WFNIZGdYM2hpUTBCUXVsbGQrS3g2bEZEdkpnSnRuV2FyTXh2akg5SjJCUDMv?=
 =?utf-8?B?eXlUNjBqRnlTVGxEQllLT2R3MjhHMU1JRDZadko1OCtHbDFvYnJCcHlqb0h1?=
 =?utf-8?B?c0NEVHJMclVnQ1o2ZnhrRTFydU1QYzFFMTMxYVZqOHFwZFYrKzRKNjN6K3pi?=
 =?utf-8?B?UjQwbHF6YUVWM2RxcDZaRHgzVk1uR3gycXFoaUNzTDJWRUZERE90NFJxdnZZ?=
 =?utf-8?B?anh3VkhXVlFmNEM5S2NyNUlHT3hOQjFSeU9qT016WXMxY21XSFMvbkx6ZVNr?=
 =?utf-8?B?a295TnREdlpIcEl5QXZDTVRUZlN5bi9DTGtwbzZyWGxNRVpCdTFXU0RGSGJS?=
 =?utf-8?B?RWNScjhjTFRROWZiblZuWGwvS29kQU5aRXJGd0J5aTdoU2dXSjBRRTF0bHJP?=
 =?utf-8?B?bnZXeUpqQ2xTRFNpMlBvL2JxYWdtd2taMDBUSjBtUEZLUE5HNncvTHFHdmtO?=
 =?utf-8?B?aVExMUhTUEVTTlRBSTZ1dGlMVWRYUktaRmUwRXBhUkhDQTVVOTB1UTRJdXVP?=
 =?utf-8?B?OVBiMmdqdDhrVldqenFyYWRrNXNyRXZDenZ2Zk04ZnZhdEZURUZmMjVPVHV6?=
 =?utf-8?B?NUp4bFYxOGhWRFZTQWY0MXRBTVA5bzR3VkZMV1pFem9sTGsxZWNKclRpYW1P?=
 =?utf-8?B?bDNrVmo0SnpXbUpHekh1N29QQnRUMmQ5NDBPNUNuSWV6Q1lvR1dQZ3gyakhQ?=
 =?utf-8?B?YUZ6djFjRjdxb2VjNmpnWVJES05rS2hiSFFpcndiMmZOTlUxRzBaUVpZMzM1?=
 =?utf-8?B?a3o1MndZS1NLUlNFcVBOdHFKU2FrL1VOV2k4UDhiQnovV3hGTThIS3FEOHFa?=
 =?utf-8?B?M2gvWDFWaEJPdDhNRE1CU3ptTmptVUlPU1NuMFpNbzdhVG10S3pCQWNMdE03?=
 =?utf-8?B?b056NnhBNmI5MjQxc2g5djJqMFB6UnZGV1RNWXZHSkI1L0wrMW8rSlNVL0Q0?=
 =?utf-8?Q?WquB36/fCQyTZwaWcNJubzUgj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ItveV4ftdI6YHRdMI/N5dEd2vAARfhgFDapLoGPkaI8TnUxZEHnRDp4w7gERC8eIbXVAsj0t5+j9Z26d19qgJwJK+Vb0A9xn2Joyudd98+WGLmVD0Ed5WFw5aAUyS1SRoq+7ukIW7d88Fb02xhU+se6uEK8Df8FldRtZnA3wzyxeoyiCZyQe8ybHE4nFpz5dozFsjTMNUs4fJyRNTnanFjqg7ZSX/As89HlYfW1zzvtmephvIVIuMZvKJcjIAWDK5rulvkr7LNSH3SOAaLgXBM/FURqr2vi8zwcAo6p9i2YTseB11Pyvgh7H+/rtKBDqdKe/KIN+pDOHjbR3s4+SvYJ3PeKWTpwKrIRKKWOGQBgMpaTB8hutyF7pqyW3B4WihEeSyJNVzvEfEIYyqCXteYyIkAv3fKslN5Ig1+bIze+oIaSWCQZioFxmwCzcNFtx4ZNuq8BxB1Yu5UA24S2kbxm3sWBexdbWXNrE/TWhJXxh4QY4utRCT7nytfFz0MwnXi9DAamVuhJV2bOXkgFnLCkv0AMH9JB7wWnsti9mQ4FsWy7MD2qhQowuEOc01AZNkGbtv6dCen5nEw8NPBNmeqLZYMApIUSGwP/GAjmRw13ne4GhE8yvtGGbH9ycxP3F
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 766a84b4-09f0-4422-1e0c-08dd464bc972
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 01:15:47.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1D/2RZgzmyl/3k5l7FLDAM9dBtv2YkUcjVlTTS1N4d/XsBJyJNAE/1sSzJbsMy7TphdqnR/QjuONAR0gG9IbFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6528

On 2025-02-05 17:06, Joe Damato wrote:
> On Wed, Feb 05, 2025 at 12:35:00PM -0800, Samiullah Khawaja wrote:
>> On Tue, Feb 4, 2025 at 5:32 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>>
>>> On 2025-02-04 19:10, Samiullah Khawaja wrote:

[snip]

>>> Note that I don't dismiss the approach out of hand. I just think it's
>>> important to properly understand the purported performance improvements.
>> I think the performance improvements are apparent with the data I
>> provided, I purposefully used more sockets to show the real
>> differences in tail latency with this revision.
> 
> Respectfully, I don't agree that the improvements are "apparent." I
> think my comments and Martin's comments both suggest that the cover
> letter does not make the improvements apparent.
> 
>> Also one thing that you are probably missing here is that the change
>> here also has an API aspect, that is it allows a user to drive napi
>> independent of the user API or protocol being used.
> 
> I'm not missing that part; I'll let Martin speak for himself but I
> suspect he also follows that part.

Yes, the API aspect is quite interesting. In fact, Joe has given you 
pointers how to split this patch into multiple incremental steps, the 
first of which should be uncontroversial.

I also just read your subsequent response to Joe. He has captured the 
relevant concerns very well and I don't understand why you refuse to 
document your complete experiment setup for transparency and 
reproducibility. This shouldn't be hard.

To be clear: I would like to reproduce the experiments and then engage 
in a meaningful discussion about the pros and cons of this mechanism, 
but right now I need to speculate and there's no point in arguing 
speculation vs. assertions.

Thanks,
Martin


