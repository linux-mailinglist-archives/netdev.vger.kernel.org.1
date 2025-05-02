Return-Path: <netdev+bounces-187422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EC3AA70D8
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6219A19D1
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0A2246769;
	Fri,  2 May 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6dNNYFY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A93D76
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746186435; cv=none; b=FsGgApgIhFwG3vJgDBmuikbcJpj0eUUf2Z3Bq2vD06thS/UmfVCAcF2p8wnKI3SJcJ2k9wTUZ+L31tRI5MtEAhp4Lcul86L+GxcTh5qkI/8dYpjKkeoNSYGJSqBgsW3h8gmHcPhlm26lK7W5z8jaJjWnRqBmYPLNyXuI62UYsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746186435; c=relaxed/simple;
	bh=cB2cxb192pgUkDCF/6JRnHqrlQVpXJEBsmB29jSR3dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Us77Bplui/k6656Jx/x2IAO4u+cs4+ldaTGixIWh7+fQgfZf3jN31OYgyq2ggsUyjmk57Tup4BtAwc1g7UN0PU1bgRVkkfC/Nvfb3vfvphhO4RwHRhKr8pqmeYwLhwLftSDINMpsOwZLJOmyJMXHM4S0ohFnnrWl5MlQ7XKRpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6dNNYFY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746186431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bd+qrSUziC6Hp37oryqfJ42cozggFXlnjz2f5SA/Nlw=;
	b=L6dNNYFYKtBJP1kfLI5PhIpG5Z+ozOTm7hZs2VDWePOEEUkpRaBc+N5RqPFdE121DMvy3+
	xy38ta5bvS3odSObmoxiqpXbY1eMYfKXLLR5QSuz3CWaLmb5Hh6l+k5vrVTFA9LoFrHd4d
	jFix5avV529hddSR1PsGe8hStWbgWX4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-ZplP1qcdPSSP-ZPQfw03Ug-1; Fri, 02 May 2025 07:47:09 -0400
X-MC-Unique: ZplP1qcdPSSP-ZPQfw03Ug-1
X-Mimecast-MFC-AGG-ID: ZplP1qcdPSSP-ZPQfw03Ug_1746186429
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so12983595e9.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 04:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746186429; x=1746791229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bd+qrSUziC6Hp37oryqfJ42cozggFXlnjz2f5SA/Nlw=;
        b=dgD2LmJDH+RlECFNQJ8D+70lz9411Nt6ur84E1cBSSEi5LZbB4A0Fhuyxa7zMTqQf7
         uQOCHaFdmFGRk7na2slV7E6qun3uuO9U/XEgPg4AqjvfHKgUzMLnf/S5B/PzSJ4lRXk9
         7GQlDd+FYSxP+pqqgqWBaoDl22g2nlPtriGmdcYZdRXQIAymvW6maE9dp8CKFB+YpRnv
         55QKUaFOY2CVQDndWezM8e0IR6glmQPqyTCGpY0YF6MXQoylBtJmHzPF3DLLtiVWvVX3
         ZrQsj3G/dmlvmxGjcTSDzCBeHHNYF6QCRvVvsfwamZe0qISWxpyWb0bMiGHLAWRQlvfg
         zIsg==
X-Forwarded-Encrypted: i=1; AJvYcCU3HhONKL/YgYNiLXYcxgvj7lTuKS3xqyit/gqH6vcXkFRbuaRnSB8UJladvdl9a4YZOdDCOwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiIP3R7snWlXZktI5+PYGfzW+sLGjBK6TUwdkYRxDbO3kd8XzG
	8OwVIMeCpQTizXoqAmKkL0osjytRDlL52M3pExomuADzcsezDBk3Ng4XkM/NtEwKxGsFcg0Jub6
	Ng2LSc1r3bHNCy3+qkdah9aa9gHtAcNOOBLmDy4/lyrUtp9/2hsy50Q==
X-Gm-Gg: ASbGncu5UbHwcFjPgquZ6Rh54yYJY5OBSu9Lw6vdtX5A8Sl6CCJQBEVMPg8QqaTdwXW
	cAcXdpBB5HnLQ8vBfdN2G1MAJCvs/FSbzfo6RQV/fKNIqb8l9PtGVaYqbLS9vHw9i9Jui+ptnZI
	kYwizWkaUSrEDB0pghnSu3eznY0xjWDGLZTaZOpPLRCjQa6cieR/BQOD+pe+yngpoYzb21l9mFW
	mL/ZxdGVS3RJXy3M6DK2OiTfgnL+HBMl8YwOANT/HWLiphCyYOnn3f9ckb1GPUtcEraA49ORGnv
	2L5GXt64RxbWEABvv+Q=
X-Received: by 2002:a05:600c:1907:b0:43d:aed:f7de with SMTP id 5b1f17b1804b1-441bbf31b4fmr17578775e9.21.1746186428646;
        Fri, 02 May 2025 04:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNkSVOCPi9/Yl9G06/uxys7n8ZbaJNy9wtYWx0RJ7ALzhpTB8PeBBxho/R9jjz77v4vvgt8Q==
X-Received: by 2002:a05:600c:1907:b0:43d:aed:f7de with SMTP id 5b1f17b1804b1-441bbf31b4fmr17578465e9.21.1746186428227;
        Fri, 02 May 2025 04:47:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aecc89sm87546305e9.9.2025.05.02.04.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 04:47:07 -0700 (PDT)
Message-ID: <53433089-7beb-46cf-ae8a-6c58cd909e31@redhat.com>
Date: Fri, 2 May 2025 13:47:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 4/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 io-uring@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250429032645.363766-1-almasrymina@google.com>
 <20250429032645.363766-5-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250429032645.363766-5-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/29/25 5:26 AM, Mina Almasry wrote:
> Augment dmabuf binding to be able to handle TX. Additional to all the RX
> binding, we also create tx_vec needed for the TX path.
> 
> Provide API for sendmsg to be able to send dmabufs bound to this device:
> 
> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
> 
> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
> implementation, while disabling instances where MSG_ZEROCOPY falls back
> to copying.
> 
> We additionally pipe the binding down to the new
> zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
> instead of the traditional page netmems.
> 
> We also special case skb_frag_dma_map to return the dma-address of these
> dmabuf net_iovs instead of attempting to map pages.
> 
> The TX path may release the dmabuf in a context where we cannot wait.
> This happens when the user unbinds a TX dmabuf while there are still
> references to its netmems in the TX path. In that case, the netmems will
> be put_netmem'd from a context where we can't unmap the dmabuf, Resolve
> this by making __net_devmem_dmabuf_binding_free schedule_work'd.
> 
> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
> of the implementation came from devmem TCP RFC v1[1], which included the
> TX path, but Stan did all the rebasing on top of netmem/net_iov.
> 
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

I'm sorry for the late feedback. A bunch of things I did not notice
before...

> @@ -701,6 +743,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  
>  	if (msg && msg->msg_ubuf && msg->sg_from_iter)
>  		ret = msg->sg_from_iter(skb, from, length);
> +	else if (unlikely(binding))

I'm unsure if the unlikely() here (and in similar tests below) it's
worthy: depending on the actual workload this condition could be very
likely.

[...]
> @@ -1066,11 +1067,24 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  	int flags, err, copied = 0;
>  	int mss_now = 0, size_goal, copied_syn = 0;
>  	int process_backlog = 0;
> +	bool sockc_valid = true;
>  	int zc = 0;
>  	long timeo;
>  
>  	flags = msg->msg_flags;
>  
> +	sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags),
> +					.dmabuf_id = 0 };

the '.dmabuf_id = 0' part is not needed, and possibly the code is
clearer without it.

> +	if (msg->msg_controllen) {
> +		err = sock_cmsg_send(sk, msg, &sockc);
> +		if (unlikely(err))
> +			/* Don't return error until MSG_FASTOPEN has been
> +			 * processed; that may succeed even if the cmsg is
> +			 * invalid.
> +			 */
> +			sockc_valid = false;
> +	}
> +
>  	if ((flags & MSG_ZEROCOPY) && size) {
>  		if (msg->msg_ubuf) {
>  			uarg = msg->msg_ubuf;
> @@ -1078,7 +1092,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  				zc = MSG_ZEROCOPY;
>  		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>  			skb = tcp_write_queue_tail(sk);
> -			uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb));
> +			uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb),
> +						    sockc_valid && !!sockc.dmabuf_id);

If sock_cmsg_send() failed and the user did not provide a dmabuf_id,
memory accounting will be incorrect.

>  			if (!uarg) {
>  				err = -ENOBUFS;
>  				goto out_err;
> @@ -1087,12 +1102,27 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  				zc = MSG_ZEROCOPY;
>  			else
>  				uarg_to_msgzc(uarg)->zerocopy = 0;
> +
> +			if (sockc_valid && sockc.dmabuf_id) {
> +				binding = net_devmem_get_binding(sk, sockc.dmabuf_id);
> +				if (IS_ERR(binding)) {
> +					err = PTR_ERR(binding);
> +					binding = NULL;
> +					goto out_err;
> +				}
> +			}
>  		}
>  	} else if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES) && size) {
>  		if (sk->sk_route_caps & NETIF_F_SG)
>  			zc = MSG_SPLICE_PAGES;
>  	}
>  
> +	if (sockc_valid && sockc.dmabuf_id &&
> +	    (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
> +		err = -EINVAL;
> +		goto out_err;
> +	}
> +
>  	if (unlikely(flags & MSG_FASTOPEN ||
>  		     inet_test_bit(DEFER_CONNECT, sk)) &&
>  	    !tp->repair) {
> @@ -1131,14 +1161,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  		/* 'common' sending to sendq */
>  	}
>  
> -	sockc = (struct sockcm_cookie) { .tsflags = READ_ONCE(sk->sk_tsflags)};
> -	if (msg->msg_controllen) {
> -		err = sock_cmsg_send(sk, msg, &sockc);
> -		if (unlikely(err)) {
> -			err = -EINVAL;
> -			goto out_err;
> -		}
> -	}
> +	if (!sockc_valid)
> +		goto out_err;

Here 'err' could have been zeroed by tcp_sendmsg_fastopen(), and out_err
could emit a wrong return value.

Possibly it's better to keep the 'dmabuf_id' initialization out of
sock_cmsg_send() in a separate helper could simplify the handling here?

/P


