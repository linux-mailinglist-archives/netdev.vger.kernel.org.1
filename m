Return-Path: <netdev+bounces-271441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAnxCxWSw2ncrgQAu9opvQ
	(envelope-from <netdev+bounces-271441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:43:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55542320DD6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D0A130AB65B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA6D377560;
	Wed, 25 Mar 2026 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3iRDdqS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E3376BF6
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424378; cv=fail; b=eBg3pqOGg+I5sClpxQlCd0ejLJPMb8qbv3wlv9ldJpzX2eYdAsOX1OJ3qwapIia14fhmIi4uiHEfDtBasqBdNd7bsi7O6ZMCHai3W/f5J095pF690T1AspI3gFC9Skl2feR7hhg0ALPv1HC1SrF0NX3PIB9bfovBgGO73ClaPU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424378; c=relaxed/simple;
	bh=f/JxnOcsa6YKqdjuG1RN5PZUP34+SayVv5OXDxGvoaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gm51YLDdQlwE4mV0kS/BKaRGS0+qqsw6NgB9QtSTfP1Q2RbyJwcqkQO4gBpkfsNv5pgMRWyZ/r/ZhEVJWqiJNn/4saHyMs0HdC9QX2wEQrinU3y/MWtV2JFYjwHdF4iuvHnx+Xje2URXg9jhea8Cj2V2ZEvG62UnOKKwekFfG0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3iRDdqS; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774424376; x=1805960376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f/JxnOcsa6YKqdjuG1RN5PZUP34+SayVv5OXDxGvoaw=;
  b=h3iRDdqS7x33JFKE8M49eL5KwJkCFNV+zC1SR/3GYHmGz6ZFN6IwRlIu
   FhTwIzmHeS17AWXhVvVymgvmVmnkB7vzyhT+7tBHSy1pYJgYvqzLcuBAY
   18dqh8mdI8flZFuRPhHtNMriWwJEwbXtbRu3BpoDh1zyjJSRhaYo+CW32
   tHvDpxUpaj/k4KXovtUxiaRQ6n+592W3ExnnwtGMP1n/1Ta5LwXFNHunV
   DqRWF4trmSCLyV8gTzc2TFfp76KS8E7QODw6HqyrZUBi2RPx1ijzMwenj
   lqH1/azF5eioAbCM6xBWEHb7a1dXUKHzlc3FuX9ZmQbTXUgtc1jTI0PQz
   g==;
X-CSE-ConnectionGUID: QQgSKFYPSPqcoAsmWf+Low==
X-CSE-MsgGUID: aN38jWwhSlOdgrsJ5JPvmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="85765018"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="85765018"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 00:39:35 -0700
X-CSE-ConnectionGUID: qifzTXs6ShivR4nFECO7ZA==
X-CSE-MsgGUID: G1XJimh7Ry686PeLj9xPrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224863605"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 00:39:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 00:39:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 00:39:33 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 00:39:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGK7Uoa55c8XaYzAoDA4RoAHeO1TQrg9h5VChwMpqNMizu30MoysaKqIXzsutHSKpyiZcrKN889mgU2lWJI929NC5jJHEPn1a/la4eTQVDUeAj6+IPufHXRwzLjGlrpf+W9ynfWysl57tV6M3erD5vZTJifLt+k8JDUMfOF/hB8/wLWLoW/yTVt+YHyWTFECzGRPFJeKf+H+cfkTMF9s4+oZ/ieqfkgxMp6qN8tgljyNaLGHvMONM+WSzFnOqHLDtsrLEs6CEeioKFgwgQyuLeEKOREntLLD+rE/wS+i7UzxpRQSN+Wdy8itZ09wbDXNOiXV3QSn6wzL/aOcBtjFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYW2tgqhHo+owO4tvp3IgQsn+YZbKf3veshkBIr4Hwc=;
 b=azdIR1ZrC707YbNRl3m0x/Pw9CiZROCZBG8+BviNSfyGW79y0y0yfLLkflKbe0FHmOsdjP2/OCOmu8wFD+SNqFZOKNvtN2e0a9eFlaC8KUYcjrOfrBzVitJU5/q47U0TRKl1cPqhFoWkNhu8Bw1ryoUPIIff9AMI+4hyBVP73EWTmXp0cI8nm6zPuQtP+qBa0yX2C5CG+9SIJ7FIjV/UoQNDV+bL/tndeOwknupbdsCkoIracm/riC32/joFhk46YhPHIFNLBDS50sqOAwFp6cWQV10xr99e0WTKIi9YkPc6Uq9S+8WJBRfkvY8o5WOi9ZGjfj0EVz9xfYjHq+TujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 07:39:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Wed, 25 Mar 2026
 07:39:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Jiri Pirko
	<jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "Schmidt, Michal"
	<mschmidt@redhat.com>
Subject: RE: [PATCH net-next 2/2] devlink: unregister shared devlink resources
 on destroy
Thread-Topic: [PATCH net-next 2/2] devlink: unregister shared devlink
 resources on destroy
Thread-Index: AQHcvCEa0R+4EPZh/kmFtI1r4a90I7W+3LLA
Date: Wed, 25 Mar 2026 07:39:28 +0000
Message-ID: <IA3PR11MB89861D42103B1981EADEC1A4E549A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
 <20260325063143.261806-3-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260325063143.261806-3-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6500:EE_
x-ms-office365-filtering-correlation-id: 2cb571e3-d026-424f-79d8-08de8a41a551
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: vTZQ2ZYEGGGHZ+lRdkpFMyt25qL8iSXTr8DwNoWpLRqa83PjnY79WkKkul5GsiERtZonDNyORIrW5HfXs2lFAjOhrgASYSQlaSpLbYV5SgiIhnmLpthM0UFxyu9SsYGxKyeqTC44Lcf8PwtSuQmS8jWUJEzUtqj65jLPTWhwsyNSXaJOalKFLavATqrAZz2vu/DXAZ/QhTu51V6FMM1Y/DAsGoLmKcPkb5QHLje6GEY1hipq1+mF3biwg0v7vSd+6MqLQCF8NZlGzHXttBbBI7awKebuq+XxXpezH2c3JWe886wW3PtjoU6WSK9DKOoAcRLh8g50SotK93hpA8lNrdt63b/dRIxXQLos3LvNNE9QO2DTSudvRIyyS5ubqImYQbREOk1HKt+vVIpnOLFEju9vlKm3t0GiWMe2f+HYxSVMSISR4aY65jJ+vyaKTP6AxiY33BXcmajogdufjTqsPLuLE+MrgWYVaQIMNx73mZBrAD5MORY/Quz9hCHGIM64MgIGAectsmvpx62rYustmPrMfTn+KSDLbN+A1JFpBNH8M5ZH03333t9sF0pMKjCkjJlyPAKq6ceh87Ws+1WvFEC8MGWZraTaGugP/+PoVdMu16ert5XtRsbA3/6ezheyPFghXU5dV+iQG6IveKoT5VSIGVCSAx8sO/1JMtYZ97LJQL7Tde38MjLcH9POU8xj5uNBqAcO3z0JxEnGDJu9FKaz0hTYTLmzgeAOH8Cpm2AeXid6T3my5+eXPEqIIIeoaLexxLFL9g7zn1/JEdHxjcgGjSZ1Sg5Uhl94j88mK/k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i1hJd4zhz+gEsax7iDKPaSiNamPOwAoHl+fh670QVl8SwHMG9BUO+kNKaRVl?=
 =?us-ascii?Q?MfAQSYUVg1RIhyU4ONu/52IzdXJhC++fgKSH1Ck8UfK3ICHCFQETDUsYnk00?=
 =?us-ascii?Q?qIjeKEnRWp+s2phUEYVH4BpINenb4tosEszTGAWl0mKYfuRMB9ax0XA4FVCA?=
 =?us-ascii?Q?zO4BiGaRyKXW2HyQhpJZvbd/0tAbXJBxbAU9oYRuiDtHvKo5IsZW/tuVu0Rr?=
 =?us-ascii?Q?1bwg6a+L/a4mayyI8Y0CspDqKax5OOh2o5KtQqKSAwUYsFk+YcBzkhGc2BlK?=
 =?us-ascii?Q?zpZjAjPvOx3+ppQJYiV6AeoiK4iu5y8I9hffpVJV+co2pfh+M31jtOhfSWUp?=
 =?us-ascii?Q?WRUigm5ZKUBhy7LC4/FtdVR1pkCH5FGpQu+niTPDmwZUJIk9hAKAiE6l/+OD?=
 =?us-ascii?Q?Ti0M+kGKqdhP1y6Gemvql67Ij5p5kEQg0WEBrfRqa6DQ6xgjbJwIa2AL68P8?=
 =?us-ascii?Q?QUxFB0M4q7AZsCxV++gEByhxQja14VIt0t9IykA1QFRyQvCb4GUKfeTeswiY?=
 =?us-ascii?Q?PiYV9zc9HUNjXG5nWbJ3xngBoORP6LKR+NDONCtFwDdVrvaSQSv0HRZFXDmy?=
 =?us-ascii?Q?CRoYA+tpRCvmIsW7UgcVYczUzbTEbtI6CMGbwsPXJskcI9+F0lWI+Tlilz9A?=
 =?us-ascii?Q?kMmlC/d/PcU7Sxpf9Z2jHVxhCERxBIy7PAg6iXGv/Uwh7ufgMF8tX54tnXxK?=
 =?us-ascii?Q?is7AojFEmdkNXlLGqUQf/qgF4Ge6JE6j+VlghD8mtzz47oFsO5c9emQl4dm+?=
 =?us-ascii?Q?ehKxNn5Jprb9cZ62m6ngTzo8Y0YwGA2w5X5XuhvUnCLLO+1DBjeE19YuM0ff?=
 =?us-ascii?Q?s50W/Y5yPhqmiYEn4RXNYno8eG7Ili2LHhZLwX8oiJfldOLn96r6r7hrkG8G?=
 =?us-ascii?Q?8vK9Bx4rFFLUBxUc4gvKxZjX5xblTiCfK6ClfjHhkZeX7FUxhYIDNKC9qwum?=
 =?us-ascii?Q?7S/q3x3YcEchIdJS2AAfCx1Uu8MujtGR95YFTcs4a/ryobgEgCSTRrT1OhJd?=
 =?us-ascii?Q?b/TVdnFjUTX95YP3AG4ygEgI3uHsE8MeR984buOR58VGbEdVvRuSBYWeDl6O?=
 =?us-ascii?Q?j05rZrbGptPP6dw+g0IEUqAXAJiyCqgxvC6It3G62gQ1MwdQwvoEo986cPno?=
 =?us-ascii?Q?Hwqms2fG9XD0HW/MrozQeiexNUQoqHWyk/PGpF9UvorPirjZoAaCc0v3DBXJ?=
 =?us-ascii?Q?6ofGF5lPkcxe6bLBLLEkMT1ZZnqGrMe6L8PSzkRYZZh+5Qst6x97rLxzE/2l?=
 =?us-ascii?Q?zUpKEDQXBnVfl/DJOekJYVSINnIpbr3o89D5jvQ9TZv1gYAbZ14qlQkxBMAt?=
 =?us-ascii?Q?Mnmr9cRreIzEz+oGMxhgPmJju58zE+ptAlfiTej6rGtonu58SJlVs6We+Z3h?=
 =?us-ascii?Q?KPnSBSzLkGTAC5IY9MDzi0PX8ZJgvS92GO+5QXWxOsGK9ByhnKOb+oLRy1dD?=
 =?us-ascii?Q?YrHNp6OfK2Ke/SbfL0Al8ITfwRxly2pDKPwm01NPbSlXQrbp1LpFRlXUbeya?=
 =?us-ascii?Q?9/p03QbAuqwca11zc5/vI9yYeM+FOx2uVdWYMq8OmO53GNMB/U37h7Wp3JEj?=
 =?us-ascii?Q?qIVuYlQo7KA/sO1HHaEqPEz84L0yD5nHwuMED6p3Xjft2dXKEuSrBxykZfQy?=
 =?us-ascii?Q?sTaetkkyyDsGcBD50Ok6BYCcO1qUac5g1/XZIyXUZI+88eoAzefVio3L7cOc?=
 =?us-ascii?Q?i3kbhTWmVeOGJbHecEi7r9wXKSJxm70wqsJBdROtbvQZg2tXlk/HBujoY2iG?=
 =?us-ascii?Q?UbQ0t9o/rBIauEqoBPBwBLcjlQ0XzCg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vSVb1+GTmxuNCMiy/38pLBTs7YjZ8GjVswUWU+4EQ/1HXvT4hvGBeprdgAGC1tWL9VdeO3JWNAqF7xpzsx8Po1URoRMlFzIIoT9XGlxCHP1faO1qndw0FBW7GUgLlDJyyp1b06la7wKQBvQp2oXA04Kd0+JXiXJZJpvVNaQlSbWJ+Kzo00qC4bdLDDissVH417FgboaOXr62sG7bVP+3g3f5gprClv9nETiKGTExi8VCu0/vVxX1gbX3gRC16jXjzRh43ZWqNRFTb9iG890fgRGIo1BVZREiq+M0BFW/VT6EqWDTSuDmFyFi287Q1qol/v1iHjzls8RMx/E2ZbL+bA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb571e3-d026-424f-79d8-08de8a41a551
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 07:39:28.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ZLN6jUzqbjls46aYJsZXWWFuvWOvaCfyeyS7oGKaO8rkKkgQtOTtX3ls+BTHzRgR8GodzoZ+Wj2p4pjCBN0udae7y9hL8jC/KWaN2l0GaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271441-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:dkim,intel.com:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,resnulli.us:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 55542320DD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Wednesday, March 25, 2026 7:27 AM
> To: Jiri Pirko <jiri@resnulli.us>; netdev@vger.kernel.org; Jakub
> Kicinski <kuba@kernel.org>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan@lists.osuosl.org; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; edumazet@google.com;
> horms@kernel.org; pabeni@redhat.com; davem@davemloft.net; Schmidt,
> Michal <mschmidt@redhat.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH net-next 2/2] devlink: unregister shared devlink
> resources on destroy
>=20
> Since shared devlink acts as a normal devlink instance, capable of all
> usual devlink operations, it must unregister its resources.
>=20
> I plan to make use of devlink resources on a shared instance for ice
> driver by separate series, coming soon.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  net/devlink/sh_dev.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c index
> b85e5cb1edbe..5de138bf3630 100644
> --- a/net/devlink/sh_dev.c
> +++ b/net/devlink/sh_dev.c
> @@ -71,6 +71,7 @@ static void devlink_shd_destroy(struct devlink_shd
> *shd)
>=20
>  	list_del(&shd->list);
>  	devl_lock(devlink);
> +	devl_resources_unregister(devlink);
>  	devl_unregister(devlink);
>  	devl_unlock(devlink);
>  	kfree(shd->id);
> --
> 2.51.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

