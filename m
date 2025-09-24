Return-Path: <netdev+bounces-226025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323F2B9AECC
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6336323A22
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467E22DE701;
	Wed, 24 Sep 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="47dwF9qb"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68E313289;
	Wed, 24 Sep 2025 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732847; cv=fail; b=B3n7jTVgOU2XZJNt9P7GkaGvYx8lAM99zJfJ9uFguiYsl0LndbPLthXxMKZkkeJvZbVzqjHUzJdGDnQ1geyUQFzcdDTRT+ztXKf39hh/sLbk5biVLVIjr+yYKZs66zhC4sijJfiLtBZPQitXVM2jOwcOOwk4PpF016MJl9ddhDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732847; c=relaxed/simple;
	bh=ydckuWEBM9z8si2U8zabj/nysnNXM/5ZAdWwYMVc9ZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TFw/ckeVbO+6JoBOFCoYzjq3DCUloOrtOgwjZ7qvs87UyHI/JFdyEWy70x9grzlS1gvtyM1PLYpaTzv7or16DsbkejcJGiz8cK2hOD7eyV6O2xJ/jfRet9p6btaFdsjUimIIQcW3tvPucvQQ+Zobk+Hr2ucvDrYdydzG61Fj9O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=47dwF9qb; arc=fail smtp.client-ip=40.93.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHNrB7jgXBA/6az0TKW8AI6QK+TcvfqjFqdt4PtBUtiMDthhAQjmGR9WZbe818AYdx3Hz6nznhEQsmMYOjDQusIX+ngkcEt+3X+GoWG38oclUUFIWcy5iQJVXMCBnJ0RTYeqFRCzxtWpWp/LbasQ69EkIp1kfa/dEVwvph2OrBReyfqI2i1ygsJRnkPYefSFAtUU1UKzfVPcSCP9ICcXdvMxumZbom7vHIREsQAX2JMGRoFswF737wSYpTSL7ZMwUjOVsp8d/NyviGiOl1zpaha6KJUM0YUckyAtJEOBMqJBTXiDi9a/RdtzRoJrpehfpx4owgX9rGbaz7eqPru6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vb2YVY5/KorkmVE78opj3JFnUK5hj5Aogb6lfE7EmhI=;
 b=SrD8Zs01hpOqS6FOBVx1kJdZkI0VFXBWi2kCB+0Cv6DuJxuvIJ/bajJT1vUhL7ABZhBk6Lqc9292JXchU23BmBLI5cTSl0RYShPZ1Zk5nJzB/erS1ZBHyuLAUhukhQ7X9xGM7wgpoWMhVlQ597fKG0rAzo6rDlTzfc9Nd/C9AQG3TRluQLo9idHgSgi0M/K8/QqSiwh+6uD0DJlu+Co9pm1P28HAugxPMbZ4CZ59yJsNi6yFveP8KbDlFCJHNpRbmlIkCazRQM8/Nj+0TiJKghBHmKae0LRElD6Ol8yhPA5si3oLrJk5FB0ljM6/K10knhGmdoqkNFQb1JnAyz+qrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vb2YVY5/KorkmVE78opj3JFnUK5hj5Aogb6lfE7EmhI=;
 b=47dwF9qbAc9bIuN8k7Nx/jTIxOmSQER7Nxb4Dl/VUMY7JOqaLeBXKWI9Ma/ijDaHphTh6RY8VmIgrFasELNvRiOvHPEJshX9/jWanXu6xt+F4WbE8l5BjInKqJUR9WGcRFttZsc84X9FyimGmeC3ThFmajTj34hjZ6SlKTos8jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 16:54:00 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 16:54:00 +0000
Message-ID: <a5783611-b837-4882-8d52-dfb5f4094f2c@amd.com>
Date: Wed, 24 Sep 2025 17:53:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 09/20] cxl: Define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-10-alejandro.lucero-palau@amd.com>
 <1b18b212-d348-4a9e-aa87-0cd3db596ed8@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <1b18b212-d348-4a9e-aa87-0cd3db596ed8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0141.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4ab3de-664e-4e48-dd17-08ddfb8af5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZndvNWYwWXdsVk9jMm40a21tZVgraVpueEx4RUNUS3ZZRzdsUTB1ZU15NnIr?=
 =?utf-8?B?UXFUSGpURUZpUldYU3RYdTJZUEJUclVhQWl5R1VibUdzZWhoczZTeEM0dHEr?=
 =?utf-8?B?QW1KZUJKZFYyU1g3cGh1eDF6Yk9mNWd6YlYycDlFNnZYYUU5VE1DWDh0bHRE?=
 =?utf-8?B?ZGtiQWEySXV4OXV3THZGbURRNzl3Q251QkNDODc4eWM0QWxXS09wRE04VWsw?=
 =?utf-8?B?NHRxZDhNazN2M3QrUWljOHVCd2pzVytHS1VZM1U2V1ZubTBtWEkySi9xTkdI?=
 =?utf-8?B?NzVjQllycXF6eTVzSDFQSC90UTNMcHRLMUE4dm5CNjByUTJtYWlWbTg2WVRt?=
 =?utf-8?B?QVp4d1VXUjBZdUNzVnFtZDFkUGdLeGFyRWt0eEd2R0p3MW9RcFJuTE9SWUNQ?=
 =?utf-8?B?Rkw2NGkzajM4b3JVcHpIcGpWNGJXMWZCb3lUWTdTcWZCSU5LbmducVEyYWtx?=
 =?utf-8?B?TmsxR2p4MmpvWHUvM2xEVUsxRVh2bTQrM2RxM3VwbzdvTkJNOUVvbkJ3RDAy?=
 =?utf-8?B?cVp5Vk00aW5raFp4VHZGOGQxSTBla3ZJcFF1T1BQNThLcEl5L2dyTEJoL1VN?=
 =?utf-8?B?b0RPbUpPeG1WTWxEN2RYdW56b0hQYUxRa1c0eG9xNVhFVXdUTEVDWDV2TnNv?=
 =?utf-8?B?UStnNzNIVGZnVGpScjI3MkhYZHhCUFZxdngrYXVZeWhDbkoycEJvVDk2Zll4?=
 =?utf-8?B?aE9zdVQ1RUdtUVJRR1dQQUs4TkxSZ1d6T3FoaUxPVEprRXpmK3hNSkhHeDVD?=
 =?utf-8?B?SDVkZGhlMFU5OW1IcnR2bWdvc21FK29DNFV1TDB6a05RM0JRL2x1cjM3SlZO?=
 =?utf-8?B?QzBBVWs2VUE1VUFhTWVyQVJQR2xtck1icFY0Qmx6dGk5dHRHY3RyY3RQTjQ0?=
 =?utf-8?B?cHNaZ1kyQStQRU5yN0pFeFpjdkh0OW1sNXdmaWIrem5rT3o1M3ByOVdJTTg0?=
 =?utf-8?B?VisycFh1RVIvZEpvc1R5UlJGMlE5dGVSSlJ5Z2xvSS8rS0swQXJ2ZUR2alJl?=
 =?utf-8?B?akNkYVFJWmNvSGRjNDhFN0Q1MmxyQXNWOStxd3BJWU04YTRBTEovdHpWVE1T?=
 =?utf-8?B?OTB2OUV6ZVMyK0l5aHFSS3N1WmRBY1BMU21qNzE1YWovZ3F0N0thalpjSjh5?=
 =?utf-8?B?UkxPRk5JN1RDeDI0QVZ5bmphd0c2NHBXL2xPMkhycWJXOTNuTzVadGozN3dK?=
 =?utf-8?B?VGZEQXNwYS9XSDJqUjdSSFpxRnBmOVJiRkFVRTNISU5UT2VDcXNlc1U0ZllN?=
 =?utf-8?B?ck9JUXRHUHRkQTJldXMveFV6YWpqajVKVEZLR0c4M3pjRG1wRkZpd1dEMWYr?=
 =?utf-8?B?aytpNGJ2Y0ZIWVc0UjBnbEQxR0trcmsvQ25oZFBSVFJwUG5naTdjenNCQ3Yv?=
 =?utf-8?B?Rzdweng0MFk5cTdxQ0cwUG90cStQVFEvaEhQa0dvWjJ3M3krQXNWbGFrbHJm?=
 =?utf-8?B?UDl5dStSVWlmMStIT3hnZUxtbUtmZ3lybTdJSTRqSVprUEdlaFR4cVlvZVRu?=
 =?utf-8?B?ZVlEdy90OEZ5V2NXNWZZeWpGb2ZYSExkMlkxZVYzbXh6RWorc2o1TWo5RUdZ?=
 =?utf-8?B?aG1hZWRER1lIUS9ONjgrcE5kTTRZOHkyUFh5bENHVFQzRDdleGg5UDBUTTd2?=
 =?utf-8?B?NXVvTFc1dHQxb0ZKNUh2SGwrOTl5d1FSV3BOUElCN0E2MHNKZVZsSHlWak4y?=
 =?utf-8?B?WmZ2UXZYamFuRU9HWmhHcXFIR2VodmhoMUVDbER6RzVaOW5XMFlIamtpWmNh?=
 =?utf-8?B?bTE2c3dmNE1pQXZ3NVBUVmlKYUYyTFFQV1VhMlBxdU5VU2RTWTA1REVraVNH?=
 =?utf-8?B?YlRHNHZDN0J1a3ZEUVdHV0ZxVDRlK09ldDVWb3JBd0pzc3J6TThyQUlSSEJl?=
 =?utf-8?B?eXZSb1BXWTJTWVYxQXJ3ZnJZcEpKeDRBUlAwZDh5bGpRZDVSdCthM1VDMVRG?=
 =?utf-8?Q?Si2nwptnW3k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGlBZERyN3BzVVlCUjQwc3VQRmpwSFN3RVBBYjdndHJCcDE2R3prK290YjB0?=
 =?utf-8?B?MzNBOU5kbnN1czdJWXBwbDJpNHNmU29wcVlIUFRqcGllNW5WcmpVdjVrUGhN?=
 =?utf-8?B?VzA4OUh5T2o3bmxwTlpwOFc0WnRHRFU3Q3V6cnYzWElyNFlXNGFHYkFVb0Nm?=
 =?utf-8?B?MTBuY3NVSUtRWitpTGVKTmRkYnFFdjg1dXU5cnFlLzlBdWR0TW04MHZPcEtn?=
 =?utf-8?B?SHl6VmdqeWJnOE1PcDE1WjZEVXJMV1FIZnExamVUampERmRaNWZvNEtzcGdG?=
 =?utf-8?B?Wm9vYm1kSnlIcm5jOFUzQ1dBY2pWdU13QzBFdUNmdnFTakhpYWx3VWVDb1pT?=
 =?utf-8?B?cmNlRzJuUDY2UkNEcmY3amY5WG9LL2c3OWVjcE5xQWRWSkJoYUU5NURlMHhW?=
 =?utf-8?B?NVVEVkpnNzRkMjlzbmp0eDlOREphWWI5dkxyV2xybDlFTkRFTmQvbktsRFY2?=
 =?utf-8?B?bW9SNFNiYU1MNTRhNzBWNlczUVhNdUxVY3EvenpyeEVoVXRpTGd4NlgwaEFV?=
 =?utf-8?B?d2I5b0d4RDRCQ3NrN0puOGU3ZXVoYkVhZnN2Q3NVUE9sTGg1YytrVS9sUTZh?=
 =?utf-8?B?TnRyYlhkbXVtUjZUSzdOczZoc2VBOEVQcHYwcE5YemdOUEk4Z0twa2hIWDlV?=
 =?utf-8?B?dWY0SllWNHJUMGtYcDRPL1FwbDNHYitLaEs3MktoS1hTUzUyZTJENDE3KzVH?=
 =?utf-8?B?WnFkLzg5N1NMczZLM21ZblN4a1ZNWm54WklZR2dScVNuNllOcWtPWTNnZ3p3?=
 =?utf-8?B?M0dQbUt2TTNqSFpRSWRuRDAzcnlzMWZTOHlOSnBvMXVMd3hTN1ZvaUg0a0gr?=
 =?utf-8?B?QVFoZ3lQTW5NMWhvb1hjSll0b1lJTDBLNmV2aUpUNUxsS1JYMk5oY3dXSksw?=
 =?utf-8?B?WmdHYmlpbURvQ3ViZGZFbnFWYW1BOUw4dTE0THJHYWllOVpVMkJyR3gxRW5X?=
 =?utf-8?B?TWJ6b2VnS0F1N3BwTWxqNkFiM1AvUlJNS3cxNUZ5WDMwL1lzSjhMeUluOE90?=
 =?utf-8?B?ZHR3bDBrMTFvc1U4bTdlZnVKSjJXM0g1NmF3ZkExcWVieldscURnT3ArWHFh?=
 =?utf-8?B?S0orZEhYNjBZSklodmgzai9lbWdYN3BCUDEvRmE2WXNkSnF0VFZBVGVnVWhI?=
 =?utf-8?B?TVZqRFZrMEVoM2F4dUxENlZvcUJhaEJ3UG4yTy9aZTVJTUxrdWhZcU5KR0d4?=
 =?utf-8?B?L2dUcitldXBXd3dkTCtvTnlIWVBLTnJyTWV6ditBbVVxOFVvUy96d0U2UXFr?=
 =?utf-8?B?VDR0VHNya0U1N3kvRHhNN3Q4OHBram1SNnRCTE1qVzZLMVNBOTcwSHUwWmpP?=
 =?utf-8?B?RGxOWXpIblVHOTdvMlkwanhOQm9yYjBTSWJKd1VZTjZudkF0anppbmNWYWhZ?=
 =?utf-8?B?elJNUVd6azdaV0drdVZzbUpkOGd4UnNCeTlNVnJ1dXRDMzFaZVBXYUdsUkRr?=
 =?utf-8?B?TEE4WUJnQ3R4QkJrdUljcFIwYm14SlhaTzlvMDlYZ2VKMjBMNk5ZUTFiQTVm?=
 =?utf-8?B?VEI1eHlqdER1TTQyNHVTTXV6WUVxa1l6ejlxZlROak9FSHFuS09XVVhYMFZy?=
 =?utf-8?B?WHRoVGlyS3RHK3ljQU10NHhGSE55NGhwOEFHZjVHSlR5bjVzcXNUUmYvMWdG?=
 =?utf-8?B?RVlTVy9BaFpXbVlRbmxBS2pzdVIyTHJRaUtJZzJ6YjJuS0src2w0Y2lOVVBS?=
 =?utf-8?B?WTZCWCtzdmVpbnlPblZ6cUxWSTJQRkpVN2RtMDdwSDBUYmtHZmdLRDZSQkY2?=
 =?utf-8?B?c3BoMTEvcFpMTEtuZDlURGFRamFnWllNV2dUVGw1VEtsTG81Z0krQmdWUlZE?=
 =?utf-8?B?TzNjeTFETVpHanR0Nlc5VmlJSUEwU1YwL1dvNzBRemw3d1VOeW5pSHBjM3NW?=
 =?utf-8?B?VnBvUUl6NVVITmhFdlN3eEtiK0NmdkM0dXIyNWNyd0xkcU1uMnhTWFlDOEFu?=
 =?utf-8?B?VmpBRjBVOHJxQ2IwZWg3V1I2Q05Bbjg3N1pFRXdqUnBXTHZWc2VxeWE1b1ht?=
 =?utf-8?B?bEJ4YkI3Q1hNMTAyZFNaQ3ZJUFQxU25IOGhXdWdTYWUwVG5xbk85ZzNoVUxE?=
 =?utf-8?B?ZzFoQlRWdStCU2dmckxjK1FZdEk5ZVNFK2hZeXgzT3ZVR0w2WlZIWG54anQy?=
 =?utf-8?Q?CiwlNd/99cktKwOIqcOzWWQiC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4ab3de-664e-4e48-dd17-08ddfb8af5b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:54:00.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5T61shX3HwhuuTgHX6U3/ijKUtdjUMM1DtUyHCaRLExIGgdsSXaTC8FEDPsFAA6BRUxquzHsTxcgTJFxjGxHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771


On 9/22/25 22:09, Cheatham, Benjamin wrote:
> [snip]
>
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @endpoint: the endpoint requiring the HPA
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * Returns a pointer to a struct cxl_root_decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>> + * caller goes to use this root decoder's capacity the capacity is reduced then
> s/capacity the/capacity and the
>
> Or you could cleanup to: "If by the time the caller goes to use this root decoder
> and its capacity is reduced then...".


OK.


>> + * caller needs to loop and retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with cxl_put_root_decoder(cxlrd).
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
>> +{
>> +	struct cxl_root *root __free(put_cxl_root) = NULL;
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridges = &endpoint->host_bridge,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +
>> +	if (!endpoint) {
>> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
> I'm 99% sure you'll crash in this case. The endpoint pointer is dereferenced when assigning to ctx above.


Yes, I need to delay the host_bridges assignment.

>> +
>> +	root  = find_cxl_root(endpoint);
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> s/can not/is not


OK


>
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
>> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> Do you need the brackets for the scoped guard? I'm not sure how the macro expands when they aren't
> there.


I can see other uses like this in core/region.c so I guess they are not 
needed.


Thanks!


