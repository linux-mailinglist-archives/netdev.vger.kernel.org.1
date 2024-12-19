Return-Path: <netdev+bounces-153418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8939F7E5C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2487188DF78
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80A225A37;
	Thu, 19 Dec 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T59nczg/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8B3225A47
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623368; cv=fail; b=StDYjcUWNp/ex8LYPWMsrW9qocLDt2iKOjpS/OLI1NX3rfnND14z0vbiMzYq9uKfvsHDetwaxboPnpCRqhhl6d1HHmd5elaA2Jk0qu2mXq8CtyEQ304GWHCeP2Y0scoqIFWyfXh6Krxz0wDFqXXSPusQDZe8q9nW6HmhnTJ74wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623368; c=relaxed/simple;
	bh=y7nMTunuDNxDH+liTtPibXaKtmBfZFVNauMPccQm4Qs=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cfnm1GuptWIOo5k5L+Gze4jiTG+vjmvLtZG5TahQ6Yw1gl+GIi/tQDfrZ7VFbI8wJFUCbAhgWg7FDUwrsEUDwtaoy/jhwGtA6agwcqWDgfNecTgzC93+uCyd2+KHt9fsI9OOSwVbJoUhnY9jSXqhXt7dRku8PKEOawWRwbNYGQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T59nczg/; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734623367; x=1766159367;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y7nMTunuDNxDH+liTtPibXaKtmBfZFVNauMPccQm4Qs=;
  b=T59nczg/dGq3xp4QaJbsGhjmNJP7qVLNC1BSIaSs8WHDUrTDejylGiwt
   AFQ6ijR6U2GTQThLuLZr6E7wTdu3fXomrz2D1gHIaBpW+TfE/dV4h+Mfa
   RbVzRVgHS76xuNczS6gMSCiE0lhPZXYNZ4o4sYqM1LfDw+5P6nPPnq35A
   et1GtKPO5d1TfaZJGFwkiC4NcU0I4Ptn0nNIxqlzNIhi6gLvVG+7lyQhV
   Wet8WRxi+oMA22hiIxZM2QZ5OXs7hyFZSD9+PikIH/zZ3pfLMLH4vEeuY
   dgp3k6nPckfqmNqk2SJJ1VxG7TLVPNQ6qSNlGGVoLch5HMcMUdka9Deyf
   g==;
X-CSE-ConnectionGUID: dbdumvzwRbCHdW2p1izyiA==
X-CSE-MsgGUID: LW1swW/YR5GKmu2mul2YOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="39078790"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="39078790"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 07:49:22 -0800
X-CSE-ConnectionGUID: ZKx502ydRSK9vk0FrPX/jw==
X-CSE-MsgGUID: qCaAXba0R2e7LyG8g6q5ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="98763301"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 07:49:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 07:49:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 07:49:20 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 07:49:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx0blqLYn+xEdenKC6P8cNXGOHVgvPUEjZgDygfTM9dIUmNptvSPGjIr0tK9QWlppcrfl5pLd/83zhVmVUfu6PVPAb+LP5CXQhDdBGBUTa8k179oEHWkFtIf7qaIxxELMBMHkSlXR300GiRYhu0Hn/ej/hZ6TOakDYPalw9FMU2hcqetyUCtIyanX/s0Kt1YI5rCyRnCuM2ty49x5FOIrArmqUx2Tf1S9DIuSXNDUqLx8oMI+apoLDJB5h6o3TFGqyFHxmV+fB6jM66s2QK7d2KKS1AaVdIjDN7iXJsj41NzZ+Vuo2bOPwRswv4WIqdlNJehal8pD9fwn5p/krHsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCQvqrvWntGNyA6gQVmjNoFytQ9uj/Dh7uCWPODMieI=;
 b=Fkzci/me2bQaCB95jvmF0/zZkQCYAs2mEh+ZO6f13zS5Xv23mdgC8YJqNgN1MQ7S5Iu2hmnJ4pZgoDiv/tnD76G+MzeOe31qV2nQ6AO9NkiOv8Dz2mv35kgAGFuYMPCPVHucjdIc9RzLADqCmq3fAZrY2TTOnMBPCcyL20MNfO04CnV28FJMfqyzgmKRRXedVWXoU5T5PRdtV9hfhKYXrrWAqkZs5zkqOtuY1U2ArznV97yMh4NTR5hf+kyn2Rw55bNTnAcvU94NFXigNGb2uJLyBFoH3uYx/sFV9EKZUA6eTZvpMDXUEFJwdsF733jD9Fv6t/mwG7sR29BX4Ds9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7818.namprd11.prod.outlook.com (2603:10b6:610:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 15:49:18 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 15:49:18 +0000
Message-ID: <633062bb-5c70-409d-a55b-5785294d59da@intel.com>
Date: Thu, 19 Dec 2024 16:49:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] ice: Add correct PHY lane assignment
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
CC: Karol Kolacinski <karol.kolacinski@intel.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>, Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
References: <20241206193542.4121545-1-anthony.l.nguyen@intel.com>
 <20241206193542.4121545-5-anthony.l.nguyen@intel.com>
 <04a216d1-6952-40f0-b7d0-f9d8b4f5a866@redhat.com>
 <a7b0cf34-4445-40cf-9a8a-b3c24be08fc9@intel.com>
Content-Language: en-US
In-Reply-To: <a7b0cf34-4445-40cf-9a8a-b3c24be08fc9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac965b8-c713-42ba-6cf3-08dd2044b282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWR4empCTGFKcHFDMDVPM3cvcmJGR1BDTnpRT3d0cTBsU3BiRm1qSDdKbFYv?=
 =?utf-8?B?M1hNendKUllzTFF4cGFtWmlGZVQ3RTFEWFBMRWJtRTZmSTJseU1wK3djRXpM?=
 =?utf-8?B?RzJZamNxNE0xeVUwTUpPRnVCKzdpN1pMc21vcDluR0c4aHhZV29xMjUxZld2?=
 =?utf-8?B?QWZIWEVJZ1ZMYm1UT21za3N6WjRlOHJwMFVnSEV5TnQra2lQTmZKd1dWUjJ2?=
 =?utf-8?B?cXBGanVaenhDcHZwV1BDL1R0NGlWK0lFOXBpaHQxL0s3cGJoZCtHMis2bGpK?=
 =?utf-8?B?NWkxT01vWnVuTDRrZExXYko1TUlHQ3kwb0I4SXdoa0tmcVBqb01UNkliem9G?=
 =?utf-8?B?aUtIcWFSRTBvUDNjNGdidDVydUd2dC94V0FjMmxSWVVFV2s4Uk4rczIwRTha?=
 =?utf-8?B?UHo2a2JlZEErMFdHMEJnendaQjcrLy9lN0tyZ0Z0bTdTQjBJOHJMVG5PQ2ZS?=
 =?utf-8?B?QWppYnVpM01VdHJ5ODhybmFZQTZWcHJ5VXJ0cWFlNENmcHdsd0xEVmt3dC9v?=
 =?utf-8?B?UkR2bmxnZDBXQjlHcTdDT0lIVlVjM1RGYmpnVis2RzZFOFZnQkZkNVdGY3VR?=
 =?utf-8?B?S1FjVi9VK1lqVVBqL20venFqYXVqRVlpY1Q5VGZET085ME14L2ZTR3lacWZx?=
 =?utf-8?B?OEJ5NGc0a2l5L0V1WXNOWS9yTEp5WVp5VDB3aHgveS9RZWlxNW1JMG9ETWgx?=
 =?utf-8?B?Y240dW5MclZ6QlQxOFpuclpPWWJCOWRpZjZ4OGZOMmlqa3JPNXFSMjdVN3ND?=
 =?utf-8?B?Nm1WWFNZN1FnUUorVFlCcXJTbU5NeDRLTVhxS1doWm40eXdxY0NZZnh3V29p?=
 =?utf-8?B?enUvclFHYUxNV0o1Y2o2SWlLUEppMlpjZ3pkR25neDQwbWpZNzNtSnl5T1g0?=
 =?utf-8?B?d1JZTGtpNHB3bnZyZU0zbWlrZFh4eG8wNkVPOTYzSy9TNGRDaVZlNUtVWVJE?=
 =?utf-8?B?TWprRldPcTh6UXpMUVpyeDMwVjI3dm93aG00QWh6UG5OcmVBOStZbWJEYmhm?=
 =?utf-8?B?MER5TDVLZ3RZeExDNjB3NGl3bHo4elM3dGJ4RzFhQXRuTkVOcytmcTZpeTJl?=
 =?utf-8?B?UVRlOFp6WSttdmFwRDZsaFJoUm9tK0xRbWwzN0hFNlZFZmJoN2pLUyt6Q1hK?=
 =?utf-8?B?SzRXdmIzMld1dldLT3h6MXRpT244WTNJT0JwQzNTdXNuem5LR2FmTVZES29X?=
 =?utf-8?B?UWVOU29iRG53RndQa0xzNnNJaEcveXFZVmY2QXQ3NzBOZ3oyTXZMQXN2YWpq?=
 =?utf-8?B?MkRZNEFjM0dtWWE1NEoxbUhPWWNMZ1FqelQ4TndIUkJiNkgxU2JoNFlJR1dG?=
 =?utf-8?B?V3Y3SkRqWmFNTFhOc3JkRUxCK2E4QlU0VUNvOXk4Z0sxQkViRzNYeDRGaUwz?=
 =?utf-8?B?dC80bjcrQXptejgzTDJ3WnBXcVJVOWdIaFdwQ1ZuYUR2ekNKNXpTMGFHWVJL?=
 =?utf-8?B?ck5ZTW5nQWpSTEdvWHFaUVlEbWlIbTRoNGxFRkptcWhDY3dWSjdNaFFUUFpY?=
 =?utf-8?B?d3lFbHpBYVAzYlFmaEdza3ZCY21RZnRyRHJRREliZEJlK0MvbEV5K29MdS9l?=
 =?utf-8?B?VkVoNmM1aDF4SkF2WTdGNW12Ymp4UkZOOTR0REZkT09IL0pUUnBvSWRBK1B5?=
 =?utf-8?B?d2RyWnFBZTBKYXE4VzdFMEt0eDlrYVY1NjlCU3VDT2psMERhWjIyNURVVkVl?=
 =?utf-8?B?VzFnaXFsUkg4ZXZ4amZub1dCTFlINm9RVldWVXh4N0g1RDQxNy8rbzdaQnc3?=
 =?utf-8?B?Q3hIM3RyOGhtdXQ2OHJ4WWZQTVNjcDBNNXRKbGlzVDdEL2NONkU5TnlOaDYw?=
 =?utf-8?B?MzJ6b1dDdFFOelI3c2EzQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTAwQVRkQ25DMGdwYTdCQUxvTy8xN1dma1Z5ckM5Q041dzhiZ0pjVDlhbS9l?=
 =?utf-8?B?L3ltS2dOU3dxY1lZVkR3TjFvdEh5RVc1VEg5RDN3TWlvZFlFTXNGUGlOeDNy?=
 =?utf-8?B?WURGbjRURm5ObHhzNlJXak0vZUtmUVUrU2hKZzNZVklDZWExc3BueFNaZHA0?=
 =?utf-8?B?bWpCTVgwV3AzNWd5T0VEai94dURGWWZhSHVQU0RxWG4zWTZ1TTZrNzhlc2Rx?=
 =?utf-8?B?WkQyNnJacCtOZzdoVTNqYVBvS210K3BlMkFKOHhEenNXdEYxT1JqSUFnMmZl?=
 =?utf-8?B?QkZyRldzaVlTdXF2bytXNVhQQitVVUxMdU1SVks1aVNZcFlwVjhrN1BQdDA2?=
 =?utf-8?B?NEhVSW1BMFFYNnExQjhUQ0NVY05jYnZJR3hYLzRIOTdERlNKdWdRcUNhR2JD?=
 =?utf-8?B?aHdlTFVhNWpkemJNN1dQYzFLckRmMFFmZmwzbjVaMDJpQS8zUVR0OEMxWFBD?=
 =?utf-8?B?WHZtUkVFQ3ZCQWpCY0RXSFRTL1UvWGZ6Yk5pQzM1NVBHRi9WQ29NQ2Q3MUx0?=
 =?utf-8?B?dWJPU2dCcmZzUHVGSFZQNXl6ZzMrODdTR2l6VE54aGQ0OUNiWjBZSlJtK1ky?=
 =?utf-8?B?NU1rMlVrdVZaZ3BWL0gwenlxbFFYTVc2WjQ0ZWJyNHJJTGd6UXZTN1FYY0Mv?=
 =?utf-8?B?SXg2RDZSNXh3ME9kK2djY0NsVmFFUGRKcUNqdVoxRWM1ZzlESGhFaWl4bG9O?=
 =?utf-8?B?T3dPem1zNHRNNWZVYk5EcW95Q01xT0hpRnNKalNrMWYzSUQ4aXVZek0vRjlW?=
 =?utf-8?B?M2lRUFRjRWd5MmZhN3Z6aDdudDZ1TmdhMXlSb2NSZFc5eVZJbWM5VHlOWXlK?=
 =?utf-8?B?bzdHcGtmSUNLNFhGMkhnWSs2QjUxdHhDWmVCZFFUNmkrdGdsSFNCTlNLOVVU?=
 =?utf-8?B?MHpPMjdmZVRKTFNLdTVGWVNDakYwY2c0aVJCWWpGUUJHUGJOL3laZ3h6VjNM?=
 =?utf-8?B?SlMybFdkWXp4VFBqTXRncWNCM2x6MTV3THBqM2pFVVkwQ081NWVEOU1CWHh4?=
 =?utf-8?B?N1kwMTJrR3FYYkE0UmkwdVpQUGtzM2RQTHMremdhazB0RkQyZ3VMYWV0bU9k?=
 =?utf-8?B?UVRPREl6ckpPYUMvMFpVM01XQll1cWY1d0Z3S1llaG9mb2RvV0lVK1NTaG1R?=
 =?utf-8?B?S1ZyYXVkSm9oR0wxbGw4RHlLSmlKNmN5SGVFYThVNENDYTlrTjhrRytxa043?=
 =?utf-8?B?ZCt0SVJLa0FoSTRMMk5Oem52N0prQi9maEdRbllLSG1OVVRyUHdReFV0cVBE?=
 =?utf-8?B?UHg4SEJMZTdjQVRaT3h6eSt6cUxVREJVdVVnV095a0VZK21XSy9CRnltQkth?=
 =?utf-8?B?cm1KaGp4MlExM0ZrQTFRcEMrQzlmMWRDOVEzWE5NZXBza2M5cGdiRmc4THcr?=
 =?utf-8?B?dmRzdGhoWnFlRVBEOEsyVmZvYjdVVzh5YitlZ0tNSVNPdzljTVlrSzd1R0lZ?=
 =?utf-8?B?SndlbGxmVnU1Z0NGUkN4YWduZi9rM3FHSllrU3dZWWQvTUtqVlVMaDZxOUp1?=
 =?utf-8?B?Zm82N0U3V0RDVWJGaE5wbzdKb005ZitoRlRBTGk3dmZXWmc2RHA5Qi9CbzhK?=
 =?utf-8?B?ZzBJK2hsU29rT016Z3hsdlV4ZENONVdPdWd0U0FoN0xFV2FQbmI4d1RSUUJF?=
 =?utf-8?B?aTQwZ2NCU29FdE9kNzJBV1FocjZLOWw2R2pJcHJUOUpkaUxWWFgrS2JZTjFr?=
 =?utf-8?B?OUdZTENWZHNjaHVoSUlWTjAwYmJrZ1lTMXp1L3hTdXdtamhHT1lETTQ0U0dE?=
 =?utf-8?B?N2pFN1pER0R4ditMODRkSGQrb2JoVHU4S0lxek5BbFVwUlpIOXJZM2l6ZFRE?=
 =?utf-8?B?RWNZaHFCWEprOGtyNU5RRGNPTUNHMUlLNXdBZG83OEtYYTdTb095NUJreU9o?=
 =?utf-8?B?dWlTdGZ3YWxsQ1dTNGltOU81QURKRmxCelpDRUdTWXNEWmkxRThybVZVZitw?=
 =?utf-8?B?VzFXUkN4R0l6UXdkSVh0cHdqa0o1T2NRQ29JN2xaZlNVVFZJVUwwTWpFT2pr?=
 =?utf-8?B?ekJjZ2tBL2RyK290NFJXME1EeUE4YysyT3lTRnBUWWsySEtyZmZwanhEZTlH?=
 =?utf-8?B?eDhsMHBkbEI5aG5jNzk5UXBCZ1ZjUHRFZVhkWDJGNlRlYkhqVzZRVkt1NXlS?=
 =?utf-8?B?UWMwN2FmbFJYblVaYjUyQkVrZmYvSzRqWUpNbktvRU1qQTNVUGxEbFc5eDhx?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac965b8-c713-42ba-6cf3-08dd2044b282
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:49:18.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +doK7PYvIAqugQb0Kpkrtyl1xiWFyBPEbz7PCVYAVoaQvl5zLLaf2upTNt1wJ0ZB0qHO3X/RkLbDSfArA+fk/QNaJF2j2TYykA/dOU0FOvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7818
X-OriginatorOrg: intel.com

On 12/11/24 11:36, Przemek Kitszel wrote:
> On 12/10/24 15:54, Paolo Abeni wrote:
>> On 12/6/24 20:35, Tony Nguyen wrote:
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/ 
>>> net/ethernet/intel/ice/ice_common.c
>>> index 496d86cbd13f..ab25ccd7e8ec 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_common.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
>>> @@ -4095,6 +4095,51 @@ ice_aq_set_port_option(struct ice_hw *hw, u8 
>>> lport, u8 lport_valid,
>>>       return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
>>>   }
>>> +/**
>>> + * ice_get_phy_lane_number - Get PHY lane number for current adapter
>>> + * @hw: pointer to the hw struct
>>> + *
>>> + * Return: PHY lane number on success, negative error code otherwise.
>>> + */
>>> +int ice_get_phy_lane_number(struct ice_hw *hw)
>>> +{
>>> +    struct ice_aqc_get_port_options_elem *options __free(kfree);
>>
>> Please avoid the __free() construct:
>>
>> https://elixir.bootlin.com/linux/v6.13-rc2/source/Documentation/ 
>> process/maintainer-netdev.rst#L393
> 
> My understanding was that conversions to __free() (w/o any other reason)
> are bad. But for new code, it's fine. I get the "discourage" part from
> the doc, as "don't use __free() by default, for all pointers, or all
> allocations, but apply your judgement and sanity to tell if that makes
> given function better".
> I still believe that this function is better with __free(). We develop
> (new code) with such assumptions for the better part of the year.
> 
> I think that static analysis tools/Reviewers already got used to that
> (after the first false-positive memleak reported). Developers (and
> Reviewers for sure) know that those pointers could not be left
> uninitialized at function return. The only concern that is unresolved
> for me yet, is: "there is a lot of characters to type", but that is also
> good in some way, as one needs bigger function to justify the added
> "complexity".
> 
>>
>> Thanks,
>>
>> Paolo
>>
> 

Paolo, could you please revisit this? In short I propose: let the 
developer and reviewers to decide if __free() makes given code
better, instead of an umbrella "just no" statement.

I believe that Jiri would be happy too, to back it up as another
HW Vendor.
https://lore.kernel.org/lkml/ZfW9lVhnClqr9Han@nanopsycho/T/


