Return-Path: <netdev+bounces-105812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D307912F86
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 23:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536581F23E78
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 21:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D52D17BB1F;
	Fri, 21 Jun 2024 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1EKXX/q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D24A3F
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005260; cv=none; b=KiAVXIz2mWSYeODKjWhlouv7OAG6PMo332Mf+JbOOrq11y9bAT+/R31NQFEYlA6mru9Ly1mnXviVehYu3uDEuEoIHs1I2oMwm0cYfQeXFHC7AzuPTunZ5Nf1zFeFicd88S3cmoMnz3e1P1lnv88W/0/iYLAz2vTx6pzVfhUYmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005260; c=relaxed/simple;
	bh=uMNzYRIgleMfYnwYF+a0ZGkYj4KN0oRJZLd7rVFB5WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vE2l6NXlGbZSgVwbgHjCvwlcX5AQjiq0xbHLw7yvi2s4RGH3n7iI9kLG75PwXIzIebY0q+vtH/0LB9dTUMd3rH1TG75L68WP8SydECnnlS2P5p8qtSvj3m3+dH+SlINYjdJQwPo2d1rvk1rGMy5PY1BMiaad3jeYkbkTJDsggdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R1EKXX/q; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48f36f57a5aso335830137.0
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719005258; x=1719610058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9YYJN6gO8sKB5sQbYzsaO+MvxbhNg/Nzd2XouVD5g0=;
        b=R1EKXX/qUnfHZeXz1indkAsJn+QxIR/qE+0LNhJX4SyafRv8wlD8Aa4GetPSAaNw6L
         eJm4mrnkw3EG9niWz8pLAEjhPRgByHILE6cQXXephaugj6q16TzpsXGXSq4g/aOmiiHG
         DAyzFEvz0dXKwlRg7pZgXqWX6w2GECeh/wNjcR1n/Otjghf/uVH1a65XSlJ0fOpn2yge
         STDeWRC3g59k1MtP+wB0O7vTx7JvFHMFjRZUj/VlsXP2WnT0bymJBtN3PqKLXPb7yu9+
         9NlFXNUcg37RWUMW6z2f+fB7v41nRHdMAzJKV0QhcahcmweJ601G6cG0KIs/0GDajq1G
         7CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005258; x=1719610058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9YYJN6gO8sKB5sQbYzsaO+MvxbhNg/Nzd2XouVD5g0=;
        b=wL++5jxbDkmnCxkWM3Mi5RWJJ3HwQFraxGqnpchnMSQoMTYN1blx8zNE1erHGoUpzu
         4O9SJOitMYctVU39bMLp3tM8OpJZVYx9RUOppZ1BU0IKqidecuKgbc2iKAw1MNy5Wq/g
         cAiTaDKZjZJIomK7rvJ6q2yXRk8Cgar/UddVWRmyy+nzaC96FHbeoTVWESPfrvBEFZ63
         YhzYGf4E1zCvJv7swn+psc1wEXywUGys3N2Jnd49fJqiZAV7JJNCjwdZMgjFW4/M1L95
         eQlwo/qpebipyD+tUDU93GZGyQIinntu7+GnsWKJJ4JD3U4MrT5M0TSI9lEFfmHCJNYY
         GYrw==
X-Forwarded-Encrypted: i=1; AJvYcCVhrrWEG9vsaV87uDk64vRSICE2wo3qOHaraJp9uU2qIAp5n91ju7PafcdL4cShnN0CnIhJvgXSDaOaqHjHJs29v4aqoaAv
X-Gm-Message-State: AOJu0YxGg20Dsdt4fRdtyhJMGphNY4635TfVfq5cf4KHS/pyxVp0L5V1
	PA5iXDqmKU+3WWyrYFW1YPtzztcJG2DtNpN7v5g73qhIugvVYHry0DuQJNhs4EW8LDLj9uT4wCm
	a5MSzPu7g+Ms8YvGqYmSOgTnx1dHFt2dtr90N
X-Google-Smtp-Source: AGHT+IFJsXHscUZN1ArxTSIV4VXg2gnQo9OEeHipRr4oFQUE6eYw6FyYq4qABzIJaAuPwBpxGEH9hruTNr2gkbg4xXw=
X-Received: by 2002:a67:e20c:0:b0:48f:3fe2:1560 with SMTP id
 ada2fe7eead31-48f3fe21584mr2043664137.11.1719005257518; Fri, 21 Jun 2024
 14:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621211819.1690234-1-yabinc@google.com>
In-Reply-To: <20240621211819.1690234-1-yabinc@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 21 Jun 2024 14:27:25 -0700
Message-ID: <CAKwvOdmYWEp8SaksnereMRPBq1q614kWJAWtcSyAeTVZ=geQfg@mail.gmail.com>
Subject: Re: [PATCH v2] Fix initializing a static union variable
To: Yabin Cui <yabinc@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 2:18=E2=80=AFPM Yabin Cui <yabinc@google.com> wrote=
:
>
> saddr_wildcard is a static union variable initialized with {}.
>
> Empty brace initialization of union types is unspecified prior to C23,
> and even in C23, it doesn't guarantee zero initialization of all fields
> (see sections 4.5 and 6.2 in
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2900.htm).
>
> Clang currently only initializes the first field to zero, leaving other
> fields undefined. This can lead to unexpected behavior and optimizations
> that produce random values (with some optimization flags).
> See https://godbolt.org/z/hxnT1PTWo.
>
> The issue has been reported to Clang upstream (
> https://github.com/llvm/llvm-project/issues/78034#issuecomment-2183233517=
).
> This commit mitigates the problem by avoiding empty brace initialization
> in saddr_wildcard.

Thanks for the patch. The links add a lot more context.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 08ec9af1c062 ("xfrm: Fix xfrm_state_find() wrt. wildcard source ad=
dress.")
> Signed-off-by: Yabin Cui <yabinc@google.com>
>
> ---
>
> Changes in v2:
> - Update commit message to add/update links.
>
> ---
>  net/xfrm/xfrm_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 649bb739df0d..9bc69d703e5c 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1139,7 +1139,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const =
xfrm_address_t *saddr,
>                 struct xfrm_policy *pol, int *err,
>                 unsigned short family, u32 if_id)
>  {
> -       static xfrm_address_t saddr_wildcard =3D { };
> +       static const xfrm_address_t saddr_wildcard;
>         struct net *net =3D xp_net(pol);
>         unsigned int h, h_wildcard;
>         struct xfrm_state *x, *x0, *to_put;
> --
> 2.45.2.741.gdbec12cfda-goog
>


--=20
Thanks,
~Nick Desaulniers

