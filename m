Return-Path: <netdev+bounces-102215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E99D901F19
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113BD1C2082A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFCC768E7;
	Mon, 10 Jun 2024 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhD2JyKq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA415381B
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014728; cv=fail; b=Cl1o9DgnG3ABIQuHtJOAbfwjSmH8MTdjQspPHOzN3crek0c9sI/mvtgiGKNnkD6WIJUNx2W0tMVa3J16OEQ8WEVj5kEzukFrB3z2B/jCaRvHWSQLokxG9zF5mm+xfSIIDCLLYovox8/P7SSFGaf/KOXEGz3gnbyzDVArLfWHfPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014728; c=relaxed/simple;
	bh=kCGBtwwOuqkkCf1zsCtxtq4NiNHcai+bZQfzPBTxCqM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YkX7KIDVVkZuXGm+TCaXoz9JfXw4BA3rQzjaNNLlX7MIqQOOzR6+UBewb69R1CWqD/5TQggZXBKjwr+4N9LWRKm5o9xhvNY2CLHTfY6DmTHC23U2FbYHKRNZX6b5uFtlRNk3hGRP6KtyA7wpjrl+QsId9Oy4GZltE25mshbIcYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhD2JyKq; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718014726; x=1749550726;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kCGBtwwOuqkkCf1zsCtxtq4NiNHcai+bZQfzPBTxCqM=;
  b=FhD2JyKq9T99SVjuC37bjGf3BHuioj1ovNlxbx0vent4wHojGwADKN76
   EWiSpYUk5hsH0evMqrG5QW5wmy7t3W/Ku3ezUWYVy0xnBzB7tsGTvRQtZ
   n3fH6pFIXqQ8gOyoLBbUdKbN738nsMuWc5frlCGrFgKftJbTY+netolWn
   llpIHzjTaXLRBU6tkoPhdXAFNWpNys12Oox0PbzKO61V9+zDcUKCAwsEz
   189FfplVsXj+mrQIaU1/jE6w7OfDmwvUGNUKZbEtiC7sRZX/7p2UHeryP
   5ICvEeS5ozW4RF7MWvzkwV+vgwilHNzQmiNGdYN99cL8mKcQlMnQJgRV7
   g==;
X-CSE-ConnectionGUID: hQQQUAqmTHGf/tw3KDVb9w==
X-CSE-MsgGUID: SoIb6iM2TC6WI2eI7yGVAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14462085"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14462085"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 03:18:45 -0700
X-CSE-ConnectionGUID: i3wymDzbQzm6ootq1Pq4ng==
X-CSE-MsgGUID: APsW0iLuRd6wU7XNQ5YUbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="38945732"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 03:18:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 03:18:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 03:18:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 03:18:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVqZRP+uqishyu+ti1gqCE3ERjajbTD2kVkr9TEh+boCF52JSgyDLGxn3XCiONO+5oAe1TlQCmv9vLAqK3ujukkEuchm/LUNSvLOvW1DzgwVfxuA9IGLWAObnQlawQPVsbxPB9g1EXHgAo0yz06XXIv+S11YNif7ELvN2lSAtcuhN+b9MVeSVNtiFXz34gOgvBFF5M4PJbjBLzU2ijk1M0xjjRjc03RKxwnYpB5nHhAKBpkHmthiHZeubRNra0fBbSUS705PxMnNtkKQoYx3ZqYJBPK22qkc+kBLvjfw3GGgxGZxFIdd88lBmCcxOMfNGPLZ8FkRvnhA8JmQoCE54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39OykcJnJsiXkoiiM2Sve0C8EtGFIrrCWKNJaNNMLpQ=;
 b=dsq/RzCSdsd0e0K9peIUwWpjkto5qvbE4xIVkOLQK2qyBGzoaq6ZtvUK8rOyURGrhj0ABkey7heascwoQmg8rR0pgFENhPFeljA41+esCITZTnCgvXVO6eUWARnY0WchtH+8zJ6k+9qKhfNL4CQbWT/s9T2tMdb9QwnS1axgC2z5kK6P9dHLkIeiHJKMXh8NU8wFKv41g5LLOCX9K+RmMM4JJ4Rw/mzpuOO9p6KxjDwerrmf1NouATuzEpf5fNANfbfXTqc47kqAA9fwXJckU4U2lvuc/88zHrzp6VmvFlUX7I/8dxCl/URuaMhHbEzpZTMQbUY7KO+MF/HyUHhreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by PH7PR11MB6954.namprd11.prod.outlook.com (2603:10b6:510:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 10:18:31 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 10:18:31 +0000
Message-ID: <222f6e70-b54d-4fe4-8376-1940989b5d03@intel.com>
Date: Mon, 10 Jun 2024 12:18:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 01/12] virtchnl: add support
 for enabling PTP on iAVF
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-2-mateusz.polchlopek@intel.com>
 <20240608125530.GS27689@kernel.org>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20240608125530.GS27689@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0166.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::13) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|PH7PR11MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bac53f7-2001-47f0-b1ea-08dc8936ad9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjhNdUNack1LMWd5ZSsrUUI2NTYrR2UrZzJLbkdMKzIzUVAyejNiOHdnbnY3?=
 =?utf-8?B?Z1FxVTFTNkNwb3IrbzYwazh5RnRQSC9oTk5JdWxOQnczZDM1K0ZqQ0NmSG1a?=
 =?utf-8?B?WUlHSkZOdm43VVB5Um1YWlNUOHFJQWJML0pkc2lSSWpYaUV0MDJmQTAzNFhZ?=
 =?utf-8?B?MlNxRWlETTBZdUJvSkxIWWVyYVRLeDV4V0tJclVwb2pxVHF2bDBuQk5EYzRG?=
 =?utf-8?B?RkIyVG5maGNNcHFMakFkSXgvN2lxU0czM0FaRXdzNlBVZng5enF4ZkJXNWZu?=
 =?utf-8?B?SjhzRDBiSmwyWW5xTU42bFFzUXlEMVNoOHlLZ3BiNE9JWStjOHR1b0xDTFNB?=
 =?utf-8?B?dGNLKzlDNlFhUTFVRCsvcVV6YTlzUHJNYUpVV1VpZm1jUEV5cGxqYVBtOTNM?=
 =?utf-8?B?UTNSVGJ4OGxnekc0NnY3VSszM3J4WHVtSVpDVmdub0krdHoxd0trd1VYdHlk?=
 =?utf-8?B?MWh2UEZUZWhXZkdEcUtYWGVjbTNjeUdpRy9nT3hkVDdQL0ZodG5LSG5MdElq?=
 =?utf-8?B?ZFFnRFNjNFJwZ0htWjc1Tkp1Ymc1SzZ4WlJSR2RBNkdNek9CUzkxZEhtSTdZ?=
 =?utf-8?B?Q2xQejVselpaVndaK2JqTHNRSklTSHMwbnVuUnlCY25Kd08rU3V1c3BucUhK?=
 =?utf-8?B?azFGczNzbkVLSHZLRVlGRzhyUHh2SkJhcytBZm9JUXNnYkJOSzRmOFg2NVBx?=
 =?utf-8?B?RVFxZHM5Q0tkZU5aL25EMFR6RTUvMldCNXpFSjUxZ2ptU1VHV3hWcUV2UDh3?=
 =?utf-8?B?citZZll1SUF5Z2VXYWJQNk1ON0owNmk5c0dTREE5UE90TXNyQVg0dzNVVUpw?=
 =?utf-8?B?QU5TUStMTzhuR3d4QW5EVXRxci91NXdPMjZrWjRzTXFQVDUzeHhaRXN0UGIw?=
 =?utf-8?B?QnFuT3R3a2RCMVNWMXVjWk9jOUZxNWlsZ3I4d1cwb0wxRW45MW5MQmorUjVq?=
 =?utf-8?B?ODl4UjBRdG9XMlVkVURvb1JXM1EvVW85cDkzLzd2K2xMaE1vWEh5bUl3TDZ6?=
 =?utf-8?B?Y0NISjJTUHRDazE1QzB3ZGpaT2ZBYkkwZnlzWEw5WEpURWNUWktsMXNjdGh5?=
 =?utf-8?B?MUk2MzlJNlV1ZUc3L1RjTTg3dHIzVU41U0ZJeGlIMHRJS2RRdmJoK0NLZUtI?=
 =?utf-8?B?THdVL2ViM3BUOEhsZW1OekNHUmZLcWpWdTh4Sk9DdWcxZWZLdjJqYWl5di9G?=
 =?utf-8?B?bnpONlZ4WHdHV0FHejVudE9qaFl2MW00NWYyWU9GZHE0bHJXbUkwalJXZnU3?=
 =?utf-8?B?MGJxekcyQUZqYWNGd29UT1VDVXNVOVNhS1QrNXdzRTNOT0FRRVdIMHB4N0pp?=
 =?utf-8?B?Rk5vYWdGSHB3MzlWSTBWUnhaS1BOeGhCeVJYNVJjdUx1d3AwZktSS2VUZ3dE?=
 =?utf-8?B?N2h6SkgzR2hPN3REY2M5OGFleHIrK29sVWc0a1BHbWt2bm1YbVNqSjJIZ3BG?=
 =?utf-8?B?UmdqTjBuWkFxd1F5cGhyb2Z1ajFzL0dpeDNyVzc0RFN0dHR3WGJJOU96VXJB?=
 =?utf-8?B?ZzlHUW5HL3ZDYkRYZG52emJpU3NOV3FIREJxbjZkNlJkOXZuaVVqSHFlejFF?=
 =?utf-8?B?RnhLV0ZsQ0ZNWk9ScWhTL09ZYzdsdlkxWmlPaHZtVmYwNW96djVyZFhsODFk?=
 =?utf-8?B?VGJ2L1FDY0Z1RGdxcDIxWDJwSnJmNEg0QzRYbzNUcFcwbnlIMmh5NmRCc0tU?=
 =?utf-8?B?MWlNallUeDJheW96c25md1Rhdk1OVDhML3k5SEJ1dzNZOUFCeXJmQnZTWTRz?=
 =?utf-8?Q?0O9rdC5A0FWdXgSk4k+kQtSMLfzvQJpcUJwR/NH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm1NWUl5aFA5K0Q4amU5amhSSVNqS3hCODZDY2pTNkdWTmJ2dkpYb1FKQ1hV?=
 =?utf-8?B?NW1xK2FuYUYvQ2NhalZWMUpXdFVaWmR5Y0hqczRuNk1hbXdWa3ZQK1hCTXBP?=
 =?utf-8?B?dXdmb200R2dkajVJeFhuNzlKeUFhbjNmcWtzUE15ekxHTjVOUFlxTFNhNXhz?=
 =?utf-8?B?aUJuWHZWK0ptdVNaRkpFUEppbFZxU3pLcWdoTlVVN20vaUVoYW11UUNIOS9w?=
 =?utf-8?B?UUpHYjdSbnBxYjhyT0Q2RGNjZUVoZ29GMU5KY1JtQmVycVZXRlRXamQ4elhO?=
 =?utf-8?B?cHFtN3hwUjNtU3huU3R2czBJbVd0bmtuUlBVOExNeGs5VWRDSE1SOHlJdzZz?=
 =?utf-8?B?UHhKazFxTkUxNjVxWE5ZQzBoanN5VlQwck1YYTd4YUx6VndNbjhVNkx0c1hq?=
 =?utf-8?B?b2pzTGpXMTgySmpDek4wVXJxcmR4dnJzSnk0c213cTRvT05jSERlci9rRHNh?=
 =?utf-8?B?YXhSN21HZUtLREYyeVVRbG95bzdFQy9QMnNMRHBrREs2WjZkYzRaalUvREI0?=
 =?utf-8?B?aUJXM0RmaG03K3lMRXE4VkFhUFF4TDhXems4SzFRdUpMMG5hZVV3R1JpaWJj?=
 =?utf-8?B?bVREaGJHNlYySTEzKzFvQlgwUXd3bHNkeWVPbVBuR1BaKzlEaWVYM3U0YjRC?=
 =?utf-8?B?c1Y4M0tDY05wQTZ6aWsza3hHWEduaUVhUU5SYWNqYWErQy9XTWRSQlE4MEJa?=
 =?utf-8?B?MnRzbWw5VWlHYkh1c0dMV2FqNDBRTDQzdi8zOHJHS0VXT2s0OFZqRSs4QVcz?=
 =?utf-8?B?ZGFhZWl1eGxNT1pkQkFuKzVLSmV4UHB3dXVDSXZMNURWV3BsdXN5ZlVxaEh5?=
 =?utf-8?B?WFYvSUdGWHdmWHBLOWlNdGE2WFhxbjJxWm43eUljZVJUN0RSVzZuUzk0Yi93?=
 =?utf-8?B?b0Vqb1BsMTBTVHJObW0yQk9vNkxCT2ZLVUJQaG5yaVU1N3Brc2xyNDBOd0V5?=
 =?utf-8?B?ejNKRENZaTQ2Wnl6T3FJS0ROYnFPSEZhQklGL2hMQnY1bHIwTUZ2Yk9qN1lR?=
 =?utf-8?B?Tm42VWIvSUJoL3F4MmFyL0gzWVpFYnlxRE82cDdCK0JmVXlMNklJTDR5Tkh2?=
 =?utf-8?B?OEwycW8wMEIvRHN0VzNYYVY4UVRtMnZNU1FDS2UzY1hsLzJhb09RTE1MV2th?=
 =?utf-8?B?bUVrTVhMbUczY25HVUp4MzN3UFlGc2JuSE42bThqbFJicVphT3BFaTZoeSt1?=
 =?utf-8?B?aVE2RXo4QUQ4K1ZaeVk4RWJDenNSV1hzUE9DQStIRTFOVUY1ZXNBZHFaMGZk?=
 =?utf-8?B?YmgwS2V2bk5oQkRGYWUrQjNxWEw0MVdrTklsUis3NDJhM3gzZWpSbXNsbTRv?=
 =?utf-8?B?YkJYOFZ5akZvb1hCQTFEL0xJTUZXeC9yRHZQZEJidHNyUkIxZHgzUk8rMzEx?=
 =?utf-8?B?TWhPYkowd0hYZ3cwMHVlV2JRd3IrWlR4OGw2T0E3eFlyZ3lHUlBCNG5kTWt3?=
 =?utf-8?B?V2tqNlZDNHR1eWRhY2Nta3hkY2dYRUU5V1E1R2lhR2d6aDJHRURNZHVPRjlw?=
 =?utf-8?B?UVc2Y1kvMDJ6QjBuQit0VDNvNUx5WG9JcnYxY3JVQ1cyRXJybEU3UnF6U2Iz?=
 =?utf-8?B?KzdVV1B4T0gvLzBPbytxRVN6dkhGLzM2Z3pFSXFkcDc3YlZqaEdNM1dVTk5Y?=
 =?utf-8?B?Q2xlbVgxd0Y0c3ZYbkRUUllHbStsVS9XZjgweUIzWjIzbGNMWGMzdXFNRnQz?=
 =?utf-8?B?Sk5NTkR2d1g3MHJlZlRnU0Z0NWx0NXVzL0YxbGxTelE3NlBKaFI1MnkxZmRL?=
 =?utf-8?B?aEJWd0szVjJVSjFHSHhFbmNoRUxwakUwMjd3bmRja0Z0eVJrNW9RUlI4YTNw?=
 =?utf-8?B?R25nd0RNZ0I3OFJwRjA4TzZ5Ni8vSUFwUm5JRVBqY0JRQ055WUthVVJtVVhD?=
 =?utf-8?B?R3NJcFdpajBBSUUwMDRzL3o1OGpid1VxTklOcTVCNlVWbmJ4bHB3OWVJS1Vp?=
 =?utf-8?B?Y1gzMW9VSHZoRjlvOElXeFFwb0RPSzVCK2gvRS9sSkhxQlN6dWYvenhrLzRs?=
 =?utf-8?B?NFZFaXJBZ09uaVppUGcxSks4clgzem9Yd1BWN0dzbjZGeGNYZ1RjNzNMZm9Q?=
 =?utf-8?B?cndhQkswTFpXekllOHVIVTdSUUR6WGhOZ0lvOGtmWUNyNmZURmhQeTFjNmRs?=
 =?utf-8?B?a0pFVG9lRmd4VlRsOThmOXQ2VGdxQU1CcEZTQTUyelp0OUJZaGxBZ0N2QnNJ?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bac53f7-2001-47f0-b1ea-08dc8936ad9c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 10:18:31.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDMuxUxZTSBgPm3T7k0EYkWpizOGxs7l/JYT4V9KXkPV+8tE5HEp5KM3PM3hRjodjfJSh/xEKMYEwOC2bsyKwbmPVvb2LskYb8A0Sv2CY1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6954
X-OriginatorOrg: intel.com



On 6/8/2024 2:55 PM, Simon Horman wrote:
> On Tue, Jun 04, 2024 at 09:13:49AM -0400, Mateusz Polchlopek wrote:
>> From: Jacob Keller <jacob.e.keller@intel.com>
>>
>> Add support for allowing a VF to enable PTP feature - Rx timestamps
>>
>> The new capability is gated by VIRTCHNL_VF_CAP_PTP, which must be
>> set by the VF to request access to the new operations. In addition, the
>> VIRTCHNL_OP_1588_PTP_CAPS command is used to determine the specific
>> capabilities available to the VF.
>>
>> This support includes the following additional capabilities:
>>
>> * Rx timestamps enabled in the Rx queues (when using flexible advanced
>>    descriptors)
>> * Read access to PHC time over virtchnl using
>>    VIRTCHNL_OP_1588_PTP_GET_TIME
>>
>> Extra space is reserved in most structures to allow for future
>> extension (like set clock, Tx timestamps).  Additional opcode numbers
>> are reserved and space in the virtchnl_ptp_caps structure is
>> specifically set aside for this.
>> Additionally, each structure has some space reserved for future
>> extensions to allow some flexibility.
>>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 
> Hi Mateusz, Jacob, all,
> 
> If you need to respin this for some reason, please consider updating
> the Kernel doc for the following to include a short description.
> Else, please consider doing so as a follow-up
> 
> * struct virtchnl_ptp_caps
> * struct virtchnl_phc_time
> 
> Likewise as a follow-up, as it was not introduced by this patch, for:
> 
> * virtchnl_vc_validate_vf_msg
> 
> Flagged by kernel-doc -none -Wall
> 
> The above not withstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...

Hello Simon!

Thanks for Your review - I appreciate it.

I thought about followup series after this being merged but I received
one warning from kernel-bot regarding ARM architecture issue. That being
said I will post (probably tomorrow) v8 with fix for ARM architecture
issue and I will also include fixes for virtchnl_ptp_caps and
virtchnl_phc_time (and exceeded 80 chars issues in commit 6).

As You pointed, the virtchnl_vc_validate_vf_msg function has not been
introduced in this patch so I do not want to mix that. I will create
post-merge followup with documentation changes for mentioned function
(virtchnl_vc_validate_vf_msg) and also for one docs leftover from my
previous series (related to tx scheduler).

Mateusz

