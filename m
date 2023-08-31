Return-Path: <netdev+bounces-31597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A078EF75
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 16:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8512828159C
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0118911C9D;
	Thu, 31 Aug 2023 14:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C816FA5
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 14:20:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBE8D1
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 07:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693491619; x=1725027619;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rogIQlXMHuQjS7z25Cdd3G0y+kona4Ub56jVEAZcBWk=;
  b=Iox0WZm9NiLpcJZq61taYFKgB+QJXyFqlvkjuqUU56Qz6uhITkzEeN/V
   S6dXrt18yYGJyoieDeff6qkkXthd7lqbdVHpGriD0Ng0yRZdt1lcW1qV6
   rVKQKXuq2MUTzG0Tu2iFjyZXwlYbTFP2s0aqIg55wMMGjYKjdS7Q0XMqf
   TLypqMI++LMi+VnV/mQerPmwqn61u57rN6XUuwBcb6AHonrxccaxyJx5y
   OIkkRspqgGBi4uEGRkbvnZqlmDUNlwDs0wpqYs+Eh/Jm5YfFkoNaMyD8X
   wl+kYc1vHiGA4l3Hgbl5rm+Y3GgggEtiPvyx4FBW11qWhduLjJYuX/+HW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375899749"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="375899749"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 07:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="768806870"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="768806870"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 07:20:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 07:20:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 07:20:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 07:20:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 07:20:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYZ83wXrvp4G/lEaiBcnPS16SYJTaOrPnMD9vh5Iaw3JFAi0wHnPtliGAbIAD9QhIjUQmu9NZskjQUaQFc/z1dpzcTlgB3TmLKjWYLMwQy3hDvZM0cBGIDuMRqDpDpH1GIoQaHwmHJjD5zJiGhIvsNgTc+m1jpcZrOu/liirKU5j0HJqQfPa6GhRy9d8DxNCTZIDE1XZWGPIogsyRkBL20A+NUk3H9j5m7lGdnB6nT64vbmusxcTpPGUy4RpepN3Gjbre4QnU/k6kfB/EoaXorQOebC325mF8Qk6tYj29daHw/Lfo0qnYFGrwE4I8/O29FWqaKpufZpT67kmNijiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN/1GtmMYvJIhYg+L6kFOictdfocbWxX1JRPoj4Nm0M=;
 b=DsMN7ldpaOwbz4xMk+3YR7/JaMuXZroNbVWkZ63/iM9OCpHeH+e6DnCxZAczBIcRJ7JJgk6QFUhXPcj2Uo8KfXmJyotQuBMyUaMPoGWwT67GQ5TkH0c2dQTcHvVe+6Lshomkil2D5yIfHudN7dsLxhio5V2yJU9yuGwb3XUe0mqC27Qb+4qWtVNbLfyzAIQdegk41eIB7R4yj4yFheIFbE1oMf9ZH6e4Fb4jsG0hx+60WOON13fFB0P/ecqoB+lbNtAg/yKmNfMVMQJvZDxWWEMANt+RMfxIMVzd1XVZlyJ6BulAKN02Mb/olbofg4oNlTDU75DynwV/Wdt2VfDySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) by
 CH0PR11MB8190.namprd11.prod.outlook.com (2603:10b6:610:188::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.21; Thu, 31 Aug 2023 14:20:13 +0000
Received: from DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::4c4b:8eeb:f41b:7220]) by DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::4c4b:8eeb:f41b:7220%7]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 14:20:13 +0000
Date: Thu, 31 Aug 2023 16:20:01 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<eric.dumazet@gmail.com>, syzbot <syzkaller@googlegroups.com>, Chuck Lever
	<chuck.lever@oracle.com>
Subject: Re: [PATCH v2 net] net/handshake: fix null-ptr-deref in
 handshake_nl_done_doit()
Message-ID: <ZPChkWIzhULbk2Lb@localhost.localdomain>
References: <20230831084509.1857341-1-edumazet@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831084509.1857341-1-edumazet@google.com>
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To DM6PR11MB2937.namprd11.prod.outlook.com
 (2603:10b6:5:62::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2937:EE_|CH0PR11MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcb42ab-9c9f-41b8-564d-08dbaa2d640f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcWf10awiaHWT503XexLJCsgiwj1qQk2/qrKIktiKcr3/aZQrNImVqJ3tvq8/mCKmTJSpnH1hbltWK7qTrx9Fg/4RH3S+a+01vpSAyHxtyDBEoetAJ/qfVUMc+YaKqLcVayFL0cT1FXoSaIShEse2w9HeqWu3P3ojVa275EUdy72l+tDg9SLdr2ls5gf549WPtVdJ6tG/X/Qm/o+jwHijP/uRZwe3pyzr0+B30kfrFK35WrUBcfAJ3jM8aoxL1wg966LtchU863MWwisGVqfJsLOOEoDYjKRc/DFT7LiPviF5BwLb1hX7La871F3ECIs3R6h5OmJWJ1KdDY+DBMQT8i03AEjpl/XR1HhzZyRB7LAA8Qve0pIRqBQF1rFanF8X+5L+5iH7DppDJJNN0tfSQX/8S+AS+Rr84RkYHERJDRUM63F8qbVtIuxqZ6yqHUDG08jx8UjYG6qv75oiSfhWisX75pBY8bxTxlYmpxZKiQDl24tWV1dNs6gektxnYO6QEtBdU9++BIC1Fg9MpxJ+51EkNPMgd7ZBL5isHzj+qjW7i6y1TVK2/MyDFysPSDN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2937.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(1800799009)(186009)(451199024)(66946007)(6666004)(6506007)(9686003)(6512007)(6486002)(82960400001)(86362001)(38100700002)(2906002)(26005)(45080400002)(83380400001)(478600001)(8676002)(4326008)(8936002)(5660300002)(44832011)(6916009)(41300700001)(54906003)(66476007)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ywvBJ6wapuoOys+1yMP7I3BoERU0ZOaMLFz005c2+ebR7vMAlzoVwwu/ov/k?=
 =?us-ascii?Q?DByj0LEuqwT/htDt7uRR0mATx+99cV8Cvg+loQLp8TPfxce4GvgMflLcVkao?=
 =?us-ascii?Q?NrDV/VQC1qFjWwWWShgXZKNJQWmjrnV/T6PDhGil3bzeQghU+R7q8Z3nHIOo?=
 =?us-ascii?Q?SjsFJTgzIUnj64YVuxTQsxSHXlUlVMs7SKkTrFUVKQMeRvRwKcazanBaQJxr?=
 =?us-ascii?Q?PBRDOsdtC9mZXhY1gI+FqIOscIjywfYoCHfw8Hzq2VwFkBsvZKmzBFlYw+V4?=
 =?us-ascii?Q?GBJnDyyXk6b/WFxmuMbqqrqIoGEqz6M83rMOaAXQfFn3tvo3y6l+wAnY+6HM?=
 =?us-ascii?Q?S4n5fBwdUhn7P1b3nNppAhfVTXPDJZUyIlBkFsLgtelkpoiHG8vBHTRj3xj6?=
 =?us-ascii?Q?Bjt86BSFOzbG9yfLDu4mmoYWn1reSXxFLUmjlPcszqSDe8HLhAuqEaatR7xZ?=
 =?us-ascii?Q?XDgAd2NWutYujCf9FeHaynzjikCT8YRSulzvlPu4p8R5217itJBXUkACQDKa?=
 =?us-ascii?Q?5OtRwm0yf8CMjRdb6lqLqRQcnYoyq3r9rDIVlSmUZw7uq1Naj2G5lzSXc+5J?=
 =?us-ascii?Q?Ozl4c5g4T389fOPZ6jlX9HA/FdfNmdsQHzPADrJysUJfvXdRKh6y4G47tMn+?=
 =?us-ascii?Q?ohKBY6LY04xFcMmUCdq8lkcrEvbUzMzz2nQ6o7KcLY8dOd/HYzKiST4gXa8E?=
 =?us-ascii?Q?ikr/F1iwHeP7z4Av3/gBNBjcstLIzhFQOSGYWsAyDz9d3iMU1f4bbhPHr2Xn?=
 =?us-ascii?Q?c75WVGwx6sCaRS4g4jWQxvXVWexdqzWnqGDdZPpx2rs92EDrkPJ2bJ1zQdEj?=
 =?us-ascii?Q?4mp4MuEsh8s16RRvQzuddcBS7G4LfdUKSLJl3sqZ9Gz7C30PATXuUPZy0nZF?=
 =?us-ascii?Q?7ykmQP2tpftphJ2aQ9E4+lDKKc514THrNFmTOJSzW2L62zV9dxdyIqkH9x2u?=
 =?us-ascii?Q?Ls3vSH6527cqbKPVHtfOUaM51tCNGi04oA6aSLGr2Y2by4VlLtGI2tJIQJ9U?=
 =?us-ascii?Q?PCwKgWZJwWSRD42Pz1iO2pJUgdRFyt1SnmNfFt1EM30vPzcfD0tnVP3oJgzB?=
 =?us-ascii?Q?fjQe9eLMa6gAPfSewV1qybMye2NTzRLhntzMvfBDy4QXLM8auOJ0mKlSafOc?=
 =?us-ascii?Q?AhD9G9T/bY+/gkhMzT0zplnbQdNr5qE/Cgou/sqcdw6s+xQ5F9hm35IPjbO2?=
 =?us-ascii?Q?AqA6nE+X9FDUfnDkwdj8ex1WODglT0/hudS+GqzGZb10VX/JCu5j137xiO0d?=
 =?us-ascii?Q?37bjcfl5eIEGhrNKusFwD9GK8HjMnHth1vaAQ+bfpGqOdCbgyqz53JdICwo8?=
 =?us-ascii?Q?aqrdn3hl9NksndN/o8RcndDLFcRflQSrdFdgBrAao+KSMtcSe6QXxBzPZs2X?=
 =?us-ascii?Q?0uuDGG5Hu6anxl6dJfKzOJ4BN/igBlfJs1vvk3o0fGl5WmhuJHBEeIaCqD0B?=
 =?us-ascii?Q?6xnW9CqNA75luSQkdSwQ9hInb4qO7axEZe8QnPA5irXggDmqjQ72M9rclSOn?=
 =?us-ascii?Q?WdUIOY+e8ifHP1OMDHlmPrtgKFl6Oq/737OFr2QvE4hLYxs2qpVGYzpuaWg7?=
 =?us-ascii?Q?qag50rnGn38kvhLdjNBQPO/MXXzC08w1GGESmiQfI7pd6cHbfPttlpDfThvr?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcb42ab-9c9f-41b8-564d-08dbaa2d640f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2937.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:20:13.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LXHJDd+5OvvFYJNAf7lnVoglT29Dn1Lqx9v4bVASAAjhwVOVLWLVBQtMHHaEft4QKXVc9YuWKwzQqUuoZ9Xbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8190
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 08:45:09AM +0000, Eric Dumazet wrote:
> We should not call trace_handshake_cmd_done_err() if socket lookup has failed.
> 
> Also we should call trace_handshake_cmd_done_err() before releasing the file,
> otherwise dereferencing sock->sk can return garbage.
> 
> This also reverts 7afc6d0a107f ("net/handshake: Fix uninitialized local variable")
> 
> Unable to handle kernel paging request at virtual address dfff800000000003
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> Mem abort info:
> ESR = 0x0000000096000005
> EC = 0x25: DABT (current EL), IL = 32 bits
> SET = 0, FnV = 0
> EA = 0, S1PTW = 0
> FSC = 0x05: level 1 translation fault
> Data abort info:
> ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [dfff800000000003] address between user and kernel address ranges
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 5986 Comm: syz-executor292 Not tainted 6.5.0-rc7-syzkaller-gfe4469582053 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : handshake_nl_done_doit+0x198/0x9c8 net/handshake/netlink.c:193
> lr : handshake_nl_done_doit+0x180/0x9c8
> sp : ffff800096e37180
> x29: ffff800096e37200 x28: 1ffff00012dc6e34 x27: dfff800000000000
> x26: ffff800096e373d0 x25: 0000000000000000 x24: 00000000ffffffa8
> x23: ffff800096e373f0 x22: 1ffff00012dc6e38 x21: 0000000000000000
> x20: ffff800096e371c0 x19: 0000000000000018 x18: 0000000000000000
> x17: 0000000000000000 x16: ffff800080516cc4 x15: 0000000000000001
> x14: 1fffe0001b14aa3b x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000003
> x8 : 0000000000000003 x7 : ffff800080afe47c x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080a88078
> x2 : 0000000000000001 x1 : 00000000ffffffa8 x0 : 0000000000000000
> Call trace:
> handshake_nl_done_doit+0x198/0x9c8 net/handshake/netlink.c:193
> genl_family_rcv_msg_doit net/netlink/genetlink.c:970 [inline]
> genl_family_rcv_msg net/netlink/genetlink.c:1050 [inline]
> genl_rcv_msg+0x96c/0xc50 net/netlink/genetlink.c:1067
> netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2549
> genl_rcv+0x38/0x50 net/netlink/genetlink.c:1078
> netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
> netlink_unicast+0x660/0x8d4 net/netlink/af_netlink.c:1365
> netlink_sendmsg+0x834/0xb18 net/netlink/af_netlink.c:1914
> sock_sendmsg_nosec net/socket.c:725 [inline]
> sock_sendmsg net/socket.c:748 [inline]
> ____sys_sendmsg+0x56c/0x840 net/socket.c:2494
> ___sys_sendmsg net/socket.c:2548 [inline]
> __sys_sendmsg+0x26c/0x33c net/socket.c:2577
> __do_sys_sendmsg net/socket.c:2586 [inline]
> __se_sys_sendmsg net/socket.c:2584 [inline]
> __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2584
> __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
> invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
> el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
> do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
> el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
> el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
> el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> Code: 12800108 b90043e8 910062b3 d343fe68 (387b6908)
> 
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> ---
> v2: remove req=NULL as claimed in changelog (Paolo)
> 
>  net/handshake/netlink.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
> index 1086653e1fada1724f98ccbc81fbcf7741ef9bc9..d0bc1dd8e65a8201751fddcc2356da89cd2c65e7 100644
> --- a/net/handshake/netlink.c
> +++ b/net/handshake/netlink.c
> @@ -157,26 +157,24 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
>  int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct net *net = sock_net(skb->sk);
> -	struct handshake_req *req = NULL;
> -	struct socket *sock = NULL;
> +	struct handshake_req *req;
> +	struct socket *sock;
>  	int fd, status, err;
>  
>  	if (GENL_REQ_ATTR_CHECK(info, HANDSHAKE_A_DONE_SOCKFD))
>  		return -EINVAL;
>  	fd = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_SOCKFD]);
>  
> -	err = 0;
>  	sock = sockfd_lookup(fd, &err);
> -	if (err) {
> -		err = -EBADF;
> -		goto out_status;
> -	}
> +	if (!sock)
> +		return err;
>  
>  	req = handshake_req_hash_lookup(sock->sk);
>  	if (!req) {
>  		err = -EBUSY;
> +		trace_handshake_cmd_done_err(net, req, sock->sk, err);
>  		fput(sock->file);
> -		goto out_status;
> +		return err;
>  	}
>  
>  	trace_handshake_cmd_done(net, req, sock->sk, fd);
> @@ -188,10 +186,6 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
>  	handshake_complete(req, status, info);
>  	fput(sock->file);
>  	return 0;
> -
> -out_status:
> -	trace_handshake_cmd_done_err(net, req, sock->sk, err);
> -	return err;
>  }
>  
>  static unsigned int handshake_net_id;
> -- 
> 2.42.0.rc2.253.gd59a3bf2b4-goog
> 
> 

LGTM

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

