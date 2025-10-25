Return-Path: <netdev+bounces-232923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2013C09EFD
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 21:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00E7402162
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525B9303CAE;
	Sat, 25 Oct 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oRHf3Nma"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE224DDD2;
	Sat, 25 Oct 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761419137; cv=none; b=vAlXiSUBJ1c5DoAwQlZcQ0tpvNds6rsn8m8iWOSB9oKoyTvsKdxnpk3Li6XnjLFBUYzemeoI01Y0STz4sSHteP47wXK+i7czgrM2B6wGmy6fv+03xWA/KESwOiuBskHDNmUU9pH8cH1hDGf6kW1Y+JTgmE0dzs77vNem3v/jdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761419137; c=relaxed/simple;
	bh=5oBr3nvlJParOZnZNwPmDHrOsW1uP4xKDzsA5kW9CSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbrkJMInXJzaYG2b3A6M9nnFa74wYPsVwJYQIJo2aZOfbXe+9NWwwxqnWsXLTV+03qxTc4pPsIrNtdFqVHx5WGCikCJyIjvEoUj6SYT+mx+vGE7AhfJMjwsqfhR2DmJt3Lrncai7dL7vGFAFKlla+bk/8K1yqsScP4AEAErLFTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oRHf3Nma; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p2X9/zl5/YU37XtsjNPYYxytGVPCsBxM1199nKNdjpA=; b=oRHf3Nma159cbmTdrFpR+1N3Rc
	mO5kctvNyBfwY+VuEarqOXqdxhUwpwjiItcUyanCH0jt3OHC/jFHzN07u9KTPaimia3PE8MoouHr7
	M3PMYZAzL8d3SufauL5jDoYh+EgjYe/rbvTJNpL49lPNe6DdeTcWYR+zZkB//i2RUXjiR6FuJFPGt
	za2tep18dkgcEGwo/JIaspoB2+11H+BbiGs1YBtOmLIejWezkO2DooKpa9IkQEEjMSfxPArKyTgaL
	v3jM8dni60uuzvSV9D3BKO+++BgQCKx4JXekQhjM6EavOpALREjHnbdCKqaRULOoTjeFTion4lvQ4
	m4Z7ILSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47724)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCjZq-000000000Ki-26ix;
	Sat, 25 Oct 2025 20:05:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCjZn-000000003uK-25sa;
	Sat, 25 Oct 2025 20:05:19 +0100
Date: Sat, 25 Oct 2025 20:05:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH net-next v2 03/13] net: dsa: lantiq_gswip: support Energy
 Efficient Ethernet
Message-ID: <aP0fb63DLciFDpov@shell.armlinux.org.uk>
References: <cover.1761402873.git.daniel@makrotopia.org>
 <20d4879e51b7f4ce5624123e462d6af05637cc26.1761402873.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d4879e51b7f4ce5624123e462d6af05637cc26.1761402873.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Oct 25, 2025 at 03:48:23PM +0100, Daniel Golle wrote:
> Introduce support for Energy Efficient Ethernet (EEE) on hardware
> version 2.2 or later.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

