Return-Path: <netdev+bounces-236984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626D0C42CCB
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 13:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A71C3B0893
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 12:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865782747B;
	Sat,  8 Nov 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lMHQaOiz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187991805E
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762605085; cv=none; b=eQYFyRvguhXyTD6S7PbmKVMIasYyLnOUQNfV/vzpkf+xYNmfucaV8OMe60F5NNcZVwHDCnmY7gfILdfVjtwBhTxZIfo15Uxg6YxnMKP9FVFJrgzAqf05epdlTBn4udISppFfq00y+Cf4CVenmBGs79f5TWjKu1uq+GqEp4ST94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762605085; c=relaxed/simple;
	bh=jFqjvE99b45pu2oCz9ajTBa0meyTTID/k0aUamXBwSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e49DbJOO1Az5ph7zXhdO+TMapGwhP8kqEVeU1Oy5wtTWx9r4h/jWr8c2HUNyPabNvhdXtbys+wWK1Tb2Vo8Kd65Iff3clG7BOXAA8jwlO8nOAhVo7rsNgHxlHnSXufCrZaVK5B+skXGcBCSnUrZVwj1pvbC9v+S1AlTLnt3EQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lMHQaOiz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-341d07c020fso2092459a91.2
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 04:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762605083; x=1763209883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFqjvE99b45pu2oCz9ajTBa0meyTTID/k0aUamXBwSM=;
        b=lMHQaOizdnvBLP8yVB23YqXuyg9Ggt5tT0YPjuogiPgDkurTElDQ70kj/TI0pvBmkR
         4bNtj+OnigZkWiISZyNtQmRH0QVC5lQZeZmM18Jb0deQur5j4QW4DWx9eeszMzhs96Fu
         NMBKpe1jrrG3jZCMd+2PH1qlG6woN9/IpdduiEqENDkDK8aZy6hfOgHZKL9bEbLlqbVM
         ittPrZpKRhW2dRL+9jW/jJIXArJkG4zevrsW3coxss6zjLCkXKSC/ZOHx+GQwKIQVwaL
         tLkY/r0z1OcMusD0p8VVwU19cFiAE+s7t4PFZWNw1uHgi5UQucvqnAM/y38w2Azl+upI
         /scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762605083; x=1763209883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jFqjvE99b45pu2oCz9ajTBa0meyTTID/k0aUamXBwSM=;
        b=PYHBjYq4gUExdiKcR/Y8bdK9rIO6QS5nP4bCt8YMrRYJLo3p13xI6uPAPMXPVbedCX
         1KGze2TCpsfUqvHGMUphD1j+re3aGSX9OYFopdvnxK5xraceXJnBIKtk1F/3BBY2Hq1D
         7bwtSxxA9W927nuUr4SEhQynJ6FDliCGkcydWQDQAdwGRrdvGZMx7hMz+8eKNU2Cxfou
         90h95USoKSULDSZ1pvl759lljG1THuIcc5VPuiwTv8OJNGsjMv6fAVy/Na8bKVyMokdQ
         CZfd/OjbX6YwOVwepKv+YMujPKLwK0gYfTcSf4IS5A75yWoP0iSNgiG3bNv5iV9NmPIH
         wI1w==
X-Forwarded-Encrypted: i=1; AJvYcCWFsC/2LaXKYbNhqD11jSR/qGByfccWchZE+qYQftCrBugBHOWlu9wpMvO2TyNobiq24DCiErI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqvobAlSOVkxZqDXVwK+uJNWD/ggiSMx/Yz4ZH/syFoL07vvJ
	NpJkOIxVfAyQHhAT+JKIqPu26Fxx5AsNIaHxDUb4wZ4b7KGecwiRt6/FKgvjBvF5vFcOOIKMOTm
	5zD3fA9xv5OP/4nUyZPsRiAg25wRLcz0=
X-Gm-Gg: ASbGncv8canbXkGmoEqTdrLDX+qp/MYbncuTYFg5dOFDvGCC70NPkLAeG650dDktWQL
	8EXOW5wSW3TeW+HquZ7QrxGR6dgUvaqNehi1LKddcYpT/TsIMrm+y9PCjg7iqVYrjkKMqU5L+QF
	XHMZNEFYm7BTMFqAWKuHTm4BQ1zShEFgbiSBx0gDfpyAK6zNKALHlLhQcr4Ey2zch4yLUkrSKsS
	QiTcpcjGvtmNIcP92IWxrgoSAsCgAMqT5UjGe/L+peo9Z4Ba0xpzoHnwY9nPzf7ZHA8Fc6Dcpmw
	+bboEa/9p1EEpSS6NH9nCOIruZXhLUVR6VSYaQ==
X-Google-Smtp-Source: AGHT+IHx494bsoHJaju4RengP4iXpGRFmMQLliiMWy2Q89R/cSWBMiB3q+hcgQyoomcv+0z0cS+rAooMlyw+VCTekJU=
X-Received: by 2002:a17:902:f791:b0:297:dfc8:8fd with SMTP id
 d9443c01a7336-297e571236dmr29139155ad.51.1762605083407; Sat, 08 Nov 2025
 04:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQ4ByErmsnAPSHIL@shell.armlinux.org.uk> <E1vHNSG-0000000DkSh-4BIj@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vHNSG-0000000DkSh-4BIj@rmk-PC.armlinux.org.uk>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 8 Nov 2025 13:31:12 +0100
X-Gm-Features: AWmQ_bn_kIDv-pwz4dNwmzBqCanYs2atUFgMMshyNEi0RKuzPdaQ1v4towlIcoM
Message-ID: <CAFBinCBp1x3KWe-5mWoGwFEVxEoSKhTXKYfGgNKS-eDsbW8X+A@mail.gmail.com>
Subject: Re: [PATCH net-next 09/16] net: stmmac: meson8b: use stmmac_get_phy_intf_sel()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"David S. Miller" <davem@davemloft.net>, Emil Renner Berthing <kernel@esmil.dk>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Keguang Zhang <keguang.zhang@gmail.com>, 
	Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Matthias Brugger <matthias.bgg@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Minda Chen <minda.chen@starfivetech.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	netdev@vger.kernel.org, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 3:29=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Use stmmac_get_phy_intf_sel() to decode the PHY interface mode to the
> phy_intf_sel value, validate the result and use that to set the
> control register to select the operating mode for the DWMAC core.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

