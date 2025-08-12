Return-Path: <netdev+bounces-213070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D826B231CE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7198316BFD3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D12FE565;
	Tue, 12 Aug 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="AwViNJ7S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF02FDC24
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021829; cv=none; b=Nxndua+MRpf7T6HjdACkhXLY93Veei41902QARkP/fChjvqTpAV+lmV7snnv+EYi3xUII5t+F7lnLmkkqFohU/taX77+npswk8rY5Fc0S1wwgMIHoGcn2mqSRfoLLJbRY+5JE2+YI+W/OG2LtOXJ1+2nlRGmgYWFvNHosFnd34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021829; c=relaxed/simple;
	bh=KHvsApnQ6X6pb/fu2BnxeH9/Ddmef+l51fbXPf4IWNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcct/EvxtPyWj4I/RUfLJasaDllgLB7ew2CYXhm35RD6iIEQ///YDwGQAASUui1fDc6J8gvYrafyIgK47DjNwmnkvcW3jqLtl8FHcCkwMpL9VNLrnNlo/8CX62G0IyiFp1HQ3AmxpWtOFSQWwzFLXT8Z2Ft1L5GqUHq3UN/LwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=AwViNJ7S; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-321c5eb1f4bso644177a91.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755021826; x=1755626626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JxTxUeodlegAo1pRtZuoSn3av1NRniV1h5H1/B/LUc=;
        b=AwViNJ7Seg05MshkeZisRPNLQQ9SysJGoUOEj8bcKTag7ko1pmlrENZii/tvUFWt8p
         3zm9NJHZ5sGH6aYPAGE2y2zpwFISgeZYwN+ZodZl8rFBihAf7n8wuy4oIWGNZI8g0qGl
         Q0m0vnnNbYxw4AOstDGmMyB+XFF7dsm9UyaAy9tv644ic2UYAqyAziLRlgX5bmJNzhD/
         gvj2if0gLg2eQNozIu/wazyLyUzUnI7TRT+w5JuJs0qZIa+UqNE0CiAPnKrHOfDJwAU9
         AjGljQtfb1CTnLZtho77Dk0DphjVS4Is79CGRYPFURSeb6Do1dFVhnzDMtcycEe5XhWH
         N/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021826; x=1755626626;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JxTxUeodlegAo1pRtZuoSn3av1NRniV1h5H1/B/LUc=;
        b=h3K5YME6kjbPgjwBD6WMsjG1UHS7U1NWMN0NSupzsehqL+qIhLMwVtrm6uc2lHMDey
         OgIkCwOWfHc4t6JdUdvKH26JQKiwNGvK0VFxgKuUv1neLC2GiYIkWp6ClPDqYIlqE8Rf
         KIHjhUk0viIDVTlOKRx5rs8jZQXl5sz/1mnpqRsuszFWq30noTNfAOBIpUE71VqSyCxo
         DSgaWw4nno5ZIh/Rn53jXMUB145VO0qhiWXT9Llx8FO8GX9qYAOvHfxkuwfYyX2H4rAm
         4bCZXjj4ILO23RaKVPZJbnYF8yXt+UB0J+tCrzTHwdWsJyZD79+y0e+nP30OPXPuJIcL
         kXng==
X-Forwarded-Encrypted: i=1; AJvYcCW4kKx6fpbBiXI3r+Et1MBPmjnBOOXiCMOax7NTf8i//tzOM1r+R7x/yL5FX26hR9w8CE/bDS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSgip9ngvkamB+aDVnve5kTyQX7t2YFWmboh9DBXFatFk8Bxx
	/A8D7C24NWAgn4LUWzQulPHajlpSMlm3EKAJyhirB/d273UXr39PXd/sO7CL+fGXg54=
X-Gm-Gg: ASbGncvVa/dofXW2FuqGD7ZbfJCPd4/ZdBjAddkBAU9cE/1Cc44PhG4MLKu7npdgWP/
	HX1x3wPJ1hIZgZiA7M6cd07ttEq1AUR4VR0MD/y23K12L7gPHpg6cBcOhydrR9FHwloBPsD8NxJ
	Wtfr60pC2Gbrt+Ql5aVTwvXzKxGwjjtFsjmSoqH+TEFYoY0ZcZSgUkLsuW5iv64nPh4OtN5gHC0
	Xq/Djt73sE8gacdYiVQdH4XJa8IkamBn2PwvPhkH37J2wNsGPIB+UUP9bppAyppJViOvsABW6RD
	9od5wsC1IbZyOJCP2j403/h4j5vDh8MVCx70EbCeHCrzEyez/5cUOt08eUNeVdb3h7bWQ0s3fQx
	+eIrJpuoBr8ZhRcYtbHq9EAgzfnLeZ9vO+Ceh/uJFUgx/y1RVdpzDdkWom+rTq6QRMCXFwNXboo
	bx5eBRDR4=
X-Google-Smtp-Source: AGHT+IENKKZNInGyonfPBc0V1DPpC6RnOE3FELqkQE6MFhJZF88D3Q4wqIFpScOEiZUoRbCrym6NcA==
X-Received: by 2002:a17:90b:3842:b0:31a:ab75:6e45 with SMTP id 98e67ed59e1d1-321cf9a8f66mr711558a91.28.1755021826084;
        Tue, 12 Aug 2025 11:03:46 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161282b5esm18164043a91.27.2025.08.12.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:03:45 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:03:43 -0700
From: Joe Damato <joe@dama.to>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: Shyam-sundar.S-k@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] amd-xgbe: Configure and retrieve 'tx-usecs'
 for Tx coalescing
Message-ID: <aJuB_4cQAyZfiEc0@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Vishal Badole <Vishal.Badole@amd.com>, Shyam-sundar.S-k@amd.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250812045035.3376179-1-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812045035.3376179-1-Vishal.Badole@amd.com>

On Tue, Aug 12, 2025 at 10:20:35AM +0530, Vishal Badole wrote:
> Ethtool has advanced with additional configurable options, but the
> current driver does not support tx-usecs configuration.
> 
> Add support to configure and retrieve 'tx-usecs' using ethtool, which
> specifies the wait time before servicing an interrupt for Tx coalescing.
> 
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> 
> ---
> v1 -> v2:
>     * Replace netdev_err() with extack interface for user error reporting.

In the future, it's a good idea to link to the previous revisions on
https://lore.kernel.org/netdev/ so that other reviewers can more easily look
back at the previous thread.

> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 19 +++++++++++++++++--
>  drivers/net/ethernet/amd/xgbe/xgbe.h         |  1 +
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> index 12395428ffe1..19cb1e2b7d92 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c

[...]

> +	/* Check if both tx_usecs and tx_frames are set to 0 simultaneously */
> +	if (!tx_usecs && !tx_frames) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "tx_usecs and tx_frames must not be 0 together");
> +		return -EINVAL;
> +	}
> +
>  	/* Check the bounds of values for Tx */
> +	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "tx-usecs is limited to %d usec",
> +				       XGMAC_MAX_COAL_TX_TICK);
> +		return -EINVAL;
> +	}
>  	if (tx_frames > pdata->tx_desc_count) {
>  		netdev_err(netdev, "tx-frames is limited to %d frames\n",
>  			   pdata->tx_desc_count);

Looks like there might be a future cleanup patch to use the extack interface
for user error reporting in the pre-existing code.

Reviewed-by: Joe Damato <joe@dama.to>

