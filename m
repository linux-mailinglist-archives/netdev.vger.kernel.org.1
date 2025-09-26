Return-Path: <netdev+bounces-226597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E66F7BA286F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 08:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26311C2295F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 06:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1526725C70C;
	Fri, 26 Sep 2025 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhDlaekI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EEB3B2A0
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758868264; cv=none; b=OQXa+HW7VVu7P42qKkPw98jJMj4WCk/DqNVq1jDa7r/GTxLWbpuL5Bu41wG9IbiMH3akC1CzXs9UYFX4h2Aj9pLCrmctElfzC5Am68jlDH7uS6ADgRdS1f6Z9K9waQe6LDrjpXQSbs2X8S6PVPOkVTI9GQanxrvzhQxaFTj48Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758868264; c=relaxed/simple;
	bh=pT4D4Sn35YNV1NvLk0Gg5WRv2gza4yQM0mzRPkxHlLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc+ifuWjj4KlhTEKEkrXCrz8ZmAVCE3oUgFi8JgAILrxEeM5DltT+3kED9exPyY/rXSRmjcSNCiNerSnxjWWPSHryqd44jyjz6Jk95iJWyH4rdGMifYw1i0dFU2DloGXkRvvs9QUI05AgDzh+crxNVFki7WVpedYlxnPPUFUscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhDlaekI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27d2c35c459so15307145ad.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 23:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758868262; x=1759473062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC3AeUD+OlSR85O126Z8E0KX/IkQ5ae4Bq/IbfDT0B0=;
        b=XhDlaekIeF1dGVe8P3FQwV61t1LUrlhY5RWSnLxiNgWf2nfdQpbgPc4hgoRzWV3K1k
         SYWF5IWgrveXaWzsL/DeB9PQudjpFJ+kKYlUiplyU8Cg0mE/oBblP74Z4UCp0Qnf18SG
         nPkA5gw0wVzS368sH6uXpGVLvxprEsTL+2aCLcBhr3oYaXZmuQzx0WzY0ocOsON13KhW
         xiF496hodoN6y0UGOPoMPPOGNHykiytQ2S8xuJ4RQDEy43ptWKRDXoCsbKaLXuu7PZgS
         nNdquWcLBK9HT4z/im3r8eqNro0CYaif5O235ZM/56L1MAJFZBTl/ZCEXvfw/FeQiE7j
         c/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758868262; x=1759473062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EC3AeUD+OlSR85O126Z8E0KX/IkQ5ae4Bq/IbfDT0B0=;
        b=Km8Ryc9WLCFNVWrMHqg8U8Z10jwIs402ErssPUIx63VHCQuLSryGiaDsPgwizjGNog
         vJFgrtjIS16c+8tYvjR+kUDmNC9k76Rufifyi4Xqe2PmfB3/VX6fT3pm4Uk5YsQD/c09
         dSCdBa126LKBMQyGLx78LwAQHLzTOT0Dt6HPoJW/7EkOA5ETLuVOsEYGtU03mcwF2vy1
         idgSFAddZ1fKsoQKkkKIzsii2L9k72KGa2QTo3Gxa27U+MALQm+GEkAR+1fffzDgjbbR
         RPJz+vot3x1D7bkLXs9nVW9exJIkUX2J5ObHHrMp6hQxG2vM5poUgjKZN4CoJB9neNn6
         kBaw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0ht6q7kc4jdF9tXp+cxkECuPZ7+UThZLa4oO1bxYv5B/1+m6DgZ+hOZxagogOJiK+1USFWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbW5cXLrMHK071V+Ip35ZeyP3WGIYw/6W6vVCpprYqkaeEJBA5
	zIgQc/lVISfYHDZD8nyXOxJuUfdtOt53xXTPG9ej2YXUBNzUl+lIlQ+gWm3cPhrQAWgjMzPDUGG
	4jSUKABemyFiDn4dMKXjB8Tud6jAVLJo=
X-Gm-Gg: ASbGncuAxpi4p4vQaOrFlAwElhL8b4lcpFMpnlCEEYIwoqeYEwwPTQCen+nkBwzHmMz
	5Pyd8f4f7Tn9SAYieD0X0LQjI7jWuIx/hL31mlD5ndipSVWNMQ4bnyO3iaz8SvdPOL0QJDmvI8H
	llAqKTWku/HQ5fCy2kTOWPme/EBR48mRJdVcDHhxPVn+r8IfKnbX8fXfRzQnYboc9DKk3gYB9yQ
	HYtZnQ6Dn7cFSd/nD6q
X-Google-Smtp-Source: AGHT+IHOQqsbHKaoRWWyK8jo8RXNW/NKUILVQhNWFEFGhfVRUvbzyWKNu5nCPhJOFCZcotGOXjHOERG0NyOWk5Wwvpk=
X-Received: by 2002:a17:902:e5cf:b0:24b:164d:4e61 with SMTP id
 d9443c01a7336-27ed49d0775mr63385725ad.13.1758868261660; Thu, 25 Sep 2025
 23:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922131148.1917856-1-mmyangfl@gmail.com> <20250922131148.1917856-3-mmyangfl@gmail.com>
 <aNQvW54sk3EzmoJp@shell.armlinux.org.uk> <fe6a4073-eed0-499d-89ee-04559967b420@lunn.ch>
 <aNREByX9-8VtbH0n@shell.armlinux.org.uk>
In-Reply-To: <aNREByX9-8VtbH0n@shell.armlinux.org.uk>
From: Yangfl <mmyangfl@gmail.com>
Date: Fri, 26 Sep 2025 14:30:25 +0800
X-Gm-Features: AS18NWB6pDKhReLM4IsYwOxVnFFQ1lMaREgEQ7ywwv9WWvhB3USv5GmmOErCI0I
Message-ID: <CAAXyoMPmwvxsk0vMD5aUvx9ajbeAENtengzUgBteV_CFJoqXWg@mail.gmail.com>
Subject: Re: [PATCH net-next v11 2/5] net: phy: introduce PHY_INTERFACE_MODE_REVSGMII
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:18=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Sep 24, 2025 at 08:41:06PM +0200, Andrew Lunn wrote:
> > In theory, {R}GMII does have inband signalling, but it is pretty much
> > never used. REV for GMII could thus indicate what role the device is
> > playing in this in-band signalling?
>
> For RGMII, as you say, the in-band signalling is pretty much never used.
> The stmmac code as it stands today does have support for using it, but
> the code has been broken for longer than six years:
>
> 1. the longest historical breakage, it's conditional on the hardware
>    reporting that it has a PCS integrated into the design, but a PCS
>    won't be integrated into the design for RGMII-only cases.
>
> 2. even if (1) was fixed, that would result in the driver manipulating
>    the netif carrier state from interrupt context, always beating
>    phylink's resolve worker, meaning that mac_link_(down|up) never get
>    called. This results in no traffic flow and a non-functional
>    interface.
>
> So, maybe we should just ignore the RGMII in-band signalling until
> someone pops up with a hard and fast requirement for it.
>
> > For any SERDES based links likes like SGMII, 1000Base-X and above,
> > clocking is part of the SERDES, so symmetrical. There clearly is
> > inband signalling, mostly, when it is not broken because of
> > overclocked SGMII. But we have never needed to specify what role each
> > end needs to play.
>
> 100base-X is intentionally symmetric, and designed for:
>
>         MAC----PCS---- some kind of link ----PCS----MAC
>
> where "some kind of link" is fibre or copper. There is no reverse mode
> possible there, because "reverse" is just the same as "normal".
>
> For SGMII though, it's a different matter. The PHY-like end transmits
> the link configuration. The MAC-like end receives the link
> configuration and configures itself to it - and never sends a link
> configuration back.
>
> So, the formats of the in-band tx_config_reg[15:0] are different
> depending on the role each end is in.
>
> In order for a SGMII link with in-band signalling to work, one end
> has to assume the MAC-like role and the other a PHY-like role.
>
> PHY_INTERFACE_MODE_SGMII generally means that the MAC is acting in a
> MAC-like role. However, stmmac had the intention (but broken) idea
> that setting the DT snps,ps-speed property would configure it into a
> PHY-like role. It almost does... but instead of setting the "transmit
> configuration" (TC) bit, someone typo'd and instead set the "transmit
> enable" (TE) bit. So no one has actually had their stmmac-based
> device operating in a PHY-like role, even if they _thought_ it was!
>
> > > However, stmmac hardware supports "reverse" mode for more than just
> > > SGMII, also RGMII and SMII.
> >
> > How does the databook describe reverse SGMII? How does it differ from
> > SGMII?
>
> It doesn't describe "reverse SGMII". Instead, it describes:
>
> 1. The TC bit in the MAC configuration register, which makes the block
>    transmit the speed and duplex from the MAC configuration register
>    over RGMII, SGMII or SMII links (only, not 1000base-X.)
>
> 2. The SGMIIRAL bit in the PCS control register, which switches where
>    the SGMII rate adapter layer takes its speed configuration from -
>    either the incoming in-band tx_config_reg[15:0] word, or from the
>    MAC configuration register. It is explicitly stated for this bit
>    that it is for back-to-back MAC links, and as it's specific to
>    SGMII, that means a back-to-back SGMII MAC link.
>
> Set both these bits while the MAC is configured for SGMII mode, and
> you have a stmmac MAC which immitates a SGMII PHY as far as the
> in-band tx_config_reg[15:0] word is concerned.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

So any conclusion? Should I go on with REV*MII, or wait for (or write
it myself) reverse-mode flag?

