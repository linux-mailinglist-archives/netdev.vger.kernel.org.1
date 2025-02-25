Return-Path: <netdev+bounces-169624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B5A44DC0
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D385417AC97
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265EA214207;
	Tue, 25 Feb 2025 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG3lBf/5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219A213E63
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515461; cv=none; b=uHhMJDIe5TZDABj2+ycBw4Pxf5U0eiG/TVkLNdfBNsDXqm7BNv/oEtbcaA3yYd0AyT7fEaomuiPS5pqujOiHLWdFLK4kcD6Qtv1Fo+Vmd0ajx/LSZ941Qyiw0r4Ysv7OfRJh1abAuVYmZy6MLZ3fXNxtUgzd5qX/4Dwhz1HKuCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515461; c=relaxed/simple;
	bh=bc5+/o6iBvr99fApSP5qumW8aozgvy5KA2eg/uLLKLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2E7ixQcKkRnrmwsuJxHzyXXcURhmCUg1UlAbViJs7MnDeeuW5D9FGdCn4xpVfb6Z7lLOVEg857qzgExkU+kjZaBAYCpG9gLEvS63IoZnLFcHFgMfPyX+spomkcyiUnMfXcVdqfoDhQ0ycFbJEA2STQSOkslhSl1OC7L5iR6tKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG3lBf/5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so52970625e9.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740515458; x=1741120258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YV7wOBCDxZKolRjf9GF1nGz4gKy85D71AXPs47WKJWg=;
        b=iG3lBf/5IDc19NRBlJadC1Dpb7yNkrGzUMVMDVwywZgqdShIUbC2tc9y8wA7xAOaqz
         K/55BJKoLdg3lOHaVzZ2rEkDzwBWK35f+KNy7UcvlcCXc6BA7MLK0B7/mnI7o9rK2S6k
         VfjEmpOPYsBoDoN1y5/5vNmxwwUtolktBCAzCDsA2HTYhFQLMIFonDGF+piraw8teLZ7
         4gOIHpfLQahQLNAnyPp8dYiOi75yV7EXYmCqvll8+jrJt6MCfgzEu9ZjV88H2T1whBNC
         IHnUn+TyolorTDrB6SS2eBD4U5oWI/obOxYte5/R0zn01IFxPGK8NcxnNFJtDbLeYnSJ
         kR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515458; x=1741120258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YV7wOBCDxZKolRjf9GF1nGz4gKy85D71AXPs47WKJWg=;
        b=deTXgUF/MmQXqTaPAyP85uF8skqchCsknpAkh9yzkdfcUEJ3MANSw4TvDI9NnAEpQQ
         USocbUkkzfX4D0dn9mjM/mRnfZlQNK+K9+tiY+X41+EPrnTKlrcEHjrVG+fa/d6qKtwy
         A71d+WzuV7SWhz9QXk5uc65UzTcG1cjtgyM3UEXU+p65Z0UIOsrmYUaHKy1jAgc+f7z8
         OCwKDq75EK5iUrC/JaO7L9i/WvyNiFWE/GFUtHN9EwvouGJL2mUD0OixPC0J3d9ALJLT
         puzego54oPY5HrKTt3U0F6AglUrFq8Uq39MWBPiek2v0/Y1D6C+TzhixqhAuSNKO6v/v
         V+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXui6igFHFOwzcTW6ds3GIg4BhNL7iNvkao08XUYUJ8iQZ8Oow9eKWwV37ktekuusnXnksk20A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfsjKh6F8eywH645Y+bGIBw8eF/ejtJJNkAa/1wxX9sDsOI9dA
	r3HyfUbRNaMPe+Vh4zNM8YConZfj1DX96DE1hkXqjB1ckbd6RsHg
X-Gm-Gg: ASbGncu9kn0advGFo4pUFDn8OwRdPcSSZzInzMYyFOLnl5ykzG3ZWGBdZdJ/hRt45pF
	L7KW5BZsDC03M7hEm6t5f9qSgPspsD905xPQQtqH5xdUuksEjHAJatVJ72WjZbGZxnhpgtXoAtp
	unifBPjZ3vEUtaE/RHmKw9XLNpP0QeK5SmjCHbAg/CIt/pQsbl9XzR70eH2xWCrjEpnn5KC9R9T
	Ots27pm0rdjFuvkAk7EiMNfNx36JtkTKCEGIW6aPMemd/n46HQ3xQ946wl1wfc34HwiaZPkoM0e
	+2pbDaNyTTVFeTHAVLGY5TrhwrCcSOSh68NBGv6fcgRsY/PK6DXucEv4AWxvl8tt/QdUWu8CIZ7
	0qdxWgCOuw7q7
X-Google-Smtp-Source: AGHT+IGMx5pU7RRODJDtq0qCQl84I8Udv96NunCF2+SS/JZM7mWzu9hAPxehyg/ka5oYvjP72VnZ3Q==
X-Received: by 2002:a05:600c:4688:b0:439:63de:3611 with SMTP id 5b1f17b1804b1-43ab901d6b4mr6206895e9.24.1740515457376;
        Tue, 25 Feb 2025 12:30:57 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab156a136sm38626675e9.35.2025.02.25.12.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:30:55 -0800 (PST)
Date: Tue, 25 Feb 2025 21:30:52 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Emil Renner Berthing <kernel@esmil.dk>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
	Inochi Amaoto <inochiama@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jan Petrous <jan.petrous@oss.nxp.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org, 
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 0/7] net: stmmac: cleanup transmit clock
 setting
Message-ID: <deshe54mqty6ozlcbncliwxfxtszubrn44onswjlmo62lltcvx@42piilxcqwba>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4erhebjcgk6jk4go"
Content-Disposition: inline
In-Reply-To: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>


--4erhebjcgk6jk4go
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC net-next 0/7] net: stmmac: cleanup transmit clock
 setting
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 11:14:39AM +0000, Russell King (Oracle) wrote:
> Hi,
>=20
> A lot of stmmac platform code which sets the transmit clock is very
> similar - they decode the speed to the clock rate (125, 25 or 2.5 MHz)
> and then set a clock to that rate.
>=20
> The DWMAC core appears to have a clock input for the transmit section
> called clk_tx_i which requires this rate.
>=20
> This series moves the code which sets this clock into the core stmmac
> code.
>=20
> Patch 1 adds a hook that platforms can use to configure the clock rate.
> Patch 2 adds a generic implementation.
> Patches 3 through 7 convert the easy-to-convert platforms to use this
> new infrastructure.
>=20
>  .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 10 +----
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |  5 ++-
>  .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c | 24 ++----------
>  drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    | 22 ++---------
>  .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   | 26 ++-----------
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 43 ++++++++++++++++=
++++++
>  include/linux/stmmac.h                             |  4 ++
>  8 files changed, 65 insertions(+), 71 deletions(-)

Seems to work fine on Jetson TX2, so patches 1-3 are:

Tested-by: Thierry Reding <treding@nvidia.com>

--4erhebjcgk6jk4go
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAme+KHgACgkQ3SOs138+
s6FT4w/9GoN6QrYW3VP35tGhx3VaNaXACzYRu4GB5krW+p4Ixhq8LfnSKek6/MHu
SkB1lalSpNyFg9ZHeBHeLUMG0bulJzaqUNj38OnTv2YFI+hGXs4rkoLWKf1L+T9k
5Ci+UCoA5wGzrt+eKHixzKsu9V9oVexQOq0gp8AW+4dO8SQxqRgkTL5meN+ArqLr
O1F9jGuCNvJSIOeI4wFQ97s18GRHYTIJeq832LftTqIcJlGGT0dn59tcbLBLm+2f
2vbEqND6mv4cSADvXn1VbUqvCPFO+8p/U75Edy2D9hkl7ZjEjLv31bNQusqiPLFX
gq+JtMbP82gkdQEUDM/K1Ld5CVG5tioTgxWkBBLgU6Ly9TJZBLhN8V+FKJwUhswr
bpBS+gia4bBuu+04aiqgt4Klwb3o4opietJt5ZtJy7r1THx3kGXC/xfl6LVPyLEK
Rbtfv8c61+QmD75lC4Ydatoam55Gu1wjcct4SeqDWO/OiyJRRduoJWvOfCl7h4AI
bDjKuBvoOOTaTOMV70s65FghmyDlNLSyuOGpTMGlTqXgSNYMMehxHPsdo46S2N/5
SYZPImYOXvYaja3UcCYl8mqZn2/yFYPaI0Y8B6v08nof4iYiKdlL+sS7cK1XAkeF
emLTs/BQbziyTrK2sMmeZsY/Yiyr2y53PIxFvgAfnxNEIyl9+ZQ=
=A0bt
-----END PGP SIGNATURE-----

--4erhebjcgk6jk4go--

