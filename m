Return-Path: <netdev+bounces-195454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD16BAD03C9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213DE17454B
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035B288C3A;
	Fri,  6 Jun 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtfkfdBX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D66171C9
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219266; cv=none; b=dQjow2+DxWaIG+/bSlWv6w5Z4BjG3R31+Q48e8329kQR7e5cVzB2MDHGvhfIieR/EnYfQ219eg+l9EPQ5c05VEROTbbSaRn/3w9OCbP6keP45in/RzbEsNbp0T6ojuK/k68AtsmkvbacZ2PAKE6A2gGzyUCi3MHtop9qRoj499w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219266; c=relaxed/simple;
	bh=cJR4xtjiaA4wm7E8Tru4XigM5sB8FdydifKhmuSt/kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HksJ0dfrNw0rKeobmk4qy04HlBkdlK8YKTKh8XV/s6b4jYJLd4RZPvnAP/hXFHEXPlBtPdAugeXiX9d8Q1LuCn2vl9pEfetkT7jX8dKgKY98zSfAG5LMZP5Zu57WsUmz55y3wQZVyQqdGq+1WqpPaj//cxm/x9282Jb58309Rs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtfkfdBX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a56cc0def0so34981401cf.3
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749219264; x=1749824064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bbr5FD/qyZU5d3nuLflIQu/SrgJWifjJFAM1Ft2QlK4=;
        b=XtfkfdBX6n4FwtEwopTn6vyYJ44ktqQMoOoMwT4B1kWvXbwBSyWr2wYMyMcm9eatHd
         5fWswjdrPDoIYRav+sEwo5r0TMAWre+Ts3xyGO2NddOXxRG/79wJB1b2k7p2/sSTNN+O
         SkOoAM8H6osQjDguO/FycPHOU+Z3loSpLZNaBr6/kk02N+ltyHcRIR4UF0kXyj/sRbTM
         ERCNxs2elFTgaAirlg6Y/I7rtAFakHULu08YXUO1+ge2kbxHE1wRyBrvXddIRmQwnpIm
         7wcChGTL0X6aRA+QQuGnfcFZkjx5NI7CkRApZYHhqhG7L8KinOHY52uwz3rgI9P/8vmo
         R5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219264; x=1749824064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bbr5FD/qyZU5d3nuLflIQu/SrgJWifjJFAM1Ft2QlK4=;
        b=KuPxjv2xMjyQraVtF3H95cd6xwIHlkYg+HidwSmGUsaoMDgkC6Pqy3zKUcMIKl6hJT
         SpG2beyjx0ft9/stlhtD5neX54c19MR42+UJ1omMyMK9aNubPs38gPiXOQL/AKhIk9yN
         eshfPqs3GjeaEjUlr7VvK4kw5BXk9rj9IZ7j5StfBO23dqeQ2fxTm17x8xe5bqyAbdsM
         a9iTBnXHeg8jLaEs8eGrlh1rLdNOXVLmpPtGNPJNqZiOmzXyLw7yVqaTEQOFZbcickt7
         OwRQLWV6BDKoEx/RHrsPL3PCYfrRYJOlc/ASjfR4qL3Tuew1SDO5waPo+6vvlK0QOVLP
         pM7g==
X-Forwarded-Encrypted: i=1; AJvYcCVDSlwgb+Pu1EbIBVGndEGr5VAlLC0dYrNyvj439N1hev1irZYK9TWsFrU4CIBPbUVHzZa5l/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8yunEO7aUtXJkUysx8uarsyH/Q3QdrYfH5exvgDCwNBoIQDhf
	cjEffOcbUVDyTmAoTctoXpZLPPteyg9E8HezAqWKYl+A+HW2kkSHKTSXMiFSHetkQF4Xcoe1PRV
	HGKSbBS5wldfgqcitE6lWCwSyJVXJeSfugqYf+7cb
X-Gm-Gg: ASbGncsdEscP02PP1X7DmkKcjAzIssngA0a4Gkm6uKR0IJzwKi5rsYZI9CDmuf9afrf
	dlYrEH7gNSINndw+rZGg2k58VeAIv5tv2Xng+ziNTumwdH3pDPXo9KgsmuScx5GBSdTARPwLeyV
	2RReYTdfZDLzOSe73cl2lflO+87PraEXqKSgmTzceb5kg=
X-Google-Smtp-Source: AGHT+IEfpGAipVMOvER7WEo8x0oAHPJxVuaqd/ptFxJpu5UTCgHSUl8JJC+yQxORAkTuYHG25+LW2GGpF/6Uw+QnK8o=
X-Received: by 2002:a05:622a:5509:b0:47a:e13f:2569 with SMTP id
 d75a77b69052e-4a5b9eac7a4mr61005331cf.35.1749219263436; Fri, 06 Jun 2025
 07:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606075517.1383732-1-dmantipov@yandex.ru>
In-Reply-To: <20250606075517.1383732-1-dmantipov@yandex.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Jun 2025 07:14:11 -0700
X-Gm-Features: AX0GCFvqvHm9nG2-ssHb3mv2LJ6iZDD-C5Nx8RdcOHvSh8vphJQ3K8g0ziboODc
Message-ID: <CANn89iLFO8W6zDEBfoPzUMsAK4Pvei_gcUYufu+s8EYcit=MFg@mail.gmail.com>
Subject: Re: [PATCH v2] net: core: avoid extra pskb_expand_head() when
 adjusting headroom
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 12:55=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> In 'skb_realloc_headroom()' and 'skb_expand_head()', using 'skb_clone()'
> with following 'pskb_expand_head()' looks suboptimal, and it's expected t=
o
> be a bit faster to do 'skb_copy_expand()' with desired headroom instead.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: pass 'skb_tailroom(...)' to 'skb_copy_expand(...)' since
> the latter expects the final size rather than an increment
> ---
>  net/core/skbuff.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 85fc82f72d26..afd346c842e4 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2316,14 +2316,10 @@ struct sk_buff *skb_realloc_headroom(struct sk_bu=
ff *skb, unsigned int headroom)
>
>         if (delta <=3D 0)
>                 skb2 =3D pskb_copy(skb, GFP_ATOMIC);
> -       else {
> -               skb2 =3D skb_clone(skb, GFP_ATOMIC);
> -               if (skb2 && pskb_expand_head(skb2, SKB_DATA_ALIGN(delta),=
 0,
> -                                            GFP_ATOMIC)) {
> -                       kfree_skb(skb2);
> -                       skb2 =3D NULL;
> -               }
> -       }
> +       else
> +               skb2 =3D skb_copy_expand(skb, (skb_headroom(skb) +
> +                                            SKB_DATA_ALIGN(delta)),
> +                                      skb_tailroom(skb), GFP_ATOMIC);
>         return skb2;

Please read the comment about this function :

/* Make private copy of skb with writable head and some headroom */

So the skb_clone() is needed.

