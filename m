Return-Path: <netdev+bounces-184334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53FDA94BDB
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 06:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED6E16FA55
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 04:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17732566D7;
	Mon, 21 Apr 2025 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWSWFEQP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C603C1FC7F1;
	Mon, 21 Apr 2025 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745209229; cv=none; b=cyzAsZB+ih0H9R5gmRwQYps6jV2uD2D4j+2wR5soJx/QLT1GOv3w88DWU6BDJ4zRg8TI+oVB/dYFnL3o77vRL+H6Xt8zs09VOyxjf6z+yB2YpHUeukmRa5DN2DnhYK4t+XU/mMDfAKeoAHEZqw7dLFjulDzUFKVefC9ZfoAx8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745209229; c=relaxed/simple;
	bh=fzz5vJbGd7pv6ViNSfPjoRWY9qisTbb7I3wGIOAq57U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+WgRxhY8k0fPi9srTdSxCClEYbN15IUafwTdoS1fbFqiW4G6Wsod9cWpQeYZwdhZnRdTFIi65H6p1xjdHuQ9uF0VZkfDue9gsOLl6fOPPvqVvQtemtrWS2yxEnxgbU9VB7kLl0Hqgo9Jjy1xQOsiTrBGc9gtSLw+w4OhKgqmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWSWFEQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40689C4CEEE;
	Mon, 21 Apr 2025 04:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745209229;
	bh=fzz5vJbGd7pv6ViNSfPjoRWY9qisTbb7I3wGIOAq57U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jWSWFEQPPejY8w/rkDYZ/medBuywLpbOJspqi/LqHnzp8PSV89wF/urssd3wohMlt
	 Wnnw36x5op00Hq8uPR5KY7hDhtRKdrTz4ZIsTdkY5ed6OZzPtbToWHgkr8Cx6ylCAl
	 TeBT68SoTgBLVaJyxzruKqlbw1U5ANXlxpusUidp7ML0jvMQ0H/VR66m9BSPDvOcm4
	 h8sQTZozvmZWXFNNbeFeidHPpDkcc9sT+K1q+RyVDFY4hujOtpf2Jw4ITviKmlhIJy
	 ZrJP4VKdArdmd14dcINNM0OzZt2ntPXX4ipxkosIX+XMQ6U/uYWZxiU8vkgbGSEvnK
	 c5F4SNW48xB/A==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so5405556a12.0;
        Sun, 20 Apr 2025 21:20:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV94h2gIuTExG/WQgmX9PWoyvywIDQaAcYxKuvbRvr88/eU85Qjpci/eEsjA6pC41ePkCTJ+M0o+/A4q9A=@vger.kernel.org, AJvYcCWiZTQlC7vIXVBNvfgYvNW0mUq0FkK7p4OMiNiwseqL0gkDknzG2jMPyCAHegKaG17isZc06yBg@vger.kernel.org
X-Gm-Message-State: AOJu0YyrRxdXdYXJtAXPWbbw3jCMF8rwLLYnw8r5UXXjnPEVKzhh65Ud
	/mHs1/s/XBoZXzvSFbJoeP1Ev7rpVLvIRMPGjHXKfK2GFr14JWdASaKl0LeaASJ2Kguao2YoBEZ
	u+Vg2+fhPBTZC4MMHBZ9HysvzE9A=
X-Google-Smtp-Source: AGHT+IHZsdvuMa94t5s7Wl81xSRyFyVOkOs7YuACBk6z/PpL2AUVEIqZOYxYjZN7u4uX7F3LM3lScub97stGyXyigSo=
X-Received: by 2002:a17:907:2da4:b0:aca:cad6:458e with SMTP id
 a640c23a62f3a-acb74dd6021mr966291966b.43.1745209227816; Sun, 20 Apr 2025
 21:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416144132.3857990-1-chenhuacai@loongson.cn>
 <20250416144132.3857990-3-chenhuacai@loongson.cn> <fe0a5e7a-6bb2-45ef-8172-c06684885b36@linux.dev>
In-Reply-To: <fe0a5e7a-6bb2-45ef-8172-c06684885b36@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 21 Apr 2025 12:20:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ELoqM8n5A-DD7LOzjb2mkRDR+pM-CAOcfGwZYcVQQ-A@mail.gmail.com>
X-Gm-Features: ATxdqUGcc8EyLCwgp78OF_HVaGFUNUUqjJ_56kgJ9EU-Z9uo3q6DMaUSt86Aug8
Message-ID: <CAAhV-H5ELoqM8n5A-DD7LOzjb2mkRDR+pM-CAOcfGwZYcVQQ-A@mail.gmail.com>
Subject: Re: [PATCH net-next V2 2/3] net: stmmac: dwmac-loongson: Add new
 multi-chan IP core support
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Feiyang Chen <chris.chenfeiyang@gmail.com>, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Henry Chen <chenx97@aosc.io>, Biao Dong <dongbiao@loongson.cn>, 
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yanteng,

On Mon, Apr 21, 2025 at 10:04=E2=80=AFAM Yanteng Si <si.yanteng@linux.dev> =
wrote:
>
>
> =E5=9C=A8 4/16/25 10:41 PM, Huacai Chen =E5=86=99=E9=81=93:
> > Add a new multi-chan IP core (0x12) support which is used in Loongson-
> > 2K3000/Loongson-3B6000M. Compared with the 0x10 core, the new 0x12 core
> > reduces channel numbers from 8 to 4, but checksum is supported for all
> > channels.
> >
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Tested-by: Henry Chen <chenx97@aosc.io>
> > Tested-by: Biao Dong <dongbiao@loongson.cn>
> > Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 62 +++++++++++-------=
-
> >   1 file changed, 37 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/dri=
vers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index 2fb7a137b312..57917f26ab4d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -68,10 +68,11 @@
> >
> >   #define PCI_DEVICE_ID_LOONGSON_GMAC 0x7a03
> >   #define PCI_DEVICE_ID_LOONGSON_GNET 0x7a13
> > -#define DWMAC_CORE_LS_MULTICHAN      0x10    /* Loongson custom ID */
> > -#define CHANNEL_NUM                  8
> > +#define DWMAC_CORE_MULTICHAN_V1      0x10    /* Loongson custom ID 0x1=
0 */
> > +#define DWMAC_CORE_MULTICHAN_V2      0x12    /* Loongson custom ID 0x1=
2 */
> >
> >   struct loongson_data {
> > +     u32 multichan;
>
> In order to make the logic clearer, I suggest splitting this patch.=EF=BC=
=9A
>
>
> 2/4  Add multichan for loongson_data
>
> 3/4 Add new multi-chan IP core support
I don't think the patch is unclear now, the multichan flag is really a
combination of DWMAC_CORE_MULTICHAN_V1 and DWMAC_CORE_MULTICHAN_V2.

>
>
> >       u32 loongson_id;
> >       struct device *dev;
> >   };
> > @@ -119,18 +120,29 @@ static void loongson_default_data(struct pci_dev =
*pdev,
> >       plat->dma_cfg->pbl =3D 32;
> >       plat->dma_cfg->pblx8 =3D true;
> >
> > -     if (ld->loongson_id =3D=3D DWMAC_CORE_LS_MULTICHAN) {
> > -             plat->rx_queues_to_use =3D CHANNEL_NUM;
> > -             plat->tx_queues_to_use =3D CHANNEL_NUM;
> > +     switch (ld->loongson_id) {
> > +     case DWMAC_CORE_MULTICHAN_V1:
>
> How about adding some comments? For example:
>
> case DWMAC_CORE_MULTICHAN_V1:   /* 2K2000 */
> case DWMAC_CORE_MULTICHAN_V2:   /* 2K3000 and 3B6000M */
Do you know why we deprecate PRID (a.k.a SOC name) detection and
prefer CPUCFG detection in cpu_probe()? Because SOC-types and function
features are orthogonal, they should not be strictly bound. There will
be other SOCs using MULTICHAN_V1 or MULTICHAN_V2, should we update the
comments every time when a new SOC publishes? There may also be one
SOC with different IP-cores, then how to comment on this case?

> ...
>
> > +             ld->multichan =3D 1;
> > +             plat->rx_queues_to_use =3D 8;
> > +             plat->tx_queues_to_use =3D 8;
> >
> >               /* Only channel 0 supports checksum,
> >                * so turn off checksum to enable multiple channels.
> >                */
> > -             for (int i =3D 1; i < CHANNEL_NUM; i++)
> > +             for (int i =3D 1; i < 8; i++)
> >                       plat->tx_queues_cfg[i].coe_unsupported =3D 1;
> > -     } else {
> > +
> > +             break;
> > +     case DWMAC_CORE_MULTICHAN_V2:
> > +             ld->multichan =3D 1;
> > +             plat->rx_queues_to_use =3D 4;
> > +             plat->tx_queues_to_use =3D 4;
> > +             break;
> > +     default:
> > +             ld->multichan =3D 0;
> >               plat->tx_queues_to_use =3D 1;
> >               plat->rx_queues_to_use =3D 1;
> > +             break;
> >       }
> >   }
> >
> > @@ -328,14 +340,14 @@ static struct mac_device_info *loongson_dwmac_set=
up(void *apriv)
> >               return NULL;
> >
> >       /* The Loongson GMAC and GNET devices are based on the DW GMAC
> > -      * v3.50a and v3.73a IP-cores. But the HW designers have changed =
the
> > -      * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
> > -      * network controllers with the multi-channels feature
> > +      * v3.50a and v3.73a IP-cores. But the HW designers have changed
> > +      * the GMAC_VERSION.SNPSVER field to the custom 0x10/0x12 value
> > +      * on the network controllers with the multi-channels feature
> >        * available to emphasize the differences: multiple DMA-channels,
> >        * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
> >        * original value so the correct HW-interface would be selected.
> >        */
> > -     if (ld->loongson_id =3D=3D DWMAC_CORE_LS_MULTICHAN) {
> > +     if (ld->multichan) {
> >               priv->synopsys_id =3D DWMAC_CORE_3_70;
> >               *dma =3D dwmac1000_dma_ops;
> >               dma->init_chan =3D loongson_dwmac_dma_init_channel;
> > @@ -356,13 +368,13 @@ static struct mac_device_info *loongson_dwmac_set=
up(void *apriv)
> >       if (mac->multicast_filter_bins)
> >               mac->mcast_bits_log2 =3D ilog2(mac->multicast_filter_bins=
);
> >
> > -     /* Loongson GMAC doesn't support the flow control. LS2K2000
> > -      * GNET doesn't support the half-duplex link mode.
> > +     /* Loongson GMAC doesn't support the flow control. Loongson GNET
> > +      * without multi-channel doesn't support the half-duplex link mod=
e.
> >        */
> >       if (pdev->device =3D=3D PCI_DEVICE_ID_LOONGSON_GMAC) {
> >               mac->link.caps =3D MAC_10 | MAC_100 | MAC_1000;
> >       } else {
> > -             if (ld->loongson_id =3D=3D DWMAC_CORE_LS_MULTICHAN)
> > +             if (ld->multichan)
> >                       mac->link.caps =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE=
 |
> >                                        MAC_10 | MAC_100 | MAC_1000;
> >               else
> > @@ -391,9 +403,11 @@ static int loongson_dwmac_msi_config(struct pci_de=
v *pdev,
> >                                    struct plat_stmmacenet_data *plat,
> >                                    struct stmmac_resources *res)
> >   {
> > -     int i, ret, vecs;
> > +     int i, ch_num, ret, vecs;
> >
> > -     vecs =3D roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> > +     ch_num =3D min(plat->tx_queues_to_use, plat->rx_queues_to_use);
>
> I'm curious. Will there still be hardware with RX not equal to TX in the
> future?
Currently rx queue number is equal to tx queue number, but
min(plat->tx_queues_to_use, plat->rx_queues_to_use) is still the best
solution. If not, which one should be used here? tx_queues_to_use or
rx_queues_to_use?

Huacai

>
>
> Thanks,
>
> Yanteng
>
>

