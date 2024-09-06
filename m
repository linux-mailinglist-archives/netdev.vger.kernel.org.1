Return-Path: <netdev+bounces-125930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A396F496
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF71B218C8
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256521CCB45;
	Fri,  6 Sep 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyJuVLWn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D70E2745B;
	Fri,  6 Sep 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626975; cv=none; b=ZYDYBukidameaubRNdWrJED/nyrAzp5BEr2zg6nIv1F0b7G8ku8xoUZ6E62b2kV2QduknyGLM1QKHoy10KF0CyTNT4+Na5jvvMjKfGQTq+NOzG+XuOmr3/gQQTDZaib/Q9qgmpfwP+uRqkFnH9gLRcg3jarcOS0Cza2TqyBN2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626975; c=relaxed/simple;
	bh=/JQrWFue7O5d7XFf2sAp3z90GB4AIZ1wnBd1Tralu4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILQpEOXkXyiMxDY/qQ80/rIeK+hvJz5nyTti0YiOIRF9i1/eprO2VnXvbsgZY7m6UOQveZOL6RI1iArs3rXjLvC3wztdwbN8m7gT3Ld915AcMakE7fzoCoquqOoU8fthHWXjV1XFImEsG4NjkWM9+in0cWYpI5RzdFxIrUL9Eic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyJuVLWn; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53652d19553so288211e87.0;
        Fri, 06 Sep 2024 05:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725626969; x=1726231769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CazLyKDyDWBGE+TrHohi5rRaTCuA6ZV2cOHXjRbJ6FA=;
        b=kyJuVLWn/P4EGzW5wwWZtIjSfjc136+MeQuz49o3NfnLzQdVgDeo6+UpP59RoTlwLm
         ywnKINp7ao6llO3dy1wq46Xv5kmLFqusnz3pV6Jhaat4ntzurHD4i4LPCVb9frlhIFMZ
         Dy7799XlnMAXf84h0N6UVi283IaIMiFeMBRnW1Od7ZT6h/0umHGt7/cXm3fiNJozO/XQ
         3g3TOuaLBIFjPivCxPv+CvU6J5cWXZcVOj/lAFWVyWCM8fvsriwxmWWC0nBWdTSK8o/I
         6k2M7T8C7OLBxUCGUfu+AmGmmYn8tVzSAmKypU5eNcAoCR7Li8mgWJ2Npm33g7k+8DJ+
         hjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725626969; x=1726231769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CazLyKDyDWBGE+TrHohi5rRaTCuA6ZV2cOHXjRbJ6FA=;
        b=quZn1vs3CdIIdb+NjMZpGDA7uDrtPWo8768qiBxndkIignV3HBa9bBXFaNrF+YP+Lx
         gbY2OU7RoTR2TDUwuj464cItQft49u2l2LMOqoeNiPa7n5foNkRKDv9hyia5WfR6tHho
         glDzy0w8MEthzFFk4xGUytXf4Qtcdfqv1l0pH4G4CnkgfVKB0pD4JeHlDTo+O877Zg2g
         PGNakX2PSgrgfsWUw6iifWG9KssbHGXQpo6ILra+lwmLdUNmBU82gfEonmnNxLigZ+Pf
         yLIvv2714THNIb9PbIrhfuAOv6VXhdpwJ7OU+dRbm5QLV8UdjUYLZI7JgNuWrq3rj8yN
         0pcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFyGAo4rxCozuRzXR7ug0M3BpOqB3c7dti7lFBKmmcHP2NUJ+fqRK9eB3Ol6gDwtNwNs4mVW9A@vger.kernel.org, AJvYcCXwF+erqLy1osmL0wAuUB8qS2MjXZF9St+NHOV1ep9G6hB5U50nDJ2eNwGmjIwv40OXF32OOkCC6zMlV/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDKffKMKTFjo5kC1DRh2nA3psZ2cNVYRBQPbLdHn1EWkn+MCi
	+90yRCvf7R2LoQywG1+wSJ3qqflTu5Zgp8cXbimhQrt1rEOuoJoJ
X-Google-Smtp-Source: AGHT+IGDs+OBqeonRw88x+u40y2cJauEoSXB0MFc/Um5YW0NdPJ9YSGIlAJ4uY+T1N91qq87eQ+3ww==
X-Received: by 2002:a05:6512:3ba4:b0:535:4144:d785 with SMTP id 2adb3069b0e04-5365881cf56mr870682e87.11.1725626968213;
        Fri, 06 Sep 2024 05:49:28 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a77f8fefesm198420766b.182.2024.09.06.05.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:49:27 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:49:24 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v9 3/7] net: stmmac: refactor FPE verification
 process
Message-ID: <20240906124924.odfhsgiyg4jkrnqx@skbuf>
References: <cover.1725597121.git.0x1207@gmail.com>
 <cover.1725597121.git.0x1207@gmail.com>
 <13f5833e52a47895864db726f090f323ec691c62.1725597121.git.0x1207@gmail.com>
 <13f5833e52a47895864db726f090f323ec691c62.1725597121.git.0x1207@gmail.com>
 <20240906124109.s4p7lgrycfgr62vp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906124109.s4p7lgrycfgr62vp@skbuf>

On Fri, Sep 06, 2024 at 03:41:09PM +0300, Vladimir Oltean wrote:
> On Fri, Sep 06, 2024 at 12:55:58PM +0800, Furong Xu wrote:
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -969,17 +969,30 @@ static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
> >  static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
> >  {
> >  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> > -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> > -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> > -	bool *hs_enable = &fpe_cfg->hs_enable;
> > +	unsigned long flags;
> >  
> > -	if (is_up && *hs_enable) {
> > -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> > -					MPACKET_VERIFY);
> > +	timer_shutdown_sync(&fpe_cfg->verify_timer);
> >  }
> >  
> >  static void stmmac_mac_link_down(struct phylink_config *config,
> > @@ -4091,10 +4068,10 @@ static int stmmac_release(struct net_device *dev)
> >  
> >  	stmmac_release_ptp(priv);
> >  
> > -	pm_runtime_put(priv->device);
> > -
> >  	if (priv->dma_cap.fpesel)
> > -		stmmac_fpe_stop_wq(priv);
> > +		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
> > +
> > +	pm_runtime_put(priv->device);
> >  
> >  	return 0;
> >  }
> > @@ -7372,53 +7334,88 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
> > +static void stmmac_fpe_verify_timer_arm(struct stmmac_fpe_cfg *fpe_cfg)
> > +{
> > +	if (fpe_cfg->pmac_enabled && fpe_cfg->tx_enabled &&
> > +	    fpe_cfg->verify_enabled &&
> > +	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
> > +	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
> > +		timer_setup(&fpe_cfg->verify_timer, stmmac_fpe_verify_timer, 0);
> > +		mod_timer(&fpe_cfg->verify_timer, jiffies);
> > +	}
> > +}
> > @@ -7875,15 +7874,8 @@ int stmmac_suspend(struct device *dev)
> >  	}
> >  	rtnl_unlock();
> >  
> > -	if (priv->dma_cap.fpesel) {
> > -		/* Disable FPE */
> > -		stmmac_fpe_configure(priv, priv->ioaddr,
> > -				     &priv->fpe_cfg,
> > -				     priv->plat->tx_queues_to_use,
> > -				     priv->plat->rx_queues_to_use, false);
> > -
> > -		stmmac_fpe_stop_wq(priv);
> > -	}
> > +	if (priv->dma_cap.fpesel)
> > +		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
> >  
> >  	priv->speed = SPEED_UNKNOWN;
> >  	return 0;
> 
> Calling timer_setup() after timer_shutdown_sync() is a bit unconventional,
> but I don't see why it shouldn't work.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Actually, I'm really wondering. Is lockdep okay if you run timer_shutdown_sync()
on a timer on which you've never called timer_setup()?

