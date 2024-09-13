Return-Path: <netdev+bounces-128248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02F0978B79
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 00:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304DF1F25988
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 22:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C7E1474A5;
	Fri, 13 Sep 2024 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H49wj2m1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941547489
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726267555; cv=fail; b=NfHHJeX5Q5qR62VhyYs+N6Ld3mLQRSrHXK2NMK0SD7dnBGBb275s2u9Ez7f+RGIEAxzBDyf4/vthXOejtEKG9xwCg8vnw37c/kAGvpYDAbYwjswOQtD7fXFJB3hi90KRZwTyg7yTPjMcSI2tJXWzgxD5TrGDLNuAPbB04VYB5b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726267555; c=relaxed/simple;
	bh=ND/d7jjGTz8EPRPRf4O/rQwNvP9b5F9Lmtf5/MFRTdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cf58vksQnZAQGw3jbZ+KP/wEBlyd0sJvsVcz28Pfy5JbzU3D/961SGcJ2vdPw8zPW7Hp9HHJxj72vWJeNeDCf6HHm3VtwaCgrVljFREdGgkkN0nFifmY079Xz4t+axTBaZj/eQg0UzpDzl0YC9VtNaSc+V6KgwYax6qKgh53tX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H49wj2m1; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726267554; x=1757803554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ND/d7jjGTz8EPRPRf4O/rQwNvP9b5F9Lmtf5/MFRTdk=;
  b=H49wj2m1n6LG5LU2e1tw2hwepcOgrPXEwk+SMc/Uf4bh7FCudNdJgeAl
   N8UCDihQ7T3VVjFj0kZ495Zy3o7ZLP9Bm4qpGOTf+pPTMxaT+RSKeIC1V
   ft8rzl6o41yLsc+j89VCLrq2ztvpmXZ15uQvpB3ibVuyUpH2PC5s6dGo9
   2LU/sAcTpFpWBMuJcyvmE7zohoAR0guiUUGQCqG7DltqnS+Zol39p+kfT
   NZ0KKh6BEyl3/1aAwQGmQLqAZSUrzQyk1hQFcrJHp5FAJhlUdvq9qRg5T
   Thd27ZUJ/rW9U5+WA+b2K9JxWXKj8eBm2VzUykIG2xCnNanBI+9srxdlX
   A==;
X-CSE-ConnectionGUID: 2s0j9CSlRbaTL0b4m2mpkQ==
X-CSE-MsgGUID: EWPx/OMRTBOXYGBCKB8HQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28096357"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="28096357"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 15:45:53 -0700
X-CSE-ConnectionGUID: J9Vi01yjRLCY/2gdmBP8sA==
X-CSE-MsgGUID: tKXYskUlRtCqhA56O+1ZrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="91489469"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 15:45:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 15:45:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 15:45:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 15:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT+y0b0VHn29X8LAkXm1/yR+bEjDJ8fRpjfQd9JkxvRw6EwhneGAmhQHsBfHmuUFQsn4i4CLVqRyfzoIBiukVN2LlkEhPNATGM2pUj1UexQhqvVMzSDtERr+zsdn18c4jebgvNvH4HreUSnNIiP4eue0V1nv8in+Z3Xcwo5FuJzKHkK0Kxrz86jlkCy65HebW0jXWhsg5XfiqGSf35EEnUZL2mMLHiBBrOfgHv5BwtyGxIs7ZWC4PSurgU8fIs1QBM+dyEpbb7r3hmEgeVw5xpT7izcdE8e4Uc+CTXU7uUyyrPKaQuIvo+7aGOWQxv2sMX/+EANUiuyEAYU8bJR+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6pl/HVbh1EkMx9ZFSR77cv9zfJ4Oms6ONy6ng07kCM=;
 b=srX8xD5mB2ca2J6wRtYtGaMHfvkIA/mee5C/t9Z1/e1v9hGDHraq4ZWe3JRIvcXFig2ofDi3iAjaSrQiVkwkMVnhmgWt+a6XZk3fN5cqRIL//etfdwkmp1RgmI1/q0WOXZqHjXxzik8FH8lkpD0wlhEUi/y4984bhwWvBMNL9HqyqlNNFPhX907UhiEhJBQUMAlI2S1mhFbRxNUEbZEjtAH7BoJ4TdlqL2rpqJTomZTQc+mKM49mNrp2FLCv+QRxRs82jwR0i0xXk2eNGpNbBS+Wyrhkd6gfbGEZapXuqY+16YGxtccE0bXLTmahwy4WyTyA6ZfmzcKrhIXGvL6/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 22:45:49 +0000
Received: from IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::7f3a:914e:c90e:34fb]) by IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::7f3a:914e:c90e:34fb%3]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 22:45:49 +0000
From: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>
Subject: RE: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Thread-Topic: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Thread-Index: AQHbBcDCNfFxzJCH10CXGFshkzVK97JWT2gggAAB+IA=
Date: Fri, 13 Sep 2024 22:45:49 +0000
Message-ID: <IA1PR11MB62665A55D20446570A27228AE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
 <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6266:EE_|PH7PR11MB6772:EE_
x-ms-office365-filtering-correlation-id: 564f8de5-1400-4d7c-ace6-08dcd445d06d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vZXZEQp/YYN7T7sZSkEKF5K82rHqTANEerFytSdcL6gXkq3NcY15nymRHMLH?=
 =?us-ascii?Q?TuQtz3yP9mU8besmiESN25AQ23uE5dGbKLRu3yHYZKahWcDVgtPUTqB2Pz4p?=
 =?us-ascii?Q?1OVAr0C62gar/AWZdGLwJP4HAPZdOpPk56A2HEZm93RogK0S/rVe7oxop6z5?=
 =?us-ascii?Q?CtAM2ZefazQ+VtPWx5nqGv7hukuDUXlGokRC18uPqFMZJ9Nm/3LmwRFoI1LO?=
 =?us-ascii?Q?jn30nhSdc5vAtAMVbZ8cOJb072kfsT5eGd+B+8+w+UTI67xRR6gNgn7ONBYH?=
 =?us-ascii?Q?iRAniGmyUfZE2IP6q3azZZixKOOZwmcn1eOwaR3TpcG/xiQsvPvB2IkQDHPI?=
 =?us-ascii?Q?14gsSk/EI1wVtw8iLWU9P/F+Zzyt4B6RXBdnOOj4tiT+DMdNqjQkyOukuPWp?=
 =?us-ascii?Q?mNthoPkZiaXcXnqe4YqgndZ14sBZxnza+6oSycNIsF4A6gSoE9tZmf3f7Ggw?=
 =?us-ascii?Q?kx6kCXsf5VUJ0xh9Os+xG/rljr1xw0lDg3Yxyp6s7en6iov/5lJ5gNr3T109?=
 =?us-ascii?Q?AuMpO6wSo/LuLV1FhCR0pYRCEupv8OHUNQao1mN93Kxlov1fQBhulpI2HTpp?=
 =?us-ascii?Q?LKLqk20Dutbt5IlCSMUgXNwEM0BcKnNHB0LDi+bJMob3H/ohzJ/+I6SubBUu?=
 =?us-ascii?Q?9t3nAhzdkPTav+apaYELHG8CvgKg+m+b86KzH0EJ8YUaLYHlxjkWQGTG0sjS?=
 =?us-ascii?Q?uEmbqyRzHqrXoGwMt/h8cstF1PjYGUCbNpdLRHzN5pZt0myhWq6peSrtCN8e?=
 =?us-ascii?Q?8Ol7BV1vQ6bO9AA4RNPcGhErnxSArwCrinRbzVFrpRBAu75EVT1DPYTteOTq?=
 =?us-ascii?Q?6JPvS0SSKpXnj1O3uAm/Ot8MmSisDnrgBJBLflvYnUMBvt4AGVE2ON5yOVJr?=
 =?us-ascii?Q?kD268+dgS4MivHZPI89R+loKxLkgzU+cFQxxMAE0fn3gdati+gTlS0Z43LIq?=
 =?us-ascii?Q?6j9SiRbp0oU2TH6rx8vrxhGHDLiP9LjF2Sj5BRMVXeOuBGS5ORjcJDY30Dcy?=
 =?us-ascii?Q?WT99YB/ZcyWFDef/61n2mQ8i+dZne/1/C7xkZzbPyRw4+JyO0v8tVSmP4M40?=
 =?us-ascii?Q?LfOBl4c4Ad3DH+QZ6OuwIhr9nmtoLica/vWJQ5qA/AMbfBdCQXjNqsoAR/WK?=
 =?us-ascii?Q?WzXT1siBAkPBFs2kPmNMmxAXMuK7XHFgKDixYtEDnagucEeRXGDkh5W2M7eR?=
 =?us-ascii?Q?R6SssKEdglbDaKc3m6faLPeH6Gu0o/qhq0j5VPErhUHM9RLJuAviT8VXsfxJ?=
 =?us-ascii?Q?3SLiygsC5kI9cJ9EVUWkxIWpq0EzH8vPNusXzUjIniYufN6EwZsLWzd5TVL1?=
 =?us-ascii?Q?qKuwpmqsdW5w+JOlmip6Xy79WRwfxVffk+WoeZswuWZl/c9Puh/XwL/Q2k8k?=
 =?us-ascii?Q?+cb8sGCi0E5za+NMCrmcnKwtGwGp+WpzjxzxeYdtqu5i2ktpEA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6266.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VY3+xi3k9PzhWP+rVGUh6cfBye00TEiDuMWS7CfrkfVan7biarzFnz+0N523?=
 =?us-ascii?Q?1DMo09R6f1B4lqyHRGdE99r8vAZ4MFFI04rDrpC0nu3H5VVJ0HOXhQHvBQJa?=
 =?us-ascii?Q?6wHRtMEkabFrhD7aqlU+w9cacbCUmtZSDk3nili03l0r0GDyipAvrgX+W52G?=
 =?us-ascii?Q?6+qKno1n02J2uFkbh4X9F3jS6FuWAQnh/aNhvWuAj4E3OPAO2rpLHqMqmnoM?=
 =?us-ascii?Q?CURWzSMC7UKhQ/CBQHwIoUfAm+duzBG9j3N4f0DDQA4GgVj1GR+eXO50BV0o?=
 =?us-ascii?Q?CQtAn1ihsEjppoFhlumvWnOPdW3HSPX5Zy6Zc6IfBvBAdZJzeKmANz6nR2SP?=
 =?us-ascii?Q?53nqpdJ+TWa23zrqNrbkKzsUcU3H/uTt4ZZJcWUIaRFJC6jURa9U56GrBzmk?=
 =?us-ascii?Q?47g0arKNtwt2W3Ihv9MA14k2XHUCQ4TaJydRtJnl9+fOZ/9VWRRF19ynIfl9?=
 =?us-ascii?Q?ACVvsmTpzOx7qDlDxQxiAcoiQxD7ev+03lOK8fdxDbMDtralwCbaU2EHpo9+?=
 =?us-ascii?Q?jfkLl+KsU9n5FiRQlVLD546L5EMKSUa74M1d2vt1D0LJT0YK3ioGec2IwLKT?=
 =?us-ascii?Q?rALgYX0vhNyPp1p47PhqYPq6DzlkeyydSH74gAzS5BCtGR5HLDcGqmTMURTj?=
 =?us-ascii?Q?ld9yxQOYHsB8cML+K/YFgsfu8KLhxTV1GNfKivE5Fp/UugzTP7sHgLyyW3n6?=
 =?us-ascii?Q?ahEGK6UGsuVs04Tgi4RBEjD0Vj6YmfuPO4sGrezfHVrGRewgHkE04QDMV6hF?=
 =?us-ascii?Q?DbQEa2GAo3U5jm0tC5MSIQGGp3mL0a0JJvyy5a8JOvy9j+WMy+thFXXDCNfU?=
 =?us-ascii?Q?/lmHz68QviK9Ywxf3/xEBELpvXGZcGNCi1JQgcE4h0cGrV2Ruhe1oEmGQodq?=
 =?us-ascii?Q?RLRaa9cutOTTobUutMaYI3B4b/YKoO0xZpSkF4FS3W0RYUIoDRUgE4jQPnEy?=
 =?us-ascii?Q?FEvwM6kqefoAshMzzOuQAzdU0lDDTaUbZOZSTxSk7EBrVeP592cEU35lQ6Ea?=
 =?us-ascii?Q?rDATCKAmv4QVCbyYmNAJ7iCu2yNX2iGlRjY5YkrbNkUgTm2moLZ5zRXBwof3?=
 =?us-ascii?Q?Ddbl2iDlc3fCQY/r67m2byJt4SR+H6LepIUQrpzMSpdtO201CTPYi/tcZMb8?=
 =?us-ascii?Q?A77WbhwZtlL/54S9JaBHjpeznDJnI0U2WNpOZDv+aMCzFZlYWVmGWzYhxXg1?=
 =?us-ascii?Q?Xw14t7qs2b7Kk9eu1XY85SBkymL3B5OoDmwLwI22S/0b5HHMJZrZnZllWoDi?=
 =?us-ascii?Q?8GYuwwNuecWDFDa00Zkxz9imbmj5DAEpnWBgFhDSJ14PvgPYEUwR2gsu4maY?=
 =?us-ascii?Q?LY1QbcZH3VJcIRqZ/fwUBs5b3ryyiSrgI4jNFor5XFzfrtU6eGDnYeSj2oU4?=
 =?us-ascii?Q?tG5TL0wdF33IhZcSbTTejMSIm1MHluiUyHBsNQw7c462mQXvpL8lWesoO7ca?=
 =?us-ascii?Q?yqMJ73nRu+cb6n9PDUegZUZgyEuYXNHR3D9ruFvXHAjTAlkH8YkQ2SuyD+iD?=
 =?us-ascii?Q?Gb4uuXWJqPvh6SR6O0jlWIE1AdFd2zJHeB0L3ooykQt6DHJo031XpbotMov4?=
 =?us-ascii?Q?Degc12PvNt1QI9CaJbk3tPOKa+vsLi38v19vWtuYwHINAtwjX/AbcvOYRZ1Q?=
 =?us-ascii?Q?WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6266.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564f8de5-1400-4d7c-ace6-08dcd445d06d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 22:45:49.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4bg1LXxt4azE//WrF1R9qfMX85VMOpCnHE1ysywffN/PLZFWMwlRNYGlJmoQJEx4/6WX2Hlye2Xoku4/1xh0Zqj4EGf4sbvSucEH98SGgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Mogilappagari, Sudheer
> Sent: Friday, September 13, 2024 3:43 PM
> To: Vladimir Oltean <vladimir.oltean@nxp.com>; netdev@vger.kernel.org
> Cc: Michal Kubecek <mkubecek@suse.cz>; Jakub Kicinski <kuba@kernel.org>
> Subject: RE: [PATCH ethtool] netlink: rss: retrieve ring count using
> ETHTOOL_GRXRINGS ioctl
>=20
>=20
>=20
> > -----Original Message-----
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Sent: Friday, September 13, 2024 2:38 AM
> > To: netdev@vger.kernel.org
> > Cc: Michal Kubecek <mkubecek@suse.cz>; Jakub Kicinski
> > <kuba@kernel.org>; Mogilappagari, Sudheer
> > <sudheer.mogilappagari@intel.com>
> > Subject: [PATCH ethtool] netlink: rss: retrieve ring count using
> > ETHTOOL_GRXRINGS ioctl
> >
> > Several drivers regressed when ethtool --show-rxfh was converted from
> > ioctl to netlink. This is because ETHTOOL_GRXRINGS was converted to
> > ETHTOOL_MSG_CHANNELS_GET, which is semantically equivalent to
> > ETHTOOL_GCHANNELS but different from ETHTOOL_GRXRINGS. Drivers which
> > implement ETHTOOL_GRXRINGS do not necessarily implement
> > ETHTOOL_GCHANNELS or its netlink equivalent.
> >
> > According to the man page, "A channel is an IRQ and the set of queues
> > that can trigger that IRQ.", which is different from the definition
> of
> > a queue/ring. So we shouldn't be attempting to query the # of rings
> > for the ioctl variant, but the # of channels for the netlink variant
> > anyway.
> >
> > Reimplement the args->num_rings retrieval as in do_grxfh(), aka using
> > the ETHTOOL_GRXRINGS ioctl.
> >
>=20
>=20
> > -	if (tb[ETHTOOL_A_CHANNELS_RX_COUNT])
> > -		args->num_rings +=3D
> > mnl_attr_get_u32(tb[ETHTOOL_A_CHANNELS_RX_COUNT]);
> > -	return MNL_CB_OK;
> > +	ret =3D ioctl_init(ctx, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D send_ioctl(ctx, &ring_count);
> > +	if (ret) {
> > +		perror("Cannot get RX ring count");
> > +		return ret;
> > +	}
> > +
> > +	args->num_rings =3D (u32)ring_count.data;
> > +
> > +	return 0;
> >  }
> >
>=20
> Hi Vladimir, my understanding is ioctls are not used in ethtool netlink
> path. Can we use ETHTOOL_MSG_RINGS_GET (tb[ETHTOOL_A_RINGS_RX] member)
> instead ?
>=20
> Couldn't work on this since I was on sabbatical till this week.

I see Jakub ack'ed this. Please ignore my comment above.=20

