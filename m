Return-Path: <netdev+bounces-197980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A229ADAC1C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A86D1891DE5
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1DF27056D;
	Mon, 16 Jun 2025 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="v6n1I2wC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622D1DB92A
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750066720; cv=none; b=t2wxRzoJbvSWG+3InRqZRhvXz66Emo9alN8tfYUGjzS35dg883SOGjJUmxOkoUv2YJzHXSZn/reL9MgUOMLeHjDdObZkH1V0cYWWQHjcV40d3i30QoMEjcOiX42qnsvNk4j/aT25oUO8BauIMpt44VS1BibZlst8u+0VOyX3YA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750066720; c=relaxed/simple;
	bh=aPpR4JxWD7Qv1AsVPXBKR+ELanX70Syb89jNQzb+4gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOhKzBrtkK6mrBm+Lulr4SfvQ89uBgPJ/lTLlzQQxUqyIlKjRzTvbCaYEo+P1enNp21LcbW6C04zoKYvpUgk6aU1xVeWlhm7rugU2YfMEOhRkLFWgl3bjPcZUnPHezeHYBbbWHBxSTFbJPSmu7gLH8c//RSIFBfPD9CSOwUjhII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=v6n1I2wC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ymazMNkqSjKHhIcuupucvEPaklDWpQFzUKopMt7Nkek=; b=v6n1I2wCFp4HbcFIdXNWh4VXnU
	COxNbX0BAxKbmmikc1p5BVe9RUh3bPzpO/3U7GCMtmm4Ekhc1GYgdKd6xHMPEo0ot0MTJZv0Y+dXp
	4xZzbYE4Zd6C0+M+bBUbJZK0+YXLAxaWWRYj9xWFptLe53LsDdXTBu82lHn9MWQoU8BiTk3qdy3a+
	64Q1m4LtOsL/+uVb4CYnXZ3OREqIH+j64J36jnfv5HMrC7jAlYHsKyrg4WXpcZqje6Kv5+38nyu7H
	btGNWOzJWXqKLTwx4HOT8GA8gfuLrPOPHKYpxKXuppZzU+yA0JPQiKdTD0ZF33SPub05sSsrLb7+1
	9osRVVGA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37044)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uR6IS-0003W9-0d;
	Mon, 16 Jun 2025 10:38:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uR6IP-0004hM-1k;
	Mon, 16 Jun 2025 10:38:29 +0100
Date: Mon, 16 Jun 2025 10:38:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v3] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID: <aE_mFWgIuuIn06E3@shell.armlinux.org.uk>
References: <20250613171002.50749-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613171002.50749-1-macroalpha82@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 13, 2025 at 12:10:02PM -0500, Chris Morgan wrote:
> @@ -409,7 +414,19 @@ static void sfp_fixup_halny_gsfp(struct sfp *sfp)
>  	 * these are possibly used for other purposes on this
>  	 * module, e.g. a serial port.
>  	 */
> -	sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
> +	sfp_fixup_ignore_hw(sfp, (SFP_F_TX_FAULT | SFP_F_LOS));
> +}
> +
> +static void sfp_fixup_potron(struct sfp *sfp)
> +{
> +	/*
> +	 * The TX_FAULT and LOS pins on this device are used for serial
> +	 * communication, so ignore them. Additionally, provide extra
> +	 * time for this device to fully start up.
> +	 */
> +
> +	sfp_fixup_long_startup(sfp);
> +	sfp_fixup_ignore_hw(sfp, (SFP_F_TX_FAULT | SFP_F_LOS));

There's no need for parens around the second argument to
sfp_fixup_ignore_hw() - the bitwise OR is unambiguous.

Apart from that, the patch looks fine, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

