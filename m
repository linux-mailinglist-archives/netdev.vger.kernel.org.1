Return-Path: <netdev+bounces-61158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C4A822BA1
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 11:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E624A1C21643
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961E518C19;
	Wed,  3 Jan 2024 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/7Zl4Vm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E378218E06
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso10718a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 02:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704279078; x=1704883878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTH9jXfuzRpv+FEDsdwEXGs7Ah78rqB2uZtoBni5dq8=;
        b=K/7Zl4VmALFukwaSqtx04v+kaWiQvyThBJeOgUtScdWyTH4pjggCCosrhnvh3/M1S+
         enT7PYcuhLqptstbrARZNFYbcbe0qObWeCB+TswMSlw9RiGdrnpVetUA0/XLAau7CABO
         H7rKWLohhgmy6AJf8cJ5wbrBwWattEi9uDP12iSLJ8iS7ybgs7fhaA0E0DeI8QkOMWzS
         Bphto8RX5baa4LKKRGMDDNEA5sB0hUnc5GlJQ74ubofwPPtLqHPhhVum8GNSA6C0t6rF
         BI1HJE0VRqL6UcvwlYO1bTLm33clblrxWRAgxQn9ssqZcfgFYhuLnPgdhOCds3J62zYH
         iOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704279078; x=1704883878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTH9jXfuzRpv+FEDsdwEXGs7Ah78rqB2uZtoBni5dq8=;
        b=jBtb9xyMpmiQfGG/RbEOm+Cz0ddbIFu2A/K8a/5GYslkHRZOseG1ijNn02doCn2/Gy
         6gIjwa6fJvlSp+pYXOTsM1hZHlfojbXSFmNpKbVJu4nJ6hl3hcj0bZBt+ZAShw8viKtA
         LLAFLrEW19vJBwVsnA2TddppN5PfeKaDUY4sYBI5mrfTgFm4fzUI3nlKYOe/YgNdwgpt
         PGjI+1sgnbyUbXtvd4zVLRCEpa5srtZWn+FsVyy2KBrWIRdii2HoJ3SLyeHUqFFxj5Hl
         Q8SupiEf0u9d/QQ5hd8DUfQI5+3ihfLpL5Wz0bQ4++Qp+hGTyDTbFt2xJHs5F5GfZPDU
         1QvQ==
X-Gm-Message-State: AOJu0YzQRtf58q53Q2FbztL2zmwPQE7VnEXRUoVm2/zHshtsy+ZDSqRM
	TimiRiuDAfDK0bx+/XTv1rAfXgWaecMC0pp1WcWJaGByiibD
X-Google-Smtp-Source: AGHT+IEAcXvFtc2o/73y+r02Hq5FQGmrVV1jX5GOlemH+If2SzfGRK3QSeL5GP18I5/rS4jQWmpVHCBMjWdVNGe3Rtw=
X-Received: by 2002:a50:9ece:0:b0:554:2501:cc8e with SMTP id
 a72-20020a509ece000000b005542501cc8emr137048edf.6.1704279077975; Wed, 03 Jan
 2024 02:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219170017.73902-1-edumazet@google.com> <CADvbK_e+J2nut4Q5NE3oAdUqEDXAFZrecs4zY+CrLE9ob8AtZg@mail.gmail.com>
 <CANn89iJjAPmuT3ynBcoADkTs3e4V3=AY9=D+WDHMntQZ+typUA@mail.gmail.com> <CADvbK_c5UJsufA2WwXRrw-X7wf-RQLnpPOV3YcbGBCeiAur65Q@mail.gmail.com>
In-Reply-To: <CADvbK_c5UJsufA2WwXRrw-X7wf-RQLnpPOV3YcbGBCeiAur65Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jan 2024 11:51:03 +0100
Message-ID: <CANn89iKMQqC3u9SqfVP-Dq4Za+nQ331Z4w_KZaEUZrmpLG4UKQ@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: fix busy polling
To: Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jacob Moroni <jmoroni@google.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:34=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Fri, Dec 22, 2023 at 12:05=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Fri, Dec 22, 2023 at 5:08=E2=80=AFPM Xin Long <lucien.xin@gmail.com>=
 wrote:
> > >
> > > On Tue, Dec 19, 2023 at 12:00=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > Busy polling while holding the socket lock makes litle sense,
> > > > because incoming packets wont reach our receive queue.
> > > >
> > > > Fixes: 8465a5fcd1ce ("sctp: add support for busy polling to sctp pr=
otocol")
> > > > Reported-by: Jacob Moroni <jmoroni@google.com>
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > > Cc: Xin Long <lucien.xin@gmail.com>
> > > > ---
> > > >  net/sctp/socket.c | 10 ++++------
> > > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > > > index 5fb02bbb4b349ef9ab9c2790cccb30fb4c4e897c..6b9fcdb0952a0fe599a=
e5d1d1cc6fa9557a3a3bc 100644
> > > > --- a/net/sctp/socket.c
> > > > +++ b/net/sctp/socket.c
> > > > @@ -2102,6 +2102,10 @@ static int sctp_recvmsg(struct sock *sk, str=
uct msghdr *msg, size_t len,
> > > >         if (unlikely(flags & MSG_ERRQUEUE))
> > > >                 return inet_recv_error(sk, msg, len, addr_len);
> > > >
> > > > +       if (sk_can_busy_loop(sk) &&
> > > > +           skb_queue_empty_lockless(&sk->sk_receive_queue))
> > > > +               sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > > > +
> > > Here is no any sk_state check, if the SCTP socket(TCP type) has been
> > > already closed by peer, will sctp_recvmsg() block here?
> >
> > Busy polling is only polling the NIC queue, hoping to feed this socket
> > for incoming packets.
> OK, will it block if there's no incoming packets on the NIC queue?
>
> If yes, when sysctl net.core.busy_read=3D1, my concern is:
>
>      client                server
>      -------------------------------
>                            listen()
>      connect()
>                            accept()
>      close()
>                            recvmsg() <----
>
> recvmsg() is supposed to return right away as the connection is
> already close(). With this patch, will recvmsg() be able to do
> that if no more incoming packets in the NIC after close()?


Answer is yes for a variety of reasons :

net.core.busy_read=3D1 means :

Busy poll will happen for
1) at most one usec, and
2) as long as there is no packet in sk->sk_receive_queue (see
sk_busy_loop_end())

But busy poll is only started on sockets that had established packets.

A listener will not engage this because sk->sk_napi_id does not
contain a valid NAPI ID.



>
> Thanks.
>
> >
> > Using more than a lockless read of sk->sk_receive_queue is not really n=
ecessary,
> > and racy anyway.
> >
> > Eliezer Tamir added a check against sk_state for no good reason in
> > TCP, my plan is to remove it.
> >
> > There are other states where it still makes sense to allow busy polling=
.
> >
> >
> > >
> > > Maybe here it needs a `!(sk->sk_shutdown & RCV_SHUTDOWN)` check,
> > > which is set when it's closed by the peer.
> >
> > See above. Keep this as simple as possible...
> >
> >
> > >
> > > Thanks
> > >
> > > >         lock_sock(sk);
> > > >
> > > >         if (sctp_style(sk, TCP) && !sctp_sstate(sk, ESTABLISHED) &&
> > > > @@ -9046,12 +9050,6 @@ struct sk_buff *sctp_skb_recv_datagram(struc=
t sock *sk, int flags, int *err)
> > > >                 if (sk->sk_shutdown & RCV_SHUTDOWN)
> > > >                         break;
> > > >
> > > > -               if (sk_can_busy_loop(sk)) {
> > > > -                       sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > > > -
> > > > -                       if (!skb_queue_empty_lockless(&sk->sk_recei=
ve_queue))
> > > > -                               continue;
> > > > -               }
> > > >
> > > >                 /* User doesn't want to wait.  */
> > > >                 error =3D -EAGAIN;
> > > > --
> > > > 2.43.0.472.g3155946c3a-goog
> > > >

