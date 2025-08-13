Return-Path: <netdev+bounces-213392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651CBB24D6E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562F8623D63
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDC423A984;
	Wed, 13 Aug 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3lnuXG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F623817F;
	Wed, 13 Aug 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098856; cv=none; b=sHwBLhygGjjar2TqEE5HmImwg8iQUzn4yu3kN/O6gssdcH9B55Q2B4Dg0BflIz8r32KseBuNAAaLUEQQwgzU5yUsHNSN+d3NUpbvL+AiFayl5T9tNew2ZMT9k43H8gcJIDAQFFpgNNVjmbexhV0AyTB+0IJAXncbKFXQqg2LxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098856; c=relaxed/simple;
	bh=bMtRTyNC8XaiosYhETEdD9uyGasVz/E3rm8ZJMLtO2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sauBnuJ3PDSnejhWFicMOQSYaeoqFbRoLuCmG80KkMDuAuhk8OXPtMYsj+FU0PPzm0d6iEtQt14ejO8aikyvzCZZ/y5Q8xLnh6p0933XVb7wzQQ4vnmS89hjBPcbt4RwHxeYS49LdxTasX+WNgMHtq00pXPRQzrEDPNOUwmSfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3lnuXG9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so58622715e9.3;
        Wed, 13 Aug 2025 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098853; x=1755703653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPXPkObct2Bs3tFQz0c3H79KmxSoBx9liY5wCkk/izg=;
        b=G3lnuXG90GgLlbza9sSLe8/J+a6/ju43IX+TTOgrT3RCU/hQ31AVz82lXOBG/xsbvg
         Dyj0u+Hfop0T2Yq9YISmsxuuKOJek9Im/h7oeNHlmd6IPzYOVUPUHoV7GNoqhzMqwt/z
         pZCS+/nCcrwkPPAz8AVP/dsXCGt+f7RlUShMwUiFLjLcwHH22tttZTUubc0NnA4ELxcb
         ZGoD6q5E5Mx18IcWYL3veZmZor9I7s6T45g5Tj8CCO+1c8gXmRXRJCxD5MqGKF3AlcsL
         IHLB4xNvrleKZaclw0EBk3S1fOcFFoFScZYdNlvtChqy+oCkgtVAxIB1a24u70pVYQbE
         MWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098853; x=1755703653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPXPkObct2Bs3tFQz0c3H79KmxSoBx9liY5wCkk/izg=;
        b=LqhklTuikEwPeGhRYe95RTcNpNfReh7qaY0TzfEEOsUHKxcwAKTB+JoMLFAAO4GLZ9
         SQ99FEmOzKCG1nmACsnbuF1Yc7G3ke1+yrgKiEH/Domnl+zAjxkAwUbdQFVT701kP3WJ
         y6eK5rN3QlxVtbP28+gkZzVl3IVHzVrOWWkQt5rAs5hSpLkozABiBweyTavy20vKr4Sn
         Ak43evR24EgGw1fkWbM3j9EhdED3ZCBAVm75PxUShwNIZlM3Yp7XHMpXQUOwe5TeYH5C
         mSXUDs2NzgG2iPXGMb5Tsz1YsZbjmP8wKOj04VqZU+AFe34EGelzq3B93c2rEjVjqxvh
         J+ag==
X-Forwarded-Encrypted: i=1; AJvYcCWVz1A/h+5VCRNltAWL/UdYk+cv+HV5dakYFSl+eLBIvQibA7IRpcq6srhjENmzfZoMms5CgpBJI+s8tsMf@vger.kernel.org, AJvYcCXURnY3yyMkZLgbiEj4WBFFCOuEYjl0qw4EIiroQsq/YkJU+SzoL1UtCsQHBjWGJx8QrkUqKRzru0N4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3v66So3gIhVGxxVJ5TXkbB9sPXeXZcYUDiAPKunJ+LckNt1Yz
	QwmUYfeCivjiFt9ccjN676jghUvN1aDukTM4zP8cXMhNdzKZENsElFkF
X-Gm-Gg: ASbGncsTOw+oSaxj+8dta8G+rfUHfrZBavZtVbROXzf9vvw9IAd2Ka5tc3I8iINpIMv
	vToYIjU17RCIOE/EoXxH546FZhdGZTMKRcKg0q+xCJ3hneeWRrdyh9ME6lpAOIcWG9PFp+fciPa
	S+7Gp9jQZ6QK6yKlkz++MeIl+Vn2FvNeMxTOwRboCA/k3LIPtYYk8u5KRpuncAmUwPEJQAbiISS
	1LgvWG2G0MgCfw2gMr4Jdzx7JodwUN9E8lwsA/PWVE3FjZyM3D6/o3Rg0fREKbt6ytRXBBsy2r/
	Oytihmp6qPX3iMgyokmHuUmV8eirjZqOYg11MZak9CoyG1mB/G8Zi1AW+8jcEMaOLqWR9faD2sb
	T6DSQQX5YoSd+BoKyCmdLjx0avsO+ZTeimBu6Mqtumc3MKNkqmRkt5xB4MzNnBqI0jRHCyMEfLu
	yVKLgN512MxAlbrKNVJw==
X-Google-Smtp-Source: AGHT+IFGLxAAuIuAWtxyOeZe/1vszbnNDC/nHj+B9y42HewYnwzUn1i2VqNgC/DnOaT+IjRwn6AcUA==
X-Received: by 2002:a5d:5f8c:0:b0:3b3:c4b1:a212 with SMTP id ffacd0b85a97d-3b917d1d646mr2962333f8f.7.1755098853098;
        Wed, 13 Aug 2025 08:27:33 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469582sm46991138f8f.52.2025.08.13.08.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:27:32 -0700 (PDT)
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
 Re: [PATCH net-next v2 08/10] arm64: dts: allwinner: t527: avaota-a1: Add
 ethernet PHY reset setting
Date: Wed, 13 Aug 2025 17:27:30 +0200
Message-ID: <1928131.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20250813145540.2577789-9-wens@kernel.org>
References:
 <20250813145540.2577789-1-wens@kernel.org>
 <20250813145540.2577789-9-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 13. avgust 2025 ob 16:55:38 Srednjeevropski poletni =C4=8Das je =
Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The external Ethernet PHY has a reset pin that is connected to the SoC.
> It is missing from the original submission.
>=20
> Add it to complete the description.
>=20
> Fixes: c6800f15998b ("arm64: dts: allwinner: t527: add EMAC0 to Avaota-A1=
 board")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> index b9eeb6753e9e..e7713678208d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> @@ -85,6 +85,9 @@ &mdio0 {
>  	ext_rgmii_phy: ethernet-phy@1 {
>  		compatible =3D "ethernet-phy-ieee802.3-c22";
>  		reg =3D <1>;
> +		reset-gpios =3D <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
> +		reset-assert-us =3D <10000>;
> +		reset-deassert-us =3D <150000>;
>  	};
>  };
> =20
>=20





