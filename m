Return-Path: <netdev+bounces-215887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ACCB30C7E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 05:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DB23A7531
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3D289E17;
	Fri, 22 Aug 2025 03:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WR+pxSpi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5D288C8B;
	Fri, 22 Aug 2025 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832933; cv=none; b=rjg+DgSWylhI/HPjLH9s59Sr3HEsM/WxPYsimXjpw/KHw+KSLw79Ud6TKDdHr7YSmD45Xcw1rEMtcnljV85KX4rvktCTU3ELI+ikeAOPmSDeYNiT5jpWWS1uOKTW6QlbqoT+0F6JffM+OknfvGjZJxkU+exFv8eyCNJHyoXlkDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832933; c=relaxed/simple;
	bh=s+7lJw5m52vRir8SA1Dcv5uVrwIl45LVmlPYqi+fQwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ai/+ztvcSwLLomNzRknwLp8w1YzMu5uq1u1Wzio43gdKXSlELNa2dDod0oayrHaIUTXP6dGydfQTpjq0AnV/X4SUtdUYsMCHckE6tbxbfUcX1CfGkbsy6H+GPyRZgsu6mxU8FiFVKlZqaGRxFx72YSOggu4/1I/Q/B0aMyYO0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WR+pxSpi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Az4RL4455bEyc1Pv3I0gSsFJHGFceAmzrfsW/25VF7M=; b=WR+pxSpiyVJN5EF8nix/3CwdBH
	7V7d1vBxq5RxXmpD32Rx+Iv+mm0YVtV0i3JH2v78QLP95xtAtf9Z8hSEJZ08fY+XsQkNUFsKAR14e
	BGbP88blpYGZfLNAopm2Q7ydFrteZxexJ/RuX75r9Clc8ZWSkzZVaMjT/Nb0oua9Yz78=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upILq-005X75-NV; Fri, 22 Aug 2025 05:22:02 +0200
Date: Fri, 22 Aug 2025 05:22:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH net-next 07/15] net: phy: aquantia: remove handling for
 get_rate_matching(PHY_INTERFACE_MODE_NA)
Message-ID: <be710bec-c68c-47c3-be4b-70db5481fedc@lunn.ch>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
 <20250821152022.1065237-8-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821152022.1065237-8-vladimir.oltean@nxp.com>

On Thu, Aug 21, 2025 at 06:20:14PM +0300, Vladimir Oltean wrote:
> After commit 7642cc28fd37 ("net: phylink: fix PHY validation with rate
> adaption"), the API contract changed and PHY drivers are no longer
> required to respond to the .get_rate_matching() method for
> PHY_INTERFACE_MODE_NA. This was later followed up by documentation
> commit 6d4cfcf97986 ("net: phy: Update documentation for
> get_rate_matching").
> 
> As such, handling PHY_INTERFACE_MODE_NA in the Aquantia PHY driver
> implementation of this method is unnecessary and confusing. Remove it.
> 
> Cc: Sean Anderson <sean.anderson@seco.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

