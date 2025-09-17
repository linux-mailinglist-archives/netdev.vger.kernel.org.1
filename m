Return-Path: <netdev+bounces-223891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1514B7D733
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760267AA77F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F372F6589;
	Wed, 17 Sep 2025 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmYGy6xp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92E2DE202
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094812; cv=fail; b=Pno6Z40hLm0tZKWpwWs3cI5TFjW3ieyXR0YAWA5O9m+i1kDHh3bze20FQzUIJhmKqig+KpYUq3u0Ab0C9quCkMqIUYpDPJKNz6brwNFnEXrvEwYZvJeX8GsiVRvcDtaZrb2VfFYXeBS/2erydvkBAoqVgZe7t97Xmj6XXuz+kLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094812; c=relaxed/simple;
	bh=TxfXrPwG/mGOeof+KOqIhDZf+O0bt/AgyM7MadRhVPs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qZiUROQkuffVrxYkuZzAgre98nVTGLfujis4abDSLOY5+YZ+OgYw27Z2V+3SQW7mFRgocrubNpvojwLw0TWM4GLFJ0QrZcoj8X3z6tCXS6sfjIMiOPiXNyAsP//Gs9UsmnYqiKt+d/SsVhwwtnvR7Y+hVtFhgEswt1kw7j4ewz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmYGy6xp; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758094811; x=1789630811;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TxfXrPwG/mGOeof+KOqIhDZf+O0bt/AgyM7MadRhVPs=;
  b=cmYGy6xpZIRYpeSm3uLX80JeL+CYaD3wzZ5PZ6krw804cLosKbf98gzn
   2SaJmpAYnC31kjC0zJHChRQ0WhdjPNIMZANdn19WIdZIbEEZWWv1BsSr4
   aZRq9XsxKm+zkAVjHV0NgidiFO7/4OLsubw8fK+qcWKse8oSnEH4FhB93
   rZJJAXx37FDOJFaP0GKToXhOort7/mn5rk6uNgDSP0Y0/iuceG3yE4ndL
   Z2Mz2jFb9gxCe61CU+L3GJkFrPXqtxIlc9lXIBhhWzA7OrS7BaEsa5Cu0
   S6SSjpcg6nhAvJK1/E84GJjTDYhmfhx3Tq0rH8l4+r4v1vtgQbnqjoUoC
   w==;
X-CSE-ConnectionGUID: QPlOPNyvTdC4Wr4bI+r5SQ==
X-CSE-MsgGUID: +wjwaN9MQIWp4B4Hk5UiVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60500818"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="60500818"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:40:10 -0700
X-CSE-ConnectionGUID: PaUsD5DkRoqx2Vrq3isCSw==
X-CSE-MsgGUID: avjFde+tR2GlznRMJ0Vfog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="174738549"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:40:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 00:40:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 00:40:09 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 00:40:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZTc7HV4AZf0ZoYBdesNugS61JoMhiSQ8FGDoCR/DP9bz3SHy0aV0OggJcIE4CFHtGrxBKeBGqEVvhAf9ItoUhljIG/YdZhgDHwimWHt6WnG0kV0e++KooB8IitA00qxsCnTc2KkGD8qV5+zXxptjOnDXhExK6qRkKSXziGMbmXPwDbVsjy6oc1r4h5GIGYrIAhw71D2gpumSQZA+9oPESjVnK/4gDpKEi7xNJAkOBw+80Yyb1br9MjRVl9EsjiFXiZnDYmV6FnG+ibYI7apOoTkkm5xmF5JWzfSbvmqbasQ7brZCznnfwTmS7Lp8RNpxDRpl5hTChESPNQBUW1xaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6q7dZzrBj8piw85Yh+uCuta7J36QvuhfHR2GDKiofc=;
 b=U4OXalIZM5J/MmA4e1Bq7rvUaFTGmsvYaXMveYml033hdJc300YRIb28so4WGvNkhXZXP7cwhzRKMpqqAcnp97jHzihyBaKDJt18TLvvNRbXqX0WBegIoKfChrXQ39Q6TZ/S5wxu1Dko+e5sUeRsIqQHjG6SBpNanPeGREio3Lv5P9r1jvOSAFJd44O1yFDgcHd0BrvjFxGzhVpr/dPltIZKD08vG8OdIU7CgvhU9J0gMjfkGYq61/K1CdVBdlodqogaNrZe1TBgE51WU16HgJXz9zveXinDGk1sDrT5875Xm8AFusPW5iShMa47Ck5+Gf0/7Iiktffnz1z+kdUkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ5PPF8B3F23403.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::842) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 07:40:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 07:40:06 +0000
Date: Wed, 17 Sep 2025 15:39:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [net]  ec016f0a7d:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202509171502.9b679aa8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TPYP295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ5PPF8B3F23403:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ac6b94-2aac-4f7d-110f-08ddf5bd6bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0R0F/yN9kjZRmR6JyeLBL61LNOJVXIugIgDuuvJhh9hgq6zyqR/POkojm1SQ?=
 =?us-ascii?Q?aFLglz8z5MCAOBNsqTONCbfipohoI4dH5ExFwoAGp+wKav+Ij2VcYledorl2?=
 =?us-ascii?Q?OhvXVDXZYv4qX7OkTlenLtoKEJwFfm1uIWMIrrOUVPT4oQuVx00fAwiJ/zfs?=
 =?us-ascii?Q?MXRd2EdvuLriSTKrrVhcpuyKzcpqPxAnU4RwX5oRipago2AKFX51vhEVSnHq?=
 =?us-ascii?Q?/OrfIlDGbUVOgjd6Ea1cvs0r1+dbjqjRt0zSLkf14KoJ8ZmlgJ0MXzSAQIBi?=
 =?us-ascii?Q?xpPBHBvW41HdCIKrnvtYbdWXNha65sP2bI0lfw1rOsCkWYLklgvUHtpXEhU6?=
 =?us-ascii?Q?tv5hz0dw+rDkfJbV+pNayA5wi8q57Kda2sAgwcWdOb/NwNG8cpkY4bZSxlJN?=
 =?us-ascii?Q?J0mwqHo87c78qyLSrF9J+WPbNlmpTpQQehiajXoclFkVkOfUWgxVWdjXIgpB?=
 =?us-ascii?Q?ULfKka6EO+CBlqdJjEXoCWl9vpuPHQhOd4gE1iDcvFWl3pXmaWBNgU6jg1xt?=
 =?us-ascii?Q?z0TJv1ZMA1YS4hEBTFV9D3C6Yl9uT/1A7Jnjy86xPriZQW1CvrDYMfQji1Ly?=
 =?us-ascii?Q?8zrbYduGCGhAdneLAI0li2jnpGGMIf694I4SltSuJI0ZR9WNsa5etw/hkEXX?=
 =?us-ascii?Q?l0BmU42G1Oxtv+C8JMX5/ncLprNirgg9MaXdsug7StXZd3MXD6Z53NgfSILk?=
 =?us-ascii?Q?3iaep9tLzr27etQ5icC+gHNDsw8ZRcbAgNAO7RRE0QUSP+vfw2C1FTIIABia?=
 =?us-ascii?Q?p88OGfKhbfItj+2jYFugqqFoB+k+ahsZCmN9yi6MKMoFcgHrxnuEviVUpdHl?=
 =?us-ascii?Q?44fvKWcLZoXyV2zoUyZliCvpCmoVLW7i0fEDE7Xio8s29GEHv2n25nD0uent?=
 =?us-ascii?Q?i5wug0WuNxwjKqRVoH/sgBhtsa/dziNpVWfyHgTefs2P2dSgd4I6c1EJmy8H?=
 =?us-ascii?Q?B7IeGGmZiWn4rLtUa/wWvg/TFmo5I7AR5myH/2mdiJIHvO2JLpdKPeNtNZT9?=
 =?us-ascii?Q?3HmynSWzNXMWgoJ7qzUQJBC6JKe9Ip6s4qNWAZDwOiE6xQyGooDMO90lDPgU?=
 =?us-ascii?Q?NGZmNCM50gp5ZUbuDoZunTWGOt93VihSQF1yjGYN514DBPx2dmVcfeQafGCj?=
 =?us-ascii?Q?m0msk6fkuIAA8Igd0TK6kPEtPCf3BElON2B+jMxPrBEqgl1zQrM6owNCH9rc?=
 =?us-ascii?Q?VO8Hpf0OZq/E0nh+bU3/R7HUhpJuNGcQ8d0lDELDMQg2jcQ8KL9yyyPKdNyq?=
 =?us-ascii?Q?XgfDLyMJ+RdEv7pkGXoaOJUgLc94zVjo5u/hIKEtk7yMZNQB0JmYGzp/8gYS?=
 =?us-ascii?Q?p+qVSSpAfhvVHvrnFa9Ahu9V6LZXVx0+M4+HK4OPEZ3wst/U1jnxbsNBgZiS?=
 =?us-ascii?Q?oNNNls/e70HexWANwkdQhnwnJIQa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+qoPHNB6P+xp6iyZnsWcofKOH633rWcbmejafucWs6qMEq6QOyzHVwlAeeTL?=
 =?us-ascii?Q?Jqju9UtHdrJxN0JtTnOkxlzbl8qhYXyfwvzJteWAbO/SxsDgxH0omwGNy5tv?=
 =?us-ascii?Q?BSbc+3PSbHKmp6kaBcFqjnLDLEFgd3pysDGmCv+eK4L02iHptgTLxz3NERKb?=
 =?us-ascii?Q?jaCcb19txlVRK6C2742VuofICRnZqruRLpZxTdKu2KXQvRo8HxOlbCeSt2pb?=
 =?us-ascii?Q?mdehP5RGjoeicHDwvwpw9rgePcRcN3uwEyyIzSBxr3Cqy27YbLZWIDX1wk77?=
 =?us-ascii?Q?4GrBP+jZloGb4hehGFE0V6t85fdOHbcqcBRWbaczeu2Urh7aq6N4GKebFpQc?=
 =?us-ascii?Q?NdlXgOkaNO4/hUMSR/KGn6Q/PTHWp3ZqrO3WzSvq7n4bXlY0KtQJhBUPI6gO?=
 =?us-ascii?Q?Tunp/5DpMi644fV/ynIYjcNL7NJzropvJSvlS7Sgifxgglmba3tlmJSayr5w?=
 =?us-ascii?Q?pICDbOWseIZkjYwfAKrr7loYWYr3OcaLePX/DlMbh3je45hJSz/GJZovx3V7?=
 =?us-ascii?Q?BD4Idk+SnPcMSsAFB5pBzr9vG2v7wKqC01S+I9TnhCtwjDlW6WYSnhekUtMn?=
 =?us-ascii?Q?uXgUpx6Bp243J6rCvmvOOx0S/1wXOTcEw0pZB3BFu4GSimfxgeLcavdTLLhP?=
 =?us-ascii?Q?PT+br7EEuBpf2xxGAXHipr5+ToEA98iNNpYzSKl8+KkqsG6q2cN2zv8fmEG/?=
 =?us-ascii?Q?M57ADg9V5WiFqg9Gww8Cz5iqBzhLJ9UXxA0GJqgWI4U9ZdGgoJ6zv/drAh9p?=
 =?us-ascii?Q?ClBUcX8S24TeZsg/oJt3dvUl8mN/DOl8HMtriPmsectjNp0YDvdtWjPyZndx?=
 =?us-ascii?Q?SmuIhSN/1lSaaUmLZgMFCWoWDH+ERPvpIwjaA7a0dqv/A5wnzrbo3yjXXzWs?=
 =?us-ascii?Q?YSM/YiOZD7L47RDFL6mtaz/z2F6U1h3dTxh1RAhWInsnZrlkUZILW4nyUBWO?=
 =?us-ascii?Q?GAQ3ISctnR6NinRMertKkayjJQQWFEkT1rjKX7nYxcaU+CIXS36Xtl9tsk7q?=
 =?us-ascii?Q?CjBxhyrSFkpqhK7HEWMnPujIZh0XK5IcQDCj3U3r8s7p5Ncvbctg/8yG8ucP?=
 =?us-ascii?Q?aO1qV8ltGIeQiN+rw5qRvGNk46RzddSXLkMGhY2LjdwIGIZ8TMx2EiBS8YJB?=
 =?us-ascii?Q?u6HPqOuEZyNnyCR0oLrafEqeRFutyLLepSAOKKtnBl5iXIoH6vXVFOg25nMV?=
 =?us-ascii?Q?nCUDtd8H9la1WRSFZsI7ZTKDizUv8eKNvQpemk9o0T8rOUscoyeXGeX9Vdos?=
 =?us-ascii?Q?gMagEYGYLDNRyxE1u0H8LAXMW8xS1CcgjkZSoxP66MQzRVRqzN2RTiiE6ZNJ?=
 =?us-ascii?Q?BH/xZJ/Q+R/spWhzz61EdghBmyt1dEIhd42q1NcCAYgzMidlErVoGWV6K8lR?=
 =?us-ascii?Q?BxQLGDM/i+MWNRLo4cDsifWGbTJD0mrNydLZqm6bihlrh4Eb+j9DOws46Q3/?=
 =?us-ascii?Q?qufn8rAwk8jaSPE7gewAwcEcMeuo7iJ/+COPQVEv/W5b2uYqjco1HgoNk6Cl?=
 =?us-ascii?Q?cx512DksLszcKPUp5MlZgZKueq3jkG1GfPzeI63UHCDXQizmXykid9sSG7ag?=
 =?us-ascii?Q?W7+FfuOPupuiueJ1/uWAmweU4nciEa0d9D3xWE0A5e64ib29DAnk1DwJXtNz?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ac6b94-2aac-4f7d-110f-08ddf5bd6bd9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:40:06.5914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDVqvWDC8D59HZAbtVV4L+M6S4uhFzMhrQs4AF+IHJwXPTGuZ6Phk6FoG2unBrViIeJckmTIF6XSVIwBCI3DDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8B3F23403
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: ec016f0a7d8dd03ecdb19906da9ec617981aab93 ("net: support ns lookup")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master c3067c2c38316c3ef013636c93daa285ee6aaa2e]

in testcase: boot

config: x86_64-randconfig-073-20250916
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------+------------+------------+
|                                                   | 29ff7e9e30 | ec016f0a7d |
+---------------------------------------------------+------------+------------+
| boot_successes                                    | 10         | 0          |
| BUG:kernel_NULL_pointer_dereference,address       | 0          | 10         |
| Oops                                              | 0          | 10         |
| RIP:__ns_tree_add_raw                             | 0          | 10         |
| Kernel_panic-not_syncing:Fatal_exception          | 0          | 10         |
+---------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509171502.9b679aa8-lkp@intel.com


[    1.560130][    T0] BUG: kernel NULL pointer dereference, address: 0000000000000028
[    1.560931][    T0] #PF: supervisor read access in kernel mode
[    1.560931][    T0] #PF: error_code(0x0000) - not-present page
[    1.560931][    T0] PGD 0 P4D 0
[    1.560931][    T0] Oops: Oops: 0000 [#1] SMP
[    1.560931][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G                T   6.17.0-rc1-00021-gec016f0a7d8d #1 PREEMPTLAZY
[    1.560931][    T0] Tainted: [T]=RANDSTRUCT
[ 1.560931][ T0] RIP: 0010:__ns_tree_add_raw (kernel/nstree.c:95 (discriminator 1)) 
[ 1.560931][ T0] Code: 89 f4 53 48 89 fb 48 83 7f 18 00 75 04 90 0f 0b 90 4d 8d 74 24 18 4c 89 f7 e8 05 ff ff ff 48 8b 43 08 41 8b 94 24 a0 00 00 00 <39> 50 28 74 04 90 0f 0b 90 49 89 df ba 00 00 00 00 4c 89 e0 49 83
All code
========
   0:	89 f4                	mov    %esi,%esp
   2:	53                   	push   %rbx
   3:	48 89 fb             	mov    %rdi,%rbx
   6:	48 83 7f 18 00       	cmpq   $0x0,0x18(%rdi)
   b:	75 04                	jne    0x11
   d:	90                   	nop
   e:	0f 0b                	ud2
  10:	90                   	nop
  11:	4d 8d 74 24 18       	lea    0x18(%r12),%r14
  16:	4c 89 f7             	mov    %r14,%rdi
  19:	e8 05 ff ff ff       	call   0xffffffffffffff23
  1e:	48 8b 43 08          	mov    0x8(%rbx),%rax
  22:	41 8b 94 24 a0 00 00 	mov    0xa0(%r12),%edx
  29:	00 
  2a:*	39 50 28             	cmp    %edx,0x28(%rax)		<-- trapping instruction
  2d:	74 04                	je     0x33
  2f:	90                   	nop
  30:	0f 0b                	ud2
  32:	90                   	nop
  33:	49 89 df             	mov    %rbx,%r15
  36:	ba 00 00 00 00       	mov    $0x0,%edx
  3b:	4c 89 e0             	mov    %r12,%rax
  3e:	49                   	rex.WB
  3f:	83                   	.byte 0x83

Code starting with the faulting instruction
===========================================
   0:	39 50 28             	cmp    %edx,0x28(%rax)
   3:	74 04                	je     0x9
   5:	90                   	nop
   6:	0f 0b                	ud2
   8:	90                   	nop
   9:	49 89 df             	mov    %rbx,%r15
   c:	ba 00 00 00 00       	mov    $0x0,%edx
  11:	4c 89 e0             	mov    %r12,%rax
  14:	49                   	rex.WB
  15:	83                   	.byte 0x83
[    1.560931][    T0] RSP: 0000:ffffffff83a03e70 EFLAGS: 00010202
[    1.560931][    T0] RAX: 0000000000000000 RBX: ffffffff85498f40 RCX: ffffffff84bee420
[    1.560931][    T0] RDX: 0000000040000000 RSI: 0000000000000002 RDI: ffffffff8503bbe8
[    1.560931][    T0] RBP: ffffffff83a03e98 R08: 0000000000000008 R09: ffffffff84bee420
[    1.560931][    T0] R10: ffffffff84bdd7f0 R11: 0000000000400000 R12: ffffffff83a89ac0
[    1.560931][    T0] R13: ffffffff83a03ea8 R14: ffffffff83a89ad8 R15: 71f2107931861b27
[    1.560931][    T0] FS:  0000000000000000(0000) GS:ffff8884ab11b000(0000) knlGS:0000000000000000
[    1.560931][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.560931][    T0] CR2: 0000000000000028 CR3: 0000000003a40000 CR4: 00000000000406b0
[    1.560931][    T0] Call Trace:
[    1.560931][    T0]  <TASK>
[ 1.560931][ T0] net_ns_init (net/core/net_namespace.c:1312 (discriminator 1)) 
[ 1.560931][ T0] start_kernel (init/main.c:1079) 
[ 1.560931][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:307) 
[ 1.560931][ T0] x86_64_start_kernel (??:?) 
[ 1.560931][ T0] common_startup_64 (arch/x86/kernel/head_64.S:419) 
[    1.560931][    T0]  </TASK>
[    1.560931][    T0] Modules linked in:
[    1.560931][    T0] CR2: 0000000000000028
[    1.560931][    T0] ---[ end trace 0000000000000000 ]---
[ 1.560931][ T0] RIP: 0010:__ns_tree_add_raw (kernel/nstree.c:95 (discriminator 1)) 
[ 1.560931][ T0] Code: 89 f4 53 48 89 fb 48 83 7f 18 00 75 04 90 0f 0b 90 4d 8d 74 24 18 4c 89 f7 e8 05 ff ff ff 48 8b 43 08 41 8b 94 24 a0 00 00 00 <39> 50 28 74 04 90 0f 0b 90 49 89 df ba 00 00 00 00 4c 89 e0 49 83
All code
========
   0:	89 f4                	mov    %esi,%esp
   2:	53                   	push   %rbx
   3:	48 89 fb             	mov    %rdi,%rbx
   6:	48 83 7f 18 00       	cmpq   $0x0,0x18(%rdi)
   b:	75 04                	jne    0x11
   d:	90                   	nop
   e:	0f 0b                	ud2
  10:	90                   	nop
  11:	4d 8d 74 24 18       	lea    0x18(%r12),%r14
  16:	4c 89 f7             	mov    %r14,%rdi
  19:	e8 05 ff ff ff       	call   0xffffffffffffff23
  1e:	48 8b 43 08          	mov    0x8(%rbx),%rax
  22:	41 8b 94 24 a0 00 00 	mov    0xa0(%r12),%edx
  29:	00 
  2a:*	39 50 28             	cmp    %edx,0x28(%rax)		<-- trapping instruction
  2d:	74 04                	je     0x33
  2f:	90                   	nop
  30:	0f 0b                	ud2
  32:	90                   	nop
  33:	49 89 df             	mov    %rbx,%r15
  36:	ba 00 00 00 00       	mov    $0x0,%edx
  3b:	4c 89 e0             	mov    %r12,%rax
  3e:	49                   	rex.WB
  3f:	83                   	.byte 0x83

Code starting with the faulting instruction
===========================================
   0:	39 50 28             	cmp    %edx,0x28(%rax)
   3:	74 04                	je     0x9
   5:	90                   	nop
   6:	0f 0b                	ud2
   8:	90                   	nop
   9:	49 89 df             	mov    %rbx,%r15
   c:	ba 00 00 00 00       	mov    $0x0,%edx
  11:	4c 89 e0             	mov    %r12,%rax
  14:	49                   	rex.WB
  15:	83                   	.byte 0x83


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250917/202509171502.9b679aa8-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


