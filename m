Return-Path: <netdev+bounces-107948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E2791D225
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 16:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CF71C20B14
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08B1152170;
	Sun, 30 Jun 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBzWvr8D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FED135A65
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719758597; cv=none; b=UWFh5WP7gYu6a4S6XxuWXkn5KucSQ9GqLqJ4Li7aeobxenYcCciOPTnv2KByPV1a5GaVHcIPlxklOBd4By+6I0Vdf8YkugA79yDRxY53x43XxLaCpuJOGDhFeW/VMF17LJOQ8jLEyBDMksQLZV51pVSpLQcHeEgwJNEutlVgcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719758597; c=relaxed/simple;
	bh=4WssDlD/h6WJ1O/skm0tbkDV2aso4Vlg9k112rDVOBc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gPcjulw36+d8eRW4e1O9704sDGt4xL/hrmMjz/kUNyyXvGnJRrTZw9KPzwNTtcFPm6TGAT+HPwoxfs/GpPmNfzL7UvFC7Kdilu7zp4Rct0nS9brkQFZiRLHOLjpC+qoPvTVokJJer7MdveRsQsDlaW2Y8x5OdFD2d+gx9HiL/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBzWvr8D; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6a3652a732fso10029286d6.3
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719758595; x=1720363395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=go4c5RFvdBBd5EFt0eQNyxcZENHRyzhMTG8ic/IDoEs=;
        b=MBzWvr8DlWl057uzn29aQ3AdrfcokA/vO+i+NXMwWsML8wzlnv4+JLVjhBR3jObFy2
         KW/CoZ3S11h3oIko9Eo7lmYR8idRRpeFkigFOEXwpO3zdk8UCf50UlqEtrhkzl8kcGcp
         YN+bbBURipDdJqAwcWkUOVEwu4QhQcuA3Ezz8sZyl2XLL7bw6/1Q3AbntFdtsfDM5wz9
         1IcoigitQA4v3jZ9i0n/uVt+vNUv3AOaNQ/Ds6FhNfvSLje+xWBymErCIIK+x98CFLja
         gO12SyzcZr1NuJew8aXg6JgdTaufIkrRP7nwQB+h3dUFa6hKDnOmc4qRfEWgUx2eLPLm
         kWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719758595; x=1720363395;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=go4c5RFvdBBd5EFt0eQNyxcZENHRyzhMTG8ic/IDoEs=;
        b=JONu7RvjsmHnGFCRBQZLApKZrawg31gEzq0cbwv0J1FdQ4N3Z/oFladj/QYiL1TCFu
         YE+6hT6D5V0UZWOLE67XZTeTZlVA1p2bpcpgiX2OYIlbUyUb8f15aWA6u8JCtJnAwGTO
         bHoSV5/1UZ/Sc6n73znTZAdGyX4bAARuOg6Qw3DQF2psYtS8WhWUbWF8vSGTlCJTXWxW
         eFbz9cUplx3rfP/FnEZQxNhS6XWrTLCd+eVLOeA4wM+vjmNjnu1LYVZPeh88Axin/A19
         q3zZ1gvg7TQmULyxlyqkCLFB8MzxK/wuNApvuNwlc84Q2k8X21c3zjLZ0qSbjggFMnDb
         sneQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwZsuoxegHvQZON6X7HLBTlhmHf006Zkf6u9nN3Cw76G65u2qtiO0qI/eWfvhVm4xyO8qQxq7shVLFYwyQRaDfbcATLwZA
X-Gm-Message-State: AOJu0Yz5vY1tlE4MPge4tyyt9CopCTsQr80V/nnjcLEYVzHglh6hNGDD
	jrUcPdXqWoyYfADKubO1SARMhsMZzly/BdBL6bAIIOJY6X2n2Va4
X-Google-Smtp-Source: AGHT+IE0pj82DZUqfRfc4d2vqWydgmrSmISZ5ICVvcHcHyNrVbKpCSeBfaJZ9o9RpjopSe9qvECbug==
X-Received: by 2002:a05:6214:1c07:b0:6b0:7f0c:d30e with SMTP id 6a1803df08f44-6b5b705726bmr43040406d6.10.1719758594781;
        Sun, 30 Jun 2024 07:43:14 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f26b6sm24886486d6.95.2024.06.30.07.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 07:43:14 -0700 (PDT)
Date: Sun, 30 Jun 2024 10:43:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <66816f021ccc4_e25729443@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240626193403.3854451-3-zijianzhang@bytedance.com>
References: <20240626193403.3854451-1-zijianzhang@bytedance.com>
 <20240626193403.3854451-3-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v6 2/4] sock: support copy cmsg to userspace in
 TX path
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
> This commit supports copying cmsg to userspace in TX path by introducing
> a flag MSG_CMSG_COPY_TO_USER in struct msghdr to guide the copy logic
> upon returning of ___sys_sendmsg.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  include/linux/socket.h |  6 ++++++
>  net/core/sock.c        |  2 ++
>  net/ipv4/ip_sockglue.c |  2 ++
>  net/ipv6/datagram.c    |  3 +++
>  net/socket.c           | 45 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 58 insertions(+)
> 
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 89d16b90370b..35adc30c9db6 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -168,6 +168,11 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
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
> @@ -329,6 +334,7 @@ struct ucred {
>  
>  #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
>  #define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
> +#define MSG_CMSG_COPY_TO_USER	0x10000000	/* Copy cmsg to user space */

Careful that userspace must not be able to set this bit. See also
MSG_INTERNAL_SENDMSG_FLAGS.

Perhaps better to define a bit like msg_control_is_user.

>  #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
>  #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
>  					   descriptor received through
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9abc4fe25953..4a766a91ff5c 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2879,6 +2879,8 @@ int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
>  	for_each_cmsghdr(cmsg, msg) {
>  		if (!CMSG_OK(msg, cmsg))
>  			return -EINVAL;
> +		if (cmsg_copy_to_user(cmsg))
> +			msg->msg_flags |= MSG_CMSG_COPY_TO_USER;

Probably better to pass msg to __sock_cmsg_send and only set this
field in the specific cmsg handler that uses it.

>  		if (cmsg->cmsg_level != SOL_SOCKET)
>  			continue;
>  		ret = __sock_cmsg_send(sk, cmsg, sockc);
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index cf377377b52d..464d08b27fa8 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -249,6 +249,8 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
>  	for_each_cmsghdr(cmsg, msg) {
>  		if (!CMSG_OK(msg, cmsg))
>  			return -EINVAL;
> +		if (cmsg_copy_to_user(cmsg))
> +			msg->msg_flags |= MSG_CMSG_COPY_TO_USER;
>  #if IS_ENABLED(CONFIG_IPV6)
>  		if (allow_ipv6 &&
>  		    cmsg->cmsg_level == SOL_IPV6 &&
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index fff78496803d..b0341faf7f83 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -776,6 +776,9 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>  			goto exit_f;
>  		}
>  
> +		if (cmsg_copy_to_user(cmsg))
> +			msg->msg_flags |= MSG_CMSG_COPY_TO_USER;
> +
>  		if (cmsg->cmsg_level == SOL_SOCKET) {
>  			err = __sock_cmsg_send(sk, cmsg, &ipc6->sockc);
>  			if (err)
> diff --git a/net/socket.c b/net/socket.c
> index e416920e9399..6523cf5a7f32 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2621,6 +2621,39 @@ static int sendmsg_copy_msghdr(struct msghdr *msg,
>  	return 0;
>  }
>  
> +static int sendmsg_copy_cmsg_to_user(struct msghdr *msg_sys,
> +				     struct user_msghdr __user *umsg)
> +{
> +	struct compat_msghdr __user *umsg_compat =
> +				(struct compat_msghdr __user *)umsg;
> +	unsigned long cmsg_ptr = (unsigned long)umsg->msg_control;
> +	unsigned int flags = msg_sys->msg_flags;
> +	struct msghdr msg_user = *msg_sys;
> +	struct cmsghdr *cmsg;
> +	int err;
> +
> +	msg_user.msg_control = umsg->msg_control;
> +	msg_user.msg_control_is_user = true;
> +	for_each_cmsghdr(cmsg, msg_sys) {
> +		if (!CMSG_OK(msg_sys, cmsg))
> +			break;
> +		if (cmsg_copy_to_user(cmsg))
> +			put_cmsg(&msg_user, cmsg->cmsg_level, cmsg->cmsg_type,
> +				 cmsg->cmsg_len - sizeof(*cmsg), CMSG_DATA(cmsg));
> +	}

Alternatively just copy the entire msg_control if any cmsg wants to
be copied back. The others will be unmodified. No need to iterate
then.

> +
> +	err = __put_user((msg_sys->msg_flags & ~MSG_CMSG_COMPAT), COMPAT_FLAGS(umsg));
> +	if (err)
> +		return err;

Does this value need to be written?

> +	if (MSG_CMSG_COMPAT & flags)
> +		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
> +				 &umsg_compat->msg_controllen);
> +	else
> +		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
> +				 &umsg->msg_controllen);
> +	return err;
> +}
> +
>  static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
>  			 struct msghdr *msg_sys, unsigned int flags,
>  			 struct used_address *used_address,
> @@ -2638,6 +2671,18 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
>  
>  	err = ____sys_sendmsg(sock, msg_sys, flags, used_address,
>  				allowed_msghdr_flags);
> +	if (err < 0)
> +		goto out;
> +
> +	if (msg_sys->msg_flags & MSG_CMSG_COPY_TO_USER) {
> +		ssize_t len = err;
> +
> +		err = sendmsg_copy_cmsg_to_user(msg_sys, msg);
> +		if (err)
> +			goto out;
> +		err = len;
> +	}
> +out:
>  	kfree(iov);
>  	return err;
>  }
> -- 
> 2.20.1
> 



