Return-Path: <netdev+bounces-98936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49028D32B6
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8F0283334
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D415FCE6;
	Wed, 29 May 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N167QrZC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887236F079
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974181; cv=fail; b=D1pQoWJkbtQsK+x06Ck7IyZAmtEM4IDGAfdrNO4/7vP93Nb8hfcq0n/wXxPMnNmXL/BIxFIHaWPorXvi8Cygd0JCTSWJJxiI+/C4Z5HmSWoIZGWr4SyHUPc5Ychq8daxnekGlO8taXSYOdzYnMVQkQ+wRiN8OMEPXqY6zZpYpjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974181; c=relaxed/simple;
	bh=iT9sYeEtNtrHSUdiDYTLs1J7LlNqMyH+zxMp5rVB5h8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aFHsmbX7TLWpLSFNS/n4U0T+MKkTlq7R06wJJJ5nyIhMfnG/k6OTqPCfeU2R5ocsgZU5V6SAyKtAWLlCtKw0CVehFSFxOGPWUPb4c7ha38T9YHMSM01ouHlhZljbYPZsHp/yGr8KJ225PcapG3WAG1wsX8ms5OstYW3O+5Rlux4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N167QrZC; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK7AfvFzIr5W6+ZxovE96D5ecEEz+xA5ik4Cdg76Q2jieTqaHA5w1Y6De5an5LdiVATwfA35NSvCZD6tln5lGWtFZlll8FNEWNXZVdLxFWwkNd6mw85IiZ0fYxQ2YzXpe5W/A9bh0fFfcNfIcPZpi8rlecTZ3o05KKt6BZsiwgmk8dQk7SdnWrzsRAjFHNTeq14udMEG+1sUAvKfuhdQiiL2x6KllD+Gu7tf42ytY7gyGinrsiezwLi6ZZuO96tfoWegow5JOH+0dfWc9Nruptn44a/ZXSrS0BURO1xX26iBpJ26SXV5ultKWw2Tl6XoB+N311P7Wi/GypBFU1F+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JFNigM+Oj3ZHgOzY37mj0U2EemkmTsUGDdp8yhCj2o=;
 b=XH6Wq+wd3/5qhxOVZODkPd71tWRm5fIRUBnjLqSFZMfnBmvosvvuddyaEpKSMl7zBFwk5wZlcgWOmUi0tpkid21UlmbvQ47HClShUTnL8KrcST+3fny+l+g46Q9EPWhslDNN5enzZ9g2sJrAVtP3nJpRCpDUN4fFDWTvLvkTf2mjZv+BwV9/TUWkTbGg7pfvQXLDR7uCJ2xrr+o6am6Xaymn5XZcb6Oj9HDiGIAzbAxn+rHnFagUGEL3M3kknm2hHpX8g3kPFTglnxaGuLQLMDzXarwqcBTWhn3MmJBsfKBHQxNonC+g4EaI2w1F38is3xLHa0fzlqNPnf2mVT6UpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JFNigM+Oj3ZHgOzY37mj0U2EemkmTsUGDdp8yhCj2o=;
 b=N167QrZCJ1LXhxBMSQDzrW/Uqde3BqlaEg1AoNnTLTZUqlQeRwXTJTmQqi4Ky4rGRN/KRrKXme1/D2JbGAGmeO1Lb71eyCEoCggVAE+3OVrgLCETElq53IG+CsiGKE4hNMVgpSOU1aMNp2HCRXQh8vVMzDvjkj48Q8UlKsHT0mwOst8PWx02eT9fkNIxM2j5FvO2gOGBF7k4TP+wFrTQxgpA+pWNdzDGatxJwArGVRGrudI6cf7fYX+demg1w7GNibhGxuuZ5cxYa+zlNl4I5ApNYyjFkhuqxtB+LVIHv21GCCJKSW7nDNHNiiwy5127rAW92yCMyPaUIOPZMiAKww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 09:16:16 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::35a:28cb:2534:6eb7]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::35a:28cb:2534:6eb7%4]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 09:16:16 +0000
Message-ID: <3da2a55d-bb82-47ff-b798-ca28bafd7a7d@nvidia.com>
Date: Wed, 29 May 2024 11:16:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP connections
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, willemdebruijn.kernel@gmail.com, gal@nvidia.com,
 cratiu@nvidia.com, rrameshbabu@nvidia.com, steffen.klassert@secunet.com,
 tariqt@nvidia.com, jgg@nvidia.com
References: <20240510030435.120935-1-kuba@kernel.org>
Content-Language: en-US
From: Boris Pismenny <borisp@nvidia.com>
In-Reply-To: <20240510030435.120935-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc22ab3-9027-4194-9b92-08dc7fbffe80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c09id0FQNmlXUkdRUTB0NEl6TVJrUTlHc0JJZFpiUUw0eWQrRkpKL1NWSlAr?=
 =?utf-8?B?Y25adHZlSHVBM2hMaDllbEwwZDlXTmZ2NEVFU1BMVmxaeTNJZjB3UXM5bTBh?=
 =?utf-8?B?bEthM1JPdUJRcDJaZHFXQ1lRU2tVM1ZxNHI2WHUvMUlqT05JRzNWZUFrYWZu?=
 =?utf-8?B?TFJiU2NqbWFDU2hzeXZLZGJUWS80UEJ2SlJvOWFCNHhyTStIbG91bHI2K2o2?=
 =?utf-8?B?c1hPRW9KZFZhZ2Z4M0ovdHMzRnEwODlzZi82Y01tQnRVZ0ROWDZsdkNTU2p2?=
 =?utf-8?B?YTFjTzRTaEwzOUNHK0JrR1BHRFVOc29pZGxlbDNHVVRsUGI3TEROZEUyL1J0?=
 =?utf-8?B?L1A3c01BZjlNcGdvOHNmSVpkZHk4U0xhRU9iWlpCS3o3Mk1heFRkNEZBZUxa?=
 =?utf-8?B?STFLcE96YXNwbzdHQWpDVU1kd0tzelVkOWhsVnBnNENuRlNoamhQelpFNHd3?=
 =?utf-8?B?WEJWZGpzY0dBNEM1emV4eVdFME52ZnN2NW5rakdxT2RxLy9FcWpzcThrQTZn?=
 =?utf-8?B?L3hoYTFjYStvcEpSTnE3T20rWEFMbkhzVS9EYURRNWgyWmtPMys3cm55MndO?=
 =?utf-8?B?NUt3M0pVVWZXTEh1M3hSVGlITUZQV1MzNDhBZDJMOGR5amRISFQyUUZoRSs2?=
 =?utf-8?B?Y0E1SGxHM0FneVdyUHc4WkdiQS9EcXRMV2puVmUzb2N0SjVjbWtkaTFvT09I?=
 =?utf-8?B?TWF5RXJ6eHhBUVcwNDJ6MjNjc0V3UHNNOWJndUhqODdRUWt3SzJ2TXVDTnls?=
 =?utf-8?B?alhLbDFtc01sVkQ5eUo1Q0ZsbmUzNDZzZ0pLV0Y1cVpXVFF4dmxRNi9XbXNW?=
 =?utf-8?B?NEV3Skg1ck95bndkczZjem41VkQrSitZVWsrdXhveXNiMDZDUVhLRENib1h2?=
 =?utf-8?B?MXJDNDhHNmFpeE5PRXhYeC8xaEd0MmlVZWUxcERGNFFFcVg3UUN1YjZEUnJq?=
 =?utf-8?B?QUpxZGNTOWZZOVhtaFViUXloa1UwZU5paDdDWEVuWkE3Rmxoakc5MUllb3R6?=
 =?utf-8?B?YklFRlhkQytVZi9lRDZJUTVhcUw3bUVpdENKa2xTRUlZQlAxaVMyOWhpTkZy?=
 =?utf-8?B?aHpkRnpoc29ScmdsSEl3TGZoUXJnVHhic081ZWtPWXFWRWUvNmRWWDNaWHht?=
 =?utf-8?B?MTJ3anpWUG5lMEJBT0Z5aHhuS1poZEt6bFdXWDd5OUF2MFJ6bVNOY09uaDNi?=
 =?utf-8?B?UExqUVI0WUgzQUwyS0g5ODlZa3llQXE1OGowUjBtd0lmbXU5ekk0Y2hQaVpl?=
 =?utf-8?B?SFVFRDRzTHp1SmJ0M3BuOGppZGt1cmV3YW1jcStVUU5acFBPY0hCSGZHMWJS?=
 =?utf-8?B?ZkdkUWh3OXFvMEoxdHFYMVRaM1YxTWJJYkJhbGRjVEVOMWlZaUJia1JHL2pE?=
 =?utf-8?B?QmlMMk12bWg0TDEzYmZZeXFmb0E0VTlYUDErbThoWUxjRzZJejhSQ1cxdDRF?=
 =?utf-8?B?a2tWM0VCV0RwbFNtMi9rU0VtdVFmQUNWbkxIVkF0SkpZbGNCRDNES2l4ajFp?=
 =?utf-8?B?NU5EN3huekozV0U5WE5QQW9FWk04NlpLOWNjN2FtRDFVZ2VycGFzNVlkSkU2?=
 =?utf-8?B?TXFPblJ5UzZHTzM4R3phUmlpRFNlSG00WFJNZTNyVXp5bldKd3ZjeWN5TGNF?=
 =?utf-8?B?b0VyS2NjdnVGV0g0WFB4UkhiRXNNYUdoUjk0M1hyNTBKQ3RXb1Z5eDFRRS9x?=
 =?utf-8?B?YlY5MXlGTjZOVFFGSVZncWsvbWFxTVhOSVBLcmNSK0xuM2JYL0tJK3NnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0doYVR0SlhRK0FhVUJSbmdHSS9ZTHdRRks3d1FtL0I4alhoTXh3MnozTWlC?=
 =?utf-8?B?MTUrZmlXVS9HUWh2dWQ3YktDQXFqNHpYVnphcWp3eVU2SDNtdkovbnF1RGxn?=
 =?utf-8?B?QVc4SXZhRnFIRWcxckJEL1lPRlpEZ1JaeXdJNDNFQ1Z0L0JZN0VRYTBRT2Zo?=
 =?utf-8?B?QjFPOW9yZkY3M3VMeE05K1F5SDhqajVVMGZhUEltMm4vQnl5dzNZVEpNY0kv?=
 =?utf-8?B?ZzVPTVBHdGpybVYyWXpLYXpqTjZqUjNLczlJVVhLcW1VblQwTTdpc1gzUFdE?=
 =?utf-8?B?N1JUUndKeEF6Q2V6dWo5T2ZRaXBYSmJpQ1MwM2R3MmZLempKaGZLREw1akg5?=
 =?utf-8?B?K0c5bWhMSzNVc1RaVWo2RkZrL0o4ZHduK2lFZEJ3WXdJQnhxQVM2UytCZGlU?=
 =?utf-8?B?dVMwVVFSOEh2cWVYLzYvaGRhNXRZRjJ4cE5DeWJUVFVGMmwvTUZ3bDc0VnFO?=
 =?utf-8?B?NEs0YTVDZjJkUHUzcFNTSEprSXdUeXY3RytYcUpHNXpYV3ZPaVJvdzE1UUls?=
 =?utf-8?B?NjJsYk04USswMDliYytXYlhNTzFMQkV6L0JjMldxaEN6d1JVVWhmRmIxTW1N?=
 =?utf-8?B?UnpsUlRLUXpwbEZJcWFSZnRkdk1aRklrKzFoMU4zQUVXVmFBNG5Fam52K05X?=
 =?utf-8?B?cUlnR3BmSHhXbTIxRlhvRU9JYVpLVk1VSDhhbFg2RSsvaHRROHhGYzB0STJ5?=
 =?utf-8?B?VTZFa0JUeE1maU93NjBJZktsYjlwdmpjSnlHdXdndEd6MTRYY2JRcXMrcXA1?=
 =?utf-8?B?YTZrODNNaWl4aHRoQytWcERwQzVMRWZlbVdZU3QvNjUrajMrVTRoM05kL0tr?=
 =?utf-8?B?V3NMWWZPZy83YlJDMzBhTVA2azdqQnowWW1lWXZ1dUFqN1VCNUVYKzNKbDcy?=
 =?utf-8?B?eC9abVRTYVpWY20rOWlVV0lmejJQaUZVVmN6cnVxMVFNekVuRjF3dFdybnVB?=
 =?utf-8?B?VEVKa1g0RWJyMUkxNHozVXc1NmVjMHh4QmdMeFBJRWJ3eHdOZW4xKy8rUmh2?=
 =?utf-8?B?OXdJVWJWUmlZMCtvZW94akxNajNUcEVLckhTUldhRWRaaThKbmRkUm5sRGdG?=
 =?utf-8?B?S0llTElqM3ZMbFBwUm1HaExhZTlGRE40dENaVjhCQWk0aVZsRWU5b3hzeW05?=
 =?utf-8?B?R3k1Tm83Y2EvVkE4KzhBSThmTjBIbG1jZnE1ci9xR2NJMjRqOG9NMmpIaitC?=
 =?utf-8?B?cG1BRGhiaXluR1FXeHBxQkE1T3J5cFZsZ1VtbHRzb2dwRW9oOXJFaGNLM1k1?=
 =?utf-8?B?dXJycllaSnpldWhPZVJ6M2hSV21TbHQ5UTZlM3ZrQ0oreldjdVphUjR2V3Ry?=
 =?utf-8?B?K1lUNWxtMk53TWRSTGo3bWE4cmdUMW1aSGNLWUpFUEFnWmFvc0p4YytxazFG?=
 =?utf-8?B?bjN4dVdxaWZtVFhEZFhFU2xDSEIrYkRLdTJncktGUndpOUZwalFXNHpvV01r?=
 =?utf-8?B?ckk0VXFpYWgyMG1pclY0L3VadHhTMUx3OXptRUU5RkpoQ0kyRWk0RnBsUzh5?=
 =?utf-8?B?Q2VLSXc4WWVtdWF2LzRtUFlFcExicXdzNTQ1OWNJclpVdnNqa1gyRHFjbEdB?=
 =?utf-8?B?b1VIY1lVeDErL1dYKy9rb05lWkRIZGkyUnIwVVdhT052RmZMazd6b0tqUjdn?=
 =?utf-8?B?YldaNmdvTkZ0cjdBakxGSm51S2xYbkx3a1NiREhKNldqSzFaVjRkSnMyKy9Y?=
 =?utf-8?B?dzdvdVE3WmtkTndYR3p6VmZhWUNIUVRjdWdVTWxyMmFNTE8rc3NSYXVwWENx?=
 =?utf-8?B?aWRQUjJXekorS3VJejFCWW5xeC82UXdaeHI3SnBVTjA1N0N3cVc5VWRSQzZK?=
 =?utf-8?B?U3BrOW16V3JiSlpYcUI2WGVUM2dOSTNwNVBMN2NkWW5OOXNha2NQWkU0UmZa?=
 =?utf-8?B?dy95UmdScjkwQ0FKM24xbjFPWXhMZDFZZHJNajhZOWJCeWxrSTNuRVYvZTQ4?=
 =?utf-8?B?QjcydEFYbDdUWlY4bzRPb2QzZk5pMFJFcnltSXJRM2VzbUgxRDJSSzJvMUVH?=
 =?utf-8?B?L0lXWHlFbElHWDhCM2pjUVcxTmhiK2xSTjJTK1UwTFJNKzZucnVZMUV0NE1H?=
 =?utf-8?B?MUZrNFhKcFV6aVdha240OVFlcURPZ09UOU4ydGplUnNMcVpoU0xxK2hDbEZN?=
 =?utf-8?Q?ddCvyfNNASK0qvYgJzyzsst55?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc22ab3-9027-4194-9b92-08dc7fbffe80
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 09:16:16.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfJv5SwWc0uibZ6X5u+1u58GX/X5gjfnVrGUyr6hwYsmDcN+evlf74noz+q+Syh6xF+adwv9e5jRzTCfpso7Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069



On 10.05.2024 05:04, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> Hi!
>
> Add support for PSP encryption of TCP connections.
>
> PSP is a protocol out of Google:
> https://github.com/google/psp/blob/main/doc/PSP_Arch_Spec.pdf
> which shares some similarities with IPsec. I added some more info
> in the first patch so I'll keep it short here.
>
> The protocol can work in multiple modes including tunneling.
> But I'm mostly interested in using it as TLS replacement because
> of its superior offload characteristics. 

Hi!

Thank you for doing this. I agree that TLS-like socket support
is a main use-case. I'd like to hear what you think on a few
other use-cases that I think should be considered as well
since it may be difficult to add them as an afterthought:
- Tunnel mode. What are your plans for tunnel mode? Clearly it
is different from the current approach in some aspects, for
example, no sockets will be involved.
- RDMA. The ultra ethernet group has mentioned RDMA encryption
using PSP. Do you think that RDMA verbs will support PSP in
a similar manner to sockets? i.e., using netlink to pass
parameters to the device and linking QPs to PSP SAs?
- Virtualization. How does PSP work from a VM? is the key
shared with the hypervisor or is it private per-VM?
and what about containers?


