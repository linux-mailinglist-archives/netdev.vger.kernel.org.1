Return-Path: <netdev+bounces-205292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65436AFE139
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115841885949
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FAD26CE3F;
	Wed,  9 Jul 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ne6RIs/e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431C26E71D
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045847; cv=none; b=tJU8IRKGxSTNyARwSyrz4Cf41K8L0pqPCqyEDhjck07xkULQNjTfyt6hFixgTyAV00CIpn0jzGfRaJliHIwNUz9yt4yLSxyZ0PqJ73JheAHY6/TD/o7jfcAgpCNl8h6yUiDwyVi9/4iS97y7wNkQ7tzhwmho8NEMn8ODk8p8zGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045847; c=relaxed/simple;
	bh=RC4GkpUv+Taz17PeqsBYX+pq5QbJ2TAODWHsTMZB3U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCyNsPnjhkUK2eant/fXSLvI8LZImaAsXyARqBUF24frjE74vOng/et5kfMyX+imG45Dq9cxoccALuP/Ac1kE1m/FgiNc/xPk6yick1FL1RO6e7hcpZ+Z0O2bDoRzNzW2eEY/aRrV2qEoCEZE34OZn9teum7riIGmiBnja7hYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ne6RIs/e; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a752944794so57781651cf.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752045845; x=1752650645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10vOjwamYCISQfK4xh+wnC/Gm90jtJ1B3nAUfxM86/0=;
        b=ne6RIs/ePw9NY2RHQhBp1cVRLsJiPs9KW87YkRheK7Gx+j1mRvN+JYIYqr155rXcE8
         Du+VT5aDj0VVwmTNblU9mxW9saUsnjkg2lP2bcQPRmcHsjx1cDE0TLALIRzKWrL6quJH
         qCEAgtsSmfHMF0MEpQxGJcOijrOE/RCZErQKGDORBMjJRGMPehhl5SrkQP9nXH9f8ucX
         D+zGr77bbKv0w2ENnrVo2mfWr3kraeE79obSaj6QeHCpJc5yhdrKG2nCkTRgzQYK1cJp
         I2fEfsvZvVrMyQkeFg+TzCZbUBy0eDUaKxgqxVCDeJnXZhrg5PFO0KjRRzOXv744O7tJ
         b9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752045845; x=1752650645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10vOjwamYCISQfK4xh+wnC/Gm90jtJ1B3nAUfxM86/0=;
        b=K3csB/mtfzI9/bkyRDYokinm9e/cH1g6IIwscA0I7n8FAOnzHmh/cSkKMcnovHbYV9
         YY5r4R3Q4d46Dy5j++s71afS851ZZOwHUyPlzlx27pzYvRkBvrN2TuoR8I+K8OWy9dSD
         123XVjdQ3yZ/PaoqshyLkkMtic5PMIXmHRSC3wKfSUhAXu62dJdjZMKKjAXNVjd53M//
         sI5RC61nq0pQ7ERjCHlZISz8tpUmx19XS6rDRWJ2OE1kaie7MQQbqHKf3EM5avjRyHk9
         5ze4O5s+V825S0JbFccOOe1C1JM/LbBhJenYC7ImfAdzUrAAB2A2wATlxOkoTB8G5Gm1
         yBCw==
X-Forwarded-Encrypted: i=1; AJvYcCUIH7IRQDhD8hUfZFFQ/+Od2ZVA2OfkFj8VaPphua2fviCh0V0jMF4AfWmBCErLecaC7XjRyx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pcdd1x8TVv8XnN4lyPzj/PEYBzkomCEm29XnAvjJUruQhVTI
	vTTC9fExNhd4//u0VMGfWuMz3afeiPX1NW0aOVb8SYWNEGw1203bAw18WlE0UrlyNBm2CCrZe3N
	xMtb39c77fnN9dpnYIw1ysFVZrHHmI0h9cjwggjhWRwDOZr21Y0XHJkj6lXk=
X-Gm-Gg: ASbGncuDIB+IpBD1UjrADl//JdGG9X3LbYtAarR5X3iLyP9RNokECjrlt2uLJ3aZMk8
	b+jVbn5LfB1KKgUMwlcHD1rtbt1XjZjQjGEhAxSdMQf8h9A9yni1nskIQILts/0XpAlvA/Rpdsb
	cM1fn1UrmfqnugqegMW6X/98sbiVaHlDzTQCUkxidGUw==
X-Google-Smtp-Source: AGHT+IHw10ZFGpPafDwTbsaYdtEhkuy/OdMQvnDESXbo81oMo116oNpDNKQ30CSk7rHORrKRIK67HrZ17NiRSz8gxzs=
X-Received: by 2002:a05:622a:211:b0:4a7:5c21:d4d with SMTP id
 d75a77b69052e-4a9dec28dc5mr20843601cf.3.1752045844578; Wed, 09 Jul 2025
 00:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708020642.27838-1-luyun_611@163.com> <CANn89i+6g+VwByu-xeJ-PVuaw8X_yQdC2buB7q=YO5S3MzMTUw@mail.gmail.com>
 <ca2f65f5-0ec3-4bd2-af8b-530b9feff2ca@163.com>
In-Reply-To: <ca2f65f5-0ec3-4bd2-af8b-530b9feff2ca@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Jul 2025 00:23:53 -0700
X-Gm-Features: Ac12FXz_lcFmHHa4REHzQFdRmSeNgxnFxXEe5CJlojOh0DZswFHPzC_S3kOd6rQ
Message-ID: <CANn89iKF8=vT2vxYK1S=7mf6zqfTS5SVUYZG_BH1-6XLwiqV-g@mail.gmail.com>
Subject: Re: [PATCH v2] af_packet: fix soft lockup issue caused by tpacket_snd()
To: luyun <luyun_611@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 11:31=E2=80=AFPM luyun <luyun_611@163.com> wrote:
>
>
> =E5=9C=A8 2025/7/8 15:12, Eric Dumazet =E5=86=99=E9=81=93:
> > On Mon, Jul 7, 2025 at 7:06=E2=80=AFPM Yun Lu <luyun_611@163.com> wrote=
:
> >> From: Yun Lu <luyun@kylinos.cn>
> >>
> >> When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
> >> pending_refcnt to decrement to zero before returning. The pending_refc=
nt
> >> is decremented by 1 when the skb->destructor function is called,
> >> indicating that the skb has been successfully sent and needs to be
> >> destroyed.
> >>
> >> If an error occurs during this process, the tpacket_snd() function wil=
l
> >> exit and return error, but pending_refcnt may not yet have decremented=
 to
> >> zero. Assuming the next send operation is executed immediately, but th=
ere
> >> are no available frames to be sent in tx_ring (i.e., packet_current_fr=
ame
> >> returns NULL), and skb is also NULL, the function will not execute
> >> wait_for_completion_interruptible_timeout() to yield the CPU. Instead,=
 it
> >> will enter a do-while loop, waiting for pending_refcnt to be zero. Eve=
n
> >> if the previous skb has completed transmission, the skb->destructor
> >> function can only be invoked in the ksoftirqd thread (assuming NAPI
> >> threading is enabled). When both the ksoftirqd thread and the tpacket_=
snd
> >> operation happen to run on the same CPU, and the CPU trapped in the
> >> do-while loop without yielding, the ksoftirqd thread will not get
> >> scheduled to run. As a result, pending_refcnt will never be reduced to
> >> zero, and the do-while loop cannot exit, eventually leading to a CPU s=
oft
> >> lockup issue.
> >>
> >> In fact, as long as pending_refcnt is not zero, even if skb is NULL,
> >> wait_for_completion_interruptible_timeout() should be executed to yiel=
d
> >> the CPU, allowing the ksoftirqd thread to be scheduled. Therefore, the
> >> execution condition of this function should be modified to check if
> >> pending_refcnt is not zero.
> >>
> >> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for =
transmit to complete in AF_PACKET")
> >> Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
> >> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> >>
> >> ---
> >> Changes in v2:
> >> - Add a Fixes tag.
> >> - Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun=
_611@163.com/
> >> ---
> >>   net/packet/af_packet.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> >> index 3d43f3eae759..7df96311adb8 100644
> >> --- a/net/packet/af_packet.c
> >> +++ b/net/packet/af_packet.c
> >> @@ -2845,7 +2845,7 @@ static int tpacket_snd(struct packet_sock *po, s=
truct msghdr *msg)
> >>                  ph =3D packet_current_frame(po, &po->tx_ring,
> >>                                            TP_STATUS_SEND_REQUEST);
> >>                  if (unlikely(ph =3D=3D NULL)) {
> >> -                       if (need_wait && skb) {
> >> +                       if (need_wait && packet_read_pending(&po->tx_r=
ing)) {
> >>                                  timeo =3D sock_sndtimeo(&po->sk, msg-=
>msg_flags & MSG_DONTWAIT);
> >>                                  timeo =3D wait_for_completion_interru=
ptible_timeout(&po->skb_completion, timeo);
> >>                                  if (timeo <=3D 0) {
> > packet_read_pending() is super expensive on hosts with 256 cpus (or mor=
e)
> >
> > We are going to call it a second time at the end of the block:
> >
> > do { ...
> > } while (ph !=3D NULL || (need_wait && packet_read_pending(&po->tx_ring=
)...
> >
> > Perhaps we can remove the second one ?
>
> As mentioned in the commit message, the soft lockup issue only occurs
> when tpacket_snd() is called to send,  with the pending_refcnt is
> non-zero, and there are no available packets in the tx_ring.
>
> Therefore, at the first start of the loop, packet_read_pending() only
> needs to be called once. If the return result is already 0, the loop can
> exit directly. Otherwise, wait_for_completion_interruptible_timeout()
> needs to be executed for waiting. Later, this function should only be
> called at the end to check whether the loop can exit.
>
>
> >
> > Also I think there is another problem with the code.
> >
> > We should call sock_sndtimeo() only once, otherwise SO_SNDTIMEO
> > constraint could be way off.
>
> Yes, due to the changes in commit 581073f626e3 ("af_packet: do not call
> packet_read_pending() from tpacket_destruct_skb()"), every time
> tpacket_destruct_skb is executed, the skb_completion is marked as
> completed. When wait_for_completion_interruptible_timeout returns
> completed, the pending_refcnt has not yet been reduced to 0. Therefore,
> when ph is NULL, the wait function may need to be called multiple times
> untill packet_read_pending finally returns 0.
>
>
> I have revised the code (as shown below), and it seems to be more
> reasonable. I also look forward to any better suggestions you may have.
> Thank you!
>
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 7df96311adb8..401ae8f6481b 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2785,7 +2785,9 @@ static int tpacket_snd(struct packet_sock *po,
> struct msghdr *msg)
>          int len_sum =3D 0;
>          int status =3D TP_STATUS_AVAILABLE;
>          int hlen, tlen, copylen =3D 0;
> -       long timeo =3D 0;
> +       long timeo;
> +       unsigned int pending;
> +       bool first =3D true;
>
>          mutex_lock(&po->pg_vec_lock);
>
> @@ -2839,18 +2841,27 @@ static int tpacket_snd(struct packet_sock *po,
> struct msghdr *msg)
>          if ((size_max > dev->mtu + reserve + VLAN_HLEN) && !vnet_hdr_sz)
>                  size_max =3D dev->mtu + reserve + VLAN_HLEN;
>
> +       timeo =3D sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
>          reinit_completion(&po->skb_completion);
>
>          do {
>                  ph =3D packet_current_frame(po, &po->tx_ring,
>                                            TP_STATUS_SEND_REQUEST);
>                  if (unlikely(ph =3D=3D NULL)) {
> -                       if (need_wait &&
> packet_read_pending(&po->tx_ring)) {
> -                               timeo =3D sock_sndtimeo(&po->sk,
> msg->msg_flags & MSG_DONTWAIT);
> -                               timeo =3D
> wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
> -                               if (timeo <=3D 0) {
> -                                       err =3D !timeo ? -ETIMEDOUT :
> -ERESTARTSYS;
> -                                       goto out_put;
> +                       if (need_wait) {
> +                               if (skb =3D=3D NULL && fisrt) {
> +                                       pending =3D
> packet_read_pending(&po->tx_ring);
> +                                       if (!pending)
> +                                               goto out_put;
> +                                       else
> +                                               first =3D false;
> +                               }
> +                               if (skb || pending) {
> +                                       timeo =3D
> wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
> +                                       if (timeo <=3D 0) {
> +                                               err =3D !timeo ?
> -ETIMEDOUT : -ERESTARTSYS;
> +                                               goto out_put;
> +                                       }
>                                  }
>                          }
>                          /* check for additional frames */
>
>
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index f6b1ff883c9318facdcb9c3112b94f0b6e40d504..486ade64bddfddb1af91968=
dbdf70015cfb93eb5
> > 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2785,8 +2785,9 @@ static int tpacket_snd(struct packet_sock *po,
> > struct msghdr *msg)
> >          int len_sum =3D 0;
> >          int status =3D TP_STATUS_AVAILABLE;
> >          int hlen, tlen, copylen =3D 0;
> > -       long timeo =3D 0;
> > +       long timeo;
> >
> > +       timeo =3D sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT)=
;
> >          mutex_lock(&po->pg_vec_lock);
> >
> >          /* packet_sendmsg() check on tx_ring.pg_vec was lockless,
> > @@ -2846,7 +2847,6 @@ static int tpacket_snd(struct packet_sock *po,
> > struct msghdr *msg)
> >                                            TP_STATUS_SEND_REQUEST);
> >                  if (unlikely(ph =3D=3D NULL)) {
> >                          if (need_wait && skb) {
> > -                               timeo =3D sock_sndtimeo(&po->sk,
> > msg->msg_flags & MSG_DONTWAIT);
> >                                  timeo =3D
> > wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
> >                                  if (timeo <=3D 0) {
> >                                          err =3D !timeo ? -ETIMEDOUT :
> > -ERESTARTSYS;
>

Instead of adding two extra variables, you also could reuse ph (set it
to not zero)

Also please split in two different patches, one with the timeo fix alone.

Thanks !

