Return-Path: <netdev+bounces-220682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AE3B47C79
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 18:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6181899211
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F02820CE;
	Sun,  7 Sep 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AXWC0GTI"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8D212FAA;
	Sun,  7 Sep 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263746; cv=none; b=RG/ZTe49OhJyph5Z6iV3nUAwPyVchDzGhKes9ad0tFWHVxP2iBFC8ZMIqF8ekzZjr5XLrW5+3zxkMRGm+FBUZqpIYptqWk0WJwW+LEgqi3mZ6DXWEWSj64/Z8MTzHX8IHi5MCTd0RShdsnvpZLKDWIbo/mT5Ffy16Eko4N9RtR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263746; c=relaxed/simple;
	bh=wtJE/9V1ID9ihIEtFnTcHVxdij16qnp4YPJZcXEGmsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmQ7DH7ZzjxlOc/Xp7GZvYBqgRkm5iOIFuykABuxqoZ3+5p8FOnOjd5xXx5m2N8zmw6p/6XistBrzJctDcDITn1GBBoLaowJ53IA3E1BPtDmzjGFT1YIJdygwoXsHSYARDTjBNnn+1Qn8qaA1IIaSsUB9dnE9cW7s+VpRkN7X7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AXWC0GTI; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cKbdS3xSvz9v2f;
	Sun,  7 Sep 2025 18:49:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757263740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/AOkrt/MSyoLioZagXRkbG/LjuV+caGTuc51pKFPCE=;
	b=AXWC0GTIHrcKwR34c/D7uMv62ZAkeM5QSPsKsITkLmhF7Mfe4CEq6b0xAL1LWhtqh7HY4c
	gVDGdKSc2bXpA/VsMocV4HnYzlR6w0ZQCk3xboqC2yRU+dlo828P3H35UNdW2bWMz2Fu08
	lNoeuM+Amon6h9FfvIZLf4mwl80RzWGEui9xzxaKCTAQaw8cRfsZbKFxud7GgYEGk1RY3v
	ZM9Er/sumnT2IHnjMljR6hdvQbixf67YxRnFipQdvMnC0wbUulTdXgSF4yq7w44QHqEWHm
	IiTMoYMFpj3Zp8UtzAivsP6mYhgseqUuAreoIFD10zxTQs9UEK6rdRgFxyDPEg==
Date: Sun, 7 Sep 2025 18:48:53 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v19 5/7] net: mtip: Add mtip_switch_{rx|tx} functions
 to the L2 switch driver
Message-ID: <20250907184853.76a5ff5e@wsk>
In-Reply-To: <20250827082517.01a3bdfa@kernel.org>
References: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
	<20250824220736.1760482-6-lukasz.majewski@mailbox.org>
	<20250827082517.01a3bdfa@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: 8e9e25c0ec1635d0afa
X-MBO-RS-META: ssgamybgoy3knbawbojmr3bd5bptxf3q

Hi Jakub,

> On Mon, 25 Aug 2025 00:07:34 +0200 Lukasz Majewski wrote:
> >  static void mtip_switch_tx(struct net_device *dev)
> >  {
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	unsigned short status;
> > +	struct sk_buff *skb;
> > +	struct cbd_t *bdp; =20
>=20
> > +		} else {
> > +			dev->stats.tx_packets++;
> > +		}
> > +
> > +		if (status & BD_ENET_TX_READY)
> > +			dev_err(&fep->pdev->dev,
> > +				"Enet xmit interrupt and
> > TX_READY.\n"); =20
>=20
> per-pkt print, needs rl

+1

>=20
> > +		/* Free the sk buffer associated with this last
> > transmit */
> > +		dev_consume_skb_irq(skb); =20
>=20
> why _irq()? this now runs from NAPI, so it's in BH. Just stick=20
> to dev_comsume_skb_any(), it's the safest choice..

Ok, I will change it.

--=20
Best regards,

=C5=81ukasz Majewski

