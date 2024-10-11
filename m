Return-Path: <netdev+bounces-134602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B752099A640
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 16:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2740B24BF8
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2082185AF;
	Fri, 11 Oct 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzLc1ia+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7F20B1F3
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656717; cv=fail; b=TleOmVmomjXg/WstCTRaoWS/q/8eCMHGysKBiy1iCqsw2qe1JniwoEdcXsXmOLOBjQoSWc3/n9jInLwxKnNs0nqypDyNf5o8XNGXgObPtJH2998ghpQQYBfyl0Q3Ac/MC+HBjVWLtJEeZ5tpHwi0WpQlK2LixUeBJPobMI51bhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656717; c=relaxed/simple;
	bh=2dW0MNwNAwfHs/EQqCgkv4gCdHNOU0vmpXxv2Wag2yI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ib8v8EEfYv1DnNt8aWiAEewxGxMQiUqKl88YRiL2UuYr01QPzFAlI1KmYIFEMZGEgPmprALMgMkh6QrHcbpiLRRi9O/gDPRPHWFVl/MkxiJhC73e9502cV2k+L8v5yGFRU8Nk7PH7Z2Z/Vp4vtX6rj3P2RCENsmD8WyFcm8fWUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzLc1ia+; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728656715; x=1760192715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2dW0MNwNAwfHs/EQqCgkv4gCdHNOU0vmpXxv2Wag2yI=;
  b=lzLc1ia+6PVIivmapbLBZ7ogfzracaAiBmp29CQ/mZW3FG4AbgFoRAS9
   4DQJvlPJJLdGnJ4CLXxZhN8sVhk619eBz1yLXneO4L6znLQZtvMgUrSLS
   IjYXPUxmqPX2AkW0yeYGErG3VGVoT0m/eoP7zbvDBpymvSUUJBYYsM/Np
   u0I7WeQ8Qv5Sm2ru4UggpLhj/AyFnJlkgjI1gC4MKI5mMqfHIKmRAKbFe
   DfKjyaoppAhg+H/lgoJWBxABcdFB9aPJdm/cM450J3cH+4q+EnaidYc66
   Kn4AlzlpPIpH0TEVaTESv8I+3gNcK9phpRReKbv4+QN11UArDf5FkjwWK
   Q==;
X-CSE-ConnectionGUID: kX98r6QCQM+V4Isqk7ZkjQ==
X-CSE-MsgGUID: rAyzFMp5Qo2SS5vkyMDj4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38638994"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="38638994"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 07:25:14 -0700
X-CSE-ConnectionGUID: XNhUS75zS7mBMg3gZMfAAQ==
X-CSE-MsgGUID: cdT5rfEjTFqd5WUCaco9Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77234110"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 07:25:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 07:25:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 07:25:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 07:25:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9ztRU4lRchru2zvKmbq1TEqOEPd0H3iAZHf7O+To7eBJ0UmDBEwvMDide7ByQ3GOJGGF4DX3oMSF5ig3OhJstRAtJ3CQQtP91gwlphw2wl2R5RwsjbJ1SXOMxPVKMf6z3ahJ5182AfZL/OhHwdsnKC8G5l0uniRmMfy6ropSb0kLHXIz36kYAB6Rw8pZqjQiUDzVrihWZs8mbRWSi4BqpRniNRnVqvz979Dj/CVQ5xV2zPUup5dgdX0Erec5wFY1NuCwpGQoVJjzdGV2Xrym59OfO+HMHqqSXv94B7cmQGw/qAxyZTlAnPiVNMG/w/VwHLLPAmpm4kH9GTVhmrJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAEvNiKKJSYvGjb0fft1jQDYxLvXbV3pAR7zK/4+/jU=;
 b=x9GJPMSpw9A+iCz93+R/z0eQZbIQxTh9LO6KSYzoqUCJqmOo9YVHNOLSYL/OZ1SfcSnr7W9zNqcUGVo+qBTUlZ38LD3W+kWfMhZr/eOLSW/1loUMW/8zkrZSuWFjdB6mTd3uHldQQlDc1+UhSxm+ivrbodewNJdBiu+iw+yQvt8Zcn/nP9L6J9eiqWyjDAqvWK30ThS+XDbOJKcgBfr6NXNTKLXGK/21RXJKO2D4CKf6rccc9J4X8YylX0M6gHbAezYzlwAc/I0/BS2CU5DobngMAYwLmvJRVk/z2FO5xqu/d6vam4KNfEU7/oWbi/FX8T6I17+FmVehbc9SOshXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MW6PR11MB8392.namprd11.prod.outlook.com (2603:10b6:303:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 14:25:09 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 14:25:09 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "saeedm@nvidia.com"
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>
Subject: RE: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Topic: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Index: AQHbGkZvGPkGlPu6Y0mXskgCaB/USrJ+WQiQgAAbU4CAAUdtYIAAIOqAgAAWBWCAABxWgIAACf6AgAEEuwCAAEkssA==
Date: Fri, 11 Oct 2024 14:25:09 +0000
Message-ID: <DM6PR11MB4657805DBAA2CCA70D233D2B9B792@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20241009122547.296829-1-jiri@resnulli.us>
 <20241009122547.296829-2-jiri@resnulli.us>
 <DM6PR11MB46571C9CAA9CBE56D6A5FCFD9B7F2@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwaN7XZpS6tEnTdB@nanopsycho.orion>
 <DM6PR11MB465772532AB0F85E9EB6E1719B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <Zwe8M7KZHOLGzUXa@nanopsycho.orion>
 <DM6PR11MB4657E57046E4263E2ADBAED29B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwfmcTxYyNzMYbV6@nanopsycho.orion>
 <DM6PR11MB4657140103B9C33B3899041E9B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwjJiqFbDWwUNh9_@nanopsycho.orion>
In-Reply-To: <ZwjJiqFbDWwUNh9_@nanopsycho.orion>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MW6PR11MB8392:EE_
x-ms-office365-filtering-correlation-id: abd7974a-e8f8-44c2-76d5-08dcea0082a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?asQOwQMCpJdsugh3u5yiFhjH4xwZPhI5SlnyD7K4YW5dsXNxEu3SZJi6ynUP?=
 =?us-ascii?Q?4PgNsrfle08xx9+biitx3Vq/dta3+Ny6vxxRKGiWTDhU9OUs+2l+VbLfC0W0?=
 =?us-ascii?Q?V+9tkwankpSAtRyLDtj8ttsMoHgUaja4nkVndIIxdE/BwAn4KDeT7uLwAJdU?=
 =?us-ascii?Q?y21HkOQ+NWw0znzSiZPBccnEJ19cVTeEuGkbA4qxvDkhQ8rItG33vsgNX1Gj?=
 =?us-ascii?Q?S5tromC7a75/dJI+g1L94ndbospIAY0tsE4xcCqabQdcQxsPgV3+bC34b7e6?=
 =?us-ascii?Q?Apr7cBJTTFf6X6I1eg8lsAZN5ZfEOpxNJbJ8OMaw6aBy1IXmLmJTUEATdt10?=
 =?us-ascii?Q?ZBnF4SIJq9k3MWs/kGdokvcIQK8sMVgX7ESRXP6v9+JPOb+L61bPJzNElpsZ?=
 =?us-ascii?Q?3f4GdL7xP8WU9cixGQpI9LO7Yo92aT9zwPvt16Qs5c/3AcrL1xqcNax6yr+B?=
 =?us-ascii?Q?A+tyfmqJJwiJvY0QMvBHdGEwzscvPoc/212akBjAxmra434FkibKIlU/dNXJ?=
 =?us-ascii?Q?enujgtmtz8EhQ7y34c+7nEdm9uIW9n0fZl5S1X+0LmFZWczd6eWb6tzmgWX+?=
 =?us-ascii?Q?59uOrAVk6lgZ22/OWaWcRWpCrYJh3lYf/ITaAGXbdSe9ZwRrkZu2ZgfjQv0t?=
 =?us-ascii?Q?BI4P0CtlpJGcdKO3xTLsOJVm+dGYr0Z5A3hvcKyXTW0wGUx9i063hdxfsQMP?=
 =?us-ascii?Q?eIv6ZfFBsQ7kwvumQ95J+QYML6eHJwDGyHEvhsDworru3RIz6JL1QH3zVHmf?=
 =?us-ascii?Q?XcnKd7/T2DX6IiluAPPEigHArQn4qf8lY7whIeVuO7wsNu2Pp+l8K+7+99XM?=
 =?us-ascii?Q?CRO2USLjqQRl4nRvz1bohbavlYOz0yicYFfw8TX6mJPwGMB2NyGFZQMsPnN0?=
 =?us-ascii?Q?cVpq9252okcBuceNFf0HO/ruFXEGvFmVrc91c5edjQNZHT4JSoTWoxBD75Xo?=
 =?us-ascii?Q?eoL4NVH3XZVt3twROZhqmkH9XezLs4alislzD4mPrxmXH+oqNDtmgnNr5Nu6?=
 =?us-ascii?Q?zqGCDat1DNdWaLOPrxO6EZvQLOcjY5BLLIcvs3j9h6UAG/IvavwuCnd4e7Bf?=
 =?us-ascii?Q?dcZjPEOIqmjX1zNsbcIGIKM4HKeMGzziWyf4GhYgUG3D/16+kYrYAsYc8rCK?=
 =?us-ascii?Q?3XEnMvKp7fnuhbGQ/XsICmonJ2SMC5IJrTxxU71MvrROvPtEuOB6TBj8+3mW?=
 =?us-ascii?Q?NndumIaHnijbIYHBGtEKl71b+3ydX/rLCVSuztdZuxU4IFpx3TGXI1CjzA+i?=
 =?us-ascii?Q?1aECAu9F3w5GgwmLBU8C0GP2bVY2jrx1dfCm8gHygCLUCQJRuwsqDHCQv2gm?=
 =?us-ascii?Q?B9HDaE2I4E1I9GGkeBlQBfb/NKf93jG1RgPAlms8aj64Wg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zcgD0KcuLgVXR0caQiIHN2XkPv0hA4ARbGPphNJWPmiq3BuNwof4MSXYsZ/2?=
 =?us-ascii?Q?9x0T0E1Wle/KXuIEsKWm94H7k9JenVZokNGDbl1t49xVYfpVuEUi+SOKt2sm?=
 =?us-ascii?Q?CW1vsrVa0zvjaTJMCmeftHNqoquytHozwSeObUqj9CtA+i0tD4bC14KGypse?=
 =?us-ascii?Q?BRPz5n4cA1N5tqjgIqf4OCec745Ek0J9bgWfy8+GgGLV00uB7q9UXwXt4Ty0?=
 =?us-ascii?Q?fLdD8tbdkqjYwbHrv0299UN4ZmMiOufAAls1AeRbcWeX8NynS4Sr8XyO1WOD?=
 =?us-ascii?Q?M2KJCkKWBNXO8KmKK4QYiEqDcyawHJQtIOUqXpAhycowkU+i+/x1WR33EURj?=
 =?us-ascii?Q?sdQVhshRBq3xHzZJ+qW9d0VrAR0FulLqevvrq8K+xdhuB6M/pxCJD7FYvLfo?=
 =?us-ascii?Q?4Gu+f0p+RAdFHr0aIrT0jpvHS5gLjlF5KSfvVIVta2qAJoxJYg7bPFKscrZI?=
 =?us-ascii?Q?MKdqZ75vVdwUV4v1KeIHliXf2IZ0NrozjmEF8I7dUJcM3BEzUEkMo2l4aWWr?=
 =?us-ascii?Q?FqTIYYXBq9NUBV+vsc9mXACg42azz7C9q7xIJKygVZc9wSZfC9aQmj8rxgkb?=
 =?us-ascii?Q?tXkQdSHdXJO0Zi/1DbXWLAjc73AoDRjeLoLT1kkUB4dWCruafkY4i9Ow4o+L?=
 =?us-ascii?Q?2x7GQeUN52JPy6whrxmKcgDQhtWhzlAQlZXv8DKKHmE4JpmkVzjZSPvesfZY?=
 =?us-ascii?Q?wgxtx81imOLfUi+CZK6mJCtCAaxn8gfKFuXZV7/CuO8LXjfVxvMuIIE2wyAG?=
 =?us-ascii?Q?KZJz4Xy8JCfp8WiIeXfuRa2kHZn+R7GJEhfSXLv4CtdSw0LCuwCivxn70Pkw?=
 =?us-ascii?Q?p/iDmjzB+8a3RUhaK5oIuJko4NB7Mo+M0MnLJCiKUGjhkI79yS0HAImQIBbT?=
 =?us-ascii?Q?IdiK4448JxstVwt75tMYKg6ramrfCTxP12ZqASkm7DtwedYNSSX0m1uitGA2?=
 =?us-ascii?Q?o/FfA3NJq5gXO3qXEIXXHRo8P9SNNE46uBqh9ouZVoi0Aj+GW20UY4F0QOoN?=
 =?us-ascii?Q?FXyKvPvwHQpgAuWvW+uCgu69Lw26/sDiTtiga+Qe1lS23QvYGe5dnDxrMNaj?=
 =?us-ascii?Q?ODkpRi/es1hS7Ls4EfCdHDBNKeSf8b/V0MXFoblzFyAmx6TOmMbsOaJWJwhV?=
 =?us-ascii?Q?eEuKCdXRRkMgDCSosy6IeswZgj+rzQDfVEBo9Zvs6aCAUkJrGHOVTaAogLyV?=
 =?us-ascii?Q?MfqhwDT7NsTobRtivhn/+D49mA8cq0cs6MLExoiDGN0EXv6sRK2ixKNx2kui?=
 =?us-ascii?Q?6rTHpHGkYLgT3dU+2AAdSCiEINCUW5vG/FUwc9zcMJZISjt973pxtiKNa1Sd?=
 =?us-ascii?Q?pSn2wuhuPw/O5NJ9od8dGEJd4akQi/ZIS1pm21EvD/TxQ9K/s/1dDi/0rU7e?=
 =?us-ascii?Q?aC50Pza0hvM+QkuczK8ZQe+hIkAOeVWrsIna6FQmWbrY6tGIfpuZN4oOwA6E?=
 =?us-ascii?Q?59BFvQstzCgr6BtfTUhhATvfsCYp8FATvA4PljJIBsbOBICqiKC5iCt4cwMw?=
 =?us-ascii?Q?hFf1lGynfPEidCYK8pmgFo5e7U3iPe5dzKrprlJzQn0iyKpFhr2hc1JCe25x?=
 =?us-ascii?Q?thPWf+pvlOl3X73KquRFrZdFz9OZGkQ9NZLekslligqA6W0vYezoz1Cm/HnW?=
 =?us-ascii?Q?9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd7974a-e8f8-44c2-76d5-08dcea0082a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 14:25:09.1733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCZgVFajhcnh6CSqz9J4b2oiGQzYwQr7xFKD5IeXvgd1GuMp6jj7ZFtaj2e45CRH7DFwmZD88oyZDHeTBUOFwpVDwS48cgKqeT334+HAdiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8392
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, October 11, 2024 8:46 AM
>
>Thu, Oct 10, 2024 at 06:02:56PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Thursday, October 10, 2024 4:37 PM
>>>
>>>Thu, Oct 10, 2024 at 03:48:02PM CEST, arkadiusz.kubalewski@intel.com wro=
te:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Thursday, October 10, 2024 1:36 PM
>>>>>
>>>>>Thu, Oct 10, 2024 at 11:53:30AM CEST, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>Sent: Wednesday, October 9, 2024 4:07 PM
>>>>>>>
>>>>>>>Wed, Oct 09, 2024 at 03:38:38PM CEST, arkadiusz.kubalewski@intel.com
>>>>>>>wrote:
>>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>Sent: Wednesday, October 9, 2024 2:26 PM
>>>>>>>>>
>>>>>>>>>In order to allow driver expose quality level of the clock it is
>>>>>>>>>running, introduce a new netlink attr with enum to carry it to the
>>>>>>>>>userspace. Also, introduce an op the dpll netlink code calls into =
the
>>>>>>>>>driver to obtain the value.
>>>>>>>>>
>>>>>>>>>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>>>>>>---
>>>>>>>>> Documentation/netlink/specs/dpll.yaml | 28
>>>>>>>>>+++++++++++++++++++++++++++
>>>>>>>>> drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
>>>>>>>>> include/linux/dpll.h                  |  4 ++++
>>>>>>>>> include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
>>>>>>>>> 4 files changed, 75 insertions(+)
>>>>>>>>>
>>>>>>>>>diff --git a/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>b/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>index f2894ca35de8..77a8e9ddb254 100644
>>>>>>>>>--- a/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>+++ b/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>@@ -85,6 +85,30 @@ definitions:
>>>>>>>>>           This may happen for example if dpll device was previous=
ly
>>>>>>>>>           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>>>>>>>>>     render-max: true
>>>>>>>>>+  -
>>>>>>>>>+    type: enum
>>>>>>>>>+    name: clock-quality-level
>>>>>>>>>+    doc: |
>>>>>>>>>+      level of quality of a clock device.
>>>>>>>>
>>>>>>>>Hi Jiri,
>>>>>>>>
>>>>>>>>Thanks for your work on this!
>>>>>>>>
>>>>>>>>I do like the idea, but this part is a bit tricky.
>>>>>>>>
>>>>>>>>I assume it is all about clock/quality levels as mentioned in ITU-T
>>>>>>>>spec "Table 11-7" of REC-G.8264?
>>>>>>>
>>>>>>>For now, yes. That is the usecase I have currently. But, if anyone w=
ill
>>>>>>>have
>>>>>>>a
>>>>>>>need to introduce any sort of different quality, I don't see why not=
.
>>>>>>>
>>>>>>>>
>>>>>>>>Then what about table 11-8?
>>>>>>>
>>>>>>>The names do not overlap. So if anyone need to add those, he is free=
 to
>>>>>>>do
>>>>>>>it.
>>>>>>>
>>>>>>
>>>>>>Not true, some names do overlap: ePRC/eEEC/ePRTC/PRTC.
>>>>>>As you already pointed below :)
>>>>>
>>>>>Yep, sure.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>And in general about option 2(3?) networks?
>>>>>>>>
>>>>>>>>AFAIR there are 3 (I don't think 3rd is relevant? But still defined=
 In
>>>>>>>>REC-G.781, also REC-G.781 doesn't provide clock types at all, just
>>>>>>>>Quality Levels).
>>>>>>>>
>>>>>>>>Assuming 2(3?) network options shall be available, either user can
>>>>>>>>select the one which is shown, or driver just provides all (if can,
>>>>>>>>one/none otherwise)?
>>>>>>>>
>>>>>>>>If we don't want to give the user control and just let the driver t=
o
>>>>>>>>either provide this or not, my suggestion would be to name the
>>>>>>>>attribute appropriately: "clock-quality-level-o1" to make clear
>>>>>>>>provided attribute belongs to option 1 network.
>>>>>>>
>>>>>>>I was thinking about that but there are 2 groups of names in both
>>>>>>>tables:
>>>>>>>1) different quality levels and names. Then "o1/2" in the name is no=
t
>>>>>>>   really needed, as the name itself is the differentiator.
>>>>>>>2) same quality leves in both options. Those are:
>>>>>>>   PRTC
>>>>>>>   ePRTC
>>>>>>>   eEEC
>>>>>>>   ePRC
>>>>>>>   And for thesee, using "o1/2" prefix would lead to have 2 enum val=
ues
>>>>>>>   for exactly the same quality level.
>>>>>>>
>>>>>>
>>>>>>Those names overlap but corresponding SSM is different depending on
>>>>>>the network option, providing one of those without network option wil=
l
>>>>>>confuse users.
>>>>>
>>>>>The ssm code is different, but that is irrelevant in context of this
>>>>>UAPI. Clock quality levels are the same, that's what matters, isn't it=
?
>>>>>
>>>>
>>>>This is relevant to user if the clock provides both.
>>>>I.e., given clock meets requirements for both Option1:PRC and
>>>>Option2:PRS.
>>>>How would you provide both of those to the user?
>>>
>>>Currently, the attr is single value. So you imply that there is usecase
>>>to report multiple clock quality at a single time?
>>>
>>
>>Yes, correct. The userspace would decide which one to use.
>
>Wait what? What do you mean by "which one to "use""?
>

Generally if you provide some information to user, he shall use it
somehow, right?

Maybe you could explain the use case as you are the one developing it?
Is this to tell user a quality level of your device itself - without
anything connected?
Does it change during runtime? (i.e. locking to a neighbor?)

I already explained my concerns: if device would be providing multiple
clock qualities for different specification options (i.e. ITU-T Option
1/2(/3)) and they would differ for single device with regards to the
meeting certain class spec requirements, the list of those would be
required. Since the names for both do overlap it would be not possible
to let the user know accurately without changes to the uapi.

>
>>
>>>Even with that. "PRC" and "PRS" names are enough to differenciate.
>>>option prefix is redundant.
>>>
>>
>>I do not ask for option prefix in the enum names, but specify somehow
>>the option you do provide, and ability easily expand the uapi to provide
>>both at the same time.. Backend can wait for someone to actually
>>implement the option2, but we don't want to change uapi later, right?
>
>So far, I fail to see what is the need for exposing the "option" info. I
>may be missing something.
>

See above and below :)

>
>>
>>>
>>>>
>>>>The patch implements only option1 but the attribute shall
>>>>be named adequately. So the user doesn't have to look for it
>>>>or guessing around.
>>>>After all it is not just DPLL_A_CLOCK_QUALITY_LEVEL.
>>>>It is either DPLL_A_CLOCK_QUALITY_LEVEL_OPTION1=3DX or a tuple:
>>>>DPLL_A_CLOCK_QUALITY_LEVEL=3DX + DPLL_A_CLOCK_QUALITY_OPTION=3D1.
>>>
>>>Why exactly do you need to expose "option"? What's the usecase?
>>>
>>
>>The use case is to simply provide accurate information.
>>With proposed changes the user will not know if provided class of
>>ePRC is option 1 or 2.
>
>How exactly does those 2 differ in terms of clock quality? If they
>don't, why to differenciate them?

All I could find is that the same name of clock class the quality
shall not differ. But again I am not saying we shall differentiate
the clock class.. Rather an ability to provide each one, keeping in
mind that device can meet different O1 vs O2 (vs 03.

How would we extend the interface to provide Option 2 clock class?
I still see some entropy, I mean higher then expected..
Let's say device meets PRC for Option1 and PRS for Option2, how would
we provide this?
The same attribute twice? This seems also possibly confusing for
certain cases.

>
>
>>
>>>
>>>>mlx code in 2/2 indicates this is option 1.
>>>>Why uapi shall be silent about it?
>>>
>>>Why is that needed? Also, uapi should provide some sort of abstraction.
>>>"option1/2" is very ITU/SyncE specific. The idea is to be able to reuse
>>>"quality-level" attr for non-synce usecases.
>>>
>>
>>Well, actually great point, makes most sense to me.
>>Then the design shall be some kind of list of tuples?
>>
>>Like:
>>--dump get-device
>>{
>>  'clock-id': 4658613174691233804,
>>  'id':1,
>>  'type':eec,
>>  ...
>>
>>  'clock_spec':
>>  [
>>    {
>>      "type": itu-option1,
>>      "quality-level": eprc
>>    },
>>    {
>>      "type": itu-option2,
>>      "quality-level": eprc
>>    },
>>    ...
>>  ]
>>  ...
>>}
>>
>>With assumption that for now only one "type" of itu-option1, but with
>>ability to easily expand the uapi.
>>
>>The "quality-level" is already defined, and seems fine to me.
>>
>>Does it make sense?
>
>Sort of. I would still very much like to avoid exposing multiple values
>at a time as it complicates the implementation, namely driver op.
>
>

Well, true.

Thank you!
Arkadiusz

>
>
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>
>>>>Thank you!
>>>>Arkadiusz
>>>>
>>>>>
>>>>>>
>>>>>>For me one enum list for clock types/quality sounds good.
>>>>>>
>>>>>>>But, talking about prefixes, perhaps I can put "ITU" as a prefix to
>>>>>>>indicate
>>>>>>>this is ITU standartized clock quality leaving option for some other
>>>>>>>clock
>>>>>>>quality namespace to appear?
>>>>>>>
>>>>>>>[..]
>>>>>>
>>>>>>Sure, also makes sense.
>>>>>>
>>>>>>But I still believe the attribute name shall also contain the info th=
at
>>>>>>it conveys an option1 clock type. As the device can meet both
>>>>>>specifications
>>>>>>at once, we need to make sure user knows that.
>>>>>
>>>>>As I described, I don't see any reason why. Just adds unnecessary
>>>>>redundancy to uapi.
>>>>>
>>>>>
>>>>>>
>>>>>>Thank you!
>>>>>>Arkadiusz


