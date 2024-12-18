Return-Path: <netdev+bounces-152941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A4B9F665D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD7E189390C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338411A9B45;
	Wed, 18 Dec 2024 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2RS0vyF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D85157A5A
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734526929; cv=fail; b=oxgMBRgqOfnF8EbrEPuDRkPl0Pzvxvy81jLZEppSOtEbqmWqTSIXyHx94cfpu4lZE0Zrxmfohn+2VUgetd+LxkjKN/O5MgT3aUYGyqz7+2miLF9NNSamBNJIBZRGMiS53au04XhiYAxqvsxhkBhH/iyfyECoOGE5CgD8lC3CbnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734526929; c=relaxed/simple;
	bh=cFuNKzVdEyZisdXKZW11zSsIvCQdqy8o8q4oPltfrFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0eAV8BwoFLXqGKQZhixL19G2QdMjfMp5uSm0ShihteHVVjxi17E20WmoMOGHxxXPX3nmYxQVGzqEw6JDUoahQCfvX7mV0+xmId0tBR5LPUaViQxK3OgMjpuxvC47x2Cfe1oDyJql55LnhT33pTbRmoV+qXvAmcjjgZu+HvDhcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2RS0vyF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734526928; x=1766062928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cFuNKzVdEyZisdXKZW11zSsIvCQdqy8o8q4oPltfrFQ=;
  b=b2RS0vyF+7LFCcDqFEB2ICa79aV8WxyoVCukjEDkwIaTIC/CyUwV1LFD
   n/DqalElaigMyCB3wMsQ6+DArdYJYxOxcdEdDkDoljUQqxWDqQu6toeGj
   ICTrYsLMcGOq/MJUJGUVZ7m715mVJO+f/7Mj9C5Gw02mjkiLbQfrx+Kl1
   1YxxczYK2GfvZF3Y/JtpV/btLWkFsGuyV7QG04oGU+pekqVykBM2GdGx4
   thdOsBxNpD8RwF5qJiuH/qMK9kgsYuaHn3iXzwhQ9Cywg8JmOzL6mYixH
   uw1oyY7C2Z5Ex031Ufh6FEadNRBgtKuEXjcB13E5ECjE4DJp80bH6IBQt
   Q==;
X-CSE-ConnectionGUID: oPRRzl8nRQuOnpnY4HwgRw==
X-CSE-MsgGUID: OkI31G1LQ26xh9F/63KImg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35153778"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35153778"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 05:02:06 -0800
X-CSE-ConnectionGUID: 1gV2BvvIQA2xI7h8k9ESUA==
X-CSE-MsgGUID: NiVvK70MSlqs1zD+d/b2Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97698051"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 05:02:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 05:02:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 05:02:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 05:02:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qujTT3sWIJGUPeSm7dNbO8YA+nriU10mXsHE8hyzrcC1/zjpWHDseyav7NmDOE5wPALcJtpLB5RMt8HMOE7kkd+2kuzDS8eIj/boBpYxfrTTbkTXY2hng4td2o99IJCIB2ZCY6cC/SGu2/MoSFOgaEMK4x6snvtvRVK828cakMY5esnbTnlsSs6FZQ9O++8GrSX22frWMWAmmX69lbNgElqjd8lvbpOgIC6P15vfxHPFF4O1FYwodFwodiwH6twjrMo20OaKVvuepGckl7eIM81Fvp5ytpyCmjyqGEKcy/ohMZum/WOa4n/rzWNjLzifaKJ1G7LrrQ9tbNdCY8qsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1stIlSoLMrOR4yQDaJT0K7aXy8pvq7Wk+p4gawCfTI=;
 b=EFMCDFo/ODQh4p8tHld2EEFHbaYpOanJSny23x/B9GHD7HKAhm0n3vNMm/kMPtlNv5KsA19cHSfE5xABBTPJgD0G9iB7N3WHJP5WF2yA6NcMjfW2DaaQ59JIw2AlqIch353NGUhe4hEoZ308e0rDNv1DWDtc6NZw3wAaFqyqzZ9F6ob3TKWbnxBulMBYbF0aQnxLsAh2kl6jyH4GWJ+sG5osIZ/6IT6np2+3hwyjA37LE6j9y2v9NqYIffFklqaEIVRMeUDxzvQCyvI1Wh0hIsAHmSi7rFA1sw8lHSdlhCDdvPmZH983JXNUY2VydfQxmRPmutoKwES4lC2bIjhx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by IA1PR11MB7941.namprd11.prod.outlook.com (2603:10b6:208:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 13:01:22 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 13:01:22 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Wegrzyn, Stefan" <stefan.wegrzyn@intel.com>,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v12 4/8] ixgbe: Add support for
 NVM handling in E610 device
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v12 4/8] ixgbe: Add support
 for NVM handling in E610 device
Thread-Index: AQHbRvImMzkrTntqqEqgeTVZyU7n07LsC9jw
Date: Wed, 18 Dec 2024 13:01:22 +0000
Message-ID: <PH8PR11MB7965671662D772EECD3BFFFEF7052@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20241205084450.4651-1-piotr.kwapulinski@intel.com>
 <20241205084450.4651-5-piotr.kwapulinski@intel.com>
In-Reply-To: <20241205084450.4651-5-piotr.kwapulinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|IA1PR11MB7941:EE_
x-ms-office365-filtering-correlation-id: d2a56364-1455-477b-29ea-08dd1f64127b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YACp6aByiSSuHl9UOtLXK4fK1g+KKyxKNdy/wwVShbP0mChkPD++P9JN4yTH?=
 =?us-ascii?Q?j+yyPJPSwSSeBKTIHHCvtHkSOHnaT49W5g/Or3ErWFbmBP0x/Fr/qD+cgxxz?=
 =?us-ascii?Q?7KMJwf+mIf5DLVQRs4qdvfF/qnLaLmmc2sALtJ35WsKlnTJJX3PDHeWtfIAX?=
 =?us-ascii?Q?QHQKkndxlQLgTZrPwaiD/GXuzSJs61gpsi1ltrhMrTaImJX0DEnVWSNI644C?=
 =?us-ascii?Q?LNlXiA8PT+nCVAnD88l/kbf4U4y5QGw2b68LbIH1t1FXKVC5BYRxkWt/4iMT?=
 =?us-ascii?Q?jJPvK3tyd/wreqeCSm2k5e9/SdSYPEa4YAstPBXnQcvZ9jY15hnF0b0mLOkW?=
 =?us-ascii?Q?FOHXKrd0dJ1ctx97yzgVp9JddcsFpN9GaofLlIS/+rt1qPT+FLxKioHqptsu?=
 =?us-ascii?Q?nltMRkqfL9ABD0P8eRas3qQW6YSalB2194UTYHiUPU0Cdp3MD5HsjhmZHzoD?=
 =?us-ascii?Q?8dqNrtTlgP06o1jGjCCYUEHvqXcMjkE/wt7I1z9hoDck+sLWaMbnafjHJX1s?=
 =?us-ascii?Q?z0qS9JeuFbdkMBgsIIncFXpXwFr7DtLCtMc9K0V6d3DVNaRSb3nUqaPSX/wt?=
 =?us-ascii?Q?rV5YRJrj1iTDlo6SiMl31hrmbthBhGaxVGaMqAL5g9ykCC0ULNqjyB7/BWYl?=
 =?us-ascii?Q?I4vLI7NdqggRzMK/MlCxTg/lKRXV13a9frg7ug2z9K/WXlHCDuo2zvMHjWTn?=
 =?us-ascii?Q?bbVVKHk5SbvaS0SduTyqAUuOEcWCRykg7uSgHeLLJOk16a510gdinc/rJX8N?=
 =?us-ascii?Q?WwlHlKUrqqtucEofS7xNl0CeMLqLyfmajXXvlNUUe0rKl/FjUz3YlYXy/HMG?=
 =?us-ascii?Q?JsdWRX9+XImpoH4HaAHMwfrlx5cZLHbTXQ8U3b2KzMR2I+7op0X+vjcVIARm?=
 =?us-ascii?Q?Jril/eLq2byVOgkK4FFYfcfRVtG969OSapgFf+0mKsXuhVwYdLKaBWBZely2?=
 =?us-ascii?Q?OA0i0+Fxirs+hIhzJKDMqfSvFBNoId6YP2TQdWEDK5/ZvHu5AZDiPeF5oY04?=
 =?us-ascii?Q?WYBMlKO5nnfc1cX6BB7ar4YOsBoAeGU7S98kTGi0AHm4yZWhd3IKY+BTdVXD?=
 =?us-ascii?Q?KOBE7GxsKc/4UHRv9jkQH7JlmG/HsxY+PLoPDBKNGejNcv6fH5NfSnR7e18a?=
 =?us-ascii?Q?LSauwlpL43X6zh8aNDAb9hCoDX3/0DL8XmSrNTbORNdR14EDUh3tptQoOp0t?=
 =?us-ascii?Q?zEJuSU3yLxeBLaI5437bOsxjgikLIiuFlUN+g+c9r1o2Qm0j/jT4Vm4FZvPJ?=
 =?us-ascii?Q?+vlP5aTibp0mDUEu0lCkJCecZaGM1a96MoZKMyjcRn8ZtcSKLEmXI695+DoM?=
 =?us-ascii?Q?H5pUFQLPoN1Q6MCCcRLgIl1tAUvmXfcy8LZyOcSbzC4Ja+1XZnWJAGFqlVC1?=
 =?us-ascii?Q?51GpcVfUGA8RtEWM7yjHCIUdTSPQ/v6OXVdsUnN9emRSE9tfchL9xhrjpZF9?=
 =?us-ascii?Q?6xuKzkd0ZV0Bd9T5/Lk9wzlQWxpf7h7v?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zi5ONRPLiGfBraraoxzkqrtvVHU28AmPccawcvqkK+qEHdYiXdNpxEKTYx+S?=
 =?us-ascii?Q?rk+JHZLL6hTtXaV+HpzOg5B+DeRnIAt9gayZBXfNJzw7zGe1Q5SpHMSvLsSB?=
 =?us-ascii?Q?kNhh8mTrmJBpFpSrYTMn0sRaMls1XmS6Bt4xPRhj3Iml3tCfJf6Bcq0a4qjR?=
 =?us-ascii?Q?bn2gVlITpGhdF1hsK4Z5CrLmEWR36W6Bv7v6l0ufjxA+3hj96fdpry9dJ/2j?=
 =?us-ascii?Q?7bqcxKW4z1bJOnrK/sZgA5SoRI5nPer2GOUQFWTVIc3b0q75vWjcfFqSwlVA?=
 =?us-ascii?Q?KAhcXkg9EJ+Es2zuwPi8lqRYpIA9zvC+CpWB3kgysIqcjsuuu7190sOZ2nDJ?=
 =?us-ascii?Q?VFN2nRS/UVF09aBl6kQTQlPCt0Mm9k01MRDzFt4zaX9ENF7SGtj9dVH3jLVs?=
 =?us-ascii?Q?rtXNLLr3c0cxnryiuhAxGpFiODaz+3QuLSuBwevxrSvlQghwjJ+6GWC9f+M0?=
 =?us-ascii?Q?Oigl9mlEKZ4GT5rQnUvykJaPE7Hwewdm/A92OUFYn2GcWTPrIhDqKPUAoo+z?=
 =?us-ascii?Q?HbMLb+Ie4XV6HUWiS4oVLb0/X3Wm6b/NDO6G5WpwBvH/RtlzWEKhBwnWe+HW?=
 =?us-ascii?Q?iMPbSpGUZXE7rhJKcGGyMWNi7IDa6zOX6vcanf8iRzrI04LUBBGvApif9dEH?=
 =?us-ascii?Q?Y18L6DDiggn2i5PVAoin+0lVa6eMIrKuGjpg7+wgRLKiI2sg9Mx8KP86Mp14?=
 =?us-ascii?Q?5nCPB25vxHnCi5FVH+ZTD2kyWmE2Kdlr1Q1b3Lo1UVgkAgOUORSliuwX83Uo?=
 =?us-ascii?Q?bf4fvNWA2AP/O/NClAza4RgvJBc8bLlwjHlDs3pOnGHo3HqCjSCyPAJNn7ah?=
 =?us-ascii?Q?yvE0lfFdQ4BTO3d4+PbIrDiSjQFjWnII6cX3ahwUuk+vOUMRA7pZVGrcXV57?=
 =?us-ascii?Q?vRD4GjHDS5BS1YaMSLUTZPpv5y/9D/hqGaQLY6U7KDnoWzJ7bOPE0r4g4Xdx?=
 =?us-ascii?Q?nnuNuP1l9REXWHWx0L+x5p4hkAgwyG66SkPJNw3905mEXgiamSYEGY4+TqoH?=
 =?us-ascii?Q?u5bVpZrIdOrBCILki2++o2TOFFP777/qUWXcUbDNAkviuQ48W38s8MzsnQNj?=
 =?us-ascii?Q?+ABTP9dzJI4vFGmpIeFXNUl9cA4DGj+/dJ/s5wJDS3fWXNoc0d5/+GvccHut?=
 =?us-ascii?Q?S64YyPu1J/axozoTt+6DxJaynH7hakkCFn7jJ10EOuYiD4XWl1U+Pf0u6E/O?=
 =?us-ascii?Q?n6eAeXtDpVlmJ7XZoBaOasDZdrHphyp5VpD3UImxhJaASlpRMf7l5+pIQv2F?=
 =?us-ascii?Q?4GKiJMKEX3JfhOgSe5hFbq0koNG3kgFw8bL8dNs19nA1JJI8N2mjuLB2Bxul?=
 =?us-ascii?Q?wwdnxNkmLPc/GzLumbXQOqfcHcnWd2mW/wZ6+5xTswOvrlr37lsLkq2Js9SD?=
 =?us-ascii?Q?LMsKkxmIwffbsqbQfT1vGXZsM3IsucwsjX+FSBtPoqWwWH+e0poFW3wv0bag?=
 =?us-ascii?Q?tqvs8G0UtCB3J0Fh8kp9OD8H3msLSR7c9d7Hy7v8/IyK3I5a/4T94+3F+lln?=
 =?us-ascii?Q?+szdZxtAhk5udAvjpsHJW9HSyrP4E4KaNb26ZXr7tjnAWvKhnlLbZjiegS7k?=
 =?us-ascii?Q?Mervm5cB53/ZkY6ON6zo1WlTVzXdJW/EoLtBl7NJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a56364-1455-477b-29ea-08dd1f64127b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 13:01:22.3302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3//up+4Ha71GsZ9V0jEGOtJiWumdHsleUDaOoIZkFb6gEDGBqhHAR8UoeTFk3cFe6kjTGf9Hk6ZATAFQsBs/dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7941
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Piotr Kwapulinski
> Sent: Thursday, December 5, 2024 2:15 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; Wegrzyn, Stefan
> <stefan.wegrzyn@intel.com>; Jagielski, Jedrzej <jedrzej.jagielski@intel.c=
om>;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Simon Horman
> <horms@kernel.org>
> Subject: [Intel-wired-lan] [PATCH iwl-next v12 4/8] ixgbe: Add support fo=
r
> NVM handling in E610 device
>=20
> Add low level support for accessing NVM in E610 device. NVM operations ar=
e
> handled via the Admin Command Interface. Add the following NVM specific
> operations:
> - acquire, release, read
> - validate checksum
> - read shadow ram
>=20
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 291 ++++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  12 +
>  2 files changed, 303 insertions(+)
>=20

Tested-by: Bharath R <bharath.r@intel.com>

