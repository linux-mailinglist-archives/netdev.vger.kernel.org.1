Return-Path: <netdev+bounces-63445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B582CECF
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 22:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113F91C20EB4
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 21:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C4215AF9;
	Sat, 13 Jan 2024 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL2Pq1wo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8DD107A6
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd5b467209so71718581fa.3
        for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 13:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705181931; x=1705786731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H3ZgNqPzE+v53ejhGe7aIY/3aI392O4pxhX2WRd1M6Y=;
        b=LL2Pq1woSLqLwFNPQf2N3k6kro+8/UKRi/Qt9eOd1v1igMTbCI3/XTRK3LBPeMBxUV
         bGzJGVBWSoH5y/4NAbiDrWKT9atE3ZQDJxqvEs9U/yIVHwWBlXmsebbvdEd2B8cfa0nR
         K565tHREOrYDJbQAI060vLYqF9fXEYvbx4Ztu/JqsFsemjLWb5uWSvcmxtsJpXQgXK8L
         eSODwgYNFBAB1DV30t2eXBp3ylKJ5GWzrF30/NEvD7HqN99OzDsJxEv4TSy6NCEepgHE
         lU72fuN/OxrAU6asPNTDI/UEgF2u6MTowveQm/gEfx0JWlqQkFDRSS7XwZVstdN+9Zpi
         BSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705181931; x=1705786731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3ZgNqPzE+v53ejhGe7aIY/3aI392O4pxhX2WRd1M6Y=;
        b=XA6UB0wDSvAo8bvDM+aXr3QRl7IUkuuX2uaZ0nzMY0stvPpIr+u9eO84WidXsCObdE
         spuBzYYqOH4SzPlGOCFZAY1fNnBEnImzfgQYfaRaIwrtZjSugqk+8Wu/V0UQx1G+IRHZ
         Sw1JstrMdI/mtGEvJpA2BLYYtjEzsuRYd/RUJiGkWkpsEsr/Ho/ZH2QBeWkt+e65ZWu6
         IhPOx31DKyrw5pPl2TLCyIMlkbyPiEFPoPqGcrMahQlTK4nXyLq6D3YD18+nDkgH2/bp
         USTEAEl+9PRmgMDxr7C+Jz4bqWhn51UhMeQ86wIV9v7Jg1PLzdvW7M1EMHafIKJF+VqN
         xRfA==
X-Gm-Message-State: AOJu0YzaffIWUc5Hj85s/l5GFqhRHuQbF3+TGqvnnnETbgoy9ja83F7P
	KLZXFFIlZTVhAV5sQ2msOoZQGjiTzgRfAHM1F2Y=
X-Google-Smtp-Source: AGHT+IEUU1knMIjHVtbJpObgclBnISMaF7e7i8nkXlrAcM+CpmsApJTzwLfh9nFTbWyxij7X1jC2NDy49STkMqWmcUM=
X-Received: by 2002:a2e:9f0a:0:b0:2cc:3793:5575 with SMTP id
 u10-20020a2e9f0a000000b002cc37935575mr1527213ljk.93.1705181931077; Sat, 13
 Jan 2024 13:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20231223005253.17891-4-luizluca@gmail.com>
 <20240111095125.vtsjpzyj5rrag3sq@skbuf> <CAJq09z7rba+7LCrFSYk5FjJSPvfSS0gocRCTPiy4v8V5BxfW+A@mail.gmail.com>
 <20240111200511.coe26yxqhcwiiy4y@skbuf>
In-Reply-To: <20240111200511.coe26yxqhcwiiy4y@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 13 Jan 2024 18:38:39 -0300
Message-ID: <CAJq09z7YKKgCKgc_EeMrHy7ZYrWPP3x9aB9xto3ap8qc3gTG=w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa module
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> On Thu, Jan 11, 2024 at 04:53:01PM -0300, Luiz Angelo Daros de Luca wrote:
> > What do you mean by dropping the "common"? Use "realtek_probe" or
> > "realtek_dsa_probe"?
>
> Yes, I meant "realtek_probe()" etc. It's just that the word "common" has
> no added value in function names, and I can't come up with something
> good to replace it with.

I didn't like realtek_probe() either. It is too generic, although now
in a specific name space.
How about replacing all realtek_common with rtl83xx? I guess all
rtl83xx chips are switch controllers, even though some of them have an
embedded mips core.
Or we could include a prefix/suffix as well like rtl83xx_dsa or realtek_dsa..

Regards,

Luiz

