Return-Path: <netdev+bounces-184473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAA5A959C3
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 01:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD183AB358
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 23:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D5B224887;
	Mon, 21 Apr 2025 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlDVaYOj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52B1EA7C1;
	Mon, 21 Apr 2025 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745277840; cv=fail; b=ona2Uw8XxmF6Ru95GsM5XXOcpyhqizRxjfKOH+83FVIDv5gYcyxF+mZ1zAN9k5tKrIsd+/V23IFs6qmQPON7YrqvEsGY0xZqc7bWhLjxVF16COlqBW5II8/V/H2JOB8lYZgqESmDsuhyEmCdvtYDKSUfKgdXIzdWtXlOAo6+0a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745277840; c=relaxed/simple;
	bh=YQTxVYf4IddqYnY6m2wjr9g/mruEi2fQdfgC3hkty4w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pSBob1l3DnrOUhDHXTlh5B9Egwm/+kdOZ5wTniKWxSV0o7LidqBPkcHyzZIVC5OxkcIXAk2II+o802LFNfoPphZIpCGHsrmcCgBiKJqzWQAaKVDPtcxfXfASa/A1RBFdZ4FABNWc6u4J1Bdq43Qz8VFS5UEnsoRl5TplE4qvE6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlDVaYOj; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745277838; x=1776813838;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YQTxVYf4IddqYnY6m2wjr9g/mruEi2fQdfgC3hkty4w=;
  b=UlDVaYOjD+uS8B9zwkCtiIIBLiD+Upqe3f7hKVd3py+YTKNl6oh8Wg3b
   KcTsKBP4Jj8pILvINTAyqGFibj6bwABDbqorJNDeklzZzx0zPYrFUJgKF
   ulDLHm6YZPHL8hOXxB8WrIcVIuLEdib3eqivCRPNlbENU1wf2kcSdycpw
   y+3vSn/ABrdKfckaGm+1hUO2KawMZ94fE1PRdXzEwyCHjXSrbLqmgSwWc
   zsa1eP1U3DMl30gmahBqMLfcF3oVQMe8++6gJBT6wugh025EdAa18Hmgv
   zn7UG5ULRmhG+C5S1YF4Fg8izJpLKpjHD57AFBm/GkKp0+TxfDUrZakdI
   w==;
X-CSE-ConnectionGUID: GVAuC8XWQouVsnuiM/Yj6Q==
X-CSE-MsgGUID: D4P+g3QOQnuB1J+KShIIYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46703127"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="46703127"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 16:23:57 -0700
X-CSE-ConnectionGUID: XEt6I0taSe+LorRAtkLs0g==
X-CSE-MsgGUID: lmr+9bjhStm3b8+bjduRDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="136712880"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 16:23:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 16:23:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 16:23:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 16:23:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jaw/VZgMSgho+XyzVkTcfxckaXLq8n+aS1l/qjLuF6dQQB4YkfV/zuYmhmD9kSjwU/KftbFqQoaEl+Ct64P9XVaiMvWbNu1jP5qFirVk7LPUhzD9z4Xn3COt6cPIbJ6GQRPPTX6BOwXk2WxquJvXaYJ3PDi8E5ZjH1uC7Jpyl4Ur4/g4O3V8cFDeFNP+XS9m2vFvOw8/G9ch2VB7cFdGo/nDyTIXi0f4RfNBz2bWTGm/tGfsKWIkHG4sdKi4v76Ie4wU4ROQaxPHyP51R5ufuY7Z+WilDsaORSXvypt5/kdxT0W4IHhhr0xygKj73eeVWsfShiYXtVgGa5tuZ7IUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afDCj9bV6FdY+ymEdWt9RPgTF1ra3+FuAQcWaEgYjG4=;
 b=UuY7fF0yqqlgCkEmJuGE7DGmtr6855VvWrH7VB/z+Hw/6NoQH8SIJK+G+ZjDOCgYUt1eSmmy540hqZWxZqPkrM/zdYukhiqULLZ6HdEQSROX5O+CtMLLJF0Hj6hzqJsd8jxgad7M4sH3IzX0IHMTzyo9ptfPDA2EwK0Dcgx1Bnd1rF+eITd35oOv+wf/gZzDpdBreQuZkWnVOb+1NTBgeck+y5NJ+r6fQlqCvvybdiZQ/QDOemrpTaYDfJ2QnbEXmJOd6PfNFNurT6OEWiqdSxsIlanbQMbjOTTRt3CahPIh5b5mBmgPCwM/3zVmDKBodMJsiB4OJAXhog/a+tiyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7901.namprd11.prod.outlook.com (2603:10b6:8:f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 23:23:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Mon, 21 Apr 2025
 23:23:21 +0000
Message-ID: <a942be9e-2799-478d-b8c2-7a85f3a58f6c@intel.com>
Date: Mon, 21 Apr 2025 16:23:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dlink: add synchronization for stats update
To: Moon Yeounsu <yyyynoom@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250421191645.43526-2-yyyynoom@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250421191645.43526-2-yyyynoom@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:303:2a::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb7250f-d339-4674-5f9d-08dd812b8152
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlNUWWl6WGY2MHloLzNvM1Y4ckgrNFFaNnVmb1VHSnNHQkw4NGVyclV5SVdj?=
 =?utf-8?B?R3dESHJDMGZweWJYZHM2UEJtSzMrZFVlakt0cmJZRHgrSHhSTWhEWnFEU09R?=
 =?utf-8?B?U0lLVXVYYk5Ualc0NDdYb1lmbHRzdGFSemxPdkU2aG5NMW9DbWtMSDM4a01s?=
 =?utf-8?B?OEZpamhuVGFoT2tHUk9FOUg5cWJXSjNOS3NZMElQK1d4UngrdURwM0ltaWVN?=
 =?utf-8?B?VGpRdGh6WVRMZXVTQVNna1N0NWEzTk5ycmkwZ3ArbjJxcVhxQjczdndZSFFU?=
 =?utf-8?B?dFk2YnhQRCtzT09UQnhOWks1aWtDVlE2aWxKMkwrSGRCWGFQTnJqWTgrUFZx?=
 =?utf-8?B?cDhiWTBDNy9LeGxldHN3Lzh3WDllUklBcjNlbStoKy91QTlVY1JpQmFNeVNr?=
 =?utf-8?B?QjFTWG1KdGpGVkZpb29KUERwZmNSc0dGY0h5b0daYm0zajRkNit1MUtWZUJ3?=
 =?utf-8?B?am5KUW1FbHY0WXZFOC9TYXViMHppS1hYRGppbU9lTTBNTUlZMDNhQ0lwNmY5?=
 =?utf-8?B?TXhOa25uSFI1MVh0cERNY3ZmUlYyRmxtVVBWRXBnSXY1bGlwYzFxdzFSWnpC?=
 =?utf-8?B?TGEzSnN1WlRmaVRYN3czN1hRcDhwQ0wrYm5rV1gxbDJuUTZrbXNPMVNzV0dI?=
 =?utf-8?B?NUplRU03a1RFTEJNYkcrR2picjNkYWpqWGl6QjFLVU5ST1QzV05xcWd3bnRk?=
 =?utf-8?B?OENPR3FpQUJIc0FuV3pUbGlWSGVkOEJWbTVRSk5tNkVEdnJNRXl3VzdDT2hj?=
 =?utf-8?B?R1BzeDFZbi9MYlZBb0tyb2tYOXkvZUg4MGEvVGwzUkpwUlBUMVV4aXBxbU94?=
 =?utf-8?B?ME94VlFjZ2x1NklvVnZHbWM2YkhhMitYYk5QU2hhdkJVQVhCMDNqaWdsWkVF?=
 =?utf-8?B?eXpJYmF1bVJjcmVnWTJsSlIxV3RmbDdLdVk5RTJoNENkN0dhWUdoaktLekpO?=
 =?utf-8?B?S2tid01MVjdNNTBERHJ3eW55OFVPZXB5KzFTR2ZtV3BVRmFrY0o3RVVLQjJu?=
 =?utf-8?B?WHNlS0tmL1pkdUVMSGQ0YjBFWXBac1kwWXFNYjhCeklTYWYweUUrMlljdlZP?=
 =?utf-8?B?MThDOVYyVS9uREVHb1lmRUJidy9veU56QkxlWDBic1dkMWFmVndyVnRMVDMv?=
 =?utf-8?B?d3FMVEIyQk1iYXZnd1FPQjlHaDJhMytta3VMVkE4dmpHMXhoekh4dGNDZXpR?=
 =?utf-8?B?ZUgzSDdMTlY3VFZZWUJyOEs1ZUVQSHljNDBleFpQMGV0Sm5hU3U1d3JQS1RY?=
 =?utf-8?B?MUI3anJXSnV6NjJtMG9IQndVU1grdnFuNUdrQ0x3WDEzSXFXOXRvR2JFa1VO?=
 =?utf-8?B?cWRKeE0xampUclMyQ28vYkE4QXhKVUZuREpRamJ5VlVCVzhGTjd6UW10cmJI?=
 =?utf-8?B?NkJORnBsZ3JlblIwamxkNHNsMzBSZE9zSjNhQkMxR3hLejdJdVFUUGpsdkk2?=
 =?utf-8?B?VnNZN1pyNlBWcEJPN0t2ek56SXVhZ204dnVLSmpiTVFDYWpPSll4TytpbWlC?=
 =?utf-8?B?R3EyenFXZVlCa2QrMUtuTUZYbVlobkhFdzBwOVBjYzVJM1VBaHBBM0tEUm9J?=
 =?utf-8?B?VkVUYnFXR09oUFhWMUtSRGFHVnVqYmFZemw3d1ZwbTJzbGcwblFCL1loVC9t?=
 =?utf-8?B?SUNZdjRNZzNxeHBIZWNEZk1QNkJha25rV0daamVIVVlIbW1MNXlHL2ZieEMv?=
 =?utf-8?B?a3UweW1tZXM3MExRYWxSVk5MU0U0c3lGMWg4bnNHQ01tbGpqWThjeHI4NFgr?=
 =?utf-8?B?UjA1RHFPc21HM2NQM21lZGtYNSsyNFdCaW5aSzNhTW1abHpUMSsxR2pGM0c2?=
 =?utf-8?B?aWtra0lGRGx1MkpCNUE4cjkwcHVjblNsaEtJMWxsWVA0b3lQbjI3dkUvcXNS?=
 =?utf-8?B?Nmc5eHIzeUNMNVlldzlQeXJiQjc0VlBQUmVLaldzcEhZazN6VEVQcG9wcFY1?=
 =?utf-8?Q?qEkRdMZmElY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JCaHg3akZSREo1VDJJNGNBbkFtR0JLRzhHb1hzRE1IejA3Q1J3ejVXRUcy?=
 =?utf-8?B?M25aYVVUUEtkZG9GanVFNzEzV05Yb2RxdWhVRHRRd2xneno5L0UxMWJDSUIx?=
 =?utf-8?B?VFlJMDJ6UGRBOVJTNU9VeHBMdG9YbmhnU3hTVytiZS9QbXFnd1ZrOTMxdU1L?=
 =?utf-8?B?K285K3ZlS1NjNHl2K3FqMXBoNVl1NDRaQXRacm83cEQzdEd5TURlWVpzbFJR?=
 =?utf-8?B?TytCTUlRbVNiMUsrWUhJbWJxMXByWFFBdjVyTzloQmdFZ2tjSWxEeDZBOFRR?=
 =?utf-8?B?ZVFwbHdKMlRuRURnVEkxTDJzYTc0dWIrZlRPckhGYzBmSTluQm1DSjVhSm5L?=
 =?utf-8?B?QVpHbUIrdzBjc3UxNWczVTNKZTRaTFFMa2Q4KzdrNEtPWlM5SUVJRWdwT2Z1?=
 =?utf-8?B?NDhXSU4rb1FYVVAxU1B6M1ZSSE0wVVhjTGk3SWx1eHN0TmpQUXdOS0d4cnNq?=
 =?utf-8?B?cU5PYUdsdWVxU0UxTk1uMko0OS9vSnpkd3c1N25IV1VBQ3J3UnlGTlBuaGtU?=
 =?utf-8?B?NzM0TWxHcUlPNWdySHJsS3Btc1BiZk15L0YyOGQreGR5bTJGMGcySHljOWc0?=
 =?utf-8?B?NEdxNlh2NTJmSEdSR2VqVnI4NzVDOHZ5bTloeFltWE5nNUpvb0Z3bmNGbTg2?=
 =?utf-8?B?bEMvbkt5bEFDbjg0aGtxTnNXUm4yWXJjWk9UY1hKRUMxekp6L3dLZ3QwVjRa?=
 =?utf-8?B?emlPb0pTWHVtOUlMTnZpTXR5ZUkvdDF2S1MxckFvWmJVYldVekM2dzJtU3lG?=
 =?utf-8?B?cjErdjRYSlkyZTd4eHRSTmJPRXpWa2p2WHBPakdZa1Q2Zm13UTlTNU90LzFU?=
 =?utf-8?B?QUY3cnlld2ZmTHZiR0ZSd28vOWp5aHhaMGRwZEF4cWpLVVZwbklWL0pvVmZP?=
 =?utf-8?B?VS9sTmpwUmNlbVYyTjhvL2h4YmxRUysyRDc0ZlJIMmhmRThZaGJoM3kvRE5M?=
 =?utf-8?B?bHNLWjVQeGFpMm9NWU1XY1hoaHo0NXZjSHlWRGx6ZTNnRzhWZWd0bHZnUndU?=
 =?utf-8?B?TmtJSlJrd0gwMjRiQmlWZDZDTEUrZ05zd25xUkRTQ1JSRDd4dGdJWGYzakw1?=
 =?utf-8?B?NFpoK1BxV1pWaEZueE94T25ncEZBdXZyZkRZTFVjTy96aXgzaktBM1BjcEkw?=
 =?utf-8?B?M3g0TmxpdXJCcHEvZGpIOWtaMVVCWlVTTCt1cHMyVHFCU29YczZ0ejlRQmZX?=
 =?utf-8?B?UnpMdlpzN1o2QWdnbklUOHBPeVlkVGhvVXZQVndxY3pBWkxiSmlKRnB2VVJO?=
 =?utf-8?B?MlE2NStMVmpVSVJjNWV6REV1a2g0S2kyVVhIOEljU2JUQ3REYlZPNTkwTnYy?=
 =?utf-8?B?K1lOR0NaL0pmeDhyWVh0cjVoVVM1S0c2ZWdmSk95RVpMZTh3NDBKaEtGYmxh?=
 =?utf-8?B?SXBiZ2YzWWxEMXlVVTN4ZnFiN3Vlck80L0JKbi9PV0x4MlFoN1REdmVsZkhT?=
 =?utf-8?B?S0ErVjBCTzU5akhqSzBSV2pFOTl4eUtEanluN3VuanRwbWhqSHA5dURidjN4?=
 =?utf-8?B?enlBM0hpemM2RjJCczFnM3czU3dDQ0xRbzkzNnlvTk1NM0lWSjdJZnk3NHZ3?=
 =?utf-8?B?dFJhNGJ2WEFFN1lNREhnYm9XVEowQXk1VSsxRnh1WmJzTE5PM0poM1NTMngr?=
 =?utf-8?B?WGZpUUMrTTQ1VmV0KzROaUtic2NmdjFyQXMxSE5tc0RaWVJjTk56anRPTk1p?=
 =?utf-8?B?RFdQRXArRFRLQVh1R1IrTk04ZlpzdmZSU2NFdjNGS0svQVFQbUk3VEFuQnNW?=
 =?utf-8?B?ZitIUlhTd0VXTE4yZFFWdks4QWFGOWhzY1JZTGdyQnJpNG9tTUE1VmdweUJ2?=
 =?utf-8?B?eVpOem1mc1BWNENoUElkcVplNjhzT3RSTnV3Y3BXaEdCZnRid1VMemdSOTha?=
 =?utf-8?B?em9BL3NBam9Jc3hjNmFjWTJFRW9wdXBWczBzNzdHcDZJeUIrelBXWk9GMmg1?=
 =?utf-8?B?SWZSeE1JNENMaUlackx0SzdZUHo5SEQrK0J1bVNTbFZvTUxLb0E0R01TZjdN?=
 =?utf-8?B?cDAreHVjUGdXZXJuL0lNRktDbDkzb1p2OVd2bUNLbzlKcjd2bDh0ZlJuSnVC?=
 =?utf-8?B?aWRxcHV3S1VwV2lQRDVPa0tQVlhwZGJVSTNma3pTcGhiZU5IVDNyNWloU0pG?=
 =?utf-8?B?aUpzdnNYdEdvdUgxTUhKaCtpRzdvQkF1WWtnOUd0OEVLSzNhYlJGeUFZNVZY?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb7250f-d339-4674-5f9d-08dd812b8152
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 23:23:21.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ripJCubimyG2n/jeP3JkMFa0WzwU5bCiZb63x+2LAG1nh9AQ7zOD59ARe9mJFYwHNpHtSLbCBY2IoxaDiN12d+JvCaKYsqmquAwqxdk7mU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7901
X-OriginatorOrg: intel.com



On 4/21/2025 12:16 PM, Moon Yeounsu wrote:
> There are two paths that call `get_stats()`:
>     1. From user space via the `ip` command
>     2. From interrupt context via `rio_interrupt()`
> 
> Case 1 is synchronized by `rtnl_lock()`, so it is safe.
> However, the two cases above are not synchronized with each other.
> Therefore, `spin_lock` is needed to protect `get_stats()` as it can be
> preempted by an interrupt. In this context, `spin_lock_irq()` is required
> (using `spin_lock_bh()` may result in a deadlock).
> 
> While `spin_lock` protects `get_stats()`, it does not protect updates to
> `dev->stats.tx_errors` and `dev->stats.collisions`, which may be
> concurrently modified by the interrupt handler and user space.
> By using temporary variables in `np->tx_errors` and `np->collisions`,
> we can safely update `dev->stats` without additional locking.
> 
> Tested-on: D-Link DGE-550T Rev-A3
> Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
> ---
> Question:
> 	This might be a bit off-topic, but I don’t fully understand why a single global
> 	`rtnl_lock` is used for synchronization. While I may not be fully aware of the 
> 	design rationale, it seems somewhat suboptimal. I believe it could be improved.

Its been a long standing effort to reduce the use of RTNL lock, with a
lot of effort going into switching calls to use the per-netdev lock instead.

I think you could switch the driver over to the ops locked method by
setting the relevant flag in netdev to avoid global lock contention,
since 605ef7aec060 ("net: add option to request netdev instance lock")
which is coming in v6.15

Thanks,
Jake

> ---
>  drivers/net/ethernet/dlink/dl2k.c | 11 +++++++++--
>  drivers/net/ethernet/dlink/dl2k.h |  5 +++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
> index d0ea92607870..2d929a83e101 100644
> --- a/drivers/net/ethernet/dlink/dl2k.c
> +++ b/drivers/net/ethernet/dlink/dl2k.c
> @@ -865,7 +865,7 @@ tx_error (struct net_device *dev, int tx_status)
>  	frame_id = (tx_status & 0xffff0000);
>  	printk (KERN_ERR "%s: Transmit error, TxStatus %4.4x, FrameId %d.\n",
>  		dev->name, tx_status, frame_id);
> -	dev->stats.tx_errors++;
> +	np->tx_errors++;
>  	/* Ttransmit Underrun */
>  	if (tx_status & 0x10) {
>  		dev->stats.tx_fifo_errors++;
> @@ -904,7 +904,7 @@ tx_error (struct net_device *dev, int tx_status)
>  	}
>  	/* Maximum Collisions */
>  	if (tx_status & 0x08)
> -		dev->stats.collisions++;
> +		np->collisions++;
>  	/* Restart the Tx */
>  	dw32(MACCtrl, dr16(MACCtrl) | TxEnable);
>  }
> @@ -1074,6 +1074,7 @@ get_stats (struct net_device *dev)
>  #endif
>  	unsigned int stat_reg;
>  
> +	spin_lock_irq(&np->stats_lock);
>  	/* All statistics registers need to be acknowledged,
>  	   else statistic overflow could cause problems */
>  
> @@ -1085,6 +1086,7 @@ get_stats (struct net_device *dev)
>  	dev->stats.multicast = dr32(McstFramesRcvdOk);
>  	dev->stats.collisions += dr32(SingleColFrames)
>  			     +  dr32(MultiColFrames);
> +	dev->stats.collisions += np->collisions;
>  
>  	/* detailed tx errors */
>  	stat_reg = dr16(FramesAbortXSColls);
> @@ -1095,6 +1097,8 @@ get_stats (struct net_device *dev)
>  	dev->stats.tx_carrier_errors += stat_reg;
>  	dev->stats.tx_errors += stat_reg;
>  
> +	dev->stats.tx_errors += np->tx_errors;
> +
>  	/* Clear all other statistic register. */
>  	dr32(McstOctetXmtOk);
>  	dr16(BcstFramesXmtdOk);
> @@ -1123,6 +1127,9 @@ get_stats (struct net_device *dev)
>  	dr16(TCPCheckSumErrors);
>  	dr16(UDPCheckSumErrors);
>  	dr16(IPCheckSumErrors);
> +
> +	spin_unlock_irq(&np->stats_lock);
> +
>  	return &dev->stats;
>  }
>  
> diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
> index 195dc6cfd895..dc8755a69b73 100644
> --- a/drivers/net/ethernet/dlink/dl2k.h
> +++ b/drivers/net/ethernet/dlink/dl2k.h
> @@ -372,6 +372,8 @@ struct netdev_private {
>  	struct pci_dev *pdev;
>  	void __iomem *ioaddr;
>  	void __iomem *eeprom_addr;
> +	// To ensure synchronization when stats are updated.
> +	spinlock_t stats_lock;
>  	spinlock_t tx_lock;
>  	spinlock_t rx_lock;
>  	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
> @@ -401,6 +403,9 @@ struct netdev_private {
>  	u16 negotiate;		/* Negotiated media */
>  	int phy_addr;		/* PHY addresses. */
>  	u16 led_mode;		/* LED mode read from EEPROM (IP1000A only) */
> +
> +	u64 collisions;
> +	u64 tx_errors;
>  };

Code changes seem fine to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  
>  /* The station address location in the EEPROM. */


