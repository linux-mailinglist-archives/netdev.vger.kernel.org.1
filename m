Return-Path: <netdev+bounces-229546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AD6BDDE74
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FF13C5B9E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0957031A543;
	Wed, 15 Oct 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjwUJy2v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897E2010EE
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522629; cv=none; b=U7CrggcWis94VuLxL0XIxvLul63fg4l52k1e+q0ARQ5I7SEqAJWvBz1jJ6kZRjqtTkc0ff8ROFAPw0qd/edKa7glU+OD6OPXbSmFeKmF4STZ3y9WWrfUAtR0jw5e9Ljpekq39hNbcfuCJa50wf5kIqSgEipPWYqev3awDKWOSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522629; c=relaxed/simple;
	bh=AOexYLNyunoqnZbJBr1FOIKM+Gw3dlR/VOzYqaZ29d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNMUQgc3TD2qhbN4l6NVVd4WGm4LeEjZFDIEDPzZy3uVk3pele5bZdC0cgsua7i5NcEEJLdj5n+FYie/MlEQ1OcQqf+dDXqLAAzWoqcX8lY50KUbftmbbtQoa48CtmNy1ZMOSy4bvfURRPZxRECru38HX2pn+ZHhVYpMlczrlOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjwUJy2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758DDC4CEF8;
	Wed, 15 Oct 2025 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760522628;
	bh=AOexYLNyunoqnZbJBr1FOIKM+Gw3dlR/VOzYqaZ29d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjwUJy2vpOKs9PjYDHB8THRL8BTrBBvnaVumBSwQy0fIXp4pKWZmAXS9RqQtigdQE
	 hHepklNzYn0Mwieso9HsQxwwwaI0777hG0iWb+agbi5tGqG089OIzlUqxpth3rAu+F
	 +py7YJN67VXlbdMgO5I83HMDPN8GwWTXiSQ2XGM+tgl+W6UPh/z8SSR46vXrLZ0GQs
	 pRQfosOcjOTRgGwq32hYo62FDw5YTeAA/5UK6CTZW5x+MadZWQvWnotVVduH+O2C8O
	 qEDKZ6yL8lo0eXgjaKoQ5G9kNtiVDx1wPT0r8AG9cUoro5GgFeR2k8X/3k4IPJyEeg
	 fpWqAI+D1juEQ==
Date: Wed, 15 Oct 2025 11:03:43 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Egor Pomozov <epomozov@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/7] tsnep: convert to ndo_hwtstatmp API
Message-ID: <aO9xf0gW9F0qsaCz@horms.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-7-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014224216.8163-7-vadim.fedorenko@linux.dev>

On Tue, Oct 14, 2025 at 10:42:15PM +0000, Vadim Fedorenko wrote:
> Convert to .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
> After conversions the rest of tsnep_netdev_ioctl() becomes pure
> phy_do_ioctl_running(), so remove tsnep_netdev_ioctl() and replace
> it with phy_do_ioctl_running() in .ndo_eth_ioctl.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

...

> diff --git a/drivers/net/ethernet/engleder/tsnep_ptp.c b/drivers/net/ethernet/engleder/tsnep_ptp.c
> index 54fbf0126815..ae1308eb813d 100644
> --- a/drivers/net/ethernet/engleder/tsnep_ptp.c
> +++ b/drivers/net/ethernet/engleder/tsnep_ptp.c
> @@ -19,57 +19,53 @@ void tsnep_get_system_time(struct tsnep_adapter *adapter, u64 *time)
>  	*time = (((u64)high) << 32) | ((u64)low);
>  }
>  
> -int tsnep_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
> +int tsnep_ptp_hwtstamp_get(struct net_device *netdev,
> +			   struct kernel_hwtstamp_config *config)
>  {
>  	struct tsnep_adapter *adapter = netdev_priv(netdev);
> -	struct hwtstamp_config config;
> -
> -	if (!ifr)
> -		return -EINVAL;
> -
> -	if (cmd == SIOCSHWTSTAMP) {
> -		if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
> -			return -EFAULT;
> -
> -		switch (config.tx_type) {
> -		case HWTSTAMP_TX_OFF:
> -		case HWTSTAMP_TX_ON:
> -			break;
> -		default:
> -			return -ERANGE;
> -		}
> -
> -		switch (config.rx_filter) {
> -		case HWTSTAMP_FILTER_NONE:
> -			break;
> -		case HWTSTAMP_FILTER_ALL:
> -		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> -		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> -		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> -		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> -		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> -		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> -		case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> -		case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> -		case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> -		case HWTSTAMP_FILTER_PTP_V2_EVENT:
> -		case HWTSTAMP_FILTER_PTP_V2_SYNC:
> -		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> -		case HWTSTAMP_FILTER_NTP_ALL:
> -			config.rx_filter = HWTSTAMP_FILTER_ALL;
> -			break;
> -		default:
> -			return -ERANGE;
> -		}

Hi Vadim,

I'm probably missing something obvious, but it's not clear to me why
removing the inner switch statements above is ok. Or, perhaps more to the
point, it seems inconsistent with other patches in this series.

OTOH, I do see why dropping the outer if conditions makes sense.

> -
> -		memcpy(&adapter->hwtstamp_config, &config,
> -		       sizeof(adapter->hwtstamp_config));
> +
> +	*config = adapter->hwtstamp_config;
> +	return 0;
> +}

...

