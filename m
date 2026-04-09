Return-Path: <netdev+bounces-276835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDZkGVcg12naKwgAu9opvQ
	(envelope-from <netdev+bounces-276835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:43:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 644653C6101
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 697FD3004D19
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 03:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B8635F5F2;
	Thu,  9 Apr 2026 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7l4+6Fa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3848462
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775706192; cv=fail; b=TdJajO1o6FYgZyD/Fn8QpqZis0xDg6MSE0mqrzvPTtJw67uXAqHgrek/xoChPLpJN8nSh8TN3TeGU1Qr+bjJVak33qIwX1/UPocTqhsPhAVgNB77v9LBndGAcVnWOj5UCf+pHWY0E3iQBHXXWU2hboYY23Q4MIQ0+r6Pcy9GZ54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775706192; c=relaxed/simple;
	bh=iowBiyXNwEBg+IoGwZyeZDRaY+QC9Yv2lPpk7MYCVzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=APFAogdCjhY8z4fVXBWVoQPf0M7JyZV1V9xKcO/sXyyiv87xy3Rc/8tu+fDZXuotALBQ/sQkmX0qpF0msYOAN0mWvYPvRwF2rfnmffjCP/3MJjCsYhvzC0wIP/1fhkhveIYagwl+hMOLJIijsw/5tQtNZzU1NvN/FztRLzlgY3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7l4+6Fa; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775706191; x=1807242191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iowBiyXNwEBg+IoGwZyeZDRaY+QC9Yv2lPpk7MYCVzM=;
  b=b7l4+6FatA4eSXpMcbdhmp8UhnoLpRNEXOUHlvgYuVyiwdp0TcgEQmwN
   31HXvGZWLDcVFmT53r4LSsoh4J0Y7E9PG6mrLnFk/Zx/hpmiAkMTOhO3p
   yYSrqVEW8aYo2oqq1vXMrBrJZTB1Sud0Ex0ifDTdfpBfpd4RZp+6OG68w
   rl1Jbw2mwtVyazxuXU03sB6UnmHqaDWp0V2+/GBqfsEClChJzwLQthDpO
   yJIvPTw/BcCSwDKGwaO1qKvV7lUOZkquxOyppjH51lNUAV7AhOWgU3H+h
   /KGyrtjiX+RznPExqTVPOLkKocdny0M6V581xNqrPA/aOjlV+y1UkVpcy
   A==;
X-CSE-ConnectionGUID: EyouX9G5QXqwfQOW1wFgog==
X-CSE-MsgGUID: 8jxtu4fgQaWZIghG+3c+NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75874807"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="75874807"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 20:43:11 -0700
X-CSE-ConnectionGUID: kgjL2QWUQ9OnJjQqlZmdXQ==
X-CSE-MsgGUID: XgcYHov0QciWZZYi2YB+YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="228536095"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 20:43:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 20:43:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 20:43:10 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 20:43:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIiiJZ9e7h6SEebc7XAwpxdh+rnJIlf4GGTYla2P/tLhoEMrK1lyRDTDnlpJ7xVUGJ9vdkSXzyZDTC7S4KggfRzMg01XOMPlzc1deDRVlRYe1uq3UOgBQecyUJNmsQ0ikipSOGauK6jOFZ5yns4RHJPKDkbV3gDkoDFwFVgzJuRYGghWCZDmD8qq9enhvWYD2gpd4KMeGdazTBJo3s3Q3v/ppKeIrVFP8Q756rFKnosftdUhYbj2JHFAqdcoEtZNWB6hLi4uzmfZ7u6jS9i2C1BkjFz/fh8S/8mKLeholifk9AgiMpdeMSmTQOmXUKTmGffYMk/lEWKq7ioQr0uXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iowBiyXNwEBg+IoGwZyeZDRaY+QC9Yv2lPpk7MYCVzM=;
 b=OOnbwV3tg5Zpsds3jPR8I3+u+CbNQk/EbqlIk+TI+sGubj4SGFZQeJfeansvmYWrSvVRQiN72JBxZGNT5RgxhMrDAYWtbh3G0ZZ6qzeIJWCInLgURetWCa+Za/BCrrieb90Dw57eE+ptTXi2v90QBhL2B1IA1zsmh6oQKYLDgj7UyAaYir5co+J8GpuICKOSqbyyk/zq+GsGtRnh4aQ+GZkJvaVZLrC8VC3VHWDhCOLMnbDrltLhC6cYjZ1YC+BhaqE3QMiAMS7pkV05hgRq/Um48deGCuGx/1ngJNWwG+ATuOv6VkI+NkJWIDO3CQ6HZ0KNQQgaHJMwIK1e/UcI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DM3PPFCBDC4B878.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 03:43:01 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 03:43:01 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "Temerkhanov, Sergey"
	<sergey.temerkhanov@intel.com>, Simon Horman <horms@kernel.org>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH v1 iwl-net] ice: ptp: don't WARN when
 controlling PF is unavailable
Thread-Topic: [Intel-wired-lan] [PATCH v1 iwl-net] ice: ptp: don't WARN when
 controlling PF is unavailable
Thread-Index: AQHck4WhQKuwU7SVBU6M+jYhVN71brXWflmA
Date: Thu, 9 Apr 2026 03:43:00 +0000
Message-ID: <IA1PR11MB62412013EB2995D1661ABD718B582@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260201141430.131063-1-kohei@enjuk.jp>
In-Reply-To: <20260201141430.131063-1-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DM3PPFCBDC4B878:EE_
x-ms-office365-filtering-correlation-id: 4409433e-9883-44db-61cb-08de95ea1932
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 7DpK9qxwmn3zNx/IKTJvMz1/VzwbtGDdVn6XwGY31zfbVAb+Ex+2Y5MyPuzVvPVAQeM6vtj7o85p/SsEPZTWfFioCYS43PgKmo/5MmKDXzHAoNgjMans/HTEa3Y89BBR10H+5EefsG0lpYB/hWI768iIOk93tJpX15Rf6WH5KBOCgP2hNxmmRORK+VQShTkOSAsV6qYTB6/bQk5YS7IfJwMUAy/vszNeU/t5Chphzyxp0X/XKuG0Qtz15mmBDotZ8+L6OgnkBpnRc+hCwCNRIImGoMLRfLDcHRhqhwnHtvQ2PN87qVpS+bbtjIFaSc3kBzKGBfo0TqrAjpG+INsFHdEFCEk0CAIe3pauIUNwG6YJyL/jDntFmvJgTs3YHgo1Q2MIM98SSIgP+Ot9uCO+i4A9zHNMpNjFeT+OjqsHFnt7h9FDxqMr4sotz/51NKjBjBsNXaQDkC5h85Pz1tM5gyOR1f7q0wPFf3xvJOQgDu0j26hceCUIdeG56vM2ygp1g7Jyp2u9I9hD1dhXEaDbvnLOiPT70j0yXE5IccdrmF3QnYhI6ka7GPXbPmEIWAbOonPQXSPcGPMeokSPPNRkBZAiz1mfjTyYvZYt7moNoAVhNU7gm08LthpO9hAzfyPsN7TF6qdUDeHVdl/qdR0MCTI973kae2sshCe5WeBw2dGEn/Wj4wu+N+xy3I4Pdbb21nQCvPvOcX2+Ot1TC4hM5wgNZFJGfXniIvU9c3Dr7MY5BXEzFD5tevg6GS/g2oDgPtIxgI4VvVpnY2Ozts1RR3nvDrAPTgtMu5Ox8kDQaME=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PNtKb3GoxTZC5GLm+OQwJMFBPuWPPB/6o3R+pImaBQHDl1aY1NXSF3B5GkVL?=
 =?us-ascii?Q?mvFK6MhvjddGxuooN/hlG65hBvKTExFKDtV4ZAeMNW8tSW/zvF82RZ7qy+LG?=
 =?us-ascii?Q?56QmlZMH5NWhFadmsRPrcEmqmPoi11wqfAfU58u2ANriCUd7++SNddOxf1we?=
 =?us-ascii?Q?9rDqIdR6ccgnKxg6+jfxtqAm6ibzDtdHxxX0eziFgGyUcwurpoNWmeBqEGGg?=
 =?us-ascii?Q?0+m0a/J8C6r1yu6zJIOa3YPhdrnzVIW0gTtSl9Jr5/aD9t+IqP46zRPqOQag?=
 =?us-ascii?Q?aXYwfLwhxBw+YqjI6YRb1zspBhnzNxMJDbA8/Rx5jhkTtzXXfSZo3Mz5+8H6?=
 =?us-ascii?Q?tsN83egeT1eYa+2ovFV3ssjXjeAGqTNzbkRmNnQuiBXJ1Dnq3wd+5lcdl6ew?=
 =?us-ascii?Q?zan2OSj/3nAtg4WVdaU3l0rwvfgE4UUN3vqLSz/SsZFCVz77AD64wKiTA5PN?=
 =?us-ascii?Q?sqvSZmcnr3hdTan2nOHG/1tOd5Imh0PdqERL5ayRedM8e2ccamd2cr2fxqtK?=
 =?us-ascii?Q?F9mx5DgXezE4XGQlcJsuNbLowLW/7ILLW0U7Ey3MN6z/tj6wvea0YGceJ2Z7?=
 =?us-ascii?Q?ZWQNlGycjJLoGETAVACx5krqAp/eQdPUZ1gsjruCuaLVverV3B1t4CChb1De?=
 =?us-ascii?Q?OYcoF1Wsqirx6UAbgfFGMlrfyJ8c/uApxTLKeRyfYKDZ9HTlNsDhAOgXigIo?=
 =?us-ascii?Q?hl3ZqOgZsdLXqONjcoGH10P1iK1arRhMsFPyo7ENLKqQh6r7Zf/zigHPUkqC?=
 =?us-ascii?Q?wA0+RVKiavS7bg2cM4LkD9k9Up1nbf7/N2PEg5KmaJy7y8UpWz0wXoARxDox?=
 =?us-ascii?Q?NMowTKa5zqaf4PeldKtWz52NnyiPJl/uJFSC1GpSEjHo9BNba1hEo0tZZihr?=
 =?us-ascii?Q?4XaSyzqh5PqVv8PGysZl44pF7otsl2pYfD1KHGtN8YcO02YfYUbipndoEiFK?=
 =?us-ascii?Q?SYa+gpnnr3ejeLUJ2Ydp87DSpWnlfsqODYEBKtExF1YK92MM+ckUn6MegR+4?=
 =?us-ascii?Q?mmg7XawML6Xzq8ByC7GI/SdjRRN4+ncyJ62VVLV6vll5t2X6YH6xz6TEB52I?=
 =?us-ascii?Q?aI5PMXaE/cXD1axlKzfPXjGbuOZOR9roMeDz4ivkCqFwVg4AF+mruHyy+cxZ?=
 =?us-ascii?Q?UXDDzwSFzZw3oXCCWvlVRTTeUA6yvvyTtZaFPFX59KGGskPwozt0qggk9TCA?=
 =?us-ascii?Q?wKLTLeEPsjU1t/T4XE8si/DZYqO/NkfaMw7TnQamli8D7qj2Jz7T9yohHwCE?=
 =?us-ascii?Q?4forANKgI7xp1fQsesgK4puHv07t6Ze8XEFIWnIv/2cWA1gg3sDnAA1x5jcP?=
 =?us-ascii?Q?JmyiEhps1KaP7jGZ/4WOz384nXaQ9Q2YtNopdJyjVNyQjUSCF8vi2b58uVvf?=
 =?us-ascii?Q?kzZ7sspPb1pMbGAJ5DNKH50oHCULZ5fhoztNuowzQDSYjaO/Wt0HvYg1rDJL?=
 =?us-ascii?Q?xEB2jKcN5UJTbFVm159zHunMwoEO53mV2KUcXTIDiEFPmKUJ1Xl8oaNZZ+IJ?=
 =?us-ascii?Q?WLSKk4jIrRNfMCQRxM+BvNzgdZc7TQOO49YwyiqMznzKPThnqjQP3esgVL4x?=
 =?us-ascii?Q?4wBiAbADxBALjp5G1VjQVeghFeFlQndssIt4WuLtpbdjSYes5pO8gGF88Nff?=
 =?us-ascii?Q?u1NfTnpm4nE5K8MMNG546eM9jJO38awLmZZDyocaEVgSCpsWpYivVQJobI41?=
 =?us-ascii?Q?DmaUrFQFm3DzAm1rzPmNoPnfQBmOuazN+9lIfz8KkhqhsNcd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hvhXNtEuUtf35NIz2z3Rmhno8AkQ+UWb4XhSiQKuYQ+Qt5NJJHimZeCAnAeCtO8n1jWj8mHSt4sXV0TJxKb/cI+glBPfpY9GNGkxb+tTttNcvc4jf06RCwdfExE6rj2m3iRWZT9I6ny4UHDEbdxKZtxb69oCL9ATyrzv2xnhV5tvbEbX3pEnXxZIvgQyrD/39MlelcQbTJ4awlf2ccxucgwqh65ABmZ3BuVw2l3ZoIOTpnl1EWVx5L9OgeoTAJ+hxFbWq4KHwzyD79lolZ8HgAz89NkbeG6kZGw7qNi6XVHd+h4HLoea0LrNfmTAxf9Xys5zOcvnWpsz4M44631XEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4409433e-9883-44db-61cb-08de95ea1932
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 03:43:01.0329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAVK8SyCv+rt06XWahz4h1RqK9CamLl0SPEx5b5SO7en+tCouFnmM/pONk87RDlkG3LWuJr2g5Z0Pxf6o5zAGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCBDC4B878
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276835-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 644653C6101
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
ohei Enju
> Sent: 01 February 2026 19:44
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Richard Cochran=
 <richardcochran@gmail.com>; Temerkhanov, Sergey <sergey.temerkhanov@intel.=
com>; Simon Horman <horms@kernel.org>; kohei.enju@gmail.com; Kohei Enju <ko=
hei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH v1 iwl-net] ice: ptp: don't WARN when c=
ontrolling PF is unavailable
>
> In VFIO passthrough setups, it is possible to pass through only a PF whic=
h doesn't own the source timer. In that case the PTP controlling PF
> (adapter->ctrl_pf) is never initialized in the VM, so ice_get_ctrl_ptp() =
returns NULL and triggers WARN_ON() in ice_ptp_setup_pf().
>
> Since this is an expected behavior in that configuration, replace
> WARN_ON() with an informational message and return -EOPNOTSUPP.
>
> Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of=
 auxdev")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> drivers/net/ethernet/intel/ice/ice_ptp.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

