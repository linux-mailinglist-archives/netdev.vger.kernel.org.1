Return-Path: <netdev+bounces-193497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143FBAC43FE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF76E178257
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8B51DD0F6;
	Mon, 26 May 2025 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcJKKyYQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3561C8C0E;
	Mon, 26 May 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748286328; cv=none; b=Rwe8dUalFns9BRv+TtspFKKPfrRhXESTW35zBXM0do760YXn4AhTGbOJnTtSpxMSAhy391n+oiTYxewI4jAh9kXF2ywwg5sbLFvu3cUU5AYsxxLIYPJXLd2eMNVDv/9E+6m6brW+wM8MsgnIAOWe8uHhGyoh3ssOkiJ5iQWnkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748286328; c=relaxed/simple;
	bh=qbLNtumBrWjiSYsmDA3GQS4jPxLUNzJRPt+i7A4sKjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/wtJb2V/OAab/13c52U1juuMVWVtxkr4V43TV3bjSGwumArYtRVAGA2dogOwwqniigo08cAT7ec/gHhPA6MhCa9Mfat5O1/NoY4xeDOV+H0tBetBa703LPY84BeWrTjpK7l0ZxPQKDhm/BFepl5t2QPJ5Jv7iUoVugTzGfDBD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcJKKyYQ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c542ffec37so274477685a.2;
        Mon, 26 May 2025 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748286326; x=1748891126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zM/XnPPB9BX6DI+X/tdBdbdDGUH15z/crP7yYd1Fx8=;
        b=TcJKKyYQKJi9Z6yqFpv6kUvac9j6N39wgqhridcuuThtJywDpwHem6Abt3E/D4fdH/
         XSJ2N5zM3hA915rXQqBqYhcXtJAMIWENKqKTyjj5yy+h8NRx1rfykF6COMcUMKpVSyN+
         LMZqOvwrgGAUvpRMxY65nBfMA1EsZd0VxCTO6mST1Tbg9lhpD+2zSjBgCvIpS0NNUOM9
         rcizTWHrfg0z6lJY5JUVHOU17sSQcWJ324dOy76w1jqhxxcxXqzbqD5joYdYdfYCQv61
         lLEu+p7tQQgu5bCwkrR+26V+SYnlpF7Jo5x0K7cGPQEY2E/ie/oOSbqOpTNKKUWRdU7b
         0WqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748286326; x=1748891126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zM/XnPPB9BX6DI+X/tdBdbdDGUH15z/crP7yYd1Fx8=;
        b=iLfr2lzj708UFbP1q6kSccw55Zskd/LcAVyTFjByaRtz+ZeoAG2nVy+xsGS1J+MCHB
         kukf8XMaZSB/ppQurPeoBSzyPrqtuQQix/X6701AYshOkdXOyKyzULQRZRxQr9wBcbZE
         YQS2xVJqUbNIWN7vxCECcyMgIxfYyewaPCmEpEfe3JalTOF2nK4V7j6R/NRguqwlhrwd
         ccs6rkx5Blz9EzUJoUcpjLicA5BgXT/vmGTrgT+7g4TCuiKC6gyBp9vR8xFBBqD2kcl3
         QuQLowYkwE8DgLbRLJ1UsBkwPEEPtoG38f+4FvdQNiV31zWvIJ1Uny8diVAa4tI5GQlp
         mo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqlyEsFJunDI6vYsrPVkJ3XCTsi3pUSJUEjix3XOtBEGLsaiH+UjZhoNNwr4nPCo+h/gb4X1uq+0Ug+q0=@vger.kernel.org, AJvYcCXOcza/9ObMYRxvzq+f0kCFwC47y6Oj3ZIPQocL4ge6XFJSK7tml12c4L2DRurYIzW+BBeERbXb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi66rioxP0cXLX9l3EWq9CZz5kTjAQDeXo66e2ioIGtlU+AdyR
	ZuD7yNPtU0m+aN8UKE8s7KXqtsOkw/DxxrWa9GfbPgD90Q/ksUbLoEbftHiEnKtn7r3dJ28YBEv
	ZRsgnO+rTwr6PuUTbeA8Nftfmt3GKWB4z4rHAa7ZD/A==
X-Gm-Gg: ASbGncvrLJImnXp6WNau/N1CCPw35N2gdMek69xpI/BEbjc8AFbrGravWBRhQ8AWy6L
	T+NIEYo2z0hI3TiXODpNOA35Cg8Fku9e8a5Ld4m8x9Xc4RJdEPtYEya7w4dItRFgGkEKk/EvERG
	+kUDOTFLPKHDSppYs7G2lbRhJenRDZtKUrn1W9VFU1Ygp+
X-Google-Smtp-Source: AGHT+IEzr1D0xPyVVTqgXnkaxzNsP6OY+ZVcUjK4Q6hjbSAkhccfV9zIJl49kHyZ9kmtGtW7FN9E3h5L1m5LIHvS+oA=
X-Received: by 2002:a05:620a:4505:b0:7c5:a55b:fa6c with SMTP id
 af79cd13be357-7ceecc2b525mr1410143685a.38.1748286326033; Mon, 26 May 2025
 12:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526002924.2567843-1-james.hilliard1@gmail.com>
 <20250526002924.2567843-2-james.hilliard1@gmail.com> <aDQgmJMIkkQ922Bd@shell.armlinux.org.uk>
 <4a2c60a2-03a7-43b8-9f40-ea2b0a3c4154@lunn.ch>
In-Reply-To: <4a2c60a2-03a7-43b8-9f40-ea2b0a3c4154@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 May 2025 13:05:14 -0600
X-Gm-Features: AX0GCFufJmB1WnNeY40vi62AOOmldrFuv3uM6nfuatEvw8W1yQgwUxsIUPzPUZI
Message-ID: <CADvTj4qvu+FCP1AzMx6xFsFXVuo=6s0UBCLSt7_ok3War09BNA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] net: stmmac: dwmac-sun8i: Allow runtime
 AC200/AC300 phy selection
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Feiyang Chen <chenfeiyang@loongson.cn>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Paul Kocialkowski <paulk@sys-base.io>, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 8:14=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, May 26, 2025 at 09:04:40AM +0100, Russell King (Oracle) wrote:
> > On Sun, May 25, 2025 at 06:29:22PM -0600, James Hilliard wrote:
> > > +   if (!nvmem_cell_read_u16(dev, "ac300", &val)) {
> > > +           const char *phy_name =3D (val & AC300_KEY) ? "ac300" : "a=
c200";
> > > +           int index =3D of_property_match_string(dev->of_node, "phy=
-names", phy_name);
> > > +           if (index < 0) {
> > > +                   dev_err(dev, "PHY name not found in device tree\n=
");
> > > +                   return -EINVAL;
> > > +           }
> > > +
> > > +           plat_dat->phy_node =3D of_parse_phandle(dev->of_node, "ph=
ys", index);
> > > +           if (!plat_dat->phy_node) {
> > > +                   dev_err(dev, "Failed to get PHY node from phys pr=
operty\n");
> > > +                   return -EINVAL;
> > > +           }
> > > +   }
> >
> > 1. You are re-using the drivers/phy binding for ethernet PHYs driven by
> >    phylib here.
> > 2. You need to update
> >    Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> >    in a separate patch.
>
> A real user, i.e. a patch to a .dts file, would also be good.

That will be added that down the line, for now I added an example in the do=
cs:
https://lore.kernel.org/netdev/20250526182939.2593553-3-james.hilliard1@gma=
il.com/

Currently there's a few other drivers needed to fully bring up the h616 ema=
c1
with AC200/AC300 PHY's such as PWM driver support.

i.e. this(which will also need a few additional patches for the H616
PWM variant):
https://lore.kernel.org/all/20250427142500.151925-3-privatesub2@gmail.com/

I'm currently doing most of the PHY initialization in u-boot to simplify te=
sting
of the efuse based PHY selection logic in the kernel. I'm sending this
separately as a number of subsequent drivers for kernel side PHY
initialization will be dependent upon specific PHY's being discovered at
runtime via the ac300 efuse bit.

I've currently verified this works on AC200 and AC300 boards by checking
that the appropriate phy address is used(address 0 on AC300 and address 1
on AC200).

>
>   Andrew

