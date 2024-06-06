Return-Path: <netdev+bounces-101420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EA38FE7CA
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C272D286872
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4938A19598F;
	Thu,  6 Jun 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CygLTZO9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94FA1D688;
	Thu,  6 Jun 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680640; cv=none; b=DAaX5gVUHKveleX2+hf8WSmXpSUGBLXfkW3v+kJ/q6erB8M5fkRTXhfPFC5P8+ug8w2pHj6HtsKFyajRTnEzXG7Q8dH1JeNIhZYvl4OWT4kp5kuXR+x8JmBSE3SFl9Yw7Xk+SBSOEnr2UpwmsZN5lj/CsW3lGa5PL1IAZ2KitMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680640; c=relaxed/simple;
	bh=Aw8mXRPRvqz8sD3PD2BMYJivDyo3YQgbnJEYWVzd2/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4jOvApCh8wPywgjnbGbM+aU4g+wRxb0YyBTSM9YuNX+rD3hz0j7URUPhI7zIlIBaVZQKuj2U92vMnlDu9LDpMDvdjHhcvAE+cwYS2hioYHhPY9r2vaASx/WtSkTYr0lPTKo8mJrPIl3jMaEZ+7vC/bJCoM3gnm8nntgzfN6D+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CygLTZO9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9XI9wH7c0OiiKuuV7PRZF9/baW0BWhqWDJc2QitLSPM=; b=CygLTZO9o2WozOhuihdVYu9TLp
	FcbVEin+gAaHruSRNgRxK+Z7tLS3BIfb//O7t1e9vrIXgN/M6T7okJS2KB9XOq8VzhHfKfeMVydUx
	ilvllNJJIMs+xIxzz48Q7HX899PT/rky8c/t1wuqNH6Y63wyhqaAk99glu+WPGO4XTFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFDCM-00H1Hj-1m; Thu, 06 Jun 2024 15:30:34 +0200
Date: Thu, 6 Jun 2024 15:30:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	linux@armlinux.org.uk, sbauer@blackbox.su, hmehrtens@maxlinear.com,
	lxu@maxlinear.com, hkallweit1@gmail.com, edumazet@google.com,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V3 2/3] net: lan743x: Support WOL at both the PHY and
 MAC appropriately
Message-ID: <95a302f0-1f46-465c-b3ab-63c9c3f4dda4@lunn.ch>
References: <20240605101611.18791-3-Raju.Lakkaraju@microchip.com>
 <202406052200.w3zuc32H-lkp@intel.com>
 <ZmGN+2qysJGU/9+V@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmGN+2qysJGU/9+V@HYD-DK-UNGSW21.microchip.com>

On Thu, Jun 06, 2024 at 03:52:51PM +0530, Raju Lakkaraju wrote:
> The target architecture of alpha's config file miss the "CONFIG_PM=y"
> cofiguration.

No. Your patch is missing support for CONFIG_PM = n. Or you need to
add a depends on PM.

We expect the kernel to build for any configuration. There are build
bots which create random configurations and see if they build. Not
having PM is a valid configuration, especially for a big iron server
which never sleeps.

    Andrew

