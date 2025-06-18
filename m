Return-Path: <netdev+bounces-198859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134C3ADE0C9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CEA17915C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E43192B75;
	Wed, 18 Jun 2025 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+G2ySj4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1DC191F66;
	Wed, 18 Jun 2025 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210908; cv=fail; b=coMW3vg6c7/OdlHc6VCwWM5+jTYQE0/A6jGE6l9D8MJ8sxSj74bPDn0kWO5AovvnOJuQc3MN83us1HRlgoSGTn8+0kL98VPrL03M+k1oyXWX5t9GyPZGWhJ0Ys9H0yqhfFeulpjst8ZVLxou1IKUp3+WJfS7YzK/6XaYJmVQwOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210908; c=relaxed/simple;
	bh=1052nfcqUc9Qg9EOVqTeF00vfDAhGgiOQU7yJUdmf+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g3mdercAzFu1r1eR5orQDwFOomVQMHsnFVsOgFX1SkPU0EcUzDG0qjwqPGfkguneylQwLAY05ggHNNP9YqmHfL2whNJGqodP8IpW9ai+IkL9pHpRfkLJIVf7L2tRBdpxwZTpm16LJVPDA/XhMxIy6Rfo/t/xfDyuM7vacEND4IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+G2ySj4; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750210908; x=1781746908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1052nfcqUc9Qg9EOVqTeF00vfDAhGgiOQU7yJUdmf+o=;
  b=U+G2ySj4Cd96fLlFhGehCHUp5XQ6Ye9y+/U0lye860RWXsDy1o2DrYqO
   +eW7B8CseCErDzoO513yS2Rh29v6jE3YyhKIxV4CXJwCHspfLgaxmukQb
   Wp1ldgl0RusM5ByBRj++InrBAGAUTyX+ImqxqIB1oAn7Oj50Nwty9Ll5g
   UwTP3DAZE4T6SFJkjjPhwLilbUBmrHTNg1VdV4UaD8ljv/xEskAhzGiWQ
   MMchZHBM5xeP8poyB3KS+OLHdT3LNwe6mWkWmmpEPmgUnj1DatU+8Y9Ii
   mHaaKMhmWl5OWe3AJjQXqgKYGIwHWReDdFyHtIKWEyXxPPJIkmDiVvovy
   Q==;
X-CSE-ConnectionGUID: lC+m8NhcThiBsvE7p4Q+Mw==
X-CSE-MsgGUID: lhrCL9uUSGehWPJso1Cpew==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52551175"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="52551175"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 18:41:47 -0700
X-CSE-ConnectionGUID: XrMatuSFQZecasbv2MvPig==
X-CSE-MsgGUID: UB2iDrbvTFiyNJhErpqzcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="149632157"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 18:41:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 18:41:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 18:41:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.86)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 18:41:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtkJjybS+qsPSsCR2qwNokfLGzzMu4qpSEPiZhzu1rPES6ihsULeGiexHi5zncxEZNEn7H9GmAqZt0n+UECJQJ/0oXRwDf5WeO7uX82HWlx/fRETbmmdCaaSMZNuBmCuyf5NFSu3e89I1cYjlY5zyzUetcFuH2qKCTw+wwxYRLluQUlttgF8YF82lhKJgLYLcU8mAKvjJa1I6jRShTvD5Z4ZusoHnGGD4+fgjsGxGjOKjqeLwD3yfmY1Uen87i7+A7uq2payaSHqmeJV9CHPnFGFjU88kWPNHXQaALI9sGCd6om+cqpN/lSt7PTrCRAdnAlMByfi/yo7T0NM0SgZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxirR6y9ctuLP5i/KbzZ0I//XuMVIsAt3H5/fp0gUKs=;
 b=wmL04hLDldPBCKdTitDB4HBupJ0k4cEn519eI4I0ZpvAFrGNwdcorxQ6Ch0A4XF4fXXlAruCofBj+EgiebGupzAx/M29+o1bzEXEeCklEXVzRXts7THtBsknheS5v2qKlKJMlwToF0PYdcy7TutUHpfQ6Ar3Pk/m5xPInloQGR/bjpDcL95FevxBHYPDj6o0cSGk4HymnyVnRhoDZTwEDNATYkLkpTjRqDUg7ZGS0cv0YE2fELzRIM/VJcpT3N1EwIrYfEn7qhxLXOdavxQ0tLk/6COpmTeRuombyHcskcfy5ezToHSvi009cmJNc2ewhgovqVoVJk3KZVmPQ/LZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11)
 by IA1PR11MB8831.namprd11.prod.outlook.com (2603:10b6:208:597::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 01:41:42 +0000
Received: from PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f]) by PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f%6]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 01:41:42 +0000
From: "Miao, Jun" <jun.miao@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "sbhatta@marvell.com" <sbhatta@marvell.com>, "oneukum@suse.com"
	<oneukum@suse.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"qiang.zhang@linux.dev" <qiang.zhang@linux.dev>
Subject: RE: [PATCH v4] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Topic: [PATCH v4] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Index: AQHb3ZgPfzgFm2AU80mA5NPpU9MocbQIAh+AgAAk0gA=
Date: Wed, 18 Jun 2025 01:41:42 +0000
Message-ID: <PH7PR11MB8455242B4E160C281D8AC9B39A72A@PH7PR11MB8455.namprd11.prod.outlook.com>
References: <20250615015315.2535159-1-jun.miao@intel.com>
 <20250617162213.45d693a8@kernel.org>
In-Reply-To: <20250617162213.45d693a8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8455:EE_|IA1PR11MB8831:EE_
x-ms-office365-filtering-correlation-id: 147d13f2-8925-4449-286c-08ddae0946f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HjWToehoveZpjieKik24TIJJt+dh0avxXLCsO/Kby9tcNT4zxDCkaLvsBDwD?=
 =?us-ascii?Q?XT8IKl5Uz3dqnLY4meRsWShJ0Jffbkz5f0+APuDQ45MgmwJ7J8hU70WCpMtb?=
 =?us-ascii?Q?zpp6PKtdpMdYXV1mnSgzitPGRIVLMOBUEwBeR9YcgtQYXM3oVdeIQ7UGlxy8?=
 =?us-ascii?Q?iVfYG3/J+DIalS4f/9sNrOj7qbbuveSCBMhMZRTNtk3Wt4wVVKKmOyww3dbH?=
 =?us-ascii?Q?ID9cU0kLCZab/OiOgGCoAcR/v+ylpiubxAhlpL2INuPk5WBklWS5MobRA/mo?=
 =?us-ascii?Q?PP63efMnHz+mnkvT0vQYhkIeiJAOInwJHn8u22h+uFl4MwXm9f22dQ0nTFrI?=
 =?us-ascii?Q?fhgb8goG9CJlxJPdV2k4j+IG/E/tkz5zsLOlKFIY2DffM7w7QS/GoSaWY6to?=
 =?us-ascii?Q?jI9VhlvtoCHXF78RApqJ6DvXhgmbYHFBYkJNmSTkJUGzLDgoHwwHVzZBiaMj?=
 =?us-ascii?Q?SFnQqylH+QbH0VsYR3e/wbfOWTl6BdotPWgxtXYBQ0DgAhqhW7qVOL/o9DMR?=
 =?us-ascii?Q?loVstXWpt8M+AKHLV6PjdVwMszQJ5nxqxoW3H2XgMmTjvLdAXN4Q+L1tOQct?=
 =?us-ascii?Q?pChR1Ta6NEN3PDO8s83pCsB8GbpaVdd+ScPrTeXdpBIm/LPj8jwfeJ2sdVkV?=
 =?us-ascii?Q?XRWFTLsmhC6TpdmSK9fSfK6sqfAXWTAbYK9GL2A56aNEzbU2TfMupSsD9NJ4?=
 =?us-ascii?Q?EmWS6X1zNgo3YLc/I0b7tb/g6MQE8Xv2YOHkLdiuNGAa6mu+eXXGU2TzKnAE?=
 =?us-ascii?Q?dlyLxRuEioEdKGt7vy1zehtz++MKeavvgY8VykH/S77fJeX1iR2953PQ61je?=
 =?us-ascii?Q?QpylMbwVFC6G7gjdg3tR0qGXzSaVCE97Mmu9uOanGNak2UvrEoHx3WRmNt9v?=
 =?us-ascii?Q?OoaSt2b9OgeJQFVzTLzGKFVp/AY2bA/R3iUhoeoph2HGJy7ebhuk9dzay2pB?=
 =?us-ascii?Q?zzVQ5SxqQQYtaF32sh7bS/QQigMdQHRWMCkdXlmUjMvsawTBCrK1MNhLLdV7?=
 =?us-ascii?Q?Ku0pSveTHLL43M0c1V057UVOu04avOZV8/AjKmVXlylf+FctVjnKQoOYqOy6?=
 =?us-ascii?Q?So3y2ejj3YM8Tin3WiGeBXvCORd7FFHasW7yMnm8dBLhi5b8wfB5K7lq27mj?=
 =?us-ascii?Q?va6DX48Rdv/YbX8aGjB4qMcONsMx4AhibH6b7g5OxUXhIhZW91CUXlVx5kH4?=
 =?us-ascii?Q?DQghd1qVwbcowJOcTXsXWewiBWVwbHKr8OLXBb3G9luPSo9kkkmf+ORHRQB6?=
 =?us-ascii?Q?6U6ZRQ6LbKMGNRf+0gXv6skQ/yn78OG5JVpt0mrlOIZZjJNlfQf0MS49FCXc?=
 =?us-ascii?Q?VRyXZflGGuDzQB9AGtQuhv6jbvrEn/g1H8+i5PHGZRFPYyvn5d8fO2VP1QHM?=
 =?us-ascii?Q?eLB2APRqwwkKH709qIPSO3LimtIXdtVo4lc/W0kzEBVxCUWGobtjJhxWwEHS?=
 =?us-ascii?Q?ZIhuxkvty6SlM+tGOUjxgL2Uk9mbwBKUecqXnX/doE8gP5YnNJHM1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4tKOsi0Mmn397lPYQyY56TqHjGpt/ib5y/eNOsFBhZXL0MA6UcdtdIB1H6Oe?=
 =?us-ascii?Q?DgXyDCCR3qk5V2irWASdTaCnTsDpG8RNog7QkiGsUjJIv0A9/cdk310wP9Nu?=
 =?us-ascii?Q?VFyShG4Jpaw0ETU+uaLvtLRBHYZEkQUQIzujMivr7c/NYx731L3CvoV7d8dL?=
 =?us-ascii?Q?CKuZ/YfG3EkZ80pPTYpYs7NdEfFEmRHQXgMyotdRrtA91NvBTWwTouwieLMR?=
 =?us-ascii?Q?ZJ2YR1dgmTJm+9lK/O1ZWu3BDsjJ8LOYFXCNLgKwSv7foJAoslYVINEyzhLH?=
 =?us-ascii?Q?t8v3Nrzb5junkSWNEy0DQVGmCvUlEGLL8a/oRpjEt056mlqhHlJtBW5zQe5n?=
 =?us-ascii?Q?ohrfKk7eOXATBNsZ3dEkPsTBYWDr93GJOOBFkl+QUAEicC75W6Vg+IEpOITz?=
 =?us-ascii?Q?K07MXTelTkKOcoXigSH7WV767ZhgP7GM5GWFxhfdSGSKgWnQzyAVl4EuUhPt?=
 =?us-ascii?Q?OaoCA+6Yz3p2RFGqwfwFyU5UYTgZYdwRzOtEgeHxZo7Uo0I1VMzV+V8E6ZBl?=
 =?us-ascii?Q?o9/QGUfkAOGoZPG37H8WiJQejdQF1vJS7ao80dTVUW34n60SBUpmmU+Gwl94?=
 =?us-ascii?Q?lm2FMzTbzMwjzA4MUZPR1KfDmhmYUY+u4r8sGjNuv6ANJtv/llRT+IsNxTrd?=
 =?us-ascii?Q?Efun6xKqo4LPTWuUmjSe8jk56gnhnGRxIRezlBNJcUI9rQMArtoB7/rg1Rso?=
 =?us-ascii?Q?zsr1q5IUDskG4hrHPumPj4AL/TFc2KbT3AU1ByuNEh1R8AuK1VsgeCJJvC+X?=
 =?us-ascii?Q?LLCic8Qjan05hAASGtD8BPHcMuEmoYbMfdfgiZ3m7E5X5qNLyLVpwAX75KzE?=
 =?us-ascii?Q?7zRBsVcTzQSrr3escQMiEou7vh8YXwUMbQTpKMSM0rn7OfIrkp4XAzw7MlwC?=
 =?us-ascii?Q?LzxnIQy16f+N3ElSXCWSURWjtbCfd2mRoK7IwJj8D7RfxK965qbLej73/QU2?=
 =?us-ascii?Q?ag66idLqw1c0Y/rkWtVX3W+qaV3cmlI2Voc5LEkhmxhfRb4mmOVYB2iTfdGK?=
 =?us-ascii?Q?PtPiJrsDQqSCMZDadRci/I1kLDRDQIMWlrNKsMukYSjm90mLJsfikANVzgLS?=
 =?us-ascii?Q?tHzPbMvTqVwzTQEYfan9vzKd+mE4htTcc0uRAaQ3kqdMEeaaJk/0Nj+0v1Bw?=
 =?us-ascii?Q?hCFNFqrtIuklRb0Qcs+ut6ESsR4ukO3PaofklbRh7y5xlfmrYeq2n2eDB2Ne?=
 =?us-ascii?Q?/eRwXaq2kzKIlLyLhtd77ooMo1mzlPP75wx639k3eoqnYwjsW01lSqRS0jDo?=
 =?us-ascii?Q?cG+mH9Lgo59czIooH0G6ePdkWP55DkyVmiEyyt7msXYRrIjwc1IHkwlhx9s+?=
 =?us-ascii?Q?J+PgpA9wefaaVNOjMONkHFWXSX4DBGtqS1JUM6N4ATlxG443cFN30/BjqSxr?=
 =?us-ascii?Q?rhvHZQyLi42bMuXFfLgsCgCg9XViB7q1faLCBfu+2J2EXH5sFeoT1nBYTNWv?=
 =?us-ascii?Q?mRwY/uJ51YWgDcxNb51ACoQZU4VafeljdRMJxBpirssFcN2ZQqYL6DgI6aBG?=
 =?us-ascii?Q?mYY/tTY3k4cbP/uNxw9z08+zchnQIJtsuR4Nkx1tuzKhwZZwY+ToLDpda1ek?=
 =?us-ascii?Q?xzNHibOJPU2G/bA5FbUcbitWa5b+5f9U2z5SsIKd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147d13f2-8925-4449-286c-08ddae0946f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 01:41:42.4595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2JYcf0udnlr8yvHUCZTv0vusdjQ1WhaURSKJ0WDd09m9HL+9m+hmF+kOzPnjTtG6iNLr9BUjd9Vwe/R3O9PIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8831
X-OriginatorOrg: intel.com

>
>On Sun, 15 Jun 2025 09:53:15 +0800 Jun Miao wrote:
>> -static void usbnet_bh_tasklet(struct tasklet_struct *t)
>> +static void usbnet_bh_workqueue(struct work_struct *work)
>>  {
>> -	struct usbnet *dev =3D from_tasklet(dev, t, bh);
>> +	struct usbnet *dev =3D from_work(dev, work, bh_work);
>>
>>  	usbnet_bh(&dev->delay);
>>  }
>> @@ -1742,7 +1742,7 @@ usbnet_probe (struct usb_interface *udev, const
>struct usb_device_id *prod)
>>  	skb_queue_head_init (&dev->txq);
>>  	skb_queue_head_init (&dev->done);
>>  	skb_queue_head_init(&dev->rxq_pause);
>> -	tasklet_setup(&dev->bh, usbnet_bh_tasklet);
>> +	INIT_WORK(&dev->bh_work, usbnet_bh_workqueue);
>
>workqueue is the queue, here we're talking about the work entry.
>And we use the system workqueue to schedule on (system_bh_wq) Please repla=
ce
>the workqueue with work here and in the comments

Oh, I understand what you mean. The naming is not accurate enough.=20
This is not a queue but a specific execution action work.  V5 will post.=20

Thanks
Jun.Miao


