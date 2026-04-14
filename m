Return-Path: <netdev+bounces-278257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNjGHqCO3Wn5fQkAu9opvQ
	(envelope-from <netdev+bounces-278257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:47:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419D3F4A0C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30CD9300D767
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E254121ABD7;
	Tue, 14 Apr 2026 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjQFzd8j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5D1EB5E3;
	Tue, 14 Apr 2026 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776127643; cv=none; b=FXen11h8qG40UwJu+gvFBthzZbBh2xjrKKIxGvTH+TcsOHTtrHCey95HJT/Xkh5aXkT+B73TdJF7IgFicc6d5a9b0zQ3ddoMOqyfpY9NS1aCEou8uPBiYe51SsFZRFtN1GspDGVZJRaQC1HULbIVeqzfzW4Qo3Ad+lfpnjFTRGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776127643; c=relaxed/simple;
	bh=h0YnwdiV+EzKzA/fSvXQ3caa96S6lMOPGWgi2nVSHRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufV8GZSuglaW5eT/cjIL5TRo+14JqNJsjkfmbNko+PRkiiPQeFE8C8LcyFkvj2HAi7uG17hU7frqKs352iWCKlaPcB8Pe91Wnb6VDrrj2rGmAvktSofTUZBxyDUTp2FmzPsDTzQzk0IXupH6FTvrTul8aAorbCEkLhj+Brl91S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjQFzd8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3C7C2BCAF;
	Tue, 14 Apr 2026 00:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776127643;
	bh=h0YnwdiV+EzKzA/fSvXQ3caa96S6lMOPGWgi2nVSHRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SjQFzd8ji4pMzM7Cu0Orv9Ksnj2KxrAFCesnzuKySm/lKwvgRioCgiHMOP/4R7uzu
	 1v+m3qZyqFN0vq+ASftWyO+9hhJXl1Lyc3uFSpihT9gvKaWBoWC+ZI9E86BjJfF9nv
	 RgLIbGVlhGwqNaSmt+flRd84ARSjeHaYmKVpiFwD0zdl+yYCqHCyFqpeS+rhYt/tTi
	 boVkqfVzx7mflUFZPSLs8k5SH24t/GsJ+034Uc8nY72ASxsAXilqZsyBfAxJ11MKgd
	 jRiMAu30eCvdR9NqP+L+vQUXWs9BAbhlkH4RBie6ljhm++43pURBtkV2MN4sDf9kJQ
	 63khLth9LHDlQ==
Date: Mon, 13 Apr 2026 17:47:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Paolo Valerio <pvalerio@redhat.com>,
 Conor Dooley <conor@kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/14] net: macb: change caps helpers
 signatures
Message-ID: <20260413174716.39915c92@kernel.org>
In-Reply-To: <20260410-macb-context-v2-9-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
	<20260410-macb-context-v2-9-af39f71d40b6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278257-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,tipi-net.de,mobileye.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1419D3F4A0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 21:51:57 +0200 Th=C3=A9o Lebrun wrote:
> For parallel MACB context to start become a reality, many functions will
> soon not have access to `struct macb *bp`. Those will still have access
> to caps through ctx->info->caps.
>=20
> Change all caps helpers signatures, from taking `struct macb *bp` to
> taking `u32 caps`.

Subjectively I feel like this is a slight loss of type safety.
Someone may pass the wrong u32 and compiler will not help?

