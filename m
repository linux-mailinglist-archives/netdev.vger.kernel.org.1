Return-Path: <netdev+bounces-160646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A84A1AABE
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 20:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2411882157
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE071ADC69;
	Thu, 23 Jan 2025 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IOuZdtMy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8E191F8E;
	Thu, 23 Jan 2025 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737662009; cv=fail; b=qUIZpxJbQFnBn2lj4Zv/cKGE2+MC1ydgsn18XjNvjmduahMd2okpQCCYFTRXnH1BsbtfW9nEyfy2ZoGZboaLHqDSbCvOpINZPUCPhF1G5fDe94PZHIGPOT63WoR+HN494+OkX6rpI1m1DwPULiM0pwaDSZGgg6CVnUChUL9DRJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737662009; c=relaxed/simple;
	bh=qaN5kiiFhQCiQJO4xTVKZBlnKEqlvINq1XPQdVk9wgU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DkGnIKnfuCsPzouHXRI7rKA7MN+tTPr+axn+Nmg6r4ONhTHAfPf2oBpUb+PRwbv0vzN1wZ/Iq4CXHtJp7hDN22QFPUXao0miwHeGiFkL1HPfk1IepXN9tsKZUyYDOunzLFxqrzZRdjw8XKthSxHqumukeAFBrjSS6oWQFiO8Y0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IOuZdtMy; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ng0w43x+u6F+sJIb3JX8YqXXLuN5hobXVo3YJ+1UJt3IurZuofichFdIeyZT8A1/YSCtkIcuDLNnkid9FUWUioXOmUORU2rIdDb3rlaTRbVVM3fhg47zVxxY6xNqgVQdnN9nKcjvzq8rXs2P5TNY71tEZsT4Sg+0eYe6ygYLdvGGrUcGKlHGvgV8juW5cKOujXMH165dzHdKzzPX+QvC3drSfMuLq2IsEGQl3bZmgzVO40rzDYnjwFl2pv+FZRK0YhUC6Bd8xsmX2SOucEwvoymnRqPidhCFtMZWSerqhvxihlJYHH9jBnDVVFaFmZKKA+p4SV5O0DJdZ5F1QkYdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTaFalhB3BrKg+0uVMUZnYotZTQXpcQjmF20L1ckDLw=;
 b=dFXk3MhW+TKZXa7y3cILfWzRxDKOk51ozV9sFtlRlF8b2VIo+muJ+Of9hNqMljz3TfN1fMtHvcl5kdslKOyyhlCX9N5dByEFhPbfp+YApeO2ew++ETjKVFPVOS3TQNn85An5yAkedBFNdYhYGhpI64bIx1pDBB1IJVny2dRSidHJObcwlxPD8pjovzxU8M+QpTNLeiRA7+iWrrqR2PQcB24z4OA4+jNe4FXTfBOJUdFsfczPjzUxKzgasN/L/tsExY08r0r5l3iCI83eTOGMIBF0lKknM4Ft/9Gi/KM5HRXzM6QAjHFLvaNlKQDdpK+CIly+PUsHf0vZ0vZIQ+eofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTaFalhB3BrKg+0uVMUZnYotZTQXpcQjmF20L1ckDLw=;
 b=IOuZdtMy02LEsvcWhlb79TlnvWNmow+zyxTWq1dbu/UOmIHkBWO5T5BtySSdVgvnZJOyU7NMfo8tFPzN+eorJlB3NcNWym8abZGL+kakB1ZaEZXQHWFE6KsdthUnIXqBBUMopssQOWa1020rELyfc/ga6B16QfGt6p6YaH+DRfxIzzNC9q5d4zxTUr2I3hVpI5UkmaplcAWDBQee0NtUb2ZAwoleL7vtVnDjf02jD3Jq9C4e+H4JnINnzokecy51SuQzJMc5lZ5de5u3o/HnwyhUCacN+Y6gKHmhhC48N233xPjIhrlDNj/O7Eqpdfq0Ymfh6WPxrARCh5a3K5N+oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) by
 DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Thu, 23 Jan 2025 19:53:24 +0000
Received: from DS7PR12MB6237.namprd12.prod.outlook.com
 ([fe80::64de:5b39:d2ef:8db6]) by DS7PR12MB6237.namprd12.prod.outlook.com
 ([fe80::64de:5b39:d2ef:8db6%5]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 19:53:24 +0000
Message-ID: <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
Date: Thu, 23 Jan 2025 11:53:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
To: Furong Xu <0x1207@gmail.com>, Jon Hunter <jonathanh@nvidia.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Joe Damato <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1736910454.git.0x1207@gmail.com>
 <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
 <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
 <20250124003501.5fff00bc@orangepi5-plus>
Content-Language: en-US
From: Brad Griffis <bgriffis@nvidia.com>
In-Reply-To: <20250124003501.5fff00bc@orangepi5-plus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::21) To DS7PR12MB6237.namprd12.prod.outlook.com
 (2603:10b6:8:97::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6237:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c705861-e3f1-47e5-7ffe-08dd3be798ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MitkR3d2M2pwaDU4Unlnd2hRZnU5dEpyenlUQUVHWDR5TUluSVVTTTNTSXVo?=
 =?utf-8?B?TFd4bTRoUE5xTjJEWkhOejcxL3pML3hDdDhCMzhRc2dLejVWcGs4cW8yZCtY?=
 =?utf-8?B?S0NyUEx0T3BIM2hXZCtsRGJGLzVTTGhxRlAzQmZINUlGZkZuaXpUOE8yS0p5?=
 =?utf-8?B?QTBrb2Zydnh4L2trSFpIdUljQkFqUkFLdXl2cmVWdWlLUjF3Tkh0VVNhWW93?=
 =?utf-8?B?azZ5ZTUwN0N3TEoxemhtQks4MmcvS3dSbHdKU1pxTXpLR2dUaXF1MTh3dmFT?=
 =?utf-8?B?YVdFbDZQQlVxK3FKa1RUemNVbEk0TUVITHJoUlRucWM3ZHQ4NzRwRGVlZDcw?=
 =?utf-8?B?a2Mzdm02MGRYUThZZ2ZyYlJGZjRMK0FVRE8wU2dhVG5YdU1WRkVHMVpaUmI5?=
 =?utf-8?B?RnZpSjNJMkJDZ0JDUC95NmszS2hGSGxCWm8vK3hjSDNyUEFWNVl5TmhqU1Fi?=
 =?utf-8?B?UFJkeHV4SEs4UjZIL1M0OGRZcUx4YzcrQjRGTDBDM1hhWkRuWmYxeEMrb3B3?=
 =?utf-8?B?NGtPTnh0QVpKQStXa3p5Q1F4M1l4c2RqRWNsMVFvTElVZGdIZkk5M0wyc0dK?=
 =?utf-8?B?WmF6S0gxUG1YNSswbUQxMEd3R0I3STcyeXlFTEZFOTRIMVRVTXZsUG9yaDIw?=
 =?utf-8?B?MjdqaHROWVdtTGxLMzM0L0h3cVZkNm9TRkV0dUpldmE0aGRUL2hhRUREcmZU?=
 =?utf-8?B?ZW9aSEtMKzJWTVJZd1RxNjlDc2MwZCthOCtqNkxYMmc1SzljeGIzZElhY09L?=
 =?utf-8?B?dTBubnRrdVRuSHRyclBiWkI1TXVFWGl5dEE2R3FYRXJDbFFDemwydHRzcGJ2?=
 =?utf-8?B?YUdWbHJ2czg3WmMyNnV5VURtSlBIbkJsZTdqbFZoYTJUWFRheFhndGU0a1Zw?=
 =?utf-8?B?cjJkbUZjN09KQ3Q4ZmE3YjhlamJiVkJEWFAxUzJvZUI4NXdOTkVPdUFMS2lR?=
 =?utf-8?B?UUphQUhaMGY2am42cjV5NzJnSWxkUlVQZ0dLN2YxTHBWcHN2ZytsZlZQSVdu?=
 =?utf-8?B?U3ROV1MwOTNRRDNUWWtJaG9naVZOK0NxTWVEQVVVNXhyOTY2OXJZaXprUHdC?=
 =?utf-8?B?YWYrdnBZWko5Umt0RGQ5M2g2YVg1YW5VNDErMFJiNmRVMk01TG5ES1F0YklT?=
 =?utf-8?B?WU5aM2k1aktDQnExek16V0JpRGdTT09rakVaQTdOYyszOUttdUtDdkluWFBZ?=
 =?utf-8?B?SDBVU2dRZWVpbWRDbFZWU2MxeFBhdWtEd2VVTzNOQjE2ZnJZSFZxVFJlNm9r?=
 =?utf-8?B?TDM4dHBJQ2ZVY0ExV1NzQ0lEVE52amwzOW1LK1RONWpuaTJsSUY0UitWZEtJ?=
 =?utf-8?B?Ui9ROUtsZVYrbDZLNEdvT0l2cU5PcGdCUWVjWjZEc3ZBVjFpVm5VY3czWjFt?=
 =?utf-8?B?VDVaZGdpc0dVZUlYbjZWRWd1cTdmSktXaWhHYldIbGM1KzRMa3M2MEtudmoy?=
 =?utf-8?B?bmdaTzNiOUtNZmRXQ05ERFoyMkFKY0EwdlV0VVZuVUJIVXFCT244ZlMzaGt6?=
 =?utf-8?B?Q3g4TVVtdTk2clg4djlhZEl2UHY4Z3BWMzBnOXJFOGFyK2ZNLzFYODlXMWNz?=
 =?utf-8?B?TUhCZmRDRGNibFRMY1g0aWhTK2J0Wllxa1ZaTTdDOGgwc3ROM0gwdXVyUC8r?=
 =?utf-8?B?VFBQVCtyOUxVRTFSNXhYekhEcnRzaS9mdk9RM3FkZDRvY3VybDJUR0hlSEU0?=
 =?utf-8?B?VkNLQ25BTFVGMittZlRzWVMzRHBUaVo3U2xCTDRmOWdSTWJDSlg5ZFA3dEp4?=
 =?utf-8?B?MUJ6RlNVVFJrSTd6bkRFWmZCWjZLc0V3RElmblRWcWlESXBST05zbEtWem9R?=
 =?utf-8?B?bWtZallPV1grMjQybnRLTDJ1NDl5ZDZXb3VzbjZBVEJSQ1lsdkxNaWRLYXBK?=
 =?utf-8?Q?a5wWE/92wnci/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6237.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXpwdjBFVVJKMEtCV3VFSHJOWUJZaUkwajRJVHFmcVVUd2MxSkNaSEUrUjQv?=
 =?utf-8?B?Q0JUZXNZN09XZlZRRzdHUW51U3FaeFltRGl1UkNwcjhEVHNRZlRickY0eUlL?=
 =?utf-8?B?dzF1ZTAvbzlrSXZDRlpQSHJsZWtBVG4zQ0toK2txbUVzWGMyZlRxRWY3QXlM?=
 =?utf-8?B?VExtMys2UGYvRkpEODN4NjNCSzcvNjVRZGcyUGYrbzRxNE9weFdNdmVjTDdN?=
 =?utf-8?B?S0Jabm1JUHIyQlZyTzdIOTlZSzNIclQwNXNnVGxvTThSeEVVdUFrdGpIT052?=
 =?utf-8?B?Y2o0bnBkUUlQNytwelFZMk40TFlnOHNLdERVd2RBODBpZkhZRU5WWDN5UWdD?=
 =?utf-8?B?SFRKTWJOVGJ2cTREb05Oam4rY0FPcEZ3TTJQa1JOUEc0K2ZROFFjTjlMTzRI?=
 =?utf-8?B?MzRacTdxbVJpTGJJdENPN05ZRmNESEtaWUlDY3p3Q2luNTM2aStxSy9yMFo0?=
 =?utf-8?B?UWZQNDhyZXZXWjAvMmxRbFMwSHgwbDgzVmNVZzhnUEZCSzRaNDBpbDMzMjNS?=
 =?utf-8?B?TFlBQ2ZHaklkMTkyZzE4K04rR0szYWJmRkZubm5QdjZXSDVXSWdja2tvZDNr?=
 =?utf-8?B?dnJQYkx3Y2d0VU1JdWd6UVdPbDJyeS9RTlVrNjV6bXlwdkR3YW0wSTY3aXU4?=
 =?utf-8?B?dnlpeVhPak9oWnZzbkRZQi9QcmlEWHlEQndZYkJXVnpENG5YbER0cFNETTNm?=
 =?utf-8?B?N3Jta0dUTTFKb1V5ZWVNalhmYTl5VHlsVjhlY2pWYWZMTExPTGRIdzhCNFp1?=
 =?utf-8?B?R3JJOWo4UWlqZWpNVkNlc3VXSDFZVUEvbzF3OHFFMlBYaVRFMnM2TENrOUl3?=
 =?utf-8?B?VEdURzU3d2g1eDBHQm5JN2ZjbG1iUTQwUTEvL3l6R1VldmVKNXdBMXJEZm1k?=
 =?utf-8?B?Q1A1VXVzRGNiWDhOdkRaYWcrSmMzVGlNTmdiYW9TdUQ5cFFZSVU1TnJnWFk0?=
 =?utf-8?B?VUJGMnlKL0F4bi8rWlpiZThReHRpdmhjcUp1SnNkaXcwakJHVFh0U3VmY0pW?=
 =?utf-8?B?UlNwZStwWUxtd3hRcStQdmgzZTZtWEU0eWMza0dldVZyWlJkeW8rbXA1NEVQ?=
 =?utf-8?B?RDZkTXlDdU4zQUVNeWgzZUdwVW1BMTFSYXRNQXlWYXhsRytxcktFWlNyWGxh?=
 =?utf-8?B?aEdSelEwa3liTkhVcXpLc09jZUloelYwZEsvQ1U2dXg2aVE0Tkh3ZjF1Q3po?=
 =?utf-8?B?M1V5a2U2MStML3V4VUF4Wm5EVGFBSDRaOThDNEtRVS9lQkRRZllDdm5LZ1B4?=
 =?utf-8?B?TmtzMnVwK2lWRDVQZzVYbG9RN1BNbFR0aWpNSTUvZDR5RGRNWWMvcWJraWd1?=
 =?utf-8?B?ZndvTGxXNlVGemR5KzZ3Zlp3bmNadnZRSWdqZGEwNjkxNkQ5ZCswcldXRm1Q?=
 =?utf-8?B?OThHR05hWkt2ZDJ5YXlXM2l4VmV6SmxVd0VTdVdaTXNZZmxwcXNNQXpBaVk3?=
 =?utf-8?B?WmM3ZldGamhoTmJCWGxhR1JoRHlDc0s3QmN5aDE1eDk5TFhEZDhhK0J3TFJM?=
 =?utf-8?B?ckRTbXBKSXBRenoxQUdXR3NseGQrWlM0YVpIZSszMnU0TTIxbnJORlNCa043?=
 =?utf-8?B?cE11V0c1Ty9ZNWlPbVpMZDFnYzBzc0o4amZoQmZRcGtxV29iSllHMlp2cFlK?=
 =?utf-8?B?OWxnU21hT2pwUkNkV2d5Z3hXUFVzT21lNElNVVl6K3pjVkJkQUVMTzg1Z0Vo?=
 =?utf-8?B?TWNmMVFWVk9aMTYxQWhqT1NNOWN1R25yL041bDRXZmJwTCtXc0tOdm5ucWRG?=
 =?utf-8?B?eXNCQ29udnVMNXNXaG1uK2JxR2dQcFdNeGZiNEREYTRxUGNPSytxM0xCZ0lW?=
 =?utf-8?B?MUJ2QnQzVVUyQVhKMFBOdlJxQ2kwZm1nSTVxbDRobUZEcEhwY2FSZkYzd3NE?=
 =?utf-8?B?a25UOHlYR2tUUkU4SThyYy94clhmaGpNNm52ZGpsNDE1aUZpRHliS2N1cVVt?=
 =?utf-8?B?M2Z5d0ZCSEgyRzdMb01hOUpBUE84WTdWaDFWd1hXOTVyaytiakxQUndlN09O?=
 =?utf-8?B?ZSs5STVVdGhyS0pRV2hBRjQvRVloblFsZFJ3VlFNdysybzR2R1pwaXlkRDBh?=
 =?utf-8?B?d09Wb0tFblBPM1A1WXdBdUo4RFFnMHZTa3VrQmZVY1ZrUUdXZVpIMTJPN2M2?=
 =?utf-8?Q?9ESY1cvlSRuCYckw1AhZMn+ve?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c705861-e3f1-47e5-7ffe-08dd3be798ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 19:53:24.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjLC1MYQc4A0LCWZwqZoQXkD1WeCfxjtxufLQ8S3wMjHbhwZb9d64czioRCMQCflVMRx5/edZ1mcZ/3jxKNTKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745

On 1/23/25 08:35, Furong Xu wrote:
> What is the MTU of Tegra234 and NFS server? Are they both 1500?

I see the same issue.  Yes, both are 1500.

> Could you please try attached patch to confirm if this regression is
> fixed?

Patch fixes the issue.

> If the attached patch fixes this regression, and so it seems to be a
> cache coherence issue specific to Tegra234, since this patch avoid
> memcpy and the page buffers may be modified by upper network stack of
> course, then cache lines of page buffers may become dirty. But by
> reverting this patch, cache lines of page buffers never become dirty,
> this is the core difference.

Thanks for these insights. I don't have specific experience in this 
driver, but I see we have dma-coherent turned on for this driver in our 
downstream device tree files (i.e. dtbs that coincide with our 
out-of-tree implementation of this driver).  I went back to the original 
code and verified that the issue was there. I did a new test where I 
added dma-coherent to this ethernet node in the dtb and retested. It worked!

Just to clarify, the patch that you had us try was not intended as an 
actual fix, correct? It was only for diagnostic purposes, i.e. to see if 
there is some kind of cache coherence issue, which seems to be the case? 
  So perhaps the only fix needed is to add dma-coherent to our device tree?

