Return-Path: <netdev+bounces-216315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228D0B33151
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 18:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D891B25835
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3744917B425;
	Sun, 24 Aug 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QpkvHlZY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90615ECCC;
	Sun, 24 Aug 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756051245; cv=none; b=APDBTQbTGV7cAveVrUqeSj2d4gZ/S6CHUWeKoRhg6AG3A8VYpJQJ81N/RsZBe3NubCLb8GlXBnHXtU0aLdO0TgoSPaG3Ap8mJjoBTUB21wAJP8zUlR82CNGXzgIvro54ypQ6OFvAiby7QdE6/xdCGXbYUpaJTYoM7eKJjXbrWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756051245; c=relaxed/simple;
	bh=Z/vtMR0xsC+QVkf1xSonkMeqy+qppofWJlBvWrQpYDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q26KaRxCSCRpEabJkvF5mqI0ra5S2sXO8sWFmvN5CUWODKIyUhn3Bvw9dSIxjuM/0vD30YZiMJjzz3qA8eHJQt5FWW0rXKkvnIebbriJUw2PGhB2ZYI6FiUAQmMZVojcDXOSZyiho8Iy1rv3a7mq/vcaP4rCxrCPBToxCNF5cI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QpkvHlZY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FQ6T82BEHxFz8LS8Q8CWlMJqyUnGzIAbBmgUxuElB+c=; b=QpkvHlZYs1CdjLFckxFFny94SX
	quAJB+/oYzbc9F33CPNjs5uplcXJOot/ihfMDiWC1mFlTgpoIwT5+vXR0zetUq7qaD9GqlWFTQvtN
	zacqKbcVl2jBaOowtqIGW6Ft2BPoae21RnEmF4B3xo3pWaoIcQZDIrG32dfGaWdn9IoU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqD8n-005qM7-72; Sun, 24 Aug 2025 18:00:21 +0200
Date: Sun, 24 Aug 2025 18:00:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
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
Subject: Re: [PATCH net-next v4 7/7] net: dsa: lantiq_gswip: store switch API
 version in priv
Message-ID: <6c05a103-5e7c-4ad7-a648-4b7d573ca09b@lunn.ch>
References: <cover.1755878232.git.daniel@makrotopia.org>
 <eddb51ae8d0b2046ca91906e93daad7be5af56d7.1755878232.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eddb51ae8d0b2046ca91906e93daad7be5af56d7.1755878232.git.daniel@makrotopia.org>

On Fri, Aug 22, 2025 at 05:12:21PM +0100, Daniel Golle wrote:
> Store the switch API version in struct gswip_priv. As the hardware has
> the 'major/minor' version bytes in the wrong order preventing numerical
> comparisons the version to be stored in gswip_priv is constructed in
> such a way that the REV field is the most significant byte and the MOD
> field the least significant byte. Also provide a conveniance macro to
> allow comparing the stored version of the hardware against the already
> defined GSWIP_VERSION_* macros.
>
> This is done in order to prepare supporting newer features such as 4096
> VLANs and per-port configurable learning which are only available
> starting from specific hardware versions.

Thanks for the updated commit message and comments. This is much
clearer and the code avoids all the issues around endianness.

> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

