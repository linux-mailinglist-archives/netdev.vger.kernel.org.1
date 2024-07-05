Return-Path: <netdev+bounces-109458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E9D9288B9
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB17B1C229D6
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8961474CB;
	Fri,  5 Jul 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HzzdQuNT"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950214885E;
	Fri,  5 Jul 2024 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182787; cv=none; b=SJ+Wt5XtIb0RZcyJiAOwyvzenO8rHIL+B4m1f/omFylNeNu7AHkWjTshSrblw+bh21xGNjWSsNK+l3dExML2FX/6WS2BMrCWzj0u6E92uDAv0V1ewpa7N1ivqzaycGGBRYLIjvCJCejEKKwtfleOtHLxE1EVVHeXL8UGlL3LyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182787; c=relaxed/simple;
	bh=Wpyeg/N137qNzeN20jZ0M2uWKize72AXtnys20jkLWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5rsTVBXpfhgsHMDUkhKLqKtuffchFpH2wxl7r5tRU5osxyfJYbjuT6z4mG3iKkzqtEStC6e+I6dyQjKOxQT8rujrXOSGPLhdeN2SufHo2qZjF584uN4b9AzBMO1w7mADwm2jbvZiUqv5f5uHF0Lp/kaM66CtL43qDwh2w13/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HzzdQuNT; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7E4F6000D;
	Fri,  5 Jul 2024 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720182783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpyeg/N137qNzeN20jZ0M2uWKize72AXtnys20jkLWA=;
	b=HzzdQuNTYJFoNN46nWenjyJWaRzLXt+s7NspYVvJ+CndxWWrYlDExqI2fAzT+Bo8cs4C5q
	VrPZ3izQT7V5eLWzKURhcXRXixmntnERmtqX06EBjHEzkaZ3TPZEhZoKys7IEgaa9LbSE7
	0oFg0OsiBfEbmtT767i2zUm6s0rZmUGGdNZRcjHmhWIqDe0Jv0PSjTppnk8hjfwyXGiJua
	p5K1JI+d520jclU3tsytlzDuXhA0epSx3PescqE4fjDzoq6G9cp2s4X0rjKBOb2GnFV5pc
	Ijm19eYa8IxNT1oQKRs/X7NE6niNNUoCuxatBAFuC6hGVvXpCbftNwcfQIR2nA==
Date: Fri, 5 Jul 2024 14:33:01 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH ethtool-next] ethtool: Add missing clause 33 PSE manual
 description
Message-ID: <20240705143301.7514ce0e@kmaincent-XPS-13-7390>
In-Reply-To: <20240520-fix_missing_doc-v1-1-965c7debfc0e@bootlin.com>
References: <20240520-fix_missing_doc-v1-1-965c7debfc0e@bootlin.com>
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

On Mon, 20 May 2024 11:47:33 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> Add missing descriptions for clause 33 options and return values for
> the show-pse and set-pse commands.

Hello,
It seems this patch has not seen any reviews or activity.
Could someone take a look at it?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

