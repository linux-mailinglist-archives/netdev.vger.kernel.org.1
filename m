Return-Path: <netdev+bounces-294158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC8aDrG9Hmr1KAAAu9opvQ
	(envelope-from <netdev+bounces-294158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:25:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E8E62D6F2
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A2E93058FED
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B63C9ECF;
	Tue,  2 Jun 2026 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcReJdzH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A93DBD60
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399031; cv=fail; b=tdDVDLkHAEu+iC/whubZEXFtLaTYMFl/ORXpHl8JhzcK/LfOSNgq98MRTkPsynBptEY2bUdkugsj2vfYoY/JaQINln4FQ8icTIlYHuXMkutYp4VtJpouZs+tajEcX34N8vGTy7imo2OEs+lZbP4R21UyQ/PGP6cEp9aOfUIub5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399031; c=relaxed/simple;
	bh=rBzdS9BZmeTupDFVTNVFrus0DKm1ucOf8H6GsnM8YC8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dyx/A6pAkRvDgcC8tc5XCNLQNT7kP7U9UAh7pCHxv0jcMTUqUKpBV7F9f7Xwd8Y/vpVvi/dwMTA+VeDSgBUxBgrWO9Yf7Vy9F0poW7a9zT9X4z8R1i39Y0jGyqgzi2HonaocJTcQtBLyDp0GFzEzzGynVAI8jhpWGXKlYcvjXec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcReJdzH; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780399024; x=1811935024;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=rBzdS9BZmeTupDFVTNVFrus0DKm1ucOf8H6GsnM8YC8=;
  b=HcReJdzHS/6Txq3AjW79buobbYZKfijJCfao6RNLNxjz9fpPgfco+DNE
   tncAAN9LQf8m7h65ptgk7SLjxamCo1AzKVK+XgqPvIume1JWB6rrN7paC
   AVVSP2Mx+OSnGqM1X0N9DIMDZ6W/nxowkD5WIm/yTZyJMQYhQoflvrQYc
   JULId9hBrqbMqskm/FEg2GgwZGKtnVgClHCjamPI89A2qT/lcU6OXk33B
   Xj4VUa9Gau2kebHsp4ZjKfpAsoNsJV+UcUenOTdUVRi4vo4jYrm2Qj/Ug
   XZ4emVdmg4U+3fzmyIPn0FCF+jOPBfq83KFOJ0KXHl1M6Hm1wruAiiLYP
   w==;
X-CSE-ConnectionGUID: 0uzAzT6QSvmGktxDy9WAAQ==
X-CSE-MsgGUID: mZ62HwxuSHaMdF92j8rp3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81306825"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81306825"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:17:03 -0700
X-CSE-ConnectionGUID: CCUoN9mJTn27hzjVmvP2hg==
X-CSE-MsgGUID: c52Y0JgOTzeSTr6mYlZ9MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="248803014"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:17:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 04:17:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 04:17:02 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 04:17:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3ep3n1e92NyED1ZPp2D2rojHVVAvIgUXGtyFlcKF1u2qsalKO+9NCwwmc+EpUjtY5oixxXDykq8FavizksJOmZmhR/mkR3wEMtjXT8HfQXLuQ45B/D4+Trc2nX/WhNaymG1UgFhARv0DUwoJfpY4speisBhRTJgbGjS2KASOZE3vLmXrtNd432Efo/CcK8X17Wf9BCEhEWaNqHSCFjrTk8zzSuU2uftZRgd1YVnlvAMrvMb+boppZngqNM/+TU5qLu7P6B8A8zAqwHzbq0pMDxd4j98BwqBLw5g3xZhDLRtMGrFfEURdpdHJr77LKg4udjobWGjsajEo19tM8uOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBzdS9BZmeTupDFVTNVFrus0DKm1ucOf8H6GsnM8YC8=;
 b=mCG3ptR1CzEv5p1+NmItSjn17tx8QnLATG1Y8oi8xcegjTd1MmhXNnIxa1Rw+awIhvZW7m8f5GhQ88DEHfaP3SpTZPELrbYfcNSN78c30at3tv4NmKEuZ6LgtPYs9i142Z9WG62g8m4xvEuQ8FNUmMRGNYJdN/iEY3Dx9qhclxmft1p6CYmnqEmJ/EzzuDIqifCE3GuYRwm+s4m5rufRJa3bLeTtLgmyFlncb9E7p9+Fq3jtjxVO+8PcmMtDWcHT3dn/D7O8dPcByRzRVHr6ycO4nArBZRUP2hLLmqvaCSWWU/BAECgNF3OwYsFtS7Aif1dShzfdYkgD6G8wNF/kVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH7PR11MB6427.namprd11.prod.outlook.com (2603:10b6:510:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 11:16:58 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 11:16:58 +0000
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
Thread-Index: AQHc8lEtiU0gXZQI9U+Esf0hzUMyK7YrAxkAgAAKnoCAAA8+kA==
Date: Tue, 2 Jun 2026 11:16:58 +0000
Message-ID: <PH0PR11MB59023DD3328FBE7E0B118307F0122@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-6-markus.stockhausen@gmx.de>
 <PH0PR11MB5902B7C4C07107C3288500ABF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
 <00f301dcf279$303e5bf0$90bb13d0$@gmx.de>
In-Reply-To: <00f301dcf279$303e5bf0$90bb13d0$@gmx.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH7PR11MB6427:EE_
x-ms-office365-filtering-correlation-id: 52308683-9244-477a-c6a8-08dec0987660
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: svXCKO44cq2Bo/0nFS81Vlq+Zghb+hUVUHwk0u25f8PqfIVnFUdVJV0bP/Ojirrms02ciYHbwVkcu0qkaTEK0BEeL8qZ3ZGyBe8MloHTOlGBC666DV/MBu2qtuNarDUpBqWV5pJJBwlU8j56q+K8jGED4DLzP5YWWugkZPU6CJTequKDhqV84lGlCBXJX8ggBnTM/UzyZU8SAhEdq+vydasC/NA8JhABwa4RNxDIRfbBnXRpAdJFNpacyhRQ7xlMs4Ir+ibTxS0s5hUSF3HqAwwIFf5RzbyJk5O0g8a8aMhdgF7in8B82LMLOESsNwdwVi81kwp1E9oT7qatIVzeUjmKnXH71rxqh4uo8zlHh4fxWDQIqR6Pnx3vAIM3dQV7/VZrrMul2gMKQ6NAYTE8yywFu15PNYepKFyeZcDGUdfbRxjJd3O0QA+XRJ4UxUyr1z3TCBUE4cPq2L7ejYg9FrZp4lFOLgRyqnQeF+9uhwdkVHVuojrsUlGKLzxOAL/9cfo23F6Sg1TiuQ9CBIl4Tb7X1TH7k0Fo7LyZjreoStXlq8m1pd6xw6wuQ44yHcBE/pVbQAIgdRtjNurBsLJeM1pAHv7ig7dCGDeVfCfEKtLpM+nezyRdaiJJY5l29f9MSMRkRI1q8lrwedoNvCk+7A2t3L8cagJt64i6Rl/rkWTaodmSProCxqfKgpsZNSm4RyA0ebEFQY9h5cQjxZX20l2k5WEhyDORlgrPuh/JZVUQ7Amnt7PEMIAfUTIm4IX1REJWQ71iUNGMXx7t6zxnxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ohbl4IRk62IVD0NoQwke3w4PkjpVTdtvyPuGV67q3GoJ8DRTB5ujI03AT1A0?=
 =?us-ascii?Q?eDnbCjiieUNKHj6W5jalUZlvRlE6p0/yewI+x7TyTgoDXFNAj9vJwx3bPTDe?=
 =?us-ascii?Q?tV5QRVolQJj4cHhT4m2tU5z3A47aFkE7PwC2+g8G+7K3JGBm31+KN9pD5wNz?=
 =?us-ascii?Q?UsmOouqm7dJ1/AlpIX2Li2/KFJFqVNCR5wV8wBiC6nPnR3yFbWr8TAf7DdAX?=
 =?us-ascii?Q?6SST/5fgp6vjL5gNxnZjhePBNJcY2X0K+sPXLb+Q3xxLnNH+txJt0oPtEn2D?=
 =?us-ascii?Q?4zyCUHX/H8+9vNY5FTI3KuN2o1+Zl02Z5Fx71eTJXKCRf5xxZPjaP2npn/eN?=
 =?us-ascii?Q?Gh0ecVv5GhR+GkRgifwqD6yNR3PmFffj8f9/YLuIRygAbRA1c0N3B07OjlGE?=
 =?us-ascii?Q?P/IyeTrLeYejlR73IBodOG/cV9QCAGhzwkf+c04U9SHP9qh4zjjp/0B+ygfW?=
 =?us-ascii?Q?nH407IY0BWeUJCwh8IHZTwFrp4sdJ40Ukuiiow8Uz2thNgjA0ZKFnxwnxRH4?=
 =?us-ascii?Q?i+0EjNAGYTYdZTNrHl4QnuGxNR7iJd821NU6c7EdqvntE95sP0tkqQdDA+ke?=
 =?us-ascii?Q?1g2kOb6wTP8BVYSnNz1gdmQvB6YIv95CU0J2FBhbti/hSopeqaMEBmTacqFH?=
 =?us-ascii?Q?vUH3PeUaOz1a7q/P8aVwdoNiOnk+LQ7CzH3t/uzpRTEYomxz9Gy2Ffbnp344?=
 =?us-ascii?Q?cNRSWrIf02IWlstYAFCFxeQLoUYFNpJZWcpGtU2g1sV7VAoiwWZSAl80K6SA?=
 =?us-ascii?Q?Zmo4xgKRIdL5KpcceW3GDcdj3NGbNHUszHxlWA4rSJcRaO51iGJfs/qpRRLN?=
 =?us-ascii?Q?BneZ0m59q+ho2BsnCnZ5XHM+DcfjGmll4Hd5wYJP1nAvm+wrsffNcONW7cy4?=
 =?us-ascii?Q?jhLCPUORN44mzAlfSCPbZ58Udo5+uevtP7zlnEbXLiUACyVdv8kgyS36KfNS?=
 =?us-ascii?Q?psLOScij5H/9mUmX7z7ExcchrlQKLDS2r3hNB0jg5EMsydxjrW3jkiPxmkiX?=
 =?us-ascii?Q?fHV+MfZVBayT/L8zovL5IAGyiuz6k6zjnsmg00VO/Orz6N/fAX/EpO3SMraD?=
 =?us-ascii?Q?O8UdMMIRFOq/jJg71vsylgn+O5QjL+P11D5s6ENKywmXJetYZqIqdooPmY19?=
 =?us-ascii?Q?Kpe4xzRG79WpH02ceixR7ZQhCD+Hi9i591zNs7WlQ4HeiWD+tleXnlohCr19?=
 =?us-ascii?Q?Mz7U4uIP6wkZIRul5Fv5+zNGrwOuGKzBzHADr2hoTf7MjUOZuNT0QrfqC5Ub?=
 =?us-ascii?Q?ZKOhOBbr4Uo6GoFCsUEC/HwkOV9p8MlTJWSRuywCzR3PDES2UxXar4LP0wwU?=
 =?us-ascii?Q?qtinh4gUSXhvOH9W3Ci6/rgqt4ZJjrxl/CwiK7Gmsey7DcTPJ0oty9ThVtPZ?=
 =?us-ascii?Q?CYrae+U4lwuy1VjDyXdFLbo2KBNVUY/QjjUpX8xfSfy9QYNVydyEzTMKPm5R?=
 =?us-ascii?Q?s3Tr7V9RDN6ZXchduIe+Ye1BOVSTjxlQUEVjSODZg3Y063b3uQXunwc/bo7l?=
 =?us-ascii?Q?lt/LGRsIS0lxvx8yE0IICxdX1doFVv0sFmfsawZ4mBDXoHcAEpebWIW2fOQp?=
 =?us-ascii?Q?VaEArAO56AyqXdszNtkwA6klOaGUWPtp50mTj8zjLBg/MRbj5UXJ2zwZ8QoV?=
 =?us-ascii?Q?ArTPWpvPpcG3h/Ao9dZ5wMUAYdeT5B9L/owBgmKPkRyNqX2QukrNBN8FOugE?=
 =?us-ascii?Q?y67Xf3I2Q0wuJi6ZFX8ZglpJzzTc+9e2T0UirtxY28CfIbxlnyfnOsMjflag?=
 =?us-ascii?Q?6gUTZdCudg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LHIIEBllCwhj/y/1RfHT0CG+IlXj8rGaAECG+UO+9cJDsB09/jzZ8SxcY5vH3adyNgsgzp+BOWKdyyEMiDyAOXmuDgWv5rVb6lb7FL5xSPn2pGgwRiVhSnvTvu7jyBQV9/U3Dbp9HmOLYzfXkmM0yIdtFTO2/nyyTvtMKUwuIq29Jvd8jLSzLzGotA8SfjrdgabepBw6EwaRaN6UtgeE9dOtRKKw2tkojB009IuygggmoJEw7qnoWAQKPpavOYgXUxXxid5b9fqcuQLHboQEAPmrRI5AyqFDbeT/9Q2zDNiuHU2yYmeB/a3x+2oaLlA6IqjT/H/1ru5dNs5lY4Qzkg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52308683-9244-477a-c6a8-08dec0987660
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 11:16:58.6398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEFNzyNjwz2KpkMsehF8zs8cY6jPOsdFoHr8rw0ILrGzyjz/lUP1OcsoybxPSZIgA/omOE+kdswIB7h2TvNPsFmnsiFzqUQinG5V3VSuztw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6427
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 49E8E62D6F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294158-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,intel.com:dkim,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,PH0PR11MB5902.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

From: Markus Stockhausen <markus.stockhausen@gmx.de>=20
Sent: Tuesday, June 2, 2026 12:19 PM

>> Von: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>=20
>> Gesendet: Dienstag, 2. Juni 2026 11:43
>> Betreff: RE: [PATCH net-next 5/8] net: mdio: realtek-rtl9300: adapt spac=
es
>for defines
>>=20
>> From: Markus Stockhausen <markus.stockhausen@gmx.de>=20
>> Sent: Tuesday, June 2, 2026 7:27 AM
>>=20
>> >Register and fields will get longer prefixes in the future.
>>
>> I don't get the reason for touching it again in the future;
>> cannot it be renamed with adding prefix right now?
>
>All remaining field defines will get an RTL9300 prefix. As there
>are some inconsistencies regarding the spacing (tabs on the top,
>spaces on the bottom) I gave it a separate commit. If it is
>accepted I will make ths a combined "Change defines prefixes=20
>and spacing" commit.
>
>Markus

So for me both are resonable
either add prefixes within the commit fixing spaces/tabs
either fix spaces/tabs when touching given macro within each
commit

touching it again and again seems to be redundant ihmo


