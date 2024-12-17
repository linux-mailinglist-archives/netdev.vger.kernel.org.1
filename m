Return-Path: <netdev+bounces-152677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B29F5596
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563F71678FA
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9CF1F7577;
	Tue, 17 Dec 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4zkIxgV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081313D600;
	Tue, 17 Dec 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458352; cv=none; b=bqrHZla8pi8eu+HaU+AJujX81pr16Ck/oLC4CB7XVzgiJNMFn3lzRKveFoW+588YGBdhuzmJ8r+dqbkcK++du4aWVi2IuQshZB2j2UjBEl6WTtoQo+mo2Y0+iZjNPOYrbbVXN2frgohGg0R82GJvnoP5XF2y8uIU08QCKapFFZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458352; c=relaxed/simple;
	bh=19rHgnCBsZP8BMHGcitya26MsyA0QXlmaHTZDUQqkr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEbLv/LCMSN7IQYkMX/5dFDCaTGeG4e+w5TiY7jvxQ1DG715bGuDpSHBV8C1j4CVWrPU8s25gaULwMjSvYADSn6B5MTUuCKrAgcS//FQ4siZASyJlQg11PowIhE/6TFNMu/3yuBmWpunJW+u7XEGw3WJlt0TSFqmefPczHG4rHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4zkIxgV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43622267b2eso59270455e9.0;
        Tue, 17 Dec 2024 09:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734458349; x=1735063149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAv29RYXXNDztcHwntsNfs/9pzSwnI6rgxuTLH9jpLc=;
        b=A4zkIxgVHkL+pIf3PArPLGxGtrnvI6/BW3qkEJrdLLUyjmC5/5OL11Qm7kq9DRNH5M
         YpEIFQhJ8xTYtMB20QDnPDNFuao48trk9oVymYSDEJixzJ15lSwxt2n0AFW23LpDe3w8
         +l1EYT5Dr5fc+/zWQdScPlL1t/TVrq79CerXtvpxfwNKx/9wQdgp2VfRmwEf+c+Ni0n1
         VnELW4WUgL5deRMzna4qcBvNP+37tLDQiaRttVPagkwwySv38sDMtllS9XwGfvfPXpgp
         25fO2RRdu9VwNfkFKDMFzV1qIsiuA6k02xEBCIh+KtnuJw246tbNsrwJYhx0QeoKEID4
         1SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734458349; x=1735063149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAv29RYXXNDztcHwntsNfs/9pzSwnI6rgxuTLH9jpLc=;
        b=FelTuq+yyykOHHVA47VChLKdzb/A9gXguqDwwA+Ej3/E7ETLqyWsZ28lbZSXdkOXlf
         U6hz3OWrB0faDcBibgLXGeTBMXWvd5Nas5JvcUnjsj/TX+2ZCnr+TNz1XCOmRtEBg0vB
         Pk+aw6dwG+9Ryopvnd1CqN6p3bB5diob3bOPQmzWVR8ryzxmC79irxOOb4/hy7IuTFMV
         2cNf5vQkaZscM9KsYbkyivlfMB1edEWh2io2ezuDYcpg4gBMtAxxyvu4ZKjyUpH7AsI+
         6F7U/Z4I8iio7WrAJVJX4/yitzJsDUAASaD4cinro2wNE9IQO92XPrdxUHMRPr2QFkSK
         /cqg==
X-Forwarded-Encrypted: i=1; AJvYcCVQF/Z4RdYYv1lyfDiOfgDONrHn8IE422G3y+Z9izoq4Gw4ze0CiN6rbf8ZxsYtGV/eDr0TfRE8@vger.kernel.org, AJvYcCW9UhisXnLdYy+zmQBxxmqH/fpqN1oTkmDnMx0dr1xau+OrEWQ0Cd87wxkjoEQ0ybdiLeywtyl9WzGk+4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8IOLmGSPulrutdYwl2JdZ3pWw9/Qeo99gMQL3dz5hmNknFFt
	fxOAVnJ1+nH3pkXOl1TGm+5EFmKJFnx6HJ1kgDV4uX4vDcNCzDtb
X-Gm-Gg: ASbGncuuw8pI8Ky28z/RYz3M5K8nhPyJTlwFznMBbvYDt8NqcjZPfiDE98u9lvY2Cvg
	0udJ5LO7P5N2ZlvhC18YlGzlApaxEImbPsBveUBLoUko/E9vmhV2rTioh845/JryVnwNmRUlgrD
	4ldq8LK2b6I0RGhdTmstAGOyYTDfm4WZJXdcU1SaxtCFKGIZ1cxHKHEI+fZ2LWxgpJNUbPEch+2
	u8/e61GcKbYuC/JtloyfGjbYDh1eosnwtrcswM/iwgzo9D4Sbpj
X-Google-Smtp-Source: AGHT+IHx4RZIWwHScfUvlY6I1Ia4WwE/fbobDjJ7OnDv7M7YaVKqnEuq73f/eoHACwqXnNObKxvgdA==
X-Received: by 2002:a5d:6d07:0:b0:386:4034:f9a4 with SMTP id ffacd0b85a97d-388e4664e34mr144725f8f.43.1734458348690;
        Tue, 17 Dec 2024 09:59:08 -0800 (PST)
Received: from debian ([2a00:79c0:674:2500:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362b6981sm126434035e9.31.2024.12.17.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:59:08 -0800 (PST)
Date: Tue, 17 Dec 2024 18:59:06 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Message-ID: <20241217175906.GB716460@debian>
References: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
 <1a7513fd-c78f-47de-94d7-757c83e9b94c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a7513fd-c78f-47de-94d7-757c83e9b94c@lunn.ch>

Am Tue, Dec 17, 2024 at 06:13:25PM +0100 schrieb Andrew Lunn:
> > +static int dp83822_led_hw_control_set(struct phy_device *phydev, u8 index,
> > +				      unsigned long rules)
> > +{
> > +	int mode;
> > +
> > +	mode = dp83822_led_mode(index, rules);
> > +	if (mode < 0)
> > +		return mode;
> > +
> > +	if (index == DP83822_LED_INDEX_LED_0 || index == DP83822_LED_INDEX_COL_GPIO2)
> > +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > +				      MII_DP83822_MLEDCR, DP83822_MLEDCR_CFG,
> > +				      FIELD_PREP(DP83822_MLEDCR_CFG, mode));
> > +	else if (index == DP83822_LED_INDEX_LED_1_GPIO1)
> > +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > +				      MII_DP83822_LEDCFG1,
> > +				      DP83822_LEDCFG1_LED1_CTRL,
> > +				      FIELD_PREP(DP83822_LEDCFG1_LED1_CTRL,
> > +						 mode));
> > +	else
> > +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > +				      MII_DP83822_LEDCFG1,
> > +				      DP83822_LEDCFG1_LED3_CTRL,
> > +				      FIELD_PREP(DP83822_LEDCFG1_LED3_CTRL,
> > +						 mode));
> 
> index is taken direct from DT. Somebody might have:
> 
>            leds {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 led@42 {
>                     reg = <42>;
>                     color = <LED_COLOR_ID_WHITE>;
>                     function = LED_FUNCTION_LAN;
>                     default-state = "keep";
>                 };
>             };
> 
> so you should not assume if it is not 0, 1 or 2, then it must be
> 3. Please always validate index.
>
dp83822_of_init_leds does a check that index is 0, 1, 2 or 3. Is this
sufficient ? Otherwise I would validate the index.

Best regards,
Dimitri

