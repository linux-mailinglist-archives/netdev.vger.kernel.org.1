Return-Path: <netdev+bounces-93609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677D68BC6C0
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 07:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745BEB20923
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 05:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32094594E;
	Mon,  6 May 2024 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LG284Pdf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517DB1E896;
	Mon,  6 May 2024 05:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973125; cv=fail; b=JNQ5yiYhpYGeMp9SV5xZfWIH6qynXe+BXsBfvYUuXhwxsxwmhmP5E7u0lXQkWnji0MSXDk8UW3RTbqiUHUoLRwZMemiW/QzSGb6mq0NqTqWB8BPa42+KmZt0rYcETlnxJiOZDAT0UwGYyibHuzA+uK50uQ8fLr0ZRhkjKrsdr94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973125; c=relaxed/simple;
	bh=FEPrBN9fqcWbdOZpX5X46rqGPjCydbwmlq0yh4wB+eI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rj1ApBB58Wu+B/iJbwUUEYCjCJjnC1/Fnnb+x6kLVXwg7qi/tlKLNqcfmKa9t5QYf9kc05QAg21ZIdH9AIgu6ghQmbV2+xKvKpMyuh+oa6U2deowdvTOC22iJrg8IfkNnUFOFACpcZybQbRFqFZ6qqDgnVQZ8RYFfTncK5psbMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LG284Pdf; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714973123; x=1746509123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FEPrBN9fqcWbdOZpX5X46rqGPjCydbwmlq0yh4wB+eI=;
  b=LG284Pdf4dHag2OYpaM9689MUuj1BPdIH8STxhdxODlVtYHCEerwfALl
   EV/U6jR8LG+JY2YqMevtY33FArJCTkV7YiUlDE+3xRTBFOPIJEHO7of9y
   qbyiNggYikWXRDeBtKbKEpzA/Belnm32lGVHjLTKrfHCUOeNpgK9mDlic
   WV9ju5ZFmnusJIYA71GhFzkJ/DH7IyjMDcqaoTquOFVdstgv4EIZIhCpv
   OpJj6sUoPPNQ8dvAQEte699mGkzPI+pyPdDRtSiGuZJ8PZaEtS3ac5Jdf
   4enGeMwnU+0pnMvVf9QQVK9LfjGATbl4UO3MuAAZW9enUWnH2+MjK6f5C
   Q==;
X-CSE-ConnectionGUID: 5IgTfUx9T4+SFoTip9CxbA==
X-CSE-MsgGUID: 8/b/5l6sQzCr8BQdHJQ2jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10628682"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10628682"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 22:25:22 -0700
X-CSE-ConnectionGUID: 8SLiYx/GT52yCwVIGh1NmQ==
X-CSE-MsgGUID: 4W3LaX5DS+aHrt98TSpF+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28561860"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 May 2024 22:25:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 22:25:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 22:25:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 22:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1GZhxXB6nv4TgPBms624xyeUU69QZRT5jxpKES22JlWHMrqFwaMtsm54bIbPFq/FRCXTl5LcfeJWbPK7joS4IlMhlfCvAWNkTZMrG2eNNzxzYa2+Fhan6+hlwlDIYG6yDzaPLZfz1058kPjiA2auKmHaw3bdG9m6tdO5iP1D1OMbjJX8WVCclj+JYNf4FvLytpmfA674RiuofzBl4ovIeVG9SNDe1cWzJ2x4sHssX9LI9pPZTJwvPvSoYCmX1BrseOSrAVOq6PyiWUWofh/lD7/llo6k5/0+2lUrDXNWSMYLg0qNDb1QHDQSiWJnKFNIBV+RUA0nGHbAtPnWjJdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEPrBN9fqcWbdOZpX5X46rqGPjCydbwmlq0yh4wB+eI=;
 b=ZzBcIsF2HGsAT5ge/LhiJJQVOA8fBj1p/XzeLptp1VstsozJbMGFtBjD8QLoSmW4hJwtHEcDCeWJA0+S0yCGokRGGaBl+5U9rH0TzpwFpX4gQG8Pg6eARQOnt4P0VjwoOfhAdpsoDKQTtpkLxCHLfCpfqdCo2C35ntVf9RnmQQYxRPiXWb4lp8zisszPCuPIGrAytD2qLrq4K0C4Du6ze7ldDL7jkpK58m1dJGDL1pTq7V7ppBHgU/R2Co27B0Uc4mu0jubttRo7LNpw6Mcys/97jX3VXeJ/peM7CK9bA8x3/0y2Qrm12NtDbPhpPf4CMLnwiiS1sgomVJ/iJslFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 05:25:19 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%3]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 05:25:19 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: =?utf-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: flower: validate control
 flags
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: flower: validate control
 flags
Thread-Index: AQHakA4WoMrCetPpSkCXQWbM721odbGFG3mAgADOGgCAA+CGUA==
Date: Mon, 6 May 2024 05:25:19 +0000
Message-ID: <PH0PR11MB501348B4C2970D26DFC48C1F961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240416144331.15336-1-ast@fiberby.net>
 <PH0PR11MB50139E3BE2709C5BE7F4AC78961F2@PH0PR11MB5013.namprd11.prod.outlook.com>
 <80089193-33e8-4601-bdbc-71d10ff1ab58@fiberby.net>
In-Reply-To: <80089193-33e8-4601-bdbc-71d10ff1ab58@fiberby.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|CO1PR11MB4915:EE_
x-ms-office365-filtering-correlation-id: 79d4fdb1-0208-46bb-1021-08dc6d8ceb5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NlpRa0xxWTBFbmtPQ283cWZFbFc3UUFCRVN0cjZnWkxNM1U0MkE1VFdTSmRO?=
 =?utf-8?B?MCsrcUNINWFFNWJ0ODkxMnd4UTVvamlCSTAvNExEM3ZtcG1YWTlZUmpUK1Mz?=
 =?utf-8?B?enlLcm5ZSFNKMi85b0k4OFYxU0xOQ0piRk9sOW85VHZORStUOEdtSWpUTjJk?=
 =?utf-8?B?R0pQQndhNGgvVnNyNldnYWFyem9jam0vSVYxbHdRQkNBVkhnQXBnc1VGZzFL?=
 =?utf-8?B?dDloSnVnSmcxTGkyWC9yWmQxYklwQTBGZlNxV1hnb256NGxYaDY2SnEwM2th?=
 =?utf-8?B?czI1Y1lqUThoOVNkRnkySGY0YUkwekVacEJxbzlRd3J4OWtnbWg2WTdueTdt?=
 =?utf-8?B?cCtqQ1JDajE0Zit6TVNLZS9UN1E1VHNPdDc3YklsWHlZMzArVmQ0YWN5T3g1?=
 =?utf-8?B?VWxQMXd4TU5YRnlWM2NTc1dQYzBCakNLRkhnLysrUXk3d3RteG8reUVUMERj?=
 =?utf-8?B?YVF4RkNibW16c2p2YW40NEVJbFd4ay9ueXhycUhaR2NUdWI5ZW5wKzB1Wndq?=
 =?utf-8?B?cWhNSlFsQ1B5NElKSTliUmZOWG1FeURlclBGdkpqNHZBR1VUUU9NQlN6MU1u?=
 =?utf-8?B?YnBOUzZHbkRET244MlE5Z0VneXpTYnJZMU5hSkwwcVgwNlRhaHBVOGZTdmJz?=
 =?utf-8?B?dWVOSW9JNXdWVUdCdmZaRHV0Sm91SzR1M3ZwZUplMVhlRXRTeWhPNGxaSlc5?=
 =?utf-8?B?L0VscEFJRXZvY1Bja1VxZ2RTNVBBREFLS2NnWFZoZDM4OW1ybDZLelR3bFJy?=
 =?utf-8?B?UUdKdFlwMi9GMGFSdGt6cDNmMUZUTkNKL1NBd283ME1mR0E2MmZKNmhxa1or?=
 =?utf-8?B?ak9nR2dOL2JwUzBuT3NMZ3Z1RWoxTnZRbVlheDFCdzVsVmlQOFhHZGt6bWZz?=
 =?utf-8?B?b3k1emtHVXdVbUVjbjViQ1RJbDVBN3pUQW00YnpTcVpsSGd5MmhyYjBxak9h?=
 =?utf-8?B?L2RzZFVkdHkyNFR2dFVPdWgyWGNpNytidHJFbDQyeWwyWmxoZDh5TERDT2N6?=
 =?utf-8?B?blY4bFdWSHI4cXVIWlRXYjdtbGMvb0k1K3VWcTZvMUJLUGV0eHlIcWNKWlVh?=
 =?utf-8?B?NmJBbW1GYm81dEtNS3RKNGlMM0t6c1RVNFBnVnMrV1JtaDY2YjRzWllGKzRn?=
 =?utf-8?B?dGt6aStsaUs5N2FQaFZZODRzL3NhMmo3aUNIOERQaDZhc2ovVVZuRmdXRXJI?=
 =?utf-8?B?RkRwVGlIWDVxNWRDMmNJY1plNjZaandVTUJPckdGZS9lVUd3VzNoUXVLTmQx?=
 =?utf-8?B?UG8zQlVjUlEwQUxqZWthOFE1ZElrVTFrZWJNNVJMZWdFcUtpQjcwVDdKVHln?=
 =?utf-8?B?OXZKWkMrT3VpUTZ2UWc1b2NhakowaFAxMDE2K1o4b0FQR0pHZHMzVlBFdkN4?=
 =?utf-8?B?VXFnekFkMS9ueUxRUWRZeTByRGVIS3FJZTlZSUZnWXg5dE14b3hPVXlLODlM?=
 =?utf-8?B?SU5OT1hHUFQ4T0VwNytMVVRkdmgzUkFiZlV1Mkl0cmJKWFpCM05ycFdTbmYz?=
 =?utf-8?B?eisrLzhuQmVvMXVaM211N093ekd4MzViM3BLSVU0VU5FeFRQZUlURG9abUVV?=
 =?utf-8?B?bGxqK2dYTlN1bzVlQ1lGT3NWRjJXM2JXbWNudGV1RitYTmZsYU4vY1J5NFN6?=
 =?utf-8?B?R2toNXduYzRaa0ZIY0JKOHNXL2dsRHZTQ3F2MXB5SzFKcnpvT1JhcWRraFNX?=
 =?utf-8?B?Z0tHTXg5MXVrRDhYNDBDckVGeCtweHowSTAyQ2Ftc2cvc0NCaURXUHRnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUN4QTIxaVlmWWhZZm11VWF6MzU5SjJKdzE0TFlpanFvcTM1aHNPWXJpK0Nj?=
 =?utf-8?B?UXdQSmVvaHdYQWtvd3RzT1RlQ3FLRFpBRmVTdXordldmV0R3SUhMdFZ3SGlB?=
 =?utf-8?B?d25ycVdGeVhZbG9NdjFWQTBPbm5qeE1vSDZxOGkzMmVFMHJSMkgwQnlpV21E?=
 =?utf-8?B?UlBjVmhHVGZKQlRPVUM4Y00wQWdVQ1BhMGhZa05PVjdqbFNVcnZ2YU4zS1N0?=
 =?utf-8?B?Y1NVZWtqNC9HTVhocTZZUWphSCtQc2lTMnVYR1hGQWlXZjRFRkJhdkVmWUFH?=
 =?utf-8?B?c0w4MFNFMjB2Zkh2T0ZVSkZ3WndJdkVrWmgxZzRZdUdVZ0JSMU1BVHlLd1gx?=
 =?utf-8?B?OHB0cTRQTDBUaWJ2dmhVOElKclFZSmhPKzRwbUpXcmlvS2lUYnVORlZkZGIw?=
 =?utf-8?B?dVV5bGtPRld2eHBOV3RNajRmcTZnZzFLckZUY01aVTF4RXJ0ck52WDdZeTBk?=
 =?utf-8?B?WUZ4UStlYlFiVkJvdFJYejNDaUhYMGFQQURlVlhaVjBrclRHeFFvc2N0M1U2?=
 =?utf-8?B?ak01NnliSzMzT09nTkdnMyt3WWhHYjZ0ZmRVOUFOYTRIa1VOZmtWSWV3SkNq?=
 =?utf-8?B?UnlZT2NLVmNid1NBUDZjczFVdU9tSkc1SnpaYkhreko1WU5odVVuUG5iVG9j?=
 =?utf-8?B?dEpWNWZrb1ZMOU5NeWJic0w4Zkx6UkwxKys0UmlPTDNFR1RKakgzTU1rWml1?=
 =?utf-8?B?Q3p6b2ozaUtqUG1uRk56L3BYcCtlZ0xLNTFydHlBYld2QzduaFRSUHlBSHl2?=
 =?utf-8?B?MVc1UDZnMy9pSkdPU2lPdExNNWVETzhmT0ZRcWZJMmFnczdRUTZMdmdlNmZJ?=
 =?utf-8?B?MDhBMzFGRHZDMmlYVlcrS3pENmswV25pU1hXQ1MyTUFIbkFnNGdnN053dmNX?=
 =?utf-8?B?aHZ2aFNrMi83RXYxZnZSSWt6dXZlekFqWkFrb3NiVGx2aWova0lOaC9mdC9V?=
 =?utf-8?B?VXBuRG43aDl0b05NdGt2MjQzWXdURDBqdEFxS1EvZE9QbUUvNkFwNTh4WjNJ?=
 =?utf-8?B?a1o5UzhRMEJEa211b3VTN1N5UnJ2aDI0VEY2MmIyY0tMMGdPSVhsV3Y4d2NC?=
 =?utf-8?B?SjAvTm9OQmpxRGRMOHBRUER4bHlOcHBzMXRZWURmZ1BSZTRzM2NGdUZPaUxS?=
 =?utf-8?B?cEpBYjRjbjNLNmtIYkU4cmlaY0hoSXFwZGR3U3BFM3VzeW9uUTRwakRUQmFu?=
 =?utf-8?B?TFQ2R0twZkpyWUhhb3VPL2lpbTJOdnZ5U1I0OTk3czkzWUxhZzkvdlVYQjVC?=
 =?utf-8?B?V1VKdk5aOHdtRUFvSktIUDhPUkQxaWlpSVdSbUtObXZ4UG1xcHZGSWJOUndx?=
 =?utf-8?B?bWlSemIyQzgyK3VOcGFFUXV5VFZoMFZvZnI2a1BRSkJpT3hQYU5tZCtoQi9C?=
 =?utf-8?B?dS9sUGNOVmJUVzVBS0hURytJUUVmbXkzY3Z0RURYU2JCK3NXeDM1MUFPZUVu?=
 =?utf-8?B?Y2R0VUpkaHhoZFNERTM4UG11TTZOemtTR2huK2VRa2pxTGxXSXk1NWZ6aUM2?=
 =?utf-8?B?L2F2UVVtVjh0NnFtVXg0VStjUVVYSm41Y1I3bG9GMXVYOEdnRk9FVzJucWtC?=
 =?utf-8?B?bkVmQ1lZZFlwMjJiR3N4NWJxK0pub3l6K3pOU1ppTmw0RlV2eUl0cUtJWDUr?=
 =?utf-8?B?RklnZ1R6aEVXYnR3QmJzOUorV3JJMEpEZ250aWtpZ3pRUDhMSFN3NXFvc0hM?=
 =?utf-8?B?MkFzbFc1M1ZFUUNyUDJDemxRTDhaQ1JEWlY4TzYxOGVWMFBMYXNXYWVMR0dS?=
 =?utf-8?B?THdrQ2V3Y2VnRzh5aUlnbmF6dlJDRW5UYXh5V1NQUTlqR3h1cU1pSG9XTzNu?=
 =?utf-8?B?ZEJsZTNZcFc3VjFCN1M5cjhlNi9GSWEzQlYrNkhiU1VPOHkvMTJvbXJPSEh2?=
 =?utf-8?B?ajFlR1FnNkQ5OU5sVjM0M3RUdGhDeXJLQ3djZzFrSU9FV3FrVFkwY1lKcSty?=
 =?utf-8?B?Z0tiak9sWWYvU21BU2F0aEVXQTRZeGJVaUVtanl4L04zOWwra1NGbmVscndD?=
 =?utf-8?B?aHpJQUpmbFNYVFFFOHhablY4V3BGdFRJMlZYTnZKQVpLRUx1bWdROUZ4TXI5?=
 =?utf-8?B?ckFlRmlDNHVCRFZJSDlKbndzczdzOUJFSWRvdXZnblpvOUZHVno1ekdFc3ZM?=
 =?utf-8?B?Y0VKRDFzUzBmekJLdGZySVpRQzRQZ2VDNGhsSzVpVmpEeFJ5TXJ4bVZaREo4?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d4fdb1-0208-46bb-1021-08dc6d8ceb5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 05:25:19.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLxFz4hqxK3vEzFQVxrFhx5ZZJ+TahQeveWWTtqHsnAA/WtzSzNJwJ2h3Uq7M93W+QQLkeX+Lc+8PSDat4NN2H33eOnjJT/IMVKx3VN5G20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
X-OriginatorOrg: intel.com

SGkgQXNiasO4cm4sDQoNClRoYW5rcyBmb3IgcHJvdmlkaW5nIG1vcmUgaW5mb3JtYXRpb24gYWJv
dXQgdGhpcyBwYXRjaC4gV2Ugd2VyZSBhYmxlIHRvIHRlc3QgdGhpcyBwYXRjaCB3aXRoICdza2lw
X3N3JyBwYXJhbWV0ZXIgb24gaWNlIFBGIGludGVyZmFjZS4NCkl0IGlzIHdvcmtpbmcgYXMgZXhw
ZWN0ZWQuIEVycm9yIGlzIGRpc3BsYXllZCB3aGVuIHRjIHJ1bGUgYWRkZWQgd2l0aCBjb250cm9s
IGZsYWdzLiANCg0KW3Jvb3RAY2JsLW1hcmluZXIgfl0jIHRjIGZpbHRlciBhZGQgZGV2IGVuczVm
MG5wMCBpbmdyZXNzIHByb3RvY29sIGlwIGZsb3dlciBza2lwX3N3IGlwX2ZsYWdzIGZyYWcvZmly
c3RmcmFnIGFjdGlvbiBkcm9wDQpFcnJvcjogaWNlOiBVbnN1cHBvcnRlZCBtYXRjaCBvbiBjb250
cm9sLmZsYWdzIDB4My4NCldlIGhhdmUgYW4gZXJyb3IgdGFsa2luZyB0byB0aGUga2VybmVsDQoN
CldpdGhvdXQgdGhpcyBwYXRjaCwgdGhpcyBydWxlIGlzIGdldHRpbmcgaW5zdGFsbGVkIGluIHRo
ZSBIVy4NCg0KUmVnYXJkcywNClN1amFpIEINCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBBc2Jqw7hybiBTbG90aCBUw7hubmVzZW4gPGFzdEBmaWJlcmJ5Lm5ldD4NCj4g
U2VudDogRnJpZGF5LCBNYXkgMywgMjAyNCAxMTozOCBQTQ0KPiBUbzogQnV2YW5lc3dhcmFuLCBT
dWphaSA8c3VqYWkuYnV2YW5lc3dhcmFuQGludGVsLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEVyaWMgRHVtYXpldA0KPiA8
ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1
eWVuQGludGVsLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbw0K
PiBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVt
bG9mdC5uZXQ+Ow0KPiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXh0XSBpY2U6IGZsb3dlcjogdmFs
aWRhdGUgY29udHJvbA0KPiBmbGFncw0KPiANCj4gSGkgU3VqYWksDQo+IA0KPiBPbiA1LzMvMjQg
NTo1NyBBTSwgQnV2YW5lc3dhcmFuLCBTdWphaSB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSW50ZWwtd2lyZWQtbGFuIDxpbnRlbC13aXJlZC1sYW4t
Ym91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gPj4gT2YgQXNiasO4cm4gU2xvdGggVMO4
bm5lc2VuDQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE2LCAyMDI0IDg6MTQgUE0NCj4gPj4g
VG86IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+ID4+IENjOiBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBFcmljDQo+ID4+IER1
bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA+PiA8YW50
aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBBc2Jqw7hybiBTbG90aCBUw7hubmVzZW4NCj4gPj4g
PGFzdEBmaWJlcmJ5Lm5ldD47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9s
byBBYmVuaQ0KPiA+PiA8cGFiZW5pQHJlZGhhdC5jb20+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+DQo+ID4+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBp
d2wtbmV4dF0gaWNlOiBmbG93ZXI6IHZhbGlkYXRlDQo+ID4+IGNvbnRyb2wgZmxhZ3MNCj4gPj4N
Cj4gPj4gVGhpcyBkcml2ZXIgY3VycmVudGx5IGRvZXNuJ3Qgc3VwcG9ydCBhbnkgY29udHJvbCBm
bGFncy4NCj4gPj4NCj4gPj4gVXNlIGZsb3dfcnVsZV9oYXNfY29udHJvbF9mbGFncygpIHRvIGNo
ZWNrIGZvciBjb250cm9sIGZsYWdzLCBzdWNoIGFzDQo+ID4+IGNhbiBiZSBzZXQgdGhyb3VnaCBg
dGMgZmxvd2VyIC4uLiBpcF9mbGFncyBmcmFnYC4NCj4gPj4NCj4gPj4gSW4gY2FzZSBhbnkgY29u
dHJvbCBmbGFncyBhcmUgbWFza2VkLCBmbG93X3J1bGVfaGFzX2NvbnRyb2xfZmxhZ3MoKQ0KPiA+
PiBzZXRzIGEgTkwgZXh0ZW5kZWQgZXJyb3IgbWVzc2FnZSwgYW5kIHdlIHJldHVybiAtRU9QTk9U
U1VQUC4NCj4gPj4NCj4gPj4gT25seSBjb21waWxlLXRlc3RlZC4NCj4gPj4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogQXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+DQo+ID4+
IC0tLQ0KPiA+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdGNfbGliLmMg
fCA0ICsrKysNCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4+DQo+
ID4NCj4gPiBIaSwNCj4gPg0KPiA+IEkgaGF2ZSB0ZXN0ZWQgdGhpcyBwYXRjaCBpbiB1cHN0cmVh
bSBrZXJuZWwgLSA2LjkuMC1yYzUrIGFuZCBvYnNlcnZpbmcgbm8NCj4gZWZmZWN0IHdoaWxlIGFk
ZGluZyB0YyBmbG93IHJ1bGUgd2l0aCBjb250cm9sIGZsYWdzLg0KPiA+ICdOb3Qgc3VwcG9ydGVk
JyBlcnJvciBpcyBub3Qgc2hvd24gd2hpbGUgYWRkaW5nIHRoZSBiZWxvdyB0YyBydWxlLg0KPiA+
DQo+ID4gW3Jvb3RAY2JsLW1hcmluZXIgfl0jIHRjIHFkaXNjIGFkZCBkZXYgZW5zNWYwbnAwIGlu
Z3Jlc3MNCj4gPiBbcm9vdEBjYmwtbWFyaW5lciB+XSMgW3Jvb3RAY2JsLW1hcmluZXIgfl0jIHRj
IGZpbHRlciBhZGQgZGV2DQo+ID4gZW5zNWYwbnAwIGluZ3Jlc3MgcHJvdG9jb2wgaXAgZmxvd2Vy
IGlwX2ZsYWdzIGZyYWcvZmlyc3RmcmFnIGFjdGlvbg0KPiA+IGRyb3ANCj4gDQo+IFRoYW5rIHlv
dSBmb3IgdGVzdGluZyENCj4gDQo+IEkgdGhpbmsgdGhlIGlzc3VlIHlvdSBhcmUgb2JzZXJ2aW5n
LCBpcyBiZWNhdXNlIHlvdSBhcmUgbWlzc2luZyAic2tpcF9zdyI6DQo+IHRjIGZpbHRlciBhZGQg
ZGV2IGVuczVmMG5wMCBpbmdyZXNzIHByb3RvY29sIGlwIGZsb3dlciBza2lwX3N3IFwNCj4gCWlw
X2ZsYWdzIGZyYWcvZmlyc3RmcmFnIGFjdGlvbiBkcm9wDQo+IA0KPiBXaXRob3V0IHNraXBfc3cs
IHRoZW4gdGhlIGhhcmR3YXJlIG9mZmxvYWQgaXMgb3Bwb3J0dW5pc3RpYywgYW5kIHRoZXJlZm9y
ZQ0KPiB0aGUgZXJyb3IgaW4gaGFyZHdhcmUgb2ZmbG9hZGluZyBkb2Vzbid0IGJ1YmJsZSB0aHJv
dWdoIHRvIHVzZXIgc3BhY2UuDQo+IA0KPiBXaXRob3V0IHNraXBfc3csIHlvdSBzaG91bGQgc3Rp
bGwgYmUgYWJsZSB0byBvYnNlcnZlIGEgY2hhbmdlIGluIGB0YyBmaWx0ZXINCj4gc2hvdyBkZXYg
ZW5zNWYwbnAwIGluZ3Jlc3NgLiBXaXRob3V0IHRoZSBwYXRjaCB5b3Ugc2hvdWxkIHNlZSAiaW5f
aHciLA0KPiBhbmQgd2l0aCBpdCB5b3Ugc2hvdWxkIHNlZSAibm90X2luX2h3Ii4NCj4gDQo+IFdp
dGggc2tpcF9zdywgdGhlbiB0aGUgZXJyb3IgaW4gaGFyZHdhcmUgb2ZmbG9hZGluZyBjYXVzZXMg
dGhlIHRjIGNvbW1hbmQNCj4gdG8gZmFpbCwgd2l0aCB0aGUgLUVPUE5PVFNVUFAgZXJyb3IgYW5k
IGFzc29jaWF0ZWQgZXh0ZW5kZWQgTmV0bGluayBlcnJvcg0KPiBtZXNzYWdlLg0KPiANCj4gQWxz
byBzZWUgSWRvJ3MgdGVzdGluZyBmb3IgbWx4c3cgaW4gdGhpcyBvdGhlciB0aHJlYWQ6DQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9aaUFCUE5NYk9PWUdpSENxQHNocmVkZGVyLyN0
DQo+IA0KPiAtLQ0KPiBCZXN0IHJlZ2FyZHMNCj4gQXNiasO4cm4gU2xvdGggVMO4bm5lc2VuDQo+
IE5ldHdvcmsgRW5naW5lZXINCj4gRmliZXJieSAtIEFTNDI1NDENCg==

