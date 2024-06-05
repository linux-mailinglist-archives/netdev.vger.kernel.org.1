Return-Path: <netdev+bounces-101136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1F98FD70A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C88528566A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A063E1586C2;
	Wed,  5 Jun 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IShKNGtK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E0157A7D
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617951; cv=none; b=i9uWryfylH/hNTrnKnNL2k6NB4qo01vLKJeeWrbdnyq/C/pJ95KO+VNxAEZ1D72pvjPtcVv2G20EeG7D/aLClbvJMbpiTCRtMTYVtqXhja+ZXwYhroUo6MJMnnLI/w/86LKuQ4pTaISL2QEIQ6pG3nwfryq3ZTYMVUsCHaYyr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617951; c=relaxed/simple;
	bh=HMuwmIyPn9oJxft/xILZyfZFYcfOK5nwIg8mBj+oVTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKO23sIXPAbWtbhC+9FF0r52o5EhOwyENJpaL8Q/hyY1o7yYxo8FOgkMIW8ohz28jrD+6JI+q+74qT5tlKevvlEnOL/u6C/wseY2N+il4sdyjDU6Q5j6P64r6zXjNl6zHypuobtbtfx81sny6jwTrLk7SWW5G7vk2/QRUr49WrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IShKNGtK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717617949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PrdH88/0O98/W7d4Muvx4vjoUCcxM5TP1MAziR+qePQ=;
	b=IShKNGtK5VQ69Tk0J9e+NCmBZGCHZHcqmBPwKzdelzZL3IuETpfxCLK1QEzQgy0WXzm9tE
	pnuHIdIuAREPJcIz2eBEgMWOsMBYWFLgt/4S7F77jRUpABJLN9pwQypaZAZ6xiyFpHVCvR
	cuNfvY80rwbL2xed5aAmO4sbotvtAqQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-eANzDuNiN8uJ54araAze2Q-1; Wed, 05 Jun 2024 16:05:47 -0400
X-MC-Unique: eANzDuNiN8uJ54araAze2Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7952b4c5fb8so7259485a.3
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 13:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617947; x=1718222747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrdH88/0O98/W7d4Muvx4vjoUCcxM5TP1MAziR+qePQ=;
        b=tQLGp7rXTSwJE27rZP0uCpGKwL0jtW6alI+bAveshyOKtQ9m5G6Jig6jeLpYoOA4ub
         XeOHyAKcjviq73Q1QGu1vHdMO00JJYB1LF9VE/ocvbfU8PQH8CoK6zHNrsSunpOfZ+ff
         ZAYbp5GKdFKR8Br37iPSICUDWccZQnLnZYLhD7zaRSADoWxBj6RwPvOl6u37Xk0KDtJJ
         /Z8UJIogXDrh90uW2xr4vPZoYM+sPoEpn++reLBWekEN/QzTrHETHayO2f2XhWP4xPKE
         Vk4xCrKq9dIXPwS4as4sFV67+vxCVaIIO/WAVb7ygXTVvCOX20xwVLfEik3O59A4X9/P
         l2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqFiGvZ2EeJY2AlSyZr2V+TwV4bseC4t/GiXi6PPwtbITUGCJGy0MJhPF5W3dBEAiTJ+i4nE5sn3ARDcc+DLWoTxpo60N6
X-Gm-Message-State: AOJu0YwE+u5YoAJGME+aYlDLCf5Ojl6wBwuvLge4ksk5PyCvTJVjUJy7
	Nqpq6sC3HfLIdm+h+qF63Kmu9j/UKknSMnj6WEDQ/sFiMl4yEC6rtiM/o5hNmBfVbBilL+dYZms
	ExOrV9K1J2GVSaBUyRVz4MaDAmrui4OcDFuUnJ+kdcYW5CMlz+nBB3Q==
X-Received: by 2002:a05:620a:288b:b0:792:bc0b:e269 with SMTP id af79cd13be357-79523fd9b67mr449349685a.52.1717617946474;
        Wed, 05 Jun 2024 13:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMYwT4U14yD46Q+CgdugT284E/jRdYiZEAS6QBZe9UXDuAmP9vXDCSKxak9gLW7oyz9grJfA==
X-Received: by 2002:a05:620a:288b:b0:792:bc0b:e269 with SMTP id af79cd13be357-79523fd9b67mr449345985a.52.1717617945960;
        Wed, 05 Jun 2024 13:05:45 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79519a7ba98sm149204785a.119.2024.06.05.13.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:05:45 -0700 (PDT)
Date: Wed, 5 Jun 2024 15:05:43 -0500
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
Message-ID: <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>

On Fri, May 31, 2024 at 12:26:25PM GMT, Russell King (Oracle) wrote:
> Convert dwmac1000 sgmii/rgmii "pcs" implementation to use a phylink_pcs
> so we can eventually get rid of the exceptional paths that conflict
> with phylink.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 113 ++++++++++++------
>  1 file changed, 75 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> index d413d76a8936..4a0572d5f865 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/ethtool.h>
>  #include <linux/io.h>
> +#include <linux/phylink.h>
>  #include "stmmac.h"
>  #include "stmmac_pcs.h"
>  #include "dwmac1000.h"
> @@ -261,39 +262,6 @@ static void dwmac1000_pmt(struct mac_device_info *hw, unsigned long mode)
>  	writel(pmt, ioaddr + GMAC_PMT);
>  }
>  
> -/* RGMII or SMII interface */
> -static void dwmac1000_rgsmii(void __iomem *ioaddr, struct stmmac_extra_stats *x)
> -{
> -	u32 status;
> -
> -	status = readl(ioaddr + GMAC_RGSMIIIS);
> -	x->irq_rgmii_n++;
> -
> -	/* Check the link status */
> -	if (status & GMAC_RGSMIIIS_LNKSTS) {
> -		int speed_value;
> -
> -		x->pcs_link = 1;
> -
> -		speed_value = ((status & GMAC_RGSMIIIS_SPEED) >>
> -			       GMAC_RGSMIIIS_SPEED_SHIFT);
> -		if (speed_value == GMAC_RGSMIIIS_SPEED_125)
> -			x->pcs_speed = SPEED_1000;
> -		else if (speed_value == GMAC_RGSMIIIS_SPEED_25)
> -			x->pcs_speed = SPEED_100;
> -		else
> -			x->pcs_speed = SPEED_10;
> -
> -		x->pcs_duplex = (status & GMAC_RGSMIIIS_LNKMOD_MASK);
> -
> -		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
> -			x->pcs_duplex ? "Full" : "Half");
> -	} else {
> -		x->pcs_link = 0;
> -		pr_info("Link is Down\n");
> -	}
> -}
> -
>  static int dwmac1000_irq_status(struct mac_device_info *hw,
>  				struct stmmac_extra_stats *x)
>  {
> @@ -335,8 +303,12 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
>  
>  	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
>  
> -	if (intr_status & PCS_RGSMIIIS_IRQ)
> -		dwmac1000_rgsmii(ioaddr, x);
> +	if (intr_status & PCS_RGSMIIIS_IRQ) {
> +		/* TODO Dummy-read to clear the IRQ status */
> +		readl(ioaddr + GMAC_RGSMIIIS);

This seems to me that you're doing the TODO here? Maybe I'm
misunderstanding... maybe not :)

> +		phylink_pcs_change(&hw->mac_pcs, false);
> +		x->irq_rgmii_n++;
> +	}
>  
>  	return ret;
>  }
> @@ -404,9 +376,71 @@ static void dwmac1000_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
>  	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
>  }
>  
> -static void dwmac1000_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
> +static int dwmac1000_mii_pcs_validate(struct phylink_pcs *pcs,
> +				      unsigned long *supported,
> +				      const struct phylink_link_state *state)
> +{
> +	/* Only support in-band */
> +	if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, state->advertising))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int dwmac1000_mii_pcs_config(struct phylink_pcs *pcs,
> +				    unsigned int neg_mode,
> +				    phy_interface_t interface,
> +				    const unsigned long *advertising,
> +				    bool permit_pause_to_mac)
>  {
> -	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
> +	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
> +
> +	return dwmac_pcs_config(hw, neg_mode, interface, advertising,
> +				GMAC_PCS_BASE);
> +}
> +
> +static void dwmac1000_mii_pcs_get_state(struct phylink_pcs *pcs,
> +					struct phylink_link_state *state)
> +{
> +	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
> +	unsigned int spd_clk;
> +	u32 status;
> +
> +	status = readl(hw->pcsr + GMAC_RGSMIIIS);
> +
> +	state->link = status & GMAC_RGSMIIIS_LNKSTS;
> +	if (!state->link)
> +		return;
> +
> +	spd_clk = FIELD_GET(GMAC_RGSMIIIS_SPEED, status);
> +	if (spd_clk == GMAC_RGSMIIIS_SPEED_125)
> +		state->speed = SPEED_1000;
> +	else if (spd_clk == GMAC_RGSMIIIS_SPEED_25)
> +		state->speed = SPEED_100;
> +	else if (spd_clk == GMAC_RGSMIIIS_SPEED_2_5)
> +		state->speed = SPEED_10;
> +
> +	state->duplex = status & GMAC_RGSMIIIS_LNKMOD_MASK ?
> +			DUPLEX_FULL : DUPLEX_HALF;
> +
> +	dwmac_pcs_get_state(hw, state, GMAC_PCS_BASE);
> +}
> +
> +static const struct phylink_pcs_ops dwmac1000_mii_pcs_ops = {
> +	.pcs_validate = dwmac1000_mii_pcs_validate,
> +	.pcs_config = dwmac1000_mii_pcs_config,
> +	.pcs_get_state = dwmac1000_mii_pcs_get_state,
> +};
> +
> +static struct phylink_pcs *
> +dwmac1000_phylink_select_pcs(struct stmmac_priv *priv,
> +			     phy_interface_t interface)
> +{
> +	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
> +	    priv->hw->pcs & STMMAC_PCS_SGMII)
> +		return &priv->hw->mac_pcs;
> +
> +	return NULL;
>  }
>  
>  static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -499,6 +533,7 @@ static void dwmac1000_set_mac_loopback(void __iomem *ioaddr, bool enable)
>  
>  const struct stmmac_ops dwmac1000_ops = {
>  	.core_init = dwmac1000_core_init,
> +	.phylink_select_pcs = dwmac1000_phylink_select_pcs,
>  	.set_mac = stmmac_set_mac,
>  	.rx_ipc = dwmac1000_rx_ipc_enable,
>  	.dump_regs = dwmac1000_dump_regs,
> @@ -514,7 +549,6 @@ const struct stmmac_ops dwmac1000_ops = {
>  	.set_eee_pls = dwmac1000_set_eee_pls,
>  	.debug = dwmac1000_debug,
>  	.pcs_ctrl_ane = dwmac1000_ctrl_ane,
> -	.pcs_get_adv_lp = dwmac1000_get_adv_lp,
>  	.set_mac_loopback = dwmac1000_set_mac_loopback,
>  };
>  
> @@ -549,5 +583,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
>  	mac->mii.clk_csr_shift = 2;
>  	mac->mii.clk_csr_mask = GENMASK(5, 2);
>  
> +	mac->mac_pcs.ops = &dwmac1000_mii_pcs_ops;
> +	mac->mac_pcs.neg_mode = true;
> +
>  	return 0;
>  }
> -- 
> 2.30.2
> 


