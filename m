Return-Path: <netdev+bounces-121279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC1495C85B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EB01F23A65
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EC01465B8;
	Fri, 23 Aug 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf5c1Zmj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29D13D2A4;
	Fri, 23 Aug 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402818; cv=none; b=R+vVF0Ud4XVh8C69TKMAF1SMrvshGfM3qOU1ALanqS1RKjz/l2gTyqezzM0PxeokeOIhlBROgZ0vQuqGmQm5fwK650AA1rFTw3gLpNbAnLC94lBtyhjp2Pw5fy1yXnmpRjPQKxg0ZP1ZhVo9gUkXQhHJQ6RGPz9UckWo3gFW+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402818; c=relaxed/simple;
	bh=/el1uwAgR7BV78bPwYYNMV+u/k0BaGMwcmQ/tt526lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGxMmtpJ0Pf8Ws7kAohAOhKZq1bjXOg4A6me3jcscIKGYi0IxS7J92M+N3XljDoRlGhrH0haRHZEfp4H3kyts6iNntm11wESmAQfxYRbjR1iatE2hFHzARGp5sLmBwRH9G5o8WF66ClCGzCdr9IG0jsytIVdfainFdAmNCO7rbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf5c1Zmj; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e179c28f990so1072617276.0;
        Fri, 23 Aug 2024 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724402815; x=1725007615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVrWaGvyRMJ7X5rgNJvg75h0fK2kthydTvrIXtpH5YY=;
        b=Pf5c1ZmjbSVQWrfqziEhfu4obDnaDnZK3zItpnyAr1QoMrQ8P4wobUCcz5V0UQeQSc
         6ALY9r52JIXD+zTkx7Vp1nuNtIv2M6zGYWEUrosy+hDay0pHojFQxCbKqUKrEsi+ir49
         JWeikJ4FGye0hNs3XWmfE7H9+5PIR4yuHbmb/0XizbcwDUQYZAi/kTEhxjW+msWU67Bc
         YRQrQBp/JbyEzFTxwIVmeRNhIL5eE55IPBL06FSFxnZkfBpDwXftx3MceVtYvx3fJuAo
         yl6gVHcMJygc0zlhpgIH8jBmJCx+CNnW8eW6Z9/XeDpoABm9ww7dr+QMddiNPlukOf0F
         kw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402815; x=1725007615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVrWaGvyRMJ7X5rgNJvg75h0fK2kthydTvrIXtpH5YY=;
        b=LQpBwmOPBwwA9X79eb1MpxDTcQB9O8/+HaiDEDCDWNEjwULBRJjLKPAwkxseYbkyGP
         zbPkWsw9dVyK+ttC/I/pMgU8eqw3OoEis+UZV0VPPdkhEe7k4QbmwxwZnFoP1YRn2gSp
         lXeFsICNgLNN3+X9/caCeXKzR4B2jPZ4yYqUzY0KQVS9ikuMTgz66V1hKhHvjs5cslYR
         Qbb6CzrFIi9KfrXqwfls6fn26vXhoIOcFWiwj72m5vsGIRNI7csGrb/8ZouK727jd+VZ
         INAmQYxbpzCyOh8ILqIqdns/UfFB1r0WwCwUEluSucYZoWvwU3nT1AJCSH8wG+qTvxSE
         rqTA==
X-Forwarded-Encrypted: i=1; AJvYcCWlAodtutO+2Kl4auQGOlIEJRFTwONTzJAdRE8XcjUPNjMjeCMKmTWTsIM3p2jwcUUPMXHn+B+45XyXsY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBB1M7IrU9Em04lOTpA6U0KZC+YKR/O/MMCAPmZKtSpHv1Z1np
	3geY6+FIJoM+ylJeWFmFle8dfwErTNJvq4fVEcvXy9SnYRbwMSgrqOu1dl5brxiYHshJNPEOF6Q
	UzgjV6K9TnVJi/YQxMJimDTrVMWD781S5AM0=
X-Google-Smtp-Source: AGHT+IFJxyrBwLZdQb6O6IsngSPPXvyhHvGCyiepovpER8d/CrtgqPiVhgWtyIoQW3OjUDfqhl2TnP/bxnS/y+qcPmU=
X-Received: by 2002:a05:6902:2e0d:b0:e11:7b16:9482 with SMTP id
 3f1490d57ef6-e17a83cad7dmr1498679276.2.1724402815234; Fri, 23 Aug 2024
 01:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822145336.409867-1-paweldembicki@gmail.com> <3abe172b-cbad-4879-9dbf-9257e736ec6a@lunn.ch>
In-Reply-To: <3abe172b-cbad-4879-9dbf-9257e736ec6a@lunn.ch>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Fri, 23 Aug 2024 10:46:44 +0200
Message-ID: <CAJN1KkzYOYKuFqo4Ew0sURwNTso0op3MWWpGmmgoqRP_sHeXxg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: vitesse: implement MDI-X configuration
 in vsc73xx
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

czw., 22 sie 2024 o 17:58 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> > +static int vsc73xx_mdix_set(struct phy_device *phydev, u8 mdix)
> > +{
> > +     int ret;
> > +     u16 val;
> > +
> > +     val =3D phy_read(phydev, MII_VSC73XX_PHY_BYPASS_CTRL);
> > +
> > +     switch (mdix) {
> > +     case ETH_TP_MDI:
> > +             val |=3D MII_VSC73XX_PBC_FOR_SPD_AUTO_MDIX_DIS |
> > +                    MII_VSC73XX_PBC_PAIR_SWAP_DIS |
> > +                    MII_VSC73XX_PBC_POL_INV_DIS;
> > +             break;
> > +     case ETH_TP_MDI_X:
> > +             /* When MDI-X auto configuration is disabled, is possible
> > +              * to force only MDI mode. Let's use autoconfig for force=
d
> > +              * MDIX mode.
> > +              */
> > +     default:
> > +             val &=3D ~(MII_VSC73XX_PBC_FOR_SPD_AUTO_MDIX_DIS |
>
> This could be a little bit more readable if rather than default: you
> used case ETH_TP_MDI_AUTO: . Then after this code, add a real default:
> which returns -EINVAL,
>

How should I handle ETH_TP_MDI_INVALID? Should I do it like in
marvell.c or rockchip.c, or leave it as the default?

