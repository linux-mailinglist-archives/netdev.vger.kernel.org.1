Return-Path: <netdev+bounces-64263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD0E831F37
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C1CB23FE4
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 18:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123D2DF68;
	Thu, 18 Jan 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6CcrDe6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2E2E630
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603390; cv=none; b=twqZzv2aeDxEiVvDv36CfI2dKrwEK+s/Xs3XsM4XMK/zLQca/WLHcDSiXKKfOA9M40tPRqgskcaBnpJAETYkkQjI1LU2VsGg9SLMTOw6ktfvyFqvgmgiCijA1WX3YYNblU5QNo2V/3Ubj3jIVDVzo62FjnXGKPsBbCjkktfa8pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603390; c=relaxed/simple;
	bh=Tij6JE4buTgfD46vED8au68xUgRD7c39f990Nf1wpUY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tL6zs24vX2Qa4u3Ce4YB/9RT3BZDwHN5Lzo5Jjx8Sx5Fq7NoiGFH2Tzkp6+ZtsmWOaOdBPJ+NrrgB7SBkGm80vjE+G28w9UxN74zBQyRObKen1iaPdTaDwAskhRZh5r/oMdbcy63TRKB3cYeU8FemzCltqXNlr55LPTXfOElw6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6CcrDe6; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68183d4e403so84316d6.1
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 10:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705603388; x=1706208188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biCHPMPRzh61Zoqo2TS1LoW3XecgNnatFmIlI8ms43k=;
        b=O6CcrDe6/fW6+gn1yKUdg+ZC7cejdX+GywVOaH7yZI2KuoCxpSCYY13O7XrSnSQ0CB
         U2Qik8HBZAxi6Y8kg3JKHViUAKVRrbXBZffNySJubDYFRtIXvdnuS+9J3HSEUTcy/Y1G
         P9qoXQDvYf1GkHXD76YPGtmzigFLeMW9JygurfyCAFuw3xNZHW8TN+rmgFfibBeEvRwq
         OcwOQbYXI+LjRZJajtsOZnTp9Pg5IvaMpE6wDI9oDEXMKJ3bbLJ/FpyPMDe6Ac3PDTs7
         nnMDpXKbFuIGnrz+OgNDqRrG846vI7KsSM6XY/AmaWd6tQZI3SqedxEwom3EmHewWyA7
         M3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603388; x=1706208188;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=biCHPMPRzh61Zoqo2TS1LoW3XecgNnatFmIlI8ms43k=;
        b=jNMX7jDmseLBygt+ndfoDu+y0EPkJm8/KO9vIjZkx3I52ouQb8deVGa+q+VpAvAst1
         PTI9ZZ/FKvuy2Hr9od5qbSQqH1fEDG8s/pbrnC8P7W1rb8R7YXKTHms04bBiE/lYMOLs
         jhE+Ulwe0qeIwVVWhLg4ilEzPJfxE55ZpjPfcdh/BROpvKvrpvmhBzECV35iEntedZPS
         C6TO7MDybGpRD2m0mWU6Q2/HpUNVq+ERI1s/4Z2IhGRhfs/wXdkvTmiCk2cK9wgk6X6E
         m+TU0TfCCV6knbh1n9R2Bvp/8WlgFp7+kAoOOUS2ikmAr5C/z7kQQHetjUGhLxutLRvb
         X3EQ==
X-Gm-Message-State: AOJu0YwljbOMIQPgkHE4JMBYJFkTcBGjYpdx+pBnfoxnN0kNhKLml/FV
	fN9I0FvO/AijJNo+paY5TJUP+Xum+PXoNtzm782vZ5PchYtAxmgM
X-Google-Smtp-Source: AGHT+IEWKVoOHBl96x8lry1kzLPuov+hIPPL0v5P8yIcDBKywtR73y7c2hQB8BFDtbG4/eGgznXdwg==
X-Received: by 2002:a05:6214:e64:b0:681:7a99:b1bf with SMTP id jz4-20020a0562140e6400b006817a99b1bfmr1147437qvb.130.1705603387855;
        Thu, 18 Jan 2024 10:43:07 -0800 (PST)
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id mu3-20020a056214328300b006819adbc9f1sm197342qvb.43.2024.01.18.10.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:43:07 -0800 (PST)
Date: Thu, 18 Jan 2024 13:43:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <65a9713b2376e_1d399c294ab@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240118182835.4004788-1-edumazet@google.com>
References: <20240118182835.4004788-1-edumazet@google.com>
Subject: Re: [PATCH v2 net] udp: fix busy polling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Generic sk_busy_loop_end() only looks at sk->sk_receive_queue
> for presence of packets.
> 
> Problem is that for UDP sockets after blamed commit, some packets
> could be present in another queue: udp_sk(sk)->reader_queue
> 
> In some cases, a busy poller could spin until timeout expiration,
> even if some packets are available in udp_sk(sk)->reader_queue.
> 
> v2:
>    - add a READ_ONCE(sk->sk_family) in sk_is_inet() to avoid KCSAN splats.
>    - add a sk_is_inet() check in sk_is_udp() (Willem feedback)
>    - add a sk_is_inet() check in sk_is_tcp().
> 
> Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  include/linux/skmsg.h   |  6 ------
>  include/net/inet_sock.h |  5 -----
>  include/net/sock.h      | 18 +++++++++++++++++-
>  net/core/sock.c         | 10 +++++++++-
>  4 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 888a4b217829fd4d6baf52f784ce35e9ad6bd0ed..e65ec3fd27998a5b82fc2c4597c575125e653056 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -505,12 +505,6 @@ static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
>  	return !!psock->saved_data_ready;
>  }
>  
> -static inline bool sk_is_udp(const struct sock *sk)
> -{
> -	return sk->sk_type == SOCK_DGRAM &&
> -	       sk->sk_protocol == IPPROTO_UDP;
> -}
> -
>  #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
>  
>  #define BPF_F_STRPARSER	(1UL << 1)
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index aa86453f6b9ba367f772570a7b783bb098be6236..d94c242eb3ed20b2c5b2e5ceea3953cf96341fb7 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -307,11 +307,6 @@ static inline unsigned long inet_cmsg_flags(const struct inet_sock *inet)
>  #define inet_assign_bit(nr, sk, val)		\
>  	assign_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags, val)
>  
> -static inline bool sk_is_inet(struct sock *sk)
> -{
> -	return sk->sk_family == AF_INET || sk->sk_family == AF_INET6;
> -}
> -
>  /**
>   * sk_to_full_sk - Access to a full socket
>   * @sk: pointer to a socket
> diff --git a/include/net/sock.h b/include/net/sock.h
> index a7f815c7cfdfdf1296be2967fd100efdb10cdd63..54ca8dcbfb4335d657b5cea323aa7d8c4316d49e 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2765,9 +2765,25 @@ static inline void skb_setup_tx_timestamp(struct sk_buff *skb, __u16 tsflags)
>  			   &skb_shinfo(skb)->tskey);
>  }
>  
> +static inline bool sk_is_inet(const struct sock *sk)
> +{
> +	int family = READ_ONCE(sk->sk_family);
> +
> +	return family == AF_INET || family == AF_INET6;
> +}
> +
>  static inline bool sk_is_tcp(const struct sock *sk)
>  {
> -	return sk->sk_type == SOCK_STREAM && sk->sk_protocol == IPPROTO_TCP;
> +	return sk_is_inet(sk) &&
> +	       sk->sk_type == SOCK_STREAM &&
> +	       sk->sk_protocol == IPPROTO_TCP;
> +}
> +
> +static inline bool sk_is_udp(const struct sock *sk)
> +{
> +	return sk_is_inet(sk) &&
> +	       sk->sk_type == SOCK_DGRAM &&
> +	       sk->sk_protocol == IPPROTO_UDP;
>  }
>  
>  static inline bool sk_is_stream_unix(const struct sock *sk)
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 158dbdebce6a3693deb63e557e856d9cdd7500ae..e7e2435ed28681772bf3637b96ddd9334e6a639e 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -107,6 +107,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/poll.h>
>  #include <linux/tcp.h>
> +#include <linux/udp.h>
>  #include <linux/init.h>
>  #include <linux/highmem.h>
>  #include <linux/user_namespace.h>
> @@ -4143,8 +4144,15 @@ subsys_initcall(proto_init);
>  bool sk_busy_loop_end(void *p, unsigned long start_time)
>  {
>  	struct sock *sk = p;
> +	bool packet_ready;
>  
> -	return !skb_queue_empty_lockless(&sk->sk_receive_queue) ||
> +	packet_ready = !skb_queue_empty_lockless(&sk->sk_receive_queue);
> +	if (!packet_ready && sk_is_udp(sk)) {
> +		struct sk_buff_head *reader_queue = &udp_sk(sk)->reader_queue;
> +
> +		packet_ready = !skb_queue_empty_lockless(reader_queue);
> +	}
> +	return packet_ready ||
>  	       sk_busy_loop_timeout(sk, start_time);

Perhaps simpler without a variable?

    if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
            return true;

    if (sk_is_udp(sk) &&
        !skb_queue_empty_lockless(&udp_sk(sk)->reader_queue))
            return true;

    return sk_busy_loop_timeout(sk, start_time);

>  }
>  EXPORT_SYMBOL(sk_busy_loop_end);
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 



