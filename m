Return-Path: <netdev+bounces-275384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLVQKIcn0WkXGAcAu9opvQ
	(envelope-from <netdev+bounces-275384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:00:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A07A39B6D0
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2666300D312
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 15:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0940629C327;
	Sat,  4 Apr 2026 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pC2FHrMb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632AF274B5C;
	Sat,  4 Apr 2026 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775314820; cv=none; b=VP+od1fvTdXfxGX1KdMyvFqzPkCkNjNxYjSWa5/0ZVQArBFxMhw0SQJfGS2pyT/knu0twpwrcY2T/ONzx2YJmqryTGf/e3F8Ybo2POandgmVAfH+jPRUvGjMOCcLxvBj0LIdb7FOUenbxfjI4hiJzTHMzsb8fPk5TSCR5caufGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775314820; c=relaxed/simple;
	bh=BxBq0pW83cj/LJ/GY1O2U3mZ5zW+nLtXYHYQZeFTFAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuidQIbjvGbK6AxxkxdQov85K6KyxNGYoEMuhsrlepF0XnoPBCAEgdiv+Ptl5/+v6+65vfTPUVgYbko1rCIrirVaI1WPNrKt99HYNrsMv/RM1QXkvCnYfb+OR21d2tqBJPMabiOu6CvWHAkN5kieyQqXuEo3zDd3jOim4yAJWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pC2FHrMb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uGiDq5COSDOEbEwHdHIdtFkQkbDpMOuMKKZVUbeVOUs=; b=pC2FHrMbboZjpihBZltGOyiOcv
	t0pulRRU00ZIxFnS1x67OCpfIUHJmjsSGKstVaJ/EDO0+tjNuvO30OxXj8f58wjEEkZjVRPbGxgTv
	n6J00FRIQpO2a5erQXJW8sHDMb4dHObvDeRVmtAAzcZOgrQV1AnilhhC2YbjuLkxzTwY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w92Te-00Emqs-5M; Sat, 04 Apr 2026 16:59:58 +0200
Date: Sat, 4 Apr 2026 16:59:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] Add USB Ethernet controller (LAN7500) node in
 VAR-SOM-OM44 devicetree
Message-ID: <347d7883-8be8-4c55-8b4d-4b8971ce2145@lunn.ch>
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
 <20260403131801.359be561@kernel.org>
 <2f843cc38fce1c5df9291c2e4b064241@tipi-net.de>
 <20260403151500.5225681d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403151500.5225681d@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275384-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 0A07A39B6D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:15:00PM -0700, Jakub Kicinski wrote:
> On Fri, 03 Apr 2026 22:33:26 +0200 Nicolai Buchwitz wrote:
> > On 3.4.2026 22:18, Jakub Kicinski wrote:
> > > On Fri, 03 Apr 2026 21:02:22 +0200 Thomas Richard wrote:  
> > >> The goal of this series is to add the USB Ethernet controller node in 
> > >> the
> > >> VAR-SOM-OM44 devicetree in order to allow the bootloader to patch the
> > >> devicetree and pass a MAC address to the smsc75xx driver. This was 
> > >> also a
> > >> good opportunity to create the schema file for LAN75XX devices.  
> > > 
> > > But there's no driver for it yet, right?
> > > IDK what the best practices are here, just unusual to see a schema
> > > without a driver, is all.  
> > 
> > The smsc75xx driver has been in the tree since 2010 (d0cad871703b) and
> > already reads local-mac-address/mac-address from devicetree via
> > platform_get_ethdev_address() in smsc75xx_init_mac_address(), so the
> > binding should be covered on the driver side.
> 
> Curious. So USB core can tie the right USB device to the DT / OF
> information automatically? I was thrown by the fact that there
> are no matches on the compatibles anywhere in the kernel.

The PCI core has similar capabilities. For both cases, there is no
compatibility matching going on, the hardware is enumerable and has
vendor:product information to match the device to the driver.

However the PCI and USB core can see that the device tree matches the
hardware tree, and so maps the device tree node to the driver.

This works well for devices soldered onto the board, but should be
avoided when there is a socket and anything could be plugged into it.

	Andrew

