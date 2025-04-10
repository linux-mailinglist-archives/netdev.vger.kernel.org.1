Return-Path: <netdev+bounces-181073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B977A839BC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4AF8A5645
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F802040BA;
	Thu, 10 Apr 2025 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dj7FSe+k"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6253D1CA84;
	Thu, 10 Apr 2025 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267587; cv=none; b=FV2tFBn9ZNtdsUDsAilfy30hch5Ns0gI4Umv1pikfC+KWqqyXQdzP1h3auMYE2O5M7xOAwcwtf2UO8PaE97cLWQ339+VJZQyQNHp0HL9CzbbjsEBi0c9mfRUygw2zkaCMUd47JeXx+Fh/E92vGP3w8Svc2sRSDLO9ivIy5qZI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267587; c=relaxed/simple;
	bh=jGP+XMZtkwaQWFwwojb3ot3KsCcWojSYKFDlKGgxCYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jppzolpu+c1v1WDKqf3N14Hy25ws/ipSez+SYdk5dzq/EJQ4wG7XxkwNwtQTRY1Q/4dD5LffnEarbMkbJkv8tPf8ZJGPp83IiBdUVaNlsj6aDqfoJb2Q6eIpRZv7Yb7LPPvIJrrsKDXmduqtmOZcjBhfecbLNBQYaRrnclYxZ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dj7FSe+k; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB5D64435C;
	Thu, 10 Apr 2025 06:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744267582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHfbW2BwhNKtYp0DwDcnPQM1979WkjuSa3wL4YpUPVA=;
	b=Dj7FSe+kWXd23IvbZ+MSy+pec7Gjo7DJP4LDzOxce5VjGLvIS6UX7tnz07Fbv2sOsYGiH8
	LsTB5QxV2U7fToDLGpA7wJFGJhr9oG3kvS4U0YoGuE2eAy+N/1zeJ/rsEVWSv79oZwbG46
	DATvE87ImDnDaOjkUMUY2HtE36Fua6NoNfADlYSQV+t+UfdDkJJ+FfS3TKtdTNNj95VQzt
	Pkuy1FlNsUg3hd3j9WRkD70FhN3TMGK0VDfGDFvFsH48rctlSY2SPuTK+ymns7AScMV43T
	LQvaRoMg9v5qrS1z0EhaWPk7As1QOwqqTANPgzYzRSlI+8QDasNT/QNch3O15g==
Date: Thu, 10 Apr 2025 08:46:18 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Chester A.
 Unal" <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Simon
 Horman <horms@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
Subject: Re: [net-next PATCH v14 07/16] net: mdio: regmap: add support for
 C45 read/write
Message-ID: <20250410084618.43edc269@fedora.home>
In-Reply-To: <67f620a1.050a0220.347fc7.1fee@mx.google.com>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
	<20250408095139.51659-8-ansuelsmth@gmail.com>
	<20250409090751.6bc42b5b@fedora.home>
	<67f620a1.050a0220.347fc7.1fee@mx.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtoheprghnshhuvghlshhmthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkr
 hiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 9 Apr 2025 09:24:13 +0200
Christian Marangi <ansuelsmth@gmail.com> wrote:

> On Wed, Apr 09, 2025 at 09:07:51AM +0200, Maxime Chevallier wrote:
> > Hi Christian,
> > 
> > On Tue,  8 Apr 2025 11:51:14 +0200
> > Christian Marangi <ansuelsmth@gmail.com> wrote:
> >   
> > > Add support for C45 read/write for mdio regmap. This can be done
> > > by enabling the support_encoded_addr bool in mdio regmap config and by
> > > using the new API devm_mdio_regmap_init to init a regmap.
> > > 
> > > To support C45, additional info needs to be appended to the regmap
> > > address passed to regmap OPs.
> > > 
> > > The logic applied to the regmap address value:
> > > - First the regnum value (20, 16)
> > > - Second the devnum value (25, 21)
> > > - A bit to signal if it's C45 (26)
> > > 
> > > devm_mdio_regmap_init MUST be used to register a regmap for this to
> > > correctly handle internally the encode/decode of the address.
> > > 
> > > Drivers needs to define a mdio_regmap_init_config where an optional regmap
> > > name can be defined and MUST define C22 OPs (mdio_read/write).
> > > To support C45 operation also C45 OPs (mdio_read/write_c45).
> > > 
> > > The regmap from devm_mdio_regmap_init will internally decode the encoded
> > > regmap address and extract the various info (addr, devnum if C45 and
> > > regnum). It will then call the related OP and pass the extracted values to
> > > the function.
> > > 
> > > Example for a C45 read operation:
> > > - With an encoded address with C45 bit enabled, it will call the
> > >   .mdio_read_c45 and addr, devnum and regnum will be passed.
> > >   .mdio_read_c45 will then return the val and val will be stored in the
> > >   regmap_read pointer and will return 0. If .mdio_read_c45 returns
> > >   any error, then the regmap_read will return such error.
> > > 
> > > With support_encoded_addr enabled, also C22 will encode the address in
> > > the regmap address and .mdio_read/write will called accordingly similar
> > > to C45 operation.  
> > 
> > This driver's orginal goal is to address the case where we have a
> > PHY-like device that has the same register layout and behaviour as a
> > C22 PHY, but where the registers are not accesses through MDIO (MMIO
> > for example, as in altera-tse or dwmac-socfpga, or potentially SPI even
> > though  there's no example upstream).
> > 
> > What is done here is quite different, I guess it could work if we have
> > MMIO C45 phys that understand the proposed encoding, but I don't really
> > understand the dance where C45 accesses are wrapped by this mdio-regmap
> > driver into regmap accesss, but the regmap itself converts it back to
> > C45 accesses. Is it just so that it fits well with MFD ?  
> 
> The main task of this wrapping is to remove from the dev side having to
> handle the encode/decode part. regmap address is still a single value
> but if a phy is mmio mapped is difficult to support c45 since you need 3
> different values (phy id, mmd and addr)
> 
> With this implementation a c45 that is mmio mapped can implement
> whatever way he wants to configure each parameter for read/write
> operation.
> 
> Example the ecoding might be on different mask and with the additional
> function it can be reorganized following the specific mask.
> 
> > 
> > I'm not really against that, it still converts mdio access to regmap so
> > there's that, but is there a way to elaborate or document somewhere why
> > we need to do go through C45 -> regmap -> C45 instead of just
> > writing a mii_bus driver in the first place ?  
> 
> This was askek to prevent creating additional ""trivial"" mdio driver
> that would all do the same task. Since mdio-regmap was already in place
> it could have been extended with a more generic approach.

Ah yes that's the point I was missing, I've browsed more in depth and
indeed in V11 Vlad suggested to use this.

> Any hint on where to better document this?

Given the simplicity of the driver, I think this commit log is good
enough then :)

Let's go for it and hopefully this can be reused elsewhere !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

