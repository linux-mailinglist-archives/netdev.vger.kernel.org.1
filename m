Return-Path: <netdev+bounces-82542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31088E83C
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9012C3BDB
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31E14A088;
	Wed, 27 Mar 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5lIao1b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EC13CFB1
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550771; cv=fail; b=IceQajzgRgmF6zEKBD//nZtDrw7UGL/HHO4lRE7uDM9WnqHgYambTn5CQarGlrm6nh4bqOLqQXGuqC6dNnVKKCNwSCGJNVH12gPXKWslPhUBOth2DnCODZdWWPiUVldOauMUeSVSjGJgUiZes4j58QjE4Wo/Gr8iCV3aRXCubyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550771; c=relaxed/simple;
	bh=rxjm9RlLhZEp46ahwn1Asyy0yR7oUGNgp3S8TBNQhLw=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=SqtmV/BX87llKp7duXZzWh7O9Ff1KmiTCw2HVaOpQDIDXViqfPAGEhfZoIq35aqtUN+29I/bROuGmwhdgy341jt94Ses61+HSZZibKNB0aoxPhxl6MBTisJC4AQH7vhyE+pFicd1pjetguV5qMGBDDJO09BxjRS7IMnkjc49zbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5lIao1b; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711550770; x=1743086770;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rxjm9RlLhZEp46ahwn1Asyy0yR7oUGNgp3S8TBNQhLw=;
  b=m5lIao1bBieROILhb6nH2RF1jbcBDRSdEtmA1BzLpGGArTbRkdshU5jI
   g3ub1Bh5+O77C5gvGeq73Y+erIAttvXGjaiEZeV3pwfpFOw36mi8QnHUZ
   jZ6Rs2Q4gkp1eFD7NLQck3oruPwOaJ+RsCFymceWRH3FIkoaI8lT59R+0
   k02zjOIm5JyIVU0OkspyO9dnQmZCpsI3S/y293JcMDvjQAqLcBkF1afw6
   wQhYnrjNBsAznY2MayCdiApqVd+9U4FrKbBaifgVcWBNypAiNOeIzF5be
   AMJwqW+Gtq6ZSbUJlVWMQbrvaA5dl/LIMuNm0/0G5dh7L7lO4M7YCy6IB
   A==;
X-CSE-ConnectionGUID: F5WU+6tVROmL/p1z+4gEKA==
X-CSE-MsgGUID: KlAoGxyHTaSOzRZ4WpICBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="29134207"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="29134207"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 07:46:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16960067"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 07:46:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 07:46:09 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 07:46:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 07:46:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 07:46:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmIgebmk7mw/+Qzh8QOXPmvn7OTSDl/HpK6HgaGEn3gdUcECi00XAZ4Cm3Y61Vu9iS9H90hm1UAe3et6Ka0qATJEXEjVYwgLMUC6az6ra4hByvELAYpif2LQozoRdaWUaoduahLjLOARZ6DxbcM+Hj9Ctj7+22Sf+TBhJ87daBIJQVZ7NplEiIlbxv4dZXqD2YRrr+6wqw1a/1rvJzxcXoHTZt6woLYwwMVsE4dT+BOOjhOLThgmE6AraUOTLXqm3aoaBtYHK9DKepRyrvVItK2GYwftCUm7Ef5pBu7L55nEEed49o/916fExRgSsKfW/wlhUAr5nQKQhPsTnXzRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S0mH1FUudf5G3K6KabsKIVUUsOHJSgUdaNcsM/fUD4=;
 b=AMMY4qGkjd4aS+boHTqaCDBB82oyObY3Pq50NgvJ3vNRpINb6FEsxxerSP9zXvRXRxTlOUJMQDvTaIT5K1EGT4/77VTwE0NQIP54VWIwT+yV9odT1gszLNlPDY6UmsVmS+Uaf2KluSuI3zPivpwYaV/YKSEUdzZpGkWag3HQ+zN9FZiOQKeGsiUruawD0a3bej4h5Od2rSk49+RVzToLE4+TyP8hRiG2T6a2n/JSggfhks5GOdQOXiWwS4z8zfljrkVrtLOwNwuXLdkZhmTvkhye1XwGwefDnOwqNuvJy2t4V21sPD7CY4c1W/MtEv7l3YbJyjmPAtqgDBd9elx1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7028.namprd11.prod.outlook.com (2603:10b6:510:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 14:46:04 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 14:46:04 +0000
Message-ID: <556ec006-6157-458d-b9c8-86436cb3199d@intel.com>
Date: Wed, 27 Mar 2024 15:45:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] virtio-net: support dim profile
 fine-tuning
To: Heng Qi <hengqi@linux.alibaba.com>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
 <1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
CC: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, "David S. Miller" <davem@davemloft.net>, "Jason
 Wang" <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR03CA0090.eurprd03.prod.outlook.com
 (2603:10a6:10:72::31) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cffe121-b1f1-442d-ef91-08dc4e6ca0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4h+y0M9pP39WGliS4DaqejxXAKfSL0MMRvEIhUQlePYiQ+JjMeiN26V5M6D00Bto0lXGa+CxMTNVI1xO4B7GTSnx/tEah64EeUPkX84uiP0dTgwX8nN13zHP+GX8QS5d7+zWy0FFprkJXG308i77SvQufpRKMNYmw5z81NiA1ECHfDFH2zZpHgZtHggzSvYe+WRxDzurJmCV6Q3Jrz+XhkSTGgJ5iqMYexUU5UM++IEFYSa8kmdak+M195Ch5bl9ZzEkux2MW/qoA+J31aimfucehrFYvYYG24UtDP7SpfFavUxK4TVvftX2k+PmcwydOn3qT+YIO6ypp0XV+arR7mI73ROoWcHm4vfcw/hz9gtrOeAEiofW6feYLcGOzyc5b2TJaXJCWU7kFvxWjbwLPrmZCW2sg0uvtJMaMPN15elKeRwfRl3xNeqzgtko0VroqCO7aOXtLJYYt/eoWTW9XkXHjF7syPEwxZmm2O5vCd7gxeQIbU3+/rk+petJ8EMOikM/9j1THOo1yp9mwNrA0r87rB45M9nRzR/NSUnPghzzFSMx+H7rI8V1qmVwKAqFmv4AwvBbz5jeCkvrnOvSXpBuHVuriU9QsN0vQAhKmg9FF5zGAJ7D+2zsLbojGFeMXVLQ5i3BCXvLyfxlhv4VAgC/7/UUimn9ZLwlwFDFBeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUg1cnFzWEtmRCtWbStid0lXYmZLZ2tGMGo1amk0WE1KN3gyekxDNi9wVk5v?=
 =?utf-8?B?V3VzT3cyRUU1dzNCUHNka2pWVDE4RHY2K25LQVZmZG1QSnh0M1NtSEhEOU5m?=
 =?utf-8?B?MUpWWmpMcnAwZFRLMzNZU1k1Y3FMM2ZFRmZEdXNnWk9zRkJFWm96QUNYVUdI?=
 =?utf-8?B?K1Fkb3h1azhrZXIzSGhlUTdEUjlVU3l4eWV5dEVhRS9TdTc3cjRUNUtXbjRs?=
 =?utf-8?B?d0ZEUWZzaU1OVkVVb2kxN3NKNkVGNlk2ZDBFdlNVUWI5MlVRS0ErR1A2NHFz?=
 =?utf-8?B?b1VNbElVMTJ0Y3NMUjRmQzQ4a09sZUdneHVIVHljSkVoVWFMbkJlVHI5NGI2?=
 =?utf-8?B?aGtyclZpdWlnTjkrWldtRUxFL0RnUVNtSVdndGZnVFp1d1Z3V2JvSjhxK2hP?=
 =?utf-8?B?aGZhSWNiUlAyU1NPQ3g5cmN6K2x4Y2M1QnRRaE5wcUZ2N0Z1bDZIMFppRHIr?=
 =?utf-8?B?bUdQSkx2Qmk0ZGo5SW80b0o0Wkx2VUdhU0pDdFJ6MDdmRUJuV0RBUGU5SWNU?=
 =?utf-8?B?OHA0NGF1aGlnN0VvUjVHZ3M5TVJMRnp0VHlWd3BaL3RMUUtlRS8rbVgzM0VK?=
 =?utf-8?B?dDlkUjFmMlBaL0YwWUtCVlNVbkJqcWVlbG9UTDEydHlGMmo0Q2RuWXNiSHls?=
 =?utf-8?B?V1Q4cVVoMmtGYlpPa0ZweG9sS3ZVdmxqV09jUXFCQUlJaDlPcDJEc2xEcWl3?=
 =?utf-8?B?VGtpTUVXQk9kd2M1bG9STllrNUNZRFZnUEIyUlVCcVgvN3czcDlramprUUlx?=
 =?utf-8?B?Z2MyanF3a2JFMlN5NW84ZVJONHp5UGp3RXE3VUJpYm9FVTdMbC95R0NkK1hu?=
 =?utf-8?B?NjFWbGYzbEsvVm8rNXkrWkVGakgzaTdTMGZQOVZRK2doakFkR3U0dDM3ckp2?=
 =?utf-8?B?Y3BDM05vc3NxTGxMZDRWdWhiVFlTamlyVEF0VmdUS09Yb3FhZkRtd283UGtH?=
 =?utf-8?B?QUJKYnZaVnY4eDZ1cDZZb1RJZ3R6aXdxUWlZL1MyVFMwSXNBS2g5Q2pLSkVk?=
 =?utf-8?B?ZUJhcEp6cnFkc0dTbTBOVm1XcEpTb05RRm9ucWJyY2FFeXlNRDVWNEJORHhp?=
 =?utf-8?B?YUlRZGdnOHN1VU8rYnFrTzFCbnlxWkpPT3h3dHJxVmhUMUF3QnZMZVVYKzdq?=
 =?utf-8?B?dDdIcngrSGYrM2Nna0d0WVBOZWNqbG02dHR3TGVvbzZSempQZzhFWXBYSXQv?=
 =?utf-8?B?bGFxSWZXak5NUUc1NVFkVzh0eXZWaDBPYlREWFNDdEZNQm0zZFRuL3h4cVRG?=
 =?utf-8?B?NE9PY3pKRUdPNkhVT2pXcHhnQ0RqMkxMdC9NVU42YmlvdzFMTEdMZ1RERkhW?=
 =?utf-8?B?eW9JbUdLVW1kLzlJSjVwVkFCdFFVcGRqM2hwMlF0S2dzcitubHJ2UjRVSWJR?=
 =?utf-8?B?a3Jsd09KU2ZMN3hDUjVEQlZ5ak1qVEVVUEI1VGtjM2tGSTVISThGQkgzRHBT?=
 =?utf-8?B?bE5xeml3YkhUSnR1d01HOWk1MGE5YXF6YTlYdGQ2VllDNTNSTTFqbEVIdkI3?=
 =?utf-8?B?MGFDSmNFN1lreURpLzl0VFJ2dU03SEtoSFlSamdiN0praThHc3BVbUtpdkU3?=
 =?utf-8?B?Y3FQVkxFYTdYNHhuWHNON2VHTGNoYzU3T2dRT1RrRGpqME1yTmFibTVVV3gx?=
 =?utf-8?B?dUFYaVBDYk5Pb1pKZytQTGYzUVJtLzRIZkE4ZDFrc3JJaGZmU2NnNnY5Q1N2?=
 =?utf-8?B?YUdBV2ZDWTVzeTlFMXk2eExHTDFyNGV0NkRad2JVOS85QTZQelJLYjB2Wldk?=
 =?utf-8?B?NDltQitzVitldFVvQnJkQ1BoeUtSLzBOa2x0R2V3R1g2b1h1Q004MEZ5eEZr?=
 =?utf-8?B?b2FWVXNrakcyeXRONjZPbGhEdmphTzNQQlNDVXJBeVNEbVFxVG8ybThPQXhz?=
 =?utf-8?B?bUxIVHB1Ukxvb3Faak9IUzR2MnFSeG9CeXNadmQ2NEVCc1pBRTRwZC8zSVNw?=
 =?utf-8?B?M052THVxaS9IdCtxV0o4NDFXRGRHdFh5TURxRCtMMjFEdWNTdGZEcG5zUlVU?=
 =?utf-8?B?eVNHNXFyUDVLcTFpenFtTUJxUVl3SFVpemdWaVJheUgxUTF2WDdudHJ6RlNz?=
 =?utf-8?B?KzhYZU9NN3B6OVZxcEQ4dTMwUWlpR3VSZGNxWjl1ZTNJbmJYVmdpYWg0WkVr?=
 =?utf-8?B?UUZjYlk0VkVoWEliODZnSDMzMDF4WVNCZjh6OGVvcmN3MXgvLzRkVEgyUUQr?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cffe121-b1f1-442d-ef91-08dc4e6ca0e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 14:46:04.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+HALI7uQtlS5afPUmZ8EI6fXvZUoZQlJQossU/Q2XZ3wqCWW8rw5fbDf5nsKbHgU8zzM70VvG7q46DxPsPSUMB1quLZuN7djVmdxnKbKHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7028
X-OriginatorOrg: intel.com

From: Heng Qi <hengqi@linux.alibaba.com>
Date: Wed, 27 Mar 2024 17:19:06 +0800

> Virtio-net has different types of back-end device
> implementations. In order to effectively optimize
> the dim library's gains for different device
> implementations, let's use the new interface params
> to fine-tune the profile list.

Nice idea, but

> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e709d44..9b6c727 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -57,6 +57,16 @@
>  
>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>  
> +/* This is copied from NET_DIM_RX_EQE_PROFILES in DIM library */
> +#define VIRTNET_DIM_RX_PKTS 256
> +static struct dim_cq_moder rx_eqe_conf[] = {
> +	{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
> +	{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
> +	{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
> +	{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
> +	{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
> +};

This is wrong.
This way you will have one global table for ALL the virtio devices in
the system, while Ethtool performs configuration on a per-netdevice basis.
What you need is to have 1 dim_cq_moder per each virtio netdevice,
embedded somewhere into its netdev_priv(). Then
virtio_dim_{rx,tx}_work() will take profiles from there, not the global
struct. The global struct can stay here as const to initialize default
per-netdevice params.

> +
>  static const unsigned long guest_offloads[] = {
>  	VIRTIO_NET_F_GUEST_TSO4,
>  	VIRTIO_NET_F_GUEST_TSO6,

Thanks,
Olek

