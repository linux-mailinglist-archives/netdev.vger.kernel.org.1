Return-Path: <netdev+bounces-119684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8290095694C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B221C215BF
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265F166312;
	Mon, 19 Aug 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="onG9EXBE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83182142900;
	Mon, 19 Aug 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066940; cv=fail; b=YsECgHzPe7VjJsBJXdhtZhCoqcY+zMMU86ZwZUdA2GPWjqmTvFfX8A5o2wMueXzN/QqVLg6mip11JYXSn9V4ko1kFEe7WXvpwu7Hj3sj4pnlz3+LxznhvfLB/M1itgz3xY/4nnARoHLKKAUGrRLZGfvyrH+4DkxahlcIYAKeJB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066940; c=relaxed/simple;
	bh=eJRvKhC5qSzhrTs3Jmjr00IhBq9VudKtI/fdHTEy3Yw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iY73gft65FXFxMxUQ61FdOIbn+2f1CKw79HshTu9Ggx8VhdeRJ7+XhKaq5V29BmrCtsO2rI8nM+kUXsvy8/6EiaTf7p3o7NCzU6Ceu9wXuZfPErO29RX0mh0Rrp2WrtVXXq7g3GDPP+z1s0kk8bH1JWOqHa+BOVHHP9qEIQveyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=onG9EXBE; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiBF8g3yGfJkGbev+rWI9HDPLDmM+VUGVIZ935wnQUz93q71X9FEgPfvg7YvAW8fiVEUnwRU4VXSB7f6Md0WmK1nU7CUn8FHSwN8w5LJ8qvofmNkBNJwEK9wPkNMnPUbUslTknvd8Q9Jxj8MgNlIsmAxh8QiOTMTAIZ2ffYsXqWIw1McV9CvS11PtScUu1BXm8RVXf05XxH2okIfq6NXFtKZrBR5MvI4OrWYftdqV9vJMVVIrjrxEigvh6U62hDBotLp6O2ZeLs6M2weE3EgfrSSqIjx23eieApRJgZ9PihYixDncztS4aqd+uBxshbpX0DXiDyZNWSIOjrWGNZvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI+wivW1YLw6RBWEp3vriP5eFuxx+/AIk/W7yXMSFPs=;
 b=i7CvpGuYXtClRgbKMF7mgFJt6gwob3bGnlCZdj5e4aauuiN2bhVIOOaAOgYJ74i5RPswqK4JwUxZT8TrrINWk/MVLg1y50ZFcc2Tbt+YFeQm/SErJNXh8q7RRUyQVFmEg5gsbOeZM1llZBMKgSTYEikCRXRcuX8eOfdqWegqvscGG7+M3Zvi+oSPgfebQGwbWGV5jtNR1ujjtxuxYmg0dPfsRZ0iK8cf8KjfJlQotvDxPVX+z26l8rcrXHUnGP0L0tDsfnl5k4sI6sHoZUm7Tt7ymuS5wrvkVZPG8yoHHtczfl0csutq12qiaPP/+yJ13S6YMJvlJp/Vvv7QPOiOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI+wivW1YLw6RBWEp3vriP5eFuxx+/AIk/W7yXMSFPs=;
 b=onG9EXBEbjcrkvyF4BtCBj82DEvrIYp/hhU9dZbJB33JiwSAu/X+fLDbphvxV80gGn3O9+/9cQyNyq2CbbpP7vB1FVyt3mVREIbiBdwMnsR4rfU5nsf+4czUCdReP1D4faSrW0YY22e/0E+0UfzcJRVKBI2yZC+hwu3AsF4kOeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 11:28:56 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 11:28:55 +0000
Message-ID: <24600a48-a173-7a32-445f-83337b035285@amd.com>
Date: Mon, 19 Aug 2024 12:28:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 02/15] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com,
 targupta@nvidia.com, vsethi@nvidia.com, zhiwang@kernel.org
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-3-alejandro.lucero-palau@amd.com>
 <20240804181529.00004aa9@Huawei.com>
 <5d8f8771-8e43-6559-c510-0b8b26171c05@amd.com>
 <20240815174035.00005bb0@Huawei.com>
 <20240818110720.00004e16.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240818110720.00004e16.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f99a45-f46f-444f-efb7-08dcc0421c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXVmcW5SdzQzYktmMUVIQkFpcXdTMjdld2tHTjRuMm9GSDhSZHQyUE9RdFAw?=
 =?utf-8?B?MHpJZzhpNkdaUW5WMnNrcW1McmZTVERDWXM1Lzl4OXI4K09tVFBKK0tlNXRR?=
 =?utf-8?B?U2J2MGh5SjlrRzVJTzFNZFZuUlMzaCsrQzhQMUZGOEhYeERzUEY5N2theDVP?=
 =?utf-8?B?RDhYbVV3OGprR2dGUXR3UFQvS0FJZlVqMW1ZSlYvL0lQUnpjckVwMjN6WXdq?=
 =?utf-8?B?Z0ZLZHlkOXVUMldNNGdaS3NwdDloWDZEQmFyS2c0WkZ5T2xsVXRJeUdOWUtU?=
 =?utf-8?B?a1ZEL25paXBvTzEvcXpiZUtvNFlxV0s2aVNNdXNtY2Q5U2ViQUx3S3pLOE1j?=
 =?utf-8?B?b3o4SjdsUkRhalNHMkM0YWJOWm1yOVZVa3JYVUJ4Q3RxYTNiMmNGNXRXREpp?=
 =?utf-8?B?ak9TQ05oK1RaUkhSYnNORHQyZldtTVBERU1NRVNrSjgxMGVsSFlzdFp2S0tM?=
 =?utf-8?B?djR6UVcrQlRvODkzMkJpTUNteEJKR2Zkb051QnF2VEpWTkpnZWgzc2pGMGxY?=
 =?utf-8?B?UEdBMmdKa1l6MEJXT1FGN29uUHRGblZybG5aVWxzQWdybUlXa0R4WExiS1RJ?=
 =?utf-8?B?Z1k0S1U5YytYcGlMcWhweU0xTWx1OVBVeituWUZBOWl6bHYxb1VuT3ZvWVJx?=
 =?utf-8?B?RlBpa05ZNVFQbXhRNEF5ZWx4R2p6c0dqVGhWMm1nYm9oTkRNSkxaS2lZUk5r?=
 =?utf-8?B?SGo2QjFFVkUxNEpnWGRKT2tPaVllKzllZHhkcjNWQXNPYlhJN0hmQ1JpZnBW?=
 =?utf-8?B?TVVXMU5aZHdVK2FVZWdxeURBQ0dwWjBCMjA5bWF2Ly83Sko5Mmx6S25pdTVj?=
 =?utf-8?B?NmxoVG5mR2tIY2QxcGpoN3p0cWZrY3BPMFVuUllFZ1ZiTzF4blcxczl0bkE5?=
 =?utf-8?B?RGZjZndqbEVNaUp4ZndOMHNCRGFlcHQzSjU1MjR6RzdVcE1jRmhqQUlxM0to?=
 =?utf-8?B?dHhXbkZ1a29ITUkrb2FPdlJHNTRacjJjejJTc3k2K0FDWEc2L3haRURzV0x3?=
 =?utf-8?B?WDRuVmpId24rYWtaZ0xiNkJXb2xXaS9Rd2NSNktmenhMc1JIUUpMSGVyakpC?=
 =?utf-8?B?eXdaV1lldWl0ZEhTOGxOa1drT3lveGkzWlV4NEoyVFY5cjNsOWF1bS9WNXRk?=
 =?utf-8?B?cEc5dUFEeTNDcmlsVWZvQThaWU8xUVBMZ2E2TmhDeDJlck1RZDBEZHFkZmlO?=
 =?utf-8?B?a3c3eE0wV1E1cnRNK2xQWkQzakZ3M2NDZE8rMloxdDhvY1JhUnlFQURFY0xW?=
 =?utf-8?B?UnVFL2NQL1BuWVlpUU5zOVZaT0NBV2FoWExhbklEWm13MTFVV1F5Sk5NeUxN?=
 =?utf-8?B?NlFvU2pEM2Q1dHRSVnhmK3VTZldJczJuZU0zWmhLbVBDa2xpR1VCUlpUL3Rr?=
 =?utf-8?B?Z0QxNEZiSkFoN0E4ZmRvb2FuQUtKWHYvQkJlWGlQSkdidFN4YU1vSExJVHpt?=
 =?utf-8?B?QytvRE1LSHV3SndxeXhSOXBYaWszNERjd3ZDVDVuRkhUVXZiTUt5Z29RbjJ0?=
 =?utf-8?B?T3pENU5Gb3ZDMlV5dnFGY2VDQWpVS2hSOW1IdHpjS21FZVVKUnZIU0oySlNp?=
 =?utf-8?B?Y0R4VW1DeUdIRTBhR0RMZU1MM1dVaUFDRmxUbkh5VmhxU2w3cWpabjREWlFF?=
 =?utf-8?B?cDdIVGUySklVNmMvSGt0SjcxMHhSY01mWWRlSi9qeFNFMzluUjVvc090K0Ja?=
 =?utf-8?B?WkYvZGJ5OGx5dURZbWdib1dvWGU4T2hLZ29QSEFDNS9seXNpUUFXeWM1QXBs?=
 =?utf-8?B?UWVtZHRpV2VUWVp2TE4wMjcvZXZYd3YzQk82YmFKd0JCRlNBcmNXMW9ybEND?=
 =?utf-8?B?S1ZmeUc5STRkcU1LU3RUQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1h1U2w2VmVYc21kYkxmLzNtRkpaM1puVFB4NXFtZEVHNFVpcUY4OXZzSEN1?=
 =?utf-8?B?RTQxOXZNK3Rrc0RRajd0ZTg2dlpTN2pBQ3BnM1FiTk9TaFNuSkNWakFlR2F6?=
 =?utf-8?B?TU5wcEJQaEhmV1lyNzZLMEtqeGI0SlJsc3JwSGlmQnNETDdaVXVWdnczQ2l3?=
 =?utf-8?B?K2V3WnpzNEtHQjU0YWJITFFhcWRZZkg1VVI5T1RzSnJhbFVZL3RwK0pqam5u?=
 =?utf-8?B?VlR0RW5oc2dHTWxGTUNGNmhTNFB1em5qVWdVVW1NQndpK29raEg4LzZZUVg5?=
 =?utf-8?B?bHd1UmRQdHJOcE0xSDlic28yQ1JVUmk2YnprZUU4UHJYekRzdTFZTWptOFcr?=
 =?utf-8?B?dHF5ekdlanEzNVROR3gvWHduU3dJaVNybElPcXVTelJLRzlXRGVpRUlkNlZG?=
 =?utf-8?B?MS9TMWNpcG1VaEk2bFlYZDMxMWphc0s4cW81MVNWNUsvbUptbVErNk1UaGNo?=
 =?utf-8?B?ZXYzVWVkQ2lVcU95aHBIK0FoSlJUSGN2Z0JDSzFUTnlQL3YxZVN1RW5iemZX?=
 =?utf-8?B?S281VkhjK0V0em5DUHdXeVZwbGpjNHZ0RzhmSVI0a3dkRzZQc1R4U2U5cFlT?=
 =?utf-8?B?M1Z1NlhUeUJTVmZSWi9wQzhDOFVIU0NGQlR6MGdOZzFlSSt4SlBORGZrTDB3?=
 =?utf-8?B?NlNmUzNaN3JuUlpLdWhzYlpqejBycGVRR20yVURTTjczOGlDQjNtK2JPNkE5?=
 =?utf-8?B?bVpEQWtRZnBsZ2dLT3ZLU2tSVW53U1FBUkJRM1NnbXF1TFhwZWRJZEV4OHp2?=
 =?utf-8?B?US9Db3lRa01FeDlWQmZaejlob2dyZmprOEsrL2JsZzdzSTU4NTZMQVRORTJW?=
 =?utf-8?B?UGt4ZmQ4Nk1wb3JOLzdOOFMwQkhvYTVocEY3R1ZyNlpoKy9KMC9vNHVRbzhQ?=
 =?utf-8?B?NG8rb1VQZlRWUENraEhMRWNLZjByNUs0cUJJdllRL1Fiem9zZGtKRUtIeEJI?=
 =?utf-8?B?ZktXTUV6V2JTRkRUS0YxelFNdXBoZ1ZuNDB6YWpUUkRYNGZxTXZHYytpbDhv?=
 =?utf-8?B?dHAvc2gxMWZBZVVKSUNWdjlyT1BKQmU2TDFhVDJvM01Wc08zME5jZ3ZQUHpC?=
 =?utf-8?B?aGZzZnhTSW1GN3llTys0a2dNbGRhTHhFYkhqSnZlWUFlb1dScEFZcFFhVHQw?=
 =?utf-8?B?ZFZvSUZQeWVLU29qdWJmNk9qSFRvUk9OeWtNeXp6V1duV2REdUVrOUlNaWRS?=
 =?utf-8?B?WlkxSHhxcWhwNzhrMFZROUxKVHU4dkZ1Y2RtL1U3YmR1RkFBdUEzdnV2K205?=
 =?utf-8?B?K0Y3b2JxdW1uQWJvUjh2aGtLdlZEQkt1TFNtb3M3cExURlBrM3FETkh5cGdI?=
 =?utf-8?B?eVc3OXRrSjdTbThsT3J1T1pFcWcvOTVQYzdJSGtnbi84ZDdpU3dobEVMbDI2?=
 =?utf-8?B?ZEFSVU1jY2lvSkp4aHROWVI1ZlNKdUdQS3ovN0I2RUFTRHlrUmtqYUo5ZGlj?=
 =?utf-8?B?dVJQb2NZVy9XTm1CYVFUUGRkYVdmSVpNamFkV3NScHAvQWo0dFh3aFg4YVpm?=
 =?utf-8?B?UEFVQVlCcHlHNFlIdCsvd2x1MndaRzBSRFJjbWRXQ1gxeHc3Tm5WOGc0VERB?=
 =?utf-8?B?cUlERTZ5TDh2TTc2Y2c0S3BOVzQ1SzJ5UkVjMlBFY1lBbWV1Mzlsb2NJVjVU?=
 =?utf-8?B?U2RBT3pnbU15TWtmdW0zWGdKUVlFTnpLRmh3eVpCME9ObGNadnZBS1g5SGZp?=
 =?utf-8?B?NWk4ckZIczliUkhsTDR4d2pCa01hdFJ1SU5ZREszQXpqR2NBQzVWVFhoQmI4?=
 =?utf-8?B?cVcyYkkzQUZUZUQ2aVJIV1YwKzVCajNyZTlNVWxyaGRBbkFLeDhMZWVGakQr?=
 =?utf-8?B?UitIVEZzbWNTM3JBdElmMU5wY2I5eDdTSUhjZ1RDYTBEYXc4OUJPNHllUHRa?=
 =?utf-8?B?OUJKNzBTNVV4WmgwRWgyR1hmeDltQTd5QUFLMllaM0FiOXJSMENyQTVPVkJU?=
 =?utf-8?B?bUVvMGYxQUpNbVhuUjVEK0ErdmVwWG5tTnc4VXFYeUtvRU1zUGFoTXhZa0xI?=
 =?utf-8?B?QVRmelpnMEwvK3hjZHZZcVphNi9Bc0tQVkRmVW1Zc3k3L05SUnJBcWxkbThm?=
 =?utf-8?B?ZENkOTRqM3ZYcFh4N1M4VkNjWXBTSGlYeC9JcUlqcEdMek95VDN3U2o2WTFq?=
 =?utf-8?Q?lhbn+Pb8bDUjZFN0A+3EU/CWd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f99a45-f46f-444f-efb7-08dcc0421c5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 11:28:55.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35FLw9WQOWiq0teQTrr6JTnKO1c4KsVrIAyLWVsyl/EXGu5YvdGujfCZbWikY7FlA5HtxMyvVlx7tUkLgK4+NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970


On 8/18/24 09:07, Zhi Wang wrote:
> On Thu, 15 Aug 2024 17:40:35 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
>> On Wed, 14 Aug 2024 08:56:35 +0100
>> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>>
>>> On 8/4/24 18:15, Jonathan Cameron wrote:
>>>> On Mon, 15 Jul 2024 18:28:22 +0100
>>>> alejandro.lucero-palau@amd.com wrote:
>>>>   
>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>
>>>>> Create a new function for a type2 device initialising the opaque
>>>>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>>>>
>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>> ---
>>>>>    drivers/cxl/pci.c                  | 28
>>>>> ++++++++++++++++++++++++++++ drivers/net/ethernet/sfc/efx_cxl.c
>>>>> |  3 +++ include/linux/cxl_accel_mem.h      |  1 +
>>>>>    3 files changed, 32 insertions(+)
>>>>>
>>>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>>>> index e53646e9f2fb..b34d6259faf4 100644
>>>>> --- a/drivers/cxl/pci.c
>>>>> +++ b/drivers/cxl/pci.c
>>>>> @@ -11,6 +11,7 @@
>>>>>    #include <linux/pci.h>
>>>>>    #include <linux/aer.h>
>>>>>    #include <linux/io.h>
>>>>> +#include <linux/cxl_accel_mem.h>
>>>>>    #include "cxlmem.h"
>>>>>    #include "cxlpci.h"
>>>>>    #include "cxl.h"
>>>>> @@ -521,6 +522,33 @@ static int cxl_pci_setup_regs(struct
>>>>> pci_dev *pdev, enum cxl_regloc_type type, return
>>>>> cxl_setup_regs(map); }
>>>>>    
>>>>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct
>>>>> cxl_dev_state *cxlds) +{
>>>>> +	struct cxl_register_map map;
>>>>> +	int rc;
>>>>> +
>>>>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV,
>>>>> &map);
>>>>> +	if (rc)
>>>>> +		return rc;
>>>>> +
>>>>> +	rc = cxl_map_device_regs(&map,
>>>>> &cxlds->regs.device_regs);
>>>>> +	if (rc)
>>>>> +		return rc;
>>>>> +
>>>>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>>>>> +				&cxlds->reg_map);
>>>>> +	if (rc)
>>>>> +		dev_warn(&pdev->dev, "No component registers
>>>>> (%d)\n", rc);
>>>> Not fatal?  If we think it will happen on real devices, then
>>>> dev_warn is too strong.
>>>
>>> This is more complex than what it seems, and it is not properly
>>> handled with the current code.
>>>
>>> I will cover it in another patch in more detail, but the fact is
>>> those calls to cxl_pci_setup_regs need to be handled better,
>>> because Type2 has some of these registers as optional.
>> I'd argue you don't have to support all type 2 devices with your
>> first code.  Things like optionality of registers can come in when
>> a device shows up where they aren't present.
>>
>> Jonathan
>>
> I think it is more like we need to change those register
> probe routines to probe and return the result, but not decide
> if the result is fatal or not. Let the caller decide it. E.g. type-3
> assumes some registers group must be present, then the caller of type-3
> can throw a fatal. While, type-2 just need to remember if the register
> group is present or not. A register group is missing might not be fatal
> to a type-2.


I agree.


> E.g.
>
> 1) moving the judges out of cxl_probe_regs() and wrap them into a
> function. e.g. cxl_check_check_device_regs():
>          case CXL_REGLOC_RBI_MEMDEV:
>                  dev_map = &map->device_map;
>                  cxl_probe_device_regs(host, base, dev_map);
>
> 		/* Moving the judeges out of here. */
>                  if (!dev_map->status.valid ||
>                      ((caps & CXL_DRIVER_CAP_MBOX) &&
>                  !dev_map->mbox.valid) || !dev_map->memdev.valid) {
>                          dev_err(host, "registers not found: %s%s%s\n",
>                                  !dev_map->status.valid ? "status " : "",
>                                  ((caps & CXL_DRIVER_CAP_MBOX) &&
>                  !dev_map->mbox.valid) ? "mbox " : "",
>                  !dev_map->memdev.valid ? "memdev " : ""); return -ENXIO;
>                  }
>
> 2) At the top caller for type-3 cxl_pci_probe():
>
>          rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>                                  cxlds->capabilities);
>          if (rc)
>                  return rc;
>
> 	/* call cxl_check_device_regs() here, if fail, throw fatal! */
>
> 3) At the top caller for type-2 cxl_pci_accel_setup_regs():
>
> 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>                                  cxlds->capabilities);
>          if (rc)
>                  return rc;
>
> /* call cxl_check_device_regs() here,
>   * if succeed, map the registers
>   * if fail, move on, no need to throw fatal.
>   */
> 	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>          if (rc)
>                  return rc;
>
> With the changes, we can let the CXL core detects what the registers the
> device has, maybe the driver even doesn't need to tell the CXL core,
> what caps the driver/device has, then we don't need to introduce the
> cxlds->capabilities? the CXL core just go to check if a register group's
> vaddr mapping is present, then it knows if the device has a
> register group or not, after the cxl_pci_accel_setup_regs().


I thought about building up the device capabilities based on what the 
registers show instead of explicitly stated by the driver, what I think 
it is your point, but I think we need those capabilities in one way or 
another, not just for pure information purposes but also for finding out 
if other initialization should fail or not, what was the original goal 
behind this patch. The driver could also define those capabilities to 
expect and check out after identified by the registers initialization if 
they match.


So yes, I think it could go this way, but I would prefer to do such a 
refactoring after this initial type2 support.


> Thanks,
> Zhi.
>

