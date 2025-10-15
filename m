Return-Path: <netdev+bounces-229572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29950BDE62E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A633BBD3F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3261F2D7810;
	Wed, 15 Oct 2025 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUSfoMDU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00B17A2EA
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529868; cv=fail; b=A7jLsYIhq7+eT8xJBbYd7Wy2QTsajP6Qw9beUpFhU5VjGMTkROsUlbfNILZOOYBQNDWCY/p7lWkXnQuIDov9lObHwR1J+lznsi5bXbjnuLBhO6EqM4SoUyVdTm88UG0HrB6arKXfUwkpZJjA5rAsjZ11nq+jQ5k6xjeaZ6ao/Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529868; c=relaxed/simple;
	bh=shHMiqm6G42MrwMCyDofa2+50SV0gRBED+FyxnNV7Jc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=se62qU+VSifFINMCp+3ZqlxUifH8piqU8CTtTgKE1w700JOVd22HIyuXxpCMoNwLtk6h1/pRoMiagUuTtZsZEsa0rwBejdPw4GwGibjALbKrM7+JNcHjK9iJiqi6eFoKooPCXqZxPIrTtzOxtcmkWaAkWsd2C2hQGS2ZMVB/fck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUSfoMDU; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760529866; x=1792065866;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=shHMiqm6G42MrwMCyDofa2+50SV0gRBED+FyxnNV7Jc=;
  b=AUSfoMDUbrlVZfOxbT0BdkbIS7g0Vr51PPoq5x3Vm9idxBUPi/T6ZFnl
   7U96tcZ8Npmclhvvg+B1Pgvdttgyl3+ckCibqu7Ng9PfLEb+s4QiIUCZ0
   mPIP9wTzSaD3GzcPH2wU35gVbUjrhWWhCgII5C9TLo/JWpUZp978UDyN5
   lSJ3VEZH/knG2e6M5HdTkJdUtp9s4m+nTUADPfd8zgoBMMjG3g8dFVTuh
   P1OeCWHlN2PrVAKi8XljfjNs0DnWn/4V2y4/YPTLZ8PVaviaKa+BwfjCN
   KiKYhAupo9X25qKFLhd+My2cJW+nTmsq6Wq9vHh11+vuI1vgxVhcEDWVT
   w==;
X-CSE-ConnectionGUID: x2s5sgE5QoWADkgZymdSgQ==
X-CSE-MsgGUID: Kg+Pc/LNQOWHq4YHZin8JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62853948"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="62853948"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 05:04:24 -0700
X-CSE-ConnectionGUID: EmSnG/8hRL+cwk27APPGYQ==
X-CSE-MsgGUID: bNwH2vrTT/ST2ST/AyWFTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="186571864"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 05:04:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:04:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 05:04:23 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdrsY02dXRS1RH4Y201V/tWQehcnB8ftsRz83DnSuty0d+3HKB9YctGfGYaPdzUy1xN+eoGPfssKuie10eYgf9qOiefANH292Sf9+THSUneMHur/y9HZB7G3zHie74QGnPlVVbwoQgd62VR/BB0MMgFzWKlAEjdyFYocCrB0oqJcrdcGTlolmCoOTgUoyAIyo5zU4PzCiR6+BRNFc24cqacALHCz0YNMKAoDDLrCeWex69NvLH2QId4ysAf/lMrg2Hxd9/yMcg5wOLGOeCWFuyZYnngf3CYhg634QE87smtu5DAsHBuJ4O8SRi52f5clnf4sFDFNfnbvdq02U1C2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjDURrtCaM0hABk0XfN1xkYKU9M9vJ3JiszcmJLbmzs=;
 b=Hlac+IuWo6bedz4x2VxnL3Y0xTgJAWcLWFg3wKTf1sKhzXvqS0cu55WVRGQbqoueVFDSGwQMmY7eKa8Xr7hsEj53ztI2u3l9H/ui1t6E2N6lJe9kqalLzYSSUe9LL5Wm+AuHdvvH1E+i8qq65hk13SjNrNjTmtbXt1hoRvsnAReCdFwL0O8wSXjnUEM5NNP1nh0++SKJh9z4itKK+vR7EHPs8t10c1HsPAO2ms9PoV1X6cfhkdwftlWs7zMZVtlabEBPt7R9JbumVECHKrvfRB/EoPDCT26b6emgd/OwXFyBF4fPMfa/+mnWKzwUF9y2AFr7nJ1Ap/IoNl8sqLvfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ5PPF8225D2149.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 15 Oct
 2025 12:04:19 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 12:04:19 +0000
Message-ID: <e24f9c99-f800-44ed-86a9-8a48739586ab@intel.com>
Date: Wed, 15 Oct 2025 14:04:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: gro: clear skb_shinfo(skb)->hwtstamps in
 napi_reuse_skb()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251015063221.4171986-1-edumazet@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251015063221.4171986-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0337.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ5PPF8225D2149:EE_
X-MS-Office365-Filtering-Correlation-Id: f8039a6a-a2b0-4d94-b15b-08de0be2f826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVU5WDJGK09jakZNKys5dkpCVHB5bXZVcTl3UnBXQ0dlNXVReVZYeWFmWEoz?=
 =?utf-8?B?cWZhYnJob2J1R2tKMkZCWE0ySmVwM29EY1hUNSs1bXhrUUJ2WUJJZGZNOE9w?=
 =?utf-8?B?NGRvQThDbWxqcGpWTjR1Tk5MMWFJWmluaEdoZi9Bbk0wNGk3bUZUZmwwa1lK?=
 =?utf-8?B?UFN2M0d4bVdwZHQ4NnM4VmV3WWxKMVRDeUFncTZXc2tGaU43REs5VHhHbnNE?=
 =?utf-8?B?REtqMzZKb3M4SEF6SHhodzZ5b0p5QlFrU3NONENWOWZhQ3hwOEpPLzN6dG5x?=
 =?utf-8?B?OVluUjlEeURwNVF3YS9UY29IYTR4eU9jZ3djZGpzdDFxd3NabG8zejVEMzVx?=
 =?utf-8?B?UWdBWU5XaGhpQTBYUXhubWZqVjdIZjk1RGw1R0Nwd2JuRjZGRzlXN0VMN0J6?=
 =?utf-8?B?eU04VnNBcG8rQ2hFSStqaHlXYkR6UFBEa0xJb3p4Zkg1TjkxT1oydCtaUXVX?=
 =?utf-8?B?bGZRWHJmTldHWGxPcUhUZmJRczRGV21kY2gvaXQ0REdoOGRzQ2dEekFNNE5J?=
 =?utf-8?B?VGxrZzR1bW9GS0VobVFNdTB2Vk1xRHFvL3RCQ0N3bHRnVXRKVWIrdVRhV3c4?=
 =?utf-8?B?OXY2UGlJWjJHR1p2Z0FGZlZRT1RTb0xJM2d2b3JveGlnVXdyc3JvMnl4REtr?=
 =?utf-8?B?MFg2UVNnbTZGOFM3SkJQeEozWURsdjVubE0ySjM1NklMczRoRDdhWFlhNlZs?=
 =?utf-8?B?OEpFOWhoZHV5dVA0bXJZRklHcGlvaC8rQzQ2U1o1VzRQSEZCRllRL1NoeUQy?=
 =?utf-8?B?N0l3b0x2QTNBbmYzQ2lGemtldmFYTTdheHVibzVCa2czNXQzWm05YWM2RHhl?=
 =?utf-8?B?ZzBBK2tnbFFVTk1oVUdQY1FjL2hBbXVWdnkvS0o2TFdnN3R4ZmRDRGNFU2Ez?=
 =?utf-8?B?U0UxZnNySjIwdldiMDBCSUJMc1BuSTRjelhkc3ZHUSt5dXU1UmZTamVtbThM?=
 =?utf-8?B?QnQ2bURuZ2Z2TnNTdE01TDdwNGpWTnA2Zkp0QVJXdWp2dW5Ja1JiZ3gwZEpq?=
 =?utf-8?B?VmFrSGxsRDNiQmVDbFlEQVNlNmptTUI1SXNOc2NoRGJPL2R3S0ZxSjFaS2JJ?=
 =?utf-8?B?T1dLRXpSczBDYy82NWxmNTRvZDNMbTZxR09qdlBBNkkvKy9kSHFGMGQvR1kv?=
 =?utf-8?B?ZTI4WU51MC9vMm9aQWFqaytZbE1DeVg3QitzN0lmTGJYQkVKaHVwSmlRbTV5?=
 =?utf-8?B?S3cydElpOHBTMHBXRkRyYVcxVlM3Rmh1NndrK012aHlYa2p0cXJlNTFYMy80?=
 =?utf-8?B?STlNdWhKNk1WOTZ3SFJIUEhqZWhmWWxVTFpVNDl4QWpidi90eExySFY2RlZI?=
 =?utf-8?B?Zk9palBHVnZhdFZRdmJVY1ZtZ1BjaUdHZmlCUDJTMGlFek1MSlJ2WUpQVmZL?=
 =?utf-8?B?UjEyL0RjZi85cFVzZFlUZDlmUEhWUDd0MlFyemhtRHNQQkYvQ0pWM0VwS0ox?=
 =?utf-8?B?NHE4L2FBZlN4YWVURGIrZ3haWDJDTmJiREY2TWtqREJEaXFoU0VPUDNDVjdR?=
 =?utf-8?B?b2lIMlNHNWxhT2F0Y1BtODRYcyt5QmQ3cEpsUFY5bi9jWDZVV09KVFEzMmxx?=
 =?utf-8?B?MVhoU1hDZ0luNk8wR0txWHg1OGlYcGZDS3hHU2RXN1d0SmxnQ0lyeXg0elV4?=
 =?utf-8?B?L1FEeEZadkljZXFGZDZua0V3WGlCZWQ2OGJIeEo3K0ZURlFjTFY5dUE1dG8w?=
 =?utf-8?B?WmRVcjJiSnh2K0xDeW9pZjNnVEZVa3ZlaE1xakxRdWNSSzUyU283NlNNMUlu?=
 =?utf-8?B?TFZrU3Q0TDhmRW0zYmczNmVtWUE4ay9BUFcyaTN4V2l1STBEWURsdmo2VXk4?=
 =?utf-8?B?VTZQUWJ3ejZyU0E2M0VHVEVhZFpkT1dKU3A2bFY2eHpNNDlHSzJVR1V4WEMy?=
 =?utf-8?B?dE0rS0doNDZRMldBcVpqb3ZuTlovOC9LVmJNc3FIVlhQUW8yYVZ5WjdCcm1V?=
 =?utf-8?Q?YlvJbViKGtisCpVVITUXBrdUJAxXSPav?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVMxMGhSa1ppbUlwRGw2RGw0Sm5jTlZweTBiNVVwaS9sd0RZOTM3WjhzUHNL?=
 =?utf-8?B?ODFDREhQK3diQ01DUTh4dUNMYm1xUTZiamk3RVJGMmFZcEJUQ0R4M2xINk9a?=
 =?utf-8?B?OVFubmg4MFdHbUFwWlloOEVmTjdwY0dYYXp3emVTdE9QME9HSlE0dCt1cEhW?=
 =?utf-8?B?K2pJWlBTY2hBRklZRXdsN0dyRS9ZSk41Z3VIUnZ1TStVWGpFWFE2bDRKN0g5?=
 =?utf-8?B?aHdzaWQzNmw1Mm95djJQa1I1WXRDOXVFbkxvbHYwRzBiZ0Flc1NwQTBSSlcw?=
 =?utf-8?B?dUlqOHdqZjkrUjYyUjdibVBaVkJ3bWhtdTR1MHhmZGs2bEh2dGY2bWg2djhY?=
 =?utf-8?B?U0phUlZ5UDFPaENUV2JDeWk1bTUzbUJUazB5cTd6UjhnVTd1UUM1NXhGVHZz?=
 =?utf-8?B?NnUvS3lGUVhQTWhTWmp0Y2pOUXc3RUJscTQ5RDZBMkpjdjhBVnlyTkREYWZq?=
 =?utf-8?B?MklmeENTN0NWaG5EaWhhSUVoY0JGcHJSM3NOWVpHMlRZbnlaM3Nmb0VtVXlF?=
 =?utf-8?B?blZTRldyVEE4endxdHlCdjUrZjRaWGFIRmZlaXpGNWF3dkgrTllUejdUZDVI?=
 =?utf-8?B?Uk9RdWxuQmRQbnVpcDVTaEtGamZyNjk5b2p3QTdpb2k5VmFscStqcjdoY0dZ?=
 =?utf-8?B?TXdRRDFCekFyTlFNcmtxdjNvM3E2WmlvTDVmaDgvUExBNFJiYldGYm5qVktm?=
 =?utf-8?B?aHZOK3J2K2RTVzRJeVAwNVg0Y0hudmN4WTFXRUcvTnNKNU1Odkl3V0hjRU9a?=
 =?utf-8?B?c1pwRllLUU01NDZlcVlUa3pjQ2RZcnFLZkt2aFZpeHpvaHpDRVJuZnVkbXYz?=
 =?utf-8?B?RjJvVUtONnNnUnNlQWhMb0p5OEUzVGZ0azk4Y2M0WnJ3T3dnNTNOZ1dLaEpL?=
 =?utf-8?B?LzZPRWNvSWdteDJkWnFRd2ZRb1hBVjgrOHlsUEtaVlhHcUQ2VDdFck96aDFB?=
 =?utf-8?B?aTdlSEFlQTdXOUwyWk11WG5mY1VORllXQjhEVG0ycHdHSTJFNmZRTytueER6?=
 =?utf-8?B?MDhGeDBtZWE3RjJ4aHl4aDlScldGRjEraUU5Zmd2MVVVaUt0ZHVZMndjUUIr?=
 =?utf-8?B?RnFYQm1zbmwvMS9CMkVOMjRzdTQwbUw1ajcvZkNpdEFnM3N1a0Q1c3pxbkla?=
 =?utf-8?B?WVhaeFJ0TUNBV2xkVU4wT2p6akNFRS9YVlgyTjYyejdvU3E5NUpta1FKOVJR?=
 =?utf-8?B?MG01Vm5hQzVqMFprRjZmc09JVGZ0UHArYUVUWlZ5dnNmRlJHNUhTdUFXSVN5?=
 =?utf-8?B?bm0xSWJhQXh2R3BUZDU5QUhwY3M2R0gvckFIL3RTeWRNOGh1b01OQjR4VjZX?=
 =?utf-8?B?Mi9YckVQUDBRUlRUVVpsbDRkQnQ5cUhoTHJ3VlNYcWdTMEF0TlZ6SmdEeUJE?=
 =?utf-8?B?Nks3dWplMDBUK0dBdE1kOFhPczVIenA1VExxSzRJMzlhMTIwSmJ6YTg2VFkr?=
 =?utf-8?B?QW5NOG9pNzJKbU5pZ3g3bmpUK2J0bWdyOFBxM2E2RUF0bnJWVEkyb2doc3Zr?=
 =?utf-8?B?Vk1yOE91TFdCR3pTMm05WUdEbDQxRGVPYXZueFlIbzVWTTRHdExUTFA4RXJl?=
 =?utf-8?B?TVRnNE96TGpSQkhGYmF4V3lJVHNteXJOSXdSTGk4WTZJTzV0Ym5lQktUZi9G?=
 =?utf-8?B?YXlSM1lNeElIbE4wQktnc09qTVVubk15d2d3MFlRL2s1VS9NV1N0VlZwbFFq?=
 =?utf-8?B?SU4xNUxpSnR6bTB2VFpWRXcvVGRqcnp1VDdWYzRKd0xLNDFXRU84bHJIRFN2?=
 =?utf-8?B?eDltTDkyVW1MZ2VDcFpKa1VuMU1YeWdIcDY0bXNXenZYQmV6UC9UcC9RMitW?=
 =?utf-8?B?ZU5RemUzbkJOSlhzTnYzSEdpeUZKSlRhZ1ZrVnZoZXV5eHFWRitjQVZGaVdI?=
 =?utf-8?B?WFpZVCtKd3BIaTJVcEwvMnlWSzVoUW5LT2NuTkMwTFQvN2tmMlBOamxab1lq?=
 =?utf-8?B?QzNEOWlPOVJWT2l2VmsraUpudE5DOENwRWN5THlrRzRBNlkyUWFiODVEQ1ZU?=
 =?utf-8?B?UU5zWm1ydEJqUVlMTFdpQmUyTzhpYXkwUjJTM2VqL01iRmdrR1BkWUtheWxF?=
 =?utf-8?B?aC83aUd0MVpqOVZDNGw5blFha0h3M3dBZUV5OVlLSU5EaUlFYWc1Y2ZkWSth?=
 =?utf-8?B?cjRqN2tiRDBKL0hwNVVRMFhYQjJkd1FPaDlTV1BuUXl2Y0xZRFdaa3JkQW9H?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8039a6a-a2b0-4d94-b15b-08de0be2f826
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 12:04:18.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +km5geckMFdHXtAU1RMuykuc3oN5fS1nYnFiZE/F2X5j/LFmGWIL//0HjygeOe0YxFQzhsEnRrFH3+RjpY+q1meNue1JOGeJXfjKul9p6mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8225D2149
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 06:32:21 +0000

> Some network drivers assume this field is zero after napi_get_frags().
> 
> We must clear it in napi_reuse_skb() otherwise the following can happen:
> 
> 1) A packet is received, and skb_shinfo(skb)->hwtstamps is populated
>    because a bit in the receive descriptor announced hwtstamp
>    availability for this packet.
> 
> 2) Packet is given to gro layer via napi_gro_frags().
> 
> 3) Packet is merged to a prior one held in GRO queues.
> 
> 4) skb is saved after some cleanup in napi->skb via a call
>    to napi_reuse_skb().
> 
> 5) Next packet is received 10 seconds later, gets the recycled skb
>    from napi_get_frags().
> 
> 6) The receive descriptor does not announce hwtstamp availability.
>    Driver does not clear shinfo->hwtstamps.
> 
> 7) We have in shinfo->hwtstamps an old timestamp.
> 
> Fixes: ac45f602ee3d ("net: infrastructure for hardware time stamping")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

