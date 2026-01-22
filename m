Return-Path: <netdev+bounces-252334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBGoI1IicmmPdQAAu9opvQ
	(envelope-from <netdev+bounces-252334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:12:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1501671F2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A824943CB4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C87436378;
	Thu, 22 Jan 2026 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/2nK+gA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4837C0E9;
	Thu, 22 Jan 2026 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084431; cv=none; b=KlMKR5joqgu1aSjr5Yn/UhGzQ+9/edADBKgdDyE22Os423hr07anSpl598tdQ9E3d1O4NMDICv17Js/HsbVWO9Pv09z4M5wdCnmnXIHPvuHpb4z/ziNH0oyLXl/UFK35r5TKt45hn7aoR2oGuMOea/YaTVNpxfEA7Gx8Ru4benA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084431; c=relaxed/simple;
	bh=yz6FOb3lnDARnNOGEJctM9K6WyoQbGOoJ6ZUxNZ6L5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goZem5LgBz5r5MgevxuL5zEduSmhwezcZ4z5X9i7GT0ZcQtxRU/QD3WrPlxbOy2yBAP1poVOGWjkNnsf0BPSlI1JV4MLIyX+lEYXgaSyM6+wB/GorHvMnWiNn1K/Uhd0cW9pTkXc6Yh0InqlrGgPUKDIEQ9qAgqEBJ1d570eoho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/2nK+gA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769084429; x=1800620429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yz6FOb3lnDARnNOGEJctM9K6WyoQbGOoJ6ZUxNZ6L5s=;
  b=n/2nK+gAfyl0PZJf6xMEvyIaprO+3V5hOQXHzNS3rdU+PDn/gjUy849B
   N6xHr67/HPLZ6eylG6JIdIyLbABAtQO8yBn5XaaxaSD/STooz177BPLs/
   Huq7swhsFd3KZ6pkgAnKjbSop7MasYCZxAJjcIJj0hgsWg411zxLx+uUl
   kA4kRmsGR05C+tnQvE3pRx04/2tLjnUmifbOwsG9oJfVHkUUCAaEymm8g
   g3F+amHv5lzfUp/O0hQX9ISVp2rDugeK8+lIzV2tGtWhawRRl7tEpFCYe
   CSPyBjAXRg3zk0UqgD96TVRG7+uTpG15/7sUQEdlMcicpZnUFjU5+xLtL
   w==;
X-CSE-ConnectionGUID: 4e/Y1aEIS2yLlDTXH9Xmlw==
X-CSE-MsgGUID: W4vQ4q7nQ96gMgS0+XJUQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="74177784"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="74177784"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 04:20:29 -0800
X-CSE-ConnectionGUID: WmjDF6CIQX654NEDE0gy/w==
X-CSE-MsgGUID: 7OSp1yG4St60iyih1dlMig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206623316"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 04:20:24 -0800
Date: Thu, 22 Jan 2026 14:20:22 +0200
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
Subject: Re: [PATCH v2 net-next 03/15] net: mdio: add generic driver for NXP
 SJA1110 100BASE-TX embedded PHYs
Message-ID: <aXIWBpIvp7KZYZCn@smile.fi.intel.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-4-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122105654.105600-4-vladimir.oltean@nxp.com>
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
	TAGGED_FROM(0.00)[bounces-252334-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,intel.com:dkim,config.name:url]
X-Rspamd-Queue-Id: F1501671F2
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 12:56:42PM +0200, Vladimir Oltean wrote:
> This is the standalone variant of drivers/net/dsa/sja1105/sja1105_mdio.c.
> Same kind of differences between this driver and the embedded DSA one
> apply: regmap is being used for register access, and addresses are
> multiplied by 4 with regmap.
> 
> In fact this is so generic that there is nothing NXP SJA1110 specific
> about it at all, and just instantiates mdio-regmap. I decided to name it
> mdio-regmap-simple.c in the style of drivers/mfd/simple-mfd-i2c.c which
> has support for various vendor compatible strings.

...

> +#include <linux/module.h>
> +#include <linux/of_mdio.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mdio/mdio-regmap.h>

...

> +static const struct mdio_regmap_simple_data nxp_sja1110_base_tx = {
> +	.valid_addr = 0,
> +	.autoscan = false,
> +};

Actually the  { } is enough to initialise that. But if you want to be super
explicit... :-)

...

> +static int mdio_regmap_simple_probe(struct platform_device *pdev)
> +{
> +	const struct mdio_regmap_simple_data *data;
> +	struct mdio_regmap_config config = {};
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	struct mii_bus *bus;
> +
> +	if (!dev->of_node || !dev->parent)

dev->of_node check is not needed, see below.

> +		return -ENODEV;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	data = device_get_match_data(dev);
> +
> +	config.regmap = regmap;
> +	config.parent = dev;
> +	config.name = dev_name(dev);
> +	/* The resource is optional, provided for finding the registers
> +	 * within a device-wide non-MMIO regmap
> +	 */
> +	config.resource = platform_get_resource(pdev, IORESOURCE_REG, 0);

> +	if (data) {

We may always require data to be present. As you use a default one anyway.

> +		config.valid_addr = data->valid_addr;
> +		config.autoscan = data->autoscan;
> +	}

And if it is not provided we will have a crash which is fine. It will just
point that the code was not ever been run on real HW.

> +	return PTR_ERR_OR_ZERO(devm_mdio_regmap_register(dev, &config));
> +}

...

> +static struct platform_driver mdio_regmap_simple_driver = {
> +	.probe = mdio_regmap_simple_probe,
> +	.driver = {
> +		.name = "mdio-regmap-simple",
> +		.of_match_table = mdio_regmap_simple_match,
> +	},
> +};

> +

Unneeded blank line.

> +module_platform_driver(mdio_regmap_simple_driver);

-- 
With Best Regards,
Andy Shevchenko



