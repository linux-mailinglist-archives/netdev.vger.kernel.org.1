Return-Path: <netdev+bounces-208774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B902B0D125
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36BE7A4883
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 05:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A528B4EB;
	Tue, 22 Jul 2025 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="DBW3pB3P"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022143.outbound.protection.outlook.com [40.107.75.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D1289E10;
	Tue, 22 Jul 2025 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753161542; cv=fail; b=BlSeCy5f7u0tyLXD3+AZm/MY+fzUm7mEBBymT9jTIA48XR5J5aOn8DPP2iVxn09w1PpV7wdSEj8QAFphlm/el0+Rf4FuAjCOJ2EF3aFoep8yY17o2aVVW6a39nBwIv4OuRlxNo3pq53cC0scaYLShyZdZV0TGkhjNDG099UcjQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753161542; c=relaxed/simple;
	bh=tIW4xkKfRIwBeuhK0QLAXB61/QK98pdhXOPcMgagZNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cmKymDARm8uI9HTe3oegO1RcWf1nWF9m1Cgu1Fz4FyF15b5mLLQSBXmxotJOP9/bGy4vt/9P3wZFkVub63fA/fEBTD5eVfal2Zx3iVPwJHKpjTfQy4G2oTYteFqXNIqTXGSxgloS569zNbuZhTEjxF+7C/1YqtOKUnT//YIcxkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=DBW3pB3P; arc=fail smtp.client-ip=40.107.75.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKZkn2ucA/MNMUlbF/z6LO+nzlMMXZVvmDe/6BOFaP+J6EPNT3INuwv2vah1OARIK/t+vZ3hQyEnnkl808vsg2f4d+Ubj1UyrdDXi6RzY+1hk3QuW+3n5OebwXew16nHAfbmnvFJAVijs4f1bQcsAITP9F2c6hDc1EJIYo6/K+3IcqGVe/8D2Gya1659ICcdBLHK/NRhpFYjFpf2m0gzkNTic3s0E+uu98hw4ExTqzp3k1YjkezMTFqVS067zutKGa4rWkrlN10Q9n1+Nq2zV1HEmcvQiu1zqISBSh5cfvh+XxwU6+khMUEtKxghukFEzlxXHQ98jLosFquG1QPnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCy0IcDUjf7Im7lbrPM9xE44YIvl1+V/jkNy5cEHSIA=;
 b=KPJnvjmQ2v64EzAK+2iSiy52JMp0I5SkTItJ6XEay5LPjU4+8N6KSj5g3U2ffo5fsXdzogkBNf/Gad3FDKTwU2ILnglSUClv9AqcTHFYICC6U5G+6ZsxhHhp1o+UWWip1Zz9wGr9XfVcwREp+SWjN5+ztmpTbuLR5S5CtUkfTKJx+teHkqufVjPtq80l082QiE/nYOlRHScoFLBNtqsWjm2Twyr82RpLJmi2lP+2g+gxVSgk4TOktUb7D2WwsK/z07ECoNlbgTGvwoSmTabsqa4hSiAoLkEHJxi0gVI9w1I6Txt92LxwkAih3g2gRS6QQfZGJRiGxpMB3qEMxLL34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCy0IcDUjf7Im7lbrPM9xE44YIvl1+V/jkNy5cEHSIA=;
 b=DBW3pB3PRW55xT7WYPZ18IbPWWmqDRmvwCpKeOD4tK1Y+8OOi3LOEaeD7/zbK9DeblrnA7pzAjbUiR8Xg3sg4sEVCMmnzXtxB5Fqel/IxRnUah7rPjdsIbgERE86LczJ0um8t5Qpzch7m13log9ip9nGMVE1bW0O0JRUzvUEjC4eM0VuG/vzmWSzhdZDD/1LEW+58VaFYk84p4x1ETyHmEbfF9ZgoZeOSpxFhnupR/eIrHFf/RGTUOoYVFbmkRraVE+Yv1QZGn58D46IAvKf6waflytfo1uJom/IfgLZ2RawWkLxI5BmgHd0xcLCRB4L3VdxXJNLiTPiB1bchywV0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEZPR03MB7897.apcprd03.prod.outlook.com (2603:1096:101:189::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 05:18:56 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 05:18:56 +0000
Message-ID: <9608239e-c9e2-4d54-afe7-41caa831271f@amlogic.com>
Date: Tue, 22 Jul 2025 13:18:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: Add PA_LINK to distinguish BIG sync and PA
 sync connections
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250710-pa_link-v1-1-88cac0c0b776@amlogic.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <20250710-pa_link-v1-1-88cac0c0b776@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEZPR03MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 94778548-51e8-4268-d141-08ddc8df41a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3RLZGd6N1daSHc1aUUxaGQvelRSeVRhSGlCSkNmUlV0bFA4TW12M1RtKzRo?=
 =?utf-8?B?SUVHUDBXNWg3V1pwa1BBcC9Gbmg5dXg1SXN2cFlsdnhjUmxXclVHZEtZNWxD?=
 =?utf-8?B?RGpMZ0Z6UjZhMVhIWU9RVjNsS0g0NkFUc0VLTVF5OXRwTW10RGo3ZEhHcGll?=
 =?utf-8?B?ZEdSRjVsQnQwa05HQUgwMHdCL0NzREw5UUR4TGtmUEJadExiQXZ6NWdtenVY?=
 =?utf-8?B?VUFnZnk0Q0kwak5OUENncStZYVRGdFJObExDbHhIZjdrKzJtRGR1WSs5VFBD?=
 =?utf-8?B?ZWNDVmUzZkVNK08velcxa0tWeS9acmlEdzFtUlF3STROSEZvMWc0b3NqU1Jj?=
 =?utf-8?B?aVRxN0w4NFNUbG9YRUQyeUFsR0x5UnJjQ1FDM2c0SGZHbmF6bldaT3hjTDBZ?=
 =?utf-8?B?bXJaSm5MZ25zUjY5b3pNZW96V2JsVm1RSDgvMVdFWlVaWEM3SEhJNmozcXFH?=
 =?utf-8?B?M1RzN2cyN1dkYkRqOWR6V0ZCdFFtNGdYNkpBVzBaNWhYRmZhUHlxK0wvNGpW?=
 =?utf-8?B?UjBxd2d1NGYwaTZvckp5Yk5CeDZzSmVoU3ZJTGt2WHp0WUtDa1ZMVGxGa29D?=
 =?utf-8?B?UGZaeW5hQkJ2RGQzSEZwN3pLSVcraXMvRzNUd2U5dGU1RklYamxMN0N6ZUUx?=
 =?utf-8?B?SnhVUnBFM3NWYVdEUkJnTTlwakxFOGt2Wkl2RDVnbnJ0RlpudVJ1c2NFTVZY?=
 =?utf-8?B?U0RzdFozNytkMFA0VnAzRFBQWlllaWs4SjhJODFsZWplRkE5Y3JtSFJ2czIy?=
 =?utf-8?B?UFVnaVJ2V2l4V3ErWXZYVDJEUlRGVG1EOGhFblJEdkUrZmw3K1hFaUovNEx2?=
 =?utf-8?B?c2lFajFaOWJYandYQ1liYzdLbUsxNkMxd21Ec21lbDN4ZGU0VnZVOEtUdkxQ?=
 =?utf-8?B?ek9OQkJsMFhOeGY0OVJJb1ZQRXExaUVKeXh3MHM1STFYMVFURjMyeVZ0ZXpt?=
 =?utf-8?B?dFFDL2N6QXI2dkhSeWxEQmxCeFBiVkl6cDFaTnBnTno3T2dpb1VvOEh3K1U4?=
 =?utf-8?B?eDAyaTk3UjZTMEhDSVpkYkdKOFNwcW1haDdQRnk1YlFUMmhjSGw1ZEltS3NN?=
 =?utf-8?B?N29raWYzOVJYaUx4LzlsVy9XcTRxbzBqRjJWdzhNOWZPbnY3dlM5SzFKMzJC?=
 =?utf-8?B?Sk5RTVVyYnEzRmJYblJGNTFCeCtTUG5hVENqaVpCSFRqZlBpZlBTRXc5Nzhz?=
 =?utf-8?B?Sy9Lc2IweUFFaW40cXg0SUp6L1c3UUJWVUp0elg5YmhyK2ZMdW1obE1RYVJE?=
 =?utf-8?B?S2t5WW5KcVhvSnllRTZLakt3YzJCUUEvT2pZdzZmUHVjaFdWWEYyQ1Jsakt6?=
 =?utf-8?B?QVV5WlU1anRkbG53TUdRTDE5dWpPSCszbG5yUTdBaXF5ZFdKc0tEOUhRMzJv?=
 =?utf-8?B?ZkY5cWErWVB2V2JrSExUb3VYNmdXb0FGb0NvaHlJSmh5RXFjK1ZTYTVCbS9N?=
 =?utf-8?B?UlpVMzF1Rzhod1FYU0lkd01yT21qS3NXYklIY3N4cDU3bUdsK05QNnNFd01W?=
 =?utf-8?B?ekllU0wrNVF6K0ZQaUlDQngrTG9XeEdaL05hbG9QVy95T2xQVDFORFhJTUE0?=
 =?utf-8?B?U1Y5eERwdXBwcmNjTWlhaVhSK05VL1RoMHppd0t3TFYyc040a3Q0U2ZBNFA2?=
 =?utf-8?B?WlVVMGtDa1V3S2o1QTlLMnpRenAzMGFiRnNJZlJwdGNXWk5QM0pOd0RQTkQ5?=
 =?utf-8?B?YWVlQjh4dHZLaUJnOFg0UTkxOGhnRTM5WGM4VzBIajZZYUl2b0o2WlhpMFpp?=
 =?utf-8?B?YXU3c3pSd0tjUE81UThzZU4vY1BPZG0wK0oxY2RVV1FKcnFaTUVjbkY3bGYx?=
 =?utf-8?B?aGs3RWFjZjUzUUdWQlNKZFhQNy9VVS9GWG5INFJlU09wckxQS1BXa2dzOER6?=
 =?utf-8?B?bzNzU1ZKT2M2ejBWV0JnTUVGUmsxRzlBREFTN3FlSjN3dzhiMWVlVGZZSVc3?=
 =?utf-8?Q?oTd+EAqvJww=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWQ4d2hSeEd1YUxzSDl1TUJtYkM5bDNRRm5OeVh6b2VDblg3cnhHaEVxcDN3?=
 =?utf-8?B?NTlvdVIvdUdTY09jRTEyY2xGanFtcW9keWI0NGV0dm0zZ29Fc1puVjVyQUV6?=
 =?utf-8?B?QXIyOWRYSUc0R2JQRUpoNnA0TkRmdmxpOTZ4bER4TU9WUUFPU2IzS3ExT2Q2?=
 =?utf-8?B?WkZheDF1Q0ttc2YwVjN6Y2NuakRLZmd4VlFqMUM1ajRkNGFwQUpOTjFybXNW?=
 =?utf-8?B?d3grbkkvczh4YWgyNHFPNHdIQWJLNmJYaTJmZ1N4cmhzanlSc1FMY3Yzb2tR?=
 =?utf-8?B?Y1U4RXFIbXpxNU5ScHNRTWhSSytDc2c3NEFBTmNPTmt2Z0kzMEwvWEZiNUhh?=
 =?utf-8?B?QjlmOXAyVlcrRDdXZVliNURoU3AxVHgvc1M3ZHlEMlVpYllLYnJxd29vZEZ0?=
 =?utf-8?B?ekErNjMrVjF6MGdRVjBZK0lEUkxXQjZBV0RmYlZSUFBqcnZjeGtZZ1pFQ2tp?=
 =?utf-8?B?NGQwMk9XT3U4Qmx5MjVxcUtSRStkNGUxV0tuMG5lS1BVYTQvcDBFcU1zTlBG?=
 =?utf-8?B?OW1RTElFaVlFSHNWWjl2N0ZUejAwTU83ckZlb3hQWGFqUDREU0xGNW5TV2lD?=
 =?utf-8?B?SThrQmRKdUdzVlFUbExrS08zWURrMnVNT205emhRcjA4bkVmZ2kxRTdjRmtu?=
 =?utf-8?B?ZWN3K041bWM0NXNiQWxLYmIzRFl0WU4zNGdVZk0wVytFWUJ1aUlPdEZpTW93?=
 =?utf-8?B?SThMWG05RUVzbXNzTmNYcEpCb2tlYzZjbzJENUpVR2xpeVRMTkJlN05jQWkz?=
 =?utf-8?B?YVN0YW1SNGpYZGlhdWdQaEx6RzhjcUpkNGovcXVMK1RRWW1kd0FPaGp1by9K?=
 =?utf-8?B?NjZQRDJOUjdQa2hCSkdnelRZWU9xcWVxdmJob1p0a3VXRHliRnNtZTRqRVFT?=
 =?utf-8?B?WTM1Q1ByZlFIWUVUblphZUpCZ2RFQkprMDJxK21zMHZhT05pazVRallHYzFw?=
 =?utf-8?B?dGlpZWNsUkZIODZMK3ZOZlcrUDJUd0hkTDlMRkE1cWZKbVVweVNsVzI3S1hn?=
 =?utf-8?B?bkhHWFNDZ1hlaDVEVHY3UXhxekoyNEY4M0tJdTRCUFVNSTVhSjNaYXJ5cndq?=
 =?utf-8?B?MmNQSW5SWlhsMUEwcDZiVGRXbXJaeDFQUEM0b0ZyRGE0djRJM0NYb0NhRDlF?=
 =?utf-8?B?VFd3MzNhamJWVTZuQ3FRc2h4Y2M2TjUyRXFUY3FhUUdCRVB6NndWcXh5SGZ0?=
 =?utf-8?B?bW82a1hNVGJ4cGR6UzB3VlBJQ1hnRnVrYWg0anZjQzhXdlh4eFNiYWg2YWRF?=
 =?utf-8?B?NG5hcmdDN0dGUDNWK1R2azhhYUtxdVYyajBHL2dFbzZEVXVNOS9tZTI4Q3Ra?=
 =?utf-8?B?MWN1eTJyemJwNWFDSnVpQ2FzT0xTMWgzOExCMnJtUjZlcVQvdEpFOVpBZVlz?=
 =?utf-8?B?dDRwdlJaMWFTSlVBdVo3Y1R2b3h1VnhzeTNSWk5KdkZNZGw1UkNKbzR6VXd5?=
 =?utf-8?B?SVdMeHE1SDRWQk10S0ExQVpkNVk4VU1oQ2RGTEN5cU9qYjJXWXhuMTJUVzEr?=
 =?utf-8?B?VHZLS25WckY5Rmc4Y2JBRVRwZHlpMXQyNnQrbTM3YlhlZFRyVktBYjlGbTJr?=
 =?utf-8?B?R0xhZjdjMEFBUTJPRnNMNUhJQ0V3UDBNL0c4T0FNNTE2VCs1MFc5OVdxdVVv?=
 =?utf-8?B?czZIZ0ZDcUZzc3JsdGtvUWFnZXdJMS9aSUZlQzJFbGpmK0J5RmZNdUpVN2Fv?=
 =?utf-8?B?bDJTOTdKcjMzNHV4eE1UeTZ1VDZGeTdEYVlPQU5qZ0dsN09TRS9iNDNNVE4w?=
 =?utf-8?B?OU5HdFIrRTQ1d3I0b0JqSGhkUVdmcThhRWx6MjBGRUlpWUU5YzhYdUMvQ2xi?=
 =?utf-8?B?a0VaY2pTdFEzZzdPcitmQzU3WEhWL2I0dGhSa3VqVW9JQ3lERms1Y0RhZmc2?=
 =?utf-8?B?cFcwaVZYWFlRYk8wbmJmUWdmNHBHYjNKUHppNHZ4aDFWYlRnbUpXNmFValp1?=
 =?utf-8?B?VFYxRFYwT0hmaWc0c00xWUxQVGRCTW1wazZLeXhNNGhjNE1wdmVMVDFhelo5?=
 =?utf-8?B?ZXZWakM1akx2TFcxbmRWUkFjNEJyYUtPT0FrL2N3b3dpUXZieUdiV1B2ODk3?=
 =?utf-8?B?Y0Y3NFZVWDZsblJRajVkT2M4d0t1VE4xbXk1RmlGZUhvVldRM3lxYUxnT2RW?=
 =?utf-8?Q?SxBa4cnatsyEYHC8Pk1CtRH6s?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94778548-51e8-4268-d141-08ddc8df41a4
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 05:18:56.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0CE5bNHJXyip4iemMx8DZVRj36VMuQHXlw1t4gwkiYUaBtE/GfdPQR82no4fCLGuGITbRi2kB4aSQa8keozYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7897

Hi,

Just a gentle ping regarding this patch.

Best regards,

Yang

> [ EXTERNAL EMAIL ]
>
> From: Yang Li <yang.li@amlogic.com>
>
> Currently, BIS_LINK is used for both BIG sync and PA sync connections,
> which makes it impossible to distinguish them when searching for a PA
> sync connection.
>
> Adding PA_LINK will make the distinction clearer and simplify future
> extensions for PA-related features.
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>   include/net/bluetooth/hci.h      |  1 +
>   include/net/bluetooth/hci_core.h | 10 +++++++---
>   net/bluetooth/hci_conn.c         | 14 +++++++++-----
>   net/bluetooth/hci_core.c         | 27 +++++++++++++++------------
>   net/bluetooth/hci_event.c        |  7 ++++---
>   net/bluetooth/hci_sync.c         | 10 +++++-----
>   net/bluetooth/iso.c              |  6 ++++--
>   net/bluetooth/mgmt.c             |  1 +
>   8 files changed, 46 insertions(+), 30 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 19248d326cb2..50134b48b828 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -560,6 +560,7 @@ enum {
>   #define LE_LINK                0x80
>   #define CIS_LINK       0x82
>   #define BIS_LINK       0x83
> +#define PA_LINK                0x84
>   #define INVALID_LINK   0xff
>
>   /* LMP features */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 3ce1fb6f5822..2ebadd45fabb 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1005,6 +1005,7 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
>                  break;
>          case CIS_LINK:
>          case BIS_LINK:
> +       case PA_LINK:
>                  h->iso_num++;
>                  break;
>          }
> @@ -1032,6 +1033,7 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
>                  break;
>          case CIS_LINK:
>          case BIS_LINK:
> +       case PA_LINK:
>                  h->iso_num--;
>                  break;
>          }
> @@ -1050,6 +1052,7 @@ static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
>                  return h->sco_num;
>          case CIS_LINK:
>          case BIS_LINK:
> +       case PA_LINK:
>                  return h->iso_num;
>          default:
>                  return 0;
> @@ -1132,7 +1135,7 @@ hci_conn_hash_lookup_create_pa_sync(struct hci_dev *hdev)
>          rcu_read_lock();
>
>          list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type != BIS_LINK)
> +               if (c->type != PA_LINK)
>                          continue;
>
>                  if (!test_bit(HCI_CONN_CREATE_PA_SYNC, &c->flags))
> @@ -1327,7 +1330,7 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *hdev,
>          rcu_read_lock();
>
>          list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type != BIS_LINK)
> +               if (c->type != PA_LINK)
>                          continue;
>
>                  if (handle == c->iso_qos.bcast.big && num_bis == c->num_bis) {
> @@ -1397,7 +1400,7 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
>          rcu_read_lock();
>
>          list_for_each_entry_rcu(c, &h->list, list) {
> -               if (c->type != BIS_LINK)
> +               if (c->type != PA_LINK)
>                          continue;
>
>                  /* Ignore the listen hcon, we are looking
> @@ -1996,6 +1999,7 @@ static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
>
>          case CIS_LINK:
>          case BIS_LINK:
> +       case PA_LINK:
>                  return iso_connect_ind(hdev, bdaddr, flags);
>
>          default:
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index f5cd935490ad..4042e75c33a6 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -785,7 +785,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
>          d->sync_handle = conn->sync_handle;
>
>          if (test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags)) {
> -               hci_conn_hash_list_flag(hdev, find_bis, BIS_LINK,
> +               hci_conn_hash_list_flag(hdev, find_bis, PA_LINK,
>                                          HCI_CONN_PA_SYNC, d);
>
>                  if (!d->count)
> @@ -914,6 +914,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
>                  break;
>          case CIS_LINK:
>          case BIS_LINK:
> +       case PA_LINK:
>                  if (hdev->iso_mtu)
>                          /* Dedicated ISO Buffer exists */
>                          break;
> @@ -979,6 +980,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
>                  break;
>          case CIS_LINK:
>          case BIS_LINK:
> +       case PA_LINK:
>                  /* conn->src should reflect the local identity address */
>                  hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
>
> @@ -1033,7 +1035,6 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
>          }
>
>          hci_conn_init_sysfs(conn);
> -
>          return conn;
>   }
>
> @@ -1077,6 +1078,7 @@ static void hci_conn_cleanup_child(struct hci_conn *conn, u8 reason)
>                  break;
>          case CIS_LINK:
>          case BIS_LINK:
> +       case PA_LINK:
>                  if ((conn->state != BT_CONNECTED &&
>                      !test_bit(HCI_CONN_CREATE_CIS, &conn->flags)) ||
>                      test_bit(HCI_CONN_BIG_CREATED, &conn->flags))
> @@ -1152,7 +1154,8 @@ void hci_conn_del(struct hci_conn *conn)
>          } else {
>                  /* Unacked ISO frames */
>                  if (conn->type == CIS_LINK ||
> -                   conn->type == BIS_LINK) {
> +                   conn->type == BIS_LINK ||
> +                   conn->type == PA_LINK) {
>                          if (hdev->iso_pkts)
>                                  hdev->iso_cnt += conn->sent;
>                          else if (hdev->le_pkts)
> @@ -2081,7 +2084,7 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
>
>          bt_dev_dbg(hdev, "dst %pMR type %d sid %d", dst, dst_type, sid);
>
> -       conn = hci_conn_add_unset(hdev, BIS_LINK, dst, HCI_ROLE_SLAVE);
> +       conn = hci_conn_add_unset(hdev, PA_LINK, dst, HCI_ROLE_SLAVE);
>          if (IS_ERR(conn))
>                  return conn;
>
> @@ -2246,7 +2249,7 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
>           * the start periodic advertising and create BIG commands have
>           * been queued
>           */
> -       hci_conn_hash_list_state(hdev, bis_mark_per_adv, BIS_LINK,
> +       hci_conn_hash_list_state(hdev, bis_mark_per_adv, PA_LINK,
>                                   BT_BOUND, &data);
>
>          /* Queue start periodic advertising and create BIG */
> @@ -2980,6 +2983,7 @@ void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
>          switch (conn->type) {
>          case CIS_LINK:
>          case BIS_LINK:
> +       case PA_LINK:
>          case ACL_LINK:
>          case LE_LINK:
>                  break;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 42f597cb0941..d1c7becb0953 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2936,12 +2936,14 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>          case HCI_ACLDATA_PKT:
>                  /* Detect if ISO packet has been sent as ACL */
>                  if (hci_conn_num(hdev, CIS_LINK) ||
> -                   hci_conn_num(hdev, BIS_LINK)) {
> +                   hci_conn_num(hdev, BIS_LINK) ||
> +                       hci_conn_num(hdev, PA_LINK)) {
>                          __u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
>                          __u8 type;
>
>                          type = hci_conn_lookup_type(hdev, hci_handle(handle));
> -                       if (type == CIS_LINK || type == BIS_LINK)
> +                       if (type == CIS_LINK || type == BIS_LINK ||
> +                           type == PA_LINK)
>                                  hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
>                  }
>                  break;
> @@ -3396,6 +3398,7 @@ static inline void hci_quote_sent(struct hci_conn *conn, int num, int *quote)
>                  break;
>          case CIS_LINK:
>          case BIS_LINK:
> +       case PA_LINK:
>                  cnt = hdev->iso_mtu ? hdev->iso_cnt :
>                          hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
>                  break;
> @@ -3409,7 +3412,7 @@ static inline void hci_quote_sent(struct hci_conn *conn, int num, int *quote)
>   }
>
>   static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
> -                                    __u8 type2, int *quote)
> +                                    int *quote)
>   {
>          struct hci_conn_hash *h = &hdev->conn_hash;
>          struct hci_conn *conn = NULL, *c;
> @@ -3421,7 +3424,7 @@ static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
>          rcu_read_lock();
>
>          list_for_each_entry_rcu(c, &h->list, list) {
> -               if ((c->type != type && c->type != type2) ||
> +               if (c->type != type ||
>                      skb_queue_empty(&c->data_q))
>                          continue;
>
> @@ -3625,7 +3628,7 @@ static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
>          else
>                  cnt = &hdev->sco_cnt;
>
> -       while (*cnt && (conn = hci_low_sent(hdev, type, type, &quote))) {
> +       while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
>                  while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>                          BT_DBG("skb %p len %d", skb, skb->len);
>                          hci_send_conn_frame(hdev, conn, skb);
> @@ -3744,8 +3747,8 @@ static void hci_sched_le(struct hci_dev *hdev)
>                  hci_prio_recalculate(hdev, LE_LINK);
>   }
>
> -/* Schedule CIS */
> -static void hci_sched_iso(struct hci_dev *hdev)
> +/* Schedule iso */
> +static void hci_sched_iso(struct hci_dev *hdev, __u8 type)
>   {
>          struct hci_conn *conn;
>          struct sk_buff *skb;
> @@ -3753,14 +3756,12 @@ static void hci_sched_iso(struct hci_dev *hdev)
>
>          BT_DBG("%s", hdev->name);
>
> -       if (!hci_conn_num(hdev, CIS_LINK) &&
> -           !hci_conn_num(hdev, BIS_LINK))
> +       if (!hci_conn_num(hdev, type))
>                  return;
>
>          cnt = hdev->iso_pkts ? &hdev->iso_cnt :
>                  hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
> -       while (*cnt && (conn = hci_low_sent(hdev, CIS_LINK, BIS_LINK,
> -                                           &quote))) {
> +       while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
>                  while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>                          BT_DBG("skb %p len %d", skb, skb->len);
>                          hci_send_conn_frame(hdev, conn, skb);
> @@ -3785,7 +3786,9 @@ static void hci_tx_work(struct work_struct *work)
>                  /* Schedule queues and send stuff to HCI driver */
>                  hci_sched_sco(hdev, SCO_LINK);
>                  hci_sched_sco(hdev, ESCO_LINK);
> -               hci_sched_iso(hdev);
> +               hci_sched_iso(hdev, CIS_LINK);
> +               hci_sched_iso(hdev, BIS_LINK);
> +               hci_sched_iso(hdev, PA_LINK);
>                  hci_sched_acl(hdev);
>                  hci_sched_le(hdev);
>          }
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 2c14e9daa199..d1e77dfe9edf 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4433,6 +4433,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
>
>                  case CIS_LINK:
>                  case BIS_LINK:
> +               case PA_LINK:
>                          if (hdev->iso_pkts) {
>                                  hdev->iso_cnt += count;
>                                  if (hdev->iso_cnt > hdev->iso_pkts)
> @@ -6378,7 +6379,7 @@ static void hci_le_pa_sync_established_evt(struct hci_dev *hdev, void *data,
>          conn->sync_handle = le16_to_cpu(ev->handle);
>          conn->sid = HCI_SID_INVALID;
>
> -       mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, BIS_LINK,
> +       mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, PA_LINK,
>                                        &flags);
>          if (!(mask & HCI_LM_ACCEPT)) {
>                  hci_le_pa_term_sync(hdev, ev->handle);
> @@ -6389,7 +6390,7 @@ static void hci_le_pa_sync_established_evt(struct hci_dev *hdev, void *data,
>                  goto unlock;
>
>          /* Add connection to indicate PA sync event */
> -       pa_sync = hci_conn_add_unset(hdev, BIS_LINK, BDADDR_ANY,
> +       pa_sync = hci_conn_add_unset(hdev, PA_LINK, BDADDR_ANY,
>                                       HCI_ROLE_SLAVE);
>
>          if (IS_ERR(pa_sync))
> @@ -6420,7 +6421,7 @@ static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
>
>          hci_dev_lock(hdev);
>
> -       mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flags);
> +       mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, PA_LINK, &flags);
>          if (!(mask & HCI_LM_ACCEPT))
>                  goto unlock;
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 4ea172a26ccc..d9bb543063fa 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -2929,7 +2929,7 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
>                  if (sent) {
>                          struct hci_conn *conn;
>
> -                       conn = hci_conn_hash_lookup_ba(hdev, BIS_LINK,
> +                       conn = hci_conn_hash_lookup_ba(hdev, PA_LINK,
>                                                         &sent->bdaddr);
>                          if (conn) {
>                                  struct bt_iso_qos *qos = &conn->iso_qos;
> @@ -5493,7 +5493,7 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
>   {
>          struct hci_cp_disconnect cp;
>
> -       if (conn->type == BIS_LINK) {
> +       if (conn->type == BIS_LINK || conn->type == PA_LINK) {
>                  /* This is a BIS connection, hci_conn_del will
>                   * do the necessary cleanup.
>                   */
> @@ -5562,7 +5562,7 @@ static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
>                  return HCI_ERROR_LOCAL_HOST_TERM;
>          }
>
> -       if (conn->type == BIS_LINK) {
> +       if (conn->type == BIS_LINK || conn->type == PA_LINK) {
>                  /* There is no way to cancel a BIS without terminating the BIG
>                   * which is done later on connection cleanup.
>                   */
> @@ -5627,7 +5627,7 @@ static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
>          if (conn->type == CIS_LINK)
>                  return hci_le_reject_cis_sync(hdev, conn, reason);
>
> -       if (conn->type == BIS_LINK)
> +       if (conn->type == BIS_LINK || conn->type == PA_LINK)
>                  return -EINVAL;
>
>          if (conn->type == SCO_LINK || conn->type == ESCO_LINK)
> @@ -6995,7 +6995,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
>                  goto unlock;
>
>          /* Add connection to indicate PA sync error */
> -       pa_sync = hci_conn_add_unset(hdev, BIS_LINK, BDADDR_ANY,
> +       pa_sync = hci_conn_add_unset(hdev, PA_LINK, BDADDR_ANY,
>                                       HCI_ROLE_SLAVE);
>
>          if (IS_ERR(pa_sync))
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index fc22782cbeeb..dff99de98042 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2226,7 +2226,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
>
>   static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
>   {
> -       if (hcon->type != CIS_LINK && hcon->type != BIS_LINK) {
> +       if (hcon->type != CIS_LINK && hcon->type != BIS_LINK &&
> +           hcon->type != PA_LINK) {
>                  if (hcon->type != LE_LINK)
>                          return;
>
> @@ -2267,7 +2268,8 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
>
>   static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
>   {
> -       if (hcon->type != CIS_LINK && hcon->type != BIS_LINK)
> +       if (hcon->type != CIS_LINK && hcon->type !=  BIS_LINK &&
> +           hcon->type != PA_LINK)
>                  return;
>
>          BT_DBG("hcon %p reason %d", hcon, reason);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1485b455ade4..f90c53f7885b 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3239,6 +3239,7 @@ static u8 link_to_bdaddr(u8 link_type, u8 addr_type)
>          switch (link_type) {
>          case CIS_LINK:
>          case BIS_LINK:
> +       case PA_LINK:
>          case LE_LINK:
>                  switch (addr_type) {
>                  case ADDR_LE_DEV_PUBLIC:
>
> ---
> base-commit: 98b3f8ecdd57baff41dceccf4cba5edff3b9c010
> change-id: 20250710-pa_link-94e292e2768e
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>

