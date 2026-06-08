Return-Path: <netdev+bounces-296425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WerLM2aFJmoAYAIAu9opvQ
	(envelope-from <netdev+bounces-296425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:03:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62346654585
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:03:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ABRotQot;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296425-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296425-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28003300828D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E83AD51C;
	Mon,  8 Jun 2026 08:48:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6B3AEF2A
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:48:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908482; cv=fail; b=IpoR/m6O7nbZon0fmfSMJMi8c+VwrEDTEc3IiJ5+q/nnYXUAG7Evr7rSkRkDYwKcWvPNouMHHi0DtLQ1Zq8qWfjV5A4j+j/mAg+B4UIBArGQfb3udh5xzFZ9ESAqrDTW4WLP5QOf/WMoW84fUVnTSsuKFRrt4SEMKMYOVrOWDxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908482; c=relaxed/simple;
	bh=oCobleVeUkRSdhWKWrF3fAw0zTnwpHOeu8NsyMeBN2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NH7RgSA/K208p1DfBUDuDXgb7QTPOTc3SJ1dd2uWOAV5ep5vtPLQXbTPv4Xs3+iDZXdcHe2T4zRsE69nJekgq3apMEenb94dV+SanawuVdGmm6cIA8uMy/RD1rCMNWgadHcFsTV1MU70qTi40dMSOWYPDiahS0kmr1yE1QWwVkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABRotQot; arc=fail smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780908481; x=1812444481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oCobleVeUkRSdhWKWrF3fAw0zTnwpHOeu8NsyMeBN2Y=;
  b=ABRotQotPlzVrpe14xuyRWjNC8/+J7kj3vQVrLtSjR23ZkBuLliOrm7x
   u7b/8ZAmwE6YkudA1ibC0Yb7dnlzfN9aSYkXtwtAYaDEwM1xYD7aWfz2Y
   FZalJ1lAIv9qyvB+FlL+ZLG8alJeNioquJhqfPB3zGNqAtqa/+TAJvhuf
   lSgii3JHpK/SSgnEZ8VTAVl60obzc28QyLHlck57UXMJZkiAo7zLYZ36k
   4Bi7UkuQIov1We+jnWk3s/P8uRB9cRSjcrQQdoK1MkVhnyyvg1HEdntJM
   OMdNfhX2yLsngO3RXhBiQIbPYjEe0Y2GD2p85/GcqGpqeTUT0k3fGvqsa
   g==;
X-CSE-ConnectionGUID: 1Twwx48JR+KL/QqL90bJ3A==
X-CSE-MsgGUID: irQsVuA3Qd69dATzlwx50w==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81759801"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81759801"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 01:48:00 -0700
X-CSE-ConnectionGUID: o84bU6beQBCci45hQm5T2A==
X-CSE-MsgGUID: jixyC/3URuKFqSSHPgHBvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="239140590"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 01:47:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 01:47:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 01:47:57 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 01:47:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWk0ERtGQDvPAtuijQlY8a71+dk54kfmSDDarn2dyy94HmAGcYoa+niLpeL3zjqiAqfFRYYXgyVL8mQQLPmUHnTuBxxToq40E0RKSNXqNxeyT/xSLo8unGoLsNl91KqG+wR8WkEXrgvlgswU39jiJG4kVx1LKnKTqeapkbAl4L39t3UiaBaC5qbqGmreYNQ5u/2zTL3F+sR4my2cq/iEtCrx37518p8gcjJa6YUTrUeWV9spFX46WdYCiJXmbDdFyaoxDuWsFjr/x6YJJWVSlsg8jDe54hAdWUZYl6aCl/KEjyZ/YO4/qFMycwCKX0ct1/uEx/XZPa7FiddnOh/J8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WI8Fm5bAu/bD9m9SBXihA8gZowKs6JSZTbtmPw/ECAg=;
 b=aiabQZ5etQHVFVlpHeXb7gyghCUI74oUCVOnfYXgLPgYMv6DwuAiaEpGLKmrKWFcBIlqz8DTHDs/5kFm55ZsUlrsyUT3QRztKB4qrA35JNelVamyGWyuV2Xs6JLgFLNR7AqOrnOQwMsHA5DeAxV3HzSC2Ae9k92bhIIpAjnMBSxsK7gpp8A/nCg//AhMEcJIFatb3A5MkSVcMbuX+a+G6SW7Ks9JPZXBNFh2NpH6r/E1ilOoer+NlO65Ja4oOArCxDWrX3RlNFEHKAyec6535OLqHupfYiBuENXT+xHf8q8EC2hmUGL0nXW4QkEtcQtmHLobVVsRGN70d8Pv/XmnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6501.namprd11.prod.outlook.com (2603:10b6:8:88::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.12; Mon, 8 Jun 2026 08:47:55 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:47:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "Keller, Jacob E" <jacob.e.keller@intel.com>, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>, Breno Leitao
	<leitao@debian.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Fabio Baltieri <fabio.baltieri@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: RE: [PATCH net-next v5 4/5] net: wangxun: implement soft quiesce for
 PCIe error recovery
Thread-Topic: [PATCH net-next v5 4/5] net: wangxun: implement soft quiesce for
 PCIe error recovery
Thread-Index: AQHc9ABXgh03bCeRK02VtN0rjiEWmbY0Xulg
Date: Mon, 8 Jun 2026 08:47:55 +0000
Message-ID: <IA3PR11MB8986D150088ADD4C91A736E6E51C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260604085631.12720-1-jiawenwu@trustnetic.com>
 <20260604085631.12720-5-jiawenwu@trustnetic.com>
In-Reply-To: <20260604085631.12720-5-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6501:EE_
x-ms-office365-filtering-correlation-id: 791c4f0a-000c-4d85-3444-08dec53aa21b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|11063799006|5023799004|56012099006|4143699003|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: dlfrsBcg+AZ8QdBGIo9pidMGaErKIvLKaU/Lx3UDWj3/pqRumRj3oIb5ArJD67LE0qa1fCOQFlpjsndiAaT5nJcWsVpF6cgakhhSm0cslHXwO8aDr5kcU0CABBQDNCJTRwq0JKFKStYwB1FDwq+deeBO9vuNTCOzOgl+AeaXDzEavEnYTc3s46KXq74BwlJi+ZFrVU+EIxU3TTGx3IjIp9iDk5wkOiSUcNV89pu3Dh+L7fM4Kp5SZUkrI0dni8Pmzt8FEwEoh8tNLyYCVGgurh34UMBTA8XlwNLaK44tmNv3MbkYLAmlZgd9tW8LeIelA+lGdwtezPiCJyqITvdRBqIcJj95ZSI693BEEv6n+yVKT8DnFvkpvGLox/2nw7iAqZrq/4s7xttNG6XxB9IrG7qpXaqhD+PY6MX5a55q7raiP4mIzQzhGITs476X2HP3P3CN8ML+vBcFjmJjVrmzBZ3IAzsKLz2vIuoCwU0cv/MzceO+b7HU20ouPQn8nFLRyTi2Te9u+IYkHoWHtBkPNRNZTsGX2s99eYsRiCZHvlvpGHyJI6q/5jI4a/RKNvQtm3ItNuxFOpvaH0TAH2ZAye7f/6+Si63Kuekg3M+kyhvgwcYV7UcCjs0MEMkYMXfzbo/dTvfdpSss5lqfARgpp3El5R2/WRzsIY9FrUG7iKA6JLWs/0CGW4ef0YjYM51o0U5mILp2B/ADXimklnpJyQFxCmeREGh9bht4FGV8Gm8KMqWOvaWJC3alvpb1FW+b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(11063799006)(5023799004)(56012099006)(4143699003)(6133799003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vPTwLlj/zh6Zg3YR26J2gTBSh7zcP1r4Uw4lNzOXoXwL7YU82M/+oi8RMS?=
 =?iso-8859-1?Q?Nnv0LpJSCr/QuifTMyKVqTCMGWbJEmxQ4c1pVltoNLpul7Zh6upBzoVmGg?=
 =?iso-8859-1?Q?FA4xUSjIkwtpWOlcvaySW9Pfyil5K0Pe750cj1OcxBB1Y81hxCCZ4y0YJS?=
 =?iso-8859-1?Q?BLWWF0CSifplzmee0MeDHy1GZDeJkJS3ikWiQR6RwqTCbdFJcHd9U3KqL9?=
 =?iso-8859-1?Q?9cwfJ9guSgdLIVuG7QOK8+BUFkSdxIvyRzkQ4RTEv+GpTS/VeDwO24Ejzq?=
 =?iso-8859-1?Q?zOX2/+2Pjrp5H/lku0GVtV9cLKXSli01Wc64/ZQ/yZrjVhkwrtFFenbXCm?=
 =?iso-8859-1?Q?YhHMzZfN39R0F7XlV97ZnFqF8hc0nJL+6oSU1caIuZeHpIh3anS6uFD14w?=
 =?iso-8859-1?Q?Mtm39neCN3PaOtGMZ3mWPZWE+Su+z+qqlUMm9er4hYWogv7WibDmgMhmiz?=
 =?iso-8859-1?Q?6khB4u1RmelLzaR0xnvgMH/abGZuJ4suvRgpuanKdGVBSGLEEayBwe88Ts?=
 =?iso-8859-1?Q?xCIgBKHcDwneEztwtJ3ELC+8H91vDs6Ctjd1dA2XMFek8uggyh4o8nmEV3?=
 =?iso-8859-1?Q?fR9u7TBErLNLGkMeF5EcNKv6eDZD2Hs3WpH7N5vRieGqEJsyK6m1XmPthQ?=
 =?iso-8859-1?Q?k8cxzEnor8+3zSg0g6sE+oJFHXkzRz34GoV9Mv4EAiiPyolIeO4w1U9FLt?=
 =?iso-8859-1?Q?2lB5BgRby/vRS+afO9gK3m4aScy6YSgbQtvG9NAvS0WNReymdAKK5lGJ9z?=
 =?iso-8859-1?Q?jnpi4Gpr0jSho2LyHh+d6WITAXR9HbeAoT+5z5YDb9CwaJ8h2uH1F2unKA?=
 =?iso-8859-1?Q?Q9lwqVZvDC2PPl/pB+PJbV8hGcD5957xyY6LPHqvs+P0pEzNgfxuVXLDE0?=
 =?iso-8859-1?Q?gXlZg5pxYoI/wmrwTfSBfqQsgLo47lEBRzIGWP8A7l2x/Isdg4R0Dgbv5S?=
 =?iso-8859-1?Q?vsfS3ARdIIQOvvOGMnHraEeW2Z2UDwNOtzJa11XjVZDcb6ndFuxSnSBObz?=
 =?iso-8859-1?Q?q5zMlOJ6SgWhGl6yS/x97GwyHe/HekzKCWjj8U8zle6LHfSsh4jOxQ8r+U?=
 =?iso-8859-1?Q?Pvsu7QeNSUWfw/XJX9B87KnvLQeXpeBl8/PNpqmVA4H8UMz/7eUMykIF7P?=
 =?iso-8859-1?Q?/Jfsa1O11OMJ1cfltwErfXFp+OlVBJya/DbXmwLF0837Zn1ZUQDTnw6mam?=
 =?iso-8859-1?Q?np2YW1vwIjny6NNQSXXujBA7g4BEPaFbETTksDH66HsyJ5OjusfOYI7+Es?=
 =?iso-8859-1?Q?CxRwobpzsWJQm2SBmRSAa+hbf9b1PzAg48qZC5DCkemispUm3puG9DxZ9E?=
 =?iso-8859-1?Q?90fTMbvgn4RxGRx4JCu/sq3vUfsOOVW1ewzHhy/cMHMPnLFPO1wV8HTt4C?=
 =?iso-8859-1?Q?emhPWSBIEoRH/UH1IFSKygxAbPtwaM9nWkmKeU4FU2a7tTsiFFT9Zge2rI?=
 =?iso-8859-1?Q?AJViMBWgGvL6WdM7vT6KyJDdhl5GxGWLBJ1gQexEL/QSvXd7lGp4VOmmJi?=
 =?iso-8859-1?Q?Majan/9G5iDby1znAlIDD67A7kQ73eH/fJeuxEIpnHcRBJgK3cpTlQre6j?=
 =?iso-8859-1?Q?i0hfIJt0uZyZbzDmUp+Smkp3FjtRD/pmjZZybhuMdqRRHDCq57UUjZlNjc?=
 =?iso-8859-1?Q?gPv1ERDOSOiUwjMXE47xFH+VbXE7JBiuhX8iT8WQ6xeFfeDMUCaXsqiMjl?=
 =?iso-8859-1?Q?fjPYHhT1PUrhP+SYTrbROSJoQycp3Z25IrF6oITkGA/hE7lgisdF1D2VYp?=
 =?iso-8859-1?Q?4wYKDDxqGTarY1nTUV7DjlmTLByrOSQqPdEtYOkvkM+y+2vNMspW45EfGp?=
 =?iso-8859-1?Q?19yXevOY36eZhHrvS4g/iaISrlsxwFU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BAPqYA9To4p8+mxaNEzKatbaC3fxz9jczm62R9xMfLpkxsMcyKj+C8yrI37HZlw8Iwzm18ci4TS/QfKw+1y34ZoH1h4mgtfrwrvlDmgskSwt+qJeWvQwH4AMNvOI8K3/3hBcYDSe3NGah8vZfYxQvJilgldxQRFQS8ikLzSMn2+Wi0zu0AfvmhR2IkSKeqkBC8HZkOS2Y3BdKlBOfFKc+ulnUaTOh3Jx/LM9YhDu3eRcoa4mtYx6l4bz/YG+uDYi/W+tzSgCIY2GUbfLHdCEKBipe74uVeuyhEYEq6mS4tGmP4we/+n+XlHMHtpGc9cjUzAuuFS/G9irIHlk4ehV0Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791c4f0a-000c-4d85-3444-08dec53aa21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 08:47:55.1109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVRFlraKXMQM6Eiaf00B+Y94LiJA1mLMmqbpoc7TL2xJXzPac4asZVaBXHThchi7KCdmf3y0RKJkjGWtEsREMzlANcbytEwBUivEO2ciIWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6501
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296425-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:joe@dama.to,m:leitao@debian.org,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:tglx@kernel.org,m:gregkh@linuxfoundation.org,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62346654585



> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Thursday, June 4, 2026 10:57 AM
> To: netdev@vger.kernel.org
> Cc: Mengyuan Lou <mengyuanlou@net-swift.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Simon Horman <horms@kernel.org>;
> Kees Cook <kees@kernel.org>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Joe Damato <joe@dama.to>; Breno Leitao
> <leitao@debian.org>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Uwe Kleine-K=F6nig (The Capable Hub)
> <u.kleine-koenig@baylibre.com>; Fabio Baltieri
> <fabio.baltieri@gmail.com>; Thomas Gleixner <tglx@kernel.org>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; Jiawen Wu
> <jiawenwu@trustnetic.com>
> Subject: [PATCH net-next v5 4/5] net: wangxun: implement soft quiesce
> for PCIe error recovery
>=20
> Function wx_soft_quiesce() provide a lightweight shutdown path during
> PCIe error recovery. It avoids MMIO-dependent operations in PCIe error
> status.
>=20
> Waiting for the service task to complete may unnecessarily delay PCIe
> error recovery, especially if the work item is already blocked by the
> hardware failure that triggered AER. So the service task is not
> explicitly cancelled in quiesce path. As a measure to block the
> service task, the checking of WX_STATE_DOWN and WX_STATE_RESETTING is
> added at the entry of every work item.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 14 +++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  1 +
>  drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 21
> +++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  1 +
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  8 +++++++
>  5 files changed, 45 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index e5a45356ba00..0667eb1fe5fe 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -3382,5 +3382,19 @@ void wx_service_timer(struct timer_list *t)  }
> EXPORT_SYMBOL(wx_service_timer);
>=20
> +void wx_soft_quiesce(struct wx *wx)
> +{
> +	wx_ptp_quiesce(wx);
> +	pci_clear_master(wx->pdev);
> +	netif_tx_stop_all_queues(wx->netdev);
> +	netif_carrier_off(wx->netdev);
> +	netif_tx_disable(wx->netdev);
> +	wx_napi_disable_all(wx);
> +
> +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> +	timer_delete_sync(&wx->service_timer);
> +}
> +EXPORT_SYMBOL(wx_soft_quiesce);
> +
>  MODULE_DESCRIPTION("Common library for Wangxun(R) Ethernet
> drivers.");  MODULE_LICENSE("GPL"); diff --git
> a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
> b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
> index aed6ea8cf0d6..11bd79985e17 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
> @@ -41,5 +41,6 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
> void wx_service_event_schedule(struct wx *wx);  void
> wx_service_event_complete(struct wx *wx);  void
> wx_service_timer(struct timer_list *t);
> +void wx_soft_quiesce(struct wx *wx);
>=20
>  #endif /* _WX_LIB_H_ */
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> index 44f3e6505246..dcc8b3ae1445 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> @@ -842,6 +842,27 @@ void wx_ptp_stop(struct wx *wx)  }
> EXPORT_SYMBOL(wx_ptp_stop);
>=20
> +void wx_ptp_quiesce(struct wx *wx)
> +{
> +	if (!test_and_clear_bit(WX_STATE_PTP_RUNNING, wx->state))
> +		return;
> +
> +	clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
> +
> +	if (wx->ptp_tx_skb) {
> +		dev_kfree_skb_any(wx->ptp_tx_skb);
> +		wx->ptp_tx_skb =3D NULL;
> +	}
> +	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +
> +	if (wx->ptp_clock) {
> +		ptp_clock_unregister(wx->ptp_clock);
> +		wx->ptp_clock =3D NULL;
> +		dev_info(&wx->pdev->dev, "removed PHC on %s\n", wx-
> >netdev->name);
> +	}
> +}
> +EXPORT_SYMBOL(wx_ptp_quiesce);
> +
>  /**
>   * wx_ptp_rx_hwtstamp - utility function which checks for RX time
> stamp
>   * @wx: pointer to wx struct
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
> b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
> index 50db90a6e3ee..ad2f824875d5 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
> @@ -10,6 +10,7 @@ void wx_ptp_reset(struct wx *wx);  void
> wx_ptp_init(struct wx *wx);  void wx_ptp_suspend(struct wx *wx);  void
> wx_ptp_stop(struct wx *wx);
> +void wx_ptp_quiesce(struct wx *wx);
>  void wx_ptp_rx_hwtstamp(struct wx *wx, struct sk_buff *skb);  int
> wx_hwtstamp_get(struct net_device *dev,
>  		    struct kernel_hwtstamp_config *cfg); diff --git
> a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 9251e7a1d416..f6e596eb9217 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -94,6 +94,10 @@ static void txgbe_module_detection_subtask(struct
> wx *wx)  {
>  	int err;
>=20
> +	if (test_bit(WX_STATE_DOWN, wx->state) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		return;
> +
>  	if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
>  		return;
>=20
> @@ -107,6 +111,10 @@ static void txgbe_module_detection_subtask(struct
> wx *wx)
>=20
>  static void txgbe_link_config_subtask(struct wx *wx)  {
> +	if (test_bit(WX_STATE_DOWN, wx->state) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		return;
> +
>  	if (!test_and_clear_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags))
>  		return;
>=20
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

