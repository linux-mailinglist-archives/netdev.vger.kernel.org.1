Return-Path: <netdev+bounces-133573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBA199652E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25187B27F77
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC95918EFCC;
	Wed,  9 Oct 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AUB20Dct"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0939189520;
	Wed,  9 Oct 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465614; cv=none; b=MRl1FiDGONufcdvo6Ci/PMv7ZyVjVaTA+4ScYoIaiJmKViaR1oWZGTntH05/Wr/ywz6KkNMFPnjUk+ypE7sYwAX0/Ft5XeJJwgc44gmnAXPJUBum21Tfv97h9H3652FbSHbofpLLYQm4CVR6kU2edFvgIuFuirQIafAanOj8KxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465614; c=relaxed/simple;
	bh=bAMqCfrwaXqFtyx4AvFX7ZFSSTTt4lqyv0dvCuSH7Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAU4M22QIm6Uo8nrpm5Un/lRBUYUakA5hUZkjeNBBlx2j0lTA1nYfNOpCssvy+rgZCwt3TgAW6ZRNqwGjneRfc/J+Ag1DmLcmtvNUrfBiJa+RPEGjBBpFTyKrAyVWUoVCKaaEWQK8tDiC48o373YCfQ9DF4jKMuegVsc86eHT0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AUB20Dct; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H2DwZUbEHckuGa0hfYPz82REyIpT7y3SCXZ306JtGkc=; b=AUB20DcteP860IY8sIhZEjo0kT
	2SpZuG6aF/WvAMB9+18aLTw1/5nTptJoqzrUHYFtam9uqW3ybNRCxd098Li3wp2vE+FwiJfc+WeJu
	dfNJso8EKnE1OoJhLIDFxUb7Nh26UeSOHJEI2xP7JGMGmWfEk0glgDdz8PaOTKt5aKHupzzGwIW3o
	Y+HLfMYAZGWbBGsupVnW9BavfdOku/FE6cb9kM8Z/A+LioK9smPtaaa8Tk5A/1XyEPeWi3o2VfLgn
	CXjeoXlZJm41Je/rgkE62zUtF/a/1v9Dqv/DenlgaRTiOS7mBWgLDfvj74tAiwEqQ3ZNl9axBo/oa
	kzp9Dwaw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49396)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sySrO-0000Gf-09;
	Wed, 09 Oct 2024 10:19:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sySrK-0006Ar-34;
	Wed, 09 Oct 2024 10:19:55 +0100
Date: Wed, 9 Oct 2024 10:19:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [RFC PATCH net-next 4/5] net: macb: Configure High Speed Mac for
 given speed.
Message-ID: <ZwZKumS3IEy54Jsk@shell.armlinux.org.uk>
References: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
 <20241009053946.3198805-5-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009053946.3198805-5-vineeth.karumanchi@amd.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 09, 2024 at 11:09:45AM +0530, Vineeth Karumanchi wrote:
> HS Mac configuration steps:
> - Configure speed and serdes rate bits of USX_CONTROL register from
>   user specified speed in the device-tree.
> - Enable HS Mac for 5G and 10G speeds.
> - Reset RX receive path to achieve USX block lock for the
>   configured serdes rate.
> - Wait for USX block lock synchronization.
> 
> Move the initialization instances to macb_usx_pcs_link_up().

It only partly moves stuff there, creating what I can only call a mess
which probably doesn't work correctly.

Please consider the MAC and PCS as two separate boxes - register
settings controlled in one box should not be touched by the other box.

For example, macb_mac_config() now does this:

        old_ncr = ncr = macb_or_gem_readl(bp, NCR);
...
        } else if (macb_is_gem(bp)) {
...
                ncr &= ~GEM_BIT(ENABLE_HS_MAC);
...
        if (old_ncr ^ ncr)
                macb_or_gem_writel(bp, NCR, ncr);

meanwhile:

> @@ -564,14 +565,59 @@ static void macb_usx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
>  				 int duplex)
>  {
>  	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
...
> +	/* Enable HS MAC for high speeds */
> +	if (hs_mac) {
> +		config = macb_or_gem_readl(bp, NCR);
> +		config |= GEM_BIT(ENABLE_HS_MAC);
> +		macb_or_gem_writel(bp, NCR, config);
> +	}

Arguably, the time that this would happen is when the interface mode
changes which would cause a full reconfiguration and thus both of
these functions will be called, but it's not easy to follow that's
what is going on here.

It also looks like you're messing with MAC registers in the PCS code,
setting the MAC speed there. Are the PCS and MAC so integrated together
that abstracting the PCS into its own separate code block leads to
problems?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

