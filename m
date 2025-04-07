Return-Path: <netdev+bounces-179891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B5CA7ED90
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1614235F7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B42208987;
	Mon,  7 Apr 2025 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9vKXDKK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3499233E1
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054179; cv=none; b=PRhNawv/yDDd3DaWMFp/T4XXQPIIJHs1DqOWAxhx2gC7KXrsK8UneMCik891nScaH/BazJgpj8UuNsWhGPm/sxlg/KM4Ot8RI6XZNb9O8pDD1QlwY+BliAgBS1aIoutRK+ayeBrp3elszxSWzOW887MSsaWkQcyYAX5WqMZwP84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054179; c=relaxed/simple;
	bh=c+G+b23YDXutBCd6a3W1VSaZfSl9sFxTHv0kkyXCgi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myHl84AGEYl4PiQTbCRx//gB4QBER3uKDWgj7CJyMvkkgx0bqUF2BbFt0sFmJ9n08p0sMCc6+DLtXIh2Qsy00FwJZi7p9xM3Oyn7+GSqZzC7tUDtOpv5+kXH+K/HUt4bBxUSu9+FzRvSiBB8DQ1Vtp5ttE7YfVJXr78ejHCJ4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9vKXDKK; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5240764f7c1so1961341e0c.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744054177; x=1744658977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1tDFZHNBbzPIiAFt0CAdcD1vY0rtB3dQPVfG0k6uEs=;
        b=j9vKXDKKeD4//rSKOx8wvxphUhoKrWFG7oDzMWCKxnQirnbwqnKNOX21PSG6kwDvu5
         X84lJXd/d+ueWznif8XqiUsr9TrtcM4g2mV3ZCm5IYfYZtZmXA4uDCxNKHmQPZIWDox4
         DCoWTFqykHh36nNV5SCmjWfuXWEaPqDNFaK8HsVzXLndB8jRbHlkSl1VUfkv9VPno1Bg
         yONq/rK2tCuXUA81tHHOLKHyhh2Tx5Kk+yl7hdHWuS6uTwJ2GWcMSmfNRrcKX9OipBGC
         N0kw4oubMeaSeiL9LK/XbR3XU517jNe3Kuy0s7khr2/gHQwZP5csaGbwBiQ6J/GjLSVm
         Ym9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744054177; x=1744658977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1tDFZHNBbzPIiAFt0CAdcD1vY0rtB3dQPVfG0k6uEs=;
        b=fFkX/AouF0iLOl6JVQXILfQ2TcuXnz7oFmhLz/MmowB9IVEz/T9vcgNPWSYc/nJk2T
         FWBq4TVWBA8ij5p9eBBLCrosAVuPIYhSDcfyLFUtOK5SBUE4YEghD4tU6MgXc0AzRnfE
         8jZA3+MOk6O57Vk5uD40ROC+KaMytAVeG0qXDTAVwtLGcTgqle3y6IoqfFJW0CdoDcXp
         5D4841oCGDyo5FEtqnWuBS3AB9OpeTFMm9KfmXlY+gKtbsv/N2Q40L61vAJgcu7zoemS
         nzUItbSykedHaaDXoidVrEe2HBX+Zth9GBCeU3aLmPYJIz1T5odO9Ueu4Kl1d347HD1f
         s01Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8lWTbTa4KrSl3du6d9fC/3lR9Flxu5Jx3rN0RHt1LTPM2f8p3f7etpgRuPnzOjjxwjc0AHI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05Os39vWbmNajFUjQmx3OY6yDotE98SbkR7gZKifaKcZRNonM
	8YbqqshxkR+gtsTUhszv6I3vuIVjJmZtfWhisGA2b3UGLIydOTYL3fHi5J7O6kxc2wItP+MamRn
	Ep1GK2w3lyF+t+sfcqYsMlOmDW94=
X-Gm-Gg: ASbGncsUI4JcVqBas85YoEwbO6ex8HOS5+4oV5BqcQ20dvBhGil3R7ci30l47E09NkC
	T3hpVphEC82hJKy3c0G7PPoNtBS9g90vEp1MpGIieueibVMPgghJrNQapyXx3wZ8kILiF46CKLm
	al5KSgt/6UaRMEqYOxMBCTG7qvTppXQEhDvX2c7Octr58ZZ+dTBWeMnup3Udg=
X-Google-Smtp-Source: AGHT+IEYwC0D9Na6mldavU/SEDxrDLzeYphWLZylO7ms/uvFzvJU3N0fRqytl/SEZKNAWIqjkYg9Mf67iY5tlvf+beE=
X-Received: by 2002:a05:6122:660a:b0:527:67c7:50f with SMTP id
 71dfb90a1353d-52767c70798mr9373242e0c.11.1744054176979; Mon, 07 Apr 2025
 12:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_Qbw0tZ2ktgBf7c@shell.armlinux.org.uk> <E1u1rMq-0013OH-PI@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u1rMq-0013OH-PI@rmk-PC.armlinux.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 7 Apr 2025 20:29:11 +0100
X-Gm-Features: ATxdqUGJo6rGm-PzdxRM50F_X21bV_9ZjESEtot6xCodMTgbyqFrRYjRDv3xMQ8
Message-ID: <CA+V-a8v02JWb9fKPhRB8vLoA8Kt9h3wnGic8uWZZEc+9eptGpQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: stmmac: provide stmmac_pltfr_find_clk()
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
> Provide a generic way to find a clock in the bulk data.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 11 +++++++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h |  3 +++
>  2 files changed, 14 insertions(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/driv=
ers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index c73eff6a56b8..43c869f64c39 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -709,6 +709,17 @@ devm_stmmac_probe_config_dt(struct platform_device *=
pdev, u8 *mac)
>  #endif /* CONFIG_OF */
>  EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
>
> +struct clk *stmmac_pltfr_find_clk(struct plat_stmmacenet_data *plat_dat,
> +                                 const char *name)
> +{
> +       for (int i =3D 0; i < plat_dat->num_clks; i++)
> +               if (strcmp(plat_dat->clks[i].id, name) =3D=3D 0)
> +                       return plat_dat->clks[i].clk;
> +
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
> +
>  int stmmac_get_platform_resources(struct platform_device *pdev,
>                                   struct stmmac_resources *stmmac_res)
>  {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/driv=
ers/net/ethernet/stmicro/stmmac/stmmac_platform.h
> index 72dc1a32e46d..6e6561e29d6e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
> @@ -14,6 +14,9 @@
>  struct plat_stmmacenet_data *
>  devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
>
> +struct clk *stmmac_pltfr_find_clk(struct plat_stmmacenet_data *plat_dat,
> +                                 const char *name);
> +
>  int stmmac_get_platform_resources(struct platform_device *pdev,
>                                   struct stmmac_resources *stmmac_res);
>
> --
> 2.30.2
>

