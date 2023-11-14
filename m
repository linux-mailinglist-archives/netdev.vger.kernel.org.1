Return-Path: <netdev+bounces-47678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 011907EAF3F
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E181C20999
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA29F2D62C;
	Tue, 14 Nov 2023 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730982420C
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 11:32:01 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D69D6C
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 03:31:39 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SV3sz18GvzMmXD;
	Tue, 14 Nov 2023 19:27:03 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 14 Nov
 2023 19:31:37 +0800
Subject: Re: [PATCH][net-next][v2] rtnetlink: instroduce vnlmsg_new and use it
 in rtnl_getlink
To: Li RongQing <lirongqing@baidu.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<Liam.Howlett@oracle.com>, <anjali.k.kulkarni@oracle.com>, <leon@kernel.org>,
	<fw@strlen.de>, <shayagr@amazon.com>, <idosch@nvidia.com>,
	<razor@blackwall.org>, <netdev@vger.kernel.org>
References: <20231114095522.27939-1-lirongqing@baidu.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <7f60f869-ec5c-a58c-a490-80cfcdd0fda7@huawei.com>
Date: Tue, 14 Nov 2023 19:31:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231114095522.27939-1-lirongqing@baidu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/14 17:55, Li RongQing wrote:
> if a PF has 256 or more VFs, ip link command will allocate a order 3
> memory or more, and maybe trigger OOM due to memory fragement,

fragement -> fragment?

> the VFs needed memory size is computed in rtnl_vfinfo_size.
> 
> so instroduce vnlmsg_new which calls netlink_alloc_large_skb in which

instroduce -> introduce?

> vmalloc is used for large memory, to avoid the failure of allocating
> memory
> 
>     ip invoked oom-killer: gfp_mask=0xc2cc0(GFP_KERNEL|__GFP_NOWARN|\
> 	__GFP_COMP|__GFP_NOMEMALLOC), order=3, oom_score_adj=0
>     CPU: 74 PID: 204414 Comm: ip Kdump: loaded Tainted: P           OE
>     Call Trace:
>     dump_stack+0x57/0x6a
>     dump_header+0x4a/0x210
>     oom_kill_process+0xe4/0x140
>     out_of_memory+0x3e8/0x790
>     __alloc_pages_slowpath.constprop.116+0x953/0xc50
>     __alloc_pages_nodemask+0x2af/0x310
>     kmalloc_large_node+0x38/0xf0
>     __kmalloc_node_track_caller+0x417/0x4d0
>     __kmalloc_reserve.isra.61+0x2e/0x80
>     __alloc_skb+0x82/0x1c0
>     rtnl_getlink+0x24f/0x370
>     rtnetlink_rcv_msg+0x12c/0x350
>     netlink_rcv_skb+0x50/0x100
>     netlink_unicast+0x1b2/0x280
>     netlink_sendmsg+0x355/0x4a0
>     sock_sendmsg+0x5b/0x60
>     ____sys_sendmsg+0x1ea/0x250
>     ___sys_sendmsg+0x88/0xd0
>     __sys_sendmsg+0x5e/0xa0
>     do_syscall_64+0x33/0x40
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     RIP: 0033:0x7f95a65a5b70
> 
> Cc: Yunsheng Lin <linyunsheng@huawei.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> diff with v1: not move netlink_alloc_large_skb to skbuff.c
> 
>  include/linux/netlink.h  |  1 +
>  include/net/netlink.h    | 17 +++++++++++++++++
>  net/core/rtnetlink.c     |  2 +-
>  net/netlink/af_netlink.c |  2 +-
>  4 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index 75d7de3..abe91ed 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -351,5 +351,6 @@ bool netlink_ns_capable(const struct sk_buff *skb,
>  			struct user_namespace *ns, int cap);
>  bool netlink_capable(const struct sk_buff *skb, int cap);
>  bool netlink_net_capable(const struct sk_buff *skb, int cap);
> +struct sk_buff *netlink_alloc_large_skb(unsigned int size, int broadcast);
>  
>  #endif	/* __LINUX_NETLINK_H */
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index 83bdf78..7d31217 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -1011,6 +1011,23 @@ static inline struct sk_buff *nlmsg_new(size_t payload, gfp_t flags)
>  }
>  
>  /**
> + * vnlmsg_new - Allocate a new netlink message with non-contiguous
> + * physical memory
> + * @payload: size of the message payload
> + *
> + * Use NLMSG_DEFAULT_SIZE if the size of the payload isn't known
> + * and a good default is needed.
> + *
> + * The allocated skb is unable to have frag page for shinfo->frags*,
> + * as the NULL setting for skb->head in netlink_skb_destructor() will
> + * bypass most of the handling in skb_release_data()
> + */
> +static inline struct sk_buff *vnlmsg_new(size_t payload)
> +{
> +	return netlink_alloc_large_skb(nlmsg_total_size(payload), 0);
> +}

The nlmsg_new() has the below parameters, there is no gfp flags for
vnlmsg_new() and always assuming GFP_KERNEL?

 * @payload: size of the message payload
 * @flags: the type of memory to allocate.

There are a lot of callers for nlmsg_new(), I am wondering how many
of existing nlmsg_new() caller can change to use vnlmsg_new().
https://elixir.free-electrons.com/linux/v6.7-rc1/A/ident/nlmsg_new

> +
> +/**
>   * nlmsg_end - Finalize a netlink message
>   * @skb: socket buffer the message is stored in
>   * @nlh: netlink message header
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index e8431c6..bfae6bf 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3849,7 +3849,7 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		goto out;
>  
>  	err = -ENOBUFS;
> -	nskb = nlmsg_new(if_nlmsg_size(dev, ext_filter_mask), GFP_KERNEL);
> +	nskb = vnlmsg_new(if_nlmsg_size(dev, ext_filter_mask));
>  	if (nskb == NULL)
>  		goto out;
>  
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index eb086b0..17587f1 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1204,7 +1204,7 @@ struct sock *netlink_getsockbyfilp(struct file *filp)
>  	return sock;
>  }
>  
> -static struct sk_buff *netlink_alloc_large_skb(unsigned int size,
> +struct sk_buff *netlink_alloc_large_skb(unsigned int size,
>  					       int broadcast)
>  {
>  	struct sk_buff *skb;
> 

