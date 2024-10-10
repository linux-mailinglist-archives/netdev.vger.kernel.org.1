Return-Path: <netdev+bounces-134244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B56998837
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420372862B5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EF11CB312;
	Thu, 10 Oct 2024 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8Y+zF4I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD471C9EB5
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568089; cv=fail; b=dFmAawRu+rNippffPBbKzgcEr8GpJIQTz0vBHl8t8AI/9s8Gwu1t7ujD6XFcAFGHzSvC5JPGYwSeUrWasiOH8kDuDuQdYMKK8dymTRKTPUArg5oP0rC/A4ItjBMtzn+rz6TIigV4N+7lKtPz9GDRuEWKXFvVsr1zO+WMZnG0qnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568089; c=relaxed/simple;
	bh=jtxX3rshh9PvN76n7gfxU6RGXEaxhBdmywrLXaYZ9rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JfAu5MKzZp6azw9842rEpkDTvEg8EDIyep0ExBI1hOwpHGab9P9p6fhxVO0RtU6hoTlF+PDLR3EnbN+Cm2XEQZY6TfKCSajrt/4xdyy3GHwPDa8nTkZHnHVEvttPvlIVu/kzWcdr2630yIkfpf6doYATmlV2yzs0+A0ky54qt/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8Y+zF4I; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728568087; x=1760104087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jtxX3rshh9PvN76n7gfxU6RGXEaxhBdmywrLXaYZ9rw=;
  b=i8Y+zF4ITa8azPGcvl1eRyqSs82i4YpvIgz7On/8hZQ8Dj16BKTnqCJm
   n5pJbVlT+yAoQfC6161/yobsK6YOWRGpc32uqZbrK11gACkuMm8p/5jiy
   SXaYLwOffyu4pefL3hXVci387R7Vzuftft1YRXyTa0M3ffvt7yfHCyHn1
   FrqfPNXwq9eJ78QJKfuX9M67ThXil2ttMPo2TqjLHxa5n4gEkpZ2Xkyoe
   x/k72y7cxqrsjSVimqFFlyskgxt1DSr92hvuDa0bWTKNH6XIGTBGcLVc/
   2POF9zXGI7XFP7SD1z1jV10zv036CCcL/UyE5IJwGbM3jPtpJfjykAl1u
   w==;
X-CSE-ConnectionGUID: MgGE+iEhQhOp9xTbV8xNTw==
X-CSE-MsgGUID: zmREL3RqRLu2dK09Z37E2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28080170"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28080170"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:48:07 -0700
X-CSE-ConnectionGUID: 9KruUWesT8eso9igpOnBZQ==
X-CSE-MsgGUID: /PMa+OjlTOencCZ+2qdunA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76583722"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 06:48:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 06:48:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 06:48:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 06:48:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1CADks+26Ay3bUXoPt0r+pOqAHql5rPrZVO03UhnHtzpAkEc75ZXMGrI2MDbYTPxA0NYbT2J0JMa389GysyYDL+QoBIxLrFQzNPiceRvhGwftFxTymCU3R+TFlJtLJtH9nUN5XAPOy6y9ZoLs3PjM1Y4ymEsO+QDpEIO+8kzx4gTdQPRrnSRgpYt4sLkP8cnDdcbcEOPToUfG4dH5kOrxFMvOWiEfKwTBJPgmiU6ubYKKi+R+pOCzsE3kgUpbDpjNf1zS04ehrkA1an85JHCubIftupeZu3RwwyT2f61oeKInXx3SpIfOIdvnUj2xGUbZ8lWtcOLZfN8ug6HKLDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX/+DoHpEb743r4xNRCN8g0j2NmhNVvwqM3UH7/Q+8g=;
 b=mbKNWFZjMznSWE9qIWg8MQbl1nfXQeT907aoqQj+Rhs54DxQiSnl65VQw5THcndFgCi833+Mw3brO1Y2ZES3bC43mY9NHe8d5omd3/RHwvI2uvx1ldOgIxERbVeWSas4PrvCaaTjXic4BNigb6c2TdHEIMSnRsywL3w2OdDb/uM65G9RGQSEueq5yFEgxiKOIiRGiCQUSEfW9qEAWZnMR3MWcmrz87ptyRWSUWUkS01LsgUJyTZWUiG825jXSEPP5hcBlN5qhwQrIf/zOnLWxYbua3A3DCQxkwZ2VAMvs8TztZgVf0MrD0SZ27rvxX4ZZ4NED7zOGd0+JsON/BI8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 LV3PR11MB8726.namprd11.prod.outlook.com (2603:10b6:408:21a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.25; Thu, 10 Oct
 2024 13:48:03 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 13:48:03 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "saeedm@nvidia.com"
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>
Subject: RE: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Topic: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Index: AQHbGkZvGPkGlPu6Y0mXskgCaB/USrJ+WQiQgAAbU4CAAUdtYIAAIOqAgAAWBWA=
Date: Thu, 10 Oct 2024 13:48:02 +0000
Message-ID: <DM6PR11MB4657E57046E4263E2ADBAED29B782@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20241009122547.296829-1-jiri@resnulli.us>
 <20241009122547.296829-2-jiri@resnulli.us>
 <DM6PR11MB46571C9CAA9CBE56D6A5FCFD9B7F2@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwaN7XZpS6tEnTdB@nanopsycho.orion>
 <DM6PR11MB465772532AB0F85E9EB6E1719B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <Zwe8M7KZHOLGzUXa@nanopsycho.orion>
In-Reply-To: <Zwe8M7KZHOLGzUXa@nanopsycho.orion>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|LV3PR11MB8726:EE_
x-ms-office365-filtering-correlation-id: 4a190771-a984-41af-d000-08dce932294c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TW9IRSyD9xCjEDYKmoY83D3hqRojph5ApPy/73Pmd4QpmBI1T5/knWiWb5vp?=
 =?us-ascii?Q?trVelfuQjRy6LJoZrlBbhlc62iJZacUcl366gCitO/1aRkZq3D0nXQ8ifRHD?=
 =?us-ascii?Q?Gmd/ol427VrkHSmuKTA1zxOVQ/elMiinN8HTktCaHT/+Mqk058HpPCXrUOAm?=
 =?us-ascii?Q?lwJnIcmYLKxOhqTvJFb261Xun/QXWsDCG5T459WEDCA+NBlk4WUWzbTFT/U3?=
 =?us-ascii?Q?lfnmCiAXRRjnYRb6tCBZROY05ViMo+WDFWt5t0trp4YNDX0yw3dAxR0p0D/Y?=
 =?us-ascii?Q?XZ8x0CAM0KD5XXQHarDldHIUuh3N03WMSsedGYPYARTI8b8/q9gzNZg7vmtH?=
 =?us-ascii?Q?Nhgaf/+M4XyCjgZvbIuVQgdmSecNsK8Ev6n+17SoMniQ086IiTLRozCS01pe?=
 =?us-ascii?Q?RzNfZibMU81m5CwhZRkaxOZ88MAxhvu9R/WnsZOSwEWxNL0VMoU05hzuRi9p?=
 =?us-ascii?Q?Bp3+Clc+D75gTEC7Nm2OZhk5avDC6aDPndrxObDvfQ0vXgf/kgm8vznyfEpM?=
 =?us-ascii?Q?LNusowqZeDbHeFINbaV8qCrdwvMFEdv1Fa1kLj/QVf5bdb4nWv7HMyLMWj4W?=
 =?us-ascii?Q?Phi1az6Zaz9lklnt/ie9AZhYsnGtnXx8DJnwGY9mNjvjVUFxr23RQ1cQ8Kw5?=
 =?us-ascii?Q?RbKlutMF+UISMEqNI2UxPpEUezoydlLd5uf+dYMzU42DVngkN0NFaeH6T/1Y?=
 =?us-ascii?Q?sA0+QBo0dRq3MZVy3uzs4/DOgNhizzVOQji/l+rhb1CgG8XyMpK2BiaY7vz0?=
 =?us-ascii?Q?acljMK4icImXrm4IWknZAEHYbOsCU1sZPCE8IiqCZfmGRbZFj5lTPNKc9RsI?=
 =?us-ascii?Q?2rmiR883312ElK4kTQQ4rn9xSOKwR39Fu70+vEMPB8osG0SciHvpBg+BEPd8?=
 =?us-ascii?Q?JfrU92B8+T8SCbsvNn8SfURdqeKwBg1A+vogHTQjbZsxEJUvqj1UUBuceusl?=
 =?us-ascii?Q?kwnAK+Y68yO9N2Y1SJmRdZ1zrcqLsgA1d/DkVqDIN9rrawaDs6diwBXnoBM3?=
 =?us-ascii?Q?88wvYhmQpUI7RoE7filDRWzOgJeR1j2ORLGNIn+Lij1U55FjKBGiGSujLRYZ?=
 =?us-ascii?Q?Pr//LR/CgFtDdz58JIVPfQqs73Rs24fsBJazQKPhAKL3A27vMKzRAXxrpuSE?=
 =?us-ascii?Q?YMjG3/3hago/5WI4BWJ/cs0wIMMluT4ptth4sgohoMUmA/Tloz2793Xegq6W?=
 =?us-ascii?Q?LekLjNXSjw+Jgrm337US1tTjFxHu/U0mNjXZLmVIzpAcZajWuYAuePFJg5XG?=
 =?us-ascii?Q?exl1ntexAlxdylMePbI5O8a9c600e/AlbG5mDErYWsC7TeuOVY9444vULgfW?=
 =?us-ascii?Q?MEgx/WovSr5qkKv29LoKLqj4HBZMXRav8pc4L8oZdsn3wg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/GhLIvyMC7COP8W4gBtaJubNtqEMr8gj5FHv+pp4egu2MYZySbEgihZ37cp3?=
 =?us-ascii?Q?3c5+T2UI5xPKzGhjQvggyUx0Isc2dLqVQyEOPxTvWxh+kWgYAgxH/cUMU8P2?=
 =?us-ascii?Q?bxApsM88bmsl1X6V55jvLNgplo57PNtkKDqsygbbCEb7ULHDjSjTKwh6zRzz?=
 =?us-ascii?Q?mI3aH9v3OhuQgMFTAY899qawo9Sjtyvk81I0pigq4hrb49R76mCpnZpRK4JM?=
 =?us-ascii?Q?9pL40LCG/5PKmaSO6WeVqfnM96vI+pUtlisoUsdtaXR5qijxkmJAsJdCT0N7?=
 =?us-ascii?Q?g8/HNxJiIETNwc5JFjLLJ6/xirFJNutkcSboqxdifcGtgWT92MPwj2oxGvVO?=
 =?us-ascii?Q?JVoWPv6l8uuWZltTuH8nRjRmNvcmpkhsuD5owXLau7xqXw6dHQG4bhV67Iec?=
 =?us-ascii?Q?sbN2rQwJ8CORAMjVS5Q9A9ux4ea7A6eDpgCxu+oZL1NC7YuQhM3+sMFoGVru?=
 =?us-ascii?Q?FIk5OG/oCBy8mgyW65C37Tg4OVP7geqf4Lgbzj+iTtgM/r8/xEdu1FrdxP+c?=
 =?us-ascii?Q?EmYH0EWUulw5U/DVM6FSGX9eG4ccg39OpYI8ABMqHetyCbkI1Jk9vIxPT8p3?=
 =?us-ascii?Q?3nlqZxk8FnGfw1Lii8goGE/aYKxqMGW7LvxCM3TS4yBSOfrsIV1NsE/LPHO8?=
 =?us-ascii?Q?hRvvBXtVpfgh9omOpuQgYKom7tlq+PRdvxfMmC5XzS2jlaEZeVyiJxMV0J1i?=
 =?us-ascii?Q?zgmgm8UYmWBezlvT4WNicskXCFypIg4VrOIJqTku7A5oI0b6ZJNIV6kY7Khu?=
 =?us-ascii?Q?DgR81sbwuAV+UuRCzBkfQ3wGFiORcKnCz0cqwXW2D8KEINgTkPrCzxk5HuhG?=
 =?us-ascii?Q?deOVku97SJzybEGMw/Q1NMrpLQCBUs+fhYFphLhI/GoAVQrenIXr0opSO/Qv?=
 =?us-ascii?Q?XnrE0VS9a6ixUHYG1QjhtSO6s7Gl2QzwVwinyeRd1K8urBn4BvvKoj7S//W6?=
 =?us-ascii?Q?WYSyF7KSwSUplAAaEeOQwy8hJu2+/GWUmLN2Zp4WojjW6tyAw5G08Hj4Y+0o?=
 =?us-ascii?Q?nO+8yA8/nonqBlNyHW/UBfiNDAKlZYRgGHaryLHkurAr/lTb76ptQMc49uaY?=
 =?us-ascii?Q?oUgi2OoXczSNitrMtI1s4rglaGyanlfrg/eTrzKmihEDxKnHHByCu5va0ok5?=
 =?us-ascii?Q?xSaVYrL2Zjta8k+14ZszVVGXvs7ARZN1A9k3PlmYyP3/evUdClH8H2Guvk9M?=
 =?us-ascii?Q?ZskEpI1HVEktjQCUimoQbtkRF//RNEwMibKX8bSHiJi59d99fH1J0K1gfpyr?=
 =?us-ascii?Q?5MverQAhk71qrkxxABoQXjgeHbcVi/jPhSjop5eqyckK5XF9r6qRjFCDf7FO?=
 =?us-ascii?Q?G1qFN7tD/AZw/pu2GebkCLL4hcP/xfAQD4liYs3S5/e6xpjOjz4OiL/ACqtg?=
 =?us-ascii?Q?jwJWP2+hRUy9CeURCJ9Epzbbahc9ahloCnaSg1Mg6tsDa+VeU6+TgBSDefIX?=
 =?us-ascii?Q?AkY1sF/jeU8aNAxQF+B2zMrZYTzJJCQIUBSMvPg0nE5TRpVEbTU+MfYfQBmW?=
 =?us-ascii?Q?0Qibfbfh6kopVHqkSxfgizWE05MFHrEqdR2Jh6zdOm+vNNmyQMj2QokwZ7vu?=
 =?us-ascii?Q?yuTqDHNaqU9KLVL9zkqe57vawh4WrWwTWPFUDKhYIqaeXlU+IEMqn4bxzivo?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a190771-a984-41af-d000-08dce932294c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 13:48:02.9844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hm/UOZmOnoCTY2H+74QIsFkBgZgpijTZu9yZ0kXtCHZ/VRgsANQnku6YdjFzmWIw5eiM4Cl3feqWztNBUU/Sh0BtmFavwcZwZgmzxulveto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8726
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, October 10, 2024 1:36 PM
>
>Thu, Oct 10, 2024 at 11:53:30AM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Wednesday, October 9, 2024 4:07 PM
>>>
>>>Wed, Oct 09, 2024 at 03:38:38PM CEST, arkadiusz.kubalewski@intel.com wro=
te:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Wednesday, October 9, 2024 2:26 PM
>>>>>
>>>>>In order to allow driver expose quality level of the clock it is
>>>>>running, introduce a new netlink attr with enum to carry it to the
>>>>>userspace. Also, introduce an op the dpll netlink code calls into the
>>>>>driver to obtain the value.
>>>>>
>>>>>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>>---
>>>>> Documentation/netlink/specs/dpll.yaml | 28 ++++++++++++++++++++++++++=
+
>>>>> drivers/dpll/dpll_netlink.c           | 22 +++++++++++++++++++++
>>>>> include/linux/dpll.h                  |  4 ++++
>>>>> include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
>>>>> 4 files changed, 75 insertions(+)
>>>>>
>>>>>diff --git a/Documentation/netlink/specs/dpll.yaml
>>>>>b/Documentation/netlink/specs/dpll.yaml
>>>>>index f2894ca35de8..77a8e9ddb254 100644
>>>>>--- a/Documentation/netlink/specs/dpll.yaml
>>>>>+++ b/Documentation/netlink/specs/dpll.yaml
>>>>>@@ -85,6 +85,30 @@ definitions:
>>>>>           This may happen for example if dpll device was previously
>>>>>           locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
>>>>>     render-max: true
>>>>>+  -
>>>>>+    type: enum
>>>>>+    name: clock-quality-level
>>>>>+    doc: |
>>>>>+      level of quality of a clock device.
>>>>
>>>>Hi Jiri,
>>>>
>>>>Thanks for your work on this!
>>>>
>>>>I do like the idea, but this part is a bit tricky.
>>>>
>>>>I assume it is all about clock/quality levels as mentioned in ITU-T
>>>>spec "Table 11-7" of REC-G.8264?
>>>
>>>For now, yes. That is the usecase I have currently. But, if anyone will =
have
>>>a
>>>need to introduce any sort of different quality, I don't see why not.
>>>
>>>>
>>>>Then what about table 11-8?
>>>
>>>The names do not overlap. So if anyone need to add those, he is free to =
do
>>>it.
>>>
>>
>>Not true, some names do overlap: ePRC/eEEC/ePRTC/PRTC.
>>As you already pointed below :)
>
>Yep, sure.
>
>>
>>>
>>>>
>>>>And in general about option 2(3?) networks?
>>>>
>>>>AFAIR there are 3 (I don't think 3rd is relevant? But still defined In
>>>>REC-G.781, also REC-G.781 doesn't provide clock types at all, just
>>>>Quality Levels).
>>>>
>>>>Assuming 2(3?) network options shall be available, either user can
>>>>select the one which is shown, or driver just provides all (if can,
>>>>one/none otherwise)?
>>>>
>>>>If we don't want to give the user control and just let the driver to
>>>>either provide this or not, my suggestion would be to name the
>>>>attribute appropriately: "clock-quality-level-o1" to make clear
>>>>provided attribute belongs to option 1 network.
>>>
>>>I was thinking about that but there are 2 groups of names in both
>>>tables:
>>>1) different quality levels and names. Then "o1/2" in the name is not
>>>   really needed, as the name itself is the differentiator.
>>>2) same quality leves in both options. Those are:
>>>   PRTC
>>>   ePRTC
>>>   eEEC
>>>   ePRC
>>>   And for thesee, using "o1/2" prefix would lead to have 2 enum values
>>>   for exactly the same quality level.
>>>
>>
>>Those names overlap but corresponding SSM is different depending on
>>the network option, providing one of those without network option will
>>confuse users.
>
>The ssm code is different, but that is irrelevant in context of this
>UAPI. Clock quality levels are the same, that's what matters, isn't it?
>

This is relevant to user if the clock provides both.
I.e., given clock meets requirements for both Option1:PRC and
Option2:PRS.
How would you provide both of those to the user?

The patch implements only option1 but the attribute shall
be named adequately. So the user doesn't have to look for it
or guessing around.
After all it is not just DPLL_A_CLOCK_QUALITY_LEVEL.
It is either DPLL_A_CLOCK_QUALITY_LEVEL_OPTION1=3DX or a tuple:
DPLL_A_CLOCK_QUALITY_LEVEL=3DX + DPLL_A_CLOCK_QUALITY_OPTION=3D1.
mlx code in 2/2 indicates this is option 1.
Why uapi shall be silent about it?

Thank you!
Arkadiusz

>
>>
>>For me one enum list for clock types/quality sounds good.
>>
>>>But, talking about prefixes, perhaps I can put "ITU" as a prefix to indi=
cate
>>>this is ITU standartized clock quality leaving option for some other clo=
ck
>>>quality namespace to appear?
>>>
>>>[..]
>>
>>Sure, also makes sense.
>>
>>But I still believe the attribute name shall also contain the info that
>>it conveys an option1 clock type. As the device can meet both specificati=
ons
>>at once, we need to make sure user knows that.
>
>As I described, I don't see any reason why. Just adds unnecessary
>redundancy to uapi.
>
>
>>
>>Thank you!
>>Arkadiusz

