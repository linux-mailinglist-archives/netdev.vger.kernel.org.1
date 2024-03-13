Return-Path: <netdev+bounces-79644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3894E87A5B4
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 11:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4353283393
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF50374F6;
	Wed, 13 Mar 2024 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="b3rDx3XP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE83A292
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325301; cv=none; b=giKYYlAY5x62zqqjZcHV35mBxViLnED6Un1Z4BVLqcZrfkIanvRsHBFMgF5VjuWxph6QWm14Nrh3n7eQ9S71FzFU9y1te+tIgQhWzHftWZv/jgF/vLMuDMKiLs73gPw7irnZ36l9qSfiM+PtXrHlrSZfle2d1kSfl8Ze+p1V8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325301; c=relaxed/simple;
	bh=eP9p/vptdqozkkWhgcG8Ctae/XKwhfk/JaLmnnfq/DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eePTlBgWvPQdgpTE0yFe40sB9k/jHS5TnbifqZESrtDsmhJw9TMLJbduipl5dIOanT7f74WnKQ/pQlHZkf5On1rxJKZA/cWbHsB2kzUHQVf/aGPc9DDOnSi0sDu9GPeJWiE7fkNj7I2K/9nnnV4NSDCpEok1+n1svMI9QN37V14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=b3rDx3XP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8yCfyo5sWSccuJnR2HGeSwUXS0yTdHPuJjHJ/SwRl7s=; b=b3rDx3XPQgdyR/0P4Kgv0R+yZT
	cXD1gUIoqwwZlQd+5IrFUlhKoe35ZswKOsi6oUw8qkelExA8JL21w+845wkB30EmC3taxEmWWTZKg
	AA5a2gAGHvGHgQ2zNbzi9l4o2LBRBUbq5AfdsTJsXN+uDWAZ/zJfUk1HADckKgDVkqKNQzpyT63lv
	5sIESc0WDh+kDqMy1etPATnsKxDmWyeITk0l/alH1aAr78hJEz3/70TSgmz+1FKxID2Xw1QgBgWrW
	12tnijpmqW+N1ZR4IToy9En6Ps5UOlrMVRvtXRf/UAr3X2hgdJdICjqRSNHRDI0wqB+dfwesvgA0G
	TzUfoxJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37366)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rkLje-0007Xz-2r;
	Wed, 13 Mar 2024 10:21:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rkLjc-0004Qg-Ef; Wed, 13 Mar 2024 10:21:20 +0000
Date: Wed, 13 Mar 2024 10:21:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Serge Semin <fancer.lancer@gmail.com>, andrew@lunn.ch,
	hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	Jose.Abreu@synopsys.com, chenhuacai@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
Message-ID: <ZfF+IAWbe1rwx3Xs@shell.armlinux.org.uk>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
 <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
 <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 13, 2024 at 05:24:52PM +0800, Yanteng Si wrote:
> 在 2024/2/6 06:06, Serge Semin 写道:
> > On Tue, Feb 06, 2024 at 12:58:17AM +0300, Serge Semin wrote:
> > > On Tue, Jan 30, 2024 at 04:49:14PM +0800, Yanteng Si wrote:
> > > > Current GNET does not support half duplex mode.
> > > > 
> > > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > > ---
> > > >   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 11 ++++++++++-
> > > >   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |  3 ++-
> > > >   include/linux/stmmac.h                               |  1 +
> > > >   3 files changed, 13 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > index 264c4c198d5a..1753a3c46b77 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > @@ -432,8 +432,17 @@ static int loongson_gnet_config(struct pci_dev *pdev,
> > > >   				struct stmmac_resources *res,
> > > >   				struct device_node *np)
> > > >   {
> > > > -	if (pdev->revision == 0x00 || pdev->revision == 0x01)
> > > > +	switch (pdev->revision) {
> > > > +	case 0x00:
> > > > +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000 |
> > > > +			       STMMAC_FLAG_DISABLE_HALF_DUPLEX;
> > > > +		break;
> > > > +	case 0x01:
> > > >   		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
> > > > +		break;
> > > > +	default:
> > > > +		break;
> > > > +	}
> > > Move this change into the patch
> > > [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> > > 
> > > >   	return 0;
> > > >   }
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index 5617b40abbe4..3aa862269eb0 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -1201,7 +1201,8 @@ static int stmmac_init_phy(struct net_device *dev)
> > > >   static void stmmac_set_half_duplex(struct stmmac_priv *priv)
> > > >   {
> > > >   	/* Half-Duplex can only work with single tx queue */
> > > > -	if (priv->plat->tx_queues_to_use > 1)
> > > > +	if (priv->plat->tx_queues_to_use > 1 ||
> > > > +	    (STMMAC_FLAG_DISABLE_HALF_DUPLEX & priv->plat->flags))
> > > >   		priv->phylink_config.mac_capabilities &=
> > > >   			~(MAC_10HD | MAC_100HD | MAC_1000HD);
> > > >   	else
> > > > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > > > index 2810361e4048..197f6f914104 100644
> > > > --- a/include/linux/stmmac.h
> > > > +++ b/include/linux/stmmac.h
> > > > @@ -222,6 +222,7 @@ struct dwmac4_addrs {
> > > >   #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
> > > >   #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
> > > >   #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
> > > > +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
> > > Place the patch with this change before
> > > [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> > > as a pre-requisite/preparation patch. Don't forget a thorough
> > > description of what is wrong with the GNET Half-Duplex mode.
> > BTW what about re-defining the stmmac_ops.phylink_get_caps() callback
> > instead of adding fixup flags in this patch and in the next one?
> 
> ok.
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index ac1b48ff7199..b57e1325ce62 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -238,6 +234,13 @@ static int loongson_gnet_get_hw_feature(void __iomem
> *ioaddr,
>      return 0;
>  }
> 
> +static void loongson_phylink_get_caps(struct stmmac_priv *priv)
> +{
> +    priv->phylink_config.mac_capabilities = (MAC_10FD |
> +        MAC_100FD | MAC_1000FD) & ~(MAC_10HD | MAC_100HD | MAC_1000HD);

Why is this so complicated? It would be silly if the _full duplex_
definitions also defined the _half duplex_ bits. This should be just:

	priv->phylink_config.mac_capabilities = MAC_10FD | MAC_100FD |
						MAC_1000FD;

if that is all you support. Do you not support any pause modes (they
would need to be included as well here.)

As to this approach, I don't think it's a good model to override the
stmmac MAC operations. Instead, I would suggest that a better approach
would be for the platform to provide its capabilities to the stmmac
core code (maybe a new member in stmmac_priv) which, when set, is used
to reduce the capabilities provided to phylink via
priv->phylink_config.mac_capabilities.

Why? The driver has several components that are involved in the
overall capabilities, and the capabilities of the system is the
logical subset of all these capabilities. One component should not
be setting capabilities that a different component doesn't support.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

