Return-Path: <netdev+bounces-150873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F393D9EBDE1
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B556169B08
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6E71EE7DC;
	Tue, 10 Dec 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5CLeXqF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE132451EE;
	Tue, 10 Dec 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869945; cv=none; b=oMY3cJwVv7lc78zunZePQufzfpi4PyUKrw3gmi+NmMbOfoQY+VXI4tnrJCDD3GxgBy1cJLnzQH0EXIGLqpPbh1MAebSqH889eXFa+wxzzfz2ATaSdquuCQ19yJNfsXRPAm9l26mWAqIFP80UjmipzBLxpsIVZiSgNIWeyOlcDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869945; c=relaxed/simple;
	bh=hgMJx2VtJ+BbwJuND9+Surw/NGbnfW1t9z8fyk7Lwpw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdnC11SuYXaPMeq5OnLpiJoqla9QpZO8TsYvsuK8yUjQWOXsceKqJ1XcN9I8S0auSTnAA+kqICL+OWPsrlha55b8EpTsMBMfnE2WM+e5b40vBRzLroQIrw/adBrpn6WA6sC3j+ZmJ/rGWr0hlRD94t0OavDU/sU8WXHKRXAkdfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5CLeXqF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862b364538so48322f8f.1;
        Tue, 10 Dec 2024 14:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733869942; x=1734474742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QnO56ocUjPfv+bgOKk5gIkhPUA621URHfVhC+NJz7p4=;
        b=U5CLeXqFf4tHcprr2O6oChNC4XUwEqBLmSuYDg4pDG664k9T2LCC7lRYkDuSPn8M8k
         C2Klleznh+7UM8y2d4JM4lrBZNOgUWCjZOo3o2TG+7IKX4VMg0XfP36zxuf3c7NVeWkX
         nKOslg7BVSeqHQE7t+2xqMPyK3s/rlc27LRN/xNTUfvUeaXhga6taC25izzvm+iQ6EIH
         QETUJuW1alZjKZQHZ90cjnXXvDW7WfpvyEkg3CklPM9a58cdtpVOUABduePedQu+n6bT
         IuI/xh1lwkZsK8xQ9ROlICJhv/2FywmfWcy2CZkMaGnU1uhGS8bRYHSxuRPl3KwXe9fe
         atyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869942; x=1734474742;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnO56ocUjPfv+bgOKk5gIkhPUA621URHfVhC+NJz7p4=;
        b=ha9Kqp+tmvIqOFomIx5xSbEUXv5NFCvJXbeaEvjUH42T4kGMawc50FE5wHKusUg3rd
         FGCNx9FdjpCHngMgsKEQKl6AifyIM+56XJzVj8Ce9PuVl4Zwj5Zj2U1M7GEo+Ei5k3cI
         PmxUYHwyz88xX4JFBhGwGkpxUcfm6CFifA42mGM4Fd9Uv91vKrNGfJ97+5HgTc4JJQ6v
         w/QHM9TEQpKcfe6qyo7WC4LkZFeyJaF+83xrOpdEXf4rGMxCTCg3+cT6rDyVYgTMsPuU
         oynrcCYyuNuEafv9FD+sWpph1YWH7/Ifh+qXKMxDW4ZPn1+jm9ZiMXCg9oP4c9LZlDaC
         AS9g==
X-Forwarded-Encrypted: i=1; AJvYcCVFndzAnyrUAN69rZXMOco3OUB81o33Ml162R1+t46oXuROKYNT/QBVpnXN7cGDGhLThjV/LqDnjMte8Hfo@vger.kernel.org, AJvYcCVMBzA6pTnznmTGth2j6SCPfUsAcIkWSOR/kiStwrkFoM4oFhJr7ALj/C+yqK8nTG+h7LrNW168HBF2@vger.kernel.org, AJvYcCWDaEJzrHtK1Y6aKMnh8OgLzeYN3LU/ZZONpTzVwuBmNxTP3yITPJj69qUbvcYUUeEleqBWnTc0@vger.kernel.org
X-Gm-Message-State: AOJu0YwRsHZR8LRsoT3F1kQgw1sh8N7wbcpnV4ZD1/6OtoiXarFk+GE4
	RnfLcGWTV+zSGrGgznDZSQQVqLT9FD1zniyXDRuYLu2r8kKs6FKH
X-Gm-Gg: ASbGncu5c5X+1vCcwDkMfs+0SH/BmOEImOU+yX/gRB4G1CF20EfVsieXOawye2b2WHz
	h8TzRLmcP5pF1wAkkuzFomgBSzf/4B6ZPZnPnq3x7JZCmzgeq0GNTmyfYxtioPL3wRlsUDA4fi4
	imA/Xts2SFK3tJqKBjfF17XkDmve5xUptVqZgfOeFgZa8tn6ILrdpIOEivL/xP1i+z3IUMvgfPg
	nFIoXPdq/zOubtGTKsRXH988RhXwpHDnDZLvwjjAUN6swb4pVl1mDMr0SjUA1uw1Ylgj7/CnVHg
	OwidhRO2/Q==
X-Google-Smtp-Source: AGHT+IG1bSXHS0bpB9SrnpgSiy3t2o7skv79APs7LVWlF3TOUod3SzTBdm60dVBBJHjBYfbo6u0icA==
X-Received: by 2002:a05:6000:1a85:b0:386:3c93:70ff with SMTP id ffacd0b85a97d-3864de9e47emr286354f8f.8.1733869941960;
        Tue, 10 Dec 2024 14:32:21 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f8836dbbsm62231295e9.0.2024.12.10.14.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:32:20 -0800 (PST)
Message-ID: <6758c174.050a0220.52a35.06bc@mx.google.com>
X-Google-Original-Message-ID: <Z1jBccAhjYjXTNRV@Ansuel-XPS.>
Date: Tue, 10 Dec 2024 23:32:17 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241210211529.osgzd54flq646bcr@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210211529.osgzd54flq646bcr@skbuf>

On Tue, Dec 10, 2024 at 11:15:29PM +0200, Vladimir Oltean wrote:
> On Mon, Dec 09, 2024 at 02:44:22PM +0100, Christian Marangi wrote:
> > +int an8855_mii_set_page(struct an8855_mfd_priv *priv, u8 phy_id,
> > +			u8 page) __must_hold(&priv->bus->mdio_lock)
> > +{
> > +	struct mii_bus *bus = priv->bus;
> > +	int ret;
> > +
> > +	ret = __mdiobus_write(bus, phy_id, AN8855_PHY_SELECT_PAGE, page);
> > +	if (ret < 0)
> > +		dev_err_ratelimited(&bus->dev,
> > +				    "failed to set an8855 mii page\n");
> > +
> > +	/* Cache current page if next mii read/write is for switch */
> > +	priv->current_page = page;
> > +	return ret < 0 ? ret : 0;
> > +}
> > +EXPORT_SYMBOL_GPL(an8855_mii_set_page);
> 
> You could keep the implementation more contained, and you could avoid
> exporting an8855_mii_set_page() and an8855_mfd_priv to the MDIO
> passthrough driver, if you implement a virtual regmap and give it to the
> MDIO passthrough child MFD device.
> 
> If this bus supports only clause 22 accesses (and it looks like it does),
> you could expose a 16-bit regmap with a linear address space of 32 MDIO
> addresses x 65536 registers. The bus->read() of the MDIO bus passthrough
> just performs regmap_read(), and bus->write() just performs regmap_write().
> The MFD driver decodes the regmap address into a PHY address and a regnum,
> and performs the page switching locally, if needed.

Doesn't regmap add lots of overhead tho? Maybe I should really change
the switch regmap to apply a save/restore logic?

With an implementation like that current_page is not needed anymore.
And I feel additional read/write are ok for switch OP.

On mdio I can use the parent-mdio-bus property to get the bus directly
without using MFD priv.

What do you think?

-- 
	Ansuel

