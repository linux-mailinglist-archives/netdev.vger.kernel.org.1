Return-Path: <netdev+bounces-73876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D1A85EF22
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 03:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B5A1F2235C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342512E40;
	Thu, 22 Feb 2024 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnDrk5jo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEE610A19
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708568766; cv=none; b=ZQPN1ADZqB6g8ehBnKtLlOcZq2juz/e+6ibZ8GEqhp6Q+z0MnCfI9VNGA+Bqhy/1OPqF/mB0RDecO7XRIpS5ciabMS2la++BPVxxHNkJ2WpZgIuWYD5j6+ZrcuWROPfelkzs9QbEXhu8tE6dgEo4mlPbCroCbJiASutCbERrBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708568766; c=relaxed/simple;
	bh=c2031o9jVpVJRbWy7jd8lnA2wM34Ia4tXIatOVQokB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvcyQNcxR4orGinjlHpdWRvHeY55fosiwj+McWyLVnbkXNYPDCjOpJZAJmqabyDrUuhM3GRZ4G7a4pRdB/DJqc844BhznrJhMKTV1Ge8dN95zlYpgnK0+tYrZkBrWJPrbsvx9bsDO7U2mMlYqv8+t5iqJf91ic62WcCEUXVQZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnDrk5jo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso8170277a12.2
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708568763; x=1709173563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlODRkCo/iUbGoTogSK/I1+0VGB0tcRydIHPdfIFX5E=;
        b=cnDrk5jo7pwF0PtwMUcAFj1hwJGiQ9Pz6glTQ8LxAVNRfXFmrEzQ6wz1Ev5eI/UnE5
         x9lT285edQPzn9B2yTnYav8CMKfaZUPOoaChNricm0P5q22pcJ2WCjOK0pj7UQGmWZPX
         HZU/RyUAaXwC6nMffxkoW6Ot0R5XUpfbA64vYZIig2B7g6fa0xUNf0TLbNnBYxXCObj6
         X3E8j2eLbdnBqW+/J8j5k3E6ibslU8vKhyINTYVT6cZ4tgBd+LZF+OmBljovjcqu6H6r
         TTUkCQm6UGRlehdEHRH7hRLV3tZQ3zGel/xQLOfgF6s0pLF/YJtlkozrin/tzdWOTKvZ
         msUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708568763; x=1709173563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlODRkCo/iUbGoTogSK/I1+0VGB0tcRydIHPdfIFX5E=;
        b=Rw9/P5qrXe4O+wMW+8h5hu1KuT9UBSQjX8ONFLU0vk629LZy/+vqBIoz9nCC0ZJrH/
         swH+pQOUA5eraI5dMkyFlJSA56D7KJvQAj0cz/iXVl3RMVMgYNEtnZNBAiKM6tbIgUCz
         YAMohj1ns5gJ6lCp92cw+AOvDpPlNbbRCasqpfcvchltJaHwZcZ25pPaDWz9WWbrs0Bw
         g8nTENRjWgX1QIe48CSudbAkoFxj1BdP0JwdTBnoRiNB8FVXPi54nwM5mK7wWCzY34xt
         hNp7kPNQa6SmSUpxTZ0u+iYi/LbXkeVF83icF2dUpBTrxEfDMmy8v5NQrxmAx4FrbDbd
         nrPw==
X-Forwarded-Encrypted: i=1; AJvYcCWC0uDT/6OOhnKcAPMNbM5kSxG+8ff0Qr9BxFyc+CX85NJo7oLHWfsWHr5JSZpoZE2Vrqynzpa0I3wn7nU0YEafFyRWFjg7
X-Gm-Message-State: AOJu0YwFPg5yRzYU+XvnObZWBHdq8j6DHzZutrrIMNGp7vr5AfQ7L4Sy
	kJ3a/lxovQRKABq+YzIbrhbkYgnsIwnz92uz6DXsQjgeVTDEiacSkPjfrvxHwA1sYuc5W64kI4c
	UF3wc+OyNHRD+32AShl10nIeRAK0=
X-Google-Smtp-Source: AGHT+IGhEAzshh5uT8UVuwPDxvTB0AC/yHon57+tfUNxl6tW0A/H6V41FtH+WWTj/4TkfuigHUfyc9mC/5CLuMulSSc=
X-Received: by 2002:aa7:d504:0:b0:564:3191:f409 with SMTP id
 y4-20020aa7d504000000b005643191f409mr8938449edq.1.1708568762692; Wed, 21 Feb
 2024 18:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com>
 <20240221025732.68157-11-kerneljasonxing@gmail.com> <CANn89iKmaZZSnk5+CCtSH43jeUgRWNQPV4cjc0vpWNT7nHnQQg@mail.gmail.com>
In-Reply-To: <CANn89iKmaZZSnk5+CCtSH43jeUgRWNQPV4cjc0vpWNT7nHnQQg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 22 Feb 2024 10:25:26 +0800
Message-ID: <CAL+tcoB_KP4zrvMT-3rC0xHBDBNtXOTxTQaDhqzRShyyFcA8Eg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 10/11] tcp: make dropreason in
 tcp_child_process() work
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:44=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Feb 21, 2024 at 3:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > It's time to let it work right now. We've already prepared for this:)
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > --
> > v7
> > Link: https://lore.kernel.org/all/20240219043815.98410-1-kuniyu@amazon.=
com/
> > 1. adjust the related part of code only since patch [04/11] is changed.
> > ---
> >  net/ipv4/tcp_ipv4.c | 16 ++++++++++------
> >  net/ipv6/tcp_ipv6.c | 20 +++++++++++++-------
> >  2 files changed, 23 insertions(+), 13 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index c79e25549972..c886c671fae9 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1917,7 +1917,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >                 if (!nsk)
> >                         return 0;
> >                 if (nsk !=3D sk) {
> > -                       if (tcp_child_process(sk, nsk, skb)) {
> > +                       reason =3D tcp_child_process(sk, nsk, skb);
> > +                       if (reason) {
> >                                 rsk =3D nsk;
> >                                 goto reset;
> >                         }
> > @@ -2276,12 +2277,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >                 if (nsk =3D=3D sk) {
> >                         reqsk_put(req);
> >                         tcp_v4_restore_cb(skb);
> > -               } else if (tcp_child_process(sk, nsk, skb)) {
> > -                       tcp_v4_send_reset(nsk, skb);
> > -                       goto discard_and_relse;
> >                 } else {
> > -                       sock_put(sk);
> > -                       return 0;
> > +                       drop_reason =3D tcp_child_process(sk, nsk, skb)=
;
> > +                       if (drop_reason) {
> > +                               tcp_v4_send_reset(nsk, skb);
> > +                               goto discard_and_relse;
> > +                       } else {
>
> No need for else after a goto (or a return)

Thanks, I will do it soon.

>
> > +                               sock_put(sk);
> > +                               return 0;
> > +                       }
> >                 }
> >         }
> >
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 4f8464e04b7f..f260c28e5b18 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1654,8 +1654,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buf=
f *skb)
> >                 struct sock *nsk =3D tcp_v6_cookie_check(sk, skb);
> >
> >                 if (nsk !=3D sk) {
> > -                       if (nsk && tcp_child_process(sk, nsk, skb))
> > -                               goto reset;
> > +                       if (nsk) {
> > +                               reason =3D tcp_child_process(sk, nsk, s=
kb);
> > +                               if (reason)
> > +                                       goto reset;
> > +                       }
> >                         if (opt_skb)
> >                                 __kfree_skb(opt_skb);
> >                         return 0;
> > @@ -1854,12 +1857,15 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct s=
k_buff *skb)
> >                 if (nsk =3D=3D sk) {
> >                         reqsk_put(req);
> >                         tcp_v6_restore_cb(skb);
> > -               } else if (tcp_child_process(sk, nsk, skb)) {
> > -                       tcp_v6_send_reset(nsk, skb);
> > -                       goto discard_and_relse;
> >                 } else {
> > -                       sock_put(sk);
> > -                       return 0;
> > +                       drop_reason =3D tcp_child_process(sk, nsk, skb)=
;
> > +                       if (drop_reason) {
> > +                               tcp_v6_send_reset(nsk, skb);
> > +                               goto discard_and_relse;
> > +                       } else {
>
>
>  Same here

Got it.

>
> > +                               sock_put(sk);
> > +                               return 0;
> > +                       }
> >                 }
> >         }
> >
> > --
> > 2.37.3
> >

