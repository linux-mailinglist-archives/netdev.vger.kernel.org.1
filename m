Return-Path: <netdev+bounces-292385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED0ZF1kdF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:35:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E4F5E7D5F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F7FF302C76A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA00543C041;
	Wed, 27 May 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2R1o8e2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78BE41B37F
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899731; cv=fail; b=S2RnIgfgo+Ai0Wi75/JnagoZDCc45W3MTds0ZHUHyW3tFUD+ZhOKuNwsZLve0W9uMJoSlLuvDcSZrjzjt3Dgb/dQU9C4mmPZFtEEodMznZIcTelWgAtASNs41IzteROPo1Vs41oWACzjADyav9FlGqffmda+yEs6PQpmRDCpPiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899731; c=relaxed/simple;
	bh=fbx7DHsmVw3Uegv9hjAD5LFVaxMMZ6af8DQuKt9oiS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BMqXtxnEP1dnfTjvk2zl6qVWakxNzKABD2oTPoQHpvAy7n54f0LgjdHVdjuR+5kXKCGXGulbWdRSqvCHTk/DVGgzNuwE2Ml4H+qeZdu9hHaupxKLPgSiFbhzG3n1hWwZAz+rtGaF/4ZULIXfrAgY4NHWP8VMXSl3Usf1b0bfTSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2R1o8e2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779899728; x=1811435728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fbx7DHsmVw3Uegv9hjAD5LFVaxMMZ6af8DQuKt9oiS0=;
  b=J2R1o8e2CDE9PdCuCW8qUhGWUSUScxQ92KhJyN2eg+ndHyJOjY8c+hXg
   FG94iys/Ub7oAat16hdLwuBp1frYwcRNkMKQTKI5HUXM/I7RuHpYp009I
   BJliNo4pIPDOiQyg0MeHxGSkGf1VVJZZcywiXMPazBdlr9lGBBjfnOyAj
   JLCIo7RgVpk/uR7V791S1fDKdF+rXEWhZsMfACqs34q+Mj2NqTjLtDA1E
   hvpA+U53TR3GqS7gf0CR3CgGK5ZITo9hLjrT+q/aTuPKNGgDREGK92j/L
   DoySNJhsydPdTEU38YircwYb/66uLEBw7U0lLwR6tJexv8idg8LhHHsOj
   A==;
X-CSE-ConnectionGUID: MLFLgWV1TXemZzjd5Lq7cw==
X-CSE-MsgGUID: qvGjFz4DREeo5nHGIy9P2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="84595273"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="84595273"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:35:24 -0700
X-CSE-ConnectionGUID: BIhSqi52SiSjrSJIXnqlbA==
X-CSE-MsgGUID: 8Ih6f45+TsW5vmYYO0NWdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="246571824"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:35:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:35:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 09:35:22 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:35:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcoQ1M0JbzAAqq0IhNM42wi5It/Jcu922nd/s5uMB+YfHu4La0kl8Ogyse/1Pz38QL1/7zXK+6k4bAGrHsFForNjXF72tFMbBoGtL6HZNXjUXE5mts/edzSAjafLmPzMLASMezsIxaTylbZzp5r7ffG8wPugI1e68KMdvJ5sJkHmx94bb3ESnUk/abuYjCnWY1rfHh2ASuAl7Nyg0VUwKZWh2RIJxd2ZP4Nuw2N+LA+2vzN/c+pCVjXj3WI2aG87WLrfZ+rVfEgNa6o2q0t+ZmGOMBW4vfUQ4HDBnQFSevE9IkTHSSSqY3nj5Y61uZAo9Qhcx9U+5pD9LUeLfyauiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHXl+b5ahF4TzSUjtHna/ZfJSPw8uGtrHTakXDdQMVQ=;
 b=QXvx2OQ6+6Rc2iBTd6gfmJhOY1GAAfCkUxVJaKABRGFQcqbwVTvRAUWh2o+ft+Rr7LQb2fC7XsPc1Ralat445ox7oVnvWKfTL66gOl1wfZVQNKlKdExDyZO2rNe38q775EBtNKhcYOTYDCL2DthhmqqVGzgYXcHitRIuw+iCitFdE9GaLNg0LpRehatuLzaks4tS7+H3ZzmTKMebBqpUJjtzERWH4Mo3u91GkA8rHDI+JZ7TlUqKjSSEqjUfR2Wkp4kINBGlH7CHDs6fTMUazZsW2QcByC68YJqwdo0YR3PO8Uo6u6mIBRF5NOCLjsKMKxW/stoF4nO/fV83qqkpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SN7PR11MB6827.namprd11.prod.outlook.com (2603:10b6:806:2a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 16:35:20 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 16:35:19 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 2/8] ixgbe: add
 ixgbe_container_is_rx() helper and refine RX adaptive ITR
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 2/8] ixgbe: add
 ixgbe_container_is_rx() helper and refine RX adaptive ITR
Thread-Index: AQHcx1locQiDwsCXpEawcbEFPlOXsbYiXqsQ
Date: Wed, 27 May 2026 16:35:19 +0000
Message-ID: <LV1PR11MB87909EC81FC6E00E7A6E66B890082@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
 <20260408131216.2662245-3-aleksandr.loktionov@intel.com>
In-Reply-To: <20260408131216.2662245-3-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SN7PR11MB6827:EE_
x-ms-office365-filtering-correlation-id: 494bdf7c-923e-433f-a887-08debc0df11a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: lA7J308Q1U3ZkwLewsRPyb/j961cQpY0AhnoT56dIrczg/Uvld+NiIoV1ubKw1RQNiRVhca6DWywc8pyRR1nhhyqCXmUa0n4HRpsjyJdIwFH9QCzt5MymIH6k2oJuLnIr2aOdVGxpKhzUSc7XsH7lSBzEsDxTWgiSdms4t7I1Q6qzs1MkhVZCOv26H02isRrDnBBqvTDWT7PjEY9wM9Q1UgbD9sY/ieIxCySphDvCYMHSjpKCfQtHWvtF8n6srxpRyifwDSGIji9+KT1D1zEPMBPx8THWLKbX5EQ7WDykrdv7tbF/iuKQwGVQOylQGZptnsosLysmu54x4PvMH/c86JSq9HuE8yyVTLvg5vxc9ayQcU94eItSzEwTh+L/KFsCMnvnI7JwMY+vZy6CzE1OkcYGD8mIeIie9v6wPh6B1x+coNypqmNc5am/arcknIUDrpieolB3HfqKf4lNtRK9ctBWJSq3zSj/u0GYmZBaH4cVzNmnU1AdKw42XH63ZHq16pM3zcSJWwGTo8KMutpU5wlMPoGVEjv+/KSc7oXdQ+BxF735c6yglSJEQPWlzRY9rOAQ2aRmk8vTpxUH95g2RWr1SBSWS4nHEgKpfGS6L2rSp5NbUxLoTqlQCPPXldgIVCD2Rnl6jA/JO2Lxgn2EWyCq/wBlJ6ScDM5bg99SCs/v/oslje6FaXjhsOJz7O5uf5eloYGeEjgraugbZJ0TqhRTOANPQtBsj2lSYoduRxTgjHhQukgeEu5qg/eb3dA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xe2OwWI+tQoT7szrQjziDEgQYpxXeVkUHocMWW+him4zFhUFxAwOQE1E6ujt?=
 =?us-ascii?Q?IEYDAau09KRNLH0d/ddJSaQDmRZnFypnvkO52yrI7dYqvU56uUfRE5ExJizf?=
 =?us-ascii?Q?17aWEunAcP/6S7f3O8GTqxeaOYCg1fRv2u65CeqYa9FKOXCGsNaFFKb9e5df?=
 =?us-ascii?Q?5UFChRk9L+MRQv69TY3FpdCJ7qqrv9BvrXS0wlo+8r0VzzkhXMAi3kUzFM/B?=
 =?us-ascii?Q?DqlPdGfw0FMif58KxHXhNBH5SdfOKYen0br6gLV7uVswXU8rMzPNymWKHJzh?=
 =?us-ascii?Q?DOZBF1627hq9Epi4jf4DN87Ff6e7DUMIChuXSiDs++DQUU4rGd6MkYSDvTim?=
 =?us-ascii?Q?sKf+dE9X1oiYQwMDm8zuFM35VZOPJ0mWvmzCd1a0svzco1V2BG/5W1blDrpf?=
 =?us-ascii?Q?j3ulweU1lgj3C00Qp+G0E/O4zFB/JpVchUuer5T/CbJnnRyPhyoTi3xYvxkJ?=
 =?us-ascii?Q?4bogE5u6ZRlZLmLHwFDeQFXlarWQx//hhueGVpIeq3RfgZ8l/RkJ1M6otfmY?=
 =?us-ascii?Q?lrrCdnYjR7xuxiz0iAPp8kMX3Adc08OcotLwo7IIM4dZODAX74jdT/V4QWLF?=
 =?us-ascii?Q?9KIG7WrMcUnn66npbAYxLEre4slGlQAfC0dlfM6E2TGXyZqAyI2YcTBtZ1r3?=
 =?us-ascii?Q?0YST8PQci9Z/Npof3nMhvsiszaiYMrQU5wFN8R4CAjzSZZbvcCQleEMJHfwk?=
 =?us-ascii?Q?11i9U9kds1iPBkHO7NWIh+rY1HuhRoxTPgANjXsI4uHXNsoi13UhPivC2rT0?=
 =?us-ascii?Q?gKemyfEICxj846C56D3PNOWbNj6wVXYthpqy1ooc5So2uJwcpQ6O3a3CpJ5x?=
 =?us-ascii?Q?oQkTjwFEg/DlYvz9tob1Uj48C79GiYWatSqvcwUTRTZPeme2HKdAfpd8WYxc?=
 =?us-ascii?Q?hJXMXO1D5OCU+nQaoaklf3sEUiq0f7s5no+kE/qeueUmRPxrTRsAqwoAfn2f?=
 =?us-ascii?Q?3tbBbijxRJM/3RflXJXAbJcCV+aEy88V/FDHQAMYNRU+JKYKUO+vRraOrVa0?=
 =?us-ascii?Q?j/2+v4w1ztu811GmQ57Y1XUJPWafQ6P7aV3PNZPN6mzgs71k3tUzuER9CXtc?=
 =?us-ascii?Q?qdzrxT4XhQXSNcpjDiiPdE4rJIQvOKnlWZpprT/3gkzQgfbVh97UnvL9brh9?=
 =?us-ascii?Q?5lKvo8R8/E4PGpfitQJrup27ETmWVMW/Vu2bNHxMkDOft8p1yyaZ2Z6I7mGs?=
 =?us-ascii?Q?3rcYJbe+PbYYlHFq/z9KyCc0+eQ7Yu8xRAZxWGR3hXz1glOaKxY/8bed6i26?=
 =?us-ascii?Q?OZQ0KwGxlKkowBGL8XjhIsEQ6ZNOVw6zehWEs3eF/1SzAArqhkePqapttwNT?=
 =?us-ascii?Q?rsZknt+7usShCzbzYzykRg2KR2LdTuMRuYAufEAIKSvDEoNrqcDKbjrUs8u/?=
 =?us-ascii?Q?fS4Ap4AE17bt9eECdpZSieiBlWOF/Jx4OVdwe1SN6RtptwGksrTZ/rK/RetE?=
 =?us-ascii?Q?myAGQLQw5bB4Vke6SBNcllbfnV8nF/AF/tRi+7zwWnYH7NxUg5OCc7iiwhHi?=
 =?us-ascii?Q?w/D5+60tq+Dm9RSjEmT/OML3sVD5maGSbpZXEnbXzTvNh4GiyIgIrqdXUDXO?=
 =?us-ascii?Q?/28xxH28JVWDhDFXu4mZlqfOZnhxTdSRoWAaVdPVjASbtXRhAugXdQEstP/h?=
 =?us-ascii?Q?bVaU5yJoMTl859aqfanVaZ1+QhmeM0Xnr4WJvzS5hkZixidhweWRULIOfe1u?=
 =?us-ascii?Q?Su2xJhhWJiaZXsBQKK+sRR0z98y+5PuNl0wORcxFFalZXBSycYybiDzPKNPO?=
 =?us-ascii?Q?mVxzetkilA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: efpngivDtG9GW0ojJr2E/mMZForElRT1p13wyuaPw+ZfV7crudwQn3qLVtNq5Vy5qPaKTyuQuOOrpEzCsrnM+wwYUb0P7/U0IHsLwlUMWFgOD6dgm8crn46ksfyzxIIFZuPYm9M9WLjmAXGcWbl8NKrlCgYWV3C3Mf+1h3oTvEqKE+1XE40C0pXwGgXFxPVxbTmAYct8u1aLOk/ltux81n0lMNtEwGzOXlilcBl+IrLTiP+rRs27zdLgo0uZpPCQdFgvMGuI4JOtkUud6KmjaqgDre4cN7okI8TGwqky9MlTEXPyufWun9QJ4HYDmDazhO4Xfigx1EIkDcFqqLhM1w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494bdf7c-923e-433f-a887-08debc0df11a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 16:35:19.8715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0zxHOtGqjmjv25a/vdYMvaNTHI9ffvZRtNLdVH7Hvj9MF7o60MqL8eCkSzNUwZ8KeFevJ00gavcKtUmrbLQ3PF5Lmw0JK+/RyuJ0ubFDIwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6827
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292385-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,LV1PR11MB8790.namprd11.prod.outlook.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 31E4F5E7D5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: Wednesday, April 8, 2026 6:12 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 2/8] ixgbe: add ixgbe_conta=
iner_is_rx() helper and refine RX adaptive ITR
>=20
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>=20
> Add an ixgbe_container_is_rx() helper to cleanly distinguish RX from TX r=
ing containers inside ixgbe_update_itr().
>=20
> Refine the RX-specific latency-detection path:
>=20
>  - Replace the shared "packets < 4 or bytes < 9000" threshold with an
>    RX-specific check of "1..23 packets and bytes < 12112".  When that
>    condition holds, target 8x the observed byte count in the next
>    interval by computing avg_wire_size =3D (bytes + packets * 24) * 2,
>    clamped to [2560, 12800], and jumping directly to the speed-based
>    ITR calculation.  This provides finer-grained control over low-rate
>    RX latency workloads without affecting TX.
>=20
>  - Remove the separate "no packets" special-case block.  When packets
>    is 0 it falls into the "< 48" branch.  The mode-tracking logic in
>    that branch is extended: fewer than 8 packets forces latency mode;
>    8..47 packets preserves the current mode.  This replaces the old
>    unconditional "add LATENCY flag from ring_container->itr" carried
>    over from the removed block.
>=20
>  - Remove the adjust_by_size label and the associated "halve
>    avg_wire_size in latency mode" step.  The Rx latency path now
>    pre-calculates avg_wire_size independently and the bulk path no
>    longer needs the halving to compensate for incorrect thresholds.
>    Rename the jump target to adjust_for_speed to reflect its purpose.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
>  - Split from monolithic ITR cleanup; adds ixgbe_container_is_rx(),
>    refines RX latency thresholds (24 pkts / 12112 B), and removes the
>    separate no-packet and adjust_by_size code paths.
>=20
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 72 ++++++++++--------
>  1 file changed, 41 insertions(+), 31 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

