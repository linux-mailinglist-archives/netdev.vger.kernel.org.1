Return-Path: <netdev+bounces-152648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9629F5038
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4782016FA0C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AA91F758C;
	Tue, 17 Dec 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CYBM46Td"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55FB148850
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450432; cv=fail; b=slivrrpr7nJWdVrHgQk7m4Wocg9628uT+v+/7vopYuFK49vOcYHVs8h8eg3tPAoH/zgf/krPfl9Fumze+a4PS/uOaXqzspMBnirMlOV6UyY3ze75AlTQDMgwLx+48Sc/uVlXVITygLY0fFtdwr/0OtNWBsqwZLlRojIj722dBXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450432; c=relaxed/simple;
	bh=icFwV6UM6eHeV8kwuOVYjtE2o9l3svZQeL0v1jI8VFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kor7XV7R+WDZ/cYmRskqe9IeHzyy3wkTDubXtqUL0eph0dY0pLaPq3E5p+MubbDD9MiSk7PwCHPyzvtRpwCKC6HVjY/E5bZkKzwtif8qY7VVydiHHnGeYWCOgj0KmMuNU5clNQEy5B3lV68h2mUwJXwaGKqk+hi1Mb7l1a2n67Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CYBM46Td; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owFT+hnXwu12Ut8sHWszurFXZGlq4ojMCz00CeBq9X68tkVdVZMb9VgPmU32PF2LCLEdDA9CuwjvEI4Um4DpDtq7vknZbMwKJmfGMRU9aswVbEJD6iorF+SnqZsXMeVN63WL3GfNMBrDMPFjtvWOijmSNrSmrPyN9i2vXaHxLhjwyBjtWWr+joMfzVtKXN3/JCyZWr1O/4tf0XATRhyyPd36IRRUpMopU+kao4cIUP2/SzQqjTdRcpVr15x/RiZPHKiX3qPh+QAah1t7Z6LBtMIUzas5eMJAi9dAXh8PE7A2crKiYoDQYa3Me0Val+cmBoUOz+amtUjsi9hWvmpcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f7vOYKjKn+DZ6uZOsSTCOhaDjPGq7aSmGPWBxQQwFQ=;
 b=jvS4Wt5O4vEjVTonNUcn1PE/8aJZs+LL0nBoBXIvQ+GhGnklbafNAAPa53fAdJKoVc8ZMO7k12qcfVo5CaQOW3EBv9CZM4NuUUBbYRHVKXa5SvWMCEsyUzlwnVPqSWiPAX6i22xqETfoEm0AEYnpAzAFNFDVY0rvtJsh2mBAQ8Tp054GeInA9wP/hIHgKHdouekcTYn6tBj7Zytopr6k9zRYkRrWYgK9PIH2WOOW/8cKAsboZ6z5itMCSWcMI4zqsOgO8pL/507MGByy9++0E4jr/IdcenB+VZ2k7nFHwX21OdK+EsAuPE3NKdkibJydpfQeQpn3wDAgmzs9edE3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f7vOYKjKn+DZ6uZOsSTCOhaDjPGq7aSmGPWBxQQwFQ=;
 b=CYBM46TdsR5rNPIAV2vuNjScD45/DElQ4R5jQzh4ECAPDDnKnWM/P6UGe0wMwNawLeJos0ufACxicoHKRg5lwBNqV1BJWwW320BvfG5ABJQPypbIIpqJFjbBDi1hEpc4twhI/GZcAt+UeFCfZ+476UY1Th+5yHMDrNuNTIH6if5e+3+hh6Ypa6b+MDwFJmilGxq5Yi5SvpunqANd65Klihgxuxptq2vLGEIk50h0GtqUC/wC+urt8jsHGPnjxVEKSBFq86unUv2CYKfEFUY0qK/VmMTKyuIN8nNlrYgzWsXVcai22AVzwdFtT/dCPQgo6Ra4WAoNYesofZ183lTOIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 15:47:06 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%7]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 15:47:06 +0000
Message-ID: <80b140ac-e9ff-45b2-ad4e-f18f12be531f@nvidia.com>
Date: Tue, 17 Dec 2024 17:47:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/12] net/mlx5: LAG, Refactor lag logic
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 rongwei liu <rongweil@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-3-tariqt@nvidia.com>
 <93a38917-954c-48bb-a637-011533649ed1@intel.com>
 <981b2b0f-9c35-4968-a5e8-dd0d36ebec05@nvidia.com>
 <abfe7b20-61d7-4b5f-908c-170697429900@intel.com>
 <624f1c54-8bfe-4031-9614-79c4998a8d78@nvidia.com>
 <20241217065822.4243007f@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20241217065822.4243007f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::9) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 8112d793-c4da-4595-a482-08dd1eb20eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGVtb1dpa1RrWHBwRDl2UmVzdXp0UkxxTjJxZ0ZUaUF2cTFRdi9XUkhRUHZr?=
 =?utf-8?B?cGtlUWxGOFJZZHVGWnZHK2hDNExtSE5CWGxvakxRWGJXbEdmc2xUclUyRXRt?=
 =?utf-8?B?VGlTZ01qS2locVZncjhSV3ExUzVLL1BsTi9hVDlHZm1PYkt1WG9lRlpKcERR?=
 =?utf-8?B?THBqMHlSaWhscGczS29PNlVEL0tFV2QrN2JzWitBYVZ1cG1WWnZMMHYzSDZn?=
 =?utf-8?B?aDIzZHlsb09ENkFsMVB6b3B5am5lVEh6ajk2dVR1VGRwc3UveDh5ekg1NXZQ?=
 =?utf-8?B?cEUrR3RNU2VzQTI4RDZnOVZLVVI0N2ZWYm5uNXhXWTFIVndHNTNKa1B6dG1r?=
 =?utf-8?B?YllDNHVzVXlNSS9xQjZ6QzZVZFBpZGZvaGhLQUJ4UVFlZkhjaE8rb2hPYWc1?=
 =?utf-8?B?ZEpQbzYvQ3owN1dWRU1BeFJLNE5hSlIzWjVhcHd3bmE4U3RHN3lWdEtaNlBD?=
 =?utf-8?B?R2xpdkpDQllTa0hBRHNyc0pmNzZpZkxUM281YVovS0psODlldzY2SUU2V2k5?=
 =?utf-8?B?c3lWcmkyN0R6RjB1M1QzRUlPc2lzS3grOFQzbURnSGdhdkxkdjNKaml5aU14?=
 =?utf-8?B?QnVnTitDbVBBZFhDalNHYVR2bE80dWJRWk1YZ25sRUJGT0xxRUtYU0lYMy9V?=
 =?utf-8?B?aVc0Umowa3N5WmFxZmJ3UVN0WjRYOVpCZVpxaFRmVWVTWVh0cC9RMTlLTDMv?=
 =?utf-8?B?M3NJeHRKY1RRdXBveUJjU2psVDl5dy9XVWNyS1BRZXoxcjRzSVViUGV4bzFn?=
 =?utf-8?B?VGRZdHJNUDBRY1I1VitjeFJkczhQSXlIK0NmYjROUFJudHphQndnSXI1a2Zr?=
 =?utf-8?B?UFJGZWp6YkJYMXl5YTZpN0t3YTZ5SGhQUjBXbWwvMEZ0MWRuV05iUHhCSC95?=
 =?utf-8?B?M3FJMkN0UHhZVVd0KzdVeHFMZHQxRVFHdTNqeTVjUXJ5OFNBZW8rQzlnVTN2?=
 =?utf-8?B?ZEdYSkFnNjI2c1hMaGticXd1WWFUL1ZkeGtySldWMmxON0tWb1FpTXZnbHlh?=
 =?utf-8?B?ZnVvY1hCNWg1ZmFack5YeVF5U0xPZ2tzenhpMU8yQ1o0QmQyQm5wdmdhWTJ2?=
 =?utf-8?B?VXJqZmFMRTB3MGM3ZnFWQWRBWFBqNDBqb1hndnBhdzluVjlXdzlYZzBIa2dL?=
 =?utf-8?B?VmlGZ0V3V3ZXM1VxekFzR2t2a3VLSGpwUUZrVDcwcVVGWklJT1lzYUg3QTlP?=
 =?utf-8?B?b0lUK25Ia3Z1dlJFNGl5dGNMTTllSHFXYkFPcCtaNnhZZWhVZDZleTlJWHdX?=
 =?utf-8?B?UnRUUmJrallQMVJwalQ3bXJTc2Q5Z3pHOFNTWlpFQWN4Uy9MdTdSaXF3OG1x?=
 =?utf-8?B?S0x6ZFFRZ05hSXZmKzhGcUFjNnZpNEU0ZnJoL1lzMStXeUNjTzk2MkxVZ09S?=
 =?utf-8?B?RU0zUCtPdjZ4ekFiMW1DUkU3YVJ3UElSZEdBTElTS2pSVEZ3R2x0SWJqc2V5?=
 =?utf-8?B?cVplWFc1bkEzRS9HRWwzN3VQNUdITVVIRTh0cnI2ZmM4WForSXdZZEdmNnYv?=
 =?utf-8?B?cm9kVG9tK1J2VEFOeDdRT2ZOVWx6NnFDTFJuQ0Y3M3dmWWkvVDFuM2pXUHVG?=
 =?utf-8?B?VVJmRFlxS1lzY21mWFgyT2JOUE1QQWRqYzNkV3UwU3lMZnVOV0xVVml3M3dW?=
 =?utf-8?B?RDRrY09mb1dja2JScE1SWlhxeExIeVg5OUpVZGZPTE5hWm5xNjlrMXN4eXFa?=
 =?utf-8?B?MWdYS05DRTZmT1B2RHkrM1NWVGs3L3c5djFMbjEwVXVrUlBoQWZnS1N2UUsz?=
 =?utf-8?B?ZzBmS3NMWEJsbkliR3VFQlpZV0craDQyazRrQitoVWVPc1Q3OW9JYUNzZ3Jw?=
 =?utf-8?B?TWpTNXBIMFZKNEZ4UmpQaGdBQ3B5R0NTT3hKL0dqU0hIZ01LalBEbENIVFlm?=
 =?utf-8?Q?TGTR54aW4RvHw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWJzYVFJSVhlVHZwaXpMcDFyZnBjU3d1aDFUV1hmUFpYVDlnemI2aE8raEVy?=
 =?utf-8?B?Q01oVmhuMnQ2NlVkUmJFUmpUZk5ub0gvbWw2STN4ZEk0bEJGdURaNTVCakNR?=
 =?utf-8?B?SXBaQ2FSOGxuc3g0NUJ1T3VHV1RTU09XN0tpbGRsd0J3U0dCWmFwNVpwOWxx?=
 =?utf-8?B?M2ZHa0ZqQkR4NHlwelUvNnZkMmc0cGtuR29XS1RQQlVrUFF5RU5zMjZJVWp4?=
 =?utf-8?B?bW5MV2Y2RTBKWWczN3dMQUk3MmhUK1dCYlN3TUEyTUJvVEZDd2l3bWNvR1Iz?=
 =?utf-8?B?eTVESXhVdVZVbTlPU2ZBTUZGWXZWdXVXSHBCRW1FM2NEb2hGTUxJSFFKMWhT?=
 =?utf-8?B?OG9IUlBvSSttMTdxd3dVZWVvYWJFSGRDS2gzWVNIZVkyS1FGUFgveWRNdWdi?=
 =?utf-8?B?WW1VODRIMEFCY29uOEZxWm5mLzQrRW5GUGVmNVJOa01Qd0V4ZHBvNWVHY0Vy?=
 =?utf-8?B?R3VzZHkrUGgrbGVxalgyZ2tkQkpxcGl3cTFrZlpwTDB5cGo0RXhlZllTZUZ0?=
 =?utf-8?B?VkFER0RGZzVSelRSenh4ZUV6RVdpVXJqNzFVSTEydmF1TTNhMVBXS0VtR3pF?=
 =?utf-8?B?YjR6MmJCME4zL1Y1czVVdzllbmdyVHFvQkREMEVrSE13aUJ0TzBYalVzNy9j?=
 =?utf-8?B?a2tCMlYvN3o2WnE0YXpiZzRhZjEzVUZ0akdMMlFqYUxxa3FFYWR3cmRHL1lo?=
 =?utf-8?B?YWU1RDRGdVUxMi9RWkRDeTR4Z3FWMUN6WWUyeEhTSktjVUhOd01OYVpIUzhQ?=
 =?utf-8?B?MWNHbHhQRnVOYTNVQWNZVWdQUkR0NnBGZ0ZCUmRZSStWU2lDZ2YxbmFabVUv?=
 =?utf-8?B?ZXVhekE4bU9Bai9lR2VqM1NPMW5aMm9LbmtjN00vUWZEN3NiOGlNcDkrOWVt?=
 =?utf-8?B?NFJOMGNHUzQ1SmRwdXMrL0VZUVhjN1pOaWI1VzdJYXlhZzhhOGhOdityQmZk?=
 =?utf-8?B?Z0o5MmkxY0t6d2RscmlGekhqa2p0SExWazlJb2JkZTJpdXlFbmJkRldxb3ZR?=
 =?utf-8?B?eFpkUUZxMzA2QXV3aUQwald1KzdpZnd4OVMvMldSUlVjRnpKSEZqSURQMzNU?=
 =?utf-8?B?SnN1Wk1RMUNzaHBqckRIOUlaSCt6bXhCbUQvaEM1dVRjMEdrSllIcFVOSG5D?=
 =?utf-8?B?Nk9wa1ZDUWhDc3F1VFN4NExVbVE5UXZMaFpiZ0FnSVNLbzczcHBXcUJvalRa?=
 =?utf-8?B?UGJDUXFRZ2V0Zy9tUU9HaTgzeWNVNTB2Ry9kbWlQT1VyakRxYzRNT003RnF0?=
 =?utf-8?B?ZkhpZEx0WGRaTGdyRElUbzJESzgxUE9xM1JuOGRrRVFVSEdHNHZHQXg3bHpN?=
 =?utf-8?B?S3VNM2U5YzE1clNMalo3SHFMY1B6MGFCcjlxbWIzRXFEeHd4VTIvQjRtVnJw?=
 =?utf-8?B?VVk1bnlnNURvV1RENDRVeExFeDN6ekIwN0h3VWVVT2I0Ti85YXJXRTFVaU1I?=
 =?utf-8?B?QVdYQVZKbFJpdnlpbmc0R3BLbjZ5TnI3ZEtyUk5XdVBnWEZ2d2RLTGNuWWdI?=
 =?utf-8?B?c2R0MnQ0MGJPQzFOUHlkazBPbTNtS0x0MHY3a25Rc0RzVU1jWGd6WWQ5OHg3?=
 =?utf-8?B?RGswMm1LMjdkT2M0QkIxekJ3Ky9LRWlJT0d5SFdRcnN1Unk3L0hsVFp1MDc1?=
 =?utf-8?B?VXJJWGZucC9Rakx5dkp3WVB2dGZvamdHY0lVWmR0SzdJNXVhc1Q3Z25PRXlz?=
 =?utf-8?B?NVF0K0VLeUp4MS9QaUlrVGQ0ZHR1bmNoUC9ydzh1OUlCb0lLZEljSUpSYU1v?=
 =?utf-8?B?RWgxc1B2RXpVdGRLWEp2aGpCTkQ5RjJTRkduQlhOdHlKNWszbEg3S1dPVmM4?=
 =?utf-8?B?UTRIMnhxYTF1ek8zS2JmWmVXS1dQVVVKWHNyUGZaaDZ6M051K0JwMkJUampl?=
 =?utf-8?B?OXRRUmN4VGVSUjFTWE1VUUdBSEUzN1g1WWdWMmVTZk9aaVRudTFGU3ZvRW9G?=
 =?utf-8?B?cU1xSEgyZEFPVnFIRlJPVDNuYVNjbFJGYzlPTXFOaVNBRGp2MFU5TDgzQm1n?=
 =?utf-8?B?WlZPQVp0bU5xNnI4QVdCSHNyMnhQVHhHd2dvNDBBYm9FUHJCQngzaEFMYnlL?=
 =?utf-8?B?TVNPa1AvazFlb1ArWFVXYnI0UGZRNDJ5ejNhQzNKT2k5djZzTE95cjNVdWo2?=
 =?utf-8?Q?EWso+OVcVeS02wSOhUDC8P5NF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8112d793-c4da-4595-a482-08dd1eb20eaa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 15:47:05.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKyK/DH9v9f2EVz3BPI3vBR+x3pBCtfd5XvvqMww1DlOeu2wdbxw0ML82KBPCvDBTSWobobPyybV1pBOAvva2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489



On 17/12/2024 16:58, Jakub Kicinski wrote:
> On Tue, 17 Dec 2024 14:52:55 +0200 Mark Bloch wrote:
>>> All drivers must have its symbols prefixed, otherwise there might be
>>> name conflicts at anytime and also it's not clear where a definition
>>> comes from if it's not prefixed.
>>
>> However, those aren't exported symbols, they are used exclusively by the mlx5 lag code.
>> I don't see any added value in prefixing internal functions with mlx5 unless it adds
>> context to the logic.
>> Here it's very clear we are going over the members that are stored inside the ldev struct.
> 
> Prefixing the symbols makes it easier to read your code for people 
> who aren't exclusively working on mlx5. Also useful when reading
> mlx5-originated stack traces.

I agree with that, but since every entry point into mlx5 lag
already uses a prefixed function, any stack trace will clearly
show where the issue originates. I’m not strongly opposed to
this change, there’s already an internal version that addresses
these comments.

Just to note for example, a function name like txring_txq()
is fairly common with a generic name, and several drivers
use the exact same name, with fbnic being one such case.

I don't see a clear rule about this stuff.

Mark

