Return-Path: <netdev+bounces-294124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CzhEl6nHmpUJAAAu9opvQ
	(envelope-from <netdev+bounces-294124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:50:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C6062BE7A
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371BC302B088
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFEB3D1719;
	Tue,  2 Jun 2026 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7EMcVT/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF41F2380
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393387; cv=fail; b=BT4+d3mEOKj4dMXuCU64G9Kn8d9S56fJuosKdD3eZWTadJ6zrIGhSHqXFPC+Ie9i3LHJJeE6bdl4Lw8xZ11Y0wA7tP6vRmW8Hbi/ocR6i0+I5XqjS4IfX2AkMoNL0bHDf2gjE0j3jT2+12yQXCMn6SX6DlqdI5vDOdcAq8gocKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393387; c=relaxed/simple;
	bh=xntQ4fboiD0qL1eJ9GwRBxI6624V1rRuFBlpZQkjL1Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sb21/klMrtETs4WEMqTnkzRXYxO99dm7g9vEV4zI0275IITweOMfD6rf295XtKNcoBMpkwMCjerpceHc0u6hk/3iDaM4VX46uIlTiF0Qbx46r9hwHOCjfazgu32dp+uG7KSWipBiowCGexq0HO9bUC1Zpjiy8u+5zB5BQEyeFrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7EMcVT/; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780393385; x=1811929385;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=xntQ4fboiD0qL1eJ9GwRBxI6624V1rRuFBlpZQkjL1Y=;
  b=D7EMcVT/Aos5EUTQrynLKEHc6LIsOrmuwYEy5MGrSZpwyRTl7Zi/ofFZ
   RsAaYMd21toCzsVm7nliZaOxdRd+RmvoZ1aAGDht88n5+ln7wqJXVQiTU
   mVdmXGwbSb7DJ18UkO3QndtpMbvbN+n2o60OAyajt8laullmHQ8SccSrU
   542huRf76fg4/LD+GHDZ3eKOszBttut+G9fBKFSUNaMHlKrDiUgInSs5K
   u9jMt73FVwggip3qbUQToFN/MskcXjTpnEv3DzYuoO0nUdn99J4+d1HaJ
   t3BtUdKJlUSf6Siqciwk09in1V6FoaiVvakV3FGQKx3PetUuUlV+Mrr+r
   A==;
X-CSE-ConnectionGUID: ziqM0HVcQamT/B4UA6hEwg==
X-CSE-MsgGUID: FlPbArQETN2/Z9InaHXEPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80318620"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="80318620"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:43:05 -0700
X-CSE-ConnectionGUID: nghxuN6xRuSi5uwvNkq/5w==
X-CSE-MsgGUID: erXoWnXiQYilnFv/P1+bhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="248784911"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:43:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 02:43:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 02:43:03 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 02:43:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnvuUe4yx5o7gomoz0fBBdEk5w19oK1dtzvdGdHdfmfZ46P2YqqkoC4Ydv2xxfcM2+FwCfZ3yqTKkb6zCvxQmipAb6hgIf85IKEgiXVP6Otiv66nl3l5wh2W/vEnJYJWPEZ03jf7BqF0EQ9h3QmmbYfbMRSwxzS4IoypLeM8hNYiuI6JtoGxDtxq3uLaA43TGWUNSy+tN0zxg1Jp1kGUv+pDw4BMIuqMlVgOv87lCq5OOFUxA9VVtwjY3onC0weYAmqs5apIU68CO4trcMr4e00xgB4rlARu4GDpx5y1JcHOEVPcUwAw9gV+Ulpn85aeHNyyfucNFMi1yPwHoUJ43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xntQ4fboiD0qL1eJ9GwRBxI6624V1rRuFBlpZQkjL1Y=;
 b=nT2fw5YIOJAp6edVFi3lIgDxnBi/IuPc3O/pkrKapJWL0v4N8aGMDhKaR9x2qZwUcZVP7EzqHv8vqLoifAQwWZjryjhsm9INRIEDp7ZdqL6hJmqdc5d1MJeEO5rkh3eVMcpSqXCabQn3U4jFqYv3ffcUdci89Mi14gZnc0WXMIrpHM5v83rUjbgbxomyPquc99I9/dpYNA/Izx7psQ3ey/coKbNueBcC2Y4p2rjgql8RoOzmuudnbvabLOqtYQnpvT5uJK+7O2QZGq0F+iXwiIwcpYs4DC6vLiAp/lQlxBOVpnAP9/s6j6ipZYB8ugOrJ8D3nqfHTeqxqOZHI0xfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 09:42:56 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 09:42:56 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Markus Stockhausen <markus.stockhausen@gmx.de>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"chris.packham@alliedtelesis.co.nz" <chris.packham@alliedtelesis.co.nz>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "mensi@mensi.ch"
	<mensi@mensi.ch>
Subject: RE: [PATCH net-next 5/8] net: mdio: realtek-rtl9300: adapt spaces for
 defines
Thread-Topic: [PATCH net-next 5/8] net: mdio: realtek-rtl9300: adapt spaces
 for defines
Thread-Index: AQHc8lEtiU0gXZQI9U+Esf0hzUMyK7YrAxkA
Date: Tue, 2 Jun 2026 09:42:56 +0000
Message-ID: <PH0PR11MB5902B7C4C07107C3288500ABF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-6-markus.stockhausen@gmx.de>
In-Reply-To: <20260602052640.93083-6-markus.stockhausen@gmx.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH7PR11MB7449:EE_
x-ms-office365-filtering-correlation-id: a82b4985-85f6-4827-5e47-08dec08b533b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021|921020|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 2RmMw7+ct0nYSknsTTQG5PL3GwbMNa+PZJdm3OV2LAO1TnbCbUpPOc3hDZzCdfrpVxtYGoDZ++D7EXl2lpEOejkLfAz/TDxlNzJ7v9z5LgykuOGAa0KkiMOksIlO1U4X+aSRZfiwXhFUiIPlZLHbOZ44rUb/ugCmTz019YEKrGqbZiH2A0ii0+dx9NrYZf12QVmcw74aPy4ogx1ewwaAxlIn/kjDEGmfraz8NiAVNhbbr+dHNuOivg5uyx4hdBL+YeTUJJZlbK6O5r6c3+zL8IbBj36wB1SyxPPmkUPeNiH0eHT580O7meocPKIFFOBpZ6kct5S/hHBRafeNBwzWkxRp/F5aIgf3i3SXhM4rf3DqDXQ/V31vyRD+oTlsrxVle5r3I/Qd8wnL0F32/yCRiFUfsk6+Jji7M5VNoP459wWE8K3LcB6MJqA8e1aNb/uaH4btzLb/9weXug50RrQypZPRgfGzD9Hh2xC57/op27auVB1WbO4Y3xpILhJAoH1/9Tecjj0/XEtVbXVoYoKqyAL9ZeeyBzF8DqTe9m9wm1qpSKBUr78CV2BAwHlPX1lCf0w117HxgB5oeKo3aHrs7LKIWVqPkZsFXEPFoD2vSX1Xd+PJI2eAeIbxO20829fzzj0PjDZ9LWlzqm0I3FLCimTHGXEL30nfd1OXo9PSRFrbfIUr5WosmpT5svBgETBvniZd6zq5/WjuLAERrWc+ohrBMFs/OmYsm3aFyTQiglaHvYcXQqc8WL8BjcGgcYBsIRgFwUm1dyHBABmAUB0nJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(921020)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2XVQhA3PZCPzghGav60GruFCeY2acstIJfyk/0lTH9EhHTh9y+Nr1sDavGgT?=
 =?us-ascii?Q?lfE+OlpaHmhVtor81dyppPLyK0R0k2hFXaqObyVSBf1gi9FHwa/guUAS9yRZ?=
 =?us-ascii?Q?oRvGttvjnYuytHuHtZsnONSxzT0fIx8MLt2U6i2WEpRlSWyGfD6wXUyHsdQq?=
 =?us-ascii?Q?x896aJgQ9sBb8MAFAtaK5wGUE4G9APlkwmnwl2ovjnlCeqS6Af0uSIrAcXiW?=
 =?us-ascii?Q?+YbLHqzPgtyVBEY0RAqr7bBoGtvsF1piu3CCfGxaDnSzj9zKbDPz5tVbcQPC?=
 =?us-ascii?Q?Eek0ORVkxQvF2ofqJyVZ0vNQXDpCjqw1vqnpywkTH7lK5vXNrlyweOxOGNpI?=
 =?us-ascii?Q?SuLfihgMHAWfbYVkoh/GaSfnFj0FCw7PaFRStDg9dyOJUswOrEUjm//QM1uR?=
 =?us-ascii?Q?5ev4ToavDEP6VnYBAsJEJEizmpCvOy4zJVOs7dDNEJVEr76CX4M59SeHRFEN?=
 =?us-ascii?Q?rg2Z3GIVtJmwY+8tyxuraCeNV1hTACZOVS+M1RFZjMbFM4L7NNnOXLEFdPru?=
 =?us-ascii?Q?9yTv74/i6Qmm36qTMrp36x6fU1EN0K1TmQthVlgcQvBLodTxPxLFiYfWwQby?=
 =?us-ascii?Q?6dMGBAerBr/MUCTl3tjsA27zTXqyfcq0KyNmMGgYO8H/9etPjIHqnRtEDPQa?=
 =?us-ascii?Q?oKBElY7JEt27t8TD+HFynvMx7uEza3j2Qskw6tKvwsFBL5If9HTyzV4BVOnC?=
 =?us-ascii?Q?mPaIA4KkWfwkaVL8wXa38jfG6gOlzMC4DtLoNaDeLOBi5iQdQLy2VtqMlnC2?=
 =?us-ascii?Q?MetEx0QSjwzojIlamj1osJoHu5zjh6zWmofQwjukh5QLkOmNp5ZyVyOdGv65?=
 =?us-ascii?Q?M0n72iEv4TFPQQpSmbzxZg5rEwglLnYPRH3HrIUY3nH0gbftQJkCDnQ10Zg5?=
 =?us-ascii?Q?ffHxs6LDd6nQKAeccYSjL1t6Ho/eD474SYZALV/Bv2zsm76hyAbfiWG3Vbf+?=
 =?us-ascii?Q?nOErXr0wdBIwzWTyInIP9wQPR9pd+gNjnmALatvp+N7LaiT+dVrsAA4m92T0?=
 =?us-ascii?Q?qcWcbgUd79ojTTExT4if+v5KPnWb0TnJ8pQ2lO7fBRJ9dhxMWUDn03oRYxRf?=
 =?us-ascii?Q?U6urJ5zZF9pTcxMfZ6j57dfVqsSvXJ7TZNPq0/v55ptL/FniTIviNUgm21JH?=
 =?us-ascii?Q?ljKTLs1/NvhPknmstOoDWh6c2xg8Gvlfnq3QfnUa40IrbXx2XrKujjscFpNh?=
 =?us-ascii?Q?uo7HEknnZgoRA5UlsTNlf823hzm/1Mip/9dmBecr7QJKEKS7lZsuQqrKZBs+?=
 =?us-ascii?Q?Mh2XasrGTsArK+yPByI0L3PFc2MF2O0RCDhxFkrVr9aoKnBaGWo2bgI06l9V?=
 =?us-ascii?Q?h3ZeduOyZpAf2MLxGlrCy5Dw0smmdJoJt4bLvAVSw9tPJOXzUp9U5Y6p0P+E?=
 =?us-ascii?Q?5aWil7IxnCD5idJtYQzarfsw+gbjOpQI2dnvbCOYcbETFQ7h+yiJ77ndkB9r?=
 =?us-ascii?Q?viCQrYIYKyqYwWnT2aleudc270oUssAELBWG8h3tJnTHdDzFQPrW3Nxa7MO8?=
 =?us-ascii?Q?shRZ60Lk40qXZLytkMwYLS8m/jCkmq+ETrC4qxTIUY9DQvHN2/JfiLb/l7tj?=
 =?us-ascii?Q?8veuW2Hy1WM72HmS5sHDEn8/QVLV5Ycg0Ii7BKG1NL8W7We/eLC99m3N1vBI?=
 =?us-ascii?Q?brX4B+rWjs5qMFxRF6z1ZLfVQUdXpiwWWUa+0LxeHSXcsRfJNx7IlzDXlGsl?=
 =?us-ascii?Q?UDbgSldEDmxAjSH7jf7qU0tTpfksSpQB4B3TPtJk+eSlJjfStu22j5ouYQZB?=
 =?us-ascii?Q?WQ4NCojikw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: euogwW8DAx+6t5qw5JKLPhQneKqHfEnnFZyRO9uJmzFcIkoCAP/IwHgzP8s6vVitvYYYGxw1zEZF1rrp/qxrAKa34S/X2mleLTiO2yUz8Dj/lPD+t6bBxoU/IKRKhPavMy008LBLBcocwSNhkoZhl1tJzty3KKrPEzJBugiEGaPoazLJHIFZAO10rUETwdx4hwnQ0upkNpVVeozM8CNPWBzT/qkxAbnEnNUxJ0EWCmi6g3ChILCVDkRpxBoVaYnIoYqjbbjpBG9nEor2l7yv8jKEyqfsiqWcEL3CsTgiF7xTOa1AjyyL6xrLMI2sv0r5fgrP1YpTbmRYS84cyu6B+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82b4985-85f6-4827-5e47-08dec08b533b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 09:42:56.1961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rmt+UOjVRSVYuNILcmGdIjStCAun6HOzxy9yGmeiOhAygiSQKAhLA33Uesf+Kwby3ybQWu/Fttuf3hnd7pHsmDW5p1ZaDk3Grx4HohY7N2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 85C6062BE7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294124-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PH0PR11MB5902.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

From: Markus Stockhausen <markus.stockhausen@gmx.de>=20
Sent: Tuesday, June 2, 2026 7:27 AM

>Register and fields will get longer prefixes in the future.

I don't get the reason for touching it again in the future;
cannot it be renamed with adding prefix right now?

>Keep define blocks clean and readable and add another tab.
>Additionally clean up some multi-space separators with tabs.
>
>Just cosmetics, no functional change.
>
>Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>



