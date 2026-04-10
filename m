Return-Path: <netdev+bounces-277247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHU+FgOJ2GkIewgAu9opvQ
	(envelope-from <netdev+bounces-277247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:22:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1263D2469
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89EB3300F1B3
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA79B332614;
	Fri, 10 Apr 2026 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVOzprti"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9832D42B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775798527; cv=fail; b=ZTUufJycW4xwASeJ6uNo1QzaCEpi5d4ZyWkwCLQllGZALgSL2V9l8/DfsSbb5bjbD4XJPM4DWIb1LgVV+62HnM6q4YwvBYcIIWJQtcJFI2kb9og4Q7qDSjUNIJLouzdZgp0Xh++NzN36jhU7JmXjPfpSxgm/mEKklPgRg7IkVLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775798527; c=relaxed/simple;
	bh=mJh7w4qRwiTzASr5LXz6jw6slyHVt6GIJXnxuqzYeoU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/+a4/rGHZyTu+7a1i3RQHnl2NZFOt4KLhQDdNLFDIM0/jMABsFmNFyKr5Q1O1oNa+4aShjqg7SVz549lrWfatOt30nnzr2DdS71eEzyOEE5W3YzpPUzszg3Y1SUFszkvrJktW3+sqTb9zNbqt54j4obmDrZieLMHwl/AAhy16s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVOzprti; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775798527; x=1807334527;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mJh7w4qRwiTzASr5LXz6jw6slyHVt6GIJXnxuqzYeoU=;
  b=OVOzprti+HFinvb935NUZM8XJyhCiftcYbnPmSKVvDPVx6Zh9AJ8meZw
   a95HB7IZ9NWAlg908Q8wn88WK2FEIPY8gIK1s1ct4L7O7TtsiaIb2B5Wj
   K6D7GuMKcsOpZt0YPfW+ZJClzF2AloIyqSdP4OyCLRgY7m2xSyLlapJAb
   VYiuec33z2kORYh4a3eZeKm+r2P41iT3+3SrBxipEs0xij+RPTJl+Dqja
   dXoXTFTIwaj68hW5Ibxz+jJDEp1PxyVjdu2K/tvWh+Wsv3arzcyFTwpMJ
   dVs/NwzzWL80IlyOtmVaw7QLXNqzO4egAJE8rSb1Hl2IHtncyKBY/ODmH
   w==;
X-CSE-ConnectionGUID: VzmbvpWcTcWnUz5hKp3x5w==
X-CSE-MsgGUID: ppLDRDXfTB6ATJK5upU2+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76832874"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76832874"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:22:06 -0700
X-CSE-ConnectionGUID: 7l1CMwrJTJKkLG/N7ALQbA==
X-CSE-MsgGUID: iDCvDt51Q8+1zVfFXMt4Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="233066486"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:22:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 22:22:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 22:22:05 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 22:22:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFE7yynYSEZaKJtqgan8oG2vH72VZkgacDIYxso23pIcuC8SdFqZzm7fvuvMZyNoqh7QZCt8H7qIQh+wHo9LXo+aUYLe8cXthInEo3yDQxk9ew2j0je/O+OK6PMAj2sqJVUlPjGm7jLn614Wg/CfsB4ympMaYFw6ylxs2pLDZT5HfgDoHhmPgALqXYw2sRDXWoDrufP0hVtx894AW2VazAHYCerh9cmZJ5IT641k2SYAwh/k6BduT/Wuj25zN46VmdDdwHASuQ8PLz4nArvwXW+iCzj3rMTg8QKift06v16csHTRuDA58tZwVKIlc5V+stKJDGwPNYW8KfM7aK9VBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMNKRiYFYz1O1Iz3rMev9uy9TjdRqkSdj7l3nKlMjuM=;
 b=Ti8zSQQeB2aW1To2JMkk1QJWXgY4hoo+fAeaIPzN9QR0gkmtBSobb1sKkC/i8KP/VB9Ur6jJkuR70RiovGJ3Hm5gSWCwvZMilr4tvoKwn+WCr9wxRmE8Yw5CRd5b8dzIo2+orc5vQMVScrEElUUCL1LrKQVOzxl0wSDpCIvsjU4LsQ1I7Z+IXS9A0uvwDCFWxbUwWM3UxLDG6ucAFkBGZMnn3rVZ5sxha2oaMh29BFhq39lT62Ft1PbExx1uBWjhZyDPV3R9eW8PScVWgSEou2mgNdZbuTOCpFsaOWkn5fyrtUZ5mvWcr4zAc0+6jNNURgEURRzrc1ykX+BVd7lk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 BL1PR11MB5287.namprd11.prod.outlook.com (2603:10b6:208:31b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.34; Fri, 10 Apr 2026 05:22:01 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 05:22:01 +0000
Message-ID: <ee2681bd-5223-4957-b10e-5dbde0c0e974@intel.com>
Date: Fri, 10 Apr 2026 10:51:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/drm_ras: Add clear-error-counter netlink
 command to drm_ras
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, <maarten.lankhorst@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	<joonas.lahtinen@linux.intel.com>, <aravind.iddamsetty@linux.intel.com>,
	<anshuman.gupta@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
	<pratik.bari@intel.com>, <joshua.santosh.ranjan@intel.com>,
	<ashwin.kumar.kulkarni@intel.com>, <shubham.kumar@intel.com>,
	<ravi.kishore.koppuravuri@intel.com>, <raag.jadav@intel.com>,
	<anvesh.bakwad@intel.com>, Jakub Kicinski <kuba@kernel.org>, Lijo Lazar
	<lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>
References: <20260409073318.2909379-4-riana.tauro@intel.com>
 <20260409073318.2909379-5-riana.tauro@intel.com>
 <e7978696-eff6-4c1f-ab0f-047dccb18b59@intel.com> <aderpXuhLoiUoxcT@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <aderpXuhLoiUoxcT@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::18) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|BL1PR11MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e956a6-79b1-4f4d-15b9-08de96c1186c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qUbqXjZ0JCW965A23rB2dTcIR+FVrPYYl9PZDxJEAvRK/oqfUImF3QMM744Z/kPHTmCnmtGY8SLgqOFOSWcTcmw8fNhKEJINPxBlIsH0H0oN63X9TsQGCRgIsnTJ77xzLvmzCuWaavgtKHerrwz9jkB31zEFXAfcxJlGuEi0OMnUErme7/v8xgiNCMz2QKocr/flJxoygxYqVqWgW4Kdb+o5+Lc9unGUurej/40zCLACNCzkbPTy4/jIk14m1UXbeIjBza3Of6VMoVekoAHxzUg0WsxIFpKS5alfYQmHPJRoKUNhXm0Q6IYlLrapoDxVOB7Hr3kHaaDIBWB4gDF2MPm4LD+m5R9v4xBfTCGuELC3FsVXTq/c/PyWaiHnEyzw0zlo354a7bCbbffBckvkFjUtEigF62Zg+kM4XjUsI3qJjSdghoEHcjVCG5qnwRj64hR/D1A2o50Tm24ITc5wQ/pFp+hUYKuh5XfgxmRr+sG2FNF7rD29PWtZ9JECNFulVLUWRBYoAyQpNI3LVF8WE4RD2jUaNG16muCX5moCRZmCj94rELr0k4bMP2DMxWI18dL+BxYEh1X0+EdyDmlLJAZEpRFyFCdDInkEhLeay3XXokCOMTKgVgJkElKEWB+y+T7dJCdsbNXXk6vhQn4/aMoCs+1BuF/xDzBvbS+Se+vs3w14CtfpLI8SRa1JYDvvcGAr0Rgw+gfXTXN0mBoDmF+AXPO488FY7FAYu4nTBBA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNRMnNVRlFUV2NaUW05WW5YbEo1T1dBcWdaK0N4dmZiZURZaUZHUXp4WWE4?=
 =?utf-8?B?TkZiQXZ2OHU3YytpRExZWDFSWHh4cHdXZDRlS2xkbmhra2VITnRTN3pJKzRz?=
 =?utf-8?B?YjMrN1BsZnZ2YjN3eGlieFpsRHhJVlBhZzVENzgxK1Y4elZJa25mUldkWkZR?=
 =?utf-8?B?dWgrWm5DV1NFLzhzV20rellQUUp0cGdPZGhrTVFmelJMNXo0aDIya1BNZHUw?=
 =?utf-8?B?cXJ4N2UvVm01T1Y2RWpEOStLU2g0dGFkd3JNb2ozdzZVdFZNaEdaMnNIb0xG?=
 =?utf-8?B?VSswSHpVbGNEaHBBczl3UktqVlp5bk5GUUxIdCtzUWxrb3hmV0gyTmF1VzFm?=
 =?utf-8?B?bVdvSi9DT3lRaGJ6Zll1Z3JDSS9wT1czb1RlVFRSaUMzTEpZMDFBUVdyemNX?=
 =?utf-8?B?eDVKdllaZ1ZsMnJIUVFCbjkvVUJLSExQanBWcmw4S2FWOGRST0xBNExiYS90?=
 =?utf-8?B?UnNYY2EvTHF3ZHc0MmYvcmsvZUFIMjdVcjRKRTQ4UGhBVnlKM1c0b2hHWlMz?=
 =?utf-8?B?b0JMWWJKcHYzamNZTXZiVkpyV2VteHAydWdLczBJNzl5KzUyVmpScFk4NW05?=
 =?utf-8?B?anRiYkk4VmprZ1YrZWY2bFowbzhid1h0Z0ZBM3c2SDd0c2FTMHB0NEJiM0pn?=
 =?utf-8?B?bXp6QU5wM0twaWpPR3lwSWRva1ZIU20yc0NlQjdVWlVsNjczc3gzNVBpTVBD?=
 =?utf-8?B?bU9ZWkNlKzFtUWt1OHgycFVnTlVEQnZad3NnMDZ6R2ZGdkp4VDVlcGR2YTB5?=
 =?utf-8?B?QVcyeGMzbUphQ3dXYUtCbXA1Z2h3TGJFMkpNZTlNUndVTjZIRVBXMFlNSnF5?=
 =?utf-8?B?T2w1U2JDWktWVDBGZnF6d3c1MzQvL3RybENEblNJZmEvdnIrZVNWVXJSalZk?=
 =?utf-8?B?dGFDR3M0TDZ1ak9rWDRqWGkxZFZ1aE5LSm5GVER5QzJnclJTbmdQVzBXUk11?=
 =?utf-8?B?OHJDTnNabU9uVWR3ZnJVTE5rL3lINURrTkhzKzIzRE1GL3BCbDdyejArcmQ0?=
 =?utf-8?B?ekZ2ZTZ1NUxwM25kUjZ3cSt1bXEvRzVEUzRjOUNNaGJualdtNHpzcy81SFN6?=
 =?utf-8?B?a3BPL253dWZJWFVhd2Njb2Q0VXpnclQ4d3Ywa2NYdS9MajY4RGpZMyszSzIx?=
 =?utf-8?B?T2poRnVaamc1STNRbTNQOXpwQUF2djdmMFN0VkpWOVdlTXJUK29BK2FlR05U?=
 =?utf-8?B?VElZODY1SnlFK0l3MG1ZZlBmSmRkcGhpWjA5R0EzOHpwNW9CSGUzcHFjRjBQ?=
 =?utf-8?B?VVpTWGgyaE1oVGYwTjQ0QVN4VDFCZWUxK2ZXMUF2OXg2YXM4UEVreHRtMTFk?=
 =?utf-8?B?eUY1Q0pwaGZ6SU41SXFOb0JzTWdKcUFzS1pHYzlnVDkrVHllMVYvWGtmTnVa?=
 =?utf-8?B?SW9ST1AvMlZFSEZkaUtoYkw5dUJ0KzI2K2VWM01HL2lQZUFrK3dGb3Z3QWR1?=
 =?utf-8?B?L09JRVVDSy9LcDF1MSs4ZmFacW1LWVhicUg4MmhoSFVWNzRkRy82M2EvOXFk?=
 =?utf-8?B?VWJ6T2VrdEU5VjQzalpKbGhKZXFtNGFvMWVqT3oxSUQ0OUtVWU9CTVQyeEZv?=
 =?utf-8?B?L0Jtb1NFbzQrN2c0S05SZlliWU1QbEhhY1ArZDZnNXpOeGJVNEN0YURaZDEv?=
 =?utf-8?B?QS9IRnJIaEgwOTJCc1RCSjdjbm9ZMlZ4UExGNkQ5NWVSRmhlQzZRTWkwamJD?=
 =?utf-8?B?d0tEVFJzcjltSkRib1Vab3lHNXB3eFpvZmcva2JXNlhBMnNWRitUSENGeDBr?=
 =?utf-8?B?OHMydUFldVI5d2E3REVCSXhEeXBWZ3I2YlRRcmFibmRkK2xwWCtWckorL3VB?=
 =?utf-8?B?dkZoRmM1dHpZZkR5SjdnZDJDUWhVVGZmc0FxTWl1eUpjM0lLcTdybFAya1Vv?=
 =?utf-8?B?YkppVVN1d3F5cUNoY2d6L2NIMVBrYXlEeVM3bDRhTzZPb29CNkw2VGdORjlz?=
 =?utf-8?B?UHlBdEEyeEFvRWZOeEdISXNwdDZuOW5OUTNzcFNTbmFJOE05NStQc3hSN2Vt?=
 =?utf-8?B?eEVOejA3bncrSHk3SlViTDdnaHJaakw4YVpSQjFEbmV6UzdOUVJHMXhXRXFm?=
 =?utf-8?B?K2xERGl2dXhVZTAwTHJQdk5XR0cvRFFCNkFuTEFwNXdnYlRFeEE2cDJaSmtU?=
 =?utf-8?B?Z0p0L0J6WFV0c0ZpbmpyT2pzRm1JQmpXeXJIQ3RtOS9YKzd5WmZKY1IwMWFY?=
 =?utf-8?B?MS96Q2xxOE1zQzZTMWVFZFoxam5YeVdIUmdBTkhWVnZSaGswbC9lRWs1NDJT?=
 =?utf-8?B?YzNrVGpHL1lVUGZTNGlBSWtrR3l3b25mWEtNYmltR2RMUXA0eFVFNnMxZGZ3?=
 =?utf-8?B?MG9QemFVdGtRbVIyNEdaOXhBTy9WclRROUVWRTBrSVQ2ZW5LK0thUT09?=
X-Exchange-RoutingPolicyChecked: izZ7L7Ad1MMpgrnevO3YNHaU0LlGNxyKaOjUq32S3HvbTz20y6oxFnz520b24EbNlnp3iCo54Zu6H1LUYT2WWOqfU9vN0rqjRY8Q2FYhu33Xc24zPQQg2piIKc90TTYHpgQ4RxwJSqmB+hq4UUll3QU9aA6HvbcBC5xoietTbx4qGYWp3egMTv1+FuXtAUs0oo4APw2lajZtK/5P98RyZtkjCJJpzEt2axRqXBmKfLUSII2UeM5quScavHsXsDPJykUEE5YCuMy5kVlZkduER096D/vaKzr9RNhRYTKr1uWRzOgE93iUWokdb1yiphSC7lC52SQ2daUc4WMxTLqPsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e956a6-79b1-4f4d-15b9-08de96c1186c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 05:22:01.7698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKjxHzM6vyk9QgyMUh72lgC7fTUIHzTQFW1mHr+jJfm1O4z+js8Y2GwR7Idln4NU6iUf78Qb6hKH+Y1ByDGWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5287
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-277247-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,oss.qualcomm.com,linux.intel.com,intel.com,ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,intel.com:dkim,intel.com:email,intel.com:mid,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CB1263D2469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Rodrigo

On 4/9/2026 7:07 PM, Rodrigo Vivi wrote:
> On Thu, Apr 09, 2026 at 12:51:44PM +0530, Tauro, Riana wrote:
>> Hi Zack
>>
>> Could you please take a look at this patch if applicable to your usecase.
>> Please let me know if any
>> changes are required
>>
>> @Rodrigo This is already reviewed by Jakub and Raag.
>> If there are no opens, can this be merged via drm_misc
> if we push this to drm-misc-next, it might take a few weeks to propagate
> back to drm-xe-next. With other work from you and Raag going fast pace
> on drm-xe-next around this area, I'm afraid it could cause some conflicts.
>
> It is definitely fine by me, but another option is to get ack from
> drm-misc maintainers to get this through drm-xe-next.
>

Yeah this would be better with the other RAS patches close to merge.

@Maarten Can you please help with an ack if this patch looks good to you?
This has been reviewed by Jakub from netdev and Raag from intel-xe
There are no other opens.

Thanks
Riana

>
> so, really okay with drm-misc-next?
>
>> Thanks
>> Riana
>>
>> On 4/9/2026 1:03 PM, Riana Tauro wrote:
>>> Introduce a new 'clear-error-counter' drm_ras command to reset the counter
>>> value for a specific error counter of a given node.
>>>
>>> The command is a 'do' netlink request with 'node-id' and 'error-id'
>>> as parameters with no response payload.
>>>
>>> Usage:
>>>
>>> $ sudo ynl --family drm_ras  --do clear-error-counter --json \
>>> '{"node-id":1, "error-id":1}'
>>> None
>>>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>>> Cc: David S. Miller <davem@davemloft.net>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
>>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>>> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
>>> ---
>>>    Documentation/gpu/drm-ras.rst            |  8 +++++
>>>    Documentation/netlink/specs/drm_ras.yaml | 13 ++++++-
>>>    drivers/gpu/drm/drm_ras.c                | 43 +++++++++++++++++++++++-
>>>    drivers/gpu/drm/drm_ras_nl.c             | 13 +++++++
>>>    drivers/gpu/drm/drm_ras_nl.h             |  2 ++
>>>    include/drm/drm_ras.h                    | 11 ++++++
>>>    include/uapi/drm/drm_ras.h               |  1 +
>>>    7 files changed, 89 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
>>> index 70b246a78fc8..4636e68f5678 100644
>>> --- a/Documentation/gpu/drm-ras.rst
>>> +++ b/Documentation/gpu/drm-ras.rst
>>> @@ -52,6 +52,8 @@ User space tools can:
>>>      as a parameter.
>>>    * Query specific error counter values with the ``get-error-counter`` command, using both
>>>      ``node-id`` and ``error-id`` as parameters.
>>> +* Clear specific error counters with the ``clear-error-counter`` command, using both
>>> +  ``node-id`` and ``error-id`` as parameters.
>>>    YAML-based Interface
>>>    --------------------
>>> @@ -101,3 +103,9 @@ Example: Query an error counter for a given node
>>>        sudo ynl --family drm_ras --do get-error-counter --json '{"node-id":0, "error-id":1}'
>>>        {'error-id': 1, 'error-name': 'error_name1', 'error-value': 0}
>>> +Example: Clear an error counter for a given node
>>> +
>>> +.. code-block:: bash
>>> +
>>> +    sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>>> +    None
>>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
>>> index 79af25dac3c5..e113056f8c01 100644
>>> --- a/Documentation/netlink/specs/drm_ras.yaml
>>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>>> @@ -99,7 +99,7 @@ operations:
>>>          flags: [admin-perm]
>>>          do:
>>>            request:
>>> -          attributes:
>>> +          attributes: &id-attrs
>>>                - node-id
>>>                - error-id
>>>            reply:
>>> @@ -113,3 +113,14 @@ operations:
>>>                - node-id
>>>            reply:
>>>              attributes: *errorinfo
>>> +    -
>>> +      name: clear-error-counter
>>> +      doc: >-
>>> +           Clear error counter for a given node.
>>> +           The request includes the error-id and node-id of the
>>> +           counter to be cleared.
>>> +      attribute-set: error-counter-attrs
>>> +      flags: [admin-perm]
>>> +      do:
>>> +        request:
>>> +          attributes: *id-attrs
>>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>>> index b2fa5ab86d87..d6eab29a1394 100644
>>> --- a/drivers/gpu/drm/drm_ras.c
>>> +++ b/drivers/gpu/drm/drm_ras.c
>>> @@ -26,7 +26,7 @@
>>>     * efficient lookup by ID. Nodes can be registered or unregistered
>>>     * dynamically at runtime.
>>>     *
>>> - * A Generic Netlink family `drm_ras` exposes two main operations to
>>> + * A Generic Netlink family `drm_ras` exposes the below operations to
>>>     * userspace:
>>>     *
>>>     * 1. LIST_NODES: Dump all currently registered RAS nodes.
>>> @@ -37,6 +37,10 @@
>>>     *    Returns all counters of a node if only Node ID is provided or specific
>>>     *    error counters.
>>>     *
>>> + * 3. CLEAR_ERROR_COUNTER: Clear error counter of a given node.
>>> + *    Userspace must provide Node ID, Error ID.
>>> + *    Clears specific error counter of a node if supported.
>>> + *
>>>     * Node registration:
>>>     *
>>>     * - drm_ras_node_register(): Registers a new node and assigns
>>> @@ -66,6 +70,8 @@
>>>     *   operation, fetching all counters from a specific node.
>>>     * - drm_ras_nl_get_error_counter_doit(): Implements the GET_ERROR_COUNTER doit
>>>     *   operation, fetching a counter value from a specific node.
>>> + * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
>>> + *   operation, clearing a counter value from a specific node.
>>>     */
>>>    static DEFINE_XARRAY_ALLOC(drm_ras_xa);
>>> @@ -314,6 +320,41 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
>>>    	return doit_reply_value(info, node_id, error_id);
>>>    }
>>> +/**
>>> + * drm_ras_nl_clear_error_counter_doit() - Clear an error counter of a node
>>> + * @skb: Netlink message buffer
>>> + * @info: Generic Netlink info containing attributes of the request
>>> + *
>>> + * Extracts the node ID and error ID from the netlink attributes and
>>> + * clears the current value.
>>> + *
>>> + * Return: 0 on success, or negative errno on failure.
>>> + */
>>> +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>> +					struct genl_info *info)
>>> +{
>>> +	struct drm_ras_node *node;
>>> +	u32 node_id, error_id;
>>> +
>>> +	if (!info->attrs ||
>>> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
>>> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
>>> +		return -EINVAL;
>>> +
>>> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>>> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>>> +
>>> +	node = xa_load(&drm_ras_xa, node_id);
>>> +	if (!node || !node->clear_error_counter)
>>> +		return -ENOENT;
>>> +
>>> +	if (error_id < node->error_counter_range.first ||
>>> +	    error_id > node->error_counter_range.last)
>>> +		return -EINVAL;
>>> +
>>> +	return node->clear_error_counter(node, error_id);
>>> +}
>>> +
>>>    /**
>>>     * drm_ras_node_register() - Register a new RAS node
>>>     * @node: Node structure to register
>>> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
>>> index 16803d0c4a44..dea1c1b2494e 100644
>>> --- a/drivers/gpu/drm/drm_ras_nl.c
>>> +++ b/drivers/gpu/drm/drm_ras_nl.c
>>> @@ -22,6 +22,12 @@ static const struct nla_policy drm_ras_get_error_counter_dump_nl_policy[DRM_RAS_
>>>    	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
>>>    };
>>> +/* DRM_RAS_CMD_CLEAR_ERROR_COUNTER - do */
>>> +static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
>>> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
>>> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
>>> +};
>>> +
>>>    /* Ops table for drm_ras */
>>>    static const struct genl_split_ops drm_ras_nl_ops[] = {
>>>    	{
>>> @@ -43,6 +49,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>>>    		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID,
>>>    		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>>>    	},
>>> +	{
>>> +		.cmd		= DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>>> +		.doit		= drm_ras_nl_clear_error_counter_doit,
>>> +		.policy		= drm_ras_clear_error_counter_nl_policy,
>>> +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>>> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>> +	},
>>>    };
>>>    struct genl_family drm_ras_nl_family __ro_after_init = {
>>> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
>>> index 06ccd9342773..a398643572a5 100644
>>> --- a/drivers/gpu/drm/drm_ras_nl.h
>>> +++ b/drivers/gpu/drm/drm_ras_nl.h
>>> @@ -18,6 +18,8 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
>>>    				      struct genl_info *info);
>>>    int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>>>    					struct netlink_callback *cb);
>>> +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>> +					struct genl_info *info);
>>>    extern struct genl_family drm_ras_nl_family;
>>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>>> index 5d50209e51db..f2a787bc4f64 100644
>>> --- a/include/drm/drm_ras.h
>>> +++ b/include/drm/drm_ras.h
>>> @@ -58,6 +58,17 @@ struct drm_ras_node {
>>>    	int (*query_error_counter)(struct drm_ras_node *node, u32 error_id,
>>>    				   const char **name, u32 *val);
>>> +	/**
>>> +	 * @clear_error_counter:
>>> +	 *
>>> +	 * This callback is used by drm_ras to clear a specific error counter.
>>> +	 * Driver should implement this callback to support clearing error counters
>>> +	 * of a node.
>>> +	 *
>>> +	 * Returns: 0 on success, negative error code on failure.
>>> +	 */
>>> +	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
>>> +
>>>    	/** @priv: Driver private data */
>>>    	void *priv;
>>>    };
>>> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
>>> index 5f40fa5b869d..218a3ee86805 100644
>>> --- a/include/uapi/drm/drm_ras.h
>>> +++ b/include/uapi/drm/drm_ras.h
>>> @@ -41,6 +41,7 @@ enum {
>>>    enum {
>>>    	DRM_RAS_CMD_LIST_NODES = 1,
>>>    	DRM_RAS_CMD_GET_ERROR_COUNTER,
>>> +	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>>>    	__DRM_RAS_CMD_MAX,
>>>    	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)

