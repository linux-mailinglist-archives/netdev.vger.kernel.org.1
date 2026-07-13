Return-Path: <netdev+bounces-307257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0lFrFowjVWqZkQAAu9opvQ
	(envelope-from <netdev+bounces-307257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:42:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBD174E1A6
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:42:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=eLbr3h0s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307257-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307257-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 524F8301104A
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95FE34B662;
	Mon, 13 Jul 2026 17:42:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69939233927;
	Mon, 13 Jul 2026 17:42:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964551; cv=fail; b=MNR3xfCUUaOAHcWvPsrGoTIyyGXpauiZ2AfBlGqPyedygn6BNJzYCNgBX9W7zImSM7aaT7HBDHtEoUXo6CC5xp7+OfqQWVbmbFWHTwLVXf8Wy+J4eQW2byxBuiotXClTyORwIgZH7SF27dx7ADEvlqtkq0FmNy6Nw4O8fQDZ1Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964551; c=relaxed/simple;
	bh=JO0mmlsdV1Ntp7S0XEPkqm6CttQi6xigAWWTJPoAjjU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aFeqaDgTwumstX2u150HSTIhva9mu8mEcDi742WHx+9igvooF4WVEm6qyiJU/3mYABKAev5Xa3INOedvY9Op5QJdHpLQV0/eaZul42Es67d9FYoEDguujoUm7tEwHdZiBpNBqhgFX5jTAfvA4m7XF/91HocwgxVNdz2xh2kBrSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLbr3h0s; arc=fail smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783964549; x=1815500549;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JO0mmlsdV1Ntp7S0XEPkqm6CttQi6xigAWWTJPoAjjU=;
  b=eLbr3h0s27VI/JfSH4L6UnRK88B6Rr1LFayX947i8gih11NrJU3GECZK
   VZgAe6Vssc2LovFnRehpAmpX92OZ2NME4ez5ER1+N7M7litLbzlOj/m55
   +uPdcCCSXs8TO3SQW3O3vjBXWiIJwZsDM6mDzzsvc0xSHZL975hNyt7UP
   +UEvYiwrw3rFdHRUvGt3skk9LB7adnZEHr3Pjm7HuqqJFXVNVW4Hf4aOA
   VhzFJg7Oryqwtt1b3u6EYXaw3HtBKJpQpqlsfmBKiP9gQJOTv4d73PYE8
   Jovs+4//k5DjDKPrp/LWvjTIoawFilsonENc/JbPutP2hnoaYBpsWtPmQ
   g==;
X-CSE-ConnectionGUID: ti7YhcovQjejLczUOuU/PQ==
X-CSE-MsgGUID: Bbb7YDEzTLaU7xXA5WdWyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84544305"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84544305"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:42:29 -0700
X-CSE-ConnectionGUID: ZKAiyt/OQIyfil2ZccvFiQ==
X-CSE-MsgGUID: LHARrEkdQ2+HzkSkPpRQgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251670204"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:42:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 10:42:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 10:42:28 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 10:42:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9w5eWahDs5DVryM00FryNQZ6o1B4y0GSXAqpM1sqU7fUhL2rlcAVPOEDat+8GFZRoRknDxmyYHmlpEzAK7T+bTFfH7msV6NZXHBSspI6oOymfbn1uc4H5misi4GqHAWXFDcf1FsmY3+T8sT93ukTyCXs2whtwvz6YAwXKkr5hKHuN+qLEnqz0Uv7u9cEqQsqjUZRfhUzUdXN3mIyETyn3ndlWkNobpg7iAMQJKaogQfNb8kRjV3fV0kBqF8Iv7WcPNFWtGGzHZIrIyXw3R6+HnGLWxDbccKgyBhcNUMsRfokHTsE2L4Z5/RXgaACf7jz7Y0MkHyMY8LWDwlo5iJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5vfSoBjLRhHEFaiOyD3kuAo6XRMXS/EwfbSuDQIIkg=;
 b=Gv3Kfiwg+3pE2uwh6IH51uzXDz9JKfsGv5bmkSPAAd0oZERjsDErX5XaOudrtwdt6u+tolkjM2PvIhJAUbLZZf9e0oMxyEMbkujFM+thdxde6UZPtvO9h+eX5aIx8jgaYFNMlSRdcei7n4R97TIbebU+ZkiYjBiH7+ScRvIuKXIJXXw78i5LYMrwpbPMkZU5t+x7ODaYgQqQLTIEZvVXblxz6k7r36FCPzu7T7Q1DGvmSilbRwDFjSzaLOKJervLxVykuOOGhaCT955/xOulyl1rO244xva2YERlsmNSy8uVUUReAH23T4RzI/wHW7jSP4yFKDCCgV5l/hqImiz5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 17:42:24 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%7]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:42:24 +0000
Date: Mon, 13 Jul 2026 19:42:12 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Phani R Burra <phani.r.burra@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<anjali.singhai@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>, Bharath R
	<bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next v4 05/15] libie: add bookkeeping support for
 control queue messages
Message-ID: <alUjdKO-XHJw_AfO@soc-5CG4396X81.clients.intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
 <20260710215313.1475803-6-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710215313.1475803-6-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VIVP296CA0046.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::19) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|PH0PR11MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 66224410-98b2-4f3b-3a44-08dee1061943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|10070799003|6133799003|3023799007|5023799004|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: E+dNm+DX/RbZ1yrKR0yejMMNUWEC50tm5DXeMQAYLBt84BeJDkiLG4BmRjEAn+8TmRlN4GlztFhxltZR8BAM5hPzTWeiE6taBRvijkiahqsgXFtVTOI4sM1p3HoWK87d4uBkGgid3s2j/jLKnHuBx5gOxxaZhOJI03m7yZmuNtx6qtAZ1LWx1LABlTlnMz/Mz84j8B+qcVlcKZKAXaQhLcXvJnuHYaWPZzGaHFd69wFU2slq6Mqq43bS6iYQORThF5eg/sled4xdct0z4squSaNkNpf3kCq5KyIJXRqAadEq24uM5NT8qvnMnwGinDbllX54iAqhY8kY2S2WugCleaE6/RI++fbjxHl4M1uodgZlwueJXgdBoQEMRUIITjLNR1ESTwQkoa76yWeFX6hbPKN4YkKFw2ZFbqaKgV20J6veic/xutxmcAmyJr7QrIqOql741Tlm/1CXu8UcjFYLzgDE1z+nOqC+IIwgBnFbXdCU+lxmmnlHTRmte19+6fV5q32jXOZi/moR600ZpmC05cfmrvVd7hzq1+hzoUpplzd9t3ea6CWC140epuhMHl3KbQaqfSYTK8sYKXi8E4Su0luRXpL0WLSU0IfOG7JuVCQlK7d0jDB2qxzYEIVN+mbm5QyDTEA3LbViDCJdub94hedC050cqFzl/DBVKCpwuoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(10070799003)(6133799003)(3023799007)(5023799004)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UmndZw/yhLwMB0Ut+pNUqUddckUmeZtapS2XEuhCy3MPEnTkJaARXSl3E5UL?=
 =?us-ascii?Q?SkHjUKTsXZYr7vMvbUBlWv80HJtcDbg9TfPsv0PlQVu/VJpSB6HNF2EuR4PQ?=
 =?us-ascii?Q?PSOc0q7+2bsYY0BqGYzdqaC+emqo9KRdVvZgZy5Dnb/paggpKsHWCTgxesh7?=
 =?us-ascii?Q?swe7XnzE5NMrmGRf2mtpRyC8IkUiPXuEuddRp38zE2to++1+t+xi4NHbg7VM?=
 =?us-ascii?Q?PDm5RWh7m+7upqAkl05neM+lxJPaHVlQ2Vo6EEGbc9wH5EQxB+71RRaxp6km?=
 =?us-ascii?Q?kgKHQbaObCNGLRNjGFQ9gozD0zSPTeMs526kP8IJUlb/y7KWdNyR9rFv4FBh?=
 =?us-ascii?Q?wWObU9djmRuO3qISZNSPlnfIFeWZuypWRiNXdu0cPnlMTCPV3R6hwsRSc/G9?=
 =?us-ascii?Q?k/+rA9hOyy59dazh3xohSjYzNc+KFPpcJ1Z4vYjPTTr4hVqU4XETEdD40sbE?=
 =?us-ascii?Q?VDldxIW/iVu9sqt0nUYZzCfZFfpWObzdQY1ytRyBvxHW5e1BOtqwN8TAmTrf?=
 =?us-ascii?Q?o6JE92UVZCceYNZY5JNWwEumncfQz02Cd0cHRmWQNMsDauY7nPTv5mqgQwuu?=
 =?us-ascii?Q?VNu42nZ8asB/cZOcXGqmAPFoJ4nFij2hlLLI0LLEcNKAuqQy6Z2jiq3p5/bd?=
 =?us-ascii?Q?Ln2LwSx4qxtlN4iDgm1dSS+OxYfNZhQ44xUjs08WEP3neMUi8VvGwyZOwVAe?=
 =?us-ascii?Q?VpDQIPbGzwtZ1xGTxhDvAtyg89qxuf2OvTPl2rUCmOcW88QK7I94kW406Q1z?=
 =?us-ascii?Q?3VQCZfAnD20IOqmeStYtNJaow59ts1N76Yyj5fA9VLskEN3QWVRjt0poLEBI?=
 =?us-ascii?Q?ZXdCoYixc1JviFK1P2eBbVHevL46GbmUqbLHmHwHUeY5xKBB4ZtVoyIX4S1g?=
 =?us-ascii?Q?l5MwPTUwCwnaYagP1aYpIwOraaIGfiwr9VRbAAHKEodmGlSxZPmaorVBgtUd?=
 =?us-ascii?Q?o+GcjzwgdPfbchYzLn62qEDhsrYUXvugvMkFsTD7fC9QP84D7JSfbHFjiJOH?=
 =?us-ascii?Q?KDxivLs609YGlgGJ/AbhCUM+wYghgxy3p46IDNgfjAWBGu9kXqc8fhhk5G4I?=
 =?us-ascii?Q?gEo7qjSPZr0DgRVgHgrSgF4ayPgbwr7JYHyxmiA/N3j5yHSdxHBhXuQeJo+O?=
 =?us-ascii?Q?yE+V5MZ7yembWyk6Wjl9J59h4RV6yOEJym8v8KX2KUiHkV2AJcQnfMgGgYhJ?=
 =?us-ascii?Q?NTSJ2ynHJlIhiY4zKQHWqrSltt6jPUejIHNx9nATtyGNcfbwOA0gJfSiEA2u?=
 =?us-ascii?Q?IIaiqwu2fLGDJ/iLp+KD+LVs0UEXWY8+hQKI3cVlJdQfkSRXgZMd+hWueGwB?=
 =?us-ascii?Q?hGdRr2G8eBhU+Q8GcF0on2+NW7U6ETomucQq5D00kBwzSef2NxWloQgkVCZo?=
 =?us-ascii?Q?Kf5pOvC9JmuM6dOWNgDmfiDRdYZUWaWKeo+oH/j1ZG1+0tKs94ghOcxQ+bAT?=
 =?us-ascii?Q?cHf6ZzyFNxWkafO+FdqYEFjqwTq8Sp1Nhmw339OF09F75GxIcRNoyx/g1QZM?=
 =?us-ascii?Q?QJCLpPz2j55NCSLrtQ4XQOrL3kVnHPS31NlfSTx7XqBJZ/KISpeo+g5/k+zQ?=
 =?us-ascii?Q?QaShDMLGXqCCmvk/1yA4yi1lXFDGWdPJ2nRJxwYZ28cEvn1pRmATqmAW8wc/?=
 =?us-ascii?Q?CFByLRgZzuJMiAT/k36Pxx7tOQokwzq5VkAZV7LnTD83VwvKvmRSLEU8xIgP?=
 =?us-ascii?Q?JhX72fINc9O9xXNjCYRTjIuGbflvYb/EGx5XtmGSxTErBXrhLXCXtQKEDXQc?=
 =?us-ascii?Q?J5iCfsODSkZAFHvRxlroGz8yYny05KlADqQgvrwu08yBtbYUhCC3dGlSpo30?=
X-MS-Exchange-AntiSpam-MessageData-1: GY8895mrJD9KpRc84ZV4B+3em2vYYRp31M4=
X-Exchange-RoutingPolicyChecked: sp1CFs9SGHr5YlO6LbRsS3Yv4YHPRGY7vOfQBGZ24ctaiarYXPR1faTHhKZegNApO9n37cPups+II+1X80Eb4dJlkdnKyn0pi2tndglCwIVEMLqDiEn9bPD3lOCjLrbtX36EuNZR84iDMWuzCwTh5GwEqbUusKQqEEvpMes22rBQuV2pLcMMNAb1PCQkd0Eu5JBaHOAHFw3R8MSJ3d/XBso1ZJSk66irIhTFB55xfFFDnQFQ5oFeAlRLlT+grBdKqG49nUUqZjChpZM7FolSLQlc5Yhkaqx6/u5I/YvEg5Rbw36wW4cGaXwEFWvFRGjj7lVUtJUid+lEiK44nkuoxg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66224410-98b2-4f3b-3a44-08dee1061943
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:42:24.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQZYbTtdiOhcODfvUh8NkTcpY+fXEZmST6FHWkHCMLsCG/kIXgWoqFDAOuQ0siq5lalouL/sNOcMSUzJOkhvJdI4etu9aOXw8AKpFT9Hblw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307257-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:phani.r.burra@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:anjali.singhai@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:bharath.r@intel.com,m:Samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCBD174E1A6

Sashiko has some concerns about this patch.
I have found one (very) valid concern there, and concerns memory usage.

commit d7a772efb77228a1b12558dced6b1fdfeef123c4
Author: Larysa Zaremba <larysa.zaremba@intel.com>
Date:   Mon Jul 13 17:02:01 2026 +0200

    fixup! libie: add bookkeeping support for control queue messages

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index c043c07dbb89..8e7b2783b86b 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -720,7 +720,7 @@ static int libie_ctlq_xn_init_dma(struct device *dev,
                        goto dealloc_dma;

                dma_mem->va = libie_cp_alloc_dma_mem(dev, dma_mem,
-                                                    LIBIE_CTLQ_MAX_BUF_LEN);
+                                                    LIBIE_CP_TX_COPYBREAK);
                if (!dma_mem->va) {
                        kfree(dma_mem);
                        goto dealloc_dma;



Now regarding other concerns:
* xn cookie overflow. The flow is consistent with what was in idpf beforehand, 
  lengthy testing also did not detect any problems
* Compromised CP accessing other CP message

> Regarding cross-transaction disclosure in the pre-allocated small-send
> buffer: in libie_ctlq_xn_process_send() the small path memcpys only
> buf_len bytes into a LIBIE_CTLQ_MAX_BUF_LEN buffer, leaving prior
> transaction data in the tail. The descriptor advertises
> data_len = buf_len so a well-behaved device only reads that many bytes,
> but could a compromised or buggy CP firmware read past data_len and
> observe prior control-plane message content?
> Would a memset of the unused tail (or of the whole buffer before
> memcpy) close this at negligible cost?
> 
I think zeroing would be excessive

* Both Sashikos reported this one:

> Regarding bitmap access without the bitmap lock: this iterates
> xnm->free_xns_bm via for_each_clear_bit() without holding
> xnm->free_xns_bm_lock, while __set_bit()/__clear_bit() elsewhere
> (non-atomic RMW) mutate the same bitmap under that lock.
> Is that intentional? The comment on free_xns_bm_lock says it protects
> get/check entries, so reading the bitmap outside the lock appears to
> break the invariant even if the subsequent xn_lock re-check masks the
> functional impact today.
> 
If the xn becomes free in the meantime, we catch that under xn->xn_lock
If the xn becomes taken in the meantime, we just check it next time

* Also reported by both:

> Regarding async timeout enforcement: libie_xn_check_async_timeout()
> runs only from libie_ctlq_xn_recv(). If the driver stops polling recv
> (link down, reset, NAPI suspended, interrupts masked, no incoming
> ctlq traffic, budget exhausted repeatedly), do async transactions
> ever fire their -ETIMEDOUT callback?
> 
This is intended
> 
> There is no independent watchdog inside the xnm (delayed_work,
> hrtimer, etc.), while the sync path is self-contained via
> wait_for_completion_timeout(). Is timeout_ms meant to be a hard
> guarantee, or caller-responsibility to keep recv polling? Either the
> kerneldoc should say so, or an independent timer inside the xnm would
> back the guarantee.
> 
Caller's responsibility, timer would be excessive

* BH-related concern

> If a driver invokes xn_recv from NAPI/softirq on the same CPU that
> another thread has entered xn_send in process context and grabbed one
> of these locks, can the softirq spin-deadlock trying to reacquire the
> lock?
> Should these paths use spin_lock_bh() (or spin_lock_irqsave() if the
> recv side may run from hardirq)?
> 
Both send and receive are in non-BH and non-IRQ context

* DMA direction
> For the small-message path here, direction is not set on xn->dma_mem,
> so it stays at whatever kzalloc left it (DMA_BIDIRECTIONAL). The copy
> of dma_mem into ctlq_msg->send_mem then carries that value. Today
> libie_ctlq_xn_send_clean() only calls dma_unmap_single on the
> non-onstack path, so this is not consumed, but should direction be
> set consistently to avoid a future consumer of msg->send_mem.direction
> misbehaving?

dma->direction is not expected to be access by users outside of libeth.
Library uses the field correctly

* "For the NULL-iov_base large-buffer case" - I think this can be considered a 
  driver's programming error, if this happens

* XN_SHUTDOWN

> The SHUTDOWN early-exit here jumps to unlock_xn, bypassing release_xn
> which is the only place that resets state to IDLE and calls
> reinit_completion(). So the xn is pushed back to free with
> state == SHUTDOWN and a stale completion count.

XN_SHUTDOWN means shutdown has already reclaimed the transaction and it cannot 
be reused, hence can be dirty.

* 0-data messages

> The kerneldoc says "if force is set, then clear all the outstanding
> send messages irrespective their send status", but the loop breaks
> early on the first slot with data_len == 0. Should the wording be
> adjusted to reflect the actual behavior?
> 
The only data_len = 0 message is VF reset, which can only be sent
as the last message, so we can safely assume no further buffers
need cleaning, if we encounter that

* dma_wmb() + dma_rmb() = dma_mb()

> Would dma_wmb() suffice here instead of dma_mb()? Only a write-side
> ordering constraint is needed for the desc->qword0 = 0 store, and
> dma_mb() is significantly more expensive on weakly-ordered
> architectures.
> libie_ctlq_recv() pairs its DD check with dma_rmb() before consuming
> the rest of the descriptor. Here, DD is read via le64_to_cpu() with
> no dma_rmb() before any further use. Today nothing device-updated is
> read after the DD check, so this is safe, but should the same barrier
> pattern be used for symmetry so a future descriptor field consumed
> after DD is not silently unordered?
> 
Both read and write berriers are needed, therefore I have dma_mb().

* Same answer as for the previous version:

> Async callers of xn_send() typically pass a send_ctx that owns
> resources released only by resp_cb. When shutdown races with in-flight
> async transactions, does send_ctx (and anything it owns) leak?
> Would calling xn->resp_cb(xn->send_ctx, NULL, -ESHUTDOWN) (or
> -ECANCELED / -ETIMEDOUT) here, matching the timeout path, close this?
> 
Callers currently do not rely on those callbacks for cleanup,
and they certainly should not do whatever handling they do,
if we are shutting down

* Clearing the queue before shutdown

> Regarding TX cleanup on deinit: libie_ctlq_xn_deinit() calls
> xn_shutdown() then xn_deinit_dma() then libie_ctlq_deinit(), none of
> which iterate the TX ring calling libie_cp_unmap_dma_mem() or
> rel_tx_buf() on outstanding sends.

Both callers force-clean the queue beforehand.

* Small return value concern:

> The ctlq_deinit label unconditionally returns -ENOMEM, discarding the
> ret from libie_ctlq_xn_init_dma() and papering over the kzalloc-failure
> path with the same constant. init_dma today only returns -ENOMEM so it
> works, but would "return ret;" (with ret set to -ENOMEM in the kzalloc
> branch) be more robust against a future error code addition?
> 
Those are all memory-related functions, so this is very unlikely they return anything else.

* xn->send_ctx

> The send_ctx field here is never consumed by libie_ctlq_xn_send_clean()
> or by the rel_tx_buf callback signature (which only takes buf_va).
> Should send_ctx be removed, or should rel_tx_buf's signature be
> updated to receive it?
> 
This field is used for async transactions and is usually
a rather persistent object, like HW structure.
xn->resp_cb(xn->send_ctx, response, status);

* Slightly outdated commit message

> Is this accurate? Only messages up to LIBIE_CP_TX_COPYBREAK (128 bytes)
> use libie's pre-allocated per-slot DMA buffers via
> libie_cp_can_send_onstack(); larger messages are caller-allocated and
> freed via the caller-supplied rel_tx_buf callback. Could the wording
> be tightened to describe this mixed ownership model?2
> 
This is correct interpretation, but the kdoc is outdated

* Calling resp_cb() under xn_lock

> Is it safe to invoke the opaque resp_cb() while holding xn->xn_lock?
> If the caller attempts to submit another message from within the callback via
> libie_ctlq_xn_send(), it will attempt to acquire free_xns_bm_lock and another
> xn->xn_lock. Could this cause recursive locking or deadlocks?
> 
idpf and ixd do not behave that way

* "memory leaks" for small buffers

> > +	bool free_send = !libie_cp_can_send_onstack(params->send_buf.iov_len);
> Does this logic cause memory leaks for dynamically allocated small buffers?
> If the message size is <= 128 bytes (LIBIE_CP_TX_COPYBREAK), the data is
> copied to the pre-allocated DMA buffer, and free_send is set to false. If the
> caller provided a dynamically allocated buffer and passed a rel_tx_buf
> callback to free it, the callback is never executed because of this flag.

This is by design

* transaction reuse

> Can a timed-out transaction overwrite active DMA memory?
> If a message <= 128 bytes times out, it breaks out of the switch here and is
> pushed back to the free list in release_xn below.
> However, the hardware descriptor in the transmit ring might still point to
> xn->dma_mem->pa. If a new caller allocates this transaction entry and writes
> its payload, it will overwrite the buffer while the hardware might still be
> processing the old descriptor. Could this lead to hardware data corruption
> or invalid firmware commands?
> 
Highly unlikely

