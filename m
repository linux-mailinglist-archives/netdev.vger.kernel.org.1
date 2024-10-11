Return-Path: <netdev+bounces-134553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00B299A0B6
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027BA289747
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140272101AA;
	Fri, 11 Oct 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZuKyrqY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668020FAA2
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641003; cv=fail; b=JK5EZjq+ZElGqfuMPci2IczTpkpbh2+SCp3uFYHJSX74SWvZBsDl8tcrMRd78nbkR4PqECXYq9o2+OBMnGZdrpE8O1xRBorFcXrT4B/4WxNsJBuOXsoTBqe3/woSpm4zmxtwAdhqBUXt4YNLJXkyjxNvk+kXfFBTk+Bh85gsKX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641003; c=relaxed/simple;
	bh=DO35ZZrP7RLlnBjSiWCHI+mI46YolDbQnsUhGQX9EsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MYU8bsFHWDyVXx/1BHYXPBWS+G3+satVsxrB6hVhyX224ON1UFk8LXxpi9vMFYukdsukyjg5JLxzH0Da2QbQZbpwZUuhQR7Hi+igz97ftGHUjLHjQ0zM6fC/tX6GrHqtzozld9p+rCyklAwTmKhx4uBWdWASgO2vwvaFP3rBFJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZuKyrqY; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728641002; x=1760177002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DO35ZZrP7RLlnBjSiWCHI+mI46YolDbQnsUhGQX9EsI=;
  b=HZuKyrqYFmMnUL1H6BRxmZci/ljWPaWbUmZpEYmqXYKMQAbUsb5ejRgD
   vxb7hYu8DWpJlwbNZl5kLqIrjP1KcQway68hD3ganUy8rACjERr88J/sS
   X5MHB42Wgxvgmo1rZUSpNat2xbNWVvvhOPf9KgO0YET6AvmaDWT74LIIB
   cgb59WHqq1i0OOLAnR1b2tupFc7J7Sf74yB/CF2+ASSF1OCK8NMk/yFKl
   EhS92mgln5VZmXLtAqjsGRl9WitylgrsLqOFx7ZJYBaad6I/NGc/zQvfd
   igesVo1qzSd7Mi1nbSpD2r0vErLKrDqqIVnrdxIiqGJwJ+AbXWICL2ocF
   g==;
X-CSE-ConnectionGUID: CDUv2pxwTL2hS3gn62We2Q==
X-CSE-MsgGUID: VSAaDs7WQSKki1vuoMbBJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27845691"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="27845691"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:03:21 -0700
X-CSE-ConnectionGUID: BZk/GHsQS5qiZdBzt3RJYw==
X-CSE-MsgGUID: OEuFKEeLQgmeTTYpUeG9tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81383433"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 03:03:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 03:03:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 03:03:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 03:03:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 03:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFMeZkvkZUyx42GlZTtAx8pbmMkNeFM+YXxutjxYvV/zMZD55G+SyvObLRiSPx1uwqX5D+PQJcsMdsaLYat2eKqTfv6CBco5dLQYdKxdtZjULOImRLCA3mjDaVg68CJQTt/qeuqddIDfOKunmJIBO5VrH3uGvsAh4P8L9YjAvPcnEkTi8+lQufSpm43wniNUeIhKPTcHAH4uvVGffRoEvOA7qfnRYk+AwyX7Wh4VMWeuovXM3AxXrJSgnbwCuSpoTcWXMdAityZ1Py2UHNvC+hreM7Nj6gx1XmEiAo+LqFfSJRMbR7If1jkoN/Y4es/0fQKnV9M6QL3/K5XrD+bEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jjPuRVAlxhG1aUasbDBTdfru+6miE2QrDFnuaPFR4c=;
 b=GmrhjpwYSEscsq97JxgefPYEnmHupQnH++nFAgwU0FiEE9ZsgvsBZpuUO1TfIqj5uLv1tKysgI+qdEqbm0vVqP0DlfHVQjNRcKHW/ZQf0+eDBKTY8KEuLB9X/aqkPQj4Gvf1DBPNwULO3slnxFNEbKVLan4UMVTntpETkCKBuxYw5k+x5Tv/Q0fsVbRtoJKWo6CqCpWLn5Ejda3NfgxcripoAjAXw5sxzwIEVRhs/UZgTYGeEPZdc6/1ORRPssNouNXgqgz9SjF3QzbLk9zn9L2m4UA7YzGFXwYW5hKNERZyYSCakW2QTKOVsTy2U2v8Nf98KK7SinP94iIOIaUzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB5078.namprd11.prod.outlook.com (2603:10b6:510:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 11 Oct
 2024 10:03:16 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 10:03:16 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 2/4] ice: split ice_init_hw()
 out from ice_init_dev()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 2/4] ice: split ice_init_hw()
 out from ice_init_dev()
Thread-Index: AQHbFMHCwBFY/YVtWE+VCTNLsZsU+7KBX05g
Date: Fri, 11 Oct 2024 10:03:16 +0000
Message-ID: <CYYPR11MB84294222DFF52958AC079052BD792@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241002115304.15127-6-przemyslaw.kitszel@intel.com>
 <20241002115304.15127-8-przemyslaw.kitszel@intel.com>
In-Reply-To: <20241002115304.15127-8-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB5078:EE_
x-ms-office365-filtering-correlation-id: 13ebca84-24dd-44ea-72c7-08dce9dbecdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?b0fVEMTXWF5ThxyfT2KmDMb340gwkYdTAB8c40S0hswOdEszw27Mfc7LADPe?=
 =?us-ascii?Q?U0aWJcTeO/5b+aPixxDUkoAjL2RpTbIIPudT+9CVT+NwF2hxp+lkGdd8tQPH?=
 =?us-ascii?Q?VfY9pgt9lc2LQGWwQBEuBMEv5PhmaeLeP0uHlCCOIRrCt8JAL3jnKtJaZyhR?=
 =?us-ascii?Q?Zli63VOdCSnkTTWVW0dx9AL0xWS77v80/y6bAc1NQRS5c3RgPLxi1z3DNXdj?=
 =?us-ascii?Q?/6RugtoLybCgjRwdqJghUXIM4WM0u4OaUCYtQlLcWSX6eEZ5MgwnYh13LyVP?=
 =?us-ascii?Q?VADtl6LMguoT7LdJ3bJsFN8cYsmMSeK0WcaxbEhdTm/vTcSrqCD11wljnFuy?=
 =?us-ascii?Q?JR1JWeTnph5ZMuTxATJXxD3uuB142dZkzVpDlXwBTplFwkoacOvW3N/CbDDh?=
 =?us-ascii?Q?Um4ZusRphlLYxiTPJXxDMC+C5KtRdd+Qzc9HO9qbbHcYHqMFlB549rgGhPB2?=
 =?us-ascii?Q?jwOPWbITyMeVmIh9/a4ovzfmZBQV2e6NMR/pd7270OsLSyUf5xGruAFcrVaN?=
 =?us-ascii?Q?5eY9ia5kL+NJOLHUZ2zryUW0KvuHPECWLT0d9i2jNUNCmPWtC8egVLU7VWbB?=
 =?us-ascii?Q?qjxV1IREaGtf1Vj+GozCSJzd4+Z86qLQuKf9bsuo5On+txP59bNFsfA5HEtU?=
 =?us-ascii?Q?ittiFoTXBS7RzB9QXGrvcIb88VH6XaYd0DLhnIG2AoqY3I1L6Q7ENXXyRxtB?=
 =?us-ascii?Q?C7Sm7nlViHUeeM8j50eqrhhUUknCHd2RIc/MYTvoJFmngokrXz4gszDjrKmW?=
 =?us-ascii?Q?qfSDxIdLZyiE1hqX6mTDTTBPfTz97hkTTleEwgie4+gOVs7cl+pePqie4Iku?=
 =?us-ascii?Q?5IZsniwXtFkjwJI8yWH13aoQunOSQZfgs9xvUs8SSLXEeGFCyuzne1FdlIw6?=
 =?us-ascii?Q?fsRqDgAlj2UBtptPSrXV053Tow/IJULfliYhYnP+5bY8q6wuZB3o/PyQJ0tT?=
 =?us-ascii?Q?ND5DTyNJl3ALcq2P8iC5bKz9yg9E6Urt6zQxQBisLnPf6d3INXnzbPRRgBov?=
 =?us-ascii?Q?T4ZVkWMLfi/Uek5+BcVm5eCVuvLwc9Jl3iwgXTdZJrzuoRtu8cmeJHNmFYV7?=
 =?us-ascii?Q?Cd9mz6fgzTni46M2aXUgm5gtH8Z/MWLcbiC472s0mvrp8R9MWi/MJWeQ0Vba?=
 =?us-ascii?Q?DZpqxAwKZLWDwYW7GEmTpxM2rj0mWcfeJcLdt40ewKp+2het5tuOxP9Wvmor?=
 =?us-ascii?Q?skSXrbnTyny73/wsexlrBynnRkyWi63Z/c5m0tww556IacELpOzM++SlhoS0?=
 =?us-ascii?Q?nz0ISLyI3tB6APDuBd0bCJrFuK8/cJZeE6YJyTXG++FQ8jPI2LLifETKdMT0?=
 =?us-ascii?Q?LbJ51az/9Qd6yCMoL7xunXdkKFw9/GVDNLi3xYcUI0pvgw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vlkhrK99ex9ddezOwXst9No15C9KdquOkdiseE9QACPURJTvGC/tbGtaxtfa?=
 =?us-ascii?Q?77vaFJ3/CrwQ3K+QAO63B812B5NRsGfvBHaX1ejIfGrSjweNDoCp4pNPkmGS?=
 =?us-ascii?Q?bti33vzHWUZSUOrRR/cEYabvCEUW7aInBwJIWdYM+CwfgGWMw+OOQoJsVrrE?=
 =?us-ascii?Q?0d/GyPqKNDn09cQFJBGP2mcxy5zAX2Jm+Hw4l4p/nM2++TawDsfS3/WR99lW?=
 =?us-ascii?Q?FOJwO2joQa5YgEXkJmtN6D+E1pYGisiIzRqiShwiM+w4dnGmCUmBLRVYXcz5?=
 =?us-ascii?Q?2UwWql2frsgxbPIxHD3CZ8yj+v2sbyA78L+aVhhgqI8tlRVEZtvDzPk27n4W?=
 =?us-ascii?Q?rQH9KNFrOWsjKwptUumbb8H3vrpLRXqiRk0a4Ev9fB1ljyuu52uP2GwPNyPg?=
 =?us-ascii?Q?R63ro+Y3FbEt3Y8KJrQQRNHjtsUDNj/Vc7LRNLgiMxRm1A9WtewNmh4GbGSr?=
 =?us-ascii?Q?B9qqjqDYJoYP+cmvOXMuAGynbaWV1PCeJIi46cMwXaDk4QmKxCGvtM0L6yj1?=
 =?us-ascii?Q?Bv8BUGS1K88EhP82eJ8bXtQWa/zsYCwf41vbfPNRG2rQ7As0l3Hv/YsC33n0?=
 =?us-ascii?Q?q7lXmdKkWm1qi1KM96YR2Ar+/7i0oz77L/nJdgzoO5hBi5MfZWHsbWfYLO2q?=
 =?us-ascii?Q?dX0jaosA3r2iFyqun89g6jeqvDotwpCEJCKM20SISHc6bpCubFKwrdC2VVmp?=
 =?us-ascii?Q?INjodW+XYiMGWCf6aBFTKHhnuuis8kG74MPN5eUSv/+hjrvezrF6G4Eos0bh?=
 =?us-ascii?Q?+73zxB91+z5+jLwadIcoSPM/F0rshnhD3QEKKSZyhotrO8Mz9o2MNhLLi75w?=
 =?us-ascii?Q?hmP7mHmOUWe7lNyaVR4ms4VijHCJNOlPysNMYdpXee39azrRK3BtC5sjJQD9?=
 =?us-ascii?Q?xZnVsfRZtiZsTP1HTOPHQl37rNAKtHXXPasH6JnHXZzFZnpbilgCSJpMbujD?=
 =?us-ascii?Q?2Qyme6Yv+GSV0hYMA67TtWIjv0bpsIX4T+VX/QPmAORc+8rVarwzU3/uHDen?=
 =?us-ascii?Q?zjx4yCoUKf3U2rFrO4B1lb5OXrIU+QGtxeqNe2LELmblq4vIHiWXBb4YonDi?=
 =?us-ascii?Q?GcNXdbkSK9k0Q1boEZKlsPKjQfY3nB8yZGk2jXsVpjDE5r2rmSN0qTrEPjpX?=
 =?us-ascii?Q?ag/HUHXxMqoe3qm0GYup2E2vIHwp+9nUoLS91+gT6wHUxu4hBKj9MqbFCvn6?=
 =?us-ascii?Q?p9ikYieLCh4ec/Pw3jIsBUkEZTfYxe7llg52dqHC2TYT6C5iEXwBhWWe9BXQ?=
 =?us-ascii?Q?w+qLM7hIUkYGkQdWBXQR3QoAs8PdpqABOfmrNrYxmFgaokXZHNXtuMkWHy1X?=
 =?us-ascii?Q?cKT8pN3GsAZgneTqsQcGkrs5A4ynaabFbPOtxcX4av13nagIyIUMfKZvLpTN?=
 =?us-ascii?Q?23heI7mLReMHbX54hLrdGHdDTOWgMXb0RiSduHSsIon+AE6qctu+C8CbhCFd?=
 =?us-ascii?Q?qRUP8F32MjGX/aMFRzbISvK8GY1s5j78VL5fX9yeQoRaOhtIGZZzNK7bAzS1?=
 =?us-ascii?Q?qwZHDmO0MY/bkihD29p+mDfGSTcNNLFngkITWg539WjqtdYeIiB2Vd5iv0VD?=
 =?us-ascii?Q?+KowVAB3A3qE9k7bh/v14Gy+LLFto+KZzMEgkXF/ikpxl+edDeCZ/W+9q9l7?=
 =?us-ascii?Q?pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ebca84-24dd-44ea-72c7-08dce9dbecdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 10:03:16.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uj9XIGf5iaEDsYjYUaQDVXbx4vidHrCtXOCeinZ1j4aiYxTFluTkQI7uxlJaioHFAttMqeAig5wpGnXTeiOAWmDTxRsFP+AMqlzoPnbfYD10mnAMadFhIEAWlo0hZxj6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5078
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemek Kitszel
> Sent: Wednesday, October 2, 2024 5:20 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>
> Cc: netdev@vger.kernel.org; Marcin Szycik <marcin.szycik@linux.intel.com>=
; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 2/4] ice: split ice_init_hw() =
out from ice_init_dev()
>
> Split ice_init_hw() call out from ice_init_dev(). Such move enables pulli=
ng the former to be even earlier on call path, what would enable moving ice=
_adapter init to be between the two (in subsequent commit).
> Such move enables ice_adapter to know about number of PFs.
>
> Do the same for ice_deinit_hw(), so the init and deinit calls could be ea=
sily mirrored.
> Next commit will rename unrelated goto labels to unroll prefix.
>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 10 ++++++++-
>  drivers/net/ethernet/intel/ice/ice_main.c     | 22 +++++++++----------
>  2 files changed, 20 insertions(+), 12 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

