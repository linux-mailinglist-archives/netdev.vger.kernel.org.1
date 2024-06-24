Return-Path: <netdev+bounces-106004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B929142F6
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 08:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E3E1F22F2E
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 06:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCFB22338;
	Mon, 24 Jun 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPoYE24m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2F18E25;
	Mon, 24 Jun 2024 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719211675; cv=fail; b=e0NuwztgdtgPuCb3kpfb5YhI5qV9LdvX1gPj6ZHtd47l3jGH8ZaroCRd8meKKJ3gYzm8e6lxbWXPKL+M1ZAlhBqKU4mhaFxFnAFYstFE81ES2NfPBpGgcbq5tXqw7xsMhs7J1xvnqziTcdaJHa3iD6vKlnewncPRnFnrzOy74xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719211675; c=relaxed/simple;
	bh=Q0wEz3qIFHgLBQj++0UVuQEFQ6BaZRQNDZucBOjLEe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XaLxRXw8iLrBWQ8A2cbmAYP+GIxPKu8bs2bBYUbbJeo8oLJHC55DOzfcFsXRGjCMHr6akZ5Tsr32+5hic5qgn+K3089iRk0IcUwbrUY39TDh1IGkZbh8QOwWPYwxP6q3wITHdsedjFpwoyUmIOdLRmplXoGFFh1fBOQ6/admfWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPoYE24m; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719211673; x=1750747673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q0wEz3qIFHgLBQj++0UVuQEFQ6BaZRQNDZucBOjLEe8=;
  b=SPoYE24mbWud0qF82BVk28gj33YjcFiPG0fyjbYU+nCxBvgr8LHx3Kfi
   20oUJtWSNu6cbbRIuEqLzz+trwyoyMsXXQPYrt1dy2eFDJAlJe+SI4Q1m
   uefd42q8Vsx5cGtbNjAV4IsqmNFy8JRWgEoNSJPfsODcTzPKN5CfU9bkx
   VuCNgMAcgMs6zWxT5uUaBBcBvs5aDsyqGjpIND4YoMi5Q7FA6mHHrNhvU
   Uj4zZ03itidWzSS3blT1a1D94fX380QWf8XBjJTVY/lpn+1mK+iXnkg1Q
   YfREmQfXgXkL8OzRuP8YqkBlQbvPnuwcc9ulr656G35UCX2CciFCdmZuR
   A==;
X-CSE-ConnectionGUID: nJfzy1PaQLS8WkqK0w5LiA==
X-CSE-MsgGUID: RsRwd59+T9yGH59sk8Jllg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="33708820"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33708820"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 23:47:52 -0700
X-CSE-ConnectionGUID: UEzb0B/uTOySWhgCL3uBTw==
X-CSE-MsgGUID: Kv6wzorsQKGkZQJ1rFWAuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43072576"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jun 2024 23:47:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 23 Jun 2024 23:47:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 23 Jun 2024 23:47:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 23 Jun 2024 23:47:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 23 Jun 2024 23:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQbmpSM46LsUSSrMF5eHHCj0+N8tN+g9wgC15SZ1+V09+I+IE4ckkxFVBo+j9HQikXA8Ub8qz26x77gOOb/+FMJmn8pDAIK4r/Pg139Jp24kpuDRkLZDXquSu9ci/d4coQCpHdYzKycoRK3QWCOeiVKy5HKBoo5DMwvWpqTyj1xy/JY45n0mNtLLXW20dOpL/KBp5dTOWQsZV21mkGFAhuKFyo08K4aQRgNHu/8CInGvMBAL7koLjHrFStOcyo9psIp/Rm1SCjJ6y6xKakZOVph+/Iur5EGC+wdWfFbMOgLbxrJhqL7Ql4p4SVqSdGQ0VuFgP/HLgWs0SNzoHsnUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8jOi6A4Ies0MIh/kk55a1p3fZeWAYfR3SAbAs53lNQ=;
 b=fYXLJg9z+vxBkbQW6Vu7VpEV2PvQF5E6SP6OKExaovtxOC2SS9xLtCHfYqrnYJ4KtDDo3KgzaU7X27/tW/cjV/Q1qx8H5muLW5UQnlYpwPJ46opFy2xzlo9bBjcFMkKgLDb8PTTJbzuEgyIhtUX1nKEVfL9vzR3cUK00k6dVmKPeU6H8mpG/b3C3rcbG9d4Ae59UUkL4Ox5Hu6bleTKrwmA720FTZv2Gh5p0dDKPpllQC3KiQ5Ia/bgroho53Y/ZCoRMJ3a/z4SsA8G5aQ0/MxY0Q3oI9SwVudMusu2UXnBSgeSXWx62NW8iA0MxwdAe45vCbqJ3Oy91WVCYXrq4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 06:47:47 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 06:47:46 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: poros <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: ivecera <ivecera@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, open list
	<linux-kernel@vger.kernel.org>, "Joyner, Eric" <eric.joyner@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>, "Marcin
 Domagala" <marcinx.domagala@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net v3] ice: use proper macro for
 testing bit
Thread-Topic: [Intel-wired-lan] [PATCH net v3] ice: use proper macro for
 testing bit
Thread-Index: AQHawXBt+2dhTPjYL0+X7BwR9iHgabHWgXlw
Date: Mon, 24 Jun 2024 06:47:46 +0000
Message-ID: <CYYPR11MB8429521600AB122BE9EBC42FBDD42@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240618111119.721648-1-poros@redhat.com>
In-Reply-To: <20240618111119.721648-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|IA1PR11MB7385:EE_
x-ms-office365-filtering-correlation-id: f8e11f88-ba42-448f-ace1-08dc94198e8d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?49PU0mhsZXjacRlEOv43TTrUlMwnoH3X+77015fmLeFeYcGlIwOaW3BvPEmz?=
 =?us-ascii?Q?zgMMqGshPiLgNfbWY1JVxMjBgCn/oe/WvdnpvwKKBkrSMuj+S8WacYov8Qh6?=
 =?us-ascii?Q?gP6BZBm2gNF5ycEWWHNwC/pkMVdU1kdw0JUuKA7InUdUBASc9PVLUeQGKCcN?=
 =?us-ascii?Q?aD9A88BUsX5izrMbye56mhVzk9MWvX4E1B+utXMC+NSKd909vSUVgdpMb7i4?=
 =?us-ascii?Q?iDArb+uM3A6QhRDSoCgT4dzw/5KbIqSAMV3Y93Z2dspkZXKoIMj9FkPQ3pws?=
 =?us-ascii?Q?yKP7aQzaWMT9ODkl2IBaVHaYrLrzJJMpMiCVl72tqub/q07V9zscJYW5ojrG?=
 =?us-ascii?Q?jpP0D35zADaKKoe8KM16w805lheequAXuxpYw88yFTjBTKJxVjkFEiAzNkZK?=
 =?us-ascii?Q?oWCZwTCIfGNvKq3RhDE5XD3P9uYOIPkvQo1vmj45++ctNBOsupd83QyRI0vV?=
 =?us-ascii?Q?4tF2BLqj+l/vUBlzwIfmb2HIvaqi1P/Ta2IZCeiGTykBxq7J1LUSVIwjQSLc?=
 =?us-ascii?Q?juZ02yDg1jhGtUCCPGZ+3yZlVHmqeUZPQWnJMxRoY9xZrlkCkJBBt8131Ram?=
 =?us-ascii?Q?4qIUtWQSM0AyC1mche0q7VoBY0+LS1//rCnLfIoM5rJ08KtRyyawc4C2tCFI?=
 =?us-ascii?Q?Dx6ca6TRxw7OqNdm2NBZ3X6MeGUCyeYT/J2CG7ChziWiYGWMWmLlsMzv+iG/?=
 =?us-ascii?Q?9NGlpkyDE9SjvXSXSW6LuuUZoLrE0cEGEL8euWQeklO9iZJz39lL+iiKggf8?=
 =?us-ascii?Q?t3jLpG/SWLrSNROc0QOtiHp3dINICnrDwRsrC36Zv2XewT7ir+zzpNQWlA1B?=
 =?us-ascii?Q?6pQWdOsSA0Tpv5UCJ8Qh72O2JxPAXChR6Y3gIVXnLh1DhiI17KFGXNr+0epo?=
 =?us-ascii?Q?j0IZdSceqc5n0g8RYZHi66/aTILuMfSYeK9bes7KsLDb9WCNSGMepq29r/5P?=
 =?us-ascii?Q?ZdrQERWg6VyAvpG8H4etilFOWesNNgNAFvt9V9QV7/lwMC3e3nVbQUBr+AkI?=
 =?us-ascii?Q?bkOOQc/6N+Ih8lvLyD5anIZ89PV3jDFkP2SazK1qD+QUBXW/Pp7tWdDfpN7T?=
 =?us-ascii?Q?Y03XnBk7m1ofpcJKb9DEWkGbHZMqoG131RcDdC4qq2yUmtfrF16y+wkch/DH?=
 =?us-ascii?Q?+8IrEoRNNdMISPobTw5fXSVdJYeXUBQ9FYu0hHVn/BTZCX8brI+yyjfdDy7R?=
 =?us-ascii?Q?6py/8fJw1iPBL0GPlrfIdB/Fp3q6MW8cmo7d1TdIjSChB5RHbr/cgCPTmJ9g?=
 =?us-ascii?Q?vUS7h3ChNbxoMxHmRCWu1OUWAW6gv94ojcNDLZxTdKy4PzqXERTGpRlVJLka?=
 =?us-ascii?Q?gYiDo0oPCD8je3Sbt7BW6lFKurO3zbcFyy+znR8JFVl1M4PK2+C4F53Pg8CC?=
 =?us-ascii?Q?Co1ljvE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EE3uHDk5RwZZ+D9V0v3DWjop/2sodpiM5baudxIvp4MYhVszEpOOJcHquGJh?=
 =?us-ascii?Q?Fomyc3MAZ2BI3DDIibKb0Fr4r7iGwc6ZTt+PKGoerixommDqadVecEFpJRic?=
 =?us-ascii?Q?Ldmp64qxCJb2bMsUMpiOa4eX39pFJIXfmxW1tRgocgjgvmC96ETmpHI26wBL?=
 =?us-ascii?Q?qbnzdEsG4wS0zdHbU5BVlRkD3zfEXKdRD156216OJ5B0jsH9ghfffEhHEnG1?=
 =?us-ascii?Q?+hzBe5OVJOufNG+yeT4R9JkvSHhNrEQ4IYDBU8LrEms/Dkqof2WSAgaKq+sV?=
 =?us-ascii?Q?wCyFYDwSeHrIUaF41Em8eVBzb5f3+bpuHgVqoPaVZ72OALV7AD3WVyaciF03?=
 =?us-ascii?Q?eaBX5MKhQnlruz/7wlRvpltArQOK15DTL8xeB9Vw8ahwJz7M9tzIvYSb2Vnq?=
 =?us-ascii?Q?ex2cnHvWTZxBhDlW7KFu7X/JOQbfD2xR793vPCEuxCULk7jXlbsMn3JdL174?=
 =?us-ascii?Q?v99g786t/NJ9oRHOYVNX6WytIUTCkkSoWxK+xxO64NBG984K58otnqTofRUj?=
 =?us-ascii?Q?+y9NobDevKgFk8HAvnq474LWLYjjeB7HYzB8SEYA3Jn0lpLo4DHHKPPIJUFx?=
 =?us-ascii?Q?g9ALcnjbDn0/1pqspXFDGUBW1mhXwn7RB0gZDdinlb2fztDfbzX55R6PA6oL?=
 =?us-ascii?Q?31aUeuB2gIFVHN4eEtuB+3sHTqz3F0e5M+S6T1JWKLVyrXdH8jUr985cs5Bz?=
 =?us-ascii?Q?kxNHQWrzpiEOCImqxjtkf0MQoVJxdvrNDstII/wZooOUyyLBH3+S4PuehgWP?=
 =?us-ascii?Q?WgtanxNzFv+xcdv1jVEfZnctok3fyJfb8RKBptswIoYXqFqFnExkczTLiwF+?=
 =?us-ascii?Q?7Yn1fMT824WBhEukRUFar8du7sin7r5ZO8vOJBCjWya7q9wqVX0Lo2yrfSj9?=
 =?us-ascii?Q?k6B0UGQ5kxMtr8+TqwkYFJwAqEgXfmHZEc6XOF0pJP68hsTUT6HR0Pq2+dwU?=
 =?us-ascii?Q?mXS76o00hvnVwv7vuwSVvbSUeGIqT5ix1F42PWKF/mjCKwGn9EwlD5s+Yw+Q?=
 =?us-ascii?Q?PTVC3csm6Xlj3qpvxrZfWOhBq/EggIe0V7etdeE3fS4GT/QDxeSeEwI+2pqU?=
 =?us-ascii?Q?Ofi3BbzctDSassX7cXaDheOvXwYjwiUj63DzN3qUPPyTxoeZimI9cVDyJzAM?=
 =?us-ascii?Q?FyKtqpn3B4WbuiOpeeggfzQFJINiCY5e4kL/e3f0Lw0lOZkcjUImb2wZAibG?=
 =?us-ascii?Q?pFVIGG/vqwcvXA5DQ9aYKAl6diRMajLuqC2WYo27KJnWCUnLG4QhZ934PaOk?=
 =?us-ascii?Q?w2m6vu/2ZYlOx4sIXFrnWKJGV0SZeuJcr1+++lR6eBxcBXBcqFOHlhR13UET?=
 =?us-ascii?Q?CzBC3Cs21Hjt1xR9rD+/SjUdi/NJPMp9DHTObjDXqiWD97acV8xMY6hvHk3i?=
 =?us-ascii?Q?nP7zq34fgyU2rHNy+KCOxcSZe+Jsj107a5WMNHb7CuxZVFma151/qhWjvm+o?=
 =?us-ascii?Q?2gZ3X0oApBxhtZbjxlCzFuJ6FLeTXcvnMUGfRP3BMnzC2y1s4PRjUar14Fl0?=
 =?us-ascii?Q?KP7/Qt5jOWNBEQoO8sfHuKfREU0fgvrf+AVaWOQIfvwVSYayPpGa+j5ZLCS5?=
 =?us-ascii?Q?AjFFdjISKiV6x/W4TDj09r+i7FdRhrV+BqxfmtnhFMpyk03BXzHM0R8bArnF?=
 =?us-ascii?Q?+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e11f88-ba42-448f-ace1-08dc94198e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 06:47:46.6442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuddaUrNeJ7b0CxwgdipoOSBcd3sMpBkCq4DDOBmHjljsNHA+2yfK+wM+U+vWteIl453CKls7kELIEaqE1jsZlrRpTid5SZDtZBUC8c8/FQplq2s5KdMeV+1w3zV+v5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
etr Oros
> Sent: Tuesday, June 18, 2024 4:41 PM
> To: netdev@vger.kernel.org
> Cc: ivecera <ivecera@redhat.com>; Eric Dumazet <edumazet@google.com>; Kit=
szel, Przemyslaw <przemyslaw.kitszel@intel.com>; open list <linux-kernel@vg=
er.kernel.org>; Joyner, Eric <eric.joyner@intel.com>; Lobakin, Aleksander <=
aleksander.lobakin@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.co=
m>; horms@kernel.org; Marcin Domagala <marcinx.domagala@intel.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller=
 <davem@davemloft.net>; moderated list:INTEL ETHERNET DRIVERS <intel-wired-=
lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH net v3] ice: use proper macro for testi=
ng bit
>
> Do not use _test_bit() macro for testing bit. The proper macro for this i=
s one without underline.
>
> _test_bit() is what test_bit() was prior to const-optimization. It direct=
ly calls arch_test_bit(), i.e. the arch-specific implementation (or the gen=
eric one). It's strictly _internal_ and shouldn't be used anywhere outside =
the actual test_bit() macro.
>=20
> test_bit() is a wrapper which checks whether the bitmap and the bit numbe=
r are compile-time constants and if so, it calls the optimized function whi=
ch evaluates this call to a compile-time constant as well.
> If either of them is not a compile-time constant, it just calls _test_bit=
().
> test_bit() is the actual function to use anywhere in the kernel.
>
> IOW, calling _test_bit() avoids potential compile-time optimizations.
>
> The sensors is not a compile-time constant, thus most probably there are =
no object code changes before and after the patch.
> But anyway, we shouldn't call internal wrappers instead of the actual API=
.
>
> Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
> Acked-by: Ivan Vecera <ivecera@redhat.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


