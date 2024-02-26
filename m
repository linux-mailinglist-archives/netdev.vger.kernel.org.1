Return-Path: <netdev+bounces-74796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C587866792
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 02:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370CF2817A5
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B199CA4E;
	Mon, 26 Feb 2024 01:33:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294A14A98
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708911194; cv=none; b=S+2nVp6+DknjJgvOJc0e5sNp81c/P3T8vTkIWo5LmFkqA578uCIp3UJVl42CpZOM+QshsH1esq65UKL8z34lJ+c/3JPAPNW49flXXBJESqf8KXL9n0KirW1ucIoBn8wuKuq/HTBFU0d5vc66t1xiTIsWit+tUT1uiZj7o5WxWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708911194; c=relaxed/simple;
	bh=E3Yu1RUX14Gg/uC2+G8QywRVM6FMrNsokF9EgSGx9Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZpUqUZ5S9akrBecTsEaUSdXio8PVQCmHisQboB+x6cXWzAJ3g6Xsk6gm68yNWHm57sfb7bJELQmLalLi/2VgtXTO9kN7iSQCK5ATaUjfTLcChMTtdYovDIoqbSDx+ybvu2mSrdf/6zn6FrV/cFhg6jI9qAZrVMD/yxUK+Qhy7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TjjkY3LSpzWv21;
	Mon, 26 Feb 2024 09:31:17 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 172D5140134;
	Mon, 26 Feb 2024 09:33:03 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 09:33:02 +0800
Message-ID: <c6d094cf-16ae-990f-c670-95c570631285@huawei.com>
Date: Mon, 26 Feb 2024 09:33:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] netlink: use kvmalloc() in
 netlink_alloc_large_skb()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20240224090630.605917-1-edumazet@google.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20240224090630.605917-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/2/24 17:06, Eric Dumazet wrote:
> This is a followup of commit 234ec0b6034b ("netlink: fix potential
> sleeping issue in mqueue_flush_file"), because vfree_atomic()
> overhead is unfortunate for medium sized allocations.
> 
> 1) If the allocation is smaller than PAGE_SIZE, do not bother
>     with vmalloc() at all. Some arches have 64KB PAGE_SIZE,
>     while NLMSG_GOODSIZE is smaller than 8KB.
> 
> 2) Use kvmalloc(), which might allocate one high order page
>     instead of vmalloc if memory is not too fragmented.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>   net/netlink/af_netlink.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 9c962347cf859f16fc76e4d8a2fd22cdb3d142d6..90ca4e0ed9b3632bf223bf29fd864dbb76f3c89c 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1206,23 +1206,21 @@ struct sock *netlink_getsockbyfilp(struct file *filp)
>   
>   struct sk_buff *netlink_alloc_large_skb(unsigned int size, int broadcast)
>   {
> +	size_t head_size = SKB_HEAD_ALIGN(size);
>   	struct sk_buff *skb;
>   	void *data;
>   
> -	if (size <= NLMSG_GOODSIZE || broadcast)
> +	if (head_size <= PAGE_SIZE || broadcast)
>   		return alloc_skb(size, GFP_KERNEL);
>   
> -	size = SKB_DATA_ALIGN(size) +
> -	       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -
> -	data = vmalloc(size);
> -	if (data == NULL)
> +	data = kvmalloc(head_size, GFP_KERNEL);
> +	if (!data)
>   		return NULL;
>   
> -	skb = __build_skb(data, size);
> -	if (skb == NULL)
> -		vfree(data);
> -	else
> +	skb = __build_skb(data, head_size);
> +	if (!skb)
> +		kvfree(data);
> +	else if (is_vmalloc_addr(data))
>   		skb->destructor = netlink_skb_destructor;
>   
>   	return skb;
LGTM, thanks.

Reviewed-by: Zhengchao Shao <shaozhengchao@huawei.com>

