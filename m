Return-Path: <netdev+bounces-169371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458D1A4395E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FD33AA108
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C259B214203;
	Tue, 25 Feb 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqa8hrvN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB71A4E70;
	Tue, 25 Feb 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475190; cv=none; b=UONz/vzIqgSsx2kJ6Yb3UybvnN+I+a9oITQNxZyEiJ/ZnlvrOIGIIDms4/3sangXTPqe7TkX5yM2ha1PmNr/Qch28F43F6kc7MiCeuj4T/7AWO5/TPyHAJG7IdfeLvj5g8d2UUrp6uFH3wwiut79paqkSueVvF9cGj0y6fdAxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475190; c=relaxed/simple;
	bh=WV/BQQjSklg+inxqIej//MnYL20DO4u7FlUKUcFIGv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duAdKgAUmCMmGmo8UT8Ks3YJSt1ARi946rnZUqkALI2fjr4dyyjVahqK3pMU71j/iGYCuzdMPzPXq8XaZJCBYi1JLDo/fgmQfuTloPGgaXLeySJ0k+Jtv+hZFyxjuUMW/VxnLeIft6TlTXOQ+mC8Fgp1MKmrPuvs0/y5kM4RqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqa8hrvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4BCC4CEF0;
	Tue, 25 Feb 2025 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740475190;
	bh=WV/BQQjSklg+inxqIej//MnYL20DO4u7FlUKUcFIGv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nqa8hrvNEdtESHepNoK33z6bHqU5dvgKbp0Yr2cSPd+LQww+L4gVku3jbn+aTpYnD
	 gOtbELHFspakf/y82ddzGTkeS/oYi34BXHoKvPVh0Syb/lkHN4cLCl15AebTJNVydw
	 +2cAdStkTbzFDl4v+XhQ4HqWq4ljYU7eaah1odM6An2qpw15KdMmsOraonMtam8rLI
	 TmaD+zOv3TbNV9Z+KqX2BTEKSzvcVGrb2dCUBDx7iIWJ+SumM7Elos19q5m9Y3AxPx
	 rbvts/03En1J2eNSZkY/+o7AeFadtswXBTGFe8yvH3M5O7XzkID3AtMVvwRKOZQQei
	 MthekgK65T2NQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab771575040so1101951666b.1;
        Tue, 25 Feb 2025 01:19:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVsijjqSwE6+3ZiNJJ18TyO58pO3qEBR6vxUJxvpsq+9Wi0ytgS+xJ0ef14l3iQgbaZ/e0JZ/G@vger.kernel.org, AJvYcCXf6g8LtgQs3m5PAcjc66iEA579almAkcQZ27/5aojuhLnVjVN3QPZMObuY0p9zZ9WkFPv34+3uiEbhbNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjSSM0nokluOY/k11gNM4f3hIx8NprOLSsfi+ED8mzVlJijKBt
	jLiAWefufITOc5r/g9L8z+qrhJdkBgNV+kZtBiHocwtPFKB1lecHVYQoi3PjvZUotYtAz3lQRdx
	G3KCqF9umEbrClI9wC/980ZdLx2I=
X-Google-Smtp-Source: AGHT+IHH5/lZpNbRGSgruDA194J8Wu4I6GsbEXWL0O7Bhszg4FzraJyCq1ptOSxW6ZjsuQkpHhmLCFX1Z/wZ9UNOce0=
X-Received: by 2002:a17:907:7a88:b0:ab6:fe30:f49e with SMTP id
 a640c23a62f3a-abc0b0e5fcdmr1785569066b.28.1740475188509; Tue, 25 Feb 2025
 01:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224135321.36603-2-phasta@kernel.org> <20250224135321.36603-5-phasta@kernel.org>
 <425215fb-8fb5-4412-87e7-1d29c4ac0b7f@linux.dev>
In-Reply-To: <425215fb-8fb5-4412-87e7-1d29c4ac0b7f@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 25 Feb 2025 17:19:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6yVX_tgdiDP+vVB3K-dbRm-ejF0ngmN8UgFD8eRVaTJg@mail.gmail.com>
X-Gm-Features: AQ5f1Josz9kykUlq72YeUoErSStI-rKm3nm-tjAtPbfVHHpD6td2eL_df52t8Dk
Message-ID: <CAAhV-H6yVX_tgdiDP+vVB3K-dbRm-ejF0ngmN8UgFD8eRVaTJg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/4] stmmac: Remove pcim_* functions for
 driver detach
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Philipp Stanner <phasta@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Yinggang Gu <guyinggang@loongson.cn>, Feiyang Chen <chenfeiyang@loongson.cn>, 
	Philipp Stanner <pstanner@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Qing Zhang <zhangqing@loongson.cn>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:11=E2=80=AFPM Yanteng Si <si.yanteng@linux.dev> w=
rote:
>
>
> =E5=9C=A8 2/24/25 9:53 PM, Philipp Stanner =E5=86=99=E9=81=93:
> > Functions prefixed with "pcim_" are managed devres functions which
> > perform automatic cleanup once the driver unloads. It is, thus, not
> > necessary to call any cleanup functions in remove() callbacks.
> >
> > Remove the pcim_ cleanup function calls in the remove() callbacks.
> >
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c |  7 -------
> >   drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c     | 10 ----------
> >   2 files changed, 17 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/dri=
vers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index e3cacd085b3f..f3ea6016be68 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -614,13 +614,6 @@ static void loongson_dwmac_remove(struct pci_dev *=
pdev)
> >       if (ld->loongson_id =3D=3D DWMAC_CORE_LS_MULTICHAN)
> >               loongson_dwmac_msi_clear(pdev);
> >
> > -     for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -             if (pci_resource_len(pdev, i) =3D=3D 0)
> > -                     continue;
> > -             pcim_iounmap_regions(pdev, BIT(i));
> > -             break;
> > -     }
> > -
> >       pci_disable_device(pdev);
> >   }
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_pci.c
> > index 352b01678c22..91ff6c15f977 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> > @@ -227,20 +227,10 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
> >    *
> >    * @pdev: platform device pointer
>
> >    * Description: this function calls the main to free the net resource=
s
>
> There is a missing full stop. You commented on the next email,
>
> and it seems that you are already preparing for v4.  With this
>
>
> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

>
> Thanks,
> Yanteng
>
> > - * and releases the PCI resources.
> >    */
> >   static void stmmac_pci_remove(struct pci_dev *pdev)
> >   {
> > -     int i;
> > -
> >       stmmac_dvr_remove(&pdev->dev);
> > -
> > -     for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -             if (pci_resource_len(pdev, i) =3D=3D 0)
> > -                     continue;
> > -             pcim_iounmap_regions(pdev, BIT(i));
> > -             break;
> > -     }
> >   }
> >
> >   static int __maybe_unused stmmac_pci_suspend(struct device *dev)

