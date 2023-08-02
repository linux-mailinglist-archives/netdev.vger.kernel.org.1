Return-Path: <netdev+bounces-23622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D91E76CC45
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7528281D56
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DC46FD9;
	Wed,  2 Aug 2023 12:06:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE526FC9
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 12:06:10 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440010C1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 05:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690977969; x=1722513969;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aTfrwz0NCr4hmsUFQvjvilCOyuvI8IPcIwXAAr0HwYU=;
  b=ShPFryWqtJgwpVyf+kuYfAfIAndo+NH1/L/sWYk6gUGTeK8uLuPWyFtk
   r75C4nEoLIGN6FMKE/nEf9LS4i7JavMbM3yEJf7mmefuT9W5AVWc8a88R
   vKizBQG+vtw356U48nKffYLnuoTEUoYxBaThJNOU1IfoibXhVniiNNszq
   7yJw0pjvgoinZzKbuONvHaRAkt8SLj6cwkqiiCaxX98WQwRuPht41qkwe
   zQKu9OLjUth2itgT2hn7MXCTVw5cYxzjdxKhof55Y+8AHwPolwizezKjz
   n9KIBiuPLQSkgc+eZq8wbRu/jrt59JMXXMK3vZg/rnDeAclgDgK7XQ1N7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349864835"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="349864835"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 05:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="722840699"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="722840699"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 02 Aug 2023 05:06:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 05:06:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 05:06:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 05:06:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2ixbPzv9Ffa5CaRo8Fg7D5xVuzGB2wXFIl/TuPVvGJCnZqsyPNDg2LhNqcw+Al7ymJdR3HFynb/L+QTxUbSAyFt0eu+CseSSDwL6rSXNrYfDI2IG+lpvlTb01z6QpkCIDt9cwtU5g8KR1CFZ938fy8/ljmo/TdhZCuuPwG5TuUoY0M4Gm+Q5tO9GKe3KzAUS8u+HtcUX2whjtS6hYofj3rXpwKIImrUJvuU9kESihNUMg3XsAvpMsZ1Jlm+O3TKUvrww7gHBZctj1dU27gFkgiX+AdUaAmn9rh7Ea6AREgr3woHRhYbKd1Cy7+nXhvLp3tXXUxY3qDOiG0Mq9q/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3c2CN6GBt/GW7dZeNv1g0ysWwvWIz1AFvjX28FKBhpg=;
 b=CqMPgcgadfvi90/WCm73RGqxiQw/rrCoeJpRJ5KUkCt+w0azAelhIy2gwVj7IlpqktZaKniFyeDM8GWoHa3IK6l8VyurmFL7PP8fDaOQBNSH5SrUDUqCdcg5NYomJxihe+wJhiNFbtwJg/W2RmJBLXoahIgdRd6t3cNyRQOmeml3yWYf+QiMJOHUpQBtBNQrhLJHwFB3uRWctkA/M2xAHrg2imKwAveKQPetAUDfBmkjj6VbTYJZ4XndZxuwgk4EOdHpiXlgtzftptg0gYHP30EFGZEXVZBSUgXURjfoChluTUu8fwUz/cJS4HiqtkCqkQZJwIa3uCeFfpijlEddxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MN0PR11MB6158.namprd11.prod.outlook.com (2603:10b6:208:3ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:06:06 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:06:06 +0000
Date: Wed, 2 Aug 2023 14:01:09 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Yue Haibing <yuehaibing@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] ila: Remove unnecessary file net/ila.h
Message-ID: <ZMpFhVtxHjP+GHq3@lincoln>
References: <20230801143129.40652-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230801143129.40652-1-yuehaibing@huawei.com>
X-ClientProxiedBy: FR0P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MN0PR11MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 9389c10f-1916-4043-a8ea-08db9350d956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebJmc5j+67AxnsWWEh1DHaKmqcul6pptmcWaS5RtK92diBWxWpVgqC87FGWEBD1vctx07flMRwvqtqn4yGOcfE8kvkWMqK7pF6qeAHrY1qn8z2LdT1AltMX45ahXFiz7PWnjpQ5i4QUrxMCT+F68Jjz9b4K/1TSG0suv31Ud2AUqQ6dR3Is8wNgX56ct0X0R7lwe1Ze32KuuyvJhBxFCxN2PdYjuOyXwVphGGlFWz8IyJzoBOhC2obeOvzmrQxsiJN9fXSlMt+q6CndogomaMNyQ1agYoN6dviTQZ9JwjyeifNvPkXaX78LJhL5686J8eylKQupZeyEmPBpox3SvSXFGAUWFVxQmUR66VDvwg7KEeufYgCpLiCuSf+u2ihoyCozD49SnSY3Uu63qdD0XKGEI9Ti+HUgZfEMZl0JUfSp7T4iBhGc5RbfX6wrogBJjj5zT1HNDNh+psDoSc35zREJAb/dBt5Rmt3rHwvroEKIFl/gWVyow4IQW7baVAlYPb4ov9fE3XiYtNWmlUyTIBA7z5R0EPC0XQChLpWG4AXoe/6ri3WhzGG/hwL8EjhLACRU6iq06BjIgqg9drQh5dAMEeDWelm92wKp0L/5CC+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(8676002)(5660300002)(33716001)(83380400001)(82960400001)(41300700001)(38100700002)(316002)(186003)(8936002)(6506007)(26005)(4326008)(6916009)(86362001)(66946007)(66556008)(66476007)(6512007)(9686003)(2906002)(6486002)(478600001)(44832011)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NohPbMqiQ0QzHPpXtrg+1tmVLyxQV5iy/XgG0jNQtxI2Gus3N8MYOFyPknz8?=
 =?us-ascii?Q?SUwzbOJprRWU7hHyVKSwZZlfIMQWfRjmBYr6/NSx0ykLmWeQnemfaIZS8w2U?=
 =?us-ascii?Q?5FNDw4otS2A/5m0cBiIGO7wVEg+PzqJ8cdT/1RaQ0tCm0drHxP5DB0wmRcNp?=
 =?us-ascii?Q?LcNbPegdgqwz7ZL7ZYKKcwb3sAXCER53ZaTa++7bPiNF6hmsS2prxEtqdUzg?=
 =?us-ascii?Q?JEPaKZgkR7ClMUjsul+iz8N5Gp4Jm4yZOjlt+NHhT5ov5tUszipYj18Lt3xN?=
 =?us-ascii?Q?MFCwL8Q0TSr30fkvfReC9osBbcmZzLW7BE2O+n2kC/Qb1Y7/bJGkYjRbp6Zx?=
 =?us-ascii?Q?+qlm6WJuS2kObJYDd8KyYIviCAMrYrdIX/TrEoVTzE46ZPnzbeUi03k8mtV1?=
 =?us-ascii?Q?5mXRUOLqc9RU9JW2xisWjDU3fCxkTV/PRpf+0IE1sdOR8nkMZDw+JDE7X/G7?=
 =?us-ascii?Q?0LPQT7q+xXz+5CjuIBwW3BUNqvTpOoiPEzRNNJmuOYmUWDRZ7OHf/2IdcW5Z?=
 =?us-ascii?Q?xJ5hNGCfQ2j0RERoMJmkckmjbsfPkipP12IFQ89VadX8mWeTaObmSCX44BuE?=
 =?us-ascii?Q?d5ew/4lP+hM7bFeejUZ9g19yA/DkbkskyvTUgymvHVRrdFgx6yiJ/QkRI//B?=
 =?us-ascii?Q?zNhglwML/9p6qhxLzmyXKxVFn5jP0U6DTVnlIqPpTGAPg+ReajwUyBohVrf/?=
 =?us-ascii?Q?lNQ4FUSb38OQT5Slc5kNV7NL9iA2rQL5vP+77kjTPlox9JXq3JzGbVzQyPO1?=
 =?us-ascii?Q?UFNllyo4Y0XPfnj2BA31zHzCb6gcttdrm/o+f0NJA1o92yXBCCsxCQCPlboI?=
 =?us-ascii?Q?8oyMqGy+h4XfTscKJVpdaiWIDz2/B1s5kRz6cLZDtwgeDLU7VauGNb9EurL0?=
 =?us-ascii?Q?e4btV4SN38W4nT96fd048YE3YY19yVg00D8Hg4Gqsgmvn1aQrAOiOdrWV2su?=
 =?us-ascii?Q?sTio9kytweUm0j05uso73J0eskjHylOxFrDD1IHaMA2lH2QZVrdpJ4hX7gwx?=
 =?us-ascii?Q?hXMSRUHagjjy8W5dvHgxjqbayZ00PQs6FE6jgyrexHBirWNyuotY7ppSNc2k?=
 =?us-ascii?Q?SbzTTQlzdJ8uH6lCUNmEiJkEzkhvvqioWVXjrw7ceWgA7ibau3ETKUuwX+R0?=
 =?us-ascii?Q?5pVM5ffxC5ovgfZprrxpMBem1C+k6csX+u0An9HEXUR06m88y5CWlbk89Oru?=
 =?us-ascii?Q?Bl6bvk5aPg1Rffs6Yc5g0qTqQeB/lrgRAltZNmGMm9QNneqUMWeegmSHPvXH?=
 =?us-ascii?Q?LYOVCZO40RKq0e42NQC2K78TUWVZd14KFISxPc1q4HFAsBhptZo/8hIRq+V1?=
 =?us-ascii?Q?KZWZB7EKesaNhc3e2rsdynLiO7wItBTJMCRWkjkUyZSaVJ4NMAhAoqcvsbPI?=
 =?us-ascii?Q?AuH+3NK/am6Z6+7UjM4OAntsVfYJADOnk4+KqT7c/XRiDfKDFQ9Y7keY1YEa?=
 =?us-ascii?Q?cpyWFxJRQFqK7p/mASgoh4WTmVpOWGbM4tlG07RMB2Kh86bF8dtFgq6fXCPP?=
 =?us-ascii?Q?5IdPkUxNZu0uKfuXd2whd5+77bybnhZXCq2OffyjA5WaIVCUvJHeFUEtfU+T?=
 =?us-ascii?Q?Dnf4vJpSEe6lbiblfTUYa78BXlzz4cR/M2590CVY5a6czvQNm1nTMUBoJnr+?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9389c10f-1916-4043-a8ea-08db9350d956
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:06:05.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51cUf/nSwX8qSClzcI72I8ebNyN2de5/okG+acgddhd+jdXDpSlCzG++kqI0Ljhof44H1VHg9pHjVAlq0Iql3e2H6CZp938zksrn6DCepXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6158
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 10:31:29PM +0800, Yue Haibing wrote:
> Commit 642c2c95585d ("ila: xlat changes") removed ila_xlat_outgoing()
> and ila_xlat_incoming() functions, then this file became unnecessary.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  include/net/ila.h       | 16 ----------------
>  net/ipv6/ila/ila_main.c |  1 -
>  net/ipv6/ila/ila_xlat.c |  1 -
>  3 files changed, 18 deletions(-)
>  delete mode 100644 include/net/ila.h
> 
> diff --git a/include/net/ila.h b/include/net/ila.h
> deleted file mode 100644
> index 73ebe5eab272..000000000000
> --- a/include/net/ila.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * ILA kernel interface
> - *
> - * Copyright (c) 2015 Tom Herbert <tom@herbertland.com>
> - */
> -
> -#ifndef _NET_ILA_H
> -#define _NET_ILA_H
> -
> -struct sk_buff;
> -
> -int ila_xlat_outgoing(struct sk_buff *skb);
> -int ila_xlat_incoming(struct sk_buff *skb);
> -
> -#endif /* _NET_ILA_H */
> diff --git a/net/ipv6/ila/ila_main.c b/net/ipv6/ila/ila_main.c
> index 3faf62530d6a..69caed07315f 100644
> --- a/net/ipv6/ila/ila_main.c
> +++ b/net/ipv6/ila/ila_main.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <net/genetlink.h>
> -#include <net/ila.h>
>  #include <net/netns/generic.h>
>  #include <uapi/linux/genetlink.h>
>  #include "ila.h"
> diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
> index bee45dfeb187..67e8c9440977 100644
> --- a/net/ipv6/ila/ila_xlat.c
> +++ b/net/ipv6/ila/ila_xlat.c
> @@ -5,7 +5,6 @@
>  #include <linux/rhashtable.h>
>  #include <linux/vmalloc.h>
>  #include <net/genetlink.h>
> -#include <net/ila.h>
>  #include <net/netns/generic.h>
>  #include <uapi/linux/genetlink.h>
>  #include "ila.h"
> -- 
> 2.34.1
> 
> 

