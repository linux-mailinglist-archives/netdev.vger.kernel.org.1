Return-Path: <netdev+bounces-169375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6F4A43980
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E38F1887BBF
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAA925A326;
	Tue, 25 Feb 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuV7oYqO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261A1FE465;
	Tue, 25 Feb 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475757; cv=none; b=C/omyI7rO4LU4cs7vmptyTc7AVH+EnGIL3qAsSzjgNhbIw7rHPVsxn9dt8CX7A1IoG8tpxq9YiYPHjj3v7AWEj/+giUhRYyxUQ8N2KHyMu0y84gtGT9qbPEMtVHyc+D1TLLgWT3D+T1uxV0q+soV+gLTZwDKEkfkG23k16ymJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475757; c=relaxed/simple;
	bh=5QI9uHnbKrXRYGECovSmXyJvXB7auSAuhh+3htNO7DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDURvx4YapLnwIQL6TFOGnsXK61nj9qlBbjyQXm1HwJSc474sk3sOeQxR26I+LTsoAp5nrNJhVQFNk06w/h1meLTWXn+yiBm/00oX38x/3id5IHU0CFa4WFfeuCJU8M0htY0xQw9Cv0qhJYtQvguqk5zAfwTs4x5Sl9kYt/Vn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuV7oYqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BD9C4CEEF;
	Tue, 25 Feb 2025 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740475755;
	bh=5QI9uHnbKrXRYGECovSmXyJvXB7auSAuhh+3htNO7DE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nuV7oYqOqcFYUbXxbNP3rUkXVAa8592p3HxdihLdC5kXmWBKKZR3WqKQQendCNaV/
	 oENz2v5D7A9JKyUOf1uodJmLm1dwCSf8wP9Z8AP/kNQM8sDn99CZQi/ZJHDXpPb4Xb
	 d3PsLgO8xvfl7+lTWEKmbzenhWL8/jbbFC1E00x79diKhjTnwZcyo/4ktVzkaBvZ/j
	 OMGrPyQUPqBO+cQUWzk+7fFfEfSclBkWkxYrXRneYbAli5NQXMgr0v5DJ6YHwiQglV
	 QNPmFR5o+111CjBJYMXitgSeAeKXxONTPS5aQt0+JCNGA5357tdKC38UIqcBMLjBoR
	 GEGMFWKIGIpXg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb86beea8cso959290866b.1;
        Tue, 25 Feb 2025 01:29:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYPEVk66PhUZVdwApiy3UVnHSOYjS268gTKgw0zh/mjThmzeKnHl8S5nvFdhe3lZINUCAGrf1v@vger.kernel.org, AJvYcCXxRAHKK89uLKN9KiBRvoSenXcOJSLUsbaxhEPclp0ZimY8u1cXZHhu2NLVB8SVHNeTeyoLcIAyiwqsJ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQPTe88Rl1decGRjaLejg3bw34lPOGp6t4i+eFmu0n2kF6GoO
	Gav2x6UIHSI5DXu2YxJa+sZKPSDIoiKQvDswke0BfqbwwhaS4kavHsTbGD2A1fiLG9gt2buVfPz
	THSuTqsbPQansyWa09hygGXR29Gc=
X-Google-Smtp-Source: AGHT+IEOq0At6zPT+OpiunH+4BSketgcPR98DlixUCXVccfuLEsVE/TVTjLEJE+pZxuYrZTPiI+ADoAS4DNWkmoERiQ=
X-Received: by 2002:a17:907:9406:b0:aaf:c259:7f6 with SMTP id
 a640c23a62f3a-abc09d35ecfmr1620078166b.45.1740475754321; Tue, 25 Feb 2025
 01:29:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224135321.36603-2-phasta@kernel.org> <20250224135321.36603-4-phasta@kernel.org>
In-Reply-To: <20250224135321.36603-4-phasta@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 25 Feb 2025 17:29:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Eu3VNO615wMdMT2bbeSurACwyR9uJmSGHErdyVu950Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpaEC4JuCS1MMY9EZYHmlHgtkdETZGtwE5y_2Q9kz7yTyHXXJLQzlO9aME
Message-ID: <CAAhV-H4Eu3VNO615wMdMT2bbeSurACwyR9uJmSGHErdyVu950Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/4] stmmac: loongson: Remove surplus loop
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
> loongson_dwmac_probe() contains a loop which doesn't have an effect,
> because it tries to call pcim_iomap_regions() with the same parameters
> several times. The break statement at the loop's end furthermore ensures
> that the loop only runs once anyways.
>
> Remove the surplus loop.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 73a6715a93e6..e3cacd085b3f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -554,14 +554,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev=
, const struct pci_device_id
>         pci_set_master(pdev);
>
>         /* Get the base address of device */
> -       for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> -               if (pci_resource_len(pdev, i) =3D=3D 0)
> -                       continue;
> -               ret =3D pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
> -               if (ret)
> -                       goto err_disable_device;
> -               break;
> -       }
> +       ret =3D pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
> +       if (ret)
> +               goto err_disable_device;
>
>         memset(&res, 0, sizeof(res));
>         res.addr =3D pcim_iomap_table(pdev)[0];
> --
> 2.48.1
>

