Return-Path: <netdev+bounces-216762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F02B35110
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5312E7B1ACD
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571D61E9B1C;
	Tue, 26 Aug 2025 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5w357uUU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0B31D5CD7;
	Tue, 26 Aug 2025 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172422; cv=none; b=TOWO7lwIqqknrPjM+U33EJ9SWz9PogfVRUwjgMppSW7vQtCSysQ1ilkBm2Asv8mAQc6cvGfUQFhNsUoGrmEB0vC7ucB4sNNcqjoI20kIcP47Jjrhi3AitoYA7Uyk5LimyMD3o0MyT2NP4Pc4kLttl98ZW+whS5zRRhUeGiuuYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172422; c=relaxed/simple;
	bh=4by6mLf16exARc3x1mOAD6sIP4ym4JYNYABiP0o+QRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDTsWuZ6ZQieRuVQY3I63eorJpYo+7BGy3Ur+K2+hpDV933lziCrlpGDVkC8RGB95PHivApUnylxEuh7ave1AAEJR+QQhQgf+w9+mYZQti/1LeQETWRq9A5VEPqyRD537c7bFHBT87rSCbBwuJLqq5ExthvEI95tUfewHXtwxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5w357uUU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IeUJA4ShnDeVwdrmf3EPXsoILl1HCi50XwX5hphrqVw=; b=5w357uUUX2jMcqq2tTKgMCHPm1
	/BJhZkKgr99epYwTKib9r7otrpc3d+FpJYbPJNiS0l+ry39aGGxXWS0GJw6ZxxAwauxBinDlWN69b
	BefIIw3kplWegwowLBEknnn1PVscRgrIsT4wN3FGuFajMKEUeS9Zd/EluBmMLqHkRmsA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqifN-0061NF-B5; Tue, 26 Aug 2025 03:40:05 +0200
Date: Tue, 26 Aug 2025 03:40:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [PATCH net-next 6/6] net: dsa: lantiq_gswip: move MDIO bus
 registration to .setup()
Message-ID: <336af189-1175-4f4b-8e0e-f6d788242945@lunn.ch>
References: <cover.1756163848.git.daniel@makrotopia.org>
 <916803a5a597e9f8b4814cdbc9516c51f078d65a.1756163848.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <916803a5a597e9f8b4814cdbc9516c51f078d65a.1756163848.git.daniel@makrotopia.org>

On Tue, Aug 26, 2025 at 01:14:41AM +0100, Daniel Golle wrote:
> Instead of registering the switch MDIO bus in the probe() function, move
> the call to gswip_mdio() into the .setup() DSA switch op, so it can be
> reused independently of the probe() function.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

