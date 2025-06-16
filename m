Return-Path: <netdev+bounces-198033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 088B7ADAE80
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4FA188D4D1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777A2D12F6;
	Mon, 16 Jun 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M0Du7zho"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FA2BF3C3;
	Mon, 16 Jun 2025 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073388; cv=none; b=MLvNtY8QNr7TRsSgQ/EdKqoxriSHeenYtHgGCulQeK748td5vdSF2Ew45rJnw+Jam2G3rYEeWHF99n26lkLpMGM+4pNLzNgP44ELDgz1c5sjPzYSbY9P5oIijFqkdoB+MbfxKvaX9V1zLQbZQXoWiDNA2mWfJK6GunjN4q4qhwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073388; c=relaxed/simple;
	bh=h5SoZrXl5S4reO0OVVLyDdksy93ZlfckgM0USHvz0lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t1xGU9FpZepT+wG4Sq8NUISOLyr8XQm0bWyLZG60dIPMThMa3xP1F6H4sVJXLZQ24HV87T1mD1biFC7v0Y66CW3CpnrebWxF9uVQu/OrsV8+gnqZNg1rP3n9jYNYmjhC+mkXEQNp9NxUqRdO9WXh10SnhafQJr8XDJkyqUdQ/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M0Du7zho; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1c1e7c9c-5143-43e9-a40b-42dfc3866a56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750073383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsJbK3+gK/ymCJy2HxIdPeNdYIGOi33WqyAoP9tLfS0=;
	b=M0Du7zhoFAzLrAnDS7PPcT3mu1knvhPth+C1+CwFm+JbPGwItueLXnwNRF98Psql6am8HI
	NFsZCQX0jbEaamy1hU5mvKcrXF1aY7mecFs3yuz3mPIvJ5jtvqtgUlzgR3lovRTuxsUO5y
	gxaSmAaoX8ZysPCIaSkzS402ohJWixI=
Date: Mon, 16 Jun 2025 12:29:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] amd-xgbe: Configure and retrieve 'tx-usecs' for
 Tx coalescing
To: Vishal Badole <Vishal.Badole@amd.com>, Shyam-sundar.S-k@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250616104232.973813-1-Vishal.Badole@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250616104232.973813-1-Vishal.Badole@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/06/2025 11:42, Vishal Badole wrote:
> Ethtool has advanced with additional configurable options, but the
> current driver does not support tx-usecs configuration.
> 
> Add support to configure and retrieve 'tx-usecs' using ethtool, which
> specifies the wait time before servicing an interrupt for Tx coalescing.
> 
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 19 +++++++++++++++++--
>   drivers/net/ethernet/amd/xgbe/xgbe.h         |  1 +
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> index 12395428ffe1..362f8623433a 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> @@ -450,6 +450,7 @@ static int xgbe_get_coalesce(struct net_device *netdev,
>   	ec->rx_coalesce_usecs = pdata->rx_usecs;
>   	ec->rx_max_coalesced_frames = pdata->rx_frames;
>   
> +	ec->tx_coalesce_usecs = pdata->tx_usecs;
>   	ec->tx_max_coalesced_frames = pdata->tx_frames;
>   
>   	return 0;
> @@ -463,7 +464,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
>   	struct xgbe_prv_data *pdata = netdev_priv(netdev);
>   	struct xgbe_hw_if *hw_if = &pdata->hw_if;
>   	unsigned int rx_frames, rx_riwt, rx_usecs;
> -	unsigned int tx_frames;
> +	unsigned int tx_frames, tx_usecs;
>   
>   	rx_riwt = hw_if->usec_to_riwt(pdata, ec->rx_coalesce_usecs);
>   	rx_usecs = ec->rx_coalesce_usecs;
> @@ -485,9 +486,22 @@ static int xgbe_set_coalesce(struct net_device *netdev,
>   		return -EINVAL;
>   	}
>   
> +	tx_usecs = ec->tx_coalesce_usecs;
>   	tx_frames = ec->tx_max_coalesced_frames;
>   
> +	/* Check if both tx_usecs and tx_frames are set to 0 simultaneously */
> +	if (!tx_usecs && !tx_frames) {
> +		netdev_err(netdev,
> +			   "tx_usecs and tx_frames must not be 0 together\n");
> +		return -EINVAL;
> +	}
> +
>   	/* Check the bounds of values for Tx */
> +	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
> +		netdev_err(netdev, "tx-usecs is limited to %d usec\n",
> +			   XGMAC_MAX_COAL_TX_TICK);
> +		return -EINVAL;
> +	}

ethtool uses netlink interface now and coalesce callbacks have extack
parameters to return error information back to user-space. It would be
great to switch to use it instead of adding more netdev_err messages.

[...]

