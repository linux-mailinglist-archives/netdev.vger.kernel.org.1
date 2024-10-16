Return-Path: <netdev+bounces-136202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B89A0FC5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F5A1C21320
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313FD17CA1D;
	Wed, 16 Oct 2024 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCxrOio4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9821DA26
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096358; cv=fail; b=lKde5byM7QzTjhWaiiYNNf1bBGrM8KYHjWlXd1Oh9dtVhs2uJx0Ati4eHkCAHth4L3/hxHcjBeZNYOHNG7F+V1Eba6QxDgDG8QWw5ex3ij+sKMxO5imrWctQO84nY6wXKZ4aOIeoC0fgwrAuyx6KWP2WArr7tiOo0vGpOSUcHK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096358; c=relaxed/simple;
	bh=a2GvW1tzluZXBlfF2CXuLwY1xfPielkKNjivwvOatHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6W99DJgLdIJjoYpeNN7hdq3VqcATgOk8ly0Fdams/ctM/HLZ1nP5ilvCLsYoPVO3wlx2FfuV630yDINCf6w15/YvqKUzEF7vGqbNDUfecjynZ1hP1wj8rxwdmrgfbO6U/0d2SCPyA5JO2Nw7G5YRmfrxsPDMlEkfqEhnZql72M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCxrOio4; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729096356; x=1760632356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a2GvW1tzluZXBlfF2CXuLwY1xfPielkKNjivwvOatHk=;
  b=YCxrOio4c8JEOFiIVadBGgBz/LDahVfsN0RHvndLELP+kXzaBPLWlUJy
   /4aPvK/hlJMz3bSCIoJeWCAG59uh1iEJ6VbXwQXMQ+lcHkiNuIbNRWTel
   AeSxZfwH1V2IWzPQddB9FBGcViSQ3DIaMY1nmNCQinQES7tyw+n7VCpJr
   HWRTLYo3pn0gj9ZFYAzeeCsWbM6h+BoCPRLRKIDQqgAL8z476X4i/6WPL
   hsxREkOoUijUOfaB8ftqJWN1Aa8dO46KJDgLv6GIyT3uVUl/FIo7xR63T
   vR5j80ovsdYyc8YcZg9nTiSk0NoO+UOJb4GmXT8/Gt/Sm9fYBpsnP8M2s
   g==;
X-CSE-ConnectionGUID: Hp4NPEeCSgqFcFiWmyr9cQ==
X-CSE-MsgGUID: tbY7TEqTQBCf9o+QK8aWpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28651107"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28651107"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 09:32:36 -0700
X-CSE-ConnectionGUID: uth6JQfTSlSbaz2YuUSpnw==
X-CSE-MsgGUID: tV0vHUuqRy+1FQVpjVvaUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="115714570"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 09:32:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 09:32:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 09:32:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 09:32:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 09:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJ85LivovYPO1bAo7ezK4JV2o1/Oi1Uq7pVtadKi3LjNeU+Yz5lP0a/DtyO/JSunWKQFXBJcOEKk5RHb+L4QW8KTaB2xPwbUqs95cAdg4uQNAGth4oorOMZggPz3DnQgXWWGouXFr3yizg6OnaOHSiipZr3grNgUdKmtA5DYDPU5F5ghtq5kFfCwZmiXUG6cVRmt5eq7RrqpHkjIJmFRVcw0GEfl7HOYodZfeAib4sTqhOdE2TzRoSQYZseGcAE2CccQinQt1ewtNGpgJNNWZkHrP16uSgBvh5cg22Wy24M5Mqr3bqIttdHXTyygtKMHyA0iPEkv0YksggISFzlndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laJihb/29h6hWPeuN7+G6xfioIFUaOFiXKef17gE2l0=;
 b=s2aulisPy8FTL2x28VPPjhOFyHEzD0IEUic40hGK0eDSZsyKYrRZbSUDJ48gMG5j+R75bkTl63jPc6Dg1mhW4UrB3WJqZxsoL/orI0ffZBIC8wmXsOYolUGQkgQh9vxhuLWRB9vXMKeCel+om8/oQe4Mmdiyc4JsfRYxQtwicuPqxoVb3a2zEATh4no7SNvQjNJ5HQjBpKQ4X0SEVHtIVTgnMf/vGvtchzr6eH0uYHp6GgTeduiU3b4cx0xYCNHpEnYwxB97CzvcM1ZfLrgnT8zHUmm6PJmo5dva/NYZkfk4qHlLLnBD0plkMn7hDRSJej7xvRFzlgWHIs28+9VKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by BL4PR11MB8871.namprd11.prod.outlook.com (2603:10b6:208:5a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 16:32:31 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.8048.018; Wed, 16 Oct 2024
 16:32:31 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 1/2] ice: rework of dump serdes
 equalizer values feature
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 1/2] ice: rework of dump
 serdes equalizer values feature
Thread-Index: AQHbE+7R0dOgzN23TUek5SmropYAiLKIAaBQ
Date: Wed, 16 Oct 2024 16:32:31 +0000
Message-ID: <CYYPR11MB84293849C0FB7794888B4E40BD462@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241001102605.4526-1-mateusz.polchlopek@intel.com>
 <20241001102605.4526-2-mateusz.polchlopek@intel.com>
In-Reply-To: <20241001102605.4526-2-mateusz.polchlopek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|BL4PR11MB8871:EE_
x-ms-office365-filtering-correlation-id: 220c7f21-9ab8-4723-1b1c-08dcee0021fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/XIWaIBe89C65avW1BPS0pLsaQ1/NkB7ENSroF25sXV2ZaaPZgWD3I2Xwq94?=
 =?us-ascii?Q?9F2TIxuaxEypgInU7TsxXdzY95NnhdWst3imu727Zz9tdMqpNTHvsPn30xe2?=
 =?us-ascii?Q?t7fpugJvqH4vL5f0eok1UHQB93VWcaaVpOTCC5st+ri+A2c4Bw/C2R1YA+HK?=
 =?us-ascii?Q?jwtqQJTKNUjEe6tV/PWNOD7gXilXKcRZqXGgzVAV/EvzFty7p80UMqeEYdyH?=
 =?us-ascii?Q?wIpr6NnqmSFOq/CDcQYoYF4JC6XPUa7B5b5OYjx6QPRgci6XAyqb8g0mcnWC?=
 =?us-ascii?Q?XY7SyjOJFrSDDRrtiCQgE8j6msSGZzUJmuLGoeu6EZGMEfi/7zYm2kAlOlKw?=
 =?us-ascii?Q?/PXxyJQkGVKZEdZH4RS3WkjHssbDv1jO8VuDnIfWNUSqAVKCPxDcjspjJ2qJ?=
 =?us-ascii?Q?JW3oczaXm0r13sOCXqcsDHpjjaO8u7iv2A5f8g0xau4FHNAlu8vMnVbFZnDu?=
 =?us-ascii?Q?2R0lolQh6nVNLenrfWVA2GHFra7G+0BiIWyZSU+NnCIAJqfdI+2SmN8seS0t?=
 =?us-ascii?Q?U5e8SnbjEIQCbAq3cY6k/Zfjw15HLQFv4NYOEYMThsjvFlkv+w8UcE3J0RBJ?=
 =?us-ascii?Q?nHp8XPIIOs7a+aCmuvHbZ9HTT2loUDW0u27uIo2OcX/PmbZWupynL/x0QEL1?=
 =?us-ascii?Q?5vB6RLa4tP0iPAUwDtHXppWnmgvcjNn+sfU1InZIrX6R/1j6ywcue+nK6c5I?=
 =?us-ascii?Q?JI9idQZFD1hg0tWZ5UAunFcdOAHPxY+hp3e304xs/YwHd3T4sZL99Qb0Kdnm?=
 =?us-ascii?Q?kKHwJTAOwZWtzhooDwrgeRKXR9AuLIFIGl33RTXHPufiezG/XDRchgytEC3d?=
 =?us-ascii?Q?irjz060n6TQOyaorFyvELukQ2oUg35xvzqJVTnfBEVuRnCb0FUHjV51X+4sh?=
 =?us-ascii?Q?8/7RmXjWBhk9gB45uDnRinKgY+RqHoMIjFF/NeWrRsgFtpTgzdRzAwmwdajz?=
 =?us-ascii?Q?e9pMzsKAhW43evAYP3St2z019W2EdQI2mNPAmVLdC3FGViRBBZRb8dpSvmr6?=
 =?us-ascii?Q?37x5DNZEPohpP1ASynv6kf0wt2v2+zNzcGGu2q6x1FYGb4DlYmMmWvuE9982?=
 =?us-ascii?Q?HB89d3FnrfxvO8j8zVb8f/+uZV3Agl22gRmAGOXpUUy1b7GqpvmKbY0/fV4Q?=
 =?us-ascii?Q?DH3UsaN+I22LCp+yWsrnSG0T+uPSf+03IoRfJsbMivGGnRkQPI1IrBt3M5Yv?=
 =?us-ascii?Q?rR5X0Ng10sPtKxtwx9pGcXhLdb7sZvd/gJL/xKjtX8X6GbN3Hg2QKwHS6FDm?=
 =?us-ascii?Q?jZAOAvjWEgqKnQaAPX93mCff10BNcU19CzWnoHCYpqGZoO4rAyiJIYq1vNGl?=
 =?us-ascii?Q?Wb6wVyOPHbJlMB5mZ6xMIYwV+B9KJ3u1nfy784r0MsAacQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9fc34dxMhov3hbie8vfAtcNhPlWNQ2A+eOrEdTY9cx1RtGT+IrHB+l8X6NEr?=
 =?us-ascii?Q?xIhvgL+RgpSqOYqjSS8OfJLQDxdcrgQ1K7nud41d9/dbFm4/fwx+pBDSpv3V?=
 =?us-ascii?Q?pvz2TowSMWwzmoNcgFgsTOq3Peg7RGP3wO7lequutoNUk+P2lSb8zL4lmyXs?=
 =?us-ascii?Q?XMB6szbqje4olBkaJ2dkjIGv6Y4KMViV0i4pBwlgQohSAdE4FkMQ6GA9+wnE?=
 =?us-ascii?Q?4+2AH09UUhsjh0OeTjTRORDZKV51kr8JhXCTyqznJBwvu23FHhSTUnlS3Xl6?=
 =?us-ascii?Q?/YWIbiQSHZp+9ulvi2UiYybBtAGY4Jfti+8I3rOA5nny4XTg5TmPmL14yKdY?=
 =?us-ascii?Q?13e0haQFK7UUXFxBhg7wjQRlRAkTI8aqWj+6Jx8A3VeE76xHt0SgsToy0O5x?=
 =?us-ascii?Q?hm/pdSq3zDj7fGG1iBnVBztR38lQI7fqwcWa8+6ijqHzO5XIiyVROINw4e+a?=
 =?us-ascii?Q?r2Abx/aOu5ZHycdIm1VvjMhw/GFP2AApQndgbTqEb1+u8pAadpisBW79uqBK?=
 =?us-ascii?Q?LgKlr05pNSfUwStGEHiD5nTloeD3SMkMjlyHI00moC2ioiaTZFjDsHpBXOo5?=
 =?us-ascii?Q?1twW9vLGqk7QAnbHOB5f/MJFE2nk856PMmHIUTwW/oXMk/7iTSylNI9U/gi6?=
 =?us-ascii?Q?/SR5+iZ26TXKJcR/zVkdQELxwljl1Qs6g67E7zus/NOiDmLvbwuaiU8loyU1?=
 =?us-ascii?Q?5UEv2YpBrZVQQ+l1u2cAvkFlH/a5J0Q+12iZmqqrnmGaIDmQuwPdUOGEzn0+?=
 =?us-ascii?Q?YmslzLbAU88s6ghWH4JO8IQqC2ZuMJBBlbyUyg2HCiOCpGuYJ7B38qhXC/MD?=
 =?us-ascii?Q?tgwzxQM1FK4weHYteD2kroLfvgnXFT1GO7ZZhZrTTemnaPypI+PJbMnB2Vhn?=
 =?us-ascii?Q?HGIRnQhi6wrB00qiLGsQFDlXK3OwwU9r69Scwi+lglzEpZD3laz1FVr1usnA?=
 =?us-ascii?Q?AdNRlIVsc9W9UE2KDEIWIFz95adtTuvE4DZjxeg8n/UJiDDFgJ86lvu89e9+?=
 =?us-ascii?Q?szgtwL38fYkgIAa6uoZstxcRuR0MCTNPMr0q2j/I4i3clwQkTQIrOo7jPZZi?=
 =?us-ascii?Q?h2vDXJCM3QQoxjlOll07VY9YQGc4Mi0L+DxpkAfZ/SiAoi+wk1SWsiX3cqyP?=
 =?us-ascii?Q?ScNLW57PHXzUDfKsCWb0DEe/68Zu3btQA9iJzVm2gL54+E+DJazzrZYhEvM/?=
 =?us-ascii?Q?rRU8Ay5msJsGcIgvkuAas4JSL7Mo7ZAEcWnPpjm4BSm3xFDJoqEVDahi3bHI?=
 =?us-ascii?Q?FMvroPPkJfZb9unG35Xz+q/CAFpb/MLUBSLIwDrqyFJHBPVbet7BEWORP/NQ?=
 =?us-ascii?Q?7p8DF5kvhvhV+N8AZGSdU8ZZPl1PYczocJuRVi5P7ahFIyBsZ3hLB4rHbG28?=
 =?us-ascii?Q?P3Zb0wBmEU1RztFiNbxzzriLbv7BnvUtz2a5wy1DaV21QkoNRqUIkPKHmsjD?=
 =?us-ascii?Q?Z/rp6NTDBzIXD0AB1AHr5F3SUUhol9EeZV+wVJr7vdOlyYnyg3et1BWby0L8?=
 =?us-ascii?Q?rgB4VsGd69xl6G9s40zb6jPGoxC0dObSG7Kc120ywniFR9Ja0tcVhVjD0R6z?=
 =?us-ascii?Q?ilFLTze4yA669S8YzMXFf/zR9mFYvIeXtsN+snnMFV0oi29rd3+NBno3T12c?=
 =?us-ascii?Q?7Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 220c7f21-9ab8-4723-1b1c-08dcee0021fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 16:32:31.6698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7sT2X2d20Bl8MV1G+mFmdgGTf9wPA551lkyhlrJxLvowiPu57Vn/MB9sseOPQ/iVX9cFAVkNePG1CN/Aw2ybQc5s8a6cUn6EDzTJAifPvUWkmNhD7FCMvLPmzr7Si/T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8871
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ateusz Polchlopek
> Sent: Tuesday, October 1, 2024 3:56 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel=
.com>; Polchlopek, Mateusz <mateusz.polchlopek@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 1/2] ice: rework of dump serde=
s equalizer values feature
>
> Refactor function ice_get_tx_rx_equa() to iterate over new table of param=
s instead of multiple calls to ice_aq_get_phy_equalization().
>
> Subsequent commit will extend that function by add more serdes equalizer =
values to dump.
>
> Shorten the fields of struct ice_serdes_equalization_to_ethtool for reada=
bility purposes.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 93 ++++++--------------  =
drivers/net/ethernet/intel/ice/ice_ethtool.h | 22 ++---
>  2 files changed, 38 insertions(+), 77 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

