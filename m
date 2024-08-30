Return-Path: <netdev+bounces-123776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23F296679D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1864B273C5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106B61B9B3B;
	Fri, 30 Aug 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kP339k2/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415416C68F
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037660; cv=fail; b=YZwasMXMs7HAtO66UGmQbHjHyo9B1NCxhfykE/IN1wT/AQPTL0Czzb329lKWTiNhsjX16Qp0JXF2YcCjhsygywLFd8vAGG8qQKGu+2KP8AoVU6NtUEzUqLRK3WMH2xgUkOVMI9BzYlKE0opul3HK/Z7Nw6WrCXvphup1h4I8A3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037660; c=relaxed/simple;
	bh=evhUAMLrpZUEg0XbvG5mUNzoO6eHiYHGBMM30+vV1Zw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LLC43as1tqHadwXuWrVN2jAYbQ1hVRm9zDRfz4o0BpTnVmyN/Krjc5+yHsw5Cq4mDpRrk9r0j+ncbvQGIOZdiNj2s0qZ767//B2zxNfQFLUrV/WnEIzxYOiRUSSnTsNKMpKjBNomvh4woRiGmgDMFbbLxGjaTMVidrqT8l5tb24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kP339k2/; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj3laENuJx5Udpew1YLDDWfi8JV6/yjzQ68aLc2jCiIWd6gZ8LYIEBVHq1X+Ek0H8DpvT1VCMAgKFhax8Q8toyw+j2zRkv+qN+fGPUDDwuSfd2ITOViHiCgxxGhN4EGs5vci0fnsdhD+x9rFWCVeui/8LeNK2lCrnaJuGoCu2Uzx0Tj9yDHaweAfdTr11RHNHgoNpAJBovySNivm+V0wd2Ndg+b0R59I+QiJEQEYR7rlhtN7q47a4cJT8NaEtJBgWbqpuYoQE2S0KusRbSRqcPvLRn+GLGQGMbjl7ILe3oJ5TlMChE2Tmm917QKRSRz1METJqrJAthNgLO4d9Oe70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+6ie+9o2cfQ1KIj0SHkesUoi9iM9trqgWCTybczo5c=;
 b=L9NQux/e+WLCbvj2OHaMLfudd07Pc6jbDZKoYQ56pCVg60DsyRAfYd6o0R9Vdb7Wwbx44Hkt+hUv0VSK9/XX1nQNpkcIrabTal2CixQXvpJDsR9FbI/uIMPTLeymadf0/tXEr/3LQOoua4w+V6yOXOHDBiI2w8jZpc0RuNYtnSrmn3jKky7TqDWM0dDTuIjz2xn0iTYV1lhc++U7C9+fSEC4kZV0z/jEYBmwJH9sdr0UrSrNFipl3MZLh+LUo0P5vMkivWOFgX8a4Ad84MImA9vr8fizeoG6856cD2LdJIlwljG25DwLN17CCHLJLcgcB6x1QP/wy6QyvhcyOC/WbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+6ie+9o2cfQ1KIj0SHkesUoi9iM9trqgWCTybczo5c=;
 b=kP339k2/FY6lhDSqebDfh0THl2HKxOx2p73ziau21ZFX0+8hM7M1WESjB/DG0nqCkTgovppZxmAXmHrOLJIxhZdxip4Oc0YcaTc4GQ8wSOgL1trnIWgqdoEckL8IoKIF1daeegcJjhgf532Bie253YuvDosUdewTz7FAmETqj0hTcikLHm+6CLoYLrVYAxNG47hLJl3E995UoR2zhl8GKl1fq4Cz6lpWqRpqgnTvu6Pw0NGQiCU16n0YXWLSpZ8c96Eb0c62+1BvxUWJtDwTliOCm9JsW8jmmp5pudOS1xtZMRQkIBZRtiHnC5RGB1KoA1zRuXmJG3COX/tOzD1zwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 17:07:35 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 17:07:31 +0000
Message-ID: <0ce52835-e60a-4ca5-9001-ac48e5a6abf5@nvidia.com>
Date: Fri, 30 Aug 2024 20:07:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: Remove setting of RX software timestamp
 from drivers
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Sunil Goutham <sgoutham@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Dimitris Michailidis <dmichail@fungible.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 UNGLinuxDriver@microchip.com, Horatiu Vultur <horatiu.vultur@microchip.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Shannon Nelson <shannon.nelson@amd.com>,
 Brett Creeley <brett.creeley@amd.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 MD Danish Anwar <danishanwar@ti.com>, Linus Walleij <linusw@kernel.org>,
 Imre Kaloz <kaloz@openwrt.org>, Richard Cochran <richardcochran@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240829144253.122215-1-gal@nvidia.com>
 <20240829144253.122215-3-gal@nvidia.com>
 <20240829204429.GA3708622@ragnatech.se>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240829204429.GA3708622@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1b9949-ffbf-4369-d91c-08dcc9163b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1NwV2phWnBwYjRWekcxUzRqMUg1VlIreTZBbzVGQ2pmaStpMndMSEdNanQw?=
 =?utf-8?B?NmZLYXoxM080VGdYVWh2b3dkMDE2Z1N5cFJZN2VTUUUyUURhMG03aTZTSG9i?=
 =?utf-8?B?OWFBbnZaNWIrMmg2NFdFSitjN1VXSjZCS0ZCMCtzZnNCNDhMY0ZMTlkybGc1?=
 =?utf-8?B?cnM1Q2Q0eEQ4V2xIZlJkYzdjZy9BeTgwV3lrOHFwN0lmUlhWa2dKNnNiL0Ev?=
 =?utf-8?B?MldXaWc2YlRYOVBWajRXdC9raWI1SVhJZlorNzFYcnVRQ3VxQWN1SDJteFVz?=
 =?utf-8?B?amVSckgvSHF5alh2bkJZeVNGdXJEdm5yaU8zY2VvdlRuYjI5ZG5ia05nZzVv?=
 =?utf-8?B?eU54R3RzTXlnN3M4cUV3OEJXYVZlKzFNbTVGNitjUXB4UE94dnJ2MWNDcDJN?=
 =?utf-8?B?bmZ3Tkl0OGk0b0wzd1drWE5ZY2crNElxdGk5UC9IV0JtbEVRT1UrZmd0ZHdK?=
 =?utf-8?B?bEw1NDlZZ1NYeWZkUk9JUjV3dTUxNG1wbk9jSllIVXlITWg3dm4zeENsUmxy?=
 =?utf-8?B?SDZkS1JleUFFUmt2SHhpSS95WVNhMEdIWTVMdFI3M2ZBWjREVS9LUUQ3Ly9I?=
 =?utf-8?B?S2xBRjJpTmFOU1RYSUw1RXQ1dWZTMUUxVEcydlNjVCtDTG5uTmdabTFBSk1a?=
 =?utf-8?B?S1FkdjNCTW9LS1FHODM5S05VbEV4RzFnMG1yblBZYXFOV0dPVXZtUG5idlV4?=
 =?utf-8?B?by9NZng1TnovdVYySTdybFlkSi9tUkZKZVpKZGhyV2l5eEVBeVpnVFh4SFVh?=
 =?utf-8?B?TTVRUkcwb3B5b2xFd3BMT2NQNm1ZOWtCWTBYL2szR25nalFDVStLVGxVQm1W?=
 =?utf-8?B?Tmk2RWNQRitubU5JN2tnVXZQTHI5c2t6WDNMcjA5RjB3dmRhbE9sU2hONVNu?=
 =?utf-8?B?bTJOWkN3OWp2eEQxenpxZlYvT1BIWVNtdlhGaG1lOTR4dDZpS3kvRnBlWkho?=
 =?utf-8?B?bjZ5clJIUVhzRStldTdVbkVLblpSZXdlNHBiNlB2UllFbWpLZG9jNlE3M1Av?=
 =?utf-8?B?OTQ3cmpFbXlQVXN1UCtGcmF3L2ZzMUhVT1JYL05KdmtmdUJxMVIzT3BvTTEx?=
 =?utf-8?B?bFJtdVRvakFYbm1saHhJREFVaS9yaitRS3daZlRTSXF2YTVDWFFFV3F0MmU2?=
 =?utf-8?B?NkpVcVZmRXRtN2JpSXVGd00wMFgzdFEvVGxDSllUNzA5ZllVNmhvMDNDR0Ev?=
 =?utf-8?B?UDNId2xpQndhVGFoRVU5SHhXbFVEU0U2RGpZR2lmS25PQVNlbWF3K0d0dzY1?=
 =?utf-8?B?ekZORUV1c0VON0RpWlFCUzlyb1hjS0lyVVRDSytXRUV0RzlVaDhxQXdkV0di?=
 =?utf-8?B?N3pCRHpnMHpMTEFoMXNVME9VSVNOS1VmZ043dnlwVlRHZTBaYUFadXNKQVdY?=
 =?utf-8?B?djczN043OVJzRU5Za3lCMFlNUWpQdVR1NjVxZFp0dGQyZ1M3NERrRllSQklv?=
 =?utf-8?B?TXl4RWYwMVlhNE9wMjh0dUhDL1MxaFdkOEo2RXcxYlFpSVVsakNkZ0gybjgv?=
 =?utf-8?B?M3U0c2dwdlJObC9jTENCVzQrQzZMdmRXcTlOa2k0dFl6NnJ0aGdPQ3IzRWdT?=
 =?utf-8?B?a3RoN3d1ZjdicGxYbVQyWWJCd2lmUDR1dGNZS1o2aU1LZHlCZExYc1dZZTdv?=
 =?utf-8?B?d09sanFYNVhIYmpiRlcxYVVGNEhKYkhvUHRrSERsenNSR2s2Y3F5TXhMdFZ6?=
 =?utf-8?B?a3V4YzBlTGVBUkZHTlBDRGRIVzMzSTBFbHVrdGtTaHIvZmgvMVJQbGNwRTlH?=
 =?utf-8?B?WTdYRnQ2ZDVsNU1VNkpOb3BIcmw1eXdSdWJLZlpaN0FmcXV0bWZJcVlNSytZ?=
 =?utf-8?B?cHozdEZkL2NTcVVNTkU5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnU0YithMVBiWVlGWUlxRjZyTEhnTmgxbFlpbXF4Y3M4VEtsT1hsbGtKWEZj?=
 =?utf-8?B?NHpmYjhYc0llcGpIaG50aS9wZVB3SzNYSGNMUG5pL3dmR2VYZ1Nod3RsczI0?=
 =?utf-8?B?amc5TFdFZVlHNnFpWElKN3VyU2FWVmttU2l0RHNQSzhQblA2RTFoaGJVK2pN?=
 =?utf-8?B?ZVJ3VWFEWkYvWkpoKzJOTHo1VWhLYndKSFp2YlRYRWlHb1NxMkUrVUZzaTZN?=
 =?utf-8?B?Nm1wUXV4ZnFhUkJldmNaOUIvSXBQTmZIYkRHaUh3dEtkeUdNUmY3eGRRdGtz?=
 =?utf-8?B?THEyc0h3YTdIQWIwM0k4c0trdXE1U2tBRXUxNWVWQ01rQ29ZREVlNitKTjVV?=
 =?utf-8?B?OG41ZEdOQ1B3ZUJ4N0MybURPTVNPV1hoZk9idDdwZC80RmYyTnUrQVpHRFJZ?=
 =?utf-8?B?dFdvOHd2dDM3NzhISFp3cEE3dkdEc2RRdU1qcWI3YUhhcGY4N3BoNURJdDMz?=
 =?utf-8?B?eldrMzJ4ZUl5UzFwdW4zc1F1WVc4bzRUdVhJajBBNHBEVVkzMU01UVM3RmZq?=
 =?utf-8?B?NjNSd1p0d3cxU1RMZlVkUHA1a0V6MGpvY25iKzczZFQ5RXE1N3JkcWxSRTFp?=
 =?utf-8?B?MnQ2ZldoK3p0KzZnaVZkZkFGcmpFcEJJZjROc2xEZTBUSWhNZUloU0xRMjlr?=
 =?utf-8?B?WGxNcG0xc293TWlrTW1vazJQQitqYkZFZXd5TnZTNWh0bytwNCt2TXphNTVB?=
 =?utf-8?B?QkZ4c2NVTXlQU2hOSE9aZEgrMWNpRGwzT2hWd2U3Z0NBMWYxdC9FeWpFdmlX?=
 =?utf-8?B?eWg0L2NGZDJuSDVlQUx2dng2bHgxSmIvUmZ3d2dZMHcxdk5UNGwyY1dQbTdv?=
 =?utf-8?B?VGZiWFd2RXJBbm95NkFPMEFHWnUzWXlnRDd1UEV0QnRucVVaMUt2akxMT3lE?=
 =?utf-8?B?bTZRNUlZZkhQeEVucFYrSEVCc1RrUXNiY3JiTG52cUVEOEp5ck05ZTN0cXZR?=
 =?utf-8?B?OUM4cG4yRndZb2wrcmd1VkhtdE5YMi81c1lITFkyM3FMQTVSZHV2Mm5oZS9Z?=
 =?utf-8?B?NEtrclF4eHV4MXV3emsyRXhubGlPSXpKUzBuUGZTWGZWSWsybk45TWRNOGlh?=
 =?utf-8?B?RC9BQW5Gd3hQVjVWdWtyTVZ5NFVTWTE5M05mQWtBellBQnIxMEZKTGhUYUhG?=
 =?utf-8?B?WFpEaHVId1ZZTkMrdDBSekxQY1FTRVZMRWNCM2RSdTFJQU02Y2lYck50TWxE?=
 =?utf-8?B?VGx2RllYRkhQTFJSV1dHZkFLWGxJL2hNaDV5VGRJVC9PQkRHNnM5UEE3SE16?=
 =?utf-8?B?OFo4cEdHMG5nUzFhQ1VUdkw5UnVaRGYvbGJoSWF1aSt2bGYrWnpYR0FVREFr?=
 =?utf-8?B?NWJZL0Q0ejhVTFFmVlUxRXFJZlkyUVZvMDRRZGYrZ0U5VGUxTVdReXU2RFo3?=
 =?utf-8?B?T1JRd1BDdjZnaFJnTncyRFBNNnhkQmZPNENqaCt5U3Nqc3htTlZiUCszMTdZ?=
 =?utf-8?B?UWJSZzlWQTRBUXVsRHRJOEE2T3ZNVkU0bUcrWFpiOFhZdlFGa2MxODA4VnJp?=
 =?utf-8?B?dGVlaUxUWmlRTlJLeDk5a3dSWXpySzNYdmRnQVRSK3lLL2NsSWVhd3FwQkow?=
 =?utf-8?B?QWlDN1ByMjJYTmt3Q2Q1OFc4R0VJQW9zTjF5ZTFyOFpuUlpZRDBlVWhVNmdv?=
 =?utf-8?B?Rnd4ZkEvcDZRME9wSzUvSUtQdk5GNFRmZlVMNzhQKzBGV1Vqb1k4MFdYUVJw?=
 =?utf-8?B?WEhaNjZHdjhXSG9SdW1EWEhiYTNIRXFYRWNlREdPd0VVTHZIU1QyOXd3Q3J6?=
 =?utf-8?B?aHdGUTFQbmlBZWd5cEZLV2pValpodThDRExMT3hRQXFvYWFvbmExVG5nd1lP?=
 =?utf-8?B?S0NyQ04yWWgzdXRadE1PSGhLa0wvME1ObFBFOFBnajVLZ3RYaThVNnNNL01Z?=
 =?utf-8?B?Y1I2NnZweDgxMXFJbDlianliUXowQTRsMWJjOGdGbEo1MEtxb3laM3g3dzhm?=
 =?utf-8?B?ekN6VmttckN3S0szSU5hdWp5Ti93V1NxYnI3S2xuRU9pNzNwUDN0SlFWbVpT?=
 =?utf-8?B?QlNEM0FnL3hub2l5d0ZQTytScmJYdTdld2JIMUxMYkt4QXJrK2NRS1dRUGpU?=
 =?utf-8?B?UUdURE5iNDZhNTJzTWtPMEtQNGpGdmJyRSsrbXhBbzRFN0I1R2pVbWpDYUdv?=
 =?utf-8?Q?q+IHdjvkHLe90Skg+MIu+zkPA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1b9949-ffbf-4369-d91c-08dcc9163b99
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 17:07:31.0257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfT6rS7MRekGUSeIvz/BHW4TZs1Oc+ywHlkBXhK5rpWFCMKAS1ZA4iye4qO6yhIX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076

On 29/08/2024 23:44, Niklas Söderlund wrote:
> Hi Gal,
> 
> Thanks for your work.
> 
> On 2024-08-29 17:42:53 +0300, Gal Pressman wrote:
> 
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c 
>> b/drivers/net/ethernet/renesas/ravb_main.c
>> index c02fb296bf7d..c7ec23688d56 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -1744,8 +1744,6 @@ static int ravb_get_ts_info(struct net_device *ndev,
>>  
>>  	info->so_timestamping =
>>  		SOF_TIMESTAMPING_TX_SOFTWARE |
>> -		SOF_TIMESTAMPING_RX_SOFTWARE |
>> -		SOF_TIMESTAMPING_SOFTWARE |
>>  		SOF_TIMESTAMPING_TX_HARDWARE |
>>  		SOF_TIMESTAMPING_RX_HARDWARE |
>>  		SOF_TIMESTAMPING_RAW_HARDWARE;
>> @@ -1756,6 +1754,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
>>  		(1 << HWTSTAMP_FILTER_ALL);
>>  	if (hw_info->gptp || hw_info->ccc_gac)
>>  		info->phc_index = ptp_clock_index(priv->ptp.clock);
>> +	else
>> +		info->phc_index = 0;
> 
> I understand this work keeps things the same as they where before and 
> that this change do not alter the existing behavior. But should not 
> phc_index be left untouched here (kept at -1) as there are no ptp clock?

Yes, setting the phc_index to zero felt bad and is likely a bug, but
this patch is probably not the place to fix it.

> 
> I think this might have been introduced in commit 7e09a052dc4e ("ravb: 
> Exclude gPTP feature support for RZ/G2L") when the driver excluded ptp 
> support for some devices. I suspect the so_timestamping mask should also 
> depend on this check and only advertise hardware clocks if it indeed 
> exists?
> 
> If my assumption is correct I can fix this on top. For this change the 
> existing behavior is kept, so for drivers/net/ethernet/renesas,

Sounds good to me.

> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Thank you Niklas!

