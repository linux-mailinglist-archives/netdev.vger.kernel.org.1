Return-Path: <netdev+bounces-237394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8175C4A62C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962603B68C8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050A30498E;
	Tue, 11 Nov 2025 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M5SY1sfN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB325F797;
	Tue, 11 Nov 2025 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823295; cv=none; b=a2cZBpMRJlB5rRbRa2MT/aJXSDwWoGoX0+++V/IkV1CltnOAs/F2S1lh5sGKdNWG+HMKsW4MLg2lJa5ok0hAP0HQ6DkIXkM77XQNhRGMYrfRhihSsctKOuXGsms0jEMLIxlVu3KwnDKa/ZgLSwrBA2XVG5GJHco/sMJRixZ0XqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823295; c=relaxed/simple;
	bh=o/hg+KyedW2eySkuBO60GXlJsLQqgZU9PY78iUvzmoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siA+5ZUPlswgNrXG8ER70xjaI95xW7b1ItkpujLSMG31RjH46t4eTZupTcTqr+6LDAByGoqmI1oGjNpf2+m7Zhmr90n1e/aFwhuijSiWukDhfr0fzduxhGWsNiwWcioQJqk9jfQZ0G8eyzJi6bDwMFrSe3BS/JayDntq+FU//6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M5SY1sfN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UP7n5DTXu20VR6JoQ4QouP6cCSz8dSa6+wGE4YoaNSU=; b=M5SY1sfN54vs876zAOmtc1Nd3N
	VXUlJEiNNbY1nfVNgvIUXicL6A0mk7SxranbK2tI9uifnPsmlzgewZgOoBqRIxy2Om79ZPvmL9Sb+
	BhWJ+Sg/QaYmb4MxHOz/q7zAZ7ZeLLzdpNiZ7F+cHo1L6CGrp2840VlrNT52WgEU9EJk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vIcrd-00DZdb-QE; Tue, 11 Nov 2025 02:08:05 +0100
Date: Tue, 11 Nov 2025 02:08:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83869: Support 1000Base-X SFP
Message-ID: <924891c9-fd34-4e7a-bca9-007c80bc327f@lunn.ch>
References: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
 <20251110-sfp-1000basex-v2-3-dd5e8c1f5652@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-sfp-1000basex-v2-3-dd5e8c1f5652@bootlin.com>

> +static void dp83869_module_remove(void *upstream)
> +{
> +	struct phy_device *phydev = upstream;
> +
> +	phydev_info(phydev, "SFP module removed\n");

I think this should probably be downgraded to phydev_dbg().

> +static int dp83869_module_insert(void *upstream, const struct sfp_eeprom_id *id)
> +{
> +	struct phy_device *phydev = upstream;
> +	const struct sfp_module_caps *caps;
> +	struct dp83869_private *dp83869;
> +	int ret;
> +
> +	caps = sfp_get_module_caps(phydev->sfp_bus);
> +
> +	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> +			       caps->link_modes)) {
> +		phydev_err(phydev, "incompatible SFP module inserted\n");
> +		return -EINVAL;
> +	}
> +
> +	dp83869 = phydev->priv;
> +
> +	dp83869->mode = DP83869_RGMII_1000_BASE;
> +	phydev->port = PORT_FIBRE;
> +
> +	ret = dp83869_configure_mode(phydev, dp83869);
> +	if (ret)
> +		return ret;
> +
> +	/* Reconfigure advertisement */
> +	if (mutex_trylock(&phydev->lock)) {
> +		ret = dp83869_config_aneg(phydev);
> +		mutex_unlock(&phydev->lock);

Why is it safe to call dp83869_configure_mode() without the lock, but
dp83869_config_aneg() does need the lock? And what are the
consequences of not being able to get the lock and so aneg is not
configured?

Some comments would be good here.

    Andrew

---
pw-bot: cr

