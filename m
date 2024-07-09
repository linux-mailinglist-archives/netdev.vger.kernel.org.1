Return-Path: <netdev+bounces-110372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D329D92C1E0
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6280D291EA7
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF2B19E7FA;
	Tue,  9 Jul 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIFb+oI/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3D19E7EB
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543248; cv=none; b=Pyi38VH6KITd8Ko3RO5KSloB9i3aGe753I95V+q3nxeIIt6YchzlX7NUDOGvI+ZM3Bw0Cmbgo/CmOSj6oLX6uQW74UtP0pFRLmj0HvLcYiZaNhjcRmIAz+5Dsm60TCdpQ2w1rcmtj2Dk+LDEoF9lNkV23y6cj89aOr3ZBzEfzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543248; c=relaxed/simple;
	bh=q6z2TK/gXLO7sdQapNCir1yN2UHMnHPe+05nEiAKIX0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KeFQnXP6oji4Thlo+x/syrSbR/FqLD0JjQ+ANH9mhKJNw4Kstwi2JxYH4WsHM2AD6MWNYFMnpmv6IDd0MJ/o4BOl/nZBO+hpYcvY7EcHeEWTuvMc7YqxuYlswbq42VPgPPnXiJfc3B1BbG8v3DIwwFprlPUeH41pbZJQNmdf2gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIFb+oI/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-447e5feab85so19923501cf.3
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720543245; x=1721148045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtNm1FlVJ24JDITLpLmJjemYt7CS7WqKvmPu3sXCqKY=;
        b=gIFb+oI/HBDOxA9mIwCMYmVamoq8vsQNYI6Rf5yClXBLCYfiDTkOufQhsa2bdvcQaV
         H7Q7F673k+f76XWcJhxquUyNq4ZxKLLSG1ri4CEh7yYrpSGFIRAu/xSQgWya1CcB3ozp
         gUCOY38zlgvB2OiHRdE5x+/c9/hs5ZgmKS85L6x9Tq6pajYLpAq/E/saGJ/ZG/aVWWaH
         29vZ1kON8KEVE+2S59jEaMFNv6uR2p/ZdinOj1dz+gML6E2Rw2uT8n+/AgJ0biqANOql
         Ql8wR13ZOsakwPxg19QGQ+TQhdTH28m6s03e/QBPM6LGMptGU5h/ANaMqV47z5CFRla4
         5V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720543245; x=1721148045;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OtNm1FlVJ24JDITLpLmJjemYt7CS7WqKvmPu3sXCqKY=;
        b=J+wdeP/2INORJqwvXealKkPKOsL4yvA8FxT3u/VTYPrL/ZkR7hAQRlp5zo/14XlaJo
         fGDvQ3eW1xtWERETPHDgHVtNm1XeaRSyJFzmbbHU+Rz0ZaLCoVPK8yYsbcBUQIHWnbjN
         EWQSFGQhp9nXBuGclHeUiTx0/hdhOc9pdQSNFYSwjI4iv4KlqpGeVlHMR7yE179Tkur8
         dWhF+VyYPYb13JY6nuPGj5EOs+YVCgPYYpj8SWT5nEq+OqxMXhFI8oLFv+1CzxnAvCBy
         5RhfqHAd93W4St696TfGdotaX1R8Dh2wbOPEmK8zf86qLYYwGuuDWQ8laJMO6Gwn66vy
         4WTw==
X-Forwarded-Encrypted: i=1; AJvYcCXHA+OoCp4xVdFLHzZx5iB44gE5FHWMAmXqqc47ZstIHKoteWHDnohVQf7cZExyr5BzgD94D5GwcuyHwwPDEauJx58CsWWS
X-Gm-Message-State: AOJu0Yxt7IMkxEzjZf4ccwhjvvpb+OxHD8YtK8x5RNIlgtcCtgLeFJ6/
	NmD1vWXwydHB/aRv6z+mhQO+h0JxPuQe0VdKO3fcgFnFXdJ6ThvEiljZhQ==
X-Google-Smtp-Source: AGHT+IG2vUte75W7cwII16JzaJFCZQardYDHe1VDcCsxrPgckYbqD6abb/6w8rMwII2VhTBl1udLzA==
X-Received: by 2002:a05:622a:1882:b0:447:f0d5:ee4c with SMTP id d75a77b69052e-447fa8eb7abmr29009831cf.19.1720543245547;
        Tue, 09 Jul 2024 09:40:45 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bd2440sm11886641cf.70.2024.07.09.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 09:40:45 -0700 (PDT)
Date: Tue, 09 Jul 2024 12:40:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <668d680cc7cfc_1c18c329414@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240708210405.870930-2-zijianzhang@bytedance.com>
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-2-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user
 space in sendmsg
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
> Users can pass msg_control as a placeholder to recvmsg, and get some info
> from the kernel upon returning of it, but it's not available for sendmsg.
> Recvmsg uses put_cmsg to copy info back to the user, while ____sys_sendmsg
> creates a kernel copy of msg_control and passes that to the callees,
> put_cmsg in sendmsg path will write into this kernel buffer.
> 
> If users want to get info after returning of sendmsg, they typically have
> to call recvmsg on the ERRMSG_QUEUE of the socket, incurring extra system

nit: error queue or MSG_ERRQUEUE

> call overhead. This commit supports copying cmsg from the kernel space to
> the user space upon returning of sendmsg to mitigate this overhead.
>
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>

Overall this approach follows what I had in mind, thanks.

Looking forward to the discussion with a wider audience at netdevconf
next week.

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

This seems a bit roundabout.

Just have case SCM_ZC_NOTIFICATION set this bit directly?

>  	return 0;
>  }

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
> +	}
> +

The main issue is adding the above initialization and this branch in
the hot path, adding a minor cost to every other send call only for
this use case (and potentially tx timestamps eventually).

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

Does it make more sense to do the copy_to_user here, so as not to have to plumb
msg down to the callee?
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



