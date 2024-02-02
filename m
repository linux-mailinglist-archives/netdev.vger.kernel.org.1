Return-Path: <netdev+bounces-68515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A4A847110
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77F528BBBA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36DA46425;
	Fri,  2 Feb 2024 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AYl2Dl0Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0E1755A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880365; cv=none; b=CQLl06bQFXNxGiT5+TLxMtTgtiC3fC2Qapn0ELfs2+npEmXf3khFao9Zpbl5ydAJBrqyDJytGDyhRNIr/K6XDLcDb7yRce1zUPAHehZSxt+Rk75uwYumvW3BYnf9A94PDfMdbXz3N5pgoymKFxCbOk+pWCoYV5HuXBTcLyLSMj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880365; c=relaxed/simple;
	bh=UyIYwA4jrY+dB5Ak12s6DqOkiT6k57RJZHIYm+F1d/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPCM/A1VJJJkOqS6QSdrFoyVrABZUCeKhzz6vdy3x9RG+J30Kak33e3T1y2dULQGKsO71F4zOt4N8eD4jPPNV/jKpK4ZC17LoyX4ZTuF8U0IUw5QphuB5frEF6MBRm+h/WF+p3g0qXq7jiA1YwDBpAxpSkOzVX4nXML8tdXlcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AYl2Dl0Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hW0WHlWZHkRzfP7vx+NQXC4B5kXKvIuFQN0aJlu22x0=; b=AYl2Dl0Y6fkyQuwp34z5WCPRuj
	L+MLKZpBJlyUpfgdD5wm+mpXVXW1m6R/PGIGO3MzUl6BmZ7URKpj/nxWphCk7HK0O1K/952VF8saC
	Un72O9sBSlKM098aKpO1zjhcxOtzNFl0exUJaLokVvIE/+C9k0U0cBrZPHtkXsNqr/aY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVtYD-006mlZ-Bo; Fri, 02 Feb 2024 14:25:49 +0100
Date: Fri, 2 Feb 2024 14:25:49 +0100
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
Subject: Re: [PATCH net-next 4/6] net: bcmgenet: remove
 eee_enabled/eee_active in bcmgenet_get_eee()
Message-ID: <65370f0a-c1de-453f-b3e8-33bde1b096e2@lunn.ch>
References: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
 <E1rVpvs-002Pe6-1w@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rVpvs-002Pe6-1w@rmk-PC.armlinux.org.uk>

On Fri, Feb 02, 2024 at 09:34:00AM +0000, Russell King (Oracle) wrote:
> bcmgenet_get_eee() sets edata->eee_active and edata->eee_enabled from
> its own copy, and then calls phy_ethtool_get_eee() which in turn will
> call genphy_c45_ethtool_get_eee().
> 
> genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> with its own interpretation from the PHYs settings and negotiation
> result.
> 
> Therefore, setting these members in bcmgenet_get_eee() is redundant,
> and can be removed. This also makes priv->eee.eee_active unnecessary,
> so remove this and use a local variable where appropriate.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

