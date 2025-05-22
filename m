Return-Path: <netdev+bounces-192662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A33DAC0BBF
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9364D3AA68A
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41E528A73B;
	Thu, 22 May 2025 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhZJwKkQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9522FF2B;
	Thu, 22 May 2025 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917569; cv=none; b=C8+qrFV465iCsIxyEz0ULoP3udnuy2S3RUq5gJwb+5v+j5I2Mb4IHoI2Cvp3S9+XZf29xft4rQMp0pLsWc1jLQAF7r7NIH/yN8jTfXTeCXgKJq77368bivIYw0sghhS7HcGY0M/+XluDizCX8UWKT6Yez3/7+HozyADDAxuJnq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917569; c=relaxed/simple;
	bh=hCwBayrLIRa6jPbS6o/Fl8fVjZmRhOYRLYrgdQEN8E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDZM5C/Z7eYllC7npjfOzGfsPIRZyyHbQePPos1l4n66Ph6+AXo2lSNVXZajt6u/O297tlxF74aIQrYmuvyzuBTEJQahLz+BExk/ANtzyevca91WwBcOqbXNG2oH5LDhztbwFWOmtfZrTqCt2Uimjbl7mQ7rCaVgBaaccm7biNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhZJwKkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80661C4CEE4;
	Thu, 22 May 2025 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747917569;
	bh=hCwBayrLIRa6jPbS6o/Fl8fVjZmRhOYRLYrgdQEN8E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhZJwKkQ5Bxo71Aad9IeDuhyQFBygwvM+zfEhYz9bLWlEpaRqhIsafGSZKo8WFnM/
	 tqWQDkF44DTFajvlKSeUwEAYXm6oQjjsdc4mSasbfCsZdl8LQ1Or/PWrukLSgRCSl7
	 d0C9zUZiAuVQ2bjHU4yuqW1f+5Xx+PiAndmMIGOezqNoiDdbHMhag1X/W7xeG5Ty1E
	 27pKf/Frd8E5fDQhxS8OYK2XpIKEalVESsGWkNZWPLYkJWH2R5fc33FyETd3/UJCuN
	 cAiWvxioAZkl9B8rmaYXa8zUPwL+zU6yFWuZ6HMYs56NwWx6yY2+E4SgCWufIFwb4O
	 KcwkhWZxAdfWA==
Date: Thu, 22 May 2025 14:39:25 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, kory.maincent@bootlin.com, shannon.nelson@amd.com, 
	rrameshbabu@nvidia.com, viro@zeniv.linux.org.uk, quentin.schulz@bootlin.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: mscc: Fix memory leak when using one
 step timestamping
Message-ID: <rcdapvt2pt6zntthvvwzualqrhoeaqc4oq2jsyqxjxavvfwabb@k3p5fweby7mb>
References: <20250522115722.2827199-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522115722.2827199-1-horatiu.vultur@microchip.com>

On Thu, May 22, 2025 at 01:57:22PM +0200, Horatiu Vultur wrote:
> Fix memory leak when running one-step timestamping. When running
> one-step sync timestamping, the HW is configured to insert the TX time
> into the frame, so there is no reason to keep the skb anymore. As in
> this case the HW will never generate an interrupt to say that the frame
> was timestamped, then the frame will never released.
> Fix this by freeing the frame in case of one-step timestamping.
> 
> Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> ---
> v1->v2: Free the skb also when ptp is not configured
> ---
>  drivers/net/phy/mscc/mscc_ptp.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
> index ed8fb14a7f215..6f96f2679f0bf 100644
> --- a/drivers/net/phy/mscc/mscc_ptp.c
> +++ b/drivers/net/phy/mscc/mscc_ptp.c
> @@ -1166,18 +1166,24 @@ static void vsc85xx_txtstamp(struct mii_timestamper *mii_ts,
>  		container_of(mii_ts, struct vsc8531_private, mii_ts);
>  
>  	if (!vsc8531->ptp->configured)
> -		return;
> +		goto out;
>  
> -	if (vsc8531->ptp->tx_type == HWTSTAMP_TX_OFF) {
> -		kfree_skb(skb);
> -		return;
> -	}
> +	if (vsc8531->ptp->tx_type == HWTSTAMP_TX_OFF)
> +		goto out;
> +
> +	if (vsc8531->ptp->tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
> +		if (ptp_msg_is_sync(skb, type))
> +			goto out;

nit: you can combine the two checks and avoid having nested if
statements.

>  	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>  
>  	mutex_lock(&vsc8531->ts_lock);
>  	__skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
>  	mutex_unlock(&vsc8531->ts_lock);
> +	return;
> +
> +out:
> +	kfree_skb(skb);
>  }
>  
>  static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
> -- 
> 2.34.1
> 
> 

