Return-Path: <netdev+bounces-89538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB3A8AA9BE
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129B01F22C03
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 08:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF054BE0;
	Fri, 19 Apr 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjRue/0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1968E4D131;
	Fri, 19 Apr 2024 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514001; cv=none; b=fbmTEmRU3bOWuuVgqK7GTEWMZpBcc/IclZanyxBPbEwVcykV6NiyZq6wWOwrcQkGAvoI6MHMHjN53LW9gF058MJV/A0Vj3gcYpWrxDprsM7IEjq5lpt6tyL/y9ldLks7qCAeVH2NmKvSdbB3Cp4QqautZV+eG4x2DvLU7l4ZSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514001; c=relaxed/simple;
	bh=XTwnfm/sqlaZlJxN/MVFbKE3NWBojOwpSvveKtQy2Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f42TQ4KAywuQvG1m1zWI3uMR6wxUYt8N9cGausRMaWxw5buCpLznSfiaxaTwuBXWj1MSZH0t02y281Q2M8sdydGl/O5DV1qYmLd8OCNwrskAaHee4kFA6Sg3K0qgHS06k7BgxNSK0Sal0H2rzGCC01dX7iPvQkCfneZSGuYoajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjRue/0A; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso179923866b.2;
        Fri, 19 Apr 2024 01:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713513998; x=1714118798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpH8yxR1dAAX8kI+0z0hIiJFPsZI7NQtWK4IOvFZ1C4=;
        b=IjRue/0AHx1i5dnledMugyFdFXAq+miK2zYxDwQrdWfAvg+0RYoeRhZMFuRoQjaZ2y
         gxXuJvj60AMvIt9XtSEkh9gTUa4zdYNEQs5/LJKH1uSS53c1KHyUzMIA03FmIn+61wFV
         3R8RA/UkJ5Xr1k3+ec9wH+gHEn6nQKdSp4Uxxp1GuN59TNBuiqwpcnEJkM+9hwRAiqE2
         qB+fWdte+8ehmvoWnSMWB0H8TOA+fm9isgd2ViNh1DyKvbfEBYTWKkrXR4D7VKRpffGt
         PxBE1g94aMkhpZxow2PKbxcsoFSkJODLxHQQCGI7D5ehP8mX94ZlSdcfrdwVAUziYQrK
         ogdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713513998; x=1714118798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpH8yxR1dAAX8kI+0z0hIiJFPsZI7NQtWK4IOvFZ1C4=;
        b=xNHCsCQGt0LHiRsyVbvUnJ8a1iBIBgW1qo94JiyRic8fTs95zsfQwiMQCKj7BkmMbp
         j49nhWP/moQoGFtGUKgjSNtQsV51IumnfXnmrMtPKUxPqVXX39ogx2F+pL1Ne6petMx2
         oqEPrGKePhsTUnFFPS3Ezwxtib6GK5WZPhtRRVuBr6SXq6Uw9PBCGMqG3kAIzxWe7uzr
         A80OwC3txUx+2WfAI+ZA4xJdPwb8jiXkdKxqx8/jd+2iE4bNAF8eV73ysQBGyIeGbeVR
         TK7BlRg85Gd8YQSmVgx6uA+H7EXTLWUyI1d39erxnmh3W+4LgdrzFjHpRjQYa6PJ8rWz
         IsIA==
X-Forwarded-Encrypted: i=1; AJvYcCUHaRJVwTn0dizVOYhoEsfxjiQpHnyGHSSrx96CJAcNwPEtldYvaqMCOD9EfJmTXf8iXTsyXhsA0lxIP1kPaixCQD5c/sWowSRMIBuefvpBQ6GDS6caUGNRUU1w/4bZU60xShzOyG44c9vP
X-Gm-Message-State: AOJu0YwkYiU3mZBiyoR1ef0GaLp9+42nVFLQK1bpcP9Tb0VQHQX4qt95
	YL18BhhwxIEMzGLbB+1s3Gqr9WyDwCoD5FIILs43JSHKDCjJWjMj2Du+bj6d9P+98kFfravPhRj
	mehWite7UirRUoEpl2zQgo+148bs=
X-Google-Smtp-Source: AGHT+IFRBMQlloUTfaYbb2pImPH7ZlqroFysI+85pcZQ+0mk5gExk9aUl4Lr0bVlfcQ/9FCBkFh0RulSz3HIbWUj6+4=
X-Received: by 2002:a17:906:584e:b0:a51:e05f:2455 with SMTP id
 h14-20020a170906584e00b00a51e05f2455mr981297ejs.48.1713513998324; Fri, 19 Apr
 2024 01:06:38 -0700 (PDT)
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
 <CAL+tcoAEN-OQeqn3m3zLGUiPZEaoTjz0WHaNL-xm702aot_m-g@mail.gmail.com>
 <CANn89iL9OzD5+Y56F_8Jqyxwa5eDQPaPjhX9Y-Y_b9+bcQE08Q@mail.gmail.com>
 <CAL+tcoBn8RHm8AbwMBJ6FM6PMLLotCwTxSgPS1ABd-_D7uBSxw@mail.gmail.com>
 <CANn89iJ4a5VE-_AV-wVrh9Zpu0yS=jtwJaR_s2cBX7pP_QGQXQ@mail.gmail.com> <CAL+tcoA_eU98hMoWA2UM2LD_fNp=geY0uUfc+4pDnbUCKK6=Ew@mail.gmail.com>
In-Reply-To: <CAL+tcoA_eU98hMoWA2UM2LD_fNp=geY0uUfc+4pDnbUCKK6=Ew@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 16:06:01 +0800
Message-ID: <CAL+tcoBiJgOcVirH1O9Yn0B_4RqCj+e4735wf7uxse57Kqc_vQ@mail.gmail.com>
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

On Fri, Apr 19, 2024 at 4:00=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Apr 19, 2024 at 3:44=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Apr 19, 2024 at 9:29=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Fri, Apr 19, 2024 at 3:02=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Fri, Apr 19, 2024 at 4:31=E2=80=AFAM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > On Fri, Apr 19, 2024 at 7:26=E2=80=AFAM Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > >
> > > > > > > When I said "If you feel the need to put them in a special gr=
oup, this
> > > > > > > is fine by me.",
> > > > > > > this was really about partitioning the existing enum into gro=
ups, if
> > > > > > > you prefer having a group of 'RES reasons'
> > > > > >
> > > > > > Are you suggesting copying what we need from enum skb_drop_reas=
on{} to
> > > > > > enum sk_rst_reason{}? Why not reusing them directly. I have no =
idea
> > > > > > what the side effect of cast conversion itself is?
> > > > >
> > > > > Sorry that I'm writing this email. I'm worried my statement is no=
t
> > > > > that clear, so I write one simple snippet which can help me expla=
in
> > > > > well :)
> > > > >
> > > > > Allow me give NO_SOCKET as an example:
> > > > > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > > > > index e63a3bf99617..2c9f7364de45 100644
> > > > > --- a/net/ipv4/icmp.c
> > > > > +++ b/net/ipv4/icmp.c
> > > > > @@ -767,6 +767,7 @@ void __icmp_send(struct sk_buff *skb_in, int =
type,
> > > > > int code, __be32 info,
> > > > >         if (!fl4.saddr)
> > > > >                 fl4.saddr =3D htonl(INADDR_DUMMY);
> > > > >
> > > > > +       trace_icmp_send(skb_in, type, code);
> > > > >         icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
> > > > >  ende:
> > > > >         ip_rt_put(rt);
> > > > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > > > index 1e650ec71d2f..d5963831280f 100644
> > > > > --- a/net/ipv4/tcp_ipv4.c
> > > > > +++ b/net/ipv4/tcp_ipv4.c
> > > > > @@ -2160,6 +2160,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > > > >  {
> > > > >         struct net *net =3D dev_net(skb->dev);
> > > > >         enum skb_drop_reason drop_reason;
> > > > > +       enum sk_rst_reason rst_reason;
> > > > >         int sdif =3D inet_sdif(skb);
> > > > >         int dif =3D inet_iif(skb);
> > > > >         const struct iphdr *iph;
> > > > > @@ -2355,7 +2356,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > > > >  bad_packet:
> > > > >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> > > > >         } else {
> > > > > -               tcp_v4_send_reset(NULL, skb);
> > > > > +               rst_reason =3D RST_REASON_NO_SOCKET;
> > > > > +               tcp_v4_send_reset(NULL, skb, rst_reason);
> > > > >         }
> > > > >
> > > > >  discard_it:
> > > > >
> > > > > As you can see, we need to add a new 'rst_reason' variable which
> > > > > actually is the same as drop reason. They are the same except for=
 the
> > > > > enum type... Such rst_reasons/drop_reasons are all over the place=
.
> > > > >
> > > > > Eric, if you have a strong preference, I can do it as you said.
> > > > >
> > > > > Well, how about explicitly casting them like this based on the cu=
rrent
> > > > > series. It looks better and clearer and more helpful to people wh=
o is
> > > > > reading codes to understand:
> > > > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > > > index 461b4d2b7cfe..eb125163d819 100644
> > > > > --- a/net/ipv4/tcp_ipv4.c
> > > > > +++ b/net/ipv4/tcp_ipv4.c
> > > > > @@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct s=
k_buff *skb)
> > > > >         return 0;
> > > > >
> > > > >  reset:
> > > > > -       tcp_v4_send_reset(rsk, skb, (u32)reason);
> > > > > +       tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
> > > > >  discard:
> > > > >         kfree_skb_reason(skb, reason);
> > > > >         /* Be careful here. If this function gets more complicate=
d and
> > > >
> > > > It makes no sense to declare an enum sk_rst_reason and then convert=
 it
> > > > to drop_reason
> > > > or vice versa.
> > > >
> > > > Next thing you know, compiler guys will add a new -Woption that wil=
l
> > > > forbid such conversions.
> > > >
> > > > Please add to tcp_v4_send_reset() an skb_drop_reason, not a new enu=
m.
> > >
> > > Ah... It looks like I didn't make myself clear again. Sorry...
> > > Actually I wrote this part many times. My conclusion is that It's not
> > > feasible to do this.
> > >
> > > REASONS:
> > > If we __only__ need to deal with this passive reset in TCP, it's fine=
.
> > > We pass a skb_drop_reason which should also be converted to u32 type
> > > in tcp_v4_send_reset() as you said, it can work. People who use the
> > > trace will see the reason with the 'SKB_DROP_REASON' prefix stripped.
> > >
> > > But we have to deal with other cases. A few questions are listed here=
:
> > > 1) What about tcp_send_active_reset() in TCP/MPTCP? Passing weird dro=
p
> > > reasons? There is no drop reason at all. I think people will get
> > > confused. So I believe we should invent new definitions to cope with
> > > it.
> > > 2) What about the .send_reset callback in the subflow_syn_recv_sock()
> > > in MPTCP? The reasons in MPTCP are only definitions (such as
> > > MPTCP_RST_EUNSPEC). I don't think we can convert them into the enum
> > > skb_drop_reason type.
> > >
> > > So where should we group those various reasons?
> > >
> > > Introducing a new enum is for extension and compatibility for all
> > > kinds of reset reasons.
> > >
> > > What do you think?
> >
> > I will stop repeating myself.
> >
> > enums are not what you think.
> >
> > type safety is there for a reason.
> >
> > Can you show me another place in networking stacks where we cast enums
> > to others ?
>
> No, I've checked this a month ago.
>
> BTW, I don't know the dangers of casting enum types. I know you will

s/will/won't/

> answer it, but I still insist on asking, hoping someone seeing this
> will help me.
>
> Using skb_drop_reason can only deal with the passive reset in TCP. It
> is just one of all kinds of reset cases :(
>
> Forgive me, I cannot come up with a good way to cover all the cases TT
>
> I've tried..Sorry...
>
> If other experts see this thread, please help me. I would appreciate
> it. I have strong interests and feel strong responsibility to
> implement something like this patch series. It can be very useful!!
>
> Thanks again.

