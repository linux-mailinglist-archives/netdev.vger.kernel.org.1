Return-Path: <netdev+bounces-284991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIw9NQ2K+2mWcQMAu9opvQ
	(envelope-from <netdev+bounces-284991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:35:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABC54DF63D
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42ADB30037C3
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC33EF0B7;
	Wed,  6 May 2026 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpqnsGtH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A79309EE7
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092402; cv=fail; b=GhFKILCGxUGnsKkmGImeaaGIfXCDC2IpfbIbWZ0YiaLmAefZxl8HX6o2h/srdliZQV+nsuE8SBeD4V3rMrXEmcet6lEOuWub5YV7l4UZj6Yd8iYmzM54ObWJHZ00DM3prZH4+iP+QiMcWUyo8E59yIXPXzieNu8V6iZXiwDkzI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092402; c=relaxed/simple;
	bh=meQikuvodiOAUtFl7eWrIoYJ2eNpxOVXe4muEu8Co4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TA1KHdWo2f+L5Wee81mDPt8k+HgUobAeMSom/GSJ8rD3GavuzkUstcQb4W2guhBlM+8FSmllIi/ZEFI1gpWvpUwMd6l5QEGfaLXNRNX7mKTUf49SYjqoKygBrJLQYtKLD8huuf+JO0xcfu6aIHQ1pC5qjpSzGA6okya8rbQi8Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpqnsGtH; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778092401; x=1809628401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=meQikuvodiOAUtFl7eWrIoYJ2eNpxOVXe4muEu8Co4Y=;
  b=FpqnsGtH7mIfyvkegMHGVIzYi+VAgUAcF2GE9PP0j5qBUWZ3noz+I/3R
   wqBYzVIKHZqI9518EKfYESokabvs/m7ay3iCp9HDM+nd5YCLS2OpWiY6l
   HPf8CJvWx5WKDCoG3rhN55ZenN74PqSUVyb+k2KoGUVUkv0qaB9Ju1u2R
   rmuA1hWdPsECjUBmKG5PQFnol9AUIsLZJyd4p5YOu/TcTyCQ5CAYQtd/M
   TnMDxY3zefTF9vx9aB08svWbTedq+5TY09VHPYVdYF6RnAVliQkmdJzvi
   DFNQKN9jG4bD8xruZIHCjR6oE89Oz3oxOFHwkp8D2SadUQceptXRmh837
   Q==;
X-CSE-ConnectionGUID: Z8oQp0zxSUC5VqPImt0caA==
X-CSE-MsgGUID: /lfiVF7uSAyMuzePKzi8Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78060761"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78060761"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:33:20 -0700
X-CSE-ConnectionGUID: zK1/3c39Ssy2Jd/Si+B9Eg==
X-CSE-MsgGUID: M3Seane5ThqkC4+rfzQfew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="229831577"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:33:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:33:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 11:33:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:33:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nitf23dI1eHn6IMeRGa1vy3p76GDyi+vAyIdqgANSQ5s4cPvDU0W5davnXjXjVJ/szk7Rf6+XdqyGQRRzvPw7TdN5VHPMN0KR00DpPChBey9iVJPBBluyfQUEfdkSYRIxNgPjItmq85Oxl653obXr6DUMgGNfF4+iqOy00royTTY0ib1Id4J5KX0yIb7+Qfvi3MiN0nUnpnExBEM0UiiRKPqXaLZ/ITcEfz3H2XkZiuxHUuRRE78spzb9McluGx6Ij6Pb8/Fp0Pmft3e21ynkiqEabS0p77a7zSWQhMSH4MzaCq1oi1RVQPPRvEihdtnFfZVx4Y44XjuXjrgAkdYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/8EZuYfoR2y0Z7Nv9jbTlZdPOofN+OINDcNe+KXquo=;
 b=X1YKgD0DtuWU5AI/Eobno1Lx8+eriQmT5KagIXbz7kbs/NzGxUPXqWOSIiZ1z7HK5raekldPtVdcn2IixoLPvpxUBCwCBFbkI3PfSBC0E7u+zoKYNhbQvnJUXKa0T4C2cl1fMjaFJzvUXxhpAhgD4942ueSXGMmHmwqCw7Xy3YOcZDOPfGRvQ55l05IUaon1ZZ5/+8GhDZzy2Wn9uBrnq0bAwXSZDLmz8rfWYAHrHH/qYmrQR1y8BLmlqcUpLe+H0FRy0RcQQ2q8xigdOCavHfKSbammlR7LgxnIVcqJbAtM7lzif41lOiI78i2Jc9i9g9guGYhYNTzFEk4XGczrag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SJ0PR11MB4991.namprd11.prod.outlook.com (2603:10b6:a03:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Wed, 6 May
 2026 18:33:15 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 18:33:15 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 01/10] ice: rename shared
 Flow Director functions and structs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 01/10] ice: rename shared
 Flow Director functions and structs
Thread-Index: AQHcyCDo+LXlGUzqc0eQIRDf0tqFrbYBfMKw
Date: Wed, 6 May 2026 18:33:15 +0000
Message-ID: <LV1PR11MB879020169BC67D3CD1487F4B903F2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
 <20260409120003.2719-2-marcin.szycik@linux.intel.com>
In-Reply-To: <20260409120003.2719-2-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SJ0PR11MB4991:EE_
x-ms-office365-filtering-correlation-id: ac940fcf-bd2e-427a-1498-08deab9defd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info: gIcMn9gFWtF2dJznHaviMTdR1GY0WLACD6TICOmkfIJUXKkq8LCmzlz87muFZIaI8PUzhcihs6tciHnFwfMeptTXaKxMls3HaIhhl6C6OqNeaD/s/ZBrmHOzRcpIhx2XP/BhjRrFldWOssuhLZCWi2kRVfqiW6UEJZXH6ORWHy/qdXLlW+hx6QWF7ypPqXIGxGsdjNnsP/jbA52aI3JEMx5DR7tqO59Hmo5XykXF2ciu5p1sg/wV0gEWksKADMNk+YbA4cvXAusJCQwxwR+pomVjEEaf41DHqJV323HM0OUPNiuwK1peRK5+r2zgbQgTj3Wtr6Eeen4ll1LNXkt2xePKzxaIHdYHoHlBDiCR6O/UQgRCyFy/GSy0pkOulVzhas9ZSi6wGzlm+prCvfYlNjZQ7miZGz2dPAE9v3OxHtDCMBKRNE0uH9PmG17AKbPMG894B5ZOLszrlEr5DTRUrBiiwq9mEN0qZXzLdlXKet5IUBrcNk5kwJQlW/rSIdMlJdtMKSVQNGAeUvvgzqGacavepRWhEDRJr4SxmG8RTuc0dgw27z9qqLu3qREDEEe/Nduciaj8U6rGdnncJntkPft+zTDaDIxTer4lSymmFL15CAhxPvX76jW6mJKuvWvmAw4yooB66ycxHuKeIdgoCVu3U7qYXQ5FNVQjkK1/IaJ/d0w0a5g5Td05cddteS57iqUg+3Zck/eAMmbUgTQC58ZAWYhTsPMLW4yc8Ws5MqLwRwQFFKby6nNRZWpZQnjm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(38070700021)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q7CF6LLpXin/tSmJQskSq+YeE+42sJ2ENhc+jWS2OmR+C6yCl6TRMwABTAmD?=
 =?us-ascii?Q?QV18JepMoO2QXAtFImjqZCFh/hoZocSFGoIsky1r2AQO9HxPuxYKplomPAwW?=
 =?us-ascii?Q?RuXsXcckCZZT5ZjyY1LPOd/ykN992gdig7lUH86iyccp4tLQbeVN8ZHcBvGG?=
 =?us-ascii?Q?YW0IE8yp/4fvhgZ+DnkYIlx2LXKFuzG+KwG8KL3zT51mco6srcFu7t6mOEVR?=
 =?us-ascii?Q?npP5LHNthe3Xnmco/c4nL83hkS6WThT94TW1ZwvtAOJ8U1q1bKE/UKxDeYpx?=
 =?us-ascii?Q?qcI+NbTVZVM5HKoJEi6FD0YtyA6lbqArRoi5mhvgbP1JZLkROdFsjRjUf42C?=
 =?us-ascii?Q?CqrHkOdA6dCeheuHcTSsgefEUutTEuM7T3r8dZoPHI2gZS9z4m2VT7KChltW?=
 =?us-ascii?Q?umnDKvIysptbNm3JpIqQEaxGLodluFPtjBR+RhDSGt2XR5c77VkN6KF2reeb?=
 =?us-ascii?Q?WpbZPcJUHlvhfsxs8/JZS/ul75Xh7zwW0AkPhbStW0wAX9EmkfYA3gO4erzd?=
 =?us-ascii?Q?yhLtVtcFjZMhJ/rpX6niOvN2dtFaak3VWlzJlje7Oq8ZPrB6xAeOPPMC0XTk?=
 =?us-ascii?Q?/r0FRqTLH/g7xOVHK/veDzxjPocG2o7C8SXkYTl7B4XpuOIVb5yMZgrHZ/UY?=
 =?us-ascii?Q?5euuGtH9tqUUkktGoio1DUVn4faBWFEBlDH5j76OXe0ZlPGKSOKdPqv8XItm?=
 =?us-ascii?Q?2/VGyO4ebmbnVqmcKCoCAmDH22TMTcAGY/113G4WHeym5vYOEKccF5wz8SKz?=
 =?us-ascii?Q?TWB+i+laHH+zzWlrldi20VmQBJDoLUKiD31MwbLRJpV2B8eeFRagEN9qqPwV?=
 =?us-ascii?Q?qXmn3bVu42QScpzHWq4trL64l+8CZbwE9jDj553UuKbjY/aeBvTBbaBL5Uk2?=
 =?us-ascii?Q?rLOf3K5h7iGcYKLdeNq0T19AxPM3PjmcHGG2WsGIM0NHJrJC2ZI3wTgZyFTD?=
 =?us-ascii?Q?fNrhxBps44kgdErfgo9TjgM3eQsgCG7kq19FM7Zv/WYvrryIaTuCm02o2YIs?=
 =?us-ascii?Q?3i8gyZQfJyOLnmWfDl5opVUL5wDSVrd29rAxY7fs9V1Xh9ShM28/CcO2bo36?=
 =?us-ascii?Q?y25+WmS0X/kurwqvy+KRlYPwrrlFhOuxhuKEqyolzasbZJgrMU1Xs373dt7R?=
 =?us-ascii?Q?5lPQfqzXinW2skRSSPZ0ku1KMVpB3NgcxzaP5hUdP9jsh3JUQl2vKE3JkxRJ?=
 =?us-ascii?Q?mjm5QZY1quloOBdUoLIbZiGihBoOxnXk2UIzT0tlIV8a7dohCgQYvJqyFezR?=
 =?us-ascii?Q?X8mO+s2BPZPbnFJaoH9OPmg8VX49Imoni4cDMr9J+eZpx3uSRlRrWcCs6gcV?=
 =?us-ascii?Q?NB4kR8aIY79iWUgQsQtddwHO0GcVdd4kiCDlqG7mLHHawW2S/fhCYKjbWrUO?=
 =?us-ascii?Q?gGAnzeRsjXBYm2eVGfZdRg0dhrZd7Z5534FJ9lPOQ4lz79qOXOwg675HvFrS?=
 =?us-ascii?Q?MbiIg+7c1rKm0VvGHa3lDCtSndz4LnRJczNTzwpIXdM+LZX+DdxqEjxQQ4ZX?=
 =?us-ascii?Q?W1RZX8iI9x894gDdVuCEwBvWupZe9TxsYxohsGji4R0P77X+9ebTWYdSc6CI?=
 =?us-ascii?Q?MRsqpMeCyO6pPwAcuf8VHXVKFhhscGUJDx5C40Eg3B4FhlKSETjrJh+99coX?=
 =?us-ascii?Q?G3NmkhpqJhPGWyfRnpbleTiDh+O18QykYjm5AB9CyhbcKEBZ9/lFAems5bES?=
 =?us-ascii?Q?F86i3EEAuxTIJVlD3tPkfsh/gmvjucBFuqkPvFAvSTs4BTIvqgMcP1FVNI5B?=
 =?us-ascii?Q?UQQhgCUYuA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iwH1nmAEyQbCDlKHu72ltZBHLyBEg8NRUKVfXpRHZ2fxbxTUfG2Kdx6c6fTaivpQ7nQmYKdGfDb4qy65KlYumDo/vGT2o8Vd9b3c1bCu/LSRrgJo2fbFZKkHzcXNh23A34CfeSsHH/VM4tL6WTebMiQlOQ2yGuLreVDBetkh4ikyvKkuQffb9MdvX7HaqP5hCha5mhaT/e9Yq8j1U5t3uQKCBXkoG7w96Yx+CUfsscF8YB56/vNYJQ2gNtcALxdyK2uHh65QCX+gkALdhSAu/i2b2fKp9Ladu8wD8kiJ5EjcYNzlCTOLs4X6Xb38vA0rHfDZGCwHrc2rHpQoZySw5g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac940fcf-bd2e-427a-1498-08deab9defd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 18:33:15.4789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/Ydf+dCfHXzbNx1W993rXiw9psXNUj0SiFrn5gdwYxw3Bz0PnqvJ/U3g8oZItzoZxC55igy1NRq4X+P8ja2jWlIqUJelvhsLr9ddF7oNKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4991
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 3ABC54DF63D
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.84 / 15.00];
	URIBL_BLACK(7.50)[osuosl.org:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284991-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email,LV1PR11MB8790.namprd11.prod.outlook.com:mid];
	GREYLIST(0.00)[pass,meta];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_DKIM_ALLOW(0.00)[intel.com:s=Intel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	NEURAL_SPAM(0.00)[0.553];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: Thursday, April 9, 2026 5:00 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Marci=
n Szycik <marcin.szycik@linux.intel.com>; Nguyen, Anthony L <anthony.l.nguy=
en@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 01/10] ice: rename shared F=
low Director functions and structs
>=20
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
>=20
> Rename shared Flow Director functions and structs. These entities are cur=
rently used to add Flow Director filters, however, they will be expanded to=
 also add ACL filters. Rename the functions and struct, replacing 'fdir' to=
 'ntuple', to reflect that they are being used for ntuple filters and are n=
ot solely used for Flow Director.

> Rename the file to also reflect this change.

> Co-developed-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v2:
> * Also rename struct ice_fdir_fltr and file
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |  2 +-
>  drivers/net/ethernet/intel/ice/ice.h          |  6 +-
>  drivers/net/ethernet/intel/ice/ice_arfs.h     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.h     | 12 ++--
>  drivers/net/ethernet/intel/ice/ice_arfs.c     |  8 +--
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  4 +-  ...ce_ethtool_fdi=
r.c =3D> ice_ethtool_ntuple.c} | 58 ++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_fdir.c     | 18 +++---
>  drivers/net/ethernet/intel/ice/virt/fdir.c    | 28 ++++-----
>  9 files changed, 70 insertions(+), 68 deletions(-)  rename drivers/net/e=
thernet/intel/ice/{ice_ethtool_fdir.c =3D> ice_ethtool_ntuple.c} (97%)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

