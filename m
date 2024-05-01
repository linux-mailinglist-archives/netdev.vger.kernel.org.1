Return-Path: <netdev+bounces-92714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBD38B862D
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 09:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA0A283DB4
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 07:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C14CE09;
	Wed,  1 May 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jBH8Izcc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38314D11D
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549209; cv=none; b=IwjBSp2iyz2jPG93ULTVWiaJabVicxK8wrBy9bcxvv3F9pFDE5ZDFuWBhJ7JlSNkORybIIJCP+mTKBNdNdtqhzJUhY/7zzA8CF3p8hOrooOBditteK0aSYIJcDc09mt33xWWQ4cKcHt7lINbw8iGUQPhYgTZZO9BcjIEtwebgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549209; c=relaxed/simple;
	bh=KjCSrzmVVh6obO3qPfkUgerIfhp0qMhYLjE8+kp2Bhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxk9yoiV4WnVini0xz+gup/47t9DV5N8Mf1GLDV87Ey+zoZq1e0lLxwTt79+3ugrW6dGzKMpJBZm0z3YNYZzidWlR4bMvQoZcIQztmmvhTx6kdK7/FQV+ZTMOM7B83t2c+jvNwPi8FfEJgzO1d+ksSDRiKfYM9w3U9fh2K5NOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jBH8Izcc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41bff91ecdcso33095e9.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714549206; x=1715154006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdmSwaSHnAY+hAjhCkjyH3TvnEg+WabwvqoaT+nPkhY=;
        b=jBH8IzccpHY7gfX1Dh/QPRRcdwUE8TcEYe6HlNl136P1MuFkBSyhz7Sgzm9SZhF4Aq
         +J5lgT8eX5ovWwPV+xltHdGDPjQnAdE5Kec0aHvD7uQRstTE3Cn8U40TfLXoOEJg5xZ/
         U8bg1FuYGHkfyncZcm37Sm8qPxNGsOQOUofsonhNPguAcrZulqrPIXi9F6aWTTvlJwPz
         RboXpFG6LloG8TfB1eW99fIuaD8UFyH4THcjhhDEe0jXDgFzTeRmMRDKwfIVWHaMHJ59
         dKBSnyuLaHO7Ur4TxTTYSuH6JBEK2ZPJBY8Yu9lqwzlZLLwuggbkXsZuaqS1a1O3mIsE
         /xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714549206; x=1715154006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdmSwaSHnAY+hAjhCkjyH3TvnEg+WabwvqoaT+nPkhY=;
        b=WNYO4fFyIZ4ajjei2ZfifuUcFTJ9AG+2ehA/N2Crww8MEGNKOjoYJ50VxkUBe3+T0O
         HUmYxHgzu7GFD2fecA9XFdTYJt0zg/x5LmTHiPZWd/X9phYDLbw6QJ/oZbYzOgr4DN93
         M+SD/qg9tyXHzTVeE46MAEGWSZkJnzE0cKrUnDYmJUnbZpMm2jcipL8bLtvtEEDweJr3
         lzZuThYeDoVhD3YKoM0+VtSlDKnL8ElFPBpX/0idi2BAfJOQnwrlGSXtmAp9n+B1eOPr
         YbJkIdSde+r6OPu5qypgS4QgV/1X5xQx6rDsHRTZBwRocGl0clyFQpWuY2SUJT9wb/CF
         no5A==
X-Forwarded-Encrypted: i=1; AJvYcCWUEb54HFHOMnwheULYRNRiqmzxpvWRW2ScXHG7zjD73lj3h4mX4DELIz3sSWj9ikgQ+Nkg9PH2dPCUWmOfTzwIUvA1qeMh
X-Gm-Message-State: AOJu0YyJe4dI5LdUVsO6szUH626leH+Di2SLXbCxjdUjQ2BJSPsMy6TN
	Y9FjAGP8K6Z3xRQ3W3stAJELPEKyOQ+Nvl6n1QQWNelZNla8e1Np3FNWoqeg3PPLjkjYdrclOE3
	WKGxHSTxBrkE829VfGDdvNuYj3woR45Nb810Y
X-Google-Smtp-Source: AGHT+IFZWL+KYwY3PMsNaksDon6Hv+G2Yag/crWI4PnDrd/pcKig6XUN3HyewGjntK/0RXv4pd8P6ff0njh3as01Zm0=
X-Received: by 2002:a05:600c:4704:b0:418:5aaa:7db1 with SMTP id
 v4-20020a05600c470400b004185aaa7db1mr97697wmo.1.1714549205802; Wed, 01 May
 2024 00:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
In-Reply-To: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 May 2024 09:39:51 +0200
Message-ID: <CANn89iJETs=YMAiR5vP5pB2ENdeZ_uSHM0JrW1Wkkz6Du234oQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: unregister lockdep keys in
 qdisc_create/qdisc_alloc error path
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 7:11=E2=80=AFPM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> Naresh and Eric report several errors (corrupted elements in the dynamic
> key hash list), when running tdc.py or syzbot. The error path of
> qdisc_alloc() and qdisc_create() frees the qdisc memory, but it forgets
> to unregister the lockdep key, thus causing use-after-free like the
> following one:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  BUG: KASAN: slab-use-after-free in lockdep_register_key+0x5f2/0x700
>  Read of size 8 at addr ffff88811236f2a8 by task ip/7925
>
>
> Fixes: af0cb3fa3f9e ("net/sched: fix false lockdep warning on qdisc root =
lock")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/netdev/20240429221706.1492418-1-naresh.ka=
mboju@linaro.org/
> CC: Naresh Kamboju <naresh.kamboju@linaro.org>
> CC: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

I hope syzbot storm will be stopped with this fix.

