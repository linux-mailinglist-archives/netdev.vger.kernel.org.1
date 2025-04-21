Return-Path: <netdev+bounces-184403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954CCA953D4
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 18:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B314F3AF4B0
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F4E19F12D;
	Mon, 21 Apr 2025 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHndDwuf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE714883F
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745251672; cv=fail; b=rpYJa0S5mID5DLTQXYwaPzOa5dhgA/sPLNNbfa9KmcHClBsVtzqS91cytwa0OasErIIN3rgQ3dQfx9aOkI0DEh3KzzhK4XV98A4758Pg35mpIR2wlWXyXbYzWpcgSi1ClTxZgkKh+sru+HNgsjgVZ+YrBfXL3ZUdOvzydqsIOQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745251672; c=relaxed/simple;
	bh=paJiqbvVqEftH6aOkc8LXvaLWvGIAuTSNT5louF5iF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jl/ufx9FMprum865ocKPi2eQ11yrn55OoelDQmjPSxmVoj3pY0nw2recYbqZnCXFHFn3LKUZMbGPq4pGWF8vZeYKSmdZxl/P+qhrh4MOENYRxZvzYPrW+1x5TjXc205Bo7UOPP4O3NGeUiQCWwEREmcy50RQJ50/6tdciMC+cAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHndDwuf; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745251670; x=1776787670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=paJiqbvVqEftH6aOkc8LXvaLWvGIAuTSNT5louF5iF0=;
  b=ZHndDwufWny7ycGtveLbUFIhCnVZx6hnpjtSvrsjnFvxGGkG0Z+w+Hdk
   S0toDsv0uADNfuL3kUX1WzZ93CoUkbzv0pBogQ+thypQ44+iV7ADDyT8L
   pY/wy4mIIN3vIZWt0KdCOvt0rh3V89Zd7HTE07mStn8k01RspsnhRgntj
   9FWszj9C7xRWo39yy/9sH69EfnPhfJaqqnPDrdgZaeqTJ6UXEdDEjr2WP
   2T+nK0qYScmFVXtJeriyAgYNS/xbvdQ7wGoEgpnkoUDwj+Rgf3TabVB36
   rMhwgeeX2ALBI9HNMCpP4sioXwoQVapqeBmQiAcTPmDUnlaCzqVarzu3/
   g==;
X-CSE-ConnectionGUID: qwaUWJ9qRAWhGT04vS7B6g==
X-CSE-MsgGUID: 8LMXFnQZTeyxxGEx+LszEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46907206"
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="46907206"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 09:07:49 -0700
X-CSE-ConnectionGUID: k1VsW235TmS5VBHZYG2xcQ==
X-CSE-MsgGUID: 1m6Lze1hSmC9F759dCFwiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="136909900"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 09:07:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 09:07:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 09:07:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 09:07:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOsLOBAaCx48I5bGfrCs3nefZOT+fpk35DLvtoTpaE0rCEvmb8mdRG8qyw+kD5bOtUDuWF1TkEnxLwNWywcRA9qifSDhZYV15P8YzxDa8nvmBt35DxzlvznUZSy3HIsE3e21dXO/eIup5Uj0udpGaauryvdeDyDXSaDSVbXUaYWI39f+2V5CbDcI+dM1jl6JgjCj/EMZRBJI1cV30A419LNFH5NH7ck2djjAai8WSMafNCLbTcypA5eAfyFsJrXRpGVKogMUdFFrzXVYh7NYX3LUebh8UHqXk/+FGTjFMDmjfEmmFNgojGL/3VCycozNZP36M6UiUSKUGmGA3hXlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6Olcf59mYddafMpeuHzGlXh6U/z6/CHYJjLQx9Io1Q=;
 b=l10gQPj0WhhscH5OJJ9/wfzfrExeo1Uir80Ww0wlr5tpbAlpRj+LuwHacTE3s7SJdJVY2pgvRfpH1CKFSH2woUXp70xhhEtc+cp8ADvXmaxoPqWPelC7USGxK7G+o0AbySFOVVDVvL4FWb7b5w7FZYoQ6xBOVJPf1dxAWkLHTwJ9kyRNUc30eRyRd8Zen201x6S/+WqzwRWLC0qsQk94Dxpl6T/xHvIwy6OfQXLkRqys60Uiq9ShOGf7Jr+cZgS5k4FHb2wae9qq3xMw3kaqK30tyjUDK5rWGNrzvGNDZS0hdYSfylkLue/m8DLfeRNrvLfiJ/RF2yUdbQPER/BJxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB6868.namprd11.prod.outlook.com (2603:10b6:930:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Mon, 21 Apr
 2025 16:07:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Mon, 21 Apr 2025
 16:07:40 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Dumazet, Eric"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>
Subject: RE: [PATCH net-next] tools: ynl: add missing header deps
Thread-Topic: [PATCH net-next] tools: ynl: add missing header deps
Thread-Index: AQHbsLyg2Bs46uKqh0uWYXDI6VpUIbOuTXsQ
Date: Mon, 21 Apr 2025 16:07:40 +0000
Message-ID: <CO1PR11MB5089387D08C5328368444BA6D6B82@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250418234942.2344036-1-kuba@kernel.org>
In-Reply-To: <20250418234942.2344036-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CY8PR11MB6868:EE_
x-ms-office365-filtering-correlation-id: 36fc1c37-7626-4b46-8515-08dd80eea4a7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kL6KhP0V/Ui+UsxD2wVWf6k2TiFrYx7A31ENB8LwRO4KWAPeA5/LTOrv860c?=
 =?us-ascii?Q?2RbeALWU10I5Kj1hkty8ZglBcXzoE/i8BTU0cjM+EJAg3BXUhOyLky/H2ofD?=
 =?us-ascii?Q?Tq/lpfWyaFfCQ0Kz0+yuoprQYZkrNcRAdQOptoZnM87yRfcT9DF9qACqUysA?=
 =?us-ascii?Q?3keGzbI17GG+/DdMLcPl51R8sM9gMOrm/xHAwBeTjkfy6F0DmaH0E8XpOKVm?=
 =?us-ascii?Q?ESR8xuqw7asbRlsSQTFHcx/JLCA2pHynOsqPPBXwGnzC2oH3C2mdVEoPavKs?=
 =?us-ascii?Q?LdjQqy+/py8j3SiRAzU+QIklIbXij1debxdBxWx/S5Nz5+mh7V7JIlr/R34O?=
 =?us-ascii?Q?yQ+qvJY1a0KYs0J7gMXOMjn9Dk71s+Ga21ORUwVTVrdPd4czZkTJwHnCUK+t?=
 =?us-ascii?Q?X40b33iOzg1k/yroYUOiS+1UhpegA/B98BE+SmJYGV2QJmmFKcdo9/Gifq5i?=
 =?us-ascii?Q?W9F41siykSt+Wif8JbST4hpSYFW5AONfe/MiFqJ/ESxRY+PLnpauNGb7O80a?=
 =?us-ascii?Q?k8Y8MzDWp2EhGRO1ehSNJVvBndJHLHI2SyfJLOZU+v+BCY2xF3M7B3FFuPsk?=
 =?us-ascii?Q?cziq41JqJRXWtVcY3TEZupwqHnDCj5dkg4g+wUIqXYa9TTKbfaTa0K6PkRT/?=
 =?us-ascii?Q?pNUBAurnujuWOcFRkx/genEoNvTIfrwgVm92QQ7LXcNhRjTzhNQXJyZy6pGj?=
 =?us-ascii?Q?NuUywQghY3VZM0rLCRv+2fzdpT7zh3VHCimzYYv+Tyn02hjqpeI1KOKOUVhi?=
 =?us-ascii?Q?BtMk1JUQ26TQUhoNx0dmQ+6k+y/HeJB3hg3sNCf7qnTDBQa6aaF5wd+J/I4A?=
 =?us-ascii?Q?+ByhcfyKbnYJ/wNaU4QeaLMysDILL/6kb8sCKdgDJN124HNK7vtvAj/LaO8G?=
 =?us-ascii?Q?6RNGqvV9iK0Wu8u9xn3A0G5g8GUbcq/K6XrY65Zaka+rtznTCh5PrjAnD1qA?=
 =?us-ascii?Q?ykFjmyrzxwRhZh8ocr1RCap2Hx8UTN3hBtyw2kmgr3g3escPus9RzS1bOm4l?=
 =?us-ascii?Q?3bGqiYdOE8uqnvkESb/7dEohMUmxT+HkSOsX4Z6BFDjIGwIJeOUT7l9LewTG?=
 =?us-ascii?Q?HsX+U5GuaOxKq4CVdk3H/YSX12QXvBDmtO6itWfpt6lZuXOf/6RxC7ozdbvf?=
 =?us-ascii?Q?lFXN3YE8R8v+EOEhRykg/liEOM+dWLyLqlSgqnw+JYHoIyu4erzSUiv5iufn?=
 =?us-ascii?Q?a754x9ik/3nEjBbQY2syBrBDX0OQ8ymxNmBR3vsxQtBynSTHXGfSiV2Bh5KB?=
 =?us-ascii?Q?yfYp5WMp6A2rcpWjqV6Y3rnCZjFdI7MYemkHS5DlfZk3ehFz+hmo99JYTmFX?=
 =?us-ascii?Q?2ZEbGkNGaz9mL+GOJPyzXnc9cfiPLzIZx39l+r8P2TOceCs3WgXDv7XSQoOL?=
 =?us-ascii?Q?LA9639vKpMfv4k4T+ghjhQOdDyrX4zTOpDqYJfZoB8S1dDNwppGoeI0mvf/U?=
 =?us-ascii?Q?ajBCwZuGIw6xIeDNrC+K264sJXyQK/C2Gu/89deLBVsKnQJ1wDJhNgtcLimC?=
 =?us-ascii?Q?gYxGMOxK880kP/Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3aSdGVFOBI9sPKXgA1l2OGbFgzXsJBe/fhD8AeKp/9BiwxpU59cC5ilEUzKx?=
 =?us-ascii?Q?rpSHbHNqNh/Z6ri6euvG1FjxjQ1V5hG0x1VRtjtw/LhEWrZmafj3lHzcejMi?=
 =?us-ascii?Q?Qaz29muQIqA0sByFZQEoZSIi6fiShe/RKwpsEy6c/H05xuQhERdpPJBEU70C?=
 =?us-ascii?Q?we2//zm0xBHac6oVjVJi+CAe4iK+K2yKpjp47IauWkF+qc84WP/hSwc4HPcI?=
 =?us-ascii?Q?Vy/taQi2jvbGQsw0zlFy2ncLH3LcWAyLG1i7PzNm/ntJh1YhhQ6o1OFsCUAo?=
 =?us-ascii?Q?pQJjby3kLMIu06NVHOAW4fWGImfdyCgClOvogid2DpzwHJy6E+/aK5PreEa6?=
 =?us-ascii?Q?H2C4jHl2/aLQj5zj1U8VAa63AfVWY8CQoIy+pJuP17+X4F6CA+UvUhriDGgq?=
 =?us-ascii?Q?KFp+UcalF/gXdXhXkR9Z09HfuaqBURT86spDcqAzteu4wRejmFSokNGjV0+x?=
 =?us-ascii?Q?AXQz1w8N+4jmpEqDuhSp2Mu3ItiVpXhfmztP4nhqAXlCX04nFGKz4ZIuemrI?=
 =?us-ascii?Q?h5H36T4D+xFE1z6JyZYUfp1vZ04OG+KzW2688FcY8c/vbtTeSOxBMpPBwQRC?=
 =?us-ascii?Q?1BChsvXgYc2PZcHonep3EmEL7Dq5Ek041qu6NRwkEnSvgwzWdwCeeDTmmTBZ?=
 =?us-ascii?Q?+/riMDmVrdv5aVseCFYLbHsUZiBxhcLqhpr86SjsNC5EhCS/HVpWz7dNCqal?=
 =?us-ascii?Q?0ys8hH4aJ457PEML4US8bmeRbfrqxTooZJUycGa6markhIDc/rV83f7Hfxo1?=
 =?us-ascii?Q?WU5i77oTPpHIIT0LnuRKcuNHYQOR2dNAyWJWHSMIypPjfdq5+tnBy0EkshtB?=
 =?us-ascii?Q?exgk2VyPL3ZqDJuy9Y9OdXmLoAXjDuvPhk7PocbvF4V+84ECgUyKD/QSoXD9?=
 =?us-ascii?Q?6a+qB5wZ8YiO3EYoOjQ4U9jh+MAdyXN7MMl6V7KjO8zTGyRmgqPrQSbO4roy?=
 =?us-ascii?Q?/LgQ0DqdTh/mjBIoggLEask2u2eaNjzxCq1Bs0xDYbxC4cEV0c+l2aOhAwxU?=
 =?us-ascii?Q?aT1VtPuGtR22ln/8WmkMqxAu69bLzDFkITLvmdEkpXMqLahbUOQtLKMkn/Z2?=
 =?us-ascii?Q?Cdpyy3JpQMT8nYFLU52jM6m5v2sB9O6V3TWgs44ujzQur+N8o3wrvTR/bmQp?=
 =?us-ascii?Q?SW6RfGajTS3FgJsa5sDGEas0TgD7padJeTLNSSa0aun6ASoD0IyhVOINTfdT?=
 =?us-ascii?Q?3R1QjuF8e4KdRcBctQUPkRhOUe/j7JgQ/D7oN5eHed0uEWRhhV8lZVCpYLqz?=
 =?us-ascii?Q?yGM7Ij1M/CRQcWG8IAyafdP1KlyM+auxNVlMPFdeH1IXUTDewdKgGMeXBuP1?=
 =?us-ascii?Q?SE/Bd26dNO+ZBNugJT+krohs5UBepSDSBJB7FNcm/Jxelr8CL2sFTLd7UI7G?=
 =?us-ascii?Q?IGny3D73pwT5S3YUAnbs6G0TQsYcQktlEtJ+nb5PUcvaq2vg9J+D5NX2M73G?=
 =?us-ascii?Q?lMv26yt9czRK0gz97t8FgBvI3u3bzaz1KaageoiPFj/aZMcbrXpR5UezMiTm?=
 =?us-ascii?Q?AryROlbQpD9lbujCKUgV91hP9mYquXfdu8P7sszLV/5f07JRzbAzRuqXGoQF?=
 =?us-ascii?Q?3CAB3j+KMNv8+QSLRnApNccVY6RUY447rixXgxzi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fc1c37-7626-4b46-8515-08dd80eea4a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 16:07:40.9331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kJa4YcKSnoZCs04rMGW0eGTY9LDOGoazt/t26q4voXID8upC5YsBmcFv5hil/lZsS7xeTAuM4579URMnLpuo9DgWnda5Cyg3g7y8ekXY1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6868
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, April 18, 2025 4:50 PM
> To: davem@davemloft.net
> Cc: netdev@vger.kernel.org; Dumazet, Eric <edumazet@google.com>;
> pabeni@redhat.com; andrew+netdev@lunn.ch; horms@kernel.org; Jakub
> Kicinski <kuba@kernel.org>; Kory Maincent <kory.maincent@bootlin.com>;
> donald.hunter@gmail.com; Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [PATCH net-next] tools: ynl: add missing header deps
>=20
> Various new families and my recent work on rtnetlink missed
> adding dependencies on C headers. If the system headers are
> up to date or don't include a given header at all this doesn't
> make a difference. But if the system headers are in place but
> stale - compilation will break.
>=20
> Reported-by: Kory Maincent <kory.maincent@bootlin.com>
> Fixes: 29d34a4d785b ("tools: ynl: generate code for rt-addr and add a sam=
ple")
> Link: https://lore.kernel.org/20250418190431.69c10431@kmaincent-XPS-13-73=
90
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jacob.e.keller@intel.com
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  tools/net/ynl/Makefile.deps | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> index 385783489f84..8b7bf673b686 100644
> --- a/tools/net/ynl/Makefile.deps
> +++ b/tools/net/ynl/Makefile.deps
> @@ -20,15 +20,18 @@ CFLAGS_ethtool:=3D$(call
> get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
>  	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \
>  	$(call
> get_hdr_inc,_LINUX_ETHTOOL_NETLINK_GENERATED_H,ethtool_netlink_generate
> d.h)
>  CFLAGS_handshake:=3D$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
> +CFLAGS_lockd_netlink:=3D$(call
> get_hdr_inc,_LINUX_LOCKD_NETLINK_H,lockd_netlink.h)
>  CFLAGS_mptcp_pm:=3D$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
>  CFLAGS_net_shaper:=3D$(call get_hdr_inc,_LINUX_NET_SHAPER_H,net_shaper.h=
)
>  CFLAGS_netdev:=3D$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
>  CFLAGS_nl80211:=3D$(call get_hdr_inc,__LINUX_NL802121_H,nl80211.h)
>  CFLAGS_nlctrl:=3D$(call get_hdr_inc,__LINUX_GENERIC_NETLINK_H,genetlink.=
h)
>  CFLAGS_nfsd:=3D$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
> +CFLAGS_ovpn:=3D$(call get_hdr_inc,_LINUX_OVPN,ovpn.h)
>  CFLAGS_ovs_datapath:=3D$(call
> get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
>  CFLAGS_ovs_flow:=3D$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.=
h)
>  CFLAGS_ovs_vport:=3D$(call
> get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
> -CFLAGS_rt-addr:=3D$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
> +CFLAGS_rt-addr:=3D$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
> +	$(call get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h)
>  CFLAGS_rt-route:=3D$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
>  CFLAGS_tcp_metrics:=3D$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metric=
s.h)
> --
> 2.49.0


