Return-Path: <netdev+bounces-113455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C493E771
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 18:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0200A1F21FEF
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 16:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A35502BD;
	Sun, 28 Jul 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/qseVZv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87CC383A5
	for <netdev@vger.kernel.org>; Sun, 28 Jul 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182627; cv=fail; b=cNQ4tghqH0CkdwhaXHPXWb18tdbhi3jrrzfnkyHaRib8p0IET2eFSJXWa+bD/ePlgmtVqzwzpsik/8FOcT7O5qPSWf62n7ojH0wnA+ioNUlCS2Cq2l3dNfN5cj5OlsuMPDjqQQPKCtWr+X9y0i7WWa2gg9UZHjLsuDkMhk3eLjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182627; c=relaxed/simple;
	bh=o3gJSctmkU/r5QZwaQEaAniUWPl1sKW+9MtkVt5psrM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eAJEC40zgc0zdZxHey5zdfX6S2K+0mFtUOSFV/7ia3ZcymkiGMqeJu+pNWKC7tjV6g6gwVsvZOuQGN2eLfeIrGZWyquWR8Shh6YrOG/wNlHNfjZPlpaRQ4TkDOv08Oh7iIdJOBW/TPXrowSZjm2t87rtTBXw+34GkxHC7/yTkcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/qseVZv; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722182626; x=1753718626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o3gJSctmkU/r5QZwaQEaAniUWPl1sKW+9MtkVt5psrM=;
  b=V/qseVZvWGbbSYdaCNv3q2jMisX4jewwaJE2vnrfLW4bpsHTBFVrdJ4V
   FeSuk2cUBvYQYWmrqO42wwV+sjpe5aXt4MGG2ZaclfmVhkbheGOy7eBEO
   VwqHejeitdAgp0sYMmhBYxv4Sj2v63UeqXRZrASieeKrcafsv4S2N8TCE
   7TWBUe3DpKFxjZz/sdvDKYNBTWPqUC6ziY3gZJnf9cRL5pODZwzBstsds
   Er27JrF+X1UcO6FfMgej52Bb0+GVgobZOTJOP/1al8/dcmUowvvk+68q5
   PKU+03ODSVAZPZS7xbG1ShUWVRHcIJc0r386lQqXn2ikgac/nrWlbMXSt
   A==;
X-CSE-ConnectionGUID: 4Yiq6mlXTl2vI3HMuj5YGg==
X-CSE-MsgGUID: KlKQl3CkRJi94QtOQ/j8lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19804898"
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="19804898"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 09:03:45 -0700
X-CSE-ConnectionGUID: rNsR5PWyT7urD5fTcDP4Zw==
X-CSE-MsgGUID: L0isKV3nSfWANCeqrS6ZZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="53645602"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jul 2024 09:03:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 09:03:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 09:03:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 28 Jul 2024 09:03:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 28 Jul 2024 09:03:44 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by LV8PR11MB8533.namprd11.prod.outlook.com (2603:10b6:408:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.32; Sun, 28 Jul
 2024 16:03:41 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7807.023; Sun, 28 Jul 2024
 16:03:41 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 1/2] ice: Fix reset handler
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 1/2] ice: Fix reset handler
Thread-Index: AQHa1s1uXBlOoWMP4kqH+qblhdL54LIMYXBA
Date: Sun, 28 Jul 2024 16:03:41 +0000
Message-ID: <CYYPR11MB84299EF1F015D333C168C7F6BDB62@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240715153911.53208-1-sergey.temerkhanov@intel.com>
 <20240715153911.53208-2-sergey.temerkhanov@intel.com>
In-Reply-To: <20240715153911.53208-2-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|LV8PR11MB8533:EE_
x-ms-office365-filtering-correlation-id: af1eee5b-7c3f-4ef7-f60d-08dcaf1ed986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0liHZ0qiuDffRnsbhbqc7YR9J0XqOm1VBuEGEh63xAGLcnu3nlUBXs3iO9Hk?=
 =?us-ascii?Q?SRYQrHNey1lt/acvSPOB5TJtDdwax2OlV9aXx6LG/a/FunXDzVOAabZPRQKy?=
 =?us-ascii?Q?XGoY1mjfljiBtPfRnTPCTLNvspQjm1yGp947plW9HEcFCRWWIc7+E9bBpTO2?=
 =?us-ascii?Q?ihUFIXdf1cnIdnOXvD8B5sC9FXlL8QwWBUwoMT1pNspu36P+Fe3zlJbh5OaZ?=
 =?us-ascii?Q?jxYeSop+vd5GWKYIZaRsWxpmMBTOJGim35mMxPQFS9/8DckpaV8s+xtPY3JA?=
 =?us-ascii?Q?U55XAC2Dgz6hvrBMkJkDCMfbuCH5/NlNoejTLrY8lvUz3GoRIRYrsB9aQp3E?=
 =?us-ascii?Q?uy1LNC7n99qbWdmtb+/jWSq2xwBCM1sSvrNlNCfAH5zjV7lNM+rqdmOL9R3X?=
 =?us-ascii?Q?p+1py077iA1ce1uX9hlcZa+AKg/jNVcVDkIZ6HCURSrNUsePbmIg7ZsS0/+p?=
 =?us-ascii?Q?UulQN0cx914WjxQLSTSLaBdx+M4rKBTnvC/N3w7kLTwotdx4DtuLUvc+lc4h?=
 =?us-ascii?Q?ir2RqcKWJdu5791VbYHfc0slzvU5W3KLEBQGm0taoa2JvNZTVEmglrZ71gIh?=
 =?us-ascii?Q?kMTsAheSv6akablXtwXkdXliO3vQXSYHkws56/UbsHHQBJc0XX7cQZQBJ1um?=
 =?us-ascii?Q?Y0idq4Q2IWrAXikRRbI0nDd5/1Xy3XDZXfp1hsgAE8zrgeCrLomp73oX1PLn?=
 =?us-ascii?Q?AJ3/S21AlmpAE8Hrwr270aWGGsvasylZpeyopUCtke/MyvxWFgeY1SUimuLk?=
 =?us-ascii?Q?wZiMY2wObqYTRLMuo5dc55DDwbmVBk1mK19+eAphZYYTHJ/PH9u6wwZ6ciV0?=
 =?us-ascii?Q?1unQX+Frs+/KJLj8Bdq+zMxCu2gbeSMcyY3PxpAFyqVNjFH6ZoFzygBY3ie4?=
 =?us-ascii?Q?5yL4nm//YF/LE5gqnM7/f2WuDlggOLtd/N81dgX3OnDx6o9fx1c/Bi3l4p2b?=
 =?us-ascii?Q?IjjVHJBpeqoHBsBZWa7m1yBiEw5TY+l+tqqy2SKY6EeKKlFeKp5TiGs4wiuU?=
 =?us-ascii?Q?+IJxozmc7d7Z2Rduiv69nmKMieFhvofdsM8Z7t14pOzywhYyjwt7lzyK/ZR3?=
 =?us-ascii?Q?KXHC62E4GlqEZAQVPV9KoxRI+Iug445XhAKLJunVwsl0Akk8ER1k3zjJSao5?=
 =?us-ascii?Q?uf5CkT9PMKO7kiqtNsJZ8E9o1YfaQFBghtD0Q3oIqIVAmnjYEB2vuvpDY/oW?=
 =?us-ascii?Q?DM1Xrh0eT2OoUnjYvZMpN5dkYrAxaN/MF3zeGbn55NEkH6wjKRmjj5y0vYWR?=
 =?us-ascii?Q?KfXcz18fFBT9RqPLwi+cEG5fburHVmiUk626N6AbkLvqQSS8/Eaeia+6Yw+D?=
 =?us-ascii?Q?uyPDyJ5uiFfP9LVTedrgASZFni3566Aso3cQHmlNZPGLda/yBkDYgih4VSZl?=
 =?us-ascii?Q?nIkAcIPesFkRVZ+lP7vXIcNGspr+tzqbWnk850GgiLzT6h4tYQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K1ThO6PtEw8GSuim0U4UitYCGEGxG2BvSllanEsfDetDYCGgrvhs3SdSM0Kn?=
 =?us-ascii?Q?9RYAFyhbkHudxapYdZ+okRHEy/RlyIpFto/KuNtT3sWZ6vkNGrzd6NDBfXmq?=
 =?us-ascii?Q?B+TRF09rDmMzb761R5t5HsIBa1+EO/SOXxHJWliDQGnqlknrBlO/kuvByBDf?=
 =?us-ascii?Q?PddE+Hzq1N1pc7idrZ0v3Ffpy/lWNSTA6Us+hRCtbp0XEwGw4rOvWbhvoVu7?=
 =?us-ascii?Q?FefuRc2KHD/DVv6fQJ+tFgSUhuTjIwE1xFRZ6gurs3VqsBQjLooBD4vDPdtL?=
 =?us-ascii?Q?cHrZoVCLFAMXHVobSO4BERGsw6M1EY4MQp+8HI/UC6L6q4jXZAsd1wJuRCSt?=
 =?us-ascii?Q?JiGhrvGWt8gZciM97CDaCROZ1csLuB4xbZpFMkfMKySrN4kdaYXjweBiajah?=
 =?us-ascii?Q?RwNYtfxs+DE15zfBw1AHm/oF275M1rYv4iP8rrVHC4BNKLzKsSLc+KDLWy38?=
 =?us-ascii?Q?sMkRpvl+tFIhyDomfEoL5MjRP/MA0l/38peWwM4jhyXoK5x05P08Jaoiwn8w?=
 =?us-ascii?Q?RoBgCZyhiqSaUzBBAQ4LVK/AcjKGU42ymb2gWO9glGd45zyi7mmybICjFOAb?=
 =?us-ascii?Q?NqvLWioYDfqEo/XIde44mvuhDD9XrU4FqrUbE5A6Wlt4kwMEfuBURcgFXUbQ?=
 =?us-ascii?Q?B/Sn+HRWMGEYpi1UQxzFaUisWtyOommKGpOz2ernG680snuo5KqNgYG061Yg?=
 =?us-ascii?Q?ZVW1UCwlRVG6scMwg4FGgTiBRDFNRycyhinHAg4rNbzwR2TW2tWDfnyTXH0/?=
 =?us-ascii?Q?y0wEVomXfxSrhmWCxf1IWOifTftVeFaEPmPZEiRhNQGXJfpVrITZ4ZFPhHuJ?=
 =?us-ascii?Q?l/tVgQe76sT8mzZ/utM6AO9b+7tzAuDAB9EbYxEiEKOkpeZIp2mFdnraIB2p?=
 =?us-ascii?Q?gbEbFno9DPLua5pQLlQN5UyMFRAFCjIJUEsQpZ/wtWRq04VWHyZebwWLloa0?=
 =?us-ascii?Q?Co+2Hw+Gf68AWyhi5khQPuDc4avZQPnnXLhE74qsX0/FKfaqG7+ZnW2hFzjr?=
 =?us-ascii?Q?6yOrRolx+GlZNhkl/Z7r5l9tQo0nCtJYE5az/zzwk37FypPWxoRmcEiQBOOC?=
 =?us-ascii?Q?CHA2hPdlMEWYbs3vN3+QtDvSq6uxZ4F1l3pHL7yHt4HZCU0v3Ang2YctqRt0?=
 =?us-ascii?Q?pvjlTuMSlsw0ipy6d4y+o8D74GB0F5iNrofe2esRIEggWXJzGX+RZOB8uoGK?=
 =?us-ascii?Q?v5w/NqV9V5M1UtIuBwMj2CyoRfHW9F4KVciQr1Yr6QV/wHVXQ8iwrBP04cCu?=
 =?us-ascii?Q?dE7spd3fjBjX7rQh6TZFtD6q7SwXxvKy7EE41xyDXZ1dsgqlHYEa5TsvleJJ?=
 =?us-ascii?Q?FcZ3iwKSF7XFcgswOjXd11sLkpaFQQClL3O5sLFJtcjRciLESzabHuUzTuLK?=
 =?us-ascii?Q?aaXOYSVnnTwIWt2XQtEJYyr4CsyfTX/bpTQxKCzTL1ezpHMhdVt6B248yBqi?=
 =?us-ascii?Q?GXHMsE3CdhpRHoeKfJEiLKfR9WIBrAROh2zqB4PbKbyS7Ei/m0vU4eg8ZPgO?=
 =?us-ascii?Q?ieM1KuFJw8gUvQu/AAYFb9ezgI5J1J34G53IpR/t4JLUR9/mICOM2uBGf1lf?=
 =?us-ascii?Q?VP+9FoQ2MsyExcmVEVsrB0qYLISkzzNrYdvFY8cMH3xUy4y3pG/XtHUxZnhB?=
 =?us-ascii?Q?Pw=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrzfhrSWx68EVJLIh3AJieuBsPanDVkrdcOjFCezhbPQr/KBK+Wob1XACRt/w//DPpJoHqBdpBoM/22ymA9XIfnjL5J0NH4Mz9eo+hfHVvJ9dfcy9XHsvLwEFXaWYDhEP45F63nBBqr2N2J5URpkbDJwwxvPVLV8krgk6b/ZZms44aD53GlP19IciDNtStBfYV2sLVs00fXd6u52D8pk5yQVCfS3lpD/JNHQkYMF/253IAtp0Oh8Gu0Nyz+Yb3sTZM9neI+QahBLsc05IMc0PQ5XJ2sxq8B8S4bvzHHGU/em2MhCedNP17tlM2QGv2aVSBx5Czjvg09kHcs4iLJbUA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFdzvCug3LHhi8kMQUwfld6ngjtTZu6fYa192yq1tFg=;
 b=qjXMISvjIINKDKgxam18f0ajntzldUhleKnPsLGk2otSzjEiN7Kb1fVuzOHRgp76TOOpCx6LkyZ6RqIN+cfBV4f77kId/saIplvrEXDV2vCJhkCMtcyBVQykZv19U/gA4qZuoX1D2Z/m7+4j4bqFw/KR9iWCh0f/3gGncGI1oT4IEfhe6zxLeIJ6Z64IhkqpKmwlAwdGUsrBrxOeIVZc+Zu/UT1Lyxese2zLTjFDEDfn5IEAD0Ie/fsgWHnQNHVAH+spGV9Hgdu0dOWyQFjBoUdZ+r+izme+lWQWlWhi5a9TYxIQgsFrRmBaTPY/pCDHbeOcWLDkn1nZS4FxZYlnpg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: af1eee5b-7c3f-4ef7-f60d-08dcaf1ed986
x-ms-exchange-crosstenant-originalarrivaltime: 28 Jul 2024 16:03:41.2815 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: RugVldxv96Odgxw5KYg1A6S8FsgjKPUWbSdygwGim7xbPAsDma+O/Ph4GnuOzaW3MPGc7U4jP+RPBRdwavcOqs3USQPsuah11SEXgxdtfH0PnvoZPWqFp7yho30B3Cqq
x-ms-exchange-transport-crosstenantheadersstamped: LV8PR11MB8533
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
ergey Temerkhanov
> Sent: Monday, July 15, 2024 9:09 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>; netdev@vger.kerne=
l.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/2] ice: Fix reset handler
>
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
>
> Synchronize OICR IRQ when preparing for reset to avoid potential race con=
ditions between the reset procedure and OICR
>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Fixes: 4aad5335969f ("ice: add individual interrupt allocation")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



