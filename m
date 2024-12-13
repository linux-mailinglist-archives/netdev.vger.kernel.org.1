Return-Path: <netdev+bounces-151662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804389F07D4
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85352165870
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73421B0F18;
	Fri, 13 Dec 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ifLbmJJF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEE1AF0CE;
	Fri, 13 Dec 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081948; cv=fail; b=tv7j+crtiGQ1UDbN5zoiHiAUD4yuYseCryl1a5+RagpIPI3vTEYO+QujjxJASva6twEaXAyqQI7/70DybKc7H/haKMg0oW0Jq0v3fO978vPFfZOs/HwuYayDpS6OZHGBoodI5XC8TribKcBMW+VDcuWPqGViaHnSCCK36pB94oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081948; c=relaxed/simple;
	bh=QVE9hl2n4Ay/qda4ixKjq3gT8+bE7JMFBF5dgu5DSio=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=upqUzdDdk50hta+d2rifS8LlLV1jtUd8Vpc4uG90fxeSap5IWsD7xNRvNFD/oGJpeVgzVNGtvf7GlGZkXApaZu0iLhvpo3YtOPhELAuSYv2Dk+cII7KncI6PxQnTENGtYnGbGcqtDuEvGeUoJB62/TqbGzzCNUZWqC58xpa8ttE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ifLbmJJF; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wf4fUvr+CW8edQxkevGmT9QtwFhruc4MMDMu6OJ3C+9WaxzHb0OyPbWKsHzGshvZxGNnoWHcJ10EyzuivXzitcqv8J7Ji7jS1oN7wraCJreS2wmrX+uTvEsMeA9S13DINm0VSP0r1kIkDHAZLYrsBBSIL3ajIVR9neVOBkstnrGkuZEvF8TbW5YUuS7TJ0FkQfWK5Ww22q5VlQ42pJWKkuWro5ZpHMmB0R7GJEsHvYBSD1xnaAELnauwvh+m6I5jWQNVpJEvSyLPOCYJltD//NBpx1ZU9HFyTSW4nsKxpHxWWIuEyk9XdblVXX/ONvDgK1DxV2HSdiY6egyqHwqTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfXOFVzt5KJV5ze9ngQefAarB27yOCZy4Ikj8DPn7qc=;
 b=MzBUrPZoug9YFyteFg2sIXFOrbZBjpqfeV7kfHLN38Xa3ZI/oqjzDuLtWtJTKwYpAJZUzWczbAsyQe7q8v7JyUR/9V5SYVUJUGfLApOg92c3bcvXPbgWgGPz4CmpuU9w+9SXUjIooLktAlofcYLaegaTOcUaqN/dwcf/cKtCM0eZdnU6B/Y8A3u/cv5UmtzUrrVBxTm0Fz4kqOEgrc9PDXDQJHsmFsdUNuFHIOvIjenxTh/hxgHn2paT8jQTNSVENaNO3qjVcHCEhMMGNBkbJa6Ben6AhWC1dGAZvPDc57X9aELd/3x7jEn0+aTv9ghtym7sunu8mlXfzgxUgOW3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfXOFVzt5KJV5ze9ngQefAarB27yOCZy4Ikj8DPn7qc=;
 b=ifLbmJJFmQMDcmR7wrDo5XpExpZNX1RvNaOhIOd7H+ospCxf6I2iO8fHj0j5Ky5f6tYuW9EcAUYJN07WHPj2ScqVHZRIxt9YfS3JSz+E2agWUrFs7PIxBg7wnscmWg3zAH4Vlm4RqDS1OhOKHw+qAmhL+ZMwun9uuPpAbant1Bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 09:25:44 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 09:25:44 +0000
Message-ID: <5c1fa4e2-7751-d761-b6f7-edffedf2f090@amd.com>
Date: Fri, 13 Dec 2024 09:25:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 15/28] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-16-alejandro.lucero-palau@amd.com>
 <20241212180928.GH73795@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241212180928.GH73795@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d379e9-f616-412d-88d3-08dd1b581e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajR2VVczR3B3WVRISU9pd08rcGsxVG54bm8zVkkwOGhpbDdPVDFYUkd5VS9a?=
 =?utf-8?B?Q1paWG5KVVE3YVJaeUF5eXN0eUJnQ3lOMWtxSE9Xc3dibG9WZXRwTGw0SjI1?=
 =?utf-8?B?RjJQcWF6dnA2V0gycllDeGs4WGFvVE5KSGRsdTBxUWJWajQxN0hHM0I3ZnRh?=
 =?utf-8?B?OGZRUVlPUW9sRFR4czRhWm1CQmk3c1E3TWZuMHFITndQUFpxWm5KU3dDWE92?=
 =?utf-8?B?Z2V4V3ZnMzRXSlR4Y3dTVDNZanlocDR2d3p1ZUVUK3FSUURIb2J2cTYwQXdO?=
 =?utf-8?B?NGF3UmNEamNGTHk1ZWV4YlVMNVAzSkdYNnovZWQ3bUF1U3RNd3daNEl4NDQr?=
 =?utf-8?B?MXRWOGwxTlkwRjdTY3FjUkpIbzBLSndFeWZINkdXK3JTK2swZlBRbWFpY29D?=
 =?utf-8?B?TUxVYkhpZXU2UGhvakFUT2NPMWE0blpiQ1RvRXJEeFMzNkUzUmpSejRxZmY5?=
 =?utf-8?B?QktublJhQTJtN3YvTVlUa0QwNVlxSTNtK0VYQkRmV3hPV3FhVGd4dWREVWJK?=
 =?utf-8?B?MFZ0TmJ4NG84alJ3R1hKbDJIUW9XOENZN2o0SWdSWEs4QVZJZHNkSjFNZldj?=
 =?utf-8?B?RWR6Ukp3RkNRWFk1TVRsSHp6cnFwaktTa1V4RW0ycEMvbXJZMmdLWlhsd2xx?=
 =?utf-8?B?TDVnUHozd1RoalNaQ2lLOWR3czI3U09MYVFhM20zc0xtc2l0Nk1rMk9NVU1v?=
 =?utf-8?B?YkZwQW9yOE55VEdpY0EyczdzbDExNnpmbklZV3FOQURCaGs3ZUhSUXlOaEdS?=
 =?utf-8?B?bGlQY0licytGVGx1N0orckdQMVRZMll4dFJKck5wbGpMNkcrWkhIZEkvZG9U?=
 =?utf-8?B?Wm1sWWltZmdSa1J3V0dzbmFERWkrUmllQkQvWXQ1enBUL0oxTndLaWVrS0Qv?=
 =?utf-8?B?MnNma1A2K2VDc0lpY25VTDRNTXdsTmNKWXB5aWRRYWtuSTRjaWFidWpFUm9H?=
 =?utf-8?B?bGJhbkJNWnF3SFZWait2d3hUTW1ac2FrODA0V1NKV3FTRzRoYXNSanR1TXFx?=
 =?utf-8?B?YnFLcERVN0EvdGhoNDNWbThQUWs2Z3hyblJYWnJXRU5lanhCTEpiZXRLUDV5?=
 =?utf-8?B?M05zNTJXeE9zVG5XQUE0OHZlUWZaVkZZSWlNakpzZ2g0T3hVNkNUclVYZE9B?=
 =?utf-8?B?NUxtbWN1MUZNLzNOR0tvUCtzdnc0eU5VUEtvUnVvYU40QS8vL3NSU3B6UThX?=
 =?utf-8?B?YThiTXpRUDROVHVFc1FxbkZxQnBQWml6S0szSm1CT091SWx2OHg4TkptWk1x?=
 =?utf-8?B?SmhYOTErSlZUdUY1ZFlqdDd5UHVCTmVKdVpMTng2aUlKMWhmL3J0NnBXbHJT?=
 =?utf-8?B?QzJaenRnSGJaeXNXblkwZFEwL21sMzVxRXlxVHptMktvOWtINXdFNEJTMURv?=
 =?utf-8?B?T004amtSZ0ZZQjF4OXNYV3JJc1FrMk9HcEFPdlh5WFgyQ2puamNidU94NlR2?=
 =?utf-8?B?dkY3aHNMQ1BpSW5FRkRDM1Qya2F5Nng4eHcveFkzbmFXVE5IdFZ6U0Iyd3Nv?=
 =?utf-8?B?VEFiYVE1WFY4TUNLaFEvTnpqRmlLWE12YmNqZVByVlhMcTQzN1grcTUrN3Rm?=
 =?utf-8?B?MFB0RVpzSEJZVDhhSWFQc1JzSDVxS2pMeHRIV3pDRFI2V1FJRktZSHJjVEly?=
 =?utf-8?B?ZG9rTE1HSmMrSE55OVBKZUt5c2E3TzV1VkRMMHVDakxNbVlzTFMrczRFc1cz?=
 =?utf-8?B?QkxDSXZpUGYyZFQvRGpzbnVOYTFSbVVWSTNkWVNkRmNNNVJwZ1paMEp3dFhj?=
 =?utf-8?B?ZWxOb3lKMTcwK21EV0JrMDVQR3hjSHRTeCtDVlVlRXU0c2VhUWZHeGFTL0Vl?=
 =?utf-8?Q?PEpMekD6scSsak8MmnV0g82DKoCnLA03fGny4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1NhaGRJaXB1MFcxTDBOTVF1OE82KzRLTlVkRk4vYmt0REVjRVMzR1V1WmVQ?=
 =?utf-8?B?dGRYemJ5a3R3eG4rVHFuZUpyYTVGZUZQM2h3KzN4SHRyNDNaNW12V3hwWm1t?=
 =?utf-8?B?SXhxZVV6UXRhdDJiaklqSkhoYlhldXZLUTk3dzBBK2JmWEZlNk1BSlNiRjhS?=
 =?utf-8?B?eGhac243eHd2RGV5RnhvU2pTZGNEZXRlMHd1QzYvczVEeWJpV1ZNTENwWmZR?=
 =?utf-8?B?aWdwWVpHUVlBMVlOenhVb2ZBdjhFeE1wbE0vZDZuakFLbzhnT2dqWml6Y256?=
 =?utf-8?B?WlpVLy82ZjluUVFWelRLdHJ5c2NaTGlsZGJkWXlFWC9FRnFpYVRLM1FQT01x?=
 =?utf-8?B?UGp4SWJNYXlSbS9OV0R6K0JPRFZQc2tDSWdKaEs1UGgyRzZFNHFvVHc3QjFJ?=
 =?utf-8?B?VGxhZHEvdXl2NCt0YlNFQmdrYnFhNmRKdk1UMHU4NXRWWkthTldoMWJDQWxF?=
 =?utf-8?B?Q1c2RmhJRVJwaCtFVDNFcVNtZENGS1dOdmx0R29qL2FvY2pQSDJRRlBWN05k?=
 =?utf-8?B?bmJ3Ui9vN2hIdlhIdUwvZkplS1dZUjlsZkVNWkh2bUZHRFB0Uy9VaWx5TThi?=
 =?utf-8?B?Q3VRZEdFUVF6SklFYzlWTHFlTlkxK3lxN1NBc3huTkdBYURvVEgxWkd0NnZF?=
 =?utf-8?B?K1Z2Nm5BMWMzQ1NjR2VFcmFYNFNjeGVUeEdJVk5aTkZWTHhlSkt5bUUyM1pZ?=
 =?utf-8?B?aVVkN3NKRXlTWWIvZjZrVHVXZTBmelBGdXZNaXQ0azFURkROSkJ3NEJyM0h0?=
 =?utf-8?B?MzJUV0RMaTE0WlllYXppNzkrcVExa2liMnJxSUNvakY4ZHh5d3pJb3dSbU55?=
 =?utf-8?B?YXFvMm9pU2NkRUNqSC85QWZsV1Z2R0NhaXhucGxteWtQY1IvaFJFaXQzamw4?=
 =?utf-8?B?NDlzRWM2MDA5enBtWXRyNzZ5WW1wR3RQemtZaDMxQ3d6UzhMemdKUWRWblBR?=
 =?utf-8?B?RXRVd1R1NDVZWE5TWWR5Sll1VFJSalI3Sk1pTG5DaGtYMWVYQkQ2cjBZUTR2?=
 =?utf-8?B?aTM4cnA1WHZaY0svekUxZUowZDBVQ1VrdnZpbk5vajN4NkIvVk5nRHpiU1Bj?=
 =?utf-8?B?b1AxbmpxU0V4NDE0b1dJTjVsMGNGbDNqQm9majZoMndqMDJuUXM1OHAyaFBH?=
 =?utf-8?B?STYvanNWVTNGSXQ1WDRZZStGWXJWV2ViQ1d6ZFZtbkhpM1d4NHh5YXphVk5B?=
 =?utf-8?B?LzZFdVZjM01pZjhoak8vL1I3K3RFZXFYVUMySDJORFZONFU4TEpqQVllend2?=
 =?utf-8?B?dXBDSFBnamJTcWxLY0xxRlc5NFJNQ245dXFmU1hlc0JQZXJKSVRIeGVDT1FK?=
 =?utf-8?B?S3hmdEUyQTdPRjhoMXZGSEU5S2d1WGVveFU2ZFNPRUZyTjZMc2lncHZveFBY?=
 =?utf-8?B?cUU5cSs5V2RqQmhEc2dxcWEvdmlub2ROaEFUQWplY0oxa3RzWXA3cVoyOFNo?=
 =?utf-8?B?ZS9kNHRZSUs4dGVSK3FWS29vakhjK3NTejEzc0l6OExKK3BEbHVwV1pCejZi?=
 =?utf-8?B?UDF3ZWt3bmdVUVdIeHdNNk1sMTh1QysyMzNwSHVrZGY0THBlNmlvNVFsL0xr?=
 =?utf-8?B?ODJVblc1R2JsUjlsR3gxTkNkbGdWaExISDU4ZnF1bGQ0ekFCVFBtRWJpYllO?=
 =?utf-8?B?aHZCR2FpcVlxSkNLQUJORkwvN0Rnc0VES2hLTlplTTJYWnFTL0k1akk0QUVx?=
 =?utf-8?B?QUtoUGRCMkhQUE80aTZZeDdJNTBQL0RoTUpaWVBPZjFvdmV2TWtVbGVVTUVO?=
 =?utf-8?B?aEk2WXF4MnpyTXZOcUtvMHFYbE56Nmk1c2c4K3pRdy9xVTFrYzRFQ2F0QzdN?=
 =?utf-8?B?aW1tWTM0WnM0ZFZxci9wNFpOd08yN0pENkFLZncvYzlxdnFFMWZrWjkxYytT?=
 =?utf-8?B?Z3lEMHczR2lldGlEOVlsM2FhdDZBSjVPUURUN3Rxblh3dnJHbUZaeGJsUjFr?=
 =?utf-8?B?TDdwR0YyOER2YnhPOHdxdGZnVVFvQjBYSHRZOS83K0RhRGJkblJHdnQwUG5s?=
 =?utf-8?B?c3QwbzhidjhHVzI3elRTTFJ1ZURHbDBxRkFDVGRkNGVNVnJCcVM4bmJlUFFX?=
 =?utf-8?B?Q2kyY3FyTjhuZUFVYzhoM3d0aTVXRFhoM2lva01sbHhIbzB3UWV1MlpKTDkv?=
 =?utf-8?Q?K1aTqVBYCddK6qzy6072AHdMm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d379e9-f616-412d-88d3-08dd1b581e76
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 09:25:44.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/g/nYGs2EEAcDBQlIRnwdL7yiK1601qWC82/js3T9dXEH+zm24Dyg9HVbsXG+U/wH8EGYS5fKJgsE5aDdtXzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729


On 12/12/24 18:09, Simon Horman wrote:
> On Mon, Dec 09, 2024 at 06:54:16PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is create equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/region.c | 154 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |   8 ++
>>   3 files changed, 165 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 967132b49832..77af6a59f4b5 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -687,6 +687,160 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device *host_bridge;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "%s, flags not matching: %08lx vs %08lx\n",
>> +			__func__, cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * The CXL specs do not forbid an accelerator being part of an
>> +	 * interleaved HPA range, but it is unlikely and because it helps
>> +	 * simplifying the code, we assume this being the case by now.
>> +	 */
>> +	if (cxld->interleave_ways != 1) {
>> +		dev_dbg(dev, "%s, interleave_ways not matching\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	guard(rwsem_read)(&cxl_region_rwsem);
>> +	if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
>> +		dev_dbg(dev, "%s, host bridge does not match\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	max = 0;
>> +	res = cxlrd->res->child;
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		/*
>> +		 * Sanity check for preventing arithmetic problems below as a
>> +		 * resource with size 0 could imply using the end field below
>> +		 * when set to unsigned zero - 1 or all f in hex.
>> +		 */
>> +		if (!resource_size(prev))
>> +			continue;
> Hi Alejandro and Dan,
>
> Below it is assumed that prev may be null.
> But above resource_size will dereference it unconditionally.
> That doesn't seem right.


Hi Simon,


I added this code in the last version for addressing concerns regarding 
the resource being with 0 size, so it is me the one to put the blame on!


I'll fix that for v8.


Thanks!


> Flagged by Smatch.
>
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
>> +		__func__, &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
>> +		get_device(CXLRD_DEV(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +		dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
>> +			__func__, &max);
>> +	}
>> +	return 0;
>> +}
> ...

