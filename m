Return-Path: <netdev+bounces-223004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4E5B57763
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35D67A7496
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2032FF157;
	Mon, 15 Sep 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKj7OZ+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFAD2FF148;
	Mon, 15 Sep 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934007; cv=none; b=U+bhOghnP5AyVgJqr+DPsO+Iii3nibBZzZCjHl14+YRg1c2BI0xHA07pI8FoT/G/WBOlVW8ZXgoCrefdso7eBxZAmK0PTgHFUsQrasfDM09rLU0mhIggdd1dfCo0AAxrDDwgodl8BzqBSueceaRwqplboK8VuDu+/HywGKsZ35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934007; c=relaxed/simple;
	bh=PerGZdKHuMGnY9aDIA1/uc0lypV/nccNhLa+jYy3h44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcVqR9mwgQfPYQJYwUC3CWBO/xs7vUOQa63oRwokBET1E7+SHslRUv+fDhPqwNoepR/6CsDRGIyrQRIXGWpDwNXC8G0jObzbFiSFqCObK9EySDlvOWrJGSjgjiIR7foCJOiuk5ayPmCj/PpAT1B6x9MMULU3p1zrGJgOLNFmuc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKj7OZ+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2497C4CEF7;
	Mon, 15 Sep 2025 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757934007;
	bh=PerGZdKHuMGnY9aDIA1/uc0lypV/nccNhLa+jYy3h44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKj7OZ+iabb40dJ6272w4HO91BTJ7gyrHEgVNYSCzys9bsDy8XfW1Hl6NXIc3fz1l
	 9wq+oIghMgkNTzqc6xk04OIgvPgKUpOn+7rJcTlR+yqqYVV3jvbyzj/99IRJIwGkaN
	 snmbbap/HvfDKyAGKTCXn0ncjPExex0PTx3EI/Q0CMT6//P5yXECHBYZIEavvlVyjd
	 nDa1aWqX5kpsViJc8siV3AJ1O4waANIXmHXmrygu/Zajap/uqmROSSGIVsbIqHc4Fa
	 76dAylXvHlOkpuBS/jk/904PqZ1FVwmrq7A1ElRIHDIOcoTsVl/VC38PD0nUJGDJvG
	 65OAXMrzvpjZw==
Date: Mon, 15 Sep 2025 12:00:00 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v17 6/8] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20250915110000.GS224143@horms.kernel.org>
References: <20250911133929.30874-1-ansuelsmth@gmail.com>
 <20250911133929.30874-7-ansuelsmth@gmail.com>
 <20250913130137.GL224143@horms.kernel.org>
 <68c56bea.050a0220.a9dbf.b7c8@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c56bea.050a0220.a9dbf.b7c8@mx.google.com>

On Sat, Sep 13, 2025 at 03:04:40PM +0200, Christian Marangi wrote:
> On Sat, Sep 13, 2025 at 02:01:37PM +0100, Simon Horman wrote:
> > On Thu, Sep 11, 2025 at 03:39:21PM +0200, Christian Marangi wrote:
> > > Add support for Airoha AN8855 Switch MFD that provide support for a DSA
> > > switch and a NVMEM provider.
> > > 
> > > Also make use of the mdio-regmap driver and register a regmap for each
> > > internal PHY of the switch.
> > > This is needed to handle the double usage of the PHYs as both PHY and
> > > Switch accessor.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/mfd/airoha-an8855.c b/drivers/mfd/airoha-an8855.c
> > 
> > ...
> > 
> > > +static int an855_mdio_register(struct device *dev, struct an8855_core_priv *priv)
> > > +{
> > > +	struct device_node *mdio_np;
> > > +	int ret;
> > > +
> > > +	mdio_np = of_get_child_by_name(dev->of_node, "mdio");
> > > +	if (!mdio_np)
> > > +		return -ENODEV;
> > > +
> > > +	for_each_available_child_of_node_scoped(mdio_np, phy_np) {
> > > +		ret = an8855_phy_register(dev, priv, phy_np);
> > > +		if (ret)
> > > +			break;
> > > +	}
> > 
> > Hi Christian,
> > 
> > Maybe it cannot happen, but if the loop above iterates zero times,
> > then ret will be used uninitialised below.
> > 
> > Flagged by Smatch.
> >
> 
> Do you have hint of how to run smatch on this? Is there a simple arg to
> make to enable this?

Perhaps not so simple, but also not so difficult.

1. Checkout Smatch from and compile

   Smatch can be found in Git here:
   https://github.com/error27/smatch/commits/master/

2. Prepare kernel

   e.g. make allmodconfig

3. Run Smatch

   PATH="$PATH:.../smatch/bin" \
   .../smatch/smatch_scripts/kchecker drivers/mfd/airoha-an8855.o
   [ snip ]
   drivers/mfd/airoha-an8855.c:439 an855_mdio_register() error: uninitialized symbol 'ret'.

> Anyway yes it goes against schema but it's possible somehow to have a
> very broken DT node with no phy in it.

Understood, thanks.

...

