Return-Path: <netdev+bounces-196974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9CCAD736D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7835B3A293F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E94721CC71;
	Thu, 12 Jun 2025 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZIdZbGxT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D32F4317
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737540; cv=none; b=dIAc0Hq1cIgJJ7JWy6Bw3tuvG14n0/PRXcmUL2qfw2QSizsABCbMTzr83N+kBoETXjT62e2lSyjMOFAmim/blvk+QHL6IFaX1EcV0UH1qxNEY1HcWlIWhRYAI0BKXwN3XWS/n4r/YGeAQbXfrQFiUtX3HYxaWifdl5an/cNE9IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737540; c=relaxed/simple;
	bh=k99wzjTvOf1U2zjNLqiW+o6SFcXv0jJXg3wT8lOY8v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4bApHkdG9N7lPldSlpmVgQK9Dns5MqMt0uZtrUfcpsFumZkNnZD19h+FHDF3wA9xozSYTxK9fuD6FkeE9Bllb0C9bgpWykNrr3o+BJ9m+nKnvumObQsVLtWurWPPhISUq00Gwr5LQwjIjoxTyPh7bmS7C0zyld3i6A+n8ovKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZIdZbGxT; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-873501d2ca1so38701939f.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749737538; x=1750342338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/cfkLw0d9+EIJ8STYopKR//ovMAHjH6I1Jg7cL9sLk=;
        b=ZIdZbGxTsrulyr6uw+yrVg4oIuMsF3QZkV1R+J4GmrfWiFnQOi9n4zs35qDk3LM8lb
         /Yih7lCcvjtXDMdGmxp6LdQVwl3K7EHmXOO+hv4rZtm5/9Sblx65zfjAG6LA0Crte4V7
         uPw58FsdkOdx7mxUqaZOimZtvu9CvMwIJDjoREv9aZU3q+/OtFKc2UnVp39WqMboFZW7
         K5qw3b0GnIoluRMVYDr16iSh/BLpuQuc/apA+wSH8uI2NmHo359rVFCcgVry/ZuV0fae
         tMbhCsA56pHDPX9kV5j9djd9wediY4xv3BVxwVfCLH6gyjeLYhA6HSY21DCSeDr24Qbz
         GMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749737538; x=1750342338;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/cfkLw0d9+EIJ8STYopKR//ovMAHjH6I1Jg7cL9sLk=;
        b=DUYW7Mj8oamN+6kkirZ3+T1V9loMo4pjXNsuvhkeTQLgZC1ihSVFjz46Z+Pctka2TN
         0Am4DVHvg+BXvrawVIFrlwPdRLnxXx7WbGl/CzCwp5nEUk+aizzu5aiBYN7xQbWIgJsP
         fyuDek+PDYiaNw1QrwVeNxLKNMOJajsw7TPcesiCFobjwkttGDOq4JjqUdxwxy6GuHY5
         Eex+GWwAyknTwV8fWBy4AA4yVQyOzmHK3jqZBI93Yac4kgtAODLMrsn2KGOhA8O/uJyy
         tdapEItN/oBsoZgzW3YI2m2BSVnYJ3FZCL9yuPickK52NWjJxUBStFW+HOTENm/Gb9OW
         3bww==
X-Gm-Message-State: AOJu0Yx9cGV89n0KztpMEQOK+tBVm577bB4L76NWGEw+FH1ct20gf1lJ
	TfafbvjJ1EVXWX0ujvc9XQN8eH4TSbn/QTloe92+FDJo3/7vAhdIOYniZzZlMbMzKJY=
X-Gm-Gg: ASbGnctv3ZjGfzmppOzgE3h+/7tZcIsLuF4OdnqTrc2HNUpsKll0GbUeFvqPEPQY0qw
	v/r4aXYO6BT+fmPnSQNnk4lQ6tVBHJeVQakpvJ6nGh1VLSD5YIbJw6EqeoAnB62a0X89JK74yZH
	a95fLdwyXXWbq2HgxPPa4rkUJbJaHOKtKd7JmAaI465YyngulYKZGA5GHyi72gdPk8i6Tt5IZf0
	/wRU8Gin3Dyk3p7uC3wCLjJG+BnzGfpMgHGWsKZKchvRDjFtKFlBvM/bpp9H/e4qMsy/eK3M65d
	USHXnTe+ojGrnrcIfIuTqCLnbbf9yYzVvCIIW5PJLyUTqilIgdQXSOSXNnk=
X-Google-Smtp-Source: AGHT+IGdUHa79HsCkHsowI3Wp6lXuo1RbogPsjoxKOPYbSIjiIiaA+n6psfcYhhUtobBCIIV1nFifw==
X-Received: by 2002:a05:6602:4c02:b0:867:237f:381e with SMTP id ca18e2360f4ac-875c7ca9754mr318124239f.2.1749737537708;
        Thu, 12 Jun 2025 07:12:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5013b89f623sm300172173.88.2025.06.12.07.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 07:12:17 -0700 (PDT)
Message-ID: <2106a3b7-8536-47af-8c55-b95d30cc8739@kernel.dk>
Date: Thu, 12 Jun 2025 08:12:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] io_uring/netcmd: add tx timestamping cmd support
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jason Xing <kerneljasonxing@gmail.com>
References: <cover.1749657325.git.asml.silence@gmail.com>
 <1e9c0e393d6d207ba438da3ad5bf7e4125b28cb7.1749657325.git.asml.silence@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <1e9c0e393d6d207ba438da3ad5bf7e4125b28cb7.1749657325.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 3:09 AM, Pavel Begunkov wrote:
> Add a new socket command which returns tx time stamps to the user. It
> provide an alternative to the existing error queue recvmsg interface.
> The command works in a polled multishot mode, which means io_uring will
> poll the socket and keep posting timestamps until the request is
> cancelled or fails in any other way (e.g. with no space in the CQ). It
> reuses the net infra and grabs timestamps from the socket's error queue.
> 
> The command requires IORING_SETUP_CQE32. All non-final CQEs (marked with
> IORING_CQE_F_MORE) have cqe->res set to the tskey, and the upper 16 bits
> of cqe->flags keep tstype (i.e. offset by IORING_CQE_BUFFER_SHIFT). The
> timevalue is store in the upper part of the extended CQE. The final
> completion won't have IORING_CQR_F_MORE and will have cqe->res storing
                        ^^^^^^^^^^^^^^^^^

Pointed this out before, but this typo is still there.

> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index cfd17e382082..5c89e6f6d624 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -968,6 +968,15 @@ enum io_uring_socket_op {
>  	SOCKET_URING_OP_SIOCOUTQ,
>  	SOCKET_URING_OP_GETSOCKOPT,
>  	SOCKET_URING_OP_SETSOCKOPT,
> +	SOCKET_URING_OP_TX_TIMESTAMP,
> +};
> +
> +#define IORING_CQE_F_TIMESTAMP_HW	((__u32)1 << IORING_CQE_BUFFER_SHIFT)
> +#define IORING_TIMESTAMP_TSTYPE_SHIFT	(IORING_CQE_BUFFER_SHIFT + 1)

Don't completely follow this, would at the very least need a comment.
Whether it's a HW or SW timestamp is flagged in the upper 16 bits, just
like a provided buffer ID. But since we don't use buffer IDs here, then
it's up for grabs. Do we have other commands that use the upper flags
space for command private flags?

The above makes sense, but then what is IORING_TIMESTAMP_TSTYPE_SHIFT?

> diff --git a/io_uring/cmd_net.c b/io_uring/cmd_net.c
> index e99170c7d41a..bc2d33ea2db3 100644
> --- a/io_uring/cmd_net.c
> +++ b/io_uring/cmd_net.c
> @@ -1,5 +1,6 @@
>  #include <asm/ioctls.h>
>  #include <linux/io_uring/net.h>
> +#include <linux/errqueue.h>
>  #include <net/sock.h>
>  
>  #include "uring_cmd.h"
> @@ -51,6 +52,85 @@ static inline int io_uring_cmd_setsockopt(struct socket *sock,
>  				  optlen);
>  }
>  
> +static bool io_process_timestamp_skb(struct io_uring_cmd *cmd, struct sock *sk,
> +				     struct sk_buff *skb, unsigned issue_flags)
> +{
> +	struct sock_exterr_skb *serr = SKB_EXT_ERR(skb);
> +	struct io_uring_cqe cqe[2];
> +	struct io_timespec *iots;
> +	struct timespec64 ts;
> +	u32 tstype, tskey;
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(struct io_uring_cqe) != sizeof(struct io_timespec));
> +
> +	ret = skb_get_tx_timestamp(skb, sk, &ts);
> +	if (ret < 0)
> +		return false;
> +
> +	tskey = serr->ee.ee_data;
> +	tstype = serr->ee.ee_info;
> +
> +	cqe->user_data = 0;
> +	cqe->res = tskey;
> +	cqe->flags = IORING_CQE_F_MORE;
> +	cqe->flags |= tstype << IORING_TIMESTAMP_TSTYPE_SHIFT;
> +	if (ret == NET_TIMESTAMP_ORIGIN_HW)
> +		cqe->flags |= IORING_CQE_F_TIMESTAMP_HW;
> +
> +	iots = (struct io_timespec *)&cqe[1];
> +	iots->tv_sec = ts.tv_sec;
> +	iots->tv_nsec = ts.tv_nsec;
> +	return io_uring_cmd_post_mshot_cqe32(cmd, issue_flags, cqe);
> +}

Might help if you just commented here too on the use of the
TSTYPE_SHIFT.

-- 
Jens Axboe

