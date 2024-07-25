Return-Path: <netdev+bounces-113098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E1E93CA6B
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415531C21C9D
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 21:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9DE13D8B6;
	Thu, 25 Jul 2024 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyBu6vP5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E511711
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944787; cv=none; b=KX12PifbRlof5qwVMHJRLtl9a2cV0Am5RfnOokBCDoFdRWt1xKcbX5XD9/Hyx7tgFP5sW647qdPK9EJzId45kNcb/OehaBtWisJ71mB885sPbMck9o8jnLN9EI7gHEvFn2UsN0S8BCfheOfEwqDWttHBt5e7J/k2f1hFVnOHINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944787; c=relaxed/simple;
	bh=jVfKEovpet0AUwnYPna3LTmaEH/OjhUn65lGhEFOK80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvLYSMHG1iWKMZMxl2QJ81RrV4mwGxlBSCg/nLP7DiyMxksnfzNphIYtnGU7aHN3JEh36kdbq8xJkoLwRT0fu5EouXPwruR2psG6PFrbTwjpnw0P30hvWkFMKPNo7vyQdQUPE+6G9ouCDYZPhyGioVJO2ZQEjazlBDmfjdKlFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hyBu6vP5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so291117b3a.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721944786; x=1722549586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/zAAKxhanEJCxPVHAgsNfkGdISBbjnwo5/o6s0gX8M=;
        b=hyBu6vP59rTYsuvJSlHnHg79ll8TzFDiC+wu98Bt2ROOazjJFGo3wSiDVSPMHSa/2Z
         j8Vk4m+XQ3+ihNfKARRaIn/8paZ5WC/gjvD+/sIlMUQCLQWykG24MJKn/uzOMjrmpcIR
         w3QXOSPsurqroG5AIt3btoqD/gCexLZEhUYHT8cVM+2/y4iSsn9fSX/Dl6+NBS2/3ln+
         C/IDdbnIPtdesVrk6yVZdd7i8yya6uFnRsT/pi6UB+PD5faO1KtXRehDAwyPPKUGITvp
         0TdU2REBCH7qmVlfaKQktFKv5PdUg7YTxY7pF6tSIjR/ViRzVaQD1z3LdPQblB26YoaW
         FsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721944786; x=1722549586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/zAAKxhanEJCxPVHAgsNfkGdISBbjnwo5/o6s0gX8M=;
        b=OxiuERWTsSPMpSiHbeZufQbe9g1GyOnyHH7tSnoT3XNwJcEs4oDWZyUN049m2Omw1W
         wnvyRA4b5JlEEKGjw4g8wVuv4KMyKAbd3NlxZdRKMxAeeztdVmKJtp8+1o0KlPBfDxBW
         DMkrxVyj3qOOTzVyCF8RTDgOIv/vkfOB/xEX02paj1Np0qf069YsFyhjHuW5qdi3/iJM
         piDCN2zAcW92s0WOPA8dugKqHEMCCP0WjhkZNnaYB8pssrAu1EMDh3WowM3onmu6YU5g
         mqzewtq+YAI89vBC7Us5vVfCT0o6eZ3U7eJCgXZKepyenokcidRrxamAkGXxm+9jpPIx
         kJRA==
X-Gm-Message-State: AOJu0Ywb66PjY8UOAu25Y0s4qzZEYBNxO6hLvOy4E9R++iU6bjpQuEu6
	7MVPu2B5aC4TOKvm2uazZ2IinapN1V8zFBY0Z0+Fqrsz3tJmvACloyx6nUHWdg==
X-Google-Smtp-Source: AGHT+IEWl58tFE4d0yHIyX1tnQECNqYDamGjzkHVL0mBSKgGkOcNuvzzKNPwnuCDuuoJOaH4xrtrpg==
X-Received: by 2002:a05:6a20:a122:b0:1c4:6a86:e40d with SMTP id adf61e73a8af0-1c472b205f3mr5910617637.38.1721944785140;
        Thu, 25 Jul 2024 14:59:45 -0700 (PDT)
Received: from google.com (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fd99sm19088145ad.47.2024.07.25.14.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 14:59:44 -0700 (PDT)
Date: Thu, 25 Jul 2024 21:59:39 +0000
From: Mina Almasry <almasrymina@google.com>
To: zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org, edumazet@google.com,
	willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com
Subject: Re: [PATCH net-next v7 2/3] sock: add MSG_ZEROCOPY notification
 mechanism based on msg_control
Message-ID: <ZqLKy8OqpMi-kPQ3@google.com>
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-3-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708210405.870930-3-zijianzhang@bytedance.com>

On Mon, Jul 08, 2024 at 09:04:04PM +0000, zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
>
> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
> However, zerocopy is not a free lunch. Apart from the management of user
> pages, the combination of poll + recvmsg to receive notifications incurs
> unignorable overhead in the applications. We try to mitigate this overhead
> with a new notification mechanism based on msg_control. Leveraging the
> general framework to copy cmsgs to the user space, we copy zerocopy
> notifications to the user upon returning of sendmsgs.
>
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  2 ++
>  arch/mips/include/uapi/asm/socket.h   |  2 ++
>  arch/parisc/include/uapi/asm/socket.h |  2 ++
>  arch/sparc/include/uapi/asm/socket.h  |  2 ++
>  include/linux/socket.h                |  2 +-
>  include/uapi/asm-generic/socket.h     |  2 ++
>  include/uapi/linux/socket.h           | 13 ++++++++
>  net/core/sock.c                       | 46 +++++++++++++++++++++++++++
>  8 files changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index e94f621903fe..7c32d9dbe47f 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -140,6 +140,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>
> +#define SCM_ZC_NOTIFICATION	78
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> index 60ebaed28a4c..3f7fade998cb 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -151,6 +151,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>
> +#define SCM_ZC_NOTIFICATION	78
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> index be264c2b1a11..77f5bee0fdc9 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -132,6 +132,8 @@
>  #define SO_PASSPIDFD		0x404A
>  #define SO_PEERPIDFD		0x404B
>
> +#define SCM_ZC_NOTIFICATION	0x404C
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> index 682da3714686..eb44fc515b45 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -133,6 +133,8 @@
>  #define SO_PASSPIDFD             0x0055
>  #define SO_PEERPIDFD             0x0056
>
> +#define SCM_ZC_NOTIFICATION      0x0057
> +
>  #if !defined(__KERNEL__)
>
>
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 75461812a7a3..6f1b791e2de8 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -171,7 +171,7 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
>
>  static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
>  {
> -	return 0;
> +	return __cmsg->cmsg_type == SCM_ZC_NOTIFICATION;
>  }
>
>  static inline size_t msg_data_left(struct msghdr *msg)
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 8ce8a39a1e5f..02e9159c7944 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>
> +#define SCM_ZC_NOTIFICATION	78
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
> index d3fcd3b5ec53..ab361f30f3a6 100644
> --- a/include/uapi/linux/socket.h
> +++ b/include/uapi/linux/socket.h
> @@ -2,6 +2,8 @@
>  #ifndef _UAPI_LINUX_SOCKET_H
>  #define _UAPI_LINUX_SOCKET_H
>
> +#include <linux/types.h>
> +
>  /*
>   * Desired design of maximum size and alignment (see RFC2553)
>   */
> @@ -35,4 +37,15 @@ struct __kernel_sockaddr_storage {
>  #define SOCK_TXREHASH_DISABLED	0
>  #define SOCK_TXREHASH_ENABLED	1
>
> +struct zc_info_elem {
> +	__u32 lo;
> +	__u32 hi;
> +	__u8 zerocopy;

Some docs please on what each of these are, if possible. Sorry if the repeated
requests are annoying.

In particular I'm a bit confused why the zerocopy field is there. Looking at
the code, is this always set to 1?

> +};
> +
> +struct zc_info {
> +	__u32 size;
> +	struct zc_info_elem arr[];
> +};
> +
>  #endif /* _UAPI_LINUX_SOCKET_H */
> diff --git a/net/core/sock.c b/net/core/sock.c
> index efb30668dac3..e0b5162233d3 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2863,6 +2863,52 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:
>  		break;
> +	case SCM_ZC_NOTIFICATION: {
> +		struct zc_info *zc_info = CMSG_DATA(cmsg);
> +		struct zc_info_elem *zc_info_arr;
> +		struct sock_exterr_skb *serr;
> +		int cmsg_data_len, i = 0;
> +		struct sk_buff_head *q;
> +		unsigned long flags;
> +		struct sk_buff *skb;
> +		u32 zc_info_size;
> +
> +		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
> +			return -EINVAL;
> +
> +		cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
> +		if (cmsg_data_len < sizeof(struct zc_info))
> +			return -EINVAL;
> +
> +		zc_info_size = zc_info->size;
> +		zc_info_arr = zc_info->arr;

Annoying nit: To be honest zc_info->size isn't much longer to type than
zc_info_size, so I would have not added local variables.

> +		if (cmsg_data_len != sizeof(struct zc_info) +
> +				     zc_info_size * sizeof(struct zc_info_elem))
> +			return -EINVAL;
> +
> +		q = &sk->sk_error_queue;
> +		spin_lock_irqsave(&q->lock, flags);
> +		skb = skb_peek(q);
> +		while (skb && i < zc_info_size) {
> +			struct sk_buff *skb_next = skb_peek_next(skb, q);
> +
> +			serr = SKB_EXT_ERR(skb);
> +			if (serr->ee.ee_errno == 0 &&
> +			    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
> +				zc_info_arr[i].hi = serr->ee.ee_data;
> +				zc_info_arr[i].lo = serr->ee.ee_info;
> +				zc_info_arr[i].zerocopy = !(serr->ee.ee_code
> +							  & SO_EE_CODE_ZEROCOPY_COPIED);
> +				__skb_unlink(skb, q);
> +				consume_skb(skb);
> +				i++;
> +			}
> +			skb = skb_next;
> +		}
> +		spin_unlock_irqrestore(&q->lock, flags);

I wonder if you should drop the spin lock in the middle of this loop somehow,
otherwise you may end up spinning for a very long time while the spinlock held
and irq disabled.

IIRC zc_info_size is user input, right? Maybe you should limit zc_info_size to
16 entries or something. So the user doesn't end up passing 100000 as
   zc_info_size and making the kernel loop for a long time here.

> +		zc_info->size = i;
> +		break;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> --
> 2.20.1
>

