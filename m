Return-Path: <netdev+bounces-221744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F06B51BE7
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0569B16395B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9492A266B6F;
	Wed, 10 Sep 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y2YemHcJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC817736;
	Wed, 10 Sep 2025 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518722; cv=none; b=VfE3+WLR1UQE32AebPwTRDK6N4s1GfT4u+MVfFV6TVaBDynq3FVB8pByU2P72H5bdyLp5liCHIva+DFqfhmmGJeOlkTk7kbgusk5p4+M5lfdM3yq6C3ENTY2xUcF7xsIC/ZAXJzG1eBcPtbj57pJvQvG9wDWIupYjDfWmZ1jHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518722; c=relaxed/simple;
	bh=QwkBarok8UBOI2Lim709fhspkN42JvpVi+4SbyFUZZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vAp4vS5AheX2aofL+JYSzo6INft2nTskM99gdIk2EyyKQmsD7TxPSQ184BM9e1n5XM8M4h+TxP/MKU/YLlZsYpws36wY4Ybo1aOJk7VwyIpJyt71lKzOAifUQjl06M7RWCy4oCDa7T+1TU/0lE0Eip6M0hIFn9AVPsaLNcu/tI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y2YemHcJ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 109FBC6B3AC;
	Wed, 10 Sep 2025 15:38:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D14C5606D4;
	Wed, 10 Sep 2025 15:38:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E110102F28E4;
	Wed, 10 Sep 2025 17:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757518717; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xlHXywoJ2uD7SrY7tudc4A6W/KEFHaVaOyXcV7vcPxs=;
	b=Y2YemHcJu9VLTkBBToWyc6y9ceSnb7jMFlZN3n1W9U24mHdIOHjfu/Bai67AkbTw87xDJk
	qHiJmlEqqBGlhYt17gtbzqWWC5r/1+vFtX6kvTRf7JzQup+U5wP5+kRJ0wrl8xOsnVCDUC
	bsLcrLapzZ3gVRsrcBdScQxx7V+YzKsg/nhRrISlWlJ2+ndw70Bu68N7eVva06mGRAIjgQ
	unGx+TEKk2ofXIzOmKW0ddVre1CQmud82r5ZNLLUgnVTjtBQVVwQ47iCydA325ae4u83Tk
	x63NcAlNl5lZNQ0faDFpnt1qQa8uH4uTtRhSgX1kNbvDz4Rk9TArOBvYJSpK4Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,  UNGLinuxDriver@microchip.com,
  Andrew Lunn <andrew@lunn.ch>,  Vladimir Oltean <olteanv@gmail.com>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Marek Vasut
 <marex@denx.de>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,  Pascal
 Eberhard <pascal.eberhard@se.com>,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: configure strap pins
 during reset
In-Reply-To: <20250910-ksz-strap-pins-v1-2-6308bb2e139e@bootlin.com> (Bastien
	Curutchet's message of "Wed, 10 Sep 2025 16:55:25 +0200")
References: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>
	<20250910-ksz-strap-pins-v1-2-6308bb2e139e@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 10 Sep 2025 17:38:13 +0200
Message-ID: <87y0qmb9ne.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello bastien,

> +static int ksz_configure_strap(struct ksz_device *dev)
> +{
> +	struct pinctrl_state *state =3D NULL;
> +	struct pinctrl *pinctrl;
> +	int ret;
> +
> +	if (of_device_is_compatible(dev->dev->of_node, "microchip,ksz8463")) {
> +		struct gpio_desc *rxd0;
> +		struct gpio_desc *rxd1;
> +
> +		rxd0 =3D devm_gpiod_get_index_optional(dev->dev, "strap", 0, GPIOD_OUT=
_LOW);
> +		if (IS_ERR(rxd0))
> +			return PTR_ERR(rxd0);
> +
> +		rxd1 =3D devm_gpiod_get_index_optional(dev->dev, "strap", 1, GPIOD_OUT=
_HIGH);
> +		if (IS_ERR(rxd1))
> +			return PTR_ERR(rxd1);
> +
> +		/* If at least one strap definition is missing we don't do anything */
> +		if (!rxd0 || !rxd1)
> +			return 0;
> +
> +		pinctrl =3D devm_pinctrl_get(dev->dev);
> +		if (IS_ERR(pinctrl))
> +			return PTR_ERR(pinctrl);
> +
> +		state =3D pinctrl_lookup_state(pinctrl, "reset");
> +		if (IS_ERR(state))
> +			return PTR_ERR(state);
> +
> +		ret =3D pinctrl_select_state(pinctrl, state);
> +		if (ret)
> +			return ret;

In order to simplify the pinctrl handling I would propose to replace
these three function calls by:

      devm_pinctrl_get_select(dev->dev, "reset")

I do not think in this case we actually require the internal
devm_pinctrl_put() calls from the above helper, but they probably do not
hurt either.

Thanks,
Miqu=C3=A8l

