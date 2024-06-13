Return-Path: <netdev+bounces-103400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FDB907DE7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DE4284767
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D957313541B;
	Thu, 13 Jun 2024 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZtNpe2m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146C94F8A0
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313264; cv=none; b=mKqZHkz/JT/9lEzQ+uqdfc8AvdCr9s48rJqXGZbQZPazdGx50i88EyLD3nbkaBY3vkigkV8LrOKKKW1d54CAH1m3IUD5l/x9Kp/Rg0VWnIfxX9obj4FhKxAxqCwGPugcdhTw9UV1j5fAQhwIUYUQD270hgyJiL/NriGAreYYOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313264; c=relaxed/simple;
	bh=2UYFKv4qeON34y75zVHh0Rx3aGPET2pmNDszE/s8Zj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHtq3bZUSwiapfkmGk79hoMZtJ7IQT9qNNYymGFb8EA9jQP64stC5yVPLgdNpxG0g9eH371CCVnYUZC1bCLE1g2efm7oB/IVazeCDxL19b6P11SUCXD8yQnQ69HDVTFIr7JcA452Zx7X7pSwnXkzKacos+GieVhwx30xa/ADmEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZtNpe2m; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5295eb47b48so1867892e87.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718313261; x=1718918061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftEGjGiodNUlNFLJ4s9QwQPCpcz2rKKpzG6CDOWGl3g=;
        b=iZtNpe2mYOz7PK6Mz2gxZrguCWPIU7ij3fDANXERWTqjeVAS0aXSPmFnC5bdpAGdLq
         hYQzZ3MH1UwL0NuRgiesod0auKacFWrMgTS4CU/ShkkgwRiBTtZYCJXQcPJlRiG3xQHf
         lkanl/TLN68VCKTx9dGIhna8GEIYU1KVhkGcXaaC4ADY5JbQxRnbg/gEYOVrNVczJsXA
         kBXi9omvTOBEsneK8V9oF1yue1e1s+afUfOEkF5o++/tsZxad73/GWCSuILMGqTtIRzs
         OO4QT2q1Xt+t2hz32I/eO8XJYN4XrLXAFCMNrciMgeegIZTXsvWyTYVoaevkZ5iB3hMx
         0YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718313261; x=1718918061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftEGjGiodNUlNFLJ4s9QwQPCpcz2rKKpzG6CDOWGl3g=;
        b=jWJ/lehvNogZplhuuOR9IQXczdBFdVIpkV2bVPY2SNVplksi7qlM48Bx/n7+O/WSx8
         8eFiX7tAM0co9kySO91pCW0HmMHr7jVYrqMFa5CYnOJNruVJnBu2uDaTNk1v1vk/gfio
         2oog7alo4S6kn3kNDfUcc1hrp/SEmzxC7T16/l+W7U4G5I0dxCbp/DozwkDFe4V8xa+a
         RDswvK+9mof2XpjlaPvvZ9VRplohGMdIT6MwandeS7uHY+apRYQrxAaCW1mIUyCDq0qG
         ffhLgINMPE1Hz61oz62+GDiJnTj8pWqO5meIYGmmZbmO7Z8/6oKItbUL5qybw+CvCrOX
         E2/g==
X-Forwarded-Encrypted: i=1; AJvYcCV/EGdZmN/VIhV9GGGE/agKuzCSHPERm0NchZrCKHQPklPW9Yv/s9DdJudhfaMDBZei1NLM3g5ErwdPzVU0ulpd+++8A94h
X-Gm-Message-State: AOJu0YxqtK+BA1VgjV7z50v/AUWG/09oxrs4Na4mkCMHNP0m5Cqs0FZK
	cL86JrkDKl2swvpJqN0u2ZTgef0HUgX1moGcjSyN+FG/shvhnvVX
X-Google-Smtp-Source: AGHT+IEbCbfAirRfes3utvk8rWHRVwbD5jpakBi8HtcODlseSZ85GzCYwowhe0K+tBCGyjoZUtXdwQ==
X-Received: by 2002:a19:911e:0:b0:52c:8215:574 with SMTP id 2adb3069b0e04-52ca6e6dc1amr473331e87.38.1718313260821;
        Thu, 13 Jun 2024 14:14:20 -0700 (PDT)
Received: from mobilestation ([176.213.10.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2826269sm340392e87.61.2024.06.13.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:14:20 -0700 (PDT)
Date: Fri, 14 Jun 2024 00:14:18 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Halaney <ahalaney@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC net-next v2 3/8] net: stmmac: dwmac1000: convert
 sgmii/rgmii "pcs" to phylink
Message-ID: <doeizqmec22tqez5zwhysppmm2vg2rhzp2siy5ogdncitbtx5b@mycxnahybvlp>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>
 <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>
 <ZmbFK2SYyHcqzSeK@shell.armlinux.org.uk>
 <dz34gg4atjyha5dc7tfgbnmsfku63r7faicyzo3odkllq3bqin@hho3kj5wmaat>
 <ZmobWwS5UapbhdmT@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmobWwS5UapbhdmT@shell.armlinux.org.uk>

On Wed, Jun 12, 2024 at 11:04:11PM +0100, Russell King (Oracle) wrote:
> On Tue, Jun 11, 2024 at 03:25:14PM +0300, Serge Semin wrote:
> > Hi Russell, Andrew
> >
> > Should we have a DW IP-core-specific getter like
> > stmmac_ops::pcs_get_config_reg() which would return the
> > tx_config_reg[15:0] field then we could have cleared the IRQ by just
> > calling it, we could have had the fields generically
> > parsed in the dwmac_pcs_isr() handler and in the
> > phylink_pcs_ops::pcs_get_state().
> 

> pcs_get_state() is not supposed to get some cached state,

It won't.

> but is
> supposed to return the real state at the time that it is called.

The idea is to implement the tx_config_reg[15:0] getter for DW GMAC
and DW QoS Eth. It will return the current link status retrieved from
the GMAC_RGSMIIIS and GMAC_PHYIF_CONTROL_STATUS registers. Like this:

GMAC:
u16 dwmac1000_pcs_get_config_reg(struct stmmac_priv *priv)
{
	return readl(priv->ioaddr + GMAC_RGSMIIIS);
}

DW QoS Eth:
u16 dwmac1000_pcs_get_config_reg(struct stmmac_priv *priv)
{
	return readl(priv->ioaddr + GMAC_PHYIF_CONTROL_STATUS) >> 16;
}

Then the dwmac_pcs_isr() can be updated as follows:

static inline void dwmac_pcs_isr(void __iomem *ioaddr, u32 reg,
                                 unsigned int intr_status,
                                 struct stmmac_extra_stats *x)
{
	...

	if (intr_status & PCS_RGSMIIIS_IRQ) {
		x->irq_rgmii_n++;
		/* The next will clear the PCS_RGSMIIIS_IRQ IRQ
		 * status. (It is done instead of dummy-reading the
		 * GMAC_RGSMIIIS/GMAC_PHYIF_CONTROL_STATUS registers
		 * in the DW GMAC/QoS Eth IRQ handlers.)
		 */
		(void)stmmac_pcs_get_config_reg(priv);
	}
}

Similarly the dwmac_pcs_get_state() method can now use the
stmmac_pcs_get_config_reg() function to retrieve the link state and
parse the data in a generic manner. Thus everything what is currently
done in dwmac1000_mii_pcs_get_state() and dwmac4_mii_pcs_get_state()
could be moved to dwmac_pcs_get_state(). By providing a single
STMMAC-driver callback stmmac_ops::pcs_get_config_reg(), we'll be able
to define the phylink_pcs_ops::{pcs_validate,pcs_config,pcs_get_state}
methods in the stmmac_pcs.c file.

> 
> There's a good reason for this - dealing with latched-low link failed
> indications, it's necessary that pcs_get_state() reports that the link
> failed if _sometime_ between the last time it was called and the next
> time the link has failed.
> 
> So, I'm afraid your idea of simplifying it doesn't sound to me like a
> good idea.

No caching or latched link state indications. Both the GMAC_RGSMIIIS
and GMAC_PHYIF_CONTROL_STATUS registers contain the actual link state
retrieved the PHY. stmmac_pcs_get_config_reg() will just return the
current link state.

Perhaps my suggestion might haven't been well described. Providing the
patches with the respective changes shall better describe what was
meant. So in a few days I'll submit an incremental patch(es) with the
proposed modifications for your series.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

