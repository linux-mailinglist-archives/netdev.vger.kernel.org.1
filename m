Return-Path: <netdev+bounces-227428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F42ABAF059
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 04:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55AD1C2C38
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 02:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A60279DB5;
	Wed,  1 Oct 2025 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttRgAU+r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB74279787
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759286662; cv=none; b=Ca0HgIarvZgu1yLF6KJfwXQYcYDY83LUNPZe5D4bq22HCnLwzK/udkAHcah8WJHEBT7Ep40wYCDv2gPzOLQroiS4gRuQ2iJ7eTxHqfCy98p4KYrQriKQo9GwDua1ap2BDUUSjbFLCtv3s4Mn0fO5d6Ph8R1vHJkGn5TzXxFCFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759286662; c=relaxed/simple;
	bh=k91NTUDhUssUji9MJhdmtkiC7VaqJjlsTCOYLX42i1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ0n6Je6BHUvOj51FM1dAqTM8XEx4gPFgjk2z3IJQyxWQ31pxtui6geGPhjnXGbCkbE+hDSLLhgnkrzUlLyO+DRnGWI43+5S5zOEs7sS7Qgw9BiNRjrg6Yoq6uCZMrhqiO4U7iVIcGiFT407e/Od7gxKVCwEkP7ffx3BLrX5g3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttRgAU+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21269C113D0
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 02:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759286662;
	bh=k91NTUDhUssUji9MJhdmtkiC7VaqJjlsTCOYLX42i1g=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=ttRgAU+re1QfOgTUsJYEGBkaY5sJkurfUuoKPafm22hee4mBvUsfCz8+lnPzgv8d4
	 ZOdgnV8fba3mPfHIywenzEHUDYZIP6vODhYrMcHJhSLdDPE2HjSFGBcgL9m1yi7LmE
	 W7n+1yOtllzOEImsPbhBak+kD93G4zlgR7UkMNidvOgQcMplPmuKroueK3CHorgKyn
	 CtjDLwmqqEmAxVu1+9/A4A9BrY1j+7n9xbmw+OyXSKiMcP4Dv6vu7kN9MibVjJsSje
	 TSyEQyAq1nHm7QtDoRmOMwnpTAefVibRt4KoP7xFveey6CHlXTPwpNO4u0bMThDA1S
	 sTMaZgwlFjwDA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-368348d30e0so64916901fa.1
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 19:44:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXth52JlOKhRD56CPuo+ufIv+nH5OK8q63P+x/TZO0fJic6z+ZuCz+tE/wS4T0G3k0Z6eOEOeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa9SLziFDnadoxpnmhyQCGj0Xtn4DSAT5Cr9uS+Sdjb+fHkRkw
	oBvVTE2tOlgMkQxiEPzVaRnXCnrE1RkRADNuUVgOsA+e+aAGKP2G77bltNmNkTZkH0XB+ANB9eM
	jyAfOm6Y2F1QclD8g2HRvCUSshDM58RE=
X-Google-Smtp-Source: AGHT+IFQFAiOMKqVsvDwjwivvtKNdu8wmiPuFmG09MeyicmCKH2vmN2UpLtpz/sWXcpxHK2OBBrDx4wW/jvYc7IHYT4=
X-Received: by 2002:a2e:b8c6:0:b0:364:45a:5159 with SMTP id
 38308e7fff4ca-373a745e30fmr5133711fa.30.1759286660527; Tue, 30 Sep 2025
 19:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925191600.3306595-1-wens@kernel.org> <20250925191600.3306595-3-wens@kernel.org>
 <20250929180804.3bd18dd9@kernel.org> <20250930172022.3a6dd03e@kernel.org>
In-Reply-To: <20250930172022.3a6dd03e@kernel.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 1 Oct 2025 10:44:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v66AKNyV0YegdnZPOV+bh6dNU9ecmtKRqw4HnBO+ZCrBDA@mail.gmail.com>
X-Gm-Features: AS18NWA7fKCmJOgwyIEYi5Cp05qNoNNJdcUopK8PxdgcLYDSihGbZiKbNoeO0vw
Message-ID: <CAGb2v66AKNyV0YegdnZPOV+bh6dNU9ecmtKRqw4HnBO+ZCrBDA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/2] net: stmmac: Add support for Allwinner
 A523 GMAC200
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andre Przywara <andre.przywara@arm.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 29 Sep 2025 18:08:04 -0700 Jakub Kicinski wrote:
> > On Fri, 26 Sep 2025 03:15:59 +0800 Chen-Yu Tsai wrote:
> > > The Allwinner A523 SoC family has a second Ethernet controller, calle=
d
> > > the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 f=
or
> > > numbering. This controller, according to BSP sources, is fully
> > > compatible with a slightly newer version of the Synopsys DWMAC core.
> > > The glue layer around the controller is the same as found around olde=
r
> > > DWMAC cores on Allwinner SoCs. The only slight difference is that sin=
ce
> > > this is the second controller on the SoC, the register for the clock
> > > delay controls is at a different offset. Last, the integration includ=
es
> > > a dedicated clock gate for the memory bus and the whole thing is put =
in
> > > a separately controllable power domain.
> >
> > Hi Andrew, does this look good ?
> >
> > thread: https://lore.kernel.org/20250925191600.3306595-3-wens@kernel.or=
g
>
> Adding Heiner and Russell, in case Andrew is AFK.
>
> We need an ack from PHY maintainers, the patch seems to be setting
> delays regardless of the exact RMII mode. I don't know these things..

AFAIK the delays only apply to the RGMII signal path, i.e. they are no-op
for RMII. Also, the delays are unrelated to the 2ns delay required by RGMII=
.
These delays are more for tweaking minute signal length differences.

ChenYu

