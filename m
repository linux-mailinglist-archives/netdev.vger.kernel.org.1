Return-Path: <netdev+bounces-306114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GIbSIzpsT2rxgQIAu9opvQ
	(envelope-from <netdev+bounces-306114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:39:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8393072F0AF
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:39:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MxTtDzDx;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306114-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306114-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45CCB30735DE
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D21402BBA;
	Thu,  9 Jul 2026 09:29:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915B3FE65D;
	Thu,  9 Jul 2026 09:29:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589359; cv=fail; b=gVf5Op4lFp9v3u+4pgSe5o2M4zdA+uNfoI3n39s5zs1wLALpudHhMI/d6luYJ2kkKxS0n+8GnhNvup3T12lTcou+nJU5bvuwFL5K7BYxrSFExaGp4tfmLrDAx46liur/Ivdb2BUY6KqmamcLLtpB5p8+LtNC+QuIlu4ZZWFq6qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589359; c=relaxed/simple;
	bh=p/uGHMBA8fGohSwW/kkbu+1mGs7zTawzTCVCUs1F1wo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=stoN6mdbAI8VIO/v1L/unoKE0FuDmYswFiJorytL8UBZheaPoee/s4S6/bstDJrBut7fxyP6pTy+2+zs5uQQutnIsWQ+7pAOiEDz+GMA1h9IBlp8JHZEQpe3GuK7mcgMovxtE3iwZ0lIhyeK/n0YktVRsdBcmUZEZvs/koqdzVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxTtDzDx; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783589355; x=1815125355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p/uGHMBA8fGohSwW/kkbu+1mGs7zTawzTCVCUs1F1wo=;
  b=MxTtDzDxADpvUkLMCQ2lz9vuY/bnXplTDAz2pFpU4CIQsxzJkeflHmNu
   DeFjRdkhtg9GEXXgLj0iRFdKZ3F1TNPaycrQHlxrSaf/7Qrdhv+hvBr8H
   uGnp3Lej5kn3iZ/AG0u/yfAJwn0xvGRKLRulwOagd1Q20d3048HGyCpum
   cQcriGtAZ7Ix16unQxFYiqPYg58zWNTbmGdVpuV3T/ggESkeMXHiGa1x0
   CD02pTA7ZMJASnEKvxQJnEZbuOCdOwmijL53jjRKFmzJ/Nwfi98aKy0xV
   Y0aBXjZ1awo27ATOJIZYWJ9LBD84cPq5AGXE+QZnyWf3mvdArzTBkrfNp
   Q==;
X-CSE-ConnectionGUID: prI96lxaRM2Bc+remIOWLQ==
X-CSE-MsgGUID: GlQn2CFmSCWcbE7phxg+8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88180929"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88180929"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:29:14 -0700
X-CSE-ConnectionGUID: Di669AF0TZyesiY4YXCoqg==
X-CSE-MsgGUID: VkZTpezWS1KMKtA6784SxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251169951"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:29:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 02:29:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 02:29:13 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 02:29:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwCfWnt41kJqU+cEyRZ8C3BX6chAEpzo+dW+nfDdeQvXxlOW8L6HswetW+DjIFXo4/VygY6rV0yXrkin6l72ghphrseiRx7hiYUmWBF/kA/y16b2boQZKVJVPEyr7u+iuy2ITb8vXHtNZ+EqmFY1wR2t8td7yH9XFSCyDrX7bFvVd7J+XuADlLw7fBfp1r0vDeWxaV7uuO0W8hILrvTOoWsY2P3LImoxP+Ubd40KsDNfKAo1Tcp5AoUqaNIDJ+NX5Vr9ExSJMbjjeSRRX6TRlvhxiVdip7uua8djU+Z8+t79pxyAGmGJnLGuOAjEqgFeYl9Jdw4eFRfGSK4oLWS7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB/QPA4pqpoFPcsLylrvna5bBDD8O4x/2tUflrhybPU=;
 b=t3H9SFSEstHiMt9UH1ZO3ij1cI1IQ3ik/SHH21YC57HeL+0jWOtp3zHCs4teTzH7c6JYZRPNCQr3xjidQiC6Zbhmvo4qT7HAGjOmADJhDtBIBX4ZFGJCWRBDO8wQvMncdptXNpA16VeE1QJON0EQrvCE6ICfNQ3trNgBPzHT8TX8pwWxIupvko7xX2/TmlV5Emp0mosXgcbZfY1RcOS0/MMT9Dh3Gkm6GKeNkJB87xSh9kZgu9ZYizuWWWL+iwne3sQJp07P/ylbYJ9vIDB+YO0poPdddtZtlzlNM5rA/Wk1rjQpmHHUbt14sKh5khE0IjkOaM9kMWZXExF8Wx62jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by LV2PR11MB9539.namprd11.prod.outlook.com
 (2603:10b6:408:378::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 9 Jul
 2026 09:29:05 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::62a:1a7c:6360:a580]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::62a:1a7c:6360:a580%8]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 09:29:05 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] idpf: add flow-based XDP
 fallback for FWs without Tx FIFO support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] idpf: add flow-based XDP
 fallback for FWs without Tx FIFO support
Thread-Index: AQHdDuyFFAIjz5u9qkinjtCiXKAKtbZk7KPw
Date: Thu, 9 Jul 2026 09:29:05 +0000
Message-ID: <DS4PPF7551E6552EC89FC7B6FD57DB5ED86E5FE2@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260708151327.1091570-1-aleksander.lobakin@intel.com>
In-Reply-To: <20260708151327.1091570-1-aleksander.lobakin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|LV2PR11MB9539:EE_
x-ms-office365-filtering-correlation-id: 7e2da8d7-90e5-4750-98b7-08dedd9c8569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|22082099003|18002099003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: GBc5aSpW36Pn972stEyehX5HXDReCde1GRm4c9K+va1t2V46xQnH4IwxVUVox9/7XLVlmb7UK9roOE5LSw3slTIrld71wLoyHzIJvYd5L5gC564EkKos8F6ulwDU8se6AETNGfK29U+Ba7d9WO1u8aY2ZPgwV5YayJP9zMinteDomLYRpqY9rHc5RdEhmEUq3QGKoSgTTpm/pbFX64DWe+NVQEU6Cfdzkri2jWy+eg2+sR7Mo7LGB/hqjitnSJ9mUsVBQxW2bR7j5vXDOBeErwp3HUnE6knRGvPbYsHVwSgUlS/faG63za4kUPIyF4txhEYK8kYE4/wzicJlfUE67uzEbuaK/XHxtqirjM8+mdPdz9XjdMqi1+Z0kSEUIjbWWmWV/oYbT/nyfkDv6Sh+2+dkcxJy9am8aZCe+wLUIpagOWyOw4yIu+gKbuDNno2poHnZdksAeQuZEYNmhRjp/shztlpfhqKwLVO7AS/FPkk9rpgk0O3rUdyCB4fArF83P7iV0bKG2D8MqMQ86slqcOo6BdlVEH0bdJ+bJIL2dMBzmz34VqzzO1jpqdaEgQGQv0Nx6S2WfTJrP4EhF0AJPZRSPou0CJ4Ont/vG9TS2ZZbB5yGrnZvfFBO4UXZXVranQmUK9qST/5eho7i+yjch1CwMtwE9uzfKBC4zGw1HNbVOviHYeyhXc6VOsIMEAXBKdXxlgJoPB+IUafQyTTwNDly4WHF9FL9DGVrglZ0EAk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7551E6552.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jw9r/gIK0DHM02Zwhbujmm+Pm38vRO69GXwf9wSgVxsaVlhc5RbJNldGrf2G?=
 =?us-ascii?Q?qRi9JZ6AO4NUySvB5wiScIi1lm7Ky9xU1oWHCxsEk/b3jfCEj7igW8axjO1i?=
 =?us-ascii?Q?5MXayPJvUplaw3E5aUXl6z2vv8vdpxLFkNSsa5rt3AGMAcslL4yHC2iDO1ED?=
 =?us-ascii?Q?C/ZxRYwib0LilNWf4HMLtPmw7RREztGIrAWnean+gvLWHuymzm7GGAdv/2dE?=
 =?us-ascii?Q?Z0/k2PYoVxWhzpbWFTwZrVBLkr5IlhDLniZr5v/22UpgAB22hs35PB9WZaGJ?=
 =?us-ascii?Q?fsAmFwySSYlEB09UlN2iIYkmGFUZpAzfV7v7sSQiwLzubE2F8s2S158oc4XG?=
 =?us-ascii?Q?BCFqLBZ4oqLVkq54pSOF/Hwx6M4Z33fRI8edXgSV7AEWCxWvO5lY631jsuiO?=
 =?us-ascii?Q?kXO9+8tPFwELLJuwBhDr8AvoPcG2zqkULda4xMBNUdqeIn8RwRzlHEKIwWxO?=
 =?us-ascii?Q?zzqYeBVxQFY7D6/G8k4j7CIkvlvJt39sdtn2eqrNi15F9ML2YmLf4zcp6HWs?=
 =?us-ascii?Q?5DT89fEEUcte+wts32xTjDFhjzKzHe0V4+YpRX1E2r4WT1Gx4M/wkOmovzVH?=
 =?us-ascii?Q?KD352gAE4Anm6qBitLIZZqreiN9yQrc83YNAFCx4hq0a7oGsGWtaBko+ESMR?=
 =?us-ascii?Q?qnfB8dZXBUDmvPaXRhMhOTplbAZXiZEddEJ39ACNQsXtdDXPJCGxYkrpgWwz?=
 =?us-ascii?Q?GLB/FathufS55ok+3OSaHtR5s4bu+co5Nde7cX2dgy9AqERcJ9D2aUuCCocP?=
 =?us-ascii?Q?DoqXh3uK9cn2J88AZ5/4rsgq8YaJMLURTznaCrxKYSjLyBM0nrBRI5k5DHVg?=
 =?us-ascii?Q?UVxUE2RfM6BIHqpziR/V2hYz2OMj76d7M6y0ba6CZOhzF9Zss4ZmNkMc4Q6S?=
 =?us-ascii?Q?3jXceVEhe4w1hZgrUAhJFQDirOwrlIxBwYn9F4kbvF2Dt5JfOQZEtLJRWCrP?=
 =?us-ascii?Q?5NyHaj5gIpmzcavuHFXGrC8uo3GlOnVihyU0bPWvqI8O7GJKjB8DK3UfCtiz?=
 =?us-ascii?Q?TcyVvMUFdW2FiPvtFy54J6R3M4W7iejeYij3X/cYcMM1F1lRe76vdERHU0/6?=
 =?us-ascii?Q?DnM4J/8iV3+TjKxkWvlyH41pnkypEFIhNfVTyg32+A7/FJfgqowFuWUaYGHR?=
 =?us-ascii?Q?PjnlFUh8Vy9YMi9eVVDXLYndb8mo+x2leCWnoLcaNwMb/E3wy1mNIS3jC56H?=
 =?us-ascii?Q?YY0fkhJzwqAcepWqg8mI0UuXycfWfexK+V0v+rhStH83bstC93PqRo9foxOp?=
 =?us-ascii?Q?8XCe1Mn+ZQQHj675J4aamrzJbl8gtoMSh16Ti4giQ/FpBVTpla5yFkO2UkbX?=
 =?us-ascii?Q?wf9x29gnT7imR0sZXsjSLUPyN4RfdgSMc//bgO4U2UaRLKyfFE7ZKcrt2xUs?=
 =?us-ascii?Q?m/oWQnjPgcBv6Yxfnpp0qWhSmd+x4GCbRLg5qSlSW8W6fX+jOBEFZZYkaHuo?=
 =?us-ascii?Q?e2gRo+0W+P/F/tx16MxFCInlKKh8haR9mwXOl4nPd9mMi6N32Uec8+CfeTG+?=
 =?us-ascii?Q?INF/X3Fx1uBlo+wje/LWqFav+tAyNWNjQ16Pq6Xfe2cnYM52aXecbX8MO7//?=
 =?us-ascii?Q?4B4P53gckAJgRfmIUb+ApHrDNOTNgBzUT7pTndYaCMXM/RQ93ByEs3vaJwEB?=
 =?us-ascii?Q?z5E4SXgonwuLXF5CUulD90dx1AeGAvlm43GUQJov0izvuuo2Pu8daK5BoeE/?=
 =?us-ascii?Q?I8l6awf4NtqlgZ7+UufC9ft8OYaTRxb9jCOWXblKutkNU+IlldZKgXo9C9z6?=
 =?us-ascii?Q?UNXDx0ERj4gKSH/yetvr9pfI0AbNhnw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sjb9+FD2ZWWGLrFF3UcxmzFe6dEHo9osJlprB+bY0uCoDbLVV/ZoAXMoJp0nGIA38QGPvd2CEjGEyuIdtSterE6TDzqaRTwOi4t24ArkQd7Lis2ZSkxfnsreYxAJUxIJn57fmqug8c3riVwoLgikGM63jcqciiKcNEKV+goidzSFNCt1/nS3pr2Ub4UWzr6IWpmIBgEohACni3D1FXS7isK3P635b7gE+A2HV+pvgvDiVhhLTJo+YV/MZNTrHho/1jbJQe5FcMQJEAf2L6abGHBGCRPkIAnzbXwJo7WdL5VjNhpWTsn2W7Y9u2MKat7/jDKrDhcnX7iWey9dqiXU1g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2da8d7-90e5-4750-98b7-08dedd9c8569
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 09:29:05.4937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOwB5vQVsHphUVesb9SZtxzUOiLQutDWxhsyQg0cZwCznbFcZyaJigOBtA85UomgLeb5LHOZ3DmHDeB5Fb1Bh42n6CRPLCLikg5acqEShWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9539
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306114-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:aleksander.lobakin@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:nxne.cnse.osdt.itp.upstreaming@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8393072F0AF



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alexander Lobakin
> Sent: Wednesday, July 8, 2026 5:13 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; NXNE CNSE OSDT
> ITP Upstreaming <nxne.cnse.osdt.itp.upstreaming@intel.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next] idpf: add flow-based XDP
> fallback for FWs without Tx FIFO support
>=20
> From the first days of XDP implementation in idpf, it relied and
> worked solely on top of the queue-based scheduling Tx mode, which
> basically means simple FIFO. However, turned out not every firmware
> supports this mode and XDP doesn't work there at all.
>=20
> Since the flow-based scheduling Tx mode is mandatory and supported by
> every FW, introduce a simple fallback guarded by a static key to not
> hurt the more performant mode. The FB mode generates a completion for
> each Tx descriptor and never guarantees that there won't be any out-
> of-order completions. Serialize that using a bitmap of completed
> descriptors and report contiguous blocks of free bits to match XDP and
> XSk expectations and avoid further code complication.
>=20
> The usage of a bitmap on hotpath might sound scary, but this fallback
> is able to reach around 70% of the QB mode's performance, which is
> comparable to what ice gives us. The main bottlenecks are unlikely()s
> and one completion per each descriptor, while in the QB mode we have
> one completion per batch (which might contain 64 or even 128 frames),
> plus the size of the completion descriptor is
> 8 bytes in this mode (4 bytes in the QB mode), which means a lot of
> additional PCI traffic.
>=20
> bloat-o-meter shows .text increase in about 2 Kb without adding new
> functions or uninlining any of the existing ones. I played a bunch
> with inlining and uninlining certain pieces or the whole fallback, but
> the compiler collapses and optimizes libeth templates so hardly so
> that each additional external call only makes things worse.
>=20
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h      |   1 +
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |  11 +-
>  drivers/net/ethernet/intel/idpf/xdp.h       |  60 +++++++++-
>  include/net/libeth/xdp.h                    |  13 +++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c |  10 +-
>  drivers/net/ethernet/intel/idpf/xdp.c       | 115
> +++++++++++++++++++-
>  6 files changed, 201 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index ec1b75f039bb..5414bbbee07a 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -384,6 +384,7 @@ struct idpf_vport {
>  	struct idpf_tx_queue **txqs;
>  	u16 num_txq;
>  	u16 num_xdp_txq;

...


>  	old =3D cfg->user_config.xdp_prog;
>  	cfg->user_config.xdp_prog =3D prog;
>=20
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

