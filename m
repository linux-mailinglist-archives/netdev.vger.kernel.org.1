Return-Path: <netdev+bounces-214473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32711B29BEB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EAF189BB57
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4799C2FF67D;
	Mon, 18 Aug 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zvVmPLrR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02B21D9346;
	Mon, 18 Aug 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505341; cv=none; b=OfarMtMXXXuytF9J3QipS6FUDFeODNiPQuPwRy4qiHqdaFPJHl0AVaRDHAAZQNpJc44wKgxxk9+nBf3RcDv5vklxTRIXfj++gSWePhHxN4Zb7wQF+TcW3Ye4JhVy0HKQ/Mrx2Ng1JRoSKLebWTzlGSqZLc/mVvnNFaJTbZh/a4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505341; c=relaxed/simple;
	bh=tQz09CQnpg2v7hXSM+rrQMxQLWtYNk13pbjlIvre16E=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=V6KjxdRE9YS724+exKXPoM06s6WoujOK4Db9OlQK9lprDGLRDne5hDMYQjRNpQEZwOS9I/gcpMNIWhqWRyBdyTs/W0nzZ0gJNHGAAFd6Y9at+GR5D08FpOBk9A87E2vQivZYHx/Pfa2alU8SitpHacxAVZf74HS0IBX3G8pMy6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zvVmPLrR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D928D1A0D74;
	Mon, 18 Aug 2025 08:16:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A577E606A6;
	Mon, 18 Aug 2025 08:16:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id EE6F21C22DA38;
	Mon, 18 Aug 2025 10:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755504988; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+9Qk2NYCjGmfOUHqDVJHq6gqBPxiEeC5lSxafUieh6E=;
	b=zvVmPLrR3DlHxwdDO+5udyfppBCbTiVOErcQUikGwVc2r7fpVow4GrUqinlVopdb8ctYOd
	im04COl7V2zFSJTQWAqeqEnC6roiK+MGn7oTyI2xtVdbUIYU/nQidoytH2k7mH9120zAZf
	e2fEEEZYKBu+O+e0+dDhej56qlFxqvEJfjJQ7z1eedeWKi0A0lc0lSwvSLSQ6daXwC5Odd
	bvM8AjxsHhnjz+vDqp4qqx3uI34WTgVrlO9ewWH/WD3mQ58TsBk24HsO6uM0qRR86jIaL7
	r1JSwb9Yu1PEetB/HQV+TOK/66F+T5reJUGCGgDhpXGgSBIQAZyTdp7vN2oMhQ==
From: "Maxime Chevallier" <maxime.chevallier@bootlin.com>
In-Reply-To: <20250815063509.743796-6-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
References: <20250815063509.743796-1-o.rempel@pengutronix.de> <20250815063509.743796-6-o.rempel@pengutronix.de>
Date: Mon, 18 Aug 2025 10:15:56 +0200
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Jakub Kicinski" <kuba@kernel.org>, =?utf-8?q?David_S=2E_Miller?= <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Donald Hunter" <donald.hunter@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>, "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "Kory Maincent" <kory.maincent@bootlin.com>, "Nishanth Menon" <nm@ti.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org, "Michal Kubecek" <mkubecek@suse.cz>, "Roan van Dijk" <roan@protonic.nl>
To: "Oleksij Rempel" <o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1df-68a2e100-1-20bf1840@149731379>
Subject: =?utf-8?q?Re=3A?= [PATCH net-next v2 5/5] =?utf-8?q?net=3A?=
 =?utf-8?q?_phy=3A?==?utf-8?q?_dp83td510=3A?= add MSE interface support for 
 10BASE-T1L
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hi Oleksij,

On Friday, August 15, 2025 08:35 CEST, Oleksij Rempel <o.rempel@pengutr=
onix.de> wrote:

> Implement get=5Fmse=5Fconfig() and get=5Fmse=5Fsnapshot() for the DP8=
3TD510E
> to expose its Mean Square Error (MSE) register via the new PHY MSE
> UAPI.
>=20
> The DP83TD510E does not document any peak MSE values; it only exposes
> a single average MSE register used internally to derive SQI. This
> implementation therefore advertises only PHY=5FMSE=5FCAP=5FAVG, along=
 with
> LINK and channel-A selectors. Scaling is fixed to 0xFFFF, and the
> refresh interval/number of symbols are estimated from 10BASE-T1L
> symbol rate (7.5 MBd) and typical diagnostic intervals (~1 ms).
>=20
> For 10BASE-T1L deployments, SQI is a reliable indicator of link
> modulation quality once the link is established, but it does not
> indicate whether autonegotiation pulses will be correctly received
> in marginal conditions. MSE provides a direct measurement of slicer
> error rate that can be used to evaluate if autonegotiation is likely
> to succeed under a given cable length and condition. In practice,
> testing such scenarios often requires forcing a fixed-link setup to
> isolate MSE behaviour from the autonegotiation process.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

[...]

> +static int dp83td510=5Fget=5Fmse=5Fsnapshot(struct phy=5Fdevice *phy=
dev, u32 channel,
> +				      struct phy=5Fmse=5Fsnapshot *snapshot)
> +{
> +	int ret;
> +
> +	if (channel !=3D PHY=5FMSE=5FCHANNEL=5FLINK &&
> +	    channel !=3D PHY=5FMSE=5FCHANNEL=5FA)
> +		return -EOPNOTSUPP;

The doc in patch 1 says :

  > + * Link-wide mode:
  > + *  - Some PHYs only expose a link-wide aggregate MSE, or cannot m=
ap their
  > + *    measurement to a specific channel/pair (e.g. 100BASE-TX when=
 MDI/MDI-X
  > + *    resolution is unknown). In that case, callers must use the L=
INK selector.

The way I understand that is that PHYs will report either channel-speci=
fic values or
link-wide values. Is that correct or are both valid ? In BaseT1 this is=
 the same thing,
but maybe for consistency, we should report either channel values or li=
nk-wide values ?

Maxime


