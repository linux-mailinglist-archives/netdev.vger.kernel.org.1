Return-Path: <netdev+bounces-211335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F315B180BC
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA751C81872
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D118B23C51B;
	Fri,  1 Aug 2025 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbEW4Mob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E519AD48;
	Fri,  1 Aug 2025 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046815; cv=none; b=QTcRNncdb8bKuxVodVKYVCFb1Q26a/pxgsJir6djuL7ywIKzPs5k/qkYsvlhQM5E+GoPhuT8AlbPcGjJZJnlScCFpz0ejLItdZJAjQ+8VC8APRm+EY2NJ1+OYpjj+EWMpg3obwaxhlwu7VZdDQqzHwPCP0/fOuVflxSwrb5hPYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046815; c=relaxed/simple;
	bh=kYYvVTM4qPH2mG8oNBuS7rj/rQa1XFn68dlJ7SJHifY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBPoyWk3K3Rl03FCLymsNLEWv02S6sHJEL+fG12fnHtppz29r7+G1XzHh/xPUQUtnHfjXL/L1mn1idrXH3j9oxqEWcttYe9ea6uEMfgT5ce3Ng1sblrba4OqTMqAROa4gdaeETBvHOadGtGwbY1KMetAzfXvJEXKQNv+yMof3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbEW4Mob; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-455d297be1bso2271755e9.3;
        Fri, 01 Aug 2025 04:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754046812; x=1754651612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWsD4E5MkQZBKxPCQDxHGrezzNPyoGhGr3r6n78HRXI=;
        b=CbEW4MobiAbf8Qb5EB9x3iufJ4GHYEIeLqKZQYzSh171X4EedPFpEnuKL4IwQ1AHpo
         uJ2U33ivkYD0ZnwZEYZ9FKjbgLoWDHs4Fa9VRnKRrIAGOZRWjFmA+OD0r+cVQQVbiKPO
         tmPs6c6StO6XVwNSdxs2tmCkDlEWEL/Vv01++qshfiGGg+48slSEXz58ynl9ScooQDtr
         rlvMo7lPGvBi7kqu14i1Kni6/afbo0M/3wc8sJTneXufTezeFc6jWlH6iK80bRLCwbBI
         Gc6gtvBoJ2q8b2xS8nkqSGTXSHGbRvbdPVbPJn8vaWUE0EGEnjjJgQmMUxYJVRaxD6gh
         Tz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046812; x=1754651612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWsD4E5MkQZBKxPCQDxHGrezzNPyoGhGr3r6n78HRXI=;
        b=AopyX/jDxzZhSbl81Ugi6cYQ2M2QKbIM+3WDEaBzngRY891dbiHkNKO5WVIZMlJs/9
         fmWw+63xNolr1Fyau55cjFuzOqak9SzjOXlXt3hZcdN/I+P15iIiCHCT4BGLT87ktmZT
         5zK7uHIIL+cmq8VXmZ+34mFN3OW41X/EDXVW0PVJFHigSdTqp14jKHJZXKu+lEg11K+M
         VK5lGMCFK4+9kX5mOtJu5o3jP2IngjGhHDY++b9LoCWZCcGJ4BIMSGargNNqANa+qFau
         jQtNPOPAZR8/D1Ydv/Lov1FNVcWPZn2QcpN2NnwPnMHt3KCahzMiVx8Jms1eOK5MXVBj
         nO0g==
X-Forwarded-Encrypted: i=1; AJvYcCXiHQ4PrO04rOvORQQObjfPZGaIkOhbGEQT29UZIacay1pWn3Sl3tfJz+L3iTqpCeXnVfudbSDYVRotOLE=@vger.kernel.org, AJvYcCXjhkPbDE2lCypQvySShM9NUkwaOla/L4pDnbfFCXXI0knbtZvkRX1l4vXlmt0zNxq8t+2AlW/0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7zgMeP3i3To3PqMNtlR4SKWy8cUH58w6mI1VgKEJaC+CIXjG
	KhckDTnCeIRTi81Nk8XNIXEOfdNLJOrkVqCPb/KcIM4yAVS5aUtERROx
X-Gm-Gg: ASbGncvzjca9PZF4maVFtyrwk/Qa6aXhmYmSWRuK84XaHJtwtXANpgcQiYfPKyzWx2Y
	rpmv71TCx2YdJYRi3Nj52xhW6xlpep7F3zMpWAzShQDFElvTmG5jjukU6nsQFAaS2YEKV3CzWwy
	SARyCPCqbCEtWNBFRuEpws/QTm7cx3HqxOuGOp2kkDhvWsp2eoCEzyWHsrXuALbZ0ckC8kjct4b
	3ctkTSpkrERn17GJVqUKizfP/LzMgNfxGWh0JJztXGtCLD5uAC1JsrrcrVJkjzkdulQhh2OMCwT
	hmpDNNQR+jFitUAs/L+aDx4uTvbx4ya5ck3hBHtkUB8C3IbaSjct7yic3yoD6XEbCOvCzU+ULDl
	YMV6eXGyBJ4v0Nss=
X-Google-Smtp-Source: AGHT+IE7JIiob8i65gyZWYSDQUxoEkn4lMJGeIvSKpmdEp+VEBlEeE3XX/xpChu6zM2RTdMsbm2APw==
X-Received: by 2002:a05:600c:1384:b0:455:fa91:3f9b with SMTP id 5b1f17b1804b1-45898e51908mr39441635e9.6.1754046812278;
        Fri, 01 Aug 2025 04:13:32 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:b5a7:e112:cd90:eb82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2848sm5436728f8f.71.2025.08.01.04.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:13:31 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:13:29 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250801111329.j4oaiyuiuvkncckw@skbuf>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIvDcxeBPhHADDik@shell.armlinux.org.uk>

On Thu, Jul 31, 2025 at 08:26:43PM +0100, Russell King (Oracle) wrote:
> Essentially, in aqr107_fill_interface_modes() I do this:
> 
> +       phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1, MDIO_CTRL1_LPOWER);
> +       mdelay(10);
> +       phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x31a, 2);

By the way, you can add:
#define VEND1_GLOBAL_STARTUP_RATE		0x031a
#define VEND1_GLOBAL_STARTUP_RATE_1G		2

according to:
https://github.com/nxp-qoriq/linux/blob/lf-6.12.20-2.0.0/drivers/net/phy/aquantia/aquantia.h#L45-L54

> +       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_10M,
> +                     VEND1_GLOBAL_CFG_SGMII_AN |
> +                     VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
> +       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_100M,
> +                     VEND1_GLOBAL_CFG_SGMII_AN |
> +                     VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
> +       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_1G,
> +                     VEND1_GLOBAL_CFG_SGMII_AN |
> +                     VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
> +       phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_2_5G,
> +                     VEND1_GLOBAL_CFG_SGMII_AN |
> +                     VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII);
> +       phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1,
> +                          MDIO_CTRL1_LPOWER);

