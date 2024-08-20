Return-Path: <netdev+bounces-120105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7151095851A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2830428BC2F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0518E042;
	Tue, 20 Aug 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1+sTE65X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5918E047;
	Tue, 20 Aug 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150743; cv=fail; b=n0m5ST41nVFn470ROE1xtGKDzaQXqgu5vVxM2Q7vtWW0E7EnF5YXfrlsnmudhn3jh9icJOZlacJqOm7q0dhhg9OxQswlqpKZHdz79+y/ysNbXow4bOcE8RvjGlLIOzLWVZQiOyruAt2gijmKExapLv34AsAgPrZNB9XAEK5ZMao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150743; c=relaxed/simple;
	bh=TjG3TpDnnoTQ+Aex0HyrCGDZ6CV/JBjQAs2Ptvc1rlY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CczMwAqVjNmP/ITnnH6G/dCzidKwx1MoOprqMSxk0LOiDRIPVo1L3YqolkChuwFPzQKwiojC8+LbaJkIAW4eJonHDDhkTKITLwKgzm1m8+ewG04s+6icyYeVuDWNLkdlO4jLcZ0C748NoEebVitfKLRSevfy9vDYy7bNh+cZTq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1+sTE65X; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsvh9LMbQAEKdrzm7l+NuQwozM8g1tEKC1hbWx8hA1kuN/nuNL1IqgU0VxEhxkSzduzQSA6yEKjdRFDja7+djV/vnO0b4RjaxICVwlE06YmAvMtP19YwcLZlhIeuPUkyxKpAMV3ZpHnlNkphUSJpIVFFeAGyVAOhbpBYhbAcXgFlo25i6oDYN/Ai5PxtySxQUkT+nUqJ/8iEu5jkbBeLgHD/MO2AZ1s6QsUJ9iDC7lkLqYQCQxTPpqCY7M0F2oRM3H64l2blktp6cD0ZsMxFw2ipYKR3t25EMPbhS/Ia7F+EHpLA9tTezFX8hFXLptJJgZAN43wwai4zQah3sZ12Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FFVE2g/FjHlxJKufZECjQjJ9O0HVtRuZVBgp0rBz7E=;
 b=uzd5EwdpOhHI1u4ykkaNRXcVK2Ged1YhrQAoreLRUDAdDhf0cPUjGpyOGVOwSfyR+AZ6ABumI0Ii5ZuWjzfmPNm3VJU7ZHl8dUvfsb8ei4Er77XD33jh8hNg1BgCbVuCmE36UkRGUAhnoXix1F5Zmp/Qcd187xeyLZ/EgY4Saw15kqMaGRmk50Xi1YLeXULP6M9pY35mXhWJTBxTbGgjoz2JuM/+Zg42rD6No/50BfAeGT4hrrusGIcU+i37cdx2MqK+OonEbr/9Ltx8WMtqHEbvIxK11xRnaBl5dwnXalwCKfX5abDGC5wpGDo48Y9PuAYQwV1075ATUg0FBgVKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FFVE2g/FjHlxJKufZECjQjJ9O0HVtRuZVBgp0rBz7E=;
 b=1+sTE65Xru0ZYB/ymwHzeeD1WNYtQlDoZ7fsh1rLQsZE/3hG0j1t4vMlw1X5HAandQtMCXiljGTtcVrPDr3VyOvURI8BFmXckGJbU7G3m73L9dytQiSoTPntAMVSkMkphClRCSu0id8elMr8FVNMzxeGyn7HBszZJN3YbwxMI3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 10:45:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 10:45:37 +0000
Message-ID: <942da248-7140-6cb0-d960-34e300544d5a@amd.com>
Date: Tue, 20 Aug 2024 11:44:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
 <20240804181045.000009dc@Huawei.com>
 <508e796c-64f1-f90a-3860-827eaab2c672@amd.com>
 <c9391139-edc4-73a0-3ede-d67c40130354@amd.com>
 <20240815173812.0000447c@Huawei.com>
 <26723cc8-c067-280b-f0cf-ee3906545837@amd.com>
In-Reply-To: <26723cc8-c067-280b-f0cf-ee3906545837@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0294.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 30978c44-1aa6-435f-c446-08dcc1053a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGQ4UEpYT25wdEdDbVlRWk1sc1A1eUxzYkwvZzM1eVRTdDRmSVU4TzJ0TmNm?=
 =?utf-8?B?eVA3WEVVQWVuWVRTZ3VuVTU1NHpLRi9Nb2MwY1owaERaMmw3SWRHbmpHaSs3?=
 =?utf-8?B?RkJ0VzFtSytkbXFwbFdwRUMzdkN2MVdqMjBvN2VSL2lacmxrY2g2NkNFNVZl?=
 =?utf-8?B?ajhkcXQyUFNhZnVpd0tOOXBOTGdQekdSVjdUL3U0bUh6TElHUUw2ZkVjVVhm?=
 =?utf-8?B?TW1qNjdnSGhlR0Yvamh4VEYzUm1QdFU0NnFDTG9OMVI3QTVuZUJCaEphVCtQ?=
 =?utf-8?B?NjJjdkF6WHducjJXaC9Gd3FlaU1ERFAzUFdkTXNFeGp0T2RRTjVCRDBaTW9E?=
 =?utf-8?B?RUZnSy9hOE9lMUU0cmJZRDRtTVdLaDBrekFUb3dXampyWUdvUElwMi9mZzlp?=
 =?utf-8?B?amF4Q0NsWDZLZmpUc2xjbldQeVRSR3JzQXpNK3RhTDIzbWszNjlwRGkzYTJn?=
 =?utf-8?B?Z0tmY2hRSTY3MDFKVmVkY1Y1aHBUQzRtbXZCWXgxQ1pQZkNMbWQzODlQOFUw?=
 =?utf-8?B?QVpjUU12OWdlTHJzZ0NjTE9kcnVCS2FhWTZHVm1nbGdJVm5wT3RqQ056NmtN?=
 =?utf-8?B?b0VFTjhTZ0VDYlAzVzBHbDhpSjVoMFFtb3R3bkp3Y0EvbHFZbnNWNHNpSmNv?=
 =?utf-8?B?Sm01Smp3RzRZTVBrVVR0dCtNRWYraUVIRmxDc3RHdEF2Vk1wY2lnaVVtenFw?=
 =?utf-8?B?OG1zV1B1d3YzcTc2YW9OUjdoeVpObDVsSUlYellZMDFObzVUTnVtS2hDNmFV?=
 =?utf-8?B?SzlmdkpvWTRtenlqL0JXR0owWFZXcHExWnU1MGEzenF1b3ltdmk0UlVoTWV3?=
 =?utf-8?B?YVZGSlRjQ1U3TWkwSllxMS9udlRySWxveFRTL2FKTXZ2eTE1Sk1pcmRGbTk2?=
 =?utf-8?B?Vm95Zm1reUhkMnlsY01XeFJJYzBPU3lYR3V3YWZxTzluZ2p3VkM4aWZEQnZj?=
 =?utf-8?B?UG9iREJPZEtkTEQrMzhpTDI5Q2tKMTJFdWxNYUtjRTdienNOTHdMd1RqTDBR?=
 =?utf-8?B?dkZLMlh6MG9IQVgwYVBraTRGZ0Y0Sk1lMDcwVWV3bHFiUnhvZG1YdkwvQVpt?=
 =?utf-8?B?bDVLbHhZL3NYSUxyVnVYS0I3S1QxcDJOd3d5L0kyQ09ld0ptektNbkl0ajlu?=
 =?utf-8?B?ZFVUcEpzQU5HS2VFZFk5bXNGVXdjWGxlN2U5d2lhSjkwTmhnOHQ3YTgyNXN5?=
 =?utf-8?B?b2dyYi9McUNMS3R5d0M1aWVmUkZ6cFFmcUlDbnpDaGt0c2NLRmV6SWplbDZB?=
 =?utf-8?B?SEE2QzhzdXlrSFVzTG5QUkF3Q0FHQlltdEJrd2tDV25PZVIwM0V3TUY3cDk5?=
 =?utf-8?B?REo0blVYTnByN2szRFZ3OG9xNXVrYTVCRHRyQnltR2NENkNmeXhJTC8rNmNM?=
 =?utf-8?B?RTRzemRFck5DY3ZYTm9lK0ZJUWVtSENSL1h2Q20rWlVLdTZSQUxQV3pxaDQv?=
 =?utf-8?B?QjQxbmU5YllzbEZFZ3pCZkVEOW9teTR2azhueFFSckxJTGZCZGZXY1p2S2NE?=
 =?utf-8?B?MjVMYTBudEszSWkvN3VGcEkyYWV4YURjSnJiRkVkeUJkUkpzOWVjZTBzYTVo?=
 =?utf-8?B?ODA5VVRnUk9vQXJSa1lqK3JwaU9aVjF0TTR3RHVJWHhEcVFqLzlvRnpJZS93?=
 =?utf-8?B?ZlVlTEtHRDVpOWJWRk5lRWtEQ3VsM3dXK1l0UHpqZEVLQ2luSEdCM3dkb01h?=
 =?utf-8?B?WDFnQWY0R0JQTFdVdWhJM3Y2VWVRaStZTThYZzhNdGZHemJFN01VOGdlL3pX?=
 =?utf-8?Q?qGHt+vwbi8OFES5gZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXZQZkoxdmZKd0xXRmR6S0Uwc2hYTGpOREpLcG51bEFLdU40NnBvQi9KNGpQ?=
 =?utf-8?B?NlN0RVhBWUtjeWVwTWovYVU1c3hyYU0wa3FkZ3FJK1ZkUE1QcmNFcVNBVzA4?=
 =?utf-8?B?YTZ0cml5bVhyM0N6dGZPSDhMcVlYS3RCdWcwTnhyNmNnb1cxVWpOL3JhNjdt?=
 =?utf-8?B?cmJtbXpKV1BiV0F1Z0NMNVpEZk9zYU8yWXpERmcvT1pmNEZyT0VTWkhkMTI4?=
 =?utf-8?B?aUFIK0VPRnRjeThQS2xtcDR0MjBUOGl3S1E3bnNjRGZya1JybHRXbmFIL3B2?=
 =?utf-8?B?REpsMDNDQjR4MDUzMGNqZlhrcEpHdUNSZ2IyZkdobEQrWnZ5Vi9mRlhJUHNJ?=
 =?utf-8?B?N1d6Nmxpa1JYVStWTVhwcmJzNk03SFR3bXZSQS9jZ2J5ZGM0cDdzVnVpYkpj?=
 =?utf-8?B?dURqZW5nWU9aZVRJRUhobTQzMUwwek1ybzFnWXB6cGh0WE9OdHVXU084ekZW?=
 =?utf-8?B?S3RCUVBLbEhpSjQ3V0FkV0ZrQTh4VHRyNUFWYWsvRUlPVkJkUDNDUmoyU2lK?=
 =?utf-8?B?ekdXQ1NUNVZMeDU1QkJ1SDI2MHVXZHh6cTU2YThHdEYrRWdYNEUvOU1IWE1R?=
 =?utf-8?B?dlU5a2NNZ09pVFl5WFVtNVRzZFJEU3MrWFdROVNBRWxtOW0vdVdheHpIQkxa?=
 =?utf-8?B?bEdXdkxjNGFHdUg3b0FXN2tkek13eHd5L0JCVnMvTDE4eFZOSHl5MXNBZ1BB?=
 =?utf-8?B?aHBxY3JlRmpaNWhSemZpWEZMWVNMSEpHT1YrMFZ5TU1pOTFpYitiRzBKYjdM?=
 =?utf-8?B?QVNIYzkwT0YxaTlZbVcydy9EbXVVZk94cjlSSlVwZ0pham5iSXBMNGxBWkUv?=
 =?utf-8?B?MGxHaXNnTjJhK29jYXZxc09rQk5ncmRXcUZqN1doMVFPSGpKTTczQS9panE3?=
 =?utf-8?B?MTloMWdrWXNFN1VZSHJlUExCeDNudkZ5YTVEaWF2OFBNajR2NUJqSXJHbFBO?=
 =?utf-8?B?S2pJbGRQVms2cU80blhGM3g5clN5NDJUR2d4K2wweEZjUXBUOUhsdDFsY3V3?=
 =?utf-8?B?a1hUeVJUYUxRbGZ5Tm1aUGRCOEJPSE02aW5NSXk1THJHb0QxdnJRSUxRZVVG?=
 =?utf-8?B?WU5tTW5Ud3U1WWdjd204ZWs1T1NqUk1pUDZtcWZGNVdLNUl2T0txZDQzblVi?=
 =?utf-8?B?SHlaUER1aHE4MExXbjdDbTIzRXp6NnMxMHI3Ym1mUEx2M1BVd1d3NWw2dVRh?=
 =?utf-8?B?cjRxRTNSUC83alZVc0Q1T0FmUXVEeTFPREVHd1ZMN1pIbTFQTG5tazBHTDBF?=
 =?utf-8?B?dHNxUnlBcndVdXJtcW00SnVTSktvSDVTMC80V2JteWlRbklWbDlZc0RuQUZm?=
 =?utf-8?B?RThibG8rYmVvTVU0WnhFRktpV3ZYZWpXMXIrcTJwQzcrdW5yWSt6ckwyVUJk?=
 =?utf-8?B?SlRUNHkyb2MyaXZZKzh0UFB0NjRkNk5jMm0wQUZDd2FaSjExT3EvZHpwRXFB?=
 =?utf-8?B?MVZDeVJPWnBocllRblZja1kzUVVROFQ3bjAzcThRNU1sbjZWcXBoWmNDTEJB?=
 =?utf-8?B?dURsQlJ2OTBpTDBHdVVoSUFTVzljREkyNSsxakluMlBZNXU1NWFVMGh6S2N0?=
 =?utf-8?B?OWhYeDlhYldWRW1SbzBmeDBTdlpQTG1icHZ6dU9WUzlSWEVmYkF0d0NOVGkr?=
 =?utf-8?B?dytCckdtdG01bEdLUFZXT0Y3ekxobWhYV2dZRUNLTnY0OVl6aFMwVDE5WWRD?=
 =?utf-8?B?NHVwNi9xczhPRXlNV0hOSjVSUlMzMnZCeEtvV2pCekVXRU5JL2YvRHJSOVRO?=
 =?utf-8?B?RWxSNE8wMzNXL3N6ci9EV2RmTkQvWlpoTnNDUDN2dVdZNEZiM3F2MWNHU1Z4?=
 =?utf-8?B?ZEw2VEVETkZUSWlOeXlGTlhMME1xNmFxUGhrak5Edy9mZ3FBMDB0U0dJblV4?=
 =?utf-8?B?Lzk0UWhMYnJnamFhR2tpcjFQaGF6ZUwrdDl1OERNQ051RXdjWjFhd0RHd1gy?=
 =?utf-8?B?L0VWOEJIMm01YlNCQmRKTnEyaXoxNUUxMmZLb3M2bkRWdHF0UjR1Vy9kU1Fk?=
 =?utf-8?B?amQzQTBsSExyRXZTRmFwME0vbzlqTWZBem5RUzJJZmp3aXI1K3JTVER5OXBz?=
 =?utf-8?B?bVJjUXBYa0NzY1lReHJ0djkyK0FOZVFNNHpIVVcrdVV3N3lYRk9hSjlEdE1I?=
 =?utf-8?Q?nUoihmZ3eW14wAxWtB7EdQnOE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30978c44-1aa6-435f-c446-08dcc1053a2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:45:37.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jp7AeIyImVE4hLmv47KLzGMZEzynJeU8clqUXPqjNJvyQaZ8omvbOmiQ95WJxDbPWpxP8Mse6XdbTWjQTNgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414


On 8/19/24 12:12, Alejandro Lucero Palau wrote:
>
> On 8/15/24 17:38, Jonathan Cameron wrote:
>> On Tue, 13 Aug 2024 09:30:08 +0100
>> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>>
>>> On 8/12/24 12:16, Alejandro Lucero Palau wrote:
>>>> On 8/4/24 18:10, Jonathan Cameron wrote:
>>>>> On Mon, 15 Jul 2024 18:28:21 +0100
>>>>> <alejandro.lucero-palau@amd.com> wrote:
>>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>>
>>>>>> Differientiate Type3, aka memory expanders, from Type2, aka device
>>>>>> accelerators, with a new function for initializing cxl_dev_state.
>>>>>>
>>>>>> Create opaque struct to be used by accelerators relying on new 
>>>>>> access
>>>>>> functions in following patches.
>>>>>>
>>>>>> Add SFC ethernet network driver as the client.
>>>>>>
>>>>>> Based on
>>>>>> https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e 
>>>>>>
>>>>>>
>>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>>>> +
>>>>>> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>>>>>> +{
>>>>>> +    cxlds->cxl_dvsec = dvsec;
>>>>> Nothing to do with accel. If these make sense promote to cxl
>>>>> core and a linux/cxl/ header.  Also we may want the type3 driver to
>>>>> switch to them long term. If nothing else, making that handle the
>>>>> cxl_dev_state as more opaque will show up what is still directly
>>>>> accessed and may need to be wrapped up for a future accelerator 
>>>>> driver
>>>>> to use.
>>>> I will change the function name then, but not sure I follow the
>>>> comment about more opaque ...
>>>>
>>>>
>>> I have second thoughts about this.
>>>
>>>
>>> I consider this as an accessor  for, as you said in a previous 
>>> exchange,
>>> facilitating changes to the core structs without touching those accel
>>> drivers using it.
>>>
>>> Type3 driver is part of the CXL core and easy to change for these kind
>>> of updates since it will only be one driver supporting all Type3, 
>>> and an
>>> accessor is not required then.
>>>
>>> Let me know what you think.
>> It's less critical, but longer term I'd expect any stuff that makes
>> sense for accelerators and the type 3 driver to use the same
>> approaches and code paths.  Makes it easier to see where they
>> are related than opencoding the accesses in the type 3 driver will
>> do.  In the very long term, I'd expect the type 3 driver to just be
>> another CXL driver alongside many others.
>
>
> It makes sense, so I will change the name.
>
> A following patchset when this is hopefully going through will be to 
> use the accessors in the CXL PCI driver.
>
> Thanks!
>

I realize you likely mean all the accessors and not just the dvsec one. 
Right?

Also, I think I could add the changes to the pci driver for using them 
within this patchset.


>
>> Jonathan
>>
>>>

