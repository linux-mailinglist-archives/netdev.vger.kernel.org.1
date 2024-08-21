Return-Path: <netdev+bounces-120655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B4795A137
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367B0283A83
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5581386DF;
	Wed, 21 Aug 2024 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM+trEPg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF414884E
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253584; cv=none; b=X4X0aP3NYf4bjmuc0ZriIZUoK1Jo0h2GhDS/s9+L0vqv2H3BpdqjHQ1KDnea5uVcIKNFMu/z8is6arpaM4n4IziWGE+arZjeG85YmJIj3Ep7FULyJsod9bJ42TaAo8ICfUmRjUZBSK2onHZXvWBRcREoVoRhvOYoPN5k7a0nGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253584; c=relaxed/simple;
	bh=DABmbJ5xr3+kPxzdPgH1KDbNkWt8A7gTW6ZNALitISM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRO6zHvb1NuxDLDyhK3AyEdliNaKKrpHOgQHvANMnojDYFeUvD598m1IJrF2vSugwDlhDzdzkJZfiUXqkarOkoQtiwgRDqHriIibIJ9CNAEmiR8T7malioxMYripHTPbb51K+4BjtBh5bh3dDYkdprnbHaJKMmFEIvfgE2XQLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM+trEPg; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39d29ba04f2so20472805ab.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724253582; x=1724858382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmAWRsQ+ClmFs3Y1VK+ml/3QqAeWk+oloMwXv5uGD8M=;
        b=mM+trEPgNLdV6tmwz4Vcnnt6AaiwsMiRACzG3Exz3M13MVKstjHE09kmY+naa44h0L
         lIeq7vMr8lCW+42tqlERg7byKOI4qf1dyiBRqC2Iohxs4i4Rv4R6EfhC23KxFWlsO8Bh
         STJnLQlgsPDlcSv50dDQveWiMQI63u8uA0Z/JAPXDCTpIc/KLKDDyvXSvtbMUk7zzNVH
         BvnY29Ya3N6bxBkd3MGOJXYu/EMMsv5ZtBKFe7m6feC0BWluvQeZF0/b2lFxgpB7zYVp
         D3dns9LW5lz+XKE87NBgnqD+NMiOhoA5RzoFT4UeMmjaHlddjvYdwGMu1cAyLjajbfcV
         gkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724253582; x=1724858382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmAWRsQ+ClmFs3Y1VK+ml/3QqAeWk+oloMwXv5uGD8M=;
        b=qr/boFrMlHbsZjK3GgCDU4TuWY0WgA2RL0xYhD5NO+Plc4ay8z5srVz3SFgWs/IQAV
         JVGw9+ac7NM/E12culzd9rSo6IHmBBpN1a0Is5GvjIL+l9owDR2I6JvPUGmcm/4SLhbI
         AYvNHxeRRc03GD9WJoL22Oiar8IlFn0No7i1zJYlfdSu5B5HQh2+baXZNsIbZ6VgZFuB
         V+WeBPnHeiVAA9h/68C4sMOV0+nNyd3aCypNlkY1vWk5ZAbpN3wDX6TOqQFjh4/VZ37T
         S1OCXxfXHaDbMu8xGdH615E7f8GVoJfaH+7F8lXCeReZmRYKd8W3lDcyEYfTwbqowcrQ
         GsLg==
X-Forwarded-Encrypted: i=1; AJvYcCXcsAPHWqxOVMLkMfrrgmXMN1p3wD6vFrh5NL4l6WOfbbnwUDBiYsspAl6MesivvOMt1PnPcng=@vger.kernel.org
X-Gm-Message-State: AOJu0YypWULKxlmHRt0xUVnQa562z8FowFSvKX0XGfLIP4AeektyWZg2
	dIq3xig2YYawJ+4gtjyVQv9XEj5ZH7Cr2YaLDr92/93Dp/qcuRLBX/X00W6OZIjjGedXR7jpB7V
	2arOFL8CZzP6lBq15ydGhCuTaJAc=
X-Google-Smtp-Source: AGHT+IHaFVabeJSgtwoDJUzYGNnHMmfbyIMSlhOm9uNtiTk0L1JresCp77Agm2tEyGcO34K7dpKnak/OADLt+HNnqYw=
X-Received: by 2002:a05:6e02:1a86:b0:39b:3a44:fe8a with SMTP id
 e9e14a558f8ab-39d6c353a36mr26132485ab.4.1724253582044; Wed, 21 Aug 2024
 08:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815113745.6668-1-kerneljasonxing@gmail.com>
 <2ef5d790-5068-41f5-881f-5d2f1e6315e3@redhat.com> <CANn89iLn4=TnBE-0LNvT+ucXDQoUd=Ph+nEoLQOSz0pbdu3upw@mail.gmail.com>
 <CAL+tcoCxGMNrcuDW1VBqSCFtsrvCoAGiX+AjnuNkh8Ukyzfaaw@mail.gmail.com>
 <CAL+tcoAMJ+OwVp6NP4Nb0-ryij4dBC_c9O6ZiDsBWqa+iaHhmw@mail.gmail.com> <CANn89iKNQw9x388P45BtbTiGFjj6PCC6vwDF7M9DJFUPhtNWJw@mail.gmail.com>
In-Reply-To: <CANn89iKNQw9x388P45BtbTiGFjj6PCC6vwDF7M9DJFUPhtNWJw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 21 Aug 2024 23:19:05 +0800
Message-ID: <CAL+tcoBcLRREwwrEsmzOD-OhzABEOQRqZc8Co_xK3UPXOSrnxA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: avoid reusing FIN_WAIT2 when trying to
 find port in connect() process
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org, 
	dsahern@kernel.org, ncardwell@google.com, kuniyu@amazon.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Jade Dong <jadedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:39=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Aug 21, 2024 at 12:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > Hello Eric,
> >
> > On Tue, Aug 20, 2024 at 8:54=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > Hello Eric,
> > >
> > > On Tue, Aug 20, 2024 at 8:39=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Tue, Aug 20, 2024 at 1:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.=
com> wrote:
> > > > >
> > > > > On 8/15/24 13:37, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > We found that one close-wait socket was reset by the other side
> > > > > > which is beyond our expectation,
> > > > >
> > > > > I'm unsure if you should instead reconsider your expectation: wha=
t if
> > > > > the client application does:
> > > > >
> > > > > shutdown(fd, SHUT_WR)
> > > > > close(fd); // with unread data
> > > > >
> > > >
> > > > Also, I was hoping someone would mention IPv6 at some point.
> > >
> > > Thanks for reminding me. I'll dig into the IPv6 logic.
> > >
> > > >
> > > > Jason, instead of a lengthy ChatGPT-style changelog, I would prefer=
 a
> > >
> > > LOL, but sorry, I manually control the length which makes it look
> > > strange, I'll adjust it.
> > >
> > > > packetdrill test exactly showing the issue.
> > >
> > > I will try the packetdrill.
> > >
> >
> > Sorry that I'm not that good at writing such a case, I failed to add
> > TS option which will be used in tcp_twsk_unique. So I think I need
> > more time.
>
> The following patch looks better to me, it covers the case where twp =3D=
=3D NULL,
> and is family independent.

Right, thanks for your help!

Thanks,
Jason

> It is also clear it will not impact DCCP without having to think about it=
.
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fd17f25ff288a47fca3ec1881c87d56bd9989709..43a3362e746f331ac64b5e4e6=
de6878ecd27e115
> 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -144,6 +144,8 @@ int tcp_twsk_unique(struct sock *sk, struct sock
> *sktw, void *twp)
>                         reuse =3D 0;
>         }
>
> +       if (tw->tw_substate =3D=3D TCP_FIN_WAIT2)
> +               reuse =3D 0;
>         /* With PAWS, it is safe from the viewpoint
>            of data integrity. Even without PAWS it is safe provided seque=
nce
>            spaces do not overlap i.e. at data rates <=3D 80Mbit/sec.

