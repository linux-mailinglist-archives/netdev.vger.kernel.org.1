Return-Path: <netdev+bounces-179169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAA6A7B049
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C0189B216
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013521F4CA8;
	Thu,  3 Apr 2025 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UL/+Kbaq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD58219E4;
	Thu,  3 Apr 2025 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712055; cv=none; b=q6OxMdr95JYtcBqaZsQ9UwLrZk7bXzPanhZD2LMf38MRIbggMkJnq57GMBpcRwJrjQhuVT/m9wMNZl2Yy+3jS0Syo0nIXSWRR1hKAtxEzDuVrXn38Vna2pQFs5oHduv/CyVdPiNLZFdtz9zIGeZmMLm+OH4/ij9cuNcxQwU0tSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712055; c=relaxed/simple;
	bh=z20xVVv3gTB8lJMCA/nIoSqVAYFn3QUgaQn044WvAA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrLuhhKkU1rdDjFbE6dMqSGp56+hvd8gmIp/zu8PQO99k2eT4f2juTI5KVyRbBW2PJUnXbLiBUi62eafBUnmPYroxMlsAsb3sS3r7RXL0Axl8ehrOt0DHvHoNAypt+CKhg7tnj+jb1YJP+75VUY/SYtjTkI1+/5t6uWMl/RQE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UL/+Kbaq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ikKQhOvjTFsxhuP/UUycw802kvwD0C3mBIi4Nalcuk0=; b=UL/+KbaqYkQjwWdJ/s1IhbWwr8
	CEdOBhqCajp9OPBlHlITyxVYIfTpLVzJFHSLB4ngKCbhDcJENF9PDg4bAUbBsqreZGc9IR8fw17gY
	6hoPotAgb+LuDYkgtY4XBJ2s7ujD8aJ7EFe+hj1vhYHF5JIICVMua7rK+7fs9uQb1pnSf7WfbtkfJ
	FJJKqYBjz4c95HCzZMC6iSLYQawU7yofU1w8pDOXFmJHFqrOA4MdFi+W6XK6YZ0cfJNNq6hVdpdFI
	YQb5q0ZY+1sw9SqqiopiTBwBEmyU62Q+jyi5HwnAAqwWS63KumrPKnGMeQ5vDla8ctpoRjrec0YwT
	FHPCemxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50296)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u0R9i-0000ts-2k;
	Thu, 03 Apr 2025 21:27:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u0R9e-00053J-03;
	Thu, 03 Apr 2025 21:27:14 +0100
Date: Thu, 3 Apr 2025 21:27:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>, upstream@airoha.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC net-next PATCH 07/13] net: pcs: Add Xilinx PCS driver
Message-ID: <Z-7vIbvtjIGS5hzr@shell.armlinux.org.uk>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
 <20250403181907.1947517-8-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403181907.1947517-8-sean.anderson@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 03, 2025 at 02:19:01PM -0400, Sean Anderson wrote:
> +static int xilinx_pcs_validate(struct phylink_pcs *pcs,
> +			       unsigned long *supported,
> +			       const struct phylink_link_state *state)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(xilinx_supported) = { 0 };
> +
> +	phylink_set_port_modes(xilinx_supported);
> +	phylink_set(xilinx_supported, Autoneg);
> +	phylink_set(xilinx_supported, Pause);
> +	phylink_set(xilinx_supported, Asym_Pause);
> +	switch (state->interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		/* Half duplex not supported */
> +		phylink_set(xilinx_supported, 10baseT_Full);
> +		phylink_set(xilinx_supported, 100baseT_Full);
> +		phylink_set(xilinx_supported, 1000baseT_Full);
> +		break;
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		phylink_set(xilinx_supported, 1000baseX_Full);
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		phylink_set(xilinx_supported, 2500baseX_Full);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	linkmode_and(supported, supported, xilinx_supported);
> +	return 0;

You can not assume that an interface mode implies any particular media.
For example, you can not assume that just because you have SGMII, that
the only supported media is BaseT. This has been a fundamental principle
in phylink's validation since day one.

Phylink documentation for the pcs_validate() callback states:

 * Validate the interface mode, and advertising's autoneg bit, removing any
 * media ethtool link modes that would not be supportable from the supported
 * mask. Phylink will propagate the changes to the advertising mask. See the
 * &struct phylink_mac_ops validate() method.

and if we look at the MAC ops validate (before it was removed):

- * Clear bits in the @supported and @state->advertising masks that
- * are not supportable by the MAC.
- *
- * Note that the PHY may be able to transform from one connection
- * technology to another, so, eg, don't clear 1000BaseX just
- * because the MAC is unable to BaseX mode. This is more about
- * clearing unsupported speeds and duplex settings. The port modes
- * should not be cleared; phylink_set_port_modes() will help with this.

PHYs can and do take SGMII and provide both BaseT and BaseX or BaseR
connections. A PCS that is not directly media facing can not dictate
the link modes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

