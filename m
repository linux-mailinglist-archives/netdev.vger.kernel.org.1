Return-Path: <netdev+bounces-236383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 662E2C3B7E7
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB6C54E64F2
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792430498E;
	Thu,  6 Nov 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xwrZVP0K"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20CA302154
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437077; cv=none; b=sVYUx4+vUk1bCQzaOJzkyOV9wQ9y79AHxXHF/QMwqv7DSumma9+e/VRr+jLG5RwgyAmNdabb9lMWg3I5Gg8JbcSzLU32CkUwBricSNK/RTQEr/0PhR/PANssIQiIa+vrU7EuxbnOYf4WyyUFecJWg3b/6tWYKExPoxiGvGqge8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437077; c=relaxed/simple;
	bh=lNZ7cDEacb1sKH41jeG3cuHQYfHlxDDC1O5D3swx8f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtPV9+o7xY6Nq+U4ouyxJ38grwudQ3422+BHx8bjBJaGpIOqGJuGSQ+OG/Pbvbyy2/91tqluvE83TofDkCyTYPDPeiVZdOCzQG5yQ/Ffbsq5vLNfZSKT4V9RCjqhvd4jt1hLoWf7LcQC4wdmJHxTs2Ll4ZVNvOzDmTCOtBceA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xwrZVP0K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dkPwGC21Kh1kNjLh4HXPM2wpkTKaBCrL6p4Nq918o9Y=; b=xwrZVP0KlSsDTiKT881zf0ltOr
	+ZF+JjyZ71uq310x+joa/gIKaTM4DD0mRq0Q2hAXhjYhMGjUiJuXy8oqY5WVHZ+xcDUYtjtqNUaKU
	Z3LCFcyVcv5q03hflfjDtX+G5Ct85d67GxR+pXMrrkWjqaykTR/PdTefdDJfdQS+lcVA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vH0OO-00D7Zp-5L; Thu, 06 Nov 2025 14:51:12 +0100
Date: Thu, 6 Nov 2025 14:51:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH net-next 1/3] net: phy: realtek: eliminate priv->phycr2
 variable
Message-ID: <07183d23-c766-4ab5-962a-76ed4f5b99f0@lunn.ch>
References: <20251106111003.37023-1-vladimir.oltean@nxp.com>
 <20251106111003.37023-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106111003.37023-2-vladimir.oltean@nxp.com>

> +static int rtl8211f_disable_clk_out(struct phy_device *phydev)
> +{
> +	struct rtl821x_priv *priv = phydev->priv;
> +
> +	/* The value is preserved if the device tree property is absent */
> +	if (!priv->disable_clk_out)
> +		return 0;

The name rtl8211f_disable_clk_out() suggests that it is going to
disable the clock output. In fact it is conditional, and might not
actually do anything. Maybe move the condition outside? Or maybe
rename it to rtl8211f_config_clk_out()?

	Andrew

