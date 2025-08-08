Return-Path: <netdev+bounces-212191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E7B1EA4C
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C686818C7CAC
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD5D27F4CA;
	Fri,  8 Aug 2025 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIR9WG8Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA78F4F1
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662977; cv=none; b=pnieRNdasWZiSQiaz0lk9EQSZmBNL84iWuzDvT5Df1s1HrG+kNq/XeZJ27qi7GoJPcmEHRzKlRrSwepWTrRZIx886rh/jXju7gYkzeuT3RemQzgjPJ8kUmh0uoPLa+mvKhff7Jn1qchk5fsVirD8JC2IwPZ6dUa5N8YSOLKea4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662977; c=relaxed/simple;
	bh=C2mDBiwbp98LucRDstG30Q8R9qWzgIONvigmiGMmCDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKisBZd6gwx+ty2KkzqDpzxd+GX5qM/2zopCy2IZErB3Rsf1MwD/yFo/gsWfv+4yqZlK4TmtESdjolHwHx30YABtWzwPzAkeaPlkv9Lpdg7NYAM7cLsQ2XrGxYA47WMzr9tkTGZRVwprUTnbgDxQpmJrm5aZK2AiYickPke8PZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIR9WG8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3172C4CEF4;
	Fri,  8 Aug 2025 14:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754662976;
	bh=C2mDBiwbp98LucRDstG30Q8R9qWzgIONvigmiGMmCDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIR9WG8YIiMvBoT/2IOlRZTCD66n0CHJqXz2aC/VtFq/nBAf6oXz7ZccbJWE0Jvm4
	 QEk3o2tYw4YXMLOVJcqN3nr6Afnq8gsOGI1X5jsSpzKaWi57bKeWcWyTJyaF9PeOxM
	 NTlC2B+uplfuNYIfBkEUI4YNbDdWe0XwIfH2MmoGCLHUOxjwJtPLBLfDO5xfLPmfOo
	 GhCjPH2m94x6a7yVqwLnM+9Bgg0N9sVeAOwmiehh/ZiSobGQvGohQu0aMKVIR+Ey9F
	 0x/FryhM+qcRnllO9Yz0xNVcVNsCM/8X2ssENYmOeHk1K1sOvIM+wP1xxtTNWimN4h
	 z2hIhv+FSsBMw==
Date: Fri, 8 Aug 2025 15:22:51 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: stmmac: dwc-qos: fix clk prepare/enable leak on
 probe failure
Message-ID: <20250808142251.GF1705@horms.kernel.org>
References: <E1ukM1X-0086qu-Td@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ukM1X-0086qu-Td@rmk-PC.armlinux.org.uk>

On Fri, Aug 08, 2025 at 01:16:39PM +0100, Russell King (Oracle) wrote:
> dwc_eth_dwmac_probe() gets bulk clocks, and then prepares and enables
> them. Unfortunately, if dwc_eth_dwmac_config_dt() or stmmac_dvr_probe()
> fail, we leave the clocks prepared and enabled. Fix this by using
> devm_clk_bulk_get_all_enabled() to combine the steps and provide devm
> based release of the prepare and enable state.
> 
> This also fixes a similar leakin dwc_eth_dwmac_remove() which wasn't
> correctly retrieving the struct plat_stmmacenet_data. This becomes
> unnecessary.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks Russell,

Probably this wants:

Fixes: a045e40645df ("net: stmmac: refactor clock management in EQoS driver")

Otherwise looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

