Return-Path: <netdev+bounces-109219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33CA927732
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40771C22658
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BC81A38DD;
	Thu,  4 Jul 2024 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCeOeX3w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E6926AFA
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099914; cv=fail; b=PsowYh9ftdc+kxWwyMzIN0FYTgXhYdOuceaQm6b3XiSPuKepScddGrysx39LZ67cRY2lKf5946Yziq7QPPP30Lut5dihiK4ydHK9cefd70d2NKWtzig7stWoub8HMzssMJCSJi+pJe5Q5WTqJiUBXdQskUlGKV2F6uyUc0yobqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099914; c=relaxed/simple;
	bh=+jyT8LcRBewP42SGyJjppn2jwqjGCwcCIL0HjpvglkA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oymOQfUtdoMgGJ+XjxW79YTV9suYscqxBqN74683SVubYxMvG4c4QHVy6yPaQZbW9lLxWqpN85fCLosc3hmpBeKLdzSnAgwW4s58gfaoeBST6hugjG1i0nlrjQqUEKsMSGUTJMPg7dD/lyWvIcCGakmFt6Of25XnnVuQrmMg10U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCeOeX3w; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720099912; x=1751635912;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+jyT8LcRBewP42SGyJjppn2jwqjGCwcCIL0HjpvglkA=;
  b=KCeOeX3wfDynzQJ75ulNb9gOdZs3y6y3+1G7p0yroU/TU9JUr+enXl5V
   ZXsqPD99lW+rxXR0et5CqCB3JsGPHHVzIbh7/f8YGQEF1585UGJh84m91
   LG3o45CrXNUlu7SYCDxEUQZUGBXGFE4yp1sgTRjerjUN2rPoJCLUsqzPt
   YbfA8VJOS5S9KhQpdW+z8S07BbyySTrlrL1Eh50OuDZCYIDNTOC5WNCXW
   zvQ0A5k282e7xlftkTQwbXVPfz6wGnWgh7tNMTyBHueJQ89J3Ak3oBSmy
   hZpqseLYxqd/ENBvSfXoYQEmvXW/X473XVJrriPwNPattjN3DlAWshKka
   A==;
X-CSE-ConnectionGUID: 6aWXN/p/QSK66YstjAlZZw==
X-CSE-MsgGUID: 2u8C+afmR42zITmtlo3VtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17589203"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17589203"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 06:31:52 -0700
X-CSE-ConnectionGUID: et0MJUSFRxOiVMYZbpCDdA==
X-CSE-MsgGUID: dyyEDBa1SoWq9OT3dCEQow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46566884"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 06:31:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 06:31:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 06:31:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 06:31:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/uBhPB0dh0flDx9J3GB/DBm1BpCTBd2Mmg9bTJmd57LHvsjZdJCD+OHFT3FVvATbcstQk5EqcsvAnSoHqvb9IupVpcVL+aLKVOVnlyT+Xt7tinaOqVQ4gMA5TV9RXKe90HiVHW2TMV8gTJ9T8EvF9wsRClP6RDYLqPBX81wSixVzM6cBSDuKc2UtTPIM6n5TmPmlbgMWBt7OQHngqVvN0Oq6HwsyblBfr0hKbIfPUt6Bsn1qNLs/i516JPFWphTK8lpfHfRLkZnjVPwZPuNDaVRCuXsCSBkwHlZ+PtQYJ6/emIt6reQIVoyYriMNIgQ9GrvYH3nnR3frSSdYp8J0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+qejMvyuZe+GCk/VgrrY1RhbkZeuv6Pug1dkMyTF1I=;
 b=IWhe89BuiUxkv19B2pc7WTGQpqh4SC+d2nG6NoFmD7+RzROc7gNF6D0TVYMPhvzjDXUmHGe7l968StJk5HFNL3X60/nw8CSm7fkBGLWeZVl9YoKbD3ABXGHv8OY47QpQwwttBt9YA2P6g/wZjkbBVKL7ES2r4+PxQq1UQvtTNKuGQVGRIkHuYqloHeYoUMw7hb3qlCdMXh9r7m9QSU4OMfPy20zGGDDHUjkYkIfaI2O1RvG/GsI7A6ZWAYKKwDSbVKqIw58E2WhsfWCgwievYP9iaHyQSdkhwrUtrouVgeugbgKBL3jwqeMevDMJqpBlmyYMOCsKhaJA9TOXH7pvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Thu, 4 Jul
 2024 13:31:41 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:31:41 +0000
Date: Thu, 4 Jul 2024 15:31:30 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [PATCH iproute2-next 1/3] man: devlink-resource: add missing
 words in the example
Message-ID: <ZoakMumZaeSotVoE@localhost.localdomain>
References: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
 <20240703131521.60284-2-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703131521.60284-2-przemyslaw.kitszel@intel.com>
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 48eaa489-32dd-40ce-8406-08dc9c2da3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NIXWFYy/qMWzrqe/fwO95ItpIKuC85Bi08IG+UXuKwwMaY5l5LWD2UMuxcr9?=
 =?us-ascii?Q?pxTmxKnRuBSxRto7YJQTUKtV0EykAAWiogSuMKVGn+ww69R91bjTqeb+is4X?=
 =?us-ascii?Q?ry1k4ROOvcVcELdvN7cgHSYakMkypUNBXomsBHEUcCfRTnlVv3cMkMHLGyml?=
 =?us-ascii?Q?992rRCCOrCpdZfLAFKQWMB8/jV0jgazC3enJZr4Zq1L+itvOlhcZIaWgEKHi?=
 =?us-ascii?Q?MPLvpWbfgNUabIFbaVLiVZhwxpY5t7UDx54+t/YDWQ4ZNNNwHoTn6RQVvL3J?=
 =?us-ascii?Q?4doJbEXhcITmLmbPwu1ZP4/vJpr6FT0r+PMFpoRycl318/7Q7NllB3IYzQdC?=
 =?us-ascii?Q?4j7o8PI75AqLaxthg0053/+rQsrZd2Bt+RaoynPqvr4mMdXBbiVaXUHOfBYr?=
 =?us-ascii?Q?E0TE4NmbQ1/cHIJT625ErPx6y4MT+BJmZnwG7byHwZEQF9FyD+wWNWZtn4Fa?=
 =?us-ascii?Q?L7XymHdOtnXJM2KTpXi8P1eQlWAK0i1KWAVf5fvYgsd22zKZY3pYcFESH86k?=
 =?us-ascii?Q?hJpQfmQ9+rhM0Wu81opBGhs6Q34bDx9sr8zjxwB6cG9DA98ErGyUlzGw10RS?=
 =?us-ascii?Q?1/y1PaPdgDtY01vAiw4b/BvWqc/ZoHBmhKr3G/KSCRjsjXdE83/o57ZbxZmr?=
 =?us-ascii?Q?NYyA90+vUIfeINzXLCwPYjg4BbuMI3ZvjiwY6VWEVlnBzs9itK7zYi5gDHuR?=
 =?us-ascii?Q?wNzechGVRS1bdB5tR9ERs6mMba1KkNlexBJN1SDYwzz5A0esOFUCfkvwIfoS?=
 =?us-ascii?Q?cWygnJFwKIpa48/uB5Xvx550SdPHLTyA74xYtFEUYUW6dPOPrh1qyjWZrUF8?=
 =?us-ascii?Q?PKinBEYd2853HG49FYu6QjV3Is3ayV6vbXR6iKL0asS0RcSVIpSbsJMnCYoe?=
 =?us-ascii?Q?SDcUqYLu67KP9UT0oBht3UldDnPcuwfBZZEjbdV7EMs2uL4k+YENIQMr3f84?=
 =?us-ascii?Q?zR5nTDgJ3Mdu0cSDvxIQg2yUiCRWt+gGTSTtStRLYoKA5xb+AMJtU6xqnK/e?=
 =?us-ascii?Q?L+3V3EzjMKhSRzj27KtvI0FM4hl8TXKS4s0imXrTOmRVZA9O/uNTS4FfBC4G?=
 =?us-ascii?Q?EXAdMdzLucCZl55xbQ8Rd3KFGluJIwv9+7Joqm6nWcRC2+YQOso3E0oF8wW9?=
 =?us-ascii?Q?/GvWqKIFOMbIMrXTR0uZlgvbATrbTTSO4mOnhAGk2cO2Gb1oUBEVIXWIl7T8?=
 =?us-ascii?Q?cARK3+1xtwPsBZiYeNaNZ0CySWP0LH0ycHUPmDTAmQGTbj4w7d5SJRtpW1+J?=
 =?us-ascii?Q?+BG4BMzxolynNWin+nS9RZz61g4Fvj3VQZFSXNECWe+vC3U/L6HXkV9qA6qd?=
 =?us-ascii?Q?FcJr+Q8jBFjtYMaczFykmKZ3josjyoN/oR2P2oc3c/D8dA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f9wi/l8+jfBp9hxl0Xg9lL5usKqp8wyebeZEVz17hO+poUjIhJ7PT07ZR10B?=
 =?us-ascii?Q?bhNHoTBfPcz/ySAsa2EmTcStd6I1y5hnibDqf87KDzIQr2hW5jQ4IumLzNpY?=
 =?us-ascii?Q?du0XtPY95SiX6uU9Jgoxg3sob1gQB9a+RoWbyeI7lAWvqaGPbo1gmwXl0rP8?=
 =?us-ascii?Q?QwGvJm9bLjt6BT18rrO3ZxKWeQArkUMsz9d8nqT6ZKKrS1vtn8k0nMBotfC+?=
 =?us-ascii?Q?ZTHW/IC5q/DLLtp8G0OKKreL0wLFnMXZ/U6HQbhCUO8sWaAsCKGK1a5d4ntj?=
 =?us-ascii?Q?uOc5fVqEyvgZXa6Wb90c18SP7l6AFBi/TaJXJnewFKX70X3bEDtOYlYjrJUH?=
 =?us-ascii?Q?NklLFYd6MokmGQRQh3Y7cBSi+gOLBWyyZpIJNUqeP8qJeGfrJILQdFd64fYY?=
 =?us-ascii?Q?AI/ndyElbE+Emhithl4tJYOEXAH4waRP2fQTYkA0wea7TGdu2Qd5pK29ZOJH?=
 =?us-ascii?Q?bSV4TvQxCGPfbsJVOv6WMXmqKIr5gCOPATRk1kJf1ZIV0heH9gve5DjMupPV?=
 =?us-ascii?Q?4rwFhwfmMNJZTJgiYbP3dq0b7Lkvd1ky0mbJ2MMYXhoS4NgdUrAlg62QBEGz?=
 =?us-ascii?Q?vBrFf9T1iWVS2YxEZl6FCDFYDBeJ0Q36EoVIixtebRtF/OMkLi3FDxK87O95?=
 =?us-ascii?Q?q+oQAB6F+0irHujIe8MRbUJkM57YRsqC49YPbg6wpNZuw2OAXCGNtHWsFZqH?=
 =?us-ascii?Q?1akw9ic9ojGgY8bJgRY2Q0CDew0+UVQO1F58iD+UoY3NZ5Sd+kAQVj5npg2P?=
 =?us-ascii?Q?fJVKpwTLyxF+Am9i4sluY4m1nDMXKp73x6wwB31XknBaQmBKwAhOpZ2zWqOQ?=
 =?us-ascii?Q?hwhKmArvCAWx51S4/HmdOxFKOdgwMqDAfw/e+7xAovQQXn/SrNLAV/Pv9zod?=
 =?us-ascii?Q?oR2JpfX9UTUYHu0XLhGm6oPof//c/BbtHq/GcvK4G2ZKijA9U9FrxC6jDukF?=
 =?us-ascii?Q?Zb2/zunDokiwfQS87AGWp6uPk1qRA0FNvAFCuQanPUFcJdZ8kVZmSROxNPhn?=
 =?us-ascii?Q?rlAmWY205497qKpXQE6Gx1SYDgAw+IvsEIl2w9/9TUR2SG0B/D4X50odVTD5?=
 =?us-ascii?Q?DiIq1d6rTKYVFIBnmeM7XurotZtlORz+Dok9WnTpZ8K1rp4icIqhkGsFjvdI?=
 =?us-ascii?Q?XLzG2NbRITpeJDiXxYzhWGoLo4lTU8vH+4PXyG6etFPNAH6YOF7g680Kdy4n?=
 =?us-ascii?Q?OAa3TYN/PXKq00Ag8y3tWmSBCS7uhntcxNhSConG4gTmTdln7iRVQDeIP9ll?=
 =?us-ascii?Q?vViqDetmYf+QNDYS0mlWRM6MnvGbcAg+Y1cfxuAum9lPLKkraXzWsHlHuSol?=
 =?us-ascii?Q?yG5s3H/8yog6tC+RSRCueCB47Y+eJFqefTvqHDdXBzCN/WR0VTHClXZmxs2B?=
 =?us-ascii?Q?/jsx9sYQ4YGOtYBU9LVJWojlkR/8IZiOcMNUv+QWau64PtDAEuJaufTwbB6W?=
 =?us-ascii?Q?mD6cek/NhEgmq8EB31u7sPEokikFnW7IAMUaO6X9ZofG00go4Z9b3vG7bHt6?=
 =?us-ascii?Q?FVqpovRakfnidbL2UeilQZkG9HM0M4LeDqWyaVuPnN8D0CsDYbODqs5P0nxf?=
 =?us-ascii?Q?b/KgeoMdA7O+yGMrjOAokFawQJ1WQqBFdUFCwQWC+Q1GbMmjCwZG1tN5tJ+9?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48eaa489-32dd-40ce-8406-08dc9c2da3d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 13:31:41.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vj4TjpBaFQ3uTmyVvC/JtPIR1s3RN2U3vtzCkJFRCnChTnv1pyDIsNhcaoHRk7dgvYk5o3NKWSdjnTxJ6KZgcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 03:15:19PM +0200, Przemek Kitszel wrote:
> Add missing "size" and "path" words in the example, as the current example
> is incorrect and will be rejected by the command.
> 
> The keywords were missing from very inception of devlink-resource man page
> 
> Fixes: 58b48c5d75e2 ("devlink: Update man pages and add resource man")
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  man/man8/devlink-resource.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man/man8/devlink-resource.8 b/man/man8/devlink-resource.8
> index 8c3158076a92..c4f6918c9b03 100644
> --- a/man/man8/devlink-resource.8
> +++ b/man/man8/devlink-resource.8
> @@ -63,7 +63,7 @@ devlink resource show pci/0000:01:00.0
>  Shows the resources of the specified devlink device.
>  .RE
>  .PP
> -devlink resource set pci/0000:01:00.0 /kvd/linear 98304
> +devlink resource set pci/0000:01:00.0 path /kvd/linear size 98304
>  .RS 4
>  Sets the size of the specified resource for the specified devlink device.
>  .RE
> -- 
> 2.39.3
> 
> 

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

