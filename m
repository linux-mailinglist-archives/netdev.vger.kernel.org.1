Return-Path: <netdev+bounces-203886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D652AF7E3B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1373B3467
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB814248F5F;
	Thu,  3 Jul 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0LE/RoK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AEF1804A
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561666; cv=fail; b=diC5j5NrmPQb3F8uDJ/+vJPJRxjQh5PosZge39VPWla/t1OFFIuzcZk0BcspdzgylADJ/FDx2YKW96aKnhSHCnqprl5SW+XNgvCMyMiryEiG9u7LjS0QlBnHSavTGFzqKNSnEvrV6Gd/4FQKcNES0JaWo23LS5hlqectMid7pbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561666; c=relaxed/simple;
	bh=XlsuWKDwN2FHSfFMusSjx+0yncl4rjIvMKSKELyFdqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pF8KDuwrJ4SPAgG9/F9G1CbxarcnufnJzGqsbC5N+PpY84W1yj1SsdWJJvl4Ryime6Rg7Iarwb2Z2LDYqThstpiKRg+tZTEkPZYhipksXJM9PP/4/t63kQ9BtmzzSh58XRjp19N7yY1QuFnUdGW8ndsCM3/wrWIl3l9p4hm1cgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0LE/RoK; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751561665; x=1783097665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XlsuWKDwN2FHSfFMusSjx+0yncl4rjIvMKSKELyFdqQ=;
  b=a0LE/RoKMuUov9rgTh2NnzKuVJ2R1/imEnIGnHArBdc+OFJ3jasEhnEf
   TSXz7wy4wOemkMBKvfsDu9rUtvPcCIZqeLT2ujN6nt6iEOkEsISNSwQMh
   +VjbQYsrClUuR1ywdMUWCInbcP6lduARlmItEAWY5t/OzNbNYLTM7OLeW
   G011uOyOHC+xsVir0y+rzmcLRZAz6w7sI01vGunswyb4G3gZvg2kh7gnt
   pr5gR4s3/LWGKNPvfPXWXVIWBsIQhFpFwM6Pd7m51brlGqJxHX1chiOy4
   55wPRk8/j0AqbFpCltX5NHzCeXletRROZ4wkXG/9lRVI72vJ/7rSUeREM
   A==;
X-CSE-ConnectionGUID: WRSBONDWRgWhxA5dtycuuw==
X-CSE-MsgGUID: t/BGEaHYQYuSoaFYOkT7tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53992208"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53992208"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 09:54:24 -0700
X-CSE-ConnectionGUID: zmZmxVwrSeeNhcVS6XJjFA==
X-CSE-MsgGUID: YmFMxOZuQE6F+d1wOTqhbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154553128"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 09:54:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 09:54:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 09:54:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.47)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 09:54:23 -0700
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH0PR11MB7448.namprd11.prod.outlook.com (2603:10b6:510:26c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 16:54:12 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 16:54:12 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Simon Horman <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3] ice: add 40G speed to Admin
 Command GET PORT OPTION
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3] ice: add 40G speed to
 Admin Command GET PORT OPTION
Thread-Index: AQHbxnDHWmIVNr0s90esrA19wMHJTbQg319Q
Date: Thu, 3 Jul 2025 16:54:12 +0000
Message-ID: <IA1PR11MB6241D7C4B749E039692C31A88B43A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250516144214.1405797-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20250516144214.1405797-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH0PR11MB7448:EE_
x-ms-office365-filtering-correlation-id: 5239e67d-1089-4c61-a4a8-08ddba523cc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?ChGnyZ5nXLiho+BDSfZOgAZLOinobS/FGgTfurxZ26GPfX7Hoe/KjigpHVvU?=
 =?us-ascii?Q?c1g2HBph4BPnclfW7Jvn7VBuIzbHlELsPMSu12T0f+S8A5+MEHS3yv0U1Vhg?=
 =?us-ascii?Q?Q1A0fuMarQzske+uYaFbDNBk4yK5UFg9HuXHxz8Z3/GBCU4sktISFaTiUPAJ?=
 =?us-ascii?Q?JeEcY9ia+f3hVPRAIg3KNk1IQnF8CPI6bz/w3mu33Gu97X6pVDafWA78B1xL?=
 =?us-ascii?Q?sqJSlSRw4vqfHpAhHZjHrbjexk0C5g57wZhN2nYzV4bvST6DCIlUOmnM2vuJ?=
 =?us-ascii?Q?Esms9ypU+ZvadhFvLT8tde7F3vFtzYefpmLzQtqyz36mtk5k1aRy6rZOHPgz?=
 =?us-ascii?Q?UOuRm6i0UszI1BKT6VTfZc5US7jwiT6Sx6VTFBZntXx2RshzveEMGkUmJG96?=
 =?us-ascii?Q?qhqeLTgWVFBnDxvCBwEhFgP4RuWUHo56ILMcX1neQts8b9UE6ofZLs2/ZNwQ?=
 =?us-ascii?Q?6TpYqiSmbLW4YYEsAWdKZqpVPYiOu4FD0EpXmY+wd/gqICGjr4Wq+9qjkf07?=
 =?us-ascii?Q?mnqGZV17rWQEdE9VUPEMnCXWbQkM+ztUwAr2FM/5mmGQSms2GGLIlEoEQ27g?=
 =?us-ascii?Q?ZMM5jbu0xDCB01Ot8DkSd7tbMVKcuwB3ZHqu6ZDk08pLn03F7BAFQdBkSAng?=
 =?us-ascii?Q?sRf2ji5A9VbVP0/N9oszWHCEoC+FPcA+u4ZIyCP9EqyNUtTsjuAmtRZqm21a?=
 =?us-ascii?Q?gJNGADbHGt5TfqJjKW8kgxYsnmjVci9lZ21U0eL637LantYG3TRCtFoHnuoy?=
 =?us-ascii?Q?LOG9ElkIdODjjLtj51it7soNFgtDH6WAh51Q+XlDa0G2uW8W2a5tOb/0VoVQ?=
 =?us-ascii?Q?yCPoOG7emmfT5j+NQ8qKI0LDLVOTd8ImPC/XRUBN3FerEUIwLl9PL+ibBJBH?=
 =?us-ascii?Q?EFEbhlMkB0UDEy/sfxVGam0588aFkBYnRPxkoQhwwLIBJPfzdXuqZfUBDrM1?=
 =?us-ascii?Q?D3zRU3s6tAoI2rzixydEnzqZGfgEmBJcPD0r8w3t39ZW8lXv+syYD+wu7nxY?=
 =?us-ascii?Q?6uenRFYBFmEh1QcK3c66jO/lE0QYGy23R2Jmr1pNOA/TpsaqTpCRUiiD/8kL?=
 =?us-ascii?Q?aXI5x2Aww5qozjEYeohlihCU236X9mgDjLRr/ydgznnOgDDkagy0EkRuL73i?=
 =?us-ascii?Q?8MtUwpFTz+Qf2GlModGk0RkZ5jnbfFAWZD+xLvT2qqoEZ2ljNMpM/twCFiM3?=
 =?us-ascii?Q?OxpGp8R1UhawFURR335wL/HFiKskSad/JDpcHz+9ysEedJVE6JXN5QcC+qQb?=
 =?us-ascii?Q?NHM6Lq+R5Jv6N8gWOh4NT0NAPUg2UCr/iDjMszfe914WJh4BfpG+YjC4OVx7?=
 =?us-ascii?Q?a/fu+405nAAvRRjQXm11RxaA2CC+Kbh2h2stljryqVsW3WIsPbkX402xTTHU?=
 =?us-ascii?Q?xKWOn6ALwwlVBI8hr3dF2Pd7wLQ964Mcia+4IfPns4qm6bLewXXD7TLFTEkC?=
 =?us-ascii?Q?3pMjydaT8ffsCkTiBast6hVEX2bJctGVfbHayf1mJV2a9ekmqwFfTA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bqPHzBnJYcVdPXQPIkw1Z9pG9Vj9m+20cnAW9cO2E7N57gUzwVFlyiPxl1Xs?=
 =?us-ascii?Q?04JiQQoOZaTZFFhx8dwfG/lmjBT0DVaPWAKppCRatng3uB1A4qV/0UcqRPfM?=
 =?us-ascii?Q?PHAuuRbe469+Nl1zsrb7nMdDRVVG/iH+hTt2yob5L9uyrNQT/cmaNbwjJ1NM?=
 =?us-ascii?Q?lttZ8n5BRSsRc+fgcvOKpxz8UzgTrsgjoKqDiTPWeXZA93zxMlGxxFZ3YdVS?=
 =?us-ascii?Q?2EkBeVsBjqSsrZjNGjqjjCxh8vQEPJeDeVZTwGpwni8aNEJz7sLcmdLbSrSZ?=
 =?us-ascii?Q?Bs9VHyq0/dkn2XECO3TqSgB/E+wHujJhJTDv9CQVsLbuk8Sj31iSVtyEy7FH?=
 =?us-ascii?Q?3nnQpMAo+Ke8acEZg4mpiHZTqEmguZzp72i3yv55M1jYF4RdDu/uVubEz7jX?=
 =?us-ascii?Q?nS7mEAI579Ic0OHzFwQBSBTiakgUqrTdhY2y1IMQYqMDLjWf5JEIgegwz/g3?=
 =?us-ascii?Q?IZtkkqIfwLQCWbtslVIqQbU4WyC57JF/loPAu5FC/pxlQfTuHP3EOM5qFLBF?=
 =?us-ascii?Q?lsZ3l350ZLpGHhW1qGaoWlSLR94pvliGiYGuTPNJhdtpxpV3zjYKZPmLtAep?=
 =?us-ascii?Q?o2rdl9b7GPJOYJaj8dOnBR8jUKYBGZ/81eL9LQoROmUYSHTbkngbNQSmczZ7?=
 =?us-ascii?Q?utJfBMCCpkvnu1NV6+J/NW0SAc0CIS1YhMSn2Albdbnkj2vk+pFz9mIKASdR?=
 =?us-ascii?Q?kvIqeEzeEZyXkteaOguGW/TRY9lMiUxtHF1Z/stPGJCwuchjhpQD4jJcYOaj?=
 =?us-ascii?Q?mNSRONESWUtinN171BPRYej+nps3cnSODu2RGiJEFUc4kczVeP/8OjSI2Jc4?=
 =?us-ascii?Q?XTTgtRI1eFFVNe6jDmDGyUvamAH9g8BfgIjdlEqnqqWv/xs60jRp2ta2gV2z?=
 =?us-ascii?Q?cphgvA0OZO8KzQICufr2/N62vZPz+dtZtXIzmw69z0GPtoFu/CiZrLlr7ZRx?=
 =?us-ascii?Q?Fv0I+JUwX1dQytLVzDr1/eEoh3MMtursvauGhbmeq2VYnBfL2ZrpOncMX7fq?=
 =?us-ascii?Q?j4zf8zijfmVgqTNZVkK/Hk5La7FQlqnJfeVtaOC/URxOeruK9gNuKvKaf8nO?=
 =?us-ascii?Q?XL+647TCyLhzxVcIuh8JjqvnMOlFhKSdKzaPL1i7LvxK4+kP9XImrIYNInRN?=
 =?us-ascii?Q?mdTBeLVc+A7L2GgHn6d1D9Qtuzqrs/zTchZdlFiUAGIiqJhZ7DvB7DomTW2x?=
 =?us-ascii?Q?D1nLFzJEzZW7v4y/WnrI+tUYIJpbfpYSEI8XaC4TgO/UV+ycxgh9jIE/IXCi?=
 =?us-ascii?Q?tKZCvweTeCyXGQST07VTi4o4Iop4nL4Yu24LYVSxwSP+VtjZdrklDxNDo+FN?=
 =?us-ascii?Q?0rzHXHFC+Dky3Xkayl+VSgAfGbmzGwx1zoOgtnO7IzSMpvDc/xWMqik8VXXC?=
 =?us-ascii?Q?5+YATUQtx+/mx64Uinz3cZYv8eDFVpNdxUqD4CIGjRSLA/JfuygI5KMgRHFa?=
 =?us-ascii?Q?ki8hjnOY9emGLYGLeB76Con+4fJ3JXXLELA1T5DZidiuIWTIL5xpw0wrU26P?=
 =?us-ascii?Q?+HuAPOj+iJRU2VsF2sjqlYwPKtnIAW/qkjSXr+yPLbINTNjxBzYHZ33Ze3C+?=
 =?us-ascii?Q?ktnHLojOVoLmw3o+/tvJq+eXsGdFARXNPjiTzsG+?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVXDuyqhQvUEyYb9xc2NKNwTtYWTN345nfOrW4hRIQp89FioZ/7gUjGET4F6PLpnzPE/CxwjgGSHHNYXqf3Jsg3WSq6RqmclTWXE9/beFT0ASmtjOKEu1XA1s4gLXdx6G+cSFUQH3hYkxuQ7r4WXZi+GyFBfCTc44v3Iy2CtilLz2sk4N1XX+kdk2mWg6i0aZWjop1z2Zd3tGC5Q53mPiJ3e+fK6f+IH94MmaoixAij4BGislOTSywUEptdvGnQXhWDwW2UVZ6QaKT7gzMK41NrSUMbFsdVJ/bZzVuS5DyOYT/rBrSteR3qXJ6UeHSnyl1U7jmDeUSewrG1OPu4kvw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbGkcmL+CoKaPRNBk/DHN6Ya2YtKyPN5qf0b9RG5JJY=;
 b=aCVh6frldu4Je6v5qA4TTG5S7cGB27Ojw2NoYbIAFfIY2Zt85/2QLd4GjYkMZWLatkV0kXGYRSJpq6DFLhhUmB51muX9ZO5DH3My7QO6uls9HxhUAQunWkUzHIrKEkb/8Wb/vfaJ2Yvrtd/JGwwq3OjuGKhVPAd2uVQAnC6h0DWvsX/pukrK9PYiI47H0Jvfd4gDTpnmLioa9WJTyUpiZUsb9aDI7aJ7XlJmYlq1xw3MjJqP5nuiuf++Ag595DMGyxwPdbzDAeTjUx6Pu2GGuwMruGsC2su2DxaZKcYNPHnLf3G6xgtXXa1FixcN4qohRFX+HqxrM6IZ7Vlupz3edQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: IA1PR11MB6241.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 5239e67d-1089-4c61-a4a8-08ddba523cc3
x-ms-exchange-crosstenant-originalarrivaltime: 03 Jul 2025 16:54:12.5735 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: l1b5ElNi+o/2suP56Y9iU84SIO6dOEEOs6pWPA5B6hAALfIATVVQkJQhsR1bH+RJpygl8xJjZvnJoerWJ8J1pg==
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR11MB7448
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 16 May 2025 20:12
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel=
.com>; Simon Horman <horms@kernel.org>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3] ice: add 40G speed to Admi=
n Command GET PORT OPTION
>
> Introduce the ICE_AQC_PORT_OPT_MAX_LANE_40G constant and update the code =
to process this new option in both the devlink and the Admin Queue Command =
GET PORT OPTION (opcode 0x06EA) message, similar to existing constants like=
 ICE_AQC_PORT_OPT_MAX_LANE_50G, ICE_AQC_PORT_OPT_MAX_LANE_100G, and so on.
>
> This feature allows the driver to correctly report configuration options =
for 2x40G on ICX-D LCC and other cards in the future via devlink.
>
> Example command:
> devlink port split pci/0000:01:00.0/0 count 2
>
> Example dmesg:
> ice 0000:01:00.0: Available port split options and max port speeds (Gbps)=
:
> ice 0000:01:00.0: Status  Split      Quad 0          Quad 1
> ice 0000:01:00.0:         count  L0  L1  L2  L3  L4  L5  L6  L7
> ice 0000:01:00.0:         2      40   -   -   -  40   -   -   -
> ice 0000:01:00.0:         2      50   -  50   -   -   -   -   -
> ice 0000:01:00.0:         4      25  25  25  25   -   -   -   -
> ice 0000:01:00.0:         4      25  25   -   -  25  25   -   -
> ice 0000:01:00.0: Active  8      10  10  10  10  10  10  10  10
> ice 0000:01:00.0:         1     100   -   -   -   -   -   -   -
>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2->v3 - fix indent
> v1->v2 - fix typo in commit message
> ---
> drivers/net/ethernet/intel/ice/devlink/port.c   | 2 ++
> drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 +
> drivers/net/ethernet/intel/ice/ice_common.c     | 2 +-
> drivers/net/ethernet/intel/ice/ice_ethtool.c    | 3 ++-
> 4 files changed, 6 insertions(+), 2 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

