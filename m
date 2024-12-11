Return-Path: <netdev+bounces-151048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 104399EC900
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A943E1880551
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7961C1F0E48;
	Wed, 11 Dec 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LdHQsn12"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5791A8412;
	Wed, 11 Dec 2024 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909002; cv=fail; b=uQLTUOkfmn2kjxsOeweqgnWac4sJ0jtUVwzsAsOBK7dncl0o9zI4PumMLF1Vm0N9dzNkHbm6+RVo/GRfcJc1RGpaA+H94V1Q8HLtZT821l8e78p5lhiHIS4jw3gTY1viIRAk3wfiFYx2EJloh/8NE3KtJUBJSKP347nbSwFchxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909002; c=relaxed/simple;
	bh=a/0ZtYo/xqKMWT7jV2vfLrakOg0eHMKBSLx3ZBpg4R0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Epqs7AcV9KijIe+is7RvRMa8XfVSzZQ21kXV/x4o3TgOEajeU3gmA/mAsw5ulCePgKRwAejsoSBB8ms1H0XEVxqIXdtu+3wCzOwlcZIzmCz++i6VILjcxuOwpQgs2IIm4ziVUgOOPE/E+c09w3AOwe0X0zSCV6mH2qVPuS4Kciw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LdHQsn12; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJKbtCaMw6zjCJg8kSz3J4NFR1g0Tgb8rJkGiC3U6tjqOAKfwf3dLUaYChCXx894O+Jo//BzfAMkdVMmn5FW1VYAeqa5iNCSApZ0oNBuqZnkbAuxP2cr7QXswKQ8G390Awbpp2XHTkzaWipkzKnk8doIN4dq+rEh22pJtafdOGS132arbae9siAehYSe6kTfQIj1Ztancnn5dYWtn/oEr+G/icUrr65+jGY6UlAAAbOEvbnEafA9QGEXkjOf1aAZWZWeuvAyUWJ/DwdHnVH9X7zphfJPAUPByjfG5XvID9QOCA5MzmoqdvisG/9GSbmr9L+gfNL+f7k5dVXTA2LgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXENijjBfswKQC52am7TKSfwPAk4c38giGhxKd6A8us=;
 b=s1Un8uq2aOPJoxu2iMPv7molWE3k6/A7QjuSbrzFWyTwnsAYY90U/vzSKbIs/hpHzwAaaID9WoHGLRmLPY8k2MLfyaT3100r6KgFPgz0AeciyHZ7UfMvVsqGaR4nnVlxoPVLcsJoQNXqBRdRnx6/bm0t4V9CChuvpX5Uxh9fZRo2RT18yYLPK6upGoYj7Ch6yyx1skctp/JFd4OQ7kw27P8JnCzv1LeimQ4Rsf4ZmPIM5j6MC1OFO8r9ymO5wcPIdf56TbAXa4j0ZWYwZpk4AskyZ2BBntYyJQBX+qHyT61uAFYjFj5XRdPZCLQez8Rr6QHP9MgvCjXkoB+6O9wUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXENijjBfswKQC52am7TKSfwPAk4c38giGhxKd6A8us=;
 b=LdHQsn12ZH2IXiIHTCIE8VcWXE9R1bY0i3iYAPvbMgi3bgw8eGPMt7qe7D/mb25fOvcq6K+H97x7UhMmObYdC+6lYAJ07SW3G/+9mCmLtLKMw+mr4qWHMIk5+rWATGrM2Ibk8kMWJqk6sG4x1zuif2dkFyWSQ4SKXbEtVEKYQSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 09:23:14 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 09:23:14 +0000
Message-ID: <2dfb81cf-a606-3146-117b-5b5cf25ddbe9@amd.com>
Date: Wed, 11 Dec 2024 09:23:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 24/28] cxl: add region flag for precluding a device
 memory to be used for dax
Content-Language: en-US
To: Edward Cree <ecree.xilinx@gmail.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-25-alejandro.lucero-palau@amd.com>
 <455f8e81-fa7b-f416-db0d-4ad9ac158865@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <455f8e81-fa7b-f416-db0d-4ad9ac158865@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::26) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df8e8ca-c900-4b5e-352f-08dd19c5708c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDY2M3U2clh5NlhuNVdwVG90Z216SDRVU1RhS0lrRnNEMWVEbERRTTZpWCt6?=
 =?utf-8?B?ZHRXa2kzeHdwbnhLL2dUYkRjMVpNOFZWaE16NnFaRGR4K2lzS2Fub1hqbnR3?=
 =?utf-8?B?blgzR1ZVdElObVVPUWEzK1I4SVdmQ1NQQ3BhOXJuWlo1SEVuUTdvVUVDSnRW?=
 =?utf-8?B?NS9UWlUrVGlEKy9tRFBJaVc3TnhzR1c2d08vT0dhdVFEWmt1MUpzWmM3UmYv?=
 =?utf-8?B?QjZCZ3l0eXpmVSt5V3F1YkIrK0p5cERNOThKOEhscTJ5ZXYvRzF0c3RpTXBK?=
 =?utf-8?B?c0dGQTc1aUtSd1JESUJ5UTg0TkNSb05XUjdEVkVSRllSS0hLNXR2b2Nac0xj?=
 =?utf-8?B?eENoRWFRdzN2eUNIMG1Ib2Q5ZUg1UVh4TWcwMng0VmlYTzFWeXZaMzZGTmRS?=
 =?utf-8?B?cEMzUG1JQmJzRC9HT1ExUGZsSVBQcmsyNU5hVGpodC9oZk9Vbm94OVNneGNy?=
 =?utf-8?B?dFpENlhDZGtIa3RMLzhKMmRZTjMrcFIxUzBucUI4dWdHd2VtcWV3Y2U5QXhz?=
 =?utf-8?B?WjBCbHBteFM3bkZHUlA2cVE0Q3FCTTBZeFM0VytwRy9wcWs2bFVFeTRPdVU5?=
 =?utf-8?B?VU1PUnNzWVZBUlVLSXVSYU1uUjJnQTkrblVlWXJoK2h2UW55Y2Zxek94WlZB?=
 =?utf-8?B?N2llclNkUytxZWlJL0hLcXJNNzdVWit5TVVwcnVoS3l5TFU3RmlIYmo0MnBG?=
 =?utf-8?B?ejZEUTdpMGh3Z2RuQVZoeDNzbFk1WU5Nbk53OTJxVWY1VldsaXE0L1oxNjB3?=
 =?utf-8?B?cGdoK0tmYzVoMzkvbnFoRkhxTkcxYjdLODJjSjZTMmhIVlJ3OHNXUDByYm5J?=
 =?utf-8?B?c1N6Z0VFRTB5em15SWlwVGxXUGlUZFlSZHIrU1ZBTFJhOWJLcWdXL28rNkhl?=
 =?utf-8?B?UnVtYnNjN3ZUL2ZkSndzSWNPVWNxbmgxRFVSemlPYm9NcngwSmxsRUdzN3oy?=
 =?utf-8?B?eTlJSnQwQ2pyb2xyd3N3Rzdnc29LRWl1dGFyTG1GK256amo0amh5elVEQVZD?=
 =?utf-8?B?ZDBndlh2cVRndENWM3FzWGZtRVF0RkpXUkx5b2ZDQTVTVTJXS3pkN0E1bHJY?=
 =?utf-8?B?M1FwaEZQWS9ReGpzQk5JbUJiMkZLWXluV1BKWHFaendKTXg5UTViYVBuWnl1?=
 =?utf-8?B?M09WL3FBaWdBWW5rcXVhaWU3d0hFQ3lIUlh2SHVFSHA1YjZzcWNvZGpqWGJG?=
 =?utf-8?B?SnJGS1RGajhwcHI0eC80VUtMeTFvZi94MnA0YWh5eG8xd2xWMTNDbW91UlNR?=
 =?utf-8?B?Uk43V0xmZjUvWUVpOHk2WE1hYkFQcW1UVWhhUmNvdmlLNThabUowa0FSVFg3?=
 =?utf-8?B?RlUrbWsyV1RiUVR0b1hDNVlpalMxZzE4blc3bEhnZHhsY3pibDZYRTR3RWhj?=
 =?utf-8?B?clFvdEF4RnA2b0RGMXI4VUc1cllDR1FVZjJRcExUTFh6LzFSZUhJMHFVZTR6?=
 =?utf-8?B?VHRiTElub2tadjQ0djgwaEIrSVJ0SkJSWHZtMHpiUHNlZzU4Sm9CaldHOTVq?=
 =?utf-8?B?cHVUWGF3R3hoaTErMER0M29ad3hOUUwwNG5Yb243VUNWWENiYnRBSmRVTEdD?=
 =?utf-8?B?ZWFHYkhUU21VNFNCM3RCaDdSNFRuaHVpdnZoNGcxeGRDcjdRNTZSaWZHdHFR?=
 =?utf-8?B?T0kzU2pMNHJ1QlZ3RUZFOFpUTFMrenVMSm90MWx6bnVMeHdPZWk4LzVSaTZk?=
 =?utf-8?B?azZRWXV5YmUzNXYzVWxpU1BBWDBhSW96SENqODRGOGtqMWcrdDJRTjROYWdM?=
 =?utf-8?B?czdZWHV6TEJhdEpIZnAvMVV2Q3pPTnJzSmRJM2hZUVIwN1lWUUp0SXNYSHdJ?=
 =?utf-8?B?OURsV2dueHgvT3hhL1FENnBBMmdQS1JsQ1g5bHpVdGxTVXY2cGh1S0dFbURi?=
 =?utf-8?Q?1rSpNOjyYfZAI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDJBZEpvZUNxK1lLa2YyZWUrc2U2S3oraFRHT1VzOFZuWHkrS3JWQTNrWXE0?=
 =?utf-8?B?NjdYR2Z6czIya2lKU3c4N2NkZ2tFWWtxYzJSVXdZWENIYnVXaGw5YVRwQjh0?=
 =?utf-8?B?QklvY2IyajRjQ2daNGlLZHBsSEx0S3AvdTVMdmxBV3YyOXlxeWVjZTBUWnRq?=
 =?utf-8?B?R056VkM0ZXlzVHVJb0hmNWh4b1l2bm9EWlNLckhmQzBCb1NwUWtOOHVKcnJD?=
 =?utf-8?B?dWN0YXE3cDJKUnpCb0R4U3pBczBDNUw3OWNYT3BKcXpPUG90dlJrM1hrUWtv?=
 =?utf-8?B?UnBvMWdqNmJ6akxRVkorSGp6UTVuVklRWWpLbkYvNnNMWVd5UllnQ0l4Wks1?=
 =?utf-8?B?TnVUMjcrMnZnSmE5SWgydXZSY09McEQ3bXZYVVdjaGUrQkk1SmhsOXZ0d0N4?=
 =?utf-8?B?ZlJkU0F5T3AxaFdJOS9JaytsTTI3WnJOci9ONjd5SWhQQ2h1V0gxUFBkLzNm?=
 =?utf-8?B?N0IvakNpdi9HTkNHVWJhdy9zWS9BRWpNQTVXeGR1V3B0RGwrZmIwZlMvZXl1?=
 =?utf-8?B?dExSTTNDMm9TU2lCZVZDRjNNR3FIaUE0NnlxazNmekNwWjJralFwbkt3cXJI?=
 =?utf-8?B?MGpRVVlaY081RWxrL2RQcThGNFNwalJZQTJrRFVvZ2xrdTVLNW5YRG5BRDJs?=
 =?utf-8?B?eWFtMVAxc2htN0kxY0RpLzdVNytSbU5udXlaY0NQOE0zVXh2VU12OC9iQU8x?=
 =?utf-8?B?L2xzUWxqQ0twT3dDQ2w4Z3RqU1NzRURIMWM4Z1JVZ09UNnlaZTR3NGxyYzgz?=
 =?utf-8?B?TEMzN1orbGlkQXI0RUlXZlRtbW5MemRuTDlQdG1SSm41VUNLbWswY0VqVmJa?=
 =?utf-8?B?RFFCbi9GSmZtVVBWTWRoQm1YS3g3ajZ0WjZja2ZBUmsxZmIxeFV5bSt6bksw?=
 =?utf-8?B?MkpIdEFSaERzQUwreWplNmZpc2x1ZE9xaFJFMk5UaFFBQ0tsUUMzYlhnN2Zu?=
 =?utf-8?B?cjBIZzgzYWk4YmVzZ2dJcU9nMm1EWkpiSzVDRlhvVU9PbkZLeUsxY1pEc2w2?=
 =?utf-8?B?NW9BbVlXZFhRbkxxNDM3d0FpcTdjYW0vWXo5ZFBmZmVqVjlKNTMxZjhUaWVQ?=
 =?utf-8?B?bDlSZ2lwYWFwVHZZTWRaSkN1dVpkTzJJS2EraHB5bDI0WlRweUpJN2VJV1ZG?=
 =?utf-8?B?Z2h3Zm8veVRYZFdsUmdabEZsbDF5Vi9Sd2xUWStRWk4ybDZMVWFPMFU0L3hw?=
 =?utf-8?B?WGJVTm5lTmFzS0lRbUUzbzRSOThUVmIvNVJIdFhCNk1WVE5xMTZnUkpYOVox?=
 =?utf-8?B?QW9mUlpSOGYrdGdibE9kZi9CTjBpVHlCVFRUc2tOejZzbDhyOXBjcy84UjBU?=
 =?utf-8?B?YnJRTWQwWmtRUENrbDFVL3hGd2pBTXdIOG8yRERxYUFoRHc3TnY4UkFHT0Y3?=
 =?utf-8?B?OG5rQzc4ZnFISDlwUkNDd0N2aStrM0sxUlE2MGR3c1Jac29IZ2xhbGVNckRj?=
 =?utf-8?B?V2kwRmdEeHA0ZU9VWGNRY3F4NUN2dzArR2xtY3RyeXQ4Zy9zcUcreGFGb1dO?=
 =?utf-8?B?OUw3Und4MDRHRUI5bHZvUGVjWmIxQUUweUdRQnJUNWh2MEVaWTljOTJjbDJ2?=
 =?utf-8?B?cDVCbStFOTdUOTZhZGpCQTcyZW5jaGNjcHVLMnY2WWRxTTFvM0RvcTVhcVpr?=
 =?utf-8?B?dktZN2FwS0NaK0hKdDJxOXF4elF3THM0QnpFbDNPTmtBOWNHbDZ5ak9LOUlx?=
 =?utf-8?B?ckNSTEd4NndNdzNkWklqOTYyNEVQVFNJMmRqNzJvczRPSWpmU25oM3FoRmVx?=
 =?utf-8?B?UGFJUnY5cHp6a1ZPb0xMaU15ZVBpN2xVVzZVNWc5Tno5T1puNU1GU3VCckUr?=
 =?utf-8?B?T1FEU0xPVzdqWWUyMGowdzdHcE9YQTlsZE15d3pKMkN1dkRBdUZTckozOTAz?=
 =?utf-8?B?R2VDOXdyaVg0ZE9CdlRtNThuT2N2WDV5VGszd3dNOG1Pek4vNkw5U0dxNHRE?=
 =?utf-8?B?Ri96ZzE4V0xyQUo1VXZGZzA5Nld5d2UyQjRZOHBtanBBMW5yTFU3S3VqMDNi?=
 =?utf-8?B?bTdhVHFvYjlYeWo0QnRNUnFhYkNsV1cvRkVvSnZGRkxzd3N5SEZsbnlwUHdE?=
 =?utf-8?B?cEhOZSswZFBIQ2dGMUNNRExsWDZiRnhNS2cxTDFkbUVWSnZjWVBJYzFYbDBh?=
 =?utf-8?Q?XBCQVYOZu7aaKB6xV4BHm/JY+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df8e8ca-c900-4b5e-352f-08dd19c5708c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:23:14.8274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAJl2aDZoyDufqSWL7datZK0UDky/LJREBFmmrmkER+UovnaVjkpQGzy2Tg9bXnRyFEJyn78kGBPwldullqAbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723


On 12/11/24 02:31, Edward Cree wrote:
> On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> By definition a type2 cxl device will use the host managed memory for
>> specific functionality, therefore it should not be available to other
>> uses. However, a dax interface could be just good enough in some cases.
>>
>> Add a flag to a cxl region for specifically state to not create a dax
>> device. Allow a Type2 driver to set that flag at region creation time.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>> ---
>>   drivers/cxl/core/region.c | 10 +++++++++-
>>   drivers/cxl/cxl.h         |  3 +++
>>   drivers/cxl/cxlmem.h      |  3 ++-
>>   include/cxl/cxl.h         |  3 ++-
>>   4 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index b014f2fab789..b39086356d74 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3562,7 +3562,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>>    * cxl_region driver.
>>    */
>>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> -				     struct cxl_endpoint_decoder *cxled)
>> +				     struct cxl_endpoint_decoder *cxled,
>> +				     bool no_dax)
> Won't this break bisectability?  sfc won't build as of this commit
>   because it tries to call cxl_create_region with the old signature.
> You could do the whole dance of having an interim API during the
>   conversion, but seems simpler just to reorder the patches so that
>   the no_dax parameter is added first before the caller is introduced.


Oh. That's true. I wonder why the robot did not catch this! I thought it 
was building things after each patch in a patchset.

I will change the order for properly using this in the sfc driver.

Thanks!



