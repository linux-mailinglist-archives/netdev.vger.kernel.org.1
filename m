Return-Path: <netdev+bounces-233645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC90C16C56
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3E3B356F5C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFB12BE7CC;
	Tue, 28 Oct 2025 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tFnZddMW"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431F29CB4D
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683271; cv=fail; b=cS9uebdiBeDQX5KqLsTLutCV1oROotgwju14VCYGnfvu4BBE1W8Ys3iB08qBTWN5ZeAfxCBJgW5PGjErmBm0Rqv/JJdXtxDL24jno0el/+TfYg+kduqRLQShOoEzShQkFjWrwm1TL8E0sbISD0nn4Lx250aI/Y2mjS9JkrrMGEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683271; c=relaxed/simple;
	bh=ayC9SIGTGtmCS7zmmQ6CfWf79Nq8RDF6VxE+fuZ54Qc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tdO0R+K6E4fcbh/rFEPPmtik+TExveFQAEVXpVAcW8J3pWsXsWyxuW0Um4JCyo/vlYXCcHq7V5/Y6gMSA1iGfaQWLtcybwAOMsc/APi0powTPstQtKqzTuYMAiuoDtJyQCmAlFf8iQ7GOcphdE8C8iEcZD0sPPB6gQcB1AF2A7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tFnZddMW; arc=fail smtp.client-ip=40.93.195.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcMRVP9u9yuhnJnx/WDHTIAYo0n21NrtBTHkTlTPheiOmOvJhiKTI+mrDhiuDNUVYcb/0ul+tL5pqhDedlRADJazOWMZRAxfio6uVq1ymc1A+7rXA+tAqb4XMrF8MISwNeniBuuE+0JJm52/BTiCgEHaeDpd+G6/IvddqRkPlUByN392hhCkRTZsK5qB/U0x1sPhbb/mzVicdZGKPWX347kISj2Ogw/sQKVRQTTKY8Zrv0jvmq0DzfyIWmOJ3uXLknmuqBSgR12sPp4MvgCBWk6JoS++kMF3ZYqJGcrw2qDU7DtEjx1ow7jaCWUhNrAMr40AfZkoVijUq0FrWdObDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayC9SIGTGtmCS7zmmQ6CfWf79Nq8RDF6VxE+fuZ54Qc=;
 b=NvKq8DiUHTgQ+KzHLjobyKMsA06XWNNFOvV8f6eWnA857MZWZ4rQqUede1M6gQYZKkx3bTbWO4bhhfRsp7aYHYIQzQ1xOGxjud5bH1qTH5MstGdWvuhbPHibLwlpqlOrzVEa94ssMnipPT/laqC6oK4lb4123ONDyl8owdUeH9Uvykba5i7EAkke5Eg1EX94R5U9IV2xlPjWW5TEJ2eShfyn8Np5csiH8oxapCw8VP2+9SvQl8PzGzwVoXvZmfbXPFe5jxVBLmzdjytNPya2Vl7uZpX2hwCgLyv8Je/fYA+c25PjrdFFQXZag0GrWShTepiXp13nWB6e+lfj14o7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayC9SIGTGtmCS7zmmQ6CfWf79Nq8RDF6VxE+fuZ54Qc=;
 b=tFnZddMWVRcPh5cR9xweV2T5YKwuzr+KnzrmJp4Mjmjd5tFIudgTE14QwUhrV6V9gauxXT3zaeMLAzvwANVOT50X8LqZU7z2OkpMH3vpNUvFNSpapQFPtCmU5MFwFXN92Wo0/TxnvHe017dDaKXJicBSr0dwXIrB7L6w8BJPBh9+1hDcQoGx5mzsmiDXKbvQVcd6qU/PTX+X0FIPh9JZSnL+HO9r4o4eE1HCgJ2fST0z/lY8M19dwcsZNHqcCYOYuIE6apSNzorZNSud1gS2WaCSUellXOYHWJ4Es68Wj/PIVixolwjR7GYd2Gq/LnTKgm+wKMFuEXURkHLeqjCUzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 20:27:46 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 20:27:46 +0000
Message-ID: <02b7f472-74c2-4510-97c7-499661b612bb@nvidia.com>
Date: Tue, 28 Oct 2025 22:27:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] net/mlx5: query_mcia_reg fail logging at debug
 severity
To: Matthew W Carlis <mattc@purestorage.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 ashishk@purestorage.com, msaggi@purestorage.com, adailey@purestorage.com
References: <20251028194011.39877-1-mattc@purestorage.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251028194011.39877-1-mattc@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 2059ba61-10fc-463f-f3eb-08de16607475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Lzk3VEk5T2lJdkUyeXhoUUdva0ovT1F2a2FRbkw4MTNFV1I2L1pGZk5UWFl3?=
 =?utf-8?B?N05IV1AxTG9NT0ZsZlR2Tkh3ZkFwa0UrWVViMlN4YWY3L3o3b3JuaUtNWlFB?=
 =?utf-8?B?VGJrZWNkRmxiL21JRWdPeEljdVhYOWRyMXQ4WERBS2VkZkVCSXpxZGFjVGRu?=
 =?utf-8?B?bExjbVA1ZDdOYTNXNVJMQVkzSEgrbGM2bUl3Y3B0cGpoRG5HOU1WZVBVRllS?=
 =?utf-8?B?M0M1Mkx1OUxmMXV2Nm9objNFQWU5MG9aaTZXMm1URVl3MjZyYmhkRlZxUmpx?=
 =?utf-8?B?akxWVVgwMXFOK3gzdDcwSHRYdS9mRlpwTkNNby9uSE56U215MU9wRldKS0Yr?=
 =?utf-8?B?cXRkZDdmMEFQcDdsSU1Dbkx3aTlXZXllRkZpczE4OHFBYmZQSWZYK1lSSGls?=
 =?utf-8?B?QUtpQXhuYU1YSW5Vdmh5MXZmNHZYSUIxRElZQnFtd25kdTByNlQzNy9JcXBD?=
 =?utf-8?B?WDNOQnhoTC8xaitTQkV2SXpyV2FvKzVmblhiVHpzSkRWVnVpTjhqbmZIdktR?=
 =?utf-8?B?YlJLUW9lSEd3WGhZWllFcGtvWWFoS0YydUh3ZnB1V2FRRWl1TU1ISTZ6UEtK?=
 =?utf-8?B?MlZuNmdQSFZWVkhvMTFBbFd6TjZzWGVrWUxUTDNyaTRhM0ZrOVphZVlSV1Z5?=
 =?utf-8?B?QWhxU1J5NWZIeE5rR2RnTWZSSUpHK1VYYnBEeTRLSGFvejlkN0t3QkhyY3Nq?=
 =?utf-8?B?RHQyY2lYZkQ4R2FmWHI4TkcwaHFPejF2L0ZTNnMrMGVHVmhWdTZLQVJ6eGIy?=
 =?utf-8?B?U2k2d01BQk1Kc2FuQXpST3BtVnVydEVNY2krOThJbmNlcmFyYmY3Z01zVjlY?=
 =?utf-8?B?MWFOV2dQQVhDZnhUSFZSM05Ubis3UjVjbExIZUFIdjNDTkRDQi9LRVplTDRL?=
 =?utf-8?B?YmhzU1pBTkR6RURLTlV2QndOQjdtUjhPWXd2MTRCcVNLTHljZGRuZzdDTEI0?=
 =?utf-8?B?d29RcGMySEYxUHFPRXpmRW4vYnJJQ1k2Q3lFbThEblpPck9oU09KNmlnY25j?=
 =?utf-8?B?SFNEL2xKbjJaQ2w3T3pvQnNIRDVmSnJkaVdkTzJvRGtxU0pnOVdVRTg1QXhT?=
 =?utf-8?B?Q1Vlc2Z3cml0RHFkR2svcThZcXRGbklGNkFmS0haQzZNR1JQYmdEenN1eURG?=
 =?utf-8?B?YzhuUWxOamRmNmpJaWtxZ0UyMEF6c09OU2d6c21ZSE5VYnFDMXFMNGNxcGpI?=
 =?utf-8?B?c2JNM0FuSWpOaE1LMkxxUG4rbFA0MHU2UlJUMU1VdGY1amRUWE9ITkJYTHFu?=
 =?utf-8?B?c2d3a1JVYlgrWnJkbVFMSUJuVVZoR1NtaGtKakNxY0hIRUE3Mnl1Q3ROTlJp?=
 =?utf-8?B?M0FPdVkzSmUrMUxoTFZ5TEJ6MmVkRDdQNVhUeFJ1S2cvNTE4UUg0UkZCdjVo?=
 =?utf-8?B?QVhTN2g5NUdWd2cvYWVJVW1mMXBCMWFzbnJFQWxSQ0k5Q1grZkFXQld0Si9i?=
 =?utf-8?B?aE5MRGpFWGdRcFNHMEczclpKSmtEbXdCclA1Tmg2NnpNc2x3YkhSNEJmMGd1?=
 =?utf-8?B?K2lSc0kvS1JEVFNDNFlReWM1KzNGS2ZrSEtCeXdoYWFubE9VaGNMejdxVklR?=
 =?utf-8?B?MHR1My9qejZJSk40OCtsZHBSU3V3d3Y5MnpCaDlFUmd4VW40eUJ5WVVKYStm?=
 =?utf-8?B?Z3BEQ3MwVzBEK2Q0bUxHcjRxOUJVTHgyODVRTUM3TGJuMXdZUFk5RGZZeWJj?=
 =?utf-8?B?SW5mQ1krMTh4ZVVURmpHSDlkN25XQmNMTnYyWWFodmlnRHZkajEyTEYwU0VU?=
 =?utf-8?B?Sll0b1duOGVaVzRIemttSUx2ZFFJRUtsYXdQbVMxMktiYVZMSEpSS1FnT3Rn?=
 =?utf-8?B?Y29WaEZNTWpnV2pvbjl3TEQ2QWZ4VGd4M3JyWDlOd2ZvazExZ0ZkanpCWVRo?=
 =?utf-8?B?TXZOSmtuVUo2VUhTMXdkOStQY1pCYXlhVW0rN3pZQ3VUZGpMVEk5S0FXSHNF?=
 =?utf-8?Q?YRxaZJsnGRQ4mfYHlyQJTHDu2wAM39d4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHZxVVV4bStGQ1dIMnR2Rmo3UDYzNmRLTUxvZ1RCbTlmY2tmTlNoZGRUUkZ4?=
 =?utf-8?B?TlBYY0V4T2VaNXFRdit5aGtrNENyeGlqMC96dG8yeWFranl0d29KenN2NSti?=
 =?utf-8?B?M081L3BKZWZjMTFCNGVkNmJVR0NldW4wSVprb0lHbU1EdCtJV3E3TVBlVVRx?=
 =?utf-8?B?empmYkxoUWkzMVV2TE5seTlHN3EwWS9vOVY0NWY5NllLSGNCS1RySXJpeHRq?=
 =?utf-8?B?bFkzSEFZZjJnZGRZRGZOU01GVGdXNGx0VU5sekl4L1hEeC92cGRiK2NqWnNO?=
 =?utf-8?B?aURZb2hlcWhiNXVtTHVWY1NzRE5nTnM3a2wvM2F1ZzFrTzl2NG1LY0Y4amZx?=
 =?utf-8?B?Y1NmS0JVYi9rYml5VnlnUmZTQ3NXUWFXbHlTbS94Wm9FTU5tU2xNZzdOMnlY?=
 =?utf-8?B?Y3M0QlhHR0thQ3FiaWNFWU9BcGYzRUdhSG1kaGVzVHM2dmN3V251dmtiUFNh?=
 =?utf-8?B?ZWlXOWc4TE53R05uc0VqYTNSWDl6dnpxRHQ5V1hsZlVIdy9CUFloZVVzV3pi?=
 =?utf-8?B?V1hPbituOG5wZ3hza2NHRlJoZmtWL2lXcG9oYm1KeFdmMkhGc3NzNmRWWmV4?=
 =?utf-8?B?LzVBaVkyMzZoOW0vbzltUGtsSGpNMmhCM0pHMkR0cGlCbFRaY0RZZmlsaVJI?=
 =?utf-8?B?YU5OQWVzY09rMm0yMGVoY2RUbDcxVXQ2Yml3MzhsSlFFR0QyVUlySTEvd1pw?=
 =?utf-8?B?MVc3bGdzWXUwZU9hazZ4K3JwOEgwQmdLeWNUQTBMSjlFLzYvY3h5Y2hMT0xh?=
 =?utf-8?B?bGVoV2JaWWRiR2hHNkZNQVVTKytQSlFMTTB1bEFhbS9BQURRbXN1a2ZYSDhz?=
 =?utf-8?B?ZC81Wms4RFJMTEx2d0lpM3Zjc2o4bkRLRjZmR0MxUzRDUkRSQW5FUXE0aXhs?=
 =?utf-8?B?VjVGK2NDcDN6dTVIUExUTjU0WWlmZnJlbkRFTUYxNkVQQW41SGV2RzlCK0hF?=
 =?utf-8?B?djBucXZzT2lLT3ZMUzIxSlF5Q0RPcVByZUNpamFNUHNBK0lZQUtuQkJKcXRV?=
 =?utf-8?B?L2NrVzFzM0N0TGJ4NkFoclhHMXhmMGwrekQ3Ums2R01XcnJjazI0L0JpcWNB?=
 =?utf-8?B?MTllRGZPN0psVlBxZmZEc1QxeG5vOGY1NEpGemFKL2l6NlBRV2hLdktxODBr?=
 =?utf-8?B?eFVDckw0WTBQbWlhaEhHVGt5dXZ4S1pRcHprV0FnVkpEeHdXU0szT0h1VkZD?=
 =?utf-8?B?eWNjVkk1Tm80aTk3U09rdGowNjJ4TGlGbHhGb1I5TzBFYksvK0pZN1NoWFIx?=
 =?utf-8?B?eHdWVGtYUitRY1pIQW04WWt3ZFh6TEZQblZpNGI4akZlUTVzSkMwSW5vNk1i?=
 =?utf-8?B?L2E3LzMrRkMxbU16WVlrcU1RWE5QcWQ4MHFFY0taTWRyWG9pakhTM3M2MENP?=
 =?utf-8?B?WXpqV1FvMjI0YndKdC9lMk5QQTc2d3RrMnBPdWoydDdXdStHVUVWOHBrSlpp?=
 =?utf-8?B?QmVtSmdCQUdFUmdRMHNhanVNL1NpaTAwSVVWWjBuS09VeVZrRG1OSVNvc1hC?=
 =?utf-8?B?U2NOb25wdi9tbmd5UGF0eFB4RG00Vkp1SVcrTlpoM3krMHhKSjdaajZqTUxI?=
 =?utf-8?B?SU53NWd2ZXplWW5pQVgyMEZLYkh2dzFERWh1dkJJRDRzNGtwNFU5bGVJd1l6?=
 =?utf-8?B?akVabmV2dEFic0trZTh3blkvZk9jS0hndDY3MjZ5dEIrdjZZREdoTWxxRDA5?=
 =?utf-8?B?UVJjVzBnMTFpYzV1WWZDTFFHWkZvMzFzRmNWdm0zTDZFWFY0NTd2OGN1UVJi?=
 =?utf-8?B?NXZHQlRVWXRsdTdzVllnVm1rK1ZsZWp1Q2tvWFZhb01WM0JVaTVUVVpud3l5?=
 =?utf-8?B?aWNWb3lncGJON0s3bUNNTUoyVHdlRHVkUk1CYnhKVlpJNnBhNVFKS281b2pX?=
 =?utf-8?B?MnpjZC9RL1J6SjZEQkwvR1JibXpSNWFFMEFvQ2NpZ1RjcnpBYXFldjU4aExn?=
 =?utf-8?B?QkEzWWYvek83cWFPSTJDWDNoN2RqRVp2ckpUWDRSK0pTaU5ZM3dpVUR6S2xS?=
 =?utf-8?B?aENUSDFySFZqM3B6UjJGTi90NzB0ZFlwVFh3c3pRQnRtdUdoUmRDL3Rlc3pK?=
 =?utf-8?B?bU4xeFZWT2c2cWtVd001dDVLcXFFeWJ1T29ibFAvS25Hb2tscGU5bDkxN2xi?=
 =?utf-8?Q?shzq1hAWEH6ddlB3IqcxmkIa4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2059ba61-10fc-463f-f3eb-08de16607475
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:27:46.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyGRXD2Srk+Gayk8g63STxzufIKU5s7FxFHaiMdtlHWeJg/fmlMeBesHWRaj5qwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821

On 28/10/2025 21:40, Matthew W Carlis wrote:
> The commit message pretty much has most of my thoughts on this one. We
> see this message generated all the time because users are trying to
> determine if there is an SFP module installed in a port or when trying
> to get module info from a port that doesn't have an SFP module. This
> is not really an error at all

It is an error, as evident by the fact that you only changed the log
level, not the error return value.
We cannot query the module EEPROM if there's no module to query.

> & therefore the message is undesirable.

Arguable.
This is a privileged command, and error messages are intended for
errors. It's important to have the value of the status field in the logs
in case of an error.

