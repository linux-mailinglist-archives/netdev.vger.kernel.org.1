Return-Path: <netdev+bounces-147546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A976B9DA1A9
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 06:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6102A282EE1
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 05:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D341126C1D;
	Wed, 27 Nov 2024 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpsIloa+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC013C906
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 05:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732684548; cv=fail; b=kydbZI/DI2daMdL3gWYBY4GEUkG3wHFfZ5wY6olOQBXXoOMmJMyKFeOt7jo2fF6AVaVTOH1iRJJFUY2IA2ccxXM9k4O3kR+jEZevjYai8Ng3grlVtrPYBuvipWssYlX6cg0wnsNddStW+3wEzl64xP0nd9maeHuk7UBT+Oe+wTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732684548; c=relaxed/simple;
	bh=q0zNl5SsPN8n4hJ106TNV3jv1MImO2cktePjIMxEpMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QU5aeuy5U614Tbnbfej0/Ml8fcUNJXTibsLaXNbax8JTzr/h022bSiBDWVaNYH668LxdBLaYvvlqPDOBWzt+/i/t3BPvnD1gkFVmMuwqFdabGfmPlBWHWeyzoSFML1U8o2joiso5ZEsDEV6kU8F+KwiUo3YvQsdEe25KGphK+c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpsIloa+; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732684542; x=1764220542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q0zNl5SsPN8n4hJ106TNV3jv1MImO2cktePjIMxEpMk=;
  b=fpsIloa+gNdi3z+F5lNlgSFjhTbtUQAdEHTuMOLl0FiFg41kOJXacdsX
   Zj38TxJQbCPNXZiGkuoF3YzYp1vAjmsjbIsfR+3D9o4eQDxIygXbJ7fyU
   0TH2d6WaNIqyDriw9ghU+NLHZhP5ptaBpRnfQ7BmRtllufmT32FcMfNUw
   yj9uFeL8nUg28XoIYhV4K2lAUTlqqrJ37EhFb8gtYuR0cU6Tv2vyehRHz
   TKt8XaatJE0TH1alfeMvZw+HojUGNnRoZeUlnGAFGZHw/0LtTO6YZ7lZp
   I7Y6wr/KmOAimI+fcKbIhHeGAqH4ip+YU+R2dVVrnkLJ14ecDHJ2sf2XN
   Q==;
X-CSE-ConnectionGUID: /1TPn68WQd6eQwd3BvskSA==
X-CSE-MsgGUID: ToMqerUWS+2cycUOuraHBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32246436"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="32246436"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 21:15:39 -0800
X-CSE-ConnectionGUID: PYnfv8foQLWC70T4vo1BXw==
X-CSE-MsgGUID: JSRgwRS4R7CiTtRhF3b5ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="91641987"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 21:15:39 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 21:15:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 21:15:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 21:15:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3zgdPJJGgJUINRAHFa9EaJzZFFIX7RSxLRGsYVJkaJUwUVLEDLgXnO37c2jfH17JCWjcK4wNBIdXR7CeBPr8V10bAzdjqgtVBNgpyCIihJd/PeukAKWM9LmFkq71m+Fkqt1u6JZTCBOCSVhiszf7JrbpKPOQFSCskWfri8DxBhpKAHTBC1ph9I3xzwrW0ANJBck6MUstMcI3lsz1wJ1RTmoUb78hDcWVamFtHfqxX67gwx6KIfw665b0Sj6IqGCNmz0xuw1WJesU6307tg4ChilRv+Hr6T0tz2MOvUA85T5RWgLPjmvP0EWHZvhGQdGgOoklpS8ipAEkVZ9my1JyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFN1zBD+UuAvhjH7U3p4Js5gab0DpzHjQTSduvpjHWM=;
 b=xg90xB6rO4VWrc5L0wFCFdqYZAgAN6V1DlDFTylP+uBjhnEVlDFmbdhr8DEplZ2z+/7X4u+27pcW7h6IrukCnu17oTqWM1N17pc1LgitNv5crXQSLxRaWtaFFQnxz88sf6DpBcKlSaiEsrWed8i0C/8Gjn6+5FovsJ/7d3at+DPmnqyYII5hvex1iyZYFmmagJJq2hkY6Cc+Mm7Okt0Zjvu8zF6kM8Td8a8gP4oSbSaTf+Q2KPcpz69XdORaWSHXnWWFapV5tcQ4c/c0zNtGG+Nd5CduWdgf7z8PuY6M4eLXQ7HxetGXL8eg5A0dLBzoSP/b89rRh0WsMJZtUGFskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by MN6PR11MB8219.namprd11.prod.outlook.com (2603:10b6:208:471::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 05:15:34 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 05:15:33 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: fix max values for dpll
 pin phase adjust
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: fix max values for dpll
 pin phase adjust
Thread-Index: AQHbOyGvQSiA4uJkyUatI/XMLULNi7LKoCHg
Date: Wed, 27 Nov 2024 05:15:33 +0000
Message-ID: <CYYPR11MB84291078839C75E70F20D0AABD282@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241120075112.1662138-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20241120075112.1662138-1-arkadiusz.kubalewski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|MN6PR11MB8219:EE_
x-ms-office365-filtering-correlation-id: 3f1c1f97-e069-4a5f-06df-08dd0ea2852d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1rASIHqY6kCFsM8L6P4jd37g/bcTfwDV0zXPPZTutl2QXjRCOBI/nNZz3qQK?=
 =?us-ascii?Q?AzP4vM2B2gkBPy3OYx92CZdOpOp76jZrEca5dins4ZubwBc3lW5lxuXvAtAP?=
 =?us-ascii?Q?c8GQeJCxYl40TQw7Ksb+LSfs2mYwlWgRXghkGbrJK5G15aO2OSBXfbHhKgHK?=
 =?us-ascii?Q?+I5OAhoKfqPaEHqOKZtEGXrx+hybjiK6Gf9vl6MPxoZRSPryv5trstZr8cta?=
 =?us-ascii?Q?Y6Tmkzl3NQj52zARfEToaImKYA1KT+9GNbQPwjL9smaWKzGr65M6+3xXtklk?=
 =?us-ascii?Q?/iZiYVeTkadFgSb4F/ihuyXBomhFvEu5opDdtIPMV5PblN5Agx5dRlePOh2+?=
 =?us-ascii?Q?jVbDhbhA1m3xGr3T0QMypMNgjG9+VRbpraz/4UEV2DG2DZEZMPvWsAKZPizy?=
 =?us-ascii?Q?QJF0VRe3OGUIWoqdJ/EDo18opAb97CTxSHf3glpKQ69MmBhztPGMzMg1bCIF?=
 =?us-ascii?Q?FgnUrG5BJr2r7d+By47E/m1aJV0n+WRwTQ2oy53SJo9QfiMw0pmUh9aq0BKQ?=
 =?us-ascii?Q?TNapWvMavSGcz/8VfZ3GJXF+cOISvjmYHcSjKpzjeitNK4EA6aEPqd3xD5iI?=
 =?us-ascii?Q?yDi9IxSiD0XjP7KM609EmDYyvLX8wavrtP21Zfy2vNmTSQ5s3YvmDoQ5Zq/I?=
 =?us-ascii?Q?pFuvI+jQeFBuOVhAbSF52GFoYTgYBsgWPMUKlrIUBoAVf398iPzkNZr+6rJN?=
 =?us-ascii?Q?zDzJdc91bqVwgDCruZybircDY1Zhvh+Y1Zf6AYeOl2pEDbI0B7F0gkz8PPjl?=
 =?us-ascii?Q?cfGQ3Wt/t30INWuIV7e5HKWZOwbRMPACO/OTaTofpz1BqOkPVHxLc9a4VjVE?=
 =?us-ascii?Q?tm2gYxnpKaOKWVUmHiCDKu7/oNf3VHjzaAzoDvn9CxrkXmF8NAkrvgLcbg4D?=
 =?us-ascii?Q?k/Xr19kJtmigO/SSIphVFLxxjQpE/VrCJDoPC+7ug0/GE27UFzU1T3xKuD6S?=
 =?us-ascii?Q?DD1LFa74Lam/G37WPNNb95GxxUk7Ps5P0BT3Lgj791+SIgL3J9584pb64Cf+?=
 =?us-ascii?Q?jPXP/F3Odh0VcrTOvcYQr22I3f5vEqvhlJLHQgCH0iu3LfNj5pHGwZbT/8pn?=
 =?us-ascii?Q?a6C70aG1QfywbQF954gurN8ZQvx1Iao//avXZfQufyA28LcPOo7WEGo8udrW?=
 =?us-ascii?Q?+0ZpqfIO5josqgXe1sHCqVf2otLsqBpl+ooYBoO2+gKO2KqEtEGQL0RFpi/3?=
 =?us-ascii?Q?z8Ptmt2Mi2q47FDc8L1m+EKahggbRQUmUkNtXEv9hzAtEenF3W+AcRlvcUaV?=
 =?us-ascii?Q?XREzhic7elY8iVSd32vNnaH9TbgTBmX19iQLcCf0H2DwKyStgdnvINu6wSnB?=
 =?us-ascii?Q?SP+XPvZ/1sOTf6rhlj6clohj1Nbbd23r+qaAuZDXTkvHrBVQASTNhtGmV7Zb?=
 =?us-ascii?Q?Nkd0t88=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FJn12hFH6IRPA15i0Nx9y+SNthm3BQpu/5QZomI5FGU3nHfNqHFLVnIfSHl5?=
 =?us-ascii?Q?WxuSAw4zF3ws7W8NUVW/t5hYpTLLweCZDViOGz0UlLYRgUhj+cNrd7K2nUK1?=
 =?us-ascii?Q?tP22jhVxFeer8ugkVQaMHBtQjrIBzghXv8nJioj9Tv77ZQIGbFgnl3MC3b3O?=
 =?us-ascii?Q?36BYJqW7A3u+e69yHUOWWfLjUMZjN0ciscW/932Rw+iRsWG0l7juuwll85Ec?=
 =?us-ascii?Q?sR6q1TenLt4xaaoCQduHt7wC6nzpjOKg3boMyOF4wQxmb+EqzpjbeD63LxKI?=
 =?us-ascii?Q?GnA7A9zmxLyFJ83otyUJI2KNgFM9v/99URQPHHKu2hh27lMkqKkeomM8vm0a?=
 =?us-ascii?Q?lAi5wfikorlg1qy43hXtQk25IgmRMlFqP50xMHTdRz8SMxeEJLFAS/xY8i1D?=
 =?us-ascii?Q?EZSSxuNjZ7HwMvzkoYm7NMd2L7jJam55ynNCRJna2tVK9iPiaOXvGaIZiqjy?=
 =?us-ascii?Q?G37BO0RpwCDnRgbgQtYXS69Y6TRXlg0ArkEWJwO8YmUtaFqfpT15ODPpr4DC?=
 =?us-ascii?Q?eerDy0vAr5itSZ9PZKVfB8J/8mQoWDCVnVzOxSlKwUT+yVvyWe2b5871gDvr?=
 =?us-ascii?Q?OlxeTYpJ3Sw/jQrOMRdnNN3eVTcCi+7c3GTVRNum3jW2odMwsMiP+2WtLSih?=
 =?us-ascii?Q?E1k358rnTrufjcUeH0KoxRFdPSPkNbe87uQbOeksbReqM6Pag5RgFH+TS94L?=
 =?us-ascii?Q?GC/2hDT9m40LdGo62iLMFEtXB+cSS8CryU1Iya2F8gIPFZ5XWPAS/kqT9WD1?=
 =?us-ascii?Q?wXUjWLunh6HkEVapAao/uXCKiy5mIJuPneqjQ+OPeMoaUjoMgwTAc1eucyO0?=
 =?us-ascii?Q?9Dy2QZJzl4r+WPlmMK9pVTE7MDFLDCNz9mjuyEp9c664GBkKcu4p4VBiZ2nG?=
 =?us-ascii?Q?WIbTKi7XDkiJD5+ezBdc0zlgZQHwIx5F7D1AlhcZCPYUMS/Xytxnzv61Jq20?=
 =?us-ascii?Q?qVvtL9KX9WVVoeA5RQTxfq3qgjFUIuFsBfNtqRjwrVWvKCu8AjXV+djuRYFH?=
 =?us-ascii?Q?/dFUAunkYk0Dmj7HaK6ceJFsDbeXyIX3d+HKOA63L4ceRU0D4uVPYcqA3QV+?=
 =?us-ascii?Q?QcYNPc6PFXSVnMxhHnnzHaJugCEdQElMnSBwHZCX1Xy3G5wj2USaeajIe6y7?=
 =?us-ascii?Q?zLk+973meNYMskikhfrzJCgTRebcGPZWUobn5BGQ1d1wDVkZbOItjCPF/pgf?=
 =?us-ascii?Q?Pu+aSjHCjqsBDPXQ8JvmNLWE8RP724CWRLPMVaKopyFLxXqxghmFZ/Up6pKI?=
 =?us-ascii?Q?kvX2N1OWl9TUJRd2543Lt38DFk1FLGZPZ8UDSqx8oc9qUtNLrOLHoipz+61x?=
 =?us-ascii?Q?8MSzEPLS1f78WMjd4WHsYTS5fQfwMqHsF3LSF5NCgKvxXF5caExP0NS25ULj?=
 =?us-ascii?Q?1CVgZ8LFOz/NVM++AbG3hdwi9Z2FTUMRJIEjJstEvKmsU1aVExrRHzeJGIxV?=
 =?us-ascii?Q?eK/KzHySCY3mPcPmL2wb0qSAolSPajrKyyLXc6Z/ndFHRpCkFZGni7akTwmU?=
 =?us-ascii?Q?tpMPHTlc2HjLnpbZteydapc4RMH3l6jv69bOdcxye++KHrXbw6dAd/1fcEny?=
 =?us-ascii?Q?wIjqdG5VdJQxipkZvxkdp9/QYiaUQHPY1qD+9FlCcoKlxGw4v4W0O3SJWcKC?=
 =?us-ascii?Q?d6qZlxWFr3ApQK+pzIUziu8tjTfX48Ih8/gAu7N2iG5YV/vSlJ61azc3BqFu?=
 =?us-ascii?Q?p49mHegaZrrsxV2XZalPH04YXHo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1c1f97-e069-4a5f-06df-08dd0ea2852d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 05:15:33.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKR8++6RoCyfHCExs+7JFDBkdG0Fk26P+aJzTa1Po6aqrlnWn0flYDWIBKx5I6nF5/qtfjoRaGrzhLmP6iyGjo3FsXaotAeT49wUYzWOO5gFOeWtnzL/vp4aFCOTywox
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8219
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
rkadiusz Kubalewski
> Sent: 20 November 2024 13:21
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix max values for dpll p=
in phase adjust
>
> Mask admin command returned max phase adjust value for both input and out=
put pins. Only 31 bits are relevant, last released data sheet wrongly point=
s that 32 bits are valid - see [1] 3.2.6.4.1 Get CCU > Capabilities Command=
 for reference. Fix of the datasheet itself is in progress.
>
> Fix the min/max assignment logic, previously the value was wrongly consid=
ered as negative value due to most significant bit being set.
>
> Example of previous broken behavior:
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \ -=
-do pin-get --json '{"id":1}'| grep phase-adjust
>  'phase-adjust': 0,
>  'phase-adjust-max': 16723,
>  'phase-adjust-min': -16723,
>
> Correct behavior with the fix:
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \ -=
-do pin-get --json '{"id":1}'| grep phase-adjust
>  'phase-adjust': 0,
>  'phase-adjust-max': 2147466925,
>  'phase-adjust-min': -2147466925,
>
> [1] https://cdrdv2.intel.com/v1/dl/getContent/613875?explicitVersion=3Dtr=
ue
>
> Fixes: 90e1c90750d7 ("ice: dpll: implement phase related callbacks")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  2 ++
>  drivers/net/ethernet/intel/ice/ice_dpll.c     | 35 ++++++++++++-------
>  2 files changed, 25 insertions(+), 12 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


