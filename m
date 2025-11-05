Return-Path: <netdev+bounces-235678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDDC33B0F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53421898F54
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F12B22127A;
	Wed,  5 Nov 2025 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZaj26Oc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B09E27470
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307022; cv=none; b=WqqaDPJT53TIm8rqVi+s0QYkwAR8UTB+Rw70xOEebcX41NVKKDIsMDJ2HaC3J5BkBs2wt0Sa3XsZosg56Bsy4HWT3ahgHvTM8qLTOz8PUmnIRgLhuMbqlwSyiFCGYzwfF1mMlylkF3XwJ18GSwodXPahp1ohNHoo3tQzcmSAwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307022; c=relaxed/simple;
	bh=qyKbep87U6tFaQtgtK+LxswkZ6ORWQIdJGoQUEsxra4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2YVTINzCsVBb6iz2hmNSWRM1VRmAPSrszAzzOaFJUR4rQ3cGnuNLVO13merOUAbmwoT9M4Tt9t3lMLt/4BOPJP3EtCFTvfIaruN+QC3120eCO1lAgWzOiyjCVzzykdHMxmqs7eu32ps8E6n3ulSAAGCmpmAmYCQ1W/0Sj0bWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZaj26Oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049E4C4CEF7;
	Wed,  5 Nov 2025 01:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762307021;
	bh=qyKbep87U6tFaQtgtK+LxswkZ6ORWQIdJGoQUEsxra4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pZaj26OcpSM2Wfs3vWfI0Ac007a31QJlAiOdbJwA3h9bSF8wo7WXk1BJ3vy6nhDmD
	 AIyVK9deZuZm5nsjuj/l4Pz+bEqaybpofAADE8IFSoP1++ZBKQ3MntorIFCsUz4vpc
	 nU8TVvGftXmRZ21mp54PgZ6nqoDU9Ftno6UiFwl19ro3dhSUv4j+bF8AquEtYxVGMq
	 SyuP+R8kK424aE5FVeWh6tJ9I2JetrqWFrlVfGLp5o+cH6OiSdS6ktbYcfo9lwe7iu
	 WEY3XC/HHdUaVPXW8525qmnpJ0Yt9uxrZOFJtXzqrTbBDV2GfS72UQxHiCxHak9pWz
	 IXoibLzD9NQcA==
Date: Tue, 4 Nov 2025 17:43:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Manish Chopra <manishc@marvell.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Kory Maincent
 <kory.maincent@bootlin.com>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/7] qede: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251104174340.5d2d8741@kernel.org>
In-Reply-To: <20251103150952.3538205-8-vadim.fedorenko@linux.dev>
References: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
	<20251103150952.3538205-8-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 15:09:52 +0000 Vadim Fedorenko wrote:
>  	ptp->hw_ts_ioctl_called = 1;
> -	ptp->tx_type = config.tx_type;
> -	ptp->rx_filter = config.rx_filter;
> +	ptp->tx_type = config->tx_type;
> +	ptp->rx_filter = config->rx_filter;
>  
>  	rc = qede_ptp_cfg_filters(edev);
> -	if (rc)
> +	if (rc) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "One-step timestamping is not supported");
>  		return rc;
> +	}
> +
> +	config->rx_filter = ptp->rx_filter;

Same story as the first patch.
I suppose these drives may predate the advanced tx config options.
Simple fix would be to move the tx_filter validation here instead.

I'll apply 2-6.

