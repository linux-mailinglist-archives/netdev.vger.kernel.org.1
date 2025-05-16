Return-Path: <netdev+bounces-191169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C039ABA4EC
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4911AA233B7
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D322D7B3;
	Fri, 16 May 2025 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXAXHLDc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361031581F0;
	Fri, 16 May 2025 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747429407; cv=fail; b=hUdL8ovWB+p0s4t6rJHcfepJlPjB2MfaqGV/T6gfADiWIUMIY2Acb72trYnhaSgqzKVzVyf0PAETGlfPj7ZZFLwESAi0ToKbeUIccZoSV6dpapLlouRtl9x299HlIXz9qXX3Vv3QTjmnVN+siVEjeelU1hjzq5vkZfguvBUrgds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747429407; c=relaxed/simple;
	bh=lY5niunJeHSCxxRJJQ38J0m1cPfPKj3FHVS35sbFRns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sc6fUi7UimhC1GI9ijhV4+5HpIg1gjVyrcDIM4MP277+0rB7gOvnX+X+KxvkzwIpxa5nynDmjfzMbr8fZCXOnVDSp1SMd4MvbQhLEfg0ZPmR21374aRmuHUpJf4J3/5sH6aZSWxcbJegLd+QuBnJ53mlgHtdUaLxL4r/JMVZ0Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXAXHLDc; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747429406; x=1778965406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lY5niunJeHSCxxRJJQ38J0m1cPfPKj3FHVS35sbFRns=;
  b=mXAXHLDcYGo6vhg1owdHWiCrz2ut8AMWDfvVJB+/+YB8gThqfoSjZvyY
   G1WKpy2QosZ4fMjYqqpN4307nu+QukZJL6BrcVJPnDs5uzQbrw25sDNvf
   on4u74EpId1+/cV6GB1MXYaUDA2PTEWQJmmyrV2Viz/7RZVPFZbjwM365
   AXdoHpd1LxmSjtSiCW0ag0nOTBqP4qsmNvfxNZVun48OdLRr48Z4WW1Al
   vCAahGTqOVOjThTndxoCEhDNumj8yD9lHDDAQFUJ+xDuPVlwxltnDoZwY
   TPd+dFXWXY8pt7ykB55XTEdKBj7uGGQmufVqoeCLCOKGF4IrbHxjAKiwO
   g==;
X-CSE-ConnectionGUID: kX9YsebHRIKqk8Afuv9ZFg==
X-CSE-MsgGUID: /Rveb+5yR/+YQdM1Q0PYkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="53214779"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="53214779"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 14:03:24 -0700
X-CSE-ConnectionGUID: cfng+couRjqiZP7hD5ZNWA==
X-CSE-MsgGUID: VO78rVW7QGySgALpgXndMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="138535889"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 14:03:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 14:03:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 14:03:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 14:03:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma7VVU9mC5FLyFpcO21ZB8o0tTE2BRKDUKCErwK3UAPMUy8PVE7KuFAphlmHZlU+poVOfq6YhB2eoE2y5sLNay0D2SOO8KU9pNTuLP/PNWJFOIe29+/81VnusT/aKpIdXIN57wjMWz/9r7hphy3QuZEVdDxiKgQ7RXTTxu4/lguqC++a7ux9VdtHHP+5pQf6wnFBG/Z4OhBnxmsyVAc+ZX/DCVyxQoEVieAPaeCWnvaM3OLjAKZEWA1lySz/LSbzScM2LC5Mw8aBJoDGG1eUgVGQWPtDFLO5No2n0FK6/+pye+rtx8MjKeoHRfJBfi/YOrzb7Uv0AqDgXHtPfEuQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY5niunJeHSCxxRJJQ38J0m1cPfPKj3FHVS35sbFRns=;
 b=RFu+4RDOXF+aEQF9sAXQDCDED7rEUeaq/a2ocRkhWVpMj0WwYMmPvYQJUTBJzTsYVd7ChDXxycB7xTwir3mnwDIjJuBY1HpzOz5XaOi+3g9abiDNbZh1CZn2uP42KxJqK+cqez8EA50FAtLkB2v4gqDpAxb/03zmgMU+Dp6V3NHbIliuzlcG+TMLOdMGvVlnzqLZrtfuwvWvCpQqT3Xq56V/0nNAKgAge0wUTWTYGcE4G6fA0EaMr9BewL/4azhFyeivqej6zA2kSDwYwjnnwtHPDZEKx9Ziw3HNZUylV2hu4fEhZbKz+2Jf2L/OgF8/H2ExCTj4Id9k6+s1byrhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB8090.namprd11.prod.outlook.com (2603:10b6:8:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 21:03:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 21:03:21 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>, Jakub
 Kicinski <kuba@kernel.org>, "kernel-team@meta.com" <kernel-team@meta.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Simon Horman <horms@kernel.org>, Sanman
 Pradhan <sanmanpradhan@meta.com>, Su Hui <suhui@nfschina.com>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] eth: fbnic: Replace kzalloc/fbnic_fw_init_cmpl
 with fbnic_fw_alloc_cmpl
Thread-Topic: [PATCH net-next] eth: fbnic: Replace kzalloc/fbnic_fw_init_cmpl
 with fbnic_fw_alloc_cmpl
Thread-Index: AQHbxoLUeP1scDoaOUKCw5rHpN2LCrPVvszg
Date: Fri, 16 May 2025 21:03:21 +0000
Message-ID: <CO1PR11MB5089467884B7D4EC8059C4DAD693A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250516164804.741348-1-lee@trager.us>
In-Reply-To: <20250516164804.741348-1-lee@trager.us>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DM4PR11MB8090:EE_
x-ms-office365-filtering-correlation-id: cd2b18f3-659e-4871-3fc0-08dd94bd16ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?/TmwsxM4Eq24WHvWYX1MY71C+fz1N16i2yR2VUEiSg5hu6Z4BMEfPc9yXKA4?=
 =?us-ascii?Q?En76cC2Tug86GUMcs9YTGehk4KpPp0VyaemmRN5xb68nIFq8i+2Ooe5pqaJZ?=
 =?us-ascii?Q?KgBn4p/7KUOOK08ABYVwuoT2QaqHKKeMiYcxNigyHTMguPghe45gpzRpwYzI?=
 =?us-ascii?Q?XTj3yQUbd5vN/jjrwH3C2O4xq9LDCe+dtsOWVrnDmGLokueDi6oluH7drwg2?=
 =?us-ascii?Q?LWxhtFuDAdeny3XriD9JGGebNfkXynp0tkmhsS1V+TpJROXrmBrtabtc+c3u?=
 =?us-ascii?Q?Vs2jRlBs4edfa/8QDyjzRybO3z0rpDe8zY9EIijGBDgDjdNwUI9CmlyJUnqz?=
 =?us-ascii?Q?qeOfBdwAidBO9Rhpl6vpn2oHbb1ONKZMkbncwL7ayZEQit+Sc9hwjBw0RXhZ?=
 =?us-ascii?Q?QmTTURMXLdr22rSpaikj702Yar5A0cIT15Eu5jGzQPLmlYU4RCWQr0WB3pkV?=
 =?us-ascii?Q?m68yVYpAwrFp82AMn9+uA/L2KAQvlLnEGne4YSOl8BefeGyCLIW+qPdXHCPj?=
 =?us-ascii?Q?PYMFNfr3cU13XjWQrMJd3ZlYjAMdFaHWVbluucsdp0jvhAgrFZ78a+wbXUaI?=
 =?us-ascii?Q?2IeAaxFQdL5zBxtOV4Fyh/vxZnP58W3jQpFlgvYUxe6r0l0I0UaWQ2OdQoOi?=
 =?us-ascii?Q?8WNxFT22NaBAbX2h0jgiYdaa9G4euOmqZ6dGSea2jx+TiGFO8RNjRDYKNy6i?=
 =?us-ascii?Q?VtoN4Se33e6KUkbyRJ5Wxx1LR78w9YNS17brpxH+dnDM4dvQj3EBFX0x8qzr?=
 =?us-ascii?Q?oOGLP6sM6dvdJKAY6s0e7p4VAbWRDHfqfb2wOT26wApOEJgcdV2mNOkBhsdL?=
 =?us-ascii?Q?JY83t+UhnAYgVHxqhaJL0XhJq+F/irLhci+XSwzxjD+ZuvIfpP0P+xRJEqB+?=
 =?us-ascii?Q?+wScW/kkkuh3FyPyG6ujh3YskPIK1t4jCp/iK3jw7r21bnq5x6jPN/RIDEeX?=
 =?us-ascii?Q?THQ2k2+sR9Qu6n0XgX/0u3bYXgG8cgrVq8HsfShG2SZdUcmT9pJD++KYcQRc?=
 =?us-ascii?Q?FtPsire4+DMCkVd5sZoHrQt6XNMI2vV1PY7e2BV7l/tA5D+QVClgs4RU2cx3?=
 =?us-ascii?Q?tsvHg65+fpmazaFqRWeeCXkzFOCyq+R+ZNVOGCCveyhe7Hqy1XtXEjrVSHU8?=
 =?us-ascii?Q?Bh8v14i4U8H3FQn7m9Npi9JlI3497uxEd8x6LrY1xX950YX96APmTOo1XgJb?=
 =?us-ascii?Q?+kItsNgrjryRxoKBaLPFUdJWlT3jvLBC7vevrzs8jUo4q9rtR4Oh2AGu4efl?=
 =?us-ascii?Q?L2eR/x8aZ0C3WygOqd9g8tcSDy3+bh/KUafBFLxz8+0bbN8Vzr3qZSBsEN8M?=
 =?us-ascii?Q?YneMzv2NQ9UBLhbKQMGWJO3aXcdVhNWkI6R+nV7bLAj95qPP1Zd1rnFrBTeI?=
 =?us-ascii?Q?7103Wb8DBHHqRtxhmkanfexUNhdGlcxczN4bN/Tn7ZAudqNC7JCEcPWIso9Z?=
 =?us-ascii?Q?4ZAV+2L5xPvdISP2LmXBFTS0e2084/6IP09J8Sd5PrfwJCuaRA++3OLImABU?=
 =?us-ascii?Q?dxSOqdCIPAmx4NA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9TbTg0DaPSH/TfyI74k4Ab0CSSetULrmm6yHs1GaYZWAXyFS7X9k/3pqlTx6?=
 =?us-ascii?Q?e4HRPCu3bvMaIVmI539pugAmZF9X1LG6oOeRDQpSldEXiWkqmaY/SY/wCAZp?=
 =?us-ascii?Q?pCljwLGlS9vamcJqhTeqGe4gvWpE1BilWfcGuGZLUWsaPu7rBO3ISL2htRFW?=
 =?us-ascii?Q?sCMCJiUZKwINTBBzdHdrujxZ3CksHUDlvqxbSmRMPpx9r7B5XNeqBWR4p+6l?=
 =?us-ascii?Q?i6gsIveOZLfsHKlmhznUbnBbx2QgMycPk3jSPiUoDgrJsX6dA09v3dcHmued?=
 =?us-ascii?Q?TRCRnC5feIbM4yVeHvFGyjiNiICRHAsD+gC8e1sV2/gRcCNRzjhmFkuhell+?=
 =?us-ascii?Q?kHJJiezMee3SurtH5hoCAOSJltbwWhzZM/9U906ZOlkpUSO04m9+QrK49cKF?=
 =?us-ascii?Q?URzAJ/8lYjKNN8zhGtGIAToxdtFTnkqxL7tOieMM4n1eKzfjl6E4qd9pHYdC?=
 =?us-ascii?Q?VyEltKGcrR9RfFN23wSFEXULTrcP5ckVjo+iX1BUWnYUZNgN9EJq+bP2kFIR?=
 =?us-ascii?Q?ZDW3LYXlC031i5SukRQOJLSSykZ6POZRpUBp95AOBPeQTDnc9G1DHp6D7enB?=
 =?us-ascii?Q?XODBvWaD3+yJQgoRAIuVPd5+CGd0ABVyySPhFh3cy5zWh2WjU/0SACVu5r9g?=
 =?us-ascii?Q?x5a97S2Dkb23tzK30f+fgy6/HEoUvDjbk6Zm3xtSTPcA9Sdwtyl68hXzH1D9?=
 =?us-ascii?Q?xexBcy1/g21AWTfJ4zfnL6zh0+FnZ/HOZdDYatrq2YToNc9d4h8qWkN/xhSU?=
 =?us-ascii?Q?+chNUMzEk1EW8I0N79QdVUdRzgWbqoM9y9OATvfadlVkpUMKcYBemIUPPrS3?=
 =?us-ascii?Q?X570jn44W0CQ5ubjNppKuA3QZEPp+3BFyHINmAUhBsApp5+K0VVsSvzSew+d?=
 =?us-ascii?Q?fxxIO7GKhz/ZUrfFyjuTfiU1WyO4fSveav3LSKaoFfhnDL3Mq3X01mOgNaUo?=
 =?us-ascii?Q?yYT29iBHS1wcjsH95NEEuBAqRlZpWZ3MgCJl2ai+CGstH0HaJH4WU72CEOMk?=
 =?us-ascii?Q?kWurbENxzePBUjpruovMb8PmaxDFV3Lcnus30ae9e2IYbSizFU1nlDqyd1VX?=
 =?us-ascii?Q?BGcAmdpS8CHEYSxiCeCYXhEzgsJ5ZYsH7y3kpYXtwIcTT0vRVDonmFGh+ZiR?=
 =?us-ascii?Q?1klezamJ0yaRXQFL3Ab7+ALKR6hHg3Hz443z9xY60c4mwmVmM7f7Ie7jfYuc?=
 =?us-ascii?Q?lWr8UgZaAXfWSbDRPI+WNdceBgL8RPXyOw/jzavxu/FPeSn5RHvOf37acjKq?=
 =?us-ascii?Q?OBgJVUgvbSQdCGyzcr/fDFvf0rv5Oz/3wUk2vMbZKb/g+2n67eNrVXT2x2eB?=
 =?us-ascii?Q?DdAWOK9GoFNY86cd8hmQ/fiyhVdwH1jE+iDP53qPVAxKBYICwRm2fqsfxktl?=
 =?us-ascii?Q?tO022hctFIAAtBcOfZjUSmWQ930mcAQm1ZtvkV/w6qCuNtmVM9qegzllcH9p?=
 =?us-ascii?Q?vWbN6Fl3pBzImwNWsTv2NT8OIb6gO1bO0V5tNZjYQ9+bryPjP37YN2dlKVl9?=
 =?us-ascii?Q?a4lX9ybGULkZKUaeV4IgN7ZowjQyr07rHqj3uIXM0+YL0kCezQXWjtBRFLYR?=
 =?us-ascii?Q?yevaCVSs8oxakoUhbO9BOxdGTtx/FFicS/LEfFc8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2b18f3-659e-4871-3fc0-08dd94bd16ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 21:03:21.1970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0PBhZzcx3VV1rew/w1AH9bSGbbNfw4wYQh5zRncfGUufC/94L9Fq2PMK+ZrLT+K4UIy4X9REvLHhlZlYNHwGyxuMJssuHz/I66nxiCsqFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8090
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Lee Trager <lee@trager.us>
> Sent: Friday, May 16, 2025 9:47 AM
> To: Alexander Duyck <alexanderduyck@fb.com>; Jakub Kicinski
> <kuba@kernel.org>; kernel-team@meta.com; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Lee
> Trager <lee@trager.us>; Keller, Jacob E <jacob.e.keller@intel.com>; Al Vi=
ro
> <viro@zeniv.linux.org.uk>; Simon Horman <horms@kernel.org>; Sanman
> Pradhan <sanmanpradhan@meta.com>; Su Hui <suhui@nfschina.com>; Mohsin
> Bashir <mohsin.bashr@gmail.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH net-next] eth: fbnic: Replace kzalloc/fbnic_fw_init_cmpl =
with
> fbnic_fw_alloc_cmpl
>=20
> Replace the pattern of calling and validating kzalloc then
> fbnic_fw_init_cmpl with a single function, fbnic_fw_alloc_cmpl.
>=20
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


