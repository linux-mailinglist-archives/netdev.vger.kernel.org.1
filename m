Return-Path: <netdev+bounces-220834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 617A9B48FF5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26EF47A59E5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21EA30BBB0;
	Mon,  8 Sep 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuCDerxS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983330BB92;
	Mon,  8 Sep 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339107; cv=none; b=eqQ9g0UfFXScMavacTKf9KAU54LZeMQkf6RuON/Lo0TKDJsbETStKveJj2zap5I/9isbKevHVT3AsgCQWXlhpAllqeSE/618kuBL+nGvcsdIpCwCZ49cnfkU9ZtYTXNLxiCfgwUg/FMR5w7lFdCmNRPztdJBLo09TH9y6v01qq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339107; c=relaxed/simple;
	bh=6Exa49x2tTun8/GdPZIClkbq/hZZCYAZWPs6tflMRhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhrmnD1+ozBrSw88N/WVUaR1/qFntyBnk8n/dOABmft85QfT/R/6UfIi4IqSFyRzSMC+Uu8Ivl7SzBgadlNtEQm55wjL7+hC1NC9DbcaiKtGeXdfdV3osIW3nOH69mOttH7FSM0NwOQfKC3+uFyxdtPiaZq+D/tZIRJAn/LnXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuCDerxS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so1922673f8f.0;
        Mon, 08 Sep 2025 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757339104; x=1757943904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qa2FDEzfrHnj9/Bgif488Zx3zsoWnSpMm3bjoJ5kMkM=;
        b=TuCDerxSxtZnl5PrnDzbFxaM5Wd5I5krD+QJ4QZWVGVehWdUJo4vDidWDdhypgcZuu
         ozXT9EkK4vw8YiTy06bzuCd7/sDSQ7SB2dRCnQtBS+PkU6bZoZm8MaCR7zO6Erb+aNcn
         COYvFuziCeNHg72LvgPw2golhu2FgBFvUrhGlI79T6oclvB/cQjB3Vy5Sioy9UCbobts
         5Ma+XlalciiXyOQMZiDIfsZSyyEY8JTzYYgLC+BJzYqlvd9+N22YA5sOWnzUsNn7mZ8T
         G+y++HX40bm/CLmi5iS+StRIcvzcyzJ0rj7opogCGwcdkwQCDr4GyJXlmSXQj55k18GS
         xfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757339104; x=1757943904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qa2FDEzfrHnj9/Bgif488Zx3zsoWnSpMm3bjoJ5kMkM=;
        b=Ac3048jGuEesAV076kPAbq7zCTVB1mf7ZOiimTQd7bim0mqL35pIK0jbR3kL3aedEE
         4nJDH/lOCrb3tHCt1eUXMIKHP3Zx0kte1jDF0rQh0hp8t0Od0Ti4ateCHZlxdwMr5nHW
         B5RRCVBZ38dVb0QLftEgYTtAyq/0m8S6rN1umugU9nsnC04SW5og2+5QGWkCGdEB7xIS
         e2PqUM5CHWaJWtCrM6/PaV+Q8y5zeKmACWHv7Cmqm78W8JHWfsHFxwOmHjMZoPGLwBWE
         tGY0I6xv3wIgTjOuhNC3zQKyIBYLS4Mw5JpBam9F16Mt+tsYk8Fi9JbhxQHcZEWKF2AI
         /TMg==
X-Forwarded-Encrypted: i=1; AJvYcCV3aDQjJwvfjNUFbaigIA4wPseGmTjpznQ08M+FjDcaMkdpbiMTpXf2fnu/HjOckRU2dHcQDza3cXih0Slc@vger.kernel.org, AJvYcCX0LUvRfsH34chcq5Cacs6qOhgy/JHJceFCxWJQAiqAO7zjLRGInbF78xPX9HT6+H7e+YGcvQoeL39C@vger.kernel.org
X-Gm-Message-State: AOJu0YzmlfxpvvsiY/R2vBf1fAsQfZJBTDdswEP2YhPfrjM6oDDt0mrQ
	1076bKT/POouTGHpmQZdTMvojec/kJg8TE23broLOknwckswDM7wV/fd
X-Gm-Gg: ASbGncshvzKnCnRHBK45n9y1zefLP9m1gSp83OYNslXWoQlx7/2jR7VvqHN17Z8esvy
	XU/PW5cizz3Q/vHRKzYJ3p0d76c5fY6iDSRzA4daFEmNMa/tRYLUBfu+KvIeN65jMOr4pO0EgwD
	7ssEp1V0pu/8RKjEjSKnxkjrJNxRMiT5+yIKx+AmbTCOguIpzqGzCK+5FT4NIoJk2rHkGyw1Gf5
	KV+56eOsknTNaEiyasS+xpu+uYwNLjqcxSHmiHf3A0zEKTB3s9ojyJVPPpc2CoUzzoJ5mcwglmW
	Th8BltqyZ9fHhLveaoMCkAxrRfGeJGgMoe3tHdFawodH8uOrFOqQz0z1heUxeql3p9lVBsPMWZE
	XdYLUopACyY5k95OiHz4X6neZbCuCJawJemMz4RMFzzndJhFla1BK/Wn7nN4hoLcTekW9lHEcUp
	qSWdUAd6lQqRZp29/CpyM=
X-Google-Smtp-Source: AGHT+IF/bu6N4b17VGa4d32p6sVB8f7trrLvKQqSA5MvaDaYKtxhuslb1edIkbNaktRAD6ubBUZRfw==
X-Received: by 2002:a05:6000:389:b0:3e6:fd4a:940d with SMTP id ffacd0b85a97d-3e6fd4a9c30mr6459105f8f.12.1757339104123;
        Mon, 08 Sep 2025 06:45:04 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfc3e11esm96635905e9.0.2025.09.08.06.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:45:03 -0700 (PDT)
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
 Re: [PATCH net-next v3 06/10] arm64: dts: allwinner: a527: cubie-a5e: Add
 ethernet PHY reset setting
Date: Mon, 08 Sep 2025 15:45:01 +0200
Message-ID: <2795513.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20250906041333.642483-7-wens@kernel.org>
References:
 <20250906041333.642483-1-wens@kernel.org>
 <20250906041333.642483-7-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 6. september 2025 ob 06:13:29 Srednjeevropski poletni =C4=8Das =
je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The external Ethernet PHY has a reset pin that is connected to the SoC.
> It is missing from the original submission.
>=20
> Add it to complete the description.
>=20
> Fixes: acca163f3f51 ("arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E=
 board")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/ar=
ch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> index 70d439bc845c..d4cee2222104 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> @@ -94,6 +94,9 @@ &mdio0 {
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





