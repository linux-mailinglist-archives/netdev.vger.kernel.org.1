Return-Path: <netdev+bounces-122469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5646696170A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAA31F23F05
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704801D1756;
	Tue, 27 Aug 2024 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BCfwbtHe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98B1CFECE
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783657; cv=fail; b=rYO5zdr+W3v59iS2ZGf0LL994WgCRV/paSBCJczxUaTWocFBiSIQ5P1ABWMMNFC/5sRN4KFaUGUKSe1H0vklnVd/zcWr2oFH4AeFNCVyHerIYLv+xpC7iEV3tQF/6kLvU+nkZu1LgKxO4XcZrpQvmRMTYCAenV57ilsXeHH7hwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783657; c=relaxed/simple;
	bh=akyIgPRxmKbSJj/hUwC9I509H/00lfZKcNzhr//8hmA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CVki31J/gCK9k5P1RxHaGAh1afWpy5KOZp1ktyeXxCTtbjuNGO2+Tvtgis65OPetic+sVb/J4FSbDWLd/hvTpqSySJD8q7otE35iQfSgZaUFzgH74vPJwo0sxoWhLoeGa6hU1LsW+tjXli/Exz8NOyrzqkohjYz94bPz77RxuZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BCfwbtHe; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stK78uCLbmHDKThJM5ncHBND/sGA/eYz3cjRTHChpRgJJgUWQWWaaRp1Xfy1jHmhR9gY1vq6d9H1MpOuUtL25fsyi+PvMGViS4/R1307+JVnB3o4NmHkGJjzgTAisfi7hLspnHvGBh3tJEQk5TzIcjyDZxpB7zbP3HXz9C/q5AXjOEbqls1wtG5R1vwEPu/9Z/o4CFQXLDSOPqIBpDwGSC6wtmy6mZUCNeR8GYfqWUmD/gvbBf1GC5A68Bl4Fi+NZC3EfZoEObboIjI+fhEvGM/n4KSF+1EUkgLLWgkB0VHzYfcjbRB9k00pPk1hxhmukeXCid4UkFzCwSSublE7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwNhbf3u2sCkaDBdDYYmeFzx20RkV5GqDf5EL3D+RfU=;
 b=UGfFpcCGeuQFkoJsQybrBxn/hzPfdgoMT1igfWPkTTt6ciCLxwkag5GquPvrX7AfmPl70Tni2fn39Na852wewWoA9t1iFPjfbVZHorhsCXnKVkcJ7btfE7V4t3x/Glw5VavQraA0IMaBNh/x0VVeJb1eO02rcerBqvyqpDAdFxhzUFkG5FsVQiSwLwUCX56ijd0mKlcrP8gY0nS9syUZNRVoG4NzV72YfFs91qnfwqARivIiM2EIEjCTXRkkwv3iC21MLgbFOCwPJbejF5MChaNxz5LnkPqPDMTHH702RSbsuelG/saM/UaoBBfI7YC20lZ8WJkYuNg/0EZwNgtkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwNhbf3u2sCkaDBdDYYmeFzx20RkV5GqDf5EL3D+RfU=;
 b=BCfwbtHekz5r5smjcmKOFIaikHVM3aYlt+Tivk+bK+y+9ScOm+ycfSL7ED70yEROtwO9+y1s/HGk5mJAUaLfp6hRSya2d31NRJEUVO/ZyFTKf/MyQIdn+fJ22c/Mg8e/tpmKwywUMHFLCkL9VuHLSwcGa/e1r4TDh8pz/aSzr29MjbCe0XmWhInKu7p8AzioBF+oRDKmt5LjmigwZVP6rYUTmSRxo5DlvTpo81xvFnBgOi05JPEK6mw4dL6plI9GFc9dXTaCcG5sxcEJrthcbRyuvNymk9NsPkiZ4/0z/bwgqxhQWSld3rsT0Pxsc7LN1WoU0NADycTVNpUK4b4jcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 18:34:09 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 18:34:09 +0000
Message-ID: <a4448066-7278-4fc2-b859-4de7a555e7f2@nvidia.com>
Date: Tue, 27 Aug 2024 21:33:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Arinzon, David" <darinzon@amazon.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
 "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
 <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>,
 "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
 "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
 <ofirt@amazon.com>, "Beider, Ron" <rbeider@amazon.com>,
 "Chauskin, Igor" <igorch@amazon.com>, "Bernstein, Amit"
 <amitbern@amazon.com>, Cornelia Huck <cohuck@redhat.com>,
 Parav Pandit <parav@nvidia.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
 <20240811100711.12921-3-darinzon@amazon.com>
 <20240812185852.46940666@kernel.org>
 <9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
 <20240813081010.02742f87@kernel.org>
 <8aea0fda1e48485291312a4451aa5d7c@amazon.com>
 <20240814121145.37202722@kernel.org>
 <6236150118de4e499304ba9d0a426663@amazon.com>
 <20240816190148.7e915604@kernel.org>
 <0b222f4ddde14f9093d037db1a68d76a@amazon.com>
 <460b64a1f3e8405fb553fbc04cef2db3@amazon.com>
 <20240821151809.10fe49d5@kernel.org>
 <d66b079f-c6b7-48c5-ba6f-68cc3e43d1c7@nvidia.com>
 <20240827110402.0c8c5fc6@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240827110402.0c8c5fc6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0025.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::16) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 142d36d9-1a5c-4b0a-84f9-08dcc6c6d6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE80dmIzU1RxMURmNDZQS3Npbzdic1JUR1lGQ1ZiRTVkNG9Vb2ljUy9tUDVm?=
 =?utf-8?B?M1IyZXA4VGZPUlI1U2VqamkvekN4RlF6dkVwMTBiVUwyVVdaSzIvQVlCTXpr?=
 =?utf-8?B?cHNpcEVQTUo3a1IrK3ZCYUFpME9kQTZFL1pkeG9CZytYUmNLRGVKWnM5b3F3?=
 =?utf-8?B?WFpIQzZGYnRwbzlzcUZXdzJrTVBCc001d01QTUk4Y1QvYThYUTcvanRldTYw?=
 =?utf-8?B?aVZ5djBhQytpajdyZ3RLZzJNWk4yUlVqUXYzRnMrbVFTZXZZWjJVWHVuOHFs?=
 =?utf-8?B?WEpONXZ6cGU5NnFRWWxhZDllcjZSZG91c2g5UVphRkxOdGpHYzJPNy9pSnJn?=
 =?utf-8?B?VU01MWVWZm5wUTFJZzdmeHlqcCtjc3IwSUhjQkt2TjlqNm1YYU5sWnZlWVQ1?=
 =?utf-8?B?WTZHd1RGOHc2MVV0QjJwb0lua1NwVWM1ckt0K3hBN0dodElzM1RYYXlyS2Zn?=
 =?utf-8?B?ZTkxK1VDZHVaUzVhdnBSblZldExlWWdvSnpHU3FOYTJIUFgvZTZZZ2VrU2kw?=
 =?utf-8?B?N29FRExRVUZ2Zy9jeGJ1WFFxRjFYUmF5YWg4MGJIZUs3ZU4xMkpaM1dyTUU4?=
 =?utf-8?B?OTFTdnJLVEpMTFBHZlJIK2JFTStMOGxzRkFkTDI1RFJ6ckFHSXF1Z2NJcUxR?=
 =?utf-8?B?alZJdUZ4b01YUVAyNWgvMFdaNGFJdy9ucGkrRndESUJRWmY2dFNCRW9wYVd2?=
 =?utf-8?B?K3pLZE1reFlCNnQvSUlON202UEtjZ1NDdUlZYXlIUXk0M29CMlEwekRSdkE2?=
 =?utf-8?B?cFFXcGJEVDNEOXZVOU81YlF6N3lXQjZiaTVUYnM3bmdhemZvWEp3QnVhU2Iw?=
 =?utf-8?B?M3dBcjFOUFJUaXZFME9jbEZpZ21RWEl6ay9JZFhnKzlGbnR2OWY5R2pWVUJF?=
 =?utf-8?B?MXZFNklkMUgxNzNTazJxYlErK3RxR2VUSk42RlZHcXNVeEYveG10cXplMnZs?=
 =?utf-8?B?YzVHWWVCSGkwRjlKSlBGUHA2SFlWS216amkzbnZoUzZIZFJZR09MUHZzSW9J?=
 =?utf-8?B?bExCMkc4bUl3dW1nN1NyeWFHd3V1by8rR0JRMkZxcnVLOUkrZlB4ZEJEMC8v?=
 =?utf-8?B?V3hTZ2xNTkJ6MkdPamtJSS9KTFZ1RGhWdnRVMXQ5c0w0OVdDemlEYy9rdUtk?=
 =?utf-8?B?anNiQmxXeEM0U0xyL3VTM0ZEb1R1S3Y1ZmJVNGJYbHBDYkR0aDVLaVl4MWlX?=
 =?utf-8?B?cGJrdlVXZXZxOWpwUnZoNnh2elpuNCtVcEFXRUVVMXVmblB5L01DYWVlN01h?=
 =?utf-8?B?M2lqNjRndnlTdTV4NGlXRXBqQW9ZZXVSTEcrYlBOdUdNdmZ6S05XYUROY1B1?=
 =?utf-8?B?QmNsTUNwUWh6dExLYUJHT1RzYk5Ncy9VOGRDUzVvS3U3Z1hzZjk2eC94Tmoz?=
 =?utf-8?B?WEFaQSs2K3d0QlJYSElhWjVseVhsYlRZWWJSelNLOTVXOEFneFJJdkhYWVJC?=
 =?utf-8?B?MU9nVGcyRy9OY2gyQlpHYjl4MVZqZGxEd0FVM3NPbWRLMkJqeUNkUXM3TE5i?=
 =?utf-8?B?WG5McG8yQU8vMzFzOU53dkNzOUJ0SHdsR1Y3VTAvanBFU2VNRGVQaU1jUVRO?=
 =?utf-8?B?TFVMWHJGalJBbXNLN2RHTUhYMHJOeFJiem54UU8wZDVvcFcxbytkWE14bHBT?=
 =?utf-8?B?NVhiS1I1RTd1UzRiaFByaDFjTHY2UWxEeHFvUi80clkzTG0ybCtLT1NsSDRH?=
 =?utf-8?B?MllIak82K3V6MSs1UXh5Q2F5TjUzVlFEMW9LZjlBdDJyOUZhZ2tPTi9NUSsr?=
 =?utf-8?B?QnNhTks4K0J0eXhETEg5Y2pzQkZnaitYU3dFNzhFT21pQjlrQkY5ZzZaWFI3?=
 =?utf-8?B?R1doN2xiWG1LZlhKM0djdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFFvZnZFMDNmeVc4dUNReWVPak5wZ2dZam9lNnZGRzIwMlBCalMyZHh5ZmtZ?=
 =?utf-8?B?c05hS2tJQVpIa0hiRXd6SjhTMDREa3lVVVJtK0dwSmhnZVpvUkRNYnBrbzd2?=
 =?utf-8?B?UTBSSHNxcWphV1E1SFdINHJoNUFBSkt3MFJnMXc3Qk1NUHlkb2szVEJ6N2VQ?=
 =?utf-8?B?OVdHd2hIK1VXWVd5eFlXU05VYTZ1S2RHL29UZnduOWpHVWs0UFhXcnJiZkIv?=
 =?utf-8?B?ZmhHMHh0dktGbFkzZ1NDUDRhUktZdUJOWTcwU1F5NnZuSmJzSDhsaG5HeWVz?=
 =?utf-8?B?UTNpbFJFaVhoUGdSeDBXUGVEWDlJc2FVamRlSGQ1d3I5di9XNEsrTHpBbFhk?=
 =?utf-8?B?cE9vUlptaVpIcWJlekZsS1dRRllPUHYzOW42UXE1QnhubXl6N0JnOXlwazBv?=
 =?utf-8?B?ckFzTnFWNVI0Tjg4bGk4aWRMdkV4TnpBbGRPRmR3OHN2VlRyRzRyL0Mzb243?=
 =?utf-8?B?RmxkQVVqQkYyNXJJTDIrNHJHWlhHU0YzZ053SjlQdTYwTDMrM3lESlJIUWRk?=
 =?utf-8?B?a283a1U2UzFCSUxwTGhCeG0rYXFyU1JZZmtOeStRSDlsTGx2UEh0N29xZ0Ja?=
 =?utf-8?B?N0xNU2pYYzR0bkV2dFdOOUQwTnVBTzlHa1hKdjJhWHorZU5sMVk4VnJTV0J4?=
 =?utf-8?B?SjFVQWNwcmxXbFBKODlLS2Y4U2k2N2xZcnhDN294K0dHU09qYjNJb3ROQW55?=
 =?utf-8?B?UE5FQ01mc3NYYStuNCs1QTVCYjd6ZTRFc1J5MS9hSVU3Ymc0STlUS1lWdXYy?=
 =?utf-8?B?YkNQWWY0aC9FZW9zOHZCcEVsTUpvU2NFM3BxMTNpV1V1bDJFbDlzczdsdURW?=
 =?utf-8?B?SWpZTTVROW4vSkpkY21oTWZDSUEyaVJuVUhGRCsyY1VCc3NUNm5vM1B2RHRU?=
 =?utf-8?B?VE5KTWxRRGZ4cnJjTW9UcDNrY0pCdTRpdWlSUVhWcDYyNnNQeHVsUmpWdkJU?=
 =?utf-8?B?R01FUmJ2cXliS3JVa3ZCektHMmhQaGJyTUdMYm12cCtMMkNqVEgwaUEwc3ZY?=
 =?utf-8?B?N1dFL0RCZ0RpeVBGeWtEVGwvZXJ1aWE5MXVtaFI4Tmk3NTNGd2VIaWlTWkkw?=
 =?utf-8?B?S3h3RDlMaXBvQUV3anFobVYvZFNJbzdEaDVSbFlBZndWQ3lPbkFkNmpCYWFk?=
 =?utf-8?B?cERwakdkTnVhWGNXRTVlMmFCNVd0alNBZ2dqZ29NTWx5UGsweHRvbGJPMTRU?=
 =?utf-8?B?M3ZBTTduY0lIeHRaSUN2TUN6ZWQ5NXlNTzBHeERLd1ovcldCbkozWCtSUXk0?=
 =?utf-8?B?VUNCalpwS05kTGlielllSHkvK0JINjF1ekg2SDFheWQzUmI5UGdhZEVYbTVY?=
 =?utf-8?B?dEIwRDRwcEFaQ2JhTWxoVmNGYlJDRUNKa01SYXdBT2pJRlpVMVNVMVRlSU5N?=
 =?utf-8?B?SUxYcFdxaDk3VzY5RUlnL3ZjbUZDSDE5cDROUXUvQThLMERzWlVyYnhHU2Rv?=
 =?utf-8?B?ZU5OVU4zbmVNeENWbDVyQ2FNZ1VrdThId1B0RmZRWHZ4TDN0emxqeTdvOUtX?=
 =?utf-8?B?RGhmVkFLNDM2endsZTNNS2dFL0hxRk5TTU81aGgrdDY2UEo5TzUzbUZTeHFx?=
 =?utf-8?B?b2t4Z2Mrd3NEem9NNWkvNW84eDg4dXB1ZUJqRzJuaG44MEFHZ3VsQ3hoNlRz?=
 =?utf-8?B?RXZUZGJzTlBCcCtpZWF4U2p3UCtESEFSQUx2M2xoYk10WFlxSTFmcElSUDRR?=
 =?utf-8?B?S3FBdUZMeWtqZWMzSnFXNFBiTitra20wM0RCQm91Z3lJQWs1bXRRVjZOVTBs?=
 =?utf-8?B?aUdwS1JHdk5SRXJ5ZHRVQnlyRkpHWmxwRjdVOCtmbDBuc2FLczRBQ0tHQ1F4?=
 =?utf-8?B?bjhjMFFoOTJaYTdudUN0aysxcHVnRCtTblB6UnZRVUd1dEFoemRHRHc1Rk9F?=
 =?utf-8?B?SFlsTmRGNlUrQWFDRWZ6cTcrK0dZNWQzcklWYmpVc1NSZkhtTnpMMGRFMHpv?=
 =?utf-8?B?MzBwR0d0QkdnUVNxU2ZYcFRtcm0vbnhYcC90MXcvVGtydFROdit4cGtWNTJv?=
 =?utf-8?B?Ris1ZktyZWN6R3NjWDc4NXNVVWtYdkJucW1ITmU5MG9ucjFsWm4yWDVSRGc2?=
 =?utf-8?B?SmxFUUh2ajFWQXRLSTdFZzU5UFcrdEp1aTFWTU93R0J3RWs2dE9JVUZDR0xZ?=
 =?utf-8?Q?7X4U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142d36d9-1a5c-4b0a-84f9-08dcc6c6d6a5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 18:34:08.9783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxCGd3SwTddGDELwz7z5TVs2LFbNMfdWIWGiTn2CXiqOW3OOXDqANizCisaYdDIB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295

On 27/08/2024 21:04, Jakub Kicinski wrote:
> On Tue, 27 Aug 2024 19:41:47 +0300 Gal Pressman wrote:
>> Perhaps David can show some good will and help sort out the virtio
>> stuff,
> 
> Why do you say "perhaps he could". AFAICT all he did is say "they
> aren't replying" after I CCed them. Do I need to spell out how to
> engage with development community on the Internet?

My phrasing is due to the fact that I'm in no position to tell David
what to do.. I just got the feeling that he didn't get your hint.

I understand your motivation, but my point is that even without him
being a "good citizen" these counters are already out there, should they
really block new ones?

