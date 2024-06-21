Return-Path: <netdev+bounces-105659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8C79122D4
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1828C1F227EF
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43E171679;
	Fri, 21 Jun 2024 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkNOhZfW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8713207;
	Fri, 21 Jun 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967120; cv=fail; b=nigcywV0bsU3bfVQ/VLEwhGF/nTZZxLXCG8NEUssbU+wG8ZKckthkY33NqbW8U7KYScsdV2kSD1RAYW+EJdW/rRVJ7x5Irq3Ga5pIgXsxDG8GYTw6fYx4PGSgOfmcqbGpcTAuf+61qQD8NkGcjrtLlPROJjnlCS19uiph3xQCuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967120; c=relaxed/simple;
	bh=HxdU9TZnMF4+HtJ4NCx+z+KgBHVo1OatlN3gg1UbeTI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ivbrEJZJ/RUcOAtiDAUJX1cmFxvynDgx1GVoY//lOmTtL9f634VBYdnu7YyfKHnGMY0F1gzXpRFN15El/Q8r84Djq2u2c9RGSzTMvNRSaQFalaAMaJdijLJYPuuzP7NwdX3JO6bkbgzrspOam3TeBJnfTTWFrhaCwYBNMHflRTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkNOhZfW; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718967119; x=1750503119;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HxdU9TZnMF4+HtJ4NCx+z+KgBHVo1OatlN3gg1UbeTI=;
  b=bkNOhZfWj7vzXpRaN6x6R1uWLsju0OknUH4ODx/QimCuQvUy9D1w1t6v
   rDVquoHYE2U47/+DmM/GWpGtIq3lyqRbPJp63DxDogIQO9oahmCVhcmbT
   0F2e4kVkviZ8w/dZuUAG7Ey63btm8zpgb8b0+qHf5tRs2GOWM/+6u3P6H
   x23Z0/RM1bL+6UO9txl93gltFF7aIAnv7WQnyfPlwPUYVJaQrzLNAmYTj
   S7PvG7oHosgO6ak8lyvQ+oVCCq3NwFSEf2QqERWaUYI1jWXKRoTX4ukYc
   /8LRTuPqNHD+0i8n8mjIgwGelPrYsofO59MgGW0PleAHG14sBqgMX+eYP
   g==;
X-CSE-ConnectionGUID: gCektdJqSu+cByDVQK/kYQ==
X-CSE-MsgGUID: vxqPeJGzQMO9xeVLHz1ujw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15693971"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="15693971"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 03:51:41 -0700
X-CSE-ConnectionGUID: /abSKmrfQ3SWcdl9TN4oIw==
X-CSE-MsgGUID: 2KrJQc+1Rh+Hzb/CLBRVtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="47005427"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 03:51:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 03:51:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 03:51:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 03:51:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOUNXLxJ1mA43l9OBKIKO2jugd87PhcqIaVXoho/qerfMrwAxv3iiwX7clRgJjmYTuYKHupXMhRTr3ttlCoenAja5q4wUuaNk5bZo11H6WpyIhJfkTNWBLG74C5mZB6Ad8qVrpIz1m52q5Wsh7yR0xLY5GcUp+txNo19cX91PlQz1bObAYgVXyIeZlWS4/bwPzp8mLmUc+zq6OFsAztA2Xu1+ddlkCZ4vKxfOo9vsQi9cdGmMmOvShVrM0aDpxJIKGkBdi8JltD3YPNFSIci4RyUBI7wKxHJBwse6V7gKLOr6JR82xr0aGp20i6m0S4PLIHOHA3D/7u9IlFQj93ROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6ZE3TB58eDou05UNk2SK2RxbqnaZ9lK0pDNrzUbDg8=;
 b=cAt98A2+GdhiGCUTCZEPbcUvPK+RL5k/G8tFoPnR4dTFGTF3FM/m3lJyqN6V9aWFl2eBGQeitQeO4UuDSTwwiYteCRrok1G2d3dS9LWoTVhUulVL00GLdly93ISlcbMKQu5ntex/B/wF+5f/GOdkUv+Nkeq8dhm5Dqxhs13RwajAvipEuasY0cc+Um0Zy056uMUAcqZcsJ1FHj3KTYV0ut53TDWqRkO1c/qAh/cz/3FFx2V23yBtXSgkzP+iG2r/3i/Hseybs6FegqHqKNw5LA91ygv+JWYy9YGeDjKw4RhtZrq4tubsXl1qm+pBLCrRg7I1jsQp1SLOGs+2LNu0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA1PR11MB6823.namprd11.prod.outlook.com (2603:10b6:806:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 21 Jun
 2024 10:51:38 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 10:51:37 +0000
Message-ID: <04d70bcd-2210-41d5-97ff-68c0aa5fa129@intel.com>
Date: Fri, 21 Jun 2024 12:51:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: dsa: qca8k: factor out bridge
 join/leave logic
To: Matthias Schiffer <mschiffer@universe-factory.net>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
	<olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Christian Marangi <ansuelsmth@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1718899575.git.mschiffer@universe-factory.net>
 <7fbdc27fab4df365db91defca8037b87bdf49438.1718899575.git.mschiffer@universe-factory.net>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <7fbdc27fab4df365db91defca8037b87bdf49438.1718899575.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA1PR11MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: f030dbae-0e7f-4d96-9512-08dc91e02015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUlZczZyTE5lWm5vZWhPVXJBZUlrbVJvcDZjRUM2Ynh0Q3BHeFlsOEprSTl6?=
 =?utf-8?B?blptREdSWGhtNUE5Z2hsMnpONWlnZjRBYW5OcWxIcUl2eUhuU1QyTlBPeS9P?=
 =?utf-8?B?MXBaVmE1K1VoZG1XOTBrZEtra3k4aHE0MVhXUm55cjZIQUxXeUY2b0J4eEhP?=
 =?utf-8?B?R3hPUHFsbHk4bEFxTlRTT2NoV2ZMS3NBWkNKc0wvdkxYUkFOVytPbGxqdmE4?=
 =?utf-8?B?bE9EeS9oc1Bic1JOKzhwb0NPN25SS3RzYUdCakdSbnhYOGVreXF0S29wWGdF?=
 =?utf-8?B?dElEMTBWd2pncGhNeFUwa3RSVVd1dm9BNXZIcXU0bEpnS3l1aGpNaWVmaW5I?=
 =?utf-8?B?c3dKR01za09tZVQycVhMVHJkV2YxQWpQU0tWRnIrMm14V1N4UERoL3VtbTJB?=
 =?utf-8?B?V3pqd0RuUlh1MVZUdnpyM3ByMzAzZ3R6N3haN2RHcWJmemlhbUxjdkordS9v?=
 =?utf-8?B?WUtSSmtRQlNIOWgva3hIOVl4THNrc0hNcGs0Z05QenV5N0gweUV3dXJkZUc1?=
 =?utf-8?B?QkNSTHM3M1lGbFJpdmwvQmdFTjEzSkQ4Y1ZxR3dISTVnVE1rQ1V0c251dEJP?=
 =?utf-8?B?R3R3RTZ2VHJtdHdoV1hsZlhzb05NM0xmdDVFNUhvMTBHSzFtRmthSjBoRXVu?=
 =?utf-8?B?cWF0SmcyUDFNQno3YWVxSFRHMitlNWVLaHl5R2V1UFdsd1FsRlk4djF0WG1p?=
 =?utf-8?B?Y2xFUnBqbUhlUStuaHlTcW1EU09kUDRxY1k5RE9iNHlJaXlyRnlYN0Z1M0cx?=
 =?utf-8?B?VUlYdDBGbERkOTdubE0wSHJnNENlZitmRHNxUmZFdFhtOEtwYkRLS1dpWDVl?=
 =?utf-8?B?ZlNJSnh6Sk9WOUJBMVdRSS9YbExCWWJrcC80ZGpFcW10UzhSaFBpdlpNUHhs?=
 =?utf-8?B?Nkt2Z1dLbXArUGJMNVY3T21WRmRVR0d2WThXbFdSelFZcVFJRW10aEhhOVNH?=
 =?utf-8?B?cjBRZlJCaWR2eVV1UEkxb21PR0Nld2ZJaHdJSW9oalFMcUZRL21sTFZGTWJy?=
 =?utf-8?B?WUE1SlhheEx0RVRaNzRhSUN5bjZlSWVJcmZRWEQzRTMrTVFHNVM5TU16c1lN?=
 =?utf-8?B?OXNOZURzVEYxZVp0QmluTG5aSWhhM1JrNW41b28zbXU0d3BoU2NKcGhnY2Zt?=
 =?utf-8?B?RzNOYVQ1UytIN2RHQjRGMm5zcS84enE5cWxoWlpDMTFNVzFMUzFKazg5OTZo?=
 =?utf-8?B?YWc0Sm5FMmJ4WnpUeGcwcmRWTmQrVFNIVkNKMlNtVHJHMWhhWWxHSmVoVDhX?=
 =?utf-8?B?cWlkR05yWXN6MStnU1phUHBFQ1IxZndmWXVXWmJtalRaUk5JR2ZvZlhvUXcx?=
 =?utf-8?B?djhyUWNaQVhpQVFOa0pyN3hJbUwzQm5jUXBvVFFvUk9VY3dCcldjc3pkSWVH?=
 =?utf-8?B?c0VhQXYvQTd6TUEwa1czd0tucG1obVZqYWlHTHoyRlhVanptNUc3OVA2Z3N0?=
 =?utf-8?B?MkExZkNSbDg5ZmtrYjQ4anltM2duRjlWcDNodEtqWGFDRjY1T0wyb3duMHZP?=
 =?utf-8?B?SDh0NFpRb3hISWc5OExidnFuN2RZZGZKeWJoMHRGUFdXWFdEdGJMbG1EVEx2?=
 =?utf-8?B?SkJiU21mdDdOR0U5NVhJV2xBM253WGV2L05rTUFhQytpU0dBaXlDbXRsZC9D?=
 =?utf-8?B?RHJmRHRya0FGcEZlTlpoRjl6aGhiTFdyNGJ5SUpUbE1VczhweTZORVp4d2ZR?=
 =?utf-8?B?MFk2L1Rma0xoTUIxT0laMGJ4VGpWbWlPMnI3NnNCZUJWUmYxaE8ydkJqOEdy?=
 =?utf-8?Q?C70JnaLF5kcIePQJPW1EMoU0Zsyi/AEzYEzU/JS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3F3Y2M3enRSajQzNW56K2VMRktIays2Y2RabjhiNElSNGd5ZW5NTU1hN2d1?=
 =?utf-8?B?ajRGWThMcE94d0UwUTgzWkFpazBlak84MUwybVRramRlemxiUHR2dk1JUlVX?=
 =?utf-8?B?Sys0T3E2M0FIRU1ZN1g1WEorNmQ4dGF3VGphM2ErN1YyYjc3ZklOTUtqM3ZQ?=
 =?utf-8?B?VURnN1h4c3hFOE96dkd5OUxwblVLYXpKVFZqZFJvM3A0alZEQlgwM0YvSWJC?=
 =?utf-8?B?ZVplRU0xc0N4bFpSaTlPY1V2VmlRTTdnWU56ck1EcVBHNFVKZ250VlJpVWdI?=
 =?utf-8?B?UEFsR01vRU1ZL1lZTXFuMlhCeDlLUW9zN0RpaUVOSlBjQlJGMHlPRUZIR3Zl?=
 =?utf-8?B?aVZxbE1EUjNiNEVBVHlUTHphV3NUZE5DcXpHb2xKY1M2VmZnQzFpTEpucmcz?=
 =?utf-8?B?KytDbzlFSjZ2MzgxL2JHNnh4TDhEUTR0d0cvSXFpZTk2eHJ6NjlWSGtEK2cw?=
 =?utf-8?B?b1hqUFdpb1NUYTA5RWNxdVpVdGxLR1QreFpveUpyblpxVDJFdTdndU1FcmxX?=
 =?utf-8?B?bEVJSElNY2FNbDIvaERBVHBZZkNCbmUrV2tJK3R4ZW80WVJ6L0FUTUxTT3NR?=
 =?utf-8?B?Z1dCdk9MSDYyejA0UUxaMFdlRUFQMU9pZWFQVmxuSzQ0VWR6VVF5cFk4UUlT?=
 =?utf-8?B?cFJCczZGb2Y0c2N2cE42aFVNdlFmOWZLbUJxSUpaSlVlaWNOWUVzQ056TjNl?=
 =?utf-8?B?QXpmYW1ZaXd2VUhZRFRMWDZmcExJSzV3dVowb1FtTWtoT1U0VUgyTmJYWDFm?=
 =?utf-8?B?YXZVWE5iNDk2V2dITGFvYVZoU2l2RjBOa3JOSFdYSEdPWnhFY0hmTHd0Y1NE?=
 =?utf-8?B?bXhrV0hvYkRIS0U5LzZGcnErZVorNlZjckR6V0p0cmVuVlU0YStheEpUYWJQ?=
 =?utf-8?B?RmNiOXVpOStQNHlzM2Naa0VmalFWT0tFMUJFSk9UQjdqMVNlQlVSa3ZIRmpF?=
 =?utf-8?B?ak12cS9KbHgxYjB5WGl6dU5rK1BGVG5IMEQwU0RBWGl1b0F0d2hWaU93SERS?=
 =?utf-8?B?czNqNEc5aWp0aS9yUDhRSHRWckdFL2U4VXV4aFNTTEJMazhmVXo5WnRGM0FW?=
 =?utf-8?B?OVpOZm5NTHo2UTl3RWJqVHNNa1hpbjZvaHlPdEMrWldIZTk2ZWNvSHFzZVRJ?=
 =?utf-8?B?cFdIMWxUK0p3bmpqUGxtMDJNTEYwTTMrcWJDeWR4TXdNRHpKOU8xNkZGVmJi?=
 =?utf-8?B?d1E4eHErMEdxN2pWeHIvZ2ZDZHVqdUQ5cFV6SGV5Zi9XN1VzK0xoYlNIUHM5?=
 =?utf-8?B?cWx3eWFhQzZIQS9FRHlCdkpRbnNKRmRldjcvUWJIZi9rampWR3Y2NUlpNG9T?=
 =?utf-8?B?ZDlGY0dHSDJVSEh6VkRpTEF2NlY1RlgremVOUjFYQzZrTTIvMkhhZWJqelBr?=
 =?utf-8?B?QXpPaTRjUFh5NlQxT3hsRWtCUHhTM1E0Y0RWTmpuVXdoMjN5Z2cvQXdtNEps?=
 =?utf-8?B?K1E1VXIxdnZ1RmJDUERCNnh6ZHpXbGdGVzN5WFJhU2VuZXR3VTVvVWM5ZCtD?=
 =?utf-8?B?Y2ZaTFJqN2tYZjlTeERWL0R4WFVFWWtrTktQVFRNTXNmUWVKM1JGOHdzUXd5?=
 =?utf-8?B?REJtTmpxUm1uR3pRSHY4ZWlCbTJuU2NCYXI3cUJrenA5OXhZRlZob1RhWGZz?=
 =?utf-8?B?YVJwWnYreUwyN1ZiVjd4eU5iWG1QY3ZCa3FzQWszcEY3RGNtNDdCTlRlK08r?=
 =?utf-8?B?RVhxTWdkS0pwMmRYV0R3aXZMd0FQN3BNdHVBZmkydndIMXMzVDhNbHZBckcw?=
 =?utf-8?B?Y3NWMUhrRWVPaUxBMmo1dk5LQUFZalcweHd3bGhrREdvSjczK28wdHRJTEk5?=
 =?utf-8?B?ME5vWms1MG9hSEVXeTk5Y090ekthQmZYc3BmNkEvVjBEMUo4eDlPWEc3bTRY?=
 =?utf-8?B?RVlKTVVHa3dhM0l4RnFhVXFETVNJWG14ZS90UmFweDhWR0swZHVBelNhclcr?=
 =?utf-8?B?ZlJLUkFDTVNrRzBjU3dxUXR1TVFmck9JdnpNb0hwdStra1NrNC9oV0ZtMzJ5?=
 =?utf-8?B?QmJWcHhWTUF4c1ltdzV0N0daVFh1Zjhza1dwMTlFa3VaZFdFajZ1M3hVQlJC?=
 =?utf-8?B?UlNBODhCN1lrcEFWZ3h5dUFMMitlVmsvY0loWlpUS2w3dVY2dUkvNFpNbXFx?=
 =?utf-8?B?aC85M0NXM2VOVTN6Y0toTjI4R0tOWE13Y3p6eStITkFCZ3pKUVd0YWZzMjVS?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f030dbae-0e7f-4d96-9512-08dc91e02015
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:51:37.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LPBJ25hs4v9fBblCc1dLnzZNjilGZ4QnE4JlEIEoN6ZrjvLHk8bzuqzGNxDaV5WSK6gRwaM0NWpwBbZDFKob7IIiU+hR1vZWCy7C4LXAc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6823
X-OriginatorOrg: intel.com



On 20.06.2024 19:25, Matthias Schiffer wrote:
> Most of the logic in qca8k_port_bridge_join() and qca8k_port_bridge_leave()
> is the same. Refactor to reduce duplication and prepare for reusing the
> code for implementing bridge port isolation.
> 
> dsa_port_offloads_bridge_dev() is used instead of
> dsa_port_offloads_bridge(), passing the bridge in as a struct netdevice *,
> as we won't have a struct dsa_bridge in qca8k_port_bridge_flags().
> 
> The error handling is changed slightly in the bridge leave case,
> returning early and emitting an error message when a regmap access fails.
> This shouldn't matter in practice, as there isn't much we can do if
> communication with the switch breaks down in the middle of reconfiguration.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

One nit, other than that:
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/dsa/qca/qca8k-common.c | 101 ++++++++++++++---------------
>  1 file changed, 50 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index b33df84070d3..09108fa99dbe 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c
> @@ -614,6 +614,49 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>  	qca8k_port_configure_learning(ds, port, learning);
>  }
>  
> +static int qca8k_update_port_member(struct qca8k_priv *priv, int port,
> +				    const struct net_device *bridge_dev,
> +				    bool join)
> +{
> +	struct dsa_port *dp = dsa_to_port(priv->ds, port), *other_dp;
> +	u32 port_mask = BIT(dp->cpu_dp->index);
> +	int i, ret;
> +
> +	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
> +		if (i == port)
> +			continue;
> +		if (dsa_is_cpu_port(priv->ds, i))
> +			continue;
> +
> +		other_dp = dsa_to_port(priv->ds, i);
> +		if (!dsa_port_offloads_bridge_dev(other_dp, bridge_dev))
> +			continue;
> +
> +		/* Add/remove this port to/from the portvlan mask of the other
> +		 * ports in the bridge
> +		 */
> +		if (join) {
> +			port_mask |= BIT(i);
> +			ret = regmap_set_bits(priv->regmap,
> +					      QCA8K_PORT_LOOKUP_CTRL(i),
> +					      BIT(port));
> +		} else {
> +			ret = regmap_clear_bits(priv->regmap,
> +						QCA8K_PORT_LOOKUP_CTRL(i),
> +						BIT(port));
> +		}
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Add/remove all other ports to/from this port's portvlan mask */
> +	ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
> +			QCA8K_PORT_LOOKUP_MEMBER, port_mask);
> +
> +	return ret;

just return qca8k_rmw(...);

> +}
> +

<...>

