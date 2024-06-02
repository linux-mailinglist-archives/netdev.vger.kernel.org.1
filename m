Return-Path: <netdev+bounces-99981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F58D75D4
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 15:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2DD1C20ACB
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 13:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B953BBFB;
	Sun,  2 Jun 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j6vxrZNS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C5C2135A;
	Sun,  2 Jun 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717336636; cv=none; b=E0/vslZC9uLtqUxcvKYoQ1baRh7fRthvND54YjDZmLEQjf6tY7Sxqq2v4/Dwo4lnuzSlEZr6u8w/owYiUfNJXfkZfi3vpfihcdDF6Xnuz+7XkIJRR5Y2Y86QMuqfaW6vH+/9wYPd+pLuO04PcqcDb9EPehxVzQdKhKGNpkus9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717336636; c=relaxed/simple;
	bh=mSlNPFEdg2MPTDAP2B9HUPG0/XPdFjlhuUdowqQC/gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKG+N8rdwuJaNDw/8qncM850e6Ii2HZOlNZdJygpoB4QxC3fD2DmzOcOSe0XZZ5sEsKGHXPiUGRWE2upSjGCyuOZiCPrOiMEbnj8C1a1js3ffZ5BkN7sUdDGVYxweSNFElgozbU18Cm8caO9J6yd5DVkjSPlUnxp8lTo9GrUdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j6vxrZNS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DO2iP4v2vxp0ZSW+yVwHjzYOouDHZnjWtS/l0hfmw2E=; b=j6vxrZNSyOkpmaGmniS4lyLv2H
	A5MwNH8JmO5Lr17/3VzWrHsJHDBDYPYJDhnsd8vjYw4Ne5gX9HhisYtFVqjnJelwvqZEVUcU/HoF/
	pGf/3VQCKBHOrOUX4Xs7FQZu3wfkwpYzFiyh8uyqfgci39UquUZATWmGVe95Ztgn43bY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDlhO-00Gc13-R9; Sun, 02 Jun 2024 15:56:38 +0200
Date: Sun, 2 Jun 2024 15:56:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Robert Marko <robimarko@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 1/2] net: phy: aquantia: move priv and hw
 stat to header
Message-ID: <3931a651-4997-40e3-93b8-399dab29c40b@lunn.ch>
References: <20240531233505.24903-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531233505.24903-1-ansuelsmth@gmail.com>

On Sat, Jun 01, 2024 at 01:35:02AM +0200, Christian Marangi wrote:
> In preparation for LEDs support, move priv and hw stat to header to
> reference priv struct also in other .c outside aquantia.main
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

