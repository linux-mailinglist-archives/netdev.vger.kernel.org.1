Return-Path: <netdev+bounces-230690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFCBBED83C
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 21:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D023A159D
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 19:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F8F25F99F;
	Sat, 18 Oct 2025 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AutLg8/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266426F478
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814323; cv=none; b=HbWpYW83osTm4nh0Q3YCKgRMd6DgRh2mxl/r8168/w6/yu4MHTYLgnhNfJmo++C+iu1jorAG66ScHuyVta4cIhkAdWT72cIEs/wFsmpge9qLg+ZRaR5hgJfrDHXjbUYgw1rEapMFscwbLRmorU1Yj8otdxSW/Do46v7ljeN5tjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814323; c=relaxed/simple;
	bh=GlkRPCPhPzOU9mLCQrN+RQspS//dfiZHnMCrJx2XjUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fL8isprnySwSMg5UllIr4B9ly85eUwD4SW6cZw3qiKYi5+09r2MIoW/oC8LUblgWhurAJc+6sI4YmukivdRcspu/B1OXdf0GKqXrVjkFqDUF6VjcAHEcGgPBLLD85sPkcV8ciNgFRhK88gseYt2eVzPKU0bLTax7CDEwBkWhKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AutLg8/Y; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-651c8557bf4so609863eaf.1
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760814320; x=1761419120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npvxteVAfIEKzMeytJ2WmNF7D4AAPzWxw0qzjoJdKTI=;
        b=AutLg8/YD91s2Pa5W48hZ3OrDxy/xKimxKdqmnQ9L9+1JudCP6yV0yTaPsTHLj9Ng6
         ayu5A1t4VTvR2u4O4BNdk4UZQdTgAQm38dyU9qLzekSonv6ChcNGevrmv735Owp1ibgJ
         b3qopqYRQMmPrWfBrDz9c6VcFRTp7gg0RafKw5fx+C6GTJ98hkRuPXE6qL0Nj9ThxvBx
         M55Dr/GnPxZ6AJ/IGHa49FGKcK5TM3g7w7fRQG7jygaIWPB06Omtdh+ZoQfK6TqmfGpc
         X1KelEdVtXe0T6BYZEMayKWX7AYx/89PpMW5VWQhEv2I2GVGBehpXaE2rr4/KaeTKGjB
         ZbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760814320; x=1761419120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npvxteVAfIEKzMeytJ2WmNF7D4AAPzWxw0qzjoJdKTI=;
        b=dY3aVn8dLLIC/P8jOGdawWDlSJZ4XiAgHcl2vE9KbtFrHAk9vMsRFWo77Zez1aoLgw
         ffQjpNqw069zKHXEzcleX1HaYAcZr4Fc54WtZ0xNoP+6+Lj/ZAvaxYntX7XXF/IuuN6H
         XrxuWEBCp9FV/ygOQ3GcDwDNUgJYAmIoxMCJlcZ+9gpnviYF2WG6iS5OoIqwQr1f/aku
         bAfdVu1Vm/0dXN43Ya5DJLstpPEexBzHetlsNiCVU5Qh3RBIuB85EhWNrEdP4UJjjsvG
         5F1fl8TJlE2eJiwXyyDtshtdevxcPxhMCp0a8HzP+NHUZPEtdLyDJhyrFCVxthWRGow5
         n7lA==
X-Forwarded-Encrypted: i=1; AJvYcCW1zf8ZkeyICEaZh2oB1qXC/nJt2PkAeajd/B18zUfIJKhC7Qh3O2b8VUMFgYiYmkYVZuTIPPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybL8Jq+ptcatw6RUOERq0tw1Pj+eKDkcB+WYyUs0domq3IEgeQ
	i8rTql055Ad/tXR4l3ZCLxbXHdvCqUk811a7+4ydLVz8BFxYOo4fNI/+MoeMNlxo8rur+eICK40
	BSNRoZ0JF41fBsA/4twQWKYL4zXzCW6c=
X-Gm-Gg: ASbGncs/Qh/sSmHP9YNRkP9ZUtUPhHDVE2iDzoyyBSBtZUpQw7xdDBNT90eQFHsE9pL
	ZO7vWoVC4H36pMKALcsVy1u6Zc2RqVooEbFLcrsMLLeLUG2JHAzqYnpvueTLCxS6CXLShzBqsN0
	hAyjQVgqvZ3l2byrQS1I4//Uuz3uDVc4395gUJfu9ivPgr1iqOY/fmaLdd+kiA192snS9OcglOU
	ZKlN9wWCvnzP/P1M74fpKeaLWILu+z+WEwnWGZR7CjFx9SM2i8MYQjVtluwohCFg/6uR96A
X-Google-Smtp-Source: AGHT+IHn6bYHsxvnnBm5dSpuXWjNC+PBXDBTRxFzgYuC3xttEpimkJMntVWJZ0cZXwANZryVuMF0nNeTd369Q5XITzY=
X-Received: by 2002:a05:6871:6907:b0:349:de3c:bfc8 with SMTP id
 586e51a60fabf-3c98d0c7686mr2520732fac.31.1760814319754; Sat, 18 Oct 2025
 12:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org>
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 18 Oct 2025 14:05:08 -0500
X-Gm-Features: AS18NWBGMwSlAmXgBiXSGQWXCd5xrZTGccuKfzZwiw4wGpClNDZImruw46Wm-dA
Message-ID: <CABb+yY2u=XZFdoDrjjYFhARLoaxH4uTnT=GyFmsnV_U1aWn=UQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:20=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../arm/altera/socfpga-clk-manager.yaml       |  4 ++--
>  .../bindings/clock/nvidia,tegra124-car.yaml   |  8 ++++----
>  .../bindings/clock/nvidia,tegra20-car.yaml    |  6 +++---
>  .../devicetree/bindings/gpio/gpio-mxs.yaml    |  9 +++++----
>  .../bindings/gpio/snps,dw-apb-gpio.yaml       |  4 ++--
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 20 +++++++++----------
>  .../mailbox/qcom,apcs-kpss-global.yaml        | 16 +++++++--------
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      |  2 +-
>  .../bindings/media/fsl,imx6q-vdoa.yaml        |  2 +-
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++--
>  .../devicetree/bindings/mfd/ti,twl.yaml       |  4 ++--
>  .../bindings/net/ethernet-switch.yaml         |  2 +-
>  .../pci/plda,xpressrich3-axi-common.yaml      |  2 +-
>  .../bindings/phy/motorola,cpcap-usb-phy.yaml  |  4 ++--
>  .../pinctrl/microchip,sparx5-sgpio.yaml       | 12 +++++------
>  .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 10 +++++-----
>  .../bindings/pinctrl/qcom,pmic-mpp.yaml       |  6 +++---
>  .../bindings/pinctrl/renesas,pfc.yaml         |  4 ++--
>  .../bindings/pinctrl/renesas,rza1-ports.yaml  |  2 +-
>  .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  2 +-
>  .../pinctrl/renesas,rzv2m-pinctrl.yaml        |  2 +-
>  .../bindings/power/renesas,sysc-rmobile.yaml  |  4 ++--
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   |  8 ++++----
>  .../soc/tegra/nvidia,tegra20-pmc.yaml         | 12 +++++------
>  24 files changed, 75 insertions(+), 74 deletions(-)
>
For the mailbox changes
  Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

