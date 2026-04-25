Return-Path: <netdev+bounces-281091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WzRYMvAP7GlHUAAAu9opvQ
	(envelope-from <netdev+bounces-281091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:50:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46323464532
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD296300FFB6
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103611BD9C9;
	Sat, 25 Apr 2026 00:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwzsUK2q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1719C542;
	Sat, 25 Apr 2026 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777078252; cv=fail; b=JwTaWUQa7CnCLWX1z7cUii6H3FmwzuZgtE/1VSozEImj8piEpmH0oFdWS61UOfM7Wq8Q4TvXkj23WL2hkHy8wQs/OzBv98LXrkG2FEZcm9Ho+GrrfrEfBdi32Mz152lP4461xSsz2hhdHfAJIq/ZdWbP8xyZMMTO1MnbBRqTtIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777078252; c=relaxed/simple;
	bh=HoxjthCSNaQxXXw7s2crejAfAdXmdTwRsiQNbp3wWnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h++swfaBgYwrfDZ1Zud+y8yeUu8Vhf0MY4thws/jWZgJK/BowMMYs33UZrdj6oI7jEXHLN+Cqtsjgda98jyLqYEgM7MQ59J2U30gP0Qg5/IGs0ez1Ot0rOEiQKRBIF+fKI+a+fFAOAoxZI5NO1428MmM7pMkw+G3gX156mMfrXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwzsUK2q; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777078251; x=1808614251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HoxjthCSNaQxXXw7s2crejAfAdXmdTwRsiQNbp3wWnU=;
  b=JwzsUK2qEVnPQQvH7iwNMFjIcWH7PVV9g0P9januqxpg/3aaj5jbBc35
   fJPERch7mMCAcmafJ5B8Iabkdt8jcskJ6fWlm/T6MrEbnmtLmJ4C5MuN+
   MuL2Ho8DGykdDPVj1ZKK6F8KrdrJUqy9v2ieHQFQ9s8oM/ASvEmLOK4HE
   Sea9I3awU4Fi4byZpZa90j97WW46MDGsz1K+h9eLjRrFouzwqT943iQ2c
   S65gRDIpWDycEhCr5PEtq1ENhIGRhm0nWnoPR2fznq0A3TNwqIBdYi41p
   mgrg+frnWUgIhQNojvSJMN80gdwdhJa5vCMRRnZkLfUMe/qzBlVE+m57G
   g==;
X-CSE-ConnectionGUID: lKJiUYoSRiGx0ZS2+yltTQ==
X-CSE-MsgGUID: ljz7ppOaRRqHhXImZ+Jv3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="78048327"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="78048327"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 17:50:50 -0700
X-CSE-ConnectionGUID: ccb+ZK/SSQS2RpuMTklzWw==
X-CSE-MsgGUID: CLCfITNRRx2gzUmnSa1niw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="233390242"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 17:50:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 17:50:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 17:50:49 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 17:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKQL1Rp598zbbKnT2z2S2r4xOhKFnzh4csOodkTsHmUqV7xIAiB0PSWypv3c8DpWxKtW7roGOtMGudnFiun5fU1LFycQp7SRAvNRhPJUuvt06DVQv4t+S8Bhl0KKWfqt6LxTZURehIA0fZcW3Ne+J2S2hdDNgT3ekzQdNYdX1hp53SJ3LrzV4Pb2KfAyApXpPY5S01u2RNGfy3TTSWEw020kHhzc9T7A7onAfvoGY067Ji88QHH/rVxV1CpLMfMaJIgjJoS5mjYkoWgmilTFtAtXTM4pwd66vYyw3VeHkTeMNVgJV2wwqRdZmxaOCd097DiAButxImdVus/4jm8LZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFj+61YuLQsuRGGNJlJ6SFJlTJcwnNefKDlcwjqdYJI=;
 b=I+ZIQIK4cbrbHtLmpp/4LCV/ccXM8+m7M5tbzb0zPJV9sXsfxupUha7guCW/MiTosdlucNr0NKN4ybMskJWcN/OiiS+U7JEN79/SlKotgJvZemQEBdlgbsbrXRAXyI/5C58f+lAlbRV2iKzHtMJZQxY0ziys81gZfM0kImDvyCDNdeOXaSyWQ/A7bUrGF5t8VG8BCGrpCuGzzDSMGUsYf80LZJwWQ4bZga8gAwn4/PPKBIIulWDGv1mSji8Or0aOVIViCHUEwccUF81X/8wiz8VJvuNbRcvVFFElER8ciIKcJSkCHtP4F0xjjUFcAFjOzDYNZKtaYGBO8Yp3AU63iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by CH3PR11MB8415.namprd11.prod.outlook.com (2603:10b6:610:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Sat, 25 Apr
 2026 00:50:46 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9846.011; Sat, 25 Apr 2026
 00:50:46 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, "Rinitha, SX"
	<sx.rinitha@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Eric Dumazet <edumazet@google.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Simon Horman
	<horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v7 3/3] ice: add dpll peer
 notification for paired SMA and U.FL pins
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v7 3/3] ice: add dpll peer
 notification for paired SMA and U.FL pins
Thread-Index: AQHcznrfJN7AC1FxV0mSx29x8HamWbXu/gMA
Date: Sat, 25 Apr 2026 00:50:46 +0000
Message-ID: <LV1PR11MB879048285E469979F54FC7D690282@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260417145907.696307-1-poros@redhat.com>
 <20260417145907.696307-4-poros@redhat.com>
In-Reply-To: <20260417145907.696307-4-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|CH3PR11MB8415:EE_
x-ms-office365-filtering-correlation-id: 939a8394-baf8-4ee1-59fb-08dea264afbd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: IbmljeROQFU4mTLNmavpZkcFayVQEFlKInSsy7Tc8qt5U0BNkbnBe+/TyXmGVj7dngdZWeBjgk+OWmH4VKOq/n++79TCDlKBexSXq6NiAG0/3YSiLgKPRTAWAfPTq2boTe1NC52OkoYv2uHooPkZUoebWTBVpBt0eUjCP8lE2gr66Z9d2h6DwRk7y5WJPOgXMkzx8FYhrGWYJPHbcXXu6t0MwoR2FjKxIrKr76iMkow6BMzf6yQ32lJiBKCdSy/Wprcr5ztcZ02+7NRZ7bolidSak2vrpK6fknUHUINVX9tynFXCRXL8rdsJ/1EJCRzH009fDveZ7H4TiYu6+nZlZerowBqVX/ey7vh9jJjeRIqAAxYR14XpsRTkmmPoSjLlihgtjiXClEvBum8PIhaukWixkghhgeZl1yXelcEqP2wIlvvxIP/87aNCOiKjYgx0Gr+PG2g9BaW83lMcnPkIIiwg2tqkid2m2R8FN/qbqG6Qj83z9FBEqfxoY43xWyoMJP9lYJeFkXKYgsVn22vEjYIvcy1WhVwBjAWeb91wcqpM/Zi6Yi6TkwYfESgM/ZI6u8DERyPfepXNtFoF6Jp6v8SEMzSPRGNeNBLFd+a9B3FUbrUuG3zW2dn4NDnBTXuZPLv304U2Lhfb7E2g0wfSYcBjSJ36mUxILndmLwq/FuzkxS1X7TfwcZ2YOgmE6qKqc/3TQgQsWYhVwujT1pprviYPJMsx2w+vVCyPdbYXfb9snZO9nbmLz//RyrCuYjuxuiymJsnh7l6S3X80xuqBk9hgbyKABqZQk8KDsdvjEe8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kv+jXYJ7f6Sp8CvjwM1pdNsYpteFqwh4Fezp6nEIl4A6SXanH6rVONxQV3AY?=
 =?us-ascii?Q?S1RPRrFWmzyPm0bL2bXReDviFQzmmGJgNr4Oi7he0U2FKAkzHLFC50OnfcBx?=
 =?us-ascii?Q?NEFcMXVjWSm5WuoQC/ZdvjpGNmKniFz4ZORCnEgNkC30672egN6JkTGrfczK?=
 =?us-ascii?Q?e2CPGhughaephyM2vTR/hgkbfS3QVDbBmxZwYyaBCDipx6GcXi4zKOJcGozI?=
 =?us-ascii?Q?zLRjCM+BgFUYvewxHN+YsAuwI+N3Vth8iY2eGXqXH7y2nIOKtrZLtKAJudDb?=
 =?us-ascii?Q?EEdAvapistrFhY3DbLoYyev+C9PQ/RG6qaEeblGDe8FI7GDXqp4yEZuyYbxG?=
 =?us-ascii?Q?wOFsh1Zn4ygQjQs81gw0qoNmrwiqjhNYbbjYHr9chgpKHZRy4XwuivmR+EP8?=
 =?us-ascii?Q?m7ezTg9jnpg125UEdjAhBVuZAbljPl5nwd7w/jKFshbIAxly30M5EQmIgH2c?=
 =?us-ascii?Q?vsSJV19UTlOy2xzpmOjFFlIyYiq+Yn1P64NMi06hRW0HuG1XXZr7HpOzIUV/?=
 =?us-ascii?Q?KC8mYS4UhklzqCK6oq9iUzP2aYV82OwMJlG6dkknrnlWJysdc7Ihlzaf1iEb?=
 =?us-ascii?Q?YiDyepkzvB3MQasinuIPwNGxOfvgP6Iu5XasuD2mhURgqUIYFGdGQ5vOIVaJ?=
 =?us-ascii?Q?0AJjdXQQX6rVz7bV4JkpgBTbnposbFdaV4CPO69oNkuh7njCQjHAXD8zDlPx?=
 =?us-ascii?Q?dXsLsjmrfI7PjhHUsEzqswJV1Q37p6KeL5IX4AXeX8X7tNfe0cthRxatS1DN?=
 =?us-ascii?Q?iGAIv3JBDHz1kVtLJg5VsSyQTeobOEbsHUFp1nyG0+fZk6rLXFukSd45cRqk?=
 =?us-ascii?Q?By4vIfPzCMrFmzMwDSlKkiCQIBz9xMM2BwTPRfaWUpOK64nxlZjUh/4ihrYD?=
 =?us-ascii?Q?QiEsp+NTQ8STTcLHaCv9HCMwdM6+CxOmMrvF+3WY8HH7xow8oMpGAGVHOroV?=
 =?us-ascii?Q?zsee0bxduvfpgAZMp1/E2pmSPsC+TLZ/H3v7apjCnaUYHlPkrAPIpJL8ywv5?=
 =?us-ascii?Q?0aoNBO7B+OKLrsK0vD0ZoTcpT46mIL3bSUxoxRPHYyKVvkXorbaZH6GZCyaR?=
 =?us-ascii?Q?FcKxtQb67Hn5xsu2BDF+9w6drRHE6pvE317b0ogtbsoUlB6QErXUeZE6oJ9B?=
 =?us-ascii?Q?rV0Ug8BHTW7wdp7Ql3vIAJjN0JUdcBxh+3lBo5P260NP3VZ7cokMbL46XY87?=
 =?us-ascii?Q?bQ912xkQzFyTt241lFib77Arhzvk3kH8GkVrP4BDaQXTC5eK5Rq2dvKnvtws?=
 =?us-ascii?Q?v5C5w1rPV/zIOC/wlWziY8nkvo9yeOOzvJLF1NDZNCbKnZqf11Lgn8FmXIpy?=
 =?us-ascii?Q?CXjeM6fjQUD/F1lFvDrrlFo+SVtIjlGXgDCUoR9ApG0q3wlOCNBHexTIwiL4?=
 =?us-ascii?Q?y4F83sC5sK4FGj96vH+M2r5GtRrBHo7eK9URGb2HzdClFi561FjVyZb64L2n?=
 =?us-ascii?Q?kQW9z7KuJLpIubzDbj13Y4n7I4F+dL8qeEgBatiEDsnasgQnCUfc0Q6UYhZh?=
 =?us-ascii?Q?Hd9CcXGePuG/snPXvudwebhoqnHYqi9Vi+4WT5bLYid3S1I3o8Ab4bdv68fL?=
 =?us-ascii?Q?Lo2vHRSTcSHDxmUzA9L0unbPSrEHhIv6qMFL79kLPjffnR3CGqD0hQe/WiGp?=
 =?us-ascii?Q?Y33Tm7DysZK+ZD2pYHGHxYlCzHHf2Y/VLplUX8bjxZ+4ZjG0IhM5QQcG52Y8?=
 =?us-ascii?Q?E0xeKAssedjJ1iFBVDHo7DafrD1LG4tz8+jF/8EXp2JVyWO2gFypTNqcmDcX?=
 =?us-ascii?Q?+DJCiFvKsA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OgthTlngz/XUrxCBYbKeAqAJFUNW5uwcVTjIHS2QeYhNDy57XaQFci/uoRw1q+8IjBgp4LwxHb6+tpOpg+HML28deWDbRLDwcEBSqo0SyTGQW8h/NL0Nz/ZxpGVYB15a9rEjxVv2kHM7gyhz4mltwTbKVOE6qkBUYMq4vWQce6cKUefWJO5J+FFU1PMgtSz6Tg9ilgGrZn6WrO2/KRMYz7Q2iXnJ9gVCYeNsZTvUtfJBEZHqBOlxnacjqVBHwkiNVj8n+FzG2BcBCNyFfAYDqb2MN074MdN1nR+/0h0KJKy6oDTYSQxnSN5op0nHpjZ3xxcsn8FYrk/jiJt7YmQKfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939a8394-baf8-4ee1-59fb-08dea264afbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2026 00:50:46.1390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +n8u/G2GV1kCJ3RbmK78qrakADUD7iFKTCsitOCAD1s0//CF63x7GvLDBbkX/rLLLHdaPQBn/HVm/Dh8SHIrjDAYsfmS18jt4tqTYe3De9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8415
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 46323464532
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281091-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
etr Oros
> Sent: Friday, April 17, 2026 7:59 AM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; Vadim Fedorenko <vadim.fedorenko@l=
inux.dev>; Jiri Pirko <jiri@resnulli.us>; Rinitha, SX <sx.rinitha@intel.com=
>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;=20
> Eric Dumazet <edumazet@google.com>; Kubalewski, Arkadiusz <arkadiusz.kuba=
lewski@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; An=
drew Lunn <andrew+netdev@lunn.ch>; Nguyen,=20
> Anthony L <anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; =
intel-wired-lan@lists.osuosl.org; Keller, Jacob E <jacob.e.keller@intel.com=
>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni=20
> <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>; linux-kernel@=
vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v7 3/3] ice: add dpll peer noti=
fication for paired SMA and U.FL pins
>=20
> SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and SM=
A2/U.FL2).  When one pin's state changes via a PCA9575 GPIO write, the pair=
ed pin's state also changes, but no notification is sent for > the peer pin=
.  Userspace consumers monitoring the peer via dpll netlink subscribe never=
 learn about the update.
>=20
> Add ice_dpll_sw_pin_notify_peer() which sends a change notification for t=
he paired SW pin.  Call it from ice_dpll_pin_sma_direction_set(), ice_dpll_=
sma_pin_state_set(), and ice_dpll_ufl_pin_state_set() after
> pf->dplls.lock is released.  Use __dpll_pin_change_ntf() because
> dpll_lock is still held by the dpll netlink layer (dpll_pin_pre_doit).
>=20
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 32 +++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

