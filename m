Return-Path: <netdev+bounces-103606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F28908C61
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D85F6B26323
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4F919AA59;
	Fri, 14 Jun 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GWRlxE6d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479E195961
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371194; cv=none; b=iJ84gQq8oeSnPPnw1AoxDSqMAeGzubi0lbSXx3d0kcsp8STJx0bldxZexDVTClcYGlxfpQd8jU2JQGj8ov7kaKhRdF20iAvM6T7CXDAcFfkB3dlAS0xhfNOmi53Q8sXzL4b4QbydF5yd7Tx8U+eZgfOwxcntSARRroSlp7klNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371194; c=relaxed/simple;
	bh=F2r132T9bOqRhLSeLaEkeu3Yb213QCmCuWzz041N7Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMZkxnEc3XfzbsccYJmrP8cEQFDbV5ASXcfm/kLRq2W0y+L24EjQTFLYS7klQLkbLONBN31Ns5dgQBcFembX1IY0UQdO1VrtU8nr2lEp4yQLWeEbSvFuX5k4JVvgjc4CfG3+YEQMjnpn3wSHpCJvfcm1uZ3gvWlbyY2JckWxUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GWRlxE6d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lkzRJdyYMnNelkb8G6ApQuasj7S7LRQUYb1cxdgn1B0=; b=GWRlxE6dOH5EYKb7m7H1sn+NLn
	elSA1uI/7naYfBWOS3giafO5CNNbZEXERwXHwJLnBqyg5g0FWBdu6Xcal4xHD1D6/e98mt7ak93nc
	wex6G+Nk6pJnt2xUMjbecXdpQEf4k4qJv3wu81hmQtfoWtHyHn7CfGaPkAPh40cwWaGs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sI6qM-00045B-NW; Fri, 14 Jun 2024 15:19:50 +0200
Date: Fri, 14 Jun 2024 15:19:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	horms@kernel.org, Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com
Subject: Re: [PATCH net v6 2/3] net: dsa: microchip: use collision based back
 pressure mode
Message-ID: <7659f8dd-3e7a-46f5-9e26-128c5e82535d@lunn.ch>
References: <20240614094642.122464-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240614094642.122464-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614094642.122464-3-enguerrand.de-ribaucourt@savoirfairelinux.com>

On Fri, Jun 14, 2024 at 09:46:41AM +0000, Enguerrand de Ribaucourt wrote:
> Errata DS80000758 states that carrier sense back pressure mode can cause
> link down issues in 100BASE-TX half duplex mode. The datasheet also
> recommends to always use the collision based back pressure mode.
> 
> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
> Reviewed-by: Woojung Huh <Woojung.huh@microchip.com>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

