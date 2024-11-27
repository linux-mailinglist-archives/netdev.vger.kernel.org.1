Return-Path: <netdev+bounces-147629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 745529DAD43
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 19:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3377F281549
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341572010F2;
	Wed, 27 Nov 2024 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dp+y/ew1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1924E2010EC;
	Wed, 27 Nov 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732732807; cv=fail; b=IB/LGCQNkufogNDyVStQ7he6fFL0AsRweIomZF10Engj+4AzvpSh+UROR+6GgA+iXKq31PxSB2H9K75IoXu88U2xtMzH5yde6l2sqU8uomnqFZH44OCHOWxABcz7CJYn2LQB5qk4v9vgfqvuOEWZXJkgf2dFrVEcUD+PotV6v3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732732807; c=relaxed/simple;
	bh=jSsZXHDOO7qjFu86KY7BVn5gACBGU7BQQSgkOecsHzY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nWWv/bTIpNcg5quRZd0yWhvnlFiwUfz9YwJQiJ/WLW5GKhH/y8Xg47DtXKIMMCwGaMlRt7hZEoC5HFhhEZmEyHCVJTrMd67DZ5/2fa68ITntf5/GBxkC964M1ENtACeieQqkob4shs7og5uX+ybrGfcySa+O6lxP94LcZlbXm2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dp+y/ew1; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7grgli042IULJ1kQNODgSrdJhypqsADTk+8Mh0pBnLZLEv2neEptaslHb9D9gBzF8MXPsGnawS46vyAAqtMsJMmE29/xahLZ2rA+fVLZgb2oTNbA2tK9P1+IqcaJLEwmuemrVprA35zOW+RK4tr5u8rcHarPJfYXrHDduYVeKmo3Tm6Uk9UqGrBI7E/TZqGxzTLTC4KsTiw8ChMwPz6F6rYYWsvAA0N2Y4HCBY5AXo11wqBTcVa3KBRS3uT6IyId9Kaxv9FPa2pcogxETUe7EiYg4EuQrqC6R05GZkpNgedf9Tf7jGNrmXTfXXKtlmau0+x/j/oeUP4OWAurI91aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZnM10QjiGu3yfcsPGoRvblDxgYrTl5i9MM43sdq7Qw=;
 b=aEOZnyHZ7CIdg6+DMU6NeDUY7TWf9IdOjkERAGA8zbLhkZg+3no74QkCh/wzCdbRD78OFLor0astJdQEkcYksfhf290FHhYOgs6dNCZ0K9SIB4wNoAOtq4BuptLifxxwAoLLaDipGdTbev/UTPlPLi6y4wdEtlfE2LmR/MP9F+YmXsPFrpMRyKrYmYh7ifbz+xX8umRdaygbGBb1Rl/+QIpayyrzsf5ZGGbro3zmPvMMZYr2hkdhrWEmyC/mGbvCYvalScPdss5HSkiz7BrQQqbyvtjoOF39uwX9pszQZl/H1qD3z2vN57gLq6+6FT0AfvIGCfuc5P534nr6PhVwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZnM10QjiGu3yfcsPGoRvblDxgYrTl5i9MM43sdq7Qw=;
 b=Dp+y/ew1gw3cE53zZ3pm7lHrQNcdcR7Qw7G19Z3MaSnAnMy9yZ9eJPC0kgZEUAkpY0bR3pbcDbq98fXY1s31fgWHZJTjqVZcWh5yXkhOJwCfiwUn2yrxiOXoZdtK9N1xRFvBppmJDgf+RXQ2jpBj1+e6iPdhlg24urMNGyrdrKoIrPS2AsdaRqgx/+EDLZGM8xCwJbzVzVnIdSTmTRxBAkw15sLn1vUkYCzGb9u62fIgfZLGrAhHT0ziHIRq+XgsWFJotTE2gT+fRQsmEIxNwAHprcCVZkvfk3kihXpDvCI4K3hLnkOHx21cCXqVEbtchv+2DECQlw6RxL+0PDJarA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Wed, 27 Nov
 2024 18:39:59 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%2]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 18:39:59 +0000
Message-ID: <d8112193-0386-4e14-b516-37c2d838171a@nvidia.com>
Date: Wed, 27 Nov 2024 18:39:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap for
 non-paged SKB data
To: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, Thierry Reding
 <treding@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20241021061023.2162701-1-0x1207@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20241021061023.2162701-1-0x1207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0175.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::14) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 9755cd5b-4f63-4ca4-3737-08dd0f12e55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTI4OVRaRVpXUlMyem9wWEhzN3M0Zy85eDhwYm1oNUc1L0J3bW1FNCticVE2?=
 =?utf-8?B?ZU1BblMyb2Y1bEhrMDBoNmpCTkJIQTFiZmJjTklQb3FaVmI3L1liaDNvekdL?=
 =?utf-8?B?SzJaV01tc29meWNOVm5DWkN0YXNoOFlna0VVV2NQclYzSGw4cW1YSTNINXdn?=
 =?utf-8?B?WllKNHZtT1pTeWd0TGRVTmxBeWVxeXJWcTJrVFBHK1ROUDRCbWp1U0dNS3I2?=
 =?utf-8?B?L3pJZEQzRWlVMUxhemlJZmpxaG1wcTUvdHhNQmJEcTBtMlFYaStUMTAvZ1Ji?=
 =?utf-8?B?T0YrTXdQRGFFdkRLMjFGQTNyMkJVVnhxZ2VtSWFqWHFrU0RBaUtBdXl3WkZh?=
 =?utf-8?B?V3FFM2wwdWpaeTNKLytvRzFWSHJBMlFGWGptYnFDY0FpSFh6OFQwV2lJc01X?=
 =?utf-8?B?aHMwM2xuak9xdm45cVZLeGJ6ODlxSm8yOGo4dHNpY3BEaHpVQlRtRWl3Tyt3?=
 =?utf-8?B?a2ZtbWNzUTZFclBNcW9IQWRldm5WQW8yK0k4L3hBdHN5R01XTUVBd2hpVG4z?=
 =?utf-8?B?TVQzY2I5QTRyWEQ5Y1hhU3FIL0ppd3AyYkplbFdyRVdETkJ6SlJOdENRcWdZ?=
 =?utf-8?B?SUJsRDBOSC9vT3lsMGJBY1d1RlRKV2xlQlpnaFFGMDJ3SGdoTGk1ZUVDUHd2?=
 =?utf-8?B?Wi9PWjRzZ0hUcVF2MXF5dzZBTGRmakJvRXhWUk1sMlpGVmgzanZkSkoxZjM4?=
 =?utf-8?B?WXJZTlFGOUJubnVRRWpHL3NQaXZGblJZVm5PR1ZYcS9qYXFYa2RiUlZQSGNQ?=
 =?utf-8?B?NUs3TGZ6WlhwOEtpQVhRTTRFNlp0Z1lPSlVHNmxoeGRyd25ndVBSTnMwUksw?=
 =?utf-8?B?TENERXpZVlI2aE8zRDJzeXdrSW1zV1pkUzRTTWY4L29Rd2pzWWxKNXYyc2xI?=
 =?utf-8?B?REp2VzRMNXFxV3ZUZXo5N05vYmFBTEM5M1oyWitXVzRjRHQ3bVZUVTgyRG1H?=
 =?utf-8?B?dGRKU0s1ZllsOFdiaXRwYVlrdWY3bHdYZDJyN01UQzVhbERWQTVZMmRQUUh0?=
 =?utf-8?B?ZmhxMlIxOEF4Mlc3eUp6SXkzZWlzRjN1VUNhSUtjZTRqdmNtSGRQTCtqYVBT?=
 =?utf-8?B?K3RaWGFMKzArN1Z6WnF5amRxanhVOUNWdnJ3cVNYLzI1VlF5OWJBL1pIdjhj?=
 =?utf-8?B?RnJRajRQUGpMdUo3M0plTzhJUFV3OEpEZ1NPbysvTFltc0FkaWhkR3dXL2hF?=
 =?utf-8?B?RFJmdFdtRTRoU2R0bTYzWkJtWHZQdmh1NGx6VERkeUUxbjV0TTRwd3NTKzRS?=
 =?utf-8?B?NWpEaUYxaFlVY1k1aEFEaXNONDhweEFxOHlvdUhDSEprWTQ3ZVNxSU01ZEUv?=
 =?utf-8?B?S2p6ZTF6a3VzYk14L09vVGl6bFBzVExhRW5SKzZGMmVsOGF0cXowVXdzYTJL?=
 =?utf-8?B?MXA0aFlVRXRET00rLzdIRDErRm15YUxyVlZQTTNjeURVeVE5cHE2UEZjNEd5?=
 =?utf-8?B?bS9NTUhRM24rc2VnWktWSUI1c3FrUkRiMFJRZlZMZ0o4RTFoS0l3M3BhaVF2?=
 =?utf-8?B?bEFoRlhSWjNSMzh2M2JhenNpSTEybXBIZmRENlJtQmtyVW9yWjF1NXF5c0Vx?=
 =?utf-8?B?ejVUWEtkbXNXTmxnN1JpR2pGalRyaEVVTXNqQnZFQ0JoaWVVMDFKeWtsM29P?=
 =?utf-8?B?Y1hxRVRmamZhQVVodThOTTFNZ3ZER2w1Z3dLV3MvcnBzV2N3eEd3a1hMSlU4?=
 =?utf-8?B?NXl0WEdqZG5lS2s5VTdRaDk3aTM2Y1hoa3FseFQ2bE5hZ3NRdmVZMS9FcldL?=
 =?utf-8?B?ZE1yM0VJS1NvUkhiTVRhN2UzUmlTMzBIWUxSeWZwWkFUUnluTG5XanVXd1ky?=
 =?utf-8?B?YWJyNEFxSkJEbzhyd3M4dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmQ5Z2gzNFZCTkpXaWFoNXdjWTZueVd5S2Rnd3NaSVptMG45ZjhQZW8reXFz?=
 =?utf-8?B?YUR0MUs1NEFIQnh3YWVJYWlmZStFczdsTTRMR2JHU0EyWGgyUHcrWitkWHVO?=
 =?utf-8?B?UU0vSElXdnIwSktES2FFSWV6ZDl0d1MxeFJyLzVuODJPM0NXQzEwVGpmcTJ0?=
 =?utf-8?B?bllob2ZtcEExSFJMODA2OUJUVFJiWWZpSFRETFNTZXUwWkI1YVc0dnlUbmxS?=
 =?utf-8?B?ODA1aEx3V1hDWjFXcFZJL29QTzd2dmM3S1FUS2RrbEdCZjY0a09odWhJK3ln?=
 =?utf-8?B?QmFBYXdsZ1ZIOGFwR0NwWW56ZkU4QW9UU2xBaFoyTFFFV1JZTUdtdGs0YWxT?=
 =?utf-8?B?YzBxVVZWTk52alVtL0lCMXlEcWJpdHNPRi9sY3ZaS05CME1iVTNTUzl2YVdo?=
 =?utf-8?B?SjE3czA5SGt4T2FGdmxwOWljWkkxd2RyODVLMTVYUUtYa3hZbFZKR3FKNE1Z?=
 =?utf-8?B?eEJxUHdtRloveXh6dW56NDJvYUZ4a0FyMVpZV08wME9WQUJsa0Q4M1pQcm5N?=
 =?utf-8?B?VVBOMisyc00vSGUrODFvMG9lYnYvTjRXV21LZnhVbTJqemdpWXU0enNNbThZ?=
 =?utf-8?B?dnpVSFVrOTZBdElVYTg2MWR4cXJDT1UxYWloUTFYdjlzZ3N4b2hKS1N2YUdp?=
 =?utf-8?B?aUM4cS9hYStxUnJFS3E4Rzd4SW5wRm40a3VTOXBkUE1LTGQ0TEtqSmhEak1r?=
 =?utf-8?B?RnMxa3FCWUppZU16M3ZJUEE0K2VEYUFiTGxpaEZwSGg1L1RJc1ozR3JFN1lx?=
 =?utf-8?B?cjdVYzRWU2xoUTd6amV6MTE0YkJ2QmgyVFJqOFRTYWt0NnNQRHU4RmIzNkFn?=
 =?utf-8?B?dlMwUUNObnM1d0lTcytaZzh4VlczWDlJNlJtdnp6elVBMFJicG5qMWFYOXJJ?=
 =?utf-8?B?SlArc2ZycHlLMFJRV3g1aVlZZmhaUzFtbG5zUC81dStQKzRpVzVQZzhBZGJ1?=
 =?utf-8?B?aFJqMTJXZUdTOFMvaVRxbU55ek42VWhMdHp3VXVKQysvYU5nUzJWMW9OeW9L?=
 =?utf-8?B?RElMeEl3T09iUDI1N08xWlFzdUk3YWpXR0c4U2xneS9BNy9NR0FaNitpQkZU?=
 =?utf-8?B?cXZ2T1MyeFh6dGROUGxrRTAvb2h1dmtXblo2ZkJ4bVdmQUEyYzZOOFAwVkNK?=
 =?utf-8?B?d2FmWXVxS01tTkE1dnhpblpmbzNyYURER29jOGpKRlNkR1hoTWpSZ0pTVDJm?=
 =?utf-8?B?cXVvbDhPL0YxcEs2SS9LQm9ZL3Y4NVhTYnpseWY3dXowRFJRN0hVa2xkYXZH?=
 =?utf-8?B?R1psVVRPZGhDV1VqNTgxWStLTXlDV1Rtb3FndUVpeDRpeWxGVExiMGlKSEVv?=
 =?utf-8?B?VDNGSmZCaVRDa2VRR2kyUXUzVGY4M1FGS3ZJZUMrM0c1dkhCWG4rdHdmS05w?=
 =?utf-8?B?Y2Fsdk5BQzIzRlpKZm9jR0pZSk1nNWh1TXNDc01BLzdyY1FpbjR3bmJabEQ1?=
 =?utf-8?B?Tlp3R2ZuV0lSczQ1N0JrMEFTUEovOXdqcXNXaFF3UTZWRk9nRThUMTVUWG81?=
 =?utf-8?B?bDNPNnN0eTBvc2JveFN0ZUJhQVR4MFJzb3BRcmVmSmlOS0lZZ1dNSlR5Q2ZL?=
 =?utf-8?B?ZWpYYURGNGFXTGJiK2xsbzFqZzdUY1M5TEVpSnVVRkNuOVFWT2w4a05sK1Q0?=
 =?utf-8?B?aEZKenR0UHlYcmczdWhIUmxIK080ZG9aT2txTVBlaFJIYVV3ZXRyeGdvZlJu?=
 =?utf-8?B?dkZ2VUFhZnVDRDEvZllKWGlaTFhLVkJ0bTBIWUtBSlpXdUc4SklGaUlHNGNx?=
 =?utf-8?B?ejNNeDZMV2NXRlNYL2F2Y1ZVUlZ0dmhmSW1BaFFjQW51UTJPUFp1cldCQmd6?=
 =?utf-8?B?WG5LVGl4UVF1SkZnVXdKYUVvaThGQkdqN1loQzBoaFhQcTFqZHFONUt3ZjlV?=
 =?utf-8?B?WVJEMStHLzBNM0xNNmpsVGdna3J1UUxCVlN2YlBGMS9MR3hqY0h0Z2phV3dy?=
 =?utf-8?B?WlhabWZjZjJXN2NsdWc2WkwydmpGQzRxZ1RHRTVyTVh4MlYvc21VNHVuejgy?=
 =?utf-8?B?Y3o1VEQ1NWlFZW1hVjFDM1BRYlRjd3dOMFllS1o0Z2wvcTV3WkdvYW96OUw4?=
 =?utf-8?B?VUJZemlrQTVMaHlLN0o1dVJkVm1OL3dpbDBhNXZlRFZ0TFJMMnh2VzREL3RM?=
 =?utf-8?B?QjY5RE8ydVh5b0N6NklSdVgwZlN5enlxa1pCQ3gvdk1XbUhlVCtZRVgrRFh6?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9755cd5b-4f63-4ca4-3737-08dd0f12e55d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 18:39:59.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf6G3gV7wY3Tz1zn/g2KN6euth7pXkU752brNaby1gb0Wu/Qm1Ik2del9ROml7XqNTKw4eVHW1GTlNT4vbROVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321

Hi Furong,

On 21/10/2024 07:10, Furong Xu wrote:
> In case the non-paged data of a SKB carries protocol header and protocol
> payload to be transmitted on a certain platform that the DMA AXI address
> width is configured to 40-bit/48-bit, or the size of the non-paged data
> is bigger than TSO_MAX_BUFF_SIZE on a certain platform that the DMA AXI
> address width is configured to 32-bit, then this SKB requires at least
> two DMA transmit descriptors to serve it.
> 
> For example, three descriptors are allocated to split one DMA buffer
> mapped from one piece of non-paged data:
>      dma_desc[N + 0],
>      dma_desc[N + 1],
>      dma_desc[N + 2].
> Then three elements of tx_q->tx_skbuff_dma[] will be allocated to hold
> extra information to be reused in stmmac_tx_clean():
>      tx_q->tx_skbuff_dma[N + 0],
>      tx_q->tx_skbuff_dma[N + 1],
>      tx_q->tx_skbuff_dma[N + 2].
> Now we focus on tx_q->tx_skbuff_dma[entry].buf, which is the DMA buffer
> address returned by DMA mapping call. stmmac_tx_clean() will try to
> unmap the DMA buffer _ONLY_IF_ tx_q->tx_skbuff_dma[entry].buf
> is a valid buffer address.
> 
> The expected behavior that saves DMA buffer address of this non-paged
> data to tx_q->tx_skbuff_dma[entry].buf is:
>      tx_q->tx_skbuff_dma[N + 0].buf = NULL;
>      tx_q->tx_skbuff_dma[N + 1].buf = NULL;
>      tx_q->tx_skbuff_dma[N + 2].buf = dma_map_single();
> Unfortunately, the current code misbehaves like this:
>      tx_q->tx_skbuff_dma[N + 0].buf = dma_map_single();
>      tx_q->tx_skbuff_dma[N + 1].buf = NULL;
>      tx_q->tx_skbuff_dma[N + 2].buf = NULL;
> 
> On the stmmac_tx_clean() side, when dma_desc[N + 0] is closed by the
> DMA engine, tx_q->tx_skbuff_dma[N + 0].buf is a valid buffer address
> obviously, then the DMA buffer will be unmapped immediately.
> There may be a rare case that the DMA engine does not finish the
> pending dma_desc[N + 1], dma_desc[N + 2] yet. Now things will go
> horribly wrong, DMA is going to access a unmapped/unreferenced memory
> region, corrupted data will be transmited or iommu fault will be
> triggered :(
> 
> In contrast, the for-loop that maps SKB fragments behaves perfectly
> as expected, and that is how the driver should do for both non-paged
> data and paged frags actually.
> 
> This patch corrects DMA map/unmap sequences by fixing the array index
> for tx_q->tx_skbuff_dma[entry].buf when assigning DMA buffer address.
> 
> Tested and verified on DWXGMAC CORE 3.20a
> 
> Reported-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> Fixes: f748be531d70 ("stmmac: support new GMAC4")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 ++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d3895d7eecfc..208dbc68aaf9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4304,11 +4304,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>   	if (dma_mapping_error(priv->device, des))
>   		goto dma_map_err;
>   
> -	tx_q->tx_skbuff_dma[first_entry].buf = des;
> -	tx_q->tx_skbuff_dma[first_entry].len = skb_headlen(skb);
> -	tx_q->tx_skbuff_dma[first_entry].map_as_page = false;
> -	tx_q->tx_skbuff_dma[first_entry].buf_type = STMMAC_TXBUF_T_SKB;
> -
>   	if (priv->dma_cap.addr64 <= 32) {
>   		first->des0 = cpu_to_le32(des);
>   
> @@ -4327,6 +4322,23 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>   
>   	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
>   
> +	/* In case two or more DMA transmit descriptors are allocated for this
> +	 * non-paged SKB data, the DMA buffer address should be saved to
> +	 * tx_q->tx_skbuff_dma[].buf corresponding to the last descriptor,
> +	 * and leave the other tx_q->tx_skbuff_dma[].buf as NULL to guarantee
> +	 * that stmmac_tx_clean() does not unmap the entire DMA buffer too early
> +	 * since the tail areas of the DMA buffer can be accessed by DMA engine
> +	 * sooner or later.
> +	 * By saving the DMA buffer address to tx_q->tx_skbuff_dma[].buf
> +	 * corresponding to the last descriptor, stmmac_tx_clean() will unmap
> +	 * this DMA buffer right after the DMA engine completely finishes the
> +	 * full buffer transmission.
> +	 */
> +	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
> +	tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
> +	tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
> +	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
> +
>   	/* Prepare fragments */
>   	for (i = 0; i < nfrags; i++) {
>   		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];


I have noticed a lot of intermittent failures on a couple of our boards
starting with Linux v6.12. I have finally bisected the issue to this
change and reverting this change fixes the problem.

The boards where I am seeing this issue on are our Tegra186 Jetson TX2
(tegra186-p2771-0000) and Tegra194 Jetson AGX Xavier
(tegra194-p2972-0000).

Tegra184 has:
  dwc-eth-dwmac 2490000.ethernet: User ID: 0x10, Synopsys ID: 0x41

Tegra194 has:
  dwc-eth-dwmac 2490000.ethernet: User ID: 0x10, Synopsys ID: 0x50

Otherwise all the other propreties printed on boot are the same for both ...

  dwc-eth-dwmac 2490000.ethernet: 	DWMAC4/5
  dwc-eth-dwmac 2490000.ethernet: DMA HW capability register supported
  dwc-eth-dwmac 2490000.ethernet: RX Checksum Offload Engine supported
  dwc-eth-dwmac 2490000.ethernet: TX Checksum insertion supported
  dwc-eth-dwmac 2490000.ethernet: Wake-Up On Lan supported
  dwc-eth-dwmac 2490000.ethernet: TSO supported
  dwc-eth-dwmac 2490000.ethernet: Enable RX Mitigation via HW Watchdog Timer
  dwc-eth-dwmac 2490000.ethernet: Enabled L3L4 Flow TC (entries=8)
  dwc-eth-dwmac 2490000.ethernet: Enabled RFS Flow TC (entries=10)
  dwc-eth-dwmac 2490000.ethernet: TSO feature enabled
  dwc-eth-dwmac 2490000.ethernet: Using 40/40 bits DMA host/device width


Looking at the console logs, when the problem occurs I see the
following prints ...

[  245.571688] dwc-eth-dwmac 2490000.ethernet eth0: Tx DMA map failed
[  245.575349] dwc-eth-dwmac 2490000.ethernet eth0: Tx DMA map failed

I also caught this crash ...

[  245.576690] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
[  245.576715] Mem abort info:
[  245.577009]   ESR = 0x0000000096000004
[  245.577040]   EC = 0x25: DABT (current EL), IL = 32 bits
[  245.577142]   SET = 0, FnV = 0
[  245.577355]   EA = 0, S1PTW = 0
[  245.577439]   FSC = 0x04: level 0 translation fault
[  245.577557] Data abort info:
[  245.577628]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  245.577753]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  245.577878]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  245.578018] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000106300000
[  245.578168] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
[  245.578390] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  245.578528] Modules linked in: snd_soc_tegra210_admaif snd_soc_tegra_pcm tegra_drm snd_soc_tegra186_asrc snd_soc_tegra210_mixer snd_soc_tegra210_mvc snd_soc_tegra210_ope snd_soc_tegra210_dmic drm_dp_aux_bus snd_soc_tegra210_adx snd_soc_tegra210_amx cec snd_soc_tegra210_sfc drm_display_helper snd_soc_tegra210_i2s drm_kms_helper snd_soc_tegra_audio_graph_card ucsi_ccg typec_ucsi snd_soc_rt5659 snd_soc_audio_graph_card drm backlight tegra210_adma snd_soc_tegra210_ahub crct10dif_ce snd_soc_simple_card_utils pwm_fan snd_soc_rl6231 typec ina3221 snd_hda_codec_hdmi tegra_aconnect pwm_tegra snd_hda_tegra snd_hda_codec snd_hda_core phy_tegra194_p2u tegra_xudc at24 lm90 pcie_tegra194 host1x tegra_bpmp_thermal ip_tables x_tables ipv6
[  245.626942] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.12.0 #5
[  245.635072] Tainted: [W]=WARN
[  245.638220] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
[  245.645039] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  245.651870] pc : skb_release_data+0x100/0x1e4
[  245.656334] lr : sk_skb_reason_drop+0x44/0xb0
[  245.660797] sp : ffff800080003c80
[  245.664206] x29: ffff800080003c80 x28: ffff000083d58980 x27: 0000000000000900
[  245.671813] x26: ffff000083d5c980 x25: ffff0000937c03c0 x24: 0000000000000002
[  245.678906] x23: 00000000ffffffff x22: 0000000000000001 x21: ffff000096ae8200
[  245.686258] x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000004860
[  245.693605] x17: ffff80037be97000 x16: ffff800080000000 x15: ffff8000827d4968
[  245.700870] x14: fffffffffffe485f x13: 2e656572662d7265 x12: 7466612d65737520
[  245.707957] x11: ffff8000827d49e8 x10: ffff8000827d49e8 x9 : 00000000ffffefff
[  245.715306] x8 : ffff80008282c9e8 x7 : 0000000000017fe8 x6 : 00000000fffff000
[  245.722825] x5 : ffff0003fde07348 x4 : ffff0000937c03c0 x3 : ffff0000937c0280
[  245.729762] x2 : 0000000000000140 x1 : ffff0000937c03c0 x0 : 0000000000000000
[  245.737009] Call trace:
[  245.739459]  skb_release_data+0x100/0x1e4
[  245.743657]  sk_skb_reason_drop+0x44/0xb0
[  245.747684]  dev_kfree_skb_any_reason+0x44/0x50
[  245.752490]  stmmac_tx_clean+0x1ec/0x798
[  245.756177]  stmmac_napi_poll_tx+0x6c/0x144
[  245.760199]  __napi_poll+0x38/0x190
[  245.763868]  net_rx_action+0x140/0x294
[  245.767888]  handle_softirqs+0x120/0x24c
[  245.771574]  __do_softirq+0x14/0x20
[  245.775326]  ____do_softirq+0x10/0x1c
[  245.778748]  call_on_irq_stack+0x24/0x4c
[  245.782510]  do_softirq_own_stack+0x1c/0x2c
[  245.786964]  irq_exit_rcu+0x8c/0xc4
[  245.790463]  el1_interrupt+0x38/0x68
[  245.794139]  el1h_64_irq_handler+0x18/0x24
[  245.798166]  el1h_64_irq+0x64/0x68
[  245.801318]  default_idle_call+0x28/0x3c
[  245.805166]  do_idle+0x208/0x264
[  245.808576]  cpu_startup_entry+0x34/0x3c
[  245.812088]  kernel_init+0x0/0x1d8
[  245.815594]  start_kernel+0x5c0/0x708
[  245.819076]  __primary_switched+0x80/0x88
[  245.823295] Code: 97fff632 72001c1f 54000161 370005b3 (f9400661)
[  245.829151] ---[ end trace 0000000000000000 ]---


And here is another crash ...

[  149.986210] dwc-eth-dwmac 2490000.ethernet eth0: Tx DMA map failed
[  149.992845] kernel BUG at lib/dynamic_queue_limits.c:99!
[  149.998152] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[  150.004928] Modules linked in: snd_soc_tegra210_admaif snd_soc_tegra186_asrc snd_soc_tegra_pcm snd_soc_tegra210_mixer snd_soc_tegra210_mvc snd_soc_tegra210_ope snd_soc_tegra210_dmic snd_soc_tegra186_dspk snd_soc_tegra210_adx snd_soc_tegra210_amx snd_soc_tegra210_sfc snd_soc_tegra210_i2s tegra_drm drm_dp_aux_bus cec drm_display_helper drm_kms_helper tegra210_adma snd_soc_tegra210_ahub drm backlight snd_soc_tegra_audio_graph_card snd_soc_audio_graph_card snd_soc_simple_card_utils crct10dif_ce tegra_bpmp_thermal at24 tegra_aconnect snd_hda_codec_hdmi tegra_xudc snd_hda_tegra snd_hda_codec snd_hda_core ina3221 host1x ip_tables x_tables ipv6
[  150.061268] CPU: 5 UID: 102 PID: 240 Comm: systemd-resolve Tainted: G S      W          6.12.0-dirty #7
[  150.070654] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[  150.075438] Hardware name: NVIDIA Jetson TX2 Developer Kit (DT)
[  150.081348] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  150.088303] pc : dql_completed+0x1fc/0x20c
[  150.092401] lr : stmmac_tx_clean+0x3b4/0x798
[  150.096669] sp : ffff800082d73d00
[  150.099979] x29: ffff800082d73d00 x28: ffff000080898980 x27: 0000000000002ce0
[  150.107115] x26: ffff00008089c980 x25: 0000000000000000 x24: ffff000083c88000
[  150.114248] x23: 0000000000000000 x22: 0000000000000001 x21: ffff000080898980
[  150.121380] x20: 0000000000000000 x19: 0000000000000168 x18: 0000000000006540
[  150.128513] x17: ffff800172d32000 x16: ffff800082d70000 x15: ffff8000827d4968
[  150.135646] x14: fffffffffffe653f x13: 2e656572662d7265 x12: 7466612d65737520
[  150.142781] x11: ffff8000827d49e8 x10: ffff8000827d49e8 x9 : 0000000000000000
[  150.149913] x8 : 000000000003ca11 x7 : 0000000000017fe8 x6 : 000000000003ca11
[  150.157046] x5 : ffff000080d09140 x4 : ffff0001f4cb0840 x3 : 000000000010fe05
[  150.164181] x2 : 0000000000000000 x1 : 000000000000004a x0 : ffff000083c88080
[  150.171314] Call trace:
[  150.173757]  dql_completed+0x1fc/0x20c
[  150.177507]  stmmac_napi_poll_tx+0x6c/0x144
[  150.181688]  __napi_poll+0x38/0x190
[  150.185174]  net_rx_action+0x140/0x294
[  150.188921]  handle_softirqs+0x120/0x24c
[  150.192843]  __do_softirq+0x14/0x20
[  150.196328]  ____do_softirq+0x10/0x1c
[  150.199987]  call_on_irq_stack+0x24/0x4c
[  150.203908]  do_softirq_own_stack+0x1c/0x2c
[  150.208088]  do_softirq+0x54/0x6c
[  150.211401]  __local_bh_enable_ip+0x8c/0x98
[  150.215583]  __dev_queue_xmit+0x4e4/0xd6c
[  150.219588]  ip_finish_output2+0x4cc/0x5e8
[  150.223682]  __ip_finish_output+0xac/0x17c
[  150.227776]  ip_finish_output+0x34/0x10c
[  150.231696]  ip_output+0x68/0xfc
[  150.234921]  __ip_queue_xmit+0x16c/0x464
[  150.238840]  ip_queue_xmit+0x14/0x20
[  150.242413]  __tcp_transmit_skb+0x490/0xc4c
[  150.246593]  tcp_connect+0xa08/0xdbc
[  150.250167]  tcp_v4_connect+0x35c/0x494
[  150.253999]  __inet_stream_connect+0xf8/0x3c8
[  150.258354]  inet_stream_connect+0x48/0x70
[  150.262447]  __sys_connect+0xe0/0xfc
[  150.266021]  __arm64_sys_connect+0x20/0x30
[  150.270113]  invoke_syscall+0x48/0x110
[  150.273860]  el0_svc_common.constprop.0+0xc8/0xe8
[  150.278561]  do_el0_svc+0x20/0x2c
[  150.281875]  el0_svc+0x30/0xd0
[  150.284929]  el0t_64_sync_handler+0x13c/0x158
[  150.289282]  el0t_64_sync+0x190/0x194
[  150.292945] Code: 7a401860 5400008b 2a0403e3 17ffff9c (d4210000)
[  150.299033] ---[ end trace 0000000000000000 ]---
[  150.303647] Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt

Let me know if you need any more information.

Thanks
Jon

-- 
nvpublic


