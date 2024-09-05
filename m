Return-Path: <netdev+bounces-125607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD8E96DE78
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EBE1F22B7B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ECE17ADFF;
	Thu,  5 Sep 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikgqfdNw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A52D529
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550694; cv=none; b=iOqX5D17M35og0tCrCC2UC1IDfqiKBFmFC6wwD/tg8yHzz+O39GkmAhu5JvLu6KugMaqdU7YYYZ1vbxLf4PAG68ijigGePvgxZrfK+x7u+4fngfCRhmtv2j0+xBnFoMzdBSrevXp35zk4g6V+VB3LR7KlvGNifhJm1+yZM/qBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550694; c=relaxed/simple;
	bh=WkiTy5i0wsh8Ta+b7gNKFbmu/W+TkntMx7imXQLyRWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tl5OzV5MiMYe11R5D14XVaj0etJq79vAzKnraUY1XXFK1WzRrJ9yunTlDPzswF9tQvodnDtb6XWhHUMF8VYQJoo5RYCoPCnO/vQyV847eoHF8wzPv/GlNZYvFpWg+Sy1WH9JythgR8rRrkIsxa/5E1igs5V2UQhhr027eEo21sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikgqfdNw; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d4161c398so3741245ab.3
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725550692; x=1726155492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcITvI7aVz2pDdbJpgOm16Q/lMkIHz7L+we1CRdcrrk=;
        b=ikgqfdNwL0W8dcTkTGdRXbNQEHvRqzAhUoCQMzcdrRZkvrMaVxJYJFqj5CmegzVsNs
         RbZVpIdM8UxBjmIQas9+DyAXptDJTH/baqF34RDHwY2cT8gsof+Hbup5UeTuU4f1XVO6
         oiXGwBDkjgZlJnRLPmFW+Ur1pvMEJ5oH9Gn6BX62Gv+DOWQKKE0iOpK5LAbFBQoOpE07
         FFZ8MLsn8gbHwt/7TZPmYvnpVd/+/BrwRyeWydUV1MqlH/84ddUc2Nq7fGjg871kLXvf
         CC7QqoDOibff+407A7J0EO25KXNPd3kz1y8PhvAt/QVpoKsa+bwBwqI6YMSGrRwiaXYM
         NjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725550692; x=1726155492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcITvI7aVz2pDdbJpgOm16Q/lMkIHz7L+we1CRdcrrk=;
        b=H4A+JsolNQtE3tZ3z0Whv1zOfVUHDxEBOQiLOSFa5nP8a6tZJ3X7R7sN0VYUSSssU3
         sx53dCQMIbHoonH9+27A0e1Q/Ix25GF+UrUsAe42fIlz8DLzy/Ui5RM6MBkntIwE/YNl
         tQx22t0gYG1DPdpGkOWsCD+MccDgMIL9eJ0qMiDo1GnmZQlx5reWHC/+nSq6XCBiV9Au
         iUAx5FIOqRGskx5Fq5AddOnyZfeCUzvTE3hhaXI/hNi9jAkY7Y6UiPzMKorGizpXbs8n
         aEgJP58I5KAQB5xbnzxzHz52IM5PX9IS8zg3Ph36SwmkWWU2fINXgjUqoKzuALU/ea73
         spig==
X-Forwarded-Encrypted: i=1; AJvYcCU65b2LUUupm7fMsxZ5wQDeGcFhhuX20UCzIvpgr9H/nDV8QILGD+oLMJFTLIcg7kkrTSGnZnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuT757QyzYAq/r5OELSofWGA+XQwSH1jsx0SFc4gaiwVo9SVYq
	bR+Strw9Fks86GLDH1suBZKnr5nATXx/A6+VACnD9c/0MEfGlzo4TTbuAFtyg4/tuiCNwYl4RKe
	bhVQ4aMxJY3h+I+s0p7sXlovONYo=
X-Google-Smtp-Source: AGHT+IE64ufrO3LN+f07KYAF36FLVbJ8ufCF6q08wLfutQuo4Ko2xQYDUJ5Gd+USi3osJljFICtBv3Nu/HBtwAloeEM=
X-Received: by 2002:a92:c54a:0:b0:376:410b:ae69 with SMTP id
 e9e14a558f8ab-39f4f52cf9bmr222203925ab.15.1725550692189; Thu, 05 Sep 2024
 08:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904113153.2196238-1-vadfed@meta.com> <20240904113153.2196238-3-vadfed@meta.com>
 <3e4add99-6b57-4fe1-9ee1-519c80cf7cf5@linux.dev>
In-Reply-To: <3e4add99-6b57-4fe1-9ee1-519c80cf7cf5@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 23:37:36 +0800
Message-ID: <CAL+tcoAdgoKdRA-n5OdrD47K8_iJpCpaQ-8BGxXgTbFz1pW9nQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/4] net_tstamp: add SCM_TS_OPT_ID for TCP sockets
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Vadim,

On Thu, Sep 5, 2024 at 10:58=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 04/09/2024 12:31, Vadim Fedorenko wrote:
> > TCP sockets have different flow for providing timestamp OPT_ID value.
> > Adjust the code to support SCM_TS_OPT_ID option for TCP sockets.
> >
> > Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> > ---
> >   net/ipv4/tcp.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 8a5680b4e786..5553a8aeee80 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -474,9 +474,10 @@ void tcp_init_sock(struct sock *sk)
> >   }
> >   EXPORT_SYMBOL(tcp_init_sock);
> >
> > -static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> > +static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *so=
ckc)
> >   {
> >       struct sk_buff *skb =3D tcp_write_queue_tail(sk);
> > +     u32 tsflags =3D sockc->tsflags;
> >
> >       if (tsflags && skb) {
> >               struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > @@ -485,8 +486,12 @@ static void tcp_tx_timestamp(struct sock *sk, u16 =
tsflags)
> >               sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
> >               if (tsflags & SOF_TIMESTAMPING_TX_ACK)
> >                       tcb->txstamp_ack =3D 1;
> > -             if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> > -                     shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len=
 - 1;
> > +             if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
> > +                     if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
> > +                             shinfo->tskey =3D sockc->ts_opt_id;
> > +                     else
> > +                             shinfo->tskey =3D TCP_SKB_CB(skb)->seq + =
skb->len - 1;
> > +             }
> >       }
> >   }
> >
> > @@ -1318,7 +1323,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct ms=
ghdr *msg, size_t size)
> >
> >   out:
> >       if (copied) {
> > -             tcp_tx_timestamp(sk, sockc.tsflags);
> > +             tcp_tx_timestamp(sk, &sockc);
> >               tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
> >       }
> >   out_nopush:
>
> Hi Willem,
>
> Unfortunately, these changes are not enough to enable custom OPT_ID for
> TCP sockets. There are some functions which rewrite shinfo->tskey in TCP
> flow:

I was planning to test locally after your new version is posted... Now
I can see the good of a useful selftest from this :)

>
> tcp_skb_collapse_tstamp()
> tcp_fragment_tstamp()
> tcp_gso_tstamp()
>
> I believe the last one breaks tests, but the problem is that there is no
> easy way to provide the flag of constant tskey to it. Only
> shinfo::tx_flags are available at the caller side and we have already
> discussed that we shouldn't use the last bit of this field.
>
> So, how should we deal with the problem? Or is it better to postpone
> support for TCP sockets in this case?

I'm not Willem, but my intuition is to postpone it since this will
make the series much bigger than the previous expectation.

Let Willem decide finally :)

