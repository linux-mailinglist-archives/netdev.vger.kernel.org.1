Return-Path: <netdev+bounces-179586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEDCA7DBB9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDBF188EBBC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48516239090;
	Mon,  7 Apr 2025 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IDtwVrcO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A622B8C3;
	Mon,  7 Apr 2025 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023673; cv=fail; b=nio8Cb3ZjKMVEuaaqhyn5Dkna/RzcjIkbT2j/WjztW4dH0FytxMKha1IbJHwlNVRwIdoZJNxeGDFnQpkZ+N20xk4dr2EuO4GrPUdt6loGBQHpD1NaKFA5Yl7j8hPfrhScOGsUUrTKAl13nWnr82RJk7CJVBwSXf/jkpiLsGbUqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023673; c=relaxed/simple;
	bh=oWXqqIGj4CRxxHfywKLRcFzUeGA6s+HOjy5vYw1l4Q0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hnCzc0/A4aIUFyQDsBYUiJyejE3AsDdVq6+Nt6gA6MRD2DPZvSVgPQJH9y7vw0e578xD/l9gRDhmA6ypNmlk2SOgw6xuOqtedSqxFX+iqpLJrZF5isR1dA9bCnPzTS+UITC8Jhap+6Y4NU4gwXp+TFIjrAMPMlev+BOe081A3CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IDtwVrcO; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDXpuygNf2o0YkTH9AmDDADqGRn+n1cwWXVTAd3Yo+Ab023b9b5sM3AEf2qIyFFGIn/bFEx71kef3sXpjG5wIjFBih8L3BT0pZMwGPh9rM8hvjUjYTbgmlaWDU5ieommIISSngO7uDm6Q5IqT+FSIOrdUE7DRhsaQje0PNR5Es36XBUBI1La0vnqrFEaf3DBwRVpwM/iDDIAKBuY8SL9wPVjcKnzWJcVw2xogdsce9UkNDZJlyvzmzXvn+Wum6jMUtsSIuVSRgX/l10xnoRQp0Tb0IG6w8B2yuDlGDvqSkQofxI/zHAbpJjMJPI3tTama0zmy6t8Iv/BOIScv0CIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfuibiB1WLefW1M7yIzYYLNYXfl5abz4PxR37hlzIM8=;
 b=gfZkSkUgKZpZEAxvqgMAZhId0JFkl88+pahjIoOc7lIiVcJBsq0VEA8RjQfa8744BAW8XCYl2RHyGDtfICxTFtE3z1KZeQcQyvCk83rVyg6T6prQBoZ2Eqr+rWs0EQ+UQIUpZ10bIzz5dIKwaw6HFP8IV0SlyEbzQTghpFrfQZW5zVuqqr5Azq+/d7EhRPjFvMOS0mFYb2cC8WGfcNWP8DmmM8FedCb/+8MbuWEqxQKA1cmvn3lW3u3uS+ZGG464NQEBK66NJG+54DR2iKOwuFxpiMgwePnwGSvBJ+z2tZhQFxcqlGOZry8OlrYCqn5kCy4tH/Z8XCCz7BG2LAa66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfuibiB1WLefW1M7yIzYYLNYXfl5abz4PxR37hlzIM8=;
 b=IDtwVrcOS5QLRxYCyzoul8jcqJoYqIjIhfG4FuwaKgi10SCeeVJqk1VAPr2bHRcSTJjO1dy9QsxS3xkaYoZ94Qj8yeCVZDRmKVcbDygCuii3aCbWXWSxew2NOGjJ4qDksniqlCurlb1NhpuzoViOGAH7R7fsKUYuMmjv4S/DvDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 11:01:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 11:01:06 +0000
Message-ID: <2b4963f4-0a1b-485c-8198-b9abf473f0ef@amd.com>
Date: Mon, 7 Apr 2025 12:01:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/23] sfc: initialize dpa
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-9-alejandro.lucero-palau@amd.com>
 <20250404171253.00002b41@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250404171253.00002b41@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0195.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::26) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: a640ca88-78ae-47bb-03bc-08dd75c37ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWUzZHNTSVhVeGpRdVRhc1FaL0hwbGU3RDI0eTA5SDF0WlVUMkhwTFFucVFj?=
 =?utf-8?B?c2ptRlJheThBVlBVeVc2bzZPQ2EwbmRQT0VoY25KSDVrZUErNmwrSzhFVFBE?=
 =?utf-8?B?UWRlU1YwV0lMVWRCYmY2K2pHeTlFOVFvTXFaZWFjMzFxN1lXWG9NMzBxZXBC?=
 =?utf-8?B?WkhPSXd2SDN1Nno2Wm9vbnFaV0ZveEhXWERscTdmb3h2V0RyNWU1M0dCcll5?=
 =?utf-8?B?RDNTcC90MEJpcm5aQ0I3Z0dNaWFVS3ZpYklYRFFmakVoUmU1YVNGZnBOREFC?=
 =?utf-8?B?ZzBEVzVacFc2RFhpWXM2bW9SUXpnMW0zcy9PUm5TMy9JaDhFaUNSTUdMRDZ3?=
 =?utf-8?B?TUR4ZGxXejBNSndLcGZRWmhVRTJPYVM2b0hMUGl0cyttZU15aWVUenNlV3Jn?=
 =?utf-8?B?WHVjcWZackw2bVpGV3I4YjBWbzB0a1plWUxCc21sakFLTGdaV1RnNDl5TFEy?=
 =?utf-8?B?cTFxRnVPeUhpVE1YVjZKNnRkSC9xMVVKT3RidkU2Y253VmVkK3hscDV3Rzd5?=
 =?utf-8?B?aVp5K3VnUEZSdjZ6V3ZDcG9oNjBrSHMzbXoxeVA3bExuTFVzaE9oMlR0VlNB?=
 =?utf-8?B?eHBqeENvWmVNRDltTnJYeTkrWmhyT2tvVDM5dWNJMVBycjVzN1AzZk5ENGdF?=
 =?utf-8?B?bDEvbml6d3JuZ1p5ZWJjTDZCREwyV0FVWnNFQ3BpdGNuQ1h5aVFQRm16SjVw?=
 =?utf-8?B?V29UZm5mV20vOUV6Z2tBRjNCU2MxQ1NoMjV1TDRTSTlRNVZmTHNBY3NuL3dB?=
 =?utf-8?B?MmxNV2taN2pXYlhMSlhaUnpwdWx4dEN4SGNBSGwyNnF3N0dRN0x1anVJUzBs?=
 =?utf-8?B?UUFzVWZ3Q2t6WDhTcmZpU3RKSWVFVDBCS1pQNXlFdm5SQXNHa0puQTBxU1Vn?=
 =?utf-8?B?SDBCRlNUUWh1M24ycWE5MTJQd3Y5ckEvektaZjIrSFpTNGpYYWxCU1FKR2pO?=
 =?utf-8?B?dTJyclZab1YvTTdCaTJiQklMZmZVLzZWczVWRTFyYjBaRlY5L1g4dzRMbzgv?=
 =?utf-8?B?Wjh2SjRFNkN5RHJFbXM2c01jT1FhOXFpMDg1UlR2bkdHcFFseVgrQnBpU1M0?=
 =?utf-8?B?TDdqQmxUYkhoMjJEb3RObVRZQ2dkbEVGcDBqN2xlOHhvY1NHZVIwWlhwb29K?=
 =?utf-8?B?SWphb1FHWFdiSFpsMlhZdGFGTUpBUC8ybHdyYjBRQ3U1ek0rZHJuWjlrVXdG?=
 =?utf-8?B?dDVQMEVqamc5YWkrckRhTCtCWGpmL1JMclFYYnJjTFpxQkY1a1hrM290RzN1?=
 =?utf-8?B?VUdVVlB3VGhpVVBKbVlZNXhnaHFqV2s4Y1VSOHlqWlkrOHdNM3hzaTdRZllm?=
 =?utf-8?B?Z0dOcWNUYjBDNlYyZDZFTkM4aUJ0cnRSYjdSYmQwVHl6WDliak1pYVZXNjBP?=
 =?utf-8?B?V2kyOTdCcUVudlZuRHJ3UEh5MnQzcWtVUDd4Y25pYXJQUHF2VlovczhjOEJY?=
 =?utf-8?B?WHBnZnFHVklhRmVUeFpqV0JXUExqcWZkOE0xaWpZMDM2TzVmalFzT2lJSlVi?=
 =?utf-8?B?RVdueXVFbEV1OFF5MHlBVEs0M3VZM1FsWTlJRWgvSDhqS0RKSXUzNTliVkhX?=
 =?utf-8?B?dTA5c3BvYVBKYlY1ZnJVZG42MXUrSm9pMEtHdWQ0cVcwT1NiQm5iaFpWSkhN?=
 =?utf-8?B?eUxCWXhWMnNEVndVR1JyYStUU25Xdlp1TkhnQllrNTRUU2xJL3JzbVRsdmF4?=
 =?utf-8?B?b1kxcjh0Nlh6dTRjQzNNOUJ1UURpdTRvSGhjY25qd1hEczZqbkVkRnFqVDQ3?=
 =?utf-8?B?Zk12MDQrdGUyQ3g2V3k2eDJ3c2VJVHprVDVLYzdHUHVCd0FrNWlnci94Q1ZB?=
 =?utf-8?B?NHFIcWpXdW5MMk5TbFU0ZlQrdEFSaVk5QkZ5cVJjc25mZzM5YU83MDY4MDd6?=
 =?utf-8?Q?55IyHwF6C+ttn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUJaSlJjcnZJenRVbkZjeFRlSkJvMFZKYnlYWWVTcCtVVlpoM3YxVVltNDBw?=
 =?utf-8?B?UHRRWmFjVDQzVXlWRjlPcDRzcWhxWjRhc2FiZ2piQ254QkFnY3haTWZUQlQ1?=
 =?utf-8?B?Z3hPK2F3RGh1blNlUUJyNGdIN0ZjUHNrTWY4WkxvUTlDNEJFZkQ1eXBPRDZj?=
 =?utf-8?B?SmIzZG9XL0xLc21sc08vQkg3UmhUSUhValZPOEtzbFh1eHc0Q05mbG53a0VG?=
 =?utf-8?B?cXFvcURRWkxpa09uY05JQmFqaW5ZZ1ZjY1cvQk0rd3RscHBxNEY5MWlLR3li?=
 =?utf-8?B?UEc5QWMvMk51YnF4bXJEQURjSEw2b01JSE5pRDhHRGZnWTF1TDEyTk9tN0ZW?=
 =?utf-8?B?bFIvekk2dHZOc3N4MkZLdHIvYTRPbngvUitncGRDUlI4OHhHSDV1VmltL1RN?=
 =?utf-8?B?TmQ0Zm9nRTl0VkxTNW9LK3pFdEVNSklDYjVOKzJZREorZXBhNXhvUXhEc0xH?=
 =?utf-8?B?RFpNSGpyTEJEeENmQTdqZWpSNElFSS9MUlJMR2Z3WnFFSWcyQzI2eWJUVmFa?=
 =?utf-8?B?dkVQK040SDVneEtDaFRDYURTK1c1N2VkbEhGM0hsTmduMUFtVjl3ZzZXL2NF?=
 =?utf-8?B?TjRCTXZvNlBVVmVTM1VLMHBSeVFtMjlTUTJrK1ZHenlvdU1rU1BwL0JqcjNh?=
 =?utf-8?B?d1hRbGlnaFUzVW50cTVuMWtRcXRsYTR3SGJINlQ2Q3Q1dEtSK0xScWdOTWJ4?=
 =?utf-8?B?Ym5jSW50MUNpQlgrcEMzVzVMSDRaSWY1VmZGZnIzTjhJQXNkZHBjeXhaNlpY?=
 =?utf-8?B?c3JFZSsyUndDTlZzSWQwM1dCMlBNNm5nc29sbkcyeFkwd1l5RlRFd05zeW02?=
 =?utf-8?B?bDRINVJyS0tMQnpWYXBKYzUwaG5sL05MZU44VERWWnpBWlQ0VFVjUU94cHU3?=
 =?utf-8?B?TXpHK2RPUW9KTnZRRDA4YTRLbTBLcWRmN2VKaXBCVXVVYk9yYzF1RFovcldB?=
 =?utf-8?B?NVRlS3ZtV1c4UkhweVhoRTBVK3g3RGJuT2RLQnp6SHd4Mkh6R1hTSC9HcERv?=
 =?utf-8?B?cHViRFFpNHF4SUFPNXpTd01SM3JkWWlxcm5BRVJQbmhCRHZVbE1ncGcray9S?=
 =?utf-8?B?aDZkVnZ4ODdHc01zeFVJMTB3a0pTcUFPZ0NWZGpWb0RJVFgxbUEwbG1oSVBB?=
 =?utf-8?B?QUVDbFFTc0VKZ3htV1BnbTFBcExZM0RtK1BnWjdHOUlqS1RFQTFBc0Y3YUxy?=
 =?utf-8?B?NjdoN3JSOXR2YSttSEpQTXp1clhFSlZRcFpybHlxbUYrOXVrYzRueStzenhZ?=
 =?utf-8?B?U0RYZm9POTlDaVlDZmFUdWsxcC9XQ0VmdEwwOTYxMEJSOEtxazdFbjZEd0FI?=
 =?utf-8?B?ZjdKNXRoK0tFWWdBYzY4cjRaWmxGMWFnUHRnbXVVdUJDWXl3b1hNRjN3azBD?=
 =?utf-8?B?OWMzeFhXbU9Jdm5pT01RWU1acmpEZkI2Z1l1REVJOXJjWTkrdUllOEdleDZQ?=
 =?utf-8?B?VHVZQ2xDOVIzaDRyWU4xMkpGcWhzRlNndzM4K3NYWG5EbVNuNDFnVHM2VXFp?=
 =?utf-8?B?MUxkTUlSVll3VHJ0cHFRYTExWmVWb0x3SksvNzVEN1lIVUU0UWRDY01nMXZF?=
 =?utf-8?B?NksxTkc2Q2lMcjBKbENoOFI0bGZpbHZBbHJOQUo2WWxNcDBtcUFyUXlQYkp3?=
 =?utf-8?B?d045L1NTWlhNMUdwSU8rQmZGL3dXanZZYzRVaEV6d2FpS3VxVlMvbERvOWNK?=
 =?utf-8?B?T2gza2Q3UTI1dGthMzZUMEtqVWRNcHlxUHR5SVFqcFMxL3ZhU1dOeFZOYkxu?=
 =?utf-8?B?Rkx1RVZOdmpYeldodi9Pb2IybzRQbWVQbTVSbndSN2x2KzNKYlh1L2hxcm9J?=
 =?utf-8?B?dHk3U2g2M2NhZGg4VkJZRi9UZktpNTFDZ3ZVNGs2cERqK2dOTVNZK29USlg5?=
 =?utf-8?B?ei8wSVRuQllaMEhjcFNVaG9jNXlrYUhreXRSdXJCYmNtSUNTTytJU01WTXU4?=
 =?utf-8?B?UDhJVEUxSDVSTytXOVNJRERXM0FFY2FScnNVMTVLN3hMMnRDVFFxdlVDaWJP?=
 =?utf-8?B?UW5aZTVLamw3cHJvQ1J0N2NWZlNPUGw3QkhEV3VvZFpzNkNUaW1pR0QxQi9V?=
 =?utf-8?B?R1VHZmdNYU1mTGFkbytDMUUycVRWWHc3WEVNMHR4ZHpQZFkyUkgzc0U3OXp3?=
 =?utf-8?Q?NNbIAERkDlKIjR7He95zL4ClI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a640ca88-78ae-47bb-03bc-08dd75c37ec3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 11:01:06.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zv5tFSMEjAZnVCUp/q6Vxo+UkoFquOY3dZQ3joJLudNtO2DTN3zNqPx+drGmdC1sJKxAMQ78GX/0XbiNNiL0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281


On 4/4/25 17:12, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 15:45:40 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use hardcoded values for defining and initializing dpa as there is no
>> mbox available.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 3b705f34fe1b..2c942802b63c 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -19,6 +19,7 @@
>>   
>>   int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>> +	struct cxl_dpa_info sfc_dpa_info = { 0 };
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>> @@ -75,6 +76,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	 */
>>   	cxl->cxlds.media_ready = true;
>>   
>> +	cxl_mem_dpa_init(&sfc_dpa_info, EFX_CTPIO_BUFFER_SIZE, 0);
> Maybe it is simpler to just pass in the total size as well?
> Here that results in a repeated value, but to me it looks simpler
> than setting parts of info up here and parts outside of cxl_mem_dpa_init()


I think it is not needed once we initialize size unconditionally now 
inside cxl_mem_dpa_init().


>
>> +	rc = cxl_dpa_setup(&cxl->cxlds, &sfc_dpa_info);
>> +	if (rc)
>> +		return rc;
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;

