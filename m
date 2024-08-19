Return-Path: <netdev+bounces-119685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB3595694E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32F1283969
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E1515DBB2;
	Mon, 19 Aug 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqnF5jHH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70517C7C;
	Mon, 19 Aug 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067071; cv=none; b=CqsEkVwsFJqJhSR3WF3ew0AQKBC7m7w5WncXu4M4JjOXiXu8CPc6hKlP2LFsl/v1safdO83wjzQ+cx+MBod7OzuefK30PeVPAhghCG3tR/uneuAj4AtWCdEEWMVkS3hFt5fapbEFP+MgFgOWc9Q/wTd6aWLVQb6+x8SvAnTvP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067071; c=relaxed/simple;
	bh=pDtB7WH7jC4shgxlrBCghTofnpeeio7Z2/u0qf4ZM9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3Bd5HLu/L4z4EiWxXpecKJkjv9BhhUrYPGBjeLR4/pFtjVxo5iv8cF3azAb87203z4L6G5IsIleM1sBDvWvVlzqgWHDoLXCrYVzY5fpLJNWuOH0j4LKcLUoLGQxYD07BNFm1osr0QuHuUTkfiwcYsATbZoiB+DURcRb2PPRJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqnF5jHH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aac70e30dso449795566b.1;
        Mon, 19 Aug 2024 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724067068; x=1724671868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItBsaYaUYukKcs9mT8FxS4IiWnVvJXNxy3plA4auI4E=;
        b=gqnF5jHHOwQAKgfSt62duYOAmGacpDbPb9gNAYvFtKoz4M/ZkhLAfOe7nT2yhdhKkb
         8ucGLMG0jqiCa7rhtxV/Vm6iuJY4NUwINn2qVgRboMKczQYPWwgstiwCEI/T28SmMnoR
         DhstR380HgDPSyoiQw1LnGWTQnxmrlIzxQSrveLvy4/Qohyz7eR4axULwm72+1C7bSx+
         aenX3P0o04TC7bT7FWwky3t6wRgVi8M0ftvpuXjmQSShmG9eFLHY71ON4yCNSNSrH0qO
         0oxDWh/MEvWi1ryQUrbrJyJq39R400FNlp0VnpzuKQ/uojMoM9wfMe9h0+aFua1Hc8Fi
         L8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067068; x=1724671868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItBsaYaUYukKcs9mT8FxS4IiWnVvJXNxy3plA4auI4E=;
        b=mChU47+8UPjMkBoNOq8qPIUNdodm2KRCKci8ttsGoSuv81rap7wQoF3lUv/6eC1hnH
         UhwmWfqTD85LOxJkbGe6c1rEA+OxoQpRbGFgzV2UosYwxSxacHKhqeQkg1p+A/Pvd7iK
         +X+9n0xbEyl6Qc3sBoPKFhSu51ctDKZPtO5TZkroBZa/mmTcKGbrbypatID9a43dwRBT
         B3YHIITJsqq3/xVwe+XRu7yxzbPrymw4i+ppumGHJgsOs+bAbVIO/yIXm1JhpaiiA2Lt
         hjApzZ8D1wstAv3Io/U3GNR/Ixe8mdEt3Zo/hRIEIoe/eMWLTsqBxSIAt77iAsfNeQYc
         +aOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUByQupZbYPmrOOPyPyThVneyEFgq/0vovPZn6eGaYQVIhS6246jVF70uZgbhDeCuaJDBIYbwKnchPs6EY=@vger.kernel.org, AJvYcCUSws4fmKKdiqsyZqMGuBB2FuzYaL20gSPa9YMzwnm6RQLEddGI0wx86LDAc6n3cX0HHISiU7mV@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/DYpE5RgCQQ4XxmlzIUFBjjRroH4Db/fwS+aWJt2sofArezR
	CZrbYbIeKk63f+2WjeV7iYHqk67+z/cKkwEKIiqB+2roFBX6gL3e
X-Google-Smtp-Source: AGHT+IFw0X4PENWMjfNydLGal6c4vATRAbYzFtb8Tgkf8ezeSAUXVubLDH1teEvaB26Birvnfb9xyA==
X-Received: by 2002:a17:907:f794:b0:a72:aeff:dfed with SMTP id a640c23a62f3a-a83929f124bmr748465066b.53.1724067067348;
        Mon, 19 Aug 2024 04:31:07 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934564sm619890466b.126.2024.08.19.04.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:31:06 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:31:04 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com
Subject: Re: [PATCH net-next v3 3/7] net: stmmac: refactor FPE verification
 processe
Message-ID: <20240819113104.u2v5s4tdfac2kqbj@skbuf>
References: <cover.1724051326.git.0x1207@gmail.com>
 <c9da02a6376f1e85a11631a5ccf47dbdf24c7618.1724051326.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9da02a6376f1e85a11631a5ccf47dbdf24c7618.1724051326.git.0x1207@gmail.com>

Interesting spelling of "process" in the title.

On Mon, Aug 19, 2024 at 03:25:16PM +0800, Furong Xu wrote:
> Drop driver defined stmmac_fpe_state, and switch to common
> ethtool_mm_verify_status for local TX verification status.
> 
> Local side and remote side verification processes are completely
> independent. There is no reason at all to keep a local state and
> a remote state.
> 
> Add a spinlock to avoid races among ISR, workqueue, link update
> and register configuration.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  20 +--
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 169 +++++++++---------
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   6 -
>  3 files changed, 97 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 2c2181febb39..cb54f65753b2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -146,14 +146,6 @@ struct stmmac_channel {
>  	u32 index;
>  };
>  
> -/* FPE link state */
> -enum stmmac_fpe_state {
> -	FPE_STATE_OFF = 0,
> -	FPE_STATE_CAPABLE = 1,
> -	FPE_STATE_ENTERING_ON = 2,
> -	FPE_STATE_ON = 3,
> -};
> -
>  /* FPE link-partner hand-shaking mPacket type */
>  enum stmmac_mpacket_type {
>  	MPACKET_VERIFY = 0,
> @@ -166,10 +158,10 @@ enum stmmac_fpe_task_state_t {
>  };
>  
>  struct stmmac_fpe_cfg {
> -	bool enable;				/* FPE enable */
> -	bool hs_enable;				/* FPE handshake enable */
> -	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
> -	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> +	bool pmac_enabled;			/* see ethtool_mm_state */
> +	bool verify_enabled;			/* see ethtool_mm_state */
> +	u32 verify_time;			/* see ethtool_mm_state */
> +	enum ethtool_mm_verify_status status;
>  	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
>  };
>  
> @@ -366,6 +358,10 @@ struct stmmac_priv {
>  	struct workqueue_struct *wq;
>  	struct work_struct service_task;
>  
> +	/* Serialize access to MAC Merge state between ethtool requests
> +	 * and link state updates.
> +	 */
> +	spinlock_t mm_lock;

Given that it protects members of struct stmmac_fpe_cfg, would it make
sense for it to be placed in that structure instead? fpe_cfg->lock.

>  	struct stmmac_fpe_cfg fpe_cfg;
>  
>  	/* Workqueue for handling FPE hand-shaking */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3072ad33b105..628354f60c54 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -969,17 +969,21 @@ static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
>  static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
>  {
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> -	bool *hs_enable = &fpe_cfg->hs_enable;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->mm_lock, flags);
>  
> -	if (is_up && *hs_enable) {
> +	if (!fpe_cfg->pmac_enabled)
> +		goto __unlock_out;
> +
> +	if (is_up && fpe_cfg->verify_enabled)
>  		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
>  					MPACKET_VERIFY);
> -	} else {
> -		*lo_state = FPE_STATE_OFF;
> -		*lp_state = FPE_STATE_OFF;
> -	}
> +	else
> +		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +
> +__unlock_out:
> +	spin_unlock_irqrestore(&priv->mm_lock, flags);
>  }
>  
>  static void stmmac_mac_link_down(struct phylink_config *config,
> @@ -3533,9 +3537,19 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
>  
>  	stmmac_set_hw_vlan_mode(priv, priv->hw);
>  
> -	if (priv->dma_cap.fpesel)
> +	if (priv->dma_cap.fpesel) {
>  		stmmac_fpe_start_wq(priv);
>  
> +		/* phylink and irq are not enabled yet,
> +		 * mm_lock is unnecessary here.
> +		 */
> +		stmmac_fpe_configure(priv, priv->ioaddr,
> +				     &priv->fpe_cfg,
> +				     priv->plat->tx_queues_to_use,
> +				     priv->plat->rx_queues_to_use,
> +				     false);

This is probably unintended, but &priv->fpe_cfg has just been zeroed out
earlier by __stmmac_open().

> +	}
> +
>  	return 0;
>  }
>  
> @@ -3978,6 +3992,12 @@ static int __stmmac_open(struct net_device *dev,
>  		}
>  	}
>  
> +	/* phylink and irq are not enabled yet, mm_lock is unnecessary here */
> +	priv->fpe_cfg.pmac_enabled = false;
> +	priv->fpe_cfg.verify_time = 128; /* ethtool_mm_state.max_verify_time */
> +	priv->fpe_cfg.verify_enabled = false;
> +	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +

stmmac_set_mm() can be called before __stmmac_open(), which is entirely
legal. You'd be overwriting the configuration made by the user in that
case. Same is true for the snippet below from stmmac_release().
Personally I think work items should be put on the fpe_wq only when
netif_running() and during __stmmac_open(), but configuration changes
should also be accepted while down. Maybe this also implies that during
stmmac_get_mm() and stmmac_set_mm() it must temporarily use
pm_runtime_resume_and_get() and pm_runtime_put(), and get whatever
clocks are necessary for the registers to be accessible.

>  	ret = stmmac_hw_setup(dev, true);
>  	if (ret < 0) {
>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> @@ -4091,11 +4111,19 @@ static int stmmac_release(struct net_device *dev)
>  
>  	stmmac_release_ptp(priv);
>  
> -	pm_runtime_put(priv->device);
> -
> -	if (priv->dma_cap.fpesel)
> +	if (priv->dma_cap.fpesel) {
>  		stmmac_fpe_stop_wq(priv);
>  
> +		/* phylink and irq have already disabled,
> +		 * mm_lock is unnecessary here.
> +		 */
> +		priv->fpe_cfg.pmac_enabled = false;
> +		priv->fpe_cfg.verify_enabled = false;
> +		priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +	}
> +
> +	pm_runtime_put(priv->device);
> +
>  	return 0;
>  }
>  
> @@ -5979,44 +6007,34 @@ static int stmmac_set_features(struct net_device *netdev,
>  static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
>  {
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> -	bool *hs_enable = &fpe_cfg->hs_enable;
>  
> -	if (status == FPE_EVENT_UNKNOWN || !*hs_enable)
> -		return;
> +	spin_lock(&priv->mm_lock);
>  
> -	/* If LP has sent verify mPacket, LP is FPE capable */
> -	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER) {
> -		if (*lp_state < FPE_STATE_CAPABLE)
> -			*lp_state = FPE_STATE_CAPABLE;
> +	if (!fpe_cfg->pmac_enabled || status == FPE_EVENT_UNKNOWN)
> +		goto __unlock_out;
>  
> -		/* If user has requested FPE enable, quickly response */
> -		if (*hs_enable)
> -			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> -						fpe_cfg,
> -						MPACKET_RESPONSE);
> -	}
> +	/* LP has sent verify mPacket */
> +	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER)
> +		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> +					MPACKET_RESPONSE);
>  
> -	/* If Local has sent verify mPacket, Local is FPE capable */
> -	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER) {
> -		if (*lo_state < FPE_STATE_CAPABLE)
> -			*lo_state = FPE_STATE_CAPABLE;
> -	}
> +	/* Local has sent verify mPacket */
> +	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER &&
> +	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
> +		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
>  
> -	/* If LP has sent response mPacket, LP is entering FPE ON */
> +	/* LP has sent response mPacket */
>  	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP)
> -		*lp_state = FPE_STATE_ENTERING_ON;
> -
> -	/* If Local has sent response mPacket, Local is entering FPE ON */
> -	if ((status & FPE_EVENT_TRSP) == FPE_EVENT_TRSP)
> -		*lo_state = FPE_STATE_ENTERING_ON;
> +		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
>  
>  	if (!test_bit(__FPE_REMOVING, &priv->fpe_task_state) &&
>  	    !test_and_set_bit(__FPE_TASK_SCHED, &priv->fpe_task_state) &&
>  	    priv->fpe_wq) {
>  		queue_work(priv->fpe_wq, &priv->fpe_task);
>  	}
> +
> +__unlock_out:
> +	spin_unlock(&priv->mm_lock);
>  }
>  
>  static void stmmac_common_interrupt(struct stmmac_priv *priv)
> @@ -7372,50 +7390,47 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
>  	return ret;
>  }
>  
> -#define SEND_VERIFY_MPAKCET_FMT "Send Verify mPacket lo_state=%d lp_state=%d\n"
> -static void stmmac_fpe_lp_task(struct work_struct *work)
> +static void stmmac_fpe_verify_task(struct work_struct *work)
>  {
>  	struct stmmac_priv *priv = container_of(work, struct stmmac_priv,
>  						fpe_task);
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> -	bool *hs_enable = &fpe_cfg->hs_enable;
> -	bool *enable = &fpe_cfg->enable;
> -	int retries = 20;
> -
> -	while (retries-- > 0) {
> -		/* Bail out immediately if FPE handshake is OFF */
> -		if (*lo_state == FPE_STATE_OFF || !*hs_enable)
> +	int verify_limit = 3; /* defined by 802.3 */
> +	unsigned long flags;
> +
> +	while (1) {
> +		msleep(fpe_cfg->verify_time);
> +

Sleep for 1 ms without having done anything prior?

> +		if (!netif_running(priv->dev))
>  			break;
>  
> -		if (*lo_state == FPE_STATE_ENTERING_ON &&
> -		    *lp_state == FPE_STATE_ENTERING_ON) {
> -			stmmac_fpe_configure(priv, priv->ioaddr,
> -					     fpe_cfg,
> -					     priv->plat->tx_queues_to_use,
> -					     priv->plat->rx_queues_to_use,
> -					     *enable);
> +		spin_lock_irqsave(&priv->mm_lock, flags);

Thanks for reconsidering the locking.

Unless I'm missing something, it would be good to read fpe_cfg->verify_time
also under the lock. You can save it to a temporary local variable, then
release the lock and go to sleep (waiting for the IRQ to change the FPE
state).

Note that in between fpe_task sleeps, the user could in theory also
change the FPE configuration. I think that in stmmac_set_mm() you should
wait for the fpe_task that's currently in progress to finish, in order
not to change its state from one spin_lock_irqsave() to another.
flush_workqueue() should help with this - but needs to be done without
holding the mm_lock.

>  
> -			netdev_info(priv->dev, "configured FPE\n");
> +		if (fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_DISABLED ||
> +		    fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
> +		    !fpe_cfg->pmac_enabled || !fpe_cfg->verify_enabled) {
> +			spin_unlock_irqrestore(&priv->mm_lock, flags);
> +			break;
> +		}
>  
> -			*lo_state = FPE_STATE_ON;
> -			*lp_state = FPE_STATE_ON;
> -			netdev_info(priv->dev, "!!! BOTH FPE stations ON\n");
> +		if (verify_limit == 0) {
> +			fpe_cfg->verify_enabled = false;
> +			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
> +			stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> +					     priv->plat->tx_queues_to_use,
> +					     priv->plat->rx_queues_to_use,
> +					     false);
> +			spin_unlock_irqrestore(&priv->mm_lock, flags);
>  			break;
>  		}
>  
> -		if ((*lo_state == FPE_STATE_CAPABLE ||
> -		     *lo_state == FPE_STATE_ENTERING_ON) &&
> -		     *lp_state != FPE_STATE_ON) {
> -			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
> -				    *lo_state, *lp_state);
> -			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> -						fpe_cfg,
> +		if (fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
> +			stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
>  						MPACKET_VERIFY);
> -		}
> -		/* Sleep then retry */
> -		msleep(500);
> +
> +		spin_unlock_irqrestore(&priv->mm_lock, flags);
> +
> +		verify_limit--;
>  	}
>  
>  	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);

