Return-Path: <netdev+bounces-131510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B927F98EB71
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E980F1C219F9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F6E13A87E;
	Thu,  3 Oct 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IGWOB9jE"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A817126BE1;
	Thu,  3 Oct 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943588; cv=none; b=bHVqeYdez0QIZ4Fqss6trkTIPhiup5OvlYZ9hDT6QM27e2TIN4Hkl3cTkK7ZAX/w1Oj7cG8pD9oTnCaqu90J+++u1rqHrCk5RxW8Y1mlM1oV1KRnq6yybFVRS53Xy0WjQljyDS7jBSlOpupXFwxoVC0VAUK5sHlSCV/KevSH9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943588; c=relaxed/simple;
	bh=dfEW2k7YHLo2pSfF+AUP3ENDUvUcm2Ab+g9AvjeTz1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUfWwSjltPWYwLP3XZui43LThg5zOTS10dzZhwxV8YmxMYpSZPa48SlvM/EcBgZF5CPBcZoxFW9s3OG6yAnJEARzxvDIRTcxOoarHtdAggNFIM1DnrMpo18+7ZZmUoZNBULbaEvRtCTam8WVejc2XsL0Fnn5vvVPGMUBVl1LNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IGWOB9jE; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A726C1BF20C;
	Thu,  3 Oct 2024 08:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727943578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7Z8QNYMYP28ITJ13P0Meo68nL/GbGQPnGkie6cHxXg=;
	b=IGWOB9jEGEAs/2SGvINai9cU6jEUKZvViadyI2yY9agUZiew+VA6ejQZ3EeQJNL39sPDUH
	xQR6HT7ytG3e+/L8iI5RGs2MqLxMyfL2L+HgprQfZEPQiGbqoHreLy76G6JJ7AzE1g9ZHM
	8K/cUEp266feEXKloW156h+HshsoHSyy86D/ObOkZirJYcIp/oReadNtPh8ZhYwe7SeomH
	8NkHPCkesndK0k4kS4Cu+raXoGNcBg7RGYt29QThg/jzuAjJbFmgIYBOv5klRQ4MjsK0wg
	vXD7mMEe2KbSg91wFxrv1Hbx2XA2OL56TdOdYOjGBonMgggdmT1jg7xH5PpapA==
Date: Thu, 3 Oct 2024 10:19:35 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next 10/12] net: pse-pd: Register regulator even for
 undescribed PSE PIs
Message-ID: <20241003101935.3eb5f276@kmaincent-XPS-13-7390>
In-Reply-To: <b78344a8-d753-4708-ac61-9c59ffdd5967@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-10-787054f74ed5@bootlin.com>
	<b78344a8-d753-4708-ac61-9c59ffdd5967@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Hello Andrew,

Thanks for your review!

On Thu, 3 Oct 2024 01:46:22 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Oct 02, 2024 at 06:28:06PM +0200, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Ensure that regulators are registered for all PSE PIs, even those not
> > explicitly described in the device tree. This change lays the
> > groundwork for future support of regulator notifiers. Maintaining
> > consistent ordering between the PSE PIs regulator table and the
> > regulator notifier table will prevent added complexity in future
> > implementations. =20
>=20
> Does this change anything visible to the user?

No it doesn't.
=20
> Is it guaranteed that these unused regulators are disabled?  Not that
> they were before i guess. But now they exist, should we disable them?

Indeed we could disable PI not described in the devicetree.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

