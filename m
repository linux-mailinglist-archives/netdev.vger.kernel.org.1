Return-Path: <netdev+bounces-224606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC58B86DC6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EF1B61C94
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8A31DD85;
	Thu, 18 Sep 2025 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NjuLSoAD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3831B113
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226327; cv=none; b=pn9G/PnCA+Pd7qHPhqv6qZDrCylN6QgnndO3AS6D7YvfFn1d0nZJdr5kM4Ws7GKGk5CggouErrqDNGhndzrqctX8vt/x8KZOaemWQXUa0AmBR2WllKUUnjEEs1dSB7AQisc9mBrQm1MSB+4cYsoexiiSiM9jmCJRNcU6nqjnTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226327; c=relaxed/simple;
	bh=/5malKAf/53wBBNIen4m68do8XeguMRHCIZg0fmrbt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnMKln5ou+40uPW5eMsKpG09bY839S9o4h7WF47qBOIyGt8KWgp2SQ64b737saJoC0mzy+gLbe0uumNQs+5hE5oCa9yGkmYPIfG6OxHgGipBRahx0K07DHitVyaUI85NJFmyQEnPv1zOb6w944quNX0k6JKB1GYcT4y9w1+tvX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NjuLSoAD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=64cgCuOjk8WQWoRCW+lqFmzEnqEjh2rv8TA+DTpPXVM=; b=NjuLSoADhNWJNJFumowp1JNPRl
	+klHNrmuoLUbacrLCo9m8yjAFzXNvVsJJ35CyCS3y763DJ7GJd3+CBbWXNnZarBcuUlxOcTpzGEYB
	6heJ4YZAXdTyhkQb/3MeEB7d2DWvn+MyMbCSw2+yf2JiAgxnSe495h4woPIV//q7zlMg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzKz4-008sAq-5t; Thu, 18 Sep 2025 22:12:02 +0200
Date: Thu, 18 Sep 2025 22:12:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 03/20] net: phy: marvell: add PHY PTP support
Message-ID: <299f61cc-b5a7-48a6-b16d-f1f5d639af85@lunn.ch>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIb5-00000006mzK-0aob@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uzIb5-00000006mzK-0aob@rmk-PC.armlinux.org.uk>

> +static u64 marvell_phy_tai_clock_read(struct device *dev,
> +				      struct ptp_system_timestamp *sts)
> +{
> +	struct phy_device *phydev = to_phy_device(dev);
> +	int err, oldpage, lo, hi;
> +
> +	oldpage = phy_select_page(phydev, MARVELL_PAGE_PTP_GLOBAL);
> +	if (oldpage >= 0) {
> +		/* 88e151x says to write 0x8e0e */
> +		ptp_read_system_prets(sts);
> +		err = __phy_write(phydev, PTPG_READPLUS_COMMAND, 0x8e0e);
> +		ptp_read_system_postts(sts);
> +		lo = __phy_read(phydev, PTPG_READPLUS_DATA);
> +		hi = __phy_read(phydev, PTPG_READPLUS_DATA);
> +	}
> +	err = phy_restore_page(phydev, oldpage, err);
> +
> +	if (err || lo < 0 || hi < 0)
> +		return 0;
> +
> +	return lo | hi << 16;

What happens when hi is >= 0x8000? Doesn't that result in undefined
behaviour for 32 bit machines? The u64 result we are trying to return
is big enough to hold the value. Does the hi need promoting to u64
before doing the shift?

       Andrew

