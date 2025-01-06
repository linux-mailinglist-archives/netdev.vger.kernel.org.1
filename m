Return-Path: <netdev+bounces-155629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B41FA0334C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D667A0F4A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F09E1E22FC;
	Mon,  6 Jan 2025 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLaExWgH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116B1E1C09
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205967; cv=none; b=HUA6PqayPWuvm88bOAMjdUCdCNTYryR82O2HXNPpYojzErblKEJyZSxNyk4Uy3z73jrn/ahuMlXe0KobHmTIlT0Fx/2dVQA74xec8jfg1mfckZNFjRe9trUwYckdvVItFJ+tFKpzh2VpU0ucoCA15hezNpO1GSTElUjzn3tudd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205967; c=relaxed/simple;
	bh=k774zpeZHr2GUtijlC7wIOuXDtxUEqF8o+gidFyzgoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdW4cveSpdv2JU+NpxRJtktuBrE0n+Om3oY8cgTBWNvfjUo1tdL1qG1++DietZlR5yOlZeEr9oc/a9Vfauuti1ORZ0eER8ts5tAB46CCt+KpCWEKfDrgm0TiNBn9rKXWM+vl+q3rn1a8Q98yriUTMDGj12Dm1mwbV6dneJ+SU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLaExWgH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21625b4f978so41745ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 15:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736205965; x=1736810765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCR+MHidHJkdHeo9As7ODJUOIJVBOhU/iYv5JmbqqAI=;
        b=WLaExWgHy1aUw1R8GqBRfviC4CIW07nHsL7COljOlk37a9db0T9mIMbN4G6lCWRTzZ
         +FzK4EYoqwgGYU8IA8w5qip/7s/gY48W2D8s6KNoqPdXCyqTf8xVn0z0kSaT+LuqTCtq
         PIfs4WDzWDPpkJHrNM2Hrey5J7TwHOZgUwHRlGfIuB5lBCNDQda1XYSIFA4U5PTpNqj+
         O8XARN8HSZnxz3lA+kBJ7pcRQpsPUd0gvvO1xxVli2SL9dYTmDIVgyvuuOenuTHirkhO
         6Wzdar0YbUGKW2Z0lQn+RBDXIVdP4LLMWE+o/ohcuoHcIwtqTJ+5JMSxs1BATJpoKQ02
         g0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736205965; x=1736810765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCR+MHidHJkdHeo9As7ODJUOIJVBOhU/iYv5JmbqqAI=;
        b=q9YZt/OvGtppD9PN+WtyJ4XfEKAiAQ1+Eiq5WPenMQmsJa/prvjaiepQGlRtzPYb86
         U3vsg6MRpKD31y2/pSVqoV+BSveHyIXv02ixmf9ILiBsVynvaINA4a4ciEFdacepeLk4
         trPIoCykEEbemDvUROU/Z81kyhs28ZfL7hu06Q0+yZefbVhqOOC0c+4hNIrrQVH7As+v
         c0E0ESop7rVWboe6WSYIcTejBeaQizi+kj0NIe0S/dAYNVw1fa5YKElg/pBz7pIal3we
         BVcDPo1fKUFimfWeqwbBIxVFSQCh9dLajr1CYOTgJHSe5NJF/r6IM17YfJV2DxzrC6ze
         Gh5w==
X-Forwarded-Encrypted: i=1; AJvYcCUFywQMEbOwyfRexTdxDpOWXcxSgbEs/4LMGhS+1E2iq2cGOWTqck8dc9Ai9ex5hNOy+slyWSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGv0smN8h0X+TD+Wz5x5yI8gUmI/NoTU9d909wDn2pHoqFrJG5
	LHd7rrYDrKfW7b6ZXaDo/7mxFew4MKYgRVBmOSNU4+NwDQhhb9XZ6mgGSyONq/TW5zC+1vdztmC
	aFnBVzsEfWmkVC9iUDHFjXkKMgF2j5yxcV+F8
X-Gm-Gg: ASbGnct9MSuSWu0Bye2WQESigQqWpUBk6FATFRJySauHtgoqX3rLT1CngaksddGtnCd
	tHP3zI8USB53foYtCyHntn/FwyGomNhrqG1w=
X-Google-Smtp-Source: AGHT+IFVVEOJNqKXT3chAR+IGDHYd9laVjM8X11XT+9rLD5Pm03nLcOpVAoiBcE9aYNZnbQQkwC9pyU7U+dFFeV0cys=
X-Received: by 2002:a17:903:124a:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-21a7ac49462mr832815ad.14.1736205965056; Mon, 06 Jan 2025
 15:26:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106180210.1861784-1-kuba@kernel.org>
In-Reply-To: <20250106180210.1861784-1-kuba@kernel.org>
From: Jeroen de Borst <jeroendb@google.com>
Date: Mon, 6 Jan 2025 15:25:53 -0800
Message-ID: <CAErkTsR0Av6sFnabSSJ7TNtix8Y_QLX+xb6vShvx3P0GyV3w9A@mail.gmail.com>
Subject: Re: [PATCH net] eth: gve: use appropriate helper to set xdp_features
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, pkaligineedi@google.com, shailend@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, willemb@google.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-By: Jeroen de Borst <jeroendb@google.com>



On Mon, Jan 6, 2025 at 10:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Commit f85949f98206 ("xdp: add xdp_set_features_flag utility routine")
> added routines to inform the core about XDP flag changes.
> GVE support was added around the same time and missed using them.
>
> GVE only changes the flags on error recover or resume.
> Presumably the flags may change during resume if VM migrated.
> User would not get the notification and upper devices would
> not get a chance to recalculate their flags.
>
> Fixes: 75eaae158b1b ("gve: Add XDP DROP and TX support for GQI-QPL format=
")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jeroendb@google.com
> CC: pkaligineedi@google.com
> CC: shailend@google.com
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: willemb@google.com
> CC: bpf@vger.kernel.org
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 8a8f6ab12a98..533e659b15b3 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2241,14 +2241,18 @@ static void gve_service_task(struct work_struct *=
work)
>
>  static void gve_set_netdev_xdp_features(struct gve_priv *priv)
>  {
> +       xdp_features_t xdp_features;
> +
>         if (priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT) {
> -               priv->dev->xdp_features =3D NETDEV_XDP_ACT_BASIC;
> -               priv->dev->xdp_features |=3D NETDEV_XDP_ACT_REDIRECT;
> -               priv->dev->xdp_features |=3D NETDEV_XDP_ACT_NDO_XMIT;
> -               priv->dev->xdp_features |=3D NETDEV_XDP_ACT_XSK_ZEROCOPY;
> +               xdp_features =3D NETDEV_XDP_ACT_BASIC;
> +               xdp_features |=3D NETDEV_XDP_ACT_REDIRECT;
> +               xdp_features |=3D NETDEV_XDP_ACT_NDO_XMIT;
> +               xdp_features |=3D NETDEV_XDP_ACT_XSK_ZEROCOPY;
>         } else {
> -               priv->dev->xdp_features =3D 0;
> +               xdp_features =3D 0;
>         }
> +
> +       xdp_set_features_flag(priv->dev, xdp_features);
>  }
>
>  static int gve_init_priv(struct gve_priv *priv, bool skip_describe_devic=
e)
> --
> 2.47.1
>

