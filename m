Return-Path: <netdev+bounces-237496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31EBC4C75F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD944188748C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEFD253932;
	Tue, 11 Nov 2025 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjSEX8+B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE2F757EA
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851060; cv=none; b=VBjTXwr2zA0gZRqHKnsAwI8tykGOs5QTFofs3btdnDvcTYxrOLCZaxN11yQ6zxieeAAjtCBGyi+pnO0MrKubA8b2U0EnYG7Htx98ZEny59Rq8LEpSss6JCbzR93IoTFc61aB1ffWDtJEsUpu9DOICRhy5a0K7vLCOyPeO+HdwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851060; c=relaxed/simple;
	bh=0YRsrI6lk/jpE/TQxXFHe1uone6HcJRymeuTM22KPDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrRzxh5t/Vq2l+bJkrguM8lPW0HLuxX75JxqojuazTIeT0BIhObD4/HuD21Jnvcc/3fjKxCIWCNzvDZHX4HCNDT8lZTdH6ia7I1ZVc90DhZXuAPG/RZfo5uxsIfIjfE0leqq4ujtF9piYYueXR0lAKX7Zbf6CGzXNUtrIs+qlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjSEX8+B; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so1027522f8f.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 00:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762851057; x=1763455857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AFOtj9BBWikbvrk76I+BOfuLhZBC12T4UuFnubfgtU=;
        b=VjSEX8+Bau2Yqc5otfkaZpmWy+ce/jsNVbJnZj6sY4wpQ/xq83Q5Iu3wDuoUGxbCWX
         rHKBgVT08CtErkBqV+fIvf4d/JYvj3pDyAbltVr+STZ/HgWF6u4LTHx9yfg+HXE2ig+x
         c+fTJA3eFrZpUgphQWqa6o3FwpKKMlGmwKliaKi15QzlC7jiitUSXwRy13x5druPLLrs
         nGlBETdxjtdcBUUrxewtKAFdignBI+oz2B00rBTSpJ1kV4WSIDPWCbYl5ZfpDLYrFvVw
         NgEJ6HfeAEF9kiTAkYuYkSwsK19FogYlgdbNMVyV/Z34ZQRyiOCsl1KTRHmsovFi7mT1
         vFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762851057; x=1763455857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4AFOtj9BBWikbvrk76I+BOfuLhZBC12T4UuFnubfgtU=;
        b=KMWYVB98ePBqExwHS5XGKOUPZjTgDyq8l2r1gxVFQCzoN151quf6ZXYbtFpxg/mt4Z
         Hafwn+8u8sKfNaLQbgc7dYQr+JbKE25GWRlIfzwjISsgpm3GcG2gahTHg+DxKyinLJVp
         kaowWF+5HkyJfRH6p1fM5HE5emEJRDWDvxx5WS4QGJzhaRGS5ro7WOwAJeseHQkUQoX5
         mI7GyWqqqi/6Tkt3a2k4X4yTXtfu3jfULaPL/ITI5drdfSR3tEqRqpU2lIjgYQ0FF0Zc
         vNVc+IGRYikTE86gf3Wrii7jX4P1QPCTSQFm6m8YFPXka2m/nd+6tM9eZ3GV7NNDDwHE
         XK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVe2cxw1bcvkBoWAjxHAKdK1IJ6+yWDpMI4KkQUNVAvxgrHSZU+8RvUSCq6xyH3IJFrRl9RnxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+pyIlxtrjdtixrdTIbJDiYEOgG3ReCpFXEdMegofr5bNuWxbF
	g3/3XrLIwuwcx9Kfm7vx8+tssXwXOm7UE4yeYXwoM2XVB+djBgVOuUM4KQ66rDi2Q2dbYsBq1Gj
	4P+9x/6z6NJIv1b6iJUZVnZu+uvhDRqk=
X-Gm-Gg: ASbGnctj/Ql7e/Sn+2EmwkOVz3eO+woK+cafRdgVcFbHCdygNp3YxhZT1gaHJPmKmIz
	Yu8tCyFmJDVniyhK2XVxKQJfmBv8inW9iSwxTkOh3lq7Ljiy/io06rdJY0Ef2kV0Tk/6fL3u0o5
	c0WwjkpwbKthPqjFRcv6tNFV8DRP094avEfQNMBTIsK3O2K42GlUWyFdHDBi0/jpLgpVc1QAT7X
	0QTeuTZzxVTZPFG9MfTZcvvX7YdlA3T6QPWCnKoo+DddibufbiXADePtq8M+g==
X-Google-Smtp-Source: AGHT+IE+da+1r+jgi0DXyIDNB8MGdp+Nzp4Lqz4ylhf8uYWKyvAt57QPmxdapcBrV4Tm8KD8ARq3BHLCSjO12/WC1Hc=
X-Received: by 2002:adf:9d83:0:b0:42b:3083:55a2 with SMTP id
 ffacd0b85a97d-42b308356e2mr6996138f8f.63.1762851057106; Tue, 11 Nov 2025
 00:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107201232.282152-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251107201232.282152-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <ec28d950-f7ef-4708-88aa-58c2b9b0b92a@lunn.ch>
In-Reply-To: <ec28d950-f7ef-4708-88aa-58c2b9b0b92a@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 11 Nov 2025 08:50:31 +0000
X-Gm-Features: AWmQ_blqCCNNMwhN5TO78-IZrSmoQkRYNb4dIksXog2xpI2Up-_qLjDEx3kShQY
Message-ID: <CA+V-a8uLC5OJ7g1MbJVcJeCS9wPVYDoCDUW7i8keUftQLkmmLg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: phy: mscc: Consolidate probe
 functions into a common helper
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thank you for the review.


On Tue, Nov 11, 2025 at 2:50=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> diff(1) has not made this easy...
>
I agree, --diff-algorithm=3Dpatience option for format-patch gives a
better result. I'll send a v3 with this option.

> > +static int vsc85xx_probe_common(struct phy_device *phydev,
> > +                             const struct vsc85xx_probe_config *cfg,
> > +                             const u32 *default_led_mode)
> > +     int ret;
>
> > +     /* Check rate magic if needed (only for non-package PHYs) */
> > +     if (cfg->check_rate_magic) {
> > +             ret =3D vsc85xx_edge_rate_magic_get(phydev);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> >
> >       vsc8531 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP=
_KERNEL);
> >       if (!vsc8531)
> >               return -ENOMEM;
>
> > +     /* Store rate magic if it was checked */
> > +     if (cfg->check_rate_magic)
> > +             vsc8531->rate_magic =3D ret;
>
>
> I think we end up with something like the above?
>
> I would move the vsc85xx_edge_rate_magic_get() after kzalloc() just to
> keep it all together.
>
Ok, I will group that under single if.

Cheers,
Prabhakar

