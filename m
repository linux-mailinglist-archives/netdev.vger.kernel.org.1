Return-Path: <netdev+bounces-119683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D17956944
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B544F1C21479
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974CD161320;
	Mon, 19 Aug 2024 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfIdfbbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CE1662E8;
	Mon, 19 Aug 2024 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066619; cv=none; b=Wf9QSVb18uD5DmxJ6LMoSD9mCl/gFPdxkQXZ5yh6SNOsM6RAOPDXHEezRHhPG1S7EemdLo/k7zliYwzNIRuuaUwag8xnIok+GpBTVnlJD46JnS8JP+d/NePoA7yX3+2Y705uaou0eOBKHDhodieGsuRayoRAfY1xAO6UUnTTNEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066619; c=relaxed/simple;
	bh=ci1K0h7zlYlyjvo5jHiSOoPSyGYj0n1gsgMafZ6bY9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuYZ8q8+rN3tz0gQwi6FkPzXl7Gzkl/a58I6NB7lybcPiDmIl1uz1ilqPPIBUG/ahYhksl4flL3fNs0VExQscldDGNRlnCyRDa0/keijzkIgTnFuaqRVBov+iaPwyfcxw9KEFYLw9w0P6pswidC0dDl5U/lk0Km1DWqSQqVSU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfIdfbbz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f1a7faa4d5so52325111fa.3;
        Mon, 19 Aug 2024 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724066616; x=1724671416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tprFxrKfsDYUogvcMoI1LKxJEeb7f1ZyOv21fW+7YTg=;
        b=MfIdfbbzK8aRJiiYVO7ZSSBu8yjGc8tV0QLbpeHcQm0EehY/dGJwnVyrrXXOv6WqN4
         RjQcm5vW4ha+bayOqWyddpTAugGhLBeGXYfiSqwYHA2wB0R4m3/BXnjZ2zByQitBuWRj
         2aHkga35Szsq8/y5435TYeQ9gCKKmUmgpgNJFvabe4U8VK0a9p0iRsQOa72NW9J2FTAN
         pv4Z66ytHdnPTYD0eBX9T7jZ/W2bbh+Zqw88tTayXbzLSKjeL8NLA2c/UN7/Qs0RS9KH
         +87TvOaGhD2/qa74cJUkLaG4XXP51Ru8lR5A1eFZ7E/a4l93LA9ZttDKAOpE/boPo2fJ
         Y95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724066616; x=1724671416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tprFxrKfsDYUogvcMoI1LKxJEeb7f1ZyOv21fW+7YTg=;
        b=cxDAb1AipehAbvOOri0x0/FEolXSmV6OJ6KJGwb72OnFsYhAPDkGUx3pTGUv+3WSGQ
         Y0Hn6MaimwTpdRQ82fZEEvVx0aignGby5nlfqDIbe/zreUj9LHH0cAKlXIV76fgs9IpD
         +zOyUnEnO07GTUuid0AU7TaO4JlwRdG0HG0zDDrpdfJzKdOFLxn3u8/ig9k6/k9fzHT3
         SMBj9s9B/1yLxbiy+rd2w+H4sQQM3YE6OGENlzZ9Ot7ZWooCmmwxsYtORa04h7qv0A0j
         BJhuyugq4XWUpdiEpH+aSQ4zrvQWQ6aQsgSF7DhsrFVpPlgsJLO9pvev9dCunqTV993c
         /wsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCLo4443RnlC+gazb0VkmfME2wkpiCmROvLikAHJR3+gvJZK5/5CcBg4zO0kc/SWFbWAUttoPGaw4YHmRnoY39rzgVpC2IKsCQIyBSZW+Buao6q74Flo05dkHDjzC8sLNaVu87
X-Gm-Message-State: AOJu0YyBJn3HzrP7DUSHPhNS1ukq/FGsb8cqZLM/K6poXkfATP/vmCDJ
	Il2Mgor1KVWhTAtnLrW5YsdQkO5caTAm8arvarMW0Yd7WKRjBnMnF25ajQ==
X-Google-Smtp-Source: AGHT+IGqHw5aq4Yu5IwvBHPNFj0C3R+/6U8ytKFwReL7XY64X9J8HjO+AB7srHVJE+zt2fnxZzC+qA==
X-Received: by 2002:a05:6512:1086:b0:52e:9b2f:c313 with SMTP id 2adb3069b0e04-5331c6ac976mr7551084e87.22.1724066615124;
        Mon, 19 Aug 2024 04:23:35 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d425c0fsm1456167e87.298.2024.08.19.04.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:23:34 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:23:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, dl-S32 <S32@nxp.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/6] net: stmmac: Expand clock rate variables
Message-ID: <r5jc6kzvalommas5gs6pxmxpsygjkuj6zi6pz6qtdlya2n2kqv@4rtqdorr5iw7>
References: <AM9PR04MB85062693F5ACB16F411FD0CFE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <ciueb72cjvfkmo3snnb5zcrfqtbum5x54kgurkkouwe6zrdrjj@vi54y7cczow3>
 <AM9PR04MB8506994625600CA8C4727CFAE2832@AM9PR04MB8506.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8506994625600CA8C4727CFAE2832@AM9PR04MB8506.eurprd04.prod.outlook.com>

Hi Jan

On Sun, Aug 18, 2024 at 06:54:01PM +0000, Jan Petrous (OSS) wrote:
> > -----Original Message-----
> > From: Serge Semin <fancer.lancer@gmail.com>
> > Sent: Tuesday, 6 August, 2024 12:18
> > To: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> > <alexandre.torgue@foss.st.com>; dl-S32 <S32@nxp.com>; linux-
> > kernel@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> > arm-kernel@lists.infradead.org; Claudiu Manoil <claudiu.manoil@nxp.com>;
> > netdev@vger.kernel.org
> > Subject: Re: [PATCH 2/6] net: stmmac: Expand clock rate variables
> > 
> > On Sun, Aug 04, 2024 at 08:49:49PM +0000, Jan Petrous (OSS) wrote:
> > > The clock API clk_get_rate() returns unsigned long value.
> > > Expand affected members of stmmac platform data.
> > >
> > > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > 
> > Since you are fixing this anyway, please convert the
> > stmmac_clk_csr_set() and dwmac4_core_init() methods to defining the
> > unsigned long clk_rate local variables.
> 
> OK, will add it to v2.
> 
> > 
> > After taking the above into account feel free to add:
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > -Serge(y)
> > 
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c   | 2 +-
> > >  include/linux/stmmac.h                                  | 6 +++---
> > >  3 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > > index 901a3c1959fa..2a5b38723635 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > > @@ -777,7 +777,7 @@ static void ethqos_ptp_clk_freq_config(struct
> > stmmac_priv *priv)
> > >  		netdev_err(priv->dev, "Failed to max out clk_ptp_ref: %d\n",
> > err);
> > >  	plat_dat->clk_ptp_rate = clk_get_rate(plat_dat->clk_ptp_ref);
> > >
> > > -	netdev_dbg(priv->dev, "PTP rate %d\n", plat_dat->clk_ptp_rate);
> > > +	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
> > >  }
> > >
> > >  static int qcom_ethqos_probe(struct platform_device *pdev)
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > index ad868e8d195d..b1e4df1a86a0 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > @@ -639,7 +639,7 @@ stmmac_probe_config_dt(struct platform_device
> > *pdev, u8 *mac)
> > >  		dev_info(&pdev->dev, "PTP uses main clock\n");
> > >  	} else {
> > >  		plat->clk_ptp_rate = clk_get_rate(plat->clk_ptp_ref);
> > > -		dev_dbg(&pdev->dev, "PTP rate %d\n", plat->clk_ptp_rate);
> > > +		dev_dbg(&pdev->dev, "PTP rate %lu\n", plat->clk_ptp_rate);
> > >  	}
> > >
> > >  	plat->stmmac_rst = devm_reset_control_get_optional(&pdev->dev,
> > > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > > index 7caaa5ae6674..47a763699916 100644
> > > --- a/include/linux/stmmac.h
> > > +++ b/include/linux/stmmac.h
> > > @@ -279,8 +279,8 @@ struct plat_stmmacenet_data {
> > >  	struct clk *stmmac_clk;
> > >  	struct clk *pclk;
> > >  	struct clk *clk_ptp_ref;
> > > -	unsigned int clk_ptp_rate;
> > > -	unsigned int clk_ref_rate;
> > > +	unsigned long clk_ptp_rate;
> > > +	unsigned long clk_ref_rate;
> > >  	unsigned int mult_fact_100ns;
> > >  	s32 ptp_max_adj;
> > >  	u32 cdc_error_adj;
> > > @@ -292,7 +292,7 @@ struct plat_stmmacenet_data {
> > >  	int mac_port_sel_speed;
> > >  	int has_xgmac;
> > >  	u8 vlan_fail_q;
> > 
> > > -	unsigned int eee_usecs_rate;
> > > +	unsigned long eee_usecs_rate;
> > 
> > Sigh... One another Intel clumsy stuff: this field is initialized by
> > the Intel glue-drivers and utilized in there only. Why on earth has it
> > been added to the generic plat_stmmacenet_data structure?.. The
> > only explanation is that the Intel developers were lazy to refactor
> > the glue-driver a bit so the to be able to reach the platform data at
> > the respective context.
> 

> I guess it is home work for Intel developers, right?

Mainly yes, plus to that it's a one more crying out loud from deep
inside my soul about another clumsy solution incorporated into the
poor STMMAC driver.)

-Serge(y)

> 
> Thanks for review.
> /Jan

