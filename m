Return-Path: <netdev+bounces-125128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABD996BF95
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BC128572D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505CE1D47D1;
	Wed,  4 Sep 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvnH/b12"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7CF1EBFF7;
	Wed,  4 Sep 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458696; cv=none; b=UA0zTdsCx+eDEUkm03hrCUEXyTAJKWp2Wk7liHSpBGbrcAkmofy4+o3OVCLubINu56oEDqwAn9qhHfkEFsF6SvvJyt9mUTAz3JZel+06mDFla2EUAAqE0O4jL/grvzb4HAcnzBpNJyikdJuTwCg0O/ZOLF8soGLVp7/zPhEA5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458696; c=relaxed/simple;
	bh=YcVLd4CgfFwDGY2+lBjpAE7Fj7gBEkaN1HE3M1S0UAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pki+cSdEPVEK9A9VS6XmHmzoDkcVkFZeBFo1HWNmjG/bqrP19Ak7h/f5+MaFFvhPwneDb8x5cR3zhZaPP+rhJ/z5pPsa0HAAYsdVwcSLyi9QrY6RwHoREORiHkFkduvHAJnTIXCwBBJonZ/NPADW07YpLEUOHipsxVHTqgUaA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvnH/b12; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bbd3bed1bso7370155e9.1;
        Wed, 04 Sep 2024 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725458693; x=1726063493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcSQHDuFZNW8f8jn2HlyrNAfmNzNkeFSHZv2Ikhhg8I=;
        b=hvnH/b12DOyFv4FxlzgA5wXHp2J7rc0cbd8X61l3rR5DeeB8d8cuetknOS6i0/mD91
         pc4V3TrHLhuEl9woFFpSZwOJ1Wp/hYUFtZuj6Et9DE1IiGQal049kctoi9VO/Fv3iN1g
         qavmBldgcsc34F2Hfu1lpfBQolu6cj03xcOd8hrbLJVwdKE9LE8mL6uYYFpts9IPyD6W
         Ei/A/k4xDna5bPdzKFc74oRAoakrWWjAozyI4Ww+QqoaCaDOM5to3qmBe4AEIwP96XXB
         g2374iLxOuEwS7PtCSjcm9vAvYSjoCJpHvl5yiwza8aoXtGDLLP1A8VqVdTmAceIhj5R
         Nidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458693; x=1726063493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcSQHDuFZNW8f8jn2HlyrNAfmNzNkeFSHZv2Ikhhg8I=;
        b=ol+E2fV7V8D4rC9XBCFfTEglXk0J8qzJu1rGHlp8AEmXBgH6bDOxu2J/8TsbbPXYsE
         HKMCimWzDERhblSyTuBmUk60xgARNeT03cIIhTXCWnmR5/OpmLBDi9tThvmDCjNe55wu
         jSslQPb5xtcRBgWp88Ek9z4mZjmfRNyTlP/6zu70c2P54CFH5XI6Sb/kwNOTuIEcDjcS
         Jlscwqh60ELtWFVzhPMXYMbAgO7nmmvqqYFHnPHVkUqsr8w3XADD/NchKVBnA/IrGj/F
         YyC0h6TEia9muYscoopJFskt0ECPub9rbk9c6ws50sXErYTnAIQm6QeeGiVmQM1WneVm
         8BvA==
X-Forwarded-Encrypted: i=1; AJvYcCVUofzrAYP371U5GydiWmiOanTVjBf8ZUO9tV9/GRgq026TCBwQbwhDWrAIknqKKq64BC92xsVCB540O4Y=@vger.kernel.org, AJvYcCVjMBLPPoBW6MuT9ZWMMTFgl80ZXIxRAI87D+kUktAbpich+nVsZs8w50twrmqpqHPq9QBPHc/i@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzh6O2UKKyJd6baBrbDo9ecTZJe77Oh+DwuaECGvtYGeqkINuz
	y884ABSR2T1tPmKiShsaItS6eSoAKfSpQcUYENy1RWyC0uCEUGLL
X-Google-Smtp-Source: AGHT+IFwd43mImwMibDfu+DajpXj0lE+8R58B0kaRqv52bm6izGdfKSggdaX92YjEflO0z3LrM32tw==
X-Received: by 2002:a05:600c:1554:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-42bbb43d5e4mr71495425e9.4.1725458691917;
        Wed, 04 Sep 2024 07:04:51 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374cf7e2dbfsm7060858f8f.37.2024.09.04.07.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:04:51 -0700 (PDT)
Date: Wed, 4 Sep 2024 17:04:48 +0300
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
Subject: Re: [PATCH net-next v7 3/7] net: stmmac: refactor FPE verification
 process
Message-ID: <20240904140448.6hvjzj3ei2k7jdbe@skbuf>
References: <cover.1725441317.git.0x1207@gmail.com>
 <1e452525e496b28c0b1ea43afbdc3533c92930c6.1725441317.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e452525e496b28c0b1ea43afbdc3533c92930c6.1725441317.git.0x1207@gmail.com>

On Wed, Sep 04, 2024 at 05:21:18PM +0800, Furong Xu wrote:
> +/**
> + * stmmac_fpe_verify_timer - Timer for MAC Merge verification
> + * @t:  timer_list struct containing private info
> + *
> + * Verify the MAC Merge capability in the local TX direction, by
> + * transmitting Verify mPackets up to 3 times. Wait until link
> + * partner responds with a Response mPacket, otherwise fail.
> + */
> +static void stmmac_fpe_verify_timer(struct timer_list *t)
>  {
> -	struct stmmac_priv *priv = container_of(work, struct stmmac_priv,
> -						fpe_task);
> -	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> -	bool *hs_enable = &fpe_cfg->hs_enable;
> -	bool *enable = &fpe_cfg->enable;
> -	int retries = 20;
> -
> -	while (retries-- > 0) {
> -		/* Bail out immediately if FPE handshake is OFF */
> -		if (*lo_state == FPE_STATE_OFF || !*hs_enable)
> -			break;
> -
> -		if (*lo_state == FPE_STATE_ENTERING_ON &&
> -		    *lp_state == FPE_STATE_ENTERING_ON) {
> -			stmmac_fpe_configure(priv, priv->ioaddr,
> -					     fpe_cfg,
> -					     priv->plat->tx_queues_to_use,
> -					     priv->plat->rx_queues_to_use,
> -					     *enable);
> -
> -			netdev_info(priv->dev, "configured FPE\n");
> +	struct stmmac_fpe_cfg *fpe_cfg = from_timer(fpe_cfg, t, verify_timer);
> +	struct stmmac_priv *priv = container_of(fpe_cfg, struct stmmac_priv,
> +						fpe_cfg);
> +	struct ethtool_mm_state *state = &fpe_cfg->state;
> +	unsigned long flags;
> +	bool rearm = false;
>  
> -			*lo_state = FPE_STATE_ON;
> -			*lp_state = FPE_STATE_ON;
> -			netdev_info(priv->dev, "!!! BOTH FPE stations ON\n");
> -			break;
> -		}
> +	spin_lock_irqsave(&fpe_cfg->lock, flags);
>  
> -		if ((*lo_state == FPE_STATE_CAPABLE ||
> -		     *lo_state == FPE_STATE_ENTERING_ON) &&
> -		     *lp_state != FPE_STATE_ON) {
> -			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
> -				    *lo_state, *lp_state);
> +	switch (state->verify_status) {
> +	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
> +	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
> +		if (fpe_cfg->verify_retries != 0) {
>  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> -						fpe_cfg,
> -						MPACKET_VERIFY);
> +						fpe_cfg, MPACKET_VERIFY);
> +			rearm = true;
> +		} else {
> +			state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
>  		}
> -		/* Sleep then retry */
> -		msleep(500);
> +
> +		fpe_cfg->verify_retries--;
> +	break;

Odd indentation... "break;" should be on the same level with the code,
not with the "case" statements. Not sure which editor you use, but even
if you hit "==" in vim on this line, it will shift it by one tab to the
right.

> +
> +	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
> +		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> +				     priv->plat->tx_queues_to_use,
> +				     priv->plat->rx_queues_to_use,
> +				     true, true);
> +	break;

Same comment here and below.

> +
> +	default:
> +	break;
> +	}
> +
> +	if (rearm) {
> +		mod_timer(&fpe_cfg->verify_timer,
> +			  jiffies + msecs_to_jiffies(state->verify_time));
>  	}
>  
> -	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
> +	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
> +}

