Return-Path: <netdev+bounces-97553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7D8CC1B4
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88B61F21A08
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249881AA7;
	Wed, 22 May 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sEDkZAGW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21DC757FD
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382999; cv=fail; b=nmOq2S8Vrnnl62oZI1w71JPH0grOsgv7eAKaw1vJzz/q/9NObAap2j9k20DRtKtykzZq3pnmIe0zqHPpjKV8uAPjMiCD7uC+VHfN7Tn3lUowI/ZHftZiW3RlbRRC+E37EA4+rFIDFHkKDMHEMh0tTND8uvI/Reskj3gzvXdb+KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382999; c=relaxed/simple;
	bh=hOMwCa88lfiJE8BtayF0/ZEowCwHbsEzdKBh2Tbcb8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TVbAYTDxRN3jG4KWh6RGnUsCGypJw72ea+IiyKqSEIEP3mEg/tmGKQVapsRpDw8mOrIx2yQP/aEseLOUDc4ocL8nPb+YpuvGGyWbygIeA5WMXWaDluQnweGcaAssAoNcVmraysx+bEiXnrViJ78hDkIIwG6rPEzaz7zIP8QNczM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sEDkZAGW; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9wH+bsY8zCnUPCIHDMBnO4/xI8A6vqkbQWvZ6ktsYzfKripq8td2pB1tWAPYPvsd4x7kQ3c+HNnErOJzLxgXE9BEN/irRPCpBFpDdr6XB+WuDtHFLnuJvDVXepivVNNeBLvJb+9kcCWSZ82ueZDDgSe1A4Z/5T8FC0lu1afE1hnhurhqSd/U0GLhACBUXdK/3bMjnVx4IEvlNehwRNrYg/PYGm4xBcHqKE9SQos2R3mnhmxUvZ2Bv+tDUBRSOj6JoHB9/+AmDGGykBSw0h4Fp2w37JA+J2zV7nO0EtdfcBLYeaoaTnBKrQOs/FmTClHX3cz+dJVe726nqVOjYwSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmMamWBOvtdvnm0E3/ps3GbhyGO09G4P0m46gTQB/UE=;
 b=N7YKVXe6h8/mk2cr2dfvr4ZCL5IBBPgxa+h6vZQVh0HTLugmByecPJ70hODogxKQYC7N3m0vf6wpR3yL3B3eYXdRULeZtDFugpK2HNcMRaP/WJQldISW8inJNlmr2vyeHPMj29GWRFrIMRvhoLhXxEGcK61NDA11qyYS16UxG0WyS6lzB7UbcyujN++fld8eJzXB5P/Y/KKNUdGBuj9z3K7uPFQU8w3OFVMEDnWnrjqA289RplDd1Ep+V1Nq4PGvi9LBLAlCaN9y0R8VNFxFa28RDYjfpyCeWU/9zCgUThlqj9gQoz8hww2r2RKVsr4e0ZnCRRd8EFN/IwFQbm1AFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmMamWBOvtdvnm0E3/ps3GbhyGO09G4P0m46gTQB/UE=;
 b=sEDkZAGWNJVisAqiAaMwBhtDR1rTQN5TuP61cnZU3euNHgLNb2nlYRxbL9I6kv9CBaSBcJnlYr2T0JB3wHtfPoRLAdczWHLtfsbwN9OzmHg0AS6J5bPw3Vdz8Lh//hYvhmvjmqhDwYUIeoAACbNhW2Wifi75PX5A7vW+5MEWjcBsi8ApGMS2cdAKV6baKwupc3FBIQS3FveoHouVjXeH/W3TmdTl3MyjG5g6q6bKZ3+q1Cg7GyskZMJcjJ8HDPVCoaontHQqmhp+3FGmlR31yzIIZEPxtNmFW5cw6/FX+M3mT0aRXWxELCXeUlojskbCxj1jM22oD7DTP2shBU7cdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 13:03:12 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::35a:28cb:2534:6eb7]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::35a:28cb:2534:6eb7%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 13:03:12 +0000
Message-ID: <62042356-d449-ccc5-1047-6bfaf90cbb8e@nvidia.com>
Date: Wed, 22 May 2024 15:03:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP connections
Content-Language: en-US
To: Paul Wouters <paul@nohats.ca>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: pabeni@redhat.com, willemdebruijn.kernel@gmail.com, gal@nvidia.com,
 cratiu@nvidia.com, rrameshbabu@nvidia.com,
 Steffen Klassert <steffen.klassert@secunet.com>, tariqt@nvidia.com
References: <1da873f4-7d9b-1bb3-0c44-0c04923bf3ab@nohats.ca>
From: Boris Pismenny <borisp@nvidia.com>
In-Reply-To: <1da873f4-7d9b-1bb3-0c44-0c04923bf3ab@nohats.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 009e91c8-31e3-428a-e4a5-08dc7a5f8904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWZRcE1rQlh1cWpXaUFSdVBCZmwvbnRqV1JGU0NBQVAvdkEwWHdKOUJrUHRO?=
 =?utf-8?B?Z01VU0xnUXhqRW5GN05tT1hCMDhHa3JUbCtPcU91WWRlV1BoNGRUQno5R1FN?=
 =?utf-8?B?QklvNXhPMzRmaHZkK1dQOTY3OE1FSjI5Vk55dExkdURsUmRmM0k4ZlJLZFdR?=
 =?utf-8?B?a1JsNksyZExhS0xoZGlMczJyNTVrZlU3UnB4dHljRks1VHlGU3lUM1JFMndw?=
 =?utf-8?B?eVk2ZzNyT0owOHRBRTNnQmdBSDY5T3ZjdTk1ZzNTb1A0K2FBWEE4RVlVRHA0?=
 =?utf-8?B?MC9JL2p0emsrSzR3Q1FVTlV0RGhXdExFcUhKenlhZjU0TUIwczE3bTdWT2xM?=
 =?utf-8?B?MHd5L3BCWWxCM015OURZUm5wVUR1NWl1emhUdzQzc3J0RjBsQWd4SGFFNnYw?=
 =?utf-8?B?b1pJVEZ1UFhjSm0vMGlHQ0hOS2FDZHZQengvK1ZISGNWU1FJNmlNUGtuK3Fn?=
 =?utf-8?B?Ym40RGluSW1zV2pXMWRpZHpKc2taTjJMRkQ4RWdnb0hmTU9hV3kzSmIyMm9J?=
 =?utf-8?B?bmxaU2cxLzF2K1NXQVF5ZmZWSUlNalJscjZmeTNtNndXTmRaZ0pSaHJ5T3pq?=
 =?utf-8?B?MGRCK3VZTGEybXZ2d25pOWJFd055N1VrMEpCUHZQa3Z4cHpOZTY2MlVpbW5G?=
 =?utf-8?B?Z2dMZi9sdFJQMkdwVzRnUlJXU0F4TFNDTUhZMHdrN0N3SzlKeHgzcFdsbnNK?=
 =?utf-8?B?aHB1Q2l4Vk0yb2w1aTROVU52Q1ZPSW02djhwc0pKci9udW45L0ZveEhmYlU5?=
 =?utf-8?B?T2htVkNpUzJUSDZmbGRjdGZRcWJlZmk2c0tmRmlTQ2MybGtlMVRDV2tBeVlm?=
 =?utf-8?B?UzJnaXg1ejQxdm16V2x2bFhGamFOMmNMU1lSN2E4WXN5UjByWGl5K0I0TVpo?=
 =?utf-8?B?S3p5Z1Q4UmthOUxuRXZweHFLV2c5OC9RSTM4R2poWWRMdEU1K3pkS3ZKODR2?=
 =?utf-8?B?S2VlUVNNWEpNNFlyMS9XSFNTd0hnY29WWHJEQ2YyWjRaQ3NVM2x4RFViRWpG?=
 =?utf-8?B?aXNFRDBTUGtLT3RLK05CZ3dwQUkwQkY2UkM5Q2o2MG1yZnZJQzlsSG03Tnlz?=
 =?utf-8?B?TW1iblROdGlMVUNjOGVieDdCZWRKQ2hQdXM0R1Y0VWJnbWRlVXZiWGxiOUJr?=
 =?utf-8?B?MVdhNk1Ib0taMERYbWJrejc0YTNxc3QvVDVTOTRWMHVXMmdFcHEzcm15ZTRH?=
 =?utf-8?B?QXBUc09SMEpwVFpaUU1hQWl4ZzNFdlQwQUJXWHF6VVlnSUlBS0hISlJNYjNC?=
 =?utf-8?B?VXJDalU0MGhsODVsWTNNeDhPTEZxYkpOb3grQURHNVh0SkdaT09IZitSaWRw?=
 =?utf-8?B?cmx2QzFYVHJxSXlSS3YrRzViZWdQR1VyRWtGT0xLZnc4RjVNVFh1dFArUEFW?=
 =?utf-8?B?NHpndGdiQTVBTjU4d1dET1hlVmIxVndUeVczc1F0USswV083bzBjRkRjc29z?=
 =?utf-8?B?aVh2V00weWloL3dLVzRoaFJqSUpBc1FTM3BsVG4zd3ZVVENCY1dZZ2FRdWZx?=
 =?utf-8?B?cU9lQ1cyekFMdVlSWmRUU2lVL0NBcDJ4azdSOVcyZ2xyT1NXa0pUODkrWGtr?=
 =?utf-8?B?N0VmYi9weUlva0dIWm5EYUE3cW5YREUzbzJjWjNpdmJTT2lLREdZOWQyWkxT?=
 =?utf-8?B?eGFKbU9ySHlGblFxUTNJQVdxQjZhK2ZOZEJURGdHT3A4TXJwRVg4WlQzbGxK?=
 =?utf-8?B?UEgyanYzSE5DOU1xS3gvRlpGWGg5ZkZuTDFlRTg2QlBQLzJrMEN0VjBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnhkN1hjMmtBZTJZdjg2ZlBWUzFEcjJ0a1lhMkduTzl2RWdnamdONnRRZEhY?=
 =?utf-8?B?QkVxS04wQ1JWajFwRmtjVVdiWVF4Z0RwdldJNmkzNEZzd0FETU1YaDlzQkZw?=
 =?utf-8?B?dkM0c2I1SEVmZWU4d0RrM2VTcUpNa1AvblYzVkd3RjkvOWFONjE0WGI0TUw2?=
 =?utf-8?B?UjNwWDA5SjE3ZU5Cc3VzYU9SNElyRWlaSWhhS0laTk52UHpHdzRHUEpucGV5?=
 =?utf-8?B?ck5nMzY3aFRMRU9KQmRWaEFrd1N4emYwL1F1RE03MEgrUjFRWHo1NzNXcUtK?=
 =?utf-8?B?RmpzTW93ekZqa3ZvM28rVXhTMm5Nd1VBMW54c2t5dWYwUkdsMkZwcUhjN2FV?=
 =?utf-8?B?ZVgvejJCalFQZGpQWkxxMVE2OTBkVXlZbnhhcW9aR0ZnRWpKeTAreUlJdGhw?=
 =?utf-8?B?UTZFYVdiZ1Juek9leG42VTlNYUFFL09CZENkblg2Y0tzYTkwRUdNZFNpaVVm?=
 =?utf-8?B?MVBCR21DMTRWSXpKNVBZOGRtaUgwUlora1dMdlN4UnJJelRnUXJxd2NvMVla?=
 =?utf-8?B?S3lmM2p3WTZWa0poU2llMmh6WXBydllmdDg5QWVFdnZBdG5Dc3kyRm9GV3Z3?=
 =?utf-8?B?S1grc3RJNGdYTzhEcEZTRGZVZHhmYUF1Y0tkZDRrT2p2T3lCVFZaY1pxMVJD?=
 =?utf-8?B?NkFLVGlJdm8yV2RxaUE5VFd5ZUwrcXBiN0FGMGp6cXFua045SzFzRHZXaUsw?=
 =?utf-8?B?UEc2ZFk4TmQwQmxLR3daemtUc0hQWmhvdEFnNlRIQXJTOHQ4SjFLNUZiMTNX?=
 =?utf-8?B?M1plSTQxZGhLZTJUaWdrK2l5aEs4TldNMWZERkFCd2x0dVdlaHhtZkptUWc3?=
 =?utf-8?B?dXJSU2o5WG55c3RMc2hRR3lJKzdxNzZKS25BMmtwWUtJOW1CSEVCaG1qcXFY?=
 =?utf-8?B?ZEY4MHJGRjU2TFh6OHFveHNEV0dDSk5mWEtvOVpiM05LVmFHU3BLakNpVllh?=
 =?utf-8?B?QkdsY1Q2dm1mSDRMR2M5b2dsczZ2NkZ6a3lRMjBlWDdLcHRxT050OFBpT0Jl?=
 =?utf-8?B?VVJSSUtaa3RnL3JVRlJDMzdKNU5RZ0FZRzZmUjEyU092aUNJdkVzT1dJU2F1?=
 =?utf-8?B?RGdVanB2SFNGSG9TREcvVmxYdUo4SE03UmkxbEJwaDdUN3VXU2VUaGJhM0tI?=
 =?utf-8?B?ZFpPWmVLQVhOTFBqUnpGdE1GMit0dEF1UkJ2S0M1V1l0cWZHYS9jM2Zpbjh6?=
 =?utf-8?B?NGZWcmRGcnhZR1lSUlEzaEFTL1F0Z3lPc2JjbGhIckVkdFM0OEE1S0JXc010?=
 =?utf-8?B?a2s4KzBxZVhUL01oQ3dEY0duTmpMcDBLSUV6cnFpVnBXR3UzcHFmeW41WWp4?=
 =?utf-8?B?SWFlbDlYb2ZheVlVQXJDaUo0UlgzK2U4c3B1N01TcWphM2QrbjlHWCsrSzk3?=
 =?utf-8?B?c2RqU2k3ZnlPTHJ0eFJ5ODdUWUFIT2syMmdQaGpxWXVkRVRSUUdwVlF5OWN6?=
 =?utf-8?B?OWdEbzZERVQyb1huSFBQRFFLVlZkM3c2eGo0dHZNcG9COUo5eHU3cUpZM2Ry?=
 =?utf-8?B?WkMxQ1A4SktCOE1jbmdJbncwbU15WHlyOGtvUXpXRGxrT0hGVDJWTCt5V2NK?=
 =?utf-8?B?N2lTZk9VbHpuTjhOMlRzSUtyazJ5Z2JkS01leHEzYjZVeXJaMVF2OVJCTzBK?=
 =?utf-8?B?SE9rMXo4TzJITzBSSUhVRXhwMGtscHQyT1dYb1R2ZytXSGJkQmNBN2RmdFdO?=
 =?utf-8?B?Qjd6SDhrZkhvNk0wUy9PRmZUL2R0aittMWdNRFBDQVBMLzBaZ0lsejhsM05Y?=
 =?utf-8?B?VTNBTHluQ3kyTUJSYitVTm80Y25pS0h5UlNCQUI0ZlVyS3JkZTJ1aFhXQVFM?=
 =?utf-8?B?MVBOdkxDYlU5U29JWjFtc1R1ZmI0c0JvV2MyRVhxTjlCdlhST0NvRHI1SnFL?=
 =?utf-8?B?M2tWWTBVOVdjU0Z5MVRyeUNGMFhwR05yUHJLMjdFbmg5elhrOXo3cFNHb3Bj?=
 =?utf-8?B?MnpTYmdrVEdvMm81T2M2Qnc1UkMxcVJMaWY3OG02TS9ZQnRZa0o3NlR1UUw3?=
 =?utf-8?B?UTJka05IRmZCaEhoNjVzRUk5ZTZpdWtKOU1QOHVFTURNNDNVUWJ1VnVoaEdl?=
 =?utf-8?B?WTdWUGc3Tnc0ODMvU2FuSzUxTWJzUkVIclBDU0tDSk5DSy9nVDIySWtZRENJ?=
 =?utf-8?Q?nS8gNJWjJ1mNMlETpTarWWMMu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009e91c8-31e3-428a-e4a5-08dc7a5f8904
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 13:03:12.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utDnGNM8J+72xAH/qy41rAhv3gH6radQT7CxctbE29pasU70Ekoggj08Nu0Y+W8ZNQsrW/ag8vokqwzaLfY03A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883

On 22.05.2024 14:56, Paul Wouters wrote:
> External email: Use caution opening links or attachments
>
>
> Jakub Kicinski wrote:
>
>> Add support for PSP encryption of TCP connections.
>>
>> PSP is a protocol out of Google:
>> https://github.com/google/psp/blob/main/doc/PSP_Arch_Spec.pdf
>> which shares some similarities with IPsec. I added some more info
>> in the first patch so I'll keep it short here.
>
> Speaking as an IETF contributor, I am little surprised here. I know
> the google people reached out at IETF and were told their stuff is
> so similar to IPsec, maybe they should talk to the IPsecME Working
> Group. There, I believe Steffen Klassert started working on supporting
> the PSP features requested using updates to the ESP/WESP IPsec protocol,
> such as support for encryption offset to reveal protocol/ports for
> routing encrypted traffic.
>
> It is not very useful to add more very similar encryption techniques to
> the kernel. It scatters development efforts and actually makes it harder
> for people to use functionality by having to change to a whole new sub
> system (and its configuration methods) just to get one different feature
> of packet encryption.
>
>> The protocol can work in multiple modes including tunneling.
>> But I'm mostly interested in using it as TLS replacement because
>> of its superior offload characteristics. So this patch does three
>> things:
>
> Is this issue related to 
> draft-pismenny-tls-dtls-plaintext-sequence-number ?


This has nothing to do with it.


>
> https://datatracker.ietf.org/doc/draft-pismenny-tls-dtls-plaintext-sequence-number/ 
>
>
> If so, then it seems it would be far better to re-engage the TLS WG to
> see if instead of "having no interest, do it but elsewhere", we can
> convince them to "there is interest, let's do it here at the TLS WG".
> I could help with the latter.
>
> Paul

Boris


