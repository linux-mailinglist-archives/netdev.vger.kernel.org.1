Return-Path: <netdev+bounces-182157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6825A880D5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E2C3A8577
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E7127EC9F;
	Mon, 14 Apr 2025 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xu+QuR5X"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513601DFF8
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635118; cv=none; b=XDdqPCw+pnC4fGycv86bWr7+XTRl9+DGAcmBx+3/t+Fqj9v2fmhc2G+buKtYhSKjhBSwEclot+olxnxCq6DEClXOlEOxVCgGZ+qDYP4kj66RxMwifH/de3voGtSUbWtKypIvgHghi9e/A2OflWZSm6sEqPcvIGdnab/mSvz8tPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635118; c=relaxed/simple;
	bh=Dm4r/1Aos1f2QXkQrIuINjOfWpJHRSfr6mOxeGlXMzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wv5mvxzCsj6lYQ5w5cUuYaOCkzPEXRbRdNZCheWIOYZaepBYvulHngyd7U9u8krOvYI2OasxRjHKv203sqjY5Fy0jfp1FUtgyUuA0QSuV7oEIMx/Vor6bGS9JmRiW4VUP9CYCrdP8um7U9XXmBRcnuk8AHpikWaGyOgMzdMCqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xu+QuR5X; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04C6A43903;
	Mon, 14 Apr 2025 12:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744635113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H+fFw1bQt0EWCU6JEZCGzK+/5m1hU/7TzALUO2Ewrg=;
	b=Xu+QuR5XXkRFZBbaJiEMmFKGlEcW+0P5UNcDJRNb7qRkx9zbj4jBZovezka9rRdJM2Nh51
	/q5ScPsjrV14lOYsDPiOsuvZUKh7yDw9oiY20MbxHJpT4DWc48L/Xq1EvqqU0BD1ZXJsU+
	q2DeGcb0AHkFYGAVOYHK/EjXE6sObU0keKn6ZYZyY/kwWiGRWImIuzdO0y3nwiaHHRcyUb
	ibYFZGINAyGYHHFpRFN60AIqnEqmj/0ANuLYXY9NxQSn5TZysguojVhk3Oo8JSAfkWQpyJ
	emZh1JIabZTJ5lNEckq8GBH7xO52eOS+NhWOo4lAXAJo9Z9Nok+UEyXzsdSLbg==
Date: Mon, 14 Apr 2025 14:51:50 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 1/5] net: mvpp2: add support for hardware
 timestamps
Message-ID: <20250414145150.63b29770@kmaincent-XPS-13-7390>
In-Reply-To: <E1u3LtP-000COv-Ut@rmk-PC.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
	<E1u3LtP-000COv-Ut@rmk-PC.armlinux.org.uk>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheprhhmkhdokhgvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtp
 hhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhgtihhnrdhsrdifohhjthgrshesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 11 Apr 2025 22:26:31 +0100
Russell King <rmk+kernel@armlinux.org.uk> wrote:

> Add support for hardware timestamps in (e.g.) the PHY by calling
> skb_tx_timestamp() as close as reasonably possible to the point that
> the hardware is instructed to send the queued packets.
>=20
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c index
> 416a926a8281..e3f8aa139d1e 100644 ---
> a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c +++
> b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c @@ -4439,6 +4439,8 @@
> static netdev_tx_t mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
> txq_pcpu->count +=3D frags; aggr_txq->count +=3D frags;
> =20
> +		skb_tx_timestamp(skb);
> +
>  		/* Enable transmit */
>  		wmb();
>  		mvpp2_aggr_txq_pend_desc_add(port, frags);

Small question for my curiosity here. Shouldn't we move the skb_tx_timestam=
p()
call after the memory barrier for a better precision or is it negligible?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

