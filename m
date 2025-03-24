Return-Path: <netdev+bounces-177101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627DAA6DDAD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E595C171AD2
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2905261364;
	Mon, 24 Mar 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGr5x1R1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D025D916
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828393; cv=none; b=FXsEDQwxWlpG85GlPg8S1e61sdAELn+AXWe+GPM5BjdqDbMnwnmMPIw+sBoZPWTheaQsgb8umtgNOkU7ddpN6iKRaaw1Yk4pT1gh0tHpzOP82UV9ppMBB3Uc8NahAQdOLmGoKjyOAMzVtDg9pE0JSSHA3F1wnGaR2eogJ8LUvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828393; c=relaxed/simple;
	bh=+OlXnEkFs9bPKuvWlYHUF11x8BX+W/o03qOmV8HOIiw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fcrYlpn+lvt2R5aUBKzL/HIa6/8WpYJyvIFS7N70ozTDZGvdRwv4CRNpHNbPKS4CZUGvByrE8VBZqBefGfKXqgPrIGgmYfvq5tkr6qB0h50WDyzxb/coRuZiNmUj9xeOcm+voQf39iyYAfsxNdBDSjO1ML+lfhG3B0ncv5e6h3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGr5x1R1; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6df83fd01cbso20411086d6.2
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742828391; x=1743433191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g0RDdxcyMsOSeNmZH/DuNwL4lbiAB9DosVoQUk8rNo=;
        b=kGr5x1R1q9HA1Y7l93sI37sj0hctvm9Gk7FJ5i0kzzbxoXKc9Dal+/QzT7IltUIQoc
         ylmw4HZ2EJTHgNlAiHwwXgKMRp1OgqHDBXZO6oJ+SbJuudrGE0kh9BE7hvHtHh5LWPXj
         WXOs2FxR7BmAcwxRLq6lK72j02TEXqAdAHwKAyaU7KvG/njlINU94GiARbzUEuZ2gbc4
         6bFPhhLMvQ1a1KEY3PTPIPLRybPAxQBwlxiDGoC2dlMnSqQ/3n6Cn+XjbC8PpN2qk/Ju
         7weUEeZ8g7QK+0Stz0FyDbQg9f6zK1vvxaUf6dUXOiwWbZpZru0G6F6Li73QuukyvzCJ
         vReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828391; x=1743433191;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8g0RDdxcyMsOSeNmZH/DuNwL4lbiAB9DosVoQUk8rNo=;
        b=tjILgd5XgdIOKPfEFVdvslmSXJwPQNbhGQoOb05ET5vPxu3YOLHDiLmBt2R4fpHljg
         FcKitOkDJY9X0fNutwmfsQKdyLQF5bhu9ARB8KfH/epdwtUfM8er4MAt4wOPwL8tGUCh
         MiWU+DV7w1+gG56RIv4EI2wsIZw5fxdAX/p18XSFpzl7v/idgDu7dQ9kMdjPwrA7UQmG
         pfRU6DeJXdGoPGmaTRbDCutps3uFYBiSz74QfARnoEZ4eF32RMrmF0LOaI0XLWkplxMr
         LXT+PNo8Kqev1zO1sENkC8M35Hjfwk1dKHBMnlHhfsic0ttO56yTrZRKbRapQ/y2xYTQ
         30Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU8frKycNATZdvNoi9GrLwKWXoUDrOpPry+Q0qt07K42wXRT69V7PHAW9NAJ5261iK/YXtYAt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqabTv7qww6DcFkHQjEKsS/2Ya1SUP4R9XjPBp1S1oRXRr7EN
	tHwxM4Ak4hkyzMVtOIMuUU5QnSZbsFT8LgRtyZB8jPnYl9RxEFw3
X-Gm-Gg: ASbGnct2zBlX9b+HCn2PTk67C+CGx+br9xCFseJ+3Fy/Da4eCX7yeYIyrn0HmIaGDXI
	ApMENF6jxhD2UGL3phMFwxvLHEusw4LByGS7adABpfo+Vw5o5LJSKYhrLpctDbPxH7SrOnFvsNi
	ndRmxlD7FGZG8k4PrVOLPWBlUakIAaG25//qiYJ3WbDiA4FvPPxAMzd1PDeHdPbz3UFzZI7BBSg
	EiIBg68h0WjxNfJS9Kj7MD/Al0A4fY9GeHMmoYaDhQq0D/Cp5/nsCTp+kXmLR7JUHxGKKohsfNZ
	AMjB0Wk7xRA5B5vihv97EJoPdEaQU88ZTgEsrHuvwkaRG3ittj7DqCGOlULhsenpicL7/IMJswW
	BFlUiyH2s3pmjEGEYkEMzvw==
X-Google-Smtp-Source: AGHT+IHU+LZmmrPyrrGjlSiyS6WtiUN/u6kRFV1pDWFYgNai2y15Be5WFHjjv7MCAoy7+Gz4xVoarA==
X-Received: by 2002:a05:6214:5297:b0:6e8:f3af:ed44 with SMTP id 6a1803df08f44-6eb3f287f89mr136683866d6.12.1742828390584;
        Mon, 24 Mar 2025 07:59:50 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef31810sm45558956d6.64.2025.03.24.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:59:49 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:59:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <67e17365461e3_2f6623294ea@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250323231016.74813-2-kuniyu@amazon.com>
References: <20250323231016.74813-1-kuniyu@amazon.com>
 <20250323231016.74813-2-kuniyu@amazon.com>
Subject: Re: [PATCH v1 net 1/3] udp: Fix multiple wraparounds of
 sk->sk_rmem_alloc.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> __udp_enqueue_schedule_skb() has the following condition:
> 
>   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
>           goto drop;
> 
> sk->sk_rcvbuf is initialised by net.core.rmem_default and later can
> be configured by SO_RCVBUF, which is limited by net.core.rmem_max,
> or SO_RCVBUFFORCE.
> 
> If we set INT_MAX to sk->sk_rcvbuf, the condition is always false
> as sk->sk_rmem_alloc is also signed int.
> 
> Then, the size of the incoming skb is added to sk->sk_rmem_alloc
> unconditionally.
> 
> This results in integer overflow (possibly multiple times) on
> sk->sk_rmem_alloc and allows a single socket to have skb up to
> net.core.udp_mem[1].
> 
> For example, if we set a large value to udp_mem[1] and INT_MAX to
> sk->sk_rcvbuf and flood packets to the socket, we can see multiple
> overflows:
> 
>   # cat /proc/net/sockstat | grep UDP:
>   UDP: inuse 3 mem 7956736  <-- (7956736 << 12) bytes > INT_MAX * 15
>                                              ^- PAGE_SHIFT
>   # ss -uam
>   State  Recv-Q      ...
>   UNCONN -1757018048 ...    <-- flipping the sign repeatedly
>          skmem:(r2537949248,rb2147483646,t0,tb212992,f1984,w0,o0,bl0,d0)
> 
> Previously, we had a boundary check for INT_MAX, which was removed by
> commit 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc").
> 
> A complete fix would be to revert it and cap the right operand by
> INT_MAX:
> 
>   rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
>   if (rmem > min(size + (unsigned int)sk->sk_rcvbuf, INT_MAX))
>           goto uncharge_drop;
> 
> but we do not want to add the expensive atomic_add_return() back just
> for the corner case.
> 
> So, let's perform the first check as unsigned int to detect the
> integer overflow.
> 
> Note that we still allow a single wraparound, which can be observed
> from userspace, but it's acceptable considering it's unlikely that
> no recv() is called for a long period, and the negative value will
> soon flip back to positive after a few recv() calls.

Can we do better than this?
Is this because of the "Always allow at least one packet" below, and
due to testing the value of the counter without skb->truesize added?

        /* Immediately drop when the receive queue is full.
         * Always allow at least one packet.
         */
        rmem = atomic_read(&sk->sk_rmem_alloc);
        rcvbuf = READ_ONCE(sk->sk_rcvbuf);
        if (rmem > rcvbuf)
                goto drop;

> 
>   # cat /proc/net/sockstat | grep UDP:
>   UDP: inuse 3 mem 524288  <-- (INT_MAX + 1) >> 12
> 
>   # ss -uam
>   State  Recv-Q      ...
>   UNCONN -2147482816 ...   <-- INT_MAX + 831 bytes
>          skmem:(r2147484480,rb2147483646,t0,tb212992,f3264,w0,o0,bl0,d14468947)
> 
> Fixes: 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/udp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index a9bb9ce5438e..a1e60aab29b5 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1735,7 +1735,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	 */
>  	rmem = atomic_read(&sk->sk_rmem_alloc);
>  	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
> -	if (rmem > rcvbuf)
> +	if ((unsigned int)rmem > rcvbuf)
>  		goto drop;
>  
>  	/* Under mem pressure, it might be helpful to help udp_recvmsg()
> -- 
> 2.48.1
> 



