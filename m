Return-Path: <netdev+bounces-238186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BEEC5572F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 03:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BD3B4E19D4
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 02:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1225423ED5B;
	Thu, 13 Nov 2025 02:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcS8AJcG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B320FA81
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001310; cv=none; b=hzaAoZ55aQU0OWvGj3noebyd4KRN5MtEDgXPNoi2q9ZbCqDzIqe05DhBnMRdSa8ScMHuT1zqN46aAv02VhbsozZS4UsLYwQQGPkOndtqpFLI+WBN8XmldgRTWrKWR4OhFkvdNSwqOgwRTWk8BafVXr5yZYcAxWI9EyT7fnD7PzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001310; c=relaxed/simple;
	bh=YO/Ftu/Xg3pmed58glUcL1UBDyJ5Rpx9lMXkwzM4PLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGpyy6V1ApoRiYkJ7fWrWoMRvjN5LPE4QaDSac4x0zMT0BEkGykC4U0mjuAmQOxZjH5zziCROYPzndRXJ7VTTFhamIvpSrQgKlAnmQ9Kp7Y8vueBnmY8HNZG0krFkqyfBV+lX0ha8/Sa7TItNA46T9Sj2vsYp0sJtLy8xsfqsv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcS8AJcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1127C19424;
	Thu, 13 Nov 2025 02:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763001309;
	bh=YO/Ftu/Xg3pmed58glUcL1UBDyJ5Rpx9lMXkwzM4PLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JcS8AJcG+fbKYyr5ATWCpMcqB/l72/Mp+MvknlzQ7F5QwBO04dO6nRF5u207ilctS
	 BO2rGLMKd6Ed2yQE3gKZNS/IMYlEyYv71S73DOPzgVRgyzTMDqdz+uCD6smHdZT4DS
	 /266MmDNrMv6iSBbTD/0QU1biVcThgq3Vx/p+LG46QsDzw2lmpi3UILuMGn3EjhpUj
	 yX96GXPrWJuiIeAPktbTEinYOndS7oeUR5MuZpc9bb6obtE7u/fyspAvVTU2eRdF1y
	 JYQZIFIsBj8xk7nA+7um/aKLISLW7H78/yxd1LbA0/pbqB7USApyTwQjKoeVgX9VwY
	 a1BpJB5MQvcUw==
Date: Wed, 12 Nov 2025 18:35:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Manish Chopra <manishc@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>, Jacob
 Keller <jacob.e.keller@intel.com>, Kory Maincent
 <kory.maincent@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] qede: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251112183508.3c20e21d@kernel.org>
In-Reply-To: <20251111151900.1826871-3-vadim.fedorenko@linux.dev>
References: <20251111151900.1826871-1-vadim.fedorenko@linux.dev>
	<20251111151900.1826871-3-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 15:19:00 +0000 Vadim Fedorenko wrote:
> The driver implemented SIOCSHWTSTAMP ioctl cmd only, but it stores
> configuration in private structure, so it can be reported back to users.
> Implement both ndo_hwtstamp_set and ndo_hwtstamp_set callbacks.
> ndo_hwtstamp_set implements a check of unsupported 1-step timestamping
> and qede_ptp_cfg_filters() becomes void as it cannot fail anymore.
> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> -static int qede_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> -{
> -	struct qede_dev *edev = netdev_priv(dev);
> -
> -	if (!netif_running(dev))
> -		return -EAGAIN;

Isn't this running check gone after conversion?

> -	switch (cmd) {
> -	case SIOCSHWTSTAMP:
> -		return qede_ptp_hw_ts(edev, ifr);
> -	default:
> -		DP_VERBOSE(edev, QED_MSG_DEBUG,
> -			   "default IOCTL cmd 0x%x\n", cmd);
> -		return -EOPNOTSUPP;
> -	}
> -
> -	return 0;
> -}
> -

> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_ONESTEP_SYNC:
> +	case HWTSTAMP_TX_ONESTEP_P2P:
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "One-step timestamping is not supported");
> +		return -ERANGE;
> +	}

Eh, I guess the warning I was imagining isn't actually enabled at W=1 :(
And config->.x_type does not use enums..

Could you switch this to the slightly more resilient:

	switch (config->tx_type) {
	case HWTSTAMP_TX_ON:
	case HWTSTAMP_TX_OFF:
		break;
	default:
		NL_SET_ERR_MSG_MOD(extack,
				   "One-step timestamping is not supported");
		return -ERANGE;
	}

? Guess similar adjustment would also work for patch 1.
-- 
pw-bot: cr

