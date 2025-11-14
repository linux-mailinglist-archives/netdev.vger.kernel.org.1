Return-Path: <netdev+bounces-238629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C71C5C3CA
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C37C35858E
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470093019B3;
	Fri, 14 Nov 2025 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrPTgg0j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687B2FBDE9;
	Fri, 14 Nov 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111728; cv=none; b=qtxdOXwzwmR+iSFKbXm7vBxiDWrjjhe61UH7qXclPMuUYT89S6jG6Pfw5v0lY/jXWBEWexCJ4WD7qecAa3z8Zoac5/HC/7ozKwmQYIm7sdmZf/JhntMlSETE3IzTWqY97PXMLv6wer5O4Tv5PS5SATPyGm8JoGo0FVENObEWiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111728; c=relaxed/simple;
	bh=uIoL6F17tP0jesir1V6cycmjCPl3jlFWKbnDbifqVNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew44PmuqCHJEvQAWbobqBOL1ph22AA0j85BKLSV26rHe+MSqC7Lr1jgjg1Oj++FIFRf1p4cKLjihbJXv6flsqpMRNvYtTFVnxxH02L1WgNx4Ry6PWDfaMgDrOTjlyQPzV5l+6cdrGWyYCME2fz2FkPX3y6q+VMEAz4SLtkO8GZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrPTgg0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A643AC4CEF8;
	Fri, 14 Nov 2025 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763111727;
	bh=uIoL6F17tP0jesir1V6cycmjCPl3jlFWKbnDbifqVNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrPTgg0jchX4Ugutwsxk2kal2kbS9DxT4VFtFczn+X5exV8VYs6kZIojrfoayxUqE
	 zzdiEO3q3qjna1vVu88ui0pLLODqJD1bTpfPt7y73u7cSzsuIxL3ve+XtyC2gOo97u
	 pno6F4BUb47da/BARTZVBu/2SFBfKFIqDdb56AxXeNCnaUDjIVDJPCVMR86CKlG83/
	 k7FQpGkPtb/QN3jSJzZ+HeoQOOOnS5stT9LC+2vftjet7p5wveEzKACaXSgSSY+UBw
	 s+DSZOJ5sgV3UgwG7rBFuT4BnpLbIEdxlSNB4fCDrcpL4HTqRN3Ef0CuHuIFBu3e1h
	 HhMGtc4ZbWzTA==
Date: Fri, 14 Nov 2025 09:15:20 +0000
From: Simon Horman <horms@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v8 2/3] net: phy: Add helper for fixing RGMII PHY mode
 based on internal mac delay
Message-ID: <aRbzKI3NpXPv-JpK@horms.kernel.org>
References: <20251114003805.494387-1-inochiama@gmail.com>
 <20251114003805.494387-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114003805.494387-3-inochiama@gmail.com>

On Fri, Nov 14, 2025 at 08:38:04AM +0800, Inochi Amaoto wrote:
> The "phy-mode" property of devicetree indicates whether the PCB has
> delay now, which means the mac needs to modify the PHY mode based
> on whether there is an internal delay in the mac.
> 
> This modification is similar for many ethernet drivers. To simplify
> code, define the helper phy_fix_phy_mode_for_mac_delays(speed, mac_txid,
> mac_rxid) to fix PHY mode based on whether mac adds internal delay.
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>


