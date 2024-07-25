Return-Path: <netdev+bounces-113093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A952393CA43
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 23:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DB71F231F6
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 21:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4301C6BE;
	Thu, 25 Jul 2024 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qURu7pn2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF613A3E8
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943305; cv=none; b=EWeZ94il5FC1CXRLuszvTtxVxYNcLCwl/hqFMX8e65QqhSB4cjrro5EWaVH7jsfNkdcDQGXof4jcA/o1Hu9PWumMr9ZCt5OEiDfw6awrr6s5qvUzvzd6C9JsUuNJ4z35MypH+H7j0SYDoTqn/JgGugsH4355UzpZ0lMKTH+TUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943305; c=relaxed/simple;
	bh=fX996tynQjZs/DK5PfNlpDTlyLALxXGkzJfemk9uqR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpUHVrYeVjszmJfBHum/OOcB9XLlcunpe8t0i1Z+XZb8JODmLlihH4XqcDMlAoYVxX33FG++bfn0B8VPyNz/abJYqmUIq+HaGmYv9wJzX/7tZw/JEO+c3q6+IHVslO1Ny1IfjlAXzXNLaxIoQm/erI084nfkxSDtRaLuxssj5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qURu7pn2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso273259b3a.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 14:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721943303; x=1722548103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IPMhmN39tmeqnE+K6hmwwZK2U3XPX4OF5ZMMS8nmlI0=;
        b=qURu7pn2dmOVaXXC0zGz9EP5DSnwfFXRs/64p1VOhke/f/iNe6Ntz9j2Y7lJeCR+7u
         8rlhY2lv+gocn/cWBsGIQCo+b7GnmgtuwpTvW+JKLmNaN26uITFcIWQtYrQ2FiD7tYyb
         +c/zj1fIjViMu4OvYR1O7yD6cGZarzmlVrSxYhykY2gqNZcVXWvJXSKTVhmb1BRsNwjp
         DOyvus175jEj5CA9aXigFWdLyP9ZVYC1rMhuq6HMXS+rdvnMlzdkwZZSznHCTYL/OC4Z
         Ta8ak5qe06rIO6FU8IAz7scAQMc/k7ESsw9TRmx35RPtjTl5w0hYG68oyL1u4fHoq33P
         9IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721943303; x=1722548103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPMhmN39tmeqnE+K6hmwwZK2U3XPX4OF5ZMMS8nmlI0=;
        b=UtMDAkJDism1bKF3xSyxmFxgMwlD8MZVmCFKWOA73nnyz8ksaxjTBYyHNykbOb/FuL
         UVZSab/B7aUvl+EdEw4QYX5b579IIwUqoF1gQ77xJOGHjAFeFyEu1wuOMvnGHQTbWTU0
         zzRcHADA4tSv4J91KIA/VfIFku03IhHe4SbSBsAbVuumG4ADwogo4W7ICmjuWYWuw5PE
         Eyn+zI3giOHZim16pnxZfvqKjZMWgHSeOkoWQr4zmuoqIl9fh4ayUEikRWltABR2eV2j
         1plGzmnlL4hSw9g3s7im8Ni2GH708AW/jgImLS3APTehUb+LySacTfPCiCiuVPUane8H
         w2tg==
X-Gm-Message-State: AOJu0YyDpfVP26EoRcXRMvxhjUf9Q6/O9uGb2EC8zEWeaBD2gmeCydy1
	FMtukQC+NZiX87k5H+pohbxtSdurI6Qr2SDTHqIvTi380Lz4iU46zKJJAM5b5EHImklkA0cURlF
	Klw==
X-Google-Smtp-Source: AGHT+IFpfXZRBxWXDV+deBvkXUp/wjVdoueeG4DByUoaCB3jGG8pUttBbP6bMj2POIVu4gJfpAnA3A==
X-Received: by 2002:a05:6a00:94a3:b0:70d:3354:a190 with SMTP id d2e1a72fcca58-70eae9a10fcmr3706195b3a.27.1721943302046;
        Thu, 25 Jul 2024 14:35:02 -0700 (PDT)
Received: from google.com (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead71269csm1556868b3a.56.2024.07.25.14.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 14:35:01 -0700 (PDT)
Date: Thu, 25 Jul 2024 21:34:50 +0000
From: Mina Almasry <almasrymina@google.com>
To: zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org, edumazet@google.com,
	willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com
Subject: Re: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user
 space in sendmsg
Message-ID: <ZqLE-vmo_L1JgUrn@google.com>
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-2-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708210405.870930-2-zijianzhang@bytedance.com>

On Mon, Jul 08, 2024 at 09:04:03PM +0000, zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
>
> Users can pass msg_control as a placeholder to recvmsg, and get some info
> from the kernel upon returning of it, but it's not available for sendmsg.
> Recvmsg uses put_cmsg to copy info back to the user, while ____sys_sendmsg
> creates a kernel copy of msg_control and passes that to the callees,
> put_cmsg in sendmsg path will write into this kernel buffer.
>
> If users want to get info after returning of sendmsg, they typically have
> to call recvmsg on the ERRMSG_QUEUE of the socket, incurring extra system
> call overhead. This commit supports copying cmsg from the kernel space to
> the user space upon returning of sendmsg to mitigate this overhead.
>
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  include/linux/socket.h |  6 +++++
>  include/net/sock.h     |  2 +-
>  net/core/sock.c        |  6 +++--
>  net/ipv4/ip_sockglue.c |  2 +-
>  net/ipv6/datagram.c    |  2 +-
>  net/socket.c           | 54 ++++++++++++++++++++++++++++++++++++++----
>  6 files changed, 62 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 2a1ff91d1914..75461812a7a3 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -71,6 +71,7 @@ struct msghdr {
>  		void __user	*msg_control_user;
>  	};
>  	bool		msg_control_is_user : 1;
> +	bool		msg_control_copy_to_user : 1;

Please add some docs explaining what this does if possible. From reading the
code, it seems if this is true then we should copy cmsg to user. Not sure where
or how it's set though.

>  	bool		msg_get_inq : 1;/* return INQ after receive */
>  	unsigned int	msg_flags;	/* flags on received message */
>  	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
> @@ -168,6 +169,11 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
>  	return __cmsg_nxthdr(__msg->msg_control, __msg->msg_controllen, __cmsg);
>  }
>
> +static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
> +{
> +	return 0;
> +}
> +
>  static inline size_t msg_data_left(struct msghdr *msg)
>  {
>  	return iov_iter_count(&msg->msg_iter);
> diff --git a/include/net/sock.h b/include/net/sock.h
> index cce23ac4d514..9c728287d21d 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1804,7 +1804,7 @@ static inline void sockcm_init(struct sockcm_cookie *sockc,
>  	};
>  }
>
> -int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
> +int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
>  		     struct sockcm_cookie *sockc);
>  int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
>  		   struct sockcm_cookie *sockc);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9abc4fe25953..efb30668dac3 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2826,7 +2826,7 @@ struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
>  }
>  EXPORT_SYMBOL(sock_alloc_send_pskb);
>
> -int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
> +int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
>  		     struct sockcm_cookie *sockc)
>  {
>  	u32 tsflags;
> @@ -2866,6 +2866,8 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  	default:
>  		return -EINVAL;
>  	}
> +	if (cmsg_copy_to_user(cmsg))
> +		msg->msg_control_copy_to_user = true;
>  	return 0;
>  }
>  EXPORT_SYMBOL(__sock_cmsg_send);
> @@ -2881,7 +2883,7 @@ int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
>  			return -EINVAL;
>  		if (cmsg->cmsg_level != SOL_SOCKET)
>  			continue;
> -		ret = __sock_cmsg_send(sk, cmsg, sockc);
> +		ret = __sock_cmsg_send(sk, msg, cmsg, sockc);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index cf377377b52d..6360b8ba9c84 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -267,7 +267,7 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
>  		}
>  #endif
>  		if (cmsg->cmsg_level == SOL_SOCKET) {
> -			err = __sock_cmsg_send(sk, cmsg, &ipc->sockc);
> +			err = __sock_cmsg_send(sk, msg, cmsg, &ipc->sockc);
>  			if (err)
>  				return err;
>  			continue;
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index fff78496803d..c9ae30acf895 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -777,7 +777,7 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>  		}
>
>  		if (cmsg->cmsg_level == SOL_SOCKET) {
> -			err = __sock_cmsg_send(sk, cmsg, &ipc6->sockc);
> +			err = __sock_cmsg_send(sk, msg, cmsg, &ipc6->sockc);
>  			if (err)
>  				return err;
>  			continue;
> diff --git a/net/socket.c b/net/socket.c
> index e416920e9399..6a9c9e24d781 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2525,8 +2525,43 @@ static int copy_msghdr_from_user(struct msghdr *kmsg,
>  	return err < 0 ? err : 0;
>  }
>
> -static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
> -			   unsigned int flags, struct used_address *used_address,
> +static int sendmsg_copy_cmsg_to_user(struct msghdr *msg_sys,
> +				     struct user_msghdr __user *umsg)
> +{
> +	struct compat_msghdr __user *umsg_compat =
> +				(struct compat_msghdr __user *)umsg;
> +	unsigned int flags = msg_sys->msg_flags;
> +	struct msghdr msg_user = *msg_sys;
> +	unsigned long cmsg_ptr;
> +	struct cmsghdr *cmsg;
> +	int err;
> +
> +	msg_user.msg_control_is_user = true;
> +	msg_user.msg_control_user = umsg->msg_control;
> +	cmsg_ptr = (unsigned long)msg_user.msg_control;
> +	for_each_cmsghdr(cmsg, msg_sys) {
> +		if (!CMSG_OK(msg_sys, cmsg))
> +			break;
> +		if (cmsg_copy_to_user(cmsg))
> +			put_cmsg(&msg_user, cmsg->cmsg_level, cmsg->cmsg_type,
> +				 cmsg->cmsg_len - sizeof(*cmsg), CMSG_DATA(cmsg));

put_cmsg() can fail as far as I can tell. Any reason we don't have to check for
failure here?

What happens when these failures happen. Do we end up putting the ZC
notification later, or is the zc notification lost forever because we did not
detect the failure to put_cmsg() it?

> +	}
> +
> +	err = __put_user((msg_sys->msg_flags & ~MSG_CMSG_COMPAT), COMPAT_FLAGS(umsg));
> +	if (err)
> +		return err;
> +	if (MSG_CMSG_COMPAT & flags)
> +		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
> +				 &umsg_compat->msg_controllen);
> +	else
> +		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
> +				 &umsg->msg_controllen);
> +	return err;
> +}
> +
> +static int ____sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
> +			   struct msghdr *msg_sys, unsigned int flags,
> +			   struct used_address *used_address,
>  			   unsigned int allowed_msghdr_flags)
>  {
>  	unsigned char ctl[sizeof(struct cmsghdr) + 20]
> @@ -2537,6 +2572,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
>  	ssize_t err;
>
>  	err = -ENOBUFS;
> +	msg_sys->msg_control_copy_to_user = false;


This may be a lack of knowledge on my part, but i'm very confused that
msg_control_copy_to_user is set to false here, and then checked below, and it's
not touched in between. How could it evaluate to true below? Is it because something
overwrites the value in msg_sys between this set and the check?

If something is overwriting it, is the initialization to false necessary?
I don't see other fields of msg_sys initialized this way.

>
>  	if (msg_sys->msg_controllen > INT_MAX)
>  		goto out;
> @@ -2594,6 +2630,14 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
>  			       used_address->name_len);
>  	}
>
> +	if (msg && msg_sys->msg_control_copy_to_user && err >= 0) {
> +		ssize_t len = err;
> +
> +		err = sendmsg_copy_cmsg_to_user(msg_sys, msg);
> +		if (!err)
> +			err = len;

I'm a bit surprised there isn't any cleanup here if copying the cmsg to user
fails. It seems that that __sock_sendmsg() is executed, then if we fail here,
we just return an error without unrolling what __sock_sendmsg() did. Why is
this ok?

Should sendmsg_copy_cmsg_to_user() be done before __sock_sendms() with a goto
out if it fails?

> +	}
> +
>  out_freectl:
>  	if (ctl_buf != ctl)
>  		sock_kfree_s(sock->sk, ctl_buf, ctl_len);
> @@ -2636,8 +2680,8 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
>  	if (err < 0)
>  		return err;
>
> -	err = ____sys_sendmsg(sock, msg_sys, flags, used_address,
> -				allowed_msghdr_flags);
> +	err = ____sys_sendmsg(sock, msg, msg_sys, flags, used_address,
> +			      allowed_msghdr_flags);
>  	kfree(iov);
>  	return err;
>  }
> @@ -2648,7 +2692,7 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
>  long __sys_sendmsg_sock(struct socket *sock, struct msghdr *msg,
>  			unsigned int flags)
>  {
> -	return ____sys_sendmsg(sock, msg, flags, NULL, 0);
> +	return ____sys_sendmsg(sock, NULL, msg, flags, NULL, 0);
>  }
>
>  long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
> --
> 2.20.1
>

