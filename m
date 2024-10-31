Return-Path: <netdev+bounces-140666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01529B77A3
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 10:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CE61C22A25
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA67E197A8F;
	Thu, 31 Oct 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A88vGXNe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E9195FF1
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367337; cv=fail; b=lMSzfytPLO+NtxkE2G1o1nH6v4h1qsXpYYcVJVCmQ9dJPY5l/zhEGh+otINJ95Zk1RCNZeitregS/zP0SFDNwBp7qTQFVRJ1vz+60IxoVX9CpDgwpmVzrGRIpr28D1dPRdXaCYnCzdoGa76wz9SSTstIou+v8MErQFF7Fn9W91U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367337; c=relaxed/simple;
	bh=KJWi2+AYk1ZottG9AtpiP/MGtaX5UqV8grbJ+xm4zLs=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=kkqmJGt53ATm72tf+vunwQftgw0ETHYw278flpaywNMsQ/qj2HtBbYJQpEkaMWWWzfoTKNnU2nRsuZ3GsGF1eIbBntCijLdrMd/kh8ubeYfhvIE/059rgjONSP4uxeDBYHcnpqL4rrk3hGyNejpEltRl4Saq4lp5LiHzsgpieU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A88vGXNe; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730367335; x=1761903335;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KJWi2+AYk1ZottG9AtpiP/MGtaX5UqV8grbJ+xm4zLs=;
  b=A88vGXNeLEAAS2btL/mkD+vVLtqfmSitTKuYU8OZjFL7tYv1FG+FvNDO
   tmkYthbBwSe3SBe0tfy9CJ7C0e1ibO5RQD+n5Xp5XtKGDB19FnZSozdij
   qxyGob6M6cXoM+At2209Y60czNH0NqlE6GdKSpRdOt6mn82MfZbS4ZklB
   3twiB87PNQ25vxtJoI9Gugowe+3QGFD1XTwnxnIOmQYOG0hMutLUVBE9j
   JF0o5de1cxyKpaXk7q8SlUDtCBw/QhTkqUELiWV6MuyUeRtYi2q3FwlcR
   Ty7H+jJA3AvNTWYmF4/EZ/KTkyQHPvf2mUlLRQPrZ1lr2FxW2pUm/W661
   A==;
X-CSE-ConnectionGUID: 0EgP29X4QdulSvO2DLm7FA==
X-CSE-MsgGUID: rwCvpTyuTSySF9dnx74iKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="34026545"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="34026545"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:35:34 -0700
X-CSE-ConnectionGUID: 35P1pxY9SNi1ExRSkuRb4w==
X-CSE-MsgGUID: 2o+0tKCiQK2rT9za+viI7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82231974"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 02:35:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 02:35:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 02:35:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 02:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1L71U6zXOeK1TByBjV/POSBJes3csq3yQW5QQ6lfZ02c6hMu9YoTMhjzYvLP8Q4P73pqthclRI+qoeDO98bhip1v20V/2MokIC1jcnkmCOSBXWprUvg6ydWREbS3g8CLtIUKUPQyclXl7zJe9N6AZEILG6VDUpjySZ7RR4N2sv5FZpc57IUTG1sQId1OGXPkEPjXwg29AtCU80PjMjxKZWa7kQfNfaCz6KmA0s9A5SJ6Ui2n0G1c66C5g970RfAPWEIKNXuMysgj0IN25K5tPLpl8Z8/jA5FbZOMRlM/eClDSqQ2hN9STFnk8Wbn6vFAmZanRj8Z6KtYr97bFYxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuvmzHinx9C9Q14B96sh9ivuOADM01S21uaUs/9HHDM=;
 b=hwL69yH3ksMbBq65DnV5HvS9ToIdb6I1XwBP7i0FDe45W97KyFGVfOgqguNPMyhHvi3MzUIN8XfTUUu57p9dBVs6SElqLNALIlR4EEvcUuTmdbPQL/nE8z+ddBtNNCWh0s0E5IDLpqVLxGmVAJcrC/CtShaPKy7X0XIjtUC3TFtYCsD3QSUKo7jBtFXejoYgiqrMx8wq3I/2qL1wYsmRexrMi7rO6o+VuSJhezkQUVKGcii/AyfBFz5hQDmPK0JxUFr/S6rW7OXDfxgNHIFeTTplOVut/qBHz/DO77celAKcaew9leg5s+2TtzbwG3wOKcsqwhGwmfJTJrgyYlsIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4194.namprd11.prod.outlook.com (2603:10b6:a03:1c0::13)
 by SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 09:35:27 +0000
Received: from BY5PR11MB4194.namprd11.prod.outlook.com
 ([fe80::9d17:67a6:4f83:ef61]) by BY5PR11MB4194.namprd11.prod.outlook.com
 ([fe80::9d17:67a6:4f83:ef61%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 09:35:27 +0000
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 2/4] igc: Lengthen the
 hardware retry time to prevent timeouts
To: Chris H <christopher.s.hall@intel.com>, <intel-wired-lan@lists.osuosl.org>
CC: <david.zage@intel.com>, <vinicius.gomes@intel.com>,
	<netdev@vger.kernel.org>, <rodrigo.cadore@l-acoustics.com>,
	<vinschen@redhat.com>
References: <20241023023040.111429-1-christopher.s.hall@intel.com>
 <20241023023040.111429-3-christopher.s.hall@intel.com>
From: Avigail Dahan <Avigailx.dahan@intel.com>
Message-ID: <f009f059-f421-22f8-4541-ad10d4589efe@intel.com>
Date: Thu, 31 Oct 2024 11:35:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20241023023040.111429-3-christopher.s.hall@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To BY5PR11MB4194.namprd11.prod.outlook.com
 (2603:10b6:a03:1c0::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4194:EE_|SA1PR11MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: e15b4afb-6cf2-404e-0963-08dcf98f5a9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGc4K3IxVHRhUnFNR0k4cGRhNzRZeGhiR1VkbThGek9MNXR5bVkwbnN1NGp1?=
 =?utf-8?B?MzBBYVRNN0x6R2dMc3Jxa3h3aXN1YnFVOXVvdlllS1N4TE9pMWVXa1ZhaGR4?=
 =?utf-8?B?dzc1K1JUTGVmcHEwUHo1ZjFSK2xpQzBNK3QwRlZBSkk5TTNpSXRrcnVzWEhi?=
 =?utf-8?B?aXFMUEZSY0hrTzlXOVdkeGE2K3hWUWNGaE15WTkyTW1RaUFqcjcxWHRkKzNC?=
 =?utf-8?B?M0JreUpWVHlsUXJYUUNVTDE0alcvblRJdUh1dmlodzIzNGFwNkh3OWJHT3Zo?=
 =?utf-8?B?SG4xdnp6bS95QWtRK3Raek1JM215YVo2RjA1Z3UrK2NSTnFtK3ZYRmNLbXF2?=
 =?utf-8?B?NlR3S2pSMUhqa0JSZFRBWGpscTg4bmdGbW1XSlFqTGxCV3BvS3kvRElJU250?=
 =?utf-8?B?UUpFSVlBRHBkTGdwM0xhbytDTDg2bmo0KzBDd2xYQlNIeGhnYTRmbGZFMGlB?=
 =?utf-8?B?S1BXWkxJWnI5VlA1aTBVbzFnUUhwaWNPa01zNnMxMFBlZEMwTnRZNjFKc1VC?=
 =?utf-8?B?ZE1vczlsMDlkUlFHSlgzVVFZclZIYTZWYmFRay9SeXJMTDVtcVRuTGZSTXha?=
 =?utf-8?B?UXFLUWZoVXVwS1o3SnFpWkNQODlPVTJ3WUJ2QVF6UEFiYUc0aWFnV3FVOFcy?=
 =?utf-8?B?NytNZFkvZVAwVTlGeDZNRGc3M2NjT1lPTHNlZnU5TnhuQWpxUElEb2RnV2pa?=
 =?utf-8?B?bG5HclVYS1haSnlYZDRvMWY5dXllVEQ0LzRGUWdpU3NTNHc1Ni9IZzRZZXEr?=
 =?utf-8?B?b1E5Szk1Smg1VTNnSktLUk4vdzhaT09Gb3pNSWtHSWdGWTByTWZLbFdRUks0?=
 =?utf-8?B?UHZzM0xoU0x4OUJ2UU15WGx2eWxhRTJTeGF3cUFSTk9YZ091Ti9KUmJLcUpN?=
 =?utf-8?B?TGt1c0t2U0JGRkFXamFwZjg2WEwrajVNZ3pNeUU0dDNXWGxCbFZGYnlJOWd2?=
 =?utf-8?B?b0M0dmtJOXRTVWpEODNGY2hTZEF4NmxMd3VhTC9pTDFzTHo4REFRdzgzUmtv?=
 =?utf-8?B?UG1kVjdoRUt5emdRd2lFdGlqelErTjNSalg2SDUvZG1ITEtYMTQ0TnVTTm1x?=
 =?utf-8?B?L2h1YzJYRFlabkEvRzE2UVJUUXVNUU1hazJhNWNseHoyZU1SdDZvcXg5ZzNj?=
 =?utf-8?B?Q1ZQc2FrWXhsWXRzV3ZTS0l1YjVEQjNEVURlZ0lGK2hKOEpibzQyRGpadEhk?=
 =?utf-8?B?T0dJRUR5blVIRG9URXQ4Y3RyYVJzVUtYV3ZETkZzUWR0ZXlNbG9Cc1JXd0hp?=
 =?utf-8?B?M1pncFh1TDNlQytEblRCd2M3Vm9JdlA1dFArRDcyR3NIMTc1RVhXRzI0Sjlk?=
 =?utf-8?B?UzJOWXJoNUlaQUhzQjZwZU9aYWJ0VHYvNXpITE5yakdpc0R4M1FHK1VXV2RL?=
 =?utf-8?B?YjlQK2R4N0NUSXYyUytZcVlic3FKVW1FNi9pNzBwV1RZZU1OU0ZOS1VxL0Fl?=
 =?utf-8?B?V2FMNFFTSVZGMGkwTFl0c2ZLcXVrR0hpQ0dRMDJMUndSSmlEaXF5ZjVrZkNF?=
 =?utf-8?B?dlZpS3BKdnZFWENTT1pzb25YeUh1Z3F0M3B1Q3ZiczdjWnAremFheGNtY1Bo?=
 =?utf-8?B?Uy85TG0za1hka2RqN0V6TFg4VC9iaThiV2h2RWR6Ri9sWWZncUJqQSsxSGVl?=
 =?utf-8?B?eUx0bHp5MEZYdUthTDFpc0ZlTmRoVHZJeGwyOUhEcEpHTjF3SWx1ZVVxOUt5?=
 =?utf-8?B?Y2x5REpUTEkxejFFNUtacFpKaVlYWFRMR1hDczNzKzBDcDQrcitUa0pJdEFs?=
 =?utf-8?Q?QI634OFlwfXsTpc55/PsjPZjKFOMGrDhYxbaihb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4194.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEUrSjlWa01QRGxyTW5DeEhKYTZ0SkxPNGo0aDRtZFlwcUZ3ZWhrZ3UxV1Jy?=
 =?utf-8?B?R3VFbkpmSHVHZnNVdnFxUkw5dnZsMGduWVZ2YXJqNEI2bWFpdk9LLy9iblBX?=
 =?utf-8?B?NFRSR21ndktXbFNiWWY0U3kwWnF0bDY0c3R5WFF6eUNWSTBnUHEzQUxaRWVS?=
 =?utf-8?B?ck1reEdHYjVIcFNUR1VGUWZFT214SlhXMXJLeitnSitSYWVObWJMcHJ0ZlJN?=
 =?utf-8?B?Z1ZZVW95aXNOMEJhNS9JSERaRjNnZHNyblNGaERkeFNnRC9YSzFRSmsxUldo?=
 =?utf-8?B?S3NOS0pJMk5JdGMwdWhYM1RhNU5qaktyTHVBamM5ZzRBcndXSjJSbDVhQUx3?=
 =?utf-8?B?Rk5LZmU5ZytBcUt0c2xkYnBPKzV3N1hLZlc2Vnp2OGQ0aDRaczhEdG9JQ1Yv?=
 =?utf-8?B?YVR2VUhZTXd0WmNmbDBFdGsvQ3RaNEpaakUxaGhlVFRQWnp4MDJJR29ZZkx6?=
 =?utf-8?B?SjZvRUhTc1JISW16OHV6aXBibnBadWxsREhpSFF2QktHSmdpK3dWOFV2WDd0?=
 =?utf-8?B?OXM5NTVOM3lMZ0NWUWMyOHdVTnh1TE8zcjRiUE83S1pxNkNGZElhKzJKZzZk?=
 =?utf-8?B?NTFiTEFtOUMzd2hST0R4S2NOUTZCQXZ4L210c2RjQVh6NFFWVWdvK0FlamRP?=
 =?utf-8?B?dENmM1ZQUEhySXZvMWtOTVlmejFRZGV1YUpQY3NyT2xRc3BSNDVpYTNyQWZ2?=
 =?utf-8?B?cUZ6dVNvNWEzSHk4V3NCVXNhdURDaVk2RGJ3N3ZHaXpnaXFEazdhdkx4MlND?=
 =?utf-8?B?cTlhUXpJSndVVjVsQVl2ajVtR1ZITHVrdEFzRHA1UXRlTTluSXpNVTNJajdH?=
 =?utf-8?B?ellLdlZJNHZZREx1TUVUVldoZEFLMUNxbDR3SXZUR2pQYUlHSE9odFIrVzU5?=
 =?utf-8?B?dWk0TjcraG5JWlArU200MmFud2trN0pjcEx3T3ExcUxxNjBGQ2dJN3NrSldV?=
 =?utf-8?B?YVF4cUVFUWNSNEF5WTNKeDVEQ2xxdHdkVllDeDFIWjc5TzJESm5zMGV2WW1i?=
 =?utf-8?B?ZmJsa1d2TlE1Z0Jxd0VBSHNWK3p6YVlNWjhkUHJMK1hvclY0cnBSNVVWR2Zo?=
 =?utf-8?B?SjRPK05nODJzU0xIa2tjWUY5eGwxZEJ4VHFFcG1NMUF0M3J2bThTeDIyWldF?=
 =?utf-8?B?M1E2U3ozRDcrdjB4RDV0QjhETi9JcEtoU1JEZzBlc2RSRmRRamFoOXBxZFo3?=
 =?utf-8?B?TFUyekh2UDFlemNBMnU1UHExeWZ6YU5MM2hTclpsWmpoUythUTZzUXNQYWJt?=
 =?utf-8?B?b25ES0dlaVMzZTRxVHA0a2EwM1g1WVFsZU1UbGhVbUkyN1F2OFNtNytLc1FH?=
 =?utf-8?B?VklXMUh3SGtvUnlBSzBKdzNxTEh1Z01kcng0aVlqaWVTcVdxY2k5bjBFREIz?=
 =?utf-8?B?Skc5dExpZnFlci9GS3REWWhxUG5BQVlRTmhuMllLYWlVcVpFbzI4NE9xeVlH?=
 =?utf-8?B?YndaSHZzRVNnOEpKZlJDRnMybEVTM2R6RnM5RGRsZk9lUXNaYzYrVVBVVDBt?=
 =?utf-8?B?YlRvY1VVRWZaMWFhRjI2MUtiSHJzYko5QXVpeWlBd2pjOVJ5RFQ5QXJ4MlRh?=
 =?utf-8?B?MTdPM1hPTXRZMk10Zis3aU9jM3l1U1NjQWplWVl0S01vTThnT3RqY2lLeDA0?=
 =?utf-8?B?emFNMjRyRmEwaU9nbHhoTXRjUkszUVhtN3ZMRTFUOWxXemJ3S3A2YTJ4Q0Qz?=
 =?utf-8?B?QWgxQi91dE42NU9OSHRGQlRxZXBENkJxNnY3N3piMXlmd3cvVG11SVNzZ0xt?=
 =?utf-8?B?Y01GZVlBajM5SWdwcjQ3eGd3aXFqeG9JdFFBWU5mcjd1cU15RnFiaW1USHJB?=
 =?utf-8?B?eFc3SVl6WktmdUVUQ0FIRS94WDFTZ0duYm5oQkY2Wjc2MDhrcVpEYjZoa2dG?=
 =?utf-8?B?aFRFUHJDNm0rRzE1MjBmdm5QRHU1MWNNbEdDS20vbDlJaTlQVlVEalYvQ2R3?=
 =?utf-8?B?TS9FOGdvQVNRcUNQSGx3OVdIUDVCR3NWN1ZJR0RJYmVrRDFEUHdMVjBaN2dn?=
 =?utf-8?B?K2E4dHA4Uys2VlNxb3BTWCsyOFVhQW9sZXMwRUg0YzBYTmdqdUpGMjdoOGVF?=
 =?utf-8?B?WW81SUhnTUlaZDVJczZFVDdaS2ErbFpjZ0VKdVAzRXh2STV5SzdvYkRvU3Bp?=
 =?utf-8?B?alJCUko4T3g4VmI2QmJuNzhabUJueWhuMmVFWTdNVEkwa252R1VXZ3VPcjV2?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e15b4afb-6cf2-404e-0963-08dcf98f5a9e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4194.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:35:27.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/OsSUosm7GljN9NPFElXsHsbnfhqyiOhu7ONsltTKcmqNpXYTWHxKB/lbqqtrK/xZJffyHDE0nJ0uKTqrPdhaOLd6kdqd9CaqH6nc0Yd2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5825
X-OriginatorOrg: intel.com



On 23/10/2024 5:30, Chris H wrote:
> From: Christopher S M Hall <christopher.s.hall@intel.com>
> 
> Lengthen the hardware retry timer to four microseconds.
> 
> The i225/i226 hardware retries if it receives an inappropriate response
> from the upstream device. If the device retries too quickly, the root
> port does not respond.
> 
> The issue can be reproduced with the following:
> 
> $ sudo phc2sys -R 1000 -O 0 -i tsn0 -m
> 
> Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
> quickly reproduce the issue.
> 
> PHC2SYS exits with:
> 
> "ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
>    fails
> 
> Fixes: 6b8aa753a9f9 ("igc: Decrease PTM short interval from 10 us to 1 us")
> Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

