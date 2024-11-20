Return-Path: <netdev+bounces-146503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4035C9D3CA6
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6450AB26E44
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9A1A9B48;
	Wed, 20 Nov 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MHoYCA6V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF619D8A0;
	Wed, 20 Nov 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110086; cv=fail; b=lleYwo76YCb0+EEm3L4gEBr3PfyxWQGiIsRXQsnRey9AqP0sUwXmD7hkdPHW90JiDtsEQgCSuzOZemvI/BUZVJhdFwD2TRkgi1h987G0blHE6ah8LYeFw2toE97w14mR4UL6u1FZfiwaBV34ndmHMM+SwntE6iD3kw80WbmB1pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110086; c=relaxed/simple;
	bh=rqkjKRWZvvt+WYDPNMZ7xy8EYENMNagbuuMIGNSMMYc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OQ+hjZvr3MUlby+vq9+xZWee46YZxhTocV7dKTiW6N3pplhSQMyWIWlGGCOCiXkK1lNBMUUGMiCLFCCFc/8U5fY1A92spSRNXV/Nhz8dz/HAW4GB24f/Kw7adOtvc4RXv5gXr7w7Cf/3c2OP/szlMqNsGbDvel1e3u2fn7M1SY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MHoYCA6V; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyEqn6ClVZoWiUyZ8353d/Zlh0rLrXm1uCW8d56xWmmnO4GToaW4ro5F427VWCTE6qiyLCLitw0OyFWJ1HtAIlR5caQUGPExgbGYpGrO5H2JImULMK43V5t2ZVhkFZZ08ZveTpWSltMvqBfJnhLZVYvKAi5io4X3QaaEX5h5ZEJu9fm9SjkGvGVUqT5SBP/zJOVYj33xJ6lfAUF0y7zq098Cd03bhztnmv8ObLJE2FfvaP217Eyf8rzxeziwLqLtzUgOeqoHeXZxgHfoEZjS+IUI0lvpBnrt6iZbFk7ztWAHUpZZTp9WgfspRNjEaQH817VnW8fPJlo9Shok2LRS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ud0WT2a94N/2kFpZCRBkKcb/RK48StfuPlPh/I2z3cc=;
 b=fJEsIpLxsLZDgGdXZjJL1EIutuiaVIEv4sveJT8KLLeqHfHrJoRqbxLiGwajZdNvC9CcQMC+lJswIMzaDlM314L7SwGdR/B3MLmzKevEzAy4eH80b/szlinBj3VTZdliCl3nsPBG8s5qqLM1rZNftN+VEuIOGnPuwBxUxZD+29iLGZICMzXq02aN1LdhXOzXH2dsJAfW48G34knEE3n+MUWgQTl9g4/Dd6cs9dYPaobqoW4tlNIuzCdqH48W/ZC9qCGKXGSawQ1tIQ0RDwf5SbpXELPRTWfpXw32bEkxRDyjK2w65J6Seb89Zv1Px2jk3TLq5gVjKbOazMYJBztwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud0WT2a94N/2kFpZCRBkKcb/RK48StfuPlPh/I2z3cc=;
 b=MHoYCA6VB2yWHNF0tEaEbH41Ea7ymuBvbhwd9gBSUT7GVX8uYI4hawbl00SLlkaHP75CUlc+PavC+Hr2fc0Koho6yB6cxNiRQg1PVx+9suQ/uK6RCv0yJR7IcLyTQYV6EFtLlMquX2Gc1j/rth02fZDl+oX5XnBS9BGqvaD+NXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:41:20 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:41:20 +0000
Message-ID: <f0ea2714-9684-ef60-1bf1-20c6add5ff03@amd.com>
Date: Wed, 20 Nov 2024 13:41:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 03/27] cxl: add capabilities field to cxl_dev_state and
 cxl_port
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-4-alejandro.lucero-palau@amd.com>
 <0ca7d9ba-2d01-4678-b109-ca49091266f4@intel.com>
 <7c988754-fb25-bd8b-49bf-b0dae845e81c@amd.com>
 <bfd5e93f-6250-42d5-bf13-b0d57c26acfd@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <bfd5e93f-6250-42d5-bf13-b0d57c26acfd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: e71a1983-c4c1-408b-da31-08dd0969041d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WiszaFpaS1QrZWNieXpkYnJ0WE1STm1PbHc3T1dZUzFZcitpREFHTnlWbXZr?=
 =?utf-8?B?c3g5VmZsVFlNNE1Hay83ZWJJY3N6TjNGSFZUS0NxcURyNTVTYmQwY01zWEYv?=
 =?utf-8?B?RnMxRnpwNS9ZajNLSGIyd3VmblRNV2pESXVESmFHdTc5bHExUEd4NEhaMFkw?=
 =?utf-8?B?K1g3RU83aVBNSnk1aUVCdnExNWFBQ2ZXamxDenFialZyU3dZRnpzUnkzSUkr?=
 =?utf-8?B?L3M1azhJa3FsNlk5TjduZUsycWxiN0YxNVFqSXcxd1JNUWlQNG9HcG9LOTg1?=
 =?utf-8?B?STU1VFk0U0txNmEzTWpFYWFzd0o1eTZtd0ZlSzdxVmYzd1RkM0paL2tFU2t6?=
 =?utf-8?B?YURRcHJ0YTljTFhRaS9hdkZzd2Fuc0grcmN2Umx0eG5PcG1nSTJyUW5jZU85?=
 =?utf-8?B?bnU5bUNGVkl4dGVtUWpTcFM1UTdxMlVBeWU2alRxcmlFZGJTMWxraVRTT25o?=
 =?utf-8?B?UW1VZk5DZWVsd25KaFFibHhhb20zU0JlZkxrQmt6QTR3L0NpVzNpUVlyOVlX?=
 =?utf-8?B?T1RlRFBlemg4cTlTYkRGbUlsRkswckJXWEx5Vm96cXFCa1hrTVdwUlduTzlw?=
 =?utf-8?B?MHdmWkVBbjYrdk5ENURhREhNa2pnMmlNOUZXelF1UDdqYVpnYUwzYVlmOFNR?=
 =?utf-8?B?OGdOMVRPbnBSeCtqa0l1ZDRvWTJTWUdZV3lMdzVaV1FsZmhyVG5YeEFkemVj?=
 =?utf-8?B?c2RjOFBnTjRIK0V5RHpFY0ZrTWQ3bWhPOXdXT2QyRWRFOERLVyt2a3dJOStj?=
 =?utf-8?B?WnViVWVPTm5LNlhvSE9tNEd2WnBNaTAyVGRZRmFib0dodVJUL2hyUXFHRDNP?=
 =?utf-8?B?MExqblQrdUNvTVloQ0h1bytzdkJmSjUwckNVRHZMc1RtSzVNVXRQakUxZDlW?=
 =?utf-8?B?WmlFdnduNzFaYWdYZnYzK213aEYwWnN2UE5UUm5rUjZGSjhBRVV6dEZPVGhT?=
 =?utf-8?B?MEV0Vlc3WFJNZ2U5MXVqUmNKYUdsRVc5STRwZjZLRlk4eVhNSVF3c3B1SVgy?=
 =?utf-8?B?TUlCb25iVDZZR3VEZFkxdzhkdzRpTERxOERFUmJBTFhYa1BuVWlxSWR4ZU1r?=
 =?utf-8?B?YjZIVVhQblZrbnh0eFF2aTNCbXRMNms3T2RadkZ3dGM2SmNncDhOSldWS0Qx?=
 =?utf-8?B?Uk5ZSnllaUxXbnRuT3FEczNJamQwVkdvbENaTzUrZGVIV3gzVGxMcFlZQ2ZM?=
 =?utf-8?B?WTJJSXprL280MFFKKzc0NVp3cVdaOFV6T1gxSjA5MENkZXpmZzdYcmJOci9X?=
 =?utf-8?B?RVp1RGg4SWpGM0JpbkxCbU9YUnRkVmtKUEpzeVJJdjJKSjNGQlphNEtCMy9x?=
 =?utf-8?B?SjMrS09uT3p0SlFZOU9BTzJmNzdzL0U2ZjFEZmsvaXgyREhtM2dUZUwvYmI5?=
 =?utf-8?B?cXRFMktadjM4bFQzUXEwdHBZVmgyZzBoREhOcUJVT3VRWkpWT2pyQjB0bHNj?=
 =?utf-8?B?MkFoelF3dmVUSnMxenBFanVDUnZPOHFnYm53VGpKQ1VjN3JTci9FdW1ZYTZM?=
 =?utf-8?B?b1ZLNG1aZU5mK3ovWm9MbjMyUTZ3RVVXTW4zV2E4NTRlZCtOMXVxcUh0VHVU?=
 =?utf-8?B?M0kyVEhQekFRdm5TZWdEZ2dtZnJPUjE4UG1wOXFIak5Yc2tWaUloMEZLSDVu?=
 =?utf-8?B?QnorRkxsSy9ndTN0QWFNOEJsQzBDY041Ym9xb2NCRVBjc2poaC9lOXdkNWo1?=
 =?utf-8?B?ZnlDcmJVVkJVcW0yQUc2aFRXcWJqWlFxTFZmVUxjYnVRVjZpNXZmSUo5QUt3?=
 =?utf-8?B?NVpEblpLcDZoMktXVFpMQlhRUmd2VGF1UDZZdmd1Tm45OGVtWERocWY3Q2sw?=
 =?utf-8?Q?8T6DCU0CE0MfUhm0G4oQy4u6vbupjMxPZvmQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3R5cHhpNG5SNDV4UDUvL0xsdjdiem1ORlNqTTlKaERYeXpyVU40bitWU0J0?=
 =?utf-8?B?TkdzQ1ViY1RiR2RFWnJmYkw1MndwUVh3UEMwbU5NSlNFZDRyZnZodGJBWGhM?=
 =?utf-8?B?WjBhZUFaVzFtVTlVOCtkdVNOQkNBMUZ5OVZOSXZmMXg5aUFxYnpZZVBpVDdT?=
 =?utf-8?B?STZGZTFPalhoYzhoSk96ZGd5MWJ1ZGNraGZxZ3BjSzlLRWVpNXdUcEFwb1hp?=
 =?utf-8?B?eDdLN0UzWjVJeG92WElBMXdkcFNlVXZRMVJjSXBGSnRiYUhNbWJkbEUwbVhi?=
 =?utf-8?B?ZitrS0Rsa0IyNHQ2YWZCOExTdVBCeC9TR2Y4QXpYTnpIenZ0U09YMUN2WDlo?=
 =?utf-8?B?ZzFsU2dmanlmWFR3T3grR2M4L2cyTWcvakYyTC8zNCs2czNsVFJENUNxRERQ?=
 =?utf-8?B?QlNtNkdzN3lIS1RDRTM0Q2F5aVNoKzQ5RlBvVWU0WHRHRHZxb25Bd0xkU21r?=
 =?utf-8?B?U1hGZnprMEcxd3dtSXd4R0NrNEdhd0VwTGJ0bGhlTy96TEhDelJBL1FicWtH?=
 =?utf-8?B?R1VCd1l4WXJab1MwUWpwak9VTUFmcldlaEZRYjViS3l0ekFJRXZ4dWxKdURF?=
 =?utf-8?B?SlFIUzFVS0NUSWRVUUYyVEZYQytqV0dWVTdJMHFXd0F6aS9nUHZWNzhMMmpQ?=
 =?utf-8?B?YlFPSHo4RDlaUThuemwzRnhKVlhZVTRxcUVBOGhKSVhpVGZIMll4ZVYveElN?=
 =?utf-8?B?dXNTUENOdFZQS0htM3MwQ29GcVN6Q0s0cjhvTGtsRzVicXVpektHbG1jL1A1?=
 =?utf-8?B?MWdsTWMzeGoreWhvVk8ydFc0eWo5dm5tTjFnNERXQ1F0L2twVXdhOVZRL3RP?=
 =?utf-8?B?NHhSU1paZVV1K0tLTDJFYkF6Umlia2lQRjB6UGJHb2lLOEtwZWpqZmtLZFh0?=
 =?utf-8?B?aXZhQmxrYmhDNkJYS3VBcnh0MnE3R0N4RmVhLy9NUHQvazd6ZXMvMFJ6clcr?=
 =?utf-8?B?RUZNYUFkMEhvUGNKM2YrSFFqNFNTdWIxUlpDMXBhWHJPbWdGWU5sdU9zdUJ1?=
 =?utf-8?B?RHpvaktXNEYvRnQvWlY4UXpKNHhBS3FHZzE2L3hBclpBRWhqMUNHakNGNEw2?=
 =?utf-8?B?QzZvd2wzWERPb09hVjY0WU5QT1hsZzhMMWZtNVVSTDFLVDAzRUNZMVE2eDhQ?=
 =?utf-8?B?eWtOOFNiN0VmOGVhbEtJUUExbnVnUlFuS3B5WlI2ak8zbnZEUkxqWHJlWlFp?=
 =?utf-8?B?NU1FckVKcUVaTUtGU0JzNFYrNGtzQmxpYXErQmpMN1FOV1hBVTJtbEpRdnBL?=
 =?utf-8?B?UGMvenRlNTJHZHpSYmV0Q0VaRTNueVBDVWpXMHk4enFrL0JqVWtpTEhUd3dS?=
 =?utf-8?B?RG55SDhCdUxETG5CRTI2U0VtclZOdE1kWFJKMDd6ZzlVUzlJOUo4UGEvS2p5?=
 =?utf-8?B?OVFMR1MxVDNKRSttSGc2emFMNm53T21xS2xOSkxESGJGRURhMmRWOEo1RFNy?=
 =?utf-8?B?UzJ3bTlENlBZaUZvbTAxYzRlUGhjVEhRTzdTUHFjWERib3hKeUx5QXY4YXp6?=
 =?utf-8?B?aEhDZlp0OVY1Ly9QNzZ2TWtyT3JLZWtCT0d4d2FBZXE0Q3dTaHVkU3ZxOU80?=
 =?utf-8?B?Nmg0a2FTRXVnb21SWnRML2x4czlaK0x2dVc4Y2F2bHcvN21JUlZ6U0JIbEx4?=
 =?utf-8?B?YzZselZSaEhzY2w2eXBBYURBM1pyeG5KYXpEZ09jK0kwUXlRbWZ3akx6V3pZ?=
 =?utf-8?B?UkZXOEdxUkVlZVU1cmZucGM2cGFkbk9tMXBvcE1zT0Y0UmJlNWhvODhaWVRn?=
 =?utf-8?B?a3dnVnRnN2RnK1ZwdnVVTHk0SGdzTXI5Ym96MjZFVlFYbDVDR0RkVHRwR2Ji?=
 =?utf-8?B?dGdUS0VYa0RDaEhWSmxUbElTcmcvQ0pHOGxKdXJRYUk5dSsrd0JYallrMG1Q?=
 =?utf-8?B?d3ZaT0o3RzFTRGw1RTQvcndmbE1zZlFpTlJpUXMzaElqNnN2K1B1RllGNWNC?=
 =?utf-8?B?NHk0aWpmM2ZGRlVSOVlvOC9QcnpDYXFxemsxRDlLWkJkQzM5b3J4UEhQQzI1?=
 =?utf-8?B?LzRqY04yNFdnTFpEdUt1OWh6MkNBRVUxbGQyaGYxNU1XZDJxbkFjTUZXNy83?=
 =?utf-8?B?UlhSTjdDeHRWTnNvbWpCSnhpSmZ1WmlZeVZJUGdtY1BZRXp3ZUFwKzAzK2Ux?=
 =?utf-8?Q?pP3nNxVn8XO/+k5Iw6RfWK6qe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71a1983-c4c1-408b-da31-08dd0969041d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:41:20.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OLUmKtjjA1QiaBbCLq0KIqKDVnn2FZK7YhCvi4H0GrAdBTmiPvzkDSfNsKPqey/eWCKNif5XyHZq7BumlJxQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026


On 11/19/24 15:53, Dave Jiang wrote:
>
> On 11/19/24 5:28 AM, Alejandro Lucero Palau wrote:
>> On 11/18/24 22:52, Dave Jiang wrote:
>>> On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Type2 devices have some Type3 functionalities as optional like an mbox
>>>> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
>>>> implements.
>>>>
>>>> Add a new field to cxl_dev_state for keeping device capabilities as discovered
>>>> during initialization. Add same field to cxl_port as registers discovery
>>>> is also used during port initialization.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> ---
>>>>    drivers/cxl/core/port.c | 11 +++++++----
>>>>    drivers/cxl/core/regs.c | 21 ++++++++++++++-------
>>>>    drivers/cxl/cxl.h       |  9 ++++++---
>>>>    drivers/cxl/cxlmem.h    |  2 ++
>>>>    drivers/cxl/pci.c       | 10 ++++++----
>>>>    include/cxl/cxl.h       | 30 ++++++++++++++++++++++++++++++
>>>>    6 files changed, 65 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>>> index af92c67bc954..5bc8490a199c 100644
>>>> --- a/drivers/cxl/core/port.c
>>>> +++ b/drivers/cxl/core/port.c
>>>> @@ -749,7 +749,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>>>>    }
>>>>      static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
>>>> -                   resource_size_t component_reg_phys)
>>>> +                   resource_size_t component_reg_phys, unsigned long *caps)
>>>>    {
>>>>        *map = (struct cxl_register_map) {
>>>>            .host = host,
>>>> @@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>>>>        map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>>>>        map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>>>>    -    return cxl_setup_regs(map);
>>>> +    return cxl_setup_regs(map, caps);
>>>>    }
>>>>      static int cxl_port_setup_regs(struct cxl_port *port,
>>>> @@ -772,7 +772,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>>>>        if (dev_is_platform(port->uport_dev))
>>>>            return 0;
>>>>        return cxl_setup_comp_regs(&port->dev, &port->reg_map,
>>>> -                   component_reg_phys);
>>>> +                   component_reg_phys, port->capabilities);
>>>>    }
>>>>      static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>>> @@ -789,7 +789,8 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>>>         * NULL.
>>>>         */
>>>>        rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
>>>> -                 component_reg_phys);
>>>> +                 component_reg_phys,
>>>> +                 dport->port->capabilities);
>>>>        dport->reg_map.host = host;
>>>>        return rc;
>>>>    }
>>>> @@ -851,6 +852,8 @@ static int cxl_port_add(struct cxl_port *port,
>>>>            port->reg_map = cxlds->reg_map;
>>>>            port->reg_map.host = &port->dev;
>>>>            cxlmd->endpoint = port;
>>>> +        bitmap_copy(port->capabilities, cxlds->capabilities,
>>>> +                CXL_MAX_CAPS);
>>>>        } else if (parent_dport) {
>>>>            rc = dev_set_name(dev, "port%d", port->id);
>>>>            if (rc)
>>>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>>>> index e1082e749c69..8287ec45b018 100644
>>>> --- a/drivers/cxl/core/regs.c
>>>> +++ b/drivers/cxl/core/regs.c
>>>> @@ -4,6 +4,7 @@
>>>>    #include <linux/device.h>
>>>>    #include <linux/slab.h>
>>>>    #include <linux/pci.h>
>>>> +#include <cxl/cxl.h>
>>>>    #include <cxlmem.h>
>>>>    #include <cxlpci.h>
>>>>    #include <pmu.h>
>>>> @@ -36,7 +37,8 @@
>>>>     * Probe for component register information and return it in map object.
>>>>     */
>>>>    void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>>> -                  struct cxl_component_reg_map *map)
>>>> +                  struct cxl_component_reg_map *map,
>>>> +                  unsigned long *caps)
>>>>    {
>>>>        int cap, cap_count;
>>>>        u32 cap_array;
>>>> @@ -84,6 +86,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>>>                decoder_cnt = cxl_hdm_decoder_count(hdr);
>>>>                length = 0x20 * decoder_cnt + 0x10;
>>>>                rmap = &map->hdm_decoder;
>>>> +            *caps |= BIT(CXL_DEV_CAP_HDM);
>>>>                break;
>>>>            }
>>>>            case CXL_CM_CAP_CAP_ID_RAS:
>>>> @@ -91,6 +94,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>>>                    offset);
>>>>                length = CXL_RAS_CAPABILITY_LENGTH;
>>>>                rmap = &map->ras;
>>>> +            *caps |= BIT(CXL_DEV_CAP_RAS);
>>>>                break;
>>>>            default:
>>>>                dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>>>> @@ -117,7 +121,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
>>>>     * Probe for device register information and return it in map object.
>>>>     */
>>>>    void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>>> -               struct cxl_device_reg_map *map)
>>>> +               struct cxl_device_reg_map *map, unsigned long *caps)
>>>>    {
>>>>        int cap, cap_count;
>>>>        u64 cap_array;
>>>> @@ -146,10 +150,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>>>            case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>>>>                dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>>>>                rmap = &map->status;
>>>> +            *caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
>>>>                break;
>>>>            case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>>>>                dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>>>>                rmap = &map->mbox;
>>>> +            *caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
>>>>                break;
>>>>            case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>>>>                dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
>>>> @@ -157,6 +163,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>>>            case CXLDEV_CAP_CAP_ID_MEMDEV:
>>>>                dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>>>>                rmap = &map->memdev;
>>>> +            *caps |= BIT(CXL_DEV_CAP_MEMDEV);
>>>>                break;
>>>>            default:
>>>>                if (cap_id >= 0x8000)
>>>> @@ -421,7 +428,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>>>>        map->base = NULL;
>>>>    }
>>>>    -static int cxl_probe_regs(struct cxl_register_map *map)
>>>> +static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>>>>    {
>>>>        struct cxl_component_reg_map *comp_map;
>>>>        struct cxl_device_reg_map *dev_map;
>>>> @@ -431,12 +438,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>>>        switch (map->reg_type) {
>>>>        case CXL_REGLOC_RBI_COMPONENT:
>>>>            comp_map = &map->component_map;
>>>> -        cxl_probe_component_regs(host, base, comp_map);
>>>> +        cxl_probe_component_regs(host, base, comp_map, caps);
>>>>            dev_dbg(host, "Set up component registers\n");
>>>>            break;
>>>>        case CXL_REGLOC_RBI_MEMDEV:
>>>>            dev_map = &map->device_map;
>>>> -        cxl_probe_device_regs(host, base, dev_map);
>>>> +        cxl_probe_device_regs(host, base, dev_map, caps);
>>>>            if (!dev_map->status.valid || !dev_map->mbox.valid ||
>>>>                !dev_map->memdev.valid) {
>>>>                dev_err(host, "registers not found: %s%s%s\n",
>>>> @@ -455,7 +462,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>>>        return 0;
>>>>    }
>>>>    -int cxl_setup_regs(struct cxl_register_map *map)
>>>> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
>>>>    {
>>>>        int rc;
>>>>    @@ -463,7 +470,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>>>>        if (rc)
>>>>            return rc;
>>>>    -    rc = cxl_probe_regs(map);
>>>> +    rc = cxl_probe_regs(map, caps);
>>>>        cxl_unmap_regblock(map);
>>>>          return rc;
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index a2be05fd7aa2..e5f918be6fe4 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -4,6 +4,7 @@
>>>>    #ifndef __CXL_H__
>>>>    #define __CXL_H__
>>>>    +#include <cxl/cxl.h>
>>>>    #include <linux/libnvdimm.h>
>>>>    #include <linux/bitfield.h>
>>>>    #include <linux/notifier.h>
>>>> @@ -284,9 +285,9 @@ struct cxl_register_map {
>>>>    };
>>>>      void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>>> -                  struct cxl_component_reg_map *map);
>>>> +                  struct cxl_component_reg_map *map, unsigned long *caps);
>>>>    void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>>> -               struct cxl_device_reg_map *map);
>>>> +               struct cxl_device_reg_map *map, unsigned long *caps);
>>>>    int cxl_map_component_regs(const struct cxl_register_map *map,
>>>>                   struct cxl_component_regs *regs,
>>>>                   unsigned long map_mask);
>>>> @@ -300,7 +301,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>>                       struct cxl_register_map *map, int index);
>>>>    int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>>                  struct cxl_register_map *map);
>>>> -int cxl_setup_regs(struct cxl_register_map *map);
>>>> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
>>>>    struct cxl_dport;
>>>>    resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>>>                           struct cxl_dport *dport);
>>>> @@ -600,6 +601,7 @@ struct cxl_dax_region {
>>>>     * @cdat: Cached CDAT data
>>>>     * @cdat_available: Should a CDAT attribute be available in sysfs
>>>>     * @pci_latency: Upstream latency in picoseconds
>>>> + * @capabilities: those capabilities as defined in device mapped registers
>>>>     */
>>>>    struct cxl_port {
>>>>        struct device dev;
>>>> @@ -623,6 +625,7 @@ struct cxl_port {
>>>>        } cdat;
>>>>        bool cdat_available;
>>>>        long pci_latency;
>>>> +    DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>>>>    };
>>>>      /**
>>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>>> index 2a25d1957ddb..4c1c53c29544 100644
>>>> --- a/drivers/cxl/cxlmem.h
>>>> +++ b/drivers/cxl/cxlmem.h
>>>> @@ -428,6 +428,7 @@ struct cxl_dpa_perf {
>>>>     * @serial: PCIe Device Serial Number
>>>>     * @type: Generic Memory Class device or Vendor Specific Memory device
>>>>     * @cxl_mbox: CXL mailbox context
>>>> + * @capabilities: those capabilities as defined in device mapped registers
>>>>     */
>>>>    struct cxl_dev_state {
>>>>        struct device *dev;
>>>> @@ -443,6 +444,7 @@ struct cxl_dev_state {
>>>>        u64 serial;
>>>>        enum cxl_devtype type;
>>>>        struct cxl_mailbox cxl_mbox;
>>>> +    DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>>>>    };
>>>>      static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>>> index 0b910ef52db7..528d4ca79fd1 100644
>>>> --- a/drivers/cxl/pci.c
>>>> +++ b/drivers/cxl/pci.c
>>>> @@ -504,7 +504,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>>>    }
>>>>      static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>> -                  struct cxl_register_map *map)
>>>> +                  struct cxl_register_map *map,
>>>> +                  unsigned long *caps)
>>>>    {
>>>>        int rc;
>>>>    @@ -521,7 +522,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>>        if (rc)
>>>>            return rc;
>>>>    -    return cxl_setup_regs(map);
>>>> +    return cxl_setup_regs(map, caps);
>>>>    }
>>>>      static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>>> @@ -848,7 +849,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>          cxl_set_dvsec(cxlds, dvsec);
>>>>    -    rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>>> +    rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>>>> +                cxlds->capabilities);
>>>>        if (rc)
>>>>            return rc;
>>>>    @@ -861,7 +863,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>         * still be useful for management functions so don't return an error.
>>>>         */
>>>>        rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>>>> -                &cxlds->reg_map);
>>>> +                &cxlds->reg_map, cxlds->capabilities);
>>>>        if (rc)
>>>>            dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>>>>        else if (!cxlds->reg_map.component_map.ras.valid)
>>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>>> index 19e5d883557a..dcc9ec8a0aec 100644
>>>> --- a/include/cxl/cxl.h
>>>> +++ b/include/cxl/cxl.h
>>>> @@ -12,6 +12,36 @@ enum cxl_resource {
>>>>        CXL_RES_PMEM,
>>>>    };
>>>>    +/* Capabilities as defined for:
>>>> + *
>>>> + *    Component Registers (Table 8-22 CXL 3.1 specification)
>>>> + *    Device Registers (8.2.8.2.1 CXL 3.1 specification)
>>>> + */
>>>> +
>>>> +enum cxl_dev_cap {
>>>> +    /* capabilities from Component Registers */
>>>> +    CXL_DEV_CAP_RAS,
>>>> +    CXL_DEV_CAP_SEC,
>>> There are a few caps that does not seem to be used yet. Should we not bother defining them until they are being used?
>>
>> Jonathan Cameron did suggest it as well, but I think, only when dealing with capabilities discovery and checking.
>>
>> It is weird to me to mention the specs here and just list a few of the capabilities defined, but I will remove those not used yet if that is the general view.
> I think that is perfectly fine not to define them all. In general we want to avoid "dead code" in the kernel if there's no usage yet. When a cap is needed later we can add intentionally. Given this is just enum that is not tied specifically to hardware positions, defining them later on when needed should not impact the current code.


OK. I'll remove those not used yet in v6.


Thanks


>>
>>>> +    CXL_DEV_CAP_LINK,
>>>> +    CXL_DEV_CAP_HDM,
>>>> +    CXL_DEV_CAP_SEC_EXT,
>>>> +    CXL_DEV_CAP_IDE,
>>>> +    CXL_DEV_CAP_SNOOP_FILTER,
>>>> +    CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
>>>> +    CXL_DEV_CAP_CACHEMEM_EXT,
>>>> +    CXL_DEV_CAP_BI_ROUTE_TABLE,
>>>> +    CXL_DEV_CAP_BI_DECODER,
>>>> +    CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
>>>> +    CXL_DEV_CAP_CACHEID_DECODER,
>>>> +    CXL_DEV_CAP_HDM_EXT,
>>>> +    CXL_DEV_CAP_METADATA_EXT,
>>>> +    /* capabilities from Device Registers */
>>>> +    CXL_DEV_CAP_DEV_STATUS,
>>>> +    CXL_DEV_CAP_MAILBOX_PRIMARY,
>>>> +    CXL_DEV_CAP_MEMDEV,
>>>> +    CXL_MAX_CAPS = 32
>>> This is changed to 64 in the next patch. Should it just be set to 64 here? I assume you just wanted a bitmap that's u64 long?
>>
>> Oh, yes, I should change it here.
>>
>>   It was suggested to use CXL_MAX_CAPS for clearing/zeroing new allocated bitmaps instead of BITS_PER_TYPE(unsigned long) as in v4, and for that to work, CXL_MAX_CAPS needs to be defined taking into account the size of unsigned long, which is the minimum unit for BITMAP. For x86_64 that is 8 bytes. Otherwise the clearing would leave the upper 32 bits untouched.
>>
>> Thanks!
>>
>>
>>> DJ
>>>
>>>> +};
>>>> +
>>>>    struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>>>      void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>

