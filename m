Return-Path: <netdev+bounces-189073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428F5AB048C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2806C98883C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C6628BA9F;
	Thu,  8 May 2025 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DIkQ2pbq"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8332797B2
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735922; cv=none; b=n9wniCwntsydZ++mg6fxq5+JWUL9Z4KAFe4VRxbl+nCq3F+KxlY13CWMnR1jgAeMLwCeM9b8tWdNQUSiKNBGUgssoP7+j/Vi2jnSZw47kpKAxEA865NNj4XXjhXmy2RcjWz5SuZorY9uxiTiRm7N5X9tSXfg3/jaS3Ggd09Ytuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735922; c=relaxed/simple;
	bh=FMFfjAhupIyMcQiW+d2vGijJ/6Hn/M9gHCJ3BHT3hs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dycfRwqwDNNXSyeE/rU7AP3X2zpFlgcW002WzJKbxggQoXPihrsD+aumQxskI3BJqmDvvxJIn3+gFVBVdSEYdjDqADy1j1xY6kJ6pVXsxE21KgM+rjxBsEV5Dfrzt4UDfCh6EWnS3ejktS35rvNmA9IhknmCDCdmVSqYPI/FaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DIkQ2pbq; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <21e9e805-1582-4960-8250-61fe47b2d0aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746735919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hy7ec7lbC/Y0P4+kLPv/gY7QRnVaxVEb18bBEjhf04=;
	b=DIkQ2pbqSpZYQ8yInqdxezW+G5MCjt4PF0pcVkx8mArv59NsvgIzzMWgwimW9Ez4sq8hl9
	mGgej8SrRQqmDe+QB5exTXx/7rqPr5wVosl/lhRDJRFmfEmJMcjmbcIFXr7KBDSo9avE3y
	CPa3jZ+J1R11+VVXvL6vT5uqa+AMxxA=
Date: Thu, 8 May 2025 21:25:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: dsa: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Kurt Kanzenbach <kurt@linutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
References: <20250508095236.887789-1-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508095236.887789-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 10:52, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert DSA to the new API, so that the ndo_eth_ioctl() path can
> be removed completely.
> 
> Move the ds->ops->port_hwtstamp_get() and ds->ops->port_hwtstamp_set()
> calls from dsa_user_ioctl() to dsa_user_hwtstamp_get() and
> dsa_user_hwtstamp_set().
> 
> Due to the fact that the underlying ifreq type changes to
> kernel_hwtstamp_config, the drivers and the Ocelot switchdev front-end,
> all hooked up directly or indirectly, must also be converted all at once.
> 
> The conversion also updates the comment from dsa_port_supports_hwtstamp(),
> which is no longer true because kernel_hwtstamp_config is kernel memory
> and does not need copy_to_user(). I've deliberated whether it is
> necessary to also update "err != -EOPNOTSUPP" to a more general "!err",
> but all drivers now either return 0 or -EOPNOTSUPP.
> 
> The existing logic from the ocelot_ioctl() function, to avoid
> configuring timestamping if the PHY supports the operation, is obsoleted
> by more advanced core logic in dev_set_hwtstamp_phylib().
> 
> This is only a partial preparation for proper PHY timestamping support.
> None of these switch driver currently sets up PTP traps for PHY
> timestamping, so setting dev->see_all_hwtstamp_requests is not yet
> necessary and the conversion is relatively trivial.

The new interface also supports providing error explanation via extack,
it would be great to add some error messages in case when setter fails.
For example, HIRSCHMANN HellCreek switch doesn't support disabling
of timestamps, it's not obvious from general -ERANGE error code, but can
be explained by the text in extack message.


