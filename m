Return-Path: <netdev+bounces-80753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E4D880F56
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26C41C20D58
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4812B3BB36;
	Wed, 20 Mar 2024 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0q4qtST"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59E3C060
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929412; cv=none; b=BwQacSgTuKoAHpCAfPbgq/lpg3vQ/zSt487IziJTZLMbbthX9iT6W6VO4FojNH2kwKmine5Pp4xbPoUfu3o1eZbmbCgf9IORsuq/qodcu9wJosynvNPaxwRuDlDxN3VQrsB41809zCBfq2jFBFl9Yf/0DKvZpbf0N2Ykg9fNBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929412; c=relaxed/simple;
	bh=Cxm19imkyicEHoBGhA1VF+3OlH/L/2B6Sylu2bNghwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIFelB4oUgxWB08i1wwbXd+t5PTDuTNiEBtZBiFmW16THDCTycRgAo6omLpftHJLrTQvsr8iTBsaWmQ6v9bQp+DGVjHcZPGPsKmAfFraP0M/bki5zPqv2mdcu1knSfMiUGBw+MUiDo9Nl1/KI6k646vdVWk6es4K6FSMxBYvQUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0q4qtST; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513e89d0816so4030028e87.0
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 03:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710929408; x=1711534208; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oaFQBAeySLc/4g1+NxFK/xDpRmO1vnuBvQEiNv0Zh50=;
        b=A0q4qtSTgFw8CU4+pe84knBrJmxP0W1w61zl8QZuTgZD92l1Cu23sN7htU3q6uP9VK
         OoO9VcSW21t1BLe6vUa3zrOUCTk3BPIdcW/TFyiFGG+OvOaAdDU5vnGYHB30LggqM4Ie
         viYLnOGFybYgFls2mtTvfk09UUAGwaC8e9uWGnjsiGBCCcP3RLE0redq28rzQLYkbt+S
         DA+dcOUoL0ZIywTg19yvmTN4IEd63FrLVajWOjwYsDUmCZfpq7rKFW+beM3Q8Tjj1Xwc
         yQkLLfk6cK0zaSCyT/DNluXhb1GMuIuwQgyXXD06iFefO8MA8Ohwy8zZZZWLxH+WUQOI
         UKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929408; x=1711534208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaFQBAeySLc/4g1+NxFK/xDpRmO1vnuBvQEiNv0Zh50=;
        b=BdHBxv5tuK7voMbM3jDLDa1H/I7c9QlzxVbFn12l7fDgez8N2mn9REO41zkDdAgKx/
         BQMb6cyn9xI++dx7T3liLAhi8xhCYHUeNKrQULLXGYUPtSVxMKgYbrwSWzNncL4AnBit
         8TyvaOk8FhpFOl7zb+sFjpa3bUwnhGnSwqtkBK1lXsGcNql3bEY33WHB23fbcOJDn8Ox
         +hfLkG/MY14zCQCnWkC8K6s/1yks8ieJiZMzX5qxl2rEkKPe0XwHkhZ2QOGmt4i9Z4uC
         4poAmVfVj2RyOzJlasLBcJjZka/PHPNhSmrpST7c/Jq3I03G7UAziXhMNyKSCDKWr+WJ
         QxCg==
X-Forwarded-Encrypted: i=1; AJvYcCWT6hUHXJNOWT9ST4H1Av5VZOoQ6k5YSNmPCLh17Tqn2ni2MewBWjnccbDm71aaEL+3itfdQwVA2dvigyBDioAYaHLhGMu/
X-Gm-Message-State: AOJu0YwJpglDQa7PnGXHlGArZWHvK3+GzrG4AFKGg8m4xcyDNRgtqD74
	qeV3vwX+WIJcs+Wf2ZemTYlzHS2YNINzJR/KX8NPA/uUlNqYgYCJTUZebNk3
X-Google-Smtp-Source: AGHT+IH54AqWCKuvyXoQ8mbzoshEjz/RVW7gJrCsgTUIkC/WZ+uoe5586EThMo0D2diHYHZTXtv9og==
X-Received: by 2002:ac2:43d5:0:b0:513:4105:6b34 with SMTP id u21-20020ac243d5000000b0051341056b34mr3465400lfl.64.1710929408028;
        Wed, 20 Mar 2024 03:10:08 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q13-20020ac246ed000000b0051355ec71absm2211614lfo.220.2024.03.20.03.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:10:07 -0700 (PDT)
Date: Wed, 20 Mar 2024 13:10:04 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
Message-ID: <em3r6w7ydvjxualqifjurtrrfpztpil564t5k5b4kxv4f6ddrd@4weteqhekyae>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
 <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
 <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
 <ZfF+IAWbe1rwx3Xs@shell.armlinux.org.uk>
 <cd8be3b1-fcfa-4836-9d28-ced735169615@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd8be3b1-fcfa-4836-9d28-ced735169615@loongson.cn>

On Thu, Mar 14, 2024 at 09:08:41PM +0800, Yanteng Si wrote:
> 
> 在 2024/3/13 18:21, Russell King (Oracle) 写道:
> > On Wed, Mar 13, 2024 at 05:24:52PM +0800, Yanteng Si wrote:
> > > 在 2024/2/6 06:06, Serge Semin 写道:
> > > > On Tue, Feb 06, 2024 at 12:58:17AM +0300, Serge Semin wrote:
> > > > > On Tue, Jan 30, 2024 at 04:49:14PM +0800, Yanteng Si wrote:
> > > > > > Current GNET does not support half duplex mode.
> > > > > > 
> > > > > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > > > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > > > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > > > > ---
> > > > > >    drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 11 ++++++++++-
> > > > > >    drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |  3 ++-
> > > > > >    include/linux/stmmac.h                               |  1 +
> > > > > >    3 files changed, 13 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > > > index 264c4c198d5a..1753a3c46b77 100644
> > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > > > > @@ -432,8 +432,17 @@ static int loongson_gnet_config(struct pci_dev *pdev,
> > > > > >    				struct stmmac_resources *res,
> > > > > >    				struct device_node *np)
> > > > > >    {
> > > > > > -	if (pdev->revision == 0x00 || pdev->revision == 0x01)
> > > > > > +	switch (pdev->revision) {
> > > > > > +	case 0x00:
> > > > > > +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000 |
> > > > > > +			       STMMAC_FLAG_DISABLE_HALF_DUPLEX;
> > > > > > +		break;
> > > > > > +	case 0x01:
> > > > > >    		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
> > > > > > +		break;
> > > > > > +	default:
> > > > > > +		break;
> > > > > > +	}
> > > > > Move this change into the patch
> > > > > [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> > > > > 
> > > > > >    	return 0;
> > > > > >    }
> > > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > > > index 5617b40abbe4..3aa862269eb0 100644
> > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > > > @@ -1201,7 +1201,8 @@ static int stmmac_init_phy(struct net_device *dev)
> > > > > >    static void stmmac_set_half_duplex(struct stmmac_priv *priv)
> > > > > >    {
> > > > > >    	/* Half-Duplex can only work with single tx queue */
> > > > > > -	if (priv->plat->tx_queues_to_use > 1)
> > > > > > +	if (priv->plat->tx_queues_to_use > 1 ||
> > > > > > +	    (STMMAC_FLAG_DISABLE_HALF_DUPLEX & priv->plat->flags))
> > > > > >    		priv->phylink_config.mac_capabilities &=
> > > > > >    			~(MAC_10HD | MAC_100HD | MAC_1000HD);
> > > > > >    	else
> > > > > > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > > > > > index 2810361e4048..197f6f914104 100644
> > > > > > --- a/include/linux/stmmac.h
> > > > > > +++ b/include/linux/stmmac.h
> > > > > > @@ -222,6 +222,7 @@ struct dwmac4_addrs {
> > > > > >    #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
> > > > > >    #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
> > > > > >    #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
> > > > > > +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
> > > > > Place the patch with this change before
> > > > > [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> > > > > as a pre-requisite/preparation patch. Don't forget a thorough
> > > > > description of what is wrong with the GNET Half-Duplex mode.
> > > > BTW what about re-defining the stmmac_ops.phylink_get_caps() callback
> > > > instead of adding fixup flags in this patch and in the next one?
> > > ok.
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > index ac1b48ff7199..b57e1325ce62 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > > @@ -238,6 +234,13 @@ static int loongson_gnet_get_hw_feature(void __iomem
> > > *ioaddr,
> > >       return 0;
> > >   }
> 
> Hi Russell,
> 
> > > +static void loongson_phylink_get_caps(struct stmmac_priv *priv)
> > > +{
> > > +    priv->phylink_config.mac_capabilities = (MAC_10FD |
> > > +        MAC_100FD | MAC_1000FD) & ~(MAC_10HD | MAC_100HD | MAC_1000HD);
> > Why is this so complicated? It would be silly if the _full duplex_
> > definitions also defined the _half duplex_ bits. This should be just:
> > 
> > 	priv->phylink_config.mac_capabilities = MAC_10FD | MAC_100FD |
> > 						MAC_1000FD;
> 
> Yes, you are right. Our gnet device (7a2000) does not support half-duplex,
> while the gnet device (2k2000) does.
> 
> I plan to use PCI IDand IP CORE as the condition to separate full-duplex and
> half-duplex.
> 
> > 
> > if that is all you support. Do you not support any pause modes (they
> > would need to be included as well here.)
> 
> I have tested it and our gnet device supports MAC_ASYM_PAUSE and
> MAC_SYM_PAUSE, but gmac does not. I will fix this in the patch v9.
> 
> This is also easy to do because all GMAC devices have the same PCI ID.
> 
> > 

> > As to this approach, I don't think it's a good model to override the
> > stmmac MAC operations. Instead, I would suggest that a better approach
> > would be for the platform to provide its capabilities to the stmmac
> > core code (maybe a new member in stmmac_priv) which, when set, is used
> > to reduce the capabilities provided to phylink via
> > priv->phylink_config.mac_capabilities.
> > 
> > Why? The driver has several components that are involved in the
> > overall capabilities, and the capabilities of the system is the
> > logical subset of all these capabilities. One component should not
> > be setting capabilities that a different component doesn't support.

In general you are right for sure - it's better to avoid one part
setting capabilities and another part unsetting them at least from the
readability and maintainability point of view. But in this case we've
already got implemented a ready-to-use internal interface
stmmac_ops::phylink_get_caps() which can be used to extend/reduce the
capabilities field based on the particular MAC abilities. Moreover
it's called right from the component setting the capabilities. Are you
saying that the callback is supposed to be utilized for extending the
capabilities only?

If you insist on not overriding the stmmac_ops::phylink_get_caps()
anyway then please explain what is the principal difference
between the next two code snippets:
	/* Get the MAC specific capabilities */
        stmmac_mac_phylink_get_caps(priv);
and
	priv->phylink_config.mac_capabilities &= ~priv->plat->mac_caps_mask;
in the MAC-capabilities update implementation? Do you think the later
approach would be more descriptive? If so then would the
callback-based approach almost equally descriptive if the callback
name was, suppose, stmmac_mac_phylink_set_caps() or similar?

In anyway I am sure the approach suggested in the initial patch of
this thread isn't good since it motivates the developers to implement
more-and-more DW MAC-specific platform capabilities flags fixing
another flags, which makes the generic code even more complicated
than it already is with endless if-else-plat-flags statements.

-Serge(y)

> 
> Hi Serge,
> 
> It seems to be going back again, what do you think?
> 
> Thanks,
> 
> Yanteng
> 
> > 
> 
> 

