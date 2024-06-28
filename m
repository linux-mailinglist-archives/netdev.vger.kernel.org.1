Return-Path: <netdev+bounces-107519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37A791B4E4
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 04:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B28A283C38
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FCF1429B;
	Fri, 28 Jun 2024 02:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6kknnjk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E463812B72;
	Fri, 28 Jun 2024 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540323; cv=fail; b=At5t6LvXgS7lYVmP/b4K1rTFa2uRR00+Hu9mcLt6fkqcs9Kr/yvkPGD8FtwTJUkTddS9+NBePo3HY7YNAux5A9fcPJlRYd5PY8kFUI1rV2U73s6TfwUCWG6NmhyL2WFneecoXUMMnOcCa9KVyK9IWL9ZGu26wk+PML/dor0LQJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540323; c=relaxed/simple;
	bh=RRu3MjRH/W/HtyP3W0jnnGlgggggOYk1L1MnoC7SKtM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Mff2paEI8LFRztLpYnXNJylvYo5pDzZk6u3ah02Zf04wmq86aOfW/UphAYkzfbl3KYw6HvqkvmFsvJIQ1xgCDIPdoJtb4jiWr17pxI0tESAcqtcN6AoNTWh9UKhsI97BySRpE2tX+TFG74Gkn9CMJsOavqi8CgweBnYIzbBpaac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6kknnjk; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719540321; x=1751076321;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RRu3MjRH/W/HtyP3W0jnnGlgggggOYk1L1MnoC7SKtM=;
  b=j6kknnjkFO5wzn1bpgOIgQqPDnSLuYPnwWfpJBVeyLsXua3gfzQnSLgC
   L94Z16y+crUNDN+dH1+ieQ83EJtN6f7uGtWHRQ596Hc3cqssLMFRo/Dwn
   4yBJcHKJmLml3FZcmm3v3gG+wWwbbBmfshv1w/hhQyyYotm8ozT5ofYmC
   fkkJCuhlaPUwMBsC6k8bIgzI8sTIB7hJ1ozYYXAoMKwxGuRG/SNXP6O2z
   WNVJ+T0LBxOL9q1/CKs0p9h7GzJ+ZFwh0oG7xRyCJTrf9zdzfyOVMqwaF
   YaqAke4WYHP5CAS8VNDql1pUZUI0uqDX9dloK9iKP8HCA+pFxdhS+AMPQ
   g==;
X-CSE-ConnectionGUID: FHvr6Zk2QZ+ba8X6Gn9srg==
X-CSE-MsgGUID: ROndT2Y9Q/m94MsSCzra1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="39225333"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="39225333"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 19:05:20 -0700
X-CSE-ConnectionGUID: 5BvIpwyiRU+kudxvpagZ5Q==
X-CSE-MsgGUID: sTJ+P6BNSeiZn/PoOVWlLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="75331731"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 19:05:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 19:05:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 19:05:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 19:05:19 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 19:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii8PGNlInuLUhPeTWgdqhr3vk4xXOKOC5aPF3W6BSAgvmH/qh6jqN2NBVV+i5ZdL3NLtHzFXKKVGmN4i2DtwO5uuKSqKado2QbB00UcSRjpAD/zH+IbwWjKizgMX4sljoUBCZIOmWbacjoAC0Vfj5fT151Xjc9I3Q+EE07fi+hBIWyruwYfBixo5/eN32h1X0o2QJ7Pd+ig0N/ZXPQ4tBWgqjKRCdovci8Cnzyg7QJQ6MlaGLqiNCqHe/tmtvhZrA+EgP0FlxL2FkZ2cw3yeouXzxeQgrehkIJbkfUUD9QL4WL4nRxU4eJCo7hjUPdzQRIvNH61sUEh0ngoOoozL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv2zaZYVLQZ14yLy9tngnHT+W0Y6OsQkHd7B+pZ03JY=;
 b=flmcTB2er8Vi7WjFpv1o6BI89B5HyUY6EL+pFC4GwZJdovY2n3SjU+i46wbjGUGaMaMPMYxlNydPr5p2tKBn7q5NJA6BBZ4khXlVsV8eU+NxrKZpQcJrkkV8D8Yg+1R7pJ0t6L12uvSgjxp3GXYoZOwZuY3RGNMmaSk+J4hBuvOa/GMk56tw8UXKhiWIlGpuwMyPnFWebMca/fdc5537SFw195kJ1G5lM0jp1jsfDz3QFSyOYRkJhJz6GGBOu2y12nDlbJbIK6GnmnuRsVFSVxQTfwu2HDvyV3wTUj0rTcSmRrYYTb/4T5f6kHQlL4qqVPkRf3DF8ET75qLQ9OqjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB5301.namprd11.prod.outlook.com (2603:10b6:208:309::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 02:05:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 02:05:17 +0000
Date: Fri, 28 Jun 2024 10:05:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [ipv6]  dfd2ee086a:
 packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-after-idle_ipv6.fail
Message-ID: <202406280948.73d69176-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: ed930c19-e3c7-4dc8-f301-08dc9716c151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+piliL3B5mYrVpLHJyiaUwOYcB2gtmsNoydCWmj2xJIcIHqzHeRE29c4S98K?=
 =?us-ascii?Q?B3axzRHZ4TvFFT12pjdhs/T5kmKTLX6N6iEn7oC5ptrLmWNbyfzL+sj3O/Lz?=
 =?us-ascii?Q?tZ5+PocluU0bnnitLgl1uq948m28oI7wVSTybvOZo0pAtEEmYcnJraWKp5FK?=
 =?us-ascii?Q?y6gTWWT2z1AhTq2EyeGz1lcVvAeMZdNovHg9qtyWWi7bQ7ijWJu2GNZ+ZcAx?=
 =?us-ascii?Q?JkFEByKKA93mSODt0iLG9Phaj2hET35HpZEGP9gpjlfrRQa3TYwR/IffvK0U?=
 =?us-ascii?Q?ZccHyOR6os6hg18zg0BDwfM5R3ptYJ32f8z27qHgSvjF4HfdcNnxgpxY/Wr8?=
 =?us-ascii?Q?RpjoFyEy3r6xh/DIPV/4OSRuXUDrjSTHvyEoib+5/DC5tS/JUwdmXXGJkoW5?=
 =?us-ascii?Q?O8ndG3b+vAWpJ9+B1SD2y2cI3SG7h5u9G6u7pC3MeOlrwGXo0MmxqTl/jRDZ?=
 =?us-ascii?Q?ZLaRcMA6dLXQ5gDv1IxQfXZ0CcGur77MM7+GwN6tyf8OTCKgdLfF4ZNYYam6?=
 =?us-ascii?Q?4Whaf6Ud0kuO+uguxr5qthvva9gde5OgAPdaADF5CGqnRMMxHSLm8fodHM/9?=
 =?us-ascii?Q?b4m3BLaJ4UC3ZrxXozWhQ6cqtrba3WWKuWOcKVeC2SjkUNo53523DvkfDnJR?=
 =?us-ascii?Q?yG5ziXjztiXNKVY2vNndmHN5gZKQHLZNWRDQPJksIqeL98TACFbruG6uXXeJ?=
 =?us-ascii?Q?XA/J2yvKHgE+rvBcXnfqlpT4BKuLOU+jZ4BbITRMq2n6xkDqgbpmVUiYhtBM?=
 =?us-ascii?Q?MKMwx/3U3O6ct9rniDq2GeD+uutwppCOO9K0+JE2bdqaK6tfs1mfgtTtfvM/?=
 =?us-ascii?Q?UoqUkh5wJmffXlU0iFjkcgoiN4z2WmWwWI+e2AdVZEVmClzw6whK3sc5ABuv?=
 =?us-ascii?Q?kUL8ihNSq3A9bUtEpJkLlFtRrRYqMEl3UXaWSeYkj3tww0aDNoMKawCdV5sn?=
 =?us-ascii?Q?GX12PttxU5F6BIGoy3KZ5PbPU+v/b0BzEnTf3bH17sWOG+8lJkULVSDHNQeO?=
 =?us-ascii?Q?LP7/UpEoB/QOb5pGsjWW2Hr7pWUrv20bPgqox4GxGP9ss35QIZlK/pWN8JgV?=
 =?us-ascii?Q?C6VD+TbJefnsb5AwdEMvQgF/LNudrbP7UNqDeCW3KiRJsifWcGRNE4vyHpty?=
 =?us-ascii?Q?GaNBsXCUATHX0Csd9gI1LvaNLM8KxDuqLQvBTbRZssMsLIiUhblM/ploFEyu?=
 =?us-ascii?Q?SQQOTLoeDw2Is0Pn869zriGAD3wjCNpwAZ1RpZhdGTDgh6YFJopBfow2GIr4?=
 =?us-ascii?Q?VZ2X4Y2gsiZploTjDWhU5Ad9WOh8+Fx07BuidpWQbgXU/rHttqqenldAr9DO?=
 =?us-ascii?Q?Vo8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FhOAj0/1fycMF72/1XgZwhH9Tm2fvCbQeZW7hd5Kd9FyaR8Z5n2y5HDt2dR?=
 =?us-ascii?Q?QKdC6H5Nxe6A+sR28kVv2tyDP7amgSDddX5YUkVdvRUc9xO+SKf/TIR+J/Cl?=
 =?us-ascii?Q?wsXZCqK0/1e3hK5gucdr4dxB0uUC7nsVOgqEoh73/f78eRWhkYKGqist8RaA?=
 =?us-ascii?Q?ytqKOLbgl7y4oaRfysWqC4ukvC5zR2iXwM1on2bUlbblAjoNTBn/km5qgMtH?=
 =?us-ascii?Q?1hedm/Lgvw0w7GeYj+mGf66U0AcYND0SH/37nH/Fs9dZhwuFqlk46qlmDTvh?=
 =?us-ascii?Q?0Fhc1aJPimf5Dg9MUuWaPDFT7oxydDn2wVgVgU/H/ZMIZ+EbibEbAd4ph3vR?=
 =?us-ascii?Q?5a3iAWyhiNhM+bDuaxoURKoLCn23LrRnFi+eqndGt3ci7AAHJpUnCybz/VWC?=
 =?us-ascii?Q?iDddkSOo0idiezdj5vMXQgFiLGQ+nIVwp15NF6jyn5hT4TagznyyOvOia3ms?=
 =?us-ascii?Q?kwQdRUNHPbwNt1hdsv0ENd1E2kkh58RvJ1Rg5UaJhoujf52d6riTVk11Rrfd?=
 =?us-ascii?Q?mpqORKdzHPJ5SffqDlFlosl4ig6D4YFC+tm/eah7CjAizXKqbQwRIDeZH3xB?=
 =?us-ascii?Q?cbj3gtTqU0FEtw5naI1LyZglU+DBL9f/PoKbQS39MWhnnJIbZSk4DmkbEFw6?=
 =?us-ascii?Q?BVFb89DRRbRZpJiMY5BjhFVzO9v5YwVUYDV4hKe+z2awqso/jrU11g6xSrR4?=
 =?us-ascii?Q?wKAwPGaXpzx0tGn3Nn+UBgCHTLbUrHmOmbKp5zocbPqretYrk9/GpPjyJ8s9?=
 =?us-ascii?Q?FlBjWrYsvyK9D5f0+O6cDyATVuoGojHz8juN5PUQiD79lzwSeoqtPRl63cqL?=
 =?us-ascii?Q?1VpYyO8up1+ePuZwdtUWy2W5eVizMoiNpgEHLQDFWbeFDRSwwiD843sU027O?=
 =?us-ascii?Q?c0dt9/We4BJlerq6SI/gQUstGMjJ8bMQEZFU/RtG37cPjLIAX+AJ9ygSzdtQ?=
 =?us-ascii?Q?DD6Ein7IhgyUB2rRDcgEi0/zC4AN8fFqXFNUycmCr1+18rSPzQXlvu7rT0ZL?=
 =?us-ascii?Q?DmZqvojvRsCwMfB9IIZdN2AySWx6czsShvzRMOZ+4MHleCQAd1LZIBYKH2zn?=
 =?us-ascii?Q?n5x0EA8Sh621MyvtlFrhUr/s7hbJB1MYb1hZU5t/UediEWBZvw5U8oT7RDXM?=
 =?us-ascii?Q?28HKBkwmG/xfLJ5bsi3Jl3VJ3Ww5fiFc7gtc/26UyQvEflPj9+a+KfxGowXe?=
 =?us-ascii?Q?opJMOaKRV1PoRiClZeR+DQCsrmTpG7kesP/2vWsyE4lXU6AQTJZiM8xO81G7?=
 =?us-ascii?Q?Zyjdfm0BXRS8rsTsbPqqB1+ptxwPF6e2Rgp29JV+WS88FD/DHUf6c1HPIsvz?=
 =?us-ascii?Q?ckBK5s5dWlEWxR4ZME9VR8Tj1a++6zb/nlXSFGbsUSsiyhhsDpeddbJAy2Yo?=
 =?us-ascii?Q?eyljoenRWILYnpTEduMjthxJWPVNgF99r223Itt+p8SJTgPziXw2jG40Xgr3?=
 =?us-ascii?Q?KehtAW9w+bbgg97VsFwAlr4JHCcWtKHGnL9Tm0STacuiiD2KzTYDMICU0QUT?=
 =?us-ascii?Q?z5dDhO4oBVUj4Oo9fclGFWyRSOAlpWi+4BlioKfMLXVzD8Rk1gPKRsoKCWPX?=
 =?us-ascii?Q?DhXIqYAFzkeYRgBy36KD3KCcJaL3GEQqbLPwwwUa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed930c19-e3c7-4dc8-f301-08dc9716c151
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 02:05:17.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAGF4uUmIyF6Gv6PmD13PGO8gKpXgdHFsUGe/J+mP1YGs4hmi/q109hD/Def3sG1hn7N9IX3xI8id3ApM8ZU5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5301
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-after-idle_ipv6.fail" on:

commit: dfd2ee086a63c730022cb095576a8b3a5a752109 ("ipv6: make addrconf_wq single threaded")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      e5b3efbe1ab1793bb49ae07d56d0973267e65112]
[test failed on linux-next/master b992b79ca8bc336fa8e2c80990b5af80ed8f36fd]

in testcase: packetdrill
version: packetdrill-x86_64-31fbbb7-1_20240226
with following parameters:



compiler: gcc-13
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed this is an ipv6 related change, we observed there are quite some
'-ipv6' tests failed on this commit quite persistently but keeps clean on
parent, e.g.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler:
  lkp-skl-d08/packetdrill/debian-12-x86_64-20240206.cgz/x86_64-rhel-8.3-func/gcc-13

f5d59230ec26aa5e dfd2ee086a63c730022cb095576
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :30          70%          21:30    packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-ack-per-1pkt_ipv6.fail
           :30          90%          27:30    packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-ack-per-2pkt-send-5pkt_ipv6.fail
           :30          77%          23:30    packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-ack-per-2pkt-send-6pkt_ipv6.fail
           :30          83%          25:30    packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-ack-per-2pkt_ipv6.fail
           :30          90%          27:30    packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-ack-per-4pkt_ipv6.fail
           :30          70%          21:30    packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-after-idle_ipv6.fail
           :30          67%          20:30    packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-after-win-update_ipv6.fail
           :30          73%          22:30    packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-app-limited-9-packets-out_ipv6.fail
           :30          73%          22:30    packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-app-limited_ipv6.fail
           :30          53%          16:30    packetdrill.packetdrill/gtests/net/tcp/slow_start/slow-start-fq-ack-per-2pkt_ipv6.fail



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406280948.73d69176-oliver.sang@intel.com


below is just an example, more details are in [1]



OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/slow_start/slow-start-after-idle.pkt (ipv4)]  <-- ok
stdout: 
stderr: 
FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/slow_start/slow-start-after-idle.pkt (ipv6)]  <-- fail
stdout: 
stderr: 
OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/splice/tcp_splice_loop_test.pkt (ipv4)]



[1]
The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240628/202406280948.73d69176-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


