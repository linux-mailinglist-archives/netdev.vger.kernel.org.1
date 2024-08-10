Return-Path: <netdev+bounces-117434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B5894DED9
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 23:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 070C5B218DF
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 21:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D6B13E023;
	Sat, 10 Aug 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ROIEjw4z"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B2142905
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723326455; cv=none; b=A3HVxSqZPiXlZjp6fjBGHfxIO9ymvIHg5P1htZ3Vvi4xwN2uMr4ILauCk7VKIjmc1h/K89vDSCqVn/mAVVniWL8F38I7+AXne47mcZR5+4CBB6OUcel+tu86XmU7U8LP+/r1Onz6ZtXi8YYMcYqwAYjRGawTcIXqDVsHAfBOcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723326455; c=relaxed/simple;
	bh=w1OICdfDQr0fMlHeCwmbvJUGwMLzj7XrTAnnD4ITlec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuahbBa9I8ERzXkF9i00oRmT5yICoTIQAiCG5tjDFFvIlJSdsmr9ukij8k2lKG4Z5PfZBlPhAp7WGqSJr8X7m4mrI+89KCBdvYcYDFb1lXgqmUaEQ5WUy+gfSHX1ongPZ/O6Lm/04Lp6r8rVxaIAn1IdcM57gW36P41hCHyVBs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ROIEjw4z; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id B8965C1040
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 21:46:06 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2FA6C40002;
	Sat, 10 Aug 2024 21:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723326359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1OICdfDQr0fMlHeCwmbvJUGwMLzj7XrTAnnD4ITlec=;
	b=ROIEjw4ztNljFs/p1AX7I1LOfwcyRQf+6iK0GlnpPqlNr21KMwuNLTXmW2PLAviMLKhnzP
	iH2set4fOCN1N11GV8p7BN/a2tJDTfztjo8yE+LRjXTW+uuGEwP9ooFUrZtTDCwXFSu5RE
	ZFUvwLiP4QU5AqFOF+SXBM6DibzUlA69h0NhAf+Dy1DM5hVPZjLzuFBUsmDtD602GcyyWl
	kjFug+VRVHVWrUmQ2XfBV0DLdQ40Ug4ThT3eX3uFEV6oriQuwH2uXBdJcXa5DwY1mAWKgt
	jUSh/Iz3k3sRn9CAWBtV1FWMJlGn3F9AbAMxALW9yfHmTVjC48vrPh+LYsbHrA==
Date: Sat, 10 Aug 2024 23:45:56 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "kuba@kernel.org"
 <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "thomas.petazzoni@bootlin.com"
 <thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: pse-pd: tps23881: Fix the device ID
 check
Message-ID: <20240810234556.4e3e9442@kmaincent-XPS-13-7390>
In-Reply-To: <20240731154152.4020668-1-kyle.swenson@est.tech>
References: <20240731154152.4020668-1-kyle.swenson@est.tech>
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

On Wed, 31 Jul 2024 15:42:14 +0000
Kyle Swenson <kyle.swenson@est.tech> wrote:

> The DEVID register contains two pieces of information: the device ID in
> the upper nibble, and the silicon revision number in the lower nibble.
> The driver should work fine with any silicon revision, so let's mask
> that out in the device ID check.
>=20
> Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
> Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>

Hello Kyle,

In net subsystem when you send a fix you should use net prefix instead
of net-next. Jakub, does Kyle have to send a new patch or can you deal with
it?

Thanks for your fix!

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

