Return-Path: <netdev+bounces-167918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528DA3CD8D
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01603B7E5D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433DF260A44;
	Wed, 19 Feb 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCxgrSTP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7465025EF86;
	Wed, 19 Feb 2025 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007799; cv=fail; b=erN80a9ILHZG8x1A90qnA/8Y3SQuPrec1dIHtHEGOJ2JDITGX25rq+OJOLrWbwKwNuOX9UVJQWju9C4ooWp6Fc7sNjASOQCSd3B5ckULkbWttJkevmQlSpsy0wCtVKn91mxtJdHLJy9qrWn6Tr25bZiTs5hjhAtcewJPvEVrnxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007799; c=relaxed/simple;
	bh=+fa0Itj0648kXPNBHP4kWzwvw+wxGEJ5UhnYVlw7hEo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5RIJvY2FgyN8kPjtyrzvTvZDMf+BNR0Curoe5S45FFL6ArJTCx7S4dptx8DtMR9Uhn0/BO5aYwxEmOBZxZtvrr3HF8q9Qwwf9T3yyw0pUsrBmcmp3nGozwNE/+vr9fsdrHE1iPH4MK49BW+m2QOk/FcnEZCGUbo2ZYbYhRCe+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCxgrSTP; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740007798; x=1771543798;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+fa0Itj0648kXPNBHP4kWzwvw+wxGEJ5UhnYVlw7hEo=;
  b=YCxgrSTPDaJ1Pwn2bDP2nQSi6WNGhfy/29i9q/QshanWbPWkiKwu5Wfb
   YmhnlJRMa0IvZsQAMdCKqyHf6QGoTJ4TfzF4WhNvOy0/oWu6/gsPw2gTt
   M56CCd3UuhsvBfY5aMa6FkiLeqcbKYOOFoDXatHjIibTSTn1abryz2Ehw
   PHVEv3a0QgxPz29sZwLYJIhrt4J8REQANDjRDImrAWG0vXyBGk981tc2Q
   1yrTQBO6HliFOkbvtPM1OCaFGst4Ey4NxwsHkbYoZsYbuJ3BrIDgjN3sg
   Rw0RyT9rEfbFIlbb+iqKRc01jFJgitrrbFt6ds/TVf67BxurKAhPC+u2u
   g==;
X-CSE-ConnectionGUID: j1JGTeMuTEisC/b/sZpk6g==
X-CSE-MsgGUID: 1ewmHlFUQ4mD9A21MfEkXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58311838"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="58311838"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:29:57 -0800
X-CSE-ConnectionGUID: BU//EWmiSV+8b+fy4r0ThA==
X-CSE-MsgGUID: V0z3dILkROave8fA4BwdGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115404344"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:29:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 15:29:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 15:29:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:29:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFkcF0ynF9Lbv+o1bQgEIeFD/g4YaZ8aSxT/DkXijoLCQST4dwwkv2VSLv71N2bDn03ZLRCLWtAaH0e4WkApN2+KkEbX895dYgPBg780g+LEYkLAShBvBjHKcDeAEMeovb3/or95LqRhztyZwsTMrnlx+yZlsZLErRlJx0S4D00X9WydWsBX29oboSM0Ugjdl/1HztgrY9pWWTXp35fYdU3mHr/2DLgYmhR0CCBq+HUNFZ+ZSdOVTS0Ztg7o06pjkz1IhiZnPU1R8Hm3HiDUUK9e1svOek6NWyn1wbSty9wQWd7hF7m32LJ22hHX1rXFv4YUjunLpSIuuXuV78GVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYwraooxORnTPQaXdcLQUWBaR8U8eEnaD5QZs0yfwDs=;
 b=Qr+DjYNQXLc+3n3zPeGpkz6PN9uZGYRLTpoCPBiKyGB9GUpgGyNToxxrFYUZscpUfbt6EXqN53LBETnsTld7liHVsNbbQnbrv5vN0l/BDxerCQMvQ0fKZgT+2ob3mKmY7AbA0imlHIiJz18ejQqxmLVM/GEtBmnjupupoiud5t9fA/3VScpxldOlD1WILkFWu0afaMmF8u+SN/w+3blrbjbBjzEfOxyrRktGLn3cRjDK19nHMvQMl9sB/u+p5sE3GrPDzAb/lpr13J3pWtaWwkNVvxRCB25iskWi+iZF9nYQL95CBsUerqxzxS3L4zh8A903wJaKykiJk7aSWhBU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8577.namprd11.prod.outlook.com (2603:10b6:408:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 23:29:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 23:29:53 +0000
Message-ID: <889918c4-51ae-4216-9374-510e4cbdc3f1@intel.com>
Date: Wed, 19 Feb 2025 15:29:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: axienet: Set mac_managed_pm
To: Nick Hu <nick.hu@sifive.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek
	<michal.simek@amd.com>, Russell King <linux@armlinux.org.uk>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Praneeth Bajjuri <praneeth@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250217055843.19799-1-nick.hu@sifive.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250217055843.19799-1-nick.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:303:b4::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dafc638-1cca-4881-9185-08dd513d4ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHd6L2huaDZnU0ZONGJLM3VoQ1Z3RXdEOTFEMXZNR2Q2eklmMjliRmxsWDNS?=
 =?utf-8?B?YXgyaHhpazBNQlBTTEtDWWY2T0JaWDFDTmYzeEc0RTFhVTVrQXU2SjlsNlpP?=
 =?utf-8?B?VUtLc2lDU202ZU1pdlZvVE0wVGFZWlB4Z01jWjhMNVJCUHJZb2xvTHJCN1ZN?=
 =?utf-8?B?TGZpUkNtNXh3YkZyWDlUQS96bXpKY3BHakk1RjRrMEh1WG1CL0ozb0p2bm8w?=
 =?utf-8?B?bm9BZG9kZDEzd0JNNXhzU01uMFZPNElhVVR2Y2JxS2o2Tjc5a21JdC9aaFpC?=
 =?utf-8?B?ZDMzRGdURHN3Y2dvS0NkNDBVK1hObisrZWpQNHZhS2k0R3dqa3graWtlTkxM?=
 =?utf-8?B?QkdLMHpzUnVTWno5dHNhUDQ5bFZDWFNxcG5tSDN0V0lneXNoV0IrUlBnb0RJ?=
 =?utf-8?B?TXNqendIR2ZOQnRGeDlVd3VZKzM2bDZnTkRUMVpYYmFGZXQvMlJaamJkc0NZ?=
 =?utf-8?B?a1V0aURKL0xaT25GSm0wV2VuTHhTODJPYWpnaXVPOVk0eVIya096c21Xc3hR?=
 =?utf-8?B?QnJGWDhQU2d1elhvSytUb1hKeml6WnA4aFJRUnF4YThCMjN4ODYydDEzNk5o?=
 =?utf-8?B?dGNXZkNMMU9vUzhWcThvZTZqV1pucXM1QUpVS29Ob0h1U0lsa01MUkRuY0ZZ?=
 =?utf-8?B?MzhLRGZTRlJnSElkblJhWlFvellJb1NDRWJMaWRMTXg1Vmg0VkhrZjlSMDVJ?=
 =?utf-8?B?NEhtaENVOWFuQ2huNVJyMjdMajZ1VEVKZnRPeDJDcGhndkNzWFhubGtmdHVM?=
 =?utf-8?B?VkVEWEtrakdiZU1CaUlzZEUyelJ1YndpbnRaU3pmTVMxZzRrelEwQm5tSHJy?=
 =?utf-8?B?NTlPNjI5eWZnS01NQ0dTUmtHb3VNMHZzdzNpU0RaSGtrYzN4eWR4YWx3K1lY?=
 =?utf-8?B?RjJ4RlFvRDFXL25MN0hDWFNXVVFMSHErdy93Yk9sTGl4Z0FESWVLTENPVmcx?=
 =?utf-8?B?Q2ZCK1BSTlZ3QmVIR0RWSjdqdHIxNlNUQTdMbERGSW93Wks1TGxzdzVaemsz?=
 =?utf-8?B?cjdxU2VkaVJuNTNpa0t0NStUOGE3L1BKSW42TlhPMlpGQ09rUHBDQ3hzS3Nt?=
 =?utf-8?B?UDFhYWdIM25yMlV3TmNNYy9jTjBqR1ljR2pWRnQvRlVHWTYrOHNPMTdyQVZ6?=
 =?utf-8?B?d2VQclliaHFHRk5naEUvNHlJMWJTRDZEN3FyZUZwcGNaQmR0UjlvV01naTd3?=
 =?utf-8?B?bTRMLzlwQUdET2k4bjFXUEhGUFNHc2tibXVQbXpXR09xSVE5UHJaeW9JSUhi?=
 =?utf-8?B?cWtlWGlURGt1cUNIZ3RKOG1WZURLMm42SkhadzAydFpPTll0Y1BtTm96Q1pj?=
 =?utf-8?B?MFRrRmxlcHpGSngwL1dWSVZOUnJWaFQ5YTBiQ1VweVhqMlF6ZUpBaTNlL2V2?=
 =?utf-8?B?REdsc3FkQmFqYmdCVmZqbWZDbDgzZjVTMThqeGZBb1dZSGlPdEZiVFlxUzhh?=
 =?utf-8?B?K0duNUtwSnZXTzRFczZRVHN6SGd5ZVYrbHFEZHZZK2ZGN1I2U2NrbHVNRDcy?=
 =?utf-8?B?SEJxNjlIV25ieUgxQ09JWGJNSUsxYjlPZ1kxRGFCTGZPbjE4YUVvMFZmRzFW?=
 =?utf-8?B?cnUzd0xHNHJPV0JleTk5WE11WGxBK0wzWVZHTm5WL2duSndYc0NuVEpVMVMz?=
 =?utf-8?B?WFBkS3kvUlpaVXN3bDVickdqNUdXaUpEamhVZVlGczRkZVdiSGJsUi9pV0xx?=
 =?utf-8?B?TzdLVkdFbGdWekxOL2xnZmdKL2lRaEc2Nm9PQnFNVkYxQjdnTm1HOE9rRHdl?=
 =?utf-8?B?cm5vbXR5d1R6VUl6L2NuU29LczQ4UDNyMHI5WWpaaVdtWStRWFFUdmRUb1VR?=
 =?utf-8?B?cG5CK2FlTU5USlFLdDFCN3BsKy9OYlB0eElMYnlUTDFISTBsakhjd3AxVGVm?=
 =?utf-8?B?ZTJiWkx2Tk9IZnRnZTlhSENWRGpPS3FCTUV0cHlGSGI5Sk0yWEFqOEM0VjJs?=
 =?utf-8?Q?QKtnCFE074w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0F4V3l0UzF6cGhINFBtc1lUSUtnQTJBM2dhL2t6OEhERW5nNldYS0V2ZkpU?=
 =?utf-8?B?SFlVYnFKVHJnM25wamgxejI3Q3BnN2NVWXd2K2NNZkMzbWdodVVwTmYvUkhx?=
 =?utf-8?B?d3djRXVQTEN3b1FpMW1uUm91RFJHRUZLSHJ3b0ptRHMvNm1EVGVMMUFoR1Rr?=
 =?utf-8?B?bnpSTGZSU3FaS2Q5cWdSWFdBNkpWU1FNMjNySjZrWWhHZTZYYUwvUjA1Mk9w?=
 =?utf-8?B?cEIrQ2czZ0FsMDJvMnZyR3pPUVBnRzdpRXRhRkRFSUZaeks2dnBNMWZDWXpV?=
 =?utf-8?B?M0pDeWJTUHNKVVY5TEkyaE5GK0w0eStUOENSbXp4UXhtajF3VytSNHB4VElm?=
 =?utf-8?B?VGpWTXZDeWp5b1lYa0RHQU5LRjBRTHQwZjBqRkdob0J4K1VmMkxVbTQzMU1l?=
 =?utf-8?B?TmRRVDBKMW5PR2R0Z0sxUTlFRzl1VHptNG1uZ2tENkkyNFlRZ1BUcjY5Sy9l?=
 =?utf-8?B?TXhwSFBkVjVFT01Lc0h0RDJGRWlMNlUvK0kxY0o2aHZkSEI0OGdLUmhoQlRi?=
 =?utf-8?B?ZFYyNEJSQmhXYWtsdmtVQldBU0FPRVBESmhqUUdsWkFiTGhJRmVLd1BPZjdJ?=
 =?utf-8?B?QjBkYXNmR01JRTlDcEptQTNNOVNaendOZm1aaW9sTmJiMmdGY0tCS1VEeitv?=
 =?utf-8?B?RVNIenVYY0xBcVlUcjBsT0VoS2srMWZjb0hMeTBOTHJEU3VJMnNHMHNHa2FK?=
 =?utf-8?B?TC9mYzYxVE5hL2RhT2F1ZEU3R3kvYW9EY3pTNFlzUHVqd0xRRW9XUlhRK2RK?=
 =?utf-8?B?M2RmU3RuRHJXUDh2cjFrR3cvdmc5MmJNM3Z1TjJBNWN1akFOMk9mQWZYaFZP?=
 =?utf-8?B?SFZncG1aUVk0RmxvRTlvK05UYmIya3VtaDZlL2VUdnVFNUFZclhHTkt6NmRM?=
 =?utf-8?B?NGlWMHVlOHo1d01hWm82SjNnSlpGUmRQVTZxQ2hkZHY2OWRLb04vdFVkOUJP?=
 =?utf-8?B?cGhXUTRZMHZLcnRLeGVGY000YlVNRnlrWExXdmxYVGNFVzRZSmZSVjBHbUh4?=
 =?utf-8?B?UCsxLzl0R2ZBOUtRSEhEVEVjeHpremxBU2pqZE4yNXk5WmxiTHIxeDBSWDRm?=
 =?utf-8?B?WXdnM0RrM3p1d2RLSjFhZHVwWmU3eTA1OUpoTXBjZGxvcUF2RTZwYnJDVmtS?=
 =?utf-8?B?Vm9SdnZISDk5ZFBHVm9PZFc5MFMzZHpIaDJWT0tWclFVMTVCYkg3MGowMHBO?=
 =?utf-8?B?a3k4MXNJdDVER0FYRy9Yd3FDYUNSdUsyMDYwQ2JiYVFwSG5hY0NUZUtaa1Az?=
 =?utf-8?B?RHJhcGVPVGUzNkM3UlAweEg3UGdsekpyUkpFOS9aS3J0bE9wUmthVkhubGVk?=
 =?utf-8?B?Tkx1OU9QcDRKZVlHaGlOVlBXOFdKL0xzRW1lYTlpdnNzbXVSOEpKYmlybDRp?=
 =?utf-8?B?SVNZSDl0dFh3YXQvQlBTdGVqUHFqWE83S0JiNTd6alFUWUd1d3djcmd5b2ov?=
 =?utf-8?B?aTd3cHk1OEdnejFOR3QxM2xKcGVyOEsxakVkckxBWUIyaklzcWpNVms5RkY3?=
 =?utf-8?B?TFNNMW5RTDI4U1NuZXAwV3FKbnV1WmpncWtxODVjTlZ4MWJsTXNRNTJDcnpP?=
 =?utf-8?B?TzliTzhUSzEzL09JdXpTdDFzRFMzOGNYdE9WOTlGeGQxcUxyT1l4WWI1cmhh?=
 =?utf-8?B?SHNBWThOU0N5bzdibnNQNTBoMHdFWkhGY1BLOG9VZTg1VUs4a0s0NHVqUTNy?=
 =?utf-8?B?UjI3dlAwYkE0M1piWGg2YUhOR3hJOG9mRGxScGZvQ1owZlBNRHdvcFBmd3hz?=
 =?utf-8?B?YzArd0pIN1prSG4zQlMwWVpSWEpVRVh6czVYSStZTzlTWTNjeU54QS9rYzJB?=
 =?utf-8?B?RTJ6MGMwM2FOZXBzUnZFWGExMW1UV1pmTG9FellXTWZWWW5ZN2tFbTMvREtP?=
 =?utf-8?B?eVlCYnRHSytZQ3ZobXV1ek8xa05wWmh5b0k0aUNGemU2dE9zZzJJQVcxTk5Q?=
 =?utf-8?B?L2k0OXFjdlhrbXRUU01WL1FLZkNYU1NPODZMMDdGTXFvMXArTmpBTExvTnVV?=
 =?utf-8?B?TE82S00zSFBCQTJRcEQ4RTdqVmtPMEZHQkl3Y1RPMmJrQkQ2NkMwMDZQYUF2?=
 =?utf-8?B?enBmS1BMTENZbkRkWUJjcjhsWjZaMDdaNzBqaFdYS2JXVEhPRHpoeGRuUWcx?=
 =?utf-8?B?ZGs3SFpmTzNzVHdyZWs1MlRWME9rMUl5RUlEaUM4bUd2Q1oyRjVqL0lmUmt1?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dafc638-1cca-4881-9185-08dd513d4ff2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:29:53.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Myx09c5eQJA05vT88C0lmeATefhzU8kSJSzIs/0b0vP+Qhve3yto+4PoYUc3ikCfEol7EQg4dBt1/hQuzunYwfRzVjQbVFtItkU9+ApMOVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8577
X-OriginatorOrg: intel.com



On 2/16/2025 9:58 PM, Nick Hu wrote:
Nit: subject should include the "net" prefix since this is clearly a bug
fix.

> The external PHY will undergo a soft reset twice during the resume process
> when it wake up from suspend. The first reset occurs when the axienet
> driver calls phylink_of_phy_connect(), and the second occurs when
> mdio_bus_phy_resume() invokes phy_init_hw(). The second soft reset of the
> external PHY does not reinitialize the internal PHY, which causes issues
> with the internal PHY, resulting in the PHY link being down. To prevent
> this, setting the mac_managed_pm flag skips the mdio_bus_phy_resume()
> function.
> 
> Fixes: a129b41fe0a8 ("Revert "net: phy: dp83867: perform soft reset and retain established link"")
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---

Otherwise, the fix seems correct to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 2ffaad0b0477..2deeb982bf6b 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -3078,6 +3078,7 @@ static int axienet_probe(struct platform_device *pdev)
>  
>  	lp->phylink_config.dev = &ndev->dev;
>  	lp->phylink_config.type = PHYLINK_NETDEV;
> +	lp->phylink_config.mac_managed_pm = true;
>  	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
>  		MAC_10FD | MAC_100FD | MAC_1000FD;
>  


