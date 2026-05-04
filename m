Return-Path: <netdev+bounces-283810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPKnHpiO+Gk9wgIAu9opvQ
	(envelope-from <netdev+bounces-283810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:18:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D54BCD16
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67097301904E
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CF13CF021;
	Mon,  4 May 2026 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tnLX/bCt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAAC3C1419;
	Mon,  4 May 2026 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896729; cv=none; b=NM24bzj626N51TeFAPdjdL6hoqG0eBHGHmqMH5lQdxJ++0qgc15nJDGOY/7VK22LShvM5cNg4yjtikTV56zVxpHFzZM72jLA7I+oH0ibWNvBHLXWQfvBwC9qt+KMSOk+0BQXJS87xq6k3AaVlkMe8ueH/znaxau58NaKYRp3AHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896729; c=relaxed/simple;
	bh=2WT+1xuEUaii2BhLVWdlXp1efGYUUNZfjVLiullujCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd0mTyn5oA3HiZPS2cLWQGQwBgBOkjhnkMrIj5FCpxRumNtgsl7qOw62mYCDFR7znB7VmJPhOSv0ptmWvLrhd77B3HhX4QDB2rYI+ZqnShOkBF9IbcrUWsgoeEIDVTMRl/RI8COJI0FAjrI9BWy0BFokFIdkvCEqua7kd248BX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tnLX/bCt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IC6q3csUL/lRdwOp3q5oUmclja9Dv8UZMrCr2gsPnZQ=; b=tnLX/bCtCqEfcPK2EY6LtUJT5Y
	0cfNtcI/YKijnzSx6FsvlU/2Q+ZYu2bZmfh5EMUkOP5XgbEsXEa2wBjFz5+dhZ38HH7gfYWiTLiif
	n+q+JiLLi6XNQCt1oyB8lg2WYzk0YRBYSoGbWGbovU7bKFHVCepUvDuIyCm1fEkSSbkg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJs9F-001FxV-5R; Mon, 04 May 2026 14:11:41 +0200
Date: Mon, 4 May 2026 14:11:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Regus, Ciprian" <Ciprian.Regus@analog.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] dt-bindings: net: Add bindings for the
 ADIN1140
Message-ID: <f2caaf38-06af-4ccb-b8f9-a7dba4ae87ad@lunn.ch>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-5-dd043cdd88f0@analog.com>
 <05ae6249-1f40-4530-b2dc-e52e4f454c0d@lunn.ch>
 <2de08ad6ba73477299b6aace38b6de4b@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de08ad6ba73477299b6aace38b6de4b@analog.com>
X-Rspamd-Queue-Id: 226D54BCD16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283810-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[lunn.ch:s=20171124];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.424];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid,0.0.0.0:email]

> > > +        ethernet@0 {
> > > +            compatible = "adi,adin1140";
> > > +            reg = <0>;
> > > +            spi-max-frequency = <23000000>;
> > > +
> > > +            interrupt-parent = <&gpio>;
> > > +            interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> > 
> > Table 1: OPEN serial 10BASE-T1x Interface Pin Definition
> > 
> > IRQn MAC-PHY Interrupt Request (Active Low)
> > 
> > Or is this something else which the device gets wrong?
> 
> The device generates interrupts correctly (the IRQ signal remains
> asserted while there are active interrupt conditions that have not
> been cleared yet). The oa_tc6 driver requests the interrupt with
> the IRQF_TRIGGER_FALLING flag set

Ah, that is a bug in oa_tc6.c. A falling edge appears to work, until
it does not and then all interrupts stop. So bugs like this are not
obvious. I've been looking out for this more over the last few years
since PHYs are level, not edge, but many developers get them wrong in
DT.

Please could you submit a patch to net to fix this?

       Andrew

