Return-Path: <netdev+bounces-171084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FD6A4B649
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 03:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF04F165918
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 02:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EAB7D07D;
	Mon,  3 Mar 2025 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdl9mHKO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7D7083C
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970421; cv=none; b=A6iDtP91gSu4B1a/w2SZ7GtxsM1JFPOxRKmdRujD2g2sJwY/qsP0Z9QG+6zZQsPbQCGZUVNECOhOvMTVI9N9ajXf+O6ggDq8oZGGlG8mk+Ca3mBj/g2KTUGZTuEEsNgZIUlbpuBy7923oGIimJGvrxrIQQgjf8tEjBczKOz9MzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970421; c=relaxed/simple;
	bh=cY0eDGVYDgt8fPtyxz/QsCgh7R/RkXsPKyDkDh4WK/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlAnKB/Q4DjGOzvgf9VWrF0Q4rYVa137vNR6srx9qOEAxKFZYGcqAH9vLgKaWbmnBLQkpxDaAg+OvOSHveWgad1jdQzNLeN4jVmAcFNLumOSxooCE4nk/UQq4zQ8f43lA3UetbXavmRq6DLqQBRmFrNw8p3DbAlNZlsqyJStp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vdl9mHKO; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d191bfeafbso16435245ab.0
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 18:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740970419; x=1741575219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf1m/lU9wloSvZPcAq8SHWyi0XGyx3065k+PSYT5Cis=;
        b=Vdl9mHKOOzsQUcIDv2KwOa4VT5HXFqT2xeTfm2YCKWY3KRcqZZjSKD12SUMQwrueIG
         bEjqzKWHrXFppZ05fEKReAEBGh9ti8tA3hJTnKth9kSg2ZPwv+6W3yBjJc7Jrn/ALy9V
         pkENqrCyLfP/Mru2nNyXe8/1rHpSF39ElKaCrphi0LW0BnMrjahT40ylFLynxJ6gnEbw
         IKNRhPqtoYVu9FnwUekh9/MbCWChYpzl/7792mBljGkfITGEDr0nmtv1GzQkFqifEEIB
         U7shF6HPoZKgQCmoQnKF98LckpZ0Y6KS7EUl5uFfFQEGu6CtudLFZT6yp+Fe7udP0WLG
         0HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740970419; x=1741575219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf1m/lU9wloSvZPcAq8SHWyi0XGyx3065k+PSYT5Cis=;
        b=Lb64nDogYo+xPPIhfyik+heVqHBCQWxzRccotV8hLRZbl11P6VuoGDaRUHVGH6cK8E
         3V/qvL76ile7+nsvPGySeWkvj9GTygE2py7C5flBMJh8p3WsXRuZzQmIFtFEMmGUp+62
         byir+w2OaEWcFK8v15di+vk2/UHnP3YdY9Irwt5Ud/s1jVvF3Zqdg2VenOk9Q1kBGEOM
         LzF5B5rLn40H1NZfAiEzTd9mJCcCX1o2CnE8slTQhJ0X+P0L6DIexqw6fVyAxdBaxHGP
         D5V8uJGMG8zH3UBFblazg2HuGw4N/0Tgc52Cw/34WHt65UV9KbQMM7oRzHu5xGkGqROC
         t6bA==
X-Forwarded-Encrypted: i=1; AJvYcCUm7eh18EK7dLmcLRkStqGVGLg+5hQ5HvUBPEBXIz5wtNyR4C+OIyvQRbjrUaTBZv5pApXaILM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFsrfjT4ZDVKx+fjvFl04I0oPoBg2VpW31p2flHqtyuB3EUMl
	KlrZEK63Zv1e2N2BBYf1SSbCRP6gRiGfqHwe47garDgRSohRa0tVR4S9krmlTMjSlnlkNX40vOz
	ByP6yvgBQAl7q9j5siDLNC6hs6Hs=
X-Gm-Gg: ASbGncsQrNsSUC5BJacYxWKlQbnPWbuhzj2aii3TEvLYimfjacbUgH3n0oeqrr1mZ1F
	l70RmZ4O/undzqxGlwFKvj2eCRCr+F/psquQx9ok04Ch26OQPx8oyI6I7bVvKRM+Y4OROHwuyWY
	vFuGJxHJGGN5lKrOwNYw5nsddH3w==
X-Google-Smtp-Source: AGHT+IH7P+5MIclwg5PSh5ReW3VL3B9pewG59fxBLVtDnjChyEail+ChpRQNT/dwCuaVIiWsH2UlMwiUInt9fqZIyQ4=
X-Received: by 2002:a05:6e02:10c5:b0:3d3:faad:7c6f with SMTP id
 e9e14a558f8ab-3d3faad7ef0mr43528605ab.5.1740970418776; Sun, 02 Mar 2025
 18:53:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228164904.47511-1-kerneljasonxing@gmail.com> <67c5111ae5754_170775294fe@willemb.c.googlers.com.notmuch>
In-Reply-To: <67c5111ae5754_170775294fe@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Mar 2025 10:53:01 +0800
X-Gm-Features: AQ5f1JoenH5iaVlKm30OYg60LrN0OXz_dT17jXmRGScS12fPWvJpACaOKkPWH08
Message-ID: <CAL+tcoDg1mQ+7DtYNgYomum9o=gzwtrjedYf7VmHud54VfSynQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net-timestamp: support TCP GSO case for a few
 missing flags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ncardwell@google.com, kuniyu@amazon.com, 
	dsahern@kernel.org, willemb@google.com, horms@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 10:17=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > When I read through the TSO codes, I found out that we probably
> > miss initializing the tx_flags of last seg when TSO is turned
> > off,
>
> When falling back onto TCP GSO. Good catch.
>
> This is a fix, so should target net?

After seeing your comment below, I'm not sure if the next version
targets the net branch because SKBTX_BPF flag is not in the net branch.

If target net-net tree, I would add the following:
Fixes: 6b98ec7e882af ("bpf: Add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback")
Fixes: 4ed2d765dfacc ("net-timestamp: TCP timestamping")

>
> > which means at the following points no more timestamp
> > (for this last one) will be generated. There are three flags
> > to be handled in this patch:
> > 1. SKBTX_HW_TSTAMP
> > 2. SKBTX_HW_TSTAMP_USE_CYCLES
>
> Nit: this no longer exists

Right, I wrote on the old branch, sorry.

>
> (But it will affect the upcoming completion timestamp.)
>
> > 3. SKBTX_BPF
> >
> > This patch initializes the tx_flags to SKBTX_ANY_TSTAMP like what
> > the UDP GSO does. But flag like SKBTX_SCHED_TSTAMP is not useful
> > and will not be used in the remaining path since the skb has already
> > passed the QDisc layer.
>
> Unless multiple layers of qdiscs (e.g., bonding or tunneling) and
> GSO is applied on the first layer, and SKBTX_SW_TSTAMP is not
> requested. But SCHED without SW is an unlikely configuration
> Probably best to just drop this.

Got it. I will remove this description.

>
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  net/ipv4/tcp_offload.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > index 2308665b51c5..886582002425 100644
> > --- a/net/ipv4/tcp_offload.c
> > +++ b/net/ipv4/tcp_offload.c
> > @@ -13,12 +13,15 @@
> >  #include <net/tcp.h>
> >  #include <net/protocol.h>
> >
> > -static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
> > +static void tcp_gso_tstamp(struct sk_buff *skb, struct sk_buff *gso_sk=
b,
> >                          unsigned int seq, unsigned int mss)
> >  {
> > +     u32 flags =3D skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP;
> > +     u32 ts_seq =3D skb_shinfo(gso_skb)->tskey;
> > +
> >       while (skb) {
> >               if (before(ts_seq, seq + mss)) {
> > -                     skb_shinfo(skb)->tx_flags |=3D SKBTX_SW_TSTAMP;
> > +                     skb_shinfo(skb)->tx_flags |=3D flags;
> >                       skb_shinfo(skb)->tskey =3D ts_seq;
> >                       return;
> >               }
> > @@ -193,8 +196,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb=
,
> >       th =3D tcp_hdr(skb);
> >       seq =3D ntohl(th->seq);
> >
> > -     if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_SW_TSTAMP))
> > -             tcp_gso_tstamp(segs, skb_shinfo(gso_skb)->tskey, seq, mss=
);
> > +     if (unlikely(skb_shinfo(gso_skb)->tx_flags & (SKBTX_ANY_TSTAMP)))
>
> no need for the extra parentheses

Will correct it.

Thank for the review,
Jason


>
> > +             tcp_gso_tstamp(segs, gso_skb, seq, mss);
> >
> >       newcheck =3D ~csum_fold(csum_add(csum_unfold(th->check), delta));
> >
> > --
> > 2.43.5
> >
>
>

