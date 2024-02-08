Return-Path: <netdev+bounces-70395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C9084EBC6
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 23:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB741C23E89
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87F950271;
	Thu,  8 Feb 2024 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="Sj1Kx4fC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4BC50255
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432035; cv=none; b=HmdOWPY3nhObLRGE7KzO2YrJuEaEUw4n5eAr+Mr+y235VnvSRkRd9mqY5SFjw29WmtlF5Gm6OIPcjhrNfRLvyTHfAFVyerEDFIu17wZTr4o9+AjFJRcPtf0u77MLCvbqqd4TwuX759pKLHntNl5mBwDEJ8TwHR+WIEFuLr1gvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432035; c=relaxed/simple;
	bh=So4aeRiMyONRzC1FOgNjabmSHvbOX0qgbFWEnNdNiWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebKbyQ7tukI/jQcgfVrWL1f82jTWCeSdubmY1xdGgz+XWA6wBUxQ5rKufJxQCSLbrAK2+EhkhBarVtwRMvSg8f5+b7bwpH8lG7gRq9iWlcUXWOhaQ0MwGkVPabpZGgnB7F+OqU7tDj1Fom28tOrBa3cemnHyUDuNGknLiBe4HIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=Sj1Kx4fC; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4b739b49349so84522e0c.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 14:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1707432032; x=1708036832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3lJ5/PEKTBbs3STYt/PCrWknijWDm4oZWwDaq5DHI0=;
        b=Sj1Kx4fCLh1AfMAU1+io5EU1zwaD58gtoBXVMF1hFAA2ilWSGqoFIwrhoIKeSciZnI
         Qt+6KlnEOxtsUChjGWlL5N6aN1HgLWsShCl+NEZM89+ZkF8peDw1+oCsQmyfcJjaa6xL
         2bsgRncNL1vgQNJikbRJ34Ro5ni6+ciFCpKlibukg+06Dczm1B3e9FkyrnkaH2dMO5WG
         cdD0rMMqlKMvan8FSh+N1pfxOpEO2BceZa8rbL/PDy3oeBV8xWvNgmkUzuhF33XqPzZJ
         thQ4dfvE/dxv7RuHf+++Nqh5oZYWn3k2Yn4Tfpz13q61S7nEmQgpZdT8z8PNloFhDnk6
         bC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707432032; x=1708036832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3lJ5/PEKTBbs3STYt/PCrWknijWDm4oZWwDaq5DHI0=;
        b=KbM3cQHBdREU1b122zbWdsJ7VQre1AsZAamvRaop1okZSdrJh/Dt7eX+HqLg3rXWq6
         uiGxv/XCKM6VhCCQyYjzGDac930zI6Wa5mbD2CeyLO8NIGJOl0wSw1t1pGJg9ZMQBJaL
         6M2KajXvvRp4CKxqsN2uOBbxIxdeweuwEMVfY7u+QmzyLsm6+inRIbyADPH28iiXJpTs
         8OAkpj/lXZvibpR5AUP5teyio6z3giVGccTZ70eJxwh85bP/1oZj5cxHPsrM6zkfOyF7
         gkMxQfMcXOqys4ZIPCG8L7faGFAUPMaWOwjvOCJugnurM+gQZFrn44vpI8aO40TMaZCP
         cKNQ==
X-Gm-Message-State: AOJu0YwWQ+yQkxUYnlky3zoed3w1z4an0GSV+0/8tnDuF33kdkcEiltx
	IJpEyzq11IyQRMa/bKVbD5xaeE0XplWZWXlmyaA5LrwR9leR9pXQDkRl4TJFfWmzleRmRJBBm35
	qK6mkRoCcw7hnwRK81pyGOQMLTB/ZXWzbwqJ3
X-Google-Smtp-Source: AGHT+IHWAboIgDWGtFrvLeIIqUbq2ZeXCrWTEzNavW92E7YiBCEGMwaQV95fRD3i4XbIwNEifp9KksFPBqxzUf041rA=
X-Received: by 2002:a1f:4c46:0:b0:4c0:292d:193d with SMTP id
 z67-20020a1f4c46000000b004c0292d193dmr1013503vka.12.1707432032515; Thu, 08
 Feb 2024 14:40:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com>
 <f454d60a-c68e-4fcc-a963-fc5c4503d0ee@linux.dev> <CALCETrWu63SB+R8hw-1gZ-fbutXAAFKuWJD-wJ9GejX+p8jhSw@mail.gmail.com>
 <65c54cc9ea70c_1cb6bf29492@willemb.c.googlers.com.notmuch>
In-Reply-To: <65c54cc9ea70c_1cb6bf29492@willemb.c.googlers.com.notmuch>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 8 Feb 2024 14:40:20 -0800
Message-ID: <CALCETrV3S1hj5tdQ1oCgm6ytgUOY8M3t9OSn0WcRLNYn3ZBURg@mail.gmail.com>
Subject: Re: SOF_TIMESTAMPING_OPT_ID is unreliable when sendmsg fails
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:51=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Andy Lutomirski wrote:
> > On Thu, Feb 8, 2024 at 11:55=E2=80=AFAM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> > >
> > > On 08/02/2024 18:02, Andy Lutomirski wrote:
> > > > I=E2=80=99ve been using OPT_ID-style timestamping for years, but fo=
r some
> > > > reason this issue only bit me last week: if sendmsg() fails on a UD=
P
> > > > or ping socket, sk_tskey is poorly.  It may or may not get incremen=
ted
> > > > by the failed sendmsg().
>
> The intent is indeed to only increment on a successful send.
>
> The implementation is complicated a bit by (1) being a socket level
> option, thus also supporting SOCK_RAW and (2) MSG_MORE using multiple
> send calls to only produce a single datagram and (3) fragmentation
> producing multiple skbs for a single datagram.
>
> If only SOCK_DGRAM, conceivably we could move this to udp_send_skb,
> after the skb is created and after the usual error exit paths.
>
> An alternative is in error paths to decrement the counter. This is
> what we do for MSG_ZEROCOPY references. Unfortunately, with the
> lockless UDP path, other threads could come inbetween the inc and dec,
> so this is not really workable.
>
> > > Well, there are several error paths, for sure. For the sockets you
> > > mention the increment of tskey happens at __ip{,6}_append_data. There
> > > are 2 different types of failures which can happen after the incremen=
t.
> > > The first is MTU check fail, another one is memory allocation failure=
s.
> > > I believe we can move increment to a later position, after MTU check =
in
> > > both functions to avoid first type of problem.
> >
> > For reasons that I still haven't deciphered, I'm sporadically getting
> > EHOSTUNREACH after the increment.  I can't find anything in the code
> > that would cause that, and every time I try to instrument it, it stops
> > happening :(  I sendmsg to the same destination several times in rapid
> > succession, and at most one of them will get EHOSTUNREACH.
>
> UDP might fail on ICMP responses. Try sending to a closed port. A few
> send calls will succeed, but eventually the send call will refuse to
> send. The cause is in the IP layer.
>

I tracked down the code, finally.

But I maintain that this behavior is absurd.  Sure, if I do:

connect(fd, some address);
send(fd, ...);
<-- ICMP error because the port was closed
send(fd, ...) =3D -ECONNREFUSED;

then this makes a little bit of sense.  But that's about as far as it
makes sense to me.  This variant is a bit different:

connect(fd, some address);
send(fd, ...);
<-- ICMP error because the port was closed
send(fd, ...) =3D -ECONNREFUSED;
send(fd, ...) =3D 0;  <-- now it works again by magic!

okay, maybe I can stretch my imagination so this makes sense.  But
then this comes out of left field:

connect(fd, some address);
sendto(fd, ..., willem:1);
<-- ICMP error because the port was closed
sendto(fd, ..., andy:2) =3D -ECONNREFUSED;

excuse me?  And setting IP_RECVERR broadens the set of errors that
cause this IMO rather silly behavior, presumably motivated by the
login in the ip(7) manpage:

   When the user receives an error from a socket operation, the errors
can be received by calling recvmsg(2) with the MSG_ERRQUEUE flag set.

Isn't that what POLLERR is for?

And somehow the implementation of this logic for send, etc makes it
most of the way through the code before checking sock_error at all.

Anyway, I'll continue contemplating.

