Return-Path: <netdev+bounces-217679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E3B3984B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7B55E88AB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5DB2E1C6B;
	Thu, 28 Aug 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="itR4/JIf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE12E0910;
	Thu, 28 Aug 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373330; cv=none; b=uH2NABUODJ67GcX4RtO8wttbjw3cKb3h+6PYle+iAJIj44uSurm9hN7F3j19q4KKBMNF65VJfybNPZN2RnXKlBgC2EI9Z1zbuGa9ZqHjhBtbndiZ8jxO22umPIiBpBQapVaOgZjayb9Fbjh+pf+014kkaA3ZeL20rOs83c3j/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373330; c=relaxed/simple;
	bh=y8YnwcnSxBOTmOyoA65L96B1RKvSEtcKZ0A6OCYbckQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2bQNJICioUFpB/QaTvlYy+A0LdOq0Udry2iR/9niFgaKBene3cZr8vwna2cyDN27f4k7hVRkDQZjeJduk8r6E5ba6UUcih7AXkXrUq7ouF9CalnVOWsb+ENX2nwh6vLUWvkFpeNlXLo9bY6wOcIbfJYbRSwMAsJpKDHs+l5PBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=itR4/JIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECBFC4CEEB;
	Thu, 28 Aug 2025 09:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756373329;
	bh=y8YnwcnSxBOTmOyoA65L96B1RKvSEtcKZ0A6OCYbckQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itR4/JIfDU7uqrAWwxeNh0s9mmdmkznvYT3uyvfBV2KPNdM5qTCqjObIv4dnUZHac
	 ZskNQxAdVWivgltri9cqI6IEyqXIpIkELFktXg78wPFx8NGA3kZvImaLzRvKzqvIKY
	 zSOkrreyzUtIt5zvnHkmae0jVUd8BvQbwn1JJaV4=
Date: Thu, 28 Aug 2025 11:28:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: ethernet: ti: Prevent divide-by-zero in
 cpts_calc_mult_shift()
Message-ID: <2025082830-bobbing-confusing-14fc@gregkh>
References: <20250828092224.46761-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828092224.46761-1-linmq006@gmail.com>

On Thu, Aug 28, 2025 at 05:22:23PM +0800, Miaoqian Lin wrote:
> cpts_calc_mult_shift() has a potential divide-by-zero in this line:
> 
>         do_div(maxsec, freq);
> 
> due to the fact that clk_get_rate() can return zero in certain error
> conditions.
> Add an explicit check to fix this.
> 
> Fixes: 88f0f0b0bebf ("net: ethernet: ti: cpts: calc mult and shift from refclk freq")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> This follows the same pattern as the fix in commit 7ca59947b5fc
> ("pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()").
> ---
>  drivers/net/ethernet/ti/cpts.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
> index 2ba4c8795d60..e4e3409e7648 100644
> --- a/drivers/net/ethernet/ti/cpts.c
> +++ b/drivers/net/ethernet/ti/cpts.c
> @@ -607,6 +607,8 @@ static void cpts_calc_mult_shift(struct cpts *cpts)
>  	u32 freq;
>  
>  	freq = clk_get_rate(cpts->refclk);
> +	if (!freq)
> +		return;
>  
>  	/* Calc the maximum number of seconds which we can run before
>  	 * wrapping around.
> -- 
> 2.39.5 (Apple Git-154)
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

