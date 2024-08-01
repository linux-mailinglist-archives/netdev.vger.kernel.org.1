Return-Path: <netdev+bounces-115119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A594539E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 22:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF171C20E9B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4563214A0A8;
	Thu,  1 Aug 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ1P6vTx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF921EB48A;
	Thu,  1 Aug 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542668; cv=none; b=BC4k4h85a5VCO5rLWzzYJda/TUIqHfSYoZultf3l89CqSsjbUng7r6o/9nHwi9YUm9rENDN/zZ9l8orr3LqwCL4T795wG98eWLh1/5Ldv7eAyLBJgdY65VrHTI1WHle8VNQdi388sFV4QRRbI2v69RVVZ7Q3hY1FFfiQuB9nAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542668; c=relaxed/simple;
	bh=dUbossqffzfKo4EtAIVeZVj6+DiFSvnO31PEZfmHHlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcH3VyO0/9JrJ8IPq6sE6ImnMKL6I1EcVg0URYFotAN/2ixcISbwbc1Dqt/rANqCGwRFkcuw66V/mCbw1PWhKl6Owka7VHjB5Uv0xfnZQ6bznimQ7PFZI3ndjAo0Vda7h/W3fOjU2fNGFAqSLiX3P5FeDZUt9/F/X/nfJ5diA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ1P6vTx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso83665971fa.1;
        Thu, 01 Aug 2024 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722542663; x=1723147463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=svzaLRly6/piQEhmTsRu32eA5qubsY2cEZkb7yILYP4=;
        b=BJ1P6vTx6Cl1q20XnxR3IBYDQpw4YeeCcROwuqJj+aIwW0Qgl4S+KVM4z7gJTeW4Ta
         n9acNNhXsDy8J8JJpJcRIVl55h/fRXhHESIvAGzUA9Cy5cbUjU+LhueMiWHbgpczmaZf
         jAvNtMrd0UsGxoyJrUviW1z5YWeygyZvdbh0ZabA0x/m4HPqH0zvrKuirGVRO1sq/M92
         cg1U+xpJChlmBkOMc3sSWjxspGG/oK20KXrXkH3icKGunQjGRV6gcq4K6E1CRrZL8q00
         26irmFfKV05UPL24QROIAN4lWELGIJlhLDpDzWqU0e5Nh+esv3gE2dQYchhL7VTX7wvF
         YJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542663; x=1723147463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svzaLRly6/piQEhmTsRu32eA5qubsY2cEZkb7yILYP4=;
        b=i0sNG/NIdyLue6RZXB35NKIna9wRIs/ymLy37bMcHs+6ExVXrKVmgav0NEvlKYLr5Z
         BjJ2rlmJkuv6Yowx1GQbjNT8DulGsKMiHXXmBM/xHCLd4bzGHD1p919qWywx2UlPlsmT
         fmo/WDtcahZDS1321uHvAe9yIFVXMmooN+duchb+P1wm9qDmojSvMzgWjydOQK4ukDCs
         WikkNzA1bCV3geOdRxbUeI3aa2J9gQDpRZvG8EqqFheAVOPr9SP97T7OQkp4kYTT6+MA
         +Y2Kyx7fSCXqzX/W8ehppTOHN3oKd3NFZG3DHpok+w5MzjM348CPo1VLb0nVvcewcUAO
         +XQA==
X-Forwarded-Encrypted: i=1; AJvYcCWzQFcvKcmO0p19vRdnyhVNdCXsx6mVO2pXG2B/JV3vJUzvcVYHm6HglODtjLalMl/ZezL46twJnt/SG4cyDcc3sXls8b2NDlBdwWYtW8sQgAsnX00A0KPYoZOwMjHp0MqaKE/W
X-Gm-Message-State: AOJu0YxajYvuNPb4X9cG94AB6UlZcq/re2yRXb4m7MOBoEDDmqwkOTNN
	Cv2sntUfDhOGwODw6fqwyxaOMAFDvmpgFPPFMwEq/uDmFutB/HC5
X-Google-Smtp-Source: AGHT+IF1rgY/ErrP3mP5eIig5nR3oDZkb6fvwAxelgQkhXiPc8SfFBiS5eCL9jtGfDknIKnyJ+0fFQ==
X-Received: by 2002:a2e:b602:0:b0:2ef:2df7:3d9a with SMTP id 38308e7fff4ca-2f15aa84e17mr8653871fa.9.1722542662737;
        Thu, 01 Aug 2024 13:04:22 -0700 (PDT)
Received: from skbuf ([188.25.135.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83bf3b99dsm153406a12.91.2024.08.01.13.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 13:04:21 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:04:19 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 1/5] net: stmmac: configure FPE via ethtool-mm
Message-ID: <20240801200419.g3b264sjcc3njvwg@skbuf>
References: <cover.1722421644.git.0x1207@gmail.com>
 <cover.1722421644.git.0x1207@gmail.com>
 <d20b291dc4dd5030adefbabef7dda1bf2206a15f.1722421644.git.0x1207@gmail.com>
 <d20b291dc4dd5030adefbabef7dda1bf2206a15f.1722421644.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d20b291dc4dd5030adefbabef7dda1bf2206a15f.1722421644.git.0x1207@gmail.com>
 <d20b291dc4dd5030adefbabef7dda1bf2206a15f.1722421644.git.0x1207@gmail.com>

On Wed, Jul 31, 2024 at 06:43:12PM +0800, Furong Xu wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index b23b920eedb1..5228493bc68c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -345,6 +345,9 @@ struct stmmac_priv {
>  	struct work_struct fpe_task;
>  	char wq_name[IFNAMSIZ + 4];
>  
> +	/* Serialize access to MAC Merge state between ethtool requests */
> +	struct mutex mm_lock;

The thing is, ethtool requests are already serialized by the rtnl_mutex.
The purpose of a driver-level locking scheme is to serialize the ethtool
requests with things like interrupts, work queues, etc, to avoid
corrupting driver state.

Surprisingly, even if the code runs indeed very much unlocked, I don't see too many
races with severe consequences. There are some exceptions though. Like for example,
stmmac_fpe_handshake(enable=false) races on priv->plat->fpe_cfg->lo_fpe_state
and priv->plat->fpe_cfg->lp_fpe_state with stmmac_fpe_lp_task().

static void stmmac_fpe_lp_task(struct work_struct *work)
{
	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;

	/* Bail out immediately if FPE handshake is OFF */
	if (*lo_state == FPE_STATE_OFF || !*hs_enable)
		break;

	if (*lo_state == FPE_STATE_ENTERING_ON &&
	    *lp_state == FPE_STATE_ENTERING_ON) {

		netdev_dbg(priv->dev, "configured FPE\n");

									Another CPU runs here:
									stmmac_set_mm()
									-> stmmac_fpe_handshake(enable=false)
									   -> priv->plat->fpe_cfg->lo_fpe_state = FPE_STATE_OFF;
									   -> priv->plat->fpe_cfg->lp_fpe_state = FPE_STATE_OFF;

		*lo_state = FPE_STATE_ON;
		*lp_state = FPE_STATE_ON;
		netdev_dbg(priv->dev, "!!! BOTH FPE stations ON\n");
		break;
	}
	...
}

Simply put, due to lack of locking, stmmac_set_mm() can try to stop the
FPE verification task but fail, since it can lose the race.

I would expect a way for stmmac_fpe_handshake() to be able to stop
further FPE interrupts from taking place (or at least from being
processed), and then flush_workqueue(&priv->fpe_task) to make sure that
all pending stmmac_fpe_lp_task()s have finished.

> +
>  	/* TC Handling */
>  	unsigned int tc_entries_max;
>  	unsigned int tc_off_max;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 7008219fd88d..ca85e8694285 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -19,6 +19,7 @@
>  #include "stmmac.h"
>  #include "dwmac_dma.h"
>  #include "dwxgmac2.h"
> +#include "dwmac5.h"
>  
>  #define REG_SPACE_SIZE	0x1060
>  #define GMAC4_REG_SPACE_SIZE	0x116C
> @@ -1270,6 +1271,113 @@ static int stmmac_set_tunable(struct net_device *dev,
>  	return ret;
>  }
>  
> +static int stmmac_get_mm(struct net_device *ndev,
> +			 struct ethtool_mm_state *state)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	enum stmmac_fpe_state lo_state = priv->plat->fpe_cfg->lo_fpe_state;

I expect this to have to serialize with the writers of lo_fpe_state on
some sort of lock. May have to be a spinlock (making the priv->mm_lock
mutex inadequate in its current form), since stmmac_interrupt() is not
threaded and thus runs in atomic context.

> +	u32 add_frag_size;
> +
> +	if (!priv->dma_cap.fpesel)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&priv->mm_lock);
> +
> +	/* If FPE is supported by hardware, preemptible MAC is always enabled */
> +	state->pmac_enabled = true;

Documentation/networking/ethtool-netlink.rst: "set if RX of preemptible
and SMD-V frames is enabled". You can use the pmac_enabled knob as a
hook to call stmmac_fpe_start_wq() and stmmac_fpe_stop_wq(), as well as
whether to process FPE interrupt status bits.

The idea being that as long as the pMAC is enabled, you are obliged to
respond to mPackets from the link partner (to allow his side* of the
verification process to run). Otherwise you are not - you should behave
like a FPE-incapable NIC. In fact, this is what the manual_failed_verification()
portion of the kselftest attempts to test.

*This is actually a misconception of the current driver implementation.
The two verification processes are completely independent, since each
refers to its TX side only. One device can have ethtool --set-mm
verify-enabled on, and the other off. There is no reason at all to keep
a local device state + a link partner state, and to make any decision in
the driver based on the LP state. Like here:

stmmac_fpe_lp_task():

	if (*lo_state == FPE_STATE_ENTERING_ON &&
	    *lp_state == FPE_STATE_ENTERING_ON) { // lp_state does not matter

		netdev_dbg(priv->dev, "configured FPE\n");

		*lo_state = FPE_STATE_ON;
		*lp_state = FPE_STATE_ON;
		netdev_dbg(priv->dev, "!!! BOTH FPE stations ON\n");
		break;
	}

	if ((*lo_state == FPE_STATE_CAPABLE ||
	     *lo_state == FPE_STATE_ENTERING_ON) &&
	     *lp_state != FPE_STATE_ON) { // lp_state does not matter
		netdev_dbg(priv->dev, SEND_VERIFY_MPAKCET_FMT,
			   *lo_state, *lp_state);
		stmmac_fpe_send_mpacket(priv, priv->ioaddr,
					fpe_cfg,
					MPACKET_VERIFY);
	}

To my superficial reading of the driver, the distinction between
FPE_STATE_ENTERING_ON and FPE_STATE_ON exists solely to wait for the LP
to finish its verification as well.

I think you noticed that is a non-goal as well, because your stmmac_get_mm()
implementation reports ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED when we are in
either of the 2 states: FPE_STATE_ENTERING_ON or FPE_STATE_ON.

I hope you don't mind me if I say that since waiting both sides to
finish verification is a non-goal, I disagree with your choice of
papering over the existence of the 2 FPE driver states. I would
recommend consolidating them into a single one.

Another mistake relating to this (TX verification processes are not
necessarily symmetric) is:

stmmac_set_mm()
-> stmmac_fpe_handshake(priv, cfg->verify_enabled)
   -> priv->plat->fpe_cfg->hs_enable = enable

stmmac_fpe_event_status():

	if (status == FPE_EVENT_UNKNOWN || !*hs_enable)
		return;

	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER) {
		/* If LP has sent Verify mPacket, send back a Responds mPacket */
		if (*hs_enable)
			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
						fpe_cfg,
						MPACKET_RESPONSE);
	}

We should always respond to the link partner's Verify mPacket as long as
pmac_enabled=true, and not just if hs_enable=true.

> +
> +	state->verify_time = priv->plat->fpe_cfg->verify_time;
> +
> +	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
> +	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
> +	 */
> +	state->max_verify_time = 128;
> +
> +	if (lo_state == FPE_STATE_CAPABLE)
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
> +	else if (lo_state == FPE_STATE_ENTERING_ON || lo_state == FPE_STATE_ON)
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
> +	else if (lo_state == FPE_STATE_OFF)
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +	else
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
> +
> +	/* Cannot read MAC_FPE_CTRL_STS register here, or FPE interrupt events
> +	 * can lose.

s/lose/be lost/

> +	 *
> +	 * See commit 37e4b8df27bc ("net: stmmac: fix FPE events losing")
> +	 */
> +	state->tx_enabled = !!(priv->plat->fpe_cfg->fpe_csr == EFPE);
> +
> +	/* FPE active if common tx_enabled and verification success or disabled (forced) */
> +	state->tx_active = state->tx_enabled &&
> +			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
> +			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
> +
> +	state->verify_enabled = priv->plat->fpe_cfg->hs_enable;
> +
> +	add_frag_size = stmmac_fpe_get_add_frag_size(priv, priv->ioaddr);
> +	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(add_frag_size);
> +
> +	state->rx_min_frag_size = ETH_ZLEN;
> +
> +	mutex_unlock(&priv->mm_lock);
> +
> +	return 0;
> +}
> +
> +static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
> +			 struct netlink_ext_ack *extack)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	u32 add_frag_size;
> +	int err;
> +
> +	if (!priv->dma_cap.fpesel)
> +		return -EOPNOTSUPP;
> +
> +	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size,
> +					      &add_frag_size, extack);
> +	if (err)
> +		return err;
> +
> +	mutex_lock(&priv->mm_lock);
> +
> +	priv->plat->fpe_cfg->verify_time = cfg->verify_time;
> +
> +	stmmac_fpe_configure(priv, priv->ioaddr, priv->plat->fpe_cfg,
> +			     priv->plat->tx_queues_to_use,
> +			     priv->plat->rx_queues_to_use,
> +			     cfg->tx_enabled);
> +
> +	stmmac_fpe_set_add_frag_size(priv, priv->ioaddr, add_frag_size);
> +
> +	stmmac_fpe_handshake(priv, cfg->verify_enabled);
> +
> +	mutex_unlock(&priv->mm_lock);
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 12689774d755..9b1cf81c50ea 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7384,7 +7384,6 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
>  	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
>  	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
>  	bool *hs_enable = &fpe_cfg->hs_enable;
> -	bool *enable = &fpe_cfg->enable;
>  	int retries = 20;
>  
>  	while (retries-- > 0) {
> @@ -7394,11 +7393,6 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
>  
>  		if (*lo_state == FPE_STATE_ENTERING_ON &&
>  		    *lp_state == FPE_STATE_ENTERING_ON) {
> -			stmmac_fpe_configure(priv, priv->ioaddr,
> -					     fpe_cfg,
> -					     priv->plat->tx_queues_to_use,
> -					     priv->plat->rx_queues_to_use,
> -					     *enable);
>  
>  			netdev_info(priv->dev, "configured FPE\n");
>  
> @@ -7418,7 +7412,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
>  						MPACKET_VERIFY);
>  		}
>  		/* Sleep then retry */
> -		msleep(500);
> +		msleep(fpe_cfg->verify_time);

FWIW, if you want to follow the standard, I guess you should modify
"retries" to 3 as well - this is the constant that 802.3 uses for
verifyLimit. It helps make the verification process fail more
predictably (within verifyTime * 3 ms).

>  	}
>  
>  	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
> @@ -7720,6 +7714,7 @@ int stmmac_dvr_probe(struct device *device,
>  	stmmac_napi_add(ndev);
>  
>  	mutex_init(&priv->lock);
> +	mutex_init(&priv->mm_lock);
>  
>  	/* If a specific clk_csr value is passed from the platform
>  	 * this means that the CSR Clock Range selection cannot be

