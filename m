Return-Path: <netdev+bounces-146511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5056B9D3CD5
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6AA1F23A15
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC3C1AB6E2;
	Wed, 20 Nov 2024 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PZ7Edad4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2781AB6CE;
	Wed, 20 Nov 2024 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110938; cv=fail; b=MMafqmUo4CfuMyL0xUm/JuE7LHHYMRTiTooPiSxrcz7CynQSOk4hbNIfrcTEK4vLszIl/is8uJMMNMxhnOYNt+9dH8MS3kdf74xYAVe1p+mxGvwZ5DJrRkiRfEIWJGbe8WHMG99Qi7gjSNOD8RLJAykXLLYD3V0AYUG/r9PER0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110938; c=relaxed/simple;
	bh=hGiUPIC1DMcS16HbLFxzfuqeeGvv5fH88HXjqe9t/zQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gJt/9iTvJ784JnD992AwPYsoPNPZqc1/xF63ikO3CM6q0pR/g8ItqldKxbaD+3opKj16r2e5kY/eVrqueAisNWZQAJjUoO8Kow/Yg5APP76yDF0fDRBsVtRbtWIFmCNGqZBZwKCbBl7zVCpsN39RdIc9oRtFVJgj5LNoqSvKyDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PZ7Edad4; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLADjtZyaMc3moZmy4oryzzpg+UqaDDWvX06GfbIoCLXqoxVT+rAzGidRau9xiQmW+U+egIcspZUCxmgkJqYZt7TTKWZYjgl3xDpGUdI5Sv7Sx+xQcS3bwX2Y3YBKOgDiRf4rBk6NA9oVzgDZGP4Cs9fPp/u1ACkpo8upfJkGzCUp9jfg1f+nbDFulUmb+s82R/SqCDWHUoVc/fFng2vyXTr1m0Ywc6MprfmIoAzI7NO9RGBF5TelRaJk7EItudAd0hyHfdsh3RkM9zTkPwClJ/pVL/KmTNcWLw5aXxXol1/+jdAd/XE0l/kKKln8rZaXVBBICzHpjQ7qCEWDyag5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwxJ3cRanlkeUXZYiVZThao52xm92IlfFkpmplnNne4=;
 b=HUFthGdcnhGHZFCLD1J/rGbdC43bQTvr1QkBNS/eaCU3qRpDUA0VSaWVN1DURLvldy+Y36T5m5zFnUB3+hBqCdvEaCf05kRQ3i2buagxmb99056tbFQYveuzy6woCUxZm3F8zrlrJQnHifrU24auyW/+iI/fANAH/zgrgJG5P2nHerHpxuEyzqSXepupE+aqggua1LUuQdbiyPCWXNd7n8Kmde6lSdm7JJhMqeVAEm8OT+XNKj2SxsgqhS3UKbu+6eGLg6GA1bXbcmVoqIZZXqpZgMhH0wLKTR9UC1+z04VAObSVyCgNZQTHWq3DKLtDB4BrZ9qEQ4IPkN/ZlvP2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwxJ3cRanlkeUXZYiVZThao52xm92IlfFkpmplnNne4=;
 b=PZ7Edad4nuz8ZKrBTHhnWw73H3yAoA+6a9mGW3EIMTcE3ycF6odjYY5ePNUYWf/Gu6sXXxJXIgjPYInz7hv5iGqAF3KWhTdAGjWPFrM0Nqw94iZqx05ptkESjBl/inpIhk+etjrFXJDQMepOQ6Tnpw0yZhd1y5KuxlS0fC5JjxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:55:34 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:55:33 +0000
Message-ID: <dcbb5c8c-893c-5880-d6a9-3c37a1d8f6da@amd.com>
Date: Wed, 20 Nov 2024 13:55:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 24/27] cxl: add region flag for precluding a device
 memory to be used for dax
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-25-alejandro.lucero-palau@amd.com>
 <20241119223905.000030cd@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241119223905.000030cd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0605.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 008b049e-0f29-4588-f492-08dd096b00c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGEzRVlzbzVMVFN6dmh4ZVVxZ1Y2NEFPa2xGOXo2ZmdlYkZNLytpM0FOUTRz?=
 =?utf-8?B?bTB6dDYyZEI5RW0zRjVzcGpzajdlRG1wQ09RaEFPQ0ZSMWw3VFNTcUFBQXBC?=
 =?utf-8?B?dXRsOEtIclFvY21NY2VPN29mU1lGMHVYcmw4QjFwQ0k5ZkZjUU9IT25GYkdx?=
 =?utf-8?B?aEp1dG5XWG1oNUJVT2pQUzg5bHJwOEt0cU9LeTR0bjNHMnMzdmtxd3U4MkdY?=
 =?utf-8?B?K3BKbXJpMnkwd21nZ09GcWxZT3FGNk40bEt6QlFQSFc0T3ErQjdiekRndnNq?=
 =?utf-8?B?d1ZKcWwzc1U3S0RHajdkQmhIZGRJTnJKdmlkNjl3bWgrUjMyQVR3TllOV1c1?=
 =?utf-8?B?U0lsbzhxeHZoMWRYWXREaFdhc0lNeXl0amttRWw5bWl0K3gzUUdDUk5KTWxI?=
 =?utf-8?B?dlpVaVpRZi9xak1pYUppMTI4ME9nSGpDRlJvQkZrWWlHZjQ2RUxEakVQbjk5?=
 =?utf-8?B?cXJHSEwzMWRKcTNpaGJyS0hrSWxhRXU0UVZha21Ka0RRd3RuekkvTDllYVBK?=
 =?utf-8?B?bU5uTysxOHFiSVhEUnpscWRQekhaK0J3Rm5IOEFZSXd1UXFhTTl0WWVtcU5n?=
 =?utf-8?B?WDJxME01ZDNkTmRsanJGbFV3UXZvVlgvaE1vUHBnVlZJMTB4cXpHTHhQbHZx?=
 =?utf-8?B?TUFjSXQrcnBBeVVTMDRVSmRBeGVoVUVTWVE1MEFmY3EzSms2eWdHUkIvbE0x?=
 =?utf-8?B?SkpuMUFQMUkvRGd0am94VUlCS0xzeHJYU3N3VEs5Ymc0RFQySmFKeHBpN0dS?=
 =?utf-8?B?VEtJV1VMaXhHaGhpSlUvajhVRGZhRFJpeDJFV3BQR2d2WkxMdDRYTE1BVG1q?=
 =?utf-8?B?NG44OW02cmY3VnM4d0doUnFOUDdpRXI2TGUxSEV4cjJmcmJHa3RZLyt5RVNY?=
 =?utf-8?B?dEVHWUZlNXJPbEZORU4va21PZWlGK21GSGMrcFkvWDRzSTc0SVlRSkJkUHdx?=
 =?utf-8?B?TTFjeUdRd1ZYYUpjaWtEUmJ6MTRDaUdobkFaaURtN01NV2dhMlZ4d1ViTi9h?=
 =?utf-8?B?UUVUc0JLZGhDcXR6amplWGMzRTJabVQ5WEJxZUp1eTVBb05EZFRNWkQ5andE?=
 =?utf-8?B?MGJGMzg5VDFYMDl0YkZPY3o5cmRkYXFoMVhsb3JoZ282a2JIL3FEYnc0TFMz?=
 =?utf-8?B?VE1NL3M0bVY1SWgySW8xaVdySGo5eWNmY0M0VkpFNGhoWlA0czhjQWhSM0ZZ?=
 =?utf-8?B?cm5yV1FGQjN2U2hCeCtVTUlvQWE2dVhvUjdmTzl5ZjJIbWc0YlNIdjZGRmFt?=
 =?utf-8?B?WGUyWVp3R3dhS21RNFJKU1NIejlLWHh6U0MvNkdqcFg1Ykg1WDhXRFE2cGww?=
 =?utf-8?B?UDgvWkpCOWYyT05qZ0R4RzdxQ1ViYWU4eG03c0s0a2NDV0wzeVRrZENMem1I?=
 =?utf-8?B?aFhzQnZqZnRtSkJlZ0lPc0V4ZzJONVlvQmZIaEs2bmszd0dtZ1M2Slg1cmox?=
 =?utf-8?B?Z1cyQVZTZUk4T2pKTTEwNkpZUVlhb3doZ2FLZGxMZ1o4RTRCb1llUm5UREk2?=
 =?utf-8?B?ZGtiZXhkODhMSGVZNkxwZVljUEtTZnlxVkdFUWx4TXg5R2M2Ris1eEluUFRP?=
 =?utf-8?B?ZzVGYndLR0FHeXdVL01PSVVEclptMXRmV2lmT0kvd21ndjVNYm1JMGVvZkdi?=
 =?utf-8?B?c0ZNVlBudk1hem1lOVJsemJrVk1qY1FOVVlaS3BjTHFySy8zUGZZWWJpSnMx?=
 =?utf-8?B?amxxUjlsOEdXNGxLTHJEMTNlR0ZLL2o0YVBQVVU3bHIzTFVIRGNTRngrZnVQ?=
 =?utf-8?Q?wyw7GJIwUJeHLKQ90IFy6VKfzdU/luW+eoQYebc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWExZHR4N0hwUVFkZXBOMndVSlpjazc0RjU0cUkxQm5wdUJNc21jb3ZxWGI1?=
 =?utf-8?B?aEVLWEtqOWx0WnBncjUxQTN3bmtYQ3UvSmVycEFZZUpHTGh5dkJWYXVQb3Zp?=
 =?utf-8?B?SDNIQnhDRFNYT3BqNzg0Wm1SZGNxMmkyaHNQWkl6RFBLa1FneFovdDFTdlZp?=
 =?utf-8?B?Y0N6VXJrelhkMUNuNDU2WmFxU0NLSHRicUFTWkJyQ1hDT2JKTG1qejQ1K052?=
 =?utf-8?B?QTBYc1A2Z3RKSFVYL2pqRGs1L0dPYWd2MXFqU01WbTRIYnZ6NEdyY1FuZlBw?=
 =?utf-8?B?MEZBTmdUcU82OXJaTUY0b3dCSFpKWGljVjVLWVdhWEhPamF5dlF6bHhSVXFm?=
 =?utf-8?B?bW82R2kxZEl2eHBhVEp3RUJRUWNHcWZSa2NpdzdYR1dFWlhIa0JTTE1pUUdY?=
 =?utf-8?B?eHJJY3d5OFJqNjUvM1NZZm1HSGNncVQwWTNJeDBiYVR3bzRGeTBqRENjTlhG?=
 =?utf-8?B?MytWV2lEb0xNMmhQMEFVY1FDSmkvaGliN09EcjYxanp4L0RubFJzVDRyKzA2?=
 =?utf-8?B?NkhBaGJDTHR5UFhpekJKZVNxNUxTU3o1S21GVG11QWM2b0oxYWNQY2F4NEor?=
 =?utf-8?B?RVFLM1pKMDM5a1pldTlwazlKcjg0SlYzeXpHZ3h3TmNUQWtHZnJlM2lXSlBZ?=
 =?utf-8?B?R1dXbFAzcktXZ2FZWk1rQ2ZteEp0YlV4Z2pNTUFRQ1lMdzhIZE9KWVZFQS9S?=
 =?utf-8?B?QXAweVNERWttRXR0ek9BK3NPLzRkVkJjMnZQVFM3VmdLdHp3OGNQRnRJdE1Q?=
 =?utf-8?B?cXJwSC9RMFlpdjhqeHIzSXN5OVBBSldkT0NqMGs5NHFSY1JsU09iWjYwWGha?=
 =?utf-8?B?WE1LRWtGU255MUJyTVY2U2o0Rjg5R0ROMXd2WEIwdjBSa080N0trRVBkTkpp?=
 =?utf-8?B?N0R2aFRsenB0WTRHZFIxYjBYQm42Y01pYldJdklncFdMZXJJS3dENzJRSzMy?=
 =?utf-8?B?c0crMHdaN2FDczhqdW5Mb0dvejJsekE2Z3VRbVRrK2k2SVZIMFIzREZrZCt0?=
 =?utf-8?B?ZVdCZXdNN3hDc3R3TTZlR0R0MExRdVNrNjFxeHBjQlU3allxbjNkQ2c3azA3?=
 =?utf-8?B?dWxCYk9ld2loNXFsSGlWRHQyS1lHZDdMd2E3Nlp5THlmUXVudXFEZTc5QnZv?=
 =?utf-8?B?RnNRbTBKSHRoc2kyZVAvQTluSHlpbmVLWkhjV0M0QVlDVFAzaU52S0Vnbytv?=
 =?utf-8?B?bDRML1pYVkdNWDdaNkpSR24vZlFkZXl0cENVQzdEYWR0Q01hTmhhU3dUakc1?=
 =?utf-8?B?aEppV01LUlhEbEwwa1dFbXpxcjVXMDhTb1ZuODZCN2oyK2ppNHNsVDJSbzZ6?=
 =?utf-8?B?Z3ZieThEZG4zOGJvNXRZTEUvUVdSL1V4ajZ2ZC9MOUJoU2t5dTM4MUttaDlB?=
 =?utf-8?B?QndNRmlIWCs0ZkdvWjJGUmRnRytBV0tPcnRnc2kybUNHZk9yWGIzUm1ITHk5?=
 =?utf-8?B?Y2tRK3MwWFJTUmJQMTVVVFp2NmMxaE5peUo4dmtMUTdZN3A2aHNXQ282M2FI?=
 =?utf-8?B?OXhUZkVoMkZDWjhmR20zOE9TQlZsQW5JRElPZzl0cmVYRUpLV2VEVHdNeUJp?=
 =?utf-8?B?MkJhRUV4bitHM1VOKzY0eUVJMVFvVTFIZElNbGJkM3JLemNrL285K2JrczVC?=
 =?utf-8?B?ajBWeWtnWGMwYkJPeG1IMUczR2JoUzZwR0VHRkl4ZENMeFBnTzY4aGRMWVNr?=
 =?utf-8?B?cEZ2V3RzZUIwY0o4dFVJc01lSlMzdVk2OEVmR3NwcFVFelJmL2RISmxRVy9E?=
 =?utf-8?B?Mms4MnRvN2hJUERLSUdJQWM5Q3NBNllORlhKU085Wjd5dFQ3alFUWXlCeWtE?=
 =?utf-8?B?VUJlN2lGL3Rtc2lqMTJOOXM4eVpKVTdnMHdoRTJzeENnRDJMcUo5c3NnTDZD?=
 =?utf-8?B?UEFuTzYvaW9XNHVWdDByVlJBd05ia1ZKV0JyanROM25QcjF2djExbnQ5cHNr?=
 =?utf-8?B?Ym9aUzlPdFlZZ0ovNjg0T0RTYlVJcEcxWXZkMXRPcG8yR0lHZ2syRzNKaUdY?=
 =?utf-8?B?NzVjeEtNTHZlY3VFUEVEOHIxTTZSOWRDK3E0MzBkRzRxczNvWXRQR3ZWbGVn?=
 =?utf-8?B?VG5SWWNNK2d6bFRVVWxUamFZb1lZOWhpeDhqd3lvaDlnQ0ZzZnU2U3BHTmlY?=
 =?utf-8?Q?64ky/sju3nRNRuaM/+VELiLwO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008b049e-0f29-4588-f492-08dd096b00c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:55:33.8194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uD9DZKd+/ypB3ov1DRPyUnT58IiplCV0jiP/yZy6EQiVu+ak7zBqNCSDqzsCOfHo6rU6/7TtvqRljUtiPxqKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924


On 11/19/24 20:39, Zhi Wang wrote:
> On Mon, 18 Nov 2024 16:44:31 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
> Minor comment: maybe no_dax would be better than "avoid dax".


It makes sense.

I'll do the change.

Thanks


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
>> ---
>>   drivers/cxl/core/region.c | 10 +++++++++-
>>   drivers/cxl/cxl.h         |  3 +++
>>   drivers/cxl/cxlmem.h      |  3 ++-
>>   include/cxl/cxl.h         |  3 ++-
>>   4 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 70549d42c2e3..eff3ad788077 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3558,7 +3558,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>>    * cxl_region driver.
>>    */
>>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> -				     struct cxl_endpoint_decoder *cxled)
>> +				     struct cxl_endpoint_decoder *cxled,
>> +				     bool avoid_dax)
>>   {
>>   	struct cxl_region *cxlr;
>>   
>> @@ -3574,6 +3575,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>   		drop_region(cxlr);
>>   		return ERR_PTR(-ENODEV);
>>   	}
>> +
>> +	if (avoid_dax)
>> +		set_bit(CXL_REGION_F_AVOID_DAX, &cxlr->flags);
>> +
>>   	return cxlr;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
>> @@ -3713,6 +3718,9 @@ static int cxl_region_probe(struct device *dev)
>>   	case CXL_DECODER_PMEM:
>>   		return devm_cxl_add_pmem_region(cxlr);
>>   	case CXL_DECODER_RAM:
>> +		if (test_bit(CXL_REGION_F_AVOID_DAX, &cxlr->flags))
>> +			return 0;
>> +
>>   		/*
>>   		 * The region can not be manged by CXL if any portion of
>>   		 * it is already online as 'System RAM'
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1e0e797b9303..ee3385db5663 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -512,6 +512,9 @@ struct cxl_region_params {
>>    */
>>   #define CXL_REGION_F_NEEDS_RESET 1
>>   
>> +/* Allow Type2 drivers to specify if a dax region should not be created. */
>> +#define CXL_REGION_F_AVOID_DAX 2
>> +
>>   /**
>>    * struct cxl_region - CXL region
>>    * @dev: This region's device
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 9d874f1cb3bf..cc2e2a295f3d 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -875,5 +875,6 @@ struct seq_file;
>>   struct dentry *cxl_debugfs_create_dir(const char *dir);
>>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> -				     struct cxl_endpoint_decoder *cxled);
>> +				     struct cxl_endpoint_decoder *cxled,
>> +				     bool avoid_dax);
>>   #endif /* __CXL_MEM_H__ */
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index d295af4f5f9e..2a8ebabfc1dd 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -73,7 +73,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>>   					     resource_size_t max);
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> -				     struct cxl_endpoint_decoder *cxled);
>> +				     struct cxl_endpoint_decoder *cxled,
>> +				     bool avoid_dax);
>>   
>>   int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>>   #endif

