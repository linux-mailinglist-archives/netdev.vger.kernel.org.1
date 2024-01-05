Return-Path: <netdev+bounces-61770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7743824D3F
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 03:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A596287668
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A70720EB;
	Fri,  5 Jan 2024 02:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UntTp1PT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5653AC
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ccbbb5eb77so13979901fa.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 18:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704422920; x=1705027720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl0lrZWmAGuBBbVOSccBAwPrz9mWlawLPugZdHm65aw=;
        b=UntTp1PTjgSz2A7Mm6qFcDnCTMBfAEtt2fgPrKtq5PK/wjsGy8TiWjUH7bNWYz9S8d
         H2ScPspGxaf3FxsvS36OTOMBTpAZPa742RVbYSbxOhhK6TlWhle+z+tQiCwlEctE4kg0
         7ZKkKCAja0WScyx8aObcWJQMeJMja8HxE/IG0dSJFI16fvwy1wLaLy+5SoU1xgz1r/yg
         6VpjWHtFN2QbCAGhJuTiBalXD+b28cfB7BW2FyPNxkNewtsPSQxjxAo1U0WSeMYrPJBr
         svu5pzvvCH4RjKsLkvqzu6Zs+iI5wp+DY/QU4hFh+QfGMm91qm31eqvZup4+STGPa4am
         W/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704422920; x=1705027720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tl0lrZWmAGuBBbVOSccBAwPrz9mWlawLPugZdHm65aw=;
        b=NXpL43wH6/zRyARoFnnAAcmq3No0M607Pv68VnpsAFYUI2C7QfIgKN1f5e5BlXcdah
         ehXt1folXpYiIfs20bujEG/+pu5BSsC99BTjW+L0R2iTTd4bMP//2gZTZARhdhvFqwjX
         7F28aKP1Z7Ylz0K0urGLWSypzGOghB1X51S2eOtg/EeEdmt4AdDAE2lHRkvd1ULvl41L
         nX9MnjCPvwR6MWhqx1KhB8D1/s4vx42ritFMJ3NYd6WMNsHo5MorwVpWk5oR4UZnlbEF
         uLW6qn700OEEwJMqT4pUwLuZVAeaBmk0Ji2sRKXk/3uQ1vZA6dLAr9Td7GSS9s8uu2+f
         yacg==
X-Gm-Message-State: AOJu0YwmTX/xaDiNifV7eKAoRJYAC5mmMt85MVd8j+6ctE0tNICZNv6I
	mWRkGXpLyQ2sxoOyxt9JVN6Niybt1ATVX57PLVI=
X-Google-Smtp-Source: AGHT+IGqd/tix5tOFegvSfR/Ov0WxYJ4l3y71JLv8eVp1Zf9odJ5R01gC87wf/I5+u0MxW3Zb2GAPn4zIDyExQTahJQ=
X-Received: by 2002:a05:651c:1992:b0:2cc:8e9d:1769 with SMTP id
 bx18-20020a05651c199200b002cc8e9d1769mr855997ljb.95.1704422920202; Thu, 04
 Jan 2024 18:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104140037.374166-1-vladimir.oltean@nxp.com> <20240104140037.374166-11-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-11-vladimir.oltean@nxp.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 4 Jan 2024 23:48:29 -0300
Message-ID: <CAJq09z44VzeiaperC6v2VULUk2RKDOtg05bsFX8t+fVGiT3_Qw@mail.gmail.com>
Subject: Re: [PATCH net-next 10/10] net: dsa: bcm_sf2: drop priv->master_mii_dn
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>, 
	=?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> There used to be a of_node_put(priv->master_mii_dn) call in
> bcm_sf2_mdio_unregister(), which was accidentally deleted in commit
> 6ca80638b90c ("net: dsa: Use conduit and user terms").
>
> But it's not needed - we don't need to hold a reference on the
> "brcm,unimac-mdio" OF node for that long, since we don't do anything
> with it. We can release it as soon as we finish bcm_sf2_mdio_register().
>
> Also reduce "if (err && dn)" to just "if (err)". We know "dn", aka the
> former priv->master_mii_dn, is non-NULL. Otherwise, of_mdio_find_bus(dn)
> would not have been able to find the bus behind "brcm,unimac-mdio".
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

