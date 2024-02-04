Return-Path: <netdev+bounces-68946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC4C848EE7
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F6F1C2108D
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379DF224F2;
	Sun,  4 Feb 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ujoVmz+H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE41225A4
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707060246; cv=none; b=FHlbXhhUhsK5VXE05EHV5wt9dv0GiIA1EYd207OmnxR267lLw468RS73S9fzSSsmGF7tPzgl0NhcqdUNTH6wid0f/198EW5jnARD/nmAptow0Wo0MyNeLR4qqmkS1GGdHz+zqUDU7XMkkpWnrhVHH7Ebvi0YHBILZ31bDPkHl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707060246; c=relaxed/simple;
	bh=6lUL8KmzRVbzUErtD0OydhQfNnA9AAujcfj3dlLw5fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4u1mOeY5kK4gMRUaVEsNUteFi68aLxAfny6O8mmwsRymeFLLIwU/olDgIHmjHgwk5MsmCYc7KXTHUk7FDi4xfr3hLco8cszcZVKDH6fH1HzYU0aZ+SaiwxISBolMClhg4AJs7wjff2H5P0o69RJF/v5znw23F/Ep+q7nBCUPVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ujoVmz+H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6LTRiOq9cQHbHLqnjRFUamncJsroF08b44hf/otCMGE=; b=ujoVmz+Hqhrwhh86rYZwK2r+XT
	o46NySruJphF3hgSE+ITPDcX05tMbjMJWUV55So2A6Pzf+9QA3Fo5O+nR8RdxRfX3Rf3G/a3MTklT
	l5Jy/m4Q0tUVAmxfLJK4XRtTJazpls66kV7iDSiSZPhgLblIGEyeDcew4OgL4Y+WmVu8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWeLT-006xvx-UQ; Sun, 04 Feb 2024 16:23:47 +0100
Date: Sun, 4 Feb 2024 16:23:47 +0100
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
Subject: Re: [PATCH net-next v2 3/6] net: fec: remove eee_enabled/eee_active
 in fec_enet_get_eee()
Message-ID: <d3d427e4-1d45-4527-98f4-959fcfc13391@lunn.ch>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
 <E1rWbN2-002cCh-MY@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rWbN2-002cCh-MY@rmk-PC.armlinux.org.uk>

On Sun, Feb 04, 2024 at 12:13:12PM +0000, Russell King (Oracle) wrote:
> fec_enet_get_eee() sets edata->eee_active and edata->eee_enabled from
> its own copy, and then calls phy_ethtool_get_eee() which in turn will
> call genphy_c45_ethtool_get_eee().
> 
> genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> with its own interpretation from the PHYs settings and negotiation
> result.
> 
> Therefore, setting these members in fec_enet_get_eee() is redundant.
> Remove this, and remove the setting of fep->eee.eee_active member which
> becomes a write-only variable.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

