Return-Path: <netdev+bounces-213874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC35B27308
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31AFB7A3550
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B353283153;
	Thu, 14 Aug 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KT1v0HFP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D06F4FA;
	Thu, 14 Aug 2025 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755214445; cv=none; b=AXaAbbNva+KxYQrw7/6XeSUot2tqEnq8pkgHUGpPtPcavW/bvU65lcNCV47Zr0+3zzLhO5XpAV26gndohzIrM/tGXR+TMY48s3iXXpMXDnSmZ5m3/IGNz2RpHXplpkamCsS//LJwHO5HxrQZZdnQ3zWY9K4IFMIEJ07/yCrd5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755214445; c=relaxed/simple;
	bh=2aSVEHz1DtpnMUNkeOSnZlCwQNl0fDdqRS25zB6EREM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QChxVmR14lf3Hbws5Xmxw5vwauOkTXC3Uw7M9vn6CjIgpTbFQ10ZeGg4Fx2LQWnp7l8OL0l5pPDNjppYQc9PZf3ZfOu5O8re/W83gPJXyQR6dCzn3WNSQOOyvLXFSsC+WBtPhCyObeaC0oc594TyW267EGQwkgRDJXvktkkdOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KT1v0HFP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TILj3DGNsj7SgnyaUWIrvVUlsSuKDsdTIb9FI2joqaM=; b=KT1v0HFPXPldcjwX6y7IjX4jEj
	ZlnreOH9A6oqrs0n9DQVkokjryY/wof0hQINFUrrwXCnRt1Q2TlohM+JOHrQlUemXvdiSMwA01cO7
	RKqzBsXnX62jTWFf3VxdEc5jbnvFiP4WdGMPyRGkqWKoOxcPXPVnpLf/dlp5wvvAO6oI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umhS2-004lBE-R3; Fri, 15 Aug 2025 01:33:42 +0200
Date: Fri, 15 Aug 2025 01:33:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, heiko@sntech.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net-next] net: phy: motorcomm: Add support for PHY
 LEDs on YT8521
Message-ID: <f6ed3ea6-eba2-40a8-a8d2-9c8ee6dc9337@lunn.ch>
References: <20250813124542.3450447-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813124542.3450447-1-shaojijie@huawei.com>

On Wed, Aug 13, 2025 at 08:45:42PM +0800, Jijie Shao wrote:
> Add minimal LED controller driver supporting
> the most common uses with the 'netdev' trigger.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

