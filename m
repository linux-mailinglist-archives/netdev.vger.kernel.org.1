Return-Path: <netdev+bounces-140535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD89B6DBA
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AA41F22CCC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FDD1F12E0;
	Wed, 30 Oct 2024 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xhwn05vg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1171E8850;
	Wed, 30 Oct 2024 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320317; cv=fail; b=lS02S+xh32RliVZRzf1g2Cd0OE+FFhvv5ei70dNyXySD1o0u3VE13Dst/3x6SETzelbHArtqnm9TW7VXpELJ8aQY0j1NVWPwlQD59ekHjVPC6m0Amc9YSs/VEl/pl0/SHTYtpj6C7F5lxijIND4tEX8l42XkKGjYNp6Gsy98xzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320317; c=relaxed/simple;
	bh=k5Fyjk72nHpziZ6JDw9aYXoVcpWkJs6qLCuyym1xPIU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jhtpFfsn/fGpjPXIL5dYO5UunZtuJ/uSHPlz29kgniHjeoUvpDD/+B6i91x0eVWPjfMX4Eodb4PFiV4baCIEe+ew9ZfV8tTcjtxeC5T3cFiLt872WWC5PpB4NZVZTy8lVMFyJym6BczIMJwJeZ7KYx/2yhsGTmR8irdotzIbkEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xhwn05vg; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730320315; x=1761856315;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k5Fyjk72nHpziZ6JDw9aYXoVcpWkJs6qLCuyym1xPIU=;
  b=Xhwn05vgHwY91/gV+0HC0gYIYOc/Edaxnzxw96SAYh8RFigXkkxk6+Sf
   f9YTNT2YiI3vhquP2ysCxrkGu1Xyp5WKNhi+/mr0IOAFl2kUPQfQoEXx0
   K1NMRWcSGKR1fTRiv6sFWjKJ7gLSD2AQfeKuho1me4xxgr9/KYO0+Mcvn
   4127je1csQqLHJbolUBNp2/4MZbVLOQJi+BQf/MZX4f4H//P1V1TBu1D+
   IJ40NgD3njezIoojmGHFFyjYlj7hrlnwhHqdExQ4T/yPYSwKJPQAYh3Nl
   z5vvrIEzA8Deb+GIJkGsxzgJqQjOr6x2BCqGwcP6w7iXrMxSbswuHyf5T
   w==;
X-CSE-ConnectionGUID: 6BrTd4S3Tj+fZKx3Dz1KjQ==
X-CSE-MsgGUID: QdkmoL0/RKm6IKoj4kUrZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="17686120"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="17686120"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 13:31:54 -0700
X-CSE-ConnectionGUID: CjLOjCavRga86Gfp9LJFvg==
X-CSE-MsgGUID: HyalRYeOS/yBC1k5QJCX0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82344288"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 13:31:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 13:31:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 13:31:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 13:31:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdmYH9YQxVnTFhr1yi7UinOyMDPo9g3nsPhPiGM8U1xyh79vHgjeW9hDA9dwNjKiz0ZnpMfeWgjwCv91W5BWQ9soCdPxFSxivSwtkBnAkHx9B74IehR/jhOErNdHY4DXRgEv54gfz40+r8oZwjwtD1nZH1ceIxEt1GVGGd2idbyfJ1r99h5BY3Be5qmBbGbjkfuJm/Kpghf0IASmRbzvA3SZeuUyRQ13E9wDQUOws4DYzn5wzS6JTneWLj/DupCa3zED3CCF3yIdnMPGaH2NkNGZ3SNf/60T9jzWsxLMywyVxm8S3uzQZZ/UxFUZ94gYQVehpIzuq/od3lGjvazx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubjp1H9+lerXKFGJB22YpkE3MPclelL+AQsFt61si0Q=;
 b=B+tqLDvLF2rKEiGkOs2tTLVAz6m2awE8wLBDK0K6yCrRzW5bkGvhrbujm0Gn+R4NfFVB0oYxZXnrlmS5nuI7m4E5T6fXlte/bvb0zXNg1GYg8+D54kCcC+KJFLzYsBj0D5atQGTvU6ml3ZScRgO0Yi3fNTnA6bEOKIsYjgMU/zakHkIebDtiyAyZexThsUyPp+WvDQNWTMyaYrVN3lidaOvAF0RTmDzs+1jblP7UsRJODTeFvx0JaRp3FLTEQiRNBD5iwqVReHS/WYwNy4i7rYihE5K3cF4whNAkcIcVvG/n3c4sYRo6aXgk6iOLpH6dLevqsjz2ujKoDdRGzpDJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 20:31:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 20:31:50 +0000
Message-ID: <7d2fdd24-6e45-4007-a0f7-cafa44c0ac4f@intel.com>
Date: Wed, 30 Oct 2024 13:31:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: broadcom: use ethtool string helpers
To: Jakub Kicinski <kuba@kernel.org>, Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Justin Chen <justin.chen@broadcom.com>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Broadcom
 internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Sudarsana Kalluru
	<skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, Doug Berger
	<opendmb@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, open list
	<linux-kernel@vger.kernel.org>
References: <20241023012734.766789-1-rosenp@gmail.com>
 <20241029160323.532e573c@kernel.org>
 <CAKxU2N-5rZ3vi-bgkWA5CMorKEOv6+_a0sVDUz15o8Z7+GFLvQ@mail.gmail.com>
 <20241029173747.74596c8c@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241029173747.74596c8c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:303:b7::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f0201c-a687-43a7-167f-08dcf921e260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0N1SnlFWjQ2STU3Y3BWMkpPd1dzM3ZWcnd2RHFnVnZ2S2dzSlJJTmFiYkdZ?=
 =?utf-8?B?dDQ5VFFnd0VWdjhtVVhWMHJPaW0zb3dVb1hNQWVtVnNjMEEycUhIMHFzbTJP?=
 =?utf-8?B?dGNMcXpxSndiR0M4QVZPM09DZ1dHaXZpNjRKdGdRYkl2a0loU1BNTndBV2ZY?=
 =?utf-8?B?bTlYa08rMldwakIxVHJISXY2SlhFTmJqeU9UNTdCaXhHZEo0MEg5YXhCSTZM?=
 =?utf-8?B?SHBsVXRYL1NTU0h4RldtdmQwY2VmSGdmNVI3eXlRV1RDR1kycTlOTGlRNEhU?=
 =?utf-8?B?aG9ZNWZpNVd4SlVHWk9FQmk0QStkcXIzV0JiVi9xR3VkSmp4Q0FDRDJDeGk1?=
 =?utf-8?B?MUtDRUh2ODMySE5uanlFQXpXcEtFUHY0b3djRnhOanJXMW13a1RFTFFUNDNT?=
 =?utf-8?B?THB4RUVKK1VQUmpwcGY4aU9SUU8yZ3dhMnQzeExEaSt3MjVyZWJuYXpIQ1hi?=
 =?utf-8?B?aUdYZE9qQWxFTm0xVnFlcUVMbG91UlQ4MFVrM1A0amI4MU5EL3g2QmNqVkFo?=
 =?utf-8?B?Mks5WnI4T2dFRGJPSXFMbWtTOG95bkJ4OTd0WGlpaENzWFBsL1lzSy9SY0U1?=
 =?utf-8?B?ZjlqZWlVckVTaHdROW5SeTl6ekU5UGNWUDd3aUN0eHJWOWJ3MEt5YUNOd2Fk?=
 =?utf-8?B?RVExd2dSeWZCem9LWFpJV2NQNkErU2JjUW0xYW5IMHhXdUxUOUFvUmR0MVBS?=
 =?utf-8?B?MHI4YXQva0U5cDE1dHdlRUp5eHBnbGh6Ly9XanhLejcwUWxybG0wQllZZHlV?=
 =?utf-8?B?UjEwL1lReG1jOTArWEp0YUs4MFg4V3h1Wml3cEZnUThFSGVFdTNjdEEvVTVF?=
 =?utf-8?B?MC8xK2svU3ZMaTg5YXdpajBuUkRQbUNMTElPKytSWnVxSjI4Vzd3UVpGUzhK?=
 =?utf-8?B?UWRBTFVRTm45MU9sOHNWdzJwM1l5N210UUY2ZWVzd0NwSmhoZllyNnZWdWJ5?=
 =?utf-8?B?QWJSSUFNeVMybW55dEpGbzJJZ1dXQll4OTJUTHlJRTJkN2s5M0VGZlNFWkp0?=
 =?utf-8?B?NGpaTHFFaXBnVyt2UE9UUmM3anJEenpyTjNoY01ocndWRVVLWU14Tis2dG9y?=
 =?utf-8?B?RlB1TVU5eFJxaytxV01XRTRocTM2MlVXY1hkS3VwWER1TjZpMEMzbDFVVFlo?=
 =?utf-8?B?U3BveHNOTGZtamZxT1VhYWdqM1FHT1JVQ0dWUkNNUlRiV0hRRGF1L2ZVTmhJ?=
 =?utf-8?B?SEduUXYxcHRHaXBuRTJyWFcxeTYvV3g1Y2hjbjZhOURidFpLZlFXZXJyY0dV?=
 =?utf-8?B?SnQvVzFCeVFSRndXT0RFdjBKY2c4RUd0ZkVCUlVIcnhwa1V0RzVacEphWThj?=
 =?utf-8?B?aHRrM0VhTFhFejlneE4yZ1YrNlU1RXhoRUk3bEpjSjNZWG9YR3UzSk1kQm82?=
 =?utf-8?B?Z25kRHpXM01oUTkvZWpmU3dTZUZzRXBJdzF4S3B2OVVQa3pTQzdkZ2JNTm9r?=
 =?utf-8?B?Tjh4R0tDcUVWUmhrc2NzWURSc243WGlQa3V5Z0t6SE9Ham1OYlh0SGRMU0lM?=
 =?utf-8?B?c29EdUtHc1ZESVpQbzRrNHBUbnFrYnpRYXlWV0EreEZkU1Y3YnVtSkd4NVI2?=
 =?utf-8?B?UXFwUXdkVEVvZ0VsUDJndUl2K29EaFQyRmRzUktkM2JwZE9jSFlrRnJtZG5i?=
 =?utf-8?B?LzlQOWJSL1VudzFpc2htamZSQzFHSENKanJYeUJQS0hWeGhvSnh3a2prN0xE?=
 =?utf-8?B?bVdlUEtFM0JkTDZpMHFxbmduem9VUW1mZ0swT0N3Sm1WQkVkU09hVmo1MUl0?=
 =?utf-8?Q?Nmalz8PZM42l4KIi+dqoAgfnQ3aP2Bb+Ht10jdB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE9weU1HSndHTmYrOHVPOVdxNmNwSVNXTHZwRGNKdGx5bFgydnRTaDdjVjZ0?=
 =?utf-8?B?RGNHMTlrUWNSWVp2WHhnNHU3MTBaVE9DdzNQTDdBeGc1WUFzVzhYcklVUlFT?=
 =?utf-8?B?S1UzbDhPUjJmais4T0FaZTZ1TzRmSlpBNUFKdS8xZDBZWnhBVkp3RnpkT09k?=
 =?utf-8?B?c3JXenFQSHpmWnk2SW8xeFM1UzR4V1NyeXNVS3Fob2FWZkFhRnc1K3lYKzR6?=
 =?utf-8?B?VmYwVkxqcElMVlA5Q2hQRVZPcG1JRHBMMnFGWVhCNEZNKzcvT3h3NGpHZmlw?=
 =?utf-8?B?Mk8wWmdIZHc3TWZLNm02cnVPZjB2TnRZbVM4VWpCb0o5OXRtMjZBV2RINDFi?=
 =?utf-8?B?SmtVMlAyTmpDOFB6SUZSMlVwemhrSFArRjNvUDFGVmRIR1hFeSt1RlVabVpM?=
 =?utf-8?B?WXBHN2lYTnlZWk5SOWJPYXVSN3JvZE95ZUI3L3hrVUphUndrQ1ZvUlRpVDQy?=
 =?utf-8?B?NFRKWkZWajZXdEQ4M2pUZ3hkSWRzZ2xwSTJMNnpkeEVBTjYxdFR2Rmw3SDJB?=
 =?utf-8?B?MFc3ZVRzRkxzajZjeE80RlBaclZoMGs0d1JTMmRtYXh0R205L0NDYXF0U1Ey?=
 =?utf-8?B?MjdmVWp4MGFQZGNnN1NuT1lTTlhxb1ZxRnpnR3Qwa2djdXVsSGltQU16c0ZT?=
 =?utf-8?B?amdWRmJ6aDFISHRZOEJEM3ZrVHFiREp1Q1JMSEc5bG5yZXF4N3hGVURXSHJn?=
 =?utf-8?B?Z3pyQ0wvWjFUSHo5Yy81WEFuVWRJSnI5NTEwbmMxdWZKcm5DeURaVzhjM0ZW?=
 =?utf-8?B?bFVsenMxVHBIY1F0dXl4SkZtV0trVzhyTjA1dnJXRmZmY1oxNkZVVGJYeUNL?=
 =?utf-8?B?MG5Ba2lSSjRSbFA0NDlhaFQ5aFhzM0gvanRnK1FQb1ovRTdPNzZoWWZCcDh5?=
 =?utf-8?B?YU55SG5pL1RTYWw3VkJuc0V4Tmw4dG5Hd2Y3dDNETXU5citidS82Vmp5c3Vv?=
 =?utf-8?B?S2Y0M25GR2lRMG1zL1NPcEZLZ3JRaUsrdXorTENSSm1YeTVTZHBlT05BaDRs?=
 =?utf-8?B?S3ZJVnUwZG4wdzlka2hHblpLZWp1K2UzSitVUFhKUU1Yb2IxR01QRi8ydDNK?=
 =?utf-8?B?eUl4UEVCcmR6TUQxeG43K0FNL2NBZlNCbTJoaE5KakowRmdiMnhUN05KZUhX?=
 =?utf-8?B?bkljQk1zejk2czVJRVlPdW0wc2dYU3VTZDhxSC95b2d2U0FzdkpuK1QraVpI?=
 =?utf-8?B?MEc1Um9pL3JrcHdPajlhcmp5NzVxUzhBTTFxVDc2S0xkdllXVG5hVTh3eGE4?=
 =?utf-8?B?bmxoQUdGTTNhNEdOL1hidjJ2SDNUZWREWjA3cTh2eTA4bmRKeE9Ubm96aGJh?=
 =?utf-8?B?S2dKc2ZwMlBuTmFlY1pMTmprbHBSbVpZVFUvTGQwOWppeU9vUFk0MU43d2N2?=
 =?utf-8?B?WjYzYVEyUTA0OEM3dll3UHpZd2RQUzN2TDdxZUVleUZ2TmVIRTJ2dmFITnVn?=
 =?utf-8?B?QVFwUEwyMGc3NW9HekwrMFB3LzAzaHRsaGZuSHh6RExpSkQzWEw0bHdOVWph?=
 =?utf-8?B?SXhldGV3WkxhTHgrUnVMZ2JIQm9jd2p1VklxZlJOcXpyWmF1ZW04NVU0OE1i?=
 =?utf-8?B?VjA4ZFlRQW5SNXc4eWR1Vi8wMVFMbGQzUUlLT3lOcEZRUHBnMUJ3VDJzYWoy?=
 =?utf-8?B?em0zOE9sVmhLV1ZJQ2JLeVR1aUc4RlRlRE1UVFpRWXZBZTYyTDFTY1l0b1B2?=
 =?utf-8?B?eFFmOFFWeWtpMW9Wek85RVVRQXUwSWJBVVUwYVFrMzBDaHVlYXNzT1dOYmpY?=
 =?utf-8?B?TFI1QnRXNzhqaXFNRjdzeVNzREYzRVFIQnMvZE1jVUtqMDNhYittK2RvMWow?=
 =?utf-8?B?R2dDclZ1d1VrTW5WcFRqVU5lL213dWRtUVR5OUprRlZTZzZIbElvY0hGMnNh?=
 =?utf-8?B?UE9kS2htcGVCMHZrbXZhWFovazZTcUMxandKbW9PTFE0M1ZweExDU2QvMXdv?=
 =?utf-8?B?bmdFWVVDeXlVVVZiaWcrcHFsQTV6OVRmUytreHRpQnB5VWQ3YU40YWl4OXpR?=
 =?utf-8?B?RURDOXh4SE1yUm1IVGgwMDlKRUhUSXF6S2V1b003eFRKUTZDTGJBOVJLWXht?=
 =?utf-8?B?U0FyMGdLUWovM3ZhN2Z0a3BKemFqOEg2ZmFXRFIvMVJlOWZaYzdQL1NvNVM2?=
 =?utf-8?B?Qk5OOU4vaWVMQlM1Rng4em5RcmxEVDc3Wk14NitQVzFFYkJsT1QwQ0w4L2Ez?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f0201c-a687-43a7-167f-08dcf921e260
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 20:31:50.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iesax2cs/AqbrqxdjYeZf6YZp1XNMPPVFmkHDn+nVzXbuskpLTydSeGqGAjNceylEwpSWSwYa1GkIJNaMYahLXmkzkvCW1M1kHMhRnz0lfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7588
X-OriginatorOrg: intel.com



On 10/29/2024 5:37 PM, Jakub Kicinski wrote:
> On Tue, 29 Oct 2024 16:43:15 -0700 Rosen Penev wrote:
>>>> -             memcpy(buf, bnx2x_tests_str_arr + start,
>>>> -                    ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp));
>>>> +             for (i = start; i < BNX2X_NUM_TESTS(bp); i++)
>>>> +                     ethtool_puts(&buf, bnx2x_tests_str_arr[i]);  
>>>
>>> I don't think this is equivalent.  
>> What's wrong here?
> 
> We used to copy ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp)
> but i will no only go from start to BNX2X_NUM_TESTS(bp)
> IOW the copied length is ETH_GSTRING_LEN * (BNX2X_NUM_TESTS(bp) - start)
> No?

Hmm. Yea that's right. I'm guessing BNX2X_NUM_TESTS(bp) changes the
number of tests based on what start would be...

Probably we could use a static size of the string array instead of
BNX2X_NUM_TESTS(bp), and that would fix things, but this specific change
needs more careful review of the surrounding code.

