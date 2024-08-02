Return-Path: <netdev+bounces-115413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A14B9464BA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 22:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFA51C2173E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 20:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BBD6F068;
	Fri,  2 Aug 2024 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ff1++IQt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9DD61FE9
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632315; cv=none; b=PvH7mBlZWyfKBfBE1GtiOO7RbK8wJvc3fKpSoHMCwRw3JXfHWsZAi4ZIcTrR2/mFYgNrtWIZZWyYZcbfax2g84FMwIgtC089RYdk6d7oifF7fAk1/2PYgp0+otZSloBpADx9Bm6ts1iYkHJkiteF6CbEw2xhj5D8DwDnfP1RLxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632315; c=relaxed/simple;
	bh=O+Tilim3KrHmSHorua8YjAEFRiWBTprbGtThLXeCT40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6ou20UKDxxcA2nJXRwtnOtmx/2hC0RD1PQFw8LGkY3++tDwx/OB4qGCgwsU0P1qWtnl3kiI8bB8agg7eo0oHy6SGwE4///R2XVA5VUj3s7nUA/37Wr4keSKuSI44g+4m5e4i9VK2HSzylLF7nKcIZ+sW2OcOPNHS6GlmQeqNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ff1++IQt; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f01993090so12360611e87.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632311; x=1723237111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+Tilim3KrHmSHorua8YjAEFRiWBTprbGtThLXeCT40=;
        b=Ff1++IQtefS2vQx5N6vsf1zr6pZ+mZsyzFGKbf2e29saEGW2Sv2GdPFm0v07YfdRZm
         eOSpv8qE4bF3iFyR44AZdS1HFIebqJweX9ghdpAgP0Cf9NHO5bfMat/uDoV2Z2kcnEMd
         CPSLUcChEDppfV/Jxxq6j7BxJboq7heyI2no3kbvmdqDvALZ2TqmO65kAWbU9T9nX/QM
         WSIlK3Blvi4isr85XcKIcJd/X9Qg2AcZUTE4eTXZ77Fxs5iIrGBTb6g+dbI8fM6gzPfw
         NDwjvicpyyfXBPXOkX3rVWwW9XfsaBgyJXvi+KX+WO4QqGMt8oKdD8EzMs/4i0albdsP
         h4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632311; x=1723237111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+Tilim3KrHmSHorua8YjAEFRiWBTprbGtThLXeCT40=;
        b=CkbG0xdFA4A8mRim7kz2vOJF00NQg/c3h5POUuQcGZzwwIx6SBbC8MTT/1lNuEIpKz
         HvtYHKBnXXAcy5dY9MsweMm24+geuR4KsFfocyWrywio246V4TOEWjvEBD6VBVDM7smN
         co7KL44ODeMASNSKA4cISzE6hVu621saJYFXa7EgeJ1fHK1OaHkA2Njk22+M8VvF+vcu
         XmJivZZVkPpwoZIKo+zHixZWppZ2XYi6aIZB4mvD3P1er/RPxYtiBjSnsgcZkjlZ7Hpe
         tUZSXdZT8QTNoG04MYFHdv297zbPYBQ4Ye3J6rwt1G+vcguVBIfEooe8Yw3yqcO6+1kk
         UK+A==
X-Gm-Message-State: AOJu0YyMCb3OPgYb3ARJEidpj1qWTdlrtyvO3eRVPtuhzbFPJFPzB5kF
	TSkKfX3EK36dPtqMBjBY5cJMGNqvMe+Ow6GjylDXeoboRsa4f6liMI4YA03NEz2ed7WbmZsIB0x
	raVV5cd5TxJD51fgt5H2Tyzb77jZT9FN9c05r0w==
X-Google-Smtp-Source: AGHT+IGEPkWYjQyyOhvXhyRwGwgS8w8GFCtqhBPUgnWMvIErW7bGpVsQpPodZajzWUnVBZudUqQ/mS1GChG1h+2Tc8c=
X-Received: by 2002:a05:6512:ba3:b0:52e:bdfc:1d09 with SMTP id
 2adb3069b0e04-530bb36f0b1mr3129076e87.18.1722632311380; Fri, 02 Aug 2024
 13:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-2-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-2-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 22:58:20 +0200
Message-ID: <CACRpkdYwCNSj_A9FwinwW6kf6DOKEjM6jY9ur+REF+Yuv2yP2Q@mail.gmail.com>
Subject: Re: [PATCH net 1/6] net: dsa: vsc73xx: fix port MAC configuration in
 full duplex mode
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:04=E2=80=AFAM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> According to the datasheet description ("Port Mode Procedure" in 5.6.2),
> the VSC73XX_MAC_CFG_WEXC_DIS bit is configured only for half duplex mode.
>
> The WEXC_DIS bit is responsible for MAC behavior after an excessive
> collision. Let's set it as described in the datasheet.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

