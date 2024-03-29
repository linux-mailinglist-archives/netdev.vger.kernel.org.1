Return-Path: <netdev+bounces-83127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3339E890ED7
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A021F2394B
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 00:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23986196;
	Fri, 29 Mar 2024 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJm0IuK/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8391C1103
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 00:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711670741; cv=none; b=s53TGoFQuh9YBInzq1U5Vnn2HyPYLwVysa7+w9c9lwMXK5T7nRxVu+U0osMnL6t1FtqoiUT23NlWo78BJmKADd/VwKBC++hX/zbJ5F4D836Kd131Zqa6y2MdsYRdo+hCKuSy8HnFAOwvaxnSf2Ka2paBIQv3/1l7dm3VNDqZaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711670741; c=relaxed/simple;
	bh=CVFDuF7QchxtnUALLrrW3aKDADEk5Wcx2aSHpQ0oWQw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Qt31ma6t5u1uCTAifhCAQx7vX9lXY/mmbrmk5cn3nYgJLX/ZYq7tKTQoZWbSn9rXVIhjboVLLU9SwT4VS3odj71+o3+JcNf1t4TPBLyMhX8Chm1xEoUSjw+BZYLzz1McIRJpLT4tJ4QnYvH4Sd9jut77atV6JhPvV0aBZumr5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJm0IuK/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-695df25699fso11653486d6.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711670738; x=1712275538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/emMI+v1QgjHULbqRu005ku6e9KACgkmdzZVKRP/5Y=;
        b=IJm0IuK/CcgUVQXUkA7TO1xtqCVL8kf8mT5SpzSAaJQnuRPFYxtRLn35UoMR3sc/zn
         Re5+HIrOifmHPAkEzYNrnZEpSmDsoS0zQ+2+Dyg8xyPEYrU5gRb9/Qb+vFtNwp2kZBTM
         HWr9iGlvXhhY8Uv4Z0LA4oEg/XEsyYbkEJyg8FolGGJ3Hz0Ajtafc1Y5s0ztMv5WyQ++
         H5ZIYq5YkEYT2BO+/WHsoCYJpBUEHVH5Xc+CgoWY4xER/+KF12qYxH9tMy5lpuOB+AYQ
         fbw6Bd60PeYFvb9d6rnxPmRx6VVwGjAZ5Hk4A4vvWtWxpHPX0tNJ06X28zNEeGMZdcw3
         62jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711670738; x=1712275538;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V/emMI+v1QgjHULbqRu005ku6e9KACgkmdzZVKRP/5Y=;
        b=DTAwmlJE4Qtk67KgFjhzJ5itERHhl+XmP/N0t7uhm+EuJetl3n9JtsqZExSuQKCkcH
         Q06aq2lKiG+BUPrthplDgedVswzTJi+IBQqSk8TLZRlOfuZD5ua5z2oPkumZ8d3ReRJm
         FEaudvhdzhBT1C5BvIrxgHx9eDdZ7ZBl4TDaxKrzCNZwa9rdrhhIKZi9+mFe3OyXWjst
         kCPIzo5QlNwCxQ+aR5ilkvhnAEC5Oban62jWEOpqqMJPbQX63I5DTswIQUAft7rluCLF
         /ZrCNl8rZGXJRyiblkcClLEtQgLMQ8e8utrrOT+j9983E1Ztmu7g4B3uN31sxl+6hWUr
         mHDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN/fVJThwtUKGaqNngUkq//tsLlkc9A2nrfnr/Jn/LGJREw8iXcFyOTsZa+NIU2MphVdPSPfwf5IYNnwrSIY8B/lr/rUTt
X-Gm-Message-State: AOJu0YwBSdLecotmNxgnIUzVtlM1ZgNs19vH9Rc0ja95LQSCQX6ARILM
	S1fyjHBkji5OLaNGSvujB8f7zMAUBTsIJF1638W9wu0Ume9qn3A7
X-Google-Smtp-Source: AGHT+IEzx7tX15f4f/6HeifUfYggIrOTu6Xg/I/ua9mh67nJ4kZn4S1i142aAiyEoXRPLwjDUNM8rg==
X-Received: by 2002:a05:6214:205:b0:696:80b0:8c37 with SMTP id i5-20020a056214020500b0069680b08c37mr625501qvt.28.1711670738477;
        Thu, 28 Mar 2024 17:05:38 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id jm15-20020ad45ecf000000b00690afbf56d5sm1094447qvb.66.2024.03.28.17.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:05:38 -0700 (PDT)
Date: Thu, 28 Mar 2024 20:05:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <660605d1e892f_2c4140294f7@willemb.c.googlers.com.notmuch>
In-Reply-To: <660602dbd4e85_2c31072943f@willemb.c.googlers.com.notmuch>
References: <20240328144032.1864988-1-edumazet@google.com>
 <20240328144032.1864988-2-edumazet@google.com>
 <660602dbd4e85_2c31072943f@willemb.c.googlers.com.notmuch>
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

Willem de Bruijn wrote:
> Eric Dumazet wrote:
> > sk->sk_rcvbuf is read locklessly twice, while other threads
> > could change its value.
> > 
> > Use a READ_ONCE() to annotate the race.
> > 
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/udp.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 661d0e0d273f616ad82746b69b2c76d056633017..f2736e8958187e132ef45d8e25ab2b4ea7bcbc3d 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1492,13 +1492,14 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
> >  	struct sk_buff_head *list = &sk->sk_receive_queue;
> >  	int rmem, err = -ENOMEM;
> >  	spinlock_t *busy = NULL;
> > -	int size;
> > +	int size, rcvbuf;
> >  
> > -	/* try to avoid the costly atomic add/sub pair when the receive
> > -	 * queue is full; always allow at least a packet
> > +	/* Immediately drop when the receive queue is full.
> > +	 * Always allow at least one packet.
> >  	 */
> >  	rmem = atomic_read(&sk->sk_rmem_alloc);
> > -	if (rmem > sk->sk_rcvbuf)
> > +	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
> > +	if (rmem > rcvbuf)
> >  		goto drop;
> >  
> >  	/* Under mem pressure, it might be helpful to help udp_recvmsg()
> > @@ -1507,7 +1508,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
> >  	 * - Less cache line misses at copyout() time
> >  	 * - Less work at consume_skb() (less alien page frag freeing)
> >  	 */
> > -	if (rmem > (sk->sk_rcvbuf >> 1)) {
> > +	if (rmem > (rcvbuf >> 1)) {
> >  		skb_condense(skb);
> >  
> >  		busy = busylock_acquire(sk);
> 
> There's a third read in this function:

But you remove that in the next patch. Ok.


