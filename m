Return-Path: <netdev+bounces-110431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981EE92C553
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 23:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA881C20A8A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 21:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591F0143752;
	Tue,  9 Jul 2024 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+WoqUj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157A1B86D4
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560655; cv=none; b=SDfZphy8uc88kwGW5j3hUHqXAsmApPuoe1ifGCdjEpnV1tn5yg/tFAcvZ7ZA3RYuaSo+ebV0fpe++XIlwfV2qi0kaNZwipryJjPBEhnbnjQ/JDfFymtTTF/nNDo5mAyrzbcGW3U2z7HCBU1LlnyeleLR4u0sjeSkIIm2JBoo5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560655; c=relaxed/simple;
	bh=oEUjr53vSUedwxwSDZ/IOIVlVvRqFXa/8Rr6yBzPFic=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pAyNJj/tQx7jlkYtJtywpFv3XYMMGVEOEb4gn4T7lFf8r4ZiW18iU5TMnwkkLmQXf96CEyYpaua1rcCcKeQw84ho2exWU8QZbWk7R3Hvs7Fjz7Apbc4Z0h+k9rebBkt8H9fhbAbDRYMvXxN0N+Dr8HEMXfkGvktCx5VemO+a7Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+WoqUj4; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c66ffadb7aso1543621eaf.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560652; x=1721165452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlAoWv3cOVhLjJbTBLe9MS9tD9qeRmexs2jtfnp7ggw=;
        b=N+WoqUj4Enp1AY/NDHSDpj0eReMsrH7rUKpiGGHqIyoUAhZiX0ebASg46IJzXec0On
         Tbb6ak8TE3t5eyADMjFw1uzOks1tXlZh4+r4poF9QvnPGPPZaVfQt7yDo45pY/VxEg2O
         fMHiOCkf4wWzpMpc49HUlVViWgKr2GkBv5k9GkMZ07SYtjbERUhqJSJGgDOzZ5uCGIkV
         eJvnxOJ4kwtr/OfRUa+JLJDuPjIe8qLF5Dep5SFoEIK3Dlj9ZPWmS+VNZPcRc5El2rR6
         tktiOEvAv0JE08aLUyDIrahgly5Xe076b4mr4zjsnHLbCiY3erTKxh0XVApqBIGbZ9ip
         INfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560652; x=1721165452;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GlAoWv3cOVhLjJbTBLe9MS9tD9qeRmexs2jtfnp7ggw=;
        b=aRRoZqwNPFm5tfnNa294HmxESBil7ik3sMiuJQCPbRa5OiLAN6p2JdUbmyEykOnsaO
         8PrEV5NX0EO6Sxgn9teMLFNn5hZoGjazr1cEO3JuzJGCaWt72qgymqV5DBhMq0cZHI/w
         ApAjglHx16veE0dO8wNNV1e1ozNgxnFzjC5V3cUjf0i6NdkGFMpqYwBijtBtZim3Xbmr
         U18kx63Yn+tA06UmySiIkOBzSBPR2HtBlqXr9hhZrYQcsUaMx3OcVYU8Gyf7BBv/vtMh
         zEeZ+YupN9Hlw5mE5PbAX+zXC9JSj+rmGwwb8os8gGM42Iq7/svVvt8NKZz9PWSjwtSd
         xI2g==
X-Forwarded-Encrypted: i=1; AJvYcCWB18yxkz3+w7M+6HVnMUhi99fwRVcLkwSL0fffiMARvr45YNVnGIwlJbsVmuhh2RZROzo0bIPPdplv6abcS8leJotjQWkE
X-Gm-Message-State: AOJu0Yzkqao2CHPSmrbnDvm0H/LDI67ZSGcQpYTY0+v38P82d6U9iQZx
	gdgraBNQnSqTSDhQOEvCGm8jQPsdFQH5WdxOmvrD4TiICc4hZSAD
X-Google-Smtp-Source: AGHT+IHrsT84dkp877a+tCsXeStjkfBbpwnmgEWrQdL6bTdYu8o+oMzUACmNIOvJuoGgK75FqHp5XQ==
X-Received: by 2002:a4a:ac81:0:b0:5c6:4807:2d1f with SMTP id 006d021491bc7-5c68e493edfmr3894256eaf.8.1720560652499;
        Tue, 09 Jul 2024 14:30:52 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9ec002sm12149706d6.46.2024.07.09.14.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:30:52 -0700 (PDT)
Date: Tue, 09 Jul 2024 17:30:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com
Message-ID: <668dac0bd73ba_1ce27f2945b@willemb.c.googlers.com.notmuch>
In-Reply-To: <7c4354fc-148f-4b34-9dac-2202b59bc6ca@bytedance.com>
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-2-zijianzhang@bytedance.com>
 <668d680cc7cfc_1c18c329414@willemb.c.googlers.com.notmuch>
 <7c4354fc-148f-4b34-9dac-2202b59bc6ca@bytedance.com>
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

Zijian Zhang wrote:
> On 7/9/24 9:40 AM, Willem de Bruijn wrote:
> > zijianzhang@ wrote:
> >> From: Zijian Zhang <zijianzhang@bytedance.com>
> >>
> >> Users can pass msg_control as a placeholder to recvmsg, and get some info
> >> from the kernel upon returning of it, but it's not available for sendmsg.
> >> Recvmsg uses put_cmsg to copy info back to the user, while ____sys_sendmsg
> >> creates a kernel copy of msg_control and passes that to the callees,
> >> put_cmsg in sendmsg path will write into this kernel buffer.
> >>
> >> If users want to get info after returning of sendmsg, they typically have
> >> to call recvmsg on the ERRMSG_QUEUE of the socket, incurring extra system
> > 
> > nit: error queue or MSG_ERRQUEUE
> > 
> >> call overhead. This commit supports copying cmsg from the kernel space to
> >> the user space upon returning of sendmsg to mitigate this overhead.
> >>
> >> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> >> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> > 
> > Overall this approach follows what I had in mind, thanks.
> > 
> > Looking forward to the discussion with a wider audience at netdevconf
> > next week.
> > 
> 
> No problem, see you next week ;)
> 
> >> ---
> >>   include/linux/socket.h |  6 +++++
> >>   include/net/sock.h     |  2 +-
> >>   net/core/sock.c        |  6 +++--
> >>   net/ipv4/ip_sockglue.c |  2 +-
> >>   net/ipv6/datagram.c    |  2 +-
> >>   net/socket.c           | 54 ++++++++++++++++++++++++++++++++++++++----
> >>   6 files changed, 62 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/include/linux/socket.h b/include/linux/socket.h
> >> index 2a1ff91d1914..75461812a7a3 100644
> >> --- a/include/linux/socket.h
> >> +++ b/include/linux/socket.h
> >> @@ -71,6 +71,7 @@ struct msghdr {
> >>   		void __user	*msg_control_user;
> >>   	};
> >>   	bool		msg_control_is_user : 1;
> >> +	bool		msg_control_copy_to_user : 1;
> >>   	bool		msg_get_inq : 1;/* return INQ after receive */
> >>   	unsigned int	msg_flags;	/* flags on received message */
> >>   	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
> >> @@ -168,6 +169,11 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
> >>   	return __cmsg_nxthdr(__msg->msg_control, __msg->msg_controllen, __cmsg);
> >>   }
> >>   
> >> +static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >>   static inline size_t msg_data_left(struct msghdr *msg)
> >>   {
> >>   	return iov_iter_count(&msg->msg_iter);
> >> diff --git a/include/net/sock.h b/include/net/sock.h
> >> index cce23ac4d514..9c728287d21d 100644
> >> --- a/include/net/sock.h
> >> +++ b/include/net/sock.h
> >> @@ -1804,7 +1804,7 @@ static inline void sockcm_init(struct sockcm_cookie *sockc,
> >>   	};
> >>   }
> >>   
> >> -int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
> >> +int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
> >>   		     struct sockcm_cookie *sockc);
> >>   int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
> >>   		   struct sockcm_cookie *sockc);
> >> diff --git a/net/core/sock.c b/net/core/sock.c
> >> index 9abc4fe25953..efb30668dac3 100644
> >> --- a/net/core/sock.c
> >> +++ b/net/core/sock.c
> >> @@ -2826,7 +2826,7 @@ struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
> >>   }
> >>   EXPORT_SYMBOL(sock_alloc_send_pskb);
> >>   
> >> -int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
> >> +int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
> >>   		     struct sockcm_cookie *sockc)
> >>   {
> >>   	u32 tsflags;
> >> @@ -2866,6 +2866,8 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
> >>   	default:
> >>   		return -EINVAL;
> >>   	}
> >> +	if (cmsg_copy_to_user(cmsg))
> >> +		msg->msg_control_copy_to_user = true;
> > 
> > This seems a bit roundabout.
> > 
> > Just have case SCM_ZC_NOTIFICATION set this bit directly?
> 
> If I directly set this bit in SCM_ZC_... and delete this if code block,
> I may have to add "msg" argument to __sock_cmsg_send in the second
> commit, because if I still keep it in this commit, there will be an
> "unused argument" warning.
> 
> However, I think the change to __sock_cmsg_send function declaration is
> generic, so I would like to make it in the first commit, but it is truly
> a bit roundabout. Not sure which way is better?

A temporary __attribute__((unused))
 
> >>   	return 0;
> >>   }
> > 
> >> -static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
> >> -			   unsigned int flags, struct used_address *used_address,
> >> +static int sendmsg_copy_cmsg_to_user(struct msghdr *msg_sys,
> >> +				     struct user_msghdr __user *umsg)
> >> +{
> >> +	struct compat_msghdr __user *umsg_compat =
> >> +				(struct compat_msghdr __user *)umsg;
> >> +	unsigned int flags = msg_sys->msg_flags;
> >> +	struct msghdr msg_user = *msg_sys;
> >> +	unsigned long cmsg_ptr;
> >> +	struct cmsghdr *cmsg;
> >> +	int err;
> >> +
> >> +	msg_user.msg_control_is_user = true;
> >> +	msg_user.msg_control_user = umsg->msg_control;
> >> +	cmsg_ptr = (unsigned long)msg_user.msg_control;
> >> +	for_each_cmsghdr(cmsg, msg_sys) {
> >> +		if (!CMSG_OK(msg_sys, cmsg))
> >> +			break;
> >> +		if (cmsg_copy_to_user(cmsg))
> >> +			put_cmsg(&msg_user, cmsg->cmsg_level, cmsg->cmsg_type,
> >> +				 cmsg->cmsg_len - sizeof(*cmsg), CMSG_DATA(cmsg));
> >> +	}
> >> +
> >> +	err = __put_user((msg_sys->msg_flags & ~MSG_CMSG_COMPAT), COMPAT_FLAGS(umsg));
> >> +	if (err)
> >> +		return err;
> >> +	if (MSG_CMSG_COMPAT & flags)
> >> +		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
> >> +				 &umsg_compat->msg_controllen);
> >> +	else
> >> +		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
> >> +				 &umsg->msg_controllen);
> >> +	return err;
> >> +}
> >> +
> >> +static int ____sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
> >> +			   struct msghdr *msg_sys, unsigned int flags,
> >> +			   struct used_address *used_address,
> >>   			   unsigned int allowed_msghdr_flags)
> >>   {
> >>   	unsigned char ctl[sizeof(struct cmsghdr) + 20]
> >> @@ -2537,6 +2572,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
> >>   	ssize_t err;
> >>   
> >>   	err = -ENOBUFS;
> >> +	msg_sys->msg_control_copy_to_user = false;
> >>   
> >>   	if (msg_sys->msg_controllen > INT_MAX)
> >>   		goto out;
> >> @@ -2594,6 +2630,14 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
> >>   			       used_address->name_len);
> >>   	}
> >>   
> >> +	if (msg && msg_sys->msg_control_copy_to_user && err >= 0) {
> >> +		ssize_t len = err;
> >> +
> >> +		err = sendmsg_copy_cmsg_to_user(msg_sys, msg);
> >> +		if (!err)
> >> +			err = len;
> >> +	}
> >> +
> > 
> > The main issue is adding the above initialization and this branch in
> > the hot path, adding a minor cost to every other send call only for
> > this use case (and potentially tx timestamps eventually).
> > 
> >>   out_freectl:
> >>   	if (ctl_buf != ctl)
> >>   		sock_kfree_s(sock->sk, ctl_buf, ctl_len);
> >> @@ -2636,8 +2680,8 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
> >>   	if (err < 0)
> >>   		return err;
> >>   
> >> -	err = ____sys_sendmsg(sock, msg_sys, flags, used_address,
> >> -				allowed_msghdr_flags);
> >> +	err = ____sys_sendmsg(sock, msg, msg_sys, flags, used_address,
> >> +			      allowed_msghdr_flags);
> > 
> > Does it make more sense to do the copy_to_user here, so as not to have to plumb
> > msg down to the callee?
> 
> I did this in the previous patchset. The problem is that the msg_control
> of msg_sys is either a stack pointer or kmalloc-ed pointer (in
> ____sys_sendmsg), after returning of it, the msg_control of msg_sys is
> either invalid or freed. I may have to do the copy_to_user at the end of
> ____sys_sendmsg.

I see. Ack.


