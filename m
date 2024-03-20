Return-Path: <netdev+bounces-80786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDFB8810E1
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED11A1F212B8
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F20D3D0A4;
	Wed, 20 Mar 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clFkMPfG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9DD3BB4B
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933870; cv=none; b=ITbzu+OdQ7izx9TIHJF6bR9PVIhia2y43o9R3PijvrO6OmakHjBOo3DHM/+ZyRRQCdbT1bNBLPJo39/E34B3akFe2RJSqkzcJhQnrlmdrK+bFTNI8jjp1n43ALqFlh2QJuUyyjkIBt4gw91QpVSaRWIjSnfmN22xUwPP4dobnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933870; c=relaxed/simple;
	bh=XwXCT+qnYYBfAtfEIcJiQh3VH/yQNQLrCZ3J9wntS0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS05HPvjF9/qU9PCgleBweMxW1xuNwwJFJysX9nbl2LZ0i3N7cYcx/HXWr+J4U74qJYWdc9wB+p3Filh9qVpUU1DOqd1uucfuSVLGzBmopBsgpjmdAP0l4webRUW7akMMqOMeuuraTb/aqxSu5O8eAhQw1hzhXBmUGWV2yaWVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clFkMPfG; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so72918081fa.0
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 04:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710933867; x=1711538667; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LoeoZQ1lVSwW0Z0+D/UcuK1fsgJMFRtVgMQHvGUMVXw=;
        b=clFkMPfGC8wHh9bGzYtW0+8ChujdzChL7qXuv82pn2x5Ef8JDlppg04yGqlu0YHgag
         ufrzhvidYFb2sBeAPj5e594D66nfzYYRxprou6GePZPbbKvJNmj2acgPH9GEMe5DL7DB
         FenwJjizJ+ekVEZI7uU2JxzmnEUq1/EekqgSaPcbENGnI6KxLCuDOGS34j71Vsd1nncy
         cCbUuuPtBlRf0b3J9I+hADibmAE+bIBDfkP01rPGfmTuKNgo5CCbEWjZ1LEyovK7dNEQ
         RM39Hwa0GXH065WpyFX978dMXStUqajpfzTqBAvxD4y+CPvDFg4cFTHjtg9vztNJ3Pem
         mIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710933867; x=1711538667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoeoZQ1lVSwW0Z0+D/UcuK1fsgJMFRtVgMQHvGUMVXw=;
        b=kpCu+U49AR59RiSuNCOdmQ17r+vgYj4ddaj27bpJDCzXK3trH/FEQMB+c2STJ0nkWE
         kjx6AyGbvWVV3GZToELvTNZGlazr42qhRheay3d3/4dR1xR/9yWNJ5JTIlzvxens0Uqp
         kQFgyvZ/LLpyZcWSdJJcioZh5AAL8kUT+b/P7I36HWoGc5barDF7CxKs1qOfWD+Myx5r
         vs2VVwv9OUkbJ+tEewbzWx7ojARLju8hjI8cEnagUferXDzTCabqhTK2k+skvVCJQoPj
         F82fvjR0d03cmvqCK26KFWRqZUIfMAWHMbjBJr2D9labDKxtsRwpvEuawb/2LdzEgJ09
         h63g==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZfntuJAAXP2G/8GGRUo6ot1Qanqy3alB/aZavQkAXgD2eoPmpmYm4mhJSYMSAE6Hggyvi0iDDkqvSHaUAB3e35s38LB/
X-Gm-Message-State: AOJu0YzBhP1MBgboAbHLOhM8MVH0Y1KpAC9LvmpkSRRGl0NZ5DzkG5Rf
	pz07z6e539K74L7z3RzaXXF1RZSB2XTCsAVNr9p51ajLocmaFgis
X-Google-Smtp-Source: AGHT+IESiEJl4ZU+KHf9qgQdWs9367yy+GAQ1d45Hs8XJMQRRIUnRS8SCZEzg9DFv/kJWTy1p1o4UA==
X-Received: by 2002:a2e:a592:0:b0:2d4:5a3a:de7c with SMTP id m18-20020a2ea592000000b002d45a3ade7cmr13912029ljp.32.1710933866868;
        Wed, 20 Mar 2024 04:24:26 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m4-20020a2ea584000000b002d2e419d9besm2030387ljp.65.2024.03.20.04.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 04:24:26 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:24:23 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 11/11] net: stmmac: dwmac-loongson: Disable
 coe for some Loongson GNET
Message-ID: <zqzkanogzdaqvjjobnoidhl4tqeho5uqldsa2r46ttbxo3y4dt@tdouti2x652a>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <151e688e8977376c3c97548540f8e15d272685cb.1706601050.git.siyanteng@loongson.cn>
 <52aodgfoh35zxpube73w53jv7rno5k7vfwdy276zjqpcbewk5t@4f2igj76y5ri>
 <6ba83c5c-a993-4d79-86cf-789505a893ed@loongson.cn>
 <f373b652-e65c-4f7c-9605-9b387567c513@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f373b652-e65c-4f7c-9605-9b387567c513@loongson.cn>

Hi Yanteng

On Wed, Mar 13, 2024 at 06:19:47PM +0800, Yanteng Si wrote:
> 
> 在 2024/3/13 17:52, Yanteng Si 写道:
> > 
> > 在 2024/2/6 06:18, Serge Semin 写道:
> > > On Tue, Jan 30, 2024 at 04:49:16PM +0800, Yanteng Si wrote:
> > > > Some chips of Loongson GNET does not support coe, so disable them.
> > > s/coe/Tx COE
> > OK.
> > > 
> > > > Set dma_cap->tx_coe to 0 and overwrite get_hw_feature.
> > > > 
> > > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > > ---
> > > >   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 46
> > > > +++++++++++++++++++
> > > >   1 file changed, 46 insertions(+)
> > > > 
> > > > diff --git
> > > > a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > index b78a73ea748b..8018d7d5f31b 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > @@ -196,6 +196,51 @@ static int dwlgmac_dma_interrupt(struct
> > > > stmmac_priv *priv, void __iomem *ioaddr,
> > > >       return ret;
> > > >   }
> > > >   +static int dwlgmac_get_hw_feature(void __iomem *ioaddr,
> > > Please use GNET-specific prefix.
> > OK. loongson_gnet_get_hw_feature()
> > > 
> > > > +                  struct dma_features *dma_cap)
> > > > +{
> > > > +    u32 hw_cap = readl(ioaddr + DMA_HW_FEATURE);
> > > > +
> > > > +    if (!hw_cap) {
> > > > +        /* 0x00000000 is the value read on old hardware that does not
> > > > +         * implement this register
> > > > +         */
> > > > +        return -EOPNOTSUPP;
> > > > +    }
> > > This doesn't seems like possible. All your devices have the
> > > HW-features register. If so please drop.
> > OK, drop it.
> > > 
> > > > +
> > > > +    dma_cap->mbps_10_100 = (hw_cap & DMA_HW_FEAT_MIISEL);
> > > > +    dma_cap->mbps_1000 = (hw_cap & DMA_HW_FEAT_GMIISEL) >> 1;
> > > > +    dma_cap->half_duplex = (hw_cap & DMA_HW_FEAT_HDSEL) >> 2;
> > > > +    dma_cap->hash_filter = (hw_cap & DMA_HW_FEAT_HASHSEL) >> 4;
> > > > +    dma_cap->multi_addr = (hw_cap & DMA_HW_FEAT_ADDMAC) >> 5;
> > > > +    dma_cap->pcs = (hw_cap & DMA_HW_FEAT_PCSSEL) >> 6;
> > > > +    dma_cap->sma_mdio = (hw_cap & DMA_HW_FEAT_SMASEL) >> 8;
> > > > +    dma_cap->pmt_remote_wake_up = (hw_cap & DMA_HW_FEAT_RWKSEL) >> 9;
> > > > +    dma_cap->pmt_magic_frame = (hw_cap & DMA_HW_FEAT_MGKSEL) >> 10;
> > > > +    /* MMC */
> > > > +    dma_cap->rmon = (hw_cap & DMA_HW_FEAT_MMCSEL) >> 11;
> > > > +    /* IEEE 1588-2002 */
> > > > +    dma_cap->time_stamp =
> > > > +        (hw_cap & DMA_HW_FEAT_TSVER1SEL) >> 12;
> > > > +    /* IEEE 1588-2008 */
> > > > +    dma_cap->atime_stamp = (hw_cap & DMA_HW_FEAT_TSVER2SEL) >> 13;
> > > > +    /* 802.3az - Energy-Efficient Ethernet (EEE) */
> > > > +    dma_cap->eee = (hw_cap & DMA_HW_FEAT_EEESEL) >> 14;
> > > > +    dma_cap->av = (hw_cap & DMA_HW_FEAT_AVSEL) >> 15;
> > > > +    /* TX and RX csum */
> > > > +    dma_cap->tx_coe = 0;
> > > > +    dma_cap->rx_coe_type1 = (hw_cap & DMA_HW_FEAT_RXTYP1COE) >> 17;
> > > > +    dma_cap->rx_coe_type2 = (hw_cap & DMA_HW_FEAT_RXTYP2COE) >> 18;
> > > > +    dma_cap->rxfifo_over_2048 = (hw_cap &
> > > > DMA_HW_FEAT_RXFIFOSIZE) >> 19;
> > > > +    /* TX and RX number of channels */
> > > > +    dma_cap->number_rx_channel = (hw_cap & DMA_HW_FEAT_RXCHCNT) >> 20;
> > > > +    dma_cap->number_tx_channel = (hw_cap & DMA_HW_FEAT_TXCHCNT) >> 22;
> > > > +    /* Alternate (enhanced) DESC mode */
> > > > +    dma_cap->enh_desc = (hw_cap & DMA_HW_FEAT_ENHDESSEL) >> 24;
> > > I am not sure whether you need to parse the capability register at all
> > > seeing this is a GNET-specific method. For that device all the
> > > capabilities are already known and can be just initialized in this
> > > method.
> > -dma_cap->tx_coe = (hw_cap & DMA_HW_FEAT_TXCOESEL) >> 16;
> > 
> > +dma_cap->tx_coe = 0;
> > 
> > I'm a little confused. Actually, I only modified this line, which is
> > used to fix the checksum.
> > 
> > 2k2000  of Loongson GNET does not support coe.
> 
> Specifically, it is to ensure the normal operation of multiple channels, as
> other channels except for channel 0 cannot perform checksum.

Originally I thought that Tx-COE was fully broken, but seeing it works
for channel 0 changes the situation. While we kept discussing your
series a useful patch was merged into the driver:
https://lore.kernel.org/netdev/20230916063312.7011-3-rohan.g.thomas@intel.com/
The stmmac_txq_cfg::coe_unsupported flag can be used to disable Tx COE
for the particular channels. You can just set the coe_unsupported flag
for the channels greater than zero and the skb_checksum_help() helper
will be utilized for them to calculate the packets control sum. This
will be the most optimal solution since channel zero will still be
serviced by the Tx Checksum Offload Engine and you won't need the
stmmac_dma_ops::get_hw_feature() callback redefinition.

-Serge(y)

> 
> Thanks,
> 
> Yanteng
> 
> 
> > 
> > 
> > Thanks,
> > Yanteng
> > 
> > > 
> > > -Serge(y)
> > > 
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >   struct stmmac_pci_info {
> > > >       int (*setup)(struct pci_dev *pdev, struct
> > > > plat_stmmacenet_data *plat);
> > > >       int (*config)(struct pci_dev *pdev, struct
> > > > plat_stmmacenet_data *plat,
> > > > @@ -542,6 +587,7 @@ static int loongson_dwmac_probe(struct
> > > > pci_dev *pdev,
> > > >           ld->dwlgmac_dma_ops = dwmac1000_dma_ops;
> > > >           ld->dwlgmac_dma_ops.init_chan = dwlgmac_dma_init_channel;
> > > >           ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;
> > > > +        ld->dwlgmac_dma_ops.get_hw_feature = dwlgmac_get_hw_feature;
> > > >             plat->setup = loongson_setup;
> > > >           ret = loongson_dwmac_config_multi_msi(pdev, plat,
> > > > &res, np, 8);
> > > > -- 
> > > > 2.31.4
> > > > 
> 

