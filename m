Return-Path: <netdev+bounces-240375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1DC73F2A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C4EB4E61B7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16B3191C9;
	Thu, 20 Nov 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHgr2EF/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tUnV/aKw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F612B143
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763641202; cv=none; b=jwS+Qsjhj78oxob5jzjHl/9Aqopc9wkGqFAlrEdxpS1vRYc8VMY6wYywSG1hnaXNXJy0LQldUaqvF/cP28gD94l65PDjSrsYXI7vx93ztj1ax5ieMy2DbZf/cpkK61dhkdyIXV2gp8x25L8dh3Dp2BOptwzV0o/FINFg1sjwmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763641202; c=relaxed/simple;
	bh=at1e75hOWpRKvRRLbvhWM9/uctq5gzPahra6Oo6jHMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9yv+6hJsIWVuaQaEmbZFkEGkUQi50x6sDWEQeaYeNA15K79rnroxBmvA/s1MfWdDpvpMJ3FU77ViBuENNyU+ofWD8Bi5ynwz6Lwakruvyn2QRRM8F3mSWd7s/wh5XlFqiSp70H1FAGnWUgx+PDd8WGkZnNKriLsrP9KPNnLY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHgr2EF/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tUnV/aKw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763641199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pw7frUWnVBP5/bK04W/QcbdTjEKCzyz1vTHmtbnF5zE=;
	b=fHgr2EF/Cm6noYo/Hg5zUcrhIRMQe0l9R1l7HfZVYICjgm8OGeeFRD54CvwzpoQEPTneu5
	xk/M9E94TRK7vT6SDJg6PUDpUUTpgFaYG3t7Gmnj82Q0QLjgbIES39zdV8yEKPFSqNs9ue
	G/KkWZt86yjzbHudlM/j56REtGCVnxY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-RWIqgT5pOe2b5zFB6N0LJA-1; Thu, 20 Nov 2025 07:19:58 -0500
X-MC-Unique: RWIqgT5pOe2b5zFB6N0LJA-1
X-Mimecast-MFC-AGG-ID: RWIqgT5pOe2b5zFB6N0LJA_1763641197
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b30184be7so403034f8f.2
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763641197; x=1764245997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pw7frUWnVBP5/bK04W/QcbdTjEKCzyz1vTHmtbnF5zE=;
        b=tUnV/aKwNPveV58Vpl1u4WXidLL0tPUXnGzIG9fac8c3t01U4/KSsOBgS2ratf4qGv
         n5FUQc+VOON5CgkFl7wexHNru6RdTKly02m7n8JWcM7HUyGxfnwzKc3bziDtEqsRheEs
         hgCa1WSWPX49Vc+3IzUx9wNcn8gq8s1+0XD4D87S5xZAiYDIsvhNtYOcPNnRj20SaHus
         mqeGGsHiN5CgcSOwpjJ7kMWeW2dAkBCIdZF73wM0L+0aWqapFG25roJIix+yYKrcMzpo
         xGfvkaYG4i461Z4KKnzicBwn9u4UNO4tI2vst/4Kc6kHGBwSzara3F5kzML/8lx9t7TV
         54Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763641197; x=1764245997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pw7frUWnVBP5/bK04W/QcbdTjEKCzyz1vTHmtbnF5zE=;
        b=cav8e03Sysb2LNgn773HCTG9giOyn/sSXIX8bllefNQwqkuXsDGxM7lOoWz/TOOlau
         ooLdTgSv0yJVyFpAqVNBllqIaoDfo2RznenSuDAwVf/Um+FNydzHgcATVP7nhVxdUw9q
         408rvXuteAtgw4LuQU4XJPON0bRbmNFsK8eSeNm67gB5lXS/25sNxmQF/s62QLK1jd9F
         rndD3sniUXNIExr9ydfGlDjurI8TjhPSsvoyV4dvu+TnDLeUzhqXPICsTrnfa9ypx78D
         FDD2pRPxRq4zGIkHYbUzYYYFRn+No+PMZ5b6GMxYZMaAo3nj4hQWDItXJiyJstPH2Yj6
         mjgw==
X-Gm-Message-State: AOJu0YwBAzDHCzF9aiFi+dfRH1yEVHEid3nbNxkK4j4vQmX8yHSyEe/W
	4ed4eTo9aQRQo3ejL/equsQNYHKFSnOaqNh/bA3RZzemWBNYv0A/WJWFBtgK8dSK3uo5eOpE2AV
	u4IUThFqpiZ9LpykthIw11OZrR5X5TXcEJQ+LVuZUQzEkxsvlzesPmqEQQg==
X-Gm-Gg: ASbGnculF+VOkJc80JmM0+2JcD4HUElIUbS5nASB+U7UC2C+SJBFUMtoyYorG8QjUYz
	IlZqNgRfCfNMoNlThwLFXnfJKuF9HmrovCbs8B2RTj9wuHtk+o2NSoYvDmf1LV6mOIjE4HcjJ1n
	LQrHMgfx+klA5Hugsoxpx5k6m3k5vp/GhENVQd/XCfqX7MgK18p/RGgIsiI0aVKKKK+VXPUvup1
	zx9BKgtjtR5iiwtfpYRAf5TmZ2kdUuQtvbblsAkgp4OkcpZMn8oUHsVzeawh+gl1K11WcSMyLab
	yiXL5a7ymuwKEYQ83zDUNtO7IjU0h8SrOy0e/CwmOjykIDxOwQHwbvfeDKqU3sp5i291rzHfOr3
	sn1H0NHSMhWqG
X-Received: by 2002:a5d:64c4:0:b0:42b:3ee9:4772 with SMTP id ffacd0b85a97d-42cbb2b1a79mr2179240f8f.52.1763641197265;
        Thu, 20 Nov 2025 04:19:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDT5eOsby5onmtLuvobHZk2SYkA/y2Wh5xP/wocdvM4KSJix9fhaPkAeUQspjHNj61Efl/0A==
X-Received: by 2002:a5d:64c4:0:b0:42b:3ee9:4772 with SMTP id ffacd0b85a97d-42cbb2b1a79mr2179197f8f.52.1763641196791;
        Thu, 20 Nov 2025 04:19:56 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm5107021f8f.32.2025.11.20.04.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 04:19:56 -0800 (PST)
Message-ID: <a0543467-df01-4486-9bac-d1a3446f44cc@redhat.com>
Date: Thu, 20 Nov 2025 13:19:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/5] net: devmem: implement autorelease token
 management
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
 Bobby Eshleman <bobbyeshleman@meta.com>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
 <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-3-1abc8467354c@meta.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-3-1abc8467354c@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 4:37 AM, Bobby Eshleman wrote:
> @@ -2479,10 +2504,12 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
>  			      unsigned int offset, struct msghdr *msg,
>  			      int remaining_len)
>  {
> +	struct net_devmem_dmabuf_binding *binding = NULL;
>  	struct dmabuf_cmsg dmabuf_cmsg = { 0 };
>  	struct tcp_xa_pool tcp_xa_pool;
>  	unsigned int start;
>  	int i, copy, n;
> +	int refs = 0;
>  	int sent = 0;
>  	int err = 0;
>  
> @@ -2536,6 +2563,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
>  			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
>  			struct net_iov *niov;
>  			u64 frag_offset;
> +			u32 token;
>  			int end;
>  
>  			/* !skb_frags_readable() should indicate that ALL the
> @@ -2568,13 +2596,32 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
>  					      start;
>  				dmabuf_cmsg.frag_offset = frag_offset;
>  				dmabuf_cmsg.frag_size = copy;
> -				err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
> -							 skb_shinfo(skb)->nr_frags - i);
> -				if (err)
> +
> +				binding = net_devmem_iov_binding(niov);
> +
> +				if (!sk->sk_devmem_info.binding)
> +					sk->sk_devmem_info.binding = binding;
> +
> +				if (sk->sk_devmem_info.binding != binding) {
> +					err = -EFAULT;
>  					goto out;
> +				}
> +
> +				if (static_branch_unlikely(&tcp_devmem_ar_key)) {

Not a real/full review but the above is apparently causing kunit build
failures:

ERROR:root:ld: vmlinux.o: in function `tcp_recvmsg_dmabuf':
tcp.c:(.text+0x669b21): undefined reference to `tcp_devmem_ar_key'
ld: tcp.c:(.text+0x669b68): undefined reference to `tcp_devmem_ar_key'
ld: tcp.c:(.text+0x669c54): undefined reference to `tcp_devmem_ar_key'
make[3]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
make[2]: *** [/home/kunit/testing/Makefile:1242: vmlinux] Error 2
make[1]: *** [/home/kunit/testing/Makefile:248: __sub-make] Error 2
make: *** [Makefile:248: __sub-make] Error 2

see:

https://netdev-3.bots.linux.dev/kunit/results/393664/

> @@ -2617,6 +2664,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
>  
>  out:
>  	tcp_xa_pool_commit(sk, &tcp_xa_pool);
> +

[just because I stumbled upon the above while looking for the build
issue]: please do not mix unrelated whitespace-change only with
functional change.

/P


