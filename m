Return-Path: <netdev+bounces-170379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27856A48686
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC95218860D8
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DD21DE2D5;
	Thu, 27 Feb 2025 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bJ+zGhXU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C91DDC0B
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677121; cv=none; b=hOmN+2ulu+JQoqPxBVRIQN+PDn8TbJKecl8g9hFUNd/xAfMfZuVDCZ8e3qQWbYjkvXiyY872D24Ao8d468CsW7trJJmd5buSnwh1bo5Z3XXygNa/Ny+MCJmSGac9haILUsQS52wXuydePhi4+ELyztDU/h7dxhW4XL3XGsOe3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677121; c=relaxed/simple;
	bh=R7qoO8KW9WlDWM5ZVWZV+/VQ3M8I+9s76NCKHvtMrXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDX7pwpXORaq3qjkWSBj45u7Se7A7qJxligsl/E9cLHPx8NlHH1/S60NrZ0FKXunqwYxCbbP8brMblFPh8ooaawkNfunu+hHhT3Nlk0340IvOAvoEMzcLaz3iTayKziglJJBjhFY3Lmgpl6galudLQmatJ3hUkWS+W/4OeLBw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bJ+zGhXU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rbxxJ9pdlSP3U09DcPRoocZLIIpwjB5GRyunBWX+jlE=; b=bJ+zGhXU3FlmjFeUxlk/urw9rv
	L3AEa6Crjr/Tt+MWVqCW0ex61iL/HQnvl3iWgmhVvH4aJHt0TkewpstPiWl9JPfnh4xG7Cb4VmA3H
	yyddM7pcXpXp+dBWq25hy9PipEB1RwCOXRY82q4gsJ30fsMS70CyliJYkoLmHF/IQw2ZA5gupv82F
	D7iolgE/gBFu84QJaTZoJ61CB8hgph05k8nciXdOQu6/rKC1BCkkqpqX0njPqk53QtXiMh7G6UJiN
	fpPWiy8fBrDilcnDsPoqV1N1h8vcTvR+syRi+ISMqC3Go2wLTTqRCVecY+SaMdYTuCPXaiGoT1bJi
	XeF9wDbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48846)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnhdD-0007oW-2A;
	Thu, 27 Feb 2025 17:25:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnhd8-0008Jo-1M;
	Thu, 27 Feb 2025 17:25:02 +0000
Date: Thu, 27 Feb 2025 17:25:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 3/5] net: stmmac: simplify phylink_suspend()
 and phylink_resume() calls
Message-ID: <Z8Cf7j530L2QaUqT@shell.armlinux.org.uk>
References: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
 <E1tnf1S-0056LC-6H@rmk-PC.armlinux.org.uk>
 <16e3f674-0267-47c1-8825-7f15a379332c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e3f674-0267-47c1-8825-7f15a379332c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 27, 2025 at 05:45:35PM +0100, Andrew Lunn wrote:
> > @@ -7927,13 +7925,9 @@ int stmmac_resume(struct device *dev)
> >  	}
> >  
> >  	rtnl_lock();
> > -	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
> > -		phylink_resume(priv->phylink);
> > -	} else {
> > -		phylink_resume(priv->phylink);
> > -		if (device_may_wakeup(priv->device))
> > -			phylink_speed_up(priv->phylink);
> > -	}
> > +	phylink_resume(priv->phylink);
> > +	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
> > +		phylink_speed_up(priv->phylink);
> >  	rtnl_unlock();
> >  
> >  	rtnl_lock();
> 
> Unrelated to this patch, but unlock() followed by lock()? Seems like
> some more code which could be cleaned up?

Indeed, this vanishes in the next patch due to phylink_resume()
moving later.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

