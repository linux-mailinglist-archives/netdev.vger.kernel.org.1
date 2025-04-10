Return-Path: <netdev+bounces-181364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C66A84ABA
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E70178F76
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710471EF376;
	Thu, 10 Apr 2025 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xmuRXX4c"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2AB1D5CE8;
	Thu, 10 Apr 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304972; cv=none; b=ZPsM4u7LkWVGM1j2V3ykaFBywrHCtG8veocLyJVPLMPnJmxAUS1ecGaCzNCr0CQMrC2qQPUKZBFdrrxF17z8eh0XBBkh2BwZTR5vMZMgEl7eDOE5454IZV2vO/iYSflszz3TcvK/7XUJUjPIvIpAevAb0izfKLfOp2ux3IEkjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304972; c=relaxed/simple;
	bh=Ug4lEjA1gs4L+Ah+ss6ctQKV51r9X17j7n35KVsDUXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2ZKhyo/lv3FfLK5e/0PJWfB1rSAVGElQ/gLzJ0fgC4Lman+8sSqwssZ3Yb2YH2gIjS29l9hjlzJeHBMf07WNFBBg6YgCCDFNdIx6eeCxESi49KE0yOcCvqlL+tp4X1yZbpdBPh2/XQPDozPqq/mN8MhDDOZeAG5O34mLk+lynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xmuRXX4c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=amQTBAOZwMkJ1j1LtN/s0dLA/fANsCSGlX6qX2vDPVo=; b=xmuRXX4ckQGKPcGs/K603KyGOs
	QmoAeM637i5YHNIvTohfYiqLxX93Z3FRa6YXYpZ3sxWZQaV+btppFVPLy85jiSRgABw3vFLLBk6LK
	xaO/iLPaVu5lFyziZmfyk26lo31+TSjMFLJb1ZwR28icKNlvd1R5aSjMBK+W8E6ffK54=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2vOX-008i2l-LS; Thu, 10 Apr 2025 19:08:53 +0200
Date: Thu, 10 Apr 2025 19:08:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v14 07/16] net: mdio: regmap: add support for
 C45 read/write
Message-ID: <50c7328d-b8f7-4b07-9e34-6d7c34923335@lunn.ch>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
 <20250408095139.51659-8-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408095139.51659-8-ansuelsmth@gmail.com>

On Tue, Apr 08, 2025 at 11:51:14AM +0200, Christian Marangi wrote:
> Add support for C45 read/write for mdio regmap. This can be done
> by enabling the support_encoded_addr bool in mdio regmap config and by
> using the new API devm_mdio_regmap_init to init a regmap.
> 
> To support C45, additional info needs to be appended to the regmap
> address passed to regmap OPs.
> 
> The logic applied to the regmap address value:
> - First the regnum value (20, 16)
> - Second the devnum value (25, 21)
> - A bit to signal if it's C45 (26)
> 
> devm_mdio_regmap_init MUST be used to register a regmap for this to
> correctly handle internally the encode/decode of the address.
> 
> Drivers needs to define a mdio_regmap_init_config where an optional regmap
> name can be defined and MUST define C22 OPs (mdio_read/write).
> To support C45 operation also C45 OPs (mdio_read/write_c45).
> 
> The regmap from devm_mdio_regmap_init will internally decode the encoded
> regmap address and extract the various info (addr, devnum if C45 and
> regnum). It will then call the related OP and pass the extracted values to
> the function.
> 
> Example for a C45 read operation:
> - With an encoded address with C45 bit enabled, it will call the
>   .mdio_read_c45 and addr, devnum and regnum will be passed.
>   .mdio_read_c45 will then return the val and val will be stored in the
>   regmap_read pointer and will return 0. If .mdio_read_c45 returns
>   any error, then the regmap_read will return such error.
> 
> With support_encoded_addr enabled, also C22 will encode the address in
> the regmap address and .mdio_read/write will called accordingly similar
> to C45 operation.

This patchset needs pulling apart, there are two many things going on.

You are adding at least two different features here. The current code
only supports a single device on the bus, and it assumes the regmap
provider knows what device that is. That is probably because all
current users only have a single device. You now appear to want to
pass that address to the regmap provider. I don't see the need for
that, since it is still a single device on the bus. So adding this
feature on its own, with a good commit message, will explain that.

You want to add C45 support. So that is another patch.

C22 and C45 are different address spaces. To me, it seems logical to
have different regmaps. That makes the regmap provider simpler. A C22
regmap provider probably is just a straight access. A C45 regmap
provider might need to handle the hardware having a sparse register
map, only some of these 32 block of 65536 are implemented, etc.

So i think:

struct mdio_regmap_config {
        struct device *parent;
        struct regmap *regmap;
        char name[MII_BUS_ID_SIZE];
        u8 valid_addr;
        bool autoscan;
};

should be extended with a second regmap, used for C45.

	Andrew

