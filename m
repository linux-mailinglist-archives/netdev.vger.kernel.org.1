Return-Path: <netdev+bounces-86868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CA68A0882
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 08:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE21C1C2161C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 06:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCB513CA86;
	Thu, 11 Apr 2024 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJKPqLMY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8413BAD2
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817192; cv=none; b=MGQyEUcAyyo4+/X7c/y//u9odFwA/CrITrq3ZU+9un+wdLBwfUDCVxLbZfFgpVz9For7D1qWfmSkTQiauEIEmvIGat/mCZAdlkkfrLnzh18ySTF0rGnJyrx4oLkXnj1d5JfOe3vxrXD+8Ff6CdBNeifCI9hNsyx88sq/xUxJXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817192; c=relaxed/simple;
	bh=XFPOkJ8h/JEvZAfh3iEzz8etisfLujSN6U0T6wb9H5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDZbZzEpx3LvIc4Tf2aZQWCGkxse8FrArod6WBx6GllKv2iPW5/hiDP7sBQeVgcFOA0bmbbBJomPSddEmM6Mx7WuGOz/Fvh+plPXoKPZLVQxt9kGZo/75lamOud3arTHunvttI7xmuUR/YBnmAazLLJhd0DrzEa6vJZVP9RjN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJKPqLMY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51a7d4466bso740349166b.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 23:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712817189; x=1713421989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI3WMljeid2oTzriCscLyDPt27vX4GiAF0jSUBUV1aY=;
        b=SJKPqLMYulsGHlzSHTcjqY2sLmzJYROfwMeo8bMeey6U7NUfPPC1tguqi4Jtu8bv4v
         o90drdO6ou76Zf/pTUtVs4rKBXhh7kas25uwqosGKwow9c9y7+jo1fGN9MQAnFnIFs4q
         sSq8HPnKboewNHqmPY3wrtZKMMaOI0wY1qCELTAT8LppixAAYpH9Dz9RvzApBWQ6iRs4
         GaG7NEptsRRypfyxmG0Ul+g7NL+8QLrEcxhI20xNJj/FtTkN7N8pO9LA/MBcJvXSi9sC
         Zp3LY/ceQubV9NCXVrRRrOdCMwHqi11jY40AZ2M5vS9iEiiQQZCSnmjCl7LIgwP2R2gD
         4Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712817189; x=1713421989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JI3WMljeid2oTzriCscLyDPt27vX4GiAF0jSUBUV1aY=;
        b=Y0aERUXP04V67nvDFWSgxuzTwZnFfaaTxeZwuP1PKb5zd7fAggjMYb7Q588b/cca2r
         YBf4IXe1WFS/1GUdo3w7lF5Pcjd+GJ2fCCuI3MYF2fYWnwbGqcs8dDV+UvdxPZCe32pC
         7BcEZIhkwW8x/nv1F/z7EfubqbqDmCMbnSVqztML7YkbZdEAcxCVQVvwnJDHU3abZmOu
         HQepX/xkVK8nszNM01Xpv2b7nUQRa7P1pnrxVzRmTC1wWzLn2TM75xbE1W7mLkWHY5I3
         TQWsRvS6drxpP4hTEzlYTFx8sAn2dWEIARWX0eZkTbdIkVQ6Se4F986hEx4YooGIJb9B
         LYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoGDDz57HXsWuyUpfUG3N3csBMRyK8KXYspmIhnq0RMT8ewSwdLERV/ykBDiBgFrQer+FLoDLuWcjpjRQ1n56ieQKnxNJv
X-Gm-Message-State: AOJu0YwSMa+WvKQ80ykDh/bCfObY0/y9oGAJnf8WJ5DY0dUZOREy4MU8
	W8ep1GgG36wyaaAOCM7uFjKj5fOGxOd8jPTxr6AwsjybjxC+aZrVrNhrLBJ8sllECklbwCoJ2JH
	/3S788hHes0YO7/tsS3WUUXp5qZw=
X-Google-Smtp-Source: AGHT+IEajuJywyI4Y10xZu+Exry6CeGchqVtPt+IbNRVnp0SFNv3m2Pf6udmf/UDzHRQ2GCXl0v0ZCcfefaKWRsyJAA=
X-Received: by 2002:a17:906:1513:b0:a51:9438:af01 with SMTP id
 b19-20020a170906151300b00a519438af01mr2969159ejd.76.1712817189329; Wed, 10
 Apr 2024 23:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411032450.51649-1-kerneljasonxing@gmail.com> <CANn89i+2XdNxYHFNwC5LHupT3je1EaZXMxMJG9343ZO9vCzAsg@mail.gmail.com>
In-Reply-To: <CANn89i+2XdNxYHFNwC5LHupT3je1EaZXMxMJG9343ZO9vCzAsg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 11 Apr 2024 14:32:32 +0800
Message-ID: <CAL+tcoC2FW2_xp==NKATKi_QW2N2ZTB1UVPadUyECgYxV9jXRQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: save some cycles when doing skb_attempt_defer_free()
To: Eric Dumazet <edumazet@google.com>
Cc: pablo@netfilter.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, horms@kernel.org, aleksander.lobakin@intel.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:27=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 11, 2024 at 5:25=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Normally, we don't face these two exceptions very often meanwhile
> > we have some chance to meet the condition where the current cpu id
> > is the same as skb->alloc_cpu.
> >
> > One simple test that can help us see the frequency of this statement
> > 'cpu =3D=3D raw_smp_processor_id()':
> > 1. running iperf -s and iperf -c [ip] -P [MAX CPU]
> > 2. using BPF to capture skb_attempt_defer_free()
> >
> > I can see around 4% chance that happens to satisfy the statement.
> > So moving this statement at the beginning can save some cycles in
> > most cases.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/core/skbuff.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index ab970ded8a7b..b4f252dc91fb 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -7002,9 +7002,9 @@ void skb_attempt_defer_free(struct sk_buff *skb)
> >         unsigned int defer_max;
> >         bool kick;
> >
> > -       if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
> > +       if (cpu =3D=3D raw_smp_processor_id() ||
> >             !cpu_online(cpu) ||
> > -           cpu =3D=3D raw_smp_processor_id()) {
> > +           WARN_ON_ONCE(cpu >=3D nr_cpu_ids)) {
> >  nodefer:       kfree_skb_napi_cache(skb);
> >                 return;
> >         }
>
> Wrong patch.
>
> cpu_online(X) is undefined and might crash if X is out of bounds on CONFI=
G_SMP=3Dy

Even if skb->alloc_cpu is larger than nr_cpu_ids, I don't know why the
integer test statement could cause crashing the kernel. It's just a
simple comparison. And if the statement is true,
raw_smp_processor_id() can guarantee the validation, right?

