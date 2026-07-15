Return-Path: <netdev+bounces-307622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7+ZFGpDPVmrfBQEAu9opvQ
	(envelope-from <netdev+bounces-307622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:08:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BCC75998B
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:08:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=4Islqyk2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307622-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307622-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77AA0309C42B
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D558A18AE3;
	Wed, 15 Jul 2026 00:08:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D02C9D;
	Wed, 15 Jul 2026 00:08:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074125; cv=none; b=s5OVKBimCa8Awpq/1IQ6+lHBJwQJwhqeCV2XwvksjiL29sIE7tfTFCAJ9dNwP2LubCURXP094pFShhdA/hKS/C5CTI2gXHPGpyGg0M4CuyH5ga3mc2I8UcmYjAqchttaH9zZQ+UUWidLO9mlEYjD2804fZGryODSlCDoyScXSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074125; c=relaxed/simple;
	bh=HhTxsjwPf9ilQD9fx9qSHKloUaHkCZSe8NEirijYkI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR5y6oERpJd1wKEbsMjOZYvYb7OYAzKtk5KVKx4la5EzcIoKNIKzLHmtg8HRYI2ir/8PnXLcxjPCWqH+0OpKTs81jgBG256so0YrgnMeUmyYWfpTzfa9cWKJQY2F/GcDPrIkM9gib1/IlX8yPlbZNtHGEojbHWY1bffG22Okbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4Islqyk2; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+8CdzOLF4Z7ievgNWligxSX6Ig48hMUY6P+71lmcb/U=; b=4Islqyk2nyTlkl2gpDqKFmIDd+
	Zxv3gjGl93DFSbaX5qRBw7BW5pcPM2g6MYOdmYN54jaSNb47FxqU+BdIWQfLCHfLSGtRobpuGcGqo
	bK21NAKIJRrgsDerAsGbQoVto7KnP0QWJd0xCjsd775lQGGHHw2MDlPYfQBSoSEP5ILI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjnAu-00CGoH-4a; Wed, 15 Jul 2026 02:08:32 +0200
Date: Wed, 15 Jul 2026 02:08:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] net: dsa: mv88e6xxx: flush the ATU when the
 hash algorithm changes
Message-ID: <a607d5f5-a315-493c-971c-d5e8cab33941@lunn.ch>
References: <20260715-mv88e6x41-fixes-v3-0-9a8702b27ecc@padl.com>
 <20260715-mv88e6x41-fixes-v3-2-9a8702b27ecc@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-mv88e6x41-fixes-v3-2-9a8702b27ecc@padl.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-307622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[padl.com,gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:jonas.gorski@gmail.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:richardcochran@gmail.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jonasgorski@gmail.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8BCC75998B

On Wed, Jul 15, 2026 at 09:29:42AM +1000, Luke Howard wrote:
> Changing the ATU hash algorithm invalidates existing entries: those
> loaded under the previous algorithm end up in different bins and read
> back corrupted.
> 
> Flush the ATU whenever the hash algorithm is changed through devlink
> and reload the default broadcast entries. Per-VLAN ATU entries and
> any static addresses are not replayed, so the hash must be selected
> before the FDB or MDB are configured.

Hi Jonas

For v2 you said you thought this was a bit of a foot gun. I suggested
maybe checking all user ports are admin down. What do you think?

      Thanks
	Andrew


