Return-Path: <netdev+bounces-204881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF82BAFC649
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD83B5459
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066D02BEC3E;
	Tue,  8 Jul 2025 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AR4GS2t8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7B1A5BB7
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964904; cv=fail; b=mWeMSeLn/vtDsHmlKqKIExcsVy/9b6MhzBpJ6IX+8mNKML7yGvUDnU0ldCMz1F4LTRubG+d8sZ9t2RofVvQGUKg1WbQ2igKpVyZC081EfGRwAXPf85Lco1P2KpgktSGBuHzLpj3kawmGPawSSASoDhFB9eOpf1g4OBSTGJFJz18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964904; c=relaxed/simple;
	bh=lh7eX3lyIgn/Lnt3AjHzKAigpjoiZnKwW9juCO03Y4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t4mN/HFTq2L30aUIB5wqJpaUl95rbLKwUaO6wVkJOKwyrUz3qlVgMrmYSRxyDfviudAEDfAsrHfffLPc5snaaUBTV8fBxVg9MsOg4LuAVKWY4DGJLBHeH1b+mLGDj2g5lvM9R8yb2mjYflREkhonyaADuv0LdjLYzPXKqmUqmBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AR4GS2t8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751964903; x=1783500903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lh7eX3lyIgn/Lnt3AjHzKAigpjoiZnKwW9juCO03Y4g=;
  b=AR4GS2t8wg/PytNBiZiuwjjDbr1LGIlc9/ZPoECVHxgVQsQM5M2rD//o
   5Px8XMk32DZiVM26hj0NuTsuNEa7ZOa+RRa/J12iLdP3RoPc3GHsvmz3p
   CXL84tvg7eerZ934MX5/bN0177XEtQKSdIP6a6yqAgKyOPVw57/NX3cl+
   IKk/Zy4OFUGeAA5yO4wegUXk8CkJo9rGNNPSHThYSFQRnzIHyeGu8e1q3
   w2KZqT+zUdAvyc89g28bJ5Z7svSpTtxmubNzlJZtt6zMwnMigJgnN5OML
   PoGW0ipYnvYP5r9uDPr+/7tlgPhyuF4QxFaZbkVZuFbxOGq6XFI0nKI2T
   A==;
X-CSE-ConnectionGUID: n+KUqEr9RVK2th6gdGnz7Q==
X-CSE-MsgGUID: 1miAZUlaQXKFJbRc2+Yfrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71777608"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="71777608"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 01:55:02 -0700
X-CSE-ConnectionGUID: WzvHemq0RMOmwkmLIlQa7g==
X-CSE-MsgGUID: Km4+TfDSTTeYCgGk+cwdIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="155180452"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 01:55:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 01:55:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 01:55:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 01:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSuv6v4svFt/vEao1Xb8wJwYYtmuv39sLIrTV+3sJKth9Vi6XstqQfhOdWovi8X+dLz/8X2FFTbt1ND4jmLHuwyN/+2lPc7xEZjX8oufnbsVNvFsKM9izg/DIIv85k8PNCt1N6nIUdFoWaOancUf5wvs4433SAGiZf+hJoRJsVHVXUamv32kC1ypyF0a+ZcsaLPcv24ZuiydhSOvlfyJ8fbDRp9EscD8cz+ceqJ3g5CDE9X+oq6vAd+0P6WlOYaliAFxL3omn2JfwJAiot5JwfAr2N5HaajjIFWsU5EE36dRlHZaG6iK4z28clHJNgFvQ7r29yp58fsbopNOaYC1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lh7eX3lyIgn/Lnt3AjHzKAigpjoiZnKwW9juCO03Y4g=;
 b=MTOjC5KyXkBWTMGPn04bteZJY2pgKA+sgDXwpiE6UOHaJySdCrGG5YkXE6XlEwB+ZXXaoOwyz+Yrp//gsNqX0NYlsLW4PCy3qxufYZwGWfnAaemgHZirhrmTdgii4eVw4tn6Y0STrYzXiM5e3O1OHRO5kTjBQ0EwICvT0+Qd4UMip3VPhDQdB7e/EKc16y6m8cT5EUloSySO/8MeVKQGMpl2+dMk+5tin0KNF4Z7gUnvjRUSE31VmnY/ioQMbR5m/hV3AvwHpOPgfAmdTe9S8uo/witHwctaAf7cKnIkObKHysAPqM9LiDY/nNb5DCl0Jamd3pGHfy9zQaU0QsSkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN2PR11MB4582.namprd11.prod.outlook.com (2603:10b6:208:265::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 08:54:56 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%7]) with mapi id 15.20.8769.022; Tue, 8 Jul 2025
 08:54:56 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jacek Kowalski <jacek@jacekk.info>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 5/5] ixgbe: drop unnecessary
 constant casts to u16
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 5/5] ixgbe: drop
 unnecessary constant casts to u16
Thread-Index: AQHb7+D2qyRrvu30L0WGM3O1IcuR1LQn6o7A
Date: Tue, 8 Jul 2025 08:54:56 +0000
Message-ID: <IA3PR11MB8986B9D474298EEEFA3C57E5E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
 <33f2005d-4c06-4ed4-b49e-6863ad72c4c0@jacekk.info>
In-Reply-To: <33f2005d-4c06-4ed4-b49e-6863ad72c4c0@jacekk.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN2PR11MB4582:EE_
x-ms-office365-filtering-correlation-id: ccf1a615-55e0-4a2a-cd48-08ddbdfd1ceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?SjN0b2s2NDNpRmJkU2Y0WWRCZFROTkRZTUdOK2tzQVBYL3JyNFUwWHZYeEtY?=
 =?utf-8?B?U0dWVnZzRmVMTndibnUvL3Z4djR4N1hkVW1kYlZuQi91VnEvUFJUYUhPelBr?=
 =?utf-8?B?Y3AwNG93TkduVHB3dzRYZ2FJUmVCUVZ0RHowazFyY2VmRWZiU3czRmdIUG94?=
 =?utf-8?B?RWEvcFhKK0dvUEsxbjJiaDhML1BGRktvb0NCUHFEMlY2dFk3ajU2bS9KT1A1?=
 =?utf-8?B?Ym1saVVRZnVsV2gwWG5zQlpVYkxrTExNUEhpTC9UME1ZMmxxMlhDVUUzNXpk?=
 =?utf-8?B?a2F6YUx4b0JpemJtNzNGRXNveWJ2US9tMTYvUENFd3RCbjN0MDY4RitmL0lL?=
 =?utf-8?B?bVNMRm1IQXllRHhhSVNuMTN6MDkzUFdmK3FQbExxNk53ZDVUS0lCR3NlRks2?=
 =?utf-8?B?alJkMmtDQUZEN3Y1Z2NMbVRwbThSVnVScG9aU1laL3l1bWd1ODF3anZrZEgw?=
 =?utf-8?B?T3RDRkFqbTd1TmZxS09IdlYzZXJBcGdFYk5vZTVvMlpsVmltckxLcHZYbEtt?=
 =?utf-8?B?M0NWV1d4NFd1cGdsQ041RGdFSHkvdyttZ2w1RjlSc1hJbVVneFVaSUtxNU9D?=
 =?utf-8?B?M1ZhZ1lpeUV6M24raHkxN2ZYUStMaGN6R3N3TkJleWlESFdqaXBzSk1qM2NP?=
 =?utf-8?B?TFZNM0FEYnpUZnpEcFhSTjVSTUN0Wlc4SzFNVWJuRFljUjhLcTZHcFNmN3Z6?=
 =?utf-8?B?OVVsQ1V5SnlXZmVTSGlJUnFvTStqOHFWNk84dWtSWHFDRkNEMXlIUGxENnJH?=
 =?utf-8?B?cTlQUkVIalRQcU9vazhRR3R5UHkyd1hhZi8rYm44RGlQdEJMdGJYVUxMMjFj?=
 =?utf-8?B?K0dyekNXRnlzNkRPSG0vSUhxTWJ0dzFhZ3hGdlRsTzg2MGdyc0Y1OHVZRFAy?=
 =?utf-8?B?OG9aU0xDTFVLVHNBVjdyYkVIZTVNTHBUZ1pDb2w0L0pYTEVTZHFFY2daZlg4?=
 =?utf-8?B?SjF5RElhNEM4R3I0eXBwWjdjTlFqVkFxdW15cGFnSFdCaWk3NDE5Z0o1dzc2?=
 =?utf-8?B?TUdKNXZXLzlNUWJWM1h1NWZ6S0tiektuV0tZaFMvTHR0TnpKNmtoM0JDQUZX?=
 =?utf-8?B?R2h5RHpmbVBldGNFdUZ4SzZlbjJKYmVJb05vSjVpTjZOQUlqU2FUVzNEdFdZ?=
 =?utf-8?B?NEdEOW5FV3FsOVF2c3M2Rk9OWU5JbmJieUpFOWFVZzNvcjQ1aUtMMnlHNEtz?=
 =?utf-8?B?cWJmNE5uQmkrMkFKTUJ6cVlzTjB2RlZCcTg0VDlsVnYzUnRDUGEvOTZaTlZv?=
 =?utf-8?B?TjlzeXZDUTNRQy9ocW9WdnQ4RGlqSURONkZpMlNKVVhRTm42MVQxTE9oTjNN?=
 =?utf-8?B?aHRWcUs0WFliYy9SMG9qaDZ3RFNsaDZ0dkZNUXAyQm1iUXZIMWQ0QU1NVEtB?=
 =?utf-8?B?ejk1eHFYYm84ZTBmcllVUzRuNmdvTW1XQnV4NWtkYjVpT1BrcDZPZS9SY1N1?=
 =?utf-8?B?ekEyZHJnMHFDc0syazBoVWxpTDJ2QXN6K2UzOGdudHpOVjhOWjd3aXQ4UG95?=
 =?utf-8?B?a0VVTVlJRlljSUw4cFNDZ05SWG5JT1gwYWl0UXJYOUFsc05RTmsxUTFNM0hk?=
 =?utf-8?B?QUMrTXFTUU1xVDZvSUs4UCtnQVhWSTIzMjNienAvU1RkNzJmTkh4MlR1ODNS?=
 =?utf-8?B?a2MrNUdNT2FxN0tscTdIZUY5Mk9IaFU2bFpweWRmNlIweUJmUG5Eb1VnOGRF?=
 =?utf-8?B?MVVYdXNHM01YSDdndGUwc3FhWmFCMlIvU1hsQ3VJSUFxMVFHZ1RORnN2L0dZ?=
 =?utf-8?B?MmJMTlY1WEl2L1hsMllJaUZ6REp3UUZSSHJ4SXVDV2JSMmptTHlXQWhKZ2dY?=
 =?utf-8?B?VzJkQ242czhYMnJ2d3oxSXZjSk5mVWxkNXZwbHY3TS9vNWlyVS9FQVFpbnpD?=
 =?utf-8?B?YlZkQ0FuLy9za2RJWGVxOEVscjZGUVAwVDM4MU1BNUMxUnZNbGFKQTh3Tlpx?=
 =?utf-8?B?MlhPY1lHUWRGa2U1U3RGQllPaXB2dFZMRmJlWlFHMG9wdkFHaDFIRTBTcFJO?=
 =?utf-8?Q?vcP4NGHwTfMnSVjQQRZa6997+3grXU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUpTUG9ON21XVmphL2RsMXF3OVJhSUQ4bU9HakJ5TERUcWVwMHF6dlVwdXZE?=
 =?utf-8?B?NUg5M3RMbks1YmhRZjZVdDA2Q085MERhRXNhdmEyQlJoY3RNV0ZMSFEyM0gv?=
 =?utf-8?B?b2ZZaThuVVBTZGpxcTFoUVhsRnVMb3hxRFJZLy8wYi9xWXZwejZoZ2I0RXZ1?=
 =?utf-8?B?WXNXd1FxZE9WQXphY2RkcTJhZlUxUCttMHRpWmhnVTJzL3pmd09qOW1MOHhG?=
 =?utf-8?B?MHFIQmZwbWJzV2J3TUczVjNIY3VOb3BKMjY3SDNHQXZKS1dtdU9aaXBvNTRP?=
 =?utf-8?B?dnk0elhmOTdUdWdVVzg4eUJaeHV6UWY1bGNUQ1AydU5scVZCdkE1VTJCbXdX?=
 =?utf-8?B?dS9weXM5a0tiZnJBWk8vRkhEWjBqYk4rRy95YVZycms4dTdwVXh5V2hHN1RI?=
 =?utf-8?B?eldUNFZMVk5HTzRESXd5SlJpYU1NZnQ3dkxsWStZZFFCR1Y3ZHZJK0NyeGN2?=
 =?utf-8?B?NE44NHE4cFdqSnpHTzJKSXZjS2M2VTdmSWtqdWJLRHl5aitJcHBNRDJkZWZU?=
 =?utf-8?B?SVN0UHBYUXA4N2pEWGRibnh6MjA3TXVGY0pZQUc1SUJLUGVPeGtPMEFLSTYr?=
 =?utf-8?B?QVh1OTV0QmNTM2JaVnRUSHVPNXdlalgvanErcWdNKzVHMytGOUtoQm9FWkxZ?=
 =?utf-8?B?NW9tMisxOGNHSExxcGV0Q0ZMSytTcHNlVmQxUHpla2J2Z05vYlp5dzFEbnlz?=
 =?utf-8?B?TUt0SWFqVk5FS1ZSV0lMMUJORjBGN2tIMnhPVTdqdUFPNU1MSTY0U2srVVBG?=
 =?utf-8?B?aEF6dDMrNmErcXBWNVE4UHpBRUQxbjRuNDdjT0M2TTZiV1JLR2NrRU4yalZN?=
 =?utf-8?B?S1lGRXlBZHA5ZXdENFpHb0FOdnlNc09vSHlGTHUyU0VGVE5Yb2NpZ0VkM3R1?=
 =?utf-8?B?eU95bFc5blRjR3ZnSFJra0tKc2Fvek1ObTczazB3RWlFUHQrcU51YzZ2VEtX?=
 =?utf-8?B?UGhncWZ2b3BFWEJ3d3ZUVWtpWWVLb3JFKzV5OGhIVDZjY3lDb2U4TmEvTFN1?=
 =?utf-8?B?T2FrUkFDaXA4SGNsZDVmU1FuRytsRVFtVmVPWnE2T0hvcXFtNkFGU0JWU0xP?=
 =?utf-8?B?bzN4N2VES05TVkt6aHVvcC9RanIxWTJBU1pxWTV5b2dYY242cjh4dnRlR0pE?=
 =?utf-8?B?YTgzUHZwOWZXM09VYzhhY2hDSXNsaVlScVkvcFFVTS9sWjM5VStVd1EzZ1Fk?=
 =?utf-8?B?cCtpNEhkQ05HMW9od0M5UDRTVk80cjkvZ3h4bDN4amtYazRYQVcwa1dDUFJt?=
 =?utf-8?B?UWNRZGxqSVNDUlRmdjZyS0ZQTVdvYUsrNmxFWDZOUnRKU2tMT3c2QmppNWM0?=
 =?utf-8?B?Qy9xd0pSRFRoTHBVYzArOUZ3WW56bGcwUVMzeHVoaVhwSTRIZC9yRXRsSGFh?=
 =?utf-8?B?eWZ3K2x6K3ladHJVS3RpdS9qZFc5WWNQMHR2a2ZmMHlKYjRDZS9PUmJvVXpR?=
 =?utf-8?B?YVNlWDl6czZvUkVVM3ZSRjZvTlpIWHBLdkFqMFNtaXUwd2xGVHFjcVhFamMx?=
 =?utf-8?B?QkdYTE9NdHZqTVNrZzdpdTZIaENUYlhlcll1aGVENFAxa3o5RG8rZGQ1ZGxX?=
 =?utf-8?B?dUNzRkxiQXMrU25aeWoxQWs5NUcza2gzc2VjL2NldCszYmJLdDA3SkVPNjk3?=
 =?utf-8?B?YVdZUWpoczFZUkl1aVg3WVhGVHJZcm5za3p1dFU5VlZaMHRER0JGaDU3KzFI?=
 =?utf-8?B?ZVBueDg2YitQanlCdndLakNPYkN6S1BhbkMrQmFXdHY2VTJxTitNeFgrZEhQ?=
 =?utf-8?B?ZXlBL1h2ZEdkRDF4TkpBVzFQeTlZdXNkQXZzNWdGc0VtT2UweExJMWtlL0RY?=
 =?utf-8?B?SGMrR000OU42akRMenZFVXNkOGxRV0ZKaHVRNFdPdjNxYkhyVjRyMXlHQ3Nu?=
 =?utf-8?B?bFFDREhzUTNESkp6Tk41Z05pTGhuK3BmQWhFM0ttT2Z0Tm1NMVZhbkZmTlla?=
 =?utf-8?B?Q1hobGJHMGRPUzYyWWxWbFI4Z0RyY2crVW9vWk9BaEg2di9LeHJ2RzRUeTdm?=
 =?utf-8?B?RVU3LysxcFFScWZ1VjkvdlplMlJLK3pGREdUTFlNdmlsRHFzdXR1TjFOdVg5?=
 =?utf-8?B?OFgxRUt5UUlpZktjcDFNVzFMcElaa0d5ekxIQVk1cWtlcEVXaGVaOFJFcDNx?=
 =?utf-8?B?YVN2WVZUUW9ZYVl5dEdNSFBkY1ZyQ2UzeHcrUk03ZHVieTFub3RzWkoxWEJN?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf1a615-55e0-4a2a-cd48-08ddbdfd1ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 08:54:56.6010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpM+aYdr1Mycxf0rler2Q5NNj9XIi/hVBipZtONxaXBEV1ADFX8VO6PVKQ5BQ1wK7JxuRsWyi5IDsUMNUdDrUJkwMPNmbAoPtWFkyf9BkRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4582
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFj
ZWsgS293YWxza2kNCj4gU2VudDogVHVlc2RheSwgSnVseSA4LCAyMDI1IDEwOjE5IEFNDQo+IFRv
OiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVs
LA0KPiBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgQW5kcmV3IEx1
bm4NCj4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3Vi
IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbw0KPiBBYmVuaSA8cGFiZW5pQHJlZGhh
dC5jb20+OyBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IENjOiBpbnRlbC13aXJl
ZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjIgNS81XSBpeGdiZTogZHJvcA0K
PiB1bm5lY2Vzc2FyeSBjb25zdGFudCBjYXN0cyB0byB1MTYNCj4gDQo+IFJlbW92ZSB1bm5lY2Vz
c2FyeSBjYXN0cyBvZiBjb25zdGFudCB2YWx1ZXMgdG8gdTE2Lg0KPiBMZXQgdGhlIEMgdHlwZSBz
eXN0ZW0gZG8gaXQncyBqb2IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNlayBLb3dhbHNraSA8
SmFjZWtAamFjZWtrLmluZm8+DQo+IFN1Z2dlc3RlZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0Br
ZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4
Z2JlX2NvbW1vbi5jIHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUv
aXhnYmVfeDU0MC5jICAgfCAyICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdi
ZS9peGdiZV94NTUwLmMgICB8IDIgKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2l4Z2JlL2l4Z2JlX2NvbW1vbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaXhnYmUvaXhnYmVfY29tbW9uLmMNCj4gaW5kZXggNGZmMTk0MjZhYjc0Li5jYjI4YzI2
ZTEyZjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4
Z2JlX2NvbW1vbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4
Z2JlX2NvbW1vbi5jDQo+IEBAIC0xNzM5LDcgKzE3MzksNyBAQCBpbnQgaXhnYmVfY2FsY19lZXBy
b21fY2hlY2tzdW1fZ2VuZXJpYyhzdHJ1Y3QNCj4gaXhnYmVfaHcgKmh3KQ0KPiAgCQl9DQo+ICAJ
fQ0KPiANCj4gLQljaGVja3N1bSA9ICh1MTYpSVhHQkVfRUVQUk9NX1NVTSAtIGNoZWNrc3VtOw0K
PiArCWNoZWNrc3VtID0gSVhHQkVfRUVQUk9NX1NVTSAtIGNoZWNrc3VtOw0KPiANCkNhbid0IGxl
YWQgdG8gZGlmZmVyZW50IHJlc3VsdHMsIGVzcGVjaWFsbHkgd2hlbjoNCmNoZWNrc3VtID4gSVhH
QkVfRUVQUk9NX1NVTSDihpIgdGhlIHJlc3VsdCBiZWNvbWVzIG5lZ2F0aXZlIGluIGludCwgYW5k
IG5hcnJvd2luZyB0byB1MTYgY2F1c2VzIHVuZXhwZWN0ZWQgd3JhcGFyb3VuZD8NCg0KV2l0aCB0
aGlzIHBhdGNoIHlvdSBhcmUgY2hhbmdpbmcgdGhlIHNlbWFudGljcyBvZiB0aGUgY29kZSAtIGZy
b20gZXhwbGljaXQgMTZiaXQgYXJpdGhtZXRpYyB0byBmdWxsIGludCBpbXBsaWNpdCBwcm9tb3Rp
b24gd2hpY2ggY2FuIGJlIGVycm9yLXByb25lIG9yIGNvbXBpbGVyLWRlcGVuZGVudCAvKiBmb3Ig
ZGlmZmVyZW50IHRhcmdldHMgKi8uDQoNCj4gIAlyZXR1cm4gKGludCljaGVja3N1bTsNCj4gIH0N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3g1
NDAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3g1NDAuYw0K
PiBpbmRleCBjMjM1M2FlZDAxMjAuLjA3YzRhNDJlYTI4MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfeDU0MC5jDQo+ICsrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3g1NDAuYw0KPiBAQCAtMzczLDcgKzM3Myw3
IEBAIHN0YXRpYyBpbnQgaXhnYmVfY2FsY19lZXByb21fY2hlY2tzdW1fWDU0MChzdHJ1Y3QNCj4g
aXhnYmVfaHcgKmh3KQ0KPiAgCQl9DQo+ICAJfQ0KPiANCj4gLQljaGVja3N1bSA9ICh1MTYpSVhH
QkVfRUVQUk9NX1NVTSAtIGNoZWNrc3VtOw0KPiArCWNoZWNrc3VtID0gSVhHQkVfRUVQUk9NX1NV
TSAtIGNoZWNrc3VtOw0KPiANCj4gIAlyZXR1cm4gKGludCljaGVja3N1bTsNCj4gIH0NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3g1NTAuYw0K
PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3g1NTAuYw0KPiBpbmRl
eCBiZmE2NDcwODZjNzAuLjBjYzgwY2U4ZmNkYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfeDU1MC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3g1NTAuYw0KPiBAQCAtMTA2MCw3ICsxMDYwLDcgQEAg
c3RhdGljIGludCBpeGdiZV9jYWxjX2NoZWNrc3VtX1g1NTAoc3RydWN0DQo+IGl4Z2JlX2h3ICpo
dywgdTE2ICpidWZmZXIsDQo+ICAJCQlyZXR1cm4gc3RhdHVzOw0KPiAgCX0NCj4gDQo+IC0JY2hl
Y2tzdW0gPSAodTE2KUlYR0JFX0VFUFJPTV9TVU0gLSBjaGVja3N1bTsNCj4gKwljaGVja3N1bSA9
IElYR0JFX0VFUFJPTV9TVU0gLSBjaGVja3N1bTsNCj4gDQo+ICAJcmV0dXJuIChpbnQpY2hlY2tz
dW07DQo+ICB9DQo+IC0tDQo+IDIuNDcuMg0KDQo=

