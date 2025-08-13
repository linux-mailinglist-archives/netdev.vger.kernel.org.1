Return-Path: <netdev+bounces-213389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15158B24D54
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0611753E9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112EF23183C;
	Wed, 13 Aug 2025 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDNMMUqI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B8F231839;
	Wed, 13 Aug 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098712; cv=none; b=AdAw9V7kLg26BAf50DAoDSN1VH4PoaWzpIwL84PBON1j81s0/TQl4Y34JvUK/5mtfwAdpUOXeRQVZH9Eo4VE8qLkN7mcl9ZVI+8KlGNyToxxLwy9K9Q8sTcGvtLZi3L9mi6SaX5cL7jTvuV9wB/g/mLPfqYskn0zgkSIZXN9pHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098712; c=relaxed/simple;
	bh=aSZYpogVJcVF1l/xXID+mUfdRe8mg1bAaCN9UZNml/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qISBmQLT/HIdTnW1AkZNOagVAHUWJ8w3R30LuZPqVlV4fDkxySaRRPcaDenx2KMOB9fnqFyGghzk2PSsKEJ1KGj6rf4uzL+M7mFzXQxv/A1dqmljl/0blQY0+l+j5gYOrltn5tdiYU7+fNTxfiaBw4A4y9PPVVBhhsBB2O2OmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDNMMUqI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b792b0b829so6753904f8f.3;
        Wed, 13 Aug 2025 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098708; x=1755703508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIKzP+v10goqJv8MZ6hUQxh9iZh9GLNgEJG//KT6geg=;
        b=WDNMMUqIj72UOuM/KvB5/7uOlhvQKYtUnSqlCukpkEhGKf9f+91kA9xoTXXupsEOLq
         iDP79d4Cj+O283jO0BGWW7IkCzEmQ4TsbNldWIlZopnHaPLBxoht0z83N4kLO23LT3BJ
         jfpMgbqeE/5PxvKrGip8a5/3E3l+fwLMBCG/H1vrRWELh8+taSivtHABKi1XRqHBHTxL
         wc8ZdU4Rw7P6f78aWRdIes5uP8T2ZdDV28ZYSvDSxd10vsTTqhPCOTxtO5qdmkSXVth8
         Sz8Ao6RgEqWN28azI3TqzYUSVSdp/FgTnmK8axzttq8r5+kfrIb5RUvo49V1yDv1AGNX
         4+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098708; x=1755703508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIKzP+v10goqJv8MZ6hUQxh9iZh9GLNgEJG//KT6geg=;
        b=Ajd4D6h0+xG7syHitV8rcNOQLLtEC7VUb8CRbu04In4pdZZsHd8lMKHoAWyZv+lhCa
         6iWMOPDJE6Hw0sHdpGq2gyiaJu+NQkMhGauJK/nU6Pz9J3KbtIg9HAHeRgp11GVt//9u
         4R+FGZJAmRLlkA/ZL2OKPGrFY+GcvUzeFHSGy5cT61cncaUDe7B3eDSKhkp4mn1FRXE/
         7QtnktQSD0oo5leumkNI8XYJ/k4flalEAqUEwoj3T0iVZGJhk2YpENeF1+K9+smc5hjO
         C9z/QQOI9x1eMbXGJ6LRGWyFNtdi6et+D5w1BQyc3DbtGjAviTjkdAzMcXzS47b1Qeug
         r4gg==
X-Forwarded-Encrypted: i=1; AJvYcCUqSTyvW1XvGQ2x4G8qXXbCO0pW6i2NUX6Uze0UHTuJNYcmTDdk/kGV+h6tzDjCDuFAyAUNBo+hvgtKCAif@vger.kernel.org, AJvYcCXzcr6tYoIenwtFZcbo+R1cY84YO0FgvWVAlpu4B3ZqJ9hnXGeaHIGshTW+qUSZMG9bJSuPTfpsrzhe@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUeBR7A15HZaB5gGMqtbE1MJiK9OkI4CnwtvewLfLBU6nAoTQ
	/lyTE64UABsNRIG/m2fuRN/b0YUis/yPZPBhgRKre6LOMKKj0ZjFGHkErnxHwA==
X-Gm-Gg: ASbGnctquke610gGNK9wLqJCBJTpZHGMfq2Io0U3uRLNKT8NfV4Ly0TodgmHb4NGcNw
	DwoZMCkwlm3UcBkfwPrLTblYfc4doDJgU7sfxN0EPbYcEBBAQ4LF2cKrUYxpRMHp5nCPFI2pSSk
	tvWLYP9hKbT6PXOUsLFWsWB2YW38aXkGpnHgbfmEXNbOFsp2EmQiBQYrP0w/kIkgjb2n9MpFz35
	/FRKvoQ09n3JWvSzeVCf8jAQuG1af0Sb9SuYnApnAoYSaB/BFzNVJtBmTtSgPKILjHr2f4vwQfU
	C8z8YF/QE9mMFh5mQyDRpEjULf9+9zU/9JIHBC2jSZKE0Hb15HnBSrY3ZLnZW/3lhaj+nyMNltS
	Lt/yrGt8xYxVc1irlENc2vxuikbrCnpqG09MB9lWkocXI+XAX3x3B9vp3oPEl+QFGRBEeMySIhg
	==
X-Google-Smtp-Source: AGHT+IFDK6njZdaYiIYPO/ZMO6ujPoE/G41Mb7N255M2MT+1frSU31mMtoR+dOSJ53Ri0BsuUYgPGg==
X-Received: by 2002:a05:6000:2c01:b0:3b8:d4ad:6af0 with SMTP id ffacd0b85a97d-3b917f14e1amr2572720f8f.40.1755098708425;
        Wed, 13 Aug 2025 08:25:08 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1abcd59bsm465535e9.3.2025.08.13.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:25:08 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Chen-Yu Tsai <wens@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Subject:
 Re: [PATCH net-next v2 04/10] soc: sunxi: sram: register regmap as syscon
Date: Wed, 13 Aug 2025 17:25:05 +0200
Message-ID: <5910992.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20250813145540.2577789-5-wens@kernel.org>
References:
 <20250813145540.2577789-1-wens@kernel.org>
 <20250813145540.2577789-5-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 13. avgust 2025 ob 16:55:34 Srednjeevropski poletni =C4=8Das je =
Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> If the system controller had a ethernet controller glue layer control
> register, a limited access regmap would be registered and tied to the
> system controller struct device for the ethernet driver to use.
>=20
> Until now, for the ethernet driver to acquire this regmap, it had to
> do a of_parse_phandle() + find device + dev_get_regmap() sequence.
> Since the syscon framework allows a provider to register a custom
> regmap for its device node, and the ethernet driver already uses
> syscon for one platform, this provides a much more easier way to
> pass the regmap.
>=20
> Use of_syscon_register_regmap() to register our regmap with the
> syscon framework so that consumers can retrieve it that way.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> ---
> Changes since v1:
> - Fix check on return value
> - Expand commit message
> ---
>  drivers/soc/sunxi/sunxi_sram.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sra=
m.c
> index 4f8d510b7e1e..1837e1b5dce8 100644
> --- a/drivers/soc/sunxi/sunxi_sram.c
> +++ b/drivers/soc/sunxi/sunxi_sram.c
> @@ -12,6 +12,7 @@
> =20
>  #include <linux/debugfs.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -377,6 +378,7 @@ static int __init sunxi_sram_probe(struct platform_de=
vice *pdev)
>  	const struct sunxi_sramc_variant *variant;
>  	struct device *dev =3D &pdev->dev;
>  	struct regmap *regmap;
> +	int ret;
> =20
>  	sram_dev =3D &pdev->dev;
> =20
> @@ -394,6 +396,10 @@ static int __init sunxi_sram_probe(struct platform_d=
evice *pdev)
>  		regmap =3D devm_regmap_init_mmio(dev, base, &sunxi_sram_regmap_config);
>  		if (IS_ERR(regmap))
>  			return PTR_ERR(regmap);
> +
> +		ret =3D of_syscon_register_regmap(dev->of_node, regmap);
> +		if (ret)
> +			return ret;
>  	}
> =20
>  	of_platform_populate(dev->of_node, NULL, NULL, dev);
>=20





