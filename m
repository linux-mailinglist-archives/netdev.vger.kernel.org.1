Return-Path: <netdev+bounces-153440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6149F7FAD
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D98163534
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD59227BAF;
	Thu, 19 Dec 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f7FQdCQy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE422655E
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625547; cv=none; b=EQegcajwUO3FYnsQrI8UXp2ji3U5DaWdvBl4/n8x4TWOEOfcQfobx5YyV6LtcogKs+3Ir/em1PiAM/CcfYNCRoLd+fQEPcxR3emiCg6DMeItcNLvt0vNEdGaUAqTv4ivbRrpMS3RfstXkKWNjj84cq6N391JrYTWzQCuU6EpB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625547; c=relaxed/simple;
	bh=h8SReLCjBQ3+hEV8BIGdea1YZWOAXyDEnUYyWttSOsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChWPLCyf7Bp3FZa8Fp5VvVryXXjx6vnrW6BQ+6XDqz2fw4tcfn2xdunVpgNl30Tb0jNlab4brJxn0vsyidH02QNrwu1K8/a4Vc7EAYKEDm4OGAoPulaTj0x0CPmrETk6XCGyBYuyG6XGSZabL50IsVefWkXe91qI4nFsWIz5pSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f7FQdCQy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gxs4YoRpQ2Hv9+HIAlmwF6HIce7LS/O+vf2GnztrK9I=; b=f7FQdCQyxlV6vfzTZ/gc9eo/GA
	/6kpKQkYZTs4yh+F2FBe21XgAIwPkb6sqKJcRNnoA3gneroQo3c5dut1+yrBsWT+DSLTPHT2r2/7K
	Jx0y6/vACZj3f/TVC7oJVV7HX6p77kT4exbcSQgI99/G1JlvSZAB2j1gj5vueF7Dj0mo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOJLE-001g8c-ME; Thu, 19 Dec 2024 17:25:36 +0100
Date: Thu, 19 Dec 2024 17:25:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/7] net: phy: aquantia: search for
 firmware-name in fwnode
Message-ID: <fe610c82-75a5-4903-aa76-d7b24cdf4a07@lunn.ch>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
 <20241217-tn9510-v3a-v3-3-4d5ef6f686e0@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-tn9510-v3a-v3-3-4d5ef6f686e0@gmx.net>

On Tue, Dec 17, 2024 at 10:07:34PM +0100, Hans-Frieder Vogt via B4 Relay wrote:
> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> Allow the firmware name of an Aquantia PHY alternatively be provided by the
> property "firmware-name" of a swnode. This software node may be provided by
> the MAC or MDIO driver.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

