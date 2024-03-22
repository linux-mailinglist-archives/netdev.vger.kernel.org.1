Return-Path: <netdev+bounces-81330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E76C88740E
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 20:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF684282028
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B6D7A702;
	Fri, 22 Mar 2024 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VYG0xVp/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815871733
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711137440; cv=none; b=hp6AZe/dfoS4SDCNvHHgHTkjNyYS9K+dJufM9T3fVyUPT9P/DZodl+kLFl5QVnH/wxSJTD/GRPAhEsC7d/duB8bGONR0XYjQIGrLmwG+wskm0KCUgQ/zwfxYt7kO4VglteVQMfq+c31jILYZ6JI992cklKt+unlSkIlQvT4df4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711137440; c=relaxed/simple;
	bh=o75SRdTkUMmQcC2lL8a8S3pSKWUGJdtOgfiyXIzEscE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgmIm+pOU/WDU9vRnxP5oub/Fv4oaKzPqRExvgBMtiu/pDjt17Uxd20+qInsKZNGmAX5N33CjHp9SImp77rleNcpjRcIAN+KILjUP09S2bj3+C6b7YduWzpez3JI8TOeUI86pIR976XNml8zvWivTtn3MdPe0S1a9tbrJTPb/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VYG0xVp/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=amIrGlkmaB76KZoaSlBCudgSjqmh6MBWuV9e0ATMQMY=; b=VYG0xVp/g0svrTKpM8hk0FFQBg
	Yb5zCDOhNV0t0ZBF+V75bXYpl6ZYkNSMh2rsSGOgNLC6kw6Qu3EM5UkhzMmDTc/h3Cd8ql/swu0qj
	v7W53bzXaiTuzGY3yJRr7IkU4/inMStOrOY1LHZe82rl5X9keeaBdgQrbXrIkvRhigcdnAKRcDs6C
	EnIRfcKOc2XM3hXTT6s+ZgeT8wMxx5Skt6jl4LIGUrRKvUbQG3+2FPDp4Od6+pGFsdROMkXOe4Zvs
	Ay8eMwtQ57hxOyoKg0LaklRDR4ML7cRXTT4dofT0+7bLO9jywWSXLqCRg9HnUaNEtFbfUIOdOEx2K
	5qiDyptw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44742)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rnl0S-0000lE-28;
	Fri, 22 Mar 2024 19:56:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rnl0O-0004vy-7X; Fri, 22 Mar 2024 19:56:44 +0000
Date: Fri, 22 Mar 2024 19:56:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch,
	hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	Jose.Abreu@synopsys.com, chenhuacai@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
Message-ID: <Zf3ifH/CjyHtmXE3@shell.armlinux.org.uk>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
 <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
 <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
 <ZfF+IAWbe1rwx3Xs@shell.armlinux.org.uk>
 <cd8be3b1-fcfa-4836-9d28-ced735169615@loongson.cn>
 <em3r6w7ydvjxualqifjurtrrfpztpil564t5k5b4kxv4f6ddrd@4weteqhekyae>
 <Zfq8TNrt0KxW/IWh@shell.armlinux.org.uk>
 <fu3f6uoakylnb6eijllakeu5i4okcyqq7sfafhp5efaocbsrwe@w74xe7gb6x7p>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fu3f6uoakylnb6eijllakeu5i4okcyqq7sfafhp5efaocbsrwe@w74xe7gb6x7p>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 22, 2024 at 09:07:19PM +0300, Serge Semin wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 25519952f754..24ff5d1eb963 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -936,6 +936,22 @@ static void stmmac_mac_flow_ctrl(struct stmmac_priv *priv, u32 duplex)
>  			priv->pause, tx_cnt);
>  }
>  
> +static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
> +					 phy_interface_t interface)
> +{
> +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> +
> +	/* Get the MAC-specific capabilities */
> +	stmmac_mac_phylink_get_caps(priv);
> +
> +	config->mac_capabilities = priv->hw->link.caps;
> +
> +	if (priv->plat->max_speed)
> +		phylink_limit_mac_speed(config, priv->plat->max_speed);
> +
> +	return config->mac_capabilities;

Yes, I think your approach is better - and it still allows for the
platform's capabilities to be masked in towards the end of this
function.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

