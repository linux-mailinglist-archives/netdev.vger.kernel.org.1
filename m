Return-Path: <netdev+bounces-33989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E3B7A1244
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 02:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C738281D46
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 00:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C6360;
	Fri, 15 Sep 2023 00:22:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C57E
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 00:22:13 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DBF2102
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 17:22:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so5775829a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 17:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694737331; x=1695342131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoYp6ZQIcavE2pbKryXBIEDWCexfCoGS3L2twCZN9y4=;
        b=H6HtA9EMX21JK0hCfTbD9N2E8Tcgmi2TkQcH+IfyjLTKYzFE98AmDkUuQfMqMdr5NR
         w8JTJLhbVg415TCKevj2HWWEcQG3zMdniAq4Z6TrvyuFM3nAa9XzzaOUxvX+C6Qfk1QZ
         SIm3wv2Dqbrg3XeoHjhx9KL7SKIBeLtChzVsIy0O77WwvbhFcXN7d2LLiyZHWF2crdmM
         HSJRHiXqly4/Chs4ptlqAJKh2Tw4oUD1sBoB71NVgjvmjb62q2or6CmKumu7Yc0+tSf9
         HNmaXCAAKXg+TA/uWRjMMS0qMzIJwr9h1QtZErNtKUsw30AKvgUrX+MsRlomvfL1v+GZ
         2jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694737331; x=1695342131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoYp6ZQIcavE2pbKryXBIEDWCexfCoGS3L2twCZN9y4=;
        b=EsRE03DrgKI8Gm/ApFrR1+UdAIcE30a8lE9MpTXz7+pwS6Wtu+TdSKPJmIpJJJ2MU6
         lPxhEJjUnIqumT0Ymr+z2dfZqQac5SJzVE3WY/CP1kFj86lJsYUecPbvDsiHjoBjBWGq
         7bJbbQMhdMD454sCv2Z1Ef6WsVj/xyTOSNp10187ipvb0kBOmV9HoBo6gawu65RD9a77
         9I+QiR+YlSZjRwNvPpls8fBlJF1BMRVX3UIMLiJbClHA8Betdojrg9jHFG/tVh7k/FGp
         JEMXELIPKaB2VUmjfQK5Lh8bVgtHlBUKhOiSE0YmtnnJC4bQpFyerZuAF82tWEtC7UDO
         rgHw==
X-Gm-Message-State: AOJu0YzB9oV9jC9w2VUi1ztSeSVUDiFj9s+WEGegTLAuRI7pkSfK2hWi
	KC6VJhVwSOkqykgTxPubp9qrhso3QaLls0xOJD0w6cJFmvQIWufZ//V9Xw==
X-Google-Smtp-Source: AGHT+IFCp0d1znE7K1jhQJ2YzkYK9Lt/jqXTi4/1AEZvF+aRN7joSQOfHe7IOgpAfF9ZdHJG2OMq0Bx6vv0LQ/n0b44=
X-Received: by 2002:a17:906:dc8b:b0:96f:9cea:a34d with SMTP id
 cs11-20020a170906dc8b00b0096f9ceaa34dmr4452500ejc.21.1694737330711; Thu, 14
 Sep 2023 17:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912013332.2048422-1-jrife@google.com> <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
 <1ca3ca8a-6185-bc55-de74-53991ffc6f91@iogearbox.net> <CADKFtnTOD2+7B5tH8YMHEnxubiG+Cs+t8EhTft+q51YwxjW9xw@mail.gmail.com>
 <CAF=yD-KKGYhKjxio9om1rz7pPe1uiRgODuXWvoLqrGrRbtWNkA@mail.gmail.com>
 <CADKFtnSgBZcpYBYRwr6WgnS6j9xH+U0W7bxSqt9ge5aumu4QQg@mail.gmail.com>
 <CAF=yD-JW+Gs+EeJk2jknU6ZL0prjRO41Q3EpVTOTpTD8sEOh6A@mail.gmail.com>
 <CADKFtnTzqLw4F2m9+7BxZZW_QKm_QiduMb6to9mU1WAvbo9MWQ@mail.gmail.com>
 <CAF=yD-Lapvy4J748ge8k5v7gUoynDxJPpXKV8rOdgtAw7=_ErQ@mail.gmail.com>
 <b6ed0ef1346363f11ddc7bb1c390a5f03f3a6b89.camel@redhat.com>
 <CADKFtnTWU8L4JSL0hME=tMB7xst4ZoCQJgTt1XvtiP7Pn+7Swg@mail.gmail.com> <CAF=yD-KRbSeTugZ-tQKrY0BuchJeNjr5c=KZ=4QTr-zk9zWbHQ@mail.gmail.com>
In-Reply-To: <CAF=yD-KRbSeTugZ-tQKrY0BuchJeNjr5c=KZ=4QTr-zk9zWbHQ@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Thu, 14 Sep 2023 17:21:59 -0700
Message-ID: <CADKFtnQSK8CxH0ns_xYkEBZqZfjJhwa6bWHCHGFvbpOz1nUAPQ@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, netdev@vger.kernel.org, 
	dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> How about a __kernel_sendmsg that follows the sock_sendmsg API and is
> a thin wrapper exactly for in-kernel callers.

Makes sense. That works for me.

> Good catch. Sounds like it.
> At that point it might be worth splitting into three patches.

Sounds good. I can do

Patch 1: kernel_connect() changes (ready to go)
Patch 2: sock_sendmsg() changes
Patch 3: kernel_bind() changes

-Jordan

On Thu, Sep 14, 2023 at 5:17=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Sep 14, 2023 at 2:41=E2=80=AFPM Jordan Rife <jrife@google.com> wr=
ote:
> >
> > > 1) Swap out calls to sock->ops->connect() with kernel_connect()
> >
> > This is trivial, as expected. I have a patch ready that swaps out all
> > occurrences of sock->ops->connect().
> >
> > > 2) Move the address copy to kernel_sendmsg()
> > > 3) Swap out calls to sock_sendmsg()/sock->ops->sendmsg() with kernel_=
sendmsg()
> >
> > This turns out to be less trivial. kernel_sensmsg() looks to be a
> > special case of sock_sendmsg() with sock_sendmsg() being the more
> > generic of the two:
> >
> > int kernel_sendmsg(struct socket *sock, struct msghdr *msg,
> >   struct kvec *vec, size_t num, size_t size)
> > {
> >   iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size);
> >   return sock_sendmsg(sock, msg);
> > }
> >
> > It populates msg->msg_iter with a kvec whereas most cases I could find
> > where sock_sendmsg() is used are using a bio_vec. Some examples:
> >
> > =3D=3Ddrivers/iscsi/iscsi_tcp.c: iscsi_sw_tcp_xmit_segment()=3D=3D
> > iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, copy);
> >
> > r =3D sock_sendmsg(sk, &msg);
> >
> > =3D=3Dfs/ocfs2/cluster: o2net_sendpage()=3D=3D
> > bvec_set_virt(&bv, virt, size);
> > iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, size);
> >
> > while (1) {
> > msg.msg_flags =3D MSG_DONTWAIT | MSG_SPLICE_PAGES;
> > mutex_lock(&sc->sc_send_lock);
> > ret =3D sock_sendmsg(sc->sc_sock, &msg);
> >
> > =3D=3Dnet/sunrpc/svcsock.c: svc_udp_sendto()=3D=3D
> > iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> > count, 0);
> > err =3D sock_sendmsg(svsk->sk_sock, &msg);
> > if (err =3D=3D -ECONNREFUSED) {
> > /* ICMP error on earlier request. */
> > iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> > count, 0);
> > err =3D sock_sendmsg(svsk->sk_sock, &msg);
> > }
> >
> > Maybe these two types are more interchangeable than I'm thinking, but
> > it seems like it might be simpler to just do the address copy inside
> > sock_sendmsg(). Does this revised plan sound reasonable:
> >
> > 1) Swap out calls to sock->ops->connect() with kernel_connect()
> > 2) Move the address copy to sock_sendmsg()
>
> That also covers normal user code that is already protected.
>
> How about a __kernel_sendmsg that follows the sock_sendmsg API and is
> a thin wrapper exactly for in-kernel callers.
>
> > I also noticed that BPF hooks inside bind() can rewrite the bind
> > address. Should we do something similar for kernel_bind:
> >
> > 1) Add an address copy to kernel_bind()
> > 2) Swap out direct calls to ops->bind() with kernel_bind()
>
> Good catch. Sounds like it.
>
> At that point it might be worth splitting into three patches.
>
> > -Jordan
> >
> > On Thu, Sep 14, 2023 at 1:24=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On Wed, 2023-09-13 at 10:02 -0400, Willem de Bruijn wrote:
> > > > On Tue, Sep 12, 2023 at 5:09=E2=80=AFPM Jordan Rife <jrife@google.c=
om> wrote:
> > > > >
> > > > > > If we take this path, it could be a single patch. The subsystem
> > > > > > maintainers should be CC:ed so that they can (N)ACK it.
> > > > > >
> > > > > > But I do not mean to ask to split it up and test each one separ=
ately.
> > > > > >
> > > > > > The change from sock->ops->connect to kernel_connect is certain=
ly
> > > > > > trivial enough that compile testing should suffice.
> > > > >
> > > > > Ack. Thanks for clarifying.
> > > > >
> > > > > > The only question is whether we should pursue your original pat=
ch and
> > > > > > accept that this will continue, or one that improves the situat=
ion,
> > > > > > but touches more files and thus has a higher risk of merge conf=
licts.
> > > > > >
> > > > > > I'd like to give others some time to chime in. I've given my op=
inion,
> > > > > > but it's only one.
> > > > > >
> > > > > > I'd like to give others some time to chime in. I've given my op=
inion,
> > > > > > but it's only one.
> > > > >
> > > > > Sounds good. I'll wait to hear others' opinions on the best path =
forward.
> > > >
> > > > No other comments so far.
> > > >
> > > > My hunch is that a short list of these changes
> > > >
> > > > ```
> > > > @@ -1328,7 +1328,7 @@ static int kernel_bindconnect(struct socket *=
s,
> > > > struct sockaddr *laddr,
> > > >         if (rv < 0)
> > > >                 return rv;
> > > >
> > > > -       rv =3D s->ops->connect(s, raddr, size, flags);
> > > > +       rv =3D kernel_connect(s, raddr, size, flags);
> > > > ```
> > > >
> > > > is no more invasive than your proposed patch, and gives a more robu=
st outcome.
> > > >
> > > > Please take a stab.
> > >
> > > I'm sorry for the late feedback. For the records, I agree the cleanes=
t
> > > fix described above should be attempted first.
> > >
> > > Thanks,
> > >
> > > Paolo
> > >

