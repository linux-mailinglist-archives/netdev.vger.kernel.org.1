Return-Path: <netdev+bounces-276752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBTiG7no1mm4JggAu9opvQ
	(envelope-from <netdev+bounces-276752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:46:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C07753C4D50
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32C683016EE0
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85152337B81;
	Wed,  8 Apr 2026 23:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MM0YhD5f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CAA25776
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775691958; cv=fail; b=Q+6K4oNvRjksP2yo8AeBSNQcTo9mbSFiTjD7m4Wv+1vgzen7YZ0c2Yyu5jN/AoKEXOPsZ3QVnnLOUAn7Oxd9pSPPPR9jT07gMYI0R6BKSpRXIQCMqFyLmEGJsK8hqLQgwACh7Cy4ry09S+v7dO5iNf6+Ztrd6cndPaJ2x8cfLpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775691958; c=relaxed/simple;
	bh=AtEAgQZdmc9AGcoVHysWLqKXLRvsGCupq3zX54TihWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=unXJHMS7Kk7zngkH/vGICZiqE27xGAGdHVpUw+vu1iaiWQxfkbCRm3NpptSPDsh1kAbFIukWopBGNANNozMswbz6Uvoe19N0gimvXT37C2iRa1ycvruQcBBaZpmpaFzlMry2gINnGwQ+PpVR1HbWwI/PXGMR8gm+tH+1RauYkjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MM0YhD5f; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775691957; x=1807227957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AtEAgQZdmc9AGcoVHysWLqKXLRvsGCupq3zX54TihWc=;
  b=MM0YhD5fk5E0iGyrF713KtbVBJkzyW0QC5X5UqEYLebIDYA7AgUjcCFc
   hsXtl9tgMsoASBihjaOxSsoCfD2MgHgsgHCj24Zh9XyIScWw5Olge53eH
   eVVeA2cqKyCom2MpxKqpYuqJS3A08raSGAek0igmbbLHZFZf0MHPzB9Cl
   SEe0l3Z/fmYhuuUAPH6oWKISHUXQOchwjqt6/M1Ad9PJHl1a+pO8hQ664
   THvooQ1T12ojBkeOnZSYeHfXYYNlgmIkv6o9qMn8u9boguaAMs7NPuVQy
   5mrh99QMUxqbJZVTbq9H6+rWFhbj296DhmJk5ly8XPCGIPZs03oBbXrZ4
   Q==;
X-CSE-ConnectionGUID: WZQGw9+wTgqH6F7JNSuVJQ==
X-CSE-MsgGUID: t90o3SC+QoiyjoZOY7NYTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="80576509"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="80576509"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 16:45:56 -0700
X-CSE-ConnectionGUID: 8qB7GUDZTF+k7NQiW6VzrA==
X-CSE-MsgGUID: iS/3UPhIQXK6WRFfMRGdWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="228839175"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 16:45:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 16:45:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 16:45:55 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 16:45:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO64TneGjmv1javrJvq4YE4gl497Mh5REXkDUHNZIgE8cxLfh8UAr30LIYvnBVJb/sPo0yRrXn68g0FqCmzr8+f5W3aZ3xO3ghhSI2HO3DjbfQNJJYEUwLSeM9Agq4Bh9Jg1JcQM6JyG1dUoor4AvAlxH+iAnEjL/drFIKKYr45ZW5X8soOgBUiFgMJar8ClZlVxFb332HCnetzmXoMA+z1qiMtCRH0MZpy8gXr1Oey7gxx8qGvcPKGEkMOW7gdKgG0Ze8v71/hIwPLpIcxYPnLywTGxAslYP6TyoVL0BgeNNxgBaqFkunsTI5UoXpb00bLxt0pvRs/sMBiz1gcQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li6x/TPZUVemjCORGISEUNYvUhvmIdVXNZRWf6Rdy0w=;
 b=ScyWxI2HnuIdL5g8MhbCMI1klTN23JUJRf5DbxVSTJzZAS8PrbBh6M8/Wcnf0A0KEx8I6CV7P79Q5CUBy3tZkvwCr3xt+yYJ95Zizw6MtBOLYA+fYAfYsZ0eHRgIDvKitkCtbfeMhvPgufFzitEh7KX9c1K85CHRQ/vwBj1yj2d6VQ1I4je0GVWstvT4azH+S5TnyBpU0Kz4UYM0KKxeovvtHHBTXcZgv2GRDlo/y0qywnwckTLUZbc/F6Y7dgXOum17rV4SLLfblUgIPkuLqmI5VJDTeBtk53lorSH75xsglpY4apaak8YC+jUsZwCzOLnMyC/s+nA++Zdw4BukxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by IA3PR11MB9205.namprd11.prod.outlook.com (2603:10b6:208:573::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 23:45:52 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%6]) with mapi id 15.20.9769.015; Wed, 8 Apr 2026
 23:45:52 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Fodor, Zoltan" <zoltan.fodor@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: update PCS latency
 settings for E825 10G/25Gb modes
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: update PCS latency
 settings for E825 10G/25Gb modes
Thread-Index: AQHcoGGisCMTCcZxWkODjORbj7qLIrXWImuQ
Date: Wed, 8 Apr 2026 23:45:52 +0000
Message-ID: <PH0PR11MB752235031FF24A9E5C9FB88EA05B2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260217225956.1593920-1-grzegorz.nitka@intel.com>
In-Reply-To: <20260217225956.1593920-1-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|IA3PR11MB9205:EE_
x-ms-office365-filtering-correlation-id: 4ace5eba-9fc7-48cc-255b-08de95c8f817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: T+OPp36OiwHezj2H4yHCdZq6UyDfqzAfmRc6UQGnOF8bWZOwMoMP7hZQEhv8I0lNq0f8UhkxmLj+/tL299dExa8KQxHvETSyvpgI1ukc4ctfHnQlyNuONHeWpAosAc5IGUh1PtGm8UwgQy2lTZW9H1PzBtm7njZXJiKJE3wQIPlZ4OabpIOWjO5nGk0bQZgmjSjQelfxLvGL3a+cc7Bd5K/GpdJF8h8Uz0hwVKOYs+zJZQaRPy+jVAze2SZjm/7vnWEwW4X6pbbD1oIY1Y8TawVKEdsDfFZgWMVEyx9EeEhWiWoF6bw7SY11MM5Rz0/IAIxaetV1TwObbXelJg6pwEinRcUmXtrTvqbDarYh3RKyl4k76E486io9gYP1bgWE1PoYcRMa8O8qnUlIhMuDpNpyDc4hFpvDhw30Z7IpG1t1xZeKf27VD3WOeDJgv7m18r2M9WOQTSb2P291fKS+vPA8K1eFNkXUawUFZV99WO0RuGLJ+HTigizpfACNphLB3hxdqPo4fUshdynDjfmzmFAYbUX2QwxJiyTni0T03FvpWBLRqfftontRiRm6pbTklF7N0pA+CRcCqwsfg+Ex8Y5yt15b73JjtV8zxc1/GSwoKrTyz6wQU1c47gKLyR8oCObxrnYvePb0Wq/vc6jyvemaCPUopHO9f0P69fC1ZeIBGj+nc/i9sGk24YVXuDv3YhnM7xx9p+wUl9aD8jd/DMyvr5BqU9zpJ5XL46jo9TqHTzLwjA1RuXR1+OW01utnISpWtYErhg6y4vsGeKBg+dSJ7SLHe3NcwbO7thqlrtA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KD1yjXrmbPMF0R4nocJlyvUTxUwUqU3ekHq0BLX71ygudkscNSGqGy9c/QG2?=
 =?us-ascii?Q?DEzPn9e/hcN2Cy3uK0gJrPdnxESX/p1IcfbHeCqoEVjLj3cJsn3gPa+XFLPI?=
 =?us-ascii?Q?Nw/Ez+JBInE/3uzhELkscz2ncLlJ4ALIW1g/fliLYcaDJq04iYW36FnqVOTy?=
 =?us-ascii?Q?MTjOVqLJwyUAbweFuowgn8ORG6xWnR/KQgLu02ytYc4lgHXeDcOgitDQH1v3?=
 =?us-ascii?Q?KguVp/dXzCtmIfQv01157p+IsFQQ4e+mI3nM/R8F8PQD0KjMPqci48TO8igz?=
 =?us-ascii?Q?yjC+qioVVbYnxwm9qLeE208gtsVfm/5No6eSgwOsx2Orbao6qDpDBWjj9HK3?=
 =?us-ascii?Q?bkwYvzwoFpWTVuYZMob2lQUawMATsVCI34XM0tacW+hbswgzmYGontEqEdBw?=
 =?us-ascii?Q?OlAG3LzBiQrd1n18jEeTt7WJkminMUVb3EkzI6Rc7IYqX5Ih+G+N9Gv/IS6n?=
 =?us-ascii?Q?5C6fI7V7KikSwLGOifSQ1Nz/mJGSeLuD5asSAMr8ZsupOSvPV8FpRpSF9iYK?=
 =?us-ascii?Q?iajtnbryXgQCSK+UH59gdE1VarJ/7iH39Qt7+5hMjAP736Nd8G/dariYv0bP?=
 =?us-ascii?Q?e3DVSTiWksbAoGHc5aZ6YIzXA37REVGN6Q3KwPznQZOAwitRYZeGlkoBub02?=
 =?us-ascii?Q?FVmALmaYYXxPNFaxVVeMVZyDfCa3CnRxeY4u5ZvMqpI+UovElaI3GJ6oxgIK?=
 =?us-ascii?Q?5uAdsHya1VKODn0dN4hhIaqCng8YuAIOLfnatbF+GhqkJMk1LO8/owRwl+AQ?=
 =?us-ascii?Q?an3QFNGo+gD3zHWsp+XT9w+X/3E/SmjuFGgHu0jOGLJ9THIYw2TW3/xgpl6h?=
 =?us-ascii?Q?kcFYSKB0v5efA/3wk3DAWBOnQwdjQmPVWwKeiCgxOHbPK7jaTDPHmZsCWxRN?=
 =?us-ascii?Q?28WV5D7uiZvSXIUvt6RXiXYh19wAHfntzSFD7kXA8NLTHveEm1zjxnd9yeXK?=
 =?us-ascii?Q?MJXgcx6ji9QI54IhWIWmM7qmIcAm1+wReo30kZwoE4ywdzCscXagZfGFZnFi?=
 =?us-ascii?Q?KL8cOLaPUGbG+YyXOGMTuxjCwqP+YZ4XIfhbbPOo+A8kV8a8jeoFt86iP9/K?=
 =?us-ascii?Q?t8nMM9rU92Vs9/e/0fIIHivezJox+xsl6vVhZ9mmJIzTSfRwTGlJbV4DwqA5?=
 =?us-ascii?Q?0a94gbp9x8Oywc1NlptW/AHa/hed/XNso324h3nrGfrVxShnt7XKYnfAVIUP?=
 =?us-ascii?Q?/jto0v9A4y0EhRvsLptYY6j1HrMrZTY242Fll1mnXDZYbku7POhGConqIW68?=
 =?us-ascii?Q?QTrZFUvJ2aFEit/8667oHLAL+JJEDnQZaskRoALmAe9MiRNMBL6+cvX2LTw+?=
 =?us-ascii?Q?XHg2HDGtGU74m9lVSpbljPrCl/hTB4OteSsABCvUf5dc0zp2BRzGTokkAtGO?=
 =?us-ascii?Q?nc5pQcGaH5nOo+/7GQS7eI1YWjJRjQgIwsMoaKl1fDa3LVTH8Ld7fJRG5Guo?=
 =?us-ascii?Q?c8jCo9jlCW/w8cy6Afiz3r0+YmIR5XQoucynEAx4Mxez8Hpm3J0ezSbqg3Cu?=
 =?us-ascii?Q?t9NVrE39PxEDZzLZvBaf4EjxdOAY5RZjBwkINcgPt6O2ybQVf9xdK8Dd7jFo?=
 =?us-ascii?Q?ZoXhsE2rMvm5GfSm5WT+UbnOekM9B0e+BdkylGXOilI0+VzIuUNPnr3cQtnP?=
 =?us-ascii?Q?6kdaLQzssXFlDbyXW9eSlLBqrzSbWcpDwPP7AKpqPJjtUAtnV/tCujBSAbDI?=
 =?us-ascii?Q?23IpzpKX4OW2bprOZ21qa3ftRVvEcXB4qepxH/qWgAAnZGkxwNt0tSX2WMab?=
 =?us-ascii?Q?wSL8l5fK4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: weA0ljtRzY0pDDqPnGHNDmE6yzxFujhSgoAExIIP7RPfhxbkhrADrdZ74TEn6l0uBoQk4hIW90Nk+K1T1rhW63glnN2gKLBJyI9Vuxw2RDKT2W3jhqiGsCxouWSfkX9Ax47nQPk/DQJruc6cicqLeORUWzKIncXveTBdgMhutYt38rksIq6LyrmWK/9DRf2QJRXiBo+Kx06fkaFJ+iU/WrKDopM6Tsv0rXHXBMoy2wb+RjAKqEJrkmBo5NsQ7KragC29cdUHYh7aVtPb6oTIrRXrbHqdm/ssi0ShwGSQeqIaV46y25S5+sqsINLWcZTeefTgct6Zf1PZPHuu8LUG+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ace5eba-9fc7-48cc-255b-08de95c8f817
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 23:45:52.1297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZhI2+NOua8IG6VTACR4Irki87+PdI7yb9R+pkNCXXVZbCUT5g6W83/DQI1uxYO04g+DCbEJtkqFIbjro3npxMwOdAzGKbOKcAhDgz00PXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9205
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,PH0PR11MB7522.namprd11.prod.outlook.com:mid];
	TAGGED_FROM(0.00)[bounces-276752-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunithax.d.mekala@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C07753C4D50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: Tuesday, February 17, 2026 3:00 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Loktionov, Aleksandr <aleksandr.loktionov@int=
el.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Fodor, Zoltan <zol=
tan.fodor@intel.com>; Keller, Jacob E > <jacob.e.keller@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: update PCS latency settin=
gs for E825 10G/25Gb modes
>
> Update MAC Rx/Tx offset registers settings (PHY_MAC_[RX|TX]_OFFSET
> registers) with the data obtained with the latest research. It applies
> to PCS latency settings for the following speeds/modes:
> * 10Gb NO-FEC
>         - TX latency changed from 71.25 ns to 73 ns
>         - RX latency changed from -25.6 ns to -28 ns
> * 25Gb NO-FEC
>	- TX latency changed from 28.17 ns to 33 ns
>         - RX latency changed from -12.45 ns to -12 ns
> * 25Gb RS-FEC
>         - TX latency changed from 64.5 ns to 69 ns
>         - RX latency changed from -3.6 ns to -3 ns
>
> The original data came from simulation and pre-production hardware.
> The new data measures the actual delays and as such is more accurate.
>
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products"=
)
> Co-developed-by: Zoltan Fodor <zoltan.fodor@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Zoltan Fodor <zoltan.fodor@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)

