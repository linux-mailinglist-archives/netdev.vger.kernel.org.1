Return-Path: <netdev+bounces-287960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMplDkzLBWrvbQIAu9opvQ
	(envelope-from <netdev+bounces-287960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:17:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E125422CD
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60B923029631
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230453DFC81;
	Thu, 14 May 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RonAfqFn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD33BFAC8;
	Thu, 14 May 2026 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764602; cv=none; b=g1oSpx1ntcbHsCNGqjWpw4MSDs/GJ7aCdMkBw3RHhsblDFT7dJKZQgVvsKBTve5iCVeU5uX1fduXpK0duX9hFwedByLsSuOcl2EpESJq9E054maKWVCvaqu4jGoZ0zTTwi0mkrshCbOE6wY+quITBm8IhRFN/g3AwiRdAVNjyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764602; c=relaxed/simple;
	bh=dLQRcRkcA46txUCXuJ2km9A7HIs1N3NYIpzMw9JTGTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlFexUF+8NOnw4bUQLjzkmaozeg4yJr15EO38IccbHAjBCNA0d1LxG3txYo23kffk34+cr4a8eQHLulSsW+qbYFpusufGGh9/Gm5HAIaolXk067tAr8dO6sJolOo/79T9B+Cj+Lp7b/xIHlNhXZd/KRT+8DZCXmw9ro7wjoVlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RonAfqFn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G4fPOWWTSjI5yvRz5lPq6nB+O5BhDTbqkRTco99Z8Wo=; b=RonAfqFnFtgqoB8ydY6b7UKK0j
	roADVpo5j+UOfNpWe/5KKxu/bulV/kIWdVSBEe0gL7L0HaAmvGcU1N2oCZ0FMWmyvaJRzsCsod1md
	C2oF2amkmEVl1+xqG0j2erDdYAVd7RDPVT2YpsisfoCfVfMsgtr1c95bsssqekHy3tX8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNVvU-002uNe-2w; Thu, 14 May 2026 15:16:32 +0200
Date: Thu, 14 May 2026 15:16:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] net: lan743x: Add PCS/XPCS support for SFP on
 PCI11x1x
Message-ID: <a044fcc6-554f-4edb-ad49-194d11eb6124@lunn.ch>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-6-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514105028.42942-6-thangaraj.s@microchip.com>
X-Rspamd-Queue-Id: 97E125422CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287960-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

> Integrate the XPCS instance with phylink by providing a mac_select_pcs
> callback. Support SGMII and 2.5GBASE-X interfaces in phylink

Not 1000BaseX?

>  
>  	switch (adapter->phy_interface) {
>  	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
>  		__set_bit(PHY_INTERFACE_MODE_SGMII,
>  			  adapter->phylink_config.supported_interfaces);
>  		__set_bit(PHY_INTERFACE_MODE_1000BASEX,

So it looks like there is some sort of mixup with SGMII and
1000BaseX. They are different things. Can adapter->phy_interface be
set to PHY_INTERFACE_MODE_1000BASEX? Should there be a case: for it?

It could be the broken documentation, using SGMII to mean PCS, has
resulted in other problems with 1000BaseX not being implemented
correct? You might want to look at all the "SGMII" code and fixup all
the 1000BaseX issues.

	Andrew

