Return-Path: <netdev+bounces-244460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B35C3CB80AD
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 07:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D0BC300768E
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE14A283FF1;
	Fri, 12 Dec 2025 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYM9o4Hb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E028136F
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521675; cv=none; b=c+2acHkWNBiIeM+Kvv3U6NXgUKFbcEYdx9dv+o22ZmlvUJ0Xa9X6MtorL0CcU1dm282DuWiKne1TVdPFRf0vSTUp9aBNCOmNHQm3uDqKVboyD1xuQVbcoyMA+QAa7X/WdCGDP/6/tgBTFd1ze4oRTLQqayh6+d2mjfD/osbv/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521675; c=relaxed/simple;
	bh=EGGjWYnkkHDyueL0BDm4DN/rC1WlBNGx0u/5qlcPAFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaJEqHgmT2wZSpo0Qoj2pVHlzl9+a6XmqVFzLlWXaXv6Ml9ti/vumL7kCe6u4sT1ImuqVu8yTdET4l2Qu/KCVW9FosstwzTLhiTPlSBI5DU7l9I2qaGuGkduhTDMfBm6xCV6oo8fgjtCl0cp8E4S0Z5N2Kbl65aE/xfRM5e5Tgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tYM9o4Hb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso6331125e9.3
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 22:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765521672; x=1766126472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/0dbF2KGAYM3vdkkaB9ys4HQSTDRocKJY/9bGXcOOVY=;
        b=tYM9o4HbBtBZCS7IgxuzB3LW8VMuorLZkcvJnLi3Xntn9TrO8h8vvm1deF587AhjD0
         m4jvZd/OegEkOfbSa/eQFlu5nuyG/EMSNi04VYcvpN9Ufh8429qBeDByAPiWDaMP46TG
         xmrWoKWFhygCGOjqssCzjliDJSJ/CmJMXgGymzZq11KeTwu6QTR+m7FqFmXesaPpVFrp
         8dVVaaQO7Mt2v6pXo7ekFm3Lt2iKtFFbxyZh03XW0N+a4lHJ7Y0prcnYNeb47zfkLz5Y
         HAwW8v0jknmPZNzcGAbCeN6DZfsAmQ6PBkdwgKOsLh7JTVgyZunV0fHFqsc8/VJEMAuS
         fDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765521672; x=1766126472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0dbF2KGAYM3vdkkaB9ys4HQSTDRocKJY/9bGXcOOVY=;
        b=Zk7MQsnceo7Ysk3b0+Tu/wgrX9HOt5D+gE8pRzwAnRtJ0I3TmD+A/aEmL7N+4zPfu4
         KmKEzZ6sTGPqIGsgZlVSlUYF7KiJrGaVrShK4mPMBBDAODqehKyD65y971OhmZOOKgZb
         Hiy0FQWDkjwxFWzNnSzcD7eNNO4DWfeGsv+DnSISZzTTZPMF90dtVXoyw+Vow7zfZxOx
         2DKaQ83xBmEnaGJIPAJgSx3Vx3jQaov5pbYGDhpCwRVKLONSNwOiJuOD7qPnocO9uYnL
         aeo2ct6BALRKqEqKZr3RAn+cIiQCAk542TSndNYnqHLrOTQNqypuVnbkW/jWrEuzRAv1
         3Lpw==
X-Forwarded-Encrypted: i=1; AJvYcCVPMyTtmJ8DVT7Mq2MvYeUzt1Lhel/HaxTUJHmZq46yAygRq2wTQsdHQAla1fuHu7oHkXAgfwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKBDvb6JvH5Ug3/7zWQJvbLui5kmCpTnUU/7+ohd0ZySe9YE75
	/hckX0ReJLu4QaTMHbdSQ7U5rmsheHg1bwp9kpUwNpJnFV8B1m7pVQOu5xhN1IDhpuM=
X-Gm-Gg: AY/fxX5ZS4UHbmWnDtFl8hfxqoRp7AIH/vCMGT+etIupNCg7y15gNKUDqMZjKzmTgM5
	/5kJG6xeOl6TPMvHwbfrv8kl31yiz74POhPe0tuKvEVzMZaAtel8hg5Zka2Ug0KmK+xa0Al8/CR
	VxXPf1kzPPZhL46/qW9eUurbKdJmAs0rO6xWquEeKTS4WABOUgrx7BfHN+P+akUwKD3Ajf9gNXj
	bJkkHeN5eDgw4OUMwWNZ/VizVKW+7DMmSjG7TqKJo0NZ5+0VLKhiwiLYcdzpK/j4sRvDcTg+kY1
	eKKPa8CoVbC511DD7bfXHGih2Rt8hUHtixlZ1RLB8EEOGdTCc8KJWefauqyKIcuAvLPY07PcH2v
	JLeuJ/+1eHE4BceohhfrqbAU3L9Y0KFKxHjEnO7+1E0Yw2nJJZHH6KuVH4uCszZ3f47VWq8hFGP
	zcW2OfK4xhxs21ANho
X-Google-Smtp-Source: AGHT+IF5qezNkUaAJ9catHYZZtFdsT9KvXk7hbPAPFs0cPAp04mHo7MQ82wa12a1D0dIkmm73s4oQQ==
X-Received: by 2002:a05:600c:470b:b0:479:2a09:9262 with SMTP id 5b1f17b1804b1-47a8f8c00d1mr7099105e9.9.1765521672165;
        Thu, 11 Dec 2025 22:41:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f3a1b17sm5503315e9.2.2025.12.11.22.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 22:41:11 -0800 (PST)
Date: Fri, 12 Dec 2025 09:41:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org
Subject: Re: [PATCH 1/4] net: stmmac: s32: use the syscon interface
 PHY_INTF_SEL_RGMII
Message-ID: <aTu5BB0pMfgzIodh@stanley.mountain>
References: <cover.1764592300.git.dan.carpenter@linaro.org>
 <6275e666a7ef78bd4c758d3f7f6fb6f30407393e.1764592300.git.dan.carpenter@linaro.org>
 <aS3GzJljbfp2xJmW@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3GzJljbfp2xJmW@shell.armlinux.org.uk>

On Mon, Dec 01, 2025 at 04:48:12PM +0000, Russell King (Oracle) wrote:
> On Mon, Dec 01, 2025 at 04:08:20PM +0300, Dan Carpenter wrote:
> > On the s32 chipset the GMAC_0_CTRL_STS register is in GPR region.
> > Originally, accessing this register was done in a sort of ad-hoc way,
> > but we want to use the syscon interface to do it.
> > 
> > This is a little bit uglier because we to maintain backwards compatibility
> > to the old device trees so we have to support both ways to access this
> > register.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 23 +++++++++++++++----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > index 5a485ee98fa7..20de761b7d28 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > @@ -11,12 +11,14 @@
> >  #include <linux/device.h>
> >  #include <linux/ethtool.h>
> >  #include <linux/io.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/of_mdio.h>
> >  #include <linux/of_address.h>
> >  #include <linux/phy.h>
> >  #include <linux/phylink.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> >  #include <linux/stmmac.h>
> >  
> >  #include "stmmac_platform.h"
> > @@ -32,6 +34,8 @@
> >  struct s32_priv_data {
> >  	void __iomem *ioaddr;
> >  	void __iomem *ctrl_sts;
> > +	struct regmap *sts_regmap;
> > +	unsigned int sts_offset;
> >  	struct device *dev;
> >  	phy_interface_t *intf_mode;
> >  	struct clk *tx_clk;
> > @@ -40,7 +44,10 @@ struct s32_priv_data {
> >  
> >  static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
> >  {
> > -	writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> > +	if (gmac->ctrl_sts)
> > +		writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> > +	else
> > +		regmap_write(gmac->sts_regmap, gmac->sts_offset, PHY_INTF_SEL_RGMII);
> 
> Sorry, but even if that regmap_write() is targetting the exact same
> register, these are not identical.
> 
> S32_PHY_INTF_SEL_RGMII, which is a S32-specific value, takes the value 2.
> PHY_INTF_SEL_RGMII is the dwmac specific value, and takes the value 1.
> 
> If this targets the same register, then by writing PHY_INTF_SEL_RGMII,
> you are in effect writing the equivalent of S32_PHY_INTF_SEL_SGMII to
> it. This seems like a bug.
> 

Yeah.  Sorry, I forward ported this, then back ported it, then forward
ported this again and I messed up.  :(

regards,
dan carpenter

