Return-Path: <netdev+bounces-145647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B08869D0454
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292351F21667
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF6E19414A;
	Sun, 17 Nov 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kZZ3og2K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907F39FD6
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731854000; cv=fail; b=HHVMSARTwpBL950F1dALi01mgdAO6tppxlEEQaBo3n3MzGjz3KyEYhyO+AkN8AFaJpSYPHGnTbmlOR75OEw6hIBKo8iZHGANfxL79LBEFDszk3n1lu7IdTxgpIadOqqzqQe1pkirNj/qyLIuU6A76seFCG6BSwyn3ku+pIUb6uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731854000; c=relaxed/simple;
	bh=vgqkw6/umfos8moHmqZd7P+K+/fb/TLZ5SwosMvkVlc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hgcznGAqB7DY+26tS5ndxQt3gKbtb85ieIJyZMpow+npR27ltfyHCKz5XiNfnxylvTa8GzCMbxY6OU7X5SB3FOaGGoGh867XfeEvnrZt0YYP20sQozgBncPtyNcIilV7AGDJAAEmoGN4HLYOV0HAAypXnunut9n+RyAQE7+nJxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kZZ3og2K; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1uHG+QngPRtNdoJv5RjZ8W3yS0jMvJXp4rfmvruMM6feLCJ++rPsVZTBLgmTxSEpG5JwYun3goGZ6FdsjF7Xrsk2ICaIV+kejleJBd3LvmsGJu7j5p6hLVmGAeToOw7K/OWMJhfPLRqp1Em6+aY3I/sCUHBc2af6ybopLchZ4cI7XXniMKXVAObJXGtgmz9E32j40R3T6UEZxsbMGbVAJQdXaBvXh70dSS/scW6ORxUgwShVkcI+DaiLzEelwpGtPKKXcT/fSLptLUD/HsC7PBQ2lwuG5kmxy7MQG4pgvuZEYKt2dGuZ0LlPw3nFlHJ0F2LJIvIGMK7s//kRsFXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APQFtS4GkJQKDiAaISbwrH9VfU2iiaigcSMARu+085g=;
 b=vx0niZboCo5DqJmHAW/z2c3cJUT653paUU0t2dBLCDGSPRfcGlGvIJiYmLekdO+jKF/KT0NdZ5Ko8tUG3WOmBS903ddDOhlOuOWD2066LPWmLjMbVZ/Fyd0QP6LToVtpf6UIsQkDGPbAucDOapCLjDd4wUtwh66jv+jhgP53ZBEtpYF1KCSzI/Cc4Q0kshaEm/fqLdO6q0Ve9+qpfRH321MJAdlICrbRBzmgdofuJio54kbN/ZpH4gbL2tKqTH+tnJMmzoT1j7ENXDo4z84vnmYW6/7SK9LLVJF3vkfOVb7yofkS5IF0TkmQqFXqAM1E28ZB7lUIwbImLIX4Xu5Xjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APQFtS4GkJQKDiAaISbwrH9VfU2iiaigcSMARu+085g=;
 b=kZZ3og2KJFaOjfAx2OYMCjCLInDdgeyMKOztasU6lWkl1WWpbKaG+Jj0VvQ9vra9xZvMDpDVYQe2m5d1mM+udnEf9We5kH0239x/iYpQ4YMnhL6GFNiTqyM7kDjrcQfksxqqNk+8gpwsd/t5wXI8k8sX3vHjx+KRi68lNq1IALU2tBxzppO9hn2JfJZM/DqIOsDloguduXixWJWX2JkCkg28+HW4PB/hW2jvJ/oyxbOrthOQehOGQ7uVscM94Y9r8CH8W/lJ6MOSFUEQauoUWM3LfJSuYyBI0F2gu7PxxqjMvs4mUCj6OL7/zR+3TxsdyvVEoHjnNnZ55gTa6Oc65w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Sun, 17 Nov
 2024 14:33:13 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%3]) with mapi id 15.20.8158.021; Sun, 17 Nov 2024
 14:33:13 +0000
Message-ID: <91609e70-110e-44b6-a45d-177f86ab7c99@nvidia.com>
Date: Sun, 17 Nov 2024 16:33:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Jiri Pirko <jiri@resnulli.us>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <20241114220937.719507-1-tariqt@nvidia.com>
 <20241114220937.719507-4-tariqt@nvidia.com>
 <Zzb9m-nyVoHLtJ75@nanopsycho.orion>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <Zzb9m-nyVoHLtJ75@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: afb374a8-7198-4552-35a2-08dd0714c42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alhyWlZacGNaL0t3clE2WGtjeWQ0YzVJd0lMM3NLZ0ZlNlBXMmFDejQ0ZG5G?=
 =?utf-8?B?ZUM2aVRmcDlNWEpoaHpGVGJsNU5lMjZwRk9GT3hkNmdtamFxL0RNZUtjUGVP?=
 =?utf-8?B?UmpuWHFqZlFnSEplMHQvUTFtekhoRCtETkxxcmYycE9ySnZ4L1N1czJpRkFZ?=
 =?utf-8?B?Y2JUK2E5ZG5nTFhLRGZwU21BdmpzVjJVNXcrZDMxZFUvb2U2UUdWeWkyRHYv?=
 =?utf-8?B?cGh5YWVPOHJqRjZ4YTVxdS82WVZNRjdMSlFFc0JTRzQ5ak16aHd2QmJiczR3?=
 =?utf-8?B?NEh0aVJTYjkxU0tIMjdLRTZyemRRTWFMU2VOUUE4VmU5OXJRNUNTSlBiS1dn?=
 =?utf-8?B?LzVFUVpFWm94V0txL1hvcWZvZXdsdjI4UUJ2KzRsZjk1MmR0WHpDL1VPZVJo?=
 =?utf-8?B?NEQ2V2JGQU9aQzNFR2tGRXZDUitBUW1wOWpwQVdYYldIRUg0aVZJRUQwZUM4?=
 =?utf-8?B?TDN2YnN5S2hJTitJWjIwRHNIdXZ5STlaR0NrYzRCYVRickt3K0tFUW5TL3NS?=
 =?utf-8?B?OWQ4U3BXYkpTQm9QUnErdjZLUURvdDJtQ3lCdldnNDlsOGpnbGlNQ3BLU0xG?=
 =?utf-8?B?U2M1S05WdTgydWxWTFF0MkZHK214c0lMUXEySlVpV0cwU1QyU3g3MFZxU29a?=
 =?utf-8?B?ejd2amcyKzF0K3dTU2hoMk9lT3plMUdGbzlkckxLUU9sODlmZ2dxSEtHZVNF?=
 =?utf-8?B?Uzd3VW81TkRyMGpPeWZFdTFUMm12bS91ZHIxNXpmRGZISUhPaFJOTEtUeWJP?=
 =?utf-8?B?RVdyeFpaTCszMW9uaVVKM2Z1RmxXcnF4L25FQWZkYzZJZGo4eWpOcHg1NWRF?=
 =?utf-8?B?dGtxd2d1N3NLSEQ0U1kwbFBtUk1RNUdZZ1hVanlkbDRmc2MxTi9jd1cyS2Q4?=
 =?utf-8?B?V3UvZ1p0c2JOTEV4T1BjbHE0aTArcDhqd3lkbnBtcHBFSjRHaFFtZ05mOGNk?=
 =?utf-8?B?V20rTDU0L1FBMXNxckNsOXFHMkQxcEFrd1dkSktUZytzM1hVc042RzV2SGtE?=
 =?utf-8?B?MlFOYU9qRWJjOUNXUkVOZFQ4ZmlXYit2ZnJlNUN4cVNucFFoV0ZRL1lmYzF2?=
 =?utf-8?B?YkZVcDNqcEd3cVhkOVJTOTlhQ1BEbFNLTzMxN2NrcDRlTGh1YmU4SEtNZTZ3?=
 =?utf-8?B?N3g3eFQ3Vlc5MG9KeHZQaGpQTStFVHNVcDk3SFF5ZEx0ejJNWTJYYStWdFJZ?=
 =?utf-8?B?TDRZbEJsQndjN1oyanhlL2FwTFdOMForYWxZaGpiWEdxMllxcXpaeGtMSEpu?=
 =?utf-8?B?YlQwaklxK2s3ckszc2tRMkdkd21RQndaVXJaejByaGFZTlpGaC9iMzFwckI4?=
 =?utf-8?B?blo5ZnA5Nll0RlVBY3QrVGtBa0crcXVGUWRUbUh5OWNVeGFpNkJsL2F0K253?=
 =?utf-8?B?bzFKS0tOMWZ1dXRWbjM3dXhLZzgzNjNyWEJTR2xtaHZhN2UzQ011eG5HWEhk?=
 =?utf-8?B?L2VrTVlOOXRnQllPTi9mSVJnZGMveDNBNmh0SFBvWFdHMnVCd2hzQ1VjTGZv?=
 =?utf-8?B?WUl4RFJRMzUxZHdiQnlvMjJQU3JualhTM2kwemlGSDRsMzNISTAzV2s1QUhE?=
 =?utf-8?B?TU1oVWZWVEZ6WFNBY3p0WjdoZ3h0bjN0THdudEx4YkFGdTg4dVdSL3VJdXZ4?=
 =?utf-8?B?ZGdzbUJHN3NHUFphcEtJNkJTMjFINWhSdnRlTVNvNEJ0QlJPRGxzUHVkZ2RD?=
 =?utf-8?B?ZW9MYzc2cTE4MVZvZWVBUEpqTmdYbkovUytXNXd6SU1uRmtMbUNlZ3E2dVhS?=
 =?utf-8?Q?Wmoqy1fBSVxmPXto1tmqa07gvG6i/D0hQ2PvGpG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ulg4SnNHTE5yUVNVeXBSeGtWUTFHZWxNZUlWbW8yNzI2M1BPM2xrQ0lmRGVK?=
 =?utf-8?B?Wk5XcUdGc0Y2NzN5VWloTVd4eEdKc2tuNHcvZUlZTHJ3a3FTVGt2UDlKZ0c2?=
 =?utf-8?B?Z1VDYWdLVmFnalFPMWdxb0tZVnU0dWxlczFCWjl4U1BSdTZRS01qcUJiMmFF?=
 =?utf-8?B?blZhUHVPSlNwaE9zVXpYcnl0UmJTanNSMnpsaFpSYmd4RVliNi9MeDE3ZnF1?=
 =?utf-8?B?Yy8rOGNTWWZLUXdYY3doaVVzS09NSnB5bkM5cVprdEREclFvZmNlVnRnTFJr?=
 =?utf-8?B?YWxZZVhhVlBUVWlKOVJlcHVaOWR6N2czeWhtTHUvQXRSR0tMbFl2czJjNkdt?=
 =?utf-8?B?TElTVHNTTEgrQ1NGMjFSdklJalZOeUdOOXd1MFhkNUU1TUFQYWZpb0hvR2Rq?=
 =?utf-8?B?Rk94UHJScEI3WWp2blVVbWw3WGJXUU1BNGhrWFZETWFFZXo4TUI4Y3hicXI4?=
 =?utf-8?B?aFlHNVM4S3RXWEVCK3ZrdG5NaTd3aDUxdllJUlhuMUdOSnlWcUZrV2ZOZlIy?=
 =?utf-8?B?aWlyQmRIbTcrMUhxNzNHeHhTbk05cURuREZ5bG9NMVNGMVlPU0Nuc25xK1B3?=
 =?utf-8?B?QWZHcHFuTzdWSXMyL2NMZ3Q0NnMxQ1ByUmdvUXlkUXpqK3d3U05taXlEWC9Z?=
 =?utf-8?B?cXZTaHBxVE8xRDgxeHRTOEJBbFY1WTdiQ3EwNys5aU5oSklsTFVEZ3ZJc0dr?=
 =?utf-8?B?UUpOWG5qWngrMU5UMXFCRDFJdFlUVk9iUGFuSnRZdWdFOVNMN2ViUWJ0M1oz?=
 =?utf-8?B?aXlqZzVRb1IvZXNmaFhNdUJQTVR1aWNMTUZRZUY4YkRzcGRvWHdpSk9FMStC?=
 =?utf-8?B?Q3MxL3NWdTlUOHZtcTBDN3VmeDBKclhpcUFTNFRPSzFtNHpiRGF4eWYydDN1?=
 =?utf-8?B?dFViMVVxOU9aUTZnV1RNOFJiQzZkWGlEWmR4cUV5UmYreEQ5UWpnSGMxaVNj?=
 =?utf-8?B?QWVQZU5vT2gzdnBsSU1uYm5Jd3MxKzN5OVIwRlJQRVlMWXBRdklKWU14b01J?=
 =?utf-8?B?S01KSC94YlF2amkvQmNNelFRMlR6S29rMGdjNGw2UWQ5RTRlT1RqM1JVM2dM?=
 =?utf-8?B?ZDZ2WDVlVndSNUNnU1ZkZ0JSbVlRYWFFdGt2dFAwc0xnOXpBZnZuMzY4SWUr?=
 =?utf-8?B?NUVUbWpFeTQ0cjNqMFk0RXZTNzRVbGppR01nTlBoMS9XbXFTQTNPT3NqOXhs?=
 =?utf-8?B?MmFibnR6T1lwd2pNcmtyL3gzcHgvSElmU0hGWitVelkzSEtYNURTOUtwQ0Qz?=
 =?utf-8?B?YWFFUysrcWpyRDBBbE9XQmFkc1VSbU5Ic3BPbzBEVlBOTVVHdVF6QmdjSTJk?=
 =?utf-8?B?N2NBbWNDclpOTUVicUcxK2dVNitkUkhVeEE5elRCWkdPOEJ2ZTFlcG54YmlX?=
 =?utf-8?B?ZnNLU3pJcjFOY2hKWHVSMXB3eGdrRkc3ZE5zVnMxZTRQSXJVM0RtWDdrS0xJ?=
 =?utf-8?B?UnBBZlRGRkJIV3c2OGRNTm9INzVBL0JDQVNNVkxlblUrMWdhRURqRFRqVXBK?=
 =?utf-8?B?dUZiaGZjZXFudC9BOXB6Ykk5bVp4NXpJeDBQUnhEem11cEFTU1c0UC8xVFQ2?=
 =?utf-8?B?bzJPSmlTYmQwS1NzZWF2QUtlc1dHZHM3R016SCtZRnpuSDVJZkdpTEU1eWdv?=
 =?utf-8?B?TEo1WEVEVGpZYXVDQkp2VVNQNGQ5NFc2U2RQUXQzV1N4ZzJQRFF6QTg2akhy?=
 =?utf-8?B?RXJNbktpQ2c4YlpNOGVPZmIwNDlMdVFnNDNqSndqRlFXNmE4MlpVV3VGL3lY?=
 =?utf-8?B?dWVGNjJ5ZXBvTm5nNmgxRmdYMVdVL2JJRi93UjY1ZW1HeFpydmV2UmZPeU8v?=
 =?utf-8?B?ek1EejV0dUprMm85L29WSUFkcDFaY1ZxMXdKY0x4Ujl0T0xZK0g0alUrL1pH?=
 =?utf-8?B?dnR4QlRTdWtIYTZBL1hwYi9LTS90ZVVOak5WczhrVGQ0bHdzTHlaUy9yZStP?=
 =?utf-8?B?Z3c2b0hMYkx3VldYaENsL3JWZnJZbERjaUdieklrK0VibGtxOFZWYkhidytI?=
 =?utf-8?B?RUNrempKcXorbldBQTUwUXBSL3UzTHcwek55VXJUa1RDR2Y3b3hGNWthVXJt?=
 =?utf-8?B?eHRaZUwyRUdRRkVnMTJvR3dQOUxHUjg3QXh0aEFRRFkrWWxZdzZDeUNZQ21B?=
 =?utf-8?Q?QY0ls+yzp7VPBGidkMBplPl+5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb374a8-7198-4552-35a2-08dd0714c42b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 14:33:13.1022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AEPLaitgpEWhOBw3BB8GLbYoRqA1qzvt2rTYBiUWRw66cZL2aaeCHHk4SYsqS1/AYGDxhl5Bhxks7ebEWZlxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742



On 15/11/2024 9:51, Jiri Pirko wrote:
> Thu, Nov 14, 2024 at 11:09:32PM CET, tariqt@nvidia.com wrote:
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> Introduce support for specifying bandwidth proportions between traffic
>> classes (TC) in the devlink-rate API. This new option allows users to
>> allocate bandwidth across multiple traffic classes in a single command.
>>
>> This feature provides a more granular control over traffic management,
>> especially for scenarios requiring Enhanced Transmission Selection.
>>
>> Users can now define a specific bandwidth share for each traffic class,
>> such as allocating 20% for TC0 (TCP/UDP) and 80% for TC5 (RoCE).
>>
>> Example:
>> DEV=pci/0000:08:00.0
>>
>> $ devlink port function rate add $DEV/vfs_group tx_share 10Gbit \
>>   tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0
>>
>> $ devlink port function rate set $DEV/vfs_group \
>>   tc-bw 0:20 1:0 2:0 3:0 4:0 5:10 6:60 7:0
>>
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>> Documentation/netlink/specs/devlink.yaml | 22 ++++++++
>> include/net/devlink.h                    |  7 +++
>> include/uapi/linux/devlink.h             |  4 ++
>> net/devlink/netlink_gen.c                | 15 +++--
>> net/devlink/netlink_gen.h                |  1 +
>> net/devlink/rate.c                       | 71 +++++++++++++++++++++++-
>> 6 files changed, 113 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>> index 09fbb4c03fc8..68211b8218fd 100644
>> --- a/Documentation/netlink/specs/devlink.yaml
>> +++ b/Documentation/netlink/specs/devlink.yaml
>> @@ -817,6 +817,16 @@ attribute-sets:
>>        -
>>          name: rate-tx-weight
>>          type: u32
>> +      -
>> +        name: rate-tc-index
>> +        type: u8
>> +
>> +      - name: rate-bw
> 
> This is bandwidth of tc. The name therefore should be "rate-tc-bw".
> Could you also document units of this attr value?
> 
>

I will rename it to rate-tc-bw and update the documentation to include 
the valid range (0-100).

>> +        type: u32
>> +      -
>> +        name: rate-tc-bw
>> +        type: nest
>> +        nested-attributes: dl-rate-tc-bw
>>        -
>>          name: region-direct
>>          type: flag
>> @@ -1225,6 +1235,16 @@ attribute-sets:
>>        -
>>          name: flash
>>          type: flag
>> +  -
>> +    name: dl-rate-tc-bw
>> +    subset-of: devlink
>> +    attributes:
>> +      -
>> +        name: rate-tc-index
>> +        type: u8
>> +      -
>> +        name: rate-bw
>> +        type: u32
>>
>> operations:
>>    enum-model: directional
>> @@ -2148,6 +2168,7 @@ operations:
>>              - rate-tx-max
>>              - rate-tx-priority
>>              - rate-tx-weight
>> +            - rate-tc-bw
>>              - rate-parent-node-name
>>
>>      -
>> @@ -2168,6 +2189,7 @@ operations:
>>              - rate-tx-max
>>              - rate-tx-priority
>>              - rate-tx-weight
>> +            - rate-tc-bw
>>              - rate-parent-node-name
>>
>>      -
>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>> index fbb9a2668e24..277b826cdd60 100644
>> --- a/include/net/devlink.h
>> +++ b/include/net/devlink.h
>> @@ -20,6 +20,7 @@
>> #include <uapi/linux/devlink.h>
>> #include <linux/xarray.h>
>> #include <linux/firmware.h>
>> +#include <linux/dcbnl.h>
>>
>> struct devlink;
>> struct devlink_linecard;
>> @@ -117,6 +118,8 @@ struct devlink_rate {
>>
>> 	u32 tx_priority;
>> 	u32 tx_weight;
>> +
>> +	u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
>> };
>>
>> struct devlink_port {
>> @@ -1469,6 +1472,8 @@ struct devlink_ops {
>> 					 u32 tx_priority, struct netlink_ext_ack *extack);
>> 	int (*rate_leaf_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
>> 				       u32 tx_weight, struct netlink_ext_ack *extack);
>> +	int (*rate_leaf_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
>> +				   u32 *tc_bw, struct netlink_ext_ack *extack);
>> 	int (*rate_node_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
>> 				      u64 tx_share, struct netlink_ext_ack *extack);
>> 	int (*rate_node_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
>> @@ -1477,6 +1482,8 @@ struct devlink_ops {
>> 					 u32 tx_priority, struct netlink_ext_ack *extack);
>> 	int (*rate_node_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
>> 				       u32 tx_weight, struct netlink_ext_ack *extack);
>> +	int (*rate_node_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
>> +				   u32 *tc_bw, struct netlink_ext_ack *extack);
>> 	int (*rate_node_new)(struct devlink_rate *rate_node, void **priv,
>> 			     struct netlink_ext_ack *extack);
>> 	int (*rate_node_del)(struct devlink_rate *rate_node, void *priv,
>> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>> index 9401aa343673..a66217808dd9 100644
>> --- a/include/uapi/linux/devlink.h
>> +++ b/include/uapi/linux/devlink.h
>> @@ -614,6 +614,10 @@ enum devlink_attr {
>>
>> 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
>>
>> +	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
>> +	DEVLINK_ATTR_RATE_BW,			/* u32 */
>> +	DEVLINK_ATTR_RATE_TC_BW,		/* nested */
>> +
>> 	/* Add new attributes above here, update the spec in
>> 	 * Documentation/netlink/specs/devlink.yaml and re-generate
>> 	 * net/devlink/netlink_gen.c.
>> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
>> index f9786d51f68f..fac062ede7a4 100644
>> --- a/net/devlink/netlink_gen.c
>> +++ b/net/devlink/netlink_gen.c
>> @@ -18,6 +18,11 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
>> 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
>> };
>>
>> +const struct nla_policy devlink_dl_rate_tc_bw_nl_policy[DEVLINK_ATTR_RATE_BW + 1] = {
>> +	[DEVLINK_ATTR_RATE_TC_INDEX] = { .type = NLA_U8, },
>> +	[DEVLINK_ATTR_RATE_BW] = { .type = NLA_U32, },
>> +};
>> +
>> const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
>> 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG, },
>> };
>> @@ -496,7 +501,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
>> };
>>
>> /* DEVLINK_CMD_RATE_SET - do */
>> -static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
>> +static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
>> 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>> 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>> 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> @@ -504,11 +509,12 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
>> 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
>> 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
>> 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
>> +	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_nl_policy),
>> 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> };
>>
>> /* DEVLINK_CMD_RATE_NEW - do */
>> -static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
>> +static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
>> 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>> 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>> 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> @@ -516,6 +522,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
>> 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
>> 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
>> 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
>> +	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_nl_policy),
>> 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> };
>>
>> @@ -1164,7 +1171,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
>> 		.doit		= devlink_nl_rate_set_doit,
>> 		.post_doit	= devlink_nl_post_doit,
>> 		.policy		= devlink_rate_set_nl_policy,
>> -		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
>> +		.maxattr	= DEVLINK_ATTR_RATE_TC_BW,
>> 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> 	},
>> 	{
>> @@ -1174,7 +1181,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
>> 		.doit		= devlink_nl_rate_new_doit,
>> 		.post_doit	= devlink_nl_post_doit,
>> 		.policy		= devlink_rate_new_nl_policy,
>> -		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
>> +		.maxattr	= DEVLINK_ATTR_RATE_TC_BW,
>> 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> 	},
>> 	{
>> diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
>> index 8f2bd50ddf5e..df37c3ef3113 100644
>> --- a/net/devlink/netlink_gen.h
>> +++ b/net/devlink/netlink_gen.h
>> @@ -13,6 +13,7 @@
>>
>> /* Common nested types */
>> extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
>> +extern const struct nla_policy devlink_dl_rate_tc_bw_nl_policy[DEVLINK_ATTR_RATE_BW + 1];
>> extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
>>
>> /* Ops table for devlink */
>> diff --git a/net/devlink/rate.c b/net/devlink/rate.c
>> index 8828ffaf6cbc..dbf1d552fae2 100644
>> --- a/net/devlink/rate.c
>> +++ b/net/devlink/rate.c
>> @@ -86,7 +86,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
>> 				int flags, struct netlink_ext_ack *extack)
>> {
>> 	struct devlink *devlink = devlink_rate->devlink;
>> +	struct nlattr *nla_tc_bw;
>> 	void *hdr;
>> +	int i;
>>
>> 	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
>> 	if (!hdr)
>> @@ -124,10 +126,29 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
>> 			devlink_rate->tx_weight))
>> 		goto nla_put_failure;
>>
>> -	if (devlink_rate->parent)
>> -		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
>> -				   devlink_rate->parent->name))
>> +	nla_tc_bw = nla_nest_start(msg, DEVLINK_ATTR_RATE_TC_BW);
>> +	if (!nla_tc_bw)
>> +		goto nla_put_failure;
>> +
>> +	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
> 
> Wait, so you fill this up unconditionally? I mean, for set you check if
> the driver supports it. For get you always fill this up? That looks
> wrong. Any reason to do so?
> 
>

I followed the existing pattern in devlink, where attributes like 
tx_share and tx_weight are filled unconditionally in the get operation.
Should I still add a check to see if tc_bw_set is supported?

>> +		struct nlattr *nla_tc_entry = nla_nest_start(msg, i);
>> +
>> +		if (!nla_tc_entry) {
>> +			nla_nest_cancel(msg, nla_tc_bw);
>> +			goto nla_put_failure;
>> +		}
>> +
>> +		if (nla_put_u8(msg, DEVLINK_ATTR_RATE_TC_INDEX, i) ||
>> +		    nla_put_u32(msg, DEVLINK_ATTR_RATE_BW, devlink_rate->tc_bw[i])) {
>> +			nla_nest_cancel(msg, nla_tc_entry);
>> +			nla_nest_cancel(msg, nla_tc_bw);
>> 			goto nla_put_failure;
>> +		}
>> +
>> +		nla_nest_end(msg, nla_tc_entry);
>> +	}
>> +
>> +	nla_nest_end(msg, nla_tc_bw);
>>
>> 	genlmsg_end(msg, hdr);
>> 	return 0;
>> @@ -380,6 +401,38 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
>> 		devlink_rate->tx_weight = weight;
>> 	}
>>
>> +	if (attrs[DEVLINK_ATTR_RATE_TC_BW]) {
>> +		struct nlattr *nla_tc_bw = attrs[DEVLINK_ATTR_RATE_TC_BW];
>> +		struct nlattr *tb[DEVLINK_ATTR_RATE_BW + 1];
>> +		u32 tc_bw[IEEE_8021QAZ_MAX_TCS] = {0};
>> +		struct nlattr *nla_tc_entry;
>> +		int rem, tc_index;
>> +
>> +		nla_for_each_nested(nla_tc_entry, nla_tc_bw, rem) {
>> +			err = nla_parse_nested(tb, DEVLINK_ATTR_RATE_BW, nla_tc_entry,
>> +					       devlink_dl_rate_tc_bw_nl_policy, info->extack);
>> +			if (err)
>> +				return err;
>> +
>> +			if (tb[DEVLINK_ATTR_RATE_TC_INDEX] && tb[DEVLINK_ATTR_RATE_BW]) {
>> +				tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
> 
> Ough, you trust user to provide you index to array. Recipe for disaster.
> NLA_POLICY_RANGE() for tc-index would sanitize this. Btw, you use nested
> array to carry rate-bw and tc-index attrs, isn't the array index good
> enough? Then you can avoid tc-index attr (which in most cases holds
> redundant index value). Or do you expect userspace to pass only partial
> set of tcs?
> 
>

I will drop the tc-index attribute as it is redundant. To address your 
question: I expect userspace to always provide a complete set of tcs.

>> +				tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_BW]);
>> +			}
>> +		}
>> +
>> +		if (devlink_rate_is_leaf(devlink_rate))
>> +			err = ops->rate_leaf_tc_bw_set(devlink_rate, devlink_rate->priv,
>> +						       tc_bw, info->extack);
>> +		else if (devlink_rate_is_node(devlink_rate))
>> +			err = ops->rate_node_tc_bw_set(devlink_rate, devlink_rate->priv,
>> +						       tc_bw, info->extack);
>> +
>> +		if (err)
>> +			return err;
>> +
>> +		memcpy(devlink_rate->tc_bw, tc_bw, sizeof(tc_bw));
>> +	}
>> +
>> 	nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
>> 	if (nla_parent) {
>> 		err = devlink_nl_rate_parent_node_set(devlink_rate, info,
>> @@ -423,6 +476,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
>> 					    "TX weight set isn't supported for the leafs");
>> 			return false;
>> 		}
>> +		if (attrs[DEVLINK_ATTR_RATE_TC_BW] && !ops->rate_leaf_tc_bw_set) {
>> +			NL_SET_ERR_MSG_ATTR(info->extack,
>> +					    attrs[DEVLINK_ATTR_RATE_TC_BW],
>> +					    "TC bandwidth set isn't supported for the leafs");
>> +			return false;
>> +		}
>> 	} else if (type == DEVLINK_RATE_TYPE_NODE) {
>> 		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_node_tx_share_set) {
>> 			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the nodes");
>> @@ -449,6 +508,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
>> 					    "TX weight set isn't supported for the nodes");
>> 			return false;
>> 		}
>> +		if (attrs[DEVLINK_ATTR_RATE_TC_BW] && !ops->rate_node_tc_bw_set) {
>> +			NL_SET_ERR_MSG_ATTR(info->extack,
>> +					    attrs[DEVLINK_ATTR_RATE_TC_BW],
>> +					    "TC bandwidth set isn't supported for the nodes");
>> +			return false;
>> +		}
>> 	} else {
>> 		WARN(1, "Unknown type of rate object");
>> 		return false;
>> -- 
>> 2.44.0
>>


