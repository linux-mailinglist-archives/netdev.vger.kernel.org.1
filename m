Return-Path: <netdev+bounces-296543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x3gnFsq9JmpucAIAu9opvQ
	(envelope-from <netdev+bounces-296543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:04:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF02656674
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:04:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=HbMuVHGg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296543-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296543-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 963A13009F27
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BFA2E54A3;
	Mon,  8 Jun 2026 13:03:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D482F0680;
	Mon,  8 Jun 2026 13:03:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923803; cv=none; b=TxXQ5YJdZLUZbKaERYigOjHzeKH9AKWlKMIjkA6riXNLtHpgYr49NRQpmDnAy3hvOlYUcVE1tlf+L+m/8V3mjx+1gGwxc2TDt5gjHgIDG7yPr8jp7cgrCGFjTPc5u5ib4ydYtZs7fip7pcVGhHlenK2ixkuBoA8mhwyoS8h7x2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923803; c=relaxed/simple;
	bh=ZfGb3yRO3uJdV97UqrPxkNCdZZ0VqT54a/R7KAZrCv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFe0RiUzLdWMc9tjF9s0L6eK9V8YCoVIk5+pTLs7HKWyXu4Fk4dqWJBJg2RgecTN13Ofr/btdKwBf5fwM15LLsIyOnMd71mttztrdoJSby/rSYu7JPRoPNgLfTXKw4BCHiMoBstEDOle3DeU18KIv5kq/E4FQM/2myfiIecfTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HbMuVHGg; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CC4F7C5147D;
	Mon,  8 Jun 2026 13:03:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C1ED55FFB7;
	Mon,  8 Jun 2026 13:03:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1045B106A0F7D;
	Mon,  8 Jun 2026 15:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780923793; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r4XgRVe/buFyPPXpJMVJDq0d56yIUHK0TN5rUg1BD90=;
	b=HbMuVHGgzgaU1FebEzJ4oThUJCl004U9R/tazgIPhKGK/iDdnO0HNXKiZAj3RijnlIYMzh
	AXYtVmjia1G56xwW/pvix4LhG24WainLDWAgzSJbaXxHYckS4oH7Yhvt4UNkScvko2zhGW
	cKl8FeYruuV+4PRHqS4kglOH2RrXScQV27lLc3dq9tnvWksKPzDtL4yA7H4ayu3duBjgI7
	03HCQiaoFKuIby1Y8hQbSsJj5EJ9S8Hr+uG9fYxOOauoY9HVY5jFImUobNATszGDZyuDpD
	FMyeCV71DRTJsWuPu8TxSc1oqKj3P+qlvr7TNEzJMgsnuCB1P/YmX3hVZ0MbNg==
Date: Mon, 8 Jun 2026 15:03:06 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Robert Marko <robert.marko@sartura.hr>
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.machon@microchip.com, luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v3 2/2] net: pse-pd: pd692x0: support disabling
 disable ports GPIO
Message-ID: <20260608150306.32a37e54@kmaincent-XPS-13-7390>
In-Reply-To: <20260607165600.1260210-2-robert.marko@sartura.hr>
References: <20260607165600.1260210-1-robert.marko@sartura.hr>
	<20260607165600.1260210-2-robert.marko@sartura.hr>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296543-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robert.marko@sartura.hr,m:o.rempel@pengutronix.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel.machon@microchip.com,m:luka.perkov@sartura.hr,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:url,bootlin.com:from_mime,bootlin.com:email,sartura.hr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CF02656674

On Sun,  7 Jun 2026 18:55:36 +0200
Robert Marko <robert.marko@sartura.hr> wrote:

> Microchip PSE controllers have a dedicated disable ports input that like =
it
> name says disables PoE on all ports.
>=20
> So lets support parsing that GPIO and using the GPIO flags to set it low
> by default and enable PoE on all ports during probe.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

