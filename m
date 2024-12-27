Return-Path: <netdev+bounces-154342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0323A9FD1F3
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 09:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09C2C7A1207
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D1C153808;
	Fri, 27 Dec 2024 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e/MKsVds"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798576F2F2;
	Fri, 27 Dec 2024 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735288099; cv=fail; b=WMLSD+h3+0304n84gdLovAKiwo16E9e1/qDzNz/vqi8q2zXUT4tXHZa6qN7eYr20OYTfQ1k5HrDYn65ZJM9hQwH6Z/6o14QgQYQ9TIeOAs0PeFgecNC+7ztcyHgmioA0EbKqmvL1A6Zr23s8i3e9pDQKlt94ISCCL9K9ThArlO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735288099; c=relaxed/simple;
	bh=6mAeZeE9CWUivxnk6MWYpoi/CEyPyB6czM2ZT3n4DeQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g73/LZU2YgFKSImef41FwrWFzgMtr8Hr/izXjMtOFhCzplhkRtxspHYH5vsjQsirYgXcvImAdHv8XvaTheVv9WTjnVcN6YN4UEkl9gv1mLBvTqWB1n8nApGOtVEJ4/2ul2u30GvJ0b/GbwK2v29cU3wmYVTnc+qAOAyuVpCSfhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e/MKsVds; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQ/K+JaCwtbBO3mr2ACzJf7N4/oZEPfoBo5DS5XkW7RPffpatZhCZnhMXSlKJKpd2GbxS8D/OWpjVbMzaMiPu8idCOVEQ74L7AsFt0GWU2hnLmETUHMrFU64/RP5VlAhjboN/8FPiyjTPwX9xB/7SNj+eCrFiQI3jLyNgNV3G5Qnw1MGwbJAwxIo/AlwtZsMOP2KdJdo1LWN/tbu+AToH0WRcQ9yU2lnjTJoWmKzmdYfT0vc2bogvIgPuZXF1ii3LJI6ytJ6iA+7Wwjj2zZGVyIdf8mkwWfhpSgxf2pGD3D/XowfzZ1ufVl113GlhM0KgGvtwERInP3D1U/U51VyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWuWbcXxE4hmh9Jht2i+3MHtcsrIa1bm9/TA5cnlumw=;
 b=yyleRJFcG1YK5ndhBnjJRXFHlREM5p1KRVf7oIg473uqTHBNJh2ISO08hg+Xq3gIKP8Letja8KZjk5xiSyXL7EiowIdnV/KwOfTNc8DcD4DetR2bjwiyPZ5PqLl1w9u8I7RN5CEFnhWoEd7idRgvRXq212CY1V4SopRaQOzlfaMvwpsSwsZvwXjzaiKDsvqMDrhhHQ43TcXv8puU6/hq42xNRMFmhbq/eX+pRnc6wayQnYGSmhAVz4d5NY5z+T/3Qke/7sFJey00+cKpi7ZFjdrsYN0FLOrDUCVc1/CfaMOpoVXlK07oiAPtYXGPyi09QfjNddmJfoNta2ywV+7PuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWuWbcXxE4hmh9Jht2i+3MHtcsrIa1bm9/TA5cnlumw=;
 b=e/MKsVdsGkddEEOrA+g5T5CkLCqqEDrVBbrkd7YNzA8tP3jC8fdfhRvgr10Pr9kuCg/Vy5ttVWhwSNsuZzXq0XQlAkQbTx6Rx9SzLYnGaUfpg97fOMRLjBNf82cKig5I1eliP9MtJRKN9T31Z+xK/FWm3cdwgZnmQgfOVC+vC0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Fri, 27 Dec
 2024 08:28:11 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 08:28:11 +0000
Message-ID: <ca3159ce-6063-f10d-a445-1ffaf6560435@amd.com>
Date: Fri, 27 Dec 2024 08:28:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 13/27] cxl: prepare memdev creation for type2
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-14-alejandro.lucero-palau@amd.com>
 <20241224173245.000028aa@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224173245.000028aa@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c697f0-8d85-41a0-4d63-08dd26506605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFB0U2crT3dRTzlLTlBGUlZDQWlnY2R2YnBwc0xlRzdUMnQyWGFNZ0RodFUw?=
 =?utf-8?B?Tnh4R0lYaENESU5qQVhQYklxaUc4Yk1tK0RrcnRlQm50VEpvaHFrcHhrVkl1?=
 =?utf-8?B?aE1HNE8weEE5ZVBLYTFQeDg5dWtkZnozWHl6Ym4zRm5jN21DRCtpMElibXha?=
 =?utf-8?B?a1N0K2ozMS9qU2dTTXgxUk9JQU1yWTVrVG1CK2Q1VDhGNmdidmxOdjN4cG0x?=
 =?utf-8?B?UE5VKzFsRmlGSnJHaWxqRzZRQmhlUGR0blZDajY5dDdMUndHWkEwelNicDV6?=
 =?utf-8?B?dWg1WmFrRTBmSlBTTTk0dU5LU3l5bXUwajg4TFE2Z2xoZVF2ZWN3RU56dXlo?=
 =?utf-8?B?S3FtbzlEQzEzVG5WNzQzMStiTWkwMUlPSmFQZHJxdHQ3VUVLRjYvMXJQd3Fi?=
 =?utf-8?B?RUZnM05Ea3lhbEJla1pwQTJjbW5PZTJTdHpCeWZEYU9xb0NCazFRS09mWEx1?=
 =?utf-8?B?bmZKdk5teU1udXJGMDFIZFJoQzkyWkNGams3OGpmVW9XMUFKdm53dXZkSmtS?=
 =?utf-8?B?V0hwcVBJelhnS0VVZVpkRHVLS3R4MUtZOGRVNnZEeE9WQmE3dHEvNVB4RVFa?=
 =?utf-8?B?NmZvQmwzN3RDYStmdk1rTHo3RTFHWDVxN3R0ZmtzZ21FRUhmdUdxK01VSTB3?=
 =?utf-8?B?YmJ6eXZIaS9wZEtKT2JjaG5iM0ZTK2J1a0RBVU9GT1B6d2VYTmFIeVlrbVR1?=
 =?utf-8?B?ZlA4N3hqMGNRMnRoa2x6VXUwZWN1WktqclUxZG0rSzMzVENDL2VkRnVnYy9G?=
 =?utf-8?B?Q2s5RXF5MHhqeERDblpNSGZCdGptdExTTjhEdmR6d20zRGErendsUTU3cCs2?=
 =?utf-8?B?TmMwSk5xdnlGVmVyaStMT0NZdjM5anhrKy9Vek5ITVZkS1ZSeGgxWmtZdjk5?=
 =?utf-8?B?aUVwdU4wUStUdVJNRjF6c21NM3ZaUnp5UFU3anpqQU92Z0ZjZzlJY2ZXT25F?=
 =?utf-8?B?dnpZQ1FjOCtaTVR6c085aEVNc2FTY29pNDAydEplcC9ZVlZmb0Q0bFlmaEZS?=
 =?utf-8?B?QzI4MzFDaWJxaGNDRmtuTjVGUWo4MTdVbDZoNDdrVTRuMDlaeGZ4VWZ3c1NP?=
 =?utf-8?B?Z3FRdUp4UkhnM3ZBU0lZeG5pN3dReWxSQjdWOTUzeWFHdERxZ1JieTVlbXN5?=
 =?utf-8?B?Vis1NG12Zlg3S3p3N0ZjOXFTMXFReU5YZ1N2K0QrTjNiTWRQeStqVkNWZUtx?=
 =?utf-8?B?NEtZL1Btbjdkcms1QlhpQjdWNC9VWEpWQjY4QVYyWmpZQnl5bmE1QmVMYjd2?=
 =?utf-8?B?a3hqV1ZJSU1WRmtsbGJrbGJmZytoTFAxVGVQUTlDTWV5a1lNOVdYd0dTekN3?=
 =?utf-8?B?N1BydXN3ZkQwVjFxU3hpZkpCMDBBSFZqUGRvMkxhcjcrditWTUtBTFRPWHlG?=
 =?utf-8?B?dUlRVVhsalhtRmJXNll3RTRWcVhkMEw4TEtEV1g0eTRyRlN6THhuNWsyYXYz?=
 =?utf-8?B?OHNUckF3QVVzYkdVclVKT2MySlM2NHlhNzhIVzV4cWQzQzhJTFRhRDlxQ0Qr?=
 =?utf-8?B?MVBNS2pzWGRETXRFMG9tNXZmdklCRmQ3eXJiMEZDazhkYjNOTW5mNHk3SVNj?=
 =?utf-8?B?NXY2akN4NW1DV3FkUlRTTTRCQm1xZ2liOStxYzlZaHVMd2MzeWI0dlRhNDFt?=
 =?utf-8?B?aElUVWcwWG9tY0VGMUZKRjBLM1RETURHUllBaXNad1Z5M2RNKzRhd0VSYWp0?=
 =?utf-8?B?UTBUNTBoenNkZ0VBYmFBcnBSQmxVZXFoSFFHWmVOcHBqM2duSTRGWTJsZzFC?=
 =?utf-8?B?T1kybFBRb3h3MDl1YUtuNW9BYnRTQm8yK0F0NU9WWlVIeFZZYW1vZUE3NCtG?=
 =?utf-8?B?elo3Mmw0Q29tUDJpdmxSTnJsV1ZhMW5RRTVtVXVPM3dNYVdybU1sRXNleGRm?=
 =?utf-8?Q?E9G4wUhyx6diD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0o5dWtjeHorZzhIYVpvUzhkR3dIMFl6TW51a0czK1hrQlZPOHg4cHIvOWZR?=
 =?utf-8?B?ZklxV0RUUEI3eEY3anNDaFg5QURseWJKZDFEZWJFUnIzdmwzK2l1ZXJzNk1J?=
 =?utf-8?B?aTR6dldEaHdTZjBoQ05TdUVUYWZscVZuVVFCUnBUbDdUNnRySytZaS93NXFx?=
 =?utf-8?B?b0Q4MHRTc2NjTzBZUUpCK2xNa0hhM0RUL1ptYitXK1d1em93YUpjODl5QlRM?=
 =?utf-8?B?SkxDNDhOYjFaK013UkdVRisxV3FBT0Zrek1ZaENsbUpVVmR5YVdKcTZOelcz?=
 =?utf-8?B?REpmN29tZStmdFF0TDJ5MjNMSjlKUzJ1Mmt2UTB2VGdOUmxGWmJDdGQvcFBK?=
 =?utf-8?B?bnJPMEhNMDVnbHlPMEpBQzZXWDBxU1ZNZDhpdERUWVI3WFJpTFZ0TmV4cEd0?=
 =?utf-8?B?WFVtVUxpN1M3L1V6Z2FtTTdDVWRIWVExZk5iTWZmbERuRVo5UE9tamZkVENU?=
 =?utf-8?B?WVRiY0VYUnhsc3JPNW5pdzNYOVplMjE2cWVHVWE4QU1QYjNvVXpzRWMvaTMr?=
 =?utf-8?B?NDNQd3BXbC9OVTFHQXlrdzJ2cEQ0TW51T3QvcE15eDNGek96Z1FtRWRZUE03?=
 =?utf-8?B?dnprWFVxT1FXSmpUcFRuOUdlSkhkdDYvM1JDYktXcThsSVRjRW5nOEJzbmsz?=
 =?utf-8?B?aW1OcXFBaC9SbFFNa285RzlaeFZHZmdadGMvZTBHQytMYmdQWnVGQVBrSUNY?=
 =?utf-8?B?ZHpZbDVCRmtOTjE2cEpmMUt2M3NiYUI5MTUwVlRNUk9JY2VjNGwwOW9oSno5?=
 =?utf-8?B?NkZyVUJEK1FLencwcDVhSDBNaHYxSXEreGViY09wT2h0ak5zRzQxN3MvUG1o?=
 =?utf-8?B?QWVoemNiREt4YnNjWjJDdWlMelo4ZUpGUUVUQlpoNkNSNytrM1lOZWFCQVN4?=
 =?utf-8?B?ZkwvLzZIckMybjNMZjF6bitQS3BkM05aWWFyZERRRmpqaEt5aEJicmlxd3Ay?=
 =?utf-8?B?S0RmcFVJTDVtYnExUHY0Sm55US9MUG1ndDlkM1ZPcTdERVp0b1lDNXlSbW1z?=
 =?utf-8?B?RHFGcGNmUWtsdTUrMjFoa0JoYkJoNWNUKzJzcGVsbENISitCRGJYNWh0MSs0?=
 =?utf-8?B?MHZTZXYzSENCdllvOFRHeGZab2RzN25SelFuTlJOakpZdzlMZitLZ1hidWt4?=
 =?utf-8?B?TVhEcndUTEJpL2NRek9scUhkR0RjeFN3RDFwbmdSK3BrUXBNak13ZnBYeDNN?=
 =?utf-8?B?dS9sSXBwRWUrdFVEVVhUeTA4WjBOQVJjajU0WmV1SjNJbXVkcFo5TjVSdnoz?=
 =?utf-8?B?RTdGNTRPbThLL3JCTmxJTTRtL25tODJkS3hQbUJhMm9nWDZxelEvcm1ZT1lT?=
 =?utf-8?B?NlZLbGoxVFp6bEF1K2dGeWIvWnVIQlNzSmpiWjRCbjM5aEJwRDdYaHd6d1N0?=
 =?utf-8?B?Qk1lU3FVNks4cVBnWGNLMk5iZFovZGJhdTY1d1o4NGhmTmk4Q2dVbGYwa1Uz?=
 =?utf-8?B?ZGtTZDh2UENucmVKZ0YxWDVnUUk1dnhEUCtzbXVIdUk0emRyVEw1blNiZnZ6?=
 =?utf-8?B?cnJ2b285RFprUGFlb2E3eWdYK1FQYUlWUkttV3hlcVpkR0NGMElBWUF3MTZM?=
 =?utf-8?B?L0JHRmhZN3BKWUh4ZlIwbGdQTWIrTkQ0cWsxbmlnT2piMWVMM0JPbGQybExF?=
 =?utf-8?B?bFU4R1ZpMThuQldUdUJnR3BJNFhMMElGeFo1dFV4RHlaOEQzbHJFcU1WN2N4?=
 =?utf-8?B?SllTT2xnTXhjTGlCTGRLUFRpSURuVmJJQlFUTFl4L0pvTjF3NTBtS2VPYTE4?=
 =?utf-8?B?dDlPTEFkZnc2dzFUNStMTDJwSkhyUUxpaTd3aTIyekdpTlRCeEEycHdlbllK?=
 =?utf-8?B?eHc2dDdwaEtZMXBkd21HRlF6bGxkSUl4cXd2aWlyald3NUxVVzFwdWJpTjVO?=
 =?utf-8?B?SkgreFR0aXBrUWp4azdDWkpoNnoxcGZjaEdHRzh6ZDBMdy9DUGcvSmJ2dzRq?=
 =?utf-8?B?WlFUcG5NVXdMc2pFOThSTWR4UkpJS3lDa3Z6VmM4Zi9TRkE1VzB0ci8yL2s4?=
 =?utf-8?B?OExOcW13c2xzbDNRandnQndFMldwQWdkWS9tRVFDajJZRXp4UHlaUVFCVldv?=
 =?utf-8?B?LzljNmhsSmZSdjlxbUNpcFVKdWVKMkJsa0ZFZTdzcThFR3hHVXZjbTF6ZU44?=
 =?utf-8?Q?P+g19hEoVAhULmecRW5ZOO9Te?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c697f0-8d85-41a0-4d63-08dd26506605
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 08:28:11.0479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sebdOJ6MWf5La6b+sweie7IWpcfqSRbN+jnl2UVesFDJCHEq211qK5y5poo/XWelKOC78ugh/2XMQK+gc5eAQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065


On 12/24/24 17:32, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:28 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
>> managed by a specific vendor driver and does not need same sysfs files
>> since not userspace intervention is expected.
>>
>> Create a new cxl_mem device type with no attributes for Type2.
>>
>> Avoid debugfs files relying on existence of cxl_memdev_state.
>>
>> Make devm_cxl_add_memdev accesible from a accel driver.
> You've added it to a header, but not removed it from a different
> one. That is generally a bad plan.


That's true. I'll remove it from cxlmem.h


>
> I'm curious on the poison part.  Does your device support the command?
> If so we probably want to think about what is needed to enable that long term.
>
> Jonathan
>

Our device has not a mailbox ...


But you are right. The problem is the structs which, I think, requires a 
refactoring.


This patch is the fastpath for initial type2 support. I hope with new 
clients, and likely with the qemu patch from Zhi for type2, the 
refactoring can be properly done with more exposure to type2 cases.



>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/cdat.c   |  3 +++
>>   drivers/cxl/core/memdev.c | 14 ++++++++++++--
>>   drivers/cxl/core/region.c |  3 ++-
>>   drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>>   include/cxl/cxl.h         |  2 ++
>>   5 files changed, 38 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 8153f8d83a16..c57bc83e79ee 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   	struct cxl_dpa_perf *perf;
>>   
>> +	if (!mds)
>> +		return ERR_PTR(-EINVAL);
>> +
>>   	switch (mode) {
>>   	case CXL_DECODER_RAM:
>>   		perf = &mds->ram_perf;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 82c354b1375e..4d24305624e0 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -547,9 +547,16 @@ static const struct device_type cxl_memdev_type = {
>>   	.groups = cxl_memdev_attribute_groups,
>>   };
>>   
>> +static const struct device_type cxl_accel_memdev_type = {
>> +	.name = "cxl_accel_memdev",
>> +	.release = cxl_memdev_release,
>> +	.devnode = cxl_memdev_devnode,
>> +};
>> +
>>   bool is_cxl_memdev(const struct device *dev)
>>   {
>> -	return dev->type == &cxl_memdev_type;
>> +	return (dev->type == &cxl_memdev_type ||
>> +		dev->type == &cxl_accel_memdev_type);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>>   
>> @@ -660,7 +667,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   	dev->parent = cxlds->dev;
>>   	dev->bus = &cxl_bus_type;
>>   	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>> -	dev->type = &cxl_memdev_type;
>> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
>> +		dev->type = &cxl_accel_memdev_type;
>> +	else
>> +		dev->type = &cxl_memdev_type;
>>   	device_set_pm_not_required(dev);
>>   	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>   
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index d77899650798..967132b49832 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>   		return -EINVAL;
>>   	}
>>   
>> -	cxl_region_perf_data_calculate(cxlr, cxled);
>> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
>> +		cxl_region_perf_data_calculate(cxlr, cxled);
>>   
>>   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>   		int i;
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 2f03a4d5606e..93106a43990b 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>>   
>> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_inject_fops);
>> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_clear_fops);
>> +	/*
>> +	 * Avoid poison debugfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (mds) {
>> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_inject_fops);
>> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_clear_fops);
>> +	}
>>   
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	/*
>> +	 * Avoid poison sysfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (!mds)
>> +		return 0;
>> +
>>   	if (a == &dev_attr_trigger_poison_list.attr)
>>   		if (!test_bit(CXL_POISON_ENABLED_LIST,
>>   			      mds->poison.enabled_cmds))
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 473128fdfb22..26d7735b5f31 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -45,4 +45,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> +				       struct cxl_dev_state *cxlds);
>>   #endif

