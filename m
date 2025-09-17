Return-Path: <netdev+bounces-224030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D272B7F271
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A80A5201C9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A42D18FDBD;
	Wed, 17 Sep 2025 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqf4wrQZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5E33C75F;
	Wed, 17 Sep 2025 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114646; cv=fail; b=Io8wV0ICwmUBS9cHmIQ/A98veCUb+CEJSM7LCupP5myd+7GpgbNNoCdTPogjPzyF6np7hF3J828c5Sr0A7OCP/vv5E/07X3BZRjlygfn3E7UpLc3VOSSYxSnj8gDWXNEDYrMm74lrQO8Qle5W444CJvQeHr+Ch0MFwC1NzeTmiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114646; c=relaxed/simple;
	bh=Ask4qQsDcC4AA9+ryb9eX/3wdMSrtMatOyTXEhq36mQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t2zS9Ct+9j76ykIOVl87dOTgkFCdrmFvIg4X+q9vsWYU1CCPbx7JP55usQAHm0q5/BwO562Z7rJyXGJ46oVKUjWhcKQNFUr00GtfNeHyNJRwowk6258VOhw8MJjNrtrUAIA+IE9IZGHkmftwakY7GtaRSuso61gYKRQW6UxHgR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqf4wrQZ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758114645; x=1789650645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ask4qQsDcC4AA9+ryb9eX/3wdMSrtMatOyTXEhq36mQ=;
  b=gqf4wrQZZHxtrU88H8nRvUzlXKxtm5wgavuvKrUXZGBFnNyyxgHYJ6IP
   g5eOxrkq0Zglc3yEzDzSh5Z95AkJkmRvbsQ6Fyn/2dqED75c0QWPvqfwu
   nQCLQZCxx2x97Zrbse8JrDvfXjv0MrVGUd0Wv9lR1Lt7XuC1CW8eHhCGU
   dUWF9yI70yhWbybmhTV1f7gqTc9l0CkJ5Q1AhpexCLgZ9p9ZxgxxSATV4
   s08Mgzj8nrensOgh7i+aEvd0ytAonZ8aRGRUUHwaVxc8ysVw66DuTmFN7
   Nh5mSi7YbzNYt9RGIm/zN48tICHpWRAH+scjNZmsRNlbSQzedbsBFa8FO
   w==;
X-CSE-ConnectionGUID: JiirprjPTDK6NHnUX9xsIw==
X-CSE-MsgGUID: UR8AV/ELTceLXmSoL54OaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="59640094"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="59640094"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 06:10:42 -0700
X-CSE-ConnectionGUID: kHpRtGXMSsWdWGPncay8IA==
X-CSE-MsgGUID: KpsxF2cAT9aHTj4o1XUhug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="180375124"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 06:10:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 06:10:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 06:10:40 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 06:10:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isobBqJotHesilbOFkTc42Ox3UHH6MjpeWDQv3FIKtjlnxBKlQmJnKtmlQ43pZtAk9I2M2Uqna14bwatyFtvmxvYX3t2N020kxSsOhGIb8gIMCSIQr2JgbOfmNdpYuNZJ1PExlbFM3JvLkLmENl8bJtseNTD964gxHVcPs0Pb+wq754jgU7cmzrWgO4MvlBmUhLRjDqKkCaEw8ci1ikqFzQjwmoq86LI942rznvLQX1oGtb6oPv22fTd6xrxgxZQSmZg5jXt7R3X165aipUk+u46hjnbk09HGpk0tBlcZIKBR9jRNBYo4zxqU7bo4fq611tSWv1/hRlUegAxh0Zwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ask4qQsDcC4AA9+ryb9eX/3wdMSrtMatOyTXEhq36mQ=;
 b=Aexhi/8yZoRpky57b9M8ZueKA6LD2ekPXbcfjjzAdvmfUyq9mYu54znvckBeIYlV+7RDEVJfZbFMtnksUj+8a3kez7BXBI+oVTcmEXMdbqtDM/0x2//5etVKNx2rEUbMYyDXnCbDu7Eq/C5rziG7iA+Xa+yyQGXf6fjzzqXjZD4HqiqOendquzk6thnz+8ATkr8peh7bWvDFtfkU6N6PNh+a3AeuNMQjWAq2mUJ0bckY0o4PWvHeguMvh99gvCptDkRL6NKLGMeRR2Jg7jx2+0VFBJreIOWBPCTWjuXgiHDi5x3GtqtdVFUAboi/wtzYMD6z2AzmIPpOecBfdi4ItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by MN0PR11MB6253.namprd11.prod.outlook.com (2603:10b6:208:3c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 13:10:35 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 13:10:34 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] dpll: zl3073x: Allow to use custom phase
 measure averaging factor
Thread-Topic: [PATCH net-next v2] dpll: zl3073x: Allow to use custom phase
 measure averaging factor
Thread-Index: AQHcIuz7gBZiqN/7qUGqrdM7g65j8bSU8B6AgAJJoICAABqyAIAAAN0w
Date: Wed, 17 Sep 2025 13:10:34 +0000
Message-ID: <SJ2PR11MB845273963D6C04DCDB222FF19B17A@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250911072302.527024-1-ivecera@redhat.com>
 <20250915164641.0131f7ed@kernel.org>
 <SA1PR11MB844643902755174B7D7E9B3F9B17A@SA1PR11MB8446.namprd11.prod.outlook.com>
 <c60779d6-938d-4adc-a264-2d78fb3c5947@redhat.com>
In-Reply-To: <c60779d6-938d-4adc-a264-2d78fb3c5947@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|MN0PR11MB6253:EE_
x-ms-office365-filtering-correlation-id: 707b0d6a-5d57-4fb4-1d95-08ddf5eb9687
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SU5GNmtLcU00cHpYS0lxOEZ6c0tBR002RjQrMHJHSHNsNDFaNTUrOTV1enRp?=
 =?utf-8?B?YXZBRmJlQS9hbGc0eEZNY2dXaytRd3hYZTZrRTFNK0ZISjViMUxNVUpNTE0x?=
 =?utf-8?B?ZlRNL1RvUXJZdGltaWZmcytXOTZrUUh3OEdIZXpPRTFFOElrUEJTd2VzdG1a?=
 =?utf-8?B?d2tjNUFuZThpVDdRL3ZEVzFQaDAvdlRla3hGV3N4dmVQMTRvYWR5bG0vNWpk?=
 =?utf-8?B?VXN2bnZEclpCeFJhd29SRGNKN0FyQURpR0NQRDJUbGoyRG81QlRHV2FFeVBu?=
 =?utf-8?B?UnVYdE96VFJGQ1pkKzBLelB5N0cvUFdjZzVaUnY3YnVnZitKcHB3V0dENlFE?=
 =?utf-8?B?T2hqSTJvQlNyUGQvOFExekN2VnFYNHBlSEM5RHFPd1lHV2k1SEdGL3ZnMnJ0?=
 =?utf-8?B?R3o4YWswRzNqcUJMd21XSWJoeTI4N3YzNHhYYys4QkljWE1xK0pvZUFtU09r?=
 =?utf-8?B?ZW1Oa1pvT2Vyc1NwaVNWSURaZTVkeDA0bEtJb0JwK3BWVVFqUTVZK0ZocnFM?=
 =?utf-8?B?SC9OY2JHeDJoY0l3N1orOW9hOC9xNmlSV1VzRHhUZEZPVGU3b3BBNXF6TTFa?=
 =?utf-8?B?dGx4YkNxVkFKNTBYUisvOXJleHBWaDlPUHJXcXdLNnNwL0FSclE3dXJWVGRD?=
 =?utf-8?B?Sm9OaEpMUEFJOHNQTnhPdVROMWV1b0liZ1piSFl5dTZJMi9Bc0JqT0hCNGhE?=
 =?utf-8?B?M1poNTlJRHR0eXFCVGdONWtFNjNncVMxSVEza2lQRERwam44anR6NURrdjlC?=
 =?utf-8?B?OWsrMnJwQ3RNQndYVjVqOG93T2U5NVBGRlJVbmppZSs2VnQza1NyUFJ4ckdy?=
 =?utf-8?B?Lys2dVdqNGZqK0lvU0ZLY1hlUUdXN3U3U2JHbUh0dWkvMDRlRFcySE5aSEd4?=
 =?utf-8?B?VXdVckVVaHFNYkZTQ1R5cy9XVzAxNkZVUVRiK2lGSmxXYVFKOXhySHlLVjNu?=
 =?utf-8?B?NXVCeUk2TUk4T2NDN3Q2ekpZZUowNXBEYjk5ODczRzA2UnUybVFpckdBU05z?=
 =?utf-8?B?THlHZEdWS2QzTGwxeEQ5ejQ3OGRjQzhJa01FSXJNNzFNd2t1MUdjS01RZkNu?=
 =?utf-8?B?VkN0M3AxallHbU1jbkNpYndlT3dVTG5ndGN5MVNtZ2dtWnBZeFh4L09mZ0ZF?=
 =?utf-8?B?TnowM2R2QlpRMTYweklpT292c1lhNmZtbUFhMlpLZEdzb0p6M1pZcnBFcnZ5?=
 =?utf-8?B?N2NnWDVHcGFydDAvQXVDdEd1YjZEcnllOXNHOHNGNU5oQ2k3MHZJTCtrK3lV?=
 =?utf-8?B?cStJS3BRd0JuR3hodXlZQ3Z4dEcrZXpraURmbm8raS93SWEvRlpwYUprT0lV?=
 =?utf-8?B?aTAyMjJtMmt6OURKcStlSVFuQm8zcGFUbTlIT1o1cjJ5ZTRKR3NUaVZLL3pT?=
 =?utf-8?B?ZnJmNXJQRUFZZjJhbkJZbTBRd3R3T0JodGtuRjlQMi9iMzZWbXR4N0phaVQw?=
 =?utf-8?B?VnVydFpiazFDcDl5REZNeC9kMnBSakM0c0J3eTRRcVVwS0dGRS9BMGl6MmlH?=
 =?utf-8?B?VW9Xa3cyNWgzUzV0R1V2R0pKdm1HVjlzYjU5bGl5dE1FYnRyU1E5MHR0U0JV?=
 =?utf-8?B?alM4NzVGNXUvLzV1d05pKzdENHFqM3JpRCsxNlJ4UVRKZ0JXb2FJYUszbWFC?=
 =?utf-8?B?WURBdnJiQVZIRjE3dGtxcDdaQmx4TUIwTDNtNFdpUU1GTVdZTnBDa21kYSt1?=
 =?utf-8?B?eWJaQU9rS1N0THZKWmdGOVREVlMxblFybVBndmh4Y0JVYzg2S1g3TUw4ajQy?=
 =?utf-8?B?YzcwQnZ1L1NBSmI1QkdrYTRNVDJRb1NmaG1LNTh3RFZMeWl4cHhhQk5ZTW5V?=
 =?utf-8?B?bS9qNlBTRUEveEtIQm1QQVJRc1BxVEtJaEx5aGhhd3J2VFNwYnduSHpBM3pE?=
 =?utf-8?B?RzUzVWRCc1BjdGt1UWhMdDM5Z2VFTWlSWUova0lNVm1oZjRuNnZQS3BiOTdh?=
 =?utf-8?B?OHd1c2NPZm5BMm9La0Y3d25vOTI4L3QybFF2aVF0cTZjSnVDdTdxVWh0NkNU?=
 =?utf-8?B?U3pMMStjMnNnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3hoUXpPMDNkcGtrOGRVUXNCbHVSV3RDY2Nxc08rVkl5NjlXeEdqWndkdVpF?=
 =?utf-8?B?bVlBdENUVmdBT28yTFJMeDJ0T1ZyczBnanFpeUJJVi9CUFVaMmxHQmJKMlhU?=
 =?utf-8?B?R2xCYXUvR2V0dUtUbW9rUllwTW5NamFWeTRXSmdRcjJTSUxEOW5yS1Uwc25P?=
 =?utf-8?B?VzZHT042YzVzc09ERkZ6VnFXL3RNOUZ1OEJUTityUkRNZXR0djB3djdBQ3Bk?=
 =?utf-8?B?R3FEejUxR1lmODRLUEVWMHRNckthMkpRWmVPWmMyOFRZdmlMZXpJK3NlMVlE?=
 =?utf-8?B?TEFnTWVNdnc4MzRRdVJZOGxyWmp6YVE1a1B3T1BwNWFBL0tlWUFzZzFMZzhq?=
 =?utf-8?B?WkkwdGpzR05VV2xTUGVJYi9oMGNLdFhrTjdoSGpuV1hJcmVyamhFcGFxSWNa?=
 =?utf-8?B?QkZBd3VqTmdrTXpWc2swSU1hbm5FcCtkeGVBZWpheTRFWUdIZzNzV2FVRmhT?=
 =?utf-8?B?QWl4b1BWTElGM0Rka0h5bWE2WWM4YTF4d1dxdkQ5VkZwbDk3YzJXN0JrZ1dh?=
 =?utf-8?B?dlFpWnQ0eTJZMVpQTTZxRy9Va1h2QVBGbWt6NVc0eGZWVjJHUkQvMWhtOWNE?=
 =?utf-8?B?ckk5aDFsKzBGWnVZZmJqQmlBV3IvVzNrU2VJQnFKRmtlN3lvMk1HN0JGMmEv?=
 =?utf-8?B?dE1qZWw3dGFkN0ZoMHBER296SldGZHBCQnRjVzVNRlBqNis1eVVGcjhieVUw?=
 =?utf-8?B?UWQ2Wk0rK2k2VVptc01CbUxLTmswemsxR2FLYXBBY2tEa29XK2dMQVZacGlG?=
 =?utf-8?B?aHhpWDFEci9XdEYwZXdqRjZubVhiZ2pUZlQxT1RQLytHNWx2RGpwMzg3dVl0?=
 =?utf-8?B?TEl5bjdIQ3ZORlM5bitrdnlyV1hSWnhmakxiTGpaOVlFN3llUmZkZFRtV1B2?=
 =?utf-8?B?RHZKSHptN0RSbWkwcU9KdFVFckxjc3lHRHNLTFk5eXcrOE1YOWMvY0NpTVlz?=
 =?utf-8?B?Q0lpMUo0TUxwc3Z0MmR1b3pBWXBuTWdYL0hOZXk4eGc5Q0J3cEY0OHZPNnlk?=
 =?utf-8?B?b0tETVFnT0JzYXNIM3pxMC9zcXU0bGQ4dC9FbTVUTVJYcjluRHBQNUc2T054?=
 =?utf-8?B?bWNvQ0ZtUVArSStqT1BzeGd1aFRlTXQzYlQ3SDcxT1Q5RGlDcU9zWkRiRmtU?=
 =?utf-8?B?OHprVnhWMnRoWEVnUHVUT0V0NWtxaU51T084L0M1M2pNR1J6dU82Q1AveVFl?=
 =?utf-8?B?Ylc4cUdyY2RKa1RhRjY0b1h6dFhRZnIrUkFWNTB6WC9SNXNsQzZsaks5alRB?=
 =?utf-8?B?clJNQXdWK1ppTDRVWmxoWnRjSXkrMElmY0tYdVc4WEFGSWp5aGFkSVlYTjJo?=
 =?utf-8?B?bW5VMlpnWW1MZHJRY2NjUEI2NWQ4eGpuMzlMSTNNaGJjbFpqcElrNDNIampq?=
 =?utf-8?B?ZmRvblZaVklyZHRsV3RqYXlpdEFZVHZMWS9WcU93RzR3QkJmN0xtb3ppcHAx?=
 =?utf-8?B?anJRMWQyU2U3d2tvS3ZBMFRDWVhMV2Z1aVBVS2pONTArdGVBRkVXbWNUeFBD?=
 =?utf-8?B?MCtsQkJXUmhSOVd0d3JaRms5YjUxdVlJRk54bGRXVmViNHZHVHRkNGZNSjRl?=
 =?utf-8?B?U1FuWnNzeEJ1VW1QTUIyN2RnL0d1SUwwQzllcHJpWWlxNXRPditCN3czbzFY?=
 =?utf-8?B?bHJESTlWSU5TQUdiaG5rdEY4bzcvSmFBbmJ5bTEyWm5nMFZjSkxQOGZRaDFp?=
 =?utf-8?B?akw1ZXd5TlZGeDkxMnE3dTRTWEp1MklGaDZ1cUJQV0o1Yk92WGc0bE5uclU2?=
 =?utf-8?B?ZkR3NCtEem93WTJuSGhxUUpMbVllOWlIWlN3cEFSejM4Q083MVVPYmVwZ01m?=
 =?utf-8?B?QkV4bndVRTh6ZDgyZnVtVnMrcHFVSGkrY2VTM3hlRFlkL3F6M3lxa1NIL1Ir?=
 =?utf-8?B?aTd0R0haRU54R2RUSU1sYWFPY2s2SlZ6by85MzMxTXM0MVZMOWxQeGRHK1JV?=
 =?utf-8?B?SnU5RFhtYzB5c2ViZ1BvcUc3ZjhCTG1RbTRJejZXc2xheElqT0FycVRwd2F3?=
 =?utf-8?B?VjU1b3BtZFNiRUZXbDdrRjZRc09Hc3pBU09pSEYrOVJ1RUZEOWVkejV3TFFq?=
 =?utf-8?B?M2F4bE1TMGkrVHVRQndyZHVML2tlWWpDV0dmdm5VcUhqalJjYlJHR2Fqckl4?=
 =?utf-8?B?a2hra3VML2NPbWhrWGVqT2k0NkxEYzZYSEFUZWxFV1RRYXp0UHJUM3pwbk5X?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8452.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707b0d6a-5d57-4fb4-1d95-08ddf5eb9687
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 13:10:34.7681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0N1sUh3SSUZG4Q3UNgGDW5TUiLIQZBZV6g7AfVawx7Kdgl3UCNpQZn3D/lhlcmB+Z0Nrr2OAr+TAToIqVOEhiqG7xLLO9qs35GTtoAA6rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6253
X-OriginatorOrg: intel.com

PkZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+DQo+U2VudDogV2VkbmVzZGF5
LCBTZXB0ZW1iZXIgMTcsIDIwMjUgMjoxOCBQTQ0KPg0KPk9uIDE3LiAwOS4gMjUgMToyNiBvZHAu
LCBLdWJhbGV3c2tpLCBBcmthZGl1c3ogd3JvdGU6DQo+Pj4gRnJvbTogSmFrdWIgS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz4NCj4+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMjUg
MTo0NyBBTQ0KPj4+DQo+Pj4gY2M6IEFya2FkaXVzeg0KPj4+DQo+Pj4gT24gVGh1LCAxMSBTZXAg
MjAyNSAwOToyMzowMSArMDIwMCBJdmFuIFZlY2VyYSB3cm90ZToNCj4+Pj4gVGhlIERQTEwgcGhh
c2UgbWVhc3VyZW1lbnQgYmxvY2sgdXNlcyBhbiBleHBvbmVudGlhbCBtb3ZpbmcgYXZlcmFnZSwN
Cj4+Pj4gY2FsY3VsYXRlZCB1c2luZyB0aGUgZm9sbG93aW5nIGVxdWF0aW9uOg0KPj4+Pg0KPj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAyXk4gLSAxICAgICAgICAgICAgICAgIDENCj4+Pj4g
Y3Vycl9hdmcgPSBwcmV2X2F2ZyAqIC0tLS0tLS0tLSArIG5ld192YWwgKiAtLS0tLQ0KPj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDJeTiAgICAgICAgICAgICAgICAgMl5ODQo+Pj4+DQo+
Pj4+IFdoZXJlIGN1cnJfYXZnIGlzIHBoYXNlIG9mZnNldCByZXBvcnRlZCBieSB0aGUgZmlybXdh
cmUgdG8gdGhlIGRyaXZlciwNCj4+Pj4gcHJldl9hdmcgaXMgcHJldmlvdXMgYXZlcmFnZWQgdmFs
dWUgYW5kIG5ld192YWwgaXMgY3VycmVudGx5IG1lYXN1cmVkDQo+Pj4+IHZhbHVlIGZvciBwYXJ0
aWN1bGFyIHJlZmVyZW5jZS4NCj4+Pj4NCj4+Pj4gTmV3IG1lYXN1cmVtZW50cyBhcmUgdGFrZW4g
YXBwcm94aW1hdGVseSA0MCBIeiBvciBhdCB0aGUgZnJlcXVlbmN5IG9mDQo+Pj4+IHRoZSByZWZl
cmVuY2UgKHdoaWNoZXZlciBpcyBsb3dlcikuDQo+Pj4+DQo+Pj4+IFRoZSBkcml2ZXIgY3VycmVu
dGx5IHVzZXMgdGhlIGF2ZXJhZ2luZyBmYWN0b3IgTj0yIHdoaWNoIHByaW9yaXRpemVzDQo+Pj4+
IGEgZmFzdCByZXNwb25zZSB0aW1lIHRvIHRyYWNrIGR5bmFtaWMgY2hhbmdlcyBpbiB0aGUgcGhh
c2UuIEJ1dCBmb3INCj4+Pj4gYXBwbGljYXRpb25zIHJlcXVpcmluZyBhIHZlcnkgc3RhYmxlIGFu
ZCBwcmVjaXNlIHJlYWRpbmcgb2YgdGhlIGF2ZXJhZ2UNCj4+Pj4gcGhhc2Ugb2Zmc2V0LCBhbmQg
d2hlcmUgcmFwaWQgY2hhbmdlcyBhcmUgbm90IGV4cGVjdGVkLCBhIGhpZ2hlciBmYWN0b3INCj4+
Pj4gd291bGQgYmUgYXBwcm9wcmlhdGUuDQo+Pj4+DQo+Pj4+IEFkZCBkZXZsaW5rIGRldmljZSBw
YXJhbWV0ZXIgcGhhc2Vfb2Zmc2V0X2F2Z19mYWN0b3IgdG8gYWxsb3cgYSB1c2VyDQo+Pj4+IHNl
dCB0dW5lIHRoZSBhdmVyYWdpbmcgZmFjdG9yIHZpYSBkZXZsaW5rIGludGVyZmFjZS4NCj4+Pg0K
Pj4+IElzIGF2ZXJhZ2luZyBwaGFzZSBvZmZzZXQgbm9ybWFsIGZvciBEUExMIGRldmljZXM/DQo+
Pj4gSWYgaXQgaXMgd2Ugc2hvdWxkIHByb2JhYmx5IGFkZCB0aGlzIHRvIHRoZSBvZmZpY2lhbCBB
UEkuDQo+Pj4gSWYgaXQgaXNuJ3Qgd2Ugc2hvdWxkIHByb2JhYmx5IGRlZmF1bHQgdG8gc21hbGxl
c3QgcG9zc2libGUgaGlzdG9yeT8NCj4+Pg0KPj4NCj4+IEFGQUlLLCBvdXIgcGhhc2Ugb2Zmc2V0
IG1lYXN1cmVtZW50IHVzZXMgc2ltaWxhciBtZWNoYW5pY3MsIGJ1dCB0aGUNCj4+YWxnb3JpdGht
DQo+PiBpcyBlbWJlZGRlZCBpbiB0aGUgRFBMTCBkZXZpY2UgRlcgYW5kIGN1cnJlbnRseSBub3Qg
dXNlciBjb250cm9sbGVkLg0KPj4gQWx0aG91Z2ggaXQgbWlnaHQgaGFwcGVuIHRoYXQgb25lIGRh
eSB3ZSB3b3VsZCBhbHNvIHByb3ZpZGUgc3VjaCBrbm9iLA0KPj4gaWYgdXNlZnVsIGZvciB1c2Vy
cywgbm8gcGxhbnMgZm9yIGl0IG5vdy4NCj4+ICBGcm9tIHRoaXMgcGVyc3BlY3RpdmUgSSB3b3Vs
ZCByYXRoZXIgc2VlIGl0IGluIGRwbGwgYXBpLCBlc3BlY2lhbGx5DQo+PiB0aGlzIHJlbGF0ZXMg
dG8gdGhlIHBoYXNlIG1lYXN1cmVtZW50IHdoaWNoIGlzIGFscmVhZHkgdGhlcmUsIHRoZSB2YWx1
ZQ0KPj4gYmVpbmcgc2hhcmVkIGJ5IG11bHRpcGxlIGRwbGwgZGV2aWNlcyBzZWVtcyBIVyByZWxh
dGVkLCBidXQgYWxzbyBzZWVtIG5vdA0KPj5hDQo+PiBwcm9ibGVtLCBhcyBsb25nIGFzIGEgY2hh
bmdlIHdvdWxkIG5vdGlmeSBlYWNoIGRldmljZSBpdCByZWxhdGVzIHdpdGguDQo+DQo+V2hhdCBp
ZiB0aGUgYXZlcmFnaW5nIGlzIGltcGxlbWVudGVkIGluIGRpZmZlcmVudCBIVyBkaWZmZXJlbnRs
eT8gQXMgSQ0KPm1lbnRpb25lZCB0aGUgTWljcm9jaGlwIEhXIHVzZXMgZXhwb25lbnRpYWwgbW92
aW5nIGF2ZXJhZ2UgYnV0DQo+YSBkaWZmZXJlbnQgSFcgY2FuIGRvIGl0IGRpZmZlcmVudGx5Lg0K
Pg0KDQpZZWFoIGdvb2QgcG9pbnQsIGluIHRoYXQgY2FzZSB3ZSB3b3VsZCBhbHNvIG5lZWQgZW51
bWVyYXRlIHRob3NlLCBhbmQgdGhlIG5ldw0KSFcgd291bGQgaGF2ZSB0byBleHRlbmQgdGhlIHVB
UEkgdG8gbGV0IHRoZSB1c2VyIGtub3cgd2hpY2ggbWV0aG9kIGlzIHVzZWQ/DQpEaWZmZXJlbnQg
bWV0aG9kcyBjb3VsZCByZXF1aXJlIGRpZmZlcmVudCBwYXJhbWV0ZXJzPw0KQnV0IGZvciB5b3Vy
IGN1cnJlbnQgY2FzZSBvbmx5IG9uZSBhdHRyaWJ1dGUgd291bGQgYmUgZW5vdWdoPw0KT3IgbWF5
YmUgYmV0dGVyIHRvIHByb3ZpZGUgdGhvc2UgdG9nZXRoZXIgbGlrZToNCkRQTExfQV9QSEFTRV9N
RUFTVVJFTUVOVF9FTUFfTg0KVGhlbiBkaWZmZXJlbnQgbWV0aG9kIHdvdWxkIGhhdmUgb3duIGF0
dHJpYnV0ZXMvcGFyYW1zPw0KDQpOZXh0IHF1ZXN0aW9uIGlmIGEgSFcgY291bGQgaGF2ZSBtdWx0
aXBsZSBvZiB0aG9zZSBtZXRob2RzIGF2YWlsYWJsZSBhbmQNCmNvbnRyb2xsZWQsIGluIHdoaWNo
IGNhc2Ugd2Ugc2hhbGwgYWxzbyBoYXZlIGluIG1pbmQgYSBwbGFuIGZvciBhDQoidHVybmVkLW9m
ZiIgdmFsdWUgZm9yIGZ1cnRoZXIgZXh0ZW5zaW9ucz8NCg0KVGhhbmsgeW91IQ0KQXJrYWRpdXN6
DQoNCj4+IERvZXMgZnJlcXVlbmN5IG9mZnNldCBtZWFzdXJlbWVudCBmb3IgRUVDIERQTEwgd291
bGQgYWxzbyB1c2UgdGhlIHNhbWUNCj4+dmFsdWU/DQo+DQo+Tm9wZSwgdGhpcyBvbmx5IGFmZmVj
dHMgcGhhc2Ugb2Zmc2V0IG1lYXN1cmVtZW50LiBBRkFJSyB0aGVyZSBpcyBubyBzdWNoDQo+dHVu
aW5nIGtub2IgZm9yIEZGTyBvciBmcmVxdWVuY3kgbWVhc3VyZW1lbnQgaW4gZ2VuZXJhbC4uLg0K
PklzIGl0IGNvcnJlY3QgUHJhdGhvc2g/DQo+DQo+VGhhbmtzLA0KPkl2YW4NCg0K

