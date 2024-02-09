Return-Path: <netdev+bounces-70517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6462584F5B5
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032501F22131
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9643771E;
	Fri,  9 Feb 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X24qYcl2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE2E3717A
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484834; cv=none; b=cb7QdzT4dwDXQv49kVKD3XyIOzlo5tuhwZfCmuq4EVgCbLl6oOWjNsvzGZXvv3yktWLUJBrpXZFm8u5Q4HYro/eW2d5PksMjp+enfjNHVEFZYEtL2dJZxqxLfwXSqk1BETBVE02EzjXqQ7AaX6PZVoA17ORAwhnWLrVu16wJe6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484834; c=relaxed/simple;
	bh=yHV4xD6vA5uk0R6Dh4WYIT0pSu9+jAt1mKXfWSKM2do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFuV1tx61y5W3XE2ObV65qJIqavCmzHdOROGARpNrKZ1hXqvTIrI7qxLTwud6J5hX8QUYEALqw6GLxuULgvg6d8pHAxIdYPKx0OweFQFKWpok1oXShmc/HmzQrOE75wUhucuzln4WWl+lOS+lUSgBhFzNF4X1ODaPUrPhhI5tFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X24qYcl2; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6002317a427so9150297b3.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 05:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484832; x=1708089632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHV4xD6vA5uk0R6Dh4WYIT0pSu9+jAt1mKXfWSKM2do=;
        b=X24qYcl2NWLm9SXvPG0vqETFeGHM+OCT82MbulmC+FlrmY2aFDqt7dpsOn2qNuh0jf
         AciIwr+HvE7Y4h6t+6hC4PhrclT1qcTw5dBUWmOwafy7hrNX/gs4LOX/Ged0tqm8YQgJ
         PVrSYHlCtJR6SlryCMDZSFVVEqAX43V+l7QjSSPu5gtkh2y1t2uU/0T00LiTTVwAK7mL
         zruJ/BjAbyP8KeSwPgvmaang5PZpJNot5ANKAv4bFyOTtj2fsFYOTqOJpnSg7zQxPWmX
         4Qo51Eq0lgS/2LveK61oSgknetek/RkniZNys4F2m1oz+4MLB/+e6YNoRhANuZbcgKdc
         ZLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484832; x=1708089632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHV4xD6vA5uk0R6Dh4WYIT0pSu9+jAt1mKXfWSKM2do=;
        b=GXE/wasP2wqPbZeJh/l8VUXL2p7AcoJliNGdSD/Icy5tyXCjqxuct/VjumIPPJlvTV
         /qhXuYux9PfM36NIogj1TVhQtKMXLSTW+v0tl84GABrLNwOVrqfFMwAYzaf9tD7MVw9U
         RO373ZmSno2f+66lqp6oSNk4Hip8xv/1HPCJV/dPgaM5hSdPt9m4jmKhyJYDtIu7GNfB
         b49g6rWVNT8ZcgaFRQTK0bwJXgfIloBc29VPTnpWjccmrlbWXfSOR9rIBQt4EJnZ1v3F
         j6ytCKDmS55OAe+wpq4vWl8LTTLO3/lcbmHtUB2ZASrChoWaNCVtFQhDWjImTRL49z1m
         NMgA==
X-Forwarded-Encrypted: i=1; AJvYcCXLJEDQ8cCVdq3ZEyoeR6rmdlXZtbJPd3KdMPjvDcuiD8Mxu1Ehm749lY/KM0oTMsONdmezjSB/M/BjCczmse8VWvfmu3fG
X-Gm-Message-State: AOJu0YwVIY0PUqSih2hpKvcWQexSAXGrrploFHWPwCgVt672WqIuxB6K
	J95lDmD3jJLoyPMA9ZjS+Z1EW3ui8f7bcqcq7DJixSr6HHO3EP+ZRq6dFMj9jRDxzPhmxHhxFYL
	Kqeh8sicayQ8p7LpcVBZ8Iz8Pq9JIEObaD5/hvA==
X-Google-Smtp-Source: AGHT+IHzXhEAUvFgEV7wiolwPKaeO/ClVjbm4bCy3evX9EHgeTDtdwoxMk++CSmO+UGJKh1jRTy9lxWRLSFBSBxcRTs=
X-Received: by 2002:a0d:ccc3:0:b0:600:34b6:6bc8 with SMTP id
 o186-20020a0dccc3000000b0060034b66bc8mr1289933ywd.33.1707484832203; Fri, 09
 Feb 2024 05:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-5-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-5-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:20:21 +0100
Message-ID: <CACRpkda-D_K=A5yxJnLJdQ1URpUWpmXUTgwECYV+_=sjE430EA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/11] net: dsa: realtek: common rtl83xx module
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

> Some code can be shared between both interface modules (MDIO and SMI)
> and among variants. These interface functions migrated to a common
> module:
>
> - rtl83xx_lock
> - rtl83xx_unlock
> - rtl83xx_probe
> - rtl83xx_register_switch
> - rtl83xx_unregister_switch
> - rtl83xx_shutdown
> - rtl83xx_remove
>
> The reset during probe was moved to the end of the common probe. This way=
,
> we avoid a reset if anything else fails.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Sweet!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

