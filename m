Return-Path: <netdev+bounces-124920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E66B96B620
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBC228962C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5901CCED2;
	Wed,  4 Sep 2024 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6b985b7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7E17CA1D
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441015; cv=fail; b=eBWF4d8aGc04uIo2TKZBDPpedPMmjZeSsIeFRFStaalZnrLqb4aTytbbtvCgbL4TgZosCOcqvEGDtOTkEXNLL5mcfY1I9bgubozSuWPsmZnBv1rRQHwpoV9S4RKiraa8hPIeM+IhmJPWSZ9h+FJuG9GOw9i/UY1kh51a6IOTUNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441015; c=relaxed/simple;
	bh=htJ7Tfm7UHPhImRvRBhxhCiBNWLRtj54KCJMOPaGiT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BcRKkO0eBu3aEJxWpZA+3+6+1JVCgx+X32XB7JaWnOMqVr91OINVaQ/cGGUiASiqgK1/mlQEIZkp3GmL3W+bKUdLjeggIE3+K9hqKYgvfzcDU3cSsBlgWlFufkGPKDY6BJOssX349UuowYU1HozPnXs+V2mLmmco7tehREdKYnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6b985b7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725441014; x=1756977014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=htJ7Tfm7UHPhImRvRBhxhCiBNWLRtj54KCJMOPaGiT4=;
  b=J6b985b7Vj8NGNI3knyGSDdm+YZZ11NTu2X4rNGYuqI/qJ+n7hd50WNw
   De5nrTOldaaHCreh7yaGf8299YEwnWR/WFVG5zjJm6JArYGogJdDWBYcZ
   tWJrSGFkSA5VvvZrXzXzslV2spp8+iRkpUEXyKcBrK+T4zBVofnjtuBpx
   M9kwDTi6BHrR9si3Gkwgp3TCklGWEhR5zdKil7iFHgq6JpwdYOdpHnBJk
   WBZ9IfwjpQ7jDUm/D7V2Aoy1Iig23O0RbZ9PKagseS5XLgK3icrUIVolh
   C+jWfUdxLV8CA9IzxjMUsaWhqsjI1PAHyye+0+Ed5FVEnMVrAZemtnnBL
   w==;
X-CSE-ConnectionGUID: /uVpMZUgSb+MOeje4KK2ww==
X-CSE-MsgGUID: jzdabzLnQjulfIy3bhbPnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23965187"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="23965187"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 02:10:13 -0700
X-CSE-ConnectionGUID: yEJbN633QC6ttBmOFYexxA==
X-CSE-MsgGUID: mcqrO0gDRzezvdOAeKjp/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="88448026"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 02:10:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:10:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 02:10:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 02:09:43 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 09:09:33 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:09:33 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 3/5] ice: Initial support
 for E825C hardware in ice_adapter
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 3/5] ice: Initial support
 for E825C hardware in ice_adapter
Thread-Index: AQHa88vKZm94WvdafEmcD6bJCUSEsbJHRWwg
Date: Wed, 4 Sep 2024 09:09:33 +0000
Message-ID: <CYYPR11MB842904BD9C35ADD1B3359C6DBD9C2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240821130957.55043-1-sergey.temerkhanov@intel.com>
 <20240821130957.55043-4-sergey.temerkhanov@intel.com>
In-Reply-To: <20240821130957.55043-4-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: 0d831c23-b4c3-40e7-d86b-08dcccc14aa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2PrZ94XgSGAIo2YJAVdzFFXrIueW6bYhoAmN88DNHML8wL9LhkSNPinq0nFh?=
 =?us-ascii?Q?ICqQYDYwVqkRuJsJdHsxo1S5KGchmsMmsqc6nDH5FNLKGvcAb7ckfpWshYPL?=
 =?us-ascii?Q?bGWaNYNG6F6U0ODPb97Rq76+Oudw43Kr5FL65RTi+BExZmt+MgZodrg5B+Ce?=
 =?us-ascii?Q?TzVcFi8o5fJ5r9/dCMQMfpQ2fI91lcV2KEeGrCw3NocoyZJe+nTu5u2a0MOi?=
 =?us-ascii?Q?ESJbk9iOMTcaEMa/2M0l0Ig2A/MNPo2a65pvPSw7JCS8yjgJfv9AEYi1YBvC?=
 =?us-ascii?Q?htI6c9vFYnOxnaUu2h0CkYO8Zv6No9eXqEMcZr9lgSMuomt6CVN8baY9mYsM?=
 =?us-ascii?Q?hxA9qMfWiPbSii5pFYM9u7LcDW2NjTJog1pS7O/75nePLSgIeLJSiuyK4VFp?=
 =?us-ascii?Q?wIzVZBdlDreqAoh9cfelAFGee3n98ewknMglL45fjj2wtVoXXud6/XKd6WIQ?=
 =?us-ascii?Q?r6YgfibuCQ+BZctoiJZ19oQP703Heb+Omt7XEkikhW+qbGWIPolq7oWoV+2X?=
 =?us-ascii?Q?Au4YoT5kA0JC6Y8DXQrAsFP7SYKrS64EVuCMXLRVMxs2/F3mIrcr9gi+/6tb?=
 =?us-ascii?Q?GFG7QReQOeaQJZwrY6ZzM/kB2owMRjdfPLSQitLw/ynj9UBqdKCH+M29V6gI?=
 =?us-ascii?Q?af8lvjBOEXFmBxEoKm9KQqgnhpYWWWZ7S5a3UrXSud8bII9tt05zEvbYzac6?=
 =?us-ascii?Q?w1e7XquglPtu3BBEpmyUi59w2++sibCtp1WJ93D8zB+ACA9eyKDVCUUSLzX7?=
 =?us-ascii?Q?3KVrOIOEZvrVsUT58TNjxRRpGH3QfnUk2wlKYGmsOPY+JXGhhnvWG+KR92KT?=
 =?us-ascii?Q?F9ndwcdxoyMxIDS7i01t4TFEH+PyXwfmaF+6Qyx4P/K43EJd2yV7i6OdyN3v?=
 =?us-ascii?Q?QYB7CUnQVnoPeIS4EdGNlBpuhS2q6TsuqTTJmo5R+debIfCRGZmIKIMG2hyt?=
 =?us-ascii?Q?f0M874JWQxgXMqwn0iqll7d/cN5OPblJtm9M2NKFCAiwTM4H4ATQReuJ3tun?=
 =?us-ascii?Q?b6/pvO0Yt3o5okQ8rKV1vTeXs9Ry25w62mJtSgbZfVtjZ5XKq/WK4TbAPlpo?=
 =?us-ascii?Q?YLJ0NDu3RptkNza5huFdrPrve6wN6cufANB6NFOl2fEvY2J5D/IAf67E3EQe?=
 =?us-ascii?Q?+YZ/kqbaqGMzquXolZjQtZmPAuOVKIW7tsokXVHv+9l7Ds/S+UAd6P6YpJPT?=
 =?us-ascii?Q?OTk3wQPiZTfB7M3Mu6AAFzxgHch6RBV9TObmCKSKob1qAfxQnxUWPy0jqzIq?=
 =?us-ascii?Q?+ZFCPKoJbC09pvgO9HUARqTzSqIFuBloqW6q/8YnoyWeRLzmreuYwwRdUypk?=
 =?us-ascii?Q?ndqlEmJsH8j9JlPFLj1CHTYBDDd/9itF4o277a7PUA+5oQwLHI8hSyK7X9F8?=
 =?us-ascii?Q?KsFw5KH5C/Torh6zsZknt85rgPHsIDRDPlkDuoaxsOa6RWCoUw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iae0ICfSVDjqmVHazlTFW6twT82Il7UsDmc7//4CKqugMMpsbNTq3OD2+YfD?=
 =?us-ascii?Q?klVmQ/8jvHJv8o7C4YFpozleYhqEIDPKHGsZKWN6+VHxXg5NQdgQGzBihTlf?=
 =?us-ascii?Q?tOeesdtvB1fbzQgz8QXM+QKZUut1xBYLkRARubhE+S0S4mKIOM84meIrnQca?=
 =?us-ascii?Q?qfKk034fG8bRJYLImUbaXQ8RgkKAGQT8CitsGsScJaD/5PtgI4a5ZQALifsZ?=
 =?us-ascii?Q?V+ExDVPqcqcKX2aYv5BAm1BG0smWhTzNQkHJDW0VVT5g9M5UcPSrTMnnpMKi?=
 =?us-ascii?Q?V8Z0Ig4cVW/yu4klOlK5d9LtbAj9HixYPBSUWIjLgFu5SH7IQqfWypHTBEbi?=
 =?us-ascii?Q?qTcIhC/wAKKcHcpinsEIn/Ydgpb6QnhRBygdS/5C7ymIUIFE5z9aJ9v1G5MS?=
 =?us-ascii?Q?jbL+NnLpTyOI2s1lhgQdD30FfF/vwgYWJtetrlSuMZN+NjTc93Cf0u+csRoj?=
 =?us-ascii?Q?FwYASxzJSatK4YP7QAGEA4f49yrzwXUCFl3fF27CzflYHNmOPCJk1w16jqPU?=
 =?us-ascii?Q?uKGI/3GJxexEjbYYYY7qRUtqRvMkCKQc/ggmrU5C4bKQ72dOj9xDZBFOnpXu?=
 =?us-ascii?Q?vvWnf4tKZepeLmnaYOFj30zT158V+yGp+4BYU/ZQFz5WgEjKVh4+oPkALwiY?=
 =?us-ascii?Q?sZDq9JaJNUnKIl9RTuQ3xOir1SVUuE0KbpNaWGTXkc0b7Q37t50C260mGxrF?=
 =?us-ascii?Q?fRVe/g0CYxxHw1HSit2UdXGKm8UqLzk7a2A82m/yka6zLgQZ8Iqhl0FiuGoX?=
 =?us-ascii?Q?O/1PomSFK3gfF7MmF6v1T4hS9n3f27R58XirMu1fxUEN++WAqmyeWPqdWJHN?=
 =?us-ascii?Q?2Jyi6/Bf6iLN2gXxA/y99KWOx+5y4ahs4k2xed//N3WdKyDzNIuk1/6LykTx?=
 =?us-ascii?Q?fRNjkDGWG/59BPJsvovBOki/miN/dwqd576ndWbLg2Yu+JWfOqqbANAfF6Yv?=
 =?us-ascii?Q?Hh5TCheqDjOX8zS3yGjZzGJSGbPOmWOeXamPheNzy9QcSr/TCCgEYJhO89rD?=
 =?us-ascii?Q?rDS+HeGWVL8cZsjf3gBNdJea3LyfsXiC5PbX1rPlHGjsEXyvsWsXtB7b+viN?=
 =?us-ascii?Q?veEAZ6f4Ew5TEXTLnRa4DRawHBvGQQyh8LxeFofMPNqoamDP8f4ZCjhRpyOx?=
 =?us-ascii?Q?RqiEpIa9DYk93Iryng2Q0GbrLhs4eUOHiC9tqO9onlPU/lNobjJkLErT+8KF?=
 =?us-ascii?Q?B1qYImRLgQ0EfBUV3ifWKl8a9nW6aTRokHEPmYrVd9lkLQoXtCAaAT6iLEOH?=
 =?us-ascii?Q?TRO2E1KO+vuh8FLVkG+LbUQadSyoI5B237vA0UURq5qKoMAQC5Q7uIEPq2qy?=
 =?us-ascii?Q?bCj5aAV4sr3wFdCu6XRwF467zwrEEufbBKu6gRJvvJ7Vu0N/VZ8LS4n6Oktl?=
 =?us-ascii?Q?XyxRtaHWzCeSIEHPhiiMNlMxPWrjwKWvAk0Ycs3NTFT/vML2yjJx80tLsiWZ?=
 =?us-ascii?Q?y0UpggxOesFQgYn/1OzFJ3ZKnrg3PwBr05saghubTI5g4XsL2uocBRWvibJU?=
 =?us-ascii?Q?dXsFyxvPhxGYbmp8hwBbQ7nTwLE4AmHrZ7McSQFHaCP2y9tS677kWpKiueYd?=
 =?us-ascii?Q?lnf4HO22C1Tbg/I4L9e0NN213Mx2uhfG3tMibEAmJqgb+7UWUaHaMQbvaiZF?=
 =?us-ascii?Q?OQ=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuVrYqwr7lIMegrvTkslvLLV1mh2OLF3dsumZWV1vxNsyn0n4ZdjWDQTcDGtYCLwqJ94EooiUtuoS7jgxAJMZWtSnHx3gPo4bYopU3Xr1T7FIK/VeWqjdXLMcGzyh/NB2HJ+6ohu6M4pBb5stoPy5MHlPm2rz5dMdNEGXL/6J1gFPHr1HVvgol8uvbe26Fmy2ibapkR8GEDbqtYSF9bIy5vwkfJkXOo2iicPh/TAXO9TlerMSP5Q7CSqCOCT86hIr7iRwcT+Rl+WtzJbVaRQk3iH5lWSKGeFSoyFodsWhNPB69Gwe7xme/5NgC1GL0jNI5cTeDxwVPofHneqgMvrEg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waGsyG9Bo0DQ/Tvc+WWzMrQ5azGIvALeyzz+A6NDMLI=;
 b=E0B2xPooIKaA/mRiP07akYgfR65lvj5bH96+7klhDDVraOOh637kjmIxqKQlBbuQu/c0e46XwwGWfQhpbxaLtBIaTpv3Y6Z4Q90pXTi8Z6cOLDRtXMAfBdGsjvOLLgJkVYRT+9xiim/IV1ZOw8hOs7t2sSsjLdyID/6VsyT4C1KqC3fz8KcdolJM2KF5C6GlAX2UrEuFY/xAxqElN1wdprW81aeQpz3FgHbtPVobqh/N0aHq+Ret5F4zWTQpfIbJUo2/HEzuUnsauu0psz33e63rCBSNr+cZ2rmiV8FDQQ+b08Otdsg7MjIf7YJ35NIqQQ7ErsQU0GUdM4Wm43u3yg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 0d831c23-b4c3-40e7-d86b-08dcccc14aa0
x-ms-exchange-crosstenant-originalarrivaltime: 04 Sep 2024 09:09:33.2014 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: eeCH2vKgMCb1hVp3hDQn3d2vyQCMbLrxXQ2apGTenasK5P0gmIh4PwfRYF/3omkNWMhn6gLVmVzPhB8RhyJe3Ew3rjwOrU1uTshKxBvr5lqApjT59i+9Pj2ThYWKvv9F
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
l.org; Simon Horman <horms@kernel.org>
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 3/5] ice: Initial support f=
or E825C hardware in ice_adapter
>
> Address E825C devices by PCI ID since dual IP core configurations need 1 =
ice_adapter for both devices.
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_adapter.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



