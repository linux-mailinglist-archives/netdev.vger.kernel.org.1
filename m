Return-Path: <netdev+bounces-128674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CC297ADB5
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB121C2384A
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1861581F9;
	Tue, 17 Sep 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kh0rM0iK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703071422D2;
	Tue, 17 Sep 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564596; cv=fail; b=VIObr0lQ0jCs6ZjUmZSkMRj1EcirBhyYUpxzv9dG+X34Meg1w/QRIgash6aKhdw01fm7Smkx+0T5kakE8LcvYhyd5+54NcbSzVK2m9YRWNS+qly3K1TMfnbHIQC31xQ8G2+OCe9kySsjZZA56YzhOPKMS4/fEOe1GPzkBvFTFBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564596; c=relaxed/simple;
	bh=jTpU3HqwSVjEIR7kr2Qlar9QKgFwRCUDZKFge5BZeN8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O0vKxo/GRFpFdX6y76J2VP9TGvBaAkLJyPjnp3PRjiGutL/p6PeDCIeOmMCurhgXBH/11jVKfmIWQ6Kg+QdwABiwzfQJgWJN66WiHBLFAyfUb5AGwwB1ipfcJ3tGRBdowHEEYzejVw7W51rdUUkDiViFk1dhIua5y0AhogpS3l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kh0rM0iK; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G71D5ItkB5HO1THJEOQs58OTebD6z0zKqlU258ItdwDZ/ufMM7rcehBoKwUfseKpfs1VQw6F7dRCJUSpAZtWsSICyNSLB1O/UJXeKLXXNXvH6oEfUfeS4fMBmeSOQRpz/OyB7Zs638NjkPPP904ukhY+KCt9sz/zpA6ZThoeI6S46M23rF8+dAs6eDZlRDI0cnO3l38ED97LMijmhrYdSMqyhJM3+7cAOvZVd3eAJ5zdBjQWtw8Hh2TxtsDD1xrcysntPdKGtfZFXxk3DBq7esKwY1vCSSvrPRHxlrLM6M4CpmXz607pJI9WiusApo8DxHGCErHX9pWlOzG/tJlsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS+Majrp9RW9c+QcW7JDLhbYui41/y1rI83YK5D2X3Q=;
 b=W2JlCt3fMEfWfuMLml2SmYGe9wqi2+WJtIPBGNn53lnQXpgSRpyCF76lxTJfRMJFXziKiW/9emyPoYgrF8cUSUkxqjl5gCPSB40JAY0bvc0wjXhZxM3UTnFZzhQvudhFTOrDMWJdTAO02FWQhASFBj7JL3eFUHU3X5i1ogQhfJeLBTEKZyg7AJGfME+ndYBgVE3D0W+QFAr3imz85kxqym5cJCUHAoJJ8yifVxmWfO+9+VQwz8ypMjsCnmLg6NZVMQ2RmWH6f/t6x6pjepdD3cF9mhW2ZkVLiL6JZYiEbIgrus/Q7ouAiWT4sGuZQQDC5hWo6LvX6U6fIKsGj9Uqlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS+Majrp9RW9c+QcW7JDLhbYui41/y1rI83YK5D2X3Q=;
 b=Kh0rM0iKoLDsNX+oImhS3yqLrsiCCD2M0FYFn0JGJ7GultMGEKnA8bijsZqgP0kFqzgfW2BQOWIPDANAyD0WDsQDqH/fBvawABqDEkmJYk5W6M0AcdEw2BS8agAH9cgC/y1DkoSmsvYksDmF9ECnIvSDXGhSkK0P8b7gWqtYM7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 09:16:31 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 09:16:31 +0000
Message-ID: <fcfa1cc0-0ba6-c267-18b3-3923cb217ee4@amd.com>
Date: Tue, 17 Sep 2024 10:16:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 10/20] cxl: indicate probe deferral
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-11-alejandro.lucero-palau@amd.com>
 <920a9258-650a-454d-b45d-673b7cfa1e56@intel.com>
 <cfffaf6e-3044-a389-f4e5-6fbd50ecbdd7@amd.com>
 <601e5516-3ad9-45d7-90ae-635aac14e371@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <601e5516-3ad9-45d7-90ae-635aac14e371@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0181.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe650fd-3e9b-45ef-3a16-08dcd6f96acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VW4ydEdZOGYxQnpnMFdWV1phbU5kYkUrNEhqSlhsY3dHSlZhWmxvN2FtRG5S?=
 =?utf-8?B?R3J1UXJQeFloeTg3V1BzVExSNUFtODhnalMva3F2M00xeHpER0pwK0NZakFj?=
 =?utf-8?B?ZXJ0V3NnWXFrTWhXQ25Mem84SUkwVHQ3YlJrSlhUdnFyaDBwMUxTSkRGQXBY?=
 =?utf-8?B?ZFBmQlp6NklJeCtHYWV2b3Rjc1pFdWhnUzlxYWo2TlY2QkpIRmthOXZORktJ?=
 =?utf-8?B?KytyYlVYemZrUFZzcXh6YVR1MVdSMGhhRzRzSjVwci9xbUd0OTFSZ2N6MTJv?=
 =?utf-8?B?Y3UyQmYrTEV2YU1GaFdHRURSek9NYVhsekFkZGlOdHVQZ1dxRDd0dDZ1M1NI?=
 =?utf-8?B?NEZUOHJQNEdJdmlBWVhYeFF5bVRabzNqMEM2eGJ3NkJQRUdXaENaaFBiazRH?=
 =?utf-8?B?eGRpd21XNzlRTzQ2SFVzTStVdDJjRnNPZ0lBSXJjQlRob1FKM29GZ05SSytH?=
 =?utf-8?B?YUE2UnFnU2FSdW4yLzRaN1VMQ29JOGZ0ckJjbjRpSkVuY040K2JIdEtCamRa?=
 =?utf-8?B?Tk5FZGtZa3VoZXN4Nlg2TkJqNkVKcVdrQmpWUU5GOTF3SjBSZStQc08ydDU5?=
 =?utf-8?B?R09IU2hhNGtpdTdQNitDSGtKcDZjL1lZanBQbkpQMzZNdXJGZVJWd0RYaFFV?=
 =?utf-8?B?ZVNkcUV4S2RhN2syaTBxT0hZQ3Q4TTdKODhldHV0Q1hnY251NWREL0xISE1K?=
 =?utf-8?B?ZDBDN0dhQjI0TSs1SlNiZ2FJclJ2Z0luVmpUQjBCeWRwUG44ZXdFS25IMXY5?=
 =?utf-8?B?c3FqR09pQUcrSVhIZFpZUHpQNlV3N0dkNW9IRGd1OVVFQklGclNzekU5OGtp?=
 =?utf-8?B?Z1ZDaEdhb0Z6ZmtrY3dLU0wvc1RwSG9kRE9VMkRpc2ZlQk5HeVk3Smc5WTQy?=
 =?utf-8?B?MWZGaUQvUlVYZURaL3BObElScWRpQUtxTENTaWdSZjBvSWZkcWQ1WnhZRW5D?=
 =?utf-8?B?akV0VGVzREpMaVJhcGZXakYyNmtMaU5Xa09JRk8xR3V4TjZFNXN6ZTNZQzRo?=
 =?utf-8?B?djdPUGs1QURCUWFBcTFySDU1T1dVWm5DcHEzVzYrUTgrOHpsV2RoSWRqN1RV?=
 =?utf-8?B?M3J6aTRIRzNoU3pveUZCdGViWkt2ODZTWENCZ3U2NjFUK0w1V1YyVWh1dW1R?=
 =?utf-8?B?bDljVkZkRHRKSHkvcUVEKzdqQm02ZGprZUxNR2FUMnFwZ3d0NHpSR0c3V3o3?=
 =?utf-8?B?YlQxTU9zQS9STnh2RFY2OWFRV1FuZGxjVzdBL1czWFY4cDkwYWIyUnBCRkJp?=
 =?utf-8?B?UDl2eUtlSVZYcHV1NnZmcURHWE5hMkxzZEJ1QkZtZ0tETDlGV3ViY09MMjFZ?=
 =?utf-8?B?STZVY2dLRVA1YlJveWNFK095Z2dIbThVeHBmMDV4akphS2hBN2l0bFM4VktU?=
 =?utf-8?B?cTI5Uk1VMnF2ZnM0a09MWjRGQWEwZXVId08wUjRSZHh6elJ2cmRmL09OQ1VG?=
 =?utf-8?B?RHZwQjdpQzlEb2pKUDhVM2ZFYUJ6ZnZpYVVzSGpSOVRWMWkwNU9CcldOYWZI?=
 =?utf-8?B?a0VGQ1pJQXNYLzRLaEQ2Q2JROXNDMkZjY0NHM1dDb3dTWjk0QlNNZ2M4STIr?=
 =?utf-8?B?c25LMFZodGhQMEdxWk1mSDNvamlNVk1pVjI0NnErelpCR3dpd2h0VnM4c1RL?=
 =?utf-8?B?VFZDdHhBalpRWGtTdnVxRUxFL0pUS0YxYlpIeXNyOUxrRC9FbTZxWjJFRzV0?=
 =?utf-8?B?c0hSNTkvcXFJYWJaMWl3NWlubnN0ZGpiR3lDWWswSDJmQ2NqQ0xaZUV3NTdr?=
 =?utf-8?B?T0ZRNXdvWXoyQzlTbWtYU1plc0VSb0FOaEVGOWdQV0dkUStnY2xZSnd3ZUs4?=
 =?utf-8?B?cjhhMERXUTZPaFdSZlFmT2hRdEx2MzJuMHZSN2sxTDJWRmt4UTM5bnd5dW1m?=
 =?utf-8?B?QmVsUXJlKzhMZ29yek5CNmJzNHkxbEpWS05QYXYyZW5vZlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjNJZkloMEFjRVFwTko0ZzFlZU1pODNLbm5mbkEySHJ1cE51czhOMHorN0Qz?=
 =?utf-8?B?VkVLNng4Wm1HTzNvSytzcHdZQXp5ZzBUNWc2aGJ5WkFtbWtObHN0dUtHMDlz?=
 =?utf-8?B?UXBLWU8rTVRzcXl2KzBLNHpuOWdJY2MvRlVmZWlVdjBUM0JheSsxZzZRLzVT?=
 =?utf-8?B?bmpjYVhmQ0kzanlWZDJyVWxlVHlXNFRJN0dBMmxhZ1IxMldUczR2OW44REpR?=
 =?utf-8?B?c3RPTU9qZFk1UWZQOXJsWEV0dHZiNDVQaGlCWkNPUGVoUWk4VHhLU3ZscWFX?=
 =?utf-8?B?UFYvRE1KcGRqNGUxdFRFQmZQeHk3anlZdFZKTWpJTENZZ3A4TnhEemMxWjdY?=
 =?utf-8?B?Q1AyVFhlMXUxZGdzSHdMbWxMc21HdE5TREZuR1F6RG9nSkltTmZxbGNyWlkz?=
 =?utf-8?B?VnRPNVJVdHIrN0RYRlZCb0dSK3lnZkxJUnlzTDlEU1Z1WUQ2VEZHMXVGM3Rk?=
 =?utf-8?B?UUc0UUhwWE8xeTQ4NlhhdVJQSk55MmQ0Nk9FVEduTDE4WVdEODBwcFdyd0lS?=
 =?utf-8?B?UEZpR3lvOWtHdThFUEpXNzc1cDhFUEsvYTZEMHlRWmtYQWlMRTNaelNQZzZQ?=
 =?utf-8?B?MEZSQXE3OHZOcW9MT0xrQ00xYlNXUzhOREZnNjBEVlVvN3B5Q1lVQVlST2pq?=
 =?utf-8?B?N0RQMkVmL2d6ZWZCUWx4SFYxUE45eGU0SWFiczlicW8vNjlGNDBkZmh6TkVG?=
 =?utf-8?B?ZlF6bHhCVkQrS1JKbDNPejFyRUFXeVJvTlR1WEkwZERCRmlMMEp0Rkx4ek1O?=
 =?utf-8?B?cXZSUVNLWjYxTUw5L0grdUNiMU82V2RqWHdzcHZmbUQzMEpJTzI4cGhaVXpi?=
 =?utf-8?B?b3IraFJ1MlJLMGp4OFdOL2FFYy9CN2g1L2xLNy83TTBCM1IvZS9jenorb0c0?=
 =?utf-8?B?Ylg1VU4vTTRXWHNBRU1uZEI5dlhkRElIOWFBWUVSZHBCVGF6VlVJSlJ4bi82?=
 =?utf-8?B?QXlGZWZBRkxQWnIyV2dnMVIrYVdCVmFRYXVCdDBHMzJRRWcxdnUyUVRvUDRF?=
 =?utf-8?B?RS9MOE11a2I4Q3JDUnJJeVgzT1YwcTdQbFpZdnJlbFA2blRnQXV1clBiZjBY?=
 =?utf-8?B?OEtFd0Y1dUo0M2R3OWFYZWY5akNvOXRXK2ttOXkxZlBvY3pmc25uNGFFM0Nj?=
 =?utf-8?B?RkUvS2JIYy82UXBMaWdiZCtaQThLQ3MxQjBwSWlOMVYwYWZtbzZhS0NUN2M2?=
 =?utf-8?B?RzJtOURjR0dPTHZtZm1FcDhYMytKU0Z4cUVTcFdwUVFTYlpxc2wrdmFDVENo?=
 =?utf-8?B?eElJZ0VmWURNQnJmM1RkSVpUMzRKaWE2eDYvOEtBaytBYVE0QU9ZK3dYTmNX?=
 =?utf-8?B?biswbW5lWVN1RXBCM1pFcU0weGhydWFkYUtsc1dqTm9jSFdpTGcrcjJ6a1N6?=
 =?utf-8?B?c25rU3lLaUl4SWNOUmc4SWUzRlRGYVJURXVDMDVqbFlPSWxmUGVlcGFSSGVZ?=
 =?utf-8?B?VzJreC9EdU1mWHlhc01pNXBrSys1dk9SYyt3dzcwZmNYeU9hSXltUjdER0U4?=
 =?utf-8?B?UEl0YkEzN292WkVSMWphaS9iVXBSZFdVODJhZ29TTFFha0IvZ2w5YlNmTmp2?=
 =?utf-8?B?N0ZFYlBNeEE4Q1BadFR0eHFCbFRYQUx5Wjc5bWRRb3k4aWxsK1BQdUQwUE5u?=
 =?utf-8?B?R1YzYm5GNS9EV2hYUGRjSGxuWm5PWnpOZ1d2VVphakhIOVFPV2lobmV5Q05K?=
 =?utf-8?B?NTdlY0d5YkY2RjJWdStOUTVYeDJMTU4xaWtlSTBNamFSQjdSdW0xT2R6Vm5K?=
 =?utf-8?B?dUVGYkJJSi9ZaFhJbUpDVlU4M2JuM2pxRk45MFFLZjlwWXo1Y0pmdU9KQXBS?=
 =?utf-8?B?YzBLWjJzRFUzQ2JQQ2tFa09JUk52R1hYUFpQbzg5K1M2ckZvTTNTVklYL0Nx?=
 =?utf-8?B?MW0zVFFsNU9IWXVsaSt5Vm5BWENsaXJzT01LeTdMV01CN0toWVBXOXpwam95?=
 =?utf-8?B?ajErSzkyZ3FLbWZ2UEg0YS9LalYvWTZLajdONWtxVFFrLzNnZytwblFzZFlB?=
 =?utf-8?B?bXZUME9aT2hRMDg4TGluZ0xwUFlXcll2ZmdibUMrSUwxN1pMNytialA1cmtu?=
 =?utf-8?B?TTFPVXh5am9Vd3dUQWdzdnVmOVJKNjhON3FHQVczbFdFR25oTkJLWm1LNjlz?=
 =?utf-8?Q?Qx5KGSV+agAjyvpgE7mONQYVF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe650fd-3e9b-45ef-3a16-08dcd6f96acc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 09:16:30.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tmkdRz3C+qBgnaiNkC4XIp7xLtzCDvb+TmnDoKc/qZzMF3ThkZ+WgoWO1hsplamG3rcS/O0wgBKhHti+xc61w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039


On 9/17/24 04:31, Li, Ming4 wrote:
> On 9/16/2024 4:24 PM, Alejandro Lucero Palau wrote:
>> On 9/10/24 07:37, Li, Ming4 wrote:
>>> On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> The first stop for a CXL accelerator driver that wants to establish new
>>>> CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
>>>> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
>>>> topology up to the root.
>>>>
>>>> If the root driver has not attached yet the expectation is that the
>>>> driver waits until that link is established. The common cxl_pci_driver
>>>> has reason to keep the 'struct cxl_memdev' device attached to the bus
>>>> until the root driver attaches. An accelerator may want to instead defer
>>>> probing until CXL resources can be acquired.
>>>>
>>>> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
>>>> accelerator driver probing should be deferred vs failed. Provide that
>>>> indication via a new cxl_acquire_endpoint() API that can retrieve the
>>>> probe status of the memdev.
>>>>
>>>> Based on https://lore.kernel.org/linux-cxl/168592155270.1948938.11536845108449547920.stgit@dwillia2-xfh.jf.intel.com/
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>> ---
>>>>    drivers/cxl/core/memdev.c | 67 +++++++++++++++++++++++++++++++++++++++
>>>>    drivers/cxl/core/port.c   |  2 +-
>>>>    drivers/cxl/mem.c         |  4 ++-
>>>>    include/linux/cxl/cxl.h   |  2 ++
>>>>    4 files changed, 73 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>>> index 5f8418620b70..d4406cf3ed32 100644
>>>> --- a/drivers/cxl/core/memdev.c
>>>> +++ b/drivers/cxl/core/memdev.c
>>>> @@ -5,6 +5,7 @@
>>>>    #include <linux/io-64-nonatomic-lo-hi.h>
>>>>    #include <linux/firmware.h>
>>>>    #include <linux/device.h>
>>>> +#include <linux/delay.h>
>>>>    #include <linux/slab.h>
>>>>    #include <linux/idr.h>
>>>>    #include <linux/pci.h>
>>>> @@ -23,6 +24,8 @@ static DECLARE_RWSEM(cxl_memdev_rwsem);
>>>>    static int cxl_mem_major;
>>>>    static DEFINE_IDA(cxl_memdev_ida);
>>>>    +static unsigned short endpoint_ready_timeout = HZ;
>>>> +
>>>>    static void cxl_memdev_release(struct device *dev)
>>>>    {
>>>>        struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>>> @@ -1163,6 +1166,70 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>>>    }
>>>>    EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>>>>    +/*
>>>> + * Try to get a locked reference on a memdev's CXL port topology
>>>> + * connection. Be careful to observe when cxl_mem_probe() has deposited
>>>> + * a probe deferral awaiting the arrival of the CXL root driver.
>>>> + */
>>>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
>>>> +{
>>>> +    struct cxl_port *endpoint;
>>>> +    unsigned long timeout;
>>>> +    int rc = -ENXIO;
>>>> +
>>>> +    /*
>>>> +     * A memdev creation triggers ports creation through the kernel
>>>> +     * device object model. An endpoint port could not be created yet
>>>> +     * but coming. Wait here for a gentle space of time for ensuring
>>>> +     * and endpoint port not there is due to some error and not because
>>>> +     * the race described.
>>>> +     *
>>>> +     * Note this is a similar case this function is implemented for, but
>>>> +     * instead of the race with the root port, this is against its own
>>>> +     * endpoint port.
>>>> +     */
>>>> +    timeout = jiffies + endpoint_ready_timeout;
>>>> +    do {
>>>> +        device_lock(&cxlmd->dev);
>>>> +        endpoint = cxlmd->endpoint;
>>>> +        if (endpoint)
>>>> +            break;
>>>> +        device_unlock(&cxlmd->dev);
>>>> +        if (msleep_interruptible(100)) {
>>>> +            device_lock(&cxlmd->dev);
>>>> +            break;
>>> Can exit directly. not need to hold the lock of cxlmd->dev then break.
>>
>> Not sure if it is safe to do device_unlock twice, but even if so, it looks better to my eyes to get the lock or if not to add another error path.
>>
> why device_unlock will be called twice? directly return the value of rc like below if the sleep is interrupted.
>
>      if (msleep_interruptible(100))
>
>              return ERR_PTR(rc);
>
>

You are right.


>>
>>>> +        }
>>>> +    } while (!time_after(jiffies, timeout));
> Another issue I noticed is that above loop will not hold the device lock if timeout happened(without msleep interrupted), but below "goto err" will call device_unlock() for the device.
>
> I think below 'if (!endpoint)' can also return the value of rc. Combine above changes, I think the code should be:
>
>      do {
>
>          ......
>
>          if (msleep_interruptible(100))
>
>                  break;
>
>      } while (!time_after(jiffies, timeout));
>
>      if (!endpoint)
>
>                  return ERR_PTR(rc);
>
>
> Does it make more sense?


Right again.

I can see it now.

Thank you!


>
>>>> +
>>>> +    if (!endpoint)
>>>> +        goto err;
>>>> +
>>>> +    if (IS_ERR(endpoint)) {
>>>> +        rc = PTR_ERR(endpoint);
>>>> +        goto err;
>>>> +    }
>>>> +
>>>> +    device_lock(&endpoint->dev);
>>>> +    if (!endpoint->dev.driver)
>>>> +        goto err_endpoint;
>>>> +
>>>> +    return endpoint;
>>>> +
>>>> +err_endpoint:
>>>> +    device_unlock(&endpoint->dev);
>>>> +err:
>>>> +    device_unlock(&cxlmd->dev);
>>>> +    return ERR_PTR(rc);
>>>> +}
>>>> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
>>>> +
>>>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>>>> +{
>>>> +    device_unlock(&endpoint->dev);
>>>> +    device_unlock(&cxlmd->dev);
>>>> +}
>>>> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
>>>> +
>>>>    static void sanitize_teardown_notifier(void *data)
>>>>    {
>>>>        struct cxl_memdev_state *mds = data;
>>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>>> index 39b20ddd0296..ca2c993faa9c 100644
>>>> --- a/drivers/cxl/core/port.c
>>>> +++ b/drivers/cxl/core/port.c
>>>> @@ -1554,7 +1554,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>>>             */
>>>>            dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>>>>                dev_name(dport_dev));
>>>> -        return -ENXIO;
>>>> +        return -EPROBE_DEFER;
>>>>        }
>>>>          parent_port = find_cxl_port(dparent, &parent_dport);
>>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>>> index 5c7ad230bccb..56fd7a100c2f 100644
>>>> --- a/drivers/cxl/mem.c
>>>> +++ b/drivers/cxl/mem.c
>>>> @@ -145,8 +145,10 @@ static int cxl_mem_probe(struct device *dev)
>>>>            return rc;
>>>>          rc = devm_cxl_enumerate_ports(cxlmd);
>>>> -    if (rc)
>>>> +    if (rc) {
>>>> +        cxlmd->endpoint = ERR_PTR(rc);
>>>>            return rc;
>>>> +    }
>>>>          parent_port = cxl_mem_find_port(cxlmd, &dport);
>>>>        if (!parent_port) {
>>>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>>>> index fc0859f841dc..7e4580fb8659 100644
>>>> --- a/include/linux/cxl/cxl.h
>>>> +++ b/include/linux/cxl/cxl.h
>>>> @@ -57,4 +57,6 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>>>    void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>>>>    struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>>>                           struct cxl_dev_state *cxlds);
>>>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>>>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>>>>    #endif

