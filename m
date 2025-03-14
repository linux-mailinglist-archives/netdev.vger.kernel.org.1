Return-Path: <netdev+bounces-174965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB2A61AE0
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56E23BA65A
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F05C2046BE;
	Fri, 14 Mar 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SjdFy+Fq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CB1FA856;
	Fri, 14 Mar 2025 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981314; cv=none; b=PasDTMoNI631XgX3PQFZVI4Pfsl0ylCVXBbk9m8GpnH0TBdMHpe1Hb93trXvcU9arDoQ1GvF70XA2qgR7qtBBCRqr0EOMYc2G4sx1DxDf49jFf+vyFrES/pDIgRtCdWHBcKOxKuoJNA6LZcYDFVp3chx1x6Ur/8sS26viyjEt3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981314; c=relaxed/simple;
	bh=I0Iczy/ujPP+d2Q/el0NMy+Hf10Bhqea0jfRlST/8oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEhGuDvk2XzEuVckczYQ53Sh6Ljvmj2VYhYjYHrIzPknzTtIpAHlVrbVy+kUWU4pX3Y06wET1mFrz3uedSd+EHREa+1THLDyu/hcYmC7eIMwzr0zyDazMjIk0O1LSMpJHVYTdVdO9b7R/px7HcO7e+a78AnSZtsmVY4hE7Ii98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SjdFy+Fq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZSUTA5z36ql72JekD9ouDmOBEs0+WULpQCq7eoA298E=; b=SjdFy+Fq1Mqqp9/ZrB0+kU88+7
	1r5EbroNgCXtOKvAkjdplUsUIM/zYIsPWcrkuEKXEtUfc4T0or4pxqBqTcFQG4OeGMqCm/LN0NV5h
	7nybjoweSIZ2WsZN5GDJGnMHW6Ymd6cUBbFAYWSTHEBCCbYbKdasZMh+SV3gd9NCvpXU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ttAuT-005O81-8g; Fri, 14 Mar 2025 20:41:33 +0100
Date: Fri, 14 Mar 2025 20:41:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 07/13] net: mdio: regmap: add support for
 multiple valid addr
Message-ID: <0c6cb801-5592-4449-b776-a337161b3326@lunn.ch>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-8-ansuelsmth@gmail.com>
 <Z83RsW1_bzoEWheo@shell.armlinux.org.uk>
 <67cdd3c9.df0a0220.1c827e.b244@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67cdd3c9.df0a0220.1c827e.b244@mx.google.com>

On Sun, Mar 09, 2025 at 06:45:43PM +0100, Christian Marangi wrote:
> On Sun, Mar 09, 2025 at 05:36:49PM +0000, Russell King (Oracle) wrote:
> > On Sun, Mar 09, 2025 at 06:26:52PM +0100, Christian Marangi wrote:
> > > +/* If a non empty valid_addr_mask is passed, PHY address and
> > > + * read/write register are encoded in the regmap register
> > > + * by placing the register in the first 16 bits and the PHY address
> > > + * right after.
> > > + */
> > > +#define MDIO_REGMAP_PHY_ADDR		GENMASK(20, 16)
> > > +#define MDIO_REGMAP_PHY_REG		GENMASK(15, 0)
> > 
> > Clause 45 PHYs have 5 bits of PHY address, then 5 bits of mmd address,
> > and then 16 bits of register address - significant in that order. Can
> > we adjust the mask for the PHY address later to add the MMD between
> > the PHY address and register number?
> >
> 
> Honestly to future proof this, I think a good idea might be to add
> helper to encode these info and use Clause 45 format even for C22.
> Maybe we can use an extra bit to signal if the format is C22 or C45.
> 
> BIT(26) 0: C22 1:C45
> GENMASK(25, 21) PHY ADDR
> GENMASK(20, 16) MMD ADDR
> GENMASK(15, 0) REG

If you look back at older kernels, there was some helpers to do
something like this, but the C22/C45 was in bit 31. When i cleaned up
MDIO drivers to have separate C22 and C45 read/write functions, they
become redundant and they were removed. You might want to bring them
back again.

	Andrew

