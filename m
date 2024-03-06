Return-Path: <netdev+bounces-77807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D18730F1
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC401C229E0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568C5D74F;
	Wed,  6 Mar 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlErZmx6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A164A
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714444; cv=none; b=Fvyrk4tcH8GUqVukpTbw1bkuOJUVJmtI85f8DADOIKGQvOR1pfRp4DL1J6vzspqBRh3wQ4OQFeoNGg/8Amf1qpxDc4Au4jqCP6QjSDhMAjxuwxp+INnxAIACrBO9I5hxQYnQFB2E9mUTKiy0lMK7RvWE7Np+lj6qw+yYVJVEbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714444; c=relaxed/simple;
	bh=fTpCsu/6ZU8FqxRTRu6JSkKCSAuqJJxd7/aHe9Dj+Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkEpWXKQIwZu+HH8tUyr76KySR07l72bADIdX3TM8EFq9FQ7prZaCd9ZBiHuk5a26Trg+DlUz5d5033faji7taEkGAYwGfaq0meoYL0V76C8+wFPGXO/ChSdJpkCLWY7NY4lrrHnuNtFPd9Qu8KcD0U6bjZrGWwTn4CL7XXEljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hlErZmx6; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so472014276.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709714442; x=1710319242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTpCsu/6ZU8FqxRTRu6JSkKCSAuqJJxd7/aHe9Dj+Hs=;
        b=hlErZmx6J6GPQEvmUMXt1edFiYBzJOqKoxvbhs7jlQBisypnmwbWqDtLNWh2JF2lyN
         57127EPzsCZyZ1tKRQARit7+AL9lT4kUAItNBvUKn0kUVazoie9VfNKwtJsAOReb37Pg
         iFlTvNA+cQblELGsFJjdxrqaMfNBafammmBTBu+tUMquFrmZaqwfN74ihj+Zv099zncz
         nyh81as2fCXzUq7d4bZ5EeXK9117Q7IQ1Es0HFucB2few7Cu+8eRNtZ4zhOq2JmfgCAc
         Wn7c56u9ULxxYOkJ0Mno0+4DciFeQxP8pLXarw0P5fehrHBY64bX2FnbmHHLQ4b3bVW3
         mHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709714442; x=1710319242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTpCsu/6ZU8FqxRTRu6JSkKCSAuqJJxd7/aHe9Dj+Hs=;
        b=g2kFMyLyEx9DhLP/tEE1eTworHkkzTcT6CriSwSk86B347zXMExzBXyA+oo92ZFR0u
         K1pmRK0mo7gfxAI/so5268nSuDp6Uu+f46UPuzZLv4JWMl116zSNzQPL/keJV3QvI8QC
         9IM/qGn5oDM0wD2K+JrvNEXKjlYvHo6bFPMukZqb7XUlGF2i9xBBEIrqy9pPb9rOyzmB
         9mKDixoL40oy/Nr7vgjxwfKsp1+Z/qFjAq1BEvtV1Ghzj6CePAnYQYuIwHYjZhILbIl6
         4KDUOTpV5r2OD0+3AxUoPZX0JqYO9wMgi6bYm9iHfVPfhDqyu4jQsIHwSeyPAdmFxWFo
         8dgQ==
X-Gm-Message-State: AOJu0YzUjRAexOcX/b8BB0MPa9YdoYVgMN4lQ9hhiIi4KxyCvixKx/aQ
	AsqsqLTsLwI10VtXvOJAle1IynqJ3nsioc/zaS/Q24UsKMpfyXQ3m8K5i34j2ewJI+OA0EkRNGy
	uZLJAD8VDta9co+5GLgJP+gZiLDRaGtBtk7R2pQ==
X-Google-Smtp-Source: AGHT+IH2IIOi4/G0T0oMvBWo97Egq4HVaVZ0DhuUsr7rB6Y6OQ2qfSF+eTVGsPw3Ib6o6D5CqXl9NLJGpCn+DMkI6UE=
X-Received: by 2002:a5b:10f:0:b0:dc7:4265:1e92 with SMTP id
 15-20020a5b010f000000b00dc742651e92mr3968571ybx.23.1709714442391; Wed, 06 Mar
 2024 00:40:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com> <20240301221641.159542-3-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-3-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 09:40:31 +0100
Message-ID: <CACRpkdbFxS_f1z=N-zZyxV_Y9kLDqHSGwwibV8kF8RgmjNLSkA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 02/16] net: dsa: vsc73xx: convert to PHYLINK
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:17=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This patch replaces the adjust_link api with the phylink apis that provid=
e
> equivalent functionality.
>
> The remaining functionality from the adjust_link is now covered in the
> phylink_mac_link_* and phylink_mac_config.
>
> Removes:
> .adjust_link
> Adds:
> .phylink_mac_config
> .phylink_mac_link_up
> .phylink_mac_link_down
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

