Return-Path: <netdev+bounces-169877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B8A46327
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087A2178552
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C89F221712;
	Wed, 26 Feb 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xPG6PppQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BEB19CD0B;
	Wed, 26 Feb 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580738; cv=none; b=MxEJ8N1mxvynBOGldJFf65RaNBtV6f414L+c910X7Hl/1fXvNBn+gDRbj4ozEeD21YyPqvu9V6OkSuCBjX5t+yXs4guH30G/uyz5PJzhaUOYYM72zToU1d1nN8BIpKclIlRjpBYraMrLL4mv6UKUSXxzFvtUVMIRsMpfIiHi5x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580738; c=relaxed/simple;
	bh=5/u6wDS/lA76jxL4Byqt/Yw7pq51XwXuara9YjYfKZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIxsiOzdxRbYPpm+cN/5St1S4mq6TuYURHQWLxmaK9PZ1N6Bo+XTlp5YwL0rSApixZoRorjW2VI/VhVlSh1QaNfsOYG6/vKX8rgQbrEff38OyZhDZDBdzTe7zAgcjZObscjxm+Fy4+IS/9WdGvKDGVQVoqlYU2XDZJSDpXWPHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xPG6PppQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LyM9C/8dkXjwtrW01/wQoFLq/6QdRLnBhdNwslNvl5c=; b=xPG6PppQVoVHxQ50hWNFQM7IJf
	wJjfHN9rpc0uuV1fLvu5XZHpmodrt27SzEi4h/mQMom4WEVy0jY5MlO2iEa+zHVAfYLpUat+ND7+J
	Q8wpXQBOh+h2qkAy/tQ+AYcgU6e3XPncsDGxnvZwQGp/7c+AqflFAPJLV1DvBiHQl4DEiSilY6FPa
	KR5XwOpLmGWGdt2im9Ghzytf+z+j42u9atQ0khm/8iMPfCbDuxZHOWoP6U+ffIFD6AP2l+OrJt9d5
	xENXHesHMrtBm2A2CFbYDrqkbcan9gA5nm1C8+DDbn3sAaQgKWnp+S6xJK010i8iM5iJXsaGWR1/p
	NGYf7hWA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55100)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnIYk-0004Zg-1r;
	Wed, 26 Feb 2025 14:38:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnIYi-0007AA-1m;
	Wed, 26 Feb 2025 14:38:48 +0000
Date: Wed, 26 Feb 2025 14:38:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Martin Schiller <ms@dev.tdt.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for FS SFP-10GM-T copper
 SFP+ module
Message-ID: <Z78neFoGNPC0PYjt@shell.armlinux.org.uk>
References: <20250226141002.1214000-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226141002.1214000-1-ms@dev.tdt.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 26, 2025 at 03:10:02PM +0100, Martin Schiller wrote:
> Add quirk for a copper SFP that identifies itself as "FS" "SFP-10GM-T".
> It uses RollBall protocol to talk to the PHY and needs 4 sec wait before
> probing the PHY.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>  drivers/net/phy/sfp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 9369f5297769..15284be4c38c 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -479,9 +479,10 @@ static const struct sfp_quirk sfp_quirks[] = {
>  	// PHY.
>  	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
>  
> -	// Fiberstore SFP-2.5G-T uses Rollball protocol to talk to the PHY and
> -	// needs 4 sec wait before probing the PHY.
> +	// Fiberstore SFP-2.5G-T and SFP-10GM-T uses Rollball protocol to talk
> +	// to the PHY and needs 4 sec wait before probing the PHY.
>  	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_fs_2_5gt),
> +	SFP_QUIRK_F("FS", "SFP-10GM-T", sfp_fixup_fs_2_5gt),

Which makes sfp_fixup_fs_2_5gt mis-named. Please rename.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

