Return-Path: <netdev+bounces-101259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0535A8FDE13
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 07:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46FA1C2262F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCB731A8F;
	Thu,  6 Jun 2024 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XwTpyHqN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99B3A8CB;
	Thu,  6 Jun 2024 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717650835; cv=fail; b=bsJ/AWDgwZHNF/gVxaPUY5Z1ZIsO0dQHq/5FtEnEkd9SFHdx/WA0dT+3sp1DoYFqoGZ6kUghDbB3hqt3OEiNcllO2SeF8cvx29VPakge2JhKQD2yvy9mrgfcAynr2QsL1kv9KiQHzgEANd/A8Zw+krlfSDKoVVMUlDrLO8ig0dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717650835; c=relaxed/simple;
	bh=1li3sH5/NOY280G1GcJw7opBA7o7bPwrEGLenIpRayI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mqIjBbxqb+NQUkPeV4H5NHfZU8Ku5AmO7t+1LeipiB/lIE/SPyVCxQf9O4FKLh5Pv1u29u3mKrcJAhBuBBxSytlsP+s13LcYQVcEVWQ0ZtPEacSpqonCx0xf6/0MYLFhB8+zHlW1nUP7TCLqwnrQoRAN6S8dY/GolbVyxnGsv+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XwTpyHqN; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXWelH5R0ZkilrCfsBe4Q9HPITkPKEeURIY8p1eqvLDrAKLaoN0ENMbpSiH4a7bLzk8X9gfSzU86uejd2HGx+hG+ZV7HxBU2zOB0bCSwdAaqnsh7KH0D4/+KrC3k91tkZJeICslcSxGqnRZ2rfWZQwOcNIwXGROKqJXFt3DGZVf952AI3mhiH7Oacn4EdenBJYPmdBmQENMjfBbrQDkom+KAs+vNAtqfWade51Mpwpo1XWEmQSBElcdpzOjQQqfhOrjM9sGp4l0OzVqyS8C5+1uBN/zVozWE0ZWt/9Hzz7hWSvfGE177fIshK94VIJd69fttEg1pySgstIBu3vqfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umZgBq5qTvcdOZHuFRaDiPUmxnl9XutRk3LnPFpFZUs=;
 b=C+WYM0FPuozocGAg5eNHplFXeJ82Sf8HgaUCwDAz8x6Bo34EKiz1Ue3Ww4PpT94+DkM2qFdtcB+0CHayFHIzwyYV/fZ3r0UplcK/8sblaHxjWj2ztBj+iBJMrS/1mlMTAMzTfZaC58gamFyGNz9qotV35yolW3LOYCGvnRY7j6rb6owNfDgURNmcqritUdildn6gxWqUG/8wxVJs1cNCb1uFwCu21h+4ViMEDVH3yNayqwj1BxyYVAV/i30lugahTwv4WEEvOS13tuj27v969a15VEHCLm2blX6wxk6mn0AMrmpelEX8BCUAxpdUGyUS2MRFvDQzzITar4gq7/YWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umZgBq5qTvcdOZHuFRaDiPUmxnl9XutRk3LnPFpFZUs=;
 b=XwTpyHqNfsf7ma+LsM0rLF5jFd6gdIiXqd1g+eQlxrZZ4NibBcsWqsZWniZo271ZvucJSSWiiy0IH8DkrFneRLn7kvvUruCY6AtEutLsVe4mvjhHQp7SL4xKM8JBAms2OtxpX1scmB5fp9wQ7exNOjPHNn2U6SIwHiLricn6BcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 05:13:50 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 05:13:50 +0000
Message-ID: <241cb8ec-14c9-4d7c-9331-2df0b8bf21b2@amd.com>
Date: Thu, 6 Jun 2024 10:43:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/4] dt-bindings: net: cdns,macb: Deprecate
 magic-packet property
Content-Language: en-GB
To: Rob Herring <robh@kernel.org>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, vadim.fedorenko@linux.dev, andrew@lunn.ch,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
 <20240605102457.4050539-5-vineeth.karumanchi@amd.com>
 <20240605154112.GA3197137-robh@kernel.org>
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <20240605154112.GA3197137-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ac8288-d832-4382-ed41-08dc85e77354
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2tMNWZmQysvN0hvbHQyTUdueGdPWlRaN0ZDZG42THFMLzlrUHQ2TFpKWHBZ?=
 =?utf-8?B?MVF3cGNQU1BLd1BSY3pxZnBnQndIakJJNC9vRjRHY2k2UGZDMUIxK0p6RTJr?=
 =?utf-8?B?MENCNEdweXlVUGtoM0R1TEhER0h2WDdjUHN0RERWWmdpenhDb1lRNm1lMTR2?=
 =?utf-8?B?Unowa1dTZlRnWHBNTkhrd1ZreVJFZWo4SHdpNTZGcjFLV0pTb2crT0Y1SGN0?=
 =?utf-8?B?SFJncFdmU3dGeDA2NEJBMk54aXZIU0hmcUJxVXJyWGVmUlFrakVkOVQwUDBU?=
 =?utf-8?B?Rkx4Wld3a0FsdjU0YzYzYXJUNktaVWJhNzBQNEc2OXNlK1duN2JwdUdZb1dS?=
 =?utf-8?B?L3pvME9qeUg0b09zZWVyN0RKNE40RXh3S1pJT1gyS2J6UXA0aDhDKzd5V0I0?=
 =?utf-8?B?cDZ2NVFoRVV6V2VubjlodkJKZlNwTkd0Nmc2VnhObXhZSy9TZW5DMGFLUUVL?=
 =?utf-8?B?YU0ydTQybmVPVGgxNHJmaXY5d3d3WSt5WU1hR3A4RVdmSzJtQXZUVENxVWM0?=
 =?utf-8?B?OUxzYjlyRjRocVdzbHNlK2x3VThNN01JY3Bvb05ZdTRTVGg3THppQjJ5VEFh?=
 =?utf-8?B?cWxwY3hhendYcjFnakRGb2JYU1FrcHUrUzByRVZrT1pUNEJQZUtoYzcxUEtG?=
 =?utf-8?B?WnRuODRzTnk1WUZMV09KcmhKVnQzNWZyZGRzY3NXRDM0OXJnTFJYS0FJQnZF?=
 =?utf-8?B?M3pNM3l3SlVzVzFILy9uRUdhRTN5TUZqZlRJVDlpK0FIZ2JqTU54RkVQdmho?=
 =?utf-8?B?R3ZSbEUzWmh3cEFURlJ2Umtxbkp2bUJ1S2tSVTVXQUgrV3pRNXp2YUw3MG9a?=
 =?utf-8?B?Yy9WdVp1eXdjUTJSblI0MElwMlFMTTJjY1ZYbnM1VFR6WmhLQ1FYRHBRemU4?=
 =?utf-8?B?RWRFZE0vRWg4dXdTQWdsVThqalJIQzNZWkt0TGUvUHdBNXEvemNNOXdhbjJi?=
 =?utf-8?B?Ynd6YXZvb2hQeWg4bmwyUk5JZkFPNVFiM0hjSk8ySWxZcUNpeWUzaEN4QnBR?=
 =?utf-8?B?K2JzM0dXNDQ2TnJFRy9DZjBCK0c3ZEpNZTZId2t1V1RyRFpYSWw4RG1MTUxq?=
 =?utf-8?B?SnVSU2FuWGlPMnREd3pHeE5QMXFjZVkxWnlSNjBvdityYlVRM0xJWENYajlr?=
 =?utf-8?B?eGorZG83ejhKYzRkdDlpT2JNbGE0YW5RZTJzL3p3U21nTlVpdlhaY0NOZEp2?=
 =?utf-8?B?ZllWckhwSDNqWlJndzVVZytWR0tSSXJxWWRmTUtHaUZGV3dBZHlVQzhyUTJh?=
 =?utf-8?B?Z0d2bGpkMk1EekZjTFF4ZG8xL3JLelFjTElZb0htK1lHUEtqVFkzdGk0Y3NW?=
 =?utf-8?B?UWNIWTZOdEg1OURvUzRPR0lCdk5xRVAyZXdXOVpYcWZib0JwSUJ1UGtmVFVa?=
 =?utf-8?B?eEJScDJXdVlnVE5BeTVoamQxdWUzZkxUSmtpNy9nVXBDZjFianJBZ0NqM2tG?=
 =?utf-8?B?dXU1UE9TQTlWMnoyUDB5dFVnZExRYm0wSVhhUXBTRElDejhGdTVYTUxGZyth?=
 =?utf-8?B?MHZpd1oxeHg0MWUxcTRtdUpGbE40YTQ4Q0ZNZSs5YmxuRExJeHRZUStHYXR5?=
 =?utf-8?B?SzRQMW9qbWk2OWtqVU9WWUl2UENwSVpxL3hmQmxxTWdwSDAxb2ZIY1RDL2FK?=
 =?utf-8?B?VEEzVituUVhEZytNRURjVi81a0h1RWRLQjg2NTFub043Yi9xMGdDZnV5ZHJH?=
 =?utf-8?B?YzVCNTBZY3VMcUxqRk5TenpUaVVVNHUyQlFzYUgyUWRFRU5wcTZqcmZraFdR?=
 =?utf-8?Q?xPMUSLEMiwrMsOVU6tb0D7Lxm8X2sYgNyGXqujC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjJKaHQwSVNSTFFjMG5yY0djVC9QY2xtaVMzS0xxYU51NkhwMGJ5YWEvSzJt?=
 =?utf-8?B?UGJ0Z25SbmhIZnhqeUo0TUV1Z1pmRU5vQWhoSDV0ZzhOOTkzVThod3g0ZTBw?=
 =?utf-8?B?YnVmVXRmd3FLWFpRMEJRSGZHS0VBTUZxcmtLMkVIZHRKOXI5OEdtN0xCTGx2?=
 =?utf-8?B?OTV6TkExektrd210d05PSmVYc05mczdVWXZpbHRNTHJTVU1YdzNtaUdjTytJ?=
 =?utf-8?B?UFlXcHFpWXlHNmpPZVBHYTVVRzVub3p0MldvMTJqWFpxWnA2Zk1mbTZINGxv?=
 =?utf-8?B?c0l6WE1EN1hQWWlqQVFwOWorZzhHdStMbDI1NGUzTmxpa3NMNDNFUEZDRkp2?=
 =?utf-8?B?MDhVM0tteFlYYUJqMENaKzFDVUxJM0NUdDlvU3V3MU94NFh2bnF3bkNRWjN0?=
 =?utf-8?B?clE4L0Z0Y1NPcERiTGxJYVpDaUFpd3QvTlpHeGVuT1BYOThDYVNvZWRHMVQ5?=
 =?utf-8?B?VC9rQ2tXNEFkSlE1NVNCUW5sb0ZmTHhxd3FSajFIUExnZkRucEl5eTBjbnVL?=
 =?utf-8?B?azJWSERTblZsaU9HbzdkQ2FtSzhhdHIwNHpFT1hvSnFnaXB0eUdxeGtUNmJB?=
 =?utf-8?B?bm14WnAwSVlUZkh0dW90QVpPODZJYmplOVRMU2hVZWtDS0FyWS8yOUtuOTVI?=
 =?utf-8?B?MWNQc21PeUFWZkJXSGtCRXVaUmhOOXV2Rk5iT0o2N1p6RDA2cDZoYmMxQ3Ir?=
 =?utf-8?B?eGsvOW5QZW5UcnlGVzJWZGpPa0oxL0RDYnlTclFtcEkzYWszakNjV05RWmZE?=
 =?utf-8?B?VFEyb0J4UWgybHFOZkRrUnFtYTNQYnJyQUtiVmJLKzN1U2hKVWJPZVhBTTJP?=
 =?utf-8?B?TkY5K3hUemo0M3prZFQyOGdyM2ZrQ3ZvaGt2dkhlL0pkL3l2aTdvaFByd1hn?=
 =?utf-8?B?OTNmNmhrQS91TlFqS0loaGY0SEtSWmtTcXZ6WEdhUUJORUJOUUw4Ym5tREhl?=
 =?utf-8?B?NFVacElrUzdDTGRlZmgwT1lRWTVPQzQ2dzlJQVZUSE45dWIwOXplL29TdGJZ?=
 =?utf-8?B?U0RQMThyTmpOejRtSEZsYVdiOXA0Z0ZoS1JSeGkwK2trYTJrUDlRRDBhZ0dt?=
 =?utf-8?B?bm1NdkVIU1ZaTUFaTDFCYjlnSzl5bmdlUCs3bVhDbzArNnFaUzJLRzZKRlQy?=
 =?utf-8?B?V2ExSUdGSW1kMWwwbGg1N1dVbHVMM3ZoNnc2Ris2cFNqQ2Q2VVhNY0VhMjAv?=
 =?utf-8?B?S3AyNjdlcU5lSGdudUFpNHdxcUx0elNsTnJQbG5ZWVpKYkpGNkdFRUlyaG1z?=
 =?utf-8?B?OVlQbVhma1NMUzg3ajN0NFVmZDd6SERFWFRBRXd1RklUS1hSdnpoUzNrbTl3?=
 =?utf-8?B?WUo4dnV2elJJM2ZDOEx5VEx4bWM2RXBYZHY5Rk45TnJuemxmRlNld2VIUlpZ?=
 =?utf-8?B?bDllNUNrNGp5OGNIVXdlVXJiYW5aSit5TmtDcmU1b3lWZ0RDQVFPbkRDWXo0?=
 =?utf-8?B?cUlMdU1LdTBOYWg3R2dBRGYwbnF3MllReTBrM3ZHandoZmZDRG8wRUpPdDRH?=
 =?utf-8?B?M1BXZHY0OXlZYmw1elhyV3pDZmlKMXkvRkhCTGp2RHl6b3FyRmhjVEhqTGNv?=
 =?utf-8?B?cmdvTldaQlloanJhZkNHdFRMdXUzYjRDTDREVTUrNEViOElMeGpYcm5xOWdC?=
 =?utf-8?B?aTU0Q3Y3cnFYRFA4SXBuVnpESFpYNTMvcDRZNnN4Ly9HQ3hUdEc4QmZQM0lk?=
 =?utf-8?B?Y0UxcC9XYjJtektGaUdnUU9EM1c0ZTFDM01mSW04SDk2c05qUENGczF2TVhs?=
 =?utf-8?B?aHpaQTgvdm1kZWF2WENSMVdxRzlWaGdSWS9rTGt2OXhtZFltQlhMN2FPWFJp?=
 =?utf-8?B?Z0lXeklpdGhuN2FQckZreS9RRzNNNmdQOGI1T1RyeWJPUWJPaFplUnBpbzZp?=
 =?utf-8?B?LzN5YnVhUG5nWmVSeTIwTGM5eWViVEdCKzVUTXVRZnR6ankyOGZSUGhSM2hv?=
 =?utf-8?B?N1ZZRU4waXlvcml5UFlLcWdLT2FpQWZFRzhhb0xiRVlrVmxOZm5lcUhhRERh?=
 =?utf-8?B?a09vUnpvQmhyVjhiazJncXJxRTMzUHFYSXQrTzUzODJjMWI0MXUxRFB0di9Q?=
 =?utf-8?B?a2JKQUlQbUF0Y0w3bEdHVE5GNTZRQ05wNnhHNDZLbWhBNW5sL1NIRDRpNGlF?=
 =?utf-8?Q?lb4U6rwHrwQR+3Co8GkCa/5Bw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ac8288-d832-4382-ed41-08dc85e77354
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 05:13:50.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XZpTTYchbPDdVMHuA34uelLZxfY4d6AiT0d6wjpt2/4ZLk3XR67/tYhC4uDziKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

Hi Rob,


On 05/06/24 9:11 pm, Rob Herring wrote:
> On Wed, Jun 05, 2024 at 03:54:57PM +0530, Vineeth Karumanchi wrote:
>> WOL modes such as magic-packet should be an OS policy.
>> By default, advertise supported modes and use ethtool to activate
>> the required mode.
>>
>> Suggested-by: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
>> ---
>>   Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
>>   1 file changed, 1 insertion(+)
> 
> You forgot Krzysztof's ack.
> 

There is a change in the commit message from earlier version,
as we are not using caps any more, I thought of not including the ack.

I will add his ack in next version.

🙏 vineeth

>>
>> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
>> index 2c71e2cf3a2f..3c30dd23cd4e 100644
>> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
>> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
>> @@ -146,6 +146,7 @@ patternProperties:
>>   
>>         magic-packet:
>>           type: boolean
>> +        deprecated: true
>>           description:
>>             Indicates that the hardware supports waking up via magic packet.
>>   
>> -- 
>> 2.34.1
>>

