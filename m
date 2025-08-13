Return-Path: <netdev+bounces-213391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A215B24D65
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EF53BFCB0
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DCC233712;
	Wed, 13 Aug 2025 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQIqzT5R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCB2376F2;
	Wed, 13 Aug 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098832; cv=none; b=oNKFBYC1J1gjJKQ8j1ShnbgkEvFEE/jT1Lpi1bXp8811dLPEXelVhCgP+X3utgk/mRbQxwlbH91T2UBtbwWghOHjlqgj5CsckeL7f/SoL/Q0PQUfJD5Zbq17bqP/d8pBSi59uXs/2TWNT6IwZ1x6gJBuEeh6nUhEGPMKs65OqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098832; c=relaxed/simple;
	bh=alzjLEe2fEl8rrt5jUx+xc9uy3t9RY8ZhInQDMnJePA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGefHnZhOOXQu2lMl73rgeciOxKBnOiV9h2iIPdDf/W0ct65UhkrP5nVGYrQZiwlXOQCVI5tFQBP2GtfsZhlVe7sLTxa9zuGYKuj+XYMgJ/cIU+5ykBK983UF5TraRGLYcVf5unugjzw2SP1JWejSnhoMPdoqahYTLDnX8yAzDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQIqzT5R; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so61288455e9.1;
        Wed, 13 Aug 2025 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098829; x=1755703629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZIyAAVxGkCRQr9BUYAZ8nPgNM4Ndhfq5a5jE1scOa0=;
        b=gQIqzT5R23JfKwuqlIdd/0VYLxZzcTOMtcTB1l6cq+EiZbro+Vb6/WUP96oJ5K04Ow
         SacKeJseCjqmJqqm4INmyFxy+KN5pwa91RsQBknnks4uGSO12wd1ZJAMDW73YtksctiM
         NRFg3uxAb4yfC8+w05LsC3xhPwR617X2o97wqg8y5Cr4y7PslIu/641R28q7DStdrLFX
         iExJEYr5NWbjZ2W01GuSTXKRH2AZrsUN/tL+LMmkbIg8io8AENWcYQKJ/nTAz4GQI0Z7
         ibD0gekbtb7VALg+FZx6PMbcg8R5YeTNh3k6oi8vu7NOIWgHMCSYIviZstN3iv+Gdjoq
         X3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098829; x=1755703629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZIyAAVxGkCRQr9BUYAZ8nPgNM4Ndhfq5a5jE1scOa0=;
        b=JeNOXl1yVFywlP14ZRXDJt8KcNL7Z5i15G3+METvqMNTm8vuc8QGakySjkiPc9TZYx
         rC43QtlZB3gX5SR/Ab2xdKwbEoN0nCoyHDwwldzOB4EQBxYFB47y44K7sgZY07cweAAZ
         cH4R0xnp2ngnxI7cpQ9Lmmm52YZmXmcVNlpfORTSwDUmDyZq1m2WiPQD2Dcp2aXHediH
         cuTJ3FIIu/6wEMAXxvFrz5eHaT4Jk78uObYmLo7q4o1jfbSPgXIOJ6s52XP4S6AGdHGl
         sA8w8Tfb1RfhDWM9PdIT5ADJnRFc+h6byEbHavaQaonKuPnzX1539zswtFrMkT4FDXiw
         KISQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIIb3ntoaUrICl9I12UWWFiSnSQ33TajWC/KqKy30ahVThkcUsKl/xwJ8wPNg0mdHlOhEpFAynLB2e1bOj@vger.kernel.org, AJvYcCXrLmXdOALN3hNM0zDzPWwAL1Q4mb3zybXLfQy1VBsuoHjwJMMRqr9ZqnRko7P3jTa5ebbvwIYoHNdC@vger.kernel.org
X-Gm-Message-State: AOJu0YwWami05G5/dIDpw8fIrVldcIL45jxlXoKlkc2SsgeYmL//qhrY
	xGPiuSrjh0jQ/1wfDd04kAWCICGKNI2PJp7DuxKTYPeLmxdbdnnmZJkuPnH2tw==
X-Gm-Gg: ASbGncvq0MeENQVGZ/AjefmRPP0H3+rPhc2qUwUscdVSSqr2iztL2m4XjHoyDiHtA4Z
	tA95f8BVNU7dtaRSpIIE5KkTlAqSWAhU79D80f93wScGeVUQ3kF9JrSy7MDlEqak7KcnFxTuqV/
	SvyGdbfCccBU9WQix7gdYT3IqoISx/RMZZU+m8guFov93U1bkNoCAoDefG9HAi3fxkoF/qSDPac
	sJiUYuufCHVAMrz4r59AZZwHtIYSu+dX9wvxlz5A1PS9OZ8E8he6n/Uksy3N7JsgZrcZlYQ8bdm
	ayh9IW8NboJk1o42PNzbYaMEyGNsRlho7BIeAVYGZS0TvDKJukT7HYhsilSP9ZKSV3npGFvoyNY
	d4ZrOpz1paVAJphhOSSEb7EXGbQTgrh1mYeMrXSmvA2cYprJhaoSRTUWblt6k/PtimSyC2j+z2W
	xZb9k/16NM
X-Google-Smtp-Source: AGHT+IEX4BDNa5mzqwSGmhUw6KuEqvUFZNcO+D5WjOPXTrwn2jJiUF7/1VKfEyNQ34hedf4mE52tig==
X-Received: by 2002:a05:600c:5254:b0:459:ddad:a3bd with SMTP id 5b1f17b1804b1-45a165d4d2emr30205835e9.15.1755098829053;
        Wed, 13 Aug 2025 08:27:09 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a509b9bsm6560505e9.6.2025.08.13.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:27:08 -0700 (PDT)
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
 Re: [PATCH net-next v2 07/10] arm64: dts: allwinner: a527: cubie-a5e: Enable
 second Ethernet port
Date: Wed, 13 Aug 2025 17:27:06 +0200
Message-ID: <2376533.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20250813145540.2577789-8-wens@kernel.org>
References:
 <20250813145540.2577789-1-wens@kernel.org>
 <20250813145540.2577789-8-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 13. avgust 2025 ob 16:55:37 Srednjeevropski poletni =C4=8Das je =
Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> On the Radxa Cubie A5E board, the second Ethernet controller, aka the
> GMAC200, is connected to a second external Maxio MAE0621A PHY. The PHY
> uses an external 25MHz crystal, and has the SoC's PJ16 pin connected to
> its reset pin.
>=20
> Enable the second Ethernet port. Also fix up the label for the existing
> external PHY connected to the first Ethernet port. An enable delay for the
> PHY supply regulator is added to make sure the PHY's internal regulators
> are fully powered and the PHY is operational.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>=20
> Changes since v1:
> - Switch to generic (tx|rx)-internal-delay-ps properties
> - Add PHY regulator delay
> ---
>  .../dts/allwinner/sun55i-a527-cubie-a5e.dts   | 28 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/ar=
ch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> index d4cee2222104..e96a419faf21 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> @@ -14,6 +14,7 @@ / {
> =20
>  	aliases {
>  		ethernet0 =3D &gmac0;
> +		ethernet1 =3D &gmac1;
>  		serial0 =3D &uart0;
>  	};
> =20
> @@ -76,7 +77,7 @@ &ehci1 {
> =20
>  &gmac0 {
>  	phy-mode =3D "rgmii-id";
> -	phy-handle =3D <&ext_rgmii_phy>;
> +	phy-handle =3D <&ext_rgmii0_phy>;
>  	phy-supply =3D <&reg_cldo3>;
> =20
>  	allwinner,tx-delay-ps =3D <300>;
> @@ -85,13 +86,24 @@ &gmac0 {
>  	status =3D "okay";
>  };
> =20
> +&gmac1 {
> +	phy-mode =3D "rgmii-id";
> +	phy-handle =3D <&ext_rgmii1_phy>;
> +	phy-supply =3D <&reg_cldo4>;
> +
> +	tx-internal-delay-ps =3D <300>;
> +	rx-internal-delay-ps =3D <400>;
> +
> +	status =3D "okay";
> +};
> +
>  &gpu {
>  	mali-supply =3D <&reg_dcdc2>;
>  	status =3D "okay";
>  };
> =20
>  &mdio0 {
> -	ext_rgmii_phy: ethernet-phy@1 {
> +	ext_rgmii0_phy: ethernet-phy@1 {
>  		compatible =3D "ethernet-phy-ieee802.3-c22";
>  		reg =3D <1>;
>  		reset-gpios =3D <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
> @@ -100,6 +112,16 @@ ext_rgmii_phy: ethernet-phy@1 {
>  	};
>  };
> =20
> +&mdio1 {
> +	ext_rgmii1_phy: ethernet-phy@1 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D <1>;
> +		reset-gpios =3D <&pio 9 16 GPIO_ACTIVE_LOW>; /* PJ16 */
> +		reset-assert-us =3D <10000>;
> +		reset-deassert-us =3D <150000>;
> +	};
> +};
> +
>  &mmc0 {
>  	vmmc-supply =3D <&reg_cldo3>;
>  	cd-gpios =3D <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
> @@ -240,6 +262,8 @@ reg_cldo4: cldo4 {
>  				regulator-min-microvolt =3D <3300000>;
>  				regulator-max-microvolt =3D <3300000>;
>  				regulator-name =3D "vcc-pj-phy";
> +				/* enough time for the PHY to fully power on */
> +				regulator-enable-ramp-delay =3D <150000>;
>  			};
> =20
>  			reg_cpusldo: cpusldo {
>=20





