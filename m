Return-Path: <netdev+bounces-279308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNpbFAgm4mnt2AAAu9opvQ
	(envelope-from <netdev+bounces-279308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:22:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CBD41B2E7
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C76E301829A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403E9350D7F;
	Fri, 17 Apr 2026 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6fS0yWt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F932AADE;
	Fri, 17 Apr 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776428548; cv=fail; b=KTKhxX+kBWaJv6IIxnjwl8Q5d0p+Zfn4zzEYIcc6Z+y3wurQJoObHXyfbb/ZG+LYYXYuZ/h2LRsN7Q+51brzueu2HNANVrU4ySGfgzXSznkE84lG7TmzZj1OBITPQQawNSsYJRaD1ZGWpZtg3aroKP1iGHG0zbtQLoVtaNtNj4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776428548; c=relaxed/simple;
	bh=h+RJUtBYmKjXOVxKMW9EjPw2e0dWD5ybhlVzXYufKiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ptnoz9ROdf0Zj+CmdVVaFnHMTsKa+1f14Z3j0OKe3juHKeENyiT9PJesI6ebSI4KTuIRkHLteGm3gHsjn+RH5mxS9AaNDAteTP1pqaRjXQBnaCm2hjywlF4DCfopFM5WaLtZrm+/AwhM0BHNjDZTc29l/hDBX9HoiviCQfMuzUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6fS0yWt; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776428546; x=1807964546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h+RJUtBYmKjXOVxKMW9EjPw2e0dWD5ybhlVzXYufKiU=;
  b=C6fS0yWtTunmfgXmJ1KoODAKKfz/l0NwxzAsLVTynBeP3l3VT/uGjBXF
   jol7OSsMPM+HaODxcpjJtwOl8xqFsndPwH2GFQPHzIiBun4wl6gMos4o6
   pS1AYznhvqQrPpyH5cdHsT99ID2uw/iIEnxz+G16d7/dfTSmk2+g7KLEr
   ibcornKeMRfn8PTh8vkkSeUBSZeCVwT+1ueHFgonUlmD5TjbvA0DiIto9
   X8ZdY9sVa25W5G3bvIsRdPuLD8DmnVMMzCbVSiqDcBtRL6uql7HyO4Dqx
   h7veiUhXJY1E7ot4igIiGWuaAMPGJ1dQTAmvNV4XX8Mus0ztK15xsn5b+
   A==;
X-CSE-ConnectionGUID: zU5NQw7XQRa65hM08F669Q==
X-CSE-MsgGUID: 0mDdf6uqSv6TKPT3JRBMHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77562971"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="77562971"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 05:22:26 -0700
X-CSE-ConnectionGUID: WqFa4iT3TRGepyePTekx7A==
X-CSE-MsgGUID: fKKDY4pbR+G/wHB03jTjqg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 05:22:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 05:22:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 05:22:25 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 05:22:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUaYEWK7ICjgH/NWw/Es3WyPLNHRxvSia9sQfvbEut4YVIancJU8NFAX3lsvHRgZw1+s0v5BU2DVTalXoQCIRNvfH4WuXUpdgMWqqpM7jlbnmEeDqeIShmY5D3fsizSxpc6O9wzNkktX6EH3+/gn7blzmPix3O0CHh1U4amUQxqeoJWhjcn+7TXGn5bjjFY2gti/woMsJvfA8fMICaCaEyQqNRqcXra4Tm2l8j20dLehMYhjNbR1I+85We5h19OSPVdZPd5gyCCu866NXMjMSdnjrM1q1lCc8nNM1rbCo6KnSWKak21RmiQOegn5T89DRsASnO3KxVzBYMI2JRmWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+RJUtBYmKjXOVxKMW9EjPw2e0dWD5ybhlVzXYufKiU=;
 b=hTGYGfml+DvXBO1KDqz7PUAINyl8nti0h/SQYK6nKhV2DdUUtJbuw6lc12lo6RdtAd2cK7V8WXoONRWbQhgrjyyMxRWKtNRZUlH9JRq6VTFeUC4TlhQ1/lCCQlT7muP7tZwxyYHvjD9SRRqmDMpeJemeA8SYbd+QlYO/3iNBQNeqGD8CugCn/CgGhXG/4Rl0HZQiPiLC5wkE8E+D1MEeUTC8FzRoZNBu7ALvlJyRqTO7w3yDDbf+ZKvXPdFMZ0vV2hzGUQcaHRdKlsd+T49eya0iVxqhMg6yMK4O7THEq6ccLwiuBkKJtMFlA8wqavxsa9B8a0Jehr1xfssMVxeUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by PH7PR11MB8036.namprd11.prod.outlook.com (2603:10b6:510:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:22:05 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::7b0c:7df:21b8:dbbf]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::7b0c:7df:21b8:dbbf%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:22:05 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"horms@kernel.org" <horms@kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>
Subject: RE: [Intel-wired-lan] [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL
 type and full TX reference clock control for E825
Thread-Topic: [Intel-wired-lan] [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL
 type and full TX reference clock control for E825
Thread-Index: AQHcwvXix3hjxSFB2EyUhfJETBJtn7XS5QsAgAO7FYCAAOemgIAA3aQAgABojwCAA9gqAIACh5+AgADpDdCAAc5xgIAACEIQgACY8ICAAJvRkA==
Date: Fri, 17 Apr 2026 12:22:05 +0000
Message-ID: <IA0PR11MB7378CF62D86454916AE8F9D79B202@IA0PR11MB7378.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
	<20260406192312.0f7a2760@kernel.org>
	<IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260409181041.395a0c37@kernel.org>
	<IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260410133812.4cf9b090@kernel.org>
	<IA0PR11MB737882B384AE7279EBCD05C79B242@IA0PR11MB7378.namprd11.prod.outlook.com>
	<20260414145835.07fbe355@kernel.org>
	<IA0PR11MB737842E2098D0952A8BA1FE29B222@IA0PR11MB7378.namprd11.prod.outlook.com>
	<20260416082751.04782987@kernel.org>
	<IA0PR11MB7378FF7BF4EA32C1F89372C19B232@IA0PR11MB7378.namprd11.prod.outlook.com>
 <20260416180447.1a3c5c87@kernel.org>
In-Reply-To: <20260416180447.1a3c5c87@kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7378:EE_|PH7PR11MB8036:EE_
x-ms-office365-filtering-correlation-id: 8d818ec6-06f8-4976-64bc-08de9c7bf012
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: j2wV/PcwMQReC7+SyzJWVD1gZ7qyoQahhBrRGMDBXQr8k9HoyJp2G1XQ6h1alY7U6TqWpARcd6/fRvl0U9G1vx7ibxHiHvE5gI/21SaVCsspja1RudiG6pEkHbcXDRWhRw0JXj1trlY3PZg4HqTrAD/m3EkGtnfDuhv/JDtd8gZmjY2+cx00xqIz1pkC9XHSWLuIzHgRAOYROe5KxVf9J+DiTuvlD0dFJhJVh+nGgrANbwxC+Z3vcRzs3MHJULWwWQuQTnApvWZPE94FCJw79NYWq+b7OVz6vtZNkHRPDyQarqUBsQI/JxkIj2KGAA0LOlw17Thfd+SW7ZKb77igdUNuY4QBpZTGWuQNuvsVbn3QLMdwfurzmvals5qxseCg+iKF614UCUEtI1K9RCXwKshV9NeqpOvGB7BsYIPZcFfBRpmcGMOUQaj50dEeAO6ks3cxGsuWuGqxUbC4A0YsPCr3kQ+Se3j9sxmbgHXECw9rX1CqhvmdhAti08fsfPcrDRzq6QHnyI/do4f/kYTSY3uuvbfWFYzR1PZGXOyzFEfGk1A072G7MGqWMG6V+H2Ylsm191yGrycdK7Tc43GPra7bak3so2pv2jwSoZ/PSAhRPUk0hDYbbm83J+PJWMblim8KehMJ3M3cIETr1tfMBFCb3iPGh2UsjX9Hxl5oxqOo3cBp4ilf9eyJvHuQz/+hCBom7eWp7InpukrcwK7EHeMbZhFgFczS4LC4s+y5Dx/H+5npaCstnnVBKxGHrx3robppGBmf5ZZPQGIXur7OhwY/iV/WAkpFfiHo0Yreqe4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9/1NuBm1Tzn9KdfcRdYh8j61ng7fwDg++xi1t7qIEvNSjCRLAhgbQiv7C1+6?=
 =?us-ascii?Q?ZA7KrWUPw2Dj/gEtgP8JzMWCcmz+qFE/bLcsaGg847k+FpevheF8TV1mJjTP?=
 =?us-ascii?Q?APz5LfPS9AarbL9b5BEpWL6cVr2+ZVnoWkAla8lQ1XC4QYp0Kg974JsZoxIi?=
 =?us-ascii?Q?MQuO6Yh1YupdX1HnxOOmqBbKX2saC08s3nwRckcj8HSJYIqhDwUH81K2foll?=
 =?us-ascii?Q?HVif0bI4sNSwerWSNeY2sVcdFt+6icNbOlydYvia0dZtL0zeteoPL+yiDiuo?=
 =?us-ascii?Q?H7jNGTk7lhC1VjFieKSgzSW4S1my/qGxmxzLneGGTF6L0EzAMlimeoeiZ+vd?=
 =?us-ascii?Q?mmVaENSSSicPMDUvNnxk02VTrJiKywa97FEZR0/GMP4/SY84icUPxPE5Ajlm?=
 =?us-ascii?Q?IOJVf7gP2ObQu0+veSCItCBjUwodtMWhc0QezlkWMwwmk89C6zysiIfwjJaU?=
 =?us-ascii?Q?mJwZ+QAm+J9G8UfL0/wfeOlRDW1J2Uk8cLQJh/sd/k2QQYg+8ysgDVTZEsMz?=
 =?us-ascii?Q?5iRQWiuKCheoEmPe4emxRiOM5iZpMztS8Rdbm9igjFALcAW/GW/Vi7CoPAHw?=
 =?us-ascii?Q?Gx2PvYLdNyBPvqeJPQYK1b8jUzppyEKG3M0i06nMdNN8AqIgZrHAu6shzFsR?=
 =?us-ascii?Q?szWnpJflhoHqHOvWOL5NikGllRugMS6oXwaDNonkeB4euEuTclgXimmCgrih?=
 =?us-ascii?Q?KGlkLsR1eSU4MPbnurazwtOPjCw39Dutusw0xoyUlkwU2InpDJnP4C3CFCO8?=
 =?us-ascii?Q?ChjxoDcem1/MtQQf1YgDQmLt3wtNxguX0IOuXVKsrGntefocmG0c5Aq1y1PO?=
 =?us-ascii?Q?20Le70atAFZaBHItWYqWp67Mxzn+JDFtbzGosUxhjTJnl3bEMUr89W5bOlJ2?=
 =?us-ascii?Q?bXsV2yyuLwF0an8T1qJ7ebl/KkdEQUhvbPZuBxdmV740eQ5FXcay3iH4TglB?=
 =?us-ascii?Q?lhizI44s7OppkawNeBNWqrcSUN8DqfWp74Hzvno71LmeOy400b8kR3OMTchd?=
 =?us-ascii?Q?4xw9VYIxF9ZL5YERTh/h2SzVA6cBYrP1x4VYN1u6pEp99OrsP4Q6aYw08jFP?=
 =?us-ascii?Q?VQutw+6NofI1z/Lrx1p0VaRBGFNduIzJSb2ld+OEt9yjOW4ORz5ELhAOkkbq?=
 =?us-ascii?Q?5+Bo5P4lvYdi6EeuR6QIvnbhKBtgA+MN4melzQl931jjxPdfk5g5nxzmazqo?=
 =?us-ascii?Q?ugHCFNotZvU4ICoilgJeU7SgfTOmyCgsDbxQbrt4WAx6C3jwU7SL/qSdv+LV?=
 =?us-ascii?Q?Y15alYZ551Eb+4mp1y3fkczOUS8v9bhuV6+ywb0bCJGaz+UO5O9CJ0eDjeWp?=
 =?us-ascii?Q?IGeMnT9itrLbkkv4YG1RvJiBGUNQVZtTMeIUQmKKtf1sYsWv0oNGpZlWkyS+?=
 =?us-ascii?Q?p7oIjc9tyutZB9iA4FXo/Wsj5psDAuQVVIzVEjDBp/iSXN+2+Iq9lOurWzZq?=
 =?us-ascii?Q?3s6EKzs4rsB68HqsDgPgYO+ZhgvM//nueAbo0jcN9iby8X4PmT13i9HLwKDp?=
 =?us-ascii?Q?QajhTgHa//yGK+aNz7kHuqTaMqbZ4QQak6LRRt7Ghykc6BQHayC3aoMt6/2d?=
 =?us-ascii?Q?xDXg0S9bvO1BfA8yNQ7fSBZdQGqtAvqml3EE1GeHU6OLaopuIhQfE5t+Z/2d?=
 =?us-ascii?Q?s5K0TS+GqxqODwLrZHNgGapaPa6y0JP69m9EKcXsM3OehkIkSH3GwsP73mfK?=
 =?us-ascii?Q?2yJWWlVisLUNGx8ge3GmR3vmtGfCIRSIGWqRykgUrD+jl/V7lcXQ0hyp0KME?=
 =?us-ascii?Q?BdJvooZpxj9rWBnuQ55Oj7LpfJzjI+o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pNsYjvxXpPu+iOoJ8Ka5v5VmTwBdCEyuNKXjx8Dl5dgyEfdukDMQFICg5mC4Voy4QN9otjfwRtou0/Ca5tEqFEivNZU0kh1XDVM/3YuivGOvYRZb3qMMGnATb27jmEYbYk+59J213ml4+74BXIoBaX3ZnkZN/zvkysVXcJXAxit+Ht4o0FxbJuRmp7W+DHhWywmfHwrtOfOrnAnTt0cCWcl51BMXaW18Q+Dpu3/wfyDOAdNEpIRAQUDdwOD0LpeKsoq0gdgypRUP/kkyRrHAhFu0DPiK7d7vlNzy5nS9n9D7Nnt+W6V4VRY6A9IiqIJ2fhSZgCm9Ve10sIexFlsDUg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d818ec6-06f8-4976-64bc-08de9c7bf012
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 12:22:05.5642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtJwxA1CdRUK1VnMKmYSnWNwgcKnDZh9ugtNzh1wFFEjXy6UWIn3Q4AinVHhxRsbc78fM3Sy0Tisz0G6KBmGpaM4Ewodwy3UW4XToBviWRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8036
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279308-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,google.com,vger.kernel.org,gmail.com,davemloft.net,microchip.com,lunn.ch,lists.osuosl.org,kernel.org,intel.com,resnulli.us];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,IA0PR11MB7378.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D1CBD41B2E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Friday, April 17, 2026 3:05 AM
>
>On Thu, 16 Apr 2026 18:26:11 +0000 Kubalewski, Arkadiusz wrote:
>> >> This HW doesn't use EEC DPLL signal to feed MAC clock, as DPLL is
>> >> external from NIC point of view. Only 2 signals from such external
>> >> DPLL
>> >> device are used by NIC:
>> >> - synce (a single source for all those TXC per-port DPLL device)
>> >> - time_ref (a source for the TS_PLL - which drives PTP timer)
>> >
>> >No bypass? The PLL is actually in the loop? oof, this is beyond
>> >my understanding of clocks and signals :S
>>
>> TBH, I am not entirely sure what do you mean with MAC PLL into bypass
>> mode, but the HW description I have provided is still true, the MAC is
>> not fed with any DPLL provided signal here. Only port tx clocks PLLs and
>> a timer PLL can use those.
>
>The ASIC PLL IPs I managed to find had a bypass mode where the reference
>/ input frequency still goes thru the dividers but the PLL circuit is
>bypassed. I assumed that if we want to distribute a syntonized clock
>across the network we would want as few PLL circuits in the paths as
>possible and we'd use bypass (which would be relevant here since for
>the target use case we wouldn't engage the PLL of the TXC). But this
>is 100% guesswork so I'm probably speaking gibberish.
>

OK, thanks for explanation. I don't have such details about it, I have
seen only high level design drawings.

>> >> Well, 'floating' MUX type pin not connected to any dpll would require
>> >> a
>> >> lot of additional implementations, just to allow source selection, as
>> >> we
>> >> have tried it already.
>> >>
>> >> Wouldn't more generic name cause a DPLL purpose problem?
>> >
>> >The old proposal in netdev family was to to have source selection
>> >without creating a real mux. Not saying I'm dead set on that direction.
>>
>> Yes, correct, it kept the list of dpll pins valid for source selection
>> of
>> tx clock within the netdev and control over it through RT netlink.
>> That solution was rather simple but you requested to hack into dpll so
>> we
>> did here.
>>
>> IMHO this is cleanest and simplest solution we could find to keep it
>> within DPLL subsystem.
>>
>> >> We still want to make sure that given DPLL device would serve the
>> >> role
>> >> of source selection for particular port where a source pin should be
>> >> an
>> >> output either on EEC dpll or some external signal generator but
>> >> somehow
>> >> related to SyncE or similar solutions.
>> >
>> >Right, but adding a new "type" per location of the PLL (especially if
>> >we lean into covering any ASIC PLL) may not scale, and opens us up to
>> >"vendor X calls it Y" and "in design A clock is fed by pll type X and
>> >in design B by type Y".
>>
>> I was thinking that this is more like a purpose specific DPLL device, if
>> someone would want something similar we would have to review it, right?
>
>We would if it was a Ethernet MAC PLL, but if someone wanted to expose
>whether some random PLL in their ASIC locks - are we adding a new type
>for each one of those?

Yes, that was the implicit intention within those patches, if other purpose
specific PLL would have to be present for whatever HW design and user
control over it would be required, then that would be the easiest to
maintain in the long term? Multiple types and each have own function/purpos=
e.

It would be good as long as there is one PLL for a function per board, once
there could be multiple ones for single function, we would have to add some
enumeration (labels, etc.)

>
>> >IIUC you do provide "linking" of the pins? netdev will have the MAC pin
>> >assigned. Is the pin that connects the PLLs also annotated so that user
>> >knows what's on the "other side"? Maybe the topology would be clear
>> >enough from just that, and we don't have to add a TXC type.
>> >Call the PLL "integrated" or something generic. User should be able to
>> >trace the path of the signals?
>>
>> It depends, TX clock has one of external pins connected to external
>> DPLL,
>> but second is a board-level pin with ability to provide some external
>> clock signal, the user would have to determine that purpose just based
>> on the topology of one of the pins, which seems a bit problematic?
>> I.e. if at some point there would be HW with only external non-DPLL
>> connected pins?
>
>Not sure I follow, TBH. To me the function of the "MAC PLL" is fairly
>obvious from the fact that it has a pin exposed via rtnetlink. So it's
>obviously a DPLL which can drive the Tx clock?
>

I am lost a bit now too. You mean clock recovery pin? And EEC type dpll?
In this solution the 'MAC'/EEC is external and it doesn't drive TX clocks
directly.

>It's the function / relation / linking to the EEC DPLL that may not
>be obvious. But user can see how the pins connect they can get some
>LLM to draw a diagram of a live system.. et voila :)
>

Yes, correct it would work for this particular HW, but adding a variant
without a external EEC-connected pin in the picture would be problematic
to understand 'generic' dpll purpose, pointing to the labels later.

Just to make it clear. I believe that generic type dpll could be used in
any HW and for any purpose, so after all each such usage could possibly
introduce entropy and confusion on the user side.

But if you are fine with that, then sure, we can live with generic
purpose dpll.

>> I mean 'generic' type is something we could do, but as already
>> mentioned,
>> thought that we want a DPLL types specified/designed for some particular
>> functions/tasks.
>
>I feel like we often get labels wrong the first time around, so if we
>can defer adding them until later that'd make me happy..

Sure something like it later would be required.

Thank you!
Arkadiusz

