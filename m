Return-Path: <netdev+bounces-79426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DB78792C1
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5644C28508F
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05B079954;
	Tue, 12 Mar 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvY+66p7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A477F34
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241893; cv=fail; b=PbV3CDK/6Y2yYWlTrqP54gVBi+Q6HTPX5GcL0+KycbhNMWZCzfE//ruS+57/mY1yw+ueHR5hVXCXMK8mrXe2w1aBRQ35STQB0kVFBU6hZrlHpqu11sO2YCCKfviUsL4qFofOKz5hWBPpsJvWufmQxnrqv3Q6EwZDycHKVGws1iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241893; c=relaxed/simple;
	bh=fOV4DDjL6/gvIAtQS/38H/b1uf4c6+g9H/ihPiynM/Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YgW1nfkyDdmJqcVatVEs0pya8LAMgAhNv7x+eXSnSxbAAZNZERRtgWzv2whOifsZYZayupBdVuHT3s4RqiPV1gjCjc1r9E2EnB8zMKbD3U2c9TPBSDSazGFSCofwb3Y5R3lgis7Nl3AegsEbByMHFnZYpxnWf4KAlVLLYmiWQxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvY+66p7; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710241892; x=1741777892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fOV4DDjL6/gvIAtQS/38H/b1uf4c6+g9H/ihPiynM/Y=;
  b=gvY+66p7nY+wz8X3FzPTdsXafQedOsUzgz6uzk/rD5yFPQt15jdrMLYD
   +MMDBKUmKluT2fcOIrj+5JPVN2Df2zOyvQayA7w3BEWo8+dE1gTOb1xWa
   haiGxvdXz138D0B4xLSJP4lo4W+Ly16q1xz1QcH45sUbP+xMrkxwDzoXd
   fW0WHuOCnnjBLqNZbNTTUCrPDbnMJ9h27dp++vV6L4TDsW1qlVM3b5zMs
   ZICNZMAGAe2U4btvgzugAyV5PJmJPkN7okEFQXUT8lkWW9oOkVzW9RUym
   dK7W3DZGTsgkuCbqXbArdg3LUaWEYVlaVnwHdhtGHZXytiL9ljDlf4fYO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="15582134"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="15582134"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:11:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16200295"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 04:11:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 04:11:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 04:11:29 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 04:11:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUffJRx4Bh83snDp7LDnQF0F2pvQ1OG1IjjIdLIvdZokhQ/eg970bqDsqOSuGuXnElMcKpcYEofUbRYbSS/LliiUP9aj/b01cLSSkKefZEvdZI15TLHmF31+05wx7poGY5WenrMta03nyqMwMZmfUoVIbFMVFf81f4m6vqIHCsUEjnVyE4VzM7GB5HgzMUqN/bIxpNMuDNRlk0qVStVQ1hyihIFv27akE4yol2RPpA+cqyL2//dUJtE/ywDuI9BmxMuUTuqv4wHFDmBIJvOQOVqKhCIlZXMPx7clsAfcpEL3hlo0f9ZGm8eFMJLTHyyL127BKc1CiKfYKVu/8EFUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr40lDT9tNzesDOtRRsTYkh2HjMMTrT2LJBBnEhHIFE=;
 b=QM3uGWoOTXtzip2EYMDs9W1MY8EH/IEC1jKHm3g4/QoOaI7wXEVIQScwKSNGBzVGtJeqCnEdcKuo12l8Nn5ZD04/SF7tNFWHWyNJpCDZCaCSrjeiOqt8yjnJWPfOlGstT6UQhD5EalBO0yxllPbAmnzQZ0B5OylnGmP+KdtNFhmVe5XeyuVP2MSO9FAnjAZLI1C9nxmL0qmqP/jWPudIh0iW9XflIqOLXSru9Xf44DsL6cv6s9wpdROII6qIxX9g4OHo/cn1d6ZUqmODfXRqNXDHcAHFZ5pQw5yX1DUOCRJnqlyIDEeIxNN4dQ0csSnzM3wy4Z9myCZbTgBapBzjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by IA1PR11MB7271.namprd11.prod.outlook.com (2603:10b6:208:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.14; Tue, 12 Mar
 2024 11:11:27 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7386.017; Tue, 12 Mar 2024
 11:11:27 +0000
Date: Tue, 12 Mar 2024 12:11:15 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<eric.dumazet@gmail.com>,
	<syzbot+a340daa06412d6028918@syzkaller.appspotmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] net/sched: taprio: proper TCA_TAPRIO_TC_ENTRY_INDEX
 check
Message-ID: <ZfA4U0itpWSjsALX@localhost.localdomain>
References: <20240311204628.43460-1-edumazet@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240311204628.43460-1-edumazet@google.com>
X-ClientProxiedBy: DB9PR02CA0013.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::18) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|IA1PR11MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 43716275-7b18-48dc-e193-08dc4285291f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3ITkuYvbZoE2w4rmSNMEsAEGaiN4lsWu86QOalfkIsu8JtK9C6BmEX2EVf6id7ZNeJsadW+9M1NT7WldNye6KSLPgAoUWYwFZsFGIltf42q7iOy0nDQe2sX/MXugrExOj5pppf6NmKFt22iTeVxQan3L7omBCEoYhplmVH6KEYilYZqTCJcblF+2XVKkxxKdOppyMS6pl9COIZnof7PkiFz58iSI/O600W1u88PmLEs9pATT0W8Dun5YaitlS1e2zFfaVHdNaeWOe3nuMSaX7DGOqTDGZT/EVs1X+5xztIG70MPr1gECBhkUaBWUTc09zqVb6SJKiZfx73NqLYLWxCu4Cn/ovhmT2AsL6QtbZVV85fp8vYaASJQoS1dWJePKZ0VpZmqKV2ZzModwc7ERIEs27l5bycnrieuic/3rhgsXzRn3vJubfBFebPehvEnKzKX9oxPXS/OhQMaO2hoyS25f5cgj/UG3nvsuFJ+WDVBOjvlILJYZ3Q1WZygz+GEzHSZGd7sk8IHZ5+0nGv7fpT0pTl39KK7FNmeItkudXz85BpMb79YdwIkiux57R2DyGT5WtyPq7Ca7e8GKS2zh0eeRBPtZLaqgZou5ZfI6VmD8nHkb/0Oxu5J6ckLKa91RzrSB5KBtmJe4Bp71v3YLZuSs9E8YBmcwb0qcCoTJr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WuVt5kbvpep2ME+z4sOldQx2V0no8RTs06Tl8oBVzWOfNVq0d33MlS2hc1u7?=
 =?us-ascii?Q?AYAdlIomRFfpf+vee4kxP8dRwOpNEQ3HwLrsA6+Ls4/0+YVuHNJkP0jS6Fbi?=
 =?us-ascii?Q?q28uls/AZT7igTCeYt+rDwZdxhg4G5Xzo/fAMirsmYasCLWPl3mTqG4dnJ0G?=
 =?us-ascii?Q?OMEn5VVfCzJzvdQLuio0WCyEduHzn/p9jqmJ/gZYJK9RBaTff9qgQZNJQEpA?=
 =?us-ascii?Q?krAUUBPMv6o8UFup+4zVUbFJSNPMJtOeAT2bQpsoQIqp+5Wd4+2vU5egGNpL?=
 =?us-ascii?Q?Hs8zCfMYm+PrYWGRKSz7XQB2DF2SePpZqdqTFXJ/sYiK7tNFKlQIu2PU8+xM?=
 =?us-ascii?Q?yYLT/akwMFcQPyl/hKL4pVBjiDMigXX0A/ES1/mPMAuOJ8WRJ4f4Za/m0cH5?=
 =?us-ascii?Q?vow8/mpEeZ2kvIiVq5HNlZLmDQMiAauHjhMpWZZ4dvhYV2FGzz+Wn/IlUgNP?=
 =?us-ascii?Q?eg29i6AAE47aNdrhxxkW1rQk+WNuw7SBo4GtBGXA4sIuLR9QWRrdaWUz3Law?=
 =?us-ascii?Q?67fEun0rYEi9Fyrx3gGGJ40hKU8XmK3feqYWNiyqw3fTk9hPZHG0NksQMDjI?=
 =?us-ascii?Q?SqzTP6MzDSV1LSpD7I8RUC47NzC6PuNep8lsKmTiwg3FLYK6gfCBiQmYUBJM?=
 =?us-ascii?Q?KyHfjusaP4FzJ4Zpg+GoD/71BTCE/P1FIPHbdbhPy6EX1oqVjZ3Lkf4cYBAU?=
 =?us-ascii?Q?oZ5RcKNyILq2w5d0OB7wGFFvseMmCR+xN4whn7mWCZlNVLF59o/0YBmrEj7z?=
 =?us-ascii?Q?Wn6+t1Iwblvf92W3fZrSFyDVCF9mgSVo55bfM7GfTRnM58eZmT1u3iWATYzP?=
 =?us-ascii?Q?rpG69ChrATSFuVfNBHLa4Y1jwgA+ZGzTKzzJRbyBI2yBkucfuH/HapWrm3tM?=
 =?us-ascii?Q?KLlG3IzNdwPrVGfdSPJmFu/mgREHCSFtahISdA6JQy8zdSYaYWP8eu20Rie6?=
 =?us-ascii?Q?YFXKDKl/6hq+y5VER3tvfUigAewPUcPxxVLGJIeERuU7otvquUZceBdw0Z9p?=
 =?us-ascii?Q?GI5ex2fYHAVSRMz7VAqa1PjFIFXNSi5pjl8tmkZtntsTlSqFQvuvqk3kyuep?=
 =?us-ascii?Q?KhBDERoT6mulcxpuPxSgEab04sU9g/MDd2qzVW37o8zSax9OjIXKqOpTJb1w?=
 =?us-ascii?Q?pMew6ebyd6Z56EGJXxVMJiw7KWRkN9qIMypCJXHNMMRBq16voyOVajYvE3HP?=
 =?us-ascii?Q?uxt05VOcRB8sfDBVkmvxIol6DpYTDlkRg+9h0jtiw8P5OgE9nMGp7EoEzEK/?=
 =?us-ascii?Q?DY6LYb4B5K1G63l7D+tCSa/txBvKI+lNTvAD5YzE0X9G5azcS2Cl1kCtJ3Pr?=
 =?us-ascii?Q?WZ+bp55ElwXMWukmqd3J6O6y5stZeS9tTW2ihQ22XuyKKvIZcInA1Modr+XN?=
 =?us-ascii?Q?Sfz8uE4bXgPfokJ124yM43+jSS3G2Map6CMJ2hfoAgLU1TvCH45HoCmoUvGU?=
 =?us-ascii?Q?puEnBa4BM+Y5P6KYYkOEEAs7yTJ+sO6Fkx0qqnbtaTVdL05jHLqlzf7tUaQa?=
 =?us-ascii?Q?FLNGnjzCnNzDaRm50jtmOWtOB6OxXLgBa42wIHLJQlbx1QpEpo+zH6GNb6iI?=
 =?us-ascii?Q?ozbyNpQKhDzkYzAk2H3tNCxHhiF3oChu6UTwIBmBD0h4hyiN34ZCZP2rV6yQ?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43716275-7b18-48dc-e193-08dc4285291f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 11:11:26.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qx4RtNBYkGnDcIKAs7+QdlAgy1UbEmPTrmA+jFADsvDv+VYWjCp16tCImbocCBKeWrYk4dvLYpjC89P1BT9Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7271
X-OriginatorOrg: intel.com

On Mon, Mar 11, 2024 at 08:46:28PM +0000, Eric Dumazet wrote:
> taprio_parse_tc_entry() is not correctly checking
> TCA_TAPRIO_TC_ENTRY_INDEX attribute:
> 
> 	int tc; // Signed value
> 
> 	tc = nla_get_u32(tb[TCA_TAPRIO_TC_ENTRY_INDEX]);
> 	if (tc >= TC_QOPT_MAX_QUEUE) {
> 		NL_SET_ERR_MSG_MOD(extack, "TC entry index out of range");
> 		return -ERANGE;
> 	}
> 
> syzbot reported that it could fed arbitary negative values:

nitpick: arbitary -> arbitrary (checkpatch)
> 
> UBSAN: shift-out-of-bounds in net/sched/sch_taprio.c:1722:18
> shift exponent -2147418108 is negative
> CPU: 0 PID: 5066 Comm: syz-executor367 Not tainted 6.8.0-rc7-syzkaller-00136-gc8a5c731fd12 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
>   ubsan_epilogue lib/ubsan.c:217 [inline]
>   __ubsan_handle_shift_out_of_bounds+0x3c7/0x420 lib/ubsan.c:386
>   taprio_parse_tc_entry net/sched/sch_taprio.c:1722 [inline]
>   taprio_parse_tc_entries net/sched/sch_taprio.c:1768 [inline]
>   taprio_change+0xb87/0x57d0 net/sched/sch_taprio.c:1877
>   taprio_init+0x9da/0xc80 net/sched/sch_taprio.c:2134
>   qdisc_create+0x9d4/0x1190 net/sched/sch_api.c:1355
>   tc_modify_qdisc+0xa26/0x1e40 net/sched/sch_api.c:1776
>   rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6617
>   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
>   netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>   netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
>   netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x221/0x270 net/socket.c:745
>   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>   ___sys_sendmsg net/socket.c:2638 [inline]
>   __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f1b2dea3759
> Code: 48 83 c4 28 c3 e8 d7 19 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd4de452f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f1b2def0390 RCX: 00007f1b2dea3759
> RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
> RBP: 0000000000000003 R08: 0000555500000000 R09: 0000555500000000
> R10: 0000555500000000 R11: 0000000000000246 R12: 00007ffd4de45340
> R13: 00007ffd4de45310 R14: 0000000000000001 R15: 00007ffd4de45340
> 
> Fixes: a54fc09e4cba ("net/sched: taprio: allow user input of per-tc max SDU")
> Reported-and-tested-by: syzbot+a340daa06412d6028918@syzkaller.appspotmail.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  net/sched/sch_taprio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 31a8252bd09c9111090f0147df6deb0ad81577af..ad99409c6325e179319f8ec4053582417a978817 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1008,7 +1008,8 @@ static const struct nla_policy entry_policy[TCA_TAPRIO_SCHED_ENTRY_MAX + 1] = {
>  };
>  
>  static const struct nla_policy taprio_tc_policy[TCA_TAPRIO_TC_ENTRY_MAX + 1] = {
> -	[TCA_TAPRIO_TC_ENTRY_INDEX]	   = { .type = NLA_U32 },
> +	[TCA_TAPRIO_TC_ENTRY_INDEX]	   = NLA_POLICY_MAX(NLA_U32,
> +							    TC_QOPT_MAX_QUEUE),
>  	[TCA_TAPRIO_TC_ENTRY_MAX_SDU]	   = { .type = NLA_U32 },
>  	[TCA_TAPRIO_TC_ENTRY_FP]	   = NLA_POLICY_RANGE(NLA_U32,
>  							      TC_FP_EXPRESS,
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 
> 

Looks OK to me. Please just review the checkpatch warnings.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


