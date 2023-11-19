Return-Path: <netdev+bounces-49037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED847F0774
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 17:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90561F21B20
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1357F4F1;
	Sun, 19 Nov 2023 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ruh65STf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B92F9;
	Sun, 19 Nov 2023 08:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=izoxJtFa+gut2GWYiJJ8Hdj7FJsw6dsjll3K6JT4ym4=; b=ruh65STffNt9q1uP1/ORdjOM+z
	BP7aC3fu/N9AclhSPAEJVT1Encp6gbfzcF7bYuwBthNUNcO4qR4haVfoNhVyFweylbXjCoNCVw0v7
	UenMcNnA3qFcrtVivc9mJlJexbjRWPEWyEfFbs+X7xNw8qpdwDq7LZRWgW+dVgzCF50E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r4kaW-000ZXQ-Hw; Sun, 19 Nov 2023 17:24:00 +0100
Date: Sun, 19 Nov 2023 17:24:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [net PATCH] net: phy: correctly check soft_reset ret ONLY if
 defined for PHY
Message-ID: <5d35be32-58bb-465d-91d9-ca3e8029373e@lunn.ch>
References: <20231119151258.20201-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119151258.20201-1-ansuelsmth@gmail.com>

On Sun, Nov 19, 2023 at 04:12:58PM +0100, Christian Marangi wrote:
> soft_reset call for phy_init_hw had multiple revision across the years
> and the implementation goes back to 2014. Originally was a simple call
> to write the generic PHY reset BIT, it was then moved to a dedicated
> function. It was then added the option for PHY driver to define their
> own special way to reset the PHY. Till this change, checking for ret was
> correct as it was always filled by either the generic reset or the
> custom implementation. This changed tho with commit 6e2d85ec0559 ("net:
> phy: Stop with excessive soft reset"), as the generic reset call to PHY
> was dropped but the ret check was never made entirely optional and
> dependent whether soft_reset was defined for the PHY driver or not.
> 
> Luckly nothing was ever added before the soft_reset call so the ret
> check (in the case where a PHY didn't had soft_reset defined) although
> wrong, never caused problems as ret was init 0 at the start of
> phy_init_hw.
> 
> To prevent any kind of problem and to make the function cleaner and more
> robust, correctly move the ret check if the soft_reset section making it
> optional and needed only with the function defined.

I think this should target net-next, not net. It does not appear to be
an problem which actually affects somebody using stable kernels.

The change itself looks O.K.

    Andrew

