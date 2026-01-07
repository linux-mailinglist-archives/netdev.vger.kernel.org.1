Return-Path: <netdev+bounces-247730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6DECFDD56
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA4830DC307
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D398319873;
	Wed,  7 Jan 2026 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YS0lg+fh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B1314D13
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790893; cv=none; b=dpE5i2KDAaBTTwLknnw+i3One3tuMnxbpnKl94tudGqTrttQmRTccxyYVegGqJ5F7+eg4Z15UF1AdJDoJ1RAFNF4LtFmlQ7CnBcjXyCGBu8RT18yccbuNXXahrqf5DHo65iS7wcfSDEoR4HsLJJ3R7i0X3UgK98OiJDbRzy2A08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790893; c=relaxed/simple;
	bh=ZFBHKnCoBPdFWOIGkoJWE8ZkaUPWI6yc4PvUJ0tWoVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ODXZv2QDpQRlN/+aNKJehXV3pev+e6h7prIhKtwLF8e61kfM9Jrrm3VNsbDF7vlypcyUZX89YH4BAAbKcl4PelFDViX+Emnvw6Mq6Ynz/vhOlJ+XtvsFxMnBlRRc4/p2aJJ7akcoGkLbmhyZu2mVPrmz539z1yisB6aR9XzqoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YS0lg+fh; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso1621464a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 05:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767790889; x=1768395689; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xir3ca+ukIVh/RHVo7Ct0xUP1DZl1QDE+zdc0E28knM=;
        b=YS0lg+fhzEioA+R8RLxRY1rbXQ6hSQLdrteJEAnmTIu0R23HV2yEDITk58AnTuRfc8
         mMZRMYrKgIIH25vtVbeqvp7dS/epFGw+cfX9TG3LOmnIXSuIpgz16MRuBjYCJN04xI+j
         BuVpJvCmmzY7GyyyiZP59ttTQMJBhI+F+woOAt1DHnMfXBJKOQbIU0HouBJXA7qBgXnx
         AbTZChIiXkOhQUWKjaZja9nkhUcOwqTL0EQqj63+/Qkx31KwgeyEKtOZpgRS1qLD1lh5
         bDy2NTZkWngCLIFhGY1vvVffQXTLoOf3DHvizYVnzt9/EE4vI/9Lke+kCY/WBZ99J4gu
         dNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767790889; x=1768395689;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xir3ca+ukIVh/RHVo7Ct0xUP1DZl1QDE+zdc0E28knM=;
        b=DjwUaLBVyZGHhQ199CwV+MFP4CrRokW12xNRVN0P7PFbanevQo16je29hA3zraptE7
         tLsS3mGM/lpSnxsyfZMNf+jWvKw62kkVc4nxXytkznsY09QIeY6do3XdrEi6GZBLIVy+
         MofY6zDpKTzLQ8dLk+1tLgr7xN+kUV+knNSvE763CIE97IpEAfKgCjmt5kGmEWIJ0CD4
         OzVPP2ZzpNF9tqwY1r8L3vag+4tFwytSjP9c/NexI4NIDKXpoaXxb3hlJa+v1bWlRLg6
         TLUtjeYEiUmN6gJJQgfQws2VO7HbTCelWYeBLiiZ9IowfcT+GkkN7oUgpPA0HW0NddA/
         zHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYVoxyu2Sx4aPHTq+AZ2fiFepO9oIx/rDmH/xgQUxwFRoAl2A93ghfyPrMcfw5h7r2Ebace9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBggKroPUwEbBinNXZUowRtSG8LOURyF5nO8f1MxtWD5pr90RF
	M6s4nPO7KBgIW02gZyTrYNZNp1vE8A3G4a0gdimIisEv7JaJRh3Y5uOvUCOag4trWsM=
X-Gm-Gg: AY/fxX6z6b0+1we/cSIJb9sCe9pwsENRK9/ZNah8WrWX4shhwBnpshfhF+WtNkbzOHC
	iQutEZUtBgVDj0uaSCerZOQZPHTv2nHscVi5LpjbxYFbmQKu23pFUm+Qs+D3iFZYuJniFSqpavc
	OmbMDM0mv1QkJgUbdYOiBjybJsbrNU25gpM4zqfRLgjmT5hZKM1VyuBfrjOMV4VxQ9ZgV1+hkyE
	VlRoPZCoTPFfeNtCv3hqfkvM5mKa/x23Byz9xEA6RZiYi8Rw/OmMSCqjkLLzDFrH1ZWtSxfC02/
	hNkqHdpla8h6KBw42tsXAzxgkXQJYZkWm/ltglknwVGouSSxo1hn9cyeKNhEuYI36eOe7yW5pKz
	IPdEjuZuBWBqWIzlWaG8U3XxcnwpBj1bZf7szsgmMjDwSAGP67a2QWQ8F4NaZ10U+844jrUXD47
	Ak0HvPgMkdFQEjQg==
X-Google-Smtp-Source: AGHT+IEHgppdZ9+MA6XjO99QW33t8OQ8GPnpF0g3kbKM6o5sKERqSqJ/zi1nzB6V76byczxXQVMLPg==
X-Received: by 2002:aa7:d74d:0:b0:649:81d7:581c with SMTP id 4fb4d7f45d1cf-6507bc3d7fbmr4690740a12.1.1767790888994;
        Wed, 07 Jan 2026 05:01:28 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:12])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4429789a12.10.2026.01.07.05.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:01:28 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Stefano Garzarella <sgarzare@redhat.com>,  Michal
 Luczaj <mhal@rbox.co>,  Cong Wang <cong.wang@bytedance.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
In-Reply-To: <20260106051458.279151-2-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Tue, 6 Jan 2026 13:14:27 +0800")
References: <20260106051458.279151-1-jiayuan.chen@linux.dev>
	<20260106051458.279151-2-jiayuan.chen@linux.dev>
Date: Wed, 07 Jan 2026 14:01:27 +0100
Message-ID: <87ms2pinko.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 06, 2026 at 01:14 PM +08, Jiayuan Chen wrote:
> A socket using sockmap has its own independent receive queue: ingress_msg.
> This queue may contain data from its own protocol stack or from other
> sockets.
>
> The issue is that when reading from ingress_msg, we update tp->copied_seq
> by default. However, if the data is not from its own protocol stack,
> tcp->rcv_nxt is not increased. Later, if we convert this socket to a
> native socket, reading from this socket may fail because copied_seq might
> be significantly larger than rcv_nxt.
>
> This fix also addresses the syzkaller-reported bug referenced in the
> Closes tag.
>
> This patch marks the skmsg objects in ingress_msg. When reading, we update
> copied_seq only if the data is from its own protocol stack.
>
>                                                      FD1:read()
>                                                      --  FD1->copied_seq++
>                                                          |  [read data]
>                                                          |
>                                 [enqueue data]           v
>                   [sockmap]     -> ingress to self ->  ingress_msg queue
> FD1 native stack  ------>                                 ^
> -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
>                                        |                  |
>                                        |             ingress to FD1
>                                        v                  ^
>                                       ...                 |  [sockmap]
>                                                      FD2 native stack
>
> Closes: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/linux/skmsg.h |  2 ++
>  net/core/skmsg.c      | 25 ++++++++++++++++++++++---
>  net/ipv4/tcp_bpf.c    |  5 +++--
>  3 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 49847888c287..0323a2b6cf5e 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -141,6 +141,8 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
>  			     struct sk_msg *msg, u32 bytes);
>  int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  		   int len, int flags);
> +int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		     int len, int flags, int *from_self_copied);
>  bool sk_msg_is_readable(struct sock *sk);
>  
>  static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2ac7731e1e0a..d73e03f7713a 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -409,14 +409,14 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
>  }
>  EXPORT_SYMBOL_GPL(sk_msg_memcopy_from_iter);
>  
> -/* Receive sk_msg from psock->ingress_msg to @msg. */
> -int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> -		   int len, int flags)
> +int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		     int len, int flags, int *from_self_copied)
>  {
>  	struct iov_iter *iter = &msg->msg_iter;
>  	int peek = flags & MSG_PEEK;
>  	struct sk_msg *msg_rx;
>  	int i, copied = 0;
> +	bool to_self;

Nit: Can we unify the naming and make it read more naturally?

s/to_self/from_self/
s/from_self_copied/copied_from_self/

Otherwise LGTM:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

