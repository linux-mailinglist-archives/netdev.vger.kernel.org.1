Return-Path: <netdev+bounces-120148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9129958717
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AE9282810
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E19A18FC8F;
	Tue, 20 Aug 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doOJNdrv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A3E1CAAC;
	Tue, 20 Aug 2024 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157305; cv=none; b=WGBbqiA+MV02iDrJLJfVJUHyObxrk2vpe+rQkLfFrVCBqpPD0JiDIlb2EXljc2QRX1KdlNMRxaWSoOdS0nU6djTOMqNjl+RL/P+VVwzA/79XAcX3ucwmXK1HVP7BXVRXhO8EI4bJzrjDH7s8eivzpxaXvL3NP3fKkl/qpbMBt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157305; c=relaxed/simple;
	bh=OFFbWVomErqVDJ1QlW0KdifzN+X4cNUoTYjA6waeA8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dH3puOOl3v430lLVLdc+n4Yg/OYOTgo3qHMfJHYtwZWL6Jaqsp/xDwTHOBervrcxCkri9p1QC59LUO4eOhNwA+I0Q3OPVHjiVDr5Q2R5c1LnbtgdqJrSMggk+ZzvXkTQvydMJAiHF5NjMha5krNnb+9lY48gHOl1201u2/euyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doOJNdrv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso4450023a12.0;
        Tue, 20 Aug 2024 05:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724157301; x=1724762101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VHGZt1R2aqOcWKdCxk8PVxhDicABM+R1yiEYakU1s0=;
        b=doOJNdrv//J19K0hfDLTGnbHVyt2BTsDkjEaZ+d+4X3W6gF/ud8hZFRVngiYx3nqcK
         AaKQxMFNmDqlmzHQsm27J4j2++w7d6r3V7UcNU5C5lztjGh3pCjezAyLrZFUwF9GmBio
         KvLoA7tm80WIUNMh/ohTslkco+cjZHGXqT4nl0lQ2LyTl3j9Zzc2P9dVZkXLIll2VfvO
         3/u0yImOwuIv0CmtCbifNnSzDJSkM356qhNCjOI5ahqxCCczQPbUCzD8V4luoEGfENwb
         L3rjhU8aM69DsnSIUsW2pGOhKze8c1iDahd3ob6y74YWnnWbyS+xJKnXsYL60xhJsjn3
         O+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724157301; x=1724762101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VHGZt1R2aqOcWKdCxk8PVxhDicABM+R1yiEYakU1s0=;
        b=i49nd4DUfebACR6M+DZjqVxCCdT4we2hNcyk60KRjIDVVamgUqN8+0rc/I+XTqDEC2
         zjZ5fSj0Poe+MbEPz4MqoGQf/apJjcghOEVBfmRxjChG3elZqb5ngjGCRyJFVD/0mzv1
         qClmFrWDfD5XboDJa5wsp8BlbtX0iuh1rFDUZSHBwRNw+8g1kVsDXqfYrwkh2oAmbLLA
         OKZMHRCOpKeKV2+mKSfoiELc7jHGyhn4EqXlQ825qgN0QUIQcLDlFG0yav14Kbqid9xZ
         etrO/j0TZsSL3ZBHHXLvTcFvDEGffxyhQPuMOkdQza6k5Yoi53Ki7D8E6P+oVcJdtfGD
         lS7A==
X-Forwarded-Encrypted: i=1; AJvYcCUteTSVan8kZAIOuu8U6uD35PtL8SZyS6EZ6I8iXXflJO6i8nWMZCv/PzFwbjPFZ6cG50pnF426vf3fx1o=@vger.kernel.org, AJvYcCXDvHBvsWGr9GdbKauZToG1SP0n+h+5Jl4ypye4HmGKhSyHcEkGI/GXbu5tPZSRmTHJ/VAVa/ie@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5fsmMUp7oCkKSQ0zMUo9jENmCnaR9AdWbz2UfdDF7H8B34br
	nUYIeAamNGqvyQ1yqWCDohwS8Tg1hlqYWHxIOiKvJf57A4lntyHU
X-Google-Smtp-Source: AGHT+IF6uYBW9R6jzN702jDQ9saKget2CSs108Txn3oN6qQ6VWBBn4r2ghfXbAlhLU9xpNVAIt0uWw==
X-Received: by 2002:a05:6402:11c9:b0:5be:ffe1:6539 with SMTP id 4fb4d7f45d1cf-5beffe1666fmr3978232a12.24.1724157300170;
        Tue, 20 Aug 2024 05:35:00 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bec82e5eacsm5909592a12.19.2024.08.20.05.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 05:34:59 -0700 (PDT)
Date: Tue, 20 Aug 2024 15:34:56 +0300
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
Subject: Re: [PATCH net-next v4 3/7] net: stmmac: refactor FPE verification
 process
Message-ID: <20240820123456.qbt4emjdjg5pouym@skbuf>
References: <cover.1724145786.git.0x1207@gmail.com>
 <bc4940c244c7e261bb00c2f93e216e9d7a925ba6.1724145786.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n5bc2hehdh25qze3"
Content-Disposition: inline
In-Reply-To: <bc4940c244c7e261bb00c2f93e216e9d7a925ba6.1724145786.git.0x1207@gmail.com>


--n5bc2hehdh25qze3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2024 at 05:38:31PM +0800, Furong Xu wrote:
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
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  21 +--
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 172 ++++++++++--------
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   6 -
>  3 files changed, 102 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 458d6b16ce21..407b59f2783f 100644
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
> @@ -166,11 +158,16 @@ enum stmmac_fpe_task_state_t {
>  };
>  
>  struct stmmac_fpe_cfg {
> -	bool enable;				/* FPE enable */
> -	bool hs_enable;				/* FPE handshake enable */
> -	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
> -	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> +	/* Serialize access to MAC Merge state between ethtool requests
> +	 * and link state updates.
> +	 */
> +	spinlock_t lock;
> +
>  	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
> +	u32 verify_time;			/* see ethtool_mm_state */
> +	bool pmac_enabled;			/* see ethtool_mm_state */
> +	bool verify_enabled;			/* see ethtool_mm_state */
> +	enum ethtool_mm_verify_status status;
>  };
>  
>  struct stmmac_tc_entry {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3072ad33b105..6ae95f20b24f 100644
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
> +	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
> +
> +	if (!fpe_cfg->pmac_enabled)
> +		goto __unlock_out;
>  
> -	if (is_up && *hs_enable) {
> +	if (is_up && fpe_cfg->verify_enabled)
>  		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
>  					MPACKET_VERIFY);
> -	} else {
> -		*lo_state = FPE_STATE_OFF;
> -		*lp_state = FPE_STATE_OFF;
> -	}
> +	else
> +		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;

The fpe_task may be scheduled here. When you unlock, it may run and
overwrite the fpe_cfg->status you've just set.

Although I don't actually recommend setting ETHTOOL_MM_VERIFY_STATUS_DISABLED
unless cfg->verify_enabled=false.

> +
> +__unlock_out:
> +	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
>  }
>  
>  static void stmmac_mac_link_down(struct phylink_config *config,
> @@ -4091,11 +4095,25 @@ static int stmmac_release(struct net_device *dev)
>  
>  	stmmac_release_ptp(priv);
>  
> -	pm_runtime_put(priv->device);
> -
> -	if (priv->dma_cap.fpesel)
> +	if (priv->dma_cap.fpesel) {
>  		stmmac_fpe_stop_wq(priv);
>  
> +		/* stmmac_ethtool_ops.begin() guarantees that all ethtool
> +		 * requests to fail with EBUSY when !netif_running()
> +		 *
> +		 * Prepare some params here, then fpe_cfg can keep consistent
> +		 * with the register states after a SW reset by __stmmac_open().
> +		 */
> +		priv->fpe_cfg.pmac_enabled = false;
> +		priv->fpe_cfg.verify_enabled = false;
> +		priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +
> +		/* Reset MAC_FPE_CTRL_STS reg cache */
> +		priv->fpe_cfg.fpe_csr = 0;
> +	}

With this block of code, you're saying that you're deliberately okay for
the ethtool-mm state to be lost after a stmmac_release() call. Mind you,
some of the call sites of this are:
- stmmac_change_mtu()
- stmmac_reinit_queues()
- stmmac_reinit_ringparam()

I disagree that it's okay to lose the state configured by user space.
Instead, you should reprogram the saved state once lost.

Note that because stmmac_release() calls phylink_stop(), I think that
restoring the state in stmmac_fpe_link_state_handle() is enough. Because
there will always be a link drop.

> +
> +	pm_runtime_put(priv->device);
> +
>  	return 0;
>  }
>  
> @@ -5979,44 +5997,34 @@ static int stmmac_set_features(struct net_device *netdev,
>  static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
>  {
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> -	bool *hs_enable = &fpe_cfg->hs_enable;
>  
> -	if (status == FPE_EVENT_UNKNOWN || !*hs_enable)
> -		return;
> +	spin_lock(&priv->fpe_cfg.lock);
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
> +	spin_unlock(&priv->fpe_cfg.lock);
>  }
>  
>  static void stmmac_common_interrupt(struct stmmac_priv *priv)
> @@ -7372,50 +7380,57 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
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
> +	u32 sleep_ms;
> +
> +	spin_lock(&priv->fpe_cfg.lock);
> +	sleep_ms = fpe_cfg->verify_time;
> +	spin_unlock(&priv->fpe_cfg.lock);
> +
> +	while (1) {
> +		/* The initial VERIFY was triggered by linkup event or
> +		 * stmmac_set_mm(), sleep then check MM_VERIFY_STATUS.
> +		 */
> +		msleep(sleep_ms);

Thanks for the added comment. But why don't you just use queue_delayed_work()
instead of queue_work() and sleeping at the very beginning?

With this, you really don't need to drop the lock and read fpe_cfg->verify_time
twice.

But I think what is needed here is better suited for a timer, especially
because of the required coordination with the IRQ. See the end and the
attachment for more details.

> +
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
> +		spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
>  
> -			netdev_info(priv->dev, "configured FPE\n");
> +		if (fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_DISABLED ||
> +		    fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
> +		    !fpe_cfg->pmac_enabled || !fpe_cfg->verify_enabled) {
> +			spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
> +			break;
> +		}
>  
> -			*lo_state = FPE_STATE_ON;
> -			*lp_state = FPE_STATE_ON;
> -			netdev_info(priv->dev, "!!! BOTH FPE stations ON\n");
> +		if (verify_limit == 0) {
> +			fpe_cfg->verify_enabled = false;

I don't understand why turn off verify_enabled after failure? Only the
user should be able to modify this.

> +			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
> +			stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> +					     priv->plat->tx_queues_to_use,
> +					     priv->plat->rx_queues_to_use,
> +					     false);

I don't understand why turn off tx_enabled after failure, rather than
not turning it on at all until success?

This really has me thinking. This hardware does not have the explicit
notion of the verification state - it is purely a driver construct.
So I wonder if the EFPE bit in MAC_FPE_CTRL_STS isn't actually what
corresponds to "tx_active" rather than "tx_enabled"?
(definitions at https://docs.kernel.org/networking/ethtool-netlink.html)

And "tx_enabled" would just correspond to a state variable in the driver,
which does nothing until verification is actually complete.

There is a test in manual_failed_verification() which checks the
correctness of the tx_enabled/tx_active behavior. If tx_enabled=true but
verification fails (and also _up until_ that point), the MM layer is
supposed to send packets through the eMAC (because tx_active=false).
But for your driver, that test is inconclusive, because you don't report
ethtool stats broken down by eMAC/pMAC, just aggregate. So we don't know
unless we take a closer look manually at the driver in that state.

> +			spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
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
> +		sleep_ms = fpe_cfg->verify_time;
> +
> +		spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
> +
> +		verify_limit--;
>  	}

I took the liberty of rewriting the fpe_task to a timer, and delete the
workqueue. Here is a completely untested patch, which at least is less
complex, has less code and is easier to understand. What do you think?

--n5bc2hehdh25qze3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-stmmac-replace-FPE-workqueue-with-timer.patch"

From 6ce277245128638160385d948583a3e6d2561a94 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 20 Aug 2024 14:50:32 +0300
Subject: [PATCH] net: stmmac: replace FPE workqueue with timer

What remains in the fpe_task after decoupling RX from TX appears
overengineered to use a workqueue. A timer which retransmits Verify
mPackets until the verify_limit expires, or enables transmission on
success, seems enough.

In the INITIAL state, the timer sends MPACKET_VERIFY. Eventually the
stmmac_fpe_event_status() IRQ fires and advances the state to VERIFYING,
then rearms the timer after verify_time ms. If a subsequent IRQ comes in
and modifies the state to SUCCEEDED after getting MPACKET_RESPONSE, the
timer sees this. It must enable the EFPE bit now. Otherwise, it
decrements the verify_limit counter and tries again. Eventually it
moves the status to FAILED, from which the IRQ cannot move it anywhere
else, except for another stmmac_fpe_apply() call.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  16 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  35 +--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 212 +++++++-----------
 3 files changed, 100 insertions(+), 163 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 407b59f2783f..dd15f71e1663 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -152,21 +152,18 @@ enum stmmac_mpacket_type {
 	MPACKET_RESPONSE = 1,
 };
 
-enum stmmac_fpe_task_state_t {
-	__FPE_REMOVING,
-	__FPE_TASK_SCHED,
-};
-
 struct stmmac_fpe_cfg {
 	/* Serialize access to MAC Merge state between ethtool requests
 	 * and link state updates.
 	 */
 	spinlock_t lock;
-
+	struct timer_list verify_timer;
 	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
 	u32 verify_time;			/* see ethtool_mm_state */
 	bool pmac_enabled;			/* see ethtool_mm_state */
 	bool verify_enabled;			/* see ethtool_mm_state */
+	bool tx_enabled;
+	int verify_limit;
 	enum ethtool_mm_verify_status status;
 };
 
@@ -364,10 +361,6 @@ struct stmmac_priv {
 	struct work_struct service_task;
 
 	/* Frame Preemption feature (FPE) */
-	unsigned long fpe_task_state;
-	struct workqueue_struct *fpe_wq;
-	struct work_struct fpe_task;
-	char wq_name[IFNAMSIZ + 4];
 	struct stmmac_fpe_cfg fpe_cfg;
 
 	/* TC Handling */
@@ -422,7 +415,8 @@ bool stmmac_eee_init(struct stmmac_priv *priv);
 int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt);
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
-void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable);
+void stmmac_fpe_apply(struct stmmac_priv *priv);
+void stmmac_fpe_verify_timer_arm(struct stmmac_fpe_cfg *fpe_cfg);
 
 static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index a8cdcacecc26..3eb5344e2412 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1293,14 +1293,7 @@ static int stmmac_get_mm(struct net_device *ndev,
 	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
 	 */
 	state->max_verify_time = 128;
-
-	/* Cannot read MAC_FPE_CTRL_STS register here, or FPE interrupt events
-	 * can be lost.
-	 *
-	 * See commit 37e4b8df27bc ("net: stmmac: fix FPE events losing")
-	 */
-	state->tx_enabled = !!(priv->fpe_cfg.fpe_csr == EFPE);
-
+	state->tx_enabled = priv->fpe_cfg.tx_enabled;
 	/* FPE active if common tx_enabled and verification success or disabled (forced) */
 	state->tx_active = state->tx_enabled &&
 			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
@@ -1326,34 +1319,28 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	if (!priv->dma_cap.fpesel)
 		return -EOPNOTSUPP;
 
-	/* Wait for the fpe_task that's currently in progress to finish */
-	flush_workqueue(priv->fpe_wq);
-
 	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size,
 					      &add_frag_size, extack);
 	if (err)
 		return err;
 
-	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
+	/* Wait for the verification that's currently in progress to finish */
+	del_timer_sync(&fpe_cfg->verify_timer);
+
+	spin_lock_irqsave(&fpe_cfg->lock, flags);
 
 	fpe_cfg->pmac_enabled = cfg->pmac_enabled;
+	fpe_cfg->tx_enabled = cfg->tx_enabled;
 	fpe_cfg->verify_time = cfg->verify_time;
 	fpe_cfg->verify_enabled = cfg->verify_enabled;
-
-	stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
-			     priv->plat->tx_queues_to_use,
-			     priv->plat->rx_queues_to_use,
-			     cfg->tx_enabled, cfg->pmac_enabled);
+	fpe_cfg->verify_limit = 3; /* IEEE 802.3 constant */
+	if (!cfg->verify_enabled)
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
 
 	stmmac_fpe_set_add_frag_size(priv, priv->ioaddr, add_frag_size);
+	stmmac_fpe_apply(priv);
 
-	if (cfg->verify_enabled)
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
-					MPACKET_VERIFY);
-	else
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
-
-	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
+	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a5d01162fcc5..fa74504f3ad5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -971,19 +971,22 @@ static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
 	unsigned long flags;
 
-	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
+	del_timer_sync(&fpe_cfg->verify_timer);
 
-	if (!fpe_cfg->pmac_enabled)
-		goto __unlock_out;
+	spin_lock_irqsave(&fpe_cfg->lock, flags);
 
-	if (is_up && fpe_cfg->verify_enabled)
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
-					MPACKET_VERIFY);
-	else
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+	if (is_up) {
+		/* New link => maybe new partner => new verification process */
+		stmmac_fpe_apply(priv);
+	} else {
+		/* No link => turn off EFPE */
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     false, false);
+	}
 
-__unlock_out:
-	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
+	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
 }
 
 static void stmmac_mac_link_down(struct phylink_config *config,
@@ -3362,27 +3365,6 @@ static void stmmac_safety_feat_configuration(struct stmmac_priv *priv)
 	}
 }
 
-static int stmmac_fpe_start_wq(struct stmmac_priv *priv)
-{
-	char *name;
-
-	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
-	clear_bit(__FPE_REMOVING,  &priv->fpe_task_state);
-
-	name = priv->wq_name;
-	sprintf(name, "%s-fpe", priv->dev->name);
-
-	priv->fpe_wq = create_singlethread_workqueue(name);
-	if (!priv->fpe_wq) {
-		netdev_err(priv->dev, "%s: Failed to create workqueue\n", name);
-
-		return -ENOMEM;
-	}
-	netdev_dbg(priv->dev, "FPE workqueue start");
-
-	return 0;
-}
-
 /**
  * stmmac_hw_setup - setup mac in a usable state.
  *  @dev : pointer to the device structure.
@@ -3537,22 +3519,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 
-	if (priv->dma_cap.fpesel) {
-		/* A SW reset just happened in stmmac_init_dma_engine(),
-		 * we should restore fpe_cfg to HW, or FPE will stop working
-		 * from suspend/resume.
-		 */
-		spin_lock(&priv->fpe_cfg.lock);
-		stmmac_fpe_configure(priv, priv->ioaddr,
-				     &priv->fpe_cfg,
-				     priv->plat->tx_queues_to_use,
-				     priv->plat->rx_queues_to_use,
-				     false, priv->fpe_cfg.pmac_enabled);
-		spin_unlock(&priv->fpe_cfg.lock);
-
-		stmmac_fpe_start_wq(priv);
-	}
-
 	return 0;
 }
 
@@ -4049,18 +4015,6 @@ static int stmmac_open(struct net_device *dev)
 	return ret;
 }
 
-static void stmmac_fpe_stop_wq(struct stmmac_priv *priv)
-{
-	set_bit(__FPE_REMOVING, &priv->fpe_task_state);
-
-	if (priv->fpe_wq) {
-		destroy_workqueue(priv->fpe_wq);
-		priv->fpe_wq = NULL;
-	}
-
-	netdev_dbg(priv->dev, "FPE workqueue stop");
-}
-
 /**
  *  stmmac_release - close entry point of the driver
  *  @dev : device pointer.
@@ -4108,22 +4062,8 @@ static int stmmac_release(struct net_device *dev)
 
 	stmmac_release_ptp(priv);
 
-	if (priv->dma_cap.fpesel) {
-		stmmac_fpe_stop_wq(priv);
-
-		/* stmmac_ethtool_ops.begin() guarantees that all ethtool
-		 * requests to fail with EBUSY when !netif_running()
-		 *
-		 * Prepare some params here, then fpe_cfg can keep consistent
-		 * with the register states after a SW reset by __stmmac_open().
-		 */
-		priv->fpe_cfg.pmac_enabled = false;
-		priv->fpe_cfg.verify_enabled = false;
-		priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
-
-		/* Reset MAC_FPE_CTRL_STS reg cache */
-		priv->fpe_cfg.fpe_csr = 0;
-	}
+	if (priv->dma_cap.fpesel)
+		del_timer_sync(&priv->fpe_cfg.verify_timer);
 
 	pm_runtime_put(priv->device);
 
@@ -6030,11 +5970,7 @@ static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP)
 		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
 
-	if (!test_bit(__FPE_REMOVING, &priv->fpe_task_state) &&
-	    !test_and_set_bit(__FPE_TASK_SCHED, &priv->fpe_task_state) &&
-	    priv->fpe_wq) {
-		queue_work(priv->fpe_wq, &priv->fpe_task);
-	}
+	stmmac_fpe_verify_timer_arm(fpe_cfg);
 
 __unlock_out:
 	spin_unlock(&priv->fpe_cfg.lock);
@@ -7395,60 +7331,82 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
 	return ret;
 }
 
-static void stmmac_fpe_verify_task(struct work_struct *work)
+/**
+ * stmmac_fpe_verify_timer - Timer for MAC Merge verification
+ * @t:  timer_list struct containing private info
+ *
+ * Verify the MAC Merge capability in the local TX direction, by
+ * transmitting Verify mPackets up to 3 times. Wait until link
+ * partner responds with a Response mPacket, otherwise fail.
+ */
+static void stmmac_fpe_verify_timer(struct timer_list *t)
 {
-	struct stmmac_priv *priv = container_of(work, struct stmmac_priv,
-						fpe_task);
-	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	int verify_limit = 3; /* defined by 802.3 */
-	unsigned long flags;
-	u32 sleep_ms;
+	struct stmmac_fpe_cfg *fpe_cfg = from_timer(fpe_cfg, t, verify_timer);
+	struct stmmac_priv *priv = container_of(fpe_cfg, struct stmmac_priv,
+						fpe_cfg);
+	bool rearm = false;
 
-	spin_lock(&priv->fpe_cfg.lock);
-	sleep_ms = fpe_cfg->verify_time;
-	spin_unlock(&priv->fpe_cfg.lock);
+	spin_lock(&fpe_cfg->lock);
 
-	while (1) {
-		/* The initial VERIFY was triggered by linkup event or
-		 * stmmac_set_mm(), sleep then check MM_VERIFY_STATUS.
-		 */
-		msleep(sleep_ms);
-
-		if (!netif_running(priv->dev))
-			break;
-
-		spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
-
-		if (fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_DISABLED ||
-		    fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
-		    !fpe_cfg->pmac_enabled || !fpe_cfg->verify_enabled) {
-			spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
-			break;
-		}
-
-		if (verify_limit == 0) {
-			fpe_cfg->verify_enabled = false;
+	switch (fpe_cfg->status) {
+	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
+	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_VERIFY);
+		if (fpe_cfg->verify_limit != 0) {
+			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+			rearm = true;
+		} else {
 			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
-			stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
-					     priv->plat->tx_queues_to_use,
-					     priv->plat->rx_queues_to_use,
-					     false, fpe_cfg->pmac_enabled);
-			spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
-			break;
 		}
+		fpe_cfg->verify_limit--;
+		break;
+	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     true, true);
+		break;
+	default:
+		break;
+	}
 
-		if (fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
-			stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
-						MPACKET_VERIFY);
-
-		sleep_ms = fpe_cfg->verify_time;
+	if (rearm) {
+		mod_timer(&fpe_cfg->verify_timer,
+			  msecs_to_jiffies(fpe_cfg->verify_time));
+	}
 
-		spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
+	spin_unlock(&fpe_cfg->lock);
+}
 
-		verify_limit--;
+void stmmac_fpe_verify_timer_arm(struct stmmac_fpe_cfg *fpe_cfg)
+{
+	if (fpe_cfg->pmac_enabled && fpe_cfg->tx_enabled &&
+	    fpe_cfg->verify_enabled &&
+	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
+	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
+		mod_timer(&fpe_cfg->verify_timer,
+			  msecs_to_jiffies(fpe_cfg->verify_time));
 	}
+}
 
-	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
+void stmmac_fpe_apply(struct stmmac_priv *priv)
+{
+	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
+
+	/* If verification is disabled, configure FPE right away.
+	 * Otherwise let the timer code do it.
+	 */
+	if (!fpe_cfg->verify_enabled) {
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     fpe_cfg->tx_enabled,
+				     fpe_cfg->pmac_enabled);
+	} else {
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		stmmac_fpe_verify_timer_arm(fpe_cfg);
+	}
 }
 
 static int stmmac_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
@@ -7565,9 +7523,6 @@ int stmmac_dvr_probe(struct device *device,
 
 	INIT_WORK(&priv->service_task, stmmac_service_task);
 
-	/* Initialize FPE verify workqueue */
-	INIT_WORK(&priv->fpe_task, stmmac_fpe_verify_task);
-
 	/* Override with kernel parameters if supplied XXX CRS XXX
 	 * this needs to have multiple instances
 	 */
@@ -7733,6 +7688,7 @@ int stmmac_dvr_probe(struct device *device,
 	mutex_init(&priv->lock);
 
 	spin_lock_init(&priv->fpe_cfg.lock);
+	timer_setup(&priv->fpe_cfg.verify_timer, stmmac_fpe_verify_timer, 0);
 	priv->fpe_cfg.pmac_enabled = false;
 	priv->fpe_cfg.verify_time = 128; /* ethtool_mm_state.max_verify_time */
 	priv->fpe_cfg.verify_enabled = false;
@@ -7912,7 +7868,7 @@ int stmmac_suspend(struct device *dev)
 	rtnl_unlock();
 
 	if (priv->dma_cap.fpesel)
-		stmmac_fpe_stop_wq(priv);
+		del_timer_sync(&priv->fpe_cfg.verify_timer);
 
 	priv->speed = SPEED_UNKNOWN;
 	return 0;
-- 
2.34.1


--n5bc2hehdh25qze3--

