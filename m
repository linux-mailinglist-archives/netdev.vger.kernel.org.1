Return-Path: <netdev+bounces-142482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D18C9BF4E2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18CE1F23141
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575EC207A22;
	Wed,  6 Nov 2024 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYoIsGG6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3E207A30;
	Wed,  6 Nov 2024 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916687; cv=none; b=kB6WRUmH28enueo/a7ydtqzuUNylmbLcfZR/SvnqKJ+6gzWnJE2CuBODBJt1hSDTF3Q65RVOhYT8a5yyV3iEEDIJvHkBRek5sna6nLtuByNnE836lC/TvElRXXlHK6FNOIg1udeJI6Ix6Qg6jM3dk7DFpD3Ag3EYKf2GDUPYm4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916687; c=relaxed/simple;
	bh=I7+NKSCuuixm+p2hfzimwphRUWRKZgzh+vHWC2ltDPs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYhBU/RAk4Ea9XLeP+1x/5tl3OrblBcYRK3C7IRt8WS2fpWA0iI8fsLiAshqFkeOqYYG6D9hNdMyQqSGEgmggc670tCUFLOgbIEvklSYVzZ+UQs0lljnQBwvUyU1/ojxMbDFyKWDdZd5qH+KJQazsaWM0KqGsp+8TfvuJ889FtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYoIsGG6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539eb97f26aso5014036e87.2;
        Wed, 06 Nov 2024 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730916684; x=1731521484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KUerZBQbd4+bg88hhFJvKSj9QgEJ2Ngk8f4x34asRYo=;
        b=hYoIsGG6mQdpY+w5zg2eLm+PZ0PNhtnT52WQ65vtbwVrurOcRoO/it6Y6y3n8SOCId
         El7zCoMKPIg0yDYiMo+fk5UkagvqQ5DkTbinv0QIJZsNp+lH5JHYaFFj/i+YjgUCfm00
         JzjcdNJJ+TohLbsRPVq5D134quriy6JspyAF9V2r8D6448CN8yn0Ayagm5BW5vo8ihjA
         5jI5OHoUVb5QRA6cFSjYTQdQyHO/9l34409SBrLhX6JUsduhzy3o8I/TX3XqQUy0s6eZ
         vi0qOYt+mTF5ob0lSBmZt0l7M9x7DvHEH/lW8/XTUdav5RIgv1/iVEz8HRdQuoas1TMr
         mFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916684; x=1731521484;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUerZBQbd4+bg88hhFJvKSj9QgEJ2Ngk8f4x34asRYo=;
        b=NfWlc6ujDVVaaB6eq+0LvVGhmR6k+0ngAWp3INv3i4DpYw3A8vnaR2IXiBhxg0TBXY
         LxseexSBzY7Q3DFtalrFLj+cGP6r/n4Wd0H1MXiGcaIt/ozjx3o3k86t9a+lIlSCT2jV
         i8BqXAOsUIdI4iLUCoPInqx05kwnvCuiwSofKxaLyeQKu9q0AycCHwZHA3wQyswxfHiz
         EMIRzy4+ZDsQIku9VxF8+CmXxsqT2vmf09+9U5yU5E1OYOnap6lBtCvA+jd45tshh++j
         e7AVMs2u8XfRY+dxgvw7RNXFFShkcDW3sQ7PjVfbtn05nn3DH7wYHrceuyNs+MYlfimk
         BtAA==
X-Forwarded-Encrypted: i=1; AJvYcCWAENh+pWak/RpqFG3XGBxzcRSbKiqUlNS40iIinK0mj4aXgxTffSiQPUfLcj/BmnozCaJ2C9WUBYIu@vger.kernel.org, AJvYcCWRbaiCsEdkwUr3pU5R77hIIg9dt5XzMLDqQ9hEAhxAcOTjhwcEdyXlMm9BmQEnZNEdylOHDw83pF8lnw7g@vger.kernel.org, AJvYcCX2D2CfoL23tE62jLxsY/waDDdhF2hYzVAYSHSW00TAPkw0mkTM+seY2vKTybef8KkL5ibRdV/6@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4VORbYEVo/UXe1iEnvg2DuVIbMPN5qDgHIW0/UCLIAGXLzO3
	jXwoL9kLmD/qjkUcWcovmK6jLZHb3EsimxmUnQAy0DGCyv2GUs4o
X-Google-Smtp-Source: AGHT+IHJTwLvOEJYl2C7zDFAHdl4m70ftFJabHTUXZMihSXo6FUmYq+cdgH2knrHNo0VFTQR6uSKnA==
X-Received: by 2002:a05:6512:ace:b0:52e:9fe0:bee4 with SMTP id 2adb3069b0e04-53b7ecd5807mr13588636e87.9.1730916683288;
        Wed, 06 Nov 2024 10:11:23 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b60e9sm31713315e9.14.2024.11.06.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:11:22 -0800 (PST)
Message-ID: <672bb14a.7b0a0220.fded0.9db6@mx.google.com>
X-Google-Original-Message-ID: <ZyuxRvbygg7SfgAO@Ansuel-XPS.>
Date: Wed, 6 Nov 2024 19:11:18 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v3 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
References: <20241106122254.13228-1-ansuelsmth@gmail.com>
 <20241106122254.13228-4-ansuelsmth@gmail.com>
 <8e5fd144-2325-43ff-b2b8-92d7f5910392@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e5fd144-2325-43ff-b2b8-92d7f5910392@lunn.ch>

On Wed, Nov 06, 2024 at 05:19:03PM +0100, Andrew Lunn wrote:
> > +static const u8 dsa_r50ohm_table[] = {
> > +	127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
> > +	127, 127, 127, 127, 127, 127, 127, 126, 122, 117,
> > +	112, 109, 104, 101,  97,  94,  90,  88,  84,  80,
> > +	78,  74,  72,  68,  66,  64,  61,  58,  56,  53,
> > +	51,  48,  47,  44,  42,  40,  38,  36,  34,  32,
> > +	31,  28,  27,  24,  24,  22,  20,  18,  16,  16,
> > +	14,  12,  11,   9
> > +};
> > +
> > +static int en8855_get_r50ohm_val(struct device *dev, const char *calib_name,
> > +				 u8 *dest)
> > +{
> > +	u32 shift_sel, val;
> > +	int ret;
> > +	int i;
> > +
> > +	ret = nvmem_cell_read_u32(dev, calib_name, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	shift_sel = FIELD_GET(AN8855_SWITCH_EFUSE_R50O, val);
> > +	for (i = 0; i < ARRAY_SIZE(dsa_r50ohm_table); i++)
> > +		if (dsa_r50ohm_table[i] == shift_sel)
> > +			break;
> 
> Is an exact match expected? Should this be >= so the nearest match is
> found?
>

As strange as this is, yes this is what the original code does.

> > +
> > +	if (i < 8 || i >= ARRAY_SIZE(dsa_r50ohm_table))
> > +		*dest = dsa_r50ohm_table[25];
> > +	else
> > +		*dest = dsa_r50ohm_table[i - 8];
> > +
> > +	return 0;
> > +}
> > +
> > +static int an8855_probe(struct phy_device *phydev)
> > +{
> > +	struct device *dev = &phydev->mdio.dev;
> > +	struct device_node *node = dev->of_node;
> > +	struct air_an8855_priv *priv;
> > +	int ret;
> > +
> > +	/* If we don't have a node, skip get calib */
> > +	if (!node)
> > +		return 0;
> 
> phydev->priv will be a NULL pointer, causing problems in
> an8855_config_init()
> 

Quite unlikely scenario since for the switch, defining the internal PHY
in an MDIO node is mandatory but yes it's a fragility.

2 solution:
- I check priv in config_init and skip that section
- I always set phydev->priv 

Solution 1 is safer (handle case where for some reason
en8855_get_r50ohm_val fails (it's really almost impossible)) but error
prone if the PHY gets extended with other parts and priv starts to gets
used for other thing.

Solution 2 require an extra bool to signal full calibrarion read and is
waste more resource (in case calib is not needed...)

Anyway thanks for the review!

-- 
	Ansuel

