Return-Path: <netdev+bounces-207701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C647BB0853C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35511C232C0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 06:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056731A5B8D;
	Thu, 17 Jul 2025 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DxO1GOMJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60097218E99;
	Thu, 17 Jul 2025 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734730; cv=none; b=ppRiIC2vMi48PH6+Hj+KRh8fiuPLtN93N6HlwrNRZBDs83nDUG+/vbdHHZg0lOTewCOorkVbCLfIRLRPYU+V20rA/F5tQRD4tC5Mm6DN1tQVNbHJ9UCl3cRpZynWXJDDSEbbAWZHOaMNRvMJO9lx5XatBvmlim6wYDwNAAzoqlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734730; c=relaxed/simple;
	bh=L/UtpAVRJrUr4OdsplN2woAEgJp68bly2ZEnhRg7ank=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3hdn8lYTHEjsPZhkPRDInM7EW62W3DdVltZUbThiCn2opuH398VnacVKMhY2VMbDS57eaj5JgnOrm9hG2txFzv/08Q0H22eSms+6Cv3FKEAKgo+zzCE3L+ZFPGHKcl25F0r1aU4aP/50xYM1dWoi8xnfkQZDhkAz/R90dWDfqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DxO1GOMJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nXMaxus8XfDIaPk/PrV9R055UFe2h6R0FRKpTuO5XRQ=; b=DxO1GOMJ+NvrBkIAX8Br+aJ8Q9
	UVSDgZx6yS6GnqdC6mbMhOo+egX/a4ywDvA/Y7MRENl1PBLe/pQSbKvqGO1wW1Xye0TMIWZ1xKeXW
	Tyb16/sYf+YqErU0ebo/9wYDSXu/buZ3YR34wYlFdF9UCZ04yqgmgX6ncL9I8r1YkYbgX0AznLY81
	4IBi2iGczQYKWyluBOEXXUpVUEDpyAUznKrV+5EF14Kyt63iS7bxfsDet6xbKGQ8okRyfv0o0jCY7
	fxvhI2tw8Ryo77AJW3q7eEyoutc1b+IfXnxrG27npSdqvOO9TrbUANgXOgDc7mpjkdp0lFnOtyjSl
	sICQEDMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49690)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ucIMk-0000fd-1w;
	Thu, 17 Jul 2025 07:45:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ucIMf-0001xN-1N;
	Thu, 17 Jul 2025 07:45:09 +0100
Date: Thu, 17 Jul 2025 07:45:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: rohan.g.thomas@altera.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next 2/3] net: stmmac: xgmac: Correct supported speed
 modes
Message-ID: <aHib9V1_WZfj3S8M@shell.armlinux.org.uk>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 14, 2025 at 03:59:18PM +0800, Rohan G Thomas via B4 Relay wrote:
> @@ -1532,8 +1542,8 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
>  		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>  
>  	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> -			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
> -			 MAC_10000FD;
> +			 MAC_10FD | MAC_100FD | MAC_1000FD |
> +			 MAC_2500FD | MAC_5000FD | MAC_10000FD;
...
> @@ -405,6 +405,7 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
>  	dma_cap->sma_mdio = (hw_cap & XGMAC_HWFEAT_SMASEL) >> 5;
>  	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
>  	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
> +	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;

What if dma_cap->mbps_10_100 is false? Should MAC_10FD | MAC_100FD
still be set? What if dma_cap->half_duplex is set but
dma_cap->mbps_10_100 is not? Should we avoid setting 10HD and 100HD?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

