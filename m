Return-Path: <netdev+bounces-192628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319BCAC0916
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B24D7B524B
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738862882D5;
	Thu, 22 May 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I8SCrPP/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DEC2882DA;
	Thu, 22 May 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907583; cv=fail; b=PD8gxlY/vfldSpcFWP6VHcJkWG1/CJiIowxDAuoheez2WAYgxW1nIrHQZJWyhtD6XUtu+IxV/rnDzHAuQKEAi6W8EOyHGzLZ9U6E0IsB9rNyPa1HCIHuyk+dwKKvodmSZ21gfpMAXJtFuKuFpBgfAx48MZeTGkyK89YlhQsM0Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907583; c=relaxed/simple;
	bh=hgiRmu4hdOTYmdJT2K9TQX/vDBDg1u9MrC2EyDks09s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qDDQs6CpX8mhoWDIhBLtlC54dLP3yGBFP0y3ULC7K1zB9YD5XzNcGHh5OCvd+jR24uLTIN9swZmXttvQA++sZh8TDZzxPtAxlDfe9zuw25I0kCW/tk6sxgLk5NWisernp9uQiXIhKYOseP/2IgbkfYtVa9UiBOL4oGq188aqT2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I8SCrPP/; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlJZlxmXu+zI6WsFkxNupB8F3QmKUhz8L1DhcBdkX5P1PkG6aSB65J2QFi5pemO/oJ0oSp6QuCusmyy8NqljSwJei+6Z3RPeXuhmxiixlOGx8d4s1bbMQovt2+cgLFMHXjnaTArI0bHLftX9a+bzmgdNlKX4VQH8q0OHz+mCjHfvMCJg1kMGolXJ0Vswrp6jijSX7ZErxW50Sv+7fi+i8gTOhTgwZSockZ02ewhqrJn1jmPJo5NNxGmbAIUVPAbtg7WQ4WylGf8Mc++z331IcJn2hHP1HN6lB193KhZtgu8YuSm0qe3iytqDnA8TWx5kI8/5i8w3sHSE2HYq9QVwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aL5s/TayqALZZ33GAJ9kokIaSuAT00jZh5pg5PvN/c=;
 b=eEYUrBA1zUBJlp99/BF3S9pUQGlwj4VWJQrGXKdPb8PUHvmfK0F1XxHxGnhE/WhcxKVH9IsppyGgoi24o0t9n4O3qk0rOcvmwmnnxv7G/ErYXDQngXajfrM8s921EWjlTneV73iwKb0l/3ZOETiviXA4O3Ki4rW9nIFG+bdExHsgsULkfSzffDfkGsHv9LVH3sZ2fEhKE9J7RmosuDr/8e1OFKeW1K3LanmmpvpVBfcgahshOmYgEK8n5F0RDKdkTdiQM4nZcwD5rcgDMxiQwWLcFmmADETLx2pNV0eAzd2kMvpbLZCO6Jly4veMzmr6/YkGUoKzo5f3S/wVlz5vnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aL5s/TayqALZZ33GAJ9kokIaSuAT00jZh5pg5PvN/c=;
 b=I8SCrPP/kZryYgZQ+xniBrNbe1Gikv2Y3xo5C6gkfrpL+vbZJYCF4VZxFtFwWrwgygNgl3wVcJbLJmMuLjsyMpvUI5YZEO67fVyC2rXg7GCV32mUHPyS0NLe/bMN5x5yyDzrJ6uwU7nWIOJv45GFw6Ds+XbPM9VPZxU6BGhWc0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Thu, 22 May
 2025 09:52:55 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 09:52:55 +0000
Message-ID: <d64fad40-20f9-44ff-867a-8caacd70767b@amd.com>
Date: Thu, 22 May 2025 10:52:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 05/22] cxl: Add function for type2 cxl regs setup
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-6-alejandro.lucero-palau@amd.com>
 <682e1b368fc8_1626e100c3@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e1b368fc8_1626e100c3@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0135.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e26bc05-63e6-4b3e-9a00-08dd99166c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUF1aEtHQ1k1ZzI0SzVlbGtPQjg5dzFxN2FZdTNGd3RJcHB1bWZZSlhPRmI4?=
 =?utf-8?B?bVU1UkdZaHl4Q2RpR2RqR053SEdiQ2FKd1EyTzUwVUFIOFJDT081ZnlUNHBZ?=
 =?utf-8?B?eWg5Mks4dzJ2eGFTdENzQnJUYW9qV24rVEVMeWFiTFcxY3Y5QlNYbjVxSGRD?=
 =?utf-8?B?WGo2SW5NS0RXK0d5cjhhc1FEY2tzVitEZ1VVRUEzTmxYMWxTTWpRTFRxNE9N?=
 =?utf-8?B?TSsycGY0VzQzR3VjZWlVSTFOellodTFxZlB3QS81OUwrWGdMREFsZU04SSts?=
 =?utf-8?B?Z1V4NWFGTHE5UG1PMWZGRjZJOEdwUFBkSjdtcUJOWU0xcXU4R1JMQ21RRWIz?=
 =?utf-8?B?UUVMVTRjcHd6K1paaVJTc2NyeWlteVlRTlBWSXNKa0RxSXVSZ2dhQnR5bm9W?=
 =?utf-8?B?M1VKc3RmYXpqSjA0WThkZ3VMYm9OenVHYUI2WTF4S0ExUWFXcU81SzlkOUEr?=
 =?utf-8?B?MWdES2wyOG1XUnlHRmN6WEVxODNEQm5rZy83ZWhJNEFuQ2NYMzZUWm80eGpC?=
 =?utf-8?B?RWxwZDMzK2hPTlpsUjd6cUZybEdwM2prbEpyVFhQZk92dTVVZFdhZ0JzZXRF?=
 =?utf-8?B?VllqdDFxeU9BYUxaR1RGQ1NyS0o1a1YwdStFdktsY3U5eDYxelFadWM4eWE2?=
 =?utf-8?B?RGQxMk5sbUpjWkE0WWRQVDdiQ1Q2bm9rWkNpdjA1MDRBY3FNdWozRkM0MWFG?=
 =?utf-8?B?L3c3b3Q3a3RXVGRqd25YY05Pc0NxOXpsVERRRktZandTSFdFMUZZSElQcDlR?=
 =?utf-8?B?R085YzJmOVVNR1BRRDA3Mm9jUk1OVlVZdHp0MG9oNmhhMUc4NWlXeTZjMDRh?=
 =?utf-8?B?UVp5cjNOenZCd1RCWjhpVld0NUYvbnArQUErQ3dDL3c2OTJVeHk3RzBXdSt1?=
 =?utf-8?B?UDZDN3BaSXBGaHA1TXVVOE42dUxNU2ZUanRrZ240VVYwK0hST1RGWE5uVXIx?=
 =?utf-8?B?Qll1ZW5rMHVZbEh6aER3ZzBaTVUvUFh4S2FKa284ZXNwZjg5c2ZhMUVlb2VN?=
 =?utf-8?B?NGZLRHJJNVBlbGtjN0czZ0R4RjhKay9lclAvVE54c0NJOWN0aEpSWGtvZXps?=
 =?utf-8?B?ZmR3ZGE2K1NxQWtuMGQvL0lmZ1lkQTJlVmF3MmlvR0pVazc3SS9oUVhBektj?=
 =?utf-8?B?ZTllZHVBUjBhdy9kV1hCWjVDakZTQ2hSUHJDRllwdkkwRjhqRngxTndQMEVF?=
 =?utf-8?B?L202S3hhQlIrYXdCc2hsUkVKcmlxUStybEw5bTZoNzQwME9ZY2U5WlpjdnBT?=
 =?utf-8?B?WU1yUWdBR2pKOFNiRjBPK2xBVG5nWUlwZnh4SHZZcWY2OXZZVmFILy9qWjlW?=
 =?utf-8?B?ZjF2Y0dSa1gxUGZmbkpJTmVXVlgvVS9wbCtUZ09YL0VXd3FiZlpaT0Z0bnpx?=
 =?utf-8?B?UWsybld6Tkp6ZGd2SjhNZmtaRHFVaTFHZXNoaXQvVkZ0YnlabzhVVVZQNC9s?=
 =?utf-8?B?STJyYitQdHdWMVlVOStLcjNHWGpIRDF2eStIcHo1RG9LREpkZVZac3cxa1hC?=
 =?utf-8?B?Q3RTSGxNc05oYkJCSnd6bVJXbk5xc0FhZHJsa3pmT1JteXlzTlB2c3NWRGNI?=
 =?utf-8?B?YVBlK3JGa24wSUhuN2NoOEttemwxMkg2dStlNi9DOGpOdW9nV0tjWFlkVVVQ?=
 =?utf-8?B?RWtqcDkwSTA1S1JlbjJyNm1LK2Vwei9GaEhqam9IUGowUkJ3KzFjZVBySzFl?=
 =?utf-8?B?bTZlY1hFbWRhczRWczNNQk9QeXF2c2hlSDl3Rlhvd2FPMkthYWNyT3cwYjZo?=
 =?utf-8?B?YkFNTktLOGFqc28wS0Q2cFhXakY4Tk5ocWt3dk1Mc1g2MHZvc2VXVC9xNnhz?=
 =?utf-8?B?SWozVEtBeFV3M2p2WlNodE41L244RVdLbHI2MEpQNEtwa2FvRnFCNTdUUVhO?=
 =?utf-8?B?QTRkUXluVWVLQVk5YVdkTXg4M3VBakRGRTVmTjFVNzI3WnhnbjhyQ0hFQ0JF?=
 =?utf-8?B?ZjJ4bGs5aDlOd2FOK28rRE50SDJ5UFY2SkI0bG81VTc3K3FZcnNZS04zR05F?=
 =?utf-8?B?eUlvZ1BveU9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzFVQWh5M1RiNkJFMWxEdXFoL1dTYzNWZURabzFBa1BSZWdyYVBJTHNMNEFB?=
 =?utf-8?B?Q2xSNTd1bDc2ZThCckJoc2liNEErenNwSVFQMytiZ25qQXA5R2JjcnJyd3lp?=
 =?utf-8?B?VzFrMTZHbHdMWWJ4Q3gzZUNBMDRWdCt6cHA3ZDg1SUUwUWJNaEp3d0hkSWNU?=
 =?utf-8?B?ejNjdUhhbnF5NE9CKzBVelVRc1cycWVRVXcxM1Z3allOK2EvT0dLbHJyZE9x?=
 =?utf-8?B?Y0hDZUYrSzcranBPUDR5Nm1rMmp5RlY3d1RHYy9EU0JTNkNqdVl3UUxrQnJJ?=
 =?utf-8?B?ekhISUc5Tm5FT2l2L0FvVU41dHZwYTNURENGTkU4TWE2SGlBaW5ONjhTeHc4?=
 =?utf-8?B?TEpwOTlpZzJZbFgrWXVlK1lCNHk3R3l5U3F4VngvWnNuN1lhUVp3dnhVRWR6?=
 =?utf-8?B?SHR5azJHakk0cUs3eEVoV3FURnRtL1lOU1o2encwQUV0WVF1SmRRaGo1Z3BP?=
 =?utf-8?B?THpGQWdJQXd3YmVXa0s4Vm9lVHkwR3Q4WWRqWTFScVM5bFhYWTJJS1daTXVp?=
 =?utf-8?B?c2FDMzVBdk5pVDg2ZEJZN2IybUowSURCWXI0dEN4dlBnaW04eU5mbytUU3Zk?=
 =?utf-8?B?RnZhSjhVajhpUVBGOFYxK3QyejA1ZVpZS0dIT2Y3S2xETThWcUdKVnVWMzhn?=
 =?utf-8?B?MXpiUlp3SVZCVUNEbW81U2xEUy9LSUw4dUR2djNQZXkzVXZGdUlibFdIRVQ2?=
 =?utf-8?B?cFcyRmpjMHZUOEI4S2dhV1NGczhWRUI1Rk5zVXFMVHZFYmtGT2hURk52U1BD?=
 =?utf-8?B?aWpzL3A5OVg2VzFpeHVjazNWcndoSXBrakxwK1owd2huQi9QZHV6Q0xCd2ND?=
 =?utf-8?B?WGRSMUEvS3dVcUZVeDZZcExTSXptQnVjY3RPak5jRG1KMmRhdjlTZk1oTmkz?=
 =?utf-8?B?ekhqcmNMK0NBbFhaaGJqdWdQQWUwQncvUjdZMXBkdmk0SkRGL2xzazd4RjJy?=
 =?utf-8?B?Vmtodk14UUpoQXJVMVhBTW0zSnBKRVVaaGhCK09XL2pBNzZlclk4NEMxSnFH?=
 =?utf-8?B?cElMOTdSNkNsYm0yU2FscER6ZC84OTZxS0FoQU15MDBwWEZaZ0NObE9PV0VI?=
 =?utf-8?B?WW1KWTBmMXlxN1liWXFFMHFUUngvRm9TRzFtbnh6Yk4yOURoOTA3cGQzQ0V6?=
 =?utf-8?B?a3ptSkU4MWN5Z25qRnU1dURIcGtOM2ZOcmRuTCtRcVFib3MreDR3bWx3RE16?=
 =?utf-8?B?QWl6bitxY1pKZjAwMnQwM0pnYXg4RHRicTJCUlNuZEFEWTJkM2VUbGhGY0pq?=
 =?utf-8?B?b0FuUWFHTzgzeWxOUTBkM3huU0RTYlQ4SU5TNlFZZ1ZzRjlucE5IQkM1WlBs?=
 =?utf-8?B?YjViRTA5aE5HbFNsbWJDRE1aMjhxL0FIZW1HS3JDdWs4Tk9uZnFhUXRmaWtS?=
 =?utf-8?B?bzM4akFPa1FVcWpwc3U2amdYZFBhQ1RNRkhhMVp3MUVWdmx5anVBWEZ4QUpO?=
 =?utf-8?B?bkF2cmJVazJHRzVJYlRCMlNnbkRLWU1nTnNlbHJxbXp6MnFWV1lvZlVnYnpx?=
 =?utf-8?B?akdSekNqSDJLMTZMZndBNnpiQTJGL1YvZWc4SHk3S1FLTVdCZzlhdmNqcEZM?=
 =?utf-8?B?WVdvWFN1U1hBK0VpaTFBU0NsajgzVnhNaFJEL1pOdHpyWU9rWU5NNHd0aXQy?=
 =?utf-8?B?dFpybURBbTVrYzY3dU5zNWZhMHBNR2tEYTlwMlZlVSt5ZXVCWFFiQ1BQVzho?=
 =?utf-8?B?MXU3a1B2MHZ6YlN5OWFjUnhsMlRQSTg3ZElYdyswVUNOampKSHhLMnd6ZEdu?=
 =?utf-8?B?L0FSNzVJVGRZS3ljVU8ySitPcVZkc2RRWEt5SmtDa1BMa1c1Vi9RaFVmYytV?=
 =?utf-8?B?QnFqM3RHeHgrajNvMHplVlVvUVhKRnRHQXd1eGhkZHMwVzNQN3NDeXZaeU00?=
 =?utf-8?B?Vi9vRTgvbmlJRmtJallPamcwcDNlS0o0blpydk03c0RDZHJ0Z2lNaVBhdkc2?=
 =?utf-8?B?MDVqaFJuQ0NvRFp1QTJqSW5hMGN5RTIyVUlId0NZQ0NKdHN2N1lSekhsMGht?=
 =?utf-8?B?UHJJSG9EdS9WT3k2MmNsNmpwRW1uQlgwcThXbkNjR2VWbk5NbHNwSEhiSWJZ?=
 =?utf-8?B?MkFPQ0xDdXYzUnZlQ3BIL2JlblNjeHorQVlXNjRyT3BoM05NWUpaWCtHK2xJ?=
 =?utf-8?Q?vC2HdH0Z4BOQwqFzEVwsnhqw4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e26bc05-63e6-4b3e-9a00-08dd99166c9b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 09:52:54.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3qZbLVA1AN52CMLrDhEsjJ9X4OM2kNB4J3Qw+8NlK++LCCcoCMkBC5o1rgkecGkEbh+EoCFFahQOBKgdLGsHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765


On 5/21/25 19:28, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Export the capabilities found for checking them against the
>> expected ones by the driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  3 ++
>>   2 files changed, 65 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index e2b6420592de..b05c6e64bfe2 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1095,6 +1095,68 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>>   
>> +static int cxl_pci_accel_setup_memdev_regs(struct pci_dev *pdev,
>> +					   struct cxl_dev_state *cxlds,
>> +					   unsigned long *caps)
>> +{
>> +	struct cxl_register_map map;
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
>> +	/*
>> +	 * This call can return -ENODEV if regs not found. This is not an error
>> +	 * for Type2 since these regs are not mandatory. If they do exist then
>> +	 * mapping them should not fail. If they should exist, it is with driver
>> +	 * calling cxl_pci_check_caps() where the problem should be found.
>> +	 */
> The driver should know in advance if calling:
>
>      cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>
> ...will fail. Put that logic where it belongs in the probe function of
> the type-2 driver directly. This helper is not helping, it is just
> obfuscating.


As I said in the previous email, I disagree. The CXL API should be 
handling all this. A client only cares about certain things, let's say 
manageable things like capabilities, without going deep into CXL specs 
about how all that needs to be implemented. This patch introduces a 
function embedding different calls for those innerworkings which should 
only be handled by the CXL core.


