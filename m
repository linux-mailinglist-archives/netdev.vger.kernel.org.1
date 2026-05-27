Return-Path: <netdev+bounces-292130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAkWCNaZFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:14:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A815E04B2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AD7D302DF57
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE73B83FB;
	Wed, 27 May 2026 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irAtdZjg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8353B9928;
	Wed, 27 May 2026 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866031; cv=fail; b=TW7i+C/DtoQGNmlUt9u4YbfQMM7lhJpIzgnZg8aQ+hzdPJ3bVcg/Ik6Epmvc6ARyl4HBFzM8OUjSxXySmK5Cu3jAHLAyWvRHPuH22oHJGOOxeYdzWSZsvBS3BkbQPScihSJDjKWFEwUla8ga40a7JYHrtwrls4ZHp5cFA8Oz8HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866031; c=relaxed/simple;
	bh=V+Xw0FzUfvjBnu8Q9WZGIyqwAXh932zJxsAtJt4YHTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CqcKQ2uwwAmLXiLLs0eXWPsPc9pkHvYVkEmlsry2iWYsyAK65OaX3VhZnpqrQBak1xfBFwbFnLvYYBW9BLeZszDg+oFIZwFQaGJncXN6R1u0BS7cRJgOSBGkrDzYG32TLHJWmXhMjpr3oNnOPiY2D1z6Nly/EwTvzyWeJ/4yND4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irAtdZjg; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779866029; x=1811402029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V+Xw0FzUfvjBnu8Q9WZGIyqwAXh932zJxsAtJt4YHTg=;
  b=irAtdZjgdWtIxVN1IxsrIdXgl+aAV2/AS7xj4WNlsf15BjMPKD6jujYu
   U4A7qMIrOlH/6B97slgZBG5sRAQ0FQBnnktjYD6PWKweI/RlCV1UwUI4n
   LgEi+isNx1wADz/Kn2NL/1Z3+ZlvBUBSHH6k8VJrC6INZlFlZP8UAwrbe
   V4nXSEe7YzyLB4s3ON3qsHolrvBLgUZTorcKSnzKXFEM6Q5GXMWS425r8
   /Ts6pugE1uGXn7YrCiyvZ1AeiieGTmPVbjlfRdVMJWKim4tQtFc5z71gf
   8LbBaIXH1hmhdRTghb/lHy2jXH/D8mYEw8Ni891RO66hbkBFstDulzTGz
   g==;
X-CSE-ConnectionGUID: DX5saHvqT62Hvys6r8UYjQ==
X-CSE-MsgGUID: 0twszftaRcmLghUrhhLSug==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84314303"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="84314303"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 00:13:47 -0700
X-CSE-ConnectionGUID: anRzIwZwTf+VyB9RYg2C3A==
X-CSE-MsgGUID: lekOaCqOTWu8PQG3dR6jFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="246178152"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 00:13:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 00:13:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 00:13:47 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 00:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV1ku9BiATJO9LpEiPHlg4HHYp9lAzNegRiCeLn/TraZg/ZauZ96Pdy1kLt24yvYqDBqI5K9AFiNGcd9O/b/YfOTRIM0rTh6I+tt5uzhvJMDGqZAirYwEcCl0Z1MRP5oJpc0kyOFSl8SsZLirD/D/jhJlifS/JkDGC3PnezdsBoKdZ3cVstjL9JcHt72PlhkQR2dOCpOzJrjY3kofVSiso8zhcvClb9u301Sb1iYs6QqunRJ0a3Rve/DbtaMraUIHElyQkaUri04+OZ8HzFtZ+49d1JYWI1m3aUpiDmZcHR/bIDQ7TTE+ZEVcpdBYZvXSMC3NdhpwH4C561dGT9raA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w51Qm/lPQJoE2e1PiicG5/MznTmLMAIGTiwEezjEyUQ=;
 b=xzOh/MDhI6UC85CXPfDOutIl9381AQ3RmZmOMbRfkeSsoTYggLwdKS1N8R+kuTVynSEQRF8iR+uNEK+5eYsIwlEi7Y+Q6gfJyHh5Y62/dzSP7ojgrPyNvUN83OQksH+xByrdVw5LDrmHa8wG+X80TEeind5Y1iwqM0bweOJjjmrZfHP32dUK8QMU9AnLxpDxZSb5Dhf9bpqK/4e+dIq4qZ+Au2hRApZbAjZZTMiKUDaZm0048ai/HKn05Geff3nBNBDVbKezn1u1jILtjVDSl7HS2yl6YBqw6yIzq29jiDRhXzernl2Yn00TeZEX2qa2vHFORmy9Utxer8vOXC8Cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB8281.namprd11.prod.outlook.com (2603:10b6:806:26b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 07:13:43 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 07:13:37 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: ZhaoJinming <zhaojinming@uniontech.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: dpll: fix memory leak in
 ice_dpll_init_info error paths
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: dpll: fix memory leak in
 ice_dpll_init_info error paths
Thread-Index: AQHc7SQyWbXOjEfmTESGqx4igTzGhLYhdkbw
Date: Wed, 27 May 2026 07:13:37 +0000
Message-ID: <IA3PR11MB89866105E1DFFAD917A80B64E5082@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260526021154.2774526-1-zhaojinming@uniontech.com>
In-Reply-To: <20260526021154.2774526-1-zhaojinming@uniontech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB8281:EE_
x-ms-office365-filtering-correlation-id: 50171fff-0711-4c27-3a62-08debbbf78c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006|38070700021|921020;
x-microsoft-antispam-message-info: QLW/il1FIz+rYDS/7v5yM0A0CPbYcydn05eAuSAVl1vEEojPcN5AfRTR2fUsA4lP4RWMJrr/F0GWwhMI6XnJhAmyyLsxAdfVUHchG0Rybzs/pWbvKOMqRvts9JhOqy2CYOojf2pgoVVBvyTSwftC8Q0i154KHV6DmKrdlkh6NGkjlqr7iUtX5BuIw84qn3aSBHbg1V4YPtkLXnJNnMzTpPE26JpT4v/XMI0y8tX7LQ1Qz45pzIMJ/SkriVAZZLpzO6NYcbXxoxxY3Wg5Rk4qOLEVMf2nIRd0DdZASw2S5UlmDa4w1O/RnnLTpT/cIDwE/DBaxT+vs4IJz2NRfhfvFycx6bGqJx3TATKqWTRh5ZesaCqE6aurH50ClgWxDJV0l9a6SgVSo4IMsemqoVczF5kSGXJUmMg+ITYBXmT1hBnO+TaAgFoNx8gVog6f81R3tQMGfKjgH5NoBP3cYRrouxiUGS900w90QlFq4uE1TMZVJxg0e/jVewGG1ahc5DU2LVuCHrG5RN3RLMD6OUUDMz3LlbY9No3388nNanDii0nirgkkz6KeHHs5M2jM5DBkeGL+dII4Ptf3KousGoV3nHKCk2TpJfOApJpGwgE8D4NBe2lb9skuWaTJVBFC8dp0zUviRACmm0xmEo+Lkhp4d6ttrByDZldjdhvS8ePi6VXYXgWXYVTCJ8W6acSavsjWX4DgKzeD9UPmJwkms8AKiE3kmJSZKLp5RBF0hHpfnl5WzdNB4DhyPSO1Ho8XbFkepQ+PMLROE8+RQgW5pOKk1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DSWsG5Nsm6jLYbpJTAlabRpWOk+BLRL1It+ykah8RMI08E60jviduxkG7jOa?=
 =?us-ascii?Q?GacmY7vSI2iT68dl01HsIZ1cgBGB+5KQMttNBy8jhmDecUy3YC/jqP1d3b81?=
 =?us-ascii?Q?nQN2bRjKLGOdMthrSQIM8xGuQxvAIHydJeSBJt6VUySfgjv3StqkClnEWXin?=
 =?us-ascii?Q?99rDsOcmKCUhUuty9/L8k1i+gf0F90ZR0UZbEuMdjWyA1rH7YSs9svzgHTau?=
 =?us-ascii?Q?Y5HSo6yf7pn9UeJgNxY83EycvYAZCP8oxF8dj1BEc1cIj4b8qGS6kpFcdmWK?=
 =?us-ascii?Q?GCuHme2uwAHctYsH0MLhNrLPcs1GqshJhlloB93sceQYsn/i5WlmmypeMlXD?=
 =?us-ascii?Q?VxH04j/wHQkt87x3UjIXF429GKiAv0hS5fM5Lk206ntpPALCsAdbjmHtYL/K?=
 =?us-ascii?Q?nmFXztOP+i5Me7vY0QHmUoVhGW5dfr0za4X3tbkvr0x+bBU8tomOL9AY3LJX?=
 =?us-ascii?Q?dlc8hg9EQOxl6r7+2Zqz+9g6MzmDPbJYgMLpjLwMli2UwK+x/oalokOdjViP?=
 =?us-ascii?Q?coDf+A/tuYysKta3JQYRybuOPkHUmI/pH5KUQEG02wdrsyrFZp8ItEs+sr9J?=
 =?us-ascii?Q?4R1wHBOYDCooGQInH0Yn096Iht3m7O4S6bf3EiUtUlJKX1UoQdAOK8iVsR94?=
 =?us-ascii?Q?1taH9GmHZifNsazP9/NutDlg6yVHQmyK2Ir9BfHHaEpdbzcxTQH8qTnD8WHJ?=
 =?us-ascii?Q?E917OEuOtW9u7G7PItNTrQ7qS3A5NZYBX5aarOVaCgD9oUb/KZV/sPzkG8Fp?=
 =?us-ascii?Q?g6OAhRgnI8kzOI9wKZe2crzNcFXS3nnx1z2Q+oanmTYU7hlP3DEmqJj4gJ0U?=
 =?us-ascii?Q?i7cIV8YLacVzdzpriUpZ4m5A2+KDtOcN6R47NdBf8PrqOOESrIA9i4oWi9XU?=
 =?us-ascii?Q?M6lq0/7zO2NDS5Rxz7Gv16S0NaYneTTblhiQfh34//PFrlOKzfb54stK7nma?=
 =?us-ascii?Q?Ae5nq9mxH+fuXS0l6/sz3k62Pc7ny1PlnaYHP5jSgHaZBCAj/yh7lc0YSY12?=
 =?us-ascii?Q?vB3mniE7Yo5S0+hXxo6IoIJpyISyS5oXdElFeU/vqf3FTEzw512oiph7lIZI?=
 =?us-ascii?Q?Oy7sBtiuu3SjBkU+4R90XtYHtDo36/cwqeaToxWUxnQ7oOTRLOkEhIm3/YFl?=
 =?us-ascii?Q?cK1cWAbbc2vVK6A4NMkc61iL/eFwxErQJxTtJHOtmTmx/Nae0pviDlXZFmZL?=
 =?us-ascii?Q?E1GFoVxNSRKNrvO/ifenclk/ko27zXjWBwnFixDjEf1Q2uoQ1vB5KYHDlGAe?=
 =?us-ascii?Q?LdgMjIOVwOaw1KvayEFuI2MjnlYpheJiO747ntT4JUzw9Z+qIJauWtr/imBs?=
 =?us-ascii?Q?asteUN+mNQmEolz9PsAE/JVTUOecnIiNHRtDSK+eE1P5pwoTfmc8moWX/GZX?=
 =?us-ascii?Q?tDTGpP8B+Dgbcod+VFhdmHkgAEnHwQkHxQEMbqTZiqQUw5KgUtrl4apu2VoX?=
 =?us-ascii?Q?AhjGgCU8dKAP3dleIP65QwFqCgqsf+wWqI+sMkxkAJ+Ce4D6n1Ql6/nDA5IV?=
 =?us-ascii?Q?tZZUv2Gow1v2VfxMug03mVd12ZGgwNlOFsLZhNxZXYBf/En9qwoSx2eex6wZ?=
 =?us-ascii?Q?pjRcWh4dKgiDgKaKj5O0/CfF2GwzJozo9msEf42pLYw8NcEQ2ipP0SQBAnKx?=
 =?us-ascii?Q?rB7zxSEDfWyFGf/IZxK+gH04irV+xvSPjxlgo+I0yRt/grb7ODly2nZoXXWy?=
 =?us-ascii?Q?M4Cik9lWvig0nrdSoufpjXCdSIjyWHFt7QMlnDwgnh1ASgMAxGuVDGHyHsxl?=
 =?us-ascii?Q?x3mNpLVXpU4P75COX0N2ZaybYLzHmkE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YjXw1+fJ7O0VhVNQxeZPsQwwZA+VAXfEp8w6OEv5s/L6gECGuiu/k2+Dbd7J0xZimES3Av7LSh0X+ZAPG9HZrO6n+lZJMRj9Vttp8CZLQDbDKNEN13tF34c7CuSs2R9H9KK5XCUK5hMTC3M+WpWTjJghtTtTP2SbPMFDdJigVabgFY/aMSPt7vwKz7VKTE2afQP6Ho/wOsz8TX63EbgsRXe2e+2s/lxYmkL+ygwc5Zhg4kJ1go37XKjxM+Bh21twV4uGGhMmFTQe0u5qcq8OL0nN/VNOaK7e0BZzui6c0jz2eYhKBITxZNdCtTmdj23khAGg5Y3+CtJ45MyJOIawlw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50171fff-0711-4c27-3a62-08debbbf78c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 07:13:37.2404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA58YU/+PA1KHah6H3Fa6YaP/TAIGJWNN3w8gkHU+Fg7lhITD1oK+NiYcAYcTdH3IPgodH+bnlCFJ1AatXpSXSnhzd1PLOROdmjLelul/BY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8281
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292130-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,davemloft.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uniontech.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 86A815E04B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of ZhaoJinming
> Sent: Tuesday, May 26, 2026 4:12 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; ZhaoJinming <zhaojinming@uniontech.com>
> Subject: [Intel-wired-lan] [PATCH net] ice: dpll: fix memory leak in
> ice_dpll_init_info error paths
>=20
> Several error return paths in ice_dpll_init_info() directly return
> without freeing previously allocated resources, causing memory leaks:
>=20
> - When de->input_prio allocation fails, d->inputs is leaked
> - When dp->input_prio allocation fails, d->inputs and de->input_prio
>   are leaked
> - When ice_get_cgu_rclk_pin_info() fails, all previously allocated
>   inputs/outputs/input_prio are leaked
> - When ice_dpll_init_pins_info(RCLK_INPUT) fails, same resources
>   are leaked
>=20
> Fix this by jumping to the deinit_info label which properly calls
> ice_dpll_deinit_info() to free all allocated resources.
>=20
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 892bc7c2e28b..3cf098e67563 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -4341,12 +4341,16 @@ static int ice_dpll_init_info(struct ice_pf
> *pf, bool cgu)
>=20
>  	alloc_size =3D sizeof(*de->input_prio) * d->num_inputs;
>  	de->input_prio =3D kzalloc(alloc_size, GFP_KERNEL);
> -	if (!de->input_prio)
> -		return -ENOMEM;
> +	if (!de->input_prio) {
> +		ret =3D -ENOMEM;
> +		goto deinit_info;
> +	}
>=20
>  	dp->input_prio =3D kzalloc(alloc_size, GFP_KERNEL);
> -	if (!dp->input_prio)
> -		return -ENOMEM;
> +	if (!dp->input_prio) {
> +		ret =3D -ENOMEM;
> +		goto deinit_info;
> +	}
>=20
>  	ret =3D ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_INPUT);
>  	if (ret)
> @@ -4371,12 +4375,12 @@ static int ice_dpll_init_info(struct ice_pf
> *pf, bool cgu)
>  	ret =3D ice_get_cgu_rclk_pin_info(&pf->hw, &d->base_rclk_idx,
>  					&pf->dplls.rclk.num_parents);
>  	if (ret)
> -		return ret;
> +		goto deinit_info;
>  	for (i =3D 0; i < pf->dplls.rclk.num_parents; i++)
>  		pf->dplls.rclk.parent_idx[i] =3D d->base_rclk_idx + i;
>  	ret =3D ice_dpll_init_pins_info(pf,
> ICE_DPLL_PIN_TYPE_RCLK_INPUT);
>  	if (ret)
> -		return ret;
> +		goto deinit_info;
>  	de->mode =3D DPLL_MODE_AUTOMATIC;
>  	dp->mode =3D DPLL_MODE_AUTOMATIC;
>=20
> --
> 2.20.1


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

