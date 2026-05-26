Return-Path: <netdev+bounces-291618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIZpNOpsFWoIVAcAu9opvQ
	(envelope-from <netdev+bounces-291618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:50:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC15D3B3D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EA05301324B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E5B3D75B1;
	Tue, 26 May 2026 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjC8hlqI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2943D88F2;
	Tue, 26 May 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788619; cv=fail; b=s+ANJ2wMFRNQJg/UjCKg7tpXK/kVwwdr9e9US6SVwli3pB3KI7zE//8SQB+kiBrNCwuwMj+JdoG1J0sPym+o86yzjZK5HlA79eLiAnKmq3gcTYIVrKQLGGuGpDT1Ylha0ERkyoG0B+BylJ/oACvwtx3zfEPFcBVZLm2ljEnfVRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788619; c=relaxed/simple;
	bh=OsjjAKeu22npnEavCWjHROB19ht+lwcGjXPV2S3w7os=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C2TL4vka+H5AebvM/XOLNLKgu7DJLay2eCoJ70ibnsWt6ziLP7BDNTDMEd57nDBMTu3pA3kB4E1uVCIt285ONWkMXc7jVKWxZzsxUAKMeWesoAdTg9fai1LLDWALJwlPY/qP/Xf1MkRqmbhNmNIO8aA0vGZ83D4pd0Vl2OLjqxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjC8hlqI; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779788617; x=1811324617;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OsjjAKeu22npnEavCWjHROB19ht+lwcGjXPV2S3w7os=;
  b=bjC8hlqI4sb+Tcud21dPg88AotO9oxE7YiGkiWFsgrG1D8lyGqCJZV0V
   WOLlXfnDJxRqetSd9b1Fcdw2tAwKVptRqxamHDbiC/bK9sF/5pFOmhhf9
   98we7LtrUWIS74SvFXhFhrnxDOAzU83lIXnX+BTkN7kq2C3Mq4MEtSfqj
   1noA4cyUpvcnVOkPlLYQjp3SsNdEPwSrCxC17fdi3gGYeZAucCedCmF0D
   T0fXhvrQMA08niF1GeQ5rHbdV9Q824U26cwriUUNHpdTy+ruov5U44+5x
   H0UCcQR1JgmYfAXQqDCSUr7a5NSWf3UH2mNlejV6aMe3ZTbLfLoA1ABXZ
   w==;
X-CSE-ConnectionGUID: 7Dwopxh1QGmlvL8Y1Sio4A==
X-CSE-MsgGUID: KU/d3n+6SF20ps98F/2/yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="90897781"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="90897781"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 02:43:37 -0700
X-CSE-ConnectionGUID: ppMs3PmGRe6nPrmAVILftA==
X-CSE-MsgGUID: jxJr6EXcQquf4zupiso8pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="241027852"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 02:43:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 02:43:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 02:43:36 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.30)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 02:43:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zf1VgS4DPG3vfo22OEvDkkoSfPKqPde4bc9MFE6u9ntQsFxYxKBYx6XjLNfzciR4S3h/AmcTT8O0+CRPRRxeXNhRJ8pOM/kZpw64CXppMJyy9RkrO65iLmGTkxqU/muT19k+OAgk5kPfrCoFcoUJJLOlWFzb+pxNtWjoPMQsxAXvW4utcrOm9EH8/OXKf7eGBrA21b8bti4qjQkDpAUYuTkXRhlACbwYYPGjdvhiUV54YaqmrRKUxiWa8SdVL/mXcGRVFxhKjJMjs+uDNu1F3mdeTZjuXLvPfEc7s8S8iaX+BzUn9coILONJ5Q8CQjouLugDZEx8980MZQxXwUFBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfUSX1ZF/tRtKx3FuYlujgrN+h8R8NQFkyMmGMz9hsg=;
 b=hJcBnTVWp3pSYe4rWuHK179fzwC3qGDKStRIJRAc2ZNDqwd8RE1qlLVk+ad5KcO7OZinOeywiKWsOsdVRDfkRwpV1YoVXVZ0BJMYHbAB5VYFpefyyyMn3ELX6cfOl+mFZS3ina36ImQLwkpaxveawvOrqcvogamt7OXcdA7YemO4Y3eKaCMI1MV7jOCwsFism7Ds4CHesOmbyhukPrj+uF1bXPIoHinL4AEH4HDRZ3p24tVeBmxsp0VQrhCPRv3A5igEaHs76kl8WG113Ef0XD1V9fVTzGjc3N46/S/8yXpHdRUlIa1aad1CDgWlCjmgBwbAVGxJUkxruKsO3VFY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SA3PR11MB7555.namprd11.prod.outlook.com (2603:10b6:806:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 09:43:25 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 09:43:25 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "edumazet@google.com"
	<edumazet@google.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "horms@kernel.org" <horms@kernel.org>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v10 net-next 6/8] ice: implement CPI
 support for E825C
Thread-Topic: [Intel-wired-lan] [PATCH v10 net-next 6/8] ice: implement CPI
 support for E825C
Thread-Index: AQHc6DzsQ0uD5J3Sm0qO3G11Gyv84rYW13YAgAlAFoA=
Date: Tue, 26 May 2026 09:43:25 +0000
Message-ID: <IA1PR11MB62198492B4715F12BA0D4745920B2@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260520093628.3930705-1-grzegorz.nitka@intel.com>
 <20260520093628.3930705-7-grzegorz.nitka@intel.com>
 <IA3PR11MB89866BC0598C6D63E6D071CCE5012@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89866BC0598C6D63E6D071CCE5012@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SA3PR11MB7555:EE_
x-ms-office365-filtering-correlation-id: da02df78-5cee-4391-72f2-08debb0b3b9d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003|3023799007|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info: AB/FbTK0tNzKciRc6E41S7Q1JmOjqcrA3dAAezw8nEDmpdo1WzFvIH9BXBYd08D19Eg+6POv2O+B6IpM7JVRCq8hlwIHoC676A68awkAxXq6n80QL611LOd4oRJwK3XoNBGQd8MM84BKn7ATBVrI55R0+W+hNbcKAZGnTv/+hKF0bJw39pl1wZzZw2I1a2FEQCkwkk4KgnxbjKIcN9GcYb8k4kx8eZDvCHtOsNNLWTIzq606kaqRGh0myP73UoSm7liel22W4zWj2A+YYlq9sCMKnQxFaid6ZdnRjyijzmW8OUGhr/4E1Z14p+cO+GILveyVSfGcCNsdNyOUDoUSMF3NeiiKvjol2kDatlYX2Gf3utsNGblo6Mf+y+OP9vpPGhDhQWTeEhQ3ORZzPFtMHwO3gmkCYaCuZRPqNqm4ZDpnX1waOQBJn5QTG3r4GiFA2/WCH/bJuQTzolNhZs60OtNYJpPj9UR6i026s8oQKgalTfB0s5ksY1N+yXAaBa2ol1wuQ4gxG+97hhNVMcrjM5lptoCFvYc0i2WDEtgx2mVyVL/z2Uc+orCJkaIwyqTcmJRoe027UfQ7o36GI9UifVsQO8j+d3nJv9VWgb3nS/JeaLspWzwfJKKHP5DaYc/eMqPJn3h4/fCubVrJHqvxdu2UUAfBk25FO+n68nZKanRGHep2MOypDADJHRYiAkL5qgKa8wKpEwu5+C6pCdIOUla3Gn0HVhppJ1PEV5riBnpCPHJU7whH3bNxgHc/FcKB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(3023799007)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vbFfZXBIkgrDyxqBlGWhUeeLslBCmTquXtcDZiWMtKzRpBAWFN2seBhjCV9/?=
 =?us-ascii?Q?s6rRpytFyPOyyxvA2XiaIpPmx2rDPdQ+IRQYQMYyzRjjk2hCbj5Idca0yX0U?=
 =?us-ascii?Q?RNQejyd5pEki0lEWzhB5n08Er8MwLNhT92K43oktJ5ajBV9qnicPfqjmD1Op?=
 =?us-ascii?Q?rtcjEG07JjQjSJEjEL+kXXGGcWD8tMQXxhDttaG/4T53ApuA/s/B/BuSz5ZX?=
 =?us-ascii?Q?3JBV9fxFmEiPsjWF/PzYNy16/jtBXI/TwU5ZsQo0Kf1GXniVfmpw2vBipfT5?=
 =?us-ascii?Q?+T3X9nCdBYddWwvyXty+b9XIN2ov9dIBV+j+Sw7906VQZNveI/Vvfm87+owh?=
 =?us-ascii?Q?DehZHA/HmQS9BtQ4UCk9BoXzgNSJs3w4ycQIbj1w0znpWBz+rO83AgaD93t+?=
 =?us-ascii?Q?QjlCcQnzKXRm1tCNyEEedaG7HI7kVBlFA8CJPihbkd3OeC92modomVBFcJ3z?=
 =?us-ascii?Q?Z1kkOVGzpPFtFV+7llbsaTeLtaF43t9MFO3y7ucbzjOr/DZvt9p09v+0Gtl7?=
 =?us-ascii?Q?sU9/dVFwkK55MGSJWewjlj/YJoERX4fnTxmff2RQ+2MnBHCWb523e58zbCBs?=
 =?us-ascii?Q?Ute/I57+gpREyuXGB+mL8EXkc+T1b5vfpRryZD9jTFJT1H5zf75JKDcHOe/S?=
 =?us-ascii?Q?kto9C9avvHL7gqt/ESCbpMOfRDCy/I7ZMO99o8l9QL20DFmp6ot6QkgTJajU?=
 =?us-ascii?Q?N6fHbw5wtL8nDzn+xqZv8g4CPJGap+BXJPkin6KxieNKzV5aE2rGUN7WjTj2?=
 =?us-ascii?Q?aI5wiPj4q3IhEWIcxD1flOIWzXWLFidUWmjcR69tUoGXaX7+MTY9Of8s2tag?=
 =?us-ascii?Q?/Cx0pPu/zGDPk4pFi2J9+ard2d9ypUwAeWjVYPbTPiRVKvcxrzgWU8s6Hz9w?=
 =?us-ascii?Q?9NMIkKnGepZ2nN8kpvaIG2KNtILJLC9VkmWqRUa+uKgjD8lJqHg+4O/wIGqy?=
 =?us-ascii?Q?Ig/lGMd5MZgjmGkqlX3iL2VY3OgTpYSlPKq9grKGM0sw6wLaJgaDu+wOI8Dl?=
 =?us-ascii?Q?LQGaw23CZmzXyRY7VR/H16odhqIuTjnOf7EHBue6H5rw+1F0/0SC8aE7VKRn?=
 =?us-ascii?Q?gHC8m0D+Zh4sXKE0tQcydJNVIaVBIbkEmHZ61dx/IFw35HL5D3hpJk7gkZ02?=
 =?us-ascii?Q?bmvbpm6mJkRazIhtjo8Sd7bRUppoEg7+YtP225I1TKpObwjYZvhaFhbyD/tQ?=
 =?us-ascii?Q?a3L3KRD94t5o0gZ9JvVEcLREM5kN0hVrlyjJJ7M9r9wvLDrxnxH/U20fa6vY?=
 =?us-ascii?Q?OgtJbBWxhDa4oZQcZiwm2/gtK4GOYz5pxGvlhcK73vtRwFjTofhKUZelVCls?=
 =?us-ascii?Q?/GUDoAjRiT3WQNJksGCP3ZLSdh91iSRvXfT5dHLzwXTtocKF2kKhY5qzs/uM?=
 =?us-ascii?Q?NEvfDQILcAlI/WBkmNDgW5f6P3HGSW2xRmBo2j1tQUn7UqxohQr2NtdB8n7N?=
 =?us-ascii?Q?6usQEZWsMCTLFTkzw1RQXSZQcbb/NbBcuSQ7W/u++QvwLORmrc7/Vczkdeo2?=
 =?us-ascii?Q?VIoNI9IUARAX1dOVUOkrWCCxg8hD83lrUyoTv5c7Ik7eNRSvJJ+7Ndx6ylS2?=
 =?us-ascii?Q?zHOLOUMThgqdt7GHwji/v630CywjMQtXzHfb3Xgb9xF4mZjnLEcfedVa6uHb?=
 =?us-ascii?Q?XEGITPMYloyocaObpD7wKXFJuHNK76eytrhCLMZo64yYY6nb6hK4UaJ13asM?=
 =?us-ascii?Q?GuVXtKs4k/hxpvxyx/ab6h6/BfN5bxVNOOGDxzY/A6Ucg+ro4AAIcL1btC+H?=
 =?us-ascii?Q?8fksmWDq8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OsojllfjFkuDAwOcohmytRontKjBL+37bC1p/3Ru+hVHt59OfgXJpmR2vSTMYeBW5SvkmCvIZNyVEGMGs1sMPZTbHcANkHakUJNPycIB6awYBYfiBFER2jqRUC2XFfaVzZENc/u9fr8yn3PrzY4GMAbD37YwyoKesoh0eZeOZgxPW0TUr5iMcH8tCTIVhwnHGSAT/CjGm3mADwrcZmEHJSAaNnNLyRW9cdFioxs2uTRqZbs2Um9/cu7A33uW3ErJgYX18fUixvWR7V1AwIVBANj/TvXYVMwLsZ9EaxSETBaHKp6n7mMuQr2Qyt5g0OHi9AQZ++eFphs2rw1dKwJ61g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da02df78-5cee-4391-72f2-08debb0b3b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 09:43:25.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vLdOlrKf7h1V5H6zSzHN4gCAIFIRdEwYMpIzS5dkM9nE06jT5Kyov2n6zl7KbL1owvKSpmaZ6mfkFs8asUbjwYMq99nK61NY+NUN23tBX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7555
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291618-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,kernel.org,resnulli.us,google.com,intel.com,gmail.com,vger.kernel.org,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 30DC15D3B3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Wednesday, May 20, 2026 2:27 PM
> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>; netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> Prathosh.Satish@microchip.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pabeni@redhat.com;
> davem@davemloft.net
> Subject: RE: [Intel-wired-lan] [PATCH v10 net-next 6/8] ice: implement CP=
I
> support for E825C
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Grzegorz Nitka
> > Sent: Wednesday, May 20, 2026 11:36 AM
> > To: netdev@vger.kernel.org
> > Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> > kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> > donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> > Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> > intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> > Prathosh.Satish@microchip.com; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; pabeni@redhat.com;
> davem@davemloft.net
> > Subject: [Intel-wired-lan] [PATCH v10 net-next 6/8] ice: implement CPI
> > support for E825C
> >
> > Add full CPI (Converged PHY Interface) command handling required for
> > E825C devices. The CPI interface allows the driver to interact with
> > PHY-side control logic through the LM/PHY command registers, including
> > enabling/disabling/selection of PHY reference clock.
> >
> > This patch introduces:
> >  - a new CPI subsystem (ice_cpi.c / ice_cpi.h) implementing the CPI
> >    request/acknowledge state machine, including REQ/ACK protocol,
> >    command execution, and response handling
> >  - helper functions for reading/writing PHY registers over Sideband
> >    Queue
> >  - CPI command execution API (ice_cpi_exec) and a helper for enabling
> > or
> >    disabling Tx reference clocks (CPI 0xF1 opcode 'Config PHY
> > clocking')
> >  - assurance of CPI transaction serialization into the CPI core.
> >    CPI REQ/ACK is a multi-step handshake    and must be executed
> >    atomically per PHY. Centralize the lock in ice_cpi_exec() and
> >    use adapter-scoped per-PHY mutexes, which match the hardware
> > sharing
> >    model across PFs.
> >  - addition of the non-posted write opcode (wr_np) to SBQ
> >  - Makefile integration to build CPI support together with the PTP
> > stack
> >
> > This provides the infrastructure necessary to support PHY-side
> > configuration flows on E825C and is required for advanced link control
> > and Tx reference clock management.
> >
> > Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> > Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/Makefile      |   2 +-
> >  drivers/net/ethernet/intel/ice/ice_adapter.c |   4 +
> >  drivers/net/ethernet/intel/ice/ice_adapter.h |   7 +
> >  drivers/net/ethernet/intel/ice/ice_cpi.c     | 362
> > +++++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_cpi.h     |  58 +++
> >  drivers/net/ethernet/intel/ice/ice_sbq_cmd.h |   5 +-
> >  drivers/net/ethernet/intel/ice/ice_type.h    |   2 +
> >  7 files changed, 437 insertions(+), 3 deletions(-)  create mode
> > 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
> >  create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
> >
> > diff --git a/drivers/net/ethernet/intel/ice/Makefile
> > b/drivers/net/ethernet/intel/ice/Makefile
> > index 5b2c666496e7..38db476ab2ec 100644
> > --- a/drivers/net/ethernet/intel/ice/Makefile
> > +++ b/drivers/net/ethernet/intel/ice/Makefile
> > @@ -54,7 +54,7 @@ ice-$(CONFIG_PCI_IOV) +=3D	\
> >  	ice_vf_mbx.o		\
> >  	ice_vf_vsi_vlan_ops.o	\
> >  	ice_vf_lib.o
>=20
> ...
>=20
> > +
> > +/**
> > + * ice_cpi_set_cmd - execute CPI SET command
> > + * @hw: pointer to the HW struct
> > + * @opcode: CPI command opcode
> > + * @phy: phy index CPI command is applied for
> > + * @port_lane: ephy index CPI command is applied for
> > + * @data: CPI opcode context specific data
> > + *
> > + * Return: 0 on success, negative error code on failure.
> > + */
> > +static int ice_cpi_set_cmd(struct ice_hw *hw, u16 opcode, u8 phy, u8
> > port_lane,
> > +			   u16 data)
> > +{
> > +	struct ice_cpi_resp cpi_resp =3D {0};
> > +	struct ice_cpi_cmd cpi_cmd =3D {
> > +		.opcode =3D opcode,
> Silent u16 to u8 truncation.
>=20

Yeah, it's 8 bit. Changed 'opcode' to u8 in v11.

> > +		.set =3D true,
> > +		.port =3D port_lane,
> > +		.data =3D data,
> > +	};
> > +
> > +	return ice_cpi_exec(hw, phy, &cpi_cmd, &cpi_resp); }
> > +
>=20
> ...
>=20
> >  /* Port hardware description */
> >  struct ice_hw {
> >  	u8 __iomem *hw_addr;
> > --
> > 2.39.3


