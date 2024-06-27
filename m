Return-Path: <netdev+bounces-107240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD8291A669
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD3A281579
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA44715382C;
	Thu, 27 Jun 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tagTi9za"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C01304A3
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490701; cv=none; b=m2HDuUuoB9FlW5WzHTWLgYMxbOshIQXqkRPTOk8QJOI+C3TgA+25ki5tfyxYRhr5QAfkX0rlCW+3OfQSYkXtyBk0Y3U3QcJyIaoCTJGTRTMRE/oJD/kc77u9QQveC29sbDyPIHvVaxndCqsgk5AruCAz9DIzTlfI4IWe7gz/F6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490701; c=relaxed/simple;
	bh=Fm8Lc5p1A5H70/b2jqUsL4oBjkyBytvMJYfYPNEtcv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWSWDDoZUyuV2ejzDfiIgg7lxsJPtIEfnSj3tic/+LtFKRZubDTP4WqGGNeTKnOZSOdgU0U05TG3USALKM9EnRLgJyZrWZhthQW2j0zHgDija2KSlvEJykhrp8O87z0ZlCkLurUqAHnyp6Ykiv96s1AisvKvkmtBiPiWbN0d6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tagTi9za; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec002caeb3so100041261fa.2
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 05:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719490698; x=1720095498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx0CgMn6jluyyz8Lb+06cQAt1KaCnUk56+5xBtg2eeo=;
        b=tagTi9za7JNHZkzf+w7VHt5HNGxF6kDkdmePl08/AKsc17tV+aLWI+k1xB7tSivh9Q
         MbOR70IZrurqSsBg76suzrAlbntdJSUvTqYquWZNngpakEh2tkJFWzpvAG0mA2+wpq/N
         cEKW38jjpK79DWyrrSZkRjL1458P3YT78B4ch0DKxEgHI1qyGhDaga4UaluSME1rG/FJ
         D4p5+hyu/lRFHp3LazSY/p8DKwjH0IkxX1Ttb5UAhTkDnHA0hPCTQjLs/WvRfLzxg7CK
         FP6IKArFwmvf8Yg5tpAuEP0yaKKaOh8Jsiu1i+JtupHwYAERbQH26QIOA1R/prldE3TV
         9U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719490698; x=1720095498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wx0CgMn6jluyyz8Lb+06cQAt1KaCnUk56+5xBtg2eeo=;
        b=nxKPjPelbtPWjQFqwxWkwL2oWIHovUwNUtQI6P6Uk2l/PhQR1rU7uAkmT1mcyi/SxK
         Bd2oiwYtltMsxD/UE628pzWcmwc1I4mVMltJje5K01rp6YSY9HUVa74xCBQxcZu5dq1B
         eiUqnvhPEp1J7BGlVLFTFS0QMx1OTbBQQUV6GKX6jEfamAdq+cF+1jhHN+kbL3WxVoLH
         0RUCWndaOn8/wyVyA1X4zvB1J7j69HFuhtnTmnKo75LkAaanC8zpKHBo8taIqxOOp2ib
         AOhg0QswWX4/o1xsx5eeIbOwQIKXpS08VNyPpi/nWjhRxSB5sj8Z4J31aDffRjOXKXeD
         1eqA==
X-Forwarded-Encrypted: i=1; AJvYcCX1B+qbhYpjTaEG53k1CH9uIGYsWNCU10LliObmkrK7v4aPhjMS4jUEDKOmSHl+wSoXKkdhgvQuFIRgjQ3J1sdNr1pduoZE
X-Gm-Message-State: AOJu0YxMaVEzhSMkTlApkRMAgbuv1VzGWQFIyh9q/mlTj8zQLoeC4H1C
	ITeQY2YE/B9rc778F28zdORaCo3GG6GTxCazzuU48s205FY81x9Go5WVG6xOG6UYMG0zbDhldwM
	/UWcIJJgYGXBsE4O3qxR7HWUlFU3qvSffgFY8Wg==
X-Google-Smtp-Source: AGHT+IFoXRdB/Inu8lFN9nuGotr9Qb3Ng9uwIeH8T3OCKFP0OTUnuvV1f/leNMSuHwCZB1jD8YWlv09Pw3eh4/iuVdY=
X-Received: by 2002:a2e:7207:0:b0:2eb:f7a4:7289 with SMTP id
 38308e7fff4ca-2ec579ffb0fmr79246121fa.51.1719490698327; Thu, 27 Jun 2024
 05:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627113018.25083-1-brgl@bgdev.pl> <20240627113018.25083-4-brgl@bgdev.pl>
 <Zn1WgpC58nbYfLVF@shell.armlinux.org.uk>
In-Reply-To: <Zn1WgpC58nbYfLVF@shell.armlinux.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 27 Jun 2024 14:18:06 +0200
Message-ID: <CAMRc=Mdn6gXhgoWwpztXDKzix_+Ad1_rNUWP7O6HDyLXAJev6Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: aquantia: add support for aqr115c
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:09=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jun 27, 2024 at 01:30:17PM +0200, Bartosz Golaszewski wrote:
> > +static int aqr115c_config_init(struct phy_device *phydev)
> > +{
> > +     /* Check that the PHY interface type is compatible */
> > +     if (phydev->interface !=3D PHY_INTERFACE_MODE_SGMII &&
> > +         phydev->interface !=3D PHY_INTERFACE_MODE_2500BASEX)
> > +             return -ENODEV;
> > +
> > +     phy_set_max_speed(phydev, SPEED_2500);
>
> Please can you explain why this is necessary? Does the PHY report that
> it incorrectly supports faster speeds than 2500base-X ?
>
> If phylib is incorrectly detecting the PHYs features, then this should
> be corrected via the .get_features method, not in the .config_init
> method.
>
> (The same should be true of the other Aquantia PHYs.)
>
> Note that phy_set_max_speed() is documented as:
>
>  * The PHY might be more capable than the MAC. For example a Fast Etherne=
t
>  * is connected to a 1G PHY. This function allows the MAC to indicate its
>  * maximum speed, and so limit what the PHY will advertise.
>

Well I should have RTFM. You're right, I'll drop it.

Bart

> Aquantia seems to be the only PHY driver that calls this function.
>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

