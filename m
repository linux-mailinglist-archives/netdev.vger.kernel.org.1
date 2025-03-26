Return-Path: <netdev+bounces-177813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D58A71E0B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DA51767CD
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6A524EF7C;
	Wed, 26 Mar 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tIAaVPrl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E623E324;
	Wed, 26 Mar 2025 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012505; cv=none; b=GuEEbJGRkIjTQT0RqsNB8Z7Fp2V0yoMaeCMI2UtsX/NdjQn7Az+VQ+WgE0QGa3th66owpLwXnD0/H4GxkQvk5Z9EYk3TrH7FT1UO+ph1cgxhLzgjEsKaGJGBa0nUEzYnjhbFYTDcw/mcCLq3doUWMRFTiYgrEjUzrceu6GdyNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012505; c=relaxed/simple;
	bh=VUWIUj2hfkXI+Qy0S+bOeux5uwuJCkBDwdfH5H5+a04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF3sPpWgG8T/FhlqPCi5vVQvqZjZebGf3tZjiEZ0wtfbYiaEfb/u9AnEnu78pa6Ot0eYPOyB74c/klI48FAC/0S1ARK8KbVCaHaWeq0PfsVMbGb/S2fub5O8W96wpOu1lO6GezPJhSriGlvOHWk1o3JySxL6EF5ftxcYvfkcXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tIAaVPrl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W9NKf/8mTYUYfIRNEyzd9z7p8OnoYdqWiENexZcINQs=; b=tIAaVPrlQIYxF6Z16HmkxlO/zN
	MaqTLGdwwrT2x1RDu/stzwNSmKYIVGWk30woItxKAlJwr0+SAxQPqT2H0NlPsNZ4DNQXcm/jboLPH
	0DDitU52H/T04+xuGboip2+QSFHJhcz52keptJ5h8ASfrhiUvuu1C0OEVTcpAzDfS4gqA2hg48vcY
	xnwh9+F9DuSSDViL/8GV2DKoWjDqQFw8IMGt02IwdE/3SYlW5aTmmC+ABAhIzxAvD/mZ8EHxs8vbb
	JUtqFeELrOxuL72kYV9FhZNewMcGuQkyUHuo8PBg7NcEokKr13ADUO7Kx26NC4/ddTSSoW/yh3s81
	R9OsymiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33370)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1txVAi-0006RH-0w;
	Wed, 26 Mar 2025 18:08:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1txVAg-0004c9-0c;
	Wed, 26 Mar 2025 18:08:10 +0000
Date: Wed, 26 Mar 2025 18:08:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 2/3] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <Z-RCiWzRWbv7RlHJ@shell.armlinux.org.uk>
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-3-ansuelsmth@gmail.com>
 <dfa78876-d4a6-4226-b3d4-dbf112e001ee@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa78876-d4a6-4226-b3d4-dbf112e001ee@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 26, 2025 at 03:56:15PM +0100, Andrew Lunn wrote:
> After the firmware download, the phylib core will still have the wrong
> ID values. So you cannot use PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1).
> But what you can do is have a .match_phy_device function. It will get
> called, and it can read the real ID from the device, and perform a
> match. If it does not match return -ENODEV, and the core will try the
> next entry.

Before it returns -ENODEV, it could re-read the ID values and fill
them into struct phy_device. This would allow phylib's matching to
work.

> You either need N match_phy_device functions, one per ID value, or you
> can make use of the .driver_data in phy_driver, and place the matching
> data there.

An alternative would be to change the match_phy_device() method to
pass the phy_driver, which would allow a single match_phy_device
function to match the new hardware ID values against the PHY IDs in
the phy_driver without needing to modify the IDs in phy_device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

