Return-Path: <netdev+bounces-167330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64984A39CA1
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9185B3AA428
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233A266560;
	Tue, 18 Feb 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7pQPjRG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB320265CD8;
	Tue, 18 Feb 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883604; cv=none; b=cn4GNvt73rgu7YG4wtkl1DssV04mvgoGFEiXrB6UmFlFuIl5LOihXLSMKltRVSnOyZM6XYKw4y7DUs0epfyyNqY9G1shELjErQb8o2vuUT07nUDAsmaCpgGTz0Dtz8hwjFVrpseX4ti/mUeZ3mXywlsE+GtOSNSivUoFR5S+Nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883604; c=relaxed/simple;
	bh=wkaSrmI42WJ8eWLGud2n2+KIp1RZrA0hZp27Cs/S1os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfCcIYgMv1i3lpO6KMCigUZAMUy9GeNUJIMwbGYz9opW8BpD079xnTTAneSLXXVZ+caUEEWKvY/HU6uC9mR9RyQIdoi0xFbQRUpbuLRo3jfJFCzwSa1yFYQmPLoFGcs1UH+6QbvvADG8UNSDaF9RHmdBUq3hNtIsillPbn3xFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7pQPjRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DD6C4CEE2;
	Tue, 18 Feb 2025 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739883604;
	bh=wkaSrmI42WJ8eWLGud2n2+KIp1RZrA0hZp27Cs/S1os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7pQPjRGFqpUEqRUTP8WqTqJCGC/2YTh4O27TLV9vm126m4kCoOmAwS97lD/hjjfw
	 eCtd7SYs2FOAaiy98MHm/EiZNAdqpX8f3W6vFgr/+SkgeghmtrI73iWz3DsGG3S09u
	 C5agCd2n5J5fVOjYeqleodcKLIt19zk4686f4ISRXgpNG5AVC2JkzO6PriMJ3aBObU
	 zh3wFF5VVhuazFapG98U/CLt2pNZfAuBuwwHYjxmBEIOAFgMsEqW4ZJ1e+y0pAb2Oi
	 C7oEiICDHx0gjW8ej342Ub7FXaO9wciu2y5xaS+YIkbyt3uzKGG7UEzOCCmH4KRK0k
	 +qJ9HTixag9FQ==
Date: Tue, 18 Feb 2025 12:59:59 +0000
From: Simon Horman <horms@kernel.org>
To: Piotr Wejman <wejmanpm@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH iwl-next v3] net: e1000e: convert to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
Message-ID: <20250218125959.GS1615191@kernel.org>
References: <20250216155729.63862-1-wejmanpm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216155729.63862-1-wejmanpm@gmail.com>

On Sun, Feb 16, 2025 at 04:57:28PM +0100, Piotr Wejman wrote:
> Update the driver to use the new hardware timestamping API added in commit
> 66f7223039c0 ("net: add NDOs for configuring hardware timestamping").
> Use Netlink extack for error reporting in e1000e_config_hwtstamp.
> Align the indentation of net_device_ops.
> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Piotr Wejman <wejmanpm@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> @@ -3932,7 +3939,11 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
>  	spin_unlock_irqrestore(&adapter->systim_lock, flags);
>  
>  	/* restore the previous hwtstamp configuration settings */
> -	e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config);
> +	ret_val = e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config, &extack);

nit: If there is a v4 for some other reason, please consider line-wrapping
     the above to avoid lines that are more than 80 columns wide.

	ret_val = e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config,
					 &extack);

> +	if (ret_val) {
> +		if (extack._msg)
> +			e_err("%s\n", extack._msg);
> +	}
>  }
>  
>  /**
> @@ -6079,8 +6090,8 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
>  	return 0;
>  }
>  
> -static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
> -			   int cmd)
> +static int e1000_ioctl(struct net_device *netdev, struct ifreq *ifr,
> +		       int cmd)

nit: And conversely, if there is a v4 for some other reason,
     please consider merging the above two lines into one.

...

