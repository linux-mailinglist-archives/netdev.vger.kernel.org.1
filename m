Return-Path: <netdev+bounces-107384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D391ABD9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD52B2223E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A6199249;
	Thu, 27 Jun 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEkq0hQn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79319923D;
	Thu, 27 Jun 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503490; cv=none; b=ANSpptXWJ609+z5vJZGrszBKpvu+YkTV++Gsawij4D+aK6ekDjdYzoTcBrZrzzkUAQJXSXutfuzikeUgWpqfIO7w393fnZhvpb6u3Sz45LmmTfTa+CycJpoqDBXgMJ9cRUij657QlJyv3QBQsc5ZDSB3vbU46hsNiw+zDlJG5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503490; c=relaxed/simple;
	bh=8sNmBRbLYtnOF9l6k5kdWe+U29xtoepmvDGnR4Vle4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmweVlA2cK02WNGYZ5Mzu3qBekqYTfHg1NZ1iU096ltFkAZaHynOLWIit6ROsIpG8ElU/Ttul5gU8r4MXufAfLHaxUoVNU2X9jQ4/fuSQwu8WZAgzGuyy7qS+y44VwZYblrd/F7buiFi4CIes81/MPLD2hQt8fwBSZN4QRqaHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEkq0hQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56EAC2BBFC;
	Thu, 27 Jun 2024 15:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719503490;
	bh=8sNmBRbLYtnOF9l6k5kdWe+U29xtoepmvDGnR4Vle4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEkq0hQnBZ+KNYUesU7oE5e3CjPxEjIcd+kDInMzgBmoqMrWOBCZjMFuNDFksaLgA
	 B349Jiu41uqUzX+CtcDiWGgV7bIMsSwNyNw9IkCB1qoOCBS8t6b/XW1rrKG4R1rOUE
	 4qC7axIyxiMNpaPpA+/n/qgHBa5XDsuGvigOnz73uxhU+lnx6wlHvnZdb+xfT0YMI4
	 q5ONx4IfGxclT/naaa2lJETxyQD8xhU0w1KzDRdBDoUEryhCEn2oQFRRHeowiWcULD
	 EvCQQrEphJ4gXeMz8S0mumv4QPuCm8PqJRdbZs4WK0eAqQryrvv9HkA5zZBup742WK
	 Zxhe4UF9mJ4og==
Date: Thu, 27 Jun 2024 16:51:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/10] dt-bindings: net: Add Synopsys DW xPCS
 bindings
Message-ID: <20240627-hurry-gills-19a2496797f3@spud>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627004142.8106-7-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KQdBdOR3fsoaQVmH"
Content-Disposition: inline
In-Reply-To: <20240627004142.8106-7-fancer.lancer@gmail.com>


--KQdBdOR3fsoaQVmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 27, 2024 at 03:41:26AM +0300, Serge Semin wrote:
> +  clocks:
> +    description:
> +      Both MCI and APB3 interfaces are supposed to be equipped with a clock
> +      source connected via the clk_csr_i line.
> +
> +      PCS/PMA layer can be clocked by an internal reference clock source
> +      (phyN_core_refclk) or by an externally connected (phyN_pad_refclk) clock
> +      generator. Both clocks can be supplied at a time.
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    oneOf:
> +      - minItems: 1
> +        items:
> +          - enum: [core, pad]
> +          - const: pad
> +      - minItems: 1
> +        items:
> +          - const: pclk
> +          - enum: [core, pad]
> +          - const: pad

While reading this, I'm kinda struggling to map "clk_csr_i" to a clock
name. Is that pclk? And why pclk if it is connected to "clk_csr_i"?
If two interfaces are meant to be "equipped" with that clock, how come
it is optional? I'm probably missing something...

Otherwise this binding looks fine to me.

Wee bit confused,
Conor.

--KQdBdOR3fsoaQVmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn2KegAKCRB4tDGHoIJi
0kCTAQDqWeZ7LyH0ZTe86qqVq1cd1SncHuw8+sZsegmlMUWaWgD/QLzoKs61xpZg
Gdvue5pIwWCgd5AWlNaYMf/fQIBK7ws=
=bQ4k
-----END PGP SIGNATURE-----

--KQdBdOR3fsoaQVmH--

