Return-Path: <netdev+bounces-101167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A58C8FD972
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B555F1F24900
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883AC15F3E6;
	Wed,  5 Jun 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFTIpltA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A33C062
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624762; cv=none; b=tRh4C/n5jOB9t66hepUV55VnWIJHGse7PEbe97n8nNoJkn6fHsBt1+PyIw7Aybzx+hAHhEYRSIb08Iwa6SPfTD/db9rbF4aWSlla93j8/4Y28emituR/wBMycQDTdR7IiiGwDkZKUp+Jj0DzsirV5IQ6LvhknIMFJBB0fd7cHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624762; c=relaxed/simple;
	bh=fwETLvZ6kb/YUNiwzax7A3Zv5Qg8ctbg68/b/Q79+n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp9USFZgSaI15HW/P3bbKZQfKvBZ+ShzaRBK9CmFwXHoluZMvhnQAiOSXX5jTVrDUDkSulnNB1/0N+v1/dg99MOGf5Yt0YbaA2+Yip8NOZVqRcLpzI3zZS4j0MDBMj65S9Ttx5BGkFKLtLHPBHSurAE/R/QvRWkdJ6kqdjeHCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFTIpltA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717624759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BS5UbRPaXwrBemfpEa7lElS2oOfakJCTYaPE42vqmLY=;
	b=LFTIpltAM8b5DDkL11fgS2N2y3DhuOVOcVBSpe2G/gOEBO7U5YQpt+KFCr2EbcUKXtSVqo
	vtkbqUjmTPAFjbgk/zRGiRHZwVUJq1k4ZJpNvkOPiYmvAlUnA6G1LvAmnT2JXGfI4/au5L
	aVCrmGJzTx0zSFKivI4xIrSwkmBCyCU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-4YlAsmV4PJq7etvrPKUAdA-1; Wed, 05 Jun 2024 17:59:18 -0400
X-MC-Unique: 4YlAsmV4PJq7etvrPKUAdA-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dfa74b3e6cbso569411276.2
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 14:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717624758; x=1718229558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS5UbRPaXwrBemfpEa7lElS2oOfakJCTYaPE42vqmLY=;
        b=w1U6CBqU8Q7+l+eg1CNZ0SwxYhTqyX7CqfxOwvQveX1fgaz3SS8SfA2TEPgdgeBrup
         rXixBb1q1PRM9l+jSGn3vlqbwRIAbOE4UKISFPXaGKpMlC4BBIPpxCFKzo985CHdPNth
         1oWG14cUonXpaUKpGfXGAHH86iBfwwXV6ggd9f2WeIk7pDWGGmo32iBFwaEu9wyoKNVU
         GeD0nxLcbJ96AiPF8Rie2EOfPfaBOTFSgkVue3yDgrvUxKOPZbQRMijIZMJymEW1T53o
         Jv91EHistEpJpWWZs5MmvL3/o54HbuP70tgQuxoNi+7bkUitnS4JRtsLgQI3/ssNq5vH
         AAxg==
X-Forwarded-Encrypted: i=1; AJvYcCWFKGeJNskm+g0fOUAUCXvLUL+02X0r4iINbpueHGkYxC/MQX0Mg+7NZERemUuFtlnisFtzvPxMVHe3Rb2m/Wfy7GWjnjKK
X-Gm-Message-State: AOJu0YzFy0SFSrZ6O/ZTsy9v3RQEolGkVHvOogsDt992MnZSFSomUCho
	Bu2w+pFIBx2x9FkjOFn1JSY5R7OW5+TlkEn9C0jYIFz9WbZjHd+jQKofIJa70ZSjGqjBg8MBP6z
	duVeHDenLCb3uDpU/OSpet5qgkX0HemW00Ju95r4re6lXO71FAy7+sw==
X-Received: by 2002:a25:f502:0:b0:dfa:72cc:f88b with SMTP id 3f1490d57ef6-dfacacee2c8mr4099224276.52.1717624757876;
        Wed, 05 Jun 2024 14:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1ONbdFA8YK2xXD4LNm7Arn6wmyNXQQLV/iwegUTAqEAZwNPAzl19UGio/NM4W7NRIn/brzA==
X-Received: by 2002:a25:f502:0:b0:dfa:72cc:f88b with SMTP id 3f1490d57ef6-dfacacee2c8mr4099193276.52.1717624757274;
        Wed, 05 Jun 2024 14:59:17 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f9f6a94sm2616d6.113.2024.06.05.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:59:16 -0700 (PDT)
Date: Wed, 5 Jun 2024 16:59:14 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC net-next v2 3/8] net: stmmac: dwmac1000: convert
 sgmii/rgmii "pcs" to phylink
Message-ID: <6qpcartwgkgdmtxwj4puxn2exbpiv6t6fxv2b3kecu6ezzdogs@yii3j3xtougr>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>
 <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>

On Wed, Jun 05, 2024 at 03:05:43PM GMT, Andrew Halaney wrote:
> On Fri, May 31, 2024 at 12:26:25PM GMT, Russell King (Oracle) wrote:
> > Convert dwmac1000 sgmii/rgmii "pcs" implementation to use a phylink_pcs
> > so we can eventually get rid of the exceptional paths that conflict
> > with phylink.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 113 ++++++++++++------
> >  1 file changed, 75 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> > index d413d76a8936..4a0572d5f865 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/ethtool.h>
> >  #include <linux/io.h>
> > +#include <linux/phylink.h>
> >  #include "stmmac.h"
> >  #include "stmmac_pcs.h"
> >  #include "dwmac1000.h"
> > @@ -261,39 +262,6 @@ static void dwmac1000_pmt(struct mac_device_info *hw, unsigned long mode)
> >  	writel(pmt, ioaddr + GMAC_PMT);
> >  }
> >  
> > -/* RGMII or SMII interface */
> > -static void dwmac1000_rgsmii(void __iomem *ioaddr, struct stmmac_extra_stats *x)
> > -{
> > -	u32 status;
> > -
> > -	status = readl(ioaddr + GMAC_RGSMIIIS);
> > -	x->irq_rgmii_n++;
> > -
> > -	/* Check the link status */
> > -	if (status & GMAC_RGSMIIIS_LNKSTS) {
> > -		int speed_value;
> > -
> > -		x->pcs_link = 1;
> > -
> > -		speed_value = ((status & GMAC_RGSMIIIS_SPEED) >>
> > -			       GMAC_RGSMIIIS_SPEED_SHIFT);
> > -		if (speed_value == GMAC_RGSMIIIS_SPEED_125)
> > -			x->pcs_speed = SPEED_1000;
> > -		else if (speed_value == GMAC_RGSMIIIS_SPEED_25)
> > -			x->pcs_speed = SPEED_100;
> > -		else
> > -			x->pcs_speed = SPEED_10;
> > -
> > -		x->pcs_duplex = (status & GMAC_RGSMIIIS_LNKMOD_MASK);
> > -
> > -		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
> > -			x->pcs_duplex ? "Full" : "Half");
> > -	} else {
> > -		x->pcs_link = 0;
> > -		pr_info("Link is Down\n");
> > -	}
> > -}
> > -
> >  static int dwmac1000_irq_status(struct mac_device_info *hw,
> >  				struct stmmac_extra_stats *x)
> >  {
> > @@ -335,8 +303,12 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
> >  
> >  	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
> >  
> > -	if (intr_status & PCS_RGSMIIIS_IRQ)
> > -		dwmac1000_rgsmii(ioaddr, x);
> > +	if (intr_status & PCS_RGSMIIIS_IRQ) {
> > +		/* TODO Dummy-read to clear the IRQ status */
> > +		readl(ioaddr + GMAC_RGSMIIIS);
> 
> This seems to me that you're doing the TODO here? Maybe I'm
> misunderstanding... maybe not :)
> 
> > +		phylink_pcs_change(&hw->mac_pcs, false);

Continuing to read through this all, sorry for the double reply and
possibly dumb question. Should we be passing in false unconditionally
here?

Prior code had checked GMAC_RGSMIIIS & GMAC_RGSMIIIS_LNKSTS to determine
if the link was up/down, which seem logical to pass in here too. Reading
the kerneldoc for phylink_pcs_change() I'm not totally positive if
we're in the "otherwise pass false" state here or some other detail I'm
missing though (it seems that maybe we're just sort of kicking the can
to phylink_resolve() which ends up calling into the get_state()
callback?)

> > +		x->irq_rgmii_n++;
> > +	}
> >  
> >  	return ret;
> >  }
> > @@ -404,9 +376,71 @@ static void dwmac1000_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
> >  	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
> >  }
> >  
> > -static void dwmac1000_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
> > +static int dwmac1000_mii_pcs_validate(struct phylink_pcs *pcs,
> > +				      unsigned long *supported,
> > +				      const struct phylink_link_state *state)
> > +{
> > +	/* Only support in-band */
> > +	if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, state->advertising))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int dwmac1000_mii_pcs_config(struct phylink_pcs *pcs,
> > +				    unsigned int neg_mode,
> > +				    phy_interface_t interface,
> > +				    const unsigned long *advertising,
> > +				    bool permit_pause_to_mac)
> >  {
> > -	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
> > +	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
> > +
> > +	return dwmac_pcs_config(hw, neg_mode, interface, advertising,
> > +				GMAC_PCS_BASE);
> > +}
> > +
> > +static void dwmac1000_mii_pcs_get_state(struct phylink_pcs *pcs,
> > +					struct phylink_link_state *state)
> > +{
> > +	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
> > +	unsigned int spd_clk;
> > +	u32 status;
> > +
> > +	status = readl(hw->pcsr + GMAC_RGSMIIIS);
> > +
> > +	state->link = status & GMAC_RGSMIIIS_LNKSTS;
> > +	if (!state->link)
> > +		return;
> > +
> > +	spd_clk = FIELD_GET(GMAC_RGSMIIIS_SPEED, status);
> > +	if (spd_clk == GMAC_RGSMIIIS_SPEED_125)
> > +		state->speed = SPEED_1000;
> > +	else if (spd_clk == GMAC_RGSMIIIS_SPEED_25)
> > +		state->speed = SPEED_100;
> > +	else if (spd_clk == GMAC_RGSMIIIS_SPEED_2_5)
> > +		state->speed = SPEED_10;
> > +
> > +	state->duplex = status & GMAC_RGSMIIIS_LNKMOD_MASK ?
> > +			DUPLEX_FULL : DUPLEX_HALF;
> > +
> > +	dwmac_pcs_get_state(hw, state, GMAC_PCS_BASE);
> > +}
> > +
> > +static const struct phylink_pcs_ops dwmac1000_mii_pcs_ops = {
> > +	.pcs_validate = dwmac1000_mii_pcs_validate,
> > +	.pcs_config = dwmac1000_mii_pcs_config,
> > +	.pcs_get_state = dwmac1000_mii_pcs_get_state,
> > +};
> > +
> > +static struct phylink_pcs *
> > +dwmac1000_phylink_select_pcs(struct stmmac_priv *priv,
> > +			     phy_interface_t interface)
> > +{
> > +	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
> > +	    priv->hw->pcs & STMMAC_PCS_SGMII)
> > +		return &priv->hw->mac_pcs;
> > +
> > +	return NULL;
> >  }
> >  
> >  static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
> > @@ -499,6 +533,7 @@ static void dwmac1000_set_mac_loopback(void __iomem *ioaddr, bool enable)
> >  
> >  const struct stmmac_ops dwmac1000_ops = {
> >  	.core_init = dwmac1000_core_init,
> > +	.phylink_select_pcs = dwmac1000_phylink_select_pcs,
> >  	.set_mac = stmmac_set_mac,
> >  	.rx_ipc = dwmac1000_rx_ipc_enable,
> >  	.dump_regs = dwmac1000_dump_regs,
> > @@ -514,7 +549,6 @@ const struct stmmac_ops dwmac1000_ops = {
> >  	.set_eee_pls = dwmac1000_set_eee_pls,
> >  	.debug = dwmac1000_debug,
> >  	.pcs_ctrl_ane = dwmac1000_ctrl_ane,
> > -	.pcs_get_adv_lp = dwmac1000_get_adv_lp,
> >  	.set_mac_loopback = dwmac1000_set_mac_loopback,
> >  };
> >  
> > @@ -549,5 +583,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
> >  	mac->mii.clk_csr_shift = 2;
> >  	mac->mii.clk_csr_mask = GENMASK(5, 2);
> >  
> > +	mac->mac_pcs.ops = &dwmac1000_mii_pcs_ops;
> > +	mac->mac_pcs.neg_mode = true;
> > +
> >  	return 0;
> >  }
> > -- 
> > 2.30.2
> > 


