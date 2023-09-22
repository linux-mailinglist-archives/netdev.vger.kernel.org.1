Return-Path: <netdev+bounces-35759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4FC7AAFB2
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 12:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id A54CB1F228A1
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 10:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EC171A7;
	Fri, 22 Sep 2023 10:40:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D469CA4C
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:39:58 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C74AC
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:39:56 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bffdf50212so32172031fa.1
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1695379195; x=1695983995; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=bd3Lp+mNhz8XYxLGBCuWdPha+I4ZIt6td6DPuyV79r0=;
        b=A3q62NGJPfqXYvMV9zhjJ7/N3nORSHbaBT7eL+A2Gn1FSIAIMXrdtj+GJb5VWS32Dg
         CmtXTstXDx8SIx5Z+zsAB3usJzJlGm86lRMKe2W5HYoSGgtPf+dZ7br4m32HG8PXR+rc
         kGBrFphCJ24Dma2JkEP0S9+Lc6BiYNvgcs24gxc9enrqgjigOFR6o9ndgRT7zoa6pswO
         xKOkS2fsrflpxA1r3EHufaMRSFrLeXIDEJQ4h2GMxEDIB6ampa5abzZAaLu2mmqVAFCZ
         Pz0qi3jqaP8jEgM8W9kH+MXdNcX6Ihw9gVEknlGr+zS0uufabSuojhJYhPJIB+6PspUr
         rkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695379195; x=1695983995;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd3Lp+mNhz8XYxLGBCuWdPha+I4ZIt6td6DPuyV79r0=;
        b=iFrpTfyGa4Y1qVqilarFokbUH3rRMeUu37404UMiVgS3gi60XqqVQZUncUrCqpWBbk
         Bcmb4CBY33Lr6MNvJJiiSsQL7/AfROUXUycqRi9UA30Ss5cPSlZ7cj/RnC5CavuJyZ4i
         99yXAxrAJ8ms+p+LJ8Pta+A3+DciwP4tiBmlo+1SV919LQw2Y2LSR7Z+Ms/v+QbFchJY
         i4TWcLYu+T2mXPPn21FT0YlHfJKM5C/bbHZ+4QVgpAivCvRz+gkaKyza0EnVX/IyOCwQ
         didvLBch2YF6Iw5HOKli0MpUKdUfIMkKXPX2da6/l7ldvi1VBKa4AlMfNUMXx0ltbfR2
         GRlQ==
X-Gm-Message-State: AOJu0Yx3WEAXLM6138uoNbgtwVDyi3NUEJDixyOeshCHZYo36lA8NwxM
	ezB+/bbCkyS5oWnZnWDCcDUKNMJfUpb9PsbGj+c=
X-Google-Smtp-Source: AGHT+IGc3YC+ytaWH2/Gm8wMswgofRd1VqvQcNJGwGldp04+48Gqb0Aue9oZWdQ+j14DrysmX1AUIw==
X-Received: by 2002:a2e:910f:0:b0:2bc:b70d:9cb5 with SMTP id m15-20020a2e910f000000b002bcb70d9cb5mr7121103ljg.33.1695379194634;
        Fri, 22 Sep 2023 03:39:54 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:63])
        by smtp.gmail.com with ESMTPSA id o24-20020a1709064f9800b0099cce6f7d50sm2528990eju.64.2023.09.22.03.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:39:53 -0700 (PDT)
References: <20230920232706.498747-1-john.fastabend@gmail.com>
 <20230920232706.498747-3-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf 2/3] bpf: sockmap, do not inc copied_seq when PEEK
 flag set
Date: Fri, 22 Sep 2023 12:23:53 +0200
In-reply-to: <20230920232706.498747-3-john.fastabend@gmail.com>
Message-ID: <87a5tesd8n.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 04:27 PM -07, John Fastabend wrote:
> When data is peek'd off the receive queue we shouldn't considered it
> copied from tcp_sock side. When we increment copied_seq this will confuse
> tcp_data_ready() because copied_seq can be arbitrarily increased. From]
> application side it results in poll() operations not waking up when
> expected.
>
> Notice tcp stack without BPF recvmsg programs also does not increment
> copied_seq.
>
> We broke this when we moved copied_seq into recvmsg to only update when
> actual copy was happening. But, it wasn't working correctly either before
> because the tcp_data_ready() tried to use the copied_seq value to see
> if data was read by user yet. See fixes tags.
>
> Fixes: e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq")
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/ipv4/tcp_bpf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 81f0dff69e0b..327268203001 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -222,6 +222,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  				  int *addr_len)
>  {
>  	struct tcp_sock *tcp = tcp_sk(sk);
> +	int peek = flags & MSG_PEEK;
>  	u32 seq = tcp->copied_seq;
>  	struct sk_psock *psock;
>  	int copied = 0;
> @@ -311,7 +312,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  		copied = -EAGAIN;
>  	}
>  out:
> -	WRITE_ONCE(tcp->copied_seq, seq);
> +	if (!peek)
> +		WRITE_ONCE(tcp->copied_seq, seq);
>  	tcp_rcv_space_adjust(sk);
>  	if (copied > 0)
>  		__tcp_cleanup_rbuf(sk, copied);

I was surprised to see that we recalculate TCP buffer space and ACK
frames when peeking at the receive queue. But tcp_recvmsg seems to do
the same.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

