Return-Path: <netdev+bounces-121906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6830A95F2EE
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF66FB20AEA
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83214D44D;
	Mon, 26 Aug 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBQ/7HRM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3040855;
	Mon, 26 Aug 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679052; cv=fail; b=ZsJH+JYd6NEC3/VgwW5+7cCAeMU84wSkb4Yu6rQ3J2ECiTOtwIdsCK8lFqAU9IZ2cvznk51n2SmiN0lC9GCzwxEJCsDcOkoymIGVoTyMVw3xX7cRO4iHQyIvngBNaDimmqN8H9VG0byPsXzpjMsvSvoM8qb3uako6WrqCkj10u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679052; c=relaxed/simple;
	bh=9bfg1NyZlHafawqEeqkeyu5h3TeRlD7zWjAAmPOxbMU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ObfsOsBAWDGGeFO5hAD416EVDMRK+BytWYGvu2UMVi9gMn7mzdtuJeqwL42ZE6L9iMgI4KDpnP5nS8+qhcO4UGNZvZd34VcK2mqQ3fSc3EpFweso/u8aZ45vf4yL+5mED3PwBrwCyimvKNCjOT5uRdIojYnGjdN1DsMfkAXZvb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBQ/7HRM; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724679051; x=1756215051;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9bfg1NyZlHafawqEeqkeyu5h3TeRlD7zWjAAmPOxbMU=;
  b=eBQ/7HRMXiva/CkKtBQWYGBXUo7IQAk3dwT392w6C9wTcJEyOZg9woKb
   wS7Ik8qlxnxvXZbv7MVk1xulW+DkOwckpnxkWNT9D3wWT1qwlBoPYGiFa
   rejq0twa/f2da5pb8hnRMlbdf8pkII/tLEorQ8+Ck3TTZVBgsZgj7jn7b
   y62hQlcjFt468QasbcbHw2XNs1/Gl3C2Ht7cJScSN56PQVV5G0RaJg4Gu
   3014VuoWrSSibuUG4gh9eJHnaUj1yWFY05Sl9akHZwO4Z01j2oWwM+f/o
   0gadCZ7pLQeXK2fK8SxFAZnpJH31VKSdBxZSQOtUD9OroCKOmopBo4QYy
   g==;
X-CSE-ConnectionGUID: Z/gAYiQWSjqJovLLbCd0UA==
X-CSE-MsgGUID: 1PxDu1O+RNWjSwXexo9/BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33765890"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33765890"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 06:30:50 -0700
X-CSE-ConnectionGUID: y0vE+ihySIKa2hJqVShFLg==
X-CSE-MsgGUID: t7/0wpCHROSWyK7C2BkW+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="66839748"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 06:30:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 06:30:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 06:30:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 06:30:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbEFry2X18IwioBn+7CKLYiAMw2BiYWcc8dAS/S+l8AwTSamtmK7aK8xdOqbrmfTMiQrZRAduiCEZJcGywuJ3APZNgxgiBJw4mZZbpsZp3n12+D3tN+XSQMnw4TmhMQzAS9o5t+rsb8THPQh7nYGAKZ04nG5O9/3QgczKhjvKrryzMwLkasSCyTZ76gIbge5/HHuqkAXj6SeXvS4/5UvgUEfd20ycFYjM5FhzudOO0Q4Tx1RX6LoscToL5Luoug+83vBnF4lnEC6JCnaE5SWeH1DA9LpzWa01fHP2BHBx8qQ9TlIm60OLaQOUuYx8aTbz7XcrqsBJGbysB6qFf5aRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0lQO1LQYDdi6HnMBevPfUUARrH0UxDkxQmURBlpPiA=;
 b=pACVZ7kuW6qOzo6iRr3Uk8XjWBFAlaY0R157kw0XB49ePs5ggNyKpgUcq2NVX74eFzqufowJ9Gq8LMMX4GgkNh25iGPyyRcYf3AgXa7L8X4qFLT3You9ZFvbj6kbPTOxrDUKJPL8BCM0THAhmbC/maSy9lETgDS1SUMp8L8D60FG2wPZOuu9lQKuY0U7uVjb6p3ZUFjskgRzD4CnXtMXazyfeYb0Xv0OeDP7GaTtPmYLmzwfHFWA2OasE9777VRKhETiNMosGXCf1yo5ByRrE8vws6nUfbNa8dGASUqbgU6K+7LM45rLZ63sPyR4hHAmTlAhRHkQFwqQhmC8+p0Kyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY5PR11MB6344.namprd11.prod.outlook.com (2603:10b6:930:3b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 13:30:43 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 13:30:43 +0000
Message-ID: <7eed6937-bb9e-4ab9-9df3-acf8cb9083ab@intel.com>
Date: Mon, 26 Aug 2024 15:30:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethtool: fix unheld rtnl lock
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
CC: <edumazet@google.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <kory.maincent@bootlin.com>, <o.rempel@pengutronix.de>,
	<maxime.chevallier@bootlin.com>, <andrew@lunn.ch>,
	<christophe.leroy@csgroup.eu>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-kernel-mentees@lists.linuxfoundation.org>,
	<syzkaller-bugs@googlegroups.com>,
	<syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com>
References: <20240826130712.91391-1-djahchankoike@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240826130712.91391-1-djahchankoike@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY5PR11MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce27ebb-d486-47a5-bc60-08dcc5d348c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVU4WFVBZ3gwY2NwSk92dHZQbEZDamdSSjJaeG1aVVp2TllXUjNSTitFUmlY?=
 =?utf-8?B?aWUwb2I4ZmhEb1dHanVRSWY0L3Y1b2N5US81TzlCMUp5Z2JBbjc1ZlY5ZENY?=
 =?utf-8?B?S2dQYTl3dG1uZEdybGVwcjNPOUxXMUs1U0Z5Y2hrM1NDV1l5TU1YU2dMM2sw?=
 =?utf-8?B?clI3L2JDdGRxVUVjQjVsYUpHNHJnZWlKWTBxZ3Z2WFZPVFdZVng4enFxMnlu?=
 =?utf-8?B?YkRGTDZUcWJNR0dpb1R3Mk5qdzlJUE1lcGFZZnRjcUpreXkranJ2WEgrUnpW?=
 =?utf-8?B?RVkvT0RHcGJCNXAvZFJTWkFKL2lrUm5HTDlwTHBDZDdXbmc2QmF1NWdkTEVj?=
 =?utf-8?B?SHhtSnhHdmhEcGZyU2JGQk9vc1JySkVYRTVxUTNVMnpneHlvQXdhcHFaMFM4?=
 =?utf-8?B?REFwSmlQd0hGd21CcEhKWStGT3dWWGFpMUJuY0xDRmdVMzhNTVEybEtWbkwx?=
 =?utf-8?B?UVpjdFhpa0Y3SVhJV2Y4R254bnNpTUxhRndWM2I0R2pqT0JWeTJ2VFBqQXpH?=
 =?utf-8?B?NDUzYUZ6OHJtUmV5WW9GM0tDRzZiTFBYMEIzeFB5M2FsZEdqYkU5ZXpnYVIv?=
 =?utf-8?B?aW05SENLT2dBMkdEbDlsNFBuVFR4TkIrTVNVaDNwYzNHbVJEMFc5aHpnSDF1?=
 =?utf-8?B?UzdNTVg2K2xiSFVrVW5vRG05d0U4T1VrRWR2eUVuOVkzSHZpaUJhSEFBTjVl?=
 =?utf-8?B?WFQ4R0JldjJJTVF6MkF3WXpvc3VJUmxBZy8yMDVzV2h3RlZWc1dXb0xqZDRQ?=
 =?utf-8?B?Z3JRdnJuQlcycnNjUXhvSHlVV0E4OXNZL0lkSDN5U2lWbm9UNFpSRENzK3FJ?=
 =?utf-8?B?M20xSTl5Qm5GUnFQWUsrbUlaRUR0Q2pYZjZkcVpORkpsWEs3UEYxdjFlK3R1?=
 =?utf-8?B?TEcwSWVRWGRLOC9RQTUyUW5VZXN2aWlYU1RuTnUzSytDa1RhQWV2ZzNFZHd1?=
 =?utf-8?B?dHhIMThjVCtSS05leEFuN2NsTmVSTDlSbFJoS2ZzSlNDM2svOG00M2NyUmJM?=
 =?utf-8?B?OUExQ3hDdWJ1d2o1aEdueXVIaERsSURrYTJUWFFzTVM3eTEwSDlFMHd1ZC9E?=
 =?utf-8?B?cUFFcEU1TmZDTEtnUWRwWDR2Q2tPT3dZZmdBMGZTT2JiWWxPdWtIK1BrTXlX?=
 =?utf-8?B?QmRCZHliNWlqb0hyc1VqeEFXbUY2b3NneFRVY3dvcmdpNkhzOFU3a3U1QlJq?=
 =?utf-8?B?WWMwbi9DUjMzMkVpZlNLVVpIaEJnM0NOWjc4aVdHamZWTGw0Tldod1p3YzlS?=
 =?utf-8?B?VmFmUmExL24xVmlubWo3cXNOUGNZN2xxWkNXWUtqeEFxR1JhNVhqcVFUK0x6?=
 =?utf-8?B?Sjh6VlcwQm1uTGlqd3pNOWIwSEpoRUtFeEJ4UDZFTndBVTcyejFCaGFKWVBh?=
 =?utf-8?B?VDRkbXErYWtYc0gzRHBYU0hWa1ZWVXpUakQ2UFQvNmIyTmNrU0hSbDdyRVAz?=
 =?utf-8?B?dmhuZkVhdGRRbVZ1NHhIQXhBRnRjeWl5Yll6S29wQVk1d204dXZpVUdENkNR?=
 =?utf-8?B?dDk2TVlRM1U3bGxoNUxlNm5WY3l3SXRCeSszTUNFZVNJMnhVcXBLdzEzN0kw?=
 =?utf-8?B?elV6SjErbDhYcGhHYlFaRGpkU1pUUFNBb2x6SnJNTlpLN0MwcmdKLzNFZXI2?=
 =?utf-8?B?OHJodmdpRkVYdDdPUUxlazBpQnpIZHM4NEx0QXdZenIzN2d1aVgyZWVFYUtO?=
 =?utf-8?B?dUw3TURCVlMvbFgwcmY2bmkremt1VExxWjBrblVHMGt6K3VxVnFDNnptdkl3?=
 =?utf-8?Q?evClo5PVMCEQ7cf7X0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Slg2VkswOVNUcnJucGFteDlsNmJ5Y01tZU1zWUFYN3FvRVlQT1VlQ0t6Lzh6?=
 =?utf-8?B?czBoL0pwZHIzVGNubmd1SGdpZFlINHovUHVDUVA5d0FYTWY5K1ZmNmtacHg5?=
 =?utf-8?B?U3dKZHA3MTlkc1ozbXlqZkVGNE10b3dHaE1RcnpRaWxjL21ObzJCTkxScEE2?=
 =?utf-8?B?eGpVY0NkVzdFbm8rRDFxWU82SkdUOHpKMndDRFhtVFhXZXNUWmMwNDA2SFFY?=
 =?utf-8?B?ci9xemZlRWpRUmFMcDMrVzVlcFVVb3QvUGh2MXQ0MitDTnlCV3h4UHdNWjZw?=
 =?utf-8?B?c1gybTFvT2RDelBTYmxrOTB5QlAxK3VxQmRDT0MwbVNyV0ZaT1J3NVk5NThP?=
 =?utf-8?B?TTB3Rmp3OWQzYlUzbWREbjg3bGEvYXZXTlJ1bjAwTTQ4QU9yNUh4dnl6OTFI?=
 =?utf-8?B?NE8wV1NKeHFHQWpKbndROTRGWjhEQVE4Y0lIZmM0WnNZbkYwNE9UbVpRcnFh?=
 =?utf-8?B?clhISFhWYzhTOURwdnFRcVh2UUJmc2JZV2pkRE10K2ZGQWhNMWY1V0pZbkIy?=
 =?utf-8?B?M3ZpTDNraCsyRUlDaW9JNElEUmFsc05WR0xiS1RINnQzVmdmai9GR2I4NU5R?=
 =?utf-8?B?K1ErVmlDU1o5YTVtK21qazFRUmdGdTl4WERzOW9nWHBjU1Y4VzAyL1d5MnUz?=
 =?utf-8?B?UEhuNGJYNUxMaDNjYmltcDFwVmNQQUlzV1IveHFlWWhRRmVpcG9vQWF5SnBp?=
 =?utf-8?B?Y3FCNVBhNkJNeUROY2lmMG5Ec1k3dk13WkVBaXJBR1ZPQ1hMYXUzVkpkdGNB?=
 =?utf-8?B?R0E3UFZ0T0RtNVVJbUFzcVh6aXZWSlh3Wm8vVExCT1kvSjBENGIzNW85bWxj?=
 =?utf-8?B?cWttQ0NQSXN5WlpqUDRzMWo5TG5VOXB3MjFjUzZrY3NyRWhRVE9INWFqeWJV?=
 =?utf-8?B?VXlZZ3huWE5COXNqTnRkbW93ZUcrUE9UOEZCNUpDK0Q0cHpVdFdDZjBNcTRq?=
 =?utf-8?B?MUZmRlBzT0hEdjgrTzZFSTZCL2FzdDJOaXoyUURpR0l0akYxRDkwUDhnK3c4?=
 =?utf-8?B?SW41cGg0NWdDM2p2N0I4dlBEM2pBMFRtL1lNWUVhcGpLRmpUQ2lIR3M1dGIr?=
 =?utf-8?B?VmptZjgzNW9DYkUyOTFDWEJjWi8wbGQ0RXorMXhaZzN5TjdPVU81OEVSZUk1?=
 =?utf-8?B?enl2WE53WE1pY1A1NVdDWEh2a2t3WGVWMUFZL1hXUTlHWURXQTRHSFNjaElh?=
 =?utf-8?B?bFVxZ2NvczRLQnhaNUF1czJEZHc2NE5pVFZ0eEU3bmZZNDRKZVJVY1NWRW4v?=
 =?utf-8?B?clJSbFQzcHdMNGl0VTZtcHZwenVoaFJxaytRc0p5WFhGMU1nYlgyVFQzQjND?=
 =?utf-8?B?THAySVo5YzlUTjlMckxVNk14V1c0eTk5VUxzdi9xZ0xrc1g1ZnFnZDQwYVBN?=
 =?utf-8?B?S2l2dndMckxaQkk3Z1NVOUZ5ZENQcE1xSmNQaEd2MGxLeS9WalRHL2k2Ylly?=
 =?utf-8?B?RW1vaFl2WVE4Tm00SjBTbk5UdWdROXBtejI5d3JaRFFZY1hDSkdrbWlHMTFu?=
 =?utf-8?B?Vkp0c2FHa1FhcWxsTVFhNnRpUlVYUVllUkZQR3lqQVV3dEM2R0tiSVVzb3Nq?=
 =?utf-8?B?ckJIVTNoeW1VN1BadFRqRlkvSHJhWXlsNFZiaEwzZFkyaTUzUTg1QXkyUjdD?=
 =?utf-8?B?YzlMNjMrbm8xNGdjc3ZuTlhyeWQ5VXFGampHU0JYM09aOFZlb25NaFdKWTBB?=
 =?utf-8?B?UE5SZmhiWEdaM2hoOTZpTit3RzV6RlFhWUNYV1IwSFlKVDNqSEp0Tm9QMEVu?=
 =?utf-8?B?Y2dFOFhPK0FZVWlPbDJXbVR6dUVEMG5pVFRud0FDRXlvRUhtSWZ0UXB2bXZ1?=
 =?utf-8?B?dWNpb2VXN01lYXJManFnenBPN1k3ZzZPWS9XLzNJSTZTQ3d4RzdXQVMwc0hh?=
 =?utf-8?B?V2VhUHVnR2RuVUpPRHlrS2NLbVhyMDIvMHh2QXVib1I5TXdsNU0yd3RNblo3?=
 =?utf-8?B?cS80enZMZS9Bd3BURkdyVkdSaGozMXpJYytJKzdYM3lXZE1OeVIxVmhLSWNs?=
 =?utf-8?B?aDUwQUEyWnBFeTR2TGdrNWFQa1hSR1lLU1JaQ0VmdG5ML3EwTHRGWkU1UEM0?=
 =?utf-8?B?LytpRXJWZkV5NUE0N285R2xtSVc5eFlYaXEzRjM0Yi80dlQrTGc1d2xLYnhU?=
 =?utf-8?B?djFBcTJwTW84cURlN1FXQS81T1dlUGdUQklQK2pmQTZGOXlRY1VMMDFXVita?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce27ebb-d486-47a5-bc60-08dcc5d348c3
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 13:30:43.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVS0NulW3I3sM+tF05jLtwE4ZKGDf35rrt+gUdA+jYGYlMKZFOtQbJgvpqBtOQhtZ/CNyEnYBYd/I3NNPXOZyDCzzFnBLK0UMJVyn0YD/Vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6344
X-OriginatorOrg: intel.com

On 8/26/24 15:06, Diogo Jahchan Koike wrote:
> ethnl_req_get_phydev should be called with rtnl lock
> held.

Next time please make use of more columns in commit message (75).

> 
> Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
> Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
> ---
>   net/ethtool/pse-pd.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index 507cb21d6bf0..290edbfd47d2 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -226,17 +226,21 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
>   {
>   	struct nlattr **tb = info->attrs;
>   	struct phy_device *phydev;
> +	int ret = 1;
>   
> +	rtnl_lock();
>   	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
>   				      info->extack);

Fix looks fine, thanks, I will however unlock just after
ethnl_req_get_phydev() call.
Then all ret code logic touches could be omitted.

>   	if (IS_ERR_OR_NULL(phydev)) {
>   		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
> -		return -EOPNOTSUPP;
> +		ret = -EOPNOTSUPP;
> +		goto out;
>   	}
>   
>   	if (!phydev->psec) {
>   		NL_SET_ERR_MSG(info->extack, "No PSE is attached");
> -		return -EOPNOTSUPP;
> +		ret = -EOPNOTSUPP;
> +		goto out;
>   	}
>   
>   	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] &&
> @@ -244,17 +248,21 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
>   		NL_SET_ERR_MSG_ATTR(info->extack,
>   				    tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL],
>   				    "setting PoDL PSE admin control not supported");
> -		return -EOPNOTSUPP;
> +		ret = -EOPNOTSUPP;
> +		goto out;
>   	}
>   	if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] &&
>   	    !pse_has_c33(phydev->psec)) {
>   		NL_SET_ERR_MSG_ATTR(info->extack,
>   				    tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL],
>   				    "setting C33 PSE admin control not supported");
> -		return -EOPNOTSUPP;
> +		ret = -EOPNOTSUPP;
> +		goto out;
>   	}
>   
> -	return 1;
> +out:
> +	rtnl_unlock();
> +	return ret;
>   }
>   
>   static int


