Return-Path: <netdev+bounces-61272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC1C823046
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FC7285B3E
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E51A715;
	Wed,  3 Jan 2024 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfINWVpP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF481A71F
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5efb0e180f0so41833667b3.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 07:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704294898; x=1704899698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5cX21kqrmTOh5bQYIC33CTlTBLni2x8ztmRE58zXa0=;
        b=LfINWVpPazjBlS2OjtcDLHygTDWGDVK9oX7CpQesKdpgfEX9Z3mOgugwWERNlCN9Bi
         wRVdBtSzfoQGLzS0dlfvDRYTN08u6cRLuZdBOGVUuaDdzYDGHb4sK6zS3vFyjgp4qNus
         tKwhvArr5I+ZcSKKG+n9dJEs5ZFIPKMlTVPTNdpDpJdjDNXFJp4vIYyOgIczORCSAGFo
         AkiYysvIV3krYE5yvn/pgZlnkuR+BTehxRrVePmjFutLm+God7hBmdZ9b3k8NgcB522e
         ceuxvnZxqkWETBoHybxMz52ho2/sIvtzDSWjLZaeFrF0bqe/W11kpELsZTDtzXNyFmHH
         13rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704294898; x=1704899698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5cX21kqrmTOh5bQYIC33CTlTBLni2x8ztmRE58zXa0=;
        b=LbQYXKaKsGyYVvk8Mi3gO4zeg/vRlwoS78XBOqeNA2wN3LC1jhv0o9If1Ho1IKk8hD
         tj9hUeMLfG6rF/HTWACuDV28sGEkVrklTB5/sc+WkTK4din3N5VNhxtys5G57xEjoQ+a
         JlzKkYBMFxW9mURBpA8D0b+w5B2pzSWi2IhNp0EbVfrizgyi1dXRzdShGwhQCsgh9x56
         Y0I7TfuwyatXAYlUh9yNloUUKokR98dq0Q1sNBuoSWZWI2sUbhvzmBZbsJtxT8GGbgob
         r2/zthjG0lavcyUp68eOTp/f6e2KxKwT4W7s4QWVujmoznDW+ehlIlbOSLk/abOud07d
         RUKQ==
X-Gm-Message-State: AOJu0YxLIc3Dz/Sj3RmIDAolr6QlGNr1f9Za5zZVaKhDamYaZAAywPk4
	DT+jG5aRUtCdytAtR8VJlh8MNPuAjEEDumYpo0M=
X-Google-Smtp-Source: AGHT+IGqXpc1yXHFGyDETfZt6YHEXwyL5Urz581XvxlhUHNTIkgAnUrFkAy8LMpUeK+nGjjF/6eaT1OAEGDQ+Nq4awY=
X-Received: by 2002:a0d:dd92:0:b0:5e2:62c0:f18b with SMTP id
 g140-20020a0ddd92000000b005e262c0f18bmr13041397ywe.37.1704294897918; Wed, 03
 Jan 2024 07:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219170017.73902-1-edumazet@google.com> <CADvbK_e+J2nut4Q5NE3oAdUqEDXAFZrecs4zY+CrLE9ob8AtZg@mail.gmail.com>
 <CANn89iJjAPmuT3ynBcoADkTs3e4V3=AY9=D+WDHMntQZ+typUA@mail.gmail.com>
 <CADvbK_c5UJsufA2WwXRrw-X7wf-RQLnpPOV3YcbGBCeiAur65Q@mail.gmail.com> <CANn89iKMQqC3u9SqfVP-Dq4Za+nQ331Z4w_KZaEUZrmpLG4UKQ@mail.gmail.com>
In-Reply-To: <CANn89iKMQqC3u9SqfVP-Dq4Za+nQ331Z4w_KZaEUZrmpLG4UKQ@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 3 Jan 2024 10:14:46 -0500
Message-ID: <CADvbK_fT9-ufQZ1wAh+Zs-0eKJYY__9JhQX_qBo-Fxei5yXnFA@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: fix busy polling
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jacob Moroni <jmoroni@google.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 5:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Dec 22, 2023 at 7:34=E2=80=AFPM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Fri, Dec 22, 2023 at 12:05=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Fri, Dec 22, 2023 at 5:08=E2=80=AFPM Xin Long <lucien.xin@gmail.co=
m> wrote:
> > > >
> > > > On Tue, Dec 19, 2023 at 12:00=E2=80=AFPM Eric Dumazet <edumazet@goo=
gle.com> wrote:
> > > > >
> > > > > Busy polling while holding the socket lock makes litle sense,
> > > > > because incoming packets wont reach our receive queue.
> > > > >
> > > > > Fixes: 8465a5fcd1ce ("sctp: add support for busy polling to sctp =
protocol")
> > > > > Reported-by: Jacob Moroni <jmoroni@google.com>
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > > > Cc: Xin Long <lucien.xin@gmail.com>
> > > > > ---
> > > > >  net/sctp/socket.c | 10 ++++------
> > > > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > > > > index 5fb02bbb4b349ef9ab9c2790cccb30fb4c4e897c..6b9fcdb0952a0fe59=
9ae5d1d1cc6fa9557a3a3bc 100644
> > > > > --- a/net/sctp/socket.c
> > > > > +++ b/net/sctp/socket.c
> > > > > @@ -2102,6 +2102,10 @@ static int sctp_recvmsg(struct sock *sk, s=
truct msghdr *msg, size_t len,
> > > > >         if (unlikely(flags & MSG_ERRQUEUE))
> > > > >                 return inet_recv_error(sk, msg, len, addr_len);
> > > > >
> > > > > +       if (sk_can_busy_loop(sk) &&
> > > > > +           skb_queue_empty_lockless(&sk->sk_receive_queue))
> > > > > +               sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > > > > +
> > > > Here is no any sk_state check, if the SCTP socket(TCP type) has bee=
n
> > > > already closed by peer, will sctp_recvmsg() block here?
> > >
> > > Busy polling is only polling the NIC queue, hoping to feed this socke=
t
> > > for incoming packets.
> > OK, will it block if there's no incoming packets on the NIC queue?
> >
> > If yes, when sysctl net.core.busy_read=3D1, my concern is:
> >
> >      client                server
> >      -------------------------------
> >                            listen()
> >      connect()
> >                            accept()
> >      close()
> >                            recvmsg() <----
> >
> > recvmsg() is supposed to return right away as the connection is
> > already close(). With this patch, will recvmsg() be able to do
> > that if no more incoming packets in the NIC after close()?
>
>
> Answer is yes for a variety of reasons :
>
> net.core.busy_read=3D1 means :
>
> Busy poll will happen for
> 1) at most one usec, and
I see, never used busy polling, but what if the value is set to a large val=
ue,
like minutes, I might be just overthinking and no one will do this?

> 2) as long as there is no packet in sk->sk_receive_queue (see
> sk_busy_loop_end())
It's likely after being closed by peer, no packet at sk_receive_queue.

>
> But busy poll is only started on sockets that had established packets.
I think it won't be told to break when the socket is closed by peer.

>
> A listener will not engage this because sk->sk_napi_id does not
> contain a valid NAPI ID.
>
>
>
> >
> > Thanks.
> >
> > >
> > > Using more than a lockless read of sk->sk_receive_queue is not really=
 necessary,
> > > and racy anyway.
> > >
> > > Eliezer Tamir added a check against sk_state for no good reason in
> > > TCP, my plan is to remove it.
> > >
> > > There are other states where it still makes sense to allow busy polli=
ng.
> > >
> > >
> > > >
> > > > Maybe here it needs a `!(sk->sk_shutdown & RCV_SHUTDOWN)` check,
> > > > which is set when it's closed by the peer.
> > >
> > > See above. Keep this as simple as possible...
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >         lock_sock(sk);
> > > > >
> > > > >         if (sctp_style(sk, TCP) && !sctp_sstate(sk, ESTABLISHED) =
&&
> > > > > @@ -9046,12 +9050,6 @@ struct sk_buff *sctp_skb_recv_datagram(str=
uct sock *sk, int flags, int *err)
> > > > >                 if (sk->sk_shutdown & RCV_SHUTDOWN)
> > > > >                         break;
> > > > >
> > > > > -               if (sk_can_busy_loop(sk)) {
> > > > > -                       sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > > > > -
> > > > > -                       if (!skb_queue_empty_lockless(&sk->sk_rec=
eive_queue))
> > > > > -                               continue;
> > > > > -               }
> > > > >
> > > > >                 /* User doesn't want to wait.  */
> > > > >                 error =3D -EAGAIN;
> > > > > --
> > > > > 2.43.0.472.g3155946c3a-goog
> > > > >

