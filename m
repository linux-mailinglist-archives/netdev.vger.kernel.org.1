Return-Path: <netdev+bounces-253716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM80M8JZeGkupgEAu9opvQ
	(envelope-from <netdev+bounces-253716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:22:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C09B905B6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87322300BDBA
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB45F30FC39;
	Tue, 27 Jan 2026 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GaRbKc3j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBEB17D2;
	Tue, 27 Jan 2026 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494975; cv=fail; b=nIPF0R2UhPRD1IlCPm0ocoKdC2l+o3L1ONP1XWC770A8S+Jo1vITwACWcqhfDjxP7u8EaxXA739UQY8qhU+0pRFaP5ZOfJuGfCIQg587tuTFoO6aeOO+hIFeYC5RFsSInCz5zILJht7mzfGWkzZxkbwOW3OIOaKjtvyJxko3/HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494975; c=relaxed/simple;
	bh=3CHBxWVlk4j5+zJJI6jWnJFlW2ClCEgRea+/k/mu8lA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZwmtL8icatGtWtQPS6hmiByfhJpbYM2Za1EyGKcyX9B8JGwQ8FYJcJwae1WormkGCSMyUeIWtxtxtlB5gGMt4s9kMmLNDdZkwZW2RHIUoqHKg5i3f0NX+e6l6U2t2//pvErvJAgVH3uX026IkraQKxJsXgSAvb29eldyvaO+46Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GaRbKc3j; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769494973; x=1801030973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3CHBxWVlk4j5+zJJI6jWnJFlW2ClCEgRea+/k/mu8lA=;
  b=GaRbKc3jGfWAXIDtqh3W6uHI36t6rwdMsUoPudKiP/dmhikWwqMVbq0C
   UmCw7xg0RHQyGqM+NmpS6qqWIp+4zM4AeN/Zfa4uRbe8V22ixXCne2iCa
   xrOOxsKwBgeOzvtDGpQrskW0EFm7TmyCCeKsxcd8o9MC/ZPDCfk5KXpC4
   mJOIzFyqEJqkTkmr4GhrpWKnKQkMP4HiLrWitijcHvNSzNyijb4o6FEFS
   M0qAz244kMZTIjqnfZ9zjcHRrcuW6ikgye9aX5CylmaLqZTiVUUv+WjRd
   jzyIPuvEXp/6E+B/AP15Wktg7+7P7YQIEqVUr/egM79wa3c6eCbrd+eak
   g==;
X-CSE-ConnectionGUID: 4Mgo9+B9TZO2K2QwEC8k+w==
X-CSE-MsgGUID: gjuTeG9URlOce5ZeixT3Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70397123"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70397123"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 22:22:52 -0800
X-CSE-ConnectionGUID: nDQFxrJhRnGGW1xAAPXyLw==
X-CSE-MsgGUID: RFUA8rqtSLiyQOqTbOf2GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="212001195"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 22:22:53 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 22:22:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 22:22:51 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 22:22:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTKwUZ5Cj4tRO++fFBLBrhwwSq8c6XGf0GjZz/MLozppHOOtXZ+KlFEr+ixwQach5sHA5iQV7bAf4DkHGT+P6lhe83bGIGS+okiXbvnVWpik2JHbdEB0T5ahX6DBlBGd+nriwuCkdElCqR1h+Z3sh8UBOATKgNK73v95Y7QlG8M3OLe4PORszCUKW0YwAapmVRCR8dU266/2wJUTZUijsOjyKjyU0ka/50iINGx//DMW5YE2qViE9Ux1WdwUJwx8Kzz8/g/Rg/dkKRDbH7+ealhxdoYjY8kEx0tLnhfXJQWAlZCbkq7lEupBgfhXvHgyTAuSaCwOr0ihtiJsQIPGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vNTmQagNgMC14b91T0LXM8BH82jVOSX85Ssqkfjb/o=;
 b=v6CMKPonZuKAugKib5pNE7stUlCo5YiynAVp3Y40akWhqyyV/BO91YJow3jwXvww7zZZt5hyJI1OQBFzmrqISRjS0iye7J/F5Fk0O+v0l1233xY7pmbzvm1yKbOypqmhCtaHEXTG2c+z93fBfXROfkBLnOE1K+pKsJ4ciPiC4o/l3FFARMtVTPagteeTP69gvkdeQvcbwCl2rCiTy5pOxa3tmGZXnVtbwXMV6zhnbkDMVCbMO2Jov2G4EkVQ921xFm68PYA/M5YiaRZP0NfRI8ElhsWim5YfSx5V4NZ1GwFM6kzQm2bpx8BreTSxhZuPSX2LySYE3imN9vCwSRxCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by MN2PR11MB4631.namprd11.prod.outlook.com (2603:10b6:208:262::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Tue, 27 Jan
 2026 06:22:49 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 06:22:49 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2] i40e: drop useless bitmap_weight()
 call in i40e_set_rxfh_fields()
Thread-Topic: [Intel-wired-lan] [PATCH v2] i40e: drop useless bitmap_weight()
 call in i40e_set_rxfh_fields()
Thread-Index: AQHcb8HJc6KMWkkdXE+/RhxJZXcs/bVlynUQ
Date: Tue, 27 Jan 2026 06:22:49 +0000
Message-ID: <IA1PR11MB6241A70092AAA30A3671AC708B90A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20251218015758.682498-1-yury.norov@gmail.com>
In-Reply-To: <20251218015758.682498-1-yury.norov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|MN2PR11MB4631:EE_
x-ms-office365-filtering-correlation-id: 84c22d42-9caa-4d0b-4492-08de5d6c7e72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?4vLAEXGjFFEtvx+Vn/svkQ01Irb4gcAxWyA57lKihRIhIgmlMKvDnw8jSkuy?=
 =?us-ascii?Q?NERwJX0ErJNiWNRfpbC3UWtQYWZdG6w/HaVBC6FPZSp3nKduzQRlp7w2ncdq?=
 =?us-ascii?Q?AJsu/kSI4RQf3bUNHFUK4JnTOYyE9/+3uF3zvfIVYzlZSWqVFEYZkW41NQ0R?=
 =?us-ascii?Q?WVhbHVJSY55KuMlvXoLpxK0QnkYt9FzHspvbwtIBLIo/VQ64Q49esl45ilW4?=
 =?us-ascii?Q?vEqrJMxWHi9LCVymw4a7r0VisoThOkFfpNrkHqpVe2eTadTpVApQNVxy8vEK?=
 =?us-ascii?Q?P3r4iVt1eCX+zhU5/+4UgFJRsVqoI4pqjsJoFFB4z+lt8qb4Uatv8tDDvgZ4?=
 =?us-ascii?Q?1AR3dN24bAWAj9oW5wClXrsT07Toy/6oZN83LsiRlKQ/i7WYsMdngRIpgZaK?=
 =?us-ascii?Q?snUWljJ1kteUWnkTut9ppRPNSithm7Pq278knosTJs0wHRscS3Z4UNuubV+G?=
 =?us-ascii?Q?3R6/OmgHBY3rpR7NVB5n5rrC7rsUuHL59kdxAIlb++IGz2lvpckZfGauAtOh?=
 =?us-ascii?Q?IOXbs0Qo8cFG9YS4Z3KiL24/MBiGhn2l89/fq1TmhZZ5fPjPhgUUI7s2YJrV?=
 =?us-ascii?Q?PHBQzNEoYpyXG1SDGaISWFi6q5Cbc0pOoblbw0ZxfqJx4vcjcT/lFeR8JJrU?=
 =?us-ascii?Q?L2rrsw073dgr+IBToBArIYKVI/fCXdUwmZF+WW121fyl5nlMiL0X4LA1SdJH?=
 =?us-ascii?Q?M/HRMke95MccNvu9W4TpQoIZlvCrng0xCMafN0Brz93R7VOW5lpiit8N+FeS?=
 =?us-ascii?Q?+6xmY/B/7A+At+AVzJAQZBuqxAxHztjBJOx9Gfgki0uNi+UHK6UovgWDo4/M?=
 =?us-ascii?Q?Lq3XjJx9l2iGc1OplXJlvxPX6SJUpxMZrQZ88Sozozl5jXLJ3bFLx4D9hX5A?=
 =?us-ascii?Q?pc179upvcm5zwlTQ1dak+9IiwIq8mnsRtzapAptmKDvDEVHPIvAiUQsJ59Fc?=
 =?us-ascii?Q?O1nu8GzwC9RUpp7FPL1tdyJW+wA3U24VyYpV1zTH8tyr6wbhAVPkTGqSmhZe?=
 =?us-ascii?Q?v4MEvUWRa2yqu9M3Wv1nIK1PLV99IjaFxoozEcnAjTsVfAIPlwle+4IJdRoz?=
 =?us-ascii?Q?OEghl370Ye8wQSFIH5JkOwuok6X6SHoah5UbaqYimr4CjKHGsw9yS+1fHJ0n?=
 =?us-ascii?Q?+hGeO9d+VXqNQjVLnNjIteemUjke4vfGdikfJdqjRTaaZKbAL7aPG0vDKm7O?=
 =?us-ascii?Q?MLZWuJ8PgjOfytfcjbW6H+MFfOy+AEm6es+A4qYHgQaQVSdXoDoIW/lRrR9+?=
 =?us-ascii?Q?gZWGGl1KcztSUSqvWQ3qjLqm0rsWo6+X5KhA1uQ6Xvi7ClBRx9tdmUfKcp5H?=
 =?us-ascii?Q?qtC+tMnl2+qhTC0XbQJKBLbdx2pqv/0MnbSZPPtukKMYpexgyPsqitf5S6+f?=
 =?us-ascii?Q?s75+ymR8P2GyO03Pa1gPPjMEfd6SD24dWi07boZ51rnALFy8UMeCLBAR8lwN?=
 =?us-ascii?Q?yFONcDjQFkJPoge3PnckiBqG7jIhNkZ0Zpapk+TxpmV/mZ0NMA5hu/lM2nAD?=
 =?us-ascii?Q?Kj1ki3AyEEN4DXa5vKz4mYXeatHBD5Ekmol2zm83IJaVuYo+Ietaj/fheC/v?=
 =?us-ascii?Q?G9wCKigj09PHL+9gIHihUdq5ViVpmK++gtZ9bwEJQvteohtSwd73iBQbo7cD?=
 =?us-ascii?Q?PjO9t2e8p7DuYdd228HvIx+rCZeKTaBMSwRAgsw/9nND?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i1gLeB/yoSvfvOS8xJzmPSiedI6w8zwX227ExBpcjYm/TP31elNo27YGBSuu?=
 =?us-ascii?Q?lsYjtYUkjRFILnJ6ZUctZeXTaxQOT/kpwEoD3eNuPj2BhygbfY/wn+MafH2C?=
 =?us-ascii?Q?IVqUpa5vyKUzV9BgBWzXWBrJ3269GwTZ+ut3PS6+XXCkaIZiK5tMCiOq0ck/?=
 =?us-ascii?Q?zr0W0RZkgysnaQDGztXuvnQHSrZvumL60B5CnzEyWmTgOlHFXNYWUR6uyWzQ?=
 =?us-ascii?Q?4M5ifPtx39EVGX3atONGHX0qU2h4+EvCbukbDjWD0/Lf8f6luiQd5r1k9TuX?=
 =?us-ascii?Q?8Dmu0W+tNx8NDlFrX7cp19bd2u1YD1AwNtYhx5akg3RXMxNE6ieEQo04q/BO?=
 =?us-ascii?Q?Rl7dfWH58RiZcHNEtfjSvuVUS1rVG7VlaohCLPnz9fTBSihoMMHlMnyrNRGI?=
 =?us-ascii?Q?D3+1XLV+DoOjeOBMUapo9h20rJoDzWsyPBzFxV5lofbsvd16CO8CW5Rcv1/y?=
 =?us-ascii?Q?Z6ARXAXAjIrlB/VlvZlk/wnFgD7aGEYeM8cN5qXko545qph/QkbY5PkhK3Xs?=
 =?us-ascii?Q?M3tAN1nLpiEsXSxL2ktb8xYpC4fuL8F7L0cvnYsFeWU4IuRuBaU+XzkCyjrm?=
 =?us-ascii?Q?bgBzMDPENEYxtPGRIQta12p1APzzIdjCOAAU/9EdmTveeHlibYxjzMoEmXU+?=
 =?us-ascii?Q?Z1yRcht7xsgP6Fha2jHmT28SrakvMbG+YoVYHeIR/Zp8TCddQT7NPM6jlYvI?=
 =?us-ascii?Q?iVV5K4C2s1LUmYbkt9IGJr8xJt83RbzA841TDyQQVA0AEskmf8bOo8/p1kfY?=
 =?us-ascii?Q?a+eBsAP2/a8sakmyhOnwRa4gyTLToZ5zuZeDKM0hZsMs0ghLUGjdrXpy0g1z?=
 =?us-ascii?Q?nWh8iRjdw/ObXgwt0dLoaJV06FyKBhRfuBN4Y/kXy1u2w1WSFLfNtvHFRSE5?=
 =?us-ascii?Q?loayJDh0gtxlVVNT8+OyjI6hiioGIv/GzKN2fKOQiCZHGPXbaCuvuIjkvh3U?=
 =?us-ascii?Q?KCGc2cLOru87f6n9+ZeUAmLijP/8EcIOe1Gyf0aBgCq4IkL/F6pYl1pLlpmZ?=
 =?us-ascii?Q?n7iFYVew6yzCcAsSOtC2w2Lv7ojWfkAs9LAF3cbKJpZGEZrKbNZVpRwTlCvu?=
 =?us-ascii?Q?W/KFZOiaq3s2nlt2wxo85UM3kgwfYtCeUitYFW6kAF541cnu28KVRhZPABgF?=
 =?us-ascii?Q?88Ob8uByJy6j1LPa+K+fJOp4SBt2ucIFiLvYEQ70SwXve/dwB6uZv8sAmBL6?=
 =?us-ascii?Q?yETW0P164OhdiA4I/sxLstuqplLxoZixZPeUojqDZkWIkHoQTI2N7pY8AjFM?=
 =?us-ascii?Q?T9TjMrA54jG9yWc7qDHCLkn8EJqHisEh+RTk80RKwJj1T8Bb/IRFc14sQBc6?=
 =?us-ascii?Q?aBxEbhjSfSAvMdHFPiLO5C/d36I6RyM5qkDfNBhWJwP6dM1T7LPIV9zb5C5J?=
 =?us-ascii?Q?X+liYP0pFnCCfipaSckFiQOZQqOmfC71k+xCThNKLEOtz9Y3G2Cjuhsx2IlA?=
 =?us-ascii?Q?TL8MihSoLqyGpxtXzzYEWOIXAaIaszeMIX4hraH8cwTu1AgOdAHXspSsC75y?=
 =?us-ascii?Q?PO9t9C+nAMWRLO2sOHhjCo2MCE74kstCas/Nswo2/XHKv+5+4Na12qmZkzZU?=
 =?us-ascii?Q?1f7KFN6qReXOUfaZHyqHLdj/qQzw3Uz9lffBHd3lVzzbvGIABvs0cexSqSE9?=
 =?us-ascii?Q?usOLk5/TqdBKDUxO79WjviK5M64pKYGYfbb+SKDz9LiDgQPkdLuvfnKjuwPQ?=
 =?us-ascii?Q?RyTEL0E5rmqfKe2gJLgx84kOngSDhsKC2nhQyvrbJ2ShN+bI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c22d42-9caa-4d0b-4492-08de5d6c7e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 06:22:49.2317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZaBX/Z1MQ+bE+He9z12GBCnDRzpZLmsychu4U/5ijXChu3ExqWt6NTF6k/qltZ2p279qdq8fot7mUvd/zrw7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4631
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253716-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,lunn.ch:email,davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2C09B905B6
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Y=
ury Norov (NVIDIA)
> Sent: 18 December 2025 07:28
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-wired-lan=
@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Yury Norov (NVIDIA) <yury.norov@gmail.com>; Loktionov, Aleksandr <ale=
ksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2] i40e: drop useless bitmap_weight() =
call in i40e_set_rxfh_fields()
>
> bitmap_weight() is O(N) and useless here, because the following
> for_each_set_bit() returns immediately in case of empty flow_pctypes.
>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
> v1: https://lore.kernel.org/all/20251216002852.334561-1-yury.norov@gmail.=
com/
> v2: don't drop flow_id (Aleksandr).
>
> .../net/ethernet/intel/i40e/i40e_ethtool.c    | 21 +++++++------------
> 1 file changed, 8 insertions(+), 13 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

