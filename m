Return-Path: <netdev+bounces-128615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8C97A9B1
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189691C234ED
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 23:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CD15535A;
	Mon, 16 Sep 2024 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dvnvwGYH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863714BFBF
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726530239; cv=none; b=tptChJ81oUq1+BhNhVSNeJFF5EhQgQ7votP4q25A4Uv4WPh5dOKDXXNZYeDRl6iV9ntmsu49DHUlX4XXKyPWRo2qSC+xsLCXJdcK+pDGLRHUMFq6TC4NA/D9TbuW4B363NNwGAlbe5ZnXfLQwjAo2Q/knN80nyU8IRCZX40HMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726530239; c=relaxed/simple;
	bh=u1YaqZN14RDCxXBWc2qMTsW1Xw5ZOEH0WziLR4ejItA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXfbSP+QQv7qfPN01fR/y4xaWmZcw49K0jmC0ZNqOwTHpQmI5kS7iZdG1KTQTKg+xh2Ad3lksX/JpJfBOqoVXAFS9uFZ0IZcr0pVsYIJSnh0JXs0zMtYyD/5EquoMr/2xmGF85zXsBxdoIaQrrheJCD3nO2ErGG814NH61UuOjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dvnvwGYH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71788bfe60eso3734862b3a.1
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 16:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726530237; x=1727135037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77kXHk0CwQMaJZ+QC7si1m6ucR6ldM5v4PVuuUisH0I=;
        b=dvnvwGYHn7pi05SR0M3CVtoMz/5RlSpDyU1R73TRnRdchAZHRQg9XZgLVpTDXrvyNJ
         4a/WZ5Q8jemQRy6chbFdHfx3VrifTFoikwuP1T7Cn4i6FerHN8w3Qkw4MuJIQNpsdus3
         cmP3j6neWpsmAmRneUbOFuywdzsjv4ewiFCGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726530237; x=1727135037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77kXHk0CwQMaJZ+QC7si1m6ucR6ldM5v4PVuuUisH0I=;
        b=OKMSyLg0Szfg7K+Nd27Du3kGLGPnLWSJSo+X53khj3M5n5RMe1ZyzpigUeJ8W/FFBa
         LMZNXeYfmSpkIH08iF/6wiOEA/FdhcqRl1nnFewowQ0v9eCN5B94VAFDOGvq5AEGuPDP
         iquEoWwyv7mZW1dTvseGO6D/p4mb937wsxuJXYjYau1dJsb3w+t1XTB4ZL/TQPiFjfan
         z++5ZIL/iOzh35g5ufaTm5m1hnhQwIft12rN0w/PJ7NZNrKzHhGCREAAx0xG6S4dmrmg
         jbrwGqGK6i60DoBkXGGeomPP/G+zteCJR1UahP2y2IAq6iVmNBw089BM9s1IJx7pQZW2
         8wLg==
X-Gm-Message-State: AOJu0YxTFnb8yZ34imKY/s4XGVzxEaUqzSHwSydJbuIya0s99ZzGibGg
	hArR8GBTPfiETig2MyhRmt3r1BL2Fkma/ea4Vwd4q4tjlXQ+8AA9606z4KcD+MMKIdDvBgvwnRb
	XK3lU+Dt4Sn2/prYxn5YoWvk5JT52TBH3kNK5
X-Google-Smtp-Source: AGHT+IGUjIkkpfK0iPlFkg8EaL4VmYJF0nBRgVTT/N67tb3/JDKoTTnfr1O/z7MIgDN2Z5Ml2NWgrfR4hsIHoHZwgA0=
X-Received: by 2002:a05:6a00:198d:b0:714:2014:d783 with SMTP id
 d2e1a72fcca58-7192605a0b1mr24314029b3a.2.1726530237339; Mon, 16 Sep 2024
 16:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
 <20240904054815.1341712-5-jitendra.vegiraju@broadcom.com> <zv2yxt4aw2wscvmcaadll5gmiswhlgdiesuny2ge7ufhs3xyjn@d7oxhj63qiey>
In-Reply-To: <zv2yxt4aw2wscvmcaadll5gmiswhlgdiesuny2ge7ufhs3xyjn@d7oxhj63qiey>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 16 Sep 2024 16:43:45 -0700
Message-ID: <CAMdnO-JBU6k7a4UZa6jOWCk1un9ub9dSS40y8cW+jOWdMupQUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/5] net: stmmac: Add PCI driver support for BCM8958x
To: Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, 
	ahalaney@redhat.com, xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, 
	Jianheng.Zhang@synopsys.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Serge
Thanks for reviewing the patches.
On Tue, Sep 10, 2024 at 12:52=E2=80=AFPM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> On Tue, Sep 03, 2024 at 10:48:14PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
>
> > +#define READ_POLL_DELAY_US                   100
> > +#define READ_POLL_TIMEOUT_US                 10000
>
> These macros are unused. Why do you need them here?
>
Thanks, missed the cleaning these up.
> > +#define DWMAC_125MHZ                         125000000
> > +#define DWMAC_250MHZ                         250000000
>
> Drop these and use the literals directly.
>
Ack
> > +#define BRCM_XGMAC_NUM_VLAN_FILTERS          32
> > +
> > +/* TX and RX Queue counts */
> > +#define BRCM_TX_Q_COUNT                              4
> > +#define BRCM_RX_Q_COUNT                              4
> > +
>
> > +#define BRCM_XGMAC_DMA_TX_SIZE                       1024
> > +#define BRCM_XGMAC_DMA_RX_SIZE                       1024
>
> Unused.
>
Ack
> > +static void dwxgmac_brcm_common_default_data(struct plat_stmmacenet_da=
ta *plat)
> > +{
> > +     int i;
> > +
> > +     plat->has_xgmac =3D 1;
> > +     plat->force_sf_dma_mode =3D 1;
> > +     plat->mac_port_sel_speed =3D SPEED_10000;
>
> > +     plat->clk_ptp_rate =3D DWMAC_125MHZ;
> > +     plat->clk_ref_rate =3D DWMAC_250MHZ;
>
> Just 125000000 and 250000000. There is no need in defining the macro
> with the names matching the numerical literals.
>
Ack
> > +static int dwxgmac_brcm_default_data(struct pci_dev *pdev,
> > +                                  struct plat_stmmacenet_data *plat)
> > +{
> > +     /* Set common default data first */
> > +     dwxgmac_brcm_common_default_data(plat);
> > +
> > +     plat->snps_id =3D DW25GMAC_CORE_4_00;
> > +     plat->snps_dev_id =3D DW25GMAC_ID;
> > +     plat->bus_id =3D 0;
> > +     plat->phy_addr =3D 0;
>
> > +     plat->phy_interface =3D PHY_INTERFACE_MODE_USXGMII;
>
> Really, USXGMII? Universal Serial XGMII? Synopsys call it just XGMII:
> https://www.synopsys.com/dw/ipdir.php?ds=3Ddwc_25g_ethernet_mac_ip
>
Thanks for pointing out. It was a misunderstanding on our part.
I will change it to XGMII and add corresponding handling for XGMII in
stmmac_mac_link_up().

> > +
>
> > +     plat->msi_mac_vec =3D BRCM_XGMAC_MSI_MAC_VECTOR;
> > +     plat->msi_rx_base_vec =3D BRCM_XGMAC_MSI_RX_VECTOR_START;
> > +     plat->msi_tx_base_vec =3D BRCM_XGMAC_MSI_TX_VECTOR_START;
>
> Please see my next comments about these fields utilization.
>
Ack
> > +
> > +     return 0;
> > +}
> > +
> > +static struct dwxgmac_brcm_pci_info dwxgmac_brcm_pci_info =3D {
> > +     .setup =3D dwxgmac_brcm_default_data,
> > +};
> > +
> > +static void brcm_config_misc_regs(struct pci_dev *pdev,
> > +                               struct brcm_priv_data *brcm_priv)
> > +{
> > +     pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LOW,
> > +                            XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LO_VALUE);
> > +     pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HIGH,
> > +                            XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HI_VALUE);
> > +
> > +     misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_OFFSET=
,
> > +                  XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VALUE);
> > +     misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_OFFSET=
,
> > +                  XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VALUE);
> > +
> > +     /* Enable Switch Link */
> > +     misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MII_CTRL_OFFSET,
> > +                  XGMAC_PCIE_MISC_MII_CTRL_PAUSE_RX |
> > +                  XGMAC_PCIE_MISC_MII_CTRL_PAUSE_TX |
> > +                  XGMAC_PCIE_MISC_MII_CTRL_LINK_UP);
> > +}
> > +
> > +static int brcm_config_multi_msi(struct pci_dev *pdev,
> > +                              struct plat_stmmacenet_data *plat,
> > +                              struct stmmac_resources *res)
> > +{
> > +     int ret, i;
> > +
>
> > +     if (plat->msi_rx_base_vec >=3D STMMAC_MSI_VEC_MAX ||
> > +         plat->msi_tx_base_vec >=3D STMMAC_MSI_VEC_MAX) {
>
> Please see my next comment about these fields and STMMAC_MSI_VEC_MAX
> utilization.
>
Ack
> > +             dev_err(&pdev->dev, "%s: Invalid RX & TX vector defined\n=
",
> > +                     __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret =3D pci_alloc_irq_vectors(pdev, 2, STMMAC_MSI_VEC_MAX,
> > +                                 PCI_IRQ_MSI | PCI_IRQ_MSIX);
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "%s: multi MSI enablement failed\n",
> > +                     __func__);
> > +             return ret;
> > +     }
> > +
> > +     /* For RX MSI */
> > +     for (i =3D 0; i < plat->rx_queues_to_use; i++)
> > +             res->rx_irq[i] =3D pci_irq_vector(pdev,
> > +                                             plat->msi_rx_base_vec + i=
 * 2);
> > +
> > +     /* For TX MSI */
> > +     for (i =3D 0; i < plat->tx_queues_to_use; i++)
> > +             res->tx_irq[i] =3D pci_irq_vector(pdev,
> > +                                             plat->msi_tx_base_vec + i=
 * 2);
> > +
>
> > +     if (plat->msi_mac_vec < STMMAC_MSI_VEC_MAX)
> > +             res->irq =3D pci_irq_vector(pdev, plat->msi_mac_vec);
>
> What if msi_mac_vec is greater than STMMAC_MSI_VEC_MAX? Will your
> device work without delivering the MAC IRQs? I doubt so.
>
> In anyway see my next comment.
>
Ack
> > +
> > +static int dwxgmac_brcm_pci_probe(struct pci_dev *pdev,
> > +                               const struct pci_device_id *id)
>
> > +     plat->msi_mac_vec =3D STMMAC_MSI_VEC_MAX;
> > +     plat->msi_wol_vec =3D STMMAC_MSI_VEC_MAX;
> > +     plat->msi_lpi_vec =3D STMMAC_MSI_VEC_MAX;
> > +     plat->msi_sfty_ce_vec =3D STMMAC_MSI_VEC_MAX;
> > +     plat->msi_sfty_ue_vec =3D STMMAC_MSI_VEC_MAX;
> > +     plat->msi_rx_base_vec =3D STMMAC_MSI_VEC_MAX;
> > +     plat->msi_tx_base_vec =3D STMMAC_MSI_VEC_MAX;
>
> Please don't use these fields and the STMMAC_MSI_VEC_MAX macro. Either
> have the BRCM_XGMAC_MSI* macros utilized directly or define the
> device-specific data in the glue driver (in brcm_priv_data if you
> wish). Really the MSI vectors aren't related to any DW *MAC IP-core
> these are the pure vendor platform-specific settings.
>
> The fields originally have been introduced by the Intel developers,
> who AFAICS just found it easier to extend the generic platform-data
> structure instead of introducing the new Intel MAC-specific data.
>
> I am going to drop these fields in a future cleanup patchset so to
> reduce the plat_stmmacenet_data structure complexity.
>
Thanks for the explanation. Will follow your guidelines in next patch.
> -Serge(y)
>
> > [...]

