Return-Path: <netdev+bounces-141882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D055E9BC989
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8714D1F22724
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439841D096F;
	Tue,  5 Nov 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cwJawqnX"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D41CEEB4;
	Tue,  5 Nov 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800118; cv=none; b=VeoQeUKbrBeF1J8tItpwnKZjKB4x/+FwBvx22QHwQdbzrC0kHx3EXwWnMfGtHW0Kg2uxL7RJ3TefVn45RHLkIMdiROQEDNDBJraiGX8ZkkN2sqPJUo8GDZgPm0QuBSF1vG8ANYqlLaC0nmhGcePsH1aRzzXeOk9PuHnVYn+Fanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800118; c=relaxed/simple;
	bh=/2QwgAXiPUODt4iE59pzhQ9GeyVS881QJbOf6HO4EEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ho2UdaOENC8OmE8DP2rEnpMV4se82IdSaR1UaRwXg9VGrxYnqoSgQXfN/tPhXHPfvkFYDbqsQMkm5LitDuuLVR3Jid4CHjC3cMjU+RyYOX4DQ2le7L7hIJPdafRUUqnPQEk8NrBajcm0kEISg896qAbhnm5bdCWkqH/8W9Y+q+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cwJawqnX; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8CB1FF804;
	Tue,  5 Nov 2024 09:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730800107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPMHfYx6OZKwpmgoXf5RalkYoqx0nz8w42w1wG828y4=;
	b=cwJawqnXxr1f7ZN/2ZvfHNMJEDZ9q51ODGu4Xxrpjx3L8oppyPKkYDJ6ipF9ri7LxUnxW+
	V4eHzflWTxKVgAVjYWLljJoJQ/990J7ROAt4rdNeLd/IMDv7hrzo/tMRdHDbviNfwkf0Ld
	AsrIwCrlOOW5oyWfgYbcUcYcuyqbgh8eH2Q/aEqGIUVxXnTxORBnWs9Ce8L1w8XPU80QIT
	D1dAQ7xln7m/QYMUwogJdOjGWN4kKsEKHTWOZC4rPILt4CWyC0V0c1rg18OGilPIjRuV/d
	9msH4aSdSxU8MHNRBPHuEa1m/5pY1z5BgCdxYNrelOEo1sZ1pDYV99QjZZgPHA==
Date: Tue, 5 Nov 2024 10:48:24 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 08/18] net: pse-pd: Add support for
 reporting events
Message-ID: <20241105104824.2bc51cf7@kmaincent-XPS-13-7390>
In-Reply-To: <ede82d07-6adc-486a-b715-e6e783655333@lunn.ch>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
	<20241030-feature_poe_port_prio-v2-8-9559622ee47a@bootlin.com>
	<ede82d07-6adc-486a-b715-e6e783655333@lunn.ch>
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

On Thu, 31 Oct 2024 22:54:00 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static struct phy_device *
> > +pse_control_find_phy_by_id(struct pse_controller_dev *pcdev, int id)
> > +{
> > +	struct pse_control *psec;
> > +
> > +	mutex_lock(&pse_list_mutex);
> > +	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
> > +		if (psec->id =3D=3D id)
> > +			return psec->attached_phydev; =20
>=20
> The mutex is still locked. I'm surprised your testing did not
> deadlock, and that none of the automated tools have reported this.

Ouch indeed! As explained in the cover letter, this v2 has not been fully
tested.
But I have built it with smatch and sparse. Weirdly they didn't find it.=20
Thanks for seeing it.


> ---
> pw-bot: cr

Does RFC patch series pass through the netdev CI build test?=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

