Return-Path: <netdev+bounces-301543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h98oKYZTO2rfWAgAu9opvQ
	(envelope-from <netdev+bounces-301543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 05:48:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E546BB295
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 05:48:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=FPJ8dru+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301543-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301543-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 936B3300371F
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 03:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7906D2FFFA4;
	Wed, 24 Jun 2026 03:48:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C242F9D89;
	Wed, 24 Jun 2026 03:48:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272895; cv=fail; b=M4x++Bu73jWH4lzYAa/PRxuAy+kn2HP+v0s6vSAqVwNRK7dR+IeIAZM68NZ4UmRabTO2rv130iYkxEcCR/JEaKO0D2afsrMejEGUCTTBW6Qa3LXFqmYVWCzolZeRRjT2AnMxT0QbzTCRsJBgz8m1kGwbwJATl0Zrr/ewuPxUl74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272895; c=relaxed/simple;
	bh=ktIX1P57RZWp7ZYWewsK3gqsVg/Y0meNOmNHOOrP65I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N98jvUWcuJ+bJI6RbmKNO7Z3l186TnMVOcdthtOmPz3ZuEkKcFXcbDvGlxn0Ypuesdw87LeRVqg4UQ6p4hVJIJFpZlCTVzEHJhkdKnsJ4DPZf8svzjltQNuuVF/rS3d3wNB22sRwk+BswEQzXCZcxkPj9UjFCg/PGfAHUICNikM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPJ8dru+; arc=fail smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782272894; x=1813808894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ktIX1P57RZWp7ZYWewsK3gqsVg/Y0meNOmNHOOrP65I=;
  b=FPJ8dru+s+zgjDp+F2M39uZ1fRU4Yl7DPPsoFyQ25VsfJeTBXPHiFYiQ
   ZgvCT/xuZAvxglc3oo2p1bbiXIYoGkvQuUekADR1iqb/6KDLXTHdu8/Zu
   91IGqGqtjICvrB0vdIJop7jOJNnLoR1LWAEkWTkkQJbkSxK2kG8Ku6xBY
   cFpzMnz4laOmB4AnnWOK2ycx+Ee+iNzp7wMZ8Vyhqe14J6O8pFZ872Vly
   UVrGDsjOTfsfnfv13k4VioXl42RuV0LcFnpD2q8tb1QxBGM1gItxddLUE
   f6M9JjaJaLwiTgZMUB2Oxc/yBDU2Tj0nDdNnGr1sV2fj8o7yB8j9DMqzJ
   Q==;
X-CSE-ConnectionGUID: 5pApBC4TQdWP8CYc2Ds6kQ==
X-CSE-MsgGUID: sOGai//nTYqhzYVcKdVOcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82135476"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="82135476"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 20:48:11 -0700
X-CSE-ConnectionGUID: qLpaoYLDSNCWIHzTofAHWQ==
X-CSE-MsgGUID: hkwjfKMrSdiXL20bFxZnpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249547613"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 20:48:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 20:47:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 20:47:52 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 20:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCjDNNKFS3VbtR85mX8JqwfQbhXbJQfcWkOmR2+bEunZR1Dk6YGw3Ee3H80oK8w0XFtnp5/xymgse0WFyvZJ/T3NY0czd6yB7qXNrbKJ0OY02tRCo4ezNZW+uLxbmg6RLE3QwmzQcDWuagaTYZqf25tbi+2VWXLYS8GCRXIjjVy8t0/BLlomlMxezGB8LChNCLP+NqK9x44+HurT5ndA0+XcLVdkbvg0xIVZ61+Sh1iJfhSM1X9BacFjD9+OWQIDsNWe1ke9pbfPTCDAenX7s+oX9DByfritC8qqT9Y9UGtyyysO22+4cD/PUB8xkO3K8aVdTuSXW3/7D9s65WIefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jbUmF0J4YCoyHdy4mc7pQYIVvcgsxiaPWwm3cw0yO8=;
 b=ZLI+xMoOZLj+blFJYemlxaV9i2iKur3wr/iA9U7LB/FVPd8Tq0QOsvXCL4sCSQ2ZZt2re8IIXTV3SSnx+vvMe2zJerDsuf0TIpkkhqkS9i5ytUHr/njlMSgHxASer9H1XX1GWiC28goZ6/5kg9yr77Imt6SCgjnWv4ND+1pMzdJFTeOxl2BqrcPyiY7sM6Q1+iwB5EKcupJt/nbZxgODZ4Dy6cTVt1qhgXIN7rud2lyAofhi2iRRwxT2RxZlRHGpBvaY3Vy1L2sMVjxczv86SwfVhrRWChplDkZj/70KTdiV2cHNAQwb2/tFqTR0B3bAxX0Ww+fEXUcfwtx/OFn4dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN8PR11MB3793.namprd11.prod.outlook.com (2603:10b6:408:86::23)
 by DM3PPFED6629EA1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 03:47:26 +0000
Received: from BN8PR11MB3793.namprd11.prod.outlook.com
 ([fe80::dc62:24be:3b09:80f2]) by BN8PR11MB3793.namprd11.prod.outlook.com
 ([fe80::dc62:24be:3b09:80f2%3]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 03:47:25 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "stfomichev@gmail.com" <stfomichev@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "kerneljasonxing@gmail.com"
	<kerneljasonxing@gmail.com>
Subject: RE: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
Thread-Topic: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
Thread-Index: AQHdAvAmHfrIVyQJ5Uq9unygvKpwCbZNEgYg
Date: Wed, 24 Jun 2026 03:47:25 +0000
Message-ID: <BN8PR11MB37937287EDE68B2F8773CC428FED2@BN8PR11MB3793.namprd11.prod.outlook.com>
References: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3793:EE_|DM3PPFED6629EA1:EE_
x-ms-office365-filtering-correlation-id: 2eb17acf-2302-489c-d630-08ded1a34e5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|22082099003|6133799003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: r5Z2JZ9qTBsR2Y+xSVxAOYuBjUxPl34WmKNXAGknPZoES4SIrCL0B/GdgsbLJi5gn9xfje/qgwAjNLrvW0b96r9D1yjCBUhYskQWv/oLkvf3riK/G25wQJmg84PE4s6leJFgDIwbDLUsbcE78KOh2C8NmOqpf8hnaZm3MeiOgGahpL9dgCkBT+k8j6MBtHldhHA2JlFTKDinPJdYGadkp3SYX7DpC9sxbYaky0s1RUud8+fig/ZmGO7hRJig1IjCnC5r16qn6ETCvflcapTyymZUVDQqXfhFtsM/pdhiF7eRNCmA6Q3fX/X2qgsjaD1fR+rjfFVxyZnyq9zCfBgHgY/6Dv7tAkHaWai6waDxOJeocMNxG4+BhCKGV4SMfFeTBLpveGiuIfOCHUjAI+LMhHM2Fr7eYvuwEwFcv4+YUFgjzq6RIhNFJ+qKJmNhNkwALsLyPEhB7I1V+WbXuDnzqJsOtadTA8R8OFWVXt7jAuruiFVOe+I/0oedM17MuEyeA/Pu0OGZeR6reLMZQfqQ/5COSGMV5cWjCTM4PHQYJGP2CZ4zB/6aBGskQKczQBF1DDtQBoPyuMsYIfgtIr05NFB7kwXocsoQ4kx2Qq967RXcMlEg4QhwJYv6RilGlJUg+8Gqpzw+13ZemfTSzWCfsjhI5MmzfTj4P5qgp4Oj0IFTn0+hf6MesxaB3YfV/wWRMjqlFNwMEwhWRKBSxPe3QU5rEWE6DUJePwdgZt9QTdE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3793.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c+uK9l6wdiR2EUNpYNzPKCDkzIR6kkHoLrlkrlDowPRFu8rtQYkJlWnECK8+?=
 =?us-ascii?Q?R1vn28KSU+OmqGazHstjwtJAyZZwhfLl4cfEsF1+SoP/B04BHEElJA26rHIs?=
 =?us-ascii?Q?nPd3s9feIWoGrtokhboZ0TQ6vl//yjwtUT60ZFSxv+O+5CtVvdUx+8BcPYh4?=
 =?us-ascii?Q?zNzkXMefQhHxn1ZHgUstdD1BSBgPr0shTWe6zt/qVpzUVUv/JPyLDrnc+ifh?=
 =?us-ascii?Q?xoCT5WOQS9O6lN6088WLYHTdW7EalwOZR0RxUgEp9gUJ/y7rbeWVuMtyVHaq?=
 =?us-ascii?Q?s5HrfLs2u6VHUmqnRzgOU4WaaSU9bUzo9aMo06QqYo3KPPUsNoroz4pze3gL?=
 =?us-ascii?Q?DBr75Tw92WL53CZuiZfyzN3QLXJmctlwTw07CgmO8P8OrmYuqOEZEHeQeuhS?=
 =?us-ascii?Q?0HXpuIgZJW/PErp78dSEr5lNhEhLA/I1gjsT2CV+bMAGqRmOmnwL4LUO+jfZ?=
 =?us-ascii?Q?mbTu7Ex5N+vSmM0o+1xKkYo7iG1/IN6fTrX8kuXnrAYWE9i5lQlxJolNFRUM?=
 =?us-ascii?Q?4uV0conZBAOraYYaegVmrknvskeCaNJePn9A+UNZ1ofo557fUbjpwnNVi+uH?=
 =?us-ascii?Q?L5UVJoXqL9FscBNQ2L9iiHCdYUf6wBEoIUSmbP+lfVX+dugIsCKmQ21E262m?=
 =?us-ascii?Q?r3JWMF1uV8a2UDoGR7iLhuYb048B1LR58nSET2I3JigWWkYvDOuFkO4PRyFB?=
 =?us-ascii?Q?0rQAOErGqdH8i6XlY8YKinmxbSZU2o7Sx39VHGTTkNmVmxWO1FsjK0qRoK0d?=
 =?us-ascii?Q?B8pza9h6J+Jueqb4wK5qrXQbGhFf9YcqxOW4Ak2qB/oWX0tnI59OCpY+cg3b?=
 =?us-ascii?Q?CMp1F2ogfDiMc1EXs3XqVqmIXv02rrIhj7kRxusOxztVrFQukbpTQCVy261k?=
 =?us-ascii?Q?67MPQR+Lc2KnV2hufA6ZEHlUWeCOH736+LDRpYbTXJN4dp8F8wYC1j3lLzLk?=
 =?us-ascii?Q?olHbpo4OP0FC8mZB4og/xN5wfRXIvj9sK2Ctw8koCRx2yQuRYf6J0ltJk9lY?=
 =?us-ascii?Q?ytjzW4lYk3+GlS/a+du96Vbx69vLJdtQrRANhXqaSKJVMsAS//UzymjeN4oz?=
 =?us-ascii?Q?U8cBDqYVfQpEweO9l9Jnwmi4rhEQsvoLqquwxUPqiWfaiDVLsut9csp+DzAz?=
 =?us-ascii?Q?VL5IHzLjWSJADx5KdiDNrvYYg4Fv8cfNfWMfDfUJxCIp/VjPPtPmIMmxmwyU?=
 =?us-ascii?Q?vScXHly6QCEKlNVBF/kgb6K9xPbTA0JdO96tKYFy1gLVS8cE0Js5+kZkSiif?=
 =?us-ascii?Q?1ZmwiC0OZ+AE23R04+PDMhg1wugrlFxTr0B0FmbfD9c8BmUOL4AFHwUt7cs6?=
 =?us-ascii?Q?2U7pCTPqMbNgXIoj4fAIFYc14mxDjr6LDEyP/IbAxkbqDv7QQpOtNhywT8K8?=
 =?us-ascii?Q?P0j9p+UDsaj4rH+qy8b4zz2qpJ52kvP6KGRtwvamsKMB+/OxYW3ffrVAVho0?=
 =?us-ascii?Q?G/ehx0yVD4VgP1EyWuhlbA4SBHwREAkioQ/Bwy8o6mGw+9TmbbqZemogr+gJ?=
 =?us-ascii?Q?HWOC0nI8GRHowlQqNIuNsZApl4oezXgxMjReTdnf3lud0r0Dqa/pNzV9M123?=
 =?us-ascii?Q?R7pZPnw5JVYewEYQlNgHOk1jMnq0uXVHv0raVW+XfUmEQhk1++ZMEQ2wOCZW?=
 =?us-ascii?Q?6tjCmsOBSRMeRT6KGVN7bhbYy0jParj+eAB7TZdmj+TMZO/U4vmpMURfHI0F?=
 =?us-ascii?Q?Es817UsgDIHgtu4ZlSS/iSIi6S1Jjg6WttPRkPV5ssxI9rKUFtRBIIsPE4Gx?=
 =?us-ascii?Q?N/0/SMFzTg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n3YIbn4jvVeFi5XkK3QIAlGlm10NqXB3PYgpwVsWNWJu+bjKiU0gyoRpK2G/y1kBpC103pH3SUZ0sXmdz9se76je06p2KoacA94GeYsat347485TmkB4ukvph9faqhZKo2U0KTWcuCZ7E4fcLvKOMc+1V8gzZq3tlBefshn7a5ELuTUl4v3wtaUSi+r0jpUI3BeO7DYqbr/R49CR+04dOusQ9NiZQYBuaSQ1ZVSjcIBugyP/fn43tnuvxv+c4Gh69QmqkKpABE4BwCcJINQDIiSdpczweovBLc+dlKjHmXql6qwI2qzfNsnCSMzd4oVpEeNdOwnRR22KtobA1qLKsw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3793.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb17acf-2302-489c-d630-08ded1a34e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 03:47:25.7309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqfT/G8lNzH7Whb0Y6dXmvGUt6/yl54hKui66fhw/9+y5tIF48as4+70lu/Vn0zkAHkPitgWcJGCaaI+cbU1R67mvL1jN7eech5i32Uy3tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFED6629EA1
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301543-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kerneljasonxing@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56E546BB295



> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Tuesday, June 23, 2026 2:40 PM
> To: netdev@vger.kernel.org
> Cc: bpf@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;
> stfomichev@gmail.com; kuba@kernel.org; pabeni@redhat.com;
> horms@kernel.org; Vyavahare, Tushar <tushar.vyavahare@intel.com>;
> kerneljasonxing@gmail.com; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>
> Subject: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
>=20
> The UMEM state refactor made __send_pkts() use xsk->umem for Tx address
> generation. At the same time, the shared-UMEM Tx setup copies the Rx
> UMEM state into a Tx-local state object and resets base_addr and next_buf=
fer
> before configuring the Tx socket.
>=20
> Passing that Tx-local object to xsk_configure() makes xsk->umem point to =
the
> zero-based Tx allocator state. This breaks the BIDIRECTIONAL test once th=
e
> roles are switched: the same socket is then used for Rx validation, but r=
eceived
> descriptors from the other logical UMEM half are checked against base_add=
r
> =3D=3D 0. With the new UMEM bounds check, a valid address such as base_ad=
dr +
> XDP_PACKET_HEADROOM is rejected as being outside the UMEM window.
>=20
> Keep xsk->umem as the shared/Rx UMEM view used for socket configuration
> and Rx validation. Use the ifobject-local UMEM copy only for Tx descripto=
r
> address generation, preserving the BIDIRECTIONAL test's intent of using t=
he
> proper logical UMEM half after the direction switch.
>=20
> Fixes: b17631032769 ("selftests/xsk: Move UMEM state from ifobject to
> xsk_socket_info")
> Signed-off-by: Maciej Fijalkowski maciej.fijalkowski@intel.com

Reviewed-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Tested-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/test_xsk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index d8a1c0d40e5a..50a8dbacb63d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -1169,8 +1169,8 @@ static int receive_pkts(struct test_spec *test)  st=
atic
> int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b=
ool
> timeout)  {
>  	u32 i, idx =3D 0, valid_pkts =3D 0, valid_frags =3D 0, buffer_len;
> +	struct xsk_umem_info *umem =3D ifobject->xsk_arr[0].umem_real;
>  	struct pkt_stream *pkt_stream =3D xsk->pkt_stream;
> -	struct xsk_umem_info *umem =3D xsk->umem;
>  	bool use_poll =3D ifobject->use_poll;
>  	struct pollfd fds =3D { };
>  	int ret;
> @@ -1524,7 +1524,7 @@ static int thread_common_ops_tx(struct test_spec
> *test, struct ifobject *ifobjec
>  	umem_tx->base_addr =3D 0;
>  	umem_tx->next_buffer =3D 0;
>=20
> -	ret =3D xsk_configure(test, ifobject, umem_tx, true);
> +	ret =3D xsk_configure(test, ifobject, umem_rx, true);
>  	if (ret)
>  		return ret;
>  	ifobject->xsk =3D &ifobject->xsk_arr[0];
> --
> 2.43.0


