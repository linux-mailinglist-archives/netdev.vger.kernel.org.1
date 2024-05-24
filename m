Return-Path: <netdev+bounces-98002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D67C8CE855
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 17:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA1A1C20D66
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4912CD81;
	Fri, 24 May 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ReUg/wOb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C712E1C2;
	Fri, 24 May 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566273; cv=none; b=Orb0e55s2fRcgUnpGM7yjYgsLx+UKosvOFghwBS3WzvnLAc5KHCf16jpRi2XIEEEA5ak7w/VwrR37jEAx6ergIiTWDBArqNpoEmzkJR9WAlZcCh0X35F2gtx9PTSTuWl5haL4RyOp4PvYuEpy9W/aNh+nQT6wKHUDsm4LqG2/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566273; c=relaxed/simple;
	bh=kfIIi857EybpxBimqI/wHunoGzeTcbPROPA9FGNUzsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvhCC768xlu7Zvpb+1Zfkoa4+Iod9ZTBOvWp5X8dC/+26/9zLmysB6OtgDQCrI7BKpEARfBkTXdlCwPse2ouSxebgWmV2VlMHtJSQ48QjLU1Jmk6vmKSG4UupAfPVdgV97D0qWNQYYOjRjuzYGWDhP4A13kdyHzHutXdOcGLBhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ReUg/wOb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=etSydXL6tXHFa81kbUBjj0DUGgJuvxzCEq1M2WtotB0=; b=ReUg/wObEt+ltc/5I9cAUEALuM
	9PHtfWthwH3KhBCBC4xjVJPC6OBRqGCSemSIJSOyn+ar8zl8+KMP9tsUptUyiLAatlbCBG2mfETJl
	4hk5nfRUanX3aS8k0btrjL4oGqVMMxeG8Z86Up2m6bbIxgldDO3TNiApdCrhbPOij9JTsfy+tgVir
	EFxp4lBXmxiwmbL1Y7ArJoGnQWFTxbPN8u3NIqRHqAA8W3fERSwgqL6x48OvZxM21xTBMt3NYJD9z
	uIrQ5xHpFSOPmJEKIVLgzwXe72zSWQMDQEQXCBN/nN+repU4XVb9IVe+Um8nv/Wz96mvpz1R53rsH
	NgoUYrRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37468)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sAXIX-0005Vl-30;
	Fri, 24 May 2024 16:57:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sAXIY-00084S-7T; Fri, 24 May 2024 16:57:38 +0100
Date: Fri, 24 May 2024 16:57:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sumang@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: micrel: Fix lan8841_config_intr after
 getting out of sleep mode
Message-ID: <ZlC48i7YxFTaDVi1@shell.armlinux.org.uk>
References: <20240524085350.359812-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524085350.359812-1-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 24, 2024 at 10:53:50AM +0200, Horatiu Vultur wrote:
> When the interrupt is enabled, the function lan8841_config_intr tries to
> clear any pending interrupts by reading the interrupt status, then
> checks the return value for errors and then continue to enable the
> interrupt. It has been seen that once the system gets out of sleep mode,
> the interrupt status has the value 0x400 meaning that the PHY detected
> that the link was in low power. That is correct value but the problem is
> that the check is wrong.  We try to check for errors but we return an
> error also in this case which is not an error. Therefore fix this by
> returning only when there is an error.
> 
> Fixes: a8f1a19d27ef ("net: micrel: Add support for lan8841 PHY")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

LGTM.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

