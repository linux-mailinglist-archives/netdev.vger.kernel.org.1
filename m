Return-Path: <netdev+bounces-169308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622E4A43600
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1FD189966D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB0C1FCD1F;
	Tue, 25 Feb 2025 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPNf6qAj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464061FDD
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740467788; cv=none; b=lsGC6DXGeIQPVARO4OYr+EFtlqcoie9iLuWmd/JVK0cKeI8Xusj//0m15g1yssbjxg/yjFVcGWzqaCyapRxW9mzlDUjxvD2SFCS/ggMbrbyFiLGbknV+18TiewQsavQDJ2ntujiapF3A2ZG5Zv4Qr+VdN5h00vp++YNRPbeEAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740467788; c=relaxed/simple;
	bh=/pgV5jyjK6Z1jVtfeCTPOeHBCDBaaVf166zwsVuNipQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9KkdYx+9vIp8w3VZU9Rs9RuEIpaW3h9ge7BylmLB7tZdJcjyWS7397Mv8K+5nXquHJQv8KIZ7oZ+Gs74fqGjQvzjEbBcOFBu0ZYbiEkseYoAX3gWFRIgLCQeuaRSOw6Dzf4YHsuLxFHCNHPgcI5tK1MAJbrZbYBFIGKE48wtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPNf6qAj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740467785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ8ganHFrjZwdAsNJKERIzeXH5APWE2/FMGZlEN7QT0=;
	b=EPNf6qAjX9RupHhnmQdiz+c3iv35D5T8mwV1bUpAmhgyr9kJpQcGbUiGv68ggTSPi5zXcn
	nOahAhyQcx0uJCPotJd3x9i+kax9elWmVLX9ayU1dFkjcaMt0BF828wp0EJJJV2aJQefXp
	Wmdcr942XilFCVJ7HVlt80x6E6VP/Vg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179--88ALst1O3q2CKNyVXSTZg-1; Tue, 25 Feb 2025 02:16:22 -0500
X-MC-Unique: -88ALst1O3q2CKNyVXSTZg-1
X-Mimecast-MFC-AGG-ID: -88ALst1O3q2CKNyVXSTZg_1740467781
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394c489babso28902915e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740467781; x=1741072581;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQ8ganHFrjZwdAsNJKERIzeXH5APWE2/FMGZlEN7QT0=;
        b=ZFl8cb1agVJy5e1UhVq0u/uBS7fdHeAEfbK1JhijzfigFXf5VhVQUfMkJaVMnpmBg2
         6C5g9rITBI5m7vA45VaeyLjRMuwK7BTEprH66D9usep+P1mKK7yoFky+Le/OxYKPXqRx
         kJ8rr0vMn49tsJiVXuTzSGqHBg6w32YsjnGQTDQoZu83CDT727rz0gLKFmo7vJ0Trse2
         ENWlDc75eaoTvco6I5ARt2m8VK0OdW3OLCjrzlmCVmP5dYSQ1DwHYnVgsVvQOd/nCzeo
         mC2Sb40pdhpYx3Frc12TqROteQDnI22OkmIdwXbfvN1wTI2qVAOsKorA90elp2NFphDz
         xY6w==
X-Gm-Message-State: AOJu0YxjPNyD2tX3VE0zbRhAUExA/TtvS0Z6lvyu20dFRPoyElQLvbhf
	NA7GiUEA5Wq4VSLPypg0Nb/ssABnhE1AA04C1loA3oDsvOlfgA1RT3wklfEqp9HwF2gKfT6lXza
	JdchbsmphB45k1MQqCU1h1rg5bzxgprdzEaujOJ/UiMdnfUHo/CFMzQ==
X-Gm-Gg: ASbGncsJUhGn//mzLda07PLWcHYlmUGRQiCs5lvsEzn2OR8l36PIMHzPFXaQLPruV1P
	rIKuBHBrC/2j44AGRMQ2yLltX+sooIzJQHQb41bX7bAI4KpKaijRhJ/J0H5T6l2o6DAGNFm8You
	PqTyTr3OqJMIodHE6ukElCS1YSauiVdep7pvy1IhcTF+KSndIDpFMEHv8lsSuY+onIlSbahWxUL
	4LidWsYfwBBxl/S2UB2BBHS+XgMTy+maYPs3SAe4tY00n2CBVvc7DT1wekm69rHKE4efFWu0pfh
	GtT5x4Kump0Yjz7sJWAnTKnCHiX4BL9Sp73M+xJlEA==
X-Received: by 2002:a05:600c:4e8b:b0:439:9eba:939a with SMTP id 5b1f17b1804b1-43ab0f8b68bmr15347885e9.26.1740467781034;
        Mon, 24 Feb 2025 23:16:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKAYIbDeUkxN/sPOdOh9dmDT/KC44JigW8G4nDwTJ+erWGkxMnzLVafhwjP4Cz13s3tIx2WQ==
X-Received: by 2002:a05:600c:4e8b:b0:439:9eba:939a with SMTP id 5b1f17b1804b1-43ab0f8b68bmr15347625e9.26.1740467780642;
        Mon, 24 Feb 2025 23:16:20 -0800 (PST)
Received: from [10.32.64.164] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1539da5sm15328505e9.10.2025.02.24.23.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 23:16:20 -0800 (PST)
Message-ID: <f1c3e538e19aca7fd46dd7f10da190d691bace83.camel@redhat.com>
Subject: Re: [PATCH net-next v3 4/4] stmmac: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Philipp Stanner <phasta@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Huacai Chen
 <chenhuacai@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Yinggang Gu
 <guyinggang@loongson.cn>, Feiyang Chen <chenfeiyang@loongson.cn>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Feb 2025 08:16:18 +0100
In-Reply-To: <20250224135321.36603-6-phasta@kernel.org>
References: <20250224135321.36603-2-phasta@kernel.org>
	 <20250224135321.36603-6-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 14:53 +0100, Philipp Stanner wrote:
> From: Philipp Stanner <pstanner@redhat.com>
>=20
> The PCI functions
> =C2=A0 - pcim_iomap_regions() and
> =C2=A0 - pcim_iomap_table()
> have been deprecated.
>=20
> Replace them with their successor function, pcim_iomap_region().
>=20
> Make variable declaration order at closeby places comply with reverse
> christmas tree order.
>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> =C2=A0.../net/ethernet/stmicro/stmmac/dwmac-loongson.c=C2=A0=C2=A0 | 11 +=
+++-------
> =C2=A0drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c=C2=A0=C2=A0 | 14 +=
+++++------
> --
> =C2=A02 files changed, 10 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index f3ea6016be68..25ef7b9c5dce 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -521,10 +521,10 @@ static int loongson_dwmac_acpi_config(struct
> pci_dev *pdev,
> =C2=A0static int loongson_dwmac_probe(struct pci_dev *pdev, const struct
> pci_device_id *id)
> =C2=A0{
> =C2=A0	struct plat_stmmacenet_data *plat;
> +	struct stmmac_resources res =3D {};
> =C2=A0	struct stmmac_pci_info *info;
> -	struct stmmac_resources res;
> =C2=A0	struct loongson_data *ld;
> -	int ret, i;
> +	int ret;
> =C2=A0
> =C2=A0	plat =3D devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> =C2=A0	if (!plat)
> @@ -554,13 +554,11 @@ static int loongson_dwmac_probe(struct pci_dev
> *pdev, const struct pci_device_id
> =C2=A0	pci_set_master(pdev);
> =C2=A0
> =C2=A0	/* Get the base address of device */
> -	ret =3D pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
> +	res.addr =3D pcim_iomap_region(pdev, 0, DRIVER_NAME);
> +	ret =3D PTR_ERR_OR_ZERO(res.addr);
> =C2=A0	if (ret)
> =C2=A0		goto err_disable_device;
> =C2=A0
> -	memset(&res, 0, sizeof(res));
> -	res.addr =3D pcim_iomap_table(pdev)[0];
> -
> =C2=A0	plat->bsp_priv =3D ld;
> =C2=A0	plat->setup =3D loongson_dwmac_setup;
> =C2=A0	ld->dev =3D &pdev->dev;
> @@ -603,7 +601,6 @@ static void loongson_dwmac_remove(struct pci_dev
> *pdev)
> =C2=A0	struct net_device *ndev =3D dev_get_drvdata(&pdev->dev);
> =C2=A0	struct stmmac_priv *priv =3D netdev_priv(ndev);
> =C2=A0	struct loongson_data *ld;
> -	int i;

Just saw that this is a left-over that actually should be in patch 3.
Will fix.


P.

> =C2=A0
> =C2=A0	ld =3D priv->plat->bsp_priv;
> =C2=A0	stmmac_dvr_remove(&pdev->dev);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> index 91ff6c15f977..37fc7f55a7e4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> @@ -155,9 +155,9 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
> =C2=A0{
> =C2=A0	struct stmmac_pci_info *info =3D (struct stmmac_pci_info *)id-
> >driver_data;
> =C2=A0	struct plat_stmmacenet_data *plat;
> -	struct stmmac_resources res;
> -	int i;
> +	struct stmmac_resources res =3D {};
> =C2=A0	int ret;
> +	int i;
> =C2=A0
> =C2=A0	plat =3D devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> =C2=A0	if (!plat)
> @@ -188,13 +188,13 @@ static int stmmac_pci_probe(struct pci_dev
> *pdev,
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> -	/* Get the base address of device */
> +	/* The first BAR > 0 is the base IO addr of our device. */
> =C2=A0	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> =C2=A0		if (pci_resource_len(pdev, i) =3D=3D 0)
> =C2=A0			continue;
> -		ret =3D pcim_iomap_regions(pdev, BIT(i),
> pci_name(pdev));
> -		if (ret)
> -			return ret;
> +		res.addr =3D pcim_iomap_region(pdev, i,
> STMMAC_RESOURCE_NAME);
> +		if (IS_ERR(res.addr))
> +			return PTR_ERR(res.addr);
> =C2=A0		break;
> =C2=A0	}
> =C2=A0
> @@ -204,8 +204,6 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	memset(&res, 0, sizeof(res));
> -	res.addr =3D pcim_iomap_table(pdev)[i];
> =C2=A0	res.wol_irq =3D pdev->irq;
> =C2=A0	res.irq =3D pdev->irq;
> =C2=A0


