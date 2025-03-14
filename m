Return-Path: <netdev+bounces-174879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EFFA611CE
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AF04621A0
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF41FECD0;
	Fri, 14 Mar 2025 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSPn5a9+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC51FA272
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956866; cv=fail; b=b1eSFn+sI8Z0ll0lZ9lhnpzoqoEls3sHDxhWRnEOmR+vsC+ypOiZcfH96Q/c3UDJBytTJcr3jOQh+RJtlBurcjoZ2BuXXCE/S0jIP7aRC7lHqYmjYLRsgZNHiJNmcXEkv81KbYeOAqXRkN9Ke3ceJTwoSMI9joOHHNAyQQhy8ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956866; c=relaxed/simple;
	bh=FK9fgzKTXOd8xWqAznIABZnhjxsUiHmK4GcdDmwkeH4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tp4Mg6y2dlxC3pxT427Y9vh4FtWEtKT6qPSMIYUkDjYNyqUks0F9SoDWFXzlfze6INbOyWRAQ7w0GAMpsJSKEtrlkLomK9j2HR26+AhfHnJiCF5eFBj6HK3O+rBFsK6Yq00OmXJW1cot6sJduMrlBX67NtTOBF6+Wq3m2CYHy1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSPn5a9+; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741956865; x=1773492865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FK9fgzKTXOd8xWqAznIABZnhjxsUiHmK4GcdDmwkeH4=;
  b=JSPn5a9+S1Cty/QLrqin8YOgH/eFU4KzEOx6TVH/QBT0dwB6beAFabIB
   gV2lr4LjZuLOcD1VIuLOGh6O0F2hmJqrxSd58fRinSMUbsvkVpLkxTkSr
   6HujUjCckUy4yXvPk36PFVsvRpABF4uX4iIIObRTviSw5Rk8eFfH84fQW
   L9uVhYusxFvRy3R24W/Pj5067mxR/zaqxVNlVKOgIprYVYoAUzle3LwvC
   Hd57IW9qnB523fSwpJ5BfOTsH4oKyPXMzqCygs72WEN/yNN4UtrSoFFeC
   fAatXr67nHifi0c0/oHHHJiWfE+o+lsZEHKkzg+qNkf361gIyGVR2jT6k
   A==;
X-CSE-ConnectionGUID: JR/RCnKdSROp4D2IdeOMRA==
X-CSE-MsgGUID: R06UswvHRxye/Vw9NsivjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="54102500"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="54102500"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 05:54:24 -0700
X-CSE-ConnectionGUID: lMMMU4nfS0mHcTM0dmVOog==
X-CSE-MsgGUID: PKlB/Ap9SRaeG/L4lo6hXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121004044"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 05:54:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 05:54:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 05:54:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 05:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FACcxw9Ccu/khid/5xAeLPti2f0ReV37sNVGS0VFKwEylu4FfLJJnE+DmmMr5lFuZccdykjg25jkV8w3VdZfX2/3AZPEVaRe/xizEF5cxFMwrYVB8P0whRjPVIRfTEYo0BDwoeODj9QP+lv+UPYNjp93UnVANduHihsYk3Ua/QZRIUykB+BVZuxwDgQ0HGOcAeCc8GmYjP4w3eD1J4iBAbW69QfO4XoWe/pIfvoTca0NgvjStmEdNI3UW8NDK97sFtHFTDVxBz46Z9Uy+Jtb/f2WLM0UmaWo+jN8CMmA2AyZ5NgaybGzQlv/qJGm1K0mJF1gHrlQOMSdS/XO/kpLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmN3hgYK9+4iglEIczOd5rLozKshp1Qe9FJppraCOBc=;
 b=op9nJEGCfDTZ71j756qPTYc84QGETa7triZPJb3rCvnvTOYWRQXzJNMWekxtcAEYI3XxZGCWSo8dbbE0XL+LE8BZV2eHxD1NA3AwVz+J+TEAUha2cwzdycfiXGDVE5dKyJCwXcAaYakJr+YvBVmFQCnhMrf+2Cxk2lpDWb5kp7nI4m6GL3u9+SyAI28Ie2lH73DdcNmouIFRnK3ftyadd7aZZdNo6any+yCCMphTg7U8FZA4Zmo5xRT1GHRkDGdzOKCkJmJ2BljYBLNifCqVghCKJjxHJvY2ZhmNqL2LUpEGX22C3xC81cZydyuQB+sMF+D8+ccOACw5RLFt7UGu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB7986.namprd11.prod.outlook.com (2603:10b6:510:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 12:53:05 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 12:53:05 +0000
Message-ID: <122bc3a2-2150-4661-8d08-2082e0e7a9d7@intel.com>
Date: Fri, 14 Mar 2025 13:52:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/3] fix xa_alloc_cyclic() return checks
To: Dan Carpenter <dan.carpenter@linaro.org>, Matthew Wilcox
	<willy@infradead.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
CC: <netdev@vger.kernel.org>, <jiri@resnulli.us>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <pierre@stackhpc.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
	<christophe.leroy@csgroup.eu>, <arkadiusz.kubalewski@intel.com>,
	<vadim.fedorenko@linux.dev>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
 <c2d160cd-b128-47ea-be0c-9775aa6ea0cc@stanley.mountain>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <c2d160cd-b128-47ea-be0c-9775aa6ea0cc@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eced558-17e9-49d5-88ee-08dd62f729c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWlYTjBiMEhHRXlVVUNGWWUreWJNQVNST3ZuMUtBZk04dkhBUis0MVp3czB3?=
 =?utf-8?B?REZybnVHc20wRXB3bjI3bEQ0ZzJuQmt4bkdSa1Y3a0d1RFN5QTFSWTRWeXRW?=
 =?utf-8?B?bmgxcjBJakkrMFJaVk9qMVliRDFPYWlISlZWKzQ5cURXZU93Z3JJVzZHdzFr?=
 =?utf-8?B?eXlHZlFXUFduWFNhbzhoNW01MFI4amJJV3FsdmxJYmU4QnRscllINXprZ0hw?=
 =?utf-8?B?bFFNNCsrNTNORnFZY0o5SXR2RzRKcE0veXJZUWZHOUNMbWpnL21GMkwvdDQr?=
 =?utf-8?B?akd0MklhZ09Fbm5DMXRjc2hCcFAyUzZoNm80dzhrcmhDVzBybWhPVVJGWWxi?=
 =?utf-8?B?MEM3N3N5cHdtL0Y2OS9abUhnZEhyT2JGaTh2bzE5SnBna0ZOMExsTGo2T3NV?=
 =?utf-8?B?c3RQcmJ2K0I0bXpacy90UjM3TVpKRmdFTDZCZU1QdXdBSk5HWWRMb3pmK21G?=
 =?utf-8?B?dzFxTDFRWHcyUEVqVTJiSEpDZXdzY1dkYWMwY0VuSEc4elpZbWJkd0dodFNB?=
 =?utf-8?B?eWVSOW41NFpkRzN2MCs1UndIdS96RUk5U2dKeG11Q1NZdFl6NDlaZXFra3Jq?=
 =?utf-8?B?NmR2V1d0bjZPS3cybWRFeDNnNUNmTCtCbjJLVDhiZCsvd2E3Q2pINDl3Q3Bw?=
 =?utf-8?B?NW85dUNTY2huc2JsL3h1YVhwOXFnM0JBZ3dKUjhibWRBejBmelV5R2ZDKzFL?=
 =?utf-8?B?TmdGdXdyTEFuVUNuZTJQaitCYXJoTi8vM1M1VDlwUW1nMHVUQTh1L3Nwbklw?=
 =?utf-8?B?RmYyNFl4Zm1YTkcvN1dSU0lrUXZWRmoybFZhMExQKzBYanZLV0lyVHVudmhY?=
 =?utf-8?B?OTdOc3ZqZXpOMUphVnhYdUl2Nmk0TVBQclFxcWNldkZVeW0wNkc2VVVsd3Nq?=
 =?utf-8?B?QmVjZ0w1ZUZRZXNTNG9nZm9IZ2VqZndDa3lmdm9RYWduVHJqL3JUNXJUb0hs?=
 =?utf-8?B?dk1zZEdSUmJoR3Bwdm9mRThpY0NuS2tVV1QvbFoybXVidyttL0JlWVN4YnZj?=
 =?utf-8?B?Vmp6MWtjRnk3K2s0SW9ROFdYZDREckROTk1reEs2WWZucWtLMk9zaTVzZG5k?=
 =?utf-8?B?NWVtcU1OTVJrTXNGYzBzdi9DVzd3SXE0NTJxd2d5SWlzbzlFcVpQMDdkQlY3?=
 =?utf-8?B?bW15TXJEMmJZZGFBeXpPOVEvZVl4TDgvQWFFYmc5Z09UNnhlUTBqUFBxR3pC?=
 =?utf-8?B?bFV0bFhCdUwvTjU5YWdkYnlEbWxjSWxORC9FQnpmWXVINE1xcUpFRFQwVzdz?=
 =?utf-8?B?SmJaRGVlZ3FLWlo5OFlNMjlYdlJxYi93Qy8wNmNXaTBCNzNrMlJ5UE5halBY?=
 =?utf-8?B?b3MvcjJJdk5Ib0hreWlsYlI0Um05SG81cHVvelRYVDVUajFlV0RVSjQrKy8x?=
 =?utf-8?B?MGhUZ3M5Z1QvMkxmOHpYMlBkTy8vcE9Tbk9mMG4yVWdDaUZqSnY4bXhoOUxv?=
 =?utf-8?B?bmpaUU1yYWlrMkdmbWVEakR4Y1loYk1VWUcwYWVZSkxOTnRCZnJHUkcxRXp5?=
 =?utf-8?B?Y2F5ZGpmajlYTmxhRHR0UDVWNGtlUXJMWDlybUFVR0p4T2NQZWIyMVJ3OHpM?=
 =?utf-8?B?ZHh1S3R4ZC9xbjN3Ym55RXcyZlNlNlB0Ym9pUlg5aytIUTZ1MkNaenBITFUz?=
 =?utf-8?B?Wm5Hb2JOL0FHdjE5bXZmM3RuSUloYUxnVk53bVlCR1dkdWpTc3p4eEl1VTBr?=
 =?utf-8?B?eDcyaDByM1FkYU04WkdtbUZSMHFLenc3UGtJVlVOVTFYdFFEMlgwTktNaWQz?=
 =?utf-8?B?SVA5aGQ5RnpBUE1iVERVWGRET0RJenM0Z200ZmkrcXcwY0hOQ2RSSDlWOTRu?=
 =?utf-8?B?VGZTMWtSa3JtalNCeHhjZ1BzbUZFS01tNHdLb1JsdXFZT3FNbDZWY01ZNWFh?=
 =?utf-8?B?aWNRN0ZZSnBDdVJmZ0h0c1FycXhFb05UcFcvZ0k2NXpyTmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGJhanFoRmVxd2pPdFYvWSsrSlRLZHFmQUo1TG0yQVBpUFdHMkRuRHpGbVVE?=
 =?utf-8?B?ZnFXank2dktXZFpZY3hwVU1oakp5Y25hejBLVEJpcDVBczhqWFZQRlcyalpF?=
 =?utf-8?B?WU8rVXRTd0sxVDJnYTErbmtrODMwYXNRUEtlSWNmQndoV1lMK3d0ZTBtQWVT?=
 =?utf-8?B?NFpscEtINXFib0F4TE9jaXM0cWRuOTlGcGJoWlJIblFhZWV3UUxWTFBYUVd0?=
 =?utf-8?B?c0NaMGNlc3ZISlViWG5qQzJ1cFZTUFRURmJDY2t6ZUovRUlkSjRRa0NUY2Jo?=
 =?utf-8?B?NWpoaGZnYUpBTy81UkhyV1Nra2ZzZnprbWdFUW0rNHJZT3J5bWpqT3M1VThV?=
 =?utf-8?B?UlFsaU05QjhTaHJOMVFjT1BBWVhjcFVyTnZkTkQ4WitnRkJSSXcyM1ZoMTcw?=
 =?utf-8?B?cDhiVGpqMCtGN3Rib2E5SnE0dTIxTzFZSE1XaHNRdk80ZkswTFE4NXIzcncv?=
 =?utf-8?B?VTVhYVViaXJ1OC9HRjhISGw3ZU5qdW1JNmEzd0VQS2d1RXlXSTk2d201c1pU?=
 =?utf-8?B?MXhUZ3JyM3FsZFpGa1Q1djNDL1BJU21OMkdqYWgxR0xvTEIvNlN0cUtrUExV?=
 =?utf-8?B?bEVsbjJwQUtHeXlaL1R5RDV1U3RwRkU2ejhaT3FKYmpmTTVMRUV4K1ZrdEZ2?=
 =?utf-8?B?Y1c0QklyVU42djNUcUxRa1gwRkx0N3hoKzBtTWcvb1BGZ2RPKzdLTmdla25p?=
 =?utf-8?B?ak53OFo2RUpEc3VWVEE0N3JMTFlST0Qrc09jblBKeTh4K3BpVGlMWThhRGor?=
 =?utf-8?B?VTlKUUdBYkRnNFF4dDVNQmxFd0lHT0RlT0dEUzIyTk5YQVZmb0JQSDhmMksw?=
 =?utf-8?B?L0VTMGVLN1RMQnZ3aEpESzhpMmZUL25LMENvWUREYTB5MTdJZWwrdWFTSzRs?=
 =?utf-8?B?YWpiNVRZdDV4c1E1cHZOaTR3NG9FOEZsTDZVUVlpYlRKUTFtSjFEdjdTRXM5?=
 =?utf-8?B?RnIycWtSOC9xRmhic3Rab0t0NnNiNXp6c2V2Rm82dWg3SEdZaHFRZ3EwZHlH?=
 =?utf-8?B?N1lMWVhydE1xNTdCNGVjUlZjQTFGeWJ0SDUzM2pVUlBLY1NNODA2WXNROGI5?=
 =?utf-8?B?YTVEa2pzQXBoSDFRSGI1dytsQzJYZjByeElJV1dsbWhJSTYvVThDRTBSWHk2?=
 =?utf-8?B?elZKQlYyWkpPTStUZkZaaVROMEx2T0dzZ2ZuR21oODI0cWthZjJVSkpvcTZk?=
 =?utf-8?B?UTFIUEVKTlVwMWx1SkM5cHp2T3RoZWxOQytHQ3JONDJjK1creXZSUXhBTnRs?=
 =?utf-8?B?dU1Ub0RSQW1BN0VMQTBQTmo5WmtQc3B2bVBnS1k2THlTVXVPMysyYjVlemNW?=
 =?utf-8?B?NW9mRmFEN0QvcWc3Z3o0TWJMN2x0VGtGYk14UVlxZzVBemFJOURBZjY2dEJO?=
 =?utf-8?B?cFhjOURrOXdHNEdCSzB3TXhHZnhKM0RoV01vVkEzWWhkazJKSDIyQTBaOXk0?=
 =?utf-8?B?ekozeFJaK1RnNVU2aW9tSVljZ3lHZi9Zbm9Lclg4cXF6MlZlOXM1eEhqU3Fl?=
 =?utf-8?B?NVVTNFRJRmNPbjJ0eE03L2xPc2tycXVNd2RTZldQeFpiK1gyT3E0THRMU3lN?=
 =?utf-8?B?VUpYd2I0ejRpOXJtaCs3RmN2NnJUYkV0LzczNVhsVmNBT0hwN2RibVBWWGMx?=
 =?utf-8?B?dkVmVWw1N2hhL3h1ZkExYlRNSmpTVHBwV3A1RXZya1NrK1V1aS9Sd2Eya0lC?=
 =?utf-8?B?cE9WUG1xUlFsV3MyQTRrTDAySGM0dFE5bmpNSzFoeHJRWE12bTBHVkxMSk9O?=
 =?utf-8?B?c0hoQnUybWdhWlVTZ2RuNXZEN3V2ektQemdKRXJmQnpoc3FBdnpsVUZCMkV3?=
 =?utf-8?B?eEc2V1hLb1VySktKZXh1L3RvN1JFc244c2pqemlZRzF6dFdwM09abVUwWkx4?=
 =?utf-8?B?dFkwUWxBbzh6S2FVVUZTQjh4VHNBbnZVcjk1NWxiR1F3MytyUjFIUGJsZGlh?=
 =?utf-8?B?TXdobERHVWw2dnFnRmI3NXE0K2hKNnFXYXZ4c08wWjd1cmlGbU5UVWo1QTFM?=
 =?utf-8?B?dnduMTl3THFTeG1VeWZEZmpwOUFIK0x3aktGODVPQUFOY3lQL0VXeVZkdW4v?=
 =?utf-8?B?dUREVXFEQ0p5MUZsMWkwVzZnTkdNM2xtazZVOEZIV25RMFY4WVJzcUVEMzlO?=
 =?utf-8?B?T3FXaEx6ME0yYnl2RFByNzhscTlpRzI0K2lhdGFJVTdvbTZJbnFiZ2dOTUJs?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eced558-17e9-49d5-88ee-08dd62f729c0
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 12:53:05.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0YXA7g3xbLo5imE4HkxyVZcDQf2ZCcaoUN0rWhrkl386rUb6h7p34br+CLeh0JlRa6pBNXoSgrg9ddHbFclt4rQ/JoqGCJejfC1x1hbDzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7986
X-OriginatorOrg: intel.com

On 3/14/25 11:23, Dan Carpenter wrote:
> On Wed, Mar 12, 2025 at 10:52:48AM +0100, Michal Swiatkowski wrote:
>> Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
>> from xa_alloc_cyclic() in scheduler code [1]. The same is done in few
>> other places.
>>
>> v1 --> v2: [2]
>>   * add fixes tags
>>   * fix also the same usage in dpll and phy
>>
>> [1] https://lore.kernel.org/netdev/20250213223610.320278-1-pierre@stackhpc.com/
>> [2] https://lore.kernel.org/netdev/20250214132453.4108-1-michal.swiatkowski@linux.intel.com/
>>
>> Michal Swiatkowski (3):
>>    devlink: fix xa_alloc_cyclic() error handling
>>    dpll: fix xa_alloc_cyclic() error handling
>>    phy: fix xa_alloc_cyclic() error handling
> 
> Maybe there should be a wrapper around xa_alloc_cyclic() for people who
> don't care about the 1 return?

What about changing init flags instead, and add a new one for this
purpose?, say:
XA_FLAGS_ALLOC_RET0

> 
> int wrapper()
> {
>          ret = xa_alloc_cyclic();
>          if (ret < 0)
>                  return ret;
>          rerturn 0;
> }
> 
> regards,
> dan carpenter
> 


