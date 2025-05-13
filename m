Return-Path: <netdev+bounces-190116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7EBAB536E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FC43B1200
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039512853EE;
	Tue, 13 May 2025 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8+pebEE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477702882DF
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134275; cv=none; b=G+Y2EucajIDUFPcUp3Gf45E3iLs+kc1IRzzIrZNYhB51jlWuvLvnjZwksrDbuncI0rRrhWZuxnWD48Ita6aJdgR2vn979MUEoBNQKGDY+qNeUkFV0e1/JH2TdJZfChCgyRdbGZRaH5lYYlifxAjWDfR3znTWAQZ4jIQnPnd/qUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134275; c=relaxed/simple;
	bh=cD0kSgh62M8/Y/zh/4GOrt1GenQJy1Ty3520jNy+5Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1l7XhYO2kSDIESTIDG+aQrvthC0I5Sqvg18n36EUrWQSCnMkCGbJ7tHBpHVb39N2kFKktyFAkg/n54R9/ERjOj5ZU3+ly0elYDNa6+44rJ4S87EOoxnQ2QyyaBrNS2MwCo76HeHBP4kd1UJ/CIiLlAt1zLzXskOBsmFLEg9Y1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8+pebEE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747134273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xK2MgygORKh5aA+2qnSZ6R0zwTOP1pHjPLlJuNvz8ic=;
	b=Q8+pebEEk5NRMQuELwNWKOCuD2fEbsz0pXlZ6f8NauIOhKrdoEMHGVnD+czRZwko/FypA4
	fN7nl5JQpJtW40WDVxeoIM8AZC1RKwY3yx5Z4G0z+hwFAFG5ABxEwKznBui16f1Wtqq/Yz
	dsDtrbdfbv3pTg/D1LvRWecOYsOlAOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-pYzfGbTqOTOtgiza-H1qGg-1; Tue, 13 May 2025 07:04:32 -0400
X-MC-Unique: pYzfGbTqOTOtgiza-H1qGg-1
X-Mimecast-MFC-AGG-ID: pYzfGbTqOTOtgiza-H1qGg_1747134271
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a0b570a73eso3121608f8f.1
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 04:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134271; x=1747739071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xK2MgygORKh5aA+2qnSZ6R0zwTOP1pHjPLlJuNvz8ic=;
        b=QwlquP26ZYBsc7W3feZDk0AUoznFNlGOBQoHN56yO/WwBlZTzTVssliMIyjH3MXD7z
         HkJeLmFK70W/GrZClK8L6x7j2vCrYoU9bkrXEWlF+JN50oOuzSGHve1os0JKWkke/wS5
         ioI3nNt/7qfHn4AlvysLwWRXfZqUsgU6dYovJW0dlKYn2WCRIXzmolN7pV+yEO/a4f7g
         1mw8Z76EEi6RBVvI20gOhCO/60tsaE3uPDI6WnMPklsGv0RcpsIonJnKE/B37sS1Ik3n
         O3v/j3/mDeiH3WTAoOdDlr7quOUVlLhHCnQibxfbR+nmZ+sn/kubc80uh7pX0tmyTIxk
         84YA==
X-Forwarded-Encrypted: i=1; AJvYcCUhOrb4lb8KfS/T8Cqf8+tq6ocWa3WSezt8zKcbB1PA3LV9oNDYgRnm9xqYRqEa7lBW/38l+2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeYEm8iMC+Qe8iB/xoXVMTDtzuEbLms8rz2CGJhFAJjKLZxgQ7
	sKSXKZO8KN4/C1HgY6dTqe5fGUmuQWQIjQ4uLZNl+bnJscQPtFXW1fZaNGH4MLSqAaSVKBRF9cF
	vI2enjVzDe0rmsDRGsdoJVwGyHI+pwOKdRVg6KXrJjfFdT1TOdWl7tQ==
X-Gm-Gg: ASbGnctxL81Z0GP1Rv8irlIbipHC2JmVlIRmWo5qqAV7YEmAEW7qQbWKTa9HXO3PdK5
	dsNHB61ppzFaBe3rSoApjwetBUoyRJYLy8YlXnKEwm6/ycbOttQg2WZC5cQ9G/fLrjHnZFRZ3jI
	JxR/gkrmU/lpCE5B37ZWYyweMuZe/7RqQoP14i9J33tmei9RRJlt5zYI225tmkG/Rnzo5PBQN4r
	lZJrGM/19qUlTcd0qZOlzHKmafxnjJ99PkQuwqzgZ8zUE3PCc7wVYxCBlbOKszcCY81ijzxLyi5
	osBhP7FvTRszhff8zgM=
X-Received: by 2002:adf:e0c6:0:b0:3a1:f91e:b029 with SMTP id ffacd0b85a97d-3a1f91eb0b4mr10378434f8f.57.1747134270787;
        Tue, 13 May 2025 04:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqosrgja6xlH2lyXFtG4dHnj8AU6GKe27ulz+iWqCHknSq8THOKHDj28BckES7SZkWcSkhFQ==
X-Received: by 2002:adf:e0c6:0:b0:3a1:f91e:b029 with SMTP id ffacd0b85a97d-3a1f91eb0b4mr10378409f8f.57.1747134270377;
        Tue, 13 May 2025 04:04:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32f238sm202841325e9.11.2025.05.13.04.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 04:04:29 -0700 (PDT)
Message-ID: <aac5b03d-1380-437a-9763-1069aff1fd8b@redhat.com>
Date: Tue, 13 May 2025 13:04:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2] net: track pfmemalloc drops via
 SKB_DROP_REASON_PFMEMALLOC
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 kernel-team@cloudflare.com, mfleming@cloudflare.com
References: <174680137188.1282310.4154030185267079690.stgit@firesoul>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <174680137188.1282310.4154030185267079690.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 4:36 PM, Jesper Dangaard Brouer wrote:
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5cf4d35d83e..cb31be77dd7e 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1073,12 +1073,21 @@ bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
>  	return set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
>  }
>  
> -int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);
> +int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap,
> +		       enum skb_drop_reason *reason);
>  static inline int sk_filter(struct sock *sk, struct sk_buff *skb)
>  {
> -	return sk_filter_trim_cap(sk, skb, 1);
> +	enum skb_drop_reason ignore_reason;
> +
> +	return sk_filter_trim_cap(sk, skb, 1, &ignore_reason);
> +}

I'm sorry to nit-pick but checkpatch is not happy about the lack of
black lines here, and I think an empty line would make the code more
readable.

[...]
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 03d20a98f8b7..a1e10a13f7c8 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5910,7 +5910,11 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>  			dev_core_stats_rx_dropped_inc(skb->dev);
>  		else
>  			dev_core_stats_rx_nohandler_inc(skb->dev);
> -		kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);
> +
> +		if (pfmemalloc)
> +			kfree_skb_reason(skb, SKB_DROP_REASON_PFMEMALLOC);
> +		else
> +			kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);

AFAICS we can reach here even if skb_orphan_frags_rx() fails and that
will be accounted as 'SKB_DROP_REASON_UNHANDLED_PROTO'. Perhaps it would
be better to let the 'goto out' caller set the drop reason? And also set
it to 'SKB_DROP_REASON_UNHANDLED_PROTO' in this block before the 'out:'
label.

[...]
> @@ -2637,6 +2635,7 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
>  int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  		   int proto)
>  {
> +	enum skb_drop_reason drop_reason;
>  	struct sock *sk = NULL;
>  	struct udphdr *uh;
>  	unsigned short ulen;
> @@ -2644,7 +2643,6 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
>  	__be32 saddr, daddr;
>  	struct net *net = dev_net(skb->dev);
>  	bool refcounted;
> -	int drop_reason;
>  
>  	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  

The above 2 chunks look unrelated/unneeded. Since the patch is already
pretty big, I think it would be better to not include them.

Thanks,

Paolo


