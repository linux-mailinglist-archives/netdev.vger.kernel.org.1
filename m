Return-Path: <netdev+bounces-67961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4796D8457D7
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB55B2B503
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A0B53368;
	Thu,  1 Feb 2024 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZBOwbyC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F553365
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790434; cv=none; b=mWwkQeMXppUgOWArsQgJ5550et/SJI2RufzqebGekZ1nZFPR+OMYBSdZoU1XcF57knLa0jJ0YGKwIAqDMe9ieXWdhAAREOATAxKclgUpC5SngzI3RMbQzMvzmWlI2Zm/1Vt50gzUE4tPoh7fiyRopBngrBK020mGv91VERIRXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790434; c=relaxed/simple;
	bh=bqMA8kpz+ZEy0Nhr/thcrdvZ8GQ3Mj53b4sx5dLp2Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYbmKX36hNr5ltbn0vMxAuW+oxjTbLa+YBVGCNBCEnoqsouFlJTaH0fB/Nd4d4JgglEGvBXspNdeex9HiuNSTaV1/wM/TPZ2dnM8muoBsHHF2IemOsY/q60YwW92QY/NQp9/HO9fJ41HDUNoGG4dJ/4A27gi+tfIWrWJzulX2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZBOwbyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635B5C433C7;
	Thu,  1 Feb 2024 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706790433;
	bh=bqMA8kpz+ZEy0Nhr/thcrdvZ8GQ3Mj53b4sx5dLp2Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZBOwbyCFSQAz6Yd61eutqrrJd5/vrPxNV4qSd+hK9v3QdcmMYxySgVQS66RKTRa0
	 Cd4qYmk9RwBvCOc/Jig3NagPx4jVtb+kgOSuQPm3exRn/SUsZnp5DxV+cUHid7Bn+d
	 fHnO7OBIrZzurRWPhy41RZDJ0PQIQuQIowvEMtS6/hds/UsKuIYCFeTO26iRVIQfMD
	 wOR32G1evyKqqeOezvr6zRy4VPR1CHQYDkwAHvzxM3sfSFOCCN8ltj+9Ajy09KQGL0
	 D0dI16C7RJEXddx4gUT33ORDz0mgbAhgQ4DQY7stJkRnLkCdxVZPg4ngjONKJZPlQ6
	 /ZmHMMV2pnjdQ==
Date: Thu, 1 Feb 2024 13:27:05 +0100
From: Simon Horman <horms@kernel.org>
To: darinzon@amazon.com
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Koler, Nati" <nkoler@amazon.com>
Subject: Re: [PATCH v2 net-next 07/11] net: ena: Add more information on TX
 timeouts
Message-ID: <20240201122705.GA530335@kernel.org>
References: <20240130095353.2881-1-darinzon@amazon.com>
 <20240130095353.2881-8-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130095353.2881-8-darinzon@amazon.com>

On Tue, Jan 30, 2024 at 09:53:49AM +0000, darinzon@amazon.com wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> The function responsible for polling TX completions might not receive
> the CPU resources it needs due to higher priority tasks running on the
> requested core.
> 
> The driver might not be able to recognize such cases, but it can use its
> state to suspect that they happened. If both conditions are met:
> 
> - napi hasn't been executed more than the TX completion timeout value
> - napi is scheduled (meaning that we've received an interrupt)
> 
> Then it's more likely that the napi handler isn't scheduled because of
> an overloaded CPU.
> It was decided that for this case, the driver would wait twice as long
> as the regular timeout before scheduling a reset.
> The driver uses ENA_REGS_RESET_SUSPECTED_POLL_STARVATION reset reason to
> indicate this case to the device.
> 
> This patch also adds more information to the ena_tx_timeout() callback.
> This function is called by the kernel when it detects that a specific TX
> queue has been closed for too long.
> 
> Signed-off-by: Shay Agroskin <shayagr@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c  | 77 +++++++++++++++----
>  .../net/ethernet/amazon/ena/ena_regs_defs.h   |  1 +
>  2 files changed, 64 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 18acb76..ae9291b 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -47,19 +47,44 @@ static int ena_restore_device(struct ena_adapter *adapter);
>  
>  static void ena_tx_timeout(struct net_device *dev, unsigned int txqueue)
>  {
> +	enum ena_regs_reset_reason_types reset_reason = ENA_REGS_RESET_OS_NETDEV_WD;
>  	struct ena_adapter *adapter = netdev_priv(dev);
> +	unsigned int time_since_last_napi, threshold;
> +	struct ena_ring *tx_ring;
> +	int napi_scheduled;
> +
> +	if (txqueue >= adapter->num_io_queues) {
> +		netdev_err(dev, "TX timeout on invalid queue %u\n", txqueue);
> +		goto schedule_reset;
> +	}
> +
> +	threshold = jiffies_to_usecs(dev->watchdog_timeo);
> +	tx_ring = &adapter->tx_ring[txqueue];
> +
> +	time_since_last_napi = jiffies_to_usecs(jiffies - tx_ring->tx_stats.last_napi_jiffies);
> +	napi_scheduled = !!(tx_ring->napi->state & NAPIF_STATE_SCHED);
>  
> +	netdev_err(dev,
> +		   "TX q %d is paused for too long (threshold %u). Time since last napi %u usec. napi scheduled: %d\n",
> +		   txqueue,
> +		   threshold,
> +		   time_since_last_napi,
> +		   napi_scheduled);
> +
> +	if (threshold < time_since_last_napi && napi_scheduled) {
> +		netdev_err(dev,
> +			   "napi handler hasn't been called for a long time but is scheduled\n");
> +			   reset_reason = ENA_REGS_RESET_SUSPECTED_POLL_STARVATION;

Hi David,

a nit from my side: the line above is indented one tab-stop too many.
No need to respin just for this AFAIC.

> +	}
> +schedule_reset:
>  	/* Change the state of the device to trigger reset
>  	 * Check that we are not in the middle or a trigger already
>  	 */
> -
>  	if (test_and_set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags))
>  		return;
>  
> -	ena_reset_device(adapter, ENA_REGS_RESET_OS_NETDEV_WD);
> +	ena_reset_device(adapter, reset_reason);
>  	ena_increase_stat(&adapter->dev_stats.tx_timeout, 1, &adapter->syncp);
> -
> -	netif_err(adapter, tx_err, dev, "Transmit time out\n");
>  }
>  

...

