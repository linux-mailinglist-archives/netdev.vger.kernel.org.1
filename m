Return-Path: <netdev+bounces-197757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C56AD9C49
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 12:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7B5178CF6
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01B247DF9;
	Sat, 14 Jun 2025 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnMeOreo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703F5FDA7;
	Sat, 14 Jun 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749898750; cv=fail; b=dLwaQYvs9fzUdi8By6AS43RqbRV2Noh1Ju3ro0RMfyLq/UjkK4stnDP5H7QTE6a+of/Lk9UZNkvWwnN3rHN3mrau5CmVIUcp0Mk8s7gf7Ci9jzx40HAtFX4Pj0GSdCpktmlbSfEFKCqsFYWFlDNWTqAqE2zv6XZ5CACpL+rhK84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749898750; c=relaxed/simple;
	bh=mxe8bjgu48jsxSU7FvpaTOYuYhh/Uk/LpyMmbf0Yd8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lvv4yLbwRrHOqSTFf1QBQ3EP77Ixe1rXvRwHfcC6KKk0ZYowhtmi+qkmkp7CxDl5Ph5Yg94Dd4K3ORV4dbDsZRs3yTr/qNG55hmH3lq3SnRRflY/uoryUOm8T4L4U3QslPq7vRikeIJoQqUQNI5M23YO04hEpA7QeFW8BXNHfx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnMeOreo; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749898748; x=1781434748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mxe8bjgu48jsxSU7FvpaTOYuYhh/Uk/LpyMmbf0Yd8A=;
  b=CnMeOreobaXCfE+2nYsJNoHLxl7Zbf3AWHtdadHIcIGWt0gYxGOaOvty
   BR9yPQmD4tALOTaTTE8McKV+/n5JJ1gXBKfXlPkJb+kEMoypEqFHbsDbS
   t9aYSUhnBFZmrmYMGIXPe5y/ppBEAFFsFD3SMXek+67c8JsR7+YCsdxhi
   HBNvMMDklq/xHeEanGTR9s0KbZ76T223Hkwh9gbVKLe0uNUfaRyuHlsod
   6ppfB1Rgl9oXWKoVcO1tg+s1phOL1fINcTGP2jjIEzh/2xhP1QJWHFENr
   SYNpiHexMdqztgRTST3p3J5FO/z1ymqkRZlqQXQKq7HG3n9TKJJ8pgpB7
   Q==;
X-CSE-ConnectionGUID: OcX7ipI6TRqfVy/mzqn3Iw==
X-CSE-MsgGUID: oaRfBj2CSGueoQDh+4zCKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52025049"
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="52025049"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 03:59:07 -0700
X-CSE-ConnectionGUID: WEVwP0/RQYq5lveAZe4Ldg==
X-CSE-MsgGUID: tlJ98imVRXSgKdYNtTJyKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="152810895"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 03:59:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 14 Jun 2025 03:59:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 14 Jun 2025 03:59:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.85)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 14 Jun 2025 03:59:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcorgNqhm7r0YY7XEEDCNHTg1bCLkBI5tv0c5Z94NnK6tyoWjBatRajdkFQd3mFkjY+rhXShIOmku3Yuyh1QKgIYtsHMd7MmzpScSknL/buJ3G/mhKdYWhumcdDQ7N8nS743AXlve7himHaUdw7x956daxN5aT2AROkzglhnVNo6YVHFn7UozF3zINMhvRjKqoqqSIiU+abVEPwFT7c0RfDO0JUCz4wiTIj21ZnkuVssLW5CDh+gU+ga8DlvvHb4wWSEOVQQKzRjYVzoEOWGP/PL7yj9+jsT9CNBx7tPICQhhPli6BoRQMScj+z35YH5JsaBgr3yUfMcYM1WTFkBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s6ZoJj8TlPQrps3GWh12JIlfd8pY4LI6XeqOhz3W9Q=;
 b=kjfcmPQb2Xx7ei+E8BJ5MzVHJAq3rd+2Gi19ipQshHs//ioEmWjwzGK5yai9NDnwxV737uPaUCV1WpwY/zi4s09vkVmGD0dH18EHCvScM7+jATsjoKQObQPedEacVYaZZV2RzDBFTxa+PLr1K2sbA3eBqffq2UBAqDzX4KHaEKRpgUxR8X7I6PriKIbrdXNbwxnU4OnGtmvj04MXr/yGsi/+iWkfOmGVA+LpjYo3tWOE+7OaVxM/7sr44PAnxmxP/G6CtRJGv1Ye/fL95+CxS+UiFJDrgStlEy+bLsckamNhVh+5g4ifFJZrMvgG6SZt/bXOMjSauWPTMteqs9x1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11)
 by CY8PR11MB6842.namprd11.prod.outlook.com (2603:10b6:930:61::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Sat, 14 Jun
 2025 10:58:45 +0000
Received: from PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f]) by PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f%6]) with mapi id 15.20.8835.018; Sat, 14 Jun 2025
 10:58:44 +0000
From: "Miao, Jun" <jun.miao@intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "oneukum@suse.com"
	<oneukum@suse.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"qiang.zhang@linux.dev" <qiang.zhang@linux.dev>
Subject: RE: [PATCH v1] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Topic: [PATCH v1] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Index: AQHb3GCJdtb8MN3k90izmC3RZYbW1rQCQH8AgAA6wqA=
Date: Sat, 14 Jun 2025 10:58:44 +0000
Message-ID: <PH7PR11MB84551B0C08AB204503ACAE9E9A76A@PH7PR11MB8455.namprd11.prod.outlook.com>
References: <20250613124318.2451947-1-jun.miao@intel.com>
 <aE0icNX2nBiopztj@3763e0283353>
In-Reply-To: <aE0icNX2nBiopztj@3763e0283353>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8455:EE_|CY8PR11MB6842:EE_
x-ms-office365-filtering-correlation-id: cda04339-04a0-4b1b-ea74-08ddab326e8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?B1i6HKdM8jq22M7U1ByNCmbDs9EFnIUELAhxze6PmpsKrJUejZgfEVrAS9Z7?=
 =?us-ascii?Q?63nWyndIXy1QToDhARUESs2sw4mB6cSfDKAcyklmHtUyw5lTyBNTLazKADOd?=
 =?us-ascii?Q?S3NN9nAbUmL/IFa53UBb0qu2AOodb/G3VPP+jbpYWiGlb27AV6OvYFRd0AMG?=
 =?us-ascii?Q?pft4JxIfjxt7x25DWaKzS7b21S6VemAdNfuyodUXfaDvVfnPg9DP6KEw+DMC?=
 =?us-ascii?Q?ew1Z+G9FfbiidP2Qb9K9vJiKIkNUdom/QT+1XhnxJ44usb7i7zWPRmfK41+E?=
 =?us-ascii?Q?FgHpL+yTcPTNaXkbro1hKM+Y1Os7ThQAGYrtklvdZEOdGD+NUOQsqhGSBu5E?=
 =?us-ascii?Q?xTOQ/qs2koL4/piQeycwfjK3KcWjuUQ0gVxAKLW8ehkH9cA2I2Eb9H0u+x6U?=
 =?us-ascii?Q?O4a9L0VAH2NZY0+rRW+VSJguDvKLTfEN2OrXba+DiYnoIgsvuvJrPPuRgCc2?=
 =?us-ascii?Q?0+u27UqdjZJ3hZGh+rRySgmT3h3k9TYj99mXW+lHZTRhHcyoIKT06EDUu7D2?=
 =?us-ascii?Q?mmYc6XgIwvX+Z9osim0PiraeHEjvJVzPg8xoxvbCdpvbqn9Jpt1UeuKIORKE?=
 =?us-ascii?Q?NcTreNTldKMAMr42veu4Sli8x/gYjnuY5jzp0bIAofuSWzyvSYd9nJv89aFm?=
 =?us-ascii?Q?PYicRbgovmnF3rtuM0d4u7zekuGSqdxklPyl4ORg4fr8mLjYxE7KC96Fa77w?=
 =?us-ascii?Q?rR6wtb2npJnqimm+F55q9ZoBadAJjdAus6Xix0wnq3KBapCNPl3BLKvcu/rW?=
 =?us-ascii?Q?GFwtKjK7hxKiKE5cId8+XOYlb9qtlBOGu86tn3g4x28/SzgJHbUnIWzLI5bq?=
 =?us-ascii?Q?V5mYtDbrZ2yJQTR3NVG9AQrQWZWQVt7e9Tu1eSsmGxth7sAeHrzdoMfGyoEB?=
 =?us-ascii?Q?v8xKnJ8qgHus8/lUSwNyCRGvDTCJfaDenXuP6Qw1riAUgh109mWg/6CZdnDb?=
 =?us-ascii?Q?BZu3dAPjjth6SdeelI3Nmry9K4DWlRnp1uDj9zUOE39nRmJg46iRh4G62LsJ?=
 =?us-ascii?Q?TBpl4oBUuftWxpGXvCvOMZyBM5mvd0cJ/fMlBBbQktbT+nTK9PovDuyWU08M?=
 =?us-ascii?Q?gb1l6EdoITQUwxae529NLw/wdKYXCa/zMPe8XNMy3OX//AQ65x6dbYXIe1Ve?=
 =?us-ascii?Q?EsZT78CO868hz5YExdA4YTXOw4cUk22QYP8TokjRsB0mRH8Xc/uwo8sdiUZG?=
 =?us-ascii?Q?xJvVXqnIHByla3WkbxHTe5WhfiqkwN+BRU5TV7xE2kHzQQ5025fxq0l0db1D?=
 =?us-ascii?Q?ZNuhp7g/93PbJhqVqKZPbiOUk358cnJv2HsGQapcEvydDQfI1X6kkmwz96l8?=
 =?us-ascii?Q?AN4ar59sfE49YAFlHSfjpSIK76pwDsx7ZNYp34fKflZNswVgm4rSkYaWqt9B?=
 =?us-ascii?Q?HEFpX3Hg5fy/+06Ch5iHfHEox+kOTx0jakwwhBDfj1Mcq2Y7UbcHV3NrcW/m?=
 =?us-ascii?Q?D0Ynp7RVBX+85qJ8sd0XEStDJf6GravYVCgFYuJXNJTPfaVFcnMKgqt/uvq3?=
 =?us-ascii?Q?o6QE4MbuOaesKW8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yyFcuEE51ihyaeDXhRaI7VwHS3nRGP3Le/UYIpEqKYEIxkVrqhIC0UHW1GEk?=
 =?us-ascii?Q?Wxi0iCS3r1dQRrHz216BGolsWsflaSIfmw5YsD/TRvDoVl1WyELsXzU4TJGm?=
 =?us-ascii?Q?0xnBEzKDk1WQtuDYULQYXz4MDsyTFTHCTi8lXKx6u0wOP6v2584OYXel411w?=
 =?us-ascii?Q?QL772nmaZXYtq8sg0Vfj3gk+9M87pRi7n2vzs3PSFlbWv+CO+oTDFF0RIYWs?=
 =?us-ascii?Q?nZKhRI4u0ZKlPELHHUclrre4eFx/1vweFct6ueamMgKjTGPTKu9Q0ywiLho8?=
 =?us-ascii?Q?Az6HQBoViHE7goqOJC0LPhUPPWNF3VdIGHFQvMksVGDiKxHzQRQZgvh1zuBC?=
 =?us-ascii?Q?0pmUbFnyC4a2figTOn6zyp3DI+mO8ZZ7V7xnyF3rmvBYzYC9YGbPa/fc5Oqy?=
 =?us-ascii?Q?Fnj5yqeUbzvjTLNhMEPIgILa8Az89k8muwxfCZu5Q9dM/PPhABqp5Uq6f7uj?=
 =?us-ascii?Q?7kTeYusffpyVqWxubISjZ5Tjlk4h2uwVC796/LeRDYjMmfRaDtKpbFCDFwK+?=
 =?us-ascii?Q?LdxUZdUGf1gIFei/x9CR1TmUMlFRyHuTphCudIA/CzzGSCyAu2XZAaUvAk50?=
 =?us-ascii?Q?8SXHQQAzozNGzLKj9IlNNQbBUFI0gV+Nc9X/WbnzHFIKZCi1L2sVK9tc8kpl?=
 =?us-ascii?Q?7M+nY5d5C6D85CNTSzsa5j6HIMA3EzaykNy12FFgn0JdwIQSkcXk0u9AJtz3?=
 =?us-ascii?Q?lmZoNASgXjuSF5r6R/NY7QV6niuNatxpY7GpC4f8aX+wQCgK1Oj7FQsKWyk1?=
 =?us-ascii?Q?eicThCxi2dAU9nBvydrKpyt+eVPL8S1+ZmISf9bEm5JYFD2ZuilvyjkWaxSH?=
 =?us-ascii?Q?+2iynaHjD79e+6z0GMvgghJAXz9h4evf/6dOtmGTGEdhn5tdFqh8ZrLDNE8x?=
 =?us-ascii?Q?5yt2Y+1q0AYRcEdbSHRlZ+tRLxvfHu7C9xUosLUvBg61RzCmDRnHEwo2ZFfz?=
 =?us-ascii?Q?m3+vYLgAjjbyioz5onZ3a41kNKG5SR4epfN8gaV9U13QBOaFTpu7NQ8+PG7k?=
 =?us-ascii?Q?6/or7oB257crGNtQbWJeZqlN7X408bLD60JbGL5NfHqZLrcY9dk17Oul0/hX?=
 =?us-ascii?Q?bOPyHNveRhf2UoaRheW5nZN0iguN972qCBKM5Fn2ryDCLYShVvd2wR1mCsi3?=
 =?us-ascii?Q?lmF88v+xu8MMA9uSZnVrER76Vjj/lheMfoevEGvwdia8qIj0vWDR4OSt468P?=
 =?us-ascii?Q?w1CGTgjUNWaTXqczplPZOYojfKp8NZZLFKvTPY0P1v3r9+WLIyxyIsEihUoo?=
 =?us-ascii?Q?gs06taxjdW0XVS8aQUUd6bTMIX1olpAzYuShYhbedKfzSaKQ0J5dg4NNhh3t?=
 =?us-ascii?Q?NgJFtG9Upm1oUFAecDU4C6loDywvTdmDzwUxdVwSRz/1nxX+MHICzN4myZga?=
 =?us-ascii?Q?D96nUwIzoy3bivDozTa4HxcG3P7NT8+DsoZ9VCYtXmHG+r1XYLa2c4HL4sna?=
 =?us-ascii?Q?/xd6tbuyMOwEiqSeTiRTY/F0UgJ8ZkWUJySbouFbhXfJ42HXvnoupvsTzfeO?=
 =?us-ascii?Q?1dZHGS91lpT97YN3Tm9SM873etyrGTqedCg/tyWAjSVDTzw2JH2OPxxqWls8?=
 =?us-ascii?Q?EIW8Y0xUvbgZWYTXLm8RBCTre3c55qJWGLaT74mT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda04339-04a0-4b1b-ea74-08ddab326e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2025 10:58:44.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FV0+45m5eRtSjryFAIHAvaeXUkbNYLWYsI2bTswGUQ67tLIQcDooXECPY0n+yjEOiGgO2K0hz74i/zx+VB+sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6842
X-OriginatorOrg: intel.com

>
>Hi,
>
>On 2025-06-13 at 12:43:18, Jun Miao (jun.miao@intel.com) wrote:
>> Migrate tasklet APIs to the new bottom half workqueue mechanism. It
>> replaces all occurrences of tasklet usage with the appropriate
>> workqueue APIs throughout the usbnet driver. This transition ensures
>> compatibility with the latest design and enhances performance.
>>
>> Signed-off-by: Jun Miao <jun.miao@intel.com>
>> ---
>>  drivers/net/usb/usbnet.c   | 36 ++++++++++++++++++------------------
>>  include/linux/usb/usbnet.h |  2 +-
>>  2 files changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c index
>> c04e715a4c2a..566127b4e0ba 100644
>> --- a/drivers/net/usb/usbnet.c
>> +++ b/drivers/net/usb/usbnet.c
>> @@ -461,7 +461,7 @@ static enum skb_state defer_bh(struct usbnet *dev,
>> struct sk_buff *skb,
>>
>>  	__skb_queue_tail(&dev->done, skb);
>>  	if (dev->done.qlen =3D=3D 1)
>> -		tasklet_schedule(&dev->bh);
>> +		queue_work(system_bh_wq, &dev->bh_work);
>>  	spin_unlock(&dev->done.lock);
>>  	spin_unlock_irqrestore(&list->lock, flags);
>>  	return old_state;
>> @@ -549,7 +549,7 @@ static int rx_submit (struct usbnet *dev, struct urb=
 *urb,
>gfp_t flags)
>>  		default:
>>  			netif_dbg(dev, rx_err, dev->net,
>>  				  "rx submit, %d\n", retval);
>> -			tasklet_schedule (&dev->bh);
>> +			queue_work(system_bh_wq, &dev->bh_work);
>>  			break;
>>  		case 0:
>>  			__usbnet_queue_skb(&dev->rxq, skb, rx_start); @@ -
>709,7 +709,7 @@
>> void usbnet_resume_rx(struct usbnet *dev)
>>  		num++;
>>  	}
>>
>> -	tasklet_schedule(&dev->bh);
>> +	queue_work(system_bh_wq, &dev->bh_work);
>>
>>  	netif_dbg(dev, rx_status, dev->net,
>>  		  "paused rx queue disabled, %d skbs requeued\n", num); @@ -
>778,7
>> +778,7 @@ void usbnet_unlink_rx_urbs(struct usbnet *dev)  {
>>  	if (netif_running(dev->net)) {
>>  		(void) unlink_urbs (dev, &dev->rxq);
>> -		tasklet_schedule(&dev->bh);
>> +		queue_work(system_bh_wq, &dev->bh_work);
>>  	}
>>  }
>>  EXPORT_SYMBOL_GPL(usbnet_unlink_rx_urbs);
>> @@ -861,14 +861,14 @@ int usbnet_stop (struct net_device *net)
>>  	/* deferred work (timer, softirq, task) must also stop */
>>  	dev->flags =3D 0;
>>  	timer_delete_sync(&dev->delay);
>> -	tasklet_kill(&dev->bh);
>> +	disable_work_sync(&dev->bh_work);
>>  	cancel_work_sync(&dev->kevent);
>>
>>  	/* We have cyclic dependencies. Those calls are needed
>>  	 * to break a cycle. We cannot fall into the gaps because
>>  	 * we have a flag
>>  	 */
>> -	tasklet_kill(&dev->bh);
>> +	disable_work_sync(&dev->bh_work);
>>  	timer_delete_sync(&dev->delay);
>>  	cancel_work_sync(&dev->kevent);
>>
>> @@ -955,7 +955,7 @@ int usbnet_open (struct net_device *net)
>>  	clear_bit(EVENT_RX_KILL, &dev->flags);
>>
>>  	// delay posting reads until we're fully open
>> -	tasklet_schedule (&dev->bh);
>> +	queue_work(system_bh_wq, &dev->bh_work);
>>  	if (info->manage_power) {
>>  		retval =3D info->manage_power(dev, 1);
>>  		if (retval < 0) {
>> @@ -1123,7 +1123,7 @@ static void __handle_link_change(struct usbnet *de=
v)
>>  		 */
>>  	} else {
>>  		/* submitting URBs for reading packets */
>> -		tasklet_schedule(&dev->bh);
>> +		queue_work(system_bh_wq, &dev->bh_work);
>>  	}
>>
>>  	/* hard_mtu or rx_urb_size may change during link change */ @@
>> -1198,11 +1198,11 @@ usbnet_deferred_kevent (struct work_struct *work)
>>  		} else {
>>  			clear_bit (EVENT_RX_HALT, &dev->flags);
>>  			if (!usbnet_going_away(dev))
>> -				tasklet_schedule(&dev->bh);
>> +				queue_work(system_bh_wq, &dev->bh_work);
>>  		}
>>  	}
>>
>> -	/* tasklet could resubmit itself forever if memory is tight */
>> +	/* workqueue could resubmit itself forever if memory is tight */
>>  	if (test_bit (EVENT_RX_MEMORY, &dev->flags)) {
>>  		struct urb	*urb =3D NULL;
>>  		int resched =3D 1;
>> @@ -1224,7 +1224,7 @@ usbnet_deferred_kevent (struct work_struct
>> *work)
>>  fail_lowmem:
>>  			if (resched)
>>  				if (!usbnet_going_away(dev))
>> -					tasklet_schedule(&dev->bh);
>> +					queue_work(system_bh_wq, &dev-
>>bh_work);
>>  		}
>>  	}
>>
>> @@ -1325,7 +1325,7 @@ void usbnet_tx_timeout (struct net_device *net,
>unsigned int txqueue)
>>  	struct usbnet		*dev =3D netdev_priv(net);
>>
>>  	unlink_urbs (dev, &dev->txq);
>> -	tasklet_schedule (&dev->bh);
>> +	queue_work(system_bh_wq, &dev->bh_work);
>>  	/* this needs to be handled individually because the generic layer
>>  	 * doesn't know what is sufficient and could not restore private
>>  	 * information if a remedy of an unconditional reset were used.
>> @@ -1547,7 +1547,7 @@ static inline void usb_free_skb(struct sk_buff
>> *skb)
>>
>>
>> /*--------------------------------------------------------------------
>> -----*/
>>
>> -// tasklet (work deferred from completions, in_irq) or timer
>> +// workqueue (work deferred from completions, in_irq) or timer
>>
>>  static void usbnet_bh (struct timer_list *t)  { @@ -1601,16 +1601,16
>> @@ static void usbnet_bh (struct timer_list *t)
>>  					  "rxqlen %d --> %d\n",
>>  					  temp, dev->rxq.qlen);
>>  			if (dev->rxq.qlen < RX_QLEN(dev))
>> -				tasklet_schedule (&dev->bh);
>> +				queue_work(system_bh_wq, &dev->bh_work);
>>  		}
>>  		if (dev->txq.qlen < TX_QLEN (dev))
>>  			netif_wake_queue (dev->net);
>>  	}
>>  }
>>
>> -static void usbnet_bh_tasklet(struct tasklet_struct *t)
>> +static void usbnet_bh_workqueue(struct work_struct *work)
>>  {
>> -	struct usbnet *dev =3D from_tasklet(dev, t, bh);
>> +	struct usbnet *dev =3D from_work(dev, work, bh_work);
>>
>>  	usbnet_bh(&dev->delay);
>>  }
>> @@ -1742,7 +1742,7 @@ usbnet_probe (struct usb_interface *udev, const
>struct usb_device_id *prod)
>>  	skb_queue_head_init (&dev->txq);
>>  	skb_queue_head_init (&dev->done);
>>  	skb_queue_head_init(&dev->rxq_pause);
>> -	tasklet_setup(&dev->bh, usbnet_bh_tasklet);
>> +	INIT_WORK (&dev->bh_work, usbnet_bh_workqueue);
>
>WARNING: space prohibited between function name and open parenthesis '('
>#160: FILE: drivers/net/usb/usbnet.c:1745:
>+	INIT_WORK (&dev->bh_work, usbnet_bh_workqueue);
>
>total: 0 errors, 1 warnings, 0 checks, 144 lines checked
>
>checkpatch warning here please fix this minor thing and resubmit.

Indeed, there are more spaces. Fixed and repost v2 again.
Thank you for your care and patience again.
Jun Miao

>
>Thanks,
>Sundeep
>
>>  	INIT_WORK (&dev->kevent, usbnet_deferred_kevent);
>>  	init_usb_anchor(&dev->deferred);
>>  	timer_setup(&dev->delay, usbnet_bh, 0); @@ -1971,7 +1971,7 @@ int
>> usbnet_resume (struct usb_interface *intf)
>>
>>  			if (!(dev->txq.qlen >=3D TX_QLEN(dev)))
>>  				netif_tx_wake_all_queues(dev->net);
>> -			tasklet_schedule (&dev->bh);
>> +			queue_work(system_bh_wq, &dev->bh_work);
>>  		}
>>  	}
>>
>> diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
>> index 0b9f1e598e3a..208682f77179 100644
>> --- a/include/linux/usb/usbnet.h
>> +++ b/include/linux/usb/usbnet.h
>> @@ -58,7 +58,7 @@ struct usbnet {
>>  	unsigned		interrupt_count;
>>  	struct mutex		interrupt_mutex;
>>  	struct usb_anchor	deferred;
>> -	struct tasklet_struct	bh;
>> +	struct work_struct	bh_work;
>>
>>  	struct work_struct	kevent;
>>  	unsigned long		flags;
>> --
>> 2.32.0
>>

