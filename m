Return-Path: <netdev+bounces-162225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D592A2641E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E293A1284
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB4D1E7C03;
	Mon,  3 Feb 2025 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="163YN5kA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D01DACB1
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612472; cv=none; b=HZ2mwD560MunnglZhSx1a+3w30/YNp+CkXrtDxX3TToCi7qJWPwd8+4X1VMmUj+J4/wZJ+LkR7QdhdDPigssdcERkTk/rEDyffpoZMm0ixzZ/+RjdGSFpUNxGYEEy8EG/LDAfjXcQ95ANYyZkJeS7Ovy96hnp88h+DovmsWTZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612472; c=relaxed/simple;
	bh=ztKiG31Luh1lQwSgv6oCtkJJB7c+HoA8kcmgb/VJFW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S97OjigUswrdusd+Ks0297WHxNk7s6QgbT8wgJjY/g1IH2sb9T+zLrJgf+6KEF5FPYPaG2T3miYj60E0HhEsRfcDGMVnW6vX9tNbKo9eGBYLpnXGHBHRhi00+elkbuy2tYSVv9FvjEMphQsYFXyHTxMkaWbFLZ2VftNUuxFIw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=163YN5kA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w6dYF4YrnPvWP9HtquT/UMp6zFz5bne6zTsmz2orqRI=; b=163YN5kAgGUvvBkTDFvDBbIamI
	VG2n8xHb0xfUdFle47rh/SEfH63/204vzX5K+iJibtqq/aAsXM3AZFubcqLHYm1qzH3XieOdtBd11
	wpItHTeEMNITD6WreoQfBjtzUNKc8G0pp779Z9SzJ9u8ygp8n7QEuN9p4M/iMn15KbDQOQTdRE8Aw
	S7fd1pEDA8tAyjqN3qG8J7pTDyG0PI7fUGEIB2r/73l3uNeNk07ebLStqTHL0+Kl4NpabEZNhjVUq
	0VjpP6nKc1PUzkTyW95rZpu2fEtASPnzBrbKT3SXMyWs7qgXJaiIUfh4pmiv8mLvls/c32FxVi48r
	eqX0qlbQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48796)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tf2WS-0001IC-0O;
	Mon, 03 Feb 2025 19:54:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tf2WP-0000e1-1P;
	Mon, 03 Feb 2025 19:54:17 +0000
Date: Mon, 3 Feb 2025 19:54:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/7] net: phy: micrel: Add loopback support
Message-ID: <Z6Ee6RDkaAeKw749@shell.armlinux.org.uk>
References: <20250203191057.46351-1-gerhard@engleder-embedded.com>
 <20250203191057.46351-4-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203191057.46351-4-gerhard@engleder-embedded.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 03, 2025 at 08:10:53PM +0100, Gerhard Engleder wrote:
> +static int ksz9031_set_loopback(struct phy_device *phydev, bool enable,
> +				int speed)
> +{
> +	u16 ctl = BMCR_LOOPBACK;
> +	int ret, val;
> +
> +	if (!enable)
> +		return genphy_loopback(phydev, enable, 0);
> +
> +	if (speed == SPEED_10 || speed == SPEED_100 || speed == SPEED_1000)
> +		phydev->speed = speed;
> +	else if (speed)
> +		return -EINVAL;
> +	phydev->duplex = DUPLEX_FULL;
> +
> +	ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
> +
> +	phy_modify(phydev, MII_BMCR, ~0, ctl);

Why do you use phy_modify() here rather than phy_write() which is
effectively what this is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

