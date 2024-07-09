Return-Path: <netdev+bounces-110175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7847192B35F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF13282178
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A976C153801;
	Tue,  9 Jul 2024 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1oBPwKc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418A146016
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516445; cv=none; b=cHg8H1vZ4mojwVHpQh6X1x3S9Dyq06gtuAXkNzNAarxvJUbQG4/yWC0YikYEOjU9sKCodEmq9XQ9A/V+9rj20C3LbaBgeakDJ6nYj9LjDTvwme32Nxp1cUOFWjsI2pP70AUjPbYcRiPc6gJrhn+cZSqTaiH5cXHR6NFC8MZZ/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516445; c=relaxed/simple;
	bh=tmK1Vhmamn3/t0ATZ/n0FLraHQ6CFF7vg0IiTG7F1wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/Pok5NH/6ynnNOw+f/B21FRWBaMff2H/fhucXdLhbhn5yb/8IFF8OHIkKUuD9xzJVesi8BjFNNPDrki4C23WDc0hi01dsZrbEs86jtpFiV/vgkTj/54jW4XvfyezrmXwBlvN7FUG/vJALKa7b0XSSbHCczpl/COhX5opKrTPTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1oBPwKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AC1C32786;
	Tue,  9 Jul 2024 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720516445;
	bh=tmK1Vhmamn3/t0ATZ/n0FLraHQ6CFF7vg0IiTG7F1wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1oBPwKc1MRMbsJSAsLVpXTVDkYlxH0dHhgUeVPgWFQuPDi5E16+NkpazkV1ll21l
	 EVxxYetaOU3oMG1lYc890l0NFEaCir7JS6D+VMzXPyip31eIEYmbZ3OXFLtIbnA48z
	 5DSDlk/xSPRebB56wD9DUPp2GUpbqcAvCTgknLHYhuBa3uTFnYcXn8WlesTgjrgV5l
	 sdDuwqdJ8dsdKcaK7OozHPYS1wjlo3aR5F3WqpSZVkwsPKi52VJStLU4HgsVR+3nQq
	 kjMeZNWVFAwS7ELTl0XFmuDPlrRzMg+FFUn+KAMKgE9T0Lee/WgTlrtwAJOPcVBcrl
	 aVrOzvViNETew==
Date: Tue, 9 Jul 2024 10:14:00 +0100
From: Simon Horman <horms@kernel.org>
To: zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org, edumazet@google.com,
	willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user
 space in sendmsg
Message-ID: <20240709091400.GE346094@kernel.org>
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

+ Dave Miller, Jakub Kicinski, Paolo Abeni, David Ahern, and Jens Axboe

  Please generate the CC list Networking for patches using
  get_maintainer.pl --git-min-percent=25 this.patch
  but omitting LKML.


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

...

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

nit: Sparse seems unhappy about the use of a __user pointer here.

     net/socket.c:2540:37: warning: dereference of noderef expression

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

nit: The line above could be trivially line-wrapped so that it is
     no more than 80 columns wide, as is still preferred in Networking code.

     Flagged by: checkpatch.pl --max-line-length=80

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

...

