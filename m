Return-Path: <netdev+bounces-131301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B11298E096
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C407C1C22CBB
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A41F1D0E1C;
	Wed,  2 Oct 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CqMQLteA"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2965747F;
	Wed,  2 Oct 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886202; cv=none; b=EAPYKnvOQNbLcWUVnKJ9Y4wgulTA9kwA/tEOjAopcd+MUbNoavuoDuFhszlBSeDgBE87nJJlqrSPdTpf3TxNePO7N/EccjmnooKFqOuMfWeqe+LHwceZq6oKiq04IeaapZmdVH9nqZDpLXnE4L1h+ohCwcklL3A97HnMuNUyuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886202; c=relaxed/simple;
	bh=drOzvvjccuXSABPkU1Ww1CiI1cBfTf2nRCm8Vom35do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0iEIYo4MEJariWNm7m+n68RcZsu4+VvIbaR9wZhJyfc95J0YPIiDvR5YbJdVW/1cC1rfyf+HhxSKsAU5RNWPWC8os/2IZbe0lo3J/KWgNLlK37EDAbccs75iXZtdzT0KCiyXI/jOhaj1knluAQs/GdXAryXVVcl+IXRZ+DiESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CqMQLteA; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D11501BF203;
	Wed,  2 Oct 2024 16:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727886198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drOzvvjccuXSABPkU1Ww1CiI1cBfTf2nRCm8Vom35do=;
	b=CqMQLteANyQUe4I9+QQFVPJ1BYNLpOOahmVjWeZODqWm49AYJTJxSgrBXcpFuQ5e+Iipxo
	wGIKfKQGx6/iaBeR3IZZgjUjtmnp7ghFE66+hxMCoRTMkv7muJ2qiPK7Qm3WzPnaIG4W0o
	60GS3Gw1WsQoWDzVhFY/HIovNVycIcs/Xn0hFgD2S95b3n4NCYKEsQhaeU3x/HDy/ECEpT
	xEYrrPboGnWp0iDJWghyXXqshuZDgnftlzTB4lL+8vVCkCGhKDh4AOFWEv2DlHPgeRB3Ee
	RpItcZQCGqSTmHYD5Foxapv9em8yzABQh/GPiH3PGsdG31b64SNRzUJNctDZQw==
Date: Wed, 2 Oct 2024 18:23:16 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH 00/12] Add support for PSE port priority
Message-ID: <20241002182316.22ad7e39@kmaincent-XPS-13-7390>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
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

On Wed, 02 Oct 2024 18:14:11 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> This series brings support for port priority in the PSE subsystem.
> PSE controllers can set priorities to decide which ports should be
> turned off in case of special events like over-current.
>=20
> This series also adds support for the devm_pse_irq_helper() helper,
> similarly to devm_regulator_irq_helper(), to report events and errors.
> Wrappers are used to avoid regulator naming in PSE drivers to prevent
> confusion.

pw-bot: cr

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

