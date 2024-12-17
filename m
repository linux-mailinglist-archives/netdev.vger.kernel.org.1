Return-Path: <netdev+bounces-152505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F739F45A3
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210D1188C326
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE0718952C;
	Tue, 17 Dec 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQESHe4h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD2288A2;
	Tue, 17 Dec 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422613; cv=none; b=I5PHu+92jJeJMT0Dpcfc+tj6OFkNUSCtKvukzs8dmEyfu1D8Es+P8JRZj3O8OgAltnBD1TXafmlwLrCRWPvTrkdduZy3qKgo0hRVvxfYyYgosZX27LRmpD6oVY8j/4v/jfHSnrOsLRCuXy1GoBGFCjuIVAvBOVwHQWak5Gd8kEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422613; c=relaxed/simple;
	bh=NgamYC8cJquApLL5URatb+CGOC/W3TZppVHX71VqPz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/nXH8fhLBoTreOMdy2FXmDGTfbKdyN+5X7FO/Q0ZcZpGz4vKRclleGgEp1iz0y6xNHHFAk6690Ceqqi/62uFX78fWpFQbnGJ/mgUYv7IJNlTrTPd1nRaSFDiv8g1izH3H65g/MLTSk2AR6Xu3w5l1Ynzn7U6nhlc4x8v0qMHrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQESHe4h; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef66a7ac14so56748447b3.0;
        Tue, 17 Dec 2024 00:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734422611; x=1735027411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj96oH1DOgPsAsfx7X7JlJNQT7Oe+0uriUt8dn6RoMA=;
        b=FQESHe4hlkUyiVaIvC6aTE65gG0eTUXdEpC75dYa9uJZO6crDlI+QbpBpOfIs/utE6
         uj7Iga4qld2jUtMaz9P585HnuO4Mb0pBZJA0oILsydbE6HZwXhxSt7LU7YwBqDEP8Ofx
         j0dpDOKXGiqSOXd45fj1VlF1ABjMwFLnVJQM+zqnHyiTHpwv0I5ld+YSmzv0xcNONXeq
         uPwQ6043laJLX1Hbj+CuP9mxXh5lmCvLogr75NDC86vi+fwVxo0PtTh4R+8UV0qlxNeY
         UP2/VuaL2EdJpIYlPubHTpxaF2ZzR++jinSyleM1FWd8oOuQJS7iU1VgWbPv3n0MCR5n
         rJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422611; x=1735027411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oj96oH1DOgPsAsfx7X7JlJNQT7Oe+0uriUt8dn6RoMA=;
        b=Gw1vJXXSp6F458oQQhVeAL33dlWFCXA6rwWo+BqxLsgdke1a66xyXKaBfgSBcpzQh1
         SDvfy+SzSDl4Qih9G2VvOEa19lmHtgQ7xBdUB3O9R2dw3fjtjkGfkNLLuOHj+gw2fCkb
         MJN9H1BKfipQD9yfc/FNC/dXCb+FdQQc1D80UHDW0lQBppT+pvlLQ8+bparK1DgcyELt
         zy2yurtFFJLj/P9z1HrCH9E7ykp5H+mbm6gCuds5LxKAGxahzqMGNE5xFlRVvlE1i/jC
         U0c5sEvxyJ182oSq8bSEyUFcUnzv4B7xdFi0Bu8P4uGvV56ZDgb1RaB3gfk0V1Xh2jgO
         njuA==
X-Forwarded-Encrypted: i=1; AJvYcCWx67Q1HyL2zuihDFEQruIrkl8jLSNWD3TVJSvj8F1sMbUkVfRTsiXaQE+gtlU+xo05boOd0p/pj1WVwln+lxk=@vger.kernel.org, AJvYcCX2cdSxcMnHz/KJ4/nyfMBwfXk0gYIgdtksWYTeTld2THiLkoU0N84i5u8EP3Gm/3RVpe3fXLjcSUxFmvug@vger.kernel.org, AJvYcCXFI6AcOPLtORd/xt/zjV1o5ilSjbts5oURexzqlaFGq5VxJ+D7L/JcrDJvefblY3Gaj41YBg64@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv8OGYr978s4PSRBpf2gUo2Swb/oZa2SjvHKEPDSaMsWDMt5kv
	C/LozmmymqGA1k5Z+1KK77byZHTcT+wc5Tc0ibyiGE2NBqlg0rv2ZxhWTJbqpWmtNXUiQff4Ao6
	RZgr83vQSsapV5cfCPG6IHwNvAVI=
X-Gm-Gg: ASbGnctBqByyX7APR/dI3q2zQcq4EBnthRZTJPsEeYqACUu5cb3XcuRE9KcLjyEPqRy
	kUyOkGcYe1ueJ2j6Bi/iwIjJJb5HrhjaxcXreX3EuwsUARZasSt6dTp/OjUWdaS8e/UthEPX+
X-Google-Smtp-Source: AGHT+IF29xv0SwBMtXwtMISpjFk9CjnFAM9hGctuUD1mZExG2czaJ9ohAKO4vZYzuXWekm0XNLaOT3nYxqK5YQXYPe8=
X-Received: by 2002:a05:690c:3343:b0:6e5:adf8:b0a8 with SMTP id
 00721157ae682-6f2bbad6d2amr23344097b3.6.1734422610892; Tue, 17 Dec 2024
 00:03:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217020441.work.066-kees@kernel.org>
In-Reply-To: <20241217020441.work.066-kees@kernel.org>
From: ericnetdev dumazet <erdnetdev@gmail.com>
Date: Tue, 17 Dec 2024 09:03:19 +0100
Message-ID: <CAHTyZGz4T80-gvSaY8hp_bspiL5SVr1mJd7Z1Vv0hVxnvQvkwA@mail.gmail.com>
Subject: Re: [PATCH] rtnetlink: do_setlink: Use true struct sockaddr
To: Kees Cook <kees@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 17 d=C3=A9c. 2024 =C3=A0 03:05, Kees Cook <kees@kernel.org> a =C3=
=A9crit :
>
> Instead of a heap allocation use a stack allocated struct sockaddr, as
> dev_set_mac_address_user() is the consumer (which uses a classic
> struct sockaddr). Cap the copy to the minimum address size between
> the incoming address and the traditional sa_data field itself.

Not sure what is a 'classic sockaddr'

>
> Putting "sa" on the stack means it will get a reused stack slot since
> it is smaller than other existing single-scope stack variables (like
> the vfinfo array).
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: netdev@vger.kernel.org
> ---
>  net/core/rtnetlink.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index ab5f201bf0ab..6da0edc0870d 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3048,21 +3048,13 @@ static int do_setlink(const struct sk_buff *skb, =
struct net_device *dev,
>         }
>
>         if (tb[IFLA_ADDRESS]) {
> -               struct sockaddr *sa;
> -               int len;
> -
> -               len =3D sizeof(sa_family_t) + max_t(size_t, dev->addr_len=
,
> -                                                 sizeof(*sa));
> -               sa =3D kmalloc(len, GFP_KERNEL);
> -               if (!sa) {
> -                       err =3D -ENOMEM;
> -                       goto errout;
> -               }
> -               sa->sa_family =3D dev->type;
> -               memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
> -                      dev->addr_len);
> -               err =3D dev_set_mac_address_user(dev, sa, extack);
> -               kfree(sa);
> +               struct sockaddr sa =3D { };
> +
> +               /* dev_set_mac_address_user() uses a true struct sockaddr=
. */
> +               sa.sa_family =3D dev->type;
> +               memcpy(sa.sa_data, nla_data(tb[IFLA_ADDRESS]),
> +                      min(dev->addr_len, sizeof(sa.sa_data_min)));
> +               err =3D dev_set_mac_address_user(dev, &sa, extack);

Have you added debug checks in dev_set_mac_address_user() to make sure
dev->addr_len is always smaller than 14 ?

I think we support devices with bigger addresses.

