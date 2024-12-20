Return-Path: <netdev+bounces-153648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341D99F8FD8
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 11:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A851D1897923
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 10:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16381C3034;
	Fri, 20 Dec 2024 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWPwfnoY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4A1C232D
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689215; cv=fail; b=GHQ3U/vgH4ou06BBV32tBPMqL6NG+/YORwfjlSdTLiDgZ2kpdbSfE2BTW/XslLuNTO8W6CaMhFlC78h8C+wVjXHw1G7hHUAsPZbAHILBjUdca5L9L5naj76WkaZI9EoweFaFQkG3UhJ5o82Yf3WhVirnvO6wn952uMZ8bG22r64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689215; c=relaxed/simple;
	bh=V7ccgNflOREI1HJs2mJsOXmdEMmwgCAORGiNl1uLDOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SpDLxDClSTQQdH8hU27dvguSEiTVlkIfqYXtCl9JHSgqWI/rou4zwgMAXnJsyyGfFsFeEuCxxKSdorCxoxn0U6nqi68rUmvxz2i4Y+aZ+XfCcGqaKQC4F41YNLwRYXYIOr+XUKn+W4fUpTcvrZF0jpl/ZysLx1Oj/XUwBhkWK2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWPwfnoY; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734689214; x=1766225214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V7ccgNflOREI1HJs2mJsOXmdEMmwgCAORGiNl1uLDOw=;
  b=LWPwfnoYGgbi1VEfKxIBIEqUCjoasQZR1m4Ycz9x8ihFQ+BLii5lBaoY
   oAjXqo46OeJgGE+YcQNFvwCGd/mgTL5xUPa8AFAnQVd+miXuRs6gO1rR1
   ALrhjUu24E0IL3wMD5vN16kNFNKidZFX+gWDLWgBP13YsJ1wZZOb9HK/f
   CflXOubBdIepUSk8eOjOOgTmAV7LtFoy/r7/Ikt1XrCDIrmXb4vMb7GCD
   TI+eX5GuJ3ne85CSNRS6fhRZGUpq/VmrwwJyV7i86JXlMkgmIMBf3LETK
   MfyIaNVLjAPJxYwhuGXcoWKKRWNv6VbYWlLyZtiIhanZ19D2u8DDVrqVF
   w==;
X-CSE-ConnectionGUID: Z5c8oylbQiifGCoSXrUnlw==
X-CSE-MsgGUID: s+Y+FW7TTpuDrEv/N3ptVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="39017406"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="39017406"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 02:06:53 -0800
X-CSE-ConnectionGUID: N4f8/yXrQhKSMqN4seb41A==
X-CSE-MsgGUID: DOEbvhQKSSiMbl0N2Ir28g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103457881"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 02:06:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 02:06:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 02:06:52 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 02:06:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTz3QUgydQHMttR1gfkb64EqnSt/hNDreLBVzdckqVwuymiIJpnRp+5noOGRf1usNcdxJZFD74u0rvYml9ytOAnPxQ6bjl2MryQdgIqUyyP6xJQC03RtabCqCUODBZkBrkiSw38iE/RAGbhEn4zsKKBNnyIPQf/JDM6BLpcPSj5ooYRk3TnnIcar4+1tbYVU2WBi/jpX/KfK0akon46BVDLP9LnLmz1bQpRvTSR6r7N8tW2QEtbiApo8WBkUpg970oUm/WkSbpZfHh/tFBMlksu/8PBpa7YY/mXQq6oCR6tgS70EfdOKCkxmPm703mXrswpcoBXeIEK9PgGzROTbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLMTMVVF7k+8Jfu0wCwARy7g8BC9Ujt+YOyfoUGkLqs=;
 b=GRASv9mZsS4oY/IP067rNCzQQQM2UXzurTG/OVWGV+6+Dj4eWRZnYL79y4Uli8iV9tf5GxvsLW+V+MLbEbLUNMBl8O2ucfXNSEEMkJOBUbybXgW4Evt0q8Nas/H2YQyYiGrmtCk1Oo0dxkF514rRNDFtEHeeLKoFQyMq8TVBrJSwe0mfvCCR3749EwyzcRM2U719QgQhgSsq1MTLUfuQOTyCLoc0bbLk05yQ/XkAPQ/YbXaieJ9gwoEWB+CVMCijnkkr9xTaYnvRERoQ5qacggwJPToyo9j/GA8fuq6wKBOQMHrC26h1hCE5SnEB0zILwJUGwXlFZVcfkjNHqd1hyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by PH7PR11MB5942.namprd11.prod.outlook.com (2603:10b6:510:13e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 10:06:33 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 10:06:33 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Simon Horman <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 2/2] ixgbevf: Add support
 for Intel(R) E610 device
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 2/2] ixgbevf: Add support
 for Intel(R) E610 device
Thread-Index: AQHbUU6qs8LHZMprskOQiBSSHrwlA7Lu6u9g
Date: Fri, 20 Dec 2024 10:06:33 +0000
Message-ID: <SJ0PR11MB5865FEF5AD650B82823106E08F072@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20241218131238.5968-1-piotr.kwapulinski@intel.com>
 <20241218131238.5968-3-piotr.kwapulinski@intel.com>
In-Reply-To: <20241218131238.5968-3-piotr.kwapulinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|PH7PR11MB5942:EE_
x-ms-office365-filtering-correlation-id: 83820001-401a-46d3-45ba-08dd20ddfb4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?abe5Ros4ZyJPMC9nyJ9k4duDKIlyECig6F5MiZAYC0ok8fQGRit83RhMGhoA?=
 =?us-ascii?Q?ifT5MMV17kcTv9YzkdfuySvIna4wR/iaXFPRB9jruuckSBrcy9UHufiFUpiY?=
 =?us-ascii?Q?lEypgj3coaDoxnUuPiy8M1pRToq97HuREyuII2+a/AZ/Clo65rXFtgpUaw/Y?=
 =?us-ascii?Q?rbPe2dDZCwBkfQoXPm8XOnQs1Fy7w8MIwmQuYBcgrsJeoL+KPschqZx0XUO4?=
 =?us-ascii?Q?U1kvKmzbC3SceVzfPtSShewhF94HneIGp5UZAy6KqZDRW7cXzEUttENAQBLm?=
 =?us-ascii?Q?jiT9ZonVG2yET2COvQFiHf1zGKbLoJ0RkNDmVLw7dtUNQIEyqIKzFpS7NDlB?=
 =?us-ascii?Q?34NUuZFwkvl/y/ujkn+9bkGhq4zY2+2Js4975hRQIviPJtXBzKr681y4lxT7?=
 =?us-ascii?Q?V8byTp9ScsunT3v/Dt0IkixpQUZmP9M0fT5YIEIkDKCQ6np1Uqk04btHvNyC?=
 =?us-ascii?Q?NSFxBmT/7qz1osisMhvHPkEeZspJzvOAW10NSwmhSY9kbtD9ETJaG2590Jnd?=
 =?us-ascii?Q?70Oyl6tMTHyglFmG6fL8RkrO24RyZtW+xhGs2dyT8PaoN8tRKkympW7oSspY?=
 =?us-ascii?Q?Es3Yl/8Yj83/EAZmuIyA5yzGbLOvGI3Z6UTw3E1Y3gj9flijtMcUHJI9ht4f?=
 =?us-ascii?Q?hR8K3JO6MYkOXacLiq73lbtKpbsFSX7BD6alCod3wHYDLN9CVzF5+DzXOvQs?=
 =?us-ascii?Q?Wdhsb+Yd8oJJ8llo7YJ+2yiRwSMZ7q6LMpRyBmEAqrTOJIl0ZutYm9/EdcCd?=
 =?us-ascii?Q?KRcyvnj+5evsuIqoKwZAM6+XVEidDJ5dv7xLAek7nvCbbbdlPmOM4XtMaGFF?=
 =?us-ascii?Q?OGWTFpP5ZwGtMdBcyCJulb84HhBcTHwBKbjBm2hpc5jb42RK+TvwhOPZrdwq?=
 =?us-ascii?Q?D3fjEWSp9ATbN78c4kNZwgla1rTyTDkVQBXxPncG5CzP8NGouD3Dzf8d9gNd?=
 =?us-ascii?Q?DA1W4CRIQ62E298bgYpi32qgre1mdaFdbBcFTEra094SRgWFFpwOyD9y0V/9?=
 =?us-ascii?Q?CvDDM0sSBpMZpfYzR0biQmMfsSbJLR3UgCgnLUd+u3SukAPVWH4wtNWclbIc?=
 =?us-ascii?Q?aI/UhDTd2hFwVyCFVyaYyDoolDF8GFZoAFTjRjFeFBGA1PIK440zsHiFBx9a?=
 =?us-ascii?Q?sr2t/TQKSuip79jQm5GyrNrZm0Snxr4I/0n4Uvk9GnHPgcBXhH941UVyYF+P?=
 =?us-ascii?Q?I0aP2j5QeZRrJVbzB5qIEsSivogYqA19Q6LVq3kSwRfMEWasi9I7RLPrlQDx?=
 =?us-ascii?Q?lMnu9bXsGVzjfGkuOnX4ieRD1HIoq6Z7ivtDMjDKH9aVQ43JkJcBr2nJ+dAR?=
 =?us-ascii?Q?gqU0rddIxMlcLUzpG/ahMPo4sfR72o4KKvClIGJDRzvYOXBRMaE+Q0vVYbDR?=
 =?us-ascii?Q?LmBGpiTIYNUDXS90lE+FGh02gErwyGlotm01ToH5vgPNPIgxYrZ2QTmcVXF0?=
 =?us-ascii?Q?MAGk/yw17Fz5syd+cAd27rFHNOtCdUXA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bEZin1ledUb9LJP6TDd43quDNEW3zb/ik9yEtR0xHS8cdKKbVugGK7bx/dX2?=
 =?us-ascii?Q?zbYxx89ebMUzVKpwsVTt1IuH/w7bixM9H6lKuqpOIT5i41G0FmLXNqV62MPO?=
 =?us-ascii?Q?hakrt2wA7yvsWmloxekRIRftXHd2+Keed/jf4tVTVOffD1XEXDAaN4SSG6kx?=
 =?us-ascii?Q?aajnC5UO7jcgnjhnB2+tMS+PDSm187wJT2xjSl/NjM75rG1nLSCrkeSCxZPn?=
 =?us-ascii?Q?gjT/WqAwMaXHZWT+i6pvaIoYaBqmm625d+pIoPrKlKmjTfgHvG42Nrm2/MxE?=
 =?us-ascii?Q?c+9EVdQFOmMe3h+IKii06IqlQgkbkjjozMZG7Pzt1IGcPEqsAwBQchBkshG+?=
 =?us-ascii?Q?WNdanDPH8aAonHOAJ3i0lSDN/35VWie8qjz9f+fQWdd4zGmtg1lSb1k1EIPw?=
 =?us-ascii?Q?Ih7rjoXXG9hK3thOI2XLRzYuJ2Q/YLi+xnQ/73z1YjTfMkn6rr1QtOquVSVq?=
 =?us-ascii?Q?lL1+0VrP8grQp8Mb+LmBn7CFvrUlTGaqkYdqu5TTDcXxPYZoQAzr1B1f61Mp?=
 =?us-ascii?Q?TwV+6nRHd8jZSsosibNylmSHC+AB/2TDdx+hFbeu8QFN3qPcMHxaworESOrs?=
 =?us-ascii?Q?vPyMP1XgJYDXNdRMrCYNZHjg3wSljSFHIjeZqDb1vCJPEMbeaD4T8QSES0Gi?=
 =?us-ascii?Q?oleL2gcMjSp1TkQqMkzbIc7IkAB8ezd1ZbcP6i7mjtclKHdwUSKoZxWLs2vz?=
 =?us-ascii?Q?19hvtxehuHMw0GWn1VrPJf5lwBD3Zack2cJMPyHBU4QSuvctttWy2SWkL1d4?=
 =?us-ascii?Q?elmnj2ZoeyGG0j0LrHYHu8hcyE/kdVE0+xacEaEo7ltVJPg63r8XTs92peMF?=
 =?us-ascii?Q?5qbODkwKRy8Pv82pMZ2AJ6NJb/bpyaEOLwW+6c8rlzyqg5Ai75ojNngsgJ7y?=
 =?us-ascii?Q?4yYwOgG51Qx6iRN+UFK1wQhLgRkqSD8GSe8HtBy47XikAcJwcAM8p18uThE4?=
 =?us-ascii?Q?ACuam5aNl3kWEbG9xrfBljg3J7lga1B2kmFB6gua3Dc11qxLM8OrtVjSuGAl?=
 =?us-ascii?Q?7P8G7PyHPZKYlc5Fh04CV0rmf8umFOlWaOZNdyTRiz+8UWSCqNQT9GtxqzwZ?=
 =?us-ascii?Q?VO0xFvat2vjf0C5FaiczDf6952Nr5eIDn2IrQYiFl+OlKqVwgaqPS74ds4UJ?=
 =?us-ascii?Q?jjMOrTGJZt6JMAPn2cEWm/tPCYZPoKpvRL+bQzItS2qdlCuanWWintrsng+W?=
 =?us-ascii?Q?Jk02scvPwvvbTT6c5UCUHG2SgeRzahAHFsZD1KHAWiWp3Nzy9Y9Vk00lV6Vg?=
 =?us-ascii?Q?hj8MfcmML3+xn9gO0kPRTP54a8viuGZMleXBKxWp0DzbVfiP4OrIg139C62r?=
 =?us-ascii?Q?yQXFyms5/wDQdT0/zMvCOkzUFeMGcYcbTXnpkH/WxqN+rgxzo6j9QuCuFMsz?=
 =?us-ascii?Q?a+Hz3QLuG0CY0xmdPPWg3F8tLGysTtrqqjESvU6BX/QajFVN+liOZKKSyyKX?=
 =?us-ascii?Q?A07o9WPjoNEY1vZo3uZvQFWxLPR7fRrTlOVyF0occmL1+0+CIOXBlIbT7f0D?=
 =?us-ascii?Q?To8dhepYlsjBFNesIqTOY2fbcwjCqgbbYg/Y/b1qKTV6M4f6eZIVRsIPn0B9?=
 =?us-ascii?Q?V+7fPiNaSCVJVFf+5tvK0eQMgjkrHaEH/Pj6gZhLUDRWK4LiNW6Q7BstBoCk?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83820001-401a-46d3-45ba-08dd20ddfb4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 10:06:33.1785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3N1TIsI1tmu3yIaq0dF1L2D6JiWOYpDpx1sWHGiPnWwR6ODZa+48Yae0RrlcZjesV5bAIGsy8L3ALjyImJCHWOhqt7Eum6bv1lxHI4vwLqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5942
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
iotr
> Kwapulinski
> Sent: Wednesday, December 18, 2024 2:13 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kwapulinski, Piotr <piotr.kwapulinski@intel.c=
om>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Simon Horman
> <horms@kernel.org>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 2/2] ixgbevf: Add support f=
or
> Intel(R) E610 device
>=20
> Add support for Intel(R) E610 Series of network devices. The E610 is base=
d on
> X550 but adds firmware managed link, enhanced security capabilities and s=
upport
> for updated server manageability
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/ixgbevf/defines.h      |  5 ++++-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  6 +++++-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 12 ++++++++++--
>  drivers/net/ethernet/intel/ixgbevf/vf.c           | 12 +++++++++++-
>  drivers/net/ethernet/intel/ixgbevf/vf.h           |  4 +++-
>  5 files changed, 33 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h
> b/drivers/net/ethernet/intel/ixgbevf/defines.h
> index 5f08779..a9bc96f 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/defines.h
> +++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 1999 - 2018 Intel Corporation. */
> +/* Copyright(c) 1999 - 2024 Intel Corporation. */
>=20
>  #ifndef _IXGBEVF_DEFINES_H_
>  #define _IXGBEVF_DEFINES_H_
> @@ -16,6 +16,9 @@
>  #define IXGBE_DEV_ID_X550_VF_HV		0x1564
>  #define IXGBE_DEV_ID_X550EM_X_VF_HV	0x15A9
>=20
> +#define IXGBE_DEV_ID_E610_VF		0x57AD
> +#define IXGBE_SUBDEV_ID_E610_VF_HV	0x00FF
> +
>  #define IXGBE_VF_IRQ_CLEAR_MASK		7
>  #define IXGBE_VF_MAX_TX_QUEUES		8
>  #define IXGBE_VF_MAX_RX_QUEUES		8
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> index 130cb86..9b37f35 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> @@ -1,5 +1,5 @@


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



