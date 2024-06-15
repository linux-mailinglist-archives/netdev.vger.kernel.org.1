Return-Path: <netdev+bounces-103790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93D9097FB
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FD01F21882
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18603BBF2;
	Sat, 15 Jun 2024 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft/qP8NF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C7125BA
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718451741; cv=none; b=bykhGRrlMbU37HwVk76Twhpo4t6BCrt9lD7qn5AH1LxFzMvZNd2tMi2TsK38WAzD0SUpRwtLoCCv8m/P5UDoWJa4Vs/+RZ1TY72bZ6d+TmBmCZDi8tFN5Id4GoLlWgHVofyW9N2sdnBFeerTJdrl6N2jpqnR57E/KYDaps3AXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718451741; c=relaxed/simple;
	bh=bo1od2d2cQ/V1GI3VDVxtJuvCloT8dB0xwpGixe8CBM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uDa7BcPOpd2EZWaK1Nb3G4U+bxsv6hSfK2qS2f6sAuqBv8F3BJfBuST9OVDJHVdeBe2pk84mJWOF1mCCHsb1Aquw8W5zBcKfO1ipMrYMvbIf3ZgENOu5RZi8nR3JkmqMLLgI9SaUUeDToSNru3um6ljV+9Kte5JqhStf/n91X/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft/qP8NF; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c9d70d93dbso1802908b6e.3
        for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718451739; x=1719056539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lGM5YzzJeuAkTp/attYWDDSwNdcpnU1kRskfp0NH7k=;
        b=Ft/qP8NFy0c8oAW8rZYLa1KjnYfkeKt/MUOfs8xBzzL2ml42V9n4GRL2RWgC3OJJ8R
         2lDfiL0xIiw3Eb9QFCnj4wEH/5tLxfBF7VTbmtUy9NUApxL6pROfKEUbWg4e/A9kMlRJ
         /a2n3MtroXqQ5bG4pSPzw2LNZZesUr65Gz1SolyNNvJPlI2EXSvMN470G7cMhGz8qZ5g
         Wo4sn5X+UCTU3ZAOkGow66YrbIGEXUByLQjnCzRoGhXRmsVZDDPdLKGe6AzzSDLifWi6
         LSthO0gj/0FIU0DsW4WegaAE7RGin2BZUzeKBiToi1rbyAk0PI+JC+fg54z8FMXE+Zru
         y2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718451739; x=1719056539;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6lGM5YzzJeuAkTp/attYWDDSwNdcpnU1kRskfp0NH7k=;
        b=ezDkwEuwzseo4LVVWIrgs9I2H7jwW7r5Wggl+4FqaHfqu5zl9ll2CEjJOzYa+bi57f
         wBM+ePnI8b0YCF0Omq0Tp2mvtiUBnjyzFIHVigpvg0WvGt5uKfrH9MuiDuQCUyo3/vf3
         3wOjOItbLk+qPvGEk+4XADA11dbcfrmN4YhpZuPGmoH030r1AndUcQ/WIFSX65saNnEk
         xlqylkWSiRaooVSGc9Vo8CU9+mxMDu1705g3/qT5vZ1Thp6eIg7XdJoEFox6BbHAhl1H
         GqtobqkByV2Zt6r9ioSwhApkgDx/vgjYGm/1lJnDHr+xIExh45pYEW8ozoXwDYv8edcU
         xmLg==
X-Forwarded-Encrypted: i=1; AJvYcCUmwLE2MjlCif9wVa7JfuY+pGkZ3zXrreA8ZyrI2mKuhx3/mQ68Uike/A2IsVrnpxJTKAECmmsVnLTHNIObuOgYHzo7AoF9
X-Gm-Message-State: AOJu0YxIJfCpsyHBtXFMp1A4AyomL5kuScoS6CMkZuO3fz0WC99txxdC
	z4j528JvRZm8ZzYVAYvQ/ie371culFE1BygxZR7kKmbcJjevGWDQRXbbI6jg
X-Google-Smtp-Source: AGHT+IHsZ8nwwx7m5fEpKuIINWlVF9EvXPHsfrm8N1wy4ejew6YodbzbutFq7W1oiupK6x0LtDOCPA==
X-Received: by 2002:a05:6808:1527:b0:3d2:1b8a:be60 with SMTP id 5614622812f47-3d24e98755bmr5404846b6e.42.1718451739231;
        Sat, 15 Jun 2024 04:42:19 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaedbf6fsm238524085a.48.2024.06.15.04.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 04:42:18 -0700 (PDT)
Date: Sat, 15 Jun 2024 07:42:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <666d7e1a7b72d_1ba35a294a5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240613233133.2463193-3-zijianzhang@bytedance.com>
References: <20240613233133.2463193-1-zijianzhang@bytedance.com>
 <20240613233133.2463193-3-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v5 2/4] sock: support put_cmsg to userspace in TX
 path
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
> Since ____sys_sendmsg creates a kernel copy of msg_control and passes
> that to the callees, put_cmsg will write into this kernel buffer. If
> people want to piggyback some information like timestamps upon returning
> of sendmsg. ____sys_sendmsg will have to copy_to_user to the original buf,
> which is not supported. As a result, users typically have to call recvmsg
> on the ERRMSG_QUEUE of the socket, incurring extra system call overhead.
> 
> This commit supports put_cmsg to userspace in TX path by storing user
> msg_control address in a new field in struct msghdr, and adding a new bit
> flag use_msg_control_user_tx to toggle the behavior of put_cmsg. Thus,
> it's possible to piggyback information in the msg_control of sendmsg.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  include/linux/socket.h |  4 ++++
>  net/compat.c           | 33 +++++++++++++++++++++++++--------
>  net/core/scm.c         | 42 ++++++++++++++++++++++++++++++++----------
>  net/socket.c           |  2 ++
>  4 files changed, 63 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 89d16b90370b..8d3db04f4a39 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -71,9 +71,12 @@ struct msghdr {
>  		void __user	*msg_control_user;
>  	};
>  	bool		msg_control_is_user : 1;
> +	bool		use_msg_control_user_tx : 1;
>  	bool		msg_get_inq : 1;/* return INQ after receive */
>  	unsigned int	msg_flags;	/* flags on received message */
> +	void __user	*msg_control_user_tx;	/* msg_control_user in TX piggyback path */
>  	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
> +	__kernel_size_t msg_controllen_user_tx; /* msg_controllen in TX piggyback path */
>  	struct kiocb	*msg_iocb;	/* ptr to iocb for async requests */
>  	struct ubuf_info *msg_ubuf;
>  	int (*sg_from_iter)(struct sock *sk, struct sk_buff *skb,
> @@ -391,6 +394,7 @@ struct ucred {
>  
>  extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
>  extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);

> diff --git a/net/core/scm.c b/net/core/scm.c
> index 4f6a14babe5a..de70ff1981a1 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -228,25 +228,29 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
>  }
>  EXPORT_SYMBOL(__scm_send);
>  
> -int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
> +static int __put_cmsg(struct msghdr *msg, int level, int type, int len, void *data)
>  {
>  	int cmlen = CMSG_LEN(len);
> +	__kernel_size_t msg_controllen;
>  
> +	msg_controllen = msg->use_msg_control_user_tx ?
> +		msg->msg_controllen_user_tx : msg->msg_controllen;
>  	if (msg->msg_flags & MSG_CMSG_COMPAT)
>  		return put_cmsg_compat(msg, level, type, len, data);
>  
> -	if (!msg->msg_control || msg->msg_controllen < sizeof(struct cmsghdr)) {
> +	if (!msg->msg_control || msg_controllen < sizeof(struct cmsghdr)) {
>  		msg->msg_flags |= MSG_CTRUNC;
>  		return 0; /* XXX: return error? check spec. */
>  	}
> -	if (msg->msg_controllen < cmlen) {
> +	if (msg_controllen < cmlen) {
>  		msg->msg_flags |= MSG_CTRUNC;
> -		cmlen = msg->msg_controllen;
> +		cmlen = msg_controllen;
>  	}
>  
> -	if (msg->msg_control_is_user) {
> -		struct cmsghdr __user *cm = msg->msg_control_user;
> +	if (msg->use_msg_control_user_tx || msg->msg_control_is_user) {
> +		struct cmsghdr __user *cm;
>  
> +		cm = msg->msg_control_is_user ? msg->msg_control_user : msg->msg_control_user_tx;
>  		check_object_size(data, cmlen - sizeof(*cm), true);
>  
>  		if (!user_write_access_begin(cm, cmlen))
> @@ -267,12 +271,17 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
>  		memcpy(CMSG_DATA(cm), data, cmlen - sizeof(*cm));
>  	}
>  
> -	cmlen = min(CMSG_SPACE(len), msg->msg_controllen);
> -	if (msg->msg_control_is_user)
> +	cmlen = min(CMSG_SPACE(len), msg_controllen);
> +	if (msg->msg_control_is_user) {
>  		msg->msg_control_user += cmlen;
> -	else
> +		msg->msg_controllen -= cmlen;
> +	} else if (msg->use_msg_control_user_tx) {
> +		msg->msg_control_user_tx += cmlen;
> +		msg->msg_controllen_user_tx -= cmlen;
> +	} else {
>  		msg->msg_control += cmlen;
> -	msg->msg_controllen -= cmlen;
> +		msg->msg_controllen -= cmlen;
> +	}
>  	return 0;
>  
>  efault_end:
> @@ -280,8 +289,21 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
>  efault:
>  	return -EFAULT;
>  }
> +
> +int put_cmsg(struct msghdr *msg, int level, int type, int len, void *data)
> +{
> +	msg->use_msg_control_user_tx = false;
> +	return __put_cmsg(msg, level, type, len, data);
> +}
>  EXPORT_SYMBOL(put_cmsg);
>  
> +int put_cmsg_user_tx(struct msghdr *msg, int level, int type, int len, void *data)
> +{
> +	msg->use_msg_control_user_tx = true;
> +	return __put_cmsg(msg, level, type, len, data);
> +}
> +EXPORT_SYMBOL(put_cmsg_user_tx);
> +
>  void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_internal *tss_internal)
>  {
>  	struct scm_timestamping64 tss;
> diff --git a/net/socket.c b/net/socket.c
> index e416920e9399..2755bc7bef9c 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2561,6 +2561,8 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
>  		err = -EFAULT;
>  		if (copy_from_user(ctl_buf, msg_sys->msg_control_user, ctl_len))
>  			goto out_freectl;
> +		msg_sys->msg_control_user_tx = msg_sys->msg_control_user;
> +		msg_sys->msg_controllen_user_tx = msg_sys->msg_controllen;

No need for this separate user_tx pointer and put_cmsg_user_tx.

___sys_sendmsg copies the user data to a stack allocated kernel
buffer. All subsequent operations are on this buffer. __put_cmsg
already supports writing to this kernel buffer.

All that is needed is to copy_to_user the buffer on return from
__sock_sendmsg. And only if it should be copied, which the bit in
msghdr can signal.

>  		msg_sys->msg_control = ctl_buf;
>  		msg_sys->msg_control_is_user = false;
>  	}
> -- 
> 2.20.1
> 



