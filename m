Return-Path: <netdev+bounces-192377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746DDABF9B0
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80316188725B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA47221551;
	Wed, 21 May 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfn1GPaH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F1221297;
	Wed, 21 May 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841683; cv=none; b=G/J/ETuPJWSOuH7oACay3JerWb3sAi/9td/fd9SaYgBd3wFG49Zk2nLBiIqlCD+d/dNcDEa0NhS0UA3GfdFJu2MaHmhx2y3G+diBW0KocC5wfLNztsabvqQamKKkSefAWTNyivyZ8MKstrDSfXkkL5jozjYuqaXASg6YHOqO048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841683; c=relaxed/simple;
	bh=/amBSm5I9J5IaO88xw0RyZWxwOgvbaTAgzX9oG5SXMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plbg6JPUGtUttMdpDcEuP/6Tuhe4FurnUUCZDH1ECEzhAuiraSg7g6vc1O+bi0ilY7k/wbQ701kbk47C8ndmjhk0muT5DFTax0kmdGg1TF/+K2ic8VHl+m0dYIUHM0XThrh6N/G0mPLia9FHL0m/hGnML8EggUYmcZ5/uREkHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfn1GPaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A056BC4CEE4;
	Wed, 21 May 2025 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841683;
	bh=/amBSm5I9J5IaO88xw0RyZWxwOgvbaTAgzX9oG5SXMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yfn1GPaHIuvKHnHI+miBXmeiq85J68kYtDwLB6WZxpGTex0+8pkUdFPI4ffS0mmHk
	 7ySSF6k6dW8gOXvH/oTo/vSEsZUbnK0r90TMMkn9BQINQAjdxOszaEbJeMtsDxE2nW
	 l8Cr8sSHB03vzB7XVPXYNqbWoW7/nAkRaTXv/HS0lmiJcDVUF0L6kFzxrIo2uZb5Bf
	 T0TzCMo37mfxzeg0O8D0NV9Y/DZtpOrKktgN0PBmbnZxMxTf88sVsD796RuEeoCAkO
	 yCpzSD3C95szCTQGTnxeARQGH5IUHTiZhTX8TXUpjnWnLcQaKirOT+yhgrTX14dxji
	 DhWdLLEE9M3iw==
Date: Wed, 21 May 2025 17:34:39 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, kory.maincent@bootlin.com, shannon.nelson@amd.com, 
	viro@zeniv.linux.org.uk, atenart@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: mscc: Fix memory leak when using one step
 timestamping
Message-ID: <vmtli7u7fnsj56xhih7eqtzt6w3v4yp7dviyssqyyybvsioznj@lzwdr5dpo5wg>
References: <20250521131114.2719084-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521131114.2719084-1-horatiu.vultur@microchip.com>

On Wed, May 21, 2025 at 03:11:14PM +0200, Horatiu Vultur wrote:
> Fix memory leak when running one-step timestamping. When running
> one-step sync timestamping, the HW is configured to insert the TX time
> into the frame, so there is no reason to keep the skb anymore. As in
> this case the HW will never generate an interrupt to say that the frame
> was timestamped, then the frame will never released.
> Fix this by freeing the frame in case of one-step timestamping.
> 
> Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/phy/mscc/mscc_ptp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
> index ed8fb14a7f215..db8ca1dfd5322 100644
> --- a/drivers/net/phy/mscc/mscc_ptp.c
> +++ b/drivers/net/phy/mscc/mscc_ptp.c
> @@ -1173,6 +1173,13 @@ static void vsc85xx_txtstamp(struct mii_timestamper *mii_ts,
>  		return;
>  	}
>  
> +	if (vsc8531->ptp->tx_type == HWTSTAMP_TX_ONESTEP_SYNC) {
> +		if (ptp_msg_is_sync(skb, type)) {
> +			kfree_skb(skb);
> +			return;
> +		}
> +	}

I don't remember everything about TS but I think the above is fine. Also
while looking at this I saw this function is doing the following too:

  if (!vsc8531->ptp->configured)
	return;

I guess we should free the skb for all paths not putting it in the tx
queue. As there would be 3 paths freeing the skb + returning, you might
as well use a label for easier maintenance.

Thanks,
Antoine

