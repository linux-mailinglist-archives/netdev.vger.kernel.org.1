Return-Path: <netdev+bounces-197990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E3BADAC73
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B4E3A6580
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA7D26E718;
	Mon, 16 Jun 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q9pH0txw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB85272E48
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067646; cv=none; b=ExEoKGfKi2+sU1YdvgO5O68estZBu+CJvjBnWLufF86HfLJXA/UY32mZ9lxZdHunv6it5Toz5kWw/8cNFsEaIHX8+Y7oUAKVZ3LZ0pROIjtHf1lJyBQZRucg2tmF18s6QZPHMav5IrIlYdKl4B9EWnKI5V4f9KP9IO/bs7NVUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067646; c=relaxed/simple;
	bh=UcboFpRIDvTgyY8F8gep893lL/RoFNU4Lr4lwCqgTog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgRIl+ZYCZyXv5hGGmSW7WFsrusQVFvisC/6iTt3/5RSXQ+LbqkuKDYV+wDPwr4Cxji7QHYtvMPX1jI9eArMZxyDjD48daWNVlks4p/ezQixJzz/ZYt+sjJG1V+HS3hlAoIwSpTDdSBthMpzYWu96s5DrI+q/6prKNhaJp7BZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=q9pH0txw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PQLRJj21WoHRMNwesijYpTUp8BJF+HSJRoZj1m2T2Jg=; b=q9pH0txwZu3dz/3Kzfbar0l8rn
	SR+N45aZz2LKf6pJ3sacGHGz5vU9vBhfAVC3Iupi8KwYwvpLFqEY/5jNV3PCbzNinu5WVf2WiG8Lx
	56NriIHWHJrDTo9Ie6LG4VmO3IUnLY5thSDX0ATaJ0o+EFNKakBN07xwv6pKyk2UofqrBMyC0ruuI
	JAbero2oDUmAuc0SnEbrsUQHGu/QaiEME23yORvptamGjQLghH3+fTJA+66k6asPbS7YQjOOGT2rS
	vK6cXOBrUhbtwhMwOZKbZ3o8gvzpOAqS+G3VmooJrykCDYCOazebT4m8tUIDLlU34ul6ck+b0W2Gp
	SDxj7M0A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37464)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uR6XO-0003Xp-2r;
	Mon, 16 Jun 2025 10:53:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uR6XN-0004ic-1m;
	Mon, 16 Jun 2025 10:53:57 +0100
Date: Mon, 16 Jun 2025 10:53:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: phy: improve phy_driver_is_genphy
Message-ID: <aE_ptXbQQTuuYKv2@shell.armlinux.org.uk>
References: <5778e86e-dd54-4388-b824-6132729ad481@gmail.com>
 <c9ac3a7d-262a-425d-9153-97fe3ca6280a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ac3a7d-262a-425d-9153-97fe3ca6280a@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jun 14, 2025 at 10:31:57PM +0200, Heiner Kallweit wrote:
> Use new flag phydev->is_genphy_driven to simplify this function.
> Note that this includes a minor functional change:
> Now this function returns true if ANY of the genphy drivers
> is bound to the PHY device.
> 
> We have only one user in DSA driver mt7530, and there the
> functional change doesn't matter.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

