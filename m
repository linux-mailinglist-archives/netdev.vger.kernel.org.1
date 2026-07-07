Return-Path: <netdev+bounces-305465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jhO1MaUBTWqHtQEAu9opvQ
	(envelope-from <netdev+bounces-305465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:39:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6157471C05A
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:39:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="AefBOu/Y";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305465-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305465-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D21B31225B5
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D738341F7E6;
	Tue,  7 Jul 2026 13:32:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4DC41F7C7;
	Tue,  7 Jul 2026 13:32:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431124; cv=fail; b=Lzz6ulsWzHI7l+1vv3yqkbtO1C9j/ppPbVrZolGr2rfQoFP+dMOjRVCRUnrwv4oZaUQ0+IpdT0lkJ5bYt4tQKGAm15MpzeAmA6JDTnadioXR+BopEsh+s6QGID8/s2kkrgvB5ntgwavhNPfQaJWQmsit596h28+vBMXWoah9wn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431124; c=relaxed/simple;
	bh=ELctHapxcciIo6Cnqoc3eloP7NRyurstPpEkizf13CQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cFie1WLBN1tN4zkfMZfhNHEcZy81DlNcRqYQql1BIm6yzkYJDLrp0h9WLZjHlP+ELwuTGDTLWb5Nf3pkCt+rKAwyDaJ2Yj981TRTi/v8eJfAosegb7dVAuiUf/JdfrdpueGyGjHe/090h9aY5IFiWv3uBR6jRxOrkzJfULiAkxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AefBOu/Y; arc=fail smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783431123; x=1814967123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ELctHapxcciIo6Cnqoc3eloP7NRyurstPpEkizf13CQ=;
  b=AefBOu/YIo/kqfejjLpA3hNv6PhAggLFVlnxSEPDngwAaqmRh8axaAN8
   oHvxr3yZa3EG1qZ3WSGtZflaAuXM24Ocd5km9yui1kRfYuirtt0KzM/5g
   c7cyNxNLCzgaq+L1VdCOa2vSSvW6TPTF1xlTErkxuLkDmWX0VEqDF4gVS
   V+P0MsuEe81E2ujUQCTStLRRcTwDbhHsFl8nOrdXWmmaf4Aj9Cv4m6Ru8
   AqrSEHu3qqHR54zbgTIIFxMXVmXq4hkJgZXLUttsTFJW0sTtce4ealasE
   BH1rKK8Yswp+7I9vXbAncBdlU7Yxkgdunw6/Z0fl9lQDrx7X6gKHUTLdy
   Q==;
X-CSE-ConnectionGUID: eu+ks88fSaqf5aShILWK7A==
X-CSE-MsgGUID: CtNSXtjQSUy2HfjShCNksg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84052147"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84052147"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:32:02 -0700
X-CSE-ConnectionGUID: oRB8QzYmQIScKBDzGQlh4g==
X-CSE-MsgGUID: mfidBy+lRPiUDmX+fgAN0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250009395"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:32:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 06:32:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 06:32:01 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 06:32:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYzEbBZBC2N8MkZ1ILoO5NOlY3nUUNq5c6E5rDR8+cjw4UGp2GC/4SHRqPwn4QF24nmNIX6Lda2zKmHmxdH3d0GJ0PjzQpaxyoBBQhhsiPwZdqvoCr1iajGSsNmGQU2y+mnTR7v4fFwqvBbTlJL3rFb3KR6r8hlQgU7jCxcp5lHunn4BSHWq1Q8AegIggrYRaQoES7RMeOzyPa2acZ2njzEQTjnc9SxZrvidV+wRVTeKm15ZP3v/5GHOo7be7e0MpCRKhtZf2168c7sOhXgNqWYSrSNSAx7XSyJnNodDAjgh1OSScLzFc5/K29POlsgxTkfxlOZtZT4tFXO/yPYttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nzn13J75R2oiWVrfxGf/Zx8/5nqXnHq4r1PXVClgxfk=;
 b=V1kbkVAz3VN+chHo/aoms2ge73X1fxc82TDR6asRgb3MMMgNNtTDypMQAH74ecbBqrTG2agKwXayYuyFaED78TnqI93usgN+zcZ4ogghDOe89ltINxdH8xhtoLtc/KOZP/IQUCRkfWmEQwuleNnjh73HBm2sybZFR5ftNYpVb7cz3vT071BjLgnfHp0fHUYMvowanrgT6eCc73lwyOswOYShfC673l6taPQ4TgrDNn2LlBxz62ctmHt4+VPgPjwwKQGhKzrwH6f0z3EniNJ9jJWSpZc1AW5HK2tHIPljVmyJ24xXmIXo/Su2S4FG77TViUTwnCXL49soJHVW7n/D5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 13:31:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 13:31:58 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Yuho Choi <dbgh9129@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] idpf: Fix mailbox IRQ name leak
 on request failure
Thread-Topic: [Intel-wired-lan] [PATCH net v2] idpf: Fix mailbox IRQ name leak
 on request failure
Thread-Index: AQHdDVt0uZQWtL3wi0qPhZxlxds7E7ZiDybw
Date: Tue, 7 Jul 2026 13:31:58 +0000
Message-ID: <IA3PR11MB89863719790B9C2A4AE48A34E5F02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260703050332.121551-1-dbgh9129@gmail.com>
In-Reply-To: <20260703050332.121551-1-dbgh9129@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM6PR11MB4754:EE_
x-ms-office365-filtering-correlation-id: f189d597-af48-4a9c-f8fd-08dedc2c1e95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|921020|38070700021|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: zn9EciijKyqiwmZou/QcnMZXJ8DZSYhzDb/6F7WSThulJEIWQ2DgTrefBwBNTpihWrNozg+ReavfSZ6bbBdIn7AA2+uKju0ldKVvvrYWF9NdsjwhI3+kTib4+9BKZ0fa+5r1NHDbTx80LFrLjLc5mu8k4Bgg/wud11x5z5EJlkA5tNar0rUzpjuTPY9DlgIk3QeEtMZ+wKG+kJoK9FZFsleiAeDjVzlM9ALvR+wwZeQZOYkWoPIP7DBEhdKPcELVNa3Q/fgMUD0VWNPyKHLmHqtkSfydC8yk9bM7SCUxRHAOrTL9KQ9f+tdVO506+sqtc/WleLNoKo1omFKdjyCq1pIMCZ0e+tJmJFra7x5n7VW590nOHWL9Kkq1/WJIOZ3xwezh0qMuXtCHfkk06iK7suuXtMjDpM4YVM7B7RJ/F7p98V/A0YBo0m+1HkRRw7+qUD7X8bZNW/EXYQLTWormDoyB+/M0m7MVbHJvRqiduLilzdo53L8sr49LkfTlq49IRSvjBN5zcsPG6Wmg7d2Iak/myB+JtUip5jHwPM91zkYHNj7uDcJ8CioQsrFxtsbD05c9fSLMJzTnZsugZbvkaERLTQl8XU5e4z7loqXpIKZ9eWNEyQY7kRZogrlsxfHKT5LLzcE2Ys7KWNrXVi3B/vyVsdEp+A5OcbnLjYBudPZc1GdQ4Ew86y9I4c5F+s8lOYAwBLod2LL86s/GqMDsGlkQ1Hw1sEuQlXnbaG76Jiq8jpxoltGewe2fb8s0z3r5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(921020)(38070700021)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/zVg9lk4WbW8tAywsUoK0Dz49wXkragS7C90nMed8EPIyxCCULgm8g6t7x1c?=
 =?us-ascii?Q?mc5bIQESsVamdZnQB0mZJvOpg5cNgGyITDbJgqAMy9asZX4L65SES8QJBoS/?=
 =?us-ascii?Q?/oEnPreNbJhBZaeCzF5YETw7xtyG1JCyVgYVyHLsXSjrMpReiKxjDrZSy5JS?=
 =?us-ascii?Q?EkLleyTw6OG59j1ei5Zk5vVH3IEDjzb2KYZ5FUvMRFreB97Fw0VXi+eNlDGl?=
 =?us-ascii?Q?mmyfenJhiDwe79eIWhMZHiG1h3PwqtOFIDaOqihG+QmHUvVJmPxnGYxSuIiw?=
 =?us-ascii?Q?r1Mz+kSnKfJGmHKXadrHral2I4zCvGaJDz1hkYNT8d5Qir/HRLmFzSJ2fYez?=
 =?us-ascii?Q?g7mtcL7nG+ArLj/GX9eNDC3duk+pTlz2Dj87KINq1eABj6yj7fgz6VbUru+B?=
 =?us-ascii?Q?Um9x1mPjH4+iVD4BvRUf9iSQ3pmv9MhvlpntoXWdD+yIHljHoxgIiLm4eTRH?=
 =?us-ascii?Q?39+91EZ0sBxqyTDz9pGFbsiEtBntmSl7jeeirPivMu7El5fhlnOtCDP/PhkG?=
 =?us-ascii?Q?IjpJKD1UH7b4fv7aFoYOBPc6m604SaBH7z7fZKRFbGwuuX9G11nUHmxevrt4?=
 =?us-ascii?Q?2qf/Z/Hr9LKOZS3K4uqs6HLd7ZQfDgzJ/f1MQe4ZI9zpodcIR9UhCaCi4HrB?=
 =?us-ascii?Q?0cSvrcfD+xvtt/ux4Auv4RgoRg1IpB5A8VucbN0/C9mgOr6CEIkQPSM0uHew?=
 =?us-ascii?Q?Dzmnoq2lkCiyigii6aHvdkktbhVIpnrOeNq8e5DOW2iMlY5SyqRcFck777ge?=
 =?us-ascii?Q?eVwRrVZKlSyGYKqS4CQLE5drd7t7F0VBn8fFRMBQ3yWF6wM/3w76Gd0D/r3g?=
 =?us-ascii?Q?uDTHvuRHaAvbXIeBPqmmsQ/OUZ+G+hLRHvwftE1QGHq3sCY/whFglsVBo3P5?=
 =?us-ascii?Q?6odiovbjvZCLCS6E6HH4rLUOo2K3a/Aq4BbOxlxnBXc8Fxswhgv/h+l4dhdz?=
 =?us-ascii?Q?VyRqZjsMz4g/smeT1KVAupZKovhP9hZO2niC6qYL4dZ3bn+jUKy9W+kHyUvc?=
 =?us-ascii?Q?tJyhiHXgqzAUKlCz2fu2VEhX6JEdWShzH+5CpxiP0Lnt2dNhQJpqVBy434B5?=
 =?us-ascii?Q?JXuq6/xisa27Dukxwx+tPuOd/U/HMqydyK1Tyjwfli6LCjXIYBO1iSM6EuE4?=
 =?us-ascii?Q?St/PIjEfNLp+3HIwr/JdZUbWK6RMPJ/CygGpHGYrvu2yis7dHrOiyRaUb8Ed?=
 =?us-ascii?Q?10P7D2FEXkbx+ZpcuKusVXe1cPZ96aKKp6GzwImI2sIWePjnOlLDdo3LLaTf?=
 =?us-ascii?Q?ZB6HPFjpVcuy53QZ+EDXyBEAf/hmzOJTYP1F6nQb78G9vRFNUufnEmdY3wdE?=
 =?us-ascii?Q?16DrmFI30bkcvkXMH9ocMfIUjaSoh+xyS/pL/iWN3Rs7OgRFbQtNY47clhu1?=
 =?us-ascii?Q?qZSIS+y9Gz0vIG2kSsC9419dlug++27X3qyNy11/s/sgDQDAsCBHw6YkbohY?=
 =?us-ascii?Q?sZt2Xy5ACEWgwjHX4wLx6cy17buAquaib5vD67+1QUdNzMT2iDTpCLAhxpxA?=
 =?us-ascii?Q?9ZLJhiJEq8vkTjm2+iDxb8XKsuO84wV12HykC5+/ld8xj7GT6LSK/JjtALt2?=
 =?us-ascii?Q?j/kK1yuNMit0gIlZXKSqq9vhtrU6gXv19nWSAwvTqbekXAjyto3xg1+dq0HH?=
 =?us-ascii?Q?8FlKyZ7yog6bEmWuDpZkQYTlfc1hA6RKCdCWigKU5/t0FdpMp+0sVG9kNs6n?=
 =?us-ascii?Q?q4igRO1h2agH9VNVLk0WEUtHmXuMgrb/qV0qaNcyfx/5FrewIlt0lKVoGiAt?=
 =?us-ascii?Q?msBe0WsuFO67LZVOosOgvDfvn3ehdmE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jClxts0gWmU5XPQuwjbvr+RUgBai84RIdoEyFlZl+WYE0vV2amkUyyzgd/E8I/3ot+/CZn7z5LTFFgbTgZKEijv4Pg7fz8dSHDjbNkzqLuDMIw7ggW1mqSAyMI9FY0p7UN4L5m/zc5T35HDJfc1/uElkacZ6MznTYkdLKopYA423APNOhFZ1UHE4uZZUggu7iur6xvy+bwwX93ChA0mrtdEY/byG/Gg4SE1V8lwNkng8E0l5LdgZPmbUGD435BTb0kuW4scRdVPBFkOLaO1cG7Wb8I7sMkPX4KtFYX7u1eIXfF/POjyH0mvGw2km3Z+Ef6QieXsInqpURFjr6aUByw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f189d597-af48-4a9c-f8fd-08dedc2c1e95
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 13:31:58.2906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNJJ/kFLutt48Uc18MM8y18fG03oo1XExa9sUfabo1zvnyLskAcxNpdDgnCv/Ih/mSHqfPPJlZHQ4vRd0x4mbP1VjZds/jJgWBFroCn3neU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305465-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dbgh9129@gmail.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6157471C05A



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Yuho Choi
> Sent: Friday, July 3, 2026 7:04 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Yuho Choi <dbgh9129@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net v2] idpf: Fix mailbox IRQ name
> leak on request failure
>=20
> idpf_mb_intr_req_irq() allocates the mailbox IRQ name before calling
> request_irq(). On success, the name is released later through
> kfree(free_irq()), but request_irq() failure returns without freeing
> it.
>=20
> Free the allocated name on the request_irq() failure path.
>=20
> Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
> Changes in v2:
> - Add net tag for the patch subject line.
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index cf966fe6c759..bb81e620c5c8 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -139,7 +139,7 @@ static int idpf_mb_intr_req_irq(struct
> idpf_adapter *adapter)
>  	if (err) {
>  		dev_err(&adapter->pdev->dev,
>  			"IRQ request for mailbox failed, error: %d\n",
> err);
> -
> +		kfree(name);
>  		return err;
>  	}
>=20
> --
> 2.43.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

