Return-Path: <netdev+bounces-145038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553419C92DC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EDB1F2323A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7FC1A76B7;
	Thu, 14 Nov 2024 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GyoSqQsG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ECF1A76B5;
	Thu, 14 Nov 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614634; cv=none; b=U3eAHgiTgUl26WTXXmlCIT4NUhVa6oMgUBQ21Geij8OIuzrvtebyXRpKZYhg/xHivlIyuMDt3vrZqWeLMYdNQQjJ8oX8L96HH9yVM+oLBTbMhjh7ZtFC44mUOP6lr7efi9Zbj/2Dtb2lOFHUUqB9jl6VCv7Z3lZ2mCMR9lCxkq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614634; c=relaxed/simple;
	bh=d+HGLCrpFkZ60PiheBeyeUupGbSwYXYAqhGs1w5YNd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqbY+adhWbKRjFh3OCwGAJcMMcCJQvYtEWAT3Nqte2IV4P+7uaNPRYWDyFJgr+uB11PHgT8bkqm77bw91jlv1IoXkD4rSA6p6OE17VNjig5LOv0kd6baHeZomABs3n/7Jjs8ZIiF9JB2AH7pVrAmwT7ZhafLbDN6IZdHJ9P2+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GyoSqQsG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y3DVoqjlG4RnINiEddGHP4tOYPiLD95IOSMjngMK6NQ=; b=GyoSqQsGIneHQtE+7JRx6yf0Bq
	zQNrpPK6UkzKZY8c0IqGuXlM/k2FgJDfv1V6JFyWD9iZcRupMdMcZPMV/R4/O3TDmzzSnvoUmfgz9
	034DbLXq021H6RCfDns/K+3DhOHuDYSXe94/E3y21DRVytEbWuHsxuB75+SDtH5fyetQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBg4B-00DL5l-RU; Thu, 14 Nov 2024 21:03:47 +0100
Date: Thu, 14 Nov 2024 21:03:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tristram Ha <tristram.ha@microchip.com>
Subject: Re: [PATCH net-next] net: phylink: improve phylink_sfp_config_phy()
 error message with empty supported
Message-ID: <65229583-367b-442c-bb24-14f1b04436e1@lunn.ch>
References: <20241114165348.2445021-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114165348.2445021-1-vladimir.oltean@nxp.com>

On Thu, Nov 14, 2024 at 06:53:48PM +0200, Vladimir Oltean wrote:
> It seems that phylink does not support driving PHYs in SFP modules using
> the Generic PHY or Generic Clause 45 PHY driver.

Somewhat related, i wounder if we should add a phydev_info() message
in genphy_probe() which prints a message that you probably want to
swap to using a PHY driver specific to the hardware?

The less genphy is used, the better.

	Andrew

