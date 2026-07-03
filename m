Return-Path: <netdev+bounces-304593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KcRGNgTYR2rLgAAAu9opvQ
	(envelope-from <netdev+bounces-304593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 17:40:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C151703F32
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 17:40:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=SC7LkNhZ;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304593-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304593-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 068F3300B603
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0B93B8124;
	Fri,  3 Jul 2026 15:40:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A611FC7C5;
	Fri,  3 Jul 2026 15:40:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093249; cv=none; b=kR4UDS/XqxtcPD5yL1rQZU+F9IL9qMz1pG/tMYn9UEi99oaz9qIczGPcgouDe48wr1XMdACMNJ+In50EyxA6/oF1RkZugTqFiOTvG+n8Jbc8fMUaeZZUBntJQckSrj6kmo9IcglbxJiMIMs2J3zy827gQTxvonWhDHphL511agI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093249; c=relaxed/simple;
	bh=lDBOPhfWpfjfTE2m2gJ4x4Gu/DTzAkZFJcveYG5vugI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpzIIPSltNXjkdtf6E3diXFgh/hPYjKWIGqICiMWOmYX3sO2WNGNF4npN8DhsAIDEWWcSPkkCqcVKC5tLja6WArS1bYpHVl43MsK3MC6uw4D53a8e19fDk3SmoaLqr3QtdZww/6r81s/UykMKPbtrD4nGQsCibi/80kUE1AtHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SC7LkNhZ; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0+P/PiEPhZM42eh3ttvrxsXZZTOMysKO0Zgh2TH7zvo=; b=SC7LkNhZyaHLQpeBlvEM6EHMV9
	/wP2J5LQRTyznib2pxEH8lPCQJBUUrtYUtEAJIekFND8Z0Fu3GkDqCosrTsX106eY/UQ46OzghohC
	FOwTJTGlgrKuJnbI3rjMw7GCU/odtPKuglfZf/43WBSeHU7EZJ/64IaNhBPKKwGQe80Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfg0J-00AZHD-Eq; Fri, 03 Jul 2026 17:40:35 +0200
Date: Fri, 3 Jul 2026 17:40:35 +0200
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
Message-ID: <9eea72a5-b30d-4543-ac97-179743d99950@lunn.ch>
References: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
 <20260703-mv88e6x41-fixes-v1-2-fbd3a1bf8965@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-mv88e6x41-fixes-v1-2-fbd3a1bf8965@padl.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304593-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C151703F32

On Fri, Jul 03, 2026 at 04:42:56PM +1000, Luke Howard wrote:
> The default 88E6341/88E6141 ATU hash algorithm appears to result
> in frequent collisions, evicting permanent registrations (including
> the broadcast address) out of the ATU.

Is there any documentation about how the 88E6341/88E6141 hashing
algorithm is different to all the other chips? How is it special?

> This workaround disables hasing in the ATU control register. It may

hashing.

> have a performance impact (the data sheet notes this is for testing
> only), but it also enables correctness, at least in local testing.

How do you define correctness? Are you using a well defined test?

Why is the devlink parameter not sufficient.

    Andrew

