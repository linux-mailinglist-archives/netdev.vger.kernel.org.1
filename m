Return-Path: <netdev+bounces-238372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D57C57D43
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 525D94E23DC
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E09526CE2C;
	Thu, 13 Nov 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KzVQSnmq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBBC23D298
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042588; cv=none; b=bwunYsJy2+uALtAWMuT+PdrVZOfscQgEpw9WW/0XS/2chQU55KGsxfFkFVCZZX19wpeb3PWbq3hfbDzaUCWr1tFHKi+T435OkgdDFedSMntXZFLUoOH+AT2YeSehXKdzZbGfvfqCADMPYQw0TnSp0MGxWMkW/DeWftqVsGJzNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042588; c=relaxed/simple;
	bh=3pWWR3HzVNsJtYwcjMVGgLX1BiiVAf8Vqia6dcsxatI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVoNba+NfR8eNljrylqJmQjKKcRZ4+ImVvWW6WCGAPRLP0ym0DWGXEa7oluf8XpdkdpAmPomFaUN9i4dlOCwRBo6FzCDItUNuqmBBUARGTf9HK3dRGeLLSLcJUc7Oz+0bGzjt6QIpz5TH5MKLviwiXhy7yXwyrRelYrDzWe69/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KzVQSnmq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rq5e4iSX3yY8JDgyiXqXWjVJ5Op++h4fyBwJ/GxyAcw=; b=KzVQSnmqgLiuL2kfK/xIN8ooH3
	Ey+tzhQBEL+0NPfYkGGnMBFHXF5QCSYZ5GEQen1BHQAzQ14FPA6kqCufjRNSIaC8AaR83CInNrjad
	rYVZlPZZ3B2ydbeGH+7+9+r/6zJWya/nHHJM5ZoAIciJ5PuMt8mgbccBBVbBgB9NuTt4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJXug-00Ds9U-Ao; Thu, 13 Nov 2025 15:03:02 +0100
Date: Thu, 13 Nov 2025 15:03:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 net-next 6/6] net: phy: realtek: create
 rtl8211f_config_phy_eee() helper
Message-ID: <b3634004-79ba-4278-be28-227c40d0a0e5@lunn.ch>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
 <20251107110817.324389-7-vladimir.oltean@nxp.com>
 <56b1deb7-2cc4-46fc-9890-bb7d984bed55@lunn.ch>
 <20251107143240.7azxhd3abehjktvu@skbuf>
 <9cb3808d-341d-4db2-90c9-12bf412d4a48@lunn.ch>
 <20251113121357.uu3em364s24ehm2q@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113121357.uu3em364s24ehm2q@skbuf>

> I think the safest thing to do is to keep the genphy_soft_reset() in the
> CLKOUT configuration procedure, regardless of PHY version, which is what
> I am going to do for v3.

O.K.

	Andrew

