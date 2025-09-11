Return-Path: <netdev+bounces-222255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18790B53B46
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A41A1CC33D3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F6D3570B6;
	Thu, 11 Sep 2025 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLfIzDYC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FF21C17D
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614690; cv=none; b=Bao2QMI85MgGkgcI6EZ+JLN3MfhekfqRCdnVfVrTU1f+rqG2YUj0XTD9paRo2Ghwr5jsxRKAtWaWZBsl3j1oGZTH7zQxwq3Cug9rAP7Ap4vBHsAuEv3M8/PuQqYuH9ADC2oeBvqE/pOkwPc4cen4c+o9rFIZc6F/jJvf1b8J46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614690; c=relaxed/simple;
	bh=clA8GqiEaZLpxSps/Zg9+uXbFOxSOUyl+6EIrGzL37g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiJP2fXkdRQWGddupsbVTJ+mGKKd6Ht6SkHRxNxvXM29h78aKDvMfkW55GL9Mt0UnSSDWcXbCWwKKTc2aTOOvaZX8GhP8qp2wb3TzcOW2R6X4g0EbioE71HyzUhBdhubPrYgJifgQTQIWVjJ42XqFAl5gCTy2WuiLF18/r8K2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLfIzDYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03109C4CEF5
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757614690;
	bh=clA8GqiEaZLpxSps/Zg9+uXbFOxSOUyl+6EIrGzL37g=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=QLfIzDYCHc0/UNmTxImRu5nZHNoGCtg5/JZmaRjEOnoKDCf3RLPNrxMTvHsBDzTqp
	 BVCYw0Yf15yTITpxUrhGNq6uiB8uIpZnuUBoIHTYQ3k8VgYxIvT/gZ0UW5aCS96Zv4
	 lKHsAsgVa7Hh8yO8oKxyekmV1cK1niIt6gZzgYU9tWbIpevjl2fUF5UxWBqiXMbrxP
	 CGpCtxfmeQIOi6F6Nl6sIeBYPwRID+E1Ya2Embdk8AaFxaLylcLD46Me15Re57e6xI
	 WIjC79qlRk/xHIzDFsKMHDNsH5eU5uStSYF9Zn3YHMBOjfzrKRkRo0D97+JMF/k1xG
	 BByAcFeZ22png==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-336b071e7e5so8614651fa.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 11:18:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVajMAcAl1PUaSNh2g4D6ZXGTDgNqq4L2emFtjGMfH/lIgPwsGtS/MVv0KzwMObewI+3j/jntk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGURtuH2QtQ24IzWL5nsCRsFzypQuUkbslN3gjCRoFtHuxx3Lk
	Dp6jQvQM/0LmbI1fLkFpWkVYt/PKd7hvkZlFcvIc1YuRxf1n9ZQUtmc3TgdX+OZuC/acg0ikChM
	UmUunSiBlkQUHSJZKdgwKYJj/KLKNSBU=
X-Google-Smtp-Source: AGHT+IFNhBqlOYMX7VhHL/3/WsyBugQCqv4OR+B6SohRHQQkUzEv33t/qS3NjuPROvGHTdFWqUdjtxSUm5WWLxfziaM=
X-Received: by 2002:a05:651c:4386:20b0:338:1ce5:4034 with SMTP id
 38308e7fff4ca-3513d96a5femr123181fa.32.1757614688354; Thu, 11 Sep 2025
 11:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908181059.1785605-1-wens@kernel.org> <20250908181059.1785605-3-wens@kernel.org>
 <aMMQSR7yYBQkY4CI@shell.armlinux.org.uk>
In-Reply-To: <aMMQSR7yYBQkY4CI@shell.armlinux.org.uk>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 12 Sep 2025 02:17:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v64n_eMBiUaT1S=V6v4Bqv5hLP8vP3=20sp4w4Fxh7RcOQ@mail.gmail.com>
X-Gm-Features: Ac12FXyLWsyObIH64arQzyilGb9hj5BcnDeSxUoNsS-pX-JbEZMJGsbKHCxIoyA
Message-ID: <CAGb2v64n_eMBiUaT1S=V6v4Bqv5hLP8vP3=20sp4w4Fxh7RcOQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/10] net: stmmac: Add support for Allwinner
 A523 GMAC200
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 2:09=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> I drafted this but never sent it and can't remember why, but it's
> relevant for v5 that you recently posted. Same concern with v5.
>
> On Tue, Sep 09, 2025 at 02:10:51AM +0800, Chen-Yu Tsai wrote:
> > +     switch (plat->mac_interface) {
> > +     case PHY_INTERFACE_MODE_MII:
> > +             /* default */
> > +             break;
> > +     case PHY_INTERFACE_MODE_RGMII:
> > +     case PHY_INTERFACE_MODE_RGMII_ID:
> > +     case PHY_INTERFACE_MODE_RGMII_RXID:
> > +     case PHY_INTERFACE_MODE_RGMII_TXID:
> > +             reg |=3D SYSCON_EPIT | SYSCON_ETCS_INT_GMII;
> > +             break;
> > +     case PHY_INTERFACE_MODE_RMII:
> > +             reg |=3D SYSCON_RMII_EN;
> > +             break;
> > +     default:
> > +             return dev_err_probe(dev, -EINVAL, "Unsupported interface=
 mode: %s",
> > +                                  phy_modes(plat->mac_interface));
>
> I'm guessing that there's no way that plat->phy_interface !=3D
> plat->mac_interface on this platform? If so, please use
> plat->phy_interface here.

Makes sense. Looking at stmmac_platform.c, for us mac_interface only comes
from phy_interface.

I'll wait a day before sending yet another version.

ChenYu

