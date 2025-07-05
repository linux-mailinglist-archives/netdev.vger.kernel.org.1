Return-Path: <netdev+bounces-204300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39969AF9F76
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 11:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D0C1BC71D1
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AD9275853;
	Sat,  5 Jul 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=palvencia.se header.i=@palvencia.se header.b="bXkF61hd"
X-Original-To: netdev@vger.kernel.org
Received: from m101-out-mua-6.websupport.se (m101-out-mua-6.websupport.se [109.235.175.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DDC239E87;
	Sat,  5 Jul 2025 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751709488; cv=none; b=SY4FvOeAkSvDB8Hahq1LIX9MmFIF1sZ2ifT0uozmErDypPGTWd6hYpl7+Pja0OZp6FhphLSxqzfupbnRJsZU8KZCXhjj83Ka4ygjOVvtIAbWhHY/7AQx/XG6GJotMDwptm9f0uCOpPB7ia+6Xw8VY0rzNxtyAufuxkoLB3mHq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751709488; c=relaxed/simple;
	bh=WJ4HbOQu78BdDONBa51774fnFcMtDdfI8U3P82ZRyVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAhE2IjD2ShR4xOoFXdpwjKLZt3UvY+UqcXAZrxX59g9liAM5DqaO/Sz9jAcjkX306na3h88ET5SuhtfS9EoQJjcAcRRGtb4XGkcpyX0YUKCIuh69tNq+p+3DF3LicJ6IMBTFc0kDftBYnT+vV5Gu0b35rIaNBMhCjD2u4o63EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palvencia.se; spf=pass smtp.mailfrom=palvencia.se; dkim=pass (2048-bit key) header.d=palvencia.se header.i=@palvencia.se header.b=bXkF61hd; arc=none smtp.client-ip=109.235.175.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palvencia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=palvencia.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=palvencia.se;
	s=mail; t=1751708736;
	bh=uhXa9esT/5VXql/uG7nuK4DRUevXL199pPe0ERZ9KrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bXkF61hdjGYlYWI7fRAibPkbjV8n1SIWfk5H2xp0LjiOTtSSyNipITFlEldslm6XR
	 NL9lHwpvEoxFWIdhZMsO8dsRo4R9FjCvrnauBbnR2fUof4OA7Qf+md1EqsFnbDIlWP
	 lA3FCvK9wy8+qCNgs3Z6zWTCA2jEpaed+IdMyl5xMXlLNwgp02mtFYEuMAW73A4yX+
	 diuvVGI66XejLonv7oR06HTMMEVVgv03mDqGuBVDNeNEjDuWg1YHXkz+tscKC867ei
	 OVgWPnFf7abysW0LLxDFe1Xf+TjfzHFOu71XfAB4SBnHFHNdgPyzgi5x1v7/3dS+yq
	 HDTjRn5tptW3Q==
Received: from m101-u6-ing.websupport.se (unknown [10.30.6.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-6.websupport.se (Postfix) with ESMTPS id 4bZ5GS2fDHz1Ym9;
	Sat,  5 Jul 2025 11:45:36 +0200 (CEST)
X-Authenticated-Sender: per@palvencia.se
Authentication-Results: m101-u6-ing.websupport.se;
	auth=pass smtp.auth=per@palvencia.se smtp.mailfrom=per@palvencia.se
Received: from rpi (unknown [213.204.219.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: per@palvencia.se)
	by m101-u6-ing.websupport.se (Postfix) with ESMTPSA id 4bZ5GN71HQz17mm;
	Sat,  5 Jul 2025 11:45:32 +0200 (CEST)
Date: Sat, 5 Jul 2025 11:45:27 +0200
From: Per Larsson <per@palvencia.se>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jernej Skrabec <jernej@kernel.org>, Samuel Holland
 <samuel@sholland.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH RFT net-next 04/10] soc: sunxi: sram: register regmap as
 syscon
Message-ID: <20250705114527.73b15356@rpi>
In-Reply-To: <CAGb2v646HvqipGd_C=WJ4LGsumFfF5P9a7XQ7UGO6t1901DDiw@mail.gmail.com>
References: <20250701165756.258356-1-wens@kernel.org>
	<20250701165756.258356-5-wens@kernel.org>
	<CAGb2v646HvqipGd_C=WJ4LGsumFfF5P9a7XQ7UGO6t1901DDiw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Out-Spamd-Result: default: False [1.90 / 1000.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:35790, ipnet:213.204.219.0/24, country:SE];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_X_AS(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Out-Rspamd-Queue-Id: 4bZ5GN71HQz17mm
X-Rspamd-Action: no action
X-Out-Rspamd-Server: m101-rspamd-out-4
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 928
X-purgate-ID: 155908::1751708736-048FF069-EA712F3F/0/0

On Wed, 2 Jul 2025 13:01:04 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Wed, Jul 2, 2025 at 12:58=E2=80=AFAM Chen-Yu Tsai <wens@kernel.org> wr=
ote:
> >
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Until now, if the system controller had a ethernet controller glue
> > layer control register, a limited access regmap would be registered
> > and tied to the system controller struct device for the ethernet
> > driver to use.

"Until now"?=20
Does that description (i.e. something that used to happen, but not
after the patch) really match the change?

- snip -

> > +               ret =3D of_syscon_register_regmap(dev->of_node,
> > regmap);
> > +               if (IS_ERR(ret)) =20
>=20
> BroderTuck on IRC pointed out that this gives a compiler warning.
> Indeed it is incorrect. It should test `ret` directly.
>=20
> ChenYu
>=20

Regards
Per Larsson, known as BroderTuck on #linux-sunxi

