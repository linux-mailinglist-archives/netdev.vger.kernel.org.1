Return-Path: <netdev+bounces-238896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D91DC60BD8
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B53944E1218
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC10227EA7;
	Sat, 15 Nov 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrG0PVe8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11152CCC0
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763243663; cv=none; b=i1Wwx3pQZ6LmN3J3eiz9f8SEBQGCPVypntgq97gtJzOVxRdKoNSH9/J8WH7JFdhMmBc04fe7YaAC4nB0SpFiWuNdUdY7PVxEmGSxiayoSeDSmRo7OcqDRMpE87qth7JI0bDH9Vq2Culni39boNXorZ37WX7AZQOBpDt1V6tQ4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763243663; c=relaxed/simple;
	bh=h/D+0cPQv0yTtx3AqzqzgEIjlEU+lWJTGeVD+H497GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U93+ceGyxrx6P7Eroq3se6qhLhidXDTUb+GM+WHR5qnOkswx9MtBS/lDxdRa3sjefYnwXd2MxeLvHDXUHPFq1XHv0A5JYZh+TQHlCkfxiYtTOr+Bj7ZPz+D1+Lsolo3o+H4SB2lJPV9MRgn2RCovwn0gxURLw7y3ed9OoZnblvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrG0PVe8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37b97e59520so22403661fa.2
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 13:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763243660; x=1763848460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhiRZGRZUaljPmUDOqzazXcrEsnTyVCYslWVoh4MNLU=;
        b=jrG0PVe8Ui+cmXUZuMEIg8Ly1mW6sMgGcLjMw/qIrlUIdrSU945AOsyrRWxi59Bb/7
         S+zXJVBVSAvWJ8qPvp1Ys8i2mcBtpWDqXQyA098ENsh0mtGsp2E2qmtRaTqCmQFf5Ucd
         W1occdpbNdJS0RnV5zdy7Xr5EVF+cMF/fKT9TjZ56DVqU2w8l2jfQx8FLljTL7t03V8c
         KmmzNmvFB5DYTjE6HW1d17y5uT6fXsjaYxg+Fnp7zQy/b7R4Bav9P+/gkgMWGP5j6Ax0
         LNR8+L9JV94BVMhiwewZcxU5382qb13ahCyFkKR8VFR0aF+vrvpxOX+egZ0jGHGrq9jC
         RV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763243660; x=1763848460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhiRZGRZUaljPmUDOqzazXcrEsnTyVCYslWVoh4MNLU=;
        b=QZ0L0haXXhBCUQrOXy66y6io466k8bH8I9fOGtWlBM87643G0mHvSlOF0I7q5N7K8/
         coKPFqfvZ46nANyHwlpF1Zot1wgYAC3tQV1ur6wijvkIBhGASjKDw10OJmo96gvcRaop
         SyZEsf/DprkGF6DTW2Kc7KWc3w+fSIPyPXj20nWJLGILgh88cRUZvHzuHuN7CZSUU0yQ
         MRKbGEVyvYrpz1z2z7ovZGaEMPaYEukwM2W3dYkRShPQOGPgrA9N5hXlbroZNnOoKB3z
         9mwVVOFJE/N078Fmz2kfuphuXrwEriFbev4QcKXGgGBLVci/4AyRvtKcSZhpyfd6X7as
         AavA==
X-Forwarded-Encrypted: i=1; AJvYcCX+3Dj5o53owIaRb6j6ByI7wXF/9B52gLepULSsKHb44fm5EV6FwAQLyqL+WT2rO+H/WHcaPlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3prtrWWpkRGwXRNR52P2BtZ2wu6/HVq7bBAv5gIlO64rPFVu4
	lIBaEEaHOg9KXBB5oPJTEpnymDDD2UNLJ/DilQ5OiFRgYoTTEwtAr1onCxXGITLH7xm3oNpBKDM
	1maL1gMhlLAYFCl68ze/LWhIrtImeTho=
X-Gm-Gg: ASbGnct4SyxrD6t1PqEcIX72YvoZgYs3ZHV8/Ea8IeAP+kJdYIV0aMippAyTKdosNG+
	KSc67q91hw7+f3DZaE1zq6Mm8KcTkyKCy7HwIJR9OGoJRXNqq731XePxsJ0CAj6yWoHGzPE4jSC
	IJe8/bBCV/ChKsRQuJk7W8f0ccJMiY/m0sgZ1mzrddOSjdHszCpq8R6FgZa9t+QzQ17E6ROSKNW
	BJyFpUa0TdbCRLAIyq/DBp6X6OZWJZ1M0WW7KW0YVykIEgjwRtHTdktPbFqe5Imh+QGSH94UN/G
	g3H7k3Km9JJHhq2TI5sDxvTamyzWS5QRhhnD6U93TgJz9XEl
X-Google-Smtp-Source: AGHT+IFDk8MTG35SUzb3bRIXkilk8VDC1Q8vyF7dJu+iCyupdmY4oNMuD63lty9E8ejIsVZfJw8GJVpeTGhUKD1jNog=
X-Received: by 2002:a05:6512:3b98:b0:594:27c6:9ea with SMTP id
 2adb3069b0e04-5958423ef90mr2168586e87.35.1763243659637; Sat, 15 Nov 2025
 13:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch> <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
 <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com> <CAOMZO5CbNEspuYTUVfMysNkzzMXgTZaRxCTKSXfT0=WmoK=i5Q@mail.gmail.com>
 <7082e2d0-a5a9-4b00-950f-dc513975af1c@gmail.com>
In-Reply-To: <7082e2d0-a5a9-4b00-950f-dc513975af1c@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 15 Nov 2025 18:54:08 -0300
X-Gm-Features: AWmQ_bkylFEux-3bKEM8kjLfKsf51uvRa6BzdS9tZrxp84P96-tFZyvYObMCFJ0
Message-ID: <CAOMZO5CLvDMgxi+VUVgiTy=TsK75QMYrTYZDEOzY4Y7eN=CRMw@mail.gmail.com>
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on i.MX6Q
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, edumazet <edumazet@google.com>, 
	netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 6:26=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:

> smsc_phy_reset() does two things:
> 1. set PHY to "all capable" mode if in power-down
> 2. genphy_soft_reset()
>
> Again, as the genphy driver works fine for you, both parts should be opti=
onal.
> Check with part is causing the packet loss.

It is the genphy_soft_reset() that causes the packet loss.

If I comment it out like this, there is no packet loss:

--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -149,8 +149,7 @@ static int smsc_phy_reset(struct phy_device *phydev)
                phy_write(phydev, MII_LAN83C185_SPECIAL_MODES, rc);
        }

-       /* reset the phy */
-       return genphy_soft_reset(phydev);
+       return 0
 }

