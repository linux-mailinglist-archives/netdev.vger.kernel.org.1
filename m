Return-Path: <netdev+bounces-304910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6MBNNit0S2reRgEAu9opvQ
	(envelope-from <netdev+bounces-304910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 11:23:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B12D70E919
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 11:23:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=OnpVZ53V;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304910-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304910-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C51830004CA
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEFF42F71E;
	Mon,  6 Jul 2026 09:13:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643342CB17;
	Mon,  6 Jul 2026 09:13:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329192; cv=fail; b=YjmFUzB0kCic+yVSPYu0Ea+mguj+SHgGjhF88CCVmu/kwKi32vHuIrt6S0cemkoLKp/dcaq1jHSVuG0jApkMS8gC1BmTVyTtk3mAWtRi1lvDDWdn2CDsAonshiE/Bpzl+c48cdQZsOcWGdGPg7+WtJvbMseYgu+w/hY2NG3CRAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329192; c=relaxed/simple;
	bh=4P5gtOFUerGe0EM1ixJY1qwcJzHgYltlB+/D8xjEM3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KR2CfxKpwr2QrZxw6RgBMZKae+L7oL5Oksc0Z7eRGusodVnUaN7TEL6GGj2olWFTJXob3+tQ04MLLE9sJvP8fDBl/HRd2Cgjath8sJ5CAKFN7CkNQGaGJoh7jlBo4rrTYjt+H1gTcTnKjk9fKVcPnVIDqF6cDuleyZPa2yrymbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnpVZ53V; arc=fail smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783329188; x=1814865188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4P5gtOFUerGe0EM1ixJY1qwcJzHgYltlB+/D8xjEM3o=;
  b=OnpVZ53VEJpMD+KAW+UNsQwZQuhaxJMvQWizAvAtw9xbejrtjuQzDg7G
   GXoZKjhwAWusaJzherZhmjKUCFU83zbGSFEr+0MvXLxEpaYRlrTL3e5Ss
   Ib0SFZC2rtD7pRdIf/wWBvP+Y4NYoOG2UESXvBD+uU9S1HmiA7nnnOUIZ
   dDGbHer/F4eDmQ0ky7Iz7mSk0i0C1PN0Drbv1wREbytKxyC4ryYDgPQD1
   BO3Qr/tYBpx6E6p6hnqLNpihd5hxZo734xKznjFihNKP7PtKhdmcwYKjz
   C4/RZc0BuoxN5BhaH4EWgCooipYK97DuBR7P3Nl0lqEMn6CxzIrOvQWFa
   Q==;
X-CSE-ConnectionGUID: PMS4ppVhQoWUfbSfPEHKZw==
X-CSE-MsgGUID: qX38t8jqQkybW3msdLyIMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="86510035"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="86510035"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:13:04 -0700
X-CSE-ConnectionGUID: zeDPx1ApSZiR139fIPO7sA==
X-CSE-MsgGUID: YWT0XXyRR4OffJ8q7VkTAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="253191327"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:13:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 02:13:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 02:13:03 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 02:13:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyl1hvOEzJmCiJSTXJdi8IscfGQ+nP1MdCCdcNJGpNOVDc5e71Yw0sDfOK5Rzn6mRA6Z8wIymM0MSNLXr8qYs/2y76W/eBbSAuGheIJjbC4METfE9TiywMu/FTTGm9Dx8uRHM23EFVxonuKMab091BQSj5aiC7X+77bI6bkks1+kSa67v97I3V7ruR0rCFNEFlbcIY2drMkKIx9gw2+mT5rriqPi+oaONXPPrrcWvo8AflF1f1W9++Gp/wiSRKGc+jNKS6C0DfttuRIrrHNkCKBC+J/9Ic5i3WxU4KfccJSBDVmn27fmhyD0XNvelN7KmPUpz+Kr7KpTRG9FwKam/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4P5gtOFUerGe0EM1ixJY1qwcJzHgYltlB+/D8xjEM3o=;
 b=Ssf2iMAktvrPt+//yjW7XMYDdIWFEx0+Q94WwMUh9iwJ+oWgo7hXQZIfWSg63uwLlZHXIt+qkx6d1jy5uw5GFemFiwpgccC0oIHrl+3kW35KVypaq3UXVphaH39HQgRtLO8akADdtIzffWirXxWgoPlalmlavg4rEqq2e7c0h9oquu9C3tEEqsyre0/DOl5EIifIb/vjF5bo968CDuVXNDSE2zUsl7CoAambCCNQgzXlQuzMr01TVDZCa4DW8od1bOq1M6kkYmEYP+VcgWKTUx/73wrvQ5VRxKs6C+Ba7EzL1UhV9Vj7UIE2XiAmYumYhzoJONVfWvjqe0Y6k1IRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Mon, 6 Jul
 2026 09:13:00 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 09:13:00 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Hay,
 Joshua A" <joshua.a.hay@intel.com>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: RE: [PATCH iwl-net v1] idpf: fix lan_regs leak on core init failure
Thread-Topic: [PATCH iwl-net v1] idpf: fix lan_regs leak on core init failure
Thread-Index: AQHdCtsqNBw1WrA5j0KCdYRO+bqom7ZgOXIg
Date: Mon, 6 Jul 2026 09:12:59 +0000
Message-ID: <PH0PR11MB5902BFDA3935B15A12D4B091F0F12@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260703104132.47419-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260703104132.47419-1-xuanqiang.luo@linux.dev>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DS0PR11MB7481:EE_
x-ms-office365-filtering-correlation-id: 65d31265-4017-4a4e-508e-08dedb3ec6a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: W0KPAZmLwYj1PwJLh564d6+MOjQH4P9VputPMlvjbyiktFJ4wyTxX1yDIUACwrK8UXEMGSFzjZuPucRJNtAsnGTcZi4+g3veAxjLSxn82Q7iS/iHYolm230mFNh//PvDm4oZT4ZExlJuS0rEAEy+HR24+jvIR5/zTPT+GLRWihertKijX0rw7BQo7+ik67awX8/M6tMBIKzGm6+LmwlXsMH+cHOlID461TfpsPdribMbCdku2f+TQDIgXoaent9qkyo9XlieJdjWeKA1ccPd4Er8ZzazA5HQHH9CfuakiMeOjLXSpTE8wfrpdiRNXFrTptgu4BD+YIOLcTO7ooMc5z55h18bXRmhauGhf4eDRzw+2xk0GW7B51zoHY6I58DPlhJgdKMaist+t66Jx5MtTxVHZ7oVxGcZzaxcSCS35Y4FV5EODAermUhYBWip2rYfxJhlJz6Z73eJtsNbLH/LXFlqIwe82BzeTTjG+gCnh8l/cYD84T4tr55KhFLB9gK5VhO8FNHOd1fKcBrai6ikrLLV4tqvSaNd5enEwQpU1vcK8Tx0HSIU500bc10KNiWZelMK9yAv2XNqsM+NOPAzxFttXlclX8+YkyjfiUAHtyegDJeQy6qOm/cwbhGIF9UffwbWsgKLA1IzNHvR28gOy1uwpOGrd1Mfcv8RrgEL0aSi7TjkO0xGjtAtz8dCT5UXLCNU0A26el4Pwh61JsDd1i4ImT4ig0/lX0egdhTQ5Lg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KBrMWcLfYuIyIpZipVFYsipfNJruAvyF7wW1vjzeq/jiTIExf1Spv+LSmz5t?=
 =?us-ascii?Q?mDiKd55Gj7KZKjh+iGfj324kvAunnbTOPsXgiAi9IjHFCh0dE0gnc6DiyQXW?=
 =?us-ascii?Q?niHRT9Nm2rGx000vOOlFG7rKAiHVYfUoDQOpX2wbhURPWIUM7ph7F6FWOM/p?=
 =?us-ascii?Q?dCLjII2JcRoMbzkI19HIiQuvpMc0a0BN7ePYMN+yZm/IPZHxAkrsG2w6EDP0?=
 =?us-ascii?Q?MjRi/Xd0yXTKEovp5xRBHRJq/rN3UAHt5WMoGqUzHEcXYN0+268vJe57BeBI?=
 =?us-ascii?Q?cF6BhKnFzxUnODI7yqjvK/tt4yhqZ4To96BB6xy5A8OTFdPqNOWqOItb0pyK?=
 =?us-ascii?Q?IH2yczHkBR9rhdfvPu/DwxvmnZ+hKOsxQRM/LWsjp85NR3yKqU//sz9BtrX3?=
 =?us-ascii?Q?aDw503cdJgIDTn2yKRQAVWoXK6fUtx3PFygCVo3PHgJr6i/e+YwENeu2QyQD?=
 =?us-ascii?Q?2GTcCXmz908uD25tgTr8lBL9ITGXTBEDt7Wb7lKVMfTRY0izkdyFWR4ML4Zx?=
 =?us-ascii?Q?wYWOXKBDXHXnEK5O3X4FVMjA7igi+nxy9+BdInL7FkeCFcm8Bq5FK/EsXuZC?=
 =?us-ascii?Q?ijkvu6Rassdn3NapQ6q2lZZ+2VglikYgS9KaeIbbCtauPbvGUZQ0gSZv0fC+?=
 =?us-ascii?Q?aIMopF2Fnvi9VyFz0LN16wP2lmKO1pvfW6jXMiNXhhmd3RATVBB15cWWX6OU?=
 =?us-ascii?Q?WJyh3Xou1sl33gvkMkf3iE9ACGnLLaC89UtcTUtwTV7RNF1/OR1XlfDVU+yV?=
 =?us-ascii?Q?h10qakGLtTVzGNioYVF8OIPR1/Ugx6zxgTh7g+22hw6g5tTW3L/Ce6ml11No?=
 =?us-ascii?Q?JvVJ2Rp1IgQR8VEFryOFCvie2af2D6mFSKZckkyt10ahAthPtE2XAqeXO2va?=
 =?us-ascii?Q?3YPX/7afaSZ8TlSrKX91ebqm2AwP7VcjnS0ZTBmQJgzwzJ09ooCB/JiBJxu7?=
 =?us-ascii?Q?hvwJOe8MCMXRywIRlnGn1WCci+4+/iJU2f41DRUe7kMASHP1GJQJWW2/jkNT?=
 =?us-ascii?Q?otg+n/HIlLnJaEc+Q66p10ppsPwq5Da2M7O9YkM96Mqzf++Vs3vrdiaBysta?=
 =?us-ascii?Q?LynBagZstopwwN8GhrojgvJ5wHcCO/kQMMnEqPCAmHqPRTJwYz7gpiPvcscI?=
 =?us-ascii?Q?6Q22oaiuREg7sF6XipVNehQhOef0PX/O0KVge+BjWm741uGu0PqVm95Z292R?=
 =?us-ascii?Q?RsCGOyBUQgpVpc/xnvkxtWiXdkpS4MPHKHUSUugJbPiEQwmH49dc5kQOq6yC?=
 =?us-ascii?Q?FcHj2mTca+2Ag8RjkT7MtYagkrewBg/ovXJlNTeMpieaWjRoTznkoJjOtE/8?=
 =?us-ascii?Q?uk94CtWybUS88a8z95sgRbz785hWqs42On88dCoh15F/nNYmiGwSliqF/ZWV?=
 =?us-ascii?Q?NidygOOjCUqtHVp8cVfisnVNFgYczbNeMbOdTo3JsR78P0w+pBjpW6nqh4Bk?=
 =?us-ascii?Q?uiOSGG0cpW1Nr/3trgGVqHzaT5bv9MnvUbO+FuMry+/adPTqXfe/ZdEIKaqJ?=
 =?us-ascii?Q?MdnajbW7M/r79Yb4miR9zWYHAgufOKhe09jg+DUMTv3/5tP2p7LhVKjL5MuD?=
 =?us-ascii?Q?gekCtJmTvlrguKblbNDLj5b1P3oUIQNDqcIC6TyA5JtMunVDNxhoIETJcYwn?=
 =?us-ascii?Q?F5yiZDRqWNwOKMXnSrF7ON8G35eO/kPs3HJ+EgEUm8gUJ+KsekT56UNLiUv9?=
 =?us-ascii?Q?t8cfy5TMyyrwteAuFab2hE4bxg1iTLDQJAJpcu0H88B5NFyrj2jlARNEedqo?=
 =?us-ascii?Q?ouIrbMemWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q8auVhiPZMONltXR9SZinE4Rr9HD4vhvA3RLPVrbLa6lzOR5+fSyRBnQ81um7ddCmOBFKak/LTUaTMxiu69dcDvycGwTl95ibqTFH5C31xpzTbV5zkfJlNV6Fh8wSM8ej93l5VGZq14su7+ViO+tQs8e4zPF7h0/KM26vWpVni5I/GcR4QRXeEAZLh0QmoWoxMCioStxjrB3E0+ZiTCjWAb+VS+ueMMB31qLy6sarEQgBW7zzPaqrFDHXHdD46sKMs34Kw7Eqv+chbD/uB564z8nOmt1oPIdPhZaRcpd5Xjs0a9rSvQLlRA5tbDTdaCA5W+/GyjdBFoMbdkj7lNuOw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d31265-4017-4a4e-508e-08dedb3ec6a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 09:13:00.0232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qd2NwR4vpU+zR134grsfKdxUYW7QrG0W/5vRhDMD1fpRs8sMNd2A+C6UkVG9OTeG+MZCC+WYk+yrSIV1U6tDR+2tvuhNpsjnnOEuK5PInuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304910-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xuanqiang.luo@linux.dev,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:joshua.a.hay@intel.com,m:tatyana.e.nikolova@intel.com,m:luoxuanqiang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B12D70E919

From: xuanqiang.luo@linux.dev <xuanqiang.luo@linux.dev>=20
Sent: Friday, July 3, 2026 12:42 PM

>From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
>idpf_vc_core_init() gets the LAN memory region layout before mapping the
>regions and allocating vport resources. Both layout paths allocate
>hw->lan_regs, but later error paths return without freeing it.
>
>idpf_vc_core_deinit() does not cover these paths because it returns unless
>IDPF_VC_CORE_INIT is set, and that bit is set only after core init
>succeeds.
>
>Free hw->lan_regs on the post-allocation error paths and clear the
>pointer and region count.
>
>Fixes: 6aa53e861c1a ("idpf: implement get LAN MMIO memory regions")
>Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>


Looks fine, thanks for the patch!

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

