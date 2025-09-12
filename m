Return-Path: <netdev+bounces-222406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE8B541D4
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62823BDF7A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 05:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BEC238C15;
	Fri, 12 Sep 2025 05:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQ5OPGAy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8862367DA
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757653248; cv=fail; b=RNHONrPIWK8hRdvBaCVdxbvNaxvAYVhCjZYZEia+gqsKYApjllgunWiiBI1on3W7+ZK35jQX9131+TWIiYOGvstwkFgcWSLGbuZeaQtHnIIHK9Ix23/cLSgULoQoOmQ9z5eZqjMu/icXLz5TAYDTGKs/bfHqdckDA1om/r4uD5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757653248; c=relaxed/simple;
	bh=cOgez3/2XEG697dU2zfX+OjJQn0NhImX055190si4xw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s0w+2vGB56p7NPUndO9YK0njGQ9GYpI6v34CVLWMTcslJIFnreE0abZLaRih27Aw9V/2XV/1KwLCBjntB2KccmxKqjpz/ZgOxNqDszqqLTY1VOIPCbxe9BvTdqf+0U5sZMD45g7PkGod7PosXI1YklPh99l3RUmMc+ZD3by0kpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQ5OPGAy; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757653246; x=1789189246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cOgez3/2XEG697dU2zfX+OjJQn0NhImX055190si4xw=;
  b=KQ5OPGAyA2STaog09OdgXBZIUEVBEqN6rXWdEKSCVvGiLpLwyNkgLTTB
   xdnz8TtDBJ9BMQcuUG3N/UsRI+xTjFgMC+/SlqiXytHfaGLbfXte5TPAF
   76bEh4yHMKmFy2cyfSsegmp285axle5Pti0iTUEhX0wCx9pDmu2lU7KLm
   d/Qjy78XQ+vcSJNXD9ctz2XwxuEQTouE70qxvGgl3hHRS5UdAERDMxFkD
   sWUc1NUkfhUa4ipGRy5Gjog1r6ea2SDDCI2AH7NdmVIDc7AwmCCkRaokj
   1E9EYVlFz+NK1SGbKHEAUYDSPATWPeJ+PtvToQtexDr94MLd4SpKqVX1l
   w==;
X-CSE-ConnectionGUID: ppzXy+pTQC+lGhf1xhePXw==
X-CSE-MsgGUID: xR/wp5L3TKOD8k/7peglEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59225072"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="59225072"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 22:00:45 -0700
X-CSE-ConnectionGUID: xtqYsiZXRNSf5c2DwKn5FA==
X-CSE-MsgGUID: rrOstQ/jTjqF+j1h3QxqbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="178189242"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 22:00:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 22:00:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 22:00:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.75)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 22:00:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esJ8Jr7AJEuGl06ygbC1Xj9znHvrIGGZL0rMNsg/l4TKL/4bp7vLZekIs+PBBjA1kYnzaQVfWBKP1y1mDnYvkr+tA42KxGAvo8N3pllTEsUNQZBxO3b42AuFwhnnxvUjyDK+fepjvuN+b19M4+HRG3gk08MlDZ0KfJ0/8396xj1wFp2dt3ghK3QGEBBxL+GaI/FeEXtaEp4NBe4dGRQxDRKyp+NM/qnzZuLwtIsvU2qnUQCEvG6/HNwoRXqGcXk9IG2HC2blzUjYjlD2fHiYaHzk2JMKh5JQKh7wy0+71xAky7FMibSEYFrnl5OzUmJxuY3OCOkdmIY2si3ZaRc5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOgez3/2XEG697dU2zfX+OjJQn0NhImX055190si4xw=;
 b=hsBFgI2DKoZ3kDGbDZBsV8lwaUGsao9BUX3o4xKpMNG1hbKya7KMz6tBXeiFMAhwf+U8OxqrjWgYAqJwYpoMAMdcE2ULFlZTy0ke9JPmn3mlWpBASR0ILut9WQ/Mx4l0aShwlsnFTknkEOU8mK10E9TRw0sM2E/Zl5AaCmrByg+hhpm1es6lkBw6ZhOAFCcRPlH4CnGbu5egLVsu9B6lNgHgBPnSk7QxDkWomQHCdo8MrTV6p+W5FJ9o9US89ez+zBpVnFFZDGC0SjHEoztS9ZTRXXnndp1y+g4Ed9zK9b1TAezVxnZmmkBn7W5NOVqCQHYc5x4bDW74pe/MlYIC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CO1PR11MB4785.namprd11.prod.outlook.com (2603:10b6:303:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:00:42 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 05:00:41 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: remove redundant memory
 barrier when cleaning Tx descs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] i40e: remove redundant memory
 barrier when cleaning Tx descs
Thread-Index: AQHcE3fX/ox1iENfCkyt4jVdPg5H/rSC8KFQ
Date: Fri, 12 Sep 2025 05:00:40 +0000
Message-ID: <IA1PR11MB6241633A18C6497E503DEB278B08A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250822151617.2261094-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20250822151617.2261094-1-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CO1PR11MB4785:EE_
x-ms-office365-filtering-correlation-id: db495085-5a18-4678-483c-08ddf1b9525d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?b6+++SIqSZAqdQFoJzaL0OhFa3p5Y/Rcbr9O1Qnfij62tMw0XIMD9L3Aq+VN?=
 =?us-ascii?Q?UKkaAbCpgH6zlSzYirJX4zGsr1w0Q2vYZSQkL7CRUc/P4Mvl2HqADBuOii+q?=
 =?us-ascii?Q?PGOBU4HI2O0NMdF0H8Iy4NrQAcxEOGcn94kd8BowtgDKhswwUdeKwFj/d8kn?=
 =?us-ascii?Q?OY3VwCg7PFD8uVDw/3HA9R9wj5PSdnFQRx070D0Wa4jH/XLDfAaF60mJXpAc?=
 =?us-ascii?Q?nBhlscuj11V4QFpI7/++BvhFw5fEgoADIs33tHRFT5+sggBTYvmIVc2NbzwL?=
 =?us-ascii?Q?N/0F6Wb+HKgVS/ZTCvtft6JEuwuej0N9cD5XZUc33zMRwZFqXq3j7aMW3WwL?=
 =?us-ascii?Q?xrEsWDA22sDyy6/tuqlGDLBLvkzILlrVMaJQkh1Zbeadt9K9MFAJiAU1xxms?=
 =?us-ascii?Q?k06ov9Qq1TeyuI2z5G3vdfpZKDrbN1vaQX6/b7GI2uat+0/HIQQgjvYP5ywW?=
 =?us-ascii?Q?2zzrH9wxqUKACJFzrGwXG/l6HDN3r2OE1btIKUJ3cpx+nkGyYma2jiqzvyZI?=
 =?us-ascii?Q?tEVQSMtW7DDS0mH94IbGMzRR46jlZk1Skf/po+uWDwfCNkmEFnNQ6x7M0KOy?=
 =?us-ascii?Q?d+S1pldeJILMNuu3eqmhgpXYKIrftLaOqec/DDDrL9d2XFHFxQcSwTuYYX0/?=
 =?us-ascii?Q?+S40kBxKcXovM1RTtOgESdc5T34VxbJVu0Ai8SZNHpV0utTpfCaMvMmfQBl7?=
 =?us-ascii?Q?Htu344/ACToh335e1paxV5sYuEgVvU5fyalHHVWTiWdoL/4KcC7vxMOwvlE4?=
 =?us-ascii?Q?XixJyJMATKERNOmVzZxbnAeNiJ8B+HrfbJpLEiwlHxOH/bhmqkmrHeMej5ke?=
 =?us-ascii?Q?Nx2Yt0rwpgiAOOzTthQSIX1g8meLiWWyw0ahe2ptLyATPdcAIVVxtOoA7uYo?=
 =?us-ascii?Q?7WGfcDDGMIW/INfo2vScLfh055ZwlwL/cXeZexpn9RJlLptiBiGrW2dpul40?=
 =?us-ascii?Q?uHmyDFg89tddo+Sc+Qn4oByPyaqiKUmIavM9SLm5ZUkgsJJ7yNkuu5yNnZnJ?=
 =?us-ascii?Q?MlcOqmzTwyjijQQGJmmlFufqwnghsDyMLp3tpzDX3DD6MrzID61JAxhC40Iw?=
 =?us-ascii?Q?kPgsxba1BB95T1DzpriBaNCWwIj14eepnpDhRJHZf9IJtGPKX4tSRRnMJwvB?=
 =?us-ascii?Q?k1riu9nNB0vqcEyTn4I1aWhgvN99FJxLHzVk1o7pXllECd6sHJsKljMY4THD?=
 =?us-ascii?Q?D54AELMgH1xLBxsZckewGj6dqnX8bRN9V0DyN2cTL2NbYBjyNg43LhwwUPjR?=
 =?us-ascii?Q?/lEHjqGrXk0ejzSdpf5Qvtg4ARgi4p3GdCbqBoTuEf3TisYf6Jqs9qhBmMMq?=
 =?us-ascii?Q?sQSs1suCAKUeSPlaRDwPv910+pnE9VQ+2AbV9jjLlljo5fcTMGCPtuxCBfTn?=
 =?us-ascii?Q?OCzWGQ9QHKBZKGnXA8rntcqHMpRHmqzgcr3/itXNuc8wyoATT6tKnV3+B8ui?=
 =?us-ascii?Q?i4KSjs/1cpgd6UpHUAb0sgQrDtepUbwy4NJDYX0gxrg50RncQTq76sug8/Jw?=
 =?us-ascii?Q?P9P+bihKqeWb4Xk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bLvD6KIU/g7tLusHPZA3RILiVJNCZAHPaq5rTU5VsqkOaY/IYvEO/ffjeel+?=
 =?us-ascii?Q?tvPZWwEH/8SPU6dxXe77bN0hjbFm9VEPONGUfrDTkcrSsB6XDVNeCKlVwuXr?=
 =?us-ascii?Q?hDmxWM2rSLhxCkCnxsJZG3fH6ctbFzzPQeJseJvMfqd7rTE1RvIDIBu+OuBx?=
 =?us-ascii?Q?QScaAPx8ZWQp+/wlsrY1xO8tfk0ge+V88pHIUV5DfmofPH9hM1mulXad2qch?=
 =?us-ascii?Q?kIfzn+xbLHUCvEk/kF1hOvuvigFoA6xG1hZcaapO+iMXYF5dBR4CoWUYEAbU?=
 =?us-ascii?Q?XnX/+4uV9wEoQJKdyiQ+tv7UJiimlxr6IdhS8XkZbBWVsOSE0lOIyWp8se53?=
 =?us-ascii?Q?hBZvLOabSYo5ktdtKRYyemKZEY8L7fAWBk/jH0Iij50g6XDjcGP4Jbf5yz5N?=
 =?us-ascii?Q?LdV1OdecojWGfkkrO3GlpsWH7fjNN9PnlajFSzJ2V9k+wLDGih1uecj1N19H?=
 =?us-ascii?Q?jb4WlU5dQ8PpVpWYJ0FN2RWSdE264iBKwLcAP9R3uQpnIg9PmKvKFwmnMhfN?=
 =?us-ascii?Q?OcvTVhxeaO3z1OncPjcBNuj7TyFmLprNa6g656E4d6bCKlYFRxd8IU9vx3rH?=
 =?us-ascii?Q?9Xx5GBXHHWdXy6M19yF7FI//cdUMbQ0XboTKeCcxAsnx6RZgoA0RslLo4pNn?=
 =?us-ascii?Q?Cq0WBLyt90F2uapnzk34UhWcx3aV04drTSHJFsW271TgMUH4p0WGqn3Xqog7?=
 =?us-ascii?Q?ZNh86sVxjAR4BE1RB/HCMaH5Vuba5oE/2T1Xp9xtaUQudV/EHcKGQ2GwqvfS?=
 =?us-ascii?Q?bW9amJzjd1ZtcQuI7BqYH1r09eK58q5YbiZUBvNVDI7Rb2KZI2Np+913ATU+?=
 =?us-ascii?Q?y8bEyt8d0dMfvQBzqeE3AEufNKePV4opdMus6CjisSrGKvhXKItauiHLZhi2?=
 =?us-ascii?Q?6kt0ZsqRDbJ4VejY9VEAGlZ0kXskzk/obIHr7qq75fH01kA3YqMxLmu0NMdF?=
 =?us-ascii?Q?NbfeUuxjwVtCbqi+YF/HVq13IPkidBR8RtC70gFIhDgc87hxyl2kauhEpzU7?=
 =?us-ascii?Q?ddtMKdL6VpkC+weHeGpIKLhDm7Nq1vak1to9BIu4LMBob/PIotW9iou2+6PB?=
 =?us-ascii?Q?ztlqgBHx07vYbK3t49WOMsaK7crFKyZOryDXwTUoEsUbdhbIdkQ95Z2p9Zih?=
 =?us-ascii?Q?Mf75e2YP3QzB9WnWWSlZoekTJHVKrKAoutZHbi9X9uNfajsruhoKomnKOdyl?=
 =?us-ascii?Q?2H288N7E+kNhjDquURB1z2MP8jgrWOjgOdrI4boVvYSJH/Q/5HoTIiuyqppP?=
 =?us-ascii?Q?aklKSDGHv6o24WzDFNBds0qdmheBN7Hym7uYXBYJdXYBiVXA1JPf8H0o8mH/?=
 =?us-ascii?Q?TO5fGjJu55fM4xNXf1g8QpXOBB8noHdkT/MMoQLbZsKuqlN6Ziwk0EZFmlyP?=
 =?us-ascii?Q?6BUIWciv2eLbuh1m+gsf+qvXzaWjASfFyh5C+4kS3k16QdbPvw+UKzyCRDN3?=
 =?us-ascii?Q?1kdi3BACC5mna78kw0RClnDBh6PrUYX09aS9HRNALigjTLat0iuEvuIP45O2?=
 =?us-ascii?Q?mdgQiVOtR9FEKOdSzQW9pY1nRStAXTpGTYIoArXLX8Z5Fps5LR1vE0OnsouY?=
 =?us-ascii?Q?7AW/r04bhP06YeNqtodCYQ484yjGT51tvdeDAx6V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db495085-5a18-4678-483c-08ddf1b9525d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 05:00:40.9513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqloDRaOSX3D8fRs2xQiCzoUpT2lf0d3uJlygs+tPwcjrX8m9lh9+NVc72NHfhsR2/XYlsjvFbrdlcJRl69FzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4785
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
aciej Fijalkowski
> Sent: 22 August 2025 20:46
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Karlsson, Magnus <ma=
gnus.karlsson@intel.com>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com=
>
> Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: remove redundant memory =
barrier when cleaning Tx descs
>
> i40e has a feature which writes to memory location last descriptor succes=
sfully sent. Memory barrier in i40e_clean_tx_irq() was used to avoid forwar=
d-reading descriptor fields in case DD bit was not set.
> Having mentioned feature in place implies that such situation will not ha=
ppen as we know in advance how many descriptors HW has dealt with.
>
> Besides, this barrier placement was wrong. Idea is to have this protectio=
n *after* reading DD bit from HW descriptor, not before.
> Digging through git history showed me that indeed barrier was before DD b=
it check, anyways the commit introducing i40e_get_head() should have wiped =
it out altogether.
>
> Also, there was one commit doing s/read_barrier_depends/smp_rmb when get =
head feature was already in place, but it was only theoretical based on ixg=
be experiences, which is different in these terms as that driver has to rea=
d DD bit from HW descriptor.
>
> Fixes: 1943d8ba9507 ("i40e/i40evf: enable hardware feature head write bac=
k")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 ---
> 1 file changed, 3 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

