Return-Path: <netdev+bounces-138370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E49AD212
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7252BB260D6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8853B1CDFD1;
	Wed, 23 Oct 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QBA8zcHA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766C57C8E;
	Wed, 23 Oct 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702835; cv=none; b=GcEYL1rLXK/iSjkw5i2V5kMmLaGOMJi+v6sbA5jJHjWQP7v1PT20Ule+0Vkudw8OwLSKpQqNUyL40n7PoF5ZUQoJourReB4CbYdDlgUsX5vHJtvjDW8KttJul+GzQt9hphjkSCSlJIcSeBrQWZ6kcaN9+YqvWuYcCJPhtW00QVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702835; c=relaxed/simple;
	bh=uVTSoGK5g8Yb4xOEMl5cCsANxIRS0x2c7n5rCY/wKZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERQvVb0eKGtSlfwHlwk46QL1OBMbLan9qeYkrfRh96nAit4EEwOKUbg2kW2rphyT2HziQvd7PyVk2HPbkgoLIZt9++8oinZeyHv+agzkpAZNhYCrcZhnZmYVjeN2DB89EOg6PZiYcMrDpObw9cPMcvXqTSCsvDXCUE7UsqtpODU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QBA8zcHA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G3xGyGswdGL9dKMzc/WMvHmRdt6Zg4+8xpvLGcGRCws=; b=QBA8zcHAK4iexT+ZJ6HFXGJ+JC
	xy1znc4M4jJuQ6FV4aZLNfumq9xWcVTNY2nGHiZCRbc028iDrOTGlCBn/HTauggc2Ongx/4+3pgUR
	tNJnTNp/cp1I70aVgIUd6xNsC9qzs/rDcAx9VQNrHlzdZNnql35yc/9cynJ3PfiiniTM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3eic-00Azl0-R3; Wed, 23 Oct 2024 19:00:22 +0200
Date: Wed, 23 Oct 2024 19:00:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
Message-ID: <4ad7b2e9-ddf1-4a82-9d60-7afd1856c770@lunn.ch>
References: <20241023161958.12056-1-ansuelsmth@gmail.com>
 <20241023161958.12056-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023161958.12056-4-ansuelsmth@gmail.com>

> +static int an8855_config_init(struct phy_device *phydev)
> +{
> +	struct air_an8855_priv *priv = phydev->priv;
> +	int ret;
> +
> +	/* Enable HW auto downshift */
> +	ret = phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_EXT_PAGE);
> +	if (ret)
> +		return ret;
> +	ret = phy_set_bits(phydev, AN8855_PHY_EXT_REG_14,
> +			   AN8855_PHY_EN_DOWN_SHFIT);
> +	if (ret)
> +		return ret;
> +	ret = phy_write(phydev, AN8855_PHY_PAGE_CTRL, AN8855_PHY_NORMAL_PAGE);
> +	if (ret)
> +		return ret;

There are locking issues here, which is why we have the helpers
phy_select_page() and phy_restore_page(). The air_en8811h.c gets this
right.

Is there anything in common with the en8811h? Does it also support
downshift? Can its LED code be used here?

	   Andrew

