Return-Path: <netdev+bounces-20515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D593A75FDC2
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CA1281596
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E72F9CE;
	Mon, 24 Jul 2023 17:31:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66712E574
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:31:32 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC0910FA
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:31:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55ac8fcc887so2065630a12.0
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690219889; x=1690824689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSgnGcg3YjnNYSyj1LYEiiwYiJRepbWFY/Wdg7LJs/Y=;
        b=3YEtG9bk1gL1T3vNWpdFUFjYJR41pScWP1ol0U2Wh7ZriVSchZ30bwvX9149kw3j4A
         GIBtYESX3ckLFfBGE48jVA2bOtYANrsjJeIpsQ1wdGtIBbozQeL62HIs7uHtPhQ/DAbP
         5aQP7aTb/VM8jLrElLj3Y+ugWugqaNXgXYcMNBm1WVNMXfkfalpay+JXrPjXqzffW8Ut
         yh3PliqyH0esQCwTfeEKNM3RshnklWWaqcc7BnJeOESHVRDZ9erOFkZx/fbCK6U2BYR0
         FscevRWHqDqDxtW0T/tuTcslEYwsuOyRjT9E8cNmswZp0pi9xb7b7u46OXNZNE6A8Pj1
         WShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690219889; x=1690824689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSgnGcg3YjnNYSyj1LYEiiwYiJRepbWFY/Wdg7LJs/Y=;
        b=Kf//ZFtxD0eNpKFbi9PAjklv1+cqqjTIeWwwoZfTVWqCtPVmuodFzn7CBmbaBdQe5s
         05WsS1wreo4tdT5XO6GuDLlnnMqUN+aBTe+mHostFuZAZQMoTnd0t26u3lv/QsGigMWk
         e2lq+2q8S8aNEd4SLr8+WEEVdWQITDdTNXwAoj/uokJWLmBAeIEn08f6sHQwhyt87wxt
         aFfMAntnWbyZSp8u8qZpK6XLfjZoeqSGCRzaTUHQc2xA/E99q9MmCq/s5mqJoNnK0oWE
         bwnXFmgxhK/TGH62j6oPuFVi3lH8OPIVAWMCbQ7xpwKRPwrDlBYlAr8SdJ0jVLQ9vVwc
         DkHw==
X-Gm-Message-State: ABy/qLZI68grye2k+Z+ZEW0YVP9h2Ku9FbA+CAOn75OIPo9t7uf5smwM
	e9LAQdsVuhn7/iU6urmamZ2TWag=
X-Google-Smtp-Source: APBJJlEbkG2fhsk/zKDhg6WkliIQ+XgGU5IllL/bLs4sJnXLQe9xC3FBfdxqEonT/Uvq7IuAJ174ypI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:751d:0:b0:542:c9ed:b with SMTP id
 q29-20020a63751d000000b00542c9ed000bmr44128pgc.7.1690219889364; Mon, 24 Jul
 2023 10:31:29 -0700 (PDT)
Date: Mon, 24 Jul 2023 10:31:28 -0700
In-Reply-To: <20230724142237.358769-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724142237.358769-1-leitao@debian.org> <20230724142237.358769-3-leitao@debian.org>
Message-ID: <ZL61cIrQuo92Xzbu@google.com>
Subject: Re: [PATCH 2/4] io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
From: Stanislav Fomichev <sdf@google.com>
To: Breno Leitao <leitao@debian.org>
Cc: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	leit@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/24, Breno Leitao wrote:
> Add support for getsockopt command (SOCKET_URING_OP_GETSOCKOPT), where
> level is SOL_SOCKET. This is leveraging the sockptr_t infrastructure,
> where a sockptr_t is either userspace or kernel space, and handled as
> such.
> 
> Function io_uring_cmd_getsockopt() is inspired by __sys_getsockopt().

We probably need to also have bpf bits in the new
io_uring_cmd_getsockopt?

> Differently from the getsockopt(2), the optlen field is not a userspace
> pointers. In getsockopt(2), userspace provides optlen pointer, which is
> overwritten by the kernel.  In this implementation, userspace passes a
> u32, and the new value is returned in cqe->res. I.e., optlen is not a
> pointer.
> 
> Important to say that userspace needs to keep the pointer alive until
> the CQE is completed.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/uapi/linux/io_uring.h |  7 ++++++
>  io_uring/uring_cmd.c          | 43 +++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 9fc7195f25df..8152151080db 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -43,6 +43,10 @@ struct io_uring_sqe {
>  	union {
>  		__u64	addr;	/* pointer to buffer or iovecs */
>  		__u64	splice_off_in;
> +		struct {
> +			__u32	level;
> +			__u32	optname;
> +		};
>  	};
>  	__u32	len;		/* buffer size or number of iovecs */
>  	union {
> @@ -79,6 +83,7 @@ struct io_uring_sqe {
>  	union {
>  		__s32	splice_fd_in;
>  		__u32	file_index;
> +		__u32	optlen;
>  		struct {
>  			__u16	addr_len;
>  			__u16	__pad3[1];
> @@ -89,6 +94,7 @@ struct io_uring_sqe {
>  			__u64	addr3;
>  			__u64	__pad2[1];
>  		};
> +		__u64	optval;
>  		/*
>  		 * If the ring is initialized with IORING_SETUP_SQE128, then
>  		 * this field is used for 80 bytes of arbitrary command data
> @@ -729,6 +735,7 @@ struct io_uring_recvmsg_out {
>  enum {
>  	SOCKET_URING_OP_SIOCINQ		= 0,
>  	SOCKET_URING_OP_SIOCOUTQ,
> +	SOCKET_URING_OP_GETSOCKOPT,
>  };
>  
>  #ifdef __cplusplus
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 8e7a03c1b20e..16c857cbf3b0 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -166,6 +166,47 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
>  }
>  EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
>  
> +static inline int io_uring_cmd_getsockopt(struct socket *sock,
> +					  struct io_uring_cmd *cmd)
> +{
> +	void __user *optval = u64_to_user_ptr(READ_ONCE(cmd->sqe->optval));
> +	int optname = READ_ONCE(cmd->sqe->optname);
> +	int optlen = READ_ONCE(cmd->sqe->optlen);
> +	int level = READ_ONCE(cmd->sqe->level);
> +	void *koptval;
> +	int err;
> +
> +	err = security_socket_getsockopt(sock, level, optname);
> +	if (err)
> +		return err;
> +
> +	koptval = kmalloc(optlen, GFP_KERNEL);
> +	if (!koptval)
> +		return -ENOMEM;
> +
> +	err = copy_from_user(koptval, optval, optlen);
> +	if (err)
> +		goto fail;
> +
> +	err = -EOPNOTSUPP;
> +	if (level == SOL_SOCKET) {
> +		err = sk_getsockopt(sock->sk, level, optname,
> +				    KERNEL_SOCKPTR(koptval),
> +				    KERNEL_SOCKPTR(&optlen));
> +		if (err)
> +			goto fail;
> +	}
> +
> +	err = copy_to_user(optval, koptval, optlen);
> +
> +fail:
> +	kfree(koptval);
> +	if (err)
> +		return err;
> +	else
> +		return optlen;
> +}
> +
>  int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  {
>  	struct socket *sock = cmd->file->private_data;
> @@ -187,6 +228,8 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  		if (ret)
>  			return ret;
>  		return arg;
> +	case SOCKET_URING_OP_GETSOCKOPT:
> +		return io_uring_cmd_getsockopt(sock, cmd);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> -- 
> 2.34.1
> 

