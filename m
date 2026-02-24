Return-Path: <netdev+bounces-260667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NWEBzYrnmn5TgQAu9opvQ
	(envelope-from <netdev+bounces-260667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:50:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DB518DAD8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BE1E300D14F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB2E33BBC5;
	Tue, 24 Feb 2026 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jy3be8ui"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4998304BB4;
	Tue, 24 Feb 2026 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973426; cv=fail; b=Ex535Wq70y/gknnykMWkWFq00ofsoxjBRH+1Cx7ZnOfHSQWppzXJasqOZEnlVq04UkiF6oQO270giu+vPXI94SL+KM3WVPEr+L9zISHav7rfQosJgOu41tb431++6F5J1oH6ArpQGu5961AO7/+P5zD/ysbhug8xzTBU6wqckEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973426; c=relaxed/simple;
	bh=mswoF7hmuQRwCJ9UQx589Vp/s97K1jEpnicm3/RUgpk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=utENDxTW9ZUqf5akAfZqB6B3JvFrYD4TnG6lZ0xn3I642lIxzHjg20T5eCd6mGj8NRze2ZRe2osWHVvzcK4cbmeYkX7aXXNzeux52F9ub1dv/h9Ausnbh+g39ExqHyEcg8k35NYkL2TBc09E6enRNpuc50ozSF0Vd1AZ6ZCUyuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jy3be8ui; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771973425; x=1803509425;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mswoF7hmuQRwCJ9UQx589Vp/s97K1jEpnicm3/RUgpk=;
  b=Jy3be8uizmnH/QxoA4Rn8hSIM0rJHddC/CLSg9DkUjPCqNPBCds/9M/C
   LwKk4F+zftw1aHO4apZEuHx3ud9XPNUcKrv4yzFWzEcpd3FOp85nwIiFh
   5viFPNRiHIvDpobqfuRHFpncPpsh7ePpmzONUFGL49a0EfPFtQAS1kndk
   Gs/QeCO6jc1vIGF4kE3nEusOAjxBqUzYnXq067J4t2PbgYlGqWTfGLQfM
   NtfHC3pUIgSkLwinT9ox415mCeJCuS2ZuwVd5YmvFA3GzrPj/NwtyFqDL
   lmbxpI2LxWsB7AtRgrPlsvokWnWiDvebV1254qBrqKnGBdO+NoNcw03Yn
   A==;
X-CSE-ConnectionGUID: e87LvBARQ4+jQaVT0ScF9w==
X-CSE-MsgGUID: pb72mCdjTLSpeUI+eRBqKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72907036"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="72907036"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 14:50:19 -0800
X-CSE-ConnectionGUID: 1uDWLWeARBiRzALJmyVsUg==
X-CSE-MsgGUID: v57UKe4eRmSlA3d5GBs64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="214229908"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 14:50:19 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 14:50:18 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 14:50:18 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 14:50:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ya70SsgoDr7wiDHthUMRus+p1ejdAT5FFmX+75z15PjBLbvgQXHiMHzxL5v7KHFsvHPmTeQTot9XVHfe51qo0e2MhJROAIefML1xsuDvn7vCwLR7kP8DzTYkt7vw18/byvLLrpmsW1exc8w3we5CYEaqtq+qxZdISTIZm1myW3nEZ4Ku1X80QhdzEPfsfjLDZ0lqQBhrolhXbqojrOfTVUjc/oOGjQ0sJ5z0lD3gTD8I+ddBNcg9hJMyiR7ciz06mxEIU6+20vopE1Wu45VTZwYVUIbVbjjMlew7QnIaU+5uX3Ubs6BkbR9ZUt6zAE28dBntOONXbZO9ZTz/YfHbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In3mUN0yLCmx01uU86ViwX23H6zjvx2Oig+p8pYQmvM=;
 b=wiTBkf8olKimld+lI9hK1s6KJ7CHVEJ9xjC3w0f0SE1x+Naq9J4WO7Q2DAydY4MROXYJ6FVyowUk4OOsZAmQ85RlsjLQZEB6JuGNMFXje/LpZBDS7pf9QxcMvcRBr5BwR4u7tCgpNcbv1oxJgu2QCWdWwBLKN6oeCNFj+zBZEoal941vtFx0y4CsCszF4kFXl7ZtMJLI/UyZMFII/TZwbWSZ34zI1+PteqAq1ShzKOIi4aeVyC3U6kvvNXdrKRsXqkdr0+zj+1w8dF39IDtQEZts7kmCUKRNQLrzyvE+62Skm420o/4TMjeGaGsIzxm+2Ko58LAoEcby4QMSQRzswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DS7PR11MB7808.namprd11.prod.outlook.com (2603:10b6:8:ee::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 22:50:16 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 22:50:16 +0000
Message-ID: <32680f88-dcb5-487a-b001-93c26edc80dc@intel.com>
Date: Tue, 24 Feb 2026 14:50:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ice: use bitmap_weighted_xor() in
 ice_find_free_recp_res_idx()
To: Yury Norov <ynorov@nvidia.com>, David Laight
	<david.laight.linux@gmail.com>
CC: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton
	<akpm@linux-foundation.org>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251223162303.434659-1-yury.norov@gmail.com>
 <20251223162303.434659-3-yury.norov@gmail.com>
 <20251223190846.76ff4dc0@pumpkin> <aZtD8klexMFal8GI@yury>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <aZtD8klexMFal8GI@yury>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DS7PR11MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: a5263eb6-4d5a-4004-d7fb-08de73f713ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk5ZUlYvUGlVbnZqM2RYVFl0WklxTUFrTEZvK3cvVEg2ZHhWcnRhNHdYYWhW?=
 =?utf-8?B?aXlOeFp5Q3JYU2w1Rkp0RXFZOFZjb0ZDRHVOMUlQYm9KeTJnem96UmJ3aS9H?=
 =?utf-8?B?anJRenQ1VURGNFBrNjcyN0hwVE45S3o1eWM3bExSdm82UHNyMmNHakZTcGpY?=
 =?utf-8?B?NGRBd1A5ei9BSGFHK1NWRml5MkFzYXM0Mko1NjlWNlpUN1ZPUUw2UEVXZ0xn?=
 =?utf-8?B?a2t1OExyOW82czNtcVdpcEFHdEJ2a1FEdksyQUR3eVZpSHU3M3V4dUZBcitp?=
 =?utf-8?B?NnBWYW5OWHYyZUFyMWZ5d0pjamU5Qkx6dG9ZYWJpZnJQQzR3K3pvQTc0UTNF?=
 =?utf-8?B?anZJcmM2SVdqcmRtMW5FWDhhSWlQOVVBS3AvKzZwK0hCbUZFWWpaTVlXZXl6?=
 =?utf-8?B?Wi92TkxlRllJU0VQNU92UWtuYVV4bWY5Q29uaE9iN1kwTktYdnhjMEp3a1k5?=
 =?utf-8?B?bEMrenFObVdjTVNjVEI4TEJFZzhXREJCbTd4dUZnUnpEeDRGNmo3cjBCZXAx?=
 =?utf-8?B?RXI1enZVdG5PMGw1dzllczNoN0lJamFia0pMTzJKNjVmY1RrdVB2RUhBb0xy?=
 =?utf-8?B?Yi9pZENkVFFIUE9nKzhyUXF6bXVoNGNqRktLVCswbGtFcHVOMlhYNU5kb0VK?=
 =?utf-8?B?U3N5VnYxNUlnZ09hRGxWYWVLNEZIWGNjbVFFVHpYejJkNktmbmJJUFVqaXJt?=
 =?utf-8?B?TkdJTE9MUUcvcDZjU0RhVkk5bzIxRCtGZ2h0aDhjREpyZ0ROL3FHMEJYRXJZ?=
 =?utf-8?B?bXJkczJxd1NSSFYxL1JTcWJMZnpaZnlNcEM5bEZGelNVT2x6ME1neTVhbDBm?=
 =?utf-8?B?N29CbUQ2MElXWGlnaEZXQ3JWSTlrekZwcEFnYzZCWTlZVkVZMXRKT1UvaE1L?=
 =?utf-8?B?dkdUTmMyaGNaVlUyU2JlWXY1cmEza0hvMXRvSjFMeDM0OUJhOVQveTNWZWpY?=
 =?utf-8?B?MStEMS81MHJVOWd6cXg3MVlHeHBVdGM4REljQ3Bqd3NRbGl1R3dnMFBJRmt5?=
 =?utf-8?B?QnQyL244bzNucWQxU3dvMXBCRGdsOERxUEdFeUoyeTRtdmdpdGRVRjJKL3Iy?=
 =?utf-8?B?aTJlSENTUzNSRmFqNUhnQ3BmQy92ZThPa2E3dkhUZHprRHZxRlFWckw1Rksz?=
 =?utf-8?B?NWdidVJ2b1hLVzJDTG8zSjYzUnFlK2JxY0pUankxTXo2eU9lRWl0aUtGUkV5?=
 =?utf-8?B?RGVrOW1WbUlMTldxVEUxalVJb0F5YW9oYUtxRXVudC9mOTRLWldKNGdXbjZE?=
 =?utf-8?B?a0pIQjJjeGN0aEphQXBzckpweGxxVXFHYTQwMmZsQURtYUh0djl3bGNHZGJJ?=
 =?utf-8?B?ZS9PaDI4UE1ma1cxd0tkSGpUckVzVFRMcnJVL0pxcEphTGc0U3JjRmhJRFB1?=
 =?utf-8?B?RnR4YVVxSllUNE1GZTRidno5U3ZiaHNGTFVZVEhVbkRYWStEVHJ5MzhvaWdL?=
 =?utf-8?B?RzBBbHVJT1R6eCtWZ0t1Ti9JNEpmMTQ4SFY1SjhSb3V5TG81dEJ1aXhvc3hB?=
 =?utf-8?B?Um9CQmthYTF4NkFleng4UmJmWlh2aEZ2UnE2RnJNUkJCK0h4c1AyVnp4dE5h?=
 =?utf-8?B?MzRHUmU2OWtWN1dYQ042OUR0d3I5UVd0cDRhVjFsLzRkUTlxRFMzZ0oyV285?=
 =?utf-8?B?bG1XWXhmd1BPNFp1dk5tMDN4MlIreDlmQStRbUE4S2lLWmpxQW0vaHk2MzBT?=
 =?utf-8?B?UWZnbmk4UTZlT1EyTG91NWtmbUR3WVBmQ0Zvb0psMDh4U1RGMzFZM1UrcndG?=
 =?utf-8?B?Z3NTSjBENExncEVSRW9lWlIrM0NzVFFZcTgvZlU2ZUtQR3ZjaCtvem5OZHVU?=
 =?utf-8?B?TVQvT09pWXZCc0MvYytDSW42L2kvNlFrSkMxSkNUeVArTXJkcGpvYkt0Z0Vl?=
 =?utf-8?B?N2k1ZG13aGVSS0dSeXVrUllnZzk4VDFDM1pBbDJMd0dqajEvc3ZBaWZFRmtv?=
 =?utf-8?B?ZGVXRDNhUnkzRFYyK0JWZk5WQkRBNVFJaUJDQm13TWYxbFBEOXFydytHS1ll?=
 =?utf-8?B?OWdsdElDM01tRmIvQ0NnVk42QzJ5VVVPVHBMTWI1emxtaENJVlRKcHVoNHR2?=
 =?utf-8?B?ekxVc2JNVUF2bHFESHE2SGtUcmd2bGJMSitLVVVRSGpIVjE3OGN0NjMvdURs?=
 =?utf-8?Q?DaoE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDg1YVUyTlgwMmlxY3ZWOTBnS3J1b2U5RXBsSWlyRGFIZGFYMjF5VHpYRXlB?=
 =?utf-8?B?MVJRUFJqWmRzckowNjI2QlZxZkxLWDZMa3hxRkF3L1BPaXIycTEyNVZDUkdw?=
 =?utf-8?B?ZUozUU0rdGpxWDBJbm9vM2haSkp5dkNyTWM5SUtlL1BMMWoyeWErR1dnbjVJ?=
 =?utf-8?B?TGcveEZBTUtFcmZOeEtCaTNXSWdEUWc1M255SmRaUWlaMTU0b1ZTd1gwaWFx?=
 =?utf-8?B?cHpHS2NKY21aRGdFcWloQ2x2M0RSNjVpTDNRK2tiWWNZZTBpM1FMWW5BQjFs?=
 =?utf-8?B?WmhOaDlFeDBzN0RWcVJWQjNWU000L2grb2xMUHFxaDZVaUxxQUhBYnJoR1Jn?=
 =?utf-8?B?Zy8wYjNhK0VZcWwzckpRaTdnU3NZV2RhaVBnLzJSTzgzMlZCWktjb1lwL0ts?=
 =?utf-8?B?Mkp1YlJCczdLSm5TbW16SDBaKzAySlRIOTQxcmloZVp2SEtIUGJOaDdLaTlv?=
 =?utf-8?B?R0lCUEhpV0pmWi94RCtRSCt2N1ArU0IxZlh0UGx5WHlTWlBTTW1jVnMxTXdB?=
 =?utf-8?B?NUl3Q0tqMjA0cnM0aUhVanBJb3FTMjJFTFdCZXMyaWdHMUMzVy9WZTBkejlM?=
 =?utf-8?B?bGtqLzNOb2ZJRGtIRjQ5eGZqVzVtb08vWG5wYTdSZkJhT3ZJcE1sZFk5eVRY?=
 =?utf-8?B?OWVkT2w3Unl3SFp6VXNaRTRaR2dISjduZ2ZSUG5CK093a0xIWjQ0WkY2UjBY?=
 =?utf-8?B?N1prbGhFTmxMcnJ2NWlsZHRmeGN6b083R0J6cXF0VHowWGtSWThQWGJqS2F6?=
 =?utf-8?B?TXlKd0JDMFBKbkM3WGFJaDlCaDBCelBpTkdrcHVPZUt6cVNVbGk0aHdvakhV?=
 =?utf-8?B?blBFNWNTNkhleU1Ld0lTblMxMUlyakxHcmplRTM5RGtOQmNKSlU5c1RVZ3Vh?=
 =?utf-8?B?ZTd4N1BsSjdNMFJhZStFUVZ1U3BQVG5RbEFXazB6eWh3TzU0UEU2cytWSlFB?=
 =?utf-8?B?cEV5ZnMza0NpdTlURWJRYVhlQTM1UlU3SXZzUzFlQzM2K2E0clFuQlZob2E4?=
 =?utf-8?B?cjNJMDBSbkxueHYyR0tMTmRPdWxKSzArRWFnUnAyTUVFa3pUVkdmVlRMcGJi?=
 =?utf-8?B?RUVwdzVFL2Q0VGtLWTViY2laREp5U1hXSzQvdEtEMTJwRGVmZEZKTDBkT0Fp?=
 =?utf-8?B?M0V1andYU1JJVlk2MStkOTcxYVBNTGRMTXNaRWFwbUJ2TGF3QkdqUkxNaWpD?=
 =?utf-8?B?T3FZKzRqb2ZEQVZEWlhhS3B1eXhGSmlCRmFmeFU4dXpYREFkZzRKbDBpdjVn?=
 =?utf-8?B?a3NqcDBuaVgwd0l6a3BRTXNUNEh4VHJRemtoOGZJSVFqS2QzcEs2amRBN1FO?=
 =?utf-8?B?NVlXUDBpSUNhSG1jZGdwcjlZVVdHY2RNaUp2ZEYrNGI5T2dDWW8xWUNxZ1cx?=
 =?utf-8?B?YzJ6MEV3RFFwcGZXK2pXVmdkcVZOcHdZdjhQand2amx0b3g2Ym8zN2JRRE4z?=
 =?utf-8?B?TGlZNlBFNXdRUkZvZTFSWUFUNVpZbFB1U3N0a3JjMWRYT0owcnpMcmdBTWp4?=
 =?utf-8?B?bXJJUEsvQUU1enp2NG00L3RIaXg3eFRqZnJRTzQ5Z1VQQk9TU3ZYU3h3RGNh?=
 =?utf-8?B?YndqcUVWYXpVVTRBN1BjT2VuVnFqcUkzQVVsRDJmUVF1NS9LclVoMExqUHdT?=
 =?utf-8?B?MDErT1VjRTZtQlpMWmE1c2tXUTRPUXo0NTJtVUk1cEN0NTVnWmExaUZXZ002?=
 =?utf-8?B?T2ZQTkQxQmlrd0NJdjRvTk9zeVNwdFV5aFZOTW5SQW5Qbmg5UlNaN09tbzdT?=
 =?utf-8?B?c0k4Sm1NSllycXRjV1lMOVlkN0NpYkRiVjg5N0MvRWgzMGdNbmlpVnl5eFVt?=
 =?utf-8?B?aHVDN1h2MmlyaUsxbm02d0M0MjEvSGlZVUVUb1BOaFVNMXdlS2h1U0ZXUVVz?=
 =?utf-8?B?VHhKVHgyN2JlckFDaUw0cHpIUTBUcXVNemNZNXRtS2pVdFZRN0R1eHBrSkVq?=
 =?utf-8?B?RFRZZWtqb1I2NlE0d2poUzZGcERGRU5wWWVSWWdkRmZENXNkeEZGWnZxOWpa?=
 =?utf-8?B?eEpuRE1KYTBubUJYTDQyRVFneEJEeWUvejR3alVxL0hkYnYrTytieTFvLzNI?=
 =?utf-8?B?eDUrZ2hJSFE3V25qeG1XQmo1ZTFBMkhTTmFmaTFQeUh2VGlpeXBkWHpkeER5?=
 =?utf-8?B?MEluWWJQeHMyVXZYLzFkbGE3anV5NlhCVUViQzFCem5NUE1FeHVMc2t0NHN0?=
 =?utf-8?B?QVE0Y05kMlFGc3E1VTRZYTBpd3VRZ1VaUDZtaUl0MVY2MVZsTkRtdDJzL1BK?=
 =?utf-8?B?YjZsY0NrWE9oYmFkbVl0MU04d2J0WkFqTEN5R3E1V3JCSC9VTHRvVnEwdW9V?=
 =?utf-8?B?VjVPYndMLzBvMGd5L0JrY0k2NHZKVVg3VUhmWm5Demp2WHpQeVFidmx5YVZW?=
 =?utf-8?Q?mdsQ4J/u4MR1kQBs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5263eb6-4d5a-4004-d7fb-08de73f713ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 22:50:16.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrdADLH19+IDQw66DynJpJhG3oHAs+8cz68hG7l/PVE6wZPvuNzZ8quGh93QOy0nsjJTjjLMZSjdN25u4FsDt3Th1/T8Wp5DPC+0I6a5aS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7808
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260667-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rasmusvillemoes.dk,linux-foundation.org,lists.osuosl.org,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 81DB518DAD8
X-Rspamd-Action: no action



On 2/22/2026 9:59 AM, Yury Norov wrote:
> On Tue, Dec 23, 2025 at 07:08:46PM +0000, David Laight wrote:
>> On Tue, 23 Dec 2025 11:23:01 -0500
>> "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
>>
>>> Use the right helper and save one bitmaps traverse.
>>
>> It makes no difference here.
> 
> No it makes.
> 
>> The bitmap has 48 entries and is just a single 'long' on 64bit.
>> It is also already in a very slow path that has iterated all the
>> 'set' bit of two bitmaps.
>>
>> The code is also pretty convoluted and confusing already.
>> One of the other bitmaps has 64 entries, recoding using u64 would
>> make it a bit more readable.
>>
>> Doing the 'weight' here is also just optimising for failure.
> 
> We've introduced bitmap_weighted_or() recently, and now we need to add
> siblings to the new sub-class. Regardless of performance impact in this
> case, having a dedicated helper for a typical operations saves a lot in
> debugging. This is proven by decades of code development.

I agree, performance issues aside, I could see the utility in having a 
combined helper. It makes is a little cleaner and removes a point for 
introducing problems. Assuming there are no objections, could you resend 
the series? It'll be easier than digging back to get these.

Thanks,
Tony

>> Oh, and using u8 and u16 for function parameters, return values and
>> maths requires extra instructions and is usually a bad idea.
> 
> Changing function signatures is not the patch purpose. Feel free to
> submit a separate patch.
> 
>> 	Dvaid
>>
>>>
>>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>>> ---
>>>   drivers/net/ethernet/intel/ice/ice_switch.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
>>> index 84848f0123e7..903417477929 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
>>> @@ -4984,10 +4984,8 @@ ice_find_free_recp_res_idx(struct ice_hw *hw, const unsigned long *profiles,
>>>   			  hw->switch_info->recp_list[bit].res_idxs,
>>>   			  ICE_MAX_FV_WORDS);
>>>   
>>> -	bitmap_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
>>> -
>>>   	/* return number of free indexes */
>>> -	return (u16)bitmap_weight(free_idx, ICE_MAX_FV_WORDS);
>>> +	return (u16)bitmap_weighted_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
>>>   }
>>>   
>>>   /**


