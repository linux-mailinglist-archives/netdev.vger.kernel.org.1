Return-Path: <netdev+bounces-165440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F8CA320A3
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 09:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A406163AF1
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 08:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA42D204C18;
	Wed, 12 Feb 2025 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpL0nlxz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E1204C28
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347771; cv=fail; b=rz68sWCrbhshkAntxuUIkuP0JMcTZF/4Qliiw2R+Gh1TynmkIWP28s4r9qga9UAzvTbJyHFeNqeWT5rgeJjm7cvqOLeUI1GK1XEGsQpfK8lZ3BSwaTYr75LhGPNGiQMvcoWpD7f25IDA4i9qzEczhlmZIr29Z4gU4jVvxEhs4E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347771; c=relaxed/simple;
	bh=WRgGzmkPlD0uSJxlQFoH/lxB9HbV/67I9nwh5iHWjsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LtUZ9Agwf44CvVbywWWvU4eG0Ny5+hRQj3cUgeirFL2Qx3jWmlXex2P6RpzW6VsxY52jXRiaWpOQA8x0AuBcOiVTzrpXlsMA7aBZ0uFn3RjhgSjl6IdJC7GQfdi1wMuyrGxEVOKzlv9Qukd3YUkORGxoAHUU3pa2XTRu5APzEWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpL0nlxz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739347770; x=1770883770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WRgGzmkPlD0uSJxlQFoH/lxB9HbV/67I9nwh5iHWjsU=;
  b=FpL0nlxz2NpMAMMXAmQ33KXmamOUBmD3oyGxx/Z2EW29lppxNihVYa0h
   4Vlys0IKU9b1yJSfOOvP7R7d4u+AKtGVcNJvX6SA/b8xmWUHyRVTLeHuy
   V8KQDNligAscWZPh3TvuCeH+uCVBhzsx4aWGTqkVYr9mPM5v0FrqkMD1f
   irtyqtZHl35DHU7QtyTvvyMhnOGl8UN8bngxuZq3fIxrj8jZkp7lYFmMq
   spahc8Nb7CF+xrAaZ5v4Bzua5+SLC6vYMyVhqJC5Fm8rc47R19yrpovTr
   jH1JfZ4TNR9arfG5+0cKYqiKkeOg3M/ucPBvrwGAkTJMBRxCgVbowo5pO
   A==;
X-CSE-ConnectionGUID: m0vmg6rBQO2tWZmlUtve8g==
X-CSE-MsgGUID: Q3l/O4FVQeOw//8CScPkvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51385589"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="51385589"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:09:20 -0800
X-CSE-ConnectionGUID: s+oWBghqTDuQVSU0AsfwvQ==
X-CSE-MsgGUID: zaYkrHnSS/+gwNkRO7aJlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149942130"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 00:09:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 00:09:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 00:09:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 00:09:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVRW8zWMjIm63dUBZ/RlE2MIYcr6CM1jmFIsgRqY+cseCMHk89KnunGa53Xh+Eo84xpaGdSgZw9ERFH9oaSm7DEEhtlAWi87LwRB0tWl+mVortyG+AzIrFu71gw355bST6nULMXMhgEeVRi0Q3mSYbG1I9AgmSVYbnPZ1Jb2SB3UecnNoFEIhZoP08dSxRIA+/xHug3r5SzyLnLNc5iFIm4uWHKcjeSjNfqu5Jlhc4wydcUBOUMLdHMq6sP6Y33gQYqCE+hIAVRC8utI5nYfu8iUTqNF/6XoJqWgosyAL+X+vGT19hf4nl9oft7PoY6m+VHUrqg3jLXFOlF7UxM9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC5AC/G3FhOSaDwvsmzq8FIsUCdK3cDE8i3NUggHUII=;
 b=T5d0arwKawFHlxnCPkYTgWlpuQVRJmK1BhFsmdbxL2VzM/d7lw8mCfvskjY7NyiDXHROUrkkqiy7lDAb4jCwMDAtkNpr4R8EKXlLCEpsLtmzCsHKLvSfuYi6OO+bknDrS4KmZxkpTRCb7uzr9kw7XSYPf5s3vRSvlX2NXDFPC40ATVVJaCMwH+raEvLF/c0csrMNy7eIXdVJRa85WZfGF37ciJKB3c3qfCpy3rIfunhfKjXCzB1fawIzZRGUHpkfQeSc6yFrOZGVWiP64gWOu3NaAMhemAFFRa9mEXrX0sxf39DbYl6GVsQtRdJvsszb1AXLg/l1XWAkzBuPcRhugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by BL4PR11MB8823.namprd11.prod.outlook.com (2603:10b6:208:5a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 08:09:14 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 08:09:13 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ixgbe: fix media cage present
 detection for E610 device
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ixgbe: fix media cage present
 detection for E610 device
Thread-Index: AQHbeKqcFZFcBJpCl0quyYWI44c4hLNDWSGg
Date: Wed, 12 Feb 2025 08:09:13 +0000
Message-ID: <PH8PR11MB7965AA765C7056475192B32EF7FC2@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20250206151920.20292-1-piotr.kwapulinski@intel.com>
In-Reply-To: <20250206151920.20292-1-piotr.kwapulinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|BL4PR11MB8823:EE_
x-ms-office365-filtering-correlation-id: 853e5cb3-020b-465e-54ed-08dd4b3c89ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?nki6aIUB+9MvNhiW6uM5jsuBENkezO2KXIdq7X9UpLnszm3Q9/TRs5U7PWyu?=
 =?us-ascii?Q?yOxgCdZbNdxckXCZmLrg0+Xe/yEH5wvEwVGH1qrbk/obmZt1GOvKT8m4ogDs?=
 =?us-ascii?Q?4IgMfRtLeVl7c1YUyibkC8QySciruARQP17ZlAVm1RBR4C0bKrGYTHFtJrlo?=
 =?us-ascii?Q?KEtisrA62KsGSQqqIX1jSuFVvKugXcQUj32bd6cZlhQ9HS3EXwnX5z/NyxcL?=
 =?us-ascii?Q?iDBTO+DVtzsUPQjxRLnsBwb2LN9FSMgnfvJszEVXSvflZf2TQ0axuJIDfWV7?=
 =?us-ascii?Q?ZtujcE/9seC1MHnQE5MRTzb/o9cXfqkdZ7mNlSjv2+7Vsz6NMSElPnBzi4Wi?=
 =?us-ascii?Q?349AIFM1qHLNUgjXX0CpFBmHpUvwt8bS0/hGXYKmuG77adZ8BUizAdjywKjV?=
 =?us-ascii?Q?7ZrSXqR1OXeScRjUsEDu2pUeUaiTha500Ft31Ar4qIVTYVJnd7d8roaNkDzp?=
 =?us-ascii?Q?9R3+XEouci8/r3JBQMR88JSxz3Pva1GeFXfe/ENRM6VZGFI/RDwkAs6zFfiz?=
 =?us-ascii?Q?Apu+x4hpPXZGZwRXO7/PAxKR0pD5IM9MVas5/D8zHrKN9t6/YAJGbPWL0lCQ?=
 =?us-ascii?Q?A4U5pTiI+bS5+mKfJoXR8oVn8IB7z+f38OSYqrqIgLhAJCaHebZtsxqB1HEr?=
 =?us-ascii?Q?eC6s6m32MRpknLJuoJEPxla0CEiVJ2V1NZWhfRBQzXxr662AOJcZQFvov0SW?=
 =?us-ascii?Q?IKGVXPzVd9dIN29oypcEXrp2RsFaDYjFcEo/349YKYcGCsm1vnkYrwgeQxt2?=
 =?us-ascii?Q?X+yBEIeu8kcu2N0kumFCSrQgIi6Fq64VL0URPgD1TRZcb0nhUb7XaDP9QzFR?=
 =?us-ascii?Q?VX2rB9J575q1iUFLeI3z/YUgdxx5/aj/oOV7Qv8wvNS8sa0DlaZ0w8so6scH?=
 =?us-ascii?Q?aLRP2Fzf68ol3+LM7XMhFiRtb4q4VXV7NnLWBpU+/fUHkx7rtpIsAYVBjKMt?=
 =?us-ascii?Q?CVzQoKqYc7XrZBlKZF3Z8SdOZtdO3soWek9blXsPv6g9KMphIasoor9sO1/J?=
 =?us-ascii?Q?6Tjr07jjoEFcRgSIqMhoX38eiGCj2LMNSV5zN+wBijM+alqbkmgY1fjLtFRo?=
 =?us-ascii?Q?60lLIa+pGdEu09Rbvy2PNF2sW96TmI46EZbHqgp9SDHwi1deV7oq+jc6DXkY?=
 =?us-ascii?Q?vF1T2UJkOSYZnrGTrDr/q9xfctQQ0/m3MDd2/u4Wiy5dtWUwU97Y9ma/gUAs?=
 =?us-ascii?Q?20Hq30/HPNXxaB546C0YS8T3jiSub56f7NiroiakYmn3Pxn0zNrLZKr6wXli?=
 =?us-ascii?Q?qDqV3j5sgy6k5jKLtnEkSmz91hIYOMHGPHGryXs2xsV85HwBNl6zOwIhOwhl?=
 =?us-ascii?Q?z0NuR2TFP7g2n/rWydMfm0PfwK01nJJaqhzhrc2I6uGyCH/tm1T3foIqNhM7?=
 =?us-ascii?Q?92rpVSZYAgwlhNUhDHukQ8Ol7yKXG8eRStC2tq9SCF4b33iAcRtLzpNWyhJj?=
 =?us-ascii?Q?VhCaQEoGbmne9sKNEi9Rzz1IMvmPKfLk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vzsc8G1K2MAuSFUJ7NhXJiWiJ3yPd9Ii4h3tV9+YLnbqQWlbRR+CCgZYrV2n?=
 =?us-ascii?Q?MQBavzdniBgYf2nc+ALyMpHM8DzKeqV1Tm30tgztwsTZ+fpNpGoOA2IEBuiP?=
 =?us-ascii?Q?ZHNY8Cyo4OS0GPGOVnSvMdbATiWcl5a2rLd0EoRppbunGQXQLnMVzyt6+dC0?=
 =?us-ascii?Q?GUUPU/LB+RPsVWAZDrW9m3/j1rP3F6LX9hxwk7jFgv8Fw8usbX36EaVoMk2j?=
 =?us-ascii?Q?tkt9CG+cKOyvfQe6n1Vxu7H+hH19l1nxDyWMWhI6CoKE/Br3joviG8fILO3U?=
 =?us-ascii?Q?/nVKQqUZd/mYKCckdWX3bN2VbzxC3AABgsCJCiw+lDJhh1MaxZvLLY1ABDMl?=
 =?us-ascii?Q?izNdYseru5iLZ/W46N8IjkkpJU5y2Ha2q7a90MRhLCzCuhqGQPJ4nl6tSKgn?=
 =?us-ascii?Q?GWMEQPIHSmfLQRjTJGP6jwmyNSbGZFwBZCDx4KGrugpAAJBmyRCZL3KP3G8B?=
 =?us-ascii?Q?KAnSI/f1rSB7xkM352ZkAg0/SPyW7MtDFNnChpD+OtXAsYsJl+huFuwdJmcz?=
 =?us-ascii?Q?Hby57tCaFGqWMuJlX/k1mX9/krvfv6FyjacPUVR9mctHJHMq44MzmY/JmLYh?=
 =?us-ascii?Q?3F1JpC+QhA8xHBaOjfuRMkQDRmPqlbYW04o+AfOCODCsAiksRlXrJHff9tAI?=
 =?us-ascii?Q?b9gt+jlzM9vJNGL0aeRKMUhYVpPWaVIe8E2pPwOeZS9lV1snX7qHvPC8Pf7T?=
 =?us-ascii?Q?CFrXhY4lg6nQtvWZRe11080yLrfS0W1q5A4kKpKBi1o3JAmOuo9KiGYPir+/?=
 =?us-ascii?Q?kyapevAcWedc0up00dgpewoJmJYzVfmZSyeusWvinwDInScbTKU07J6cGEFU?=
 =?us-ascii?Q?lwyViCIYkUaPbv3WVgaEwLrosc34lK4qrT2DC8IZIekbT1VSkLjOlyp9k40f?=
 =?us-ascii?Q?+ARlYSxH3CTfmTyd//yP4f+89S94g8M5z2CFLcyVK7511OOIGyyAMsCzlV4S?=
 =?us-ascii?Q?Sqir63mLy8Z4Clu2mYtsDFmv2fane4t+F66o6q2AmMOFy0is5JmTDgpE3oE+?=
 =?us-ascii?Q?5vnYwSyjHo/0HzsTMurbioPgEY8f33pbO5mJ0GRH3G+LrU+2eGESyeUehA71?=
 =?us-ascii?Q?HNFOKgnfR7g50Y05kZ8lttTtlrSDMPlnqcFSJ61qwqVNP2gGOTgkdBOYHWrn?=
 =?us-ascii?Q?seRvaLnLqIXu3nffym8M0zDOBNRu+xhs8Qrav0BOy3go5nUYxLgXQNGI7VXH?=
 =?us-ascii?Q?O2FRuy9J5TZine+ojLzgbX+3Ymb29jTI3DIKMSnPqO2NDryDk71Z0qraaMk3?=
 =?us-ascii?Q?VqzewnvLZRhYOsn/dT2dDTseuernP+nSoVqqcrYP8EUqjr+UoJZNS0ckrdNv?=
 =?us-ascii?Q?sOTrVvqUoQ/5ZS7G0YYVLM+WClzPEc3E6qQStE1P4TIzWbqdvn1J/sFTx6o0?=
 =?us-ascii?Q?Aoxz4FYwyVADer3PD/TAUIHPpYRCqkaiPk2VZD1TPLJREdJvvzqS0wo70k89?=
 =?us-ascii?Q?nDrm8FQZKJK0xqzMPMbIv6AddPTkP88YYb85xEARuCW3p5Bby8kChAgPdN/G?=
 =?us-ascii?Q?DtumjLKAP5GRhrdim32ArY7jaEunB0XLG3KZ8ibHWfrXHSoP/WomDoSe+wxB?=
 =?us-ascii?Q?IrWcU13bjlbfbVXf10I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853e5cb3-020b-465e-54ed-08dd4b3c89ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 08:09:13.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xS7TYERPZQ04LajiHs0+hyNIRd6vONGPp4SBwQZQ1evT0PsaVReuTNZ6azcssll0ttDsv0Wn0jsHUirCxPHsPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8823
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Piotr Kwapulinski
> Sent: Thursday, February 6, 2025 8:49 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; Dan Carpenter <dan.carpenter@linaro.org>;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ixgbe: fix media cage present
> detection for E610 device
>=20
> The commit 23c0e5a16bcc ("ixgbe: Add link management support for E610
> device") introduced incorrect checking of media cage presence for E610
> device. Fix it.
>=20
> Fixes: 23c0e5a16bcc ("ixgbe: Add link management support for E610 device"=
)
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/e7d73b32-f12a-49d1-8b60-
> 1ef83359ec13@stanley.mountain/
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Tested-by: Bharath R <bharath.r@intel.com>

