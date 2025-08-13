Return-Path: <netdev+bounces-213390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F1DB24D60
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E06A3A9537
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB52367B1;
	Wed, 13 Aug 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvGJYVng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0EF235341;
	Wed, 13 Aug 2025 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098782; cv=none; b=NDGn5JUXkMjNOQObxr+4U/ghBCFOVIoUPTztMxU4hZUZ8GxMxLKdPyRgj5F5Xp5NOdESRz7ta/q68Hjp0eHfezx/GxvsgFYxsAMdpGBn+UeX3gC6OiQki8BzwDMzBt+aki5OiY9E/g5ZVzfP1un4qzZ/wUkMZ3+55yxCJgJh1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098782; c=relaxed/simple;
	bh=T9ew6vV7It536VuL2qh0FYOmync27BJ+NqE+bgI6NO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxeJDHNU9yO85QB5yrw9AHUVqQehKCsG6Eoiynr1mS6or0wlI83KpvmwZDcRVekB/E2r9/UVRHwRm1dbuQh2yS6OnkG7O7I7n2+orVSCvl5+8CigYl0ZEB+Cl5uIRzDxacVJ98fYeVycFOTzYYqeAdGO3svWbY0RGeFgGADtJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvGJYVng; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a12b3f4b3so15303765e9.3;
        Wed, 13 Aug 2025 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098778; x=1755703578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHmzj/owjBnWQXccQqjtqoeZzUsvFVlqZRdyc+4n9B0=;
        b=OvGJYVnghhi28Z/vyIwXXaJ73/C4tzPL3ty8ZRy8I5HKQGSj4wys9rDngh+dL5bmb+
         g76nsoHo+QLfxxWTfJcYOTCJ9rJ//ykmd1fqY76iFaf4dQwumDdXoaao3fIld6vaWx5Q
         W1o+3lH2+n0mo0TWVFK3ImOml9WWaoAsHn2lHFWcQwk89sGbnXCHvo3bmvcj5PkUhsHC
         3aeTXTxnyTPkCbIXaxHQEJ93vQGEF/0uIqCvhK/8ajawy+9WxU1I+H7Mf9rLPAIroBhB
         hRQ7ZSP80TxDUPp3BGDL8/aFZ44FaoulcdmzYa9tBu3mI7Ma9JrEFf/T5eKVFQ9psRga
         EZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098778; x=1755703578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHmzj/owjBnWQXccQqjtqoeZzUsvFVlqZRdyc+4n9B0=;
        b=KWB3pQ3/DEgSyZ+VqaMI6JWhOju4EVqab4Wo4FXM4x2bOQ7Q7fl/8rTjcevAcZZjXQ
         zlJtyNR3Ly6pUuN6jdPfva4I3k+3cyuXdR8YYPDlpuyX4Oej/1NGKhiID2rPCAszcxhL
         8ElZBZ3lv1M3Jxv8zqID/9MDnbGCBaL9zX2Enmzy6PTrF++cZxDUWtrqx9yTnsXs11o9
         Ti/prwd89SNOvJFccf9fpTtQdiMfUZD2ZzK+c14x8vXPODH4WsjZK05+8sruCHGV48ms
         1kJBP43TbvEc17sBQlEd75zSyGFmR1P1qlO4woHxL5vESL0fCkuqSbloa3xiOvDi8Uzl
         OH2A==
X-Forwarded-Encrypted: i=1; AJvYcCWsXAJwWP2omI2ZTg9QguGh5YJv2CIklclVRNmkIm9zMkLBxqVoyrTZmrgq72qVL5xBoyzqoGD08R/+@vger.kernel.org, AJvYcCXwMmSXgEmPz8DA0W6GtnM2k1T7TY0CKT4sD88c1sZUcr6NIqUCVyGM7ZoNAxRyCF9Wv7XHi+DNMK4J9TYP@vger.kernel.org
X-Gm-Message-State: AOJu0YxP39d1jCVIL/hsKWM0rIsiNcvefMuB+nrMIvhCCAeQAen3iMfd
	brFtvSELpXfFATjSaohSDZpuxZ4HgPfUA310WEPQAHBafjdDMz9x1TPR
X-Gm-Gg: ASbGncu3KYuU+b+FVlN3yxyMexRi3CcoR6AdV+mDBxeLRyiPnvcJyt3NevvIxVBgiIH
	stSZVb/PhKw5U1JsxzWHiZOkasZ3+q57f1oYmQjm0xqghNg6nIbNXoSmSGuzqHE9kI2pp+n1Opl
	4LMRfcOL+AMJsdMK+SAcLgSvdm/RwMvGasVtvf0WwsrdrRK/A2tZfLDhRpx5jU0setQ+noEl0mh
	Ru8JSphEeXKMykio5sAIQpSzfektcy1FCcxTsx2tzSpQqbUdYszIYzqofFNTYfAP3m7HCTzyBjD
	Uzoi18k8tfTB4WcJ0TiFWd/Mat1Pb+PUyFLBIhq+h9Qx4oQz0gxpL1+zqodcc2WoSK2vsvHIO+X
	BpzP9e5ShGJjwfRzZoX8BrKj67BgDqzhnjhWJo07QGCQfYeyoBzdXIUUiTxzGHgYFby/urUuqN2
	tKEbzkN1TV
X-Google-Smtp-Source: AGHT+IHUC2ftwzSvSylSdT06ajBela8u5SU+ijYkDLGHo9/q750n74l021ps+CiYV2OdEDDglYn8Pw==
X-Received: by 2002:a05:600c:19cf:b0:458:bfe1:4a91 with SMTP id 5b1f17b1804b1-45a166350a2mr28993085e9.20.1755098778076;
        Wed, 13 Aug 2025 08:26:18 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a50b99bsm6611325e9.5.2025.08.13.08.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:26:17 -0700 (PDT)
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
 Re: [PATCH net-next v2 05/10] arm64: dts: allwinner: a523: Add GMAC200
 ethernet controller
Date: Wed, 13 Aug 2025 17:26:15 +0200
Message-ID: <5030505.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20250813145540.2577789-6-wens@kernel.org>
References:
 <20250813145540.2577789-1-wens@kernel.org>
 <20250813145540.2577789-6-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 13. avgust 2025 ob 16:55:35 Srednjeevropski poletni =C4=8Das je =
Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The A523 SoC family has a second ethernet controller, called the
> GMAC200. It is not exposed on all the SoCs in the family.
>=20
> Add a device node for it. All the hardware specific settings are from
> the vendor BSP.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>=20
> Changes since v1:
> - Fixed typo in tx-queues-config
> ---
>  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/=
boot/dts/allwinner/sun55i-a523.dtsi
> index 6b6f2296bdff..449bcafbddcd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -180,6 +180,16 @@ rgmii0_pins: rgmii0-pins {
>  				bias-disable;
>  			};
> =20
> +			rgmii1_pins: rgmii1-pins {
> +				pins =3D "PJ0", "PJ1", "PJ2", "PJ3", "PJ4",
> +				       "PJ5", "PJ6", "PJ7", "PJ8", "PJ9",
> +				       "PJ11", "PJ12", "PJ13", "PJ14", "PJ15";
> +				allwinner,pinmux =3D <5>;
> +				function =3D "gmac1";
> +				drive-strength =3D <40>;
> +				bias-disable;
> +			};
> +
>  			uart0_pb_pins: uart0-pb-pins {
>  				pins =3D "PB9", "PB10";
>  				allwinner,pinmux =3D <2>;
> @@ -601,6 +611,51 @@ mdio0: mdio {
>  			};
>  		};
> =20
> +		gmac1: ethernet@4510000 {
> +			compatible =3D "allwinner,sun55i-a523-gmac200",
> +				     "snps,dwmac-4.20a";
> +			reg =3D <0x04510000 0x10000>;
> +			clocks =3D <&ccu CLK_BUS_EMAC1>, <&ccu CLK_MBUS_EMAC1>;
> +			clock-names =3D "stmmaceth", "mbus";
> +			resets =3D <&ccu RST_BUS_EMAC1>;
> +			reset-names =3D "stmmaceth";
> +			interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "macirq";
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&rgmii1_pins>;
> +			power-domains =3D <&pck600 PD_VO1>;
> +			syscon =3D <&syscon>;
> +			snps,fixed-burst;
> +			snps,axi-config =3D <&gmac1_stmmac_axi_setup>;
> +			snps,mtl-rx-config =3D <&gmac1_mtl_rx_setup>;
> +			snps,mtl-tx-config =3D <&gmac1_mtl_tx_setup>;
> +			status =3D "disabled";
> +
> +			mdio1: mdio {
> +				compatible =3D "snps,dwmac-mdio";
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +			};
> +
> +			gmac1_mtl_rx_setup: rx-queues-config {
> +				snps,rx-queues-to-use =3D <1>;
> +
> +				queue0 {};
> +			};
> +
> +			gmac1_stmmac_axi_setup: stmmac-axi-config {
> +				snps,wr_osr_lmt =3D <0xf>;
> +				snps,rd_osr_lmt =3D <0xf>;
> +				snps,blen =3D <256 128 64 32 16 8 4>;
> +			};
> +
> +			gmac1_mtl_tx_setup: tx-queues-config {
> +				snps,tx-queues-to-use =3D <1>;
> +
> +				queue0 {};
> +			};
> +		};
> +
>  		ppu: power-controller@7001400 {
>  			compatible =3D "allwinner,sun55i-a523-ppu";
>  			reg =3D <0x07001400 0x400>;
>=20





