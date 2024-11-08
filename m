Return-Path: <netdev+bounces-143295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CD49C1DA3
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5571C22B89
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED531EABA9;
	Fri,  8 Nov 2024 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmTlRMxy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD81E491C;
	Fri,  8 Nov 2024 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071371; cv=none; b=md6B9PGnDZuv0Exo/aF6wJRGODEMiF66C2e6STxQh8yElGA2cE4LjCU0QtgRZypZcLzvKtZ7bG7sGoQO9Ioz6NjDkkt3PznVroUGTIhM8FBFhqEEL1plFp0KiM5PaNE7DpCCr0LIVbI94TQ7pBVl3JEbWlOHHki6z8WEfUaxPTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071371; c=relaxed/simple;
	bh=7wPSME1yvHU9R3fhuU7nAzygr3P2SjWow4X8OI/HRUc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjrm3ZZyJLuRrCNlYjb/vbJp7mPWVgfB971191peho+16HBAQnGNqUAmXGoiDgOI64Qhoodw2oVdtQjLajUyV4vbhBZkYA6SePpPl/8+xe95CJo4usTUaizAwrXrBhq851EhZUgCEvQzMRJhvleGzmhk062RcGCwNyqsd1kzuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmTlRMxy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4c482844so1326785f8f.0;
        Fri, 08 Nov 2024 05:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731071368; x=1731676168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F9iLMWxrxAZ1l6R46sN9fOYiE6mHClhuivBfFEnygig=;
        b=fmTlRMxyTJYahSGz8XKbrFIcP+lXsd0yGiakVpbEF2tD1IjGG1WUthfxXp4Tr8zH39
         2/cxt14Pc8+ZOPREA3qJS59jgJ6ES8aDTTHUrPblAesBvO2IuHSauC6g1FRKK2KnBmXc
         b0AxwG/l5JhJNzWKr+OuhmKZM79gQBIjOxUPkUmNC/01TY0r2iLKg2sHofiMmFAbxxlR
         R/BYjE8VEJA6NYYp1XhZN44BAM/VT+WQwURwOXmPJHca7OvL50m9Ay8BDrWA+98127kn
         8DOS3SGSNGpYEpkWY1EdaE71x+FZDaB4zlm9E5ElpYwE6iwK5hZ8d12C14VMzduwV4WR
         Bfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731071368; x=1731676168;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9iLMWxrxAZ1l6R46sN9fOYiE6mHClhuivBfFEnygig=;
        b=ZWdlNLUBwbmXiH1HVmcozu/x0b08IjmoK8b7gGBjKikQuhDqMX4BLUEJ7QA8d8K8Qd
         ks0svptidh4/kxlks+3VpycIfdQWTNtgJFA+op92R44bpsItenN1yvexs7h4NkOpptJR
         5LWJZabwKYrce4skLWC4Qv7i0bYuAyiXesfT/6iVDFiQswD82dbxKFIY1qI5ETqoe//+
         2lxt6Q2W6aG0UwFWLCSSYgVzcw12PwAZlh8zd7xGg6UI7NnyeB9EQnlSQP8Lmti6ugLB
         7UiFBvLVvBQBLFA7CA8pg7FHGErDtY6/C9pdWzarZ9Lpy9RtHbZj7VK1JTmLsFOKzbYp
         yJkA==
X-Forwarded-Encrypted: i=1; AJvYcCVH1V5vTysbeyS0sdoa5TPnV/OFJ3umsyhYZ76p+QlJWzhJx2UkTtQQZR4N1IKhaYeRc/sq1mE1@vger.kernel.org, AJvYcCWaZzRLjCqV9eQOEJNjDZXLxT7OQWp3E3WHtfNsRE4aDCzRUgS8HtUYMqEKTrAPe3adQ8vpOaJqLOJs@vger.kernel.org, AJvYcCWnLszoKhNVxskMo/+LkC/DxcIc8VNic+h45fk6N7FaVxtFEEYNDGJU6TBB5AVpgK/HEIS94gRx6zhao7ZF@vger.kernel.org
X-Gm-Message-State: AOJu0YwxJ9Xi083Y7+DNzqxv20UO3wD4o7Y/DjgbFi5f5MfBzn/eWS+v
	kV7+VI9gH4PXD+gNWvE/yg24IbZF9EphseTBpgW3zi3Ff723xXrE
X-Google-Smtp-Source: AGHT+IGn8e7+hz9DFcsUdMnK7TZj6vrjAuQ+ZZHeOp4IPyI4ISngIYwwvEId7eCxCw595dz7+N8oSA==
X-Received: by 2002:a05:6000:18a7:b0:37d:52d0:a59d with SMTP id ffacd0b85a97d-381f18672fdmr2224309f8f.10.1731071367308;
        Fri, 08 Nov 2024 05:09:27 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda0517csm4724320f8f.96.2024.11.08.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:09:26 -0800 (PST)
Message-ID: <672e0d86.050a0220.9eb0d.c3e1@mx.google.com>
X-Google-Original-Message-ID: <Zy4Ngmvg2sE1SOJK@Ansuel-XPS.>
Date: Fri, 8 Nov 2024 14:09:22 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
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
 <Zy3xaviqqT6X8Ows@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy3xaviqqT6X8Ows@shell.armlinux.org.uk>

On Fri, Nov 08, 2024 at 11:09:30AM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 06, 2024 at 01:22:38PM +0100, Christian Marangi wrote:
> > +/* MII Registers Page 1 */
> > +#define AN8855_PHY_EXT_REG_14			0x14
> > +#define   AN8855_PHY_EN_DOWN_SHFIT		BIT(4)
> 
> Shouldn't "AN8855_PHY_EN_DOWN_SHFIT" be "AN8855_PHY_EN_DOWN_SHIFT"
> (notice the I and F are swapped) ?
>

Typo from SDK that I didn't notice fun.

> > +static int an8855_get_downshift(struct phy_device *phydev, u8 *data)
> > +{
> > +	int saved_page;
> > +	int val;
> > +	int ret;
> > +
> > +	saved_page = phy_select_page(phydev, AN8855_PHY_PAGE_EXTENDED_1);
> > +	if (saved_page >= 0)
> > +		val = __phy_read(phydev, AN8855_PHY_EXT_REG_14);
> > +	ret = phy_restore_page(phydev, saved_page, val);
> > +	if (ret)
> > +		return ret;
> 
> This function is entirely broken.
> 
> phy_restore_page() will return "val" if everything went successfully,
> so here you end up returning "val" via this very return statement
> without executing any further code in the function. The only time
> further code will be executed is if "val" was successfully read as
> zero.
> 
> Please use the helpers provided:
> 
> 	ret = phy_read_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1,
> 			     AN8855_PHY_EXT_REG_14);
> 	if (ret < 0)
> 		return ret;
> 
> ret now contains what you're using as "val" below. No need to open code
> phy_read_paged().

Thanks for the explaination, totally got confused by reading the
restore_page code. Anyway yes I will use the helper.

> 
> > +
> > +	*data = val & AN8855_PHY_EXT_REG_14 ? DOWNSHIFT_DEV_DEFAULT_COUNT :
> > +					      DOWNSHIFT_DEV_DISABLE;
> 
> Here, the test is against the register number rather than the bit that
> controls downshift. Shouldn't AN8855_PHY_EXT_REG_14 be
> AN8855_PHY_EN_DOWN_SH(F)I(F)T ?

Copy paste error, was already staged to fix, thanks for extra eye on
this.

> 
> > +static int an8855_set_downshift(struct phy_device *phydev, u8 cnt)
> > +{
> > +	int saved_page;
> > +	int ret;
> > +
> > +	saved_page = phy_select_page(phydev, AN8855_PHY_PAGE_EXTENDED_1);
> > +	if (saved_page >= 0) {
> > +		if (cnt != DOWNSHIFT_DEV_DISABLE)
> > +			ret = __phy_set_bits(phydev, AN8855_PHY_EXT_REG_14,
> > +					     AN8855_PHY_EN_DOWN_SHFIT);
> > +		else
> > +			ret = __phy_clear_bits(phydev, AN8855_PHY_EXT_REG_14,
> > +					       AN8855_PHY_EN_DOWN_SHFIT);
> > +	}
> > +
> > +	return phy_restore_page(phydev, saved_page, ret);
> 
> This entire thing can be simplified to:
> 
> 	u16 ds = cnt != DOWNSHIFT_DEV_DISABLE ? AN8855_PHY_EN_DOWN_SHFIT: 0;
> 
> 	return phy_modify_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1,
> 				AN8855_PHY_EXT_REG_14, AN8855_PHY_EN_DOWN_SHFIT,
> 				ds);

Funnly in rechecking I produced the same exact change.

> 
> Thanks.

Thanks to you for the review.

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
	Ansuel

