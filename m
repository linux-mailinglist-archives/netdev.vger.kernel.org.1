Return-Path: <netdev+bounces-86062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3751D89D661
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568EA1C209E5
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 10:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890F81729;
	Tue,  9 Apr 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/bsoXFH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4281745
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657490; cv=none; b=tfhdDCUVe8P1AK2sIEWZ8pz30wFBcCWZZSKzFP4FwXJyoxyAWVm7SZ5n62+/34K64yz9fMWb+b06eYduVrT1sYRYu7odsMeK846d0GcWpIuWkcrARD/43De39CwWjAQe1cvSz8mbBGQw2bteXERFUD+iOJ0iQuLA1SzbC/PmZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657490; c=relaxed/simple;
	bh=M9cB0/AJTqzsmmzhRYy97t8a2Q0hLM7wGGDVhr1/QXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiPrH2K05BO26yDduma1h1x/XfFBGI1YMZfOypWdTz16DU5iZpNYjRmc3U/Yb4+DVc7OgMLSYIe3Z4fyZxABZ5WcuIZcg/dp10WTbqidcCKSMnzMqKvUp9h/AR/p5Z6UMqoQo/rTM0DQzpbXwRLvjfMmesDMMPLhYsraBfx7ldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/bsoXFH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e67402a3fso11614a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712657486; x=1713262286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVqOud0ne5DqlZUAOPzE/7aP/obK6MlkdUEJ9pdZK3E=;
        b=A/bsoXFHCFuYmY4wfSG16Qd7sxlc6jEvDAaVRKEkJPBuabjacK78YUTQHSxIYEyKtr
         8hPSOdoFhAhtjOeO1za5PJrL3f8cAZoM7n+v4gqNj9L93Q6lLz/PmX4Kj7lImjr95Ga2
         tRtx3PfUFglLuIQIGm7nYLc5eLL/8oPaFoHmUv/Vb2fG2R5yMgSNLmHyKEJnx0zDpkNO
         1q/BGJXIQtggKAvTEemAHzQ3mWCv+dMurrXfS3uq0yPkCWG/3UGx6W1mbCGLjiUdNnFv
         2UOvhvoL9erXetjIN21jJBpLcw+2bVifpJdMID2n9mJxVS8A7O0VmiiP4KoI3jLP9AMI
         ZT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657486; x=1713262286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVqOud0ne5DqlZUAOPzE/7aP/obK6MlkdUEJ9pdZK3E=;
        b=HPclrsSrOMbz5n6+pI0fRfLk0vg5h+86Cdk1YEBO6iJqmjom6Jvj6Rz7/k2vDeuFMr
         pIsxe0J2DjqcFcnjFdRMd3w8eGS0Wxv/8UsvjbrDL3m/EXaWFZQ0+r2yOoQFqP9sdoVF
         V/VtS6FoSnuRFCmhkZNFDnb/MweJ0vMWsUBgY+UX06z+7Ij5d9g8JJguetPmHwCS13FP
         JimaYKJHg1aPx8cziA+V05NxVuKs1PiANeH2z5XvuR/l9aiOMGlws5jF1GV0picDtUTD
         7doReboITJBROyfY3lDieYyQFTveEUu6KkQZseIDuS7TGGzDa5vhC2F9Pz7pLL/B9bA5
         M8ig==
X-Forwarded-Encrypted: i=1; AJvYcCXuSqg4E0OLVx4XD3llaMMoCAEU4ja5h2bN5Fl5PiBZ2fBH24wXmBgeUyZKztcu7BzPFCcg+VbgIyI6zm8DxUySIMCeegl2
X-Gm-Message-State: AOJu0YyKnN1QOGbYv5Rl3P3rP0LHeMdBEAJMJXbMluyxZdHRYP/8RWBI
	8BZ61T9uzRj4eD8AfSwItX4fsmETKDFGzGJzHlC/hq7ZHiO4MpdSYmPQlxc+dLPeWDe1WpmLaiz
	bJFZTqhsK5uifwMQTfxET1l3fiEvbsruKFcZMdZ2bIUcA8RevinMo
X-Google-Smtp-Source: AGHT+IGtNBE8IoEIftbYi44BaR1frjEf4NphRkMoIVciiir+z9JagybDMvzv9Wg+H5U+afQ5Lnx05tW95lg4jSKqKJ4=
X-Received: by 2002:aa7:db46:0:b0:56e:2b00:fcc7 with SMTP id
 n6-20020aa7db46000000b0056e2b00fcc7mr154172edt.0.1712657486294; Tue, 09 Apr
 2024 03:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407093322.3172088-1-edumazet@google.com> <20240407093322.3172088-3-edumazet@google.com>
 <68085c8a84538cacaac991415e4ccc72f45e76c2.camel@redhat.com>
In-Reply-To: <68085c8a84538cacaac991415e4ccc72f45e76c2.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Apr 2024 12:11:12 +0200
Message-ID: <CANn89iLCrjP6wd30mt2Ptjr4=bPT3jzZSxsK+DmMysakvAvv1A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn
 with a per-cpu field
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:58=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Sun, 2024-04-07 at 09:33 +0000, Eric Dumazet wrote:
> > TCP can transform a TIMEWAIT socket into a SYN_RECV one from
> > a SYN packet, and the ISN of the SYNACK packet is normally
> > generated using TIMEWAIT tw_snd_nxt :
> >
> > tcp_timewait_state_process()
> > ...
> >     u32 isn =3D tcptw->tw_snd_nxt + 65535 + 2;
> >     if (isn =3D=3D 0)
> >         isn++;
> >     TCP_SKB_CB(skb)->tcp_tw_isn =3D isn;
> >     return TCP_TW_SYN;
> >
> > This SYN packet also bypasses normal checks against listen queue
> > being full or not.
> >
> > tcp_conn_request()
> > ...
> >        __u32 isn =3D TCP_SKB_CB(skb)->tcp_tw_isn;
> > ...
> >         /* TW buckets are converted to open requests without
> >          * limitations, they conserve resources and peer is
> >          * evidently real one.
> >          */
> >         if ((syncookies =3D=3D 2 || inet_csk_reqsk_queue_is_full(sk)) &=
& !isn) {
> >                 want_cookie =3D tcp_syn_flood_action(sk, rsk_ops->slab_=
name);
> >                 if (!want_cookie)
> >                         goto drop;
> >         }
> >
> > This was using TCP_SKB_CB(skb)->tcp_tw_isn field in skb.
> >
> > Unfortunately this field has been accidentally cleared
> > after the call to tcp_timewait_state_process() returning
> > TCP_TW_SYN.
> >
> > Using a field in TCP_SKB_CB(skb) for a temporary state
> > is overkill.
> >
> > Switch instead to a per-cpu variable.
>
> I guess that pushing the info via a local variable all the way down to
> tcp_conn_request would be cumbersome, and will prevent the fast path
> optimization, right?

Right, I tried two other variants of the fix before coming to this.

One of the issues I had is that packets eventually going through the
socket backlog
can trigger this path, so I would have to carry a local variable in a
lot of paths.

References :

commit 449809a66c1d0b1563dee84493e14bf3104d2d7e    tcp/dccp: block BH
for SYN processing
commit 1ad98e9d1bdf4724c0a8532fabd84bf3c457c2bc    tcp/dccp: fix
lockdep issue when SYN is backlogged

I chose to not care about this tricky case (vs tcp_tw_syn), by making sure
to always leave per-cpu variable cleared after each tcp_conn_request()

This was also a nice way of not having to clear a field/variable for
each incoming
TCP packet :)

>
> > As a bonus, we do not have to clear tcp_tw_isn in TCP receive
> > fast path.
> > It is temporarily set then cleared only in the TCP_TW_SYN dance.
> >
> > Fixes: 4ad19de8774e ("net: tcp6: fix double call of tcp_v6_fill_cb()")
> > Fixes: eeea10b83a13 ("tcp: add tcp_v4_fill_cb()/tcp_v4_restore_cb()")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> [...]
>
> > @@ -2397,6 +2397,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >                       sk =3D sk2;
> >                       tcp_v4_restore_cb(skb);
> >                       refcounted =3D false;
> > +                     __this_cpu_write(tcp_tw_isn, isn);
> >                       goto process;
>
> Unrelated from this patch, but I think the 'process' label could be
> moved down skipping a couple of conditionals. 'sk' is a listener
> socket, checking for TW or SYN_RECV should not be needed, right?

Absolutely !

