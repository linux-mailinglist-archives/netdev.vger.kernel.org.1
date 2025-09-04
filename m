Return-Path: <netdev+bounces-220082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0305B4461C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103A67AA1B8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6531D244685;
	Thu,  4 Sep 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rETx9uoc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC11F2C34
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012726; cv=none; b=Vzkz4/oojIAIxSEgKLLqDQLWbU6t5mcbeKaocpaa9ZQPGx1RUS+p/4TlUeLo4+fQRhc1Kp+QkV6zzym6DPM826Hv5WbLuedu1duGsr7bpsPKV2mrJzDSS8vyln+kEGFLxliiAAhj+szPI2PjnsYT9X982uxbhLg3idUQTJDzI80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012726; c=relaxed/simple;
	bh=pu82jQngyK0R1KiBgGjTAlm1u3Ifg2Edq0tliVF+EBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkI/xA1Q/fyNdGXXJjjlXR0mmGdN+mT+whL3wVJamTlY3Wi7roz2tp1BakvXQs5ChoARdzVBTYbx3YnI0zoW8CLm7NiKJ7M7H/0h7lp1jCMuJewJj6Gpj2Wy8YLB4tSLH7XrFoGya9H3ENklSps7gIfdGe3nON2YKYzI092hNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rETx9uoc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s+45S5njtmiXLeT8cAYJUv1WcvQO6rLaUo0tJbyOMrc=; b=rETx9uoc5v1A00+e07ah69FdsR
	jsmYcx5P+FjJaBCrki6/o3W+2gcr8SaSzBz4yUkfFlcMhWc8/qqzYqXiyqud3jNmaVilqzE/t7RXL
	VrotVi7plxZnVpsBeZjFSVwjqhe6mOe02UIIdP023fI0J7PXmum6zyMaKfWj+Zjxi7DQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuFGm-007GAd-Aj; Thu, 04 Sep 2025 21:05:16 +0200
Date: Thu, 4 Sep 2025 21:05:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 09/11] net: stmmac: mdio: return clk_csr
 value from stmmac_clk_csr_set()
Message-ID: <27b0579c-ecb3-4deb-9687-ae3237e6111e@lunn.ch>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
 <E1uu8oW-00000001vpH-46zf@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uu8oW-00000001vpH-46zf@rmk-PC.armlinux.org.uk>

On Thu, Sep 04, 2025 at 01:11:40PM +0100, Russell King (Oracle) wrote:
> Return the clk_csr value from stmmac_clk_csr_set() rather than
> using priv->clk_csr, as this struct member now serves very little
> purpose. This allows us to remove priv->clk_csr.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

