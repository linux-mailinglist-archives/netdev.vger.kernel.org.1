Return-Path: <netdev+bounces-161706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A40A23834
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 01:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F0B166DE6
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 00:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041324683;
	Fri, 31 Jan 2025 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaJv1slw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2945FECF
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738283127; cv=fail; b=FQ/NtmDjtBJumoIcML7cwtxPlzAq2DYkmO7QOYfbQQOJXTZVm5KsV3QWaZ9Q82aFX3bpH+x3WXcKax2tQKb5SwSwOuoJMg8CE1qKUEphV5JCFlj1/3HpaaFQsj8wW8kur+S9x7qT6hrKsEpOg4G5TKSGwLW1QG8VGxsEZa9lBZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738283127; c=relaxed/simple;
	bh=I8v5Vg22ESN64lnwXkg608a/9WmA4JWvGq4fUcKT/YM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WyLSh91DPNk76vXg8BfGSwmrWA4dH0xvjISdMMJrw8HkWaAQFZtTNSawrkOsklzsnhcRQbLy7oQExj8apwV/16t/ZhHkOLAUWi8Ku2GIL2kd1e7o3sY7pLva3LJmJZpOzyInVFK1DA/Oz8w00i5Uvp3MpCgLLbBnzN6mJfN0uN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaJv1slw; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738283126; x=1769819126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I8v5Vg22ESN64lnwXkg608a/9WmA4JWvGq4fUcKT/YM=;
  b=YaJv1slwsbA7BfYjBlHFKjkYsM3VZddXmpCTtiDCoIde6yvNYdazTl17
   XcTJdrhIlDXvQgtl0hmIZaGASNM/rgcFhbZs8XJ68YIGnzG7uY5XhOSKI
   Li8ZdeKbuX0+zdliHvM5olut2YXZDIG2InMJpPJrYLqZMaR7bK3gyUbE0
   iEP1qmQZngLJFR0mLIFcCxS4IOFpzqRmxD12iXYAmPEl3Sc0rMEx6yQWW
   y1g+XDdsq83M62FhWN4ldkmJQjLtJ7GWOdW7ldspnIFx/MYjXPt4rKSCn
   073z2eJPMpShHOh8vangrdPXmj5pan7fyyKgZcJocuf3wN0G7oR1t19oX
   Q==;
X-CSE-ConnectionGUID: WQRoOnfJRxGJQcOH7HETOA==
X-CSE-MsgGUID: 7IQzRZ/9SOO8Fx37iWiNNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="42605360"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="42605360"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 16:25:26 -0800
X-CSE-ConnectionGUID: P2tN2XfAT3KXCrfOiNwXFQ==
X-CSE-MsgGUID: COysPFSGTxKE5lQRIqlZQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113511761"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2025 16:25:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 30 Jan 2025 16:25:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 30 Jan 2025 16:25:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 30 Jan 2025 16:25:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyWvmuED11tYDvT3qqxp4eqkzEaA349jutvS+XyOUGjKpKxEQh7Bv5Hxn9PSYFOdzRizjLhAxoyZBWzVBYRsCyxEMI4IEr2dLKJWolsq3AJiGRuV/GXqfyTK7SF1NpaCCrQwKL81IGHUBYM2wlO9afwUi7SU5Zb9xmZ+iefR7IXlK5n8SKXf+e6Rx0uhVfqHLsVqDYYRVff9xciz1/2cJe+Vv5VKFtcIeZjOXZOgu6pn24l0H2XdM5mgnMzuetEVS74f2n3pNMG+eimETrAO7B8CsnBzRQ5T7+PCxZhoPuEu+25Ha5840y4jaCNyQ+Qdfki4wG3SSGGKXN4tzakNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FU7NsMo3m+BhCSOqK7+RbOYRyxNIG3gnZY1lYdQjXM=;
 b=reLc11Bra9dJUsWLv7FvkI6XizF8Ks//S7pzqPMilTxprVelwojqhCQB2oXU3EYI3rH/LWDSbKIx5oaHz4VoBhhIL/Kw76lnnvAvcr1i/g5E7cpOkd3rXDO+siIAxV0Eq+XQviK6aZuXT5sxkqIONqpPZLSAAszdBHGYXIRcoSKBvmC+BWkcjyi3WMyEaypQuyPwvOX34Og2E3Se/iUNcIK0EO0INWV4BVJgh4WQRpUf8377ABvNLIMMkhFxe1+BwYT6f2jGcuGsYByrPZFmXdtScp9nb2/evnFPFFp3diCLCyfzAz06Wi2FPNzPanAeB74pTAfmIG+MI8hktRhFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by PH0PR11MB7615.namprd11.prod.outlook.com (2603:10b6:510:26e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.29; Fri, 31 Jan
 2025 00:24:54 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%7]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 00:24:53 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "xudu@redhat.com"
	<xudu@redhat.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Simon
 Horman" <horms@kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Maxwell, Jon" <jmaxwell@redhat.com>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>,
	"Nagraj, Shravan" <shravan.nagraj@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v5 iwl-net 3/3] ice: stop storing XDP
 verdict within ice_rx_buf
Thread-Topic: [Intel-wired-lan] [PATCH v5 iwl-net 3/3] ice: stop storing XDP
 verdict within ice_rx_buf
Thread-Index: AQHbbafMlZT0Eo0ydEmhRcVWofj3WrMwEQaQ
Date: Fri, 31 Jan 2025 00:24:53 +0000
Message-ID: <CH3PR11MB8313FC7A7EA90AF5C257DD4FEAE82@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20250123150118.583039-1-maciej.fijalkowski@intel.com>
 <20250123150118.583039-4-maciej.fijalkowski@intel.com>
In-Reply-To: <20250123150118.583039-4-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|PH0PR11MB7615:EE_
x-ms-office365-filtering-correlation-id: aaeed624-0a57-4e6f-5fac-08dd418daee6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?omQXPLS6iiYC30yMEZG1ZIc/48/ddyDfIVS6PwFYR5YDOxxOXa+EVmoBnrgU?=
 =?us-ascii?Q?CwDLyuNty3Uhvu4Q9I7oz1bWHQJT4SDOWp6zSBRqd8dQc5E8TyaACaDZ2HgM?=
 =?us-ascii?Q?jDHoLhcZEsVBEX6ZTL4GOhKiwHucDVPtRSAznoC2tbC1FQSQpG3uPwpk41oR?=
 =?us-ascii?Q?cImb/7VspaiyNhLOVbgCVVayMKUZQm6hekebZqbwBLPrp1bXprA50RJrcq34?=
 =?us-ascii?Q?Dm9Pp5TD/8x/ZHPkWdgOyqpx9q/wu9px7rEw9iLhHcsLlBpcrKaAICWfE+Uj?=
 =?us-ascii?Q?7kNK0ZJLsv0Nb3+MlCOxyQUIn1fhlwewmYcNxj4MiV4UJHiMAA9Zf9LN8tTb?=
 =?us-ascii?Q?8KbAL/tT3aJh/WpWTA6s02b1u3BwTRwo7fWhG8E9GlEmP7RamFFYO972Poah?=
 =?us-ascii?Q?M+B91C9WJaqWwIzIhMx56DCfzZhPpMrqihn4lSFfPzTxXQOZPg9oWfxfMSA7?=
 =?us-ascii?Q?EJew2aP01PGh7ahyRm78dhfctc92k24tQwgqeHEWNZ180JJGzGMKKE1awZYx?=
 =?us-ascii?Q?mQJJYH8iDiMbhSpFAV8yoGUBp7UXV7Rf/6iAZTvYBuhMiUKHcZm7Bu2g7ceG?=
 =?us-ascii?Q?bWVsheIYNLN5PQzb/6CBd1eeWRFnjw0vD+ffqLLJSgk0OIDu/YKfrSzJ5d4o?=
 =?us-ascii?Q?oUxsUf2FNUY3zNEAZ1n80/PcFQavuDsuzzi3GmDGa9pfOZn8RrsbRtRDFx5r?=
 =?us-ascii?Q?u2N3m9EmsH+vWbJzD+xiCixBQdqBgYUudpFAEUxhoctK5WyEwrZ5U6dBgLmL?=
 =?us-ascii?Q?VTn9dxbWVVdb0ACnzaEy3yH6q5mi36FQphWe7X8WLTgl34F/8vorMUf3ZUPH?=
 =?us-ascii?Q?2vHCQMonRUd/wOPqoSovoze42rTlymuPux8STUVj1DuNH5Pg/s5PRiAjI2oC?=
 =?us-ascii?Q?iukMgkFRA/3CA06OqlcXpcwY0nBTd79w5kjuwrHWElTnu4IXOvU5ZhI6lbOG?=
 =?us-ascii?Q?YuvvcFJLowdLx7r9oEiM9BDlYTVNFCV9gKJ8H1v7bKaKOYeZxM1F75PmdLfI?=
 =?us-ascii?Q?uonfFihRwBddtUFXit6FYUzqFHICynsGXdSliYIjaI9uhFYdENhszCleYPSH?=
 =?us-ascii?Q?NbqrBoYWMZsv+sLxA6CIbIenF6z//kkUM3DuScgidc8ON3dW+Ve3xM/VhBIv?=
 =?us-ascii?Q?40RwiNYmaE82VsNAKhIags6UyoR5Afaj4zqEcCP+Nvau0KtZb9mi/9VwHARn?=
 =?us-ascii?Q?EhfBB+iCrwVoaqg/7u7mqpSH7o4vwQFiLL7muNGLXQwao58+Msh/OIn1SYDA?=
 =?us-ascii?Q?fSXxWSWJmYNJlbMdUmGRuAayy6/pan5yZzkJlsztag9dw1hb+UFwtXMYxTKJ?=
 =?us-ascii?Q?heHU/O4hQOJQtF7VDfbxN6v6yhN0/7IjcFrTdHekwQ2PbEWmQVDiHENpSy29?=
 =?us-ascii?Q?C+bil/aHDAs0UMf+Xc62+8udMJzLT7YrDETSgXsnsHGGuiXq/QLdTyzbjnYq?=
 =?us-ascii?Q?1Iy+IEgug81x8G5GSnby5Dx1ygwWb6IK?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Oy+YEyPl+FkY9iruHLoklIxb7M+HGAeh8kUhWKpGdZsPNxXisn3jHxBPw4Hz?=
 =?us-ascii?Q?Lc2Q+ejMH7miQZdnABRYktAvG0g88h7BTWijK6pjk3HoTjgOyYA5h8VMUaIj?=
 =?us-ascii?Q?7PW0/REokBB2tKYol53T8R9M3J/rPHhMNyDqyQZQb+BoWt4c9lXDs3Yo3eN3?=
 =?us-ascii?Q?hVzJc7gjOnADhRQJJanZfQsTnDhOCXzVrG9FREe2Brrgbu414sdyZz7+5Ek8?=
 =?us-ascii?Q?Dx1dQ4aEDFCgeD9ae6cHZvlL1LI3d070Vg9Fl6Am1nnRkGUn5nfq6YYcjhg6?=
 =?us-ascii?Q?RvYxcEHCCSNmUHJH0fRxwl8saZA7ZrtR73YkhLxP/pgvJfUzgAATWvrtAo8+?=
 =?us-ascii?Q?vDfgGluJHQOva7Os7FMglS5oN6Yyv+b4msF3fE0dmToOLIKGQ5M+pyqJfOXS?=
 =?us-ascii?Q?OO/O5R3VvNwLknSvd08lWRk/BVQaIK+pjfZ9P9mx+n948fngySEiWzFJzwa9?=
 =?us-ascii?Q?oRXEaKHkWKs9FFU/lBs40gG1HZYCggWTDQb4IrGklcChg7/31qKKE7p7bffU?=
 =?us-ascii?Q?al25PUD7sRmPdamAp3rz7o8mTvzR60CD/QXPxHgM5KpPX3duD8bARwCrStQ4?=
 =?us-ascii?Q?FqUE7FrEop+WjbmIiJH2m4/wHjPHPQ5P07a9oHI5gteuvMQg6WVTogBUyjQF?=
 =?us-ascii?Q?kQ3MaO+KIhyuSzbRfq621ixIOmg6TzvH9WegrJ9kVQ7v1vnabJOySyLecQpf?=
 =?us-ascii?Q?6zwwLTJz04rMNdILOvRl+lDaj1rpCgCtftamrOlIgqV+vMfpaYNiaF8HCL4s?=
 =?us-ascii?Q?TdroPzVajME54XTHvU3wlYHGUyCg0q6yZJCy3ypwMGCmMPsbUB5vV46haqVR?=
 =?us-ascii?Q?dGMdYmjPu6HxYz2HYwT0AtaFhKKtDCCJE36li4KavzUuj+Zac/O3A2Y3kGPe?=
 =?us-ascii?Q?vXFtAIuU8R5vanMI48SuwueWZs9xu42dFJho1c+l2uRmvYKpZsIDmXmK2dZR?=
 =?us-ascii?Q?ShQmgJaurr5k2o36WntG4RtT5+PTM5C1hT4lC/xE0yqP94Ck8Eiyc9a7BWrJ?=
 =?us-ascii?Q?RPCqHuFUEFDEKQ2ivD2x5990NuLd9GkIj9n8uk7QmbjUld1fg1ACgKVgqX3K?=
 =?us-ascii?Q?Ip7XtumH4SurblR7TOTy8WrhGIz9xGecvjE98wOf3dSmE+LKzhUgXgfGbiXX?=
 =?us-ascii?Q?zkUBH1cD3bCYD8w07E2QQqT9npu95hqHShFrhRBcN1P1tAocQPwWx5nSJ+Nf?=
 =?us-ascii?Q?v6ixEw1+JOrn+pmX7yZSqej9w7kkeSd1++TVrIk+7Zf0G1ZeCwQKJRPMfYaT?=
 =?us-ascii?Q?yduQZonML5InMq2ATy3t9CSvn9NZ+xEl1A7yQpbgRg42fkEzTB3SxPZ8gYqH?=
 =?us-ascii?Q?vcXLGMvNZC+1Tyi7ldlE7+6by3xZLl8l6ypfRq3GZyYB2FEqSBLF6RSPVlMN?=
 =?us-ascii?Q?2VKnPE6/WmSlX7g0+FMQEEKSW5wXghRDfXkHG8bd9+TvR22f5C3IZZPpXS5I?=
 =?us-ascii?Q?VqHJQZrr9YIZA7CPhnsTApkhkfyQ1iWGgqdPZgjSrShYnRLgHwDzbnyWv4Pe?=
 =?us-ascii?Q?A6nt5M434mhXNnVKl9z0QACaD+n7OxZdcz5ntAtqbXe7LR3ngbDJVpU6X5Q+?=
 =?us-ascii?Q?SqPm9jd4D4lDE/PtjZoE/ZpuEC7j/a9tZTnK7SeG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaeed624-0a57-4e6f-5fac-08dd418daee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 00:24:53.6607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PnVhMPvLTD+8U3bUHzt3D4sazxWctgywebHv3UlODLsMFmOHBvrlr5bOD2qfEZpv1h+aQtGE7NErFfM/I9cnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7615
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Fijalkowski, Maciej
>Sent: Thursday, January 23, 2025 8:31 PM
>To: intel-wired-lan@lists.osuosl.org
>Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
>netdev@vger.kernel.org; xudu@redhat.com; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; Kitszel,
>Przemyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E
><jacob.e.keller@intel.com>; Maxwell, Jon <jmaxwell@redhat.com>; Karlsson,
>Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH v5 iwl-net 3/3] ice: stop storing XDP ve=
rdict
>within ice_rx_buf
>
>Idea behind having ice_rx_buf::act was to simplify and speed up the Rx dat=
a
>path by walking through buffers that were representing cleaned HW Rx
>descriptors. Since it caused us a major headache recently and we rolled ba=
ck to
>old approach that 'puts' Rx buffers right after running XDP prog/creating =
skb,
>this is useless now and should be removed.
>
>Get rid of ice_rx_buf::act and related logic. We still need to take care o=
f a corner
>case where XDP program releases a particular fragment.
>
>Make ice_run_xdp() to return its result and use it within ice_put_rx_mbuf(=
).
>
>Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_txrx.c     | 62 +++++++++++--------
> drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 -
> drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 43 -------------
> 3 files changed, 36 insertions(+), 70 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)


