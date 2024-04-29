Return-Path: <netdev+bounces-92055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31688B539A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E075280D43
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5717BCD;
	Mon, 29 Apr 2024 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F+YREqED"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C88C2C8
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381147; cv=none; b=COtw/zTdlzWami8GmTI0ocLTbm3lRapjwp15MEaHIEFdosNkX0AmTzudVCXRcNRfAyT0U/UMZtiMgfviZtpwv/4HGO5rr/NSsz2SiD7zg/LjOppI4zYMcm89jKlmuuXQgQStknOn2dQO9NjpsmOamhIpy9hQFgBQi6fb5xfs6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381147; c=relaxed/simple;
	bh=PmE8vHBGTj4Iyf5RTCdJYNGXVLXbjY63ut0L9Jaft1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUHpDhOw0N8eS2e+2qeOmubrQz3uIQJkm0JT9Pbwk2FBreRCbyWMTs/RwjPNwSP2zsuUg7brRUgQOO1Z2iyRu+S06zsnaHlW5LRe791p2fRFnh8CzoM35TTS7GKasJz8/7R8rN17UEF9eufjcT6LglRJhYnoBGCoqcXApPlm7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F+YREqED; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s1n7UojPf0KvZHNSfpgxeU/9t0d+iSqFBcUEtKM6K8g=; b=F+YREqEDseZGJQoVyh+qzXb+Ul
	BysCGA1VMUUbaFlULEmIMaP17c+7H7UD93bH733CV+rdLUrjhGg+iWW5A8vO6EeL5JalkpVgzI64g
	l9kCiaPDDwyyeqn5T4N8l9SOH69YspQC2hJSStzQ1cReJ1RkP8MEa1037yz9yXKk5yOqz6pDcMaFY
	SD19xxWdxG1j247MDRxf8sn3x0BWRvwMwI8OxxDSYnk/SqYAq3Ke6CIisTv68J5LN7qgOlzRf8+mk
	ndZjc48lXkXkLcV3pHlaD81PzHB5R526pKc3tRjM+8hyctOg/Gc0qPH7Dutp+bQDmLJvoQUgFjVGS
	LN8RJfVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51046)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s1MqV-0002sX-1Y;
	Mon, 29 Apr 2024 09:58:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s1MqU-0000ia-B9; Mon, 29 Apr 2024 09:58:46 +0100
Date: Mon, 29 Apr 2024 09:58:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp-bus: constify link_modes to
 sfp_select_interface()
Message-ID: <Zi9hRst2uBGgbWo9@shell.armlinux.org.uk>
References: <E1s15s0-00AHyq-8E@rmk-PC.armlinux.org.uk>
 <20240429082511.h32rsx5s3iu2jlpe@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429082511.h32rsx5s3iu2jlpe@DEN-DL-M70577>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 29, 2024 at 08:25:11AM +0000, Daniel Machon wrote:
> > @@ -593,7 +593,7 @@ static inline void sfp_parse_support(struct sfp_bus *bus,
> >  }
> > 
> >  static inline phy_interface_t sfp_select_interface(struct sfp_bus *bus,
> > -                                                  unsigned long *link_modes)
> > +                                               const unsigned long *link_modes)
> 
> There seem to be some misalignment on the opening brace - at least in my
> editor..

It's intentional to avoid going over column 80 (I use an 80 column wide
terminal to edit.) It's either that or the thing gets wrapped differently
(which then means one loses the return code when grepping.) From a
readability point of view, this is what I prefer.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

