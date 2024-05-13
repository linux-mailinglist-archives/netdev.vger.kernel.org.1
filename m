Return-Path: <netdev+bounces-96031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4289D8C40EB
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C820B23705
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7456114F9C6;
	Mon, 13 May 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqMNKEin"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85B14C5A3
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604192; cv=none; b=HdUgVld/fqT6O5eP/sLEtjkilovlclSuR97c3dFSl/tqijex8nNwxwg7TPZYBYySOmAQLEhvZ6KKaE6GFHygm04ZQvt1ewvuue+ZOoN1ynq5Vq0dErT2Lm48jCj0TZYhsaFvKNgf8gjeWb0wlhHPYVexpv67abUU8HjUymLcvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604192; c=relaxed/simple;
	bh=MCWMF72NhQFLa+nEpDZpgYfN8q4BqExa/29G0Atn6NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8xtL7YzZ8+wCpnbEKb0iLiMbANaLtHq4Km9SZUroRj82F6kkoDHFh6DvdfWK+dXxT0+4JiGskZ+wmw7eo/PT534TQsCRrIT2Lif95RmIOhchmgd7EnP9I2d+d0qeyhXPbTEvIXh5oeAG9OMH5myZmDaYn0xSYyf3xrL1Rj6udo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqMNKEin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE741C32786
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715604191;
	bh=MCWMF72NhQFLa+nEpDZpgYfN8q4BqExa/29G0Atn6NA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CqMNKEin5MJHArmk4d2Hi1fvOt73Zt2/4sC0oywvus9TI/JNs25FeCfw4T0f8Ic7E
	 g4Kp7+brRftEf8AMK0t1aYVFQnW6XG6rCAk/QfDV28viAeT8WWm8EptOuIYeZeYwDa
	 xkqxRwyXxp5LEq7rdqrve3fOfifkJW3cxNuaaZ+gSrQBuW9RnIG6gF4uyRgpyqqiEe
	 BTpe/awg3dFEMjjnPm8URRQ5zbgSCFGfw9uHvllgl9dU76J7YveFcQzdbBHM474DPB
	 jTuM5kXZViwUHu4MQdaA+AdtAitG4lXsjXfZyWeFrs3JRVuw6EApWxqCJhFMyKLMAh
	 fO9nHQjl7NBNQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so7347556e87.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 05:43:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIcTtzVjBF253RwQ2mGAuiB6z9NPmcbAh69zHEI46eIy2boq3JNNXGbrDcukHDipRQKbnrGZkReJIdEzpfynKoREeGltj9
X-Gm-Message-State: AOJu0YzlV0KKbq9yOAWC6DklR5FQK+q5AdmOocEsVON1l0WoKSyjaAJ6
	Dw3eIOoWS6/NaW9VSlfG0u43XTjOuNivwBtz7sgK0qvw8I32Kja6smrP0tEnenaPvtNXRVE5OCU
	Wh8fWJ3no7J52lGFbLJnWVuBNtEs=
X-Google-Smtp-Source: AGHT+IFEUmvA936WBNfjvrWXXqvQMrhUA2UmRGTpKOuOIbNcwZE+xXN8uhjUliYu6K6kBN0mjkzfwCwJTUokdRMRNok=
X-Received: by 2002:ac2:4c85:0:b0:51f:5d1a:b320 with SMTP id
 2adb3069b0e04-5221047585dmr7420615e87.68.1715604190176; Mon, 13 May 2024
 05:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714046812.git.siyanteng@loongson.cn> <e0ea692698171f9c69b80a70607a55805d249c4a.1714046812.git.siyanteng@loongson.cn>
 <arxxtmtifgus4qfai5nkemg46l5ql5ptqfodnflqpf2eenfj57@4x4h3vmcuw5x> <29f046d6-67a8-4566-be6a-e2ee73037a94@loongson.cn>
In-Reply-To: <29f046d6-67a8-4566-be6a-e2ee73037a94@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 13 May 2024 20:42:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ZCXZO2NHzKNQuD2Q0ciBi4VmP31sd1tChF_QD=Ofz0Q@mail.gmail.com>
Message-ID: <CAAhV-H6ZCXZO2NHzKNQuD2Q0ciBi4VmP31sd1tChF_QD=Ofz0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v12 06/15] net: stmmac: dwmac-loongson: Split up
 the platform data initialization
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Serge Semin <fancer.lancer@gmail.com>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	Jose.Abreu@synopsys.com, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 7:07=E2=80=AFPM Yanteng Si <siyanteng@loongson.cn> =
wrote:
>
>
> =E5=9C=A8 2024/5/4 02:08, Serge Semin =E5=86=99=E9=81=93:
> >> [PATCH net-next v12 06/15] net: stmmac: dwmac-loongson: Split up the p=
latform data initialization
> > Please convert the subject to being more specific, like this:
> >
> > net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
> >
> > On Thu, Apr 25, 2024 at 09:04:37PM +0800, Yanteng Si wrote:
> >> Based on IP core classification, loongson has two types of network
> > What is the real company name? At least start the name with the
> > capital letter.
> > * everywhere
> OK,  LOONGSON
> >
> >> devices: GMAC and GNET. GMAC's ip_core id is 0x35/0x37, while GNET's
> >> ip_core id is 0x37/0x10.
> > s/ip_core/IP-core
> >
> > Once again the IP-core ID isn't _hex_, but a number of the format:
> > "v+Major.Minor"
> > so use the _real_ IP-core version number everywhere. Note mentioning
> > that some of your GNET device has the GMAC_VERSION.SNPSVER hardwired
> > to 0x10 is completely redundant in this and many other context. The
> > only place where it's relevant is the patch(es) where you have the
> > Snps ID override.
> OK.
> >
> >> Device tables:
> >>
> >> device    type    pci_id    snps_id    channel
> >> ls2k1000  gmac    7a03      0x35/0x37   1
> >> ls7a1000  gmac    7a03      0x35/0x37   1
> >> ls2k2000  gnet    7a13      0x10        8
> >> ls7a2000  gnet    7a13      0x37        1
> > s/gmac/GMAC
> > s/gnet/GNET
> > s/pci_id/PCI Dev ID
> > s/snsp_id/Synopys Version
> > s/channels/DMA-channels
> > s/ls2k/LS2K
> > s/ls7a/LS7A
> >
> > * everywhere
> OK.
> >
> >> The GMAC device only has a MAC chip inside and needs an
> >> external PHY chip;
> >>
> >> To later distinguish 8-channel gnet devices from single-channel
> >> gnet/gmac devices, move rx_queues_to_use loongson_default_data
> >> to loongson_dwmac_probe(). Also move mac_interface to
> >> loongson_default_data().
> > Again. This is only a part of the reason why you need this change.
> > The main reason is to provide the two-leveled platform data init
> > functions: fist one is the common method initializing the data common
> > for both GMAC and GNET, second one is the device-specific data
> > initializer.
> >
> > To sum up I would change the commit log to something like this:
> >
> > "Loongson delivers two types of the network devices: Loongson GMAC and
> > Loongson GNET in the framework of four CPU/Chipsets revisions:
> >
> >     Chip             Network  PCI Dev ID   Synopys Version   DMA-channe=
l
> > LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
> > LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
> > LS2K2000 CPU         GNET      0x7a13          v3.73a            8
> > LS7A2000 Chipset     GNET      0x7a13          v3.73a            1
> >
> > The driver currently supports the chips with the Loongson GMAC network
> > device. As a preparation before adding the Loongson GNET support
> > detach the Loongson GMAC-specific platform data initializations to the
> > loongson_gmac_data() method and preserve the common settings in the
> > loongson_default_data().
> >
> > While at it drop the return value statement from the
> > loongson_default_data() method as redundant."
> OK, Thanks!
> >
> >> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> >> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> >> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> >> ---
> >>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 20 ++++++++++++-----=
--
> >>   1 file changed, 13 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/dr=
ivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >> index 4e0838db4259..904e288d0be0 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >> @@ -11,22 +11,20 @@
> >>
> >>   #define PCI_DEVICE_ID_LOONGSON_GMAC        0x7a03
> >>
> >> -static int loongson_default_data(struct plat_stmmacenet_data *plat)
> >> +static void loongson_default_data(struct plat_stmmacenet_data *plat)
> >>   {
> >>      plat->clk_csr =3D 2;      /* clk_csr_i =3D 20-35MHz & MDC =3D clk=
_csr_i/16 */
> >>      plat->has_gmac =3D 1;
> >>      plat->force_sf_dma_mode =3D 1;
> >>
> >> +    plat->mac_interface =3D PHY_INTERFACE_MODE_GMII;
> >> +
> > I double-checked this part in my HW and in the databooks. DW GMAC with
> > _RGMII_ PHY-interfaces can't be equipped with a PCS (STMMAC driver is
> > wrong in considering otherwise at least in the Auto-negotiation part).
> > PCS is only available for the RTI, RTBI and SGMII interfaces.
> >
> > You can double-check that by checking out the DMA_HW_FEATURE.PCSSEL
> > flag state. I'll be surprised if it's set in your case. If it isn't
> > then either drop the plat_stmmacenet_data::mac_interface
> > initialization or (as Russell suggested) initialize it with
> > PHY_INTERFACE_MODE_NA. But do that in a separate pre-requisite patch!
> OK.
> >
> >>      /* Set default value for unicast filter entries */
> >>      plat->unicast_filter_entries =3D 1;
> >>
> >>      /* Set the maxmtu to a default of JUMBO_LEN */
> >>      plat->maxmtu =3D JUMBO_LEN;
> >>
> >> -    /* Set default number of RX and TX queues to use */
> >> -    plat->tx_queues_to_use =3D 1;
> >> -    plat->rx_queues_to_use =3D 1;
> >> -
> >>      /* Disable Priority config by default */
> >>      plat->tx_queues_cfg[0].use_prio =3D false;
> >>      plat->rx_queues_cfg[0].use_prio =3D false;
> >> @@ -41,6 +39,12 @@ static int loongson_default_data(struct plat_stmmac=
enet_data *plat)
> >>      plat->dma_cfg->pblx8 =3D true;
> >>
> >>      plat->multicast_filter_bins =3D 256;
> >> +}
> >> +
> >> +static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
> >> +{
> >> +    loongson_default_data(plat);
> >> +
> >>      return 0;
> >>   }
> >>
> >> @@ -109,11 +113,10 @@ static int loongson_dwmac_probe(struct pci_dev *=
pdev, const struct pci_device_id
> >>      }
> >>
> >>      plat->phy_interface =3D phy_mode;
> >> -    plat->mac_interface =3D PHY_INTERFACE_MODE_GMII;
> >>
> >>      pci_set_master(pdev);
> >>
> >> -    loongson_default_data(plat);
> >> +    loongson_gmac_data(plat);
> >>      pci_enable_msi(pdev);
> >>      memset(&res, 0, sizeof(res));
> >>      res.addr =3D pcim_iomap_table(pdev)[0];
> >> @@ -138,6 +141,9 @@ static int loongson_dwmac_probe(struct pci_dev *pd=
ev, const struct pci_device_id
> >>              goto err_disable_msi;
> >>      }
> >>
> >> +    plat->tx_queues_to_use =3D 1;
> >> +    plat->rx_queues_to_use =3D 1;
> >> +
> > You can freely move this to loongson_gmac_data() method. And then, in
> > the patch adding the GNET-support, you'll be able to provide these fiel=
ds
> > initialization in the loongson_gnet_data() method together with the
> > plat->tx_queues_cfg[*].coe_unsupported flag init. Thus the probe()
> > method will get to be smaller and easier to read, and the
> > loongson_*_data() method will be more coherent.
>
> As you said, at first glance, putting them in loongson_gnet_data()
> method is fine,
>
> but in LS2K2000:
>
>          plat->rx_queues_to_use =3D CHANNEL_NUM;    // CHANNEL_NUM =3D 8;
>          plat->tx_queues_to_use =3D CHANNEL_NUM;
>
> So we need to distinguish between them. At the same time, we have to
> distinguish
>
> between LS2K2000 in probe() method. Why not put them inside probe, which
> will
>
> save a lot of duplicate code, like this:
>
>      struct stmmac_resources res;
>      struct loongson_data *ld;
>
> ...
>
>      memset(&res, 0, sizeof(res));
>      res.addr =3D pcim_iomap_table(pdev)[0];
>      ld->gmac_verion =3D readl(res.addr + GMAC_VERSION) & 0xff;
>
>      switch (ld->gmac_verion) {
>      case LOONGSON_DWMAC_CORE_1_00:
>          plat->rx_queues_to_use =3D CHANNEL_NUM;
>          plat->tx_queues_to_use =3D CHANNEL_NUM;
>
>          /* Only channel 0 supports checksum,
>           * so turn off checksum to enable multiple channels.
>           */
>          for (i =3D 1; i < CHANNEL_NUM; i++)
>              plat->tx_queues_cfg[i].coe_unsupported =3D 1;
>
>          ret =3D loongson_dwmac_config_msi(pdev, plat, &res, np);
>          break;
>      default:    /* 0x35 device and 0x37 device. */
>          plat->tx_queues_to_use =3D 1;
>          plat->rx_queues_to_use =3D 1;
>
>          ret =3D loongson_dwmac_config_legacy(pdev, plat, &res, np);
>          break;
>      }
>      if (ret)
>          goto err_disable_device;
>
>
> What do you think?
>
>
> Of course, if you insist, I'm willing to repeat this in the
>
> loongson_gnet_data() method.
In my opinion, it is the most elegant method by reading gmac_version
only once in the probe function, and save it in loongson_data for
other functions to use. So, it is good for me to put the switch-case
in the probe function.

Huacai
>
>
>
> Thanks,
>
> Yanteng
>

