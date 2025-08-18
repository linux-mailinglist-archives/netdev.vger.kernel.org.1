Return-Path: <netdev+bounces-214737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72B3B2B214
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 22:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4A14E653C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356CE216E23;
	Mon, 18 Aug 2025 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="x+S4B8p0"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9091F187346;
	Mon, 18 Aug 2025 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547687; cv=none; b=iRCUMXIBmHLgFkPWC4Ba1PMztSx7OuGsUTxkg8BIL36U3WEWZQ36zybiCNet6YORrPQA4bVkwQXw/OJkiJ6pwpvtaIxLnzR6nlEHJh9N2K69d+7mP5lBB90B9yk3yE2nzO+uQoz4XFqkKWnmZSKVg6Upi18FifiUdKbkJlBVUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547687; c=relaxed/simple;
	bh=6LhwwRpqhnFscA7YIs1rmS9HKYYXxQmhOatXl4FvTrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZPRkWJX7h/+xGytvsNpdWY877F5Rc6lD6qsMwiandcS8n0UZIFmWnkRRvcW6gdmeXa6WVTLxj5WL0dZIabIVx2vE9ycqh08v+/PBxJqcdVlRLC7+XRLfHvNySsXXLGihqq+aagAKMhLPe9fUhXYiMENOuoPKwYGhciR81Kpd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=x+S4B8p0; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c5P0K5XHfz9spd;
	Mon, 18 Aug 2025 22:08:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755547681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tc6P835DxKr69oSCM6M41RgZOB2wSNxZZcT4gcuaAas=;
	b=x+S4B8p0LG32NBGQ+FGXtCHXcljeFFH6tgPOXMCvIkcdvR0aBjE8TAm3UAsZ6kcMyNECCz
	9p2oaimFPxc+agYEVznV7t+x3HhcSf8Bne6KAud8aRiZLrBGqInZHHXXM/+L4wixkwHaAS
	8LTecY1terpjtmdF9De250uV3rC445Dw4PT8Fnpkk3+Xg094X4JIMU5g6ptTvF3UXL3QJ+
	USuiM6vFGp/1txMxwz4G8s3aExhRJA/OGskeSbzvVR8Pnj6iJ2qXtzSS2IV3CXZrhZ9JNP
	DINS76kq5B6cPgpefpY/iMwSyX1kS2TUaEbXKvtkyKKPdmHspj8de9yU31o9hQ==
Date: Mon, 18 Aug 2025 22:07:54 +0200
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
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v18 2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250818220754.585dac78@wsk>
In-Reply-To: <20250815182930.196973bb@kernel.org>
References: <20250813070755.1523898-1-lukasz.majewski@mailbox.org>
	<20250813070755.1523898-3-lukasz.majewski@mailbox.org>
	<20250815182930.196973bb@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-META: 35qi5izozcp45u58cd3qppdasc3mhqxe
X-MBO-RS-ID: d00d9afc35992f2ef92

Hi Jakub,

> On Wed, 13 Aug 2025 09:07:50 +0200 Lukasz Majewski wrote:
> > +	pkts =3D mtip_switch_rx(napi->dev, budget, &port);
> > +	if (pkts =3D=3D -ENOMEM) {
> > +		napi_complete(napi);
> > +		return 0; =20
>=20
> And what happens next? looks like you're not unmasking the interrupt
> in this case so we'll never get an IRQ until timeout kicks in?

Good point - I shall set the "default" set of interrupts before return
0;

>=20
> > +	}
> > +
> > +	if ((port =3D=3D 1 || port =3D=3D 2) && fep->ndev[port - 1])
> > +		mtip_switch_tx(fep->ndev[port - 1]);
> > +	else
> > +		mtip_switch_tx(napi->dev);
> > +
> > +	if (pkts < budget) {
> > +		napi_complete_done(napi, pkts); =20
>=20
> Please take napi_complete_done()'s return value into account

Ok.

>=20
> > +		/* Set default interrupt mask for L2 switch */
> > +		writel(MCF_ESW_IMR_RXF | MCF_ESW_IMR_TXF,
> > +		       fep->hwp + ESW_IMR);
> > +	} =20



--=20
Best regards,

=C5=81ukasz Majewski

