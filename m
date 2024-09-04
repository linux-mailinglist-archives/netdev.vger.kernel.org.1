Return-Path: <netdev+bounces-124926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65BA96B62F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95701C20DE5
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D9C1CC17F;
	Wed,  4 Sep 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDILT36D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1049F1CEEBC
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441057; cv=fail; b=h119rNy1YB4VBz15VBmTLpQs1MNqoAO+wRxuR+287IT2OYSoWJjAJAdPitMM4G/9fjF+9A3igPqCo3LfPEw41nL6uUwLyk+Bhd4EpXHXfeRAm7LqBfxtf5o2uXbbtmOYiqfnTn1vpnZHxISgWhSj55+gLmqYV943Zz4i45OtKyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441057; c=relaxed/simple;
	bh=bbURehc8eRCDo/oCogFEEptohrtppUfHI4GrMwYEKOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4ZRJ3l8KOTpPm05QWQaurOLiXbVHkVNh9J/Qp9b6x8X38XCkz7ixxtNQcUTkhpjBLKNJrG0QaSEKGjEiPe41+EmD+RdIBKSEB6YepE8X8jy+6dwx5bM8zp+3CkfRtWm/cfbf8v+qHC5rQTQnS5GwDBkLR907Sj9/BDnpokUEzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDILT36D; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725441056; x=1756977056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bbURehc8eRCDo/oCogFEEptohrtppUfHI4GrMwYEKOk=;
  b=lDILT36Dcdehs4JEQCs1YFtkFLiBI70sb0NJZvvjBxLX3dCPwsQBa/7D
   pE/Gm4/05Id7ZxgAjz1IbIl0ya5iChWFxvuOB6d11A/d+V5T2UN8Loiul
   kk6R/Wdk6Atj4sPbqU7PWuvOxniMX8ILdn15MrQUnEt1k3Thu1qcmV2Ec
   UZs2OPuUxInuj3O8MZFpUEtJsvRB/n4yqdQo79/Cyex1wZf/cE5cXoeV+
   IfCOwHTCcLJJRa2O8CZaa8DCtlismvXxsBcUN53cvp22ng48WkQdlHCeX
   6PppkJTzwIQE/GqfjMTbSv4CGfNiJ1RAT3GpTBhxKgoAigEVB+0e0zenN
   w==;
X-CSE-ConnectionGUID: dI+5oRAnQZGlg4/IUVNnUw==
X-CSE-MsgGUID: W3aTQrHfRxKOncXNqocU+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35246681"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="35246681"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 02:10:55 -0700
X-CSE-ConnectionGUID: jBftpp2jRyaWX4lTXkRa1w==
X-CSE-MsgGUID: 5g0V63XJTjqWpRveI+RJWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="96002668"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 02:10:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:10:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 02:10:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 02:10:37 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 09:09:42 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:09:42 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 1/5] ice: Introduce
 ice_get_phy_model() wrapper
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 1/5] ice: Introduce
 ice_get_phy_model() wrapper
Thread-Index: AQHa88vG5Rgszs1LMkC176pYJKsmy7JHRLgg
Date: Wed, 4 Sep 2024 09:09:42 +0000
Message-ID: <CYYPR11MB8429258415A207762F5CF227BD9C2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240821130957.55043-1-sergey.temerkhanov@intel.com>
 <20240821130957.55043-2-sergey.temerkhanov@intel.com>
In-Reply-To: <20240821130957.55043-2-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: 11a6bf03-018b-417d-596e-08dcccc15024
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OEdoJW+srgjKBBGG7vYHbEyUOBtomUblPjGj2WCz/V4qJTl2hmbVAMpa9FGK?=
 =?us-ascii?Q?CFHOrqta8lBVDSYHXJSf37BosH7IJIPD/wxOv20B4x6AUC3SFNjr5KRXgaBp?=
 =?us-ascii?Q?O/O8yeeQNKLHMBX1osqQGTQbqBDg8wtSN2uSQkiufU8TjiYNSwPQD4I66bAI?=
 =?us-ascii?Q?N2CMPTe6O15uflU4wm9rj4uf48xO5eiWlEo+1iLsUgdv8rhl+81T73bKu14V?=
 =?us-ascii?Q?7XQuB6LPw8Gw5f2ptX961u+np5g9IVTwM8x+G8Q6NNabTR3fzgM4tUmY2HeG?=
 =?us-ascii?Q?nUAmswKgY8qGc790S3yFyYD0/japEQ6qx/5LlNYjrPYoynxaGptF9ITv8dPF?=
 =?us-ascii?Q?eNDjZVtuDUleB5jvupeCYZcxr74CBQrSIfo7lm4bx2+2Mzo+Zsm8j89ngm07?=
 =?us-ascii?Q?sVo5tBAlwJKQjXKNpaHJ+7SCcwBnkcjdItFAlnnoFu4eJldA1+6mjkwc8nBm?=
 =?us-ascii?Q?v6m7Odhjb2fEA0VJ/tQt5opm4VtntDy4qKrP7W9ImCv8+4OxjY3iWDLfthq7?=
 =?us-ascii?Q?i3oP/j9+D+K9WK8bTU0CywSMpi4C1h7IiWl0Yon7wApVkOHCDTJE8nl1Inkj?=
 =?us-ascii?Q?K4Vqm7uY6BM12/Emgw2S9i2bSdfomZnmxqx8l3vV6UNawHYRyNb62d2DOgL+?=
 =?us-ascii?Q?zndDd31UsvXl7IWLsna61lzCfMeGRcyGm/ZzzkOnVGVIIW/iYvnwVa24JeSA?=
 =?us-ascii?Q?I5EIHGB5DUHIH79lr5jaEiGj/OzCuM9A+kJSGaAyS2pMnHh9D+pPB8mwXZ/4?=
 =?us-ascii?Q?it/92OeVz7Y3E6uhFGjDhZQs5EOFJSLlsdkdCANg5gNUjjw45gZHibK+BYEy?=
 =?us-ascii?Q?Dmqj0KcO8Xp9M/kI3pi7wBM1ToIyvTUhZP+eEK/iCKLNAKOyLe/BiFOQ3zLO?=
 =?us-ascii?Q?tjrTpxuIPrjGA4jU09M7vmPo5ed2rQGGpEmcfhhNCxmNZCQaILYqCSKBmbrC?=
 =?us-ascii?Q?dkKcQf607iyp7VUbZm1tt5ZaXTz8VMzcQTQZsOt8Iwz+FNpz0nFrl6OkIs/w?=
 =?us-ascii?Q?HH/hK3h5MdTK0HVm5gFeAxhmkwuhoPx+d/cG5plKafJKkHwGlTT7Uis+18wB?=
 =?us-ascii?Q?kWPEtzPKIJ4Qnm1L+1wgHDMij/JZkyLfI6RbALCKpPsnwlKMFK60ZVJMYSk4?=
 =?us-ascii?Q?6TTqeg5psLLFFhtz72XuZE2CkFkFebN370CbTIcNRsVRtbR9HTMec3qZPtny?=
 =?us-ascii?Q?J1Nh6S7IZvubr87grTve5GMkJTgWht0lvVeNSx/YD3/b0qzv3TZc1rtLOzTY?=
 =?us-ascii?Q?FPTJrDtn0PRzorviEuylmBfdyrXavLw3Cz5b+iIHsXg0F29bYc3e/w3ukVpe?=
 =?us-ascii?Q?cAnY+CRdWAkv6NlHU4gJHtvsQCKFNwEj8mjag6OfCeLoe70suUsSi2fjjIEx?=
 =?us-ascii?Q?pMXlGmO9S9+CTVttS3tuyFwIOgPj0meIh7HON5RKOkbaw79yNw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8/mhTmCwp6J0B4Qa3QBIgwSfHETPVRpnBtpdEOU9/TZQNuIIm8M8h5r1BmKM?=
 =?us-ascii?Q?iqjgV7wMU48QJFVAOJaZVwsEQLF32H9BM2RdxyKec0N82Lh2TXe/BgygJH7M?=
 =?us-ascii?Q?WcHL7F5bniACTTLRSaGZgSZSWvlppJkyaz9GwjebFZ8W4i4IL9S0aZgBRULl?=
 =?us-ascii?Q?c7bz8yrktA2JtSnVt+x5eitaLfNANGHaDn3yxF7kuiVfowgiMhvlhEv8gnqp?=
 =?us-ascii?Q?GDjXXmOxtxZKFuvE9FQbgGGjAXjljxEbc/rMQW1gH09sSAOA8KpKlHg4xjFi?=
 =?us-ascii?Q?P7LJclbKNt+qf/udcqzK8I3Q7P9UiANUeLQ1RqTew3swFv2aZ+Nm0zOBeBzr?=
 =?us-ascii?Q?zkgGWqtoyfUMRnkETMPD5syiJu5E/5THqGikdlcH4PcLD1MWMr0NN9PHrkd0?=
 =?us-ascii?Q?f73d+k+LbS4o057MgfrIYx/qRkHhUTvVdpNZi5YhwIjjNjSqxiAYXnSAxCfJ?=
 =?us-ascii?Q?gu4GrPYAZMVsXT/S2LhCHEfIwTzALEPfds3KtLo2M7duklyS/c6WE+0z8Ea1?=
 =?us-ascii?Q?4THAFSZG5aqI/IV7OG3teg1C19HwOcw6lb5yky3ApBDSWQcADWULNP2JB/FD?=
 =?us-ascii?Q?kOUZpke7svMjGB5JKTgLsvQY4HPMQO+G/sbrT+yppa07LAlKYYP8vIfMpM3Q?=
 =?us-ascii?Q?W90E7igpugC6jKpWXoVv4NmshUxZWUK2UJ3DKTZUNY9m4Q40Zk1t4g7D2Bac?=
 =?us-ascii?Q?WIYCKiWAEsJDkrkNjuYKRpdCnzWFLXQCXqKlTTehPyx3qmZUNb7haV3YZ+o2?=
 =?us-ascii?Q?Rz/iXu3ZodNswEJYf7KdE/5WfbM625kWSExGfYHt06yYyACtm6gkPcO1h2wB?=
 =?us-ascii?Q?YLoCZiyPRV7RxEJyEdbe1Hph18CNic05pXIbDb3G42hx2cm4G/cFCtkJjg5b?=
 =?us-ascii?Q?K+R0lM81KyzcztN6JQPdkMOV8Xfxs3lDx4RuQ7bsCu9QN8el8LCUWJDsmkde?=
 =?us-ascii?Q?F+VyalWgpVYENDcpdPIiD9/49suC9XAbcmsi88V7RTdziP8hp2G+4pEtySlP?=
 =?us-ascii?Q?BdFlD9Zdz7ts9UUsrFNcaYX0mP5X3vkY7+AgIMEdP0zhI+CdXkdEXAMSpx/M?=
 =?us-ascii?Q?oeeGmoyEOeuAzqQlSu18rL3sMuUo7nSVfghbra+ekCuAvqG3ZPbVacAT0B5n?=
 =?us-ascii?Q?FvPY5Mgy3Vlnr9A2jE6Y3k59mY6PL6JNP5InIKILz5ycT1FQga+W8PLVV11O?=
 =?us-ascii?Q?JSjR1H3kKmbCTVIpDKGbExTTtBlSOcQPRJ2mAoPsem7PFdFBXsALAKmqutDM?=
 =?us-ascii?Q?/hvie7V1nj5qUo1d0HTcOZc5+mz+et9II5SIXYonAze6ku8MSpqMmftT3gG8?=
 =?us-ascii?Q?wDJPT+vAc98PCRkZt4ElVs9+yl5fWhRou0x0xF4rJNc5FEucHYeasTfDYHM6?=
 =?us-ascii?Q?P1U+wQNSQtxzIkjXRGgPF+tY+5VVHj/jLmrjnlk+/G18oCLps4LjFiKaEzjz?=
 =?us-ascii?Q?asYL0ujrZtXE5gO/V7xvenubzuxIq3CF6RipnRN2GmSncamOyGeYnC1Eqp7C?=
 =?us-ascii?Q?b2MoTyDXpd/of/5/PCjDBsZROZD7c4A6njeM0s59p0TQK2WCaVpcENN7PFyY?=
 =?us-ascii?Q?fg76z5e3HzuHiFqde0z5HxHrkGro7JLkl7Gp+DFK3aOMu4yRWETYI+hUmkSo?=
 =?us-ascii?Q?KQ=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPEOT9h+vIpH9RU9yUw3KoW0WG3KpJ7+pTo5jjCTAvNXd3AmVw9XvtVJWYXQutiURSThqFvCVAN2sjQVnkPZ7876B3mxGdVBifnT65RSACp2z/TC4Nj9c0k9YgQ3oVNSHsYzR09c0fOHOvwJSGWnFES5VX2OqPGzR/das2n0T+nuJ1hJ49grXTJALvxtKon3TeTm/tSwvFuOaj772mHSG2vGQeZ1pmpww+n01aUw2ln1nFu/3u//z67+YGixux76NXhNqQ63lmMKZzDmuA+oLyORqToLI3RBc5sLulYTl7/Fit5arnlB6rOwFEsTVRcCQJ9kXvbZWVPzdBdnOv5mwg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWSPKxM9BJtESy0s0HVWxow+jTsIORSq7KOnJCVE9VQ=;
 b=Ef3wTb2FPXe176Yf9TLJZ7voR/yMGAPc1rMzKSfRjpz1MhE4aKb5Hfzf3+DIZCWBjU004f7JhiERPpGC1NGyqxyW12xVlb5rmelTQ2+TVlGqFjPXsBSMU4ZtGa68EFyx1gZY4SVpaHJJ/aQ/xzr12vR2vP+hOJ+ZnbDhqj5T/W51NvvJgsKgeT8cSFHF//g7Q9PrLFACHz7FnUj+WvfJflKdj1J/TRPtxyEFsc0jBxWzsYQyC0IR3WVG3UWYlj/IKMdRJw4jco3l6zj9wvVYm/7EgtYm2N4c3UemrkIKMwEcgc8Fl58zVzmQFR8wDiEG+ngvT62O/HLnDV6qSQEeyQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 11a6bf03-018b-417d-596e-08dcccc15024
x-ms-exchange-crosstenant-originalarrivaltime: 04 Sep 2024 09:09:42.4701 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 4BvTLrb6sveRvnpG7FQHcX84dw+QZ2whjgOx6MYp54p7tnRsW42MMP69cD2TiXnS1dKYNzZ55yPAWFGd56m9qpOKRQp3Q4xVz37o/DAtIpAvx0YC20aD2xMe6hoPZvSa
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR11MB5830
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
ergey Temerkhanov
> Sent: Wednesday, August 21, 2024 6:40 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>; netdev@vger.kerne=
l.org; Simon Horman <horms@kernel.org>; Kitszel, Przemyslaw <przemyslaw.kit=
szel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 1/5] ice: Introduce ice_get=
_phy_model() wrapper
>
> Introduce ice_get_phy_model() to improve code readability
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice.h        |  5 +++++
>  drivers/net/ethernet/intel/ice/ice_ptp.c    | 19 +++++++++---------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 22 ++++++++++-----------
>  3 files changed, 25 insertions(+), 21 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



