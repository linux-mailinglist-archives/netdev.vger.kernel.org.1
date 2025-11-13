Return-Path: <netdev+bounces-238361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC4FC57B84
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 082C3352123
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FED15ADB4;
	Thu, 13 Nov 2025 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RDeOfM0p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00C184524
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040995; cv=none; b=g6VejU21S+vfvU1bAc4AO+lPx7EbQMlWRHi9FjpC6lzYIJc/3oHLBarDmag+7rV0bIyEy1u9okf3KufNLLuYXMmelStCvmeEnuW28nLzuQnhR2IvvAoV52qGfBrhlKwL/KIlpcBimOJkHwyf5SEZErCVz03wIsK4SZHWm4b6zqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040995; c=relaxed/simple;
	bh=mbyXpF16xuSOT/xNqNmn5qUePw8VIa992fULg03LHqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxFGfTlOrFOYr0t5tHbs6RHklYLJc+iMbFlv/RnscgC4EsOaeIOV4FVuWpCKPy2cQjlfSMQFCJhq6ygMPLkcB87l4YaE2o+M7nPEXmduvLGZ5Mi/Cw348O8DNyHpKKXszMNuq+OxUENdkktJ//LQkkEBGK8AXjy9mz/CC0Ney8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RDeOfM0p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LCLvkmd3x7QKtuhxdVMeybaV8ZDSLQsc1VITW9Huyd0=; b=RDeOfM0puykNm5JwRhS2Jcbk0u
	vu73/7RmSG2UuPe7X1xQXvDnts6tOF9Pn/0zl6FjB1a8KLGR5vHMcvmFdCTkBYU39cpLNgqbP0EGN
	M/HyFZhOpxmbKugFmVVlgVx6872u2H/bVbt+VPqjnfRu0KMXzaBp+1ZIr+eWWc1l3c28=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJXUg-00DrqQ-A0; Thu, 13 Nov 2025 14:36:10 +0100
Date: Thu, 13 Nov 2025 14:36:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/9] phy: add hwtstamp_get callback to phy
 drivers
Message-ID: <a4b391f4-7acd-4109-a144-b128b2cc09b2@lunn.ch>
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
 <20251113113207.3928966-3-vadim.fedorenko@linux.dev>
 <aRXIuckumra-3Y0L@shell.armlinux.org.uk>
 <12c8b9e9-4375-4d52-b8f4-afccba49448c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c8b9e9-4375-4d52-b8f4-afccba49448c@linux.dev>

> I was planning to remove SIOCSHWTSTAMP/SIOCGHWTSTAMP dev_eth_ioctl calls
> later once everything has landed and we have tests confirming that ioctl
> and netlink interfaces work exactly the same way.

I don't think you can remove SIOCSHWTSTAMP, it is ABI. All you can
really do is change the implementation so that it uses the same path
as the netlink code.

You can avoid this for _get by never adding it in the first
place. Only support the netlink API for PHYs.

	Andrew

