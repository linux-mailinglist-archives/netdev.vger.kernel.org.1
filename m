Return-Path: <netdev+bounces-270964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A4DI2RhwmmecAQAu9opvQ
	(envelope-from <netdev+bounces-270964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:03:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9077A30621D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D45553149E3A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5369B3DD519;
	Tue, 24 Mar 2026 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o2JHj7SC"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0053DB63E
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346007; cv=none; b=uBN4CXec3Xv7FB2arovqfRqJHRM0utULWLrIJbE/cOtN1eEBYEp6FuCnzGJe+XsVYcy6iNyQR9+dNGRkt8zlx0mysI0+a7wOedGVbVRddNR3XIlIaW1QuidCdmmrfsg5hLelWVS9pesrAL3HqqLYOGN7FrYYLCunqX/zofZ7Mc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346007; c=relaxed/simple;
	bh=5MT8PDhOYBMYWmqmrRBQBWxZxI4+1aBD255erJz/T9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Covdy2+jleiU0roQE1NJNELWVWitnCWLzEoArxsRBeosIqAfX6na18azA9aIdNeKu84Iyl7/kHqzuRObnuYOhWPUNERCOPWCcMy2098rbQC9QhPl/V8/dam+4Jf39DFLhvg3iEQ2DwBRgBGpTZgDG5GdG/upQ3rSdVAgtbQOkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o2JHj7SC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A73E01A2FC0;
	Tue, 24 Mar 2026 09:53:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D38B6011D;
	Tue, 24 Mar 2026 09:53:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EE7F1045119E;
	Tue, 24 Mar 2026 10:53:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774346003; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5MT8PDhOYBMYWmqmrRBQBWxZxI4+1aBD255erJz/T9E=;
	b=o2JHj7SCfm6NxR8ecid5mgKuScpWezj/pLsD3G5WsC8PJXTs4QqAMDv/XTBtw/JQNowi3r
	AIpPwPrFM2qJuFHBkmHs1NUyMENi0b7W8PGKU2eowRh8fuE4FESpCoDhCr7AQ41SA04J7y
	3Wq1nXgjs0F69CTcVkp3CY8mcVPvRtzRcDyrZr3AOADFSTrvagmokE/8IntLbzcd8V6h/f
	yHSucfFfIirvSloVsQCJmIG3YVJY86lcn5BW5AYdXUIcKdfcRblxgLqzBvsR7RniQgczb/
	ETrf9Wz/LpE70+IOqA9rcaU7AVJNz27s8nI/6avR5IITsLSuulKCE4VexQkntQ==
Date: Tue, 24 Mar 2026 10:53:20 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: pse-pd: add poll-interval-ms
 property
Message-ID: <20260324105320.70225b50@kmaincent-XPS-13-7390>
In-Reply-To: <20260323201225.1836561-2-github@szelinsky.de>
References: <20260323201225.1836561-1-github@szelinsky.de>
	<20260323201225.1836561-2-github@szelinsky.de>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270964-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szelinsky.de:email,bootlin.com:dkim,bootlin.com:email,bootlin.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9077A30621D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 21:12:23 +0100
Carlo Szelinsky <github@szelinsky.de> wrote:

> Add the optional poll-interval-ms property for PSE controllers that
> use poll-based event detection instead of interrupts. Defaults to
> 500ms if not specified.
>=20
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

