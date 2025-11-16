Return-Path: <netdev+bounces-238916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF7FC61102
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 08:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE35C35D442
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 07:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3125C2309B2;
	Sun, 16 Nov 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="X4gUYjDJ"
X-Original-To: netdev@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9818DF9D;
	Sun, 16 Nov 2025 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763276460; cv=none; b=ocM/78sG30AwwSWFX2gDNlBlPH79PfJnFCgM+R//ezD6STwZ1U/Uj1646VvJef7IlP+oaEWLOA5eogVhzhjlaXYQfpQ8YC9rcfuXOQVVZQhHcrBrbmnKQBP+ouzq4tR7qZEaeiHLjP06WgZtDy71v3pJGnC7hXS8PJtf+Cb9LV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763276460; c=relaxed/simple;
	bh=J7BC20v9y6muxA7zWIsS0PntbL9QfvjKU5WmEL8pum0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SgLlBYkF2XuV57oMhHN/8dxi/DVZct+BKtGSVd1A4TvQETlVbFFcFfowuKLxHi4Qxqzstb1Vz4e9944waEdX+e0C/etR0j41rGzVnwwZuxYCkJrLfphB7CrUChVV08ozBQZ8J+U0e6+lIsa4+gwbaLBvvkrLVuNw8xz6V6r4zY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=X4gUYjDJ; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1763275854;
	bh=4OnAVtevBW02I5afaz+ZH/wCDG3dkPk2kH6TQKBGVW0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=X4gUYjDJb+m9G5Sqz45Bba0yAOq+dg+NQOKwODFrIOQPIlvTmUzZzApwJwnO67v6b
	 Jh5AIFmUFEqr/meCtZegUXuxdHh6v11yx2ABnSzEzb7qDhYRXCXpglwWYn2yQp2Cb+
	 mcAzvv6ZUoBfgSg5g/avVsKR2az8ahgNfnF6SRd0=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E620B66C89;
	Sun, 16 Nov 2025 01:50:50 -0500 (EST)
Message-ID: <f40bcb32b2bb47b83705706a0a326fc8e027ee00.camel@xry111.site>
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
From: Xi Ruoyao <xry111@xry111.site>
To: Yao Zi <ziyao@disroot.org>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Frank	
 <Frank.Sae@motor-comm.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>,  Chen-Yu Tsai	 <wens@csie.org>,
 Jisheng Zhang <jszhang@kernel.org>, Furong Xu <0x1207@gmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Mingcong Bai	
 <jeffbai@aosc.io>, Runhua He <hua@aosc.io>
Date: Sun, 16 Nov 2025 14:50:48 +0800
In-Reply-To: <aRhoHJioqvfT2tEv@pie>
References: <20251111105252.53487-1-ziyao@disroot.org>
	 <20251111105252.53487-3-ziyao@disroot.org>
	 <aRMs-B2KndX-JNks@shell.armlinux.org.uk> <aRhoHJioqvfT2tEv@pie>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-15 at 11:46 +0000, Yao Zi wrote:
> On Tue, Nov 11, 2025 at 12:32:56PM +0000, Russell King (Oracle) wrote:
> > On Tue, Nov 11, 2025 at 10:52:51AM +0000, Yao Zi wrote:
> > > +	plat->bus_id		=3D pci_dev_id(pdev);
> > > +	plat->phy_addr		=3D -1;
> > > +	plat->phy_interface	=3D PHY_INTERFACE_MODE_GMII;
> > > +	plat->clk_csr		=3D STMMAC_CSR_20_35M;
> >=20
> > Could you include a comment indicating what the stmmac clock rate
> > actually is (the rate which is used to derive this divider) ? As
> > this is PCI, I'm guessing it's 33MHz, which fits with your divider
> > value.
>=20
> The divider is taken from vendor driver, and the clock path isn't
> mentioned in the datasheet, either. I don't think it's 33MHz since
> it's
> a PCIe chip, and there's no 33MHz clock supplied by PCIe.
>=20
> The datasheet[1] (Chinese website, requires login) mentions that the
> controller requires a 25MHz external clock input/oscillator to
> function,
>=20
> > 25MHz Crystal Input pin.
> >=20
> > If use external oscillator or clock from another device.
> > =C2=A0 1. When connect an external 25MHz oscillator or clock from anoth=
er
> > =C2=A0 device to XTAL_O pin, XTAL_I must be shorted to GND.
> > =C2=A0 2. When connect an external 25MHz oscillator or clock from anoth=
er
> > =C2=A0 device to XTAL_I pin, keep the XTAL_O floating.
>=20
> 25MHz fits in STMMAC_CSR_20_35M, too, so it's more likely the clock
> source.
>=20
> I don't think this guess could be confirmed without vendor's help,
> should the information be included as comment.

I used the "beep" function of a multimeter to "probe" the connectivity
of the two YT6801 chips on a XB612B0 V1.1 board.  There are two 25 MHz
oscillators on the board, each connected to a YT6801.

--=20
Xi Ruoyao <xry111@xry111.site>

