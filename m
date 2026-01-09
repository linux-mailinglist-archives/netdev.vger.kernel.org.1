Return-Path: <netdev+bounces-248550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3193D0B3EB
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 17:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E0430D32BD
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BA231A547;
	Fri,  9 Jan 2026 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u+GwY04C"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79093128C7;
	Fri,  9 Jan 2026 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975708; cv=none; b=Uwz4/yVxCXrJGRTZ3fzSjcoDMTxv3M86aB/HCzcoDEYz5MpwZSEaFhUt54ZPJKok4cF6fjEzURqhdnqil4LtvVKCNFL/I3aQT7faiCTi1g5J9ZEpNm8oiiPG7+ArdSe9DuRHzpuISLLiGXQW8iYpsYZ6y4mDt9+AIocZReYSilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975708; c=relaxed/simple;
	bh=JHf7XjqDxz+HBu4lmMwAulX2JgUiNemGA0gF/Q2GtGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8K4DrDus517E1ghfWSwalR/lrQ7y93Erg2JyuoFKgNBZX6gxeRLPVnur3jTex9b/oc3a2HLcGYuqkN7a/azewHEpCIATi5oJmxGwLpfEq8U3ve1uf0JbqtygJ64USq8ce7Ltenz/pjuMNI4572h1966BteAsst856eBX4apF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=u+GwY04C; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gEXWYjUfV4aieZNmTH6njmEjvqBEOJCTz/56ibrDc1g=; b=u+GwY04Czf5tiOJziF7EKbS4R5
	TCbJ76RNFno0KKV6/G3lXXehrXvd+C2SgRjqPGfHUmiiO7Lkos7riH854W9h4OioY7DomhhKM5A/g
	ptVWbDkFUIOltdSs+/k1Vi+Yw+VKoetasTkKrFq6zRV2ZG6iCVgjoSGzYN7pSm1V01iuZigqBvIHZ
	nzLfpq5ULrC4hKQqfQyJ8tNKwpy0GMErWVCqpcxBiCLts1lVpakvywANbH8QOTe4MPwvzsCEr+EGk
	tFfWC7iYyEzG/tH1Bjd6ZBHQW1SWHcCFQ9cBB+YnbW8vVqBFzZtn3qtyW0XubvqQp3r6lDrK+QAeX
	vPaSgE7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44010)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1veFF7-0000000043b-1Z0s;
	Fri, 09 Jan 2026 16:21:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1veFF5-000000003Rv-0thW;
	Fri, 09 Jan 2026 16:21:39 +0000
Date: Fri, 9 Jan 2026 16:21:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4] net: sfp: add SMBus I2C block support
Message-ID: <aWErEyV8UhemgiRy@shell.armlinux.org.uk>
References: <20260109101321.2804-1-jelonek.jonas@gmail.com>
 <aWDw0nbcZUaJnCQX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWDw0nbcZUaJnCQX@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 09, 2026 at 12:13:06PM +0000, Russell King (Oracle) wrote:
> On Fri, Jan 09, 2026 at 10:13:21AM +0000, Jonas Jelonek wrote:
> > Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
> > added support for SMBus-only controllers for module access. However,
> > this is restricted to single-byte accesses and has the implication that
> > hwmon is disabled (due to missing atomicity of 16-bit accesses) and
> > warnings are printed.
> > 
> > There are probably a lot of SMBus-only I2C controllers out in the wild
> > which support block reads. Right now, they don't work with SFP modules.
> > This applies - amongst others - to I2C/SMBus-only controllers in Realtek
> > longan and mango SoCs.
> > 
> > Downstream in OpenWrt, a patch similar to the abovementioned patch is
> > used for current LTS kernel 6.12. However, this uses byte-access for all
> > kinds of access and thus disregards the atomicity for wider access.
> > 
> > Introduce read/write SMBus I2C block operations to support SMBus-only
> > controllers with appropriate support for block read/write. Those
> > operations are used for all accesses if supported, otherwise the
> > single-byte operations will be used. With block reads, atomicity for
> > 16-bit reads as required by hwmon is preserved and thus, hwmon can be
> > used.
> > 
> > The implementation requires the I2C_FUNC_SMBUS_I2C_BLOCK to be
> > supported as it relies on reading a pre-defined amount of bytes.
> > This isn't intended by the official SMBus Block Read but supported by
> > several I2C controllers/drivers.
> > 
> > Support for word access is not implemented due to issues regarding
> > endianness.
> 
> I'm wondering whether we should go further with this - we implement
> byte mode SMBus support, but there is also word mode, too, which
> would solve the HWMON issues. It looks like more SMBus devices support
> word mode than I2C block mode.
> 
> So, if we're seeing more SMBus adapters being used with SFPs, maybe
> we should be thinking about a more adaptive approach to SMBus, where
> we try to do the best with the features that the SMBus adapter
> provides us.
> 
> Maybe something like:
> 
> static int sfp_smbus_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
>                            size_t len)
> {
> 	size_t this_len, transferred, total;
> 	union i2c_smbus_data smbus_data;
> 	u8 bus_addr = a2 ? 0x51 : 0x50;
> 	u32 functionality;
> 	int ret;
> 
> 	functioality = i2c_get_functionality(sfp->i2c);
> 	total = len;
> 
> 	while (len) {
> 		if (len > sfp->i2c_max_block_size)
> 			this_len = sfp->i2c_max_block_size;
> 		else
> 			this_len = len;
> 
> 		if (this_len > 2 &&
> 		    functionality & I2C_FUNC_SMBUS_READ_I2C_BLOCK) {
> 			.. use smbus i2c block mode ..
> 			transferred = this_len;
> 		} else if (this_len >= 2 &&
> 		           functionality & I2C_FUNC_SMBUS_READ_WORD_DATA) {
> 			.. use smbus word mode ..
> 			transferred = 2;
> 		} else {
> 			.. use smbus byte mode ..
> 			transferred = 1;
> 		}
> 
> 		buf += transferred;
> 		len -= transferred;
> 	}
> 
> 	return ret < 0 : ret : total - len;
> }
> 
> sfp_hwmon_probe() will do the right thing based upon i2c_block_size, so
> where only byte mode is supported, we don't get hwmon support.

I should also note that, when checking for the appropriate
functionality in sfp_i2c_configure(), we need to be careful that
we can read single bytes.

In other words, if an adapter reports that it supports smbus word data
access, we need it to also support smbus byte data access or smbus i2c
block access.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

