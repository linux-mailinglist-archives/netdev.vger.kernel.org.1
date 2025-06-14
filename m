Return-Path: <netdev+bounces-197840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B4AD9FF8
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 23:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9DD175E0B
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 21:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52D51FCCF8;
	Sat, 14 Jun 2025 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYh81WN0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9BE1DF246;
	Sat, 14 Jun 2025 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749937943; cv=none; b=lHSG325bvsWAP/bKGvqrwUGVz3QynWLBGmrr+Url7XRidKIKYqv/yxdSDGzaoGZe4Fd8Vt1jLmvWXvNEf5G+oXlsFejXVTTFnwGffM2N1tZkpZYN+Am6ybNtD/fkJRHpfahrVSXznz4T7/biJ4AQfdpkCfuVWtdG/k5nQxAwRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749937943; c=relaxed/simple;
	bh=1zgSDBZr5Fkmb/y7roQGPX54QUJVPxcs9B/Z9Z2RXOA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bvNgF8jq/ITcZ8kYN0yymf9KUvPBV8eGbTytIOy6ZAYFXpPJj3F1RY8X/szzDCHbhYbC4+SsJYKWWpHgjvDtoe71HldPV6n7xImRLk6+E3oWGhsI0os9iZcUQJG29qyGEERT1li0iwFz56l++LhEv2ogq+2z0mrKCoguv8DnEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYh81WN0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so39560525e9.2;
        Sat, 14 Jun 2025 14:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749937940; x=1750542740; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bg1odM9KUcbjVWw6SM2h9C8Ehh1I33FXJkfY9DO2daw=;
        b=VYh81WN0PxO6gTRDarXhCG/Ud6ua/Y/AQv3yE6GiRJyl10o43TJmcCe9Q8csnOs6lT
         0HhuZXeOUUvCkDuSPOTK9SZ3L8IKnOeKohHPCowxompLwmBX2yQe2udXXediXO6KCLxE
         hDtNNWazR5jf7CTMxEiCGbWoWbQ9G5pVNHjC+OxivwAKP648CgmSaf4CDAZA1iLMMYFr
         DyUD8zy/hUruChRpJZPv4Qu/fFbfmeoy//RH23bUi3PvfoJr/6QK07s+K+4gc1qNbubu
         MG9NISM5mRK2uCxkIw52t2SbB9l7sw0Mo0aNE7ebATOSDv4Bg9lUsSXMcHZR2f8pm4j2
         FU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749937940; x=1750542740;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bg1odM9KUcbjVWw6SM2h9C8Ehh1I33FXJkfY9DO2daw=;
        b=ajqeNnxOnWCHmp6a3xzTYKkdEnOx7GbsY95539mFDAGgeEhAk4DV20G+k7tBoEegpp
         TUjp+sQ0GdScW6g9DRVy3ajqWsxfKA0pUGwFXSP5JCG3pHhGBj92B52O0wDrGisQf5OL
         6cQIMqlD77BJK1oU1+RiJiy90cuX8pvohenhTp6AnumWgMJvUM7yLkzxIGvPB/cjoJGS
         NNVjZMP6itUH7dtPNqJQITyj0APNPe4oGAuJQk0dsM3UgZ3lPSmygv1VRgF5B6Qcu3vU
         /WAF+rV13xZy9+y7NySl3PqarmdcE/SC+deuebe07EJepEDEON5Ve4HsjBdbGCTXnE1N
         gW6A==
X-Forwarded-Encrypted: i=1; AJvYcCWSaTZ1qWjhz72d1WQPuMqfdEhBrxbZosAxDdQ8MM5t4z0gsr7M+S4jXFr5+s+OSlDwvcR66Es7zp9RTT38@vger.kernel.org, AJvYcCXUh2y6S3dsCbkqlsXvWhAvr7ZimvvIsSKsSirX+BZZ1W4KhGjv4GyQNCvw4zakqHdDP76V2I1S8K7L@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8aXRMLxf/cj1R7VtGp1nYxdgxQ5LFtAlSWp6na9EbVamY7uX
	6YsVTi+RlRyJF8jJboJeV3B9Pj4MBUKuB2i+zgou1/IqfN5ysHpkcpHi
X-Gm-Gg: ASbGnctsIZeVUoBtWuciY4aKoESpLeZNsfGXU9gb1hiqiqZtNebEKz/KTdNqlQm6HOP
	5wtQ+ptKB2TZ5U4QPst1Gknp+Y/5fpBQTkqFQ2I+Zg8Yz9pGceL5sWNw3rcCix0Pai6IGfAEUqB
	vynQAKP87RHizAS77IrfEmHQiFYCLRRhrA3vanfshrBUix4yuw3e9Mg88pBNnp6V95iJNYnt4a7
	ukG1QN7mxg12BGR3FF8kpUgsQ+YLofsh0noZixUZybE30voWgxbqyrVUfljFEjLLjPRRR1CefQj
	sOaln1Hls9FInKDYhbLtMXTqd8CxRk9BvfoetXxrhULysBkSlwrfAGwL03tWpswX99qeBgDOVwb
	Wyue3lw==
X-Google-Smtp-Source: AGHT+IGahM28OixwThHb31jCwhtlrClMJngbczGluvHx5ulPSa+4X0NSYo1XxDZlq6XZ+IJhlazykw==
X-Received: by 2002:a05:600c:c117:b0:450:d4ad:b7de with SMTP id 5b1f17b1804b1-4533cc69257mr35521775e9.3.1749937940275;
        Sat, 14 Jun 2025 14:52:20 -0700 (PDT)
Received: from giga-mm-7.home ([2a02:1210:8608:9200:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e13c19esm92865075e9.25.2025.06.14.14.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 14:52:19 -0700 (PDT)
Message-ID: <e84c95fa52ead5d6099950400aac9fd38ee1574e.camel@gmail.com>
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
Date: Sat, 14 Jun 2025 23:52:30 +0200
In-Reply-To: <7a4ceb2e0b75848c9400dc5a56007e6c46306cdc.camel@gmail.com>
References: <20250611080709.1182183-1-inochiama@gmail.com>
	 <7a4ceb2e0b75848c9400dc5a56007e6c46306cdc.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-06-14 at 23:01 +0200, Alexander Sverdlin wrote:
> Thanks for the series Inochi!
>=20
> On Wed, 2025-06-11 at 16:07 +0800, Inochi Amaoto wrote:
> > Add device binding and dts for CV18XX series SoC, this dts change serie=
s
> > require both the mdio patch [1] and the reset patch [2].
> >=20
> > [1] https://lore.kernel.org/all/20250611080228.1166090-1-inochiama@gmai=
l.com
> > [2] https://lore.kernel.org/all/20250611075321.1160973-1-inochiama@gmai=
l.com
> >=20
> > Inochi Amaoto (3):
> > =C2=A0 dt-bindings: net: Add support for Sophgo CV1800 dwmac
> > =C2=A0 riscv: dts: sophgo: Add ethernet device for cv18xx
> > =C2=A0 riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
>=20
> Taking into account, whatever MII variation is implemented in the SoC
> is always internal (and only MDIO part is multiplexed), can we add
> 	phy-mode =3D "internal";
> and
> 	phy-handle =3D <&internal_ephy>;
> right into cv180x.dtsi?
>=20
> Boards can then enable the corresponding nodes if they wire RJ45 connecto=
r,
> but I see no way how they could vary the MII connection.

I suppose the above proposal was wrong, though undocumented, there seems
to be an external RMII interface (at least on SG2000 SoC).

Unfortunately the internal PHY is also barely documented...
Also ethtool seems to be incompatible with mdio muxes :(

> > =C2=A0.../bindings/net/sophgo,cv1800b-dwmac.yaml=C2=A0=C2=A0=C2=A0 | 11=
3 ++++++++++++++++++
> > =C2=A0arch/riscv/boot/dts/sophgo/cv180x.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 70 +++++++++++
> > =C2=A02 files changed, 183 insertions(+)
> > =C2=A0create mode 100644 Documentation/devicetree/bindings/net/sophgo,c=
v1800b-dwmac.yaml

--=20
Alexander Sverdlin.

