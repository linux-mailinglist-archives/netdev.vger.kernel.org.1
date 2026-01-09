Return-Path: <netdev+bounces-248383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB21D078F7
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C8A73003B2D
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1682EB5CD;
	Fri,  9 Jan 2026 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U20X6Fco"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955129CEB
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943664; cv=none; b=nZiHUXxLbuN/2IvOw4Lp22OL/4zCjmZdEoZL27xZWqIY4PLLGo31avPDzpYDBVkd2LSq3LTjhP5ksuHCW7g1j3tH6eNLse6J1aW2TLiHvkjXIP0toYP12VY+78811cm2HySDtnyQ8vHJtX7ULAh6dgCpE2Se9lFPEcktHv6Qi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943664; c=relaxed/simple;
	bh=QNuVbPeI2qVEw72vq3YmkyXsF4v4LnSYiVYCItYTB0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AKfeUNKPDAZr+nikPoNLMlcvXQypCl8gGKEXXJ09hCAha5KtPoyp8S3jdkVSp5Jn60ng0xf7oPu23tDTTs6XbaKtGIVOx8PNvDUfQ4g0Z1z2J7bBG02KrPtXO8F+Dlia6OeT+re5uQ44Hh2JzTYuQdHr0YVBTdyqy6CqFCZ0XAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U20X6Fco; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775ae77516so43663555e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 23:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767943662; x=1768548462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mUlwKfPXko5L4cw7hWpnjkjddCTSDp0J/M9heFeeYPY=;
        b=U20X6Fco8NqTRMD/XyTBCjyZllK0A7hUQ4rrdM1+bNQvUlw9IZwst41TMTgCpwhe9h
         Ssh57W4ZZ9g/Epf8mNAZJwhPT0Gc2k28r8jtB/eI6VChMWykjwnbYWEiKxFmOixWWMvI
         KUNchkeDPMWxDNsp94+TZGGMuJGKpqz9JlNGKows7d+LnoXfKSwVZsZV87Lr9nREx/DC
         FsV9O8CFXOVRg6c8Jt7fahmWvnTOok0zDjEWoB6y1V7VDJ+rK5yIa6HX3Q9+HN8yZvyg
         Qc27fP6u2sv3hHLoAuBymA+v/91VPUyQCJR+tdGEbXVXAKtRKEAaaVP2vFNpOZQjTksJ
         80hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767943662; x=1768548462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUlwKfPXko5L4cw7hWpnjkjddCTSDp0J/M9heFeeYPY=;
        b=tZ6Y65T3flPZbOGXTdfPO6t39PVWXvGJyO2phNkb6X1WG8a5hZ0k/kTNlMwbRVaJ5d
         GB+VoLyJjS8aEiBHJ7N7boCP99rb5E22qTrXhfUP+V6LyNlSdPwmyOWs7mW3bBDHr+BU
         E/VhdqXpTHph4LoBEy0TI+7HBNl9/Q7SCCDkpZQ6NlwpLWQqFu8AwI1+2EUs1NTmk/7C
         q9XknPsW3/iRFCfgrClUMciTsKlyGUxQh2kyISnUkFbsdIHKAVYLqQ6uwJpjoB/tcY0l
         XkCMCovKi8U2oYLc1ymY5tZRgmq0RotIPVEnyt8Sp8DWdOnxeuQ/inoKzqOIx1HLiGCm
         CxSw==
X-Forwarded-Encrypted: i=1; AJvYcCVEIX+UL2Pi0zYWj8Qhe/HvK3pyJPkwSSFrbaEUQlGfxomQSAV+jniZjC5jqI49bC7WAW9419c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuVbQ0O87J0CpT+1yf2OSpA1LKy3jofpyKCFqcee8CUjDLOxUx
	SKSL+u2F9JYLhaDmyUBbu8OnoRRjPytkuADk1oBYCmcgtk4/E9vHH4Q+
X-Gm-Gg: AY/fxX5k9TVBetB59sv08bG8+B3nK5d7SKbl7avUP1BrCbMrMZAW3rxV3YexEtMZKCB
	2nSrNyaQQ+3YyAdQA6aEhAJ0WXiXlIu5pw9M4UYfdJ7A1T/Vff+TeC6HoLM2sr2z6w/8K+CJ4/k
	VQtGcLKoDsbjukEtoxUpKAlW+p7cdgRXDzjc1nPB/QgdvCgPYvgtJsfzjYwK7SaA+rJsZ4QMOqw
	A1+tLqEsdIPv8IOShMcqDfDvcXrvEvNC2uMsjORjjeY6FMnCcetSUKYdnTb/mzAR09+LYYhPfG6
	TEAGznVFvK+Gm/tJxiYpwvqfxHDxwgP1WZnEX0DTHxYvCCBpF5nfs5qIj2OBXo4LjYQcyt+T2WP
	b+vorog/rKw+zr8rUhxeUK2Yi8fePpdxZ2wTTkNZY2op6AwbvimiW/LKv5NbY78UZEoonqL0X4O
	+jzjtxOCd8T3wwwcmV3UkkcmdBQT189Jz7lZmMlYIdxqCWycQ/v/c9VTpZa2TvHwLxJ1UXDYxpy
	tiygAAxYnFb7QLUIyQI3dU7ty+tkFmF2DELgou/RCVi7kGnJl4NuQ==
X-Google-Smtp-Source: AGHT+IF6uMw1r7waLkv7KoCFAlGPIuQzERBLeCEdwblU6RPsq9aQl2/481f7Eu8tg0BSK5rXC766hA==
X-Received: by 2002:a05:600c:83c9:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-47d84b3b650mr98273025e9.26.1767943661494;
        Thu, 08 Jan 2026 23:27:41 -0800 (PST)
Received: from ?IPV6:2003:ea:8f34:b700:1da4:ce1d:3d7c:283d? (p200300ea8f34b7001da4ce1d3d7c283d.dip0.t-ipconnect.de. [2003:ea:8f34:b700:1da4:ce1d:3d7c:283d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653c61sm193670815e9.10.2026.01.08.23.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 23:27:41 -0800 (PST)
Message-ID: <65f60d6f-d6f9-4c36-a344-ffc713633dfd@gmail.com>
Date: Fri, 9 Jan 2026 08:27:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: phy: realtek: simplify C22 reg access
 via MDIO_MMD_VEND2
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>, Aleksander Jan Bajkowski
 <olek2@wp.pl>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1767926665.git.daniel@makrotopia.org>
 <938aff8b65ea84eccdf1a2705684298ec33cc5b0.1767926665.git.daniel@makrotopia.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <938aff8b65ea84eccdf1a2705684298ec33cc5b0.1767926665.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/2026 4:03 AM, Daniel Golle wrote:
> RealTek 2.5GE PHYs have all standard Clause-22 registers mapped also
> inside MDIO_MMD_VEND2 at offset 0xa400. This is used mainly in case the
> PHY is inside a copper SFP module which uses the RollBall MDIO-over-I2C
> method which *only* supports Clause-45. In order to support such
> modules, the PHY driver has previously been split into a C22-only and
> C45-only instances, creating quite a bit of redundancy and confusion.
> 
To complement: RTL812x MAC/PHY chips allow access to MDIO_MMD_VEND2 of the
integrated PHY only. There is no native C22 MDIO access.

> In preparation of reunifying the two driver instances, add support for
> translating MDIO_MMD_VEND2 registers 0xa400 to 0xa438 back to standard
> Clause-22 access in case the PHY is accessed on a Clause-22 bus.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 7302b25b8908b..886694ff995f6 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -143,6 +143,7 @@
>  
>  #define RTL822X_VND2_TO_PAGE(reg)		((reg) >> 4)
>  #define RTL822X_VND2_TO_PAGE_REG(reg)		(16 + (((reg) & GENMASK(3, 0)) >> 1))
> +#define RTL822X_VND2_TO_C22_REG(reg)		(((reg) - 0xa400) / 2)
>  #define RTL822X_VND2_C22_REG(reg)		(0xa400 + 2 * (reg))
>  
>  #define RTL8221B_VND2_INER			0xa4d2
> @@ -1264,6 +1265,11 @@ static int rtl822xb_read_mmd(struct phy_device *phydev, int devnum, u16 reg)
>  		return mmd_phy_read(phydev->mdio.bus, phydev->mdio.addr,
>  				    phydev->is_c45, devnum, reg);
>  
> +	/* Simplify access to C22-registers addressed inside MDIO_MMD_VEND2 */
> +	if (reg >= RTL822X_VND2_C22_REG(0) &&
> +	    reg <= RTL822X_VND2_C22_REG(30))
> +		return __phy_read(phydev, RTL822X_VND2_TO_C22_REG(reg));
> +
>  	/* Use paged access for MDIO_MMD_VEND2 over Clause-22 */
>  	page = RTL822X_VND2_TO_PAGE(reg);
>  	oldpage = __phy_read(phydev, RTL821x_PAGE_SELECT);
> @@ -1299,6 +1305,11 @@ static int rtl822xb_write_mmd(struct phy_device *phydev, int devnum, u16 reg,
>  		return mmd_phy_write(phydev->mdio.bus, phydev->mdio.addr,
>  				     phydev->is_c45, devnum, reg, val);
>  
> +	/* Simplify access to C22-registers addressed inside MDIO_MMD_VEND2 */
> +	if (reg >= RTL822X_VND2_C22_REG(0) &&
> +	    reg <= RTL822X_VND2_C22_REG(30))
> +		return __phy_write(phydev, RTL822X_VND2_TO_C22_REG(reg), val);
> +
>  	/* Use paged access for MDIO_MMD_VEND2 over Clause-22 */
>  	page = RTL822X_VND2_TO_PAGE(reg);
>  	oldpage = __phy_read(phydev, RTL821x_PAGE_SELECT);


