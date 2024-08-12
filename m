Return-Path: <netdev+bounces-117738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5672394F074
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8084B2556F
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439E6184538;
	Mon, 12 Aug 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YkMf3q3n"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1C184529
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474207; cv=none; b=SG8T+LxhTR+44f1PyiLcgtWS11AtEFLgP06ttjuvZqftxm0j/L3tRQy9IcpFsQU9E3AFCKR3pJFsf66kEUdtZO7onSncM+/r65OrnsOTn4SwlTilyCySKB5aP9c5lha2fMHNCRS0JYT5A4W+wuRf13eI35CdZQ+dQCUfqRG/0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474207; c=relaxed/simple;
	bh=Ja2Hw/FbLdlx9gYd4WYEZ3YirX2YZ1uWj+oLEm9CW/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xox1fwvHESXUxwZXHcQgGuJS0EMuGMMau0Nav08JznjAHkkntPrUA9M0WSvMEOY6ipxiKU6DoDhZeBq5Dy0lWHg1C3b3FZhUJwHlteH681OfhY3vhkblcfRCXiE9pB66qB8Xg0i5wM/TIZ7NvnKzyyR8xhqMfx5wPoeiADGa3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YkMf3q3n; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iqonCG8m29OHfu4ThWWzT6JCNotcwXB/x9DJlczWMM4=; b=YkMf3q3ne2MjIwYxfmTgyLR6kz
	CIzxfTz9VMZF/3ZtiQM/UDWHjqOF/UanrQpuvBiOn8fXbWVNWKa3A+QVGprUN0kM88P+0vbu0EC3m
	lL99II2ZTKy4thlfScaL6ycyxB5DC2dLyBNTueHTzQAHW+aknNJTHizfh8fTnDxgKBgdkL70zGsPm
	nvaizAbwmM47sPn1GV6sCOU25E1I1kqeJMjd/qNmKPlg9F2tcKxPYoOt8oCbrpDPUQR1pe7cpfHfe
	RKtz1wDBli+tvL2MU6mpPoNJsehtAzDSAal5ePUMS+5BsOZMIAjt+b4fWoboPpkwcSnhwXyNBUPij
	Kaut+oQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36514)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sdWMm-00043m-2m;
	Mon, 12 Aug 2024 15:49:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sdWMr-0000YN-Pr; Mon, 12 Aug 2024 15:49:53 +0100
Date: Mon, 12 Aug 2024 15:49:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND net] net: dsa: mv88e6xxx: Drop serdes methods for
 88E6172
Message-ID: <ZrohESS4mC4c2Ggy@shell.armlinux.org.uk>
References: <20240811200759.4830-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240811200759.4830-1-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Aug 11, 2024 at 10:07:59PM +0200, Marek Behún wrote:
> Drop serdes methods for 88E6172. This switch from the 6352 family does
> not have serdes. Until commit 85764555442f ("net: dsa: mv88e6xxx:
> convert 88e6352 to phylink_pcs") these methods were checking for serdes
> presence by looking at port's cmode, but in that commit the check was
> dropped, so now the nonexistent serdes registers are being accessed.

NAK based on commit message. See my comment on the first one for why.
  	.gpio_ops = &mv88e6352_gpio_ops,
> -	.phylink_get_caps = mv88e6352_phylink_get_caps,
> -	.pcs_ops = &mv88e6352_pcs_ops,
> +	.phylink_get_caps = mv88e6172_phylink_get_caps,
>  };
>  
>  static const struct mv88e6xxx_ops mv88e6175_ops = {
> -- 
> 2.44.2
> 
> 

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

