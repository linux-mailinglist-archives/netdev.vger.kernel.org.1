Return-Path: <netdev+bounces-61284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34940823102
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 17:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DFD1C23AC7
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DD31B292;
	Wed,  3 Jan 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpJC+tPd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397A1B284
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso14827a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 08:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704297996; x=1704902796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOa4bP49x+aHktN5v4DTpJlORPb3sX48BA3/BIO8BSU=;
        b=KpJC+tPd4FVmdV2IGjpgFRQH0GMDIqIgR2w0R7OMC6WefKD8ZKw2m+NS2L4Qd4PcpF
         CCMA02pHGogJE0ByeOhXCyteA8TxF1e8/mcNZig/vyk28R0v07w+NIWpjWoEj6jpQFUn
         Wv4+aWEJRtPtzdQ+TFZyv5eetHtVAVXiXn0J0hWfhxwc7UD/uzEgG4UBPVtP6tmfQUgY
         GBMzUyjxl0hVYP6W3VtSX7bY+t5i8oYThOSq5cLNEoR/mIr+dszZ/eruusmJ4vL1GpYQ
         xs37PUNMxhg5Na/pZ16IppuF5CsaA++9+vO0Ma0hToYm9MS/6YcjLwigytC/9eGCtJLp
         vnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297996; x=1704902796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOa4bP49x+aHktN5v4DTpJlORPb3sX48BA3/BIO8BSU=;
        b=xRSAulBpCuqEPkU/qpjF2ZoXe6OVANcohAfh+RLSyNEyPaCUgJ+bEjrPtFDh5HZ1Hf
         k1ZeXPF1b0yBSG1mNWGiUJOMegavAu3C8ac7uJcBk4V69cLOsm+IfQs1+04Y6MyATvQz
         r1XDKIY2s/DKMql6fp3iKuRzx3CPi9QJAhTDLjB6boUMnzCvNnlzw1QTu5Kv7P2ugRXV
         7utKEHwNFNKRWXfcCcxKdpPfPj4mMol1WKNJTIxK2teGKHrbnkHUyXes92OD5Vrlayae
         M2r4AdtazXACUjoigNP6992sPtx4T2pG8tAWQ5dlsE6H1GG3R0ylsxjlBzLGWLthlvY5
         DNQw==
X-Gm-Message-State: AOJu0YyQQLDEBN3OYpfrt6zBLh3ZwTuLXnM7TAd8VUtnmfb+vuBhRffQ
	NIYSllIK2ioOf/jTJ7SLitKEd/uUk2Dv/FuxMh5WVLW3dYx/
X-Google-Smtp-Source: AGHT+IFquDN4ByM8ojqHHN6yFzbXpGGUIMj/hvAVXdM+XR2o41WDjafT4XdG6exzTvxFeENByE4UdJnjI7EDmrQXhBk=
X-Received: by 2002:a50:9347:0:b0:554:98aa:f75c with SMTP id
 n7-20020a509347000000b0055498aaf75cmr167909eda.5.1704297995819; Wed, 03 Jan
 2024 08:06:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219170017.73902-1-edumazet@google.com> <CADvbK_e+J2nut4Q5NE3oAdUqEDXAFZrecs4zY+CrLE9ob8AtZg@mail.gmail.com>
 <CANn89iJjAPmuT3ynBcoADkTs3e4V3=AY9=D+WDHMntQZ+typUA@mail.gmail.com>
 <CADvbK_c5UJsufA2WwXRrw-X7wf-RQLnpPOV3YcbGBCeiAur65Q@mail.gmail.com>
 <CANn89iKMQqC3u9SqfVP-Dq4Za+nQ331Z4w_KZaEUZrmpLG4UKQ@mail.gmail.com> <CADvbK_fT9-ufQZ1wAh+Zs-0eKJYY__9JhQX_qBo-Fxei5yXnFA@mail.gmail.com>
In-Reply-To: <CADvbK_fT9-ufQZ1wAh+Zs-0eKJYY__9JhQX_qBo-Fxei5yXnFA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jan 2024 17:06:22 +0100
Message-ID: <CANn89iKtwvm-32HYBr7ynV3d_TUV2DFGyPyZMbpYYzE_kkwwQA@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: fix busy polling
To: Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jacob Moroni <jmoroni@google.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 4:14=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wrot=
e:
>
> On Wed, Jan 3, 2024 at 5:51=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Fri, Dec 22, 2023 at 7:34=E2=80=AFPM Xin Long <lucien.xin@gmail.com>=
 wrote:
> > >
> > > On Fri, Dec 22, 2023 at 12:05=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Fri, Dec 22, 2023 at 5:08=E2=80=AFPM Xin Long <lucien.xin@gmail.=
com> wrote:
> > > > >
> > > > > On Tue, Dec 19, 2023 at 12:00=E2=80=AFPM Eric Dumazet <edumazet@g=
oogle.com> wrote:
> > > > > >
> > > > > > Busy polling while holding the socket lock makes litle sense,
> > > > > > because incoming packets wont reach our receive queue.
> > > > > >
> > > > > > Fixes: 8465a5fcd1ce ("sctp: add support for busy polling to sct=
p protocol")
> > > > > > Reported-by: Jacob Moroni <jmoroni@google.com>
> > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > > > > Cc: Xin Long <lucien.xin@gmail.com>
> > > > > > ---
> > > > > >  net/sctp/socket.c | 10 ++++------
> > > > > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > > > > > index 5fb02bbb4b349ef9ab9c2790cccb30fb4c4e897c..6b9fcdb0952a0fe=
599ae5d1d1cc6fa9557a3a3bc 100644
> > > > > > --- a/net/sctp/socket.c
> > > > > > +++ b/net/sctp/socket.c
> > > > > > @@ -2102,6 +2102,10 @@ static int sctp_recvmsg(struct sock *sk,=
 struct msghdr *msg, size_t len,
> > > > > >         if (unlikely(flags & MSG_ERRQUEUE))
> > > > > >                 return inet_recv_error(sk, msg, len, addr_len);
> > > > > >
> > > > > > +       if (sk_can_busy_loop(sk) &&
> > > > > > +           skb_queue_empty_lockless(&sk->sk_receive_queue))
> > > > > > +               sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > > > > > +
> > > > > Here is no any sk_state check, if the SCTP socket(TCP type) has b=
een
> > > > > already closed by peer, will sctp_recvmsg() block here?
> > > >
> > > > Busy polling is only polling the NIC queue, hoping to feed this soc=
ket
> > > > for incoming packets.
> > > OK, will it block if there's no incoming packets on the NIC queue?
> > >
> > > If yes, when sysctl net.core.busy_read=3D1, my concern is:
> > >
> > >      client                server
> > >      -------------------------------
> > >                            listen()
> > >      connect()
> > >                            accept()
> > >      close()
> > >                            recvmsg() <----
> > >
> > > recvmsg() is supposed to return right away as the connection is
> > > already close(). With this patch, will recvmsg() be able to do
> > > that if no more incoming packets in the NIC after close()?
> >
> >
> > Answer is yes for a variety of reasons :
> >
> > net.core.busy_read=3D1 means :
> >
> > Busy poll will happen for
> > 1) at most one usec, and
> I see, never used busy polling, but what if the value is set to a large v=
alue,
> like minutes, I might be just overthinking and no one will do this?
>

No problem, you can look at
https://netdevconf.info/2.1/papers/BusyPollingNextGen.pdf for
a short introduction.

<quote>
Suggested settings are in the 50 to 100 us range
</quote>

> > 2) as long as there is no packet in sk->sk_receive_queue (see
> > sk_busy_loop_end())
> It's likely after being closed by peer, no packet at sk_receive_queue.
>
> >
> > But busy poll is only started on sockets that had established packets.
> I think it won't be told to break when the socket is closed by peer.

This is fine really.

sk_busy_loop_end() works fine as is for UDP/TCP sockets, and it does
not look at sk_state.

Keep in mind polling applications are using recvmsg() 20,000 times per seco=
nd,
there is no point trying to optimize the last call.

>
> >
> > A listener will not engage this because sk->sk_napi_id does not
> > contain a valid NAPI ID.
> >
> >
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > Using more than a lockless read of sk->sk_receive_queue is not real=
ly necessary,
> > > > and racy anyway.
> > > >
> > > > Eliezer Tamir added a check against sk_state for no good reason in
> > > > TCP, my plan is to remove it.
> > > >
> > > > There are other states where it still makes sense to allow busy pol=
ling.
> > > >
> > > >
> > > > >
> > > > > Maybe here it needs a `!(sk->sk_shutdown & RCV_SHUTDOWN)` check,
> > > > > which is set when it's closed by the peer.
> > > >
> > > > See above. Keep this as simple as possible...
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >         lock_sock(sk);
> > > > > >
> > > > > >         if (sctp_style(sk, TCP) && !sctp_sstate(sk, ESTABLISHED=
) &&
> > > > > > @@ -9046,12 +9050,6 @@ struct sk_buff *sctp_skb_recv_datagram(s=
truct sock *sk, int flags, int *err)
> > > > > >                 if (sk->sk_shutdown & RCV_SHUTDOWN)
> > > > > >                         break;
> > > > > >
> > > > > > -               if (sk_can_busy_loop(sk)) {
> > > > > > -                       sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > > > > > -
> > > > > > -                       if (!skb_queue_empty_lockless(&sk->sk_r=
eceive_queue))
> > > > > > -                               continue;
> > > > > > -               }
> > > > > >
> > > > > >                 /* User doesn't want to wait.  */
> > > > > >                 error =3D -EAGAIN;
> > > > > > --
> > > > > > 2.43.0.472.g3155946c3a-goog
> > > > > >

