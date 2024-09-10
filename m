Return-Path: <netdev+bounces-126998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF7C97394A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB281F23A3E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36219413D;
	Tue, 10 Sep 2024 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs8rmIBW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2943194088
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977056; cv=none; b=HPASEmpEZIH7WyO1/Mo4Hsxvj3QMCVUBuvKs7/E8Gmet2eNJVrlzudERZgI7mumobHaf7sRAt6iG4+KcuEz1h9+BgHnInYIOkeXSqj6XoKAHRjGuoS7CU65t4dUE8IakJI0Urht8FI/70B7JbmdmX0HtaFF76ec64YJj8rIbs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977056; c=relaxed/simple;
	bh=LBN/DnDm5/A/b47DId1ssZsZVduj/8QzGNO8ZsNqSyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s61HqYOLgXr7z0UGy1uIeFt6pNyT2Y+IDhIRIe/5wGCOvxHs6wTfyJOI+8HPUeMvyQZSt54y5aXXFIkz9sGUZBdmxxUfzaLXKWdV/6Yf2Xc7Z57HnIox2xBi38dPQHYZd94a7O2Z5ZOtjiE4/ggn0XTGKtc2i0y5NBUDbleujRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vs8rmIBW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725977053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/tFBSyIeFXq/nxQiX3z74k5CZtrJ0NL2wlqYuRfQq0=;
	b=Vs8rmIBWQcmQt7IuJYGakNjrqd7uz+fF9sF6SzA1U7Wt00Oys2cAJgeAtokKqigSSsdhpY
	TSjbY+YaMNztaoj8pyoWtdWHo5e+bBDYss33qXDYqq76eogd2lP5fSB4i+JYcWw+V0wOIr
	W3DRtMJVT9XnJe5vkHd6QAQIITJA8L8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-lnyyr4BCM6qkf0UhoYoA1w-1; Tue, 10 Sep 2024 10:04:10 -0400
X-MC-Unique: lnyyr4BCM6qkf0UhoYoA1w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb374f0cdso14212535e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 07:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977049; x=1726581849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/tFBSyIeFXq/nxQiX3z74k5CZtrJ0NL2wlqYuRfQq0=;
        b=TSAKig79oQbzI02fxm3hu2EOMfvMHpZFGObfaODhMkLOpn7CLIDevVABbfZOIgMPtj
         XrOGne7NIq9C/osVE6XZMEm/BUDOQ7KhjhMd61a/Z2ywl8QBXoUeAqGUS1mpJhTuANb/
         cJEBf99JCaTp67EE9UbCPH5yXhopyAsxFCcH6JWgrJ/pAV8AeLsLKnsJarY+ghChw/5c
         ZlvkZSeSZiPKOEkZiAh52KJYSm8WLrx4OJpWGt3XTuEu7gzFslrVS8PqWQV5dzcTLujn
         BcGg86NE9mpY9KuKZKRcCMes6cBRihQzpciIhSLTluwN3+utsOyqWXQROHV0S8DWkc2Q
         KQvA==
X-Gm-Message-State: AOJu0YzuWHqkAtkEtVvS9fjQUjbkxPN63Z7x1LEP2LuL59sXoXuVNweX
	+2ATkvO4qRKGKV1yyfK8Nd0oc1F/1qJcQzVyuAyHrYv+EIOp/JUYpxFCbzPYyD+24Tlw4a/i1WM
	knnhBLL3YFrSTxVTMERYp7tarXHxHMXhRtjhPQDVNW+u3SLASZX416w==
X-Received: by 2002:a05:600c:1992:b0:42c:b826:a26c with SMTP id 5b1f17b1804b1-42cbddced8fmr19781725e9.8.1725977049309;
        Tue, 10 Sep 2024 07:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFQhE+vt6e0XqO6sgKTdoT7A+C7YkFPXFefNLhlpdrkwxTPv+GeTt9Ow48cp4HAWvOj1D3RA==
X-Received: by 2002:a05:600c:1992:b0:42c:b826:a26c with SMTP id 5b1f17b1804b1-42cbddced8fmr19781005e9.8.1725977048699;
        Tue, 10 Sep 2024 07:04:08 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb1cf939asm98601195e9.19.2024.09.10.07.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 07:04:08 -0700 (PDT)
Message-ID: <1884e171-cc87-4238-abd1-0f6be1e0b279@redhat.com>
Date: Tue, 10 Sep 2024 16:04:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 12/14] net: replace page_frag with
 page_frag_cache
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Ayush Sawal <ayush.sawal@chelsio.com>, Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, David Ahern <dsahern@kernel.org>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Boris Pismenny <borisp@nvidia.com>, bpf@vger.kernel.org,
 mptcp@lists.linux.dev
References: <20240906073646.2930809-1-linyunsheng@huawei.com>
 <20240906073646.2930809-13-linyunsheng@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240906073646.2930809-13-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 09:36, Yunsheng Lin wrote:
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 49811c9281d4..6190d9bfd618 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -953,7 +953,7 @@ static int __ip_append_data(struct sock *sk,
>   			    struct flowi4 *fl4,
>   			    struct sk_buff_head *queue,
>   			    struct inet_cork *cork,
> -			    struct page_frag *pfrag,
> +			    struct page_frag_cache *nc,
>   			    int getfrag(void *from, char *to, int offset,
>   					int len, int odd, struct sk_buff *skb),
>   			    void *from, int length, int transhdrlen,
> @@ -1228,13 +1228,19 @@ static int __ip_append_data(struct sock *sk,
>   			copy = err;
>   			wmem_alloc_delta += copy;
>   		} else if (!zc) {
> +			struct page_frag page_frag, *pfrag;
>   			int i = skb_shinfo(skb)->nr_frags;
> +			void *va;
>   
>   			err = -ENOMEM;
> -			if (!sk_page_frag_refill(sk, pfrag))
> +			pfrag = &page_frag;
> +			va = sk_page_frag_alloc_refill_prepare(sk, nc, pfrag);
> +			if (!va)
>   				goto error;
>   
>   			skb_zcopy_downgrade_managed(skb);
> +			copy = min_t(int, copy, pfrag->size);
> +
>   			if (!skb_can_coalesce(skb, i, pfrag->page,
>   					      pfrag->offset)) {
>   				err = -EMSGSIZE;
> @@ -1242,18 +1248,18 @@ static int __ip_append_data(struct sock *sk,
>   					goto error;
>   
>   				__skb_fill_page_desc(skb, i, pfrag->page,
> -						     pfrag->offset, 0);
> +						     pfrag->offset, copy);
>   				skb_shinfo(skb)->nr_frags = ++i;
> -				get_page(pfrag->page);
> +				page_frag_commit(nc, pfrag, copy);
> +			} else {
> +				skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1],
> +						  copy);
> +				page_frag_commit_noref(nc, pfrag, copy);
>   			}
> -			copy = min_t(int, copy, pfrag->size - pfrag->offset);
> -			if (getfrag(from,
> -				    page_address(pfrag->page) + pfrag->offset,
> -				    offset, copy, skb->len, skb) < 0)
> +
> +			if (getfrag(from, va, offset, copy, skb->len, skb) < 0)
>   				goto error_efault;

Should the 'commit' happen only when 'getfrag' is successful?

Similar question in the ipv6 code.

Thanks,

Paolo


