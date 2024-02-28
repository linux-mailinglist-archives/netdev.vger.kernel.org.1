Return-Path: <netdev+bounces-75865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0299F86B648
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 18:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7493D1F29247
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A6C15DBAE;
	Wed, 28 Feb 2024 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kX/+BCm4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A415B11F
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142189; cv=fail; b=asH8wqrB73S5XAZNLuuiR7VSBCP6sXa3X5EudVMkrCWnCwNez1MHSTARzPo/nM+b1iBBl757HQ9BTwRZSOhr+EwWu0Mqd/QPIUaecIrvJBQiRBzVKNI7ATN8HfeWBvjLwevo38cJ/wS65ENdcnxSNWnRiRqSzvCKbYuCkA07k4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142189; c=relaxed/simple;
	bh=/+OAc4Iad7oxoLAueg9UnVwyzPTUQHRDg7FNU+AFFjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KSXXlEgC8hD4eLPgaDUth/gQUzteG+LX4NHJ92Fr8wTR4wHRebuiBAeBWycqQD54e/+dn3XaOg01kZxm/Y/CXTqtCtUHfk0YkECHEmm5h6XoXSE6JWCgMmmL3tRIyl7Akop+pFQZD37doE3tnnG2bSj4p9V8ygdvyxua1aBU+II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kX/+BCm4; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709142188; x=1740678188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/+OAc4Iad7oxoLAueg9UnVwyzPTUQHRDg7FNU+AFFjA=;
  b=kX/+BCm4sxFYPrGfS5M5WH1JrSgDob9CZU350iwKjoTlqTitz7D3+Zvi
   C+rh3K5jupE7PmSK7tmjrF3H/n5t3UbBVqB/TJedXxIIkB5RHBHCOERIp
   OT5TD88DjO4TxrCiXv0hQqGZ2p9xWtqy+HuT93DVfzb4a8LieNdrPtvGU
   NzP0qfJqVOVTqtwXykVTsG2+WyvmGvXkj0O5czzPwfJwQf1r5eRlCMMKg
   KGK2emlmgVLGRwI1UIOYtW1eg7i1CkMMeDe6mx+xIKtqykoeEr9Ig1tto
   vP5UlOgGfvbMZoPX0D2UIYVuqCVu8Dco/DC90qiY9cZrwk6WLVToSdJMf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3724403"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3724403"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:43:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="38352019"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 09:43:07 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 09:43:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 09:43:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 09:43:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMnvWOd81CtzByQWlnldVdIcdn2PQvydtIsqzaOKj2ZH5H19Ca9ZCpOsg7j3BIF1pyY16+OR1WkPsfM7zNWehVF9k/8Dz4Wvh/u4vWEOo2gIVEPDS6cgVBBHJY/yGjx5U1yuF4myTHs84VO+rXMdNTQuiPsCg194lXZFcmw965nywHe2PL0Sg3kI8mmpcJVHwz1Bgm0v3Jf/CJX4BdTJqJ9R+b0w8WQKpJWg7P3b9pX1Bc3Nl5iZ7GmuNbvFond8uVKxEUrq+eICCdI990QReedZTYcfm9ZRRwY+vw5VAwTRRWJXyOQS9NB4+eY/AvjYsbm/yIkKVrwmq8pRDBbZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+OAc4Iad7oxoLAueg9UnVwyzPTUQHRDg7FNU+AFFjA=;
 b=Dt/jxanRqL0NqhF0hOn0R3DGElm3x3HIK9MopoCcVfrVASkAy9DmrnjQhvYMIYxt96Wcb6e06ZQ3cZix+6R56sdgYa6Zea9PnPFuhpcA96rDnlAG+FLn/Nu7SnsENIuOXhc5bsbddWEiuyHfUvh8jMDW3kap7I3lL6z5jPKIqwtIr3KWpYTzkJtzYPOiZAd/K7TyYJoOth6oHZk/7CVRt+B2r4Eg6dnlueZlutIt0ZUwbo2G4Rsiu7Wu2Hgs98fiFPiMiwB3+rRGXQbKpu2W1S/5F3fopShcaqavUhiWitSxQ5oCDkhgWrvOlvQOoagYxHSqxygL0/PdyT7mHo3P9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by PH7PR11MB7571.namprd11.prod.outlook.com (2603:10b6:510:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Wed, 28 Feb
 2024 17:43:03 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::6f88:5937:df91:e4b]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::6f88:5937:df91:e4b%7]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 17:43:03 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Jiri Pirko <jiri@resnulli.us>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"nathan.sullivan@ni.com" <nathan.sullivan@ni.com>, "Pucha, HimasekharX Reddy"
	<himasekharx.reddy.pucha@intel.com>
Subject: RE: [PATCH net] igb: extend PTP timestamp adjustments to i211
Thread-Topic: [PATCH net] igb: extend PTP timestamp adjustments to i211
Thread-Index: AQHaaa3CU9jnRWXQz0yaMwdkAd6u27EfgEIAgAAvpICAAFdHMA==
Date: Wed, 28 Feb 2024 17:43:03 +0000
Message-ID: <PH0PR11MB5095A06D5B78F7544E88E614D6582@PH0PR11MB5095.namprd11.prod.outlook.com>
References: <20240227184942.362710-1-anthony.l.nguyen@intel.com>
 <Zd7-9BJM_6B44nTI@nanopsycho> <Zd8m6wpondUopnFm@pengutronix.de>
In-Reply-To: <Zd8m6wpondUopnFm@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5095:EE_|PH7PR11MB7571:EE_
x-ms-office365-filtering-correlation-id: e8212d45-e26d-4695-9fcb-08dc3884b6a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fheRb4lxe0P39eiy8kBwapU/FTuLz2pep0ydRkGhmLUYxE6atQHoF0f+t58wUPuf6D+c5uApEDOY5cVkxue+17cz5fb7hPvyidPxflA62GMlF4Wq+6ytmoecRsfaZ2MIt/CXEaWpYlIyBNjHcEh7q7EQjy5QNc16RyLHSoDmC70cvr7g2XY5Efl6e4lLRZyYxX0FsxIrdB5fkCW1eHYBO7d108rPkAbAeTfDFLX58vHTVnKeahB4v6Ei9GAvJi809j7ep+rbbOVxaDR9KkLvclbyF1GEXWDgFEH37x6i4EhEFHkSCO6PXhs9SzwDUw0OghCTGJfsdTCuEMAZDECygiofJBudyVswGnXNkomySvojCe+8mPINyXVVZs5gGWnD9V1Y7lb8h9CaVCy7GZrsruh/vkp4WSJTF1doVBVwLXrWHchl7odFRM3TYnJGb322tcjcX3oNP1uFrr9Jl0iOblhU2Yl+EiqxI290v5qkFKC2gO3yjxRVziBjd5RyatNizb1SkqxkqXbuhlkN3p5W7LjHqTu1TLvIFkilA1r6S1SgeAV7U+XVqMr6RhgWlnxcYcOlmZGx8S73Lqj9Aaz52AA2xWMVBa9mcrDQWWRgszysyT5xl//Fpy6LL+M2vzp8ZmOKpFu1VwqjykcaGP9t4oDLrkre9No+fnSDfP9Qix6nQg2BqYJ+rKCdl7CN4PSpwnKJJQtVZlNeat86VLK9Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmkwYzd5ODJEYnJqUVJhTmpnaGVjQ21YcDZOL2JEZ2hKTVczL1JoOWpoby82?=
 =?utf-8?B?R1ErVTNMQjk3anNCOGwzU0xtZVpYSTN1U09MK1Zub0RwYy9QMEc4ZUxBVnNJ?=
 =?utf-8?B?S0t5YW5yVlRZeExWdVVjSnU4aW8xT0F5ZzR6Z0w5VndxQzJOTm42N0E1czll?=
 =?utf-8?B?Z0prU1FTK0wrd1ZodS9NdFJZcU5GUE1SNUhpUmJuZ3FaY0V3cENHQ2xHMnIv?=
 =?utf-8?B?VzNCVjNBUzJZSnNqdjJqdkhLdnR0WFloOVJFYUd0VG5YQlQ4ekM2Rktjb245?=
 =?utf-8?B?bzRjVFZXZFZjbEF4N3NjTUpBemhlbzljclREUnd0dFk1Z0FzYjgrYXNoaGxZ?=
 =?utf-8?B?bjFhbHR4am0wU0h1UXVReHlIYlZaQWlBc1ZTaU5WZWhBSCtGSHVOVXV2N3Uy?=
 =?utf-8?B?d3A1NUNxelFXbVQ3YWFYSWtwSi9TWTJQR2U3K2hUZlh0VzVZUGtyK3FLVUZH?=
 =?utf-8?B?MHNxRHAxQTJwUE1rdEtkRGZIeVJlNld1Q1dxazhFMUx2N2tjaURtWHpDZUNY?=
 =?utf-8?B?RCtMeWFBUU1QcnRDQmx6ME9YWU5qaHc3ZkNSVmhGQVpoRlpUc0U2Y3NTdlBW?=
 =?utf-8?B?TGpLQWcyd3FDU1dldVJmLzFKZGsxaWY2WWVCTVJkRmNJU2JNUWJRRm1lRng4?=
 =?utf-8?B?SnRaQ0lTb09ISE5lbVdKdmtSemF2VzF4QmFJWWRtKzViRVJwalJTNjFMRTJG?=
 =?utf-8?B?SUdJTHp1NHdWZHFXbm5PQ2dOZW8wY3dBcWtxOERRb1FSd3p5cEsrM1N6cGpr?=
 =?utf-8?B?M3hPQVJtVk9FYmpua25FNWVrenVxKzlLZDQ4cWpUSkpMNnFrUHF3Y0dIYVhR?=
 =?utf-8?B?RU01Nm1GWW4yR213QnlUQlljemF5aGY5NnROL1VoYmU4ZkdDdmdrSGhvQ0p6?=
 =?utf-8?B?Q25vdDhaV0MzaTd3RFJEMVRRVmpucGRPakdMdno1OFNnbnlLaXJKa3N0ZXZC?=
 =?utf-8?B?VmoxOHVySDJpM0FBM2ZsNUlJakZRZHZIc0xsK043aERyOTZ6RjNmM1dla3Vt?=
 =?utf-8?B?TzA2Z1hPV000U2FZSlVZSzhQcVZ3Z1c4ZWVyWkUrY1ZudkxDWkRKcDVUdFNt?=
 =?utf-8?B?N09KODUzN3FNVklGZVM0bFNuZnhmUW9uWHhodGoxQjhIaFcranhaYWQxakVl?=
 =?utf-8?B?Rk9yc0FtSUJDTUxQVk1JQ0lMd2tDemdnSTNlcGJuYlZjczg2RDVnK2JQT20w?=
 =?utf-8?B?aHgwRnYyaWVuWkZTUmZoQ083Ry8zZXE0b2RUbVBzVFhFMGdkTFRrd0VlQzlJ?=
 =?utf-8?B?RFZWU1d3U2NTMjZXQmxhTC9tWnBJMmFoSjNKcEtaY3kwZzR0UDR0b2dHcHJp?=
 =?utf-8?B?R0VzREp0cGxGRFptaWtOQ0JvL0QzZS95Ymx4SWU3bGlMS1BoaEg4U2MrYVhw?=
 =?utf-8?B?Q3BVcUY4YTFNSmR0eG9RaCs0eGVTNisyQjFxcTJBMkNLT083VUhVS2NtSVh3?=
 =?utf-8?B?WmszcC9vWkVsSWIvNmE1WXQzMllsVldrWlJmeDV3QnMyYXdGV28weUtDV2Nm?=
 =?utf-8?B?bHFURFJIdld0aW1qVU9qWVdXKzlYRUsxcnhydnNMSCt4ekdpK3h4c3ZidVF5?=
 =?utf-8?B?MjRPeWNZY1lyekJKNUYzYXVNbEFEZHp6WGVvSWNweWRxWHZXUjlXY2ZmRjMy?=
 =?utf-8?B?TXFpWEJERE00Q2dteE96YjJuc0E5QzF6YTczaE9MbURBSjBXN2JXcjluYVoz?=
 =?utf-8?B?djluRHVveWkrZ3d0M1RvQlhkNmRjbVROZUF0R01SS25YOHp2L0xOWjFBOW85?=
 =?utf-8?B?d1hxcEVMRzkzM0FIVmRERlF5TEVUb21udGEvdlpQWEhwc3NrWC80ZFFiVWg5?=
 =?utf-8?B?N3RVN3o3NDdyZ29lMTZqM1E0d2VHZ25vSzRwajhoa2I3d2hRa0tpOFp5TSsr?=
 =?utf-8?B?OXAySU5wbXZmZGNCTC9iNGF6TWhvZXU1S2xtdG5WTjJMZFBraUNxSUcvRnpw?=
 =?utf-8?B?d3d5SEU5azV5UHdBUkVQRGhGUUU4bnVlcVV2aFEvNElBS0R0dHlFaHF0cU5Y?=
 =?utf-8?B?TmFQUG9mOVE3WGk1cFc2UjhXcWt3YjlHUjNSbEhEKzNhMWhrU0dkMTRRZ1hu?=
 =?utf-8?B?cG1ReVFDV2RXbDRGMXpkSE1iWDliVWJpUUFUT1oyMzlMcFlCUk54UFVXY0JC?=
 =?utf-8?Q?NmMgNKamW6OVEsUaxUpcULtMm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8212d45-e26d-4695-9fcb-08dc3884b6a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 17:43:03.0956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1u9egstGxIhpF1vJQm7vk+9geK1R0qQ6Aa3QSvUy+skzjHeLvdmjYUUmBpxUEh0X3LsQ9fWTZ8+zwKKTsd3xFePQGEY3fU2/4AuBvROjIeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7571
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xla3NpaiBSZW1wZWwg
PG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI4
LCAyMDI0IDQ6MjggQU0NCj4gVG86IEppcmkgUGlya28gPGppcmlAcmVzbnVsbGkudXM+DQo+IENj
OiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBkYXZlbUBk
YXZlbWxvZnQubmV0Ow0KPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBlZHVt
YXpldEBnb29nbGUuY29tOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyByaWNoYXJkY29jaHJh
bkBnbWFpbC5jb207IG5hdGhhbi5zdWxsaXZhbkBuaS5jb207DQo+IEtlbGxlciwgSmFjb2IgRSA8
amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgUHVjaGEsIEhpbWFzZWtoYXJYIFJlZGR5DQo+IDxo
aW1hc2VraGFyeC5yZWRkeS5wdWNoYUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
bmV0XSBpZ2I6IGV4dGVuZCBQVFAgdGltZXN0YW1wIGFkanVzdG1lbnRzIHRvIGkyMTENCj4gDQo+
IE9uIFdlZCwgRmViIDI4LCAyMDI0IGF0IDEwOjM3OjU2QU0gKzAxMDAsIEppcmkgUGlya28gd3Jv
dGU6DQo+ID4gVHVlLCBGZWIgMjcsIDIwMjQgYXQgMDc6NDk6NDFQTSBDRVQsIGFudGhvbnkubC5u
Z3V5ZW5AaW50ZWwuY29tIHdyb3RlOg0KPiA+ID5Gcm9tOiBPbGVrc2lqIFJlbXBlbCA8by5yZW1w
ZWxAcGVuZ3V0cm9uaXguZGU+DQo+ID4gPg0KPiA+ID5UaGUgaTIxMSByZXF1aXJlcyB0aGUgc2Ft
ZSBQVFAgdGltZXN0YW1wIGFkanVzdG1lbnRzIGFzIHRoZSBpMjEwLA0KPiA+ID5hY2NvcmRpbmcg
dG8gaXRzIGRhdGFzaGVldC4gVG8gZW5zdXJlIGNvbnNpc3RlbnQgdGltZXN0YW1waW5nIGFjcm9z
cw0KPiA+ID5kaWZmZXJlbnQgcGxhdGZvcm1zLCB0aGlzIGNoYW5nZSBleHRlbmRzIHRoZSBleGlz
dGluZyBhZGp1c3RtZW50cyB0bw0KPiA+ID5pbmNsdWRlIHRoZSBpMjExLg0KPiA+ID4NCj4gPiA+
VGhlIGFkanVzdG1lbnQgcmVzdWx0IGFyZSB0ZXN0ZWQgYW5kIGNvbXBhcmFibGUgZm9yIGkyMTAg
YW5kIGkyMTEgYmFzZWQNCj4gPiA+c3lzdGVtcy4NCj4gPiA+DQo+ID4gPkZpeGVzOiAzZjU0NGQy
YTRkNWMgKCJpZ2I6IGFkanVzdCBQVFAgdGltZXN0YW1wcyBmb3IgVHgvUnggbGF0ZW5jeSIpDQo+
ID4NCj4gPiBJSVVDLCB5b3UgYXJlIGp1c3QgZXh0ZW5kaW5nIHRoZSB0aW1lc3RhbXAgYWRqdXN0
aW5nIHRvIGFub3RoZXIgSFcsIG5vdA0KPiA+IGFjdHVhbGx5IGZpeGluZyBhbnkgZXJyb3IsIGRv
bid0IHlvdT8gSW4gdGhhdCBjYXNlLCBJIGRvbid0IHNlZSB3aHkgbm90DQo+ID4gdG8gcmF0aGVy
IHRhcmdldCBuZXQtbmV4dCBhbmQgYXZvaWQgIkZpeGVzIiB0YWcuIE9yIGRvIEkgbWlzdW5kZXJz
dGFuZA0KPiA+IHRoaXM/DQo+IA0KPiBGcm9tIG15IHBlcnNwZWN0aXZlLCBpdCB3YXMgYW4gZXJy
b3IsIHNpbmNlIHR3byBuZWFybHkgaWRlbnRpY2FsIHN5c3RlbXMNCj4gd2l0aCBvbmx5IG9uZSBk
aWZmZXJlbmNlIChvbmUgdXNlZCBpMjEwIG90aGVyIGkyMTEpIHNob3dlZCBkaWZmZXJlbnQgUFRQ
DQo+IG1lYXN1cmVtZW50cy4gU28sIGl0IHdvdWxkIGJlIG5pY2UgaWYgZGlzdHJpYnV0aW9ucyB3
b3VsZCBpbmNsdWRlIHRoaXMNCj4gZml4LiBPbiBvdGhlciBoYW5kLCBJJ20gb2sgd2l0aCB3aGF0
IGV2ZXIgbWFpbnRhaW5lciB3b3VsZCBkZWNpZGUgaG93DQo+IHRvIGhhbmRsZSB0aGlzIHBhdGNo
Lg0KPiANCj4gUmVnYXJkcywNCj4gT2xla3Npag0KDQpXaXRob3V0IHRoaXMsIHRoZSBpMjExIGRv
ZXNuJ3QgYXBwbHkgdGhlIFR4L1J4IGxhdGVuY3kgYWRqdXN0bWVudHMsIHNvIHRoZSB0aW1lc3Rh
bXBzIHdvdWxkIGJlIGxlc3MgYWNjdXJhdGUgdGhhbiBpZiB0aGUgY29ycmVjdGlvbnMgYXJlIGFw
cGxpZWQuIE9uIHRoZSBvbmUgaGFuZCBJIGd1ZXNzIHRoaXMgaXMgYSAiZmVhdHVyZSIgYW5kIHRo
ZSBsYWNrIG9mIGEgZmVhdHVyZSBpc24ndCBhIGJ1Zywgc28gbWF5YmUgaXRzIG5vdCB2aWV3ZWQg
YXMgYSBidWcgZml4IHRoZW4uDQoNCkFub3RoZXIgaW50ZXJwcmV0YXRpb24gaXMgdGhhdCBsYWNr
aW5nIHRob3NlIGNvcnJlY3Rpb25zIGlzIGEgYnVnIHdoaWNoIHRoaXMgcGF0Y2ggZml4ZXMuDQoN
ClRoYW5rcywNCkpha2UNCg0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiBTdGV1ZXJ3YWxk
ZXIgU3RyLiAyMSAgICAgICAgICAgICAgICAgICAgICAgfCBodHRwOi8vd3d3LnBlbmd1dHJvbml4
LmRlLyAgfA0KPiAzMTEzNyBIaWxkZXNoZWltLCBHZXJtYW55ICAgICAgICAgICAgICAgICAgfCBQ
aG9uZTogKzQ5LTUxMjEtMjA2OTE3LTAgICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBI
UkEgMjY4NiAgICAgICAgICAgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0K

