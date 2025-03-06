Return-Path: <netdev+bounces-172385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C345A5470B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3BD1893B26
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055120C46B;
	Thu,  6 Mar 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkUmWWfq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0620AF78
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255036; cv=none; b=cefLyh1tEwKKdm4GR4xjhcq5z3KAmcpOV9C2GG2zXnLCb9w+iqZmMB7vhxFxDv8zMZ6Mezw2XKzVEP5If8BI4rtJwrtB00D3WTsTNF9ncVDXagGsCH0YpkYhoCOjyRDUH0VAuLLlqAKLwPG7wrGz3NWi0yIwrdCBKe1f6UGCNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255036; c=relaxed/simple;
	bh=wsDrmZWqNwZ8Z92QvIsMkJWkfZRuwXzjXEV5bkQIeE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKL1exyAf3OAbnMsELnDERUdVRDT7cEq03fB9u4rW+TJu0fadp2epP3SrHDEnrF5UVUeW1L84AU9LVcnQX3RP0AlNO+xdeJLUdmWQscgeyOUF+lQ1R/YFp8TN6B1ESXveHO/TBJGjlT/r1oyZ4YbsOSZytMpmugBczrawt/ROIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkUmWWfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335F6C4CEE2;
	Thu,  6 Mar 2025 09:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741255035;
	bh=wsDrmZWqNwZ8Z92QvIsMkJWkfZRuwXzjXEV5bkQIeE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkUmWWfq0wnktTbrQMOzFCxZ1idiOiZOA0Td5RKlwaMZLIzNz8MCsANI6ruO+VVZp
	 gbGm7NG8dpfDTk4y3ua5cy3hTFiR8v4JXyYFNoQE450Jkq+dXHs9gXxrUbNs7B7+q4
	 xySW/R9nLFVa21UfFdAEhuSjeQJh/tp6GlJbhPT3tEcjlRW6hLVnCgjQ0rtGnls/dz
	 tlLYsYOaP4jm3eK0Ipat41qGStDjxly3buRLC7i+x/V7WgMlU7AerBmYZ26g9j/0Fi
	 hLTgZNC0sfOIk976NyWco3xeMZQ5uQndGt+QKyO3FUfl5L3DdTnKUCV1f0RFX7wxY9
	 QETTN5tbBhK3w==
Date: Thu, 6 Mar 2025 09:57:10 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: simplify phylink_suspend() and
 phylink_resume() calls
Message-ID: <20250306095710.GR3666230@kernel.org>
References: <E1tpQL1-005St4-Hn@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tpQL1-005St4-Hn@rmk-PC.armlinux.org.uk>

On Tue, Mar 04, 2025 at 11:21:27AM +0000, Russell King (Oracle) wrote:
> Currently, the calls to phylink's suspend and resume functions are
> inside overly complex tests, and boil down to:
> 
> 	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
> 		call phylink
> 	} else {
> 		call phylink and
> 		if (device_may_wakeup(priv->device))
> 			do something else
> 	}
> 
> This results in phylink always being called, possibly with differing
> arguments for phylink_suspend().
> 
> Simplify this code, noting that each site is slightly different due to
> the order in which phylink is called and the "something else".
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Simon Horman <horms@kernel.org>

