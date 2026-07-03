Return-Path: <netdev+bounces-304673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jwgZNB8tSGqDnQAAu9opvQ
	(envelope-from <netdev+bounces-304673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 23:43:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE2705F4C
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 23:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=PswdgUND;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304673-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304673-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 339D43040F92
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 21:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052BD331EA9;
	Fri,  3 Jul 2026 21:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42049344D90;
	Fri,  3 Jul 2026 21:43:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783115024; cv=none; b=GFA883q/HOnzSJA27pu8W0Y3R0rCHrwgbHUvzB79lTIKuNjF6eenDFM1mlcqkqAR3xrHwOKmpvBEYSkSlgNoQ9/FqO8P9PdwVxQoeOWr0ye54zXbdc1WCNlBawWG15bQgHpGEg8Ryq/N4FPGyNjaIQsK8BWQWR6tY5+kn4+TfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783115024; c=relaxed/simple;
	bh=sh1v0BgyiVrbIWK1EhotgEJABJE3oFph91vxVNoM80k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kjfe6Gi7aG+IErZarD5NmyBda1JrvDolfSdqFVTPJdDiQ/Jl9rsRFfs5wceYJ2fpBdlEzwnwyvyW17pPcmGNVW+NEepXtRvfmHTkIFOqRSfdx8v6HRvs6fKviixd0jIhcp8Er+tpUcMtwBxvbZtnNwxh50OES7HJDlhBqLJGiHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PswdgUND; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fyh5Jz/zd3eMw7zxHR3YpP3JEnNl9pLHOSLEVxhX9JU=; b=PswdgUNDfK0j77zSpts3KFqilk
	Tg/7gAaorWwowak+5h9GC/dvOdh90XGydgYB4s/Rf+JzqIEtwBu2boubm6sUGeStMLYSv4Zdjorct
	RSdNySLEtb8b8X0ReJ5tr/xCVRlYZZc4/Rb6eCAD4ewsJHxu1vnN5ZqzmJlDj6q/3SIw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wflfO-00AbsA-Dd; Fri, 03 Jul 2026 23:43:22 +0200
Date: Fri, 3 Jul 2026 23:43:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: use direct ATU hash on
 88E6141/6341
Message-ID: <8c2fd5d8-6b64-41d1-9dd4-bb1db687b844@lunn.ch>
References: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
 <20260703-mv88e6x41-fixes-v1-2-fbd3a1bf8965@padl.com>
 <9eea72a5-b30d-4543-ac97-179743d99950@lunn.ch>
 <81F61D3E-D9EB-4646-A401-9C34BAF0903D@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81F61D3E-D9EB-4646-A401-9C34BAF0903D@padl.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304673-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FEE2705F4C

> No documentation, just my experience, which is why I asked in the
> cover for others to test. I can include test results with the next
> revision.

Not so much the test results, but the test case.

The reason i added the devlink option was because the network
contained only devices from one vendor. So the OUI in the MAC
addresses was the same, the usable number of bits in the MAC address
being cut in half, in the best case. As a result, there was a lot of
hash collisions. For this special case network, the test mode hash was
better.

If you are also seeing a lot of collisions, it makes me wounder what
your distribution of MAC addresses is.

> >> have a performance impact (the data sheet notes this is for testing
> >> only), but it also enables correctness, at least in local testing.
> > 
> > How do you define correctness? Are you using a well defined test?
> > 
> > Why is the devlink parameter not sufficient.
> 

> Devlink would indeed be better, but changing hash mode with a
> non-empty ATU causes it to be corrupt on read back. Perhaps the
> right solution is to flus the ATU when changing hash mode via
> devlink.

Flushing the ATU would make sense. It could well be in the system i
was working on, once it was shown to help, the EEPROM contents was set
to configure the ATU hash at hardware boot time, and devlink was not
used in production. The vendor had a bad habit of using the EEPROM.

     Andrew

