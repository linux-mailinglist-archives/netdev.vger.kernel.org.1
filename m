Return-Path: <netdev+bounces-68520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FD484711F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E413628B754
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8B45C07;
	Fri,  2 Feb 2024 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YdXu3aCa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A58442E
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880467; cv=none; b=H0eXv9czZ3LrNg3emj58S/8LtEt80ysYdYe6pdjU5h2TPi0uNwhzc4pOL/FJ1TrvBS8T/cGRv+t42c3ugRYugoz6FRAxGFV5k1hW8C6EJY7oWd2QSbQq41poXMdbMYczdkBGN9aYp7ZjFwJKQ8SQp4+ktcBgRcFJLMFKiNcoMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880467; c=relaxed/simple;
	bh=TEEsuWm23/DxzqCBNhOeZsY5ROgu/GXMI2ypw8OGtO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTpEHdUxf0wPrHPnYoCUVbSgIzoIyK0qo47wFXKmtQ1+tfVo2UcdZUj301J8VVWihtg6taBJDgELUtLo6Suspf/JDD5KC8bFQTmXBHkayUwvDGNwunN0KHdsE3cUCoePLOmHpeh6rw4/Mp4wMaZQImcKz3qtiFXpAj4hnq/i6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YdXu3aCa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CZ96REXPzgbv1rKB/gQ+nMDSX6HLKmttay56kD5KHLc=; b=YdXu3aCa2E9/AFs1Pll0plKcki
	vnG615A/ug4wDtAwALJaiOKdgjIz8XnVrQ4avj0Mr5vBuU2Uatp3u2nM8jiWH2Oy+xYgmt8/TC/pQ
	fYn5U02d8aSAmKeSpYvqwT3IqpyHVpruZotKmU0qN9S31fvyLzdn5S9dBdPBru9e2yLQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVtZv-006moX-7z; Fri, 02 Feb 2024 14:27:35 +0100
Date: Fri, 2 Feb 2024 14:27:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next 6/6] net: dsa: b53: remove
 eee_enabled/eee_active in b53_get_mac_eee()
Message-ID: <d989588f-d92a-45aa-baec-a9d616ddd11a@lunn.ch>
References: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
 <E1rVpw2-002PeJ-Bh@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rVpw2-002PeJ-Bh@rmk-PC.armlinux.org.uk>

On Fri, Feb 02, 2024 at 09:34:10AM +0000, Russell King (Oracle) wrote:
> b53_get_mac_eee() sets both eee_enabled and eee_active, and then
> returns zero.
> 
> dsa_slave_get_eee(), which calls this function, will then continue to
> call phylink_ethtool_get_eee(), which will return -EOPNOTSUPP if there
> is no PHY present, otherwise calling phy_ethtool_get_eee() which in
> turn will call genphy_c45_ethtool_get_eee().
> 
> genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> with its own interpretation from the PHYs settings and negotiation
> result.
> 
> Thus, when there is no PHY, dsa_slave_get_eee() will fail with
> -EOPNOTSUPP, meaning eee_enabled and eee_active will not be returned to
> userspace. When there is a PHY, eee_enabled and eee_active will be
> overwritten by phylib, making the setting of these members in
> b53_get_mac_eee() entirely unnecessary.
> 
> Remove this code, thus simplifying b53_get_mac_eee().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

