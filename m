Return-Path: <netdev+bounces-169899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B8DA46565
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D0F7AC0D6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD921C9EE;
	Wed, 26 Feb 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Gr6mqL/5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD414A627;
	Wed, 26 Feb 2025 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584456; cv=none; b=e9ugLEIre3258HJrTNcnflpAZjNnnb/Ib4+oOmGs3tcPa2883hxwNnXDm6PrjuUieW+pi+FaytkJVaOttXpzCZbis5T7i6v7EQRSb0FpwABcAuM4I107fSIycAJJT9ECJuxKDHzJuSzQ2kQi19oWr0UgI3IoJk56O3dtYpY225o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584456; c=relaxed/simple;
	bh=R1FUb6bxmYLbBcrvmP57IaiM3Pq6YCgkP+9MQlKeXN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWECfbhDI09XIymwnX0jJQhjBuSmlC7QyMNMBQgnW6Fm6P2fajJYVlRYRKtBYHF+w3ACbSSwzL+rCbbh0Nj6KAXtSNPqXdpZTiM+VkwHHbgKIngsEXrfxAdvMhjrfNkwcBMOpxdRgbECYTEEpxRziQlaxSjiGFUWy37B2WNptt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Gr6mqL/5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IlbIe310WlqxQlCzQsZku/DHMOFOicrxArfMuFNw1Gg=; b=Gr6mqL/5KT3mi2rXH+/NzlclrA
	Lf50svvp6oZ9jNNQ6De4ANjM/sZh5i35wXkvVdJa9o3ZfmLJZz3/DFBnDykr8rGv5KuQuwiV80Xop
	V34TZm6Dq09WG63RVEvT2AzKVwUxU9afefJjx+C1s2HAyXwsFN9acOg7fDEnucngr3I174nfaFaX3
	wIunBfhAx3BdnsUigzn5R95ayXmUE9XX74HhhJVY2XAeDQRJbKrxtqtuN3/HTnD2ZKTq5Gs1nXv/V
	mimnlMLCz7dFvfWNnvaFFyaiB4md/ZjoifI6z/ttueh3w5VhSYfBePvd2Mp4VWNar3ihhB7sPkw4D
	eWG3nE2Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53160)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnJWJ-0004je-0q;
	Wed, 26 Feb 2025 15:40:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnJWF-0007DP-0q;
	Wed, 26 Feb 2025 15:40:19 +0000
Date: Wed, 26 Feb 2025 15:40:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v8 2/6] net: pcs: xpcs: re-initiate clause 37
 Auto-negotiation
Message-ID: <Z78141ZNWEYDSi5l@shell.armlinux.org.uk>
References: <20250226074837.1679988-1-yong.liang.choong@linux.intel.com>
 <20250226074837.1679988-3-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226074837.1679988-3-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 26, 2025 at 03:48:33PM +0800, Choong Yong Liang wrote:
> diff --git a/drivers/net/pcs/pcs-xpcs-wx.c b/drivers/net/pcs/pcs-xpcs-wx.c
> index fc52f7aa5f59..f73ab04d09f0 100644
> --- a/drivers/net/pcs/pcs-xpcs-wx.c
> +++ b/drivers/net/pcs/pcs-xpcs-wx.c
> @@ -172,11 +172,9 @@ int txgbe_xpcs_switch_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
>  		return 0;
>  	}
>  
> -	if (xpcs->interface == interface && !txgbe_xpcs_mode_quirk(xpcs))
> +	if (!txgbe_xpcs_mode_quirk(xpcs))
>  		return 0;
>  
> -	xpcs->interface = interface;
> -

...

> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -602,12 +602,37 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
>  		__set_bit(compat->interface, interfaces);
>  }
>  
> +static int xpcs_switch_interface_mode(struct dw_xpcs *xpcs,
> +				      phy_interface_t interface)
> +{
> +	int ret = 0;
> +
> +	if (xpcs->interface != interface) {
> +		if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
> +			ret = txgbe_xpcs_switch_mode(xpcs, interface);
> +			if (ret)
> +				return ret;

The above modification changes the functionality.

In the old code, txgbe_xpcs_switch_mode() does its work when
xpcs->interface is not the same as interface OR txgbe_xpcs_mode_quirk()
is true.

Your replacement code calls txgbe_xpcs_switch_mode() when 
xpcs->interface is not the same as interface, *and* it can do its
work when txgbe_xpcs_mode_quirk() returns true.

So, e.g. when txgbe_xpcs_mode_quirk() returns false, but the interface
changes, txgbe_xpcs_mode_quirk() used to do its work, but as a result
if your changes, it becomes a no-op.

The point of txgbe_xpcs_mode_quirk() is to always do the work if it
returns true, even if the interface mode doesn't change.

Therefore, this patch is logically incorrect, and likely breaks TXGBE.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

