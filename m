Return-Path: <netdev+bounces-95830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220088C39BC
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 02:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9341B281169
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 00:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE2C8BF6;
	Mon, 13 May 2024 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr9M0Ef0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A66322B
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715561917; cv=none; b=Cucy1z8bcr1HyHTbAqZPqiH8N0JwK4kiMLesUtprPjGyD8d5o1vGNh5k2CKgPIm94/68SXwZ7VRbMtEl+hRA02OUlduivQ2S6qyS7Rgc3wF1MOdUdZUjMFXTawHzdoG7OAYLLEHUmDKh8fxKerWaf24RXj6cATfr6vasZ0pb6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715561917; c=relaxed/simple;
	bh=uLoQHY5fPpeVy356l44jGAXbqd+xa/5Z+ebwCt4itlE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=L9bTuuuGW5Pm231C2roqPryOp+6UWKP9ImaUVPUhyc4qhk6zHAN1CjGcKBe+Za4wmixOA4IZ35loV88BBHm7Dl41Efy3Au/WOeZgeScr4n7bf9odhPzm2bWjWo2spTTx7YB9uvUUcoVnF4XR9VUq6uxCa9dgdO+krUen3CI346s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr9M0Ef0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-792b8c9046bso344848685a.3
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 17:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715561914; x=1716166714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lXxdqPm0uOtUJcFBlBjChktLW0GDHROE5MMZ4i7utI=;
        b=Lr9M0Ef0rqtKftSEO2YbUf5aGApE+Z6pwWuOk0WOkMmq6mWN4n+1iBvR2Jif9aOd0S
         GmhngkozjOFRTEeu+NpgjEOm416bgRW646G00FsTCOZN1S1nppN4Wq4M9jvvDjaC2ML8
         DM2t8Z3P9++gRthPLKlYHhgz8czXtzPKx2ek30EPs073OZCLU4JY7ugCk3FI87pVrH/Z
         5eS4ZZJxlNHbLxz6kf2gFdIJf/qG2rUhOtOarX0KLO1jAYryqvrMhu8JFud2K7DS8Z1+
         4MIr8MtK846DXDRYHiqVdVU1lzfI8sVQCs5Iu7l5YeAYmYS/U/7ZM+htVHbWL6shJld4
         L12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715561914; x=1716166714;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1lXxdqPm0uOtUJcFBlBjChktLW0GDHROE5MMZ4i7utI=;
        b=thdfwV3oLFL7adcsdZFpD4FKFNyq8knfgfWdsAUkQbPIc8pAPYBjhWwmHYGCnTmi69
         3uE4no9l3HEnGniR9uEJYzL9pCZ68ONTEdjOzGc6+4XZpUVBKlt5y4bmo5BoDq8rMZ1s
         /4BF+ExeBsJnn33QR45gTv0R6GDjEObdOBTeReeXyFEjeFG3oi12RhQ0QTEfy7ueSsOa
         Ur0rSZKYn+oDwulqhIRaNTsCIvQ89NSyZEZqu6rEH4DzYxbHPWpiYBobRI5ceZPkH9xO
         UxSJcZvPs5rAu1s1svYlkbJFD/olGNbwvY7ZAuoPrkSSly34r8aUOJiWoCEpM00bh5oo
         TvfA==
X-Forwarded-Encrypted: i=1; AJvYcCXF+3VL8Yv8mT4HfiYchCafIIjw3/dmzZ14SAtRDk7PYmLtocAuyNhxyawg/7je3C/KdXhatB0OmlriCTz3taWWelNaMmjJ
X-Gm-Message-State: AOJu0YyKXN9aXEwZ1XU/rMEE7oaFiz3TRIMO5KaIsj6G1lACbgVR7bcy
	f7Mg3rlqx2FpAzZPJDrKfpp718rjHRMsCfa/pt8RX3Lpu50KWriA
X-Google-Smtp-Source: AGHT+IEbGDa7alDbmQTJEO0RFrY6Z6zDsG4xJZt/ZvKZa/NfDueNCYq07+EbGelvvZkSZ21R8oZLDw==
X-Received: by 2002:ac8:5f96:0:b0:43d:fc62:f0c3 with SMTP id d75a77b69052e-43dfdb20ec6mr119222161cf.10.1715561914310;
        Sun, 12 May 2024 17:58:34 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e1af71f71sm4323411cf.68.2024.05.12.17.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 17:58:34 -0700 (PDT)
Date: Sun, 12 May 2024 20:58:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <664165b9c4bbf_1d6c672948b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240510155900.1825946-3-zijianzhang@bytedance.com>
References: <20240510155900.1825946-1-zijianzhang@bytedance.com>
 <20240510155900.1825946-3-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v3 2/3] sock: add MSG_ZEROCOPY notification
 mechanism based on msg_control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
> However, zerocopy is not a free lunch. Apart from the management of user
> pages, the combination of poll + recvmsg to receive notifications incurs
> unignorable overhead in the applications. The overhead of such sometimes
> might be more than the CPU savings from zerocopy. We try to solve this
> problem with a new notification mechanism based on msgcontrol.
> This new mechanism aims to reduce the overhead associated with receiving
> notifications by embedding them directly into user arguments passed with
> each sendmsg control message. By doing so, we can significantly reduce
> the complexity and overhead for managing notifications. In an ideal
> pattern, the user will keep calling sendmsg with SCM_ZC_NOTIFICATION
> msg_control, and the notification will be delivered as soon as possible.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>

> +#include <linux/types.h>
> +
>  /*
>   * Desired design of maximum size and alignment (see RFC2553)
>   */
> @@ -35,4 +37,12 @@ struct __kernel_sockaddr_storage {
>  #define SOCK_TXREHASH_DISABLED	0
>  #define SOCK_TXREHASH_ENABLED	1
>  
> +#define SOCK_ZC_INFO_MAX 128
> +
> +struct zc_info_elem {
> +	__u32 lo;
> +	__u32 hi;
> +	__u8 zerocopy;
> +};
> +
>  #endif /* _UAPI_LINUX_SOCKET_H */
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8d6e638b5426..15da609be026 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2842,6 +2842,74 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:
>  		break;
> +	case SCM_ZC_NOTIFICATION: {
> +		int ret, i = 0;
> +		int cmsg_data_len, zc_info_elem_num;
> +		void __user	*usr_addr;
> +		struct zc_info_elem zc_info_kern[SOCK_ZC_INFO_MAX];
> +		unsigned long flags;
> +		struct sk_buff_head *q, local_q;
> +		struct sk_buff *skb, *tmp;
> +		struct sock_exterr_skb *serr;

minor: reverse xmas tree

> +
> +		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
> +			return -EINVAL;

Is this mechanism supported for PF_RDS?
The next patch fails on PF_RDS + '-n'

> +
> +		cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
> +		if (cmsg_data_len % sizeof(struct zc_info_elem))
> +			return -EINVAL;
> +
> +		zc_info_elem_num = cmsg_data_len / sizeof(struct zc_info_elem);
> +		if (!zc_info_elem_num || zc_info_elem_num > SOCK_ZC_INFO_MAX)
> +			return -EINVAL;
> +
> +		if (in_compat_syscall())
> +			usr_addr = compat_ptr(*(compat_uptr_t *)CMSG_DATA(cmsg));
> +		else
> +			usr_addr = (void __user *)*(void **)CMSG_DATA(cmsg);

The main design issue with this series is this indirection, rather
than passing the array of notifications as cmsg.

This trick circumvents having to deal with compat issues and having to
figure out copy_to_user in ____sys_sendmsg (as msg_control is an
in-kernel copy).

This is quite hacky, from an API design PoV.

As is passing a pointer, but expecting msg_controllen to hold the
length not of the pointer, but of the pointed to user buffer.

I had also hoped for more significant savings. Especially with the
higher syscall overhead due to meltdown and spectre mitigations vs
when MSG_ZEROCOPY was introduced and I last tried this optimization.

> +		if (!access_ok(usr_addr, cmsg_data_len))
> +			return -EFAULT;
> +
> +		q = &sk->sk_error_queue;
> +		skb_queue_head_init(&local_q);
> +		spin_lock_irqsave(&q->lock, flags);
> +		skb = skb_peek(q);
> +		while (skb && i < zc_info_elem_num) {
> +			struct sk_buff *skb_next = skb_peek_next(skb, q);
> +
> +			serr = SKB_EXT_ERR(skb);
> +			if (serr->ee.ee_errno == 0 &&
> +			    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
> +				zc_info_kern[i].hi = serr->ee.ee_data;
> +				zc_info_kern[i].lo = serr->ee.ee_info;
> +				zc_info_kern[i].zerocopy = !(serr->ee.ee_code
> +								& SO_EE_CODE_ZEROCOPY_COPIED);
> +				__skb_unlink(skb, q);
> +				__skb_queue_tail(&local_q, skb);
> +				i++;
> +			}
> +			skb = skb_next;
> +		}
> +		spin_unlock_irqrestore(&q->lock, flags);
> +
> +		ret = copy_to_user(usr_addr,
> +				   zc_info_kern,
> +					i * sizeof(struct zc_info_elem));
> +
> +		if (unlikely(ret)) {
> +			spin_lock_irqsave(&q->lock, flags);
> +			skb_queue_reverse_walk_safe(&local_q, skb, tmp) {
> +				__skb_unlink(skb, &local_q);
> +				__skb_queue_head(q, skb);
> +			}

Can just list_splice_init?

> +			spin_unlock_irqrestore(&q->lock, flags);
> +			return -EFAULT;
> +		}
> +
> +		while ((skb = __skb_dequeue(&local_q)))
> +			consume_skb(skb);
> +		break;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.20.1
> 



