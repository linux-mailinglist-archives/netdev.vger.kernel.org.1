Return-Path: <netdev+bounces-70384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E584EAD7
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEB128D4F8
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 21:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A564C618;
	Thu,  8 Feb 2024 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhYdeRS8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76E4F5E5
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 21:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429069; cv=none; b=lBSvCqgKZVJuLW0wNS0KeYmxCizD8+GEKXL8bSyhnmG1MgJEIyk3AZJwfni00VqfBxcEuH4cNEjIgKj+iMrqYgyA1qpBapDI4MGEZwqUkcjhyTAvxztJNUFJ/Nyha/8QVdGkzCJCbdjzk65/RWuAREDj4e0ZM+NJrIkupVBAm2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429069; c=relaxed/simple;
	bh=Idu3qGPO/g/Etri0oM1k3dU5UPdINQgZ5cDiEHVrcZw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=APiQwZhAF7Q27s0tThDRcwcboYxEozsDvyM1InCrHT2XP+aPShgMFyKEPOx//YDxViMUmIkER6eIvagjUCPAKagc526JJfMPzghMCsA8+bpNpwf8Ey0B1soLICniP1xJjx/ddH0lNt5fg2t9h8pzBAgnz1CTf/z7jobUlDB6NVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhYdeRS8; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bfd3db19baso118899b6e.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 13:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707429066; x=1708033866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIYiS1TTUPCk9T95S8njC1Yp6siu1vGkgx9QWAdSP6M=;
        b=HhYdeRS8shONBy7yW+1K492lony2z6up2HQK0SneSsVhjdfX6Ra/fGklT3m/LSGu7b
         K18ZUAXL6nw9oCK6a9gk1Ey8WKza/n3z4/jQ4dzsgIDoclK6WiXXxqujAQ0wF6O/zHEw
         rd7xprOKjXUjF29KaRI0pUBEd5bhVT0/UYhY4k4V1ttBCIYLl7cf5FNn9W+Utd6kb9d+
         65X+pnTAEJ+3Jy6Ww287UHj0QhspsbSMk4Wt5J3LX97zcJcDctBYmWjajPksCQHe3Eho
         YdiizPtSQbnzAQfY5JQVXiMQLJnwxKGI7nYOb7ZlBQp+0kznSo/Uil0MJ0envwGoH/e0
         QqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707429066; x=1708033866;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fIYiS1TTUPCk9T95S8njC1Yp6siu1vGkgx9QWAdSP6M=;
        b=lqVe/WHjFmnv16eL6DVijZh7784qXvxNo+LDHqfzIWaoKKy6GHU7ET5a+LUcNeZY2c
         8p7vjw1ridllbbqku3+yexs6ZjJ4sFD/8ptFq9C3a0GkScpY1uRFSTVrzJyGxQIDC89J
         TW9uJP0Gzy1nsuy1oNambvQORGY8ql25yZgLIi3Z/veWsEFkYR1Ox+2zunpzR/IAn20F
         z8s+yeVJ0VDmi/D8daIRAvww+FBdl7ct6/gSIjwC2zbtCALd42/Mj37rkXf/8xXPuZxv
         EeuQyBE++9y/z/pRu2xtO6L443RGrwQR9SzE+nBL2wYpFld/TzgI3chqIvCTm4CdDPY+
         Vs3A==
X-Forwarded-Encrypted: i=1; AJvYcCWbQwq4XyprlTiyRzGxSm2Lyo8Ov/9PuPYD190tifzl5f2wqLJLc7neBiEhfsgziqO8eOixZMFgsU6tx0irOupxsNVExPev
X-Gm-Message-State: AOJu0YxSH2i4Qh0qFi8DnWjdshntf4m+7PkPpjms7EwXu2k7fxDrUZp4
	DXuR0HojyZPSE9OfmknMK6b7VQNC558rGIz+RJY+XduMda2vMY6M
X-Google-Smtp-Source: AGHT+IEzw50FuLMT6gPEIoloy6Wn56dW1QPJ3loSVNW3CG4N3ucItR122GvV+8WOF8IlcN78Y96CDA==
X-Received: by 2002:a05:6808:114f:b0:3bf:eb08:da79 with SMTP id u15-20020a056808114f00b003bfeb08da79mr695597oiu.2.1707429066531;
        Thu, 08 Feb 2024 13:51:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9qcCiVwuMp5F6We8sgt/iXMbeq35Y24AXEXQIb7dll3Qk3Z3hRDg9NkEdlwaPOZwuDM3BH1FA0ATJHgXQ9J9xliVMpJ6si8RAVYqAYB3JxTZV3O7IOag21Tb3jZzM6W/feEnU3dyKHnMih/jWqMeSFjnoNeZ8V73o5rfhpr0030pHfnlHCUo=
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id p4-20020a05620a22a400b00783fe340e2asm184901qkh.107.2024.02.08.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 13:51:06 -0800 (PST)
Date: Thu, 08 Feb 2024 16:51:05 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Andy Lutomirski <luto@amacapital.net>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Network Development <netdev@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <65c54cc9ea70c_1cb6bf29492@willemb.c.googlers.com.notmuch>
In-Reply-To: <CALCETrWu63SB+R8hw-1gZ-fbutXAAFKuWJD-wJ9GejX+p8jhSw@mail.gmail.com>
References: <CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com>
 <f454d60a-c68e-4fcc-a963-fc5c4503d0ee@linux.dev>
 <CALCETrWu63SB+R8hw-1gZ-fbutXAAFKuWJD-wJ9GejX+p8jhSw@mail.gmail.com>
Subject: Re: SOF_TIMESTAMPING_OPT_ID is unreliable when sendmsg fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy Lutomirski wrote:
> On Thu, Feb 8, 2024 at 11:55=E2=80=AFAM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
> >
> > On 08/02/2024 18:02, Andy Lutomirski wrote:
> > > I=E2=80=99ve been using OPT_ID-style timestamping for years, but fo=
r some
> > > reason this issue only bit me last week: if sendmsg() fails on a UD=
P
> > > or ping socket, sk_tskey is poorly.  It may or may not get incremen=
ted
> > > by the failed sendmsg().

The intent is indeed to only increment on a successful send.

The implementation is complicated a bit by (1) being a socket level
option, thus also supporting SOCK_RAW and (2) MSG_MORE using multiple
send calls to only produce a single datagram and (3) fragmentation
producing multiple skbs for a single datagram.

If only SOCK_DGRAM, conceivably we could move this to udp_send_skb,
after the skb is created and after the usual error exit paths.

An alternative is in error paths to decrement the counter. This is
what we do for MSG_ZEROCOPY references. Unfortunately, with the
lockless UDP path, other threads could come inbetween the inc and dec,
so this is not really workable.

> > Well, there are several error paths, for sure. For the sockets you
> > mention the increment of tskey happens at __ip{,6}_append_data. There=

> > are 2 different types of failures which can happen after the incremen=
t.
> > The first is MTU check fail, another one is memory allocation failure=
s.
> > I believe we can move increment to a later position, after MTU check =
in
> > both functions to avoid first type of problem.
> =

> For reasons that I still haven't deciphered, I'm sporadically getting
> EHOSTUNREACH after the increment.  I can't find anything in the code
> that would cause that, and every time I try to instrument it, it stops
> happening :(  I sendmsg to the same destination several times in rapid
> succession, and at most one of them will get EHOSTUNREACH.

UDP might fail on ICMP responses. Try sending to a closed port. A few
send calls will succeed, but eventually the send call will refuse to
send. The cause is in the IP layer.

> >
> > > I can think of at least three ways to improve this:
> > >
> > > 1. Make it so that the sequence number is genuinely only incremente=
d
> > > on success. This may be tedious to implement and may be nearly
> > > impossible if there are multiple concurrent sendmsg() calls on the
> > > same socket.
> >
> > Multiple concurrent sendmsg() should bring a lot of problems on user-=

> > space side. With current implementation the application has to track =
the
> > value of tskey to check incoming TX timestamp later. But with paralle=
l
> > sendmsg() the app cannot be sure which value is assigned to which cal=
l
> > even in case of proper track value synchronization. That brings us to=

> > the other solutions if we consider having parallel threads working wi=
th
> > same socket. Or we can simply pretend that it's impossible and then f=
ix
> > error path to decrement tskey value.
> > >
> > > 2. Allow the user program to specify an explicit ID.  cmsg values a=
re
> > > variable length, so for datagram sockets, extending the
> > > SO_TIMESTAMPING cmsg with 64 bits of sequence number to be used for=

> > > the TX timestamp on that particular packet might be a nice solution=
.
> > >
> >
> > This option can be really useful in case of really parallel work with=

> > sockets.
> =

> I personally like this one the best.  Some care would be needed to
> allow programs to detect the new functionality.  Any preferred way to
> handle it?

Regardless of whether we can fix the existing behavior, I also think
this is a worthwhile cmsg. As timestamping is a SOL_SOCKET option, the
cmsg should likely also be that, processed in __sock_cmsg_send.

