Return-Path: <netdev+bounces-259761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMAXEHS+mGnuLgMAu9opvQ
	(envelope-from <netdev+bounces-259761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:05:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9C016A8A5
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98EF73004D17
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 20:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848F22FDC3C;
	Fri, 20 Feb 2026 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MF7Ohq2H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F92ECEA5
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617903; cv=fail; b=NT3WIr7OTFvOi35cMwS0Eseu7vHXUprpkx+tfYd8DVjbCir6la/gtR2xhcKB0t/6Q3j/Ts+iimjcYQjdFhxfOl5RYZ7U0X/X8QUIqn4r63yLm5NnpIta/8G0lU4I+ZFV/zyoBFdGKGnbqkhVQMutTEKAJSTWZFjXZWns0FjMASs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617903; c=relaxed/simple;
	bh=N+gYFExgzUSTKtiuRUvEnz1tL3YVRNDwh+46IpNZos4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iYvC4HUlkcJmgRE7GRBNR8mt6CrROuLjUYMiSZyEyP3o1tEEGX1FewLuW37FXCPbJuMriaG1zpVdPNmsF9nskn+P3L/1ExB0uRhQusJXo5NkDvxzEEsudWo3yhRuaxvK5c3UNm97nf8Dgm+JlXbk/jfmJ0g/g/WDcRp0dYgFgmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MF7Ohq2H; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771617902; x=1803153902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N+gYFExgzUSTKtiuRUvEnz1tL3YVRNDwh+46IpNZos4=;
  b=MF7Ohq2HwN59bWmUwzvRMnq9x1YvXKNj+9kmxSSPVTTazPv5UgGWb79K
   1Zy0+MsAEfPoOTWL+tkbsY2GbGyw2KjTS1Y9glRB44kz/efPKenlItfcm
   JnA5xC7qVOCz2n+sypeM96u4UxoQoxWEFlNs/NL1aax9N37BVV1s1L37r
   76pJgpDddYXXf+2Qo0rZHK9M9c+P2CRBP3uEY/QJW8UrOFkYr9YebxBnn
   +jhOn/wGQWo7ywnhLl4Q+zauSejDd+8Q7nQ8+1FfhBlksy1Az6E8CWGKo
   p5xU8agUpWXATF09q0u43M9O+7kIgANaU4GS9SO8BbTDTshQOWsKJ69B1
   g==;
X-CSE-ConnectionGUID: OVDuR+CYS42yMtgcwdINeA==
X-CSE-MsgGUID: 5z4xqv/rSUuzw3lJXVMlXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72594605"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72594605"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 12:04:57 -0800
X-CSE-ConnectionGUID: q/Qnh3x2QNW6ypf9sNHKGg==
X-CSE-MsgGUID: XABUfE9DTdWQXrBJzTImgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="219087472"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 12:04:56 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 12:04:55 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 12:04:55 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 12:04:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lek2VMb9QqDH0lUaXVPHmJzXQdSrt+I3WZWlms6xRK+ZpH75GC6H28Sy3ujzpSow91Q1W835Gd+ekDixJmjGamZla8ItldNQW6+r3zPU3S7s3+93kLtVkSvyIQULStSzIajXmX5FK05y+sDb6MhZxVX/QnMH+4aGW/PMsoo4ISmPwAdbwKBCnlOzgWbq6BGInWDdnEo7RezpCBh8+fVXCm8qVOyBtoUfQzavK5sdtVjcTTab1cd/qRYlm+LvuxjV7ka9fdV+hjMjDNdlM8PvlwKS+xknzrDP2r5wyavwUrukjOl/UoY+Os0P3t1zIDlTvJhBB952tdEpyb2AQBrAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4tlHHQOIvRIJAuHyou8h9AOtzQDzKFJiPrQ9cgK9c0=;
 b=bvzrgJCtQRYPh/M+s7oCnceVVaz9Sd3tFoPdCuniD/BxMg5brNmvr/tiJJiO81Xp2eYD3ZtKlJKxA6qVIY+IIs5hZqh1jrbX1BJ6kwsbuZnSAxdpkU198CGRZ7wh1rqWKAatHNvAAvS7znAANyN4Vwqmg9V6PQF/jkjpDlMQwQQT4yg3a8MMDjpaQEllWQtyQgp9PeaRPXJ5/yILBg3grd/Y7f41V0z01u0xsF3z3+OG9nd04hbC056YR30FO2txAnTeju2KvCCGaCSVX3cBrxcQ15lBl/5C4/6SIAs0GOrC91f9kBUd9ZUJxK9wI6Jmxy6nswrA5vKsuwVTNoSwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN0PR11MB5962.namprd11.prod.outlook.com (2603:10b6:208:371::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Fri, 20 Feb
 2026 20:04:53 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 20:04:52 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alice Michael
	<alice.michael@intel.com>, "Greenwalt, Paul" <paul.greenwalt@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "kohei.enju@gmail.com"
	<kohei.enju@gmail.com>
Subject: RE: [PATCH v1 iwl-net] ice: fix potential NULL pointer deref in error
 path of ice_set_ringparam()
Thread-Topic: [PATCH v1 iwl-net] ice: fix potential NULL pointer deref in
 error path of ice_set_ringparam()
Thread-Index: AQHcoph4FuNw6YIGHU2e9kutfDspH7WMAbzw
Date: Fri, 20 Feb 2026 20:04:52 +0000
Message-ID: <IA3PR11MB89864DB144A3D8990E6512D5E568A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260220184031.60113-1-kohei@enjuk.jp>
In-Reply-To: <20260220184031.60113-1-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN0PR11MB5962:EE_
x-ms-office365-filtering-correlation-id: a083ba8a-05be-4651-287c-08de70bb4f8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?vf26R7L+BUCln/bV1lOYiLpaCQ78VxZpc2RBtRPxqEAdu9DlLDwdHuQVWcvT?=
 =?us-ascii?Q?LVZaNdJ2V6Lj1AWm6LIMt/xz15WZ4oxvgCHZ1KZEWeRLPNU1/9nKKTj0HzK7?=
 =?us-ascii?Q?aEK41eoDfa9InSNEDdQ8jrcR19s7gBdQDeFHRY0bsuUw+zdjqhyMRlhWgtkt?=
 =?us-ascii?Q?sR3/lJjo0ZdUPa869RIVAwi7x6g19SQrwT/uKv8BbZ2m83edZpscHP5BZ2Ih?=
 =?us-ascii?Q?P8VMT4s0KtdzhFDJte7fqEfhViLYvdTFfm2E2EJTTlWUG0arRgzoob9OFvFh?=
 =?us-ascii?Q?3x+/nKyHirWqOXJgF3zmIdIH0s7sMQgrAnha7wALPkojXhDxE3A2cd3qWvZU?=
 =?us-ascii?Q?zsVauip4b96o7Xy3Gmu2NeVqcT3RelalZ8YitgUNhQVibFNzoZMlshyPKEvQ?=
 =?us-ascii?Q?maXw21TrY4lys+g9ZaBvjEKTvpS4Kh3/GbM1ZsDVXVx/3mPWe9+bov2XChxX?=
 =?us-ascii?Q?nMjI/Bn0b/sLqYm2EXC0sRPpmANXsN5FJzgu+lMV3SQIYTlF+UT81wMctpMf?=
 =?us-ascii?Q?z6YtFtU2KnpaofLhpZgFyyYm3MVpAtyq96pQE0C6NHixpKmjC2pOhmx8RfZ1?=
 =?us-ascii?Q?2w4Yduek6tBjSWTjxq0IWqx20JVpDttx0T9aAezDEMsdZtMvbmv04rz2P1nL?=
 =?us-ascii?Q?zuRJfQQdVo5eTgcMnQTcfbWXea/V16D8c8wzJgzQ6fUS2Okm1WXs/7XP5Xik?=
 =?us-ascii?Q?CjH5KZUV1b7Xy6RCqDQExs7AZfOztp3ft9k7/Vm84uMUzP1Kmks+a98Jzsc/?=
 =?us-ascii?Q?ycfn8fFhK+PVI43kzwhWgi721tq28TzrhZqRxzk85Ec0kFCaJ3e1keJ6CMkO?=
 =?us-ascii?Q?8wyftH2Wq3dHA7L0uhhY+auMPdP+2mC4UigQxRSjElk01cSyeafimq4z1yaT?=
 =?us-ascii?Q?Occutb1MxhMqJMzSiBS97fADAH4gxReUSvxYo9y0QchRRTVzH1gGdlo54vQl?=
 =?us-ascii?Q?8KKIN55ghFE7xDfd5r8oltR0JNBJquRcyX/MzBVuNXkB4adyoNbYpmzhi9xI?=
 =?us-ascii?Q?hpclueMi9s6o1fyCOUSle4bKQFchAkYp8gck4+z8m0y4X8VVXtlxPFI41jmJ?=
 =?us-ascii?Q?rp/0fC/8NmkmbtmbtHj+GImg8MlaKHArM77P4+TIwLCexWXvFuN4rxhAxxgi?=
 =?us-ascii?Q?u65n85aET54AhYc7QG7K+pBgt4EJgUFoA62hyE11cUnJmVkHXXf0BzkujxVM?=
 =?us-ascii?Q?yQAapn1k3NYyd+dziMHvmrf4IBPxNPeAodbKsY1jFXsU8aq+vUdMMgTGe4KU?=
 =?us-ascii?Q?9jwX9Mi+pQpTk020xtbQ5PEsV6t0d+bIED/jaB9TOPyinCHeYcUlXZzaHjyb?=
 =?us-ascii?Q?mA13WSi9Jpku+ZCd4OXp+dRSAaCAb/eHSrqayp5yxuMdyChUmZTEcafiIJTs?=
 =?us-ascii?Q?L7JffEes0eCPaY1Ij7vbzxPLf+RnmhqZEVe/b8mfxUVLRjQGsNxEEADVK6fP?=
 =?us-ascii?Q?3gv5XkWzvxr90qX2t0fcC8dwkI0ItEuPEuEA8ZIK8FqKOKwoLVOvholV+GVU?=
 =?us-ascii?Q?MPM/PHEE6ZuLtOA/fTDZWDxUcbMKorsSv3RQHR214273mclvLscrBWiYEWuo?=
 =?us-ascii?Q?U+RpmA8xJn/WYZUI6rbqxQGbFU1T9oXbT558F75URXMlxtBeUPJOM4X+bRZE?=
 =?us-ascii?Q?nkP6yys2IPFaCPx8PzavdKo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OJuTSFWLA0DEaBlaKWwzdO/rpnoJLRRapyRolpDS1hBXX0WZsSNhtAv8snk5?=
 =?us-ascii?Q?fQmJ1jEay/9cGBd593r/dDXu1le2m9j9cO4eRegjl25TYl1LzW9waDxlrYFG?=
 =?us-ascii?Q?pyUg9XB7nmwXhECBA2KTrAtcCNSqr5ffPP7RvHmFJ/aMqOP06N7YCnpuI+XI?=
 =?us-ascii?Q?A58c6HMNF4YZMOsVpK571v86peb83p6MpSbznjEnZXZYSfGqB/a/F+dA9p7b?=
 =?us-ascii?Q?ruTEyZ2JUf5cggXGLmGhYyQkVs+fQwrgaLiHQOU9op4A5qZ3nIuteZYu9c9v?=
 =?us-ascii?Q?3NCSV5Xq59aGW1Golk5wY7H6t3foLfQLkP6t8+9qjVN7dG1I0apF8q7xu9FX?=
 =?us-ascii?Q?YGPvgX+zck2AuOjvOZfyQScGSGvl0b0C5NmgzLjqwSOEHmXS1BycZPjag9T5?=
 =?us-ascii?Q?e4V2GqpBIgc8yC89BflDurSD+wjjpBcpk9tfFA//HouZMfheLvdBj8cmBP3t?=
 =?us-ascii?Q?XLUpWQmPnK4LYMO8vhYnyO54Jwh1UKu4ciZXLemCtwavpSIFisEjHQnA9qN1?=
 =?us-ascii?Q?DN3d71/ALBmeVqNMDmuFMh+3uP6X/h6++t/dr0woYul7WaS3OCw5AWJpHmEt?=
 =?us-ascii?Q?YvnC/TUGja15V2YK3I9b273CDxNBh3OSNVqDH6BB+pOC4uONVRmbrKRhXQjI?=
 =?us-ascii?Q?cIaZVTvKGKtXPtYauaXQIMyRx3Wi3QKJ8x0cTJs2oj+XGUZvQHeu78nQsBaz?=
 =?us-ascii?Q?ecYNh2rqqMqgXNVktxDpatEs9G9U5omeJokIE3kXrmMkpZEJfWJS1jJMwR58?=
 =?us-ascii?Q?lDfpm82bqF3UrgHHbIXLx8aVtcqc1uyE4D2cqTJVkIAeOejPGm6zGJlvRAbI?=
 =?us-ascii?Q?38Y0jBUSHonBSJ3mWXvhhzJk/YftdJ8otrX7ZyKQ95BjtRxU2vgILPqQWAUu?=
 =?us-ascii?Q?KOOpkxWw++g2DFvW2uOt/hAsID5uPrAkXPG6InuB90pIo64RRIS/agBEJysd?=
 =?us-ascii?Q?nP8+6PnWjXl/HpOWT89a2QfRvdQxYFgVOKGeJSeU79KtwyzQGAQAhe++LZsf?=
 =?us-ascii?Q?Z2/d5JOdac7bBnKU82eh1lBSDe/c93JHydmU4v4+BNumhKeRKxrvq3maiNGs?=
 =?us-ascii?Q?CJxFDqmViXvPMDaX3qqlpqUj5q1MJ08EnkxtuAHIHByYgySQBg83gKANSYll?=
 =?us-ascii?Q?h0Knj7YnWUmFARrMKTjU68eSQNb37tVjMSZCXet1WeCnxIc0BB++umPcoPJh?=
 =?us-ascii?Q?f9n3xGubvtBrw0dcPbweyelTAWNQJgYIFTmd54Zlcfm6vuk5V+eW2TgpTwUQ?=
 =?us-ascii?Q?Sx3wptiw7XFymWfPMyJ0rWickzv9cNO/Qx+DK6th9qER0jV35Sd9Y9ERYipy?=
 =?us-ascii?Q?EAjwcNLFz9F9RdW2ecDf8GzePlfFWvK7PiDJWMlDghdC7QY3o+hLSaDb6ARC?=
 =?us-ascii?Q?V2ap3+KqLGrxFL3LJ8szH/sgx0l9JbrKzs4+r1mUJDZvWmlDwLYbgyIQ+qZJ?=
 =?us-ascii?Q?wXD8DYRkwyQhycpzxcCZ3+1LplbwJGnUQO7BvwUqm+zxGgsZnwjjY4PzozJQ?=
 =?us-ascii?Q?Fs29Dtg0Ce5UvtxH+Liy3WHfaE/Cku+AScHe9gOL/qSULAp3jSui6SKkOSKF?=
 =?us-ascii?Q?2zdN9UWXXJmZtkkmHEvoHbnIxqAKVKvaaIyExHaa9y7DMLpDtBVX+wTSKapw?=
 =?us-ascii?Q?L6I8r3VtNozRLt+rB2tEEQ6wPwy5qQ0uUWhBOfcqV5xI877XxLc8utyigpGj?=
 =?us-ascii?Q?SOC6NggsZGtKMoTkKOJIteIgoJ/6nByeNZHX07iLYogsFpuAOtGh83kC+6nO?=
 =?us-ascii?Q?YsLnfbClHrFgjcidjIWoYUBXlgbHn5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a083ba8a-05be-4651-287c-08de70bb4f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 20:04:52.8897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CowUn8vmGzvqiXK+yfUCDSuJFrVNpr/cZAgZam4dDeBpXlLY1Foh8BMfQ+IusTu/fh647Wm6N/8yOmzbULbV+zcKHfgT3Bzrx2rU6szbA4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5962
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259761-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5F9C016A8A5
X-Rspamd-Action: no action



> -----Original Message-----
> From: Kohei Enju <kohei@enjuk.jp>
> Sent: Friday, February 20, 2026 7:40 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Alice Michael
> <alice.michael@intel.com>; Greenwalt, Paul <paul.greenwalt@intel.com>;
> Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> kohei.enju@gmail.com; Kohei Enju <kohei@enjuk.jp>
> Subject: [PATCH v1 iwl-net] ice: fix potential NULL pointer deref in
> error path of ice_set_ringparam()
>=20
> ice_set_ringparam nullifies tstamp_ring of temporary tx_rings, without
> clearing ICE_TX_RING_FLAGS_TXTIME bit.
> When ICE_TX_RING_FLAGS_TXTIME is set and the subsequent
> ice_setup_tx_ring() call fails, a NULL pointer dereference could
> happen in the unwinding sequence:
>=20
> ice_clean_tx_ring()
> -> ice_is_txtime_cfg() =3D=3D true (ICE_TX_RING_FLAGS_TXTIME is set)
> -> ice_free_tx_tstamp_ring()
>   -> ice_free_tstamp_ring()
>     -> tstamp_ring->desc (NULL deref)
>=20
> Clear ICE_TX_RING_FLAGS_TXTIME bit to avoid the potential issue.
>=20
> Note that this potential issue is found by manual code review.
> Compile test only since unfortunately I don't have E830 devices.
>=20
> Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload
> support")
If it's a fix, shouldn't it go to net?

> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 7f769a90dde1..5ed86648d0d6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3290,6 +3290,7 @@ ice_set_ringparam(struct net_device *netdev,
> struct ethtool_ringparam *ring,
>  		tx_rings[i].desc =3D NULL;
>  		tx_rings[i].tx_buf =3D NULL;
>  		tx_rings[i].tstamp_ring =3D NULL;
> +		clear_bit(ICE_TX_RING_FLAGS_TXTIME, tx_rings[i].flags);
>  		tx_rings[i].tx_tstamps =3D &pf->ptp.port.tx;
>  		err =3D ice_setup_tx_ring(&tx_rings[i]);
If ice_setup_tx_ring() internally reads ICE_TX_RING_FLAGS_TXTIME to decide =
whether to allocate the tstamp_ring, then clearing the bit first means ice_=
setup_tx_ring() skips TxTime setup even on success - leaving TxTime silentl=
y broken after ice_set_ringparam() completes normally. The crash is fixed o=
n the error path, but I'm afraid a functional regression is introduced on t=
he success path.
Please correct me if I'm wrong.

Thank you
Alex

>  		if (err) {
> --
> 2.51.0


