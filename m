Return-Path: <netdev+bounces-142590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E379BFAE8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 01:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CAC0B22592
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50D42114;
	Thu,  7 Nov 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RxhXTLcS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A47322E;
	Thu,  7 Nov 2024 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940616; cv=fail; b=YJfI2LnhKvrFkZOGKacU+8AUkOmoiH7Ea3qMQarfrhe9XODnqaB2g3p2Y7u3iJY9xdSUl3UWv6WQHBrBhyMxaigAtoprMH4w04ZFWKIJ6HhJq6FjKLFzmhIIXwvZd3M74kn6oIOtkysV3Lmu7R2eznsn5gU8+vplFyQXNVR45so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940616; c=relaxed/simple;
	bh=zLnLCUaoaarzl15NQyduQE3LSCmT71eADdW87rng2M8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B70D16464xFSXSio1JZBZu7XCNtWFOt7x1t8UUBR4hd8TJ6PTR8+0FjNpb4OM6432ZQsH7o0cq/x56WohHxtQihMj659N5mG8WL2sZJ3blXdI8fSTZbNLVEJ7WvVkA+mM8FuDBhcV1Dh025tWL7UBZ/+b2kKDWCqTWxiXQnBaLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RxhXTLcS; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISrJG6ryXU9rJMui/QKv37F/oSdsjA+j7bD+dbcW+3+tEHINFIaGMxH48vXnNMgY0n6IemgXcasWJlmx5mbt60ajQt2e+hsgeYtLDywzbH1g5ksdPvdx36j0DDm9W7CJK0sMJlfv67m6DEfofVs9dFm/+pIQ5UtaA6TEzP49zdWa8WTFu29cbYf+7Ia1eOwGBYTtFT4D7s868Cfq3/ZfCD8InSXpzLZKhIIX1RSzB5MAYY3d7JD1xMuu4hylJRVB5u0MdAvDSWm4OtKxgBCeOfO/YmZCFpkM+MDtz9uC93SVyTBjgSi3a6NH5z6lZgelciTUDDVQA44Nrkm8Eqygyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW4jGgLFmhTl1bl29EamQuK1+i0HnyfEwI7xHYXS5to=;
 b=wXSrLobgPlxsghKerRUIuGDKVOb1UH1F9uF2dow8y8hvhM8Skf6quZiMeYIxSUOPW5/lQGZGLPq226NQ3ax4JDGCW7rPsdQzYJKZrmJZfaQ4zTOj9ePN/he7ruEpe1cs5jAXGmREBxRrDrjrxvyF71rdi3DYWVPStLJ86FvBSCZigjXfA/2X3eLc1cQaw8wXs5LNFgkM0w2bJJypgKT4uCv+zPWaLXlHa9LX3wYYN8UHhBr4P6h4jk3P+h4FdWRXIxwYW2+zJmfN2W6oO6JjkM0ve8HVKUCa6qAVM91+S1+N+JSyPSrwxRsMfrZYU1Q5VQOLdIO8iBjw3l7siJwkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW4jGgLFmhTl1bl29EamQuK1+i0HnyfEwI7xHYXS5to=;
 b=RxhXTLcSMaj21q5Fs/mR/+UR4r3Zmx+4SLl7PYjzEI46hWH/66hj7Sn0qCJuSkvLqwSJX6xFYbnuQFx5k/12cWSVj7NEz0oIvR61kjZpQAq8aHIRf2S1eR85+fa5/N1sBLJKhFAzVY7FapsRCzdA2rLt/2P8rLowQJvW03g493g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Thu, 7 Nov 2024 00:50:11 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 00:50:11 +0000
Message-ID: <4bb510fc-105e-4fd6-bc6e-6fdd1763ad91@amd.com>
Date: Wed, 6 Nov 2024 16:50:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: net: ionic: fix a memory leak bug
To: Jiri Pirko <jiri@resnulli.us>, Wentao Liang <liangwentao@iscas.ac.cn>
Cc: brett.creeley@amd.com, davem@davemloft.net, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Wentao Liang <Wentao_liang_g@163.com>
References: <20241106085307.1783-1-liangwentao@iscas.ac.cn>
 <ZyuLn0OW8ceu9cMg@nanopsycho.orion>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <ZyuLn0OW8ceu9cMg@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 54000558-d823-43aa-35ff-08dcfec6228f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WncvVG5KOU4zV0FlUVpvZURZdTExUFU0cE4vRyt2RlZ0ZWdWT05KQWdzZWJs?=
 =?utf-8?B?ajZCRWRJTDNJM0VvRXBoTzAxUXh1aFhxaGxRWnp2YjRXeG1NSGtTZUwreUVQ?=
 =?utf-8?B?bExLdllZZDJlL0pSTytzaVBuaUd5YytqemVRZ1Q5Uzg5YzNZdUc1QmVSVWlT?=
 =?utf-8?B?MkcwdHFaQjFTRnVFRXk5WWRlZWFhdHVWa3hJQXZBQnNhS2Rsc285YWtScDVO?=
 =?utf-8?B?NWpMWWRKMnUyREFQV1BLQXRZZzMwSDRuOE05TGNMU3RjR1ZMZU5aYjZETmhl?=
 =?utf-8?B?UGFoNnJYaUVLeHVITTVLTFVzQWkzaTRwTkNtVHdCVlpMK2RmVnpMUzcwRHZ2?=
 =?utf-8?B?blJKNGJOQkUrN29yaGhzU1ZIbVZWT3l5bWdRMFJGeXV5SmNKemdDcGtzRFY5?=
 =?utf-8?B?YUJUWXBFOGt5akpLdkhhcU5OdkhOVDRHZ0Rra1ltYWU5UDg0MTdHSUM0MEVv?=
 =?utf-8?B?TjdZUm9JZUdmY25rMkw3dmttQ2pGNnFNa0k1cG9mVXNZYWRhOUxOV2pPTHU2?=
 =?utf-8?B?aXFVZFNlanozUFZsaWVuN0FTdUZPdFpwRDJsenVOWmlQV096SHlEaUdrczNK?=
 =?utf-8?B?SnY1SFNNWDZJeHhqYUwvNzhFblVtN0NPMFNFaElvazFVMjhBdWF3UTY2bE42?=
 =?utf-8?B?REF0UDNwVVVad0QrUDh6bGYwTEZ1K1lmdWFFZEsyeWptdU5td3RHL0oxZ05a?=
 =?utf-8?B?REQ4TDJuamxwUVpocFpmZGhCRkdONDFzUUJsZnJFS3NoWVVLb3FJVFp3LzVn?=
 =?utf-8?B?MkdidDlUdjVkdW1JekRkQVVhMzh6RWNmaXYyQ1h0bHNyZiswNkViNlpQbnQ1?=
 =?utf-8?B?SWY4akV6MjZJVG1DS3ZGMUhvRUFuOGdxV1RDYXJTaFNkRWlQdXRxRkpic1M5?=
 =?utf-8?B?WnVTeEhaQSttbXA3cUtEMDNVTkdqR1F1Y0lJT01HWVVUSkVsTlVZa2JkZVVJ?=
 =?utf-8?B?VUxGa3I5bHRLbytOUGhXZ3JaRGxqOFlZSGpaVWFZQnVSZE5uUkQ5Mi9pUWwv?=
 =?utf-8?B?aFF3QzlRRnBlK0kwNmk0MVZiS0N4KzRjVXFNcFFISUNZVnhKR2drSDl6a2Fi?=
 =?utf-8?B?T01aZUhNNVZLVGk4Ylh4U0JTM3hqeXlaV1ZMOUl6MW9EaVhVZW0zOVZ5WnNx?=
 =?utf-8?B?MUp6MkovL1oyRHk2UnZFM2dyRlRudXVKUm9uTnJtMzlhK2Y2YlY2VTZMZG9s?=
 =?utf-8?B?L0V0MFFoZFRWMEoybFB3cHFTWG1ONmJKYlVuckpJbExEK2NML0RSS2dINmo3?=
 =?utf-8?B?ZDhOWFV6LzBqUFhhWHQxUjhuSzF6OTgwVzlrNFhZdDhKdXBhVkxBWC92UVZq?=
 =?utf-8?B?YnhCKzZEdDl3dFQwbUl5T3ZpczhIZEhvQmVZWGFtSjlSb3lvOHhDSlpyRTVo?=
 =?utf-8?B?ZVlXNndWVVlWZFJSdmx5TmV4R1NSLzFEa1ZPZkZDK0plUldSdkJNellJclNt?=
 =?utf-8?B?RVI4OWpIa1VlcmtuZTFhV0lBTTBWOEF4clgxbWxSOXQ5SmtMM3ZIYitpbUJr?=
 =?utf-8?B?SCtFSVlxOVhoQm1pcnlCRHRYdjFDTWx1OEE1dmVNOThoMTZQRXNZbkMwVmR6?=
 =?utf-8?B?SXEvclZiNkxPcE9oN1hpQndPRHN6c3lIcFMvZjlsU3d3L29neGRCcFV0MnJU?=
 =?utf-8?B?UllWekIrNklxZG9vQi80Y0s2WjdjdVIwQU9XN2kyUkdRamNqR2VvU1B6RlNG?=
 =?utf-8?B?QWVaTUJ1KzRFTEkvc25ESmFvNG5lTWdza1d3aXlJa0dMOVZzWnlkTUJhbER3?=
 =?utf-8?Q?M5dKUyoAAKsfOXbO6mpzirzw4yD0DhP2fPLJDHB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXZWeHl0RWd0NUYzSmE3U0N0OWZxMHlZZHoweUpnZk9PVWJTYnVpZUpMb2lT?=
 =?utf-8?B?MGs5d2lYaGJnaXU5UmJVQXJSMmpBaXp4L3kwS1UzNm5JaGhNd0JJdzJSenBP?=
 =?utf-8?B?ZnkrY3ZwSzNaYlNmdjF2dHB5Y0xVeUlnL1pWay8xUUJZYzdZY0RzY3NNcUQx?=
 =?utf-8?B?TnlWZzRxVGhLcXhBcHlkV3BpdUZCd1JXb1lhci9NZm85RWpBSzJmMy9UTVUx?=
 =?utf-8?B?NGJ4Y2tWK1lGL3NEUE5MejcyaTJIbUZYWCszYzUvbk9TR1gzK3BwS3BHV2d0?=
 =?utf-8?B?NXZtem0yZ1dWcE5ZWm8xalFSaTl6amdmZWZnWEZ3OTdpMTllOVE0bWV5Vm85?=
 =?utf-8?B?UWc1QS83RFJFdnpKY2RUNmZxZU1RWXF2SlNIVnorYmRNOWx6ZDQzSDNFblpa?=
 =?utf-8?B?M3hFZFN2RURVUGRKRTdzUEFrUzFIbHNGOU1lc3RyTmtJSzVaZk1TZTNGN3VD?=
 =?utf-8?B?Z0dYTWVIaUJJTE9KNXNlYkpGZGcyY1BDSTEvTXFaUlRjZW8wZWJGbW8vbzRl?=
 =?utf-8?B?ZjU0VDhIcGpqaEVGekNrWFRhQU15YmU4elFUellJQlJPV2dTYndxd3lLQWRP?=
 =?utf-8?B?YUZJSU0vMisrak5tVmNMUlRSUTY1emhYRW1QWEEvMGhhTFhJUzZzZzhnc3BX?=
 =?utf-8?B?VEZWNERIVkdIVzRaODRjR2pSWFVEb2p0M3h2anFCVysyUUhnc0t3NGFwVGEx?=
 =?utf-8?B?bnFrcmZOczl5cVBPbloyVERCUVk3UURhOXlRODlRdUtzWmhlQUJtMEQ2SnU2?=
 =?utf-8?B?blM1V2c4Z3FpRWhyR2pFbDY4cG40TE9EcEFqemdrQ2EyT040UTJGblZySkxF?=
 =?utf-8?B?cmNlTnQ1Zkp3OFBJdGZBQlpMWDdvOGhybytrTVQ1d0xVbXlWRnAzUnZiaE8x?=
 =?utf-8?B?WDJpSFNuTUhPeXpJK1NuMFBCbDNvNDdqUy9pR09nSXAraTBBVmhTSktpTVFl?=
 =?utf-8?B?eVlkUW56ZkJRM3FRd3o0VUIwTzdZaWtHVkwzV3dweExFSWlrbndWSGFMajJS?=
 =?utf-8?B?ZnZtcDNNTkhXQ3BpREJyaU0xVzZGS0wrUHBraDBIcUxwbjh3WmNvY0pIRWpi?=
 =?utf-8?B?STU3aVFPcXRWTEV6dzNYSUtoYkU4dlphV3dKRGF6MHg1TnI3dUt0OUVobngy?=
 =?utf-8?B?WWVlNCszS2lxTE12cGs5anJxL05UblJZTk96WHhSckppcjdNeFA1cy9LU1E2?=
 =?utf-8?B?b1A0Y0NnM3pLUGh1bHhnRG5vSWwxVHRnT0xhMkt6ZnRyVlJUSUd5RGdxY1Qz?=
 =?utf-8?B?eGF3S1B1eURsZHovYm95RnBFbWZqL0xKRFZJNlg0SHNoYUpMdE1IeVlQYVho?=
 =?utf-8?B?RVJReEVGVFRKc1pzbXdkWmp4QndBQlVwdmhubEZKa29Dd1BZd3V6Z0JmM3hP?=
 =?utf-8?B?ZGtuTTdtbVpvcnoxYVk0NnFXcXJSM2dpTSsxOVNHaEJvTU9ManU5ZTNqQi85?=
 =?utf-8?B?ODBGbllzQnFaVVMwSS9SVVRET1BGMkJqdSt0Q1J3RzE1VmYxa2lybVBldXNr?=
 =?utf-8?B?N3hDK2t6UVc5UlAzNlg1QmpxdmlMSTc3a0YrcHBOcUVhNEF5K1U4VStDeTJx?=
 =?utf-8?B?RlE5K0E5SUpWWHEzYVVmdEtIWDF2YW9KWFdvSE5rR0NqNUNGZ2I0dGY0dEhI?=
 =?utf-8?B?TUpCdklPY1VtNEFrZGRYUWJodVFuRTZuQnAydVBDalVkR25QWDVWb3ZjVThW?=
 =?utf-8?B?QmlCb2ZjUGVCanpadldKN0VQT2lJQjJHSWgyNCtRMHdUM2htN2dSNnREMjVm?=
 =?utf-8?B?VTlwTEZlc1VnaU0rQjBiRTR3UUFVemtnZVlPaU1wRWs3V3lNNW9BVkRDbGF0?=
 =?utf-8?B?L3NMWGJONUFkZUF0V1lBa2NFUENqekpWd1lqWnpHdVMvRHlkOGdQTUFmQXZQ?=
 =?utf-8?B?OFd5QkRhYjVGNGptcy9IWDdtWjlWRlBIV1FQV3hBcGVqb2p0UW1VSmgxeTN3?=
 =?utf-8?B?N284bFpxZU1LVmpMdy9MRzdTSHlnUisySGhodWRoWTZaMXRaUllWQ2c3UTJZ?=
 =?utf-8?B?OEdDMmtmeVYxU0RobVFaMmMyTEpQSUNFUWVaSzhxTEdMWEdNd085ejdqM0s1?=
 =?utf-8?B?ODJXaXUrYzNQMVQ2cGZPQVpRWkcrUWdxcUhod1NwRnFDRjFhdlpaMjUxbXZQ?=
 =?utf-8?Q?SWfmHdOIEugoTCiJd5UlD5VtK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54000558-d823-43aa-35ff-08dcfec6228f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 00:50:11.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvEQzQuTmnsvBDKcP/YnNTLBsN8wOZ9GpKQo18tiy7wFFhIVkoJZd2eSNgsbCxF9lJ0c15JtXgMqjW5aavgcng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166

On 11/6/2024 7:30 AM, Jiri Pirko wrote:
> 
> Regarding subject. "fix a memory leak bug" sounds just too vague. Try to
> be more specific. "add missed debugfs cleanup to ionic_probe() error path"
> perhaps? IDK.

Also still needs the "net" tag in the [PATCH ...]" part.
sln


> 
> 
> Wed, Nov 06, 2024 at 09:53:07AM CET, liangwentao@iscas.ac.cn wrote:
>> From: Wentao Liang <Wentao_liang_g@163.com>
>>
>> In line 334, the ionic_setup_one() creates a debugfs entry for
>> ionic upon successful execution. However, the ionic_probe() does
>> not release the dentry before returning, resulting in a memory
>> leak. To fix this bug, we add the ionic_debugfs_del_dev() before
>> line 397 to release the resources before the function returns.
> 
> Please don't use line numbers in patch description.
> 
> 
>>
>> Fixes: 0de38d9f1dba ("ionic: extract common bits from ionic_probe")
>> Signed-off-by: Wentao Liang <liangwentao@iscas.ac.cn>
> 
> 
> 
> Code looks okay.
> 
> 
>> ---
>> drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> index b93791d6b593..f5dc876eb500 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
>> @@ -394,6 +394,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>> err_out_pci:
>>        ionic_dev_teardown(ionic);
>>        ionic_clear_pci(ionic);
>> +      ionic_debugfs_del_dev(ionic);
>> err_out:
>>        mutex_destroy(&ionic->dev_cmd_lock);
>>        ionic_devlink_free(ionic);
>> --
>> 2.42.0.windows.2
>>
>>

