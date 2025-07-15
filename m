Return-Path: <netdev+bounces-207240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E8AB06555
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA64C16F7F7
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7BB286413;
	Tue, 15 Jul 2025 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ/tFzTR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365328507B;
	Tue, 15 Jul 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601429; cv=none; b=PX+zKvscgzip+zWpHJhjh0UlAMMC/czbxkc0K3lrmlQoSjpwCUCkHNO94GHDcZgkyEBTr9MR37oYYebBY2w5S6N6ujiB3cgwNb3atx5ARD3+BmQj/NpczcNMVFVy6SnrH3fvLZsUUmi2ManeLwR5qQllcH9Tl0xoDFLwThFA8dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601429; c=relaxed/simple;
	bh=54VsIhKZIv/mNC4NrTI9DMJ7xO/jEt3cjbBcWJjARgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boDqHqZsC8uwcLuUviwiLBae8dng3kcS19ZOAfcy+BR6Ey6cCtvXOo5nfByJdWnbdWJ2kgbyXVxr2HTS/uQROijQDAZoc92yLS/P7y1cmDD42Lj0xlgxwCe+853Z11lgQmZHk4FexQEf2wUhsbMqnAEmhWDCnjFyQ9ynP3qp0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ/tFzTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99843C4CEE3;
	Tue, 15 Jul 2025 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752601428;
	bh=54VsIhKZIv/mNC4NrTI9DMJ7xO/jEt3cjbBcWJjARgg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cJ/tFzTRQvVmZe4bXDNiYPtuqt/7L/tJESoX0k/L6gt+FYeldUsQj+/4OgvhhudJ2
	 a3Gz8r8S//vHl2Rawg9VD8KL8fop2h6lLT4IkLRJaTWynA3bf14gmE46MSUNREkv/Z
	 kySwX/bMmaD2nntB3vVVp7T7NXIFxYzX8QDI7+UkV3zHSCMx4vsffdRWwhH10dwQkQ
	 RC2u5GYUUG593bC6qBFvUpVlKnjLoxKVDZkjau1bWsDeFDybD96JFHHFCD/G9MJibh
	 HxSkK7BltDpfwwtZOmXvhpxm/Ay6oywwTMZw+61Pe3Yxr4rV9y+kQlMcwr2JYiD32R
	 XOPAPeaXMLe3w==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso8037863a12.0;
        Tue, 15 Jul 2025 10:43:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFJ2aBN+IdXQfaoM9Rr1F6xJuqlgIN83XVrX0Ch2o5JD2YBb5YoAGJ5jPbsiNdm9/N9TkxyB3TubkOCgTu@vger.kernel.org, AJvYcCWWx8zKCA5zRhzsMAO+fKU9uIj9zbWSumGXgbn102GrINWvgfVTJP13vN9jW+M1Q5g565tao0ed@vger.kernel.org, AJvYcCXb3SJPEn56JzJUJgEcHDyXfmKzaE8n13/7ehaFOWXAgP69YS4UZhPJpUFmO5OLkLF2K7M7hoVFVpTf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4wfaXT7lT6agYaZESqNkDGgZ2RW5lZgM9jBSMK/Wmaum8I2dH
	8uNMqJhysgLPLvOQC+mkoRBROBe4fWWJtiDHjSPGE1F57DAPkVPmE6cC/5Fn5CLBsVHJJBheRfL
	NRidCMmQ654vxITMSjvgXHrN8XFs0zA==
X-Google-Smtp-Source: AGHT+IFSfJ329hc32n6pv+14gS0mt5gTgoFqsqGbemfhsisnZDnXEaldUJ2gRxLUkvPg+1tT8vixRzdxTK8k0xV9biU=
X-Received: by 2002:a17:906:730f:b0:ad8:9466:3348 with SMTP id
 a640c23a62f3a-ae9c9b0ce31mr42139766b.36.1752601427144; Tue, 15 Jul 2025
 10:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703021600.125550-1-inochiama@gmail.com> <20250703021600.125550-3-inochiama@gmail.com>
In-Reply-To: <20250703021600.125550-3-inochiama@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Jul 2025 12:43:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLKLKHj+vQJmZnaXRj3TmqR3ELjpBc27HRbTOOP9FD0hg@mail.gmail.com>
X-Gm-Features: Ac12FXz_neDQRbYET5mV11I82g2lSNlhGKsWNEzC8k-2DtgP7jZ-KwLmxIiQkME
Message-ID: <CAL_JsqLKLKHj+vQJmZnaXRj3TmqR3ELjpBc27HRbTOOP9FD0hg@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Chen Wang <unicorn_wang@outlook.com>, Richard Cochran <richardcochran@gmail.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Yixun Lan <dlan@gentoo.org>, 
	Ze Huang <huangze@whut.edu.cn>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 9:16=E2=80=AFPM Inochi Amaoto <inochiama@gmail.com> =
wrote:
>
> Add DT device node of mdio multiplexer device for cv18xx SoC.

This adds a dtbs_check warning:

mdio@3009800 (mdio-mux-mmioreg): mdio@80:reg:0:0: 128 is greater than
the maximum of 31

>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv180x.dtsi | 29 ++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts=
/sophgo/cv180x.dtsi
> index 7eecc67f896e..3a82cc40ea1a 100644
> --- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> @@ -31,6 +31,33 @@ rst: reset-controller@3003000 {
>                         #reset-cells =3D <1>;
>                 };
>
> +               mdio: mdio@3009800 {

The nodename is wrong here because this is not an MDIO bus. It is a
mux. So "mdio-mux@..." for the node name.

> +                       compatible =3D "mdio-mux-mmioreg", "mdio-mux";
> +                       reg =3D <0x3009800 0x4>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       mdio-parent-bus =3D <&gmac0_mdio>;
> +                       mux-mask =3D <0x80>;
> +                       status =3D "disabled";
> +
> +                       internal_mdio: mdio@0 {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                               reg =3D <0>;
> +
> +                               internal_ephy: phy@0 {
> +                                       compatible =3D "ethernet-phy-ieee=
802.3-c22";
> +                                       reg =3D <1>;
> +                               };
> +                       };
> +
> +                       external_mdio: mdio@80 {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +                               reg =3D <0x80>;
> +                       };
> +               };
> +
>                 gpio0: gpio@3020000 {
>                         compatible =3D "snps,dw-apb-gpio";
>                         reg =3D <0x3020000 0x1000>;
> @@ -196,6 +223,8 @@ gmac0: ethernet@4070000 {
>                         clock-names =3D "stmmaceth", "ptp_ref";
>                         interrupts =3D <SOC_PERIPHERAL_IRQ(15) IRQ_TYPE_L=
EVEL_HIGH>;
>                         interrupt-names =3D "macirq";
> +                       phy-handle =3D <&internal_ephy>;
> +                       phy-mode =3D "internal";
>                         resets =3D <&rst RST_ETH0>;
>                         reset-names =3D "stmmaceth";
>                         rx-fifo-depth =3D <8192>;
> --
> 2.50.0
>

