Return-Path: <netdev+bounces-216391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76609B33673
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415AE200AEE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DD327FB34;
	Mon, 25 Aug 2025 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGyiev46"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA227FD5A
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103323; cv=fail; b=Ph1BfNZ7dXp6lGElbayecsoX1Dds4Kl1pSiQZtZVioci9Y24tgpyCDxzAozfdhvin4yEz0vay4hocn2ESeha31FK0/0rIP6hIJDpph2VZLOfuBaLv+ExqVwvz0GfF4M8k/YgZpJNkqjxCY2BTY/2uqaCDrT5NRmLFvGEOpEMzi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103323; c=relaxed/simple;
	bh=MoECBey9NCILz5jXFqyS2LH5LapxJtHszuuUzkwatRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sIv8+o26tvGDiYGyteHLrZ4thlvPtE2g5Rh7kYkO3oMhnDphRJ2R4lU/mpFejTzSk8QsSXms0mharoG9sDz3KlIoI1hy6rOxIOV7Mm1aCStR4bZiI/AklrPEvCHOP6npH5H/+juA0fSABLPWf+vJjH0e/l1bllS1oNBRcUeiJwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGyiev46; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756103322; x=1787639322;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MoECBey9NCILz5jXFqyS2LH5LapxJtHszuuUzkwatRE=;
  b=OGyiev4611rrwVWhk5aE5l5SKpSrhNygtJo6+4Z0MJf1A4441azLK7uC
   UgxLMWFjEAdCUAljKBZOMcvFf4lBzlCMLdEVDhRifCvNAbNA7h7Daz2Co
   4wkcFlkYcWAsDXSG8Ws6UReQztfGgSDFw6BWkcbZWFEMx5DaVSzcUGY/k
   cubVjfGzkl9xmDYxXDpRVIm8HWWXM/2GwwM4O6Noct+tHtSsLaCEYGmAZ
   ijuNYUC2xzJ4so0Jdbj3HoaNN/KMZytPYoQ5A6CEbYpZ859UzOLvUD9Y1
   xNQ0rgwoAfJH7mSQcs7mQddcXx3ftstwBYwnQgj/VqWsZtWsH65u098ME
   g==;
X-CSE-ConnectionGUID: 9yo8D7PySPeni5+A/BZ9vw==
X-CSE-MsgGUID: lkGPyRsgQfypindt23Ph0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="58165984"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58165984"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 23:28:37 -0700
X-CSE-ConnectionGUID: BTKJfgjxRuKgB506tfnlPg==
X-CSE-MsgGUID: UgMjk2LERJydQu/utUkneg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169587641"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 23:28:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 23:28:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 24 Aug 2025 23:28:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.82) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 23:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yv3FHnF7UmHsM4YP3LzHeBJNv9qmTOpKZnIFL2/85/0VFxwPrMOyecnbF1Hy7zaPeoc+r7zJHjd8z/vFvL7gynN4+8t+vCk2uIof99av2Lg5pkyRSwYGgCVXsQ6bL6J5PxSdhDUObz3rx7E7CGX3zA7VC3+1+CHmMwSxCKxGXoev98Za0nvwA6sPPKyMppQoop21pgyUNf/hqFRoS+qpBuDSfi4NqawKuw2fbZY5Wy2IPYSVxbRjl2rzrEZNIWFWbqGqNmVRAuKGWOGZlf24ftzFBl9fWA0sSycocKpXbwV2zyaewN6IMPBWyeuSUTA+1ayZdWpbF710GXlwHPFNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/z0KuemCmuV6RWjjZJrA5c2hZbQAqUOP5ofPdnWJEA=;
 b=LLdgUNVFFMEpoju9SXaxyTFP6wBF4XctPDWTsm5WFAOu1xmOqK7fhand5pQ0WUarywOT6YJa+pQ/CPp+amkPS+SutoV/1bpHPqb6+jFDT/Q4b+fogftH6i+RKtKnWCDWCprVtxx4uUVYYU36t6lUN35Wo6plKV0XERKlB3KbBSnmuQTfTOSgO1vUhrB4Tks/DnSEGOnZGToAUgxujqbMICPEtYpnTHmvcMbQngUBFjuJrtOqtagX/sfS3jfJXj3Si7Zx/Pob4Ve2JiaLSVPFQIciCJ2r3g2e74qnZWFJBccyna2ik3VVy/Un/FhU0N9okpL2JdM23rx5/3e/J3sIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SJ5PPFE5BD61D44.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::85a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 06:28:31 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 06:28:29 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ixgbe: fix
 ixgbe_orom_civd_info struct layout
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ixgbe: fix
 ixgbe_orom_civd_info struct layout
Thread-Index: AQHcAhtkKi8AT96XVkaahJhcUCP7j7RzDVug
Date: Mon, 25 Aug 2025 06:28:29 +0000
Message-ID: <IA1PR11MB6241B7CCCFAC319D622B5F5D8B3EA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250731124533.1683307-1-jedrzej.jagielski@intel.com>
In-Reply-To: <20250731124533.1683307-1-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SJ5PPFE5BD61D44:EE_
x-ms-office365-filtering-correlation-id: 21ce5b73-e87f-4ef8-9a37-08dde3a09b4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Z5IUq9Fn/9UmIsJ/HApk6PBC/ODvQc0kN+r/xToQ0ZtXakf4ciI6A4W2TJUH?=
 =?us-ascii?Q?ftfFQnZwkZiC5tRfIGEzJwnEgIKjbur3A9DHkj4T6cYyb7wY7nAwmlwKwIhi?=
 =?us-ascii?Q?m9UiPsNc2lORuU2ndbqBQg/LDj8pdL6sYgHnTFbu1rOa5XAkt4h4caQd3oZU?=
 =?us-ascii?Q?sz+FT0TJEHZuobZYywRgWEo2JkKy8B+NfABVlvDkqp831kHDAOnsArcdQ79k?=
 =?us-ascii?Q?H+fqWGUOsQvMriyIItmst8Rrc3S4j2TjZqF400JtWpRDraPscDYS6UaQx5LB?=
 =?us-ascii?Q?GXmjXnI9YyBUAaB7dhDtOxQy4BJJHs7Jfok6pbIMA+jcXNg5cDvZh+V7NDcM?=
 =?us-ascii?Q?WHEEVEODvkRPOiDla/RL+hAJPtrqLe9rDligdHvfR0e77/yQPTyqG2NTA63f?=
 =?us-ascii?Q?7l5o7aMdQz6eGzcakqJthjc2Rt2c+clkIIVVN3x9fSwBLVCwfxhbDAMSyZGW?=
 =?us-ascii?Q?HIf0BPthJaz3z1mNyj5kEA6j5LBNUVPrBVx5By2/xPzSHKSEwdm1IyHzkK/S?=
 =?us-ascii?Q?/m/eZpKUq6EatYhr3nHHsMdoSpldeIV9305b3J1L2//Rwvn7wQa7CZUr09Hp?=
 =?us-ascii?Q?WvKtNW8wHD86CUtuoRwdly+vNCZDsKOSeOL7ksVDd7m6Ld6RJ+yEKnmSFXSj?=
 =?us-ascii?Q?4LMAWdGmHqTKNToBQbh+F4MvVkW2pr3/Geh8d9CuHXTLn+GYKu3ByrHMRS6N?=
 =?us-ascii?Q?5qQ8LgL0hqzM6q+oZfx6g3ydvejmi522P/nNp+MHIckf1NNDt+JWuvHR8lFi?=
 =?us-ascii?Q?9qEcg8wKa0Bto9TMe0bFR7u0AnttavThrPfIC44Z0ykwVkP5oRxy0zG1BF/I?=
 =?us-ascii?Q?0zNyauX2y7VWe9VW8dO9NBALmR/IMQ7oVmlPb8COrNOj7NSC0RnP7r0sjXkV?=
 =?us-ascii?Q?2KcIv6IY9X0SzwDMcWrHFLYEkwXjkINdG/OHd8J4yh+JaJxiFgm0iDND8Xmy?=
 =?us-ascii?Q?cIaZ8lfkbkPP8b0a4V3YrBJZbX5IhdAcM6QtZFfKYXY+qGbj1xLCM3GnuoVq?=
 =?us-ascii?Q?Uk3oXG4z0WFGe8NdhwpsSIs3+NTO1ikrVw68J3BCyYzf8IyG2Ak2BeVzYkOV?=
 =?us-ascii?Q?mV4Qoq0nzi+vOQPvpbPVj0UCrDgfTv46Yz6weP99g0TpDOlByN/NZ3bybY4X?=
 =?us-ascii?Q?/G9dnOahc50mXpcE8FKw7rP329ERAFrDrPw9LuXgN9ihhnjH0+PE1/YFlHGD?=
 =?us-ascii?Q?85tEkZzeLD6DQuZYfEZ2e6fmSVPX9AmeaG/7uyexEMHBJ0m3vIz/oNFztJO+?=
 =?us-ascii?Q?g4MtffVpDpHZcDnDr9WEM/0hjMD24GgGsLrCc7B6M1CXUb+gJgqZ+1FxAHLw?=
 =?us-ascii?Q?xFJ4cNMFGrTKWrALzv6dfYLKel8220xA03ApGmB+5oywW/ECvV+sS0LSj2ue?=
 =?us-ascii?Q?tVNp8Xspb5OG9+lRUs6ZuoeQN7onlKHCwyumSY3COulvIvxDvID+7OnfnASM?=
 =?us-ascii?Q?fooZIgDy7DTHWYxDfMwFHmymdNAXXt+RbBgYTiWcZRQVDGDby1KUyD/CbyZY?=
 =?us-ascii?Q?rEFqlC9KDfRKu1Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ma26EcE8WRFCi60NPhQHWvSixmMjSokEJiqpD3+eeb/vvVnu6SH0saBA9NoL?=
 =?us-ascii?Q?9z2YgnsjGdiisJp2LKNe2pa7HZxRAFE9QpdlJMHFSBWaSy8/AAN7idqoHZyt?=
 =?us-ascii?Q?Mky3ginAeVM81fzH6YqElXdU1VwlFSsbCxqpsT/dW6OMDKGi7JLToEMlPRnv?=
 =?us-ascii?Q?tFXaiWfvOut2Sg1IHAUNcJtu8EGGLV3kqnKsjjBMFo7oJV2bWtI/Mvlinekf?=
 =?us-ascii?Q?/qnwlScbQEGBNtj1petWOdlAc3OrgqcCnldSloauuhALh4glTc4q3DeSHEjl?=
 =?us-ascii?Q?g39MFScAbkYItw/d+bBV08ukWUniPIFnEcFSfCHhIrMjA+QdetTFyfIwZZ6v?=
 =?us-ascii?Q?XF/i9rfex0hqxNkiLKhTcbiObq4cG8Eio6PyCOjvdbigSQpNu1mi2r+amAUl?=
 =?us-ascii?Q?FfiNWcee0dW6Lc1dlV4FykU/u1W4kNkQVjCr5Oy8q5XJOYv/wQ7JPdD3o5I0?=
 =?us-ascii?Q?7x75Ex5A2ktKv996tiFn397Y/K3cPcgyDTA1FRstHtu278NJ3dtZvGsnbuMa?=
 =?us-ascii?Q?TTdL8BjAiFRJwL2IQtyVF6TohHdrXxt+Q+qydXXH13Cd8SMA2bwhW7ukFgsR?=
 =?us-ascii?Q?zpMut+Twga14JHruzwhb9VoY6/jdwOtu0JQvcT5dVIxDYglZoCZ0Jf4pRE5C?=
 =?us-ascii?Q?AnweupWclE6rU9cKAc7qgwfFUoGSoqVCwPqnrv56/uKbWnZ0gsnQtuFMDRir?=
 =?us-ascii?Q?NDtP2ggc05/Ycl6JCHij/r5TjIQ09pDwAKuRQHeRfUzNc5cTfmcDJDq2U7FS?=
 =?us-ascii?Q?zzRBeMRHT4RxA7TyHyhwn7VII2EjnnIVfYF6zbJIZb6ZISuDOsfZlREOPmS7?=
 =?us-ascii?Q?jZBP/73tDf1Hva19+cpGNO7uHwmy3K00wVwb5iCLl7vpEClX7qba30Q1X+oT?=
 =?us-ascii?Q?nmYO10YWyij4K+nzsQ7GbR2hAWZJ7uePkMy8BaWgVo2lE4Z7TKuq6piBjFBx?=
 =?us-ascii?Q?YFTfxcd7XDj7285vI7XugewLLYwg4DujwgWFtfeX48Z6KTceVZ2Wr2Ropm3V?=
 =?us-ascii?Q?hZ8//q3pl0QMQ4b8IqgrXGIgg5iU3/qcAZoII8+8E38LXnZopLW1p6X5mMf9?=
 =?us-ascii?Q?93yJG+zwlQeiIxoO7nDPGH+VXCDqX7WqjbH6cDcbznBgw/Zx2ygILXPQqB/J?=
 =?us-ascii?Q?xyACeIHlAjGFmrq23yKYNJn5OoqfK6SOnSrqII0R/eMSYhPW9pA+46gU9id7?=
 =?us-ascii?Q?nzEGl5vFa3VkuKNNunVpOq3gBt2HFbIy8qvPmKrXPHdLtst2/c7qWt7Igy7Q?=
 =?us-ascii?Q?z7fDFDaAQI+2beT/BcSc51dwJRgdKydZmCmTMr+XBSYgPL3261czq7kPSq67?=
 =?us-ascii?Q?vtLrihKShcFrD85fEOLUJ4Nm44cci9qZ0Z8TpsZhLoJJOT5hbpgzpB3OSC+2?=
 =?us-ascii?Q?gbe0c+JsPFiw9yNISKa1Os1aGY9ZV9IkbxX8TPgJ9uuBNlUfljyLqrCAzs7Z?=
 =?us-ascii?Q?xieYWqMwRUEsfzcYi+V93WG7Id1Z7kh0cnTqntjx7IhF9VXO35egJgK2jc8K?=
 =?us-ascii?Q?B/BbM6RRxxq3Qv5mTrENMFjtIWDHmu7n/0YXzToJb3dKm7+OErCWnBvI/Huw?=
 =?us-ascii?Q?kTvNqhqhqR28paWqc/h+xGVuJn7bcf1v8jcdHS8b?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ce5b73-e87f-4ef8-9a37-08dde3a09b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 06:28:29.5775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKit8DibG1czzZp5hB+908seeVqLCJdJDiP5iNAtg7mythg5K6Yn/kqnoQ9qj+QGZaM4qqBW7xtZ/lXueHtc5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFE5BD61D44
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: 31 July 2025 18:16
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ixgbe: fix ixgbe_orom_civd_=
info struct layout
>
> The current layout of struct ixgbe_orom_civd_info causes incorrect data s=
torage due to compiler-inserted padding. This results in issues when writin=
g OROM data into the structure.
>
> Add the __packed attribute to ensure the structure layout matches the exp=
ected binary format without padding.
>
> Fixes: 70db0788a262 ("ixgbe: read the OROM version information")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: use get_unaligned_le32() per Simon's suggestion
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      | 2 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

