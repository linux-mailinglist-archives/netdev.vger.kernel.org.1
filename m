Return-Path: <netdev+bounces-285935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGREG4wY/mmQmwAAu9opvQ
	(envelope-from <netdev+bounces-285935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:08:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE894F9C80
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2650304470F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F2240FD9C;
	Fri,  8 May 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuPAItzb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DD3F54B7
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259813; cv=fail; b=plR1k963gMghJIJdUg87N0KiJiq/2w+YAyCRr4PQu5ZdG3qMxsKKQYss3olJrDUagRVznZQTasfWoR12mPFbOEUlk//nBThV8DYLmwbZO3onlakIncyB6045xY6qDg46riinVqO5XThIS9bv5+s7otl9wxfLEnMhTtVTAWqEcmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259813; c=relaxed/simple;
	bh=4iS340k0hOCGrloCEZYmoQTGk7Xa94dtIqSADQ1ECQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pd7HokeWg07N03RiRd5bWhCwZDF1BwehZsUDVmXwGIYl9sLbVt9v2osyBP8vQxp85KJPAQdgU7+xM9aLdRwZjI0TnUG+114qiR5R8CjCkEBrkXM/NKzaQA0U2tNeUQ7dMpQGF25BGlASNyQK3M9kG0NPmscAImysz89iDb6E9Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuPAItzb; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778259812; x=1809795812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4iS340k0hOCGrloCEZYmoQTGk7Xa94dtIqSADQ1ECQc=;
  b=EuPAItzbrhI9MMwpUi9tclIArJ8JOoQ6XtlmN+qL1TjmqBL927NGTyuN
   1IayIb3EugXZmWcyw+OmqK5f97Q8NOKG59uH+Q1a7qsEztBzjF6ZEV1Da
   jeX5NR0dkJxoDOfy97SlALbmzV1tP/PpKFZJRbitOhqmvoNBT+q+LUV2V
   EaC0yr1HjZZUafpNxb4fFc0uJWoXeaW8f/z5bOVpZ9NEwKtvUNyWC9+PL
   ipq3mvAOsQ5oO85ECNktszG6sG1S27QUHwFr9/9MBogNymWX0FHIBAh4S
   PMOmVhF4G6cx2cm+zNQZL1swHSeFRPZYucd9ppY9/pBrGy2xUANOWKfB6
   A==;
X-CSE-ConnectionGUID: 9FT1pGKrRK+eg02NS+zQFA==
X-CSE-MsgGUID: 9AdEQvjSQoegXERLoS6z0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90694034"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="90694034"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 10:03:32 -0700
X-CSE-ConnectionGUID: fsx1icXQTrGCumjeWauFUA==
X-CSE-MsgGUID: EYzBa6vQSJ244rfdJne05Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241169656"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 10:03:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 10:03:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 10:03:30 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 10:03:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVY/HXoJSwZx5ljc/0yEpQK7+6zrFrUPSBrrsV+HvhejbTJkkYO7VUnff5rYgWP0z5yWsIeZ169fXro+U5RN5L5FzHsZTrCE+2KbiV5C9bAL09DX8aBXumavbae0iHEitqqsoU31JANCNvh4LAL7bdJ08auy1K61m7NEOHuXVUQ5rwqPGge1hG38aZ39K0twiaO4gY2LjhQI3j22JK3irahtTCkstfhXTl7tS8lnn2l5L9U47uu0czb6A+aKHnfzAKl+PJJTASNwhhxjI/IuwbbJQ3UEncwQcr3sF4jd3diZz9fYn2lDfjsOO2Zq6B8wzxGfPjvkwCu6O//avMWjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vro0p23CVSgga6Ame54m+5JIksbqnZjZqFb6vH3ayzI=;
 b=PPS9mH4eUICv3WECQg+44a7lfe8HvUNtijXIrQw32PNnJ4MD2LpumVkuro1qFWi8hl+v4wNQeIradgZpFLG2S8sTaKbiOs4IKOkQBUGeGHxBztKa1DLU5hllhvNscNmjWA6yHBFB1wROEcMWQs/BAm8B8yxSpYpsbvjFWykHhdytRrfrjX2U570G4GKaW/mDhPiM6h5F+V3Z+gtYeCU7CQUDxFk/U3xxiJaAccMNEQ+elqmvt9w4XgECjnwfUuBIWEGCKEH4t5DJFBvklaCsOp9tlxaYkcxZj9apMCUSifSx650ektlGAsFtpXqvFpuxrM4o3ru1YCcMFzl7cpqmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB5888.namprd11.prod.outlook.com (2603:10b6:510:137::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 17:03:24 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 17:03:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Schmidt, Michal" <mschmidt@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, "Richardson, Bruce"
	<bruce.richardson@intel.com>, "Medvedkin, Vladimir"
	<vladimir.medvedkin@intel.com>, "Connolly, Padraig J"
	<padraig.j.connolly@intel.com>, "S, Ananth" <ananth.s@intel.com>, "Miskell,
 Timothy" <timothy.miskell@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: RE: [PATCH iwl-next v1 14/15] ice: represent RSS LUTs as devlink
 resources
Thread-Topic: [PATCH iwl-next v1 14/15] ice: represent RSS LUTs as devlink
 resources
Thread-Index: AQHc3uq0PmcPkxxC/EW+evaGPsRX/bYEWijw
Date: Fri, 8 May 2026 17:03:22 +0000
Message-ID: <IA3PR11MB8986DED74CB42DE655B0E436E53D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
 <20260508124208.11622-15-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260508124208.11622-15-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB5888:EE_
x-ms-office365-filtering-correlation-id: a26b8e38-91cd-4423-16ee-08dead23b656
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Cs4CsYQ+4rTo5M6SSiY2i8BrJUDEeSNFdePHfzpxwVQ/LnRSfsTjz4BrsqAwgw7L8iLBTicl76S0i/v2i0jPafwh2yfd4GuV9zDA26FeuflFatCtKKxvrEYfCeEoqylgrVwnENGdfnH3L/ki0gZLwzfaPSn1H+QV4eQQ3Nmf7Ph754a/FnDp7EBIl2WsPDTU+KD7OSbAuQ24u2KZmT0Qt5al2NQgvDm9CCto64jBe5oPz1Im7hRSpOJ7eSu6z5zne7zIgWvnpSi9CFTDMwqhDdcrO2G8zCDMUmONLDUv1iIOPA3fPtXjAz3s2iLYMTVk0xSBXvfs11HS/d6wZswpqQCysqEjugdR/6DmB1eZiAn4Cfk4msC42Yg6QhewiHRqyEslaFaRVTtT5DD+gecu3+jFoymAjk+LwFcf8FNdNr4UJgKrKvt/xJHitB/HpxQBigHuTAqXFCJHaTPnle7bpIyxNT1bEBxpupAOdE1Aoz37weIfsrlsijYqWNTKWtfRVEdfe/jPqNMmYpSS6FVkDB92JKhfcvvZ94P1es8BSVpTvYiUFQyO5GZb5c0L7Xi/h4bC8O3jO2bIQftPRRyhyse0kxH+dsUIWHmAM4pHfcN/qxoWh+kPuVMH76PtZcxjLV1VdDkeQna67aDTTjSzffWLYJCQpIhswVxlA6Mdcc2+uw0OxrcqGvjWtYEsrUp3Ses7cFO09DyfsEEBoSLxMPuXjGNmuTzmQZ1O8PWxyO3sg0Y/5qSREgqtwQiy06i2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s1rq1kuK2ULtWciJiuvcXApFCkf5ofVpHqxmKhmW26GkCDzgOU3DbzldVUKt?=
 =?us-ascii?Q?0tw4JuS9y3tuQBNKhVxdlM83rS0vCTbPI+62T396tMlKqwLmXKB5FM+gTIlK?=
 =?us-ascii?Q?f14uzbIa3qAxWQpybgLhTpIArpqEsaxUVGYjvP/1Ln2vtqbyER3LCjAObzSX?=
 =?us-ascii?Q?eWSDFhdfn0H3oHGNP4D/uBv/iGvGkSdH55Ay27K5ax24w8HwXYfomjvVjPbA?=
 =?us-ascii?Q?TyIE4yQPuTC8oSW0Z7dnRSaOB4/zQLzb3OtYNrnQGeudZzqZuDZ5YzSWWTyK?=
 =?us-ascii?Q?nBw2Qb058nYoNmMo3t3cDIIcEGUBNajw/ENoEk1meecYMMWYedlDTjS2Xf9Z?=
 =?us-ascii?Q?WeaDdPUB3Q4ZbPe3er8KwxlqQKQNhKI+Wi4aBhuhExSrT7JJsY8zTCcUmd1o?=
 =?us-ascii?Q?pmrB7CuKtfxjio3K+7Fz7NBPTB+Z/UrGTUAKIVxtg/XUfZEjPnVMQbpo5yyX?=
 =?us-ascii?Q?rChewR2anTC+JN2PsUbCFSNcK9Hdg5fJbd4jf6kVlKoeU8yhR2NwgJkSl1gg?=
 =?us-ascii?Q?mzz7VuIs5SUTowx7fNEK6vqV+en4Qpcg0xHxYVt8KNVjfui+hxqvJQ5Io2dZ?=
 =?us-ascii?Q?ulUPhAydhfGYOVGBBv0lM4+wz6oTIYfbztZXUELfLMKljIDpuCWbRcTerZLu?=
 =?us-ascii?Q?4laSy6wIr0sooJrluynchd5i/jwQ+azrYn+x4acTw6mri5JOeeUsxWF3CIY5?=
 =?us-ascii?Q?K33TfcWH1AJOmTKvFcf6WF60KUHggmY8NFfnogmurP9+/2htT4tLAiyNtOpe?=
 =?us-ascii?Q?G88FJhvOsxmP2xkzk3NOzLE6bzu82FMsh4TN6n+45VkZwRbhlnzDqLGToHyu?=
 =?us-ascii?Q?nao8//0tMyLOMHoT1KkkCE+mWwF0f/7nimFftZWMwyVMvrr/nBU+0Cxtj4b5?=
 =?us-ascii?Q?FtoAd6yPTIxxLc1UUSy7LRnFWWYuVhqJDm3LX5cDgrddjyDLg1pfzqg1bUka?=
 =?us-ascii?Q?ci2ESguARCuZoCl2/GGEQdo52U5zjgJacG4DUv7wdrGa/tMLfdofMp48bLy2?=
 =?us-ascii?Q?jkeBoU8zishLYkQE7188YgHotRTeP/HNpjpIkqoQ33vMW1dQOPOEVsAZgONg?=
 =?us-ascii?Q?nQaSIHUfQT29boftM3kOxq9NUQVWeAsUY1jvQDEI9UyPyvhuislColfUWFg1?=
 =?us-ascii?Q?0wUZ2PC1JebHjdyoGsAVf+UGw2vEEr2LPdVDWCUIZfdft4BGhC5hpIJ2ChYm?=
 =?us-ascii?Q?hIslC3g8EWUlqocEDE9K9OxeT5BgDOH6znCezLQqxWaC1mwftQSP4Kn89XRE?=
 =?us-ascii?Q?Q5uJKe+20UAE+6cCfftZBOm3tSJbFNpbdhb8VzilbHi+RYGMNMbo+iS1dALn?=
 =?us-ascii?Q?7QMlz82aBKjAyOno27zQ2wFFoiNOHgz1/KhUw3HrK7pS/p9hOZZNO3WBirUn?=
 =?us-ascii?Q?dNaBEjXQavsigcppX+TQYGTYppku9f0dxzGFInoDtyUtJmZBeQPsKr5uTmPr?=
 =?us-ascii?Q?pdWcm0m0pBJfew5+m05x7iug+/ZST6FuC5WXdjqLxjOM/Xfvt+0I0vOl1dzf?=
 =?us-ascii?Q?uRL9eV8VnnorvKUaIXzvlewD0jO14lnurChDdAunVKq2gEU4YRsBiRXtJvtE?=
 =?us-ascii?Q?86037GYfGnoGlGM2hjk6odng7gHTkeUIXG81kQrKG2FazwQ7jH1iK9teAh70?=
 =?us-ascii?Q?q9npSK1a1r7oUZ1xo5L73cw/FWwaUtAoG9k5Rw1d6qZ/c2fK3CqLnjPE/bKd?=
 =?us-ascii?Q?YMj5rlTLBWnrocsQdZKBd/hfiqDcO9kbP5tiV8F40gt6uCH26J00E/xt659x?=
 =?us-ascii?Q?327owZwSKmTHsKpp54oY5n8FgnFkUG4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KsDq7LaqOwC3JuYwmf8dxpBHwFbrxpVdG5FbmzyB/rI2g6LnJ6vV+kqPB+AWkjfUDH+XaBn/VgrhDXeK1uHOILr07N4ZwJXsOV99NbEe3kbiC4QLDCnIRYi9kU3MIkVFbqjmoGczUNJoLvvGhhkeHyHG4Se7fTwUTLzliLmcg/bfVLxSKtyZFef86Wm80MFqe64JUEbco3cnsYB5pUG/ioz/5QFSaHi6Xz3lNlNZr2ckY0/HNqbFbnJso0+eKMc/vrIF6PYXvVm54/v+MRF6NzrbukmIUNJKVMcvwTEezHgHHfXLEWkBpYUPbsA2y2SdF8c/eoxH4m2PbUYUBFW+dQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26b8e38-91cd-4423-16ee-08dead23b656
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 17:03:22.7493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96mLxtXzL0I7xKfVS2BQSkVZmA3lIaJSzvTvXoChUGM+mj30Y5QNx3YGc+JviaAPljr8SBISkohJUTkw8gm6wtfgI+c+fGzxWS7KPgLA+tM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5888
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 6DE894F9C80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285935-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Friday, May 8, 2026 2:42 PM
> To: intel-wired-lan@lists.osuosl.org; Schmidt, Michal
> <mschmidt@redhat.com>; Jakub Kicinski <kuba@kernel.org>; Jiri Pirko
> <jiri@resnulli.us>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Richardson, Bruce
> <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Connolly, Padraig J
> <padraig.j.connolly@intel.com>; S, Ananth <ananth.s@intel.com>;
> Miskell, Timothy <timothy.miskell@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Czapnik, Lukasz
> <lukasz.czapnik@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Saeed Mahameed
> <saeedm@nvidia.com>; Leon Romanovsky <leon@kernel.org>; Tariq Toukan
> <tariqt@nvidia.com>; Mark Bloch <mbloch@nvidia.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [PATCH iwl-next v1 14/15] ice: represent RSS LUTs as devlink
> resources
>=20
> E800 family offers three kinds of RSS LUTs: VSI LUT (sized 64), GLOBAL
> LUT (sized 256), and PF LUT (sized 2048). Until now the GLOBAL kind
> was not used at all. There are two possible usages for it, subsequent
> commit will give VF option to acquire it, and this one enables PF to
> switch between PF LUT and GLOBAL LUT - switching to smaller one is,
> again, to make it possible for VF to then acquire the former one.
>=20
> Devlink resources are used to let user show current usage and change
> the allocation, see examples below.
>=20
> Default state on 8-port card, asking for aggregate "whole device"
> usage, note that there are as many PF LUTs as there is PFs, and, for
> e810, there are 16 GLOBAL LUTs:
> $ devlink resource show devlink_index/11
> devlink_index/11:
>   name rss size 8 unit entry size_min 0 size_max 24 size_gran 1
> dpipe_tables none
>     resources:
>       name lut_512 size 0 unit entry size_min 0 size_max 16 size_gran
> 1 dpipe_tables none
>       name lut_2048 size 8 unit entry size_min 0 size_max 8 size_gran
> 1 dpipe_tables none
>=20
> Now let's add GLOBAL LUT for a single PF (on one-port NIC):
> $ sudo devlink resource set pci/0000:18:00.0 path rss/lut_512 size 1
> And show it's resources after that:
> $ devlink resource show pci/0000:18:00.0
> pci/0000:18:00.0:
>   name rss size 2 unit entry size_min 0 size_max 2 size_gran 1
> dpipe_tables none
>     resources:
>       name lut_512 size 1 unit entry size_min 0 size_max 1 size_gran 1
> dpipe_tables none
>       name lut_2048 size 1 unit entry size_min 0 size_max 1 size_gran
> 1 dpipe_tables none Let's take the PF LUT out of that PF afterwards:
> $ sudo devlink resource set pci/0000:18:00.0 path rss/lut_2048 size 0
> now `ethtool -x $ifacename` will report smaller RSS table.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  .../net/ethernet/intel/ice/devlink/resource.h |  19 +
> drivers/net/ethernet/intel/ice/ice_adapter.h  |  40 ++
>  drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
>  .../net/ethernet/intel/ice/devlink/resource.c | 469
> ++++++++++++++++++  drivers/net/ethernet/intel/ice/ice_adapter.c  |
> 12 +-
>  drivers/net/ethernet/intel/ice/ice_common.c   |   2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  23 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  14 +-
>  9 files changed, 573 insertions(+), 8 deletions(-)  create mode
> 100644 drivers/net/ethernet/intel/ice/devlink/resource.h
>  create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.c
>=20
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index 7f06d9bafe4a..0217ab6403de 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -37,6 +37,7 @@ ice-y :=3D ice_main.o	\
>  	 devlink/devlink.o	\
>  	 devlink/health.o \
>  	 devlink/port.o \

...

> +
> +static int ice_devl_res_take(struct ice_pf *pf,
> +			     enum ice_devl_resource_id res_id, int slot,
> +			     void *owner)
> +{
> +	struct ice_devl_resource *res =3D &pf->adapter-
> >resources[res_id];
> +	int end =3D slot =3D=3D ICE_ANY_SLOT ? res->max_size : slot + 1;
> +	int beg =3D slot =3D=3D ICE_ANY_SLOT ? 0 : slot;
> +	int err, new_id =3D ICE_ANY_SLOT;
> +
> +	for (int id =3D beg; id < end; id++) {
> +		if (!res->owner[id]) {
> +			new_id =3D id;
> +			break;
> +		}
> +	}
> +	if (new_id =3D=3D ICE_ANY_SLOT)
> +		return -ENOSPC;
> +
> +	if (res_id =3D=3D ICE_RSS_LUT_GLOBAL) {
> +		struct ice_vsi *vsi;
> +		u16 lut_id;
> +
> +		err =3D ice_alloc_rss_global_lut(&pf->hw, &lut_id);
> +		if (err)
> +			return err;
> +		if (lut_id !=3D new_id)
> +			return -ENOANO;
 -ENOANO; looks for me very unusual choice.
BTW won't LUT leak without calling ice_free_rss_global_lut() ?=20

> +
> +		if (pf =3D=3D owner)
> +			vsi =3D ice_get_main_vsi(pf);
> +		else
> +			vsi =3D ice_get_vf_vsi(owner);
> +
> +		vsi->global_lut_id =3D new_id;
> +	}
> +
> +	res->owner[new_id] =3D owner;
> +	res->pf_id[new_id] =3D pf->hw.pf_id;
> +	return new_id;
> +}

...

>=20
>  	return status;
>  }
> --
> 2.39.3


