Return-Path: <netdev+bounces-185222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF9CA9957B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CF5188B769
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE14284B2F;
	Wed, 23 Apr 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTGPAqm5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2255283689
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426129; cv=fail; b=RLWXwocbuErl7nQgfGiz3ZLEzGXomngmJLKHDI4KlSEoaOXPM3EHk7QvY2OB/aArjvbOGQFrv4oDsalNR3Ak8n9euzcPiAA6C3w21dItB+mX41v3rgzzrSw6CYiWzp4PtCeHfoqJ+bt7CLCdTqw2s09IsJLLs061fyaHbw/oYjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426129; c=relaxed/simple;
	bh=gECksuVsSSFC28XWi+XZeS5UKBq2iW0+pk0lehY8URM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=na15L6bxnJND4fIdaWC9lF/2uA7+S0R59p2yajm7ji7pA4/85gldVhRUxoKFAqM8qL6TV7F3q1n4F9wq+5ebeT47TVucCxiwU55Tc7Ul4uDOrNgxis2LqRs4l8YL1md9c1FMwP/PFZnfYVQAMjE3pOVbJVPD/7218TYBHjONHgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTGPAqm5; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745426128; x=1776962128;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gECksuVsSSFC28XWi+XZeS5UKBq2iW0+pk0lehY8URM=;
  b=OTGPAqm5PDhvNRqODYykNtfUntgv7CxfbdHbxtHSoHjhENkXi1Wrqc6p
   8XSzv1i886d0FjiFgIC5dFqpDmj5hOR1tN4GKIeizpCxrGHZt8h8bjLh9
   YL7EdycyhvxL0uaPD5A70lMKqKrUc26qU+u8IXMLldjlRNfLy9lxW9unF
   LKgnsmWlTLJ9wt8633puNadQW49slbVC1r3uo0gh7EtMZS7nqJ+mTNzls
   3/JMdn+X4nLyYNbKIziSu576Y5oG0RkYJGdzeo6sXaUAgxXWPhj8bqTgm
   ay8dC7iGFXeV8VFuyK6SW0xfM3ii00W3wSHmwBMwCFLN8fBmXCG+x5oKy
   Q==;
X-CSE-ConnectionGUID: 6CCjb8tCQ+Kg+GvYJkv6AA==
X-CSE-MsgGUID: QKGR3ilyQzKT+Xf6pJBijw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="50693111"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="50693111"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:35:27 -0700
X-CSE-ConnectionGUID: oRxeDTiJSNid8bDJHarPlQ==
X-CSE-MsgGUID: TmrS7c0gR8SKciDtnV+2Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132111476"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:35:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 09:35:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 09:35:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 09:35:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQwGoV9i8Z8c83TUsMDIWXXEuEAc3DrMz/pYH8nfazdS+dvkFp+kGC0dST93YTcNN/3MYrc43InxL+tvjRfTvKjzYChtyKFrh+O9+MY+HdYajsmLiGMkbAb0dGUd5iRLYxUCLOEPwLOCTE7L4nPlF73LiYdYJS3IEsxksA4Ee1XZal7ia96LuhOC4urJOGUUJaeV8No4D4Vw7HwzDpn0g40r2bbaJ53AkZli3apu0XVJpeCMlyW3z+L+XMuPJMc2/2wK1pDpG80umZp0yfZhMbzKujSauaKS27too4zx5+UoI32cA9sf8ayJLQrCUaEeHob+gzkCkDrk9kswwVymeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPhmr9FpiiMeyei/dzpRPDTrLbwUcYDcqUqzW15PpHY=;
 b=HBLdIjL/ABHWBmmDXXyE3aMXK61H8VFZF9Te/3AAr3C8ND+xCLlQbNccYWakRzSPGzZRiV/n8abHwEK+TQNsBgsJgsWl9CvXAB+RGpIWOVOCY/FRhGGacT2ZmtHex5PfHt9jr2ye0iP8/C4zuy4l7l6g2c44EQ0UyfYjrYfced4GKrilauynnEwbVoPbTXIQhTwiq1IBAKp3pNBSjHvRR+382E2yDnhRJq3Ku2MrXI+fOGlAOz+fBNQJ/sxyPc9EzmBYfXJkvH4J76O9L/g9bFWgOk8CfXhJ9VQhjMvH16llUB60hcoUgALR6FQMmTec7QZVyJ67cAYyJuRg1n5JPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7680.namprd11.prod.outlook.com (2603:10b6:208:3fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 16:34:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Wed, 23 Apr 2025
 16:34:52 +0000
Message-ID: <b3ad22c0-bc58-41e5-8d62-a3bc8d7dccbe@intel.com>
Date: Wed, 23 Apr 2025 09:34:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: airoha: Add missing filed to ppe_mbox_data
 struct
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>
References: <20250422-airoha-en7581-fix-ppe_mbox_data-v3-1-87dd50d2956e@kernel.org>
 <c34ef8a0-20fd-4d0b-84cc-8f829f4be675@intel.com> <aAjNC7zUrhc2Ma0z@lore-desk>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <aAjNC7zUrhc2Ma0z@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:303:16d::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 75acbf77-08f6-4f05-d3a6-08dd8284c5ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnFEa1h0Y2Jrd1ZHSWJ6THBNVFVHQW5QYVNNTDdOY1Y2MWlBQkhub1h4K3Z3?=
 =?utf-8?B?SENkcHNaTFRJRUhsc0ZhVmQ1Ny9wZlM1NG9lc2hFOVVvWWk1UWV5Unlrc1FY?=
 =?utf-8?B?ZjRRbFBjUDBwUW5oNGpESExwVFNUTFVIWStVeEh0QmtoWW5MamJCcWlmQnJS?=
 =?utf-8?B?a2phc05EY3hYdk9rcHZuVklhcFgvdWNReVhDWU94YjdsWTdwYXU4MFNBdDJp?=
 =?utf-8?B?cUtBeW9wSFp6QnBUdXJtbG92cGtIcTJkTllSaXZNMldTbm5wbHU0U1lKS0Nj?=
 =?utf-8?B?dUlzdkE1ZTkzcVVkNHpWREtacTZNaGV1bGljbllYbitvdjRmMjhFQjZqb25t?=
 =?utf-8?B?NXMwQlRoNExDSUJQSXFtdUF6NU84WjlIVU1xMHJhRFhyUUF5YkdwQXVaMGVQ?=
 =?utf-8?B?WCt4T1VHdXFJdXZRUng4U2tWamhTeGRDUXBVckpqVjBRcGZUcWRCUXczSk5t?=
 =?utf-8?B?QThCNlFwSjFIRjE2UU1KaTJYdTBxRGg3a1hPdENjN1NqM0tha2dwU0paSnps?=
 =?utf-8?B?SVJnYlBZRTJuUzNZdnVDR3IvTktCbGY2N21ETVR4cUdOWE1GMzlKZmNIREY5?=
 =?utf-8?B?SndmdVZqUTV3YjlUdkc1Y3dNeGpldmthT0tlMU9pNEwyclgxTldKYjZubWUv?=
 =?utf-8?B?VVlPYjBHM1hPQUdKMzhka1JselhuTWhQeDVuWWxMV3dOS2cvLzFOYWxtV2tZ?=
 =?utf-8?B?WG5qMWJNQ0RnRnJ6cjl4Y2REdEUzWUExR2xLK01zSjFPaDNzSThQM3V1OXR3?=
 =?utf-8?B?ZGRpcE5YRnVEUnRzSDJSbCtFRWFtdmpaaUtoWHBQZ2xhclJmRnJtSzFtRllo?=
 =?utf-8?B?V2hZV0Z2cm1OZGhYSTZjb1cyQk5SWVZtczhmeXZvVzlmRkVZcmduNnpRUFc4?=
 =?utf-8?B?MzVjd3hjY3ZSb1dzVUl5M1A4MzM0UHNmVTcyRFgyYjV2Yzk5clZIaWRHUC9E?=
 =?utf-8?B?a0YrTXk0ajRCYWtFOSszcFpGV1FCMXdYSlFpeUd5QmZaWlhacm1USmxpbWx6?=
 =?utf-8?B?Wmxrd2lJcUhwNGwvUWQ0K0FvZG5scm13aUUvT1ZMQzgxUXM3YU90MGlKZE01?=
 =?utf-8?B?NWhqWUNKSHlEcXJsTU9qWitoV25QeTc2cVBwUmRNWVExa09ubUwzaDJsZk9R?=
 =?utf-8?B?U3JLSUd4T2VZTFQ3a3lXNHNqQTZ6UXp5N3Bnd1ZrYlIyUHR3Sm9icFJxald1?=
 =?utf-8?B?SFRjUW9UQWJieUxwZWJ2UVpoWlo3Ym43ODhwRDYvN1JxdHZDOVQwYXlKK0lF?=
 =?utf-8?B?c01LK3RrNnZsNXlMYU41ZjRvS3B2OStOOFJ5L1d1MGZxTnNQZUdBem80anBY?=
 =?utf-8?B?eEUwR1FuM3ZLdHdjS1NnQ0xtb1Q1OUIyb1JNUjJZTjEzelRUM3N1Y3poUjQv?=
 =?utf-8?B?cGQ2Y1dKdE9LL2tFZUhrMzltRGE1dHRXVzhaQlRBaldLR2x6NmhISzdxYTRU?=
 =?utf-8?B?aW5URlI4Q2lJVDgyZVZ6RHV4TzAzb2hsYlROSUt0VjZSY09MZC8xUjFuVlBz?=
 =?utf-8?B?VGQ1L1FRaGVIb1p2ZlZscGYvaEk0MGVYa0RBZG5SREx1eVNXazNsL2w1MGJU?=
 =?utf-8?B?dklRdVJYZSsyWUhqRktFT0UxVUxSMjFyNmYxUVZtcDBnUTVTZThRYVVHYXRp?=
 =?utf-8?B?U0lGSVdwYWxtaFY3TDJVVXdmOEVGUEFDbThGejViUjJuRXpOcUhTN2Y1M3Jk?=
 =?utf-8?B?aFY4T2RPamgyd2lubFJ6cklDWVJNWWxkb285eXB3ME5lUmVPWEpwbDY4cHJD?=
 =?utf-8?B?ZFpsSWhJRWV6N1Rod3JCaFZpRHpoTk55Ti9tUGRwYXhJZzYrQ1VCZXV5OUwv?=
 =?utf-8?B?eDZuZXZyNmQ2M3U4Zmd1T1J4OHhLbWJ0UVU3V3Zsb2k1RURBOGlQRWN1V1Rj?=
 =?utf-8?B?cHFRdzRyeFp1QmsyUWdTVjVyZGhGby9ic2wwT2UxZ0NLMmx0YjhPaXhkYnIz?=
 =?utf-8?Q?8DYKB35nOI8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b09xbUgwbVEzbkhYK1dFYWhxWmdNWURoQU1HRm5KeFZLL0JHZkZ0UTNPSkdV?=
 =?utf-8?B?T2dlRURxMDB6L3ZOMXdLUFlCREhKQkF2RTQvanIxbE5CSnZBb3YydzJISUVN?=
 =?utf-8?B?ZTV3MnpvbWF1N2VzOGh0L2lYZ0pQM0JNTElnQUZJZzk0dk5OTnN3eEh4U3dY?=
 =?utf-8?B?Z3lQUFR6dDdEMW5GSXdlUGJJeTdDNEJpOXZvQTFHblVtcHhldjhXYTNSNFM3?=
 =?utf-8?B?THVsV0RmQkRxM25Fa0xpWWduOVd0Q2VVaEJRSnlPRldKY29oMGRQR3ZuUjZE?=
 =?utf-8?B?cFN0UjAvdzZ0MEhNVHArSzFvZ0dEUW5xN2Q3RTM1YUptMlplRlJNT1ZqWDUx?=
 =?utf-8?B?UndHV1NaYUZYd2IvTno2Ym1Hcy9mSGVBaHZBVVpVNEoxMXdJR3ZBYUZOYmxr?=
 =?utf-8?B?dTlTK1Nmc0dqRDBLSmh4d2ptdFRHcGJaMFlvRGFpWklVS2JtSHMvNXlHNFNS?=
 =?utf-8?B?OFlueG9LREc3aEtMVnBpRDRqWHRwbmtnajU0ekdPcEE5TXVUSGE0d2NrZXRU?=
 =?utf-8?B?VXZHQzFCOWJQUDVoT0d3SDJ0ZmZCMHdvN3RlZkpBUVFiaDVSMlpSbTRlOGVh?=
 =?utf-8?B?bXE3ZFExOWQvbVFVSTlRdldLOFRvbUVCY3czMW1uSHozeWw2K1hnYTh5UWUx?=
 =?utf-8?B?QVBCTklUVHo1aFJFbk9LVzNuYWRVTzB4a0Z6ZXpDSWhac3ZDbFh6Q0lTSERu?=
 =?utf-8?B?RUNMakh1Wjc5RnlyUXBHb2d5Q3c3UmovRDk0M2g5elhMdkwrb3BTTGZNdjVi?=
 =?utf-8?B?MldObE5SWGJuRllVN00yajZ5R0tleERpUGVxc0FuS29TZDZ4TTdLQUYraDBn?=
 =?utf-8?B?ZldGYlFxbmtTeXVlQi9lUnBZQkpqVzlKeFBLdVU2RThoOUV1MWc1Vlc4SmRF?=
 =?utf-8?B?NWFpZk9OYzZybEx0OVhOdlRxWFQ4N2RxcnlGT1JhWkhnZEhkU3hDUXRBNGpq?=
 =?utf-8?B?NUMxVUZjb0drbkM3M2ZDWXNlMFR6cXRNbVJnRUtRL1NlUENsTHd4VnlTM1dJ?=
 =?utf-8?B?UXA5YjZ0MG14VEthb0V5aUUvaWh1WDlaZXV0cXhEL3JKY05nTEM1UklhZDRs?=
 =?utf-8?B?aGdCN3dHZ1dpeWZGMEhGRXlPM1dXck9JdWFFREhRMEJqdTlOQmlaaHZlQWNx?=
 =?utf-8?B?VVZpeHdMSGNXMHNpZDEvZ3Axc09xck9OMjhaQ1BpTTR3cDIyU1lqMm1YWmFt?=
 =?utf-8?B?QmJWT1l1NFRKSkZSTVFWNHZabi84VHFKTFdpNjZoUVVXWHg0b2tTRjNWcXpE?=
 =?utf-8?B?QWRjcXBoRFlRWlRBNFFyYXk2QnJ0ZWM2TVZxYlYxM1AwbTJDbWNjVlA0cEtj?=
 =?utf-8?B?YUJJK1FRSzA1WVd1cHlML1hxVkRJMXNWOUF5WnBPcmJVcGdqaW5pSEJhRFdG?=
 =?utf-8?B?KzN0QTIzV2Uzdm8rVnFzbnhxTklxVjdNVVg5QkJYZXdhZFRBOWNVV2ZXNlBK?=
 =?utf-8?B?bTBYcTlNVGFvalVheHAxWmQ4akU4NFlvaExGRWc1NEtVeHJMMlZXTjN6T3VN?=
 =?utf-8?B?dnRJZGQrS3YyendTQ0ZtVytuUmVNSFZ5YTdPWkJrb25rZEVJUDZFeE50dmEv?=
 =?utf-8?B?Ym1yWmVqOHBBSWRGWDVnMWNJSUlRN1M3N2ZIMlB3bE84ZnVyWnJXK254N0dk?=
 =?utf-8?B?ZkxvOE9lUzZhS2szVDMxL2RRRHhOYndIK1FpUzJDY3pIbW1GUENBb3RNcDR1?=
 =?utf-8?B?U3FzVmhYZmFDNyt3M0xRWWlYZGFMMVI0QTc5cEY3dmdPUjVMQk5zV1JyemdS?=
 =?utf-8?B?THVpOFlGaEhVN2d2aTM4Y2Uzb0gvdzdBOFFpbnVRYzgrMWZMWGVyRlo5cXo4?=
 =?utf-8?B?T1FMWHdvalA2VTNMb2kvLzRYMERMRTlLQWQvQTZKWHNvWS9ieEFOUGFmY0x3?=
 =?utf-8?B?cEVEWFlDZkFlYjhyUk9Pd0pNa0RYWUVGU3hhaTk1blN5N3ZDNnNETUIrVXhE?=
 =?utf-8?B?YkQ4c1Q5SjAwd3I4WEpJRkNWc3F6RUdtbTJIZnI2TXZUZTNoRzZUYlZmbjBG?=
 =?utf-8?B?bVZYd0VXbjBFbmVLbG1ST2V0UzEvN1ZDd05CMjRsOTNEcTZVcjNOaStPK0JS?=
 =?utf-8?B?SXNEQ05EZjg2b0tKREQwOXBJZUp5eGQ2QW9WNnI1b1pmMVAwRlZmUkhFTjN6?=
 =?utf-8?B?NUNYV0VBWWZ2WTliMXdCUUFMYjl3MzYzVS9nYTB2TEVIY2pVRTh5VnI0dW9J?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75acbf77-08f6-4f05-d3a6-08dd8284c5ae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 16:34:52.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBCkEJajNdIJGioMmCGGp0dsfOwL20kp87zk5KncZJIWlQeVr3/Pm1THl0gqgEPliUOZDjZqIogZDN+J+gzvI6xSChmCJ7e3MwKTxbghl3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7680
X-OriginatorOrg: intel.com



On 4/23/2025 4:20 AM, Lorenzo Bianconi wrote:

>> One oddity here is that the structure is not marked __packed. This
>> addition of a u8 means there will be a 3-byte gap on platforms which
>> have a 4-byte integer... It feels very weird these are ints and not s32
>> or something to fully clarify the sizes.
> 
> yes, you are right. Let's hold on for a while with this patch and let me ask
> Airoha folks if we can "pack" the struct in the NPU firmware binary so we can use
> __packed attribute here. In any case I will use "u32" instead of "int" in the next
> version.
>> Regards,
> Lorenzo
> 

Sure. Also, if firmware already has this layout fixed, you could add the
3 padding bytes marked as reserved to make it more obvious they exist
without needing to remember the rules for how the members will align.

Thanks,
Jake

>>
>> Regardless, assuming the correctness that the unofficial firmware is
>> only available to developers and isn't widely available:
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>
>>> ---
>>> base-commit: c03a49f3093a4903c8a93c8b5c9a297b5343b169
>>> change-id: 20250422-airoha-en7581-fix-ppe_mbox_data-56df12d4df72
>>>
>>> Best regards,
>>


