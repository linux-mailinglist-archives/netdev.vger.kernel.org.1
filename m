Return-Path: <netdev+bounces-87550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92F38A3871
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 00:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF6E285EF4
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315414C593;
	Fri, 12 Apr 2024 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuVFi/jO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756839FD5
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712959407; cv=fail; b=gpq2e9DSCErphY2Kprf2IUFqSWP47147ldu7NMw/KK9lL0bahcppozeWBll8o5ngnOkh99k8kBxFLttxaX3hzrcQf5Lor2Ot+OFTrODpeT+SgyTGEnrCrZQUWpRtiMv3CNgvngFlXXaqai0oM9S7HO1VrM6X4tCT35Yt+xfnu+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712959407; c=relaxed/simple;
	bh=6O5qKclBwDlkOkVkvPwlH/Vn6QOFTKKye7SviJ2E51w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tfJOnnWxMXUlOUBRo7XObselRc/tIaMTKxT23ROkDSq4QSjdHzcceIf5yRjX1Ro2PCTNrL8N8jqhYYuxGBGueGQ53z7T8OuZEwnwDimJtH4Cmz0K6djOvRn7Cmk5/NhUT1CYcOO5wqfiBaUZi0qJBKByoaiOqPpgei/6bR70aKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuVFi/jO; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712959405; x=1744495405;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6O5qKclBwDlkOkVkvPwlH/Vn6QOFTKKye7SviJ2E51w=;
  b=MuVFi/jOEKCzb8FWoWjbl9ZZ7TzK+AdnaXcQmFu4N7pSBK+j6PmxZTi1
   zGoxnMG1Js4d8AputeHZtRvVqfLnMTtDO7e1ZmfRMYNF2BjX4mWhfQjlM
   f0+XVQVPJmqLcwtvyg/6LYLPST2rJTjKE7PqHI1pWeGBKCAyDYkL+cY4e
   wsHqHSmBKcfFWT795nnGeVYc6oKSDNna6GfFtQ2nNWmQEcPNUY9H1kB/w
   3KHzsqFhr6JdohZ3BbE0RFfpKp0sRbyojUzElhtR0EN1sSq0HVYYDBS6I
   LDugtAojEowa+jI7OsrfiS+7tWBPSgBImiTYln3ot68PvYigkCvVcIfpL
   w==;
X-CSE-ConnectionGUID: sFzRdP8cTCSxXDEttDyWfw==
X-CSE-MsgGUID: f6nakUDfTRePhang0BHfRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8301465"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="8301465"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 15:03:24 -0700
X-CSE-ConnectionGUID: eeeKK9hxTSuYBGGRJialGA==
X-CSE-MsgGUID: tAt3c7d8SWGQOlOx8Px8dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21434007"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 15:03:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 15:03:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 15:03:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 15:03:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 15:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7/DIxLVIjXrG8irbccf+x99P+NurXsUo0g9S/Em+6cBc3FTX8OcEO77ssWnotzA6SZrzz2ds1FRFb+ma9eyLSbCC/eK8sA+qHDrZB62vLz+nuWi3iGbwUweCLRYtLLY67sz0b9Mi2dl5l9zQE8MwDrg2hDNbgeCJhXYhxL/s9qwybN2Bhl9pO1Ys/7LS0Ow/4m9WGR1WTCC9qabmvQBVFHGs2ViPw70y8OZNnS0r8BIu6LVglCDM6/HBTLDLzX6R/z8KQmjYVBSBSMoDQx5o8Sc7rM0JUv023szpaUBZLIgh+9fyYjsKZh299jsTrzyavL01MkCHxi30MchzVUsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgMMKDTP8om89MvF4JgfztSab12Ogq7sFXcLpsRv7fg=;
 b=MPGTxvrAuSSsgu9MCz7KUb5aR1U4EuHOE0SlSgxgWAGLonlDgV+LSc/cinmEr0RYe+SSgR7ySkUVT2NLnfLE3XoYe/mHi5o7jj+S08WVP+9i2g9OmdQRA62XGezTKrHVqjdi7eK+BWtfm6JNxzHefnyajKH3Vi3WXfVMAkQvXvDMpclMoqfaevl6LswSMGyyHzeTKe0++gukfF9Y+jRSTKpCsFrT2I0hGLSk89AVmdpQ2K1ZI1WDq7pk+fP6QPeyW++Vcp5Kfzzf29Bg666+GZdK9dV6/e0MZi9+0jq0wchXlEy1gGdufx9KtKJ60pUlimERLvOx+NmhNSnNGfGPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 12 Apr
 2024 22:03:19 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::4a3a:732f:a096:1333]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::4a3a:732f:a096:1333%6]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 22:03:19 +0000
Message-ID: <717f47b1-d9c1-47d9-83ae-153ee11bb66d@intel.com>
Date: Fri, 12 Apr 2024 17:03:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] devlink: Support setting max_io_eqs
To: Parav Pandit <parav@nvidia.com>, David Ahern <dsahern@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>
CC: Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>
References: <20240410115808.12896-1-parav@nvidia.com>
 <a0c707e8-5075-43a2-9c29-00bc044b07b4@intel.com>
 <PH0PR12MB5481898C4B58CF660B1603DDDC052@PH0PR12MB5481.namprd12.prod.outlook.com>
 <dc7eb252-5223-4475-9607-9cf1fc81b486@intel.com>
 <68b0f6e2-6890-46f9-b824-2af5ba5f9fd4@kernel.org>
 <PH0PR12MB5481F29AC423C4723F57318BDC042@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481B04C5E22E7DECE8879B0DC042@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <PH0PR12MB5481B04C5E22E7DECE8879B0DC042@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:a03:167::19) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|BL1PR11MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 92458c78-4e76-4cda-635c-08dc5b3c5d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzlGQXZUVXNXTU96VVRYd0ZaMjZ5TVBMQnlnUGgwb1k3WnhTb3VncitTU0o2?=
 =?utf-8?B?TzdJUWNPbWxjTlNWMGJSTXVhaEpUeDcwcm9IN05hRUdtWE85Y3BMak9KWUFP?=
 =?utf-8?B?QnNNQ0FmSCtQWmhiUzZCd21oVnhGZnJxNURkcnU2UDVOWTljekZIUXdSTFFZ?=
 =?utf-8?B?WklwWU00SDJIampqVEN5QmdHMVZWL09zcHgxcVkzWHN2MVNGWUV4blkrRVQ5?=
 =?utf-8?B?bituM0t4MVlqdE1qQkRKSlJ3dFlqY2NvcUcxTXlkdU1mc3licEhYWTBsU0Ry?=
 =?utf-8?B?bWlTaEJUL2JPTGpraUdzUjMweDBlUldqVWorMjhhSytmYm02RkFpRWZ6L0hM?=
 =?utf-8?B?YUx1aVNVejdxNS8zaG1HaExMZU1jbVVpanA1dUF5bDd4SW5VbnFqa2dlTlVp?=
 =?utf-8?B?K1pPeFFlZ0xWNXgyOGtqUDFCMHFxaUVnU3Z1RWE1RXFkUjg3OWdOdlYvZTZN?=
 =?utf-8?B?eXNRMms2MERnR29LN0dNd0Y1NUl0ZGhPbnIydTEra1puSFlOazVlb2FHUmRP?=
 =?utf-8?B?MlN5S1IrdC85VXZFTCs2MXdaVVhqbmMzcFk3ZGM3K3N1V1ZvaGxCbmRUZ1ll?=
 =?utf-8?B?aHZLMmRtNGg0RWM2Mmw2c3BwWjZPOHhaS3dYazE1TVFLUU16NGY1TXVtc1pP?=
 =?utf-8?B?ekg1bnJqcE5nYmRTRFhEWUtZVm9qYUsvcElLdno0YzI0cVA4Ujhhem9NdmFU?=
 =?utf-8?B?VEpJM3FBcnNRNHUxbnZEWVZmb0NnSVhVMHY5ZlE3WDNJeWE4TTFQNDZmbGVQ?=
 =?utf-8?B?MWlidzlGS3JzcVFoTTFid0hBV2JDN1pOcW1QOGtCZU41K1hFcGNxOWF1eGV5?=
 =?utf-8?B?bi9jVFJtZUd1TzlqUGl5aEhHK25kbWFqWHdZOHdrQTkxMDFzMU42MWxGOWY2?=
 =?utf-8?B?UDZCL3gybWdwZnBuU1RDNDRsNHk2S0c5d2hYdGJxRyszbDhiTUtqSDFtbHgz?=
 =?utf-8?B?bEhWSTBOVUNTUlBDU0tCVUxjMGtudzlsRENoeFE2eWJXUnAvbFRPY0kyY3hW?=
 =?utf-8?B?N3cwYXFvRXJyaVFHejByZ0c5cVpGS0NmTlV2SmlpeERtSTVSM04zKytvcGZB?=
 =?utf-8?B?QU9SRWlGY1ZZMjlGV2lJaFNRQWZvcjJmbjZhTkluR2hxRGU2MlhWMHdLa0Zp?=
 =?utf-8?B?eGxySXVvTWhYbFF5USt0QXFoaGo1cURLaWMwMkdqS1NNVFVVVUk4dFE3UkZk?=
 =?utf-8?B?dnVEQVlsazh0VUVoTzZGeWhVMVR1aDdrYzQwMzhxRHBveTVJV3ZhdUNxcGpK?=
 =?utf-8?B?emN6bGs5NDZVcjJCZHVqQ2gxbTRjUHorUVBtaTNNTStxUTE5VmpuUXZwaEgx?=
 =?utf-8?B?VkhBczVBcDByN0k0S1RKNS9zYzE0VVZGTk53SWRkV1BXZGhRczJ0dGFWTk82?=
 =?utf-8?B?NDFGamkwV09McWJ5NVY3RVlqaE80Y09ZRmdBMERDZDc1dVZudlRGeXhDMVEr?=
 =?utf-8?B?YVRVdHoxU1kxbHNxU2RlWXlyelFQNlRJSmV2VXFTSlF6Y2FCL0xvaVR4WHdT?=
 =?utf-8?B?NE1SSDY2TnRISlp4aFUzaWNFNVhHVXVUeTRIQVJhdmVDdytDdllkNWpVMStp?=
 =?utf-8?B?SURkMWlGS0FKeDBYakhaTUZZTzhxbThwalRlWDVzTzQ5TmFvbXB4UW9DSFla?=
 =?utf-8?B?LzJFS2tWdDAzTXFSWTUyK21TNllRaEpLL2JYUVJ3OWE3Q3lScXltWE1nYXNn?=
 =?utf-8?B?bVVUU0FIQlBabHJuSTRpN29rNGRLNlB2T1RMeHp4SnQxd1RuNXA5c1hRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmUzcUtZNWxLaXpTc3VnL3hSMnhBQWFKeXpJUGtwUm53ZjBrb0l5OFk4Y0RN?=
 =?utf-8?B?cktjcFZSNGpMUWpwQ1lFNEY4ZHdaMmplQkZYQWhWT0JPbzBIc0hRVEtyeUZ6?=
 =?utf-8?B?VEYyK0VjZFRRSW0yMmlQR3A2b2JlajRIcE9uVGJ3V3Y0ckFEbmc0N1RvbEZy?=
 =?utf-8?B?WjZCVHJXZDFGUEk3enpjVDZFQXBBck1zK1F4QnVRdi9kaXBnTEV4T2JlOUM2?=
 =?utf-8?B?M0ZDbkFSVENHKzBZYXU2c2NYSHRSd2svdDlyYks3TzJ3Y3hoRVhXYU13UFJP?=
 =?utf-8?B?bVE4d0I0MGRxVDlVRlpGMGo0d2NUbG9YbjgrMVoxWFpWOWRtZm1Vd3EvWGxa?=
 =?utf-8?B?Ym56Wi9rbGIyOUw3dExwRFJERVZlQVhNNHhwQnFmTGYzeFJyL2JGTXhPMHFx?=
 =?utf-8?B?dHZBbkY0dGJGT05OZXN6K25VdHhvRnUxQVdPTWtjMC90OUdpbU04VENoZk5Z?=
 =?utf-8?B?d2VqdTJCcTNqdFVWc3EwMFU0a09paTFMeVM0VHl1bm9JL3NHMUlrcWFqTHBz?=
 =?utf-8?B?RnhnQXJDamxjK1pIMktqaGpEKzFHdktpQVBob1VyMVgzd2xyTjN5L2V4TWVV?=
 =?utf-8?B?V0t6cWlHaGNvZHRRbTU3dnJEeUJ6U2J6NFdBL3ZFYVBtY3llbzR3NUZFNFVP?=
 =?utf-8?B?blNYL0llWGVwRnVoTFRxcWlrMm5xK0piaFlYNnFVQ3I3UE5UMzhXQ1ZURnRx?=
 =?utf-8?B?TWczd1AxVjVJVGoyZUl0QVdYR2d1aS9FOGd0aC9JR0lKUWl4VGVmSDMzeVZO?=
 =?utf-8?B?aU9mQ0doeHFmRlBGRjh5bGhDTW42ZWpwZ2RRMzRmbnZIejJmVDd0Qmtsektk?=
 =?utf-8?B?MjdNMi8vM3NvTHo1U2g1b1BMNGp5b2VIU3JyRDBNUjVPbUNzd1ErV2EzUHdI?=
 =?utf-8?B?cG5MZERyQ094WmIrOTByQzk4ckpVK2NpWTI1UFBlOGdocjRMRXFMblhra3E5?=
 =?utf-8?B?NUxNVTBHRU1iZmlUcnpJYUt3Z2tZODdvY2lzNXdJbnJ3QTdzR0wxZUJQeHhz?=
 =?utf-8?B?eHVVSUd6QWRrQXNQaGRkTzlPa0lwcEJhZnhrcndwSmtlbTJRa3V6QXlKRlV4?=
 =?utf-8?B?eDhUN2hCK0hQcUh2a2tramN2aFV1WFJzenZLTWlVRlZOT1FlbVk3VDhhelVL?=
 =?utf-8?B?cXVoVWx2a3VnMmV2MXRualFIRHJhUk9FU0ZQNVRNVE9TWWZBZnY2WlhmdzlC?=
 =?utf-8?B?ZWdMRXg5cXR3d3REKzUvd3UwbWlnRHNmWWVDdllKUEpJRUJPeFpWZ3c1Rzk5?=
 =?utf-8?B?K2IxcmN0Zy95WERTMjY4WUZPaWpobEFSZ2FvRzJIYlpNeW5scXJlcHBqSWZj?=
 =?utf-8?B?ampKbVE4VGJwQWJ2alZrTzlaZ0lWbG9rbG5YY2Vxelp1WkYrV2NIcXd0RjhR?=
 =?utf-8?B?ZEtKaWhTYWt3cFF1RUVWcGhTbFcvdEdvMEt6QmxrdDg1Q0NDV2grZjJvMGc3?=
 =?utf-8?B?SnV6Y1QzVmpwa3RCRGY4RmFUWjdxUnRwcG1tWWlMT202MmxqclNCZGRBQlBq?=
 =?utf-8?B?Nml0NldHTWZQanFiZUdLNTRHaXBIQzhJL0h6U09zeS9lRnN5eWtvNTVXL3pN?=
 =?utf-8?B?Uy9VVHVwc2FDRjJCTldZQ3R0SmZXWEpBZGhYQ3RuRUVJTlUzdmZ5NnZzbWlC?=
 =?utf-8?B?NWg3L3ZJZHlYZXZKV3pERmRISkN4Qk92ektnTS9paE51ekhKUGRFeEVVMmRs?=
 =?utf-8?B?ZXRFcEpGL3BmRUFoa2I4dTRWZHBLWXFidzd3YnkybktTNCtOOCt3L1J3VFg0?=
 =?utf-8?B?ZHpZMEgrRWhkakZUZjVHUER6d0hXZFlOaE9abG9ibGdCM1lhMG9kd1ZjeElI?=
 =?utf-8?B?VUF5dkNqZVloOGNNcXJLM2UwbG5uNnV0TmVHandBNXlQVUtFMTVVUm5kU1VQ?=
 =?utf-8?B?YWJOZmh6WVAvUnZLSTdiUEJBR3RVTElRamR1ZkgyUHJhYzJHK3Vxb3hMZWpI?=
 =?utf-8?B?S2hIcUwvZXZnbTVGdXFzdHpaSUpZQzFwV3ViNUVGM3ZRa3IvdGhhUGNYazlx?=
 =?utf-8?B?MjRHUzh2QzBmVXYycEFTVEhiSndvdWp0R3BjQVMwQlo2Tk5GWWhuMW92YklE?=
 =?utf-8?B?VlNxb1ZGV0x5ZHVoOXhWSHRSVFk3dU9pRkhrS0RISEhEVmsrb3JQak5jR2JH?=
 =?utf-8?B?a2lHRFVoL0FkUnlDRUtWTlZjWFdXTDI4OGtXcDZpeTcra0dDRjdraUVuejZX?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92458c78-4e76-4cda-635c-08dc5b3c5d02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 22:03:19.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dc9TzzJYWGtW9bfhboZqlypQUEIpIRn2ZQXcW0EyTfok5IT7ELFKHUFI+WOzPpJfnQsMxGq0It8btGgISK49Af21GVr7+PWMsbYxT9tbQsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com



On 4/12/2024 12:22 AM, Parav Pandit wrote:
> 
>> From: Parav Pandit <parav@nvidia.com>
>> Sent: Friday, April 12, 2024 9:02 AM
>>
>> Hi David, Sridhar,
>>
>>> From: David Ahern <dsahern@kernel.org>
>>> Sent: Friday, April 12, 2024 7:36 AM
>>>
>>> On 4/11/24 5:03 PM, Samudrala, Sridhar wrote:
>>>>
>>>>
>>>> On 4/10/2024 9:32 PM, Parav Pandit wrote:
>>>>> Hi Sridhar,
>>>>>
>>>>>> From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
>>>>>> Sent: Thursday, April 11, 2024 4:53 AM
>>>>>>
>>>>>>
>>>>>> On 4/10/2024 6:58 AM, Parav Pandit wrote:
>>>>>>> Devices send event notifications for the IO queues, such as tx
>>>>>>> and rx queues, through event queues.
>>>>>>>
>>>>>>> Enable a privileged owner, such as a hypervisor PF, to set the
>>>>>>> number of IO event queues for the VF and SF during the
>>>>>>> provisioning
>>> stage.
>>>>>>
>>>>>> How do you provision tx/rx queues for VFs & SFs?
>>>>>> Don't you need similar mechanism to setup max tx/rx queues too?
>>>>>
>>>>> Currently we don’t. They are derived from the IO event queues.
>>>>> As you know, sometimes more txqs than IO event queues needed for
>>>>> XDP, timestamp, multiple TCs.
>>>>> If needed, probably additional knob for txq, rxq can be added to
>>>>> restrict device resources.
>>>>
>>>> Rather than deriving tx and rx queues from IO event queues, isn't it
>>>> more user friendly to do the other way. Let the host admin set the
>>>> max number of tx and rx queues allowed and the driver derive the
>>>> number of ioevent queues based on those values. This will be
>>>> consistent with what ethtool reports as pre-set maximum values for
>>>> the corresponding
>>> VF/SF.
>>>>
>>>
>>> I agree with this point: IO EQ seems to be a mlx5 thing (or maybe I
>>> have not reviewed enough of the other drivers).
>>
>> IO EQs are used by hns3, mana, mlx5, mlxsw, be2net. They might not yet have
>> the need to provision them.
>>
>>> Rx and Tx queues are already part of
>>> the ethtool API. This devlink feature is allowing resource limits to
>>> be configured, and a consistent API across tools would be better for users.
>>
>> IO Eqs of a function are utilized by the non netdev stack as well for a multi-
>> functionality function like rdma completion vectors.
>> Txq and rxq are yet another separate resource, so it is not mutually exclusive
>> with IO EQs.
>>
>> I can additionally add txq and rxq provisioning knob too if this is useful, yes?

Yes. We need knobs for txq and rxq too.
IO Eq looks like a completion queue. We don't need them for ice driver 
at this time, but for our idpf based control/switchdev driver we need a 
way to setup max number of txqueues, rxqueues, rxbuffer queues and tx 
completion queues.

>>
>> Sridhar,
>> I didn’t lately check other drivers how usable is it, will you also implement
>> the txq, rxq callbacks?
>> Please let me know I can start the work later next week for those additional
>> knobs.

Sure. Our subfunction support for ice is currently under review and we 
are defaulting to 1 rx/tx queue for now. These knobs would be required 
and useful when we enable more than 1 queue for each SF.

> 
> I also forgot to describe in above reply that some driver like mlx5 creates internal tx and rxqs not directly visible in channels, for xdp, timestamp, for traffic classes, dropping certain packets on rx, etc.
> So exact derivation of io queues is also hard there >
> Regardless to me, both knobs are useful, and driver will create min() resource based on both the device limits.
> 

