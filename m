Return-Path: <netdev+bounces-123607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AD596592C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D19B1C2148D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A6168C33;
	Fri, 30 Aug 2024 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DL/DRixH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2000166F30
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004547; cv=fail; b=aUvkhyxCCu9KkENQtaa4+Ge728dbSYY0i6NC0IjyJ3WglDV3C4c6bFy9FhC246cKgyx/h75/hnDcrOI7+bdLJ5VydDzoG0MbP3BWZR1lL1ysTaxgCynwsENnXgCpDk8QpG6hNESIvml4xDenK2642XlRNLt39CXlDSiG6A8RxDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004547; c=relaxed/simple;
	bh=FMWA+kZFxRNP26jFa3fNI/C/DSZd7R2PuQJAv1tJVcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IyiJ464G7jii8VcrtJ56Ro6/nC1hlfmIT4n2MfjUpr//Xu7I1PW39ZGIPjATxj7wb/AYEP7CLo6poGXsVKSKxDOs5j7d/+ihLgqg9tFjbmirFGjSsQDSlYVsygFnPQu8OH0YdOf4OZQ4SruH9Ip+xLlGstNrbfLVWs10OMuPwbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DL/DRixH; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725004545; x=1756540545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FMWA+kZFxRNP26jFa3fNI/C/DSZd7R2PuQJAv1tJVcc=;
  b=DL/DRixHhcYjidlWaRue15k41oZLUpMgrhYEjrYxfhtHeEXvPxKDPwnB
   05zIwGXR3n1LR+owhRkiCyFwu/udTuiCp284BBWP9vroBN5wiPiVApNCA
   QyI8nuNx6GK+R1dNjm0/w1dIzkPDwauhT4WIFbbIS0lf5NwnNqYaZ6Y7A
   u/YDiAaB6Txyj2lPVuukiPpDji4KFg0hw9P2z5e5fumTEg6gcYLrBUnoJ
   T1CtlQqF0DzjwqJ2M8wEz+UeMn6QxYnsVRJgmZlaBdgzrUKhmVpm1dUrF
   c+v1Hs8F1D+BkuxwvHNF0IZWxz7bE+nh+I7zEow5eOIO4W02Qn0UGBVPJ
   A==;
X-CSE-ConnectionGUID: beoa19txQluAIg7WIlDd2A==
X-CSE-MsgGUID: GtmTI0DBSLOq7cfuvid3Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23819938"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23819938"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 00:54:24 -0700
X-CSE-ConnectionGUID: 0De8hmN8ShS8CvK1SK2EjA==
X-CSE-MsgGUID: yVbuIl/WRumAbVz5RyaKqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="63820626"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 00:54:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 00:54:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 00:54:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 00:54:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 00:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIiqXm8hKgKxsxZvmHn+WYGLMbHzwNdWnhTmd7lm0ogqAFVAPrHDSypJK3PUEgBO812M9qYciE/D1BmQdWmzooCIQ8mMnMEWakZmYz0f8qr4+8V4kyL7vnxAdPcIHvphVrhV2aXSAkS1ZM8ttkSuhksmOu6iRTc9+9K7ijEjUpaEgH14RTT5OZPeab1tcwLR58k6CxeDCZan5QSW1HDxN9OKy1Pfc/H2oNz7aROwTWQ/rpcOgb8E/tjPUAlZFmLc6gkKRnfCEPGlYE8fs2xj8sxR71xsfCL3p+j3e62Rag780r4gxjAlScr04/AvHbyOgCIMP72g1vM8WUDuOf9ASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Pc2UyS4msjWPGBCQFGpqenvWeJHopLXamU1fADqbhE=;
 b=AnlYG63zjOKVJ8mHjdDCHRQ5zbhfOnR/KylM5yxB65RrzdqVNpx1dFw1qFBx3NNaqHa5Zs+N0kOROKQO3uivnOrbm7bMBjp5nfHTMT+q/BZaitsmt6CPvPBoYSosabUPQ+EfSuBkiYjiMzKJ2lx5R+OPZw5whWxNehNp4mZgMosEG2eRcGIOMmQ/iZoMoctiUJanKHcUt96G+c2VUUbqMtjoSHIQZvrl7bbVvcywDSdmxgr4xnLo9dvWZAd1g+xy/4Zka1nKcveNRLxp2XU0SX8QRR03R65HSh7M4jt+T2paYpW9h43vFrdwv0VpbDjIAfs5FkAdNExv3QDXY9Lr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH7PR11MB5864.namprd11.prod.outlook.com (2603:10b6:510:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 07:54:20 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%7]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 07:54:20 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v1] ice: set correct dst VSI in only
 LAN filters
Thread-Topic: [Intel-wired-lan] [iwl-next v1] ice: set correct dst VSI in only
 LAN filters
Thread-Index: AQHa8iCSI3nlarLwHUOhwTUdWRgY87I/fy7w
Date: Fri, 30 Aug 2024 07:54:20 +0000
Message-ID: <PH0PR11MB50132B1B6A58E0B103F265BA96972@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240819101401.67924-1-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240819101401.67924-1-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH7PR11MB5864:EE_
x-ms-office365-filtering-correlation-id: 5b45233c-59c7-4012-c5fc-08dcc8c8f4a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WyLRlWCPKjI1KxmMO2YfmYnMSusR8JldtpDnaBdq+pLTtNjdWmXxKm848TqV?=
 =?us-ascii?Q?BRmBuV+Y+zkmhaffbTem6hd6FwBQizgTuA1yy5e+ekxyvtXEKQX+B0mPeDQd?=
 =?us-ascii?Q?+Zh8/9K1YXRd2EhuL0vyd8uGtESIebmH6rw8mtzLtGFUV/ZoAG9/JNREO7x1?=
 =?us-ascii?Q?Ou86DduH3cMK8YPE7bA6Avatl98JftPM5D9k/OxXw+PQpK0frcwc72rM8AKh?=
 =?us-ascii?Q?azQugWfy87Uv3GGF9BCaZaeyUX7ECnERbLkS7n5bF38mP0ccw/pzwGmIiYUX?=
 =?us-ascii?Q?IfBHyQPK8EEYBeykTZVDkENss9uPlBVvYFcIhV7uMmdP2xXVgBCJuICwW1GO?=
 =?us-ascii?Q?qGeTj5L6YA27fxdcXyh48CRmUFvhNVj69QgPhO5jVb/UQXWiX496hQ394FFH?=
 =?us-ascii?Q?qrsReMoYW5SLWQNCe31rW+M+AGnf36B8f6Nwz0gA5RLzhtZq4aXQNQiqfeiv?=
 =?us-ascii?Q?OcgaPPHwAf3z5dgCfw9EBVen961ScQILXlX6gq8/OQ1jVuccqKIoU0UBK+RH?=
 =?us-ascii?Q?liqz7sIG2xa7J3a35TjDTMpwxa8rhyo3QrRouKenyf9cmILrpcJOjmPYebFm?=
 =?us-ascii?Q?ug0VKbf0Q88c/t9ybKv08HwPWSPLeaHEsLz+HtgDb0d72hu0WYV8suvba1Zo?=
 =?us-ascii?Q?lW8HhM3fPtkpvjngHUgjV6B6qcZhZmf5OzE7ZNB0yJfMFMgBm5mKzCdiEviF?=
 =?us-ascii?Q?QlxHZll49Sj+NTv/vKnorz3fdBcmAkQPmTevY9Ox8wHQM0f3ZuJMbz6AQGLJ?=
 =?us-ascii?Q?3EdEs238WnBmBzCRdL0KGRHJY+EdY5jPIP1RPFTjD/Tqg3QCHYgoKncAhS+p?=
 =?us-ascii?Q?tD+Lb12t9M2/xbs91I21aGAWD4Iro2tXcoLSznuyCPftytpZD4OZ8Xi2NP0q?=
 =?us-ascii?Q?XA0AWxpjy8SmAZzeAE/K5EJaozp80C1xKbdmXqcNV44xHckqTLWX1m248fe2?=
 =?us-ascii?Q?OKD4ClravwiiqhunrEyuNBY2mko8g6TbtJefQVQTM2zQS+UQq9s5mFOtbzs6?=
 =?us-ascii?Q?xc3PsgXzfrwyCPR51mprNYH9pV/hesowBpn50YwZndVQu8+5vfRjeeqdaYhl?=
 =?us-ascii?Q?d5WCHL1h+pL/+m/NkhpiI2NjIwoM0simcfSPKOo6pGQJvoqRIxOytBz4QBk/?=
 =?us-ascii?Q?XfuBYKKvrQD/6vBq+zCCj00Il2L06qkshn89/3BNsvS1oC1TZUwP7esusEnf?=
 =?us-ascii?Q?mJZHPkLWOHBrTY8NS1eMOltD8WI7X2vUXrXXdtM4tyX6yq6EHWtzi66C3STJ?=
 =?us-ascii?Q?P6tUbofOBIuomO8f7AVUxXVOBolbVfYXlVFuJOypg70CbzfClKlzd6QzTz7z?=
 =?us-ascii?Q?jZrvUAM8Sug0cM+GKT+3Lepzvd4dt5DpShR/aOB37EqLh129jZdLoU4DHJbM?=
 =?us-ascii?Q?8ZqBIPeLvV5pBg3L4h1WIMNHdDkhCgazdFTC5VVFoGlEV3d87w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bUs/IfEL9IbIThHTpjxT47+f/AAfHyduy7m1k2dp/Mnt3HvCOsZX24ZW6czk?=
 =?us-ascii?Q?A6yZmU0k/5wPOUJskL9wgmzVCvfNLaTDqHP8owmKNBBy9Zs/G/ghmI7zu/2l?=
 =?us-ascii?Q?CA+B+/69rST+M5oQtV/TA8J42/TpOSnj3BuNUojKDIJaI0koFZF66B/5x48M?=
 =?us-ascii?Q?29K+GcNVUTcVO4iWaE1BS2LkcBAg1oCKl1fKxQ+uuh7zDqHW7Kg4Vu4Rlo0b?=
 =?us-ascii?Q?dfHus5aIQ3AIoBhPDpgL3iGimYLvvmRROx3TQG2eLHLE8xyeICknW+1ZBtCP?=
 =?us-ascii?Q?f4Z9nAASalx8qNtxqu06aPWj3eUAke8WNxwQAgShd0qkiN8kSga8qc2NQanB?=
 =?us-ascii?Q?K7bBVSed2dIuD59xA8STDTjH+xw0Fuc8rVeHmNT2dGPE9wp5W6HkyHSuvCso?=
 =?us-ascii?Q?U28j3KY0C8yViPo/zJaLCZc2HdIH+z+dANJbkqXbVsj9zT1EoeQmwxxqR223?=
 =?us-ascii?Q?zRiLyw4N3fp4IhzqhD1RQntyiBSVHusM+zVwWAbbggbRpY5wgCgsvB9yUImy?=
 =?us-ascii?Q?hzHQdCZp23i2UHd2aKbHOeFVsGza2z1HaS/niDBtXkyiDpg9Qj8paqZXzrUh?=
 =?us-ascii?Q?x4VFy8kZQqaEgJl8dnsBq/Ke8dushhCx2coQHSWBHblDIXxnO8knmIpyRjBv?=
 =?us-ascii?Q?Fl6Qe5MvQce6kZwBtYFy+cJkS9oMaSnKAI1Jy8n7ks1ZBQ3z35eUl7YnH/Zw?=
 =?us-ascii?Q?N1HYAEuo6N0KRdzsPWU//4vW90q4yummThnarW1BF9dzY2eTqipzTNXlWacJ?=
 =?us-ascii?Q?pDMp1HSQ0vq25dL+wTCfSSsf3pPY5SyHe/ShBjM82NlDYzdE8TBkA7/R1xBT?=
 =?us-ascii?Q?18dlyBymfaRR0UY7gnZayOUgncg/FvDcLrTy4LZCX0aR6Z2lQJt6Uz7i8Cqn?=
 =?us-ascii?Q?Ftc88vV0jYtaIHHGPixlVqjzOnd2tj3UcnKSfahdXmHPLcGuKRHvpKEtUSzW?=
 =?us-ascii?Q?p5bfXT0RYNGDYDanzCv2cR05EuYbxM9OlWwCOMzVjnD3u7oaZO5WBspokSr8?=
 =?us-ascii?Q?3R50nR9LnGp1HUmG7963pLtyCwd5rHu41tIwHjxMDCKMbl5M3mn/6ntmyEYw?=
 =?us-ascii?Q?X77KQpiUYwo49aQmkb5slbSfXNhJP4kXwJFkPXFFqIYtJ+QGQKqbg4VkPb2v?=
 =?us-ascii?Q?PJMnHoI2M5Xr4GXlA8X3x9im3r94b/m69gF1igNMkJdG5SEhqh6avGN5GfMX?=
 =?us-ascii?Q?2a9kMOtn9x/Oom184FnqTU9BbVgyksrVJMi8mb6wd7gmW/28vsORdDKGIwdk?=
 =?us-ascii?Q?UFQyM4gjQ9/0cfsr810J7VT7BulxoSycsX1hY8f12Z3M1BlVJCtBCpSBeCnj?=
 =?us-ascii?Q?dcN27WUgDCoxVrSscm5rkVGyX3gtw/eakTEhBu0qaR/lWXBxEGMx5q19FijD?=
 =?us-ascii?Q?J8MDjIaemdDbWK6jyiFXGNypkOgtYe+8HJEMwQaclJ3vCYcc9wbfzWK2ccLn?=
 =?us-ascii?Q?zJ4UTWFEiZFvQIi86VhZjKJgGjTaDC87Jv1dl7hQangnOzGzajg0r4n1XHj7?=
 =?us-ascii?Q?72jwpufjPk2MvrxGFVDvnqPCi6CYFSAeM49anZ4bTcu7pIXbCxolNM6U1HhE?=
 =?us-ascii?Q?gv2J4l0xTjCoAdAG/3wNg34bQ2rU003wKkiOuara/Zgmsaya0Wl3F5o/tQMn?=
 =?us-ascii?Q?dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b45233c-59c7-4012-c5fc-08dcc8c8f4a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 07:54:20.3073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSHGrGg5zoVcJNiqzgTFrGwUrYglfmSAuayTIC/WmJckSQtfthh/cSRfEyB5PmJZyjfnEBE23ZvSwenL5D/qafw1wzRppmFeYC9bNhbSz7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5864
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Monday, August 19, 2024 3:44 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Drewek, Wojciech
> <wojciech.drewek@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [iwl-next v1] ice: set correct dst VSI in only=
 LAN
> filters
>=20
> The filters set that will reproduce the problem:
> $ tc filter add dev $VF0_PR ingress protocol arp prio 0 flower \
> 	skip_sw dst_mac ff:ff:ff:ff:ff:ff action mirred egress \
> 	redirect dev $PF0
> $ tc filter add dev $VF0_PR ingress protocol arp prio 0 flower \
> 	skip_sw dst_mac ff:ff:ff:ff:ff:ff src_mac 52:54:00:00:00:10 \
> 	action mirred egress mirror dev $VF1_PR
>=20
> Expected behaviour is to set all broadcast from VF0 to the LAN. If the
> src_mac match the value from filters, send packet to LAN and to VF1.
>=20
> In this case both LAN_EN and LB_EN flags in switch is set in case of pack=
et
> matching both filters. As dst VSI for the only LAN enable bit is PF VSI, =
the
> packet is being seen on PF. To fix this change dst VSI to the source VSI.=
 It will
> block receiving any packet even when LB_EN is set by switch, because loca=
l
> loopback is clear on VF VSI during normal operation.
>=20
> Side note: if the second filters action is redirect instead of mirror LAN=
_EN is
> clear, because switch is AND-ing LAN_EN from each matched filters and OR-
> ing LB_EN.
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Fixes: 73b483b79029 ("ice: Manage act flags for switchdev offloads")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

