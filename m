Return-Path: <netdev+bounces-98141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B137B8CFAA9
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC951F21141
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9465136120;
	Mon, 27 May 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iztzIh2O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB06C152
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796663; cv=fail; b=YTqeZWIcHJgpt4R0dR1hvlpxlDPorKm0wBo9MHMff9qtvIf/3Dd+iTviY+BMyiNsVxYToWKThgvBAcGVoZFzz/IWBh2TfBRvCMdRRDt90PumTfB/6GY76k5THVFU67aoeypLEmJWuXUwjIaNG+q04wjB02V6cyhiHqroFMgre4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796663; c=relaxed/simple;
	bh=oMHFNosBcI/wdZJrve5wtyGbw49TfKeM2/WPNiiOFjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qGbXvaTLsm5CbdpZr3YJ856S/YSUgou5H+pt8P8+5TR0Cppk3YRihwbw8nif3x0N4en4E90Xc7U5X6qe2S8Q8+ChM3wQMau7coRZ41Swc6sGaxz5wzOrP0M0ksQIUKg4gHxssRi3xoS7iUFJT3/bHvHuuKaCe978huXxFqTjpak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iztzIh2O; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716796662; x=1748332662;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oMHFNosBcI/wdZJrve5wtyGbw49TfKeM2/WPNiiOFjU=;
  b=iztzIh2Ok91S1doQxPQCKqJahos/XQ/CPhVGYGPgUG9quiDWIHrgLiib
   Mg2yigWDO+qcHQC6gtey0xhAleix9JedNXKBC/dlFIYGXsHK3WOgjBiw1
   j+OMccdjaM928xHbMH5+NiGywhbbABiKbnUmHQte4Z9NAUeKaRaXpSxhv
   YrxX/XBQAew7BkA8OWtzMVX84Z1NM/0cUfQ6qnoqEhqvE3nWPQ4qKsgG/
   Q65JDcBrMYQ55SlEiWhyId2r194kTeiLdNImk8w3WreCrIoOs4fdwVWpa
   EQITZZZkjgqx/YUIras23lmabq+w5bmpiJOgVApHfyVrn1ZbNNG9ZVvX0
   A==;
X-CSE-ConnectionGUID: T9lGXQldTxC5IJCjuFOhLQ==
X-CSE-MsgGUID: q0pa16fpQ+2KCFbLdEpVOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13219413"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13219413"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 00:57:42 -0700
X-CSE-ConnectionGUID: zVkD6yCSQVqp7s7QTofnPA==
X-CSE-MsgGUID: 8sdYkpnxRyWKBmQWxo7Pqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="57878447"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 00:57:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 00:57:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 00:57:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 00:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCsMIxzekrCbJoG2UHP1xIpTmSs0NDZAuzo5E+vzg/enVP8HVmMofOpuKOP0N5wg+bpAhrGYjdp0pN5aHdDTfK0JFTaxPoUf7VEOM2dmMGA8EvwxijjrvSUNnH1++dzyp4LWimIBAUMi4YzOLxnt1LIggieUrlA2s0XtdANnR8LSPvd+VFuU6O3TBCi5j4FPDOmILqCSqFrzFbmrUKL+xe/CGw0RTZFZHxxlpGwjXh0FZicmOkDmRRDTBjtye73sVdX8i7JFKMIE7oYgquMzOmaDkUB870LJc0bU+k47n+cCcpeX5/ab7hgxDqCj8pTiPtVTEWl48KU1m0ZbzOIbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JboZymqMVSsm5F80ih4W4ancs9CPiQj1CghJC+Nxm00=;
 b=bBDRJ4ef4VyCXrDiGrYzpKyvF+nNJfcTnIGFogwa8qUNAaVu5RJhZPT6iDrXEwGbdITuY51blFOrxEhk1QcbbkqmogKzH6J72uZxycugfqMGRz+c8Jq0jTzr8dI2E8vDXNu4ANDI2XE8BCm90AlXc5UKYud2t7NpIH9OBmcn4aTBFWI0L+526GN1SAaxsLIfU+V/kXOEedl5ZpXYFGGu59iGf0tfkOh7JOL4QCce2f5FAoqaeBMHT+P0kjxE96yHW7J25QUVUe/Qjy55OgplfYBKlkKRqtfl0n+eL+j4HyDKx8vwoepp0yT1sj0AP0AhxYqr/7TucB2C/LLKleZEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DS7PR11MB6248.namprd11.prod.outlook.com (2603:10b6:8:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:57:37 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.7611.016; Mon, 27 May 2024
 07:57:36 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: Michal Michalik <michal.michalik@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v10 iwl-next 09/12] ice: Add support for
 E825-C TS PLL handling
Thread-Topic: [Intel-wired-lan] [PATCH v10 iwl-next 09/12] ice: Add support
 for E825-C TS PLL handling
Thread-Index: AQHalky9I8cYIHhto0m5BEpZUH59K7Gq6hvg
Date: Mon, 27 May 2024 07:57:36 +0000
Message-ID: <CYYPR11MB84296D8343A1B877EFDDAB24BDF02@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240424133542.113933-16-karol.kolacinski@intel.com>
 <20240424133542.113933-24-karol.kolacinski@intel.com>
In-Reply-To: <20240424133542.113933-24-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DS7PR11MB6248:EE_
x-ms-office365-filtering-correlation-id: 13277d5b-ab59-4e67-872b-08dc7e22ac87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?yLEqnQaiNXJewZpHAS98kRw3vaX4M4iNb0cf+KdXfSwd/GkwAM3ZuBKCOMS7?=
 =?us-ascii?Q?LfX7SmxaLjORV6lIxMKNFDQdUghmZ0+gri9rh0x4BngbhGPo5SVQRchiTuwK?=
 =?us-ascii?Q?sRkb+iwUW6YyWA25tFEHmegw56gsY0o31WkOnU3mzoEENECSZj7edqLDupRd?=
 =?us-ascii?Q?NWiDkwwG7mgrigWW3sgrY3KXvYAjkb0cwfAqaYTvPB9mGiSdqzBv/Ton/ICd?=
 =?us-ascii?Q?9P1i5Slg1q4BIioAreVAvtGSL1s7iy1Yxiycys/XEIU+u0KLPeuhwbGpAjB8?=
 =?us-ascii?Q?7rJe8TntdNA68ICBn93B/tK05yFLPH68DDX6lEacdxCoAYAD8Y8+IdI3UIx7?=
 =?us-ascii?Q?NjvfTJT0sFXPmVunREXQpYmyhfY7MFedeAbt+g1jyb4RZL4aWrVTbkFINu+y?=
 =?us-ascii?Q?znZlwhf9JacSN9kQ6tZ2GQP4THwj57pUte++xYFaYMrtGMvPbSeR4Gz1zfDC?=
 =?us-ascii?Q?plVqM51LobKMZJiMxqyVgw+TgxzetGfuLxi7RiymVPD9bJGI+9l/whcg1Zjv?=
 =?us-ascii?Q?rtQstAcEh6hBJc5YO3qc31tMDUP8kmdz5SAYB+YD79/qr0S5tJVAuc/NcoMX?=
 =?us-ascii?Q?JbLtkLT3AEzt376Qz+38+tYQy+IvOXpCRMo+NkdzZWIqRN+cx+AdzOmctVp8?=
 =?us-ascii?Q?mxRxQiYAyWo17h6xN7q3jPxmog717GdoRnM4txPMm16VbxjdXrQQspjp8rwQ?=
 =?us-ascii?Q?XMLn68aBTmzGFIxta4TE/ynkiRU2ormppXLnhG6Oo/TS8r06trVrvuqL0G+z?=
 =?us-ascii?Q?owkaprdlrWgkOGSN447qGd5vbupC6ZFz4K63xPw9ydFuQJ6KD3mfxWxckRaX?=
 =?us-ascii?Q?lYXA2tnECxQOLTKaaETUyC7lhMPQ/By2MY9WjrngaEbO1GxCbMuKoFj0Ucen?=
 =?us-ascii?Q?8sa48Qzj1nMFzX0Vj3+CFN1ejJSTty+GYfve1qjSVdwxCvIftYdbpz72Pk66?=
 =?us-ascii?Q?5fNjJuUngy6DLFJ8Vo3KI3uoA/tG4zMmYXlPCXT8CQCVS3C0+96bZ7zC5saN?=
 =?us-ascii?Q?5Lp3nVa75cO3QEzS6jVZvBnt+6tZUY0VSCS6w9QjRTtls4LTtwoQoF5T/XTk?=
 =?us-ascii?Q?aWh0e7SiX99AwFJo1KaSgS+q5uS/ov3hOz9urPOLoOyUBhepc0K3Q2YoxcWK?=
 =?us-ascii?Q?9e/EmRgmFwnag4Way9zzen2uKkGEHdtJ0k/59YrOVwdxCHaZ2rtJYVt31OAQ?=
 =?us-ascii?Q?44qMeBeP8EHSz42dVOOZtM0rxNEt20X8VbY1U4Ci6FVL2su6vEMAx+S1HSki?=
 =?us-ascii?Q?vDTykJ1QSaDfRkvmIgcbqJ6eHbZhZx1vk2PYpvfxSWgUEELFcB1GtT/YANlY?=
 =?us-ascii?Q?Qgfewr8eD9XhI04QF87imqaclOfBBBa9jUQtly2LpSJ1bg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2RVxS7uQu5E64Lmd7quv16Po+BEAkH2VjAm3CJTDi1LowxSDsA//VNjFwvfO?=
 =?us-ascii?Q?iOPBPMv7YH0G1OUPPJdLluYTzDVb4zhQTGii9KFSzxjDUTlTF0kqCFojW6sJ?=
 =?us-ascii?Q?1OcA7kwozOxfeX6IStP0nvu30jN7kfZE8gWJeNRngF+C0AvjMhyhXPR7eAko?=
 =?us-ascii?Q?8of4ByRjX7dv6JVF9ahgzAfxbnflF9tnMd+3baIyLdAWU9eTL8jDm+rktKkU?=
 =?us-ascii?Q?yt9Pxyu9R/QiGFUbTb1AGsw0REu73HbjeST6N0i152sCxWvkymyvz54okqiw?=
 =?us-ascii?Q?SY6il8nEZA8i03W+KTipHkW0OSUBiE4lHal0mPQ8Ikc7bCO/sG0Te9L+EaK7?=
 =?us-ascii?Q?9XT+IgTvmBoFRxb/Oa87p64MELPv6lVJdaBsEsMGUEszzEr5EPqN6NSiKA4o?=
 =?us-ascii?Q?UVscsCL+fXlQqhaWuWBus1p+reHgdAb7zoEtQq7dGM/dhpL/EzxnLqDz8QEf?=
 =?us-ascii?Q?VvZo7Aqp6Bnkc36V7qvUG36Q4ZUocrPqSW1IGMdUvWKWExgVPaJ+rTqtTCFU?=
 =?us-ascii?Q?bvniCVSph0v6UhzwFOgs9XdQPcM4qk3aRXW1UZE9wThfnN3y6VhfARKD4iNf?=
 =?us-ascii?Q?wPyQR6DPU1Y+UjBoj7CpE15ALWJejEtINlYp8xX8dNVHAP0YUV8hqpem7/3k?=
 =?us-ascii?Q?cH/Hil4TEdePEhxarh0rt99vFZ5Fwa3go+XPalPdWseDuOPHCbwgtWOFoqcc?=
 =?us-ascii?Q?kyud7cufjVoLzz8Xr9Xb5x/g86zn7yb9R3UOeJ7xHo8F2WQhFiqkXDotXEmC?=
 =?us-ascii?Q?xaccD+4Pb1MvUJ8hV9vTHHxDCJutIMFZ+NHoRukgn4FoJT0YGT8oasTdehDi?=
 =?us-ascii?Q?v46sYgu2RAF7q6jnuD4LL/smkPBym9XNJtA5+b+pZeg7tysCi6LpYr/6gtdp?=
 =?us-ascii?Q?S3SUl9q9YCS6XT1JQHjBQlpc3B/6yWZvRZUArs7JrDJeGln9SHXFRAmdcneC?=
 =?us-ascii?Q?QoQpWx6Bv7ObsIgMLdNXSKmATbc86m+rY/wXixEwlr9s/ixvvcgbzuPrKx6O?=
 =?us-ascii?Q?bSi1YtI910wDDF3EY8M7HTvD/clz9Uo/QlXczmyc0n4dCo0XmFr+XSEC/fQ0?=
 =?us-ascii?Q?N5s030Taff7gmW79vq43Tw0/5b97h9hsSG/l7D5NvdgKTP/F9lv8raQnA4TP?=
 =?us-ascii?Q?amL8cF/fwdky7TGZZgA6R4aHKmtaa5clQFxDApDp+Vq1DLYQQsnJ9Ufj7bIi?=
 =?us-ascii?Q?n6w8uQEgyZnDv6HmtSxumvqux1n1/Ew6Y7iPynVbps+FmTh4NeASTFoCtzCL?=
 =?us-ascii?Q?K4tuSmh9C0QrUrrj/+M75wJHl0nlJrEOGqdiMR+PuOO4z5w4uENiMT1ciKzo?=
 =?us-ascii?Q?tI5PMT0lVptuqXkmskkomosd//VV+QrJe+eIxJkCwRFO9c1eLGp3NkCEH6P6?=
 =?us-ascii?Q?XsFqTs9e2PAuZ6AuaT/BhEMY4g/EsZvkBwfyYyblKemhctzHq8UWhVVzwJ9b?=
 =?us-ascii?Q?qCUUnWyHnsCpAi4HZ2ahWhxHcGV+9xZLh9fbbCA9HgSimCSRmnXZAtrxE8ks?=
 =?us-ascii?Q?sGxoybWToz7NXt22n7hHYIO043DowZpUA6Zt0Jb8xc0loJPuYruxElHKZoQb?=
 =?us-ascii?Q?4fkQNckC/0bIegmzsSGIsynXWMuxtNFq7o1XHYWL0OmVJGnmD3DLB49VjDeF?=
 =?us-ascii?Q?KA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13277d5b-ab59-4e67-872b-08dc7e22ac87
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 07:57:36.7705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xd/Ow1I/L4PvNrUw3Yqg+/DqtBjnMPMI8RdYG53RzXiF09aAd3/g6DJtk6J9/8lkXza4R/MAuP1T34Qhz6oaNoTZvAqr3NMXwvFTkWlXtFAkcFJpTUQ9frefDjoVhAnS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6248
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Wednesday, April 24, 2024 7:00 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Michal Michalik <michal.michalik@intel.com>; netdev@vger.kernel.org; =
Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Kolacinski, Karol <=
karol.kolacinski@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>=
; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH v10 iwl-next 09/12] ice: Add support fo=
r E825-C TS PLL handling
>
> From: Michal Michalik <michal.michalik@intel.com>
>
> The CGU layout of E825-C is a little different than E822/E823. Add suppor=
t the new hardware adding relevant functions.
>
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V9 -> V10: changed 1588 clk_src and clk_freq caps to fixed ones for E825C
> V4 -> V5: added UL to some of tspll_fbdiv_frac values in e825c_cgu_params
>
>  drivers/net/ethernet/intel/ice/ice_cgu_regs.h |  65 +++++
>  drivers/net/ethernet/intel/ice/ice_common.c   |   9 +-
>  .../net/ethernet/intel/ice/ice_ptp_consts.h   |  87 ++++++
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 261 +++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  24 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   2 +-
>   6 files changed, 429 insertions(+), 19 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


