Return-Path: <netdev+bounces-141512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE39BB2E4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6ABCB23023
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A81C1AC7;
	Mon,  4 Nov 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mA9dQeXn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715241D0F63
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718339; cv=fail; b=CEWby8fGj++Ruvz+u41fdiNW2b4W8TPNx7+6e22h7r2TIMugkjdlRkcORLzsRD0kcUkBo8fQmb4tDC5Qu+unNjjFEDLDOVeKZBZADMpLqIfoCQhjdIe1pKLdshFI6XmSWgjjeDN6rS0S7yGRsArDvVbHF/sziJSxZsQq5EmNq7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718339; c=relaxed/simple;
	bh=rTTuz4I4Vl9S8fL5tjFbNLXhl4IAtnnsxqtuDNd6KgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RkzEr2X6mFAkDrDLds8F+C9GBdCYT5GqVaBg1gWgwWRW61Y2gnZiinOUlaJ53qI6ya9w3PVOOecjeeD0/SO68t+Mq5y5AigKmxi8jjBvE6ug4plc3J2QWZeKd1hdKpfxuKi+A3ZQuSlWHA4RjcXrX4i+JPnD0oZrHWCmOQOkWtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mA9dQeXn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730718338; x=1762254338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rTTuz4I4Vl9S8fL5tjFbNLXhl4IAtnnsxqtuDNd6KgI=;
  b=mA9dQeXniCOMqSFpdvW/M8/m4WWRmylmWdifykZSCYSPFAj1q5XcZgi0
   5nirBuXbzCMBj+o6kpk6qtfHHrKVE96GhfdFSN5kW2cNnIjby/UQ0zFxC
   HFTe4TfIm1OeJQPuTZf/Xjkor+nhAOCsreQIW+0wqEApsJbYcPZPjE39s
   tzvU04LZz/wbhPuoa8EuoE+NyribQBscEBA751Ag5KOMxuzBEttZHWmrr
   wWoccx6LRRK8fCKVnCesyWI/Z7qYwYFTtv2QltLxXfFBTvvKJmB5bANqh
   /CLF7GXbhA/9y8CNh85YD8s7qhmsdS0UbF3ZvF0bMsGZBX6hwvnTadWov
   w==;
X-CSE-ConnectionGUID: kBgwsMghSui78Ij5WlY2fA==
X-CSE-MsgGUID: jVZPXkoSTgCnt6u5A+FYfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30586632"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30586632"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 03:05:36 -0800
X-CSE-ConnectionGUID: FsgEthQRRnC82NNBXhGKLA==
X-CSE-MsgGUID: ZJd+s4WtTcymbWzwoSRIoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114408017"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 03:05:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 03:05:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 03:05:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 03:05:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWiAsS0hRXnXHS2JWynQebPTpMYPUn6V/AyUjffgFwuO1bQjbAXapk8NC/UFqMagIcEvvrbxOBQ/ZTMhWrMLR8VtShM9UXNHals9lqpEG7MPhPJcxeh3fGIPNcAVBjJGRVgOydG0Vf27XO/kfHcamBDjtQ5HPgZG9PwJ8sVehoPDcBXeCtYcnoHlPGXEgaa//O+p1O9c0bYlpfCJuPq9s4COB5CN2vSHHYiY09GbW0C8XAPUD+kaf2WYvl0Img9KYzZZVxXZv2Pns7hOpIiZXlxhGH12b4DhaN9i/CRxcgNW2LoBM8HZ534dXUj65+edMit9rp7JCJjryLYj9l0tmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBK6/oeIHnS8fN7m3JCIUeFoO4c/isZirSURjXJ47NM=;
 b=nhJzNPHcI0uGqVExAg8pDfKrUMYstdkupgUqdTlmyU8v2AlLb+zqCSVlbpvh3gVBqWTI2Z/pwaijgtMp0Ky84IMh0yOa17lUSTQ4rUSN+Ya4G5zH3UhoYqyHIGAXCdtOQUyuCtbExbA9tu6DsC0TQTZA+j30D4Cm14bnLX+/5UJyyY0XpsljCHpQJTEsatIS6J+aOjrM2EiSmaqKa36LIbCA7ZINY1vwO3bMqxbh5pcSW65YLgubmURhqNPs6k+2OHIurT3s7LNVD4fkjaKazThc8+0HiBK5FPga6EirtZepepfnHS02r9yEJTOTogI6nJ5bnRX6tN/q8g0e30RfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by CY8PR11MB7082.namprd11.prod.outlook.com (2603:10b6:930:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 11:05:33 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 11:05:33 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Simon Horman <horms@kernel.org>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v12 13/14] iavf: handle set and
 get timestamps ops
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v12 13/14] iavf: handle set
 and get timestamps ops
Thread-Index: AQHbJEU+TutAFeHMREyI0vcY0D215rKnClRw
Date: Mon, 4 Nov 2024 11:05:33 +0000
Message-ID: <SJ0PR11MB5865EBF8088F6098BD3E77C08F512@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20241022114121.61284-1-mateusz.polchlopek@intel.com>
 <20241022114121.61284-14-mateusz.polchlopek@intel.com>
In-Reply-To: <20241022114121.61284-14-mateusz.polchlopek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|CY8PR11MB7082:EE_
x-ms-office365-filtering-correlation-id: d80c1fab-39a7-48b9-8c09-08dcfcc09a69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YI+IykJ6DiwUSQXDwfULkP+qv5Ae7Z0W4/Qt3a3fABsV3untAZMiyQJOhrI2?=
 =?us-ascii?Q?CleKOH+Z050tJN2e2bycvUyzIqotrtjQTKMdepGlhRmVOEb6rc8pT4b51H/P?=
 =?us-ascii?Q?P8iZw91J7C26H7rQE4iqJDFdlK2Rfn2esa6Jw7Ka+f3aIFDKgwdsoLsmQrsv?=
 =?us-ascii?Q?XA5FHFa7yB6JKdyRRwdqrXpQ/xDjCMASMT5+Mg4qdMitsvb/MZBA9fwpACHh?=
 =?us-ascii?Q?U7QcfN//+CyA/nmSFmsxvdWxia7PnRO8B6QKa1zQF0VUO+BZyJDnaOHXPg42?=
 =?us-ascii?Q?cVruB7cwHkOmpB10oJ/V3eqxc8JQ8LYOivDjylAG/wMobxaR2FlLa2K1C65f?=
 =?us-ascii?Q?eZ1kSom5Wgn1umHapGauY2HFpP1Xk0VFZQg/tDZG+mg17x4f4YM1hBbc+Jcs?=
 =?us-ascii?Q?HDNq+uA+rdxUyrJy+O/ikfApXLVG53Y2RIdkhxAZzvud0+dCvuegObkCKdOg?=
 =?us-ascii?Q?POJ2oWZ/J5fweB9Yv02UVAr0MrvjboNX6cwfXO5t3J8b2LtKmR0A/8s32XWs?=
 =?us-ascii?Q?HzwkGAyjGfmGPeYxnpjuVra8I5l3Fxe4/QLeCgDmWP1ZO7yTt3g63IQ352au?=
 =?us-ascii?Q?QXxSb0oEIlZBdS+cGxE35SKHPmJbly/Gd5mwVYxN3ioNxX2RFF4OKB3E4omR?=
 =?us-ascii?Q?H6ESYaiTPpP/WJi9corgaQ46UXU/3G/NhCL9SnKDdqRehbr2T69ha9jTiWSK?=
 =?us-ascii?Q?NpS0ZUC01ABeBbuNg1n9FLlTQs8XO9vjrpvWTI+slyc0PSzEp+YX17078nfa?=
 =?us-ascii?Q?Kcu7Lq+HJsLbeivpRjrPGghfFPoOD7ykXU80rezsIDxW9YQy1MGiGVp/coVj?=
 =?us-ascii?Q?ASOHGfiAnGBrUOMdXjZeUjBkprG7wrYq90lqbTDIBQh5luHHM2vRn56babCm?=
 =?us-ascii?Q?+7WUT7tE0m5PYZwDdfzasRN4EM9ss1JAxj7EwHR4YztMeigG8V5tk9111hRn?=
 =?us-ascii?Q?TXO86zKfiZE6LNgGQt9ePFCjnq+3rpJ8MCRliMz7lStpxV/Lzz4Yve0Glu8n?=
 =?us-ascii?Q?zGNHAvQV85AkuyDoNc+HTZ4M0phwqYy0MuJmrJUeetRqgLAfhDGaLzOQP110?=
 =?us-ascii?Q?8DGJmCsNwTcLe1/QQQy4ZlAkFiNikh0hP4/+Kxm9jhloNQ4k6TanifaGy6Aa?=
 =?us-ascii?Q?ApHSujh2aRl5evP2GFrzG+/bgM3pnAVIQ5rsWQa2oQN6pvE8TuJatvjccfbi?=
 =?us-ascii?Q?ooBqfAmVhZM/Wfxss/i/ivLse2ifWewB4GlXu9o/YdpeCaX6Zyn4amtW6fq1?=
 =?us-ascii?Q?5AdQhE6PqIx03AMrCJICDDDficnIyYci7FZ3PShv6ET3Xqk5N6PsqXaDUe3C?=
 =?us-ascii?Q?D1lEAEs9Cl9RRW/yYTEjAKVScZ7nGt6aEFJQCtAxzE66wCwB5sZPZafaHibh?=
 =?us-ascii?Q?+0zR6oI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vyClK/QAYpWctLAkaqghHr78OPy8IaM5J5OcScxXz1tCoQkVfNjxBqMxZz9+?=
 =?us-ascii?Q?57dim9hriTVQVEY57kr/uTvy+zLq9aiOIdhA3vbjd2n3vvS1dRIXDAy7Lkhv?=
 =?us-ascii?Q?v6626SXMtViHbQmF2Zl157Fu07vsmb6X2ZtqS/Ypn5HMGNWK1Olg3KYh/7VH?=
 =?us-ascii?Q?VyJ88dKAa86m0znbdeE+4QAxzB9LgbVopjlsAvwDMziyV9luGAGZThzGHzla?=
 =?us-ascii?Q?LlVmUkkzBScPwe5uwGhyd+uZIbPB+Rzd7paD2s8AVHWmYIztnm7/NtvSQl7E?=
 =?us-ascii?Q?wqT7WDz+lqa+/t+jPXKmyTfGjD0VH1Fz06e5CpcXAWZ/oRH7xjwqHeKd5LgZ?=
 =?us-ascii?Q?DgitcFuhg7laTvqxk+s7Ef6deQl5n3HAGigZaM2DmPBDJRqNiREQ7EN3n/uy?=
 =?us-ascii?Q?9pVtNYI0F8t7Q4MQdWxWFP9QiDa2Tf+YWxRQ6FU73VwsXoTkQqkv740EhO+T?=
 =?us-ascii?Q?du10Hh6PzEowGxPuajsKP10fvN0G6jWGXgF43L8hgaHoR/Zu+5Kmrs5lMGdQ?=
 =?us-ascii?Q?EcUPyPKMhK6IuTOr43o/wm5m41a9gVdVNXndXhTB5d3D1YBCZgNEKBSsBlRb?=
 =?us-ascii?Q?74nC4LUXKHtndTmPW6AE1RTRg9zJ3whdMw7gOSeigyOuruUhAOuPy7RP8Cg8?=
 =?us-ascii?Q?vGAijJsSsV/G8HG5lfgO3dza0G5HC0zcPvVP7u5X+Q/9VX45JDHD5dxvL4B3?=
 =?us-ascii?Q?VmREmQLS4IqTe4KfZz65+KRyUvkzgcx9PK96JmLcfqWgYp3IrxEaB7UNUlwG?=
 =?us-ascii?Q?WcwrBMarO8DQZEMwrtT7vMkxhHWzLX43tM1UHLHsKgqrTMxJAIa9r2dkuAXT?=
 =?us-ascii?Q?FE8U3wwK/6PoAj641z5w5WWK41O8I8AUU+GujCO/8xtLJxmQeDfW4qudlvnu?=
 =?us-ascii?Q?nkeGE2+el15GaxvIYOc3yNiK2y6XaWtrGJGxf9kzXwzO3/5CK2U8tbKEBx3z?=
 =?us-ascii?Q?I0WicJyYw6K8xTLQFOHXoEIl24Yct7mqFp1h36j2GK0GUSBbxL1X4i6XinwA?=
 =?us-ascii?Q?4Dbg6OURAjWfCaBRDHRjPQ5P2bh9FFHYxeykRWFIseEnkQzZwXNqTGB2N+OA?=
 =?us-ascii?Q?7Zn92htNIUI3/3NwqXRYnOz74WM2FCn2r/IwEAuHdMxLecFkFi882+DZ3WON?=
 =?us-ascii?Q?rSR3oZVtwVRfEcw8TZUoitboSDq1+vT3NUqtOfgTcCVayNMwSYib7fDDjlnE?=
 =?us-ascii?Q?nkyMWme141CvSYoWE175nTL9HLIITy9GoBsbqBRPmGRYSdmEq5JN1qOUYmkY?=
 =?us-ascii?Q?fltJCRW2ms00Bqt8D1iw7IA4OAiXxy/TAgMLSjeOhzu64MPNvAM2VEGDODN9?=
 =?us-ascii?Q?wZBrqyAD6q86qd0apZum13jFDFGRQlja9sBjNpmgQfYzkFoerZplaXXmMNjW?=
 =?us-ascii?Q?JvmuZ4WeLWsLWX0elb2PsBFIdZWgVGD+XPU+VzVDTh+Li9OkZeoFIH0b5iUC?=
 =?us-ascii?Q?cUs6Ce3fpUP0PECARZe6PG/5vzV0TIEYILcq7Mek82+E4DT8uMdEHwsRwpvM?=
 =?us-ascii?Q?/enFGR6x1EhgZN0DrLUeHFD7V7vkRZtvVqgMtQc2w/oNpIirHRLrXTsCHVGu?=
 =?us-ascii?Q?irbyBn+un3j9o0QwQCbNURXkKwFn8/7O6pe7RebayZ65l63p8BGy85eLErBS?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80c1fab-39a7-48b9-8c09-08dcfcc09a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 11:05:33.3932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMrFNjPTDG7Fowmsb7BHgJ+H1Xh785kpXwo1Ikv5Wf4c1bID1YUw+gLjgdVRB+aSp0hFylCeEHHqSt6VzBjind/LDlrttEuo473EMOb9blU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7082
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Polchlopek
> Sent: Tuesday, October 22, 2024 1:41 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Keller, Jacob E <jacob.e.keller@intel.com>; D=
rewek,
> Wojciech <wojciech.drewek@intel.com>; Rahul Rameshbabu
> <rrameshbabu@nvidia.com>; Simon Horman <horms@kernel.org>; Lobakin,
> Aleksander <aleksander.lobakin@intel.com>; Polchlopek, Mateusz
> <mateusz.polchlopek@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v12 13/14] iavf: handle set an=
d get
> timestamps ops
>=20
> From: Jacob Keller <jacob.e.keller@intel.com>
>=20
> Add handlers for the .ndo_hwtstamp_get and .ndo_hwtstamp_set ops which
> allow userspace to request timestamp enablement for the device. This supp=
ort
> allows standard Linux applications to request the timestamping desired.
>=20
> As with other devices that support timestamping all packets, the driver w=
ill
> upgrade any request for timestamping of a specific type of packet to
> HWTSTAMP_FILTER_ALL.
>=20
> The current configuration is stored, so that it can be retrieved by calli=
ng
> .ndo_hwtstamp_get
>=20
> The Tx timestamps are not implemented yet so calling set ops for Tx path =
will end
> with EOPNOTSUPP error code.
>=20
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c |  21 ++++
> drivers/net/ethernet/intel/iavf/iavf_ptp.c  | 100 ++++++++++++++++++++
>  drivers/net/ethernet/intel/iavf/iavf_ptp.h  |   9 ++
>  drivers/net/ethernet/intel/iavf/iavf_txrx.h |   1 +
>  4 files changed, 131 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index b897dd94a32e..1103c210b4e3 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -5137,6 +5137,25 @@ static netdev_features_t iavf_fix_features(struct

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



