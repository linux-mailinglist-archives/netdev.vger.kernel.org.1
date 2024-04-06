Return-Path: <netdev+bounces-85400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03CE89A978
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 09:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A685281A65
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B75D22095;
	Sat,  6 Apr 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYZVQHHp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E81322EE5
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712387241; cv=none; b=Scbyrt7PDWfdXceiCYhfGUlpyGp4ruc8ZwO7TWM3Hoxe+pF6khFsfUrSTCNsdfy5BUPGNTjCiQP6ScOzEf7Osm62MfZVlRDBk7KCC4sMeTNFs6zLXNZu06d2D9WA0iS0lgKRqg733fq9I8tTFGxyXPurLzLcRHdTWM4OgBUF1iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712387241; c=relaxed/simple;
	bh=poFcz1cQK5dBXN6RTm3VCb03mC9s68DjSduBKXhdYl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmarmTYA1Xh9ztkXUg9WfngTDuN4BjR+2oYaHO8GYNjxyM0mTItv1Q9hpWfTQE6Bbf9c5uP/TyxaYvnkiRExqxIGCwJQ3c0OVUCgBc2TuIqN1ar/8ah2LzTrMUFt18w+QN8XgGdJBBIfhXmzRgwVciegp46CO5YUqapUivLIFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYZVQHHp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e2e94095cso6352a12.0
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 00:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712387238; x=1712992038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTO/UJhrqP61bAEgzujDG4nIL+jAhwQmQ/U8HwGLCgQ=;
        b=KYZVQHHp/yvlQ/Bi0eBxdaZazOOu/aGK338gpU8cs4HO2UXicntywR8D9V96EpAoPE
         V9hEIEqD0zF3a9gt4+mFLKKHvvbBKXCFh0Xy/RIcQ6OuGOMUdn0Wj0++kxlZqxhLv76S
         6xD6CuRJDG6Sh0ClAbrAtoUmj9jbs4eXbAWnl7SagtJb1R0cpveQ5MhrHZ0kS04D8gqA
         Dv3AzjYQLqkhSBsm3+RN1aSIX75v8ej5qQU1GUCJdbalgJU5UL8SxfoWY/AMLrYTH7aO
         H8lnFVNNTW9Gr+ewQwZbDD9fQQjPdTEdMDgLAJ2M56Q5Z2KiPJOGtzjOj+B8MyCZ+iID
         hsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712387238; x=1712992038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTO/UJhrqP61bAEgzujDG4nIL+jAhwQmQ/U8HwGLCgQ=;
        b=Qd8NW2ZCR0k4p7Jw/PcliypogBVi/IssAVpGClaV9ZzX7NkDoSrWYXhKWXPUl5YSes
         RUaO698IoJWhexNiZDI+92yTTKK7npBAylzceShuSF30Pvyxe29arPSZ2FmftxfvqF1C
         bWcGV1wbT6T/nMY4aV7SivaWBJ6+uxOuzBEdlYnTPrfp0Yl03xHdfEQl3gfANDxS13uf
         u10nbT26tXdITxznDdQkTJduGtFT2C/q0XWkJeBqepvxN1l/MfDruI0zDRHFz8VTaM+9
         LK2bDGnRdl0SCPPygsZwTujWdD6l+3EvJ20dLcSto4d53Dq6oheUH8KeC6SMRS2SBZnW
         3S2g==
X-Forwarded-Encrypted: i=1; AJvYcCXCSjGYMwE1GtQvm3bXKOn0ftYElj5rAY2W3YcPhofZGuB7dFC+KE2mCvZeJKVhYpqvX1pzOPTEt9DW/9fk8spEuL71MIIx
X-Gm-Message-State: AOJu0YyS4L6xFpy9oPWPociKFK/eKyZO3OVfSGCC/sLyPlW+zYMPija5
	SVsXDit016t90mi5UvV4N98fWepCAf9dYa2rBuBvMUmmI23j9ZzDI7T3iFW0l9x0MVgSCn+wfn6
	HCOOUIuSKf7R6yOczy/WmaujGX3LvSmX/BCpK
X-Google-Smtp-Source: AGHT+IFeKlXvFRT7VraeSyZTe1k+d6FG8BdE/kgpbY2dMwcAr38Y2FPzlrRKnU9a66MnfJfwy3YydGUsvMesHDmDIj8=
X-Received: by 2002:aa7:d417:0:b0:56e:34de:69c1 with SMTP id
 z23-20020aa7d417000000b0056e34de69c1mr81630edq.4.1712387238356; Sat, 06 Apr
 2024 00:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717152917.751987-1-edumazet@google.com> <c110f41a0d2776b525930f213ca9715c@tesaguri.club>
 <CANn89iKMS2cvgca7qOrVMhWQOoJMuZ-tJ99WTtkXng1O69rOdQ@mail.gmail.com>
 <CANn89iKm5X8V7fMD=oLwBBdX2=JuBv3VNQ5_7-G7yFaENYJrjg@mail.gmail.com>
 <f6a198ec2d3c4bb5dc16ebd6c073588b@tesaguri.club> <e463df8c95bfce3807459e271e161221@tesaguri.club>
 <CANn89iKoaTjaK7s_66EOHAYw+drT3XTEhT5xBcFU1iHTYr_aug@mail.gmail.com>
In-Reply-To: <CANn89iKoaTjaK7s_66EOHAYw+drT3XTEhT5xBcFU1iHTYr_aug@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Apr 2024 09:07:04 +0200
Message-ID: <CANn89iLWkJrth7jLTSp-jFK-UUTFMN6UxHc_HcDGkSNFN2kXQQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
To: shironeko@tesaguri.club
Cc: Jose Alonso <joalonsof@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 8:11=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Sat, Apr 6, 2024 at 2:22=E2=80=AFAM <shironeko@tesaguri.club> wrote:
> >
> > The patch seems to be working, no more dmesg errors or network cut-outs=
. Thank you!
> >
> > There is however this line printed yesterday afternoon, so seem there's=
 still some weirdness.
> > > TCP: eth0: Driver has suspect GRO implementation, TCP performance may=
 be compromised.
>
> This is great, could you add the following to get some details from the s=
kb ?
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 1b6cd384001202df5f8e8e8c73adff0db89ece63..e30895a9cc8627cf423c3c5a7=
83d525db0b2db8e
> 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -209,9 +209,11 @@ static __cold void tcp_gro_dev_warn(const struct
> sock *sk, const struct sk_buff
>
>         rcu_read_lock();
>         dev =3D dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
> -       if (!dev || len >=3D READ_ONCE(dev->mtu))
> +       if (!dev || len >=3D READ_ONCE(dev->mtu)) {
> +               skb_dump(KERN_ERR, skb, false);
>                 pr_warn("%s: Driver has suspect GRO implementation,
> TCP performance may be compromised.\n",
>                         dev ? dev->name : "Unknown driver");
> +       }
>         rcu_read_unlock();
>  }

Thinking more about this, I  think this (old) issue comes from the
large skb->head allocated by usbnet,
allowing tcp_add_backlog/skb_try_coalesce() to aggregate multiple
non-gro packets into a single skb.

We could fix this generically from usbnet_skb_return(), instead of
'fixing' all usbnet drivers.

