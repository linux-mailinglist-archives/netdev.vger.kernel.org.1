Return-Path: <netdev+bounces-86579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E509189F3AE
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220471C210C8
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194A515CD69;
	Wed, 10 Apr 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pEOLrIik"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3215B54E
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754480; cv=none; b=hnnqp5x7vBlQyVBJN71Fp0GWc8m2GWHwvP2kAG+uvxr1tqi2eZ3wE8dNYLiKvFpU9D+Gte4cB7mhoC+1bY3cFldTduCXNtFhOtmaq98v4ZHCWNJPYmzRnu5jSNZhx5OXHCYiPzkxovxSgZlqnQxSTi3uMSHAL3ymmhFo5p1Sfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754480; c=relaxed/simple;
	bh=Md0Yiu7Qg0+EaiF79o5u1ASslwTjp/vtZxzjovffZPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bi9X0YWS8rUGp+qhkrbOj5Zv056wdDoQiyc385CPFFpsTXlRc2CuZp5ZQ4Uvzh1hOeqGkZPj99IsIvHnqE3sasrgawcvPbMia6vk2DSWWFEqWTvlUUH1JcjARpSphygntQ2bSolgiRXJK6UdPBHbe7VnAf2xF52smNNqPvo3ojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pEOLrIik; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+1SLsua+e1rjd26Xm4MLfYXzsr2YhirDF6WCfjVTU3Y=; b=pEOLrIikxO5VHvZSe8lTUH+Gy7
	pUyVKOCfNtmb49cNgfWwTC/Wvho3trWLYogc+stODHl617lbmzpBC4U3OBLlsypPnHMHrKBUA25Ed
	WK/U9eQI1cANtV34AaT3OEBr5hRrRHsIML+2G7eNi8ixMkv78ys/drz5E/OyLCvVJem99COMyIOV7
	+BmkgBK4Co/B+Xfi+fCyCEsuqrnv9AIO4BKzPgbaqb0EYQhG5WRGrvfFZImXr9vf1I1O16hMvNpkz
	0pq4H4M6RVFMuIav4kAatLBYusP/DLR9Lf2EiPNSOawV7r7uUiQVsoyU7FxM7DJ/z62Y5SVAdhOdC
	bRV96ANw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37330)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ruXfv-0007yD-1O;
	Wed, 10 Apr 2024 14:07:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ruXfs-000601-Be; Wed, 10 Apr 2024 14:07:36 +0100
Date: Wed, 10 Apr 2024 14:07:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org, guyinggang@loongson.cn,
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v10 6/6] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <ZhaPGO77dcYxiqqA@shell.armlinux.org.uk>
References: <cover.1712668711.git.siyanteng@loongson.cn>
 <77daabe9ca5c62168d9e54a81b5822e9b898eeb3.1712668711.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77daabe9ca5c62168d9e54a81b5822e9b898eeb3.1712668711.git.siyanteng@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 09, 2024 at 10:04:34PM +0800, Yanteng Si wrote:
> +	/* The GMAC device with PCI ID 7a03 does not support any pause mode.
> +	 * The GNET device (only LS7A2000) does not support half-duplex.
> +	 */
> +	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
> +		priv->hw->link.caps = MAC_10FD | MAC_100FD |
> +			MAC_1000FD;
> +	} else {

I'm sorry, but what follows looks totally broken to me.

> +		priv->hw->link.caps = (MAC_ASYM_PAUSE |
> +			MAC_SYM_PAUSE | MAC_10FD | MAC_100FD | MAC_1000FD);

Parens not required.

This sets 10Mbps full duplex, 100Mbps full duplex, 1000Mbps full duplex.
It does *not* set 10Mbps half duplex, 100Mbps half duplex, nor 1000Mbps
half duplex.

> +
> +		if (loongson_gmac == DWMAC_CORE_3_70) {
> +			priv->hw->link.caps &= ~(MAC_10HD |
> +				MAC_100HD | MAC_1000HD);
> +		}

Braces not required.

This clears 10Mbps half duplex, 100Mbps half duplex, 1000Mbps half
duplex, all of which were _NOT_ set. Therefore this code as written
can be entirely deleted.

Alternatively, this code is completely untested and is functionally
incorrect.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

