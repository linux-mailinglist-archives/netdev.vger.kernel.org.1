Return-Path: <netdev+bounces-120462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 280CD959789
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2A01F20FFB
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9DA19259A;
	Wed, 21 Aug 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jon1dStJ"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61BD1607A0;
	Wed, 21 Aug 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229482; cv=none; b=BtdfXzclVXhhAvYwObgwHq0yBLCE2+d7g7wurU6tgJVZMa+NOHMRf0A/sNgPH/QwaJ/JcGFxivoiVS6LlGu8VPYfwTSPRePTevv711IYEnEd0Et+rYXcV2uQtaIze3VVlie5Jw95W113ad4nEMv9cDCOhn9SIq81S0I7HhWD1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229482; c=relaxed/simple;
	bh=uabQm7ZYUZLzAKgUc+bSaZLsoAHNfHfQdgMMrc030bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlcDENskz2tgcixD1gJySHKye4/4u2ZE70E0n6Qbgg2FcSnWwFwbOc3WQVPA4HXWvkBDxS9O0n+IRRLmKoBFvOUURzuqgiXifg05/a0qIVvS4ItgQuKphOJ6ZHOiM8e+2oAQSo10iSgrzJl5fHUch04gw7LJSumZMe5zYQ68wZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jon1dStJ; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 66654C31EC;
	Wed, 21 Aug 2024 08:16:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3119A1C0007;
	Wed, 21 Aug 2024 08:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724228185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJeKwYOdnVrbwcx1BXhsYNmdVn78L0iOo9pD8KulKgA=;
	b=jon1dStJRSD9xeQ/OyZmNELKzotCTnjuoGx85fBcVvA8POxxUXhAwTwEa84A4qKM3DhFGa
	xBrrkVV+cYW+OAO+VciBzi0d6O4A0qtBvlMF9ZDKryBtomwm0H3wrF9ne8CHA81q9lW3gE
	vnDOX+icKNiC4zvjU+8SyYlV6pjsKxA1L1erzhZ1MT+L9XmtP63am+W2uXYCYaliucJLq5
	4YVWiHXoB9Gaw9WYuCBYnYrxMYg3G6WmvdIQXtuhE8T4Q4F/yzuBt8PRTs94bQX1gk7Xz3
	j4V/R5KoTfCsia6yZp9f7+dVX65ZZE5Vpgg1cFyWGZmC25C/3+njM8yB8zTZ+g==
Date: Wed, 21 Aug 2024 10:16:22 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] phy: dp83tg720: Add statistics support
Message-ID: <20240821101622.3ef23d29@fedora-3.home>
In-Reply-To: <20240820122914.1958664-4-o.rempel@pengutronix.de>
References: <20240820122914.1958664-1-o.rempel@pengutronix.de>
	<20240820122914.1958664-4-o.rempel@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Oleksij,

On Tue, 20 Aug 2024 14:29:14 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Introduce statistics support for the DP83TG720 PHY driver, enabling
> detailed monitoring and reporting of link quality and packet-related
> metrics.
> 
> To avoid double reading of certain registers, the implementation caches
> all relevant register values in a single operation. This approach
> ensures accurate and consistent data retrieval, particularly for
> registers that clear upon reading or require special handling.
> 
> Some of the statistics, such as link training times, do not increment
> and therefore require special handling during the extraction process.

This all looks good to me, I do have one small nit bellow :

> +/**
> + * dp83tg720_get_stats - Get the statistics values.
> + * @phydev: Pointer to the phy_device structure.
> + * @stats: Pointer to the ethtool_stats structure.
> + * @data: Pointer to the buffer where the statistics values will be stored.
> + *
> + * Fills the buffer with the statistics values, filtering out those that are
> + * not applicable based on the PHY's operating mode (e.g., RGMII).

I don't see how this filtering is actually implemented, is this comment
correct ?

> + */
> +static void dp83tg720_get_stats(struct phy_device *phydev,
> +				struct ethtool_stats *stats, u64 *data)
> +{
> +	int i, j = 0;
> +
> +	dp83tg720_cache_reg_values(phydev);
> +
> +	for (i = 0; i < ARRAY_SIZE(dp83tg720_hw_stats); i++) {
> +		data[j] = dp83tg720_extract_stat_value(phydev, i);
> +		j++;
> +	}
> +}

Thanks,

Maxime

