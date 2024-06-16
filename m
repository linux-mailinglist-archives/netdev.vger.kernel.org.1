Return-Path: <netdev+bounces-103834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CE5909C6B
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 10:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494B01C20A30
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58B16EBEA;
	Sun, 16 Jun 2024 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbAoFz4p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DC163AA7
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718525179; cv=fail; b=TvRnsmNAv+gEec204EOgXiplttghWN786/Vs+rG9W+DhUaVYkNP6RDd8UaSmdeO1qPucjcYnq1OuEmAqSLKsLWOVV/CH8kSOmhMg/cdW2Sc/cwGhAw4CObICAKR4gqsD08n728vNwHk8X7bL9JBH5km7J2N/7IxNdfgPwWWdG0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718525179; c=relaxed/simple;
	bh=YYcnYbYG623/T+O3k7rLvcmeUE/i3dixemQyV9FMjBg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E3oDnWTAFUdRWrMy+Hi9GMiihEDoZ/8sEu6C1aeR/wHUNpCMOx64+bjinbpIADBd73jp5++yRzqIvWhd+tcf4s3k+8/4UjASlppYQ9qjlteKX3CjjMAjpSIrzGw67/4RACFcuoE9RkWzAeBy7J0fBtP5MNUWkX+g6Gla7IbMudg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbAoFz4p; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718525177; x=1750061177;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=YYcnYbYG623/T+O3k7rLvcmeUE/i3dixemQyV9FMjBg=;
  b=hbAoFz4p+QU0NK2er8v+c/Z4DiCqiLixGSYtpn4ZXVt5tHftYSmsfzMP
   Rv99Dw4bixovKFjsRZ007bp4cOzPlelRirQHd0Q0lwq4VPFku6gwdij/Y
   b5QMvbhIuZFtJQ+C3RryhtaM6lXXhY6NKvFwDH6NnCGA/sinSZcOPmpAl
   C5HLvGNnpovQmevn1e5SnjIVBUXnyk5yXfKzFbRJCd6v1XbIIVtORko3a
   gOBEY6Ds3lsBdPrjx/48/iIMp2frKisOsHCeWbSUCf7CfG2ny9EEsNBGR
   qlZZWCzJjZGQeR9Djzlf8wjv7+vZqcGmfRLQWUOwAo25g8TzY5MJYJN5A
   w==;
X-CSE-ConnectionGUID: yqCI6PB9SrykgDhM4k3h3Q==
X-CSE-MsgGUID: 3AkKjidFQoq83s+62nBPBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="37897383"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="37897383"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 01:06:17 -0700
X-CSE-ConnectionGUID: wM0e8ErTTcaGENoO+AAbEw==
X-CSE-MsgGUID: hAK9NQ3QRx20bmfgmSpGNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40847803"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jun 2024 01:06:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Jun 2024 01:06:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Jun 2024 01:06:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 16 Jun 2024 01:06:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 16 Jun 2024 01:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFv8QsDh5YOinUlzV+RQtV7hHGk97jlcXmLl6/KWmeKTAmiPI+KZqkMLLJp5CqFJVD2D3WQ8zyrgN27WkVIXOfYAQk6L4HKo905gINmeGkSAmBBXBPPUQolJhnss8/ArPb2Z79hoab3jmVTlx3afSQZkdFiGb9Q8vrbiEcvaGYjX4W3aD1NIdwRCG6RZinrGhunW3OxT09h4FJz/I71GO5lclN22hC22PoI/16IMiwjV6DCUqNkbZa5C14Qayuvj+d/mWdyfxBwpzM8Hd6nbu3I3mEh+dTEoz/b93OwsdYl05tC0FJUGkfXOEcDA3BIphfYk/rgK7Bt/la17H/um/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFCrmQxU5uRF+nXj9Wh6Pt2VpRJA3wWH6CkVtSETYUw=;
 b=d0766qb4oTvUOZEUQdh8SxVDBKHcjzb7McQZPV9M5RyReXMa3+s3BUvTVhAIuLCYIpQYKnF9cL7/oxj5dM3jVH1ysRSsKEjzazsoreL/26P/khDiavFzKsbVyAYFGIkKAzdk5Z0VScQTHTbE7paqkxzxU19aQ8SecYckssBQDOMuWAv+3ScljGgWl/ezmmXYIaU5+FzyCJdqhX1gHWHNZEKMeLSgiclvA/B7l4W/PiVvMwv2uNe1QIxIXhjQKOyP42wruZYddqkSWDWj9heQq8uYGhIAe6WquJERvqjoMpn5gYR9W/BoVQ27sZjxm0qVWOIiR/+CpDjlXhhrOL5+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7246.namprd11.prod.outlook.com (2603:10b6:208:42e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Sun, 16 Jun
 2024 08:06:08 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7677.030; Sun, 16 Jun 2024
 08:06:08 +0000
Date: Sun, 16 Jun 2024 16:06:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
Message-ID: <202406161539.b5ff7b20-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240613113504.1079860-1-sagi@grimberg.me>
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db45735-272f-4e7f-0992-08dc8ddb2d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AlNtavveUKKMLx7Nk2Fwy/AZ853dsonxrvHQ7L239cz5emsQLoIULSctuz5m?=
 =?us-ascii?Q?DVQh8OI0rqIvKM7+fBVk1if3rjPy1PVSWZ1RjKgvndqfQV6TGxsZnQqtdiW7?=
 =?us-ascii?Q?zQZV8nxY5InXYifgp/aRrSYnDE8AwOBbxw1KVX6/HvnA8rkDQ2iKG0n5XIFB?=
 =?us-ascii?Q?HZMIsvkSX1GjriZI95c43f4MymPVrWGu3czFUdOD0APlWfecD85HVCrAcpZq?=
 =?us-ascii?Q?m4SK3+nuGa2j2PzW5r802HdyqTX/+susMqu1aeqK8mlB3jqnlVE/rk1RqrVo?=
 =?us-ascii?Q?2D+GnYItSaexFjscRMLHZIsECi6VjjQx70ieMaOOFa+Djv+wa3JLIbds0WeP?=
 =?us-ascii?Q?EjHjY6m78hyiN7YZdaImoqr5K3DlhhwThU8iP+5BPZcK5mqPcr4iSGGkpUXE?=
 =?us-ascii?Q?uIEBxWFjF4urpWbtoNHA5Ri8il0DKyXTJuuYEvzk0lRj0hVbWdWKAytQSDLR?=
 =?us-ascii?Q?+1HVVmPB3Vb4HwnVKUP8ESmUOM47RHM36AjmlLfUqrb2Pj1ThLwITG4/kPkS?=
 =?us-ascii?Q?78ROQ5AJQNbC6Lx5KN0Ob0hL+2hzz2wZlMJ1FdVPp8YuqskC/bJmc/7w2Vb2?=
 =?us-ascii?Q?dFmBEqZFZiildwNUFnb59FBxVle8EtLfDdrZm4B3lB8WvFSZ6HIfF24tVSN2?=
 =?us-ascii?Q?cvvjFQZgOewjL4qUiz9BYE1X5UAji2Sv1DW4nhxNPhx3PqlMZdeP1yYEcpx2?=
 =?us-ascii?Q?5NSW4z786qmOXAgArby22wFk3cV6zzEpl1AvYmngdfI8l5+8pv5HyMJ1AOo+?=
 =?us-ascii?Q?VLT7xF0oVWX8UM7Oq963vf0BHz3PRf7XYbrRw9IoXNhk4nYBbfaEk5Y4Eeer?=
 =?us-ascii?Q?WY7jgjgLpsovraDf7nzwC3QP3MbD6Rim06pZ/7Oq2QB+WxYVS9NsiMKuqXN5?=
 =?us-ascii?Q?rw+Z/IVBu/LiQ0rtDh5T5J1l8/Mfx/7gsGqGxvAB8CsONTwt4wHWlMbYIZcC?=
 =?us-ascii?Q?UzdD58wc8rNp2oSbNCuKn8CVhuG9ZIWq0T+DApz4Cw0WFzJBLStPLQHedyK9?=
 =?us-ascii?Q?C2XhSAZNxhsDjTLHCrF42O24vWHXJUDGoIa+YQt+YbScJ+eIFEJxvqa3Ooxq?=
 =?us-ascii?Q?PipQjUShReGjZ/1b5f+bR4+UNagprM3OYMpgDEWVl4LbmkJs2EZ2tgdn/UKI?=
 =?us-ascii?Q?Ultj1+uflOk/MAT+5wVQ4wh1WJheLwg1Olh16E9oANHjoQh9ke0T3aaunGww?=
 =?us-ascii?Q?UaCTfZQtgVl0eUgwWmZDr8R69YM98OB1QcIUmfMZm8BoOgmFi1MEIb/L/+jn?=
 =?us-ascii?Q?UiJWXz3E4TbIkiBJdSD+7XPqxA9jIqVXEQcaGLUkew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rqKNhXT3TvTDOcGNKlg/vGuQmZbrvi9Q23sjakxEpN3vAu4sGNSbe21cS+8b?=
 =?us-ascii?Q?apY29vMiz/O+W7tNZDtP+yElLx4fAX+eI3M8TSTMpDzm8sLMiMqB0rwaloH4?=
 =?us-ascii?Q?40AMCCi6lBqk8zN3S7sXvVfl/60HIGzgv/CNYfGg8FP4VUb8HVltCvW+7CEC?=
 =?us-ascii?Q?/7PwVDKdgrbdVkZ6NiLdnI527V12t3OXiVeAc/1HrnLQHe8L8P5exLcPV0DD?=
 =?us-ascii?Q?o8KdXLADyEUXT5Aq984aoR2bM1Z+/uU9gjXrpKXLK0Qp6Gg4+rBTw3UJHW79?=
 =?us-ascii?Q?vwwdEUnYI37o+AKpYVq7Sdnj0Wl6f7WEHNNzKiMTadS7b8anO+onuJ3Tywwy?=
 =?us-ascii?Q?St0/mkdNo0Y5NKzNDC9Vwp66KxSuagGpyhuBAxuY6nZGrI7k93RyGwiQKsP3?=
 =?us-ascii?Q?MwhTEUF/0avrmZVqR1PRRwTHMHNNogYlV8U0Jdvak/ZRo93eJ7yAR8zPN1PM?=
 =?us-ascii?Q?SqhsLMlt8hiCfSJgRiJVevQbk/l+ERXoihThDRP9y6fxf+5PLsm2+AFrCp64?=
 =?us-ascii?Q?aOSH0ib1kTWaSUmgqDqrrbJPNABt8sQwtV6TNRa8CUqc/tk+XV4OW0wvCBz1?=
 =?us-ascii?Q?bXodBx2ifAD426nc0hg2tWEXe9sDSoffH+SpDhHew9k0FuwLEaOju1O+Mf3d?=
 =?us-ascii?Q?NDbDsTSncARIjpszKPZMUCq8VdTjzls4Eix2mS3Yzm/2g135H+xKrSDi0wwO?=
 =?us-ascii?Q?gjdFAg2LVqNUQ+ELYBlCpM0lgCqZd+avAlrf5OGUIjCQTSBbQJfuPphOvxcY?=
 =?us-ascii?Q?U8UcXfyQ92gzei14UMP/WcnQHwN/Jd72GuAL55qsQfCQdkfESEvL+MALO0Qh?=
 =?us-ascii?Q?Tua7QgxzXmKP+O1/w152gQYsGkjEcamII/6tvzzMbYKykg9XjhvfdM5gIExs?=
 =?us-ascii?Q?V0FFBP38oN2nimAOib5MdFS6BOjV3NyBR/aaxViBnle9VMDQZHQokx+LnbK3?=
 =?us-ascii?Q?oCFrylL8Py9Tj+kDeP6kbqRmZzyOeZ4y6FHF2Az/sgzUgb7lYKbw2wTMOhMR?=
 =?us-ascii?Q?Sst/GV0ikmX3cB1EFz3jmWh6f/a4vXDasO6HL/pNk/rCtu6/PPcziWuNVLjk?=
 =?us-ascii?Q?9IxOZwtg+S6gcOgu+t5YMzmq0c5PDhEBdC1dSdgRW4I+R10aqSk6dLtwTwUh?=
 =?us-ascii?Q?NodOUAzjT5rXMuGMVb2vKPfmnAqJFFy130uQ374asj6eDM7S0p5Wnh35f5GF?=
 =?us-ascii?Q?ZDir9LE9Mes09phbEWXImhowMveaEMRl282rxr09QTwGOZgWzeZ6yhEVWjbg?=
 =?us-ascii?Q?q+bWadiTbpj8fLMdIRL/patuoXBIrBN8VnNeJY9IS4q+7R5WlUcKjDHhpiB6?=
 =?us-ascii?Q?baFdd9Lqh4QCoFJW0n+LYJxDxfelX5HIkOfX3lzagpmOwQqC7L2l9zu07R0f?=
 =?us-ascii?Q?aZftU6ojZ6cHe3MmHdYMKRe5eeI9xChBINrCw6U2inYzjBizc6RBJg9w7zbw?=
 =?us-ascii?Q?UmFd6Bv1l5Px36IEnwLvUjiP0Od/TdJGPdNTutPk0kH4DL8clby+G8la6MVN?=
 =?us-ascii?Q?TRNtn92OlZNr/yIQPC96Y/3tqZha6YdaGJV+ZjjU8u1HC8H1G3XI/pNVjWwi?=
 =?us-ascii?Q?tyiWGzLn9LZ8c3NE8yLoX7eaynLGmCN8/M006P0YZV/zUHDyZ5yJhuCV95hw?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db45735-272f-4e7f-0992-08dc8ddb2d94
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2024 08:06:08.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9LCHD4FuqzKGX87f2i6ivrVHU6WSUchyoZnULdgzuITEtGapVUrzBwv8w+04++gaoHtiOlvx9BIDgSKp1GSXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7246
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_mm/usercopy.c" on:

commit: 18f0423b9eccb781310af6709ceebf654175af14 ("[PATCH] net: micro-optimize skb_datagram_iter")
url: https://github.com/intel-lab-lkp/linux/commits/Sagi-Grimberg/net-micro-optimize-skb_datagram_iter/20240613-193620
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git b60b1bdc1888f51da7a2a22c48c5f1eb2bd12e97
patch link: https://lore.kernel.org/all/20240613113504.1079860-1-sagi@grimberg.me/
patch subject: [PATCH] net: micro-optimize skb_datagram_iter

in testcase: boot

compiler: gcc-8
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | b60b1bdc18 | 18f0423b9e |
+------------------------------------------+------------+------------+
| boot_successes                           | 6          | 0          |
| boot_failures                            | 0          | 6          |
| kernel_BUG_at_mm/usercopy.c              | 0          | 6          |
| Oops:invalid_opcode:#[##]PREEMPT_SMP     | 0          | 6          |
| EIP:usercopy_abort                       | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 6          |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sang@intel.com


[   13.495377][  T189] ------------[ cut here ]------------
[   13.495862][  T189] kernel BUG at mm/usercopy.c:102!
[   13.496372][  T189] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
[   13.496927][  T189] CPU: 0 PID: 189 Comm: systemctl Not tainted 6.10.0-rc2-00258-g18f0423b9ecc #1
[   13.497741][  T189] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 13.498663][ T189] EIP: usercopy_abort (mm/usercopy.c:102 (discriminator 12)) 
[   13.499424][  T194] usercopy: Kernel memory exposure attempt detected from kmap (offset 0, size 8192)!
[ 13.499647][ T189] Code: d6 89 44 24 0c 0f 45 cf 8b 7d 0c 89 74 24 10 89 4c 24 04 c7 04 24 a4 55 8a d6 89 7c 24 20 8b 7d 08 89 7c 24 1c e8 20 3c df ff <0f> 0b b8 80 91 d7 d6 e8 a8 de 68 00 ba 3d 17 86 d6 89 55 f0 89 d6
All code
========
   0:	d6                   	(bad)
   1:	89 44 24 0c          	mov    %eax,0xc(%rsp)
   5:	0f 45 cf             	cmovne %edi,%ecx
   8:	8b 7d 0c             	mov    0xc(%rbp),%edi
   b:	89 74 24 10          	mov    %esi,0x10(%rsp)
   f:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
  13:	c7 04 24 a4 55 8a d6 	movl   $0xd68a55a4,(%rsp)
  1a:	89 7c 24 20          	mov    %edi,0x20(%rsp)
  1e:	8b 7d 08             	mov    0x8(%rbp),%edi
  21:	89 7c 24 1c          	mov    %edi,0x1c(%rsp)
  25:	e8 20 3c df ff       	call   0xffffffffffdf3c4a
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 80 91 d7 d6       	mov    $0xd6d79180,%eax
  31:	e8 a8 de 68 00       	call   0x68dede
  36:	ba 3d 17 86 d6       	mov    $0xd686173d,%edx
  3b:	89 55 f0             	mov    %edx,-0x10(%rbp)
  3e:	89 d6                	mov    %edx,%esi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 80 91 d7 d6       	mov    $0xd6d79180,%eax
   7:	e8 a8 de 68 00       	call   0x68deb4
   c:	ba 3d 17 86 d6       	mov    $0xd686173d,%edx
  11:	89 55 f0             	mov    %edx,-0x10(%rbp)
  14:	89 d6                	mov    %edx,%esi
[   13.500502][  T194] ------------[ cut here ]------------
[   13.502187][  T189] EAX: 00000052 EBX: d680da68 ECX: e0435480 EDX: 01000232
[   13.502666][  T194] kernel BUG at mm/usercopy.c:102!
[   13.503236][  T189] ESI: d686173d EDI: 00000000 EBP: ece37c44 ESP: ece37c10
[   13.504266][  T189] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010286
[   13.504856][  T189] CR0: 80050033 CR2: 0135eb6c CR3: 2beff000 CR4: 000406d0
[   13.505464][  T189] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   13.506083][  T189] DR6: fffe0ff0 DR7: 00000400
[   13.506495][  T189] Call Trace:
[ 13.506795][ T189] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 13.507187][ T189] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 13.507576][ T189] ? die (arch/x86/kernel/dumpstack.c:449) 
[ 13.507894][ T189] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
[ 13.508270][ T189] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359 kernel/locking/lockdep.c:4311) 
[ 13.508783][ T189] ? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:176) 
[ 13.509182][ T189] ? usercopy_abort (mm/usercopy.c:102 (discriminator 12)) 
[ 13.509588][ T189] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 13.509983][ T189] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[ 13.510396][ T189] ? usercopy_abort (mm/usercopy.c:102 (discriminator 12)) 
[ 13.510797][ T189] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 13.511242][ T189] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 13.511646][ T189] ? usercopy_abort (mm/usercopy.c:102 (discriminator 12)) 
[ 13.512070][ T189] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 13.512434][ T189] ? usercopy_abort (mm/usercopy.c:102 (discriminator 12)) 
[ 13.512832][ T189] __check_object_size (mm/usercopy.c:180 mm/usercopy.c:251 mm/usercopy.c:213) 
[ 13.513275][ T189] simple_copy_to_iter (include/linux/uio.h:196 net/core/datagram.c:513) 
[ 13.513693][ T189] __skb_datagram_iter (net/core/datagram.c:424 (discriminator 1)) 
[ 13.514138][ T189] skb_copy_datagram_iter (net/core/datagram.c:529) 
[ 13.514606][ T189] ? skb_free_datagram (net/core/datagram.c:512) 
[ 13.515028][ T189] ? scm_stat_del (net/unix/af_unix.c:2883) 
[ 13.515429][ T189] unix_stream_read_actor (net/unix/af_unix.c:2889) 
[ 13.515884][ T189] unix_stream_read_generic (net/unix/af_unix.c:2805) 
[ 13.516377][ T189] ? cma_for_each_area (mm/page_ext.c:518) 
[ 13.516826][ T189] ? unix_stream_splice_read (net/unix/af_unix.c:2907) 
[ 13.517301][ T189] unix_stream_recvmsg (net/unix/af_unix.c:2923) 
[ 13.517720][ T189] ? scm_stat_del (net/unix/af_unix.c:2883) 
[ 13.518108][ T189] ____sys_recvmsg (net/socket.c:1046 net/socket.c:1068 net/socket.c:2804) 
[ 13.518527][ T189] ? import_iovec (lib/iov_iter.c:1348) 
[ 13.518930][ T189] ? copy_msghdr_from_user (net/socket.c:2525) 
[ 13.519396][ T189] ___sys_recvmsg (net/socket.c:2846) 
[ 13.519811][ T189] ? __fdget (fs/file.c:1160) 
[ 13.520186][ T189] ? sockfd_lookup_light (net/socket.c:558) 
[ 13.520643][ T189] __sys_recvmsg (include/linux/file.h:34 net/socket.c:2878) 
[ 13.521046][ T189] __ia32_sys_socketcall (net/socket.c:3173 net/socket.c:3077 net/socket.c:3077) 
[ 13.521513][ T189] ia32_sys_call (arch/x86/entry/syscall_32.c:42) 
[ 13.521923][ T189] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:386) 
[ 13.522362][ T189] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[ 13.522787][ T189] do_SYSENTER_32 (arch/x86/entry/common.c:450) 
[ 13.523188][ T189] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:836) 
[   13.523613][  T189] EIP: 0xb7ee6579
[ 13.523933][ T189] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d 76 00             	lea    0x0(%rsi),%esi
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	8d                   	.byte 0x8d
  3f:	76                   	.byte 0x76

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d 76 00             	lea    0x0(%rsi),%esi
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	8d                   	.byte 0x8d
  15:	76                   	.byte 0x76
[   13.525624][  T189] EAX: ffffffda EBX: 00000011 ECX: bfdf5450 EDX: 00000000
[   13.526233][  T189] ESI: b7c46000 EDI: bfdf54ac EBP: bfdf54a8 ESP: bfdf5440
[   13.526853][  T189] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000286
[   13.527519][  T189] Modules linked in: i2c_piix4(+) agpgart(+) qemu_fw_cfg button fuse drm drm_panel_orientation_quirks ip_tables
[   13.528566][  T194] Oops: invalid opcode: 0000 [#2] PREEMPT SMP
[   13.528804][  T189] ---[ end trace 0000000000000000 ]---
[   13.529217][  T194] CPU: 1 PID: 194 Comm: systemctl Tainted: G      D            6.10.0-rc2-00258-g18f0423b9ecc #1
[ 13.529725][ T189] EIP: usercopy_abort (mm/usercopy.c:102 (discriminator 12)) 
[   13.530536][  T194] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 13.531060][ T189] Code: d6 89 44 24 0c 0f 45 cf 8b 7d 0c 89 74 24 10 89 4c 24 04 c7 04 24 a4 55 8a d6 89 7c 24 20 8b 7d 08 89 7c 24 1c e8 20 3c df ff <0f> 0b b8 80 91 d7 d6 e8 a8 de 68 00 ba 3d 17 86 d6 89 55 f0 89 d6
All code
========
   0:	d6                   	(bad)
   1:	89 44 24 0c          	mov    %eax,0xc(%rsp)
   5:	0f 45 cf             	cmovne %edi,%ecx
   8:	8b 7d 0c             	mov    0xc(%rbp),%edi
   b:	89 74 24 10          	mov    %esi,0x10(%rsp)
   f:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
  13:	c7 04 24 a4 55 8a d6 	movl   $0xd68a55a4,(%rsp)
  1a:	89 7c 24 20          	mov    %edi,0x20(%rsp)
  1e:	8b 7d 08             	mov    0x8(%rbp),%edi
  21:	89 7c 24 1c          	mov    %edi,0x1c(%rsp)
  25:	e8 20 3c df ff       	call   0xffffffffffdf3c4a
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 80 91 d7 d6       	mov    $0xd6d79180,%eax
  31:	e8 a8 de 68 00       	call   0x68dede
  36:	ba 3d 17 86 d6       	mov    $0xd686173d,%edx
  3b:	89 55 f0             	mov    %edx,-0x10(%rbp)
  3e:	89 d6                	mov    %edx,%esi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 80 91 d7 d6       	mov    $0xd6d79180,%eax
   7:	e8 a8 de 68 00       	call   0x68deb4
   c:	ba 3d 17 86 d6       	mov    $0xd686173d,%edx
  11:	89 55 f0             	mov    %edx,-0x10(%rbp)
  14:	89 d6                	mov    %edx,%esi


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240616/202406161539.b5ff7b20-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


