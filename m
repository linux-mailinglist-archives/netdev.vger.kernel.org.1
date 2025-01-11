Return-Path: <netdev+bounces-157477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1846A0A62D
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 22:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2F51889B9C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8993B1B87D7;
	Sat, 11 Jan 2025 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ufl5ptlb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADF31B6525
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736632351; cv=none; b=r0vKJNHfdoixbRvScEnuBKB/XMDYnwT4lFM//2tPUhwVJbo2ysHRXIT3WUVIGAJjWJNfljT5BVWvnTT2k66if4+hnTc37x9fX+1DMnhj+tJr8L7/iKN94rN89cqW1hAmI4daEJDuw4n06ZymsWsY5JsnDPTy4bQyp7NObPtWRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736632351; c=relaxed/simple;
	bh=0cpTQu/GnV4aytED3U2uWx1bGTv/ULBJPqSWZT3ZpEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3aL4LL7PDFmWp+e4Sw/Kwgm/yLIokRj8kaaUQFi8uzgx8cgnvf7IxFAL9IZuA7RQJ8bT1J1MshUC0jhH6GhAPRdfCyIgqnkIwqEimmjQe3cd4lqSrsNMojPrKZKwskbwbOG+RwqQ6fAFz8BMDXT1D3FqMXf/8t9ZcEqRfqvFjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ufl5ptlb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JoL+7XrdULjKDF0NajGMEVS8PgTfbKM00UVGapa9opQ=; b=ufl5ptlbm25XuaI7nS94RsYiUy
	C/kPQuhmjONVsCQ2SAPfU9aQWb6QXzahVVUHbZj1lWGsxlV3B6OoFtZcxlaROAm9nkNMG5i0LjlpP
	VkixXG4ROVpE+tS0GXUu5vJtiwqnk60nwXc9ZqSGSp7kVjzHA9EUDX9MhXBo90uKd1wQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWjP4-003dSU-Sv; Sat, 11 Jan 2025 22:52:22 +0100
Date: Sat, 11 Jan 2025 22:52:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
Message-ID: <0834047d-5eee-4d27-99c3-5f92460f78c3@lunn.ch>
References: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
 <ad6bfe9f-6375-4a00-84b4-bfb38a21bd71@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad6bfe9f-6375-4a00-84b4-bfb38a21bd71@gmail.com>

> +config REALTEK_PHY_HWMON
> +	def_bool REALTEK_PHY && HWMON
> +	depends on !(REALTEK_PHY=y && HWMON=m)
> +	help
> +	  Optional hwmon support for the temperature sensor

We frequently end up with build problems with HWMON. All the other
PHYs use:

        depends on HWMON || HWMON=n

We have not yet seen 0-day report issues with your earlier patchsets
versions, but maybe we should keep it the same as all other PHYs? But
maybe it is actually the same, if you apply De Morgan's Law?

	Andrew

