Return-Path: <netdev+bounces-95705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434D08C326B
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 18:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683F71C20CA5
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900F56B72;
	Sat, 11 May 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jnWhlfqq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD01A2C17;
	Sat, 11 May 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715444232; cv=none; b=YndmwWyCxtKhu/OEyaDEyLKKjWjy9kYPXeb+us3a2+9sq3T28DkOCg5Cn8RGj+WRtU8bRgDbrpUCDKHRqaS7D49KR2gYA/9rP7YgLC6Rw0tQ4ZDcjOVn3nc4qHzRYci7DUZIEvImWjRvG9ZenlVsWhT8h3qdy83LtFxIwzusBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715444232; c=relaxed/simple;
	bh=tXeSv2dSt8ln+/90g+hFsjKKBLujNvWGP26Ef9T9YwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKCUHasyA0mxr8GnugcqcWSEQFl8V0PYW/R7XdJg0kn/2aWK0rKJCPX3TrP4epnDg4zTKBgSMCFXUcN8jZIRsj1hG5e94aJKzCWsAdOYnYzkTz53HNG1IKxlhW5xHxzMPVToCEpOxtTrymn3Pm1zHar1KMd7MEMUTwb7kSClob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jnWhlfqq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=prI6M59tLGVOP1UtYgtk3OfsC2wBi6ByiWcytpAgf6M=; b=jnWhlfqqkJq6d1vEY7gqpI7+tg
	r3tpJbN/X9jZCDCT5+2Ms6eszKvAffYV3Zt4UY+Aw5sj/nHd9vZcMhwSlA1Hf0X+ozY+KObvy/XuL
	SL2/5po73uL+EXRcKCkmvkXgyuOaIGdac4oyRzT2EECNQBAhvVoodIq7uKNSBY9SfN6A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5pP2-00FCeu-8U; Sat, 11 May 2024 18:16:52 +0200
Date: Sat, 11 May 2024 18:16:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <4ede8911-827d-4fad-b327-52c9aa7ed957@lunn.ch>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>

> +	/* This device interface is directly attached to the switch chip on
> +	 *  the SoC. Since no MDIO is present, register fixed_phy.
> +	 */
> +	brcm_priv->phy_dev =
> +		 fixed_phy_register(PHY_POLL,
> +				    &dwxgmac_brcm_fixed_phy_status, NULL);
> +	if (IS_ERR(brcm_priv->phy_dev)) {
> +		dev_err(&pdev->dev, "%s\tNo PHY/fixed_PHY found\n", __func__);
> +		return -ENODEV;
> +	}
> +	phy_attached_info(brcm_priv->phy_dev);

What switch is it? Will there be patches to extend SF2?

	Andrew


