Return-Path: <netdev+bounces-113608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76DE93F45D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FA91C21A5B
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2BC14600D;
	Mon, 29 Jul 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0rwxMVDP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D3B1448FA;
	Mon, 29 Jul 2024 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253491; cv=none; b=MmtXbmCXoU8XjQ2Qb43n8itgSRoD79Rxn3OqtPuojgyJNtqWY5iNL0X7j47gkOJRf0bS+GnGmvMkpv+ylwSdRC2H7EfL7oE6LOtgoYK07E2LlBQ5mtFue6sUalt2LfRy79BWzO+Y/4zDZf4vruU/Zsa+S+4oEd4YvKbNRCteuDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253491; c=relaxed/simple;
	bh=Ti06r/XMSH0sbGat8+mJUkakLg/McgmwIPMyZU2BdF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFIxCfrMXBjJuUnUW4oQjp4HbtehZt9e/mCJn3cJWMOozjTa8BtemGlTK+2XcwySl3l0u7a6kbMzNh3TuTdcvFjvuXseDxm+Q70eCJ7+xt1OzAXlCi4giy8XA/mphlq/DXGjSBg8QQcShq8UJIHWc3qCQPm/MuO9e6JHdrV755c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0rwxMVDP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ha36RNBh+gI1N0zYIGKCjyTBYU6moV0YKmXSZ5w/dN8=; b=0rwxMVDPTECcTCLQSNraQAKBZy
	ksUM4TsSq4C75xehqddQoOEi6Shjsa0vxZoRgSzvh4C5QrkFEZaep6K8qFnQTOimaj7NFLNXsrAYt
	GTr7DbbvTxLWTWMZYKf5IHcQZOSQgpw/KvRRQYLaXJzXpOtS9SI0573BcZZWePp/E8uCZlZ7p7z+t
	xfIS9NNuNgR2MTroKfE/T70LNX0i9UpeUARI2GiRKh39TM9DHX510mwHBYEdadpphasWcJu1M9jE1
	T/b7UZ8WEFtc2PgH78s2DGoqDVAT0nGuV2hSN5RjwVqAVAG39CZEAIUzWxYuywjm5QmvHEcXSK7dd
	Z5M8qSGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40146)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYOno-0004AW-1Q;
	Mon, 29 Jul 2024 12:44:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYOns-0004Ic-MN; Mon, 29 Jul 2024 12:44:36 +0100
Date: Mon, 29 Jul 2024 12:44:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Frank.Sae" <Frank.Sae@motor-comm.com>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH 2/2] net: phy: Add driver for Motorcomm yt8821 2.5G
 ethernet phy
Message-ID: <ZqeApCpnq0752ZG4@shell.armlinux.org.uk>
References: <20240727092031.1108690-1-Frank.Sae@motor-comm.com>
 <fa2a7a4a-a5fc-4b05-b012-3818f65631c4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2a7a4a-a5fc-4b05-b012-3818f65631c4@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jul 27, 2024 at 01:36:25PM +0200, Andrew Lunn wrote:
> The idea of this phydev->possible_interfaces is to allow the core to
> figure out what mode is most appropriate. So i would drop the mode in
> DT, default to auto, and let the core tell you it wants 2500 BaseX if
> that is all the MAC can do.

phydev->possible_interfaces reports the bitmap of interfaces that the
PHY _will_ switch between on its MAC facing side depending on the
negotiated media-side link.

It would be nice if this driver always filled in
phydev->possible_interfaces, even if there is only one interface
when it's using rate matching.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

