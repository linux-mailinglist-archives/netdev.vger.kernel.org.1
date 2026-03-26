Return-Path: <netdev+bounces-271895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E1NJPTexGnz4gQAu9opvQ
	(envelope-from <netdev+bounces-271895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:23:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D2330610
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8B573018402
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC5C3491E1;
	Thu, 26 Mar 2026 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q80YLur8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD25347BAF
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509808; cv=fail; b=doOibFCmCFvXvv7m2DrDy1jHYGcI0FQUbjt+1Czm11GfCsjRWW48szD0BkUgaHyW8XTYmtOOx+OjbiqntvcuXaYXTwVXB6sgMCnn4+HVMT5hi/hA2GJ7J4SAFAEbPVJ5cWcC7adUZpsBjsDSQqroVuTho/V02M/paRlVwsolpHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509808; c=relaxed/simple;
	bh=EFFUfzyeskG2Jl2TqmkIjj+xct54G/YIvRRlpqE3pbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mzFT3TH0Jag98BVVAZcwjIOAk4EbJfdTSbqZ5DZFq/hY4N7Cc+/HobgTHcFrlKaSSCDiBM7/YOZcNBWI0+K+a4KzGJfZn1AmNE1TPyu4JuGD5bjOLRnArl5CiM+I3HjUBMXsyAK2Sw8bT3SaXPj2RPOTHpFtLBZ7ybvs/2WPyXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q80YLur8; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774509803; x=1806045803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EFFUfzyeskG2Jl2TqmkIjj+xct54G/YIvRRlpqE3pbw=;
  b=Q80YLur8w0hT58PcOX3UzYhiS0+fAYQr2Qt/Kzb4tUn79BmJ3YjAIaf+
   UAn0D7UknE0iMreAjukDtbZ1/4l54SgonwLwsE1o5vsIT5UfGPhn/Zylz
   g40whE86faFLsM9BvzI5TyFDxltYIMW4pCic+LiNyYNKyTd6iwZ9G5ySw
   sPFPlTB/em+rCABNeIbfthU3nItOnmj7760/CivCMOeC0KTTtyoTyj9vV
   0hGuXwm/dzIOmdQdF3uvgaNka84gq8REtwzxIV9ljYEag/+K7JYCYdSO/
   o8kfwUx6oeNit2LCgVEzBNRdOd02XA5as4Aop34mzXUgbA0hLe4m64kfZ
   A==;
X-CSE-ConnectionGUID: +K8KiqQcSGm78VA/GVRyKQ==
X-CSE-MsgGUID: PydHs0WLS8umOil9ga7DVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86637695"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86637695"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 00:23:22 -0700
X-CSE-ConnectionGUID: TGwwyLTxSZmZIdcWN3Bi9g==
X-CSE-MsgGUID: Y+P3IvTaSrqftrDwVRGL8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="220081554"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 00:23:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 00:23:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 00:23:20 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 00:23:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWvoCIUqTji2OBx5dt5xCZtXgSM5z01CnQJIatTZ8olNsYxLS34C0qFjtWp6NHZ36jjJP6DNvwTyHIFytM4RyCO8cAcluadFg/iKk4Sf4/5IW2Tnt9GF4k1jkS1T9ZbQnQi9Yba9/Rbf3PMAk8soG+0N30Cr5j8oNjqBxLjQVQ4uB2xo+6E5+XkAwun+TlBB1dLq6wkclzsxjRSMz/V8s7eRHrT5TFAzcDb9oI9ceQjn+vcyONo/Kt+zJG76s2vFovpBh/hEDq6JEbV2V/xxT8lgFmZirf0GZ9DURVlvE+DHrrhjEBpDB2O0jP9FmeLchvgr95UMxybVRP7DcBrLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLZchHQzcbPRd6Lav26WKSLFhf9C/T0+DO3W7DCJzCk=;
 b=CCAMO0feDcDrOuTVlLyDgfG3yBOh96yUMXOHjQk/i8jq0BDUjLRvO3MZ+Qkh3BccE65ydmAKixx33NPPPOv5fuF+V8EXmBCRpHs59QBx3CEfso82chbRNBVW1IEE9qjp+3LlZoIoXQm5O8/4cs738FPHAfDeZnJnU23fmO3K5QOsJ/QWF5C2i2ITujpaB9lfR9ny3hAIFCrAq8AGnsLypCZKJnln6qk5BiyPXIOuj/QjnwZeTJ41tCGcTvdqhJkr/vkjJhoa8yaJeR8y0y+g4vLCXfjyQMzpBI6b5R7vEJXMn6nj1Yf2KyCcrY6Gj+vPtXzp+BNfvt1Gu/lxrLCpVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM3PPF341F90799.namprd11.prod.outlook.com (2603:10b6:f:fc00::f19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 26 Mar
 2026 07:23:17 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Thu, 26 Mar 2026
 07:23:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shannon Nelson
	<sln@onemain.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] i40e: don't advertise
 IFF_SUPP_NOFCS
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] i40e: don't advertise
 IFF_SUPP_NOFCS
Thread-Index: AQHcvJk66RGiez+zKUixZnygSTb52bXAaYRg
Date: Thu, 26 Mar 2026 07:23:17 +0000
Message-ID: <IA3PR11MB898686D49226320C5A0C2913E556A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260325205054.109822-1-kohei@enjuk.jp>
In-Reply-To: <20260325205054.109822-1-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM3PPF341F90799:EE_
x-ms-office365-filtering-correlation-id: e3a697f4-64f1-49f7-a548-08de8b088cec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: RYTtjedKkm27okvSiuTc9lorCIR/MzsGpkvm6c7X/CSMn2evOz/itQISzPGCkP8vBt4X5tkQBT4NvJfgun0rOPpvxjEkZ1s8KTfGBSVmL8O6mjmSyB/kynVb6rKvB0yanUcONYL/kf+8flctJAw+Qe51RIHgz+iz0Q8U3gs10rYQvBP5HWDL0IA16Osg2+8cnbc5gZFAbKBferDE9mKzy4o+LGjI6RejahGN7/JNwEAn21N0zCfjHMdgj9UlLT+OOn2vZ0u5CzLbzeh4BB1y7TMZfT/uyKLk2B+rt6knB0xsivz5XFfUzFBieWpyQn6ldRYXWk1id6WaXlJ+07qp3ljCEYeXtYoXzNkSBN7NpvnkefilK4JdnC/GgefCInAmFzv3oQXKjHVVA1CajRauDfQxzsjvh6WAc4j17/ph7d0u/T6+pFuLYWCKh9fF9nxxerBNpLQmgMhdt4jeHNZ/tMMmHHhk/teb9ihJIQywwtYT9Brt6hzJC28aKJr1nedIddZViVpxBZJNS6rVQC55yCUFxJ9gdXuov5TUg6gBO+LX/a/ncfvg9b96SJx5AVt/Duth7nFYqb/v8vOwtn7BqnXxbCmHpxLfYFXlwvgZx3J9Y6zKO4SkSANwK1MLTuntRiS/U2jOi75iibIMGK1QxiUBrxhQnFqqjrUPoQexy/TkzKxoh9jbcvS0HLGhHRuVamiTSbSKP78pG8U7XzU1cW/WkSJ7ttOdzNMii2VdKe/ZYprBDzn4nBiUUj2LSjHhjo62NrX6yJ5/c+skwZiuECGKASPdzPtQ1q0Sxmg3Dq4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gKv+Fx/Zigcr89de08cE5CCNBdcWb4PSCmhGmoif5fkD9TcQ4oR+w9hMWMSf?=
 =?us-ascii?Q?HCDxRZgbOXIx2W/GuwvSOhG3KwMOviJ2bL85am4FgtkzzJ0bmne8gjhrsKs6?=
 =?us-ascii?Q?vV82CYGqRdqq0G2GXP1Gyv4/NxaHk/YmDFnJKjPE2IzDqYKB0nLMHMENAXYa?=
 =?us-ascii?Q?/SaHcNExxcLvRgkDCuxtIIUl2O04vvVoa1fbugZ2FId3OWDvVGtPMvYIDnbq?=
 =?us-ascii?Q?jVjEA7qjl1QL7X9E4XISg/23x/a3WuTJujie8i21ZgcKACht2ph6JjgfLKzE?=
 =?us-ascii?Q?0yANMsDR7zdKYguil/6VDef+X5269FTJHbIPlQ1haBWMsM8r6DRsvF/Ifcsl?=
 =?us-ascii?Q?hjOHCY8MzU1Qnq2q7PBjh/FrwKM3K620T9SBNg/IlRCMweNGfs93seH0ESav?=
 =?us-ascii?Q?ikRjIDh08r33IYE+1VsOZqqylkXqOb7jAG2xleGl2T9ymGwMX234RvVEMXUV?=
 =?us-ascii?Q?qCJFzUsJrROAJ7s0OHrM2xmpXjRevCWA9hQ4WQKmH6VBRDb+9J/bpjv3XioS?=
 =?us-ascii?Q?LJQju1KXlf8kSvOhk7PQeMc6MyNAuZ/b6NOeXLejW8IF716h+F5PZGHXKHpD?=
 =?us-ascii?Q?JyTTe4p/7SKcIihmi+hkpWS40xaC9yTNjgZROPhqISP618uJddAC8YkA505P?=
 =?us-ascii?Q?xqUmkj3KT0F7IdzjidsNKCeaI2Wvm31nw0VstxOXxeEsngRWb0RcPKM84rZp?=
 =?us-ascii?Q?FoCk54/lfyd9Yn1ppg7N/WNPaZmB66/WcCUiIDoZ/Jjh2HghtItrHajKkt0o?=
 =?us-ascii?Q?EM5ToLhLB2FGrO+qHXPNINYGmCnWT2zYSdNSS45jG8AHe+JMN9FSWa/NljXH?=
 =?us-ascii?Q?Qj7VWBWP6FteItx+3Fp/ZLsJHXi/LEP1KXbMSa73uoKZuqy1kuDNCKS7cKAx?=
 =?us-ascii?Q?ML+gYexpQWy3QhCauuYD1WxKAycUj5EaZgpDhHmne5y3a1aA8Y75+1h4MQ4G?=
 =?us-ascii?Q?zFZ4CC+vT7Ecd/XexTpNniWTgoJLV3OgItyLrPOakwaKbFEJCRg7sq+e+/BQ?=
 =?us-ascii?Q?1CJq+QbJVJsd3mxKILOY0B8jEA5Nl6iYHOfb5acGjSk1iQ+rAMmfZFREQdGI?=
 =?us-ascii?Q?oqV/g+MlUhN396GCv/vTLWO4piRyQjuWVjKcSPxBBv/ji7oIPP8PoC9tpe+x?=
 =?us-ascii?Q?tXw/5kJakIuRkAoNHUocNSbNQ52GTE1DG+mfyAb7/NT3GcGtxQSvS0sC3o9P?=
 =?us-ascii?Q?fXYXJDSUTZEDBAiqCIeKZlMjzgiHGTM1/tY5wn56zmpztPwkPieFX5i/l/hh?=
 =?us-ascii?Q?b+VU3icNk8+0zqZCzSSh3zeF+OSt4j7sUwtqxCLxBmYvdgdNrW6ARABbRGm2?=
 =?us-ascii?Q?1560zjUyicre+SG0zcYte4fAcZqWIJGbCkq0c7D3B/a0hwutzfblz0BZJgQQ?=
 =?us-ascii?Q?GpNT36GgEIG21IZBAx+SaEmif86qGp34E/2V0SMBmgPfL07c0LS6f8LRrPLy?=
 =?us-ascii?Q?aDZ0XtXYYDswrP/NiBNVxn58SiPRZ2wlCebNrImgUuKb7CI+6izlNRVdUp8N?=
 =?us-ascii?Q?2y4SOLnppffX6y7tbreZowWV1FGYQVdPPEwtuwbwx+6Ky1EltnidacG/PPJJ?=
 =?us-ascii?Q?7YPwdzxbpWW3aD70YhWH3R/wB8chOG3Zu0aiF2Cf31S/mQwAYGOcPzI3O2bQ?=
 =?us-ascii?Q?whiNj1r1RhkigqDpFPAGxMW0ioJr/a5odZMtmGLqWNm8q3D5FY6/QiXB8HZc?=
 =?us-ascii?Q?wzdc5Ldt+ng6ia88+oqA0N6Fz4sDBTx9o8PpRHQTeRu1bP1U4lxFHyMCf6LC?=
 =?us-ascii?Q?d6YQNTDYwsbWAXZ9PHw/RJRaRvE/T9Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mxFbiflVgyFCVR5isyK2tnTslquWV88n96pMrEqoRSkUZhjFYsOj4eDeKDVHbZmIM/AV46wM/3kCv03EUbkYRIosqv9K4DUdhJp+OmoouPSEo9XBVDneEa75xhFuWipdTMX04efixAyM7rjMQp1MYcUA95vhxIhvJqPaRR/HOD0bky/feNJJw4eM0nx/0K977Yj7khjBwZqhYPOEEuAgC4Buw/B5E8MGP9J8fsJVxtRv12NR55W/haQfGaJSbbZZi+/jnkIOSz4++/MfIig1aiVRnaJS+Mhus1Z04X/2pzp/FyacspYAqyRE4Aw+WqzLet5nmImVO8JgIHkLuFR9kg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a697f4-64f1-49f7-a548-08de8b088cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 07:23:17.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2p8+xIecrXVpeP0VrieSy8ZpRTbQ6i4gGDe3I5uV4XPO1qPP1dYXkzFOmEFjWSfBlFNov0wF6QsqmRPowrOSW24+urfbdrTytK/JBtR3QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF341F90799
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271895-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,onemain.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F38D2330610
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Wednesday, March 25, 2026 9:50 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Shannon Nelson <sln@onemain.com>; Jesse
> Brandeburg <jesse.brandeburg@intel.com>; kohei.enju@gmail.com; Kohei
> Enju <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] i40e: don't advertise
> IFF_SUPP_NOFCS
>=20
> i40e advertises IFF_SUPP_NOFCS, allowing users to use the SO_NOFCS
> socket option. However, this option is silently ignored, as the driver
> does not check skb->no_fcs, and always enables FCS insertion offload.
>=20
> Fix this by removing the advertisement of IFF_SUPP_NOFCS.
>=20
> This behavior can be reproduced with a simple AF_PACKET socket:
>=20
>   import socket
>   s =3D socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
>   s.setsockopt(socket.SOL_SOCKET, 43, 1) # SO_NOFCS
>   s.bind(("eth0", 0))
>   s.send(b'\xff' * 64)
>=20
> Previously, send() succeeds but the driver ignores SO_NOFCS.
> With this change, send() fails with -EPROTONOSUPPORT, as expected.
>=20
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 3749f32ef95a..a3c52aa6255b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -13831,7 +13831,6 @@ static int i40e_config_netdev(struct i40e_vsi
> *vsi)
>  	netdev->neigh_priv_len =3D sizeof(u32) * 4;
>=20
>  	netdev->priv_flags |=3D IFF_UNICAST_FLT;
> -	netdev->priv_flags |=3D IFF_SUPP_NOFCS;
>  	/* Setup netdev TC information */
>  	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);
>=20
> --
> 2.51.0

I'd recommend to add Cc: stable@vger.kernel.org

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

