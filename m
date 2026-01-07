Return-Path: <netdev+bounces-247671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F07CFD243
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA9FE3047199
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240172E8882;
	Wed,  7 Jan 2026 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1+qLOGb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844E2DEA67
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781077; cv=none; b=I22v9GUgF8CK4g+KzxxmsdzTq/+1TxberQI8a6ErvWFMKmWwfoiRDP+N7mONUd/oYfNCSKcTLFYYVbY0v1qSS+Wo0zidPodxjtJ7g4525WwdW/N4qiRi+5hlafw2DhOqcdbh5+Luh0xwvonctdQ25DK4tKZuqwU20SzNowCVFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781077; c=relaxed/simple;
	bh=sZ3mYpTbv/XotPCF4CdZdQgefByrsCZvWPwwcFuFdu8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BlNYTq4/NN/0X6IfFG2JPMoZSq3Pt8ZPNWAUZw1UdWpcgbQc8t1KNBCg65Mn/Q1R2pJz8XFY9zgyX82uk5Fejp1y8Ns3Ilo8gOQgbu1bbZtzY+pNqR2kOQeOw3Seo/ZU46MqECRPhho7xLzpHUFNytsNdhMbCF+q2BCTIbz0d/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1+qLOGb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4327555464cso1046328f8f.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 02:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767781074; x=1768385874; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zz5VqpciYzlzrDKhkNf3p0wOlTe+spDWVku/imh0wW8=;
        b=X1+qLOGbt8H+g5qDNZHBIy5tvYG6wB4JoYWcV87piCyg0xaFyFq5Cjp9HmMOzAcxr9
         Vamw4onaXp0qIxWm65AHgC2wbfi9h+HRGuBZ4kmnTcwf4CF6ydHJ1Xsysd8zX34hxO4w
         h5YFR6c/qoZEfwq55dHv4JM4GnztZIPPt8aszg4V1BmxsNOKVa+beYRDylNWv04pjTwJ
         vRYxg/aBVaZnNfMkXqteBL0GzinOJuch267whNRTL3Da9EhjQdc+bUmLCvzQlnBD6x7D
         38bspZlPuXqGcY0RDICLUfYLnztecMnbeoWPODWiyv3qb5vYN7RAX3e+kExTbYfQL9t9
         Ub2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767781074; x=1768385874;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zz5VqpciYzlzrDKhkNf3p0wOlTe+spDWVku/imh0wW8=;
        b=CcbMBhuQv2SyGCwTlwMTbEMdQjXzIzpvNmPUydCHR9m7ZsmTfw65W6Z7Hqb1Gry8+y
         daVstXwty8Q/bz+3SYNwShvV6ilY2udGHaEINPSsBJ23+7UqtXURQK4UXu1nTfCBfU2U
         pTDdOr86k6Xm5As+YNnzylD6JeGM93GE8nSnQ0WKo/d/2RZQGJaDNvcnjJ5wZd/M5TYS
         UEIfmNplPJCOR6rW2bf202nluhz93vZG9xfs7Q2k3InqpNVBLOwGz9jRf/G3y2uf4Oyi
         okfomkegdL4i7psdmeZN43rIXbljP/SwEHwHY5G0d1Q00lCAZYR6TOw9BFdVupij3H7F
         hLwA==
X-Gm-Message-State: AOJu0YxEr/0pIyz3jP5ITs5ybeeYBVByBaoi48E7tmUnUaGKko+KzgRu
	jdH8vNw4Va4QaS6eVKWzr9nfjne+9Qy8jYzc9I+QGuM1U1/oMCZt6M/OkE6BFQ==
X-Gm-Gg: AY/fxX6Xa0bMFKPFpYsa1GkpmWAWF8dlWztMm+t0al7mLikzWkdssEDmATYBS/z/lma
	eB/ocOld5WaV7kXNYu6B1eelkdVEqF4/5ENVHCj9hStygxlZxJf2jzV3Qqzb8wNoTdv1kVNI2xu
	6KM0j55vnD2061vBp1bffw8b6URnyrwkP5LL+Ydl1pYQPK5VDy6EXmFflN3yrKT2WZrjqLP0w+p
	HoeHfLILpFWnv5z4YMcFkxO3a5hlW1LWYct+J4TTO4AdA8znboqFF3VZJyjcpFkAoMw59cfgyzn
	xonSe2tCQqWe+707eap46r5oYN5cGj9ZYu00K3uV9WmuH5BwrM8wGIFbXRDniKkxnflojxsM2Nq
	cwt++OYF9AdVS3f3L/wY1HCPVwieHVSHuR8ZplAtuAFsE5Ina6bh/8r3zYs7SX9S2JsJ5+J+NeJ
	fdyFcl1+nf07mJJqoo3H8=
X-Google-Smtp-Source: AGHT+IGVy0IzKXT0arvwyJMRyYIHdNRpHdjTMklcKCCT8hfx7RIZD2RcwFg53tOX3u+ah11y3aFn3w==
X-Received: by 2002:a05:6000:40dc:b0:432:5bf9:cf2e with SMTP id ffacd0b85a97d-432c377298amr2547801f8f.13.1767781073405;
        Wed, 07 Jan 2026 02:17:53 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e6784sm9281054f8f.19.2026.01.07.02.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 02:17:53 -0800 (PST)
Message-ID: <019bcd38dadb138fda4cf8b113c13b77a4581168.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] net: phy: adin: enable configuration of the LP
 Termination Register
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Osose Itua
 <osose.itua@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com, 
	jerome.oufella@savoirfairelinux.com
Date: Wed, 07 Jan 2026 10:18:35 +0000
In-Reply-To: <a587cedd-9450-4c58-bc39-ecbdd525ef65@lunn.ch>
References: <20251222222210.3651577-1-osose.itua@savoirfairelinux.com>
	 <20251222222210.3651577-2-osose.itua@savoirfairelinux.com>
	 <a587cedd-9450-4c58-bc39-ecbdd525ef65@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-23 at 10:36 +0100, Andrew Lunn wrote:
> > +static int adin_config_zptm100(struct phy_device *phydev)
> > +{
> > +	struct device *dev =3D &phydev->mdio.dev;
> > +	int reg;
> > +	int rc;
> > +
> > +	if (!(device_property_read_bool(dev, "adi,low-cmode-impedance")))
> > +		return 0;
> > +
> > +	/* set to 0 to configure for lowest common-mode impedance */
> > +	rc =3D phy_write_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMR=
X, 0x0);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	reg =3D phy_read_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_B_100_ZPTM_DIMR=
X);
> > +	if (reg < 0)
> > +		return reg;
> > +
> > +	if (!(reg & ADIN1300_B_100_ZPTM_EN_DIMRX)) {
> > +		phydev_err(phydev, "Failed to set lowest common-mode impedance.\n");
> > +		return -EINVAL;
> > +	}
>=20
> Under what condition do you think this could happen? Do you think
> there are variants of the hardware which do not have this register?
>=20
> 	Andrew

I think he's just reading back the register to make sure the value was real=
ly updated...
If we were going to that for every write our lives would be miserable :).

I looked at both adin1200 and adin1300 and they support this in the same wa=
y so the above
should just be:

return phy_write_mmd()...

- Nuno S=C3=A1

