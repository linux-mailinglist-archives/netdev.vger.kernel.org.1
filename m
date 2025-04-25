Return-Path: <netdev+bounces-185842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BCA9BDDB
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5470E1897DA1
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 05:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C29821660D;
	Fri, 25 Apr 2025 05:26:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D520B808;
	Fri, 25 Apr 2025 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745558808; cv=none; b=hJIsU2/LE53M5nrZcvyhpym/R6IaznPLXViAWovHYac9Np0kg/4N/Xw2n0M2ovURkMr7RrxZRmSTnsVRQVaH00mjqtznLUaLtvYqgUqxoT7S8Wlb7aKaIS54vozr6q0Vc8NDLAJd/CycYukiC9BtGsd13ZpV/R+Z7e0AklkWZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745558808; c=relaxed/simple;
	bh=DHu40UIhkKdjXoKlsrsSoVrYHeDWq3E3jCkx2mydxzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZVCxM7ushhqhlN3k+aiX/N1WEmamny7ozuDydAA6h4spQ182x3Gupni+FguEJeetKEGUEoGRUedrOUv03XQvTls0A0bzgZ88hw2Bv6h1VANFJgqkVgIxmeP0JVFzZ8aw6axBc+d2bgy41sRVkSbeq4H2chTSpOrHIDiD3JK1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5499d2134e8so2004217e87.0;
        Thu, 24 Apr 2025 22:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745558799; x=1746163599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vorWjyWoS+/pe1rTuodzRNXMvlPaeZ3qAjeUiTyfr/Y=;
        b=eWnIGdzuFl/0qIndoSQ7FzEStEi/6Tt9IELqyN+Qqdrt3vFFuEpWI0GFOD8DbC04fn
         lihiv+NOPcLpLG8UD+YtEXYhF6QgK3Z+TCQdIGfvKHwGFn6J62TP7v7WSxr6ELcoHkOP
         p3s3vqCvK4szxXGwg/l4Re28/TAlUsvyxu4sYQ3ihaochAdCGhUPCWQi05fFg49iFqO7
         c2U9yiLPjxC96jzM8Fc8B4UZYzk6fT+ml2K4Ot0BkoRZJrThmme4PtiJI8U1krdVqLf9
         HoE28562QDtVh5IkHrkVS3E4kPkyvHsVSbftjuGBANusvo4oI+rwjs2hcPiMj9ovaIZt
         ckMw==
X-Forwarded-Encrypted: i=1; AJvYcCV0b84bct5RaBFtjpJoZZT+SubwLHVFSG2tYpnSkXE9WmWUAnmpvR8zFnpe4qTG5/ulrf+hQtva@vger.kernel.org, AJvYcCXDDlp9wCgXBqYMnjFTGiAFykAcQGIf5dk1s6Z9yXra3O1NRvKYuaN1WS3jECaVDuIwYMs/ojTMppnT@vger.kernel.org, AJvYcCXiFQrGvteXvlOt8DMdMaietkAagEawhcieTz+Hly0NFKPadNA4G07zTa6CsoIVv2V1KBawmf6VRtqwYxyR@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQSfG4jqCe2ohGH562GBGiaPCDT+dyCXonPG0C1rJGWC3FDXl
	VnnKAqUSzD81q/nyMI6ltab+GROJfwIZAGt/PbmXuf4cKgfKjmxGL+AyED+bL+w=
X-Gm-Gg: ASbGncsFgYTXz1WfIeOQeDaamJCkw5+AnH7/5zrlJt5OsYnoJjRiJb3wnK37Io3OFnW
	IajZ1FLpMcVwf229YiFElmRkMwffXZ/ymnE7qKeXE15vEOjlZdPuTxoLOeCQwiI2W2v3q40Ud+i
	Upo1YvlvXVcoxV7bVmBpZ5fz0rdEkLQ/JUnHRMG1lCnGZSmGMaPPUYjd9Q5dUs5fuXAJ1G6CoDA
	J40+X4PH4EspQVMwWx9DmTILbOhfam9TzRFs1HHKzlMrVAKbA0HVYANkLfEabhN0uXJrBU0ptt2
	x5piXe+xccyfZVYGbzbvdAOgPVNpxqSVC2Gznob10t7EpJ2ORv9aFrMDCH4AYFmiRfyp4SGcnIG
	jSwiAlQxH
X-Google-Smtp-Source: AGHT+IGpAmQmKYbxZZU2G9HtLZqcwF1g7fwu85alo+iml0RAysfNFhv2BeEXvi8MpguC8jPhjQGqkg==
X-Received: by 2002:a05:6512:3da9:b0:549:b0f3:439f with SMTP id 2adb3069b0e04-54e8cbdf78amr239531e87.25.1745558799052;
        Thu, 24 Apr 2025 22:26:39 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb26211sm482158e87.44.2025.04.24.22.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 22:26:38 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3105ef2a06cso18112051fa.2;
        Thu, 24 Apr 2025 22:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbB9Z6T6TXKT7yfZrynYcgZsJCQj2bZjhX7cPdXZYwrAPmgFDKAEQPFXPsUzGCQaxEgTttYkZ+xWp2@vger.kernel.org, AJvYcCVCs+FaHBpIyjeH6rpyzUQ5XwiwZsNURa5EUwlLklbrcfsS7RVIEAiDEwtvKFIvQx7rCssTJbMx@vger.kernel.org, AJvYcCVwJDl9eSrvFWYLHKOK9SUemAQ6+73wDNOGGYHHjKulIAI0hkgkUp1/Jw6dsBxuYwUjueT/9DOWi/nAZ2te@vger.kernel.org
X-Received: by 2002:a05:651c:542:b0:30b:efa5:69c3 with SMTP id
 38308e7fff4ca-31906e314a0mr2145241fa.22.1745558797847; Thu, 24 Apr 2025
 22:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org> <20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org>
In-Reply-To: <20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 25 Apr 2025 13:26:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v66a4ERAf_YhPkMWJjm26SsfjO3ze_Zp=QqkXNDLaLnBRg@mail.gmail.com>
X-Gm-Features: ATxdqUFQB3DitZ7r67Jb5Ui1og31mJLNpJsBnkQBmfhJ0SUAid0UCHRMYJY-5Nc
Message-ID: <CAGb2v66a4ERAf_YhPkMWJjm26SsfjO3ze_Zp=QqkXNDLaLnBRg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andre Przywara <andre.przywara@arm.com>, Corentin Labbe <clabbe.montjoie@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 6:09=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
> including the A527/T527 chips. MAC0 is compatible to the A64 chip which
> requires an external PHY. This patch only add RGMII pins for now.
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 40 ++++++++++++++++++++=
++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/=
boot/dts/allwinner/sun55i-a523.dtsi
> index ee485899ba0af69f32727a53de20051a2e31be1d..c9a9b9dd479af05ba22fe9d78=
3e32f6d61a74ef7 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -126,6 +126,15 @@ pio: pinctrl@2000000 {
>                         interrupt-controller;
>                         #interrupt-cells =3D <3>;
>
> +                       rgmii0_pins: rgmii0-pins {
> +                               pins =3D "PH0", "PH1", "PH2", "PH3", "PH4=
",
> +                                      "PH5", "PH6", "PH7", "PH9", "PH10"=
,
> +                                      "PH14", "PH15", "PH16", "PH17", "P=
H18";
> +                               allwinner,pinmux =3D <5>;
> +                               function =3D "emac0";
> +                               drive-strength =3D <40>;

We should probably add

                                  bias-disable;

to explicitly turn off pull-up and pull-down.

ChenYu

