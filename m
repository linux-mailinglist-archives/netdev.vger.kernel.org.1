Return-Path: <netdev+bounces-147684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E039DB310
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8906F280E8E
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 07:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300E213A865;
	Thu, 28 Nov 2024 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaFKBTPR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32311386C9
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778118; cv=fail; b=RDn7o/sP2AxywEbhRW0FDC8KqjTkhCSxZQAhyUMaQIx/OWe8WQqG9xgFYhZph+4T8x+5UmORksoyURBns8eOxrKidRYoL6R2QoyxCSIFtePUqTGzbOj5Jmpr1DxunZfc2l71XkOOWM0UDZgRqf1ILk9DoPFmHVl4OmYlfslj3uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778118; c=relaxed/simple;
	bh=SYPoNbEjPrzSUQcYs4Q7q8BYISiAbgUEoPzw7InZpKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QoSfSRXZpdSoWVbQgWrAp//1HOXm9by/BAqXr9Jfjijp9il5NmGbesArmCITJ1YIKev9ky9NScP3YipbZwmohT2MgTAsnhFehW9Lz/9pZZIvepYnBcz/mifO6buPbzBxNVBsFSEBF1Yln5crJ6oyICEYE4OpEgKqIzqFh9kL2Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaFKBTPR; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732778117; x=1764314117;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SYPoNbEjPrzSUQcYs4Q7q8BYISiAbgUEoPzw7InZpKY=;
  b=PaFKBTPRMDwKtgkWd+wxAUKzniPAtx+lS0DhC4czi+gr4B0DY7F5o7Xk
   4TC4nv2XrnD5RPuwnRPGXp+exFSSSvHHu5JyN2SrjzmK+b9kNu/0tif6l
   9+Ta0jrntI7JYLhH853+68NCPdfau/71ExTCAyRjZf+exXMeP24O6lf9N
   M2RHDYHzXUoWUweiZM3mB8YRH0Ye4VwJ/wY1U3xXLdYrXcyy3zQXHb+RA
   PQIF3jwpX9eRLM7MjsWMrYFgupdQePRu5ZQM5rrHuKVkKYn2E1Hck3BKH
   0RPRvarWSmG07y1pphSNhkc3OMkMid7rIvicZelXYPVtZghNaFkYprOtJ
   Q==;
X-CSE-ConnectionGUID: UjMD11U9RKaOdan6MAx6mg==
X-CSE-MsgGUID: gbFQr97+RMKXwUszz8TmvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="32860371"
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="32860371"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 23:15:16 -0800
X-CSE-ConnectionGUID: Q86YKTDyToqxRxuO2tnpLg==
X-CSE-MsgGUID: gEMzgYzMR1ye/hiXh7umxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="92550498"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2024 23:15:16 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 23:15:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 27 Nov 2024 23:15:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 23:15:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq5LG29GzTIFn5Di+7EJK5YJNunzPqNX2gspytgCct/w8MaTpRMatbwCz39dHsEA/of+iWUKu/luNHnWabkiv2p1bzRKraGSaY/6A6oIPBsUihebZGr4cESdzo3l99LYc0mh8veYmxOMYSA2yNMMn1aOxq0/UJPXnENVhla34n4/thQYf1+kRig4HfYAKQy977UWV44LF6EbTukmAro8F1ovX8B89v9UxJHIKPvQzc5NImE9eBtQIWthzV7xVil5QXiJKFUIxc5Sg6Gm3rEMrvPkZ79vt2s+cxwI0qZe+9tibtq4L/xaM7IGh+UMYQyFVgGM31ea9LU/pb+tlIH3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEcMI1Hg/IGr0OqiNPH1ZiBwiV4Ywre+Rise7LHMqms=;
 b=eS5gv0Na3QIdc63cqHPHWmpDA0HktR3PnyEAwZHdsbaxvibYWGnlIZmVaToam/x4uvfjJas3/cFDaffaFJPsoLibLkpLiz3zqvCUVjYwnJdGMTfEh1+6GJjVun283rvtpfzm/41WyqJIM8r8bnUO24mjJ0UBRfbfwCV+L91yo7/odJ10h5pt7nhbmTJAbK2dCjTnbh9VrOGUfyxVN6kiDPOL+PsFjcUorgHwO1GL9RhBjgiRFY6GJH++X7YimdtxnbUQ7wnBitOmM4OCT8VcG+9bIm6fQ+KMxShTfi37UT/1mslv68yGwY8/dWM6gUraJSeVo0ZBqLAMfSZnQ6D2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 07:15:12 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 07:15:12 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v4 iwl-net 1/4] ice: Fix E825
 initialization
Thread-Topic: [Intel-wired-lan] [PATCH v4 iwl-net 1/4] ice: Fix E825
 initialization
Thread-Index: AQHbL37YU0vjpjpDcU2M/zlo06o+rrLMa0Cw
Date: Thu, 28 Nov 2024 07:15:12 +0000
Message-ID: <CYYPR11MB8429FFBCCD56571645705BA7BD292@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241105122916.1824568-1-grzegorz.nitka@intel.com>
 <20241105122916.1824568-2-grzegorz.nitka@intel.com>
In-Reply-To: <20241105122916.1824568-2-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SA2PR11MB5051:EE_
x-ms-office365-filtering-correlation-id: 03ed5f45-c32b-48d1-2a49-08dd0f7c6631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tkqp/dK4koRSwjj5lXzsBiRzMk7OH8OHfODhE0gqqhuVwEXpuYBd2Q7O+G7j?=
 =?us-ascii?Q?T/rocPIfOBHNUHRK5Kx4kcsX863zkZ08zqhdtd25cRvll1f4j6j1iLw4zkRB?=
 =?us-ascii?Q?rH6Wv1a7CerRwimOGu7olY7pwQNiscdsnXxqLnRhjdxXawkh+YIUDUb+M2xA?=
 =?us-ascii?Q?jpV9Pri6h/DI/ZTb9DhV8vWSYbmAclFjuGoz6MyWR2XPQy4w2GklW+sRdQeV?=
 =?us-ascii?Q?C3EqHcKAukxjVcIitnqAyW5lh4mpXh6B6gL+mGfSiJ1Vxk/l68qwUiZaqtGE?=
 =?us-ascii?Q?EGqM8gKmcnLds+K8iorDmmGoLiVwSOYIKxQErJ5J/Fip78ogXMfmRII1X7uO?=
 =?us-ascii?Q?JUmngT2y2ks6qF/qdq8Eb16hbAIEWiDvbMXOenjMkv2RTBrnNY57DVVEME05?=
 =?us-ascii?Q?gKxWUamMvtXoLQED1v56rl8q1eo7wLjEIvntIOB0btT6JuZlGp1Z7gG3pjOn?=
 =?us-ascii?Q?qHQLV84jGBs/Of7rLkdFFASUbVfNwt78NfyrnlKdhkzsdvPLAyfyiUCdi9ek?=
 =?us-ascii?Q?8WDZzy0EPiOT6EbGODVkU/v5Mg1isjnd/72r60Juha8oJx8xTb/aNBeQfrqs?=
 =?us-ascii?Q?v21cwWM5MBVpslJPXfoTlpRRibhgGRRsqDEggBdDSmcWo4q3fYwv4jBxE2pO?=
 =?us-ascii?Q?FUO7+o4d8MKVTu3cbLRf6a8zZCGbyEHiwSuySXWQVuTb+s7e5Xsruh03VM5C?=
 =?us-ascii?Q?0RFLoL3NyNvKrJYyPl+hW1h5NyEFkr7SsjlysWkB0FNxtupjuy9oQ0yI11Wy?=
 =?us-ascii?Q?nmOLfdx2V8MQiZ1+Oui1Dn9x6ZJkBdOJJO/spkxanPj+q1MkqFeyot1roe0K?=
 =?us-ascii?Q?7YfMawyof3Q1zYe+DI+Ao5+AL2Iua5NZ/PeHDJIlu5zLwCBYG2uP8LEaTpEa?=
 =?us-ascii?Q?eIwyRNHaYUzmGHwkxHWIs9A2L2EyEaDYVkCtleyOXPyVI74n8fGWmOk2iHN5?=
 =?us-ascii?Q?5Up5GcmAYkNl4haPyG1wqDAtAK+Gq7irdsRs0gu+DJWdoUTfKvZC9AbTCV1g?=
 =?us-ascii?Q?t4/H0sDIaZUnMxKUHWb7lKEifI1AXKtJQtYEaFMaBvzWdtedzWQGlSMb3bsx?=
 =?us-ascii?Q?vMoTlbbvbx1kHQoa3RQXRXNYo0l39LD3E23RU+GTdrFUt/Rm1Z0ViVdHhx1+?=
 =?us-ascii?Q?0bF36goHW9jUX3wWLmYoEecppKBpRoJvzbS+KkxTVHS+L6bK/b4REdrctbUf?=
 =?us-ascii?Q?xzLovTjBbpDpXOOoj7y/GEAhx3BfpGdAjT9oNwNKE8UAEGQmt4Tq8ueR2SVz?=
 =?us-ascii?Q?ao+p0muupSh9MyXbFDh2bfXzaeNpDok4pybgoclwfuCjBLqYJxsD8584f3u3?=
 =?us-ascii?Q?HWH0vqwBMgL8AjlIxgOI0QsSPo12TU7TL3MYARRzTCUHVsnd3Bqq1bP3gift?=
 =?us-ascii?Q?w5l8litjNKi8VJEguUapurCQyhgZ3ugkQVM4IZQ7NS2C+pMRrA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?93D8shA2fvnH4q9WNWZtOcUB2C8a31UGQjiA5HLbky+z8h87qWipTApftVk1?=
 =?us-ascii?Q?6VL8FehCNgP9vlRsdHrOHzmDjbvyP3CorDETFBmEmUMkbKReyDVG3d9RuuE2?=
 =?us-ascii?Q?iEqBP0cfVAoB0uyaqDlAaTy4KLvoN5PvW/6I6IGoqOCgkFEkzNmNN8hk3Pav?=
 =?us-ascii?Q?Vr14QMmBqBgJ3402K6zZlA5+CAzDrKXNEAYdGtPZwgai7E69749RIM7i34NQ?=
 =?us-ascii?Q?b0qwt2GjmC4cLNVPm2idHXTTZjrf6VnjtGLCMPBTV7tJ5vfFYsSxZMgtT/Ti?=
 =?us-ascii?Q?5Ua1oPliGt78OUAYuKbC8eBcpPs+mk/7CLj9gbWsXWzGDsCN/ygqhjTbFPPf?=
 =?us-ascii?Q?kLVRe2Ucv79oB0b10eMU8HbBsYefCZm67Xauz5n9AvieBtnhlkY+dnQdFE1K?=
 =?us-ascii?Q?63XLqCXKPH7vqV3wcalhCSFR3sMnzlw7/vgGjEsAhadTUvb9fqqJnJtZrnxG?=
 =?us-ascii?Q?fN3GxlxNeavhnTdX6CffkTR702NyJJc5io0VJMPx8voSVNX1Rv0pxTNlmC8I?=
 =?us-ascii?Q?hf9ij5YqLe8aIUeXchVzT+59dxEXGcmRShHB1DNjuQuqfBA+dSsdG7K9CYbt?=
 =?us-ascii?Q?s2EHNM1eaWxKdwvHN4JLWlYeSIR5qia5uk+p6vE37ZWkPiERhYWCNTUpqsdV?=
 =?us-ascii?Q?fgYkts05pua36f0wOrYxxE50CNjocBOJoDANb87dIppQzHKQEK/IdbfAKk8N?=
 =?us-ascii?Q?udh6IKNewKkhG4rTshi6en5RWTNPX+xEhZPv2E7it6RWpwsce6epT3GvvnPw?=
 =?us-ascii?Q?jKV6LnDd85IjgjeigbbOk/m6ZeEaJWZuhgR8C2vgU4a5gh5xlVBhYhqBObFP?=
 =?us-ascii?Q?yJ+3hVSZQfCSqTMuJ/6JmBHj5YiEdgw105y+hUihx4EiSjK4+fodQK8b7lpq?=
 =?us-ascii?Q?v6HWpRrmAkFXvJ/vuVwwj3fdP+lopnWRNRZZwMD+Q9M9SRVyHA2I5ILtx2mv?=
 =?us-ascii?Q?A1j9DrhpUgN49RcXar+VZJcCdK4cY3/COtyo6SI0BrJ/We36Y+tNP3aWrwNg?=
 =?us-ascii?Q?c76q0AsBGRRn7/e9I6EEKHSXwsSMKm3a5RwQ43sZ1myvuuhBHpeZfOLMBx9v?=
 =?us-ascii?Q?QsJE18UBfLDhvZ83BF9/n1OmWx6bTA/IHkFBOAk69mOPlbZ7lJwy1NDYUiMX?=
 =?us-ascii?Q?4ED2yPRhNAKkqUW3JfsUpyukhAT/ZxVNfZJgbc6mZepj+pz8g5dOOJHkrxBu?=
 =?us-ascii?Q?6M3oGaraJdd53cyH3pY3hsE/r2Bo4q85pgc1WuTJR6V1y1NDU8qlLAzk3bJs?=
 =?us-ascii?Q?ajStNZOUuLXPgAAizcbH0hz7vToYcyoUvzH5o+TIcCYrl4bXWYb9jeRvMpt/?=
 =?us-ascii?Q?6tRkOnNWjH/YNJPsCBEFGzVoafXxT6oyXzXBu/MBQlh5yJdf4SR2HBGx9MpP?=
 =?us-ascii?Q?glzEPY5ZaKWlqaTCu//TUnTm8SK8X7fEO9qtujS9JNTQDrzRNR29I7qZzuaZ?=
 =?us-ascii?Q?Y2Qum/wfCjwR00SZkDIQRiR1ITUE22vnpwfp0L8Gv5H0j2iOgCIXMHso2jKJ?=
 =?us-ascii?Q?MfNhOn3ns1hYwPTmvykgzPJ1xjEamcJ5u2Tec8QZ0zwZ7oxk8CteJ+jhAWba?=
 =?us-ascii?Q?dg+4CwTcTfJl3FKG6ja7lEQLylryzkbdczyJzlMAyYp/yuaA3e+4WpO/YZ1T?=
 =?us-ascii?Q?uA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ed5f45-c32b-48d1-2a49-08dd0f7c6631
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 07:15:12.0899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/WFP0PY/yuOBDRVPPyx3Mld4MdpV1978Gv62BF0UxE3i7MuGgHIzBJtog6UkAn1AFJuZ9iqSHmNNIO/7poJ4h7Q3khITjSy/H9y3Pis7tMd3oDjttu4Uc//uVx3ZAyD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: 05 November 2024 17:59
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>; Kolacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony =
L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH v4 iwl-net 1/4] ice: Fix E825 initializ=
ation
>
> From: Karol Kolacinski <karol.kolacinski@intel.com>
>
> Current implementation checks revision of all PHYs on all PFs, which is i=
ncorrect and may result in initialization failure. Check only the revision =
of the current PHY.
>
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products"=
)
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
> V1 -> V3: Removed net-next hunks,
>          add 'return' on PHY revision read failure
> V1 -> V2: Removed net-next hunks
>
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 22 +++++++++------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


