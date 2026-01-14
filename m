Return-Path: <netdev+bounces-249667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA35D1C156
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 193B0303F0BA
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C42F2619;
	Wed, 14 Jan 2026 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkLd5oTV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E78D18BBAE
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356100; cv=none; b=f5EbID7+oP4DvkFpXYYiJHVLW2tOSmuAn0DE/KM4RSLm5S+yBuihxGp3g6NOb3P0io+gCPcUR+hKFZfsfPTZldCSD3gCnK0kj/S3T9jQxGrZVMea7nBYbWITCUD7Uc0laAqdPLmTKGFp5xf9q5LM6GoliBvLDFYkivI2aXMAq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356100; c=relaxed/simple;
	bh=9C94nQTK7DnwA7gjdKMJb+u/ecuo+vMs28/RY2Dyecw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cupQ/q94LFw7ERE6r5sVLmftaTil6Yxu9N3Y9jWzC0HFwVcRtz5549R15xZZN6DjpFwEdikMfZMKafp7oyN2T1EB7XQDHmco6EerjY4y/RVRsat2JE38iM1ijpA2nY0nw+iZH1veVtCQRhgdTNF3Ui3TKzBHgQadT5hFfQPdNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YkLd5oTV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014b7de222so726691cf.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768356098; x=1768960898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqdg5Rx1hxsd34tgtRIX9MZCBC0NBLvB3Lt0noII71A=;
        b=YkLd5oTVCe9JzVSskNmV3pwHDZ2UaqfP+WnKY34nQ7nWt4r8PY+OyVuBUSFcdgwZ5M
         x9HZ/nvZlwiy15PARXf7f/777mhGozOCZGDPcAoGPak88pYi6VllBw3n77r2wcZcuewj
         /LR4OZuH//nEKgl9BJrDHpcTuAbnOlq5pNgq9DqfzOEswM1Q/fd8PprZut/yXaeWzvqI
         xUFBIEpQl/PAxGQaKi9kvTiiPKgUY/sc75acMMOtwd+iMI78brjDQ7/eb3rW4PR1C4uP
         BC/e7DIUVuJDWelQuJcY92+Lq3Y4vtca6eRA7NGitesmJc3Tm/Ul6SANhBNMoppyNrUH
         FUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768356098; x=1768960898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nqdg5Rx1hxsd34tgtRIX9MZCBC0NBLvB3Lt0noII71A=;
        b=TxjaWkHGBsZAYJiPSADl77WR1h0lWPoEhUDE99gufmvf+s0os+x434ArpVPpGKXo3T
         xbqc6SHBSD27ASsIrkDKj/SNZ+2hoyrSNOo2B/OL++DSOxktO2e8kR2X73q8TnMmXW30
         paD+REYOi7yPCGrTXCUkk+cyolB/+ztKdTTRPC0iMPdafEQ+VPvqdMYt74OeUq9/1nXN
         VXocc5+RjclGrkmuqAtu5zcKqBhUgwTQeah8PFJWymAhlLZJfP7Tf0ZY4CON/p6VAg4s
         xm4JRg/4V0z08PnMxChNPfowC8TkoXeJfL2TJTXv5W92NG8CaPxW+pOt011AqtexctHW
         kFxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWT4lHZ77U3cUWyPsY5D39XTH2va4/fOeMpT/s1Uij2HRQICsKpVw3MDNxkkRRAy8ZLFinoPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYlBF1sgmwqA1CbvfFmPCqsgXe8GQaI4xPQgNXDnR0i+vDaJC
	hQSyzjrJQaR1bZqwlJ7v4npMNSKmdsTa6YZPolyMT6pANCHl0oB6rXvfVdaJbELP+dxx+L/CgIc
	FdxBe9rG+6L1nhMQImz6iAMXiQHherqbzozbeboaF
X-Gm-Gg: AY/fxX5ZPpAc/lbMM1IhBhISwsrg9PlqbHaqPUEPXnOvRJz2Xoq9w3s9Gv0U8+f7YFQ
	JZP7tRoXafY3yxQALSFWbBzm6rSjCtQBGBQAZtz5JGu6x2rUs9wW+1yn25ZxllpB2ls9VNUa2Eh
	AUTI/jtiTN69cQx3K67IEcxJ4SsH4PHJthXn1pSVwUb/fhaQkROCNMclBs6gTsLWjYIAE/0RnAG
	CMzacc+zvKWgFEtlXtq2+N4j8qSoWHQ+Sy+kVA22xgsJP+9AlqIiSZT4YfJEMXY1Dx9tUln
X-Received: by 2002:a05:622a:410f:b0:4ec:f56c:afa5 with SMTP id
 d75a77b69052e-5014a9043d1mr4560551cf.22.1768356097940; Tue, 13 Jan 2026
 18:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113131017.2310584-1-edumazet@google.com> <20260113174417.32b13cc1@kernel.org>
 <CANn89iKDrx0DP56AynzMuKv4so7DFEFpFE2yHg6gCGugzd4ivQ@mail.gmail.com>
In-Reply-To: <CANn89iKDrx0DP56AynzMuKv4so7DFEFpFE2yHg6gCGugzd4ivQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Jan 2026 03:01:27 +0100
X-Gm-Features: AZwV_QhwSMIKc3b9ic3shy2icGFf3JvY1RV6kykJZOx-DUnYOjuXKCQH2n4ahHo
Message-ID: <CANn89iJ3Ha6pQbBjR3XgvM35HVdeCh8k9nMqScuHxamz0JVYFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: minor __alloc_skb() optimization
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 2:54=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jan 14, 2026 at 2:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 13 Jan 2026 13:10:17 +0000 Eric Dumazet wrote:
> > > We can directly call __finalize_skb_around()
> > > instead of __build_skb_around() because @size is not zero.
> >
> > FWIW I've been tempted to delete the zero check from
> > __build_skb_around() completely recently..
> > It's been a few years since we added slab_build_skb()
> > surely any buggy driver that's actually used would have
> > already hit that WARN_ONCE() and gotten reported?
>
> We could keep it for a while, WDYT of
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 77508cf7c41e829a11a988d8de3d2673ff1ff121..ccd287ff46e91c2548483c51f=
a32fc6167867940
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -458,7 +458,8 @@ static void __build_skb_around(struct sk_buff
> *skb, void *data,
>         /* frag_size =3D=3D 0 is considered deprecated now. Callers
>          * using slab buffer should use slab_build_skb() instead.
>          */
> -       if (WARN_ONCE(size =3D=3D 0, "Use slab_build_skb() instead"))
> +       if (IS_ENABLED(CONFIG_DEBUG_NET) &&
> +           WARN_ONCE(size =3D=3D 0, "Use slab_build_skb() instead"))
>                 data =3D __slab_build_skb(data, &size);
>
>         __finalize_skb_around(skb, data, size);


BTW, for folks using clang and not up to date kernels, backporting this com=
mit
makes sure __build_skb_around() is at least inlined.

commit 242b872239f6a7deacbc20ab9406ea40cb738ec6
Author: Xie Yuanbin <qq570070308@gmail.com>
Date:   Sun Nov 9 16:37:15 2025 +0800

    include/linux/once_lite.h: fix judgment in WARN_ONCE with clang

