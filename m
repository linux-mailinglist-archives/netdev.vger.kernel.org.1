Return-Path: <netdev+bounces-203960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAE1AF8585
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3B77B5E94
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 02:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09099839F4;
	Fri,  4 Jul 2025 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="wLrNC7E0"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023132.outbound.protection.outlook.com [52.101.127.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F0A262A6;
	Fri,  4 Jul 2025 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751595723; cv=fail; b=HyPMUlbuvKW0UHE2N0039RMky8QYVB3RcfzNaAqxfE8pMzff17wlyRc1dSpk3fZKRC1uT2igtcD1vjPhXuCyqBxqeiABxtOJ8Psf5Gek+T6A54zTpcKgWkAEsedzg7u8KlMZ9Ftd0RtXd8h3rv0+6Cj5UeVHth205lSYWV4JzMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751595723; c=relaxed/simple;
	bh=SyAkXxESBQSIOm+nl7WFM0eWEl5sf1YWo3dUjwzho7E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FcoMUfTR0UyfOXxByZxuLQcFTpPybrp7qBTsZ9KCaEpvY71LEJozgMyHHF+DUYaP2/OS4lyVVZTJOhicHb+4fQMicPepX0h/8hBhtTmuSjSwflp5jKkSuHq1j+/neh17Ww3GB+AKq+RkgJ87Z6wnXdId/XGyL13NGwinMWvA5As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=wLrNC7E0; arc=fail smtp.client-ip=52.101.127.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWp50WnaFwPyzh8TBcZV4rtjtAQJZ/kTJaLHynJaFoCZc5VW/pMac9DeDNlmt1EKIj4lpHRWd5pQ5Da9CGB+sORUWuCE4RUcvn5Ci4wgv5S7w7Qz5fweu35YhYJphDr8pOzfjvJAtcCKsS+Z83WbP9lFXfsRXFQGhLli41pm6Mthoy2oqUHm3ktdzudJMAvZXa+Ziy8gzgKj5KIRnpmyPLA9aN3qqiXQwhERqxSVR8Qdw8/RM73bx3B2lgkrzcZaRpMaqKUCezqHOVxvIbgg7Bslu3UvMlyz4N5e9icqXLc4ky10lmmD77fI6Q82E1bFhnRLutnzy7OmAZi5S8ioUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX8jjxD6avoA49egdrVqNqb+/8Qfd1+BqthRPo68m+k=;
 b=AweEVc5uugc+CCNL+hKpPa+BK3StaLZxJovb9YzaJ0gx5d4dfW8tMt0qElTFGUNu8q6ShwR0HvYLb8fzHPlliQw/ZYqiNPfO5GHG7uIFrwWyh8wQJh9fZl0seJ1hIK81kOtBGvMeLJI+wJUt3D4I3rfCV5gJwldQUPjvKSHffYqTk6R3M0Xf/+0WAXHpZLAqnKPopl6Bl7r9Yofdtd+vEmgwT/ESUQBkOmS9II/G5oriSfJPgQTzQsF7QJdf15e5Zbty4z4C012R0eihtltq4k/Q8CEZmEeRiu5tPPB+gZiAJmiUilAuRnTwqWzTM6JcN2NxsAmEcjzBEurEkVLcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX8jjxD6avoA49egdrVqNqb+/8Qfd1+BqthRPo68m+k=;
 b=wLrNC7E0V4XamGSGtiGDJEhi4/Uqy+tSDaIHQWQSbGN5x8SBmn3elqm51+DG3tZZd0bBIqjW4YSrTpVoBEHgNJuBpuDguDK6OllY6/jxwljrgDj28pmy8oLjITR3QqzaNALm4QsHKkpR0pyLAffVkMzSaCY4FP393pO5rX2aB1TKp/RdYNF+4gVZPtdxkxTHLjAxAWiewR1GFgXYyg+jKC6ty43VE/FKGSf8/iYKRkJTecQvwXjMVwcUONA28xg7YxWy0FoLj8LnrS+uTVOuDwVEhEf+Z6CTYxlmzO8eypqsBvGH2pNixxWvWi1t+zpP3Kr5KRLRVsajHJYFYT0B7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEYPR03MB8378.apcprd03.prod.outlook.com (2603:1096:101:1fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 02:21:57 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Fri, 4 Jul 2025
 02:21:57 +0000
Message-ID: <ddb21387-a164-4e38-a4f3-41c66bc02acf@amlogic.com>
Date: Fri, 4 Jul 2025 10:21:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_core: lookup pa sync need check BIG sync
 state
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702-pa_sync-v1-1-7a96f5c2d012@amlogic.com>
 <CABBYNZJCsiKVD4F0WkRmES4RXANNSPK1jvfRs-r9J-15fhN7Gg@mail.gmail.com>
 <6bed0cff-c2be-4111-a1d3-14ce0e3309db@amlogic.com>
 <CABBYNZ+mB+rb+6hG9s7fmvqwti8oSoQ27+_Cz56_ZD7C5t3cQA@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZ+mB+rb+6hG9s7fmvqwti8oSoQ27+_Cz56_ZD7C5t3cQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEYPR03MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: e23a270e-e42b-4679-3ae5-08ddbaa18cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzdYaHJLM25GU2t0VG82Qk9uYm9ESjRDRGMyc0c4SERaS0Zydko2VHZGYUVF?=
 =?utf-8?B?ZkpDcityQ09YSGV4QVlIYm1NMDR1aWw5amFrV1owWktWMnIxSzNteGg1cDdB?=
 =?utf-8?B?MFJnY0wxbU4xcnBnWGwvTmptNGoxNUlZOXdaUzJLN0N2NnRKVkNTU3U0WW9O?=
 =?utf-8?B?cDVzNWFudEJndk8yQzFpNXRETDRCT1g3SElyWjF3dVU2YTNDblE4MkU4N2g3?=
 =?utf-8?B?SjE4RUgyZGhiemRJZGRnRUJFbzk1dG91bmptQUVaaWtmaTdXVlMyM2pDMlc3?=
 =?utf-8?B?U0c4OG5OTGQ0MXoxTVlmNE5aZGFGMGtOK01GUURqWjJTaERSY016cmJzVVNU?=
 =?utf-8?B?OVlkWklXR2pOOE5Cakt0akMvRCtQaGdLVFE5NzZLdWNUWlBoQno1NnJpcHNL?=
 =?utf-8?B?TGcrVVc2QWhlYjhYbTA2Y0E4YnFUVjdQamRWQnVWQjdBODl2ZDdiSW9ScWZQ?=
 =?utf-8?B?elNibnpUYUk0ZXIySEI2QVJOR1dVK0I4MEM1U0JEdVZpQkV0SkFENHI0RUlx?=
 =?utf-8?B?S3FET0pGbkp6Rk1JVncwVHBBdlZEbmxoMDFvSUdqZUtLN21GMmFrc0JNeC9Q?=
 =?utf-8?B?Y2QyWUc2SVVkUmFHTWFzUEdFbklxaVZhYS9VSTRmY0tUTVQwYS92YVJ2N29O?=
 =?utf-8?B?bTIrcEVBWWdTU1k1MVZkUWVWUmg0QVZIWU1qcit1ekljdzhLd1BhMmp2TU90?=
 =?utf-8?B?bnZVTWNWSVUyU3FKWEV5N0hvOElQd0o3ZjN1dE9OTG90VkwwOXA0dnRwZWZn?=
 =?utf-8?B?UGw3UzlKQVYxWmJibmtiTTl3aXQ0dTkraTY2TkthYU1aNVgrcGhMVTBhbzV5?=
 =?utf-8?B?bHRIMDArUnpZeTNmclBzQnhaNGFndHJzckxyM3U1bW1kcS9Gd1hIZVhVNGxY?=
 =?utf-8?B?OVNXWVRoRWlqMG5xdkN2Rm1VMlduNlpzMGtacG9sZ1c3Z0NEdmlISkNjL0FX?=
 =?utf-8?B?dHZoWGJYdU1kZVpXVmp3bjVkdE1HcktHaHdqaEJsRi9yS1p4M0c1a01jUFdP?=
 =?utf-8?B?bDBmOFNIZmxzSWFDOEQrN2VSOXhvYkIvRHBwM2FPTGFId2QyaFlPVDFQaFhr?=
 =?utf-8?B?WW1Nbzd3Nk54VkVYeERJMUZoU0U0WS9HaHhoQVlQNm1WVUIxQ01SQ3pic2xG?=
 =?utf-8?B?ZGk3Z3ZQTjVmelczdDVWN1UvcjdaYjZGRkJiaDJDQXh0NzBPRXE2RHp0YWpH?=
 =?utf-8?B?TUpJei91d1FhekhPSVZBNGFpMXdNUkJGUzFVajM1bVZIdHFqb0s3MnZoTHJV?=
 =?utf-8?B?VURHRHF5RmJSUDFITzUvOEErWlBiUFhEZHJMYXp4MlJ2OEpSaW5uWk01Zmwy?=
 =?utf-8?B?OTQraU02LzQ4OUo2bjZoNHRvK2lxcDNnQ1B0aHp6djF1M0Q5dERrWFlnSUpI?=
 =?utf-8?B?V2lMZnh4dS9UTnMyZHV0VHdFcWVBdjNJMlR6dUNRU3h5WnhDMkcvUmpmTjVC?=
 =?utf-8?B?SEtQS2dSNGthMnkwQVdrTU1MMXh0WmJOZEo2ZWUwaFNPeU5oN3NzSkkwRmhN?=
 =?utf-8?B?anJIU0huTWI1aXhsMldLZ2RjbUlrOG0yQnVaNVlOTTRQK2dPcnFhdlZ6Zm9I?=
 =?utf-8?B?V0cvTmxxaDhtdmFHM0RrdGtpSFBVZXMwRm1GTzlOSkRTeVZpWmpPUVozODRp?=
 =?utf-8?B?OEx1V04vUytKbjZEeHlGV29QczNDQXZ2SXBCSGZNUzNwWFluN2NmK3FVdUNX?=
 =?utf-8?B?R21hbEpxd1NhUWJibSs3UTFCUHlPb0JGOU1KZDlLYzJyckkwNE5adDVDSnZh?=
 =?utf-8?B?L1lTamdsSXpwRU5uQTQ1M2dGMzN1Z1gxRG5KWWxza3Iwb1Z5N3FDODhXT202?=
 =?utf-8?B?N0k1T0FmK1ZJaFFLZXdzSG0ra0FnQ1RqV1cwR01ZcTZHRGZ1K2d0VURrcjR6?=
 =?utf-8?B?K09CV0w5THZORTRvOERRUnVPTnNwUlRXWlplMm5wVG5OdFBIMGJyc0hFeWtZ?=
 =?utf-8?Q?MbGT4dUVdg4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnVVUlh3OThLU1BZcStlK3lsVGlXUTdDY0lCODJ1VEpUeEU3QlV2MEJBckFT?=
 =?utf-8?B?dGp0aEVVRU1SU1ZwdDNvSE5mNXl6RzhDVWs0dHlnamJxT0Vyem5BNnMrN201?=
 =?utf-8?B?STBTejNlYm4xZnptZkhCNTkrUGtPTC9JcUNYRFMrTFlhOHNGUHNBQk4vRlhE?=
 =?utf-8?B?dUsvbEZ3NGV1Zkw1amhOaXJnTmZMQUcvSVo3QkRtOEY2MGlYb2FWT3JXdkJh?=
 =?utf-8?B?T0JYUVRuR2oramhiRlloZ2p0ZTEvcnRraHlZaVFzYmJVcTJ4VG5Ha3F1Qi83?=
 =?utf-8?B?RHBKdnZJKzhiUjhEYU0yaUEyNkZ3dVNNSkFYREt0Q0FvQzlqUkNVcDhyTmE4?=
 =?utf-8?B?WnYycDJWaDR5SjZYOU9PaXN2UFcvOE90Wm5FS1dlTDhWZDZOVjUvb0ZLT0I4?=
 =?utf-8?B?Ym5BTHk3ZDZOdGRscytoVGhUVEhBbEdmYWtKNWYzQjhLckNMWDBORytDVlFH?=
 =?utf-8?B?bU42K20wRm9tVFF5WkZ6NitxNFkxM2lWOGxvK2YyRGthcytzVHA2WW8xcUVK?=
 =?utf-8?B?aW9ZQjl2VmlEcWVHYlAyU1NBaDFLZnFHZEMxdm9salcyQWk3K3JRMlg4Y2Ji?=
 =?utf-8?B?V0JqbExVVExaN3lTT3N1SlZFY2w0Z09taHVDdUR0TjFCQmxxUm1QbUpObUw0?=
 =?utf-8?B?bTlyT1ZhSHlkUVphUE5aS2VBVEhtbm9jcmdzT09oUk9aVk9LVHhzeDRldUlr?=
 =?utf-8?B?QjlMK2tPTmg5OHFmUDJVWEhRN3ZpdmlQVU8zbEhweTQzcWdwaDBMRURUakl4?=
 =?utf-8?B?TFVtWThFK2VURkFabDdRazJ2QTlqOXRhV05BNHlia0FBelVabjFXN0xjdjRq?=
 =?utf-8?B?cVlrYmRUQm5NVituYXNoK05rS1JWaDg3SUpHbWFqVkNia1hOMnFyYlprN0R3?=
 =?utf-8?B?SStRNzVQYktFN1pLeTZuTkMxSk9HbjBSQm9NK0Q5aENvQ05xby9ubVh1dkJS?=
 =?utf-8?B?VmJzdjFRSkNydTJIaHlod05TNU9qelhNZk11clJFUnlvQjhWRFE1eGd6YktG?=
 =?utf-8?B?VlVTOVZvQUIzMTBVYk5UMEduVVRlQWJRTHRXMWFrdXI1eW8zVlIwRjNxckln?=
 =?utf-8?B?WUdON1pla1hHS0tYSTd6Q3oxQkZUUzRPUHNpK0NXVkVUallGUnYyaE9qYlFQ?=
 =?utf-8?B?SGtnOC9iam55ZldMOXVNb0habXltOGlZQStpQjhGSWRCb002Wk83Rkh1eWFL?=
 =?utf-8?B?Tzh3NXd4dDVLbFhJcktEa2l3aDFoa2o0em4wM1pnOUhnWlY5c1FkVGptWEc2?=
 =?utf-8?B?RzEzK3B2UnlzbFBxTmtGTFRlOC9DeEhKMS9lMkFpY0dLUUkwV0xzTjc2V3lE?=
 =?utf-8?B?cGVHU21GVXdRWkpWS3Q0NlVoL0xHUVR6amorcitpb3dvL2cwL3hMUmVLVnY5?=
 =?utf-8?B?SEZyZFpMbHRLdWpoMEJLR3IzdDlpeld4UmJWdjFkeUdHSkpJbC9rdkc5N0dP?=
 =?utf-8?B?T1lUZkw2bTdobHFhMWp3UUZGTytVUXZHMGdpMUczNEQrUkZkL09lbjZGT2wx?=
 =?utf-8?B?d0lOZFA5Z3E2dVF1dGdSQlJWcDlzOW1WK3hGc2RhdVZCUnVHMUl0YkcyemZX?=
 =?utf-8?B?c0cxTHJQNnZ4UDYzTzRRSlhiUnk5bzZxWVh3eVNyQVRvMDRFbzUyQ2huMEVC?=
 =?utf-8?B?alNtQmYvWktHVUE0VW1wZzV4S2U1cTlaV3NKV2ZCaWJyTEVtZU01dkZUWmF5?=
 =?utf-8?B?SzRNa3NKdWZ1OHU1MDhpM2hURlFYbkxiYXMrSkJYTG5wTkFzWlFsaldZSCtJ?=
 =?utf-8?B?cHhQckpnN1lUYWFzMDVEWG1ZV0dzOXpQdWJHZTY5TjRwUnVZNTlKSUpQaHhi?=
 =?utf-8?B?L09jMUswWStBaGJtSUxmcnVHWXliZVIrM2V4VFc3SkdPWDRTYjIrU2Z5WDZF?=
 =?utf-8?B?ekFocmZzWHFQa05qelBiMm12K1hwSFlKb3I1cGxMbG1veFl6OHI4WTk1eWNI?=
 =?utf-8?B?ckViOGxxVWZvUElRZWVYQU1xcVY3VVFXSHExWDUwbXRIVUVoZDZqaGhQWXJ4?=
 =?utf-8?B?K05WVnB4aDlZSVJFMUtvczF0ejJhUngzSVJRbThORmNXVkl4OC94QnAxa2pt?=
 =?utf-8?B?djlLT0xMa2tHVUZRelNjQW1Oa21OU1M2SjA0S3FjNThLcTE4Z1F5Q05GdXhC?=
 =?utf-8?Q?Wq6fmmkz0AwvS+vR5/YBJuieC?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23a270e-e42b-4679-3ae5-08ddbaa18cc3
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 02:21:57.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OBL2B7JE5JpqS7InI6LkeHU/oLFZgN1PgJBjaoEBJmrKhRTti29SK7o0G3rEAAh5teaDQHogrZZYgMp/V95gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8378

Hi Luiz,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Thu, Jul 3, 2025 at 5:19 AM Yang Li <yang.li@amlogic.com> wrote:
>> Hi luiz,
>>
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi,
>>>
>>> On Tue, Jul 1, 2025 at 9:18 PM Yang Li via B4 Relay
>>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>>>> From: Yang Li <yang.li@amlogic.com>
>>>>
>>>> Ignore the big sync connections, we are looking for the PA
>>>> sync connection that was created as a result of the PA sync
>>>> established event.
>>> Were you seeing an issue with this, if you do please describe it and
>>> add the traces, debug logs, etc.
>> connect list:
>>
>> [   61.826679][2 T1974  d.] list conn: conn 00000000a6e8ac83 handle
>> 0x0f01 state 1, flags 0x40000220
>>
>> pa_sync_conn.flags = HCI_CONN_PA_SYNC
>>
>> [   61.827155][2 T1974  d.] list conn: conn 0000000073b03cb6 handle
>> 0x0100 state 1, flags 0x48000220
>> [   61.828254][2 T1974  d.] list conn: conn 00000000a7e091c9 handle
>> 0x0101 state 1, flags 0x48000220
>>
>> big_sync_conn.flags = HCI_CONN_PA_SYNC | HCI_CONN_BIG_SYNC
> This is a bug then, it should have both PA_SYNC and BIG_SYNC together,
> also I think we should probably disambiguate this by not using
> BIS_LINK for PA_SYNC, byt introducing PA_LINK as conn->type.


Yes, I agree with your point.

Adding PA_LINK can make it clearer to distinguish between PA sync and 
BIG sync links.

Let me try to update it accordingly.

>
>> If the PA sync connection is deleted, then when hci_le_big_sync_lost_evt
>> is executed, hci_conn_hash_lookup_pa_sync_handle should return NULL,
>> However, it currently returns the BIS1 connection instead, because bis
>> conn also has HCI_CONN_PA_SYNC set.
>>
>> Therefore, I added an HCI_CONN_BIG_SYNC check in
>> hci_conn_hash_lookup_pa_sync_handle to filter out BIS connections.
>>
>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>> ---
>>>>    include/net/bluetooth/hci_core.h | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>>> index 3ce1fb6f5822..646b0c5fd7a5 100644
>>>> --- a/include/net/bluetooth/hci_core.h
>>>> +++ b/include/net/bluetooth/hci_core.h
>>>> @@ -1400,6 +1400,13 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
>>>>                   if (c->type != BIS_LINK)
>>>>                           continue;
>>>>
>>>> +               /* Ignore the big sync connections, we are looking
>>>> +                * for the PA sync connection that was created as
>>>> +                * a result of the PA sync established event.
>>>> +                */
>>>> +               if (test_bit(HCI_CONN_BIG_SYNC, &c->flags))
>>>> +                       continue;
>>>> +
>>> hci_conn_hash_lookup_pa_sync_big_handle does:
>>>
>>>           if (c->type != BIS_LINK ||
>>>               !test_bit(HCI_CONN_PA_SYNC, &c->flags))
>>
>> Please forgive my misunderstanding.
>>
>>>>                   /* Ignore the listen hcon, we are looking
>>>>                    * for the child hcon that was created as
>>>>                    * a result of the PA sync established event.
>>>>
>>>> ---
>>>> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
>>>> change-id: 20250701-pa_sync-2fc7fc9f592c
>>>>
>>>> Best regards,
>>>> --
>>>> Yang Li <yang.li@amlogic.com>
>>>>
>>>>
>>> --
>>> Luiz Augusto von Dentz
>
>
> --
> Luiz Augusto von Dentz

