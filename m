Return-Path: <netdev+bounces-180875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC473A82C5C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 479F47AC772
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6A326B2CD;
	Wed,  9 Apr 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nuLZJt/o"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6BA26B955;
	Wed,  9 Apr 2025 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216217; cv=none; b=ksWegQMRVdgumRlOqI8/OM9+kcZ6U4HvnNd6oGJsA4xfOV/dEmltNcsS8MmLLLRNtuF1GgcsSEGLW9pvBUD3hdiatWjjpwCBsVlSV+fI+yC2aXwKKh1Tdgouu7LbdLlfVuyNqrH8qvBuPOog8X2G6z7XEZ39Fy1JIuCX38Vaq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216217; c=relaxed/simple;
	bh=i6SRLhtvN2maXi2hWslCEBU8ghY7zgrpV96NRr8npBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rp2purO8mNL1GCRtLVtBeXolQ+8bHRhRe4b2Ql2hh7rKiW29f3PPVy9eDswH3FtBw09xA4j9vVvRmPsa5ZL0n8s9xlhebbsxHzkZVTO6JDo+AsgytbsleRjd1ZNKc+Z7fIXzEO1GY+ZDbWDJPNvCxypHQfd9mz0wmtwiv0Gt8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nuLZJt/o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T3a3+8TqrHaUFYu63rI92mX0/x/Q+BzbMPWgEExVc8c=; b=nuLZJt/o43stOD9pHO2Un3mbKY
	a6tA1QXjeWa3Hu/qQQjO5S4Tczw08upKS/fNroVsb0H/Rb2yVYYKjLFXSLxNscBwKi9z7Qjglkokc
	nQSH9O1SrctoxxETcn4UmjxAt0mMm/yxwTi/kidtbKoEflMitCXqUq+QEMqnbpDtEir8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2YJL-008Zfd-T6; Wed, 09 Apr 2025 18:29:59 +0200
Date: Wed, 9 Apr 2025 18:29:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v6 5/6] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <29bbd0c3-a64d-4aef-a0b2-5ec4999ff7e1@lunn.ch>
References: <20250407200933.27811-1-ansuelsmth@gmail.com>
 <20250407200933.27811-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407200933.27811-6-ansuelsmth@gmail.com>

> +static int aeon_ipc_get_fw_version(struct phy_device *phydev)
> +{
> +	u16 ret_data[8], data[1];
> +	u16 ret_sts;
> +	int ret;
> +
> +	data[0] = IPC_INFO_VERSION;
> +	ret = aeon_ipc_send_msg(phydev, IPC_CMD_INFO, data,
> +				sizeof(data), &ret_sts);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_ipc_rcv_msg(phydev, ret_sts, ret_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	phydev_info(phydev, "Firmware Version: %s\n", (char *)ret_data);

Maybe don't trust the firmware to return a \0 terminated string?

> +static int as21xxx_match_phy_device(struct phy_device *phydev,
> +				    const struct phy_driver *phydrv)
> +{
> +	/* Sync parity... */
> +	ret = aeon_ipc_sync_parity(phydev, priv);
> +	if (ret)
> +		goto out;
> +
> +	/* ...and send a third NOOP cmd to wait for firmware finish loading */
> +	ret = aeon_ipc_noop(phydev, priv, &ret_sts);
> +	if (ret)
> +		goto out;
> +
> +out:
> +	mutex_destroy(&priv->ipc_lock);
> +	kfree(priv);
> +
> +	/* Return not maching anyway as PHY ID will change after
> +	 * firmware is loaded. This relies on the driver probe
> +	 * order where the first PHY driver probed is the
> +	 * generic one.
> +	 */
> +	return ret;
> +}

This is not obvious. ret is either an error code, and we want to
return it. Or it is 0 because aeon_ipc_noop() returned 0 on success.
But the code then turns that 0 success into a false, does not match.
I think this last bit needs commenting on.

With those two fixed, you can add my Reviewed-by:

    Andrew

---
pw-bot: cr


