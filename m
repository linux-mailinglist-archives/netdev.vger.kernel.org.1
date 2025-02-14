Return-Path: <netdev+bounces-166405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A01FA35F3D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEC13AAAE4
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317E92641CE;
	Fri, 14 Feb 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbWgqvHF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C2264A9F;
	Fri, 14 Feb 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539650; cv=fail; b=m9M6MFq0sR31nx0R01J9M0j4D04STcuT6io7j9hzHJix6QWa12obruGrk45afAZOiQNpdzfP3Y03O1djqBGILdmrrO5TsaJks7TXPMGTvyEQyWM0W1Sx0Hp0yiZpGRVdxqaTc2j+coRjJDXPzuPELZDEKXvdyrTjBw8a0escmZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539650; c=relaxed/simple;
	bh=VFsTr0IasthV3iycv9SPPlIkZO3q5+c3tSg+hKlxhss=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BLUgfMN1vsUBFTkSI6YvFumBzPXA2gnKEwyO/BFy2svs/nm0oRl0DbGiy1dCQ/0rrdqr8ESfNiODQ8W2I6HCwGMs+KBiLrgbJz/I3cs7tf5pBNNbc1Corfx1HBB9zn4hVNScXZwiTfzWuEtp9vZ7bgBWmMtLOyzGGivInTc4iTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbWgqvHF; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739539648; x=1771075648;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VFsTr0IasthV3iycv9SPPlIkZO3q5+c3tSg+hKlxhss=;
  b=YbWgqvHF/kNE4px3U67J5ENdfWvDpXB9tacGj0HqeRx5wIoj8wICPiHa
   maq8GlcOm60Jb1Me54hkGLnOKixIkoU/ceMwRpK5TROenZsmiVMIIJYMl
   IqXn/CZFf55Tg1iwA6seutRX5GeLq6qRlNR1fSfDk5bpj88TpLnqWFdjk
   V18ukI7g8YvYaAqFn5WjS+44wPJnelz3ZkxoBbqIjiONmg4J5FnCtI19B
   NckJlBIRDEyVNSnZp2kdvoHG/bz2+hrU45xzx08aomJJuKSn5hQtUDEXr
   26JlhBz4lGBosc4J6yfTTsDS7qEK+TImAZd6cRFh7+OxcjZHhKdfn5eNq
   Q==;
X-CSE-ConnectionGUID: IzXmL4sNRIS1uaI2TbuQ7g==
X-CSE-MsgGUID: mJYOIkInS0WNh3WdHWlTDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="57694189"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="57694189"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:27:27 -0800
X-CSE-ConnectionGUID: 5n7eCOM1Sl2n6+pbpn80Vg==
X-CSE-MsgGUID: XL/7dnkLSyS5VEOS5bwArQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113430897"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:27:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 14 Feb 2025 05:27:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Feb 2025 05:27:26 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 05:27:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRswcRU7VyHFU26rj1yYfApr0pqFvluUeSYHkVfl1ADXpzS1gu2HIz2MFYWF8rgnnFZ4eiftwjlFthvHKy53ZY99J6ZQJb5sLvZg+2CrH1H3vcb59YohP6q6Vp1hOQEU+oEoWORhHHer88IUpcTdPArt+QWFSNJrQH7Nbu5K5M/rp0MCj2K2yiACjn8UfJQbqDKZlfbIMUFSFP7ec/VpUs14l3eS/i0/eSyxMP98t8a6Rwjff2sKZ1TxPWwjMn6LfOxgyAwnr2dyTdrlNiGAUqAN6OwlQhkqFCN4a5z3qaDcehticU8F7UdEOpFqEZoWaAOqfa+kZ61i3wFZ2TS8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXjsbAwwehwbfK+wNmm8mMXoLJouiwkfgYUptQx1y7U=;
 b=UfLiXD08+Irb/rr464TztrQydrmSCoZ80lLU7p6DjBlwHaEyJQN7Kv+NkHkJ5u2Z9Uqq4DqgUidW+ZYBLLgFPo92a8gQ1S8NWe9gntoSNtolquBqUUbReVJxi7WR4xKKqdZj6Uxy6sLqc/b97/vnGdCv30Xxolv+O+LuOIqT/CqUXLiltVdlYezSsxlk2EKPbB71sTIAE4+9RR8TotaNWcsqWwuQqdFovvtRtzM/+ivllcBcfvrCJsTwi12U+6CZJKmZU1HOGiG1+zq8djHnbhGzi2Wg+qOq0X1LTkYi3iFPsOoJJMc3qXVc8yX1gzSwOnsdC3OyV1/xxHkH5ytHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 13:27:22 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 13:27:22 +0000
Message-ID: <d556d7be-e3c5-45c7-930b-386576f0e2d1@intel.com>
Date: Fri, 14 Feb 2025 14:27:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Remove redundant variable declaration in
 __dev_change_flags()
To: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250214-old_flags-v1-1-29096b9399a9@debian.org>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250214-old_flags-v1-1-29096b9399a9@debian.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0112.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::41) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|CO1PR11MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: a5eb32d1-b9bf-4de6-d837-08dd4cfb4ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2cxMm9GOWVEN0RWZEpJSlpGTmpoVDU1MlJLY3FDQ2ZpelJHajViT2hzZlNT?=
 =?utf-8?B?OStVc1ozNGJPOVR1ak1IVFBFejUwUzFtNmhxazFRS1d2NktWY1ZlSzQ5S2VJ?=
 =?utf-8?B?ZkxOSFFtbldEU3lCM1NxeFc5elF6Q1JKS0NuWFlST1B3Y1N0bXZxN0F5ZkRy?=
 =?utf-8?B?YUVYK3VRNVZab2RCN0lrSXRKZ2xyUEoxc0gxbFV4OGxRVWFDOUNwajI3VjZF?=
 =?utf-8?B?K2I1WGVGcFpNOHkxekRrbDI4UzlFZFZEREdDZHN1SEtBTWpja1p0S3MxdCtY?=
 =?utf-8?B?VSt6Z2ZISXk0cUNrc1FySXhFRExjaCtENEJmZHlTQWp1QWk3OUIzdy9SNDRr?=
 =?utf-8?B?aDlseXhZMjJxWmhBOUp6SW12bjM4WVQxdm1IUVB1bFRVTDhpblNKbmVXVFVu?=
 =?utf-8?B?NENhOGdmcGdhM1E4WEdtY1F5eTJYVHpSVlk0azgxKzNZdFdENWkwUTczSk9j?=
 =?utf-8?B?OFhUQjFWdW03Rk90Q3R3OEk1amI0aC9Qdm96VG5KV1R3UUFsa29ZUEZzbDZQ?=
 =?utf-8?B?U2ViMWJXR1NWVFRaeU12c3V3blpwRWNaK2luTlE5THo4RHlneThwM3NHQ09D?=
 =?utf-8?B?bDQra25BK1dHSzRJcldoelQ4N1VSazg2L2creGMrTUNObGFyV1RQZUxkb2tj?=
 =?utf-8?B?Rmx4Nzc5TkYyNmtnMjFqV1hFVUNqVTlKV2IweE8vT0owekJQRnVuTUFKM1p4?=
 =?utf-8?B?UmxRU29SdFgreHVwVDMwRyswYUhPYTVEelBSWkZtTjFhbXFvWGw2cFNTYy9T?=
 =?utf-8?B?STltaWRXQ3l3QWtleFJnRUUydFVsckR3aUl4ditld0ZuakxWMnRIekYvRXdp?=
 =?utf-8?B?Wmoxb0xsYmRmZ2M5a05QU2RweEFHRmpMV1lwTmZYZDZaMTEvak04RlphaDBw?=
 =?utf-8?B?a3YvVjAvRUd1Rk85RHRsakJyQ25hTEhqRi9ybmtuenN2VFVuRGNzMEw1aUMv?=
 =?utf-8?B?SXlLdFg1YkNmQjJBWWQ1aUlUNVhjNDY2YllpSXFQbko4Vk1zTFlJMElLdW02?=
 =?utf-8?B?b2tsUmxuVzNCMGRMOWNSaSt4V2pCTndBTjRpdWZleVR0U2NZYklSSUlEdHZs?=
 =?utf-8?B?eEwxcVduSmNiMld1QyttTkFCZ2Z2QkhCWFljaHErcklLd2pHYnAyc1B1c0R6?=
 =?utf-8?B?V1R2aGRzYmEzYWUxU1cyQTROL0pMNnpIZlpLd014QWNnRlF5MThmcDM3TXdX?=
 =?utf-8?B?Y1U2RHBIL0d4STBPWFpCMUJRaldSSGswNHordUc3Z202NVF0OTlpRmthc3Iy?=
 =?utf-8?B?TVVFR1hQbW5iR2UxVGVlSnVJdmdjVy9pUjc4QThheldmYjlxdHk3R216QTZ4?=
 =?utf-8?B?U1ZZN2FRQXFQQWd2bG1lV1pOY2dHR25ZeitKVEhEQVFzYVJSWDNlUEl4a09H?=
 =?utf-8?B?VlFlVktsZy95aDYxRDllYzVhS2NXWEordERPZENZQlVpck5GWmdYdGlmVjhi?=
 =?utf-8?B?dmxsVE5FUHNrOHI4SVlkZ2RPKzVnL0ZIeExDa1BxR3VmdFhqN2R0MWEwM2tC?=
 =?utf-8?B?TG1ia2x5dmxkb2dQSjlJWERqNEVBVjN6WXRhZ2VsUWZLTXNoLzI0UE1tL2pw?=
 =?utf-8?B?T3Rpd0ZqZEdseHpYZkxkbFpuVFI2RFJ6d2RnMGdOU0loNkhYWlc3TENnbG5D?=
 =?utf-8?B?Q0dic0ZiaUo5dTlKZHUzNUZKL1hxZ25saWJVcmtzd08rWldIb3lzckFzMlZn?=
 =?utf-8?B?UGx0Ukk3UGtDYzk0WDZvNFBKMXV4RkFlZURDcUNDdzlQdFZQeEkxc0lXY1hx?=
 =?utf-8?B?ZkFwZ2MrVjlKNzAvSFE5QUVYR3M4SzlUNDJjSUs2OVNkOER0SlVWY3RDRUJj?=
 =?utf-8?B?Qk9UL0NGQkRTQ1JySXo3ZVJvRGtuRUx4OEM1TEVWbXF5d3d0QjQ3UUxWd3BY?=
 =?utf-8?Q?TIHvpiGYDpZ4i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1hqUi9zNmI4TTlRUnd0a3FHQjViNzU0QUo5V25KM3Q2NjRXcmxYU041Uis1?=
 =?utf-8?B?RDhEdzJ5NVZUZHBZNnJUd2tjNHk5c3g4OHBHS0wxY3oxelZZZVZmN1JsVjdZ?=
 =?utf-8?B?TXFrUW0xMjN1TVNHS2FMbHFiaWkxYWNubjRSakNwYytWNVUxZlZTV1VBMlFi?=
 =?utf-8?B?bWc1VlF4cnArRjFZNitRZEhqWE9UTXdNMWJqWmNiaGl0R3BaQ2pHUDJZcDgv?=
 =?utf-8?B?UmZ4TVRWZ080T0lrOFRJd0g0RnVKVEUwMkdIQmZBNHJwZ1FHZnBxR2FNSUtN?=
 =?utf-8?B?ZGdLbEZyVWxPbGtmK0RjcWdHclJxUW8xcVBVLzJpdGVNTlhqckt0bmRTMHBE?=
 =?utf-8?B?d0lvVzI3UGR3SjV3cVBnZ29jRUZ1eXhlUVhuMWJ5aHM0dTJaTmk0TXBWcUNP?=
 =?utf-8?B?Nk1hTUdkSHJBSldoTHo4RndvU3c1Sy9LaU1Tb1p4KzJETE44RWJ0dTZXcGdt?=
 =?utf-8?B?NHg2aTh0MVFEdmxRTXRDeWRSY3ZqR01Xb3p5MFREazM3aUlWY2tNSmlyV1ll?=
 =?utf-8?B?a2FlaUJOZ3JtVkJZdzJPeW1KcmtQSkNwSkgySUdMYm5DYk8yWWZhd0ZYKzVp?=
 =?utf-8?B?elBGZS8wRVhvY1RaWW9JZE1Gc1A2akhvZWZhcmxjZFE4dWNxMXYzOHFiSWlX?=
 =?utf-8?B?bG82eUJPazZVeWRBYzRlMU1YNXdBemp2MzJNN1J3YzRkT2tnQlpBRW5OQm8r?=
 =?utf-8?B?cEZySVA2VHJScU94dWFPYTQxNDRGZEdtRDlxM1o4OHF3bGljL3kwa3pWcmJq?=
 =?utf-8?B?Z21waDY2dHR2U1lDajdiNnJQMmZHQUVTUThUZFNXR0dZVWhRU0swY0RCQk1i?=
 =?utf-8?B?eXpmSEVWN2FJYXJnTzdNTGEwQ2p6U2dQZ05uaW5yYUVuWDVNLzl1WER3T28y?=
 =?utf-8?B?ZXd2Y3JURU1LRk9KclprOGF6SEFDZEZ0ZkRnUkIxbnlNMGx2eFA0ZThndUlG?=
 =?utf-8?B?cWJNb3JkZWd2eFZoa21Oc05sUllTUjl3T0VIYVRiTFlMMWRYSHJqcHlpSnpi?=
 =?utf-8?B?UkcvTU44S01sNGhlY1djcG1PSjBJWGVRemZOQkpyV2hxQzhQR0lacFlwQzYr?=
 =?utf-8?B?eHF3WGpwSWx5TzRCN1NHbHh0SE1WY0RTaWx0aDRiWnZrUFhZVDVxNVBIOUl2?=
 =?utf-8?B?WDJYSEw5d2RacW4rckJKSG82WjFaN0dMT1kwN3VZK294aFRtZWJ6NCtBSlZi?=
 =?utf-8?B?OHJnVGJpU2NhcWpteGFyL25oMUJ6bnJ2RWhOV1lpTks2WllZdnVrajFlOXFE?=
 =?utf-8?B?OGh6MldTU0xqZzVjbm40ZGNXb2s1Tm0zNWplb3gyQUNSY1pXaW9KNHpiaVdB?=
 =?utf-8?B?dlRmcGkzZTRIVFlsUkVQNU84R2xEYUkzVHVnb1Q1MzNmVWhiSTJ1VmZjbVhN?=
 =?utf-8?B?cG5uTVVaU0pFQUFCbkFQR1JuRm9CMWNmdWJZNmdlRUdDdDlLV0l5YlBZNDU5?=
 =?utf-8?B?ZFMrdFRuYXhYelI3Q0dvaFBzMC90SWZIRmQyOFpVTXZwdEpyekNXT2hwall6?=
 =?utf-8?B?Wmszbm5HYWt2TUp2ai9BNTBPZzVSZGpQOEc0VG5jV2c4SEdaR2JsV3pTNmFB?=
 =?utf-8?B?cUt3c2tvWHFVelJrMC9nSkVmTWFPcFVxOGptK3U3NCtZQ2N5ZFA1ZXRIODFr?=
 =?utf-8?B?YUMyZmI5WlZBVHBwVklENzR0S0NmSTh6Vzh0UVBvbThYZjJYZzg0VmlkS2JG?=
 =?utf-8?B?NlRualUvRXA2VXoyeHRoaXJOUWplbjZMVTNWRHBQQXpndENvRFFvNk9hQS9K?=
 =?utf-8?B?TUh2eEdUbVl4ckN5ZjBwS2s0ZUdQYUlWbkpEMDcwOFBpTWxqVDFHYW5tSEpC?=
 =?utf-8?B?S1BaSldUaVBLcVAyUm5YTkVKUDNaVHk4b1lGU2RybDlSUFQ5ZXJpaTJiWjhp?=
 =?utf-8?B?Y3o2clZ4Mm9KREV1Z25LaFlrNXJyWUJPeTRQMWpiUWFWYy83enBrdmlwa1I0?=
 =?utf-8?B?WmNXd0JyelMxWW9DZEZaY09DSkNpbmlSNzQ2dmN0OVFqWEJMMjZsNFhxZzFX?=
 =?utf-8?B?Q0dlMitIMEp4VlRSdzVtYWo0NC9HUG5ldnN2QUdTRWZKMG85eEpIbER0Nk94?=
 =?utf-8?B?Z2VCQzZ2QkVHaVRVTmtUdWduVlpDanJWaVAvVlhNV3ErTkQxWnRpS0Z4WDFr?=
 =?utf-8?B?cG1WNEF0TkhSSkMzNmZKODJRcS9JYnAvRDMxRXFtSUtJOVZRYUdZYnpwNTBn?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5eb32d1-b9bf-4de6-d837-08dd4cfb4ffe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 13:27:22.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0yxACEnWWSmYeS/HleemNGKjvSLDuno0VnfO3RAKcq5emcBYeewFcWd3b/3aWxUwC3KGe510sWnAIidS35QwqnS1Z0wV1jRxPwvA9vm0d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5028
X-OriginatorOrg: intel.com



On 2/14/2025 1:47 PM, Breno Leitao wrote:
> The old_flags variable is declared twice in __dev_change_flags(),
> causing a shadow variable warning. This patch fixes the issue by
> removing the redundant declaration, reusing the existing old_flags
> variable instead.
> 
> 	net/core/dev.c:9225:16: warning: declaration shadows a local variable [-Wshadow]
> 	9225 |                 unsigned int old_flags = dev->flags;
> 	|                              ^
> 	net/core/dev.c:9185:15: note: previous declaration is here
> 	9185 |         unsigned int old_flags = dev->flags;
> 	|                      ^
> 	1 warning generated.
> 
> This change has no functional impact on the code, as the inner variable
> does not affect the outer one. The fix simply eliminates the unnecessary
> declaration and resolves the warning.
> 
> Fixes: 991fb3f74c142e ("dev: always advertise rx_flags changes via netlink")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   net/core/dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d5ab9a4b318ea4926c200ef20dae01eaafa18c6b..cd2474a138201e6ee86acf39ca425d57d8d2e9b4 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9182,7 +9182,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
>   
>   	if ((flags ^ dev->gflags) & IFF_PROMISC) {
>   		int inc = (flags & IFF_PROMISC) ? 1 : -1;
> -		unsigned int old_flags = dev->flags;
> +		old_flags = dev->flags;
>   
>   		dev->gflags ^= IFF_PROMISC;
>   
> 
> ---
> base-commit: 7a7e0197133d18cfd9931e7d3a842d0f5730223f
> change-id: 20250214-old_flags-528fe052471c
> 
> Best regards,

Good change but it has to be tagged to net and not net-next. Please
resend but add also my RB tag, thanks.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


