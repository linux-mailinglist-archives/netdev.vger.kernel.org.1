Return-Path: <netdev+bounces-84431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9807B896EF1
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD001C20BBC
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C5B38DC0;
	Wed,  3 Apr 2024 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD6NMf8o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCBF224D4
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147865; cv=none; b=YocSzHgfZoH+XRcNT+/jS5x903bF9NopSoYpXBx4UkuPLm7q6az+f8cuVjWWl6eJ7E6mh/KMo0p3oFmti4blpZWIBr2nTJwF9v3QWgNvdzy8DVQ7R2o+hqUKEWlIzXWOGNN1Pq8i+B7DD9MAWhfqj14mY2kp6DIf1s+vvgts/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147865; c=relaxed/simple;
	bh=r6H0laMDLdDWjaGJCwUEKxXY+DkoDLtF0Rc8ThkdChE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9y5fjJmZIdKoU8IvQV4Ai7qOshDGiQaFudkTKsTIyDb4wDW9JfcrgUnqcXXJmqDDZbsCMSqU56E4U6AOHf//Tp1qah49Gj4pUtbRXZFRtSsIM2gKIn76tWmc1nyPNxlhWKATxXnvrtlg6KJQKPPaaC+0ISU6Ypqba4CdxiDqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD6NMf8o; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d475b6609eso69287811fa.2
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712147862; x=1712752662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvL/UIV777Lc+V/wCf6aW/aaCOL9JFMUmqdkkoMNKpY=;
        b=gD6NMf8osURsov9gLY+crAn62yUUo5Awil1FtaWq8OiPkOFu+duQgNVYim59WjAJjz
         OHDUNJ5YX9fVqkTNZO6YUU0r1Oep+hIyrYVxCZRyhN2cWMyuytEZXO6n7yFL1EOhQruV
         Kcb2ywVHfF5Uq/13/R0peI+cC8yxG9I9iafmEkVlCp7OxNk427hZyWTgU3uGBB2CD29B
         omPVZkjXibQ7E/XLTDeof6LGFNO3KMa/3C5bSN3TgG1QPlG8osK11d0N95gdD9qq5Wlp
         +AzzFaJ8leAkqbVMM1l/o3hQ27PIK0I5W8MYe/2SYqmxUlzq+gBDUwMJ4cTnQFdssuXb
         dZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712147862; x=1712752662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvL/UIV777Lc+V/wCf6aW/aaCOL9JFMUmqdkkoMNKpY=;
        b=mar5ipX8FLKdlIjV0nwoagn4s+j3HBMo8PJpj7TjrU35cRV8NTbR2mSEVskCoD3RV5
         vGaO8esoQfgmjxiKuDOD+2Y/Pp4tptKiFOCdHXYZT10jln5Kz0M6Nc308GB/f2/ETuO1
         3pRaTN2nebRybCHxhm+lCLa6oqucE0Gtq7Cf+ARr7RISS2O/NxLb906CaSG4YumAIJdq
         /TBUrc4v+pHBvDIT0iT6GEAlIy7tAnLlbehjQORo+moixvZzXkgCywm5oqhx3aTK7dKW
         rnPq1I/YdsOX7K1HYmZvWlZBLAdixzkhp5+ZKvC9iwrkBLAVGWiKmYAvTP6rxjaq5+q9
         LSQg==
X-Forwarded-Encrypted: i=1; AJvYcCX5sTebsssNw0fCubLDZm8tuOS+ENoppH37eWAbjnId1iVuNlr1ui0wPDEycEiGqAXSoCAliNGC3p2/RZkec4+Lg4+RqLpg
X-Gm-Message-State: AOJu0YwywckSC6ANR65nLUIPWFeSzgSOkx4aeo3RdpOEG05PeCYNm1Q2
	mCQwLBm4RtANk2/QOSP+d1P3dXFhLqPwZ5awoBD++EwFQx1znM+R
X-Google-Smtp-Source: AGHT+IFbxvDKbLvxvajHNV+583hkjNkaZ8i7I6axn3fPjYpDMdp7n0/JtpEFwWjjWHsGH3nTsULYyg==
X-Received: by 2002:a2e:9b07:0:b0:2d6:c2b9:9118 with SMTP id u7-20020a2e9b07000000b002d6c2b99118mr10455182lji.46.1712147861427;
        Wed, 03 Apr 2024 05:37:41 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id s21-20020a2eb8d5000000b002d496ecda1csm1861806ljp.61.2024.04.03.05.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:37:40 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:37:37 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
Message-ID: <jzapsbgrdbpv7ei7uoet5aqxgvnpdqsjpm7amlvbveqnfk2bao@ck5q63hks3zz>
References: <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
 <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
 <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
 <ZfF+IAWbe1rwx3Xs@shell.armlinux.org.uk>
 <cd8be3b1-fcfa-4836-9d28-ced735169615@loongson.cn>
 <em3r6w7ydvjxualqifjurtrrfpztpil564t5k5b4kxv4f6ddrd@4weteqhekyae>
 <Zfq8TNrt0KxW/IWh@shell.armlinux.org.uk>
 <fu3f6uoakylnb6eijllakeu5i4okcyqq7sfafhp5efaocbsrwe@w74xe7gb6x7p>
 <Zf3ifH/CjyHtmXE3@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf3ifH/CjyHtmXE3@shell.armlinux.org.uk>

On Fri, Mar 22, 2024 at 07:56:44PM +0000, Russell King (Oracle) wrote:
> On Fri, Mar 22, 2024 at 09:07:19PM +0300, Serge Semin wrote:
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 25519952f754..24ff5d1eb963 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -936,6 +936,22 @@ static void stmmac_mac_flow_ctrl(struct stmmac_priv *priv, u32 duplex)
> >  			priv->pause, tx_cnt);
> >  }
> >  
> > +static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
> > +					 phy_interface_t interface)
> > +{
> > +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> > +
> > +	/* Get the MAC-specific capabilities */
> > +	stmmac_mac_phylink_get_caps(priv);
> > +
> > +	config->mac_capabilities = priv->hw->link.caps;
> > +
> > +	if (priv->plat->max_speed)
> > +		phylink_limit_mac_speed(config, priv->plat->max_speed);
> > +
> > +	return config->mac_capabilities;
> 
> Yes, I think your approach is better - and it still allows for the
> platform's capabilities to be masked in towards the end of this
> function.

Sorry for the long-term response. Thanks for your comment. Seeing
Yanteng is struggling much with this series review I'll convert the
suggested change into a patchset (taking into account that the change
implies some fixes) and submit it for review later on this week. After
finishing the review stage, the series could be either merged in right
away or Yanteng will be able to pick it up and add it into his patchset.

-Serge(y)

> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

