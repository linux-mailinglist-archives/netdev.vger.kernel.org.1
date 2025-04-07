Return-Path: <netdev+bounces-179892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B482EA7ED8E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F11B1620D9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCF31C36;
	Mon,  7 Apr 2025 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr63LDfU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C015199A
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054459; cv=none; b=bQaau1Ry3FYAS48FQN75fhR0yJe2hUcD57RiEQ1NbIQsXILdIX9uk6A8Ofwr+3nI3ENL3y02w1PUJJCVXr1SOIEHuz+kPpGMFtXsNWDIPOj0wWK8/zVZClNLl+IiAj15XDWpJ8oRmlt/X7Y1Xj8aZvhhz+7S87XXsF3FsrNCwz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054459; c=relaxed/simple;
	bh=N6JvrXCjhqI3khqlXSJRaIKZTKDdyU0nfEMulqhWz/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbX1uqIl33zZPn89suMZxnEyXZfuDpAaJi9LlpfJWCEqbEyswiJPj03UbnDX0TYIJuLOC/7mDihgBKYeNArH1t2uyZS3+2GUtkIzNxhSa93EashkMhm5KcuSrlAIoVLzTu1X7SvFYILDeJ3qqnv1LBDOr1id9YdWQ6O0Ii8vg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr63LDfU; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-523edc385caso1931125e0c.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744054457; x=1744659257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9kUupfLeM2bb97UEnJtJkHdlxhJbbR6dWtAC4xPAdw=;
        b=lr63LDfUof8A67Kim+FaJidIJPj3uBejpefbPeFHZu3FTzt8vB5kt5DyYD0dr3qaMB
         bR51B2oC69tjWrRYwDM9u7icsBU4eemDWnFsbfpXeN6ttBbn4vG9C7GUwJNLj7tvYu/t
         /UfHP6xr/ZhO4iuAlF9gr/v59GkaBHcIdo73n1OnMX+hnLbyF/DDLG+ybfS8V2rxh97V
         ZoJlLSffCOlyn5kyDKRvMd40giHvlPNZa5A1uzw0wR6nRTYmA84L3uH6wWjBCdyrutcQ
         R1jIvL9CIaLVSe9YNcAVUe8cm7T5JEROTn/Y1cIR2HM0/Xi/GNYBpA1JXkEJm7PUSgqV
         pkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744054457; x=1744659257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9kUupfLeM2bb97UEnJtJkHdlxhJbbR6dWtAC4xPAdw=;
        b=t5yR6rD5h5yln2eKDZfcwTg8rLxracwNb4s6IG8TpsQxNtklXy+97s0BN45hxpM94C
         fIPKuRJ55YJoTSsCdU1ueIpoXk2tM+8A9V4cpRxijaw8XqhhubEeSmq5DJZcVSc6YRHB
         mS6uFQuQafAz9WkH2npT9bKpWxBqKbmJGa61Wa+yA+qmqyhVkvVt2LIck5zrjdAt6yA+
         Y+4Zx6oj6dvG+vRn/5O8qehRphuEg+roC5L33zOD5Ir1uy2PnSBvDMCLJpxfTftdPwWP
         6/13fwQHlA5EujClpwVGpxGDhv3Tc4z7Kn0X1H6FOFU12Q2fMt2tih+N3DEObTXgd0d0
         QgHA==
X-Forwarded-Encrypted: i=1; AJvYcCUyqPRnnvhFsd2cbeeh3SxZSAI36MK5P9HGbX/lTkvRARm5e4piteiFfjrFhUoStLM1zPDpVSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzC8zm/dHRdCctnsRIAnT/x0jocjqxz7JBZ+N6B1+pXZj9IeDd
	5wKtJQSMfnJ3x1sDWLPPlVgWnrvVJNja/OMLrwGsaxfnWcnBGm/Hm6QN9nBu1/EHazylgEBtk1t
	SGea5iDw5Ql24JRkmx5SFutyHJaI=
X-Gm-Gg: ASbGnctPNnMbJCwRcCXEacQvuax1z7WQfe6S1LzJx4yYkZolQs9ZntA++vIF6OTEaRS
	It9Sdji2QX8Jjyigq1XCmttGYvfMywchSAx5RdIZAyTbYhvIvCeU9iVUlCw0oimvohuVZRFsshs
	2LoVxz2Sqdw8Idv3Rh6O0StOfFOgJ0c/WYu4i3SpUoo+VevWJc98+7gS17ZG0=
X-Google-Smtp-Source: AGHT+IEUwdqKil1pOvRnLZ3FdzjENanpIPQHgPq8R+xUeQrCDsCevqcy7D/AW0+zBxjvwQs2SZQhqHplRtvsFcJ07KA=
X-Received: by 2002:a05:6122:2502:b0:526:483:95fd with SMTP id
 71dfb90a1353d-527645b6798mr10677466e0c.10.1744054456970; Mon, 07 Apr 2025
 12:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_Qbw0tZ2ktgBf7c@shell.armlinux.org.uk> <E1u1rMv-0013ON-TJ@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u1rMv-0013ON-TJ@rmk-PC.armlinux.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 7 Apr 2025 20:33:50 +0100
X-Gm-Features: ATxdqUHy--tranG0MT0BFF5juBVy575ZL4jQsNWdM38rbJ8aGrL8W5d1ehNrSPQ
Message-ID: <CA+V-a8t=V-EB4r_vBBSJfmAx1_tBRsvV-m3wM841fAw75-ueZA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwc-qos: use stmmac_pltfr_find_clk()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:39=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/dr=
ivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> index cd431f84f34f..f5c68e3b4354 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> @@ -34,16 +34,6 @@ struct tegra_eqos {
>         struct gpio_desc *reset;
>  };
>
> -static struct clk *dwc_eth_find_clk(struct plat_stmmacenet_data *plat_da=
t,
> -                                   const char *name)
> -{
> -       for (int i =3D 0; i < plat_dat->num_clks; i++)
> -               if (strcmp(plat_dat->clks[i].id, name) =3D=3D 0)
> -                       return plat_dat->clks[i].clk;
> -
> -       return NULL;
> -}
> -
>  static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
>                                    struct plat_stmmacenet_data *plat_dat)
>  {
> @@ -132,7 +122,7 @@ static int dwc_qos_probe(struct platform_device *pdev=
,
>                          struct plat_stmmacenet_data *plat_dat,
>                          struct stmmac_resources *stmmac_res)
>  {
> -       plat_dat->pclk =3D dwc_eth_find_clk(plat_dat, "phy_ref_clk");
> +       plat_dat->pclk =3D stmmac_pltfr_find_clk(plat_dat, "phy_ref_clk")=
;
>
>         return 0;
>  }
> @@ -242,7 +232,7 @@ static int tegra_eqos_probe(struct platform_device *p=
dev,
>         if (!is_of_node(dev->fwnode))
>                 goto bypass_clk_reset_gpio;
>
> -       plat_dat->clk_tx_i =3D dwc_eth_find_clk(plat_dat, "tx");
> +       plat_dat->clk_tx_i =3D stmmac_pltfr_find_clk(plat_dat, "tx");
>
>         eqos->reset =3D devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_OUT=
_HIGH);
>         if (IS_ERR(eqos->reset)) {
> --
> 2.30.2
>

