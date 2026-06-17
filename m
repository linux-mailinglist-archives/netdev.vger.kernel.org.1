Return-Path: <netdev+bounces-300157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w5rhMUWOMmop2AUAu9opvQ
	(envelope-from <netdev+bounces-300157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:08:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3776269983F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:08:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HdgXNG9+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300157-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300157-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43EA1315857E
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F63F166E;
	Wed, 17 Jun 2026 11:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41614396565;
	Wed, 17 Jun 2026 11:59:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697574; cv=fail; b=RCGFZEotSM461NwnzqnUnMQyhWNZxd6kLIMU3rtAFebDRdfkByJurb1H4hRy4qZ/qdsJz5LU/wPnhtHnijO7gHucdw0CDvW+3nOqsCjEOiI6JrzivQMJa5hO/YBYk1+SZQ7Gi1mh3azMqWNDN5HPpSar3O4OMBLQy0av+jsaMv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697574; c=relaxed/simple;
	bh=pRZc+ewMjp46IlwmkyQ6fE7WkTr5uSvovGoC1OX0WPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qxWe39R1hi0lHlkLkrbE0gso2s++WR+5+yzSgI6y70Ky6LWqpR9OPmcJVAkva6gQUDBXaytxXi6ZYC0a5UV6TWozLyeeMbYmdIjgDS72+hDHB1AnwRCozp1fBOvC63sq2Lx4B6Hk264SSVcVt6zIUl5iPAQ51pt5+M7s3VPEfcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdgXNG9+; arc=fail smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781697572; x=1813233572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pRZc+ewMjp46IlwmkyQ6fE7WkTr5uSvovGoC1OX0WPY=;
  b=HdgXNG9+QE2xS9r3QKTpItYCxQJlmyQqu9gkDxWty4Nlmw2Wc2Bmjghx
   530DilgSN3OLk0W4dpo0c9r6qYb4Y91WRq6E6joo945KtCZoxzbnZRyoa
   0RS9+xcJPHTkt8AafT69AxiN2JE+Z/nrrDNKd/3OOf1nB87wD1WHF/ITJ
   Ja/ZwHRPjKdO5c+5r3PaNUOSPicXHTFy4jRJDDG/j8WOjIaocbH8ux6yj
   pEE1oVJKJF2keCtxOaGCH0NDhD9oJMUeur03Vw8QKDT5UfmIfEPXmeo8Z
   fQrKDtbaM+qp5Ss78lvCJNoC7UImU6c0TR5HSCA748c/Zh/KCMFmNhWki
   g==;
X-CSE-ConnectionGUID: 1ALvOQZ8Q0KU1585KqzOoA==
X-CSE-MsgGUID: OZ+/9hcYRB+enuN7cA2l5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="100051782"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="100051782"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 04:59:31 -0700
X-CSE-ConnectionGUID: JSuVjlZ3THStr9uooGtKOw==
X-CSE-MsgGUID: QlT8qfzaQfKLN/h/4y+QGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="278239245"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 04:59:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 04:59:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 04:59:30 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 04:59:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIt8mTcaEefPBMQ8EniV3EDrLM1gb1yI8p+414b9dCroyZo5EQZ/YcsEziauWovjpo0x9kW+mDvaM2f8k0x86EXbHWlAsxllKHSdCG5kuJO9ksRX1jtj3qR0YSO1O70tUGOBjJpdiGXgLI9WbQlCKUTva4zR9QPOOd3Td5ACqhXcPoP65P8AYFSM9gV5bbHCxDdGnZNeXJXZS2wZuO5k2qrhQGQxUO6UQpC6nBcQM+cIAjwVhb9zNB98piWTuqwddycQN58VQW15hIapvcuoFCDerzYidWzYv0i8SaF08UXOo36ugUu2Ivll7tfceVfFH2DPNkclryg3zpgWy/Ix+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRZc+ewMjp46IlwmkyQ6fE7WkTr5uSvovGoC1OX0WPY=;
 b=a01itWonVYfxsRY2GJRY+E5ieFn1/T3Y9yDISYu+MKBBzvb+wJQ02y3VSwK6HwdkiJl3WApGIPlMtu4TYe9eIJd1Kyq9ApsX/AVRtkhNj2pya8lmg59KLWUxwgXYo7kuDn9Z4NRGrMMXqPakZRoPOUtiPQ5j8keyURtQzt4gMnfzJke4nDmhPkEoh390n6cB7FrYYde96r4CXPO71YFgz2rktYOvSlHs1nDLe9D0HysdoIXr1uBbZ2Xd9icQqyP7CODUlmspc6R3+T7S3tYBKoyaGxgv/w8elURc/vp0OLKale+7uK/G2SeofpWmNfdrMrjB5LggHAsqieBOXGDptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8749.namprd11.prod.outlook.com (2603:10b6:610:1c9::6)
 by PH0PR11MB5784.namprd11.prod.outlook.com (2603:10b6:510:129::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Wed, 17 Jun
 2026 11:59:26 +0000
Received: from CH3PR11MB8749.namprd11.prod.outlook.com
 ([fe80::d7ad:eaaa:e74:e7bd]) by CH3PR11MB8749.namprd11.prod.outlook.com
 ([fe80::d7ad:eaaa:e74:e7bd%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 11:59:26 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko
	<jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Donald Hunter
	<donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, "Schmidt, Michal" <mschmidt@redhat.com>, Paolo Abeni
	<pabeni@redhat.com>, "Vaananen, Pasi" <pvaanane@redhat.com>, "Oros, Petr"
	<poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, "Simon
 Horman" <horms@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Thread-Topic: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Thread-Index: AQHc8TXy37RQpn6zaEaBmwzfbXb7M7Y0w/LQgAAWBwCAABGk0IABDEQAgABT0HCAABLVgIABXZxggABB2QCAAVXzgIAGRr2AgAL8fYA=
Date: Wed, 17 Jun 2026 11:59:26 +0000
Message-ID: <CH3PR11MB8749910F17977B951A8B12CA9BE42@CH3PR11MB8749.namprd11.prod.outlook.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <b5853501-969a-4ac3-8aff-83c9da9c9834@redhat.com>
 <CH0PR11MB53941698BDF5C3B8298CC0679B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <aifTFMZtWBgLzhCS@FV6GYCPJ69>
 <CH0PR11MB5394DA86D0D2CA45FD3DBEA79B1D2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <99cebea4-156a-4379-922e-07c50f766fbe@redhat.com>
 <BN9PR11MB5401F6BA29CBA6F0C78FDB119B1A2@BN9PR11MB5401.namprd11.prod.outlook.com>
 <fcaa184b-f9e9-44c4-bae8-c4a9c6c41239@redhat.com>
 <aiqkZhNdt-WhglDg@FV6GYCPJ69>
 <ca33b9b8-aafa-40f0-9943-a6b6736af4e4@redhat.com>
In-Reply-To: <ca33b9b8-aafa-40f0-9943-a6b6736af4e4@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8749:EE_|PH0PR11MB5784:EE_
x-ms-office365-filtering-correlation-id: 8af1b3ef-e02e-4bd1-4578-08decc67e13c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|6133799003|3023799007|22082099003|18002099003|18092099006|4143699003|11063799006|56012099006|5023799004;
x-microsoft-antispam-message-info: xT9g+nUqqkgx8/bBxkSV0K312FnrFD03v2hlXWGDVlocnbg5MXg3LHK2VTE95BuTBe1FfeMfFS03mnWZ2TUQ62+kGGDYDN4uXoddxUxPqosUOLx36d+Cti8x0ZQ2iysU5Vczqy2igzT60WRXGPJvsB7F6Q+lDUud1UhIJdbmGkb0vXKSr3LtBzcp/aZlbZukJxzDrvDOX7tjw1HFNlGo11n08GYK0I46B/Tq+v//m9sQ6w1aab3ImagIMo1t+Rx/KGrORNGv773Z9O+mxoMWL0hZAo0jWjqja5i2xyl/S5nNk6RVaP/tfFZdrItvtBhSgKD8xagIhtzfvRQHDA7TuR9cBGT87gZJCzIuQ5e68Rb9K3KDBEqOnMuuOKHtMGCu0u/KqfIDGp22ZpXsLriFU2644O7TBKFIQWnfCD5bjts6G+CFLmnvvJ7SXxbLBA7on3EspnB+Bd430jP/ACKMqkls5VbtDQgXmq+pFZ5rCX94gFbyrdbrxKaqA93kQIuao6b+dwURH1m2VFMIUDfUJOXqBjL+WpemDWQhCVZMgn5x3AmL3jTPE3EEou23L/A1FkkLe1+SdMxrncXwE37iC+LBp62+T38cHAKNwjSgVlmDSPs5NsyQwT4FRqX7fRTFVUgRDJzTVJPvkhKNffSZl1L6L4AOWFbKbn/sNi+PIf3D51mgJKmfiUs0rIevdsYgQvSilGYxg5W62FCXjIJVWkMM6xuCdBq9EGE7wAFrtIPauxwydB3bDKtiDw3rfC3d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8749.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(6133799003)(3023799007)(22082099003)(18002099003)(18092099006)(4143699003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWtuR2ZRQkVISkZkOFM5c1g0eWV6ckc3V2c3Y2V6cjNCekh3U2ovL2J3MDVR?=
 =?utf-8?B?NS9wbXdUS29HRmNzNkl3RTdwMDR6ZklCdVM3MzFabjR6RmNCK2I1UzUrUnJ5?=
 =?utf-8?B?ZnJqV2RmSjNnN29WcXB4TU1iVG1SVURuOXI5TUFtUlBkaTVOdlJ2UFdCNERB?=
 =?utf-8?B?YXJhajBzWHB3cVRJaFFsQjFuQmlCNUdCcThtQVROWUR1R3ZWS0pxTXRCcHc3?=
 =?utf-8?B?cFdGaEhOUndvcnZ5akk3cC80WlgvcVpRc0VybURFMWFNejRoU0hyZkZMdUxV?=
 =?utf-8?B?ZGNjMXBsNmtJU2RQUktGZXNoYUZKMHV1N0NmWEFmNHk5VUhZdS9rYUZLYng3?=
 =?utf-8?B?NnMwM0FISnlNdkt5T255WUZXb1hmcVcxOUQxc3hkYVJLRm52WmRhUFJ3eVkx?=
 =?utf-8?B?Ymx6TTBIY0RwdEV4RDREdVBzVDN0K3RiaHZoYUhaanpmZWx4WGs2TGR1OEdP?=
 =?utf-8?B?YXdPSGNVZDlNWVNjdUhxc0pwdm9uK3pYQXFmUW15RGFMb0FWYlVtYnZKVld0?=
 =?utf-8?B?K3ZNSmNFU1puMGdHeEp0UWlnY2lteTZsN3lscENnZVhkaERZRDNRQWN2OE5S?=
 =?utf-8?B?VHRhdnBRMlBxbWVLRTJHWDdSSzJwZ0pqQWEyUHZzSGdKQ3pxZzZpSlp6QXVF?=
 =?utf-8?B?Ukp2aEZkTmplYzRUMkp4elFQeXE4VEhobjMvWmlWaXpPMmNnMFl4WFowcUtD?=
 =?utf-8?B?SXBVL2o2TTcwWjg3QjVHenVxSHBBKytoMnhGZnpsdGdKU1JQc0I5V0Q2MDZB?=
 =?utf-8?B?cWRxNDkzWGd0VE1GTGxwejIyNW9IcEpOVFNVb2x3UFdPN2JkQ0JQMDQra25h?=
 =?utf-8?B?bHloUjdxeThsK1E3M21YdzFKQWF0MTVPYm5PdzkrOTRaUmlBR0drbWVrVC9v?=
 =?utf-8?B?OFNEcGxyZFZOVzVQUWJEdG9ObE5nUFlWTmhQQXg0ZHRjYnpiTzBadXNQcTlh?=
 =?utf-8?B?TzlVYkNtcGpZdXgwZXI1eW1iTGhYMkpkd2h5eWFCU1lYY3FlamZQbHdSLzdI?=
 =?utf-8?B?UWJKUDl5c1ZQbGJ1S3dTR3pEcGw1OXNvdnBqeXpPMzdVbVZ6eWsxYS9FSDRF?=
 =?utf-8?B?b1MwTjhmdjlVNUg3R3ArT0tTdW02TWd4UmhyY1hZTHAyQ1pRR3ZBN25NUTJp?=
 =?utf-8?B?Y0JRanZXcHE4NjZXS1l0eGpkR2QwSkd6NHRIZDFncllWU21GRHIzZFM5eFk5?=
 =?utf-8?B?V2RMUytOalI0T2xxVG1WSGFFVXpTYzFsalhEK3ZWYk1tbWdCY25wZDA4R0lI?=
 =?utf-8?B?ZnVRTUtjSEV4T2RaN2YzUFBpMDg3MFFxaVEwODhVZjBsdWFEUklNaXRCbnlv?=
 =?utf-8?B?OXBBTFFDVXEwQlpudEpQSmVTTE53cDRUTkRWNUM1d2I0bTFKSmZDQ1NlTVpq?=
 =?utf-8?B?NWYrVEVaTU5IVUlmWDkxNXRTc2FYWXMvbkx0MHRyL3ZvYXpQQjdOVnJaNG1H?=
 =?utf-8?B?SG90TSttMXV0ZWoyOGswWjRvZGtqc2NZcUlzQW5hajVjVUp3Nkhvc0JOaTlw?=
 =?utf-8?B?aWV2bWY3Y1FuSFQ5MUh4OUQwMGFtOGhWRG82V2MzeGN1SFNKYUxCVkxxcCtR?=
 =?utf-8?B?VFI5OEx6d3lSeVJ5R2tyZTRIMWJDS0ZhU0p2TkFVeExSWmEwWGxZSTFCY1NW?=
 =?utf-8?B?cVBXVkdHMGQvd1NEZFVJSDZBdGEyUUF6bjlrSVkydGFwQldhRHVqSFJUT1dH?=
 =?utf-8?B?U1JqeTJkaEJVWS91SWlkYnlGakFMTUJoc0hEOWpQQlBkcGc2M3ErdWZVbW1r?=
 =?utf-8?B?UUhmcjB4cmNyL0d4NEdxaFBoakJhenJTdW4xN2NmS1dvbnM0NW5JMmxoYTB4?=
 =?utf-8?B?d0FPM3VyVnRDaUplMWs4TlFvb1UrMXBweGE2K1VMakJnL0w3RzJoaTRPRlVX?=
 =?utf-8?B?NDc5UlhnWTFhQko3TXIyWGpEZXhYcGowaXBycjNTOEtGSkZreUtKU25PZmQ0?=
 =?utf-8?B?TU5PQ0lUVi9LTWRKc3UyVm5oL3F6bHFBQVMxL01pZW1sVk1xOXlWZkFNQWgz?=
 =?utf-8?B?b2M3KzVLcVF2UjFsSkI0L2NGQnR0aXRvSGJkTEFvM1dwVmVoNTNaYjRWeGxp?=
 =?utf-8?B?NUpMUUZWemh4NzAvWjhzRGI3YWczeWU1Mi9OTkg0Ulp0UlMwM0d6clljNkZL?=
 =?utf-8?B?blB6dEV0N0dmSVE2d3dlcml3SXY2eU40WlpzMHNzZWI1eUJrWVJMYjhXREx3?=
 =?utf-8?B?Ym81MS93bk44UFl5WUtGTU1pR1c2WXY0M0JaNVVoNkozTE14TU1WWWZEdmY5?=
 =?utf-8?B?RVdKdVNmQmRtZXE2Z0taV1BoN2toc3B6SitpMlJnb2QrUHVBcGZpZDBlSlNT?=
 =?utf-8?B?NVRrWWFRNnFia3UwQ2FaYXU0ZDdnVEVPZnVHQTExWHFKNzdhL1ovK1NsUUto?=
 =?utf-8?Q?AEURfKwFFFE0Dq14=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PEcKIyQvEv/lClnAuZvwR8f3Bd36+RlXjYIKTGTLTqnTFle2iluSPvqsIxqZrms+IacXPp0SAuasOe2MU70lUpphlv0Y11mkBfVVZdpJsJvgOj1ZdfO7j+AadE2keE9l7CsW5eo+m/wVNt/JAS7ZpxBkPBSTQ1RMYYuxWmha2TFT7lraCihjyiG9ZfDDur1HxztxmY2qzfC7F/IkLTy/IScdvtEP0QIgPoYXPcZ+1qgwCKwLK3TvTP70KnP6VMKqNlnTjwFtxUTZumhNrlelhpb/VeLpTWAUBlxgvEUHRPnDbA1JESG0b3Qd5JcF6kjmhUmY+ScULLLgJDDsOtVaSg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8749.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af1b3ef-e02e-4bd1-4578-08decc67e13c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 11:59:26.5508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNLy5AqVZYIhWqkEVg/KyF8vmeacFEfwsf/0JKMHryrjlrPU5Ez7bkhSGrntMTqhhsFJZH6RRTPe5gJaqxw3oeg5PjkMgKaKelE8UFq/mZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5784
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300157-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:jiri@resnulli.us,m:vadim.fedorenko@linux.dev,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:from_mime,vger.kernel.org:from_smtp,resnulli.us:email,CH3PR11MB8749.namprd11.prod.outlook.com:mid];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,kernel.org,redhat.com,microchip.com,linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3776269983F

PkZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+DQo+U2VudDogTW9uZGF5LCBK
dW5lIDE1LCAyMDI2IDI6MDAgUE0NCj4NCj5PbiA2LzExLzI2IDI6MDkgUE0sIEppcmkgUGlya28g
d3JvdGU6DQo+PiBXZWQsIEp1biAxMCwgMjAyNiBhdCAwNTo0NTo0NlBNICswMjAwLCBpdmVjZXJh
QHJlZGhhdC5jb20gd3JvdGU6DQo+Pj4gT24gNi8xMC8yNiAzOjA0IFBNLCBLdWJhbGV3c2tpLCBB
cmthZGl1c3ogd3JvdGU6DQo+Pj4+PiBGcm9tOiBJdmFuIFZlY2VyYSA8aXZlY2VyYUByZWRoYXQu
Y29tPg0KPj4+Pj4gU2VudDogVHVlc2RheSwgSnVuZSA5LCAyMDI2IDQ6NTkgUE0NCj4+Pj4+DQo+
Pj4+PiBPbiA2LzkvMjYgNDowMCBQTSwgS3ViYWxld3NraSwgQXJrYWRpdXN6IHdyb3RlOg0KPj4+
Pj4+PiBGcm9tOiBKaXJpIFBpcmtvIDxqaXJpQHJlc251bGxpLnVzPg0KPj4+Pj4+PiBTZW50OiBU
dWVzZGF5LCBKdW5lIDksIDIwMjYgMTA6NTEgQU0NCj4+Pj4+Pj4NCj4+Pj4+Pj4gTW9uLCBKdW4g
MDgsIDIwMjYgYXQgMDc6MDM6NDZQTSArMDIwMCwNCj4+Pj4+Pj4gYXJrYWRpdXN6Lmt1YmFsZXdz
a2lAaW50ZWwuY29tDQo+Pj4+Pj4+IHdyb3RlOg0KPj4+Pj4+Pj4+IEZyb206IEl2YW4gVmVjZXJh
IDxpdmVjZXJhQHJlZGhhdC5jb20+DQo+Pj4+Pj4+Pj4gU2VudDogTW9uZGF5LCBKdW5lIDgsIDIw
MjYgNTo0OCBQTQ0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gT24gNi84LzI2IDQ6NDMgUE0sIEt1YmFs
ZXdza2ksIEFya2FkaXVzeiB3cm90ZToNCj4+Pj4+Pj4+Pj4+IEZyb206IEl2YW4gVmVjZXJhIDxp
dmVjZXJhQHJlZGhhdC5jb20+DQo+Pj4+Pj4+Pj4+PiBTZW50OiBTdW5kYXksIE1heSAzMSwgMjAy
NiA5OjQ0IFBNIC4uLg0KPj4+Pj4+Pj4+Pj4gICAgICAgICAgIC0NCj4+Pj4+Pj4+Pj4+ICAgICAg
ICAgICAgIG5hbWU6IGduc3MNCj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgIGRvYzogR05TUyByZWNv
dmVyZWQgY2xvY2sNCj4+Pj4+Pj4+Pj4+ICsgICAgICAtDQo+Pj4+Pj4+Pj4+PiArICAgICAgICBu
YW1lOiBpbnQtbmNvDQo+Pj4+Pj4+Pj4+PiArICAgICAgICBkb2M6IHwNCj4+Pj4+Pj4+Pj4+ICsg
ICAgICAgICAgRGV2aWNlIGludGVybmFsIG51bWVyaWNhbGx5IGNvbnRyb2xsZWQgb3NjaWxsYXRv
ci4NCj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgV2hlbiBjb25uZWN0ZWQgYXMgYSBEUExMIGlucHV0
LCB0aGUgRFBMTCBlbnRlcnMgTkNPDQo+Pj4+Pj4+Pj4+PiBtb2RlDQo+Pj4+Pj4+Pj4+PiArICAg
ICAgICAgIHdoZXJlIHRoZSBvdXRwdXQgZnJlcXVlbmN5IGlzIGFkanVzdGVkIGJ5IHRoZSBob3N0
DQo+Pj4+Pj4+Pj4+PiB2aWENCj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgdGhlIFBUUCBjbG9jayBp
bnRlcmZhY2UuDQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IEhpIEl2YW4hDQo+Pj4+Pj4+Pj4+DQo+
Pj4+Pj4+Pj4+IEhvdyB3b3VsZCB5b3UgY29udHJvbCB0aGlzIGluIGNhc2Ugb2YgYXV0b21hdGlj
IG1vZGUgZHBsbD8NCj4+Pj4+Pj4+Pj4gQXV0b21hdGljIG1vZGUgRFBMTCBzaGFsbCBiZSBjb250
cm9sbGVkIG9uIEhXIGxldmVsLCBzdWNoIHBpbg0KPj4+Pj4+Pj4+PiBicmFrZXMgdGhhdCBydWxl
IGFuZCByZXF1aXJlcyBzb21lIGRyaXZlciBtYWdpYyB0byBzaG93IGl0IGlzDQo+Pj4+Pj4+Pj4+
IGhpZ2hlciBwcmlvcml0eSB0aGVuIHRoZSByZXN0IG9mIHRoZSBwaW5zPw0KPj4+Pj4+Pj4+DQo+
Pj4+Pj4+Pj4gVGhlIE5DTyBwaW4gY2FuIGJlIGNvbm5lY3RlZCBvbmx5IGluIG1hbnVhbCBtb2Rl
LiBJbiBvdGhlciB3b3Jkcw0KPj4+Pj4+Pj4+IGENCj4+Pj4+Pj4+PiBEUExMIGluIGF1dG9tYXRp
YyBtb2RlIGNhbm5vdCBzZWxlY3QgTkNPIHBpbiAoc3dpdGNoIHRvIE5DTyBtb2RlKQ0KPj4+Pj4+
Pj4+IGJ5DQo+Pj4+Pj4+Pj4gaXRzIG93bi4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+
IEJlaW5nIHBpY2t5IG9uIERQTExfTU9ERSBmb3IgZW5hYmxpbmcgZmVhdHVyZSBpcyBub3Qgc29t
ZXRoaW5nIHdlDQo+Pj4+Pj4+PiBjYW4gYWxsb3cgaWYgaXQgaXMgbm90IHJlbGF0ZWQgdG8gSFcg
bGltaXRhdGlvbiwgaXMgaXQ/DQo+Pj4+Pj4+PiBDb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB3
aHkgaXQgaXMgbm90IHBvc3NpYmxlIGZvciBBVVRPTUFUSUMNCj4+Pj4+Pj4+IG1vZGU/DQo+Pj4+
Pj4+DQo+Pj4+Pj4+IEluIGF1dG9tYXRpYyBtb2RlLCB0aGUgcGluIHNlbGVjdGlvbiBsb2dpYyBp
cyBkZWZpbmVkIHVwb24gcHJpby4gSQ0KPj4+Pj4+PiBjYW4gaW1hZ2luZSB0aGF0IGlmIE5DTyBw
aW4gaGFzIHRoZSBoaWdoZXN0IHByaW8gb2YgdGhlIGF2YWlsYWJsZQ0KPj4+Pj4+PiBvbmVzLCBp
dCBnZXRzIHBpY2tlZC4gSSB3b3VsZCBiZSBhbGlnbmVkIDEwMCUgd2l0aCBhdXRvbWF0aWMgbW9k
ZQ0KPj4+Pj4+PiBiZWhhdmlvdXIuDQo+Pj4+Pj4+IElzIHRoZXJlIGEgcmVhbCB1c2VjYXNlIGZv
ciBpdD8NCj4+Pj4+Pj4NCj4+Pj4+Pj4gWy4uXQ0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBpcyBub3Qg
dHJ1ZS4gQVVUT01BVElDIG1vZGUgaXMgSFcgc29sdXRpb24sIFNXIGRyaXZlciBPTkxZDQo+Pj4+
Pj4gY29uZmlndXJlcyBwcmlvcml0aWVzIG9uIHRoZSBpbnB1dHMsIG5vdCBtYW5hZ2VzIHRoZSBh
Y3RpdmUgaW5wdXRzLg0KPj4+Pj4+IFRoaXMgYnJha2VzIHRoYXQgYmVoYXZpb3IsIHRoZSBTVyBk
cml2ZXIgd291bGQgaGF2ZSB0byBtYW51YWxseQ0KPj4+Pj4+IG92ZXJyaWRlIHRoZSBBVVRNQVRJ
QyBtb2RlIHRvIGJlIGZlZCBmcm9tIHN1Y2ggTkNPIHBpbiBhcyBpdCBkb2Vzbid0DQo+Pj4+Pj4g
ZXhpc3RzIG9uIGl0J3MgcHJpb3JpdHkgbGlzdCwgSFcgY2Fubm90IHBpY2sgb3IgdXNlIGl0Lg0K
Pj4+Pj4NCj4+Pj4+IENvcnJlY3QsIEFVVE8gbW9kZSBpcyBoYXJkd2FyZSBmZWF0dXJlIGFuZCBp
dCBzaG91bGQgbm90IGJlIGVtdWxhdGVkDQo+Pj4+PiBieSBhDQo+Pj4+PiBkcml2ZXIuIElmIHRo
ZSBoYXJkd2FyZSBkb2VzIG5vdCBzdXBwb3J0IGl0IHRoZW4gdGhlIHN3aXRjaGluZw0KPj4+Pj4g
YmV0d2Vlbg0KPj4+Pj4gaW5wdXQgcmVmZXJlbmNlcyBzaG91bGQgYmUgZG9uZSBieSB1c2Vyc3Bh
Y2UgKGJ5IG1vbml0b3JpbmcgZmZvLA0KPj4+Pj4gcGhhc2Vfb2Zmc2V0LCBvcGVyc3RhdGUpLg0K
Pj4+Pj4NCj4+Pj4NCj4+Pj4gWWVzLCBleGFjdGx5LCBzbyBmb3IgQVVUT01BVElDIG1vZGUgSFcg
aXQgd2lsbCBub3QgYmUgcG9zc2libGUgdG8NCj4+Pj4gY3JlYXRlDQo+Pj4+IHN1Y2ggcGluLCB3
aGljaCBtZWFucyB0aGF0IE5DTyBwaW4gd291bGQgc2VydmUgb25seSBhIE1BTlVBTCBtb2RlDQo+
Pj4+IGltcGxlbWVudGF0aW9uLg0KPj4+PiBCYXNpY2FsbHkgdGhpcyBpcyBzb21ldGhpbmcgd2Ug
c2hhbGwgbm90IGFsbG93IHRvIGhhcHBlbi4gRFBMTCBBUEkNCj4+Pj4gc2hvdWxkIGJlIGRlc2ln
bmVkIHRvIGNvdmVyIHRoZSBjYXNlIHdoZXJlIEFVVE8gbW9kZSBpcyBhYmxlIHRvDQo+Pj4+IGlt
cGxlbWVudA0KPj4+PiBhbGwgZmVhdHVyZXMgY29uc2lzdGVudGx5Lg0KPj4+DQo+Pj4gSWYgeW91
IGRvbid0IGxpa2UgdGhlIHByb3Bvc2FsIGZyb20gSmlyaSAoTkNPIHN3aXRjaCBkcml2ZW4gYnkg
TkNPIHBpbg0KPj4+IHByaW9yaXR5IC0+IGhpZ2hlc3Q9PWVudGVyX25jbyBlbHNlIGxlYXZlX25j
bykgdGhlbiBpdCBjb3VsZCBiZQ0KPj4+IHBvc3NpYmxlDQo+Pj4gdG8gaGFuZGxlIHRoZSBzd2l0
Y2hpbmcgYnkgYWxsb3dpbmcgdGhlIHN0YXRlICdjb25uZWN0ZWQnIGluIEFVVE8gbW9kZQ0KPj4+
IGZvciB0aGUgTkNPIHBpbiB0eXBlLiBUaGVuIHRoZSBpbXBsZW1lbnRhdGlvbiB3aWxsIGJlIHRo
ZSBzYW1lIGZvciBib3RoDQo+Pj4gc2VsZWN0aW9uIG1vZGVzLg0KPj4+DQo+Pj4gT25seSBkaWZm
ZXJlbmNlIHdvdWxkIGJlIHRoYXQgYSB1c2VyIGRvZXMgbm90IG5lZWQgdG8gc3dpdGNoIHRoZSBk
ZXZpY2UNCj4+PmZyb20gdGhlIEFVVE8gdG8gTUFOVUFMIG1vZGUuDQo+Pj4NCj4+Pj4+PiBUaGUg
cmVhbCB1c2UgY2FzZSBpcyB0aGF0IGFueSBEUExMIGNhbiBzd2l0Y2ggdGhlIG1vZGUgdG8gdGhp
cyBvbmUNCj4+Pj4+PiBpbnN0ZWFkIG9mIGltcGxlbWVudGluZyBNQU5VQUwgbW9kZSBqdXN0IHRv
IHVzZSB0aGUgZmVhdHVyZSB3aXRoIGENCj4+Pj4+PiAndmlydHVhbCcgcGluLg0KPj4+Pj4NCj4+
Pj4+IEkgZG9uJ3QgZXhwZWN0IHRoaXMuLi4gYnV0IGl0IGlzIHVwIHRvIGEgZHJpdmVyLiBJIGRv
bid0IHBsYW4gc3VjaA0KPj4+Pj4gZnVuY3Rpb25hbGl0eSBpbiB6bDMwNzN4IGFzIHRoZSBOQ08g
cGluIGRvZXMgbm90IGV4cG9zZSBwcmlvX2dldCgpDQo+Pj4+PiBhbmQNCj4+Pj4+IHByaW9fc2V0
KCkgY2FsbGJhY2tzIC0gc28gaXQgaXMgY2xlYXIgdGhhdCB0aGlzIHBpbiBjYW5ub3QgYmUgcGFy
dCBvZg0KPj4+Pj4gdGhlDQo+Pj4+PiBhdXRvbWF0aWMgc2VsZWN0aW9uLg0KPj4+Pj4NCj4+Pj4+
IEl2YW4NCj4+Pj4NCj4+Pj4gVGhlcmUgaXMgYSBkaWZmZXJlbmNlIGJldHdlZW4gcGFydGljdWxh
ciBIVyBhbmQgQVBJIGNhcGFiaWxpdGllcywgd2l0aA0KPj4+PiB0aGUNCj4+Pj4gcHJvcG9zZWQg
QVBJIHdlIHdvdWxkIGRpc2FsbG93IHRoZSBwb3NzaWJpbGl0eSBvZiBzdWNoIGltcGxlbWVudGF0
aW9uDQo+Pj4+IGZvcg0KPj4+PiBleGlzdGluZyBIVyB2YXJpYW50cy4NCj4+Pj4NCj4+Pj4gRFBM
TCBOQ08gTU9ERSB3b3VsZCBhbGxvdyB0aGF0IGJ1dCBhcyBwb2ludGVkIGhlcmUgYnkgSXZhbiBh
bmQgYnkgSmlyaQ0KPj4+PiBpbg0KPj4+PiB0aGUgb3RoZXIgZW1haWwgaXQgd291bGQgYWxzbyBy
ZXF1aXJlIHRoZSBleHRyYSBpbXBsZW1lbnRhdGlvbiBmb3INCj4+Pj4gc29tZQ0KPj4+PiBjb25m
aWd1cmF0aW9uIC0gZGV2aWNlIGxldmVsIHBoYXNlL2ZmbyBoYW5kbGluZy4NCj4+Pj4NCj4+Pj4g
VG8gc3VtbWFyaXplIGl0IGFsbCwgSSBkb24ndCBoYXZlIHN1Y2ggc2ltcGxlIHNvbHV0aW9uIGZv
ciBpdC4NCj4+Pj4NCj4+Pj4gRmlyc3QgdGhpbmcgdGhhdCBjb21lcyB0byBteSBtaW5kIGlzIHRv
IGNvbWJpbmUgYm90aCBhcHByb2FjaGVzLg0KPj4+PiBNYWtlIGl0IHBvc3NpYmxlIGZvciBBVVRN
QVRJQyBtb2RlIHRvIGFsc28gc2V0ICJDT05ORUNURUQiIHN0YXRlDQo+Pj4+IG9uIGNlcnRhaW4g
a2luZCBvZiAiT1ZFUlJJREUiIHBpbnMsIHdoZXJlIGl0IGNvdWxkIGJlIGRldGVybWluZWQgYnkN
Cj4+Pj4gdGhlIHR5cGUgb2YgUElOIGFuZCBlbWJlZCB0aGF0IGxvZ2ljIGludG8gdGhlIERQTEwg
c3Vic3lzdGVtLg0KPj4+DQo+Pj4gVGhlIHBvc3NpYmxlIHN0YXRlcyBmb3IgcGFydGljdWFsIHBp
bnMgYXJlIG5vdyBoYW5kbGVkIGF0IGEgZHJpdmVyDQo+Pj4gbGV2ZWwNCj4+PiBzbyB0aGUgZHJp
dmVyIGRlY2lkZXMgaWYgdGhlIHJlcXVlc3RlZCBzdGF0ZSBpcyBjb3JyZWN0IG9yIG5vdC4gU28g
aXQNCj4+PiBjb3VsZCBiZSBlYXN5IHRvIGltcGxlbWVudCB0aGlzLg0KPj4+DQo+Pj4gRm9yIGF1
dG8gbW9kZSBhbGxvd2VkIHN0YXRlczoNCj4+PiAtIGlucHV0IHJlZmVyZW5jZXM6IHNlbGVjdGFi
bGUgLyBkaXNjb25uZWN0ZWQNCj4+PiAtIG5jbyBwaW46IGNvbm5lY3RlZCAvIGRpc2Nvbm5lY3Rl
ZA0KPj4+DQo+Pj4+IEJhc2ljYWxseSwgaWYgZHJpdmVyIHJlZ2lzdGVycyBzdWNoIE5DTyBwaW4g
aXQgd291bGQgYmUgYWx3YXlzDQo+Pj4+IHNlbGVjdGVkDQo+Pj4+IG1hbnVhbGx5LCBhbmQgaW4g
c3VjaCBjYXNlIGFsbCB0aGUgb3RoZXIgcGlucyBhcmUgZ29pbmcgdG8NCj4+Pj4gZGlzY29ubmVj
dGVkDQo+Pj4+IHN0YXRlIHdoaWxlIERQTEwgbW9kZSBpcyBhbHNvIGEgIk9WRVJSSURFIiBvciBz
b21ldGhpbmcgbGlrZSBpdC4NCj4+Pg0KPj4+IEkgd291bGQgbGVhdmUgdGhpcyBkZWNpc2lvbiBv
biB0aGUgZHJpdmVyIGxldmVsLi4uIEltYWdpbmUgdGhlDQo+Pj4gcG90ZW50aWFsDQo+Pj4gSFcg
dGhhdCB3b3VsZCBhbGxvdyB0byBzd2l0Y2ggTkNPIG1vZGUgaWYgdGhlcmUgaXMgbm8gdmFsaWQg
aW5wdXQNCj4+PiByZWZlcmVuY2UuDQo+Pj4NCj4+PiBFeGFtcGxlOg0KPj4+DQo+Pj4gUkVGMCAo
cHJpbyAwKSAtPiArLS0tLS0tKyAtPiBPVVQwDQo+Pj4gUkVGMSAocHJpbyAxKSAtPiB8IERQTEwg
fCAtPiAuLi4NCj4+PiBOQ08gIChwcmlvIDIpIC0+ICstLS0tLS0rIC0+IE9VVG4NCj4+Pg0KPj4+
IFN1Y2ggSFcgd291bGQgcHJlZmVyIFJFRjAgb3IgUkVGMSBhbmQgbG9jayB0byBvbmUgb2YgdGhl
bSBpZiB0aGV5IGFyZQ0KPj4+IHF1YWxpZmllZC4gQnV0IGlmIHRoZXkgYXJlIE5PVCwgdGhlbiBp
dCBzd2l0Y2hlcyB0byBOQ08gbW9kZS4NCg0KTm93IHlvdSBzYWlkIHlvdXJzZWxmICJOQ08gbW9k
ZSIgLi4uIEkgYWdyZWUgdGhhdCBpdCB3b3VsZCBiZSBhIG1vZGUgaW4NCnRoYXQgY2FzZS4gV2hl
cmUgaW5zdGVhZCBvZiBydW5uaW5nIG9uIHJlZ3VsYXIvYnVpbHQgaW4gWE8gZHBsbCB3b3VsZCBy
dW4NCm9uIE5DTyBhbmQgdXNlciBjb3VsZCBzZWxlY3QgaXQsIGFuZCB0aGlzIHdvdWxkIGJlIGFk
ZGl0aW9uIHRvIHJlZ3VsYXINCmJlaGF2aW9yLg0KDQpJIGFsc28gYWdyZWUgdGhhdCB0aGUgcGlu
IGFwcHJvYWNoIG1pZ2h0IGJlIGJldHRlci9lYXNpZXIgdG8gdXNlLCBhc3N1bWluZw0KZnJlcXVl
bmN5IG9mZnNldCBmb3IgYWxsIHRoZSBvdXRwdXRzIGdpdmVuIGRwbGwgZHJpdmVzLCBpdCBtYWtl
cyBtb3JlIHNlbnNlDQp0byBoYXZlIGl0IGNvbmZpZ3VyYWJsZSBvbiBpbnB1dCBzaWRlLg0KDQo+
Pj4NCj4+PiBJbiB0aGlzIHNpdHVhdGlvbiB0aGUgcmVsZXZhbnQgZHJpdmVyIHdvdWxkIGFsbG93
IHRvIGNvbmZpZ3VyZSBwcmlvcml0eQ0KPj4+IGFuZCBzdGF0ZSAnc2VsZWN0YWJsZScgZm9yIHRo
aXMgTkNPIHBpbi4NCj4+Pg0KPj4+PiBQZXJoYXBzIHRoZSBwaW4gdHlwZSBjb3VsZCBpbmNsdWRl
IE9WRVJSSURFIGluIGl0J3MgbmFtZSB0byBtYWtlIGl0DQo+Pj4+IGxlc3MNCj4+Pj4gY29uZnVz
aW5nIGFuZCBuZWVkcyBzb21lIGV4dHJhIGRvY3VtZW50YXRpb24uDQo+Pj4+DQo+Pj4+IFRob3Vn
aHRzPw0KPj4+IEkgdGhpbmsgX0lOVF8gaXMgb2suIEluIHRoZSBjYXNlIG9mIFRZUEVfSU5UX09T
Q0lMTEFUT1IgaXQgaXMgYWxzbw0KPj4+IG9idmlvdXMgdGhhdCBpdCBpcyBub3QgYSBzdGFuZGFy
ZCBpbnB1dCByZWZlcmVuY2UuDQo+Pj4NCj4+PiBKaXJpLCBWYWRpbSwgQXJlaywgdGhvdWdodHM/
DQo+Pg0KPj4gSSBhZ3JlZSB3aXRoIHlvdSwgdGhlIGRyaXZlciBzaG91bGQgaGF2ZSB0aGUgZmxl
eGliaWxpdHkgdG8gaW1wbGVtZW50DQo+PiB0aGlzIGFjY29yZGluZyB0byBoaXMvaHcncyBuZWVk
cy9jYXBhYmlsaXRpZXMuIElmIGl0IGltcGxlbWVudHMgcHJpbw0KPj4gc2VsZWN0aW9uIGluIEFV
VE8gbW9kZSwgbGV0IGl0IGhhdmUgaXQuIElmIGl0IGltcGxlbWVudHMgbWFudWFsIE5DTyBwaW4N
Cj4+IHNlbGVjdGlvbiBpbiBBVVRPIG1vZGUgdXNpbmcgY29ubmVjdGVkL2Rpc2Nvbm5lY3RlZCBv
dmVycmlkZSwgbGV0IGl0DQo+PiBoYXZlIGl0Lg0KDQpJIGRvbid0IGtub3cgJ2N1cnJlbnQnIEhX
IHRoYXQgaXMgY2FwYWJsZSBvZiB1c2luZyBBVVRPIG1vZGUgYXMgYSBwYXJ0IG9mDQpIVy1iYXNl
ZCBwcmlvcml0eSBzb3VyY2Ugc2VsZWN0aW9uIGFuZCB1c2Ugc3VjaCBOQ08gaW5wdXQuLg0KQnV0
IGFzIGFscmVhZHkgZXhwbGFpbmVkIGFib3ZlLCB0aGlzIGlzIHNwZWNpYWwgbW9kZSBvZiByZWd1
bGFyIFhPLCB3aGljaA0KYWxsb3dzIERQTEwncyBvdXRwdXQgZnJlcXVlbmN5IG9mZnNldCBjb25m
aWd1cmF0aW9uLg0KDQo+Pg0KPj4gTW9yZW92ZXIsIEkgYWN0dWFsbHkgbGlrZSB0aGUgIm92ZXJy
aWRlIiBjYXBhYmlsaXR5IGZvciBwaW5zIGluIEFVVE8NCj4+IG1vZGUgaW4gZ2VuZXJhbC4gSXQg
bWF5IGJlIGhhbmR5IGZvciBvdGhlciB1c2VjYXNlcyBhcyB3ZWxsLg0KPj4NCj5BcmVrPyBWYWRp
bT8NCj4NCj5UaGFua3MsDQo+SXZhbg0KDQpBZ3JlZSwgJ292ZXJyaWRlJyBjYXBhYmlsaXR5IG9m
IGEgcGluIHdvdWxkIGJlIHRoZSB3YXkgdG8gZ28gZm9yIHRoaXMgYW5kDQpvdGhlciBzaW1pbGFy
IGZ1cnRoZXIgY2FzZXMuDQoNCkkgYmVsaWV2ZSBhIHNpbmdsZSBhcHByb2FjaCBvbiB0aGlzIHdv
dWxkIGJlIGJlc3QsIEkgbWVhbiBpZiBBVVRPIG1vZGUNCm5lZWRzIGEgY2FwYWJpbGl0eSwgdG8g
c3dpdGNoIGZyb20gcmVndWxhciBiZWhhdmlvciB0byAnT1ZFUlJJREUnLCBhbmQNCidPVkVSUklE
RScgaXMgb25seSBwaW4gY2FwYWJpbGl0eSB0aGF0IGFsbG93cyBzdWNoIGJlaGF2aW9yIGZvciBB
VVRPDQptb2RlLCB0aGVuIHNpbWlsYXIgYXBwcm9hY2ggc2hvdWxkIGJlIHVzZWQgb24gTUFOVUFM
IG1vZGUsIHRvIG1ha2UNCnVzZXJzcGFjZSBrbm93IHRoYXQgc3VjaCBwaW4gaXMgYWx3YXlzIGF2
YWlsYWJsZSB0byBzZXQgIkNPTk5FQ1RFRCINCmFuZCBtYWtlIHRoZSB1c2Vyc3BhY2UgaW1wbGVt
ZW50YXRpb24gY29uc2lzdGVudCBvbiBlbmFibGluZyBpdCBubyBtYXR0ZXINCmlmIEFVVE8gb3Ig
TUFOVUFMIG1vZGUgZHBsbC4NCg0KVGhhbmsgeW91IQ0KQXJrYWRpdXN6IA0K

