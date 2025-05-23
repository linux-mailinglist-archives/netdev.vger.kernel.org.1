Return-Path: <netdev+bounces-193092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9533BAC279A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74911B62724
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE6F296FCE;
	Fri, 23 May 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q9PanhOR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC12296FC6;
	Fri, 23 May 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017548; cv=none; b=Hegbm77unkapaML7ugxYNZeW9Q64tnPYf4WjAuVK/Oxqd2G0gyIEqU+I59BRdSifdzmy0VZQ+0ss/2++s++3dWJlz2fgZJAAzo85L70ima3OYT/aR9drI/z6WzlBe8Iapquz3vtqy2WUMsVZT0myjuI4mk3l3i18wyrUa7Ep7yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017548; c=relaxed/simple;
	bh=rjoEa4YTfRqV8t+RKBbDbYu/7bQ2rDRgnMXdcMYrDjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLmrF7WAJIiLZpS4mcCwgOr8Pu72N3Bh6BeyjwCwucEumFapbEbc8ZEdA3C3E3F1YUM/ATgfuKwEcbr3mwqvaLoXFh2LPJYHNEwIBFTVBFw6d3C9m10SE3+Cw+yi6EjWY/EoAOLX6zqlYm7wngithrxIlR7zdcp6Wykr5X3rGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q9PanhOR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3dBMu1aZeb4MqUjdbspQjjDSvZqqtn4D0MG87nppG/E=; b=Q9PanhORIlfOYOsdnsVJY64a4x
	vdceOKyr8105FTb8paN5cngobBxTgeipmScNsW0bnslzqsVR0mWqlI0yGTCUlEmtoAqKTBUiAB70J
	l3iyJuhtagFDoQA0f9onsfXDA4KIA6eFKUd4F+rAemeqzZgsQbszkoawNDCsdvlW0T1Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIVDH-00Dd8c-Ek; Fri, 23 May 2025 18:25:39 +0200
Date: Fri, 23 May 2025 18:25:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net 2/2] net: lan743x: Fix PHY reset handling during
 initialization and WOL
Message-ID: <7a6b4862-df38-4b9e-9add-beaeebbbefc0@lunn.ch>
References: <20250523054325.88863-1-thangaraj.s@microchip.com>
 <20250523054325.88863-3-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523054325.88863-3-thangaraj.s@microchip.com>

On Fri, May 23, 2025 at 11:13:25AM +0530, Thangaraj Samynathan wrote:
> Remove lan743x_phy_init from lan743x_hardware_init as it resets the PHY
> registers, causing WOL to fail on subsequent attempts. Add a call to
> lan743x_hw_reset_phy in the probe function to ensure the PHY is reset
> during device initialization.
> 
> Fixes: 23f0703c125be ("lan743x: Add main source files for new lan743x driver")
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

