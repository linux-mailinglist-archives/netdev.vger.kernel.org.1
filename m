Return-Path: <netdev+bounces-276838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MlYL3Ai12ntKwgAu9opvQ
	(envelope-from <netdev+bounces-276838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:52:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B61D3C61BF
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C653300D63F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 03:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D536C324716;
	Thu,  9 Apr 2026 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDPM6+F2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F50A288C81;
	Thu,  9 Apr 2026 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775706732; cv=fail; b=BdMadhwieNKSVhNPWBdFlbqXJ32krBgJN2rYflO5I4r7PalXu9uFQS7hFYCGidtdioqXX+Jt26y8szpqs3jLAkOX/Cju5aWRK16MnFj+JfS4+1vIrbxJQLGcm60Q8zXDRsyL5PuFaOEzw2QzrNuYV43Um3Df6iouZhq1k+vce2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775706732; c=relaxed/simple;
	bh=KW0yiKLBuIXFVMwhUqb8ewCofVgdIoEzN8yaerszG2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YIZ1XuKvwfjvCjoueNlqqiBAGFlRKj0ERjnWCvP9CQmnqZP07DJrAXqmsaddkr/VZqgkU7vigm8IuHdTJmVbj3/sE1a+uQ1L1hWX9Udw9UzSKoULtoFJzVYO4UiL9tZhuzRmrjfD2VRWtIMUtksoBmLxWfr0x+hJgBCfKY7GZUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDPM6+F2; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775706732; x=1807242732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KW0yiKLBuIXFVMwhUqb8ewCofVgdIoEzN8yaerszG2A=;
  b=PDPM6+F2z8lvTFyzAnbQKh9wDE++pFR0/h1wNXS9m1eDQf//wwsAGzJl
   QBrPeXS7kvVk80DwMjQkKs/seTM0OSjGwh8IMUOrrI1Y0qdr5zTrdZ7nI
   cwxBqOcN6ova/4IVTYWm17TJUb3omm0PxbVmEwqIeWIZavWZVG4mGpdjv
   jCCMN9Olyk0uQ1zn1mmmfoZ3jiyiW3ehZr6mtK5/AfT+Z4kNK6itBEeNp
   E66X57rgWA7nJq4YYZ5DrEZfZJB+RweNummQjp4UqQCYNqhCpWPfOxoBX
   GEQkgQHkAtFfJFkP+H+PC2g5ccOpqwmPxhL8ExMB/ztb2j4bF0cIkilpd
   g==;
X-CSE-ConnectionGUID: 3ZfARWwfRQ2KEcWUVc4lwg==
X-CSE-MsgGUID: rGE+XzZJTeG50pl/cR9hnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76774850"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76774850"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 20:52:11 -0700
X-CSE-ConnectionGUID: AI8+ZE3vSTu/OggYeuEPpw==
X-CSE-MsgGUID: 7pGu1SFeSySGu5jpjhK7kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="225481631"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 20:52:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 20:52:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 20:52:09 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 20:52:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX+y5VPZOy3C6450r0tI2OKgipow0S5kJW4txrz+BiEpCl3CqbFEfpi0wO8rCQ9mo63R7bK/26M09Wm1sGgaPNOUQvEmmlyhWLBSkd91WWik+SiOKtr9+Imy6Ha+H3A4nC5lcfWh/mBf41esUnqi9lVVKx9hv9L5wpro/OaJiJndZUeUCkVErzYZmZyYBtp/lnw0CO9S4Ee0uapHwxXAAkK5kOASt+b0jb5BnoSHR/d6KZ9tncgzybU14DXZvkEwylqs5lRkStPnBOBDbKc2Qg1ShU/JKv8L/egY+AHVBpwHePRua1/sQaDRSg4e1GI9baVkxBIq2MlxUQpc/MZIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW0yiKLBuIXFVMwhUqb8ewCofVgdIoEzN8yaerszG2A=;
 b=FMZfPmDXHi+y9oYAKzf1LSWMdzrSkiy4CdIg61r/cYiZUbbtLREzu0kyzet7Rbru4Rc9eqgjPDT8/lBYg2vRQC7Zf4tmAe1mSvxeKwZANnuGQgY0l/xJTBDs5KIL6zq5CgaKWmy4O99rHCPKYAJeQdb6OTYT6wASqHd5XmDCjC29bRz8GMXFMElVDThOzIECUWEc4MF9Nj1eOp8Zaa3v7DeumiPs4+DjuWoHjIl+kxgY6XeEB2EYhqNCroErdRHDqdKwLCOHxcm8DRz8ldOnOvLy53SzzbJEbzh3fTRsUvHZPPozjrA2hQD5roBWa19Kat3mbgk/x9VtRoGbVvhq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 9 Apr 2026 03:52:07 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 03:52:01 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Yury Norov <ynorov@nvidia.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Morton
	<akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Brost, Matthew"
	<matthew.brost@intel.com>, Paolo Abeni <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, Yury Norov
	<yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: Simon Horman <horms@kernel.org>, David Laight
	<david.laight.linux@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 2/4] ice: use bitmap_weighted_xor()
 in ice_find_free_recp_res_idx()
Thread-Topic: [Intel-wired-lan] [PATCH v2 2/4] ice: use bitmap_weighted_xor()
 in ice_find_free_recp_res_idx()
Thread-Index: AQHcqeGnEY8oKhW3v0+n742GmXLaa7XUwHTQ
Date: Thu, 9 Apr 2026 03:52:01 +0000
Message-ID: <IA1PR11MB6241D61FB987977E4E7711608B582@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260302011159.61778-1-ynorov@nvidia.com>
 <20260302011159.61778-3-ynorov@nvidia.com>
In-Reply-To: <20260302011159.61778-3-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB6039:EE_
x-ms-office365-filtering-correlation-id: 199c020f-9bfc-4d0f-d241-08de95eb5b24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: +5gZiJ4F8AHlMAij3KwYf5Y9w6TgpKlyZ8erv4BqMDLUUHDk7Ljd+Xfi52p4W83reUVMTF8YuIC9z3ZqfXHaIoxolzHgSNGq/RLOosRX9fefa3Iu1GXzTYuwCJF5ETuQiHdxF1uyjrafvRGZXpqy0AOSXM8t+up6vOmy1w1Puh5pM847wcOwJvs/NWaFKg+S1Wrg2JlVvHdqU1tPmLRt7JFGPdNQBVG/ElOjHWayz5eygzpfSMPN2HRduOmN+GflAGZ8AIqNLNv0pXCeHbx+W07AUppcQpB1vd1mmlcRu2GTOEF912JpXQbuTRIf6916tFwcddD0t/lbzQPECnlJthjy0ymM2bb4QM6hK/0WxD0MP5OIszXRnlvYCfbcO6uyNe/DmHki8iD3OKP37pIe+eequep+kcpairnpTz/tuFY58XUT5NpkZ9Q0yfzj4uccSCvyyNUqxgaluAeISvMsvzGgImQR2jjPvzvCFdeKrKT7jI5QpZUk9pSLj/oekHxdi9ogQJ/gK6fbePRNLEwprES7XX2RJPwSVew9i7I3OgERstuMwX0dJUyxKh1rq1EeIuPgZn3rmZZfZJaPvLdqEuPTA+sZitu1Yxp9IAUUpColqJyIWZY7if+wYtgZDItW95wB7PFIU/HsqWrOfkfAayrHR+q8KvlfIXnjcRL9RMsIRk7IzzSii/c4vTvAx78gj8KzRqjK5+a+9TiMA7DAtWi/bCjli6AChlou+vuuMcqmpxcNmlFDkRfH8HbNf4dnlyEkKbxOCoI/UyUURZftCnbvxSFWIxm5XLrHqgOYLaARlgNmbi8BO9GEd9Cb+pVA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aJjcC3PX4jdtfxfB3A124DJBT3fnIKv9GHSMA5iQLO/MBaHkTWJCpJxKfO?=
 =?iso-8859-1?Q?mnf8L4Kpr6Uz6hFBepFrdNs+h/NpILVLTFGDS1X2glay2yIhN3Ny3nyOrw?=
 =?iso-8859-1?Q?tmyxsTG0cxqAMj5yBI+PtN+bkkMTypII9Rc1Cnru5sCZ5T9oHsFdQe1wRN?=
 =?iso-8859-1?Q?sEP/fao91j1YVcLlOuMfT4HRb4vvUquVsbhUCvPt0lFOoDcrRc2+MBHSXZ?=
 =?iso-8859-1?Q?yjoqMBzWZh0nPwhmkMgFWmNitZxR2Dr2a213UTUxmval1UWj1zaYKanVnJ?=
 =?iso-8859-1?Q?oYqGTREhokukUJ8B+oeanbZj13DRFWP+maE37gBvdVxDxwTrs+Wj/J5rDW?=
 =?iso-8859-1?Q?WMYQQUJPzQspP7pX3ZGdknvIbvB/tVzJP9Yz0ut3SvPOG/JTgLKhZnoEMC?=
 =?iso-8859-1?Q?ffkU2UYil1rlDXWAyudVGC1WDHslvhJhMYMZgH2iHD2Cmftxow6N+T+Ey7?=
 =?iso-8859-1?Q?m45HqOxmygIljxYNXh4jywSVUr8Ge+vCL+ZsScqBl8Nudon1Q3dyl/jA2L?=
 =?iso-8859-1?Q?1XH0weyGz5zTNU4ypH2WlaWVFdbrPknBuDJQ6mxBWctmv0tF13Vn6fwrTl?=
 =?iso-8859-1?Q?cFHrYbnF1TXePE7gKet0jVmFON5JHyhZ2yKLH7dbiMDyomB7h+OBWDsUKH?=
 =?iso-8859-1?Q?hxQFZzqUQWeiRKyw4coLP2zM4PSlGanLwEy1eSy/ajwZNotWTyJeWrlnMC?=
 =?iso-8859-1?Q?B78Js9mjSXhLD7V5WH//K//YPkD+YEyx00kqQzj2wnijF+NAOazYrNRjjx?=
 =?iso-8859-1?Q?HLH0uhs0nJ5L+GgYlJ8ck8oP6+Z6HWF0/qDsre+RXoiE/UilmdYGczQ9GA?=
 =?iso-8859-1?Q?BabFDR0HptF8Sgs6WPnkfzd70L4u9/NjmrN7lnkW943F0yb3VUPtrx3Kmj?=
 =?iso-8859-1?Q?CEbql9tR0VEFwPc8sNuyq5AYKd8JWxG6MJQycgBC4Umtklae6ejRwRSf8D?=
 =?iso-8859-1?Q?8/YguDiCqyKgj5A+FsU7iwN+2vowF1L1BETTMfi5uVOExGY55V9nwnANBS?=
 =?iso-8859-1?Q?X2hYtRqODZltgsfN8cM8bEo0MX/jM7y5R3suFWlilR5DL2tf9VC3NhLtUH?=
 =?iso-8859-1?Q?CwoCqwESMxA1AqxCFGeTlkAPnMrimmcNhlO7+Tv+N9KYFeRG4/lqTQs1b+?=
 =?iso-8859-1?Q?D1xryGNQGRit0zdOuQ1wkkQw4cZ6uU7qEoDnCsn48ZmJzKxXhDYNkhqVFL?=
 =?iso-8859-1?Q?h7jzUSnnDryB4oittxpCzvr1Jqz87fcZWR1K05qUmIgGSah54NCBdfuwTO?=
 =?iso-8859-1?Q?L93gj/a/haAhG2sIzHhLRbsaNNabzE+aQ/jRAZB77yX3jVEIh3Rf8aYYgR?=
 =?iso-8859-1?Q?V0P4RZYPnk2PFWZZXPq4NU6N8V/FFiuYlaVXM9Mkb0/WlVnAlbvWnS/rg8?=
 =?iso-8859-1?Q?oFw6xU1kgPvTh4FZoTwzYavQHr3cK3GjIamQm9rDB9L6JfM76gE/GFmZe1?=
 =?iso-8859-1?Q?lR8lmktvaqPYHhRo/Z25QqPQ4ybHP8sqdOwvZ+yyMgk77LMVUOpdpM+tUM?=
 =?iso-8859-1?Q?Qp1E5IUIVTw01DRWtysftE6pil5ySjy4EjSgKBMmjHXXCKBtWzvoHYMM+k?=
 =?iso-8859-1?Q?piteWkO5mYv3Y3hCXRl6OxjkSFwhsStyjcAerbHMiHbO1tHYAYgMjvpTB+?=
 =?iso-8859-1?Q?jLgSAiuCpwrugAAsg/V+tjeYZsmKcTNNHpQqFtkkeIV+O4QlO8sefxDIy/?=
 =?iso-8859-1?Q?pWttCsViKOvMtE+MhHvyVdytMOuUtXjgbsPU5o6kLVpt2N2Ug0HSDQ6c9p?=
 =?iso-8859-1?Q?kCD/mEsGWJcobtl2I+QnJPaqbkS9xYf66v2KV6t37l7sZH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HZGVcP7SwLhhpqPuWdbSeyJsqPrbziVv4YKd+D+J7TTMFnHwbVHt298OO8ZR317w5yFyBI7ksZ4yuhAzyvnEUOzvF4ZnCsLKopCUHK2KazS8rT99Qv4d3/MtFROZaV4jwN9Umn0Fnm18FxUPZwMTk3LJuc3HIKIuEs/IVtaZUV/O8OTJ2B2sxSNVLr1k+8dJ6Alj/GfE9SC9DSsCFLqQjIZPpj1slNgoly6OIh3L66juUXMO4QOTHlA/4vBE55aZ0suHBlBfthgdxKGZE1O2KaDGf4pe0WMnOJfuHa1FRY1Lgyy0OoeuMcy2lQ8BkhItd9j3R65KH2m10NyX9gu2tQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199c020f-9bfc-4d0f-d241-08de95eb5b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 03:52:01.1813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Q3neP6GsGZrzCpVJobREQMUEkbF6k/vWgHo1FGM3i4FRJHyUmPllc5JbsA9rljn3Lf7TfIxcYaTRNA91Ug4Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6039
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276838-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,intel.com,davemloft.net,linux.intel.com,lunn.ch,linux-foundation.org,gmail.com,google.com,kernel.org,redhat.com,ffwll.ch,rasmusvillemoes.dk,lists.freedesktop.org,vger.kernel.org,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3B61D3C61BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Y=
ury Norov via Intel-wired-lan
> Sent: 02 March 2026 06:42
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; David S. Miller <dave=
m@davemloft.net>; Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>; An=
drew Lunn <andrew+netdev@lunn.ch>; Andrew Morton <akpm@linux-foundation.org=
>; David Airlie <airlied@gmail.com>; Eric Dumazet <edumazet@google.com>; Ja=
kub Kicinski <kuba@kernel.org>; Brost, Matthew <matthew.brost@intel.com>; P=
aolo Abeni <pabeni@redhat.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Simona Vetter <simona@ffwl=
l.ch>; Yury Norov <yury.norov@gmail.com>; Rasmus Villemoes <linux@rasmusvil=
lemoes.dk>; dri-devel@lists.freedesktop.org; intel-xe@lists.freedesktop.org=
; linux-kernel@vger.kernel.org; netdev@vger.kernel.org; intel-wired-lan@lis=
ts.osuosl.org
> Cc: Yury Norov <ynorov@nvidia.com>; Simon Horman <horms@kernel.org>; Davi=
d Laight <david.laight.linux@gmail.com>
> Subject: [Intel-wired-lan] [PATCH v2 2/4] ice: use bitmap_weighted_xor() =
in ice_find_free_recp_res_idx()
>
> Use the right helper and save one bitmaps traverse.
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
> drivers/net/ethernet/intel/ice/ice_switch.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

