Return-Path: <netdev+bounces-86880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1A08A0966
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F8B1F21360
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919613E884;
	Thu, 11 Apr 2024 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxMz9YUC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F913CF93
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819530; cv=none; b=Syy5ZFMhWPApEq57xlUHZhGv6sbvyftrCQZ7azcxnxwdnH7tpEjQiepD3LUp9yeMvd5eHZ1OpH0VQNeDTym4ZzP29XjUo6UmeRjerktcB352DjU6f8eeHFfMMefvOnrTtTu/SdVhxlGQ7y1s5xA2vwrRIDCZVgi0tF7/GrEKbkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819530; c=relaxed/simple;
	bh=k9es0c6OvhMGwTbVeiQxRIy7K3PrlSI7hSSZg8Osfpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7IQfEpKJYGKmGF86wYMH6FjgbjwW5jc9YU5Z3W7aZoGwOVWobLouoHN5BQs6I3Be0FXZUdRAs1vgK0BMMu6C4eYNPVBeMo2ZijAtCjHnkCi+wjnb/fFbpEm06N9vZTrLxyvp4CYU6a2vMBoPhXrzCh8VI5no1CQIj4orOZ9xvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxMz9YUC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so5262a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712819527; x=1713424327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aKLV3hGGAVHgtfDvbKp2Kk4cW+24KQuoTZfB2pmYQQ=;
        b=XxMz9YUCULdG8H953mVP1yvKzhV+bCi7wYdoJ186i1f9M7dlO9Jx6mj6qvh36VmUMa
         /Tcm1Jj0KL2Z5GWeyyOpV1avDmBD2S0BOT04TsRaAyem/LvK4ZUGA+e7/CnAdbIo6O7O
         UEwMhhIGXOx54CoSV7Xl3cwKM4jGkliCZPu3ldsLbhG8TCXsgBAK0styGS+TCnAQ7hGW
         dXDM8lV9YVacUn9Ji97aNdIFfKd8d5E7XkF1MzDrv+MGcQtFihDF6jvqbjBV8rg8l+Jc
         rZnWEVpht4UNS8G79xH0hvCQdp/RmtHOC28NF4+gfVz26ZJBVaaSWhYdYqb+6d3ubH7N
         G/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819527; x=1713424327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aKLV3hGGAVHgtfDvbKp2Kk4cW+24KQuoTZfB2pmYQQ=;
        b=tjyBUIaYgxq/L6OBJLvyKZRpG1aT2orAvkDx4Ql4TceyoxGUqbTnBH0ABDGEhkjUW9
         jmNghXTn3nl/hx4m8xhO0Zad7mlbAJTJ0Fu7IHDufm6GQPBF4fLBKldgfdmJq/7oImxm
         umlHhycPM9LBWbRV4MgtOYWk46UdeLv7c+5DiUlFOuKpcQDdha6faAcUl/j4/mTLnIUO
         h8MgoPdH4lA1bVp2YAZu4wQ/q+oVfeQk/vZBXBWUqF9uW/bjs1IcjmnWxMbV1zhtnqWo
         SDI7JALdUsw/QD4hKE83pB3RJniEc3K7YJPcX/VWtNC4MgyFtyPr9gX2qd3qqV4rl5zj
         hPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQBBwTfY/+m8y/AcZssJ0i0+XjkBGXSeVhKilmpfdMqP7BxAt1cBbTVVoW3Yh5c3nbXbUkFZM2+B0z+0bA9jl1eqAfdFmT
X-Gm-Message-State: AOJu0YzXJCKwMO3Up/+1kuk8AW6FvLWs6kWsqRhE7PATDth/eqFEX6+M
	YxewzURWO2OCD035jZSXfIKSObV8szuK6tbt7hasI1kEmruN2mTrcZVl+nJtUAYLhw84FSD1UzJ
	27lMZ2J1L9wC1z0qNnLfJwTdjdOhZfqXzXwby
X-Google-Smtp-Source: AGHT+IGguH50lgHzuCqXnJmSsz0jSKcOesCv3H0IyD4hj0qx4fBYZLUcnZoXMR1oPy6Ysuz/z6qYkfuCz27tw0dVmLA=
X-Received: by 2002:a05:6402:4304:b0:56e:72a3:e5a8 with SMTP id
 m4-20020a056402430400b0056e72a3e5a8mr96761edc.3.1712819526903; Thu, 11 Apr
 2024 00:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411032450.51649-1-kerneljasonxing@gmail.com>
 <CANn89i+2XdNxYHFNwC5LHupT3je1EaZXMxMJG9343ZO9vCzAsg@mail.gmail.com> <CAL+tcoC2FW2_xp==NKATKi_QW2N2ZTB1UVPadUyECgYxV9jXRQ@mail.gmail.com>
In-Reply-To: <CAL+tcoC2FW2_xp==NKATKi_QW2N2ZTB1UVPadUyECgYxV9jXRQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Apr 2024 09:11:53 +0200
Message-ID: <CANn89i+6gWXDpnwM9aFtP_d_oTfQRDJdu+VMoDtvVcDrzBM_JA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: save some cycles when doing skb_attempt_defer_free()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: pablo@netfilter.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, horms@kernel.org, aleksander.lobakin@intel.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:33=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Apr 11, 2024 at 1:27=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Apr 11, 2024 at 5:25=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Normally, we don't face these two exceptions very often meanwhile
> > > we have some chance to meet the condition where the current cpu id
> > > is the same as skb->alloc_cpu.
> > >
> > > One simple test that can help us see the frequency of this statement
> > > 'cpu =3D=3D raw_smp_processor_id()':
> > > 1. running iperf -s and iperf -c [ip] -P [MAX CPU]
> > > 2. using BPF to capture skb_attempt_defer_free()
> > >
> > > I can see around 4% chance that happens to satisfy the statement.
> > > So moving this statement at the beginning can save some cycles in
> > > most cases.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/core/skbuff.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index ab970ded8a7b..b4f252dc91fb 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -7002,9 +7002,9 @@ void skb_attempt_defer_free(struct sk_buff *skb=
)
> > >         unsigned int defer_max;
> > >         bool kick;
> > >
> > > -       if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
> > > +       if (cpu =3D=3D raw_smp_processor_id() ||
> > >             !cpu_online(cpu) ||
> > > -           cpu =3D=3D raw_smp_processor_id()) {
> > > +           WARN_ON_ONCE(cpu >=3D nr_cpu_ids)) {
> > >  nodefer:       kfree_skb_napi_cache(skb);
> > >                 return;
> > >         }
> >
> > Wrong patch.
> >
> > cpu_online(X) is undefined and might crash if X is out of bounds on CON=
FIG_SMP=3Dy
>
> Even if skb->alloc_cpu is larger than nr_cpu_ids, I don't know why the
> integer test statement could cause crashing the kernel. It's just a
> simple comparison. And if the statement is true,
> raw_smp_processor_id() can guarantee the validation, right?

Please read again the code you wrote, or run it with skb->alloc_cpu
being set to 45000 on a full DEBUG kernel.

You are focusing on skb->alloc_cpu =3D=3D raw_smp_processor_id(), I am
focusing on what happens
when this condition is not true.

