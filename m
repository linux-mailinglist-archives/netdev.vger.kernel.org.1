Return-Path: <netdev+bounces-80767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2306C88100B
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F3E1C22E83
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D52A2E62A;
	Wed, 20 Mar 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuSYEjTF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16CF9F8
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931133; cv=fail; b=Gldoab9o0Zpy5dQlAVcaAHU3y/qUxP3+67oqPAw5zdVdjdhrnloqO1+23t5OkjCBox2bjp/huq9GcwiNztiZ0sYFfKdoE6h/QtE2ybCyoE0CGpXEmAIDpxLNDAX1dId8Gc0XR9yJRXapkHZl0DrFPcruOM5cNrpRT2Cf36cwa5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931133; c=relaxed/simple;
	bh=zSY1kliUYizC6TGSrLTnbIUx9pRO1rGq519K0VU4CdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PuBMuwvTweeyPKwNyYO54RoR4V/lPO6Okf93R2TRP43F5lo0suTwtz9vhiIgAkCVo2uUcp14SPkiXylxBiCPWd/jcV1XT11oLtCeHlFySjkFvvwwu6abTtZOv3AXMbLpA+ufJAaTdFweux9EvzRlcyfMFtkV7UmqJyhVU3Gkg8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuSYEjTF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710931131; x=1742467131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zSY1kliUYizC6TGSrLTnbIUx9pRO1rGq519K0VU4CdU=;
  b=BuSYEjTFTQcuLMiiXtGlZLvAKKpJDBbmSZrMbkDKk/zANZiyUAojpqOQ
   PJa8efIa3KtFGbcJifqsioCttHH7sx/nhAImLn9ECLgENLJrvoCLxTZnd
   flkGAcL04zaRXe3vT8eovEmSsC/eLwA/fabRgrc+wHyeJQxfBvC+jKUKe
   6DMIMzCJlJO1XsXToBvj2pMAekbhnwwLu64CE0epHMPtQTHQcNx1Ira1H
   Dzn6GTSf7byuNJc02T2TMkN7Lsl26LyDoySgDFByBwqb+0Grc/4xW52jN
   WrPz8+CGjRA8AxzfpFCQCKxilhTf7Hatt+0RXm0dKniBg0OSade+QvT/G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="9663168"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="9663168"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14115283"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 03:38:49 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 03:38:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 03:38:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 03:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXws6gi9SRWTScQ77mrHMPy1Ve8DEAbXK4sVitWeApmMLuYdw+1rkiO+MIQxs/LLArmNcCPVA0+Alp11XeqAR0zNJQh+DQ0pJkBgOLVNaW2vNOvNpEoPBpSfCKJxYxTAJ6C4Qp5NYnvpxb6gG23eCmkEiIJXzk2/vygZ5JA+b4DGAaDkORgG+ScZtVOpxLIoDCVMlQB4sMqrDYnU8Th4qM5Bu2zB3juJQcsl6NNASkLWm90Rb9oyQK0jQDdGfUee5cNFxThTIgmtuIhE7EI98EgT4D5a0fDs5MdKxDNGzHjPurhFT8KYth1JH34dGmKl+zzG4Ez1zgIZGMcRSQKleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcQ28ZohZ5qr91qg/8M6nkMOdl1ZG/UEpGDJb29LVlA=;
 b=hmT6SNMpLisT6sg+9upq5DX+Svl6o70qn+ZjaKYpJa/tP+hK/5m8faH5ZVSnH8UCDWVd0mqvqGHYS35I8p391EQaamuwy7hcKeXeNxCqaERkTzVIKKQEduVU+B+5sYGpmIyiDYJXvxW2dlEL/DV2/Yo0+UaSpt+3NXsH4+aUmLdPLhA1osZFVZbAeu4fwynXXti0BnZSTeOTKywN6XXz88fa9Gfu8ldZE1/GWE4bGw+jDPvSg3tlKtebsguPnZsRubIPNCJQzgH87YXWd9GLcjDDqbVmj4ednT7CP8T8I7QVPNpTeK1uYWs+moWlr88ulgQgIQ869e8hlu0HMo3W6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21)
 by SA3PR11MB7979.namprd11.prod.outlook.com (2603:10b6:806:2f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 10:38:47 +0000
Received: from IA1PR11MB7942.namprd11.prod.outlook.com
 ([fe80::f8ec:1bc6:aac4:e63d]) by IA1PR11MB7942.namprd11.prod.outlook.com
 ([fe80::f8ec:1bc6:aac4:e63d%7]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 10:38:47 +0000
From: "Sharma, Mayank" <mayank.sharma@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Zou, Steven" <steven.zou@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Staikov, Andrii"
	<andrii.staikov@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: Add switch recipe reusing
 feature
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: Add switch recipe
 reusing feature
Thread-Index: AQHaWj9RFF4lJ+IEYEuth4p3GXqMU7Eq4VkwgBXOF4A=
Date: Wed, 20 Mar 2024 10:38:47 +0000
Message-ID: <IA1PR11MB79420FDEB09C651D9836F723F4332@IA1PR11MB7942.namprd11.prod.outlook.com>
References: <20240208031837.11919-1-steven.zou@intel.com>
 <PH0PR11MB5013D1C2AD784512CA70173396212@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013D1C2AD784512CA70173396212@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7942:EE_|SA3PR11MB7979:EE_
x-ms-office365-filtering-correlation-id: 45655b82-b74e-48de-f88a-08dc48c9ec8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ArDLruok7htr7kx4uqQWnws1o/P2E9QG7Mv0OE2Z2RBHc/biumEdO0qjqAlKxfJy4rVyFCfp+9elcLBCDK28IzRMOPYCo90g9u1H2/fhOotlx1DK51EgDNUsTjBg4ZLw9/EP+gjNJHmh1/2XI1+WBrxYxUw/bfDL1dATO7gM8o2/oY4fV9bWckrWgJln2yLCt6+3XuW3dkfPC1c1CCipdlpQHb51KbRaQDvwequZqL7WJVffQJ6UHasoS4hL1xUFWO0tNv0GL8Ppq82Z1sCJf6vxHOCfxBMxA76HE9WvueS1dHCdgyKNtTrZn86dAr7ngJ9H9w/zpQY6f0b47LzrVMTAmUCDsOe2DjLkpz7XNBvzmB+/MxmN0gn6agqbXqYN0KLec88MHIEUqLpDPAuJCZ82va7Ug4J0xV4XWgOZ8PFjNIb6HgbRwCGiiFLOtKKf00iJA4DDb0xK2k5QlVf+ntV7MfbrnDFDD5FiqtAD0Y4InalSorSyU3KWWi4uL6fdUhH1Uu434EfPIW8T+UCBfH/6Z4DGWWpwgv2FY9UeiWM4+KaLtPKu3Y8PU2xNzmlqrtv8qVAhi7UrJ22PsGRz9sWH9hXQjboG9EfDjxJVi6KcOfWdH97lqLxR5jEm0x5iMG4/HUlgflRYbyLo/1WuZLpALH9CTvsZwD4fIJUlgVSniT5ifvSW6ecyD1Qeti+8TivFD9/ly/PxlHw5y9kxQQ8YL9L6wrVIg32dgZDq0eA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7942.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M2ltfEa3YF+NI7UgUd+hAB7hcVRRKduboueBGtXQbPFjkrvP/BObwPJzCwG7?=
 =?us-ascii?Q?jR73xaqkAGqVxY0WPQFC/QWAyadTzYXO+eaH2ffMIfeuP/5m/tashFlEhYuZ?=
 =?us-ascii?Q?7ecqQiGAkenfW2Vjf0QQQRPM6qhPvDyoT/TXnVR01EwSusmxr40lxBJI404u?=
 =?us-ascii?Q?+Hx9C6QHoeuvsA/hEqdtc2PMF+j1Ylot1VZdUp4tsPZuBwq+YWq5tosV12tX?=
 =?us-ascii?Q?R0usBDWrU8V2WEoKxArCwT0+nx2j3ddYVj9rd56h2wiH/gQcCX9L3ZPZQq9F?=
 =?us-ascii?Q?fBySMQ8umMfb5+v+SmW94eJN+RnWLJafyxoxVdU/JGlQMnz/dyqFr4FiVvkg?=
 =?us-ascii?Q?mFybQsgOWy42KKdGhm7PBuWvj8ZAa9PKkWe2NplObP4dpBb1vA0+hPVXKjNq?=
 =?us-ascii?Q?CFeECDpG4khN+7ggDMWxKCdnWYCZZ1qEnMVwdnYEb5E0xRFR29E+/94fh0WD?=
 =?us-ascii?Q?TmGjGXw0J5VqFt1AomtFk6x/caYEHjEplZlMpHeRKJaVYOlmVAcWnAEVG0ZF?=
 =?us-ascii?Q?jbXlN2DufW3bFrLWNcHCLDIwzkCgxhTTnds7Sl4KPIRfU+ttLgjtUeAm0s2f?=
 =?us-ascii?Q?6Pk7snRwbao3iIskbreBWpTii5Kqq+YLVnEpyFAhsZsNX9CNVz6t6uqIRqMX?=
 =?us-ascii?Q?P3J92N1l9K31U6rPJANafgOu7CCydJXa8xW2/12pNmOC110KmOrLnk83Pv+U?=
 =?us-ascii?Q?v8j8ariicnBQ3+/me86bv/whpaNNJ3C3S80vNdgWf5bQd60Lq1rd/Du8y99U?=
 =?us-ascii?Q?bezzIoMac6MEsg53d99ROZMjpmuNuG5Gd0l+D+viLRmMsemfVuKKYf60uOjP?=
 =?us-ascii?Q?FpZ7llmYmc2J/xFvO9f56p8KT01wAX5G/ePObMv6BD8mhA5iaUIoHKHPzUAL?=
 =?us-ascii?Q?+Y1BEgU2LX+ADy1x9m6GrLhmYHp3ZXVhQcAdxYnrMYKpQTyh4sGVuvRDvwF1?=
 =?us-ascii?Q?Hj+zetAC1H1fKciPXBBXcwfyZDhTHouogiqpQ+sG6vyK5Eb788KjMcF8gLvv?=
 =?us-ascii?Q?78ETnbTLWOP1vmS8xXMtHo27xAUBCd7WWlGpp0ao81tUqLbHpax0hrLr3oFR?=
 =?us-ascii?Q?aZuVB1Z/O68M4FmAvpbjPxLPUqO8di8tOWuzoB8qIMb8jq/pmoIEgJ0taLmd?=
 =?us-ascii?Q?gcNDL2KbGpxGWqEcfz+QMRJnUenmBLkZ+XxwdAtX5vlFufwxKGmUR183XE22?=
 =?us-ascii?Q?KW1n6JT6qG1D2h6bk3HgEaLr+MkOWIq8Smr+XrgWoSaYWM+VXkjHtf1Sz40I?=
 =?us-ascii?Q?mRk1M1HqoKyhEyvfhf0Xa+pcF6iokB1MFQ+9zsunJftAnSOOCOoFENLVFxiS?=
 =?us-ascii?Q?jlku8RZN9MIAoSVLwM0HNxncjFg3QbNTOtWXy28Ox5RpAosLQT38eu9yvTZf?=
 =?us-ascii?Q?+z35jpn4F1nJmIhhi/dpThc7W4JkWjp5JiOyvhy6DqdIgdp9+DWw/9KLKtK3?=
 =?us-ascii?Q?bNh0UyLArgQUpuv2AMM+n5jrgkXXHWvrmNEYpsSi8uiMk6cbj0u2rFKN8OdT?=
 =?us-ascii?Q?dGIiMVG/h/dxJvYn5n+lpVukp30I+MuVGWVqeV2TPC5Repp8Co8vbuUxh4kD?=
 =?us-ascii?Q?LzhgOnzocIqfuBUztHA7jWP+6XrYtdTyp9UMZT7Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7942.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45655b82-b74e-48de-f88a-08dc48c9ec8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 10:38:47.3618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9nEyQ/QJ9b+9M7H1aNtg4v2RyU7zkz6paowEeErPTm6GRDz7n9dc/MB3lVljd+yDLeU+AAi/1vZ/fVaz4/YYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7979
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
teven
> Zou
> Sent: Thursday, February 8, 2024 8:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Zou, Steven <steven.zou@intel.com>; Staikov, =
Andrii
> <andrii.staikov@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: Add switch recipe reusin=
g feature
>=20
> New E810 firmware supports the corresponding functionality, so the driver=
 allows
> PFs to subscribe the same switch recipes. Then when the PF is done with a=
 switch
> recipes, the PF can ask firmware to free that switch recipe.
>=20
> When users configure a rule to PFn into E810 switch component, if there i=
s no
> existing recipe matching this rule's pattern, the driver will request fir=
mware to
> allocate and return a new recipe resource for the rule by calling
> ice_add_sw_recipe() and ice_alloc_recipe(). If there is an existing recip=
e
> matching this rule's pattern with different key value, or this is a same =
second rule
> to PFm into switch component, the driver checks out this recipe by callin=
g
> ice_find_recp(), the driver will tell firmware to share using this same r=
ecipe
> resource by calling ice_subscribable_recp_shared() and ice_subscribe_reci=
pe().
>=20
> When firmware detects that all subscribing PFs have freed the switch reci=
pe,
> firmware will free the switch recipe so that it can be reused.
>=20
> This feature also fixes a problem where all switch recipes would eventual=
ly be
> exhausted because switch recipes could not be freed, as freeing a shared =
recipe
> could potentially break other PFs that were using it.
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Steven Zou <steven.zou@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |   2 +
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 187 ++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_switch.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
>  5 files changed, 177 insertions(+), 17 deletions(-)

Tested-by: Mayank Sharma <mayank.sharma@intel.com>

