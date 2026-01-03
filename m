Return-Path: <netdev+bounces-246643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9099BCEFCA5
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 09:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88CDF301D9F5
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E95025BEE8;
	Sat,  3 Jan 2026 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yBi8kW9W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7211A9FA4;
	Sat,  3 Jan 2026 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767428664; cv=none; b=PRO0JP5YvNLUVDazdRoGDeampnaE9KP4lthgPGz4vB2mOFhTkYugYNtMTJd+mfPZkWpiFww8M6mJdxg7mE1aMir764mKz++wZdDIhnEk5Sfq4rzuLCWpSPWX2CndEYsiDtKRsV7LN4ZLtumWm5RwoFYTBEBCspx3JMrVZCzD1Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767428664; c=relaxed/simple;
	bh=UxHjh6VjhwaZg4kqlPGNowf04R4GJLq3BVQ01B61FMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhSbevW4NREL2NZL641uubMp98HmgVurmL2MaUBlVrJFKo88AhXc2l5qdGxYr7Mbc8vU3GbS3X+xMWMGUnFdII2GcWTWfE16jmfbbwyeLgPt63PZsiPbdIznnyXDaDKSNi0UQKmxB7LibW0TZIeJtI1lBD+R5aIqaRuD0UhTPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yBi8kW9W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HfLB7tnzgNN40ngj7Gx7V7TV8CQHLvbaKh+evyjPmCs=; b=yBi8kW9WY5LapE2JdHgh1+Bu0b
	ThNr1iKlzM+iWHqUHPWXG9J7lKrLhPM2ZcphNG0A3mIE/gypQRi47U3C8DlkFWXYsJPPec+D2nM0Y
	4m9tVfqorLqLbwubMojDUeCD1hvo9mEVn7Lccc5BBLC2qvXmFhpU/VoEHSdgJIqcvnNU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vbwvW-001FgS-Nr; Sat, 03 Jan 2026 09:23:58 +0100
Date: Sat, 3 Jan 2026 09:23:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: Re: [PATCH net-next] net: phy: mediatek: enable interrupts on AN7581
Message-ID: <58087e55-f227-4de8-833c-c27427822e0f@lunn.ch>
References: <20260102113222.3519900-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102113222.3519900-1-olek2@wp.pl>

On Fri, Jan 02, 2026 at 12:30:06PM +0100, Aleksander Jan Bajkowski wrote:
> Interrupts work just like on MT7988.
> 
> Suggested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

