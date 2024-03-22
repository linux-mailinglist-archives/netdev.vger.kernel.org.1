Return-Path: <netdev+bounces-81237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B1886B76
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4CD1C208EC
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AE03F9C8;
	Fri, 22 Mar 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MStWK28/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7C3F9C0
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107913; cv=fail; b=ITfIQ7Nh8SSp6k5DG4swZohUcaU6lsR+CXXhYc/AGwyouOCMAN1yglZOuO/9TGpHsTuQL6TNCji2X0lGrYpIjAp0g0b9w3SzQWeKL0UbgdqWZLwb4KRaskk29GDBzSl1veiHu3IBiR2VeCS+UGGwJ2X8XWrHsVdF438vDb4nQAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107913; c=relaxed/simple;
	bh=IASHX1jfqDCQItSzfw5/dy4ObwsTNdZ2cqpPmULPuPU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X1235D+c/RCdI1gqoMmLm7iKoW/NFiuqu0f9JA53idbBEn554T8VXq/uNgyxjVdLuT0zQLghs6gBAYPi32GvtOXuDu88F0h2XoLObd4QjfSDmXSWF8wdsmrghNEfclwOEVKMUeg2RW6oZJRPIj02Zf0AcyEpdLaehpGsXQOoQ34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MStWK28/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711107911; x=1742643911;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IASHX1jfqDCQItSzfw5/dy4ObwsTNdZ2cqpPmULPuPU=;
  b=MStWK28/VWd7wxcVdka8phjKj1zMzOrjEZfN48wdCbF22tJpmgNSVqh4
   OfXmmUbdmHow0mCUwf2yIrfPphjKOgzpQTI61E/bPHu4B7h1t8gPVgYyZ
   AsLp4CuIrJ2V2GTrSbOyVLL8b19OLNE92UeKWBX6um2B7j/liSAVjAB3o
   86lnjVbCETzt2dtGhx0i+s9hJGNNAgKjBvsvcRDR0F74r6NPbqdx8IsGR
   XbJ+VMLENh13vNZTZG5qtmVS+m4hEgBgizbP9yaN64yCKULfAL1CuQvXl
   BXEBef6IoxNbBeBsWgbwGSBj47rZnqXJA6lC+/zkwi44SrjBZy2Zpv2TD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6006017"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6006017"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 04:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="19573470"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 04:45:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 04:45:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 04:45:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 04:45:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 04:45:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca6JxghQocS67FF0IV1OLBPtLGLAxPsT4HWLS3KOsYd2FJc2P5HqJa3xf8ccvnzNd4wZjv38acePs0fN6m20u6UnRMSEBQKf5rocBCJ0MabVYcycbTPjfneK829H7TcJzkslhslsfz5r2zrkFZCc7ux+ZSHJMKMs3GL4LwnapFFIk60x40cHYgCH22AnngvFDCrrh/qTkyNjDwxR+SwR87DOe1Oeo66x0r1xeG2zUf29WT7xgY7XhvRxk3BSXxIx862YEjEr4YSPKTdGU8MNRYnHwR942uPkrXXUf1lTc6MvZnHGI+eypNgvOqMod0tWKu3JZPQStv2lccz8ky4BUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYaLCkTzADMEBzimhDAQjmE7ANaHPQ9K+hhuGZAL+9g=;
 b=F2BFxWR1sZaPqVUCYkfVB5yim+Z9dpf02XZ7E5V/4Oc6KkLHNU9mUwf6qH00hdE5yM7YHXwp5r4pI8rNo/aXj6rovvj9UgBQjBLutolWfqGtlLuGobAM5gq7fr+De2hlElrBSIVTi7pZ1fuHg9JNhc+uOU/P7oCqqTETjf7SsbvP1NAVn4Lkxbf9mNYCyQuJOeQQjKYgbDKUT8QyoIz+lJscPL/U790Ska+pJ213Gpq5HKrJcVKgHno5XXzVe0waizkOwAqZZ6f+OWzKdQp19LX4XJFpncdgKJZysnjUmiKGc1NO9iVc9SUVxZXVekHS95x8g6+R+1z5426VBqUtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5054.namprd11.prod.outlook.com (2603:10b6:a03:2d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 11:45:07 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 11:45:07 +0000
Message-ID: <d415fc40-efbf-4f83-9c4a-4ec7ce333bb1@intel.com>
Date: Fri, 22 Mar 2024 12:44:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] devlink: use kvzalloc() to allocate devlink instance
 resources
To: Jian Wen <wenjianhn@gmail.com>
CC: <edumazet@google.com>, <davem@davemloft.net>, Jian Wen
	<wenjian1@xiaomi.com>, <netdev@vger.kernel.org>
References: <20240321123611.380158-1-wenjian1@xiaomi.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240321123611.380158-1-wenjian1@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f02f4f-d7db-4dc5-07fb-08dc4a658534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35W/un+QZrEdDpm+HdJ8UOn0a1AATPFBbpaV0L+x6AoCtsc8b6HPOPgmbM9AskYAn2LZKmDmPPt4QoxP2W8uO0BccUpUbOCoth+nXLhyvk7WCzv2D4KXiii21+VZe6fAsrDRa08R3kGm3C0tMC4MhKqB0qpV5CIP5zrW91+hRZiPRLjQBWc2Y5AOsBaL0fmdLEA7UKtrVMfirOMmheTPrvDtAdTlVbexp68SUA2nWcw2lJTJ6vJRKwdi5vGcaTmDA8hAtVGHoSNpz9FOH5xsTbfFcEkcHsFPgDTSVprG/axs+Oi73aGvbMxocXdFU7OEr77bLO2q6+nQDPzlIdgrBh/FO/mHiTI0AC8wMAS48W3+4RziFoGfnO/MctCJZ5DiNhyZHt9WBiCMaz/6YXc0jZO3dU89D3Urs0Pn5md/DakYolRShxGaEdNdcRTBOw+rEzNDw9aegMdw24gvE0rCIIjk/DgVzZ3x0vMYb1wLRAYez4bp2uKvhOqhnEPrro1uSbpny4LB6lqI+lEsxImP+v06D4SDEt+WDqkjnGeHpWdvCIkgMncDdLj2/1F0OTWVkgea1uAgD6iIl5gDnqVX+394LtNx2uDXT0KK6e82AGbv8WKHoIezdKYfNppxiONl1MFgy9j9gFuhNadKv1Jur6EnVrKRtnzVPTbtzvN4ucw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHpRZmt5Y0YvWVFObjh2SjZRWEJzUTlraTR6MjQ2VWhrWUVRUHdYcTZpc1ll?=
 =?utf-8?B?SnlKSWxSZ0diSC9tUjVyanJNMHpJbGxvcU1maEtzUTMrdnFzK1MzK21GVk1F?=
 =?utf-8?B?VU1uZlZKWVdvNytCS3prUnlNTVBlL2d6NU5QL1Q5R1A1WkRJcWZoVVI3eUJs?=
 =?utf-8?B?VXMzYjd4VW4wQzloMkpaclgrODhUeGp2dVNsM0MxS28yMUwybEV2d3ZFSkhp?=
 =?utf-8?B?L0Zvbi90b1EwL29tMVhreVkxb3ZoYTFVMFB3NnlTekNpWUMyZ0t4QzNBSnZK?=
 =?utf-8?B?dWFibHhPQWg1Vk16V1F6MjBHU29mRXpvcVVPUVZ2T3hMdFhTckZ1clBwdHp2?=
 =?utf-8?B?enh1bnhaMXgyM1V2Q2VsbmFXWVoxSWh2eXJacld1clMya3RRT1c2KytiZW5B?=
 =?utf-8?B?VDc4TXVKSXZEL25ocENZM1ZKQks2c1pDZkNTeXk1S0VPRU5xNk5yeEx3Z29H?=
 =?utf-8?B?ZHhwUTlKVDQzbUQveHRFOXZtSGc5M1NHeUhUVDBPbnFxb3Y0UkhVdi8rL0lE?=
 =?utf-8?B?dkc1c2tndTlIK1pBR1ZvQjVUOGw2ckxHQmV1ZDd6M1JWbWg0NkcyV1lIQXhR?=
 =?utf-8?B?THk0d0RhOXVpb1hYV1BxOGZXWU5UYm1MdGxjZTVDUndkQzl6akp4TU5ySlFz?=
 =?utf-8?B?aTRMSm1BUXE2SDhHeVNCM285cjlSdUhjdi9icDQzR05zY0t5SDhHL2FvdlRi?=
 =?utf-8?B?dzJaVTNqVVdTSE5kSmJSdHJUMlBLb0JwK0xMSXlmS0hhZ2JyTFNxaTc4Y1pG?=
 =?utf-8?B?U0YrbDUxSUJPQ3h1N3oyM01zaSttN0c1ZTJZQXFvWnRkNjAyTzVRUXFndnE3?=
 =?utf-8?B?NW5Rb2NSK09tbCttZzd4Zmo5NlhKNEZ3Z0Y3cjh3YjMvOGdUcG9ydEN5Undk?=
 =?utf-8?B?Ry93c3R6Y1Y1RSt0Z3V2Y0NxZUh6a2R1ZStqZWpJNUw4V25Fcjh5N1VINkdU?=
 =?utf-8?B?cGdnektjYTZDeUhqNEMwNVhWM1Fjclp6QS9LRWU2b25hYTNZOHZoVUh6bGhZ?=
 =?utf-8?B?QXVGTU1SellqM1F6cjR2ZjVkNnR1VGFOcU1FSmRpZUszajBtcmtvR1JyNy9E?=
 =?utf-8?B?Z1FYRW41R1oydVRFOHdQb2Y1aW5GbGdJUHZFNWhZQVRncFFibWVrbTUvVGRP?=
 =?utf-8?B?NnluaUtoVVlxdlRnaHpGaFU5dGJaZTR1MmMrbFZNcUpkaTcvdDYwUHlXWitI?=
 =?utf-8?B?bkd3VCtBS29RRkZHRlQzYlJYSjNhcXRBMU9hVS9PWWNFOS9LSndsUEt1VGdr?=
 =?utf-8?B?T09OOHN0RXVkeEVBU1h6WGo5Ylh2MCtONmEyRXFPcHJLRjZQaXJodzdLQUo3?=
 =?utf-8?B?ek92WlFEdUxwSHpoN0VOVlM0SmlZUHBod2VzK3ZJbjhhWWVDRkhGRUdwenBR?=
 =?utf-8?B?R0tYZDBvdGVwbzY4RTllWG5EMGdXemRMOXljbGVpdGJJTE9uOWhETWZza3Bt?=
 =?utf-8?B?ZW9hbkY4N1lnZkFEWWFRSEs3czFKbmc1TUZkMERWVnRUN2k0RjJMakIrR0l5?=
 =?utf-8?B?a2ZLUUdINGtzRE9ycjJybVRnYS9JbHMwc050eDRHRDlhK0tjMExSL3phY1hZ?=
 =?utf-8?B?MWg1OWZsR3ZhOEJBUElYOS9CZHVuUGp1N0FTamVubGF6SWZtK1AwUW5ZQ1pZ?=
 =?utf-8?B?bCsxUUNkSXZIK3Njb1dvcFZNRnIwc0JMZEp1WlVXaXl2a3pRWjUrUzZ1VkU5?=
 =?utf-8?B?eDRnaGI4akhRNkduM2svZ0N0V3F1REhBeGRrcGRoVHNEcUxMVW8zUGgwNnRo?=
 =?utf-8?B?QjZrL0NNTWNUa3F6NHhwaGRZRFhtRkdtOUJNS1d4by9pdEtSZmlGcWZnVlV4?=
 =?utf-8?B?dkVZR3Z5Vlo0azRyRkt6WXpzNDRoTVNaUkFtK3RNUS91NCtkYUZDemU3SnNB?=
 =?utf-8?B?cjFhS09ZZXVMRVNrL1JaTk9iVXVRZXF2K3FzVlRKQWRWaFFRTkxIL1ErQ3ZO?=
 =?utf-8?B?L093ZktoR2tIUCsvUEpyb0ZTUU5HSmNqZmh1eE1RZWhXYmNjQnB4UGNVM2Nh?=
 =?utf-8?B?UnVXWjkyYytkYnNkSkdRZnFSYWJZRkRvTnlCaWR4K1FNcjVFTFVSUjBZeXpN?=
 =?utf-8?B?cFNMdGpRUTRzT1E1WGVLNmoxTVRXYWF3OVNGN0pPQXp5UU1JVVBHVFh3V3BQ?=
 =?utf-8?B?T0NoSERwWjVPalZmdFBKakNmeURmSTNsbnlaektUK2lDRE1aR0pPa0R5Ni8x?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f02f4f-d7db-4dc5-07fb-08dc4a658534
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:45:06.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c50K+z4f3wMJKGAmb66eAKGIWMSY4SlBCx2QJgFEdIH6eXsYm7zjN9A2tiyqjmSgsttf6DZcNHX5GKewRI6o2QLgzcgB5CLp/maHM2ksSm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5054
X-OriginatorOrg: intel.com

From: Jian Wen <wenjianhn@gmail.com>
Date: Thu, 21 Mar 2024 20:36:11 +0800

> During live migration of a virtual machine, the SR-IOV VF need to be
> re-registered. It may fail when the memory is badly fragmented.
> 
> The related log is as follows.
> 
> Mar  1 18:54:12  kernel: hv_netvsc 6045bdaa-c0d1-6045-bdaa-c0d16045bdaa eth0: VF slot 1 added
> ...
> Mar  1 18:54:13  kernel: kworker/0:0: page allocation failure: order:7, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
> Mar  1 18:54:13  kernel: CPU: 0 PID: 24006 Comm: kworker/0:0 Tainted: G            E     5.4...x86_64 #1
> Mar  1 18:54:13  kernel: Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
> Mar  1 18:54:13  kernel: Workqueue: events work_for_cpu_fn
> Mar  1 18:54:13  kernel: Call Trace:
> Mar  1 18:54:13  kernel: dump_stack+0x8b/0xc8
> Mar  1 18:54:13  kernel: warn_alloc+0xff/0x170
> Mar  1 18:54:13  kernel: __alloc_pages_slowpath+0x92c/0xb2b
> Mar  1 18:54:13  kernel: ? get_page_from_freelist+0x1d4/0x1140
> Mar  1 18:54:13  kernel: __alloc_pages_nodemask+0x2f9/0x320
> Mar  1 18:54:13  kernel: alloc_pages_current+0x6a/0xb0
> Mar  1 18:54:13  kernel: kmalloc_order+0x1e/0x70
> Mar  1 18:54:13  kernel: kmalloc_order_trace+0x26/0xb0
> Mar  1 18:54:13  kernel: ? __switch_to_asm+0x34/0x70
> Mar  1 18:54:13  kernel: __kmalloc+0x276/0x280
> Mar  1 18:54:13  kernel: ? _raw_spin_unlock_irqrestore+0x1e/0x40
> Mar  1 18:54:13  kernel: devlink_alloc+0x29/0x110
> Mar  1 18:54:13  kernel: mlx5_devlink_alloc+0x1a/0x20 [mlx5_core]
> Mar  1 18:54:13  kernel: init_one+0x1d/0x650 [mlx5_core]
> Mar  1 18:54:13  kernel: local_pci_probe+0x46/0x90
> Mar  1 18:54:13  kernel: work_for_cpu_fn+0x1a/0x30
> Mar  1 18:54:13  kernel: process_one_work+0x16d/0x390
> Mar  1 18:54:13  kernel: worker_thread+0x1d3/0x3f0
> Mar  1 18:54:13  kernel: kthread+0x105/0x140
> Mar  1 18:54:13  kernel: ? max_active_store+0x80/0x80
> Mar  1 18:54:13  kernel: ? kthread_bind+0x20/0x20
> Mar  1 18:54:13  kernel: ret_from_fork+0x3a/0x50
> 
> Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
> ---
>  net/devlink/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/devlink/core.c b/net/devlink/core.c
> index 7f0b093208d7..ffbac42918d7 100644
> --- a/net/devlink/core.c
> +++ b/net/devlink/core.c
> @@ -314,7 +314,7 @@ static void devlink_release(struct work_struct *work)
>  	mutex_destroy(&devlink->lock);
>  	lockdep_unregister_key(&devlink->lock_key);
>  	put_device(devlink->dev);
> -	kfree(devlink);
> +	kvfree(devlink);
>  }
>  
>  void devlink_put(struct devlink *devlink)
> @@ -420,7 +420,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
>  	if (!devlink_reload_actions_valid(ops))
>  		return NULL;
>  
> -	devlink = kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
> +	devlink = kvzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);

struct_size(devlink, priv, priv_size)?

>  	if (!devlink)
>  		return NULL;
>  
> @@ -455,7 +455,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
>  	return devlink;
>  
>  err_xa_alloc:
> -	kfree(devlink);
> +	kvfree(devlink);
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(devlink_alloc_ns);

Thanks,
Olek

