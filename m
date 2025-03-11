Return-Path: <netdev+bounces-173892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F51A5C26B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6DB1891BA8
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC7B1D61A2;
	Tue, 11 Mar 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/SYiNO4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D251B87E8;
	Tue, 11 Mar 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699231; cv=none; b=gmsQ3z/N60pksvIQ1pA4ROHuwZQsJ3uUKTD2Jj9RDv53lY3ss3tZv+yLP6a+D8POD2Mtc0Ibbd2o1NtYTZAgxHH5EVDqUFcJIyiOHSHqlcLNDfzVZA7Hwv5ufPLLy07AmpAw/MpXGMOw2k3pwNrtexh4lmtKINZqxb1s3r49eh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699231; c=relaxed/simple;
	bh=ujZv7E5nYkpDuJ4+Pi2QwrZaRLwVykgpid5Kgg0Kjug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7PRZSnQ3tdqG6EaL8pH8zSSZP/qcxyQFa7IWITxe5mawYMRrNIrVh5zCbjbr92LrfKSkGO8GvpY2G5ELgwzuATRe0b5A6T+XruCK0VLysYVxet9gfk9ZyRIomPAvGpHtwQwo66AK4MfY+CgzueUwKQzvcjVwQqdDIyXdM5cLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/SYiNO4; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-524038ba657so2411903e0c.0;
        Tue, 11 Mar 2025 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741699229; x=1742304029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG32Oauz2hDV9q2BpFy552F2Ma60RDkGby0ei11tRlQ=;
        b=E/SYiNO4m9EaRIdhiFJW7hTXwcwLOjFDPC+vCVOeV/QDlBFW1lew7Lhowdc5UMVs17
         2gIXnmIsGCZcgChnBuSdq12S1ch5S9z8TJz5y4hR/CN4a1Wn1iaVo6BMiZnl9LF6jaYN
         Yl5XAUdTiqmlbz51K0HWAP0WW4Zy93L3rsOiURqhWVwMG0gsBkREXphH2Beeh0l+NAif
         t+lwy0mRy0NV/5sJ7jIqTjir2OFArgGZo7KjaX/yj5ShVHfmQZDROR8OSv5ISt76Qjcc
         4cbMQ/TQ4Msi/lejh2MQBjVdBieMFP7BpOkvt8pxGRLHNLuUeZDMmJh+3akfhe67Ne6J
         Mf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699229; x=1742304029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jG32Oauz2hDV9q2BpFy552F2Ma60RDkGby0ei11tRlQ=;
        b=cGRCxaBjs9FXwlVToyf3AzbtN2fQbZH5lY7hRG8bLT+w9395ah8/QpKWkgWYOFz93S
         +CElZl+o48+M2OEsNRYq8x6GW8uRFT4mzxrBbk0SGg5MVmFfi4SH8VGzEMCQqm7dAzU6
         omCf56jcVhIuGL0nv/gePahiYOIzQW7nFpOAEJeqpUNu/YiX6hWSudf26vjsLraEAvIa
         HlEB2mFBaM+/H4siNHV1yyZCNCTNLxVGRG9cGM2maTp3crfVhhpQzGQdm0NgkiRpw/1o
         V5xRuu1IcP3Hxmr/CZTc+z7/JHXF0rhcOSLfMIyeB3mN0pQQ9gbveE55WoUwL0nPGML/
         mXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7nJvxoqZDgkzf3WWBr71JRu5zD3LVsF3PQiXphQ2MbdCRfmu1kli/J34EhTyaJ58e+dtldytXSAV@vger.kernel.org, AJvYcCXcmP+tXdHzU7BDVt3KZhtAJjK3ZCULqZghUW/Wcx4Bhm/ipS4qyo8u5n1QwWCsIdJkQQldGhhq@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ87vyyywE7PpeLfYV4GIA0hOWtarx9RTb1W1EO1D6EDxOkDcO
	9dC0PU1tMI6R0SGzW3BUnRz7bNQWrkv9yS6P4vhay8OFle9G0R8bu1PzQk9tktPxfWxoOMxESsK
	fRboFtjdQBD69FyJh758YHd0HOlA=
X-Gm-Gg: ASbGncvlYF5xxiYkslodBI9OF1XlqWT6LgArDNkEzNUjZNa0yuk/v/rgpDJZfNp1BFd
	S/wgBO7zWoxaybRdBhMd3xCuXEcSgYq6hLAHXfTCkd2EtKjBn2i9/w/ssCrwHoJVjTNptJNw5hC
	geynDwhYqymLQs6ewE/LbU+jcVMA==
X-Google-Smtp-Source: AGHT+IH5Ot4qDEn+dcG95GX7rHERBDIZE9g/5SbpzTjYL9a5kZXtGTj07DwxdqUsxTS40Unad1vxI6B/ZQaIH1FxayY=
X-Received: by 2002:a05:6122:3d47:b0:523:dbd5:4e7f with SMTP id
 71dfb90a1353d-52419754983mr2351687e0c.3.1741699228735; Tue, 11 Mar 2025
 06:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z82tWYZulV12Pjir@shell.armlinux.org.uk> <E1trIA0-005ntK-FS@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1trIA0-005ntK-FS@rmk-PC.armlinux.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 11 Mar 2025 13:20:02 +0000
X-Gm-Features: AQ5f1JrO_7vudADXigeeN9yXWooM4iHlgYUlKMy4_xyai_AoXvej3y5kzsc7Vh0
Message-ID: <CA+V-a8sCxs4MFZgo0q=0HmpyWXk7hYSGq0awm2YuAFZk+x6BEA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/7] net: stmmac: allow platforms to use PHY tx
 clock stop capability
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>, Eric Dumazet <edumazet@google.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jose Abreu <joabreu@synopsys.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Minda Chen <minda.chen@starfivetech.com>, 
	netdev@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Abeni <pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 3:02=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Allow platform glue to instruct stmmac to make use of the PHY transmit
> clock stop capability when deciding whether to allow the transmit clock
> from the DWMAC core to be stopped.
>
> Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h     |  1 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++++++++++----
>  include/linux/stmmac.h                           |  3 ++-
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/e=
thernet/stmicro/stmmac/stmmac.h
> index d87275c1cf23..bddfa0f4aa21 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -306,6 +306,7 @@ struct stmmac_priv {
>         struct timer_list eee_ctrl_timer;
>         int lpi_irq;
>         u32 tx_lpi_timer;
> +       bool tx_lpi_clk_stop;
>         bool eee_enabled;
>         bool eee_active;
>         bool eee_sw_timer_en;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index fa1d7d3a2f43..6f29804148b6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -457,8 +457,7 @@ static void stmmac_try_to_start_sw_lpi(struct stmmac_=
priv *priv)
>         /* Check and enter in LPI mode */
>         if (!priv->tx_path_in_lpi_mode)
>                 stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_FORCED,
> -                       priv->plat->flags & STMMAC_FLAG_EN_TX_LPI_CLOCKGA=
TING,
> -                       0);
> +                                   priv->tx_lpi_clk_stop, 0);
>  }
>
>  /**
> @@ -1104,13 +1103,18 @@ static int stmmac_mac_enable_tx_lpi(struct phylin=
k_config *config, u32 timer,
>
>         priv->eee_enabled =3D true;
>
> +       /* Update the transmit clock stop according to PHY capability if
> +        * the platform allows
> +        */
> +       if (priv->plat->flags & STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP)
> +               priv->tx_lpi_clk_stop =3D tx_clk_stop;
> +
>         stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
>                              STMMAC_DEFAULT_TWT_LS);
>
>         /* Try to cnfigure the hardware timer. */
>         ret =3D stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_TIMER,
> -                                 priv->plat->flags & STMMAC_FLAG_EN_TX_L=
PI_CLOCKGATING,
> -                                 priv->tx_lpi_timer);
> +                                 priv->tx_lpi_clk_stop, priv->tx_lpi_tim=
er);
>
>         if (ret) {
>                 /* Hardware timer mode not supported, or value out of ran=
ge.
> @@ -1269,6 +1273,10 @@ static int stmmac_phy_setup(struct stmmac_priv *pr=
iv)
>         if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI))
>                 priv->phylink_config.eee_rx_clk_stop_enable =3D true;
>
> +       /* Set the default transmit clock stop bit based on the platform =
glue */
> +       priv->tx_lpi_clk_stop =3D priv->plat->flags &
> +                               STMMAC_FLAG_EN_TX_LPI_CLOCKGATING;
> +
>         mdio_bus_data =3D priv->plat->mdio_bus_data;
>         if (mdio_bus_data)
>                 priv->phylink_config.default_an_inband =3D
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index b6f03ab12595..c4ec8bb8144e 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -183,7 +183,8 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_INT_SNAPSHOT_EN            BIT(9)
>  #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI         BIT(10)
>  #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING      BIT(11)
> -#define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY   BIT(12)
> +#define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP      BIT(12)
> +#define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY   BIT(13)
>
>  struct plat_stmmacenet_data {
>         int bus_id;
> --
> 2.30.2
>

