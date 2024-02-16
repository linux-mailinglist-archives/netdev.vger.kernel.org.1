Return-Path: <netdev+bounces-72256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FDD85736B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 02:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628CE287BB0
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 01:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6295CA64;
	Fri, 16 Feb 2024 01:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9G2/SJC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD35BA2E
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046947; cv=none; b=sLfqOAVqlGpixH8jK95MTQzu4Dm0OzZiey1LQbMl8F8Os9EFbzOZRMLVyGpqWFmtBW/bpuqeRMay2aalJ26OpHM08H1GEaoEC1GaWBnTVd9SZ8AUZ67D+poe9Rm5U7/zJOOqj1CRcMS+gJL5YXrELOSY66FJZYmU/NaE3Z1PJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046947; c=relaxed/simple;
	bh=KWKrGPbh5xjfGBGhOWR56fUZ4FVS5qW3xUvo1uQFybw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCDYGUCatDEjF1TjtaB79gTlvf5J+FZ8YGjuNqCKsL3w/BJvTBT3UBDvvL8o6A1hekHPf/ffjGiTx7Phdu3FI+LIsSa+cSjrbShPVRao/uKLKTxzBo4XzhAmYL+FPFdDX71m7eDjYAWYEDcc/A/FdKiPBVSI07dVL+fKwN4+13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9G2/SJC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d1094b549cso21011311fa.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708046944; x=1708651744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuTIl9svJdT7N337iyzXNButeFVPbL2DjoDHk8c71NU=;
        b=a9G2/SJCoQR/majFwQMBJK0/tvuvL6xFOCAYXZJm0op/s7vAezgRphU5jY1NCQ2b+8
         f3j7tW/sbxmeL0+D7H5cDDN7s0fUhGkqTfVxTkoc1IzkqhW2h5uJzT/P2TfA278I3pvM
         WdD62/DaP/c+rBhXQmZ4FDaNbapoHmvMxjZo0V46L/A4VmO2WfIytlPl90a6yWIUNm9M
         V9c+1+QssT7odx5mcmxrYhv7yMdM+Ws6jq8uCIG6CUtND0S2gCznD4tTpEyi85K+hJS+
         2jhYa4grqQC2ot0tcOdSNRMxQ7xGU+PcvRlxDC/OtJge3Rjyfy95ahPg+iIn51OKU9UV
         Gt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708046944; x=1708651744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuTIl9svJdT7N337iyzXNButeFVPbL2DjoDHk8c71NU=;
        b=mLlTl7Cb5edRl0gL8p5/QRvECgmCSoyNj1EPNeiwzPcgQlDnRteMpFOqcAsNg+AfQd
         D++ih2709hy0BiDxRqFoz3S8W0K2wZPqec/dCW3g+CRwhbA4MN+QF0qrPbX1qD6vMRJ/
         MTQEDya1xtCK6KyLieDc5aUi3gDakNrfY5Xtb7TSE1+Z8ET4Bp61yygylq41BYZu0upd
         CEFeyD68fw7P6yJp/yeFQ3Nc8lbSLJHFK0OVr3p9R3kC7taMd7wCd8ZsnBYq+BIsfhOm
         +EqbKDZPiRW5T7bzVZDfnuch0RjKxQ/JYUIb87TghUlcoeOV8ySc0F9kyCKmD7afRf7q
         pDtA==
X-Forwarded-Encrypted: i=1; AJvYcCXtlSrCHuW0tea4NUl0sdLaao84vBlY3P6tQmOhHSrtP0k6iHaczNAMXTzh5m0HJBp8THBaanVJHz9TocFVzCyDDvatCQSO
X-Gm-Message-State: AOJu0Yzde/lTph7QvM+dZfnhhlhq4kalmx5tNLoGL56irBcWcD9Xlrf7
	dz7pHsu+ADNBYe5Eewj4BgjjP06Jw8C7WPN6jiNefpHcoE6uhDw1OhBlxON7E/nC/ivCBM01gqg
	CvxERR5AACt1xZKd6EUnl9X5MUsI=
X-Google-Smtp-Source: AGHT+IEtLhwzjLw6MfE7OvkNOZMKUjjM5+69fld6mm7lIFkHLzQ7T51Sudn+0628Pk01dpNnF2+Jt2AWf9kv/BWNztc=
X-Received: by 2002:a2e:82d5:0:b0:2d0:a60c:5c36 with SMTP id
 n21-20020a2e82d5000000b002d0a60c5c36mr2414213ljh.21.1708046943530; Thu, 15
 Feb 2024 17:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215012027.11467-4-kerneljasonxing@gmail.com> <20240215210922.19969-1-kuniyu@amazon.com>
In-Reply-To: <20240215210922.19969-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 Feb 2024 09:28:26 +0800
Message-ID: <CAL+tcoDCOJCX8NerEpu_0gxhdPCABADRKSpBAJEXohTXBBqTSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/11] tcp: use drop reasons in cookie check
 for ipv4
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 5:09=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 15 Feb 2024 09:20:19 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Now it's time to use the prepared definitions to refine this part.
> > Four reasons used might enough for now, I think.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > --
> > v5:
> > Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=3DJkneEE=
M=3DnAj-28eNtcOCkwQjw@mail.gmail.com/
> > Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b=
6c@kernel.org/
> > 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one =
(Eric, David)
> > 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allo=
cation (Eric)
> > 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> > ---
> >  net/ipv4/syncookies.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 38f331da6677..aeb61c880fbd 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, stru=
ct sk_buff *skb)
> >               if (IS_ERR(req))
> >                       goto out;
> >       }
> > -     if (!req)
> > +     if (!req) {
> > +             SKB_DR_SET(reason, NOMEM);
>
> NOMEM is not appropriate when mptcp_subflow_init_cookie_req() fails.

Thanks for your careful check. It's true. I didn't check the MPTCP
path about how to handle it.

It also means that what I did to the cookie_v6_check() is also wrong.

[...]
> >       /* Try to redo what tcp_v4_send_synack did. */
> >       req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(&rt->dst=
, RTAX_WINDOW);
> > @@ -476,10 +482,12 @@ struct sock *cookie_v4_check(struct sock *sk, str=
uct sk_buff *skb)
> >       /* ip_queue_xmit() depends on our flow being setup
> >        * Normal sockets get it right from inet_csk_route_child_sock()
> >        */
> > -     if (ret)
> > +     if (ret) {
> >               inet_sk(ret)->cork.fl.u.ip4 =3D fl4;
> > -     else
> > +     } else {
> > +             SKB_DR_SET(reason, NO_SOCKET);
>
> This also seems wrong to me.
>
> e.g. syn_recv_sock() could fail with sk_acceptq_is_full(sk),
> then the listener is actually found.

Initially I thought using a not-that-clear name could be helpfull,
though. NO_SOCKET here means no child socket can be used if I add a
new description to SKB_DROP_REASON_NO_SOCKET.

If the idea is proper, how about using NO_SOCKET for the first point
you said to explain that there is no request socket that can be used?

If not, for both of the points you mentioned, it seems I have to add
back those two new reasons (perhaps with a better name updated)?
1. Using SKB_DROP_REASON_REQSK_ALLOC for the first point (request
socket allocation in cookie_v4/6_check())
2. Using SKB_DROP_REASON_GET_SOCK for the second point (child socket
fetching in cookie_v4/6_check())

Now I'm struggling with the name and whether I should introduce some
new reasons like what I did in the old version of the series :S

If someone comes up with a good name or a good way to explain them,
please tell me, thanks!

also cc Eric, David

Thanks,
Jason

>
>
> >               goto out_drop;
> > +     }
> >  out:
> >       return ret;
> >  out_free:
> > --
> > 2.37.3
> >

