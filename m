Return-Path: <netdev+bounces-188973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B20AAFAFD
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36877986789
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98CF22ACEE;
	Thu,  8 May 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b/TgEOsp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1222154A;
	Thu,  8 May 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710002; cv=fail; b=lHeeSqNuRJCp+OLv3XTGMA9JDHNSAVSRTG+9SIa50cNZ0mndCuMkDqer837d151KtKuXOphLOGHlW8TOUP3SSrqDcR7+LdfCar9nLmzC+JiZj+PKybZgllY2Xp7aLhqoBHL7t9SvzlrSBdEbOSAmamIKsmZKJztaEl8jmzUBxtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710002; c=relaxed/simple;
	bh=TG+MpcDO6jwx8iGDQUjLSiWC7bkw1/jT8gIlf7BbBTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bHy2BQ2ZSkaEQVfwA0k98Iuo0Mh9mpATw3+1EVnmxroQhaubbZ0ZInWqghMUEN6C1v3QLvaLd6Qc9OjRLFzS7X8levHFwiB3OUny8eOhO04XyYtzkggQTh4jLtVKxTnL8xdF6gy0SXJ17Tu+NHbw1CgjMA3eM2NRalQLV/gs67g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b/TgEOsp; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3S/zBlKXLVU0vR/bLIoYu3ihXwHk+RAB6Cmmx8kY8mbDUEIqdsWqkOgi9JpyDhmirSb6AJS8g+aPwhZ5XL8mlfjnR4MXgMR+KEwsMhGmuaqnH6f4HqogHulk2AZSWhuPTm6UPXzClogVHUi6BBgEud4tSAdaJySNc2vFOWQ/DLGaeyXCbgahds6jj5Xv+5uSyaoVHh7BDK1S2J+lI5qETy4Cy5Q1wiM6p3E91CO0I6cqkLlnmgCMPu7ZsLblhhB9LV7S4pTwiQsDJjrdaiGVtk99rBaiR9v/nhmIWK9ZZCqTHMbvyQhNTcBvQPrtMAvtGHQUSySDIPPcRmboyMbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcfzDqc7thFU2oG0eGPDNf7oq5SGhRFkofbfvu6hfBc=;
 b=mIBFrMvkb0PW3Yk8h7IUaCgzeSRogk25xGbE+uBPVpgg4C6EJB9O+KCC9Gb4PdkqdN1qMoq8Bv4QLbZsK7le5bbN+WgmcZxGyWa24ch5r8Y5UTquMJgyaKNJ3Pi7BDAy4tk+tWuyNk9rsiRyRjq3bblHVwqnH5dp16j9gV3w9EXaLADwVAiMF6zkjRhuNgj6Rjxog6BT0LGrxbhH2THfvNHhM8eajNAx8Dyfrxk0ipJg0UkhNlRtAGy5AXFZ+IKXkQqo99SSa4MxQ01i7+sXBLyjYuTmS50TzIE94nXHZFjTfkOZKsmmJcRMve1FIIUqy96XDfNLeUTfgZNEih88Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcfzDqc7thFU2oG0eGPDNf7oq5SGhRFkofbfvu6hfBc=;
 b=b/TgEOspxLfS0g+PhWwUd6NQZnZmWvA8TaL2EkKpR4/zdgr5Inrp1Lsgu5bD14kM3VcWI22YTqzOup34L51ZMV+cUj+wv3y1i2iHRBtClu79Jex6a8theBAlvjCnl5EzdTlcz1Ajdu2dhW0RkgAHS6p4l2peaGc+7TFsQPgYeDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 13:13:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 13:13:12 +0000
Message-ID: <3471f4dc-66f9-40b6-8934-b7d6e791e728@amd.com>
Date: Thu, 8 May 2025 14:13:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/22] cxl: move register/capability check to driver
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-5-alejandro.lucero-palau@amd.com>
 <aBwA_CI5-eNll6Iz@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBwA_CI5-eNll6Iz@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0511.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: d2519c10-e907-4fac-f8f5-08dd8e3215ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkUxL2g0RGxaZHFPRVVlOEM4SWpodzUyamI2U1Y1U1JnVDczU0xNQllJQTN1?=
 =?utf-8?B?OS9WL1hJVVg2L2JQVjBsQllsVjRPRWp5amxRNTdVUy8xM3hyTEtkYkdWekJq?=
 =?utf-8?B?MnBpbmQzTmlNbUptNjlaTlJsa2hxVE1FeklOc3BLUjR4Q0dUWnoyVjBLNjVG?=
 =?utf-8?B?UU91clhHNWh6bXpYbzdNcnZqYXFaVG1qejRMVitpNitKdHJibGduYml1T2l5?=
 =?utf-8?B?ei81YythczVQUlN0Zmt4RnpBb2M3NmdYNGNOTUlRM0dsTzd1a0xnWTBNbHVH?=
 =?utf-8?B?bzB3OWMzM3hVb1RSLytXeGtsS0FxeXRsN2Z1WTNMVVhUOWlUblkyNnRML3Nm?=
 =?utf-8?B?WTZsUUhkS2VQYzg2N0taMWpmcFpRNHJxZzlDTlBCVzNnZWtuczh1M0ROVUNa?=
 =?utf-8?B?blZGMVJxVVRSM0kzQkxYR1lMNHhic2szVWNGQzhVU0Q0QW9DVHZwTTZvSHFG?=
 =?utf-8?B?TEYrRHBScXBCQU5KTDlVNmU2Z1hCMWQySzVNdkhIRnlVb05pdmhhSExBRVlI?=
 =?utf-8?B?Ry9IRSticGZsQlFjWTBNdXkzTm90RUQzSDRnRVJJa3hzSDB4K1RQbzFWRXpV?=
 =?utf-8?B?RXo4Vm5yUEhNTThxN2Q2OGdXMk94VEIxTDZZdG1ueEZEYVFOUHFzaXF1Mk94?=
 =?utf-8?B?dnN4aG9pYjFLTlkzdVZuM3BOY2p6TVpzQnJyRGMxcmx3bW0rTU5PUmVGcU1T?=
 =?utf-8?B?eHVER0ZmZ3pJMGQ0Q3JIdFRFVUV5WVppSDdNR0JQRnlva04rMnMzamVPWVg4?=
 =?utf-8?B?MDhibEd0U2dqVllSWnBtVDc4VnZuOG9tQWVCTXp1SkUwSXQwMXYvbmxFc0Ju?=
 =?utf-8?B?TW8rSExWZTJjVlo1SFpQVjc5ZTNVR0djb1BVY0hlS3RXbXd2cFg1UndDTHhL?=
 =?utf-8?B?MFlMZDFCZ0JwTFVxOWRuVFpabWVBaGJieG1ORE8xMm96ZEtVVEFOb2RwcTc1?=
 =?utf-8?B?a2ltdVJWaVh2SWdEbm1IY01FbTMwckRYd2ZFMU10SURidStvK2hwdVdPZkhH?=
 =?utf-8?B?dGE0TU92RHU0REtBbVdac0Q4SnpZMmZuQmgvU2pnR044RW5selFLZGZMclcy?=
 =?utf-8?B?ZFhLMTg3UmJmTEZsdUtRNWduMy92cGVXaVRmZWUrbWluUnN4ZjJGRlBsUk12?=
 =?utf-8?B?Qi92bFBkaTI2Znl5c2dodHdUME5YNHFyZmtLZUlOenVQcWJ3NTA5dExQd056?=
 =?utf-8?B?TVRNZ2ZjSDhiU2lGOTg1eEgwbzdwemtWRENudjNSVFhJUm56bHFuaUxIN29E?=
 =?utf-8?B?eGRDbFlkSjRseDNaamM0Mm9JQjlOeXc3UG4yc2kxQ1pJZEx1T1dNdzcyekZT?=
 =?utf-8?B?Ym5kb0RROEVrSjhrckN5UnlnL0FZMWVXbVphdk5Jbm8rbk9BTUg3bFI4dDRT?=
 =?utf-8?B?K0VKY3FiaUp3VVM4eUlGSnRFOE1QSHhQVnhCZlV6RkNiSGZjeGYwU3JCZ21T?=
 =?utf-8?B?VGZDLzNnVFozaXB4NjE0MzhsRDQzMEFGbXpPV2drbGJ4SW5FRUZKdU5lcWcr?=
 =?utf-8?B?RTdQVUR4b0dzOTRocmZ4MTNmb3JwUnlCNDlnK0M1bFFrcDdUL3VLemZDcE93?=
 =?utf-8?B?Q3BmOEsrK3NUaC9iUm5TOVNjYUR2MFBIMjFyUCtPSUI0WUhZQ1RLTzRsNFJh?=
 =?utf-8?B?ZUhvOVRNb0p0V0VNMGFBMEg4V1FqaXdpd3BBTnB0bkJYbTlNQ0Z6WXRCWkt2?=
 =?utf-8?B?bGpxdG03OG1uM3pocnJSNW9HSWhBdm1NcFhGL21ta3BuSWhmVGJBRXJVMVdG?=
 =?utf-8?B?WHQvNHJ2RVhkT3o2SjllMGsweDlLUlJQYTF3T1dDNjhLODFWLzVDL3ZFeStL?=
 =?utf-8?B?d283TS8xdFk5N1NMaWkyc3ZWaUJnNm5BcWtWckdYQUFJVE9McmUrd21Pci9M?=
 =?utf-8?B?NFQvYVRSejhoT2lpOEc5TjBWLzB3SWtqU0JoZE51eVZNOUNXcWZMNHZhTUFB?=
 =?utf-8?Q?s0fKbMVzD60=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emhrNTFRZENnTlRZYmpick9XR3BLeUs5bDluNlh4b0FabkszSGRWYUhXWmtM?=
 =?utf-8?B?ZVFSbWF2Nmp5Z1ZDeXEzSjhaNVBSTlpjU3hNWGk5SFd0M2FaVnlLdzB3aWN2?=
 =?utf-8?B?S3VLMjFNOU10NVU3WXY5VEVEd2FxRCttZk85c0xKb1cxaGZ1ME55QzNPTit6?=
 =?utf-8?B?NmhxakhKQ0w0MjdOZWc4WDBGaXM2Umo1Sm1lVWtCOWdkbE9YVHljK2QySncy?=
 =?utf-8?B?V3dHL3l3WFNXWUVHZEpxSE5CZUxVZTM1cWFDY25FeEJWTW5na0t6S3lYWU55?=
 =?utf-8?B?b2U3MXNueTdMV0NiNGcwOHB4WW9ZNGYvUW9RRHdiQ2hCZFdJcVA2c1hUamtR?=
 =?utf-8?B?K2xCcFZvZzRDYVZndG1CZ3d3Z0k4TTZIbVRMMk5oOHBBZGRaWGNIYVFUbGZF?=
 =?utf-8?B?SUt6bFlOWUtKb2QvNWlTbU9OTTNuMktWUTFCUVR1RWRPdm5hdisybnY3VHZ0?=
 =?utf-8?B?KzJNM3BaSmNiTVBWNm9pM2owN0dSWUdSZWdid3VVeFAxVXQveXFseVpOc0do?=
 =?utf-8?B?OGNKNmJ2elpuMkM2UmpqdUZ1M1piVC8rNjVxYUN2Y2ZzcCt1UTN6MGxqcmU3?=
 =?utf-8?B?WE9JU3F4SnVlNGVvcktFSVpxdHUvNW0vNEVndlM4eGQ2bmhDelJ4b2UySGdu?=
 =?utf-8?B?eThxWWJtcVJTUnd0ZlNSL2JJOC9pdlMyRkcvVlZUMkVONkg2SkMrN21seEll?=
 =?utf-8?B?RDBtZGNudUNwTTZwcmswSEZQNlpMM3hYZmcxTTFteUZsQTNQYXk1NVJnbklQ?=
 =?utf-8?B?U0pYMURJMk5uS0FMV0tMMTlvU0tFdGdMS3lVU1N2eTJJa3ZSdGFYV0wxUUk4?=
 =?utf-8?B?SUNHOWwra0w5WUFVNU12Y082Y3R6RlZNR1AxL2x2R1hIV2ltWHJvNnljU3Rr?=
 =?utf-8?B?MEtuV2ZhSWRKOHdURmhBa3JpcnV0UzNhY245MXJId0pabmowdzNsa3VOc0JV?=
 =?utf-8?B?VEVlWmJsR2pOWGlFQjd5WTZia3RCaXMxSGNLcmJLZmdWNmRldkVacW1SL2M2?=
 =?utf-8?B?WUpzdTBUdjNPaFFaa2RUQVlndHhGU1puRHdwK0EyOVc5MXVWMExvMUQrTG9H?=
 =?utf-8?B?MUhSZEdJdGVHYk01MFRwdSs4VzVMYUJUcXE5VXVseGRycTUwOUNBbmhtQXpu?=
 =?utf-8?B?dVhYM0JXdC81cnNBd0R2NWJRT0FJQUdzYnhJVUJLaXNIY0ZLTTFGeldrYTFI?=
 =?utf-8?B?cEtZUE9vTjhKUVR0RzBLVm5hV3BldTNQNzVhRFBkNFlEYVJZemxlQVFTVlNN?=
 =?utf-8?B?bjJGVmRSMXR3dWJkMkZqVThESW40T0JsellIVWtLU01VTnlEQlM4WnZvNVpy?=
 =?utf-8?B?aWZ2T0FpNDFVbWZDWmZ1WEFSVzNUNitLblMrVEc4eU1ZRFpmLzVpTEQyRmtF?=
 =?utf-8?B?SHRuTVFPSG4rc1VheFlTbFgwYmlXNFluVThUc3RqYkVFaDBPUU1KQVJRdjhw?=
 =?utf-8?B?cnJZSGoydFNVcnc4TWNFTmJ0K2xpNWVEQjhaYlJOQzFGcHh5U2pGQXArck1K?=
 =?utf-8?B?Z21Iejg1MG1KUmYvemF6SUFNVW5YUE94U3E1NnFTSXdvSmdQT0IweUUvdVBP?=
 =?utf-8?B?K09FYXJQWXBYUVZEbG1qN2VBak1mMFVpb3BTaTFvZDg2MU5XbXpzdnZqb0Fu?=
 =?utf-8?B?SjFxTnNyeTU2UkJicmMyVE8raVJLTmowaUhGdXVEQjVDWXY0TmRvL0QzSE9a?=
 =?utf-8?B?eHhLc1N4U1V1cW9vNnc0dzY0cWp6aUhSdk9jdmxiZ3l3TkgxY0twdXZJamF0?=
 =?utf-8?B?OEthSkZVRnc2NUtET2tnMWYyaE1QTmgwWXI3ajV1cUlpYXNpYXhCaE9UZkdj?=
 =?utf-8?B?eGdIVGovUWhxY2ZwUVN4a010RUgzVmlHL1piTi93ZU1vak5vSDBiZ1RXVDRt?=
 =?utf-8?B?bGZKRktJTWx2dVVIL09mSHNsanVDYXFVQVkrV3pYYm9wSEQrUGFLdjBMbFhR?=
 =?utf-8?B?YWUwdENhSkdqVWtzU2ZlKzVLTlJaNWtUSWxWeVI2TVY3UWZOTFFOeVNwemJY?=
 =?utf-8?B?Mzd3V3FXQy9YL3VlQjVJQTdXNXdLOTVWN0dFUGZDUWpVS1NnRHBmbGhPYmFn?=
 =?utf-8?B?dUZ4ZUY4ZnRWNnlFdDFSRVpId3lZeGpFTzdtUlVHRGJCNzFmWlRLZmFLUlJn?=
 =?utf-8?Q?LnU6ZXRb/46gYvO0tDqqyZnKS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2519c10-e907-4fac-f8f5-08dd8e3215ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:13:12.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSTNoeigdTvbDlKFl+qtgEW63P8Yr+dUOX8gGtfbcHdx9xMT9juzPWad4I9351gxYEksJquRaGv5UdMh3rmOhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541


On 5/8/25 01:55, Alison Schofield wrote:
> On Thu, Apr 17, 2025 at 10:29:07PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 has some mandatory capabilities which are optional for Type2.
>>
>> In order to support same register/capability discovery code for both
>> types, avoid any assumption about what capabilities should be there, and
>> export the capabilities found for the caller doing the capabilities
>> check based on the expected ones.
>>
>> Add a function for facilitating the report of capabiities missing the
> sp. capabilities
>

I'll fix it.


>> expected ones.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/pci.c  | 35 +++++++++++++++++++++++++++++++++--
>>   drivers/cxl/core/port.c |  8 ++++----
>>   drivers/cxl/core/regs.c | 35 +++++++++++++++++++----------------
>>   drivers/cxl/cxl.h       |  6 +++---
>>   drivers/cxl/cxlpci.h    |  2 +-
>>   drivers/cxl/pci.c       | 24 +++++++++++++++++++++---
>>   include/cxl/cxl.h       | 24 ++++++++++++++++++++++++
>>   7 files changed, 105 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 0b8dc34b8300..ed18260ff1c9 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1061,7 +1061,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>   }
>>   
>>   int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> -		       struct cxl_register_map *map)
>> +		       struct cxl_register_map *map, unsigned long *caps)
>>   {
>>   	int rc;
>>   
>> @@ -1091,7 +1091,7 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   		return rc;
>>   	}
>>   
>> -	return cxl_setup_regs(map);
>> +	return cxl_setup_regs(map, caps);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>>   
>> @@ -1214,3 +1214,34 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
>>   
>>   	return 0;
>>   }
>> +
>> +int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
>> +		   unsigned long *found)
>> +{
>> +	DECLARE_BITMAP(missing, CXL_MAX_CAPS);
>> +
>> +	if (bitmap_subset(expected, found, CXL_MAX_CAPS))
>> +		/* all good */
>> +		return 0;
>> +
>> +	bitmap_andnot(missing, expected, found, CXL_MAX_CAPS);
>> +
>> +	if (test_bit(CXL_DEV_CAP_RAS, missing))
>> +		dev_err(&pdev->dev, "RAS capability not found\n");
>> +
>> +	if (test_bit(CXL_DEV_CAP_HDM, missing))
>> +		dev_err(&pdev->dev, "HDM decoder capability not found\n");
>> +
>> +	if (test_bit(CXL_DEV_CAP_DEV_STATUS, missing))
>> +		dev_err(&pdev->dev, "Device Status capability not found\n");
>> +
>> +	if (test_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, missing))
>> +		dev_err(&pdev->dev, "Primary Mailbox capability not found\n");
>> +
>> +	if (test_bit(CXL_DEV_CAP_MEMDEV, missing))
>> +		dev_err(&pdev->dev,
>> +			"Memory Device Status capability not found\n");
>> +
>> +	return -1;
>> +}
> Prefer using an array to map the enums to strings, like -
>
> 	static const char * const cap_names[CXL_MAX_CAPS] = {
> 		[CXL_DEV_CAP_RAS]	= "CXL_DEV_CAP_RAS",
> 		.
> 		.
> 		.
> 	};
>
> and then loop thru that, like:
>
> 	for (int i = 0; i < CXL_MAX_CAPS; i++) {
> 		if (!test-bit(i, missing))
> 	 		dev_err(&pdev->dev,"%s capability not found\n",
> 	 	 		cap_names[i];
> 	}
>

Looks good to me and it saves some code lines. I'll do the change.


>
> snip
>>   }
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index be0ae9aca84a..e409ea06af0b 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -4,6 +4,7 @@
>>   #include <linux/device.h>
>>   #include <linux/slab.h>
>>   #include <linux/pci.h>
>> +#include <cxl/cxl.h>
>>   #include <cxl/pci.h>
>>   #include <cxlmem.h>
>>   #include <cxlpci.h>
>> @@ -11,6 +12,9 @@
>>   
>>   #include "core.h"
>>   
>> +#define cxl_cap_set_bit(bit, caps) \
>> +	do { if ((caps)) set_bit((bit), (caps)); } while (0)
>> +
> Prefer a readable and type safe simple fcn:
>
> static void cxl_cap_set_bit(int bit, unsigned long *caps)
> {
> 	if (caps)
> 		set_bit(bit, caps);
> }
>

I have no preference but I can do this change as well.

Thank you!


