Return-Path: <netdev+bounces-97995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD28CE7FF
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 17:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0590BB22E56
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8696130E35;
	Fri, 24 May 2024 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="okzHmcqR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ACD130E30;
	Fri, 24 May 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564648; cv=none; b=jMOpzoV20h/FXIBh5ch2c2PGBiRcO6ygnzQbd8g4Ph8Hg077cZsb9Gbn3FYiWYtzXsm938ztF85Z2KF75CGRLtm9VZR4YmR94hnQ68hPbqIl9ar1Ugv/stF3iDJNsclyGzJoBfiNZ975Ik6q3Udk6RVKL09iEN3iDrgeV5spexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564648; c=relaxed/simple;
	bh=0yGXj9YD7zie9Pdv3fzW9rBZDCsZ65Mk10jNqKtwVEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKlM9yeRgjeaxGZ05T5o5RfHZyprlObR/6hr+rDv7Y87j96lLg0DHG6Zii5kyIXXJ6IGUmeXHB5pH7K51iAv3ufCtnAZUjqlS5JsNLHQ3rkTvecA6xop96QIgX2mcAef+f1TblXaaGWEsV4+Nr80nw4Q9m1tMBX+tZOQt+649Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=okzHmcqR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W9irmsizhvetz6XhwzFoRQwII9CAnr9jbjP1g2OeruY=; b=okzHmcqRT6mXcCQVt+0oosRMwV
	lIZGiRg7HYDGGBzu949LP7oXZfac7x1AodFdeVhpZ17f0CKyO/aftQSEQX7tsO54TilD3upUnOBAt
	Skpx/JSPdfGnUqPjFksbq6mi5oWgw3RaKO35ncqc7g6nK96CTH0kjhWUxgqeYWXgQcXxUt4kzS3fR
	YlXML6nnUW2JzFSgtX6qeYD3SndJfrBv/+OwG5GTAmjPbPF+PahTnFtLvzETgp5xosLuD+VEyP1dp
	22bpFF8aV51IgwUj+j9a3NriKmXNzFRL6re9Yn7e6nqKuI+vW0H9IBMccr5xiek9xwvrU3wCNln6i
	uxCcDu1w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53072)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sAWsM-0005R4-24;
	Fri, 24 May 2024 16:30:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sAWsN-00083S-Sk; Fri, 24 May 2024 16:30:35 +0100
Date: Fri, 24 May 2024 16:30:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	parthiban.veerasooran@microchip.com
Subject: Re: [PATCH net 0/1] phy: microchip_t1s: lan865x rev.b1 support
Message-ID: <ZlCym64L+T8SIjgt@shell.armlinux.org.uk>
References: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 24, 2024 at 04:07:05PM +0200, Ramón Nordin Rodriguez wrote:
> Hi,
> Let me first prepend this submission with 4 points:
> 
> * this is not in a merge-ready state
> * some code has been copied from the ongoing oa_tc6 work by Parthiban
> * this has to interop with code not yet merged (oa_tc6)
> * Microchip is looking into if rev.b0 can use the rev.b1 init procedure
> 
> The ongoing work by Parthiban Veerasooran is probably gonna get at least
> one more revision
> (https://lore.kernel.org/netdev/20240418125648.372526-1-Parthiban.Veerasooran@microchip.com/)
> 
> I'm publishing this early as it could benefit some of the discussions in
> the oa_tc6 threads, as well as giving other devs the possibility
> massaging things to a state where they can use the rev.b1 chip (rev.b0
> is eol).
> And I need feedback on how to wrap this up.
> 
> Far as I can tell the phy-driver cannot access some of the regs necessary
> for probing the hardware and performing the init/fixup without going
> over the spi interface.
> The MMDCTRL register (used with indirect access) can address
> 
> * PMA - mms 3
> * PCS - mms 2
> * Vendor specific / PLCA - mms 4
> 
> This driver needs to access mms (memory map seleector)
> * mac registers - mms 1,
> * vendor specific / PLCA - mms 4
> * vencor specific - mms 10
> 
> Far as I can tell, mms 1 and 10 are only accessible via spi. In the
> oa_tc6 patches this is enabled by the oa_tc6 framework by populating the
> mdiobus->read/write_c45 funcs.
> 
> In order to access any mms I needed I added the following change in the
> oa_tc6.c module
> 
> static int oa_tc6_get_phy_c45_mms(int devnum)
>  {
> +       if(devnum & BIT(31))
> +               return devnum & GENMASK(30, 0);
> 
> Which corresponds to the 'mms | BIT(31)' snippets in this commit, this
> is really not how things should be handled, and I need input on how to
> proceed here.

So if bit 31 of the devnum is set, then the other bits specify the
MMS instead of the MMD.

I'm not sure we want to overload the PHY interface in this way. We
have been down this path before with the MDIO bus read/write methods
being used for both C22 and C45 accesses, and it created problems,
so I don't think we want to repeat that mistake by doing the same
thing here.

There's a comment in the original patches etc about the PHY being
discovered via C22, and then not using the direct accesses to the
C45 register space. I'm wondering whether we should split
phydev->is_c45 to be phydev->probed_c45 / phydev->use_c45.

The former gets used during bus scanning and probe time to determine
how we match the device driver to the phydev. The latter gets used
_only_ to determine whether the read/write_mmd ops use direct mode
or indirect mode.

Before the driver probe is called, we should do:

	phydev->use_mmd = phydev->probed_c45;

to ensure that todays behaviour is preserved. Then, provide a
function, maybe, phy_use_direct_c45(phydev) which will set this
phydev->use_mmd flag, and phy_use_indirect_c45(phydev) which will
clear it.

phy_use_direct_c45() should also check whether the MDIO bus that
is attached supports C45 access, and return an error if not.

That will give you the ability to use the direct access method
where necessary.

There's a comment in the referred to code:

+	/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
+	 * C45 registers space. If the PHY is discovered via C22 bus protocol it
+	 * assumes it uses C22 protocol and always uses C22 registers indirect
+	 * access to access C45 registers. This is because, we don't have a
+	 * clean separation between C22/C45 register space and C22/C45 MDIO bus
+	 * protocols. Resulting, PHY C45 registers direct access can't be used
+	 * which can save multiple SPI bus access. To support this feature, PHY
+	 * drivers can set .read_mmd/.write_mmd in the PHY driver to call
+	 * .read_c45/.write_c45. Ex: drivers/net/phy/microchip_t1s.c
+	 */

which I don't really understand. It claims that C45 direct access
"saves" multiple SPI bus accesses. However, C45 indirect access
requires:

1. A C22 write to the MMD control register
2. A C22 write to the MMD data register
3. Another C22 write to the MMD control register
4. A c22 read or write to access the actual data.

Do four C22 bus transactions over SPI require more or less SPI bus
accesses than a single C45 bus transaction over SPI? I suspect not,
which makes the comment above factually incorrect.

If we have direct C45 access working, does that remove the need to
have this special bit-31 to signal MMS access requirement?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

