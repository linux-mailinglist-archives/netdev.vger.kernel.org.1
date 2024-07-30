Return-Path: <netdev+bounces-113863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8E94021E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 02:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03416B21EE6
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 00:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43F2804;
	Tue, 30 Jul 2024 00:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9F0f6mp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2FC65C
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299256; cv=none; b=FVN2pIVg/x7I4yLuSILK9RrQGYSsxdY8POeoTWvwBBnvIsiisghCvx30usZ09ezfVZh3ks6Nt+ldmJj5OhA7ycWC0Vv+KmDyvEKDAQ+P85E2e2B9ZDaoX8TulbOTlXyRJDk0WwiDQblPGunHPF19j/pzMr38/SZD8VXVlXrqfYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299256; c=relaxed/simple;
	bh=3IeyO2RhK+k66d9jxQ9G43zeHK+JvNSS3UddIAPLJAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJb/Sbtz9dRefBJCEOp6flWXcI4cJTx6LMO2LqQ7UpM4eH6WBuA6uoX0/BO3DTbQIV+1lYQMWJZFIAfx4ynhqKCyrOBg2+6ImbWKBgkqDlc0XU3YmD8Hmg/zQGCJCEDm36pRF5FxgzsVnuJVpIQTEwaqfbhj2PxHSS/QTqkfMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9F0f6mp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efdefce48so949e87.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 17:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722299253; x=1722904053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgj6ohApZ0CvOmbZLqbR9I4uZZ930Pc6grld0w+KqyE=;
        b=Y9F0f6mpjBtTKowFPnsbCvRe3Jv9OiGrmHKnQs/8byMM9qvCkuoP0hRj4qcGI0J2gG
         N6PI4dkes5MU69vPMd1saZlffzOiyWmrSN3FJ2bNSzk0dgjHt0OaEsdrB236Q3rly3aS
         cZn/mc2EU5d/d+WVwsZEq1k2VTMafn3CkRhDMuhO0ddS3nMLWRsK2tieAloXzYlhwfjK
         HlCn0GrJhAVEGoH5d+Q57cfhgjJc6Zw39oBAn4nvWmMy/3sxpYg1stdlNBH4mB1jXRqV
         ngOwGbnlBLt33Ye683Exf03+NYXc7J7X8SFCrW31qK8a7/aNj9QaOVp+/Oberao5Iw/o
         ER+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299253; x=1722904053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgj6ohApZ0CvOmbZLqbR9I4uZZ930Pc6grld0w+KqyE=;
        b=al0fdw+XHClPrdMHLSIrHzpU7+hH8O/c8f/fYjmBHX5H8oKUW+Ehojo6WDYFcVprDM
         4c7XRLtdXmB4vd2IG9D7b7MVqLP/QIfDuFR4GrnioGG6JCOc0Ftra0dNetlzgdaqoLJW
         YZUOCksnq11vKEVSj44b3WTTTZyZDeqil45aYwaNcZxj6agB5Pj01WwAxRj/BDgxGpFz
         VHHK6sRL2uS0gM9qAkog9uoYGfBRGzGDEyET+tn1VdafqPsaaubQ74vCDaIWrw00e3c0
         wa/FznzzIufd0/U9NtYjJ7/fFl8kEdlCxUQQFBHGQwlGjCzMf6tKqZ9eMKdUiWF1lvqh
         EoXg==
X-Gm-Message-State: AOJu0YxpsqAlnF1YrvxIZMHPM9+y6DV6FlBPCToafOKDHoxJ+1RQRS1g
	Ik7MZcs9fcWcqsnGhhsqQYUEEQj20y/ZU8dR5zs113i4m8rrHM9+/ReioQWXI7yZS2AQ3uk5buC
	DSUFJEMTOy35sTpswTIB75PrBAH03auGoPyT7
X-Google-Smtp-Source: AGHT+IElrbADDNdXbCxhkaRLNDRghkpCVk6LX5gRZZV9TvxeRXLP/0m+/O/Hu11ofjRDHsXH0uecqffRfoBoCrf/4WM=
X-Received: by 2002:a05:6512:2316:b0:52c:b243:cd02 with SMTP id
 2adb3069b0e04-530ab36d495mr5126e87.1.1722299252838; Mon, 29 Jul 2024 17:27:32
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730001748.147636-1-maze@google.com>
In-Reply-To: <20240730001748.147636-1-maze@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Mon, 29 Jul 2024 17:27:17 -0700
Message-ID: <CANP3RGdKuZUxGe6o0yYpFoJi+KsVPbLUoEwpUFHTgrQHA6BzcQ@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6: fix ndisc_is_useropt() handling for PIO
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jen Linkova <furry@google.com>, Lorenzo Colitti <lorenzo@google.com>, Patrick Rohr <prohr@google.com>, 
	David Ahern <dsahern@kernel.org>, 
	=?UTF-8?B?WU9TSElGVUpJIEhpZGVha2kgLyDlkInol6Toi7HmmI4=?= <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:17=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
>
> The current logic only works if the PIO is between two
> other ND user options.  This fixes it so that the PIO
> can also be either before or after other ND user options
> (for example the first or last option in the RA).
>
> side note: there's actually Android tests verifying
> a portion of the old broken behaviour, so:
>   https://android-review.googlesource.com/c/kernel/tests/+/3196704
> fixes those up.
>
> Cc: Jen Linkova <furry@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: Patrick Rohr <prohr@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: YOSHIFUJI Hideaki / =E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E <yoshfuji@li=
nux-ipv6.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> Fixes: 048c796beb6e ("ipv6: adjust ndisc_is_useropt() to also return true=
 for PIO")
> ---
>  net/ipv6/ndisc.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index 70a0b2ad6bd7..b8eec1b6cc2c 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -227,6 +227,7 @@ struct ndisc_options *ndisc_parse_options(const struc=
t net_device *dev,
>                 return NULL;
>         memset(ndopts, 0, sizeof(*ndopts));
>         while (opt_len) {
> +               bool unknown =3D false;
>                 int l;
>                 if (opt_len < sizeof(struct nd_opt_hdr))
>                         return NULL;
> @@ -262,22 +263,23 @@ struct ndisc_options *ndisc_parse_options(const str=
uct net_device *dev,
>                         break;
>  #endif
>                 default:
> -                       if (ndisc_is_useropt(dev, nd_opt)) {
> -                               ndopts->nd_useropts_end =3D nd_opt;
> -                               if (!ndopts->nd_useropts)
> -                                       ndopts->nd_useropts =3D nd_opt;
> -                       } else {
> -                               /*
> -                                * Unknown options must be silently ignor=
ed,
> -                                * to accommodate future extension to the
> -                                * protocol.
> -                                */
> -                               ND_PRINTK(2, notice,
> -                                         "%s: ignored unsupported option=
; type=3D%d, len=3D%d\n",
> -                                         __func__,
> -                                         nd_opt->nd_opt_type,
> -                                         nd_opt->nd_opt_len);
> -                       }
> +                       unknown =3D true;
> +               }
> +               if (ndisc_is_useropt(dev, nd_opt)) {
> +                       ndopts->nd_useropts_end =3D nd_opt;
> +                       if (!ndopts->nd_useropts)
> +                               ndopts->nd_useropts =3D nd_opt;
> +               } else if (unknown) {
> +                       /*
> +                        * Unknown options must be silently ignored,
> +                        * to accommodate future extension to the
> +                        * protocol.
> +                        */
> +                       ND_PRINTK(2, notice,
> +                                 "%s: ignored unsupported option; type=
=3D%d, len=3D%d\n",
> +                                 __func__,
> +                                 nd_opt->nd_opt_type,
> +                                 nd_opt->nd_opt_len);
>                 }
>  next_opt:
>                 opt_len -=3D l;
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

The diff on this second version is significantly bigger (although it's
just unindenting a block), but perhaps this is better as it is much
harder to screw things up.

