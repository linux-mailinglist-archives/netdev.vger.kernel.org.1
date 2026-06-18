Return-Path: <netdev+bounces-300362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LXdhK2ayM2q1FAYAu9opvQ
	(envelope-from <netdev+bounces-300362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:55:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5133A69EA11
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:55:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=EBQJzYcC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300362-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300362-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67139303D1CA
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8083BB115;
	Thu, 18 Jun 2026 08:49:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E723B71BD;
	Thu, 18 Jun 2026 08:49:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772558; cv=fail; b=U57e4cr4LQmbzsIK1aCrgS7c+Ewolpha50Y1u9St9Z1+3S2WbVVBWfGGiGu4dN5nfsHdH30tiBC4m9m++yUaOOaZr61A+gHADnVvJoD5/UDJmY/HBT29mCeqwdX0WZWiAcaO8rrFPdTYAoOVbPcKSBjHG//uQMiih6DnLYmK1sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772558; c=relaxed/simple;
	bh=0cPqICRiiNmh/9W/Ipe+XzVStcp82T73TEZVF7uqp/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I/uJxR10Jz/NcoRAODklT0cnW+ERIhhSdiCA02Nk9iMKdP1W+5H3YTYzfYnqnW6Yn653V3slvZNQpzHI/q4x67BdoFS2DnVbGOb68LiGK14uHzQhfZ9m2AnSIaBqMlT/wqAH1wr13NwPJvl6oXB7PNZ02nPYFpvqP7JN9IA2U4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBQJzYcC; arc=fail smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781772556; x=1813308556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0cPqICRiiNmh/9W/Ipe+XzVStcp82T73TEZVF7uqp/4=;
  b=EBQJzYcCKm8klSnumnH/4NstzeHafBJcu2TFSMTay2Bezwn3yeFZGIcL
   czPXM1ri4zP8kvd3bOwdL7Lc5cUt0gd+gozVnG/TaBvIrIAHZqRgH4zK5
   EGO0b9Fgiib9p8ukJaQv5vf0joeHa1op+bcm7Cv+jFwVSB99wM5JUWJcM
   SHFUu0lgdtuy6mLyCUsWCjPJWXF11HSJagwbTPVCRysRD/ykm/GVEB1mi
   zwVF6Dff5zUWIk2G0wVE6bD7RR4DMk0b06XoUBsr+xdAElWTuOXW+BFVt
   v/iQmkqKxDypj2cHvkFLahtT1K598xVxJMJW3R+BODKX3220J4skkk43z
   w==;
X-CSE-ConnectionGUID: XklGeBekSiumorY9IT5yKw==
X-CSE-MsgGUID: 0xyFPPT1TwOnMxhxoUTK4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82496492"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82496492"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:49:16 -0700
X-CSE-ConnectionGUID: UwP0QthHRZ+0vZGDDNKSJQ==
X-CSE-MsgGUID: PmSKSbzFQ7uXE7WcCfTaWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="243950586"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:49:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 01:49:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 01:49:14 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 01:49:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3hUsFrdHnQdfQgE2/zfMYHKPbAF3U9XlF0kyu3Qwjporjp5cDSNi1kxJEA+ww4O68zGzyNWgG7IgCjMiCoihBF3i3hcbKHzZ8d0Dk2oqVt84Rc5slWWdDoCiPshx0PPxcF/jfH08OF7BzvfWWC0ZsXXS0ptqIvezszRLvtFx1WOMAat1f+gAK45c1t63ymt0Ys3yhNWRipxDQmCzT8IMN6720AtTrUIWsWWid0b3rAU8CQdTyPY/gmeEtckjol3eik/ShrcXCM6PQkthHoGZNdYPG06IY9GRB9RpDtThWpC3KA7+KjjkrGvE3u11hCW9R8AlbkH2inKtYWXDSJLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKkwFeq7c0vyLX5Xkhk6uP/1SnROqAVvdbjJiajAIEc=;
 b=stAB8YMVX4Mc8jtmhYWTPCy+rvW0wxsOvZC7mDFBqEkdAouhBhcwUS5K4NHc2K9AxnSTKW+7TvCWA+lsm32ARqR/QVTkNpIH530DDpmYpeoN+tV6BOlwjIZ15j77iunueEGn1lZYIkghZK26i1y6Pl7P0Rr+MiocU3Exsmx3EvQexWCd68YF2jLmQytlNjh5oMn3AH1eFDDEC34DNDOsRvElbQN6SMzyR4RIHNyEV1xS8aIoSEWdMwCrVXWVU2/HHuJ/lghEYXcVH1JMFv3Zo69UERN6a0Ig9fDq58I3H7iTPhx6TKqcCeI+QBZWdA6ec6fFGTwNqLUtpYPbWxCGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by DSVPR11MB9693.namprd11.prod.outlook.com (2603:10b6:8:34c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 08:49:12 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240%4]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 08:49:12 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: "kao, acelan" <acelan.kao@canonical.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 1/2] igc: Wait for MAC passthrough after
 reset
Thread-Topic: [Intel-wired-lan] [PATCH 1/2] igc: Wait for MAC passthrough
 after reset
Thread-Index: AQHc/vTfpt9iKM1uJ0+3cl1nceMxwrZD/sjw
Date: Thu, 18 Jun 2026 08:49:12 +0000
Message-ID: <PH7PR11MB5983AA3B3EEC64AA58623CBFF3E32@PH7PR11MB5983.namprd11.prod.outlook.com>
References: <20260618073324.1843310-1-acelan.kao@canonical.com>
In-Reply-To: <20260618073324.1843310-1-acelan.kao@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|DSVPR11MB9693:EE_
x-ms-office365-filtering-correlation-id: 737ba657-846a-4669-9fe9-08decd16786a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: W2Ue6YIAsdnp0lTwExQAIXzPH2RQvdEqaxvVmyynxg1o/u3XXFdDLl67yHkhVf6EvZaPz7T96lA79AQCxKOWYshXzX2oOMIrvODi0qGrEQxuXePBmKDuK2V5DU+t3e5uUHw+/wBgknXaihG8PxuulCY0RvjR2f5hAuBNJZ7XTvGqO+J8auMvaPAewOKuuJQExMBXQ0YQ7Z7jRyg/295ZikHjrSGTTQNQ4nkayywQX4bLkaAV1VCrQLaXo1MpJGeHb75x3Sh5Xiq/EqJFm60VpFbVyFXxTHMz1Fhb4jN0opkHe9uEe+3dnVB3MRY2DcpP4GYSKt7W7xer8b+FqZPn0xes2j7zObSw67MTSbyE7n1EdmBJQJhcNhMToycTCj9qBGIKleHXlg2JSHXdAkWc/CLGLzCDj/hTRPlN4E9PDnFsXMcQ88fGo6mTgLMdB10hthASc+79gtF6jt6hdEm5k5vaSFerGQ7SKoQYbSw2Xhp4w077H9JOv9Xm2L4rI9qNgwmcW0B1L8MUjFjv52pYei10SOYiM7boN9rxRcYCzo0BsX+yREnuTOMaSFAvahjvxypnMqxTMpM5h8rwS3f6KjX3wmg6M1I1oytpH/YUBdqFPAwp4tSTzZsqC9xhPBFG+DHlFvaoQWQqgr8Tj6XJhph7qOqIbKA8qEmLugzNEmMsFjH83em9yRYACu3e3+yOV4s71RW4oXyOOUUkFt9/aRNmoNIpCPkv9tauF+wg7SROFafANT5UPMqTG6djYHrX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pMyYYopFpERu2tUBjSRK0HHmOF/OnK2R/NLyiyO+pkJdMIeRgESjNpoCPBCH?=
 =?us-ascii?Q?cc6eoITwyqi2UEkiUP5J/47iCuxn97JYR7UK/VLJaP135TOWvgGt9dFmhXlv?=
 =?us-ascii?Q?5+uJ3BIw0FCPscpHD2+b2Y/q5eDrnnTL4acAsS+cz5BWiWC6Boh3g397UPxf?=
 =?us-ascii?Q?tQuJ9413KWqmMmmFWX2Nc2P3tJYt3TVeaM/VogM5NCPhdj8UlMfemAGo+3Pb?=
 =?us-ascii?Q?r1NswGxZlWnMhIt2GdQHtzCM0en90fwZeHeFx1J9TeKqedrc+WbuAoPrY+7j?=
 =?us-ascii?Q?UchQDgrZJzfaMUQRBopKg2H6rGLOsnPFO3CvMVjXvW34twavKeAhnIIsGPPi?=
 =?us-ascii?Q?JOFr7GTpymRCPUFlKNoQnGU6KkDhBGMH3Z0Z4eY4sE1xWvUo/niNi7DydJTr?=
 =?us-ascii?Q?vE05qEL79ueTDOKX6SsyHk7dy+gEdkIMKtdKj2342VRtCaBzH7DqiaKx4GPv?=
 =?us-ascii?Q?Rv9dioeYez0wXF6UPeMbht1Q7C6lK4/cVCd9FvnNN/IlsoKoZpu3ubrDMz1K?=
 =?us-ascii?Q?J/Hv7rQls7vEjqQArJIUGkdPEmP4ftdOE0UogEiCw8ehDj+HCAMqGt3IBQfw?=
 =?us-ascii?Q?TB3f0fkaxEHVdzojKO+jeNE/tGYHM8kVNRwr5BvdS0Du3AFd2BKegaB5YSU3?=
 =?us-ascii?Q?Frms1KHwbL98tNIOslMlHNJcReHujsDhICWmk5KaJk3MxXbYJ1wlzhRB1kjW?=
 =?us-ascii?Q?Y+d8k+G7e5mHMb/NILONcflruKItcWs2SMrLk8OZKtllC0YTxrom73zA/BVj?=
 =?us-ascii?Q?TxWnO+YGRuLPQQTE/l1cHHWi9NRPwFEoXVK07EEpwgrwUDcGNSjT7gXND1UW?=
 =?us-ascii?Q?60Y+AuMYyEhk6Z0jjQBwxJ5DKsmDeNG6tspbMleSe3uuY9TIuNgpZAd6HQ0n?=
 =?us-ascii?Q?Orn+3aZaSCb1auzFu99gTlySYhD2ZhHwS8gK9DyOtUJo2PYGgGA58X0XeOWH?=
 =?us-ascii?Q?WvUZspAnNctkOFn+6Jkah6+1Bz5pWP7lCzXj8O1qjva9fDeziTnHV1XrlXxf?=
 =?us-ascii?Q?S2RC6g56Cs2ohIblI4CVunZh6oMZDHa2p6ZaVzb83rkBnaHjr30LMQ2fN16J?=
 =?us-ascii?Q?IQCuZeOAoOe9ctLNaN+7KfY8+3THDaOU0hpttqEpu/APvAa54/JqZkN2x9d9?=
 =?us-ascii?Q?3YESFJQ78II+mEC82kxzzbHixhKRYfkfcvcAS2ispC/lZWvx3Q12ypxT5/9L?=
 =?us-ascii?Q?ZrSxOe/DTJwSX1Dp5H93nabb/ybvJusVn74iFgY5SjpNbZeenRYBYOawlcET?=
 =?us-ascii?Q?URlnQcgo6MD7qGeAeb4Iutm5MGwPVGZJHFKYimOJBqBLO8NbLFH9ic5ZC0Us?=
 =?us-ascii?Q?G3oTd8g9254zOd8e0heGDZEeaxiMgeqvKyfu/Q8w2X8ZgpvUn8b8H8zmEN/M?=
 =?us-ascii?Q?ejZhcK6DHMGtCrnenCiwxQ3FVqWhpLVMYFDrgnTSJoVg2vJ7bmwW9LwZTdgT?=
 =?us-ascii?Q?HDJR9C8aoMPB8DOGL01Wt/XZkU9HtmxDX2wQvV1fv6BIvT6pDCh5BvT9b4id?=
 =?us-ascii?Q?s7D1qydsJV+GkIXe7nxs9nk6twCwBE3ak5RWCe8eBG2lJik7Q/zptZVGaFuW?=
 =?us-ascii?Q?NI+0WLhjIcJYiJfbrmPH67gUtAwIZpMQgKVfTMziXOSNEehoGmT98MnDpZ1u?=
 =?us-ascii?Q?FfzcKtFePwgL8M4tV4Lr1pus2moHL0XLIxG5ojKMHV62x4XRq9YMm62AjJV9?=
 =?us-ascii?Q?YlsSg/yoJD4mD8UPQnxUjqo+6W0kHHYTlpeVx9CFQgD0HyxANY7fMTa65JZm?=
 =?us-ascii?Q?kHlMLG0nmA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aHnqRAZ71oiHTvDleRJzAybkAC+Qf6VPowKSdaFZBUSut4C40ugJqqOIYnnGRS0w/93CxuQdsVPUHd1a2qRGYUmcRCYjb+oIc50nJLSlbgk0krWgu2CB+baOaIPr/otXx4mQvvSAO0U4mcl6DlKd6gANdEKGfHTg77aoaNDePFLnJRh8aE3eQt3qaV5wSMiTzQ2Ol8DYUlHrnfbFRPWn1tNRkbcOZqBY0uNwdui4pv6jC0VD02Hq0FA/43bHCFPfT4a/r5v0vKgvGCeCzlFWrIZ+GamOO2oZkkrhUScq3enES6nn+1IOQDjsqfBT1YpTuBIlNv3utiUH/8zIhaOZTQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737ba657-846a-4669-9fe9-08decd16786a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 08:49:12.5778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +g4LaNa/I6BFkctAyIxT2FN01RiO+okAm44uoa+bhHEy4crRWYYA9coQlLkxrBZltGm63o38T2j4PvQZxLojwAiIJMlABf8NbXrFcYiTTko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9693
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300362-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:acelan.kao@canonical.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[piotr.kwapulinski@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:from_mime,osuosl.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,canonical.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[piotr.kwapulinski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5133A69EA11

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Ch=
ia-Lin Kao (AceLan) via Intel-wired-lan
>Sent: Thursday, June 18, 2026 9:33 AM
>To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <p=
rzemyslaw.kitszel@intel.com>
>Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.=
net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;=
 Paolo Abeni <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org; netdev@=
vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [Intel-wired-lan] [PATCH 1/2] igc: Wait for MAC passthrough after=
 reset
>
>Some systems support MAC passthrough for dock Ethernet controllers by havi=
ng firmware rewrite the receive address registers after the controller rese=
t completes.
>
>igc resets the controller before reading RAL0/RAH0, so that reset can rest=
ore the controller native MAC address temporarily. If the driver reads the =
registers immediately, it can race the firmware rewrite and keep the native=
 dock MAC instead of the host passthrough MAC.
>
>For LMVP devices, poll RAL0/RAH0 after reset and before reading the MAC ad=
dress. Stop once the address registers change to another valid Ethernet add=
ress, allowing firmware a bounded window to complete the passthrough update=
.
>
>Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>---
> drivers/net/ethernet/intel/igc/igc_main.c | 48 +++++++++++++++++++++++
> 1 file changed, 48 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ether=
net/intel/igc/igc_main.c
>index 2c9e2dfd8499..fa9752ed8bc5 100644
>--- a/drivers/net/ethernet/intel/igc/igc_main.c
>+++ b/drivers/net/ethernet/intel/igc/igc_main.c
>@@ -11,6 +11,7 @@
> #include <net/pkt_sched.h>
> #include <linux/bpf_trace.h>
> #include <net/xdp_sock_drv.h>
>+#include <linux/etherdevice.h>
> #include <linux/pci.h>
> #include <linux/mdio.h>
>=20
>@@ -69,6 +70,52 @@ static const struct pci_device_id igc_pci_tbl[] =3D {
>=20
> MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
>=20
>+static void igc_read_rar0(struct igc_hw *hw, u8 *addr, u32 *ral, u32=20
>+*rah) {
>+	*ral =3D rd32(IGC_RAL(0));
>+	*rah =3D rd32(IGC_RAH(0));
>+
>+	addr[0] =3D *ral & 0xff;
>+	addr[1] =3D (*ral >> 8) & 0xff;
>+	addr[2] =3D (*ral >> 16) & 0xff;
>+	addr[3] =3D (*ral >> 24) & 0xff;
>+	addr[4] =3D *rah & 0xff;
>+	addr[5] =3D (*rah >> 8) & 0xff;
>+}
>+
>+static bool igc_is_lmvp_device(struct pci_dev *pdev) {
>+	switch (pdev->device) {
>+	case IGC_DEV_ID_I225_LMVP:
>+	case IGC_DEV_ID_I226_LMVP:
>+		return true;
>+	default:
>+		return false;
>+	}
>+}
>+
>+static void igc_wait_for_lmvp_mac_passthrough(struct pci_dev *pdev,
>+					      struct igc_hw *hw)
>+{
>+	u8 addr[ETH_ALEN] __aligned(2);
>+	u32 orig_ral, orig_rah;
>+	u32 ral, rah;
>+	int i;
Hello AceLan
Please move ral, rah and 'i' right into the loop.
Thank you.
Piotr
>+
>+	if (!igc_is_lmvp_device(pdev))
>+		return;
>+
>+	igc_read_rar0(hw, addr, &orig_ral, &orig_rah);
>+
>+	for (i =3D 0; i < 100; i++) {
>+		msleep(100);
>+		igc_read_rar0(hw, addr, &ral, &rah);
>+		if ((ral !=3D orig_ral || rah !=3D orig_rah) &&
>+		    is_valid_ether_addr(addr))
>+			return;
>+	}
>+}
>+
> enum latency_range {
> 	lowest_latency =3D 0,
> 	low_latency =3D 1,
>@@ -7259,6 +7306,7 @@ static int igc_probe(struct pci_dev *pdev,
> 	 * known good starting state
> 	 */
> 	hw->mac.ops.reset_hw(hw);
>+	igc_wait_for_lmvp_mac_passthrough(pdev, hw);
>=20
> 	if (igc_get_flash_presence_i225(hw)) {
> 		if (hw->nvm.ops.validate(hw) < 0) {
>--
>2.53.0
>
>

