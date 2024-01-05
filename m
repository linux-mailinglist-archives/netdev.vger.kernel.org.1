Return-Path: <netdev+bounces-61766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36218824D1A
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 03:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D4D2853DA
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A278B1874;
	Fri,  5 Jan 2024 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em7sWEsr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F326E20EB
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 02:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso13816601fa.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 18:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704422597; x=1705027397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmU35AXmXhWN9C2gau/EQ/cnVcTnt071JiUMazx9nyw=;
        b=em7sWEsrjFM+N6UU2JSj6Dyns52EvQtMSrgC5RUXAC8nc6k7krfbms5AsJcBmVrY6y
         e+Irgm11Q+7PnSnXKDG5HNxV7Ue/5rxySlDD1FQQ6CjsgmsPALS82fwVSDfSl5pxwm0h
         03fJDdsp8HZJc9fFTNQXu2A3XCWo68/0AJUjf9c+cSSzRfA1rfrCA+2d/wNlq410fmDx
         EoSkqw8iWpVAkyk/8+d7bfNO3vmRF3WyvUEM7I4+JGbJ7QOOly+lPIOiKnsuJaeY8tLr
         CSHikdWyXQcUI3Gu+jbgxb0bYsLtM2rr3lSoeMnNTayv3yuO3DcJ6GYkQX29sNhsk6PN
         sKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704422597; x=1705027397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmU35AXmXhWN9C2gau/EQ/cnVcTnt071JiUMazx9nyw=;
        b=eQ7ylYIMC7aRQ0rMHUcYjZ7JWMNBLNz66lzZKD/5i/YpJ7aTfhQfsBM92oIO+T1U+T
         7FxYedMG5E+KPgr8x/F6lJmDe4PiqWAzLUG+cikPP4GCGA5y6uz47IxXENKs2+5SJL1K
         ezgm8KyPCretC9FkkWBKWVIjF8CMvSLcL7aYEcS8zcBp41Ns83apr4LnK+JDE5iuLb3a
         Xm40OiEcqZnxVbFuUAt8umfPyNAl85efSDcPzbG6gol1yH0NnunzX8NcyICUvPUmWiMj
         Ck+6Tu4oGn79voQSC5gH1V2QZP2kiAB9YiLODZlAUTfajV4Wuwc5j+NaadvBN86EfsWg
         sRMg==
X-Gm-Message-State: AOJu0Yx5ICNEJRkpWhegimOSQSpM1a2XB38CQJVj9JhSkJ0NC1Sgcz8V
	r4CdWMwoYerzgUSGOKCfGnFNtskvmG0wkXxEbZ0=
X-Google-Smtp-Source: AGHT+IFIqKgypgn+gp0mlh/58TXufCzLhf/aLBZU9tcmolPAiewoUupgA9FBjcAmvHRi8ACXaSK2LUtHgn5ZGrbRMuI=
X-Received: by 2002:a2e:9995:0:b0:2cc:5cd5:9664 with SMTP id
 w21-20020a2e9995000000b002cc5cd59664mr694304lji.95.1704422596886; Thu, 04 Jan
 2024 18:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104140037.374166-1-vladimir.oltean@nxp.com> <20240104140037.374166-3-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-3-vladimir.oltean@nxp.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 4 Jan 2024 23:43:05 -0300
Message-ID: <CAJq09z4NL3TzgsLO9beowLo0xjU+LQg+vSJ0GVenKXavxju07w@mail.gmail.com>
Subject: Re: [PATCH net-next 02/10] net: dsa: lantiq_gswip: use devres for
 internal MDIO bus, not ds->user_mii_bus
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>, 
	=?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> This driver does not need any of the functionalities that make
> ds->user_mii_bus special. Those use cases are listed here:
> https://lore.kernel.org/netdev/20231221174746.hylsmr3f7g5byrsi@skbuf/
>
> It just makes use of ds->user_mii_bus only as storage for its own MDIO
> bus, which otherwise has no connection to the framework. This is because:
>
> - the gswip driver only probes on OF: it fails if of_device_get_match_data()
>   returns NULL
>
> - when the child OF node of the MDIO bus is absent, no MDIO bus is
>   registered at all, not even by the DSA framework. In order for that to
>   have happened, the gswip driver would have needed to provide
>   ->phy_read() and ->phy_write() in struct dsa_switch_ops, which it does
>   not.
>
> We can break the connection between the gswip driver and the DSA
> framework and still preserve the same functionality.
>
> Since commit 3b73a7b8ec38 ("net: mdio_bus: add refcounting for fwnodes
> to mdiobus"), MDIO buses take ownership of the OF node handled to them,
> and release it on their own. The gswip driver no longer needs to do
> this.
>
> Combine that with devres, and we no longer need to keep track of
> anything for teardown purposes.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

