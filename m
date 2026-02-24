Return-Path: <netdev+bounces-260372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM9BODVSnWk2OgQAu9opvQ
	(envelope-from <netdev+bounces-260372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:24:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A97F182FDD
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8DE630D49EE
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F2364E9C;
	Tue, 24 Feb 2026 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMFfiBYx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCFE336EF5;
	Tue, 24 Feb 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917630; cv=fail; b=UA7Rvne0DRAE3cBTzLR7sumyBIvGC357lmkS9WksXndpF8MszS27R/ijYVjW0AHzTrFIyc5M0HOCaIJYI0wo7khsWHdjQcEOpsLkayIn8y0V5aGuUwgzfvws24HLLZ8EYpVWLk1zK8UD/QiKHylNRju51zj7/mAY0RtWrwKqcwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917630; c=relaxed/simple;
	bh=jrcxYW/Odg5C88AzFxl6T+rivIkFJosfTtsUMrvZglg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F6FUMrFPDs0HGr1TFF7fK7qvH7t+ROQMklj3/RAb2RpnkzcjqCI9lXSABVn3eZsfqZILIkj2uUbsM1N+4ayyHtC2+WfxmFFButfILJYMiuSb9Xj/ZRWKoi2MnKDt+L+PZk8LHHymUMeQdGE9zHS7hiyK4d0SxOXyX+6DlNjRYTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMFfiBYx; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771917628; x=1803453628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jrcxYW/Odg5C88AzFxl6T+rivIkFJosfTtsUMrvZglg=;
  b=OMFfiBYxSeqTmHcFOcaYT6h9gfhQArB7qYS/pEU4sb5UvfJ0/5hXJ/jZ
   wzMVhKT52XYdB0kZD2h2d7qFFKp+CHBIonrKWou0/0O91a5yISRpl+eAU
   Fx5ioIsNzxrZDwK5dw0cNFsq2FnZieviOk8ndLXYRJ6RF8XRRjMkXLhg4
   jFlNrKAdO2kjvYIHzaMdcgo8/hjMh4dvU0iEhvec5rD73AyeykwFF+502
   zRx9kEYqhRNns5mGKIY7g31pPJQTQXOgRzdIUHRhJtvXjEw4zaO3YSWKK
   zYxb1fjD/yUBPdBCnGufQI7EaPM7+qMTWrIoyNvMBQPu9tLMd3XOROszm
   g==;
X-CSE-ConnectionGUID: NRSdejlgT46gl8fCTucU2w==
X-CSE-MsgGUID: pcJEcDZwTaGbeFU7LDoPKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="60502336"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="60502336"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 23:20:24 -0800
X-CSE-ConnectionGUID: oisUgcNGRmSauL2khhBvJQ==
X-CSE-MsgGUID: zY/yOUzFQ0K3n58SAH5Bgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253543178"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 23:20:22 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 23:20:21 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 23:20:21 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 23:20:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjVaOHvWQwpiUYfBSaoMwrV19/xbR2EevuwTFzdnHZK5TGshRGiWcTWYRDP6IpXMLq4bk7iSOBKZvi9mAEC+xGq8SMW08W4or9lxeZnx/3LxK/nmEFDTbQttYNNOBBj+lCKW/Na6U4yTF3cEVkezPyIuyAlJjIxy/Vf4AZlafbQNUosyA36BJUd9nTrthlBD9+8Zpj8C43x2iv8Ud7+4TqUQOSRqLrhH1EWGvTM2XSrWlPoTMqt9PFWvPqT5xW7JEmG17iFfKfbbtgsS600otDF57NgoyoqzM82v8v7mLP1x0wlNthHejQZfxsToKAMmcAnvwupTA82SLIkllmTR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2CmehDXB23H/dZhcsSswM5mBVdbWvIbYII5UcQEQoY=;
 b=p0NpmeAGbgjQ3AA4WobxMXQH/FrC4lPmVswL9oFtFPAhMf0ndfnDn+UMoyuOqUpQxaQ1VczUX9OYwqhoig9SoiNVZv+KANerk6TQour1oO+OsC4UqBSI/yneEwzMEOyvk8me+KV673cgE+MKtaNrFAzKcltbnciwXSp0wQObbcW6XVfhP0I8fF4ALBCQdwQ7byUmw/qwSt+AXGNXnr/7Je002PpkpqMvoAPYFDSJ5J0hFivCYZCN86HKnK13zadZu/FsnI4VLchqIhohGLKLpmLvprf3uXM3do98zz39+mYg2/a6o+dSuW6pXV91eQAoHLwQlCQfgwa+rRRKMcVbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by PH7PR11MB6954.namprd11.prod.outlook.com (2603:10b6:510:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 07:20:19 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::b351:6cda:caf7:64a]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::b351:6cda:caf7:64a%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 07:20:19 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, "Wochtman, Natalia"
	<natalia.wochtman@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Burra, Phani
 R" <phani.r.burra@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 03/15] libie: add PCI device
 initialization helpers to libie
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 03/15] libie: add PCI
 device initialization helpers to libie
Thread-Index: AQHcV8kQlXynRrXR6kCyOaoCkwiF5LWSC/SQ
Date: Tue, 24 Feb 2026 07:20:18 +0000
Message-ID: <PH8PR11MB796566CC0EA1F0684330D234F774A@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20251117134912.18566-1-larysa.zaremba@intel.com>
 <20251117134912.18566-4-larysa.zaremba@intel.com>
In-Reply-To: <20251117134912.18566-4-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|PH7PR11MB6954:EE_
x-ms-office365-filtering-correlation-id: be6af487-81d4-484f-be5e-08de73752a41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?zSgm/TXg+SeErhnYto1xKH/V8YLU+GoFTGRmi/h8q4LiYDn9UFbG8lKDWe9K?=
 =?us-ascii?Q?2vsQ1bSUU6UM2YQ4XbNpQP1Yi1Z/oOAjNdmnHNM4ioHFg35OB0TKq0wcURSa?=
 =?us-ascii?Q?cNlaoulz0UpXJH6v2AH0JyJLUgQHB9+7TSWFavJy/Rx2U7b/dbUbbFHv4BYd?=
 =?us-ascii?Q?j8rD2G9KiIj/Cqw3QthrCg2dqd3tvVsQlyKTEvr3fR0KlypDaz1vfnKItpN1?=
 =?us-ascii?Q?QnCo6x5grZQgt8Z/gvtoFv0241l+7yVOMtx9AjTs6lOaF1A2SXi/AcBWm03t?=
 =?us-ascii?Q?U4yim8d0ddbd32ozQnUr7TNNVbvzuFV+877Uag7HX5OMWa8EKFsgmBk60rrb?=
 =?us-ascii?Q?bTZFQ8KmJivrkIc6VMuuBhqNC7H2Epnt1YvzTyi2p9voiZD0ZSVj14NTEcIw?=
 =?us-ascii?Q?71lasH25U9f6jb27L/qfFwm04RRdxcvE+MG4agzozgX1PQOnHArd3ePM5X1h?=
 =?us-ascii?Q?1nvZkoLj9NEkSIf6zky0tmhCuwbb1HSPKYrHxAffAtE+xoNRagpGFxs+vyQG?=
 =?us-ascii?Q?icJOIzgn3YEBqaE+laoREsF1mbhpaZMMIndWGyzteUEtvK5MbQu/5mmTFrCd?=
 =?us-ascii?Q?pWQutsDWaHg4uSJReqcWi5UfMEM5X+q5nhI3ATXXWljH3dnmBvmUL1PwKjx8?=
 =?us-ascii?Q?1nbvdH2GlAWiq4HNc/fZo544d8Ihg/F6unJNm4uVWPmxYd5LunAiXwkpWwQI?=
 =?us-ascii?Q?3h3qA6Tv9laod0X9Fk0uHH5h4onFJ7uSrrZ/dV3Yb4GTbY1c9cJ4QB4TEBJx?=
 =?us-ascii?Q?JsP7qP7Oa6uVkVWbhLBKYM1/yJbN2A1fOhfkxXs6q/MwmFuYhCUQoPURiumd?=
 =?us-ascii?Q?HIq6h8Uom9X72jmmZCp/OdBafkx2m7KqfHJu5YSp17fJlKjIChpo1r4D8Nx/?=
 =?us-ascii?Q?0x8VUgngYJZT0QPbcox9EG52Yjo7ZEvP3DTy9s2NX0LLDNs5HAEy0yv42AJv?=
 =?us-ascii?Q?hDBygFuFliJ2sC+JRv983oTlxNepfZb3l7jiEdeE9ZHQlqh9rCu/UH8F3Ngh?=
 =?us-ascii?Q?8jUB5yl1ND+CWJOi85etA47lUzLvbHiDzalPXiuo+GryDef/CuHhxzsrVq46?=
 =?us-ascii?Q?WVvIHglySR0gbN+uw7O2rnG170gquvW93BUZzl7xYJo0ObUH0P4F81DCC2MY?=
 =?us-ascii?Q?nmKwZobJR/qdxnzI7Zrwz4WjAn3H1sashvMgIJsgjDBw0JpkBAK1RJ3a9TsA?=
 =?us-ascii?Q?mvixNbecHKZXmF5sxUXZCLzda8XMf+Mua3x/VU7OcE8swIuVbF3wxFteowGG?=
 =?us-ascii?Q?7fUdEPVtJMgeRWK/z+XgVROU/cvK5guizJGKvY9/rmJgjoIxdw3JRFRhlmoy?=
 =?us-ascii?Q?CZx/WVm3idf+G/GUs3Y1h3D4AcksjIvGqrJ6cP1K/6O+69e99qc9eL3RSvpo?=
 =?us-ascii?Q?Di1tTCZD9E+Yxz1sXgtrgbKHR03sqLvoB0jkCQ7d1n3Wvt24Nt58PHm1T1Lh?=
 =?us-ascii?Q?MvQBF1XBciYf1wDcwouuNBjYxEgLl9P90/2aMJDM559AJlWWK9NettJD2Fbq?=
 =?us-ascii?Q?Y5ubgw70LfX/gtCXzdNx/pBIepNAU2J9FqTLNwFnPIPbIrgq5gJLfIPKNmNo?=
 =?us-ascii?Q?6Ve/9AIDEF7PVRHQ0PRWh3VcBPq9k/1UrzhUUtJuyjC54bbAf0pcYoPebsoD?=
 =?us-ascii?Q?04+W7wowGIlmGZ8czvU2AHo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3hZ/228PuW0Q+88PdJ4xPoGBs9nLrZqSG569LhAFuHuuA1Yy+VG5GurUT0L4?=
 =?us-ascii?Q?RN3pirWLw2ceHGsyfaGlYNf9p2CpdoUmEb6booevt4Y+h7xmG7wre3j13F8d?=
 =?us-ascii?Q?MfTdJsv7BWIaBBYoXC3ACIJW3k2zXgKxvCgrPq1N4eb3WPJJ7o3l9OgdVW/+?=
 =?us-ascii?Q?XB9MtT9Ht045/QcvcxpldaCLxY78whMQtA6TgOhMYiFZCCK6cE0cBVErYgBL?=
 =?us-ascii?Q?0bObjjxAIVEbAVM2s/3rfcev2IJ9itDlGlSrsD11R7IH7maVcKlGAFF4Q7jt?=
 =?us-ascii?Q?R4zoa4NMiMsWwj+Mg23DxWawiZnYlMwvERjVVVK6HDmZ5C5DMkonrF6uaI1s?=
 =?us-ascii?Q?OviPZ7CoSVGuminKuT5dM+XeUFI92GgnraXraQaqQvD3JRTxAWjKbrf4ge7N?=
 =?us-ascii?Q?rtC8mxZ2Eaq4k4JBKwLEb44TI8nsu/Ce22+1imqR1mMHbiMBICf8Uam0/XYn?=
 =?us-ascii?Q?nXHAoFmhAIRIcXfGmgRE6X8CYmdWONGUReT1CNBz7ddNc+mLhYsek7u0kw6H?=
 =?us-ascii?Q?npFjHOruNA7rTzq6bG4Wq0UkfMEPSCZzRCHn2LkzcxF2XdA+4xAwo2XQi6xs?=
 =?us-ascii?Q?H1I/pP/8C8yBor5AhVCuX1P1MxQTkpw2Xc2wx+KOfW8vm3OpSDplagNAv5Ym?=
 =?us-ascii?Q?nASc5eAk1zUHZrA+EdQJIuzP2ZALK8BZ6DWWqR//n6JX2AiQ83cW4BKdS+yD?=
 =?us-ascii?Q?GdPu9b6BDVDfKH/6T8aLg4H4KTy5buJN5YRlFeoNDuTkMTSwCtWniM0UwNhj?=
 =?us-ascii?Q?WttfA3WhcgrWmoB3OfNhw1b0YxdAkJZK17+AE1UdOw3TyI7x0bTlmqcEyOKe?=
 =?us-ascii?Q?bFfVYAH5Y3iD6FLe3+BGZSbheiRSa5sfrLdh5k8ovw077L+3CeU+rl1tuwfz?=
 =?us-ascii?Q?VLa9HV/D+1FISR+jrQfTwT6X5XLQg0iQr2uzYsgmjfkqwKHnHGAep61USi+F?=
 =?us-ascii?Q?IsXksJs9eShl6W6OFFCH0BJEsZujlwGKX6y5KHte620WTWaPfxib/SZ2MUCx?=
 =?us-ascii?Q?h6XcA8kw7qNeiIOaM1cqWEBPEYHSLRWryhR2vNrr30cNiRXshOSU68+p45a5?=
 =?us-ascii?Q?C1Ej+FQPw9YDKqkLStT5GmZZFOOGT3OdMZ80XcdpI9iymddtRzXIbPvHiBFK?=
 =?us-ascii?Q?QDuUEp3QG+iuhiJV5OyjBMciqrt5zKaUfi3cDCcReofhlDB8xbdDsu3wfFfm?=
 =?us-ascii?Q?2TeJ2AhNFZdCwJ5B7VWdm0kdkSAGCzM+MbwxmiahQnog5/j+apxOR5qFHm6n?=
 =?us-ascii?Q?JxKZv3t750DpM8IN/tIjPYdLBtGDOeTywL/vxd84kmnTtieDTUy0jk/WOPS+?=
 =?us-ascii?Q?VfuEXM0LRh+5+75GLna7httNfIO2bOtk+WtP4M5XP1KsbvTMIvI5iIw3utiy?=
 =?us-ascii?Q?CODCR1xsBlwudE9LmnKhu/hCG3AnvQGhC1H8M1ccYC7vejzMB4uzK6f93WDl?=
 =?us-ascii?Q?ln8RQW57Da6j1m1upZUm0wFZkc4qBzkFagLMXUvYDhLub+NAZLGPEqL52uwd?=
 =?us-ascii?Q?xtVhdUBEMypSDkNaKImEnfz2tGbigK2tA7CDgiQtwuPG1B1XOuVi0XoWwwi2?=
 =?us-ascii?Q?ZG9KA2NA8QYg4dr2fbA/lgw1qZxygjGW2QcIrDmeU6twLxRuEyJOJQ72pr8d?=
 =?us-ascii?Q?rxIjuTVxt1HobQgtsc/gIwAVZ5CbzG8hUn5BPpDsxNzcVLOdUFj1C7WbtiQN?=
 =?us-ascii?Q?jUJRCdH5WYodaiuighLKyObSsGU8AFL5x0ePbQ194d4q6ZPX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6af487-81d4-484f-be5e-08de73752a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 07:20:18.9886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lv/TGzeYFQ7xds3MzVzGQyWwE8bIElppXN/beeV7bscN2oPXi4pSwY45oqbMJsXEenStuUVTBSrsa+Rd8U1Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6954
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260372-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharath.r@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8A97F182FDD
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Larysa Zaremba
> Sent: 17 November 2025 19:19
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala, Sridha=
r
> <sridhar.samudrala@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S <emil.s.tantilov@intel.c=
om>;
> Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Shanmugam, Jayaprakash <jayaprakash.shanmugam@intel.com>;
> Wochtman, Natalia <natalia.wochtman@intel.com>; Jiri Pirko
> <jiri@resnulli.us>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Burra, Phani R
> <phani.r.burra@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 03/15] libie: add PCI devic=
e
> initialization helpers to libie
>=20
> From: Phani R Burra <phani.r.burra@intel.com>
>=20
> Add memory related support functions for drivers to access MMIO space and
> allocate/free dma buffers.
>=20
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> Co-developed-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/libie/Kconfig  |   6 +
>  drivers/net/ethernet/intel/libie/Makefile |   4 +
>  drivers/net/ethernet/intel/libie/pci.c    | 187 ++++++++++++++++++++++
>  include/linux/intel/libie/pci.h           |  56 +++++++
>  4 files changed, 253 insertions(+)
> =20

Tested-by: Bharath R <bharath.r@intel.com>


