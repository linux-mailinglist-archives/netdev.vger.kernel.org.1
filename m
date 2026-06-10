Return-Path: <netdev+bounces-297675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RI+PGvRhKWotWAMAu9opvQ
	(envelope-from <netdev+bounces-297675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:09:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 328A3669996
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:09:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=NH6GMjfa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297675-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297675-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B50233004D1B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE33E16AB;
	Wed, 10 Jun 2026 13:04:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15828FFF6;
	Wed, 10 Jun 2026 13:04:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096691; cv=fail; b=ZhRAPE//JTgGMQaFmkqTSXGJ/tHrB3N2RZXV/Z5jufss2umf0ufXfn4f3HDirnuPrQRwfehc6SgkL6yG1gTQETOxp1jaEzHCkAX2aYZfZSuNg28YFasuvH/9uG4y63qhbKXG4nCeeHW7Bp9oiDm9NcfsM4QTXvol/KJgSLN/AVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096691; c=relaxed/simple;
	bh=UIDcXGyq3X7s7NHmgR/4sEwNF0sO5k1IKqKdThjhG9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gkMIlR8s3tvQRatoZUansqGYSwiCvw2tWKpKLK/y1ha+Kcs1elI4EaV0wz6PfWJ+7ifOizwMjNd95rsyFfqd1LFMTCYCISLIoJrX7n22C5twqilt2oS0sv7gX2pFNOUJ21bV5JIbQMu5xFhiTANl/URtsRRute0C+6bJ5DsDMvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NH6GMjfa; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781096690; x=1812632690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UIDcXGyq3X7s7NHmgR/4sEwNF0sO5k1IKqKdThjhG9c=;
  b=NH6GMjfaUj8vxs3ziiL5ATDRpEaAYYwchVvDFj62mlQbeN2TwKXm6MDN
   7uUS/uVK6npNjpCgdFkdXNGcbbieJf/WR1uhCYQgylkfz4+GlrVn0KagO
   QH0Lym9EQsANHV7Yj3HmfZX2arFwzLCL0UfuY19U4vEiHEypWdd/bPd5G
   Fckt/LNsQnQkHfGXKJ837LIxymVYCdXhRMUtGq5GEN7sl26JYiUWOyFBy
   Wef0GqkrIGzURPdELWirdnHm7yL0redQRsuXg0fUKxa+Jee9P7Ebt7HKS
   e8C3bxs4lWCV8/4E2dVy9Qr0c8sf6XHU0IFplbC8eIHPewqJBa96as8LC
   g==;
X-CSE-ConnectionGUID: 2pNrGOsQQiiBif/LpGVg8g==
X-CSE-MsgGUID: vaKtDm2dR9ucvg6/XHo0TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92561733"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="92561733"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:04:45 -0700
X-CSE-ConnectionGUID: KWyVVzyOT9e6wiGY1VDC/Q==
X-CSE-MsgGUID: zTqYITFmQNW9TYFCFDMbHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="284251293"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:04:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 06:04:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 06:04:40 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 06:04:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsCHX8Rg4pTIrokewUqRTDAHBAX+PW1uIcC58joHPJ0vpCodTa9/2flllRcRC/cJT+e1vLstBmDfr21+Q/dBE5hYzJV3b384QUeEG8KO1v/LD8zQdzCLL1dbzOPzTcej+Y9WHG/7rBzAScHq6rgb4b4fIroMLSAz+GQKFRWJlWZYwmTHYMmfzifmtqeHSg9tNkL7lRDV8+ERcpoGdasPDlC5v0ulcbEJouWAgQQ85Xbl7n/r5nQgxRVRBx+ePtEGU2EM3pTaDBSWnVQfM+Td02teLPO8wQa0aMC2Y6r8ssj+FxxqsI6gMQFr5lkfbAv3cHH9z87dE3wMlLXNrffSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIDcXGyq3X7s7NHmgR/4sEwNF0sO5k1IKqKdThjhG9c=;
 b=Mzm+ZqDHe6YGb9UQ95Mhrpah0pYlN0u04pY4MdDCpxHIPic3ZHGsUSeXRs//XDowIM+hOyAmTU816GJnq+1qmwPATCcbUekFqOfiWaRitjNMaCvr+SB7FwEi4Q3wo1hxeadvl6SUF0gCUCsilH7218mnk/TxA/ENfzANIYJhExf3vmOplgD3o40LnTeHyee2P2awGgj72fCf8G8Soj4OVCVT+T4Fu+VEt6JIzK6YAAkaNOij2TBHozOJBHeRKCLSw1fUf/uYRMZSPNoGB/wvGflr66bz7yc5sHsAFazi6QizoiIlTM/9lY9ZvHYvWIEKfy6eTYC3XIW0RLrMPG4Dyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5401.namprd11.prod.outlook.com (2603:10b6:408:11a::20)
 by SN7PR11MB7568.namprd11.prod.outlook.com (2603:10b6:806:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 13:04:17 +0000
Received: from BN9PR11MB5401.namprd11.prod.outlook.com
 ([fe80::a73a:c35f:95b5:1614]) by BN9PR11MB5401.namprd11.prod.outlook.com
 ([fe80::a73a:c35f:95b5:1614%4]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 13:04:17 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>
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
Thread-Index: AQHc8TXy37RQpn6zaEaBmwzfbXb7M7Y0w/LQgAAWBwCAABGk0IABDEQAgABT0HCAABLVgIABXZxg
Date: Wed, 10 Jun 2026 13:04:17 +0000
Message-ID: <BN9PR11MB5401F6BA29CBA6F0C78FDB119B1A2@BN9PR11MB5401.namprd11.prod.outlook.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <b5853501-969a-4ac3-8aff-83c9da9c9834@redhat.com>
 <CH0PR11MB53941698BDF5C3B8298CC0679B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <aifTFMZtWBgLzhCS@FV6GYCPJ69>
 <CH0PR11MB5394DA86D0D2CA45FD3DBEA79B1D2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <99cebea4-156a-4379-922e-07c50f766fbe@redhat.com>
In-Reply-To: <99cebea4-156a-4379-922e-07c50f766fbe@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5401:EE_|SN7PR11MB7568:EE_
x-ms-office365-filtering-correlation-id: 329262d0-82f9-4947-5b75-08dec6f0c763
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|38070700021|4143699003|3023799007|56012099006|11063799006|18092099006|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: JQ6ub2JZeElmKS1s24+HZZCX1XR9e6aQ49tS1xquh4tPFKuN/ZKsCJXsBDZAYSEHUEJzIHhZh759eQccvspLd1bDmbphXwdO4+iZsdzQTHA/qgvP2YONFpI9zJweFzTpqel8Fbz3Ly41y5RGITQW44HYYRr+KdU6k9N5FP8+LTAbVOqGxpSpe34N5JZh1JEEDF4vtwQmXTaCdLXQ4xeDt2433ylw+VuMP8yE91jX3NpB39Y944g+VO63v/vVSqyQ1VlEusetKc1B0ws2jSs9eYAWmLVNTLyMJrk09b5JybvEO+PHzVAIzL6qhnXjNeqvMzHemkqs+McuojDd2RfTPH6xbYHuxAyDYvPxxkYj0WagfTapaNYgfXOP+eLg1wG96L+k2eIDGTZruiVAPCObTrtfkZ6h6duzsyTXZRF47Tbh691CLmOmskg7v5MwjZcR0yoBNO480t/Y1lpRDeoskIReNVtBNm6NVzl4i+fa6AtepcAep3QCMrU/3nZpUyQtwShUpuhZFiBRcWouQYjbjGfXFNcTSagwJjxG4jbDTPkdxwiz8Qcf4X3IQuIqomVvUnl0jhCRoR723q0dykv8YWQ8jeEj61vfwEdsVBnUugyUlPyyyBhXKPQYgkBqybKSuY+r4SDEqvwg86tvvos9LVJMFJXHZQRtW7ggO8MtG1Q6wx7rat/RApa24rxTToG3wQ0uNTPP1zN4jjbwUkPnYVuhIdv/Z5/EZGlIYM0iNoTLorfwtUmk/YTiaM9sLE1X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5401.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(38070700021)(4143699003)(3023799007)(56012099006)(11063799006)(18092099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVJYcnZOV0MxNGs2TU5OektUTFpCY2VyclZFemQwWTJYVFYyaGpOaTR2eXI3?=
 =?utf-8?B?Z0VQY3VTUjJWQ254QXV5VllXd1ptNU5RWU5tdHJhKytCd2NOb0ZYV094aTRH?=
 =?utf-8?B?a1pjRnRsb2FiY2RJRDYvc1BNTkRrWDd0aHpQZ2loVU5vaU01S0FNeGFOc3JW?=
 =?utf-8?B?cDdpZUx2Kyt4Z2dUSGpmaHRFcU5FMVowTHNzZFVEdTdqTjV0NkVCa2kyNFgw?=
 =?utf-8?B?eldOMUlleUdDT1g0TVR5QzFQMXZ3K1BwVG82ZTdKd0hXaDNwbTdPdGw5ckxN?=
 =?utf-8?B?MDhXeVUraUZ4akFsYTA0SkpGTmMydGt3ZFZRUFVWVEJPeFY4OUNVaGo3VTNq?=
 =?utf-8?B?MWR2dDV5Ty9wR2YzS00xVGFYT2JUK1FOMVVSUnA1Lzl0M1FLcm9qb2ZRL2Rq?=
 =?utf-8?B?aWludjdWMnF0Y0I0TzJKOHoyRVhUcmFQZkhWbUtjZW9KSDBseVVTWVdVRzFu?=
 =?utf-8?B?MFcrVXBhTURpTmE3YUhibEJQcUlrZXBBeVpDK3EzaVRzKzVkUWJqbjhKd1lO?=
 =?utf-8?B?allsaHQwc2R3MkM4eSthTzJMZGpBcVR5V3hDaUp4b29jT0orUUFNMkszL0tJ?=
 =?utf-8?B?Uk9YbWJ0dmdmYW9kck1CckdsZ25vUWR0a3J2cEprVGJZdStnRSsvRHpJbVJa?=
 =?utf-8?B?THZzWlhEcDN0RzJ3WnBjekIzZllFTGVvRFN1QlU3U0ozMXdjQVIrRnYxUGJO?=
 =?utf-8?B?TSt1UzBwNG81TVB3cmt5NmkwQjJQRzc3RFhiQTUxMnl4Njk2UlVoamlqT2Yz?=
 =?utf-8?B?eWluWkMraUFmR0tjWHBoYnNQbjRWanRFTGlrWVJPU0pYd3RVeEpFcDg1U2ND?=
 =?utf-8?B?ZFRLUW5NSk44MmxrMGcydzY5Qy8zRjBVR3Q4Tk12WndEN2krNVdZeDVXaHVo?=
 =?utf-8?B?Qnczcm0wOWN1cC9HYyt5MFdMRStMVDZLSHpqOVljem1OS1Nyc1ZWL2dqdmVu?=
 =?utf-8?B?UFZkTW5jcXhjbUx6MVZLc3AralRXRWNTVlp4b3BkOUhNRXZIc3laUjJJbmNE?=
 =?utf-8?B?bGk1UUlqdGcrNzlZOUN0VFZkTStKVnlEcDNjbXJxemdiQ1M4d3h5Ynl2TjBu?=
 =?utf-8?B?OS9oTFd6eG5hTndzenFkd2NlOW05SUs5bTZxMkM3ejlhWS9Zc1JwQThiMUEw?=
 =?utf-8?B?K2xIKytKRTJFNi9UdFYwSk0rR1VsYUJLODcyNXpKL0pZZm5iL2ZKNmFHYU00?=
 =?utf-8?B?UVZKazVYTGoxdU9idEwvaHFoZkxjZ1pDNk5BSk9RTHRkckdKU2lCVXZIT28w?=
 =?utf-8?B?MlNyek9uNmpTU0IvUmN6Z0pEV0t5dE9COE0rSFczV1NlczFTZndSTndSSnlm?=
 =?utf-8?B?K3kxTmp2enJQRS9wM3RxNUQvMitNTTd6RlNMb0ljOGJsaEY2MzE2QXB1MnBk?=
 =?utf-8?B?L2xyMjhEM3JYUzJPN1FzdmF2WTVnd3FyZWJIYzEvWjhweU5lTUxHSGhKck5q?=
 =?utf-8?B?Q0xPVjVnRWN3bmZPUmN1RDUvR2pVeTJFL2d5Tnd2OHNBRzM5WitWZ2R1cnho?=
 =?utf-8?B?U2x6YkZIUDdadE5FMm5wVVY1RlhENVY1R2V6b0ZjZkdPUjRHNzFBdzBLZ2xJ?=
 =?utf-8?B?eWNoQ1U3RmI3cGpKektKWnlNc2dPTGxhazFNQ1RUZm5XR0dhUFU4YmNrc1JP?=
 =?utf-8?B?WVdZQUw1dlJWeER5VGNGMSt2aXhNZ2xUNTVQeTE0bXRlRVdsakVpRWNDVkVq?=
 =?utf-8?B?Q2pXeStKQUhNN1VLZ0RhM1RNQ2poa3AzTVpmbWlkakYvNWQ1VWxOZm9XT29X?=
 =?utf-8?B?WnlrRWR6WGRsYkpySkNOVVFIdk4yVmFVWTNUbE51UFp3OFRBWXZaMEdOa1FT?=
 =?utf-8?B?Umo0QzUyemdSWVRKdGtpcHAwQWVJWnlOMk5QM0NxQU16SDhXcy9UaDEyd0pk?=
 =?utf-8?B?c1dCUDdRYkFFbVZJZkdYSjNzRFFKcWJtdnc5MTJFb1hhLy9HUkZ4NHdjeGUv?=
 =?utf-8?B?R1hkbFY4RStvVkFZMUZSNnVNUHlHSCsrdzAxM3ZhNko4ajdLZG5jT0F6REdl?=
 =?utf-8?B?MmI5eEhxcnVnSWVadGJqT1Y0MkhVbkVCU0RoQ0V1Q0dvM3dvT1J1NWM3MFQx?=
 =?utf-8?B?WG5KRG1yWUVORkNIbGtsbUpvZHZENUFnZW4xYmFYV09SeDRBUXN0SG5pV0xS?=
 =?utf-8?B?WUJNQXdzLytvNFIrTEZTZm10N0RXRHFpZXFYN3ZaN0ZZMUFEV1Q2OEQ4WElr?=
 =?utf-8?B?UHk4bUE4WGYxNENNY0lUcnFFNHluRWp0UmcybXUzN2FyRHR4WTg4dzJqR0pt?=
 =?utf-8?B?N05mcDlrbGl1eHNianMraUp5SkhxOG5ieGpzS3RUVzlmMitSc2JSOEhzWXJ0?=
 =?utf-8?B?emZ1WVhrUjQ2bEE2S1ZsaFZTNEVEeldlaDVpQ3FNblNJWUJReDZYTk5yLzF6?=
 =?utf-8?Q?2fSMYkUDxkgUd+7s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fHIDixVsOOgiJzDa4l12HVEzUQhcJllacjl/89b+jndX+VTN8FdU0taSBPqjWo7BJ+wj3yQqZ5vjlftQ7aZORxCYF4EnEB1Wa76dRkCDHTI7UxFRYDavmSZ5cPtZc8bccOxgf96dsqfYu2MBXb6Blp0yy++qM8UijdD32FDHRU7l/LariN3ljZc8HvxQTRCd8hd0baJrntwNIWTBzBV0sk4mMRpieQiQISY1X1lvxO7c43LCtVThnFs/6auLAIocxta2LauSjRH4afLLSYT8Z2IWg+iVVWYOVtxaKgp/lAg+e3MHoA5ksjGfSUpcsnVTIRYLu8GIghUZIdTDUQLtMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5401.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329262d0-82f9-4947-5b75-08dec6f0c763
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 13:04:17.2470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EfktoDF1pyIt0lhp8WEY/YWCr5bwoo/5ZtMRF0HM7dsCKewiCzxuTCb4b61mhX44vDqAAjAlHuabNGKSnl5qD0RUTz0mtDhHV9m044F71W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7568
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297675-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:from_mime,resnulli.us:email];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 328A3669996

PkZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+DQo+U2VudDogVHVlc2RheSwg
SnVuZSA5LCAyMDI2IDQ6NTkgUE0NCj4NCj5PbiA2LzkvMjYgNDowMCBQTSwgS3ViYWxld3NraSwg
QXJrYWRpdXN6IHdyb3RlOg0KPj4+IEZyb206IEppcmkgUGlya28gPGppcmlAcmVzbnVsbGkudXM+
DQo+Pj4gU2VudDogVHVlc2RheSwgSnVuZSA5LCAyMDI2IDEwOjUxIEFNDQo+Pj4NCj4+PiBNb24s
IEp1biAwOCwgMjAyNiBhdCAwNzowMzo0NlBNICswMjAwLCBhcmthZGl1c3oua3ViYWxld3NraUBp
bnRlbC5jb20NCj4+PiB3cm90ZToNCj4+Pj4+IEZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJl
ZGhhdC5jb20+DQo+Pj4+PiBTZW50OiBNb25kYXksIEp1bmUgOCwgMjAyNiA1OjQ4IFBNDQo+Pj4+
Pg0KPj4+Pj4gT24gNi84LzI2IDQ6NDMgUE0sIEt1YmFsZXdza2ksIEFya2FkaXVzeiB3cm90ZToN
Cj4+Pj4+Pj4gRnJvbTogSXZhbiBWZWNlcmEgPGl2ZWNlcmFAcmVkaGF0LmNvbT4NCj4+Pj4+Pj4g
U2VudDogU3VuZGF5LCBNYXkgMzEsIDIwMjYgOTo0NCBQTSAuLi4NCj4+Pj4+Pj4gICAgICAgICAt
DQo+Pj4+Pj4+ICAgICAgICAgICBuYW1lOiBnbnNzDQo+Pj4+Pj4+ICAgICAgICAgICBkb2M6IEdO
U1MgcmVjb3ZlcmVkIGNsb2NrDQo+Pj4+Pj4+ICsgICAgICAtDQo+Pj4+Pj4+ICsgICAgICAgIG5h
bWU6IGludC1uY28NCj4+Pj4+Pj4gKyAgICAgICAgZG9jOiB8DQo+Pj4+Pj4+ICsgICAgICAgICAg
RGV2aWNlIGludGVybmFsIG51bWVyaWNhbGx5IGNvbnRyb2xsZWQgb3NjaWxsYXRvci4NCj4+Pj4+
Pj4gKyAgICAgICAgICBXaGVuIGNvbm5lY3RlZCBhcyBhIERQTEwgaW5wdXQsIHRoZSBEUExMIGVu
dGVycyBOQ08gbW9kZQ0KPj4+Pj4+PiArICAgICAgICAgIHdoZXJlIHRoZSBvdXRwdXQgZnJlcXVl
bmN5IGlzIGFkanVzdGVkIGJ5IHRoZSBob3N0IHZpYQ0KPj4+Pj4+PiArICAgICAgICAgIHRoZSBQ
VFAgY2xvY2sgaW50ZXJmYWNlLg0KPj4+Pj4+DQo+Pj4+Pj4gSGkgSXZhbiENCj4+Pj4+Pg0KPj4+
Pj4+IEhvdyB3b3VsZCB5b3UgY29udHJvbCB0aGlzIGluIGNhc2Ugb2YgYXV0b21hdGljIG1vZGUg
ZHBsbD8NCj4+Pj4+PiBBdXRvbWF0aWMgbW9kZSBEUExMIHNoYWxsIGJlIGNvbnRyb2xsZWQgb24g
SFcgbGV2ZWwsIHN1Y2ggcGluDQo+Pj4+Pj4gYnJha2VzIHRoYXQgcnVsZSBhbmQgcmVxdWlyZXMg
c29tZSBkcml2ZXIgbWFnaWMgdG8gc2hvdyBpdCBpcw0KPj4+Pj4+IGhpZ2hlciBwcmlvcml0eSB0
aGVuIHRoZSByZXN0IG9mIHRoZSBwaW5zPw0KPj4+Pj4NCj4+Pj4+IFRoZSBOQ08gcGluIGNhbiBi
ZSBjb25uZWN0ZWQgb25seSBpbiBtYW51YWwgbW9kZS4gSW4gb3RoZXIgd29yZHMgYQ0KPj4+Pj4g
RFBMTCBpbiBhdXRvbWF0aWMgbW9kZSBjYW5ub3Qgc2VsZWN0IE5DTyBwaW4gKHN3aXRjaCB0byBO
Q08gbW9kZSkgYnkNCj4+Pj4+IGl0cyBvd24uDQo+Pj4+Pg0KPj4+Pg0KPj4+PiBCZWluZyBwaWNr
eSBvbiBEUExMX01PREUgZm9yIGVuYWJsaW5nIGZlYXR1cmUgaXMgbm90IHNvbWV0aGluZyB3ZQ0K
Pj4+PiBjYW4gYWxsb3cgaWYgaXQgaXMgbm90IHJlbGF0ZWQgdG8gSFcgbGltaXRhdGlvbiwgaXMg
aXQ/DQo+Pj4+IENvdWxkIHlvdSBwbGVhc2UgZWxhYm9yYXRlIHdoeSBpdCBpcyBub3QgcG9zc2li
bGUgZm9yIEFVVE9NQVRJQyBtb2RlPw0KPj4+DQo+Pj4gSW4gYXV0b21hdGljIG1vZGUsIHRoZSBw
aW4gc2VsZWN0aW9uIGxvZ2ljIGlzIGRlZmluZWQgdXBvbiBwcmlvLiBJDQo+Pj4gY2FuIGltYWdp
bmUgdGhhdCBpZiBOQ08gcGluIGhhcyB0aGUgaGlnaGVzdCBwcmlvIG9mIHRoZSBhdmFpbGFibGUN
Cj4+PiBvbmVzLCBpdCBnZXRzIHBpY2tlZC4gSSB3b3VsZCBiZSBhbGlnbmVkIDEwMCUgd2l0aCBh
dXRvbWF0aWMgbW9kZQ0KPj4+IGJlaGF2aW91ci4NCj4+PiBJcyB0aGVyZSBhIHJlYWwgdXNlY2Fz
ZSBmb3IgaXQ/DQo+Pj4NCj4+PiBbLi5dDQo+Pg0KPj4gVGhpcyBpcyBub3QgdHJ1ZS4gQVVUT01B
VElDIG1vZGUgaXMgSFcgc29sdXRpb24sIFNXIGRyaXZlciBPTkxZDQo+PiBjb25maWd1cmVzIHBy
aW9yaXRpZXMgb24gdGhlIGlucHV0cywgbm90IG1hbmFnZXMgdGhlIGFjdGl2ZSBpbnB1dHMuDQo+
PiBUaGlzIGJyYWtlcyB0aGF0IGJlaGF2aW9yLCB0aGUgU1cgZHJpdmVyIHdvdWxkIGhhdmUgdG8g
bWFudWFsbHkNCj4+IG92ZXJyaWRlIHRoZSBBVVRNQVRJQyBtb2RlIHRvIGJlIGZlZCBmcm9tIHN1
Y2ggTkNPIHBpbiBhcyBpdCBkb2Vzbid0DQo+PiBleGlzdHMgb24gaXQncyBwcmlvcml0eSBsaXN0
LCBIVyBjYW5ub3QgcGljayBvciB1c2UgaXQuDQo+DQo+Q29ycmVjdCwgQVVUTyBtb2RlIGlzIGhh
cmR3YXJlIGZlYXR1cmUgYW5kIGl0IHNob3VsZCBub3QgYmUgZW11bGF0ZWQgYnkgYQ0KPmRyaXZl
ci4gSWYgdGhlIGhhcmR3YXJlIGRvZXMgbm90IHN1cHBvcnQgaXQgdGhlbiB0aGUgc3dpdGNoaW5n
IGJldHdlZW4NCj5pbnB1dCByZWZlcmVuY2VzIHNob3VsZCBiZSBkb25lIGJ5IHVzZXJzcGFjZSAo
YnkgbW9uaXRvcmluZyBmZm8sDQo+cGhhc2Vfb2Zmc2V0LCBvcGVyc3RhdGUpLg0KPg0KDQpZZXMs
IGV4YWN0bHksIHNvIGZvciBBVVRPTUFUSUMgbW9kZSBIVyBpdCB3aWxsIG5vdCBiZSBwb3NzaWJs
ZSB0byBjcmVhdGUNCnN1Y2ggcGluLCB3aGljaCBtZWFucyB0aGF0IE5DTyBwaW4gd291bGQgc2Vy
dmUgb25seSBhIE1BTlVBTCBtb2RlDQppbXBsZW1lbnRhdGlvbi4NCkJhc2ljYWxseSB0aGlzIGlz
IHNvbWV0aGluZyB3ZSBzaGFsbCBub3QgYWxsb3cgdG8gaGFwcGVuLiBEUExMIEFQSQ0Kc2hvdWxk
IGJlIGRlc2lnbmVkIHRvIGNvdmVyIHRoZSBjYXNlIHdoZXJlIEFVVE8gbW9kZSBpcyBhYmxlIHRv
IGltcGxlbWVudA0KYWxsIGZlYXR1cmVzIGNvbnNpc3RlbnRseS4NCg0KPj4gVGhlIHJlYWwgdXNl
IGNhc2UgaXMgdGhhdCBhbnkgRFBMTCBjYW4gc3dpdGNoIHRoZSBtb2RlIHRvIHRoaXMgb25lDQo+
PiBpbnN0ZWFkIG9mIGltcGxlbWVudGluZyBNQU5VQUwgbW9kZSBqdXN0IHRvIHVzZSB0aGUgZmVh
dHVyZSB3aXRoIGENCj4+ICd2aXJ0dWFsJyBwaW4uDQo+DQo+SSBkb24ndCBleHBlY3QgdGhpcy4u
LiBidXQgaXQgaXMgdXAgdG8gYSBkcml2ZXIuIEkgZG9uJ3QgcGxhbiBzdWNoDQo+ZnVuY3Rpb25h
bGl0eSBpbiB6bDMwNzN4IGFzIHRoZSBOQ08gcGluIGRvZXMgbm90IGV4cG9zZSBwcmlvX2dldCgp
IGFuZA0KPnByaW9fc2V0KCkgY2FsbGJhY2tzIC0gc28gaXQgaXMgY2xlYXIgdGhhdCB0aGlzIHBp
biBjYW5ub3QgYmUgcGFydCBvZiB0aGUNCj5hdXRvbWF0aWMgc2VsZWN0aW9uLg0KPg0KPkl2YW4N
Cg0KVGhlcmUgaXMgYSBkaWZmZXJlbmNlIGJldHdlZW4gcGFydGljdWxhciBIVyBhbmQgQVBJIGNh
cGFiaWxpdGllcywgd2l0aCB0aGUNCnByb3Bvc2VkIEFQSSB3ZSB3b3VsZCBkaXNhbGxvdyB0aGUg
cG9zc2liaWxpdHkgb2Ygc3VjaCBpbXBsZW1lbnRhdGlvbiBmb3INCmV4aXN0aW5nIEhXIHZhcmlh
bnRzLg0KDQpEUExMIE5DTyBNT0RFIHdvdWxkIGFsbG93IHRoYXQgYnV0IGFzIHBvaW50ZWQgaGVy
ZSBieSBJdmFuIGFuZCBieSBKaXJpIGluDQp0aGUgb3RoZXIgZW1haWwgaXQgd291bGQgYWxzbyBy
ZXF1aXJlIHRoZSBleHRyYSBpbXBsZW1lbnRhdGlvbiBmb3Igc29tZQ0KY29uZmlndXJhdGlvbiAt
IGRldmljZSBsZXZlbCBwaGFzZS9mZm8gaGFuZGxpbmcuDQoNClRvIHN1bW1hcml6ZSBpdCBhbGws
IEkgZG9uJ3QgaGF2ZSBzdWNoIHNpbXBsZSBzb2x1dGlvbiBmb3IgaXQuDQoNCkZpcnN0IHRoaW5n
IHRoYXQgY29tZXMgdG8gbXkgbWluZCBpcyB0byBjb21iaW5lIGJvdGggYXBwcm9hY2hlcy4NCk1h
a2UgaXQgcG9zc2libGUgZm9yIEFVVE1BVElDIG1vZGUgdG8gYWxzbyBzZXQgIkNPTk5FQ1RFRCIg
c3RhdGUNCm9uIGNlcnRhaW4ga2luZCBvZiAiT1ZFUlJJREUiIHBpbnMsIHdoZXJlIGl0IGNvdWxk
IGJlIGRldGVybWluZWQgYnkNCnRoZSB0eXBlIG9mIFBJTiBhbmQgZW1iZWQgdGhhdCBsb2dpYyBp
bnRvIHRoZSBEUExMIHN1YnN5c3RlbS4NCg0KQmFzaWNhbGx5LCBpZiBkcml2ZXIgcmVnaXN0ZXJz
IHN1Y2ggTkNPIHBpbiBpdCB3b3VsZCBiZSBhbHdheXMgc2VsZWN0ZWQNCm1hbnVhbGx5LCBhbmQg
aW4gc3VjaCBjYXNlIGFsbCB0aGUgb3RoZXIgcGlucyBhcmUgZ29pbmcgdG8gZGlzY29ubmVjdGVk
DQpzdGF0ZSB3aGlsZSBEUExMIG1vZGUgaXMgYWxzbyBhICJPVkVSUklERSIgb3Igc29tZXRoaW5n
IGxpa2UgaXQuDQoNClBlcmhhcHMgdGhlIHBpbiB0eXBlIGNvdWxkIGluY2x1ZGUgT1ZFUlJJREUg
aW4gaXQncyBuYW1lIHRvIG1ha2UgaXQgbGVzcw0KY29uZnVzaW5nIGFuZCBuZWVkcyBzb21lIGV4
dHJhIGRvY3VtZW50YXRpb24uDQoNClRob3VnaHRzPw0K

