Return-Path: <netdev+bounces-301901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wEMGHsrpPGpVuQgAu9opvQ
	(envelope-from <netdev+bounces-301901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:41:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C836C3EB2
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:41:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ZuE20A1I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301901-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301901-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CB8E300A38F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CD43769EC;
	Thu, 25 Jun 2026 08:41:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5130E831
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:41:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376903; cv=fail; b=F9Kt5zdIjzfpzlxi6CozRCgIsXhrt5CwwLqTndOG8DkcsxFOyQZGy7NKoYpxvnXH3ANOvbNRL4VqIdqQtELSUlS4OMqj7zS1cg/elMCseIZZPPWbQXM3cb1nGjP/nqFcl8Xp+Y7ypde5N1PIe0x2rHjXi0Pt5kHT2aZmoMAlGuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376903; c=relaxed/simple;
	bh=6soJBk4eghlAnax2Di9dD/5Kddkv8xH5mlMH2Bit37c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pvl6pN+p7zq5WdMhb8gcZ3ojNytY4McDPUGQeO+ppAKNPYiRUZ0bF/o0TkoSx2Er/o82U9a7l0Karc5g7DtDoWi1ZUYGJkD/6eW1Cf3he7iNouoaznKWt/dyPN7bi+w+X6F9iGJGWSyA838HWDtlWNiImYEeULXW7JLFMlt5M9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuE20A1I; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782376902; x=1813912902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6soJBk4eghlAnax2Di9dD/5Kddkv8xH5mlMH2Bit37c=;
  b=ZuE20A1IdMhYTzyTxzTGBSxe5NwHwaODjYorS+6hSZZkui1hcBxi/MSG
   TiX674M2hWr5cbwc3vxaNUHPKx+GF4o4pCGRqlWB2FeyqNoLLEKeodqhW
   wFCu6xhBUeICV4B9JWX9yHcy7SFeDfZIc1kEqBPxHqG65C80ZF01ahesv
   FgCTZQRs9IneN+QBNj26yVBviYItCrDx70AN73oYspil5AwyyZu5ziE0C
   Hg2tPuidgVMTCdqCdIXgHEnSH3HeWvAy6Nndf5JiE18FP+C/UZfRRQUlS
   CylMwshQ+TjFAgEEy/mKZ4ZDFY5Jo35ecnPmCwTSw00ohIm7+drBIla64
   A==;
X-CSE-ConnectionGUID: 334BHq3GTQ6dQAVYp5jAwg==
X-CSE-MsgGUID: ZJXoc3m9T4CwaCzz6BJTlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93801985"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="93801985"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 01:41:41 -0700
X-CSE-ConnectionGUID: 71MT434MRI+8eTqq1B/kbw==
X-CSE-MsgGUID: /nysvUjuSpa37cMKXZhJKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="249076315"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 01:41:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 01:41:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 01:41:40 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 01:41:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx8q7DOrn/xvZ0icqQW3GSoMEd0TDmQpwuNTErsDcN+PmS9sIWC0yUfxkIYPcQhmwfY2uxKhAwKXZoEJ6Biw8YhjzGkdFFRW7LFi/JAaAE8NiOlWoBZ2y/OmCtxUzULDkEfJ3zFMuW9OstwkLot3/OUoswQb+WxkvAgJLW0QFaKhjZYU6Evcw+6Xr3kC3Ge0sPA3fvA3N/mbV1StQe/CGrrBbvby09D+iUrCRiWpUmwbYyLz4N6l2iiC+YJQTXV/FvdIoa1aXGV36zYW6mKejKipsNEpBFyFwD3VPSsqxVDo3UGRWhf8E+03qCF+N0GclQDFM0bcKUSDso3vW3xe5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flz0N71oxdPEL/RJxEdPoCfdcz0o7b6VXE3R/PQm/5s=;
 b=SSKY5NOnul4+0rCLQngxaDxYuOGAx6AEdPxOhxLhKZRRJI8YFVUjSOoP9dlw+JeF45auRUQsZIXRn1PbA1zbPILTBmjNtFPNAvMeCoCn5vXli8nJiu4VRdpgpxAn+YbCV8q+iJLbCuyH0DA9HfW+OBXVo2eV1x4nyzfQVGOC1+DyqUh4lAZAcQCsWOeua5TzgWgpBGx8XJceooKuzaq0zgUbsloG6BA276tj/lOO6uJCPprbQsnXT+9+Z8Z2LFTdvYrrNEDhBKZXOw6Z91MQNbsnRnmaGcRO26llwkPXKkn5nHXIV27XsQ5C0n7FSK4V0VHqN4RH+TEF41dM8JVP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB7150.namprd11.prod.outlook.com (2603:10b6:303:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 25 Jun
 2026 08:41:34 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 08:41:34 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "jv@jvosburgh.net" <jv@jvosburgh.net>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "dongchenchen2@huawei.com" <dongchenchen2@huawei.com>,
	"idosch@nvidia.com" <idosch@nvidia.com>, "n05ec@lzu.edu.cn"
	<n05ec@lzu.edu.cn>, "yuantan098@gmail.com" <yuantan098@gmail.com>,
	"kuniyu@google.com" <kuniyu@google.com>, "nb@tipi-net.de" <nb@tipi-net.de>,
	"dtatulea@nvidia.com" <dtatulea@nvidia.com>
Subject: RE: [PATCH net 4/4] selftests: bonding: add a test for VLAN
 propagation over a bonded real device
Thread-Topic: [PATCH net 4/4] selftests: bonding: add a test for VLAN
 propagation over a bonded real device
Thread-Index: AQHdBAYukJUNJheRnkCo5YA1e7yG0rZO9K9g
Date: Thu, 25 Jun 2026 08:41:34 +0000
Message-ID: <IA3PR11MB89868C8A229807D4E691A0FDE5EC2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260624182018.2445732-1-kuba@kernel.org>
 <20260624182018.2445732-5-kuba@kernel.org>
In-Reply-To: <20260624182018.2445732-5-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB7150:EE_
x-ms-office365-filtering-correlation-id: 5d15d76c-c993-4851-a7e8-08ded2959032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|56012099006|11063799006|4143699003|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: 0pQnjCPpyAiJKf+PVMJrgUcP6grDLKbqR1HWeVHJNxmNZA5naTnun6vMahLvs862I/YKBOEoS/roW812GWlAMrB1ecowMaqJ3EOU7g+DSGi2gJwRFyyr4yEq7ntRLdtvDHz4mP3SXBxRQ9AwEXyPdb/NzZTQSEWi1F0s2G8sjldmd2zloKu1WrFetXx2X51asBDpK8hqo4Y+oyv6W7VYntYLGPuyne2lwrVsRgV60M7N381HW4mJdFKMYhIVEVxyk8kxkwuh2fKRVly/UqrtXSspuKzSKKRHu3omTZzFyGkbit+PBI4vQV4xnPNUKafwgFYrgvs8ToTD9V+1u72/sNgrehCoJwHdnMFlF3B7u6b1dRkuyB08SR9omtgFCyZYcfCkyUk0jX3/ZDr+ReIIBB6w5B3hoEZYr/UwIUKQtRq2mjBng8YCj9cwao/ikZoOG0k4odt1OPN5K+Nby8D2vHw/19QqWovflOyriX+c+YZU3wARYxOmhxWOACGIAnl+Y1cmvN77uDZACS65yl3qFsr9NzZbcAVHQfXZGDEBon+iyB3MA18BLpTrE1EyGEjOmwmkdZfzmAQ4v8eDBeetrUvA8P7aK9cL1LdFNpqqIYwB322bWRgwwKwwX5aOYOj13k/f/BL37nbPbnyn9AAblZYgNTcEBkdJaSsWQtim1Fm2c9JR6nUyvmVeLn5d+lexXajKfB2qvD5Q+Sr4MAZMY4H1e0tP8FZahGzdBCF0uL4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FZzHlidwj+O3RZAhCo8Zx6ePJTiOKnPBfYKs9ikIlZ37bAC6Y+IoAv/S16yA?=
 =?us-ascii?Q?/k+BkHE3tUKVGwEADtyhf9g6KCfiFEdchIpQhgx9LjgibjKIYmXwR3qxFAP7?=
 =?us-ascii?Q?uwPG4gsqxy5K+aHrvP/pDVH2UhESn+V4KiQWzNtRlL29201zhFp4K2fObUbt?=
 =?us-ascii?Q?qBo6axgxDDdsJY07PMPD7Mk0j/x3QMV7R4+7e1aBH1Ul161BXKG7Y1RaMthe?=
 =?us-ascii?Q?bY+iNlTpXPfnEXHwyhKNUVTMQ2v3P6C49/TCxYCuYjv+G8a/CwbRaXkJ16Cm?=
 =?us-ascii?Q?um2zTu4ZJeiTotmlaaGogNXIyy4o68aXcGX3kcVSP5xnjU96DgJFrDYHzINW?=
 =?us-ascii?Q?1Qrq296QrRZ0Iyetb5CROxts2WoiOdALpCo3bE6c1hRh7U9BaM8IIlt2dtPi?=
 =?us-ascii?Q?BsKJJJmJKFoDoWeJiW71xf9qDVd8Fo5S+JK/Yb6AdNzglicuCRwqv168hwfC?=
 =?us-ascii?Q?xpRZikn6wLABGJNOydJuuIcq0NbrJ1aUDu/cY/Vdn5qEEvZc76+kgSy9eIMu?=
 =?us-ascii?Q?HFoGrIKSVwXp4eKpaTYAlBhnWTdUCggX1zXfgXZ0s7Z0hbW21xsQWYDB97HC?=
 =?us-ascii?Q?YngOqo3QQv39PHBbABE4AfPI0RPpeHTahB9igk+QmSG56Bs6BbMpZ/TX9+ZL?=
 =?us-ascii?Q?GsO26UAvK007H8MxXKYM3K4xrG6YvIJGp7nR+lAHAvM88JQtfep7dZhQdawt?=
 =?us-ascii?Q?o+mEzmERg+I5UgzMzkJ25sGBuN20XvUudtwkWJZuzx8UQJMyRfsQRu4VsAH0?=
 =?us-ascii?Q?Ayvcmocjijv1oW/iifeyG2K1NRnahcQgLpBIXz7+pAwKP/90F4p5oTbKAW6i?=
 =?us-ascii?Q?1QD1wa4/5HDWpN5n/Fox+6NhN7wZo1BcyCdv81qyAk18GfOtvBt6hoAk7/pF?=
 =?us-ascii?Q?zk0gECe1ZUY4G9Rv3HiYfqLfkOy59AQ4tfkjhO5A2FMR74rWecbDzfownCEV?=
 =?us-ascii?Q?UsLEo49vSneXamPD4/y5WWyEDj1kr/WCyXLTC4QTKcfCy36mCGTOwVEvrlcV?=
 =?us-ascii?Q?AkOTc3azSJOWgKSFOD5NBf0KvQGVfXgMwbYF6ANSL3GARdmI/4I2991vDFRc?=
 =?us-ascii?Q?kjT+z0nJp2V1qt6V3L2bgubuI7hNMTr8c9W00G++Ja2upFF7OdWF5AepZZon?=
 =?us-ascii?Q?Zp6MDXwUwRpVFyMUN40r/csBZP1dftO0dC+V0Q3eEpUY3rDWPbHjGhqAG7Aa?=
 =?us-ascii?Q?DQVWgT4cdpSttXXK5/H4+4bzxWBz7IdJnrBUBQ+VVL3AR62/wBILfFxElGwp?=
 =?us-ascii?Q?c3ESOfdRQ0s9th6KfK/MO3W6ULVDk31gymWG2I6aRFToxBgtLSHDwCouERH9?=
 =?us-ascii?Q?JVPB/kmMUcGujTYxU2zCt/Lf+aEVuH4h3TUnq0wjCJ2y+/UTirAOT19eiykh?=
 =?us-ascii?Q?4vi74b+2GoR4TIjc5ObcOT2FcgmczlIypRp6jeFo40ulGZJE04mWbGqqD5Tu?=
 =?us-ascii?Q?j2/y6nck59SUkcbmlcd3qMa12+/9wQG7tHnGr8BBN7fX+YiKWBBahZt1Yj5O?=
 =?us-ascii?Q?fLGWHCwInSDFJNpxySQ/MTzmqMgUY2KIHcL3v/fbYJ7Axrj9W4k8sq5unQ2V?=
 =?us-ascii?Q?jSDTFq4SoFEQZ+RGsIFXdOIETShygXSvnOcEZJ5zFYENuN7bd2tLRb4bBk9p?=
 =?us-ascii?Q?Q0GJb8Rpd4Dw9TpHg/m1wUMpBpkPN1ZttGG9f5fvhzktSabPZSMS3xLls2CS?=
 =?us-ascii?Q?fkk2uCNtBAeWRsFJV05bjcs0Shk8ae4D03U99DyKVXTT5SJ71F0pFj11tnxt?=
 =?us-ascii?Q?J5q8tWvmItNBWW5pZRA3Hv8+fB4H5X8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kZzwo52um0ftpE1NnvBWf5ukGIb+3kCaj0KO+03EhyQkJqPlaxAlUd+eTm+/+duVa/GKI6t7EFOGAXqcRSLSNTj0Uxpe7p/4TVa7q8zFzxGh2yu3dl1HVxfO8roOeo4beZtO2wkm5aH24p59mKNz+a0ndRiUAkdbpnvTZr5X5PrOPx6BiVhT+lE9W+M8t+CM2I+VX3oKZ/HyY6DBqcf9SGf9YwhNiW85+u1rr+QLy+0W+a2xFSz0KdtdcTKLzO+pSP9fTyaJA8i80rRBAIUmgeC0wuBDqTGsDrZvgFkUcswyh69bcBedfQWf54TnXA2iolAw5EtSK/m1uNBBUy4fFg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d15d76c-c993-4851-a7e8-08ded2959032
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 08:41:34.3770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFNzmQ0EC/Q9LUQ94XQYmsSZw7Gefe3RAfXikZlkalnAyU9IrDAYr/v30t9xXwfr3BmdfW449da3XJqt19jmA/iKxUpmkftWVPxftxXMhBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7150
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301901-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jv@jvosburgh.net,m:sdf@fomichev.me,m:dongchenchen2@huawei.com,m:idosch@nvidia.com,m:n05ec@lzu.edu.cn,m:yuantan098@gmail.com,m:kuniyu@google.com,m:nb@tipi-net.de,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,jvosburgh.net,fomichev.me,huawei.com,nvidia.com,lzu.edu.cn,gmail.com,tipi-net.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90C836C3EB2



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, June 24, 2026 8:20 PM
> To: davem@davemloft.net
> Cc: netdev@vger.kernel.org; edumazet@google.com; pabeni@redhat.com;
> andrew+netdev@lunn.ch; horms@kernel.org; jv@jvosburgh.net;
> sdf@fomichev.me; dongchenchen2@huawei.com; idosch@nvidia.com;
> n05ec@lzu.edu.cn; yuantan098@gmail.com; kuniyu@google.com; nb@tipi-
> net.de; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>;
> dtatulea@nvidia.com; Jakub Kicinski <kuba@kernel.org>
> Subject: [PATCH net 4/4] selftests: bonding: add a test for VLAN
> propagation over a bonded real device
>=20
> Add a regression test for the VLAN notifier handling that the
> netdev_work deferral fixed.
>=20
> A VLAN's real device propagates its UP/DOWN, MTU and feature changes
> onto the VLANs stacked on top of it. This used to be done
> synchronously from the real device's notifier and deadlocked when the
> real device was brought up while enslaved to a bond (instance lock
> held across NETDEV_UP) and the VLAN on top was itself a bond member:
> the synchronous propagation re-entered the stack and took the same
> instance lock again.
>=20
> The test covers both halves:
>  - that the deferred UP/DOWN, MTU and feature propagation actually
> lands on
>    the VLAN (link state and MTU use an ops-locked dummy, i.e. the
> deferral
>    path; features use veth, which exports vlan_features to inherit),
> and
>  - that the deadlock-prone topology - a VLAN on a dummy, with the VLAN
> and
>    the dummy each enslaved to a different bond - can be built without
>    hanging.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/bonding/Makefile    |   1 +
>  .../drivers/net/bonding/bond_vlan_real_dev.sh | 180
> ++++++++++++++++++
>  2 files changed, 181 insertions(+)
>  create mode 100755
> tools/testing/selftests/drivers/net/bonding/bond_vlan_real_dev.sh
>=20
> diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile
> b/tools/testing/selftests/drivers/net/bonding/Makefile
> index be130bf585a4..6364ca02642d 100644
> --- a/tools/testing/selftests/drivers/net/bonding/Makefile
> +++ b/tools/testing/selftests/drivers/net/bonding/Makefile
> @@ -13,6 +13,7 @@ TEST_PROGS :=3D \
>  	bond_options.sh \
>  	bond_passive_lacp.sh \
>  	bond_stacked_header_parse.sh \
> +	bond_vlan_real_dev.sh \
>  	dev_addr_lists.sh \
>  	mode-1-recovery-updelay.sh \
>  	mode-2-recovery-updelay.sh \
> diff --git
> a/tools/testing/selftests/drivers/net/bonding/bond_vlan_real_dev.sh
> b/tools/testing/selftests/drivers/net/bonding/bond_vlan_real_dev.sh
> new file mode 100755
> index 000000000000..542d9ffc4819
> --- /dev/null
> +++
> b/tools/testing/selftests/drivers/net/bonding/bond_vlan_real_dev.sh
> @@ -0,0 +1,180 @@

...

> +exit "$EXIT_STATUS"
> --
> 2.54.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


