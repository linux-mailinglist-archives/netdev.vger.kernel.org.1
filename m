Return-Path: <netdev+bounces-109897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB26C92A35E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD701F20F9F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B013212D;
	Mon,  8 Jul 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAKB5rdH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE958132121
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443596; cv=fail; b=kD0OPpjNFuIWTqZWviiuude2agd5JaGiyXorPKKbHmWqsNc0JNUTSxFF4AiU4o3Y9y8v1hBi5/6inHXFg055Uyhlc42rjEd1czxDD6dN72bXaGrPLd+TFRCdQBAAPuQ8SR8zGfQONCJADZYP8ODd9EXHrPJ1P4HSXVV/P0jwxZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443596; c=relaxed/simple;
	bh=8fxCEM25fNpdNAz3IQhEx2+K5ty6ef5+d9QVo10Gd+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UvDcY18oxh11QGQyjoE7MN0QDlKc+FSSwrnbXtHSB2av289upgn9QCp8RY331uSzz+KOVvfcsDh5C2IMvE7ZvfiQ/3531dIUd/QHs2MZuRcb+UU/R5h9/KUo2bMtLLWxSp3z6dvSk8p9yI4C+yorJZ+h3lzIRF+D4jQF4+g8DAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAKB5rdH; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720443594; x=1751979594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8fxCEM25fNpdNAz3IQhEx2+K5ty6ef5+d9QVo10Gd+o=;
  b=BAKB5rdHFkTnQEelgOHsQQ43CX4LGPRKbbVo2W6cukO3VRYtPdTvRH9F
   qmcQAASDa7UXjpq8ebW9rfSN+osWzmz7V3snViVxOUcFQ1Irv8KDUpi5Q
   VDQYL9kDtF03fdHHlzddXBTrw4kGMnz/AN8eX6GtCiPGLRzxa/p6Xm35q
   CtpP1JSAZ+vnlj+lOZsyzmjG8PPZT6DYuQzlJ6wXdO6VacwLrmkMBODRg
   Pm2CJJlaI6ldk+ILDj+QZ58cNsm5rOWEb7oXdLw7BrENxI8zklbk2qZ2o
   lQpy5Ja5qr+IcZc49WlDJZM76sOqoU+0ZJvTSJVRCyJPtscdlTRCkc4DC
   Q==;
X-CSE-ConnectionGUID: UW4UGRZ7SW684qLl+DYuAA==
X-CSE-MsgGUID: p/InRdd7R+iq1TNTWQs2hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17598562"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17598562"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 05:59:53 -0700
X-CSE-ConnectionGUID: fgzhcHvUReCl7cjtlfro9Q==
X-CSE-MsgGUID: FogSStH9TdWxUFu1M686Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="48237326"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 05:59:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 05:59:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 05:59:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 05:59:52 -0700
Received: from DS0PR11MB8115.namprd11.prod.outlook.com (2603:10b6:8:12a::12)
 by SJ2PR11MB7597.namprd11.prod.outlook.com (2603:10b6:a03:4c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:59:50 +0000
Received: from DS0PR11MB8115.namprd11.prod.outlook.com
 ([fe80::4cbc:6f18:8a83:eba8]) by DS0PR11MB8115.namprd11.prod.outlook.com
 ([fe80::4cbc:6f18:8a83:eba8%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:59:50 +0000
From: "Brelinski, Tony" <tony.brelinski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kang, Kelvin"
	<kelvin.kang@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v5] i40e: fix: remove needless
 retries of NVM update
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v5] i40e: fix: remove needless
 retries of NVM update
Thread-Index: AQHaxzCJeDBMGHK12EmSa/GQUd3oPrHs3qdw
Date: Mon, 8 Jul 2024 12:59:50 +0000
Message-ID: <DS0PR11MB8115AFEAB17A7EB4DF55235082DA2@DS0PR11MB8115.namprd11.prod.outlook.com>
References: <20240625184953.621684-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20240625184953.621684-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8115:EE_|SJ2PR11MB7597:EE_
x-ms-office365-filtering-correlation-id: 22fb2c3b-6662-484c-7bee-08dc9f4dda78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MpyJvFUkGuM4b46rDLLsZwxAY053z2dkzeZ0UwtZJK/S1Uqb71ylrXT4JrQI?=
 =?us-ascii?Q?4SWEV0SRS7RcygwGDqS0OGPMKO63FWOleM6KAyplKKeQeY1dMWPkMzCLXBWk?=
 =?us-ascii?Q?0NLsPl5Dl/BX6TWNa3EgBz/jSYeoL+mE+cZ7xO+netuo2v3bC+dZqLSKanEC?=
 =?us-ascii?Q?E6Hcs0aHIFyB5+F3HiFKVSC8OZ63hRWBgwHnYmeiTrBHPnf2WM7puU0uqO53?=
 =?us-ascii?Q?6UoiYVFjZDe153TO9KIaU0kk9pkoZb8QEMoBbpIMX7ofFjxvicKe1m4/nJv8?=
 =?us-ascii?Q?b7bl3jOKS49hQ/IwYJntEfcBErCUvT4cnDBVSI4BdU6jRSXb4mXXXXHNiIv3?=
 =?us-ascii?Q?d42DOtcpgz/XdTiTCOfQhikb8p0x2OdnSDRyrim9itYugbdkz3B3wc3J+L4L?=
 =?us-ascii?Q?I9zRqaXanLfSKHa/SBOYq+snRsSjU5nfYgON/z/jgdbDqEKKYlt6dFTgWC+3?=
 =?us-ascii?Q?7JUpObUWzHRgKjyoTcKf/VwnIAyGYqelkj97xEcVukVYn5CnJSNVcQ2m1/Fu?=
 =?us-ascii?Q?NYbsSE/h15NIbPdXkfSy6HJ8FAUWmJnvhiEGrnHQ1Rq/Coy08GD1VSq4z9N/?=
 =?us-ascii?Q?gYQLJecX7vpn/PdWiT68UoFv3GxR4dQ1F+mL4QHr8McegjqvF/nKg1z3Rdju?=
 =?us-ascii?Q?lBi4iR8ONvS3ic6oxhioWt1MmK387aSsuV7X99Jh1c6zDjPvOkO1jSzUmq7Y?=
 =?us-ascii?Q?rOkR97KiqCyMdyvsUKsdWtbeNiRUpTUI7PmBSawfrn8Z0bC5ktRjrScyBojJ?=
 =?us-ascii?Q?3uYqTlKn/4aEU4SW6lAyY18VQGofV6I6oFLjohy2g9Hls9QgzXuHhXhOey+C?=
 =?us-ascii?Q?3qbEDvmFhowT1OC7qPTVz/LL5XnktaWIQSRyIbHnypVRV/FhLyhMQcrh49UG?=
 =?us-ascii?Q?cw0nULZUkF8ciQ7DREJsHpaP/4Xh3xTt8S6WFuyH0038HFx5CiDSXGkGW6HP?=
 =?us-ascii?Q?0rqtgl1gyz91/UPTAo7rBnBI8m2hagR3B5Qq48LSUhsGh9FCvGa7S8aTBWQI?=
 =?us-ascii?Q?kSex78oBd21KfguQCR5qJ45KelNV3ms9WlSDKIFbdcQQtSlySahR+uu9yTzk?=
 =?us-ascii?Q?+LCfaD19WxwT4PJdZWDe+ODRWIEowcg1IJH6rOWLM+3Sjsxvlofg3M4EqVJJ?=
 =?us-ascii?Q?YKnwp+MYOYaLEg4lgCh1bWJmcC6HYqk7MgwjA6pgLGrqwqUOr0PyEylSWGqJ?=
 =?us-ascii?Q?SAmZ+FyTxbiLJtzYbtuUgBYxIyucPdvqnzf6X4I35ov1UVT5JOzTrwSusRh2?=
 =?us-ascii?Q?eRYVXNFiP7SksHB3UqRr4h62BDMrZhXLNu6AUW9ogPzJxlnoqZh7nAslhGe2?=
 =?us-ascii?Q?mDAODB214gH+wu4mrGa5fkvZ+dUSFKVFAObbQVlESKYSvWW4poNupS0tjH+T?=
 =?us-ascii?Q?xCtfy6w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8115.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yXGEK3FGOZMtdNAtKFI5Shh5xZoik/DTbvQn52rHQeoX2F7N9eR8EZ/UH/yn?=
 =?us-ascii?Q?oIeQlRz6CqiW4ybo27wc79sxyRLKBY/Jm4Y9+TgUH6T9XKX5Msd62T27Azvq?=
 =?us-ascii?Q?IB7obsvE9off7JIMQ/fPnCk3Pd/3kwXFOnfComVx2e12XnMB/rpnXdTvC/wM?=
 =?us-ascii?Q?6Gv+4gdajLOmR4UAuYVG9EU6+7aFg5etjXad0nrK5gx//pVLIKy/Wv87oljN?=
 =?us-ascii?Q?AyI0pNR97kvMznOda4S+8sSCK2HwX7EAHwcMC5y61MDL5aC9vd1Je86dQYLb?=
 =?us-ascii?Q?+5AH05mYVZSAAnuGjLzOnoPNxWICrXCUGoNoSLesGtK5L9dxMOJ+brjvsRdy?=
 =?us-ascii?Q?En2OyZCsc6sCK+N1eG6BBwDtDmjk0p4GKU4yL0mmbnnNDiDC32qSg49c+i2I?=
 =?us-ascii?Q?61sCP+Ok8hZdJc/fniRPRnfkeh3vMOeddVSywDC69/z1n3MvE6Ym3JEnRD0F?=
 =?us-ascii?Q?nxXRY2NNHyKZWbrYptx7iAKOq3AG625U8pEQAkPOGLTeIpuh6bXF7vRruOtI?=
 =?us-ascii?Q?GaRi3Iyir512gTtxED3ri9ior5KNx4H9IFZteFo6+R3AlEG263tq6qU6tTgt?=
 =?us-ascii?Q?eBZLEZSRE9KQ+HH/GOkLixMr6LcroDvnSiSXj/ujIdkyqosl4xarZ91s8zOL?=
 =?us-ascii?Q?jWVqNGCLqt3dl6S6mzydIH23lT4GcfnhFTNrwwdgwrSiUTxYJdP0nIrEwzSy?=
 =?us-ascii?Q?ClyiBti+3DzOmOgUTHVOUmi+XfnYRg2u1fTQ0A/EhNO3HCSoGX8tFdthWQDF?=
 =?us-ascii?Q?tFrsora7hL5P3I8tzGp9OL7OCv0u7LDjVy32KCp70KaR5OsDhyCNbfLiGgnz?=
 =?us-ascii?Q?gfBw3yTT7I0TUr4gAVfO1OquwEHyu8syuFmbbqhKhdldj8wMW7VRmCrZrNrt?=
 =?us-ascii?Q?qhashnUdcyexr2Ir4tHnptvFrjzaw3GJ4R2MKLLXfVDSWAir7b+HI3D6VWuy?=
 =?us-ascii?Q?0SsyX+2PE1gY99wQue4uHcfS9O5Zr9+hcMHXPk1tXMIvoycNzO8RKAW/yFbu?=
 =?us-ascii?Q?FiZc/WdsWYebMIRBwZVto0FTFZGBHxj73Wlo9M97pYwDUBI+E2hy8heNzrux?=
 =?us-ascii?Q?9Kjs12eHnQtPnfxLK9h4UyLeGDXbGn3c3PSWjoUmCzcK3Z37v38ClzAhwWEk?=
 =?us-ascii?Q?bMrpzgj3stUfxs0MHFDl82USyYCdSmzHNxsz2kiyI+iKn2mHBBeU3stZZyYL?=
 =?us-ascii?Q?J3CWzqL4xTtDPG25LPmK1GfPGvIXUNifM7s7gRz3euA1v+SUdkecE8TftPrp?=
 =?us-ascii?Q?vEiXrULSoD+7EXLMidbn70Cx0B5TbrvZliM9e3aY1CSYBcL7WaFpWdS9FlZW?=
 =?us-ascii?Q?F0JAQBvE48qxyvbApNbdMrvwcfXUeZmO2XfR7Hr7dg63NntoKWJobEfjsxYE?=
 =?us-ascii?Q?g1zkQII+RIBb0DFvubW6kcecR+EfL6xP4G/QYcOsguZTNOVlbUNFrabEq6/l?=
 =?us-ascii?Q?TxDfkh1Uw04DzBRSwv7KAmPm0hqVt3JcFHOtNpR0t88+SoWzRxvZf17V9Du9?=
 =?us-ascii?Q?PEZOTs2KtY7qGlLdKtZw6lHEtTLdrPacWtv72+6PrjfjVBKN4fgm4j3fd8PI?=
 =?us-ascii?Q?XxAd98oQboAXPaGlFMxBvr2ffQfwCRKpq0bDsXc6?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS5f1Tr0nQc1oRwEID+w6+44DZaXqMTxw6jAQlhzSko+fRca0nWCoAA5aodr8m+T9pWAmqSP05hBKJKaQgNbEUYWTS09lurxd3gxfnpuyZUnKrfUvDay+I+du2el6LTCqwCTCwYeeYssP6SGvyOv+SxjFiOtHUXd5TAXmPAd/mMzsYBz4Gk6Z6MsHsvsS73BMGTvXEzis2oHLV76cA2YYcvnfWiD7LoKszjP3tYH2Td92yU/dgU8kcwX3Mlpx6hCvs8tKVRx2rEOfE9CM+i4cR94lJu9Be/5O3yjoHcOZktGuDH+7AUxF4N2au6MbOEDMxEcUk66y2yvZ/rRNB40rw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rNtFZ/WTEiMv5noV8vpeHR+TqWHptg83wDCnqCFl9A=;
 b=IwjwWUpZCap7EJJu43l3otDzj5jxErokx8nV9PhmBRZqr6q82ajROt5KrB2zCCCtnR7nCIJl6MfAV+8cQFPOxATV7mrllyXdSAKwYUOwAbIW4dWVJhcOFZBO7ySOKGOrRx1YmLJlKmXjY4q1i7PZxc1duP8YW6RktIhDvz85qFu0CwzgMZiFrwCpAU6x92BLIAZfv1sPsP1Y62XTlgueMS73dbHBd9Lrz+nZC/E69TYdBvhRXDWDjmn0o0IQcSRA3N5YWe2Wnk6m55Mqxooeiu+HbwyMm6qfB3MDeNrHSco578YI1jaJuRLt3kFC22xLM9Uw6kbWiAoHJ+P79aLQ6A==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DS0PR11MB8115.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 22fb2c3b-6662-484c-7bee-08dc9f4dda78
x-ms-exchange-crosstenant-originalarrivaltime: 08 Jul 2024 12:59:50.5798 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 3X+TaejLZkAFQsw+X6iNesr40PT38un0LF/e3GQ8Y/3uZQ96HdZVzrv3ZXRUBGCWjr0CAEZCEzQv7NjUMygLzT3SG7PAoFUIsz0TigXpIZ8=
x-ms-exchange-transport-crosstenantheadersstamped: SJ2PR11MB7597
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Aleksandr Loktionov
> Sent: Tuesday, June 25, 2024 11:50 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Kang, Kelvin <kelvin.kang@intel.com>;
> Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v5] i40e: fix: remove needless =
retries
> of NVM update
>
> Remove wrong EIO to EGAIN conversion and pass all errors as is.
>
> After commit 230f3d53a547 ("i40e: remove i40e_status"), which should only
> replace F/W specific error codes with Linux kernel generic, all EIO error=
s
> suddenly started to be converted into EAGAIN which leads nvmupdate to
> retry until it timeouts and sometimes fails after more than 20 minutes in=
 the
> middle of NVM update, so NVM becomes corrupted.
>
> The bug affects users only at the time when they try to update NVM, and o=
nly
> F/W versions that generate errors while nvmupdate. For example, X710DA2
> with 0x8000ECB7 F/W is affected, but there are probably more...
>
> Command for reproduction is just NVM update:
>  ./nvmupdate64
>
> In the log instead of:
>  i40e_nvmupd_exec_aq err I40E_ERR_ADMIN_QUEUE_ERROR aq_err
> I40E_AQ_RC_ENOMEM)
> appears:
>  i40e_nvmupd_exec_aq err -EIO aq_err I40E_AQ_RC_ENOMEM
>  i40e: eeprom check failed (-5), Tx/Rx traffic disabled
>
> The problematic code did silently convert EIO into EAGAIN which forced
> nvmupdate to ignore EAGAIN error and retry the same operation until
> timeout.
> That's why NVM update takes 20+ minutes to finish with the fail in the en=
d.
>
> Fixes: 230f3d53a547 ("i40e: remove i40e_status")
> Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
> Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v4->v5 commit message update
> https://lore.kernel.org/netdev/20240618132111.3193963-1-
> aleksandr.loktionov@intel.com/T/#u
> v3->v4 commit message update
> v2->v3 commit messege typos
> v1->v2 commit message update
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h | 4 ----
>  1 file changed, 4 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


