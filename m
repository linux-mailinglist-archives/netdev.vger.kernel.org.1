Return-Path: <netdev+bounces-197839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E2AD9FD9
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 23:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACE117356E
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 21:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6FC1F8BBD;
	Sat, 14 Jun 2025 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh7Ocsym"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6B1C3314;
	Sat, 14 Jun 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749935969; cv=none; b=ZA6hDVnwo/qLT+u6gkn+I5Q13R5H398sCqxKy2XI3fvj1sIndek03VpClbXbt4YvvoI2qulc0BhbCHh+wXOaulLIqumz8SSeD5lZvbFKl87jujFHROiQUIui+jYVirSHHlN+oI6WC1Ka9P0Aqb79ZA4sW3muo8G/i0ONwsryEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749935969; c=relaxed/simple;
	bh=ZG3m7rZlu9KiGWUjBU4xheaArIWltgYwYSheh/mlU2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hL/JNfI75NnSySV++nB8q/HpVsSM7Bce2SPeM/vF8EpRG8voMBOzTWlo4lmcEui/Bz9CqFS0QH9GB+KNnutH4/VEMKHp7MMZNkLzeWEuNUXB0GWg8YxNrX9rjE9pGAexe8wNgUv5XmfTKRaTUvMtZmVPd5awVDo46x5TXHWjJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh7Ocsym; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so21282085e9.2;
        Sat, 14 Jun 2025 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749935965; x=1750540765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=flIDkZqwc3KWW4PKLKGBRVZjvqroSy4sA7R2DG7HV7A=;
        b=Rh7OcsymDNpBmNLhkX6BrJZAJKkrHfIuS8SwtwqQFFlVJN/KBFa3tbi8cv0zZQOlgb
         x1BiNkRULTJ5wP+rWkBjBGbjTqx/P//luJSdIjR7QsgpVenN7hqEzGRrK98iNW4M9a8c
         x0x9bWyGbhk4bwpJcfvig0g2Db6fh/uiJDHMqbbsXZ9FirHWT/pRhgqQ2wdn42TIEzxY
         ML1jH1UT/7CXw0wOsobBbuX/tU7aPmvmXvqSMzvD4Yr6MNcT7LMF1TU3HQk31GbUvM7G
         bZQnw/9BCcOC+8BZEIdItG6fGEz6LhLzaeJQt3z94C2yLIdryipKe/kthFyS5wHSvzqU
         V/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749935965; x=1750540765;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flIDkZqwc3KWW4PKLKGBRVZjvqroSy4sA7R2DG7HV7A=;
        b=szqMxOEbbotM31meyP2tvpQB7IOhfitvHQMk+PyRKVxqukyDg7w4X97lV6TytaqM+4
         cM8MPoU6T+gcFPBSdxFFUgdo5kD2u8kWRQtDH/5+QZKX4DtWOQfd5wUknP9i7MewZULL
         9hrlbPPwUxhVOP18Ioq+ocMrR6lgV3eIhSQ+71flYsFevwnBv18hbERgIjUxXucIVbOt
         LCkHB/b4nd+Xe+5VEixKlertN5nQXlrjVsGS2ME6bhxzmrFq1amhvVHmzdmPIKta7Lzq
         3Ux6dmdQMdU7c5G6d0+alsYKnsCnjEHdWXIXL38ClPJ7xa39+DCdsHDRb4TMi4r8cB6F
         EYPA==
X-Forwarded-Encrypted: i=1; AJvYcCUp3WFUECwS22hvBlUf9SaayPx3nH0/i6fcHDqWHfUe2yB+PWv1yU2xYm5IsO3Je9KDsycoG/VqgB8M@vger.kernel.org, AJvYcCX5rVNdGYX66raeJpLJr01UuZNafW2twJn1/uYuMxlLv7+qUiDrHnpOaHIQ5C+PdZpNQQ0WcXo2UiRbgA7z@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhJtip/5SjWAefS8iKUK2Uiv+bR7dPeMuwQUUJEZIPZpTD25U
	KrQeHB8U57VFWPrZoKLjluvmfjbL9FjuwzNO/2V6fLBle+TBd7iXFm3R
X-Gm-Gg: ASbGncvmOw2HZ/Yda2ZjnJ4SefIkf1JJDkPiiWbcXDL1WW7WXgML//692db4gYM2hsC
	AWFxp3nOVDtgwIHZ3q+CavU4gm1A1FqdNxT4tIa1NqSP6Dt+9kHfAPVKrAOkE97bX5nulg5B682
	FBUPN5P6mCaXCO0cOLgM85m3Tm1KxetPz/9S583VPrDFAm1ty1aBTBKgO7/I12TpGC3Phj1wxJl
	f3byuF8OqfU1HxTzKfPjIHkKcRFJ2w5FTaniIFrfL33tpuLIBHzS93qbTC78raA5Yy+Ez77dfMZ
	wE+VaIpg9iOClXAILSTdIWPmnEyP6MiBohtQpMtyiOaElrBDqbh/eeOe1n+aUNJU4AhPQXFhmK1
	WDTYcMg==
X-Google-Smtp-Source: AGHT+IEtV2JLpbYXhmYcHj10cqAe3Asf5UE3CdzjaK74yJYBNUGOKwUpNJwYbVg31UYOBNO1MJCv6w==
X-Received: by 2002:a05:600c:3e17:b0:448:e8c0:c778 with SMTP id 5b1f17b1804b1-4533cb4948bmr34825035e9.22.1749935965328;
        Sat, 14 Jun 2025 14:19:25 -0700 (PDT)
Received: from giga-mm-7.home ([2a02:1210:8608:9200:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b4e4f1sm5925838f8f.87.2025.06.14.14.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 14:19:25 -0700 (PDT)
Message-ID: <d3b20a9ce58fa296034fe3aa8b60ecde4c4192f4.camel@gmail.com>
Subject: Re: [PATCH net-next RFC 0/3] riscv: dts: sophgo: Add ethernet
 support for cv18xx
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen
 Wang	 <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,  Richard Cochran
 <richardcochran@gmail.com>, Yixun Lan <dlan@gentoo.org>, Thomas Bonnefille	
 <thomas.bonnefille@bootlin.com>, Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, 	linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Longbin Li	 <looong.bin@gmail.com>
Date: Sat, 14 Jun 2025 23:19:34 +0200
In-Reply-To: <20250611080709.1182183-1-inochiama@gmail.com>
References: <20250611080709.1182183-1-inochiama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Inochi!

On Wed, 2025-06-11 at 16:07 +0800, Inochi Amaoto wrote:
> Add device binding and dts for CV18XX series SoC, this dts change series
> require both the mdio patch [1] and the reset patch [2].
>=20
> [1] https://lore.kernel.org/all/20250611080228.1166090-1-inochiama@gmail.=
com
> [2] https://lore.kernel.org/all/20250611075321.1160973-1-inochiama@gmail.=
com
>=20
> Inochi Amaoto (3):
> =C2=A0 dt-bindings: net: Add support for Sophgo CV1800 dwmac
> =C2=A0 riscv: dts: sophgo: Add ethernet device for cv18xx
> =C2=A0 riscv: dts: sophgo: Add mdio multiplexer device for cv18xx

Have you noticed any problems on the board you are testing on?
I've added the patchset + pre-requisited + the following into my board DT
for Milk-V Duo Module 01 EVB:

&mdio {
       status =3D "okay";
};

&gmac0 {
       phy-mode =3D "internal";
       phy-handle =3D <&internal_ephy>;
       status =3D "okay";
};

And the PHY is being detected and the Ethernet controller is being instanti=
ated,
but the PHY behaves really strange: LEDs blinking wildly, link status is bo=
gus
100FULL UP even without cable insterted and the real traffic starts to trav=
el
only roughly a minute after the cable has been plugged in.

I could look into it, if Sophgo has documented the internal PHY, just wante=
d to
sync with you for the case you've seen this already...

>=20
> =C2=A0.../bindings/net/sophgo,cv1800b-dwmac.yaml=C2=A0=C2=A0=C2=A0 | 113 =
++++++++++++++++++
> =C2=A0arch/riscv/boot/dts/sophgo/cv180x.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 70 +++++++++++
> =C2=A02 files changed, 183 insertions(+)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1=
800b-dwmac.yaml

--=20
Alexander Sverdlin.

