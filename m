Return-Path: <netdev+bounces-225898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2995EB98F31
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F4A188CF10
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED16E28AAEE;
	Wed, 24 Sep 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j9fQM0r0"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0A283FF8;
	Wed, 24 Sep 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703450; cv=fail; b=K6Pgql/PwVAxl+ey0PWis6cjAe2S8d7VEncRW4jT/8nWvgODiDGw8ScsyE3RaTelakGHmaNCs0n/fl0Si8d7t9wIxS6LoipjfYnZ93lOFWPQZ4S/qRw1FnixDDCZk6e6O2FreLxY13Of9CovhVUcA4P86241IwEbgxmOCkTclVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703450; c=relaxed/simple;
	bh=V12kM940QkfQf79Y0SCYCy3xivUIST2Lugiy7dq2MBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dJV/AmMXMkwN+VR+Zuxoa1bzdm1WNpRBIX9MV7h1m6cbvtzkPGOApkrSlUn0ZJKwJ+8uAyaNItI+BtY+TUNGHWvhv7RSern6fvDIrxkKuECcddKmSn9Jzl7l4VBM3lYBlzOvaj/AwCCEsdLP+c1t1njynPeiSyLPDYS0q10nEOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j9fQM0r0; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT+XHhhT6hc5CNS4Fe+c6ZIt2bv5XQHjAMht6/KtepazYAluG4FPAEhC95sokwggttb4NE/TscqCkwtlAFAC8QgXKQ+qbtuhdvvNDVzB/8EWU+IkzTJimmFuuEmSm9MxHZ0v+GoKMYDTaILg6UEjynf8P8iZEaNtXro3QDPDyyjbpq9YhRgYmQOox1fYyz+90Ce8jQVsnSjPBPq8Z3MDRFe20jcdPIIB2cdCVWKi3MD/v5q9FNQLFJFHWSE7Kio79pVkPiJr15MBoz6PYT2J/R+CCM51fwcKXj9ylCO91I8OFflSjsHxg9NpwzkHE0Y0yBR7+27hscWwN6+6aVypZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTwaDiht0Y9vcFFln4u0DTldK2xPqhN72uZrcjxl5gU=;
 b=cMjjJgXnas7aB3tGM8CDqmy5Y6/EjxoWtW7HtbYTqi/8JquiNwSOBM/J0ZhlD03QDnyLpasTCFjgBIyNfHpI9oJirQa/mnCqFR2cxH2AgsNLJUTIxkinz1GyDxGz7PHbpptb0hOhKo4856zcVidgQKxL8H8WSHnOwb3lNW4naukZNO7FkeDZK1s0OfjdfRJc3hsd5yBYqqShgNzlZepk4/hhcAFMxKEGbSP9VnCpxEg+YbG1XSZu2IfpEow3XRAJDXL9dvR+UZtCRnu6z+XYfToQj9ilPFIPIsoCIddQl1OgKGG+gfQqx9sgHsjBgzExDEFdClp2VusZ2DXszPvIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTwaDiht0Y9vcFFln4u0DTldK2xPqhN72uZrcjxl5gU=;
 b=j9fQM0r0rpBsEDOqg2lquzMv3r1HXQ2bybUqHgf5Qvk2b3IacrFb6iOKhc0wzweFrzwqzWOaadHm4naV9Pww+hwJB/RdQArz5SEYmFkYmZ5vLru4nmc4vvQJyCZ6D2mM6vRL6w4zrmVYK2UwJxxUgyEVAcZmyO0NYB65w41RCmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 08:44:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 08:44:05 +0000
Message-ID: <bfcc6933-2106-4332-ba6b-fca8d7a32561@amd.com>
Date: Wed, 24 Sep 2025 09:44:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 06/20] cxl: Prepare memdev creation for type2
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-7-alejandro.lucero-palau@amd.com>
 <acab1594-f376-425a-a82d-51df2e6bda69@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <acab1594-f376-425a-a82d-51df2e6bda69@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: db7466aa-6a21-455a-2921-08ddfb4684a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXlNUXR1K0c3bWlxellrakYvWWkxVG91NmRKK2dlVEF5dmNleWtNaVJsUW03?=
 =?utf-8?B?ZE9BUFUwakJ1L1lCL0k0U3RoSTgwT1hpQ1lMWjlNVGkwTnhwRmpxNjllREZs?=
 =?utf-8?B?QzgyOFZwZ3JJK2gxK0ZuYXR1VkNKVVgvdlJ1SEkvZVorWHBLSFFRN0ZaK3po?=
 =?utf-8?B?Zkp0Z2lZbDgrNEV4dXpka0ZPZnEyRDJZYWREbkwzQWZnQUlVeUFpeXRKUzVt?=
 =?utf-8?B?Y0d5b2xSUU80ZmtmV1o5SldrSmhqVHVoR2FuWlVDaGc1dzNqRVdXc3l6ZmRt?=
 =?utf-8?B?UWZCVFFvZ0ZPTGJqb2xhd3djaHJqaWRVTytZLysyZW9hdFZxZGQ5RkZ4MThu?=
 =?utf-8?B?RWtrdW51MDZYeVVETHp3ZkIya2RhVUM5L1VlMlNvRXNkUVh3MGN2K2ZKR2dp?=
 =?utf-8?B?TWdDdVRyUmVMK0ZwRnVFRU5SN3pYNENVcXFGWnorcU1oa1ZSZ3lFVDZ1K2Zp?=
 =?utf-8?B?ZnRQRHQ3Y0NMSDU4cU9TcmN4M2xGdXJraTdsZzQxaEpuUms2L01rdld2OXk4?=
 =?utf-8?B?UGF5MHNINTRYNVh2eXg0cEM3RDZ3R2szTCt3V2t6VUczdkRXRnp2c2liVDRD?=
 =?utf-8?B?RHZ4dkhUTmJGa0p3WHRtM0dscXBRV2kzKytUU2pmYVhPMS9od2trcU1XZVdo?=
 =?utf-8?B?a1BReHZkdDA1c25WNTBsZDd0TDhTQjNwVGY4RmZ1TzhKWTBzQXZKTUcvdURX?=
 =?utf-8?B?WW1Pd21FRyswSVU2aGtZQWlrVWFLNlhvVEJVKzZnVEdRdXM1R3NqY1QvNUNz?=
 =?utf-8?B?UU1qMkFaVG1scURTNk5pZ1R5YTNXOWVCdHVzR0pUN2dVTW9iMWJuTXcrQWl5?=
 =?utf-8?B?QkxGMUVQZlpFdnRvSUlIUlpUeFU2Szlua0pSK2UxRDlTT0ZxYnMzTEZwVC9v?=
 =?utf-8?B?VFNvRUFDSVgzWHZZVmh2S3RqUTBFOVV0VUJWaU9jZzYzbGZoUks0RnkvVDZB?=
 =?utf-8?B?R1J5Y3hUTENuaUpLbmx6dk1CeENwUjlXd0VWK1kvU0tGRU16anlHakJCTXpm?=
 =?utf-8?B?TkRoc3RTR2tNRWh3OVZ0Nm13akxDUkFRLzlWaGlGUkREMW5kK2kySFd5aURs?=
 =?utf-8?B?SE1ySytPay9JcnF2ZnRkRFBRRU1CanRPVldEanJoZThrK2lUYW9SQjhBOTI2?=
 =?utf-8?B?aVZnb3pLRURQdmFCRTQrQTFMTGRaWXFJaTdreWhveUtWaEdSMHFvVHFiOTdh?=
 =?utf-8?B?L1hhUFRSS2treEJEOUFRYVF5elRDMUcxNUN3dHJJbTZtSWtCUVZ0M2RqSDcx?=
 =?utf-8?B?c3ExbU5YZE1naFAwYnJvVk9iOGgrT2Y4a1JhYnMvaHZTWEZLTkxGMERPYkRm?=
 =?utf-8?B?RS8xV3NZT2pRWit6Y1BrcFQvdi9wdC84SmxhUkhLV3N0Umh4N2g0dlZJeWZG?=
 =?utf-8?B?K3IvV2ZXaXhZR29pU2FHLzZGTkNYSVp2NEFDV2NnQmNLNVIyY293NzVwTGlY?=
 =?utf-8?B?OWZlRVlDZnh2UjB6SXdqRUVyNm5KMUhTOTd6NFBIV2RtYnJrcjZrdTBUcy9h?=
 =?utf-8?B?OUt3VlJxMGR6WE5RSW1lWlZsVytWNys2c0RmWGFKMDhXelFlT2Z5RThzOVh4?=
 =?utf-8?B?QWJva1k0eFNOUnRQWUJnU3JEc2UrSk9oeXN2R1B3SFc1UEV4dVVGSWN1NUVW?=
 =?utf-8?B?OWUvYjZIS1gvTmliYmhEcHpTcW1GK0dmUEVqZGFlVC9tUlBoNUo3WkRIM3ZG?=
 =?utf-8?B?M2FPa1JINzFRK1c5THVoTDVUOVR2eXpiZkxnMnV0TW1MTXQ4K1I2blQ3TEtQ?=
 =?utf-8?B?VDI1akw2NzluOTVWREl5eEVNN1R2cnJoRFFDZmdVeEw3dWNQanpiZmhKRHB3?=
 =?utf-8?B?ajNZZldnUmlWeHgxRmVYZWpSQVhhNlVrTW5wdkczSEc3L1ErZ2U0bXQ4UDUz?=
 =?utf-8?B?dStsNzVDSXJTT1VZSGUwZE5wMzFoR1FPSEFoQVpsdkJWRzF5U0doUmhIWG10?=
 =?utf-8?Q?NLNGPA0npUI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEEyK2d4RVdPTjF1OSt6YmZkZ2hON2YvQ0FCMWcxbTN1ajR5N3NySHp0OXpO?=
 =?utf-8?B?c3VUMWhLMis2WW9Bc2lqNjB6SmJOd3k5TEkwbnBaWHVZZ0paRzk1V0JNZXgw?=
 =?utf-8?B?dnExd0duMmgvdG4wZGJBZEZlZVN4cmJsWXJBVEVwTGJJTWRYWEhSMHR1WTZT?=
 =?utf-8?B?bmxEMFBtdk5McGp5SS9mY2lEenhWQjFpM1Z1ZU8vU3BIZWVnUXY5a214RElD?=
 =?utf-8?B?dXlaaVJaalBySk1odDlrQWxTMjA3ak9KTTRDUklUallndFZ5WWJ5bW13ZkZR?=
 =?utf-8?B?QU9NVHlZVU1tZUZQSkNWeWxUbkFlUTZGTVdZdmxienl0L0JaemJuNmFPcWhM?=
 =?utf-8?B?dE4xSHJvaUhrM0lBMVFlaG1zNmpVNm5RWTFjcDZRei9UOUxsM2JQTm1DRzIr?=
 =?utf-8?B?ajN0RzgxWEJxWGp6NnhRSk1uRGhMYlBjcS9KaElwenBlV01hZEZMS0R2d1R5?=
 =?utf-8?B?MStMUnBqUmxlNElscDlvaDlSS0VaTkFqUnVaQno5VFdIVE1KdFdMcVQ4LzJJ?=
 =?utf-8?B?MXQ3MXFWRERPdit5ZkJyNURPVkR6WXhkVmh6blpadEcvMUs3OWtvTkJDSTJq?=
 =?utf-8?B?WGpUOVovNVQ0VTAyOFhOMUZVTkZHbzlVT3VOcVZJZXQvUGJHSE5uTnFBUyt1?=
 =?utf-8?B?RUlCY0dLU1lsSXZJTU0vL1hONHUxV0VncTNpZHpBT0NEeHVJaWhWMGhnUHdj?=
 =?utf-8?B?cUxvaUdxUDBncENHR2FTOFd1dXVuaDJYQ1pPbW1rbzVTaTB3KzZpRGViWFZu?=
 =?utf-8?B?a3lxTUtKL1ZWVFRxSkFCMUdPZHJ2VFlpWk9hSVJsZXdNdUhLS1B0NUVDak9K?=
 =?utf-8?B?L0JZZmVuNXUwRHA4TWZBRUxmcUJHVGg4YVRreUEwdFFjb2Z0eGNtUkk3YXlY?=
 =?utf-8?B?a3lzZDlCNGlub0NwNVIyWCtXbGhmdC9OSkZpdld4S3l2VzkvZ3RkZmx0M25o?=
 =?utf-8?B?ZVNrejhCQ3hHTWlnbG9WY2I3dTZobFpPOWlMODROVjJzL3dsMnU1YzN4Vndw?=
 =?utf-8?B?SEF5SjYweFFlbEpCNHFwUXVKMVlTemRqUlpZeVJZczA2UVNFRHlMNS80dmQ0?=
 =?utf-8?B?RTAwRm5TQm0wV0lqLzgzRXRtY1ZPM2JBRlhBVTJSQi83bFdHU3BEVFhoUUhC?=
 =?utf-8?B?ZTN2c2hGTTgvOTI5YS9QK3N3ZlkyZFZSVFZoWjE5U2VoeVBTNzA1NVZ6M3Zp?=
 =?utf-8?B?eUw3ZS9lcXdPRlVlVXRrT1YwVTNzMG9JYTF0WWxSaDU4cGI4SWRFKzF2a3Y3?=
 =?utf-8?B?dnVETElFbzNGUUxuR0dDMFdlOWg4UjNoWXdZM1Q1M0EyTS9SMjVGbjhMbm5v?=
 =?utf-8?B?RDVxTjZxNGk2N29SNFl2bHpoY1QvNEVnTWJTUUxTT1NIcjlndlZoU2ZvaVVS?=
 =?utf-8?B?K3N4VlF4NmxzbVhseFFaZlcyd2VScTYxbzZmTXZxdmY5K2hBa3RRcXcvWlVH?=
 =?utf-8?B?UDY3YXNxWlNaUVovNHhQZmF4NkwwTFFTTjBob1RHZlBUczQxOXh1MUhpckk3?=
 =?utf-8?B?QnZ5VHJFdWlRTFRsa2NrdEQ0NWpCLzRwd0d3aWg0RktraUlLU2pmampvcCtB?=
 =?utf-8?B?T3VZYzcyYXNnbkhQbWdENENFYitLUDBpZHBkaXdsWU94Z2VENHlvZW5NN1Uv?=
 =?utf-8?B?UEpPR1FDd2JYVkZBbWxteldTd1RLM3IxUTFuRFMvbGhWUzQ2bU1DV2w1V1Z1?=
 =?utf-8?B?T0x0Yk1wQjYxc2JWNUd3YVYxeEV0M2ZRc2FSYVRnczI4cDdmblI3aVVmeisz?=
 =?utf-8?B?L3VBdEE2NDdrb1NMMzE4aVhaVzVvMG8xV3M4Q0xHOFcwcFNoYzhydFhnam9K?=
 =?utf-8?B?R2luVVFZdHpBMno0cXM0b1hSK0lBM2hKYml6U1hFY2JQNkNYMjlZTGVDUjhq?=
 =?utf-8?B?OSs1OGc5YnNGeG5TMkF2ZmFvbjZYQWpDMzZJMkc2YjIvNjFsMHViMFVrOCtM?=
 =?utf-8?B?K3pxNVRFSUtUdGdQSGhpYUE1cUFTRy9pVU9ISWZ0bzBOYzBaQ2V6aStzcUlr?=
 =?utf-8?B?RVQvUSs0eWVTSVdQTXVyWExTZjhBdlVVSUM3eXNkOFNQRWh2Ryt3K21BKytK?=
 =?utf-8?B?YUtoTldPOCtJWDFrdzJpTjdicmx5dktjZEpXbkhVU1V2alpuYkVmNjYvWjV1?=
 =?utf-8?Q?UeUzUZCJnSir6pM/YqkrflACM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7466aa-6a21-455a-2921-08ddfb4684a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:44:05.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhhOQSD9CgjtUd+SNt5FTqApvkfI2QcwDr5OYw7qHevbFnmoAWwbAIVuB+dBqx3MuhX7ID21PMMaBEepp/T4cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474


On 9/22/25 22:10, Cheatham, Benjamin wrote:
> On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type.
>>
>> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
>> support.
>>
>> Make devm_cxl_add_memdev accessible from a accel driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
> [snip]
>
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 7480dfdbb57d..9ffee09fcb50 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -67,6 +67,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>>   			 cxl_debugfs_poison_clear, "%llx\n");
>>   
>> +static void cxl_memdev_poison_enable(struct cxl_memdev_state *mds,
>> +				     struct cxl_memdev *cxlmd,
>> +				     struct dentry *dentry)
>> +{
>> +	/*
>> +	 * Avoid poison debugfs for DEVMEM aka accelerators as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (!mds)
>> +		return;
>> +
>> +	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> +		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> +				    &cxl_poison_inject_fops);
>> +
>> +	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> +		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> +				    &cxl_poison_clear_fops);
>> +}
>> +
>>   static int cxl_mem_probe(struct device *dev)
>>   {
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> @@ -94,12 +114,8 @@ static int cxl_mem_probe(struct device *dev)
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>>   
>> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_inject_fops);
>> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_clear_fops);
>> +	/* for CLASSMEM memory expanders enable poison injection */
> Nit: I don't think you need the comment here and in the function itself. I would
> go with the one in the function personally, but either should be fine imo.


Right. I'll fix it.


Thanks!


