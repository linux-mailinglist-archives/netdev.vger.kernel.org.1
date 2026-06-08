Return-Path: <netdev+bounces-296748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 93l8O7VAJ2oBuAIAu9opvQ
	(envelope-from <netdev+bounces-296748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:22:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AC065AF23
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:22:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=nwpPy+tE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296748-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296748-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B01683040F95
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715553B27D8;
	Mon,  8 Jun 2026 22:17:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC03B19DB
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:17:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780957059; cv=fail; b=TGcXp6Vgv51kWmau0cyJ7U+rYopPjhfquiSTYfALk2i0rX6OXUZY0eiGpVMvF+c2Pz0GCO/SULLPibIXWe+53NW0RuiG6wgBbwIUBFAa1ls0Xyi0oQjPz0jvgdRlwHbD5emESzUjS8VB6iwjEDVujWWz+qdOeKGEd29gyXCFgjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780957059; c=relaxed/simple;
	bh=3Ig+v11WSiT+9/J4cB/bNzyvzyrgk61iS2BYqZsBjX4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CKoJxM4m1blp6Qzz0ZpBr8hQWAQbMmszZbGnnWaglWIwIYijW2ECfFrb0qF3Mo2545fTX7j2xSs5BmkzjvuV5/kjQu84r19AEqd3LfqNk4n/zS3Hi05CUMZlpIf8p41KiIrR3+GXaXpu8f681Ef4JaUCmj6D1gIqzh0RgBhkCFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwpPy+tE; arc=fail smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780957058; x=1812493058;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Ig+v11WSiT+9/J4cB/bNzyvzyrgk61iS2BYqZsBjX4=;
  b=nwpPy+tEnlsqn0GV7x4iaBrzILwYmhvTTA+SaVU5+J9jwcmMEfoFnsRI
   p5h5s/Xh36OqxF2A+cbvyo7w2kbGwALvTbqm1lLJRhsOlXzHH6ObxauPt
   xR5ChZF1Zns4jH1dZP92NJifACYHgQP4Dn9wt+/DweQOVRgV+nFrKC7dN
   NJVZVQSx63MQ9BBh3OKs7re8REwrc+A9NtyZ5cqHh3PcaYZQnj6AUyFLa
   dtEsq1Uc7hPYMcMZ0MEYRaPK1JPQs3J1AAkWNKaXPDMTrst6DcjlWLMa9
   3QoHcsjBpc26KWLKd1s3+L6fiDW4AZHHHet0xxPhD3fnm9a49vppZtMGy
   Q==;
X-CSE-ConnectionGUID: GiFVFwh4T5Wku4WLNbdcDg==
X-CSE-MsgGUID: CXBx4r+FRL20hlUgD/McQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="99286917"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="99286917"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 15:17:37 -0700
X-CSE-ConnectionGUID: X/TL4GE+QHiS/3fpb73SNg==
X-CSE-MsgGUID: o6RwXkRfR5CNwgXwZ3y8rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="239338411"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 15:17:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 15:17:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 15:17:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 15:17:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omZ/3fsoupklNUennTfKHwY6ZVPKRcU8xSlgmS4C/91R4LOAIlZ2QY8jxr/15vjSQoNlxaV9ezP6CIBZpOaXQqq9hfJUYVRIcemenSOr7b63RKwQy7Vzi8gkSJaQD6Gn7kjzxHtr7B+aSRTBpVNysNLqqiKtbgKGDwMWfnS2H3zEu5ZmTorEj/wRCcN+OYf0wfj+AFJp0ib0GBL4zwQhsQllRW7NHpC70qJdyu90mNhz4LDZIee1/yPpaGxFjI9Uw0VtgdRe+ipPaMJGtP6Poxw0I0lNppxWfsBHissdLN6CVyZumLZdcUTwTU9gC9wAQXEF3uAzx+EdALK/j5e6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8sF8m6X+B+V9oewLUllCuKfKCuNzKX4DJ2udSXCujk=;
 b=Gxy2wbA3XSHQtBtIwukeXq5VA7hxrGto5ZI4JHov3Ndxx0etX7D0W3kbrYzWhUwYAU2Za4wWZh+QQvW7kb/EaJVm6cy0dqWw2TZZCSI4rH79NPtfc5FDbzg5j/DqHo/HAAXiO6U2VYUWiQjJzpCmHvxbxuzy5IiA9CIDVlhmA+80o82dLCpq/delZSZCSI34wrBfjA5vjaM88wp9KIImetn5rMieZUDZ8e7ZdyHhppEZ4QljeKgvJU1vYCUqyi582Rp+6la3BNQYzeakJF52gHG535cTlnRNAEjI3bYnhgYF3xBtLdUeuA0JMkZvxUyLqwNFjSpPPYclBHhbEaEIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DM6PR11MB4596.namprd11.prod.outlook.com (2603:10b6:5:2a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 22:17:28 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 22:17:28 +0000
Message-ID: <8d365814-e4c8-4820-a570-15b1a5c6fcdc@intel.com>
Date: Mon, 8 Jun 2026 15:17:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/12] net: ethtool: optionally skip rtnl_lock
 in cable test handlers
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <michael.chan@broadcom.com>,
	<hkallweit1@gmail.com>, <maxime.chevallier@bootlin.com>,
	<joshwash@google.com>, <tariqt@nvidia.com>, <alexanderduyck@fb.com>,
	<willemb@google.com>, <kory.maincent@bootlin.com>, <sdf.kernel@gmail.com>,
	<jakub@cloudflare.com>, <nb@tipi-net.de>
References: <20260605002912.3456868-1-kuba@kernel.org>
 <20260605002912.3456868-7-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260605002912.3456868-7-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:303:b8::19) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DM6PR11MB4596:EE_
X-MS-Office365-Filtering-Correlation-Id: 539a550f-ec15-410f-49e1-08dec5abb9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: F4e0BsAFp3lMXWo+GQhs0Q8EbOSIJhsQwkjo2qOjUT0fe39JbKV7mawvFbp0nia4EKj1zCvDCAZknDTGpk74bRG0Th0+P9jkhs/m6v1PbVVT2w99CzHvycP/fiYakgX+2EfqKFk6vVxDSncE9PQrSr3M4sSyilTRw/1iMppgn8QamTkV0RbR+2f3m0LdqL5MxJ8vrJWDoRTQMe5Yi/yeuGpOd3iDYaqovpXJAj4hP+uvUbpp+ON1WwCyIYiZ9LOaFaQSnCU6sH9TqID91qV6nC3dbLewHRRU5buA0i0c3yzXq2bkAP73OqQN+9mcGdwAIfU/0KAd1U7UCYSVxWzgHiiAw22YD1R7ElA6waFWDIzzSWKGtSH43GekYBXdjTQxMdqoJ9YuZQXDTsl/IlptWFCwhLBhzR/2th2ofIPSeRUMP60HKtxLgAxeJPDzOfXzHit/Ti1cVLMeJWn0YGPj8ndL39awNyx7T9b4+KlxbqObMUPSPChnL/uYTpv1Y4oxCVg/KyPkhvxcce1YAPd+ZC7w+6jQEFvhV0vXPjxEUnIto27diFKXbnVLIZ/RXl9bCk3VTR5/fbMVELrySQlTtev6krHhPDTrtEhlBsWlLUyvlNWB0J4xF4Mtv+WTOP0xBCr1m2iqK7H8t62UayMBxbf5FAmKn/KKZmp2J1/euP/4AYsaJKrLSkqI2d7Gu1l3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2k3WnIxQlBuMXF0a3lyZVFQT0lKN0N6Nk1WeUdXSUZPMWVsVGk3amtKUzkv?=
 =?utf-8?B?MXl6Rm9sTGM2UkQ2RTRleW9FaXBXKzN6T0tYQ2RrcGYxVFRRRFByamxTSDZ2?=
 =?utf-8?B?Z2RrQkNhVXlnb3kvdm0vOE14QVJFdy9SdmJWN0dyaDBtdDRub3VUYkpranJw?=
 =?utf-8?B?V2QvcjdsUVRjM0VGeDBleklIdWxISFhMSHhGaFJibnVKcUo5WWtYd1FCYkov?=
 =?utf-8?B?QUh5UWljMkt5QUl1QSt0MmJaam15U1JaNnRUWlAyVEloQWlYT2RyTmdwcjhW?=
 =?utf-8?B?T3NsZlEzREx6L044eWdNZ2FSK2NmRmxXN04zc3I4cThTaDBpK0NuaU1Paits?=
 =?utf-8?B?RitDaytUNmxDZmc3NnRoSVhTWUdERUpyd2JscDJVT0pEY2U1aURFWVpWL0xu?=
 =?utf-8?B?ZXZWdFZuMnBDQ3pxU3NJdXkwdUROMGJ5SXhvbzhkVTdKbXRsWjFxR3RtbVVL?=
 =?utf-8?B?NjVnbExkQlZQYkFYbk53UjlMUCsxeGlXWUsyblZxSmowMFRhMkVhV3VsMHVv?=
 =?utf-8?B?ZHZCYnU3Q0puSzlTTlZTVWFLTjVTM0tjVDhBZW83QWh1OG82RjlxVEk1S3RE?=
 =?utf-8?B?UFh5UkhSUk5sRkU5NUdVVDJqV1lSbTBlVnFpNkdpZFdUcFZnQWlqRE9wMXBi?=
 =?utf-8?B?ZEhZZ3BaYXhsZ29peDBVTGUvenc5NUphVnluMTBEekp5ejRDdURzTTZHVUZM?=
 =?utf-8?B?TndxaTBkUUcwR3E3dCt5ZGFZQyt3RkpiYldLRkZPUFR0R0ovTXhaUy9MR3VN?=
 =?utf-8?B?L0NsSEF3alJDSlE4WkJvcEZKLyt0c3ROcTZTZnlmSzRML1lGeDBDNnoyWkVk?=
 =?utf-8?B?cWZsenExaTQvZ0lzczZJV3k5a2dZL2NKd2NRREp1aTdDVHlBcUVYVHN1bDYv?=
 =?utf-8?B?S0s0MjAzR3VhaDJ3MU8xRW1ja0JiM3RPMzRVSTFMamFsMUZwSmQ3U0c0WjlG?=
 =?utf-8?B?ZHJNMU44YUIzT2pTN2ZQVHhENUtEN2F2YlZwQTVIWnhsRnRRUExsd25DQkxE?=
 =?utf-8?B?QThyaHAyN0c5dWxnYTdOMEh4VFIvdHpLSlQxVE54SGNkRUZMZW5uQnRzNk5q?=
 =?utf-8?B?QkVYVEcraXE2S3hxdHlNdzFBYlEzbUo2WWRuRGtNTkFhYlZmaStpdy80Zmxl?=
 =?utf-8?B?cXFNK2N5THBCN0grVnRVTzdaMHZqMGhvb3ZrV2MzYXRESm9aWkJ3RG1ZK1lF?=
 =?utf-8?B?T2ZIa2J4NHhpZDRNMEttVXZMUGJPcmhDKzFDQnRWQjcrTkgzYmpBZXU4ZERL?=
 =?utf-8?B?WHQ4MGRwQ0cvSUt1ZEIrTkliR3RNeFNHdllxMDFNeEFLcjB1eUJqampuL05u?=
 =?utf-8?B?akFzNzEwQU9rd3RmaEcyN0xKdWlqb0dFaWk1UGYrd0pUSHZUZFVBaTB3ektk?=
 =?utf-8?B?UURpSTlWTklPSU42S1hYOXFlRjBsT1VkNnFYVnpZTGxmeWM2Qml5UXF4bUxK?=
 =?utf-8?B?VzRBVzVYa1BBbEtRMzhjbTFkYitPVysrUGgwZkZxdDFsbTdYT0ZlcW0vNFhv?=
 =?utf-8?B?MXZXVDQ1RnVOUi9xallEY3l4VVlYeHN3TERwS28yc2tKRUo5a0pZOTl2OUlj?=
 =?utf-8?B?WTVZWFdhZUx4dVByMW1yalZiTUNHemVWcU1mcVoxcmVGMXBHcHZPb1JKdEhz?=
 =?utf-8?B?a1pFSGZZeEd1ajlheTgyRTNFeWtLRDNHaklHajFyR0M2QWdvMTVlSVVpK1lk?=
 =?utf-8?B?TmRITWVzV0hPNWp6ekl5b3F1L2F0a2c4UE5wWU5YYXJLc3JnWnI2OCt2aDdG?=
 =?utf-8?B?VjkwVjlORHp6MGJSSVdIQ0g1TCt6MlIzVTl1YUZzaGZVNG1xK0VMY1RDcStP?=
 =?utf-8?B?cG5JZFJQY2NETFZ6RjdmWS92RmNxcHlRVGlWRnNEa05menAxRVlqVTFPWmtT?=
 =?utf-8?B?M3VwclA1Y1lad2lacEhseEhYcmdUdWFhdmp5a1FFUFhoWWtNQllVU2t4cHBj?=
 =?utf-8?B?cHl6Zjl4TTA3REx5SWV0UitCald0ZWx0azFiSkx1aHRFU05EaStxOWFOQ1Rs?=
 =?utf-8?B?S1phckJyOVUwSEswMGo5ZnZQcHdOZi9mM09tejB4U2d1eHdlTVljY01zcTlS?=
 =?utf-8?B?SWNEYmpjVlcrSklBRGRkcldNT0tyUk1kbnI2STJ5c3B2VElkbFUweTQ2U3Fw?=
 =?utf-8?B?OVg3a09nUWZSZ1c4ZFBKeHRmL0FVZlZvNnBrSytzWWZQenFjODFZMUhWU2hV?=
 =?utf-8?B?enhOS1JUTk5RWERPek83UHFaVWpZY3p1WmtrVkJwa3Vhcmhobmp1YnN3MjdR?=
 =?utf-8?B?THVOTVU0UVBpRFczNjlsaS91TmorczdEb1lJN0ZpNkUzRHpNUWNOdUpEVUZm?=
 =?utf-8?B?YkNwWHZ1T3FaeHBHZEYxUmhTWmo5b3RlWFp2UWFUVnBnc01NSVhzQT09?=
X-Exchange-RoutingPolicyChecked: QyHqyJwXR5553cx4spxdVNAqvKy7zuzEevpOcp8cV9zExRs4vg8jpKLizsli5ayk87JzgsGt0bWnm9Nm2ZF8NjJ4/845aQpGhzqlKenkQbYmt42m6YKUcLeFZBgDaF3CDxU2VmcnYHx3LnIfE8pUMiqnXYFlsfMk8PhLdi5t+AWUHtltj/QU5jOUDkVKc0c3LtMZl2YntHNe+tKLQ6w1S4jmIDNuhDDus2BYRKyNthFYAxycaiWl7iDdrx/kNlmBVORUrXQTlWapD/gTPcmWeEGe3Lgq6XrI5kEUgTvGnG9z7u6SmagrUXRfaTAN9qUhtyTnimqqj+x15+iwCkpJBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 539a550f-ec15-410f-49e1-08dec5abb9e6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:17:28.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyX+lOuutf9hp0bx99wiJnH2i9HFu/0OfQHWxBDVdVdnmGD1CXqrCJ/lcOCrWydrY6JwyKHVvl5VU8oLHVuZGSXUXjK3jGdvUc0MRcRlfmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4596
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296748-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,cloudflare.com,tipi-net.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66AC065AF23

On 6/4/2026 5:29 PM, Jakub Kicinski wrote:
> Skip rtnl_lock in cable test handlers. This is really a noop since
> no ops locked device supports these.
> 

It would stop being a noop if an ops-locked driver ever implemented
these in the future.. but I can guess that even if that happens the
cable test bits don't really need the global RTNL serialization anyways
making this ok.

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/ethtool/cabletest.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
> index 8d375dac2a40..9c22d4c767c6 100644
> --- a/net/ethtool/cabletest.c
> +++ b/net/ethtool/cabletest.c
> @@ -73,8 +73,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
>  
>  	dev = req_info.dev;
>  
> -	rtnl_lock();
> -	netdev_lock_ops(dev);
> +	netdev_lock_ops_compat(dev);
>  	phydev = ethnl_req_get_phydev(&req_info, tb,
>  				      ETHTOOL_A_CABLE_TEST_HEADER,
>  				      info->extack);
> @@ -101,8 +100,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
>  		ethnl_cable_test_started(phydev, ETHTOOL_MSG_CABLE_TEST_NTF);
>  
>  out_unlock:
> -	netdev_unlock_ops(dev);
> -	rtnl_unlock();
> +	netdev_unlock_ops_compat(dev);
>  	ethnl_parse_header_dev_put(&req_info);
>  	return ret;
>  }
> @@ -342,8 +340,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>  	if (ret)
>  		goto out_dev_put;
>  
> -	rtnl_lock();
> -	netdev_lock_ops(dev);
> +	netdev_lock_ops_compat(dev);
>  	phydev = ethnl_req_get_phydev(&req_info, tb,
>  				      ETHTOOL_A_CABLE_TEST_TDR_HEADER,
>  				      info->extack);
> @@ -371,8 +368,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>  					 ETHTOOL_MSG_CABLE_TEST_TDR_NTF);
>  
>  out_unlock:
> -	netdev_unlock_ops(dev);
> -	rtnl_unlock();
> +	netdev_unlock_ops_compat(dev);
>  out_dev_put:
>  	ethnl_parse_header_dev_put(&req_info);
>  	return ret;


