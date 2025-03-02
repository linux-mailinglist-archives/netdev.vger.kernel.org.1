Return-Path: <netdev+bounces-171001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656E3A4B0DC
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 10:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC0816AAE4
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29091D7E35;
	Sun,  2 Mar 2025 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HzrXsw+J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BAE5661
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740909346; cv=fail; b=gIzj3vPfhbs//WzDDJFexMV0BQeJyqja2Ms0A2dHUtQFDG+UaI3LU0GtcZzgbOHeHpIwsWaUNG7OSoIscPdkzS6CnlfCHh18ZG8xFNGXrn7gNAgRXt0KheyUum7OU2PIubm/ABOqzv6QfULPpIKH1xz3lxfAsEIxpwpCwVQAMSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740909346; c=relaxed/simple;
	bh=V6dYBEX+cpfWKB3AlKVgAO+vLmkAvNA2aBeJqVqaQ50=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DDVcuKRdgE0VEVRXcAOanitaHBaBHFDZC2M+ZmAXLayymzwpMn6Ac3YYhrlbVrp2KPWZaEugmj5inroedbJpiWbtmCR1BXtPIWcmJGMznFhvwn27JjaBl8+1SQmFEErNt9y2QdBCRayOfCnzA4pZDDwtPtalhFBouXZiUvoQd7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HzrXsw+J; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWlfIQX6+81SmwKyYxxXa57RExiI8FDxPMhTr4DhvDNYpZuYmwC9K8X3UlDi7MHEpDZZN4ixW30G9gsURd/Il+so1VLc+qRsYgv7aCYr/9j/TPRieeg1OyK11DrIWEJhUx/6v4zd6cYjY4yFk5t3+t0VjKVaezukPbm1TwqFCYemdcr5mbmwoQu/2Dg7WV5JrOpFaHNAj78qY9IYrQ3nmMX/1uIHSRmSDeaxAPS83VanLfT1B2oMspPM0bZWVkX4EAZNa0RoaQovQzkqqhWJ4+xlfoT41MkQqep5hFCoxMcw3x/6cL94zH5Xtb6l+Owe9WnP8ljlpGOhPe3ldjlWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIVRZ63929O61VHJxs87x/b4AJgiN0XK29gkZjumB/M=;
 b=PALjFOUjRzz8/dQ6dl5cuoSpgcegWR5EUCoBsxeXWUJ8D/zQRcD95P/ni2Zs28YeQWZtByZT+nk6vr6faPKWO14tILhItdgsmFE64x2BiFxCoHD46z4TtptKAeWKmDhrcfiDXdzawxc7XPPeKxCW/GRBGYAd9mitDDfNwHCv1Qchx1nZ670P87obGRps6rB+13BQPrGjK3zyplDU+bfHG63qF2lXc1W3g7y+IVh896KmISibzf20N7S3WFTPlTujX/hscnmoq6SsEBAvDlMGoyOEUYKbnMDmJyWwIyAZ2DEKNG8sgUHWt56W8qOtR9W0w80XS1B9l5kGiJXLtXpgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIVRZ63929O61VHJxs87x/b4AJgiN0XK29gkZjumB/M=;
 b=HzrXsw+JNpwJdrnQEB99Iz+HazVLvJoHRe4rUV4bwzkafZpW5b3PiaNNc8gMlCXexg974oYpqXqr7f6HWEN4pILVmHhKt3/Gd5jtI3DsJ6fYzHidddEeB/MOivFS2Hl4wPiwdaWxyj2tRIULbzbnYGkh/X7CqK6LI02TsDP+QyQg5t1F0pzVOumE5MSuWKV9brLVqquPwq9R+Ymbhw2+XgBovXOPG/efkmx0CdTBN6n+jMX5FnS+Nezm+IqitXmCAnyozeOmcRj6wIXLHjxGz5OnXAEfXZ8zLcGXGucWD90Ov2/zjbCT8e8Qfvhd5ngZL/+xW/Q9eqMcMHG4WwE41w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 09:55:41 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8489.021; Sun, 2 Mar 2025
 09:55:41 +0000
Message-ID: <f5bf9ab4-bc65-45fe-804d-9c84d8b7bf1f@nvidia.com>
Date: Sun, 2 Mar 2025 11:55:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context exists
 in case of context 0
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Joe Damato <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>,
 ecree.xilinx@gmail.com
References: <20250225071348.509432-1-gal@nvidia.com>
 <20250225170128.590baea1@kernel.org>
 <8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
 <20250226182717.0bead94b@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250226182717.0bead94b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0044.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::12) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: aed9535e-545f-4b9a-02d0-08dd5970644e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnY3bk1zVit6WGRSUVZQYzhudjNoNmRRV251cGl0R3pNV0pqejM5NzRHWGs0?=
 =?utf-8?B?dW5JRUlHTGc3azVwNlVwNVRyWVBiZzludWY5aGpLUUZLNGVsN2VEUm52R3E2?=
 =?utf-8?B?LzNtd3F2b0tUS1J1bW0rbDhueTU2V3NSb2YvdXJFWHBGSm15MXlkU2xUcUVl?=
 =?utf-8?B?UVcrSWEwaGVzZDFhZm5QOW8yN3MwZ2xaOU9HSmxMRTVWOFlDWWxON0FnV1Vx?=
 =?utf-8?B?WGtiaUlxaWZuTWM2TXlnWk5iVjNwMnFnYXNJRUZsdVpwbTc0alY1Nnc1NUFh?=
 =?utf-8?B?cXY3dngyVFFOeHVDbFJOUC8vNS9tYkh6ZnI1YVhGdngwY2oxWTVML3gvclNz?=
 =?utf-8?B?aWZBN3FpaWRMY3hnMkNBMU9sT1lnNHBEak02RU1mOEtBRWplam80bVk5VFBE?=
 =?utf-8?B?THg1OVF4V3NWYzRKbk1VT0pXVUlHODJ5UEZZSU1JTDdMNER6ZXVzVGt1RmNt?=
 =?utf-8?B?akcxakREcjM2UnNINUJ0NmRjSzQyTkprTmU4aFNRbGhhSW8rRUEzYVFxL2lT?=
 =?utf-8?B?RVB5ekltbGJIVGVlVUp6VGlQNkFxeEVtblM4SWFET2tPUllIN2xENHV6NlI0?=
 =?utf-8?B?aWI3Wmp4d20zUUN5OHhoWGd6N3VmdXUxYmNBSDVGeTlKU1ljUjV0cjR1ak1U?=
 =?utf-8?B?Tysxb0RVNXkrM05pTVBFb003aExCSnljd3luSzZFc2FZbUFJZ2ZkTVBxWHpq?=
 =?utf-8?B?eU9VdjJrYStRQy83MmNtT0oxV2JQbTZCK1F5VDUrNlFMZmdFclBOZ1FTVFQz?=
 =?utf-8?B?bUFiRXVsNmJCL2JOd1NjVFRSYUxhWUJrRy9IVzFhTldZWWRDTFFQRnZCdWRQ?=
 =?utf-8?B?YkRwS0M5UmxVYXMrT2tZTHd1U29LUUdnUmVMbTVUVlZVelhEZndzbDkzbnZP?=
 =?utf-8?B?N04vR1VjSy9rYVk0NmwrSDQzeUcyekl3UEg2WUZSMU9oaEswWjNsM2pVYXVh?=
 =?utf-8?B?cHlVWTZRVzBXRXg0eXoyZDJWUUxTWEFTbUh0a0NETkdQZGxzUGZnYjVBUTgw?=
 =?utf-8?B?SVBkVUp2UUdzZUxEcS9JdUZzN09jdzZuS1BQUGRLSVZaQlN1SzdPK3BkSlJR?=
 =?utf-8?B?R3cwU0tKSFhwT005UE1VSHB2dWJ1ZDk1QXc1cVBQeXh0OEd2V0Q0MVdpQ2kw?=
 =?utf-8?B?RzVTWkJoR28vUjF5ckRoV2xkK0RJeDZpdFpSYm1OcFFKbjZMUlFkUmNYakx2?=
 =?utf-8?B?MkF2NTkzcTNEMFJwcW02eEdIcEdrRmU1S20rTXBGV3FxVWRtTm1JTzF0ai9z?=
 =?utf-8?B?ZUpDV1RKa0Q2S0tTZ3dXMm02cm9QNzhNa2NUM2JNUE1QWnVJRzZXM21LUVNa?=
 =?utf-8?B?Y0hsTm1DRzRGRUtzRmplZ0Y1dmx1VFhOSlJXd2lLVm1EV3lXUi9RMWR2NnFW?=
 =?utf-8?B?dmFxalhSZXRlSDV1cVA4eFl0dkF4RVhZZzZkTUdyVWVKTGNtV1pXLzFyMkVh?=
 =?utf-8?B?V0ZjV2RxdEpuM3VmWE1sS0J0V2RiZzdpM3YzeTdGbHJBWDVOK3dxbnRhME41?=
 =?utf-8?B?YXpSWjJFVHdaZUs2aUUxL2E2RWJXcDN1OS9YU2dNaXZ3OEJZQnI3Rk5tMWkv?=
 =?utf-8?B?N0p2QVRiZ20rcDVxMktSZVZPOWhmY3JzMXJseDNZZmE3RW1yRjNpYTdnOHo0?=
 =?utf-8?B?bmpjd0t3VDl2bis4ekdYWlFiM1FxMXYrSmRYTkZzSmhqZFQ1YXpsMG93V0Mw?=
 =?utf-8?B?T3BiaGFuMXdJczBjY2pkNjFHdVZ1Sy9YcFczQTVHbDBnNkllN1JINnBsZ1E3?=
 =?utf-8?B?b0UyeFRMM1IwS1N3czdPRStTK0dTTnZiY2tVb0ZEaDBjem01MkRtdDZHN1A4?=
 =?utf-8?B?QnRrZklzbkNsVmU0Zmk4dldoL2xScHEvTTA4OC9xUVJlOVhTR3Q3c05jcWxE?=
 =?utf-8?Q?ewtJB2B4OHJg3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekZjZ1hILy9vMWNLZ0JrdWdBcWVSOUplU0pNUktzdVZhV3VBVWpkT3M0LzhB?=
 =?utf-8?B?VE5wU2ppOFdELzZZVHFtSEFONHZ2cFZaNUVqUk1HZFRxZmUrZE56V3ZnajN3?=
 =?utf-8?B?UGRqNC9MTVRBSWNyaHBTYk1vVWZleGFKN1UzcjdrQm1haXcyaGFlODBTR1VM?=
 =?utf-8?B?Tmc5SjEwUlBSZFpQaWRHWXFHcFBycW1TTDg5YnFma0pkZFdIdksxTkM1MTM0?=
 =?utf-8?B?aW11SkROVTI4dThQUVA5OGhZMXE5bko5eG5Ecmk4dmZ5b2tiY1cxWjBWWGpY?=
 =?utf-8?B?bFMzQi9LSnNVTmc1MC9paEVnNDM3bFpKRWo4ZFdNM2tyVm95K2pWT3dvb1FE?=
 =?utf-8?B?MXpWenVISHVSVWNOelc2MXNqOGdsOFJBYWU0QzhwMlM2VHNuUStjZXh6cklV?=
 =?utf-8?B?MEhvRW4vTTRvTW1oRis5L1JBMFlFek00VklURk5rKzZHQ2F6ZGE2RjNVNVkx?=
 =?utf-8?B?WWxCZDFvK0JHWFFab3NDM3hWRlJqSTQ5M200aWtkS2loMVZ2N2RIeGk5U2lN?=
 =?utf-8?B?T1BRTFRXRlI2cFF6Z20vYVJkZ3BkYktDZzJNQXIxRXZaSG5KRGxFVHZpOFk0?=
 =?utf-8?B?anlkMncraTIzZm04L1lZZWFqRGd0Uk9TdmRZaTl4aUpDOTFPRVBUWVNNV0lF?=
 =?utf-8?B?UHNuRm5IMzBPMC9zVjJtV0hhR1kxRWF0MUJSaytkYlh6UzRaT3NvYXlUQ1Ay?=
 =?utf-8?B?Mmhxdk0wUGdsRTZzcmJBclRhNnFSSS8rcEswWERBSWJ0Sk5QdnR3NzQxcmFk?=
 =?utf-8?B?T3JveTJsRkFDQXVLZG56bzMrWjJRMVd1eHFybnRVbHV0OVNsem5vSnR4a0I2?=
 =?utf-8?B?NkFxcWhzWGM4UmhmR2xhVElobXFYcUR6S01EY1dYR0lQOWF6b0xncVk5YXRD?=
 =?utf-8?B?dTVLalFsajBIWjNnZDFWdWhGcTBHbHBWN0dKYVV3dmdlS1RRUlZrSzY2eHRL?=
 =?utf-8?B?RDB0SGw2bU9pSERaZ1FTV1diUU5uQktoRmF1aWFScXA2eUhiSFlpYjdsRWh1?=
 =?utf-8?B?L2ZYVDdpS2FqdnRZSUpOckI4L2NDU3dGbFlqYnFQRSs5ZEZLdGovZEdDTVhS?=
 =?utf-8?B?YmxpS3A4VURFQmxEQldQaHRzYmdqUVF0dHA2WXdBN2s1MVhRQ0NDaXVGWXhJ?=
 =?utf-8?B?VEU5VDZURHplNnhCU3ZRV1I5ZlhKNmJWbVp4SUVWMC84Zm03WGt3MmVKMFFz?=
 =?utf-8?B?c00wdC8zc1ZxSUpJYWY5d2VQTzJIc0NaN2RmU2RteFN1cTFDcnV2LzkwWGtW?=
 =?utf-8?B?RElBc2IxYmtsaE40cVFtQkxKc1R0R05MR09qbkdObHF6YjgrbW9XSmExSjll?=
 =?utf-8?B?dzZyZ0FZUjV1VlIrUHJrLzhMdGduSjVnVk9IUUFCMzdvMmovZWlVSzRxc0xo?=
 =?utf-8?B?MHhic2txQi9GR1VheE50V05pUDNCMzdFTUxFSjVZN3drUmdWQzU1bE5ZbXVy?=
 =?utf-8?B?ZlhCbkorMHdJWnNKd25yb2JLb1RhMXNoaUoxa1UrT0RsRjNXM3ZvQkhjM1o2?=
 =?utf-8?B?c2F5M0x0YlhBeHdTSWJpTTNJU0xPemxwbk02NlVMWSs4dGJzRFljQktqSXVu?=
 =?utf-8?B?ZEpiRWUyM2JWdlh6OHBPdkw3TlluaFlwUWhBakNvbFVZYllVZjNJQUNzeE5O?=
 =?utf-8?B?YzNIRjV0YlQzbjUrMkIzTEZTUUJlcmtJdGtlWVc1OHZOYTVQZUE0SVUxQ2RL?=
 =?utf-8?B?K0JFVzNIbENkb21VSDlVYUh0R2RZQzNBbFUvZGtYLzBtMVBKa3cyenFsdWR2?=
 =?utf-8?B?R0RPdjZ2SmlnN3pGeXM1S2FkZUFCaXhWMDBla0pPd0pGSWJjTkIwTWxSOG9i?=
 =?utf-8?B?SE1TcVlaOEZkZ2tLRm5mOTFjeUFvQzBEU0ZOSzBWLzZmeHhtUTRDSDJWeGg2?=
 =?utf-8?B?OFU0MThrbkx3STE5TkRFR0pkUmpqZkdWRVYySG9vNlVjVWU2bnJKQnU5RjRl?=
 =?utf-8?B?bmhSRnZNMVJvbzM3OFJHMkhpSmRKOTgwZFdwaDhkaUZabVFUS2pXSitwdE5U?=
 =?utf-8?B?d0QwcHJkVnNUR05pTjNLNmxuelpicyszVHkyQ1ppbEdGbUhHMDExOFl6eGhw?=
 =?utf-8?B?Z2xkcW9Sc3JPakVUdXBsdE81U01abTNkUmltUHdhV3N6T3hmTXEzSEw5dnZE?=
 =?utf-8?Q?lRjwXtsWqtin6B70cBI0G2R7t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed9535e-545f-4b9a-02d0-08dd5970644e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 09:55:41.2938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9i5APJyBkQjvkSsg/E59pNZbccn0PN9o/pRrt2WtwBX4dI1xwquODaE1kB3wZDC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612

On 27/02/2025 4:27, Jakub Kicinski wrote:
> On Wed, 26 Feb 2025 08:08:40 +0200 Gal Pressman wrote:
>> On 26/02/2025 3:01, Jakub Kicinski wrote:
>>> On Tue, 25 Feb 2025 09:13:48 +0200 Gal Pressman wrote:  
>>>> Context 0 (default context) always exists, there is no need to check
>>>> whether it exists or not when adding a flow steering rule.
>>>>
>>>> The existing check fails when creating a flow steering rule for context
>>>> 0 as it is not stored in the rss_ctx xarray.  
>>>
>>> But what is the use case for redirecting to context 0?  
>>
>> I can think of something like redirecting all TCP traffic to context 1,
>> and then a specific TCP 5-tuple to the default context.
> 
> The ordering guarantees of ntuple filters are a bit unclear.
> My understanding was that first match terminates the search,
> actually, so your example wouldn't work :S

The ordering should be done according to the rule location.
 * @location: Location of rule in the table.  Locations must be
 *	numbered such that a flow matching multiple rules will be
 *	classified according to the first (lowest numbered) rule.

The cited patch is a regression from user's perspective. Surely, not an
intended one?

