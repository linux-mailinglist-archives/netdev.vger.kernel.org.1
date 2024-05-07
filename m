Return-Path: <netdev+bounces-94137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC3F8BE50A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C3C1F21948
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21E415F301;
	Tue,  7 May 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yyEoaDx9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3635E15F304;
	Tue,  7 May 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090487; cv=none; b=YrdIoxpDZ7bYigWDIdNro+lXTpF1NR6en0eXvipkT8bRWVyukivSmcN0oj1ngc8t8yS5C7Ov329aFwfvCsRRUNtVGliUXQsxWfeHNrAa8t3moymp9mwyVFSqSvc5KHSnkLOVsrvcYSNYJtMo+6ltFCGAeSlXQT8rSP16svJ3U7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090487; c=relaxed/simple;
	bh=UB/6PiROn3Ss0PYSbD6N+s8cEj87DBXnAILxKvy/+yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6wSIZxDI6cXcM9hlc1/QIfie27UHKtv3sqpwgfuU2HEbSrijwmxVB87CT4CWoSEU1Rvv1KFvw71jLXjmIIZMMXVgO23wubCFTKc6IXcQnQ1NthS0Q0MVaEMO3gJQsQgHgPCMMVSgN5MyigWGoy+n8fUYrReX3X41pj0SICv2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yyEoaDx9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Hv/fCJ8384OqXRVFLKYelrn0yH7DaMvzM8OyS3Gfsbc=; b=yyEoaDx9qi6UhgRut9iHivZCIV
	U622s0K+/TahVFphjeG/XUEXEFHiIzf7dYWWdWKzODKosAy7P75ihQrGaveehy41dxYEbKyR1tHy+
	+1ZL8LWsm+V7hPjrXbB4AKR+FSzl2Ta/lX/TqF5qCskgVVkS3mXmQWG3oYVD4xL/zN7I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4LNW-00ErZd-KY; Tue, 07 May 2024 16:01:10 +0200
Date: Tue, 7 May 2024 16:01:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next] net: fec: Convert fec driver to use lock guards
Message-ID: <e1fa1aa5-4a40-43c5-a6ab-780667254fe9@lunn.ch>
References: <20240507090520.284821-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507090520.284821-1-wei.fang@nxp.com>

On Tue, May 07, 2024 at 05:05:20PM +0800, Wei Fang wrote:
> Use guard() and scoped_guard() defined in linux/cleanup.h to automate
> lock lifetime control in fec driver.

You are probably the first to use these in netdev. Or one of the very
early adopters. As such, you should explain in a bit more detail why
these changes are safe. 

> -	spin_lock_irqsave(&fep->tmreg_lock, flags);
> -	ns = timecounter_cyc2time(&fep->tc, ts);
> -	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> +	scoped_guard(spinlock_irqsave, &fep->tmreg_lock) {
> +		ns = timecounter_cyc2time(&fep->tc, ts);
> +	}

This looks fine.

> -			mutex_lock(&fep->ptp_clk_mutex);
> -			ret = clk_prepare_enable(fep->clk_ptp);
> -			if (ret) {
> -				mutex_unlock(&fep->ptp_clk_mutex);
> -				goto failed_clk_ptp;
> -			} else {
> -				fep->ptp_clk_on = true;
> +			scoped_guard(mutex, &fep->ptp_clk_mutex) {
> +				ret = clk_prepare_enable(fep->clk_ptp);
> +				if (ret)
> +					goto failed_clk_ptp;
> +				else
> +					fep->ptp_clk_on = true;
>  			}

As Eric pointed out, it is not obvious what the semantics are
here. You are leaving the scope, so i hope it does not matter it is a
goto you are using to leave the scope. But a quick search did not find
anything to confirm this. So i would like to see some justification in
the commit message this is safe.

> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -99,18 +99,17 @@
>   */
>  static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
>  {
> -	unsigned long flags;
>  	u32 val, tempval;
>  	struct timespec64 ts;
>  	u64 ns;
>  
> -	if (fep->pps_enable == enable)
> -		return 0;
> -
>  	fep->pps_channel = DEFAULT_PPS_CHANNEL;
>  	fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
>  
> -	spin_lock_irqsave(&fep->tmreg_lock, flags);
> +	guard(spinlock_irqsave)(&fep->tmreg_lock);
> +
> +	if (fep->pps_enable == enable)
> +		return 0;

This is not obviously correct. Why has this condition moved?

I also personally don't like guard(). scoped_guard() {} is much easier
to understand.

In order to get my Reviewed-by: you need to drop all the plain guard()
calls. I'm also not sure as a community we want to see changes like
this.

	Andrew

