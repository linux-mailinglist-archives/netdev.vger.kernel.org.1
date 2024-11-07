Return-Path: <netdev+bounces-142776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 801FD9C0542
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030211F214C5
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C2A1F4725;
	Thu,  7 Nov 2024 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFO+/4SG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0F15B0F2
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981192; cv=fail; b=Dwqe5wAj7BVt+tV1Oav9gh8H/n2traUZEFMDBaioYnnEzGzYxImXPSApcJV7Lb+PHWd+wnfHzBupmPtuevWX12EgPjCuYQ2OD/3UcGKi94Vqqn+VvKJqMyC4l5f82tdLcrnDpk3aqy/B4aM31Uu2rVJCZHFO8B+rItnCmO5js/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981192; c=relaxed/simple;
	bh=gu7loSCZSv/vSFW7n4vHnngnKOZJwhnjnb5hXlB1ThQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bwUcBKYKHSolRFLn/5QwgB6RPmi3M2hjehVf/1WlVZEXFBBNl4BsKzjobbF8xyv3+2J0hs//VXc7C0+QHu4IjQPUVJfZiIasqjlLiXwPZT8nMznSp2bPUI7A7rFit8OhENzO03muDyAYbAI+ytsi8hFjhTLdaN7xnZk2Gt1tONY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFO+/4SG; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730981190; x=1762517190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gu7loSCZSv/vSFW7n4vHnngnKOZJwhnjnb5hXlB1ThQ=;
  b=iFO+/4SGWV9hc3glJy69p5ovA0MLw13LXGp8U1qjhRCg5IzStCsFAbY+
   OEHCs//rLHUAkPFgDggw3ilcYgvfBlukPXEeJmPeUWyc45tDEBsciB41T
   kSyy1sQ5ee4bofYaGUUo/bp2zxcm8/8ItXsIvV+H6+t39Y2gXmc1+RR4q
   bDAlS04VC/F+m0+hoDnqHI1kwpe/T3viyZoUnWLKsqeOYU0HrVPnrUfaP
   tQTU42VP0DGlrwUMglsM/SY7y0/H9aU/F8AmpXlVYo8I2hhgyKy/RZ4X6
   RMqPh5mYFE5883ORSIrADBCokmaoycWQs/u5ic9zFOaru3PTr9ifWKMeg
   w==;
X-CSE-ConnectionGUID: YdVThgNpTPaBAS6xPW7R4Q==
X-CSE-MsgGUID: wsShGUXERQ+s+v25v+PdsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53376927"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53376927"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 04:06:30 -0800
X-CSE-ConnectionGUID: DVDpCQWkQwGtTupX95Njvw==
X-CSE-MsgGUID: dzQaupWlSe2hlQrV3eXyfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="85048152"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 04:06:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 04:06:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 04:06:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 04:06:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0tPXo3SEV1onaPnljePAtzFSdYZlNwvgKhUfnhIBz/7EP9KW1l+gbeMgYFRaPynLibRDbCxha0QM3qm6GMHqtMmcoDbJp+l3OZNR8NcsKYUESFKRqI32t2rBIHWGIn4eXuH3gtnnuVx4gReN28/3dX85JVvs4qI9zqIKhGTRfBF8C3sdngQstGllanjGjNacpyIv4VEZ7/lCJOBADGT9lNsRGQFJFiEwaA4vMPc7UnV77iM95Z8vCHGbfjZFfusjB7D8ZN3efJV+7jKRioFmd+PeJ/aatgyMvA/fDT1Z320ergIzofva3mhrxY5MNY+gp7qdgxPiqz8J+G4off2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE9n0TnIO3URxXBpySNP+r/iVRQRtMEHYhPpFKIBUOI=;
 b=XwMw9Zr2VIcpgq92wncHzInMq1hh3+E//gaz9een7qfCI/T1QKhqBalMTDOtQrH5uOqO7wVnYABaBe7zFEFEtCIm21GBCQ2NEmmdRomtGnc9KL/gBVupOqTEkydncojNP2Tt90j3gg71H5M2lPVqaAfx3tTLurT5j1w4fNUG/CFqqQ/y0Js99nIlOuUJ7ipj/f/q1vvHR87jviQKmEw6w+fB5JMf2DnPeuz5LFRjYv6YIycFI8ZRuE11gfnsJTc4TnRWdtKoEzeJ5kj98WWxd1SNuuPKaZ3aL/i4iCp80oplkMdcVn9UJbxC84s+J5HBay8pJN8WYNN/ypy2RIuslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by IA0PR11MB8304.namprd11.prod.outlook.com (2603:10b6:208:48b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 12:06:26 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%3]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 12:06:26 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v1] ice: add recipe priority check in
 search
Thread-Topic: [Intel-wired-lan] [iwl-next v1] ice: add recipe priority check
 in search
Thread-Index: AQHbG6vBWTR5GFs8z0a5mDQFNHTxQLKr3+MQ
Date: Thu, 7 Nov 2024 12:06:26 +0000
Message-ID: <PH0PR11MB50136A29D7ED13173A313FC2965C2@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20241011070328.45874-1-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20241011070328.45874-1-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|IA0PR11MB8304:EE_
x-ms-office365-filtering-correlation-id: 8d7b9a70-dd07-4795-bc09-08dcff249ae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ta9ERXZ720cBVSKB2LzVHjCoHfehaGcP6SU9XCnRAkXDUp6AyQcR48mp9TAH?=
 =?us-ascii?Q?Aa4TAcQzRZ+uxWwshVhDhyKk6+hoKm21N19Jiw7NPtlCqsHGdv0AiGSADEwH?=
 =?us-ascii?Q?mzTGua5jB0X8KnOeuodQK2PFj3NDEtyCViQt566Z46esyk5/gnAqA7S9T9Sp?=
 =?us-ascii?Q?Aa+ntvGh7plQ5RB7Fv4ua162OdOABG2XS9V0mjDhVXVB0VrNzVaAany6mq3h?=
 =?us-ascii?Q?O1POdVms4Kbp/uxPeL662Z0PyL49/hc/YlblVg/KM/lZp4KiwZqJF4FyrD2X?=
 =?us-ascii?Q?mSGlEpTOHFyejjLDRPaIkM6/hEUkiceyHaSUsUP3Eb1zj1Xl6glMb/hfm2C/?=
 =?us-ascii?Q?ylX9jpFhEixDikz7DYCet4VB7ek8/7KSvORSu/7i1zw1aAyMSrRv9OAxy7n7?=
 =?us-ascii?Q?xIE59eFXpcsOTGDLcxmP0KjHfWbJxOJH1pttzYJ0AopOBsPiFYa+W0V5Qnle?=
 =?us-ascii?Q?TcEYtI/CBxOAs7uopr+GQe7msWXGfnewW9Pu0NQ07ILDh946zBpqx6CPGkZG?=
 =?us-ascii?Q?NBZRvTOrYFpNaryfNdT3ibvc9FvP/AkZCZobRR6Wuc19ck90i/1d9F4HHiYW?=
 =?us-ascii?Q?rN8gJrOYibPZOTqBTRqzIf46DyoavSFF7aotoaoQWNFfV4qYCKZzZgiFsBe+?=
 =?us-ascii?Q?5yoyHCpLAj6Ns+IqXrkmySoQQBUup230+QON+bzJIweSuVc1fc3IeGd6gIHK?=
 =?us-ascii?Q?zE5iqVUke5KyI58EdznahV0+VY4ZTHFlYh4fFDEDPdCHJTFop6ZrODbUWEMK?=
 =?us-ascii?Q?XUBG/Kj8J0VlDxZ6PXE2IJnSbEferNDUlYuL2WM0j9LLtEGXq4+XTq6+GbQL?=
 =?us-ascii?Q?G6TjpflpYUP1jluMjtm47vbkyoLQXfUUoC70OhUGUP8lsUPR2iT4oQ63qP1L?=
 =?us-ascii?Q?VJruBFq1HGs80XDTIpBwkdNYZ4uFnOo2Zu7Ew/s+UvogcsBuGbS2IsOcsM2K?=
 =?us-ascii?Q?gPHnxzrBWu0bHBRvkQ4x6swHo8nBqEbsEynbgZwGZpXm8QvZRqT9fmMNhsa5?=
 =?us-ascii?Q?ZjBq/0HAMOYqId5FVimdulCv0K7OJ6pnkoz8K08ub5vm45BwaxNvG8Whqj1N?=
 =?us-ascii?Q?RboN5D9B3mS3wV7LujZ2rjOUB8mOB/O/+AgLsuU4e+nb6bWrCRYcO/9/sJEd?=
 =?us-ascii?Q?fHPoldxXaUTXoiYTHGcBF9axrwv3GaG3T/X5GI4wOnIb0qweUo2uyV9v9wil?=
 =?us-ascii?Q?VXEO8sGodloBJPdtxQNmwly3yprc3BaOGugcf/YleWbPcMYufxeBuZbKFW/J?=
 =?us-ascii?Q?0DXiuW9zEtTLv1fGNCXO2Jio7ey8yAagRaFo/kIsHe+i9mLAoVPUyyX1aw5o?=
 =?us-ascii?Q?hOeS3SPcUcTWAbLaVr2GVqimTzeeNV3xOEYiNpeu7Dj++O6//C8nNEe2Ku9l?=
 =?us-ascii?Q?V7YAYJQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tp6Ls8x8CIB/paMTJ/gsjDVfpw5XZoUzHeBU8cUQYTN8hx+zSIvuJbd2IL1+?=
 =?us-ascii?Q?dCIiX6f6n4pgr0xjYW9AZM/HirjkswBzeICj84vFEEfF7ivu+p3q958NCAnc?=
 =?us-ascii?Q?4gGJgnaXote/kYMREw+xNFi2w3BwIROZFZR+1y9itKJDOT2SfMtkpuW78lPZ?=
 =?us-ascii?Q?XbexuHd8zWY7tzLtSNrzMCWpoalTgsJ0ij4fsdBGN8rJdNCPpkdMTb74Dv2A?=
 =?us-ascii?Q?2CO03kHWHUqpsBAPkeAI6uoHDCybd3MmrVu5gLTD6s41ddTEisNplR2CwRRS?=
 =?us-ascii?Q?s3+XEB69M9KFZunbz7NH430zoEPXKz8w/mnE0OP3lcYp6LXhIYyKKUZ36D5N?=
 =?us-ascii?Q?NNdXdbI/ryNnaLJ0mpQOXhi7A++SOlva/svmyhYO2kgIGf4pi/c7KFIUx3n4?=
 =?us-ascii?Q?nsivk5ML3ZUt/A4rGpqk5PKJ9NAUDnSyo4xYEobabc4XLVD97i5GKx9CFuLC?=
 =?us-ascii?Q?6ATRO64a9PcAplpCW+pkV/I790wFOXZrabwXWDcdEfXzhaKjtn03CssM79GV?=
 =?us-ascii?Q?1BYt1AhWpAe86qsR5Tyx7w6Ajb8vAO34qN/w8dpYjW1uhkDw23H6jSEDxF0s?=
 =?us-ascii?Q?+gSy0woEWu6FEGzsYzp78v4ZVxr+q+7YKPN1akGZUG8EOucbQdhdZO62TY+m?=
 =?us-ascii?Q?Gwe3dIs8ooinoxmsm9lOfidm19ghUZy9b+rpnYFNnAfzVcD5k8dJvgy/oUPg?=
 =?us-ascii?Q?oDqyhi6rFhJ6nSijORFVQ5voD3H9uQbLeWuGS2CY4MNa1q9zFno23Y8IfVfJ?=
 =?us-ascii?Q?HqT/lxC1gVZfGL27KIexYbl044DWoXSUmeW16uywLvVKKCGvTEDzEjA+Fep5?=
 =?us-ascii?Q?cAhko0NcFz1VfIGeTcOmjGdSTPlZL75WHzX/iWLWAeAF8wMOJKRZkF3ua1ZX?=
 =?us-ascii?Q?1fJN6Oc3M+7gq3Nt32Xj/3UQsmn9s+BlEsCz0OsRwcLjoYprepl4CwCyQfhF?=
 =?us-ascii?Q?hXe0fqz3dp4rfkHragab+TnZZUqeAf34oR7PAbdeQlt60Fmsz0kDNjMFJkAE?=
 =?us-ascii?Q?qXmEG/A3kKYRqvVEcDe3gY0CtP9Gxglo/kvYluMjqF1be+ojpT4ZJtKCDhYO?=
 =?us-ascii?Q?FDxO5DlYDvp1KrrvIQC1zHZUlF6P9kRzI8A41qo9FNUh2ab3fjN1j3pKRmto?=
 =?us-ascii?Q?nPSfZYcPuDO8lZos9OjfSwk7v36+K6zfLMiAtECzeblYYDQ/rNDZ8Ka/dVwF?=
 =?us-ascii?Q?9UrRIXvnI7b5w/RRZD9yjUtStLRMxpxT29O52prl4HCuXJDY3I7qV2Rllrrm?=
 =?us-ascii?Q?71Q2BHhFkIn2uBGrWM/LJldtdgD+10My6qJr0+GjNvNScdUVYV0QnE7wHKdl?=
 =?us-ascii?Q?ZuuF8guWXtBohKXEcv4ZCz9Yxb03IuHQM5LKcIVSAFJ4x140XPcHJGlyVfAV?=
 =?us-ascii?Q?71Aymyrxljfys4RTyplpWML47sGObBoTUdIgvghXZtKJPqK4lB/OjAOVYl9c?=
 =?us-ascii?Q?l12r50rGDOs9VrWd3tiF4t2L+TRBa2DYZBTGfq9v1D21SEcPRuDKRUFCj3pH?=
 =?us-ascii?Q?9DToIoTzU3qQXqu2ZAkrLgB/7IinlZvZldb6KtYlwjmwm7d12GZTkAMcaxjD?=
 =?us-ascii?Q?8vp6nd5Ktoaq+VXXLZrdYbXTnWzVLdguMgn0cJbn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7b9a70-dd07-4795-bc09-08dcff249ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 12:06:26.2273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wvlp590oFwzA5zGIBNA34XQmt/fDpnzakf3rCwNu5FHkuGFTq8bIBtI94wuaWlI961Q/3clrZZPdX0rH9b2QNez3QigQ0OD6UrBVuS7DCCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8304
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Friday, October 11, 2024 12:33 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Szycik, Marcin <marcin.szycik@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [iwl-next v1] ice: add recipe priority check i=
n search
>=20
> The new recipe should be added even if exactly the same recipe already
> exists with different priority.
>=20
> Example use case is when the rule is being added from TC tool context.
> It should has the highest priority, but if the recipe already exists the =
rule will
> inherit it priority. It can lead to the situation when the rule added fro=
m TC
> tool has lower priority than expected.
>=20
> The solution is to check the recipe priority when trying to find existing=
 one.
>=20
> Previous recipe is still useful. Example:
> RID 8 -> priority 4
> RID 10 -> priority 7
>=20
> The difference is only in priority rest is let's say eth + mac + directio=
n.
>=20
> Adding ARP + MAC_A + RX on RID 8, forward to VF0_VSI After that IP +
> MAC_B + RX on RID 10 (from TC tool), forward to PF0
>=20
> Both will work.
>=20
> In case of adding ARP + MAC_A + RX on RID 8, forward to VF0_VSI ARP +
> MAC_A + RX on RID 10, forward to PF0.
>=20
> Only second one will match, but this is expected.
>=20
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20

Hi,

I tried configuring two rules with same match parameters but with different=
 priorities. One rule redirecting the PF traffic to VF_PR1 and other one to=
 VF_PR2.

In this case, I notice that both the VFs are able to receive the same packe=
t from the PF. Can you please confirm if this is expected?

Below are the rules (1 and 3) used.

[root@cbl-mariner ~]# tc filter show dev ens5f0np0 root
filter ingress protocol ip pref 1 flower chain 0=20
filter ingress protocol ip pref 1 flower chain 0 handle 0x1=20
  dst_mac 52:54:00:00:16:01
  src_mac b4:96:91:9f:65:58
  eth_type ipv4
  skip_sw
  in_hw in_hw_count 1
        action order 1: mirred (Egress Redirect to device eth0) stolen
        index 5 ref 1 bind 1

filter ingress protocol ip pref 1 flower chain 0 handle 0x2=20
  dst_mac 52:54:00:00:16:02
  src_mac b4:96:91:9f:65:58
  eth_type ipv4
  skip_sw
  in_hw in_hw_count 1
        action order 1: mirred (Egress Redirect to device eth1) stolen
        index 6 ref 1 bind 1

filter ingress protocol ip pref 7 flower chain 0=20
filter ingress protocol ip pref 7 flower chain 0 handle 0x1=20
  dst_mac 52:54:00:00:16:01
  src_mac b4:96:91:9f:65:58
  eth_type ipv4
  skip_sw
  in_hw in_hw_count 1
        action order 1: mirred (Egress Redirect to device eth1) stolen
        index 7 ref 1 bind 1

Packet captures:
[root@cbl-mariner ~]# ip netns exec ns1 tcpdump -i ens5f0v0
dropped privs to tcpdump
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on ens5f0v0, link-type EN10MB (Ethernet), capture size 262144 byt=
es
15:21:21.428973 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 8001.18:5a:58:a3:1c:e0.8060, length 42
15:21:21.428986 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 8001.18:5a:58:a3:1c:e0.8060, length 43
15:21:21.429001 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 83e8.18:5a:58:a3:1c:e0.8060, length 42
15:21:21.429012 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 83e9.18:5a:58:a3:1c:e0.8060, length 42
15:21:21.429016 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 83ea.18:5a:58:a3:1c:e0.8060, length 42
15:21:21.429029 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 83eb.18:5a:58:a3:1c:e0.8060, length 42
15:21:21.429039 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 80c8.18:5a:58:a3:1c:e0.8060, length 42
15:21:21.944173 IP 1.1.1.100 > cbl-mariner: ICMP echo request, id 7, seq 42=
68, length 64
15:21:21.944182 IP cbl-mariner > 1.1.1.100: ICMP echo reply, id 7, seq 4268=
, length 64
^C
9 packets captured
9 packets received by filter
0 packets dropped by kernel

[root@cbl-mariner ~]# ip netns exec ns2 tcpdump -i ens5f0v1
dropped privs to tcpdump
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on ens5f0v1, link-type EN10MB (Ethernet), capture size 262144 byt=
es
15:21:21.429028 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 83eb.18:5a:58:a3:1c:e0.8060, length 42
15:21:21.429040 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 80c8.18:5a:58:a3:1c:e0.8060, length 42
15:21:21.944170 IP 1.1.1.100 > 1.1.1.1: ICMP echo request, id 7, seq 4268, =
length 64
15:21:22.968162 IP 1.1.1.100 > 1.1.1.1: ICMP echo request, id 7, seq 4269, =
length 64
15:21:23.432386 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 8001.18:5a:58:a3:1c:e0.8060, length 42
15:21:23.432403 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 8001.18:5a:58:a3:1c:e0.8060, length 43
15:21:23.432430 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 83e8.18:5a:58:a3:1c:e0.8060, length 42
15:21:23.432472 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 83e9.18:5a:58:a3:1c:e0.8060, length 42
15:21:23.432508 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 83ea.18:5a:58:a3:1c:e0.8060, length 42
15:21:23.432549 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 83eb.18:5a:58:a3:1c:e0.8060, length 42
15:21:23.432588 STP 802.1w, Rapid STP, Flags [Proposal, Learn, Forward, Agr=
eement], bridge-id 80c8.18:5a:58:a3:1c:e0.8060, length 42
15:21:23.992156 IP 1.1.1.100 > 1.1.1.1: ICMP echo request, id 7, seq 4270, =
length 64

Regards,
Sujai B

