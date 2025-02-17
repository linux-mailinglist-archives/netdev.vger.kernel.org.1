Return-Path: <netdev+bounces-166998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233CCA38455
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844E7169C25
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7988F21CFFF;
	Mon, 17 Feb 2025 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F6ut/MTt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D821C192;
	Mon, 17 Feb 2025 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798018; cv=fail; b=cZVyyD05XDf/qZzUlIBDmMCROeTpC6AYjlr7Xwr3SPsEowhJKGZvapH7+22D49ICH+JnrCBmvuwPvVhoCtr0iwLsv9cWR/ayVAllMlbXr1RkcsXUWfUSyRT2Meoau6XpZZ59ngs0ZtxzEahIPuA1arEvwY2w5Uv5hSxtVhWv4Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798018; c=relaxed/simple;
	bh=TxOey53YpckyS0J9LYvQ0B3d4cr7YEacQx1Rh72slKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XZz6PSZLAGpr4va9n2strW2uupwhBkzvtySFaiUXmd3Y4wHe0LE5+5AJEoi+XIwpXXeSI66+0IbKsJ8TBCJyMSt1NmFlxT25mAv7wZgzln+e01w+kCsqUSqKOJIGumpDmLlVkMPAFksQsZHBSEhidgNT557FwBnpK3yJWAM0djU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F6ut/MTt; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNGHoig6KCISkHqpAXHIACnj5klEEukIXZcpk3ABCipDBmmEgtfUE47iJJyvWGKT2O5eFnlbjS3yokUbATjs9Gv010Dvkaoze1dpNk40TEt6WZ3FmtgQGtKpuldU9lA9Qz52DMmDybUij99qohdBSLMMD0qiCLsA+RIcD7gtBa53bKHi8fCyomtBKAxy235L4XmFAgrCADzycebE+qBA2NuaBzzDscrgKW94dXB8KN+C8afS7p6AH/JvqCP+q9HDFswGDsA2psVB9sp7Elcg9Htru02Ly1XEVRb00TvZftvig+0/4ucNmSrfxm3TBNwfJoDOusVPZXghme+IBWbKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf4F92tBu3sbK7zXAszxxl4Etj0AWMeUZ8UAS4hUYD4=;
 b=Dq2rbWQMFvgEIpca66Y5ipdrQt+qWGbSm0ZaWHDCek5JG+Yx0vPi/ZJ7hALob9WXda2bRxTd8fV0Tyu8oxknC8mEHqFRpuSj0Z1C8zX+MW9QhPagAp8E1jgE3QWAzCq41CyGDFkeo6iRETJLLYYhvrMJiHWRihvag/njoLfwgZOzw35iyYAApYiKkG8TwCCLIez6xEN6eaVxG7s+N1VWDD82E59bexCIdbhegUXCf5Z364XUEYpelI5X9jmkGcJfCQEJZGvNHS85ttMpj7HG6GbVW1CiXJ1eCoLk24jGPy4nzd1bCoQY6inldr/MtVGbf1Dyz4Ip0RqTJeimQDvkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf4F92tBu3sbK7zXAszxxl4Etj0AWMeUZ8UAS4hUYD4=;
 b=F6ut/MTtCZujl6bSV1JWObCLA8DUbCN+ctHxFbEmYXph84OjFhwssMZ3UnVjApa08tYaN8Qi7L8vAmNvP/Dl86POkZHku44aEsC+7b9TQH0H2DmgdJDIooL0naCSOvRsU2yIQQn7KKf04BFMbvUt18SFzYTn0o3iPK5DmXBN0S0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Mon, 17 Feb 2025 13:13:34 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:13:34 +0000
Message-ID: <93647dfe-0318-4b9a-9abf-3d082a623124@amd.com>
Date: Mon, 17 Feb 2025 13:13:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/26] cxl: move pci generic code
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-4-alucerop@amd.com>
 <67a3d931816f_2ee27529462@iweiny-mobl.notmuch>
 <16f4a5de-2f54-4367-9e14-b7a617468353@amd.com>
 <20250214171147.00007e5f@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250214171147.00007e5f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 718c45b4-eb39-48b9-410c-08dd4f54e1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0ViQmhkMHpNbEV0RVZTMHFFa1p2NWwwOHBTeVVuNzRRZUdoYXhMM05nS3I4?=
 =?utf-8?B?Tmc3c0NTU2c3dVE4MGN6VDd1MWZFVnk4NUFWS21pT3AxUUNYaGc3ZkxoYnQ2?=
 =?utf-8?B?OXA2UHNET2I4bktaMEdmY29mNXNURkFFS0d1ZUk3WmlYTGg5eDdZMFo1OEgw?=
 =?utf-8?B?N3FxVmQ3Qk5ac0RLZVdyWlFENVZFNjM3c1JtNzQxRFMvdTZtR1JMUFFZUTJ3?=
 =?utf-8?B?Sm9aYmoxeHZJY1QycWVQdXVGQkN0SDJweC9jNlJJSXhwSldFb05zYk16QW5W?=
 =?utf-8?B?NXY2SHlSRDU3eFRPTUdvSTdrdEtrQlltemNQWjNLMHZxUFJmdW96c243aHRV?=
 =?utf-8?B?Z3k2OC9jV1VzYVE3a3pzR2l5NFdKOGs2c2F6VkpTc1RzS3N6YytLd0s4SUU4?=
 =?utf-8?B?S1dxRnNIalZISG9pcFY2Z2RLMFRiNEpWUzE2WWNpeWQ5OEM5ekxJbkNkM21N?=
 =?utf-8?B?bkwrc1JtK2VncnVpVGs3WTlnTm15NklnUnN2TkhKbHhFRWJOdFArQ2ZNeHpB?=
 =?utf-8?B?dlZaSGN6ZE9mb1U5V25LVnE4U09SQ1Q0NnRCdHZEclZkYnBHQXpJMGx4YkJM?=
 =?utf-8?B?am1yZ1VhaklwNit3bm1ud1V0TlR4UGxFQ2RxNUx0TVVVZ1dQQjlxdGJZN1B5?=
 =?utf-8?B?TG5lWVlvLzh5SWFmemdscjk5NnVFaHc3R3R1SUs1dFdyLytSejM0aG9za2hl?=
 =?utf-8?B?MWQvK3p3bE5zZVZOWnVDRzRTbjMwQnpydFZRV1d0bjFyQnlBbjRUbndZdU5z?=
 =?utf-8?B?T3A3bU5Xc2Z4OVN1R3pPRkxwTDBCQmdFbmxhMThYR2tYczZQaWt3QmNhN2tS?=
 =?utf-8?B?VFdwSUVuRGhPTEJZWU4zaGkvbGVralVTYWNtWndRWWltQnB6OVJqRHJxdWx4?=
 =?utf-8?B?SkNtNk5CQ0lSejFZYjVWdEEwNjk2TWI3a09pSE05RXNzV0QwNExiN1JzM3Za?=
 =?utf-8?B?R1B6Wi9CdXllODFGT1FrUEVYWDltcWw4dm5iaVFrMnIxd0tQeVBVN0NJbmFi?=
 =?utf-8?B?WlhGNm9YVkI1RHYvbmR2blU3TW82V1loR1JDYzNFcVJPTityL0VoNHZPelln?=
 =?utf-8?B?RkVXTG5BR0tKb0w1WFN6ZlJ6QTFvMVIrSmZEdEJTaHJqR1hoMWdQZ3pTdjBR?=
 =?utf-8?B?bC9ZeWhPYU9laDlLbTlLdm16QTdrdWExM0ZzbXlqUmo2d1hadW0xSnJkZ0Rj?=
 =?utf-8?B?ME9HdEFkSGV4bnV2ZVNUc1BYRkg5bDVZZjlaV1hOSEpRWU80ZGEyTnpoWThL?=
 =?utf-8?B?MGJNTWZQYnpOd3Zhd2UveEsyN3lnT0dwN0RWQkU2djBtaDhDM0p0SjRJTjNa?=
 =?utf-8?B?c1JEZzlPNFVYQklGUW0zd0NnRE5tRDY4ekVQUjRQZGhSU0JnSm9UWkRMMTVr?=
 =?utf-8?B?M1NzclhsTHVFc1FyK3Vmbk9OaHptZ2NJVGZlaEs5WlZoRGRRTGkzT01FVWdB?=
 =?utf-8?B?dFdXY1NQSnlWRVM0WkFza1pOdDY0bmlTbkV4Z2hVeWsxaW5OZ0ZwSXgwN0Rn?=
 =?utf-8?B?ekVyTHBKS0h2SEpHOW1tbnNtS0ZoVzRPYlBZQ3o4Y1h2SXVOYzkyczUvbUdH?=
 =?utf-8?B?dzF2aWF4OXFCMTZHS2p4TlE4bE5hRzJ5ZEZzOTlSbkttd3ZHYTJIcElGVmRI?=
 =?utf-8?B?L2hrRHFuSG5SckZxSjFmVkorMlBFRDhUN1lVZHY3bDZmKzRrNE9tWmpsVWsr?=
 =?utf-8?B?OVRSN25MV1JNT2tRMndZczRZMCs5RG1OWTh5ZDBwTXowUENtT20rWGtkR3l0?=
 =?utf-8?B?TVhWY3AwZ1doV2dBUDRZaWVhRU9uZFgxZ1ZOalZxVVRUUjI3OEtSV1BQQytF?=
 =?utf-8?B?eHYxUjlyK0p5RDNmV01rUEZ5M3BNcmd2NUtOK2NuRk9IRmtUanNZSDFNVXND?=
 =?utf-8?Q?Sf+LXl4cJjlZ2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWNKSVFYMXZHakFaMmVCbGw0a1FuM2IvZjhyUFE2WGNKTE52VXd3Tmh5ekJK?=
 =?utf-8?B?M2N3d1JoVHZoMitEQ3dKMlVjcWZOVll1M2REaFZLSXlqVlV4ZmcxdUljUGY2?=
 =?utf-8?B?SUpsS2xlbzJjaUx3R0pPanhRTFBLOGlCZnJ6NVJwaUYrUDZDNGszT1huN1kz?=
 =?utf-8?B?OWlDeTUxc1RtNWZBY3k2TmNxNUUxYW1Rd1RKTnpzVXlJOWpXd1JtRWJMWW1Y?=
 =?utf-8?B?a3RWbkJjZWlkc3lkN3dOVVNGRHVjeE1SeGhFeXJPTDdkdjZBTW1FY0NCUVJE?=
 =?utf-8?B?ckdjTkZNS0ZoNHAyckQ3YUVJVkVONFQ3Ym9SYU9KcXErRWRvckxuNkpEUWtS?=
 =?utf-8?B?dEdHQlNyUVN3ejBHbHR3OHFkdGZ2T1hub3RPRDY3S2FXMjVVcis3VDdDcVAy?=
 =?utf-8?B?em1qajdwOWhOV2hLWVVDM1BPSm9BNzRnL0JWdFVMRGZBampkS1BDUm42T1lW?=
 =?utf-8?B?Q2dmUkI4b1FvVmhsNVB6VVg2OVZScWxxbFZoUm1OSi8xbG9XekZsSzZkMkMy?=
 =?utf-8?B?d1pkdjhvYUoxbUtUMjdOVkJlNFJrb3BxQThzeVRONWlyUkJzTTdVRlFLcmsz?=
 =?utf-8?B?RWdrdzdGVnFOam9abW81SnhYbi81dGFDdTVIZXM0ODduWmVMREk0TGk1OW1r?=
 =?utf-8?B?dk00THZJQWJCcG1EVzIrYTRRSEMxTWIxcFpzSkM5c2I4OVRkL05OUExqeGpN?=
 =?utf-8?B?M296amV1czRVSmNqRFRraUdXUzYrUDNOZmlybzlST3orb0poT2VDbHBheFY1?=
 =?utf-8?B?SWpkTW52TzFGTUt1VTFkZ3loVThTTG1ndjdGakE5M3E4UkxKYUtkenQwSlh2?=
 =?utf-8?B?ODV1Y1VqdGxYQzdWN0phWTI5eHNvUXcvcUhka1RzQmh0RmwyWmlRMmVySTBn?=
 =?utf-8?B?Z0N3YktLeXJkd2hqZDZjWmxMQWVtUGJGZHFYdWdMS0h5Ry81VlZSMWE1bTlw?=
 =?utf-8?B?dUdabysySEhhNnNLbjdqS2tRbFM2dzBKUkFkd1AzVU1lOXRxMi8zNXJaQWJR?=
 =?utf-8?B?ZGJMWlpSeVh2QXJ3ZU92RGc4QjZPWUFEaVpGQkNjZU1wdjF6Y3J2ZGlmd3hr?=
 =?utf-8?B?MGdWc2NwZDFnMmJkTGdNU3pYQjNIUThaUlEwTDZzaERuY3FINFQvQklqcVdr?=
 =?utf-8?B?R0o4NWpHRzBwZktmaTJIK1RMYjFVOElUSzNsWU9NdkRTWWJkY1pXRURZOEUv?=
 =?utf-8?B?VWxQRzNhdWcrRzlXeTRSYzZyMUtRb1RFaWZaUEx2U0xURmp6SWc1THVMMFhP?=
 =?utf-8?B?T1gyYjQvd1pKMG1Jbngyc09sSlZQdUZsNGpQVW83ZUd0dlExb0Q0c3gxaUpR?=
 =?utf-8?B?WkZPS2t2VlJONFRPajFCV0M3Sk0yWHFZTGtVS1ZDRm5ZbG1iNEd3K1dJdVJD?=
 =?utf-8?B?K2FrSzl6YS9zbEJuTUl3cnJsSVl2SVFKcEJrNU1FUGdUcHphdXFSN2VYRjgv?=
 =?utf-8?B?RDVCQkNRdU9WTkV6SnplaXdnYXlvQUFoSlcwRnJMUStFTGU5bkJPdDZRZVAv?=
 =?utf-8?B?WXZSZW1GeTJOR3RVU3FRM3VaN1pEWFVMZzlRSyt5YStDclEvRVZkei9lL0JQ?=
 =?utf-8?B?QlMvaU1OMTU1WkNMOUFkWGFjekNFTm9zbUNtRHJKV0tJQWVoZmVsZnR0S3Fl?=
 =?utf-8?B?TzUrTmRnRG52d3g5SEZBaEg2VktvSHB2RmxvYlk2TitoZitzSmlEWWZ1d3JP?=
 =?utf-8?B?QjVxUUdFTVV5U05ZdlljUjFvZUMwZUtDd1l5dUhlMStHQndIbjdhWW1uaUFR?=
 =?utf-8?B?RGlyS1c0YkFaNG1TTE1uMVVuR0RtMkhRRllBTzQ0bTJsandSQlNWc0tDTVc2?=
 =?utf-8?B?U1VnN2pMZ1dBV0cwalJ3eDI1SXI2STNBWVBHbDR6L3VoNStodEZyc3ZyN3lP?=
 =?utf-8?B?L2FuS2toa2RWQUZ1RmZ1eGNXRkU4b1JHbGl3bzN4ODR5dEs3NXNHQ1FHWWE3?=
 =?utf-8?B?Q0FkcXgwT2RLRlF6OW5ZelpRV1o1RlBCVUkwYWg1aTlpQ2FCeHdPLzdtbjFs?=
 =?utf-8?B?Zm1LTlRjUGF0TDVuK3lUMDFwRXg1WU42bURyaEpGMi9pN2Qxay9GZjAyUG8v?=
 =?utf-8?B?OENpN0lFVnBVY1p1T2hvWGNYekx1ME5EdzZjKzdiTjRKVm5QeE5WOUYvV3lK?=
 =?utf-8?Q?TIj5pVuUbRmYNkLgCiSOlCpan?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718c45b4-eb39-48b9-410c-08dd4f54e1e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:13:34.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXW0mXf8ENTfYCSffLiJpVhzI1Uo/HS6d8lS0fr/iaGvU4ReRdMeAJhcjxXh7iqigyyeKk+hO+ZrQPUN9mvyjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112


On 2/14/25 17:11, Jonathan Cameron wrote:
> On Thu, 6 Feb 2025 17:49:00 +0000
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 2/5/25 21:33, Ira Weiny wrote:
>>> alucerop@ wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>> [snip]
>>>   
>>>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>>>> index ad63560caa2c..e6178aa341b2 100644
>>>> --- a/include/cxl/pci.h
>>>> +++ b/include/cxl/pci.h
>>>> @@ -1,8 +1,21 @@
>>>>    /* SPDX-License-Identifier: GPL-2.0-only */
>>>>    /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>>>>    
>>>> -#ifndef __CXL_ACCEL_PCI_H
>>>> -#define __CXL_ACCEL_PCI_H
>>>> +#ifndef __LINUX_CXL_PCI_H
>>>> +#define __LINUX_CXL_PCI_H
>>> Nit: I'd just use __LINUX_CXL_PCI_H in the previous patch.
>>
>> Dan suggested this change.
> Would be odd if he meant in this patch....
>
> Definitely no benefit in doing it here rather that when you
> create the file in patch 1 that I can see.


Right. I'll fix it.

Thanks


> J
>
>>
>>> Ira
>>>
>>> [snip]
>>

