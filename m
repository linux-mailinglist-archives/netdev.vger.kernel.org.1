Return-Path: <netdev+bounces-262214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C/TNlhRo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:34:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 490931C86D6
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1A86301A2BB
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2113727B50F;
	Sat, 28 Feb 2026 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZPIelEqM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03D2D0C79
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772310688; cv=none; b=HEqU96mmVgKDAmys95ilr97O7gXJcSxT6af+Jmsh46UPul+7PnVUfSMTAzU5FiaHIhxSCl7Q3YPYx8VFOUNRd33oDT76ZRK56PtYzGqQtanQwXviC0jzKfAgVV0mHE/4wBRWkroQmwggdLi6HMYnOj4XPS7vGDxLyCNDeFaRig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772310688; c=relaxed/simple;
	bh=PnltOAfz+yZUl0NCtYutNI1n4JIg3WZLyegty4BKc9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyG6Q9KxdhwidAMWsjrk2/rrK3521m0up1dybJOQpRnWMCqHMLYgT0Rk11wjJPf56h2L594AuJhEgq/Cte2yWiRSeF6qG5DhjXPhnUYd876Ea1KgEYhqtCwPfMltiaiFtRZfWV3a4xsb/NJU5sXFIVxyL1EXJ1QPacHftrM1nhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZPIelEqM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nMxDUrLuLUd3EietRVzH2dDww4K4V7mpwa5/kLdWqWs=; b=ZPIelEqME7sp6eUIjb3d/4zMhg
	tTMHiEiTkCLM5WkA0gujPoy8R7GEC0+fpVNjCoAO/nolK1otT6hrR5RU4B43cp84e0lUqeEwpUWbK
	2qUcph6hBAo2TtwvqWrhJ5BfQfA6EIMGeiHXFUQWaioarRkRl0htoGP8NMqrOI9BluZw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vwQyB-009Diw-Vj; Sat, 28 Feb 2026 21:31:23 +0100
Date: Sat, 28 Feb 2026 21:31:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH 2/2 net-next] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <62e825cd-7b5d-4839-a8d7-ae936dfa03fe@lunn.ch>
References: <20260228185242.800836-1-joey@tinyisr.com>
 <20260228185242.800836-4-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228185242.800836-4-joey@tinyisr.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-262214-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 490931C86D6
X-Rspamd-Action: no action

> +static void mt7628_vendor_phys_init(struct dsa_switch *ds)
> +{
> +	/* vendor specific init sequence from openwrt/uboot */
> +	mt7628_phy_write(ds, 0, 31, 0x2000); /* change G2 page */
> +	mt7628_phy_write(ds, 0, 26, 0x0020);
> +
> +	for (int i = 0; i < 5; i++) {
> +		mt7628_phy_write(ds, i, 31, 0x8000); /* change L0 page */
> +		mt7628_phy_write(ds, i, 0, 0x3100);
> +
> +		/* EEE disable */
> +		mt7628_phy_write(ds, i, 30, 0xa000);
> +		mt7628_phy_write(ds, i, 31, 0xa000); /* change L2 page */
> +		mt7628_phy_write(ds, i, 16, 0x0606);
> +		mt7628_phy_write(ds, i, 23, 0x0f0e);
> +		mt7628_phy_write(ds, i, 24, 0x1610);
> +		mt7628_phy_write(ds, i, 30, 0x1f15);
> +		mt7628_phy_write(ds, i, 28, 0x6111);
> +		mt7628_phy_write(ds, i, 31, 0x2000);
> +		mt7628_phy_write(ds, i, 26, 0x0000);
> +	}
> +
> +	/* 100Base AOI setting */
> +	mt7628_phy_write(ds, 0, 31, 0x5000); /* change G5 page */
> +	mt7628_phy_write(ds, 0, 19, 0x004a);
> +	mt7628_phy_write(ds, 0, 20, 0x015a);
> +	mt7628_phy_write(ds, 0, 21, 0x00ee);
> +	mt7628_phy_write(ds, 0, 22, 0x0033);
> +	mt7628_phy_write(ds, 0, 23, 0x020a);
> +	mt7628_phy_write(ds, 0, 24, 0x0000);
> +	mt7628_phy_write(ds, 0, 25, 0x024a);
> +	mt7628_phy_write(ds, 0, 26, 0x035a);
> +	mt7628_phy_write(ds, 0, 27, 0x02ee);
> +	mt7628_phy_write(ds, 0, 28, 0x0233);
> +	mt7628_phy_write(ds, 0, 29, 0x000a);
> +	mt7628_phy_write(ds, 0, 30, 0x0000);

Do you have any idea what this is actually doing?

Normally, a MAC driver would not touch the PHY. It would be the PHY
driver which enables workarounds for erratas etc. 

Does this PHY support C45 over C22? Can EEE be disabled in the normal
way, writing to the standard EEE registers?

I would try to put this code into the probe function of a PHY driver.

	Andrew

