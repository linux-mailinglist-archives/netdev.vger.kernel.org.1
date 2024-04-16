Return-Path: <netdev+bounces-88182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571E68A62F0
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E382286870
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 05:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AB539AFD;
	Tue, 16 Apr 2024 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgCcjmIh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E58468
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 05:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244690; cv=fail; b=Yuio/7p44es69jZXOGM+r1+io8ZtJFGM7naorCsxtYOyUCXVyxtgg6EYgHSjj//bYHcfvhlvFTWu1AyHuEglQmcgmisx3KJ+7gxvX8yQaxsXeZe9tmqaO/loQrB9m32/zPI8D+WxxpgegS2fuflPalcKWpwzswcIUpRaq8IsgW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244690; c=relaxed/simple;
	bh=mJjUxGKHfQarPpW5TZfiSP8zU6X9qcwDmUrMz0vF9so=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zvd1MYDSX6HepGxIx43ku+z2nZjamKCJhpPBCKFzj7/StOqjk45v5CYFRD3OuF1ol/qtB9XL9TYHncF7aXTWqJekGx9g3OrNIHKGPWGEBpy1FefaPn7bAkRz3QHfPVoNBCGwM/92F5o1JkGdVmF/BiYvQBEwEWDmS7h5MNc0zKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgCcjmIh; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713244689; x=1744780689;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mJjUxGKHfQarPpW5TZfiSP8zU6X9qcwDmUrMz0vF9so=;
  b=SgCcjmIhcGpwHlfuG0jpmRuAAsgxmi0nQp5s6BAnzovwyC1/ucVpZ6JV
   rm4Z99Uput+nNwVNZX28fZQdKyJE0XeomCYj7tfoLhg2ZSlQMEw5HmsZ0
   VCPsUU5FRrol+sDt8p04LAoU0yvKwtxIiDGvOVN9B7/ymQJuJqpBHp5Ak
   VQ3+gi9TKEgcoU0HWkjbnWgQaUtBdP9Eo8q3GRweMfoJ6qhX5qJpiAl6C
   SrWo0y9DuNzs3MWhdm/kAEKf+9zAmAB1lGx3RCiuMTUVJUsNm2K9YLKrb
   23rUeTt1PyRUqbkvgESdK5KzuRhRt3QPtjX75FYf5RrJH9EvSeNLsZKV0
   g==;
X-CSE-ConnectionGUID: yBrstYSwTMKKJhYbD6ff/w==
X-CSE-MsgGUID: NEcPlaABQsqzrQD4q1qyWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="26177228"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26177228"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:18:08 -0700
X-CSE-ConnectionGUID: OhB7FKcMThuy7JGI72E/vg==
X-CSE-MsgGUID: RrDPg5tWQJGHyl2rbZ4X3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26802340"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 22:18:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 22:18:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 22:18:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 22:18:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 22:18:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQwNzd2safPwpUkwMGKJAOAhdP9ggGzyytP99vrF0TnAZbRauEqtSdlFPceLnisEPlLcsIa8K87T3Zif/zuOkZf6lSdY4EtcYyH7WpolRTn+1W6IF/Sfa5/wSmCB3DRZ+zysat6/vVtRumGMogND7/3jz/YwNl4Vues2DoaytTbXpxWN7L+uv51iHciDJM1mdjdsgxwJGUwNqJZIurtMGCrGFz2vSqXkbMDjzpPJV8qFG/Cs7FIS9+evAmGtwCxsrLOhH74//QkU3AF/L+wOqLeTXjhJaLk/AVom636Acx6WXG1tzZLAVp2iGuRAK8C5TkC3W8RBA8spqpOMmxVIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR3I9RG3tkVZXEAbnTb8qD6bi8D3X5oOl+o7Cj9eVW4=;
 b=EiEX5TuHACLUR5eewXsAXq+/yrUwPt6hlquYmpHoiD2gcsewtkKp+kD6tyzFVa5tNVw62wLdK4DBm+hBzISVFMAA9Jzs3wDxJxUTPYtOCNKZgZ+ySiruDAGztaXtw0lnoKlMdag8t6p/1yKSg/JYP/u9IjYAy8kQyGD/msGXTrwz+m/EWo7th6QPnkajnCoZZffGXo1DgPi6hyVmXsdHWo+JQm6FP4NL3oho1tM1bf8zcVR9+NdfcVOLKDyknVrF+8JDXxYM2fLO2ZC+LNIzKFSLEbXKGOfxIlwATO1+CmfjRnAGZWuxi79WEY+KmGMCGgVJej0R+5cKfb2BJxF4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19)
 by CY5PR11MB6140.namprd11.prod.outlook.com (2603:10b6:930:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Tue, 16 Apr
 2024 05:17:59 +0000
Received: from DM6PR11MB4610.namprd11.prod.outlook.com
 ([fe80::e51:4d65:a54a:60fd]) by DM6PR11MB4610.namprd11.prod.outlook.com
 ([fe80::e51:4d65:a54a:60fd%6]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 05:17:59 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "Gomes, Vinicius" <vinicius.gomes@intel.com>
Subject: RE: [PATCH iwl-next v2 0/5] ixgbe: Add support for Intel(R) E610
 device
Thread-Topic: [PATCH iwl-next v2 0/5] ixgbe: Add support for Intel(R) E610
 device
Thread-Index: AQHajx5BOwdtU0Gn50O2MHPyOEoTFLFqWN6Q
Date: Tue, 16 Apr 2024 05:17:59 +0000
Message-ID: <DM6PR11MB4610DEF14F5E8CBCB39072ECF3082@DM6PR11MB4610.namprd11.prod.outlook.com>
References: <20240415103435.6674-1-piotr.kwapulinski@intel.com>
In-Reply-To: <20240415103435.6674-1-piotr.kwapulinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4610:EE_|CY5PR11MB6140:EE_
x-ms-office365-filtering-correlation-id: 4295c6d6-db56-417c-fbc4-08dc5dd494f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b6Oth17IJELuxAL3YgMDhJQM5PRjvoHQGDUo/hvdmnF++DDr++biuF19es9V8ai+pFN5cFllc00fIPHLPYskct3wHMjZYSlajr4mA278NOByv7XaHvntN97Kdhy7FEswRvSlyBk+/MY9Ph7CLHmg60fs8zsb3FvZvusFK9ccRQG7nES4vy9iOgOgXzYtC0oMTyP8kpLRofxtGJO9rfHiERnN1mazmOva3S1XH3LEIkKwKGnjd6exeNpBe5WTiAcdGqfYNf4+hTg6Tyq3/Tdr28iHk9O25Jxq1tT9WhqIdNH5IoRi3yi1mefjVzqJvk4PipGDwsXE1MuiE++mLY4zOnMgxuQDN3yo763wvVUx98Q7N7UbUX48pZRTUarSGmVbiXnuWrOi5DMYdRZ5HHzoIu7dlF9Q/ilm7wZgLLSGN2abSF9hf2h/Eou+RNIA+WMEO20fYwS1IchrT9Dtu+jJDdXbUg2eEx4VSqnCSlqL+m0W1DL/abjcXHe7SwWKNTwHc0sI9wcFo2g+TMb31MuRTt4Vi06xEX4Mi+Kbt1xR9AVYkYVWkYGm/q04lQn95LRHRwDThLvyxKarZtSNV/CIo3ASQjMbZ0dd/1AfbIsfAnI8f9TT4w87WLtifWT0BbaXsqje2tLaWJJd92XG+m0jFetmC8buzguiP3DDtmds26W8zJoLmP8DFUCxMwnpK/+VIuVAuu2aGlBC+0PMteIUnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4610.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wSyIZWU0+rU5qLjYSac1uTM35vUemCjX2n7IH9jNacMG8183JDBJsI0e1xo0?=
 =?us-ascii?Q?BGdgZH+cMbKiGTGqdLyoWb1AxmdwpnRwA5AJpf6AjzCs+0DoYLaLoJ5TpWim?=
 =?us-ascii?Q?lyL3mYZtJAH8I8DYVSnE6oEAXgwr2WVSgfdFeXYN4FRxYU82tc6ocT8ehTwp?=
 =?us-ascii?Q?8d67XAIU+ZZjgWOGf7WD5IrnNpkgnmVoE45bIS/IDb4+lhrUSjPjRptOpvbK?=
 =?us-ascii?Q?1MolmlpMNYmuxUberfGxYbcKxtw2MyCxQjPAV1igNm3GZHyiwnV6NHo/BAi4?=
 =?us-ascii?Q?XMaknPN7hTXw6b16bnUlDJpmRTS6VKtWY7aVL+71nAI9HzQxwP6UIsQ6FJo7?=
 =?us-ascii?Q?M042r9Cai4M/Rkwl0Q73gCaY8h6+FGOONBqXm9OZv3FNHuK7+fCOEFQHndSH?=
 =?us-ascii?Q?SANIksp4Y1oOWGYii/U7ob6rQkIrvADdvQ4h4vjnqvznfjWWjeyL9uKdOFSX?=
 =?us-ascii?Q?Kvx/jecvuSNV6FurcX78vkmVwl1WTLwNtpFyaMydtBCBCW3tQUTxe4MH58TQ?=
 =?us-ascii?Q?K4XcVxZ/dh0LAm5guYEE2fcMbx+YOQY1AWZqNdrFGnRA+Tb2IaWCOnTSQKg0?=
 =?us-ascii?Q?j8jzIBMVrNAiAC4tSk1T9CAwJZ5RpibmyZNmjdLfg26HIqGQGetWP0gqlHlj?=
 =?us-ascii?Q?b7eNk8vcAzChS5N2KufbfmnqHJa0/8PdG5CL7H4Dl/VdgFtGQHJPXwTIsSCd?=
 =?us-ascii?Q?9MKkkd/cRXIId1uTnKrSpXDH8J8bL0mlhud5TyjSooA6zbgW/EU5HmP/q1hl?=
 =?us-ascii?Q?z1ZKXVRS4FuCR5Z7hPregN7zq0ibmwTjmPgmsxJpZIF3Lgr2+lIcqA4nu5X4?=
 =?us-ascii?Q?34QKSqgCqV+D6Ib+C5OVSdgHgN+upNjcWWddsr/IAGA9mJBa35pxqxkLX8ho?=
 =?us-ascii?Q?ucYWurmTqpspVfwj5cwhFf9yXbkhtJd/kiPKIAUFjAddbA4Hhmae4BqEWgy8?=
 =?us-ascii?Q?w4RgXn9pfiG6+BgREBkA5xSS2mI9tLwjMM4VNw/3B8+B2PwOj5xW9nHv5vLK?=
 =?us-ascii?Q?NZRZLnUZzUx5K+sjHL+8lSqi5ZZaJ2tkX7p4ylo9b/7rccRRKbVwoM35/Fgc?=
 =?us-ascii?Q?hMGj6DPI8P2jpNuTrndfkJVlpIvC/6w011AR4vntqisWsYOiJO1HS68rH0DH?=
 =?us-ascii?Q?3OswsJkuvYGrrXzkH3z3sYpaVYAqop8URFzWOSboqh9dYBH5Pkig1uIQXUVD?=
 =?us-ascii?Q?3iMZC+378x66gVt+rLeDOlpKKpbP7ZNJMGILVgnfL4PWeqDAFhrPEOf96nTG?=
 =?us-ascii?Q?GCAw2uBZ33Qi9ekujmtOF78OT0y3jb320gg+oRavZ32IChVEG5PHs0NgbDCC?=
 =?us-ascii?Q?nkCoQNCW5s/jbqHgfeQlCFAQZ0IzbiMSoZeYspJjZ6QXipQhoFlxRndX0W5O?=
 =?us-ascii?Q?BAHbGCXPHeTXyvedPiSY6IixaybU1IiohHWQdTEeMI/jzgl0etp+dvrsD9dm?=
 =?us-ascii?Q?UgcMBYCLnMRf03n10Q/Qcs7pwfE9bI61xxO692Krta/NmhWz+61/mn5E5znr?=
 =?us-ascii?Q?31eBx6HEdVAUje0LmttT2GlGL+bQynZErVW0kMGsBp9YGpaKaM/Pmfb7Vo8h?=
 =?us-ascii?Q?QbkC73dkWg0BDn+uE/CrzufG7k6a7gUyG0CKEdZo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4610.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4295c6d6-db56-417c-fbc4-08dc5dd494f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 05:17:59.2954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLNdX4g0Iyp9vG/PY1MXSivxZ+uV1fHuO0ExK/FFW//+hViMmK7GKqo7BUmcZ4G015yFlacm+ysDyo0Ki5GS5B5gNqGFev58CfdBy6rlZpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>=20
>Sent: Monday, April 15, 2024 12:35 PM
>To: intel-wired-lan@lists.osuosl.org
>Cc: netdev@vger.kernel.org; horms@kernel.org; Gomes, Vinicius <vinicius.go=
mes@intel.com>; Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
>Subject: [PATCH iwl-next v2 0/5] ixgbe: Add support for Intel(R) E610 devi=
ce
>
>Add initial support for Intel(R) E610 Series of network devices. The E610 =
is based on X550 but adds firmware managed link, enhanced security capabili=
ties and support for updated server manageability.
>
>This patch series adds low level support for the following features and en=
ables link management.
>
>Piotr Kwapulinski (5):
>  ixgbe: Add support for E610 FW Admin Command Interface
>  ixgbe: Add support for E610 device capabilities detection
>  ixgbe: Add link management support for E610 device
>  ixgbe: Add support for NVM handling in E610 device
>  ixgbe: Enable link management in E610 device
>
> drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   15 +-
> .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    3 +-
> .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   19 +-
> .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |    3 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2561 +++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   75 +
> .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    7 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  437 ++-
> drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   71 +-
> .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1064 +++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   42 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
> 18 files changed, 4303 insertions(+), 66 deletions(-)  create mode 100644=
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
> create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
> create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h
>
>--
>V1 -> V2:
>  - fix for no previous prototypes for ixgbe_set_fw_drv_ver_x550,
>    ixgbe_set_ethertype_anti_spoofing_x550 and
>    ixgbe_set_source_address_pruning_x550
>  - fix variable type mismatch: u16, u32, u64
>  - fix inaccurate doc for ixgbe_aci_desc
>  - remove extra buffer allocation in ixgbe_aci_send_cmd_execute
>  - replace custom loops with generic fls64 in ixgbe_get_media_type_e610
Missed the following entry in the changelog and fixed "inacurate" typo abov=
e:
   - add buffer caching and optimization in ixgbe_aci_send_cmd
>
>2.31.1
Piotr

