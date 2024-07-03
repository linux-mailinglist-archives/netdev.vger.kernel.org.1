Return-Path: <netdev+bounces-108777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7898292563F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDF61C232DB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEC513BC0E;
	Wed,  3 Jul 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUp1eoYK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94C1A28C;
	Wed,  3 Jul 2024 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998205; cv=fail; b=Jq2xwiKa8Ti1vHLJMMDO5Cqw6Lieq63VpVcdyiz5UQmw+O5p8n9xZjZEiK9OHYIHuWB3w0aF9c41MwcrKodL0fRA/iiBWvOAbgo8crhBpATfeOJcjpRHzP2vXHEgSXA1Uw/DRfVLmXbgngJpA5teFRpgpWXQxAQNATkHAZjw4t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998205; c=relaxed/simple;
	bh=M2md0E7/weCT0Kxq5zJ1GAIoLTVSSdXyzkcED1IdaUo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=euUYP6sKJoj5CsG2a7XJ/t2gohZ2Zw324KJHodsxvbauKN4y0P3L2kVVCQzOURpex3CRcQhisEOXTsXskKyMr/CsJwe2yYI4ziRrRP4BStGHJMGSvKMhM3gg6TEtz44CpEVuSmLEsNzIgbYEhpxqCnCC3RYFKSJXwrVRaeYONVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUp1eoYK; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719998203; x=1751534203;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M2md0E7/weCT0Kxq5zJ1GAIoLTVSSdXyzkcED1IdaUo=;
  b=PUp1eoYKFIESbQfZtA8jWrtVeKpgAMVtfpukW0nnzR6H3zdjDxxTrQAD
   4T1gagSDcI1rX2d54dxv0M5br3vcVRy+xOVqLW4h2JNUO1Bpyzowimdh+
   TxL6vrLifpJSD1F7+O1EQX4wQTM/+PY8Z282TfI6sy/oTvTB4SFO40AYl
   CAstL4wE1iGf0g7hF6Hn4245pc+YxpjSzgiTzvZGb9/pk7b9vBxDSzC11
   cSZ63Bb596XmbtxIGGyjaZ+oxqSWkCSG59ErVQBqP16tDzy+V6aJZEy5a
   a6Lh+kpIIBZXhxDhYNL2zCoBeGXznY/5Zud1M9V1/EGu5K3RQnCeDBZ38
   A==;
X-CSE-ConnectionGUID: kElsKwDuRlu40Ubz58MBiQ==
X-CSE-MsgGUID: SJwL4PuYSr24OhPgVNiVtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17349535"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17349535"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:16:43 -0700
X-CSE-ConnectionGUID: 8xyP/shrQdWpliP/hjg8vA==
X-CSE-MsgGUID: kLw++ElwSqW2H7Znv1Udxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="83744112"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 02:16:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 02:16:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 02:16:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 02:16:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 02:16:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/QS6oNhrDwpMnmxJdz3WSO6LOztYjVhvmwYMDVhbbZmGLKJK9/PAEo+Qjv6oS2xgk4rl1hJn25CRTo1eswKm8oxfw9SibpsyMueuOxgBUGL/ljlNzaqH86DVNfPYly2uSNGjhbvHGDO4FmhC5OtWowtKYsxDxX1SFUTNefJd7IQFwNo/r/Uf+SGK1DoDfAKwvKs9GCSNWq/AFPS25L6aMyisMAgtCd091kHe6raxEL1RgPA8iGAoqK1SfMUxI3qn4Wvk4uLjcP7oGv4x22pT2XYFJYK9uczX8Wxh3WaIHRN8SS2zgZHwetSAx5LQQyikp8Okru791JFJkLoUycmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqnuQ/EflvOvNQOSdIZoMbfKNBiNlsre4jXHSSoAfm8=;
 b=fOPMKJ+x0Dc2RmWYvfcaAs5gK/aGiN8hfKzG8w8hHQNpJFl5TIlP8fsCGTa2oCLsZFBIF3RodtPI6dRIqXdtGcp/Kt0FbU9ghe6LwXWircAzuDRCBprzRW0dEK17daV3kvaGsSE6uKMiwQqRZNUEuF+kaXyJkzhE6YeO54moCsOBV5dKtUhRh9Hd1eYn2Z2+4lQEi7sQQ7uBKN4GJw0OQg/DHwFbQGqXjy/8yr8K+s3YTybUy9oectDvxUmsgzBVvVNbiR53TrxJE9tLGb9c3HtqXX0Lkrh5kdL2UeWqmwPLpxbwWqNDjiPIpF6LVG23dwASnFz9Xh897zBUwX8x0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB5263.namprd11.prod.outlook.com (2603:10b6:5:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 09:16:39 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 09:16:39 +0000
Message-ID: <5cafbf6e-37ad-4792-963e-568bcc20640d@intel.com>
Date: Wed, 3 Jul 2024 11:16:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ntp: fix size argument for kcalloc
To: Chen Ni <nichen@iscas.ac.cn>
CC: <oss-drivers@corigine.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <louis.peens@corigine.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <yinjun.zhang@corigine.com>,
	<johannes.berg@intel.com>, <ryno.swart@corigine.com>,
	<ziyang.chen@corigine.com>, <linma@zju.edu.cn>,
	<niklas.soderlund@corigine.com>
References: <20240703025625.1695052-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240703025625.1695052-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::39) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ab8fe1-cf97-49e6-2177-08dc9b40d845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUpHV2FBbEt2cHRveXRhU0JWazJISHJKdCt4bEVWWVBMbDNELzBOTjYxN0E1?=
 =?utf-8?B?alRIcFpBbDMzbEd6dnd0c0M3MUVQWlFleEVqcnhkN2hYM1hVRmdIY05QSjVi?=
 =?utf-8?B?WUlBdy9pSEt4YjhYQVRpTEs3UGpWR0VGcDVOSWRkS29tZVlYS29rVGg3aEFy?=
 =?utf-8?B?ZGFkd0NmMU9ZREx5ak9WaTFRd0xaRDQ4Z3cvQlU2ME9MR3lNbklYTUlNTEhZ?=
 =?utf-8?B?TnNCeFpmZHZ6M0t4ZUNqY2gxZzVQLzFYQkRraDBCT2ZpdFFOenNvTjVjY1dG?=
 =?utf-8?B?MTlqaDFicHRBOXdiYkdwcGd1cFM2MEF0R0lLb1BQVGhWei9OSVVJSzZsMGE5?=
 =?utf-8?B?UUIwUDR2VW9aY0N4cTZEbVBycFl4ZWtZN3hiMnFyTG55N2NHZE1DRm9BYk1K?=
 =?utf-8?B?dTNiY09iMlFaa09OR1dLa0VBZks4NVpqeUJramdkeE9OOUhaajI4MEgwNnZJ?=
 =?utf-8?B?aFk3YjUrR09NaXVKSVhjeVBPQTZ4N1lRWk0xTFJZMEF3UitxUWhLdU1KSnZl?=
 =?utf-8?B?RXN3bFcyU0NiYUNnQ0RqVEk3d2I4amJ4SGRlb3FuZHk5MC95UDdqZzBlZ0tG?=
 =?utf-8?B?UmMwZ04wYTA0VWtHSlhta3hlUzE2Z2oyMHliUy8waGQwd3FwU05sRXQ3dHl6?=
 =?utf-8?B?cTRrWkJ6NE5QL0RjdDZzTDZsRG1yUzVPWGlyeW0zZFEvbjRoYzlsWURsQUtI?=
 =?utf-8?B?WCtyQmFxU2UwejlGOGwzWVExL0JTNGJDeFFpNGdZRGFJai95M2NkVlpGcXVN?=
 =?utf-8?B?SHA5aFVWRFBVRWkwR1Q2TllQb1QzUUdVamxPRFhxM0lJQUxwRnJGZnBMMVo4?=
 =?utf-8?B?a0NRcHI5MVhBU3JIa1NZTTdYL1dieTFIV1BVVkd2THZ5STB1TTN6a0o2SUVD?=
 =?utf-8?B?ZHVYdGdRc29Kb0ZhaDJDLzVRcW9YcTN2WXVYK1lnVXJPM09XOGc0K3RhbE9E?=
 =?utf-8?B?Ujc2TkNpRzk1RVgyOU5hZ3FoQ3dTUFZRMVBKa3NYYTQxUjg3Sm51RVA2bFJG?=
 =?utf-8?B?VDJsVU5pQ1o3T1lYYXpiejFaRXdYYnNzVDlxQTVMbkZkNUxWSGhLREV3aGZL?=
 =?utf-8?B?VkdZWGRrdmJhL2crZVJJMm00em9rSjcrdnVGT0V2TzkvRlRTT0xieXlBRFJJ?=
 =?utf-8?B?MDJmRlhOb3VuM2lPZmJtVUJDUTRXR1VtTkwvUk13V3R5cjFxKzkyRGltWThO?=
 =?utf-8?B?V3pZNS9qb2F4V0I4SEVGYlNYaU80amxzNFE4QzlzRFhEQk8wMjYvMkV2Yy9j?=
 =?utf-8?B?RWhKb0tjclNHUk5EdkplN01nTytyTVJYcnhoNnBqTG9qMm16dnZXL00zdjJQ?=
 =?utf-8?B?UDhERGpIQ01iM2x0ak9paDcyWjBJMHpvWm5DcnN3SmdvbjFNTzdWRFBldjJW?=
 =?utf-8?B?NitQTzhCNWV6ZWlORWNGc01HaGs4VjcyWE1CNHMzeHl4UEZwbDhhR2crdVc5?=
 =?utf-8?B?a0xRMWlyZnJpRENHbUxTeG5mZ01PMHYrZG9zWjduUU1ZU3NSREVoMHNaa2ZR?=
 =?utf-8?B?cDh3SVpPL3dzeit5WTNhRHdicndtVTJXWm1VeVFYK1BVZk92Y1ltT0RMdlBq?=
 =?utf-8?B?UWJnSEpHaUpqNEFTUVM1UjAzZlFvM0c3aExBRm5adkIzYnI4bHl5eGg3RmpK?=
 =?utf-8?B?bjRuNUMyZEVTYysyN3VrODBEVytTNGVPdjZ1K0J2YTMxc2N2R25kTmxRamQ4?=
 =?utf-8?B?TGRZSVluaW1hT2FVTjFhOGVySkx0TFFOSmdCQnNiVkVKcVhxcE1mZ3g3WnND?=
 =?utf-8?B?THh1QXdHUVdYd1lTYWNEd3dhblRwNjJvOUYvRzZ4Mmo0NG5vbnE3Y2lWR2pj?=
 =?utf-8?B?TWlOVEt4WFlBVCtSdUVDZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVNlQjN5QUJGSDhrM3BDVlk5MXAvWE1GNjA0MjdwWHBpM2EzR0o2R1gySjBp?=
 =?utf-8?B?OThid3l3VC9EL2luOHZHWXljYURSY1NvbkNnNzdNMXd1Y0gwOSszNVNMcW9J?=
 =?utf-8?B?ZUkrbXdZSHlnUVJaVFlnMVRGRGtVVVQ3am5ZNTRRTXNmUE90TERZNkRlUGVH?=
 =?utf-8?B?dk9OUUJIUEtObjNkWTJGZnBZbXdLdUNnVUlZR2orK1lISkN4WWMvNFpjRU0v?=
 =?utf-8?B?SUloVzNtdFNrZW9hMVdmbC9JbDBEUGViUk5TK2dDWWRybGw3NkhhS1dDcVZ2?=
 =?utf-8?B?S2dsOE1ZOUFocjcvOU8zbnZ3bmhYVlhiSkZSUzhyNEZWY2M1K0lJbUpOUmw2?=
 =?utf-8?B?Ym1TOUtIdjJ1UWlCcmlHRldqdUFsTXFCTmRkdy9hOUFBdk0xVGxKaVM3NFNy?=
 =?utf-8?B?MUptU2pjRnVEV01uV014aWdkbE11MERESDlBMXVTNlhPRHdKdE9rcm5jN1Br?=
 =?utf-8?B?Z1BXRDI2T0xydkRmbGVtL2h5YXF4alQyTmdNbFN4ZDdweDVGSWlKTFh3M0h2?=
 =?utf-8?B?V3E0OTNoNnh1eFBXU2dWSHpHQ1pyQlFmL2xqOGxnSmNsb1ZRUTBNQnY1dzVL?=
 =?utf-8?B?dEdKczBPc0dyU2RyZTNLVVRrbjFpK0hQZVR6dDZ1N3RNaHQrMzREU0c4bjhS?=
 =?utf-8?B?cGhpME8xY29UZW1qZ3UzVU15SEVIT3F4TXcyRWNscmRhVldHZ2JaWkMxRDcw?=
 =?utf-8?B?SXhoYUNBYm9OMWRNK2F6cFNwa21EWTF0TGIycS9OK3gyc1lYWGUrcHRIclYr?=
 =?utf-8?B?VjZnd1JXRXg5U3BpQ0hQWkdlUEdTd3dLVUlxSjVaWFVjeER3bEt6RmNWbCs5?=
 =?utf-8?B?V3diUWZ3R3c1WTJ0TjRCRlcwVzhWTW5RUzI0eHZpcHR4eUtOTzVUamNoMnRv?=
 =?utf-8?B?bThUdmp4a0ovbTBtRGJQYkpHakx3MzhVZ2NLQVcwaXNTZHYrVmk3dEluSXFr?=
 =?utf-8?B?Um9IOHVzSS9OczFGWUt5TnkvWVdLdGJpTG85cXRxTDBPTU5wQkZsWlRWYUNp?=
 =?utf-8?B?anJ2RkhVNk5kb0Nla1RmSmZCQjdzek00TUZ2MkxKMHlubFc1aG83WDVjZGJa?=
 =?utf-8?B?aTFzOHN0SVJPSGN5NG9hSzJRaHRoMlMvak5TSjIrZmJERzFKQ2E5dzk0L3l3?=
 =?utf-8?B?ZE5rWGNXcjJCU3A2U3g5K0VnL1ZMYndaQzRzSUtCTkI4am1WYUprekxaa0NV?=
 =?utf-8?B?TkxrYkN6Sjl6a3FET2NyUFp0clZ2N3FablJJYjFFaGNDL0ZJem9CYXFFak1M?=
 =?utf-8?B?RnVGVno0alZHZEVJazZQZE8xdjhqYkdUZFBMQVI3TkFJZ0NDNXpDZzJKZEpx?=
 =?utf-8?B?emVmS1lhRVpyMnFhU2ZWcU9ESzJqSUZxVm5NQzhNc3QveVhuWmp5MmVYYzht?=
 =?utf-8?B?T1dOeUl3bk5wWkVKREhLbzVKazdYdWE5TEF5U2xoeGxta1dzc2t1N2VtRENW?=
 =?utf-8?B?VUJTWFRMMloyVmNzU0trcWpKNjdHRXpmcWU1a1crYmdxc2VYdDl3a1ZrOXdU?=
 =?utf-8?B?Vkp1Y3lxTnZLSTVlRHlBUUZsMUdlVnZGVnh1OWtZRTk4bVRPTElpZXRHM2V6?=
 =?utf-8?B?amV0eGlnbit4aFVGRXR2ZHNtZVpPbnFaanIxc3BMZ3VWQXhCc2VlY3Vlc1Bh?=
 =?utf-8?B?c0VoVXZpcHFtQUJ1TllGL0VWd0lLSEdZcDFOUWdPMzVqRytDVGcyUHROaGxw?=
 =?utf-8?B?YmNuNlZ0dkdjS1I0VHh6THpmYVd4U2VYN09OczBCZjMrV3hiNkpHSHp2eWZW?=
 =?utf-8?B?WFlEUXFSd3FTTGpWZ2hvVVRoZjlyeXlESmZUTDkvWVNrTkxCZzUxR0RiZHRa?=
 =?utf-8?B?WTlaMlZjSmhZTHBlL0hJdW9obE5TVVhTRFJRYWJvdisvWUtVSFBZWGs2UEdW?=
 =?utf-8?B?OEl3YWRUMFpWK0VtVkg4TDdNTDRrb2k0dEQ3aXdsY1dBTHFRaWMxcWlDSEhx?=
 =?utf-8?B?SHdYenIzTXlMcFlvUWFBcWZaeWNyRlRZZVRzWUZERzlhcm1DQ243Qkl2ektt?=
 =?utf-8?B?ODJIVDlJc294TjNIcVl0R05GSnJ3bG9objQwWFNnSTR2UHk0c3F3cU1ZYWdE?=
 =?utf-8?B?TUY3eU5VeXFFY2w0UmgwMUxGSnpmY0w2RjVvekFOZ0JTSW12bVpKSzAxUURa?=
 =?utf-8?B?eURuTnBPTVAzeXNDbnZ0RUFGS3dYdVpsbVFmNjJ2SmJjanJoRFk2eVJFRWpa?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ab8fe1-cf97-49e6-2177-08dc9b40d845
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 09:16:39.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsk9+VXuyr0AvtAlg0/DOK4yLBcFOgoe8xRC5m1eLXI6vt0blxokF3gGKlcyPeYk0DNRb5izGUGWAbSTx+GZpApqOz8PBndbmIdMo3GwkKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5263
X-OriginatorOrg: intel.com

On 7/3/24 04:56, Chen Ni wrote:
> The size argument to kcalloc should be the size of desired structure,

xsk_pools is a double pointer, so not "desired structure" but rather you
should talk about an element size.

> not the pointer to it.
> 
> Fixes: 6402528b7a0b ("nfp: xsk: add AF_XDP zero-copy Rx and Tx support")

even if the the behavior is not changed, the fix should be targeted to
net tree

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> index 182ba0a8b095..768f22cd3d02 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> @@ -2539,7 +2539,7 @@ nfp_net_alloc(struct pci_dev *pdev, const struct nfp_dev_info *dev_info,
>   				  nn->dp.num_r_vecs, num_online_cpus());
>   	nn->max_r_vecs = nn->dp.num_r_vecs;
>   
> -	nn->dp.xsk_pools = kcalloc(nn->max_r_vecs, sizeof(nn->dp.xsk_pools),
> +	nn->dp.xsk_pools = kcalloc(nn->max_r_vecs, sizeof(*nn->dp.xsk_pools),
>   				   GFP_KERNEL);
>   	if (!nn->dp.xsk_pools) {
>   		err = -ENOMEM;

code change is correct, even if the size is the same
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

