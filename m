Return-Path: <netdev+bounces-177060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E334A6D8B5
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FA43B3E0D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FCC25D533;
	Mon, 24 Mar 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFG1YbsR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D517224EA
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813686; cv=fail; b=gkD6CNFHYIzcVPybVTH8UaLTrX0R0/VYmqzLSt5b7OgiC37ew9SLFRmPHbRhKjEze6BWiupzd5ULTkm7AOecoDo4vJ+4v7mqgw2MYgkzYn+N+8+SblCIs+n0dbCpBHzvJnnOCV+L02+ZnGDRezKazSNI6oUYh+S0BR/a14cU5PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813686; c=relaxed/simple;
	bh=h/jIGwcURN++tYN7GH3RsEjwf9qjYZh1ENw2ArmyiXU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CJrGZcB0KfmMdcNTMIRYMpMnhRCtAeFIiVtPagTH9cqywzOAH6jaESZFn97/QkmcW1bfXbAi+vDNCJvSmbqTTsgJatMK1WSR7d6xHFaZJH3LeMs4vzaX//N40iNUvNFOMfJZl722ongMR/8YfWaTySlD9dQw0gs4DK58sA8c8Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFG1YbsR; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742813681; x=1774349681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h/jIGwcURN++tYN7GH3RsEjwf9qjYZh1ENw2ArmyiXU=;
  b=nFG1YbsRPHmqQlaHsxejB7Wy2FyOYvchRWS6H8d2pXYCdEspOQw2tUAb
   58utWEdICVKAnCM81ybyMadavMQjMqtNL2MtPmpu9mIlojF6IDzlxfoDo
   wPlQQLm2fT9swOF9p/DmAT9jUNqU3fj/z/di+ZqWKrvRpCCficyFEqkty
   fHuoT1X2vQCMKvJqZbJ40NTpu0ogM8eqmPmyLlTJ8nWBfvOsCIhnmopfs
   Aav3ILYZPOk/+nl9105I/kH2b6za+kCh4sZ2CL/9/+UlhOHoRZTk+hC9+
   6KcmPkAA3Jv6taJJwqjFJe+uFdQuvKhN0mfI/JsnkQhdhTQWTMolgQWul
   g==;
X-CSE-ConnectionGUID: 47l8ykmRSWqY0zsnvYa3dw==
X-CSE-MsgGUID: Mdn7FbQtQNyC+2R34wL8cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="44120198"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="44120198"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:54:40 -0700
X-CSE-ConnectionGUID: BHvQNMd5TpWHpAuoQhS9kQ==
X-CSE-MsgGUID: Qb/L60UnQ3+osuFrjsGiNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="124175388"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Mar 2025 03:54:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Mar 2025 03:54:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 03:54:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 03:54:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4H2c2lYFino26DqvnWWZ13ijzW6r6kxkEfskhkjiRHkfyZdHDxd70q9VIsYTMX+M1ot1reaHbpcJHYw9EYkCHXRyzUSAXPOARznrjHpO1x1otZG/CvEcKvPmecFz84aJd3MqrM66h/K+99ZuXyJJ9skqjB+txky6QypjyLGh7OU4tdyIXGS80MkL0y2JleUmImWywUlqRlPJM54goS0Wli6JX9hFbHSBrTgBMmLl1YUiTbb3fg5w0zXHrI710SN8RihqveOW1mke5kXZCZvtE23RmVcypVMmuPqG5GxZelvE6VI+YM2BKGK1UWT4AOUAkmiWcKsRQ2kQ3Ph/ILedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NroBtHe9Lm8f88o/nTDI8zQ/edoZEPlf/G6bmGZWGPU=;
 b=bbRmzdfEez9B2X5jCtwDGAHG2diFEFDddSDrpBYnXzFZDgyYuWkUDvobMuXA18SlmVSyb3Dmu594Mv2gcses62+6amwtTfrvskS3M6Uv4LFds+z9QqEkfT59kJJIKH2JGkpABsqdH0rSawYcR1IqUSil7aPporpnVrgN/wGClCbjYvFghR/TZrM/D6dzz2x4COc9J+OgnQ86nFvPyTBYP+MPxUmhz2FWThNfje3SC1iIn0v2mJmXiUW+fPldd4F5+itzh+ajaV+rrZgrAcDy0yH8uHZIaxfZQfTYZw+uHtnMXA4HUJxsk47FgXpsL+ZfXtz7TPIOoA563CYbXINcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL1PR11MB6050.namprd11.prod.outlook.com (2603:10b6:208:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 10:54:06 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 10:54:05 +0000
Message-ID: <61e8fbbd-83d3-4838-9138-1ed6dfbb4b61@intel.com>
Date: Mon, 24 Mar 2025 11:54:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()
To: luoxuanqiang <xuanqiang.luo@linux.dev>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>
References: <20250321095200.1501370-1-xuanqiang.luo@linux.dev>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250321095200.1501370-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL1PR11MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7bf8bc-c21c-4e60-0590-08dd6ac23266
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGprOGY1NTNDMndpeHJYVzg2OWtkcjFKaEQxNEhyT1U1UjFkWHhXVGQwbEpv?=
 =?utf-8?B?c0tVamJzTTVuZ0w4Zk5kSkRaME56eUNGYW9IVTR2bG15TmxlWGs4NHk1anNn?=
 =?utf-8?B?VTVNSW1Hbm9xODRGcGpDcU9TaHF2NUpONG5WMDdIcVdDL2JQVkJjcVEzT05a?=
 =?utf-8?B?NlBlQVZzVXJ1Sm42Tkdnb2VRYkFrbjNLdXoreHI4RjJOTDNaNENGdVMyUVNJ?=
 =?utf-8?B?VFVJSFFXMlBNVWF3VkdxV3NVQ2s2eFF4Mm5ORGRld01KZENUUkk1WE9oU2VN?=
 =?utf-8?B?M05XRkYyd0FyQm1WTm1qRHN1QWNIREV3UUVpdjRwNjMwWStYSnpQSFFpNkFO?=
 =?utf-8?B?bGNUajNnTXdvTk1KRXNjVnFaSFlWQzNCZHVmejcxUlQwbVVncEFEcjA3c2M2?=
 =?utf-8?B?My9majBPaDFPb1RISU9sc2V5aXJWdE8weExsVTdpVEVQOTliRGhLNVc1WDI2?=
 =?utf-8?B?OVY3QlNRU2F3Vml6cUxIb3ppU2gxRmF1eFNBTWdFWUJZdURDTWtvOStPU0h1?=
 =?utf-8?B?VkhOcWF6OVJlajVTTGY2d2dkMVEvT2pickhaYVNNNEQ4bEdTOCtSUm1ZNkcr?=
 =?utf-8?B?WTIrU0tTWUc2UlFxaGVLTVliZDh3ZHFmeXg5d2ZyTXNWbG5uNDVDekhjN3dv?=
 =?utf-8?B?RWdUNDBJVHVjKzZ3S1pHMFd2SUI0UXRnbVFoOHpEUkZlRzk5VlZjUk5LdFhH?=
 =?utf-8?B?dnlaSzFUaG4yd3Y1cTE4cndRdHJ1TlRYMDk4YmpKcjlQTHpQd29oNHBLMjNa?=
 =?utf-8?B?c1FRRGx0UFpJcjFhZVNxNnhlOW5nNHMvRTFYZm1obk1sNlphaERlM01YVlRH?=
 =?utf-8?B?eG5zaGo1YmVFazc5eWJ6Sng4bW8rTkFCZlFTQ2tnTEJtMkRRLzR5UTZzeVVX?=
 =?utf-8?B?UG04bDk0cHRMOXVpbUNqMzY4K2h3aHd1Rlk3OGJuRW9ldkpvNE1mOTY2T0VO?=
 =?utf-8?B?bnpCUnBSeUVFNlU5RzV4dVZQeDRFa3M0SmZCakdab0xHNmFRMXY4SjNLYjN1?=
 =?utf-8?B?Y3d4cWN6QjlSZktSYXNvK2k0LzZDdHhnYkdhd00wR052TUdJc3RoS3VhbEVO?=
 =?utf-8?B?U0dPOUVSV3QwTjNvWFdubGc5Z1Nsc29mdE1IZDdYNXNud1RnbjlXYjVwKzdl?=
 =?utf-8?B?SnV0TmtxcEQ5QnBwR2JISkoxcXkrdXI2clB3SCt6R2pWRHpRejZGSmVXQnl6?=
 =?utf-8?B?WEFlWnArZWpaV21MRWp6cmVCTDkxc2MyaG9xU2VjbTNlQXY4YlVvOTgwNTVo?=
 =?utf-8?B?TS9PbG9lWW1Kc0tMKzY5S2dSM1hUT1Z3SDdqUTB3WkhSMWN4a0t0dTFUa090?=
 =?utf-8?B?MXpYNHRsSXJKQTdMbDRFYlM4SVRzb25DWm90VEVxNEJiMnRITm9QWHlLR2lm?=
 =?utf-8?B?VUF2U0ZtQmQwTERPRmxBVEFvMzlkZWd1ZkN1Wms5cTQrcy9XOWUwSnMwL1ox?=
 =?utf-8?B?cjl4NHYyVE9HTmZOZk0xTzJ4OTB4M1dTazB1Y1RkL1YzejdhVlByeGZDZ1Jh?=
 =?utf-8?B?eVErTnJlZTZnUmNQNzd4bVdZb2dyaVFpb3o4dTFVenI5R2tvcUFrZlFTT1Yw?=
 =?utf-8?B?aEdDTWEwL2hSSElqNUZ6YUppY2dUbnA3SUVsK1ptNHhmbXByaTEzN3RiUUxy?=
 =?utf-8?B?aXFMUndWL0dkbUt6ejdyNS9ReHFOSzQ3NUY4QjJYUGF4V1lOWUZ1VFVZV2JD?=
 =?utf-8?B?cCtVTlpvdU5jQUhIdko4aTRkaDJCVUdJZjZpVDQ5WnFFRHJYNk1wK1NuQk9F?=
 =?utf-8?B?TjN0TndZOEhPRWx0QzhWQ0xWekdZUFkrK2Y1T0dkVTZFSE9vZnZsR0FHQklx?=
 =?utf-8?B?dE5udlZ2aGRCSVc3WG85MDlYbURHak8wcEt5TmR0SG5GOE9ER1BsOUtiU2Q2?=
 =?utf-8?B?NEJweTRUUkdOaC81QS96SytBQ2kxRXVLTkptcXZXeVlYME9FTUdob1JzVWFH?=
 =?utf-8?Q?kf7AD6OxxMQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDVoZVNDNnVGZkRhc3BqNExkL0tUYi94eDJIcTlHRDZBUU0zS2NpZ0FldFJ4?=
 =?utf-8?B?VmNkSlZhb3ZOKzNGZVdPdjkvVlVrd2VNL0Rla0ViZng1bXd6S1lkYVoxVkpG?=
 =?utf-8?B?THZIbUxpNGFUdENBMG53MDBuS3h1cmZPVHlrZjVOUDJ2OGNzMFEwbXl4aXQr?=
 =?utf-8?B?MjlCSjJwWmI3eUtYWERUWXloWlgzZ1k1NkVWZHFNUkJCMm15OTI3NTZkRUZr?=
 =?utf-8?B?cXBxalMwVmdUNnlzU0RQU3FRZUhmbjRQNVFGM1l4V1lvVVo0aU1QSkNPemVv?=
 =?utf-8?B?T1lHSThQRHNUZkljVmZVcTd2ZnFsOHJtVEJadDVYRFF6emdlT2tpcGRHcndq?=
 =?utf-8?B?ZDZ2RFFnV1BoWmJ1UlRXWEUvZUVLU3llWmZ6VkR6UERBT0lzODNEZVYyVE5T?=
 =?utf-8?B?Mmp0UHJ2Nml0N2ltQitnM1U0VlRQMkloMzEycWdlWC9uOU9EcXZhT2hidVBo?=
 =?utf-8?B?VUt6VFViY09ieDJ4RWVtVm43RGNwYUZzTXVnZWgzRFBLMWZjdWo1cE5GUWZJ?=
 =?utf-8?B?djBiUzBiVWtxOVlaejVYV2QzdnFkN3FJSnVUUGg4UzhsNFZpNzFhWEJPaC9C?=
 =?utf-8?B?REJCYTBqOHpJWTNmcWJkUUhwUEx3VXFqNDFKcmQwUmZiVEVQdktnbTR2Z2E2?=
 =?utf-8?B?UWwzSlF6MHFkeHBXVnkwekdqTUIzNlErK0RNb1htZHRNMXVyTTdMaU0vZGxV?=
 =?utf-8?B?Q2IzSFJwVVdTOERuOHhvMFVFT015NnZwRWJvbDI2dWdnKzhyVUhpeWRsb1ov?=
 =?utf-8?B?c2c4eGd1cjU1WHp3MFVlTXpDWUJweDgxS2JXMkl0dmVFTmNucHArbHZlM1dL?=
 =?utf-8?B?L1hjNjBPcG91NEVSaFRoVmVNUTJKRjJrMEZSZURJRldsUTRGa2dZcThMdGJU?=
 =?utf-8?B?SElkb245NGwwKzMrTUFLbWxhNUNqSkpCUkNXbENzT0kvdlVIZkVFRDgxYmhz?=
 =?utf-8?B?TXIwcEl5NUIwNGNlNmJjWFhVNjJXSzBQZGdHb09IdkdINmhxbjc2SDJaMVVV?=
 =?utf-8?B?NG5LZENVL3J3dnMrNzlCdkRCV3RNSk9FQmQ2Rkkxb251WFh3LzlJbW5rdGRH?=
 =?utf-8?B?QVgyVHk0NXcrY1JIUkVYTjZCbTAyNEZJdm10djNjMjVNa0JqTExiclFESklY?=
 =?utf-8?B?N3hWVmlhOFJnSlBzcno4ck5UZmVJSitWNEgydEJJMGRXb01WRmc2YnU5N04r?=
 =?utf-8?B?NytRWWhmeTZZQmgwVlJQTmd2TEcrcjNHYU01bFhkZk9yTzBBcitqNlBmeWpN?=
 =?utf-8?B?OU10MEdJYlcxT3pxcDBsWXVNUkxXN25sMU9tbXQ1TlFoejJwTkVVcUVZT2pi?=
 =?utf-8?B?d1BQYlU0WmdqQXhlQS9ZRW9WZU14ay83VXJZWkhRWUNZeWFXTExNYWFPZStk?=
 =?utf-8?B?NWV3aG9wWEk5RktGcGV2ekt6eStlSTZYTXl5cmNpRGxFQnk0OTgwdHgyUCtU?=
 =?utf-8?B?VG1QNThQYjZjTXNwQ0JrLzlsWkRjM1g4YjVTQVk5RURYRk00WTl5UUwwVmRo?=
 =?utf-8?B?YXRTVUh2SWJ1aEgzUzBMcjZVV01OM2Y2bDYrSTZpemRZanhZVjNpanJHcHlH?=
 =?utf-8?B?TU9TcWR1aVpSMzZRcE9kNEZKbGMwU2RXOXJMU1gyY2NTVjVxWXFDc1V1Q205?=
 =?utf-8?B?SUg2a0tyOFpwWmdQcXZ6Ky90UWEyZ2paQ2hzZ0lDb3dZbkdDN3lmalBoRmxp?=
 =?utf-8?B?aUhWZGxGRytFMjQyZE9RbFd0a0FqR1kwRkVXR3JrQjhtcXY4TUFpWnBseHJD?=
 =?utf-8?B?VXR5NDBYN1VTSVAwa21sN2hjQjdwV25Od1JOTVM0OWQveFdTV0tzMWN5bUJP?=
 =?utf-8?B?OUxwS3JSOENkWWFheWZHSUlEbFVsY1hFaGpqN0RTalAvZmp4TUZIdFE4dE85?=
 =?utf-8?B?ejNsMzdpNjZzd0R3R0luaTVQR0NLbDBFV0cwcUxOUHNrQ2g5WHJ5ck9zUFkr?=
 =?utf-8?B?Wk9kSFo1TmN3d1luTzh0NzRianpicHB2Ykt3engvdG1OckFHTFBKSFlxVEtC?=
 =?utf-8?B?RlZIOHdqS282UVgwZ3pJVDRNUFZhMHBBZmFXOGVsYXJhVVVkTS9BM01QU0Vn?=
 =?utf-8?B?ZllmR1J4NXI4eFNqYWl6dE5LViszSGUxNThaeGIwVUNhdmdGRk9rdlQ4N05y?=
 =?utf-8?B?c0VvSC9nUWdUTy9obHFLRFhWdWhjellsMlVLNytRZXFXOHZQc2NqV2Njbjl6?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7bf8bc-c21c-4e60-0590-08dd6ac23266
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 10:54:05.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvMioVTUft5kAgNY7KobDB07wngeEnUW/r04PtVOpmVkqiHAH6T3K/99QrmfuQ8LbDOrDSvsgEH1gjaudOV5wPZ5pk7vj28WBYS1Hpe7iQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6050
X-OriginatorOrg: intel.com

On 3/21/25 10:52, luoxuanqiang wrote:
> From: luoxuanqiang <luoxuanqiang@kylinos.cn>
> 
> As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
> pointer values"), we need to perform a null pointer check on the return
> value of ice_get_vf_vsi() before using it.
> 
> Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR filters")
> Signed-off-by: luoxuanqiang <xuanqiang.luo@linux.dev>

Thank you for your patch, it looks good.
To apply it you have to provide us your name in the format:
Firstname Surname
(or similar, could include more than 2 words)

please also CC IWL mailing list (CC'd by me) to have faster feedback :)
would be best if you put [PATCH iwl-net v2] in the subject

> ---
>   drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> index 14e3f0f89c78..53bad68e3f38 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> @@ -2092,6 +2092,12 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
>   	dev = ice_pf_to_dev(pf);
>   	vf_vsi = ice_get_vf_vsi(vf);
>   
> +	if (!vf_vsi) {
> +		dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
> +		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
> +		goto err_exit;
> +	}
> +
>   #define ICE_VF_MAX_FDIR_FILTERS	128
>   	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
>   	    vf->fdir.fdir_fltr_cnt_total >= ICE_VF_MAX_FDIR_FILTERS) {


