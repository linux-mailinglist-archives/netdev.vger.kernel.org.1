Return-Path: <netdev+bounces-149083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7569F9E436C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 19:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C9AB62844
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7AE2185A3;
	Wed,  4 Dec 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uUb+NsLu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56458228D7B;
	Wed,  4 Dec 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331806; cv=fail; b=cnUlk0X1HDHqvG56o+wuwu5hgJha0BdpIA1IntxT6ssBPfbBDex1NZdpCpdJyKCLvVNp9IHgJpkFn0Bed1zdggxVinuwrPtlOsT7/FedFGCDMfM5eUDCho/5Y183ypqCZalsEb1YodX6x65zhAX000q3os1ziczP5twpL9fcQoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331806; c=relaxed/simple;
	bh=uc1VS2iwrV/O0Dz+iCLV7Zg86q+TXQ/qkF/lRnsOkh8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cjMeUKMQRwBQHUKWqX1fe3QspZm1PbbPbapH7KDH+z2lwN9uwVoEVHWsH2T4lHoPbsFa9Dacow6YzzsJAJ7s/uzPlvmFkVuqqXVQkd9r6/PA1bnA9WurrTAVrx8PvYLzlYCNWpl4wqUf9Pk/klEGDUh6HK2fzlUneVydoLT8y/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uUb+NsLu; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwnZopVjwIG1uBtq0hbK7KCk3e+EJaOAR+lOgUn/qLQmHhSxEt3eQguGZc5D4IHVQcOxoseBBP4ZCyGKZ9NcGgdjv2YdgjbT6Gv3kHg4fyiheF2w8DJHqWjO1EVPF+MeGPFRxMqWqYOjbz2DMOTm176ej8diIuOrTmkRT/y0rQLa6jl5SfPzBCZmeXAJjppnU3VMpI8lpYx3Onyx0NkOmfZ0j0AaR61q8wC3gwzvlONDOr3C0ds7xsZYvfvArbAxIT+kfhUsLuPpw3IG3Y3JykqZ1g8VjbmacTc2Ma9YCmcrefWvqx9YBOgXt7nCEEGVsEP5PEoaL9R4ujMq/v/g5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r04KUKjd6JtLjhoEL5EPVQAhqHsl2Ek0yDHAo9qbZlM=;
 b=Ag2ckEsA7GX32rp4lduD3yZUAKuE3280joL3kxCRmYanLshSb+lqB8G61vFf/5/D32ux7KWyRnE4XXG1h8WFW8UG2r1SZxr54gwbHmn9d5VK7MpyLe0OiObdeWqgNElMxUItxyFKb/bNFgJyYZzQLsP1zUJpzZkpNxMEz104bnlWnXiiC5LhZ/l65bVtnwrDYkinDIMfQ7ikk284Yl3hlYL2QCFDV//Y60HjF7fAQQOW+QdNsaUNXuhgdeWPEstB97H+Q6OhYahc+QBHS3ADqfm9KC6QyadKF9JV2tjbHPuzwQfQRu8B5KZzlDckZmAGLn5rAKp+pQ9KYDTTy2kMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r04KUKjd6JtLjhoEL5EPVQAhqHsl2Ek0yDHAo9qbZlM=;
 b=uUb+NsLuU5HYJr5ciPKKoskCg5kCvvNSsqEftC4pqMxeUM8vJ7YMHzF69gDl9tWxju7/pJRX2x3ZYgys9aJWTx7lQn030y0CeXZv2bJenn2rEdm3O4Th8P/wLFxxBtaVIqQoHU/cV4r0/5gUDgqyclnTJTrMozx1+gYFn3Ris1V49f68xDcBgofZU/V3aOo3zDYLTTPO8J/fBoC8SKyaJXxhp3xacguE5zDZke/rPRsKxMUZ3sy1SidoHSt81vfYtXN7aSV5eKt7wEpQYTVtgd5TcruOH6zfctLagSzht4A64ddtGObKaWcwcFfFmH+2J5SmB3OkBiBp9T0h9Bx51A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Wed, 4 Dec 2024 17:03:21 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%2]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 17:03:21 +0000
Message-ID: <44e7ae05-2eea-4602-b192-dbd01631169c@nvidia.com>
Date: Wed, 4 Dec 2024 17:03:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap for
 non-paged SKB data
To: Furong Xu <0x1207@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, Thierry Reding
 <treding@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20241021061023.2162701-1-0x1207@gmail.com>
 <d8112193-0386-4e14-b516-37c2d838171a@nvidia.com>
 <20241128144501.0000619b@gmail.com> <20241202163309.05603e96@kernel.org>
 <20241203100331.00007580@gmail.com> <20241202183425.4021d14c@kernel.org>
 <20241203111637.000023fe@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20241203111637.000023fe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0515.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::22) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c13404-b8d9-404f-29ec-08dd14858e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDhhRjJ1REZvTWtrK1RGZXZWRU5tRiswYzJTNTNPUGowVktQbFBLaG0veTQr?=
 =?utf-8?B?Q2RPeFJZOTZ1RnNLWnExQUt2dWV5YXlJTmhnUUpBNGR2aVBNeUY5WDRLWUVO?=
 =?utf-8?B?MHp4cEpQRitHUUZkNkpUcWFmdUdsOTFmOUVZRlBWQ3pEVVYrc2xGZko3cUY4?=
 =?utf-8?B?blhpV0o5RUJkam54YUxjcnFjVVhjdFk0My9WY1c1TFNOWlFHdUlvRHJJb0Zm?=
 =?utf-8?B?dHJEbWRUZ3FlOXcweDBGTDIwa1FpQzFGR0xyL2EzeUNFQU1YUWRNZng2Q2pm?=
 =?utf-8?B?M0gwN1hSZlJ1M3htcnEwNWU0cjB6VWRhOEo2V3czUnlqQmdvbUR6L3UrQ3oz?=
 =?utf-8?B?N3ZUdVp6MGNBbTYxT1BNVStYUHcrSW8xVXZab2hhRXVpR3oxWHVkMEFSWWI2?=
 =?utf-8?B?NXRKU3RRV1lLLzlVajFHbnpiVWVpUTBrRXVNK0JOeG90U0I0YWFGdUZXTVE5?=
 =?utf-8?B?a1RoR0crTTc5aldMbUFtK0VzYnFlT1NON0loRlpDRXFEZUtwM1piUFdpV3Zj?=
 =?utf-8?B?N3NnaUZaU29oamVtUWFKdW5xUTlwWUJUNzBTMHB6eWIzVzdxNktkRXo3dU9G?=
 =?utf-8?B?TlhxK2J5VkROM2NIUHFFcDJvdlIzWlZEWS9PVEwycjZ1VDVDNjZqbDZMVEQx?=
 =?utf-8?B?WjlWWkhuUXdIdjcybWViVHY1MEt5a1k0b1dOZWQwS21pc1ZybDdqQmpJa3NL?=
 =?utf-8?B?bmVqWFVXbDVkWWQ0WitUb3hjb05ma1luT1h2cEFiaXdHeDVhNHRKdjlCa3JW?=
 =?utf-8?B?ZWY3cnNEeHVxVFZJTG5NeUg5WjdzdjN3dWw1Vmc5Q3d6SGVtTzZlcUN2WGt3?=
 =?utf-8?B?SXp0aWVFYjRSQ3RGQk9OT043RllDZXRWK1lKekxvWXpJMWxFdXdYK28xVmFL?=
 =?utf-8?B?dkFMaGNqV0FaRlA0WlpON0RBdnpVYTBHb0JORkZRSTJPdWszRmZVNGdIMXMv?=
 =?utf-8?B?MzdFVVVJUk53MXk2MzJrejM2K3VUVHdRbWlINnVGSDFPMnllNnJGbmRaUm52?=
 =?utf-8?B?a20rZC9lRUsxVEVSMlVxZkNZVzArS0ZTZTVGZzJkL1EwbnFPamRGNkVQbWRi?=
 =?utf-8?B?OEhmaDVCSEJYdTZ4dUVaLzljYWsrd1dMU0NsaWVVWmh0QUU0dVVqd1RDUE5o?=
 =?utf-8?B?VWhERStsM1prYzJRWDkxWVFjb2tHWDNqSTNuUDlVWis4UU9FdDBHUlJPcERq?=
 =?utf-8?B?cHdsb0t2YjVZcU1lOXJHMll6ZXZuTGtzMnI5WjJtOFpMN1JjQzVuSGcrSWhj?=
 =?utf-8?B?YVlCMjZWMm5uMUxzNmozcUNKcjl0Yi9MSnkyNmNsSmNiRndxc1dIa1ZhVTA3?=
 =?utf-8?B?ZWJhVnRsTVRQTGZ3YWhiTWFHekZuOHpzcXgxZWdnUWl1R21KUDhWb0tNSXNQ?=
 =?utf-8?B?L1Y5c1dUcmQ0cSsvNGN4VzNhdXJEdTl3QUVtZUIxRVJjSzdFMSs4YmlURENj?=
 =?utf-8?B?OTYzMy9vK2NybFN6SkVNbHNOdUNHZWJmbmFBRFVmL05DTDZnUlFuQzExWi9x?=
 =?utf-8?B?R3dGRFE1b29IY3JjRnJ1Y3JFNDdicUpPbXZ2ZVFhQzFhTWhMTnFlQytST0pm?=
 =?utf-8?B?L1FVcTZMTUVHWjVIT0lmWU1xSDhENGo2QklFMk4zSjJ6OUJSbXI1VUVSWUFJ?=
 =?utf-8?B?WXJxWVBzUWNqTlhndlFMMXZSRUlmdFBEK1NNM2s3Z3oxRmtVenVBcURBelhJ?=
 =?utf-8?B?KzhGb3pyb2QrSkthSHc2TUVjZ1l6YWRYTno4Z2ZTYTFiL1FmVk9yY2NoWEhx?=
 =?utf-8?B?dUhncDVMcUpjbDZwbXBDK3YrM2JRcVNFN2cyQmpOc2VIbWJzVHZLM1hWbFUv?=
 =?utf-8?B?SjA5d3dkQ1F0SDdvL3J1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1paV0VzL2VZS09tYUNFZ1RMd1FEQXVnNGt0TGVpdXFpT1BtWXhlajlOTWE4?=
 =?utf-8?B?YTFLbXF4eWhMOFJxZ29MS0hNZUF6Nk9JYlZHVUpJK29PbHpSaHN1MTRuK2RJ?=
 =?utf-8?B?cFpmQmt4dkZjb0tBcVFwWml0NHo0aWw0QUxCbXdoL2RTTTN6L0t2SFNhNGVF?=
 =?utf-8?B?Nm0zY1lvSGhKVTI0MUpLV3lUcUU5cUpkSkZuSzh4V2FQbjVVa0FMTGp4NUMv?=
 =?utf-8?B?WCtaWlJRY3BrcDVyaXpXcVllK1VqNzdzTk15eVNaVmxBS3g4K09pczJDN1JB?=
 =?utf-8?B?V0o3RVUveDFRWVREbTJPN0ZjSTdjUFB1V1EwT3FuUktxM0FoSDdUZ0NPNGdK?=
 =?utf-8?B?MW1yZjcrTklsU0xXbkIyYWtJWU1YNVo2UWFKNE9aTU8wRzVyb0hxMjJic3BK?=
 =?utf-8?B?MkE3Q2NFbWdaMW5sS3R4eWJBVXBFK0xveTVKYmJQYVBXbXJxS3psSmgwSjha?=
 =?utf-8?B?cmVqU1pqTUlJU04wVmJvdVNxWHN6M2Z2MGswRWI2ZWFpc0RqVGNKYlJFZGhV?=
 =?utf-8?B?R0NoRTY4MU5RaUw4QTFwWUdTVERKeVI1VDJscEhkdGg1M1BtUC9EZk9rQ3Zo?=
 =?utf-8?B?b3dxSWdRVU1Bd3NIUGxGNEczY0FNM29pR1AvcFhJek1mTm9PcUgzeFgzZzky?=
 =?utf-8?B?aVJ6cmpMd25KVVdlbFRGR1BZTGlBbUQ5M0owbHRoeE5HaVJvUXN1bWdYQ2RG?=
 =?utf-8?B?UWQ2ak0yVmo3NGllZWFtc3ZITkg1L0FGcHlrK1JQU3ZIRUpGZGJIWkpPOVda?=
 =?utf-8?B?ZHpkYnNFYk5vUEhkdC8rSFl1NHFrSTFlR2RBcWtzb0tvWEgzSVhWdVREVXA3?=
 =?utf-8?B?b3N2OVlDVjlzbC9LbWdHa2dHV21pSGJzRkhIV2JHL29HaCtwbXA4aDlYZTF6?=
 =?utf-8?B?dlZBY2piL3FyWFg1SDlxRmIwSXRLQk9pejFxUFZQN2krTjBHdEVGNDk4eXNy?=
 =?utf-8?B?WlJJOTlneUxKbFdFSUdkd2haQVFJRFNzbnVYN0dMVkx0R2g2dmNBM0t6U3dI?=
 =?utf-8?B?WGZRd2ROWTFzMU1MZmo4R1drdVlRaWsrYUxjdG1Zb1ZFZGlZK0RWNmsrMTlQ?=
 =?utf-8?B?QjdjYllUYkFDZWVzWkNhWFYzd204RTM3Mlk3c0k3YUJ6cG1TY2J5WVdVVkRF?=
 =?utf-8?B?UVpGd0ovajJWckYwak5DeTBkTkhwbHU1M0RETkdpWnBKR2MzdEpxNDEzYXJR?=
 =?utf-8?B?eVgxV1pmcnQ4ZXBZU2Jva2NDK3ZUS3UzSkwvNkhZZXo5YUQxbElmQm5PSXNM?=
 =?utf-8?B?S3NqN1laNUxSWkVRRXJlSDFqUmw2eFBxRk1xK3RlNUk1aFdnMTA4ZkJsQ3RR?=
 =?utf-8?B?UU1NaWtvNVJMNXFpbENXQ08xUHhyc05keW14NDB6SlVQU21UOTBFalYzeDEy?=
 =?utf-8?B?YjVpamlwUVFHMU0xb095V2tOdGR0ZExWRG1yZHYwL0lyWld1RmJUeUtlaDAz?=
 =?utf-8?B?MzBpRHF0U1JUK0M2dmRnSWlPbVB2aDRQb0oyR2Y3TlZIUURlZi9LWnhIaW1C?=
 =?utf-8?B?elRuaGZ3WnRtYnBUUnZVTGlWQWFLQWVnTDhMNEJwOVROMEM0a3h1cmNFaXJI?=
 =?utf-8?B?RTZGUXU3M1I3TERZcmVwbGltZXFwVVB4S0M4NGFNZk5WWnIzQnBTWG9JVGsv?=
 =?utf-8?B?MFZMZkdlTThnWHdOa0VOb1VDWmhwSXJFT1Z5MDQwb3hFWUxsYk1LZ1FOVFVa?=
 =?utf-8?B?THFZS3MxOFA5Y0JkQUVnN05uOXV5aHhjb1lzeldQVU1Gak0xYWtOLzRrdGhM?=
 =?utf-8?B?VktCQUJON2pvbDFEaWlyYkp6YklsM1FCaWlPVVNNVGFjOXFydTZYWjZZN2hX?=
 =?utf-8?B?UW5SdUpwNkRWS242bXRLNTVlcmZFRGJ3T3h6TnZuZEErL3FHbFE0VHF6ajF4?=
 =?utf-8?B?NnExZElVSW91RUV4akdsdWYrajdibzdTTlNnVUZ2VGV2Q1hKSFNad1AreTd1?=
 =?utf-8?B?blh1T0E2WHpVNnBQRWxNeis2b3dMZktYcVNOcjY5S3dQK0MzbHpJN3JuUVo4?=
 =?utf-8?B?RFpzRUh5UFczTlhQbklxNENrYjM1Q29qSWZzUXl6ZEtPU3JJZVAxTk5GSDJE?=
 =?utf-8?B?UUcxdjA5TjJpOFR0QmFvS0F1RExzOS9sMTl2TGx0Yk5oRXRXRWNTTml5ekt5?=
 =?utf-8?B?YXFzYm5kY1V2MXBnci9Fc0xqUGNidFRLKzdMZFdzSmJLZnJxQVlyWERoS2RN?=
 =?utf-8?Q?NeZdU/95Snuh0kfeP+1wMaQkVNlBkjdjXHXNAocX4SSC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c13404-b8d9-404f-29ec-08dd14858e5a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:03:21.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7ZeBFLC2yXEwFdYyzHpsrF66hdTb4UyrZeb1djtIrOaH6VwpywnB0JKvHTUEMR98eNIYPlDvgYdnAmmNJjhbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592


On 03/12/2024 03:16, Furong Xu wrote:
> On Mon, 2 Dec 2024 18:34:25 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> 
>> On Tue, 3 Dec 2024 10:03:31 +0800 Furong Xu wrote:
>>> I requested Jon to provide more info about "Tx DMA map failed" in previous
>>> reply, and he does not respond yet.
>>
>> What does it mean to provide "more info" about a print statement from
>> the driver? Is there a Kconfig which he needs to set to get more info?
>> Perhaps you should provide a debug patch he can apply on his tree, that
>> will print info about (1) which buffer mapping failed (head or frags);
>> (2) what the physical address was of the buffer that couldn't be mapped.
> 
> A debug patch to print info about buffer makes no sense here.
> Both Tegra186 Jetson TX2(tegra186-p2771-0000) and Tegra194 Jetson AGX Xavier
> (tegra194-p2972-0000) enable IOMMU/SMMU for stmmac in its device-tree node,
> buffer info should be investigated with detailed IOMMU/SMMU debug info from
> drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c together.
> 
> I am not an expert in IOMMU, so I cannot help more.
> 
> Without the help from Jon, our only choice is revert as you said.


Sorry Thierry and I were digging into this offline but yes I can provide 
any more info that is needed.

Jon

-- 
nvpublic


