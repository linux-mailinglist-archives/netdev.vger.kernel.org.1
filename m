Return-Path: <netdev+bounces-133151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F8A9951C0
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F50EB28A43
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A71DFE15;
	Tue,  8 Oct 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZjglNPd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DCD1DF995
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397748; cv=none; b=UHmnIC9iJF99hh99A1/6sVZal3V8la2rocXlb3XMySnaCEs3PqqO0AyBoHhSAAy/PJnBRA65ceCtR989eYiupVxhY+oE7CzpKoQ12V0WMrc8XTNfBvrZyprhhYGusAlcG0eS68/Khbc9H7LdvAmxuT/5Fw3XFcuKYcHhAEWjcfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397748; c=relaxed/simple;
	bh=AQV70qMch8hhEtaG44BgcSwH2OpGfzCZIHGwcfPQkvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwUG5eW3HhmJBrgS1IgCshsB1VbEYiHcq8tetOOXALEf0wTlscO7sV6yB3CfyCi9YQufKgFLjWv+PkHfySxQ1T0c7Ngq2LdRFvUdRU0jIE8HzSOhA84SKAEQ3HKiU+xJ9GwhBJVNiQbt/izdGZbwELwNmLRQWzURFdYu3RasmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZjglNPd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9968114422so127635966b.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728397745; x=1729002545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFiC4SJXKBU4ih5rRxQAyTk1/b3JdHl7fhN1gWSDsoA=;
        b=dZjglNPdmU3lbLTZlVlLZmmP+WMODqSiuEZpxP+JPDLwAp9O3jdSIuxImkBON0CQVm
         8cGlZi3/u/5OGzrV4RQPfFkRTyVfQ7jkaGKt//5FpNYemOzz1F1qZ3pCq+9ljV2ewTJP
         EGgHHC5TUrmK2ttIkxIpiuMaMzQnroZ7lciu3tJiOR2HWY9sDjI9jsq2hh7mPe9dRZrv
         btA79HEqkhwWRBtpHEulZBtmsVUqPzmK76+C+CM+pemMjRv/Gl7Eb1PetEgQnoO1P7Xh
         3dTUPDcu9osSly4gm+xc5/pKGbuDWppTNv6b1F/QMIOd7YgqePqGivZ0mGQjbcCb9LQG
         3tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397745; x=1729002545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFiC4SJXKBU4ih5rRxQAyTk1/b3JdHl7fhN1gWSDsoA=;
        b=L+dpSrg6vxLEwPoC6w9gNxmhXABX8ygZebIbALuBst1TDjx9CbIRCjcvfjm56lI37p
         Y8Wsvz39oINwmE3B+yBuVPxTuQiKRivGiAI8kdwajiBxc9klTzur/6aKye80LPDgY9F/
         +zYrqg1i3cYar95VprfDK9HvEgeecMwrBAo+dFDnhB2IkmjMvg/GZIXb7LmMvTfkNAAC
         5nU8O+Md54qsRHIcs9xWt2jbFO3SA/5EiNbQ91NQehUT8dXZgIJ9Z8hGbfO21qNWgFki
         srEFzc1oUdiuQTXsPkqnrxOBln6sdmYYrnTr0dwkHQPLmGsL7GY2y8IGh/iRTaaaLTeX
         PFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV7DLO8nmTSxJBJUE8AHBIk8rliln18XVawgUQRfY7fogEXfo61qKz5HgjsYbxYGpP6WG8Exs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhTUjI4uPykjUKgfHcp1MHqmY3pUkb2jFqAqYdFOMhxDpmstbg
	Nxe4ic4gHGJuscOujO7VDHbEd1mBIK84ZZ1AA/KSnBV6xOYjRLKVeHyj+BwzkrgAb6io2bnqcyP
	zG0x5Qii27IFqtQ+p5U3mDlMLBTlIqZqgk1yH
X-Google-Smtp-Source: AGHT+IEFFudRZvMQQp2jHi91uAj0fRT51bJ/7DDUENc5oBNeJIlIA/kyuwYa9EjUVyQiOUTw8G/ESMex4G/pgRNui98=
X-Received: by 2002:a17:907:94c7:b0:a99:446f:1f1a with SMTP id
 a640c23a62f3a-a99446f1fd0mr1069676366b.35.1728397744759; Tue, 08 Oct 2024
 07:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iKWPDs8UXTu8NU+18DM4XE4wHz=CKeSY2AMoxB7tvLyKw@mail.gmail.com>
 <20241008142125.81471-1-kuniyu@amazon.com>
In-Reply-To: <20241008142125.81471-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Oct 2024 16:28:53 +0200
Message-ID: <CANn89iLUqJrO8VR2PTqNaZOb7Jn_CO1F792ec3cLNfXwgAdyrg@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, martin.lau@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 4:21=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Tue, 8 Oct 2024 11:54:21 +0200
> > On Tue, Oct 8, 2024 at 1:53=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > From: Jakub Kicinski <kuba@kernel.org>
> > > Date: Mon, 7 Oct 2024 16:26:10 -0700
> > > > On Mon, 7 Oct 2024 07:15:57 -0700 Kuniyuki Iwashima wrote:
> > > > > Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handl=
er().
> > > > >
> > > > >   """
> > > > >   We are seeing a use-after-free from a bpf prog attached to
> > > > >   trace_tcp_retransmit_synack. The program passes the req->sk to =
the
> > > > >   bpf_sk_storage_get_tracing kernel helper which does check for n=
ull
> > > > >   before using it.
> > > > >   """
> > > >
> > > > I think this crashes a bunch of selftests, example:
> > > >
> > > > https://netdev-3.bots.linux.dev/vmksft-nf-dbg/results/805581/8-nft-=
queue-sh/stderr
> > >
> > > Oops, sorry, I copy-and-pasted __inet_csk_reqsk_queue_drop()
> > > for different reqsk.  I'll squash the diff below.
> > >
> > > ---8<---
> > > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connecti=
on_sock.c
> > > index 36f03d51356e..433c80dc57d5 100644
> > > --- a/net/ipv4/inet_connection_sock.c
> > > +++ b/net/ipv4/inet_connection_sock.c
> > > @@ -1188,7 +1190,7 @@ static void reqsk_timer_handler(struct timer_li=
st *t)
> > >         }
> > >
> > >  drop:
> > > -       __inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
> > > +       __inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
> > >         reqsk_put(req);
> > >  }
> > >
> > > ---8<---
> > >
> > > Thanks!
> >
> > Just to clarify. In the old times rsk_timer was pinned, right ?
> >
> > 83fccfc3940c4 ("inet: fix potential deadlock in reqsk_queue_unlink()")
> > was fine I think.
> >
> > So the bug was added recently ?
> >
> > Can we give a precise Fixes: tag ?
>
> TIMER_PINNED was used in reqsk_queue_hash_req() in v6.4 mentioned
> by Martin and still used in the latest net-next.
>
> $ git blame -L:reqsk_queue_hash_req net/ipv4/inet_connection_sock.c v6.4
> 079096f103fac (Eric Dumazet             2015-10-02 11:43:32 -0700 1095) s=
tatic void reqsk_queue_hash_req(struct request_sock *req,
> 079096f103fac (Eric Dumazet             2015-10-02 11:43:32 -0700 1096)  =
                                unsigned long timeout)
> fa76ce7328b28 (Eric Dumazet             2015-03-19 19:04:20 -0700 1097) {
> 59f379f9046a9 (Kees Cook                2017-10-16 17:29:19 -0700 1098)  =
       timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
>
> Maybe the connection was localhost, or unlikely but RPS was
> configured after SYN+ACK, or setup like ff46e3b44219 was used ??

I do not really understand the issue.
How a sk can be 'closed' with outstanding request sock ?
They hold a refcount on the listener.

