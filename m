Return-Path: <netdev+bounces-298531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zweRJT7KK2pAFAQAu9opvQ
	(envelope-from <netdev+bounces-298531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:58:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F058678007
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:58:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=B7JsWuNa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298531-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298531-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BF1D3026E5E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE73371CE2;
	Fri, 12 Jun 2026 08:58:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6F369D43
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 08:58:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254716; cv=fail; b=uXnEyc+o8LbmkHx2WCV0gfk+L4Ji5lLoy4QGPBngQJBVJU7BWj2h69QEwjWRH2OCw0G+y3njGS+RSFsnUSDj8s18DGbu2z8KM88jqqcnsFZazsjFflASeyAeVqdoO6MxXCvz36Uv4p6GlxCEp5iOOkxQNv0Oy/bh0lxBNoJShxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254716; c=relaxed/simple;
	bh=+NCIO16Ac4C8N2lqdCLtxVWEo1qaci10fQGs6JSEkWk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fpuMPDbC7q49P8GIBIpBX9JG4OQErG8wiTKovhyicm2GCmzuDK+5oJagxkOaX0A5Ymp7uVnkX/LTn5UQlQubSvuAFbY+OV7LR7nnt6tPbr8dhgxjlz+1xaPpPaalP50SSUWap6+g1DGQwCdBcQXqIa1AlGp8J78KjbyCGm0G6QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7JsWuNa; arc=fail smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781254716; x=1812790716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+NCIO16Ac4C8N2lqdCLtxVWEo1qaci10fQGs6JSEkWk=;
  b=B7JsWuNaD7SMXG8hnif6PGiblhrZFuze5Ov2uTbvKx1cVGLW86enoJsp
   RWW4wkHKbLYhuvDHYGcwmIA+aI2hgf5PGK08LB/ORXH1U/gOmNMWq2s4V
   cN5dcDwHg0c0zXnNzMHkCGatwFuSgQA7iMCrGSi3MdJe0uR+sNwi5DkGb
   5ZXGxHOW0bfzcLAocRO2EqsuqdujRb+6YS5DsGeReb++K575Sa1zXDE2K
   uA5g9v/BFRCWrsdhVFEIvDe3pTIurHGX9zjJbH7KcgnoHI6kj6jh1goFR
   HYpuu6xupnorQKsELpXZev9ddlPc0g2BZmnppAjzyO/BQW4ga9vVl9LEM
   Q==;
X-CSE-ConnectionGUID: 99CAbbI5R5atWCVCnjxDBA==
X-CSE-MsgGUID: C1+/hhbGQEq8PnCiizXEWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81824450"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81824450"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 01:58:35 -0700
X-CSE-ConnectionGUID: okj0hHSsSaqRGtJOo2coQw==
X-CSE-MsgGUID: DZ8M1kM1R0m1NEqMxMO7YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="248652866"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 01:58:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 01:58:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 01:58:26 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 01:58:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHI6va0IWvTlNDgA/JYLSjtakaIdjYGrK7bMTOosWWn2w05vOkt/rR73HUMN7qz17tlYTV+GdzAShSPua1tNESjCdRsYhRtaOie3VVIPYDps1BxNhTHyX7WNqfLyB2XF0h5PpnSn11d0V+vIrKg8SCeSQBEVd7Ev9AwoccOX7CWHZUW5fcuOVsbelWkGRZ29PlZpflMirBF1nuK9zy4HS+2AzWcrVt2lgGeAtrFG8rmHQ/XZ0AK23Eyv1yfY5X3JJXV8ybEiY7eJU1UjXtwSGbJ6Pks7lt1B3fVC6JBmcutujrcbTyrtjkD9UjWEO1dD9mW1V0EUY1QRshMYu1tp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJSf4heUr8vdSLX1WRr+Q2EadmJ9JSjNVq90jRGF/oM=;
 b=lzXKSe0MZ2dXJ/CYLk4VFiKySXg051vhfqLQaa3y1YO0p0c6IjWl9+TAQbaVgEkyIk27pIeUZ86cAQdJr8BE04C5S4BP4HEt1WahMPIyeJ3lU95uZEcL5wzdXs0pKkg+Ts/nfPBaSs6aSG1Im/zbnA1kqsDzzwHG1I7sRQiibXM0XIVp+CATYibGe9alYPsEGsBR45pwYoxMfBbofrsFXKChYvBI2VGvsJqILBtAB9PvqJrtYO3TLnJFAp6BvqkLs58TpYXEY5hYq8G0MtBUyWcj/PfvA8QMe8mZioCZBiDlayIJpfbezuitskmg0OV2cufr98AkuT6eqmZ8EWojuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by CO1PR11MB4786.namprd11.prod.outlook.com (2603:10b6:303:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 08:58:23 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 08:58:23 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Rongguang Wei <clementwei90@163.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: RE: [PATCH net-next v1] e1000: Initialize phy_data to avoid
 unexpected values
Thread-Topic: [PATCH net-next v1] e1000: Initialize phy_data to avoid
 unexpected values
Thread-Index: AQHc+kNTsJs0vVnLPUiXdLkSk0iCpLY6nM0A
Date: Fri, 12 Jun 2026 08:58:23 +0000
Message-ID: <PH0PR11MB590263784927AAB47EE558BAF0182@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260612080331.120096-1-clementwei90@163.com>
In-Reply-To: <20260612080331.120096-1-clementwei90@163.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|CO1PR11MB4786:EE_
x-ms-office365-filtering-correlation-id: cc31f91f-be5c-4fb3-9eb8-08dec860c228
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: vqYA+1usrvx1u++iEQG4n20N8yApXXbMfMTZSz65r3iHI65c/TLJLuYhBkssUkdlHw2URN1iAfRomNvtvj3+OweQwRoGECGDov1UZ0npqT/urwP4YojvpjMaZsqj9N6pAWKdGUoisdN8VZLmbHZdit/Em3daD2QnM2qi4yvIVZYYLtQcLnl60mRo8SQ0q8nZnFPpq7cG7DBjZMKvwid1dG9c/XGNXLnXAO5fTxhIiyzA1MV5pzg9yOE9aVR9tep01Np9p9FvL2ROpES/nCKWFit+kID/oegcIIuHtP1E9gisK+VJmqLnqgamJQ+oSvpjOoDzxCLqbiITKGLy6aFjBssdLZA5bS7KwvYpnDiVof6EBVf93JuXYMKWvA94rCbvpNC0yrreMpkXMZ6HgyN1ZuiEMGp49w70BsNYdeEQct+hK15evoBRtY4cS5Y6PKjSqfCpDOPeefiSTbdtZX0kABV02c2IYWbEn0sWBX8JW6oindnVoLWuwKbGL1bw/Q0U2/AhrKX9Bw3qHd+fjj/ADvhbl41R37xecfF0i4BCerEPHZ4Kh8U8xesLQRUIasIp91fIT/WXxA1X75nrGXNWl/WcJn/VR1c8Jka0odnvIFPrdnIv6L/LuQEFJc6PPzZsdv7bqMguGG39EdZ1XuJOVW3pyAbbFU4eM2RnOCyvS0sPbasQIovsaGqmUHZ4a02dptmSz0Jc+K/vVXjZiPoVJKrZWrkMOKsWkY257xiUCBvm4GQEr4XhCPMNwgn0nww5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6PAmmS/LI7KNovqJg2IdZSJJAf+7go4sJi9LMTWZuSIQiUTlGCNDhlFidnqK?=
 =?us-ascii?Q?IQWh+IVJzAlqN1FdquDa5ZTozB2pf/KP0L4Bmzqq9RBO4cnYH5q5hVFTIwO3?=
 =?us-ascii?Q?SdbzhXia8FDHSsFk2WWP6pD8HUf7N4KSnMZ+iNpDMG36yKdNzjzq0EbcnM9p?=
 =?us-ascii?Q?YnYkVJP4Qh40PGhHrddUO7SQF0Oa5ClyyGID3NvMdJmMozFQ4+T6cGAoKO0y?=
 =?us-ascii?Q?n5F4UUVAqNZnnG45RjZwaMhGlflvUV+dnf4uwRnHP4Rs4nLHxjuTSzqpGvKz?=
 =?us-ascii?Q?jWUYBmjW/C17pYW08yQ0tm7cFH8u4qHHJZxkcw6X4r5FxhxfQ3AFo2xx1viF?=
 =?us-ascii?Q?gzb+1SGUGhalhCvItkRP9+YsEdgmVfWYEOInoMewBCXFzLN/kd/zzLuygFom?=
 =?us-ascii?Q?z22heo7a7RjjBBnNG1bAdNBnk9Ncf32YXx2jFKEaQd7+5VqIaqw467k1lFYn?=
 =?us-ascii?Q?5Ys4AmKge/V9tZyhY/5w9fs8yxZ2nFJR2TStDBytZV/YRohzL7z8b8YBV4bb?=
 =?us-ascii?Q?nCYCOuV9MmO7FenvpXc7x+BqA4zNSAwYipIZVO4Q8q4nPnEQxLYOrP13eBt8?=
 =?us-ascii?Q?IHl/IstFe4XBEGANnSDHzwnNjwhCcmu8v3vODzqSkemJeYKZtswQxEXNEdxR?=
 =?us-ascii?Q?n6WHp9TKTpkElbPOXwZhDr9zLu2LxdokOq2ljE5IDnFhm/3GEz+KhHcToMDX?=
 =?us-ascii?Q?WDdacro0ZbtIRhwMS4txZM0ch7RAIyoNjkqhkw9Ro30ZBZwRCYgoEYqBis1c?=
 =?us-ascii?Q?4ZDB3+DTalxa5N8IJG8wwkmWbF1H/QWlijiW9W/T4gI40PTRn2GQEN3ojwgy?=
 =?us-ascii?Q?OpA2fRw78Q+D9NTnNx+ggnZiXMNrN5xNAI0tN3lnGV90tCfwukYJ9D/oLgE7?=
 =?us-ascii?Q?MaX4e4AEijV3LZ4up4hf92S81AbhP07dcPEAwGzAulmFWkVXNf6S7pKwEvFS?=
 =?us-ascii?Q?wip5BE4sCqKrR4C+4GswS+lyBxwlGKc7JeFzEWxPRZFPE/sHlZn8hCTFVz3k?=
 =?us-ascii?Q?pZ7i28avnvodC/9p1z8MEcoVkjmwevicCNUNldnaK+Gf81wz+JAJO/DmGNAv?=
 =?us-ascii?Q?ZSC2yXhpupqP9u3r4iNKcmBZ0yyurEy9K3WDv5HYnJMTk+ysbB6Pw8Cck54x?=
 =?us-ascii?Q?488FWGSGss+h11b2Z35Pgg8L41FVWDWsE1eLW0xOr4fmeV1BIEnelR+cef+H?=
 =?us-ascii?Q?ZNT5XQaWEC0XP3lM0JfsaJe13sZIZGopQtO0ZLXCYDAOlPzmxdAxdRgQR0+L?=
 =?us-ascii?Q?qPP2UIm7V7QJtWc2Y/ndzrHXgBjWtEQn9+YX+sEEoXg0MJd5OUOQ85GXzlvq?=
 =?us-ascii?Q?0gcdgyVdOaHG8zKPkPDrPGtLuCRUN0lLJVqSWIb0T4BmcR5IqFCpqPbkBMG6?=
 =?us-ascii?Q?1intdcVVhgLnzKCcpzbu1o8tolDgIl/IOrVaEgfq1biBtV3wwWFs6KahntL4?=
 =?us-ascii?Q?ehCqb9DnTf2OhRoqt+jhrWXMZgViy4BFlyJ3HdjdXdi0/7r2d0pYfqF+kNnf?=
 =?us-ascii?Q?QueyEymASwJdSFnYxKTW034PpUApX8NyKOi41Mo8vuTuFmLvZ4arCOij31Mo?=
 =?us-ascii?Q?LBQbHyc5sLnCDWns2sNg+YTBWytMPG6HRCWTs5917c8dTJM5Ic+WnpvqR/LM?=
 =?us-ascii?Q?ASwQK7B5Xu5qnIS/aMsnKEuIxZyLScjuYhl9Qn/yjZJTgL/80xJF72sUYdGw?=
 =?us-ascii?Q?ZdS56jfap843tSzzbnULRJWtIWZPepEQMSqd9cTi7Tl5oPXZxud7yVr7/8DC?=
 =?us-ascii?Q?F3uHF06Nfg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q2y2W7+rM2/k0QnRswYd0x3w6tCOMMfBMWzB6EdfrH89vz2V5sBECTjb+djgKUGpIwAMzpdFR3YxeSqWsTQ7iL9plHpu9MWXmIYhySCuNTKoIQ/8YHYVie1bp0Yss+COVwPUszgKHP/iG4LG0G2BYzhkCHBR9RZtwP329HuTUWLG1Tn5oeQmD3qLVQ9pnh0aofv7ARugEFVAjh+UqkmaT9DSGSELUSTLfvtBauRV10yp63mNp2tanMu8JRr4sPtMmWbQn1Ta7LY5BUVJLEh72498f6zJF+HuLKXvDyTBCxGvSfRgUWOIOYf0AivVY8U5F8m0gwu/qccWmk3V+s65tQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc31f91f-be5c-4fb3-9eb8-08dec860c228
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 08:58:23.2837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eX7eDhFAw5Lr3/ThaO8iCEVAEvmL6l/rJ7Da2J4X792hdx004a4wG6VvSttHNsaFgdszC4lL1ZrhtQD+LaTHp0bgcWDe7TL6UTvP8G0OtEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4786
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[163.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:clementwei90@163.com,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:weirongguang@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298531-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F058678007

From: Rongguang Wei <clementwei90@163.com>=20
Sent: Friday, June 12, 2026 10:04 AM

>From: Rongguang Wei <weirongguang@kylinos.cn>
>
>The phy_data variable is not initialized. If e1000_read_phy_reg
>returns an error, phy_data will not point to a valid value from
>the PHY register, which may cause the regs_buff array to be populated
>with unexpected values.

Hi,

Sounds like a fix, but i believe we would like to have any real
scenario when the issue occurs and how it can be reproduced.
If such is provided please target the patch against net tree and
add fixes tag.

>
>Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
>Change-Id: I46071b3b21a566f8da650168d38d6968251b077d


i doubt this is a correct kernel commit tag

>---
> drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/ne=
t/ethernet/intel/e1000/e1000_ethtool.c
>index 4dcbeabb3ad2..f068108c5004 100644
>--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>@@ -327,7 +327,7 @@ static void e1000_get_regs(struct net_device *netdev, =
struct ethtool_regs *regs,
> 	struct e1000_adapter *adapter =3D netdev_priv(netdev);
> 	struct e1000_hw *hw =3D &adapter->hw;
> 	u32 *regs_buff =3D p;
>-	u16 phy_data;
>+	u16 phy_data =3D 0;
>=20
> 	memset(p, 0, E1000_REGS_LEN * sizeof(u32));
>=20
>--=20
>2.25.1



