Return-Path: <netdev+bounces-125555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B661796DAE0
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D5CB22CB0
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3060B19D065;
	Thu,  5 Sep 2024 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKkY1iW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A1145B10;
	Thu,  5 Sep 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544489; cv=none; b=fO6AZ505gjAWnsAKFXNBoLROy8eTn7ivJYJb6ng68cbReQmFQ+aG9uRdcxNTOsJiEOrFUUR1mBaCCzcHTDBg5ODLc2A4oPoojvXs+d2L4iQfawWv/5DcqxmkC3AtZj/hFHvzpjEgHEe3TfU3/fbV1G/zm5PQbO3HOOBg7Jd12TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544489; c=relaxed/simple;
	bh=tbZRLNLVPF3hBU2dt0hrZZ8ZhikmiYzlEI3zhF2oELo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHhhHQv9a9C/Dqg6v2uxPT9XwowZ0/64AiIAMNY9EdZpV3FkhE8W2wITaGbq9NrzhGqK4T+feemuB7Fm4gFnw+LhHE3DDsPOb4bjrm4A7k7gbAj0+h7cvQmDrZ/T2jWSfN2+DLaLuUz5gGlLM+1MO39K2dSJ1ahNW4X8PNJ+JjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKkY1iW9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53652c3bffdso106198e87.1;
        Thu, 05 Sep 2024 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725544485; x=1726149285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j72SRMwZbgesZJhHX6WjWoZslyaQOKCacKBuJblmEuE=;
        b=WKkY1iW9szgWTh55vxzyJb7erqjENrmFUZUM+OhGSLGe7Gu1f5TjkrLO96W7Q2WqyZ
         8laAu7C++hhAK6/FuVFFZk7o+/0mWZFASokgQIbCzc6g7ppILqM9YE6TtJuFreBxfz9D
         J48dizNnyx5ZMoN8hYbrDnnXpblmPZQ4LAoR2ndgsDTstS8+LgawG9UnzwcHEieUPhj4
         CII4K6XM8ctZ+YJVo5SeKwQ6tKTq/wjH3RiCFaLv4UPwRA88x7W/6DW4omuqDMlmD8Sh
         ZkOC468AgZrbtLm3mdfTdghYRwqGSyS4gqqgRzaGAoZbPfjKH028TIdhWDTvfF7K92Go
         OrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725544485; x=1726149285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j72SRMwZbgesZJhHX6WjWoZslyaQOKCacKBuJblmEuE=;
        b=jFgrcaVzYySN9xlGxn/nRFiM26ZGviY/MUJpfYZUhYlYuf4PhdVvruoyGefD0WTYTV
         9q7YMAhr0GT89L4Ge19hZTQNxJw++bjaRnwzD/RPIeeP8T0HBoftS7QhNwDgCOlHwqMK
         kvIujJZJohrgxOLX0OoM8F4CE7Tq33eNl4T+6lAOBlpcTOY4qoHFoipXgQeDFHhd0F2m
         OT3MVhsiSQeLBShNNDp5HPZ9xUpc3fYRKOWyWVgNRBXK3FbaQUqynIpdYIqopPK694ui
         nTwVzNfkx2X2xhVcLOFAK08Z29GdHoPImYcUqaDlKW39rflDzV5oqdVkezCDLcXev4lf
         eoPg==
X-Forwarded-Encrypted: i=1; AJvYcCVsnm86+Z8pTHqr8XZ3MSyDioch53tQLFoo5qIqm9pYJZdI51e2q7ivETLLHfNQK/VB8dpUBJVA@vger.kernel.org, AJvYcCWrNXwCYst9YJdgTEyoAaKs8WgCvpLGfv4qdZ/7qbEF8C3C1gZTSl6dbV7mq5cozmGAj+b98oSuRPxvKXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfR2rGKfAytbxsGNEkbvBka9wlscBVFakr0p1GX3PP6w0K8W9c
	iAjvGbXFN6CZQqToTfwBfTKdqswd86oke8CTV2MC6XASrUKCp+h/otGsUfw2qnw=
X-Google-Smtp-Source: AGHT+IEGHceBUm9ge3LWUoJ0fD0Z2UOrlf5AZ1gk7JTSUBOffG9cHqN+jDgXYhMUztM4Iwbd35KQOw==
X-Received: by 2002:ac2:5695:0:b0:536:54df:c000 with SMTP id 2adb3069b0e04-53654dfc031mr481122e87.8.1725544484197;
        Thu, 05 Sep 2024 06:54:44 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a7c662bcdsm33568166b.34.2024.09.05.06.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:54:43 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:54:40 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
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
Subject: Re: [PATCH net-next v8 3/7] net: stmmac: refactor FPE verification
 process
Message-ID: <20240905135440.hcgbva7fzic2x4ps@skbuf>
References: <cover.1725518135.git.0x1207@gmail.com>
 <0b72fd0463b662796fd3eaa996211f1a5d0a4341.1725518135.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b72fd0463b662796fd3eaa996211f1a5d0a4341.1725518135.git.0x1207@gmail.com>

On Thu, Sep 05, 2024 at 03:02:24PM +0800, Furong Xu wrote:
> +void stmmac_fpe_apply(struct stmmac_priv *priv)
> +{
> +	struct ethtool_mm_state *state = &priv->fpe_cfg.state;
> +	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> +
> +	/* If verification is disabled, configure FPE right away.
> +	 * Otherwise let the timer code do it.
> +	 */
> +	if (!state->verify_enabled) {
> +		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> +				     priv->plat->tx_queues_to_use,
> +				     priv->plat->rx_queues_to_use,
> +				     state->tx_enabled,
> +				     state->pmac_enabled);
> +	} else {
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
> +		fpe_cfg->verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
> +
> +		if (netif_device_present(priv->dev) && netif_running(priv->dev))
> +			stmmac_fpe_verify_timer_arm(fpe_cfg);
> +	}
>  }

In the cover letter, you say:

  2. check netif_running() to guarantee synchronization rules between
  mod_timer() and timer_delete_sync()

[ by the way, it would be nice if you could list the changes in
  individual patches as well ]

but I guess this helps with something other than what you say it helps
with.

netif_running() essentially checks that __dev_open() has been called,
aka "ip link set dev eth0 up". And I don't see the ethtool_ops :: begin()
implemented by the driver any longer, so I think you've done this in
order to accept stmmac_set_mm() calls even before the netdev has been
brought operationally up. Okay.

As for netif_device_present(), I don't know, maybe the intention was to
suppress stmmac_set_mm() calls made after stmmac_suspend(). But
ethnl_ops_begin() has its own netif_device_present() call, so I'm not
sure why it is needed - they should already be suppressed.

But in v7, I was thinking about the concurrency issues here:

static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
			 struct netlink_ext_ack *extack)
{
	/* Wait for the verification that's currently in progress to finish */
	del_timer_sync(&fpe_cfg->verify_timer);

								<- Concurrent code can run here:
								   stmmac_fpe_link_state_handle(),
								   called from phylink_resolve()
								   workqueue context, rtnl_lock()
								   not held.

	spin_lock_irqsave(&fpe_cfg->lock, flags);
	stmmac_fpe_apply(priv);
	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
}

static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
{
	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
	unsigned long flags;

	timer_delete_sync(&fpe_cfg->verify_timer);

								<- Concurrent code can run here:
								   stmmac_set_mm()

	spin_lock_irqsave(&fpe_cfg->lock, flags);

	if (is_up && fpe_cfg->state.pmac_enabled) {
		/* VERIFY process requires pmac enabled when NIC comes up */
		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
				     priv->plat->tx_queues_to_use,
				     priv->plat->rx_queues_to_use,
				     false, true);

		/* New link => maybe new partner => new verification process */
		stmmac_fpe_apply(priv);
	} else {
		/* No link => turn off EFPE */
		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
				     priv->plat->tx_queues_to_use,
				     priv->plat->rx_queues_to_use,
				     false, false);
	}

	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
}

[ oh btw, you forgot to replace the del_timer_sync() instance from
  stmmac_set_mm() to timer_delete_sync() ]

Because the timer can be restarted right after the timer_delete_sync()
call, this is a half-baked implementation.

I think at the end of the day, we need to ask ourselves: what is the
timer_delete_sync() call even supposed to accomplish? What if the verify
timer is allowed to run concurrently with us changing the settings?

Well, for example, if it runs concurrently with
stmmac_fpe_link_state_handle(is_down==false), it will not learn that the
link is down, it will send an MPACKET_VERIFY, get no response, and fail.
So, not very bad.

And the other way around: stmmac_set_mm() stops the verify timer, but
the link comes up, the timer is armed with the old settings, it does
whatever (succeeds, fails), and only afterwards does stmmac_set_mm()
manage to grab &fpe_cfg->lock, change the settings to the new ones, and
re-trigger the verify timer once again, if needed.

So bottom line, I think timer_delete_sync() is to avoid some useless
work, but otherwise, it is not critical to have it. The choice is
between removing the timer_delete_sync() calls from these 2 functions
altogether, or implementing an actually effective mechanism to stop the
timer for a while.

I _think_ that the simplest way to stop it is to hold one more lock for
the verify_timer when we call timer_delete_sync() and stmmac_fpe_verify_timer_arm(),
lock which _is_ IRQ-safe, unlike &fpe_cfg->lock.

static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
			 struct netlink_ext_ack *extack)
{
	spin_lock(&fpe_cfg->verify_timer_lock);

	timer_delete_sync(&fpe_cfg->verify_timer);

	spin_lock_irqsave(&fpe_cfg->lock, flags);
	stmmac_fpe_apply(priv);
	spin_unlock_irqrestore(&fpe_cfg->lock, flags);

	spin_unlock(&fpe_cfg->verify_timer_lock);
}

static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
{
	spin_lock(&fpe_cfg->verify_timer_lock);

	timer_delete_sync(&fpe_cfg->verify_timer);

	spin_lock_irqsave(&fpe_cfg->lock, flags);

	if (is_up && fpe_cfg->state.pmac_enabled) {
		/* VERIFY process requires pmac enabled when NIC comes up */
		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
				     priv->plat->tx_queues_to_use,
				     priv->plat->rx_queues_to_use,
				     false, true);

		/* New link => maybe new partner => new verification process */
		stmmac_fpe_apply(priv);
	} else {
		/* No link => turn off EFPE */
		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
				     priv->plat->tx_queues_to_use,
				     priv->plat->rx_queues_to_use,
				     false, false);
	}

	spin_unlock_irqrestore(&fpe_cfg->lock, flags);

	spin_unlock(&fpe_cfg->verify_timer_lock);
}

Looking at the __timer_delete_sync() implementation, I don't think
verify_timer_lock needs to be sleepable and hence a mutex (except on
PREEMPT_RT where spinlocks are sleepable no matter what you do).

But I think the implementation would be simpler without
timer_delete_sync() in these 2 functions, and this overengineered
mechanism.


I would expect a comment in stmmac_release() here:

	if (priv->dma_cap.fpesel)
		timer_delete_sync(&priv->fpe_cfg.verify_timer);

that timer restarts are not possible, because we have rtnl_lock() held
and a concurrent stmmac_set_mm() cannot run now, and the earlier
phylink_stop() has also ensured stmmac_fpe_link_state_handle() cannot
run any longer.

Similarly, I would like to see an explanation in the form of a comment
for why timer restarts are not possible after the same pattern in
stmmac_suspend(). The explanation is different there, I think.

