Return-Path: <netdev+bounces-89873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164FD8ABFBC
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335AE1C20A5A
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D266D182BD;
	Sun, 21 Apr 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/X4wOYZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E13D66
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713714331; cv=none; b=ZVSAJmGWkA13eBwgse0n9wQ7TbgFcc4wMISbjo8NMOXqrCGV/rz9T0pypEvAvfCNvO3i+WkUB/ALG7Cq6+C9k+pT9zajyZiU2Y7K0ijDcay/KT9v+3dwTMUWvSNcRcVEX1ZQakblXJKS5BWTHdRtQNbrzXNICzhgIa8a9V80S9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713714331; c=relaxed/simple;
	bh=wXivgWQuhaa+X9h0/hWtA0DDVHxvswmtssxgaxNfhB4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ikHqXcXrOUSntpwnhYj6MXZUUJILUxzv0NDJh/RiZt5e+uJhc2Nr90gCNoo4BYrZ0hBWYIe8jid7aX8a3lSgiRFkibPzBWFJmqtN8HoF83orheoLyqOjBe8uiS7xZETrv6RaRSUCj8YGudNrVVgOJbIa7knMvAXMH5okZf6IHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/X4wOYZ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6a07eefdd66so1137806d6.2
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713714329; x=1714319129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaxRL9YI7BHyVZs/wy3WysFNG5pbsHdpsTtD3HHXe/M=;
        b=c/X4wOYZ/9h5LTxAuP9cpW6FA5O+wZH/m7ji/xGNLestcNa1OymnifLMWS73msoY+N
         lxJKLXkBotVcHmU0xHLTXrXDwK/lh54Z9YgJnQ1Nz2s4lP2HOo5iI/WZLerGmwaIYotD
         iASwQTp/YyHckqhkHGwK3eTRvo4YLDjBi0gO98i7OBgD1u7Dm9EyoVbfh6rY0fLIw2ss
         iHo9NARDXkDF/WXN+xiSi56jU7NU4xbSHKYfU0Xq78NP5oCZnjFF48L0Y54jLPy7u8a5
         LPpZn/FqoPwzQT1QBAZYiPo7FBfdrOoGwnegx4pI5yVebvwLtgGSionm/Em34ur4XC6A
         18KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713714329; x=1714319129;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QaxRL9YI7BHyVZs/wy3WysFNG5pbsHdpsTtD3HHXe/M=;
        b=RaqEVeSHL7bSKtHbVpDAkYPtW4AkANwF5pEg1TwLr+sYPnyuxld3vw7505bhE2z0dv
         dgc7nkEeD3crF9DYhl8qaQYbDWMwlRtI0JQ5dVkpA43OpRGZ5tOnIm1QT66mYcSP/ckt
         rySTicoI8WeTF79O3i4UXpokwpuEe9rZh54PvmwMbHknvQdNr+5+wHHVlKhCbmbMP9FV
         9pI9qUjfwyrdQbfHjHWxxyaTYCAUtnuiM6IlCr6uUwZxS1C8DFlXMoHLXky+00RUW6r7
         irFbn4h8pEOwa5bs1IntCM+6C/8rUC6uI/Bqst2wTH1CsRt+ODTvGccqyZ0I9USTXQR3
         E8PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN11Z6OI762SF64/lOIyOxUcmi8N1a2NNgbPvvqiM7Fd/1C39+99hp4m8RpRcoDIWcqx+8c1M9/L/kmEIvq3JHyGVBdlK0
X-Gm-Message-State: AOJu0YxnQTW3bg7iiH5RXrC9CMsaOwyMvjaRAEJmpmYEx5aXy7R8v2LO
	2hemRFcTRc/nDlN/cUYibPbVRSrkF2lK3g84SF31HiExqL+rgRky
X-Google-Smtp-Source: AGHT+IHU+sw1IDABtxPgwBMX6adCV8Med2BSHd4+5e/nO/nN32rpqnNKo3BWXjJaG29Vg4ZPfeZjRw==
X-Received: by 2002:a0c:e6ec:0:b0:69b:c808:49d7 with SMTP id m12-20020a0ce6ec000000b0069bc80849d7mr7406795qvn.46.1713714329025;
        Sun, 21 Apr 2024 08:45:29 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id n1-20020a0c8c01000000b006a03f4d27b4sm2588331qvb.9.2024.04.21.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 08:45:28 -0700 (PDT)
Date: Sun, 21 Apr 2024 11:45:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <6625349824651_1dff99294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240419214819.671536-3-zijianzhang@bytedance.com>
References: <20240419214819.671536-1-zijianzhang@bytedance.com>
 <20240419214819.671536-3-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v2 2/3] sock: add MSG_ZEROCOPY notification
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
> pattern, the user will keep calling sendmsg with SO_ZC_NOTIFICATION
> msg_control, and the notification will be delivered as soon as possible.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  2 +
>  arch/mips/include/uapi/asm/socket.h   |  2 +
>  arch/parisc/include/uapi/asm/socket.h |  2 +
>  arch/sparc/include/uapi/asm/socket.h  |  2 +
>  include/uapi/asm-generic/socket.h     |  2 +
>  include/uapi/linux/socket.h           | 16 ++++++
>  net/core/sock.c                       | 70 +++++++++++++++++++++++++++
>  7 files changed, 96 insertions(+)
> 
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index e94f621903fe..b24622a9cd47 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -140,6 +140,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>  
> +#define SO_ZC_NOTIFICATION 78
> +

SCM_ for cmsgs

>  /*
>   * Desired design of maximum size and alignment (see RFC2553)
>   */
> @@ -35,4 +37,18 @@ struct __kernel_sockaddr_storage {
>  #define SOCK_TXREHASH_DISABLED	0
>  #define SOCK_TXREHASH_ENABLED	1
>  
> +#define SOCK_ZC_INFO_MAX 256
> +
> +struct zc_info_elem {
> +	__u32 lo;
> +	__u32 hi;
> +	__u8 zerocopy;
> +};
> +
> +struct zc_info_usr {
> +	__u64 usr_addr;
> +	unsigned int length;
> +	struct zc_info_elem info[];
> +};
> +

Don't pass a pointer to user memory, just have msg_control point to an
array of zc_info_elem.

>  #endif /* _UAPI_LINUX_SOCKET_H */
> diff --git a/net/core/sock.c b/net/core/sock.c
> index fe9195186c13..13f06480f2d8 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2809,6 +2809,13 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  		     struct sockcm_cookie *sockc)
>  {
>  	u32 tsflags;
> +	int ret, zc_info_size, i = 0;
> +	unsigned long flags;
> +	struct sk_buff_head *q, local_q;
> +	struct sk_buff *skb, *tmp;
> +	struct sock_exterr_skb *serr;
> +	struct zc_info_usr *zc_info_usr_p, *zc_info_kern_p;
> +	void __user	*usr_addr;

Please wrap the case in parentheses and define variables in that scope
(Since there are so many variables for this case only.)

>  
>  	switch (cmsg->cmsg_type) {
>  	case SO_MARK:
> @@ -2842,6 +2849,69 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:
>  		break;
> +	case SO_ZC_NOTIFICATION:
> +		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
> +			return -EINVAL;
> +

Why allow PF_RDS without the sock flag set?

> +		zc_info_usr_p = (struct zc_info_usr *)CMSG_DATA(cmsg);
> +		if (zc_info_usr_p->length <= 0 || zc_info_usr_p->length > SOCK_ZC_INFO_MAX)
> +			return -EINVAL;
> +
> +		zc_info_size = struct_size(zc_info_usr_p, info, zc_info_usr_p->length);
> +		if (cmsg->cmsg_len != CMSG_LEN(zc_info_size))
> +			return -EINVAL;

By passing a straightforward array, the array len can be inferred from
cmsg_len, simplifying all these checks.

See for instance how SO_DEVMEM_DONTNEED returns an array of tokens to
the kernel.

> +
> +		usr_addr = (void *)(uintptr_t)(zc_info_usr_p->usr_addr);
> +		if (!access_ok(usr_addr, zc_info_size))
> +			return -EFAULT;
> +
> +		zc_info_kern_p = kmalloc(zc_info_size, GFP_KERNEL);
> +		if (!zc_info_kern_p)
> +			return -ENOMEM;
> +
> +		q = &sk->sk_error_queue;
> +		skb_queue_head_init(&local_q);
> +		spin_lock_irqsave(&q->lock, flags);
> +		skb = skb_peek(q);
> +		while (skb && i < zc_info_usr_p->length) {
> +			struct sk_buff *skb_next = skb_peek_next(skb, q);
> +
> +			serr = SKB_EXT_ERR(skb);
> +			if (serr->ee.ee_errno == 0 &&
> +			    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
> +				zc_info_kern_p->info[i].hi = serr->ee.ee_data;
> +				zc_info_kern_p->info[i].lo = serr->ee.ee_info;
> +				zc_info_kern_p->info[i].zerocopy = !(serr->ee.ee_code
> +								& SO_EE_CODE_ZEROCOPY_COPIED);
> +				__skb_unlink(skb, q);
> +				__skb_queue_tail(&local_q, skb);
> +				i++;
> +			}
> +			skb = skb_next;
> +		}
> +		spin_unlock_irqrestore(&q->lock, flags);

In almost all sane cases, all outstanding notifications can be passed
to userspace.

It may be interesting to experiment with briefly taking the lock to
move to a private list. See for instance net_rx_action.

Then if userspace cannot handle all notifications, the rest have to be
spliced back. This can reorder notifications. But rare reordering is
not a correctness issue.

I would choose the more complex splice approach only if it shows
benefit, i.e., if taking the lock does contend with error enqueue
events.

> +
> +		zc_info_kern_p->usr_addr = zc_info_usr_p->usr_addr;
> +		zc_info_kern_p->length = i;
> +
> +		ret = copy_to_user(usr_addr,
> +				   zc_info_kern_p,
> +					struct_size(zc_info_kern_p, info, i));

You'll still need to support the gnarly MSG_CMSG_COMPAT version too.

Wait, is this the reason to pass a usr_addr explicitly? To get around
any compat issues?

Or even the entire issue of having to copy msg_sys->msg_control to
user if !msg_control_is_user.

I suppose this simplifies a lot in terms of development. If making the
user interface uglier.

IMHO the sane interface should be used eventually. There may also be
other uses of passing msg_control data up to userspace from sendmsg.

But this approach works for now for evaluation and discussion.



