Return-Path: <netdev+bounces-144085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 149C59C5888
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10B81F23369
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0F58614E;
	Tue, 12 Nov 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KudzVD96"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222BA70830;
	Tue, 12 Nov 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416661; cv=none; b=u6whhEzWgA5NfZ3MAsTVkPItEGl183CXfwVQyIclqChlZKml+om1ry9NIk6Wtgz5cRuEe3z1WjXW/w8l//NCY6gsWIyVS3wPO7NQeGyi9Gxs5VdnVTo1LIOqyS6av+TNNq3HcJ0Uhyb6YzKyLoaBZ+UIiu8LIPyoxRpQcFSSazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416661; c=relaxed/simple;
	bh=Hy4z5WjUlRhtu3VOj0IqS5AN9zRuRDI5X3Uf4Q+zVds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C68mKYzVko42QdRm6Kh96d8559aOLzCJDXt4DM/NiyvYkUUwz56oRSxcBV1lRKR0SBnr4u6J5pn3/g01V4dy3cK/LN9WiLyTn1SPfVLCfXgb24BWYHevwpgZTBlrqW+yfGMwtnWJct/mSed3CYYh/bmRMWM0hM/2IJfzpT419k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KudzVD96; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Yf/24sbBNDDoh13fZUjInsCA81I5s6NjSfUou39GZzo=; b=KudzVD96WhjqBFINviWDdpHa6r
	QGLsRhhmFYz5h85UzqrcF02t1lkbdDuRRYsT3Q2Kl+pCCe6QtmwqBIEqC9lQOjC+sGFMP+4BzUKTY
	SC2IQPSlOkMeqSssJLj70NqRqqan6sJtPQ5ABS9U1t3sl6t2W/NlfOlUa4ZkuPVvfv0Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAqYt-00D1ky-CZ; Tue, 12 Nov 2024 14:04:03 +0100
Date: Tue, 12 Nov 2024 14:04:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v1 1/2] net: phy: Introduce phy_update_eee() to
 update eee_cfg values
Message-ID: <71b6be0e-426f-4fb4-9d28-27c55d5afa51@lunn.ch>
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
 <20241112072447.3238892-2-yong.liang.choong@linux.intel.com>
 <f8ec2c77-33fa-45a8-9b6b-4be15e5f3658@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ec2c77-33fa-45a8-9b6b-4be15e5f3658@gmail.com>

On Tue, Nov 12, 2024 at 12:03:15PM +0100, Heiner Kallweit wrote:
> On 12.11.2024 08:24, Choong Yong Liang wrote:
> > The commit fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
> > introduced eee_cfg, which is used to check the existing settings against
> > the requested changes. When the 'ethtool --show-eee' command is issued,
> > it reads the values from eee_cfg. However, the 'show-eee' command does
> > not show the correct result after system boot-up, link up, and link down.
> > 
> 
> In stmmac_ethtool_op_get_eee() you have the following:
> 
> edata->tx_lpi_timer = priv->tx_lpi_timer;
> edata->tx_lpi_enabled = priv->tx_lpi_enabled;
> return phylink_ethtool_get_eee(priv->phylink, edata);
> 
> You have to call phylink_ethtool_get_eee() first, otherwise the manually
> set values will be overridden. However setting tx_lpi_enabled shouldn't
> be needed if you respect phydev->enable_tx_lpi.

I agree with Heiner here, this sounds like a bug somewhere, not
something which needs new code in phylib. Lets understand why it gives
the wrong results.

	Andrew

