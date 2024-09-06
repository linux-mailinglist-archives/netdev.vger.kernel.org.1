Return-Path: <netdev+bounces-125931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD1E96F4A8
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDBF1F277BD
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41B71CB338;
	Fri,  6 Sep 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elwx2U+B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB3C13C;
	Fri,  6 Sep 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627185; cv=none; b=hy821F2Hm4jVDcRZC5KPTNM6xKgQqcWyUL4/JqaHOx6qEOsA0KOIEH3YRw+USo7YBQ2ARzKVAIUksjevuc9DmPNtWZhVqbb72nUKevJ8PiovF2cwuE9UgZ2AdUdF1MW9mU1w0ccRwOvwyfdlcYW8RsGNLxwpZZW/0PJRdAhswEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627185; c=relaxed/simple;
	bh=q5VfbWltAcQLz/+81HbmpQS+9Anz1Ywt6H9742dG5kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsIJoTQsBqJdfoCHE1cH5Lv7i5vaB30rzHEAlFszbZpRyPCbtcp1rsA7y0xlRMes0evV3QHsIMCLr/1+81dpklMEHNn/LIQmBXf0prBqM/NW1aAkhlYs46pBk4XYt5v3GmuYFRzoC4Gpis/J1FNkBEoftPW0LWb6NEutNBwP1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elwx2U+B; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c24648e280so182050a12.0;
        Fri, 06 Sep 2024 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725627182; x=1726231982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=690hJkBK217OakU19EFY9fs/Kc2GYaKx8HXQ7unUhlQ=;
        b=elwx2U+B9iAeebSjj7DgB+GOim0Ul1h8O6ESIpcfEU5ae3Qz6Ggms0S/fEVtHDMD/v
         eqsiqytq0a0jH97i1PULbF+aLZa+DfDapdVSnVTsip2VfeNTUpci6f4TrASLgp5IJ7ez
         doqu+x/FEU8Zs4iViJAYUBKfuCqecsc4/kLoCY5fcubMVlNCH92dLqbmIG/5accYVhkz
         538kCL0UYmT7SMPWsoM5NCyz2U23zlyfD6UcvXyM0/1IB6Dz+Awvb2BHoBCpt8mVA7UK
         SQogaqSoMI6NSjZBWoM3mg7WIZYeiaqqU1Iix4AjfZD7TLi5IkFAZpEjSrkE/ZeTN28b
         Bfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725627182; x=1726231982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=690hJkBK217OakU19EFY9fs/Kc2GYaKx8HXQ7unUhlQ=;
        b=SfeUTfvyqhm3WgmRdQxCAglaMLyvikgW5vHACZMbGYqXHsc2EMamzgt4qiSP/WfTTW
         FPvXo4VTaVdKCmQD4fHWy1/OTxNz4wPKtL8KwXWxOVrnID1OXSWsHnrHpod9P3wuZiY6
         EALfbnPLD20jwBirgmx57jzuEdT460CBNZI5EkP95uUogVE+mVAMxMrNOlI25uxEEN1g
         dQ4VyyB3Q6nNY+N654sDMlKMS6EoXPO2flJSM6zbRViOeDzyvBY4MEPgmoTBGH+886HA
         riDGEbPmuFm6H7eLoKXs1rRXlKO75BcpWKrrQcZ2+/Oo0J7AvnGbLaVR+zh4lpsxqC5b
         5few==
X-Forwarded-Encrypted: i=1; AJvYcCUVtU81wUQYFrLlo4wJ6VVWjvegycE7rwuyugwXmW3Im+I/snHHzaBlIOGqtVuKTtqSoBUrwQA3@vger.kernel.org, AJvYcCWfgdi7a4bhTMX6Fah7DbaS1SAV/a/G5dV5wDAcpaaoM3IytEK5Ah5DRnmLOtUr4oaEnn3S0YZuVO/pvdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdjJ7gLMUQuXTC7JQZP5p/NAZdXsUVQxDoii4k7RYhPqnyZpg
	m4DbIg0lowp3rf2G57Jea+eqsWaY6ztm3+jsm12HERqBfOWpR0PY
X-Google-Smtp-Source: AGHT+IFUUlXDd8a581aFfNhl9hEBR8Xj7Vj1SfC+dxLDEYbwn71uSH7PY1/UYC/o4JTGTrHDO3gv+Q==
X-Received: by 2002:a05:6402:50c7:b0:5c2:6850:7b2 with SMTP id 4fb4d7f45d1cf-5c3dc7ef8cfmr1030364a12.6.1725627181456;
        Fri, 06 Sep 2024 05:53:01 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc56a897sm2426757a12.47.2024.09.06.05.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:53:00 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:52:58 +0300
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
Message-ID: <20240906125258.d7rhhcjdic3quqg2@skbuf>
References: <cover.1725597121.git.0x1207@gmail.com>
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

On Fri, Sep 06, 2024 at 12:55:58PM +0800, Furong Xu wrote:
> @@ -5979,44 +5956,29 @@ static int stmmac_set_features(struct net_device *netdev,
>  static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
>  {
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> -	bool *hs_enable = &fpe_cfg->hs_enable;
>  
> -	if (status == FPE_EVENT_UNKNOWN || !*hs_enable)
> -		return;
> +	/* This is interrupt context, just spin_lock() */
> +	spin_lock(&fpe_cfg->lock);
>  
> -	/* If LP has sent verify mPacket, LP is FPE capable */
> -	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER) {
> -		if (*lp_state < FPE_STATE_CAPABLE)
> -			*lp_state = FPE_STATE_CAPABLE;
> +	if (!fpe_cfg->pmac_enabled || status == FPE_EVENT_UNKNOWN)
> +		goto unlock_out;
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
> +		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;

Nitpick, doesn't affect normal behavior.
If the link partner crafts an unsolicited Response mPacket, and we have
verify_enabled = false, what we should do is we should ignore it.
But what the code does is to transition the state to SUCCEEDED, as if
verify_enabled was true.

We should ignore FPE_EVENT_RRSP events if we are in the
ETHTOOL_MM_VERIFY_STATUS_DISABLED state.

Depending on how the maintainers feel, this could also be handled in a
subsequent patch.

>  
> -	/* If Local has sent response mPacket, Local is entering FPE ON */
> -	if ((status & FPE_EVENT_TRSP) == FPE_EVENT_TRSP)
> -		*lo_state = FPE_STATE_ENTERING_ON;
> -
> -	if (!test_bit(__FPE_REMOVING, &priv->fpe_task_state) &&
> -	    !test_and_set_bit(__FPE_TASK_SCHED, &priv->fpe_task_state) &&
> -	    priv->fpe_wq) {
> -		queue_work(priv->fpe_wq, &priv->fpe_task);
> -	}
> +unlock_out:
> +	spin_unlock(&fpe_cfg->lock);
>  }
>  
>  static void stmmac_common_interrupt(struct stmmac_priv *priv)

