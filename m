Return-Path: <netdev+bounces-156438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE82A065FE
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 21:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFDE166DE7
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8931F8EF5;
	Wed,  8 Jan 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bgULs6bQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99F19EEBF
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367926; cv=none; b=isXaU+zP3RD2RgIvgFQG6DhWdOePaBqSdQVR1ByixodfCEbsxULYOyWVB5gFMuNAoasOhqHH9Tnx36ru1XU4JHVIQ09jsCrdRXytVN3LjufekT/MvsqxpIL0kq7H5TjZ8lxwBiRySbyNCimncUIZ31ZMNClZ1QCYZA38BDuWdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367926; c=relaxed/simple;
	bh=3cPwGh4BEDWuDjBsFhJ8FJSpEdbmLLbYu8b1Ht/yLGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVt+MlrtXI/xLsp/7ivIALMdz6tZXdBXNKgykAYTsss+KAaDGL9hHC+ybzja7DPNWUKq4jqP8pUKZZm8pTsO1wtCPbCXpvO4nHfIkdEadCEyJpPBwYxWQEBukcnSOuBGrK6yZ6fkBYDrxp+ueokE/UY7G4wm87pTGfpDvGQsUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bgULs6bQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PUDw2uMXlvZKFnYf/nGhrEOQlOnEKNrdrSrZUwzH9YU=; b=bgULs6bQzGZW9Uddr1Ln/594zs
	Vt9+DfsqfV4bSp5A8CpFEk5PVqbyagYxOG7eiUkt6KlN4zYgexHHHRGZ67E1YtT19gt9Qcu16kQPM
	+vbDAsasIt/5/6e4pO8EbTtvDNh0nfECU6D/UZqrKAdZqaDqlrwjAJMMzYPHE0FWqHVfGbFHqctMy
	I6jniHa56A1hvkHEb0KzrCJPhzOqbxZTqn4LmoUuajDAL4SwFSjf3sJkYuu823oHxUr/t9cnYpmZ3
	zb/pTPwV/3iL4UnidBODEqp9wCcq7lH6Ul3+G1adhBnAplyCbvsedd7k5ITwUu45l93vhG+TS6+M1
	oSzGG/8Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50228)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVcc3-0001BL-1g;
	Wed, 08 Jan 2025 20:25:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVcbz-0006a3-24;
	Wed, 08 Jan 2025 20:25:07 +0000
Date: Wed, 8 Jan 2025 20:25:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 07/18] net: stmmac: clean up
 stmmac_disable_eee_mode()
Message-ID: <Z37fI8dMLOS7-ky7@shell.armlinux.org.uk>
References: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
 <E1tVZDw-0002KL-Gg@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tVZDw-0002KL-Gg@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 08, 2025 at 04:48:04PM +0000, Russell King (Oracle) wrote:
> stmmac_disable_eee_mode() is now only called from stmmac_xmit() when
> both priv->tx_path_in_lpi_mode and priv->eee_sw_timer_en are true.
> Therefore:
> 
> 	if (!priv->eee_sw_timer_en)
> 
> in stmmac_disable_eee_mode() will never be true, so this is dead code.
> Remove it, and rename the function to indicate that it now only deals
> with software based EEE mode.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index de06aa1ff3f6..9a043d19ebac 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -427,18 +427,13 @@ static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
>  }
>  
>  /**
> - * stmmac_disable_eee_mode - disable and exit from LPI mode
> + * stmmac_disable_sw_eee_mode - disable and exit from LPI mode
>   * @priv: driver private structure
>   * Description: this function is to exit and disable EEE in case of
>   * LPI state is true. This is called by the xmit.
>   */
> -static void stmmac_disable_eee_mode(struct stmmac_priv *priv)
> +static void stmmac_disable_sw_eee_mode(struct stmmac_priv *priv)

Looking at this again, I'm still not happy with the function name, but
not enough to send another version. I'll change it to
stmmac_stop_sw_lpi() in the next batch of stmmac EEE cleanups (there
is more to come!)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

