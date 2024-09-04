Return-Path: <netdev+bounces-125073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F16096BD8D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4B21F24409
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A213D1DA112;
	Wed,  4 Sep 2024 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLUCszH3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11211DA0F9;
	Wed,  4 Sep 2024 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454952; cv=none; b=bdO9CJQoxBsO2BqgndAwyL+LgRwJOfiLT574QH/wwSo8ICA+cKQqoBkZlpfnVQPoJ/Rjz+8iFEi7UrSgbzcH0+HY7/AwZ6bWMKr1+GvjoJIznTxF54Xz3O5P1Cl5Do4lSeHQ5Sidb4JEMjH8QqUrePm7AOINIJZaADVge7RBwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454952; c=relaxed/simple;
	bh=Izkuc8DVQwG9JPQ7jaLjluJviagM7i+wKUc96A1/MYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkDACBq0kHW2Svb6YzXMoOszhBtIhYndj0+tLAIypfHHNDCDO8O3ro9TaOJB0VOrXhuFGwvm0ZAiBMCwiJlZYPtRk+fE6kL+0bYb8nICJJ5ureGx2boVAR47i5guWsd61qx9KLo595BYR99+S0GVu6FiAuOGhVQYdCmjNrSkE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLUCszH3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42c88128315so3140565e9.0;
        Wed, 04 Sep 2024 06:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725454949; x=1726059749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcbQbaIVPohzYKpW0NAJ6739Zodc4w16fXaT/0eJq+0=;
        b=HLUCszH3sR/55ATBcI/1O0siT8SytVklsVOxTk3qPAQhiP13G95cwRarSDkRyNZM20
         AUf+n7lQeWPMIZa7ihqZgSg0Q4nsiaa5T6+xZ4hX3OQEtoQw9VbUKfuZvKQ/bUZqbMeV
         833ES71A/i3+OKnNstaLdX+iPsb5RLLlrHrI1dlC/Hc+fx5LsKw1adkULyQsWVUwX9Z1
         2UNXdZmfpe4hpur9ofUpO8lWAnv6Pc3a9HXEiSWSKxTRPdwenxP9zZWE0A/Edj3C3/mo
         HFtLPUbWkgIggJmr8OvRcznGIrNLKvTRi+SmRXt0Ip2QlCFDsWHPDbjbEBYD6J/E5TXT
         ievA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725454949; x=1726059749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcbQbaIVPohzYKpW0NAJ6739Zodc4w16fXaT/0eJq+0=;
        b=Go/NrnciiDLtClrQlGzqYo2F0tbvOBNGGSFnY5faXJt3+VbUC+ugZkbbuhPpshpKi8
         ueJ/McC36m/Fe8W9hHH2lWFSFnjQuBQzOqeCJZXSYSHfJI8y889N3FUjYWNoVZ4x58Qq
         AOpCQ/rNWiVD0HclXB+C7BGXZfl2OGsVaS7v4N8R/CDHwwc/yRxXcXzLew9DP/GnVHPx
         nQxfH6feHluDvIi3DpLOGSkDY7glTEBfpiYN8VKS+0pHUMU/j73citV2TXe1J1lXJN74
         +e6TE3LUmpzls1vRjg6RWsrYUb8+tbcWdPhI7E6VNU+TnXSz8Ub1aLsJHa2EyngmUNSb
         vEwg==
X-Forwarded-Encrypted: i=1; AJvYcCVw63LTZatNJpJailPGd+atmnwKEt56mcepK9KH8i0eNyTBYCHMjkF6dzsXiyBGeszNTbsf2fMN@vger.kernel.org, AJvYcCXppNXFcRWbcyOUR6l6HgipVgdR3l9aSvFnMRp/UBuO9pW2H2JSgJCzFBbdCq6y35/cE87+MrX2e48zFGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVdIQl/X1l63+LEWvbphcnexv9hKJHqDm3CFNs9LXyHULxXIC
	8En7QEqfMhONcRhFf8imQ3yQrF3ww1yN6q9TbSZ6kVfjNJxhVeUH
X-Google-Smtp-Source: AGHT+IH7hReguc+nH4lTt0jjKw5fmY4WB2guwukGV6szfSaPGtYeUcThT/DU2IKUCSeJ3RODNpc+Zw==
X-Received: by 2002:a05:600c:4fd6:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-42bbb204f9dmr68776885e9.2.1725454946828;
        Wed, 04 Sep 2024 06:02:26 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df9705sm202738055e9.27.2024.09.04.06.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:02:25 -0700 (PDT)
Date: Wed, 4 Sep 2024 16:02:23 +0300
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
Message-ID: <20240904130223.py2yxmwo5kp6yvnu@skbuf>
References: <cover.1725441317.git.0x1207@gmail.com>
 <cover.1725441317.git.0x1207@gmail.com>
 <1e452525e496b28c0b1ea43afbdc3533c92930c6.1725441317.git.0x1207@gmail.com>
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
 <1e452525e496b28c0b1ea43afbdc3533c92930c6.1725441317.git.0x1207@gmail.com>

On Wed, Sep 04, 2024 at 05:21:18PM +0800, Furong Xu wrote:
> +static void stmmac_fpe_verify_timer_arm(struct stmmac_fpe_cfg *fpe_cfg)
> +{
> +	struct ethtool_mm_state *state = &fpe_cfg->state;
> +
> +	if (state->pmac_enabled && state->tx_enabled &&
> +	    state->verify_enabled &&
> +	    state->verify_status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
> +	    state->verify_status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
> +		/* give caller a chance to release the spinlock */
> +		mod_timer(&fpe_cfg->verify_timer, jiffies + 1);
> +	}
> +}

Why do you need to give the caller a chance to release the spinlock?
Isn't the timer code blocked anyway, as stmmac_fpe_verify_timer_arm()
runs under irqsoff?

