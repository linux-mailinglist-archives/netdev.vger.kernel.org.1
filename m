Return-Path: <netdev+bounces-84197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E689603C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 01:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F481C228EA
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 23:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E722A481AB;
	Tue,  2 Apr 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oXLEo1uE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC747A7A;
	Tue,  2 Apr 2024 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101007; cv=none; b=eZcec+GbvvHUen/sTbJLuqs7PV8Eyn12wC8MXYdLDso+UKVl+aJHhgqcAtArNDFFXCB4vD0HjDLQ4LjF1old34NDK2Szj5ILa4+gDX22p0lOhVXF1bdJVpnp879d7yqm/k91i5bmeN8GCjCyPb0Uu5TqcnRs+L7nCePpa/bLwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101007; c=relaxed/simple;
	bh=Pv4VdVU6AL/zgFp+IP6jN/D+L9T9b6LguUX+RYDiHDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9PFJWnTCm+SKWeK9dx979bQQnDA/3LJcbIoM2l7GbBXKWhpyOry/DkJwoGnbYbneBlW+BJoljSm1ZTj/2eXEUAppnVe3R161vqBt9JyLiWKDsYtNhjxNpSHKwot7A6sKl19QifprihVm0auvLYcF8BYRE6fXlVT0O2nABLxbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oXLEo1uE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EKRbw7NrczqOiFhiNTqUO47JW87hwrD+azsj7HQRFNg=; b=oXLEo1uEawo2N9Skr61q82c+uj
	ZHFAGBrKN4TN+ZIklUoTUcW2YhmJKCHFPON/5lfLGQwGu1GcPC/HWebVzhf+Wx1RB/QxDpSHgnDu6
	2GWxsOlmhB8VntfIOm0odVljR3+Vlpm5sIxLflEIsjWTiojP5pDYUC7YCat139GmdblQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrng8-00Bzsp-UL; Wed, 03 Apr 2024 01:36:32 +0200
Date: Wed, 3 Apr 2024 01:36:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: phy: marvell: add basic support of
 88E308X/88E609X family
Message-ID: <640e3d8a-3b27-404a-bf0f-0e3016b6fe10@lunn.ch>
References: <20240402201123.2961909-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402201123.2961909-1-paweldembicki@gmail.com>

On Tue, Apr 02, 2024 at 10:11:18PM +0200, Pawel Dembicki wrote:
> This patch implements only basic support.
> 
> It covers PHY used in multiple IC:
> PHY: 88E3082, 88E3083
> Switch: 88E6096, 88E6097
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

