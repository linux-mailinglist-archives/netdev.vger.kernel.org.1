Return-Path: <netdev+bounces-177435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD6A7036A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D813162F8F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E02E2561C3;
	Tue, 25 Mar 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6eCGoq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA005255E46
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912314; cv=none; b=suAPpAO+oB3n51bXXuWvXLJBLJsL8vBxoGJqKvWAGbTvV6+XvzuWlZuRwolDqRBIQ6hawjqu30o9amDAuL3LqO+S7G2AvEiOxoTwajfP/Os5GMDI0A9LMCuMDLbF/pKj74HHzgiM+svgmc0/jczhoRDpiYyc1Qa9gkWhfm3Y0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912314; c=relaxed/simple;
	bh=SvwlkvyKA66TiQdarhKtPcgtk6NcXye2HrRMzWtQgqE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=buCTuHm2mTm9zfTr75WFYO4VkEwUo4UhLJS8s/kCaDIwtSzrCyYJoYKBrNmNuWw8rg6s+/C4IxxbXHekPdG0RQTauGBZ2m5GvoYsnhbHoiMT80brtrv19JKVVsD7ilr4H7ogADaU+boCCQMwYQt7HgnQ1CL9Y9je8HVyxiKD2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6eCGoq4; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4769aef457bso62141501cf.2
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742912311; x=1743517111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j74sUDFxUOCmmG/P2LcftsHN67Rg3d1kA3HKRpkB4po=;
        b=V6eCGoq4I8F44zscC3+w4oDsvKBQGNnBqWiqw8SXf9c57htG52B2WCeMZ7lRZi91m5
         kbQzOrdL8SXpGyPpHpMINQlHJTLqI43ssZkBDp/6COL7eS9ZGWm7ffbuaus80r5BToha
         Jc1kUMotDHmfA9E36cdVW+m52gmBjUOdKXTLWbXKfaJrTpainRg7mYrEpiCGH1RHsDzw
         q037Zc6Xa0aAmHkgV4BmNgbFHTpUamO4JncyNy+A2whf3o1m7xWhMq0ye7YpU+gujyXW
         M3YtiE30Y8/MrfBhrbbTOuu5ZD3zmqygfrX+Yq9Vtggld+35R2ELgUb+w6UKFIqlz6IC
         VdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912311; x=1743517111;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j74sUDFxUOCmmG/P2LcftsHN67Rg3d1kA3HKRpkB4po=;
        b=nDs8AkyQOB93+6RNMMZho3UdXnJZp2IXwhn330mi9c9OZ0ehW8IEuI61lH0arnEImS
         BUowBY6eP6KH3AAvQxE8D5giKyTw1LqAfCR9tyjvfA7x0wfMNG3ENJxcfFaLsxQ/63Kh
         WfN/hpNDUIm7j3P3jOjCKWDqkLZ+7/k/UoDYdud0hhJDrOYfnkTq1vwyaF5ePc91iZHi
         0f3ZIKw5kYlz1TIta7QsgvxLQsr8hoH0AnxuHalxFC9LqTEgOkXqtOUt96ynD4nm8XVu
         I8PRUnvaUCR++bc9Em/zZ3K9MaeTq3CUvmPYE6gFeRdVAw2PRqgiOHOugqdRdzKASOnY
         1ldA==
X-Forwarded-Encrypted: i=1; AJvYcCXUIo4tK7Cx+NVGg34QXyo3Vyy0m55gm9wiyh5cp7s7Nm0VZMEHn7KoyY+hmG4FC6N30D/N6jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJEQtZt5kbqD7FPmXebnog9Mwi4tIHTo8QGT+TN+4E/3wdI9QJ
	SjptRqPNb+bgUwaa/8sqzeKpo49cOwd04zAyAMCqf8fhp0fdJUz0
X-Gm-Gg: ASbGncuSVJYr4BBDkGzaoJuFV2dUnHqlT6rnlpZO31vwgmGFd7tKjZ7AB68BP20tIg4
	JJB5irsys/+JOhF6JBmLMTl6KG3Bxro9QI+imFHe6atbK1gU5nKDJZ/z97vl0deMR8rMh+kVNc9
	9esSaDxkc0OuWj8Z1FGTYcDvwtJw58nUvnAhrO3A8itQKQdJlh4WbN2GLz5b22bgFkWgArZO+QU
	iE832ubbfYYSHAcvBHx3DCg+Yyn3Bjmu/YDJquQCXuVCkra8Vsyz4rwD+DSaMzagekOxe0VRghe
	oI7CV3IH7h98bsQYlpxZ3fUoDB3pzvicDKZh2JFyR4Nc5GxhgU1TMTbhG9SRT+NXgdWnaL9F6nk
	SP0pC+Iz4/EYTM5vWD/1wTg==
X-Google-Smtp-Source: AGHT+IFtBrs8i7rxsGcgc5cWVbAizdyrImCVrO1Qw7NlzWyzJt05JGS8pMwWRuyYC1Sz6EFNt82wdg==
X-Received: by 2002:a05:622a:2509:b0:476:8f75:b885 with SMTP id d75a77b69052e-4771de18e7dmr329511611cf.44.1742912311387;
        Tue, 25 Mar 2025 07:18:31 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47742085a44sm27187521cf.59.2025.03.25.07.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:18:30 -0700 (PDT)
Date: Tue, 25 Mar 2025 10:18:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 kuni1840@gmail.com, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com
Message-ID: <67e2bb367b235_3b4cd829495@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250324204653.63879-1-kuniyu@amazon.com>
References: <67e1b628df780_35010c2948d@willemb.c.googlers.com.notmuch>
 <20250324204653.63879-1-kuniyu@amazon.com>
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
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Mon, 24 Mar 2025 15:44:40 -0400
> > Kuniyuki Iwashima wrote:
> > > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > Date: Mon, 24 Mar 2025 10:59:49 -0400
> > > > Kuniyuki Iwashima wrote:
> > > > > __udp_enqueue_schedule_skb() has the following condition:
> > > > > 
> > > > >   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > > > >           goto drop;
> > > > > 
> > > > > sk->sk_rcvbuf is initialised by net.core.rmem_default and later can
> > > > > be configured by SO_RCVBUF, which is limited by net.core.rmem_max,
> > > > > or SO_RCVBUFFORCE.
> > > > > 
> > > > > If we set INT_MAX to sk->sk_rcvbuf, the condition is always false
> > > > > as sk->sk_rmem_alloc is also signed int.
> > > > > 
> > > > > Then, the size of the incoming skb is added to sk->sk_rmem_alloc
> > > > > unconditionally.
> > > > > 
> > > > > This results in integer overflow (possibly multiple times) on
> > > > > sk->sk_rmem_alloc and allows a single socket to have skb up to
> > > > > net.core.udp_mem[1].
> > > > > 
> > > > > For example, if we set a large value to udp_mem[1] and INT_MAX to
> > > > > sk->sk_rcvbuf and flood packets to the socket, we can see multiple
> > > > > overflows:
> > > > > 
> > > > >   # cat /proc/net/sockstat | grep UDP:
> > > > >   UDP: inuse 3 mem 7956736  <-- (7956736 << 12) bytes > INT_MAX * 15
> > > > >                                              ^- PAGE_SHIFT
> > > > >   # ss -uam
> > > > >   State  Recv-Q      ...
> > > > >   UNCONN -1757018048 ...    <-- flipping the sign repeatedly
> > > > >          skmem:(r2537949248,rb2147483646,t0,tb212992,f1984,w0,o0,bl0,d0)
> > > > > 
> > > > > Previously, we had a boundary check for INT_MAX, which was removed by
> > > > > commit 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc").
> > > > > 
> > > > > A complete fix would be to revert it and cap the right operand by
> > > > > INT_MAX:
> > > > > 
> > > > >   rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
> > > > >   if (rmem > min(size + (unsigned int)sk->sk_rcvbuf, INT_MAX))
> > > > >           goto uncharge_drop;
> > > > > 
> > > > > but we do not want to add the expensive atomic_add_return() back just
> > > > > for the corner case.
> > > > > 
> > > > > So, let's perform the first check as unsigned int to detect the
> > > > > integer overflow.
> > > > > 
> > > > > Note that we still allow a single wraparound, which can be observed
> > > > > from userspace, but it's acceptable considering it's unlikely that
> > > > > no recv() is called for a long period, and the negative value will
> > > > > soon flip back to positive after a few recv() calls.
> > > > 
> > > > Can we do better than this?
> > > 
> > > Another approach I had in mind was to restore the original validation
> > > under the recvq lock but without atomic ops like
> > > 
> > >   1. add another u32 as union of sk_rmem_alloc (only for UDP)
> > >   2. access it with READ_ONCE() or under the recvq lock
> > >   3. perform the validation under the lock
> > > 
> > > But it requires more changes around the error queue handling and
> > > the general socket impl, so will be too invasive for net.git but
> > > maybe worth a try for net-next ?
> > 
> > Definitely not net material. Adding more complexity here
> > would also need some convincing benchmark data probably.
> > 
> > > 
> > > > Is this because of the "Always allow at least one packet" below, and
> > > > due to testing the value of the counter without skb->truesize added?
> > > 
> > > Yes, that's the reason although we don't receive a single >INT_MAX
> > > packet.
> > 
> > I was surprised that we don't take the current skb size into
> > account when doing this calculation.
> > 
> > Turns out that this code used to do that.
> > 
> > commit 363dc73acacb ("udp: be less conservative with sock rmem
> > accounting") made this change:
> > 
> > -       if (rmem && (rmem + size > sk->sk_rcvbuf))
> > +       if (rmem > sk->sk_rcvbuf)
> >                 goto drop;
> > 
> > The special consideration to allow one packet is to avoid starvation
> > with small rcvbuf, judging also from this review comment:
> > 
> > https://lore.kernel.org/netdev/1476938622.5650.111.camel@edumazet-glaptop3.roam.corp.google.com/
> 
> Interesting, thanks for the info !
> 
> Now it's allowed to exceed by the total size of the incoming skb
> on every CPUs, and a user may notice that rmem > rcvbuf via ss,
> but I guess it's allowed because the fast recovery is expected.
> 
> 
> > 
> > That clearly doesn't apply when rcvbuf is near INT_MAX.
> > Can we separate the tiny budget case and hard drop including the
> > skb->truesize for normal buffer sizes?
> 
> Maybe like this ?
> 
>         if (rcvbuf < UDP_MIN_RCVBUF) {
>                 if (rmem > rcvbuf)
>                         goto drop;
>         } else {
>                 if (rmem + size > rcvbuf)
>                         goto drop;
>         }
> 
> SOCK_MIN_RCVBUF is 2K + skb since 2013, but the regression was
> reported after that in 2016, so UDP_MIN_RCVBUF would be more ?

Since the only issue is the overflow, could use a higher bound like
INT_MAX >> 1.
 
> But I wonder if adding new branches in the fast path is worth for
> the corner case, and that's why I chose integrating the cast into
> the exisintg branch, allowing a small overflow, which is observable
> only when no thread calls recv() and skbs are queued more than INT_MAX.

Okay. Though it can probably be structured that the likely path does
not even see this?

    if (rmem + size > rcvbuf) {
            if (rcvbuf > INT_MAX << 1)
                    goto drop;
            if (rmem > rcvbuf)
                    goto drop;
    }

