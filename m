Return-Path: <netdev+bounces-123727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF769664B7
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A400F1F25202
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E19F1B2EF4;
	Fri, 30 Aug 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lx2kPyFT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F11AF4E4;
	Fri, 30 Aug 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029890; cv=fail; b=hBh/m/5M5ugZrLLTyPhJoYNCC48BUQ+DCDzd76AYVBL7aW3Gj+3dGsyQt0BCxS++daSZIPreOQ2i2yRHcGJGnT+zIwvA+qnFLl+1pZUdunFhKa/2u1ynpQ2qXIyQ+l1LqMHi1sjOQbXyGmP4H7EtFWB9mtRaYTwOpJcQCWBODWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029890; c=relaxed/simple;
	bh=Yve6p+qmrDJPl9m2B6iLlM/v/YOXKowbXyaVnshqG0I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ly8HI+3+o8tCT+hiCz0tFgr2s8BaF+DqVXrybFrpWwbNEvw+69IW0LZYNvmk5LyDIQZ6AUBBXgZnQB8EN8uMT+zkUlJAlhI1Nnz3yMqZ4B6wQnz8XhxE5WQ+GMlwYFCeT1mew4ypbexnidfk+EBiYKGsJvj+UXp/R5Tbtn3gVoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lx2kPyFT; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725029888; x=1756565888;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yve6p+qmrDJPl9m2B6iLlM/v/YOXKowbXyaVnshqG0I=;
  b=Lx2kPyFTDKwmJYWFNGAFmuaHdWPqbGHPUuuj487WWGK48SpfK7Rm9ehr
   RjsH/u+kj88dKAg6IsnIbbkuBNJWpIC2LxnGerEIha8C5XDfBEXBLpK54
   lpyuA6+QdKmtZ69uuejDwGwXT/aHYI9EdEr6I1OQbRMOf21iOQCSPH5Ka
   Xguh8pNiaNbK+ZB4g+i78q2WrjCGH5Ugl9TJpKXGbkcmVslIbDwCxRl71
   sAIP0yxGBe4ArJ1AypAE+PDCyHKUKutsqA+gQFtRR5WA19qPMdy2Mir/E
   UWWAecocikZej7C77EnHC2eghhL59wmh2KG7DgDHUNnsD9BbhP4hbSB+c
   g==;
X-CSE-ConnectionGUID: g22XYIStTvKsvGXJEx5WLg==
X-CSE-MsgGUID: PgDO3YM2TuCZ9f6iQyBhfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="26572137"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="26572137"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 07:58:04 -0700
X-CSE-ConnectionGUID: yFXQ8dmCSxuAssVt8JZQrw==
X-CSE-MsgGUID: lphMgCV9ROCC2IZ50CGojQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="68816904"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 07:58:00 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 07:57:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 07:57:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 07:57:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3D/y9cmT585PjmwvgTU1mW15GD2F8tsM7VaT7e22XvIelzJjD67LtioGDO/BA0KXIbjs/6GJOl21hS+BXAb5VqMUEImDBK2zkdQlInHwVH2EArPsHLtF/bRUQdkc91ijAALnmDP9KJhiGParqtjpXfkWcSnM+THy6Tm9nXZWVQDHQOino0MwsyVM9sCM4ZydHnPrFklc6OMwy0+pLy5JTPSkBl2tIstw8KKvazn2uprr+AWZWCB8v+DmZy8vIFTN3XgKfYnMeuGqlZE+E8wyRAvvZ8czcN/xzKtjrEu01DzxQRfa0+Dkf//UqlmhjhZaRMkAF+BhnnBOhDkLxh0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsyIGew2J4tOffP0bvKmvyTtvXAtpIQ2BtWq2fdeoU8=;
 b=Q8sy0Hz/WehZC8mE5bWD/aHtbO2HXUa/U4RwRtNiLoX73s/eBu6p01xEpkUf+32ekV68CJUYlskA4fySpPpK1taV3kPcCq/W8D3KlV4GNL8QQCAM2gswm6Y+zggOXZw+AgjXWBi0GmjHsknPA8QR7z1GFDu66swomV3KPqe2e39pmn8+NCqi0adX4uEiFWo2spZUsePbjdoIUwbnRZGtjYqvf2zuYdrBJMJmK0w8pzcVJIHM4d0A8iEvn1FmPYZZgR1TOmv//z/uOQDcBM+Wn3D4c5XRrOoPWwvp30XPv/Syg7S/lYl3kIc9Y+LZ/e3nOzB0w9d153iLE7utNZCQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB8041.namprd11.prod.outlook.com (2603:10b6:806:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 14:57:55 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 14:57:52 +0000
Message-ID: <19af6042-e937-4025-b947-8ff603b29798@intel.com>
Date: Fri, 30 Aug 2024 16:57:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/12] net: vxlan: make vxlan_set_mac() return
 drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <kuba@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <dsahern@kernel.org>,
	<dongml2@chinatelecom.cn>, <amcohen@nvidia.com>, <gnault@redhat.com>,
	<bpoirier@nvidia.com>, <b.galvani@gmail.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-7-dongml2@chinatelecom.cn>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240830020001.79377-7-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f71ded7-64d0-4697-eb3d-08dcc9041f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1ZHbGRmdGNWVVZtQWhIajRUb3BDVnFzaWhMSEplTERMK3JXdUlCc0FKK1JD?=
 =?utf-8?B?WEsxdSs5M0c4djBlL2FVbk9VUHptaFEzU2lBQlJOOFk3ay82MW5CSjU2U0NS?=
 =?utf-8?B?SzJTb2ZwVnhvVi9DQWdJd1FkdURzazhJcXd1aVR6OVpOME42Vjg0MkQzdlZL?=
 =?utf-8?B?L2JhZVlRVFkrRlJvb3FOdHd1K0U2R0FDdTl6VzZzWVJYQmEwblFHUFkzQWdy?=
 =?utf-8?B?a281T0tOY3FmQm10TGJCakJwRnh4Q3F6dzAvUHZDYVNhRk9MQkEza1FHZy9L?=
 =?utf-8?B?S1NDc1o2ZGpxWXd5bXB2c0hOOVdRWUtEdmsyQ2ZSaDRaajVTYitGV2x3YmxS?=
 =?utf-8?B?MTVOYWpqTkxpMzBNbXlTRnljSFpSVE9NdWJxaEs2TGFDc0ZYa3o1Tkg3bVZJ?=
 =?utf-8?B?MkpVZmxwOHlJbi9OWkhiUzBnaHQ4LzZYc3U4eGNzYXV5TVF4SXNsd3U3VlNJ?=
 =?utf-8?B?bGwvY1ZRWXA1bkpyaVUwSlppS0hXejl1NXhsSFNuTkx3S1c1R0RuRmZaTSs4?=
 =?utf-8?B?Qll0RjdQa1ZHMnN6bllxelJXZEo2Z0s1Zzl6ZzUyV3FPZmQzRmh4ZlhITVc0?=
 =?utf-8?B?R1N5bmpVamtnUXZtM1hGdnJpNzNXb2VjYnJvTGtvWm1kL2tJcWFOdDUxUmpK?=
 =?utf-8?B?YUU4RGlGR3owdWlJcDNvV2szMjNlQTF3RnoxQTF5dmd6Y0lFSnBRaUZTeVRz?=
 =?utf-8?B?YWNzOUFtSDFXT29GMCsvTFp1ODRUbm15MmVBY01CM29ONEZMWGNGNCtOU0JO?=
 =?utf-8?B?RmI2T1d2QUhXekUrZGM5WnhuVXNINkY2Z0w1L3NwS0NOSThnRVhPZHNsZVFT?=
 =?utf-8?B?aVQ0WWJ2RmlLY0htb2xDSDkyOHowNG50a2FXbXdsWUdRQU9KaVZ2NE9URGNX?=
 =?utf-8?B?VHB4T3AxM0pWZjdHTVBZNWtYQnljeEJtUmZTUUxqUEFHbzVFV0o3M1VFZDZt?=
 =?utf-8?B?QVArU0QzY2hCcVdIRFpvTjFmMFFNdi92dHBEalQzd2RZRUpKRUJuY2ZadGtK?=
 =?utf-8?B?anZocWQ1a1cwVEZSOTd6QjlITzdJaVQ4L1ZsZ3BuY0R6b2UzK013eHF2aGZ0?=
 =?utf-8?B?NjRjNWpNbWtzVE1iZVdoTTZxTlFRTnkweDNBOGJFRGViOVd2SkVIZWdnbEhF?=
 =?utf-8?B?M1k2akJxOTFIakFGVWV4TndYa3lYMGRROVFjVytWSGpLbTkrSEMranhSd2l1?=
 =?utf-8?B?eVFNRUVBSTk3cGd2RUJtS0JVclIvSDFlNkRpN1QweFk0bkxXemYyUkRqWENF?=
 =?utf-8?B?aVk5WVMzSW1scGk1bytwRHlqSVF1ckMvdldkMXNMVVY0YXlEOXQ5dVN2Smh2?=
 =?utf-8?B?d1hBcWJHTVZuQ2tPanV4Wi9iaHZXaGxwYnlETVhKZEoyUmZUZG11YWpJSFNo?=
 =?utf-8?B?aVVwcFdWZEIwM044NWVielhtdG5aUTNydzFCTDlZVFV5b3ExdWdtMFJvMnBt?=
 =?utf-8?B?TG5JZ29hb2VmMUpLajhvd0tDVXM3TnJGMHk2bWVscmdaU2ZVcHp2RURLUmF3?=
 =?utf-8?B?aGNMdXVkNmhhZEZsUHhGdXJCL3JZbExSQUVGZVdFRGluTEQrbGd5ZS9mckl0?=
 =?utf-8?B?NVRKRnpkQm9pNWVNMGQ1NUZUaTdHblU4RjExdEdwT2FLamQvVlhsb2JHVVQx?=
 =?utf-8?B?dW5WcUtML2xjS1NWa1pNVlhZQm56bHI2TXJkZWcveHNvMzBaV05CMzhwUVN0?=
 =?utf-8?B?MDN3UXZweHhGNW5uVlZmTjAySTk3MDc4WUM4cXVFVnhqTUhubW84UTRYVlEz?=
 =?utf-8?B?Zlg5NGpIeEFSQmZiRE9aWHRlQUdhUFU2NXZSTnZRcVhzN2Z3SFo2Mkxnb1Vr?=
 =?utf-8?B?OVFRY2tvbFJsaGFoVkV0dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkhRR2lxQmdCM3lMeVN2UGY5bm5mRnJuNE5ENVpiRDBBdFdoSVhKTkMrODBx?=
 =?utf-8?B?UmpOZEV1MXJjSEcwUUlkYWREWWlWdjdteG5KeEhWTlQvS2pSYmduTE9udDNs?=
 =?utf-8?B?VEhCY0ZkQ0tjZ1d0TUpoajB1UndEemVnNzh6Uys4TytadWtjNnZJVzdyMEZD?=
 =?utf-8?B?STN3RkFGbjVuZDQ1RFdiaURzZlAwdXhNbDZIbDh1dW13UzQ5UTZsWmlWL3Z3?=
 =?utf-8?B?UjgrSHFteW0zN0tQaFZYcTFsbmJ6L0lNcmhaOERad3pxcHZGNkVsbTNVWWNT?=
 =?utf-8?B?Yk1tVk83UFUwZGNvL0VtOVBiTys1M3QyMVFGTFlDWnlSVVJzdFZ4ZHVub3Vz?=
 =?utf-8?B?R3JpZlZTRXBPaWxKSE9XZnpiQUg3emFOK0xDek9xbTFPbzZ0WlZyenpRbnpj?=
 =?utf-8?B?TFh3ZzBRSVlPVW1wUHZSMXlJSGZTS00zMnlHbk13Y3EycC83WUExVzlKWDFC?=
 =?utf-8?B?eHNNN0QwUUNiWkJhTy9ZcEZ0ajNZYi9jVmNZS21xa0tGWi9raEtSQ3NhaHF6?=
 =?utf-8?B?dEJWamMxY0Z3NW1kYm5obm45bDVGSXQvaUdBYmNpNkd3bG5VWDFESWNQUEx1?=
 =?utf-8?B?Sk1uWkNydmZMbkZSdDJqZ0NzMXV2VlNmOXNqZVlhbGNyOU9ML0ZISzRLclJO?=
 =?utf-8?B?Wkt4cEg5eGpmbHhud2l3aWJ1NVc3Q2FTYnFNOGJZWEVZUitvYzBBV2dkYlZw?=
 =?utf-8?B?UVVZNFVkVU1zWi9BVzcyeXVMeUIvcWRZRVpXR0J6eUhHWUhldm5MRklGNlRv?=
 =?utf-8?B?ZkFpUGE5U2NTZE8wcitNNnA2amFnNFg1L2lvN0NRNVBxWXB4S3ZBTmtlc1BW?=
 =?utf-8?B?VUVyazFCUkNjMXhTQ2k4YTZUMHFycmJjQXZheE8yQ3J2dXUwU0RiNmROSHha?=
 =?utf-8?B?L1hqSlI3bDVLMXI2bHVCQWdNTVRxSDgyMUZEQmhoREV3TnZWM1I1R0Mzam56?=
 =?utf-8?B?MWVtTk56eGlDc2pIVm1vUUhJZGRXY21Lek9sYnVvbllFRzNOVzMrYm03VEd0?=
 =?utf-8?B?OFMvdURtTmxZaUhCRWpTeGE0RkNEMHpLalB4ZG9qSnNHalpOa1llQVlyeCtH?=
 =?utf-8?B?bXpzYyt0eCsySk9WMUY2MXV3Mzc5bTVwbEVNS0NqOTNETTRFNkpsWnFtcHBG?=
 =?utf-8?B?OC9IMGxIbTVxR0s5eWhmU010bkhGdW8zSFlRUDAzcnVJbzRWS1dnVDgyZWNt?=
 =?utf-8?B?KzNwdHpqYk5sQWs0VVRWVzRkaXJrTUh4R2NMK3kzeFNCT2lBbVphVis3elhL?=
 =?utf-8?B?aE9LV1VsYkNSa0o4UWJmMkZvM1hBTlVMNlRGc21Hb01Ld0k5aGZHNjFuMXZR?=
 =?utf-8?B?cEZZd0dxNkhKSlFGRWwxOTNScHNvSHA2L2M2M2s3blZUUFBCRWppZmdHb0Fu?=
 =?utf-8?B?UVdEcGpHbk5mQkJlWnAzcVNyOFR2dzJhNGE3R04vRVdBK096emEwUlg3eHky?=
 =?utf-8?B?MUQ3KzJOV2hjd2x4RUxoKzFRcU1SWGNXVHlHektDbWR2T05xNUtBaDV0d0RS?=
 =?utf-8?B?eVdVMjlKQlBYSGkrbkRZWnorbkg0WVkwVkltTmwvelBNUU5SckR4dXFQek1t?=
 =?utf-8?B?YmhFRTlKRmp4RG1iUWtHRFlCZHc0L1VZWGNIOFpXNC9NMXRha3dPSTg5eEZ3?=
 =?utf-8?B?YndYdkN3c1NtMWtrdFFUSVd1TXlGUzBKZmpFbWlQSGJYM215S1ZxckU1YkE3?=
 =?utf-8?B?UW9IZXB1ZVF4M3ZFeDQrYm8xMmgxY3dBMFNJUkttOHR4ZGZyN244SVBVeG0x?=
 =?utf-8?B?ZVJhUENveVZwa1htVS83blkwcFF5OWpWOXFScGJWYmJ6ME42clBvdzdkQ0VK?=
 =?utf-8?B?QXNqMjIrSnhxNnBYNGx4QWVwRi82bWNqZ0pvT1N5S1UwWnFlOUJoL0RGdS9S?=
 =?utf-8?B?bHNMMVZORXFCR0pMcFROdTZnQitKaDB6VE9vZDVWd2I0QlptYzRVNFZUaGlH?=
 =?utf-8?B?blNaS3VzZXcwQXdHK2NuVk1jSGhkZk56bU5kekkrSGZFVlhYYlNIeFdyWS92?=
 =?utf-8?B?ekpJVUlNVUQ4c0lqZG0rRm1RcmNKUWpPNFRzM2IvZy9XbFFpSjhuT2U1b2sv?=
 =?utf-8?B?NVArSVJRRUVsV2pVUzZEWGNpU3RZRjQrYjlyQjdoNWM5YjhLb1h5WU8yVGNU?=
 =?utf-8?B?MVRJWTlBZFRsWC9pQ1Q1cnVXT0c4L2N0ZUdHNkpFQUVnWm5MRDJuSDVBWWYv?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f71ded7-64d0-4697-eb3d-08dcc9041f31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 14:57:52.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqDrR164kEacdzLuYmOiqEwy9TCmYWQeoVTREjMxT5LOMRwZISjZlR1bCkAAFOyvxT831RHr6J6A6HYWP/KTECisUylsM7/Of0xLLU0LbiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8041
X-OriginatorOrg: intel.com

From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 30 Aug 2024 09:59:55 +0800

> Change the return type of vxlan_set_mac() from bool to enum
> skb_drop_reason. In this commit, two drop reasons are introduced:
> 
>   VXLAN_DROP_INVALID_SMAC
>   VXLAN_DROP_ENTRY_EXISTS
> 
> To make it easier to document the reasons in drivers/net/vxlan/drop.h,
> we don't define the enum vxlan_drop_reason with the macro
> VXLAN_DROP_REASONS(), but hand by hand.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  drivers/net/vxlan/drop.h       |  9 +++++++++
>  drivers/net/vxlan/vxlan_core.c | 12 ++++++------
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> index 6bcc6894fbbd..876b4a9de92f 100644
> --- a/drivers/net/vxlan/drop.h
> +++ b/drivers/net/vxlan/drop.h
> @@ -9,11 +9,20 @@
>  #include <net/dropreason.h>
>  
>  #define VXLAN_DROP_REASONS(R)			\
> +	R(VXLAN_DROP_INVALID_SMAC)		\
> +	R(VXLAN_DROP_ENTRY_EXISTS)		\

To Jakub:

In our recent conversation, you said you dislike templates much. What
about this one? :>

>  	/* deliberate comment for trailing \ */
>  
>  enum vxlan_drop_reason {
>  	__VXLAN_DROP_REASON = SKB_DROP_REASON_SUBSYS_VXLAN <<
>  				SKB_DROP_REASON_SUBSYS_SHIFT,
> +	/** @VXLAN_DROP_INVALID_SMAC: source mac is invalid */
> +	VXLAN_DROP_INVALID_SMAC,
> +	/**
> +	 * @VXLAN_DROP_ENTRY_EXISTS: trying to migrate a static entry or
> +	 * one pointing to a nexthop
> +	 */

Maybe you'd do a proper kdoc for this enum at the top?

> +	VXLAN_DROP_ENTRY_EXISTS,
>  };
>  
>  static inline void
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 76b217d166ef..58c175432a15 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1607,9 +1607,9 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
>  	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
>  }
>  
> -static bool vxlan_set_mac(struct vxlan_dev *vxlan,
> -			  struct vxlan_sock *vs,
> -			  struct sk_buff *skb, __be32 vni)
> +static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
> +					  struct vxlan_sock *vs,
> +					  struct sk_buff *skb, __be32 vni)
>  {
>  	union vxlan_addr saddr;
>  	u32 ifindex = skb->dev->ifindex;
> @@ -1620,7 +1620,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>  
>  	/* Ignore packet loops (and multicast echo) */
>  	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
> -		return false;
> +		return (u32)VXLAN_DROP_INVALID_SMAC;
>  
>  	/* Get address from the outer IP header */
>  	if (vxlan_get_sk_family(vs) == AF_INET) {
> @@ -1635,9 +1635,9 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>  
>  	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
>  	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
> -		return false;
> +		return (u32)VXLAN_DROP_ENTRY_EXISTS;
>  
> -	return true;
> +	return (u32)SKB_NOT_DROPPED_YET;

Redundant cast.

>  }

Don't you need to adjust the call site accordingly? Previously, this
function returned false in case of error and true otherwise, now it
returns a non-zero in case of error and 0 (NOT_DROPPED_YET == 0) if
everything went fine.
IOW the call site now needs to check whether the return value !=
NOT_DROPPED_YET instead of checking whether it returned false. You
inverted the return code logic, but didn't touch the call site.

>  
>  static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,

Thanks,
Olek

