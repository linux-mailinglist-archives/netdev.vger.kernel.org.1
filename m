Return-Path: <netdev+bounces-150599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FE19EAD9A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5811281251
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115523DE8D;
	Tue, 10 Dec 2024 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jzo3kiPA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6440A23DE8B
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825280; cv=none; b=IFCawnEJj6p8vXRGt390JNxUKbUqWg8HBQsZ6Gyk/kCz3pQNX/EkDwMSaGuY2W/CNXWOTFHAXzzhSTZ78ebMMkr7ymC70lGme6CPc9UYETMoCtQZMvk2IMckQp4e0cEm0Xex6FEKcqdDtgN2szfjZOa6OQwOuvbxrrF+H/98+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825280; c=relaxed/simple;
	bh=Etk6CQR8t3uuzE6vQBHucygJu69P7QEY7ENsv30vlJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHcMJxfkJMO8cEnuoKEaE7erbK6DO0FYdM99QLWjktWzUGLWnW7Qps1gu856SgLDOm3hBtsLN+9szFnsPRz/XZDX293ykIRrJmTe/ZkxpJ/uByk8SAL2meKVbJj9ipmG2EsHbj7ajNSLNvtdQMKEw7C5JK8SSyShHVs8OljeAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jzo3kiPA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LVjeayApJ81qDaZGVW+1kd92qagFmnj64icguj1qRT0=; b=jzo3kiPAhmY72VPIRdUbS3/H4p
	lJYzvwFTFwaObCGoyJ1C2SNKUqen6hyrQFOjywkQbqgnpQYVEH5TFrBEJPI3kUHy6M6jKBZdDTC/3
	H+1ZVYMrj2BCOUWfKK+bJWXY6dxHOht+lSTQ3zqIhb/12XzcitJRfXvJ3dfLH+Q9p3qV8ar4ONwO+
	bSpnez36ssDEG2m/n+91kym5dtMoiOPAW3bUtz9n5hzXloFuIs53RJtOl8c7aCYa/LZeDFEXFtp10
	SAjlUDyB4sxVKw2/8XSRV8xN5YGGF1vZf0yn69xddTDF5atmG3x0PDh6O5YTijWu4WRHAKLfeqFaf
	WScgv1sg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50168)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tKx9j-00028Q-1R;
	Tue, 10 Dec 2024 10:07:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tKx9h-0002rl-2f;
	Tue, 10 Dec 2024 10:07:49 +0000
Date: Tue, 10 Dec 2024 10:07:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 10/10] net: lan743x: convert to phylink managed
 EEE
Message-ID: <Z1gS9eCXQM6QXKKf@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKeg8-006SNJ-4Q@rmk-PC.armlinux.org.uk>
 <49dd18b9-5ffa-4726-a3c5-02e1ef90f04c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49dd18b9-5ffa-4726-a3c5-02e1ef90f04c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 10, 2024 at 04:37:27AM +0100, Andrew Lunn wrote:
> > +	adapter->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
> 
> Is EEE not defined for 10Mbps?

According to 802.3, 10BASE-Te supports it. Phylib only has support for
10BASE-T1L (not mentioned in my 802.3 copy) using it, and I don't think
LAN743x is used with such PHYs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

