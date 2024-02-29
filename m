Return-Path: <netdev+bounces-76319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604F586D3EE
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 21:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A13B1C21247
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A913F423;
	Thu, 29 Feb 2024 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfCdJ9Ow"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395542E410
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237349; cv=fail; b=Qp38RcPAlPxkN3G/lhYRuhZp6+ClMLfx3i4zkbfhYFSVIw4ripyQM21kstsuvhTqKILr5jGjtxXEpzLRMH5OjCzGNWAANJ0KttK2eiV7HUbKJ7JBSTIpc5v387SvoOtEN2HUCQ1D2riyyRyy2NOFncspD2amHMplKO9hcOdBEDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237349; c=relaxed/simple;
	bh=MJgPw5rsBuqGil6SZREP1rAyJoBUcNS7PKu9SBvApBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eOe2rEya5+KXBRnkE0+wBQns/uPDpbww8enDh6UOxiK1PnJuPVYKiX5ErwUysvxw2ClG3WjRzim3q/ksQHarLbcrelAKP1ntYMMszZZiau72JUCQIAxwFXy59mGnd0kEypVM/L+FWlT6k0Q2J90QrWXNOI046YS4yOSpXx3CCBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfCdJ9Ow; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709237347; x=1740773347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MJgPw5rsBuqGil6SZREP1rAyJoBUcNS7PKu9SBvApBs=;
  b=FfCdJ9OwQhJIGEKkULsdW2SX4mUKXdnJYyqmVAk2Z5VNhVkQlzup+Ndq
   54HrD8p7y99NBEt1Luybsxu52uv+GWLYKBRDgJJ1tplc/chPllMPj/ZYK
   CdXh6GJX+xNrB7b+kr16xHzgvCAxVrQa1qksxofGr/IU9HudLVQWzPAFQ
   s3H/gNODy0QzYO6E9wVC748fnRP7oZ+jaUGlH7nLZMzPMe29wjKt6rV1C
   3v+QOnXsdtVONpRg4zWkuQwDmQiL7tZ1L5mb099zKevorLmSmhB/p5kI6
   7ipPZ0MD8mLg/LshLBjElfZAORRcrRt0Lc5obxWwfq/OHoXr7pFX7l17K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3597655"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3597655"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 12:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="31130839"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 12:09:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 12:09:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 12:09:05 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 12:09:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGtUIgPKnLN0Q1EUHvrasiyi3PnanRuX2LQ9ZqkRoOaDUYCDI1ej/AY6GHb+9CUg6YUDOeliqkFlSoTmqjTDek3l6FkXH+NuYxl1fugT9h1366GfwU/aMpXFEPi78v4MBAIS5UrI9AKOnjyqUdqpG1e90dskU5xwDmfq+ueyrD24ImgbR7tKgm/lBVPkM9INLhyDNaiwuCffkV/85qAIyn4V+ya8bBSQCgDHJzh3o5J3TLJNAWISE6EEzNfmlPTPLQtm5UMfty63bZ7hesCpqGA5YZs35K0Jv7yCX2O9nYOJ6FsHw7vWkoU5mphzalZSnyPIAlxBjxyRqHDwBYr7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJgPw5rsBuqGil6SZREP1rAyJoBUcNS7PKu9SBvApBs=;
 b=AFQqPBBD13VDegECzCLLcK9qWcAM7GeqDwelpH1U2RusBYIwH93FC8lpQ6c1z/T2G2qvJITMpcltyArsZYZzRhmd4wrqAvNxUcX1xriuVCFub5ZbxqeZ0R1DoVgZ5VzbViLV48zP/rHAPzhfVSnoQM3Z3g4IeQvSk/PD6zQlhn4zlRTQb0A162QBNIRxTJz7m5YSTx3KFhGqYQDSLp4vZuQMs9EqviefnTNL06YdMPrPJNr7jcADpGrye/LSKFfXT23KPr/J8cCNol2WUUTv2rJ1pDblqfEX8A08wWylBKssEyRNgql9QLK1B1Rc7fXdPZnCTkHY+yfw8plzmKH1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB8060.namprd11.prod.outlook.com (2603:10b6:510:24f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Thu, 29 Feb
 2024 20:09:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7362.010; Thu, 29 Feb 2024
 20:09:03 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, Jiri Pirko <jiri@resnulli.us>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "nathan.sullivan@ni.com"
	<nathan.sullivan@ni.com>, "Pucha, HimasekharX Reddy"
	<himasekharx.reddy.pucha@intel.com>
Subject: RE: [PATCH net] igb: extend PTP timestamp adjustments to i211
Thread-Topic: [PATCH net] igb: extend PTP timestamp adjustments to i211
Thread-Index: AQHaaa3CU9jnRWXQz0yaMwdkAd6u27EfgEIAgAAvpICAAFdHMIAAsteAgAEIxLA=
Date: Thu, 29 Feb 2024 20:09:03 +0000
Message-ID: <CO1PR11MB508939BB0C87493121CBE3B2D65F2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240227184942.362710-1-anthony.l.nguyen@intel.com>
	<Zd7-9BJM_6B44nTI@nanopsycho>	<Zd8m6wpondUopnFm@pengutronix.de>
	<PH0PR11MB5095A06D5B78F7544E88E614D6582@PH0PR11MB5095.namprd11.prod.outlook.com>
 <20240228202055.447485cb@kernel.org>
In-Reply-To: <20240228202055.447485cb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH7PR11MB8060:EE_
x-ms-office365-filtering-correlation-id: cd96269f-8d5e-473b-0eb1-08dc39624674
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FACHR/ktc8J2iWJeoNH6Gb9zsGunivScyU9AW9zH8t5YVTUXH3CdlUfCsFomIlSnWZtfo73GaAGmSysQ+gu2eZSCCSuS4V4NV+BcbLlfH15QvvAGg/ystFyI69GbdilrCgqqjorvkQHOEkKUEdkucr20XRePS67w7kiYFuffevhvV6e8Sa233k083bmowTtTCP/zBr2cjIyWWYWXkz9Fku6hfnlxV7ipnM7CmD/8kaQowUd0rJ5hz3fPYjRDPjLdKNW4uePHmi2furY9cSRCTY5hQ52JUQeQ2deA0l1E6X3wy56YfXp0huSJ8e9WrfdBIH6eGXMPn7nasPoU+rdoWbEWb4NWnW/ov/Lq/YTgoJ5B+bvwYNIX75LIYZ1kt3ZznR4QSxfExZCM6fJL9b9oWMcl93p7tOnayMl+kx1XcsQI8kU2Nv2q2zDi0Sl84hzR4isFzyyvR/knTFEpYBPSiV4Acmp0UkUJvFqnFA6l0x1GUoAjdOAwAttFo0Io16yePomXR7u/UPXew3vzS7ZBMa0AFXEBxxAPdq8PWyXwDemskAjelIEQ2SQp19XEFdn8Wio69iNzPpifT2qIc/p4MR6aomWCyMWlFXLZE71fHyJQ+YOz1s4I0TpveutQXkQjcJ05LpGoAB1a1Je4yY3QSWX/f+0547DC7uYze03rOLldpv472aFJaj69MfkAiIMRZhebBjMKuz4FETfyCfU0bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUsxR2ZPS3lGaCs0V1dEZUJwbFVjZUh1bGVRUndLZkFBeEMwcGlWZlBoU1Nh?=
 =?utf-8?B?OUsvYU9EUEJleTlUZkF0OHBkblFraDczcW1PK0VYMzB5QzVWT3hydXJsekts?=
 =?utf-8?B?MWNqQyt4Qk1heTFQWXVPZjdrVk5DUmtCdFYxZzk1MFBIRitaRzZ3Ry9idnNq?=
 =?utf-8?B?dDlsRnp3S2NEaG5VZkUrV21QNTdyakFkSFBLU3J2NC9KdUZla2hjenlBeW8z?=
 =?utf-8?B?S1VIYTRYcUlNNFA1eGoxZWxZODQ4Wm44b0h6NitJRTNtVndMYkZhZFBvbzR1?=
 =?utf-8?B?dGxsTFp5clo1OVBMVjRDM0toWVU1OVorcW9XVFRwa0VTZ0dKT3ExaUpzRFRG?=
 =?utf-8?B?WGFKcmxVTER0KzFZUGs4cnhPV1VjdGtWNFdxZXgxdzNJR0NrejZDd3paK1dy?=
 =?utf-8?B?dHZuTS9UNEdnR24zTFNiUDdrZEt6ZXZTYXlOQ0RWK3BPa3k0dUM2am1mdGpB?=
 =?utf-8?B?U0plU2pkaHFKNHl6WGZ1ZVE3RUVlUkV4OVhvOWxLVVhITkxzR1dWcUJDam9p?=
 =?utf-8?B?ZEJqTVZFU3N2eW9YOUh5UysrMlRJZGZSaFp2Q2JTTlJlUW1EMkFzbEtRdmhH?=
 =?utf-8?B?alJFQk05d0l1ZGcrNWs3RlF6MTg1TE1WTzAxZ05IM3cwU3hFWG85cCt1bmtK?=
 =?utf-8?B?Vm01ZHBRdC81QkhTT3oyTVM5L3lYY0hZbTRSS25vdEhyNDNwUUVLTytkUmZ0?=
 =?utf-8?B?SUdiSk80YWk4RkNRRis4SktnblJpdVFrYzRFOEJRZTVaQTdmZW14VWdwY1ov?=
 =?utf-8?B?T0JIcE9IYStTeWc1TUl1aFMrUTVKM0hrdVpnS3lNYVBiMEJoUy9XR0VUcEw2?=
 =?utf-8?B?bHlINkFzQ093akhaU2wxUXRaNDdGbE5zVG11K0pvRXU4bnplQUdMdUFXQXdm?=
 =?utf-8?B?MVF6VC9VZkFPSW5TTkFQMTM1QndCdFo5ZHozVVozM3U5UGlCb1dES201YXpv?=
 =?utf-8?B?MFArZGY2R0JCNHl6cG8yUnhCZk9mVW5lZXdEMEFEVXZNRG8xQ0dkY0RzenFt?=
 =?utf-8?B?b2ZhTnFCZkRCOVpvWDRTK2tiUTFhVGhhOEFVZ1hJYm1zYUdONm12MThyelNF?=
 =?utf-8?B?TkNwQjlFRkZhS2JQTmRuVHFuMmdQeXJDbkxreG42ODA2WTk4bFpRTEZiMm43?=
 =?utf-8?B?RmpzR1VuZHEvUEFobmdWSGJ0a3hyL1B6bURLblVDZzVpeFZmYWxvaXA5LzBY?=
 =?utf-8?B?T0k2b0xSVENPL0pnMEdHb29ya0VUbzFhVmt1Vm8xWkJZVzl5dDNxd0dkcFBI?=
 =?utf-8?B?cC9mUU9HWlBBclppMnJlRkIyT3c4aC9iNmxOZVRUZnF2UFNXMW9Rd3FRVms5?=
 =?utf-8?B?cXJia0oxRGovejhZcStDQm1jQzdyLzNjRjEzUTZyZnRDVDdsSmdCQnF3VWZ5?=
 =?utf-8?B?RHU2UU1MM2phcDlGenE0bCticjRocGtDMEcwYng5L3dVNFZCblFtSHkwVm5Q?=
 =?utf-8?B?OHlINk9TSFNWc01aUjZ5VjMxMVE5dVpiWWdjdStuM3YzbjhBeVFjRTVGYmp3?=
 =?utf-8?B?RUNGNUR2bVhqWkQ4a2pIRDZ5SHp0UzV2eHJTclVDK0JJZUxQM3RpR0xQNmhJ?=
 =?utf-8?B?WTBVR2JWZ3ZkNUhoU1UvNlExbGx0V3pKQkVkZXV6dUZ0QVhhYUJYdVRRYm5i?=
 =?utf-8?B?Tk1RdDJvSHBnZFh6MkZLTEhrbExQU2JhRmVXeVU4OUFQQ0hWdlNmMHE5bVZL?=
 =?utf-8?B?cmVNUVlRcmF1NXZ3eXJvb2c2YmVCR1hxY2E2dk9TMVRFV1d1SHJ1RW8yUEpJ?=
 =?utf-8?B?a3NkRDZDd2daYWF6cXVLcW9TalphZUJqaUtpQXFxSEIyMTNQbVJUcE1vc0Fs?=
 =?utf-8?B?Z09sc0tITExYTUVDeVB5OEE3QkE0Q0gzYVBqdkFib1pjY2I5R0hPbDRHL2NM?=
 =?utf-8?B?Z21YYis5Y21Ta1R1dTdqVU5DQnVOMXdyZnMyYTVFSk5YUDJlTDBmWlZiR1dh?=
 =?utf-8?B?SnJEbE5ySys5SjRncWZ0cFhYRUp3cWJFSVdlNHdlSER5RmFISGVkakN5cC9q?=
 =?utf-8?B?eWo4bnRmZERTMlpiaERYeWtQMVNpSmpIV2JSOHF2aWRYd05XM1AydFREYzFu?=
 =?utf-8?B?dWpMVE52ZHJEaHBNUHhTbWNTQ25OQnFEeUxpTCtwYTRNL3JhYnh0MERJZ0dx?=
 =?utf-8?Q?xYGW+veb1DrqJOPtxRvn9y6Fc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd96269f-8d5e-473b-0eb1-08dc39624674
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 20:09:03.1094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLzcxJvB3ImuMlgKN3CrBUMWkoJIDPQapdwqqCa9qP9CFOiv8SFmG/gJUfhGU5w00zca0ZUOXVbvawbEB3nFfxS4EbyTu2EC7CQjq7pOpnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8060
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFrdWIgS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyOCwgMjAyNCA4
OjIxIFBNDQo+IFRvOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4N
Cj4gQ2M6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT47IEppcmkgUGly
a28gPGppcmlAcmVzbnVsbGkudXM+Ow0KPiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5n
dXllbkBpbnRlbC5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBwYWJlbmlAcmVkaGF0LmNv
bTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gcmljaGFy
ZGNvY2hyYW5AZ21haWwuY29tOyBuYXRoYW4uc3VsbGl2YW5AbmkuY29tOyBQdWNoYSwgSGltYXNl
a2hhclggUmVkZHkNCj4gPGhpbWFzZWtoYXJ4LnJlZGR5LnB1Y2hhQGludGVsLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBuZXRdIGlnYjogZXh0ZW5kIFBUUCB0aW1lc3RhbXAgYWRqdXN0bWVu
dHMgdG8gaTIxMQ0KPiANCj4gT24gV2VkLCAyOCBGZWIgMjAyNCAxNzo0MzowMyArMDAwMCBLZWxs
ZXIsIEphY29iIEUgd3JvdGU6DQo+ID4gV2l0aG91dCB0aGlzLCB0aGUgaTIxMSBkb2Vzbid0IGFw
cGx5IHRoZSBUeC9SeCBsYXRlbmN5IGFkanVzdG1lbnRzLA0KPiA+IHNvIHRoZSB0aW1lc3RhbXBz
IHdvdWxkIGJlIGxlc3MgYWNjdXJhdGUgdGhhbiBpZiB0aGUgY29ycmVjdGlvbnMgYXJlDQo+ID4g
YXBwbGllZC4gT24gdGhlIG9uZSBoYW5kIEkgZ3Vlc3MgdGhpcyBpcyBhICJmZWF0dXJlIiBhbmQg
dGhlIGxhY2sgb2YNCj4gPiBhIGZlYXR1cmUgaXNuJ3QgYSBidWcsIHNvIG1heWJlIGl0cyBub3Qg
dmlld2VkIGFzIGEgYnVnIGZpeCB0aGVuLg0KPiANCj4gSSB0b3NzZWQgYSBjb2luIGFuZCBpdCBz
YWlkLi4uLiAid2hhdGV2ZXIsIG1hbiIuIFN1Y2ggc2FzcywgdHNrIHRzay4NCg0KSSBtaWdodCBo
YXZlIG5vdCBoYWQgZW5vdWdoIGNhZmZpZW5lIHdoZW4gd3JpdGluZyB0aGF0IGVtYWlsLi4uIPCf
mIoNCg==

