Return-Path: <netdev+bounces-64208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E02831C27
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 16:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78BF1F23E27
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569531E87A;
	Thu, 18 Jan 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb57tIh4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56741E532
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590911; cv=none; b=UnkhRCNiMwsVOCi3tMd5TdNZK8/GxmvKrSDHoqCT2CUaWAFdm48H88n+GPXOT0bm8mRF/uT8BsYNtDMVgi/xP7HwK6Zk1bbWUHdT6iVWwtZDBARZKYwy0Q5ztVKFRGSwJ4KiiyUBQzQxR2fmXVpVw94fXDcr/r8zUGlKVvIuOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590911; c=relaxed/simple;
	bh=XLP2Pfg/u2/OHp/0by+1mqR6I08mq7Utk467tzZy+mg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Message-ID:In-Reply-To:References:Subject:Mime-Version:
	 Content-Type:Content-Transfer-Encoding; b=Uyr+9PJgintIriPSoEGvTLobiZ1zJmqqc7si9HYVuYMX/zA4ZduVFhDoHRj6npLwwWsl3RRdbTyXlIzponMuKRWJuZd1d4w5JNxzm6u2gw4bhQxPuQbFDGP0mwG+PDna8SlT4GNB0pEeua7WNQ2IdYamaxYXnL0egrp4oKhnsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb57tIh4; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68183d4e403so8419036d6.1
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 07:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705590909; x=1706195709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNaw5nUh23ricepH0KQ+kccWNehiDQ/GjxW5k7Zd+q8=;
        b=bb57tIh4yBw9MWTwjYLMgbeuKZZ+xkipkDFP89MUb2eneZzXMCEuwfLLDmEUuH3cBg
         QUA+WPOKgOsZkrRIVprrindOYSvaQ5RIuVgpi4SUPsbWm/pvLzBY9IJROQDpHU/YcnkX
         YGqCGFlLktq3dvMeU6pBTBmkL9Bu1iakLYR5Bd8lcNzFkPlS4Cik1f0SLuATAM50SHge
         1SBovP3/XUEYMo4yLhitxfPTQMaO++nZ0WIy5bVgT5WyJT2YTsO+lh+MnrwfD6oSdlcT
         GxOhrJlvEoLSOK0CoqcJvhSWcUN35LfSPRp5umIQn6MbIMGklp3T/JFjID8M6K0EMR5D
         pnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705590909; x=1706195709;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNaw5nUh23ricepH0KQ+kccWNehiDQ/GjxW5k7Zd+q8=;
        b=mB7J3IBIB7+FekecwvAsl0bbvPdzbfLVFO4XE5fA+L1sbSbKNzC6pSS9uPHQUQVowu
         QOhh0KcDqIWUP11zzltfo3ZYgCDbLECVPyB0YIclwrtWRxnr6rlhdmLEgldZh8Zw2C9z
         Sl7MCSWd1a2kqhnD/L8P9UaoMmmj6oapmCkqjEP7GBE72c9ZB/rfQ/Kx09r8/b4gzNZ/
         4e5Hv7lJSuJv6SmpqXJfy5dKq5PCkoS1lny2+ZixoiTxmUuPOy4wNKdbfkwNKQTdUyWE
         JlLFb6kpVkc861XOoVtUe56ndQlIhqvOzO9uFf5iZ6/IIpYKkZW8ilk1M60c7IRCUkAP
         yPPQ==
X-Gm-Message-State: AOJu0YytBGzMzrFl9cc2Z6ibvL6UXDF2OO6n8V1p530S7eNogUZSvEJj
	1Rn9MnP8HlCOoEJAC+ysYsuao8a9TqpGXlFWi48+gudCLUtEXkZP
X-Google-Smtp-Source: AGHT+IFYd9BYUvnQqfmo0/GS19ujUmy+KeQGXGRRQB29TVFtSFK/s8mmbbjDJi4TsNaF1vmuOT5iZg==
X-Received: by 2002:a0c:dd93:0:b0:681:7b3f:352f with SMTP id v19-20020a0cdd93000000b006817b3f352fmr950541qvk.83.1705590908625;
        Thu, 18 Jan 2024 07:15:08 -0800 (PST)
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id j18-20020a0cf9d2000000b00681785c95e0sm1790491qvo.46.2024.01.18.07.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:15:08 -0800 (PST)
Date: Thu, 18 Jan 2024 10:15:07 -0500
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
Message-ID: <65a9407bd77fc_1caa3f29452@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240118143504.3466830-1-edumazet@google.com>
References: <20240118143504.3466830-1-edumazet@google.com>
Subject: Re: [PATCH net] udp: fix busy polling
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
> Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/skmsg.h |  6 ------
>  include/net/sock.h    |  5 +++++
>  net/core/sock.c       | 10 +++++++++-
>  3 files changed, 14 insertions(+), 7 deletions(-)
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
> diff --git a/include/net/sock.h b/include/net/sock.h
> index a7f815c7cfdfdf1296be2967fd100efdb10cdd63..b1ceba8e179aa5cc4c90e98d353551b3a3e1ab86 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2770,6 +2770,11 @@ static inline bool sk_is_tcp(const struct sock *sk)
>  	return sk->sk_type == SOCK_STREAM && sk->sk_protocol == IPPROTO_TCP;
>  }
>  
> +static inline bool sk_is_udp(const struct sock *sk)
> +{
> +	return sk->sk_type == SOCK_DGRAM && sk->sk_protocol == IPPROTO_UDP;
> +}
> +

Since busy polling code is protocol (family) independent, is it safe
to assume sk->sk_family == PF_INET or PF_INET6 here?

>  static inline bool sk_is_stream_unix(const struct sock *sk)
>  {
>  	return sk->sk_family == AF_UNIX && sk->sk_type == SOCK_STREAM;
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
>  }
>  EXPORT_SYMBOL(sk_busy_loop_end);
> -- 
> 2.43.0.381.gb435a96ce8-goog
> 



