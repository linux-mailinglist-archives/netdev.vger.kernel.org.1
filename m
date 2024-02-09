Return-Path: <netdev+bounces-70520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E2884F5BC
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FF11C20384
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209893771E;
	Fri,  9 Feb 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkOQyAU7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9EC28DAB
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484920; cv=none; b=X/WK+9x7uj83AN0jI6qRu94BbU6XdBJA/FypwiYCOxPJUG3nWcPJv/IwpE+GKCj6K1pDw1AHcE2pR01jOxnecyCi9KGWAEHXcneXYuKK4guetWbglviMgocwuf9AA8oYwZArYMG0h/PSwqYHX07EfXQDrvJlQYK0VvzxZjRJgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484920; c=relaxed/simple;
	bh=449r/RUz6LocfxD8zQc0jYXaYXqGJOsiyBdFbqy3Nuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8UMelnTTocD5sn+mFIT86YS5e8u7mYhh3a64EPiVHLUJJP6WSjozCnBhbHgRtT9yJ72FyAuPGCODXKqGv9jwUvFVCnM40nwRtESuvNR1AVnvuZ95wlCziCIQ+LQgASl6/ZY+CaNjjzCPxRiHv4V0QQN0+dcUt7UyyFXzcsUTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkOQyAU7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-604a3d33c4dso10371667b3.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 05:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484917; x=1708089717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=449r/RUz6LocfxD8zQc0jYXaYXqGJOsiyBdFbqy3Nuc=;
        b=wkOQyAU7m/ysIU9IrkUlYRBbRDZLaRzdMGbnPURlOwhyb6EIGc0G1+rCMssgnIQz7M
         EWy1JxlzVPVlfcxKsYq311uKbHTgwj409iNdoNNKsnEtVU8zyIayfEi2eUq8joSsIUtv
         CxWMS6hfkomUcGrgLqrO0uE3bQNMfXNoWuFar1NQXh1yV/dG+mqaT8lAu1EhfQZ3dKcD
         ZC6Xz87SBz9LYV0IZuPPqO6PSqxrDsS7U96gqTebBoFWEFpwQsusAA7xETz5c+lsFvOM
         Hft/lRistIN/QlTcTjWfTEcpJe70rMXBT//Vjbs9p8jLFVMrNsTNc4f987PJJZakKXcL
         D9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484917; x=1708089717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=449r/RUz6LocfxD8zQc0jYXaYXqGJOsiyBdFbqy3Nuc=;
        b=iUBEGqlsWpNennRJdp86ATJKwA6oNoPVtdwCd72tzn9B5Tz/rAbLrr4RQHbr66vf4p
         KDH8SDxwb0PeN3Fmfn3UCDiEtl+4gOil6KtlkfWYG5s/nB6sOCEBQgJOYvqnjV8nnsn2
         xtqui5zCjcZWrKZYy5syqBF75kWgG0O4iQusHD6T1Pj/l0jgnB6AM52nmoQuU7NmDED+
         czDpSqno7OJ21L9ZeHKzdO54piMejHLft5WNKXO3WzHZdgrd98u9YUKbvT346cXubXDP
         PlKWkvvMfC+Wxzu1kBr3lk8gRvzQCq4Tbps6VVN2nfNp+lK/uZWev5Ly36QznHD3qcQB
         M4hA==
X-Forwarded-Encrypted: i=1; AJvYcCWsuU8Wv7N7vck4NjDxj1p2rmFZxEfu8w/K0ZpNx5HTBcEo8+53jbkFb5NJxPd2xJFwM3AJwtr6bt49fMaJ9fXJtLl6wkyf
X-Gm-Message-State: AOJu0YxbakfwBaMfvvB0ezXGeLl2ZoMSS25+cCQQECGTspeYgtuGFwzK
	YwFL4hfnauzzvXNuQQK2GpdQ/MA2vQjG6vYHvJY2rGs5OSdqhP60OeLP09U/M9AgwryzAjJsIeX
	Qkp0+cG4dZtCMz7Ii2aslXa19Ivx/tixJ9Li87g==
X-Google-Smtp-Source: AGHT+IFvU7fTM/tIDF5Rn3dZ8AMfk0ncd2+G5oiHKN54Jzli80+CClnsvwFyIhmwrOkcVxv1gLIUpyarXk8Jx3YeKN8=
X-Received: by 2002:a0d:db4a:0:b0:600:39bf:495f with SMTP id
 d71-20020a0ddb4a000000b0060039bf495fmr1606509ywe.2.1707484917624; Fri, 09 Feb
 2024 05:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-8-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-8-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:21:46 +0100
Message-ID: <CACRpkdbD72P+eR+GjVEfTtJab3iO-K2khyVLQhxa2_snED+Xxg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/11] net: dsa: realtek: clean user_mii_bus setup
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Remove the line assigning dev.of_node in mdio_bus as subsequent
> of_mdiobus_register will always overwrite it.
>
> As discussed in [1], allow the DSA core to be simplified, by not
> assigning ds->user_mii_bus when the MDIO bus is described in OF, as it
> is unnecessary.
>
> Since commit 3b73a7b8ec38 ("net: mdio_bus: add refcounting for fwnodes
> to mdiobus"), we can put the "mdio" node just after the MDIO bus
> registration.
>
> [1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/=
T/#u
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

