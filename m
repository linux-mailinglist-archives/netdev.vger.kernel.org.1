Return-Path: <netdev+bounces-174095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D824AA5D663
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 07:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A88B189AF86
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 06:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD61E260A;
	Wed, 12 Mar 2025 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8guwhw3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0635947
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761399; cv=fail; b=JIJ4oDPkI63S3IiCsVKk+slURinIupHfIDetLsLX2qXujvEiF0ebyIJdQKaASSiTyNjl40G+u3ZKtIAAeZRuswb1slkzqJ5ityipL0/EaaI2PmnTbB4aVUuBUT/LwuDly5uq3jF0wTlbuzLo80H8wSbuZy7NPp4zICE9k78zyQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761399; c=relaxed/simple;
	bh=amykVsjkgb9cMDN1oenN8uA7lF9F/oyc5SJgodOpzuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DdbTLIHPWYM4o41AX5apmVPN9xEhNjYqYCQRsckFVwuN4yDf7Gk0wgD1ouIq5uqMzOmh8LzV8RZlKORz8yyUmn96Bm6FXcXbusf98mlfS5D8Wrtd+u/7Dzs5zqEdDghI1xVxnbF84pUz/M5oQCVTGU7Mgc5OaHmSukVexz9RZ9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8guwhw3; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741761398; x=1773297398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=amykVsjkgb9cMDN1oenN8uA7lF9F/oyc5SJgodOpzuU=;
  b=Q8guwhw3hTyJk3hRRZiF053ksIw2W8aQsWKHBZDgSjxA3/Jaa4g9Bv1q
   uO1NckNMEBEJHzKviCxjOY8NxL8Ai1wwmRQL72ESugYdFPinRc8dn3GZa
   tyzgNnuLslILRpTPBWReC5cJnUxeo6K0IdUycEXYPlfRqumKHT7VUXA+T
   1RXiLPyucTocTQar4UNaxtXP3JOqPKvg8RO3pB/c7z3PX4wF3Dc8kXumE
   YBECEtoZbNEe85ZeLInVf7haVMlLeCfEntjdXkgDutQhnRawz73lCPFXd
   TxGk/0KCvS91oFhE5Cvx2Yl9FHknj8kSL5KvtwEScO9Khblz1cSxHbBYL
   A==;
X-CSE-ConnectionGUID: Q1QNVhpCTCKVECyWB/GzTw==
X-CSE-MsgGUID: WQZEU11XTm6sjf0Orsuoag==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42739251"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="42739251"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 23:36:23 -0700
X-CSE-ConnectionGUID: 9YODJuGYR/aUCJb/UxvANg==
X-CSE-MsgGUID: CBgh/y7ETCmYlmbI/TupJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="125578950"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 23:36:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 11 Mar 2025 23:36:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Mar 2025 23:36:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 23:36:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJJNMi4jFMITaBECeLKvefu5GmWuOIH6Iq3VtfwkswZzYMwD9fCm8+ZcdHRAyiGlrQevj8E0HV8dFgngpX9NuPLzB7Hyn2IeIsn2W4q19QbwHkRCIDx5/WmHGgA80ZqQF1ca9zBiqihz7qntSuU5vDzz5/nsklI8y7mFVNLehUBnOufEI1hwfxnl+nZKTyFB5eChTCdjAtvp5vhc3FKOl/0nkA8hYJMh0RJje28517mJTMk/LyNkounTIZ6nmZlVqXMeQDTKxZ4w/c001cBR2s/obja0AsMPCs3LoMG4QKhZ/QfO5sNNCPmR2kUPIqge4ZcFVRYWrINBq8WCMBlOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe9jFkK2WtpNKjrFaP2WDJWiOc4P6vQdfQ0PM/m28To=;
 b=dPxztWH0PwpJptzy3c9xq/fNk/hpQ4O/918+0VGxkJkYO0tT74NRyiAxHO6sRCdO86AIoU+rZ2u0PHIRrNEm6030twKM6aMrYT18janTWU9t4qPBVKck7ap0EMU39baeL/aTHUpkK5O2RIHvBcTotLVDp9U+AhtKKWf/TeB3GNJ71IF4GaoxFD3GOU8sRM3Dv78JPEYin143hk7OvxQvIX/qy+LzCiqct5jzHOHYllgVFhKqT9yvs+AzmqHGSyH5UqdbrX2Yt2/xXI80m9KDzTc01FPt57iJhaaNCGsWJLr1WEHoj3uhSuaU8l0fwcOHTJPC61pQQKiDQCOjuMKkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by PH7PR11MB7026.namprd11.prod.outlook.com (2603:10b6:510:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 06:35:39 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 06:35:39 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"jiri@nvidia.com" <jiri@nvidia.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "Mrozowicz, SlawomirX"
	<slawomirx.mrozowicz@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 08/15] ixgbe: add .info_get
 extension specific for E610 devices
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 08/15] ixgbe: add .info_get
 extension specific for E610 devices
Thread-Index: AQHbj264jaWGK/VQSkqty08bfkz2A7NvEuog
Date: Wed, 12 Mar 2025 06:35:39 +0000
Message-ID: <PH8PR11MB7965724871DCC80D6E06B8B9F7D02@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20250307142419.314402-1-jedrzej.jagielski@intel.com>
 <20250307142419.314402-9-jedrzej.jagielski@intel.com>
In-Reply-To: <20250307142419.314402-9-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|PH7PR11MB7026:EE_
x-ms-office365-filtering-correlation-id: 3027c205-61c4-4684-d3bc-08dd61301ad5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?1AuSlzneLiSnXET58MF9cHyp/yMZoneMFgIR/kbfv8mJ94Wo5/EVaRlh4rQ0?=
 =?us-ascii?Q?V3UV/3zGfyS0SyIE4loknT8T/ZteECuLvdaPeszTNiBrX4CZsvyyeC5hXx7M?=
 =?us-ascii?Q?Bd20T4cjqlv4SYORoMpOlGtuaikAawlCfcj04gJ+agJsg3hcIDFx5z8VIrZt?=
 =?us-ascii?Q?GQoDDnApWbzchDMwdEDojC622lgiUn6A044xznlBfdDTU7uXD9nRPlefTz11?=
 =?us-ascii?Q?BWwnnz7RU1UX5HgxtU/YlmEXTp67C34VVNt+RsnQ3d4UC2AoFnb0ZBhgtd7E?=
 =?us-ascii?Q?F1BIFaI7N0Ida0aKR46BmUR8Ac0hbDn6OOX/IuRR+54LUo3aVZLkWu0spV/V?=
 =?us-ascii?Q?jYO8NDgt4w9GVKZDV62J13XvNlxl6AK2zHN9wAbFYsckcSxHjP0bM9cLiJaL?=
 =?us-ascii?Q?ArXzXSNw8RETWkk07AmNdfnh60lJjk0pUFpEM9BDOjt3quA8JbJfPitLtM9D?=
 =?us-ascii?Q?EfiR0Q93JpaqKHUwhFgtceTESRw53Kk+Vu5ItbQLcPaqDp+VTNa4fWWRHyUJ?=
 =?us-ascii?Q?HP0k+DnHiTvFlJ+qx4nWAb9H2yj6+llEiXTUQCLCfncVw2pPAB8QmVV5y6BN?=
 =?us-ascii?Q?TNPlmqTy5dqej/SAeB4Pml51GWl96BwDl79H8pR3flL80PjE24AKsQWdichl?=
 =?us-ascii?Q?ayN0hzI9YF0tDPrR7yYqgKe4hvfHXh5+n+4H2JpdfTYP34IRyliejwn6ifN9?=
 =?us-ascii?Q?CGcvz6GUwEiuSaV3eGpR+219O5qlxx8ZxI+1DduF5cHpYWBhvhv2domAHoRZ?=
 =?us-ascii?Q?X1chFpiFFlChVoU8hljK1jUf7m6ddRrxr1wfJfQPQNlqU4oK1lkxZTgNljGQ?=
 =?us-ascii?Q?rMs5RtI0IZs2l7Rkm99QvAEWcqKfbeVUn0XAM6EXhNhf9olxZFzFzlLb/hqs?=
 =?us-ascii?Q?6WXmZx2TssGbSUI4C9IogTOldDOqcwQJXMP8rMK5DC7ApZGwtAcwbs4Dow9I?=
 =?us-ascii?Q?sglZiPAzB5s1L/ACHeeGSAtTIPHzELezzrOYB5M61aid5mUNsh0ZeW9IvyyX?=
 =?us-ascii?Q?p8sIYXKuevd6riE1bFI7DeZnHyw0tPg3bOknIfxqe3sD9JrXLrCfJ5nlBx+8?=
 =?us-ascii?Q?SZ25Bq817Up/P7IyogkSRMQtGRX5S9XnRkHmn/rFdw4Qc+91CYF0TS1F7ERR?=
 =?us-ascii?Q?1sa3TeuuufwiElOSpsc8y1DEEsr2w7+IEQmgsZGM8c4nA8j1JnK1Cd+HZ6iU?=
 =?us-ascii?Q?mKhTjnrqyXwCHMWdWhLDqQUlwsiadGur6zMiXbp7PPUlffHuCIHzFFsZ4tKJ?=
 =?us-ascii?Q?i4bQw8cmJlnJk492HrKvb0pxBSh1o0576wnfKjQDSYSXO4JVGwoU5OuSC1N0?=
 =?us-ascii?Q?HEr38E8ciAS7hDZY5PpB44ViqZ/GNvUJeXJx8NkTyAZRQBqYjx2SiREi95Ay?=
 =?us-ascii?Q?Bs8ZxEkzflt282+9k4Bdg1W43FUIz7QIvwfYYqYXBUhfoeY9G5k1ms62cJ/m?=
 =?us-ascii?Q?4sPM0Tp7FVOQfoPol5EEWZ2GRUjDKAWu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cD0V3BpVoQq7akCwOalhvTEdh1BqI7dMxy0H1qrpCH1Rw12JL7aLYiPbRrAn?=
 =?us-ascii?Q?InxqeOeRK7gG+CNEjM1BqO/btuVQCXReGe4N57A1FncgvxL2ip8Ap2vCfMSb?=
 =?us-ascii?Q?HQicKn9ye6BMV5nxnUbJp++pyxQio1LmZtoDPFpvuXUiVQysLbh1ZYKaDTpv?=
 =?us-ascii?Q?OZGeyMsbPnCCRRCL6NiRMtwcFasGLWch8G2yAfJSViqRPghHXPSdMbf/V6ZS?=
 =?us-ascii?Q?a/SzkUvuGgq/5/fI2Q2o66Vg3hx9HO/4m18TZdLT8HPjM8RGAnwKXojzUB+i?=
 =?us-ascii?Q?VVFVhSe5nPRs5ik9kOkS5wW2IBTmSDpz5GQ5liK0lfQ8zB8aIQtbHtE+lJvQ?=
 =?us-ascii?Q?7ngH/yVOrVan+32PmoApsOx9ktCSatMkOfJigTCiuoWQ6L6iDXmpmOP1bMcy?=
 =?us-ascii?Q?7dVZ/HLOz9I9WvzE/q4XIq3k9vjSXwtIsUCCH6gn4AIonrXjRe687Qbn5aFA?=
 =?us-ascii?Q?5VQoIm3i4C8q6/24dYvDMXeNzpmgqrKsbGDsMpeX4xkknv5QqkNw924+FEk2?=
 =?us-ascii?Q?65r3LdGo1vjVYP41j6aHPkuraf96WQ4oqjjWAgf4jn9K/1GJImoTCYjYt1Th?=
 =?us-ascii?Q?gsGoX1pZxQvTpdPStE/KTrdgM9mues2hGKZ3xEpLH803a6mZCun9fwer8LUw?=
 =?us-ascii?Q?Ep3vi9Qp0ymGBvVIpOqBRXsNrx3yh3O9jd62BNjRPs9BQt94nhyn0wN9jad4?=
 =?us-ascii?Q?dZVYSMFZlXUpRVMj9hgsiA6CwtxQ2B7LcLzXrJ+R8fn7vGJ0vJXEi0Sj2ima?=
 =?us-ascii?Q?bwcADQ0jEE3Hofo6KC5zQL8cebulv/I7/hj8Pf2URMyE1SMCJ7R3uS8895y6?=
 =?us-ascii?Q?KGMCGetu9ZkJIU3yQ1FOA7vphQv6LBvdidXSczV2d6khcgFSrYH4nL0QlaWU?=
 =?us-ascii?Q?+va1OISXx26a1QcrlU4dloDLG725W9wkHNNOKWGUjPrO7ITXPHaHWFKrU+QM?=
 =?us-ascii?Q?ZXqH+3QE+C9RY1bonnajh9eikLRGu9TK5HB3Pd7s0o1LSmPY+NeeLxFdnsfn?=
 =?us-ascii?Q?/D+iB2Bbs1hxsK6p+THaDwhaR/yGvx+6bdWCj5zUFqYjH8bwCdRBpKEQijgi?=
 =?us-ascii?Q?Sf67BcBEqDKjfJsz81VFXnBpfFi+ipTDbh1OUOX9Y7vP7yAp5j60JUAPPHOt?=
 =?us-ascii?Q?FqNPC53+w1GieL9AiChZTRF/fZ+V3Nnyy6dBCsi96BfgQltiL6j5QkCirtn2?=
 =?us-ascii?Q?TayCjYGV1JF8EBiBoj3zsG6qyKd+018gu4Qzrzef2MD12cq/yQYglOwGKNl1?=
 =?us-ascii?Q?pB9oJc6G+KaqzX6MWkOfLirRYZj1dxdT8WdS4nW1sr7/eAkWNIQV63POntJJ?=
 =?us-ascii?Q?C/2C0vpjv4ghBbTkRW2aEXAUKHSd4zhuSQanGpR8DtbNwzA+pgP7l7vRWAkA?=
 =?us-ascii?Q?KI0tBdTI3uCBD3449WKLq/7TFCA/wbjQAdOzzYUxN7zye0zatGfhg9RFinGb?=
 =?us-ascii?Q?t6gXRc+DOWqA/rM5cxY/ran5jA/DVRbCRCYB2n3GitAesCgDhuPUyI47iblR?=
 =?us-ascii?Q?33b03eCjytpaDW6IdPI5W8omAW3h00NuzvI5THgsyUQ1UQAODjw6SATPBnhR?=
 =?us-ascii?Q?+OUVG+LcgpYxtuWm3RjKtdqyPRrXzJ0ihGT4B6k6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3027c205-61c4-4684-d3bc-08dd61301ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 06:35:39.2641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdmASqLtflcXGOWo0Mhn0nARHDHMWCZz6Uc1dPGWkyJadh1aTLvamoAm1L9e/L0yGsqOYvJE9CraZsfS3jZd0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7026
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: Friday, March 7, 2025 7:54 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> netdev@vger.kernel.org; horms@kernel.org; jiri@nvidia.com; Jagielski, Jed=
rzej
> <jedrzej.jagielski@intel.com>; Polchlopek, Mateusz
> <mateusz.polchlopek@intel.com>; Mrozowicz, SlawomirX
> <slawomirx.mrozowicz@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 08/15] ixgbe: add .info_get
> extension specific for E610 devices
>=20
> E610 devices give possibility to show more detailed info than the previou=
s
> boards.
> Extend reporting NVM info with following pieces:
>  fw.mgmt.api -> version number of the API  fw.mgmt.build -> identifier of=
 the
> source for the FW  fw.psid.api -> version defining the format of the flas=
h
> contents  fw.netlist -> version of the netlist module  fw.netlist.build -=
> first 4
> bytes of the netlist hash
>=20
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Co-developed-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  Documentation/networking/devlink/ixgbe.rst    |  26 ++++
>  .../ethernet/intel/ixgbe/devlink/devlink.c    | 132 +++++++++++++++++-
>  2 files changed, 153 insertions(+), 5 deletions(-)
>=20

Tested-by: Bharath R <bharath.r@intel.com>

