Return-Path: <netdev+bounces-175051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D40BA62B4C
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 11:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DC73B7955
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BED1F5845;
	Sat, 15 Mar 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw6LRjmA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1818B499;
	Sat, 15 Mar 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742035987; cv=none; b=D5K3Mv9eAW7kqcy9lSDiWDrkn6VOu+aMRtAY3srKJWsRsCqgvlE1iQQ+uIDxA4Hc14/xVO21k7PU5jtb/x2dxQzbgR3lq54uA4Srk/YPKYWkoQiwj8MigDD1Jt5e/u9Lc0hmez4EGSz3ybfDELo90z1gxsAJPn8+01VCJIVAA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742035987; c=relaxed/simple;
	bh=BN4zYhXc4gjcqMDbT0T74F4r1a2ajeoKiyCwlCkShTo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8LD1M//BB3sB5u+sfLaEktpGhucJNGCHynxUaeDS3XZ97o3pSip4aPYi1D31qMXXAltRnyd44r7cUJJsL2bDaJi6C1kHC9vuWRAyEWXxpPt8Zb5zIkXp6GFbOiMcUBIeHiJEpAhn5eKF6GZ79ZApP6z0+2m+t2ovYhS1lZRjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw6LRjmA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso2251595e9.3;
        Sat, 15 Mar 2025 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742035983; x=1742640783; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cA52CDFt55Ctd+9FFuRNv/wOUL3w+SuZ4SAnv4Bn65c=;
        b=Gw6LRjmAf7F1E0Hf2T9iarVHUdhoSGI/EnsBhbrO9G5+0b+OqPmmg0MUIdp6PHPNq+
         hI4SpKjRd7bNYK8Y18GER2klkX1VEWZDNLSBU6Nuw+7iZni91rkDuaHzN22Vi6AGhIjJ
         3nGb7+5EaIN+CkAop1yfll74+JNfwB3spNIBOGSkikJD6UuGWa+8SJiBUzk7PRMbw1mn
         /R5/5TU1BDKFHgFp4iJmTK+irBw60jHehw6MJ07g2BSXJ7YKcZ3iWOlqgVU8uXZhy3Xy
         SUYf2Es1VRP6VdMPGOK3DEQYI+eB9I+68Svs8nPnOKP/WZaVJ4aYns8YAluEslWb+ORd
         tLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742035983; x=1742640783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cA52CDFt55Ctd+9FFuRNv/wOUL3w+SuZ4SAnv4Bn65c=;
        b=QUm6Np+plX0wojKgN2WB0mA6MzONUzUfMMQLYsREnp17PbWMKAaOdJty2tewV6t3Wi
         6PUW7kznb5GmMfuORmZX195+fvSVmbAovM1soalfmnpozmbTTOr57RnBsumTCv6vrDNJ
         OE/q6CQUjnLqkjiG0M2GEhlovqStLpDgIUwGVclR0uNEacbdIjgeEzy2MfHfelKaj3+F
         5FTI2MU3T0wP9wmaSv+lq48k7QJLCBOD8mt9iX0FHGhL9MkJBTubwiBirPHeUqjmtP+l
         22RpHdYZ0eWrZyogxfL1Eda78lNrg1cRqZbYrwix8ttdD6ryI6XNBNXfU+8uKDAaapNm
         vJZg==
X-Forwarded-Encrypted: i=1; AJvYcCWgsDx9N+bhQnR/ABpt28kks8SdE6pNNSxlkQPc0LFrHz0WLU2sb2ACdbjeTdz8yOylcM4P7MKG@vger.kernel.org, AJvYcCXVPQGz/zvZiZ11RC9JT2xnakf/Y2APN6PZw/ojOEL4U6U1V4vNGdBWQ0TPDihPh3fWzoYnDNuhX/7q@vger.kernel.org, AJvYcCXZrd+iH+tvcZ8GGuZMKsWSGqvEVydlq42P5qjOBGncp/enu6gqRDZGmgzmpnFCoCeaD4Yz5Ge6QqZRtUH4@vger.kernel.org
X-Gm-Message-State: AOJu0YykF4lM43eC3hPnkeXfCe7qPyxDHG01zMGJkHHyscCCuMwMNHb/
	sAMeS9PsJNGk1hnEYdI0VmUHBkkIXKIt9gvVTxJ9k84qti2zUjXx
X-Gm-Gg: ASbGncuoAVQfZYSxWj6ogARKSkwCNRp+uy8vDhObk/cVc6hB+++U8bG2AxZRVaW6lPt
	bSaR3Rfw6irWk9E3GVscnfdcjJal9U594RXAh1oKfKO3u+7pGt/xbfU0QP5ga0eHQi1kBl4iarh
	LTI8Qc/mnQuZu1GaGTkDDQqAc0TSBHUZf3fzFBkMyw0B61Hiuc4zdY+7o0U3AQEwA2J5HzuUwXK
	OfSOcRYcjqKJty8K03QDn483E0FFqq+vQJgHUuB9qh2oTZWN/gitPV9zsPgalFkWPdO1T57IRqV
	kpGvqB3xzyk4nmN1g7X+RNJm6AzxzbkYbYSNbjzWGU9+EGKfTFPAWJTV8zTr3mwraI2MGhhIGST
	D
X-Google-Smtp-Source: AGHT+IEr8beS2tlcDElX0jI/ofOzfq+dFurkUbet7hswYuF8zoOyMZ+cBvm5diiDA9LoZdT7hm6RLw==
X-Received: by 2002:a05:600c:4447:b0:43c:eea9:f45a with SMTP id 5b1f17b1804b1-43d1ec646demr70979815e9.4.1742035983090;
        Sat, 15 Mar 2025 03:53:03 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010e2d6sm45611095e9.38.2025.03.15.03.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 03:53:02 -0700 (PDT)
Message-ID: <67d55c0e.7b0a0220.32becc.f4d0@mx.google.com>
X-Google-Original-Message-ID: <Z9VcC_1_DF7OeWdc@Ansuel-XPS.>
Date: Sat, 15 Mar 2025 11:52:59 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 09/13] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-10-ansuelsmth@gmail.com>
 <20250314113551.GK3890718@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314113551.GK3890718@google.com>

On Fri, Mar 14, 2025 at 11:35:51AM +0000, Lee Jones wrote:
> On Sun, 09 Mar 2025, Christian Marangi wrote:
> 
> > Add support for Airoha AN8855 Switch MFD that provide support for a DSA
> 
> Drop all references to MFD.
> 
> It doesn't exist.  It is a figment of your (and my) imagination.
> 
> > switch and a NVMEM provider. Also provide support for a virtual MDIO
> > passthrough as the PHYs address for the switch are shared with the switch
> > address.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  MAINTAINERS                 |   1 +
> >  drivers/mfd/Kconfig         |  10 +
> >  drivers/mfd/Makefile        |   1 +
> >  drivers/mfd/airoha-an8855.c | 445 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 457 insertions(+)
> >  create mode 100644 drivers/mfd/airoha-an8855.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b7075425c94e..5844addbda2b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -730,6 +730,7 @@ F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
> >  F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
> >  F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> >  F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
> > +F:	drivers/mfd/airoha-an8855.c
> >  
> >  AIROHA ETHERNET DRIVER
> >  M:	Lorenzo Bianconi <lorenzo@kernel.org>
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 6b0682af6e32..1b5abe5e2694 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -53,6 +53,16 @@ config MFD_ALTERA_SYSMGR
> >  	  using regmap_mmio accesses for ARM32 parts and SMC calls to
> >  	  EL3 for ARM64 parts.
> >  
> > +config MFD_AIROHA_AN8855
> 
> Should this be EN?
>

In official internal documentation this is referenced with AN8855...

EN stands for EcoNet, Airoha then brought it so there currently a mix of
name with old driver using EN and new one AN. This switch is new enough
to use AN.

> 
> > +	tristate "Airoha AN8855 Switch MFD"
> > +	select MFD_CORE
> > +	select MDIO_DEVICE
> > +	depends on NETDEVICES && OF
> > +	help
> > +	  Support for the Airoha AN8855 Switch MFD. This is a SoC Switch
> 
> Nit: "an SoC".
> 
> What kind of switch?
> 
> > +	  that provides various peripherals. Currently it provides a
> 
> Which other peripherals?
> 
> > +	  DSA switch and a NVMEM provider.
> > +
> >  config MFD_ACT8945A
> >  	tristate "Active-semi ACT8945A"
> >  	select MFD_CORE
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 9220eaf7cf12..37677f65a981 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -8,6 +8,7 @@ obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
> >  obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
> >  obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
> >  obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
> > +obj-$(CONFIG_MFD_AIROHA_AN8855)	+= airoha-an8855.o
> >  obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
> >  obj-$(CONFIG_MFD_SM501)		+= sm501.o
> >  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
> > diff --git a/drivers/mfd/airoha-an8855.c b/drivers/mfd/airoha-an8855.c
> > new file mode 100644
> > index 000000000000..0a6440bd4118
> > --- /dev/null
> > +++ b/drivers/mfd/airoha-an8855.c
> > @@ -0,0 +1,445 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * MFD driver for Airoha AN8855 Switch
> 
> No such thing as an MFD driver.
> 
> Core is sometimes used in place of a better name.
> 
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mdio.h>
> > +#include <linux/mdio/mdio-regmap.h>
> > +#include <linux/module.h>
> > +#include <linux/phy.h>
> > +#include <linux/regmap.h>
> > +
> > +/* Register for hw trap status */
> 
> Ironically, this is probably the most readable name, yet it is the only
> one graced with a comment.  Also 'hw' is an abbreviation, so it should be
> HW or H/W or better yet hardware.
> 
> > +#define AN8855_HWTRAP			0x1000009c
> > +
> > +#define AN8855_CREV			0x10005000
> 
> Chip?
> 
> > +#define   AN8855_ID			0x8855
> 
> What kid of ID?  Chip, revision, model, serial?
> 
> > +#define AN8855_RG_GPHY_AFE_PWD		0x1028c840
> 
> No idea!
> 

There magic name are the 1:1 map of the register on the internal
documentation. Honestly it would put more harm than good to rename these
register to a more symbolic name since it would make it even harder to
find them.

> > +/* MII Registers */
> > +#define AN8855_PHY_SELECT_PAGE		0x1f
> > +#define   AN8855_PHY_PAGE		GENMASK(2, 0)
> > +#define   AN8855_PHY_PAGE_STANDARD	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x0)
> > +#define   AN8855_PHY_PAGE_EXTENDED_1	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x1)
> > +#define   AN8855_PHY_PAGE_EXTENDED_4	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x4)
> > +
> > +/* MII Registers Page 4 */
> > +#define AN8855_PBUS_MODE		0x10
> > +#define   AN8855_PBUS_MODE_ADDR_FIXED	0x0
> > +#define AN8855_PBUS_MODE_ADDR_INCR	BIT(15)
> > +#define AN8855_PBUS_WR_ADDR_HIGH	0x11
> > +#define AN8855_PBUS_WR_ADDR_LOW		0x12
> > +#define AN8855_PBUS_WR_DATA_HIGH	0x13
> > +#define AN8855_PBUS_WR_DATA_LOW		0x14
> > +#define AN8855_PBUS_RD_ADDR_HIGH	0x15
> > +#define AN8855_PBUS_RD_ADDR_LOW		0x16
> > +#define AN8855_PBUS_RD_DATA_HIGH	0x17
> > +#define AN8855_PBUS_RD_DATA_LOW		0x18
> > +
> > +struct an8855_mfd_priv {
> 
> It's not an "mfd".
> 
> > +	struct mii_bus *bus;
> > +
> > +	unsigned int switch_addr;
> > +	u16 current_page;
> > +};
> > +
> > +static const struct mfd_cell an8855_mfd_devs[] = {
> 
> "_child_" or "_sub_" or drop it entirely.
> 
> > +	{
> > +		.name = "an8855-efuse",
> > +		.of_compatible = "airoha,an8855-efuse",
> > +	}, {
> > +		.name = "an8855-switch",
> > +		.of_compatible = "airoha,an8855-switch",
> > +	}, {
> > +		.name = "an8855-mdio",
> > +		.of_compatible = "airoha,an8855-mdio",
> > +	}
> > +};
> > +
> > +static int an8855_mii_set_page(struct an8855_mfd_priv *priv, u8 phy_id,
> > +			       u8 page) __must_hold(&priv->bus->mdio_lock)
> > +{
> > +	struct mii_bus *bus = priv->bus;
> > +	int ret;
> > +
> > +	ret = __mdiobus_write(bus, phy_id, AN8855_PHY_SELECT_PAGE, page);
> 
> Calling functions with '__' is a red flag.
> 

As already explained it's an unlucky name, __ was used at times
probably to stress that this is an internal variant with no lock and
should be used ONLY when actually intended (this is the case as the
function enforce locking with the __must_hold)

> > +	if (ret < 0)
> > +		dev_err_ratelimited(&bus->dev,
> > +				    "failed to set an8855 mii page\n");
> 
> Use 100-chars if it avoids these kind of line breaks.
> 
> > +	/* Cache current page if next mii read/write is for switch */
> 
> MII here?
> 
> "this switch"?
> 
> I don't see any checks here - how do we know if it is for switch or not?
> 

Check is done in an855_regmap_phy_reset_page.

> > +	priv->current_page = page;
> > +	return ret < 0 ? ret : 0;
> 
> You already check for 'ret < 0' at the call sites, so this little dance
> is superfluous.
> 
> > +}
> > +
> > +static int an8855_mii_read32(struct mii_bus *bus, u8 phy_id, u32 reg,
> > +			     u32 *val) __must_hold(&bus->mdio_lock)
> > +{
> > +	int lo, hi, ret;
> > +
> > +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_MODE,
> > +			      AN8855_PBUS_MODE_ADDR_FIXED);
> 
> 100-chars.
> 
> > +	if (ret < 0)
> > +		goto err;
> > +
> > +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_RD_ADDR_HIGH,
> > +			      upper_16_bits(reg));
> > +	if (ret < 0)
> > +		goto err;
> 
> '\n'
> 

The idea for these operation without extra line were to pack the upper
and lower part to form the full 32bit value. But ok will split.

> > +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_RD_ADDR_LOW,
> > +			      lower_16_bits(reg));
> > +	if (ret < 0)
> > +		goto err;
> > +
> > +	hi = __mdiobus_read(bus, phy_id, AN8855_PBUS_RD_DATA_HIGH);
> > +	if (hi < 0) {
> > +		ret = hi;
> > +		goto err;
> > +	}
> 
> '\n'
> 
> > +	lo = __mdiobus_read(bus, phy_id, AN8855_PBUS_RD_DATA_LOW);
> > +	if (lo < 0) {
> > +		ret = lo;
> > +		goto err;
> > +	}
> > +
> > +	*val = ((u16)hi << 16) | ((u16)lo & 0xffff);
> > +
> > +	return 0;
> > +err:
> > +	dev_err_ratelimited(&bus->dev,
> > +			    "failed to read an8855 register\n");
> 
> dev_err() will already print out the an8855 part.
> 
> > +	return ret;
> > +}
> > +
> > +static int an8855_regmap_read(void *ctx, uint32_t reg, uint32_t *val)
> > +{
> > +	struct an8855_mfd_priv *priv = ctx;
> > +	struct mii_bus *bus = priv->bus;
> > +	u16 addr = priv->switch_addr;
> > +	int ret;
> > +
> > +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> 
> guard()?
> 

Problem is that we can't even use scoped_guard as there isn't a variant
with MUTEX_NESTED. This patch is already bit enough that I didn't want
to pollute it more for it. If it's not a problem I will send a followup
later.

> > +	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
> > +	if (ret < 0)
> > +		goto exit;
> > +
> > +	ret = an8855_mii_read32(bus, addr, reg, val);
> > +
> > +exit:
> > +	mutex_unlock(&bus->mdio_lock);
> > +
> > +	return ret < 0 ? ret : 0;
> > +}
> > +
> > +static int an8855_mii_write32(struct mii_bus *bus, u8 phy_id, u32 reg,
> > +			      u32 val) __must_hold(&bus->mdio_lock)
> > +{
> > +	int ret;
> > +
> > +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_MODE,
> > +			      AN8855_PBUS_MODE_ADDR_FIXED);
> > +	if (ret < 0)
> > +		goto err;
> > +
> > +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_ADDR_HIGH,
> > +			      upper_16_bits(reg));
> > +	if (ret < 0)
> > +		goto err;
> > +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_ADDR_LOW,
> > +			      lower_16_bits(reg));
> > +	if (ret < 0)
> > +		goto err;
> > +
> > +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_DATA_HIGH,
> > +			      upper_16_bits(val));
> > +	if (ret < 0)
> > +		goto err;
> > +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_DATA_LOW,
> > +			      lower_16_bits(val));
> > +	if (ret < 0)
> > +		goto err;
> > +
> > +	return 0;
> > +err:
> > +	dev_err_ratelimited(&bus->dev,
> > +			    "failed to write an8855 register\n");
> > +	return ret;
> > +}
> > +
> > +static int an8855_regmap_write(void *ctx, uint32_t reg, uint32_t val)
> > +{
> > +	struct an8855_mfd_priv *priv = ctx;
> > +	struct mii_bus *bus = priv->bus;
> > +	u16 addr = priv->switch_addr;
> > +	int ret;
> > +
> > +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> > +	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
> > +	if (ret < 0)
> > +		goto exit;
> > +
> > +	ret = an8855_mii_write32(bus, addr, reg, val);
> > +
> > +exit:
> > +	mutex_unlock(&bus->mdio_lock);
> > +
> > +	return ret < 0 ? ret : 0;
> 
> Doesn't the caller already expect possible >0 results?
> 
> > +}
> > +
> > +static int an8855_regmap_update_bits(void *ctx, uint32_t reg, uint32_t mask,
> > +				     uint32_t write_val)
> > +{
> > +	struct an8855_mfd_priv *priv = ctx;
> > +	struct mii_bus *bus = priv->bus;
> > +	u16 addr = priv->switch_addr;
> > +	u32 val;
> > +	int ret;
> > +
> > +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> > +	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
> > +	if (ret < 0)
> > +		goto exit;
> > +
> > +	ret = an8855_mii_read32(bus, addr, reg, &val);
> > +	if (ret < 0)
> > +		goto exit;
> > +
> > +	val &= ~mask;
> > +	val |= write_val;
> > +	ret = an8855_mii_write32(bus, addr, reg, val);
> > +
> > +exit:
> > +	mutex_unlock(&bus->mdio_lock);
> > +
> > +	return ret < 0 ? ret : 0;
> > +}
> > +
> > +static const struct regmap_range an8855_readable_ranges[] = {
> > +	regmap_reg_range(0x10000000, 0x10000fff), /* SCU */
> > +	regmap_reg_range(0x10001000, 0x10001fff), /* RBUS */
> > +	regmap_reg_range(0x10002000, 0x10002fff), /* MCU */
> > +	regmap_reg_range(0x10005000, 0x10005fff), /* SYS SCU */
> > +	regmap_reg_range(0x10007000, 0x10007fff), /* I2C Slave */
> > +	regmap_reg_range(0x10008000, 0x10008fff), /* I2C Master */
> > +	regmap_reg_range(0x10009000, 0x10009fff), /* PDMA */
> > +	regmap_reg_range(0x1000a100, 0x1000a2ff), /* General Purpose Timer */
> > +	regmap_reg_range(0x1000a200, 0x1000a2ff), /* GPU timer */
> > +	regmap_reg_range(0x1000a300, 0x1000a3ff), /* GPIO */
> > +	regmap_reg_range(0x1000a400, 0x1000a5ff), /* EFUSE */
> > +	regmap_reg_range(0x1000c000, 0x1000cfff), /* GDMP CSR */
> > +	regmap_reg_range(0x10010000, 0x1001ffff), /* GDMP SRAM */
> > +	regmap_reg_range(0x10200000, 0x10203fff), /* Switch - ARL Global */
> > +	regmap_reg_range(0x10204000, 0x10207fff), /* Switch - BMU */
> > +	regmap_reg_range(0x10208000, 0x1020bfff), /* Switch - ARL Port */
> > +	regmap_reg_range(0x1020c000, 0x1020cfff), /* Switch - SCH */
> > +	regmap_reg_range(0x10210000, 0x10213fff), /* Switch - MAC */
> > +	regmap_reg_range(0x10214000, 0x10217fff), /* Switch - MIB */
> > +	regmap_reg_range(0x10218000, 0x1021bfff), /* Switch - Port Control */
> > +	regmap_reg_range(0x1021c000, 0x1021ffff), /* Switch - TOP */
> > +	regmap_reg_range(0x10220000, 0x1022ffff), /* SerDes */
> > +	regmap_reg_range(0x10286000, 0x10286fff), /* RG Batcher */
> > +	regmap_reg_range(0x1028c000, 0x1028ffff), /* ETHER_SYS */
> > +	regmap_reg_range(0x30000000, 0x37ffffff), /* I2C EEPROM */
> > +	regmap_reg_range(0x38000000, 0x3fffffff), /* BOOT_ROM */
> > +	regmap_reg_range(0xa0000000, 0xbfffffff), /* GPHY */
> > +};
> > +
> > +static const struct regmap_access_table an8855_readable_table = {
> > +	.yes_ranges = an8855_readable_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(an8855_readable_ranges),
> > +};
> > +
> > +static const struct regmap_config an8855_regmap_config = {
> > +	.name = "switch",
> > +	.reg_bits = 32,
> > +	.val_bits = 32,
> > +	.reg_stride = 4,
> > +	.max_register = 0xbfffffff,
> > +	.reg_read = an8855_regmap_read,
> > +	.reg_write = an8855_regmap_write,
> > +	.reg_update_bits = an8855_regmap_update_bits,
> > +	.disable_locking = true,
> > +	.rd_table = &an8855_readable_table,
> > +};
> > +
> > +static int an855_regmap_phy_reset_page(struct an8855_mfd_priv *priv,
> > +				       int phy) __must_hold(&priv->bus->mdio_lock)
> > +{
> > +	/* Check PHY page only for addr shared with switch */
> > +	if (phy != priv->switch_addr)
> > +		return 0;
> > +
> > +	/* Don't restore page if it's not set to switch page */
> > +	if (priv->current_page != FIELD_GET(AN8855_PHY_PAGE,
> > +					    AN8855_PHY_PAGE_EXTENDED_4))
> > +		return 0;
> > +
> > +	/* Restore page to 0, PHY might change page right after but that
> > +	 * will be ignored as it won't be a switch page.
> > +	 */
> 
> Use proper multi-line comments please.
> 
> > +	return an8855_mii_set_page(priv, phy, AN8855_PHY_PAGE_STANDARD);
> > +}
> > +
> > +static int an8855_regmap_phy_read(void *ctx, uint32_t reg, uint32_t *val)
> > +{
> > +	struct an8855_mfd_priv *priv = ctx;
> > +	struct mii_bus *bus = priv->bus;
> > +	u16 phy_id, addr;
> > +	int ret;
> > +
> > +	phy_id = FIELD_GET(MDIO_REGMAP_PHY_ADDR, reg);
> > +	addr = FIELD_GET(MDIO_REGMAP_PHY_REG, reg);
> > +
> > +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> > +	ret = an855_regmap_phy_reset_page(priv, phy_id);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	ret = __mdiobus_read(priv->bus, phy_id, addr);
> > +
> > +exit:
> > +	mutex_unlock(&bus->mdio_lock);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = ret;
> > +	return 0;
> > +}
> > +
> > +static int an8855_regmap_phy_write(void *ctx, uint32_t reg, uint32_t val)
> > +{
> > +	struct an8855_mfd_priv *priv = ctx;
> > +	struct mii_bus *bus = priv->bus;
> > +	u16 phy_id, addr;
> > +	int ret;
> > +
> > +	phy_id = FIELD_GET(MDIO_REGMAP_PHY_ADDR, reg);
> > +	addr = FIELD_GET(MDIO_REGMAP_PHY_REG, reg);
> > +
> > +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> > +	ret = an855_regmap_phy_reset_page(priv, phy_id);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	ret = __mdiobus_write(priv->bus, phy_id, addr, val);
> > +
> > +exit:
> > +	mutex_unlock(&bus->mdio_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +/* Regmap for MDIO Passtrough
> > + * PHY Addr and PHY Reg are encoded in the regmap register.
> > + */
> > +static const struct regmap_config an8855_regmap_phy_config = {
> > +	.name = "phy",
> > +	.reg_bits = 20,
> > +	.val_bits = 16,
> > +	.reg_stride = 1,
> > +	.max_register = MDIO_REGMAP_PHY_ADDR | MDIO_REGMAP_PHY_REG,
> > +	.reg_read = an8855_regmap_phy_read,
> > +	.reg_write = an8855_regmap_phy_write,
> > +	.disable_locking = true,
> > +};
> > +
> > +static int an8855_read_switch_id(struct device *dev, struct regmap *regmap)
> > +{
> > +	u32 id;
> > +	int ret;
> > +
> > +	ret = regmap_read(regmap, AN8855_CREV, &id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (id != AN8855_ID) {
> > +		dev_err(dev, "Switch ID detected %x but expected %x\n",
> 
> "Detected Switch ID %x but %x was expected"
> 
> Or
> 
> "Expected Switch ID %x but %x was detected"
> 
> > +			id, AN8855_ID);
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int an8855_mfd_probe(struct mdio_device *mdiodev)
> > +{
> > +	struct regmap *regmap, *regmap_phy;
> > +	struct device *dev = &mdiodev->dev;
> > +	struct an8855_mfd_priv *priv;
> > +	struct gpio_desc *reset_gpio;
> > +	u32 val;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->bus = mdiodev->bus;
> > +	priv->switch_addr = mdiodev->addr;
> > +	/* no DMA for mdiobus, mute warning for DMA mask not set */
> 
> Nit: Please start sentences with uppercase chars.
> 
> > +	dev->dma_mask = &dev->coherent_dma_mask;
> > +
> > +	regmap = devm_regmap_init(dev, NULL, priv, &an8855_regmap_config);
> > +	if (IS_ERR(regmap))
> > +		return dev_err_probe(dev, PTR_ERR(regmap),
> > +				     "regmap initialization failed\n");
> > +
> > +	regmap_phy = devm_regmap_init(dev, NULL, priv, &an8855_regmap_phy_config);
> > +	if (IS_ERR(regmap_phy))
> > +		return dev_err_probe(dev, PTR_ERR(regmap_phy),
> > +				     "regmap phy initialization failed\n");
> > +
> > +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR(reset_gpio))
> > +		return PTR_ERR(reset_gpio);
> > +
> > +	if (reset_gpio) {
> > +		usleep_range(100000, 150000);
> > +		gpiod_set_value_cansleep(reset_gpio, 0);
> > +		usleep_range(100000, 150000);
> > +		gpiod_set_value_cansleep(reset_gpio, 1);
> > +
> > +		/* Poll HWTRAP reg to wait for Switch to fully Init */
> > +		ret = regmap_read_poll_timeout(regmap, AN8855_HWTRAP, val,
> > +					       val, 20, 200000);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret = an8855_read_switch_id(dev, regmap);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Release global PHY power down */
> > +	ret = regmap_write(regmap, AN8855_RG_GPHY_AFE_PWD, 0x0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, an8855_mfd_devs,
> > +				    ARRAY_SIZE(an8855_mfd_devs), NULL, 0,
> > +				    NULL);
> > +}
> > +
> > +static const struct of_device_id an8855_mfd_of_match[] = {
> > +	{ .compatible = "airoha,an8855" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, an8855_mfd_of_match);
> > +
> > +static struct mdio_driver an8855_mfd_driver = {
> > +	.probe = an8855_mfd_probe,
> > +	.mdiodrv.driver = {
> > +		.name = "an8855",
> > +		.of_match_table = an8855_mfd_of_match,
> > +	},
> > +};
> > +mdio_module_driver(an8855_mfd_driver);
> > +
> > +MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
> > +MODULE_DESCRIPTION("Driver for Airoha AN8855 MFD");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 2.48.1
> > 
> 
> -- 
> Lee Jones [李琼斯]

-- 
	Ansuel

