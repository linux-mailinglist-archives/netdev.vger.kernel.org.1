Return-Path: <netdev+bounces-106813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B206917C52
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFCB1C21D24
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E636F144D1D;
	Wed, 26 Jun 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NW2hBcNS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907B33DD;
	Wed, 26 Jun 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393585; cv=fail; b=jrv+cpJuHksu9abEGOmYDYk2K8/ayTRidevqKdhs2YxM/Z3BLFQpWO/0w8NXn02tNzoghSk+/88jmHvsKPIj/LfJORO7dFPvK6GHNsdRrTq5scyotb5Aem/RAFg5E7DWVgUnIK0hvZp6S74FvGnBLIvE9kOU2o+bHgj3cJyMNZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393585; c=relaxed/simple;
	bh=Bf7xblU+KwjQJZXVm58m22tKMFop06307GTpMTcP/po=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eHDsM3Qz0ryEIQl3E7UHMDz7FRqE4rYHxK70urs5eIjAgL7Ra+880ix5TnwKV6Rvwc+hsW3+Yni4fpLG47f26I/JRtKy0ig+FEWQ97EW2zDja6iSgpnpy96LCDbzLH73CllR/uiXMui5809PTdAh6NfvRyC0Af+sNyMgtYNVuFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NW2hBcNS; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719393584; x=1750929584;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Bf7xblU+KwjQJZXVm58m22tKMFop06307GTpMTcP/po=;
  b=NW2hBcNScyefIKVOD3fLHJ9jdcgGBZkykF361owhzSU8XY+7pvkHXjRt
   aS8KpfYg9EKgKnFgCu+cL/4PbsUbANa3QhpKAgVFVp57NIal0WlB00KKZ
   RlstrcVGhKTaSnJqjf6h1woQ32DtCwjconCusizcGCeeZj5UNXTYOO9JX
   nSX2eAi3KDrfx3A8IcMM+C8OLoYzvLr3AYJ2yukpi9olAUWMqnEQ6PUBu
   XqGBDONwg2p+dtXWkuzq7kvMG6j69kFIklUmCkg7zAAvQQAD/MU9Lbsee
   prV7Xa3yVz9RErL/7nZeEjI+obX9Mxxogs252XqXijUoU9te+ZJQGK6Uv
   g==;
X-CSE-ConnectionGUID: 25xz2ctTRy+SQFH0eRdQhw==
X-CSE-MsgGUID: GJZACV3PTJyNzk021Plxeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20226646"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="20226646"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 02:19:43 -0700
X-CSE-ConnectionGUID: weAOKdTqSAKF7oWEKqcyJw==
X-CSE-MsgGUID: hGvuj1yuTPuCmbByAyeSaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="48319771"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 02:19:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 02:19:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 02:19:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 02:19:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 02:19:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCjKQvB1XTIU05pX+n7Ed1/KQazq3ygcqe4BhByWPrb/Wnxht7R/TBXiun+VBrUMGc7oj4ky3Jzp250tBIg/80xkwu+sTvKF3cjiHY408MdV1KjKuBxKAFvdadN/KjBXHkHv10viH/hlaKjVhLTMPFqgjEnIYsiEYQ/4mvP6SicqUwfAvvMUkLAYQVK1GEnSAk698STjqELcPeJHVnWck7TR8w3XXVdMgYCC0EJbTNSYqvmIYab0KBCD7Rx3CIP+lQDAlgd2e1Pp1POJqf3recH3Ks83RPvtEM3jaZGPlV2SeVZymKZnNyKs9+o+yZtNLzZz6skDEO5HdfX+IAWfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeOtNWKMbzyg0RSccCbc2Qs3HrakxLEnojigv91nJhs=;
 b=Ewo4FlXTe6jAzS4vIlPm0gaUGevggASvO7Oe0Yg36GQqxDevyR7WVOlphZ6XCwNmBjp3a41dfWxVBGdege1XmJr7YDEfEBzxRJ1z2oHSAJPGFC5mAIYAUNlAQEyCVp4IAv/vlemLQ9nUOxmZ7vDmsJXE0M37HD7k0IKuiHmQnjXTlMFHHdNNXoi6xFxl6i9MrcIjfPAHr1FB4qHhgnjkc8CBXyW7jkUa+aIf6GKbIq6STI9Y8oADRHYUTUwKOnthXIibR8YmhvFkDq8cz5WxhyLeEOmudd3EPhc+4d6DBxJBVR1xzJ0m0fWId7jZxHgqV1UHwz0yEjIEoWEukY0sWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB5134.namprd11.prod.outlook.com (2603:10b6:a03:2de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 09:19:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 09:19:29 +0000
Date: Wed, 26 Jun 2024 11:19:21 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Luiz Capitulino <luizcap@redhat.com>
CC: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<poros@redhat.com>, <netdev@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <magnus.karlsson@intel.com>
Subject: Re: [BUG] ice driver crash on arm64
Message-ID: <ZnvdGQ0fUTAIorhS@boxer>
References: <8f9e2a5c-fd30-4206-9311-946a06d031bb@redhat.com>
 <ZnQsdxzumig7CD7c@boxer>
 <34ffbdcb-b1f9-4cee-9f55-7019a228d3f8@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <34ffbdcb-b1f9-4cee-9f55-7019a228d3f8@redhat.com>
X-ClientProxiedBy: VI1PR06CA0119.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::48) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e5bf9e-747d-4f04-24ee-08dc95c114e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hw6V6152i9cP3yYqOngEMRNuDrW3d3kEUJdIqlNcyC5zy4ACL8A/NyCnyQ+6?=
 =?us-ascii?Q?LyT7e3MYAv9KThjnQg0Tg5qQUX8Nd3ExTVJfx/tqONOUQPYEAZRObeITGKyr?=
 =?us-ascii?Q?DRipdCwdnH1xA0uqUnv7BHhpPJhyF7Vg9dLtXhfUKdnBxzL9rntibsjQTh5V?=
 =?us-ascii?Q?xHRpOTZtAb9UG8rjCxvbplH3azQNIYaWKlmA/E3eNo8WfVTKW1vY0OFZjDfd?=
 =?us-ascii?Q?ekPwBCzACxehK+iDpTsXeCVHTxiEgADOtHkTbLh/An2EO0r9hbsk/DTjEEu1?=
 =?us-ascii?Q?9klDmqctT42sbPus66TRDLXc91tpkzI+UoIDFUYHSL/k7AmyYAwpCAOrRstg?=
 =?us-ascii?Q?wKijuDS/AxihA5d4w3K6VEx1Py33NrGYjZ6ztqVMLWtwu1lkDkSn/HYc32hR?=
 =?us-ascii?Q?MKxqyI79K0ZADMyQYoFOTfl7UcZWOqIxnIxDd0ELH2kr9bQTcUwg6OM/qYl5?=
 =?us-ascii?Q?xGYvU3Uyu2BmjPZy+6/0FoJZSDKhMUMrGSALBQOlDJvi/nn5y2IbgAozNwAn?=
 =?us-ascii?Q?d1gYvqsH+xltGm1wgYCMR5rG7zV4wQibfMFIPi+1hQXpeIBFCQnheZKqsn2m?=
 =?us-ascii?Q?ZxIUvH5/S0iQ3vtwekozAczfUw63gHhk5zs+bHpEXxLqf3ODkyIMYxvzSjT8?=
 =?us-ascii?Q?7Jtl5P83o15t6rsgq/JZgepjRCpqhX2jSYbVeooTLWyhcrW7JgzkjmNRa3+w?=
 =?us-ascii?Q?uN4djFtuq5qrak4OZShaz4XXw6FOwalLmr2f97IOWHavKJqM2Q7TMVl7YC/3?=
 =?us-ascii?Q?QVRX5b1YRhnO0ZAygOrV8ztPECv/38k6TufpuwZ+SFXgmqCxwY4NPln8cVpd?=
 =?us-ascii?Q?0dWcWbbJ8mljmgVdWwZsgn5W+i66C2RcWQCt5Hrtx9cTMw8nRzzPFNsTeasb?=
 =?us-ascii?Q?ZatXcNHBxBtcE0nKHiT0J1iTlNOBnmwS6UpwsWLrGOtr7r2/4/GRNXQWb98/?=
 =?us-ascii?Q?TS5scebzMgzizgUXAU7Tpyl+xMx9Rh28vi0S5CSxaldqEujHzHcVz34my3cX?=
 =?us-ascii?Q?pzTTQrg+zOrnWDA+gKUj7gk4aE4hZ4p4K7Lv1kK9bAPCcZpFMDhArdmAYxhV?=
 =?us-ascii?Q?0WSabcjnECBgiMmirkSsPtGXSD1de9YiVmLnLGmDQ1z/hMYPr6SFgEDj2cNj?=
 =?us-ascii?Q?RY4tbOXrvj6rUsRc2wyp1zes3lHTvMDQUNqszTsg4KY9hEgZsE9dozA+C2v3?=
 =?us-ascii?Q?st8IyazJp0i2oEZYdipIbtX2iN5vrqrUSN71DtTF+ue8L8OvYhvlYbg2wEuJ?=
 =?us-ascii?Q?Qv8268ZkRGSYXRsmu4YK8CeNv3cSwtN8xguSVXSJiCyfxhsYjc6p77KC4r4V?=
 =?us-ascii?Q?I60=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HWNvd1ckNciqjwSHowhV4ZNRe2v7IUeUL1HO5B12QsBa7FJCL+kJHoj+BcKr?=
 =?us-ascii?Q?9cB8tCNrVq4d6nwy3+lY6pgRZeOHBJOOUx4fSe195XpT1c5MWWtw7tw6u5NO?=
 =?us-ascii?Q?rbfrDRdUhNpUp9SLYgEMTFAekbnQw4f01taj9pRLRDlNCpI9KBj/mq3b1zot?=
 =?us-ascii?Q?eFJ9mCUwdN9UnjozAg1C5Ynf7ThrW3N9LZ+pFCe5YS9uospXua/tLaEyZSnl?=
 =?us-ascii?Q?0U85JednGLTRVLBE1o/1zpOVlfTmNsUp5OMyX/JUHIxujikmfpyhEv/0uFnG?=
 =?us-ascii?Q?Z5o5q57H1mtkmKmF6s6BYNJSH9plWofOusavZWQHxBPpvVL4pOh+5/m2ymdp?=
 =?us-ascii?Q?4Ur9WLHyTQqZlJu2qPet/hkS/cafgg/OU7ssLVzlSm7irtN2zbenDGusAji1?=
 =?us-ascii?Q?B7WLv8fF0q6r+JE52NLYz1EeY6D5Xpd5/GCBd2T0cTNp0YOOJ4Ut3xoEJOXo?=
 =?us-ascii?Q?p8hBJzuhwzIquBmV8JoXJN8jfbgUv+Cbfq9kE7IUZ0YB8erFWbVaGn7hEfzu?=
 =?us-ascii?Q?MPhB1TGNwhnWMB+dwCUBf/R0rzCJYmjo2YG1gKZ0qp5BeDBOSfetmfb0dNum?=
 =?us-ascii?Q?zn5f4eqrNxM46aq8LYD1ncNi3hKAZvxWFg9VhOrbCx4igyyIlwdJCrTxZCtR?=
 =?us-ascii?Q?GleZMjtPQm/ALEkYu9Zx1qWssKVVmU6UkGbuFD9x0q3NJ/FhzPuiuQjgeT8l?=
 =?us-ascii?Q?LcTFF9/jL6DJQlFjmIksnkxBk5+xkzk4jjuCu6w9mruG8Q3iRO/0BfzvNuLs?=
 =?us-ascii?Q?MByLDSbeSvAz7t8tlR67VPQoAX0UdEJdrozyV6LTcPb3IiLg+ubZ8+uRqgr6?=
 =?us-ascii?Q?IEDnN23ZEBe+gj0+muAOPD8z3ruPUXPpCKHxkgFzcVfc0vLV41tNoQURq7Xh?=
 =?us-ascii?Q?RpGhe6CIbZ7ruTiYO4pZaeMzrYXtwD6Lhgs0l9M2PZblcrphha4TGYidb2HZ?=
 =?us-ascii?Q?ntmBB/TdCLbzSmF5yEzyoTI7o9stWt38TxAD1Ea0zlDmfOcCK1wtMogBd/j3?=
 =?us-ascii?Q?MFGtyVuhQTlEWAeyn7yceR9vdbYF/AV8A5B+umUV0Q9OiM3R5UucVlGvRAXl?=
 =?us-ascii?Q?4z0McUrdQF/3eICzkoldHqQynEpzNDFaDEL33pj/ciHXSwNctyKBWqMmcfGj?=
 =?us-ascii?Q?OuuxBJvzkHvW6YeJx8yt/s+jWNDsXzgf7K4/e4PeQoM0oOE7jsUlt8RwwFB9?=
 =?us-ascii?Q?idr6gi9N5wb26o31w7gVrotHJOs6ay6G3lvxSztViJOTrDXP6XX8PGFk9Mjx?=
 =?us-ascii?Q?dpRz0G5u2+J/RxYUMbzgSbTAQ5qhaeF8/VkHf6Xq13w3UJnQoA0tyckIt/Wc?=
 =?us-ascii?Q?1qlnItCMHObM8wRNZ0yo8mIMZuN7tV4XTMAxnP31DU6AavHJtAA0lH+gRZxZ?=
 =?us-ascii?Q?pAuJ5/XEqMsR6itzf8KamCFmR/DcQYtuHcJCIrhc+Lxkq9OzQlX9jlL/ROkr?=
 =?us-ascii?Q?1ZoxPZCD5PceGJdfJ51wQ7CDGiQcEGgmEte83fbmCFbY+i4o22tB5gbZQ8fp?=
 =?us-ascii?Q?8ZvHn/2fhn/5lCr9TNIogSQ62Ykv4zepmPen+Xo63YqS2m5WF9eJxCPP1kGg?=
 =?us-ascii?Q?hUzqKI1jhqyBVK+UahWnr2YBFEdlFUiqrsbH/6jm3wUDr5n101MwxDrOeIx7?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e5bf9e-747d-4f04-24ee-08dc95c114e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:19:29.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZeE3f6bdL2AUI5DBdOltpDzm7AkxNV0SV7KXeTN22SvUXPGUMjjerVDQfxpzCnu2xXOZF6e+C8ik67NSJTA6J9ZeCjSZgV/rs+WPHlImwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5134
X-OriginatorOrg: intel.com

On Thu, Jun 20, 2024 at 09:23:42AM -0400, Luiz Capitulino wrote:
> On 2024-06-20 09:19, Maciej Fijalkowski wrote:
> > On Tue, Jun 18, 2024 at 11:23:28AM -0400, Luiz Capitulino wrote:
> > > Hi,
> > > 
> > > We have an Ampere Mount Snow system (which is arm64) with an Intel E810-C
> > > NIC plugged in. The kernel is configured with 64k pages. We're observing
> > > the crash below when we run iperf3 as a server in this system and load traffic
> > > from another system with the same configuration. The crash is reproducible
> > > with latest Linus tree 14d7c92f:
> > > 
> > > [  225.715759] Unable to handle kernel paging request at virtual address 0075e625f68aa42c
> > > [  225.723669] Mem abort info:
> > > [  225.726487]   ESR = 0x0000000096000004
> > > [  225.730223]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > [  225.735526]   SET = 0, FnV = 0
> > > [  225.738568]   EA = 0, S1PTW = 0
> > > [  225.741695]   FSC = 0x04: level 0 translation fault
> > > [  225.746564] Data abort info:
> > > [  225.749431]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> > > [  225.754906]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > > [  225.759944]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > [  225.765250] [0075e625f68aa42c] address between user and kernel address ranges
> > > [  225.772373] Internal error: Oops: 0000000096000004 [#1] SMP
> > > [  225.777932] Modules linked in: xfs(E) crct10dif_ce(E) ghash_ce(E) sha2_ce(E) sha256_arm64(E) sha1_ce(E) sbsa_gwdt(E) ice(E) nvme(E) libie(E) dimlib(E) nvme_core(E) gnss(E) nvme_auth(E) ixgbe(E) igb(E) mdio(E) i2c_algo_bit(E) i2c_designware_platform(E) xgene_hwmon(E) i2c_designware_core(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> > > [  225.807902] CPU: 61 PID: 7794 Comm: iperf3 Kdump: loaded Tainted: G            E      6.10.0-rc4+ #1
> > > [  225.817021] Hardware name: LTHPC GR2134/MP32-AR2-LT, BIOS F31j (SCP: 2.10.20220531) 08/01/2022
> > > [  225.825618] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [  225.832566] pc : __arch_copy_to_user+0x4c/0x240
> > > [  225.837088] lr : _copy_to_iter+0x104/0x518
> > > [  225.841173] sp : ffff80010978f6e0
> > > [  225.844474] x29: ffff80010978f730 x28: 0000000000007388 x27: 4775e625f68aa42c
> > > [  225.851597] x26: 0000000000000001 x25: 00000000000005a8 x24: 00000000000005a8
> > > [  225.858720] x23: 0000000000007388 x22: ffff80010978fa60 x21: ffff80010978fa60
> > > [  225.865842] x20: 4775e625f68aa42c x19: 0000000000007388 x18: 0000000000000000
> > > [  225.872964] x17: 0000000000000000 x16: 0000000000000000 x15: 4775e625f68aa42c
> > > [  225.880087] x14: aaa03e61c262c44f x13: 5fb01a5ebded22da x12: 415feff815830f22
> > > [  225.887209] x11: 7411a8ffaab6d3d7 x10: 95af4645d12e6d70 x9 : ffffba83c2faddac
> > > [  225.894332] x8 : c1cbcc6e9552ed64 x7 : dfcefe933cdc57ae x6 : 0000fffde5aa9e80
> > > [  225.901454] x5 : 0000fffde5ab1208 x4 : 0000000000000004 x3 : 0000000000016180
> > > [  225.908576] x2 : 0000000000007384 x1 : 4775e625f68aa42c x0 : 0000fffde5aa9e80
> > > [  225.915699] Call trace:
> > > [  225.918132]  __arch_copy_to_user+0x4c/0x240
> > > [  225.922304]  simple_copy_to_iter+0x4c/0x78
> > > [  225.926389]  __skb_datagram_iter+0x18c/0x270
> > > [  225.930647]  skb_copy_datagram_iter+0x4c/0xe0
> > > [  225.934991]  tcp_recvmsg_locked+0x59c/0x9a0
> > > [  225.939162]  tcp_recvmsg+0x78/0x1d0
> > > [  225.942638]  inet6_recvmsg+0x54/0x128
> > > [  225.946289]  sock_recvmsg+0x78/0xd0
> > > [  225.949766]  sock_read_iter+0x98/0x108
> > > [  225.953502]  vfs_read+0x2a4/0x318
> > > [  225.956806]  ksys_read+0xec/0x110
> > > [  225.960108]  __arm64_sys_read+0x24/0x38
> > > [  225.963932]  invoke_syscall.constprop.0+0x80/0xe0
> > > [  225.968624]  do_el0_svc+0xc0/0xe0
> > > [  225.971926]  el0_svc+0x48/0x1b0
> > > [  225.975056]  el0t_64_sync_handler+0x13c/0x158
> > > [  225.979400]  el0t_64_sync+0x1a4/0x1a8
> > > [  225.983051] Code: 78402423 780008c3 910008c6 36100084 (b8404423)
> > > [  225.989132] SMP: stopping secondary CPUs
> > > [  225.995919] Starting crashdump kernel...
> > > [  225.999829] Bye!
> > > 
> > > I was able to find out this is actually a regression introduced in 6.3-rc1
> > > and was able to bisect it down to commit:
> > > 
> > > commit 1dc1a7e7f4108bad4af4c7c838f963d342ac0544
> > > Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > Date:   Tue Jan 31 21:44:59 2023 +0100
> > > 
> > >      ice: Centrallize Rx buffer recycling
> > > 
> > >      Currently calls to ice_put_rx_buf() are sprinkled through
> > >      ice_clean_rx_irq() - first place is for explicit flow director's
> > >      descriptor handling, second is after running XDP prog and the last one
> > >      is after taking care of skb.
> > > 
> > >      1st callsite was actually only for ntc bump purpose, as Rx buffer to be
> > >      recycled is not even passed to a function.
> > > 
> > >      It is possible to walk through Rx buffers processed in particular NAPI
> > >      cycle by caching ntc from beginning of the ice_clean_rx_irq().
> > > 
> > >      To do so, let us store XDP verdict inside ice_rx_buf, so action we need
> > >      to take on will be known. For XDP prog absence, just store ICE_XDP_PASS
> > >      as a verdict.
> > > 
> > >      Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > >      Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > >      Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > >      Link: https://lore.kernel.org/bpf/20230131204506.219292-7-maciej.fijalkowski@intel.com
> > > 
> > > Some interesting/important information:
> > > 
> > >   * Issue doesn't reproduce when:
> > >      - The kernel is configured w/ 4k pages
> > >      - UDP is used (ie. iperf3 -c <server> -u -b 0)
> > >      - legacy-rx is set
> > >   * The NIC firmware is version 4.30 (we haven't figured out how to update it from arm)
> > > 
> > > By taking a quick look at the code, ICE_LAST_OFFSET in ice_can_reuse_rx_page() seems
> > > wrong since Rx buffers are 3k w/ bigger page sizes but just changing it to
> > > ICE_RXBUF_3072 doesn't fix the issue.
> > > 
> > > Could you please help taking a look?
> > 
> > Thanks for the report. I am on sick leave currently, will try to take
> > alook once I'm back.
> 
> I'm sorry to hear that Maciej, I hope you get well soon.

Thanks I'm back now. Can you tell us also what MTU is used for these
tests? Our validation is working on repro now.

> 
> - Luiz
> 

