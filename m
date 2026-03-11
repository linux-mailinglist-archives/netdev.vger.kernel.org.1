Return-Path: <netdev+bounces-266738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIRQCv+zsWnbEgAAu9opvQ
	(envelope-from <netdev+bounces-266738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:27:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA29268934
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFAD53075E9A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8483E716A;
	Wed, 11 Mar 2026 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bT5ynAko"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB018FDDE;
	Wed, 11 Mar 2026 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253491; cv=none; b=cGfn7gcpqgBIIu85o2P/yu6mH5uYEyp+WDegbbN84luuKgMvBCX0hsy7uota1YP7n0sRWO9Ilk+xC9PIziQ5lr0RanhWfqWQ0cjMzWU7ZeSG461IRX5N5sdJdy1Xr1qunYy88kpZPzEQUnthncz+EjusqxcZrg+X95KKJduV43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253491; c=relaxed/simple;
	bh=OXZJ3a4eImvzTCfcsyMa7gBbGVARrCrSGe9gQuXqEvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUci3HqzJ7k7xKZXcsrQY8cs38rMaAJ8brTpR5dSVxjexzyVmQwsceTreOKDQR1PW3IzqrEM9joskiyH2DF+KtBtngqmSnBrpwL07fHD5sNFhcLgdrnx6elkbtfWK5znkClL/Q1di7vXPJ2Xysv09y3oVPrdp3T1YImZMTFwks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bT5ynAko; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YTexr7dpcyHGhGNlWafQmlROMLwbxDWQe14nAtF6Z/U=; b=bT5ynAkoXyKZmoOGPyjHaJvFNu
	/TfUdkIyhoXMbFpJ1jNkEOg9cv/Veb70Q4zc640Twbp1K94lDhevx9Eh6eZkjPGkUUguBpUjxNpxG
	az0hl8EO3EQZpbgsm55JXLVddwdRoKaNu4g/cai1ICNNvpJ0dsFkhZV+EDGSi+r7EAhY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0OEa-00BDkL-Hu; Wed, 11 Mar 2026 19:24:40 +0100
Date: Wed, 11 Mar 2026 19:24:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Woojung.Huh@microchip.com,
	UNGLinuxDriver@microchip.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, horms@kernel.org, pascal.eberhard@se.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, Tristram.Ha@microchip.com
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <273e230a-b4ad-4ebf-9552-2416a9988019@lunn.ch>
References: <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
 <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266738-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,davemloft.net,google.com,kernel.org,redhat.com,se.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 4CA29268934
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The biggest difference I see is the way KSZ8463 accesses the registers
> through SPI. It uses byte enable bits in the command word that don't exist
> on the other switches.

Can that be hidden away in regmap? Add reg_read/reg_write functions
specific for this device which handle these byte enable bits?

	Andrew

