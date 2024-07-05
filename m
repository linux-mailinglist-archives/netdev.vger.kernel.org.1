Return-Path: <netdev+bounces-109509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC708928A33
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC70B20BF1
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8899A14D6E0;
	Fri,  5 Jul 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiZaD8mY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A861465BE
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187712; cv=fail; b=RLjgHSlcrXhKWyip4lyC8Z+RJyHghsDOqye+o9E84afrpZvgSZwfKnIc9un8c3NYIWA+WJd52wJ6IyE9RuAgwvD8ysH+0Cb5yD64Wkvjf3YLIqDXZvWwYXPTZABoTP9CO4Lx36qf1N8+saaAh3F9PLf5Bbq/QRx3fohMlrKvl+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187712; c=relaxed/simple;
	bh=g5mraexq9H6s3eF80XjN3XXPJwrIQUkPJYliUDVH/VU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BE22/zGiGLS0ZpHzS+ucahjN9q8PtgEdTrvPr8AkdSrZcz9D2fqroVZTFRfUHr9zrJdi3AiOq4Qc8MYlZwgbjHmJDaUlEJpqkcU17gqge2RkUFZRls1OqbPcjELAFTVd+p6Hk7oQN/MAioWwESKVEm1wZ91WcrKkVBBnMgK1RG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiZaD8mY; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720187711; x=1751723711;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g5mraexq9H6s3eF80XjN3XXPJwrIQUkPJYliUDVH/VU=;
  b=LiZaD8mYvE6rZe81G0DAlrwzuOXxP2uy91/Z3VjUuAsrqDe67XiDd4+k
   GoLwoAqFCq6z6yN00pW0+WCpaGkh/w8+iLOfV70IJsrg4InB+MZznRBEC
   8jMB5cYYDq37n3wmPcYPGWXCQnjxGrzrxJIkfefI2aN6UjWofijwhogNb
   Br9nN1yx+M5oXAebCmTTCS7VitQggLMsqakZEC60+skHK2221Nqd6qr3q
   LawQAZyD1diH3XSoRinYpMPeQuhnMPvywxiR5+v7PpotaKqzMoPT5y2rv
   jUyFbvff9Rj9XP1wba+dd/r//sUiOk/QYMrg8C4kPHtgzJhIZryRpWby2
   Q==;
X-CSE-ConnectionGUID: gsqMVZNaSPibofLbeuXugw==
X-CSE-MsgGUID: ukg9dUxBSp2914bNPgyZ/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17588532"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17588532"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 06:55:09 -0700
X-CSE-ConnectionGUID: dZ88czEPTQiFA9c1+pb6Cw==
X-CSE-MsgGUID: kFX31NIARBW44qTGmTTnrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="47631516"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 06:55:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 06:55:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 06:55:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 06:55:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRdtdJV0i7Prbs57g52PpQCwhxoVGFUvTRHy5EdeKxqyVEtuVEetmnlhq77mgeNx5D3WofdJd4FBjWJK7KDqz1pH8i9wFEtYfWGwU3HmneXP1QwgM+/NgyJSrG3ROm2FRMBxeAgQSHyZHxkA70fFHcNAdEdrLkb/MYUHW+V5eHHrGhk5QvL32KR8kjVBTYYCEYLlRLFXJ7wDSNKl3NN2dsxB6ycjRH6SNAgAcMTe5sdhGl1DR32QZrXouw0sqjj8324kAJD1HFEw6FyzQgv5znNU+xlJ4UMmspKQcfPVXriJ4NVaewhaOzKrCtDtQGSCAoHDQ8t/gRLy6i3vpoo0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG4reNt+us2FAsiHCdVcmVWHIImIl4KAXM63M4K+ghU=;
 b=Z9ai1xnrQvRUB3qqdZ7J846JkcbIRpuNxVzRKh5RTy4DKvvhqBFU99q5cD5d4ur3TxSGmocyuddzUgJju5WiuqeTKlfXq2k/q+br1EoVCTxPbx2ozgIyfxq4K7ffBp50kjFxm+Dv2adq7RXfmr35TH1zcnChYh77nLVBRE+KlfKJLHOK19bYhwsnSXPqpmHyHEkqa7VjqerAzqJTGW/ebNJiV/8R2hfcAUDdFoxDH/Pd0Aa//P81taJsf29+aP6jdw7KbzAiCgSrXdHYkZuQkXDhvh6E+94v3cdUpGbhsTH+HMzYOPsxU/nxW9HR5mlOvJ2GSk2OCfz6nwELhJ40Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 13:55:06 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 13:55:06 +0000
Message-ID: <bb960821-a67b-4d61-afeb-ead10ea2a4dc@intel.com>
Date: Fri, 5 Jul 2024 15:54:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: tls: Pass union tls_crypto_context pointer
 to memzero_explicit
To: Simon Horman <horms@kernel.org>
CC: Boris Pismenny <borisp@nvidia.com>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
References: <20240705-tls-memzero-v1-1-0496871cfe9b@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240705-tls-memzero-v1-1-0496871cfe9b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0220.eurprd08.prod.outlook.com
 (2603:10a6:802:15::29) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: b067a6db-6128-4255-e541-08dc9cfa1378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0tTeUNuSENLY0UyOHNXVUdFb25Qb2VORnh1a1BwVitTWjdRcjRGZE80VTZv?=
 =?utf-8?B?Z0M2dVMvTllQdCt0MElGNEtyY2EvS2MyMjVmSlZNYlNKU0p1WVo0RDc5MTJZ?=
 =?utf-8?B?ZldaTUZsUERNWGZFZURXeWVjVEJRR3BzKzd3bjRqN2xVWlJXUGZMSjN2c3JV?=
 =?utf-8?B?S1hiYWJGNzB5OFB4YkMzV0Y0MXNTMldhdGdTODh1dTJDUjRuRFBRM1EvdWtl?=
 =?utf-8?B?eFZ1bHZBTXhuQVpzTjFoS3VkMzZRYXJHVC80d0JNNk5KMzZxT29JQ1M4U2No?=
 =?utf-8?B?UGNReWtXRkhhMUxtWlJ6V1BmbFF3dG5kRUJoZDRJSjJnT2VpVGQ4alB2ZzVa?=
 =?utf-8?B?U3FKVnhPcFNtWFZjS2NQN3dVazYwdVhXQ2xuSlo5MExNRDNDa3NKQ3R5TE5P?=
 =?utf-8?B?NW84VFVuVU0vblNFcmVlVEUzZCs1enBjLzQyNHB4ZGtYZm5HTXc1aFBKN3F0?=
 =?utf-8?B?NTcwNkZmWFgvUGlRL0NMZmxrV05HYWFrL1J3dXVxbUh2UE43SFZLMUdOa21O?=
 =?utf-8?B?WE5wUlVsbGQ0VC9EeDF2bmdOb0ZWQlhhbjlxNjA0M1AzZWRMeHkvS1FLK0Y1?=
 =?utf-8?B?eWlHWitZUWNWbmZCMUpkU3graW00MXB0RGl5cGlRVXR2b2lYT1QrNDZZbFJZ?=
 =?utf-8?B?UWdSRDdTd1ZnTGlOWktiTExXL2NXRGtqMll5Z2hTOFdydG84dE9tVjlEeEtu?=
 =?utf-8?B?KzcyVXZsU2UwSlpuQVQ3RzE1UHBXV2MrM1c5UVZSTEx2ak52d0ZQSStHNGJ1?=
 =?utf-8?B?eHVwS1Z3dlhmS2hyNXZERWQyeTl2N092ZG14U3RtQUcyRWRrOWNJTHowSlhQ?=
 =?utf-8?B?L0d6L1p4R2x3SEZmQk9wcjkrWUJBVm5rVWxvT2hJTmRQRFlrQVAwSXNuM1I0?=
 =?utf-8?B?anpJZGhWV2U3TTB6NGZuYVpWdG5Qd2ZGd1BHNFJtN2p0aVhqaVVKL0dBNmlY?=
 =?utf-8?B?VXROYmRobzZtUHpFZ1BsZXNXMFg1NjRQc3NFMENvY0RZMXZJTzBNY3NYb2w5?=
 =?utf-8?B?VEpFanpPNDBTZmN2c1RuN20wUndnWnQvRVZjOW5WekY0MTVScmNsVXRoZFhG?=
 =?utf-8?B?eTJFN2VrbHR1Z2x5WWM2L3hURkIwRUl6Q2hYSGdYSURGTEpibnNiWmdvZk1K?=
 =?utf-8?B?Q09RV05NeHByaXpURktzdFY5SWVBYnNVb0oxRytRb3B1Um1yWDZ3SnFLcy9p?=
 =?utf-8?B?b0RRdnZZelo4YUlGUWxjeTB1Yk9sWW1sSWl0RjNwb01DS25USnZobm9ieHRp?=
 =?utf-8?B?dG1XTE5NRmlpNlF3RnNaMXdCOGhmNjFPUmFWQlpZdGxHeVFxTG96NWtOcVgz?=
 =?utf-8?B?VFM0UlQxRkUrcXZRT3Z1ZmNlRE1rOTVRWTROQW41ckNwbmJhejROOWs0QTNV?=
 =?utf-8?B?Yy9FZjJJMUJPTjk3UG5ZQU13Q093dW1YMjIyRk9QUjUveHNva0RjQkZUMG1Y?=
 =?utf-8?B?Vnd3RnZwdlp5RnA0NUhDaUpXa001YTB6c29Bckg3eEgvUmJoTmZublY2UCtK?=
 =?utf-8?B?UTUvN3UxYnFMNDVLRUl4LzNZbEIyM2dEbFlRWEFIK1kvaFdZcFlmcEdnQTVH?=
 =?utf-8?B?UHF6OWFpeGoxVVgwOUN2V3lsRGplcEdNdVhHMnpqeUVyUlJTK1Y1QnA0aEt0?=
 =?utf-8?B?bFo3eERxcjRBZWtEdUluQnRSajJVWkNobEMvcGs3R0hNVEprQlZoWFI0cDBp?=
 =?utf-8?B?c0NzViszeVJlV1FKNWxMYW01WDkxbnJ6MW1zVXVZRGtBSzhnSkJocHhJV2t6?=
 =?utf-8?B?UzJ6eDNVdFEyL3dZQ0sxQUtNcXo5WHdYVEhycDJ3eUdmejBraVpnekMrSXVo?=
 =?utf-8?B?UC9XUnFLbjhnbTNwVFVwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCtHRU9XUEdUSElneXJvRk5DTWs5dENRcFk4WmFXWnROSjBhYlljTzFBR3pK?=
 =?utf-8?B?UDJaWkhCTmhiTitRMDFxdFc0UEc5TmpuQlIwVFVmTm9Ud3NqQXNIeUIybDlI?=
 =?utf-8?B?MHkzZVdsQnZZM0ZrMys2TjlZU3ovVGV2aEx5MzBHOWhWWVFTSTc0c2M0TFE0?=
 =?utf-8?B?Qm9wRlFQSk1PZGNPTVFybmdKTUVNaFZNeUh3RjFTcklXV2RrMUlnRTdmeWJ5?=
 =?utf-8?B?Vm9wekhpc3U2M3JRTUx3ak54cTNTaklpbkdHRkdYNjhjVjB6UjhJSnd5YU5i?=
 =?utf-8?B?WW5DVVE2RFVYZjF0Z01BN3NEejF0UnlZd1M0YVkvd1N2OURqZlJFMVNyWXo4?=
 =?utf-8?B?bjQyWDVGQ1Q4S2xDTUttWDNUcVdIam1VMlNQU3R5bU1VUVExNzRpRVlGdUNt?=
 =?utf-8?B?ZmllT1lYK051RFNPS3VaZ1NyUU9JcjQySzZ3ZlVQMmhCWHVRZW9JRGgxS0Vq?=
 =?utf-8?B?cHNNS3JRUVNGUWxMSkZHY1NBaTBWVmsvVWNFVU9MZjNNdTdpSVI5TlUrTDh5?=
 =?utf-8?B?Si9kZWMxcW1wTEV6TUJyVzJPYzhkQ21MZ3FDUGxRSURvZGhLazZwMzN2TVh6?=
 =?utf-8?B?MjdMYWQxMnpuL1JPSktwaUdJSncybTl2RGVHTndIbDNDY3ZCRDZJdlUyVW9N?=
 =?utf-8?B?MVQ2di9nZmk4U0g0S3g3dEFid2tjYVhyb1NGL0cvQU12eXpIeDRacVpDK29J?=
 =?utf-8?B?ekdTaVl1MFFiblVXamJpaFEvNC9MUFM4S3NrZDhhc0k5UEVrSFF4cjFxNVBY?=
 =?utf-8?B?TC93dmV6MUYyOE8yOFd4SEJGM01hZDJ1cEJXV0NuVldwU2RWQm5JakF4S25y?=
 =?utf-8?B?OUFXM2hXNzMwY2hVa1BQK000cUhFVUtTYURkNWU1MFdMVFNKbkFXeDRhRGNU?=
 =?utf-8?B?STRTOEE4N2NMblpDbnFsUjkveW5YR1R6dk1kRWxST2d2R3RSQTNRWTVJbFpJ?=
 =?utf-8?B?ZXFNWDlyUGpVUXB1TnNSU01Mb1pTZGRFRGRNYzRFSHBoamZOeG5sZ2pHa1JT?=
 =?utf-8?B?YzE1dEhQQkR6eUUvTERyZVBRRzlReXh5OWdVMGdVVmNGc09QQnJ6UTZLUkx0?=
 =?utf-8?B?NlVKemtjc2N1Qm01enlaTmU0RW16dTlnbkJwMkJBRzhRWnI5dS84aGNIYjV0?=
 =?utf-8?B?YUxJTis4NXBtZHdLdVRscnZIV2pSOHlPOGVPQ0FyTGtrZkdrb0FueHdQN0xN?=
 =?utf-8?B?dTFuZktIdkVzZEtQOWtEc2JjNjRIWUZsZ08xeVBORFZpVUZTcXpCaEU2cGVz?=
 =?utf-8?B?WGdnK3kvZ1hoUytSZk9MTHJ0R2Z3WEROSklxZytiMnc0blFjQjVWVW5MdXVu?=
 =?utf-8?B?SFcwT1A1bFNpYWJER1MzMlROOGo2MDJBZmdaTVJ2VzE0ODdmSnBKdmZxdTFp?=
 =?utf-8?B?Q0dJUTRxLzhybHg4M1hKUnRtYVBhYW1Ib3hSQTAxbVhJYUFrc0lCRmlIZWZm?=
 =?utf-8?B?aXVzdGRaSE5xdTNiMFVxNjlxWGs5cmF4VS94blg2RzdsNUV6K2haQlpoR20v?=
 =?utf-8?B?Vm9NQmNmaXgwTTF6K1pVaXFIblcvQ0laeU81T2RNUTRsenc3UGs5MlFxRmRk?=
 =?utf-8?B?T2VOVFdtUjVsWDlMM3NqeXFDZzQ3RnBHLzJ2aHJBSkpBK0tTZUNtSVpoS2lD?=
 =?utf-8?B?Q0NNcCtTL1lmZXVuTTVtdm1vVERZOVh6WWlySFpncXB4WGVVMGcwclVkMmEz?=
 =?utf-8?B?WmQyODFFVjllM2tVN1ZwUzdBTVB4ZklLM0dvK2JZTWhTaWo2NTVGVURZM1Zx?=
 =?utf-8?B?UWJFMG9COVBxZ3ZOdFN1ZjU3eHQrc1VxNCtpQjlnNC9ucVRMTzVZc2JPWCtJ?=
 =?utf-8?B?d0x3dll1MTZkb0RaaDEyc2Y2K01ZaUsrNGpFd2J6WTh6SUFvTjN3dGRQU3dw?=
 =?utf-8?B?V3FVNmZXVnJ0enhxMDAzTVpwSG5yNGg2akJZUTN2QmtWenpUMk9JZmJTSHpQ?=
 =?utf-8?B?UjNRZTlSOXhISXMwZkZUOXVCZVdmek1uNDZZaHRjd2ZiQzFXK1owT2xHS2ZD?=
 =?utf-8?B?c3MrZm1ONUNoUkFDRExUb0RMbHJnaWdDdHpNTzFEUEg3MzA4NGFrRVFBTjda?=
 =?utf-8?B?ZEkzeU42R2JYQ1NGV3VVOHZZeWpSdkRCRjlnQ09WeTJIaS9KbGxjNDJTSEJz?=
 =?utf-8?B?R2taam5XM0R0Unk5MjQrYnRSZDBRS0JoUFU2ZjNoNGRxSUNnUnNDeE5nak9O?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b067a6db-6128-4255-e541-08dc9cfa1378
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:55:06.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LESefH85eSijGBcB4ZxbUGeupnB7cIVb1vyxrMoItd2wb7kxWAlN1LjjXv3ynL9XEj2Izzyy7i1n1SSpm4Bqa3zy1IsMel7fOhHvkbaDOVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
X-OriginatorOrg: intel.com

On 7/5/24 15:41, Simon Horman wrote:
> Pass union tls_crypto_context pointer, rather than struct
> tls_crypto_info pointer, to memzero_explicit().
> 
> The address of the pointer is the same before and after.
> But the new construct means that the size of the dereferenced pointer type
> matches the size being zeroed. Which aids static analysis.
> 
> As reported by Smatch:
> 
>    .../tls_main.c:842 do_tls_setsockopt_conf() error: memzero_explicit() 'crypto_info' too small (4 vs 56)
> 
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
one small nitpick only

> ---
>   net/tls/tls_main.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 90b7f253d363..e712b2faeb81 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -616,6 +616,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
>   	struct tls_crypto_info *alt_crypto_info;
>   	struct tls_context *ctx = tls_get_ctx(sk);
>   	const struct tls_cipher_desc *cipher_desc;
> +	union tls_crypto_context *crypto_ctx;
>   	int rc = 0;
>   	int conf;
>   
> @@ -623,13 +624,15 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
>   		return -EINVAL;
>   
>   	if (tx) {
> -		crypto_info = &ctx->crypto_send.info;
> +		crypto_ctx = &ctx->crypto_send;
>   		alt_crypto_info = &ctx->crypto_recv.info;
>   	} else {
> -		crypto_info = &ctx->crypto_recv.info;
> +		crypto_ctx = &ctx->crypto_recv;
>   		alt_crypto_info = &ctx->crypto_send.info;
>   	}
>   
> +	crypto_info = &crypto_ctx->info;
> +
>   	/* Currently we don't support set crypto info more than one time */
>   	if (TLS_CRYPTO_INFO_READY(crypto_info))
>   		return -EBUSY;
> @@ -710,7 +713,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
>   	return 0;
>   
>   err_crypto_info:
> -	memzero_explicit(crypto_info, sizeof(union tls_crypto_context));
> +	memzero_explicit(crypto_ctx, sizeof(union tls_crypto_context));

nit: That's a good fix to aid static analyzers, and reviewers.
Now it's also easy to follow the standard style and pass
sizeof(*crypto_ctx) instead of the type.

>   	return rc;
>   }


