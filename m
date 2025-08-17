Return-Path: <netdev+bounces-214385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 941CAB293AE
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729B6205B28
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 14:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266471C84BD;
	Sun, 17 Aug 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O9gOwle/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1516D290F;
	Sun, 17 Aug 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755442679; cv=none; b=Nr5pDttDF7K0FZx32YsF4YWR7mLuKk9N7EZ4rcodN3R4B6KrkBXRbekybA4EpHEj8TuaAE03Ef74NiIj45V/SmCvfAPWT9cmZw4bqJY17UFC15kOhqQeqz8h1jgMCGJchLSW6EGoU3nQpMFFFAwTrb/XdjIh4GHIoIebRB+Nr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755442679; c=relaxed/simple;
	bh=fAvFlJJqYOWnNyPSnXRIgCcz2MA0GUGCioFGwWtR8f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfWbsm41C8NFNxTfmxDaemDJ2vIiHgVjgbfb1z9d3uWwl30jg8DCleF9FMmpPIASqj95u7Vx41o7GuqE1RqGaSdBWCSCT2kQEOX2YdjefBl8WavZvnQJWUdWGkabyR/EwkOJAueeZEKXqYv6xMrTM7Lz6K/YziI6S6WO6blvflk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O9gOwle/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/s3HWwswGJVbhetzqyV9rkWjvELllA0/5aDo3OGOunY=; b=O9gOwle/E/dlKqhO3XqolD3KJw
	E3ResiTjiiSb8PrsTBWunk70onEyeRzuw315IoztouabqAUBdtpUFJ+eINW1w8VX4GOKVPRrj5z6A
	0k0KfoZI6wtqNwLEsbIR6KNnggVkFwV3vtqaugERsbjT2lRt6M5f7E/Wb9183PSxAo64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unep3-004y9j-Jd; Sun, 17 Aug 2025 16:57:25 +0200
Date: Sun, 17 Aug 2025 16:57:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 02/23] net: dsa: lantiq_gswip: deduplicate
 dsa_switch_ops
Message-ID: <6b110e80-85b9-4a5e-96b9-282ba75b24d1@lunn.ch>
References: <aKDhMZgsq9UblP4j@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKDhMZgsq9UblP4j@pidgin.makrotopia.org>

On Sat, Aug 16, 2025 at 08:51:13PM +0100, Daniel Golle wrote:
> The two instances of struct dsa_switch_ops differ only by their
> .phylink_get_caps op. Instead of having two instances of dsa_switch_ops,
> rather just have a pointer to the phylink_get_caps function in
> struct gswip_hw_info.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

