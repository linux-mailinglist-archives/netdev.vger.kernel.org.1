Return-Path: <netdev+bounces-83125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999F6890EC1
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 00:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD601F2450F
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 23:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2C913B288;
	Thu, 28 Mar 2024 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMKJxH+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71F13AD04
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669982; cv=none; b=lL3yNsIsLCdEKRjh04eVREKIKR5QS3VF8N/rDKQm8GiMSTPHQEuMByiD4n3zcrX/ZeFMTxyWWPXqEyV6N2ja6Hrw+42cviM/xPr43PxgzyfO720PWhxcSP6vzp2Qbxh7jWHMlZt/n1b1l5w8dwLczQB8kH95hpsPJjQVLLehg/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669982; c=relaxed/simple;
	bh=2CQkgrZVgoMLAcaEnzdNVl/wYj8bV5gSI4pxH0w9uGE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LJkfQZ7FqTqhGzA67MIa12oupWeeJO+zWWPKReyCBtLnzScTFCkzmz9Xu0tDRKG85YCNasTFAWA9bjPiv6BN/f4dJOkxjRcdUNe9iTASAoMbJ8A4c7k8ancSoZw5zvjVR5JXOw/l11L0rAltowKLd7p2EhOY0/v5sskwbItTxa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMKJxH+l; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d89515ec9aso581597e0c.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711669980; x=1712274780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An/2KTmJW4bMrDvyD3mXc0XAN6dSCpRYVnPUjtjjW8Y=;
        b=BMKJxH+lBhcPDkjARu1uQSyElpUPWufB3kD3qREMNRrpUMS5WK7RQQfAIXkiBDjPDP
         jHVUAzqnGA8NdvvjhMkC2wJ+ZCpMCPc4Q2ITFI9Wb8bzISpg3akC8HzXIZLj/3E+5b43
         +iNEtOXm7Imi8oznRGeRMgHW8Inumf7Inq/BUBu4U9wnadCDHNgX0cVY1GcV8mrhhk68
         krtt3R3hsoRVQKOjsTUBM1aR0sJvWWuq/sSZ4wxQnRzbTlVP1oIJzns7OXIzlOtFB3OY
         aMAgo7+bOR9LFI1PiI5KK9cunaGth/rELwxZklivYmFJlI0g0jm03avqJbr2hrNnChvr
         OnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711669980; x=1712274780;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=An/2KTmJW4bMrDvyD3mXc0XAN6dSCpRYVnPUjtjjW8Y=;
        b=r6d6c3f7Y+YYIVZAO737Yn2UaNFJbFFgA8+N4eCGsjmchOrHp+1BmjaJpWqduU+vvD
         uahL+712HgTDc5qUrRyNB9sWOMqgGxsPESPw5I7YBO1gxqXqZ9m7Ev6IgaxGwmo6nV4c
         0Q56qLvi37D7CojetoKcULp3RuyGP96IAkRYNfwworR1eCoLYEmPn+WOQLmUGTYYZYjm
         8i9ny8hDh8LBu4kEOnVK93rVPrFeGQHkxixF2q2UQGK5jnP7Amqv6I9AOZBle+pYywjf
         QVZV8UcCuHuMIdObYe1AiR/rXISr0pZOqj/fJWJYD8u+Pp8Eu99cTUttkDtPTr7s9fXS
         OtAw==
X-Forwarded-Encrypted: i=1; AJvYcCWFAiS73U/o4FqOvY7CAQkRKqb5INxQoCbbQbEuJ030nXb+nXIXctAqBxAQGyl/7ng9PqaEjlGD8d2aPDvYkFN8TTNa2Cgi
X-Gm-Message-State: AOJu0YypDCYNfthAMG4Oty+E9nBv5QIgBf+qzXiI1G3A5j9snr+O8iIE
	gFImD68UZET6tWGkUxQl6ry+zuglHtRhrr6lEmaGfG2o+cTr202M
X-Google-Smtp-Source: AGHT+IFVaLss4+QE6frWLpjgbhMYyEcevl2oJ5Ew52dTpdOgAzMdThhuSika8zvqJYy9BZ82HQ8qdg==
X-Received: by 2002:a05:6122:16aa:b0:4d3:3446:6bcb with SMTP id 42-20020a05612216aa00b004d334466bcbmr880953vkl.16.1711669980422;
        Thu, 28 Mar 2024 16:53:00 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id nw1-20020a0562143a0100b006968d8f1c05sm1089945qvb.26.2024.03.28.16.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:53:00 -0700 (PDT)
Date: Thu, 28 Mar 2024 19:52:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <660602dbd4e85_2c31072943f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240328144032.1864988-2-edumazet@google.com>
References: <20240328144032.1864988-1-edumazet@google.com>
 <20240328144032.1864988-2-edumazet@google.com>
Subject: Re: [PATCH net-next 1/4] udp: annotate data-race in
 __udp_enqueue_schedule_skb()
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
> sk->sk_rcvbuf is read locklessly twice, while other threads
> could change its value.
> 
> Use a READ_ONCE() to annotate the race.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/udp.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 661d0e0d273f616ad82746b69b2c76d056633017..f2736e8958187e132ef45d8e25ab2b4ea7bcbc3d 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1492,13 +1492,14 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	struct sk_buff_head *list = &sk->sk_receive_queue;
>  	int rmem, err = -ENOMEM;
>  	spinlock_t *busy = NULL;
> -	int size;
> +	int size, rcvbuf;
>  
> -	/* try to avoid the costly atomic add/sub pair when the receive
> -	 * queue is full; always allow at least a packet
> +	/* Immediately drop when the receive queue is full.
> +	 * Always allow at least one packet.
>  	 */
>  	rmem = atomic_read(&sk->sk_rmem_alloc);
> -	if (rmem > sk->sk_rcvbuf)
> +	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
> +	if (rmem > rcvbuf)
>  		goto drop;
>  
>  	/* Under mem pressure, it might be helpful to help udp_recvmsg()
> @@ -1507,7 +1508,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	 * - Less cache line misses at copyout() time
>  	 * - Less work at consume_skb() (less alien page frag freeing)
>  	 */
> -	if (rmem > (sk->sk_rcvbuf >> 1)) {
> +	if (rmem > (rcvbuf >> 1)) {
>  		skb_condense(skb);
>  
>  		busy = busylock_acquire(sk);

There's a third read in this function:

        /* we drop only if the receive buf is full and the receive
         * queue contains some other skb
         */
        rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
        if (rmem > (size + (unsigned int)sk->sk_rcvbuf))
                goto uncharge_drop;

Another READ_ONCE if intent is to not use the locally cached copy?

