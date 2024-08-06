Return-Path: <netdev+bounces-116066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE75948EF7
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AE01C20ACB
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3906D1BDA83;
	Tue,  6 Aug 2024 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JVQBRJ0J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAE1D52B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946942; cv=fail; b=vEAd8EUlqBudQIJ4WzbuQ3s+GAKHBQUnL6bXoQ0w+23KhB8ocWdXnl/0cpCsqlH0puGEnjfJGoi93DVdzOBL3EcJaaXac7HZRvXd06sVDcgQCDWfDwX9ZaOIjC38uz5eoR7ZvTtnJ8Q9/UTOpoB52PODnYqwcA0ucJO8r6mgekw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946942; c=relaxed/simple;
	bh=mANwWW6ODz/nvVXJ/y/LfC0NVlYg0p7VOKVlFfdVeDU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KSV+DJPW0xUEwUdLiah8XxB9Y3WbS0UOrVtz1sfUQryvjNFiBo/KSzu+H2DSxdlzwwVt4bFqXuDcNjXgau1nL5l6qk6OImJjgIlsOkePXgepAatpLlMobyVZlt/gqxvUfJ4AIkzjZglSMsYFpkkrc9JJbJ/7IL/dlpDzdJT53AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JVQBRJ0J; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAyqfNPb29MVrcwrjG/FK0QbNGQee0OAbT4YaKtRL9JP4mitlwGXuhqLH0OO+Ci3+firiP6pEtFmazC433zEzIJNGJBot+EYUZ7pqIpDbnFGVQpUDT36Q817g01HBWWxseFL8HBLmdpzUcA2vZmtyCuzHeA7m65ZO+8yQFME23BGz5ZkObrHFaZVYSthof+b+fR5LgNb3Dxm3wE5YjiOf3Qb3kUJpRxt/I3bITtnaZpwqaa8Jp2ECYW6j7zP6mKyUxCPmPjcDEFYAsaCqE5P+Ipz4/5A128TS/6dFr9BfPKgQrIUKWwx35XX53sw9xNb2tlAoB6Vum6MA2R98vmPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAMJDmvI4XhYfk/GUYfmVhQF9sxVJihMaWgOqboQGwA=;
 b=vltMKQG4Z8uwqmpqyLS1R7kwuip2UpXcQ5SfBe4B7mryivyIVDGLU8/THUU8LKDch/zoriwxdQa9BvMF+4NBtBYQo0bJDPJlGXg8BRUdj8h0y5WG3PoMJcBMVubpXE5dZZuo/UT7s76m2KQIXUPeNaX6iQfgRkQr7sf46c38/JgejJfVnx9GrgFynp6AdjNwSgcC358BdyVco2JvWHNimhdbdnyMUPs7wUJw1dyzeY8s3UC+w73nC87nltGzAqo+cMudAjQE4Y2IEupeANa1OyxSPyde9wgIcXoNT12Yd3Nzm4NtpzkQCzxCLT1EVWxljfn8jhNOPeEFrn2skWctaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAMJDmvI4XhYfk/GUYfmVhQF9sxVJihMaWgOqboQGwA=;
 b=JVQBRJ0J89Tc2gtD4J5eQWleR1VX4i21trvqWeKkJSSkLJdHbxbQkFBqinKz4Xmg6xBDI+xSl+Y9KH0Fh6c7dNH2AreWbA7IX+Z2xxCh4I5v4nObdrb2ao603wVQoQrMfG+axYmmwpuoHOaM9pKqE7SZuiEH4JMQkwP1ZbukfPIrRjgkIbVck5uvW+hznaZhf/G+51jIK65IC52QYiM1lqITzDxSxkR48kV8WPhqGj8dWFWFwKv3A/oCx/uDSNMzhV4xc4Ll+m+ko5hR44OhGcGasApHvue1jQ0NqnyyshsAmUYluNFZWx2Y/HrpJGbIq3GDIfNbfIKkLfW3FTP83w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 12:22:17 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 12:22:17 +0000
Message-ID: <cbdb41f5-c157-49a5-acc0-cbce5516ea62@nvidia.com>
Date: Tue, 6 Aug 2024 15:22:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12] ethtool: rss: driver tweaks and netlink
 context dumps
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, donald.hunter@gmail.com, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com, jdamato@fastly.com,
 Ahmed Zaki <ahmed.zaki@intel.com>
References: <20240803042624.970352-1-kuba@kernel.org>
 <05ae8316-d3aa-4356-98c6-55ed4253c8a7@nvidia.com>
 <20240805151317.5c006ff7@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240805151317.5c006ff7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0057.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::17) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: fdac88bb-31e0-49e8-85ea-08dcb61268d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGdPdTVGUUZvd0o4T0VaTC9ndWRvdy80QU9NRTRUeXdxTXdFT2wrNzd6UnBH?=
 =?utf-8?B?TW8wYzJRbVc4K09zbFdZcG9zVlZNNDZ6a2RIQURlYUR4aGFvVkNGNjhpTlor?=
 =?utf-8?B?QW9rSnQxbG1kUTdKNElTK3ZjQko1M01wOE9BQm5wd3hhaXlzT1ZYRE9JSGwr?=
 =?utf-8?B?UGdsUFowdVByVlkrdE00R2tSOFlzZU02dEZCdFRYRTlLM2tZUGtwTjVDMlg2?=
 =?utf-8?B?dExwdzN1Mm5mbUxHYUxEWVFJbXNlUUlnM0VoV2JBUVk5WUpTTHovNEsvWER1?=
 =?utf-8?B?MWx0N1VVKytmZm12WmZncWFUUkhPdjZ1UHB6ZVI2aXpRZkwrRWVqenN3ald3?=
 =?utf-8?B?N3lDVHFZdUhyUTY4cXZqanRPanltSDQvU3RhS3hNQWJueHJnbW03SERmdkt3?=
 =?utf-8?B?eGpmNDgrVWN1VGVlSHhOcFhpaEZ4dHUrOHZjQ2FBaUx6VVplRUpuOFhYUzhF?=
 =?utf-8?B?cFlDRTJwN0RHWlE1cnQ4SC9CK3lGanhVd0o5QVhDQk5zRFY1aDhPSHF0aWNq?=
 =?utf-8?B?SzZZdERKQWRHSTZwR1l6L1EvMHhjcE12ZjZHWDdTbk5MaHdvRU41NG9IWUJm?=
 =?utf-8?B?eFNEQXNkUWhzM1ZRT2R2V1hiOTFEczhvMHB6Z1UrM000b3IyY3lFci9ENmY2?=
 =?utf-8?B?eTFuTVkveitxaStKMVdwWjM4em1IVmJMRUYyc3M3bUxweDFWNmdpYzdYS1RF?=
 =?utf-8?B?aXNTNDlwSjZLcHRlUWtMaUJ1VjhPcG5ELzhHcGpZT0tsU1JCSHB1aWJtVGd4?=
 =?utf-8?B?WVB3OS9WVklmb3Y1V2lIc25PZHBXbGVzbVZxdmlpcDBmdTFCWVBnQXR3a1p4?=
 =?utf-8?B?Y1FqSTlHMTd5Qm1EUWZDekFMelF2RnJZVFljUC9wV3NlS2QreGJVelZPS1lE?=
 =?utf-8?B?ckRoZ2xyQlBob1JSelBtSHM2WExTdnF1c0NkVkVFbXZFRUR1VDY4MmREOUs0?=
 =?utf-8?B?MlFxUmJBVzZQbXp5TTVldlBtQkN1RzBHOVoweW4xVEZyTlpMRm03Tm1Rdzh2?=
 =?utf-8?B?UVBUV2JBL2hpb3pnL2pYNkhQSkF4NXNUMURhU0pzVVMxNis4SDV2YThkcEdo?=
 =?utf-8?B?MDdicVFqcytwdEdzNHB4V2ZyanFnc1U4RWRnL0RqQW1SNXRTVkRXYkpNQjAy?=
 =?utf-8?B?U0YyRDB5OWtDU3BPY1FTOGZLaGNncXQzUlNYUFJyM2hEaWt2cFdUL2VPMzNu?=
 =?utf-8?B?U250VnBRd1luRmY5THcvUy81QlpDUTRWYklhbTA5TkVEaGFlTFo5UDVJZ25J?=
 =?utf-8?B?NFdyc2tDV1k3K25OMk9YaHJIanRycmJMMHRveE1DdUIyWGlOUEFZdExGMXpa?=
 =?utf-8?B?Y2lxc3Z5YTdqdGN2TnhVZDRhVUVqQVk2RnM1dm02YkF3d3FsdjNzeURzb25N?=
 =?utf-8?B?NGM3bWhVekZWdzdkTjhrUVlIdEJsbG0zS1BGSmFuUlBFNTRCTWwvbytiZDVF?=
 =?utf-8?B?Zk8wZjRENTI0bWRVOWpPRUtzUW9PWDAxZk1kelFsMFVvRG1iOHVFRWdvNDZR?=
 =?utf-8?B?WTBwSjh1dkJYbzRtVm5NOWtsa2IyWVBLdldIcGxPWHE5M1dQMXUrSVUwSG8r?=
 =?utf-8?B?UWtVV1A4blRIeDVrWXdTMjNPbXRza2FLK1owbzd6Z2hvcFBKZXNQQnBQdU52?=
 =?utf-8?B?YjM5M2JoY1hhbnBRdHJxOVpTMUU2dkdxQzZ1YldxK3NkVDhIYWI2R3pkR0hZ?=
 =?utf-8?B?akZnUzBJNjM2R0FHRWdDalhzcmZFZmx5Tjc0UkozVGFpM2N4UmdXdWpYSXZO?=
 =?utf-8?B?REQ0KzNpUXliL3BNQ3o1L21weWxIWXdpZ21tUGh6THVidmFtZWpMeXZiZkdV?=
 =?utf-8?B?Qi9TYzBJYWU4VG5WcmFXUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aSszVDc3OHZsSHk2RW42dkErMElseWN5RHRRLzBuNU0xWWhwQUx4YmNWM2JN?=
 =?utf-8?B?dDdneENGZmNjd1ZaeVRTR3BBbm9NdmRvU2ZYbjFRSXkrZkZQamltTHNzOUVj?=
 =?utf-8?B?aFBvTWV5c0tpNE5aTUI4TjBrZGcwc2JvWS93VVFveVZnMGZpeTl6WWdaU3Vw?=
 =?utf-8?B?dFZJK3d2WWs5dTFUT0QvS2VrVnN4aUhmMU1tYm5iZFF2U05NYmJ5OUFaRWQ2?=
 =?utf-8?B?clJBSUVpVWc5UkhmS1RXMDhEODMyd1gxT0lWMWR0MTJJK2Uwcjg5ZHN1TnNp?=
 =?utf-8?B?ajhoVitPZXFBRkgvcVNPakJZYWlGa0xKL2QrN21XWnR5WGpvU0ttT1huQVQ1?=
 =?utf-8?B?bTZrUnQya3hHem5GWEpEM0RxN1lybVFiWVdnMmZiWDMvMWdjdVVmREpUcE9X?=
 =?utf-8?B?eDl5SnJ0Mk9Ec0IvekJ5NEhTN0YzMzFneWJGNWhPWWY0TjdwUlVoclBLQVJZ?=
 =?utf-8?B?TDdsQThaNU5GOHJ1c2V4QjlyWmd4ejlUSzhzNEhDd09jYVlCalloOFBNREdF?=
 =?utf-8?B?MHUrUEZLWStrK2ZEU09hRTZwbWNkajd6aEMvQWNaR2tDSGhRc0szYXIrRmNM?=
 =?utf-8?B?WkIyZ3gzUTE4NEJ6Vk9EUytVSmZIQSsxZkJaS29wTlE0Q0RGeVNTWlp3dVlj?=
 =?utf-8?B?VUpQV1IrM0xxR0Rkc1lmRGFlTGhINmVxUTdTMkFlZ0JTeHBBRkxjbTk2L2xh?=
 =?utf-8?B?MFlaVlFiakRIQVVncmxta2RDYkVxMnJvUUZiWWIvdC9mejZpN0RwakwxYW5k?=
 =?utf-8?B?U0ErK2hIc25ZQ3JLNWRqVG1pb2ZleS83c0JESVJQYnJaeGR5d0VablJtUm4w?=
 =?utf-8?B?c2k5d2NCRjI3U0tFTDhEZDAyVHdjYmFDOVUvdnZGYk1kOTJaUXdVRXR0VU1k?=
 =?utf-8?B?aDdoNWZ6TmY0VHp2VnhJdXJCOGdjRGhDUUdHeWFqVytPMVE2MTVkVDJhUVA2?=
 =?utf-8?B?Uy9ZZUt6QWNzWXd0cWFvOEI3b1VIYkZkSDJNY2JZb2RaMHo4TWNvTmpEUkNW?=
 =?utf-8?B?aUMxTEJjYTNIUkxLMjF3SGcwY2hNckpRTzg0bVNoK2VkZ0xnS1JVWVlPZXVG?=
 =?utf-8?B?YUFuQXVMenRjbWhjczlTK0pFbGZsTk90Y3hMV05HOEExYXJjdkJzQnUxRUxD?=
 =?utf-8?B?R2pUT1J5c2k4VlBVM0pPcFBRVWQ1Ny9qVGhheHJxYlZtUXdGZjZ3ejdiYW8w?=
 =?utf-8?B?YW1ydHc1VERsVDFkaEMvVHJPY3VRbHdPMS9wUmdzL2hMeVRRZmhxQ2c1UEhD?=
 =?utf-8?B?SUNGNHdYQ25uMkJVMGhUUTNSQTlHSjV5ampOa0xCYkIrUFhTSFM2SzRyS0dO?=
 =?utf-8?B?U0F2cW1jM1pLZFMvbU9XSm55bXEyWTdQZ0lGMmVHWHY1Y1o1RDJSdlIwYjBy?=
 =?utf-8?B?MDdIUVJXOFlnZFRoQ0l5ZTk3VklXTGduNlczdHFkWW1PSDdrR1pidE5hdXJ1?=
 =?utf-8?B?MUkvbjUwM29mS0x6aGEzVm9oMUxHQllZRGRkZ3cwWnJHMUdKRENuYXc3WlZN?=
 =?utf-8?B?QjNQZ3VLbWVEaGJwd0RNdFcxdWROdmRtWXMvUDduM254dFN3c1ZyT05zRjEx?=
 =?utf-8?B?NHJNbjJaSjczVy9UTGhDNzN2bDV0cWd1c1ZscFIyYm1mYm1ZYW5teWRhWGZU?=
 =?utf-8?B?YkJQRUJXalpaTzJTcHRVUnVwRUFJSlFzOW5MaVl0cDNaV1U5cVNBRS9TSWp1?=
 =?utf-8?B?WXFyM3dJVUF2Ync2cFpJVXIyY1g5ZnJNaTdXR0UvUnFBdmFKcW9wSGJtWk1H?=
 =?utf-8?B?VlM1TVYwVXBneFRwcHl6ZFBqeGFyL3lmNHU4ektEOHRqK1RxeHd5SFByMWMy?=
 =?utf-8?B?L2tobWpHK1FqVEYvTi9zdUkraXl6NEd5QWorZTN1NERCcURtUDlFYnBLdmV0?=
 =?utf-8?B?LzRKdGdPckNnUTNnMlB6cm94NWw5R2kybWtBbld4b0thY0JmUmF4VUs4M1Ur?=
 =?utf-8?B?WlM2ZzRtR0lOU1h5anBoZFR1QjgrSlhZczAwZ0dFSGRSN0ppMHMxOHZaNWVU?=
 =?utf-8?B?eWJOTmJudDF1TmdvY21SLyttdkJoUEhxT3YvYTZtRjYrSDhkTUd0WnZVc0tm?=
 =?utf-8?B?SndKTzE3dHQwMEQxd2tZb05wTkpheEpKL0NEQnQ0RnpTaFlhMDhoVys0RHpZ?=
 =?utf-8?Q?tfGY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdac88bb-31e0-49e8-85ea-08dcb61268d5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:22:16.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsziRJ5MCIoUyvnlD/T/E+tM7//XuFSSGbivuJX0t+q3aUgO2N5Q70SzsN9/03W7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927

On 06/08/2024 1:13, Jakub Kicinski wrote:
> On Sun, 4 Aug 2024 09:08:50 +0300 Gal Pressman wrote:
>>>    The only question here is how to handle all the tricky IOCTL
>>>    legacy. "No change" maps trivially to attribute not present.
>>>    "reset" (indir_size = 0) probably needs to be a new NLA_FLAG?  
>>
>> FWIW, we have an incompatibility issue with the recent rxfh.input_xfrm
>> parameter.
>>
>> In ethtool_set_rxfh():
>> 	/* If either indir, hash key or function is valid, proceed further.
>> 	 * Must request at least one change: indir size, hash key, function
>> 	 * or input transformation.
>> 	 */
>> 	if ((rxfh.indir_size &&
>> 	     rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE &&
>> 	     rxfh.indir_size != dev_indir_size) ||
>> 	    (rxfh.key_size && (rxfh.key_size != dev_key_size)) ||
>> 	    (rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE &&
>> 	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&
>> 	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
>> 		return -EINVAL;
>>
>> When using a recent kernel with an old userspace ethtool,
>> rxfh.input_xfrm is treated as zero (which is different than
>> RXH_XFRM_NO_CHANGE) and passes the check, whereas the same command with
>> a recent userspace would result in an error.
>> This also makes it so old userspace always disables input_xfrm
>> unintentionally. I do not have any ideas on how to resolve this..
>>
>> Regardless, I believe this check is wrong as it prevents us from
>> creating RSS context with no parameters (i.e. 'ethtool -X eth0 context
>> new', as done in selftests), it works by mistake with old userspace.
>> I plan to submit a patch soon to skip this check in case of context
>> creation.
> 
> I guess we just need to throw "&& !create" into the condition?
> Sounds good! 

Yes.

> We should probably split the "actual invalid" from 
> the "nothing specified" checks.

And make the "no change" check return zero?

> 
> Also - curious what you'll put under Fixes, looks like a pretty 
> ancient bug :)

Maybe 84a1d9c48200 ("net: ethtool: extend RXNFC API to support RSS
spreading of filter matches")?

