Return-Path: <netdev+bounces-138732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7F19AEAB4
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E364281BFD
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F41EF955;
	Thu, 24 Oct 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lrcws5e8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9DB1C728E
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784231; cv=none; b=GXyHTMOyC7ZKl+NjjV0Zg0tXTcsuvps0ntvfZoDjIcAekAXSG+/WMx0YOaYRNcA9TEf1aK+vEEH5rxHNMlIiga2hw48xaxrhlc/I3A5rD1LPtvPQkPuhjDgty+miTqz5P3Ec/5EZJq+MJWHOsRBD4jB6rbWwADzbtfgI3qOw+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784231; c=relaxed/simple;
	bh=mQE/fX0FNTMKWxSOoDkVlsX7HJQzVfZjTO5dwYTSjGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKwp20+Z6ZL4QOrKX6tJddqs7shSdAme/lBXG+zyt1cg5Et5qniXWDAMAyOpyzoThnZghurMWiRZV/BvczXKRvqofFxjv+lrfvbFG2jtvoTV9bo9U1HU0wSrpAwHROWMMSvTrwFh072eYjdP2J4Hm62rLI5DB4wUi+GE4bp98Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lrcws5e8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43169902057so10824295e9.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729784227; x=1730389027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCnstNue4jg85kEIiyesGcA8Rnj9rjVX17h62wnrdHU=;
        b=lrcws5e8PDRZjwo8VqBRscEhFXssdV+BfGs5GQeRtPAsnpKfzlP8K9PSDuA3dUaq0s
         V84KKW+j59HEl0agybr1GBjRhktAHbou2plNQ5zhJtTPlHwn5ugYFUWihnkmcCe8+D4Q
         K5KzRNYEeRBv1uN7W9mcwaElk3ix2oUETBPQK8e8uHAlfQ1NuRvQdnprIYtF9GywqQ1o
         xO6NLkFTpeKC/xtkFW2XXCJQuluIm4XDPc+2IDvPmyti+5DRAuUd6SsXT1rDMhpwiMQC
         PlL1rSyNcixgWZois2nhzPv7UboJ1T69U7oGb5ToV0wW9qtMQxBv56hB0luYqo0Kyt24
         m99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784227; x=1730389027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCnstNue4jg85kEIiyesGcA8Rnj9rjVX17h62wnrdHU=;
        b=eKy5pwSI2rcJdgiS2uEFT7gzCeMeX+7/kgXv01YXxs0xBNf7VKoocMfj+OmGLAuIhl
         BcJMV2AyHCZPWYJVqO69QUSWgwYrl6+V34TiY2nyjcKIBwuaftcALLLN7nauHCTqDHYI
         KmX1qGo4/1oYqYWq1rmV/LiWNK+D8/ic9VvQZMZyqJQFhmn2ieYnOKU6j0OxcNo8dV1M
         eLSvdUHcoZewYc7B0iWjXN6gfNEOjoMHbdVszhbnznl3wGl7VlzfrDKzgYgBBnU0N3UA
         0nzp5J7syYL4LnRoHbwhx9vW8OadaxgmTS3aHXM/dDvrEVRBkPfOStcTUSEAoPmgjqgl
         SNQA==
X-Forwarded-Encrypted: i=1; AJvYcCWyYsgNeYgUPg2J5FJ5ji9XoXZoK5RY8X7mpJzjWMZUYLrIgniZojKhh3FOMk5oamx7ryAThxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MmHlaT9+2wr1hTq3mJ4T7fWsnotEplmWtN9w1XvKfOW0aG0S
	bt7vobHeLxWTUUL5M4Qwkq5dOQDEHjl5Zz1YOfM+Bnct3jIFc88AnQZUvhrfiM4=
X-Google-Smtp-Source: AGHT+IFgeY+AzYZbHlaVERgkGi+hHj+CdTnAXQEQObCERD5nPgI8ASENpM18NFTIk7TmUwfS+F2JOA==
X-Received: by 2002:a5d:60cd:0:b0:37d:45ab:422b with SMTP id ffacd0b85a97d-37efcf32d1dmr4378492f8f.31.1729784227087;
        Thu, 24 Oct 2024 08:37:07 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bd6esm11615236f8f.104.2024.10.24.08.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:37:06 -0700 (PDT)
Date: Thu, 24 Oct 2024 17:37:03 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Message-ID: <7lcmhspo5xq3numdbrfc44uqppbzigwq56vmqne5ldvg2uac6z@ivu4fmwbzajm>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aoyw5qfx5gwdpipb"
Content-Disposition: inline
In-Reply-To: <20241021103617.653386-5-inochiama@gmail.com>


--aoyw5qfx5gwdpipb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
MIME-Version: 1.0

Hello,

On Mon, Oct 21, 2024 at 06:36:17PM +0800, Inochi Amaoto wrote:
> +static struct platform_driver sophgo_dwmac_driver = {
> +	.probe  = sophgo_dwmac_probe,
> +	.remove_new = stmmac_pltfr_remove,
> +	.driver = {
> +		.name = "sophgo-dwmac",
> +		.pm = &stmmac_pltfr_pm_ops,
> +		.of_match_table = sophgo_dwmac_match,
> +	},
> +};

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers. Please just drop "_new".

Best regards
Uwe

--aoyw5qfx5gwdpipb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcaaYgACgkQj4D7WH0S
/k4cDgf+KFa71VVkDyJF4Hl2zPHZr8uawn9uZBqgpPkeGPL2gMIgZeFsbW+Ta6tM
l9QqKp1U1+CNvJx+TsnkHz0XIwAAu4+jjjLogyLd9qAvydydl7UNfs2qqtiVklt3
QKX4PUt2WLIsjSSnXZ/xvPpcHmofvemuYZcQDgiEBlHaBn+GZjD9woBQgX79OZ3W
ly+IQUOVBFIqnkBG7MrskeBodS69Snv9OGEkKCxn4me2uqdlscBZVrjIQ2H4u1Q5
K+jcXjkffyRka8EVF/QuOu90nBixXNZGAa5d/H+Gt1siRRXt6Sgw/k7KSUZ8Kb7f
UZNlLZkw0L1To+cxy3Y5F23dBVqbMA==
=+aJM
-----END PGP SIGNATURE-----

--aoyw5qfx5gwdpipb--

