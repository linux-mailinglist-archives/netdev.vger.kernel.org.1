Return-Path: <netdev+bounces-259426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 06VAMVzllmkuqwIAu9opvQ
	(envelope-from <netdev+bounces-259426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:26:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E81315DC18
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C066A301913F
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842282ECE91;
	Thu, 19 Feb 2026 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uIKo+eJk"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003E2EAD1C;
	Thu, 19 Feb 2026 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496792; cv=fail; b=V6kjEKLQVJqVDkMkCXg9YxgXxR0afpittmxzNKnzia0x83qtKHOBDQ8mKq8kEr7YoVRz7oHgTN/NpWKt1rME3bHRQ6wJQq8nCSh5c/fvkwf04RM/lAYZsKUHJ6K3MKQYSaaJ3uCU8eUz02w1pL1lTQk8BNGCMUQ238x+rrX6yiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496792; c=relaxed/simple;
	bh=lZmnAJIq3CWZ6xcYh6yi7blGCj9la4V3BFNqakF2zIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IxbEI2tlFYDItmwg5E8ttedLBj7CTHKvdebubgtb3hPGlobKNnMs1kjAs6sFtVEWGOVoEi3mDT37vKDcGZEDtEAKU2kvlWaeS/VUkgVUcTgNbKHT5CNizzHzOGj61024JFtdVuABEl8t80fxm0RzAjvotyHixGAJAIA6HG0Ri1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uIKo+eJk; arc=fail smtp.client-ip=52.101.48.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYL5WPprv28SIctmfPFf7OQxwywLp8erV6pjcypB79appHrqyfX0KMC9yLpGIqS5VRgaBHM2twfK3ITLUc7vt1cqc8v0M9soeNonzShUJjaR24REYV4Ng40xeEZdUgJJy3fkuu1KFf4f2c7IqOkEUgmLJxPlEudSKdCVD1h/Z8W/tH/52QiLGqnE664sPFggtFl9fo/nTkpT0fhUDXvtI+5/W+Zpvb6sqMwY1RJOUFdItkRFKXT1aqNlWWcETScf5xcnqK+13ZRk20GXmofQoG64/CbeZnDLo4UGa69RDQ9mYYwKsTwr34uaSFTWm+00XclNBKZI+YmPWhpSfiTKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHDx9XOiu1+ViwQnKgB3kCM202sPNT518jrDDLhh3js=;
 b=rBE1/VOcDd0aiB87DpyzaAbCjxEyJb9cLnYr+MikemfYoSUhFHUo2RjS9rCjfDdOxAtYj+6DeXbgFhJ/pcG+ZOgRl63QZKh4oTFKk/Xg2jpi+0m2H181zpnAPnHE5u4ZHXakLsWTM3kHEJfjA0Iyy1fvSqMXin95PRGMrr6jPQsW7lS2nCmBUrMywBhB/lGQ/G784IXA/c6awcLqXo5aaKG1rPrLHaRoC1pkkG1a1mjo/+MtMlJV77lYsw4AAm7peR+rqme6EOjhVSLlY4zyMHj8xc0j7XVzpYrQ1ft83gu7L50osMPniDX9xkZTAQG5yIMT651wv+rApOBexy/k6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHDx9XOiu1+ViwQnKgB3kCM202sPNT518jrDDLhh3js=;
 b=uIKo+eJkm4dp+MCBlP389nJ6sm+wNoxx+g9LJMiCLuAd4OEHNO5AO6DM5EW9KJVB2784H/drpsuI5pAf/r/IGiOwHhYsolBt1pOWvz0J3g7hvQZXGQ5LNCYrzXJdwSXXaczv+g1+bArDJYc2DK/+uu8tsCJjqpuMCiEpMb92rPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Thu, 19 Feb
 2026 10:26:27 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 10:26:26 +0000
Message-ID: <185203b1-d67a-4295-9fa8-c40bfecdcb36@amd.com>
Date: Thu, 19 Feb 2026 10:26:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 14/22] cxl: Define a driver interface for DPA
 allocation
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-15-alejandro.lucero-palau@amd.com>
 <62e902d5-043c-42ce-b75c-f2b82511029a@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <62e902d5-043c-42ce-b75c-f2b82511029a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0588.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b058040-d683-4393-ff12-08de6fa15662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWw5eFVwYzRvcFlYYW1YQUF2d0wwRmxWQ1RSYTh6NzNBU2xQTWxjNi9DTjg5?=
 =?utf-8?B?WnVEV2FwUzh1Y01WWHZoRENvbE4vV1Jxa0pwNnRKOHhmcGxwdkJncHJtZ3N6?=
 =?utf-8?B?N0RyOG9vVDdxa3htdEZsTHBScnp1N1hKTXgxb1NIYnhOTC8ycDV4L21tTjNs?=
 =?utf-8?B?ZmwxcWtCeVNhZVdaZ1Z6c2tuZ0U2aVZyUWZPclRHWGVrUVVscWpHUTFmNUR5?=
 =?utf-8?B?Sk9LT29YcUlKUk5PR2dyRkdZdy8wZ3ZkT0N5Ujl3UUNwZS9qMWlLZTNabE5r?=
 =?utf-8?B?UHZ2SiswUXR6WW9UVGZ6UlNSRDIrRTZuTmJvTSsvSG5Ra3BpMnJDTldlbVlH?=
 =?utf-8?B?QjlPTy82d0RZdkhQNENTaDcyS3FOaVM5TExQaS8zaUwyTWY4RlJpZWxrUC9v?=
 =?utf-8?B?d1FuRWc0NzUvRXVIUGNWSzJETmt5bkNobUR0ZG00dUMxQVBXR0hKODFicjhJ?=
 =?utf-8?B?VU5ONmdhK0V6Y2Ryd3dXa0NrZ1hNVGYxSzc4dkxxdk5GQWtSZ1lJd1haWlla?=
 =?utf-8?B?ci9HdFFnaFJZSjV1aWd4aUtWVThxSFhUSWYxWDFDS2l2MjJ4YkdPRXE2MFNJ?=
 =?utf-8?B?VTF4VXNtdVErTG4rZXFGSmJBOFVGR0s3Rjd6VTFiOHp6TEZvOGJaRnJaOExQ?=
 =?utf-8?B?NFZvOVJ0cC9PK0lYNmZpM3hTN2hGYmlTUW0wUm5tcXllOXZ3TDNqTzg1YWg0?=
 =?utf-8?B?REs3Rk01MmNaT1dMeTBEYlRiSFEwZG1UWUxDOGtqTUlobnlVcU9JaHdHbmQw?=
 =?utf-8?B?MVliTjF0a2lQSm1wZFlZandTK2o5MXRySzJIaUVLNHRhK0FTd08yMHZteHVt?=
 =?utf-8?B?REpZUTRKU2lyMzVXZm5NZ2padUx3ZmtWYzJLVVBXN0JiMi83N29zMVAzUlhw?=
 =?utf-8?B?T2lUUi9WbXJPV3NnbVM0ZTZsYUorVTc2L0FxQVNkWFFITnhDYVYxUC9GdC9r?=
 =?utf-8?B?ZkFGanhtZFBocm1nMUNrZFExaUFaZzN3VEMzWlFZNW9KSTA0cHdRYlFiZG9D?=
 =?utf-8?B?cGFnSFBKVksvUDNGZ2NHOXR1aWsvVVZmeUdGRyt1M3NneEtIbEF1L0E4M1or?=
 =?utf-8?B?TjdVcXlNcGVHK3ZNeVprL2RuVUkxZENMcFlzSThBb2pwbmJNa08xaUpmMmFO?=
 =?utf-8?B?K2VKNUVxNTBPZjltT3hhKzB6OFpRYWRXRkdvMVBDZDd2akYrQVU0MWhWNVBK?=
 =?utf-8?B?NnVtN1pTRS9KZUNGMERiNTkrc240REx0SzdaTXMwMHcyTkxnSEV5ajBxdWkv?=
 =?utf-8?B?aVpkZmxZSnRxMmFkRksxVGpLSmo4SHhtVzJaTm9zVVFVanRmQVVsRzZ3bjc3?=
 =?utf-8?B?QUhla1dXd3Z5SmZ0blhIdXVIQjFRaHlqcFQrWW8yZVczSzdTQmM1bVlhT1po?=
 =?utf-8?B?Qy9VdzhqVVRocThONGZtRUlDc25XNmdYV0lwa3Jmdy9EeGgzejRBT3VmcFR5?=
 =?utf-8?B?ajdaM3huYkk1dm5BeWcyTi9OYzJZWE1NQlF3WS95c09SbFpleU1aRW5BWTlj?=
 =?utf-8?B?RS9mL3RrOGR2bDdrZy9VdWlxUWRvTDdPM0xxYStFSUdQYkNJeGZWZUxWMTFV?=
 =?utf-8?B?SnVCZFM0eVpxQkMyNnNOTVVaL2I5aEYxSzdHNHErOFJEUncxUlhsRUhmRzRC?=
 =?utf-8?B?OVRtU1NaY29BM3N0Kys2MjYyVGhNTDJVNytnSUR1N25UMEZtY203TXo0UGNC?=
 =?utf-8?B?ZVU2RENQMUIyZ2hOUU1WVGxJL3REN1JpdDQrVDB5MU00b1RlN3RBRDlPcHYz?=
 =?utf-8?B?WlVVK21mdXFqTndweTBpYlFHRVNCVk9jcW1GVU9KNHBQS3Q1RVJobzFtNnAz?=
 =?utf-8?B?VTBndnhucGpSQUVwOTM0TjBQMHRLazFlNVZMUUQ1TFVOZjAwYzdQak1LY0Nz?=
 =?utf-8?B?ckEzS0ljRUNZS3UyVlFtVEZRUm4vL3REYlRBUHVTSUE2MTJnQjJ2b3FQSUFp?=
 =?utf-8?B?eFZFZy90dTFBWnFYcGovK1UxNytrcUVqa3IxTDQzNHdwRCsyTjFlYnRBNXJu?=
 =?utf-8?B?UkR1ZHVYak1pZjlrUDdNd2l1dHNCcUtHd05IbzFUWUVNS3NqclIzZnNRbHY2?=
 =?utf-8?B?aE0zcmloY3dycWdaSDFYSkFLRXFFc1B5UkdsdFhydEpIWVNNMEUzMmRtNFRZ?=
 =?utf-8?Q?Fq5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjBNTmx3RHpybHdISm5jM1FyaXNaaE03d0ZNSUZ4TktwTjRQaktqc1VDeCtU?=
 =?utf-8?B?VTFBckhZdDA2VFQ2NXRSa3RhYURJZFJ1ODVtYitueEg3LzV0WHNZOGhBYi9X?=
 =?utf-8?B?dWJJeDM3YlkyL29CdU9zSkZIY2g0NDMrQWJCT0pDNXVlM1BKb2xSeUhXOGRv?=
 =?utf-8?B?Vm02RFpGR0hBUzdWWGpnRWNpc0pzVE5DM2ZReEtwcTZ2Zy91ZjZHREFWWnpP?=
 =?utf-8?B?VmlOSEtPV01iWXlrM0ROK1VOY3FsdDVlelZjbUN6M0lJNm5WOGxhei9qdzk2?=
 =?utf-8?B?WVdibThCT0k1RDRJbXVkVkcvRFdpc0FTZWxwb2J0Q2RkQlV5MmthWnduclBr?=
 =?utf-8?B?blhFSXoxeEg5WTZXbGVwK3hnMEpEVlZWWWgyN2pxZmUrd1RrYU5CQ1N4VFBm?=
 =?utf-8?B?VCtyUmFmamc3UkM0bXNiK2xGT1pwL1I5MEs4bEZnL0d0dGx3S2c5RHhweEtZ?=
 =?utf-8?B?cE51eWRQa3ZpNVh5aTRCbFMxeWN4SUwrZ0xmbDErNUtjVFRYNmhjVlQ0RWt5?=
 =?utf-8?B?MXRxak5VallXNExqZVdXM3doYk9hQ2FVclFkZGN4VW9RODVBUWVUNGloTjJF?=
 =?utf-8?B?R2FGM3RTcUd2TVp2dTBPcGxLOVZra0hZR2dBbnlmRU9zYTZiK3pCNEpzQU9T?=
 =?utf-8?B?cG1RUW5qRzlLTW96RlZ4TEtvZWVteVF3NXhCZW9yY05PNmxtZ1E2bUxxM0g4?=
 =?utf-8?B?OG1IeldzVWhRM21IU1hYaTlNRWpjRWJHenNJK3lYUjlkczJYcmIrdUwvQkN5?=
 =?utf-8?B?a1V2OW9kV3FpT2ZVZ0xDSDNxSEp4blJBNnAvYUw0YVhRSHVYa3Y5dHFMRzBl?=
 =?utf-8?B?N0RmR3h3clFBV0hreFEzRVlrZFFkTzVJaWR1bmRJSnFWNThuWE41aTExa3NE?=
 =?utf-8?B?MkJ1WjNoK3BOdFpOSW4wU29saS9DUDh6enlpOVg5MW5WWkNNSXR1SXIwU2VT?=
 =?utf-8?B?MDN4aVQ2Q2FSS21NTGxJRFpiUDI0cVd3OXJXVnZFN2svOGZPb3YrY2dCK2Z0?=
 =?utf-8?B?TDFaY1VpUTIxakpPeDJOVjFvNTRQbHBMY1g0QnVNQkUyNnZDMTdNSnk0TUxK?=
 =?utf-8?B?alU1K2kzUG0vRU9vVGtuTWpFQXR2TnVGYkduVU8rOXFCd3UrcjFLRHJXYnMv?=
 =?utf-8?B?Tk9UMlJkUkRqMERLRkJQcVNFTlNLREhGK1UvOFVmS3cxZ1poMDh6MUpSVjQ3?=
 =?utf-8?B?S0Rsa3RaMThiLzAzUDdJRTBmTTdvSkxsODJNY1ByZ1IyUnBwUExQUzhEU0dI?=
 =?utf-8?B?cG5NSytFeXBWT01xcWxYc1VnMzYwRUluZFVvdDhNZW13bllDS1N3cU0reWto?=
 =?utf-8?B?aUV6V1JiOWZwdGJuaDV1dnozdnNVMW1UQ2R0VlBTbkR4b1p5NW5EaFdDbjZW?=
 =?utf-8?B?SG9kcUNDTUswQ1FaZ3BXSmxEWnhnR2VMdUNkT0pBaEtYYk9VUE1iRlVXbjVn?=
 =?utf-8?B?SmdaOUdsVERLTnpCN1BXNUZCaFM4dE53dW9kaVFpdFE3dVdMUTFsMWJQZXRU?=
 =?utf-8?B?bXdvQlFqMFkvdkdzb3k0cFU3dUYwa2VHaE5zV21PR3dCTGp0TGdCdnNGdmJZ?=
 =?utf-8?B?VmdRTi9QT0JSQ3JsZkY0RmdOaExpaFovU1RnVnozYitZQXlWWTdXd050bmJw?=
 =?utf-8?B?M2ZZYk1ybFdRNlNCV1FPZFNmdVNoc09XbWw1ejl0T1dZeWlnUVVaSmU4SlY4?=
 =?utf-8?B?eTNjRG9pWHhzc1R3OTNXeHlvZWhwanMzVnBnMHlYYXVBZXRKQ0txclgrcnhm?=
 =?utf-8?B?eFh0V25RVnRTMlBzV3FCejF3SXBwSmFPbzJMUFVrNHNoMUVHM0RXR245RG9V?=
 =?utf-8?B?bEREYXIxMFYxenhpNmRxYVN1T01EMTFzVHpHU2dqbHRIWldHVzhibTlWYjl1?=
 =?utf-8?B?VFozS3I4cHBpeDlIamhuZ0hJUlBxOURUc1JKZjRhTmJzRG50a1l3THl4Rm5W?=
 =?utf-8?B?RVd4ZTYwa2x0blQyK0ovcWNPYUR4ZFlmM3RtL2FXRGlqZDRaZENZTmV1bm92?=
 =?utf-8?B?QVAzY29GNFdvb1VIRFFRMXBMaWxNMU5LaFZKZWwxbDVxMkpWNy9IYndaUmkx?=
 =?utf-8?B?TTMra0NPalp0MlhiTU8rQ0xmQm52OUJqYmNqR3Uyb2JlZGxIUTYwL1hZWHJy?=
 =?utf-8?B?N0hlOW1CLzYyTWNaSWd6YVdOVkJqVUd5TDVsdWNtcU1GUklqTUpFM2lWaElm?=
 =?utf-8?B?SVpqZSt0S3ZkUDdtTlltVmNZd2FTWkNheE5FeGVFK0ErT04vRmV3bWh0MGtG?=
 =?utf-8?B?TThkd0ZxcmdFQk5HM0JjNHo5UXU1aHVhUzZtQVI5Y1M5Y25HUUg2Y1RGRzMr?=
 =?utf-8?B?VXFTYWk0aXI0R1cyVTBoM3RBUS9GRWUzb0g4MDB1QjNBN044NVMzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b058040-d683-4393-ff12-08de6fa15662
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 10:26:26.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oyjzyl7hheEYTZbG9ycw0UDvNsJCJdfx98LguJAa6PGIhPEOv0bntvqUE8OA9cQs/HvhSbKPHD50CCR5H8aDng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259426-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 2E81315DC18
X-Rspamd-Action: no action


On 2/11/26 22:12, Cheatham, Benjamin wrote:
> On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space.
>>
>> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
>> that tries to allocate the DPA memory the driver requires to operate.The
>> memory requested should not be bigger than the max available HPA obtained
>> previously with cxl_get_hpa_freespace().
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/hdm.c | 84 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h      |  1 +
>>   include/cxl/cxl.h      |  5 +++
>>   3 files changed, 90 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index a172ce4e9b19..d60a697f12cc 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/seq_file.h>
>>   #include <linux/device.h>
>>   #include <linux/delay.h>
>> +#include <cxl/cxl.h>
>>   
>>   #include "cxlmem.h"
>>   #include "core.h"
>> @@ -546,6 +547,12 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
>>   	return resource_contains(res, &_addr);
>>   }
>>   
>> +/**
>> + * cxl_dpa_free - release DPA (Device Physical Address)
>> + * @cxled: endpoint decoder linked to the DPA
>> + *
>> + * Returns 0 or error.
>> + */
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_port *port = cxled_to_port(cxled);
>> @@ -572,6 +579,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>   	devm_cxl_dpa_release(cxled);
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
>>   
>>   int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>   		     enum cxl_partition_mode mode)
>> @@ -603,6 +611,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>   	return 0;
>>   }
>>   
>> +static int find_free_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	return cxled->cxld.id == (port->hdm_end + 1);
>> +}
>> +
>> +static struct cxl_endpoint_decoder *
>> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct device *dev;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +	dev = device_find_child(&endpoint->dev, NULL,
>> +				find_free_decoder);
>> +	if (!dev)
>> +		return NULL;
>> +
>> +	return to_cxl_endpoint_decoder(dev);
>> +}
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @mode: CXL partition mode (ram vs pmem)
>> + * @alloc: dpa size required
>> + *
>> + * Returns a pointer to a 'struct cxl_endpoint_decoder' on success or
>> + * an errno encoded pointer on failure.
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. The expectation is that @alloc is a driver known
>> + * value based on the device capacity but which could not be fully
>> + * available due to HPA constraints.
>> + *
>> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc)
>> +{
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(alloc, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
>> +		cxl_find_free_decoder(cxlmd);
>> +
>> +	if (!cxled)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	rc = cxl_dpa_set_part(cxled, mode);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		return ERR_PTR(rc);
> Should cxl_dpa_set_part() be unwound here, or does it not matter?


No, I do not think that is necessary. The CXL initialization fails, and 
the result is the modified struct will be released sooner or later.


> If it doesn't matter:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>


Thank you


>> +
>> +	return no_free_ptr(cxled);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
>> +
>>   static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index d1b010e5e1d0..2b1f7d687a0e 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -667,6 +667,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
>>   
>>   DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
>>   DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>> +DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxld.dev))
>>   DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>>   DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>>   
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 783ad570a6eb..4802371db00e 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -7,6 +7,7 @@
>>   
>>   #include <linux/node.h>
>>   #include <linux/ioport.h>
>> +#include <linux/range.h>
>>   #include <cxl/mailbox.h>
>>   
>>   /**
>> @@ -276,4 +277,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>>   					       unsigned long flags,
>>   					       resource_size_t *max);
>>   void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc);
>> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>   #endif /* __CXL_CXL_H__ */

