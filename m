Return-Path: <netdev+bounces-127580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBE3975CA7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5881F23681
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80EC155A2F;
	Wed, 11 Sep 2024 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PHZTcNMJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173D0143C5D
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726091468; cv=none; b=oVO9yd/cNHNek4HuDF+UFIFd308UFdfPY653a7VibPgdCEh/CCH0eKIO6E0o6bvn/YIw2QfFRAnvURsgm1rbeqmnLWc4Nygocc6ynsCbYCfr7Ge9eZOawsQ/g8RCfCzpv14POO+vtouljVOqD6Twu2+4NR9UjouOkorAmqA3mZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726091468; c=relaxed/simple;
	bh=XEPyG20mV4IFb+tVvh7hoBtM2/Pck7y+SXesyK7wyWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRajCphoBKkpBxytSu10Yk7MasWekR1xJLSAXZkAr5IoewpsXNMGP6Out2t3vaaMZ2/ZXsybfGYL/6vVM/dgKeEZQZ7gmARgckZ3VE+4mi51eM6t/9RulWH/QOK0BXrhh83qsa07AsUDM9QwQzVr9DXjXdM82BBgxl0DO4TIE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PHZTcNMJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-719232ade93so230997b3a.2
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726091466; x=1726696266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atvq8gkU6NvVoNfip7YpdVtjmePPs3eS+0+JBGapmdM=;
        b=PHZTcNMJdvAEUqPqp06VAlu19uwSfVpVP5LduE5tWU59sb0saEhEs+534sH/xA7fdm
         U8MOxIv0nYRavQcSNrvdwXde4+GQ+W1FC7Dl/Zabh6U0RDwoisyMOakOy33bGNP/kXzY
         R+jL9Alf/aHGgND+PIvPqc3/tMLNUMRGzpu5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726091466; x=1726696266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atvq8gkU6NvVoNfip7YpdVtjmePPs3eS+0+JBGapmdM=;
        b=fagZuP9AGBTZc4e5vBUWghRfW7MPfxNMaLWo9V+Ty6xPDrNKz7OV0XSESuKyZKlA9o
         KUf+b+JLBWdNgq9YbYoJoD2ylTwoPOaSxMDIqfLpNCK2u/WZgjOGWbx0iUoUGUb/DgYo
         CC+a+2M7Ecy75SOKZUw7wmOjGvfa9H4gb5NcMkChcM33/AeR/nq7w395EYtwsSjxbN5y
         7kYTbA31nxqVqIHZ/SlioAiPHlSC39mzRvIWy7wfK8LDgmNeLk0h2snD0MwFjoRwc7xx
         4TG/hnfoPKAlcEOe8b2V0K2A4bXvFpJF9yiYddszEnI9xOdSYNsYlc6FQRUwSd9JQUE6
         yaXg==
X-Gm-Message-State: AOJu0YzLNPNVMWOpjeeJzBM9Z1TS4iTsN9Xp9AXBdBQJM3VoCvFUP7r+
	6NWtltS9NiRWeT9no01PdgA4sg5hRi6veEUEh7eloXNUg1U7YVvjG6rfyWk8mCJqM2v2RO/MjiJ
	x3on9aZNfKRduEuTTvhvuzIty0EOePaauGSv0
X-Google-Smtp-Source: AGHT+IE6AjM9iNIUGGgkdelqISzU9y7VqVsFfHhd7hH+mTrRkBRlRHZFngZR/fbxEJoN18HlE/eBuMsCOSEppeavnRs=
X-Received: by 2002:a05:6a00:1990:b0:717:8d52:643 with SMTP id
 d2e1a72fcca58-7192607f5b4mr1219152b3a.11.1726091466137; Wed, 11 Sep 2024
 14:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
 <20240904054815.1341712-2-jitendra.vegiraju@broadcom.com> <7foqi3vdgc3kvyw5rrnqsqsakgfgcrhw5sihnqwza4okdnh5dd@pdsdjn32ya6u>
In-Reply-To: <7foqi3vdgc3kvyw5rrnqsqsakgfgcrhw5sihnqwza4okdnh5dd@pdsdjn32ya6u>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Wed, 11 Sep 2024 14:50:54 -0700
Message-ID: <CAMdnO-+nPHsNmxYkB0v54LfcHm-Df92dyGiZM3Rwe_sDMmPyVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/5] net: stmmac: Add HDMA mapping for
 dw25gmac support
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

Hi Serge,
Thank you for taking the time to review the patches.

On Tue, Sep 10, 2024 at 11:37=E2=80=AFAM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> Hi Jitendra
>
> On Tue, Sep 03, 2024 at 10:48:11PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > Add hdma configuration support in include/linux/stmmac.h file.
> > The hdma configuration includes mapping of virtual DMAs to physical DMA=
s.
> > Define a new data structure stmmac_hdma_cfg to provide the mapping.
> >
> > Introduce new plat_stmmacenet_data::snps_id,snps_dev_id to allow glue
> > drivers to specify synopsys ID and device id respectively.
> > These values take precedence over reading from HW register. This facili=
ty
> > provides a mechanism to use setup function from stmmac core module and =
yet
> > override MAC.VERSION CSR if the glue driver chooses to do so.
> >
> > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > ---
> >  include/linux/stmmac.h | 48 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > index 338991c08f00..eb8136680a7b 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -89,6 +89,51 @@ struct stmmac_mdio_bus_data {
> >       bool needs_reset;
> >  };
> >
> > +/* DW25GMAC Hyper-DMA Overview
> > + * Hyper-DMA allows support for large number of Virtual DMA(VDMA)
> > + * channels using a smaller set of physical DMA channels(PDMA).
> > + * This is supported by the mapping of VDMAs to Traffic Class(TC)
> > + * and PDMA to TC in each traffic direction as shown below.
> > + *
> > + *        VDMAs            Traffic Class      PDMA
> > + *       +--------+          +------+         +-----------+
> > + *       |VDMA0   |--------->| TC0  |-------->|PDMA0/TXQ0 |
> > + *TX     +--------+   |----->+------+         +-----------+
> > + *Host=3D> +--------+   |      +------+         +-----------+ =3D> MAC
> > + *SW     |VDMA1   |---+      | TC1  |    +--->|PDMA1/TXQ1 |
> > + *       +--------+          +------+    |    +-----------+
> > + *       +--------+          +------+----+    +-----------+
> > + *       |VDMA2   |--------->| TC2  |-------->|PDMA2/TXQ1 |
> > + *       +--------+          +------+         +-----------+
> > + *            .                 .                 .
> > + *       +--------+          +------+         +-----------+
> > + *       |VDMAn-1 |--------->| TCx-1|-------->|PDMAm/TXQm |
> > + *       +--------+          +------+         +-----------+
> > + *
> > + *       +------+          +------+         +------+
> > + *       |PDMA0 |--------->| TC0  |-------->|VDMA0 |
> > + *       +------+   |----->+------+         +------+
> > + *MAC =3D> +------+   |      +------+         +------+
> > + *RXQs   |PDMA1 |---+      | TC1  |    +--->|VDMA1 |  =3D> Host
> > + *       +------+          +------+    |    +------+
> > + *            .                 .                 .
> > + */
> > +
>
> > +/* Hyper-DMA mapping configuration
> > + * Traffic Class associated with each VDMA/PDMA mapping
> > + * is stored in corresponding array entry.
> > + */
> > +struct stmmac_hdma_cfg {
> > +     u32 tx_vdmas;   /* TX VDMA count */
> > +     u32 rx_vdmas;   /* RX VDMA count */
> > +     u32 tx_pdmas;   /* TX PDMA count */
> > +     u32 rx_pdmas;   /* RX PDMA count */
> > +     u8 *tvdma_tc;   /* Tx VDMA to TC mapping array */
> > +     u8 *rvdma_tc;   /* Rx VDMA to TC mapping array */
> > +     u8 *tpdma_tc;   /* Tx PDMA to TC mapping array */
> > +     u8 *rpdma_tc;   /* Rx PDMA to TC mapping array */
> > +};
> > +
> >  struct stmmac_dma_cfg {
> >       int pbl;
> >       int txpbl;
> > @@ -101,6 +146,7 @@ struct stmmac_dma_cfg {
> >       bool multi_msi_en;
> >       bool dche;
> >       bool atds;
> > +     struct stmmac_hdma_cfg *hdma_cfg;
>
> Based on what you are implementing the _static_ VDMA-TC-PDMA channels
> mapping I really don't see a value of adding all of these data here.
> The whole implementation gets to be needlessly overcomplicated.
> Moreover AFAICS there are some channels left misconfigured in the
> Patch 2 code.  Please see my comments there for more details.
>
I agree, with _static_ VDMA-TC-PDMA channels, maintaining the mapping data
appears complicated.
The real need comes when adding virtualization (SRIOV) capabilities.
I am analyzing your comments in patch2 and will respond after re-evaluation=
.

> >  };
> >
> >  #define AXI_BLEN     7
> > @@ -303,5 +349,7 @@ struct plat_stmmacenet_data {
> >       int msi_tx_base_vec;
> >       const struct dwmac4_addrs *dwmac4_addrs;
> >       unsigned int flags;
>
> > +     u32 snps_id;
> > +     u32 snps_dev_id;
>
> Please move these fields to the head of the structure as the kind of
> crucial ones, and convert snps_dev_id to just dev_id.
>
> snps_id field name was selected based on the VERSION.SNPSVER field
> name (see SNPS prefix). Following that logic the VERSION.DEVID field
> should be converted to the dev_id name.
>
Thanks for explaining the thinking behind the field naming. That makes sens=
e.
I was thinking of it as a prefix for synopsys fields.
Will make the change.
> -Serge(y)
>
> >  };
> >  #endif
> > --
> > 2.34.1
> >

