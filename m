Return-Path: <netdev+bounces-88318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC888A6ADE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00A3B215F6
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B5412B142;
	Tue, 16 Apr 2024 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXA9z89x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B21DFEF
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270312; cv=none; b=aM8w+AEOOU34zrUH5/eZLLEHWCQn+6WmEQosxr/PEvaWbhOLJzfM/t/BAF1ceg3MLuV+0KHsYTgmlxj5logb8lwWl2il7umD8GjoN7ji3i5djVTeofZvtAQM/oNrXAYoifvZ1Bnv3+pGwIC43MGSWvCz170v6jP4/u/Xhd7X/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270312; c=relaxed/simple;
	bh=A3I3UnEi4Jj6XEGZVoebUIPjEFSfASUBccQUwXzsHM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A98tvYGAj+OXQCvrJEnACbVnnTGgEEwbZYysii4i8nWWGpQFn/ismgzsINLxIgf6buqeao6UvI+xO7SPUin5tOzQZkEsvFzmKOpGHtEaVm7FyAMI4L10jsbLeApKbKV96wBW/Z7FHxLidjkXxdL1PIgI8zs5Cyv/olcD/6oGlUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXA9z89x; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a526a200879so285240566b.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713270309; x=1713875109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Iqz3uYB03cZmo9aNBvR/ZOxNMywrtwP/4mJcGIIpN4=;
        b=KXA9z89xEaR++lR61COXJ/scMXnD+ZXCA2eXqqLxe3uukOzOkoU75QwrYyX+s6oXNf
         AOkLlajgQ5LYxZrXacqhJbxYXsaQtAnXIvqOxfaDTsI96m4P3eyQGxTf1XidHfyJcRwb
         Q+9JLkietNTjOyJMoWHiGmOcwC1Kr8pqoy49FwiE8zSdod+8zAKohF+R6Pvsp3Kxvy/Y
         +XOfV91sLvo6k+XTJG8GTDgOvINnMVmW3/qOYRHDMOHiWw710632DB+FS6/IbQzz28XP
         2qAnYtclOWCmbrpOQKRGYwzljXhAwV2V1buHEQ3oX9CEWraHRECI/RYAKQr31Gg2GD6t
         7gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270309; x=1713875109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Iqz3uYB03cZmo9aNBvR/ZOxNMywrtwP/4mJcGIIpN4=;
        b=PrpVXRc95lU2j4X6H42TjBi/feWScQ906p5S+LOjWdj4XH7y6LuUen8+94OBzsWZo4
         wKhJlPH725iefwtdw++8otekS+mOe4r4bizBYj5r71axEp4oAXOq3dJYTIq62Xg49VD7
         HExmbd5kj5F+ig+ypXjn26skkI4T5xFJI8nsGptSwlpJMRO8CgF0WTL9iJ/tY+tguqxo
         g+s1llyoAr4b+LyBNeh8ygoB6wlLiR4BQm9O/rI81ubxFLDJWXJteeNJUE4W99bbUhH5
         1Z6BwfRs4bZgsmIuWN3coaXXhWo6TkPB+XariMNEXcqZ6cxeP+u4F9r9lSSv+ONAAw/T
         imEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJFj5d3QMrDX6U83tQ2vKejbJNZg8l+YcFGG+JmVZtrjEPXMvyXX2aMEyLsYTc/aJIe3TgITsyU6dzrWFsu3F/yxvRuiEa
X-Gm-Message-State: AOJu0YzI3d/3H6ucBwcTM5NH51qiG8DNDXRg2ry1q5Xq4lcjvmWi8/m4
	64/E0JnEOOy907QC9ZQ7HhsI+qFU/D87hkg5Tz/qYPTkcJlWao3+I1uY0n/xquQCBHlQz8mbjMb
	Ef8UArh4VuTpV7HpmVJC1Fbv9rHgKZRSodXk=
X-Google-Smtp-Source: AGHT+IFAlHbB8sWqNMPSyWvDGwR8gagW+jfhM7hArqhN/K9UaYFyybAhAdOI1y0UHIcKye+RvecL9GUppbL71gD+27k=
X-Received: by 2002:a17:907:9717:b0:a51:c88e:e95a with SMTP id
 jg23-20020a170907971700b00a51c88ee95amr9550001ejc.23.1713270308559; Tue, 16
 Apr 2024 05:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
 <20240411115630.38420-5-kerneljasonxing@gmail.com> <CANn89iKbBuEqsjyJ-di3e-cF1zv000YY1HEeYq-Ah5x7nX5ppg@mail.gmail.com>
 <CAL+tcoB=Hr8s+j7Sm8viF-=3aHwhEevZZcpn5ek0RYmNowAtoQ@mail.gmail.com>
In-Reply-To: <CAL+tcoB=Hr8s+j7Sm8viF-=3aHwhEevZZcpn5ek0RYmNowAtoQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Apr 2024 20:24:31 +0800
Message-ID: <CAL+tcoDVFtvg6+Kio9frU5W=2e2n7qrCJkitXUxNjsouAG+iGg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/6] tcp: support rstreason for passive reset
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:45=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, Apr 16, 2024 at 2:34=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Apr 11, 2024 at 1:57=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Reuse the dropreason logic to show the exact reason of tcp reset,
> > > so we don't need to implement those duplicated reset reasons.
> > > This patch replaces all the prior NOT_SPECIFIED reasons.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/ipv4/tcp_ipv4.c | 8 ++++----
> > >  net/ipv6/tcp_ipv6.c | 8 ++++----
> > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > index 441134aebc51..863397c2a47b 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_bu=
ff *skb)
> > >         return 0;
> > >
> > >  reset:
> > > -       tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
> > > +       tcp_v4_send_reset(rsk, skb, (u32)reason);
> > >  discard:
> > >         kfree_skb_reason(skb, reason);
> > >         /* Be careful here. If this function gets more complicated an=
d
> > > @@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >                 } else {
> > >                         drop_reason =3D tcp_child_process(sk, nsk, sk=
b);
> > >                         if (drop_reason) {
> > > -                               tcp_v4_send_reset(nsk, skb, SK_RST_RE=
ASON_NOT_SPECIFIED);
> > > +                               tcp_v4_send_reset(nsk, skb, (u32)drop=
_reason);
> >
> > Are all these casts really needed ?
>
> Not really. If without, the compiler wouldn't complain about it.

The truth is mptcp CI treats it as an error (see link[1]) when I
submitted the V5 patchset but my machine works well. I wonder whether
I should not remove all the casts or ignore the warnings?

[1]: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/870508471=
7/job/23874718134
net/ipv6/tcp_ipv6.c: In function 'tcp_v6_do_rcv':
4148 net/ipv6/tcp_ipv6.c:1683:36: error: implicit conversion from
'enum skb_drop_reason' to 'enum sk_rst_reason'
[-Werror=3Denum-conversion]
4149 1683 | tcp_v6_send_reset(sk, skb, reason);
4150 | ^~~~~~
4151 net/ipv6/tcp_ipv6.c: In function 'tcp_v6_rcv':
4152 net/ipv6/tcp_ipv6.c:1868:61: error: implicit conversion from
'enum skb_drop_reason' to 'enum sk_rst_reason'
[-Werror=3Denum-conversion]
4153 1868 | tcp_v6_send_reset(nsk, skb, drop_reason);
4154 | ^~~~~~~~~~~
4155 net/ipv6/tcp_ipv6.c:1945:46: error: implicit conversion from
'enum skb_drop_reason' to 'enum sk_rst_reason'
[-Werror=3Denum-conversion]
4156 1945 | tcp_v6_send_reset(NULL, skb, drop_reason);
4157 | ^~~~~~~~~~~
4158 net/ipv6/tcp_ipv6.c:2001:44: error: implicit conversion from
'enum skb_drop_reason' to 'enum sk_rst_reason'
[-Werror=3Denum-conversion]
4159 2001 | tcp_v6_send_reset(sk, skb, drop_reason);

Thanks,
Jason

>
> >
> > enum sk_rst_reason is not the same as u32 anyway ?
>
> I will remove the cast in the next version.
>
> Thanks,
> Jason
>
> >
> >
> >
> > >                                 goto discard_and_relse;
> > >                         }
> > >                         sock_put(sk);
> > > @@ -2356,7 +2356,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >  bad_packet:
> > >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> > >         } else {
> > > -               tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIF=
IED);
> > > +               tcp_v4_send_reset(NULL, skb, (u32)drop_reason);
> > >         }
> > >
> > >  discard_it:
> > > @@ -2407,7 +2407,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >                 tcp_v4_timewait_ack(sk, skb);
> > >                 break;
> > >         case TCP_TW_RST:
> > > -               tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIE=
D);
> > > +               tcp_v4_send_reset(sk, skb, (u32)drop_reason);
> > >                 inet_twsk_deschedule_put(inet_twsk(sk));
> > >                 goto discard_it;
> > >         case TCP_TW_SUCCESS:;
> > > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > > index 6cad32430a12..ba9d9ceb7e89 100644
> > > --- a/net/ipv6/tcp_ipv6.c
> > > +++ b/net/ipv6/tcp_ipv6.c
> > > @@ -1678,7 +1678,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_bu=
ff *skb)
> > >         return 0;
> > >
> > >  reset:
> > > -       tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> > > +       tcp_v6_send_reset(sk, skb, (u32)reason);
> > >  discard:
> > >         if (opt_skb)
> > >                 __kfree_skb(opt_skb);
> > > @@ -1864,7 +1864,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct s=
k_buff *skb)
> > >                 } else {
> > >                         drop_reason =3D tcp_child_process(sk, nsk, sk=
b);
> > >                         if (drop_reason) {
> > > -                               tcp_v6_send_reset(nsk, skb, SK_RST_RE=
ASON_NOT_SPECIFIED);
> > > +                               tcp_v6_send_reset(nsk, skb, (u32)drop=
_reason);
> > >                                 goto discard_and_relse;
> > >                         }
> > >                         sock_put(sk);
> > > @@ -1940,7 +1940,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct s=
k_buff *skb)
> > >  bad_packet:
> > >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> > >         } else {
> > > -               tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIF=
IED);
> > > +               tcp_v6_send_reset(NULL, skb, (u32)drop_reason);
> > >         }
> > >
> > >  discard_it:
> > > @@ -1995,7 +1995,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct s=
k_buff *skb)
> > >                 tcp_v6_timewait_ack(sk, skb);
> > >                 break;
> > >         case TCP_TW_RST:
> > > -               tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIE=
D);
> > > +               tcp_v6_send_reset(sk, skb, (u32)drop_reason);
> > >                 inet_twsk_deschedule_put(inet_twsk(sk));
> > >                 goto discard_it;
> > >         case TCP_TW_SUCCESS:
> > > --
> > > 2.37.3
> > >

