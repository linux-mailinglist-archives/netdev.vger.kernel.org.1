Return-Path: <netdev+bounces-193021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B178DAC23A1
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E82189D927
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEA8291157;
	Fri, 23 May 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nGqj+8zx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E12576;
	Fri, 23 May 2025 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006326; cv=none; b=I+PnrRXlF2kuHlcEkpWP4AL25JXPT4oIUxIumvOgvAmTwKl4NYnrQHdWOmd+gRQ5TiyuTceKMEVQ488hEQtPH0zCbn1/2dPPpvqW4tmTx5G2doop/kbXjYaoKrlqSyID8fxQTP/0zrwOxfn1SPot3JWAv8izYsfRFMwxqa32tqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006326; c=relaxed/simple;
	bh=DmDeA+nW2gQlpsu3R+oK8pnlc3qIeHE0zu4ebeLES2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCQsLzzl6QiIZ9mqu2L64/ewvwl3wsHhWix1WfkVycZSklp5/YZ2OXiKFtANJYfNtvdUqa3PDzgzexc/2NYLZfnRFtYm9AeheyzbABB/QIpR05XFixhpVnt3ClUwp/MwT7Xh3/ieZxcW7tuPwU7wd9Ru3ByHlCzpx7gH/p52jW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nGqj+8zx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XwwCTucFpUGQZ3GkFQaSR7QomxYPcuR84GoGCsG7I2I=; b=nGqj+8zxFi1s+JuMkJ8W9eknuj
	34NcduvS06e69Pocp/mYknGiJHM00E+VPn1lRNf0iRGS3FmjnrFt4sidp27iveiiaBakT4B94D0Kc
	8Z6ydGWkh3jNZTVIEjPaqXmAH3RY+KAC+PwZwOjQ3bpsqb2ukwRhIL+sJzeiMI0ctGH4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uISIC-00Dc1Q-I3; Fri, 23 May 2025 15:18:32 +0200
Date: Fri, 23 May 2025 15:18:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	f.fainelli@gmail.com, xiaolei.wang@windriver.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
Message-ID: <2a856f0d-ca86-48d8-be67-e2edb20637bf@lunn.ch>
References: <20250523083759.3741168-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523083759.3741168-1-wei.fang@nxp.com>

On Fri, May 23, 2025 at 04:37:59PM +0800, Wei Fang wrote:
> There is a potential crash issue when disabling and re-enabling the
> network port. When disabling the network port, phy_detach() calls
> device_link_del() to remove the device link, but it does not clear
> phydev->devlink, so phydev->devlink is not a NULL pointer. Then the
> network port is re-enabled, but if phy_attach_direct() fails before
> calling device_link_add(), the code jumps to the "error" label and
> calls phy_detach(). Since phydev->devlink retains the old value from
> the previous attach/detach cycle, device_link_del() uses the old value,
> which accesses a NULL pointer and causes a crash. The simplified crash
> log is as follows.
> 
> [   24.702421] Call trace:
> [   24.704856]  device_link_put_kref+0x20/0x120
> [   24.709124]  device_link_del+0x30/0x48
> [   24.712864]  phy_detach+0x24/0x168
> [   24.716261]  phy_attach_direct+0x168/0x3a4
> [   24.720352]  phylink_fwnode_phy_connect+0xc8/0x14c
> [   24.725140]  phylink_of_phy_connect+0x1c/0x34
> 
> Therefore, phydev->devlink needs to be cleared when the device link is
> deleted.
> 
> Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

