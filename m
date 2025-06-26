Return-Path: <netdev+bounces-201595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3507BAEA07B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224EB176BA9
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B789F2E336A;
	Thu, 26 Jun 2025 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SayqLJN3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FB12EA171
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947998; cv=none; b=M4CszK2pTbxAx6WVH78A+lBixI13xvovXrc8h8TH9nqZZ950HAGTltZ+E4HFoyN46b3FOolWgscPvs6iAlpBDj2PrmyTNTKOZsRCEAeqcLXrdbgMP3/dXIBYAVZ/oozpCJ6VYmmnLuu/vnZ/vaiVZMJNH1LG6wu+McyDtO4r0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947998; c=relaxed/simple;
	bh=0UnOVKwi19gq5ypsHUWXgfdcxKihDM86K5R+X6vkb2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Of+ta5afxr4Fs1B4GTYicFzElAXOLHV3u5MU9SoNNUeqOvV61GCKAynNj2V2scEYFjskxOyqFg2VZdmAhNswY8Ub+XLbMy5KDsJ7jRJZPrBHl+NdMws3fyLC0c1c5U9m+Cns52Z3EkfSeA2oJXR7lt2zhKLiMA//74Y3ZIMb6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SayqLJN3; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a58ba6c945so16971651cf.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750947996; x=1751552796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14vhLXCwcnGhh6aniUUHTiBgN91UqQ3DXX1+caIoud8=;
        b=SayqLJN3qdaimfA2RzRBJMP7NnSQHiVBvI7yB1hla11yp31sYqNJkmOqb4c+xhCG7q
         7T63wzK6fN+kV0VjUDcDRI6wOIK/FAoVtdy1yeRb0U4eh3hUhRWhXNoDA4i1qiuPupgA
         7o1cvKXnKt7QkuPwKp+l9U4eXbFKSeS0hh+l0A4Qa162srDXsETh+wh35qrm1jlM5p+s
         xgzMZZBnEHOfB/ar5py1EEWwCVpeKIKbG+6Czey04KzSnqqlABAxhhITC3VSfUytl8Vq
         TedUiVfIk3sOJbGdaV/tBiqKfY+DEb3vJsuF9nbs8oF6tKaQ8OidwU/8RXIWJcLPV8Oo
         Jk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750947996; x=1751552796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14vhLXCwcnGhh6aniUUHTiBgN91UqQ3DXX1+caIoud8=;
        b=N4qA9bOF6U2/u8D6tDyjofi6LOOeJa6KLxILfgmXgOw+YQUGIFyAo98mgKp1dbYDWX
         yacIducZLRTc/WN9EwOPapSAeBfKzH4+F+dVizu/AG5Lnk2+PqUS4fdPTyn6N2gL776e
         1fu2UxS6G/U9pG3XEPDRuRqf38n7xJ7v5/pYKHanZuDCZCSxcpVrl1u26YZHcwWfYpXg
         Z2vbDEpVN1TSatdhhyQH4nGLF4HzAi0ARvOKRuLl8H5kf/w70VBiMASTQ9wUa4AMR/Li
         b+p1bsqA7ybLx4ig0VHjYNsvm+2uNq64sEKomFT9AUkBrob2jDo6IujuLvN4vsaisUkQ
         my7g==
X-Forwarded-Encrypted: i=1; AJvYcCVeH5DeXRl87Xb0X96C7J2MFFYyFPFWbX3yKXTwajHyTbC8N6u17xL+Rh+UppzXG0lMX1JS4RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycAyme1911aUabMnx571/5wDAG2YyTN7WQtHx/Wi1l5m7i6BzU
	mcnfk9qPR+89aV8F569/0I/H33ompc+c7mnG/xNqVKHDvw69dHVc86oMF3j2iHCJRiz60WX4lgG
	KvD5mpg39K4JhHr2IPPuF5JIzOid2ZEFYxDzwP4Bb
X-Gm-Gg: ASbGncs3gclamPWW63Gfo5uZoYZupXNcOMHB/rdR1fNlwgN3JX8IyN5ioyZV6cbKYgi
	WiD6X+MlxEFlkzb7s41sRzFcnMjrVajTrQwvF/LSRSzBOZOAQVvq8PDP//VMqU9FAcVA4Ru5Vg4
	DCxyzsRKPXuZAzf2BO306SwAc131FO7slg4YJg7hicHb0=
X-Google-Smtp-Source: AGHT+IEhEfoqjIbkHcwkfEf7rHPPh/Cs3naakwtoQsBRoZnDEW8qtiSfj28zw2/Qo/yZMPTdMX4k6S0Alkr9IjUB8FQ=
X-Received: by 2002:ac8:5fc4:0:b0:476:8e3e:2da3 with SMTP id
 d75a77b69052e-4a7c0850e51mr120252861cf.30.1750947995521; Thu, 26 Jun 2025
 07:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-2-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-2-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:26:24 -0700
X-Gm-Features: Ac12FXwidOzDuqe5lzvesgR9L-zOn09C6mNGXXqsYLylMkVa2jNMECOk0tH2Hig
Message-ID: <CANn89iLjgDG5EB2nPWsS7GVmf360-Q_7OSZ3qRZb_SToOar8wQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 01/15] ipv6: ndisc: Remove __in6_dev_get() in pndisc_{constructor,destructor}().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> ipv6_dev_mc_{inc,dec}() has the same check.
>
> Let's remove __in6_dev_get() from pndisc_constructor() and
> pndisc_destructor().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv6/ndisc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index ecb5c4b8518f..beb1814a1ac2 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -377,11 +377,12 @@ static int ndisc_constructor(struct neighbour *neig=
h)
>  static int pndisc_constructor(struct pneigh_entry *n)
>  {
>         struct in6_addr *addr =3D (struct in6_addr *)&n->key;
> -       struct in6_addr maddr;
>         struct net_device *dev =3D n->dev;
> +       struct in6_addr maddr;
>
> -       if (!dev || !__in6_dev_get(dev))
> +       if (!dev)
>                 return -EINVAL;
> +
>         addrconf_addr_solict_mult(addr, &maddr);
>         ipv6_dev_mc_inc(dev, &maddr);

return ipv6_dev_mc_inc(dev, &maddr); ?

>         return 0;
> @@ -390,11 +391,12 @@ static int pndisc_constructor(struct pneigh_entry *=
n)
>  static void pndisc_destructor(struct pneigh_entry *n)
>  {
>         struct in6_addr *addr =3D (struct in6_addr *)&n->key;
> -       struct in6_addr maddr;
>         struct net_device *dev =3D n->dev;
> +       struct in6_addr maddr;
>
> -       if (!dev || !__in6_dev_get(dev))
> +       if (!dev)
>                 return;
> +
>         addrconf_addr_solict_mult(addr, &maddr);
>         ipv6_dev_mc_dec(dev, &maddr);

return ipv6_dev_mc_dec(dev, &maddr);

>  }
> --

If not needed (because of a future patch ?), this should be mentioned
in the changelog.

> 2.49.0
>

