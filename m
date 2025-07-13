Return-Path: <netdev+bounces-206415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3F7B030C7
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 13:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFD07A1D4E
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 11:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731D8228C9D;
	Sun, 13 Jul 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gN5FPa1c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3681A83F9
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752404938; cv=fail; b=u5DugY8RYlBRRrbiG4TqnrQOAeyNBNR2/OJMkVm7i7TfK8kEDMVHt1fBpDik7Y7LEazXLt+744RndeTzaNqB4ieQLR202kKJ+GHp9SBCIE7rFBtE3h8KfvvobVNVtjjwuJCbTdNORFEeoxiNgrcVyBfi57lYSDODYZb0rnPlbso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752404938; c=relaxed/simple;
	bh=k0SD2etz9khuqwev5RToAadiI1H1ZuJKuKQsgavDzGQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S7qpD5ephDFYt++R6eDYeXxIJGWtSWsvDlkav8vPAgFLyiPweGAG9Vw42OHBjkQ7bRfDjifByPrj/D4cH5lryzmK5LjBObhL3ueIElCuHWVfFq/WyVN6cbNRUg5GmuPQN8chYgrta7SnSPWU1IF+ooV1bPX9OrrjuxjbLlypqJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gN5FPa1c; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXlmnanNoA60cJrcoL4IVL69cdBZuzNCN9HZ6aXnGAoh+abfdpKrv83jrhGm1LkqHqnKqWtSDXXCjKNYLVky4NtQLNYbhx99h5TYojHrNU651PKnbbBb6mmVSXsUoJzrNsoUguShf+pT8Oy8Y/ZVGvfuNDClbS3NoT2oNoGtIM5Gc6eqHs/JVLcwOUu7ichoATJHyrpxMu5iMj7bvdNgQY6l5QXBofR4uYCvJClrIAkBUvsmeqVt/ujv5+pwpxWJIX9KRpPa+82vlDgVpMHFYkX1JV/uA5xkZYRrH2GjTaOyLjgGCOri1VrQBDJlpSwuc8bU5JzExCJQnpmvF6Yzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIt9421D1o79o4a762MBM15pGnIHUkfSmIGL/hFEeUo=;
 b=XhNAKWL2zddp9aQLFstDLHwBmNoTi5QgJtJcbiwYQ+oJTtToRE35f6/dz0War5KZH95OEoVVnxrxH4eWly+6+3bMotu9V21YZEX35PcnJeO77Avd6XwKys3b6lUPeihxx+gWfTtTaR/6SqdvYwbjdId5dcgrrdUkF3Xm5knN6VxKD4QlGEP8x3oJ2g056Iuug+Gxnif34recdUAG+9vQpuaYGGXkaJA7Tpoens8LparQo4KSqrSm28Jszlw8LmgvCe9f9ovMafyy/MHV/PlP5a4Vgs78RrT3QXSTk2YI23rLUwUgrLHqWq5mLX7HaCOIr/GO9NqxUb4t7eldJ13jgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIt9421D1o79o4a762MBM15pGnIHUkfSmIGL/hFEeUo=;
 b=gN5FPa1cTX/ONBbBDZaBRHcDISqrDwaGeWUW/XXfqP45DF3Ujac+uVNCc3Nco1IlM/YByD6z1hAnvnNXB5PcQi68TEKOdGEMzvkZggctRs46/7EFP8aeHa9kS+TZW0Vda5J7gQpacFCMkZFyUDqufKMQpMbuJazUGguUxedA3tNnYx1Lx/KaEbOwktgvmA3fu/53Bb//Yo1nxyvIIbyeRv3AJAIKTT0u5vsLwvKuspcnbCdnMf2CzHHDp9Krt7yrY4eoinmxSfn+kF7nHdC4JEYgWIZmXN1HdDUIc53l8xLyx5nhPgvHxp5ZMlGbhd3J8ziErak4NPBVZZuLipvHxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 11:08:54 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Sun, 13 Jul 2025
 11:08:54 +0000
Message-ID: <cd1af256-1447-4b94-8cf5-8e41014f7bad@nvidia.com>
Date: Sun, 13 Jul 2025 14:08:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/11] ethtool: rss: initial RSS_SET (indirection
 table handling)
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250711015303.3688717-1-kuba@kernel.org>
 <20250711015303.3688717-2-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250711015303.3688717-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd43519-9131-4175-f1bc-08ddc1fda770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckhNUDJDdW5YUmVOekRKNEx6V1FkdHc5dHdLdGR1UDFBVGo1M0diNzJZeDRH?=
 =?utf-8?B?RGdTMjY5QWV4WmR0MjFvZmZYc3hLbFV0STJjcXloM1FmTHgydHg1SVJBbnBR?=
 =?utf-8?B?WEVsNFJUVDNxbXBwZlBqdndBRWxDR3o4b1NYS01VRi83aVFVSWhwVmJqY0ZG?=
 =?utf-8?B?Tzc0ODZzMVJvdE5HOHZqSEdWbG9kL1BkbDNJL2xsdzg1TEx4R0syOWxaVWZt?=
 =?utf-8?B?MzFHMzhVSHVrWkFSZnFRemdMdHVETkY5NU00ZFlDUGRKUzQzRXFOS05SWVRz?=
 =?utf-8?B?YWNDb2M0VWJNQ3pFRlhSQytZZmdKaEhaaTNxSUFFUG1qZ0gwQklWOE0rdzJt?=
 =?utf-8?B?bXZ5UVhFVWNmM0gxcWs5b213elFpZkZXa1pPMFlsdXZZcVYzTWZnMVdlSGhN?=
 =?utf-8?B?UXBVaVBuNHNxczl6M2U2eVI2TFNneFFic3djNFJYc21aZWgrcTIxT3kyOEJ3?=
 =?utf-8?B?WUk3MXhQRm5IL2o1QVc4SXVJN2YvdlNiQzVheXA4TDI5SElQZTlydFR1TUFp?=
 =?utf-8?B?cnp5Q0lDSHZEbmVXUTAxWjV3RGdqM0JOSmxzRTVGdHlEMFVuMzFzNTZSUVBl?=
 =?utf-8?B?VGI0SmZ5YklGekJld1N2eDZwV0Z6SEQyOEpEK1dvWWVzOGo5eEtDSDJocG1v?=
 =?utf-8?B?OXBqblJkZTh0SG9ic3NYTDVPSTV4NHpaSEhGbWVrVWYzOUd5Nk9sMTVEVEtY?=
 =?utf-8?B?dTRTbUpNU0syYWpQQ3lJdCtLNWF3Q1h3QnRUNTFLcDJzZ0djNVIzYmdTYURN?=
 =?utf-8?B?ZFJnZ3RmZEI4MitybnFFYmk4ZFk3QklBL3NvMEFpaUI3c1VydWx0Q3pjUUFS?=
 =?utf-8?B?ZTc0NjU5SnF4eHRFY0FscmNTZVRxQ0ZnaEJSSE9TSXJxUkgveElQcUlqKy9J?=
 =?utf-8?B?NW5mV1Q1aDFhcVZBc2FuM0lmSCsvbHBocVRTNndlalVzMGtTT0lUUWRlT2l1?=
 =?utf-8?B?ZmtzOXNiSm10QnpEUWszMEozaU9BaUZIS0VlZW9hYytKSUcxWUdjQWM4cWhX?=
 =?utf-8?B?WmhGa2NvdFl4aGNoOUtrMXQ2ZHh4VDgyQWMyZ3l1YzRwY2NDVnZLd1BDSE9z?=
 =?utf-8?B?bzVOZWhINE1nWTRSOThpL3FiUnNhV2FrNnluVVNqV1NJdjZVeFFjRXhudkww?=
 =?utf-8?B?dmdzellNVXhOc3p5ZUlhVXYxTkNXYzNza0xraEUya2ZqUzA4UlhCTXRYc3NW?=
 =?utf-8?B?cGdYTmR2V0ducFV4UC9wbmZjSzRkaGFKeGFjL1k2VWJGVVUzWDdYNFFsYnUx?=
 =?utf-8?B?cTMrWEpqK1dHdmlxNHNrdzZ6MmFYQmhNVTZtUU5pK2FmY3pUcnZZL2tpdEg4?=
 =?utf-8?B?WTNuSGxMZ1QyNlVvN1QyM2c1VmhBQ3grSlJGYlRMaTlFb1I3ZEVnUit1YUNI?=
 =?utf-8?B?SndpalB5dmFyWnl5d3RwV1BIMHp6cGNIY0htS3N2WVZ5aUkwOVUxZkNjQUtw?=
 =?utf-8?B?OGNUQUNWR2NMRWxPR1VsTjM5Y1E5L1g4MnFRNGRycHNTTmFsVnBZb3UrLzFu?=
 =?utf-8?B?TUNOWTQySG81bnM0d0VQb1dKUDNlb1ZROWpZTDNScDF5WEFoZmJKOXR6djdF?=
 =?utf-8?B?b2NrUDZPVWVnZDJlNGRXM2xvTlF3b3BKc2QxQmhzVlNKaGhocll1clIxWE1B?=
 =?utf-8?B?bllEMHNwOVBzNU5Fd2g1M3lVenlnbis0YUNpVVRIMEl6WHY4VU5HcDlheEFM?=
 =?utf-8?B?T1dKbVlGRHhYU28yeWVqek51ejZNOVJwT0RWYk03MjBqV0RxTGJRMUlROHVs?=
 =?utf-8?B?TW1hVXNZclhhMWZTM2tQRVpRZzZWdjNKODVwcUZwUVhNZi9GS25seUdBRHYz?=
 =?utf-8?B?ZFo1NkErdTNDZG9YZXhiRVNDQlNzZU9NUUNFMUpZWUI4Z2FiNDFyR0tLVUxX?=
 =?utf-8?B?R1V4TUV4UzZMSjVEQ3RFanVvdU0wMHBaNSszeFZqUjhEY0QveFhxS0J3eCtq?=
 =?utf-8?Q?mXpoUBuB+QM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnRvRmxaRlR3UzUwMzgrVWhwNUd4OGh3aTNmcGZvbmt0Tk1tcGlnd0ZPWEJw?=
 =?utf-8?B?cC9sNExPMXp2ZFA4WFNsaUQ3OTJBdG1LblZpZWpMamVJVE5aVSt3T3V5Qy9i?=
 =?utf-8?B?Z1dzK203UnVPbTY5WW5kaW4vUE9NVE1IeTVxYkxYb3o5TXhVdWZXTmtHb2VX?=
 =?utf-8?B?QXpUM2dVTm83Szk5cnEwRTFvTUowREhicFNkdVo5UmE1T1RaM0kwVWxSUUxR?=
 =?utf-8?B?RDNoeWszLzI5MzFrV3JKWTJlS0hMaUlYdmkycC9kdU4veHBqSERKb1hMMXMw?=
 =?utf-8?B?UWNtV1hyN3lSRnlMZDNTNDRneEMvOUYyTm1kZkt1WjRvRk9ndVpCeVc1RERz?=
 =?utf-8?B?SFBIMThGOWMxSmhMdXd6UUZXVVFyV3JzaDBxRjFJeURCN2VYOHRsMXdWVy9R?=
 =?utf-8?B?UisxRnovaXR2WnFpaXN2cWtaSmxJTkxOV2NmTVE5WDUzREhBMkR1a1hTRzZk?=
 =?utf-8?B?VGVHLzdXeEFXdjRQb0RORitEcm53RVV0Tnhqbmg1Vmo2QWhRUTNuYTg4Q1Bn?=
 =?utf-8?B?cUQ2QlhhdVVJUVVONmVjb3FiMmRqdTViemg4b3dJTStlM0ZSUVFMVmN6YmZ3?=
 =?utf-8?B?eHZHd0ZrQ2ZEL1htajJsdUJTaGNObkJnZGFCNElvQ09kbGZndm85V2loYkQ4?=
 =?utf-8?B?K1JGNVQ2LzcwMDBpQ3E3My9VZWFDMmdnV3Nja01DZTRQN2FxZDZjUVlUVUUy?=
 =?utf-8?B?M3M4T2VvaFRkNHpNMVh0d016WDlRS2lYWjhteXVXN0pLTS9jQlZkU3Budi9a?=
 =?utf-8?B?QXg0dCt2cEFCeUh1QlJRYzVKd3BzaW9Vd2hRdExRZm8wcHpMd0s2a09EZkRP?=
 =?utf-8?B?Q1kraFNqcmZtaVRYZEh1RDBoVXNhRXRIWDJGbFRyLy91TE1Kcnp0WGN4SnNa?=
 =?utf-8?B?elR0eWZ5Z0lqeWZYY3Q1bDNPellXUlVaUDZHVm5Ubmw2dW5kS2c4YXErTFFF?=
 =?utf-8?B?MzdxRVhESTdRTUhsVnNwa20zZER0ZlRHSWdVTkhYK3o5dHhBR3pIVVl1cWx1?=
 =?utf-8?B?QlBBV0srZzc4NVR1M2kwUTJpQnc1c2ZyeSsyRms5VDBjNUxSc3l1UUs5SnF0?=
 =?utf-8?B?VG03OWpneVk5ZEhFTjFYVzNTaVVhcGI1Y09KOGFzS3c1SlBJOTZkdUJZeTd5?=
 =?utf-8?B?S2FpTlNmQTMrd09HSU9FMEgvbW9PTGNEcDJQMDRtcXBQUXlyT3ZrRXBoS1RY?=
 =?utf-8?B?bk5XODJRREl6NWdHN3Y4WDJKOEo2VGJIb1hDNDhYdU5YaVhTUndjTHUySFFK?=
 =?utf-8?B?SDY3bGlPVlJReXF0VDJyclBzR0R6c1VCTUNmdVdQblZ5QTdSanppTWlJYjNS?=
 =?utf-8?B?LytCcFNxMmtEbmwvblpncWF5V2lqNGdpV3RMb0NLU1pNWHZlWXBBdFZabkQ0?=
 =?utf-8?B?RWQ0ZFQrWFFKeldDK0taZjVvRkduTWtoaG8zNktaYlphMjFqQ2Z5c2g1c0JI?=
 =?utf-8?B?YzgwKzJwNzgwQXk3bE1tM2YwNE1nZ2JKVW5vencvejdpUzYzNi9aYzIzaDJ0?=
 =?utf-8?B?T0RKMnp6a01rV0dYdkVadEhSUGNtVWJrdENRNTZwMjZIeEc2OHZHSVRsYWVh?=
 =?utf-8?B?cmlDUUtjRWNEK25ITFlPOFh1TEtRaUlDblZoOFppcGdpN3d5b0xiSnkyWXRq?=
 =?utf-8?B?a0kzSDZvbG02UlN3bFB6U2RTNUhqTTc1SzM2WkpQWGMySnFsdmgzbkxPQWhy?=
 =?utf-8?B?Tno3a0JJTXBEQU9VVmhidVNrNVhFNTFlSUltdUJGVlF1dWR5b2d1YmtqUDV5?=
 =?utf-8?B?WHQzQTNpR1FLUm92RW1pYWVNNWRBTWx1YWZHT3oxaHI5VXZlOTluZVJ4UWNn?=
 =?utf-8?B?MTBqNnhTY2ZROWRqdEZOOVpzTW1NemorQnVtVXFMRTJ1eFNub3dOMzRMU0hL?=
 =?utf-8?B?YStoN0UrTVQrMk9jTDdyVjVidW1Wb1ZVRU5IVmN0Vko2eW5nbmphVlo0RmFL?=
 =?utf-8?B?WE9QVGJPVUk4M1hXN0lDQ0UzZ29zMXdmQjVFRHNiS3dvaTIybk1tc1NRK1dI?=
 =?utf-8?B?M2ZSdDMwMmZQUWVCd0dIczcwd3VvckRPakRKTTNNRFVZR3V5ZEk1UFUxc0Za?=
 =?utf-8?B?S0dQQ3haR242R29CUmRlSGdrZGZHRkJUcjArbEgxYXNYNGQwM2FHZXVDTFV3?=
 =?utf-8?Q?rIp9Ah44vJARSw0+Rk8L3Z+eZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd43519-9131-4175-f1bc-08ddc1fda770
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 11:08:53.8984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27ZVpE9k0Pf8Lc1F9l10CfUzmWkqOHAhibDCKtWBR6+VDXtUzmxCkGXJdSJXGx3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513

On 11/07/2025 4:52, Jakub Kicinski wrote:
> Add initial support for RSS_SET, for now only operations on
> the indirection table are supported.
> 
> There are two special cases here:
>  1) resetting the table to defaults;
>  2) support for tables of different size.
> 
> For (1) I use an empty Netlink attribute (array of size 0).

Makes sense.

>  static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
> diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
> index 41ab9fc67652..7167fc3c27a0 100644
> --- a/net/ethtool/rss.c
> +++ b/net/ethtool/rss.c
> @@ -218,6 +218,8 @@ rss_prepare(const struct rss_req_info *request, struct net_device *dev,
>  {
>  	rss_prepare_flow_hash(request, dev, data, info);
>  
> +	if (!dev->ethtool_ops->get_rxfh)
> +		return 0;

What is this for?

>  	if (request->rss_context)
>  		return rss_prepare_ctx(request, dev, data, info);
>  	return rss_prepare_get(request, dev, data, info);
> @@ -466,6 +468,192 @@ void ethtool_rss_notify(struct net_device *dev, u32 rss_context)
>  	ethnl_notify(dev, ETHTOOL_MSG_RSS_NTF, &req_info.base);
>  }
>  
> +static int
> +ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
> +{
> +	const struct ethtool_ops *ops = req_info->dev->ethtool_ops;
> +	struct rss_req_info *request = RSS_REQINFO(req_info);
> +	struct nlattr **tb = info->attrs;
> +	struct nlattr *bad_attr = NULL;
> +
> +	if (request->rss_context && !ops->create_rxfh_context)
> +		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_CONTEXT];

If we wish to be consistent with the ioctl flow, we should also check
that "at least one change was requested".

i.e., if (!tb[ETHTOOL_A_RSS_INDIR]) return err?

> +
> +	if (bad_attr) {
> +		NL_SET_BAD_ATTR(info->extack, bad_attr);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 1;
> +}
> +
> +static int
> +rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
> +		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh,
> +		   bool *reset, bool *mod)
> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct netlink_ext_ack *extack = info->extack;
> +	struct nlattr **tb = info->attrs;
> +	struct ethtool_rxnfc rx_rings;
> +	size_t alloc_size;
> +	u32 user_size;
> +	int i, err;
> +
> +	if (!tb[ETHTOOL_A_RSS_INDIR])
> +		return 0;
> +	if (!data->indir_size)
> +		return -EOPNOTSUPP;
> +
> +	rx_rings.cmd = ETHTOOL_GRXRINGS;
> +	err = ops->get_rxnfc(dev, &rx_rings, NULL);
> +	if (err)
> +		return err;
> +
> +	if (nla_len(tb[ETHTOOL_A_RSS_INDIR]) % 4) {
> +		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_INDIR]);
> +		return -EINVAL;
> +	}
> +	user_size = nla_len(tb[ETHTOOL_A_RSS_INDIR]) / 4;
> +	if (!user_size) {
> +		if (rxfh->rss_context) {
> +			NL_SET_ERR_MSG_ATTR(extack, tb[ETHTOOL_A_RSS_INDIR],
> +					    "can't reset table for a context");
> +			return -EINVAL;
> +		}
> +		*reset = true;
> +	} else if (data->indir_size % user_size) {
> +		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[ETHTOOL_A_RSS_INDIR],
> +					"size (%d) mismatch with device indir table (%d)",
> +					user_size, data->indir_size);
> +		return -EINVAL;
> +	}
> +
> +	rxfh->indir_size = data->indir_size;
> +	alloc_size = array_size(data->indir_size, sizeof(rxfh->indir[0]));
> +	rxfh->indir = kzalloc(alloc_size, GFP_KERNEL);
> +	if (!rxfh->indir)
> +		return -ENOMEM;
> +
> +	nla_memcpy(rxfh->indir, tb[ETHTOOL_A_RSS_INDIR], alloc_size);

ethnl_update_binary() will take care of the explicit memcmp down the line?

> +	for (i = 0; i < user_size; i++) {
> +		if (rxfh->indir[i] < rx_rings.data)
> +			continue;
> +
> +		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[ETHTOOL_A_RSS_INDIR],
> +					"entry %d: queue out of range (%d)",
> +					i, rxfh->indir[i]);
> +		err = -EINVAL;
> +		goto err_free;
> +	}
> +
> +	if (user_size) {
> +		/* Replicate the user-provided table to fill the device table */
> +		for (i = user_size; i < data->indir_size; i++)
> +			rxfh->indir[i] = rxfh->indir[i % user_size];
> +	} else {
> +		for (i = 0; i < data->indir_size; i++)
> +			rxfh->indir[i] =
> +				ethtool_rxfh_indir_default(i, rx_rings.data);

Unless you wanted the mcmp to also take care of this case?

> +	}
> +
> +	*mod |= memcmp(rxfh->indir, data->indir_table, data->indir_size);
> +
> +	return 0;
> +
> +err_free:
> +	kfree(rxfh->indir);
> +	rxfh->indir = NULL;
> +	return err;
> +}
> +
> +static int
> +ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
> +{
> +	struct rss_req_info *request = RSS_REQINFO(req_info);
> +	bool indir_reset = false, indir_mod = false;
> +	struct ethtool_rxfh_context *ctx = NULL;
> +	struct net_device *dev = req_info->dev;
> +	struct ethtool_rxfh_param rxfh = {};
> +	struct nlattr **tb = info->attrs;
> +	struct rss_reply_data data = {};
> +	const struct ethtool_ops *ops;
> +	bool mod = false;
> +	int ret;
> +
> +	ops = dev->ethtool_ops;
> +	data.base.dev = dev;
> +
> +	ret = rss_prepare(request, dev, &data, info);
> +	if (ret)
> +		return ret;
> +
> +	rxfh.rss_context = request->rss_context;
> +
> +	ret = rss_set_prep_indir(dev, info, &data, &rxfh,
> +				 &indir_reset, &indir_mod);
> +	if (ret)
> +		goto exit_clean_data;
> +	mod |= indir_mod;
> +
> +	rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;
> +	rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
> +
> +	mutex_lock(&dev->ethtool->rss_lock);
> +	if (request->rss_context) {
> +		ctx = xa_load(&dev->ethtool->rss_ctx, request->rss_context);
> +		if (!ctx) {
> +			ret = -ENOENT;
> +			goto exit_unlock;
> +		}
> +	}
> +
> +	if (!mod)
> +		ret = 0; /* nothing to tell the driver */
> +	else if (!rxfh.rss_context)
> +		ret = ops->set_rxfh(dev, &rxfh, info->extack);
> +	else
> +		ret = ops->modify_rxfh_context(dev, ctx, &rxfh, info->extack);
> +	if (ret)
> +		goto exit_unlock;
> +
> +	if (ctx)
> +		rss_set_ctx_update(ctx, tb, &data, &rxfh);
> +	else if (indir_reset)
> +		dev->priv_flags &= ~IFF_RXFH_CONFIGURED;
> +	else if (indir_mod)
> +		dev->priv_flags |= IFF_RXFH_CONFIGURED;

One can argue that IFF_RXFH_CONFIGURED should be set even if the
requested table is equal to the default one.

> +
> +exit_unlock:
> +	mutex_unlock(&dev->ethtool->rss_lock);
> +	kfree(rxfh.indir);
> +exit_clean_data:
> +	rss_cleanup_data(&data.base);
> +
> +	return ret ?: mod;
> +}

