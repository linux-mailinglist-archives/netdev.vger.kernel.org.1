Return-Path: <netdev+bounces-89525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0B88AA92F
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367D9281C94
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFBE4087F;
	Fri, 19 Apr 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xch2L+pO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999773FBA3;
	Fri, 19 Apr 2024 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511766; cv=none; b=DycOwco8OcEOJ5/0Mqrpq9GbnRtuitYSuqEZKR2hWDacwWDS4XizBBuyD3kdO26DSg7oBVOWSlWzErcsfuu7SZuyjSwZsbVtu4VrQ+Qv45YONG7m8PAh8SrZkRq36KQEMGKizy+dg5GqwEx8pdG8qyT/WxtsO5GKz13AWyIbiO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511766; c=relaxed/simple;
	bh=YBHXN+EIdeW6vhShWqeOPFESo+pgDUALFZPs/zUslNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLunS0BG0t7LgO/Nblcw7nyowl1mbE9CHgRR/GSXxFDrzo1ROCxmleKvBg43aTvk5/ymGb9qKlwcvCqFMrYFKZApzUYGEddqkFQVeti+/nSSA50hMuCtbxskG7gdHUNTiNdYSgI6Dt/xLo4F/4XmVwp0A2I4BcEeP71Lcpf+POg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xch2L+pO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso2553201a12.1;
        Fri, 19 Apr 2024 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713511763; x=1714116563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtPDD8qDRBcOKC0IiERMndRZmYHeHFoP6rR5g7QQLmw=;
        b=Xch2L+pOrkHYX40BK8WEh6TGkEcUQUeFeNsVlqS0DEkOwpkvBsRaC6MHlXOZgNe7Nh
         ZKUe1hnzdLgK2oZZl+tVkBOVtPYgs9unUj96R4D2/I+nbuMx7QuXfEukKNsejAM4RsJe
         Z+Bq7DwlwoQpZrIhFxh6FfSQe8pM28/sfcWYwY4mfd/te7S+jgoG8YOXA4jQS99JgzEQ
         mWHiNDuEidVf1Wal1llcRKUCSgHgKMkE7jUvNG2oiTN8Ivn7RTPa1wxdIQxoPuuZ8B3K
         a5MiaUiYHSTp6bzoA7EoBk1yPASYZIdR8uNdZN8DXHi0GZejDvvixViyuPyiKFmhoVer
         75DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713511763; x=1714116563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtPDD8qDRBcOKC0IiERMndRZmYHeHFoP6rR5g7QQLmw=;
        b=DFtMp49nRT68zBGKEMyRb5KSHjNE+XDROPkKo2T624Z2NBSIofno0LjuIQRfgb3SYz
         xoLwfOfp+erRXVVWVV3DBOX4Boaad4ANN8Kf1ux5m4xeKH6Nvwy+sb0F6/cXdqBo3SAe
         j3m70LCbOQCv9g9ULLdCMZeGkKeDWjHQAblFrwmevth1tfNtDbfbkwbftBvVQmHzBPCX
         lnPiFlzXfFJ23ec3wq6y6UM1Iio8qfIoVuRsmQoqA8aZB91jbKOoCnPPWH5WLgAL1S/j
         pcq3QdyaG9AbnKDLKAtqQDZ8f14WJ6PjGiiclAp/1q03X3LocAoqWFhMfCA3HTsdQD0L
         A4Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUjeq1Zw87AeDkBr8/w48qlQYFWsKjOjX6rrqH7mpu+7vs307AWB0wBoFxiszvov5FJr/ZXDb2nsgd0wM8qGIP3Bfry3j/MUWbRiy8aYwEIo7XOFGlBpdRT126UkcpKKprQA3h95QeWWBAc
X-Gm-Message-State: AOJu0Yyew4qym4Js3QqiWQrfmGcZbRjRo2T9uWPn3f27cyEi5Ig4YA6W
	/wydZW4wfX9nRpgAF5NGwY2PAS4tHjBopDc6COXsdfBT2Bn/ZGO27N6cXc6NCaCbSa0b+1SnLun
	QWmb3EgSmCQNHbVfjPZV+e1eczkc=
X-Google-Smtp-Source: AGHT+IH192geWnd40dMVNG+Xrm59NNfD0JGJjAFXyttFT12IO5h3wmzbFD/WC9V+arUHok8tZajijrIKuAjYm18pWT4=
X-Received: by 2002:a17:906:2b4b:b0:a51:dd18:bd20 with SMTP id
 b11-20020a1709062b4b00b00a51dd18bd20mr1000803ejg.14.1713511762590; Fri, 19
 Apr 2024 00:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
 <CAL+tcoBV77KmL8_d1PTk8muA6Gg3hPYb99BpAXD9W1RcFsg7Bw@mail.gmail.com>
 <CAL+tcoAEN-OQeqn3m3zLGUiPZEaoTjz0WHaNL-xm702aot_m-g@mail.gmail.com> <CANn89iL9OzD5+Y56F_8Jqyxwa5eDQPaPjhX9Y-Y_b9+bcQE08Q@mail.gmail.com>
In-Reply-To: <CANn89iL9OzD5+Y56F_8Jqyxwa5eDQPaPjhX9Y-Y_b9+bcQE08Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 15:28:45 +0800
Message-ID: <CAL+tcoBn8RHm8AbwMBJ6FM6PMLLotCwTxSgPS1ABd-_D7uBSxw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 3:02=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Apr 19, 2024 at 4:31=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Fri, Apr 19, 2024 at 7:26=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > > When I said "If you feel the need to put them in a special group, t=
his
> > > > is fine by me.",
> > > > this was really about partitioning the existing enum into groups, i=
f
> > > > you prefer having a group of 'RES reasons'
> > >
> > > Are you suggesting copying what we need from enum skb_drop_reason{} t=
o
> > > enum sk_rst_reason{}? Why not reusing them directly. I have no idea
> > > what the side effect of cast conversion itself is?
> >
> > Sorry that I'm writing this email. I'm worried my statement is not
> > that clear, so I write one simple snippet which can help me explain
> > well :)
> >
> > Allow me give NO_SOCKET as an example:
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index e63a3bf99617..2c9f7364de45 100644
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -767,6 +767,7 @@ void __icmp_send(struct sk_buff *skb_in, int type,
> > int code, __be32 info,
> >         if (!fl4.saddr)
> >                 fl4.saddr =3D htonl(INADDR_DUMMY);
> >
> > +       trace_icmp_send(skb_in, type, code);
> >         icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
> >  ende:
> >         ip_rt_put(rt);
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 1e650ec71d2f..d5963831280f 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -2160,6 +2160,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >  {
> >         struct net *net =3D dev_net(skb->dev);
> >         enum skb_drop_reason drop_reason;
> > +       enum sk_rst_reason rst_reason;
> >         int sdif =3D inet_sdif(skb);
> >         int dif =3D inet_iif(skb);
> >         const struct iphdr *iph;
> > @@ -2355,7 +2356,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >  bad_packet:
> >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> >         } else {
> > -               tcp_v4_send_reset(NULL, skb);
> > +               rst_reason =3D RST_REASON_NO_SOCKET;
> > +               tcp_v4_send_reset(NULL, skb, rst_reason);
> >         }
> >
> >  discard_it:
> >
> > As you can see, we need to add a new 'rst_reason' variable which
> > actually is the same as drop reason. They are the same except for the
> > enum type... Such rst_reasons/drop_reasons are all over the place.
> >
> > Eric, if you have a strong preference, I can do it as you said.
> >
> > Well, how about explicitly casting them like this based on the current
> > series. It looks better and clearer and more helpful to people who is
> > reading codes to understand:
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 461b4d2b7cfe..eb125163d819 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >         return 0;
> >
> >  reset:
> > -       tcp_v4_send_reset(rsk, skb, (u32)reason);
> > +       tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
> >  discard:
> >         kfree_skb_reason(skb, reason);
> >         /* Be careful here. If this function gets more complicated and
>
> It makes no sense to declare an enum sk_rst_reason and then convert it
> to drop_reason
> or vice versa.
>
> Next thing you know, compiler guys will add a new -Woption that will
> forbid such conversions.
>
> Please add to tcp_v4_send_reset() an skb_drop_reason, not a new enum.

Ah... It looks like I didn't make myself clear again. Sorry...
Actually I wrote this part many times. My conclusion is that It's not
feasible to do this.

REASONS:
If we __only__ need to deal with this passive reset in TCP, it's fine.
We pass a skb_drop_reason which should also be converted to u32 type
in tcp_v4_send_reset() as you said, it can work. People who use the
trace will see the reason with the 'SKB_DROP_REASON' prefix stripped.

But we have to deal with other cases. A few questions are listed here:
1) What about tcp_send_active_reset() in TCP/MPTCP? Passing weird drop
reasons? There is no drop reason at all. I think people will get
confused. So I believe we should invent new definitions to cope with
it.
2) What about the .send_reset callback in the subflow_syn_recv_sock()
in MPTCP? The reasons in MPTCP are only definitions (such as
MPTCP_RST_EUNSPEC). I don't think we can convert them into the enum
skb_drop_reason type.

So where should we group those various reasons?

Introducing a new enum is for extension and compatibility for all
kinds of reset reasons.

What do you think?

Thanks,
Jason

>
> skb_drop_reason are simply values that are later converted to strings...
>
> So : Do not declare a new enum.

