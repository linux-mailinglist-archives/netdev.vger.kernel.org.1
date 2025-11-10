Return-Path: <netdev+bounces-237168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF9DC46741
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BB41884C28
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2516C30DD27;
	Mon, 10 Nov 2025 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KGfoy45l"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22E30CDBC;
	Mon, 10 Nov 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776167; cv=fail; b=idXtWfZLrWcrpn1fUVwFZ0Ibsv4EBGzSLz13JEvlb20R4N7VPiRBpAb8llGkQMfSdQ4MX3j1UrsT3/CxzEWUOxqxmY/yQvK86r0o8xg497txwaQYhdK2P+FdtdMws8hPzd4jzokUZ49+l2vIvv/pfZkqiZfJIK4YeSp0bgDfNyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776167; c=relaxed/simple;
	bh=aH1qM5ElciFXVplSwMou4WT0oUfSRxrnz1BFYb960m8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nn0lvjejiKmidFfGmUD4YKsVzU9gTd8bSME3jkKNQjrBQj/KmBy7/dXbaBwwByjR3veexOpwjZZ20xBb+U71fNXZLztHvHtRFnNf6Lgvp+1LtUgRhyMYZ0rb2Gc2XCRLFW+IRFfQfWxxnM5evO322mXj6fr1gOqV2naU/1P9KJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KGfoy45l; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0wcNT5yEFVVDNkGB/nu4hQkOCro8qR1bOzydtRms2O2NHlIq3fTFJhlE3jXwg9FLSRY4cDG6MMPROLB9hwpXp/Mv4Kn6Fdcrv9Tog19u0uvIPEZp9sNhOKsdIt0xKKnsiGEzAsr3XZiSrvxOiY4c59qPPmsFgc/W/i3KKna5SzVM6TDxZ5qYw9HacH7jKk1LAecNH4AQrFId3Aaz8s6o3xgA1F55C2/Dm5cvury85gFhkYga1D/+n+BtR10FQU69A+6PBlrB7MSqd+JObDSpwWLu0sZsRXzAMuZutCiEX/y9wfAoxeGhnMXSV2TjYzVOQ6rTN4Ier6lo8qojE9kow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDnO8FtrgBVw8qFMhJeB+EQ1qVxi1fpnY3Ty/qyU+zk=;
 b=AsmEEXr8z+f7JUuoAgjDDKrlp7cZkDElyGjx6Ts+egsCiTK3tr++yZLYoiAM3NOmZBuSNv5pbdI6RBA7znmBcL8amcnQdDDACx5ZiGfLMhe955UwElrnLFr9hJfOpnAx/09XBBmZjArsemsgGpcYIwEAhZNrxYlajOr/eF4Nh/YSFTSOCOgcKA18q+Kk5fPY+V5f06bnXnjy9pQlH1/8CzRu4p/o7YEYZX17tRrUUWFjD/TI5PNq5N0x7Sq3Xris/vdnxAsEUXtX4NUy+Z0JXQXWzNDfwmWMLxgVKMKv0mnuLVFF9AZyfZkOkg6LZ/AlTxHn6u7Y3lMZiIy6Ir6bHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDnO8FtrgBVw8qFMhJeB+EQ1qVxi1fpnY3Ty/qyU+zk=;
 b=KGfoy45ljjvowCuHCvMCyd5vnNHSpNDVn8KNi/p8Jek2jfyT7VsLJuvj1+x2boPcMcujyMhc8NEKdRZuf9H/JKbHsh35bmq4tVF0XWApTwnAkCewp7z1kMMTe7yWL6f2DEjG1Uxo1oaDrpsAVOVgy3CFGmgFIja5oway7TQ2ccY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 12:02:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 12:02:41 +0000
Message-ID: <95368d33-92c4-44c7-9482-4144e35c2d86@amd.com>
Date: Mon, 10 Nov 2025 12:02:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 13/22] cxl: Define a driver interface for DPA
 allocation
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-14-alejandro.lucero-palau@amd.com>
 <20251007145251.0000526a@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251007145251.0000526a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AUXP273CA0055.AREP273.PROD.OUTLOOK.COM
 (2603:1086:200:1b::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e57fd04-3367-4399-30fa-08de20510cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2xRZHVaQ1J6bzZhbDZLVlVzTXhhVDY2bjJ1M01lT1o3WlpQSElBVHFtV2Yz?=
 =?utf-8?B?M0paRjNnWFpwTThEK1FjQ21VaW5TR0h3Qk5WdlFCQmFKZlJqenM1THZYaG9y?=
 =?utf-8?B?UDZ6Mi9HcDViTElhVDJKY0RVZGtHVFNyNG1aZzkxblh2bnJCZFNzclNnWUpK?=
 =?utf-8?B?cTNPc01rVlBVZmVPMW50OG1mSWs1b05BblZXT2NNamJ3cHp5YlBseVhiVG1Z?=
 =?utf-8?B?ZmM2aFlQTDRaUmlzeU5Kc05tNU1ZaG11N3NtUlArMHRPMmRRWW9tWGF6VjJO?=
 =?utf-8?B?U3puR3IxRnNvazdHdXN3ajJzdytFa2orSktLOGg2b0VYblpoY2lUQ3ZvQXgy?=
 =?utf-8?B?Q2RvSWszQ3VMZ1Z2a1NOTmRSWTlTZUd4WWRQQWt6dXBEKzAyS2ZrcktJdUN3?=
 =?utf-8?B?bkZqdnhkMUpvMElWbHdyMXIrRFptbUVrZEpkMFhISXZlMXROekNaSmV4YzV6?=
 =?utf-8?B?MjRSTXNRWi82RWxCUUF5VmN4KzVqNnBBRVFFOEZZbVRiVmNVd212aG5yOGZ6?=
 =?utf-8?B?MmNGRlBKSHVFUkFsYzM3cjE1Y1dZU3NneUNVQUxIY0J1UFVoS3V4ZTY0ZUNs?=
 =?utf-8?B?QzdIeVMyaG1FMHlybHM4Y3o3M1oyWXRWck1nVWN0dHo5RTVFV1JQMk1JQUp4?=
 =?utf-8?B?WVMvM29ZYWJLV084dFRPWkNlU1I1akZiVTJrWnVxMDg1dEV4L3VIcWlCaHVD?=
 =?utf-8?B?RzF4cFVzVlFaTFFGdjdpbFVTV3lNc09DNllITkpneEV5L0oxZUhKb2FoaEd0?=
 =?utf-8?B?U2hHV0Y3QUVUSnlqVTVSdDJPKys1SUoxRjB6UDQ5bVpXV1AyWm43Mm9XN1JJ?=
 =?utf-8?B?M0NZaWl1ZjY5RWlueE9EWjJIeS9JcXpIVm1WT0ZweG1iUzg0VXlaMHlMaUp0?=
 =?utf-8?B?VVJwOXJoZUs2ZUVWZVBWODF4bC9peUMyZ1c4ckhvWExPZjErTXpUNll0Ry9k?=
 =?utf-8?B?SUpHdWNZZUJNazR2TXFBb3QyenpBZzg2bVllMlJRYXNDUjJ6bkhQMXNiOVBy?=
 =?utf-8?B?SlV3bW9SeEl0OVFEeHc3TnVlMGpveUdNWnoxNlBJMmt1YjREbGtYR05MUmI2?=
 =?utf-8?B?RVVvaDJ3QVh2MWhPaWQrR1dBTEwrS09wQjVHbzJYVFdzTThxVGw4N016UFds?=
 =?utf-8?B?NUZmVUlrU2dwYnNxS0gxWnNrazZlaGdmUTZhZnZCUkJ3MHczVUY0Z2tuOHVw?=
 =?utf-8?B?UlJvU2JFZllJeVdTbkZqY2Z3Q3RqSjl5OE1YK0VEeGc2c0tuU3ZSS2xwVlov?=
 =?utf-8?B?djlQaC9va0cwMlpGMEc2KzBjZHVZazJkaWkxTFBVQXlESnlmdzF2cFgycTNs?=
 =?utf-8?B?YVlSUHQvUnNzcXBkNnd4cnFXbGxVbGw4NmxXV0d3S1dpNHQwdDFyS2paR2JF?=
 =?utf-8?B?OXM3VlNRSmFSV3U0L1FIS25SajdOOXhacEJuTzFUVmNTU3ZFRHhWSzNUYkdZ?=
 =?utf-8?B?d1lXc01zM2VnR1ZZdEdlenh3V2g4TktTSC9NNjc4THJ4Vyt6b3Z4eXpPNG4x?=
 =?utf-8?B?VUg1azZNZ0ZBbS83QUJBSGZvbC9xRW84Zk4xMDhsQWtObHJ5RmRVQzhZNDZM?=
 =?utf-8?B?SWhRNHoyckVjWHN4R0ZXenhEVXptUThTWFJneWFqL3RzM2pLNlZnVmpocC9Y?=
 =?utf-8?B?N0prTmZRNEtjQnB3Yy9GdHNrK0s4M1pibnE5K2VJeStGSEkySlczL2oxeUN1?=
 =?utf-8?B?Y3BQUVFKSFhsZEZZL1doOGZScEdTYXFjdDVUVzZibml6R24ySGxVYXlxbGlJ?=
 =?utf-8?B?NGJhby9CcWJyMHhRWGN0RTdHOEEwWkZtYjhneW9KckpWeTRPUUZLMHRTbksv?=
 =?utf-8?B?NnhPRXIvQ0JyZnAzT2w0dm96MVRTRmZJcWtVRVk3SWJYSTZaekszYjB5Q2dV?=
 =?utf-8?B?eUhjTXFJTFNRRHVuYXJPNlUvNzZaWjJIbnphQjhjMHpwNzJPUlAxTEo2Qm5y?=
 =?utf-8?B?VTlsRk1kZm5DRW5nRmkxa1JaaXJnaDI3LzJVeHdEeEsxdUdZU0ozLyt3Ri9a?=
 =?utf-8?B?YjJRMTNHMFlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clhxYk12R1VhK2FUd0hyRGVpdndBNUpYNksrblY1dWN1MG9HR1Z0ZmlpNFky?=
 =?utf-8?B?RjlScWtLbFY2WTZIT0JDbHVLVEQzbDd6c3ZIblg4dnk1UUNZSjRPM1hLYWhS?=
 =?utf-8?B?TmovTTBMb2JXbnY5a2J6U3RCYys2NW1aZ0s4NEsrejRQRzF2cG1ieGViWkM3?=
 =?utf-8?B?REVWNHc4U2h0Q0FuVzcyWFRQbkN6Y3pad0hIekRuNGdzRlNLZmtpckh4T2py?=
 =?utf-8?B?OXJMdUNUb3VSRmtXZnU1UjRXU2JRakpCL0dnYXZKUWlLQ2QvK1EvbDNyR1Uz?=
 =?utf-8?B?WGlRb2dQR01uVlQ3SEZlYTJDYksvbWpqK0lIeXFuR2NRQkx3NUZtWVE0NFVu?=
 =?utf-8?B?TndzU1RTcjhRMytKVm40bGVaVFV5Y3FoT0lEYzdvZ0M5dm5ZbXlpbzBjU2R2?=
 =?utf-8?B?N3JxT1M3blFTNEtjakRkRFZqeEtsMkJ6Z0JTQ0lidUNmYzBCQjZhQ2grY2Fo?=
 =?utf-8?B?L2lqYTZMMjZZRTRvV3pJY1kyM2srMjI1NEdHSDdUdlNBUk51YXZxT3VKSUcv?=
 =?utf-8?B?OXZFWEJGZmhPcEVLKzZwOWdkeXJ6QW1MUmRDWm94NTdGZW0rSnNMVnZDM0dx?=
 =?utf-8?B?enM1d2tiZGJ2K3R0M2h4UXB1TWFkTU10S2QzMFR6MER2dTExL1RiTHlsaENB?=
 =?utf-8?B?MktRK0tzWnB5UWhTajh3OGNHZHljQmF2K2NkRGFTc2JvbEZjQkNYL21oNDhW?=
 =?utf-8?B?dk9TdlBLaW1RZkNidTRKWGE5TjBCSmJoRlc1ZUREZFJUTklyaW84L1IyYkdN?=
 =?utf-8?B?NWI1TTRzemtSMCtweXhaam9UbUluU1loYlJvVzVCR0ovM252cHlNNkppRE9o?=
 =?utf-8?B?UTFRUGZZdUtib21QLzhrdFJ1VnVsUXp2N0ducVRvdmljVkMxWTM3blNPMEY3?=
 =?utf-8?B?SnorT2E5TEVaKzQ0Tk1hSGo4OVQ5OWlMcEJJdEZCOTN1eFpoSnFBMkxQMjk0?=
 =?utf-8?B?andVc2I0NmFHNm9BYnVPVkxYVzZvQzNrUUk2MXdLSTBhNVcycW1pOWV3WFFs?=
 =?utf-8?B?OXRXUm9RMHZJc1dkRndxNjdPSnd1ZmVYWlJyT1k5Zm9OOGdVTWkrTExhR1Jm?=
 =?utf-8?B?V3pGZXByYVRpeDZWVjNJVWtiMFoxT3JaQ0lNc0cvRFRiVWsvZmlLWTI5VlJv?=
 =?utf-8?B?NFlPbXJWNDdnU1B6WHdNZHJ0MVBOOGZFb1VmN1o5U0d1YUdmdkMxQ1pHZWl4?=
 =?utf-8?B?cW1RUnc5eFNsT0hzUUQvbkJleUtUQ21zdS9tTmhORzNSVTVqQ05ISVY1RlM0?=
 =?utf-8?B?MWhZcjdESFM1Z2p1cVhqd3ZiQjdteVdGd3E1bWlSaUJvRFlaekZrd2ZiVHgv?=
 =?utf-8?B?VjduZTJSUnVZNUZmZVNmaEVUMGVOTHpFNVpHL0xNTFlYYnVSb3JjWVFuUU9X?=
 =?utf-8?B?Vmt0Z0FGUUdza3ExV2EvS003cTlNbVNVYlJObU5QMExLY1lZdEkxLzlPbE9D?=
 =?utf-8?B?cndJZ2p4MS9xZzJwKzJqeEhZZDRUbkNmazQ5OTNqcXBzS3k1MTFiZ1NIOWFR?=
 =?utf-8?B?WVc5MUtsVlU5L2ZwQ3ZyWkxCMDJYcDZHbTNmbGM2dTdGaC9MY25EYUVITjdk?=
 =?utf-8?B?aEtDeUcwN0JEa2ZNZ21MWG52b3dSb2VOUjlXYTV5dU9pTmFuMHdDdVFBYllm?=
 =?utf-8?B?R3ZxRWhRVUFkR043QU5NalZncER6SEdBcFJlWEZOZWxONmNJdmxWMkk4L3M5?=
 =?utf-8?B?b0JsdWUvemxLMHB3bW1vZi8wN2NWbXk2a3Bvdy9oSGh0VWczYXppVTFQV3U1?=
 =?utf-8?B?WTgzSjBRSXA3OGZyTDc5d2N0YlVNVjc1WGhWL2FCYVowSHFDTzJkRFViaG0r?=
 =?utf-8?B?RjZNckQrSWdoY1BpZmY4MWFDK1ZKT2FuR01xaVQ4UXZOcFBmTVduSXQ0eVh0?=
 =?utf-8?B?RStVQmtySHFPRkZmTVA0bkdYNHpSRjJxdDMxWDdhVlEzWGZpM2ZRTWJxVUo1?=
 =?utf-8?B?ZGUvVmF4WFFaMzZmSDB3R3Y5TVFGM1psYVdjaFVkUjA5Z0YxcE5BREg2R1ZZ?=
 =?utf-8?B?QkYya29FSWpMVXA5RmptWDZGdmZDUDFFekZtcjU2T1IvMXU5c09rQmM0Z1Ny?=
 =?utf-8?B?Qk4zSnRaeVBURXZLZzE1NitJblBGaGdabDBQbU5XNzJiTlI2WTR6QVlVdzVi?=
 =?utf-8?Q?sHQ3znW7QslglsHJidz1j5gwj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e57fd04-3367-4399-30fa-08de20510cb1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 12:02:41.4028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2ydvuS7FF9GhAHpfykx0m0hpjsMexGocknF2eBfIjnufzsKVf10kkOfAnlUh68K8+VRTTzo6hLQFmsUle4Mtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004


On 10/7/25 14:52, Jonathan Cameron wrote:
> On Mon, 6 Oct 2025 11:01:21 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space.
>>
>> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
>> that tries to allocate the DPA memory the driver requires to operate.The
>> memory requested should not be bigger than the max available HPA obtained
>> previously with cxl_get_hpa_freespace().
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> A few minor things inline.  Depending on how much this changed
> from the 'Based on' it might be appropriate to keep a SoB / author
> set to Dan, but I'll let him request that if he feels appropriate
> (or you can make that decision if Dan is busy).
>
> A few things inline.  All trivial
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>>   int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>   		     enum cxl_partition_mode mode)
>> @@ -613,6 +622,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>   	return 0;
>>   }
>>   
>> +static int find_free_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	return cxled->cxld.id == (port->hdm_end + 1);
>> +}
>> +
>> +static struct cxl_endpoint_decoder *
>> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct device *dev;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +	dev = device_find_child(&endpoint->dev, NULL,
>> +				find_free_decoder);
>> +	if (dev)
>> +		return to_cxl_endpoint_decoder(dev);
>> +
>> +	return NULL;
> Trivial but I'd prefer to see the 'error' like thing out of line
>
> 	if (!dev)
> 		return NULL;
>
> 	return to_cxl_endpoint_decoder(dev);


It makes sense. I'll do so.

Thanks!


>> +}
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @mode: CXL partition mode (ram vs pmem)
>> + * @alloc: dpa size required
>> + *
>> + * Returns a pointer to a 'struct cxl_endpoint_decoder' on success or
>> + * an errno encoded pointer on failure.
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. The expectation is that @alloc is a driver known
>> + * value based on the device capacity but which could not be fully
>> + * available due to HPA constraints.
>> + *
>> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc)
>> +{
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(alloc, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
>> +		cxl_find_free_decoder(cxlmd);
>> +
>> +	if (!cxled)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	rc = cxl_dpa_set_part(cxled, mode);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	return no_free_ptr(cxled);
> return_ptr() (it's exactly the same implementation).
>
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");

