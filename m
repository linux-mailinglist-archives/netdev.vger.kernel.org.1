Return-Path: <netdev+bounces-179170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C0A7B04E
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD0E1753BC
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4501FBEB3;
	Thu,  3 Apr 2025 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Iy0H/rss"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9D1A3165;
	Thu,  3 Apr 2025 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712304; cv=none; b=YZbC8Qlw5n3xWZg6adWfVpDRJOv3sjNHk09C+RqpYc7RFyDGp6qNAq6Djz29bfVwlyAzL/WtNwdZEMmdOxZqAo4ANswwO8X4nn5Q3hpYr4MB/uEBR67s4OFEIehobOoAegIPS2R7DVncpjFnVy91fYdoHvjsC6fsNNvjzqGfAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712304; c=relaxed/simple;
	bh=Vf+Da0nJh73QnmQaNOviZW4RMvdwcqv1ubXHJDMSPao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkvXCoZ+ayVqZ26MbZ75UsYxx0JvmDyo3RVdztPTp28jJMfkW63y2YiL9CSHUbjgx5a5HOBjp46YeD5qFprAXoVOZNbu9Iz92eN9IgydIf26U6fx+3uGdi7VxT6Ojxuf6yFI3tjT8T2nHViEkSP2h4xh9SV54O5CXCimU7piprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Iy0H/rss; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6VaocAaYXzq3AkdQCMflNa8ivfGUAvjzmVp41S6UU7E=; b=Iy0H/rssUaeMOYg1i4b/QTMuYp
	qC3nt29f6E6ZniQDui662ygBM2g7VYlQyQYR8M2ZdKNe8OnrbX30HOmFjIou4vhekynnqVxpM5A36
	3vLK0Nqmxro+5p9euI66RjpVpRgMC46H7CrBVMVEc3PKI8F+wQrd6cOg3CMyfTpE1mz1+dpuhQFqw
	tEoVfN4LZIaRACl7Uvv4gOLlhlsCEmxoNrHAPf/s87lWhVlEP3Hp5cyKq67LQISkM6O1OMOB96KSJ
	19Y1+ilgtGOpvA4+1OdNOWc0GfdYsJmItLBJ4IT+yvcRitVFIj9e/oF52sCLl66etGQXSup39h62J
	Fci6nMOw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50786)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u0RDv-0000uQ-1A;
	Thu, 03 Apr 2025 21:31:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u0RDt-00053R-27;
	Thu, 03 Apr 2025 21:31:37 +0100
Date: Thu, 3 Apr 2025 21:31:37 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, upstream@airoha.com,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [RFC net-next PATCH 10/13] net: macb: Support external PCSs
Message-ID: <Z-7wKfjhAv6CJiuz@shell.armlinux.org.uk>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
 <20250403182706.1948535-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403182706.1948535-1-sean.anderson@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 03, 2025 at 02:27:06PM -0400, Sean Anderson wrote:
> -static void macb_pcs_get_state(struct phylink_pcs *pcs,
> +static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>  			       struct phylink_link_state *state)
>  {
>  	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
>  
> -	phylink_mii_c22_pcs_decode_state(state, gem_readl(bp, PCSSTS),
> +	phylink_mii_c22_pcs_decode_state(state, neg_mode, gem_readl(bp, PCSSTS),
>  					 gem_readl(bp, PCSANLPBASE));

Looks like this should be in the previous patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

