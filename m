Return-Path: <netdev+bounces-299921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jHkhHEh9MWrDkgUAu9opvQ
	(envelope-from <netdev+bounces-299921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:43:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 238D5692641
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:43:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=p1XWtPhP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299921-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299921-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB3583049465
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E846AF3C;
	Tue, 16 Jun 2026 16:42:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E546AF1B;
	Tue, 16 Jun 2026 16:42:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628153; cv=none; b=d/KE3UIOLtsNzXpKaUj7ApmSUKFM9xztr0Kx+Av1DTERNhSG9LnkBFaSLl8BDvMu8SCWZULOupHcP0bJCEn45VJbKcmvAYpf74/ny2FCrcD2ASiFx491tqCBiLHj/xHugqTvrf9lDaqFVtieJLd0Mvr0XeURfozRLyAZMOZlLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628153; c=relaxed/simple;
	bh=Cozgf+ex87Q5DHGCt4pmEkr1bhDJf05+lcXo9eT2FG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVxIlveW9E4q+QECsFtYJMR/wKYekPUDd3wQwbvxIqLuMjJPqmzD9pJuJ0j3qNue7I0cShrojeZksJx/NgOu1dSSJm1fhkRK9I9086zHypM3FsVzEA5ARC46a+pFNvSctPwOoKGGoWG8VcDtZiIPnBH8T0Cg6bYh/bz2eZYj37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p1XWtPhP; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1D2CC4E42F1D;
	Tue, 16 Jun 2026 16:42:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E33D1601A9;
	Tue, 16 Jun 2026 16:42:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85CFA106C9C3D;
	Tue, 16 Jun 2026 18:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781628147; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Cozgf+ex87Q5DHGCt4pmEkr1bhDJf05+lcXo9eT2FG4=;
	b=p1XWtPhPnGJ6itvOBVOkSswmUzNIKpO0fUiFxtTmNHW+oSpU3OcIL74XfoDT53MiOhptHv
	W95v0AWRnDuWKgwPHrCM2pbbMO3vVIfPd6VuE+SbuJpot/5M45nAAColutpYMdXbyJqa08
	bdqy2prgezcbFrOoNjhfu1Gb1eM2Dk+xolOJbhmoIWh5Shn+wW164t+qQj+FtfK/Q6lVcz
	I9+QCdoMHmKP94O0DhCD3sw6eiuNzN4/D8OX8IbRgKarHo1YsOGJmVEWV3p6JwDM7meF/z
	3m1D3lrwp3grxYBEIk6spVbZiAzjyxOKcBMuOuC35WYMfY8YgjbhDahaIKh5yw==
Date: Tue, 16 Jun 2026 18:42:20 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Corey Leavitt <corey@leavitt.info>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller
 lookup from MDIO probe
Message-ID: <20260616184220.72d1b814@kmaincent-XPS-13-7390>
In-Reply-To: <20260615180812.829678-1-github@szelinsky.de>
References: <177795581584.12433.14568712745388778289@leavitt.info>
	<20260615180812.829678-1-github@szelinsky.de>
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
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299921-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:github@szelinsky.de,m:corey@leavitt.info,m:kuba@kernel.org,m:linux@armlinux.org.uk,m:o.rempel@pengutronix.de,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[leavitt.info,kernel.org,armlinux.org.uk,pengutronix.de,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:url,bootlin.com:from_mime,kmaincent-XPS-13-7390:mid,szelinsky.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 238D5692641

Hello Carlo,

On Mon, 15 Jun 2026 20:08:12 +0200
Carlo Szelinsky <github@szelinsky.de> wrote:

> Hi Corey,
>=20
> just checking in on this one. Did you get a chance to continue with the
> series, or is there anything I can help with to move it forward? I'm
> happy to test a v2, and I can still run the SFP path on the
> S600WP-5GT-2SX-SE once it's back on my desk.
>=20
> Kory, Jakub, Russell :-) it would be great to hear your view on the
> approach so Corey can plan the next version. The series fixed the probe
> loop in my testing and I'd really like to see it land.

I haven't heard from Corey since this patch series, but I am in favor of th=
is
notifier design.
Corey, do you have time to continue this work? If not, would it be okay for
Carlo to continue it for you?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

