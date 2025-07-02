Return-Path: <netdev+bounces-203166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EED7AF0A14
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3500F3A1F28
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39A1A4F0A;
	Wed,  2 Jul 2025 05:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96082FB2;
	Wed,  2 Jul 2025 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751432484; cv=none; b=HG8D9F8rViK8h2NdX5/jn4F9bS7U+ZIVrnoza5Reb4lF+Vt2ykv9Ma7zMIX7qUrPeADeKTExc7SpIEANNbBK3iLs+qBbL4Xsjbpez7KlsUFAKexpnpfdWDcpKyxqmUfL2vONoZCd15PHQvmieXTpGL8KuHH7iZUOyHx6MFXLbPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751432484; c=relaxed/simple;
	bh=aM2O311AG0MI5x8qPgoLBcOvvK+KMw4egyrI2NlTIh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cB4ZD7XoE4P5hIzp1fu9he0z2WA1GjYabUs3j2RR5fHFb1jioCkYF6TZUmU2EjuS1k/Z47iaIQ0mtVQz7VKVLf5tV3QFdznozrEWjXYeOUzQ2JK4FAMIlrtpziDsKkOQcD//gRoem2FVWhkif4svbaC79HOInknmqSSIhgB2mXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-555024588a8so4186059e87.0;
        Tue, 01 Jul 2025 22:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751432479; x=1752037279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0rt2nH/TWlCePhqIMfxbMwVAseEB+3Yn8nvDGBHf0Y=;
        b=lCCQbWbJiQt1NsmLzRWqp7kobxDfeXW766hwaaFAHgHwbOfjRY8dSA9necnUkkO5gm
         KxNUrdmShXF3KFOaBaTn1BPMnMV4PKcRlm/r+L+brpFi+uNIZdLSxcgWiFHHyzdUnKx5
         iZ5uLFCP5/WXRIbrkjuuSYfw1zpU14/DJUlN+QOzpF+1DbzTltV/XsRd2h1H5J2gL452
         IFlmtZ6q/XWfBe2v69UvbG4wacAcm+xp+PD8LzECuWq5IXrrUh+e1GR0911C8uZjwf7e
         6jFxX+b+FjKMhEPg4+OO41p2wrecOpa3Nth7Ps/zQ2/TIYSHRG3D8thwdhwyjGFqQTYX
         HnEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtpOIm/sIvMEStX6GABc+E7wbxGSABEjIX2J9YSicPVW73CCdylILWX+J3Ip3UCtsyn39WFYWveAD6lvKb@vger.kernel.org, AJvYcCWHcvdeSEeNiCsP6sjCNC5UfJGhe7Z0Ua9WhFRIhzrbj06rUZ3jFD3hlPR5XPnMvWoXp7xmXPsN0qmv@vger.kernel.org
X-Gm-Message-State: AOJu0YzVGsFJLfSanOhYLT9pgqUeXxtCLPyDxH3WEMBMTuT1j1Y8SLSX
	JnuIAps4iSTQfV9omZbisgdJeoIohmuN3hw5WOrcVNSXwEUKMybwvcCiOl6YbkaO
X-Gm-Gg: ASbGncso/lvvbgOW2st4Shr2Tv06LpD9csVeSaUzUEsXzr10oSF/DsE0z0WijCQYcKe
	2nI1+x7RRB93a/JHPUu57Gw/ipWmrYHaxKDqdF3dNwAcvtIY7GliOqljkiIwMr44kVmVRbJD8Ir
	UeKKwd6+z8Hp8EYHPBE+eoco6FA6lgfGoNypLmN4YqN3NShvdj+e3kbR4Dn+7ECK+6MjAaa1GO3
	+mMwdQfpDMljP7K2Zlzamvx/TQLfsN575dHshyV2EWpb+A2Z2ZDfDzIw30nDwXfE9MGqFOMzqIt
	8kvFakcu5l+c9Zsc6yw5DIlQWQaE9xzK47z+GzQpv7haXgRqbWJ6D+J/RRLdIUglmVT+8q5zWab
	VSnMINBh08vk/HyMG/48=
X-Google-Smtp-Source: AGHT+IFG9dXhqHdaZHV6aRjDiPPbxhVNAwyQpeQVP0kYHFcxWO4/K/yqM63WaXOZhLNe2KUBF9u9kQ==
X-Received: by 2002:a05:6512:3ca4:b0:553:2645:4e90 with SMTP id 2adb3069b0e04-55628389775mr434988e87.52.1751432478833;
        Tue, 01 Jul 2025 22:01:18 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ddc50sm1993541e87.231.2025.07.01.22.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 22:01:17 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32cd0dfbd66so31294641fa.3;
        Tue, 01 Jul 2025 22:01:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfl159z/5RVQTsckcOvGW6WXb875jnd53t/621vGuq9cI2JinO3HbfaT6OE292k90lQ+m+qlZK7yVvy++H@vger.kernel.org, AJvYcCXXym3H69YibdS2FX0IiOWWLKTPNMFsZBe+e/o66NnPW/eAMCvStSUdOSmZVc7J1GcW8SChTEgL0ZWD@vger.kernel.org
X-Received: by 2002:a05:651c:e1b:b0:32a:6c63:92a with SMTP id
 38308e7fff4ca-32e0004b940mr3217911fa.22.1751432477399; Tue, 01 Jul 2025
 22:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701165756.258356-1-wens@kernel.org> <20250701165756.258356-5-wens@kernel.org>
In-Reply-To: <20250701165756.258356-5-wens@kernel.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 2 Jul 2025 13:01:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v646HvqipGd_C=WJ4LGsumFfF5P9a7XQ7UGO6t1901DDiw@mail.gmail.com>
X-Gm-Features: Ac12FXxOhT5Y9cipxD-0Dp_WlsoVmLL1HMEja_1PgcoQyh6p3ZogoQeQ7CimJkk
Message-ID: <CAGb2v646HvqipGd_C=WJ4LGsumFfF5P9a7XQ7UGO6t1901DDiw@mail.gmail.com>
Subject: Re: [PATCH RFT net-next 04/10] soc: sunxi: sram: register regmap as syscon
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:58=E2=80=AFAM Chen-Yu Tsai <wens@kernel.org> wrot=
e:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> Until now, if the system controller had a ethernet controller glue layer
> control register, a limited access regmap would be registered and tied
> to the system controller struct device for the ethernet driver to use.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/soc/sunxi/sunxi_sram.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sra=
m.c
> index 4f8d510b7e1e..63c23bdffa78 100644
> --- a/drivers/soc/sunxi/sunxi_sram.c
> +++ b/drivers/soc/sunxi/sunxi_sram.c
> @@ -12,6 +12,7 @@
>
>  #include <linux/debugfs.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -377,6 +378,7 @@ static int __init sunxi_sram_probe(struct platform_de=
vice *pdev)
>         const struct sunxi_sramc_variant *variant;
>         struct device *dev =3D &pdev->dev;
>         struct regmap *regmap;
> +       int ret;
>
>         sram_dev =3D &pdev->dev;
>
> @@ -394,6 +396,10 @@ static int __init sunxi_sram_probe(struct platform_d=
evice *pdev)
>                 regmap =3D devm_regmap_init_mmio(dev, base, &sunxi_sram_r=
egmap_config);
>                 if (IS_ERR(regmap))
>                         return PTR_ERR(regmap);
> +
> +               ret =3D of_syscon_register_regmap(dev->of_node, regmap);
> +               if (IS_ERR(ret))

BroderTuck on IRC pointed out that this gives a compiler warning.
Indeed it is incorrect. It should test `ret` directly.

ChenYu

> +                       return ret;
>         }
>
>         of_platform_populate(dev->of_node, NULL, NULL, dev);
> --
> 2.39.5
>
>

