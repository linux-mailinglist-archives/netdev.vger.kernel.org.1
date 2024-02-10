Return-Path: <netdev+bounces-70769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A03850540
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 17:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DFC1F2133A
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658A35C61E;
	Sat, 10 Feb 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esViMVK1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EE5336D
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583060; cv=none; b=LsLEPVGBamhrOIHMobAAMFJ4CT2PIU3otDFlmDEOXm+MsAiTvay6QrQG8ckb1N8Lmgece5tLh2L9mMooruLMoUPr79uC/y2P2cBjJ8RS5KXondImBaRCanISQaApRY1od5aXSTX3VrNQVot/XXDgAkODDrcR/VIcGs6qPtYbf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583060; c=relaxed/simple;
	bh=Md9FB1DmmEOIkVMUraoYh6JlF20g6xWu87bQLfMm6aA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IEfjFQ2tYUkYZBffss9Fl9+bkOlII9ZxsAVdaXTOfm9bZO9T68ZCB/7gSp4zGPuv7CxAuC09wVwrW3Vz28AP7h3gge0Eju3HPQk/lER6ZiqDkuXLna78xxf8pG8aFGgftxIxps7MWRDAA3tmbqGpmAfwTbJwZcYAcmU6E4H1Lh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esViMVK1; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-785c11b17b9so46008985a.3
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 08:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707583057; x=1708187857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfCzQFfKap6+el/lmMd9lNFAzqVTC40u6BIkgzCz6yY=;
        b=esViMVK1rWQcjdfLILrDGxKgbuWUfRjvLZ0n+g3mgruwYD+YhM2YwE8RHj6ruzj7ve
         1SSW+q6fZ+HfTiwTWD3Gkrc9XTMvZ3rVkI9IDwBpm3rE76ln+O9EWwtcNpXpli7wY6UJ
         LJ0hvPuOvMZuc9qPKUOu6ZTRcnmSxZx62Qv/qZ/yqMbtbhsLZjBhnd9K85133EoSuZZ+
         OiF2+FZeKYAYNNOQA2WaNKB1Q0AmGoIH2IpX25m9YEtSYqCPk0LfiuP2IqvXu7rAolbR
         00jY92UMxjFGAh5u5AmUyXOE3jzZ/VdT87xwB1Xa1TIOfkH2tMER+bRfhmlCGm9pj3mO
         bneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707583057; x=1708187857;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PfCzQFfKap6+el/lmMd9lNFAzqVTC40u6BIkgzCz6yY=;
        b=Uo50fqG+X3le2fUp226Xc2FiKiGE+fyl5CmEIIwzk9plZkr1S6hLFgldA9eHJ/zBJS
         lKEKTnQv6JcQulVxSOUtNQYUUsTK4dGzVsrzf7e0JpijYsdK6HWRSYmE6F+61+GIGqBM
         tK0kB1n15uQRDB+Vc7kyFVCu0nwu0qwJoZYi0BMZAhLkhHAY1eoimSg3HYlY4kg3DiYk
         2vMl9DyImrDNt6gcMlKFo5KzY2X40DgDMXQeCFtov+JIJDGLSShd/akcgCBZj+jRN8fV
         nQo3w2ki7ijlcwxrCrIPLvPIH4moqWJrv/BQucxBjoKNsKIBaQDTod6MTXchUZLhr/34
         vDKw==
X-Forwarded-Encrypted: i=1; AJvYcCWCMCyK9//YSgKVTiwqRHlU/02G8YD5ui45ZGoL64J5m9bnKMuESg76+MmQFyeR/Q5RdAQr02cyS66uhqVPuh21w7I8biZd
X-Gm-Message-State: AOJu0Yw60a5w8Mo7zoQ5ceI/4LYWjIG4aZ+b1z9/iF0hKeJopBbKJ9kt
	5QFlBB0LXCLtMUvw1KbL4yDgcmc5RBdxL3j7mreHHoaO2AStn873
X-Google-Smtp-Source: AGHT+IF79LHxngyRejlfSU1HEsLP0TCqZ7XYOPzdjjQYOk8ZZH+0WGZhAQ9g6eWKBp5AbMzKACUPQQ==
X-Received: by 2002:a05:620a:b05:b0:785:bd76:88b5 with SMTP id t5-20020a05620a0b0500b00785bd7688b5mr2333916qkg.43.1707583057492;
        Sat, 10 Feb 2024 08:37:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrYk5te+O6DGJ1MM6y33QXNF21LTYU0xRBHt6sNtSqbjS41ozrP2WRsdqv20+87VgNcni6l3zL/rzsHO1+CHum/cWwdvQCM+sp1b5HTTsrMc5s1uLrJQKZeUoZ/50gJ20r6UXyYppz0CN0kpX/MSM8NEpkf6ObenPQty2AzgNkAlZTJyxJZHcY+FIYeoAEgohqyGBdNAYEYyjb+LdnIivpxa4=
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id y6-20020a37e306000000b00783fa567082sm686254qki.71.2024.02.10.08.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 08:37:36 -0800 (PST)
Date: Sat, 10 Feb 2024 11:37:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andy Lutomirski <luto@amacapital.net>
Cc: Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Network Development <netdev@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <65c7a6508c859_77eec294d@willemb.c.googlers.com.notmuch>
In-Reply-To: <afdc2a12-7069-4c68-97d3-cf514233de1c@linux.dev>
References: <CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com>
 <f454d60a-c68e-4fcc-a963-fc5c4503d0ee@linux.dev>
 <CALCETrWu63SB+R8hw-1gZ-fbutXAAFKuWJD-wJ9GejX+p8jhSw@mail.gmail.com>
 <65c54cc9ea70c_1cb6bf29492@willemb.c.googlers.com.notmuch>
 <afdc2a12-7069-4c68-97d3-cf514233de1c@linux.dev>
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

Vadim Fedorenko wrote:
> On 08/02/2024 21:51, Willem de Bruijn wrote:
> > Andy Lutomirski wrote:
> >> On Thu, Feb 8, 2024 at 11:55=E2=80=AFAM Vadim Fedorenko
> >> <vadim.fedorenko@linux.dev> wrote:
> >>>
> >>> On 08/02/2024 18:02, Andy Lutomirski wrote:
> >>>> I=E2=80=99ve been using OPT_ID-style timestamping for years, but f=
or some
> >>>> reason this issue only bit me last week: if sendmsg() fails on a U=
DP
> >>>> or ping socket, sk_tskey is poorly.  It may or may not get increme=
nted
> >>>> by the failed sendmsg().
> > =

> > The intent is indeed to only increment on a successful send.
> > =

> > The implementation is complicated a bit by (1) being a socket level
> > option, thus also supporting SOCK_RAW and (2) MSG_MORE using multiple=

> > send calls to only produce a single datagram and (3) fragmentation
> > producing multiple skbs for a single datagram.
> > =

> > If only SOCK_DGRAM, conceivably we could move this to udp_send_skb,
> > after the skb is created and after the usual error exit paths.
> > =

> > An alternative is in error paths to decrement the counter. This is
> > what we do for MSG_ZEROCOPY references. Unfortunately, with the
> > lockless UDP path, other threads could come inbetween the inc and dec=
,
> > so this is not really workable.
> =

> As I've mentioned before, parallelism with OPT_ID is unpredictable by
> design, I don't believe we have real apps doing this, so I think it's
> better to decrement sk_tskey to have consistent behavior. I can make th=
e
> patch to do it.

Great thanks. Let's see if it can be done without too much churn. This
function is already complex, from combining a lot of optional paths.

> >>> Well, there are several error paths, for sure. For the sockets you
> >>> mention the increment of tskey happens at __ip{,6}_append_data. The=
re
> >>> are 2 different types of failures which can happen after the increm=
ent.
> >>> The first is MTU check fail, another one is memory allocation failu=
res.
> >>> I believe we can move increment to a later position, after MTU chec=
k in
> >>> both functions to avoid first type of problem.
> >>
> >> For reasons that I still haven't deciphered, I'm sporadically gettin=
g
> >> EHOSTUNREACH after the increment.  I can't find anything in the code=

> >> that would cause that, and every time I try to instrument it, it sto=
ps
> >> happening :(  I sendmsg to the same destination several times in rap=
id
> >> succession, and at most one of them will get EHOSTUNREACH.
> > =

> > UDP might fail on ICMP responses. Try sending to a closed port. A few=

> > send calls will succeed, but eventually the send call will refuse to
> > send. The cause is in the IP layer.
> > =

> >>>
> >>>> I can think of at least three ways to improve this:
> >>>>
> >>>> 1. Make it so that the sequence number is genuinely only increment=
ed
> >>>> on success. This may be tedious to implement and may be nearly
> >>>> impossible if there are multiple concurrent sendmsg() calls on the=

> >>>> same socket.
> >>>
> >>> Multiple concurrent sendmsg() should bring a lot of problems on use=
r-
> >>> space side. With current implementation the application has to trac=
k the
> >>> value of tskey to check incoming TX timestamp later. But with paral=
lel
> >>> sendmsg() the app cannot be sure which value is assigned to which c=
all
> >>> even in case of proper track value synchronization. That brings us =
to
> >>> the other solutions if we consider having parallel threads working =
with
> >>> same socket. Or we can simply pretend that it's impossible and then=
 fix
> >>> error path to decrement tskey value.
> >>>>
> >>>> 2. Allow the user program to specify an explicit ID.  cmsg values =
are
> >>>> variable length, so for datagram sockets, extending the
> >>>> SO_TIMESTAMPING cmsg with 64 bits of sequence number to be used fo=
r
> >>>> the TX timestamp on that particular packet might be a nice solutio=
n.
> >>>>
> >>>
> >>> This option can be really useful in case of really parallel work wi=
th
> >>> sockets.
> >>
> >> I personally like this one the best.  Some care would be needed to
> >> allow programs to detect the new functionality.  Any preferred way t=
o
> >> handle it?
> > =

> > Regardless of whether we can fix the existing behavior, I also think
> > this is a worthwhile cmsg. As timestamping is a SOL_SOCKET option, th=
e
> > cmsg should likely also be that, processed in __sock_cmsg_send.
> =

> Do you think about extending inet_cork and sockcm_cookie to provide
> OPT_ID value? If yes, I can give it a try also.

If the above fixes Andy's concern, perhaps that is enough.

The only reason to add yet another interface, would be to allow
concurrent sends to use the same socket. Not sure how realistic that
need is.

As for implementation, since SO_TIMESTAMPING is SOL_SOCKET level,
ideally so is the cmsg. But, then we either have to implement for
all existing protocols that do timestamping. Or at least it is
preferable to fail the system call on protocols that do not support
it. Instead of simply returning success and ignoring the sockopt.




