Return-Path: <netdev+bounces-122796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054F4962972
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED3A1F2518B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7AE282E1;
	Wed, 28 Aug 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CD6Oy163"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4418787E;
	Wed, 28 Aug 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853376; cv=none; b=K6qXr6FhNYROgLuX3E46JotERUdzbBohHELkTde0vDZH66Zqz71Ga7GiZemZ+xq3JgA0r8q1oAeHXeXDiXoIi1/rMYxix4Lf0Lg6Xh+xL6PDDuYdQTWmTaJKaWQ8t5ViELUIaqteVXyoKqJyV+OMmQNBLTAswYhbrYm76qD5Xpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853376; c=relaxed/simple;
	bh=AdhQ7SgKhTvlr8i5tAe50JFCckr2oPnQs1VS47LHhYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEggMDsCuAIX9YFFPX40wIfIiyAoDGLyOxWQ+wYsKfJLqNrYXogkWX4RC6A06QpJ+Gqv+YgEAZUBzflD8ATYtwZvqfUJtcpD2AI+7zlqbIm+7HuLo4DhgakRa0OyLmmURDKbGEvYpxVlYnjKAzZ4Na+AjFjzGCzES4BkvVkNaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CD6Oy163; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B6ieUZorE9O6QFwQiwk92WlzBjLaL+zCdotCOmej4bw=; b=CD6Oy163ghgeZG5UebH/hdWvDg
	nsA8w13ffm26CN5IVt5D9heXgx3KKG5zaQG/ScY01fwiXCDBGnv4y5LRIsyA9nNiNvo4+0QtIjtkR
	Bjj+wN/E1zRdEPwwXe1huxuzMr7q7nId/YQL8ivOzV7C51OOd6LrBCOj1vN3bYrpOOq32ToO1qBUy
	opRgDx8ovBikdv+mN8AeTa8OaINrJ/VFdYvCcH8YFAEQNW0E87J1U0OPge1uYYuDyDu97kb8icPfn
	qWPhziyRWyR+x2EHmMbXZ2uQxP+c6iwU3Qnazz5roDQaVni10G6bZzmZtVEW6teptZFx1YTvVmCuP
	/9Ov4wFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42654)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sjJ9g-0000Hz-02;
	Wed, 28 Aug 2024 14:56:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sjJ9e-0004X5-19;
	Wed, 28 Aug 2024 14:56:10 +0100
Date: Wed, 28 Aug 2024 14:56:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Modify register address from decimal
 to hexadecimal
Message-ID: <Zs8sehaL5HS5RSVf@shell.armlinux.org.uk>
References: <20240828125932.3478-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828125932.3478-1-yajun.deng@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 28, 2024 at 08:59:32PM +0800, Yajun Deng wrote:
> Most datasheets will use hexadecimal for register address, modify it
> and make it fit the datasheet better.

NAK. IEEE 802.3 uses decimal.

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

