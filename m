Return-Path: <netdev+bounces-112630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E363093A409
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127651C225AB
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467A153BF0;
	Tue, 23 Jul 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RjfhrFPl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE1813B599
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750017; cv=fail; b=mOHv9lA8ql6xmrQ/1fui0wM0MZ6JZYBLl4ve70bRQxdpFQFFm1stne2G2/FTVWtKV3r6gWlVVhxCkMccF1Png86aiDaUd5EKRoHCS7bG8aYRgQcmKK8wEqEJeDDtwQvJ5VSbh6EpLHh74AyG220F15BCV1LFKYwtI9kCzCuehtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750017; c=relaxed/simple;
	bh=1z6yaEakzQuOfeZLiPgusHWTH6WMKz6anqnnlPyx/M8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dvq+Fc3yCi0LmeTBz7bogja1pEnqJ33Z+vqUFGdRihIJp3Jg2K1ymvPW+LHgYmPMA+pqKRYKb885+gcQvpzitx66oVevAMJSxhZ/evyNVJYkF04nU5whnP318IfSbUsa9bQ8jGHm5p9dB2139qlQN4sjTcOVMjHF3FyENCLorG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RjfhrFPl; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqSmIiRRkNSxXTZa8wZ6MdzCxx0FLEOu9KLNmb22/WZyNnAA9B38U5XcW4yaEwzcomP2qdJ2piCy2Szw95roAPIzrLuyWaxJKwEfnfFfvvBrJKx3IzEezc27+YHcZu7z6Tyl5o9Ai/jzbruVfXAl/An1gBjVVX+eWYU/hGpC9q3AJMYLLGk2KyeNt1Mky4m6gv9oJOz1uGQ8qtsffkUjMQ2WX86s3wScdA9AOO52zoJBB9/XDLcA8M1WN7rrxzS4WJhND63KUlCoQTsdGgmHPzX+fDMS2VYozGS7xP/obEJvEzkO1cFb1HQ8vPiQY9WpVznlI09NTo2Dbr9f4yOSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi8EdpaYaPi7O7SwgcYBDssXORgvDBoVqefAGm1WvrA=;
 b=wjaAba0QE2whRCzLLFnDLjcBmeX5ukfCacfH0YBGfcDoV0BCziPc4EFxCK+h015Wp1Dmd2Pc0BqNqgZzl7cL8AOuFLCubjkjvlIFKprp625acK90/iIHIjLwOHoAwqORTIWJlwL3DQZVaoHr6vVAnzplr5rERHqfqv+1gYkMuRnnM9tV4kXTrR7xmo6lOJtFYiedYWeqve9MZAkfRXqpOrwG9Re+JMOhmwQv75MiXchtvvoFhwuym5bjR7CPAXwLKCN/MkqFdn6dc3lq3qoIn52NbcrP74QQ5q54Hnfp2VSwzkHmXdnI4UVEh+C0zzkikrtuehSRResfT+6rsTl6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi8EdpaYaPi7O7SwgcYBDssXORgvDBoVqefAGm1WvrA=;
 b=RjfhrFPlr7FcBuRBbBX7e2enoSTKkQlHOLyHybFvqCJmWm2W+GFL0hLCiHSOfSRUUdzArvghUWUhqukoXzDR3nkjvInSMJahZx8s8TMiv+xKUCgnmw1c5dyjF46cxAikrvG6Ro1c4NNLJdEPnduWVKuK5qrNG/xCUBt6gbrbXXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 15:53:32 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%4]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 15:53:32 +0000
Message-ID: <3f8aef95-e7f8-4c47-9b19-a2ba90c4a532@amd.com>
Date: Tue, 23 Jul 2024 08:53:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2] igc: Get rid of spurious interrupts
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20240611-igc_irq-v2-1-c63e413c45c4@linutronix.de>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240611-igc_irq-v2-1-c63e413c45c4@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::44) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: b31a3ab4-9ff8-49ed-174c-08dcab2f9a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXVDS2xDM2dIUld0K0ttU2wzNE5YbjVEY21RcWlWRDZTSjlCSGRLM2ZuMi9H?=
 =?utf-8?B?cVh1bDI2bzRyZnRZTnJ4OW5Oa2pIbE91akU0cm1ia0x2LzRKODFpWDZidXBU?=
 =?utf-8?B?SHRxYWI2aG9jenhCR1VMLzl6OU1QNVNiYUppZHE1cFJpM1ovUzZZK3UrUS9u?=
 =?utf-8?B?bUJLOTRkRnBSSlJCZ2N3dVNzTlR4cThxRVZhVStWZnNlQ1czbDZHaTlZM3pC?=
 =?utf-8?B?Y1VlU25pOTVNZ1Zta2JPNEVlTDI3cUhWT0NCUnNlTkFTbkp5eFo5YTdWMkY0?=
 =?utf-8?B?bzRuM0ZzbUp5ZWxqaU1IRlFxN3k4SURwcDJlVzZoNkhJMVJEa0ZBRGk0dGFP?=
 =?utf-8?B?R0dOYWpOYlpGNHZ6QWs4WFV0WFE4MkowUGszNHJwb3Q5RU9aRkFMZTZMeC9n?=
 =?utf-8?B?R1VMMkdQNHd1aVFGZzNIclNqU2JJUFM0eHhUTjVoa0NNY25nZkVYM3BScUNQ?=
 =?utf-8?B?ODBWNVhDZmxhdVd1OHVZdFRldUhRR1hwWitFYUlLRnRZaWZPN0VRalVHL1Uy?=
 =?utf-8?B?bXJEdUNvdzZsb1BtOFVzblVKMTZIaWZMOUxQTVMyTFVXU0wvQXZOZ0V1Z0Fz?=
 =?utf-8?B?MWptejF2NDNLQ2JDZUVOdk0rZGhWUHhwMW4vYlZlY1J4RHlWYWVHYU5Ud1R1?=
 =?utf-8?B?TzhXSm1KQmMrOFRUb3l3c1h1c0V3SHRRSnRsVHVYVWI1QmxrSG0xcmo0bGY3?=
 =?utf-8?B?L3JjTkFIN1pwVWhMTEpLZzNjOEltTnU3TXJ1OFd6NjZ5YUVNSk1IZ0ZVeVFk?=
 =?utf-8?B?b2xiWEZINWM2SkcvYk9zS2RnUlFibytiV1VyZHZvNC9iR3pxY3hkQU02d21y?=
 =?utf-8?B?MmNkNGg0L3R6U1BrRGNiWURKb2tvK0RXL3J5RHRYdnJtM3N1YUxnSjBQQXpN?=
 =?utf-8?B?V2VQN3k3aEppMXRLZVdiZUlwd0RCT1p6Mm9UWVA2WUFQcCtDOW1GdjhzN2dp?=
 =?utf-8?B?Z3VZamwxRmpad2ovbUY5QWpMbm9zdGtjY2YrRjhHVFgzRXEyOWZ4RnpCeWM2?=
 =?utf-8?B?cUI3QVNBZkFGSUpXNnE1aWxhK2crcUR4cWF3T3NiUkpGRk83MUdqSk9nTXlN?=
 =?utf-8?B?Rlc2b0xKMDlYNGx6V0VYVXdGcW8wMHhkUENPWElzTnB0Nk90T0cvaWJqb1NU?=
 =?utf-8?B?c1FaVkZlUXV4TnliQ0FyZFBnRUJPK242SHBxeEdaU0k4TWV0OXhIaDZpZ3Rh?=
 =?utf-8?B?SUsxUVAzU1JtbWUrMVZFVWgxck1HL3lHQmdYdUg1L2ZhUWJYOW9Mcnd5VGRu?=
 =?utf-8?B?SHYrUHl4NGg0dmkzTUlsTXprM2R4OVBYL29IVTg5TWJrNHpLRmFvRStINXZE?=
 =?utf-8?B?T1hZbUFlWWNMdHptWHlLLzBCR0FzMHEybVVpWUVmT2hiVFJKWU5IelBpQWhT?=
 =?utf-8?B?Z3lsNzZEMDZjY1M2T1hrakpPbTR1NWdpZXlTNm1rM3ZBbHVzUXMvYkhwVlJC?=
 =?utf-8?B?K1pySXBRYm9xTCtyU3ZlcFMzaFhzL3J4OUg2WUtnVnUxT3FlRnA3WVpRMnV0?=
 =?utf-8?B?L3R4ZmNQSDY0NlNmNlVIM2x3cHZzUmlNQnN2djQzdmdRMk9Jd1Q1QmpNME9H?=
 =?utf-8?B?QTVUQnRBcmxYRHRTZ3RHZmJEV0ovNjRabjBrS3pFOWV0ZkFyM0xWQUp5WVhi?=
 =?utf-8?B?MFduZ1EycDdDb3p6c3g0Wi9acnpYczU0NytFZzRwc3AwMGxqTnVGeXhGUVN3?=
 =?utf-8?B?VW4yMExkVkRGZ0VQVG5kdmhkVG1EUzhmNDRoNmVlWUFCeWFoSUh3Rk9veGNa?=
 =?utf-8?Q?APX3AP5/QhjRcugsYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTdBNlArTHlBTk5za0dlQlJpaHpPbThqSUwrc3J5T0xnNGNwakFFam5NN0dX?=
 =?utf-8?B?Z1FlU0daclhSd1FPbGJxaUhnZzBRaHZma3RHbjR4U2JLbFFKVkRlZDhuYVVL?=
 =?utf-8?B?NTUxTEM5NDErK1JTWlRsV3p5UUM2K0x6UkU3RlIrYnFWd0V0RDZEOUkyaHRz?=
 =?utf-8?B?L09MNXBEZFNkU1JhMEEwRzJhQzErRjJzSDZpcnpmRVFDcG55andNTmZCNGcz?=
 =?utf-8?B?dm1PYkpYMUhXdmF6ZEdpWDFzMDdvYklOM1RGZGFqMHhOSjU5ei9pMEtQQlFu?=
 =?utf-8?B?NnpCUVp0ejd1dmJFYTdUUFJrMVQ2cFhFTTYxWGQwSEMySHdqT0t3WjYwZUJW?=
 =?utf-8?B?cTBFNXhwdTZ5cjhicG5GTDJjRlNsYjVySFBPbVYzYk9LektzWWNDVzJnV1hK?=
 =?utf-8?B?ZmVhTmgwbFQ5Wms0NHlaRWZQRFVucWU5SWhqcU8vMXdHRTFSdzlONDYxQlRa?=
 =?utf-8?B?bmFwbjFMbEtpdjJZTGM5RytIcE4vTTN4eGVMbldXbzhyZUpTeTBBOFRMTHFi?=
 =?utf-8?B?cWJRMTYwVW9CeTdIQUg5T0tROEROYS9lY1R0S0NVdk0vWk05UGRoNXYwUll3?=
 =?utf-8?B?eUdQQVR4WEF4cHJHWWdhZXpwVnRPZDhnNko1Y2NkN0VrYnZFMzhvbERIMnlZ?=
 =?utf-8?B?LzR4YmVrQk1CMzNvU2xzbFBUSWxRcUdaWEgvcC9VbTJ0b3crV3NEN3JBbHdi?=
 =?utf-8?B?ekN3YTRjTy9PY3pVeGp0dUpYajZTYmhNbHlkTk1FdnZWUlZZSFRPKzZhSjJU?=
 =?utf-8?B?Q0xZbktBUFg0SnZIaktsOEs0RXhLNTIrOTNVVUxZa2twbHFtMEdXNUtDVGdj?=
 =?utf-8?B?RW9nL0FnUU5KbW1NMHVEb3RlUTBpVWxNQVUxYitwSHR0OC90K2J4YzNHbWZO?=
 =?utf-8?B?cmQ0c2Y1MWg1RUFzRDZoU3hZdysrNDh1VVZpWXlyUkYxeEREUDJrbG5xZkh3?=
 =?utf-8?B?V1BjdVdKNlhmTmFhUVc4OUVndTZJc29zUm44QU1La2xZZDF1ZkFXVmlDazZZ?=
 =?utf-8?B?ZDJsWERHbFlkUXI2UTdRSktIZ1ZEZFVaOVpFQStSbVZ6ZDZjdEpYVXlkVWdX?=
 =?utf-8?B?RURZTzRxZ3NIdFBnTk12YURtTCsyNkdOLytkN1haK0hjSUhVWkVaK1hlVmlL?=
 =?utf-8?B?MEF6T3A1amdUUEw5Qkx2NFZWZ3p5V0NiNUFsNXAwcmNRVnJnWUtLdWxZL1Vk?=
 =?utf-8?B?R1JTRGlaN1BNRjk5dG01R2x1VHNFNlFMV0JMM0liakRJb1ViaVZ3SnpQVkJY?=
 =?utf-8?B?MmloeTVBSHl1dGI0RE5RaXhDT1NrNEgyNjBXdkd1ci9uWnU3eDI1bDk4MU84?=
 =?utf-8?B?SUdMT2VyZTZRMHhacytqUkNSRElaOWdxbGZ4endlYm9hbnVFNjV0U0ZqRUps?=
 =?utf-8?B?V1FPbUFyVXNrenlpYjVoNWhZOXFlVjhyZ1NEd3AzQjh6RThTQm1YaWxpdmRo?=
 =?utf-8?B?ZDJQL0p2RmxRN1E0eWdudFFQWTMrZmk1a09uQlNJZEQrZUR5a2xXYmR3YmdJ?=
 =?utf-8?B?ZTFVSnhCUHYxSTJHQk9yZTloYTVvU1IwZm8waXRjTzVsNEVCZC84RFo1V2dl?=
 =?utf-8?B?eGNGLzkxaGJxU3hReFN6MkNIM1NoQURoREpPUlNmRU5kNzBxNUtmZUFoSk5a?=
 =?utf-8?B?dEZrYTJMVTY4S3pUTVJZeUVJamh1dC9TWkF4M2JzTk9GNnVzUnlOZWZiWGY0?=
 =?utf-8?B?aldWVWs2eU90SXJHalRKUWlPUUlkQWkzT2NEdTExMHBweXBFZDFrcU9EVWlz?=
 =?utf-8?B?RnJSTjZMdHgySHFpU2FTTWFZSTJsSUpUM2lhSGxzRndFTndETDJtWFRJWUIv?=
 =?utf-8?B?Z0hPeHNyWjJ6SWJ4cDF4REpIZ0M0Y0lNM29RL29sWjBhQS9xclhjcGpsK08y?=
 =?utf-8?B?cC9XYWhLZ09qMGg1RTZlTUdJZDVvNDdSRGZGZGFNUnVhbGlwZUl0V253QVo2?=
 =?utf-8?B?aU9tUURZemxWaDArMDc5L3c3bGoyYUFMU2xwSEhlTGZUd2pOSm82bUlKcGhV?=
 =?utf-8?B?cUhtNStsT3dnTkUrcmNoaVByK21WOVdab3hnWS8wZmhBSUNjWmxqdm1uaUVn?=
 =?utf-8?B?NWt0Y3JSM2wwVWx6NEFFQ3pVdk00QTF1U1BVMjJ5Ylp6WFNXTE9EeXJsL3ZE?=
 =?utf-8?Q?/u/LGWGEEe0K+1sQtiK/pKz8l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31a3ab4-9ff8-49ed-174c-08dcab2f9a6d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 15:53:32.3668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIpvwipHnCmfC+LZl6jYyn2MEPfjaukKXi6X75r+4g3x4VU1sRAQDe4q2p5l7WLzRNuZKdzZ3D+SAGtFhnPGSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163



On 6/20/2024 11:56 PM, Kurt Kanzenbach wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> When running the igc with XDP/ZC in busy polling mode with deferral of hard
> interrupts, interrupts still happen from time to time. That is caused by
> the igc task watchdog which triggers Rx interrupts periodically.
> 
> That mechanism has been introduced to overcome skb/memory allocation
> failures [1]. So the Rx clean functions stop processing the Rx ring in case
> of such failure. The task watchdog triggers Rx interrupts periodically in
> the hope that memory became available in the mean time.
> 
> The current behavior is undesirable for real time applications, because the
> driver induced Rx interrupts trigger also the softirq processing. However,
> all real time packets should be processed by the application which uses the
> busy polling method.
> 
> Therefore, only trigger the Rx interrupts in case of real allocation
> failures. Introduce a new flag for signaling that condition.
> 
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3be507547e6177e5c808544bd6a2efa2c7f1d436
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> Changes in v2:
> - Index Rx rings correctly
> - Link to v1: https://lore.kernel.org/r/20240611-igc_irq-v1-1-49763284cb57@linutronix.de
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  1 +
>   drivers/net/ethernet/intel/igc/igc_main.c | 30 ++++++++++++++++++++++++++----
>   2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 8b14c029eda1..7bfe5030e2c0 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -682,6 +682,7 @@ enum igc_ring_flags_t {
>          IGC_RING_FLAG_TX_DETECT_HANG,
>          IGC_RING_FLAG_AF_XDP_ZC,
>          IGC_RING_FLAG_TX_HWTSTAMP,
> +       IGC_RING_FLAG_RX_ALLOC_FAILED,
>   };
> 
>   #define ring_uses_large_buffer(ring) \
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 87b655b839c1..850ef6b8b202 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c

<snip>

> @@ -5811,11 +5815,29 @@ static void igc_watchdog_task(struct work_struct *work)
>          if (adapter->flags & IGC_FLAG_HAS_MSIX) {
>                  u32 eics = 0;
> 
> -               for (i = 0; i < adapter->num_q_vectors; i++)
> -                       eics |= adapter->q_vector[i]->eims_value;
> -               wr32(IGC_EICS, eics);
> +               for (i = 0; i < adapter->num_q_vectors; i++) {
> +                       struct igc_q_vector *q_vector = adapter->q_vector[i];
> +                       struct igc_ring *rx_ring;
> +
> +                       if (!q_vector->rx.ring)
> +                               continue;
> +
> +                       rx_ring = adapter->rx_ring[q_vector->rx.ring->queue_index];
> +
> +                       if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
> +                               eics |= q_vector->eims_value;
> +                               clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
> +                       }

Tiny nit, but is there a reason to not use test_and_clear_bit() here?

> +               }
> +               if (eics)
> +                       wr32(IGC_EICS, eics);
>          } else {
> -               wr32(IGC_ICS, IGC_ICS_RXDMT0);
> +               struct igc_ring *rx_ring = adapter->rx_ring[0];
> +
> +               if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
> +                       clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
> +                       wr32(IGC_ICS, IGC_ICS_RXDMT0);
> +               }

Also here?

Thanks,

Brett

>          }
> 
>          igc_ptp_tx_hang(adapter);
> 
> ---
> base-commit: a6ec08beec9ea93f342d6daeac922208709694dc
> change-id: 20240611-igc_irq-ccc1c8bc6890
> 
> Best regards,
> --
> Kurt Kanzenbach <kurt@linutronix.de>
> 
> 

