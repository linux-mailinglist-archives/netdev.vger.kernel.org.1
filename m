Return-Path: <netdev+bounces-124917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C456896B618
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98B91C24989
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5331CDA2D;
	Wed,  4 Sep 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2UWQS8T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA871CCEFB
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440968; cv=fail; b=Hcilg/S4HVdHbiIpvMhWZoRrS0MX6cZm9X30MV35hUf0dJVCX8ALbLVAnEZfi1F/r/NV2PWBrpy1c0lo0WElfWK8WXeIV8B+FwIdmtPUk8iw01OSF24Hi3/t4pmNvak6TnQu2lKRgw2QdGy/19ybc2oHVTFIHg8mtWxFGpT+fZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440968; c=relaxed/simple;
	bh=VHKs0N6evJUMwZcE8wqJLLAPWqFppK7gN4NUjW8D9Co=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uz5Uws9gOJF7iZi8UxqgDx6Y49qVky448I3z3qbVQ73jUeGIOv20syDW48B7FL93ak3TANR5539bq/CQ8VSj0LjW9jNbijd9vw0ti8kBXG95gmQ17Ay1tUHRNqFHXUR9Q9zyJKTK+gkcm8F9KgHOm6lM4B79DG0EzC9G41jIHaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2UWQS8T; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725440967; x=1756976967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VHKs0N6evJUMwZcE8wqJLLAPWqFppK7gN4NUjW8D9Co=;
  b=A2UWQS8TlmUsWojpAoxweqvnvytvsd5pTy+sk76bCPCO97c8rQsEDVEP
   K8KTaQ5LIejV9xepn8jfZYgiAmBARAxriUwbWnYvLGMk5Kh7BRH0xzRww
   ZvEfWNngQieEVnEqWOAr6GOd2ApwbWXQkl2dh95LY1CFHqWGwj4UMqF5D
   9frYE0KRBnXwPgR1vivOMJFTyDEv9nQ5zBtyLvufXqTRZIaolLbf42Zzw
   vv6P1ni4DcXwdhS+DHv6hqbtt1jH22ETa3bJSbYmHWTYnWgScqVHRFIiK
   /DTUr6b5d4FzsvvypFwDXgYOER+JZxawi4/mjUUWmYhPGFs0Gkms7lt//
   A==;
X-CSE-ConnectionGUID: hsUpqWxpT4u5tMXEU93jXg==
X-CSE-MsgGUID: oVCn/JEcSRiAd/H+6mumtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27877973"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="27877973"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 02:09:20 -0700
X-CSE-ConnectionGUID: 26RQ6JwvRXmvrlik+2umJw==
X-CSE-MsgGUID: lZHy8qJ4S/WLC5OX1FOLog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="69606403"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 02:09:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:09:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 02:09:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 02:09:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYiVxNj3qYPq4eZz6R8cLSYD9IYHt2l/i0MtOpGQElg5s9ZuHjYq60Vvi0w3MihGdYj3HgFLoqixV5mbkbOewrBacdf+oU9OlgCxTS/BnYmUnJHV7jniVVSWZquF10/FxwhGLrZlg/Y1stvgnXxu8FbmZD2t/SeV6B3M04f3Lu5SsTF+EKfXLK12whuaH18rypBtR+NmN9VTDrhlHqByzYd99L24KKWgOkocNXoicpIjTaNFaSu1PYgs+nUgap1C75HOvwR7/EzuM3QUmF22t0JcTGuizZFdrSRtNfehqOwWlEoIV1NJVwoLhM9GObFrpygUvbvLm/hi0pcfRH6odQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nItlJudbLogbdbbjUWUAm2ssm+O4OlKgui1/fUEyjzY=;
 b=N1THYLC0fcvZrYbyC0+IBXwFx2yr3l1+y/o3yPQzC5haaEo1uwQooGgrHwfFzw7EB3JI+p36j/ZppsE9/jSWaSLy1q8MJPCXJhbLTp20OXwld0sE5ENhD5weNPDMxZcjMFuWHK174LnT2uZC3u3fUqasZvmGcMAsoEmS93b/YdzjpP5I8qKn79t+HEXR4T1+1IQzNlOcAMSryj3VzUpglYChHGMNSd2nclrtyW0cq4iRw5Zagz8z6+CjmIDQx+Epll4C4Cu5lICJM3My55ScaoApwvurk8x2X844CWeEanbT+vo5dIM41iu1RbM6vLarLhfuGUs4kFvPxS9823WV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 09:09:17 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:09:17 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v4 iwl-next 5/7] ice: Disable shared pin
 on E810 on setfunc
Thread-Topic: [Intel-wired-lan] [PATCH v4 iwl-next 5/7] ice: Disable shared
 pin on E810 on setfunc
Thread-Index: AQHa+s1kT40GgBKfNEaDr15ZwqZRV7JHO1/g
Date: Wed, 4 Sep 2024 09:09:17 +0000
Message-ID: <CYYPR11MB8429357A9B75FA1CBB919B9FBD9C2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240830111028.1112040-9-karol.kolacinski@intel.com>
 <20240830111028.1112040-14-karol.kolacinski@intel.com>
In-Reply-To: <20240830111028.1112040-14-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: dd17aade-dd25-4520-f866-08dcccc14120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WlNXq7+08aHZSATa0nhTIU0juo74GrOdY9/MDuBtHarO/VoI82A/BmkN3Nmj?=
 =?us-ascii?Q?cu7u1Id82fcjwUaTfYPWJwuUv21B7f5NQwp1e9HMzdxQ0rVNX6X/DX24WgFY?=
 =?us-ascii?Q?fbvEy3YXzuf2t/7fOr9mFoTllx9jE9DtIgNBbmb1Xl2o9b18Iy+VijPwwiI3?=
 =?us-ascii?Q?mPUTDD08hmztFCHQ+TcvR6Fyxxy6citbNtsxFkW4jAWr6rVxEF8fbkmFN4B2?=
 =?us-ascii?Q?Q0KunGsnX5fXAXHZ9kecDb9vkBZRiLxx2OOAiExBy5qes86kKG22mHgJKcSp?=
 =?us-ascii?Q?BHTMhq8/sdqNIQWqzyR1ScnTWaWmUfp/7mweSKafRY6saH+GygrHldvRPR5j?=
 =?us-ascii?Q?hSJV1m/zXX49m2gMNSbRdIphwp4GKWRJHwhUgDitt0ILpAcBgbNsUclf4csW?=
 =?us-ascii?Q?mvzV1CNg9nCK1ztHIaEDeLTzw3UDHPuVlAyjAdH5DdDVeOWTYGIK1Mgb/Ayd?=
 =?us-ascii?Q?y7Aka0ZoTqBK040mNcFTX/RLFPGYA2muJXmoyedHJbUyL4vHsQ9rTZszc5jI?=
 =?us-ascii?Q?24NgAdiMF1BLdaLxiWM4pwmvD+j/+jyQ76pPO9tCVaUEBOkR6g8vcwoucZ1n?=
 =?us-ascii?Q?2XJXKdDT/YUNqIzRDX71xYgQH6I0hKeVXc+0EzhiFIdD7FKPos8YKeSGIPXB?=
 =?us-ascii?Q?vIiMB3Yhj2HqsAhJYI+gHGB5gf3zzDbHB35jVfCSKG1yfWqFrOgKdOB00FoS?=
 =?us-ascii?Q?rKMPwS97nThP3BiIncf7/pODTVyA3SSbGOO2AQSYOgk+e9wFk7/5EhvtK41m?=
 =?us-ascii?Q?oWYJ4bhHq8JWDmipW+XComH/6scsLn9DR+prELtZBGxn1SxXXti36AwbgBAi?=
 =?us-ascii?Q?78JG/RXaV5UuNdQdAE3iRfmVRKwWJ1+RJAM9++JbZ/Mps9xtGJJDPFcuNKrf?=
 =?us-ascii?Q?S2NLTwsEBzfKBcJdxYJNu3cPMFkJ1L71bNVaV3aouqosMxxWS3IMDqvE6CN8?=
 =?us-ascii?Q?cYDoSLEXiEM5CoKN9XE3CxzzLOBs2y9RuWdV30DHQawwjFK6M9M7k8sxRgSB?=
 =?us-ascii?Q?pPHYnk43zz6fbaDohTzv8o94X0Kw3MEzHpPaaKlCVSEOhV0k4TrwT/B7IW1l?=
 =?us-ascii?Q?3M8vRDlGX1DekXFGzv+euKhnPxveW5zgJoWFkGK1zsLoxC8LE5INFPWxc/1K?=
 =?us-ascii?Q?zqCnKWKeUe8HglfwdrNYrJq2t75biCSCJbGvdlolsn7cf4Flpp+Y2C1RAPAL?=
 =?us-ascii?Q?Tw94+yZfdgkAWEr2WFCj8vbB+tsW/9fjNk1eBV99xPtfxQ2zEjUznNGyBOkJ?=
 =?us-ascii?Q?pvnhMBDbOII+LHGuKGjSvTMgYnJakLYiYBL4BkHWWFoKccQjsvS8VXBnktU+?=
 =?us-ascii?Q?APyVw1dzp2n2VORmJ3/zVDnToVDgwkeOBGIQ1pvgMF1i2BjGOi04f8h+QzBf?=
 =?us-ascii?Q?XCMo/Z2HgbRuhUjKyB70wJOgyR96NIcBlm4l5hiC9/JyB07CHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?izS2jOqyknc/PxsAeH2EWtw1c2CeP1D32fh4IHp819zWXyjT8d0wKr/ZjD44?=
 =?us-ascii?Q?I79h5OuWeGhKboglx1bsHCm3iro0ISePicReuy+QyPWFA3uDUSpP9i+wrRiP?=
 =?us-ascii?Q?d33l4z6oy7ZPt217a9WuAT9m4on3huVDo/hw3S40p//AR34v1kkhS3c2pSHt?=
 =?us-ascii?Q?ejFfPbh+ZMPbv71HBI7EuzcZDCRvf6NC4QdtqcBanS0UEnofjhin7M5iLAR6?=
 =?us-ascii?Q?TOuOcHrI+bBdBTxWVk2cvIQOjxYwb3tjh2YzBOZ2w4Hwe906KJZENpyRT26B?=
 =?us-ascii?Q?WJ9FwZmPWKtRGkafGb0JmiYe7/Jmaav9wcSurEFeNt/FvJr/4646ovwAgUTf?=
 =?us-ascii?Q?Q6NDtzbURRdmcuFeABTJEL2DbbbO9bM19t0TEtKs+ZuQOyEYmOSW61oa0SDM?=
 =?us-ascii?Q?uV0572WwIk+E1tuQlJYK3Uv9mnXEQs0//DztICvy2s25XQq/Jw0Gmndgj9kC?=
 =?us-ascii?Q?Leupl9Q2KIIPN8V0I0ZEpPx6kZ71bf2TJD9520OHDUgafZrveK7yEysf7D9H?=
 =?us-ascii?Q?tHDMZ5vm2OwuKBfKFEXX8cuyQkTP6bLeC1pvqHGpcbsrebWRBEF9h+7KdmaB?=
 =?us-ascii?Q?SY/r7QLaus6eyfbrz1pF9fdI+QN4CFBR4BpB6m3x7/gXBeSjRf2lphD9krLr?=
 =?us-ascii?Q?wV4OP8xcyPvvOdfdnMwwX6jJ0wNDOTXoTBen9x0mYAr3GcIIdkPu8U3QzXwH?=
 =?us-ascii?Q?QlV7NSUWhPHCBCu8lUEJ+Bl3HI8HZo64S/75IVTBDIiSvGFss9dhO5vhlXkU?=
 =?us-ascii?Q?AvhU9TdrGE49ePl9Er1P+bC1EDF7o0ZfAAVrjmzLOBCCRShaacn48Tbz+E90?=
 =?us-ascii?Q?6G8mfOtDxWDmHb/nIXBw+dHulOjQxhjN6NVshdLT8gYCS63uU1frq960Fm9A?=
 =?us-ascii?Q?0S3N1w1k2P0fbprxAUK05hao60b4VkIxua6oWgc7UDrXSt/1ksS322WIqdIH?=
 =?us-ascii?Q?zCz4gxAjrERvJMAQT1shis/lu48iOcCzMxxTOc2CcnL29KFPA95LcN9Tf8zD?=
 =?us-ascii?Q?9bi78Tc/DotUxnupVWu61WNA5Dgd+EwFVPYAkxPdqi/xO3zsnc4B/LQuAKfY?=
 =?us-ascii?Q?YiRmVTepirME6Z2o5oeswfLQSgcM/PByIYDBqVYBTrsuZ2A7PUX52fdOU+XR?=
 =?us-ascii?Q?fcAGT7Bg71f5ItsfwHDI39uoFIlbnSJg9vFBnEV/5GfBiMsW107fpHfaQ/Zs?=
 =?us-ascii?Q?Ds0bRRgzDlE5WUWZN40iufIp0kor/VFzQryikeqbySjtzk4BVRuWKjXMzrb1?=
 =?us-ascii?Q?ZhNGGnYTRwQhGnW8FfdfVW6pCxNXU6H4lgSpOCfwyfch5k13sFw1z9IxOMJt?=
 =?us-ascii?Q?OSkPHidn6/t4irUJMU1ZQosHuQSkvgPduR9xVIacWUUDbrooGQxudSd6ymwF?=
 =?us-ascii?Q?eZ6mreFENr9IupbqBZREvvocI62weef2XlzXeVWSctmfUmDU+0pY+wRK6OxG?=
 =?us-ascii?Q?dvhag9Ja30CqSiXoIH0yr28SEq8ymKdS26FlgbCbcFTNINSD2SdiDzjXD1xs?=
 =?us-ascii?Q?FWiORCcl2uFAM9P4Z9ASJnKeXW4NiiBs2OkmT3dZMbaSR4pt0IscsUjZG/GE?=
 =?us-ascii?Q?OhdeEN5U5QE81O9wY+K0R5kvB3SPy9g3k/wxs0oLJAQ8n/8vl5MwnrvZSlKp?=
 =?us-ascii?Q?BA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd17aade-dd25-4520-f866-08dcccc14120
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 09:09:17.2639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRlz7Fyrg96lvCHjgVS7g8HSkcW+8EB7JO/LmF4V3wc2SQecjVFkC7YWE8qbE5nbzATLn9bQfRscf1dagHMiSclwzQjNbljDe7H5I6eVQSvhv4JLvmV2kJ5AZAqhZopB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Friday, August 30, 2024 4:37 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>; Kolacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony =
L <anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; Kitszel, P=
rzemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH v4 iwl-next 5/7] ice: Disable shared pi=
n on E810 on setfunc
>
> When setting a new supported function for a pin on E810, disable other en=
abled pin that shares the same GPIO.
>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> V1 -> V2: Fixed incorrect call to ice_ptp_set_sma_cfg_e810t()
>
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 65 ++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



