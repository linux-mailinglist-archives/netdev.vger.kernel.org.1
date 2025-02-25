Return-Path: <netdev+bounces-169376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B26BA43981
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B45D7A73A6
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2152B2627F1;
	Tue, 25 Feb 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXfIAagz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB95B26156F;
	Tue, 25 Feb 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475870; cv=none; b=R/Nz3ouF9BVPFp0TH+Lj9bVVZbXbYSN8OESRqIj3jCnxoqbgbWwAZ8gHFysIiyfETdJzmtYWwWwXos1xSwZ2nTagQbGBtAM46Gho2h5/lK2BgoleU+m+PMCPjOVC4I80hpc5/w6DSSnq8wBrtYi/e6imQOlStTeDQtrd0Q5sI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475870; c=relaxed/simple;
	bh=VhqhUEKJybMC5Ioqu2TlM8kjWfRxkvh6hF8HPB9/5wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1ZYqux8mVsZTETChxR2Sz9dM+Qtdjh+76erY/5qmBV1OBffW0PesnC1cy1f96TokNwtPe1OsELVxz5R+HChAG9FjilNnoY50F4k/6boaMa4tzlQMQLGg4La94gRr/MV6dcHnfGTSgEhlzAfRrFmus4K11x1VH/8tJMLz2RYKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXfIAagz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF16C4AF09;
	Tue, 25 Feb 2025 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740475867;
	bh=VhqhUEKJybMC5Ioqu2TlM8kjWfRxkvh6hF8HPB9/5wA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EXfIAagzfTqvwWsRGznCUK3ZkWhLbD7NPhK4kB6yq1P7xsid+Jxuj9M05vjK46gYk
	 3xEUD5L4kt7jgVgmhutEnYpZy/x04g+8QzkG9TZZOLMuynarF+R4825SDG6/c16yWv
	 hugaeESVhquFZn7pAzz5jzYhh1gM6Bu4HVuyfgKmSUhPEdwvzHkwfFrW+h+HU5Zb+s
	 7lXaIemT3IQisCddKoSlWBBoIwSZW/ViiyJKSS7+eTLmA8Jvsp1ZfGzwyn5cq4Gvhq
	 WQ7cfRa0RC2dTKKnz3yQYWeTrLaQsjneKUhDcP3nEkLI3YI3iCiE/iMat4+B60vNTN
	 woaslJT0QpaYg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so7689492a12.1;
        Tue, 25 Feb 2025 01:31:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+5kf+rc1unRQtKSCfyXLk0kPPIbN8i7UzriZJLENebWgGNOMfI+tBpAr4CZAo9CHaDdEz24uB@vger.kernel.org, AJvYcCWgC7KgsDeMl5HRiQKCiy06nr5fT+qt3QeVpn6IIIffujBNboaZIJF6F/WVHPJVbOEIiKAlw+X92Jo2GJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvhoLUt0mwInmAg8Wo3A6Ey50kzLQV8gSa+592US81kflvhnq
	dPzQTQyZi4caAVOV7/923p0okiJK8F1jogB97PU+YRhlbPSnrCPThYNa83xv89RZiN9p0bAv0If
	I2pcE1pGNR2q0UlAUe7RmJPuK3Xk=
X-Google-Smtp-Source: AGHT+IGLJYv/e1oxPDxFKFsKBaEaUHmq0pFseR1OcvNHLehzMt/+mZLqCUb2pCHMmsax354c1CbJrvmsMW+1OBmxUh8=
X-Received: by 2002:a17:906:3151:b0:aba:5e50:6984 with SMTP id
 a640c23a62f3a-abc099ead3amr1554594166b.2.1740475865854; Tue, 25 Feb 2025
 01:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224135321.36603-2-phasta@kernel.org> <20250224135321.36603-6-phasta@kernel.org>
In-Reply-To: <20250224135321.36603-6-phasta@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 25 Feb 2025 17:30:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5OH7JLUUCjDAP=qfzGUVLt1HfiAYtc6Hr0oHURM0Pa9A@mail.gmail.com>
X-Gm-Features: AQ5f1Jrr8qZL58Do6GOisELNPoK9P0OBrnmwiGAX3q4INVgQhFafk3UcjXTs7oU
Message-ID: <CAAhV-H5OH7JLUUCjDAP=qfzGUVLt1HfiAYtc6Hr0oHURM0Pa9A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] stmmac: Replace deprecated PCI functions
To: Philipp Stanner <phasta@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Yanteng Si <si.yanteng@linux.dev>, Yinggang Gu <guyinggang@loongson.cn>, 
	Feiyang Chen <chenfeiyang@loongson.cn>, Philipp Stanner <pstanner@redhat.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Qing Zhang <zhangqing@loongson.cn>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:53=E2=80=AFPM Philipp Stanner <phasta@kernel.org>=
 wrote:
>
> From: Philipp Stanner <pstanner@redhat.com>
>
> The PCI functions
>   - pcim_iomap_regions() and
>   - pcim_iomap_table()
> have been deprecated.
>
> Replace them with their successor function, pcim_iomap_region().
>
> Make variable declaration order at closeby places comply with reverse
> christmas tree order.
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   | 11 ++++-------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 14 ++++++--------
>  2 files changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index f3ea6016be68..25ef7b9c5dce 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -521,10 +521,10 @@ static int loongson_dwmac_acpi_config(struct pci_de=
v *pdev,
>  static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_d=
evice_id *id)
>  {
>         struct plat_stmmacenet_data *plat;
> +       struct stmmac_resources res =3D {};
>         struct stmmac_pci_info *info;
> -       struct stmmac_resources res;
>         struct loongson_data *ld;
> -       int ret, i;
> +       int ret;
>
>         plat =3D devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>         if (!plat)
> @@ -554,13 +554,11 @@ static int loongson_dwmac_probe(struct pci_dev *pde=
v, const struct pci_device_id
>         pci_set_master(pdev);
>
>         /* Get the base address of device */
> -       ret =3D pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
> +       res.addr =3D pcim_iomap_region(pdev, 0, DRIVER_NAME);
> +       ret =3D PTR_ERR_OR_ZERO(res.addr);
>         if (ret)
>                 goto err_disable_device;
>
> -       memset(&res, 0, sizeof(res));
> -       res.addr =3D pcim_iomap_table(pdev)[0];
> -
>         plat->bsp_priv =3D ld;
>         plat->setup =3D loongson_dwmac_setup;
>         ld->dev =3D &pdev->dev;
> @@ -603,7 +601,6 @@ static void loongson_dwmac_remove(struct pci_dev *pde=
v)
>         struct net_device *ndev =3D dev_get_drvdata(&pdev->dev);
>         struct stmmac_priv *priv =3D netdev_priv(ndev);
>         struct loongson_data *ld;
> -       int i;
>
>         ld =3D priv->plat->bsp_priv;
>         stmmac_dvr_remove(&pdev->dev);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_pci.c
> index 91ff6c15f977..37fc7f55a7e4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> @@ -155,9 +155,9 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>  {
>         struct stmmac_pci_info *info =3D (struct stmmac_pci_info *)id->dr=
iver_data;
>         struct plat_stmmacenet_data *plat;
> -       struct stmmac_resources res;
> -       int i;
> +       struct stmmac_resources res =3D {};
>         int ret;
> +       int i;
>
>         plat =3D devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>         if (!plat)
> @@ -188,13 +188,13 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>                 return ret;
>         }
>
> -       /* Get the base address of device */
> +       /* The first BAR > 0 is the base IO addr of our device. */
>         for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
>                 if (pci_resource_len(pdev, i) =3D=3D 0)
>                         continue;
> -               ret =3D pcim_iomap_regions(pdev, BIT(i), pci_name(pdev));
> -               if (ret)
> -                       return ret;
> +               res.addr =3D pcim_iomap_region(pdev, i, STMMAC_RESOURCE_N=
AME);
> +               if (IS_ERR(res.addr))
> +                       return PTR_ERR(res.addr);
>                 break;
>         }
>
> @@ -204,8 +204,6 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>         if (ret)
>                 return ret;
>
> -       memset(&res, 0, sizeof(res));
> -       res.addr =3D pcim_iomap_table(pdev)[i];
>         res.wol_irq =3D pdev->irq;
>         res.irq =3D pdev->irq;
>
> --
> 2.48.1
>

