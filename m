Return-Path: <netdev+bounces-299559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MOFFEpk/MGqVQQUAu9opvQ
	(envelope-from <netdev+bounces-299559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:08:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A52DB689107
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:08:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=XiqL0VFv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299559-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299559-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD94D3041B9D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07133016FB;
	Mon, 15 Jun 2026 18:08:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B026A1AC;
	Mon, 15 Jun 2026 18:08:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546900; cv=none; b=nweJlbWbPdBc5QRIOInuIqDjZf5lHjcpLhnOnFaqCazJ996lENg/lJHznpBZZoIkhvSAUdYW9y4qgmQmCrU29Jz6pS5Da05LV33vpYLMY9/X1jS78hltkXk5rxZFUCbgXeh2VndSVnohz/JEWHUfPn/kZDNlJA1BAlPpwoJd6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546900; c=relaxed/simple;
	bh=U6C2qKMwr8EsK4mfzTGjNKCIxqE7A8KQ32aGXqRNLmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTkejF5fYYTJ6WyCRXwo4B//6NDxtFfAVS6Vp8fPCvBzrR9Q6sUoZnN5iharDExGkFApB6o6Mmj67gtGP0FepYbkVcK2SjMSuRLnciYn1XJgbg6tzBgeYoDk6VgMNShOxoa+AgBlcKJdjSOa+wI3nKNEFN1L8QZCuDhHV6YThM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=XiqL0VFv; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 27CDBE83B55;
	Mon, 15 Jun 2026 20:08:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1781546897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6C2qKMwr8EsK4mfzTGjNKCIxqE7A8KQ32aGXqRNLmw=;
	b=XiqL0VFvJ4SwlFfVjkzd0QR3Hj+B+C9HYpHDssVIxLagdqjBevPD8UFH2q7WPX9y1Lypj/
	ADl2lWF8vvMzXVSHM9BG1PZzxa9A7YX7/0dwS4PgRieJs2bLOo8YTrf7GqXQFVS5Xurwpv
	OHjI0vLa8oKxuKIuAHMx2933P7wGZyIsD8txNVxmwgAbA0rQYWR5oLPOevgCWgUZpnJ1iE
	a8UxQmW3+nmk29vyRNjohLE8R/oMWu5tZWO4XYkyq9s5lLDS8/Age+IsdsIr6UCeqKJTHD
	1MgYadJ5jrAc+6aaF7CZNWlktjjxmWUGNHL1meljDb/iDwRJmfFnV2r0hVfC1A==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 1bEVtuS11M5U; Mon, 15 Jun 2026 20:08:17 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 15 Jun 2026 20:08:16 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Corey Leavitt <corey@leavitt.info>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup from MDIO probe
Date: Mon, 15 Jun 2026 20:08:12 +0200
Message-ID: <20260615180812.829678-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177795581584.12433.14568712745388778289@leavitt.info>
References: <177795581584.12433.14568712745388778289@leavitt.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299559-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:corey@leavitt.info,m:kory.maincent@bootlin.com,m:kuba@kernel.org,m:linux@armlinux.org.uk,m:o.rempel@pengutronix.de,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,szelinsky.de:dkim,szelinsky.de:mid,szelinsky.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A52DB689107

Hi Corey,

just checking in on this one. Did you get a chance to continue with the
series, or is there anything I can help with to move it forward? I'm
happy to test a v2, and I can still run the SFP path on the
S600WP-5GT-2SX-SE once it's back on my desk.

Kory, Jakub, Russell :-) it would be great to hear your view on the
approach so Corey can plan the next version. The series fixed the probe
loop in my testing and I'd really like to see it land.

Thanks,
Carlo

