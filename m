Return-Path: <netdev+bounces-204558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AF8AFB265
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B166A7B0192
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEFF1FFC48;
	Mon,  7 Jul 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OEjc5dzg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FBF19D880;
	Mon,  7 Jul 2025 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751888265; cv=fail; b=BBd/YAExIvwFmgwSzPtxkMCsR158g5q8AOi/zRBrWK0sQzJVHE3fjmdLIPi6xoD/efv2GRcUSVZgMCeS8BHu7I0owTZAclMPHI3zZh5jb7RxNwIKKyHMUbvrWzUw7cTFylae9csVDIh/4BXjEH5D/70yvs5He9qtnN6K4e9gonk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751888265; c=relaxed/simple;
	bh=FkdeelKUha89hu8Qndy/jOrMgPnIV4B6X/TB+u7XZbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N1HkT4+OMuKcCKo1aJLtDQt0Evw6qFCQweGbpHVHgdcaYm39XYsjXb9jrEPSlkdjGsVl4Mf6gFhsTJIYrIm8JFmPF5cZhf1zykyxiekRnlrcoUa0H46NFmiX8Gxjc35SubhS1buGUEzVBZu3IJ3H1VWBFx5vGXJL2zQZ3O5RbK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OEjc5dzg; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6gSx2q4U9kPizttcCYdg50bSk4NnLmWBlyGW0vkjQG2WmjjjEAV5JUPIduT7Hc3/OoKc62RAPyfsUd1gF9MirRSpoUVfdjFSi69kFceY13Z1OgxB/OuyUgo7caKNY8yB70TYQ30LmrTqDie1QT29QSymIGgYoOkxOG682Qt9p2JVR1EgFJTDiiCJb4FF/DaN0j4R4jJA+WhKbFgXE+OWfvkmXxZYX0VjCzu9n8FLhbhkR09Vv5iRAJarafuUvCKurvq34fmj5TWnCynO0GFdwa0H4BPDVXbGbQrO8g+NKC3aKcHazrNkIwXpe045sUEWZ2xc01XrsHHKgmwCvakCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUMmkckljTvipjdIITFA+cpbKKjhnRlJhgcS35RolBY=;
 b=I6PD4nC97rt2fBuq3Tuqu7qhNfVKAUSZPiDQslCY1TX5Wdsdl8hiJ630q9u6S3pE+VU3dBOq/Xq59W3kQg8IH5Ok9YJFu+2gcFPEgxpWlUWNzBTUG5Xb3YIH3bRX/jpV3M8DNdMSRzLYAPSZRsbI3DWyrTLH1/MpG6WEfC1EWlO+kVhi+ZDV92mvKzEo7HhOakyVaSbTq3bLhwlbT8gqeSjA9ZZlJa3rcKjYaJhJptO2Szpvv40thC5fGaX/wLfjvYp65b0ZNMLiQjAjsugyESfC0uFFGrzlNguP7WABswAJ4c5UtC2c+ZBapRVaeG4yBE6dH8nwHV1g3xyWACbG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUMmkckljTvipjdIITFA+cpbKKjhnRlJhgcS35RolBY=;
 b=OEjc5dzgZ1lNQCULCzb96TzXHIH/yeis6xj7hoRQm8TwWGrgDLhm+Gi1xWQQLn7w0p0EKkGrhzC286mZQC5dXxD3wqBVXzYqstUx7w4N4RGrLRlMfdzR3qQhkL3t4MMi5I+eSSGuKeAmady+MvjKaWiKTwLeMq2bzgXj3uVb8x0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 7 Jul
 2025 11:37:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 11:37:39 +0000
Message-ID: <e4c00d13-9d53-4769-99cd-70b977556e7f@amd.com>
Date: Mon, 7 Jul 2025 12:37:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 20/22] sfc: create cxl region
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-21-alejandro.lucero-palau@amd.com>
 <20250627103828.000000c7@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627103828.000000c7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 78763a25-b261-49ee-be1e-08ddbd4aadb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHdpQnJseWZ0Q3ltUk5JT0VJRXNJZFpBbWcyYTVQbldoSWkrUndQYUxBOWps?=
 =?utf-8?B?RVFNbVVpQXRMYkFTRklHdE5kV21mYkpWMUZhd3IwSlZOYTREWmJOTkhFY0tV?=
 =?utf-8?B?eStDc2d6NXlObUhma0hYMm0yS29GUllrYkdyUGtZL3JRSEY1RzhoUkhrVW9w?=
 =?utf-8?B?bGJkZmJRWjl3bW00elVaeGV5dk96Y3QrcHRqSmFyb3BQNlkvY2xOWWh3T0tw?=
 =?utf-8?B?aUFTcjdLL0ZKVm01cDUxa2lubm5ac1pDYlhsZzJOdVRtUU50ZDYzeU1ONzdj?=
 =?utf-8?B?MzloT1VDbEgzM3RTQTdqSng2ek9aRnBXaG1UUlp6VlNuS3hROUUrSmx5Z1hR?=
 =?utf-8?B?eGFSWEM0NTBWK1lHZ2JHWC9uR1FxVnIzVXdjM2JNaCt6eWl5aGNBMUJxNEJN?=
 =?utf-8?B?M1Mrd3AwRHE0M1RpRVV4VmhoMTZNOUFwRHhDdUpWaHdiMnd6MHJBU3kxdVNv?=
 =?utf-8?B?UGRqdnpMRnpPVTY3Z2RsLzdBdEdvZDYwcVd2QW1ZZCtEM0JybEFNcm90eHl5?=
 =?utf-8?B?bzdkWUFZa1FqS2JiS1dSM0pZT0JQZDlRK00ycHI5bk1UL2Y2aFlsSmd0aXJK?=
 =?utf-8?B?YTN2Uko3OUhmYjF5dnNNV1VHSHJmc0s0ZnEydlpDU1FQNExjV2p5VjNFWHJ5?=
 =?utf-8?B?dUdJNzhiZ0x4ZmZNZ0d5eUJKR2JWYnJpQktERUR4TVBCdEswRUV5TGxhd2xD?=
 =?utf-8?B?eHRIM1dLVnZRWDFrTnlaUFU2VGxPazRFWEkzY2tTY2ZkeFhDWHp1NlExOVRE?=
 =?utf-8?B?ellSRkhLcWcwc3cvYlpoTjlNOEJ4MXR4TkhyOHl1M2RnVkM3QWF5ZGlRY0xO?=
 =?utf-8?B?RzZodUcxaEM1Rjk3Uk9QeHgzcCt3VERnVlM4MmdNbTVrOTI3RWx4K205TWgr?=
 =?utf-8?B?U1I3alF4TU5rRE0vUldMUkdzbEN6cnY5QkRIcXNrWUd0ZjZuTkp0OWk2Nmt6?=
 =?utf-8?B?T2dtTHhUejhSSzZqazBvMVdMZnVYOE0veDgyN3hYTDFMekZXNkdINTB6QjJt?=
 =?utf-8?B?cm95UStXMmpPZGRrZ1dQYlVRSXNUTXdJbE81TmxqQ2IxdmRRYkhDZlhzTEw1?=
 =?utf-8?B?RFJrRFduV0tldUZBVEFuRkp4a2tvTllleTRXbitKOXdFd2p4dk1GbEx0TXhF?=
 =?utf-8?B?RXREdXJHWHd1aXQ3ZklWckpIbEdFWUlTczcxZmF0ZGpvZi9WOFFDbnFxL2NN?=
 =?utf-8?B?Sy9hOFkxZ096NEx5UDZDV0RaN2thVnN4allyTDJqdVozRjIvdjNQb0hIRFNt?=
 =?utf-8?B?alhMZkpIL1kwMG54Ry9menBPVk9Od0h2M09LRHRBOWRXU3JaOG9yT1FEc3I0?=
 =?utf-8?B?VG8zTHIrSndqR0ttN2hCbWJyL1JjeWM2NE4rNUQvdm5jZkNadkJzQU9Valdv?=
 =?utf-8?B?eWx1UWdFeENOaDJlZ0xaVEUvRUw0cFV2eGNhK0dWblBJY0RrQWIraEE1U0xr?=
 =?utf-8?B?clVMazFxdTlHTXRPZWtUdEJYYXdkUEl1UmF0UTNaN1N5VlRJSTNwRVoyeWJs?=
 =?utf-8?B?T3ZmK21LeGlHRHRSR3dSWmRwL0ZiU0FTdU5sZHdyS3o5YzZFWnQzbkg5ZDhH?=
 =?utf-8?B?STFtZmN1RHhCQmlzVkYzY0pJbnFLckNESlBQcjFaaHRNdGdjNmhwNmFuK0tS?=
 =?utf-8?B?MEpqUGNpU3R2V1JnMTRFMnd0aXVCRWo2cmF5N2lkYklXbzlvRVUwUE5XSHRC?=
 =?utf-8?B?THF1TkdjWldQaXpjKzRrdXV5TTR5ZUJwTHJqWThoNGh1NFh5Qzh5NVQ2Q2tM?=
 =?utf-8?B?OVd2UGpVb1BmejhwL0l1RmxPb3NsUVY3RS9EVDloR1R4TWVzTXhzTGt2cFVj?=
 =?utf-8?B?T0hSSlQ5T2tES05lV1NKZEZ2YjZocGhqZlFudG5JMmNJT1dKaTdPc29URURa?=
 =?utf-8?B?R0Jic0lOK2Rzcm43elFzZnZOWmt5Wmc2c3ltYVo5cldPVHZDK3UreEMxMUxj?=
 =?utf-8?Q?GM9v4BSiin0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDBUOFI5a24vMHVGTkFKL3FiSHFPWmwxZ1FhNTRuT2FnRmJES0RKbyszTkdu?=
 =?utf-8?B?bHBvSzhwQ0lzODRVSXA1WERTM0RCb0xuVGNlTFJFbFgrYUZ5UG1QR2F0OUM5?=
 =?utf-8?B?d2FQVG5qd0Y5UmxxUG1BREtCOENuaEdLSm1UM1dudUdUYWRZSE04QWVQY1k5?=
 =?utf-8?B?bUdaY0xDMEs0K0diSHl1RVNia1BVbEJZS0tkTFdwWERoNmRNTmtUWnRHOU1l?=
 =?utf-8?B?UjErK0txSHRhRStFWjBkamJaNmlYVTFselhmY1E4V2g5THMxUWJJQmNPNEtD?=
 =?utf-8?B?RVVxazhIQnFRNlNKcVdaTUV1SGFiU3ZZRjNLMnlnVVFoUzgvSTMvUEE1VUFX?=
 =?utf-8?B?VXptVlM2ZkJCOURIeC9YUnNaYUNMWW1XbElHWlVKc2hkQ1VLL2NGQU1IKzFL?=
 =?utf-8?B?aTc1K0xWNDRRUXJHQ0lydVhFM2ZkaTJFUms5MFZGMXZ5anJWT2NmWU5IUDlq?=
 =?utf-8?B?WmtTZ3BNcWpVRlRLb1c3dmFTdHhRSmNuN292c0RCcEdEMlpxMTJWTjd6aUdK?=
 =?utf-8?B?MjBzQ24vRG1xZ3RwRzR6dDh1SUpTa2FvRFZJaFVKQUpKeitsNmVsTkVOOHly?=
 =?utf-8?B?aDRLa3c4emU4NXoxREpXVUpZM1lUTmhnbzFSalFpZ2JFK3dzZGNZU1VselJa?=
 =?utf-8?B?UElwbXpHbTQvdncvYk5LcVNKaDN2bTEyVmk2ZVAzUTV5aXNYR2ZpbjBRRkVo?=
 =?utf-8?B?Q09ic3RUZVUyOW84dGd5b010MTF1ZzhtMU1RSzJTQndVU1pDL2tBME9WaVlL?=
 =?utf-8?B?T09qVTFHVHgvR1FCWU44YTdRb05xb2pVY085MDNkM1MxTi94RHU0ZnlocVBT?=
 =?utf-8?B?WjhMZERBTjZYTVNONUNKS2JkTDJZWERSRGNabDBtN2xBMGhOYUlWQ0QyVHhU?=
 =?utf-8?B?b1Z4NVhDbmtGSlJhQU1jTTJCUjZZR2JjQlZIRlZxNXNrcXBCN3VaM0Z4bjZD?=
 =?utf-8?B?MlFVWGpGYnVOOXRsdVZNR1R5KytoZHd0YVZXMk1oV25yNUJTc2dDT2hlb2hM?=
 =?utf-8?B?MExpd3VMSzh1bmxnd2VBeEFxaHNjL1FHVE9DQm5lSWNhcGx5OE92VFU4Ri9r?=
 =?utf-8?B?bHFJU3B3MmpBZjVzK0pUYUl2UVQvUFVzWUQ2bktVRHl0WXBVMEZSZ2JIRlp4?=
 =?utf-8?B?S0dDTHN1a0FOUjVGQy9JT3JkcmU3VDJqT0ljY0NuaDl5MWp6R1pEQ3EzdXZp?=
 =?utf-8?B?aU5UZi9YeVZZaHF0RmFvQUxvUkZKRE5uWko0RFZBYytUME5FWktCbFVVTDBy?=
 =?utf-8?B?bTJ6ZmNJdGVkSkJSaUluanM3T2grUEw3ZS9ZNUEraG9uV1IyYklWYVZaSnBx?=
 =?utf-8?B?RFhHcmNjVVlXTWQ5c1Y0c29Ebytmc3ljRk9ZZFF6bS8rMmdYTUFYSWFpNTdG?=
 =?utf-8?B?eEEvd0Z0OEVlOXlSbXF0TWJ1Sy9xOEY5OHFMNklJOUF6TjJSTkhpMk1WS0NY?=
 =?utf-8?B?eTJjNUpyVG5XQ0tSdElURnJwMDA0MndDbTZJRXN3UTV0TzdXaEhDVkVLYVJN?=
 =?utf-8?B?MmpDMFVSY0hpNUlVNTNlWEY4dFI5U0JjYmZFbDNVcDF3T25iUXZyaHFEaStP?=
 =?utf-8?B?YjI1NlRxN0tRTy9sdmlieWo4Rm9sZHZLc25nNUd2NmdieEI4WUpadHE3Tzhw?=
 =?utf-8?B?TTFGUmNkS2c5MmNtdVI4YkFHbW55c3FONWhmYlpvK05sZDREMUNRQkJjbEZx?=
 =?utf-8?B?a0g0ZGJQcDRZUU5ESWhuYlEyT3g2SEUvMlJvalNWNGFKRk53UXI3L21HYnNa?=
 =?utf-8?B?cGVCZUl3SXdLay9aaXVIQ2pEVG5LaHBaQzRwVWNEeDRKa01EcVRQSzhZdFRZ?=
 =?utf-8?B?aVRNaUtXbmoxcFNFd1R2MFl6V2M5ai9tZXA3SDBhMTNPSkRkYi9TTTBXZ3Vo?=
 =?utf-8?B?VDBBVFVCa0NRbXFoVm9pc1VrVlpMWUNiNzQvbXlnWVk0SkZEMmVIQXd1b2pX?=
 =?utf-8?B?TjZYTFNSaEU2WkZEOVpkZ2pyRXJydC9qSFNvWHljK0F5RVIveWp2eE5aS1BS?=
 =?utf-8?B?Z2FUbnkyOHN3REJpQnV4M3cyMm40NjJXeE45Y0dSR1RDUFRKWTNnUnFIL0p3?=
 =?utf-8?B?TjNVYXl6YjdBT1dIMnh4MGVNWlVzME9ZRS93YjdjeXFzUzBzdFR6L0ZNaTlp?=
 =?utf-8?Q?jIKTo3cgMncg9V92nYZM/9pxK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78763a25-b261-49ee-be1e-08ddbd4aadb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 11:37:39.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYGGl5glpUs7I/o+TrUakn4BGF/63/vZW9GShRouG/AX92oVAQvAxy65eAWecpnbUKq//Wxi6hR5wQAR7xOV+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537


On 6/27/25 10:38, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:53 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for creating a region using the endpoint decoder related to
>> a DPA range.
>>
>> Add a callback for unwinding sfc cxl initialization when the endpoint port
>> is destroyed by potential cxl_acpi or cxl_mem modules removal.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 24 +++++++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index ffbf0e706330..7365effe974e 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -18,6 +18,16 @@
>>   
>>   #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>>   
>> +static void efx_release_cxl_region(void *priv_cxl)
>> +{
>> +	struct efx_probe_data *probe_data = priv_cxl;
>> +	struct efx_cxl *cxl = probe_data->cxl;
>> +
>> +	iounmap(cxl->ctpio_cxl);
>> +	cxl_put_root_decoder(cxl->cxlrd);
>> +	probe_data->cxl_pio_initialised = false;
>> +}
>> +
>>   int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>> @@ -116,10 +126,21 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto put_root_decoder;
>>   	}
>>   
>> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1,
>> +					    efx_release_cxl_region,
> As per earlier comment - given when it's released, I'd register the devm callback
> out here not in cxl_create_region(). Might irritate the net maintainers though
> as it would be a devm callback registered in non CXL code, but I don't think
> that is a reason to jump through the hoops you currently have.
>
>
>> +					    &probe_data);
>> +	if (IS_ERR(cxl->efx_region)) {
>> +		pci_err(pci_dev, "CXL accel create region failed");
>> +		rc = PTR_ERR(cxl->efx_region);
>> +		goto err_region;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	goto endpoint_release;
>>   
>> +err_region:
>> +	cxl_dpa_free(cxl->cxled);
>>   put_root_decoder:
>>   	cxl_put_root_decoder(cxl->cxlrd);
>>   endpoint_release:
>> @@ -129,7 +150,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> -	if (probe_data->cxl) {
>> +	if (probe_data->cxl_pio_initialised) {
> Doesn't make sense yet because it's never true yet.  I assume the code
> doesn't always fail in a way it didn't until now?


Right. My problem increasingly adding functionality. With now the sfc 
driver able to catch those potential cxl core module removals, the 
unwinding here needs to be based on this other check. But that variable 
is set by the init code in the next patch. I'll do it here in the next 
version.


Thanks!


>> +		cxl_decoder_kill_region(probe_data->cxl->cxled);
>>   		cxl_dpa_free(probe_data->cxl->cxled);
>>   		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>>   	}

