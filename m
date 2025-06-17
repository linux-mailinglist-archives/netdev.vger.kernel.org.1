Return-Path: <netdev+bounces-198455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A8EADC3DF
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DB03B87CF
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A80128ECF5;
	Tue, 17 Jun 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DjnPu7+f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6A28F519
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147212; cv=fail; b=KyH0YTOC+2tJClsvSEY60yU5qycdhFWfkn0vEwcMp1FGyh70P2ETFytSJO5ditKU1Su852667fR8cllE7lGf/yI0neAWEMxPNjGtZ01K4jxxlnggChepfZO5NAqpMO7Rk8A04SPRhNfDaFma22pU9a+qXiGpPVRZ5PyscAx/OmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147212; c=relaxed/simple;
	bh=fUi59uBacuEWzwb707MIvvx02NxPIJKX8QMGcLZCBbU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ighibzi8fhhxSVWk2EthMmyyFYo5PHgI7fYOOykaYguxtamMukRc1SPrnUBE/wvILuo68J13T0ldpeF8oeh7FM0QVO2WvHldWG/AspjgcIMf1qdVBC11qj2ANL1Pfbj8jafqBgnosPHcDVNTaxKat1EHL6VBip6MsduDinPZzgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DjnPu7+f; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS2w6LXePPc6MAewE1aHX8dmipLsJ/+FCBc+aVxxb5Mmps2huOxJGhLtCj8EM+d1DXwk43H+fesKiWyjxahDT+5Cyh4lq204WWRG0/OsysU477COG5RUy8ogwB+1FaOwgxa7q4YJ3SLGicv41yiJ3DDPwOHDu3z7bZB+3dlAu6vkcJHXh/sHf49D2FkoG6YlEptpPPr20DACLeVoHg5NqWuvQlueQ6plO7dh7w/aps8Z+pStVEY+MwnTWlfR8zTod99OAOAT5RI5eJifFh/rLXDjPU6d7LVrdxyrzhPFWpTSvVQ5uySFcwagur2XLqSu/joB7znTsSTJiIRY44j/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUi59uBacuEWzwb707MIvvx02NxPIJKX8QMGcLZCBbU=;
 b=p9Im3LLUkglu9akU3m8/6RuiLxkwDxVYJHOHomOoKd5EPxtR5yXiALhMVGErUlOq/nRgkkUO3duqh8Pi9yD0BxrHHpzl1+pt6OSjS64cyxgfbeHfeRxjoE2Ds5i31RFBkStVwSF07NdejcmU8EmNXQwvsoz6Awfy8wYe7WGvC0ry6eFQK4I1CoVUjeOYXb6K+7s2Qcl8iJWfApYzu7d2NFkTBO2+9/mzuc2vxKIitBnYF3A84YZXvjmyhHRozN+8MfdUSK3f+xXAdXzDX7XDUZqMFJ3RovThUGyw0/j2oWVdVu7hGg6xRG2BiMLHQW+mOV5ddVMGbOdBuv0Cv045tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUi59uBacuEWzwb707MIvvx02NxPIJKX8QMGcLZCBbU=;
 b=DjnPu7+fWm5EpMBlHvmuqITcDO1mQui1IbJVNoSuawZH63PuPUEB1OwxU0iXqXtw61miCwp6feeIRZi6D49l66rfyJQI8cGeD48xhDEe2guALeAaDfNjTNHW5ks6rgbWZQ7sgLGSiIwCcLi1glVOhnVXjYC4shqKLqEVo0tlt04l1j3Toi31OEifhcRpSjFCeiS5op/lPU59rezBaDPkgAqnP4PQ2a7ObTeV6MNgVbqn0dE79A8RdkEzTuwUJ9TMteVEA+9ye2s4oYa1FagxnlS1ph3z7Erf5khQxK4VKm6H1AUwgj1kwFEwbv9Nz9w+a46V7oRtznQGVE5nUB0y0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by BN7PPF683A477A9.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 08:00:08 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 08:00:07 +0000
Message-ID: <16f6d38d-5ee3-4b0d-a81a-5989ce599114@nvidia.com>
Date: Tue, 17 Jun 2025 11:00:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] openvswitch: Allocate struct ovs_pcpu_storage
 dynamically
To: Jakub Kicinski <kuba@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 "David S. Miller" <davem@davemloft.net>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Ilya Maximets <i.maximets@ovn.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20250613123629.-XSoQTCu@linutronix.de>
 <20250616150902.330c4ac3@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250616150902.330c4ac3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|BN7PPF683A477A9:EE_
X-MS-Office365-Filtering-Correlation-Id: aff07cd8-451c-4843-12b0-08ddad74f9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmpvTTdDdk5nbkZ3alpnV2pON1VVbVpqNjZPK1N1d1pPNEp1cjVVa0hWQ2Z6?=
 =?utf-8?B?aUtvd3IrQnRPSWlJK3pvMTYrbVRHM3lnam9pV0RyanNOR05xcDN0dGd5RlNj?=
 =?utf-8?B?YStEOTFlRlBCd3p3cGJLTjlSUjJ2bmMzTEF2cU1abkVhK1VRRWVtU1U2WkNj?=
 =?utf-8?B?MzQ2Y0lXNHFyWitCTVlPK0Y0TWsyQklwM3F0bHVUdzNvOVZlTTNtWmMxMmY2?=
 =?utf-8?B?T0VjQkJHaWJWcko0em9Ic3ZMU0VUNGdtUUZDeithdWtlTUp5VnhXcUZRTkRO?=
 =?utf-8?B?Tkg2WGtxR3pvSFVmOHhmK2JFL2tlT0RUSTJlaHcraDM0WURWSTBuY0FXYXJ3?=
 =?utf-8?B?OTJ3eWlVZnBtYnlXUVluVjlzQW1EU2tpWVU4SW8xWkJpZVJ0bytGSFdaSUVm?=
 =?utf-8?B?c2xLanZHS3pJUDVBSVFyL2g4TythZ0xKZzY2U2Z1UGpIU2E3UXVzUjBFUlNB?=
 =?utf-8?B?eHBHRlBJZjlsZi8wQlgyK0Ridk80eW9lTmtWcUMyU0l2c2VyamFsVEJya1FW?=
 =?utf-8?B?MUsyaWFsQmxXQlVlRHVOWVhuSzZWcHZUUGlNMWRDdDllQ3VoSTRFb0VnQ0lv?=
 =?utf-8?B?WmJJSVZrZkk4bVg2Q0lIU1d1Q3ErcUd4R3VmNmtzRC9zOTErUnB4bTdFUndw?=
 =?utf-8?B?c3BKbHZza0hqdWNxNDY1SnpDdDVqbjdZbWM1THg2U2lneG0xc0t4OEhaTERL?=
 =?utf-8?B?ei9UeEZWelg1dkxGRHZ2MmhTU3M2aXhaazVHeXhzeU1meTV6SFhtbG05a3I4?=
 =?utf-8?B?c0tpbUhwWlV1ckR2bWRYM3ovR2d2T0JxcFpMMHF6S0VteVlKTkMrL25OTm1o?=
 =?utf-8?B?NHVhUHJRTTY5akt1a0lVVEdhaGt1c2dGVEV0eTJBOTE4NFQvWVpMdm1MRHlK?=
 =?utf-8?B?eFNpVm5tREY5azlhRkJWMnRDMUJjNmg0TS81YkR5K2NTVWdwejdIOW9yVTlG?=
 =?utf-8?B?bXZ4VjhEK2JreFJJU0M2bngzNmdEK1BNN2xTSVZ6TTE4NnNlK3haaWY2Q0JM?=
 =?utf-8?B?VkhVcSs5NkhybEtEcDlSSGlDTStCVHBGQ2paN295RGNKY0FJTlpOclloTW1O?=
 =?utf-8?B?Y1ZmZ0xxekt4L1B2dmhHUERnMGVNSUYxQnBCdE5vbzdSWHE5Y1JVNlB6MEx5?=
 =?utf-8?B?Z3NacGlxeUhvOU1PZHlyZTZrdlNnazdueE16clVIZjhFY250ZkZlK0JLYTkv?=
 =?utf-8?B?Vk1lb01heWtqdTdMTW44Yk1tSWMvekRmNExXckFXbHRScU9WZHlxN1R3MkQ0?=
 =?utf-8?B?VHo0ZUxMYkd0QlFBK1JzQWZ4b3RnaEhOVk1va0pGbjdJaVlJbHRnRkFiZFRj?=
 =?utf-8?B?OFZpVUNoSlp1U2c3eTJYK0pZY1NxU0ZVSlJpcDkvZ3QzcjlsWlE5dm5sWHlz?=
 =?utf-8?B?U1l1SFN6cUhFbk4zbStXN3RxcU5zLzBrU1FaRk5TZHNBQm9RRUk1WnhjNnZL?=
 =?utf-8?B?V1Arb3ROSjY3QWp3SUloVFhGeXFCK3hDWmxGRVk5MEs0U1JlMzI4NlhLUkJI?=
 =?utf-8?B?c0xPOUNkRDJPNmFTcDZYWk1zNENZZzJBRTAzdjltNW41QnlXSlRvTmJ4eFpr?=
 =?utf-8?B?d3BzeE1Nd1RsYkhJNGZTTWU0bUdMSVp6Z0l3NGVKbFo5OVNzSXNIYS8ycm43?=
 =?utf-8?B?cTdyaFk4Z1hmN0lMV1VOVnhNOWJwc2NHYnk0QzJGNG5FZ0JQRWJRZXBZQUM0?=
 =?utf-8?B?REJRTS9nczBqSzBZbkR6SXZLMFZSL3BsWkwvN3A2MnQxZE9RTHg2ZXpoYjBU?=
 =?utf-8?B?cE5nMDRZTjNjL0ViL1gxWXpkMUxIM2dnZXZhSmsxbEpubXNQZnQ5SFg5MjNa?=
 =?utf-8?B?Z3hiYlpnMDRnZmlWdmliNFJyODhoUGtwTDJWang4SnhwTVVFY083ZzJrRWE1?=
 =?utf-8?B?dXRGR3dDY25DR0FDMTdtWVJSak4vbDF5ekxWeEtHbU5pdmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mi9GRFlwUGtVdS9GNldQbTREc2tlMTE0Tm1JYnVmTlpvSk9JZGZWWVpyQ3R3?=
 =?utf-8?B?cEhsOWF5UjUzZEJ0N2ptTFZIS0VlVGg4R1REMjRGcmhaK2N3cFdoakhLa3J5?=
 =?utf-8?B?cDR3dmRGNHl5TXpNdG80RVlCU1F4Q0dZVEt1V3BVQWVKNEtCNDZURHVjS3lQ?=
 =?utf-8?B?dVg1UVRLYzZhR2kzblVReUw4b1NNRTVNZnU4TUUxUS93akJnZXNlL3lyMWtl?=
 =?utf-8?B?RFl2Q24vaW9VcmxCSnp4WmYwa3ovQ0MyQ0V5OWtDZU9MeENsd1NSSVZGVjNs?=
 =?utf-8?B?VkQzRUdBaGxXMGVkNzVJcVFzMmkrdlo3c2ZWRkNOYVVRWmhWQVRSY1J3SUt6?=
 =?utf-8?B?ckdTSEFORmc0OWdVazJ4ek5UdS9Jd2ZENXFRdXdKb3Y5VnhkYm5UTWFqdENv?=
 =?utf-8?B?cldJQ2dJZEZZUGJYU1VjaXRwUjB0b2lNSEhwSWtyeVJKQm5QdXd2K0dKMkVh?=
 =?utf-8?B?RTBXa0lSVjFwREs3NHJxdzBHRTFTL2ZXZHFoeHdLNkswSFFiUEM0WjRxRjRT?=
 =?utf-8?B?MSt5Z3duTVNzWlNyTmY0VkZFam1kb0tUalZRVlNkN0lsM0xFWS82MEF0TEhK?=
 =?utf-8?B?OTludU9LNEV3TEFxQXpKZC9TcE5uSXc5MVcxSXJBVWdEeG9XNGlYdWpRb1N0?=
 =?utf-8?B?RHBvK0FGK1NyZ2FyTFgrVjVwUk9rRFdhd3JMSmR1SVFzWFg1QmpYQUs0S1Zl?=
 =?utf-8?B?U2ZLbTBnTWhUN1JnYlBORGxtKytlSUpTQnZ0RzFBaGxISHhrRnNMa3gyL2pI?=
 =?utf-8?B?MTY3azZlYm4wL01SUnVaVitmRXRrUG5RRDU1ako1OHFwcDBYVjJqZUdLT2o0?=
 =?utf-8?B?R3kyVTU4MEpyYXFIRnpNZjlsVFNsdFkyWFNab3FxOGhYUEc2WTYzWTlMT2hG?=
 =?utf-8?B?L1p4dnkrV0kvdVJWa2piZG16eUtaTmNjTzBxK0Naek5ZdUVGN3dkMGV0OHpT?=
 =?utf-8?B?ZGVUT3ZtVW85UENTSXdrSmNZa3dBSVVwdGduakRWMlJzRjc0UWdkM2pjU0Nz?=
 =?utf-8?B?MSt5YVp2eXVzNnE4N1FQd3JKWnBuUlBIRTU3b0tIajFlaXp4dkNLRXZOc1VJ?=
 =?utf-8?B?UGphdzYxQ3pUOWlMbWFHSDAyc1h1ak9iYmpucXRXckE1VTk3M0U2QzBVZWlS?=
 =?utf-8?B?MFo0WU4xZTRCa29tLzNOOVBWK3pMTElXUWQzc0gzWWNUdnZoZERIRGRKUExS?=
 =?utf-8?B?K05BV0phcnB3QjJCQmVSTlB3amdpd3UyMmRmbEdjYXQ3ZlpJbU5DbmgxaHB4?=
 =?utf-8?B?S3ZyUy9IY2pNM1VWdnpONXMrM3dmT0FzQkxSMmM1NzFPUTMzZ1FPL0RZbEc5?=
 =?utf-8?B?emd6Z2VxQVdOR2J4YVpzU0FPZ2NOU0lNMGF1bFB5MzB5OHJldm9BZkt1QkxZ?=
 =?utf-8?B?cEp5cDJpaWhGUjFBbzBYT3ZJYms1a21aVHV2V2hUQXZUTWxIRVNhdTIzMlVN?=
 =?utf-8?B?WnUzdHhpUWtERUpadEhqdTNGcHBIOVRnYUhDdW55UHB3Q09vNnZCSDBSMDBK?=
 =?utf-8?B?dUVzMWVDK3ZjaG16bkZReTE3bHV4ZmtmSU1xWUwvcDRMZ0V5YkZhV2phaDZF?=
 =?utf-8?B?TkhoTGxpbEo3RFBkSXRMWGJ6c2ZiTEM2VkhWdnVSL28wLzQzQWVOVVFZaGFw?=
 =?utf-8?B?TUJZZUllOE4rZDJuNUQyUjZUNG9uNkhFNVlwYnpWLzh6cTFRK1B3Z1FieXlo?=
 =?utf-8?B?YW5PSXYzcTlnRnpBSkdNVWNmdjdzS0VtcWU4UFZ2UzhHOVdkeHBFSEtndWRC?=
 =?utf-8?B?TFFZS0JvQnc5T2pyT1JEME5mSnhYcTJISkJ4NkphcFpDM05LN0I3RHVpOWwz?=
 =?utf-8?B?UWNNWHdjQWUrZHVteEdHTG9VV21xWitBUEs4VjN6eWVZeDMrUStNY05Uclcz?=
 =?utf-8?B?b3FsVEg2a3JTQndRNUdWQjNGbDhBcURzY2w2bEt3VlE1RmpNOFNEbVBlbkFi?=
 =?utf-8?B?aDFTQVluRngwTFRqTDErU2IzT1F1VzdIWkdSbkpNcnF1VXorWmRsVmg4OHpM?=
 =?utf-8?B?bmZpclBHUS9zSW1hWTVSRU5Pc3NmOUJ5MTNGL3RYRWYvVlhSNExvclJiMm52?=
 =?utf-8?B?UnRVMDZPR29OQ3l3cHpqYXhqNUJQbmN5MDR6L0gzMXpvU0tHNjhRTmdMRHky?=
 =?utf-8?Q?4O9k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff07cd8-451c-4843-12b0-08ddad74f9c4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:00:07.8281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRKFxjRBuHVIF1k7sPq7Aleaevj//vQ6rGNkcAR1+VHMsGlG8BCyTr3gdWWf5moV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF683A477A9

On 17/06/2025 1:09, Jakub Kicinski wrote:
> Gal, should we wait for your testing or apply?

Unfortunately, I don't have a way to manually test this at the moment
due to limited availability these days, I will only be able to report
back once it's applied, sorry :\.

