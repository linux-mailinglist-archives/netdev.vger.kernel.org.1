Return-Path: <netdev+bounces-95946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0F8C3E4D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7B51C212EE
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490F81487FF;
	Mon, 13 May 2024 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il+ah5RM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A6219E7
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593529; cv=none; b=A1ZVqB3V94KUIGsa8R5zlqGq3BHfkkixt+cbvio6OrN0w1MfA3eAEi2yD+Q9dN98xBI3CibW24GoEIMk8MEpUf/CqPQFMRfm8eELPqhQkHWXIGcbSlOdDPNXgdNDVz/MRVJnXusOOOf67FHXm4Ib44DlPdqlai31hmYfsqUZBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593529; c=relaxed/simple;
	bh=qErnHbWEeNW2plEnZCN2+MPLF0mYbU5L11pLxsmyYhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVg7Aka9dQLvADRlIM6Fji9BgbwkMRiNgFaWe4+Bo4M8xbarbOlCSbDPo8rnlx3XnaT3OsYXiWw30b72oyHIKzYpMqWywV10cNcS9UdHGJrtp9LOyYMEJarVNDkbMycFYSt8oCh6nhFX2RpMd3TPIWGshNZiy9UqiUXvW5YIeAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il+ah5RM; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f57713684so5139176e87.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 02:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715593524; x=1716198324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tlhMibZe2eECT9S1CCdpDDi8RzpV1CYLN9A0Z3Z/7Ec=;
        b=il+ah5RM+VOLNuArnM5qXqL027JoULB1hoq/OC8+Af6WXuDvmkV/RE/aaVyjJlJcow
         /gsUvc7L2/1YROS7nr6GxoIDKBaUxPyv2B6JLb4fjgZxeEWU+228EqEb39VYLZI0hSrg
         lqTIU7zLEtVgbFIow3WWOrAqvHVCumUzOspafDMAIenKVW1X5FFfz773yYrhDAQvaO37
         +tqP0xpnXEaIReakOfCbr6+3MRZAdtUA/XZcfORcAebcosaEe45d7L6pG5lVI5ZwtqpS
         DZS8aOPA4r7YyTbxt3X+bJ8t2DaMT/ou3Vgf7qgSb41sopUjKKU93DHJNrXb+8C9LE/o
         6CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715593524; x=1716198324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlhMibZe2eECT9S1CCdpDDi8RzpV1CYLN9A0Z3Z/7Ec=;
        b=xG2zhbtL/P2prvu8BwNQDnFN/uqwb+Z36IzlIFzDG1D5pMjDsdxj0ATxAx8gGNPPLU
         hyYLmNlYHxichISYurMj8TfI6WAWhUU1IzmeC9JJTqF5iGzYRfs6SV9r8RMdprHTqg/X
         uvBVzww52phpFxiKZMiqClnUPneoz2eqQrxuzLBvoxZTeMr2zHGhIHgzhGyIGnfKhqo5
         LAFK6ZN3JWC0FTzl6TxHzrWpnRszdj2TfaFIjMF6+HcE7OAErwqSzXTwgPTlXi+ysTrp
         YJdGClef/2RO09UqZ7VtU6NMN/vaPJ4xodZDqROf4w9YEa4B8V+qJjaxhZ4MmqKf00D5
         tgkg==
X-Forwarded-Encrypted: i=1; AJvYcCUny3U6Ckua0EV4fYIBLBVjjhZq9Z4hJ3LqlP1pMYpbayroHoYOHRY9qDhw1N7GvbIM6zDKzACIMSi3ZkwGHvOTrZPMMqNh
X-Gm-Message-State: AOJu0YwonN2wNYqFRLD4OZo1nFiRjeimJVaM2KVBpqlG4TkgAR5/EWmN
	zEXs4H5QF8KkloBpr/YSODFPkLpork2if3+TyXGsDwAC5Cm81516FKbKMw==
X-Google-Smtp-Source: AGHT+IEy2eHORzc4XNuAs83yXB2qC054I7ulGkyx/PcrYz5+j+0L7Kh2c47Ryi/7eTh8E4kKHEIOFg==
X-Received: by 2002:a19:8c58:0:b0:521:7543:4534 with SMTP id 2adb3069b0e04-5220ff74bb3mr5106417e87.62.1715593524053;
        Mon, 13 May 2024 02:45:24 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad584sm1704647e87.21.2024.05.13.02.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 02:45:23 -0700 (PDT)
Date: Mon, 13 May 2024 12:45:20 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 02/15] net: stmmac: Add multi-channel support
Message-ID: <o7l4klg25pjx3glv7wg65l24uxe4tjdhz3cwd7dxegt46ytxfr@o7ofnqdovgsp>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <5409facf916c0123e39a913c8342cc0ce8ed93db.1714046812.git.siyanteng@loongson.cn>
 <zbs5vkzyuoyte5mr2pprf7xxahhuxlinvxe24h4oc6jeshwii5@ivqr45z27ef4>
 <33ee7998-df36-492c-9507-a08c3a6dad9b@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33ee7998-df36-492c-9507-a08c3a6dad9b@loongson.cn>

On Fri, May 10, 2024 at 06:13:40PM +0800, Yanteng Si wrote:
> Hi Serge
> 
> 在 2024/5/3 06:02, Serge Semin 写道:
> > On Thu, Apr 25, 2024 at 09:01:55PM +0800, Yanteng Si wrote:
> > > DW GMAC v3.x multi-channels feature is implemented as multiple
> > > sets of the same CSRs. Here is only preliminary support, it will
> > > be useful for the driver further evolution and for the users
> > > having multi-channel DWGMAC v3.x devices.
> > Why do you call it "preliminary"? AFAICS it's a fully functional
> > support with no restrictions. Am I wrong?
> > 
> > I would reformulate the commit message as:
> > 
> > "DW GMAC v3.73 can be equipped with the Audio Video (AV) feature which
> > enables transmission of time-sensitive traffic over bridged local area
> > networks (DWC Ethernet QoS Product). In that case there can be up to two
> > additional DMA-channels available with no Tx COE support (unless there is
> > vendor-specific IP-core alterations). Each channel is implemented as a
> > separate Control and Status register (CSR) for managing the transmit and
> > receive functions, descriptor handling, and interrupt handling.
> > 
> > Add the multi-channels DW GMAC controllers support just by making sure the
> > already implemented DMA-configs are performed on the per-channel basis.
> > 
> > Note the only currently known instance of the multi-channel DW GMAC
> > IP-core is the LS2K2000 GNET controller, which has been released with the
> > vendor-specific feature extension of having eight DMA-channels. The device
> > support will be added in one of the following up commits."
> OK.
> > 
> > 
> > > @@ -153,7 +155,7 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
> > >   					    void __iomem *ioaddr, int mode,
> > >   					    u32 channel, int fifosz, u8 qmode)
> > >   {
> > > -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
> > > +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
> > >   	if (mode == SF_DMA_MODE) {
> > >   		pr_debug("GMAC: enable RX store and forward mode\n");
> > > @@ -175,14 +177,14 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
> > >   	/* Configure flow control based on rx fifo size */
> > >   	csr6 = dwmac1000_configure_fc(csr6, fifosz);
> > > -	writel(csr6, ioaddr + DMA_CONTROL);
> > > +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
> > >   }
> > >   static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
> > >   					    void __iomem *ioaddr, int mode,
> > >   					    u32 channel, int fifosz, u8 qmode)
> > >   {
> > > -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
> > > +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
> > >   	if (mode == SF_DMA_MODE) {
> > >   		pr_debug("GMAC: enable TX store and forward mode\n");
> > > @@ -209,7 +211,7 @@ static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
> > >   			csr6 |= DMA_CONTROL_TTC_256;
> > >   	}
> > > -	writel(csr6, ioaddr + DMA_CONTROL);
> > > +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
> > >   }
> > Just figured out that besides of the channel-related changes you also need
> > to have the stmmac_dma_operation_mode() method fixed. So one wouldn't
> > redistribute the detected Tx/Rx FIFO between the channels. Each DW GMAC
> > channel has separate FIFO of the same size. The databook explicitly says
> > about that:
> > 
> > "The Tx FIFO size of all selected Transmit channels is always same.
> > Similarly, the Rx FIFO size of all selected Receive channels is same.
> > These channels cannot be of different sizes."
> > 

> Should I do this, right?
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 33d04243b4d8..9d4148daee68 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2371,8 +2371,13 @@ static void stmmac_dma_operation_mode(struct
> stmmac_priv *priv)
>                 txfifosz = priv->dma_cap.tx_fifo_size;
> 
>         /* Adjust for real per queue fifo size */
> -       rxfifosz /= rx_channels_count;
> -       txfifosz /= tx_channels_count;
> +       if ((priv->synopsys_id != DWMAC_CORE_3_40) ||
> +           (priv->synopsys_id != DWMAC_CORE_3_50) ||
> +           (priv->synopsys_id != DWMAC_CORE_3_70)) {
> +               rxfifosz /= rx_channels_count;
> +               txfifosz /= tx_channels_count;
> +       }
> +
> 
>         if (priv->plat->force_thresh_dma_mode) {
>                 txmode = tc;

Seeing the shared FIFO memory is specific for the DW QoS Eth and DW
xGMAC IP-cores let's use the has_gmac4 and has_xgmac flags instead:

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2371,8 +2371,13 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 	if (txfifosz == 0)
 		txfifosz = priv->dma_cap.tx_fifo_size;
 
-	/* Adjust for real per queue fifo size */
-	rxfifosz /= rx_channels_count;
-	txfifosz /= tx_channels_count;
+	/* Split up the shared Tx/Rx FIFO memory on DW QoS Eth and DW XGMAC */
+	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
+		rxfifosz /= rx_channels_count;
+		txfifosz /= tx_channels_count;
+	}
 
 	if (priv->plat->force_thresh_dma_mode) {
 		txmode = tc;

-Serge(y)
> 
> 
> Thanks,
> 
> Yanteng
> 

