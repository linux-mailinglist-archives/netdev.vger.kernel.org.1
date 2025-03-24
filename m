Return-Path: <netdev+bounces-177198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B630A6E3C4
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D98D3ADAB4
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3FD19F135;
	Mon, 24 Mar 2025 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjlEZubb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB619CCEA
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845485; cv=none; b=lHoDDIxL7wu2/l1outrtn6gBxnBmbbx1z4u0160haAxhCDaDM5P+835HYpSkqOlyurvEGxLgEtvOCkboNlq562zRKGy6E+xX0Xd7Dywn07xgaWmC1wfqcxo4wbycjJ7Cp6yAOq9EbAsEcSU3P+tNHdK1mtOHhPzPYt0lfIGd2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845485; c=relaxed/simple;
	bh=gqxJ+QmzECqRBwn1dO9QjOKCRVypeRIQvkx8F5ivx9U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lfEA//kPMkCPfQb1f8DIdml9nNZ73VOII0Ux6KDx5fvFkglx7t/6yYVnyWPLrBa5OlCsU5y8xFZw9jWPhtnmuiLxC/Lr9fgHajJKMu+LEbMKR0YbQs7Mt7+6uCNHdDT0SJ3zpGsqEy2iPBAM6zQMGXY0ZuEyQn5vvddxKfT8gaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjlEZubb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5b2472969so472862185a.1
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742845482; x=1743450282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie6E7R0W1nBrr9w7OifJk+9t+CtBR1LofPT/C5n78X0=;
        b=BjlEZubboheC3QQf9m9OMA4AHMWdCrSUo426ku7rnJb9T3hT2/YQOQbjor6fYk/yYI
         k/GNcjhkMjcKRA784NdHrgOt1P+/0SZNOsb0xopk97y/3yKnJfSCuizrfQiIvbXQSpa0
         gHbdMePd7qLaqxrjYDVlkSbnF9IZ/1R/M/aPYL+xKNVlvZ0O3MX6SM2a7lN/ZSLw68BE
         fKyDsqvt6XaTEa1tMdFJR77dcmDYLC235kPLHwhll3yXToW2vuzsevvUmvpfQla+kVGC
         +GYVTMVtqWvA2XErjmuCyal+rlxiF62NvL850ggg0n13hdEZVwjVhsxXAFDPG9/YIIhg
         o4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742845482; x=1743450282;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ie6E7R0W1nBrr9w7OifJk+9t+CtBR1LofPT/C5n78X0=;
        b=S5UGGCoC/ABkDMgheo4KF1zL8HKIr+HkgRWAXDd5U5tYAofSpxnzSGoLWMsBRH3gpc
         GBPF86zPaewCNf4U3xMVLEkD0glsxZdjC2De7+4oVya+N1IEJTsn3y1F2YWUeZwT8+p/
         LfJqG7D1r4vdM0MtKxrQuxa5f8FQ5o91BYSyNx8v6QqKe0myfOilDeEctrkwiaRCvM0g
         bm6OEEurseumQdrc7MLCG/VeMspOt/4N9ZMFM57qdfNGuk81phyvim5B/VeH9CVpWZOy
         dMKL8YJj+GpktMigGbvguh3p646SafUvdKng2umfduKs8orezHrUnS5zGrpiILw6AJw+
         sy7w==
X-Forwarded-Encrypted: i=1; AJvYcCVulZK7A9sB7JhkQwlnu1pZ7dpp6ey2QUetqWhk3jO6ZJxeMLBONd5eemM85x71iJKF0c+RreA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPY6zImB3nhUgfk6asRfOy77VBnP6kVbEssd6FM62pcfZCpRxm
	dwPaI6mkYEFMnH12Tbzc40V/WhMVqe1ZtCPZacly47MpyjWOKm1k
X-Gm-Gg: ASbGnctUA6cWnCANhyRDvc3M//fYLT2nbXOG5majSyIPKH5O32T5bG9KMroLGRfId5g
	JCJDjjYj+kVG2KnIouiO1cHebFBEKhDe8vFrj8bXN70s4vHqku8KwydJIixo2B6RFgbgaYuvlwS
	yhaJwvRy3hku7oTn+uqui8GmEEh3iPtg2440sbUG1cR1rStejezlwBXKdweSYvRIkZXJ/ecrOgo
	4s32IAswhpyeX2WhskEX3x73FAY5+/3eSjNorX8dFZoKLBf66wDmvq5OftKJlzBzG8at0OZ1/p+
	3taZm6G3O9S88suloOy18vo/Vu724+d2YwoMIkydmg3UjgA/YAs4cwyC/vJ3mYgqtviCaeEjgW5
	yweC6fzIvJsP42s7INpQLdg==
X-Google-Smtp-Source: AGHT+IHTtnhHjWjwx7nDp6zGotRmxgdnhPDtobQU5M6dYPzdHSQ5evgOUetbG1cOwmGZdJjYffyhxg==
X-Received: by 2002:a05:620a:1b94:b0:7c5:4bb7:8e45 with SMTP id af79cd13be357-7c5ba1ee8f9mr2107211185a.40.1742845481724;
        Mon, 24 Mar 2025 12:44:41 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d17ef03sm50696751cf.32.2025.03.24.12.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 12:44:41 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:44:40 -0400
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
Message-ID: <67e1b628df780_35010c2948d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250324181116.45359-1-kuniyu@amazon.com>
References: <67e17365461e3_2f6623294ea@willemb.c.googlers.com.notmuch>
 <20250324181116.45359-1-kuniyu@amazon.com>
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
> Date: Mon, 24 Mar 2025 10:59:49 -0400
> > Kuniyuki Iwashima wrote:
> > > __udp_enqueue_schedule_skb() has the following condition:
> > > 
> > >   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > >           goto drop;
> > > 
> > > sk->sk_rcvbuf is initialised by net.core.rmem_default and later can
> > > be configured by SO_RCVBUF, which is limited by net.core.rmem_max,
> > > or SO_RCVBUFFORCE.
> > > 
> > > If we set INT_MAX to sk->sk_rcvbuf, the condition is always false
> > > as sk->sk_rmem_alloc is also signed int.
> > > 
> > > Then, the size of the incoming skb is added to sk->sk_rmem_alloc
> > > unconditionally.
> > > 
> > > This results in integer overflow (possibly multiple times) on
> > > sk->sk_rmem_alloc and allows a single socket to have skb up to
> > > net.core.udp_mem[1].
> > > 
> > > For example, if we set a large value to udp_mem[1] and INT_MAX to
> > > sk->sk_rcvbuf and flood packets to the socket, we can see multiple
> > > overflows:
> > > 
> > >   # cat /proc/net/sockstat | grep UDP:
> > >   UDP: inuse 3 mem 7956736  <-- (7956736 << 12) bytes > INT_MAX * 15
> > >                                              ^- PAGE_SHIFT
> > >   # ss -uam
> > >   State  Recv-Q      ...
> > >   UNCONN -1757018048 ...    <-- flipping the sign repeatedly
> > >          skmem:(r2537949248,rb2147483646,t0,tb212992,f1984,w0,o0,bl0,d0)
> > > 
> > > Previously, we had a boundary check for INT_MAX, which was removed by
> > > commit 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc").
> > > 
> > > A complete fix would be to revert it and cap the right operand by
> > > INT_MAX:
> > > 
> > >   rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
> > >   if (rmem > min(size + (unsigned int)sk->sk_rcvbuf, INT_MAX))
> > >           goto uncharge_drop;
> > > 
> > > but we do not want to add the expensive atomic_add_return() back just
> > > for the corner case.
> > > 
> > > So, let's perform the first check as unsigned int to detect the
> > > integer overflow.
> > > 
> > > Note that we still allow a single wraparound, which can be observed
> > > from userspace, but it's acceptable considering it's unlikely that
> > > no recv() is called for a long period, and the negative value will
> > > soon flip back to positive after a few recv() calls.
> > 
> > Can we do better than this?
> 
> Another approach I had in mind was to restore the original validation
> under the recvq lock but without atomic ops like
> 
>   1. add another u32 as union of sk_rmem_alloc (only for UDP)
>   2. access it with READ_ONCE() or under the recvq lock
>   3. perform the validation under the lock
> 
> But it requires more changes around the error queue handling and
> the general socket impl, so will be too invasive for net.git but
> maybe worth a try for net-next ?

Definitely not net material. Adding more complexity here
would also need some convincing benchmark data probably.

> 
> > Is this because of the "Always allow at least one packet" below, and
> > due to testing the value of the counter without skb->truesize added?
> 
> Yes, that's the reason although we don't receive a single >INT_MAX
> packet.

I was surprised that we don't take the current skb size into
account when doing this calculation.

Turns out that this code used to do that.

commit 363dc73acacb ("udp: be less conservative with sock rmem
accounting") made this change:

-       if (rmem && (rmem + size > sk->sk_rcvbuf))
+       if (rmem > sk->sk_rcvbuf)
                goto drop;

The special consideration to allow one packet is to avoid starvation
with small rcvbuf, judging also from this review comment:

https://lore.kernel.org/netdev/1476938622.5650.111.camel@edumazet-glaptop3.roam.corp.google.com/

That clearly doesn't apply when rcvbuf is near INT_MAX.
Can we separate the tiny budget case and hard drop including the
skb->truesize for normal buffer sizes?

> 
> > 
> >         /* Immediately drop when the receive queue is full.
> >          * Always allow at least one packet.
> >          */
> >         rmem = atomic_read(&sk->sk_rmem_alloc);
> >         rcvbuf = READ_ONCE(sk->sk_rcvbuf);
> >         if (rmem > rcvbuf)
> >                 goto drop;



