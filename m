Return-Path: <netdev+bounces-125926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B496F46B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94303285DEE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51821CB15C;
	Fri,  6 Sep 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC8OUZ6t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B31552FA;
	Fri,  6 Sep 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626476; cv=none; b=pcfBv/3GYjINdJvYIWn/sqDabKBsXc81G/0lkOLyQeS+U4kAvvNM6WhU2Fd9Geh0zmD14Gsya3zF9CnjTCURcgf/FhlvtwBTPA9l3Atjrj+bDTXC8YWGD+F3cYdtcNW9plutbAHbPUaVcyieMvdTG2Uq1sDiyvXYKqiPnEXNjt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626476; c=relaxed/simple;
	bh=MlzVJ0WFLr5aBmRTclpKK7wB4bruP1O4+ahLBwNme6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0dds4Lp3R/afTVSjZuXcz4nf0iYjQfEFat/jLtyku9OrTPeAaTb/fH5cd8GEdUXo3EG81JWyYNY1VL7gcVBVv1CHlAM9wqNGZpYlUaBQ4WH6ctqEcC6d8thgjx0YBd+iTcoG4QimAw2nqCx1cr2TIiTHh46YzFmCCflhxvhNGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC8OUZ6t; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8a92e8c840so5400666b.2;
        Fri, 06 Sep 2024 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725626473; x=1726231273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2oDWupgCB0EJEDFj7Qxwn+hUjKM6noFGnO8rTsV9Zk=;
        b=XC8OUZ6tSAgwcwJVIXwq9L2c0dsU7e53L0JnkHAgWdSGjzL20ngbngB9aK+Fbf0qvE
         I9aVMiFboK838SaXtXAHWCD3iRkn/8fbjxAjfsUK7ubmQ1Ay3KgtyajGbtClsw7eeRtx
         Wjdua4vVtFe8+KrWuLUJ9L+gBUlPI5mI0buQLlEh/Bf1prZA+W473iiN8g1MgEZW/i3m
         owlXprB7J9n/XQ9S6O6H+pk/KxROymWEcRHB2AoT52AQXU9Y4bS8IIo44TJQsk7BD+Zx
         WhiYr4h6xIB0OqTtD4XnN8HNL+MhiutBF378YDQm7hIwFwCNyneVU2h8qW8OVF3oj+HP
         XTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725626473; x=1726231273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2oDWupgCB0EJEDFj7Qxwn+hUjKM6noFGnO8rTsV9Zk=;
        b=j8uRlXGJ8H0dTzAw/7uQ47WxvdBoqntSu74NzGih9tTD4uAPw/CqKSpCHImUfHmkPs
         1lMnLJMuRyU5pJn5dZPVx1DeLtnAhw3R6FqSRSjSR93VHlJEDT0s5Ql5EgGbCLZz6y/F
         q+I3qpVoOlbTTQwX6BaHw5Kj/8j70yBFTdrUjxJ7IwmLVriEX1JtA85O/iAzZBIK8/YO
         +AS7Fvlqvm/OqOhZDdN788busJPyHfmZUkNlfv2ZEbBwXP1umH1rU7DchIbeBjJmuMTP
         AlZaneMVvMy2LapDgLSJge6Hl4nB5bUp1ecG78fN39HkkKv/nBRSBrZb+o514USwIWUy
         b1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUHcTKVB9jmIOUTsjuetw2rH9HdUeuky34Tzf/qAIk1IPYYJIplOVD6GhrhvroGne98swmGfD5OmPTx0M8=@vger.kernel.org, AJvYcCXkY6devz4cspFwyVmNK6KZaOgawwm573mpI4VTCSV540HdXiH2THKQxpUNSMc2ZqMARRD/+Ukw@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdGUkCqXofEs/p2cHXi5C3gj0xzpedBNpfdu42VB+jKbJ1HWn
	BX8tB1064df+5ncQ6ZtPT52+d0LibKsp4Cxpr4nztQcbsGw5N0Yx
X-Google-Smtp-Source: AGHT+IFM2B8brZFs+Lrn+MmgYrIC5y+ofetm/PeWuFXvo6OEHyA10imDyPZrf3L0Ib3cEXormlIhXw==
X-Received: by 2002:a17:907:971d:b0:a80:a23e:fbf9 with SMTP id a640c23a62f3a-a8a88845be5mr83712366b.6.1725626472582;
        Fri, 06 Sep 2024 05:41:12 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8aeacb588bsm54664566b.78.2024.09.06.05.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:41:11 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:41:09 +0300
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
Message-ID: <20240906124109.s4p7lgrycfgr62vp@skbuf>
References: <cover.1725597121.git.0x1207@gmail.com>
 <cover.1725597121.git.0x1207@gmail.com>
 <13f5833e52a47895864db726f090f323ec691c62.1725597121.git.0x1207@gmail.com>
 <13f5833e52a47895864db726f090f323ec691c62.1725597121.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13f5833e52a47895864db726f090f323ec691c62.1725597121.git.0x1207@gmail.com>
 <13f5833e52a47895864db726f090f323ec691c62.1725597121.git.0x1207@gmail.com>

On Fri, Sep 06, 2024 at 12:55:58PM +0800, Furong Xu wrote:
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -969,17 +969,30 @@ static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
>  static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
>  {
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> -	bool *hs_enable = &fpe_cfg->hs_enable;
> +	unsigned long flags;
>  
> -	if (is_up && *hs_enable) {
> -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> -					MPACKET_VERIFY);
> +	timer_shutdown_sync(&fpe_cfg->verify_timer);
>  }
>  
>  static void stmmac_mac_link_down(struct phylink_config *config,
> @@ -4091,10 +4068,10 @@ static int stmmac_release(struct net_device *dev)
>  
>  	stmmac_release_ptp(priv);
>  
> -	pm_runtime_put(priv->device);
> -
>  	if (priv->dma_cap.fpesel)
> -		stmmac_fpe_stop_wq(priv);
> +		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
> +
> +	pm_runtime_put(priv->device);
>  
>  	return 0;
>  }
> @@ -7372,53 +7334,88 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
> +static void stmmac_fpe_verify_timer_arm(struct stmmac_fpe_cfg *fpe_cfg)
> +{
> +	if (fpe_cfg->pmac_enabled && fpe_cfg->tx_enabled &&
> +	    fpe_cfg->verify_enabled &&
> +	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
> +	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
> +		timer_setup(&fpe_cfg->verify_timer, stmmac_fpe_verify_timer, 0);
> +		mod_timer(&fpe_cfg->verify_timer, jiffies);
> +	}
> +}
> @@ -7875,15 +7874,8 @@ int stmmac_suspend(struct device *dev)
>  	}
>  	rtnl_unlock();
>  
> -	if (priv->dma_cap.fpesel) {
> -		/* Disable FPE */
> -		stmmac_fpe_configure(priv, priv->ioaddr,
> -				     &priv->fpe_cfg,
> -				     priv->plat->tx_queues_to_use,
> -				     priv->plat->rx_queues_to_use, false);
> -
> -		stmmac_fpe_stop_wq(priv);
> -	}
> +	if (priv->dma_cap.fpesel)
> +		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
>  
>  	priv->speed = SPEED_UNKNOWN;
>  	return 0;

Calling timer_setup() after timer_shutdown_sync() is a bit unconventional,
but I don't see why it shouldn't work.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

