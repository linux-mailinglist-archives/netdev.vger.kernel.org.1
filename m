Return-Path: <netdev+bounces-213394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9426CB24D73
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3181C17766A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B3A23AB96;
	Wed, 13 Aug 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkUziWdk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF1238C1F;
	Wed, 13 Aug 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098900; cv=none; b=ZRkAI9XT+/sUZt3iKwfeMKtpN/nBhvatWOL5qBNam/SMGGrKkRFvguH0rdag7yFOiG6CFB/wVksjzsHbNWLhehzvk0xxYsVg6bRffOVgAdAtgbiH9ooSaCdK8HsUJ4v5e6AHLQo5aliVlQwBfKZ6NVseZAvqBq2tVeSFjS/7bYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098900; c=relaxed/simple;
	bh=bjUfZArd1dIc7xzYB2XLMMwVGzBdfmOFwXw1/SOljyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NS49Bz0rAXZJysZjvQOvW7NHnunXRQ/Mj7Drs+CeaJI5vm15S/ZQZP7z+mbzxpiIo+gHCPKUhUfsfJtf6jeNYhhCAOeyTLT/VSQ26IAUGKOrpdY/ENEotG/ujtfye2G+CxQWt7K1gjRf3Y5oz9dIQgbJGDv+jAU7TH5HV+ai6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkUziWdk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b7920354f9so5521019f8f.2;
        Wed, 13 Aug 2025 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098896; x=1755703696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR4hoVadqu8aUTOVreHxSaRU8mKdTHXFpDokGXEFHMw=;
        b=RkUziWdkcobc1+VLt8dmdysE1gqk4uco0MtHAGr5y3islQOQaHk3W2H+d/pGNyl1hO
         USFBdoRQkKGT8YNBZWRX/eCJ/kHqlqCcJ9+aGAQXgOI3TPDL7Kepjc0tCrqj+8k97I0Y
         Tx9bhsgZVht67IVMGYcAvzh82EsSn9coAnkelNaLfkCu9Zo2mFW8qeXNUWHIq+EKdScy
         NS/vrWD8s5cSxUO51ElUWyg/J2YLYOwAsRs34/u3+YS67YOf4jh4QCYQvK8TnLeEowX/
         LPodmHeMXCQb+dJ1iURKgqo8iyfSUN3xnTuWvpV+xZoSf89DKHlbjHy0oTgURRFVEzWI
         PZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098896; x=1755703696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KR4hoVadqu8aUTOVreHxSaRU8mKdTHXFpDokGXEFHMw=;
        b=BTJlyxDnz6+tao0YWH6hCMPpULx/448mmmHN7RK+SH75GenMEhMQOsqxDONgrt206y
         oS1I0ClQNMR1iqinF+xbYfoEhFtOCahQXd7WspvEG/uy5ccwsZfcgedqETfye8LRzXHz
         zJSEfqGr75hwfqt6hW+XFLFIgopflkgF0GeaOD1ewZKBXziVxLeXLaNlaRkNeoUGYP5Z
         vvkFzdDcKiqwuRozBGDLra91mkGkJYbZcKODlOWd94OcbZnkIYpsNZFvgpc+5KiGkarC
         0PS2Tfg8aTYpzzDu1FFSLFErFc0LtUmW3205AmVpKrhQIOatEhO3+Wb/DahFuHzGViw+
         a7PQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5emU64FHKZ+uGhIpKd2zxUx6ovoyYIt3CRuT9LsVb9MHRd8IkZwHiU6iuNU5x9FH4cN+0UClatXuMnVGS@vger.kernel.org, AJvYcCWXV0CKgXb1U3fCXWsTMt7nspJa/thQ1V9lF5wHmqa/Z/AwO/anMU1z4c3hXGMjKc8YQVvWC1TUp8WW@vger.kernel.org
X-Gm-Message-State: AOJu0YxrmUKumarZdBwvdJktQSN/EMS+p2UA6dnipz4cI5hLaqlahk+/
	sEzEfXKERnRSY16FJararOGZseEcbmoOA07GVxq3wk8djhi+GHI6EbHY
X-Gm-Gg: ASbGnctu8dJa75jwLUOeFAfy40jxXfvqNGHj7wJx2dpkXqewaMer4YBrw1pkHN+y3DV
	sT3baK5QXm4NdnIYId51pVLondRFW1k3zY94yD93l43qlUl8D/67+eNe2zhZBXh1mzTTGZNj5n5
	p2awjW+NI0U71uYJ1INYGirrD1PLruCORtExuOs+2IMM7y9V+B8P0VNW6e4iEu1Eu6HlWI9leP+
	ZeGwFTMcyDETbtO6f+KxwBNIEebIfz3Pei4DFhM//AKwmeImeOFJxQf8ewC/UCeH2WCMyi1rvU7
	9Vid3cVnXL4HcEZNaMOPZWiN0uUPYlgznWgsv+775OgvTHjIa08RX9Wo2eBWVPv5HkIXhxrF+Yw
	Kda0QTa+lpufpcguMfh29maNVJb9F9W/ur0jmMN3YjMbQ8Rz6eW/PxW124pylH1U0cEFciNkebW
	jWnULLX7o=
X-Google-Smtp-Source: AGHT+IHE0fucbXsrHkFdPEfs8yK736j25+deb3oJqHtDVR3z1PaujgH3AAxRRrD0UXP0szDCxxOwTw==
X-Received: by 2002:a05:6000:22ca:b0:3b8:893f:a184 with SMTP id ffacd0b85a97d-3b917ecd302mr2496485f8f.52.1755098895560;
        Wed, 13 Aug 2025 08:28:15 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c466838sm50661600f8f.49.2025.08.13.08.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:28:15 -0700 (PDT)
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
 Re: [PATCH net-next v2 10/10] arm64: dts: allwinner: t527: orangepi-4a:
 Enable Ethernet port
Date: Wed, 13 Aug 2025 17:28:13 +0200
Message-ID: <3363827.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20250813145540.2577789-11-wens@kernel.org>
References:
 <20250813145540.2577789-1-wens@kernel.org>
 <20250813145540.2577789-11-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 13. avgust 2025 ob 16:55:40 Srednjeevropski poletni =C4=8Das je =
Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> On the Orangepi 4A board, the second Ethernet controller, aka the GMAC200,
> is connected to an external Motorcomm YT8531 PHY. The PHY uses an external
> 25MHz crystal, has the SoC's PI15 pin connected to its reset pin, and
> the PI16 pin for its interrupt pin.
>=20
> Enable it.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>=20
> Changes since v1:
> - Switch to generic (tx|rx)-internal-delay-ps properties
> ---
>  .../dts/allwinner/sun55i-t527-orangepi-4a.dts | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/=
arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> index d07bb9193b43..b604d961c4fd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> @@ -15,6 +15,7 @@ / {
>  	compatible =3D "xunlong,orangepi-4a", "allwinner,sun55i-t527";
> =20
>  	aliases {
> +		ethernet0 =3D &gmac1;
>  		serial0 =3D &uart0;
>  	};
> =20
> @@ -95,11 +96,33 @@ &ehci1 {
>  	status =3D "okay";
>  };
> =20
> +&gmac1 {
> +	phy-mode =3D "rgmii-id";
> +	phy-handle =3D <&ext_rgmii_phy>;
> +	phy-supply =3D <&reg_cldo4>;
> +
> +	tx-internal-delay-ps =3D <0>;
> +	rx-internal-delay-ps =3D <300>;
> +
> +	status =3D "okay";
> +};
> +
>  &gpu {
>  	mali-supply =3D <&reg_dcdc2>;
>  	status =3D "okay";
>  };
> =20
> +&mdio1 {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D <1>;
> +		interrupts-extended =3D <&pio 8 16 IRQ_TYPE_LEVEL_LOW>; /* PI16 */
> +		reset-gpios =3D <&pio 8 15 GPIO_ACTIVE_LOW>; /* PI15 */
> +		reset-assert-us =3D <10000>;
> +		reset-deassert-us =3D <150000>;
> +	};
> +};
> +
>  &mmc0 {
>  	vmmc-supply =3D <&reg_cldo3>;
>  	cd-gpios =3D <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
>=20





