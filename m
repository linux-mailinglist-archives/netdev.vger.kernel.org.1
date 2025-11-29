Return-Path: <netdev+bounces-242748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D93C94827
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 21:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E4D3A7019
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 20:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8862652AC;
	Sat, 29 Nov 2025 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n7iboDGX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E423D291
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764449419; cv=none; b=YYXSZRrGh9eaKp1QPxt57K83APJ/C3//Gykr6M4tzZIT+rPJMlSSWeIcoLzIWh4nX84V1Fu4rtbva8Wj9EygfkgwDQjt5yX3HNpB4CdV98a88EB6LdEV669710OQFzrObNlmdkjZYT/yR9uf+Qexbha3xxWkxLdnYhm5Mf4kKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764449419; c=relaxed/simple;
	bh=VnzxCjqZ+Bwzo7mMpaHs1MwXEFH223N4s+1vl95c8M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOgB0UDCDiJDS+jHus4rj5MIsSQGqfFT0UWlvye98elqdvp8GIRHXXi72qPjqvuJnxjtVsEKur072Wo7W0korFRjm6RkDm06s2VNC7SliS9t+KMl6dneRDtFOHbLxsePar7LMEN8+8ez1Tp7Fd377ROkTXoIwr7d7SOqFnZs3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n7iboDGX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h2EDQBB1WY4CJMVykS72ztk1cLDmjD877K18mmscGpw=; b=n7iboDGX2gYAhHen1UY4gszDni
	GF/akgayQvzq+ve5QOKD5fUrK24im9dbkmAOQpX8RcCAQclHVXI9Pl0WeZbIPRcrhgkS+tpUHKP8T
	nOQCo/lVH2dYPF9WYALtisZdhDqJcdarXoxMAqs7O57BZd2z6fl4VpCLc0KLEPs5OCnk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vPRtH-00FQV2-3d; Sat, 29 Nov 2025 21:49:59 +0100
Date: Sat, 29 Nov 2025 21:49:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: phy: micrel: add HW timestamp
 configuration reporting
Message-ID: <33b60cdb-b869-4213-a1a8-22c89b806c88@lunn.ch>
References: <20251129195334.985464-1-vadim.fedorenko@linux.dev>
 <20251129195334.985464-3-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129195334.985464-3-vadim.fedorenko@linux.dev>

On Sat, Nov 29, 2025 at 07:53:32PM +0000, Vadim Fedorenko wrote:
> The driver stores HW timestamping configuration and can technically
> report it. Add callback to do it.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

