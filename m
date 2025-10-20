Return-Path: <netdev+bounces-230877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04026BF0D1A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C89918A0E56
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA02F1FC0;
	Mon, 20 Oct 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwKxZSGO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7F2DE70C
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959551; cv=none; b=QuJf2mYPS/GSxCpdE8jSNLZ529RYcdhmgBYH1ql7cKSvqmqKlZdkMhfoVjDf1CExOF5eINsRiqqmING/XCQnRoX7Pbnmg9DarvT9A4al47RphuMhaOZBaqIhPJUSWbBLp0docK4PF2IzZVDlhIb8WtovEbsIfQoBq2EhZq4Usy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959551; c=relaxed/simple;
	bh=+QexM2APqEkUlpP6ZQAEMO79ItQrth66FIvsgz4+9CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/h2HUceAdPkwzXduuDN2sqXQYhug49e10DH1oLOzEkCVLX/4HY2jkKAJL0LNKKHut26B4zYLqtmXKbBg4Nem9Vs6/AIXaDReV9qOPL2yychcFmuIsK3rBCYazzOTLqLGy21rKawLvLaFjqBVtRDIxcZPYarlGXA7qzRKiDJV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwKxZSGO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b593def09e3so2820541a12.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760959549; x=1761564349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oz+Xl2/NrMdS6fZi0EK9OqxzCdzOSL6WeQJpOQkz1Yo=;
        b=RwKxZSGO83GxK6UXYOQz3SS+cRAeQrsFaF8C9zariV1imWzAaSjR3QTL/RYrlAYfVc
         A5AQRfTtRDbw6uldZTIA21n7LxuS9gpfB0/yhUDK5J4EU5/nGADKqjRYNct0s4pWz3oX
         gJtS5Do3Z1bTPUBOB5RRrz+3qigcgBzc/RYf9IJvyrmsgjxGqmBA4dbfacqGanjfAY/s
         21ZnGGecjKggzu+AFtXfmnSWqK4iva4+52RFav9tV2e///o85bM+XY6OZ8B8iFlIpx66
         /tJaWa4I80RCTUkC2rMeoc647NPaYgwUZuK/Irufgf7Qz+nDwPlmQlmAa5eVcLNtTBoX
         LDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760959549; x=1761564349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oz+Xl2/NrMdS6fZi0EK9OqxzCdzOSL6WeQJpOQkz1Yo=;
        b=aqVZk5/Dwxn9l7P7X7BwBxu0BUv4SBv9cjyrfh1nyMEkKB/9lyIsIgSOGi/lB+HPqY
         wEuxroXNF58YLzSNgRbuvBJm8pleS9Lp6ZUbyhsRMGWW9rrv3ZrCQCHWaz8RPeqkr2Jy
         6k5t38ApKS8l90ezOtkO95HJ350tMcIpy4GHjsUMh5PcXt6/aboKVxhj5YB/ljpJF3Zo
         0woL7czfLp2mtYxfmO/GKXQP6sRV3hlYCMMJC4ZF08PGNVppIO2RstEZsagK7cmsd8hV
         H9lIYKORJKaCmTEK1BIZ0M3gi1CkXkrEa16Ev/d+D/L0UWKNUC7vHlx1QBGIQmwVBDTA
         8Muw==
X-Forwarded-Encrypted: i=1; AJvYcCVhe1+kxMyKPuktINFIPvXk7+rIEM2OrtrMUHedk4lco4Hvtx9tWgJPV9MC5LzVlDDjIUCUIJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvE4FNvq9T5fAOvWTxKXNXmpYxvrV/+LfLmDT4dyLTban4BkKp
	lRIHXZvxwfvZs0LUXgSqkVX3Iei4AH2mlc/yAZKxD6CRjCmO9+/V56Cu
X-Gm-Gg: ASbGncsGQakRecEhIqhAQrwdK0bvJLlHpI0gHnkGCtpO3g+Xg01DBjppFD3H10eKTcg
	jaed21xWPMUk7yXM8TKOOji98u1kFox0/nvhCn/7FEBgO/KqOhWXtLntu3+ID6jx/AdRlLT8vVm
	GdtWwtyp3D+VpS9UvOKNTnLq2583qe+abjTl11XlQDjSLqREp/MOG61mOyUt0WA5VDnTMZzbPLg
	C3vxa/UlLlkyHu4IW5T5yIsRK4+ZoQ8gBfoxs7/EJjNJrafB8U9O3ReR6ILBMSakvRkFqP+Ag/3
	/AcPm9U7RsEHFqpoUnDIT1/Mrjcx8JmcYOe6isAKaMQpabCS0KOc5GqFQ7ybfD0Y7IEWsUEiWVt
	sdABB57zmfVujECviM7NT6k8xtHxvp69m0rjmUdaqKN5hC5/Mn3xAZIvbikmxSas1Yqf2UOY+5A
	YuomwL+q2d1A==
X-Google-Smtp-Source: AGHT+IGmXkq5K8nuswuZOy/Q3vJ1q/fs2FggRu+CXIAg0ikFpAfPL8SJOtCn/E3IpbjQlSwX+Wyw8w==
X-Received: by 2002:a17:903:b90:b0:290:bd15:24a8 with SMTP id d9443c01a7336-290c9c89fa6mr155748285ad.11.1760959549499;
        Mon, 20 Oct 2025 04:25:49 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d598asm77433485ad.63.2025.10.20.04.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:25:48 -0700 (PDT)
Date: Mon, 20 Oct 2025 19:24:55 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 3/3] net: stmmac: dwmac-sophgo: Add phy interface
 filter
Message-ID: <ljyivijlhvrendlslvpo4b7rycclt5pheipegx3fwz3fksn4cn@fgpzyhr2j4gi>
References: <20251020095500.1330057-1-inochiama@gmail.com>
 <20251020095500.1330057-4-inochiama@gmail.com>
 <20251020110219-GYH1506524@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020110219-GYH1506524@gentoo.org>

On Mon, Oct 20, 2025 at 07:02:19PM +0800, Yixun Lan wrote:
> Hi Inochi,
> 
> On 17:54 Mon 20 Oct     , Inochi Amaoto wrote:
> > As the SG2042 has an internal rx delay, the delay should be remove
> missed my comment in v1?
> 

My fault, I forgot to fix here

> > when init the mac, otherwise the phy will be misconfigurated.
> > 
> > Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: Han Gao <rabenda.cn@gmail.com>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwmac-sophgo.c  | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > index 3b7947a7a7ba..960357d6e282 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > @@ -7,11 +7,16 @@
> > 
> >  #include <linux/clk.h>
> >  #include <linux/module.h>
> > +#include <linux/property.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> > 
> >  #include "stmmac_platform.h"
> > 
> > +struct sophgo_dwmac_data {
> > +	bool has_internal_rx_delay;
> > +};
> > +
> >  static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
> >  				    struct plat_stmmacenet_data *plat_dat,
> >  				    struct stmmac_resources *stmmac_res)
> > @@ -32,6 +37,7 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
> >  static int sophgo_dwmac_probe(struct platform_device *pdev)
> >  {
> >  	struct plat_stmmacenet_data *plat_dat;
> > +	const struct sophgo_dwmac_data *data;
> >  	struct stmmac_resources stmmac_res;
> >  	struct device *dev = &pdev->dev;
> >  	int ret;
> > @@ -50,11 +56,20 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> > 
> > +	data = device_get_match_data(&pdev->dev);
> > +	if (data && data->has_internal_rx_delay)
> > +		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
> > +									  false, true);
> > +
> >  	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
> >  }
> > 
> > +static struct sophgo_dwmac_data sg2042_dwmac_data = {
> static const?

Right.

> > +	.has_internal_rx_delay = true,
> > +};
> > +
> >  static const struct of_device_id sophgo_dwmac_match[] = {
> > -	{ .compatible = "sophgo,sg2042-dwmac" },
> > +	{ .compatible = "sophgo,sg2042-dwmac", .data = &sg2042_dwmac_data },
> >  	{ .compatible = "sophgo,sg2044-dwmac" },
> >  	{ /* sentinel */ }
> >  };
> > --
> > 2.51.1.dirty
> > 
> 
> -- 
> Yixun Lan (dlan)

Regards,
Inochi

