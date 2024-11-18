Return-Path: <netdev+bounces-146022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D88539D1BA3
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 00:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8152BB229FB
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 23:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B831E7647;
	Mon, 18 Nov 2024 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="eQ9tesHA"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27233199252;
	Mon, 18 Nov 2024 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731971148; cv=none; b=TAQx+/hN/WGkZ9qZ5WooKjGs0ErsZFvfc2wXh24C7RFHr1EwMTIOJU+g0IMo5FOFn+f3jWOK+Io69fZ421hDQKiel5raryhzS+EEnFItynGv0EFV6c9teLY8ze9CWlLMZ51Vjpx2d0LEPxUYsO+MFwxQFTJ5ujnuKY3CZy4OWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731971148; c=relaxed/simple;
	bh=+OxDHwQ+LwgR6Jb7OIDjCgKY879pFmYdyYNHXVCDwog=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=En3Dez0Iz/OojeTOJBLJBhhy8hJww9upuxerU/s2WzWU59L/5UvSumpZ5/bEYzWR0q045MsrvZqO0glvCnO2eVQlVJcXiSow31Vu05w3sn/i5Xn6kNz+GC0afg+aYzih1DbBmdmuaEzu2XhxUfo3WiFPzn2LqLyLY4wqfWhf9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=eQ9tesHA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731971143;
	bh=+OxDHwQ+LwgR6Jb7OIDjCgKY879pFmYdyYNHXVCDwog=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=eQ9tesHA9Iuny+nyiRBUQMhg56mp5yBbcOvuBP4P9VvuulUB1B9pwUMqTLaOflq0p
	 NWDJi2a7YW8/K7l8nTmi3QzuEmCyzVAwcVp49VZIR81EtCuMPkLpCRzcl753hR29K3
	 pkKEs3a/l2+6kwP9QvQlURg8KqmhuTK1LLZr91FOh4QABe2/a+EO1weSdgRCby8tfk
	 fOIX7v+tKMQ+5Nq+oTf6pZkUJJDlsp/MuGX6FPDmA5JsuS1COoy+NHGiQ+Crb/r28d
	 JtxDWS5h2ntqSglCcnDvK4y4/VHvLEyOOvqX5VqN0cxjOq7hg00ktmJL2gH/j8RhvB
	 T9rwNRyKA6KzQ==
Received: from [192.168.68.112] (ppp118-210-181-13.adl-adc-lon-bras34.tpg.internode.on.net [118.210.181.13])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 76E9668D9B;
	Tue, 19 Nov 2024 07:05:40 +0800 (AWST)
Message-ID: <0d53f5fbb6b3f1eb01e601255f7e5ee3d1c45f93.camel@codeconstruct.com.au>
Subject: Re: [net-next 3/3] net: mdio: aspeed: Add dummy read for fire
 control
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jacky Chou <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au,  hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 19 Nov 2024 09:35:39 +1030
In-Reply-To: <20241118104735.3741749-4-jacky_chou@aspeedtech.com>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
	 <20241118104735.3741749-4-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jacky,

On Mon, 2024-11-18 at 18:47 +0800, Jacky Chou wrote:
> Add a dummy read to ensure triggering mdio controller before starting
> polling the status of mdio controller.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> =C2=A0drivers/net/mdio/mdio-aspeed.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-
> aspeed.c
> index 4d5a115baf85..feae30bc3e78 100644
> --- a/drivers/net/mdio/mdio-aspeed.c
> +++ b/drivers/net/mdio/mdio-aspeed.c
> @@ -62,6 +62,8 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8
> st, u8 op, u8 phyad, u8 regad,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iowrite32(ctrl, ctx->base=
 + ASPEED_MDIO_CTRL);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Add dummy read to ensure tr=
iggering mdio controller */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(void)ioread32(ctx->base + ASP=
EED_MDIO_CTRL);

Why do this when the same register is immediately read by
readl_poll_timeout() below?

If there is a reason, I'd like some more explanation in the comment
you've added, discussing the details of the problem it's solving when
taking into account the readl_poll_timeout() call.

> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return readl_poll_timeout=
(ctx->base + ASPEED_MDIO_CTRL, ctrl,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!(ctrl & ASPEED_MDIO_CTRL_FIRE=
),

Cheers,

Andrew

