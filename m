Return-Path: <netdev+bounces-281377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF7uD7Bz72kcBgEAu9opvQ
	(envelope-from <netdev+bounces-281377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:33:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7704746E8
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FC99301E6D1
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3113D4130;
	Mon, 27 Apr 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNbVrTPH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90583D411A;
	Mon, 27 Apr 2026 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300204; cv=fail; b=YnyUpe8YJsKqBLqpcVnXonAEltm+Y1JMA1yNs3G+OZXvv4Tx/DJGWUljnyUr4qdpkxSpaHIWcIrUDrnf+5vLZYggT9++rDH8yhvIXizK+ecdKvvRFTAWhQj1dQKYfEH2UW5b1/NFLL3V5HvfYamcANdiUZgaqq384B6fHLsB6Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300204; c=relaxed/simple;
	bh=KMdpWVjclh+fvsCO7doj24N2KcfOCEuQeEsMrB+gLvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IRGp3JaoxWpntBtA578orolEGoTtUlivPzW/LvMnEhh8P5AaBf2SkDKTIJPxFfqaEnZLJkf3fcztFb8uGEyT827OQCvl2lsnaTYipLNLFd1+GuqT6gC/Rx9RkVU4VzkP9O+YPBG1IDLXDz19WwojJlVbgihIkRM5UK/wlsCKqtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNbVrTPH; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777300202; x=1808836202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KMdpWVjclh+fvsCO7doj24N2KcfOCEuQeEsMrB+gLvo=;
  b=XNbVrTPHGgMhC5Xay4p4vpWCW9J3yH/RXNNiCFl075kO4yN25bCrrHP1
   iIh5wQCQEbxaVS9RjvgmaaHjjWgt2Oiv9hOkVDoQ4rpXlhe32dav8N+MI
   o/KUiyCNS9SLr34Z1Bkj068OkzutkCUg7JWxGqehc8PCfpHVVVx6HQ/zi
   i28q9Z3ZbozEWkFK8D8EdsbtcVnV9LemBQle3dH8Qo9tTVFcI6W8FiYht
   TKl8g9N8GabxGLF4CgRvvBGxiuFFamFqSIb5+dbfMcuVPpKT/W/vdnoQs
   tCy/FQATB7b3o2qjGIxVGMOpgWm1lj/G4mHTX+Q2k/YPGwsXZd3/rR+vT
   A==;
X-CSE-ConnectionGUID: bYiHyw2DTXO31JQG6w06oA==
X-CSE-MsgGUID: UsvF8p/hSbeZiYdsfTxRfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100845928"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="100845928"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:30:01 -0700
X-CSE-ConnectionGUID: 33JD7j86S/e86V3PB+8VoA==
X-CSE-MsgGUID: 7n2oy4UHSuaW/GD2g7l25A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="271786073"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:30:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 07:30:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 07:30:00 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 07:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYU8yloXDG+c2X+tZhngnIgsKg4sLRBvvIXkQny9/vq7kGsx6MxTFJXkbWpH9v4bqaoUkvTDFcfRUetPJChXMy6uP2aiKEP2BBIiO3j2WGB5SJPZ0XhnbSSVaK+5ROfCx1V8l+L8uRn9jzm3pfYlEorwI66zIP4WFpgapU5RxH+4I7yIgbqjeY2zZCs+nVxb6RaBW3ujys4cimRhPi1XOIgly88aNA4H1e2YB06D9OTBx0oER9r31f2TlNuS9NYzRrLJJQsmmUPil0RVWgn5yesKOwgUVSqzBpFIdYZKx3epop8uXxjP2AdXPtJQiJYVDZoUlTrUF4EsvasRxVhBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs6XFdGNL3GVTabAOaEiOLYt/vOG9uPa2Gt5rDq5wY0=;
 b=ZrFd+ObdOUuLSlrGFFIDq8JMyRpCGOBLQ9rGke1zqcODWX5yTy4WiQ9+XX9fE+qSMQPiohzkf6fJD3ybIiZCeOLwXFgFVpzNo2qLoSewIe2sfLCIZNiOxtBCNpIntimVL1scKHiLEh3r/E1o+pGan8KPWcqhITb8bzOiNLQhgUGERUSjfQJ7UsFDu+mGj9tSrUpypUxmoj1JTrSAd1w/bkdN46/dsMoIMCtcIUvk+OO4LzmYPG/wd/OhLUPZaeaU72Z2VfEcVj8G8OPa0Isui51pKyYEI4bIOTgUdPOPPT73j7E7TJ2O1z5BYbanQYjfAIS1upUSfrphJmzAzA1Glw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by DM3PPF4AE904FD9.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 27 Apr
 2026 14:29:51 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::7b0c:7df:21b8:dbbf]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::7b0c:7df:21b8:dbbf%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 14:29:51 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "Vecera, Ivan" <ivecera@redhat.com>, "Schmidt,
 Michal" <mschmidt@redhat.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Rinitha, SX"
	<sx.rinitha@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net v7 3/3] ice: add dpll peer notification for paired
 SMA and U.FL pins
Thread-Topic: [PATCH iwl-net v7 3/3] ice: add dpll peer notification for
 paired SMA and U.FL pins
Thread-Index: AQHcznrd26w2nzavMUWL7AhYacG7wrXzBdrw
Date: Mon, 27 Apr 2026 14:29:51 +0000
Message-ID: <IA0PR11MB7378830375A8B5DCF3046C2C9B362@IA0PR11MB7378.namprd11.prod.outlook.com>
References: <20260417145907.696307-1-poros@redhat.com>
 <20260417145907.696307-4-poros@redhat.com>
In-Reply-To: <20260417145907.696307-4-poros@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7378:EE_|DM3PPF4AE904FD9:EE_
x-ms-office365-filtering-correlation-id: 2aef7914-9e3e-41aa-83b6-08dea4697195
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: aANnpE9ct7WlPBsyDoL+XGhvrh+2SQC/cicQJwtNgqebaH7q2p27CSDCuUhu/SqLMYLKge7rDPro/yPPKJyHxXKSv/wRB+ioTjNmUCH77WQDZKhxgY2XLULgQg1OeEi5RqVMcZ5awDXhd6ZYQq3L33bcsBYswYwsilRBJbtYGxzLwNLYyWFSMRYcqp5SZh6wsgOQv33CkheNXPQTsdh2Q5w8afgjHPKAlUUbmndGmqhrn/AsnB9wQXfmgT1JmxlCDKCw63WBsWX+PQhuAu1ZrDXfq+QHNGFSBE+z9Vh30NPaYHxXmxc1SJ8mFme3yDICc6WYR1ckJRELS2+b2K6KkHcx70+uInt1azw9t8AqdBCvpD/VzL7x8RZqhUG416nNw7bnz0bT9FHYVPFy5unw9z4EyIow0Qi0c+K0cGo4B6gX0iPBynOMUY6fPm5/33W9xnyWxjVaIqCatAiP6qhsrNW36QOC9LcwqeMeAMfOz9x+5Qj4uBhoN8/X9WCIsJWeNF4jL7Id01eYY17Q6xo+WSLcLRFiXqpJd4dyFh+Hhlp5JQPEDx5se12u+jSrVvp/9+PSkokjs6BCBQs8sokSv3kQV7jHsiMP/yx+J0GgLI8Mr1uRUEyFKeiGdHPLwd7xQfslncC3Kr5tgnRXFSwhHLB+/POiuPE5z+Hp14Ps/MJ16OnWxiDzjGYjsYsrKJuYh4ck9WzuJV5TDzFCdjfgunlZcbCkvBIFiuwfH5a0FvSZxhra/Rm2FJBd7MQdasgSL3I6S4mvhqRjDYsYSqfZcK4eEeMfjBH+F4zC+StZWuk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vtw34nHoO85TRc/HPJlanmFzbf6mVcT18uYQkbwKljskqvL0HCkfz2TU/J1D?=
 =?us-ascii?Q?ghaQQcNtYplPx2wvCrwS9A9xuEODkc0TBhXiyr3BATvy6XvWhh3QL8bGqT97?=
 =?us-ascii?Q?w/ovDWTsgTNHjucRHn6N3FbM4aw6Qlf9URH98+/Asq6r8G27nBMQ+h2AZ/72?=
 =?us-ascii?Q?19Obd+REImZ9BXFPwQwU9j9iwHnAMc0vuwXhSa88J2oqhhMApk5VaNO82ol2?=
 =?us-ascii?Q?3s2Ah0txPb1a0fj7RB+CuDTsAhQY6ZNNWvFMyZw/RA5z9UTVTb8HhdDRcVz5?=
 =?us-ascii?Q?Zt4r/9HvvrryudFINfzLEtxNj9vRzuuQd1R1aBnYWDr8OPFdxRoV9vY6C329?=
 =?us-ascii?Q?maWo4UZJj5nE71XX7doo80U3G0vx3gKNOtAdwAemrSRh+NG8nnSKjN+rW2BC?=
 =?us-ascii?Q?yXOO2+z2NvSoY+LxXg834SpcaaJlc+B5dqSJlS7gYsqoDGmXKxlGDMFiVvSD?=
 =?us-ascii?Q?3Q6J0OIQLvG8aI1ghOefCtGg4OITxDH3hGkxOb91PR+RPig+RFnUhB8XQCm/?=
 =?us-ascii?Q?JRZgnfChrgGK+lvMUgQq6Ow3Ik8abSRIwFTB3LscAEtO5nDgEWMTDFqcIFgJ?=
 =?us-ascii?Q?izv8s6ZuTfR41L2arOXsdNlbzoH/mTLjMpo41OFCVoYMDSDf4GIOjG07V9k9?=
 =?us-ascii?Q?jHMxzdv8DyY8RRW9PXdIXhLPwcYyBJPOcOLEEMo4O08/NHP27uAS3+elSk00?=
 =?us-ascii?Q?bF2q8iweo/v5mcvYQ40TkGlpTNz1SGSUrP+CEnpqY2wgrdfyIe9OWbA6pMec?=
 =?us-ascii?Q?Cfn1I8DSkG5zM2/uH5qSIZstSY1zWeqOaFf8X2U80Qm9ZQCr8jFg0UNzAs1N?=
 =?us-ascii?Q?iHka4LT7am6sHrCAkWhmbnxBcswzHA/4orBFj7BMZUTJsNYQJlZ8bofZAARP?=
 =?us-ascii?Q?SWawkv/uxMzm5UuOgngV3goCwZhnOQG2Ab355ByK1sGIuUYkYUYOL2tiAfro?=
 =?us-ascii?Q?vQbFh/kE6XKhPJQ5AOkDThJWIRA8Wms3sDWf3sQ2X1JHUdVPVq90M08GxjvF?=
 =?us-ascii?Q?3SFIleNInp6wh5gQ9FKGG6o4ZBMwGyxBbNpv+YUsz2UVTpahQ4X+e4jbfRnn?=
 =?us-ascii?Q?0eB+OG0Se7SWmffx/bHNjdFhHGcbYyVyTir1J4iBWwXjb6p6mPJ4IeoNVFSk?=
 =?us-ascii?Q?CJmhR30r8ly1q5ur8za5I4qzw37fhLdSOYaI8FMr/YdqyQ+O9myAhz08gQvx?=
 =?us-ascii?Q?zjApG5FkWaBvIVYoiyRlJLq0RLW1MDIMORinZsHbFqUQzCJwwWkKnc7JM4kI?=
 =?us-ascii?Q?mCgM3Urq0RymhwEhrphKdzwiedAV71rZmtgX+qXgINAkwX0YEaIvnW54l9sQ?=
 =?us-ascii?Q?n38XapA7CdXKyUbKuxQx23Z5Kcq23AcHz1uNqXEe5lHY5nxCiQCG2jkYQIAM?=
 =?us-ascii?Q?lv1AHbmL/RXUqcMEg4RM75ki6VGsjoPrd4gxhPP6EM04kFRXc6R6ugvB7bO5?=
 =?us-ascii?Q?p3ucWoYOXOtqjvTe8ylr2HcmP7LAHisQJWwckR5OtfMmqXfTCF1ls0OK+9Rk?=
 =?us-ascii?Q?9PrvUvxlp2Jt/P5oCOIRT/WnbNwnWTbUMRUVK64//fUkPakwFhL5/nhvwvDK?=
 =?us-ascii?Q?Qnok55P6hgoPwO99758T94kEPsbWmnxNgnbxFVGZNyuU+NE7lgNIXlHzc6vR?=
 =?us-ascii?Q?WgDwLcZMSL0yXV7cvzMKsqufVC+RXC3SJLLSndbQvsztdysqzU+rX1rNk94u?=
 =?us-ascii?Q?YV57VotdSWVbexkcsnmFcLU8QmeCHpu//3hbXTOKA7rF5XkkBdxXeSBMbftL?=
 =?us-ascii?Q?T+niZhjcGvPT5vB0b77MSfF+fSM/q80=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F8Zi8zWoIaRXCIyxO8mb648upZFJDJIYdTKYGi+nZqnvyAnwUapqt1Luzv8KR02VmmD7Uz/Negb3eKW63bIxNfQ3M3jm+vovaLIOfJpCwFJxIS0G23yB759obIRjLLXV9qPem3vzgRN+c3q+JejglZmOrCDSsn8I0fpO4+yJma/dlM+u5wp4lzxc12osAbPPoob0YSpoV4wAi6eEM61xnRwTzP0aav8BDOtlhZQqnX5mbg0cpS2YtGWe6J/Yh/Kv2s+V16bXNPg7sUibCEM6Jh6+N+RZgwgxsGg+toukq21OzvUDGtd7B5s7a2d2hyenLUAbfQIiANprPD+GYciXFA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aef7914-9e3e-41aa-83b6-08dea4697195
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 14:29:51.7075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Fhal+ps7HerVaIz88VcGMsNn3JwzOZuD/4UQ/0O1xpVmjaRW6PyA2VhuBY96uZGDS4afw+YzoR4rMBjxJbDXWSHnwzSRf/TUxg1kSzGezA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4AE904FD9
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 9C7704746E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281377-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,IA0PR11MB7378.namprd11.prod.outlook.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

>From: Petr Oros <poros@redhat.com>
>Sent: Friday, April 17, 2026 4:59 PM
>
>SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
>SMA2/U.FL2).  When one pin's state changes via a PCA9575 GPIO write,
>the paired pin's state also changes, but no notification is sent for
>the peer pin.  Userspace consumers monitoring the peer via dpll netlink
>subscribe never learn about the update.
>
>Add ice_dpll_sw_pin_notify_peer() which sends a change notification for
>the paired SW pin.  Call it from ice_dpll_pin_sma_direction_set(),
>ice_dpll_sma_pin_state_set(), and ice_dpll_ufl_pin_state_set() after
>pf->dplls.lock is released.  Use __dpll_pin_change_ntf() because
>dpll_lock is still held by the dpll netlink layer (dpll_pin_pre_doit).
>
>Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")

LGTM,
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_dpll.c | 32 +++++++++++++++++++++++
> 1 file changed, 32 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
>b/drivers/net/ethernet/intel/ice/ice_dpll.c
>index 11b942b83500fb..be72a076f7a15c 100644
>--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>@@ -1154,6 +1154,32 @@ ice_dpll_input_state_get(const struct dpll_pin
>*pin, void *pin_priv,
> 				      extack, ICE_DPLL_PIN_TYPE_INPUT);
> }
>
>+/**
>+ * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a state
>change
>+ * @d: pointer to dplls struct
>+ * @changed: the SW pin that was explicitly changed (already notified by
>dpll core)
>+ *
>+ * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
>+ * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
>+ * expander, the paired pin's state may also change.  Send a change
>+ * notification for the peer pin so userspace consumers monitoring the
>+ * peer via dpll netlink learn about the update.
>+ *
>+ * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
>+ *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
>+ *          still held by the dpll netlink layer.
>+ */
>+static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
>+					struct ice_dpll_pin *changed)
>+{
>+	struct ice_dpll_pin *peer;
>+
>+	peer =3D (changed >=3D d->sma && changed < d->sma + ICE_DPLL_PIN_SW_NUM)
>?
>+		&d->ufl[changed->idx] : &d->sma[changed->idx];
>+	if (peer->pin)
>+		__dpll_pin_change_ntf(peer->pin);
>+}
>+
> /**
>  * ice_dpll_sma_direction_set - set direction of SMA pin
>  * @p: pointer to a pin
>@@ -1344,6 +1370,8 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin
>*pin, void *pin_priv,
>
> unlock:
> 	mutex_unlock(&pf->dplls.lock);
>+	if (!ret)
>+		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
>
> 	return ret;
> }
>@@ -1462,6 +1490,8 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin
>*pin, void *pin_priv,
>
> unlock:
> 	mutex_unlock(&pf->dplls.lock);
>+	if (!ret)
>+		ice_dpll_sw_pin_notify_peer(&pf->dplls, sma);
>
> 	return ret;
> }
>@@ -1657,6 +1687,8 @@ ice_dpll_pin_sma_direction_set(const struct dpll_pin
>*pin, void *pin_priv,
> 	mutex_lock(&pf->dplls.lock);
> 	ret =3D ice_dpll_sma_direction_set(p, direction, extack);
> 	mutex_unlock(&pf->dplls.lock);
>+	if (!ret)
>+		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
>
> 	return ret;
> }
>--
>2.52.0


