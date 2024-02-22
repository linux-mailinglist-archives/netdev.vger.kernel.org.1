Return-Path: <netdev+bounces-73877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F985EF4D
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 03:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A761C21BC9
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B01A11C82;
	Thu, 22 Feb 2024 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAZuxzdr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29C8F77
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708570420; cv=none; b=uTpIauP2hdrR2uNW7RgpkGbFt5cLUy+v5IaSpW+86r8Y+9Ura1qDi8whIQKD8WPO+ug8Ht1dJ4HvhY9vFFGzQkLs6shv+k4ho2hsgKfhqfxzU9Xp2xAkv7810xVVY6l9QgW4eEBd5Vz1DQEYHosI0oR6KH7JZ0KlzHDxz7ew/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708570420; c=relaxed/simple;
	bh=YS+Sx/Y2pwDWebj62VOBl1EdCiVwfi/tSCFdmal0ziw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPFDeW+MlQNyt4e3UEUXO1BYUeHzqT6yvU38UWC3LZO7fQb7hPpKsul+QFtpfHy5cucVRgy7V13sZCF2RXfmxhQvCa/wqGlLdvezPts5DzxcX5DiPKZIPNb71s8fjrY4EV84gh2JA4hyTxia/TmS0GF12kKB+fP3/h6bKE0PKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAZuxzdr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so780510a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708570417; x=1709175217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtazvHGdwdKHNIB4t/LdU9mfvgU+Pomh/XFY6t1LiLY=;
        b=RAZuxzdr65kLc1gTAXYXds/U1X3AexY6tfBLlWtxpgevir+2Kjj8of63DBsFmonU2t
         eZWXMLPxU6snPqV7EfGJk0mMMhugN29KR4P6GmvvTh9CLyIsfC4emfzev8JGlF5Y/SoM
         QW3Q9no6pgSD04fCQ1/ERwqtgvw3MKOtr3f2n/WTGjappU69axGgqhHGhcO3ZqdLKCMi
         Mz26nRONqwWXsnf1ZCT8x7h3N8zDEKEHV+p03tNTao2gvviRDz3sCMsTGau8pNwNZ6me
         4lHH3i2j3uioldlF5eFc9SsiGWv8BQgppa+0S2jHfJQFoWfeopQ6UGQkhl/Nb141F/8v
         1Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708570417; x=1709175217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtazvHGdwdKHNIB4t/LdU9mfvgU+Pomh/XFY6t1LiLY=;
        b=u3HZbHRxs8lXIKirD5i/RaHVy6cdCFnTI+A2QErdqvDt0c1wrFnM123yosNLf9gk8v
         IwSxoAYLd2BCTljpd+u8QwsIjYUIKy5SXtd9g73HwRKgsVg1fb1sZb86xrPTVn1cZdZx
         wC3B3rzKeJhv4lK5PMrxKE2DhfcdCPk2LHCkow++7kvtrJBbnjjoZYep2wKbdJ2U0U4W
         FiAxcm+Z/oUG6J+hYXAK5KWsA75W7nLmmOrJQdQLkm8o9BpoqHluE+GidaK9dEcKUtYv
         O/Vflt/G433sx7FwEAL79wtVRoK2+Iv0jGzlZpVGyn8mslqEc76Fli/XsCXbSt+GcQ31
         ftmg==
X-Forwarded-Encrypted: i=1; AJvYcCXZz2nOLbKiLnL76mNFQCkhrcFnGc472IE470mTvb97cjHsne16hLL+2bWAq0F87KhbGhoynHM+X1GQiSEr02VeGthlYn2C
X-Gm-Message-State: AOJu0YylWGdaSPbaKIzLLRVgTN7E/2oEk0BSlOEaGjENk08vQ8Wg7fvy
	a8uNrnRkb+AN7quWoHEuH1YDYdjoaPtt6HDhnaIUxI131IOnNS/5833f+oVehBY5D7Hk+fw+Qqg
	geVlfuC1Z+OOSChoUxAlNRE5kFps=
X-Google-Smtp-Source: AGHT+IFYcomr6KASIG3Drnx2DO5zCt2VdScK5lPSYSZn0G9+zMAJPSqAJXFhxF5oTVNXCTbWMSRZdaysu1KuA7ZrXsw=
X-Received: by 2002:a05:6402:3783:b0:561:7832:d35 with SMTP id
 et3-20020a056402378300b0056178320d35mr934229edb.15.1708570416597; Wed, 21 Feb
 2024 18:53:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com>
 <20240221025732.68157-4-kerneljasonxing@gmail.com> <CANn89iL-FH6jzoxhyKSMioj-zdBsHqNpR7YTGz8ytM=FZSGrug@mail.gmail.com>
In-Reply-To: <CANn89iL-FH6jzoxhyKSMioj-zdBsHqNpR7YTGz8ytM=FZSGrug@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 22 Feb 2024 10:52:59 +0800
Message-ID: <CAL+tcoCe1jjXD7357w+3Z8P+jv+rBxwzcZnf0S2-2YMLv=3AYA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 03/11] tcp: use drop reasons in cookie check
 for ipv4
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 5:34=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Feb 21, 2024 at 3:57=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Now it's time to use the prepared definitions to refine this part.
> > Four reasons used might enough for now, I think.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > --
> > v6:
> > Link: https://lore.kernel.org/netdev/20240215210922.19969-1-kuniyu@amaz=
on.com/
> > 1. Not use NOMEM because of MPTCP (Kuniyuki). I chose to use NO_SOCKET =
as
> > an indicator which can be used as three kinds of cases to tell people t=
hat we're
> > unable to get a valid one. It's a relatively general reason like what w=
e did
> > to TCP_FLAGS.
> > Any better ideas/suggestions are welcome :)
> >
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
> > index 38f331da6677..1028429c78a5 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, stru=
ct sk_buff *skb)
> >                 if (IS_ERR(req))
> >                         goto out;
> >         }
> > -       if (!req)
> > +       if (!req) {
> > +               SKB_DR_SET(reason, NO_SOCKET);
> >                 goto out_drop;
> > +       }
> >
> >         ireq =3D inet_rsk(req);
> >
> > @@ -434,8 +436,10 @@ struct sock *cookie_v4_check(struct sock *sk, stru=
ct sk_buff *skb)
> >          */
> >         RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb))=
;
> >
> > -       if (security_inet_conn_request(sk, skb, req))
> > +       if (security_inet_conn_request(sk, skb, req)) {
> > +               SKB_DR_SET(reason, SECURITY_HOOK);
> >                 goto out_free;
> > +       }
> >
> >         tcp_ao_syncookie(sk, skb, req, AF_INET);
> >
> > @@ -452,8 +456,10 @@ struct sock *cookie_v4_check(struct sock *sk, stru=
ct sk_buff *skb)
> >                            ireq->ir_loc_addr, th->source, th->dest, sk-=
>sk_uid);
> >         security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
> >         rt =3D ip_route_output_key(net, &fl4);
> > -       if (IS_ERR(rt))
> > +       if (IS_ERR(rt)) {
> > +               SKB_DR_SET(reason, IP_OUTNOROUTES);
> >                 goto out_free;
> > +       }
> >
> >         /* Try to redo what tcp_v4_send_synack did. */
> >         req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(&rt->d=
st, RTAX_WINDOW);
> > @@ -476,10 +482,12 @@ struct sock *cookie_v4_check(struct sock *sk, str=
uct sk_buff *skb)
> >         /* ip_queue_xmit() depends on our flow being setup
> >          * Normal sockets get it right from inet_csk_route_child_sock()
> >          */
> > -       if (ret)
> > +       if (ret) {
> >                 inet_sk(ret)->cork.fl.u.ip4 =3D fl4;
> > -       else
> > +       } else {
> > +               SKB_DR_SET(reason, NO_SOCKET);
> >                 goto out_drop;
> > +       }
>
> You can avoid the else here
>
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index be88bf586ff9ffba2190a1fd60a1ed3ce5f73d06..d56b0e309cfc0a58dcd277881=
fe2b364ab3cc668
> 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -475,8 +475,11 @@ struct sock *cookie_v4_check(struct sock *sk,
> struct sk_buff *skb)
>         /* ip_queue_xmit() depends on our flow being setup
>          * Normal sockets get it right from inet_csk_route_child_sock()
>          */
> -       if (ret)
> -               inet_sk(ret)->cork.fl.u.ip4 =3D fl4;
> +       if (!ret) {
> +               SKB_DR_SET(reason, NO_SOCKET);
> +               goto out_drop;
> +       }
> +       inet_sk(ret)->cork.fl.u.ip4 =3D fl4;
>  out:
>         return ret;
>  out_free:

Thanks for your suggestions. I will update it in the v8 patch.

Thanks,
Jason

