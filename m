Return-Path: <netdev+bounces-211219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC2B1734D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6A416D525
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3767A188734;
	Thu, 31 Jul 2025 14:33:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1F84D13
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972418; cv=none; b=Ook5MM0a7kXP7fuqKt/HB4xLugnRVI6zr2i2Gl/gh9dONs2pWBXb0ovnu8pCtKm8kZhKUwIhWhdCNRpU4TcXTwbVJeU8+UbqvhVhkT4VSVgnWXNG4x7AUwk4d8qFeYkv2dIJ1t4VTp4wEKXKr2ALoBjk5pK9ZncB2mSMlydBQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972418; c=relaxed/simple;
	bh=T2+XPQAoBhIac9pKKhie4FSPP90faYGEB4ozZA6xmMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iC6EMSLB0Tb9T0008jzXXPrVKPuEvyT+ZA8v/OnqGE3Qv+XjC1eFy0xBhFCQhizb7CmNF4vtFvyDClubVH++jotVEwKxNMVgDVbIReMfyekngJpH95YDh0og3x766XOcuE77nPc49J+i/7I+IZuxJRalMTzLnTng4nKZSzRNyn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uhULX-000000003W4-1DeR;
	Thu, 31 Jul 2025 14:33:27 +0000
Date: Thu, 31 Jul 2025 15:33:17 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: markus.stockhausen@gmx.de, 'Heiner Kallweit' <hkallweit1@gmail.com>,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michael@fossekall.de,
	netdev@vger.kernel.org, jan@3e8.eu
Subject: Re: AW: [PATCH v2] net: phy: realtek: convert RTL8226-CG to c45 only
Message-ID: <aIt-rT4T7BnUZk90@pidgin.makrotopia.org>
References: <20250731054445.580474-1-markus.stockhausen@gmx.de>
 <d0e1c087-f701-402e-b842-3444fbce7f27@gmail.com>
 <059901dc0209$a817de50$f8479af0$@gmx.de>
 <aIt3Mf-_NC8HehHt@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIt3Mf-_NC8HehHt@shell.armlinux.org.uk>

On Thu, Jul 31, 2025 at 03:01:21PM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 31, 2025 at 12:55:40PM +0200, markus.stockhausen@gmx.de wrote:
> > As soon as this bit is set to one mode the bus will block most
> > accesses with the other mode. E.g. In c22 mode registers 13/14
> > are a dead end. So the only option for the bus is to limit access
> > like this.
> 
> Why would a bus implementation block access to clause 22 registers
> 13/14 when operating in clause 22 mode? Or is the above badly phrased?

No, you understood correctly. Sadly.

RealTek's MDIO controller is a highly abstracted beast, with many
assumptions regarding the meaning of each register. It is NOT a generic
MDIO host controller, but rather quite specific to the way registers are
defined for Ethernet PHYs. As such, it "offloads" things like
MMD-over-C22 as well as C22 register pages (always assuming register 0x1f
is the page selector).
Further down the road it does provide specific calls for MMD-over-C22
which the current driver is not using -- it could, however, be implemented
by intercepting access to registers 13 and 14 in the MDIO controller
driver, storing device and register addresses in the driver's priv struct
and using hardware-assisted MMD-over-C22 API when ever an MMD read or
write operation is requested (ie. the final access to MII_MMD_DATA).

A similar logic is already implemented for page selection and RealTek-specific
PHY package port selection mechanisms, see

https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/realtek/files-6.12/drivers/net/ethernet/rtl838x_eth.c;h=5c6d79d19b598bbb2f5b74c3d25f5cf3ee077096;hb=HEAD#l2084

The same could be implemented in mdio-realtek-rtl9300.c, and similarly also
MMD-over-C22 could be implemented.


