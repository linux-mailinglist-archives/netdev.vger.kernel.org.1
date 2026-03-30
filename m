Return-Path: <netdev+bounces-273133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K+2AvBcymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E5235A246
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B763B301179D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E073ACA64;
	Mon, 30 Mar 2026 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CchhoiKF"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE333BA238
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869421; cv=none; b=gqCje6s88dhxcyCWD/eOcxNvPMhGMziUJ9PKIPIHaKY8VpAROUhrpX0+7+Qnv7nGJOksTQHoXOiKu9xvsP2icAHLG90q4taQYh0Gc72rN4wIJ2wWF8w7uJTeLoBYB9pZdaxSnlM3p6dTIdXKpiVv4ezXsDdvnTEU1EtXRwOdMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869421; c=relaxed/simple;
	bh=7K0HUEBoIAv5bFmgT9u9jQZ9dVsxysqkCU/DVAA7Ft8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiPfi4VlM30TcGTUuNCO59qv8gLUKpq9fvehvOZ9cI+IxWzM4TIFjLdznKX4gtVgrsrpbKjoMuzVDbusF24mbNGZow3yefMUe3/iUm70vBLgGJWHbozJ/LrDNY5Ulvz8n1cnuzkTv0HaDuoMk/pwIORfjUEm6sqz27kneBhE0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CchhoiKF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2888B1A3091;
	Mon, 30 Mar 2026 11:16:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F1D1A5FFA8;
	Mon, 30 Mar 2026 11:16:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8BC310450088;
	Mon, 30 Mar 2026 13:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774869415; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7K0HUEBoIAv5bFmgT9u9jQZ9dVsxysqkCU/DVAA7Ft8=;
	b=CchhoiKFoK0hm8uGXfCrNdfrS/IZeBH1j/a9mglLpOXUVgjpyNe0JsL23vpbjdHA4ghqVu
	42zpLgdt1YCpJB8aPuKgqA/0yWCQC9zQ2FKoa1mY+X0DRDFlDBVo0mW6JxfzcHUfG9IU+b
	OZwiNW2id8+q2IYLt7QiSL8fc0ws2mY3lBn+MIzEEy6wmtU87cjLSJFOYVvp+krHy/HGwu
	FAwoVZQS844V+t32gJVpqKzCO9OTf35q4mXQe5Dv2Km88bX0KbiHTbgAo+Uq8UcU7Sc7mS
	8xgxQdCDd1rZFVFO7/Uxjt//ulHT7N9vOAiWR5olMQC39qbRLSHscJ3huztfLg==
Date: Mon, 30 Mar 2026 13:16:51 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: mdio: treat PSE EPROBE_DEFER as non-fatal
 during PHY registration
Message-ID: <20260330131651.61984be5@kmaincent-XPS-13-7390>
In-Reply-To: <20260329161014.2908509-2-github@szelinsky.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
	<20260329161014.2908509-2-github@szelinsky.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273133-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szelinsky.de:email,bootlin.com:dkim,bootlin.com:email,bootlin.com:url]
X-Rspamd-Queue-Id: 74E5235A246
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 18:10:12 +0200
Carlo Szelinsky <github@szelinsky.de> wrote:

> When a PSE controller driver is built as a module, it may not be probed
> yet when PHYs are registered on the MDIO bus. This causes
> fwnode_find_pse_control() -> of_pse_control_get() to return
> -EPROBE_DEFER, which currently propagates up and destroys the PHY
> device.
>=20
> Treat -EPROBE_DEFER as non-fatal, allowing the PHY to register
> successfully with psec=3DNULL. The PSE control can be resolved lazily
> when first needed.

I think you should move this patch last on the series because it changes the
probe behavior, and needs the other patches to work properly on the lazy re=
solve
case.

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

