Return-Path: <netdev+bounces-252328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIIxAhgkcmnhdgAAu9opvQ
	(envelope-from <netdev+bounces-252328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:20:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8D667307
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD8DE72C123
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5B035581A;
	Thu, 22 Jan 2026 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YR74msmD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123D2BEFE5;
	Thu, 22 Jan 2026 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083951; cv=none; b=e+dULSAGgnc/C6oT/SyCXE3QoKXvha9AmzjzSex8wE6jjGY5OJ1TJOA9a4+1NeefQXvjvQp506YC+THyVmtEo5Lm6ZThBA+j2FEt7j2TJ7kXPSD5bgIo6LijneODAZYDAdpfQ8s7w6Vto+q30czWa4n5OFnfQdYKoEuICoeRl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083951; c=relaxed/simple;
	bh=omQkOAJnr6QMt1U3a7G037McjhcvdHWTLffUlhypiP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BznRZR8Z8Z9lbXOwAwWcrGm0b2+p0ymyvBvcBus4iyZi7W+Ze3Qd+P28u3+bSDAPi6gr4DyveGislWJC9IB0QevRvv7aiVDfZnPbJ9GAoFjKLfbtAuaz0lDPh8PqhGvyySKauQl2IEN5CSSL1hR9zyKXpRhZoc+vqiBIBraRR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YR74msmD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769083949; x=1800619949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=omQkOAJnr6QMt1U3a7G037McjhcvdHWTLffUlhypiP8=;
  b=YR74msmDHNfAqCv5CiwNl8rTQzSIIoRKGG4m3QfZCkGav6/0I53kAjvX
   pVIQnBMihqn2LT/U3MZ2voh9X+jTMoVMc0x49FfoR5CreR23LRKSeGvZr
   yHhKuShwkE6wvJT0E63AmGrjHnM30SyOJxdV8VSygla+C/IFS/nwOj+3b
   vM12xu99S8jdkKHCa2GM8Z4HupTbx8KwjHDyN+vJGHaVgEt9yM2QsLw07
   Lg3598hA498IHVM4rj43sRjPVPK8SF7KcoH4K+0wBUjgPOL+Xa22gqN6g
   HQZ1StegALZwFoNvp9GDlp7tZ2PcoX/lr/FjOoZpmulSoJXgsVgG0d+ww
   A==;
X-CSE-ConnectionGUID: TECl+sJjQwCAOOemE8wO0w==
X-CSE-MsgGUID: N0g5JWi+TX+dk+FI948Xig==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="87900720"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="87900720"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 04:12:28 -0800
X-CSE-ConnectionGUID: rBA7Xh1jRq+wVwNasISHBQ==
X-CSE-MsgGUID: hwHkNLqwR22Yjsz/qyDHXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="229684882"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 04:12:24 -0800
Date: Thu, 22 Jan 2026 14:12:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 02/15] net: mdio: add driver for NXP SJA1110
 100BASE-T1 embedded PHYs
Message-ID: <aXIUJbEwnAvIkeKK@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122105654.105600-3-vladimir.oltean@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,linux.intel.com,trustnetic.com];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-252328-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,smile.fi.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 9B8D667307
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 12:56:41PM +0200, Vladimir Oltean wrote:
> This driver is the standalone variant of drivers/net/dsa/sja1105/sja1105_mdio.c.
> In terms of differences:
> 
> - this one uses regmaps provided by the parent as a method to abstract
>   away the sja1105_xfer_u32() calls for register access
> - the driver prefix has been changed from sja1105 to sja1110 (this MDIO
>   controller is not present on the older SJA1105 family)
> - in the sja1105 driver, each memory word has 32 bits, so addresses as
>   seen by regmap need to be multiplied by 4. This affects what
>   sja1110_base_t1_encode_addr() returns, and is different compared to
>   sja1105_base_t1_encode_addr().

...

> +static int sja1110_base_t1_mdio_read_c22(struct mii_bus *bus, int phy, int reg)
> +{
> +	struct sja1110_base_t1_private *priv = bus->priv;
> +	struct regmap *regmap = priv->regmap;
> +	unsigned int addr, val;
> +	int err;
> +
> +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C22, reg & 0x1f);

GENMASK() ? Or do you have already a defined mask for this?

> +	err = regmap_read(regmap, priv->base + addr, &val);
> +	if (err)
> +		return err;
> +
> +	return val & 0xffff;

lower_16_bits() from wordpart.h?

> +}

...

> +static int sja1110_base_t1_mdio_read_c45(struct mii_bus *bus, int phy,
> +					 int mmd, int reg)
> +{
> +	struct sja1110_base_t1_private *priv = bus->priv;
> +	struct regmap *regmap = priv->regmap;
> +	unsigned int addr, val;
> +	int err;
> +
> +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_ADDR, mmd);
> +	err = regmap_write(regmap, priv->base + addr, reg);
> +	if (err)
> +		return err;
> +
> +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_DATA, mmd);
> +	err = regmap_read(regmap, priv->base + addr, &val);
> +	if (err)
> +		return err;
> +
> +	return val & 0xffff;

Ditto.

> +}

...

> +static int sja1110_base_t1_mdio_write_c22(struct mii_bus *bus, int phy, int reg,
> +					  u16 val)
> +{
> +	struct sja1110_base_t1_private *priv = bus->priv;
> +	struct regmap *regmap = priv->regmap;
> +	unsigned int addr;
> +
> +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C22, reg & 0x1f);
> +	return regmap_write(regmap, priv->base + addr, val & 0xffff);

val is already u16.

> +}

...

> +static int sja1110_base_t1_mdio_write_c45(struct mii_bus *bus, int phy,
> +					  int mmd, int reg, u16 val)
> +{
> +	struct sja1110_base_t1_private *priv = bus->priv;
> +	struct regmap *regmap = priv->regmap;
> +	unsigned int addr;
> +	int err;
> +
> +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_ADDR, mmd);
> +	err = regmap_write(regmap, priv->base + addr, reg);
> +	if (err)
> +		return err;
> +
> +	addr = sja1110_base_t1_encode_addr(phy, SJA1110_C45_DATA, mmd);
> +	return regmap_write(regmap, priv->base + addr, val & 0xffff);

Ditto.

> +}

...

> +static int sja1110_base_t1_mdio_probe(struct platform_device *pdev)
> +{
> +	struct sja1110_base_t1_private *priv;
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	struct resource *res;
> +	struct mii_bus *bus;
> +	int err;

> +	if (!dev->of_node || !dev->parent)

Can we avoid dereferencing? And perhaps dev_fwnode(dev)?

> +		return -ENODEV;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	bus = mdiobus_alloc_size(sizeof(*priv));
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name = "SJA1110 100base-T1 MDIO bus";
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> +	bus->read = sja1110_base_t1_mdio_read_c22;
> +	bus->write = sja1110_base_t1_mdio_write_c22;
> +	bus->read_c45 = sja1110_base_t1_mdio_read_c45;
> +	bus->write_c45 = sja1110_base_t1_mdio_write_c45;
> +	bus->parent = dev;
> +	priv = bus->priv;
> +	priv->regmap = regmap;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> +	if (res)
> +		priv->base = res->start;
> +
> +	err = of_mdiobus_register(bus, dev->of_node);
> +	if (err)
> +		goto err_free_bus;
> +
> +	priv->bus = bus;
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +err_free_bus:
> +	mdiobus_free(bus);
> +
> +	return err;
> +}

...

> +static const struct of_device_id sja1110_base_t1_mdio_match[] = {
> +	{ .compatible = "nxp,sja1110-base-t1-mdio", },

Inner comma is redundant.

> +	{},

Terminator is terminator, trailing comma is confusing here.

> +};

...

> +static struct platform_driver sja1110_base_t1_mdio_driver = {
> +	.probe = sja1110_base_t1_mdio_probe,
> +	.remove = sja1110_base_t1_mdio_remove,
> +	.driver = {
> +		.name = "sja1110-base-t1-mdio",
> +		.of_match_table = sja1110_base_t1_mdio_match,
> +	},
> +};

> +

Redundant blank line.

> +module_platform_driver(sja1110_base_t1_mdio_driver);

-- 
With Best Regards,
Andy Shevchenko



