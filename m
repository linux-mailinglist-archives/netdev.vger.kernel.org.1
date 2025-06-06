Return-Path: <netdev+bounces-195448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8BDAD035E
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B775165733
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4689A288523;
	Fri,  6 Jun 2025 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vcmcOqkf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A601E377F;
	Fri,  6 Jun 2025 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749217173; cv=fail; b=eHCDBAB+3ICQEyUMUGrQT8QeVGmz32iDAxn8dFoZBpGkb0RJP28Wl0x8FIKzCdsGJ5l+xHvQQCVdpyOXjT7BMmgZAAO73VckPnwkDq7BkE5/8N0gqUYZD721OYgBzyZJl9PiDUZBNxK/iv569L/eUsCOauEx6xvCFsbm3F8Bs58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749217173; c=relaxed/simple;
	bh=q1bS0cdoduxIw/b/8JKQ0fIBeSoc4C/uvIYxpmn8l60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lu7hLZ+mJWm6E7FvXsunEWnD9GPdlTdYUG7TCiDDiTsaTDPobx2zGaAlfBlgQsMotBN4y+YnP5XwQVQCoXKaBlWinc08BNL2aDl7Z+eRPYGt7MbdLHk/LDISEK780GRl72I4K75sJUimicxutna//q494V1yjXuB+Yf2iLgK0EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vcmcOqkf; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARDnXNNeoCjWyRCRjnpXz2Sc74flRZ3F4uzIfJbQSij1zHsSetUq9cJtHg3Cbithl4NPa0uI7UTR2Alts8LiIrSAn07GP7WRbZ3KHWYjdwM+aSlHuyC7R+0TloN4ilcQpWiRp+QAmGDcNCBzrggykwbDqJguqfnyOpE9f2+UcuOElp2+l7ILeh5LIsSPMk7FLnXLr/zabtgmAy+3VyDZKQx1gEjgugaeysEbSXalW+TmdtdiyoePq0bU7xpXKd49ktv1wcDnewGotnyAFBbab65+2HaJ9r4cvxAexFs9zWQylNuqeOVopdZdoMJ4+7H9E+DD56KhUU7iPRIVF1xKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaBZJ8mkjen7s2aOqjWyJfv5nHueSFMG0s5OhS97zp8=;
 b=wGAhgHiR7zYDMKZ0huTkpYpHe3vhjPop/8/GkH/hRTw+x8XaFc2vPkL0wB5kFtRngM5GkMGHAGWKM928dqMpbe84ul/8JnuKd2RGbvSyw2YYMgT1GNm4t5Ar4rhfwk8l+KUhjgJsiMUGOZE5wYBLPamxUY+arUVUd5jyijB2gfxYHicoJdre4G2z3KqWpcHiuq3nrQeGspCnjz5kekntr2WvZ5N2N2CjHZ3aEgtzIbYD5ouxMFDNWFA1jtnv0ke16nanIIGnRvx6JK79qXd0BL7wTtrOPR5bocTdj9oZv8B0kEbjiWG+tHgq9mnHvjrd4BYhUAQllyhUeFppm5uleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaBZJ8mkjen7s2aOqjWyJfv5nHueSFMG0s5OhS97zp8=;
 b=vcmcOqkfz/8GkyGj8R/6xvoCFt5taoijCh+65et88IawVi/wNBvTYzFR2ajnnL5hJR3YmHiIpuorlH7OPJ1Nizo4A2pAQjrlahEhMuzN5NyG/xjD48Y7jlByjSj9qy3yxbArZHq7a0A84nYevO7eGzhZTO8kYyIGCHXVza0Yp6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 13:39:29 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8792.036; Fri, 6 Jun 2025
 13:39:29 +0000
Message-ID: <894872e2-668e-4c33-a701-5dd641abfa5f@amd.com>
Date: Fri, 6 Jun 2025 14:39:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 19/22] cxl: Add region flag for precluding a device
 memory to be used for dax
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-20-alejandro.lucero-palau@amd.com>
 <682e3c7129fb0_1626e10062@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e3c7129fb0_1626e10062@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b14fbf3-5981-449e-a9ec-08dda4ff8f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmVFZWI4Q2lGMmt3M25LTGlqR2FBbU55QVRwYUxmWlV4QjV0dXJWYzVwY2FO?=
 =?utf-8?B?NEVqb3lIRHZSVHAyY0NqZ2oxdWVtMWtWUkl3TzF6c25HUFY4TDhYSGczTnp0?=
 =?utf-8?B?UDR4RTRRRysxZW9oOFRpcldHNjVaZ0EvYVRPRTVsYzZNamhTN2p6WlpCNEg3?=
 =?utf-8?B?OVZBU1ZhMjBwSW9LSEsyTG9pcXR2aEphMVh4N2h3b1dzVVg0eEVSeUgxVGl3?=
 =?utf-8?B?c09BL3dvanIyNkxoOTRNMFUyZXlDR2g2dHAvaGZGRUlXbkZvVzJkSVZXaWNh?=
 =?utf-8?B?dFRudjJFL3prbUVFSnJONk44TVFyaldiRWRlTjNIMXJwcmg4UjFHcXVMeGN1?=
 =?utf-8?B?RGJGZTJZVENMM0xnTmFRL2YxUjFrZWdqQUdRNmJuZjErTWhHOWNUMkN0cTE0?=
 =?utf-8?B?aDlxU1JqVFQzeXpiQWNnd3pZelNySzRHZjRHaHprQW5PSTRBekxPbkxpeHdO?=
 =?utf-8?B?Ny90bC95RkZtS0tEeUd6RXU5Ry9ERmVKL3RoakRHb3hqdERDUm50TW9EeDRH?=
 =?utf-8?B?aGw2Q1ZiWGhXU1h3WmhOUUhKKzRmUTI2NVAwN1ZDeGI4MVpHZVI1Wk1hSDlG?=
 =?utf-8?B?MkwxaTE1d3A5RCt5bU5KNkhJbU5DUnFpN0o4UjhZZS92Q3JiSUE0ZHgrSmUv?=
 =?utf-8?B?bjZvVFV4OWdGSHFHYi9nNmc3bWx5L2JpeFhqS2hJb0RlZkt6UFoyaFVQbTBM?=
 =?utf-8?B?WFNVeVdDTmhCVm9WYmdJNXhoRC9HaCtFbmU2VE11UjhMYVJkRHdObjA1WWl3?=
 =?utf-8?B?WGhjWFRDL3cxM3VjdHp1dG9DbjJTMGs2SDhMTW0zYlF6bmFUUzhNMmVCT0dV?=
 =?utf-8?B?NFNJTVRHKzZxdHNTQk4rMzJnVjBzYUtkRjBneldyL3VlNEJJVW9yZCtldXJ0?=
 =?utf-8?B?dlBtVytRVmZ5YXdNU3ViWlZDOHpaRDdxcTNZeGMwajFEVHl3RzBjeXcxL1Mr?=
 =?utf-8?B?TFc1WUx5aW1qQWpmTmNIeU4wTDd3SmdCL0o1NHY3T2l0L24ySXFMU1dFYlN3?=
 =?utf-8?B?ZUxSNjJZdEp5cFlabjNtS0lPbDY3dWRFVGdDSHJhejJnVjhPU1RYZkY0U2dw?=
 =?utf-8?B?NjgwWlJnbUF0VkwwTEltaTcvSVR0bncxRjhzT3pmUXorbDJBSUtDd3Q3emJZ?=
 =?utf-8?B?dUJ1ZDhvMHBENVVxNlhLU0tobzYwT0VVVTNkN0lBZXhzaWtTcDdYd2Ztc1Q2?=
 =?utf-8?B?bHNjMDdGRDl5M0lDQTFpRFBJSXVRZndsUkxhUzVKek5mWkJmdng2eHJvQVRF?=
 =?utf-8?B?K1JET2JKRVBDOXlOQUZkMmdZSUVBSExBN05EWmZRWlU3amMwYjhFa0hqZlpX?=
 =?utf-8?B?WHhYY2N2aGFOb08zRHRyRUY3UDM2ZUw0NlZubDRiRU1LcS9vR2gydnZ1MkUr?=
 =?utf-8?B?bEE0bmQyS0hPNHk5RlpnMnVBWFNuYXdodGVpa1ZwODJkZ0pEeWxsSDF0SFh0?=
 =?utf-8?B?VjJZcGoxZWN1b0p4WW1PbHB6WXRXb3IwTldYK1V1eVIyNzliSkIwWVBsWkl6?=
 =?utf-8?B?b0pGTndhRG54U08wT2NmaS9ERmxrQll6NHZHVEZ4elB5VTB5eWlmcjE4b0VH?=
 =?utf-8?B?YlpoQ1d5MW1mYXBjWU5yVFd4RXFhQkZRa3hpQUptZGJXcGJQTWNqdE5FSW52?=
 =?utf-8?B?MXh1cFRreWJBSEh4ek1WbjdYVUJtcFhxSE5ZSTJia2VCU293K2k3NUh6UVpK?=
 =?utf-8?B?Q3dNeUhqdTViRkFYRUt0QitmNlRUTVlrVWIzTVZ0RGQ0Rk9JMk5vd3EyU0NL?=
 =?utf-8?B?RjVMQ1k3dS9VNDBZS3hoUXI3M1kwUUFwdHcya0tCbng3bHB2ZGtqYWNydXRE?=
 =?utf-8?B?cTZwbHhrQjdRT0NVakFmMGcxWDNhS0V2bHhGSDN5SDA3S1pkMlovRjNyZWJW?=
 =?utf-8?B?djV2WHRNM1JPbVpzRnZaK05GelNMV1hJcmcyMGZmN0dNT2hBWkMwdHdZZHdI?=
 =?utf-8?B?c2ZpdEpjRU1Md0FRbEk3b2NEeWZ6SklrTlBpTXpoTU5pNUszWTVFWjlYc3Vt?=
 =?utf-8?B?aVduM3Q3aEZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SStyK2E5TmJWWEk0emk3THdYU1VCeTEvVGdqZnFoWjZtd294YzBmYjdScjFG?=
 =?utf-8?B?RlJnTHVEWnZFUUZHOWlhRXdreEdjdUlSckw0SXRoaURlTjVGTUxGS3A5SzVJ?=
 =?utf-8?B?UDdRN1FzWFRQUTcxaVZBeDdDSGVIZjRveGU1NkxqYlp1c3ZpR1U5ZzFsb2VZ?=
 =?utf-8?B?aDh1a3hkbm5BSkdMck1EaXYxVTljdkhoMVRuK1pQUGhvQ21IV2xRY2E4MkxG?=
 =?utf-8?B?TERlRm00dkFCcDRkMGdMZFZjR3pSRU5EdkhaWWVLQ29aMjdKRjUyT3piR0lz?=
 =?utf-8?B?b3VLalc2RG1MSWhJajc1d3dQYjdFdlhwQVhNT3E1clBVNjNjYXVaMlQ0d1lE?=
 =?utf-8?B?UmRSMVZzcmpaVmM0SjduQzUydmFCMlM5eHY1eHgydkk5VGNYY2g5SWVYWFU2?=
 =?utf-8?B?SUpQMlczSTNFajdvOVQ4dVE5NVpRMVRaeEJQZ0Z5dFhCT2tnTkFodkpQUTcv?=
 =?utf-8?B?RVNHdC9sNDdydlU5cTRMQVl0MHV1SmZ5Z0hPT0pvWkN4YkpvWUNadmRDWGNz?=
 =?utf-8?B?Y0xyeG1UWXArcUtqUzNBN3VQN1dXbzBPZ1NZNWFiS1d4eVlxeXJMNFFEQXNS?=
 =?utf-8?B?dVl4ekxZU2FQOFAvY3VlOFYzamhsMkhuVHQvVWp2TlRTbm9DMjV1UG5ySHNM?=
 =?utf-8?B?ZnVVTTgrdmxxMHdDSkE2aU44SlJFTDBGRzlNVUNCdG1ZaU16UUtFMm83cXZY?=
 =?utf-8?B?aEh5dGhRQmRrSkxPZHMrRWtmMStlUU5nWk1mUXR5bk5jTDZLYmdkcHdpVjcw?=
 =?utf-8?B?M3ZaU0EyNjVhMlM3UFFjYlZkV0dtaVhUVjhubWQ3WjNVb1JkOTlzN3E4RXhP?=
 =?utf-8?B?VmJsTlRHMVpHd0ZFa1NBSFNkYVpXVmx1cVppVFlQSkpaUFhJdXhkV2JqVHdQ?=
 =?utf-8?B?NjBvZUVTSHhCL01FdmZ2S3FXQnZPSEVqQURFYlJ4RG50N2luTml1ZXdGR1dR?=
 =?utf-8?B?Vk1Tb0pqdm1GUCt2ZFB0MkhYYmRWeThyNEgrNU10WUt6TlEyb21YK3dmU2VQ?=
 =?utf-8?B?MWdTNTBlaFpjYnNMZmJiYUNrdER6Vnd0dWZzcDBSOEo4cXNpR3hwQzNGRkxI?=
 =?utf-8?B?K05Sei9MeGREMmM2MWJpT21OTmlxSDMxZUFqUUw2aDVHR3Zsdm1jRk9Qc3hM?=
 =?utf-8?B?QTJESHh1bURUWnB4a2lwNGhjb0pLSDN1UXhqQzRrNHNLVzFlLzFwYVR5OVZu?=
 =?utf-8?B?SnZ3ZURxenhoL1JITWNMRXdzYWsyYmF0SkRoUmduSENVMm9XVFY2dHh5bzJQ?=
 =?utf-8?B?OGtGR2pDSnI1K0JFb0xHWFY0Ulh4Y0JKbUI5SVJ0WW5OV1ppWGJ4aU1WbjBL?=
 =?utf-8?B?L1JCQ2lHekFFcW5HNFplNlU0Yk1nMnBOTW56L3dmOGdGc0Vob0FlVHA0MmY5?=
 =?utf-8?B?ckh4UUVyeVJVVGpmT2lSRWFGeFQ0cHA1NlBPTU9YbE9BV2pIVldTMGtrSEIw?=
 =?utf-8?B?V2ZhN1RHT3ppWnNiNGxtd0ZkMEo5eW1LeGFFaC9Dd0g1UFhIS05DcHJQd0hv?=
 =?utf-8?B?K2FiZlNZWnNMYTFEVy81UjJ6V1VFTUF1R3dkZVVGbkdFdDJMRHNyQ1VxVFds?=
 =?utf-8?B?NWtEaWZJYWFqYnRwTFgxdFFPVXprNXROUHE4TFFDMUNEeE15UUpXcElMVGpy?=
 =?utf-8?B?T0Y3STBzcWRHUnRyT3VMNm0yamM3NWtTbFlFSmRMcUYraWdFK3lxNktqdzNq?=
 =?utf-8?B?dXdpY0prTnFoSmtYTXcyWnRUV0tKWE1yd0dmMnAvcENoeVJ3USs0SUQ1RXhK?=
 =?utf-8?B?V3V5VjlYYUI5NTIwb1FhdmE0bExxR2lHYTdoTzh0RXhmT3lYU3FUUnd6dFFs?=
 =?utf-8?B?ckRGV2o1T2RYaUJGeURxM0I1WmtqeW5RZWtjU0VsTDUxV043Uks3Z3NYYUpw?=
 =?utf-8?B?ODFWUGNTTjl1Y3YvWThsVXUrcEpKYlpIYytWVXFLYWVJYmgzdzJTSDMzY3NI?=
 =?utf-8?B?OWpNMzF6QzFmWEU5YjZCZHFDMytWa1lreGRQMlRId3hBYUtjUjZLMG1CcXRo?=
 =?utf-8?B?aUpUUG9LVnpBY3E0cGhKNi9ReXNGeDZpam45NCtGbEVFMVc5eUpOaVdtR2dx?=
 =?utf-8?B?QVpEWEpib1pzNGpXZ0FSVVk5UmFML0loblVsaWNianFoUFBiYnErb3A5dzFh?=
 =?utf-8?Q?cRqeGoAFmXEtFhzRJnvUhbCdu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b14fbf3-5981-449e-a9ec-08dda4ff8f79
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 13:39:28.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Up76bJx0hN+UlWkQKnxdH9BxBSzj55Qvbo22laCsmZbMh3UpXJsW/LN+2oULOAHFQmUojqGNJ3GbZlW+8qlXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754


On 5/21/25 21:49, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
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
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
> What was wrong with the original proposal?


It was suggested that although this is the most likely requirement from 
most of accelerators, it could be the case someone happy with automatic 
dax creation.


>
> +
> +		/*
> +		 * HDM-D[B] (device-memory) regions have accelerator
> +		 * specific usage, skip device-dax registration.
> +		 */
> +		if (cxlr->type == CXL_DECODER_DEVMEM)
> +			return 0;
>
> I really do not want the ABI presentation policy layer leaking that deep into
> the region creation flow. Another way to determine this is if devices
> hosting the region are not driver by the generic CXL device memory class
> driver 'cxl_pci'.


I have found a problem with this patch which precludes its goal (no_dax 
flag set after region probing). I was going to fix it but after your 
comment, I will just drop the no_dax option.




