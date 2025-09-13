Return-Path: <netdev+bounces-222790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D005B56108
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 15:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39FEA0583D
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ABD2ED165;
	Sat, 13 Sep 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROOTANAu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1612EBB81
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757768687; cv=none; b=irUvor9LJZMMW1P/MKn4rkjDVu9pVaKwaNXwMHQ7cH+HyuFtt9bOq1WNcDyx4zC76p5dW+EPYqgSmfxqrJzm4lrkRgWBGuBmbIKuVkx1jAeXuIg8mTWfssLUMqqFvp1eAFDceBzjf8vJmzcNoCIixvu8Bd/A8kEP4S+JEyc8aLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757768687; c=relaxed/simple;
	bh=b7tBpzh15qGN8uVwd9Pr+CjEOhF0/2vXJq5OskdvkFI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pupum5FDF0QaAgdTH/0zRqc+UkGNdN6PAjL2OWUOfIRiExSMzfMkHTinP/xQPHRxuaxHa30EXOiSy64OO7BTDP4v4Y9BOiN/5Bs2pl/FkM1L30liEDCk8hplAPW88HpAuWyOx0hVO52I5O2na7jNR2I5KCvhzYQNfg5hL1eMF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROOTANAu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dec026c78so26505705e9.0
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757768683; x=1758373483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn5g5etmrQRhW0GOll7653iUOWDP8XBcYnO++0L6iOw=;
        b=ROOTANAuPag/jlv1nGo0RpkMHmO2JTrBDg2Yrw87LzqGxDemmhmp+U5etJ17YVcPl1
         WxCTSa1CnoCQ9h5Y3ID4q+BkPhYPJHWrcj+elvYxZzSJ63kZ/XMjtbDDsAvmbhyKyoxv
         tgS5LtxbLRxKp0B0VKzCg4FTcTnXIrgFLINkSq7uc8DfkaXiOjh8EJZsq0vqyOmjNfS0
         RrcgpJ5Yae/3gol1jHciPc+CP/aPSRyqDTYlNzGfEq8tl+p0H5IrGeUGJ916r0Rw1IoI
         KQ4dHe5K8+mgsBcxZ1A0FMqox0nnqLd5xSjm1r+3ocpoTE+HUVItkSN+4g0V1heE87W6
         ufug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757768683; x=1758373483;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn5g5etmrQRhW0GOll7653iUOWDP8XBcYnO++0L6iOw=;
        b=oMYv0BZW+zfsy5hlr1TiUTmWsl+ZGwdxp1kLx7t8xJ29CE5yNajb5bXAjXBy/7EdgW
         UWjcSkIDclZyEc/V9TZ7IFzYjoF+u8zywQwEPWjAuVavwrJvSXhwrSqJHtpMo58dcthn
         Xl68RgCgCr2r2uIfCPc4nvgIHyHwHLfsc+8uTtA2O+jGCthk46cP+C7qFmwR25FLXGfA
         hWy2GyeSyJdYjOru4/A9az9miVNXDGTTsqyhWk33tQoL68PwYIQmzmomFWYy7iBuPgyZ
         EGLVtJupHHqXANwsj1fXFOvUJd6+511vyIhh6jWZNUpVaO06qhqNXTI+kaq8Q/APSVs7
         99fw==
X-Forwarded-Encrypted: i=1; AJvYcCUSiTHyxZ0cObSTfArUeKT5xcI0mqGhSCy/Cp/fwV3lqPlgOB0096qhZvJgZ4lZiZKK5NNIm/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxrQBiCtzRANSo+lOlrg+z0IHaQhV8kTrn7M4HKIB7zQmfAo6x
	gYLge3drl5xSSRsHtBQ+Mha2KmdDKJ1kcFkJPD3IBkFpFTOfAW331mmW
X-Gm-Gg: ASbGncszu1cbJo/BS8tbW686VTogZ7ildt0Qg21/RgopHk9GfJOWcGmBaJYf5w1b1Nt
	LL7pNgquBqvnoD9dMbHfBxHhsln6jM2dXUmk1XXfwUAY56Dwbsp1200IxrcxnkdvHqDMEQrtgqA
	DfNRhn2m5iWxES7eOHqW4tSBmdnTf1rUc3FzpTJQmnoDS+8W9eYVBdtbWwfsuod4YLOit92xdpV
	eBN6GrwWHOES1ruHIlW4O7jWudvLTebzAyGd9OkVIIVwxv6Kyf8PnaOKiXg7Hi1mm2aQtG9quGe
	ToaTHcwlwYnSLO4yFa2nKsMf0YHJDIjGt5Og8oY5A+AMRfUTaLZPuwpzAORjIjOM63Fhw6Cqvw0
	fXE7WJJzLQdlZYqR/T30tDF1QdLRP16UFo4YLVcWSepU3QPKkUUtK7GHZYyOEIFytjlOssTd1fc
	AsNxE7
X-Google-Smtp-Source: AGHT+IH7bqCK1wDu540Yv6h59nRCAcKulg0ljt7g6L2IwpwzA60j/nsTl5Zjtr2oKtoo9w4/vWv6Gg==
X-Received: by 2002:a05:600c:a45:b0:45d:dd9c:4467 with SMTP id 5b1f17b1804b1-45f211ca33cmr60235475e9.7.1757768682776;
        Sat, 13 Sep 2025 06:04:42 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e015784c3sm105911875e9.10.2025.09.13.06.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 06:04:42 -0700 (PDT)
Message-ID: <68c56bea.050a0220.a9dbf.b7c8@mx.google.com>
X-Google-Original-Message-ID: <aMVr6Hkskt5mPfFP@Ansuel-XPS.>
Date: Sat, 13 Sep 2025 15:04:40 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v17 6/8] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
References: <20250911133929.30874-1-ansuelsmth@gmail.com>
 <20250911133929.30874-7-ansuelsmth@gmail.com>
 <20250913130137.GL224143@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913130137.GL224143@horms.kernel.org>

On Sat, Sep 13, 2025 at 02:01:37PM +0100, Simon Horman wrote:
> On Thu, Sep 11, 2025 at 03:39:21PM +0200, Christian Marangi wrote:
> > Add support for Airoha AN8855 Switch MFD that provide support for a DSA
> > switch and a NVMEM provider.
> > 
> > Also make use of the mdio-regmap driver and register a regmap for each
> > internal PHY of the switch.
> > This is needed to handle the double usage of the PHYs as both PHY and
> > Switch accessor.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> ...
> 
> > diff --git a/drivers/mfd/airoha-an8855.c b/drivers/mfd/airoha-an8855.c
> 
> ...
> 
> > +static int an855_mdio_register(struct device *dev, struct an8855_core_priv *priv)
> > +{
> > +	struct device_node *mdio_np;
> > +	int ret;
> > +
> > +	mdio_np = of_get_child_by_name(dev->of_node, "mdio");
> > +	if (!mdio_np)
> > +		return -ENODEV;
> > +
> > +	for_each_available_child_of_node_scoped(mdio_np, phy_np) {
> > +		ret = an8855_phy_register(dev, priv, phy_np);
> > +		if (ret)
> > +			break;
> > +	}
> 
> Hi Christian,
> 
> Maybe it cannot happen, but if the loop above iterates zero times,
> then ret will be used uninitialised below.
> 
> Flagged by Smatch.
>

Do you have hint of how to run smatch on this? Is there a simple arg to
make to enable this?

Anyway yes it goes against schema but it's possible somehow to have a
very broken DT node with no phy in it.

> > +
> > +	of_node_put(mdio_np);
> > +	return ret;
> > +}
> 
> ...

-- 
	Ansuel

