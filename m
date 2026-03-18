Return-Path: <netdev+bounces-269082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPJKK1bIumm6bwIAu9opvQ
	(envelope-from <netdev+bounces-269082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:44:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E9C2BE7F2
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0204430814B4
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17C637AA6F;
	Wed, 18 Mar 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuRJPRgO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12271330B28;
	Wed, 18 Mar 2026 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848353; cv=fail; b=LWH8cEL0O+Ae0/2MKyPHPhfzp9b7ekwYKQaSFX8t/zHu1jpDvDopuy+F9j7CKLWPnoCIk0/LjTKdMhrwiyAyGy3hraBoo5vXp96XKCA/3rIK2wRkglAvFu7Yc6AJA2YXM9kkzc9d1UvxDY0yAmIF2Wo6lHbgicIIBN8I4xZnX04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848353; c=relaxed/simple;
	bh=VyzZCLY/ax6iHqG1np1DK6h8plkDQvGCNqDiHUZCak0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rcPAXtFMyxpommPpj7/GOjd1PO/IYqam7E2Xe9egUxK4SnL4DRYFFfQJZX/Zuw8cnKYepIXIjxn33eJuesjcGfYOccHISidVa36WE3YhcGBTiYAr/YkL0o1ZMusGrY3ISKyDjWDaIRtemnpXXJfiIQnzT9yitlPCV86RegCvgV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuRJPRgO; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773848349; x=1805384349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VyzZCLY/ax6iHqG1np1DK6h8plkDQvGCNqDiHUZCak0=;
  b=fuRJPRgOr/+dhal8p5E2Ga25UKQmzLpn8SOnrSbfHhiu/d/bQhsiW6RE
   OeT8mQedq6ccJXESVatf5AjblpcfE7Slr7WUw7o3lHAeUin9E+Ox1FHTO
   3vJgAUctbfVjJU59/+t1isDCVUcbY4WRETsemOeaBexKAEWfM4Yq1V+v4
   9qGg9K4lcWV1eNazo1A19aZ5eQfQ/urN57FfSS3pYJyqp/OYOH5jrE+0g
   X1qoMDgSybO6cb/3maqGp0yvWJkBff7+jxwTyGRbUJt8zpkOyhcyDeHzx
   3vvtcanLXL5B1xEDiglEqFrRSafqBqhV4pgq8zi5+mLa7LqvlOunvMS5W
   A==;
X-CSE-ConnectionGUID: omMGiS8hT8m61dr68qnLcg==
X-CSE-MsgGUID: cUUj4dzcRAyi9+aUqtnN4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75027618"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="75027618"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:39:08 -0700
X-CSE-ConnectionGUID: lvT/1zRpRL2z1rz8zWzU1g==
X-CSE-MsgGUID: 1KFjq7L8R8qCgauDM0lztw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="247125537"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:39:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:39:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 08:39:06 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:39:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfSEb/pPebQx/tWv6Tu66d4Z3N2bCKmBO+Fog25DCe0x7bUWY3I5OgJfT/R7qpoCd6ddB62l7i46Xh+T15VAQvLuWdTjepb5Gq31D3+C5b5oE72MCuHrT7bi+YPPrFqPFwJn+h7UqglcnMxSk99HKFF3ilOfdu6pYX+gxAC4YKySxcHB2I4yATrjE0F8v6is4XiKgzvvCY3DSjKJaKF8RWdZN0xF5RHxs1igtWsisbPaV1lOZiifW2Kk3kyZk9flEkT/Mf7X851E+KN36hiKOVGNsBHRneCk2bPRSgCNU8j9HQIUwQijr4EoLM0u2qDt30g76Ofa+RioYZB5Y5s1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhIyA5BvsVqhBDtK8HAw2HDTnQrbwfDOvgxWkQawnHQ=;
 b=KJ9v+SxsiyJQj/Mg6FYeTHqBUAvrn6p18gqZ3GuDU+J6TaLqc/Y7nd4vAR/tA+HnM5saTuFXjWseTIhqX8NacLZgFs67BT1F1vdtcs2ruwGhUTHcQMrevKJMCGX/FyRhszzA4q3arFzLM28TR4dZ9AYnsEAt0YdoZcZjWYd0VRxeP9yMUa3LxqtF3nrwdDYrvust/QRlam+h++2kWJmgD0bHkqqn4hyzT0Ov3WcNm0Mm12j2vDoFyBqaaMayy0HxExDw3+cFBd/Ec4zzg05DPq7vAt2rHkbgl5wBwBNHRbgXLk907A8knLmYl6+olkH21zxrzmqfKpVi/33iHjYSlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 15:39:00 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 15:39:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Agalakov Daniil <ade@amicon.ru>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, Daniil Iskhakov <dish@amicon.ru>, Roman Razov
	<rrv@amicon.ru>
Subject: RE: [Intel-wired-lan] [PATCH net 2/3] e1000: fix endianness
 conversion of uninitialized words
Thread-Topic: [Intel-wired-lan] [PATCH net 2/3] e1000: fix endianness
 conversion of uninitialized words
Thread-Index: AQHctuo+APNbhGgwFUurQIVGh1o7KrW0bNHg
Date: Wed, 18 Mar 2026 15:38:59 +0000
Message-ID: <IA3PR11MB89861A3D03A09FBC321C23EFE54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318120512.687149-1-ade@amicon.ru>
 <20260318120512.687149-3-ade@amicon.ru>
In-Reply-To: <20260318120512.687149-3-ade@amicon.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6500:EE_
x-ms-office365-filtering-correlation-id: 11a726ce-2551-466c-832b-08de8504799e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: yS0SBDHX+i2JKz7T4gjf8aSKRHChXQOeMIVHvf4J3x+LP2ntxXFvSlcH9N+31mWa/wbCMLI0G8ykv9ydrM68+xg49d6S5ZRHuu/CiXafMtwKlr9sp/0W3r2tpdO7t4GX/mPofKkGL19PrGkZFvDGuayfhN3BLhN0om5q0SIRKWh13+C6FoQAGm5ZZnDeyuURvwp1R86IvOEZG36BPWNO5eOWSI3RS4o13iE2o7RHAh6W0XUIVYZZuRHZRnLfkQQZkaPtSV3liDzEjbV8LowCuJAC9590pD3tDw4ZOx8AmVHTvauXH5HoalazP7lS0R8i4OAd7udEiOtfJgdga5MeRYu09AoIiJoCERx8u7PuTmD4kf0yA+Ju62/TW9YSy5fDVnrGsuAfdxRnPRjVmrO18otJUqMehQ86VcW9riJZMQ4J0NdsnVJxQksfNjD4IBKrfrsyVq4xGRAx/enJYx3poZG32qs/Bw9xG6eXjLmtQadj/Q9L32nNo0PXmEtjtfsP+/Q2x6iFS3BqtQWCNkE78vcTEWULMYPsoyLU6lySBb975X0HfIPU/FaMxdB1oCiCHxcC4A38YV1mVF8z/CBehCMsF/sWNJQNNBAU5KZoUF2LqqFUNVgn96PZzVCFNvAet5uIJ+W48o/lVejgjSFqwIsy5R/LW6EWbQ55f1TDLa43ae52/wHKuRIk4ZbMdU5SmHdTdh3qhkGoUy+n7+f7G/NjVM9JZ1HtoPP1txpEByka6wlGG8d2fupFUqg0XBl/9ZI7srhx4jHpW5d3KmbZfRlVN/VC/eZ99VPBTofNtH4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OT0hrWmC/4wg7VNF0vBBymvPbcskfgatxeFyOls/6BRZipI88dILPmh/B5cW?=
 =?us-ascii?Q?0MsBsvK7WBeGUYo3jwzDe60zpMq9BivyswHHYSWZRQrUQVbTm14gCArLNvSS?=
 =?us-ascii?Q?l8Vju7YG8knq0+yBod4pIz6174hAjvLmwKi7g+tt1Aq3mQxK8fdIRoFrfTil?=
 =?us-ascii?Q?oFzK9M73XJY72ECaDcldwOYvchWT8F8AAmB1p3M8CaWHs4GZA5plPC8AUNc9?=
 =?us-ascii?Q?Gu48v6T97TEcThsqzzmc89OezbP/LVxhb4z9oqQ5HPBVo6+uxoChAOaleHfG?=
 =?us-ascii?Q?E542/eijfAXFJaktSOnhDG3UEEjqjOYNJN2OJ7DAhJhCvosIerATbH+fo2Yh?=
 =?us-ascii?Q?yuNs68K5tFBFPD7un/VDapOhjY52Qf+4DQFs85dJCrczXP9o6oPVk7iWme95?=
 =?us-ascii?Q?hEe5tBYdhylcZHQO9f0E6IjFbFnr17UVMaykEGN7Eqy+95w9z8utraEk7lf6?=
 =?us-ascii?Q?9TI1CEGMcOnOYF7j7B7eLPMGAEizdb6EUGimiim36zx4OuS5HvEXHQ2itta6?=
 =?us-ascii?Q?8O5St0ZftJwt1Nt2jrRzUtOp6Gpauf0Y6ODHCNEni+Dd3Vhg55nCYeHBOLEx?=
 =?us-ascii?Q?uiCHcapIBEEXFdgFRWtK2esDzYqPV3AwLRHHeDPkoIKwVQRpe5g8mxbQ1SqO?=
 =?us-ascii?Q?e5mwlTMt6NxlnbB/LjKkSfHlixNYPgb8cC+8Rhddk9kuuEGsfDZmAc6hE3Bl?=
 =?us-ascii?Q?BSFGqaPCZv8D/r/lVAyTDMRwdQGDO4oiXE7OojZqwrLEm0IYfd835qjH3BZu?=
 =?us-ascii?Q?JTIOJazdYwmsV8pe48dTxx659lQXMaHpWstXcHM6+E0OoFdU6cCj33BXSzYj?=
 =?us-ascii?Q?lX11WY01JKzeU2oXnceQ1R0N8hRZBDQnzbDcd6+H8tc/RwIOT7dEQi35IUi8?=
 =?us-ascii?Q?4oBsLOpIlgnAMWqSw/sAZ8OnBcZv2j6stXuYGaDqReEAJq4m+cmTLepcKrOC?=
 =?us-ascii?Q?f+Hncj4xKRN2mJGCxodEPe82tpvKP06VsH7zijSTM0uKLcvQjhFsmFmddNe5?=
 =?us-ascii?Q?j2vWshnFX2k/gKby7oPPi+oGMuq/uy7b2mEZApJgiODjbUo1HzNMiFJODEAG?=
 =?us-ascii?Q?LW+Fb91F6Q39mfBnDEpvr4erBBHpDt7ufu3EeoJsDqj9OoaJDTNqBvVla8cm?=
 =?us-ascii?Q?eRqlO4MivJBfPxdIHylufW6BNlJULXouA1l2RbpYb0/YZfQutXaxngZcFqxc?=
 =?us-ascii?Q?OZm2Nl3sc/0h4Qt/tBICe5Noe8jSVvjG4J5ZMvBN2JMKPyVYf42wPb7Xywbc?=
 =?us-ascii?Q?a+n1OFMc91kpcnhi2lrlmGrvN1tTleJKeX6k0Mugxv7loBJxBTV3jyaJLiuD?=
 =?us-ascii?Q?SSAL/U5VBaVRVORPGSMzaKTX8aK8Eor979q/UDrW3T6PYuN3Hy1JxTM/K1Ot?=
 =?us-ascii?Q?8pD9kbUg1EvpDyorYXgu9fLjPEYpghs0pSkKqy+MHEOn/Pxt5FKOQCJOcvOj?=
 =?us-ascii?Q?pHzFYrkJUqBhLdjEfysG/zr4RY3h5KDM7J/YMNSiOuBup3TapB7yeWcDp05y?=
 =?us-ascii?Q?7zjN8hFptKHj/fVK6Jtev/fa+VBseSlNZLXesjyAZqJ1FIQO6pT90Cve/h6U?=
 =?us-ascii?Q?lEJpWGjk+eNK1X1UVbkLAKjtHbQ26sfKuGzkO5znQm9Pdqt1EwYD9YK5V8iB?=
 =?us-ascii?Q?lsQcjQyomA8NEXcT3eKVq5cr/pfekqoZ02ks0x2J/h3/ndI7y4BOncFaKT0m?=
 =?us-ascii?Q?FP2mDihUbrOZ0i6GXEeN8D3P6Y8pX4/KlDrSc/R/QovQqQwQM6OWoT2GTZZf?=
 =?us-ascii?Q?Os6z7RDP8RI3DGBvn3pC54D9YBn4HU0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SWU3WuEqvURQ35xQk9qiwhhAbY35jJL+zCds/sHDuLNv4IDVD0LbtEW5I8B5rA1LSDwomgJzK8M1t1Vp8xSGZinMKE1rgSub2bTaOSIc4RkLoi4VzfWTVgVg5WlV/x1FHnNQ22zS+bcF/cqh+iOd3GA67eMXVeSWXSSBc0zMT7s3jpEnr2iFzd28kdF8e2XpCVqGQZDcySU/D11Qe46uzXb5RUKJeNVoFA8gPtxP97DvV3Ku0+XTprCncO+cXRRR8CAeIAFBdespUdkHu12ii8K+KbEHH1U26/uOqLOK67klQ24fha0yk9lKOiXgsTNkhWcBc9kOsmYJ+OZJV+qUZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a726ce-2551-466c-832b-08de8504799e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 15:38:59.9774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQpXicmbGhvKToNk/XVZHw2Jc2fCspStRjpVqWipPVlOPbFJTV0sBu4JDvuJ9iTjZEch7oieFi7CFPKyfUMARA9Y8JNf4Bn3/XfDHQIBXTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269082-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	NEURAL_HAM(-0.00)[-0.957];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 32E9C2BE7F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Agalakov Daniil
> Sent: Wednesday, March 18, 2026 1:05 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Agalakov Daniil <ade@amicon.ru>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; lvc-
> project@linuxtesting.org; Daniil Iskhakov <dish@amicon.ru>; Roman
> Razov <rrv@amicon.ru>
> Subject: [Intel-wired-lan] [PATCH net 2/3] e1000: fix endianness
> conversion of uninitialized words
>=20
> [Why]
> In e1000_set_eeprom(), the eeprom_buff is allocated to hold a range of
> words. However, only the boundary words (the first and the last) are
> populated from the EEPROM if the write request is not word-aligned.
> The words in the middle of the buffer remain uninitialized because
> they are intended to be completely overwritten by the new data via
> memcpy().
>=20
> The previous implementation had a loop that performed le16_to_cpus()
> on the entire buffer. This resulted in endianness conversion being
> performed on uninitialized memory for all interior words.
>=20
> Fix this by converting the endianness only for the boundary words
> immediately after they are successfully read from the EEPROM.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
> Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
> Signed-off-by: Agalakov Daniil <ade@amicon.ru>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index 4dcbeabb3ad2..c15ad95c63c1 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -499,6 +499,9 @@ static int e1000_set_eeprom(struct net_device
> *netdev,
>  		if (ret_val)
>  			goto out;
>=20
> +		/* Device's eeprom is always little-endian, word
> addressable */
> +		le16_to_cpus(&eeprom_buff[0]);
> +
>  		ptr++;
>  	}
>  	if ((eeprom->offset + eeprom->len) & 1) { @@ -509,11 +512,10 @@
> static int e1000_set_eeprom(struct net_device *netdev,
>  					    &eeprom_buff[last_word -
> first_word]);
>  		if (ret_val)
>  			goto out;
> -	}
>=20
> -	/* Device's eeprom is always little-endian, word addressable */
> -	for (i =3D 0; i < last_word - first_word + 1; i++)
> -		le16_to_cpus(&eeprom_buff[i]);
> +		/* Device's eeprom is always little-endian, word
> addressable */
> +		le16_to_cpus(&eeprom_buff[last_word - first_word]);
> +	}
>=20
>  	memcpy(ptr, bytes, eeprom->len);
>=20
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

