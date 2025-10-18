Return-Path: <netdev+bounces-230639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1205BEC2F9
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66807620B9D
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F61B1632DD;
	Sat, 18 Oct 2025 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUdt9f5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77F178372
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748281; cv=none; b=czmcH31+A17R5sjvDAVo9cKs3yG60uICz3410Ac5tWPVsYeAqKTFypnSNSJriDPUlpa9kLSfZi2ukQO/TxkHpUHXDpjMzqbYrge8J7Z396hJAF/EYWu4CAApZBvAOfpuuWu0l9HlcEm0Ef3mkH63Qpo7trYHJpDK3a809qIXso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748281; c=relaxed/simple;
	bh=sHF2/XPZw6H0+JGNQbRl7shSpw7MIUsqz9Xi23Hix74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmulLrYOoSe5h10+1P9gFdg9y9jEaxLOFmwlPy065pIRG9gsQYK5e+sAeu0amls3I1p10HsJGXgMhDXLewmw+7VYnbEZdbXnwHAFjgg6DtB9x63nAFzhMXj8nn/LSDM6up6EBPEBd1xV9rLQgmHMLFu81muXWnlw73G12MbcKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUdt9f5i; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290b48e09a7so27318615ad.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 17:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760748279; x=1761353079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QafKpBA9ev9tZ8RtBiTe7ilN8YrDWJs4uzq+MACIIs=;
        b=fUdt9f5iwA4BDe8irbzVPi1woSuKvNnIqgt3/bItl4hrmKX8YKqg8iqpef24Zd24t4
         3++L/qYWHutF9xvXPYB5kxgAVa+acix6h1n9CgVzDisN0qa6WWZxwdTddtIqCk/7BZEU
         L+oxzQqH/E0d79Mmu+6VJSbPUeqUiSPreDs/sUY6XnVkkX3JkAEVl83F2PsNmp0cPlh6
         ssECQgv4Jj8m5EXR6PLsUGGlCDD+aAQwOJHtufreJjie6RCtuemqhpeiiu1yjk4ICp+h
         cUTZgfjypzzF8DOxJwrnzmTLBz2sOXYC5ausIHMo7rvfAr/CKAftaoSKhhAu3KZcvV+t
         /ROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760748279; x=1761353079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QafKpBA9ev9tZ8RtBiTe7ilN8YrDWJs4uzq+MACIIs=;
        b=J6wOcsk7rC6bT0KSfYg6phRNVrNbqRgXFMt+TAbSr9+YSMF8szTAIP6btwCQ9qyDSZ
         bUyDCqYCLEW5OCHnuqWojgBnFzikspm2vMXBHGvUZEAWRkacGWfuRNf4HFugS9EjxBrv
         5rBRuPzN/hqZGpkNvg3+A4OMMlx5GQkrXwtj5zujiqMGq/F2BnvZZYS/0q3ZUhDGtknf
         /iu7HlPHSi2eEBsbm1PrOAmFrJr8QcMVJpfbBXQJ93oxvFplUH4vCLJ8DKLQOu9oTIyj
         VmQwbqWvODNFZcn2LNF3WZnHYji6OSyqhnLzkxMgpgtMKzixqwnU2NcgyhL064FDeAgz
         l+cA==
X-Forwarded-Encrypted: i=1; AJvYcCULF4FdlwBwJGf75eWqABALZ5sJVHAtVa94IZgaHkWXgfR2u6mjSJSDav7HOpTtBIMs3pOaUWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8n9kDhpzBnNeCehRlTv9tZpK9c69+ZmLJRzZKz3BgeXOwJPv
	G+8MulzuiR0c/dMSB2eWYvK8Y4SLd3xfFO451nacUam3CMHQyGpwkQym
X-Gm-Gg: ASbGncu4o3fl7EQ4EydmPl1cGLiqzKbmElyCLIkqRcA0YqKXfMbuaA+fnOFWecQl4fQ
	vYGcx9Jv3BsA3tQaBOnJRD1gbVjcMOhhOywu9CKjoHW7BDfdl8YLvjA+BM14c0R1yMoTHXF2Udh
	Zr096b7BIu5pAqsKV/RegU4PKXMg2qv5bN96BjU30NT6iejTkyeU3R9RZzc9YccgFyQpOJsrM/A
	Wwm3aqIha4AKF9izypG0bZGmMTi71OUj2k8JCpqR0Git5HsCFhZwxP+sTm9KuOZSkM+VfyarQfS
	uzuInVmrFNwEELbqHzAqT9kMivaJbHvzL8OGDEYpwRSXBShyjrwN+cHvPpGRkoGyeq1SyhVnS09
	cgBDuv9wCAhmAsh6LkPZzFkrUkYc7iPuJp06cK9le8IOaN04NS/1b52cGX9X0J1NQKn90na3bim
	0=
X-Google-Smtp-Source: AGHT+IEJHzKpBZuNZNa18WS/ADFtdVavA7SE/dNX1ygVUM8SyYneHAxGCurSyYxg3cW6a8KtgONCXg==
X-Received: by 2002:a17:902:ea01:b0:267:d2f9:2327 with SMTP id d9443c01a7336-290c9cf2d88mr81827755ad.27.1760748278692;
        Fri, 17 Oct 2025 17:44:38 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721b6fdsm7874395ad.118.2025.10.17.17.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 17:44:38 -0700 (PDT)
Date: Sat, 18 Oct 2025 08:43:47 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, netdev@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-sophgo: Add phy interface filter
Message-ID: <hmch7csqotxt42snddksce2mpnjeglbgvoxs6r5qlu7v2ayxyk@zctj7xhugeln>
References: <20251017011802.523140-1-inochiama@gmail.com>
 <20251018000548-GYA1481334@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000548-GYA1481334@gentoo.org>

On Sat, Oct 18, 2025 at 08:05:48AM +0800, Yixun Lan wrote:
> Hi Inochi,
> 
> On 09:18 Fri 17 Oct     , Inochi Amaoto wrote:
> > As the SG2042 has an internal rx delay, the delay should be remove
>                                                      s/remove/removed/
> > when init the mac, otherwise the phy will be misconfigurated.
> s/init/initialize/
> > 
> > Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: Han Gao <rabenda.cn@gmail.com>
> > ---
> >  .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 25 ++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > index 3b7947a7a7ba..b2dee1399eb0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> > @@ -7,6 +7,7 @@
> > 
> >  #include <linux/clk.h>
> >  #include <linux/module.h>
> > +#include <linux/property.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> > 
> > @@ -29,8 +30,23 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
> >  	return 0;
> >  }
> > 
> > +static int sophgo_sg2042_set_mode(struct plat_stmmacenet_data *plat_dat)
> > +{
> > +	switch (plat_dat->phy_interface) {
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII_TXID;
> > +		return 0;
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int sophgo_dwmac_probe(struct platform_device *pdev)
> >  {
> > +	int (*plat_set_mode)(struct plat_stmmacenet_data *plat_dat);
> >  	struct plat_stmmacenet_data *plat_dat;
> >  	struct stmmac_resources stmmac_res;
> >  	struct device *dev = &pdev->dev;
> > @@ -50,11 +66,18 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> > 
> > +	plat_set_mode = device_get_match_data(&pdev->dev);
> > +	if (plat_set_mode) {
> > +		ret = plat_set_mode(plat_dat);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
> >  }
> > 

> >  static const struct of_device_id sophgo_dwmac_match[] = {
> > -	{ .compatible = "sophgo,sg2042-dwmac" },
> > +	{ .compatible = "sophgo,sg2042-dwmac", .data = sophgo_sg2042_set_mode },
> I'd personally prefer to introduce a flag for this, it would be more readable and
> maintainable, something like
> struct sophgo_dwmac_compitable_data {
> 	bool has_internal_rx_delay;
> }
> 
> then.
> 	if (data->has_internal_rx_delay)
> 		sophgo_sg2042_set_mode(..)
> 
> 
> >  	{ .compatible = "sophgo,sg2044-dwmac" },
> >  	{ /* sentinel */ }
> >  };

Yeah, I think this is a good idea, thanks.

Regards,
Inochi


