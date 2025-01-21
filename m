Return-Path: <netdev+bounces-159986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD94AA17A2F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03530169F25
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8191BE852;
	Tue, 21 Jan 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1L7fJZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184D1B6D0F;
	Tue, 21 Jan 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451790; cv=none; b=FPNzkn3tfyw7HEhITDWAlienm2dnVb+J2+m8Sp+f+jL+ix2j3nABV5tRbIGxIhEol6neApiKMU6yjvH+v7VNHSEwux/tyaOXnT5rfDMAuWvDCpUopyL1bZ4RhVv8uUSuKKO5LY3XwptMeJabTeMTSZzc8v9xMCNIxEnJJOJMLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451790; c=relaxed/simple;
	bh=x109CagQPUDie1GwfWzTla/VzFLR6nL7cSoCg9U09qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gkb34Z0YWqiTbyeS9V9nV37SA1lrq0VKvXkzRaopAC4cEZvb4CG79nKchuEqSAfz15cYhIzWiiCZJowTOqEqrLuFdTDHEr/OPcCbFnIhqheIadz7fwA/Pp/GzzEfVEbn8gUCMgKUd0iCT+EROTe8Y9yKCha51xDlSXZ9AHJetBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1L7fJZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A285DC4CEE5;
	Tue, 21 Jan 2025 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737451789;
	bh=x109CagQPUDie1GwfWzTla/VzFLR6nL7cSoCg9U09qo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c1L7fJZKcvrZWTFut2itOlg7iSmeE7jNlA+hfYZ4TyCnrQWxmnmrvrwB4F6iJN+NJ
	 8/+Q3lzudjWj8OT0VzUMw4nQFRvoFOTI5q7jubCY5aRWFscJcCYVW+PQ4NwjxYA4P0
	 qmnCJgTS3yT2F600/CQiPD+d+6Do1uzq2DSFMe+fC6aBuTyrE3oHyhF8QI/FscROtc
	 rBY7LpEn+NDsywrOMgQoFMwOliUj6iDBxcqnu44Tu7f3sjTUBDyDixME0uJFGU9C1p
	 OKJQ12n+3uxrZrl5DdLPjP+/ZLob21+LLL0W+V6vGyCpd7CNS5G6ddskEHF47cUJNg
	 zqp1pMKV6bNRA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaec111762bso1021450066b.2;
        Tue, 21 Jan 2025 01:29:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAUQQC+Fa3rBumMVSC/A8wAf6HU2VYc39ioi82GBRkyWVslGBehO57+UE6z1gxmNCXdtthIO8C@vger.kernel.org, AJvYcCXB421aM7M7YW7udm0p3U/IvZFzUJz2OmR1mNFUdhv6zvNNK7M+0c6G5mcOrww5UZ4vszSh+9+PZUN4uwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSilK0+rQRhBBoqJO3iDavFlJhmjAqJG7KMNkwclZs9JjdPph3
	hZ81oFqNQklfGFvUs+jTq+4+uDs373td0lxL1Mf9uX3wi2cNfekGlx84AJzG349ifXIY+1E0En4
	gHWkrSFPFUj0P+bwSvl2iMOIyWAU=
X-Google-Smtp-Source: AGHT+IEAMbCk6W4xhdtMlEec0nscawo4qsaBW8BJ9oUBUOnbWm3Fg6RmGYiTTHXJE9/NPXR59+LOSZsblEZ1vwYTwTc=
X-Received: by 2002:a17:907:7e91:b0:aa6:a572:49fd with SMTP id
 a640c23a62f3a-ab38b3ce71cmr1451509766b.54.1737451788189; Tue, 21 Jan 2025
 01:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
In-Reply-To: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 21 Jan 2025 17:29:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7LA7OBCxRzQogCbDeniY39EsxA6GVN07WM=e6EzasM0w@mail.gmail.com>
X-Gm-Features: AbW1kvYj-VihQZqsBfJ8AIAvc9hWhqqIdYcG3HcBC7MDUNnfd8f0MalX2Uevqu4
Message-ID: <CAAhV-H7LA7OBCxRzQogCbDeniY39EsxA6GVN07WM=e6EzasM0w@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, si.yanteng@linux.dev, 
	fancer.lancer@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

The patch itself looks good to me, but something can be improved.
1. The title can be "net: stmmac: dwmac-loongson: Add fix_soc_reset() callb=
ack"
2. You lack a "." at the end of the commit message.
3. Add a "Cc: stable@vger.kernel.org" because it is needed to backport
to 6.12/6.13.

After that you can add:
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>


Huacai

On Tue, Jan 21, 2025 at 4:26=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongson.cn=
> wrote:
>
> Loongson's GMAC device takes nearly two seconds to complete DMA reset,
> however, the default waiting time for reset is 200 milliseconds
>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-loongson.c    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index bfe6e2d631bd..35639d26256c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -516,6 +516,18 @@ static int loongson_dwmac_acpi_config(struct pci_dev=
 *pdev,
>         return 0;
>  }
>
> +static int loongson_fix_soc_reset(void *priv, void __iomem *ioaddr)
> +{
> +       u32 value =3D readl(ioaddr + DMA_BUS_MODE);
> +
> +       value |=3D DMA_BUS_MODE_SFT_RESET;
> +       writel(value, ioaddr + DMA_BUS_MODE);
> +
> +       return readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
> +                                 !(value & DMA_BUS_MODE_SFT_RESET),
> +                                 10000, 2000000);
> +}
> +
>  static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_d=
evice_id *id)
>  {
>         struct plat_stmmacenet_data *plat;
> @@ -566,6 +578,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,=
 const struct pci_device_id
>
>         plat->bsp_priv =3D ld;
>         plat->setup =3D loongson_dwmac_setup;
> +       plat->fix_soc_reset =3D loongson_fix_soc_reset;
>         ld->dev =3D &pdev->dev;
>         ld->loongson_id =3D readl(res.addr + GMAC_VERSION) & 0xff;
>
>
> base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
> --
> 2.43.0
>

