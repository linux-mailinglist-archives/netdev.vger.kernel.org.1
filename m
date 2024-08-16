Return-Path: <netdev+bounces-119215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B777954C90
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85B91F267A1
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208741BDA9F;
	Fri, 16 Aug 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1qOMDRQ3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B41BDAA3;
	Fri, 16 Aug 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819075; cv=fail; b=T9rJxiG/CzOrX/LKL4wv4m4pM7n9ArEquFfBFpIWCPyjquL6ovPW1iQp1szJD3ryNDDt+PvuFKfop0PEEbBClelfUOl6EoZkN9TYRbKh5127OyWGUAeJXF+k89F0KJkIA1/IKM9kyzgcrkku8KC97AQMwKhn+jGfGlYffN9uc8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819075; c=relaxed/simple;
	bh=aZ1hpfbj0VqHnNkJAEtAQvyDxgy2cn89OYXlx9HjlaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iWpKxqkqeqqj4fPL2hDM53vbqEuKuftHRSmQBMCWb5L0eODIsxeK+7jyzfB5i1L0vWLH/ynbKwnipLrugQYJdfOGab3T1DcHm7lbOtMvpIo4TS7V3ScVnT53UBaRnrb3xhiBz4f9oLq9HbchjEty3vJ2PUZdhc/aHkUl+44TWhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1qOMDRQ3; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzZC/EY0/PJk29X/DRYAFq5utsPj3eC8n5HkrpnQnQFzNwE1qv707w9cIHbv2lpwnR8aOr5D72Fl5UwCdBsYS889ATYKz5gB1SBK+duuf+fJDp6kq8LSulpVqHieUHx3nHYVynoD0pOmmtTYgD+d2UhlWEJiD6fu+r965v9gmF9hY/tDdGz54uIOTIfk/meuBa/VtZC+HtdUySMhgeGVghfrD7KBBsg8RRPiYKWPuI/RvqkxkLvhToTB9TF/KowCMaltXZhVYqOnTz2wxz6dv6TroZjtQA2QZsX7fbp2cE9ta98nO4hw0QVdUv+dy4kYAn3BZ1XOAU443xYhkA7J3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD0oqPm5OVkPAePD/TGj7tu7lrHcG2bVWHdZqtdO3hE=;
 b=th9NQaszekL+els66lw2qNwnWVaS8rB72TZukUILEbnFIW1RsqeGMKEHXrHuxiQAbuKYOXrTsyHUq/b7VXa2aeoOEzB3X4Lo5Nd17yOgbR2UOLqs9b1b+8bLC/+zs/2m7w7JPjcm7Ji5ZKfkD36xxMmh29kEtbUKKXmuFiS1/AHRfHwZHM9OV4JlfW1OO1B6ODADsf7U2bkOfIC7Mo0eBJhW5aIWQgKhHxABHauqGUf1gE+uUiz+Uck1anB7A1sd0nNmXsohOTfN2PgXo/6A6rzxnxweWbIIqlOFFQNUc03jATiH65mDIowOkze43xZ5/BQCs7VDP+bLLTlFI4dOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD0oqPm5OVkPAePD/TGj7tu7lrHcG2bVWHdZqtdO3hE=;
 b=1qOMDRQ3DFKy6tt70QgpxzTAi79cyruCpP+3LaswsmvLgRQXQoai99fg3ErVUDWDrtnRV3RU7Kecw/0W+me7DVK+FzWXyZrUyDvSKg/DGoZHwJ85IFh+TebGzAu/AlBl4q8oMWeixUQz6XHGSvic6/uHNuU6BqY4wWxcq9QhgT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 14:37:49 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 14:37:48 +0000
Message-ID: <32f38caf-8cc3-2e4c-668f-f36552b7cffe@amd.com>
Date: Fri, 16 Aug 2024 15:37:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 05/15] cxl: fix use of resource_contains
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-6-alejandro.lucero-palau@amd.com>
 <20240804182519.00006ea8@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804182519.00006ea8@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfadcd9-a1c6-45f3-f7bd-08dcbe00ffb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enhSczE0OXV6L0xDSHE0Qi9JemtHaVNqd1JNVHdPOFV3T0ZaY1JEMjFPVlEy?=
 =?utf-8?B?M1BBUVhLM2lqLzIrcktyZGdDUlNrdTNtZm1JaStYcXJSYzRsMVBTeVBVUnpD?=
 =?utf-8?B?ZmM1Ym03WnRPS3NqazNoOVFLNE5sN1ZPWURHaW5HUnBZOW4vVWJ6ZnluME1N?=
 =?utf-8?B?WndsaGdPN2hmdDViaEdZQW1zNDNjRWlPUmZpZ1ZFL3RtQzVqQmx4bEJPV0NK?=
 =?utf-8?B?d0FpRHMzYUF4SXZUUzFWb2xzTHJwUWJQWmYxUmdGMkNhYzd6eHV2S2VFbzFI?=
 =?utf-8?B?bkNLRjh3ZVZTcmpGSmZYR0psdjRRa1IwN0E5Q0Q4TS9rRTR2dXV6YWxnMmg0?=
 =?utf-8?B?RnlDMWxWcUlaME5PNy9tVGhFUFd0R3cwQ0I4eE9pdTM2Ums5c0Ftc3NGaEhO?=
 =?utf-8?B?dkhzMEVMWVVETGhMeHZ3TVM0anhVaFNNV2JXSFVrNStBa3A0SmRQZjlOUEo5?=
 =?utf-8?B?c1ZGTmN2U2NUNmVSM2dDSzN3Z1JOL3N0azg2aWZjRXhvemNIVVV0dzBiazBI?=
 =?utf-8?B?VUpsUW5JVnV0blRvRGpCNVNvM2FLTEwrdmMvUENiOWM3M08vL0J2WWk4RDRl?=
 =?utf-8?B?b1B1L1pZR2VJUkQxR1hLb0NBbXIwU2NWTUtuUHl3ME9lUDVyTmVNak92Z1pB?=
 =?utf-8?B?ekJ1Nm5yYTJYa2diam9LY0Q3Z1FVQWJ3NkpkSW1TMkhmck5OZ1FuYTR1TE9K?=
 =?utf-8?B?K3FKeU1xS0FZU0tMcm5ZVjd5QXg2azJ2TDVJbHROYTVpRytrc2p2MDgzL3N0?=
 =?utf-8?B?TlZTcTBMVzIxUnUvYXRzdEM2djBFdWpvTGhkc0FkdkhZVWtVSXFRVmdjSHRh?=
 =?utf-8?B?OHV6azJud3ZKWEk2OEtwM1RhTS8rdlZsemRHdnhsUkJVd0o2d093VzRxNXAr?=
 =?utf-8?B?MUJKS215Wi9kRGVQYnhuQndJNUI2QnFFeEQyR3dRdlZyYkt2dm5WWlpYZ3Qr?=
 =?utf-8?B?WW1xYXFtL3h4R2xZOE9oZGFXcWhhdTRMTTJqalpIWUtQbzhQazJSSWpzOUt1?=
 =?utf-8?B?MnE2dHpDaEhoUHNQV0ZreGNQT2xJalZCZTJGNUdJc0RNUUJ5dGo0UGxBNUxq?=
 =?utf-8?B?Y2x4ZTBRTVc1VDYrOWRiRWxSSU5uZkxCMUxVdkQrVTRpRFBYSXBjZ2trakxO?=
 =?utf-8?B?ZnQvRWQ1UlZSeUkzbWhna1gwelhhL0JNUENpM1R5UkZRdHpVNkY2ZnR3S2Yz?=
 =?utf-8?B?T3BOTGkvbkZUZWFvUGhiWElCN0lFNDd3WFl0Nm1VQ3VCYkwwUVI0WHlvdTU2?=
 =?utf-8?B?aDZVSDh0Zml4MzRpQWZ4OFFqV3ZRTXE3Ri9DYUZzdmxZd1dyczRTYmF1cWNn?=
 =?utf-8?B?Z3NxZE9kTm1qUnpKMWovWUY0eFplQmtQSmVjbEFseGVVNEl3ZENRQ3hROFBs?=
 =?utf-8?B?RnpxeEpUSzRpVHg0ckx0aXdCRTZ6M0FvRWdxMWVYSWx4L3JCcXVkUUdNU1Jk?=
 =?utf-8?B?VmtKOWdJdkgxak5ETndUK1FRdFdoVGZtTUxNK09tTCtPRWpENEdSMWdoT1Za?=
 =?utf-8?B?KzRNUitsMWpKeURoT0tSYWNQV0hFL0ZLL3N3YStYamJQRjg3QlFjai9uMFp4?=
 =?utf-8?B?cG9lRmRjSkkxN25VbHIrZEQ0cjhlazlmUDlzd29RcGg3ajlyc3Z1UzNqanNZ?=
 =?utf-8?B?NGVTcXRldDJxN2RENnYrSngzWXkzVFlTZ2wzSE02MXJYMUlEOTZ0SzFreHZq?=
 =?utf-8?B?OVBydHRGbmNodmZKRUQ1T0VaUFlUSndsZ1NWd1MwdTRNSHFUZFN6WnlvYnN2?=
 =?utf-8?B?ZWdWZHkxQ3k2cFMraGhGYXRSUUdUaTB0ZXpLdGxkV05sZVBEVkdXTVVBQXd6?=
 =?utf-8?B?Y2lTZDNSaGkxb0EwUlhTQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0dYU1FwTWpvTVRQNVBLTHgrUWdBb0JFbmp0c3R4bGZ5eVlUOW5xUmlxNjEr?=
 =?utf-8?B?VkkrTXRHQng1ZmhiMXMrZ2tGbE1jSnF3bS8wdHJIUmR6ZE01S2s1VWhVd0V1?=
 =?utf-8?B?ZFE1MkZKZFFsT1JzNFRjMGdzenlDUklPU3R2UndCVXJxQ01MZ1dPSG1waUg0?=
 =?utf-8?B?aElCNGYvY0padHdDbXRzWkVaNzYxeFhsR1o1YkxIYkdBSm5CcUxncU5KQ2Jp?=
 =?utf-8?B?dVlvQmlyQXAwclh1MitsUHVxU3hRQm9RL0ZSZ3BqN2pQOGRxMVhYUzltMU9Q?=
 =?utf-8?B?Ly82eVFTcDBvRXZzWEZZelFMaFF3aEpMYnNIcnhpK0U5UkRCcE0vc24rVUY0?=
 =?utf-8?B?cE9GS3FSWnBoN0g5S0ZCL1pxb2dYa2QrRm1rc3I2VlI2NjBPSlErcVdndWp2?=
 =?utf-8?B?TUkyRTVtWnk3VjhWbnBZbEJrRG1sUFR0T3hyeloydk45MCtCYmVKelJQMnRt?=
 =?utf-8?B?OVErOVFNQXFrc0Y2RWtleXo1aTEwWXQyRkhHb0pham4rb0x2eUZrWUlXa3Fk?=
 =?utf-8?B?cTFmQktMSURMMy9tS044SVZZUHpMc1Rjekh4aEhYVVJnRk5kMEpaKytEc296?=
 =?utf-8?B?dUp5WUR2dVpmc2QzTzBmbFAxbnBCaDZERXovd0RpZHc0V2lld3BnbzNkTkhE?=
 =?utf-8?B?Z3pKalRWejlUUllsSHRYSXprUU9iaHNCS3FjR2lyZUxYWElzM1hGQ2ZVMVdF?=
 =?utf-8?B?L1piQktzaDVZNnBTRm9TWndpK3R3ejgxSTFZenNlaU1jUHJoUVdqMTFOMzU5?=
 =?utf-8?B?QkRjeGc1T3liRGVOc3RnOTBCTDkzNjFmM0VpNUxSUmpMTzllNDlvaS85aXhw?=
 =?utf-8?B?TzZJOHdrVGErRnc2Y0ZtRFZQc1dMaW5NaFdWaGZ6QVdxcktVVFNmVE9pdCt4?=
 =?utf-8?B?UFl2T2V5NHJ3SXNzM3ozQW1hdldQNGFPQ3dWSWlpbEQxSCtxWlptVWZrT3pi?=
 =?utf-8?B?KzUxM3BKdWRhb1k3TFhMdkY2d1Q4VkpaY0xHUjNITk1HblltbWxDNmRkY3M5?=
 =?utf-8?B?RmUxcm50dFg3MzhaZGhEWkticHo1TVN6TWFnc1BBMUlRNHdlWW5XWWRieHly?=
 =?utf-8?B?eFJjS3VMTFdFM1VqdTFFa3pJdmNjSEVHN0l1TXpwcVF2aEhDOVFxZ2RkSnMx?=
 =?utf-8?B?Q1NrbjlLUWJOdm9Ea1JpTWtVV0h3VzJHc2lvb2hWSFJyK20yd09mS21odWxs?=
 =?utf-8?B?VVVGckl3U1g4NXFic01WWWhrcERidSttZUVYcmR3T0xCclNkRko2ZlA3RFBl?=
 =?utf-8?B?dklUUlp1aFBBb3BEZzJDK2g4aVJWQklLdEJyRy8vOUV4bElCT2RsWFI2emd6?=
 =?utf-8?B?K2VWZEIyNTNSMWtLT1lRdTl4RU02NDVQekZNOVFIbzhyODcwSFB1VjB1VHUx?=
 =?utf-8?B?WGIxWEFnaWNrZWtFeEZFR1liRHljWS8zL3dpNzN3UXVUSmtGemlTdTcvU1VE?=
 =?utf-8?B?bmkxbGRBaEwvM3lBU01kRk1EcGs3QWxoNk45elFTNTdXQktGMU1lV1pPOWE4?=
 =?utf-8?B?dkE5MkpNZnh3WlF6SFJNRXFtd0k2My9SMElIZGhyVmhkQTlZZE5oWkw0YmNk?=
 =?utf-8?B?TkZrU1ZBNWNhUURoVlI4cG05NFFaVmRYMlJLTEE2RmdaR1RvaG1HOUNTcFVv?=
 =?utf-8?B?NDE1VXMxVEFoekE4enUxMFYvN2djWURDSjluVVlEYlBKWmlyNWhiVWsvQ2Rs?=
 =?utf-8?B?TmxSeFpaRU56djgwejFlYjZOczdteHM5dlRYSllNWU9kdHVTR1pQaTJiWDFp?=
 =?utf-8?B?UERVM3kzMUdVTVR5Sm1yMHFRKzF4ZkpEaDRJbWkyd25sTzhWMjRhbVFkSTlV?=
 =?utf-8?B?VUx4bmY2MnJBckJBbjFwT0pMWERaeElRVm9FN0pQVnZsdm9DQnZFRjhDcDNP?=
 =?utf-8?B?bmFXNnlDVzBSdTZFais3K3lheTNXNlV5ZEJiaTFGUFBhS3J3cHdQOUI1WWhl?=
 =?utf-8?B?cktWejA1TzBya0VkQmFQc09BNk5kN2picmhVNlArWll4dHp2bGthV0d2YVUv?=
 =?utf-8?B?RmxOei9nRSs3OG90dTNsNGNERnRQVkptb09KcmlWQ2F1b0ZiN0lFempvVXkz?=
 =?utf-8?B?ZnZCUFhQZm0wdU9PMm0raTBySXVDWElNYVE1QXZTOVVoM240RGZ3NmpJK0FF?=
 =?utf-8?Q?tZtgK9yKcGbq6xjip6NMTY9dJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfadcd9-a1c6-45f3-f7bd-08dcbe00ffb2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 14:37:48.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dmPYgg8wEqlx+B473P71gwaQbfWKzcAeOzKh1t0jdCchlnlcPpFU1SIiUhgAfmox+DQg/abV6mQnKhoAPqqAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922


On 8/4/24 18:25, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:25 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> For a resource defined with size zero, resource contains will also
>> return true.
>>
>> Add resource size check before using it.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> If this can happen in existing type 3 case the fixes tag
> and send it separately from this series.


I have been looking at this possibility and although not with 100% 
certainty, I would say it is not for Type3.

"Type3 regions" are (usually) created from user space, and:

1) if it is RAM, dax code is invoked for creating the region

2) if it is pmem, pmem region creation code is invoked.

None of these possibilities use the affected code in this patch.

There exist two options where that code could be used by Type3, which 
are confusing:

1) regions created during device initialization, but for that the 
decoder needs to be committed and it is not expected for Type3 without 
user space intervention.

2) when emulating an hdm decoder, what I think it is not possible for 
Type3 since it is mandatory.


Finally we have code when sysfs dpa_size file is written, which I'm not 
familiar with.



> If there is no path due to some external code, then
> drop the word fix from the title and call it
>
> cxl: harden resource_contains checks to handle zero size resources


After the explanation above, I will do as you say.

Thanks!


> Avoids it getting backported into stable / distros picking it
> up if there isn't a real issue before this series.
>
> Thanks,
>
> Jonathan
>
>> ---
>>   drivers/cxl/core/hdm.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 3df10517a327..4af9225d4b59 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>   	cxled->dpa_res = res;
>>   	cxled->skip = skipped;
>>   
>> -	if (resource_contains(&cxlds->pmem_res, res))
>> +	if ((resource_size(&cxlds->pmem_res)) && (resource_contains(&cxlds->pmem_res, res))) {
>> +		printk("%s: resource_contains CXL_DECODER_PMEM\n", __func__);
>>   		cxled->mode = CXL_DECODER_PMEM;
>> -	else if (resource_contains(&cxlds->ram_res, res))
>> +	} else if ((resource_size(&cxlds->ram_res)) && (resource_contains(&cxlds->ram_res, res))) {
>> +		printk("%s: resource_contains CXL_DECODER_RAM\n", __func__);
>>   		cxled->mode = CXL_DECODER_RAM;
>> +	}
>>   	else {
>>   		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
>>   			 port->id, cxled->cxld.id, cxled->dpa_res);

