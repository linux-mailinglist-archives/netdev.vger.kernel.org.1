Return-Path: <netdev+bounces-289817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHLWHC1rDWqHxAUAu9opvQ
	(envelope-from <netdev+bounces-289817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:05:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 170135895C7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 799B93019108
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4836F428;
	Wed, 20 May 2026 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsZ7zf/X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D433A380A
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264296; cv=fail; b=Jep65kc7iU7v4HRC2bvG95OzW5C3360BEcBwDajtuDlMzX1pkI3NRdGM7WPIJ0SEfhgIx49wsrBjcxR5ItKx4fO8e5Djr6XjSSF1gEH7X1zpbbf+KPsy012Y7KTBQpE5LgOFkSPxpmD375TcfHTaFDgfj4yX3zzMhsSeQGzGDXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264296; c=relaxed/simple;
	bh=/VY0CaauGlrbun7K6TyC1QeH5ZGZ6c4owB+Px8Wky9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BVA2PkFjM52osMSz9dfXGn7gW3cf0lLQ/XfNkG+grEzTmLXAFYGJBYdi8IXiOBgVkq46OJGX2VL6z9p9hnrdPgUH7mourFwOAfRTIY2S6FU7m6zGXhs+pu5CJxZOMI9XCzQCNiKAgjqo/K+PX9T4RUFYRwcISEDamhfAIq6kA0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsZ7zf/X; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779264293; x=1810800293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/VY0CaauGlrbun7K6TyC1QeH5ZGZ6c4owB+Px8Wky9U=;
  b=XsZ7zf/Xa4NmABcHjw+AzqxBrGUvQjXfCC9P0Kcz1hBjMDtJaEi5xgHC
   DCz9ZaQbpOTeE2b9Ao8FRbJQCgloWmsmMwfIbX1+sgMFfCRcd+DSgKuif
   tXr6aaKgEbu7QTt1dq9US+VQLzxqzBjwMy++hzrMSTzKkJ/B/kUBMMcCg
   kz5Od2d/Agwd1UG0viTmPRVXVWu7PtgXGMgId0hg0rdNFwW6MNi4otwWH
   yoS1TZ4dG8ytcpOgb6gQkGTkl8mzFzXyu3nc9p5RYpf/SO53W2m1KJK3B
   N91pONGa59LRpcDIz6Y0dCSE6Hb/TrL0SReGAppDvX2Y8HySXuHsAtImz
   w==;
X-CSE-ConnectionGUID: lo3WafBVRnKS6euTvmKWmw==
X-CSE-MsgGUID: F6qQlkcgQ767aFGj13dXhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79302190"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79302190"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 01:04:50 -0700
X-CSE-ConnectionGUID: ZvYK4DXmQSmjPDXLdYBIvA==
X-CSE-MsgGUID: u6pzu2gnTE6eWuih6M4j1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235808343"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 01:04:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 01:04:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 01:04:49 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 01:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW1Q42F/C8ga2hTJYfpnoDNTgkQwKyFQDl1NTVwRUYVCPRS/+W9JBlX/uocltmINTcd7AqWUy2q+6REcJ28EdEdUVT73vCLQG+UDzJlADhXQf7wHCf6PNZaxmQxid5vpdDMX3CviJw/gaSW6/vrFhdbb4IONf1sio5uKtBru0CraVsZIukqZvqzOYC9oSQv4ufivp+/T51esVayryEzy5gLWOxOk/YxQN+pGZETcixjZr0EfHbAXemP+Sfp+xLIiVMY0NpTgftr7jtx2OLxgZpvulhuSwt7v1M1+HLdbJ6i3anQOOf8u31hN4nog35Yfiei7MgBSSXRr0LhifWNgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e22mFV67Spd8ZkFgNBhFwbZHHfgd6s0/FcyW8ogEng4=;
 b=JR7wAFtp3PqT1u7Ktd8Bw0pVm3m/6P8gE+PA9wYB/LIm/oALna3yi8K1PYLSGcIt4dhYqlo9P8Oe00dZNBkXmGggC1edNAj9v7I0Sw0ebNRLcnNk5ry7EOncauxt+l6ZHRiV3nNdgVHpI1drNeBE43/6260+91QiZlOZAxaVPS4whyqNGJgZtWoWTCLB/F1MeeCaZaZ3bNrolfyBiMo1XFTYl9FH0MGHaKUitAjB3GKwaBfPcULakiOtPI7OwObHp+Siu6Rkl1Ui9NHena/C3tcKRAYvRef/V+QS3lgmYH90qCHLZTgToYY32tEPWPhheg7paw9f0SqcaxSCyMZQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 08:04:46 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:04:46 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH net v5 2/4] i40e: skip unnecessary VF
 reset when setting trust
Thread-Topic: [Intel-wired-lan] [PATCH net v5 2/4] i40e: skip unnecessary VF
 reset when setting trust
Thread-Index: AQHc18KHtqMFfWD72Ee21lu+SCvsX7YWrw8Q
Date: Wed, 20 May 2026 08:04:46 +0000
Message-ID: <IA3PR11MB898575C8A8834A29145534648F012@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260429102426.210750-1-jtornosm@redhat.com>
 <20260429102426.210750-3-jtornosm@redhat.com>
In-Reply-To: <20260429102426.210750-3-jtornosm@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SA1PR11MB6760:EE_
x-ms-office365-filtering-correlation-id: a2cb102a-d5c0-4de3-03e0-08deb6467576
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4143699003|38070700021|11063799006|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: LhSwBOnNvkdnlIZEKggPUgHBH4K1eVdcI6QbswL1BMIYuxcy7ieu1JqtNBlCg6tecsrYueMM+3qQEqFiEsp/FM7G9SUv2edBcZpGS/g8sj83j51h9iMMeUalhwAzw2z9pXooEqv0/icn9HA9U28t4h+6cgBf7gLNrdperZf5YErlTiwU/+PvddBzAr2E6+bu4iXscgte4JzRffJHpun9oEIJ8uFjDiluvnFpsMqZJUajcRUH7THY7yPtqKRzWRuE0ivSU4Rq6RQir4UfTeArmpQS2GmOHEy/p+jmT8We8UshMbm3VW5zy90133r5IbT2mnxc/PVsWzPY8Qzx3b9yYX0zwRbnuR6gtnXpNSPN9THVe1rd8cUFOzzp6pIwR4RzhXeBEU/1RzwoZre2HeDjAVyg/MfTDV9RNiSmndcK7OJeyKaFVBrS+co+1gBge7pKnvc09+IgrOP1WZhwt+b14dj6n0Jm2wi+Wvny4I80a3BsHNLNPhNbNRECHuy8tvXbuLngm3m5V4TbxLtbLLavjfyntH2AbqZf1BCb/2Anr4QxgiKPMs6J3Igs3oe2xRLTA6ST7/Mjv1IhQrJZQO6ov01WZRxsHh9wikFwe5cxGsTPWwDoy8D0u5iMA2FiWGu3DiMEE/p6AChzJBB6cuh6f9MJETDnq5V3sZ98Fs24GcqMn+Q6tCuHJ8qUJagFcU3zNhA8QyvGxvuE5pQAXJhhqNJwC/PeJCGpCE55Q2L7H/wqkXeYevxgK3FawVxKOceN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4143699003)(38070700021)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XqOq6AvpDLu4pSkoj7uXVt60QnIU3b1oNy5C0TIdaUhkho4w62/mX+zHnB0A?=
 =?us-ascii?Q?JqdTu12hzg44uCQmvmcNwterJS/dXdrMbTtGFw18TUwtk2eMgqf0an+afaKS?=
 =?us-ascii?Q?LAMqfGUH7XTr53eMka4fCuOA/l+bQ7Fa4IcHu5lj5Yt7riu1VcEtLYzYRvEN?=
 =?us-ascii?Q?wU0vygVJBswbabVU3uraPokB5GbKfP5KN2h8VgrNg02v0D3yp8e+wFM7XWJA?=
 =?us-ascii?Q?ACqtaf9xxAKoTAZTQPiYqiVxhdyTHNbyt8tZs3ORq3ZNoYoSMS10WWez/EOp?=
 =?us-ascii?Q?7o5txVdhYiOoMwCxY0nyOgtO8tqY/H21qrGZaNO5tIk5LL4UaCMBi1SPz8tg?=
 =?us-ascii?Q?3ZZu1QB1iJDrz1AjMW7A30kg6r66OyKD11ihSSUEpP+SbjV36WywIUFwQEyl?=
 =?us-ascii?Q?uA0U7lLo9KaERr81VU7+2Bqbm03ZBI+umjdzAKO1uXzZgBpu5zX197kKWzQ0?=
 =?us-ascii?Q?uHDZYB/hBnao6Yl/G7WNS3boKAEHSF4xxVxPiYLi/1j5qLE1rRCkXonUVgrZ?=
 =?us-ascii?Q?h4LNIeVrr0xE/mm23VSzKUbcNrjctO8rzCxkQ27kAG1xLW26FWJjFgpMoW/Y?=
 =?us-ascii?Q?Rt6tQmD6NkKPPT3gihpA5xnlNKiHy64gerao3W2b0PU9+NUwKd4gBifyR4mf?=
 =?us-ascii?Q?DrnvCZuehKAXINqgZ4y7lOFTIzmuVDUKSpsN7M2iAydhbZWjFHlp0M8bRq13?=
 =?us-ascii?Q?1tMsERmL+OrRQS9PtWv6kJzIm5OFqSNL/PfxZXTF6CasrA8u82lMHrSRJjzj?=
 =?us-ascii?Q?mLBdHtD5PFNM09s5JKDzku0TiWNs/SRAflTbPlPLaxMYl9hqpXfxJeOc5U+5?=
 =?us-ascii?Q?t3wuADh/VUjDdc6G1Cs6gB7TO6nSK9V2ACtuOm3vwO8mamK71/5y0T2Zmf34?=
 =?us-ascii?Q?71FPKSsBlNxS3TQ/QVsCQtpRL5yQZh7M1V0hHhQ0Kx6+AFvGXVdxbYMcF2CG?=
 =?us-ascii?Q?QncsBQi2VfpCeYpCKBVP2VbI8dXEerakO/axOa8XicAUwqQDAl2VCu+JOZjG?=
 =?us-ascii?Q?SbsCEAt7fHV9Ps3x8SNwRSn8hx8Qj1cKcxrQf2MJ5A/3vqztEdJHjpCx/CM2?=
 =?us-ascii?Q?OUw+CsoDVbHcLeu5LTSmvHUwl54bhbCgkVnTLyHFmnNSO7MWLkuM8vqndXUB?=
 =?us-ascii?Q?Xs8MTXxHYZ3Oa1+CgeI6hc5I9gg0mGXS5Ek352PQl4QHWs0iBs9PaoMG1a5Y?=
 =?us-ascii?Q?mZg4LFRwi5wYJtsdJtchr6yvd83LirvVHdJVQX3TxKvEeiirqh38aSJxsOWB?=
 =?us-ascii?Q?Nkv1Au4CvHk1TRVrp7I6UIrkluTF9doMW8pOL/70/K9NpV9JcShxSfxT0F8e?=
 =?us-ascii?Q?uIlJpxCf2nhIlWeZmoebDYZPA/Mgl2arrR79a3yXEGieO5gSzWBRADwZtrgU?=
 =?us-ascii?Q?QXU5GlB52Stwjycw9+1dFNU9TmPn/jRfwTnwb5vwNVw5h+QV0O9QWYbhU0If?=
 =?us-ascii?Q?ZhsRG5V9MTeTB8/XZF5+iReSINQ6+RbU01wZlSe7XumZEaZZXD0aJqFWhhe6?=
 =?us-ascii?Q?qYxByBlR+rivOBKoPnZep0la3ylGkwS0rKdwQPk7V3whizD7F4xf/RiSVXbX?=
 =?us-ascii?Q?tdiv6kSRMx73SmNfuG5RYG+i3W5qSAPIPWS3Ba8Dla6UaBy2UK66oPHkxImm?=
 =?us-ascii?Q?ik3GTADtmxKHS0CRz6mF9HCpSke7naLPA47Ecvcv4NhOkA8VzBMYkFR9/xfO?=
 =?us-ascii?Q?Pg8rgrtT6Rc+jGEZs4MbRTQNqnTOqtj6QHeYoEQR8qX34AswOAPZ13WWl3NU?=
 =?us-ascii?Q?02BEf/m/HQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RQFoOnKCMQtf+4F50PRCGc+wGBDbs/K6c/+JxhiaGl19JIRO8tIfWKMVh2+ZLBhqrSQ78pGdleLDRtfxDFNZiJNzOq3SizRvqrokV/s9Bni8sNeNLsDL1YWD53UHvntQpwc2cAddfcltd4OfPWKmehxbfdIJ8p9U3Z73Wa1GBO3S1nJqg/Zp7cvwIYJu0kHVFnbhmfVVvTFsKct0eQVfIQXCoGbAryZeVHvMKsfCDEFwkGrwvZmESoU8lrfe8DLV6jRLneYuyzFGxrZcuT1GDKAKttiPKemIU//oXBD4+cR2jCHDhkGHlN1OZGnrhmICG2Q9AFXQ/cKchUUIjmLBZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cb102a-d5c0-4de3-03e0-08deb6467576
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 08:04:46.7305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAuPcauLTVK0NuadNWZR8Gpdr0Gue5K3wC2DdZVMT5XFy1dPwURtCpk2qGWDF4BfM7125Q1SOd2/vnKzyeyzsgcsLNhq5hobunwQUvF3YWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6760
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289817-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8985.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 170135895C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
ose
> Ignacio Tornos Martinez
> Sent: Wednesday, April 29, 2026 12:24 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Keller, Jacob E <jacob.e.keller@intel.co=
m>;
> horms@kernel.org; jesse.brandeburg@intel.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Jose Ignacio Tornos Martinez
> <jtornosm@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net v5 2/4] i40e: skip unnecessary VF r=
eset
> when setting trust
>=20
> The current implementation triggers a VF reset when changing the trust se=
tting,
> causing a ~10 second delay during bonding setup.
>=20
> In all the cases, the reset causes a ~10 second delay during which:
> - VF must reinitialize completely
> - Any in-progress operations (like bonding enslave) fail with timeouts
> - VF is unavailable
>=20
> When granting trust, no reset is needed - we can just set the capability =
flag to
> allow privileged operations.
>=20
> When revoking trust, we only need to reset (conservative approach) if the=
 VF has
> actually configured advanced features that require cleanup (ADQ/cloud fil=
ters,
> promiscuous mode). For VFs in a clean state, we can safely change the tru=
st
> setting without the disruptive reset.
>=20
> When we don't reset, we manually handle capability flag via helper functi=
on,
> eliminating the delay.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v5: kdoc should end with '*/' not '**/' (new function)
>     Address AI review (sashiko.dev) from Simon Horman:
>     -  Adopt a conservative approach checking multiple conditions before
>        skipping reset: ADQ, cloud filters, promiscuous mode
>     - Simplify helper function to only handle capability flag
> v4: https://lore.kernel.org/all/20260423130405.139568-3-
> jtornosm@redhat.com/
>=20
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 38 ++++++++++++++-----
>  1 file changed, 28 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec15..0cc434b26eb8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -4943,6 +4943,23 @@ int i40e_ndo_set_vf_spoofchk(struct net_device
> *netdev, int vf_id, bool enable)
>  	return ret;
>  }
>=20
> +/**
> + * i40e_setup_vf_trust - Enable/disable VF trust mode without reset
> + * @vf: VF to configure
> + * @setting: trust setting
> + *
> + * Update VF flags when changing trust without performing a VF reset.
> + * This is only called when it's safe to skip the reset (VF has no
> +advanced
> + * features configured that need cleanup).
> + */
> +static void i40e_setup_vf_trust(struct i40e_vf *vf, bool setting) {
> +	if (setting)
> +		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +	else
> +		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps); }
> +
>  /**
>   * i40e_ndo_set_vf_trust
>   * @netdev: network interface device structure of the pf @@ -4987,19 +50=
04,20
> @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool s=
etting)
>  	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
>  	pf->vsi[vf->lan_vsi_idx]->flags |=3D I40E_VSI_FLAG_FILTER_CHANGED;
>=20
> -	i40e_vc_reset_vf(vf, true);
> +	/* Reset only if revoking trust and VF has advanced features configured
> */
> +	if (!setting &&
> +	    (vf->adq_enabled || vf->num_cloud_filters > 0 ||
> +	     test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states) ||
> +	     test_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states))) {
> +		i40e_vc_reset_vf(vf, true);
> +		i40e_del_all_cloud_filters(vf);
> +	} else {
> +		i40e_setup_vf_trust(vf, setting);
> +	}
> +
>  	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
>  		 vf_id, setting ? "" : "un");
>=20
> -	if (vf->adq_enabled) {
> -		if (!vf->trusted) {
> -			dev_info(&pf->pdev->dev,
> -				 "VF %u no longer Trusted, deleting all cloud
> filters\n",
> -				 vf_id);
> -			i40e_del_all_cloud_filters(vf);
> -		}
> -	}
> -
>  out:
>  	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
>  	return ret;
> --
> 2.53.0


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


