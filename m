Return-Path: <netdev+bounces-45840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F4F7DFE79
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 04:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242701C20ECE
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 03:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1725415B6;
	Fri,  3 Nov 2023 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14767E
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 03:50:15 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2150DCE
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 20:50:12 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SM6981B8KzPp1r;
	Fri,  3 Nov 2023 11:46:04 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 11:50:10 +0800
Subject: Re: [PATCH 1/2][net-next] skbuff: move
 netlink_large_alloc_large_skb() to skbuff.c
To: "Li,Rongqing" <lirongqing@baidu.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
References: <20231102062836.19074-1-lirongqing@baidu.com>
 <50622ac2-0939-af35-5d62-c56249e7bd26@huawei.com>
 <d8fe126e98d1494baddc715c39deef3d@baidu.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <9df5ed1d-ef55-9272-22fd-f2324dc3b5ba@huawei.com>
Date: Fri, 3 Nov 2023 11:50:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d8fe126e98d1494baddc715c39deef3d@baidu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/2 20:09, Li,Rongqing wrote:
>> -----Original Message-----
>> From: Yunsheng Lin <linyunsheng@huawei.com>
>> Sent: Thursday, November 2, 2023 7:02 PM
>> To: Li,Rongqing <lirongqing@baidu.com>; netdev@vger.kernel.org
>> Subject: Re: [PATCH 1/2][net-next] skbuff: move netlink_large_alloc_large_skb()
>> to skbuff.c
>>
>> On 2023/11/2 14:28, Li RongQing wrote:
>>> move netlink_alloc_large_skb and netlink_skb_destructor to skbuff.c
>>> and rename them more generic, so they can be used elsewhere large
>>> non-contiguous physical memory is needed
>>>
>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>> ---
>>>  include/linux/skbuff.h   |  3 +++
>>>  net/core/skbuff.c        | 40
>> ++++++++++++++++++++++++++++++++++++++++
>>>  net/netlink/af_netlink.c | 41
>>> ++---------------------------------------
>>>  3 files changed, 45 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h index
>>> 4174c4b..774a401 100644
>>> --- a/include/linux/skbuff.h
>>> +++ b/include/linux/skbuff.h
>>> @@ -5063,5 +5063,8 @@ static inline void skb_mark_for_recycle(struct
>>> sk_buff *skb)  ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter
>> *iter,
>>>  			     ssize_t maxsize, gfp_t gfp);
>>>
>>> +
>>> +void large_skb_destructor(struct sk_buff *skb); struct sk_buff
>>> +*alloc_large_skb(unsigned int size, int broadcast);
>>>  #endif	/* __KERNEL__ */
>>>  #endif	/* _LINUX_SKBUFF_H */
>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c index
>>> 4570705..20ffcd5 100644
>>> --- a/net/core/skbuff.c
>>> +++ b/net/core/skbuff.c
>>> @@ -6917,3 +6917,43 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb,
>> struct iov_iter *iter,
>>>  	return spliced ?: ret;
>>>  }
>>>  EXPORT_SYMBOL(skb_splice_from_iter);
>>> +
>>> +void large_skb_destructor(struct sk_buff *skb) {
>>> +	if (is_vmalloc_addr(skb->head)) {
>>> +		if (!skb->cloned ||
>>> +		    !atomic_dec_return(&(skb_shinfo(skb)->dataref)))
>>> +			vfree(skb->head);
>>> +
>>> +		skb->head = NULL;
>>
>> There seems to be an assumption that skb returned from
>> netlink_alloc_large_skb() is not expecting the frag page for shinfo->frags*, as the
>> above NULL setting will bypass most of the handling in skb_release_data(),then
>> how can we ensure that the user is not breaking the assumption if we make it
>> more generic?
>>
> 
> How about to add WARN_ON(skb_shinfo(skb)-> nr_frags) to find this condition
> 

There is some other handling other than skb_shinfo(skb)-> nr_frags, such as
zcopy, fraglist and pp_recycle handling, I am not sure if adding those check
in the normal datapatch is worth it if netlink_alloc_large_skb() is only used
in the nlmsg operations, which is less performance senstive.

If there are other nlmsg operations that needs it too? if not, maybe we limit
netlink_alloc_large_skb() in nlmsg if we can assume all nlmsg APIs dosen't
break the above assumptionm, introducing something like vnlmsg_new() or only
change nlmsg_new() to use netlink_alloc_large_skb(), so that all nlmsg users can
make use of it.

If there is more user making use of netlink_alloc_large_skb() in the future, we
can make it usable outside of nlmsg.

> 
> -Li RongQing
>>
> 

