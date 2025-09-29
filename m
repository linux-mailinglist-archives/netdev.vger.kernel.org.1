Return-Path: <netdev+bounces-227154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ADCBA9361
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545653A3A87
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CAA26F471;
	Mon, 29 Sep 2025 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSM0jVx5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451711E522
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149120; cv=fail; b=icP7udplV5oTmCIKmDTVpO1zSKyX0cc1htlNsX8nmxHx+OEUgTHoX/WW2uLhbhk5NwUpYMt9JYTjFokp+VbDC364YCmjg5iIwArcAkTHraiX/AAFaVg446rDRo/yN5rUkRPq6wM68Q73jkZ8PxQzz2mUfTL2rFyvLJFfI9t8Uho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149120; c=relaxed/simple;
	bh=aLZaA9/OPIkgH1U0h57fOqWXzwgHXDznHnEYnQ/jBoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pQ7+BlC4f6LK4758DaUF6Xk153bnWwvZRg6+RsFVAnlFMgyrT72DCd68TO9RWst6lhnlhYXTp8WPS3VGDGZkEi72yBhWqZ1posuG/hAIQtoUGuCgOrm+CN+gGK8aK0yBjucaiBTdQHUf3icmcjKQmmxCasl69Mgb7zIDcEkJzTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSM0jVx5; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759149119; x=1790685119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aLZaA9/OPIkgH1U0h57fOqWXzwgHXDznHnEYnQ/jBoI=;
  b=gSM0jVx5KQ+aPASnLS3R4OglRSWYQLpajQYlJOW5TYbcBot5DcJdAz18
   YrmO2wRD34uT7My5yAJAW4Im3yJIMCyc8Gq4TWQUg6/nYgQJwUiRQ6sZR
   MnFggm7u7KWWO6A+WWobM7TIzPqtl5CzESwje6JnhCg56NYsaw0LjdsoY
   onjreGKa0s8tujy4FwXqSEYz2Gciy29Qbjw0rW7YpbuL1ZplnANJkp4yn
   MK6DXHZvtmoQTJP8ISpBFips06OeMn9Gl57Fq0WnUos4ccWwpPPIsLXdU
   S9TAH3Zob2eRAiQtdeFMMrTZWpwYJk3jkYFYi9k4KFzDY6dKCBNquELMC
   Q==;
X-CSE-ConnectionGUID: NQjZn9u7QsmcksOkqrsZGg==
X-CSE-MsgGUID: +D8L9GbHRvmglQHAb0InaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72066934"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="72066934"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 05:31:58 -0700
X-CSE-ConnectionGUID: A2bU1K8QTsS3Riw3qUi4LQ==
X-CSE-MsgGUID: bmgm8hXpRauVPICONyCPTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="177479629"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 05:31:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:31:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 05:31:57 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:31:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6SLA9+1Bl7YaYpegGVDx6P4zMDb2pF1zTwOTd8GKfQL925sDS52JLkOuBdPoz3vXLtuH7vOondj0ROYl4eIESAvFYkoBqnvINnRiAHl6ReVxu5DjG407IshmXNVD8VhYPIi/iRq3a+a/HhGEM40HQAkjNiI/Yk5g167+1bjQ/kYTnE+6DJOvxMsOXsTtap7BkwRhh0BWi9+IZYA6S+z/0hvnScMF3vom9E2PzxrY3smpIcHjAAgCA/D/AsQjBdVA9KXEqIASnwr5WqSekkQM6ujVRgePiyonle3DV03uMJ0QYhKIKf3ThvPZSRd4917Cng9idd4aa72/UWKylBosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLZaA9/OPIkgH1U0h57fOqWXzwgHXDznHnEYnQ/jBoI=;
 b=paz4mSoEQD38KwOjVwx9Y+LZpJi1ZWHDRNr8OQYlGRRPCRulkIcKNlfiA3Ygn7NtBfFBa0Fl87SPQJhSNeCfNbPuXHszyHnoomGeqdON3lAyK382YA3KKcILc74gV2Wa/7cjc9MlkJ3h3L4mOeb0zy7jYxNWq/UQzvdDHkbF4I3f0bCKHVUXq+9dw+EX4WASicPbXTP9z7UT5MDBPptW/jZN1bcYtP943qd6QR2zxusH9vrdThY2r2kon85gASiGb/w1uv7OxvP2nCj5Jj3OlYQPoDodoQwPyLTVLCTmPnjIC9oQQ9wpYgpPr6G5zV+9bIAVv/IvKv5sntm3r1jSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CYXPR11MB8729.namprd11.prod.outlook.com (2603:10b6:930:dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 12:31:54 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 12:31:54 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 7/9] ice: extract
 ice_init_dev() from ice_init()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 7/9] ice: extract
 ice_init_dev() from ice_init()
Thread-Index: AQHcI+eoTJ7ewPXsfEaHsPqls7Y497SqJRYw
Date: Mon, 29 Sep 2025 12:31:54 +0000
Message-ID: <IA1PR11MB6241DD203534899ED530680F8B1BA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
 <20250912130627.5015-8-przemyslaw.kitszel@intel.com>
In-Reply-To: <20250912130627.5015-8-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CYXPR11MB8729:EE_
x-ms-office365-filtering-correlation-id: 34e8dc8d-c0d7-44f4-5d9d-08ddff542c86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?y9wMRQTDHbMGHNLW+a+trPTcfn/ThF3sjmGuaII75dfOZRkWcVvS+nza8lDQ?=
 =?us-ascii?Q?G0O+9W4s7umzJ/w7MQ2KYuvVaQYQ5NYOVr1t7rZeShQHtcjnpDhHOWhdbWsd?=
 =?us-ascii?Q?+MbVaQ8ycxwLwcn8lO7YfahMwXhebOR8lWMcWkm74qIn/x1TkBiEv7QaNrUO?=
 =?us-ascii?Q?hCuKgvT5+mVxVimwCbWnYR2T/Oq0qF/2R2bHELz7WKC35qYFsMp22jXORHyy?=
 =?us-ascii?Q?ZhvZaJMWZAZz3eVCDejKgEq8mLG9eqck/RA5PodKwVJooiT3qtwsEHsOBGf0?=
 =?us-ascii?Q?9XmRQYMKb8E6VKR0K2NaHJ5Xq0wIXGOzinAA4vxTokEdhBg+STF3XKFwS8lQ?=
 =?us-ascii?Q?CrQ51WaLgElSm20zfDV2iOjDpkyvjy+e1dGkspcGqzwAq8yUY0cfdvb2cwfU?=
 =?us-ascii?Q?JCgxB7ii+d0T98tjXRLgP5Mf5J6bWLiTybVlmpVd3aCyMVVWaYSol49czPNz?=
 =?us-ascii?Q?L14HfknlZzBe0ajdb9Yy/o9xbtSfTOeuR6ZhlVxjJoLRf2IdGX9m+tlrXAPY?=
 =?us-ascii?Q?BDeR9yFmsbXtvNoBAFoYSxIOuszYpnm3JTDTCZeOMPYTTQSngNdaaB+0o/KN?=
 =?us-ascii?Q?RFmuHNlh3UuoUpooKMreunpVuIvijKsTZ7sZcySlW4IfMmD5EutG1PffQhPI?=
 =?us-ascii?Q?kFLoXqPQTitoDaWBAbhfhaCkdcVIpDXQ/g75kiaG1cVuV6BGwtK5Pji77jQO?=
 =?us-ascii?Q?nI1Csy5bjHaCh9riBGjvFfQR6/6wRerBmSP31cuWTS657VNCBOZfDsopQmHw?=
 =?us-ascii?Q?l52ofq0O3sq/OAQvWsr5wNkqr+e+eIinNDIz4dfwqBMSFnO2uIWZJ/682pbq?=
 =?us-ascii?Q?XA4Q425jusZjN2RJDwywH57BXVrV/HRA82rIUyJO+yE36baB8bC4nXD3Bl71?=
 =?us-ascii?Q?/jUjoKjhH4GfgAK1aiWRM+f6tiFZdxmoRu039Twp285V4NrjiWGppW8RCB0c?=
 =?us-ascii?Q?GnNWu851Kc2VIN5+lfa/Z2+IuuNsfUmckF/sCR8wFiyNDFCaAfElRTQoJjiE?=
 =?us-ascii?Q?+3yIbDt3IohsJpwmhYjDJLxtMwi7JeCMkKZLw7qBNM6X5MDzbHaBDnVRGxwB?=
 =?us-ascii?Q?8pozFcJF+jERYQzDz7BVkmzk2Hc8VU+7dprIXR4UG/lXXRccqOJvTp+qWlY6?=
 =?us-ascii?Q?HMDD31r1rP/KcEjx2pCqb4ydq4Mi+rxCQpEqmSG7Qru8OZG3LgxiLhFuonQ+?=
 =?us-ascii?Q?lSyPExjrx4es9yxTg8owcb/pC0zvvUq4DXpZT1U3IuvTT//paX1ouCugd9Lt?=
 =?us-ascii?Q?elynfS4slkj5NTWAKuvHlbl0w1YxuANzOl4foIIsnZWhpPXeANa17PgIqRYw?=
 =?us-ascii?Q?Xri2U8x8mBYOEvuYmBqqleXkxdHB9XcOzU7ul99fyyFhGdIZ4brFE1YdHU+D?=
 =?us-ascii?Q?1721p6FWJ9FG6gBDeXFmUl3nVLIkwBfLHgB6nlIleE0wyAYZTT6IGXwYpsxe?=
 =?us-ascii?Q?A0K0VaKIhQl/GuTCbf+I/5AqAVeWXoKhm1Vh7f9dUSS56ANHR1vkkkrZAHcr?=
 =?us-ascii?Q?Po8myBKWSnWyz/PLQMGUiiPVl49Cj7hxb273?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qot0qr2oEbDE2qNUzI4TI9u1/gJJiHfIfgTVNm8IebFg7Jc3Ouc+WseijSrx?=
 =?us-ascii?Q?IOLo0WgDN6FX6gZR2BF9uuAKSHGLWo6hFEFOdQ18ZNMQQ+PwMXlNobU6N2Ce?=
 =?us-ascii?Q?SPhs520SulFDy1HOQPxsbUMt89p7KlJcGJI+ZtglKfXzWkFUpOREAagOZfny?=
 =?us-ascii?Q?4/aXGsJmf+IhIW/suNkaEpc8V/hVpG0XsBNklu68JSB2Mxx/TT2kecBHzSwY?=
 =?us-ascii?Q?yHa+tI8BkfnLGtRsy4ecoYGiz0UFFDqrCsdg0htQWJfvk3t1N95iImOhjbb6?=
 =?us-ascii?Q?QX/kjMvIrWB+ljcziPeJs5X1XxJXxT+tj8LKcdnRvFbNdpeGVvbKlj8UIyD3?=
 =?us-ascii?Q?NxFteBzkizbKuC/gYijG4t9bDGiinlQo3gwEDi2neqYv/zb5mQojqTk3MgFd?=
 =?us-ascii?Q?hVUE+euUq4VEkHJcM7NlNvWulbQcoeprNt4/3XcIJbWzlDu9top9xI0ClO0y?=
 =?us-ascii?Q?n7boAfkuFNhPpofNV64yNAGwtmIu3orUPtJugDivK9WfmhsScXB//HJNPe7d?=
 =?us-ascii?Q?WZ3f/20nVUARaWAZ4KrZrgJmzv9LAFbHWbavZWs3j3PmG+1CA2ApEihNm7ed?=
 =?us-ascii?Q?hhvl0TvYNWONB/XKTi2jtYDOCqiYYt89PGCFAdV24DMnYSg9m591HPJ618k3?=
 =?us-ascii?Q?XdDAIlxtKUUw1exrrr/BpOe45ibx5D68J2ibBcaHrZnHqQxdEjsT8li69TPy?=
 =?us-ascii?Q?k+0rrHF5ym22e1hz2uA89YYM1G5i3yQWUOIvIf8+4+bqnSBcqo/yZSTjn0ac?=
 =?us-ascii?Q?JDMI9AFmiYbtYJE9neESXzGrTbRcRUtPIIMBW37OXtbBzVGecRyO6EbSH1wJ?=
 =?us-ascii?Q?cpdRpvnWHM5PNqbQZBDdIHKxw1M/GunQOVjqt3UdqUn0zZZyd/Lzp5aYqOuu?=
 =?us-ascii?Q?/TAdLDhQzlRqUUw5EHzJcsbayBqMECQ0FnFxbkejh6gnghUTxHXEt1H1Q/H4?=
 =?us-ascii?Q?7c3s7MX8VSh0jvryODpkWgjD5DcIur6A0Ml0CwJ4cFlpbxWB995D7u8CWEvp?=
 =?us-ascii?Q?lRsqu2C9HLiLWsGdkq5TfZFC76vrJti2mc+hDO3PHrUv5+ssucgrb7hQZ7Bq?=
 =?us-ascii?Q?d09jC9WflAZjOny5biMq15zDuKE9NqLhyV4398KscEtke9AqNAFxu9No+WKf?=
 =?us-ascii?Q?UB6iT3OxZ3frCE1luCqUfE/YMylneAacDJLjKHtUqwN1fnKPh94kyseEYlyO?=
 =?us-ascii?Q?yBxDd9tukpzPoNITftCK4FfdrZwzk84ZpkQ9IrAillLZkkttzvH+PgKrzOTd?=
 =?us-ascii?Q?akN+Iiv1ZlXpXlhsPCyCipAvm8rd5G1ZRTg3x/0EJ02QPGzeFhLgva+QAaoo?=
 =?us-ascii?Q?o24r70fOOE/75xWPQD+03Us0iR0ZWFrih9+7Gvkkg7auQ5l1n5pYYWFcIDs8?=
 =?us-ascii?Q?ce2cpN+jkslkRJJuo5UnX0NdGbx9j8O8+KCDZ5SasfADOIlgxf3unB99868m?=
 =?us-ascii?Q?3yQuKGSXlLJQ02EkJwpDlJRiGWglemGu5zwwRdidMwn6tmZe1/XyeoI6N4x/?=
 =?us-ascii?Q?0vY3GnboiV1ywortqBjE3cWspXDuQIfGi+6MAo2FTpU9VBM5C8J/u+ZnQ17v?=
 =?us-ascii?Q?iodDGX7foS82QSSAoIDeiIeV5Z0oJ9GVh0zlGV3e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e8dc8d-c0d7-44f4-5d9d-08ddff542c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 12:31:54.3199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbGWeidV834HxgazfdRaJQDK8PRaumV8a2omaRgvnxg6rfOiEvg/X9wBC4yf7pR+lU4kTDqdfm5sEQoxF+OMOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8729
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemek Kitszel
> Sent: 12 September 2025 18:36
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>; Kitszel, Prz=
emyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 7/9] ice: extract ice_init_dev=
() from ice_init()
>
> Extract ice_init_dev() from ice_init(), to allow service task and IRQ sch=
eme teardown to be put after clearing SW constructs in the subsequent commi=
t.
>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_main.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

