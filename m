Return-Path: <netdev+bounces-68512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ED38470FB
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1086D28D018
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A16B5235;
	Fri,  2 Feb 2024 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xDklo3pA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A73D63
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879915; cv=none; b=uJ8EeqGWfBSLWTLJGZiJFvb0pBUdc6WRbwcH4sbOnmHsFnS+iMvXkADisKixjkwnxVwIGOZGjbA5nh9lXOPxKBGUioYMtJzcn6KbXbqI79pPLzOlSI3D/YxC+ac1l11q1etC0sST9Dj4VcEqGT2Nb4ext8O0xtNscOs+OsIxZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879915; c=relaxed/simple;
	bh=4Nbf91FBxC/HCMXkA2e/DMpO4IyDWfLvJDd2QeNYt/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ug9ke0hunJcRfwymWcLcjos4cG+gSmdlTW40EHvd2FKoHaP1rqCwCpuF0+fbxlK+lpNAsF5lQhDKp8f4rlpmCoeqksolT7OVpMKtqrnEQF6LqHMPUOujW2qFuJyf6etxAFSNo+P9EFizdSCS6d/TYnM24WqVIhSxQeM8DeMNuf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xDklo3pA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GgHJ6mpt+sOxZhrwPb+ILFfuKufz3zU3QkcfFgIv9gg=; b=xDklo3pApLb8ZOGMPyWL65DQJw
	0x180dHVvfkqlgvdJby6hvV7d1kC10Mj+zr11NIAJR/2e4qFfisHmg1IDy2RETNnVIHBgRraW1PHK
	R7qu8Wb9T81DPmzDL3WN0mSRZd+w8C8cHhYg3isbItb65jAX3gw2kVmraq0WNfhstwRw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVtQx-006mi6-6c; Fri, 02 Feb 2024 14:18:19 +0100
Date: Fri, 2 Feb 2024 14:18:19 +0100
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
Subject: Re: [PATCH net-next 2/6] net: sxgbe: remove eee_enabled/eee_active
 in sxgbe_get_eee()
Message-ID: <04ed368c-9889-483c-b08f-9c061d433528@lunn.ch>
References: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
 <E1rVpvh-002Pdv-Ol@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rVpvh-002Pdv-Ol@rmk-PC.armlinux.org.uk>

On Fri, Feb 02, 2024 at 09:33:49AM +0000, Russell King (Oracle) wrote:
> sxgbe_get_eee() sets edata->eee_active and edata->eee_enabled from its
> own copy, and then calls phy_ethtool_get_eee() which in turn will call
> genphy_c45_ethtool_get_eee().
> 
> genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> with its own interpretation from the PHYs settings and negotiation
> result.
> 
> Therefore, setting these members in sxgbe_get_eee() is redundant.
> Remove this, and remove the priv->eee_active member which then becomes
> a write-only variable.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

