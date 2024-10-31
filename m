Return-Path: <netdev+bounces-140638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D29B7571
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308D91C24C5B
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30EF149E0E;
	Thu, 31 Oct 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBQrJNFO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1C14830F
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360098; cv=fail; b=T09/8MUAVvYlusAbJTdCDw/b1BuKFsOLJM+RYkSRZT7hs/xe2wTWPzWIlImbxSsSZLB2eVNA+w1yp0US3FzvRiZcw5G/sv+zLIareZGq1dYwMEeWaEd20p2/V4MLULvbHmo8LMzGzfl+MNpt9N7egyCvqfoG7bWtQldTCmXzttc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360098; c=relaxed/simple;
	bh=vMmd/KBnUG/AyV2JADjHGN8+HDZDKk6VtRpDY7Uq6kk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XA8IKUCY8uxQGd1nXVHv5USCZCxZhGXUhkU/cHseQPIp+RX/54uOfuNG4tZ4kXHtcgKUQ6WlQx0lWpsiOf3aImBWB54l5bXaadB35HmrSvWcR23ys7PduAEzMp57XdDjYsv09B/uLOKIvo2OC85olge0zLLqPANgr0ZSVHuR5+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBQrJNFO; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730360096; x=1761896096;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vMmd/KBnUG/AyV2JADjHGN8+HDZDKk6VtRpDY7Uq6kk=;
  b=oBQrJNFOM2IRnZORz4A0iQPVnwcIr7L6PQN0MHpXQES42GRsPe7oCGtI
   wzalBSgJm/FP5xwL05ANaB887DYDRbi18BuXj4/aOzL0lZWvwIltS+fNG
   6tDy85zQ005UHR6PrqLw6ldOI/PDGlTc3A5bgam4WTTB2nJgg7M8BqatF
   tApvkBa7QBYeRHqLCiBu3iYu/23agmlI/45U7ZbMBwGRn0R8IF0fYUjlb
   coEkPBTjOFapQiOidF5eLXuq7ILvmbbme5HNEHiRIK5xJ16clPt0WqzYQ
   oktR4Is06JmOENhFYq21iHesIqUMlALZMkXVUQ0597Fr+lpI7ylmdi8eP
   w==;
X-CSE-ConnectionGUID: XMeAkxgDSkGGJ/B41JJ8mw==
X-CSE-MsgGUID: WFRCxaJgRTuWYlzAyiDi9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="32921436"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="32921436"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 00:34:55 -0700
X-CSE-ConnectionGUID: JIqhh8k6RDaLcZgavXq59Q==
X-CSE-MsgGUID: UsEu3N3FT1mzqIO95HOCKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87099092"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 00:34:55 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 00:34:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 00:34:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 00:34:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOXinwDkLDZdo0D+lUn5/TuZ5ErbOPJCEDbUt5RnFU85bxARLtLua5MMllTorXKNY8qoy2P0mM3Xns6Ie7dnzl+bKzx3PYiB8QZ/kLGqeHAf1aGia63zfcVYkr+Tf2ZyDLsJmMrkv8cesWjDh6Or+nAWMfa6qmpDhruccSSGuI+WKrDAM/uaWc//UEn+7e6mpr2hb3nTH3YBjPSf6KB8fTaqNMzWMkTLGOQqIxzgKUUE8v1Vaxyy3SwCgY47+juV2eHSUw5ZYoAK/McO011FHs7e9LiNAhrQMtvf08SwTD4mvZKCIlRYc7N3sLeNH0Yn+rUQPrnlqp4PdS093TFosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0BGi4QJcH4A1TeiLKuqwbcp40J+jUv7lUybMPxjHg4=;
 b=OFU3vmgoKLIdDV5dOLLhRdJ0t9wRfw7CYNXED9o4GMgv4I5VQDIdII2SOKD9ZYUc78Aq2+6SNNqJDj08z+XvA1QgxBYAEIncCis3vHQYhFvmCoPFPc1cEEnqwGNQljfyQBsvbkp0+dhnl36pbujUGaKMytTTiUN0j9u2lX3lzUu+y9BgObCTf05E4auMrb9NJyNyxGpuf5jT864P1sSq5nnDP7Tft5KJAfRIzZXx3IBu7zddl+4ye+wFNw+/2h+ekvj7SMvODHO6OPzgtFLwwliEzPkDCq5TXohoTmMoAfxoEDtU2RmYJJfIYzLobNGynhfSBzfzy5vC0eIViFGRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BN9PR11MB5259.namprd11.prod.outlook.com (2603:10b6:408:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:34:41 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 07:34:41 +0000
Message-ID: <2d6b0d54-57d3-4f3b-833c-8490aa63490d@intel.com>
Date: Thu, 31 Oct 2024 08:34:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] i40e: Fix handling changed priv flags
To: Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?Q?Peter_Gro=C3=9Fe?=
	<pegro@friiks.de>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>
References: <cf6dd743-759e-4db9-8811-fd1520262412@molgen.mpg.de>
 <20241030172224.30548-1-pegro@friiks.de>
 <03b7d4ef-1e1e-4b9e-84b6-1ff4a5b92b29@molgen.mpg.de>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <03b7d4ef-1e1e-4b9e-84b6-1ff4a5b92b29@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0013.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BN9PR11MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f395df-9d2a-4715-06ba-08dcf97e7b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3k1S0ViOEEwdFlobko1YlphTXVEdllVek9FcGhWenVjUVNjNnRtQ005T0FY?=
 =?utf-8?B?UkxIdFc0VEF0K0MrRXBqemVhd2h6bm5heVdtc05zVlRZMXA3b2V2RVpNUDh0?=
 =?utf-8?B?aE5SUHNyZzhJT1lsaXpjMXBiQTd0K3l6dnUxUVozZVBXaStGTXpZUEtQL3hw?=
 =?utf-8?B?dExKWnZjNmxwOXlMb2hndmU2RnpobWN4dmswSXNuR3cyWTFza2Zha25pNXJK?=
 =?utf-8?B?dU1wcWFUU2tQVmN5SnNWZys1aThnSmVadWVaWDJDNjVsaEVkanNIWGJyc1Fj?=
 =?utf-8?B?eG5QOEgxcmlrVkU3enV0dXZTZUgzdDVaQVpnbDg0U1EvTVRoTFN2aHBCa0Ju?=
 =?utf-8?B?QW5KVkxnekxYd0htNmhhYjJCSUcvL0JWSUpWUzlvdDczTlg1eFpYOXd5bVRP?=
 =?utf-8?B?YjB0QWFhckVHN2E1Qkl5WHdSTEJsNkE3OFJqS3Q2VFErQkVHNlpNUmcrbVhi?=
 =?utf-8?B?dUVIQ1g3akNOV3lBSlNTMHdWMWk2Tjh0SG44eEVhYVB6ZlVGd1RDeGY3Q0xt?=
 =?utf-8?B?alMvVkNIUm1rYUJVMm1HRTBvUFZObXdZUFVsQUR6bTdVdWljb0hvZFM2UFVo?=
 =?utf-8?B?UHdMZm1VeG5ZZ0wxQ05OQ0piNGljQUQya0RpaUdmNkdUNDJ4ckU3VzIrUDVZ?=
 =?utf-8?B?ZkUzYkdJcVQ4dnhHd2RUL0pyeU1OMFRBNEJvSEkwK0VNQ1BWbFVDQ1lqVk9o?=
 =?utf-8?B?Z1FPWlRFNUNBcjFuZXdneUFQTTRMVU11ZUJtckVtbS85N0xVNzI2NFYwK3Fy?=
 =?utf-8?B?RElMS0RvZVRUZVlBdmYvQ0dGdzV1TkdDb2NYays5YnBkZ25zTzFySDNPU295?=
 =?utf-8?B?SmlVRUdiNXNndGhncFVhczdMVzBRemE1S1NMWlFkN0k4MWtkWnh4QlNIQWJM?=
 =?utf-8?B?MHdPQ2tWQTRYQzhtUkpSUktHcnY0QXo3dTYvM2ZJQVB5WnozdTlza25KRnNa?=
 =?utf-8?B?MFg4T1VoU3VRSGdYOUdGMG9KSTB5OEdRYVdrTGNYM1N3dlJMUzJrY09FTnAv?=
 =?utf-8?B?QW10V3Z1TTVxdndSQ05HZkxhTjJaN3o0N0h0ZmlqQVd0a0xNWFQ4QXZUVDdL?=
 =?utf-8?B?a2R0ZVRTMk9WUy84ZEhvRG5EVzc5Zk81amRpaDlCd3JzV1RhdjhySU1nVzB1?=
 =?utf-8?B?clB2QWdiYURLbURUbUNKZGZRQldXM3FjemlPOWtjQ0JabHpTdWR4VHlzRnV6?=
 =?utf-8?B?L2pLQlR5V0NtOW1VSVhwK2hRdW5BSFpFLzZyYW5GRzBNaUlaOUhnQTBJdGF5?=
 =?utf-8?B?ZCsrZjhYUit0N2JaZjQ0aGVZb3Q5bGxJdVBSQkxQYWZXc3V2WDV2MHAyRVdO?=
 =?utf-8?B?WjBqd0UraGxSbUZ2S0RFNHJ3WDM5K29RYVRDajNWVFVha0wvMjNQcGhoNW1x?=
 =?utf-8?B?azEwOVpPU2k4YnpNM0V3L1lMRTVTWFhVMjFtbEtsYWxCNXpEa0s0K2VSNnFv?=
 =?utf-8?B?aFBRdFljUUFPajc4Q29xWkNUalRYU3ZSYzFNbVFERFdiOVUzTjR2ditsYjU2?=
 =?utf-8?B?eUp4NjNwaC92dG9FTm1nQjhBTUtNcGpJOUFmREx6Y005dndRQW5kWDA5aHN5?=
 =?utf-8?B?cXFUSG1Eek5FeFBaVzlsaU9OdjgvSjVNR0tEaXRNcFp4dllEYzdQVXRsdktO?=
 =?utf-8?B?aWNqZVNmeVZoOWlFUmZnVGJPZXphSUh4Z09GMWdjWU1VbklMZnhFU3E4SFhn?=
 =?utf-8?B?TWZaaVNJMm05bzlCK1JGd3RnVTlzT0dHUWZGSk9TMVlVM2tEdUVzdkt2TGll?=
 =?utf-8?Q?QB6lu5kfgUXTcIFBEkf3W8w8BuWENlMSfD6DN6q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVk2a2t1QzVSUWFkZVhtOStESkF0NzV1TG5YYXl5bHJXRC94Tk5xTnkrNjFD?=
 =?utf-8?B?ODRTZWxUS05mQXVXcmIyaXVYS2cwR0F4dFJycmo3M0FpTjJ5d3VRNDFMcUts?=
 =?utf-8?B?UmpjK1VHVk5PT0YzSEFncWdWNWNSMEFSeG91T1lucDVsbDZWbGdWZi9NVGR5?=
 =?utf-8?B?dDZMKzN2MmNkZEMvSTNKOUdUWnp4RkF3ZS9HdTlQZklSRVp3OXNmLzk4SFFz?=
 =?utf-8?B?dERSejFseldSRnJvY0VDOTEzeDVMejlUMFR1QWVzaTBReXhOTDJFZmxMMFRV?=
 =?utf-8?B?dnFTNXlja0FpMXJtVGFQanZNdGVtaThsVGVkaUVVNXRyNzBLRGkwQldBVCtj?=
 =?utf-8?B?M1ppWUx5TVROU0t4R0ZBZzhibDR2TTVXVTBpaFFXcmtMdmFSMGNkQldGVWxl?=
 =?utf-8?B?QVd2bk03THZTMnRPU3REelB6WW52U1c0TTAxL1padEZTTTBmUGU4Z1MxSzIr?=
 =?utf-8?B?VzI4RnJITFlNa1l2UzBnZ20xcnBBTWlzU2lWRm1JS1Uyc3Z4V1pVbEdjUE8r?=
 =?utf-8?B?MnExR3g4bnZPMWRMeFBMSVJySnE5UjJqTE1ENllPQTFqNGdKeFNBYmlTdHpV?=
 =?utf-8?B?WHE0TzRtSnpXd01BTWpsL1k2RUx0UG9UN1Q4K3p6citYU0N4dmlnWHpXM2lX?=
 =?utf-8?B?eUttLzlxVUpqRUxMQk8wZFBPQzcxdzk3Y2pHMnBWSTFOckROYyt3MjlEalJa?=
 =?utf-8?B?eFFnRzRlMm0zTk9HYktESjg5TzdnMkIyaUIzeS82bGs3NDlWUUVhMDFoMUl3?=
 =?utf-8?B?VGEvdTd2UHdhbXV4V0dkQ3lGTXptOWY5dzI2azA0Zll0VlRkRkwrT1BSZS85?=
 =?utf-8?B?RlVJYms5b251M0dsTFQrWFVKVmIyRHl1WXo1MFJtTTdwamU3VVdyWk5VZFJQ?=
 =?utf-8?B?VkZBKzVRamdYNnZRb1FYVkg2QTRWTGhWKzF3eDhJNUtZdnNONlhHOVdKVExR?=
 =?utf-8?B?VkVQSWc1cFJuWGVxQ29DS3JiMzVCakN0ZjI3RkNubzlqU25XdnVTUnJTSmNo?=
 =?utf-8?B?c0ZqSWhDV0FyZmdsQ29HNlpmdllTVGgxcjBCT016cVRpUGlTMWZ2dERRRCtZ?=
 =?utf-8?B?bzlqbUw2b0FMRTNlS1I4WDlnVStlZHhCNHJlNUN6YTR2Wmw5REIyUi9CRytj?=
 =?utf-8?B?Z1VxQTlnZGZjT1dLb1dOSXVZWm93RHdQSFoyemNDZXlmYjdNWkFJb1VkT1Bn?=
 =?utf-8?B?UlBxRklEelRFOGFzQ1BjSFpYd2dIR2Z1ZnN4R3ZTNFBldk5nUENCdmVTTkxK?=
 =?utf-8?B?cWFlZm1GbVhJcTlRY1kyeWJLYVo2VTVrRVVYMC9WdGFBMXNNWTl1MHJhUi81?=
 =?utf-8?B?RDdmTE9PZzFwdFhjbEl6cmJvSTF2bklGaHphQlIzLzR2LzBJRGNGbVFhc2pM?=
 =?utf-8?B?bU9Ec041N251RmhIVlR4VkJqVFIrdGJJcjVuU09XTjNlS1lneTRLTThPSlYz?=
 =?utf-8?B?czd6ZmNCMDYzaHg0VlM4VytDS2RtRTRwc2d3RHVLeGhmYXZMN0Z0OExWcUxD?=
 =?utf-8?B?alpsaW9vVG4zeEJ2M2pDdGYvdmtiM1F3RTBiY2d3ZHBXWml0RE1NNUowRXFz?=
 =?utf-8?B?MnV6NzVPa1dKeDJDNFcvMzlPQkN6Y3lqbjlkcm9sWk54Ri9zbjRqMFdZV3N5?=
 =?utf-8?B?YTUzMHBBNGFaTzFoMlJjS3hxek94a01VSVdhdTRhZUFEWjR2MFI5RTlMRk9J?=
 =?utf-8?B?TFdGSFlFZEVyT1BhVUNlTndVb2VucWVJbjNTTUF3N3hZSUdHR1Q3c3hPVUNQ?=
 =?utf-8?B?dmRQTzlmbUU2SXhyOXh3Y2RMUFd1WFl6TXgrUzhIY2lIR1U4U2VUMzl0Z0hI?=
 =?utf-8?B?WnV3WFZGTUFiOE5JeTlhV0F4R0lpOS8zT2l5c0d4S2VVaStUVEszNkQrYklu?=
 =?utf-8?B?T1o3Q3QwVHAvbjVwUFZDa2tSaGJGSnZ0bjAxV24zRkQwSVZGZ3lLK0JCSGw1?=
 =?utf-8?B?OElZZFBJV3BoSnRRdWp6YVVMSEhaNDAwN2JjakUzSG1ucHd0NkQ4akI3emds?=
 =?utf-8?B?WkUxd2lOVWJORTM2azBWcmpqZ1J5Y3NicUxodEcwd0d0cHNWWGEyV3pDSFNM?=
 =?utf-8?B?UmxxNFlES0JMdEZZdmUrS01lZTVoVXVjVDE3L2RFRU5GQ2hxL3ErZkIrTHBt?=
 =?utf-8?B?YnJzTzNxcC8rQTBRNVo2UTlmNzY1dGR0MmR3T2ZlclNGZ0VEOWs5Y0I5Vy9t?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f395df-9d2a-4715-06ba-08dcf97e7b7b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:34:41.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyVTCqKimaYsbXaZnh2KIXkSDubhVBFpeZK33nGNpz5r53EzVkch79/AaeNefhhw7WaCJma6g4yqLaUBxEc5jyR67gcryxaUIW4VqPNkNFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5259
X-OriginatorOrg: intel.com

On 10/30/24 18:35, Paul Menzel wrote:
> Dear Peter,
> 
> 
> Am 30.10.24 um 18:22 schrieb pegro@friiks.de:
>> From: Peter Große <pegro@friiks.de>
>>
>> After assembling the new private flags on a PF, the operation to 
>> determine
>> the changed flags uses the wrong bitmaps. Instead of xor-ing orig_flags
>> with new_flags, it uses the still unchanged pf->flags, thus changed_flags
>> is always 0.
>>
>> Fix it by using the correct bitmaps.
>>
>> The issue was discovered while debugging why disabling source pruning
>> stopped working with release 6.7. Although the new flags will be 
>> copied to
>> pf->flags later on in that function, disabling source pruning requires
>> a reset of the PF, which was skipped due to this bug.
>>
>> Disabling source pruning:
>> $ sudo ethtool --set-priv-flags eno1 disable-source-pruning on
>> $ sudo ethtool --show-priv-flags eno1
>> Private flags for eno1:
>> MFP                   : off
>> total-port-shutdown   : off
>> LinkPolling           : off
>> flow-director-atr     : on
>> veb-stats             : off
>> hw-atr-eviction       : off
>> link-down-on-close    : off
>> legacy-rx             : off
>> disable-source-pruning: on
>> disable-fw-lldp       : off
>> rs-fec                : off
>> base-r-fec            : off
>> vf-vlan-pruning       : off
>>
>> Regarding reproducing:
>>
>> I observed the issue with a rather complicated lab setup, where
>>   * two VLAN interfaces are created on eno1
>>   * each with a different MAC address assigned
>>   * each moved into a separate namespace
>>   * both VLANs are bridged externally, so they form a single layer 2 
>> network
>>
>> The external bridge is done via a channel emulator adding packet loss and
>> delay and the application in the namespaces tries to send/receive traffic
>> and measure the performance. Sender and receiver are separated by
>> namespaces, yet the network card "sees its own traffic" send back to it.
>> To make that work, source pruning has to be disabled.
> 
> Thank you for taking the time to write this up.
> 
>> Fixes: 70756d0a4727 ("i40e: Use DECLARE_BITMAP for flags and 
>> hw_features fields in i40e_pf")
>> Signed-off-by: Peter Große <pegro@friiks.de>

Both the code change and the Fixes: tag are correct, thank you!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

BTW, we obey netdev rules on IWL ML - next revision only after 24-48h
and send as standalone series (instead of In-reply-to) - no need to
repost this time of course

>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/ 
>> net/ethernet/intel/i40e/i40e_ethtool.c
>> index c841779713f6..016c0ae6b36f 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
>> @@ -5306,7 +5306,7 @@ static int i40e_set_priv_flags(struct net_device 
>> *dev, u32 flags)
>>       }
>>   flags_complete:
>> -    bitmap_xor(changed_flags, pf->flags, orig_flags, 
>> I40E_PF_FLAGS_NBITS);
>> +    bitmap_xor(changed_flags, new_flags, orig_flags, 
>> I40E_PF_FLAGS_NBITS);
>>       if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags))
>>           reset_needed = I40E_PF_RESET_AND_REBUILD_FLAG;
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul


