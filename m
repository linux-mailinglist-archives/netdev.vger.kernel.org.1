Return-Path: <netdev+bounces-85935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCF289CF0D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 01:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532FD1C21DA2
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0B148FEE;
	Mon,  8 Apr 2024 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0dy+B9Ad"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26D146D40
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619955; cv=none; b=ih+O/50U1OlyENg6nx3Rm+BBC9jsJHmpIfFoUNEXyAMF8PAgcSkkCrulbpj0VfNi5c5C3eVL2n0SiXhPKfq0Zno2oqfJeDG+MnYnnZevs76rBl6WyW2FTUOevScN/KyXX8LA2M26hiwTuDi35PjbSu36Eq1UsgAHaVVcA9QWeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619955; c=relaxed/simple;
	bh=NT2fRRbMo479IkMJZRy+QXoJwYU3ockIBc8/u2W9SQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj3+pciIrjde48KwT4GNh5tce9CdOGeu1xrKd3IaNsKnfz+Ua48iT3UDkvOdJ/gLPkjwAX5bStvVRzb9ulXbvKO2S7+m1lllyHSbDlrXwtnvsp8ZmY0y2B/i2PtKk4VDIWfJ+xY+AqyF9TMKY2DV9tlZqvsQF5F6I4I0dSlMXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0dy+B9Ad; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ElPvRbFfZGwp18g0nTAZhmHXf/Yv66YUUAo+0BLfigg=; b=0dy+B9AdeK8YCIYYw8+Ep1RVsl
	BXmTobyLbYje3peI4vTZ5JcStS+mjZx/ldCSMSdgAvwXfqCA5kVy38UGv1q3HVqKOM1eqvaH5iKHi
	kOQ8Tp5ynTBOwM36ZnbE9x5Dq2XTr0cqSWtGbbx/vUPB+/9RlMeluVbCWm64AwwZcnMY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtygP-00CWb2-Eg; Tue, 09 Apr 2024 01:45:49 +0200
Date: Tue, 9 Apr 2024 01:45:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: dsa: mv88e6xxx: provide own phylink
 MAC operations
Message-ID: <ad7644d1-1b98-41cf-888e-92f50c4dd9ca@lunn.ch>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
 <E1rtn2A-0065p6-6G@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rtn2A-0065p6-6G@rmk-PC.armlinux.org.uk>

On Mon, Apr 08, 2024 at 12:19:30PM +0100, Russell King (Oracle) wrote:
> Convert mv88e6xxx to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

