Return-Path: <netdev+bounces-160182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E28A18AE9
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 05:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B18163419
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 04:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B536160783;
	Wed, 22 Jan 2025 04:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0Bv2SIn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9B49659;
	Wed, 22 Jan 2025 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737518840; cv=none; b=cl1FB9+efvIhv/YlfhyQLywA/eKmx5wGk4ZoAo5JXYAsxxxQYqbndu1r8p2UmGQvCL0yNPQo6qtG4rcLmopHcdrz1NdVe6W8IlTN1ly7YYgB+nsHb4ikq84HtIL0/XKjTuRw7pjEg0bXKGECakz4BsJYzT9ISLZxAG42Li1h4y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737518840; c=relaxed/simple;
	bh=LmVFa7+rsczkSeaam0lpFKFM5NAG/xrl389XXjfwFyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fan+L+Icm9u5iZ0urhqdPW17Eg0/+ozNs7HkMAI099G5LlFVpzuNalYbHSazitk2CRdCr7TszCiLxpZ9W+DWvm9goqZoyNLnD0uU2k1dn3Eb83eAKlq9ukwKTLK4pD/2j7bGGg3MogRtsst7sStXqqjdVfCniNyNEs19XNIgKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0Bv2SIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A14C4CEE8;
	Wed, 22 Jan 2025 04:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737518839;
	bh=LmVFa7+rsczkSeaam0lpFKFM5NAG/xrl389XXjfwFyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s0Bv2SInDBYUDA0dquHfwvSs6sDWP7pgGegBG/CTjnyu8YzVC4iizkTx1csr+9Fil
	 ZSX1J7RvvSrgJO/idvK+MkSnI3ENKpld5p1382mASDYiW8zUu9SoPtHSFxlJ7jgCPv
	 wpNz6+DRFvSknoh+H+6QSPQ+1AcNTKUxpTrTUyK28tRofEEtMQ9Nx/nFAMsS7WiwFZ
	 SvV2rUp100x/RSnH4tXvXXZF8tthWs/bzOTTeQnPBCzzl2JDyKAYETU9+sugOcRRRI
	 BcemDRbG3T/BTJdFN0lMQyk67Ets0EMjX3cRHB6JKW4p1JQY8lLtH5nSDVZj07ABW2
	 oJFTqJqPgejag==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so9340907a12.1;
        Tue, 21 Jan 2025 20:07:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDCsn1kLaeOuenuZa4BPWyBikTI2AvAfEfWjkSUPVMIcVEuz1vVKGNQ/v3/NIm9jhmqW1yZEo6@vger.kernel.org, AJvYcCW3pikVnY3y0kFb4/rBp3w9XeBHc8zGmGAjOc3HBnnz90OpG3BK3a7aj2dcS2P7bRCKz0W8irDe80s6ftc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtBOZbDpojg5CdciH150D2+PV6WYSWjAR0O0n6j+/BtiLee09
	RfQMyk5vJAs+WpVj7wRgmHhhVhaMghOjqFcsW6bBM80KvICLs7mndCDF6dJT1zjVV61qAlBte8R
	7tQhxoXXi3mIOInLcou4YKX+U45o=
X-Google-Smtp-Source: AGHT+IH83euRaIbr8Kiv3H0t0U/K5dEsWA9P4TmWerd02oA1XpuDA1ifRCyHX0MTZ/ZxXdVfhs+PSnb2PFcdbAY09n0=
X-Received: by 2002:a05:6402:4313:b0:5db:f5e9:6760 with SMTP id
 4fb4d7f45d1cf-5dbf5e96a10mr1862552a12.2.1737518838103; Tue, 21 Jan 2025
 20:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
 <20250121044138.2883912-3-hayashi.kunihiko@socionext.com> <07f2f6d0-e025-4b21-ac41-caaf71bb6fff@linux.dev>
In-Reply-To: <07f2f6d0-e025-4b21-ac41-caaf71bb6fff@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 22 Jan 2025 12:07:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4qrr5x9PL5NjmvT0AF9XYtOpZBMjBj-QkTF2V6h6_Vhg@mail.gmail.com>
X-Gm-Features: AbW1kvaIG0rIpsEVvPRfxgbYSjwLxqw5Bd0bCr51SyrGjTbJBRNoxlLrUYz_02I
Message-ID: <CAAhV-H4qrr5x9PL5NjmvT0AF9XYtOpZBMjBj-QkTF2V6h6_Vhg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] net: stmmac: Limit FIFO size by hardware capability
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Furong Xu <0x1207@gmail.com>, 
	Joao Pinto <Joao.Pinto@synopsys.com>, Vince Bridgers <vbridger@opensource.altera.com>, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 1:15=E2=80=AFAM Yanteng Si <si.yanteng@linux.dev> w=
rote:
>
> =E5=9C=A8 1/21/25 12:41, Kunihiko Hayashi =E5=86=99=E9=81=93:
> > Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
> > stmmac_platform layer.
> >
> > However, these values are constrained by upper limits determined by the
> > capabilities of each hardware feature. There is a risk that the upper
> > bits will be truncated due to the calculation, so it's appropriate to
> > limit them to the upper limit values and display a warning message.
> >
> > Fixes: e7877f52fd4a ("stmmac: Read tx-fifo-depth and rx-fifo-depth from=
 the devicetree")
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 251a8c15637f..da3316e3e93b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -7245,6 +7245,19 @@ static int stmmac_hw_init(struct stmmac_priv *pr=
iv)
> >               priv->plat->tx_queues_to_use =3D priv->dma_cap.number_tx_=
queues;
> >       }
> >
>
> > +     if (priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
>
> > +             dev_warn(priv->device,
> > +                      "Rx FIFO size exceeds dma capability (%d)\n",
> > +                      priv->plat->rx_fifo_size);
> > +             priv->plat->rx_fifo_size =3D priv->dma_cap.rx_fifo_size;
> I executed grep and found that only dwmac4 and dwxgmac2 have initialized
> dma_cap.rx_fifo_size. Can this code still work properly on hardware
> other than these two?
Agree, this will make my below patch not work again, because
dwmac-loongson is based on dwmac1000.

https://lore.kernel.org/netdev/20250121093703.2660482-1-chenhuacai@loongson=
.cn/T/#u

Huacai

>
>
> Thanks,
> Yanteng
>

