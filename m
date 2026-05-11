Return-Path: <netdev+bounces-286818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMNNAws5AmrmpAEAu9opvQ
	(envelope-from <netdev+bounces-286818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:16:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC9F51598B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E40663032814
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5910837F744;
	Mon, 11 May 2026 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4sfYLJzH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28437F739;
	Mon, 11 May 2026 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530332; cv=none; b=XxeuTx+TCEHc/ygl0+tvl+Gj0wxkDhzGXzTEtn98OOcWDogaA07md6u5nSRR+vuz9SLRLhH5Oo97Xtpb1DSnaNt0RH8ohPmWZ2YOBV8dUnDlQZuc7LsPlKwRbfZSZqIdV/+d21W5SZ8Ra7vvyJARhBKRsw6l8h6EQZwNDvt3wuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530332; c=relaxed/simple;
	bh=LBkZ5EQagRy70OXC82F6PyGxd/tDrK9ovMT+r92H+tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOlQz33zZLFWE78qYKct4xgN0Q993MJEusPdQOL133zJZZoQV7QLVYubYj+EiqO3ov/6z31QKhZXJxOATy8RUOw71fJwjfzwiGCFPH4ddiIKGibOyUnOQNRSi3mGBF+y3xElnBDOH4rzHBW7ky0YMZYKkMNzBlNxEaAGrvLjpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4sfYLJzH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y7704pXKdK7OmP5Md6k5aCh3b1/U2C67QpaolB6U9/s=; b=4sfYLJzHlHMw07N8IK7Za0F/rQ
	P1lyiyIdEBY8r0ZLhz67gROTKdI68l1TwpkN5mLGUONDg1o8DnMQD24txSHtbqK2yeWBoMxk4mc5a
	jyaBHg5Gc3ekZgaGGSYhSCJXenMGRclngkxOzk6jSIa/vsmwByGkvpINeCSFiRzJQ+Xk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMWyw-002Qyc-GM; Mon, 11 May 2026 22:12:02 +0200
Date: Mon, 11 May 2026 22:12:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Message-ID: <c9b1b559-f72e-46e0-8d71-57ea26f70bb0@lunn.ch>
References: <CY8PR02MB924948C0BB8611D5A2618D3283382@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB924948C0BB8611D5A2618D3283382@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: 7CC9F51598B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286818-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

> +static const char s2500_stat_strings[][ETH_GSTRING_LEN] = {
> +	"tx-bytes-ok",
> +	"tx-frames",
> +	"tx-broadcast-frames",
> +	"tx-multicast-frames",
> +	"tx-64-frames",
> +	"tx-65-127-frames",
> +	"tx-128-255-frames",
> +	"tx-256-511-frames",
> +	"tx-512-1023-frames",
> +	"tx-1024-1518-frames",
> +	"tx-underrun-errors",
> +	"tx-single-collision",
> +	"tx-multiple-collision",
> +	"tx-excessive-collision",
> +	"tx-deferred-frames",
> +	"tx-carrier-sense-errors",
> +	"rx-bytes-ok",
> +	"rx-frames",
> +	"rx-broadcast-frames",
> +	"rx-multicast-frames",
> +	"rx-64-frames",
> +	"rx-65-127-frames",
> +	"rx-128-255-frames",
> +	"rx-256-511-frames",
> +	"rx-512-1023-frames",
> +	"rx-1024-1518-frames",
> +	"rx-runt",
> +	"rx-too-long-frames",
> +	"rx-crc-errors",
> +	"rx-symbol-errors",
> +	"rx-alignment-errors",
> +	"rx-busy-drop-frames",
> +	"rx-mismatch-drop-frames",
> +	"ts_frames",

Looks like many of these should be returned via .get_rmon_stats

> +static void s2500_get_drvinfo(struct net_device *ndev,
> +			      struct ethtool_drvinfo *info)
> +{
> +	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> +	strscpy(info->bus_info, dev_name(&ndev->dev), sizeof(info->bus_info));
> +	strscpy(info->version, DRV_VERSION, sizeof(info->version));

version is pointless because it never changes, but the kernel is
always changing. If you don't fill it, the core will return the kernel
versions.

> +static int s2500_ethtool_set_link_ksettings(struct net_device *ndev,
> +					    const struct ethtool_link_ksettings *cmd)
> +{
> +	phy_ethtool_ksettings_set(ndev->phydev, cmd);
> +	return 0;
> +}

phy_ethtool_set_link_ksettings()

> +
> +static int s2500_ethtool_get_link_ksettings(struct net_device *ndev,
> +					    struct ethtool_link_ksettings *cmd)
> +{
> +	phy_ethtool_ksettings_get(ndev->phydev, cmd);
> +	return 0;
> +}

phy_ethtool_get_link_ksettings()

> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_main.c
> @@ -0,0 +1,698 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
> + * onsemi's S2500 10BASE-T1S MAC-PHY driver
> + */
> +
> +#include "s2500_hw_def.h"
> +
> +#include <linux/etherdevice.h>
> +#include <linux/if_ether.h>
> +#include <linux/irqchip.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy.h>
> +
> +/* S2500 functions & definitions */
> +
> +#define S2500_STATUS0_MASK	(S2500_SPI_ST0_CDPE_BIT | \
> +				S2500_SPI_ST0_TXFCSE_BIT | \
> +				S2500_SPI_ST0_TTSCAC_BIT | \
> +				S2500_SPI_ST0_TTSCAB_BIT | \
> +				S2500_SPI_ST0_TTSCAA_BIT | \
> +				S2500_SPI_ST0_RESETC_BIT | \
> +				S2500_SPI_ST0_HDRE_BIT | \
> +				S2500_SPI_ST0_LOFE_BIT | \
> +				S2500_SPI_ST0_RXBOE_BIT | \
> +				S2500_SPI_ST0_TXBUE_BIT | \
> +				S2500_SPI_ST0_TXBOE_BIT | \
> +				S2500_SPI_ST0_TXPE_BIT)
> +
> +/* Converts a MACPHY ID to a device name */
> +static inline const char *s2500_id_to_name(u32 id)
> +{
> +	if (id == S2500_MODEL_ID)
> +		return "S2500";
> +	return "unknown";
> +}

No inline functions in .c file please.

> +static int s2500_open(struct net_device *ndev)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +	int ret = 0;
> +	u32 val;
> +
> +	dev_info(&priv->spi->dev, "%s", "s2500_open");

dev_dbg() or not at all. Please don't spam the kernel log.

> +static int s2500_hwtstamp_get(struct net_device *ndev,
> +			      struct kernel_hwtstamp_config *cfg)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +
> +	if (!priv->ptp_clock) {
> +		cfg->tx_type = 0;
> +		cfg->rx_filter = 0;
> +	} else {
> +		oa_tc6_hwtstamp_get(priv->tc6, cfg);
> +	}
> +	return 0;

What is actually specific to the s2500 here? Your aim should be to put
everything you can into the core.

> +	/* Configure PTP if the model supports it */
> +	if (priv->capabilities & S2500_CAP_PTP)
> +		s2500_ptp_register(priv);

That should be in the core, based on FTSC.

	Andrew

