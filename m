Return-Path: <netdev+bounces-143025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8416B9C0F09
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60751C23B26
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421EC2178EC;
	Thu,  7 Nov 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LQU8o3dX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112AC217469;
	Thu,  7 Nov 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008213; cv=none; b=U9cpAlFrVHY98lPh8wyGxt7PsB2Emt6+EEUqGQXSjoaxWD+dabdXFdpD6dk7aYqg9So00a8ptaTRit1hoIftC40apwLdAAGAT7WWCt6o+cslFs2tc7PhL4lnil15tPgn2XCBkYHk6XUlrwxdLyW2LmLWevttaiiMv6UoVL9OQxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008213; c=relaxed/simple;
	bh=LRu13LUEIwBKt09C9i/sLeEvb1X/GwTrlIXMlWJ3dnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwu8DnwdYt8qez9yIg7oG7fRraFE5H2HovBsHHhDXquBK7rhYhG5PakNZvvcvk7XhdIc4nehqi7fBdM+mEUdp+m+LNpvtn8OoCN7330g2hnvupDv5Q7ZlezLRrE7JG7N0HuClbFW95lZqG1YZWbi3c3PTflNAjth2g+yuWaIMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LQU8o3dX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Og9wlVgM0BRB/j4S7Y/C7oTbSr+qBDG27Kjm/ghy3Ok=; b=LQU8o3dXx5z9lZiPBXtlL/1gzl
	yemHNPGMs6a+zViyFH+wxslUR8myQcH8aI0ArJ9yXMfMxtm39gQpQrmj1pDqErBqTrlvwnuyBnGCh
	BZOBNb5stNeRXrEHkJGLcp++t1sGOcf8uta7/5YZ+tObpjrfGQxZtvjpOF5/R7mcNhrk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t98J1-00CV5w-6i; Thu, 07 Nov 2024 20:36:35 +0100
Date: Thu, 7 Nov 2024 20:36:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"AngeloGioacchino Del Regno," <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v3 2/3] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <75495b79-65fb-4a70-a937-36f969280ce6@lunn.ch>
References: <20241106122254.13228-1-ansuelsmth@gmail.com>
 <20241106122254.13228-3-ansuelsmth@gmail.com>
 <4318897e-0f1a-42c7-8f20-065dc690a112@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4318897e-0f1a-42c7-8f20-065dc690a112@wanadoo.fr>

> > +enum an8855_stp_state {
> > +	AN8855_STP_DISABLED = 0,
> > +	AN8855_STP_BLOCKING = 1,
> > +	AN8855_STP_LISTENING = 1,
> 
> Just wondering if this 0, 1, *1*, 2, 3 was intentional?

There are some devices which don't differentiate between blocking and
listening.  If this is true, then maybe:

+enum an8855_stp_state {
+	AN8855_STP_DISABLED = 0,
+	AN8855_STP_BLOCKING = 1,
+	AN8855_STP_LISTENING = AN8855_STP_BLOCKING,

Which saves a comment.

	Andrew

