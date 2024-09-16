Return-Path: <netdev+bounces-128536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36E897A266
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1835B20D99
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463814C70;
	Mon, 16 Sep 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5BHFTvxP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0711527A7;
	Mon, 16 Sep 2024 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490271; cv=fail; b=IecBDz2LCH/vzQ6ASqyp4UEyun8IuiqESJlTHmurVyBLG4UFERX4Y8QUd2eqW6msNEnflelmbdaw+ngYueWO5XzL8aOMPLAv6G0R0QO5+ShJe4bHA6PfKmNpIwOgh4PPA5AOgrXk+VuHwCWZ6fhpBOEe72xcP2yOB/Z+jpuHyNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490271; c=relaxed/simple;
	bh=M2EqgadPVgEJqnnwdcy6s2ZOD587OO0HPlH6SmOlEPE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H9UK62BoPW8q/hxl1bRJ/U4UOuh8Lj7nviRbBMArLgFsvK5ttLeQajaaWcfWBOacMREWAHtK7RjZ4GFKB6+LR7TLNqzd2qV91JpmoYxqKOL/y4BRjPDu+mhqxgQ4NrYZfoSRrVVWHdveu0cN8Av7fRcImEzRvIUFsfz3eHvnTrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5BHFTvxP; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rF6kpwaE5CeMGZXTgT9FFOQkGP9+IhdLDBPk7NdiDaAHf+l7/gglMWWDh2nVWJ5K0LWxgFFKZ5nTz+hhWNEHgYwFhK6Jgou9mLgaAPSozcudFr5yTK008hvCWA+/o0Q2NZi2jhR2Zp5+qDFdueMWoddLQWI//pJQzA1Yd2ZOKoiO7HslNHfOgJBRuvxmEsgsAvJ4ub6E1yiws5GGKKgt1j4gFXXKGbe+yfNkAYq+/g97lMcgqThJ9pw9So+arpvM/ut+qRPd4hhpkqMnH9w6cSWD75PQvNAheJ93mTTNoW/I4YLZfzRnmNxw+R0qli4L2DGW4khd8+d+RwE8eaVoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEsicRcJRSQFG4dHs7oyBwfBrrWm5sSYiJhrBeqnNmg=;
 b=o1iRaOpnH+4bzs6WaE2oQevy9GTnPL/zMRe4jhifA201JWVIJ4niYZgN3v18/Sdz0HWTgw6mfMQwmwB+1jer9neTrxPBVB/ynBpPIsahheYu1rLTLsKbrBPdwMHaYl19ZuWry3CgBoedHtQt22aaCCuAz5Ljvd+Bz/0Q0UeED4sAwhSqBaHIoP33kWj8JK8TQifUZguTu/+sI4K4imFq6cveMtidLUPw/L3fL85RZlRpww+GXZGXgX0sFJGfftPmTXyb0GksabDhT7JEz/VtZ9o1t9x5okETpwf4XAsG+8yD4DpmCb1HwpassNlFukgnujbmkGsOWQ8ts5jCoIF9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEsicRcJRSQFG4dHs7oyBwfBrrWm5sSYiJhrBeqnNmg=;
 b=5BHFTvxPTwsuNT7qnKXcPo7M7suRq6BJyjA8jspDlkXD7zXQv1DoS4Cu4YISl0DT/rIaw/4s+bvc3fH2Tf/Kc+et8TB8eJDWePvnL4mfQ/GmnZfKLAQqXbIYZ10zMJQK2mnBy6fk00dlXhWdh1pklDbCvuHaPXaMMVJbN+p2ol0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 12:37:46 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 12:37:46 +0000
Message-ID: <425a7ffe-39c6-4e20-dd30-2d65eb1bbd61@amd.com>
Date: Mon, 16 Sep 2024 13:36:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 07/20] cxl: harden resource_contains checks to handle
 zero size resources
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-8-alejandro.lucero-palau@amd.com>
 <20240913183621.000024f0@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240913183621.000024f0@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0239.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0279fa-ebe7-4a14-3cb4-08dcd64c5ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXRHbkFuT0hnK1NSWklJTDZLL3RwQVRxU2w1VForbHEyU2wwdXVZZXZEUkc3?=
 =?utf-8?B?bEZWejhKTlcxNjVWeVpUTXdOT0IzYjVLYXhGVEU3V050R1MwZmx6dnoyc3V0?=
 =?utf-8?B?SlRIM0FVMzhIamx4bWdINVkyWE5IWFFNOTd4TUc3YkhUL1hlbDBWU1JoL2JJ?=
 =?utf-8?B?S25ETVJIWUtEYnRENWd4enpGVVQzcnZaMWt0ZzNudHZITUxKcysxSTNnb1lJ?=
 =?utf-8?B?V1hQVTJIZ0NOcmdEYjRZZGpXN0NsMlRlQkx2enQyaXBFWGxIbExSSXUwU1hV?=
 =?utf-8?B?YmxNYm8vbkg3RHp3OXdlbUgvVnFSV2VXMEJXTjQrL1FKbWovYlcvT0dDNHRR?=
 =?utf-8?B?MkY3N2ZHTlhVWUUxcm5LRFdTSFdWWG9lZUNSdkxlclVmeTR5QXZ4QUJzajlx?=
 =?utf-8?B?ZjBKZXByN1pHU1ZkNXJTOXh4NkZZSkFNc1NYbnlNZVZweGJRWEdiWGxnYlZ1?=
 =?utf-8?B?MEFRMG5JV1RhRWlHY3RDNm9yd3doUlhPNitYNmZsUFhEZnpZbUs5ZWZQL1FF?=
 =?utf-8?B?aHFBd3BhZGVtejlGc3lsSDhNWVlERk03c0cvREc3eVFSdVk0aEl4MUQ0ZDNn?=
 =?utf-8?B?R2M5Zm14VEdTQlFtMDBsZjdGU0hFRnJrNHA5TURzODVMQWxBUkVFbzVhc2o0?=
 =?utf-8?B?aW5xNGRrcjJlTVlOZ2gxS0ZRZFkvcTNjTWNkMUxtL09FbnB5d0tQam0rNU5S?=
 =?utf-8?B?aitvUkhnSkxIMlU1QzFMNDl4a0hqc091NmMyNEw2K3o2amhCRkM0Vm91ZVQ2?=
 =?utf-8?B?d0dlMmFQbUdsaXduOTdQSDFISGJzRkthamRnZG5tKzlxM25XcVJ3dkFmcU5K?=
 =?utf-8?B?NlY1UzRrVFVSb2pMZnFDTmlWM2xIQlJ1RlZ3MG05ZmtCczdFVXRRNDFMOGty?=
 =?utf-8?B?RDUwckJ4cFFBV25XNEZPSW1oT0NtaXBOak5oZ3FqbXFmaXd2WmZkYVo3MzFi?=
 =?utf-8?B?ZXRkbEJUaVJNTXFHZXo3Q2JIdlhwQXlrSTdXRWI5bWxmTVBrQkt4L1ovRWdO?=
 =?utf-8?B?elRDeXo0bCtIWnRiczR5VTFlOHRnK0dCRGNTZyt0Ti9pM1RPa2lyVll4YTJw?=
 =?utf-8?B?ZHB3SURpUkpWSW1kNVdTR3Q5S3FIVi8wTXMzN2ZQN0I1TlV4UDlMYjVMVGRW?=
 =?utf-8?B?cFAwZ1l0ZWpzNzR1YW53clpUQ3RvTCtLN2hBMlZJY0xPMUJ6dENtbXZiQUg1?=
 =?utf-8?B?ekV0QU1QVXB4ZjFGeFQwOStxUVVaUlIvM2hSaEg0SVdrWFp5RGFQSTRDYXFG?=
 =?utf-8?B?dVZCa0F1VXhFa0JWZUVvUjRoTGgwaXp6ZzhUVkJubXpJaW9FajZkYzhtckxj?=
 =?utf-8?B?NWF5dHR0U3dlSE93dlFlakxycFNTaU1RdUVTYmVvVmc3cE1PaE1ndnFqVmE3?=
 =?utf-8?B?SWtRb0xzQW9YY2dZbjdFalZMUVNBTzk4eHBmK2ZDc0tZeXhZcENMOTJYdGpn?=
 =?utf-8?B?QklhTGZqSDZxYUpycVVndnNiM1ZQMXl0Sk5ydUF0bXVlSENKczdYazdMdXMz?=
 =?utf-8?B?VlErT3V1S1RXT0s4Uytyc0hKeDVWVGJ4a0syRVlCdUhscktORUZGcWZReHBq?=
 =?utf-8?B?MnM0WVdHWjBLUlo3cElkek5XclVORy9SdDBnM1FjVEhvMmU3dkZsWmpwTzdk?=
 =?utf-8?B?cjZsOVdpbi9zNGcyL0ExcFg0SVgxM1RKOW80RlRIR2lVWHFENXZLbXBOdDMz?=
 =?utf-8?B?STBQQTZzNldQSnR0OFVKd2RzRTh1SmlFbkZPc2I0aXpINXcwWnJFbVFCcmJJ?=
 =?utf-8?B?bzJEN1YwWHdUVW1BME9XbnFXRW5WMHhRUG9RL3U4S0FEcmRyYk93aUlTK3gw?=
 =?utf-8?B?Y1JoK3hwSjFnNkkvcGM0UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkM1TUFyV3RCWnVnY2VjTVNsSGNnYVVRMFNVek5WVkpKYS9oTktOeVkxbTIy?=
 =?utf-8?B?TVhEOGN5NnVURCt3VXh6cHR1YVR1RHYzbkZqWVB0cklHOTBheW1nU3VhZDc4?=
 =?utf-8?B?bExQbVpFaTNFVitSazloSVQwL25UOE1ybWRrV1ZyUStTT1JtdmZPNjgycGQy?=
 =?utf-8?B?dzdsY0w1U05TRGNPRWFmKzAvTk82R3hidktQV0srMytWdEpRVzl0bCthMnBr?=
 =?utf-8?B?UFNaSGVVdThCRTYvUXFsdXB1eG5kMjAvajBnWGU1S2JPaTBZRXcyc25PaFFo?=
 =?utf-8?B?YVlWaXA3bmc2MjZBOVJLSVRZUUo3WFBmbVE0M21talRDcnJsSHQ3QzljdWVH?=
 =?utf-8?B?RFFuRWlCeTl6cCs1cXJvSmU0YU9rRnBIeTRXeDFMaVZHNkhPd00wU2NPdG96?=
 =?utf-8?B?T2kyak9LYWlRL1dmZXhERldqcXJEdUtOS0pCQmNZYkhGNEVlSE5CL3dXelJl?=
 =?utf-8?B?OFo5K2cvTksrM2dhckgyQmphdXhVcGxETFZJZVlXdFVNVWRXZVNOYXQxbzdZ?=
 =?utf-8?B?ZzhKME5paXZ4dWpJUVA3RDhuYWViTlhRZlpWSzg5NGNoTWlrYTl4L01sblA2?=
 =?utf-8?B?dkhuNnEwMnFBSmFFUzRzbyt1Nk9aNmRqbFc1QWZ3ZVYrWFJrbmhLSTJkQmhq?=
 =?utf-8?B?YjNnQVpJWXFYTnEvWVQ4alpHenhZMFdvNlowOTRxU1FyOWYvZFVNZjd4cllk?=
 =?utf-8?B?ditIcldtTFhycVp3VWZ3WEZackluTnZhRHRFVkVZT2FoNkxwMjNVZUF0TDd3?=
 =?utf-8?B?Wkhac3Y1ejQ4Sk9WSno4YTlxSWMraENoQmtSUUc4ZzhzRzRldTRmK2w2QW9V?=
 =?utf-8?B?aG5wSFNCdUFzNWhMNExTSmRsZzNZSktUVmF2aTgrVUtMSW1ubzV0VVFEM2Y3?=
 =?utf-8?B?VDdIZEtMclNZRkhhTGdSTG5MQmNwVW1Db3B1VmhBQ2xVQUVVZTBYNDY3UU00?=
 =?utf-8?B?ZlI3VHBSblZub0xZVmhicGlxd05oMVhtWGpiZW43S2dVcG9iZHlYU1ZKR2pP?=
 =?utf-8?B?QzhJdjRkYTVFMW1EalJmNWV5MUNXbTVoKzJSUTRIYlUrNmRFdnBMSGxQV3dv?=
 =?utf-8?B?MmJ4c1cwV1JOckRxSXlFSlJvMHdETHI4TnhINlJvTmZUMlhxMzhyS1B2YTJF?=
 =?utf-8?B?ZTczaDNxcGlaamNLdCtUYXQ1SzE4VmNGS3NYcy9Vd3E1MHRiUW85RER3MUFE?=
 =?utf-8?B?eThneGk4YnVheTMwWjc4TGZmUUdNcml4aGV0TG9OOWpyZStkVjJwRzlBTHN2?=
 =?utf-8?B?UGtCK0cvTmZ4UW5GUk0rOTdQRERGYk16dkVWZStCaEQ5K1NxdDk3eWNnR0lD?=
 =?utf-8?B?Q09obnI1ZzBxZ0lmM1NJbW1rczN0L2hhYjkyNVQrZXVkK3BDVENxOVYwUnNJ?=
 =?utf-8?B?Y2phbHh6OVRORk9ybml6dm9vWWxPQW1QZVFsMHNrTGVhcTdobWFSSTFDL2dr?=
 =?utf-8?B?QmNMblloMGdpa0tVQkJCcGNMZnk5ZzFYODhvN1pocmMrYTNmd1JvaExKdTJT?=
 =?utf-8?B?MlJCblBDUVkreDZPcXpvSUFZbVo5ZkRadERDUEM3ZXppaGtnbEUyZ0krQjF2?=
 =?utf-8?B?d3RxTXErQS9MYU03SlVPN3lscUYrQ2ZTQ0EwRys5UlR4NVhLeFVJQVlYa1Zo?=
 =?utf-8?B?SW5QdmlGK1NkbFNQWWRKdUwyRVJlYTBnM3kxWTdSUTVZZmg3TG5BVWZYelJw?=
 =?utf-8?B?cFp4dE82dUtoSXA1UzNHVmJnRmdUTHdhSU05OWkra2lBaExkcVVpaXBrRDZY?=
 =?utf-8?B?TGs5NXhiQktqRDhlVzJHWDMyZ3pEYytsYUNlV0xPMjhBZG1LckpSQllvRGxY?=
 =?utf-8?B?UGZBaDNHKzk3NzdCcWpRanVFVlk4VDlVYVdiMGNtdXJqcDJQMEppRHBBb1c2?=
 =?utf-8?B?MnovV21WSjlEaDRSQXRrYWVTanUzZ3NpT0xaakQ5cHQzU3p2bXdsam1iT2Np?=
 =?utf-8?B?MnlSQm04R2JJVFhDL2QzaWE4NHlmcWhoVVZ1VjFKVk9rMWNxd0NUbjQyeXJS?=
 =?utf-8?B?azB4TkxQYm1nUEFSL1VXY1FtcDdMRS96OERpSzgrZ0tpcjQ1bm9rV05uZGFM?=
 =?utf-8?B?djl1S0Y4WGwwdHpaT2RsMU9CVEdyVXBURWRFVytNVmc5TE5sQnpUajM5ODh0?=
 =?utf-8?Q?YxFRo+1sToY32t0XXVPLnzks7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0279fa-ebe7-4a14-3cb4-08dcd64c5ca4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 12:37:46.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aStkYLgnIqFtPst6/ZF6OAlXBTPSulf3gSfX1n2ky8lOzr2rbJnialL2KDaydfTN79g8td8KrO0wLjjpxHTUSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768


On 9/13/24 18:36, Jonathan Cameron wrote:
> On Sat, 7 Sep 2024 09:18:23 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> For a resource defined with size zero, resource_contains returns
>> always true.
>>
>> Add resource size check before using it.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 3df10517a327..953a5f86a43f 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -327,10 +327,11 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>   	cxled->dpa_res = res;
>>   	cxled->skip = skipped;
>>   
>> -	if (resource_contains(&cxlds->pmem_res, res))
>> +	if ((resource_size(&cxlds->pmem_res)) && (resource_contains(&cxlds->pmem_res, res))) {
> Excess brackets + I'd break that over two lines.


Right. I'll fix it.

Thanks


>
>>   		cxled->mode = CXL_DECODER_PMEM;
>> -	else if (resource_contains(&cxlds->ram_res, res))
>> +	} else if ((resource_size(&cxlds->ram_res)) && (resource_contains(&cxlds->ram_res, res))) {
> Same here,
>
>>   		cxled->mode = CXL_DECODER_RAM;
>> +	}
>>   	else {
>>   		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
>>   			 port->id, cxled->cxld.id, cxled->dpa_res);

