Return-Path: <netdev+bounces-45693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40FF7DF0CA
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F730B2137C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AFE14006;
	Thu,  2 Nov 2023 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E814A89
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 11:01:58 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109D7185
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:01:56 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SLgpz57BMz1P7tB;
	Thu,  2 Nov 2023 18:58:51 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 2 Nov
 2023 19:01:54 +0800
Subject: Re: [PATCH 1/2][net-next] skbuff: move
 netlink_large_alloc_large_skb() to skbuff.c
To: Li RongQing <lirongqing@baidu.com>, <netdev@vger.kernel.org>
References: <20231102062836.19074-1-lirongqing@baidu.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <50622ac2-0939-af35-5d62-c56249e7bd26@huawei.com>
Date: Thu, 2 Nov 2023 19:01:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231102062836.19074-1-lirongqing@baidu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/2 14:28, Li RongQing wrote:
> move netlink_alloc_large_skb and netlink_skb_destructor to skbuff.c
> and rename them more generic, so they can be used elsewhere large
> non-contiguous physical memory is needed
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  include/linux/skbuff.h   |  3 +++
>  net/core/skbuff.c        | 40 ++++++++++++++++++++++++++++++++++++++++
>  net/netlink/af_netlink.c | 41 ++---------------------------------------
>  3 files changed, 45 insertions(+), 39 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 4174c4b..774a401 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -5063,5 +5063,8 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
>  ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
>  			     ssize_t maxsize, gfp_t gfp);
>  
> +
> +void large_skb_destructor(struct sk_buff *skb);
> +struct sk_buff *alloc_large_skb(unsigned int size, int broadcast);
>  #endif	/* __KERNEL__ */
>  #endif	/* _LINUX_SKBUFF_H */
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 4570705..20ffcd5 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6917,3 +6917,43 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
>  	return spliced ?: ret;
>  }
>  EXPORT_SYMBOL(skb_splice_from_iter);
> +
> +void large_skb_destructor(struct sk_buff *skb)
> +{
> +	if (is_vmalloc_addr(skb->head)) {
> +		if (!skb->cloned ||
> +		    !atomic_dec_return(&(skb_shinfo(skb)->dataref)))
> +			vfree(skb->head);
> +
> +		skb->head = NULL;

There seems to be an assumption that skb returned from
netlink_alloc_large_skb() is not expecting the frag page
for shinfo->frags*, as the above NULL setting will bypass
most of the handling in skb_release_data(),then how can we
ensure that the user is not breaking the assumption if we
make it more generic?


> +	}
> +	if (skb->sk)
> +		sock_rfree(skb);
> +}
> +EXPORT_SYMBOL(large_skb_destructor);
> +


