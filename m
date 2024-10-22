Return-Path: <netdev+bounces-137686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A299A9521
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123621C228DF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AFA2233B;
	Tue, 22 Oct 2024 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AukP4SrM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D5768E7
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558065; cv=none; b=Ri2nW1Nx3e/dftx8WKnkdyLdsi3W+fjb73AXIcEt+0bVquYpiVs//jjmae0mXGfddbZUDvwEGPWbAlIndpDkpZiSn5sIRvccD6RaWkIWfX++Zt8qDJWqbdCx57k9BgjX9oT2uk++tfUE49Qd6CM8ck37JSwjipO36RXE08XojGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558065; c=relaxed/simple;
	bh=XHpdcNkcHT5hVImdqZd8CU2eOgVjukUMCcNWABhCtvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3CgFkzhrz26lmZni2NksWoUc3hJ3cJjwhGW1FHneVMzbK09abIc0xON6AHslLGwjxiOl9UIwsAyrsUD//pG4bQTKJblZmQKr9Ewt/Y5ri59IOnp8aOb/RB0LYJCATytf1KVDUY/KgVhjMmkLYUex3XXXIPjSySjN5QHQ2cXY+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AukP4SrM; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3b463e9b0so18396165ab.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 17:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729558063; x=1730162863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJiVEeNIbhp/jZwrHTw90+4ZhCBhTq6usS49IE4DJlo=;
        b=AukP4SrM8dsm82gQLfu70xuamb9qYPK7MQGbgpVLbm+YaHZu1Zo7HrglK9XVNPdl8N
         dhxWecpC858a13eX5RE4LmjCJvEfN/SHxs6DpcYODBDWyv4tKMNHXS8gsw9Az/+h3BuT
         yo5Au8ReHVv27BfAqmxqHrvNOI/gfnbWz4S3rcqHzMe8hJjB28BLDIGX8xRp33UyajqT
         2coxBBipbXK/uPYbYEgZFGTw6hcG2B4qPsCNYcpLWMl9cixg2D2EATbPEdgSQiqhOVqC
         1ht2uPeWdn3BUiLggtXpvc8DVW8V8ld8MkOBhf92d5ZLAot6MaBTNgRG0joGZeNAPwQ6
         YNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729558063; x=1730162863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJiVEeNIbhp/jZwrHTw90+4ZhCBhTq6usS49IE4DJlo=;
        b=Ss+iEY1AFCwPaYgBztdbdvp25f5gC8GTWTOhjo6TkEXHrGHcONSY7Pg2Vn1EIyhUav
         qnVAGy/xcreUnD4WT/EPBoPuinRGJRfqmCuPN1jz6t0x8l0xToEDVltFZzhCanplzJYT
         XMlwHTK9CyUSwvwXBlzIzafXxpSRC1/hqDnRsrm0hj5A3Jf2qYD/VpwkrFpgJdIXOA//
         +NfPjWVvduiwPhGcHIkQBD4KFxp2Quup7i3tvUQWaXGkHkQi9cLT+zwpV6QZMtVJ2xc5
         j+9tyU8aNIS1n0VYz0So/tOyNoOWCStgDanBWmtU9YjC3Gskg6XzYz8DExrm95sE7NN1
         20GQ==
X-Forwarded-Encrypted: i=1; AJvYcCU52vVRwUT5iSTc9BXxyPgIcrVjXOjMP2AUIvIrWOPQ+wzmn76F21NJhW3ZC8JMh4bvFDznfxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhuPG+XEyGD2XpLFTIo4+sVOx9POx8pMYl2vpmWTP09pV4DKk4
	qORS5b6kWzp0eLa/JCnLoFHUkQZ+DYl2BgcKWHUsiQWAALraj3P2E2FMqc8LRsQb0xJTrri8M1F
	hs+rHSYalXcx2eOa0qcp787nkxdg=
X-Google-Smtp-Source: AGHT+IGsNPE5xjQwne0nhyWHwRzJZG7KV9XS1pN+nBClPYQbby5F831LA2BgZyjoK0K6PLLAo631nz3C9ewByDkgLV4=
X-Received: by 2002:a05:6e02:20cc:b0:3a0:9954:a6fa with SMTP id
 e9e14a558f8ab-3a3f405e51emr116409615ab.9.1729558063071; Mon, 21 Oct 2024
 17:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021155245.83122-1-kerneljasonxing@gmail.com>
 <20241021155245.83122-3-kerneljasonxing@gmail.com> <7cc508a4-24d1-428c-bf63-ae5dbcc305bc@kernel.org>
In-Reply-To: <7cc508a4-24d1-428c-bf63-ae5dbcc305bc@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Oct 2024 08:47:06 +0800
Message-ID: <CAL+tcoBJSxnwrh8GeLirKyHjHat1kkP1=uqY26bb-y=OBowyYA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] tcp: add more warn of socket in tcp_send_loss_probe()
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 1:51=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 10/21/24 9:52 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add two fields to print in the helper which here covers tcp_send_loss_p=
robe().
> >
> > Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@=
redhat.com/
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > Cc: Neal Cardwell <ncardwell@google.com>
> > --
> > v2
> > Link:https://lore.kernel.org/all/CAL+tcoAr7RHhaZGV12wYDcPPPaubAqdxMCmy7=
Jujtr8b3+bY=3Dw@mail.gmail.com/
> > 1. use "" instead of NULL in tcp_send_loss_probe()
> > ---
> >  include/net/tcp.h     | 4 +++-
> >  net/ipv4/tcp_output.c | 4 +---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 8b8d94bb1746..78158169e944 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2433,12 +2433,14 @@ void tcp_plb_update_state_upon_rto(struct sock =
*sk, struct tcp_plb_state *plb);
> >  static inline void tcp_warn_once(const struct sock *sk, bool cond, con=
st char *str)
> >  {
> >       WARN_ONCE(cond,
> > -               "%sout:%u sacked:%u lost:%u retrans:%u tlp_high_seq:%u =
sk_state:%u ca_state:%u advmss:%u mss_cache:%u pmtu:%u\n",
> > +               "%scwn:%u out:%u sacked:%u lost:%u retrans:%u tlp_high_=
seq:%u sk_state:%u ca_state:%u mss:%u advmss:%u mss_cache:%u pmtu:%u\n",
> >                 str,
> > +               tcp_snd_cwnd(tcp_sk(sk)),
> >                 tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
> >                 tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> >                 tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> >                 inet_csk(sk)->icsk_ca_state,
> > +               tcp_current_mss((struct sock *)sk),
> >                 tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> >                 inet_csk(sk)->icsk_pmtu_cookie);
> >  }
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 054244ce5117..36562b5fe290 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -2954,9 +2954,7 @@ void tcp_send_loss_probe(struct sock *sk)
> >       }
> >       skb =3D skb_rb_last(&sk->tcp_rtx_queue);
> >       if (unlikely(!skb)) {
> > -             WARN_ONCE(tp->packets_out,
> > -                       "invalid inflight: %u state %u cwnd %u mss %d\n=
",
> > -                       tp->packets_out, sk->sk_state, tcp_snd_cwnd(tp)=
, mss);
> > +             tcp_warn_once(sk, tp->packets_out, "");
>
> you dropped the "invalid inflight: " string for context.

Well, sorry, let me add it back.

>
> >               smp_store_release(&inet_csk(sk)->icsk_pending, 0);
> >               return;
> >       }
>
> Besides the nit:
> Reviewed-by: David Ahern <dsahern@kernel.org>

Thanks.

